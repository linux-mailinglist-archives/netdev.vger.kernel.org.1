Return-Path: <netdev+bounces-152963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F79F6728
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33775173712
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CE1B0423;
	Wed, 18 Dec 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTLEgIzI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB41AA1DC
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527844; cv=none; b=svV6r///Y1bJTZ66qvyo3WaFHyeNQFzpQAAZGktXo34fZMjPZMyFXXTYAdsDcVLRjYQg1FaViSYKQ3rNPwDFlgWm3JId/1LE788JF+gO/Lj5kcDmmgPsOKh96BtogYOnnpfmmbTZM7BUXhzLRdYyCpLO2mOLg7PJxHHHy3niVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527844; c=relaxed/simple;
	bh=Q76oatco7cuC6zFeFCUmQl1afYbdN6l6V/M8gR1GIKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IdPVnhSM+Hg54wZzIVmEPCPpjLAVYY49E6QmseNT+V7uXhJ7DbgSDPMeMcjUFYRaWMuY5FindhSO9ccfr+LeiDsZqIe3Gzqhg6tgC5+FtvdWzaKBDg946oIAD2vycwUFvB8qL7v92Pb4off2d6pU9bQytqieqwgyAQqZUFrOp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTLEgIzI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734527841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ivizjjN4Lz+lPIVERr0pY0koraWnQhz5/NfNltazcUE=;
	b=PTLEgIzIi2Uu7vOP3DnIRf+8ZLAJLeXNeaoudOy8O0Zj6n77BsKXS21UT8kOVT/00CI+uD
	dH3XCZEVw5oAGJl/OIejvQhGmUOari5MKtvfWVWZKcJQUYx0HS4bXzanqnpyLUbEBuvDPj
	lBinPQmOsqWmGPuRIQdBgzlV6Mbk/kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-TCkHECi2N-eIZUSpu4J43Q-1; Wed, 18 Dec 2024 08:17:20 -0500
X-MC-Unique: TCkHECi2N-eIZUSpu4J43Q-1
X-Mimecast-MFC-AGG-ID: TCkHECi2N-eIZUSpu4J43Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso39668895e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527839; x=1735132639;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivizjjN4Lz+lPIVERr0pY0koraWnQhz5/NfNltazcUE=;
        b=kUmsSlYdeEOStkKpOam3xzBWGxgwKhmqRpDYonr/nP2WmK0fy0KJfGkXjgZmSCg0SK
         NmASGuVZfJYis9BPNFkQLqdHOA7rtK2g6dPustzicDWfLMegeWgYCGptyRjN5X8i3bQK
         DFplTkzLB01SeX0PYg0MZva1/2Ng6SOXlKJ81HVLRJBo64tEOmJNpYkD81ZzUzCpxkSx
         SukuH78nbfI+kRDYRCsaTVmTck1Enien7Ah82d6Vlos+8KnKR8+Al9nKkweJ++bZPZqY
         5uJaNZ5gpetJFrgszVaqnXuDSsQKPikkgtiXA5fuReB1nZTy9mgVBiZ75BzFkZNN7wDA
         CwQQ==
X-Gm-Message-State: AOJu0YwefJ21b0SeJEebojqOllKb8pdg3zx0brXhpKXVpTgV1dfpz2Xc
	qvWuLnTIy5BXKs4oP90kr8fzOe+NnU80GSYyC/O4CEojphDYBa2/OJsc38cnzlpkhpPHlvuqPYS
	smHKlKADREIRjeaQ+aXx8YAXLYQtBypuFk/pNiRtYeyZ30+eqXiGkAQ==
X-Gm-Gg: ASbGnctv8S2mGm2RP0MZ/OQSwWkW+8SBrGD8ieo98uIAPCfImVbGe8b2t+IQWdypitI
	uOh0dRlGg5YKuHgbfYtZWl6jdJL+kt/kH4oa08QN0Bj8M2Z/C11pcKioRKUp852cFfbi1Ibs4Aq
	udcZb7UViEROAGQWWjYBjCwfkCw3d4fU0ix0gbZxahDdui4aVtACtQSU290pMFs2z+s0v2YVXP5
	BJpXQAmhrgxvQBm4VV3ZOhqAHCbuxjONmHe6NaSHvHLW3/3UymN0pRdBB716zO+BTkAqKTLomzN
	E5duG6T529vpPq60GOpQVK+k48w4zax1gAk=
