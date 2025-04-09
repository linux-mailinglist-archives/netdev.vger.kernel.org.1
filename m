Return-Path: <netdev+bounces-180739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB27A824E8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE943B0BB9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4826562E;
	Wed,  9 Apr 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOBgPiLc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA563265602
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201740; cv=none; b=UHT5Eb0rSXbk0Sm+mBJk14DS34WL8ChCryKNwRWTYasYTss7S/K8qGs6heumIeyNL8w1kjKh0YkK05FH3E74zI1m30t9lnnhpCAtTg8X0apKxAGG032jMDSRQu4+fDm/mfV3cdM80MCt61eHxLOCuhC0MZmCK4JKOBtWvlQXLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201740; c=relaxed/simple;
	bh=J9xLiV9s5+LP4+nMsyfGq5xXN09ZieMrue4dIuwiQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3aN3efSvnfNtUOeGyKKXbmk2usXZIoTGqCDlOKd0jci8hSjfId2FCNL2O8lw96aQ/f4WoeNHAnqyp8Ccxk6iXuapicR2tNiMe0sg+UQ7KoMGZp6WLd7VKFJivOWrKEj+7aKtczpcfB9v03wTtZdLozfMucB8c0O4pfFU0Q5eFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOBgPiLc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744201739; x=1775737739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9xLiV9s5+LP4+nMsyfGq5xXN09ZieMrue4dIuwiQ7M=;
  b=fOBgPiLcIHj5h44G/kZZOuF//9BCbiBHAoqvd05xxWqmY2Wav14aOVWg
   9aOpOKle2IGdfy7CTsU3pK0FCvpr7aBacl2UDPtG24XEObAkVjVfyTY3f
   Ck4sTRh4LjbqlJVuZOeB/iWAl9rX82/CmumHNIgwZGXUChZm5ibMuVwp+
   m6MJqn3yrxwfVeGFYmg7QE3YwIjaGBK4E7hLjmKGpdEM9DsBFqF0tDq0X
   tsMzsDMwLsXnEgstr6Ja+kePrzYAmjpnYaF67f9aoYIoitM2au0JXcrYz
   npMcPzRcJi0AW290P2SEoHfi7oYpaXrtQQd773BiAwC+miyUSIcJPXL3L
   w==;
X-CSE-ConnectionGUID: pGYvsmnUQtmyssuSf14njg==
X-CSE-MsgGUID: nJb1VjDERmCA9ovVQjuyoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56655717"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56655717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 05:28:58 -0700
X-CSE-ConnectionGUID: OPXmGF/sR+2e/Dftdd9MCg==
X-CSE-MsgGUID: zI3mjntYRfSOAG08YgGerg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133557274"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2025 05:28:57 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v2 iwl-next 09/10] ice: fall back to TCXO on TSPLL lock fail
Date: Wed,  9 Apr 2025 14:25:06 +0200
Message-ID: <20250409122830.1977644-21-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409122830.1977644-12-karol.kolacinski@intel.com>
References: <20250409122830.1977644-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSPLL can fail when trying to lock to TIME_REF as a clock source, e.g.
when the external clock source is not stable or connected to the board.
To continue operation after failure, try to lock again to internal TCXO
and inform user about this.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 25a805fa0bdd..b81eb6d2a0de 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -490,5 +490,17 @@ int ice_tspll_init(struct ice_hw *hw)
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	return ice_tspll_cfg(hw, tspll_freq, clk_src);
+	err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+	if (err) {
+		dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to predefined frequency. Retrying with fallback frequency.\n");
+
+		/* Try to lock to internal TCXO as a fallback. */
+		tspll_freq = ice_tspll_default_freq(hw->mac_type);
+		clk_src = ICE_CLK_SRC_TCXO;
+		err = ice_tspll_cfg(hw, tspll_freq, clk_src);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw), "Failed to lock TSPLL to fallback frequency.\n");
+	}
+
+	return err;
 }
-- 
2.49.0


