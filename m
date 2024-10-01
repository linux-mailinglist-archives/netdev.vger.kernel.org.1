Return-Path: <netdev+bounces-130902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449298BE96
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F651C23BAE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCA1CB31C;
	Tue,  1 Oct 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TX6Vbmz/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D71C9DFD;
	Tue,  1 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790719; cv=none; b=LaiY+TjhANiYVftuTJaJ0q+nxYC2mwP94b5qmAj6YYEeRw79/FljnYVkqNebjihuh3kD6DNFPCil91VJnTr/EnpQ1wN/qQQSWjTrDzhZ06IhXziIEBtXJJRyCTipJqLgj1xC9pyblDgVwe1MyNu02poCxe5zO04LRSitnNrTXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790719; c=relaxed/simple;
	bh=mOj5JOdow5wuqv+h4v4oSNGJAxVJQHDe5dZFLi/5Vsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Pu09O7gu67Gftsy187EYH6ncSVZRaCSyMsK6+BnN8gdxtYCLqIQaAdJgA8BTY0S7kYDs05gSQvuxsActbkZGoa2MKZajYVeVb2saSK0s26X2+aF9LaAi+48toqFZf97F1N3Va5lZJ59h2gY9vuXqI4BDOT2my7YRfWm7BOLgD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TX6Vbmz/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790716; x=1759326716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mOj5JOdow5wuqv+h4v4oSNGJAxVJQHDe5dZFLi/5Vsc=;
  b=TX6Vbmz/T5gxgTH6x/LPbMDXq4o2IPLfn6c0Gm3h/xU/liyCEXPJBRA6
   2ME3GMeKqM7ADUMEoQ2bsyUKZyum8iVBj0iLTNaGE9HRC/OrB9p16bAo5
   UJYlPBOVGluIARDIj4P1xxCKK0AWPlSZuorh4YbtffFG6IwwSTOdRHSW8
   Jyk7n4cUpGuPwDMsbqVx5bY8sTr8k1t/tcG/Na3AQGX8YqLIeQbsjvAb2
   HM6jLadoI1HIMdE6cJs4dG8+92TCvgX+b9/BH2Is902pgVcBjntzOrB1k
   UgdYlBKIySDir4OyNlFNoHP3UyCxC7XUslvrz2Kb+GhReg+0WrCwUyuXU
   g==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: uktqJOuxTreLhJoLa4Jjmw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893176"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:48 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:45 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:45 +0200
Subject: [PATCH net-next 15/15] net: sparx5: add is_sparx5 macro and use it
 throughout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-15-8c6896fdce66@microchip.com>
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

We dont want to ops out each time a function needs to do some platform
specifics. In particular we have a few places, where it would be
convenient to just branch out on the platform type. Add the function
is_sparx5() and, initially, use it for:

    - register writes that should only be done on Sparx5 (QSYS_CAL_CTRL,
      CLKGEN_LCPLL1_CORE_CLK).

    - function calls that should only be done on Sparx5
      (ethtool_op_get_ts_info())

    - register writes that are chip-exclusive (MASK_CFG1/2, PGID_CFG1/2,
      these are replicated for n_ports >32 on Sparx5).

The is_sparx5() function simply checks the target chip type, to
determine if this is a Sparx5 SKU or not.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |  7 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 88 +++++++++++++---------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    | 42 +++++++----
 5 files changed, 88 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 35456cd35a40..78600b6aeaf2 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -193,9 +193,10 @@ int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 	}
 
 	/* Halt the calendar while changing it */