X-Received: by 2002:a05:6000:4021:b0:385:e034:8d47 with SMTP id ffacd0b85a97d-388e4d8fbf5mr2740117f8f.46.1734527839061;
        Wed, 18 Dec 2024 05:17:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvBpmcBo3TITTCFmMhATnpRhsPDmG1fosLYohVybXcWLFmAn5TPMQsrwnOWEfnbmjJUXdZ5Q==
X-Received: by 2002:a05:6000:4021:b0:385:e034:8d47 with SMTP id ffacd0b85a97d-388e4d8fbf5mr2740093f8f.46.1734527838648;
        Wed, 18 Dec 2024 05:17:18 -0800 (PST)
Received: from debian (2a01cb058d23d6000ef26855a45fab6e.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:ef2:6855:a45f:ab6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806055bsm13855624f8f.92.2024.12.18.05.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:17:18 -0800 (PST)
Date: Wed, 18 Dec 2024 14:17:16 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] gre: Drop ip_route_output_gre().
Message-ID: <ab7cba47b8558cd4bfe2dc843c38b622a95ee48e.1734527729.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We already have enough variants of ip_route_output*() functions. We
don't need a GRE specific one in the generic route.h header file.

Furthermore, ip_route_output_gre() is only used once, in ipgre_open(),
where it can be easily replaced by a simple call to
ip_route_output_key().

While there, and for clarity, explicitly set .flowi4_scope to
RT_SCOPE_UNIVERSE instead of relying on the implicit zero
initialisation.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h | 14 --------------
 net/ipv4/ip_gre.c   | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 84cb1e04f5cd..6947a155d501 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -185,20 +185,6 @@ static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi
 	return ip_route_output_flow(net, fl4, sk);
 }
 
-static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4 *fl4,
-						 __be32 daddr, __be32 saddr,
-						 __be32 gre_key, __u8 tos, int oif)
-{
-	memset(fl4, 0, sizeof(*fl4));
-	fl4->flowi4_oif = oif;
-	fl4->daddr = daddr;
-	fl4->saddr = saddr;
-	fl4->flowi4_tos = tos;
-	fl4->flowi4_proto = IPPROTO_GRE;
-	fl4->fl4_gre_key = gre_key;
-	return ip_route_output_key(net, fl4);
-}
-
 enum skb_drop_reason
 ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc793..a020342f618d 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -924,15 +924,18 @@ static int ipgre_open(struct net_device *dev)
 	struct ip_tunnel *t = netdev_priv(dev);
 
 	if (ipv4_is_multicast(t->parms.iph.daddr)) {
-		struct flowi4 fl4;
+		struct flowi4 fl4 = {
+			.flowi4_oif = t->parms.link,
+			.flowi4_tos = t->parms.iph.tos & INET_DSCP_MASK,
+			.flowi4_scope = RT_SCOPE_UNIVERSE,
+			.flowi4_proto = IPPROTO_GRE,
+			.saddr = t->parms.iph.saddr,
+			.daddr = t->parms.iph.daddr,
+			.fl4_gre_key = t->parms.o_key,
+		};
 		struct rtable *rt;
 
-		rt = ip_route_output_gre(t->net, &fl4,
-					 t->parms.iph.daddr,
-					 t->parms.iph.saddr,
-					 t->parms.o_key,
-					 t->parms.iph.tos & INET_DSCP_MASK,
-					 t->parms.link);
+		rt = ip_route_output_key(t->net, &fl4);
 		if (IS_ERR(rt))
 			return -EADDRNOTAVAIL;
 		dev = rt->dst.dev;
-- 
2.39.2


