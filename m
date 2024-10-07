Return-Path: <netdev+bounces-132831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB999361D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B58B21566
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3D1DDC36;
	Mon,  7 Oct 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ+na2Ae"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7551D7E52
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325490; cv=none; b=lyoD5RgvStdSeJdBI56ezyzaWFWmiZEQFB4ymJGfNaEKk5X1VTKYnjC9hLKUokl9onLm8WqcrnQ/ItsIxfuhsUIUKwnMNeqXVtUm+Vkm0gHPqkEMGjQRt2S8aCdRpI56eIpWqdxuJ/Z431IXLRU1uGLnUJyrDM4bAMyNzYGrYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325490; c=relaxed/simple;
	bh=iKbT/mhLs1ED+s0yLqNpnLD7kmeVQgDboLbFUrse/e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNOkgUHfrPeu1fgf0j5z4TagKBJZjycN/3Vy2q2NTx0sEc43vJs2HpGEJ9au5pPLRLGhutTh1USCsDD+OkC5C73VexCfplybrv3eSUtSIECrQGtVKqVgJlSs0l1qyxxi1q91BdnBxEDmPMB8oxkUMfJDvbcdJCPXRvS9XKXYbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJ+na2Ae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOOlqDvcrFEu4SzAzbSsIxpL9uQq38p0CIhtrHPYGvE=;
	b=QJ+na2AeT/cohKnF70rWKfpv7MZGa5u6zsjMq6u5ob4mN0HGjLkYiHMJtJBiroQh9cVn1g
	umKjL8tBtY+zW8cK99n2LFkeF5Orj6nGvh+1sRiXL1AZjfjZq0n39/0bZcg3v0xOxjCQ2R
	CS8VMn6j5B+ZXsIiqVdKWr3omPANTbs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ci0op7YAPMiaY-tPxuHMAw-1; Mon, 07 Oct 2024 14:24:46 -0400
X-MC-Unique: ci0op7YAPMiaY-tPxuHMAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso30320825e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325485; x=1728930285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOOlqDvcrFEu4SzAzbSsIxpL9uQq38p0CIhtrHPYGvE=;
        b=j3zTc8p4lpYvAQzPi6s0L7pPKcl0hVpwEElSQbX4dbGBzDKp9hRgx9GbF99mqe+JM9
         y8dTDjhzww7NyFcktQrz0YmTOxRScL1cTEDzCYKHt0AHiIaY0z8mCtLtXYjVk7iLuvN9
         dTOE2DaIdZO01miu7cD+KGLln1Zxx5sbIUwfneAQdxbSWchLUqkbZ57kvQiib0KqNtB+
         3sUzGcm59HQMUTssZbkPUcaQiuWZZVhemPierNC13264y6TFj35XSmZ09VIKIRCZ1EC2
         wuDX8jEBQaM9q9xjFPO6XlwLKu1NzJPuFqFLQI9vxCILlAfS+ltkXA8V/DPzIHmg7RUW
         frlw==
X-Gm-Message-State: AOJu0Yz3u8HOdepVyW8d0ndKftGP2x846d2v/aEKPVBmmO8wLMkIsdqR
	I/8U8YQgrrGrqu14GRL1yGmCjDYyHfAfe3CyaBmq8dxEXG4oYUOXMvJOW9kbJu5JTtmGtVitXcH
	kCGP/sGcviYJ0qMJ9JqmHLxkkI4W/MF+ZwEptpZOiJEI1SwC5orqmGw==
X-Received: by 2002:a05:600c:350c:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f85aa1a76mr83464535e9.2.1728325485063;
        Mon, 07 Oct 2024 11:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDdc27BBOiK8zjPS9HaU9fEDYTydrLH5F71UOP/CFPFT0e0EsPFdzRNii4lO0UhA2Td9vaw==
X-Received: by 2002:a05:600c:350c:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f85aa1a76mr83464355e9.2.1728325484615;
        Mon, 07 Oct 2024 11:24:44 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ea8675sm83283525e9.21.2024.10.07.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:44 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:42 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 3/7] ipv4: Convert __mkroute_input() to dscp_t.
Message-ID: <40853c720aee4d608e6b1b204982164c3b76697d.1728302212.git.gnault@redhat.com>
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

Pass a dscp_t variable to __mkroute_input(), instead of a plain u8, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Only ip_mkroute_input() actually calls __mkroute_input(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

While there, reorganise the function parameters to fill up horizontal
space.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 38bb38dbe490..763b8bafd1bf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1764,10 +1764,9 @@ static void ip_handle_martian_source(struct net_device *dev,
 }
 
 /* called in rcu_read_lock() section */
-static int __mkroute_input(struct sk_buff *skb,
-			   const struct fib_result *res,
-			   struct in_device *in_dev,
-			   __be32 daddr, __be32 saddr, u32 tos)
+static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
+			   struct in_device *in_dev, __be32 daddr,
+			   __be32 saddr, dscp_t dscp)
 {
 	struct fib_nh_common *nhc = FIB_RES_NHC(*res);
 	struct net_device *dev = nhc->nhc_dev;
@@ -1785,8 +1784,8 @@ static int __mkroute_input(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = fib_validate_source(skb, saddr, daddr, tos, FIB_RES_OIF(*res),
-				  in_dev->dev, in_dev, &itag);
+	err = fib_validate_source(skb, saddr, daddr, inet_dscp_to_dsfield(dscp),
+				  FIB_RES_OIF(*res), in_dev->dev, in_dev, &itag);
 	if (err < 0) {
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
@@ -2126,8 +2125,7 @@ static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
 #endif
 
 	/* create a routing cache entry */
-	return __mkroute_input(skb, res, in_dev, daddr, saddr,
-			       inet_dscp_to_dsfield(dscp));
+	return __mkroute_input(skb, res, in_dev, daddr, saddr, dscp);
 }
 
 /* Implements all the saddr-related checks as ip_route_input_slow(),
-- 
2.39.2


