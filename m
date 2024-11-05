Return-Path: <netdev+bounces-142109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D49BD873
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C841F23AAE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D20216447;
	Tue,  5 Nov 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8eJJVEK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371321642E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845442; cv=none; b=RzJJQclMlm05287heFAfjA5DjRBbjNxp7dj40U7ww2sMrU/s8olgdMTTtNa6D0UWW3liquW1Wb8SvIrEgp8wcxXwDmhvRYqqnXWaqGEBKRNPYvmahb41+iyMbxHRW/vO+x9zn0/sYXtwyVNbT3AkHmGt9eeewKnDrYJ8WZzKShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845442; c=relaxed/simple;
	bh=MlrPDZG/cfHmqD51yMuz9krG6ygJmuwjZprSgruHJV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0WLsjhozAnX3lrc/siEtvhqRYdox+KHMj1ZpO5rKWIGg9wBb+BFUEfceLPdxwCphk6/R0wUIpVz9ZzfPKynB8a9dC99k28lL7fqxXwi2/9H0zaqSrOQ+H1ZM/wRuhDJtPZlHlOvtqegYWTYIpC8E6pFJxWqcnSCZQRqnX8EOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8eJJVEK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845441; x=1762381441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlrPDZG/cfHmqD51yMuz9krG6ygJmuwjZprSgruHJV4=;
  b=C8eJJVEKzPn/qU6ULzfJGxJbVm4qwsKWFKSw4M4o57O9hnAvqiWP7rC2
   FbqEIEJmdzIQIfc6ZGk+xD6bAI9g4nGkexzb4VOBDaAg8YMrDlSEKhITG
   3EHxcpSEyOMdev9mPc5/yOGhxWbnA17Oj7zLd92yiMIF3BoP6NOG33+PV
   8v4nyIGV3KrLcpzE4eV1yL4QJjhnOcEbCkyAeOTUKA/EJrdtcqufPj+q/
   /CokSuEQEQ1ecER7l3l95xJVwbFaW2gdKKymUT2KH6h8tSS0phdgt8QEG
   xnPcHUQKgzj+veyV2upW+zKTL7HmhgFQDB5G8WB/Q10z6+sXsqlq+yR6x
   A==;
X-CSE-ConnectionGUID: 9C6uhhoGQXi+jcbvrSKciQ==
X-CSE-MsgGUID: 3RC8Pn4xQ0qr75nceyUR1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314256"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314256"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:00 -0800
X-CSE-ConnectionGUID: gqFxzGXYQ6CF8+uE5X9cjw==
X-CSE-MsgGUID: csvASfcvS5uPAimaOXllog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322434"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:23:58 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 03/15] ice: extend dump serdes equalizer values feature
Date: Tue,  5 Nov 2024 14:23:37 -0800
Message-ID: <20241105222351.3320587-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Extend the work done in commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") by adding the new set of
Rx registers that can be read using command:
  $ ethtool -d interface_name

Rx equalization parameters are E810 PHY registers used by end user to
gather information about configuration and status to debug link and
connection issues in the field.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.h    | 17 +++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1f01f3501d6b..1489a8ceec51 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1492,6 +1492,23 @@ struct ice_aqc_dnl_equa_param {
 #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_BW (0x23 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN (0x30 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN2 (0x31 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_2 (0x32 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_3 (0x33 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_4 (0x34 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_5 (0x35 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_6 (0x36 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_7 (0x37 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_8 (0x38 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_9 (0x39 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_10 (0x3A << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_11 (0x3B << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_12 (0x3C << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_TX_EQU_PRE1 0x0
 #define ICE_AQC_TX_EQU_PRE3 0x3
 #define ICE_AQC_TX_EQU_ATTEN 0x4
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 19e7a9d93928..3072634bf049 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -711,6 +711,23 @@ static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
 		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
 		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
+		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
+		{ ICE_AQC_RX_EQU_CTLE_BW, rx, &ptr->rx_equ_ctle_bw },
+		{ ICE_AQC_RX_EQU_DFE_GAIN, rx, &ptr->rx_equ_dfe_gain },
+		{ ICE_AQC_RX_EQU_DFE_GAIN2, rx, &ptr->rx_equ_dfe_gain_2 },
+		{ ICE_AQC_RX_EQU_DFE_2, rx, &ptr->rx_equ_dfe_2 },
+		{ ICE_AQC_RX_EQU_DFE_3, rx, &ptr->rx_equ_dfe_3 },
+		{ ICE_AQC_RX_EQU_DFE_4, rx, &ptr->rx_equ_dfe_4 },
+		{ ICE_AQC_RX_EQU_DFE_5, rx, &ptr->rx_equ_dfe_5 },
+		{ ICE_AQC_RX_EQU_DFE_6, rx, &ptr->rx_equ_dfe_6 },
+		{ ICE_AQC_RX_EQU_DFE_7, rx, &ptr->rx_equ_dfe_7 },
+		{ ICE_AQC_RX_EQU_DFE_8, rx, &ptr->rx_equ_dfe_8 },
+		{ ICE_AQC_RX_EQU_DFE_9, rx, &ptr->rx_equ_dfe_9 },
+		{ ICE_AQC_RX_EQU_DFE_10, rx, &ptr->rx_equ_dfe_10 },
+		{ ICE_AQC_RX_EQU_DFE_11, rx, &ptr->rx_equ_dfe_11 },
+		{ ICE_AQC_RX_EQU_DFE_12, rx, &ptr->rx_equ_dfe_12 },
 	};
 	int err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 98eb9c51d687..8f2ad1c172c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -16,6 +16,23 @@ struct ice_serdes_equalization_to_ethtool {
 	int rx_equ_bflf;
 	int rx_equ_bfhf;
 	int rx_equ_drate;
+	int rx_equ_ctle_gainhf;
+	int rx_equ_ctle_gainlf;
+	int rx_equ_ctle_gaindc;
+	int rx_equ_ctle_bw;
+	int rx_equ_dfe_gain;
+	int rx_equ_dfe_gain_2;
+	int rx_equ_dfe_2;
+	int rx_equ_dfe_3;
+	int rx_equ_dfe_4;
+	int rx_equ_dfe_5;
+	int rx_equ_dfe_6;
+	int rx_equ_dfe_7;
+	int rx_equ_dfe_8;
+	int rx_equ_dfe_9;
+	int rx_equ_dfe_10;
+	int rx_equ_dfe_11;
+	int rx_equ_dfe_12;
 	int tx_equ_pre1;
 	int tx_equ_pre3;
 	int tx_equ_atten;
-- 
2.42.0


