Return-Path: <netdev+bounces-196469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B4AD4EB8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DECB7A8F26
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0F2367AA;
	Wed, 11 Jun 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlXwsjXp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86A1865E3
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631576; cv=none; b=RzfvN3t8dIriYccS4bhGHVmN5YNJvOvXfQhxdFRj8kB0D8UCZkEYadWDve/0qkhWQRpNdpoDBAJLfn59dDTmw6+s+X6oQjQhPNkYiGDxnkMCkJApMYN1w4vEpyfbZ2Uo0/Kv3J8LfnG7JO6ihhbIW3avbdj0wuIsNwFw1HgLb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631576; c=relaxed/simple;
	bh=+EJID00wMU0CMhNgIlxGBSLKn9EwUE2jNBcMpJETq5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fiXR6Wg+1X4zUL1LnPFYeFnEW540XtGr3n8Bx6q3gWsZ79tKf1B1l92mYb0BoDzegfaSTIaNiYRt3THec0cTV/CAEIfS7ZnhTbG+WMi2qDAqQtYfFl1jCWuYu1ETuknWlRJrfCeYghfeqWBA6GMZIt90Ngv1+qCHAiqRFlo1iO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlXwsjXp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749631575; x=1781167575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+EJID00wMU0CMhNgIlxGBSLKn9EwUE2jNBcMpJETq5Q=;
  b=GlXwsjXpsY5akWqSrYJrZJGm9BpZvNsRf+OW4jw15WCvRL1qC+3V2xVs
   tgkFpm6FK1efabHQ0nrLrj9TUKjEWwFfPW1DldmrrpxDVJ+/DzKWvDJp7
   6Sqt5sFySuzYRbHOpnaXpQWDPtfJM0Crt2SeZlR5fwbvnIHLwn3sYF0hB
   5vn+fL3GMjYDKYQKARpy8VywUqMC3CAsSD1Xq4S9t7nvJrhRiU2xa/zel
   4+yegMcXU8Hz1MH2wK0qchGyUtDk18hQTzqRw0ro+A2Tes9sOw+sU4ClC
   lGspnlWv4y+yMfT3jdTO6oY9AbGx9dqB0XfWlPqbe2AixiFBrBQEG2LLt
   A==;
X-CSE-ConnectionGUID: wWN7nz50TF6DfCysAYFaqg==
X-CSE-MsgGUID: DelZugv8Qsy3bASxQSaVLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62046156"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62046156"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:46:15 -0700
X-CSE-ConnectionGUID: thoy8T2+QNuP2iXRkgkIYA==
X-CSE-MsgGUID: rJ7Q8BrsRTKPLsI8iR4i6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152298386"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 01:46:14 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EAF52332AE;
	Wed, 11 Jun 2025 09:46:12 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v1 2/3] ice: add overwrite mask from factory settings
Date: Wed, 11 Jun 2025 11:01:21 +0200
Message-Id: <20250611090122.4312-3-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250611090122.4312-1-konrad.knitter@intel.com>
References: <20250611090122.4312-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for restoring settings and identifiers from factory settings
instead of using those found in the image.

Restoring data from factory settings requires restoring both settings
and identifiers simultaneously. Other combinations are not supported.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 Documentation/networking/devlink/ice.rst       | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 792e9f8c846a..c11c7bc1362c 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -222,6 +222,12 @@ combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
        identifying fields such as the MAC address, VPD area, and device
        serial number. It is expected that this combination be used with an
        image customized for the specific device.
+   * - ``DEVLINK_FLASH_OVERWRITE_SETTINGS``, ``DEVLINK_FLASH_OVERWRITE_IDENTIFIERS``
+       and ``DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS``
+     - Do not preserve either settings or identifiers. Overwrite everything
+       in the flash with contents of the factory settings section instead of
+       provided image.
+
 
 The ice hardware does not support overwriting only identifiers while
 preserving settings, and thus ``DEVLINK_FLASH_OVERWRITE_IDENTIFIERS`` on its
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index d86db081579f..f869648939bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -1008,6 +1008,10 @@ int ice_devlink_flash_update(struct devlink *devlink,
 					      DEVLINK_FLASH_OVERWRITE_IDENTIFIERS)) {
 		/* overwrite both settings and identifiers, preserve nothing */
 		preservation = ICE_AQC_NVM_NO_PRESERVATION;
+	} else if (params->overwrite_mask == (DEVLINK_FLASH_OVERWRITE_SETTINGS |
+					      DEVLINK_FLASH_OVERWRITE_IDENTIFIERS |
+					      DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS)) {
+		preservation = ICE_AQC_NVM_FACTORY_DEFAULT;
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Requested overwrite mask is not supported");
 		return -EOPNOTSUPP;
-- 
2.38.1


