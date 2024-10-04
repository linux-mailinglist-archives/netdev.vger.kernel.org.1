Return-Path: <netdev+bounces-132044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0299903EC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D97280B83
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFEA215F4F;
	Fri,  4 Oct 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rzJgJ8Xw"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C982141C9;
	Fri,  4 Oct 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048037; cv=none; b=s3/HKPSv9mgJNHcj7IU6AobFyP4SRYQpm+Ebf09B/NkMWF8LyKjD0cl8RHndL7jRImx6syn1Ikkg46oHL57b7bUUWcm//qUwgFo0Uey0A5hAWjug24337LHIr5KHcsXF7+Fw1H5hsDP2t/fpyuZWyJU5vvPRC9Q6qXXgyet2GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048037; c=relaxed/simple;
	bh=Y2U4DxNU8jMrKiFv9pjQg2BjVZCZkBcTzLcGIihpi6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a6IpCQrplQEE0k69wiGRcP47ASQXh3Hu6pBW05eIWdvJA19De9L2WlPPyRspXU4+NbM8HPo3KVj6LWknwEpg9m2ayEfj1kDrWCA31XZXPhwM0WSVDqXQ/dic81ahwL/Q/02p5nXqzHST7xvdliiCX2PDtUqpRSrQIXKSOv5XVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rzJgJ8Xw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048036; x=1759584036;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y2U4DxNU8jMrKiFv9pjQg2BjVZCZkBcTzLcGIihpi6k=;
  b=rzJgJ8XwjiXg23Hp00yfRQqAMPWGI7OQJZG7NWEPx7Dcri3xTGOnqMh1
   6h4NEUTgmfY7L7sgkAJu05N6fxBsxwt/jsxfkBhUMtfky7yrhEr3NyJKr
   nc0TLIR8W9oLcpR+U+qO27ieM840vjtTItQckTQZ75h8hBjrCJ87r1Zxx
   SiemR39VuuUP8UkvUDRrGHJDvjyyK8hy7WG1KRu6OQnbth3OVpYsrD5o9
   eLtNB4Gx8m1q1qYqWrGqVw294Rx7/W7AIYjhxv+bNVRLnr8V3xsnnB1Gm
   idIykSx/S51zVd2nxImyVM/SsjMUdOdov85BCWXBNE+vLRux/3wuLMjXD
   w==;
X-CSE-ConnectionGUID: wYEhTCIITtS2MLde76jJ4w==
X-CSE-MsgGUID: dFAd4rp0QLOGvuLfSBUFJw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:17 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:14 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:30 +0200
Subject: [PATCH net-next v2 04/15] net: sparx5: add *sparx5 argument to a
 few functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-4-d3290f581663@microchip.com>
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

