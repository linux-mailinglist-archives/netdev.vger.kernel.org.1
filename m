Return-Path: <netdev+bounces-283903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJIMKs63+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C84C0856
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A0DB3053E3B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FA3DF004;
	Mon,  4 May 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rg/p3AiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B83DE45C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906427; cv=none; b=Ct6qDXTmloaiIZ/dyYw1yUqhkhfaWbIqhPOpro16fyoFVrsIka/O46YlFAC8s4CSiPq+/L5aXXgr5yK1i6nEaPY5n2DJQ+hJgd6RhBtn47wUnPpiihgUkUGnfunlyIflPUMiMnPwL+i8waoTnq5VwPefX6Zs3arPZF3GoaQV6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906427; c=relaxed/simple;
	bh=+HKGs/2OnYxSKjzoiGas5+wk6yJPcmLe0BbCqba4bFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRFxQkXwqwnRUNsKFSBYnHEZNn5vrNAVKLogJlRVyYpklLKSnkJxN9Qm9JPtMJUJ/jXw7OM0RvJQlbjbr9HgP8Wra1027qFU90zE2RP4Q+WmaRgHH7UrMBpyGwixuhanTyBmPpjfrui70Mlt0hXHIgkDL2B+MbWgegyChrU1VA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rg/p3AiB; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7bd5c5b8de6so3792357b3.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906424; x=1778511224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHhLI5sBgOBTw5yVBP3uB++yW6cjDecz6JHS4uWuFPI=;
        b=TOSq9nnmWfmk15VlvVYdTRJrDoKQWeAOb9v2pHSL4npf8F5tm4jew/ZBPozpnWOumg
         g9I8dFi3ddaodUZywkkqfbyVsx2+tpUmn8mUNHvSM9BVbApOOc/xvtWygsyN1imI+BGF
         KM+tY2mABj7yy61DjqYMeeRbGqrEbv+zODNb8XvJwA0htyeDLDZxfZu2Zu/XmaA/rS8m
         N6LnWxURt48dMXI5fJRP6akNslFgOYBzi4vbI+CfYbsWACEPT+inrZmno2TiximuQmUc
         yg5jDKWWTYo7+goJci6DhdxG9TyUuqaDBzv+hqvZbsyEYWxGKegB99oMj58xvYg8A7RE
         0c9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/acA806m/KPMC+rxjrzRycZO249fLdJCmJ8gQAQvn0UyoukkH4fyhNuWhGdQiNbSWoMU5/4So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUylSY4TeF1DgwfalLBvFgHssdxVOPEEm/jpvc0tk2IdE/yxYs
	vULcEUH08KGQ0S+N1qTGrvvv7sai8aROMLux4zEDneEgcANuVl2O6c9g+Q9efGPHRYC+Spuf6qX
	nbGCRXDeOUwX4gq0FH/PfhpiKnC7xCeiN118s1Go2oc3m24JSKHdyMifCm1qHgEHiJmq2dDRTp7
	GeSmhsEs6kzQmY41Qiznlu4wa50S9nRsiKgM1+42VL5RHD9LFpLpFCbuZCdGSGlJnAq3kKPhLDo
	ZCfJgkd4BfLt48=
X-Gm-Gg: AeBDieuCCCQeYiOvNEwp9RjRCJs5MivA0fanw8RaN8eK8qiiwgZziiCL4Jq1a9wsKqv
	0o9Wbwxn9gFbEwGV+3t5rKPMhbTulXS0d4+vIrV8qY4HA98S2zwD5hvmV6XVrPmU6t6JEWBWQXF
	915CbVpkXUanEgO4KELhN6xGrYJGEveyD2yuGYkSG9XazX6XPpp9Vs1aAvL27N/zhl1dI/xkBHm
	TzVXu39vJrjsXm13kI3lkVPgVYLCTNGDjB+UwtOEo2+llSkjn9yLyoU+V9lnqciDra6nsAfBj3n
	ltXlW/dd9mEn6lLtXhIV1m5M3JObCag7R4cLYngqL9tOj8XHKgSEnDRLrEMY+qVM/jQbb6I9w7h
	UQcvLnFbudEYd59QGoW/jRGNPAmVlv44xBoucPcF407Lj6s5XTBHCMJczLqcnf2CHPQfi4I9ANM
	/DlMO1DMvkny3R5Ls8X48t582wtohCJcdTZA1v39mdUshtr7IL0x1qklQKXqRahSbCoObV7q4=
