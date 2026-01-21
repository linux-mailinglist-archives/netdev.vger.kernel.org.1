Return-Path: <netdev+bounces-251892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGH5I7HYcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:46:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4A57C3D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4797F46B1E9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E93EF0D1;
	Wed, 21 Jan 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF7x3fCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090F1FDA92
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002648; cv=none; b=XDEvXB/XpzTeFF91AtVuLsVor1MWN8+TwGY2WFVRgJUkpN+wXg9OIuTL6x2OFhwOytTwnw8pPZohWlyl3EKLUkNzFos1vDks8wa3WnOr65mfvPlds+HZhx7GWc5ytfZ9ZkjaAOIE3NGa+RPfaT6X6Ki/on6F8nEea5a7d3LdzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002648; c=relaxed/simple;
	bh=YYmIc4uVc+rh9QZdVFEYe6s6TIcDM9yY0LqvWB+gLeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NJeIS+l+FF8zVSa4CwiGzOhs1DfvT9UNHd+vGfSHhi72BlDZLpmLDwFC192R6pIPom4c0WQhUKsD1IuIMp1efvPj7lQIrswyFwgPbsYbtOhW6fRJsnTljT9m+6taEQbv3ehP/BjTKrzlLLGhKBJEiK6gP/OY9vYVbw2oWxEyOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nF7x3fCH; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8946448adbdso48016276d6.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769002646; x=1769607446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FdRTj+OfuAa2DYIBfNL37R44sjWVz55aHfOBUbRwT40=;
        b=nF7x3fCHGDVQROxXFYwgPgdmZDNPBrX2WG7RV8mAtPnVulNpkvAZC6ZUvgBOMji2VP
         KOQ+LGuWgAfvCz//JHm49SPcQsdieKASFHuQ0eHq6Z9lt6TOwcmCLwANZSRyjXM2xI0i
         NCItTH2ICC3O7w7JYptecS7A6P9FDPiPKY1yjakx9wHva03PqQhyvNaP3YZtQasXTKKc
         hP351mW0HSAnI+wkKEAH74QdASRtJe26kMQM0a6f2cYd80DTP2R5JyU1Dp8L20m2QcuS
         nPr4cP5hiqZopioBQdiHxY9BUNF+hVbh0O20Nf/71LHlY/gEUyaVqku0pBEuxDlhUE2q
         H/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002646; x=1769607446;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdRTj+OfuAa2DYIBfNL37R44sjWVz55aHfOBUbRwT40=;
        b=Zpm2/PWbWLBgCYyrWjvzg46MyPRw5yZugxUVuPdOuxoTvMh4TsycHyI/rVrxhAACvm
         6F5jlSh+4hL8YboXXlL0ds4+zHAgOOEI2Yl7mVjED7OBZgiuCmw+S0X7wY6y9GwrmlRV
         2xHg2cclA25TIXCZgrfNen4T7/fM4I3oexoOyUnJxXiWWEuwo7BTDj9UEfweZylviGF9
         ENSisFICdtf7lP6e0UbV4fQWz/+cYyQMI3vAcm5s87TtOTN8KoaxpV/ajYFOosCPRZwX
         mAoy9PEPRLmnNBE0vlNauOG8RrsoMgDWeO+tfhLGEVrW8XOHCcdFIRq/kcSTQ/LnvoW1
         YhIA==
X-Forwarded-Encrypted: i=1; AJvYcCWAu9GwslTAGiEvo8ql/M2sODg0dxsVopzsDgPXkzdFV529u1e4QV3CRfkNvkd5x5n3/qjoMus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwM5l7psYK01RQwwfY7mdKJuL5yYGsGrP+Ui198oSmlY/Xgwp
	IBeQyEP14KFF939k4xzAmF9AqofEuROujh1tvY7jl3FUgYfSwdwbUMle6Widel7d+G69CbktxOS
	xD0vMxaUVa2xX2w==
X-Received: from qvhh14.prod.google.com ([2002:a05:6214:dae:b0:88a:387b:cf96])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:76a:b0:894:62b2:12a0 with SMTP id 6a1803df08f44-89462b214b1mr82567916d6.22.1769002646072;
 Wed, 21 Jan 2026 05:37:26 -0800 (PST)
Date: Wed, 21 Jan 2026 13:37:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121133724.3400020-1-edumazet@google.com>
Subject: [PATCH net] net/sched: act_ife: avoid possible NULL deref
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com, 
	Yotam Gigi <yotam.gi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,resnulli.us,vger.kernel.org,google.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,5cf914f193dffde3bd3c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 55F4A57C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcf_ife_encode() must make sure ife_encode() does not return NULL.

syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:ife_tlv_meta_encode+0x41/0xa0 net/ife/ife.c:166
CPU: 3 UID: 0 PID: 8990 Comm: syz.0.696 Not tainted syzkaller #0 PREEMPT(full)
Call Trace:
 <TASK>
  ife_encode_meta_u32+0x153/0x180 net/sched/act_ife.c:101
  tcf_ife_encode net/sched/act_ife.c:841 [inline]
  tcf_ife_act+0x1022/0x1de0 net/sched/act_ife.c:877
  tc_act include/net/tc_wrapper.h:130 [inline]
  tcf_action_exec+0x1c0/0xa20 net/sched/act_api.c:1152
  tcf_exts_exec include/net/pkt_cls.h:349 [inline]
  mall_classify+0x1a0/0x2a0 net/sched/cls_matchall.c:42
  tc_classify include/net/tc_wrapper.h:197 [inline]
  __tcf_classify net/sched/cls_api.c:1764 [inline]
  tcf_classify+0x7f2/0x1380 net/sched/cls_api.c:1860
  multiq_classify net/sched/sch_multiq.c:39 [inline]
  multiq_enqueue+0xe0/0x510 net/sched/sch_multiq.c:66
  dev_qdisc_enqueue+0x45/0x250 net/core/dev.c:4147
  __dev_xmit_skb net/core/dev.c:4262 [inline]
  __dev_queue_xmit+0x2998/0x46c0 net/core/dev.c:4798

Fixes: 295a6e06d21e ("net/sched: act_ife: Change to use ife module")
Reported-by: syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6970d61d.050a0220.706b.0010.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yotam Gigi <yotam.gi@gmail.com>
---
 net/sched/act_ife.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 1dfdda6c2d4c51feb3f9db4e26e72c8e4a515687..8e8f6af731d51cd38cb469e4351a7c861fc6754b 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -821,6 +821,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	/* could be stupid policy setup or mtu config
 	 * so lets be conservative.. */
 	if ((action == TC_ACT_SHOT) || exceed_mtu) {
+drop:
 		qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
 		return TC_ACT_SHOT;
 	}
@@ -829,6 +830,8 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 		skb_push(skb, skb->dev->hard_header_len);
 
 	ife_meta = ife_encode(skb, metalen);
+	if (!ife_meta)
+		goto drop;
 
 	spin_lock(&ife->tcf_lock);
 
@@ -844,8 +847,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 		if (err < 0) {
 			/* too corrupt to keep around if overwritten */
 			spin_unlock(&ife->tcf_lock);
-			qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
-			return TC_ACT_SHOT;
+			goto drop;
 		}
 		skboff += err;
 	}
-- 
2.52.0.457.g6b5491de43-goog


