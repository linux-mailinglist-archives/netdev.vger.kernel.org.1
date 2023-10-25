Return-Path: <netdev+bounces-44287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE807D76F3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBE71C209A6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA03347D1;
	Wed, 25 Oct 2023 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJZfhfP4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF15341B5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:42:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA6132
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698270124; x=1729806124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Hj9c8B6mKmOjQGR1VAzvQ5HHV2XZ+GydzCgnDJ7Kgc=;
  b=XJZfhfP4+9olPZqOTILezSMXDocf8a9yVAj46ARkx9yz4gtydsJ3zNT5
   tTR83alnIEFu/VU+8szyHmpbfEMA4nRY+Unjz3gKnSbKa/0UQMSUndYks
   DFlv44By2Td0xB2ijP3kbvm7f/JG77vgvW9r1QD10nEUTooN9CMXDGfKc
   0CpLLFNUCsjwTEUQw2LH7yCtKHUwUqahCSQLHiMlQk2PZuxEO8ta0k0Ab
   JK1WvxeGPCse9EUmiIYKmtKBkXWqMBt+WZtxp1hjHdI5dhkXK8Er8yc2L
   hZ4a8DT+uJ/zgOer1PCeJ/o3WjgMTLDraDde/MnPgzvrkOeSnFOryZ3vg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="6022474"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6022474"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708825449"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="708825449"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:42:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/6] Intel Wired LAN Driver Updates for 2023-10-25 (ice)
Date: Wed, 25 Oct 2023 14:41:51 -0700
Message-ID: <20231025214157.1222758-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the ice driver with basic support for the E830 device
line. It does not include support for all device features, but enables basic
functionality to load and pass traffic.

Alice adds the 200G speed and PHY types supported by E830 hardware.

Dan extends the DDP package logic to support the E830 package segment.

Paul adds the basic registers and macros used by E830 hardware, and adds
support for handling variable length link status information from firmware.

Pawel removes some redundant zeroing of the PCI IDs list, and extends the
list to include the E830 device IDs.

Alice Michael (1):
  ice: Add 200G speed/phy type use

Dan Nowlin (1):
  ice: Add support for E830 DDP package segment

Paul Greenwalt (2):
  ice: Add E830 device IDs, MAC type and registers
  ice: Add ice_get_link_status_datalen

Pawel Chmielewski (2):
  ice: Remove redundant zeroing of the fields.
  ice: Hook up 4 E830 devices by adding their IDs

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  48 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  88 +++-
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 436 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  27 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  26 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   8 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  24 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  52 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  71 +--
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  29 +-
 12 files changed, 652 insertions(+), 173 deletions(-)


base-commit: 8846f9a04b10b7f61214425409838d764df7080d
-- 
2.41.0


