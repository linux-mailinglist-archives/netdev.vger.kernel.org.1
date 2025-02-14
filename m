Return-Path: <netdev+bounces-166449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54803A3604F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E711708DD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9B266581;
	Fri, 14 Feb 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYjqkBwl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDC5BAF0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543063; cv=none; b=EEFnzY7N4/wE4VK2lYenXgiH+/Ia+jepoiYagY2xOygxLNhjDdH3M+HJezlckvEYSgY5W6bh9YuYaG9Rwk3WrK+1gHPIBqib1cVfxhvuqP0C+2LQESVpk6nPybCG9XZ5dWNvmf5R0yuSk7SBZ40H22ux6TWkXmhfEsfF1gpXJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543063; c=relaxed/simple;
	bh=PbgmwF6e2fnA/7tL35h6OZILzogHTu+bacTrdHsmx8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6snWGf6k/xmuNPdcKytNLpBcZyMICtRWBPc3vw9T2niqkIUrFguSdHwTc6Lk0BM0yBiU11SbxN0aSKr1EdXe91w9vM2jLxokMnumQNgMt8o9NYt0dcH+TtqaW6PsX6bpbsNZ76CQ5lKGuIbhmbouhUy5IBJNQCZx4N2IjNka/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYjqkBwl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739543061; x=1771079061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbgmwF6e2fnA/7tL35h6OZILzogHTu+bacTrdHsmx8o=;
  b=cYjqkBwlQOnthSdkBeQshLMG0CiJwPi8/IEuj3yFsTut845+YvQ3fqQw
   ndSRubT3F/2Dd4U19J7MH/a/uWnqdYGnXEOenHtKB+fGQLz6AOJZMSBc9
   MzWv0UYwJvmcwOauL+Q+bVyDdjZMIJrT8Nhhp/HBEcewzQOg6RSgOq3sW
   xOM5x3dSqftZciSaW9yEheRzH1sc2Wbh8dCNJ3jrrcDb0QN/Aqi8hzUIX
   oyPfAE1ypSwJEE0+gMiytQsQ4zVo33NWMpMfAVs0ey0YyK27W06JHQlOu
   rflcxvgAW0c0jLY8HnmIsAS4ScIVcYraKCxGrNoNTVEwk9HxdqwVQQUDk
   Q==;
X-CSE-ConnectionGUID: K7Sj719PSd2Dont0icequQ==
X-CSE-MsgGUID: XwOHIOT9SbOx02iVP/ifQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40154931"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40154931"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:24:20 -0800
X-CSE-ConnectionGUID: QRKRF6ChT+WyVul8tyFtnQ==
X-CSE-MsgGUID: 5ddJ4IguTvKn0WqUETqWmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118093373"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa005.fm.intel.com with ESMTP; 14 Feb 2025 06:24:19 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next v2 3/3] ice: add ice driver PTP pin documentation
Date: Fri, 14 Feb 2025 15:18:36 +0100
Message-Id: <20250214141836.597747-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250214141836.597747-1-arkadiusz.kubalewski@intel.com>
References: <20250214141836.597747-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a description of PTP pins support by the adapters to ice driver
documentation.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
v2:
- no change, updated series
---
 .../device_drivers/ethernet/intel/ice.rst           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 3c46a48d99ba..0bca293cf9cb 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -927,6 +927,19 @@ To enable/disable UDP Segmentation Offload, issue the following command::
 
   # ethtool -K <ethX> tx-udp-segmentation [off|on]
 
+PTP pin interface
+-----------------
+All adapters support standard PTP pin interface. SDPs (Software Definable Pin)
+are single ended pins with both periodic output and external timestamp
+supported. There are also specific differential input/output pins (TIME_SYNC,
+1PPS) with only one of the functions supported.
+
+There are adapters with DPLL, where pins are connected to the DPLL instead of
+being exposed on the board. You have to be aware that in those configurations,
+only SDP pins are exposed and each pin has its own fixed direction.
+To see input signal on those PTP pins, you need to configure DPLL properly.
+Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
+DPLL output pins have to be manually configured.
 
 GNSS module
 -----------
-- 
2.38.1


