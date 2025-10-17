Return-Path: <netdev+bounces-230389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75732BE76FF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173735090C4
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9A311C19;
	Fri, 17 Oct 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI0h9/PM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A248176;
	Fri, 17 Oct 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692002; cv=none; b=p3W7DTqWjC3MGyq2qWpesJrLhSmINJ0WzyWG3NTYwduDlTh6s9SxpmV89N0oPenVI681HjwhL8WL+zV3BRuelIVLBBmnWY97sPLdslS8vlS71rdvRYnqeAdlN1unh7PUYpCFu71wFfac3Byf99eAj+YiK/JplLSnXETbwQzze2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692002; c=relaxed/simple;
	bh=3mSU+FX9dbIsh1PJOErN1WzsRYXyPLXOJt1QhSHoWGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4EWEq2Qa8tnmRCRTecjyCi7sh9C8G1ZiR1e93Dc++1Zb9/MlirNbk/AnwsS6BKIm2xZ/frWfdIGEtvpo9qA+BcClWfJHf6SqHeykkX9zB7OO9u4pEqT+NuoPuV7OT/gYuJ6tNGzlmsEyyKD2aiHEYecv3xyF7H5qKcUEHcjoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI0h9/PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E225C4CEE7;
	Fri, 17 Oct 2025 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692001;
	bh=3mSU+FX9dbIsh1PJOErN1WzsRYXyPLXOJt1QhSHoWGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GI0h9/PMIzRN/Va/X8T0iAQNSwnaVer99pOwVwggwC2Fi4geBqdSnTiDSqgFUkYTD
	 4+4FR8y/CqJ7x64+cSYSb5lTtxFjLYoOFRbxx6yGihsx1B8OldBS+6eQhjaC2ByK6j
	 kUdYgMKgyVHxjSwCtUaqq6oudNQjTvpfQ9kMW0e1eVQb4S9iRlenE0ZyBqtNZqjbCL
	 v1C37Sk0nhbAmx40ObcJmbQKcMXRCofyFK50GyAoG8beIIevW7TJ0z/TnlmvIiCjjC
	 TZ9SErjGXxEVDNDWsCV/gWSKfxL8TsEIU/kqS8es29RcdUXwlwE0VU7t4xuJCEVGYG
	 AwMAEVl+apMBA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:13 +0200
Subject: [PATCH net-next v3 04/13] net: airoha: Add airoha_eth_soc_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-4-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Introduce airoha_eth_soc_data struct to contain differences between
various SoC. Move XSI reset names in airoha_eth_soc_data. This is a
preliminary patch to enable AN7583 ethernet controller support in
airoha-eth driver.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 42 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h | 17 +++++++++++--
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5825f6f29a92e8fff0596d7883a4c2648432a6ef..c9cebe6752eb524e58cfa30f937372d6d3baea1c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1387,8 +1387,7 @@ static int airoha_hw_init(struct platform_device *pdev,
 	int err, i;
 
 	/* disable xsi */
-	err = reset_control_bulk_assert(ARRAY_SIZE(eth->xsi_rsts),
-					eth->xsi_rsts);
+	err = reset_control_bulk_assert(eth->soc->num_xsi_rsts, eth->xsi_rsts);
 	if (err)
 		return err;
 
@@ -2922,6 +2921,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 static int airoha_probe(struct platform_device *pdev)
 {
+	struct reset_control_bulk_data *xsi_rsts;
 	struct device_node *np;
 	struct airoha_eth *eth;
 	int i, err;
@@ -2930,6 +2930,10 @@ static int airoha_probe(struct platform_device *pdev)
 	if (!eth)
 		return -ENOMEM;
 
+	eth->soc = of_device_get_match_data(&pdev->dev);
+	if (!eth->soc)
+		return -EINVAL;
+
 	eth->dev = &pdev->dev;
 
 	err = dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
@@ -2954,13 +2958,18 @@ static int airoha_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	eth->xsi_rsts[0].id = "xsi-mac";
-	eth->xsi_rsts[1].id = "hsi0-mac";
-	eth->xsi_rsts[2].id = "hsi1-mac";
-	eth->xsi_rsts[3].id = "hsi-mac";
-	eth->xsi_rsts[4].id = "xfp-mac";
+	xsi_rsts = devm_kzalloc(eth->dev,
+				eth->soc->num_xsi_rsts * sizeof(*xsi_rsts),
+				GFP_KERNEL);
+	if (err)
+		return err;
+
+	eth->xsi_rsts = xsi_rsts;
+	for (i = 0; i < eth->soc->num_xsi_rsts; i++)
+		eth->xsi_rsts[i].id = eth->soc->xsi_rsts_names[i];
+
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
-						    ARRAY_SIZE(eth->xsi_rsts),
+						    eth->soc->num_xsi_rsts,
 						    eth->xsi_rsts);
 	if (err) {
 		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
@@ -3048,8 +3057,23 @@ static void airoha_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static const char * const en7581_xsi_rsts_names[] = {
+	"xsi-mac",
+	"hsi0-mac",
+	"hsi1-mac",
+	"hsi-mac",
+	"xfp-mac",
+};
+
+static const struct airoha_eth_soc_data en7581_soc_data = {
+	.version = 0x7581,
+	.xsi_rsts_names = en7581_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
+	.num_ppe = 2,
+};
+
 static const struct of_device_id of_airoha_match[] = {
-	{ .compatible = "airoha,en7581-eth" },
+	{ .compatible = "airoha,en7581-eth", .data = &en7581_soc_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_match);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 1f7e34a5f457ca2200e9c81dd05dc03cd7c5eb77..cb7e198e40eeb2f44bd6e035cc7b583f47441d59 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -21,7 +21,6 @@
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			9216
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
@@ -556,9 +555,18 @@ struct airoha_ppe {
 	struct dentry *debugfs_dir;
 };
 
+struct airoha_eth_soc_data {
+	u16 version;
+	const char * const *xsi_rsts_names;
+	int num_xsi_rsts;
+	int num_ppe;
+};
+
 struct airoha_eth {
 	struct device *dev;
 
+	const struct airoha_eth_soc_data *soc;
+
 	unsigned long state;
 	void __iomem *fe_regs;
 
@@ -568,7 +576,7 @@ struct airoha_eth {
 	struct rhashtable flow_table;
 
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
-	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
+	struct reset_control_bulk_data *xsi_rsts;
 
 	struct net_device *napi_dev;
 
@@ -611,6 +619,11 @@ static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
 	return port->id == 1;
 }
 
+static inline bool airoha_is_7581(struct airoha_eth *eth)
+{
+	return eth->soc->version == 0x7581;
+}
+
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 

-- 
2.51.0