X-Received: by 2002:a05:690c:490f:b0:79c:adbd:4f15 with SMTP id 00721157ae682-7bd76f27e3dmr67408997b3.2.1777906424509;
        Mon, 04 May 2026 07:53:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bd66830069sm6015247b3.19.2026.05.04.07.53.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 07:53:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ee2dfd63beso45083085a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777906424; x=1778511224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHhLI5sBgOBTw5yVBP3uB++yW6cjDecz6JHS4uWuFPI=;
        b=Rg/p3AiBf4F0D4wlxPjxvo1QRvQUHLIhGKLb7wW/pExYm8FMLGdR/Ap5a0UndJDecG
         WAy+J8WIniQGRf58xAPasCupeu0YdULlBb8vhQUmIhWyAyN45X47eil6Ptldo0axNucK
         ykZoIcdHxbqVdHvzI+9mz+1lo10K5Z55mKwi8=
X-Forwarded-Encrypted: i=1; AFNElJ9k3605RbOcLdmR1FSp/iUzY99Mb+At7JK8s96+MJRFcg+P4Wo91U6lkYUnAM+yRYD8ob5jDbU=@vger.kernel.org
X-Received: by 2002:a05:620a:4154:b0:8d7:3f45:b95c with SMTP id af79cd13be357-8fd155f14camr1002869885a.2.1777906423656;
        Mon, 04 May 2026 07:53:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4154:b0:8d7:3f45:b95c with SMTP id af79cd13be357-8fd155f14camr1002864185a.2.1777906422882;
        Mon, 04 May 2026 07:53:42 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1046315985a.41.2026.05.04.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:53:42 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v2 1/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Mon,  4 May 2026 14:49:44 +0000
Message-ID: <20260504144945.13477-2-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504144945.13477-1-ankit-aj.jain@broadcom.com>
References: <20260504144945.13477-1-ankit-aj.jain@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 795C84C0856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283903-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When an application locks SO_RCVBUF, it expects strict memory bounds and
disables TCP window auto-tuning. However, recent TCP memory fragmentation
optimizations still apply dynamic truesize penalties to the `scaling_ratio`
of these locked sockets.

For workloads processing small, fragmented packets (like Java's Tomcat),
this penalty drops the scaling_ratio to 1. This shrinks the dynamically
calculated advertised window, leading to Silly Window Syndrome (SWS)
deadlocks and 504 Gateway Timeouts.

This patch fixes the issue by bypassing the truesize penalty for sockets
with `SOCK_RCVBUF_LOCK` set. To ensure the kernel still defends against
memory exhaustion from large aggregate payloads (e.g., GRO), the penalty
is still applied if `skb->len` exceeds the advertised MSS.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
 net/ipv4/tcp_input.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..569299dafa88 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -240,8 +240,14 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		/* Note: divides are still a bit expensive.
 		 * For the moment, only adjust scaling_ratio
 		 * when we update icsk_ack.rcv_mss.
+		 *
+		 * Protect locked SO_RCVBUF from Silly Window Syndrome
+		 * due to truesize penalties on small packets. Allow
+		 * penalty if aggregate payload (e.g., GRO) exceeds MSS.
 		 */
-		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
+		if (unlikely(len != icsk->icsk_ack.rcv_mss &&
+			     (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
+			      skb->len > tcp_sk(sk)->advmss))) {
 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
 			u8 old_ratio = tcp_sk(sk)->scaling_ratio;

--
2.53.0


