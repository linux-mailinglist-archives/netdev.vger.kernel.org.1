Return-Path: <netdev+bounces-166587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BDFA36841
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C71725BC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD51FCD02;
	Fri, 14 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/acFh6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2A1FC7D5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572049; cv=none; b=t+0I+/AV3o2qgzz8znBQ8fQKD5sy5gPrECYCO35k/bik89n1SjipNsgJuJ9ygaxlZ/caksonGzhawkGVVvXWNl5DaxUHNm8qGKcFatM2Z4gBXScwwXZEhY4JYnTLKR10ABmoFIBI+O228LCcc2tkvESO618cdqUoeqHU00P08zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572049; c=relaxed/simple;
	bh=ucvbi0Zm03b5w6SFwAo9/XNpGFI3SyVAgc8E3vqrtcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZS5g+jjjkSN11XS/sf8c3JX13nDnE0NnahiIX3Gnbmmf2GiY/SQRhsnBX355m7HYhtJ0W+VQZZnJyIA6a1lVs03OYtSaA20ZyGQz7TkP8bTUXNBq+FZ8uiZwsY6AmBpaj0InCprfLJMJ8DwTn5f5YOeTiGIOot2UC/HQyKBGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/acFh6B; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e44f9db46bso28161616d6.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572047; x=1740176847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UgHvc1QgYTs64oSEM+u8grdLcyRvVdNFVLOjGhEmX0=;
        b=B/acFh6B9zRZAGo0RQ4p4C3MzR8Vp4f2jbP6uU81wHP9BSVUjlY0OFrG+gSjVovR79
         p/BcbgMSeYKkO9A4SJU3uUCKGAcdTVgyn+LrVwuaxqF0wnehxnFpdc02GQ/tA3/BMc/+
         BmwAFeVJ3gMCWYmipC4gS4ZvshXdhygdDqZ+oF07y+WkbH6B8HuLpIB4QSWofvqt8Qw7
         dev5nhJQ6iuNDOmDg+7ZmiNlZLSBajccLJPG67IUgbUxpgDlISac8iO2+ZKuZtktzszq
         vXDgoOaAK0ru34EFHy4yENAu17EsuBwY2P1hz09+zlSC1qwKL5YtXwswS6CvYabK4Q86
         38cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572047; x=1740176847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UgHvc1QgYTs64oSEM+u8grdLcyRvVdNFVLOjGhEmX0=;
        b=aN8pYWFk0tFebn/TP6INjspGX52rtNJjRUa+IxjhJQ5rURZOoD2Az5lsbQU7BdECbr
         GnaGCmAaYFzhURnDo9fZsQuxA+jOgXqdC399v6+M5dEsLyV/7LUrpi2j9BA5BZ//OhP3
         01PQ2A5ha/qD3WxXC1vW9CkX8gfniMquVUp4C8MK8vtelX95YfYjykk152Q7GPA30F+w
         qHQHzrT3ZIXjYFaSOQXrMIz2Ga0yMA0o/bcWcO/oO9V4rRZcJPaIdFQtKKDMyE76oGCF
         TXmQZ2adtuMq1r3mkVt94kdfog8sxh2gL4QyRPtojaf9xrociXkTKC8+O8xrYrHknyPS
         3sPQ==
X-Gm-Message-State: AOJu0Ywwdf5T3GSfNkVO5F1W06CispolU+6I4QpeWJfS0b6EdHUcoGhw
	d08HLt33MVwAF7qVuYAiuw/jh6KqJR57BvkBFlR4NlhQaj6M/48hmk5Bdw==
X-Gm-Gg: ASbGncv3n8wNCyhJ8caCq0wxyfdZqFUj6MIM4kd97shOB1Hd0uEaql1+6xNkzXAgPRJ
	xYV5b5rmOoAIjsLt82m9yf95XJwXs+L1z72NtshRE1EX2BRd0igD7fPF0gWX+hTLg61LwC+B2I4
	suj3TdOiGkxJKcxNqo0KFtuzA/A+3TZsBn09dXxcvtVixp9tiOR18AJVl94dma0Q9Ift57QB8eB
	fKRjHFv+RMyDWucG0p4irVGw9DzaA578Q+hGjczNXLva7Qk30c2EDDff/ilXN33OhTrFQPHjt2o
	D60GZtDZlvpUCxEu8sr65/u/6axW/3tmYHDb4Gd5oiJ4LbyPKaQPw09ePLmR7MynF86UMes/BF2
	/Nz+hnGoOrw==
X-Google-Smtp-Source: AGHT+IGc/jDrAHxNMP7UdnO8R8nACiMYauYa0D8mX+wEZvoqQ+YevXiHlPNusvU4k/BtHJBviCpeUQ==
X-Received: by 2002:a05:6214:1d09:b0:6e6:5bda:a47b with SMTP id 6a1803df08f44-6e66cc86be6mr19177936d6.9.1739572047100;
        Fri, 14 Feb 2025 14:27:27 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:26 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 2/7] net: initialize mark in sockcm_init
Date: Fri, 14 Feb 2025 17:26:59 -0500
Message-ID: <20250214222720.3205500-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/sock.h     | 1 +
 net/can/raw.c          | 2 +-
 net/packet/af_packet.c | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60ebf3c7b229..fac65ed30983 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1829,6 +1829,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
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
2.48.1.601.g30ceb7b040-goog


