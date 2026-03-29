Return-Path: <netdev+bounces-272944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NhGLjNZyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:54:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F73532E8
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 410A130086D5
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52637F75A;
	Sun, 29 Mar 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE4gN2Rj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C830DEB0
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803196; cv=none; b=inbRWNpvB6pdqWOFMBbTaj/1K/jwSQH/ix/xh6DY9Bm5D4YN5HmHD1UrI1OVyLANzK+P9/ztQWj4iqymN81M/s9VKC8r2BLC/6iagY/poX0O/NoVoIyDe+tKsgDQLbTzJHdxYl2uyFd3f/WG4uJua8xiyqIyOQh7FjDQY61PZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803196; c=relaxed/simple;
	bh=2POrlhuH9arAjA/6Ity1Mx6C1zU6oUhfYHGwB9Hu21s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7eko2pvN0y7dr7lenvZY6Wy3rSRPwPQ1hPTc8A6xlSGQkONALeFEnITvP0rxSUACPyM/TENNusdQ/dn1wtSiUW9FRIk6xHq2jTGN7fyCOzssimlqSfFS6u8kqCX+BN0AlFwkZ+H/7R3NbBpkAGHOC73pI1qQqsDOOZG7uCLdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE4gN2Rj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so94639a91.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774803195; x=1775407995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puu7Te+HEqA2/yPexvy6rub1Qzj4/NrG66ME/AJqUXs=;
        b=fE4gN2Rj31ZsaOTek/KLTxKVOb9HZ1F3bkPdgAqFGvr5Za5H8F9QJAZ72rZng79c92
         zA+PEkueXiuvIynTG3Yza5In85j5/NCw3QnBNsO96wkoY4NNKCQI43uJC8OxlUm/BjuY
         PIpZti8J09FRvt1MpRcg/Ql02vmeIPK9f2pdWyvcNBLGsQBLGEbQBKjqzvwX/CH/vuV8
         QlMtpiarLewYNGwbDyIJ5CzgJHdBEuOqLc81KtlSoT7mWgxjMjLltfFWFfavNh2XrmZg
         eZfCTWt2bsS43ktddN9j+mo/daYNbDTysChe1u9WrW9vblP3iwPwbSvlFZMYaO/sXKfu
         l/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774803195; x=1775407995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puu7Te+HEqA2/yPexvy6rub1Qzj4/NrG66ME/AJqUXs=;
        b=JkGSKM8h1GL/ch1IZzUbPATaEuiWCFf0P6jQxwlATurAjA7YxGFDXCuOSYt/Hr2pyv
         m8TGorrYiEOkcS22mJmgNnWHjE34cMLwHlsvnNnshkx48401CxqLBplx+ax+wZsotXdW
         SS3W+haNL1u3Ysyd29c3WOOKZoFNShapMFfnKotW8I9TRTbcxiVbRNC8hPHTwHXl9qji
         BmlXqfokDfNjN1LvQyA2sUlPq69Z3GSG9NL9IlUW+5/18Y3X2ExKD8KXpibCIxhZzAxY
         HIiQYlsMBW31Wb7Wjno094wDjvzOqxJxF8T7md/ue8P2MqGnJT+kCW1k6lDRMlX2qi5Z
         nkHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXbAu1K94SeEX7RuGRIg1PYm1CX6Ik36jf8PKE/kgzM3c8noVjzMEZeXIffeebVEwIbBKlO74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSv2t3FNPvpqP7J5OZiCgTrpzKeCv0DRfDZvB2vpDO5g3UeaJ+
	h0g1Ar70tlzNsUOknAabXsAm2viRFfgkCSy/IeHy2ugC8KRrpVlXKmLU
X-Gm-Gg: ATEYQzzI3OeS/Wdas9QAVcF43Hf+SlPbxW3x3Zp5FSi+icHTsZ/NiLuJZXafIkcqMpx
	CE4Ir+KjSkq6M5h9McRi6I1aNDXjvnr+VQ6RxY4IogmzYvvtT1iszbO+Dy4ZX8bCV5vCkZy6e4q
	TLxwCUqtGIaoLu6T+7rALSYCP34lFeUDObTDaVYf56dBvVpUvdHuZJ4wT+g21HCyZeAfQmKPxyZ
	9qe8VZPJwuT/kcaVCZbgQJW00jUvT9mDnHEyH5I8nzzu98+e4vFUC3Ra0Af9zYCKtwvBG5ND4dN
	swvH40poPVwQBYF0on0SrKBpUVgh5f2hbl6ZfIz+RkuDpM2BoShqY1jJ9DGtd1y/Bejt187Pl/Y
	MlLf7vt2LDHQ8ushaP1WrcFqcdjeDlgB6vOkFZmctDFFvgfthVOYBIgbGnoMlUUw5Kuwcm9y90N
	iLSlCL7v95NjqpQGppWh2ieMfWmmGveZ8khbA=
X-Received: by 2002:a17:90b:57cc:b0:35b:e51b:19c0 with SMTP id 98e67ed59e1d1-35c300c22c2mr9727354a91.31.1774803194639;
        Sun, 29 Mar 2026 09:53:14 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35da9ef1b70sm310631a91.16.2026.03.29.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:53:13 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] net/sched: skip reverse bind walk after failed class delete
Date: Mon, 30 Mar 2026 00:53:06 +0800
Message-ID: <20260329165306.241079-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272944-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B5F73532E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__tc_ctl_tclass() unconditionally calls tc_bind_tclass() after
RTM_DELTCLASS even when tclass_del_notify() fails.  On
ingress/clsact qdiscs with shared blocks, the delete always fails
with -EOPNOTSUPP, but the subsequent bind walk still runs.
tc_bind_tclass() reaches tcf_node_bind() which calls tcf_block_q()
on the shared block and dereferences the NULL qdisc pointer.

Only perform the reverse bind walk when the class delete succeeds.

Triggered by issuing RTM_DELTCLASS on an ingress/clsact pseudo-class
that carries a shared block with a classifier using bind_class:

  $ tc qdisc add dev veth0 egress_block 22 clsact
  $ tc filter add block 22 pref 1 protocol ip handle 0x1 \
      fw classid ffff:fff3 action drop
  $ tc class del dev veth0 classid ffff:fff3
  RTNETLINK answers: Operation not supported
  Kernel panic - not syncing: Attempted to kill init!
  exitcode=0x00000700

The NULL dereference occurs in tcf_node_bind() when sch_tree_lock()
is called with the NULL return from tcf_block_q() on a shared block.

Fixes: 07d79fc7d94e ("net_sched: add reverse binding for tc class")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/sched/sch_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cc43e3f7574f..50d311ff1f2d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2251,7 +2251,8 @@ static int __tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 		case RTM_DELTCLASS:
 			err = tclass_del_notify(net, cops, skb, n, q, cl, extack);
 			/* Unbind the class with flilters with 0 */
-			tc_bind_tclass(q, portid, clid, 0);
+			if (!err)
+				tc_bind_tclass(q, portid, clid, 0);
 			goto out;
 		case RTM_GETTCLASS:
 			err = tclass_get_notify(net, skb, n, q, cl, extack);
-- 
2.43.0


