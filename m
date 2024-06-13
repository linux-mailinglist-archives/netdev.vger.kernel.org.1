Return-Path: <netdev+bounces-103362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D5907BB0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA900282CDD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C7714BF8B;
	Thu, 13 Jun 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz534wXD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343914B061
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304243; cv=none; b=UKEnJo2pxrjxmC9GJwyxeJVXbMN68ooY02dsbYcOwgva8M+fXBUgLtcCVw9pXzwo7CONidzCsBGFQx5zwo5v7Czkyf5U3ySmly6QRSCV7AX68UQksz5Lh70wvXG0EOTG+wVOzAwp0A5/UHJcviiIu5i/vk8urYx8dwedY1qUKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304243; c=relaxed/simple;
	bh=XEWm/bvUfEA5ekymaDircRaEorzJ1u5LM3/V12aO5T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZi0ebvn7b0DPRpa4cPzIfgi33Rlp1Vuc6hQaFgeLNHGCESm9NhfERYdFWi4O0pR15FstI6uhEZ//gKoakSKufjPHPyKEK1xgfUCA2f1zeEncPT6ky7yP2ixA+rM0u+1DUwAyEph5aQUTf6mijtJkXBU4jTa9CKe4gDqNM2dYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dz534wXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718304240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qch9sKQ8h+lyIFMqPXGU/IPJTZ07MIxHUqPZoVcEKRc=;
	b=dz534wXDTs75U48HI+lG0F8HU1IM2RfzcxdgLGeCo8uKyrOyh7D818Pmk6jEOTvNKBRdfq
	eIO5Mg8PnKIQEsHN7GC3gvfElGaDen61Y7ehcdmoQQ/Or8p8CM8DFBWHGW5riA9kEUaWVe
	PLwhnlW09FFfQZDeurX/hklGb2YAe4A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-pk4wCOjDMiG2t2Hixe1F1w-1; Thu,
 13 Jun 2024 14:43:56 -0400
X-MC-Unique: pk4wCOjDMiG2t2Hixe1F1w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3569719560B6;
	Thu, 13 Jun 2024 18:43:55 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.17.127])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F06C31955E82;
	Thu, 13 Jun 2024 18:43:53 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next 3/3] net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings
Date: Thu, 13 Jun 2024 14:43:33 -0400
Message-ID: <20240613184333.1126275-4-kheib@redhat.com>
In-Reply-To: <20240613184333.1126275-3-kheib@redhat.com>
References: <20240613184333.1126275-1-kheib@redhat.com>
 <20240613184333.1126275-2-kheib@redhat.com>
 <20240613184333.1126275-3-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the ethtool_puts/ethtool_sprintf helper to print the stats strings
into the ethtool strings interface.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 51 +++++++------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index fee02a94ed2f..9516f64f388e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -470,68 +470,51 @@ static void mlx4_en_get_strings(struct net_device *dev,
 		for (i = 0; i < NUM_MAIN_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_PORT_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_PF_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_FLOW_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_PKT_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_XDP_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < NUM_PHY_STATS; i++, strings++,
 		     bitmap_iterator_inc(&it))
 			if (bitmap_iterator_test(&it))
-				strcpy(data + (index++) * ETH_GSTRING_LEN,
-				       main_strings[strings]);
+				ethtool_puts(&data, main_strings[strings]);
 
 		for (i = 0; i < priv->tx_ring_num[TX]; i++) {
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"tx%d_packets", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"tx%d_bytes", i);
+			ethtool_sprintf(&data, "tx%d_packets", i);
+			ethtool_sprintf(&data, "tx%d_bytes", i);
 		}
 		for (i = 0; i < priv->rx_ring_num; i++) {
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_packets", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_bytes", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_dropped", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_xdp_drop", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_xdp_redirect", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_xdp_redirect_fail", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_xdp_tx", i);
-			sprintf(data + (index++) * ETH_GSTRING_LEN,
-				"rx%d_xdp_tx_full", i);
+			ethtool_sprintf(&data, "rx%d_packets", i);
+			ethtool_sprintf(&data, "rx%d_bytes", i);
+			ethtool_sprintf(&data, "rx%d_dropped", i);
+			ethtool_sprintf(&data, "rx%d_xdp_drop", i);
+			ethtool_sprintf(&data, "rx%d_xdp_redirect", i);
+			ethtool_sprintf(&data, "rx%d_xdp_redirect_fail", i);
+			ethtool_sprintf(&data, "rx%d_xdp_tx", i);
+			ethtool_sprintf(&data, "rx%d_xdp_tx_full", i);
 		}
 		break;
 	case ETH_SS_PRIV_FLAGS:
-- 
2.45.2


