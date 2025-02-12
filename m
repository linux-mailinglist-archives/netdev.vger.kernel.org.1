Return-Path: <netdev+bounces-165428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA2A31F7C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BA73A53D7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A941FDE29;
	Wed, 12 Feb 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS47+CZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FE1FBCB3
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343139; cv=none; b=XZZMFbggDofvahcljSSpX8g42ReCS9d2gerE83QS8UOd/YmXuxxHPeuWQabcSYEx2SkCaWKVtRsBn4Mb961c4B2svhVI+l30UlfN93WzdUt0CU8DOj/2YOt8x+x+qdseq007WMQ0bXRoDh9OSL8rJA3KxMbcD1uGtqDg4pjh6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343139; c=relaxed/simple;
	bh=oNuvzrX0ScmnFLsPRD7UuqsTQ2lVnZz8AOiY3gY+NZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/rSEkYqGTvkP5BDPXYzBNKHuRGFU8lBztIt0N5cpOE6Qu9EwVJ00qbVtfFzDrimTv0pYnZOqZ4uMmMa4nVyZaqUnng/A9M/nFU995YzymjmS5RakH/G6cAP3k5vowDYtnqSKZpPcSK7vDJSEfx2aHI6eGHOWGcOwdWgnOCNMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS47+CZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40045C4CEDF;
	Wed, 12 Feb 2025 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739343136;
	bh=oNuvzrX0ScmnFLsPRD7UuqsTQ2lVnZz8AOiY3gY+NZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iS47+CZiIjvI+nlWbAE37Zd4ChrRWym+nToPuDtYNeXBfYWg9VqhmNOAH9jCRQbSv
	 Novnyz7ViJoZUlQ0J1QHdgMyXB3vsi/6ortYFNBSG6LWN8hvNnjSCWVCt7MB5xvI7r
	 t1zS8VU7ZdQXHuY/5OF23qrcspKRzcEsmwS7LXWJqXYx/yDR1ib7LZE/hp7d9WJ45q
	 1hemK6W6LWcSfMQg8wx+Q4uhbRF+gunxJpTky0uk40oVB4hFqM2ckK6mKuiUqSIqvk
	 WzcbPFZ3tPMm0RqSCB1X2Mc94+gUJPfFUbGTVw6XoxuckB+RPqYehi9hQ8c5PzhI4p
	 QeLWoVWnmCzrg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Feb 2025 07:51:48 +0100
Subject: [PATCH net-next 2/2] net: airoha: Enable TSO/Scatter Gather for
 LAN port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-airoha-fix-tso-v1-2-1652558a79b4@kernel.org>
References: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
In-Reply-To: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Set net_device vlan_features in order to enable TSO and Scatter Gather
for DSA user ports.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index aa5f220ddbcf9ca5bee1173114294cb3aec701c9..321e5d15198c5ec6a0764be418aa447e8d9e4512 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -3188,6 +3188,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 			   NETIF_F_SG | NETIF_F_TSO |
 			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
+	dev->vlan_features = dev->hw_features;
 	dev->dev.of_node = np;
 	dev->irq = qdma->irq;
 	SET_NETDEV_DEV(dev, eth->dev);

-- 
2.48.1


