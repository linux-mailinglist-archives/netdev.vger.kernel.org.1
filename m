Return-Path: <netdev+bounces-142760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646989C041E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0737EB23336
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640F20ADEE;
	Thu,  7 Nov 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eh45QVKo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0591E1C37
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979188; cv=none; b=gncamHOnsH9fhNhyqIKq4fqh60jZPfgjMZH/n+cSCcGt79lWi7lwHZtjuTIan3NnTKtN2GdFrTO/hhslcByrlIflVvsLyCaJaozoMKfpWLSfM4Zjp8ob2Ol52wLvERpJzB+VncbTG/4/ODUItEPwpecMNnbmKlQzLByL/GviLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979188; c=relaxed/simple;
	bh=KRVHB01OEq83mExTpA4ZzpE7Xo88aH3410IvN5uxHWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GKLGCHws/L3iw6o4LpB2b9JstYOFLpyk7fL9PBwrMbAbt/bCU4tp0M467tsp2DBQcj+ZIbdZBZ/4cnPIzrmddhc7MLZ05Szw9Tua3J8igezmwbnkQj9Ule2SnsvJglaradjJUPy9Nq2ZIR3KxhojLjw4vzcQET7Uh5TNzweUuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eh45QVKo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730979187; x=1762515187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KRVHB01OEq83mExTpA4ZzpE7Xo88aH3410IvN5uxHWk=;
  b=eh45QVKocxp1A5sg47ATDFymIT+7a+gbO5N8iu4cBEr6h+VRxEMRsjNx
   vh71Of8mBtVUsu+MmBB1oNSk79UOorf9aPk8ftDzeEnbNYNvRxUD+HmuQ
   1JorbiwGfHTdTZvespp3TYzVNyGtq9XgFYRh+lvgiZNfeqvPzXbItKKoi
   3SQnR+et3danCKn/a8mI4EVJraoV3mbgSMlSaDQpRdVFERqUigRbMy5jR
   A7cEFjtJh88iDqgLOIQIir9Zf+iyNRzXYQMBAsHdKBY3IatOZHaxIXGVR
   NYK16XLnDa1xBGLT6kNP5aFRpUF+QsFNYqlSTEeZ75JW9aXUcx8uWWKAy
   g==;
X-CSE-ConnectionGUID: NLmdq8eoT4S9TUlnKT4tig==
X-CSE-MsgGUID: WBKP8gZeQcygcJuUcW0mmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34511376"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34511376"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 03:33:06 -0800
X-CSE-ConnectionGUID: tuil7a0rRwuwWD44FeHLTA==
X-CSE-MsgGUID: 95ZP8vY2RkylPARCfeqhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="85146542"
Received: from pae-dbg-r750-02-263.igk.intel.com ([172.28.191.215])
  by orviesa006.jf.intel.com with ESMTP; 07 Nov 2024 03:33:04 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: fix PHY timestamp extraction for ETH56G
Date: Thu,  7 Nov 2024 12:32:57 +0100
Message-Id: <20241107113257.466286-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix incorrect PHY timestamp extraction for ETH56G.
It's better to use FIELD_PREP() than manual shift.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ec8db830ac73..3816e45b6ab4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1495,7 +1495,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
+	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) |
+		  FIELD_PREP(TS_PHY_LOW_M, lo);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6cedc1a906af..4c8b84571344 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -663,9 +663,8 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define TS_HIGH_M			0xFF
 #define TS_HIGH_S			32
 
-#define TS_PHY_LOW_M			0xFF
-#define TS_PHY_HIGH_M			0xFFFFFFFF
-#define TS_PHY_HIGH_S			8
+#define TS_PHY_LOW_M			GENMASK(7, 0)
+#define TS_PHY_HIGH_M			GENMASK_ULL(39, 8)
 
 #define BYTES_PER_IDX_ADDR_L_U		8
 #define BYTES_PER_IDX_ADDR_L		4

base-commit: 333b8b2188c495a2a1431b5e0d51826383271aad
-- 
2.31.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


