Return-Path: <netdev+bounces-42438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799E7CEBEF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3173B20ECC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13987335C1;
	Wed, 18 Oct 2023 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7y6FZ5A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B418E0B
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:24:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E2FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697671483; x=1729207483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nxp8lcP4NnN/Lphx2iHe/mlF7d8jRes3FAwEL0NuznA=;
  b=Z7y6FZ5AVBBf8//KVuF2V08RZkY3NsQ79n6lsk3OcrSvdeMH4uRFls0D
   nt8p495wiJlJnjHAReyRiORE4FBxEz14nkwmCpKeEQPfBnfW4I+Td7qF5
   Tru9lLNVmdI07z5W6IRPebJODr5tdCPNlzKlpKj0JUom5H+gaQoxK85//
   q4rzv6P/Kba04v3ol+S/4HD9twYR4+l+tJl45XRJnXZBNtl/UOOPuDyLy
   0pmua6o1K2na8q51GBC4Ur7JtSzRKU0cLyyzYaDpHPFgUi0LWd1sgQUKw
   +YLmLRMww5ynv2UdnBkWFPGvv94yP+AUeY8LM3O7EmYDw63Ny0wlow16J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388996694"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="388996694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4732342"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 16:24:45 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH net-next v5 0/6] ice: Add basic E830 support
Date: Wed, 18 Oct 2023 19:16:37 -0400
Message-ID: <20231018231643.2356-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pawel Chmielewski <pawel.chmielewski@intel.com> 

This is an initial patchset adding the basic support for E830. E830 is
the 200G ethernet controller family that is a follow on to the E810 100G
family. The series adds new devices IDs, a new MAC type, several registers
and a support for new link speeds. As the new devices use another version
of ice_aqc_get_link_status_data admin command, the driver should use
different buffer length for this AQ command when loaded on E830.

Changelog:
v3->v4:
Resending with dependency commit 982b0192db45
("ice: Refactor finding advertised link speed") applied, and add
reporting ethtool advertised 200G link speed.

v2->v3:
Resending the original series, but with two patches moved to another
set [1], which the following series depends on.

[1] https://lore.kernel.org/netdev/20230915145522.586365-1-pawel.chmielewski@intel.com/
---

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
 drivers/net/ethernet/intel/ice/ice_common.c   |  94 ++--
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 426 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  27 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  26 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   8 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  24 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  52 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  71 +--
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  29 +-
 12 files changed, 650 insertions(+), 171 deletions(-)


base-commit: 7bd8065b0883b43c14e1eb63d9e5bbf2bb5cb296
-- 
2.41.0


