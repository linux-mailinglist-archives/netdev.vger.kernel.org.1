Return-Path: <netdev+bounces-232826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C06C09203
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC874E83E5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C52FFF98;
	Sat, 25 Oct 2025 14:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E42FFF92;
	Sat, 25 Oct 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403798; cv=none; b=HfaBL+dIDprvL50LPxINJbUj/Tb0HG0dn7ShpBMTw9IhRWTBkA1N0yNp7afFWiUjqzX5/2eGdYE311MFwmicoxwkLy78ftK9kVCyqJDQAqe6E1YqSDBNtbU6xnTdXK77/flLtjgYESm1zmYncvv02OjOeRYSXX8GcKmn6pPwcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403798; c=relaxed/simple;
	bh=h/5WK388+QyX4y4F7C/GaLklOiqWSAeuaitnMMjH+iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXh74rFgUZuFxKIf6quCDNxVLVMrHfxoxrRQ9m8MfrU85pq5Ff1HaHnbt2qcLwWpB+6xGR9kHwgrItW+7e3IUbFr9xL8ueGizN2TLIJUQykpA/aeXQt/ydV4SAFwAUIRvJUIqYioswLHgZT7y5dVWBbVRQt7KVYahCZuYFtnd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCfaZ-000000001d8-3voX;
	Sat, 25 Oct 2025 14:49:52 +0000
Date: Sat, 25 Oct 2025 15:49:42 +0100
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
Subject: [PATCH net-next v2 07/13] net: dsa: lantiq_gswip: allow adjusting
 MII delays
Message-ID: <02098c3305529392d9fa7b5615cab2bdd02789c4.1761402873.git.daniel@makrotopia.org>
References: <cover.1761402873.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761402873.git.daniel@makrotopia.org>

Currently the MII clk vs. data delay is configured based on the PHY
interface mode.

In addition to that add support for setting up MII delays using the
standard Device Tree properties 'tx-internal-delay-ps' and
'rx-internal-delay-ps' and only fall back to using the PHY interface
mode in case both properties are unused.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  4 +++
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 31 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

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
index 94b187899db6..60a83093cd10 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -622,6 +622,34 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
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
+					  GSWIP_MII_PCDU_RXDLY(rx_delay),
+					  dp->index);
+
+	return used;
+}
+
 static int gswip_setup(struct dsa_switch *ds)
 {
 	unsigned int cpu_ports = dsa_cpu_ports(ds);
@@ -1419,6 +1447,9 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
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

