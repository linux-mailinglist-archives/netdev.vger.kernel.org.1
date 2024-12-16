Return-Path: <netdev+bounces-152340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36D9F3771
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31651883693
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326962066E6;
	Mon, 16 Dec 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USmtJiTG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E008207A06
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369722; cv=none; b=r6NGS/LvRJZCJbPc6dMk/4yxaDgvR2ilwekCzJ05W845eKsE+RPGNfjvfhytb0VlrD/1fDiE14eCxhYUUzMlBQj+EvHIFFN28wKWuCsY4WpIbL7ruh2+S6BMJ56EdFdpIR1WIo3NouqmK4Vp3ltDBQIrDX0hVXrt9hXONVKHBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369722; c=relaxed/simple;
	bh=XDP3jNGk4IlqPce1sZpdzKDCFB9RnX198fmPU9Uz2rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1pH/5/wGpikjFz14XoeEwYagDvBVshYhMn+UyBSTvWpPedQ/rxaqrz5JcGI/g7TTM7csVAXVCNMZXiyuXgtSfNNLBKgBlD0UYrqsWUSWEvnUjBrllWSOySAwBk2a8QafrT+cRFMKmme7JqgUz2V4lyp1mLJsOkHrb92XRojNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USmtJiTG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6bSLiIp/vbLDm7mgursV5kX1ogUS6QQZu/74jt6OZY=;
	b=USmtJiTGG3scAu5cTEXGNwJuEA9DavebPnWLK4+j6evHAtmIIC0W/wvkWWXxmR8wv8ldGO
	nXwCCs7QfWjpCzXqwfJJgeCyC9SfMbih7b8uExy4Is5NTTW0fo949AgThKdyOjR30mw4oQ
	EvNf1MooV77+Dhv/b2C4fj/rxgRK4Wc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-HkhMpShEMvCkjxgAgFck6g-1; Mon, 16 Dec 2024 12:21:58 -0500
X-MC-Unique: HkhMpShEMvCkjxgAgFck6g-1
X-Mimecast-MFC-AGG-ID: HkhMpShEMvCkjxgAgFck6g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d52591d6so2214342f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369717; x=1734974517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6bSLiIp/vbLDm7mgursV5kX1ogUS6QQZu/74jt6OZY=;
        b=HBxJdQq/BFXIdFKSCGQlWfgzZWN8xCPjXMuxgqNatdT0RL1l1RfU4tSOxS8Kj68gz7
         dHkFpOyFHAyB/qochcalQOXB33b7uveKdmxVlo5RELYh/MKa/KTm4Te0L3p/vA1GvlDq
         aIoGFOjq2K2CTsQwawgnxNeu6mfhbyP2yvAb6Ra8j+Uda7UsqhY8PONIsOWU2Pr3E/RC
         Wri5MgVBI+NKEYS0YIpUuilPamSA1as1ndBvAIO7+01i64cJ4A/puEoHjDT2Jc8Pp96G
         BZZNRuwzQ53u0LaOrf+wgiVlqUH7X6ti8T0pxiPtSnrRJeqnMSgofsluPdtXfZC63Zyd
         yozQ==
X-Gm-Message-State: AOJu0Yxu+zboi+MidYmIhULL+NRp4RtyzLem2nQOFf+KIGSARVI+kGvY
	ym3zbEIwTCggV2T4EIYojyIpT1RNlMIQ8MjIHEqDoJr7+QmFDCMFpgjBQPjF5hjoMlhWMVpWCqN
	/rmZtg9Qs+kiXTCjmy2UeGMt9/8Kk+LeytMYkYNTfTXHzOvRn0gnh/Q==
X-Gm-Gg: ASbGncvDK8arpXRSyF3m8TJ2d/D9gPu9DCefk1RmvDPbC2fgU9p4sVG8i2Cnqoil7ht
	pACzz8SzqjKe6GGlVr5QZMLqrFu5hUHz9jb8m1cdP+gLalsMw32BQvdNzhtDoyduMmVQ5OuIMxD
	QKr/kVAXT8gCAVVhiRk7hHqC+MTKR7eKMIpf2AXw4oSgxrshdFWgaju3eMZroDdI4wamQoBFaUn
	NqiyVUGGCuTruIWCyjEOS34r3gqybu74+HENll06s3NggVu4D4QNKew46b1Oxzaml638nYQm93W
	fpsw6XsYNFgw/YK2mPud8Ez1D/D7sOJRyFLy
X-Received: by 2002:a05:6000:4023:b0:385:ea40:b46b with SMTP id ffacd0b85a97d-388db2267b4mr162112f8f.4.1734369717210;
        Mon, 16 Dec 2024 09:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7T2hOhSkRKpZXQFy4BxA9gOjhvTh0GbDcbXVeqLcVwuXZnsGRyjCJCXTwm60dbXUW47fahg==
X-Received: by 2002:a05:6000:4023:b0:385:ea40:b46b with SMTP id ffacd0b85a97d-388db2267b4mr162090f8f.4.1734369716882;
        Mon, 16 Dec 2024 09:21:56 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801223dsm8841875f8f.3.2024.12.16.09.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:56 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:54 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net-next 5/5] l2tp: Use inet_sk_init_flowi4() in
 l2tp_ip_sendmsg().
Message-ID: <2ff22a3560c5050228928456662b80b9c84a8fe4.1734357769.git.gnault@redhat.com>
References: <cover.1734357769.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734357769.git.gnault@redhat.com>

Use inet_sk_init_flowi4() to automatically initialise the flowi4
structure in l2tp_ip_sendmsg() instead of passing parameters manually
to ip_route_output_ports().

Override ->daddr with the value passed in the msghdr structure if
provided.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/l2tp/l2tp_ip.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 4bc24fddfd52..29795d2839e8 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -425,7 +425,6 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int rc;
 	struct inet_sock *inet = inet_sk(sk);
 	struct rtable *rt = NULL;
-	struct flowi4 *fl4;
 	int connected = 0;
 	__be32 daddr;
 
@@ -455,7 +454,6 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (sk->sk_state != TCP_ESTABLISHED)
 			goto out;
 
-		daddr = inet->inet_daddr;
 		connected = 1;
 	}
 
@@ -482,29 +480,24 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto error;
 	}
 
-	fl4 = &inet->cork.fl.u.ip4;
 	if (connected)
 		rt = dst_rtable(__sk_dst_check(sk, 0));
 
 	rcu_read_lock();
 	if (!rt) {
-		const struct ip_options_rcu *inet_opt;
+		struct flowi4 *fl4 = &inet->cork.fl.u.ip4;
 
-		inet_opt = rcu_dereference(inet->inet_opt);
+		inet_sk_init_flowi4(inet, fl4);
 
-		/* Use correct destination address if we have options. */
-		if (inet_opt && inet_opt->opt.srr)
-			daddr = inet_opt->opt.faddr;
+		/* Overwrite ->daddr if msg->msg_name was provided */
+		if (!connected)
+			fl4->daddr = daddr;
 
 		/* If this fails, retransmit mechanism of transport layer will
 		 * keep trying until route appears or the connection times
 		 * itself out.
 		 */
-		rt = ip_route_output_ports(sock_net(sk), fl4, sk,
-					   daddr, inet->inet_saddr,
-					   inet->inet_dport, inet->inet_sport,
-					   sk->sk_protocol, ip_sock_rt_tos(sk),
-					   sk->sk_bound_dev_if);
+		rt = ip_route_output_flow(sock_net(sk), fl4, sk);
 		if (IS_ERR(rt))
 			goto no_route;
 		if (connected) {
-- 
2.39.2


