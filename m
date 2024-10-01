Return-Path: <netdev+bounces-130901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9398BE93
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDEA2861F8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD531CB306;
	Tue,  1 Oct 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wO28T66+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE271C9DF2;
	Tue,  1 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790718; cv=none; b=ZMVa9f08yFdLxtLCCRr/4dkmbXTYMmQwWrQ+X1yMrX53Q9/mpsEsWECeSYqKa4CgFPjVSe9zTCv9UDOfguIP37ndl4Ey3CVUTQxMbq/kA7Ys6fA3Kq6wNq4J+JNP+/X4yNIRTezgJB65ev4df3vP0hCesJKrNPpFiAN4tAnkNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790718; c=relaxed/simple;
	bh=Pv+VUAjujBz2UVaZkgBtDLm6RV4FvG/RREyWqq1OPYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I97FNVvC8/hY3zzWU1OrLCCOye89vnTSUXY8vV9i2DP7v8AEaEcqDs3Q9NAyWVgpgwGkc2y+2TOwv8efqTdGhDWCrTk5ZlcfN1e+xbqdTPWdLcV3UBfJr0JmaF95ETl+co4q3w5lX2kFDnnQ7YLm5SJxHdts46GIjxfEQlvejTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wO28T66+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790716; x=1759326716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Pv+VUAjujBz2UVaZkgBtDLm6RV4FvG/RREyWqq1OPYs=;
  b=wO28T66+YYSgfL34yLU+5ljsCQkUD0uzTZYnJ6btLkCybH+lZ56jFVWx
   mmHzF/iZKPFyPB6NjAoKm6E4I9iMyBAkNjpa/X8VerHz2lM7leKJHnIUG
   3adKsIjvsjb+OMaA9WeBG7ilBcsxETcjFk/GfKfmTaMn52WxRPb2y7Imy
   zAlbYKkRSAGS2f8uQQo8RSCbzMGaWpCZy3ZoeBCaDMW52QB6NLrcDXINm
   TENvqijVU6oH/IgEowW54x7Stf1Tn6C2D6zefczWyjFJgSfPC/IppJyWO
   qPBILWo/BESWlTBAq2Tm1xZINEGPVmd9x1t5yAugtOKiVwEBK8YRAyI8O
   g==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: eptQ1vUQT++V1OzL+f4E7g==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893175"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:45 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:42 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:44 +0200
Subject: [PATCH net-next 14/15] net: sparx5: ops out function for DSM
 calendar calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-14-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

The DSM (Disassembler) calendar grants each port access to internal
busses. The configuration of the calendar is done differently on Sparx5
and lan969x. Therefore ops out the function that calculates the
calendar.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 22 ++++------------------
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index b7b611b1ad34..35456cd35a40 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -15,9 +15,7 @@
 #define SPX5_CALBITS_PER_PORT          3   /* Bit per port in calendar register */
 
 /* DSM calendar information */
-#define SPX5_DSM_CAL_LEN               64
 #define SPX5_DSM_CAL_EMPTY             0xFFFF
-#define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
 #define SPX5_DSM_CAL_TAXIS             8
 #define SPX5_DSM_CAL_BW_LOSS           553
 
@@ -37,19 +35,6 @@ static u32 sparx5_taxi_ports[SPX5_DSM_CAL_TAXIS][SPX5_DSM_CAL_MAX_DEVS_PER_TAXI]
 	{64, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99},
 };
 
-struct sparx5_calendar_data {
-	u32 schedule[SPX5_DSM_CAL_LEN];
-	u32 avg_dist[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 taxi_ports[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 taxi_speeds[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 dev_slots[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
-	u32 new_slots[SPX5_DSM_CAL_LEN];
-	u32 temp_sched[SPX5_DSM_CAL_LEN];
-	u32 indices[SPX5_DSM_CAL_LEN];
-	u32 short_list[SPX5_DSM_CAL_LEN];
-	u32 long_list[SPX5_DSM_CAL_LEN];
-};
-
 static u32 sparx5_target_bandwidth(struct sparx5 *sparx5)
 {
 	switch (sparx5->target_ct) {
@@ -278,8 +263,8 @@ static u32 sparx5_dsm_cp_cal(u32 *sched)
 	return SPX5_DSM_CAL_EMPTY;
 }
 
-static int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
-				    struct sparx5_calendar_data *data)
+int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			     struct sparx5_calendar_data *data)
 {
 	bool slow_mode;
 	u32 gcd, idx, sum, min, factor;
@@ -565,6 +550,7 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 /* Configure the DSM calendar based on port configuration */
 int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 {
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	int taxi;
 	struct sparx5_calendar_data *data;
 	int err = 0;
@@ -574,7 +560,7 @@ int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 		return -ENOMEM;
 
 	for (taxi = 0; taxi < SPX5_CONST(n_dsm_cal_taxis); ++taxi) {
-		err = sparx5_dsm_calendar_calc(sparx5, taxi, data);
+		err = ops->dsm_calendar_calc(sparx5, taxi, data);
 		if (err) {
 			dev_err(sparx5->dev, "DSM calendar calculation failed\n");
 			goto cal_out;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index c5239e547c35..67e8d2d70816 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -989,6 +989,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
 	.set_port_mux            = &sparx5_port_mux_set,
 	.ptp_irq_handler         = &sparx5_ptp_irq_handler,
+	.dsm_calendar_calc       = &sparx5_dsm_calendar_calc,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index eb71bba02a77..55fc21fbf63d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -103,8 +103,24 @@ enum sparx5_vlan_port_type {
 #define IFH_PDU_TYPE_IPV4_UDP_PTP	0x6
 #define IFH_PDU_TYPE_IPV6_UDP_PTP	0x7
 
+#define SPX5_DSM_CAL_LEN               64
+#define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
+
 struct sparx5;
 
+struct sparx5_calendar_data {
+	u32 schedule[SPX5_DSM_CAL_LEN];
+	u32 avg_dist[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 taxi_ports[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 taxi_speeds[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 dev_slots[SPX5_DSM_CAL_MAX_DEVS_PER_TAXI];
+	u32 new_slots[SPX5_DSM_CAL_LEN];
+	u32 temp_sched[SPX5_DSM_CAL_LEN];
+	u32 indices[SPX5_DSM_CAL_LEN];
+	u32 short_list[SPX5_DSM_CAL_LEN];
+	u32 long_list[SPX5_DSM_CAL_LEN];
+};
+
 /* Frame DMA receive state:
  * For each DB, there is a SKB, and the skb data pointer is mapped in
  * the DB. Once a frame is received the skb is given to the upper layers
@@ -273,6 +289,8 @@ struct sparx5_ops {
 			    struct sparx5_port_config *conf);
 
 	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
+	int (*dsm_calendar_calc)(struct sparx5 *sparx5, u32 taxi,
+				 struct sparx5_calendar_data *data);
 };
 
 struct sparx5_main_io_resource {
@@ -423,6 +441,9 @@ void sparx5_vlan_port_apply(struct sparx5 *sparx5, struct sparx5_port *port);
 /* sparx5_calendar.c */
 int sparx5_config_auto_calendar(struct sparx5 *sparx5);
 int sparx5_config_dsm_calendar(struct sparx5 *sparx5);
+int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
+			     struct sparx5_calendar_data *data);
+
 
 /* sparx5_ethtool.c */
 void sparx5_get_stats64(struct net_device *ndev, struct rtnl_link_stats64 *stats);

-- 
2.34.1


