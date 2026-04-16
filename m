Return-Path: <netdev+bounces-279041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI0oMM3d4Gm9mwAAu9opvQ
	(envelope-from <netdev+bounces-279041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:02:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE940E719
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C2E6303C507
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34139657E;
	Thu, 16 Apr 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCsjSVVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E8221540
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344511; cv=none; b=CprAE3WuiJMb8bRQREMuSFyncYSS7Y2kr3yWPXGip6kSPw2yf3BtSyUuXzZztabZzBEYNqsTdtY+cDH/2z+7pQB30FEMQkRXCOQwL06OQn24jHyhKNn5W1H+Swfz3GXZDnqb2C2qTG66xAIrpdvCoAvsFSAV/nQrcci4ZfIJbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344511; c=relaxed/simple;
	bh=7ht94Fw+bGb8Bi/o+TEbwNrSYveP128tm1XEzRyNZfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pb+9lVdZUafJDW5gtInWrcmD/pZa8KfIdlTubjBGUeoXx4jSjAIyBQbqSEOmochwweqs94YgS3dGwz26kCZWN6n8JGcQw36An25rjwogl4eMVWG1blUWKVNCbimQBY+xF8FBV/bQ1klAbX4UUbnceOrK8NoFAz+RQxsYqiF8PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCsjSVVw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so75628985ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776344509; x=1776949309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/EDEcaRnyc+WK2SyOnB3p8PfKP/h3U3xc4KOW8/lP0=;
        b=FCsjSVVwyBfDFa7q3Xs3WLoX0NewUMRk2JESsTJ+deSvd2Y3DkwQ9sFq/p4BNm/9U9
         sQlEJIYeQE+OyFCQb3WPrxxM3zKI4D76A+XmI3+TohoLP+mTJUE0GRxRYtuDX0Ea4GFc
         b/PLV+1TNTV+6uyzzoc6/gYKAFtU5Ne40nvokE10DfWEQtmzwEPrwNyOLHl6c4Vn0bcI
         U6Mm7uW5Ym8r0ObxtJ5BLgOhTsFGPrtyejc6pgbR05s4fEmaSM5bfN1+grdrpjPX+x56
         lLF8E5CrFPxBVM55gIrLex6knqNCGgQpGJLk60s96c0xnhDv9G3FzWswsofjOVUzgUrH
         yXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344509; x=1776949309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/EDEcaRnyc+WK2SyOnB3p8PfKP/h3U3xc4KOW8/lP0=;
        b=l5THTmgXyxovX2IGsm4TsiPUgYHfy0XHSl5Njfdnrw3cq7OvHRYQ0SKfqb+mh0xL13
         GE9ZdDmgtjTEQfN7UTyQTdqkiWW/HIinGKC1q4cPLOhGAI0w1awh1KrfB53+XU4ybRQm
         ynd3IhpiDRweiX6qO3BU693UCztFjbsGv63k18g7+9MNSEChO7mGXP9iaFMXQ9Rl8fxI
         ywOM5bKs1EpkE812SGmm4uI8rv7ZL4e0VnZvN6e2ymaDd0bKa1NSOsls0N9u/CodWhu6
         gf2avMMKYaY8zLIje7TJGOErfCQYbqWsPzERDOjF12imaEap4923cX3gxg0Vd3H+i6ed
         UGAg==
X-Gm-Message-State: AOJu0YznXTfrcmm8HIFrJ2RQjnYDiIpdCZHQQWvh8RjQb8ayXKL/2y2o
	KhDJA9ej6ICxdNVg0Me+BsXaNXKE0eXikqgvNHWisoz06VXBxWX4qMvGnRbYtQ==
X-Gm-Gg: AeBDiestwWLf6nbQBWTKX7kO96puOsB/+Sln/wSjBS38S/PvWX5NRmREOWDXunmmyzi
	kenFGiTnPEgORhrpbiJQ//AaxDPanErvBW2FcfVnJ/P4sF1m/1TR0S8jfbGnZgKSPl3ZEiOURNg
	b/F27d41b79LQhhefLJjz1x4qmiFYGaDTSJuQgn0RNM1heozTjsv72KnSdZYtpUM3ZCo6gYGjNe
	ryqVud1RR70/d5i+CwY5j1xEw4CyKh9q+nm8/Q8AO4cVamSrEMT/PBqsNAzlU8HXRKznH3hY4RT
	qB4KusWR1vx0je1Hc/6PaRwDfANjkZ83Zi8SFF6i8K7XKnFWUcgdqgb50I82gNdKKg+JRjyHI7C
	LGB2HalQx7UhqMsHy8iL4MMuJ5IfwXjxgRa6SANtYB5/mdtYWPV8sWSilie3CvP21pFwkrGMAYa
	d2WQrSN9KuoIIbNC53TquZwm0WygpG5bmN4mKW0wYDn2AnwbgIEm8xo2H2gWja
X-Received: by 2002:a17:903:4502:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b2d5939409mr194302435ad.4.1776344509180;
        Thu, 16 Apr 2026 06:01:49 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e110sm68783985ad.43.2026.04.16.06.01.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 06:01:44 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH net] net/sched: act_ct: fix skb leak on fragment check failure
Date: Thu, 16 Apr 2026 21:01:38 +0800
Message-Id: <20260416130138.38050-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279041-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[phx0fer.gmail.com:query timed out];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82DE940E719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tcf_ct_handle_fragments() returns an error other than -EINPROGRESS
(e.g. -EINVAL from malformed fragments), tcf_ct_act() jumps to out_frag
which unconditionally returns TC_ACT_CONSUMED. This tells the caller the
skb was consumed, but it was not freed, leaking one skb per malformed
fragment.

TC_ACT_CONSUMED is only correct for -EINPROGRESS, where defragmentation
is genuinely in progress and the skb has been queued. For all other
errors the skb is still owned by the caller and must be freed via
TC_ACT_SHOT.

Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/sched/act_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7d5e50c921a0..870655f682bd 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	return retval;
 
 out_frag:
-	if (err != -EINPROGRESS)
+	if (err != -EINPROGRESS) {
 		tcf_action_inc_drop_qstats(&c->common);
+		return TC_ACT_SHOT;
+	}
 	return TC_ACT_CONSUMED;
 
 drop:
-- 
2.39.3 (Apple Git-145)


