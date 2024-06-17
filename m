Return-Path: <netdev+bounces-104199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619690B7F6
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A881282E6D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB916DC16;
	Mon, 17 Jun 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4Bq3LOe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720517984
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645062; cv=none; b=JfPOeII5oerI3VKt4Rxx+ak9HYY9NhuSiMbhLaI3fE89ifsPRWTGB08m1NfBgA2gOBZ0D/Kvbl25WPB1MtK4WI92WPjhOJ+1zY0ofJhO00VpDyVTQ9pwGbYy4GvEgzfVM3defu0ZU9dN2tHZaD+II9r4xq6Fh19RdVi05YXcBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645062; c=relaxed/simple;
	bh=MzhSEDPxfaxdDmUQii5diptIm4iMx5LkmGh/k02/ExA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw6pBCkqAlDiZQtYp0wPifb+C/aCqFzOBohmeBlEfcEkFFByuJOarRBN53jXEBSCitEX+aGN+QySODl2/Kp4PgojXhGlCsy0x6O77zAGc0Pc5XPJ/jOXdHptUtbTDsIRDU+WFwgn60g7bpcAc4EepAIR9uoIII66Vra5g1TU42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4Bq3LOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718645058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWtqChJRo/vKwRQIq200bptC+lJDdv6T3aSZWcIpXik=;
	b=b4Bq3LOebAj5XDhnTqKijp/j0VLUxGiqg6TyJT9ALO2pFvqY5US3C2kh9Epkks9vduOphy
	WuChNFIvqb89juSLpicSfgSddH0U64Gqy1o+eCfmh6SMYhz1ZCh8oLAQDbp9kOAxllhdwB
	ceMoCANkj8XrtEvZZ0mb6zXrfwujvtc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-hA-47vQkNYSPQB0Aq267Aw-1; Mon,
 17 Jun 2024 13:24:15 -0400
X-MC-Unique: hA-47vQkNYSPQB0Aq267Aw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 589DA19560AD;
	Mon, 17 Jun 2024 17:24:13 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.18.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6EF71955E80;
	Mon, 17 Jun 2024 17:24:11 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next v2 3/3] net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings
Date: Mon, 17 Jun 2024 13:23:29 -0400
Message-ID: <20240617172329.239819-4-kheib@redhat.com>
In-Reply-To: <20240617172329.239819-3-kheib@redhat.com>
References: <20240617172329.239819-1-kheib@redhat.com>
 <20240617172329.239819-2-kheib@redhat.com>
 <20240617172329.239819-3-kheib@redhat.com>
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
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 52 ++++++-------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index fee02a94ed2f..0606f18e5bbe 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -450,7 +450,6 @@ static void mlx4_en_get_strings(struct net_device *dev,
 				uint32_t stringset, uint8_t *data)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
-	int index = 0;
 	int i, strings = 0;
 	struct bitmap_iterator it;
 
@@ -470,68 +469,51 @@ static void mlx4_en_get_strings(struct net_device *dev,
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


