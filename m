Return-Path: <netdev+bounces-152336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEB9F376D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD6E188378A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586F2063E0;
	Mon, 16 Dec 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtbhF7Bo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCEA20627A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369712; cv=none; b=hO9fBrYjtWD4PWD5hOgRuw0d4RymyDaRnhsK+SU251CeJheywNIUS7nh8TDMIvwQVoiLngPh42ow/usghcxiyYq2o1poqMF28vozThQVVnX1kejre565YA3nwkvt9NTYzhI6kAsyPwSe/cmLZv33sF2VXNbqtbYMTzC7NPLnYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369712; c=relaxed/simple;
	bh=iei1+wYHEYge/vk8H7BY/Bl0sc/gBOefFk5SR5ZC/F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKDlOguylAMLzw7tcqd7iIaK8RtuF2gFmKJW/Zvzob9BkcA5+ugtkR+SVD6ajmq9XxhgSpmdHyAGDqtucOO1mCPxftt1B3Gxz37GonHzLPQpYpJyi/WygWDXmWJt0rlxdw5e+vobhDAU8QkQy7y2LijqEWUFtF4axjPXq7i0oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtbhF7Bo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=st1qL1MqDdDk9pBBznT0qGID2b000DxTi0tlDFIqdJg=;
	b=GtbhF7BobXtGdB+tvUok7K+XXXU0K1WkZKhMrihPSi6z77PJVhgjA4ysbzZXEL/FFSqRFA
	/2qhR6GtpirIdz7K5iAl/VohYbpFKoRTjsTvEVTaMl8NtBuM7cHLNawUEsmUGZ3nYHRnVe
	AGhVHw2V8YwRUIFvCGrPycvS9hGGmtk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-BlppPgzCPd6cZuJN6zrzGQ-1; Mon, 16 Dec 2024 12:21:48 -0500
X-MC-Unique: BlppPgzCPd6cZuJN6zrzGQ-1
X-Mimecast-MFC-AGG-ID: BlppPgzCPd6cZuJN6zrzGQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862c67763dso1762970f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369706; x=1734974506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st1qL1MqDdDk9pBBznT0qGID2b000DxTi0tlDFIqdJg=;
        b=sBigfD6IYOPAJs+b8AjYZMFDbZOYnL0fFhy3n7CxJrVp/AKVGP2qDgAgcStu7ydjiW
         84UiOXxHgEfQwvU4cIIVat8o3emRurvlmsfvnynSHATpNldoTb+T+PRi0uDNI9UxIbyY
         FGdnU5118OB05jfAQNX9Bzm6HYpklX1yUtaFUPt+eddliP2CfVYGwQTAchduuex9UZcV
         92UNCTjivsrNam8ELvbzWo3Ehdpr8r+dI8JAXXl5nDV/2I1+gG6iolEWIrraGgFE68FH
         7Nf+lCrdoeiKtBfZmEPQuqGx6LM10VGpIX0uP3uHcdSXCsZO33F2IlU/d5o5gWfj7iWc
         MRfA==
X-Gm-Message-State: AOJu0Yx3Sk0ZgqmuSo9h2eCRdPw+h13OTTzngZ4nQjmpwu1Lh578uy2S
	zC1exkxE07FVOc45FAXvgKp4S+m+itEvvDZaYg9RJawJqTW8OAbJ40SA+R1VlQrn2ykrXR32IgY
	tyB2aPxk8b0cr7ZxQmVXj6NH7AeZHAzGYoOhGmCec11s44cO9LwjNGA==
X-Gm-Gg: ASbGncu8pbfAAFgDbvFNgwGEanKq83b2pv+gviTegitjR0k4Ypwl6nkaJ4TIKT/kDMT
	VaXxAhJsROP0hyB2rf0U5slYhS3VECq1r6dXnlyAAj/SIxmwNBwX/Mfkyq3Y6BdPhi3vMFvwrna
	5mh8Zd0q8Mg1X9Wuees1+0mAU1iWQcDxRpAz3rDIxad+f6tdEcTBr7R+j60r5g+Il3n7oiiBOcE
	k5Uz3mFRND+k4h+cesQwqUnexSDftDpKwgHmHZ6YigfRWDJDMGF9Ug/a2wLc7T6S7p0M7dA3wNo
	EvCQFhF3IYOK7QYw/XWGNymzjdESc7BXCLzH
X-Received: by 2002:a05:6000:2ab:b0:386:4a24:18f2 with SMTP id ffacd0b85a97d-38880ad9d20mr11101036f8f.25.1734369706557;
        Mon, 16 Dec 2024 09:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEVQNXQ3WNimF5b16gdSfFpjS7TwXA7eERR1NwldtHUOfUppNT2eNYNx8OFuLIIntFHCsWkA==
