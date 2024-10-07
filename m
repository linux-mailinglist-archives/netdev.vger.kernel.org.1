Return-Path: <netdev+bounces-132834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C28993621
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59DC282CA3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C61DDC37;
	Mon,  7 Oct 2024 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKzkO32+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9E1D958F
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325509; cv=none; b=uV3QuRQzQ7ZUnWx5K/jAR368s1Dhk/QyGEraNpi+in+ct7ge/AMIhAGE0ae2NeG11uqwSk9Pp0b5LHc/RT7b1k8ASc2g03tddJBJoMLlQmrYgzOePTxOXy+krctKH8yjkWbqTux09MIjlcLFjN+4YK4/TW6jEYNoObliCIFPHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325509; c=relaxed/simple;
	bh=nkw28ryJBjT3Q6g7hLW8/0M5MDj4kShuITxkPdd4XmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnWrMQ+ItUcP216NTYjG6nHIy3h7T5Aer05D80zNVzpooczO5jpredojm+FsYOPi+zrewYPQiCON/jVPKXXAerVfZGTOX4WDyYNgSmUmFkFroEOgir+iRKPx0goFqt1uOO4y80oc9HtgkT7JBUdKxX7RVX5ZCUHy9qNskWuuZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKzkO32+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zD8dQyOkqIxj/XSt2e1o0EaFzKFBGlrAOh8/UhfLAc=;
	b=cKzkO32+0++R58gD4MNJ731e6A49a9sxvSip4Z7BHezNlAtUvIH8JMu1F2TNRDgGunm7Nd
	Pb+zlWnerJzbKKPn/xU17rlIyuAFLBAg4pZHkSCTPOjeM5XSTaSdfZQ2ePE/5KK9wtafPM
	LUaYWGBSPqh2edPTDvqg8/gCeVqJTIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-seuihj6GOmSSlET4admDyg-1; Mon, 07 Oct 2024 14:25:06 -0400
X-MC-Unique: seuihj6GOmSSlET4admDyg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so53434125e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325504; x=1728930304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zD8dQyOkqIxj/XSt2e1o0EaFzKFBGlrAOh8/UhfLAc=;
        b=Ycntz88h/Fhoh5ADxzPiS3oMsmBsAzOUezR0tMb8RieGfNObsBuadhQGiVqV5ReOiX
         RvcCHm+zcv65HJiSb18TwIKMeC/uYY7NgkYGOb4ihs+j2e1ohwaG1XDFParewrNh14Ye
         2wsw0AcUvyGPsjs/7/qpdjPOZBg/LJsoFk2241ZtnmYIh/bhfpcFzx/QDeNRB7yLGiBN
         69hGqUv6m4R+JNIqLigihwb/374g9dFx2zYFEcEwWvY5AvQspkndwo3BTjhgH3WMHPoS
         uNhnVnQOKyHl7AXhR37bQZbgdX1HVV9+Muo7PCRQStH7KiAlHgPuKVw+XkkeYq66Qs0f
         Bbcg==
X-Gm-Message-State: AOJu0Yy31ZZYNpE/pQNewJMiIKEU4OOvVqQ4KYmnBGoLMgYELaTQpkao
	Kjrp/9I7jvxQF8mfnjqcUbwVPimTFA8MrzWYtQlf4uQaz9YOicuba90jKgqlhvhGUEbLiMW6/vB
	QvwKs2PE2cIcNuOcBsT1pvWuudfGAFcnmUGGJN6nyYhW9ob1D0Ngrkg==
X-Received: by 2002:adf:ebcb:0:b0:374:c658:706e with SMTP id ffacd0b85a97d-37d0e8db679mr10216040f8f.39.1728325504567;
        Mon, 07 Oct 2024 11:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmEiD+aO3nn4hp+M2brR980LWNeZhtfTNKEF9mxJkPjgBtT0mpS7sWK5Pkf+H3JlO8LmOKxQ==
X-Received: by 2002:adf:ebcb:0:b0:374:c658:706e with SMTP id ffacd0b85a97d-37d0e8db679mr10216024f8f.39.1728325504075;
        Mon, 07 Oct 2024 11:25:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16973c2asm6270172f8f.111.2024.10.07.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:25:03 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:25:02 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 6/7] ipv4: Convert fib_validate_source() to dscp_t.
Message-ID: <08612a4519bc5a3578bb493fbaad82437ebb73dc.1728302212.git.gnault@redhat.com>
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

Pass a dscp_t variable to fib_validate_source(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos.

All callers of fib_validate_source() already have a dscp_t variable to
pass as parameter. We just need to remove the inet_dscp_to_dsfield()
conversions.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/ip_fib.h    |  3 ++-
 net/ipv4/fib_frontend.c |  5 +++--
 net/ipv4/route.c        | 21 +++++++++------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 967e4dc555fa..06130933542d 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -449,8 +449,9 @@ int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,
 __be32 fib_compute_spec_dst(struct sk_buff *skb);
 bool fib_info_nh_uses_dev(struct fib_info *fi, const struct net_device *dev);
 int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			u8 tos, int oif, struct net_device *dev,
+			dscp_t dscp, int oif, struct net_device *dev,
 			struct in_device *idev, u32 *itag);
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
 {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 793e6781399a..d0fbc8c8c5e6 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -419,7 +419,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 /* Ignore rp_filter for packets protected by IPsec. */
 int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			u8 tos, int oif, struct net_device *dev,
+			dscp_t dscp, int oif, struct net_device *dev,
 			struct in_device *idev, u32 *itag)
 {
 	int r = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
@@ -448,7 +448,8 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	}
 
 full_check:
-	return __fib_validate_source(skb, src, dst, tos, oif, dev, r, idev, itag);
+	return __fib_validate_source(skb, src, dst, inet_dscp_to_dsfield(dscp),
+				     oif, dev, r, idev, itag);
 }
 
 static inline __be32 sk_extract_addr(struct sockaddr *addr)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1efb65e647c1..a0b091a7df87 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1687,9 +1687,8 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
 			return -EINVAL;
 	} else {
-		err = fib_validate_source(skb, saddr, 0,
-					  inet_dscp_to_dsfield(dscp), 0, dev,
-					  in_dev, itag);
+		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
+					  itag);
 		if (err < 0)
 			return err;
 	}
@@ -1786,8 +1785,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		return -EINVAL;
 	}
 
-	err = fib_validate_source(skb, saddr, daddr, inet_dscp_to_dsfield(dscp),
-				  FIB_RES_OIF(*res), in_dev->dev, in_dev, &itag);
+	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
+				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
@@ -2159,8 +2158,8 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	err = fib_validate_source(skb, saddr, daddr, inet_dscp_to_dsfield(dscp),
-				  0, dev, in_dev, &tag);
+	err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev, in_dev,
+				  &tag);
 	if (err < 0)
 		goto martian_source;
 
@@ -2298,8 +2297,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 	if (res->type == RTN_LOCAL) {
-		err = fib_validate_source(skb, saddr, daddr,
-					  inet_dscp_to_dsfield(dscp), 0, dev,
+		err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev,
 					  in_dev, &itag);
 		if (err < 0)
 			goto martian_source;
@@ -2322,9 +2320,8 @@ out:	return err;
 		goto e_inval;
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = fib_validate_source(skb, saddr, 0,
-					  inet_dscp_to_dsfield(dscp), 0, dev,
-					  in_dev, &itag);
+		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
+					  &itag);
 		if (err < 0)
 			goto martian_source;
 	}
-- 
2.39.2


