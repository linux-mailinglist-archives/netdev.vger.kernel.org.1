Return-Path: <netdev+bounces-132833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23D99361F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6090C1F23986
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EA1DDC2A;
	Mon,  7 Oct 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmlNReN9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E271D958F
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325503; cv=none; b=Yn+MThQg4+FAI8xeXkEP2oyl1irZNjBn0XYARmZlBrRvkuJTkz3GxrjdaKvrqshkC1K/sHh1Q2gdNUH7Xk13FnuqzmvKurX3HO62MIhIncDOQutzBaPtOFR4xKrE2mLHSi3h5visKGX64u/zdsEoukhjUFWmQYa6RFPdi5snQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325503; c=relaxed/simple;
	bh=+6ZVXGLHRAPlFJUw3qVLiyVt/Jj6wVHDk1q2Wq1oxuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6xgdC1K4k8ZZKYwJYx1an/Md3a+abAPaqDsuCIfgba9aSPeLZxPnHgx7FmhVveMBhjdfTrDR/t1pBeDSuUwbpJCB4qLK26WR2T0Pl2YsAAm6ZggW3EH+n2p63wjp9k3d5x0QAyAhKtlQVQ82hXVu4QrRhwujBXJrs2PnTnpGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmlNReN9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwNPPZv+TRoSbhZM2PCad31BdfTBneWZwqr2YSkRDfg=;
	b=bmlNReN99KAH+8XbEoTINSlZgC4sdAR7NDDE1oILtAIDN1fcZQAPAShY7l8AEOvKADUuvN
	pYEDJ4GVHecj1PV5EAkw4sXRXdgyhcjc10C3tK4/g0Wi1rh8uEQtSrLAr4fZjbUGs6vj4C
	JlUzjVjWRjkwLsG3wiMINK8gZgvyQoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-YRbfe3GtNaKl1LCO1sU2tQ-1; Mon, 07 Oct 2024 14:25:00 -0400
X-MC-Unique: YRbfe3GtNaKl1LCO1sU2tQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso30312555e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325498; x=1728930298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwNPPZv+TRoSbhZM2PCad31BdfTBneWZwqr2YSkRDfg=;
        b=JorZ2zPk0219TdUIjExeMevF7WksdJi/Kxb6L2U2ifP4jR1GmeirZmVfZy2f7yelMk
         rhv3Ox5ghFriAWBTD1oHtzh6Y7U3NI9XnPIYJtaxb/SM2t6EiqPgbU/O1ycf00zPuxw9
         VPgtLZdd94HjTaiJqIYHPNC9rm2U1NQmEuc0WiGeiOumSS/LVFsnfj+HymOwJF+QyZzf
         XE+Eru3dfo8kfCMxyLJu5m6hLMwwztwp5NY9WOw5w83TfVUT/tXfGCNAWnD95C8sDGM9
         IBgK7m/9uC8WeQ1mXBVnkW20SxOtARdHUXVmHmaWeWOBkN8hUD6K3o9GN/+D2pg6/WdT
         J15g==
X-Gm-Message-State: AOJu0Yxd4NmmlQjxTzIK5GrO3fSjxh+F1yiXUwQPiSMHL2O7jXsu8AVl
	0TUOSArCXHjiEnQOW/g01gTVWGvWd5eL5ZbSO1ZlImont0y6xr3zEvbwhbuocPi10VxlHQ5atzD
	ZFQk6h3GcpxbKgByuTpG/OSr4AYC8qECx2AhYIZR4ET2UawVHlaIhBPTcUB1zoA==
X-Received: by 2002:a05:600c:5493:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42f85aee7d9mr90711045e9.26.1728325498295;
        Mon, 07 Oct 2024 11:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbdkgSeLBVnRYkZMrZYtHCUGuwu0Bpj5aHsGFhJmeFyKuJw+Y/8w9bVsxOBajILu0WvsqQww==
X-Received: by 2002:a05:600c:5493:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42f85aee7d9mr90710795e9.26.1728325497778;
        Mon, 07 Oct 2024 11:24:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e5fbsm6258874f8f.73.2024.10.07.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:57 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:54 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 5/7] ipv4: Convert ip_mc_validate_source() to dscp_t.
Message-ID: <c91b2cca04718b7ee6cf5b9c1d5b40507d65a8d4.1728302212.git.gnault@redhat.com>
References: <cover.1728302212.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>

Pass a dscp_t variable to ip_mc_validate_source(), instead of a plain
u8, to prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of ip_mc_validate_source() to consider are:

  * ip_route_input_mc() which already has a dscp_t variable to pass as
    parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * udp_v4_early_demux() which gets the DSCP directly from the IPv4
    header and can simply use the ip4h_dscp() helper.

Also, stop including net/inet_dscp.h in udp.c as we don't use any of
its declarations anymore.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h | 3 ++-
 net/ipv4/route.c    | 8 ++++----
 net/ipv4/udp.c      | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index c219c0fecdcf..586e59f7ed8a 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -198,8 +198,9 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	fl4->fl4_gre_key = gre_key;
 	return ip_route_output_key(net, fl4);
 }
+
 int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
+			  dscp_t dscp, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 527121be1ba2..1efb65e647c1 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1666,7 +1666,7 @@ EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
 int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  u8 tos, struct net_device *dev,
+			  dscp_t dscp, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag)
 {
 	int err;
@@ -1687,7 +1687,8 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
 			return -EINVAL;
 	} else {
-		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
+		err = fib_validate_source(skb, saddr, 0,
+					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, itag);
 		if (err < 0)
 			return err;
@@ -1705,8 +1706,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	u32 itag = 0;
 	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr,
-				    inet_dscp_to_dsfield(dscp), dev, in_dev,
+	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
 				    &itag);
 	if (err)
 		return err;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8accbf4cb295..4b74a25d0b6e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -100,6 +100,7 @@
 #include <net/net_namespace.h>
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
+#include <net/ip.h>
 #include <net/ip_tunnels.h>
 #include <net/route.h>
 #include <net/checksum.h>
@@ -115,7 +116,6 @@
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
 #include <net/gro.h>
-#include <net/inet_dscp.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
@@ -2619,7 +2619,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 		if (!inet_sk(sk)->inet_daddr && in_dev)
 			return ip_mc_validate_source(skb, iph->daddr,
 						     iph->saddr,
-						     iph->tos & INET_DSCP_MASK,
+						     ip4h_dscp(iph),
 						     skb->dev, in_dev, &itag);
 	}
 	return 0;
-- 
2.39.2


