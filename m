Return-Path: <netdev+bounces-131010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429398C609
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC11F23C7A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD81CCEFD;
	Tue,  1 Oct 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA5pbxQt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221501CB30F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810953; cv=none; b=HfOBPRbnrRDp+AVEtEVia1Hds+b4bQ8EZUlTCQZWu7LWnjrjou5T04G9IBmCtNFzyLkzyBwHs8eznIKnLKt0Q8edpG2ZCMmb/V20HPeDPgdDwol+Gw5fclB76g6rX1DWJt221bUVezvowOyfYhfv1ml14ZtNmL4p+OeW/HFqaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810953; c=relaxed/simple;
	bh=mbVxVUGGVRmGPGK3ra1hAXno2TTsqq9/DKY9s81E1QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stnIS69gCkgmlH5LsakGcXxdtihFEtHBndg6taB70zDT3fvY6YSKI7GdDl+0yesXrlnB61WVG1lmDL7JwKXoe8gfmEI7I0TZY+s3aeWNUCHTy6k0vZgvyiTEI4xyMjWsTS+JrtfQjama61LktnxU/vwzEWBtOzDyU6MTYXAuuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA5pbxQt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyiAPzLiuXxL95Kto4qHwRPzad81VI7XfdIz5OkYFCc=;
	b=cA5pbxQtszlUTlBJb3NIwNlxhZ3Dr1D6CrsCqOZL5L2sW6RN4njLS6VsWgG687KYiZfhKG
	e5aP0BpDRYphs1fuo7Kvunem3ynrsNbNVzTF8FFYK5/CCc3k6Liy64IO0FiXFoh2AT7zfc
	ExEPQqWZbeAb8ibHbGdpHpYd+2niQQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-SrkwAJfbNRiNBAEslshIzA-1; Tue, 01 Oct 2024 15:29:07 -0400
X-MC-Unique: SrkwAJfbNRiNBAEslshIzA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cc4f28e88so4035653f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810945; x=1728415745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyiAPzLiuXxL95Kto4qHwRPzad81VI7XfdIz5OkYFCc=;
        b=A5BmKvid94z/LoHs+HSPnKYLrE8b/UXSodhpuxVbpUaxJhv8/qNgylb/60cCsyGIkI
         r7LDrzXTEqIUBy9gNj5fMOwh15m3jUeHzjX8L2pqPuop4isXQESsHlJ1xzFKpl4XKBHu
         Mh0qbkVeSN8ivtcuFfSqNmV1nXu3MnrGjdpoCPiRr3J5xu2jVRJJPOEfir7nSAs+0pD7
         ndFLprAzdNlOFaoJY5GHkeAAuPtn3V4TNPSTrIzLtZ+iepmoLAC7b7l59yTXN4aY7xaH
         2AxTE/DUoqd3nUtjm7TJ7XfwAZEDwbJA8vBg7Vd22pjQhja0eH6OfFm+Nku+WukE5NpU
         YRFQ==
X-Gm-Message-State: AOJu0YwC8rziM//YOYsV38DvEXj0BlRfHsvtLpgVsRyu4PsJ5Il5r7yK
	jEsNrXWxpycD+k0Zm25bZ86obMrtvoRB5OLVgo+3uvqvKirZT1+QHMJN75q6wnbdzf57GOk0cmf
	MecWSuoWs7Fn7dXCCB6wjHQXNgfOs9Lp6XSM53IBtF9aD5Oc5hqE/Cg==
X-Received: by 2002:adf:ce8f:0:b0:37c:f96c:a089 with SMTP id ffacd0b85a97d-37cfb9d4298mr567899f8f.31.1727810945081;
        Tue, 01 Oct 2024 12:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERJmiyrozH+Bi2MfXZyLkSTTnnu9kljcmVjn1ZLByaAOqzg/ofAz1u7oNbbYaTY9QpC1pqCw==
X-Received: by 2002:adf:ce8f:0:b0:37c:f96c:a089 with SMTP id ffacd0b85a97d-37cfb9d4298mr567887f8f.31.1727810944753;
        Tue, 01 Oct 2024 12:29:04 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fbebsm12477751f8f.72.2024.10.01.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:29:04 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:29:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/5] ipv4: Convert ip_route_input_slow() to dscp_t.
Message-ID: <d6bca5f87eea9e83a3861e6e05594cdd252583c9.1727807926.git.gnault@redhat.com>
References: <cover.1727807926.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>

Pass a dscp_t variable to ip_route_input_slow(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos.

Only ip_route_input_rcu() actually calls ip_route_input_slow(). Since
it already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a693b57b4111..6e1cd0065b87 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2201,7 +2201,7 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  */
 
 static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			       u8 tos, struct net_device *dev,
+			       dscp_t dscp, struct net_device *dev,
 			       struct fib_result *res)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2266,7 +2266,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	fl4.flowi4_oif = 0;
 	fl4.flowi4_iif = dev->ifindex;
 	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_tos = tos;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = 0;
 	fl4.daddr = daddr;
@@ -2299,8 +2299,9 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 	if (res->type == RTN_LOCAL) {
-		err = fib_validate_source(skb, saddr, daddr, tos,
-					  0, dev, in_dev, &itag);
+		err = fib_validate_source(skb, saddr, daddr,
+					  inet_dscp_to_dsfield(dscp), 0, dev,
+					  in_dev, &itag);
 		if (err < 0)
 			goto martian_source;
 		goto local_input;
@@ -2314,7 +2315,8 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto martian_destination;
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, tos, flkeys);
+	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr,
+			       inet_dscp_to_dsfield(dscp), flkeys);
 out:	return err;
 
 brd_input:
@@ -2322,7 +2324,8 @@ out:	return err;
 		goto e_inval;
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = fib_validate_source(skb, saddr, 0, tos, 0, dev,
+		err = fib_validate_source(skb, saddr, 0,
+					  inet_dscp_to_dsfield(dscp), 0, dev,
 					  in_dev, &itag);
 		if (err < 0)
 			goto martian_source;
@@ -2463,8 +2466,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return err;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr,
-				   inet_dscp_to_dsfield(dscp), dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.2


