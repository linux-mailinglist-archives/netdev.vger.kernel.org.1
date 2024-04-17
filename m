Return-Path: <netdev+bounces-88817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D58A8984
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633D02860AC
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2824171E44;
	Wed, 17 Apr 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX8RjuQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C8171657
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373083; cv=none; b=L8lhDHmeWf6TXp9Ce7FrA3+31tODrnFYoeht1uU68Zrt0v8eEzCUVKbU5Ubez7SU6kxOvMhbZ1zIoNF2M66Dcw8jsPO+V8v0JaDES0LGsH20BHxAiXvi970RLCWPWQ7RO4jwplMWp4JOY1Mp0s+Tzcils++ARmoOyi3eTMsAPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373083; c=relaxed/simple;
	bh=N2jmBhMBn5+m4fm5zFW8foolZM+iM6Bte4t0VVhlVmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q17dzAKXrSaOuaIdpKPqCavCtjX0OPAP/sVjvNYdvCgRMu2lULz457r0Km0jyjutnCswypzdAr0gDBdABI8v7aWjWq9zK6YdbcPKdOZQ+3D4a3Ik4NnMc/xCDS0znA8SXNjvOVaIVHsyJyE+ahN8Dfm+19CWKQ6X6tuhrJF1EBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JX8RjuQ7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d8ec875so419828276.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373081; x=1713977881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SfHsMjvbsZ8saPJkjIJdYMKlU+OKfppDgN6rcyAi7Y=;
        b=JX8RjuQ7mG9zOrFZYtiS4U+EYp7st2FfajGj2AbXZwQRgMRAsDKL07aTfcDM2YPIyJ
         skxSb/hA+t0oO+GK03F9aODPFFSuSZjBh9vJvwzCpr3xMvJmKVL2IDnauCdMny3iU/qh
         ePCL5aunD3hIb6YdYK/Bp9zsVnkAZlf+f5ybASg5bBMh6FsBMtuY5dyutSocYFVP+Q1m
         yJ8waG/J2IHkhXyyb7Tj7oeFYcLs/86YtJidxlFPpE2W9xmGXyFB4PmyJjv6oXE1oScs
         cpyX5UkMENwTC0ij3N8mNUR6P1VybzOIu49Rrub0/nJX993oTs44w6dysE/8gtNxUZ61
         NtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373081; x=1713977881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SfHsMjvbsZ8saPJkjIJdYMKlU+OKfppDgN6rcyAi7Y=;
        b=Yn9zrH6Q1rcm+jS5POFAvd8w6Q6w/w6LC/cIJ87eMAX/348sY9GWhj4xGw/eZzeVux
         jBL9Eq57Q1UEN0gZWvus/NfVQ0dTxgJEM/Bll/Z6ObVOzDQ21BbuYFrIeBHjFyQ/HDzL
         noMDQfCwR2sGAnY5P5b7j52N3wyFGIX7VRZc+l3wTo4xuWVPTE/sgN70UU20WSUuaBGE
         X6gVXs7Zwaz8LlVVrmM8vQ1ve9no8tpt3sX2sSZUAKPnl6zajP7hdKqAngBlabDpvlC0
         5w9BgyVnh8TVTzPBhmqUcQOL49/fG3XbeUKVhDqhKv4ayYyoZ/UUnSoMv63u6F3Xqhii
         2QCw==
X-Gm-Message-State: AOJu0Yx0Ee7pPEEEpdC+lW9m7/0lzzE9+8pVZ9QBCYR/9+d9NxwnVGRj
	FthmQYCgMmpbpU16nDss4b5CWaxUNM3BufAUfd95YQbmmPrcmuuEVlclxX04I8tYXEKMjK9sqU8
	R60iCP5Gcfg==
X-Google-Smtp-Source: AGHT+IEg1v6If1wu5z2wGkUiaGBXXjWDiofPW7ixTY7LVjpINF01obAWlwjXMefuIFNEecyyMeVQVHMX/iIBsg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b8b:b0:dc6:fa35:b42 with SMTP
 id fj11-20020a0569022b8b00b00dc6fa350b42mr5290472ybb.2.1713373081352; Wed, 17
 Apr 2024 09:58:01 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:57:56 +0000
In-Reply-To: <20240417165756.2531620-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417165756.2531620-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: no longer abort SYN_SENT when receiving
 some ICMP (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Notes:

 - A prior version of this patch in commit
   0a8de364ff7a ("tcp: no longer abort SYN_SENT when
   receiving some ICMP") had to be reverted.

 - We found the root cause, and fixed it in prior patch
   in the series.

 - Many thanks to Dragos Tatulea !

Currently, non fatal ICMP messages received on behalf
of SYN_SENT sockets do call tcp_ld_RTO_revert()
to implement RFC 6069, but immediately call tcp_done(),
thus aborting the connect() attempt.

This violates RFC 1122 following requirement:

4.2.3.9  ICMP Messages
...
          o    Destination Unreachable -- codes 0, 1, 5

                 Since these Unreachable messages indicate soft error
                 conditions, TCP MUST NOT abort the connection, and it
                 SHOULD make the information available to the
                 application.

This patch makes sure non 'fatal' ICMP[v6] messages do not
abort the connection attempt.

It enables RFC 6069 for SYN_SENT sockets as a result.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/ipv4/tcp_ipv4.c | 6 ++++++
 net/ipv6/tcp_ipv6.c | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a717db99972d977a64178d7ed1109325d64a6d51..4b50d09f84b9ae7fec98a71bedf39594ab85e5ea 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -482,6 +482,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	const int code = icmp_hdr(skb)->code;
 	struct sock *sk;
 	struct request_sock *fastopen;
+	bool harderr = false;
 	u32 seq, snd_una;
 	int err;
 	struct net *net = dev_net(skb->dev);
@@ -555,6 +556,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		goto out;
 	case ICMP_PARAMETERPROB:
 		err = EPROTO;
+		harderr = true;
 		break;
 	case ICMP_DEST_UNREACH:
 		if (code > NR_ICMP_UNREACH)
@@ -579,6 +581,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		}
 
 		err = icmp_err_convert[code].errno;
+		harderr = icmp_err_convert[code].fatal;
 		/* check if this ICMP message allows revert of backoff.
 		 * (see RFC 6069)
 		 */
@@ -605,6 +608,9 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		if (inet_test_bit(RECVERR, sk))
 			ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
 
+		if (!harderr)
+			break;
+
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index bb7c3caf4f8536dabdcb3dbe7c90aff9c8985c90..f31527f0a13dee9488ce72834d89524e83f61e5f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -382,7 +382,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	struct tcp_sock *tp;
 	__u32 seq, snd_una;
 	struct sock *sk;
-	bool fatal;
+	bool harderr;
 	int err;
 
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
@@ -403,9 +403,9 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 	seq = ntohl(th->seq);
-	fatal = icmpv6_err_convert(type, code, &err);
+	harderr = icmpv6_err_convert(type, code, &err);
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
-		tcp_req_err(sk, seq, fatal);
+		tcp_req_err(sk, seq, harderr);
 		return 0;
 	}
 
@@ -490,6 +490,9 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		ipv6_icmp_error(sk, skb, err, th->dest, ntohl(info), (u8 *)th);
 
+		if (!harderr)
+			break;
+
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
 			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-- 
2.44.0.683.g7961c838ac-goog


