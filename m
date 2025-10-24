Return-Path: <netdev+bounces-232625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B45C076E8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E0F4EB519
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2133F8C0;
	Fri, 24 Oct 2025 17:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96F33F8B2;
	Fri, 24 Oct 2025 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325318; cv=none; b=Zy3f8D9lfL9jKmkwP0fepDmZDEMSRUaiAlhpjnN9NMChiBkwvpQcFopGd1YRpCd1x4UMBI3W8DZnMY/joI4LFDuwmz0Lnei4soYCqyUh1mVRDi97HwoEOR/uzTN7feG738Xe4eU9AHlroI6RvzKOLgqw59ao13njSdrQ0RORfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325318; c=relaxed/simple;
	bh=j9bU/vJX3Go9I6Yk1ar2hQ++QSAeFDxaVJUXvGtJ2SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBSEyDTCpNayDfuvtTWlpZqghilFD2pJkY/BlI91UYMcPzUBWJo0stflb0K9PnNHC/GuuANmskxQBaJI82EtxvMmDyV4MZ5UUUbAoGckAMI7pQf9HXJXFmAlpW1i0A7OX40jEGIocN+AIdi1ba+etxZggf64pEwoyKHyT58IJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLAm-0000000066C-1kWN;
	Fri, 24 Oct 2025 17:01:52 +0000
Date: Fri, 24 Oct 2025 18:01:40 +0100
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
Subject: [PATCH net-next 02/13] net: dsa: lantiq_gswip: support
 enable/disable learning
Message-ID: <00835a8b88affea908ccb47753bd49271406d5c2.1761324950.git.daniel@makrotopia.org>
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

Switch API 2.2 or later supports enabling or disabling learning on each
port. Implement support for BR_LEARNING bridge flag and announce support
for BR_LEARNING on GSWIP 2.2 or later.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  3 ++
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 43 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index d86290db19b4..fb7d2c02bde9 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -157,6 +157,9 @@
 #define  GSWIP_PCE_PCTRL_0_PSTATE_LEARNING	0x3
 #define  GSWIP_PCE_PCTRL_0_PSTATE_FORWARDING	0x7
 #define  GSWIP_PCE_PCTRL_0_PSTATE_MASK	GENMASK(2, 0)
+/* Ethernet Switch PCE Port Control Register 3 */
+#define GSWIP_PCE_PCTRL_3p(p)		(0x483 + ((p) * 0xA))
+#define  GSWIP_PCE_PCTRL_3_LNDIS	BIT(15)  /* Learning Disable */
 #define GSWIP_PCE_VCTRL(p)		(0x485 + ((p) * 0xA))
 #define  GSWIP_PCE_VCTRL_UVR		BIT(0)	/* Unknown VLAN Rule */
 #define  GSWIP_PCE_VCTRL_VINR		GENMASK(2, 1) /* VLAN Ingress Tag Rule */
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index a0e361622acb..595d4016f6d1 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -403,6 +403,47 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
+static int gswip_port_set_learning(struct gswip_priv *priv, int port,
+				   bool enable)
+{
+	if (!GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2))
+		return -EOPNOTSUPP;
+
+	/* learning disable bit */
+	return regmap_update_bits(priv->gswip, GSWIP_PCE_PCTRL_3p(port),
+				  GSWIP_PCE_PCTRL_3_LNDIS,
+				  enable ? 0 : GSWIP_PCE_PCTRL_3_LNDIS);
+}
+
+static int gswip_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				       struct switchdev_brport_flags flags,
+				       struct netlink_ext_ack *extack)
+{
+	struct gswip_priv *priv = ds->priv;
+	unsigned long supported;
+
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2))
+		supported |= BR_LEARNING;
+
+	if (flags.mask & ~supported)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int gswip_port_bridge_flags(struct dsa_switch *ds, int port,
+				   struct switchdev_brport_flags flags,
+				   struct netlink_ext_ack *extack)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (flags.mask & BR_LEARNING)
+		return gswip_port_set_learning(priv, port,
+					       !!(flags.val & BR_LEARNING));
+
+	return 0;
+}
+
 static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
@@ -1521,6 +1562,8 @@ static const struct dsa_switch_ops gswip_switch_ops = {
 	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
+	.port_pre_bridge_flags	= gswip_port_pre_bridge_flags,
+	.port_bridge_flags	= gswip_port_bridge_flags,
 	.port_bridge_join	= gswip_port_bridge_join,
 	.port_bridge_leave	= gswip_port_bridge_leave,
 	.port_fast_age		= gswip_port_fast_age,
-- 
2.51.0

