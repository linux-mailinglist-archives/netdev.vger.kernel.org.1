Return-Path: <netdev+bounces-83249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC2891790
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D03286AB1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0D381BD;
	Fri, 29 Mar 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUf8Q68O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41313AF2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711427; cv=none; b=STE/4+36QlKV2MktMdkS/4pqlcPE43lT4oi4CHav1Fe/ei3Xd9uvhBGFKX7cPI2Y9SpAALbwcExyKaaNL1jxuPE84iF+XMEyZKDqybE4JlrR+iDW3KrIbRTjfpC17m2B6gWPSKFo7P9KHgOj5VW8StvInYfT1lUelrjzjlGtYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711427; c=relaxed/simple;
	bh=Zyiddza1bIuKIDl1i6Jr4CeTZ0fTMIZ3uw0n4da+wNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do6htVtzUsBRRJTpvqbk5YuVW9RUYgux5mWFC7f89X492Jw1Eka5+5GJY60vP7g+Kl7ukvMaLt8s+GDGJztX+rrpcKLljpjwoKPmBP3LvBblI1spvrXOyYDm82ew08mcw3EpSBLzzoO41qJNR6thSymU+djCvUnhPMagXStm3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUf8Q68O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711425; x=1743247425;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zyiddza1bIuKIDl1i6Jr4CeTZ0fTMIZ3uw0n4da+wNY=;
  b=VUf8Q68OQi9HPLM7TKRwnUzO7DsMcq734+PkQDeHMH0X/OuLg+LxVYR7
   ijxUoqa8CRmAEeaY4IIlmKHhwtYXTjalkQKnBtwOj0h7YwGfHKi9Xu/Fm
   kBz+vJOB7/ZZbGOpV1qSN1lTlUZqFFMQY6jIKwvc5s3lw9yh1hgOjsySp
   dQ5OZAYReVsE/6ezuaKkjfOqTRZ+eKOX1/vZEWzCXPuRAFL3+qiq/Unab
   0EAYszkWa7Y2alN0zfTrNEFATbMcRTgoSJR0jHk9SCV4NkzKlNpCbKW4X
   pJoE0pcqW0eS6j4+RDqG3kMUrKy2QGR0AEJdErTkce1vxl2F3Wgp8gGZ2
   A==;
X-CSE-ConnectionGUID: 6xAQK/yxR5qBhmC8RG5oQQ==
X-CSE-MsgGUID: qfesDPkNTGaqVIoC+8gjFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755170"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6755170"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16836687"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2024 04:23:43 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Fri, 29 Mar 2024 12:21:44 +0100
Message-ID: <20240329112339.29642-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825C products have a different PHY model than E822, E823 and E810 products.
This PHY is ETH56G and its support is necessary to have functional PTP stack
for E825C products.

Grzegorz Nitka (2):
  ice: Add NAC Topology device capability parser
  ice: Adjust PTP init for 2x50G E825C devices

Jacob Keller (2):
  ice: Introduce helper to get tmr_cmd_reg values
  ice: Introduce ice_get_base_incval() helper

Karol Kolacinski (4):
  ice: Introduce ice_ptp_hw struct
  ice: Add PHY OFFSET_READY register clearing
  ice: Change CGU regs struct to anonymous
  ice: Support 2XNAC configuration using auxbus

Michal Michalik (1):
  ice: Add support for E825-C TS PLL handling

Sergey Temerkhanov (3):
  ice: Implement Tx interrupt enablement functions
  ice: Move CGU block
  ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice.h          |   23 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  263 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3659 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  286 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3912 insertions(+), 934 deletions(-)


base-commit: 0f3e0f83f872052bd96011f32c8b138337cf3d1a
-- 
2.43.0