X-Received: by 2002:a05:6000:2ab:b0:386:4a24:18f2 with SMTP id ffacd0b85a97d-38880ad9d20mr11101013f8f.25.1734369706238;
        Mon, 16 Dec 2024 09:21:46 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8047089sm8830458f8f.85.2024.12.16.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:45 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:44 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net-next 1/5] ipv4: Define inet_sk_init_flowi4() and use it
 in inet_sk_rebuild_header().
Message-ID: <fd416275262b1f518d5abfcef740ce4f4a1a6522.1734357769.git.gnault@redhat.com>
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

IPv4 code commonly has to initialise a flowi4 structure from an IPv4
socket. This requires looking at potential IPv4 options to set the
proper destination address, call flowi4_init_output() with the correct
set of parameters and run the sk_classify_flow security hook.

Instead of reimplementing these operations in different parts of the
stack, let's define inet_sk_init_flowi4() which does all these
operations.

The first user is inet_sk_rebuild_header(), where inet_sk_init_flowi4()
replaces ip_route_output_ports(). Unlike ip_route_output_ports(), which
sets the flowi4 structure and performs the route lookup in one go,
inet_sk_init_flowi4() only initialises the flow. The route lookup is
then done by ip_route_output_flow(). Decoupling flow initialisation
from route lookup makes this new interface applicable more broadly as
it will allow some users to overwrite specific struct flowi4 members
before the route lookup.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h | 28 ++++++++++++++++++++++++++++
 net/ipv4/af_inet.c  | 14 ++------------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 84cb1e04f5cd..95805dd4ac13 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -28,6 +28,7 @@
 #include <net/arp.h>
 #include <net/ndisc.h>
 #include <net/inet_dscp.h>
+#include <net/sock.h>
 #include <linux/in_route.h>
 #include <linux/rtnetlink.h>
 #include <linux/rcupdate.h>
@@ -129,6 +130,33 @@ struct in_device;
 int ip_rt_init(void);
 void rt_cache_flush(struct net *net);
 void rt_flush_dev(struct net_device *dev);
+
+static inline void inet_sk_init_flowi4(const struct inet_sock *inet,
+				       struct flowi4 *fl4)
+{
+	const struct ip_options_rcu *ip4_opt;
+	const struct sock *sk;
+	__be32 daddr;
+
+	rcu_read_lock();
+	ip4_opt = rcu_dereference(inet->inet_opt);
+
+	/* Source routing option overrides the socket destination address */
+	if (ip4_opt && ip4_opt->opt.srr)
+		daddr = ip4_opt->opt.faddr;
+	else
+		daddr = inet->inet_daddr;
+	rcu_read_unlock();
+
+	sk = &inet->sk;
+	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
+			   ip_sock_rt_tos(sk), ip_sock_rt_scope(sk),
+			   sk->sk_protocol, inet_sk_flowi_flags(sk), daddr,
+			   inet->inet_saddr, inet->inet_dport,
+			   inet->inet_sport, sk->sk_uid);
+	security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
+}
+
 struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *flp,
 					const struct sk_buff *skb);
 struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *flp,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8095e82de808..21f46ee7b6e9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1309,8 +1309,6 @@ int inet_sk_rebuild_header(struct sock *sk)
 {
 	struct rtable *rt = dst_rtable(__sk_dst_check(sk, 0));
 	struct inet_sock *inet = inet_sk(sk);
-	__be32 daddr;
-	struct ip_options_rcu *inet_opt;
 	struct flowi4 *fl4;
 	int err;
 
@@ -1319,17 +1317,9 @@ int inet_sk_rebuild_header(struct sock *sk)
 		return 0;
 
 	/* Reroute. */
-	rcu_read_lock();
-	inet_opt = rcu_dereference(inet->inet_opt);
-	daddr = inet->inet_daddr;
-	if (inet_opt && inet_opt->opt.srr)
-		daddr = inet_opt->opt.faddr;
-	rcu_read_unlock();
 	fl4 = &inet->cork.fl.u.ip4;
-	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr, inet->inet_saddr,
-				   inet->inet_dport, inet->inet_sport,
-				   sk->sk_protocol, ip_sock_rt_tos(sk),
-				   sk->sk_bound_dev_if);
+	inet_sk_init_flowi4(inet, fl4);
+	rt = ip_route_output_flow(sock_net(sk), fl4, sk);
 	if (!IS_ERR(rt)) {
 		err = 0;
 		sk_setup_caps(sk, &rt->dst);
-- 
2.39.2