The *sparx5 context pointer is required in functions that need to access
platform constants (which will be added in a subsequent patch).  Prepare
for this by updating the prototype and use of such functions.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c | 24 +++++++++----------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 28 +++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |  6 ++---
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    | 24 +++++++++----------
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |  8 +++----
 8 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index d898a7238b48..ca97d51e6a8d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -505,8 +505,8 @@ static void sparx5_get_dev_misc_stats(u64 *portstats, void __iomem *inst, u32
 static void sparx5_get_device_stats(struct sparx5 *sparx5, int portno)
 {
 	u64 *portstats = &sparx5->stats[portno * sparx5->num_stats];
-	u32 tinst = sparx5_port_dev_index(portno);
-	u32 dev = sparx5_to_high_dev(portno);
+	u32 tinst = sparx5_port_dev_index(sparx5, portno);
+	u32 dev = sparx5_to_high_dev(sparx5, portno);
 	void __iomem *inst;
 
 	inst = spx5_inst_get(sparx5, dev, tinst);
@@ -819,8 +819,8 @@ static void sparx5_get_eth_phy_stats(struct net_device *ndev,
 
 	portstats = &sparx5->stats[portno * sparx5->num_stats];
 	if (sparx5_is_baser(port->conf.portmode)) {
-		u32 tinst = sparx5_port_dev_index(portno);
-		u32 dev = sparx5_to_high_dev(portno);
+		u32 tinst = sparx5_port_dev_index(sparx5, portno);
+		u32 dev = sparx5_to_high_dev(sparx5, portno);
 
 		inst = spx5_inst_get(sparx5, dev, tinst);
 		sparx5_get_dev_phy_stats(portstats, inst, tinst);
@@ -844,8 +844,8 @@ static void sparx5_get_eth_mac_stats(struct net_device *ndev,
 
 	portstats = &sparx5->stats[portno * sparx5->num_stats];
 	if (sparx5_is_baser(port->conf.portmode)) {
-		u32 tinst = sparx5_port_dev_index(portno);
-		u32 dev = sparx5_to_high_dev(portno);
+		u32 tinst = sparx5_port_dev_index(sparx5, portno);
+		u32 dev = sparx5_to_high_dev(sparx5, portno);
 
 		inst = spx5_inst_get(sparx5, dev, tinst);
 		sparx5_get_dev_mac_stats(portstats, inst, tinst);
@@ -912,8 +912,8 @@ static void sparx5_get_eth_mac_ctrl_stats(struct net_device *ndev,
 
 	portstats = &sparx5->stats[portno * sparx5->num_stats];
 	if (sparx5_is_baser(port->conf.portmode)) {
-		u32 tinst = sparx5_port_dev_index(portno);
-		u32 dev = sparx5_to_high_dev(portno);
+		u32 tinst = sparx5_port_dev_index(sparx5, portno);
+		u32 dev = sparx5_to_high_dev(sparx5, portno);
 
 		inst = spx5_inst_get(sparx5, dev, tinst);
 		sparx5_get_dev_mac_ctrl_stats(portstats, inst, tinst);
@@ -944,8 +944,8 @@ static void sparx5_get_eth_rmon_stats(struct net_device *ndev,
 
 	portstats = &sparx5->stats[portno * sparx5->num_stats];
 	if (sparx5_is_baser(port->conf.portmode)) {
-		u32 tinst = sparx5_port_dev_index(portno);
-		u32 dev = sparx5_to_high_dev(portno);
+		u32 tinst = sparx5_port_dev_index(sparx5, portno);
+		u32 dev = sparx5_to_high_dev(sparx5, portno);
 
 		inst = spx5_inst_get(sparx5, dev, tinst);
 		sparx5_get_dev_rmon_stats(portstats, inst, tinst);
@@ -1027,8 +1027,8 @@ static void sparx5_get_sset_data(struct net_device *ndev,
 
 	portstats = &sparx5->stats[portno * sparx5->num_stats];
 	if (sparx5_is_baser(port->conf.portmode)) {
-		u32 tinst = sparx5_port_dev_index(portno);
-		u32 dev = sparx5_to_high_dev(portno);
+		u32 tinst = sparx5_port_dev_index(sparx5, portno);
+		u32 dev = sparx5_to_high_dev(sparx5, portno);
 
 		inst = spx5_inst_get(sparx5, dev, tinst);
 		sparx5_get_dev_misc_stats(portstats, inst, tinst);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 4988d9b90286..549c04b1f2b3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -401,7 +401,7 @@ void sparx5_set_port_ifh_timestamp(void *ifh_hdr, u64 timestamp);
 void sparx5_set_port_ifh_rew_op(void *ifh_hdr, u32 rew_op);
 void sparx5_set_port_ifh_pdu_type(void *ifh_hdr, u32 pdu_type);
 void sparx5_set_port_ifh_pdu_w16_offset(void *ifh_hdr, u32 pdu_w16_offset);
-void sparx5_set_port_ifh(void *ifh_hdr, u16 portno);
+void sparx5_set_port_ifh(struct sparx5 *sparx5, void *ifh_hdr, u16 portno);
 bool sparx5_netdevice_check(const struct net_device *dev);
 struct net_device *sparx5_create_netdev(struct sparx5 *sparx5, u32 portno);
 int sparx5_register_netdevs(struct sparx5 *sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 705a004b324f..3ae6bad3bbb3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -55,7 +55,7 @@ static void __ifh_encode_bitfield(void *ifh, u64 value, u32 pos, u32 width)
 		ifh_hdr[byte - 5] |= (u8)((encode & 0xFF0000000000) >> 40);
 }
 
-void sparx5_set_port_ifh(void *ifh_hdr, u16 portno)
+void sparx5_set_port_ifh(struct sparx5 *sparx5, void *ifh_hdr, u16 portno)
 {
 	/* VSTAX.RSV = 1. MSBit must be 1 */
 	ifh_encode_bitfield(ifh_hdr, 1, VSTAX + 79,  1);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 70427643f777..e637834b56df 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -235,7 +235,7 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_t ret;
 
 	memset(ifh, 0, IFH_LEN * 4);
-	sparx5_set_port_ifh(ifh, port->portno);
+	sparx5_set_port_ifh(sparx5, ifh, port->portno);
 
 	if (sparx5->ptp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
 		if (sparx5_ptp_txtstamp_request(port, skb) < 0)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 062e486c002c..ea3454342665 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -132,8 +132,8 @@ static int sparx5_get_sfi_status(struct sparx5 *sparx5,
 		return -EINVAL;
 	}
 
-	dev = sparx5_to_high_dev(portno);
-	tinst = sparx5_port_dev_index(portno);
+	dev = sparx5_to_high_dev(sparx5, portno);
+	tinst = sparx5_port_dev_index(sparx5, portno);
 	inst = spx5_inst_get(sparx5, dev, tinst);
 
 	value = spx5_inst_rd(inst, DEV10G_MAC_TX_MONITOR_STICKY(0));
@@ -316,9 +316,9 @@ static int sparx5_port_flush_poll(struct sparx5 *sparx5, u32 portno)
 static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port, bool high_spd_dev)
 {
 	u32 tinst = high_spd_dev ?
-		    sparx5_port_dev_index(port->portno) : port->portno;
+		    sparx5_port_dev_index(sparx5, port->portno) : port->portno;
 	u32 dev = high_spd_dev ?
-		  sparx5_to_high_dev(port->portno) : TARGET_DEV2G5;
+		  sparx5_to_high_dev(sparx5, port->portno) : TARGET_DEV2G5;
 	void __iomem *devinst = spx5_inst_get(sparx5, dev, tinst);
 	u32 spd = port->conf.speed;
 	u32 spd_prm;
@@ -427,7 +427,7 @@ static int sparx5_port_disable(struct sparx5 *sparx5, struct sparx5_port *port,
 		 HSCH_FLUSH_CTRL);
 
 	if (high_spd_dev) {
-		u32 pcs = sparx5_to_pcs_dev(port->portno);
+		u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
 		void __iomem *pcsinst = spx5_inst_get(sparx5, pcs, tinst);
 
 		/* 12: Disable 5G/10G/25 BaseR PCS */
@@ -558,8 +558,8 @@ static int sparx5_port_max_tags_set(struct sparx5 *sparx5,
 	bool dtag           = max_tags == SPX5_PORT_MAX_TAGS_TWO;
 	enum sparx5_vlan_port_type vlan_type  = port->vlan_type;
 	bool dotag          = max_tags != SPX5_PORT_MAX_TAGS_NONE;
-	u32 dev             = sparx5_to_high_dev(port->portno);
-	u32 tinst           = sparx5_port_dev_index(port->portno);
+	u32 dev             = sparx5_to_high_dev(sparx5, port->portno);
+	u32 tinst           = sparx5_port_dev_index(sparx5, port->portno);
 	void __iomem *inst  = spx5_inst_get(sparx5, dev, tinst);
 	u32 etype;
 
@@ -789,9 +789,9 @@ static int sparx5_port_pcs_high_set(struct sparx5 *sparx5,
 				    struct sparx5_port_config *conf)
 {
 	u32 clk_spd = conf->portmode == PHY_INTERFACE_MODE_5GBASER ? 1 : 0;
-	u32 pix = sparx5_port_dev_index(port->portno);
-	u32 dev = sparx5_to_high_dev(port->portno);
-	u32 pcs = sparx5_to_pcs_dev(port->portno);
+	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
+	u32 dev = sparx5_to_high_dev(sparx5, port->portno);
+	u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
 	void __iomem *devinst;
 	void __iomem *pcsinst;
 	int err;
@@ -843,7 +843,7 @@ static int sparx5_port_pcs_high_set(struct sparx5 *sparx5,
 /* Switch between 1G/2500 and 5G/10G/25G devices */
 static void sparx5_dev_switch(struct sparx5 *sparx5, int port, bool hsd)
 {
-	int bt_indx = BIT(sparx5_port_dev_index(port));
+	int bt_indx = BIT(sparx5_port_dev_index(sparx5, port));
 
 	if (sparx5_port_is_5g(port)) {
 		spx5_rmw(hsd ? 0 : bt_indx,
@@ -1016,9 +1016,9 @@ int sparx5_port_init(struct sparx5 *sparx5,
 {
 	u32 pause_start = sparx5_wm_enc(6  * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
 	u32 atop = sparx5_wm_enc(20 * (ETH_MAXLEN / SPX5_BUFFER_CELL_SZ));
-	u32 devhigh = sparx5_to_high_dev(port->portno);
-	u32 pix = sparx5_port_dev_index(port->portno);
-	u32 pcs = sparx5_to_pcs_dev(port->portno);
+	u32 devhigh = sparx5_to_high_dev(sparx5, port->portno);
+	u32 pix = sparx5_port_dev_index(sparx5, port->portno);
+	u32 pcs = sparx5_to_pcs_dev(sparx5, port->portno);
 	bool sd_pol = port->signd_active_high;
 	bool sd_sel = !port->signd_internal;
 	bool sd_ena = port->signd_enable;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index 607c4ff1df6b..468e3d34d6e1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -40,7 +40,7 @@ static inline bool sparx5_port_is_25g(int portno)
 	return portno >= 56 && portno <= 63;
 }
 
-static inline u32 sparx5_to_high_dev(int port)
+static inline u32 sparx5_to_high_dev(struct sparx5 *sparx5, int port)
 {
 	if (sparx5_port_is_5g(port))
 		return TARGET_DEV5G;
@@ -49,7 +49,7 @@ static inline u32 sparx5_to_high_dev(int port)
 	return TARGET_DEV25G;
 }
 
-static inline u32 sparx5_to_pcs_dev(int port)
+static inline u32 sparx5_to_pcs_dev(struct sparx5 *sparx5, int port)
 {
 	if (sparx5_port_is_5g(port))
 		return TARGET_PCS5G_BR;
@@ -58,7 +58,7 @@ static inline u32 sparx5_to_pcs_dev(int port)
 	return TARGET_PCS25G_BR;
 }
 
-static inline int sparx5_port_dev_index(int port)
+static inline int sparx5_port_dev_index(struct sparx5 *sparx5, int port)
 {
 	if (sparx5_port_is_2g5(port))
 		return port;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 8dee1ab1fa75..5d9c7b782352 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -20,34 +20,34 @@ static struct sparx5_pool_entry sparx5_psfp_sg_pool[SPX5_PSFP_SG_CNT];
 /* Pool of available stream filters */
 static struct sparx5_pool_entry sparx5_psfp_sf_pool[SPX5_PSFP_SF_CNT];
 
-static int sparx5_psfp_sf_get(u32 *id)
+static int sparx5_psfp_sf_get(struct sparx5 *sparx5, u32 *id)
 {
 	return sparx5_pool_get(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
 }
 
-static int sparx5_psfp_sf_put(u32 id)
+static int sparx5_psfp_sf_put(struct sparx5 *sparx5, u32 id)
 {
 	return sparx5_pool_put(sparx5_psfp_sf_pool, SPX5_PSFP_SF_CNT, id);
 }
 
-static int sparx5_psfp_sg_get(u32 idx, u32 *id)
+static int sparx5_psfp_sg_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
 	return sparx5_pool_get_with_idx(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT,
 					idx, id);
 }
 
-static int sparx5_psfp_sg_put(u32 id)
+static int sparx5_psfp_sg_put(struct sparx5 *sparx5, u32 id)
 {
 	return sparx5_pool_put(sparx5_psfp_sg_pool, SPX5_PSFP_SG_CNT, id);
 }
 
-static int sparx5_psfp_fm_get(u32 idx, u32 *id)
+static int sparx5_psfp_fm_get(struct sparx5 *sparx5, u32 idx, u32 *id)
 {
 	return sparx5_pool_get_with_idx(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, idx,
 					id);
 }
 
-static int sparx5_psfp_fm_put(u32 id)
+static int sparx5_psfp_fm_put(struct sparx5 *sparx5, u32 id)
 {
 	return sparx5_pool_put(sparx5_psfp_fm_pool, SPX5_SDLB_CNT, id);
 }
@@ -205,7 +205,7 @@ int sparx5_psfp_sf_add(struct sparx5 *sparx5, const struct sparx5_psfp_sf *sf,
 {
 	int ret;
 
-	ret = sparx5_psfp_sf_get(id);
+	ret = sparx5_psfp_sf_get(sparx5, id);
 	if (ret < 0)
 		return ret;
 
@@ -220,7 +220,7 @@ int sparx5_psfp_sf_del(struct sparx5 *sparx5, u32 id)
 
 	sparx5_psfp_sf_set(sparx5, id, &sf);
 
-	return sparx5_psfp_sf_put(id);
+	return sparx5_psfp_sf_put(sparx5, id);
 }
 
 int sparx5_psfp_sg_add(struct sparx5 *sparx5, u32 uidx,
@@ -229,7 +229,7 @@ int sparx5_psfp_sg_add(struct sparx5 *sparx5, u32 uidx,
 	ktime_t basetime;
 	int ret;
 
-	ret = sparx5_psfp_sg_get(uidx, id);
+	ret = sparx5_psfp_sg_get(sparx5, uidx, id);
 	if (ret < 0)
 		return ret;
 	/* Was already in use, no need to reconfigure */
@@ -253,7 +253,7 @@ int sparx5_psfp_sg_del(struct sparx5 *sparx5, u32 id)
 	const struct sparx5_psfp_sg sg = { 0 };
 	int ret;
 
-	ret = sparx5_psfp_sg_put(id);
+	ret = sparx5_psfp_sg_put(sparx5, id);
 	if (ret < 0)
 		return ret;
 	/* Stream gate still in use ? */
@@ -270,7 +270,7 @@ int sparx5_psfp_fm_add(struct sparx5 *sparx5, u32 uidx,
 	int ret;
 
 	/* Get flow meter */
-	ret = sparx5_psfp_fm_get(uidx, &fm->pol.idx);
+	ret = sparx5_psfp_fm_get(sparx5, uidx, &fm->pol.idx);
 	if (ret < 0)
 		return ret;
 	/* Was already in use, no need to reconfigure */
@@ -303,7 +303,7 @@ int sparx5_psfp_fm_del(struct sparx5 *sparx5, u32 id)
 	if (ret < 0)
 		return ret;
 
-	ret = sparx5_psfp_fm_put(id);
+	ret = sparx5_psfp_fm_put(sparx5, id);
 	if (ret < 0)
 		return ret;
 	/* Do not reset flow-meter if still in use. */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
index e80f3166db7d..28b2514c8330 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc.c
@@ -60,8 +60,8 @@ static int sparx5_tc_setup_block(struct net_device *ndev,
 					  cb, ndev, ndev, false);
 }
 
-static void sparx5_tc_get_layer_and_idx(u32 parent, u32 portno, u32 *layer,
-					u32 *idx)
+static void sparx5_tc_get_layer_and_idx(struct sparx5 *sparx5, u32 parent,
+					u32 portno, u32 *layer, u32 *idx)
 {
 	if (parent == TC_H_ROOT) {
 		*layer = 2;
@@ -90,8 +90,8 @@ static int sparx5_tc_setup_qdisc_tbf(struct net_device *ndev,
 	struct sparx5_port *port = netdev_priv(ndev);
 	u32 layer, se_idx;
 
-	sparx5_tc_get_layer_and_idx(qopt->parent, port->portno, &layer,
-				    &se_idx);
+	sparx5_tc_get_layer_and_idx(port->sparx5, qopt->parent, port->portno,
+				    &layer, &se_idx);
 
 	switch (qopt->command) {
 	case TC_TBF_REPLACE:

-- 
2.34.1


