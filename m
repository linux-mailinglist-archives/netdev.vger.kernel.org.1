Return-Path: <netdev+bounces-131009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D198C608
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A072D1C23EE7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F81CCEF8;
	Tue,  1 Oct 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLeFT7Bm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B471CCED6
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810945; cv=none; b=j3DWAcEId6oA7YNXDIERvAluyW+pHg3ba4SGJ1MyNXIZADVh1S+JXSwf7pxj/Fa+FzODQQ76lTlRe8HUFtGOACcFiJHrWgYB4mKWjvzbPxhZB3hmw7zYfxC44o9Df77/ROWfvEvRGa+/KyoXlHo/wnvFs4J4lEeFJYWoAH/a8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810945; c=relaxed/simple;
	bh=e1R2AqnpJKiftjb+lYf3kS0dQNuVwRKIfQHug1zc3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYAhjFQXKPRZTm0ykyKO/9BzpYsQ5/63X8gD0Bh6l44NLsMoq1uADqkz9bUAnIJq3LmM0uhw8APBmAz8ZYRpOq6kj19wQ06reCtxVwx6/jq/440341zU/vZEh1v756eAzEmWHRlXeZ8Um22XTUN/r1Kj7EglXkH5g7dv7yrr8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLeFT7Bm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjL7CwM6ypjXJpV7gAAATjLEUIaRsTObcktuGB/hzyM=;
	b=PLeFT7Bmy88g2TTZ58BAnrne/T+5KRyR0sWeioz8OEUBK75eVBVxBN5Hhw5Bz4RuUcuouc
	SKJfxUOQRT4Ua76ts9c7oTepZ4EugJDgPup9yGSSHVY8zcRLXEBZTgZfKLly58rQ5fSPNQ
	k7VYrRckCllVk9CdvFcz2mVB9g5U/18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Hzin7B2POo2f-IudbsemGQ-1; Tue, 01 Oct 2024 15:28:59 -0400
X-MC-Unique: Hzin7B2POo2f-IudbsemGQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caf073db8so48618355e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810938; x=1728415738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjL7CwM6ypjXJpV7gAAATjLEUIaRsTObcktuGB/hzyM=;
        b=HHHmXfqvZxmJGIgRUOuMGQ3MZz4NV2z+I9IYFrb5GPwGksx56H1PaUkQuBEvrIdW5e
         UMaffM9POUvixiwbEMgaG3IRuiPX1xGpslZ6z+pkGvQVT3pTdCoOul/eAXFpTWQKHaO0
         qgc/WzLUgijF7/2eoI9bxm7knEwlMudTi+qy6RyicIxAhLKesnxp872/aj+YKxQRNh19
         Lh7c9sQ6rOOsqN2Hu/mz9LD0qPVj6K4trv4DFBwijY2k2ChQLPxoPM7WCQLHS356qTJU
         61zMRoVUt9hxCd611poL1UnY4ewVRS0l3luwz+3IHoV1yNOhgnvHjSjNs6Vt8gxtE7T/
         5GEw==
X-Gm-Message-State: AOJu0YxdVQsfMJ8ZCS0CZKoG1kqigelNNPWWW9bUmxl8bNaUQlm3Yzql
	14EIyQQNg4r31Y9JyFpPvWdj+QYnopW2D8ITDkhD8taXziWyRE3kvia10Ippr18194wWMUF5jPQ
	nmEEi/Q/7zFqmMRnyfATjbnBg6sqqa6QeUQz+wSfqow9IJV9Z4UD/5Q==
X-Received: by 2002:a05:600c:1c81:b0:42c:b23f:7ba5 with SMTP id 5b1f17b1804b1-42f777b6d2fmr4369345e9.10.1727810938143;
        Tue, 01 Oct 2024 12:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfMz8VPhRfkBGR6aYm+OyZu3gTFPLQZUyrIOSbXfKB9nIGF0xcfYwwpjBTdRkm5mmMXApTHA==
X-Received: by 2002:a05:600c:1c81:b0:42c:b23f:7ba5 with SMTP id 5b1f17b1804b1-42f777b6d2fmr4369205e9.10.1727810937668;
        Tue, 01 Oct 2024 12:28:57 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57423afsm12490327f8f.90.2024.10.01.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:28:57 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:28:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/5] ipv4: Convert ip_route_input_rcu() to dscp_t.
Message-ID: <c4dbb5aa9cbc79c4fcb317abbffa7c7156bc56a7.1727807926.git.gnault@redhat.com>
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

Pass a dscp_t variable to ip_route_input_rcu(), instead of a plain u8,
to prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of ip_route_input_rcu() to consider are:

  * ip_route_input_noref(), which already has a dscp_t variable to pass
    as parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * inet_rtm_getroute(), which receives a u8 from user space and needs
    to convert it with inet_dsfield_to_dscp().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 00bfc0a11f64..a693b57b4111 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2415,7 +2415,8 @@ out:	return err;
 
 /* called with rcu_read_lock held */
 static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			      u8 tos, struct net_device *dev, struct fib_result *res)
+			      dscp_t dscp, struct net_device *dev,
+			      struct fib_result *res)
 {
 	/* Multicast recognition logic is moved from route cache to here.
 	 * The problem was that too many Ethernet cards have broken/missing
@@ -2456,12 +2457,14 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 #endif
 		   ) {
 			err = ip_route_input_mc(skb, daddr, saddr,
-						tos, dev, our);
+						inet_dscp_to_dsfield(dscp),
+						dev, our);
 		}
 		return err;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, tos, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr,
+				   inet_dscp_to_dsfield(dscp), dev, res);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
@@ -2471,8 +2474,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, inet_dscp_to_dsfield(dscp),
-				 dev, &res);
+	err = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
 	return err;
@@ -3286,8 +3288,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		skb->dev	= dev;
 		skb->mark	= mark;
 		err = ip_route_input_rcu(skb, dst, src,
-					 rtm->rtm_tos & INET_DSCP_MASK, dev,
-					 &res);
+					 inet_dsfield_to_dscp(rtm->rtm_tos),
+					 dev, &res);
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.2


