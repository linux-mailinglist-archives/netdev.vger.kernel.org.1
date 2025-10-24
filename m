Return-Path: <netdev+bounces-232631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B77C07736
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523C61C440CF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07B33F8DA;
	Fri, 24 Oct 2025 17:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD441459F7;
	Fri, 24 Oct 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325409; cv=none; b=HRz2iTOByzPIYN9Y/zjI2i58aB6/C7dBWSBAMuDECO6tLRP7MvYNBKRu4/50neDZKYLsDd+jrruLwWxeRN008CBF3XSx8F1EAhZ+tuKO0Ur5IykcByObNyvjv44icwMe0UnAqG6KDqjj8uLw9dreiJpaIDqS/n2FxVqp1rsNFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325409; c=relaxed/simple;
	bh=jZFlenhmt00K9bSWtx1eXsoz+1diM5x6m10Efs9lxSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of5mSPsnIbYNBmw6no9FFXevFh5fKd/dxLt0aN1kURaL0hNs5Pa2GHWO3u7XcSOvblcV6Wfh6ZucWZlqvJZlLOC4GzLfUAPa3G7bYbNiXevPHZzYJPuLP+U9KarS7CLflOHMlnr1HnEkB/KUNZyxbNMdBnMQsfZltZAkSMSrAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLCF-0000000068i-0jIS;
	Fri, 24 Oct 2025 17:03:23 +0000
Date: Fri, 24 Oct 2025 18:03:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 07/13] net: dsa: lantiq_gswip: allow adjusting MII
 delays
Message-ID: <0ae34f08d2cf764ee45d663e6b76e3ce04a14cd2.1761324950.git.daniel@makrotopia.org>
References: <cover.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761324950.git.daniel@makrotopia.org>

Currently the MII clk vs. data delay is configured based on the PHY
interface mode.

In addition to that add support for setting up MII delays using the
standard Device Tree properties 'tx-internal-delay-ps' and
'rx-internal-delay-ps' and only fall back to using the PHY interface
mode in case both properties are unused.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  4 +++
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 30 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 42000954d842..0c32ec85e127 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -82,6 +82,10 @@
 #define GSWIP_MII_PCDU5			0x05
 #define  GSWIP_MII_PCDU_TXDLY_MASK	GENMASK(2, 0)
 #define  GSWIP_MII_PCDU_RXDLY_MASK	GENMASK(9, 7)
+#define  GSWIP_MII_PCDU_TXDLY(x)	u16_encode_bits(((x) / 500), GSWIP_MII_PCDU_TXDLY_MASK)
+#define  GSWIP_MII_PCDU_RXDLY(x)	u16_encode_bits(((x) / 500), GSWIP_MII_PCDU_RXDLY_MASK)
+#define GSWIP_MII_PCDU_RXDLY_DEFAULT	2000 /* picoseconds */
+#define GSWIP_MII_PCDU_TXDLY_DEFAULT	2000 /* picoseconds */
 
 /* GSWIP Core Registers */
 #define GSWIP_SWRES			0x000
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 4cf548319b1b..d5a13a7ee1c1 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -622,6 +622,33 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static bool gswip_mii_delay_setup(struct gswip_priv *priv, struct dsa_port *dp)
+{
+	u32 tx_delay = GSWIP_MII_PCDU_TXDLY_DEFAULT;
+	u32 rx_delay = GSWIP_MII_PCDU_RXDLY_DEFAULT;
+	struct device_node *port_dn = dp->dn;
+	bool used;
+	int ret;
+
+	ret = of_property_read_u32(port_dn, "tx-internal-delay-ps", &tx_delay);
+	if (ret && ret != -EINVAL)
+		return ret;
+	used = !ret;
+
+	ret = of_property_read_u32(port_dn, "rx-internal-delay-ps", &rx_delay);
+	if (ret && ret != -EINVAL)
+		return ret;
+	used |= !ret;
+
+	if (used)
+		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
+					  GSWIP_MII_PCDU_RXDLY_MASK,
+					  GSWIP_MII_PCDU_TXDLY(tx_delay) |
+					  GSWIP_MII_PCDU_RXDLY(rx_delay), dp->index);
+
+	return used;
+}
+
 static int gswip_setup(struct dsa_switch *ds)
 {
 	unsigned int cpu_ports = dsa_cpu_ports(ds);
@@ -1419,6 +1446,9 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
 			   GSWIP_MII_CFG_RGMII_IBS | GSWIP_MII_CFG_LDCLKDIS,
 			   miicfg, port);
 
+	if (gswip_mii_delay_setup(priv, dp))
+		return;
+
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
-- 
2.51.0

