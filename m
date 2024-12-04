Return-Path: <netdev+bounces-148963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A509E39B5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B96B2E518
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9B1B87CF;
	Wed,  4 Dec 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqmZzBd9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFC1B87C6
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314299; cv=none; b=o1ZVpBPp9DHbXHPGGsIl+EiDxO6AnDg69Ru7nq5MW+4sptEjwxlx1CMqCznW3oEnqZWX3uZcLyctQWbqwcZCmzZw6eZ1GNugIJ2YwN+HeK+Gu3z1HVzQmnlZLuqJuxKUcnxdFqdczXAJqrhjHfXATH0ylzc0AVr0FBn4ERhyMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314299; c=relaxed/simple;
	bh=8imndJXJX33hJtetZZiHeDN05pdqdgmsj6JDHEhLiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrTaSNLDs6g8wYHRIe3Uk0kBZ1aXDTlZsM4CsrihAegzdNpG7CZzyToFj0/CKTRXs+3jfrlc/FpCi23zlQGLHTxJANaSsWH1YJcpwz6j/4SJyHmNluLQgBA2LAZDz9JxcFvvgT8jxxKWrjM2moeeIGj5i/uJGf2QGGjhC5IkaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqmZzBd9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EboEf2/84XUCd54dCRY7yzh8509sOYchgZiYAwfhqyY=;
	b=eqmZzBd9e9AP8a0pre/kjdpceoc0Sj4T7C8uhv+afnBH2Cc5QvWRzqBoDJ6qR6v628JfPB
	RCyw8Kx27jEoPfhPB2bLaXChbOH4Ogb2zJ+1EoYlMEmDp0dvoorj0DRU/OxjhPM6qAEn/v
	ad6DX9IbbW13t6wR6OFGJcaNE28FXu0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-tJmAIkOdPdSTJA34pFjW9g-1; Wed, 04 Dec 2024 07:11:36 -0500
X-MC-Unique: tJmAIkOdPdSTJA34pFjW9g-1
X-Mimecast-MFC-AGG-ID: tJmAIkOdPdSTJA34pFjW9g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d0582ad3so5112684f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314295; x=1733919095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EboEf2/84XUCd54dCRY7yzh8509sOYchgZiYAwfhqyY=;
        b=TEWNf2VXNCbFPR1iMDcTPKHwqTJ5DMGPFBfVQjtzojyUEMhC0ti9fXgHclodctFoOv
         1FrwzgtIWlxsNETEVpGfSrwFLDPb1jKbNIarP5T29tz6PA1O8DFiJ8VPalzJR8ZTpKgX
         Z5A+qID+EZhP8uDftwGjcD1Td+5246xw4kdXp15XsVpAfFi8M2mKVOtpdve5bxTGMPhS
         2c6vI+jCHwGw87yFDcPqw9mVKW5VIm+oZWKLjZK42BRkFvpPGOJCYFP9oLbdI2VNd43j
         c2QQVxZ6cccGK76ZrYLCBjmzz7vOfT5/fTygVep4mz/95l7Z3K1nFBHPA/iTTagLpy90
         PqdQ==
X-Gm-Message-State: AOJu0Yz5Ac2QJMWfIXn9/N2CTlo7GA9LflQr7ZfdWDxFdauKEqlWm7dE
	vnvWVmww+UU2P/oRutIGoqtnQR1kOYIox73OkoEdIsHZ/d2xo0vu9y0N5/BOWCQH7khd3sfBZxr
	ONSSm6ySNV8Xs+vmJ685i8PmJYCTt9Wt/ZjozE3Z3iUEXaBE/gdmFlA==
X-Gm-Gg: ASbGnct5TKgGP9AoYtIvgOIIG5Y1tJyoVl2TExZ092mcd14wLkMGmoh+Rw6WZ2S3Lfa
	gvmNDZiat+OueFToZGXmATIDN2drYdNcEBJESpcG6ITIaGEwfhWb3lHXJPWZ6qnT9q25yufytfE
	DoDFosfzhEtSdB/ezIgrAjR/cpVdZlrvHvFFt+1ycMeODfCtHQ0j8Uk5KaGcXawW00QYqU9c3hf
	5VHoTeeACYzav67e5rfTIi5NMX+yDai4sVDeXxoQDZtiEIjoHcEL3Gkl/XCC1VYbpsOG0JxpWAi
	SSw8f9WxnXAAZeln3qNXvRybydxbzw==
