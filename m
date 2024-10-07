Return-Path: <netdev+bounces-132832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C999361E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7F8286B91
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C261DDC3A;
	Mon,  7 Oct 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdR32iFd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6D1DDC1E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325496; cv=none; b=Scw11DUcl9KOG84y4/olfI/COmU7SvEVBRurVZvgnTQ33fRt0vhKazPR0fp+iJWGE7GVBxhrYbBJYbbHVJMj1kiMTb/reULdFY9iRL1UgGtMJz7mCv6G6o3iTWC8uRhXCtAD1SprVsaewX01RUz7phep+YIMUAbBXMyyEDMUht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325496; c=relaxed/simple;
	bh=kTS0zQn1xPgAQHoBCukJ7yeYlTOvUMlcR86XQTnpuNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5l/iTp3EfCHYKB2/gVmaPjdvJ1zfRJbiXX20g5DSY+6gR9irjl96SAlNrg5jUUc8Lu4dE8m/d87dzWRxLuxADp25h/we8IUw25A/urN9clB6uEqatoQlbuqWcfdHE0540eu/BktAhVlG1bHFJTSFGK+3WYu0f6C3TDL7RfI5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdR32iFd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA4Yj9XYC4zT18ciKfW6jQxfqHSCJKVQMRevOEKq9po=;
	b=UdR32iFdTGhKudyPiS3E7swlCDIgO/8M/ew/YBfhO5lT9RqcL1MbG5dcX6jy6Bdak7sGH9
	Hr3g+GgvvV9kVQH2aa/N7/1fYu5xAq329TEHcOEp+xQtnmQXbu+/56bJU4weJJIWiCB0LC
	IUQLyTRrOz4xmErc2Sg6myHFtiUosBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-oQy9SacrNH6r5bj9YDskrA-1; Mon, 07 Oct 2024 14:24:52 -0400
X-MC-Unique: oQy9SacrNH6r5bj9YDskrA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cae209243so30348545e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325491; x=1728930291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA4Yj9XYC4zT18ciKfW6jQxfqHSCJKVQMRevOEKq9po=;
        b=REMD55ziitJF93FVntCa31AHFA6DjBIBTcAyTax2kUvEGnneOwtOZTrPha2NR1lRC2
         FH9ANjk7VA9y1XfY2k3lmTOdMG2nojjHeCPET1ClrD8g761Gc2W8G+cx41N5QS5XV4tx
         pQkb0Nvin7q/K68qgHeUYS8zy9xDeW1dKkcBYmSjVVBvt/kAgusrWr6D7JoK2rzMnQ12
         x+SR95pnA6qVqnIFFzbG1wTr53qgcbsQKLR8EF4oz9JQANPg59cu+/8O+//APbVfJiTB
         A1bjeCBwO5SUP3Eb93UdrsVhI+DgcxVgCG4vUiTyTBzhrGomQhvZhDPQ6KnxIMzKT6Dp
         eGKw==
X-Gm-Message-State: AOJu0YxZvO696QRM7ctMUz2irCNy/0CjRqf1D7nTzFX2oWhiVPJhTVWN
	oiFy4L84UCXVzoGu7NdyrHTnvEGZaSSyT3RWDOrj8BtUh2SLi4UyXShVla8vjnQgd4J47/8c0xR
	4nDqnRm6QMuUALyk1sDMC5eItw0vc5lZpWg6haNcjZqrOhXuF6Xr2mw==
X-Received: by 2002:a05:600c:3c8c:b0:42d:a024:d6bb with SMTP id 5b1f17b1804b1-42f85abf4damr79181395e9.20.1728325491470;
        Mon, 07 Oct 2024 11:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qxZGb/L+dOGZUdVlF+VjvrPs2syi30v6OOhNK9VQPkRFE3q7Q5DKbmhgJb5BSvPHwanhbg==
X-Received: by 2002:a05:600c:3c8c:b0:42d:a024:d6bb with SMTP id 5b1f17b1804b1-42f85abf4damr79181275e9.20.1728325491089;
        Mon, 07 Oct 2024 11:24:51 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f1dasm6315549f8f.6.2024.10.07.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:50 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:48 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 4/7] ipv4: Convert ip_route_input_mc() to dscp_t.
Message-ID: <0cc653ef59bbc0a28881f706d34896c61eba9e01.1728302212.git.gnault@redhat.com>
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

Pass a dscp_t variable to ip_route_input_mc(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos.

Only ip_route_input_rcu() actually calls ip_route_input_mc(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 763b8bafd1bf..527121be1ba2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1697,7 +1697,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 /* called in rcu_read_lock() section */
 static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			     u8 tos, struct net_device *dev, int our)
+			     dscp_t dscp, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
@@ -1705,7 +1705,9 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	u32 itag = 0;
 	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, tos, dev, in_dev, &itag);
+	err = ip_mc_validate_source(skb, daddr, saddr,
+				    inet_dscp_to_dsfield(dscp), dev, in_dev,
+				    &itag);
 	if (err)
 		return err;
 
@@ -2455,9 +2457,8 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     IN_DEV_MFORWARD(in_dev))
 #endif
 		   ) {
-			err = ip_route_input_mc(skb, daddr, saddr,
-						inet_dscp_to_dsfield(dscp),
-						dev, our);
+			err = ip_route_input_mc(skb, daddr, saddr, dscp, dev,
+						our);
 		}
 		return err;
 	}
-- 
2.39.2