-	spx5_rmw(QSYS_CAL_CTRL_CAL_MODE_SET(10),
-		 QSYS_CAL_CTRL_CAL_MODE,
-		 sparx5, QSYS_CAL_CTRL);
+	if (is_sparx5(sparx5))
+		spx5_rmw(QSYS_CAL_CTRL_CAL_MODE_SET(10),
+			 QSYS_CAL_CTRL_CAL_MODE,
+			 sparx5, QSYS_CAL_CTRL);
 
 	/* Assign port bandwidth to auto calendar */
 	for (idx = 0; idx < SPX5_CONST(n_auto_cals); idx++)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 4176733179db..516eb107040f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1189,7 +1189,7 @@ static int sparx5_get_ts_info(struct net_device *dev,
 	struct sparx5 *sparx5 = port->sparx5;
 	struct sparx5_phc *phc;
 
-	if (!sparx5->ptp)
+	if (!sparx5->ptp && is_sparx5(sparx5))
 		return ethtool_op_get_ts_info(dev, info);
 
 	phc = &sparx5->phc[SPARX5_PHC_PORT];
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 67e8d2d70816..04ccfb448c2c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -210,6 +210,25 @@ static const struct sparx5_main_io_resource sparx5_main_iomap[] =  {
 	{ TARGET_VOP,                0x11a00000, 2 }, /* 0x611a00000 */
 };
 
+bool is_sparx5(struct sparx5 *sparx5)
+{
+	switch (sparx5->target_ct) {
+	case SPX5_TARGET_CT_7546:
+	case SPX5_TARGET_CT_7549:
+	case SPX5_TARGET_CT_7552:
+	case SPX5_TARGET_CT_7556:
+	case SPX5_TARGET_CT_7558:
+	case SPX5_TARGET_CT_7546TSN:
+	case SPX5_TARGET_CT_7549TSN:
+	case SPX5_TARGET_CT_7552TSN:
+	case SPX5_TARGET_CT_7556TSN:
+	case SPX5_TARGET_CT_7558TSN:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int sparx5_create_targets(struct sparx5 *sparx5)
 {
 	const struct sparx5_main_io_resource *iomap = sparx5->data->iomap;
@@ -464,44 +483,45 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		return -ENODEV;
 	}
 
-	switch (freq) {
-	case SPX5_CORE_CLOCK_250MHZ:
-		clk_div = 10;
-		pol_upd_int = 312;
-		break;
-	case SPX5_CORE_CLOCK_500MHZ:
-		clk_div = 5;
-		pol_upd_int = 624;
-		break;
-	case SPX5_CORE_CLOCK_625MHZ:
-		clk_div = 4;
-		pol_upd_int = 780;
-		break;
-	default:
-		dev_err(sparx5->dev, "%d coreclock not supported on (%#04x)\n",
-			sparx5->coreclock, sparx5->target_ct);
-		return -EINVAL;
+	if (is_sparx5(sparx5)) {
+		switch (freq) {
+		case SPX5_CORE_CLOCK_250MHZ:
+			clk_div = 10;
+			pol_upd_int = 312;
+			break;
+		case SPX5_CORE_CLOCK_500MHZ:
+			clk_div = 5;
+			pol_upd_int = 624;
+			break;
+		case SPX5_CORE_CLOCK_625MHZ:
+			clk_div = 4;
+			pol_upd_int = 780;
+			break;
+		default:
+			dev_err(sparx5->dev,
+				"%d coreclock not supported on (%#04x)\n",
+				sparx5->coreclock, sparx5->target_ct);
+			return -EINVAL;
+		}
+
+		/* Configure the LCPLL */
+		spx5_rmw(CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_DIV_SET(clk_div) |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_PRE_DIV_SET(0) |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_DIR_SET(0) |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_SEL_SET(0) |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_ENA_SET(0) |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_ENA_SET(1),
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_DIV |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_PRE_DIV |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_DIR |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_SEL |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_ENA |
+			 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_ENA,
+			 sparx5, CLKGEN_LCPLL1_CORE_CLK_CFG);
 	}
 
 	/* Update state with chosen frequency */
 	sparx5->coreclock = freq;
-
-	/* Configure the LCPLL */
-	spx5_rmw(CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_DIV_SET(clk_div) |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_PRE_DIV_SET(0) |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_DIR_SET(0) |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_SEL_SET(0) |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_ENA_SET(0) |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_ENA_SET(1),
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_DIV |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_PRE_DIV |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_DIR |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_SEL |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_ROT_ENA |
-		 CLKGEN_LCPLL1_CORE_CLK_CFG_CORE_CLK_ENA,
-		 sparx5,
-		 CLKGEN_LCPLL1_CORE_CLK_CFG);
-
 	clk_period = sparx5_clk_period(freq);
 
 	spx5_rmw(HSCH_SYS_CLK_PER_100PS_SET(clk_period / 100),
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 55fc21fbf63d..6aa7b58556e9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -380,6 +380,7 @@ struct sparx5 {
 
 /* sparx5_main.c */
 extern const struct sparx5_regs *regs;
+bool is_sparx5(struct sparx5 *sparx5);
 
 /* sparx5_switchdev.c */
 int sparx5_register_notifier_blocks(struct sparx5 *sparx5);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index 5d5e5c2c05c5..36a5b3c09469 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -16,8 +16,10 @@ static int sparx5_vlant_set_mask(struct sparx5 *sparx5, u16 vid)
 
 	/* Output mask to respective registers */
 	spx5_wr(mask[0], sparx5, ANA_L3_VLAN_MASK_CFG(vid));
-	spx5_wr(mask[1], sparx5, ANA_L3_VLAN_MASK_CFG1(vid));
-	spx5_wr(mask[2], sparx5, ANA_L3_VLAN_MASK_CFG2(vid));
+	if (is_sparx5(sparx5)) {
+		spx5_wr(mask[1], sparx5, ANA_L3_VLAN_MASK_CFG1(vid));
+		spx5_wr(mask[2], sparx5, ANA_L3_VLAN_MASK_CFG2(vid));
+	}
 
 	return 0;
 }
@@ -141,15 +143,19 @@ void sparx5_pgid_update_mask(struct sparx5_port *port, int pgid, bool enable)
 void sparx5_pgid_clear(struct sparx5 *spx5, int pgid)
 {
 	spx5_wr(0, spx5, ANA_AC_PGID_CFG(pgid));
-	spx5_wr(0, spx5, ANA_AC_PGID_CFG1(pgid));
-	spx5_wr(0, spx5, ANA_AC_PGID_CFG2(pgid));
+	if (is_sparx5(spx5)) {
+		spx5_wr(0, spx5, ANA_AC_PGID_CFG1(pgid));
+		spx5_wr(0, spx5, ANA_AC_PGID_CFG2(pgid));
+	}
 }
 
 void sparx5_pgid_read_mask(struct sparx5 *spx5, int pgid, u32 portmask[3])
 {
 	portmask[0] = spx5_rd(spx5, ANA_AC_PGID_CFG(pgid));
-	portmask[1] = spx5_rd(spx5, ANA_AC_PGID_CFG1(pgid));
-	portmask[2] = spx5_rd(spx5, ANA_AC_PGID_CFG2(pgid));
+	if (is_sparx5(spx5)) {
+		portmask[1] = spx5_rd(spx5, ANA_AC_PGID_CFG1(pgid));
+		portmask[2] = spx5_rd(spx5, ANA_AC_PGID_CFG2(pgid));
+	}
 }
 
 void sparx5_update_fwd(struct sparx5 *sparx5)
@@ -164,8 +170,10 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 	/* Update flood masks */
 	for (port = PGID_UC_FLOOD; port <= PGID_BCAST; port++) {
 		spx5_wr(mask[0], sparx5, ANA_AC_PGID_CFG(port));
-		spx5_wr(mask[1], sparx5, ANA_AC_PGID_CFG1(port));
-		spx5_wr(mask[2], sparx5, ANA_AC_PGID_CFG2(port));
+		if (is_sparx5(sparx5)) {
+			spx5_wr(mask[1], sparx5, ANA_AC_PGID_CFG1(port));
+			spx5_wr(mask[2], sparx5, ANA_AC_PGID_CFG2(port));
+		}
 	}
 
 	/* Update SRC masks */
@@ -176,12 +184,16 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 			clear_bit(port, workmask);
 			bitmap_to_arr32(mask, workmask, SPX5_PORTS);
 			spx5_wr(mask[0], sparx5, ANA_AC_SRC_CFG(port));
-			spx5_wr(mask[1], sparx5, ANA_AC_SRC_CFG1(port));
-			spx5_wr(mask[2], sparx5, ANA_AC_SRC_CFG2(port));
+			if (is_sparx5(sparx5)) {
+				spx5_wr(mask[1], sparx5, ANA_AC_SRC_CFG1(port));
+				spx5_wr(mask[2], sparx5, ANA_AC_SRC_CFG2(port));
+			}
 		} else {
 			spx5_wr(0, sparx5, ANA_AC_SRC_CFG(port));
-			spx5_wr(0, sparx5, ANA_AC_SRC_CFG1(port));
-			spx5_wr(0, sparx5, ANA_AC_SRC_CFG2(port));
+			if (is_sparx5(sparx5)) {
+				spx5_wr(0, sparx5, ANA_AC_SRC_CFG1(port));
+				spx5_wr(0, sparx5, ANA_AC_SRC_CFG2(port));
+			}
 		}
 	}
 
@@ -192,8 +204,10 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 
 	/* Apply learning mask */
 	spx5_wr(mask[0], sparx5, ANA_L2_AUTO_LRN_CFG);
-	spx5_wr(mask[1], sparx5, ANA_L2_AUTO_LRN_CFG1);
-	spx5_wr(mask[2], sparx5, ANA_L2_AUTO_LRN_CFG2);
+	if (is_sparx5(sparx5)) {
+		spx5_wr(mask[1], sparx5, ANA_L2_AUTO_LRN_CFG1);
+		spx5_wr(mask[2], sparx5, ANA_L2_AUTO_LRN_CFG2);
+	}
 }
 
 void sparx5_vlan_port_apply(struct sparx5 *sparx5,

-- 
2.34.1


