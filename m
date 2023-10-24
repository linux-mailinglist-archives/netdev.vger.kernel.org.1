Return-Path: <netdev+bounces-43819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E245F7D4EDC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39090B20DD5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA928262A6;
	Tue, 24 Oct 2023 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtLs9bhm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455541FD7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:34:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB8A128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147280; x=1729683280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CKvAcJ0UICqy+gXSIAnwDmufo4fKFX/tjp+tbbgzTG4=;
  b=CtLs9bhmMmbuC6yxjHJXbaxomyxPN8CWz5/4Nb+sHXaxOhksGv7fZa+y
   h3iGz96wbPUpxSLihoNsiWgPOKOITZeznBMpu49gSwBhnO893YNAPElOf
   PLpohhNUm/wEQ3kSuhWyZMxx2rCPgKydLNbFKUVfkRoSEarYDPtR9hc7C
   U8r7LQpkWPAQQ8au7CR868JKjqK4cLSAGpsiuAKVnvVpl/yI0pCo9gH+J
   MEzmK/GcAA87K9nnpJzCbbwI6mRaLFdtnBppekAjskDVge60HOZS7k8HX
   t5cJSXkfODv67+dEEyKWWD0r7Wh35S+oc3LijlqJzDrNHUDe3tM9h3QP/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660512"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660512"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6145938"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:20 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 00/15] one by one port representors creation
Date: Tue, 24 Oct 2023 13:09:14 +0200
Message-ID: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently ice supports creating port representors only for VFs. For that
use case they can be created and removed in one step.

This patchset is refactoring current flow to support port representor
creation also for subfunctions and SIOV. In this case port representors
need to be createad and removed one by one. Also, they can be added and
removed while other port representors are running.

To achieve that we need to change the switchdev configuration flow.
Three first patches are only cosmetic (renaming, removing not used code).
Next few ones are preparation for new flow. The most important one
is "add VF representor one by one". It fully implements new flow.

New type of port representor (for subfunction) will be introduced in
follow up patchset.

Michal Swiatkowski (15):
  ice: rename switchdev to eswitch
  ice: remove redundant max_vsi_num variable
  ice: remove unused control VSI parameter
  ice: track q_id in representor
  ice: use repr instead of vf->repr
  ice: track port representors in xarray
  ice: remove VF pointer reference in eswitch code
  ice: make representor code generic
  ice: return pointer to representor
  ice: allow changing SWITCHDEV_CTRL VSI queues
  ice: set Tx topology every time new repr is added
  ice: realloc VSI stats arrays
  ice: add VF representors one by one
  ice: adjust switchdev rebuild path
  ice: reserve number of CP queues

 drivers/net/ethernet/intel/ice/ice.h          |  13 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  29 +
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 562 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  22 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  81 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++---
 drivers/net/ethernet/intel/ice/ice_repr.h     |   9 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
 14 files changed, 553 insertions(+), 422 deletions(-)

-- 
2.41.0


