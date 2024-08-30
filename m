Return-Path: <netdev+bounces-123648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4496604C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB01C22E03
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51F19ABD5;
	Fri, 30 Aug 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXxW+1nS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E7190685
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016243; cv=none; b=qjJzqWEVUw+xxwT1oAh3wS6gfKtbM1/Beb4v6fwCE4YEMWW07AhvqIYbPloV9mvZFJmXWGGT3b18WbiiRzKELtSppRCgrj+R0ItrrWZW5YngHE4Zs2AoIVeEAoCCD6Jcw26+x9BM1lsTuwDzcjTXDMXLPU6jcw2ik+9xqADjQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016243; c=relaxed/simple;
	bh=tKnPTu0sKsUolgfaknV08Jbr9xf/S4C5cERyTobmygc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGeajAbnJMrlXYuZ5hJqKPnOGKTSgMrIOBnqQBx6B78luMslhcQtxGUe/B7DdO6LOhJ+bwMmsob4qfEGFPdB5aEzngfU+K7pyydrPluHVtzmrRa9RitGhh9MPCEV7wT8ssj3QIbxtNUUFDXq2TdM46CP7WwxV1KI20gHCnLM5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXxW+1nS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725016242; x=1756552242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKnPTu0sKsUolgfaknV08Jbr9xf/S4C5cERyTobmygc=;
  b=LXxW+1nSQ1YXi+gu72ycRm964YrqiPpRJOIc5jJ8FzcMqZGdvXSPgukU
   ZvrmrFYXLgQMS0mADAPS/Jm9k0ll+KO7PHuptAugCVCFdzpplMwkFT+sZ
   0477uZ+F6Zc92XBYYn/nuFk+bNCDTA39Kz+PwU6TKuTQpHKska76/jDI9
   3H38T5YX3U9oSwacqd94sG2vgW7S5ASb3gOu8ah65CjTQJmB9w/WkRzfE
   8iIBWbmCAdR9hWS68G3mBQNljcD0RXWY/5oeNlX5iKlSt9VcrPq8+htvu
   QVDPgpB8kCoCNIVtKBdMCkv/k81ASYLD4w7+IlreYnJVKADYkpoUaV2KX
   A==;
X-CSE-ConnectionGUID: C6C8j6rgRVq4MUKQTuar8A==
X-CSE-MsgGUID: rwEDohCOTEuWRGrgnfVIbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23517584"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23517584"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:10:42 -0700
X-CSE-ConnectionGUID: vXIhqjaSR6OdAb7UYAq3nA==
X-CSE-MsgGUID: gyWOcw3LS4iIyVseqKtNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68273565"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 04:10:39 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v4 iwl-next 2/7] ice: Add SDPs support for E825C
Date: Fri, 30 Aug 2024 13:07:18 +0200
Message-ID: <20240830111028.1112040-11-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830111028.1112040-9-karol.kolacinski@intel.com>
References: <20240830111028.1112040-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of PTP SDPs (Software Definable Pins) for E825C products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
V1 -> V2: Removed redundant n_pins assignment and enable and verify move

 drivers/net/ethernet/intel/ice/ice_ptp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 34ce1a160f73..9879a6f2150d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -20,6 +20,16 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
 	{  ONE_PPS,   { -1,  5 }},
 };
 
+static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
+	/* name,        gpio */
+	{  SDP0,      {  0,  0 }},
+	{  SDP1,      {  1,  1 }},
+	{  SDP2,      {  2,  2 }},
+	{  SDP3,      {  3,  3 }},
+	{  TIME_SYNC, {  4, -1 }},
+	{  ONE_PPS,   { -1,  5 }},
+};
+
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	/* name,      gpio */
 	{  SDP0,    {  0, 0 }},
@@ -2605,8 +2615,14 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 #endif /* CONFIG_ICE_HWTS */
 	pf->ptp.info.enable = ice_ptp_gpio_enable;
 	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	ice_ptp_setup_pin_cfg(pf);
 }
 
-- 
2.46.0


