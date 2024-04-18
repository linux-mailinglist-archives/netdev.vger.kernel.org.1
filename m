Return-Path: <netdev+bounces-89157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3F8A9902
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A50C284EA9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647815F41F;
	Thu, 18 Apr 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpX5c3ng"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC315F30B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440995; cv=none; b=JZqv+Ell0GiGOWXXME3mC/7YAznilZv4nxsjRUFpVsE5ZcTjW/01VV6VMJqsrvx8xxNQqDb4mmYlDlnWu1rBQi6WxZWg09Epzw5Or4o6Vq9pYM6iGbsFASWadbD6RCkRFm4d7PCgP+Wpixx/WGHwMNDzzDg2TaMbrYWEw0CaHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440995; c=relaxed/simple;
	bh=AOyG9ACA8piLD8ZUFTDWXXz2PsX8UXZcwL0rG2yA1Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DOfr/aQqxlWi7FlGbgQzw4o4Hzoxu54qst4WTgKOc40Pa9brc1WO5xIhGGyJfC/YHPhbcJD0JCkX2081m1lBfPiovIGtFr7VXFFkIDdABxeNIKxOhCHDoZzAIsfYVDQK/doYe9ZoK+v99NUnT5IkhPLFI96dgF0OKumpfL+uTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpX5c3ng; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440995; x=1744976995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AOyG9ACA8piLD8ZUFTDWXXz2PsX8UXZcwL0rG2yA1Jw=;
  b=FpX5c3ngomQMeAaxiQ6AtBx/zsv5mm0+I6/h0+iB3GUhdmzIw/viQS8j
   aKWc+oxwCAp5cEAwuKOqK6UFvGZ/uxHIsedshl4OLG8sj/36kNTtPaPsy
   XHwgrayxq5GkIvKVe6XW94Ww1Ys8TLaOpfKPdsemCS9tVd5oPY873CRR7
   VcuqATyexddZE+jB1nU8mFW8a/3dtQ3N3eJRhnMi0dF49o1FDPvULjWea
   0NpTQHfprca7PKxdgfpcQcFrnj9mM9m7MD3tn/dvdFuKOIdunPA+WLDDd
   Ai9ScGrSe9+96TLLa3HtIhL5npe18lqJylnHqxGe3wGeFJBJJcgU7zBUh
   A==;
X-CSE-ConnectionGUID: ywj3jxEjTnmKr7ulox9Ykw==
X-CSE-MsgGUID: UW2CvxLmTsKSzhCwqKQblA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20127425"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20127425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:49:54 -0700
X-CSE-ConnectionGUID: QPyqIneJRUWjZoVQ+dgBig==
X-CSE-MsgGUID: eS+FT5SeQFiBPkM7zdwnAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27731033"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by orviesa005.jf.intel.com with ESMTP; 18 Apr 2024 04:49:52 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v3 0/5] ixgbe: Add support for Intel(R) E610 device
Date: Thu, 18 Apr 2024 14:06:22 +0200
Message-Id: <20240418120627.287999-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

This patch series adds low level support for the following features and
enables link management.

Piotr Kwapulinski (5):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   15 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2561 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  435 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4302 insertions(+), 65 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
V1 -> V2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
V2 -> V3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
  
2.31.1


