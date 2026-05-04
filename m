Return-Path: <netdev+bounces-283881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAWxFlCx+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB974BFFD6
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C9223047C60
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550A3E51D3;
	Mon,  4 May 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0xHu5v/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E163E51E8
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904701; cv=none; b=eeecYqfPjAhltGpXRYkummQkJU8/0/CW+yPXkYzVGBrmv6yxV5/mm1jiztQN6jFDrsRHG4vxaTVxNNhq4WB6ad4Z5wCpsYd14eiGv5v5chwUwuLUowFec6uHkHDmFgDgKFYGsWWMzJw2YmtTRzk+Ed6IBZwrL6LKLgH58Yz1zAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904701; c=relaxed/simple;
	bh=HeCSJC8AQFIhb51F7c7FJSajP0xoCAzaU8poc4y0+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN6i7va6SwPxUf2uxx+lZ7syyOUra+kB5KziwA2UaZeMtZsvJs9xDDQtnq4ebwqnlmp/Kk9WU6x/6cuVz/GNlAJOFAf3I89si+4+9IC/sf2MgdXet34lWRbemFgdu7aOFxtbSCCCLY6aWtpAP3FRTYMj3VHYOg1GUuqaenFXkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0xHu5v/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904700; x=1809440700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeCSJC8AQFIhb51F7c7FJSajP0xoCAzaU8poc4y0+BU=;
  b=Z0xHu5v/d31uSmPXf7YOKBn8Ow9c7urcGeQ1S9+S6IKTUO14QPoPscR/
   jhK4jVMay35aD7+aPWowKuFunv8zlQjUBMuXDYQmv1CUDy9rg7mtiKbIL
   bSFHeleEPa7DHLo9vl+jlcG0kjC0a80lBZQOMkcs/8zxv5XmaWdIexbhL
   NLvc0y0mdGAIwBOhf2uWk4ITEjm34ZxPA0VPJsFMRyVMXifARTnIf4a0A
   Q47L5DKMEMG2/xYA44wPiQH7ioPuEUwJD+xeHWHYu2MMmvC1yLb1vMIWf
   dOvPMKOyWBTOvZXDyobQkLfmyGA7HqulKrjJGhEeM8qGFZwe9+DI5/5Vx
   Q==;
X-CSE-ConnectionGUID: z5w6qlK8QGqTDZTsYjpfag==
X-CSE-MsgGUID: qCEg9RdpRWWe3ClJkP8cJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78691613"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78691613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:25:00 -0700
X-CSE-ConnectionGUID: ks4DLOgaQMSQv20nfR1PWQ==
X-CSE-MsgGUID: I2mMo+LkQIK8LkynDeGVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230935408"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 07:24:58 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v2 4/5] ice: fix DPLL pin frequency range in CGU pin descriptors
Date: Mon,  4 May 2026 16:24:50 +0200
Message-ID: <20260504142451.4161845-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EB974BFFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283881-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Replace the per-type frequency tables (ice_cgu_pin_freq_1_hz and
ice_cgu_pin_freq_10_mhz) and the two-entry ice_cgu_pin_freq_common array
with a named range constant ICE_CGU_MAX_FREQ_HZ (25 MHz), a new
ice_cgu_pin_freq_range array containing DPLL_PIN_FREQUENCY_RANGE(1,
ICE_CGU_MAX_FREQ_HZ), and a separate ice_cgu_pin_freq_gnss array that
retains DPLL_PIN_FREQUENCY_1PPS for GNSS input pins.

The hardware firmware spec defines an any_freq capability for CGU inputs
(ICE_AQC_GET_CGU_IN_CFG_FLG1_ANYFREQ), but the static pin descriptor
tables constrained configurable pins to 1PPS or 10MHz, preventing users
from setting valid intermediate frequencies. Use a range entry so the
DPLL netlink interface correctly reflects what the firmware will accept.
The firmware validates the actual value and rejects out-of-range requests.

MUX, SyncE ETH port, and configurable EXT pins now advertise the full
frequency range, matching the hardware capability. GNSS input pins retain
the 1PPS-only advertisement since a GNSS receiver is physically
constrained to 1 Hz.

Fixes: 6db5f2cd9ebb ("ice: dpll: fix output pin capabilities")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 128 +++++++++++---------
 1 file changed, 72 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 7b1b402..3949138 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -7,127 +7,143 @@
 #include "ice_ptp_hw.h"
 #include "ice_ptp_consts.h"
 
-static struct dpll_pin_frequency ice_cgu_pin_freq_common[] = {
-	DPLL_PIN_FREQUENCY_1PPS,
-	DPLL_PIN_FREQUENCY_10MHZ,
-};
+/* Maximum frequency supported by CGU pins, in Hz */
+#define ICE_CGU_MAX_FREQ_HZ	25000000
 