X-Received: by 2002:a5d:5888:0:b0:385:ded5:86ee with SMTP id ffacd0b85a97d-385fd43c326mr5438070f8f.57.1733314295373;
        Wed, 04 Dec 2024 04:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc4hQfXi1BdXQ6I3rtpxEZvHty0dvkEiTskKqecwSD3udUXDWz/G+P1A0U2I7+zW0Q5T9UJg==
X-Received: by 2002:a5d:5888:0:b0:385:ded5:86ee with SMTP id ffacd0b85a97d-385fd43c326mr5438048f8f.57.1733314295074;
        Wed, 04 Dec 2024 04:11:35 -0800 (PST)
Received: from debian (2a01cb058d23d600b242516949266d33.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b242:5169:4926:6d33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52a6aa9sm22325855e9.33.2024.12.04.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:11:34 -0800 (PST)
Date: Wed, 4 Dec 2024 13:11:32 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 4/4] bareudp: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <0f4f8448db3ff449ac6e939872b28cf3f8982da7.1733313925.git.gnault@redhat.com>
References: <cover.1733313925.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733313925.git.gnault@redhat.com>

Bareudp uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX
packet counters. It was also recently converted to use the device core
stats (dev_core_stats_*()) for RX and TX drops (see commit 788d5d655bc9
("bareudp: Use pcpu stats to update rx_dropped counter.")).

Since core stats are to be avoided in drivers, and for consistency with
VXLAN and Geneve, let's convert packet stats handling to DSTATS, which
can handle RX/TX stats and packet drops. Statistics that don't fit
DSTATS are still updated atomically with DEV_STATS_INC().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/bareudp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index a2abfade82dd..70814303aab8 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -84,7 +84,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 		if (skb_copy_bits(skb, BAREUDP_BASE_HLEN, &ipversion,
 				  sizeof(ipversion))) {
-			dev_core_stats_rx_dropped_inc(bareudp->dev);
+			dev_dstats_rx_dropped(bareudp->dev);
 			goto drop;
 		}
 		ipversion >>= 4;
@@ -94,7 +94,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		} else if (ipversion == 6 && bareudp->multi_proto_mode) {
 			proto = htons(ETH_P_IPV6);
 		} else {
-			dev_core_stats_rx_dropped_inc(bareudp->dev);
+			dev_dstats_rx_dropped(bareudp->dev);
 			goto drop;
 		}
 	} else if (bareudp->ethertype == htons(ETH_P_MPLS_UC)) {
@@ -108,7 +108,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   ipv4_is_multicast(tunnel_hdr->daddr)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				dev_core_stats_rx_dropped_inc(bareudp->dev);
+				dev_dstats_rx_dropped(bareudp->dev);
 				goto drop;
 			}
 		} else {
@@ -124,7 +124,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   (addr_type & IPV6_ADDR_MULTICAST)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				dev_core_stats_rx_dropped_inc(bareudp->dev);
+				dev_dstats_rx_dropped(bareudp->dev);
 				goto drop;
 			}
 		}
@@ -136,7 +136,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				 proto,
 				 !net_eq(bareudp->net,
 				 dev_net(bareudp->dev)))) {
-		dev_core_stats_rx_dropped_inc(bareudp->dev);
+		dev_dstats_rx_dropped(bareudp->dev);
 		goto drop;
 	}
 
@@ -144,7 +144,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	tun_dst = udp_tun_rx_dst(skb, family, key, 0, 0);
 	if (!tun_dst) {
-		dev_core_stats_rx_dropped_inc(bareudp->dev);
+		dev_dstats_rx_dropped(bareudp->dev);
 		goto drop;
 	}
 	skb_dst_set(skb, &tun_dst->dst);
@@ -194,7 +194,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	len = skb->len;
 	err = gro_cells_receive(&bareudp->gro_cells, skb);
 	if (likely(err == NET_RX_SUCCESS))
-		dev_sw_netstats_rx_add(bareudp->dev, len);
+		dev_dstats_rx_add(bareudp->dev, len);
 
 	return 0;
 drop:
@@ -589,7 +589,7 @@ static void bareudp_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->lltx = true;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 }
 
 static int bareudp_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.39.2


