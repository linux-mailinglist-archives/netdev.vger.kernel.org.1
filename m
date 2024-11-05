Return-Path: <netdev+bounces-141974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528F9BCCCF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C1D1C222E5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138D1D54E1;
	Tue,  5 Nov 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3mxtM4t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308001D5AAE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809971; cv=none; b=ZWSqU3ZwZ1r71CnIuMuvTBAifPbgRNoByNq/nu4x278B34p4xfvvQHGIFIkSfQ7eK1DAdtyTu/p9X63C2sZ41TE9hp8jsWRxuLOQXVI0ZUwkyXcmxiRJKbhXOf+RCNHzaAbq0Z/N8njlZzhJlZGxsTPN4ZZQUFQl3YrS8W7Awo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809971; c=relaxed/simple;
	bh=4ww874tZ0f5tEzLjU78wbUg7StgUhmJ1cvMZdu7uRWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyFUNFllDvNrHKobRaas2+z2YstXWEEe/hE2Ad99Y0bWPNvqB0TbXm5Kd9kprIIocsECoVeqQ0fEhgCylySnyYAYlg/OnqCuh+ZHDmJmuyqNazQLmuPSPfHhetbAc3VXYWI7Dj3iIxj+1QZovlxD+WxdD7vgx+uZNEI6Bpu9zRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3mxtM4t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730809970; x=1762345970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ww874tZ0f5tEzLjU78wbUg7StgUhmJ1cvMZdu7uRWc=;
  b=a3mxtM4twvPBuPCIsLeRH6rmUucXQ+Odkduem8Vl5SXrs8bGtOzVjQtf
   Fx1Z1Kfb5pafG+olpGFrJOIQ8VErHPNCxH29CZ7TQEHXbG0NI4BV2SkwN
   4babajEyEk2i+fS+fMCCK5YMOsXl5QXruVfBNUh+Z4b6ACbhdS9TqGGZX
   YtcfczMivZYQEN1illEgZKzmqEzevWNx5VN2PKKM373i8Xw93J58L95xO
   Lo4zgzANnk5enVHqMC8JsqPgUzsCcHB7cnYhh4IRq8TC4GAift2x2KXBN
   3I9qXFMCf5ViKyxjBu0G0gAIeLiTtuo0v/PCzEhVoP0D7dz8krkA3Z8OA
   Q==;
X-CSE-ConnectionGUID: RyBLksLzQ42tzjI+u20Hnw==
X-CSE-MsgGUID: AIej3/GtSbSAa/Nsv9n9vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29976264"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="29976264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 04:32:49 -0800
X-CSE-ConnectionGUID: K6cdYE7MRpyrVig9Ejs2Tw==
X-CSE-MsgGUID: QWaETA9PTTetdDSNvAe5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="121481364"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2024 04:32:48 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v4 iwl-net 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Tue,  5 Nov 2024 13:29:15 +0100
Message-Id: <20241105122916.1824568-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
References: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index e6980b94a6c1..6620642077bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -131,7 +131,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.39.3