-static struct dpll_pin_frequency ice_cgu_pin_freq_1_hz[] = {
-	DPLL_PIN_FREQUENCY_1PPS,
+static struct dpll_pin_frequency ice_cgu_pin_freq_range[] = {
+	DPLL_PIN_FREQUENCY_RANGE(1, ICE_CGU_MAX_FREQ_HZ),
 };
 
-static struct dpll_pin_frequency ice_cgu_pin_freq_10_mhz[] = {
-	DPLL_PIN_FREQUENCY_10MHZ,
+static struct dpll_pin_frequency ice_cgu_pin_freq_gnss[] = {
+	DPLL_PIN_FREQUENCY_1PPS,
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
-	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, 0, },
-	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, 0, },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_gnss), ice_cgu_pin_freq_gnss },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] = {
 	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
-	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, },
-	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, },
-	{ "C827_1-RCLKA", ZL_REF2P, DPLL_PIN_TYPE_MUX, },
-	{ "C827_1-RCLKB", ZL_REF2N, DPLL_PIN_TYPE_MUX, },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_1-RCLKA", ZL_REF2P, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "C827_1-RCLKB", ZL_REF2N, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_gnss), ice_cgu_pin_freq_gnss },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_outputs[] = {
 	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
-	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
-	{ "MAC-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "MAC-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP21",	    ZL_OUT4, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP23",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 };
 
 static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_outputs[] = {
 	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
-	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
-	{ "PHY2-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
-	{ "MAC-CLK",	    ZL_OUT4, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "PHY2-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "MAC-CLK",	    ZL_OUT4, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP21",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CVL-SDP23",	    ZL_OUT6, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 };
 
 static const struct ice_cgu_pin_desc ice_e823_si_cgu_inputs[] = {
 	{ "NONE",	  SI_REF0P, 0, 0 },
 	{ "NONE",	  SI_REF0N, 0, 0 },
-	{ "SYNCE0_DP",	  SI_REF1P, DPLL_PIN_TYPE_MUX, 0 },
-	{ "SYNCE0_DN",	  SI_REF1N, DPLL_PIN_TYPE_MUX, 0 },
+	{ "SYNCE0_DP",	  SI_REF1P, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "SYNCE0_DN",	  SI_REF1N, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "EXT_CLK_SYNC", SI_REF2P, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "NONE",	  SI_REF2N, 0, 0 },
 	{ "EXT_PPS_OUT",  SI_REF3,  DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "INT_PPS_OUT",  SI_REF4,  DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 };
 
 static const struct ice_cgu_pin_desc ice_e823_si_cgu_outputs[] = {
 	{ "1588-TIME_SYNC", SI_OUT0, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
-	{ "PHY-CLK",	    SI_OUT1, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "PHY-CLK",	    SI_OUT1, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "10MHZ-SMA2",	    SI_OUT2, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "PPS-SMA1",	    SI_OUT3, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 };
 
 static const struct ice_cgu_pin_desc ice_e823_zl_cgu_inputs[] = {
 	{ "NONE",	  ZL_REF0P, 0, 0 },
 	{ "INT_PPS_OUT",  ZL_REF0N, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
-	{ "SYNCE0_DP",	  ZL_REF1P, DPLL_PIN_TYPE_MUX, 0 },
-	{ "SYNCE0_DN",	  ZL_REF1N, DPLL_PIN_TYPE_MUX, 0 },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "SYNCE0_DP",	  ZL_REF1P, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "SYNCE0_DN",	  ZL_REF1N, DPLL_PIN_TYPE_MUX,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "NONE",	  ZL_REF2P, 0, 0 },
 	{ "NONE",	  ZL_REF2N, 0, 0 },
 	{ "EXT_CLK_SYNC", ZL_REF3P, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "NONE",	  ZL_REF3N, 0, 0 },
 	{ "EXT_PPS_OUT",  ZL_REF4P, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0 },
 };
 
 static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
 	{ "PPS-SMA1",	   ZL_OUT0, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "10MHZ-SMA2",	   ZL_OUT1, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
-	{ "PHY-CLK",	   ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
-	{ "1588-TIME_REF", ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "PHY-CLK",	   ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
+	{ "1588-TIME_REF", ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "CPK-TIME_SYNC", ZL_OUT4, DPLL_PIN_TYPE_EXT,
-		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
+		ARRAY_SIZE(ice_cgu_pin_freq_range), ice_cgu_pin_freq_range },
 	{ "NONE",	   ZL_OUT5, 0, 0 },
 };
 
-- 
2.52.0


