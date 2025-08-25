Return-Path: <netdev+bounces-216675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9930B34E68
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7F5169C2A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002372BDC28;
	Mon, 25 Aug 2025 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNFO3pD/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB329D26B
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158629; cv=none; b=bWPaHHqvUJ1j2m+I4irVSvpepfsttfAft5V0OZZFWocepAb+ecyhWCvfzFH13dIjV31MxQEURjk+MkZqKogWU/WyTZN+8HchWLaHU0d6s/cgQDHNWtvXDG4N+0LUPuLMbLrHAtqShPF0k3YRn0Zac9PwSoUPfoy+CjIplO+98Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158629; c=relaxed/simple;
	bh=HAej9FtmhKJFTZZZCzrwFU1VTVFrN2qFJEd2CMP2JTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJEj+dqCNNxi5yLY5VHLkRIqLCHhihoaMc4yBzOmC1wDyxMkkn1IRi158gXZdkM920xq1wZG1FyEHdxS2oTDd8S6oHzkaYvpbD8N3BwSfW7Jv4J+2v8nzaaJ2Y/Rsg0Lw6xIc8GCYXy4JVMMEWH/UUlIzTahF9lfhpk9ZOFw02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNFO3pD/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158629; x=1787694629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HAej9FtmhKJFTZZZCzrwFU1VTVFrN2qFJEd2CMP2JTs=;
  b=bNFO3pD/7vO2m5m73v+SrBsiko3Qu7ky5MDXRMUC4fCXsq6o80mGK065
   efV8xvW/uUOPJ+fk0XcJ4MYShcJlksB6xffoMLsqfjBLIxkluTThq1u62
   4Gk4DFJg0/PkNp1i5Lr5C9QayerPcs0orIkKPpeWsyVuEKuJcc6Ceaw5U
   grCrDbs1vOG/1Ke3SLZ3NQmxxN1LtF5LToRY2ooggH2I46W9v2A4+1s08
   9T/6hK67nlTLLJfNigy2n8uqMchZ1GfeCZFf7KFA+kRdtdmxgmN1n1snE
   +tUidlZDCJe11QJdmrDQQqvX7ttlY78XQbn5ojEpOQKTFUbUmpSE0gXrw
   g==;
X-CSE-ConnectionGUID: RQs9Wv+8R6qG4FHCg31f1g==
X-CSE-MsgGUID: onDD0fCCRTKn0c4g4UJ1Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651392"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:27 -0700
X-CSE-ConnectionGUID: OdzHGsQEQGOuw+HyooaCpQ==
X-CSE-MsgGUID: OuHBEeQ8RCWVyQJcEiyF2w==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 5/5] ixgbe: fix ixgbe_orom_civd_info struct layout
Date: Mon, 25 Aug 2025 14:50:16 -0700
Message-ID: <20250825215019.3442873-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

The current layout of struct ixgbe_orom_civd_info causes incorrect data
storage due to compiler-inserted padding. This results in issues when
writing OROM data into the structure.

Add the __packed attribute to ensure the structure layout matches the
expected binary format without padding.

Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index d74116441d1c..bfeef5b0b99d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3125,7 +3125,7 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
 	if (err)
 		return err;
 
-	combo_ver = le32_to_cpu(civd.combo_ver);
+	combo_ver = get_unaligned_le32(&civd.combo_ver);
 
 	orom->major = (u8)FIELD_GET(IXGBE_OROM_VER_MASK, combo_ver);
 	orom->patch = (u8)FIELD_GET(IXGBE_OROM_VER_PATCH_MASK, combo_ver);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index d2f22d8558f8..ff8d640a50b1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -932,7 +932,7 @@ struct ixgbe_orom_civd_info {
 	__le32 combo_ver;	/* Combo Image Version number */
 	u8 combo_name_len;	/* Length of the unicode combo image version string, max of 32 */
 	__le16 combo_name[32];	/* Unicode string representing the Combo Image version */
-};
+} __packed;
 
 /* Function specific capabilities */
 struct ixgbe_hw_func_caps {
-- 
2.47.1


