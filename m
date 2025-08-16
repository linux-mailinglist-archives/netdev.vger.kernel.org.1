Return-Path: <netdev+bounces-214335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7CB29060
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831055A3BC4
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADA21772D;
	Sat, 16 Aug 2025 19:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EA217F56;
	Sat, 16 Aug 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373988; cv=none; b=ALKbl0aT2Uti5hnor473668nB9DkBfuqt0zD0Tf0MCbKHWDp4gM5miEk0Sm+EiNbtOJqx2tIX8PIorObHe6760pYnYrtIWkZlokBE5CbLOzCuk5ZrDmKbUGrS13MNBRRYlWGlgWgRwb6bboZTPLm7KDCSG5VwjnN7DRjUM0Crqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373988; c=relaxed/simple;
	bh=NflaXKBNXGXDkXRGvHepgY8LfFV96xQx5x5Foq8qA8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qvz9iOyat1UdL/H9O3UFtfX5Ka9OvQtVYRZObiFAvLRvssLmB+X9+ozfgS9ukO9fuA8ONOBbkXQH+WJuLDUryvrGZwmRW2VBi3OnuGHriWc4stVNhOmCeCjZ/7Kd3YVYxXVlxPmRzipbq918s+4Z+pW32BvIcmEpIEQMqruYoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMxX-000000006zx-1zaA;
	Sat, 16 Aug 2025 19:52:59 +0000
Date: Sat, 16 Aug 2025 20:52:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 10/23] net: dsa: lantiq_gswip: support
 enable/disable learning
Message-ID: <aKDhl5LHSmwms9-h@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Switch API 2.3 or later supports enabling or disabling learning on each
port. Add basic support for that feature and use assisted learning on the
CPU port while enabling learning on user ports.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 24 ++++++++++++++++++++++++
 drivers/net/dsa/lantiq_gswip.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 16b92af9ff23..fde31c5bd8ae 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -448,6 +448,18 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
+static void gswip_port_set_learning(struct gswip_priv *priv, int port,
+				    bool enable)
+{
+	if (!GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_3))
+		return;
+
+	/* learning disable bit */
+	gswip_switch_mask(priv, GSWIP_PCE_PCTRL_3_LNDIS,
+			  enable ? 0 : GSWIP_PCE_PCTRL_3_LNDIS,
+			  GSWIP_PCE_PCTRL_3p(port));
+}
+
 static int gswip_port_enable(struct dsa_switch *ds, int port,
 			     struct phy_device *phydev)
 {
@@ -592,10 +604,19 @@ static int gswip_setup(struct dsa_switch *ds)
 	}
 
 	/* Default unknown Broadcast/Multicast/Unicast port maps */
+	/* Monitoring Port Map */
 	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP1);
+	/* Default unknown Broadcast/Multicast Port Map */
 	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP2);
+	/* Default unknown Unicast Port Map */
 	gswip_switch_w(priv, cpu_ports, GSWIP_PCE_PMAP3);
 
+	/* enable MAC address learning by default on all user ports, disable
+	 * on the CPU port to use assisted learning on the CPU port
+	 */
+	for (i = 0; i < priv->hw_info->max_ports; i++)
+		gswip_port_set_learning(priv, i, !dsa_is_cpu_port(ds, i));
+
 	/* Deactivate MDIO PHY auto polling. Some PHYs as the AR8030 have an
 	 * interoperability problem with this auto polling mechanism because
 	 * their status registers think that the link is in a different state
@@ -653,6 +674,9 @@ static int gswip_setup(struct dsa_switch *ds)
 
 	ds->configure_vlan_while_not_filtering = false;
 
+	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_3))
+		ds->assisted_learning_on_cpu_port = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index fd0c01edb914..b565ebebbc46 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -151,6 +151,9 @@
 #define  GSWIP_PCE_PCTRL_0_PSTATE_LEARNING	0x3
 #define  GSWIP_PCE_PCTRL_0_PSTATE_FORWARDING	0x7
 #define  GSWIP_PCE_PCTRL_0_PSTATE_MASK	GENMASK(2, 0)
+/* Ethernet Switch PCE Port Control Register 3 */
+#define GSWIP_PCE_PCTRL_3p(p)		(0x483 + ((p) * 0xA))
+#define  GSWIP_PCE_PCTRL_3_LNDIS	BIT(15)  /* Learning Disable */
 #define GSWIP_PCE_VCTRL(p)		(0x485 + ((p) * 0xA))
 #define  GSWIP_PCE_VCTRL_UVR		BIT(0)	/* Unknown VLAN Rule */
 #define  GSWIP_PCE_VCTRL_VIMR		BIT(3)	/* VLAN Ingress Member violation rule */
-- 
2.50.1

