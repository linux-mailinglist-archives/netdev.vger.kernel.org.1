Return-Path: <netdev+bounces-148232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEA9E0E1E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652F628238F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840951DF747;
	Mon,  2 Dec 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9bQUHLj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD81DF721
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176147; cv=none; b=N/KRRMGZYWmWpRalFAIVSB5w6gmqFDKZbfs4hQQHoPl8hoSDQerZRy6uMzNI9nKd9SMWFM0X8gsZ8LpRpasfDLs5OOHMrwTUSSDuJ4m3Og060vPI9tE00DavkN4+aVNtJSgjYhWTf+b0w1Y4iWFXJoxX84LuJbfwY5l2h/cLSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176147; c=relaxed/simple;
	bh=8imndJXJX33hJtetZZiHeDN05pdqdgmsj6JDHEhLiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seWCtkFjB6qm2pwbhL04RkQAu4aYhm7tCfhkHYy4iFcKoPWQJdoarww7bQjIiSw7b6p6v0fWLhsc2TeMVw9screNqhmtK8bM5a1wp4sLbr2p3gLkCr1PRn8dI6XJXtl0CyPAMBmuX/zVuL/iv69VTssYaunYz6yOf+eT1+Z1xE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9bQUHLj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733176145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EboEf2/84XUCd54dCRY7yzh8509sOYchgZiYAwfhqyY=;
	b=W9bQUHLjGgwKPDZM0NKJ5fpFFEOY1gQGwBX4gtsVobRJ2Y5iflU9l+MU64ZjzcCtVF9jIJ
	xvRrG6Xy7f2AKHHsEHMRurjKcHbowRYt5iz3W0U5cYXqZk5LDKBhvqRgmQ5fw4ayE2zcK3
	JUqGIOjFnQXIVYzHaSTehjVV6kInpOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-M_h6KJyGOuW_b9Lg2paxVw-1; Mon, 02 Dec 2024 16:49:03 -0500
X-MC-Unique: M_h6KJyGOuW_b9Lg2paxVw-1
X-Mimecast-MFC-AGG-ID: M_h6KJyGOuW_b9Lg2paxVw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a467e970so33296175e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176142; x=1733780942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EboEf2/84XUCd54dCRY7yzh8509sOYchgZiYAwfhqyY=;
        b=CCHlk+KfLZfZldXFI/aN68cX5ehz2zJk7N/wA9m3pgVJOTzYV19dviuFh1tGVCB3Fx
         nh2LD0bcZ+iKTMESe7ZA23gsjWPaDkgCq4i4hWhODTrhaFUKlT0rqlrZTdU5GgyXdnuL
         8Wsi+0M5vEij2fwyVJqWygpLgR64Sc0E3HOetFaF0gBYcSz9DUlmE0qpVkvu79cRE9/q
         /wlgyl369jmB37MC6YsrDrYjMjckHUH6e8ySCwxiWWg9G7ZcgaZTTX8+RYh0zCLEpQMf
         bx94M6okakqVdOYYamREKXAo6FehtviT3V9lGBdgSRwAL8LPgf7e4dAi8SM8noEHkzsJ
         7tZA==
X-Gm-Message-State: AOJu0YwtVqJYIq75eqNKBy9VN8v9hLgRMfGI/EV9nqpE7jiR+0VLC/PO
	DCA3dQj4GUVIwDDHleOJZZGs3Zge4ibgOtT5aSDMatUw7n7xcZ3Bl83Eh3n4JQAbTDE7CdLbybP
	vHjsoBBLIfpyUZZ2+IZMr+qc3fyw8MNs165u5g/QvzvNTTJDT+9XfnIhfNR5i2Q==
X-Gm-Gg: ASbGncskEV5/c1WTT+JF9UAj0Q6uTRVMEf80g930S1jZskwal1OxAKxaWjp4YwyW+OW
	zQFhi1pisNklUzQguYqb8NBhSxwZV52du8UxpeS1r3sbsMI2Tv5fNlO9BUVJW7rLrV/p6Zl6iGO
	sKe6rpmaTdjhR21NLrxf2kwKkSkj1di9u2ZilGaUuLugFaxbbF1qfsMDjGByXRym2Vj4Jy+7lHY
	s0CPmJZkpAf5rBaso5oU4HX9otVART3TKP1KY/HuViKTrdHLDQUPKQivJMp0bXfIMswfkRcStgA
	3fKaBfq/dXcIIMxjAUd+VEGynIICmw==
X-Received: by 2002:a05:600c:1390:b0:434:a71f:f804 with SMTP id 5b1f17b1804b1-434d09a8e13mr514385e9.3.1733176141830;
        Mon, 02 Dec 2024 13:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCCidU69+dKT6hCtBKNN8rI/qHWtIiOLHg/Lt8Rqvwd+f3+bg3f6fSvP5j8PD46O+DkwvB9g==
X-Received: by 2002:a05:600c:1390:b0:434:a71f:f804 with SMTP id 5b1f17b1804b1-434d09a8e13mr514185e9.3.1733176141432;
        Mon, 02 Dec 2024 13:49:01 -0800 (PST)
Received: from debian (2a01cb058d23d6001797ea6ce8a6dfab.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1797:ea6c:e8a6:dfab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm197019205e9.32.2024.12.02.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:49:00 -0800 (PST)
Date: Mon, 2 Dec 2024 22:48:59 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 4/4] bareudp: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <37867f0b8dfecd92ddb36ff3711a27a35a93b5ba.1733175419.git.gnault@redhat.com>
References: <cover.1733175419.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733175419.git.gnault@redhat.com>

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


