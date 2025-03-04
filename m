Return-Path: <netdev+bounces-171658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED1A4E0BF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8AC189F2F0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB022054FF;
	Tue,  4 Mar 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBd+8Gkd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F831FF1C1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098093; cv=none; b=afeDtcsqeqbMmXuCdizZUJ0aJdhdXQXNY6k59Ie3D+XQkIEE36EeFiNF8hm6lIedp8zsWBSE36ijOXmL2xQGbq+086uRUino9vwmHHLj/xnKg8kFWwb4eN27kxUPOuxcA8uKDyHRvOm3vrF05NMkGMEzq/seOVb2+pDY9NApDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098093; c=relaxed/simple;
	bh=vztZjvqRxMnAnwg98RzbidH7GaYmuzxRS3siARCZUYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1QKMsN1SgkkXUQrFDzuKvGdB5xI9LMIAkhc/najNRPe3B9fUZ1iCOIYJs0tmAzkOK0HO+tSHgEoZEcwTixiGvgj9J9jyr5BlDtWslUOqdgqmLgLetyk+j2/hOE9b4TEuDH5hAaVTNnaTVieh6WPJU17mBRIyVYxMnQ/gZbm+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBd+8Gkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E87C4CEE5;
	Tue,  4 Mar 2025 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098093;
	bh=vztZjvqRxMnAnwg98RzbidH7GaYmuzxRS3siARCZUYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cBd+8GkdUpwHoP27A3V855BlI3ImI1Yq63+gkLLrzs5ys4/EZUBy2slfMfOVi3Wab
	 qqID0lqNvBX5SJK5zzdQLmNPoVd8UHHNObynMcZsodUy/fLoBj5svwchGiHcY7tz1v
	 1vkDE4483cP8V3d1gvSDxbb+EN1/3vxY8e1cnROfQIon2lQIr+ZtQSr/PM8w05smJ9
	 T3IyXM5LufK/5nmiJPkJz2hNQu5ps31FkRDekOc/sq33mDYcW54PYF2ktkv6wXYEAx
	 uD/q0M8/iHSeU3YIe+HVixzoT0Qohz49FTQQJnphBNXvBHUp+q65i4bYiTivssOWli
	 Di4bpM1pZEM+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 15:21:08 +0100
Subject: [PATCH net-next 1/4] net: airoha: Move min/max packet len
 configuration in airoha_dev_open()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-airoha-eth-rx-sg-v1-1-283ebc61120e@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to align max allowed packet size to the configured mtu, move
REG_GDM_LEN_CFG configuration in airoha_dev_open routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ff837168845d6cacf97708b8b9462829162407bd..a9ed3fc2b5195f6b1868e65e1b8c0e5ef99e920f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -138,15 +138,10 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
 
-	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
+	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++)
 		airoha_fe_set(eth, REG_GDM_FWD_CFG(p),
 			      GDM_TCP_CKSUM | GDM_UDP_CKSUM | GDM_IP4_CKSUM |
 			      GDM_DROP_CRC_ERR);
-		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(p),
-			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
-			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
-			      FIELD_PREP(GDM_LONG_LEN_MASK, 4004));
-	}
 
 	airoha_fe_rmw(eth, REG_CDM1_VLAN_CTRL, CDM1_VLAN_MASK,
 		      FIELD_PREP(CDM1_VLAN_MASK, 0x8100));
@@ -1520,9 +1515,9 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 
 static int airoha_dev_open(struct net_device *dev)
 {
+	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
-	int err;
 
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
@@ -1536,6 +1531,11 @@ static int airoha_dev_open(struct net_device *dev)
 		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
+	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
+		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
+		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
+		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);

-- 
2.48.1


