Return-Path: <netdev+bounces-165355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37113A31BBD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0F1889911
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170218BBA8;
	Wed, 12 Feb 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwmRZH3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3F1531C5
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326310; cv=none; b=ZAuwGu4QBT4Xgb8fHbKpUnTdDrPalJ5ouR0G8nlLhZg3aN0QCK+SaAg/+Z/LcVgg8qJG7ghw+jua5Waq2tNWy4O/XhJc3GnjoU58RHCeMPWZbLdeEbKvqjAkUx8BfN3iqZ65hHCLBkPXAniUZxeknd7+wUURuBIpw2emB/pr5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326310; c=relaxed/simple;
	bh=SUQ36dT7NCquYR/J3wrYi9DAuLdQ7lLdOj3bIwQ95TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFHLvGTBncMrJUZN42OvSkE+Wf3M353kkUwG3e+srivuV8RDmrARuQK3+KucsgFanhDH8sEst/TZoRDlEiKbfyX7xbIFZeNtLB01c+DJJEqIwSjCFH81mzvcnaUT0aO+VBg/aHcGEjCkRSVnwS25+8uOIupJR7SjUhMBBpENLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwmRZH3c; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c05f3dde21so345740885a.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326307; x=1739931107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR573iXHDE6qn0yhJ5BDmPlNhijejbGjKbJBvKgVCss=;
        b=XwmRZH3cbXKQKY0m4hIOT7UaE8F39GU7LfSbH1RqfOQQN/l7FYMuKPLg02n+q8+sB6
         528j3cK0dnUiS2q2cvceaasrICC/LxDAMu/bg4FpcWirWRFm/mttFu4HwJKZig/4Aeau
         kPTLpDdGbAwsTAgkw9ioELnADFT4SD6UXnVlbzftOvqLaAtmyXzDepQqCmwkOWgZZJyC
         vERd2DR4o+ey6TKT/1mDshtBG2cfTGQtVRmC2QxVhui574r2OlMyyZEydTCfQYnRN4Ta
         LcpHTnLly9adIzW300LIX+F9/APA/p/XVoYRv7ICqLn3hqlUNnIzPcqXcy8/p+grwp2+
         Fsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326307; x=1739931107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR573iXHDE6qn0yhJ5BDmPlNhijejbGjKbJBvKgVCss=;
        b=tS9c6BLt9JQlRyOLRKstfe6xFeCcXRf+5nNwmEFZZ47+PieIe0icZ73GqoMVrSl7O9
         b73wcyxb/l0H5ZFUEedG0KLvHxBoFs3FgENIPr7TfSJnfxsX6RtT/EtsTyoQVfXkjFyQ
         4sbagu0WKiSDG35Uho3rwgvAtT6nacMOB/FNEzrFS9DReRT9FTvI6Lnvg1oS4ZKVfIkJ
         tf8vyLwqGZRWPKC/7mxEEAjZRtrq1Z/DKAQI2IZehUtD1KIW+B4J2qdir54GFSJwDtRh
         D9W5TbunQsbNzp52TB4SVXkIS+QN8L/SJ+TcpFy2L4uCv+k+ywBxPf6HhjAu1Tps0Sur
         lm9A==
X-Gm-Message-State: AOJu0YzEUTzs5qiUsmw9x9BAI4YT98PldgzPedUMwz35YwqCPMmpLCJa
	JdAOkP+mGywDU0hZoohZT5Z4BNpY4MOyZy3iDEn3125W/mdYqp8W7bA9CA==
X-Gm-Gg: ASbGncsPmeKRayJqvp7k5BI1DJZSARXy5lOvT3uDDWIuZ0ENzqc+LKMxXIa+XxKfkk6
	S7U499Aghw1xpDPfhLrve81uMfgA2Y3nvcuEYpfjFfvb5uSly+5HowlV1K1Eoyyq1xplpKto5HX
	XojV8XvgCIdsZfz5IYRHsylv4LyHCBpQ4vg/fFFx7zyeumBX3tdZXFEHdjceI0pdgod4dV17fZZ
	uhz4AIr+5oAdE+SygHCn5IfzpNuUlrVFsGVoFD0EDlvydtrFuoFOGdT3+AurezcZ3EoXimohBmf
	nNkA5zcgbksD+bwelWfR9tFnc3kqUo118XyWhvlgKMOAhVrA/cLs03JRSnZvLMqs7LpUMRyfOOn
	uEomBl56jBw==
X-Google-Smtp-Source: AGHT+IHd0KHmhhGVX3ciUGzERKrhWqJ2KmhDf5zr5yP43a494Nx/YN5+ZA59tIgARNpPGzgMrnvPOQ==
X-Received: by 2002:a05:6214:110b:b0:6e4:6ff6:bac2 with SMTP id 6a1803df08f44-6e46ff6bbc3mr9824506d6.40.1739326307464;
        Tue, 11 Feb 2025 18:11:47 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:47 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/7] net: initialize mark in sockcm_init
Date: Tue, 11 Feb 2025 21:09:48 -0500
Message-ID: <20250212021142.1497449-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding initialization of sockcm fields.
Avoid reading the sk_priority field twice.

This ensures all callers, existing and future, will correctly try a
cmsg passed mark before sk_mark.

This patch extends support for cmsg mark to:
packet_spkt and packet_tpacket and net/can/raw.c.

This patch extends support for cmsg priority to:
packet_spkt and packet_tpacket.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/sock.h     | 1 +
 net/can/raw.c          | 2 +-
 net/packet/af_packet.c | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..767a60e80086 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1828,6 +1828,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
+		.mark = READ_ONCE(sk->sk_mark),
 		.tsflags = READ_ONCE(sk->sk_tsflags),
 		.priority = READ_ONCE(sk->sk_priority),
 	};
diff --git a/net/can/raw.c b/net/can/raw.c
index 46e8ed9d64da..9b1d5f036f57 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -963,7 +963,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	skb->dev = dev;
 	skb->priority = sockc.priority;
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
 
 	skb_setup_tx_timestamp(skb, &sockc);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index c131e5ceea37..3e9ddf72cd03 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2102,8 +2102,8 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->priority = sockc.priority;
+	skb->mark = sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 	skb_setup_tx_timestamp(skb, &sockc);
 
@@ -2634,8 +2634,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(po->sk.sk_priority);
-	skb->mark = READ_ONCE(po->sk.sk_mark);
+	skb->priority = sockc->priority;
+	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
@@ -3039,7 +3039,6 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	sockcm_init(&sockc, sk);
-	sockc.mark = READ_ONCE(sk->sk_mark);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
-- 
2.48.1.502.g6dc24dfdaf-goog


