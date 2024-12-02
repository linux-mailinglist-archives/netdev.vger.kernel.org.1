Return-Path: <netdev+bounces-148231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8B9E0E1D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C48282105
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5991DF265;
	Mon,  2 Dec 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3JZdo1u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F47185939
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176145; cv=none; b=oSVG4z1WbTxWYZppzXaVzg/HA1LCVaOGDiW88mzevA/0bjUFjtKQIScoanOdXL4njPKYK0vpNRK/duOcy9DxqUUOl5jDI0Y0B5mwV1SrL5nhU1yE4UAoukKE52tZ8vmfr3s/VG7A1lqR0loPEOpImVF2dBSiHCvzqP83aGoUk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176145; c=relaxed/simple;
	bh=/jTbBW+dYBEfC+6AnaEjSjg7rywisc/VoKcCooARNBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFzei6CKT7PfjEsIQg7CulcTUBdQun1LeFUxUNnSijbExETPgapyBY3GjDyOR2bP7FwpZyPOknECUkiMgabT0XgR+nbYMECSBpklaNwpY/z0LXiUsOASeRpZFxyhYTMCNjdsBOv2nnWZwRS0yOXyKG4Fh9fpGOVQeeOW1LO29dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3JZdo1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733176143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4ge6cuaOCzyq6y/Mmf3pd55HRmk1F2IdM3vKurD5fA=;
	b=X3JZdo1uJ7qqYAHHQlgwNT3sY8329O2+pgy4knrbkl+jjxxiZpLlz/LM5EpsMr8YWFOak/
	bQfEsCKjMfw31RFyVtXkgDVFcaryrCaUzRHuHuC+Cznmb/ZZbpV/dz16nwlql+2Q2vy+iD
	vQj91OMRUO52ks/n919fxXskpA9aaZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-PXD0-WlDPrmHec05BN5tEg-1; Mon, 02 Dec 2024 16:48:59 -0500
X-MC-Unique: PXD0-WlDPrmHec05BN5tEg-1
X-Mimecast-MFC-AGG-ID: PXD0-WlDPrmHec05BN5tEg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434996c1aa7so35462185e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176138; x=1733780938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4ge6cuaOCzyq6y/Mmf3pd55HRmk1F2IdM3vKurD5fA=;
        b=pKWc8PmdRyDZow1e+ofTAPl/TGkaqG/XJXQPwwj/WXGNFZ+0kMdzy7/xUkCoattrNw
         SNR+A/lFb+fV7zqYedKelcwSTvylrb6m4jy816pGJOwtUZIv23HPepsKYAF5Z5Zxir5j
         IQg3GZTOYXakKj8dFrimjWw7LS9DRBA36+4qUwrO99h6linnzasDibJV8rCYYjBa6Zry
         WzxqhbBnXvI4UNijqJd3Q6fPkNVEhhLFzoOfqc+yEslkFvPBD35sm6nQQbl5oN5tu7hq
         MrPQ1GYDH2cDxZ5eeUFOGh9gmraxD0QnPfuxJ3R6QZpnKgolmXVLB1J3nLzxgAq6Tmtp
         1DKg==
X-Gm-Message-State: AOJu0Yy/3Bx8uxhZkHKNAnVUiIDUH1Orc6ZPusyK68uYGIr73UcKxVI1
	BkszKk24wKF5uQtMY3rcVSrz4wsTz7W5uhHIplpnCMuV+ZoM1PGZEyVWiNFFc9nx5E8DPh8hhik
	MIjjcpy8xQqqTKf5tJvZVt5XuIa2rAdLEG60FmOadhTzx0x4ZShHgsQ==
X-Gm-Gg: ASbGncsLpD97NTsz4/7RgSZBjSSHYOa3L1haRDyx/YAAmkMTzfUq6vdBjvdSxnIxWfA
	2ZmiEtWR2581hwpb4W19+PpcWrn5fEecAufQNM+NpgoRw6mGzy2PyokiFdVKf+r0ikLDDXUZPgR
	LL+JyCKdchEGtFrafDQWp+PeQ+s2SQwdKrVKN8eTW5Kg1nuFx0cUULwIS7ws4fj4pyfe2fNq0BI
	WbZx4shPU9S9JprY8fFMxjMXNYKOE95Wv7zlvMSdPsFCYqq6jEdUcSScjux1xer16nzcLgDMQq3
	A50Zap2u/hgI3Oqm8VFz4nYteXfa/A==
X-Received: by 2002:a05:600c:3aca:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-434d0a23a76mr246315e9.30.1733176138401;
        Mon, 02 Dec 2024 13:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwi4pPPsOKbkWIJjM4sUla3Vwtkhh6iLDEgdf5G8IdOIqedcL9//9n/BthRAGFCTViWz8EOg==
X-Received: by 2002:a05:600c:3aca:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-434d0a23a76mr246185e9.30.1733176138026;
        Mon, 02 Dec 2024 13:48:58 -0800 (PST)
Received: from debian (2a01cb058d23d6001797ea6ce8a6dfab.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1797:ea6c:e8a6:dfab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm164399175e9.39.2024.12.02.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:48:57 -0800 (PST)
Date: Mon, 2 Dec 2024 22:48:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 3/4] geneve: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <d45ccc778f7d264fb95a5f90e8709661b88b151d.1733175419.git.gnault@redhat.com>
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

Geneve uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX
packet counters. All other counters are handled using atomic increments
with DEV_STATS_INC().

Let's convert packet stats handling to DSTATS, which has a per-cpu
counter for packet drops too, to avoid the cost of atomic increments
in these cases. Statistics that don't fit DSTATS are still updated
atomically with DEV_STATS_INC().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/geneve.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2f29b1386b1c..d927737010cf 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -235,7 +235,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 					 vni_to_tunnel_id(gnvh->vni),
 					 gnvh->opt_len * 4);
 		if (!tun_dst) {
-			DEV_STATS_INC(geneve->dev, rx_dropped);
+			dev_dstats_rx_dropped(geneve->dev);
 			goto drop;
 		}
 		/* Update tunnel dst according to Geneve options. */
@@ -322,7 +322,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	len = skb->len;
 	err = gro_cells_receive(&geneve->gro_cells, skb);
 	if (likely(err == NET_RX_SUCCESS))
-		dev_sw_netstats_rx_add(geneve->dev, len);
+		dev_dstats_rx_add(geneve->dev, len);
 
 	return;
 drop:
@@ -387,14 +387,14 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely((!geneve->cfg.inner_proto_inherit &&
 		      inner_proto != htons(ETH_P_TEB)))) {
-		DEV_STATS_INC(geneve->dev, rx_dropped);
+		dev_dstats_rx_dropped(geneve->dev);
 		goto drop;
 	}
 
 	opts_len = geneveh->opt_len * 4;
 	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len, inner_proto,
 				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
-		DEV_STATS_INC(geneve->dev, rx_dropped);
+		dev_dstats_rx_dropped(geneve->dev);
 		goto drop;
 	}
 
@@ -1023,7 +1023,7 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
 			dev_kfree_skb(skb);
-			DEV_STATS_INC(dev, tx_dropped);
+			dev_dstats_tx_dropped(dev);
 			return NETDEV_TX_OK;
 		}
 	} else {
@@ -1202,7 +1202,7 @@ static void geneve_setup(struct net_device *dev)
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
 
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	/* MTU range: 68 - (something less than 65535) */
 	dev->min_mtu = ETH_MIN_MTU;
 	/* The max_mtu calculation does not take account of GENEVE
-- 
2.39.2


