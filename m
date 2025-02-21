Return-Path: <netdev+bounces-168475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976BFA3F1DB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BDA166756
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70466204587;
	Fri, 21 Feb 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBmt2OnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EC205504
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133192; cv=none; b=f5SreBFUoWZ1+9irAsP2fmCgAvgV4sFbMKC7aDQsZPCfAHiNJ9yQGsYdlxFWVOlCz53hq3TkjDtgS0uPBzQi0TBChGvmGt22jczVqEYf851J7NmeATYt6yGDFptfV3O3EZB+K1rhyiU6DV8wl+rBK1jT8a0sVpmG5Azjid6jUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133192; c=relaxed/simple;
	bh=JYyOnp/OuwO4wl7taJd+x0fNGeIDkomWjxqgmJienSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JFhDFlItb4GGZqzKhIBFG/e/9ZSyxEa/doND6i04sJnDKb1caSZmmsYI+DOvBS2N4LOi3OliAwKvKQy+/be9jxVBZ4KYVK9KhbTcvZUz9JISSNOOGLvb6m9zjMkkc4HVS1h+LjPooXGS2bgrbEmjWYmoyQPraIviTIXlZlH9FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBmt2OnZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740133190; x=1771669190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JYyOnp/OuwO4wl7taJd+x0fNGeIDkomWjxqgmJienSI=;
  b=XBmt2OnZNNdZW7M6qRNQ913eNHbx+bbDymFZ+9EIkiucSKoWpno4c9WW
   SF2GijI7EimPj8Yc3V7xfEDgWv4OvZmASgCp+83ExcTx0Bmwdt8/7ejwE
   rUIgqbGyFvGyDsH/hRf9kq+W2HlMcxERZEiI9xaHIY6oT+ElshZBTCcvE
   TJYPnUvxx3/r5Pbh0T3b2eoed8mOWOdAkzPF7cNVEiEF5vBgRRucPIDiH
   +eU9OaYdLcGqrz+j8tv4kfNh8fZFcXiQZi7K1y5jyAHOK7GsRiFTnqu9F
   4gZ8snKzs+O/1StJv7BusALtJ06onzxi771rJRDN7rsGjh7b30Zr97Gxt
   Q==;
X-CSE-ConnectionGUID: FSunxCigTvGB9rHHOGI5Gw==
X-CSE-MsgGUID: Sf65QnfuRS2COXKLFR1yHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52378415"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52378415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 02:19:49 -0800
X-CSE-ConnectionGUID: q8y8ZRXsSse4wET1gGMeNQ==
X-CSE-MsgGUID: XwlGBv8oQpedO21xoIX0KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152528112"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 21 Feb 2025 02:19:48 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] ice: Allow 100M speed for E825C SGMII device
Date: Fri, 21 Feb 2025 11:16:08 +0100
Message-Id: <20250221101608.2437124-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E825C 10GbE SGMII device to the list of devices supporting 100Mbit
link mode. Without that change, 100Mbit link mode is ignored in ethtool
interface. This change was missed while adding the support for E825C
devices family.

Fixes: f64e189442332 ("ice: introduce new E825C devices family")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a2a2e8da8fa..caf3af2a32c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3180,6 +3180,7 @@ bool ice_is_100m_speed_supported(struct ice_hw *hw)
 	case ICE_DEV_ID_E822L_SGMII:
 	case ICE_DEV_ID_E823L_1GBE:
 	case ICE_DEV_ID_E823C_SGMII:
+	case ICE_DEV_ID_E825C_SGMII:
 		return true;
 	default:
 		return false;

base-commit: c4813820042d447c687cf4f1d5e240740638e586
-- 
2.39.3


