Return-Path: <netdev+bounces-132829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91C993617
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AB8286BE9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714791DE2BF;
	Mon,  7 Oct 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwah6VK2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55161DE2A6
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325477; cv=none; b=iJbcHapec2WT08XvETf7NatSOm2uETHJfQAvie/VgfHI+fgKSZW47c97rDxygzBDDwfdQPuKMaqcVzjNJiV0i5VPWz8VPoX2At/8QNOCJGanfDGFG+59VJxpNot1Kuh7roVeKAGKUFmH5gajag5Be7IrIMW58YQTwsnTrG/6yTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325477; c=relaxed/simple;
	bh=wZSYZHH/3LJNaxMHDb5opplY/j7IfYwiiwPsSLoLDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRrujze0xT7nCiQ7Ms6D6nBwptiFlJ0ipQmVUfr3ek4F8CRIwfZNgMHjUnKiiQul71FcTLPJ66cXxnxlzTcPz2HB5wRHWyc8+q/7V5fGYR7+B4JipLRp9qO+S960WHC56RDdARmI/qx80dj3+d1LNnr8MsMqQhYS90fLm5B2OyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwah6VK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRuNcq2/0wvynhumJ90aFM1JC2lVUo5+l+Buwvehshc=;
	b=iwah6VK2vErVAKVe5Y7Bq4yTtX7oVcYeGshw6YkjHdf05jPgajklqk2Tkh7n/Pq2ADjFk3
	HKSli0Se4dI5q8nIXrATCIzXjx8ueF9j5XwZ66UQdMaMApoOfk+k6bWZtJJykA943yORe7
	dinDNGDO9zLoLM0cQh5DxIDf9Es1d8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-tiN1cxzWMzSOwU8Zp4ctcg-1; Mon, 07 Oct 2024 14:24:33 -0400
X-MC-Unique: tiN1cxzWMzSOwU8Zp4ctcg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so37145815e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325472; x=1728930272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRuNcq2/0wvynhumJ90aFM1JC2lVUo5+l+Buwvehshc=;
        b=C7PPJDm3A93RTTY+uJ5zSaG5mxM8PH7ytYjvaZHkuPXpgaWVAR/wRRPPh+VmQFoiXh
         zWmyYLDrPI1Mm3MvZONuLpqzAj4QRWpBAN90HmFT5K0qZhTf/fwcEG9CEbK2/JtcvSiL
         baOwoBwnbTQ7pzyrmdwLMjIyn2Y8qQ+PyKSEhnmnCcwoned22oibSwSNFkw1KQ5+K0d8
         SzBOsgbLmBxwa/nb3/bMsXAm9zkvSsBKU/4/VNOeJP/MkC3KTUa+cUbfG52IPhZNwlG+
         kZS4KZRZXTabR7caHS6UlPQYR8qMZ7f/gExxRVd1hzLJI5jcVbz+RVKRMC/4bYJ/k+x4
         c+hQ==
X-Gm-Message-State: AOJu0YxBSOB1Ffd5wV33IwzBF2EscjzxQmdQ+cH5iNhZpt11vBTN/Aia
	uDWdxDe8r6MyHHylIJi15Wu7gwcFL+Y+o9C7GKHAECmt8dSsknNOGVyWAjooB2GvkSv7RGf4Vm4
	19DiD/4fD8MSWZH94W8LDCMSrMvhWgrbT9X8TIRTDVRt55GzUG9DTqQ==
X-Received: by 2002:a05:600c:1c86:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42f85ac1149mr107591935e9.17.1728325472313;
        Mon, 07 Oct 2024 11:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf3h7K4hqQfqk8MB1bYgjkH++Z2G1I81dP7XCvH+3QHw1VT+hBYsyv1xCfI5QVdgJH69F+bw==
X-Received: by 2002:a05:600c:1c86:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42f85ac1149mr107591775e9.17.1728325471941;
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a7d7sm100022805e9.2.2024.10.07.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:29 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 1/7] ipv4: Convert ip_route_use_hint() to dscp_t.
Message-ID: <c40994fdf804db7a363d04fdee01bf48dddda676.1728302212.git.gnault@redhat.com>
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

Pass a dscp_t variable to ip_route_use_hint(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos.

Only ip_rcv_finish_core() actually calls ip_route_use_hint(). Use the
ip4h_dscp() helper to get the DSCP from the IPv4 header.

While there, modify the declaration of ip_route_use_hint() in
include/net/route.h so that it matches the prototype of its
implementation in net/ipv4/route.c.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h | 4 ++--
 net/ipv4/ip_input.c | 4 ++--
 net/ipv4/route.c    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 5e4374d66927..c219c0fecdcf 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -203,8 +203,8 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
-int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
-		      u8 tos, struct net_device *devin,
+int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index c0a2490eb7c1..89bb63da6852 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -325,8 +325,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr, iph->tos,
-					dev, hint);
+		err = ip_route_use_hint(skb, iph->daddr, iph->saddr,
+					ip4h_dscp(iph), dev, hint);
 		if (unlikely(err))
 			goto drop_error;
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6e1cd0065b87..ac03916cfcde 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2136,7 +2136,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
  * Uses the provided hint instead of performing a route lookup.
  */
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      u8 tos, struct net_device *dev,
+		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2160,8 +2160,8 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	tos &= INET_DSCP_MASK;
-	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
+	err = fib_validate_source(skb, saddr, daddr, inet_dscp_to_dsfield(dscp),
+				  0, dev, in_dev, &tag);
 	if (err < 0)
 		goto martian_source;
 
-- 
2.39.2


