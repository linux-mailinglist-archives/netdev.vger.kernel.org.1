Return-Path: <netdev+bounces-217084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB03B37537
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C901F7C3E65
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5D2D7DD0;
	Tue, 26 Aug 2025 23:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DB2BE056;
	Tue, 26 Aug 2025 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249585; cv=none; b=RepDNhgjcLifmohIuuiSlPfryjdT0g/9WHBLMSS5Qq3d4+R6ZgCYX/JtKX0hQGy9vlTxedGf+SNMqxaPKbB9TklEX/oZ/zMPWduq5C1m+1EkEDsckIT++JHcBT96vUlueGbxWgRmjZYrQS/hhnkth+8/hg2SLK8A4ahEAxlpFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249585; c=relaxed/simple;
	bh=lilULB5ZXKPnWyrM03ch+Go3uRCUpl9ACWNoaZOFiVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOJn2ciPU+f/RQZK3lTzLr87BtjEgeeWM0dLya00HEJtOZAgSFCWYj3Mpaas1ztGcdAdPGu29p0GLmeKiNw4Na+IZHKVc9w9HAQoeh5FCNzX9JhJjOlHkOWnWckYdqTKz5/w4yBFkahF0Rp4eRNxp+pMtG/5QdenQoHQ+HzkLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ur2k6-000000001tZ-0hLj;
	Tue, 26 Aug 2025 23:06:18 +0000
Date: Wed, 27 Aug 2025 00:06:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 4/6] net: dsa: lantiq_gswip: support offset of
 MII registers
Message-ID: <8cb10636ec71e0a237d7132685884ce885f14bb5.1756228750.git.daniel@makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756228750.git.daniel@makrotopia.org>

The MaxLinear GSW1xx family got a single (R)(G)MII port at index 5 but
the registers MII_PCDU and MII_CFG are those of port 0.
Allow applying an offset for the port index to access those registers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 12 ++++++++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 3e2a54569828..64e378852284 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -183,21 +183,29 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
+	int reg_port;
+
 	/* MII_CFG register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(reg_port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	int reg_port;
+
 	/* MII_PCDU register only exists for MII ports */
 	if (!(priv->hw_info->mii_ports & BIT(port)))
 		return;
 
-	switch (port) {
+	reg_port = port + priv->hw_info->mii_port_reg_offset;
+
+	switch (reg_port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
 		break;
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 19bbe6fddf04..2df9c8e8cfd0 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -233,6 +233,7 @@ struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
 	unsigned int mii_ports;
+	int mii_port_reg_offset;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
-- 
2.51.0

