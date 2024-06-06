Return-Path: <netdev+bounces-101574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338828FF7C1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8AA1C240F4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CAD364BE;
	Thu,  6 Jun 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwZmd3Ol"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0129415;
	Thu,  6 Jun 2024 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714033; cv=none; b=sD1usEkH85b2c2LFvT+Lo7ZkSyC5TRNLU87dXQTnwAlA71sMXzNHfHUiAtsQgOzGncylJ0xvqJvYX4ZUYKj8p3G0msIIzCSTMvsDjU74i3ONi4gXjWw3lZQneLUhGZyHqlYhw1JG3OCOmOaP0EGzQDtTG6jljPubyPX8f++wyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714033; c=relaxed/simple;
	bh=vS8D+WXC50cCAKUj8LONKm5qZ2IdHVeVgNTaI2pagTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVaFEiuySmQWFJORsLmNrTOSHwKmzrMBGe4lSCtqfSZJZ+ZksiajXbD3FSajmPsJrigT4es8Cng7S3Q9+gzbComODVfnn9vO8tBVBqqyMIVClXz3FRUeX5PG5vZsZDA/GKiK/ZdplKfSGsNPO6R+dJ8uJkflArw7H/r2iB57kmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwZmd3Ol; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717714032; x=1749250032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vS8D+WXC50cCAKUj8LONKm5qZ2IdHVeVgNTaI2pagTc=;
  b=VwZmd3OlueZKUh6UsuE0CE74TvANMok2CTBM2WL3Iou4yES3CehNqpjt
   l0I1XZrRtw4k7e8lkiooj3CmrmIGEpo+ncaf0Mq+LF+snyqrqfbiFObvf
   WcAfnVUWH6dBbamjcZhUUjrbkFpn5o8FBu00SgIoYDFQsgha/6ROBGLLU
   g8eOnZCdh/g7nO+FVV9eDqnhJ+usGe/58Pd3ehtZkuumOzt6xMrunxpGZ
   ZRxCg/6R6+GofArBtfe6HTuHfl7Nbx79eXwGSxHH1vKHB5fVSO5EfKr3V
   PtjE7+J235UO6ykUcC925SCkXiUx3qSkKD5wcs2lT1hkoLkCrivM7jaGN
   w==;
X-CSE-ConnectionGUID: XZ5GH0/tQFCU+V/NaBlSkw==
X-CSE-MsgGUID: oa4CSqEaSH6cgYF5ML0oYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14223998"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14223998"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
X-CSE-ConnectionGUID: AurUIcNYSpKQ7zv19yUecw==
X-CSE-MsgGUID: 8K2lguCcRRy+i/NhYCnctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38243830"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 0/5] ice: add standard stats
Date: Thu,  6 Jun 2024 15:46:54 -0700
Message-ID: <20240606224701.359706-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main point of this series is to implement the standard stats for the
ice driver, but also add a related documentation fix and finish the
series off with a cleanup that removes a bunch of code.

Changelog:
v2: address review comments on 1/5 (Jakub) regarding backticks,
    fix email address for one reviewer in commit message
    pick up some reviewed-bys from the list
v1: https://lore.kernel.org/netdev/20240604221327.299184-1-jesse.brandeburg@intel.com/

Jesse Brandeburg (5):
  net: docs: add missing features that can have stats
  ice: implement ethtool standard stats
  ice: add tracking of good transmit timestamps
  ice: implement transmit hardware timestamp statistics
  ice: refactor to use helpers

 Documentation/networking/statistics.rst       |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 138 ++++++++++++++----
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   9 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 9 files changed, 132 insertions(+), 47 deletions(-)


base-commit: 95cd03f32a1680f693b291da920ab5d3f9d8c5c1
-- 
2.43.0


