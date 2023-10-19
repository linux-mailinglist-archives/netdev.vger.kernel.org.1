Return-Path: <netdev+bounces-42744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBCD7D0092
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2AD282007
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58F335D3;
	Thu, 19 Oct 2023 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9QNhJLY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2C27469
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04F116
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736754; x=1729272754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PnmoSB/mYkvu7D00MpEe8IUDHDfwHJlopySlkczPBAc=;
  b=k9QNhJLYSZ54Ki64/aGEB34X/UZehS/gvMQ2Pjyfi/zgpm4SxSx0iuSr
   kWaMUslCCwQfs656HzZbbInk8wcO2NQQSQe2NiCypS8TLJpX6sP3O/rMe
   pD1n0EIVRdzW7AynnkJvmiqBBdLYon/ANuZZsD4tGFsNKWwsOrDzsQOyk
   s1ecRAjN83148eHt2u8NiVj03yFa84jCr+58749rEccM7vVvvgpO9e0MS
   jBzqNKZiiai5VMf2bxzLjfHpJyvdgsjZOiUVe3MvWOOpgX/f4INBa5oTO
   /eTq1dzTfZU+H/tfTs2VFE2xKoWT5q+srRwEdz0Y3QgO0od3IRE4VIQQX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183669"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183669"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722666"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722666"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 00/11] Intel Wired LAN Driver Updates 2023-10-19 (ice, igb, ixgbe)
Date: Thu, 19 Oct 2023 10:32:16 -0700
Message-ID: <20231019173227.3175575-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains improvements to the ice driver related to VF MSI-X
resource tracking, as well as other minor cleanups.

Dan fixes code in igb and ixgbe where the conversion to list_for_each_entry
failed to account for logic which assumed a NULL pointer after iteration.

Jacob makes ice_get_pf_c827_idx static, and refactors ice_find_netlist_node
based on feedback that got missed before the function merged.

Michal adds a switch rule to drop all traffic received by an inactive LAG
port. He also implements ops to allow individual control of MSI-X vectors
for SR-IOV VFs.

Przemek removes some unused fields in struct ice_flow_entry, and modifies
the ice driver to cache the VF PCI device inside struct ice_vf rather than
performing lookup at run time.

Dan Carpenter (2):
  igb: Fix an end of loop test
  ixgbe: fix end of loop test in ixgbe_set_vf_macvlan()

Jacob Keller (2):
  ice: make ice_get_pf_c827_idx static
  ice: cleanup ice_find_netlist_node

Michal Swiatkowski (5):
  ice: add drop rule matching on not active lport
  ice: implement num_msix field per VF
  ice: add bitmap to track VF MSI-X usage
  ice: set MSI-X vector count on VF
  ice: manage VFs MSI-X using resource tracking

Przemek Kitszel (2):
  ice: remove unused ice_flow_entry fields
  ice: store VF's pci_dev ptr in ice_vf

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  30 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   3 -
 drivers/net/ethernet/intel/ice/ice_lag.c      |  87 ++++-
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 307 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  17 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   9 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  19 +-
 18 files changed, 398 insertions(+), 108 deletions(-)

-- 
2.41.0


