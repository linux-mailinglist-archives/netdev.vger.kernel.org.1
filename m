Return-Path: <netdev+bounces-148962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21109E3996
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A82823FD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95091B86CC;
	Wed,  4 Dec 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCDAoJaF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727B198A32
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314297; cv=none; b=eAaACTTtM8kdaUrUQfpmENylW1hlmDuj3bQJaALvi9I1A51kpTtCHI6awoz+Dj61LSCw9aZ2o3eSWI9yfJ5Z4aJy5fOTDYm1KP+aLAbrfbSmhvIRdfzOwsPH2hmpHntYP6VsSXzMwLlD5y20ZW4f/84nw4AQCR8AdTYMX3vCkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314297; c=relaxed/simple;
	bh=/jTbBW+dYBEfC+6AnaEjSjg7rywisc/VoKcCooARNBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbK2Mts8617n9Nq6OSm59M7iJT9j8jzYjfn+b3aOvz4CdgDq5MtyUGCPt0M3pOzk9pcpYCmAEY7rrzpt655ST9FdqQ2jU6PSJNR4t21X+nDN91HQkC4PEAUJM2ZzdpYZtBwo5cTwK88ax6eScjGzjoSoNbbRrmDVMAl8qMsctRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCDAoJaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4ge6cuaOCzyq6y/Mmf3pd55HRmk1F2IdM3vKurD5fA=;
	b=SCDAoJaF/oHlFlsaQXF4ufroRtApGxd5wMzfOildyGtXuf8gSF+7jMOipomglNjDySbs1A
	Ly+Gois70h3JPcJIMQZDCsJ3cmHQd37oPM49eNZA32/buD6XWR8DML5KVIJg0NoxJlo+w4
	3BL8dN/LsJxwbLjoDbgjRnRm0FfU9kg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-HbPrUXTUM_-InYxWufiAJQ-1; Wed, 04 Dec 2024 07:11:34 -0500
X-MC-Unique: HbPrUXTUM_-InYxWufiAJQ-1
X-Mimecast-MFC-AGG-ID: HbPrUXTUM_-InYxWufiAJQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385de8e0416so2911770f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314293; x=1733919093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4ge6cuaOCzyq6y/Mmf3pd55HRmk1F2IdM3vKurD5fA=;
        b=dZ1ynhV1n4HqclyFs2TxjyvgHBYBc182LHuF8L8jn/ihUfQZRd61ElgfppsAf5h2/T
         T/JIlI1mEhZ8KrnuxvPZUpfir+IMqnB1kMKfanx3OdfPywsLm7R8Iyz/gPWqcmP8ruzJ
         e+uaexZ9MTiOh5v2PEYhnVX3wSs2J54TtFBRsSzmvIpBLpWD7P18/zi4hMrLICZoFDtM
         VH8GLbLpG610xFUcYWfv3pjeVj3wu6UprLvisJWf2LcVQ1AqwcAu0BZzb+ip7zVby5Th
         16tKjYADdjdskd85O+oAY7v0Z40p87RNrPs6O8k8+yTDzfCPT8exFzm4gds5tDPVPxgY
         tt/A==
X-Gm-Message-State: AOJu0YzO/k7dVXvGQiYmBwKr1ZfetIjv4p4MlYq1krfZ3DmTae4qCS3J
	zdBJtl06dae8wxFwTdPRs6kLbpURUVS7378MROVBNEXge6Jp0jCgAdrtuKmfUAOgE/v1KOMgGPf
	iwJqOiGh/GH//5nSOMHF68LmWphgB4FCkZSGtLu748HTdAJ7Odq2G+A==
X-Gm-Gg: ASbGncuaCJuiJnt8HGT1PiuTMBwym2W2hJeCAH2Vq3HvscGpOipS8npu2Jk33ke5KK1
	0aHIqSpprxhz84cz2MVQKr8cB5CKrhA4nQt0LqPizgWNTGqGpISe51wM+E6azWQxCAhzMcg+ico
	K9S+KUBofIPf/wMN2iRx7l/45HM4qLGaDtKvcJQ+QJsTenUxt4CVPD6oqXZrQpNX91vRYcx7/lC
	l6lfxrDciekzdxt8vxFEpxrhGbjx7ccEPw7yY7PTNMD+SVTqZtczVXhLIaidxReaWgAZ+2TTTTf
	UY+owAu57RZW2xoSnM50LiXSepDtaQ==
X-Received: by 2002:a5d:47a6:0:b0:385:e055:a294 with SMTP id ffacd0b85a97d-385fd55f1b4mr5488954f8f.59.1733314292771;
        Wed, 04 Dec 2024 04:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ3pRJ6SxC276FFNdDqnCVmlV0rydo+wzyfTk5Fv2D6/c80ajIxJY4Px7/U7FofHYxpBFu1Q==
X-Received: by 2002:a5d:47a6:0:b0:385:e055:a294 with SMTP id ffacd0b85a97d-385fd55f1b4mr5488935f8f.59.1733314292463;
        Wed, 04 Dec 2024 04:11:32 -0800 (PST)
Received: from debian (2a01cb058d23d600b242516949266d33.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b242:5169:4926:6d33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ec6a3d8fsm10445640f8f.101.2024.12.04.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:11:31 -0800 (PST)
Date: Wed, 4 Dec 2024 13:11:30 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 3/4] geneve: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <7af5c09f3c26f0f231fbe383822ca5d1ce0278fa.1733313925.git.gnault@redhat.com>
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


