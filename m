Return-Path: <netdev+bounces-38318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1362C7BA64B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B62BC281A34
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF28E2D;
	Thu,  5 Oct 2023 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKjYtKXc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318434CE2
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:33:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D43683
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523462; x=1728059462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPombCDQ3i1w+SXg+v6h92vp5NBZZDS00D8narxQbeM=;
  b=jKjYtKXcSILtZHhVNsUkm/xNOI04YUNmqjyfK1ZTDrzcVnpsHQ3D6m1B
   S72bo3KmklZSQOQ0G5gTyET5TfACblR361KG+eNyEIAzoqNCOlJU764IY
   ShVYqxQcH2+Hcne6Mx5X0jTgGAaGiNjbqTPP9KZP9eK8w4MMDLj17SPy4
   AenhO+8+Yer8MXlllm2x0Kh76TA4uR6fNyaXMw6Tjb/kwropduFV3m+4g
   qXgMkbVV6Mcz9mWOa21Z2aRu6QsDOSLmhGw8hNkp+mlVO5KHh4n++VEY/
   gvdwEhEY5ttXZthIMeSOqvzP0Wt0ZyTyaoc/t7eSPXT59zjagl9iFzvk0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152643"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152643"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607725"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607725"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com
Subject: [PATCH net-next 0/9][pull request] i40e: House-keeping and clean-up
Date: Thu,  5 Oct 2023 09:28:41 -0700
Message-Id: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ivan Vecera says:

The series makes some house-keeping tasks on i40e driver:

Patch 1: Removes unnecessary back pointer from i40e_hw
Patch 2: Moves I40E_MASK macro to i40e_register.h where is used
Patch 3: Refactors I40E_MDIO_CLAUSE* to use the common macro
Patch 4: Add header dependencies to <linux/avf/virtchnl.h>
Patch 5: Simplifies memory alloction functions
Patch 6: Moves mem alloc structures to i40e_alloc.h
Patch 7: Splits i40e_osdep.h to i40e_debug.h and i40e_io.h
Patch 8: Removes circular header deps, fixes and cleans headers
Patch 9: Moves DDP specific macros and structs to i40e_ddp.c

The following are changes since commit 49e7265fd098fdade2bbdd9331e6b914cda7fa83:
  net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (9):
  i40e: Remove back pointer from i40e_hw structure
  i40e: Move I40E_MASK macro to i40e_register.h
  i40e: Refactor I40E_MDIO_CLAUSE* macros
  virtchnl: Add header dependencies
  i40e: Simplify memory allocation functions
  i40e: Move memory allocation structures to i40e_alloc.h
  i40e: Split i40e_osdep.h
  i40e: Remove circular header dependencies and fix headers
  i40e: Move DDP specific macros and structures to i40e_ddp.c

 drivers/net/ethernet/intel/i40e/i40e.h        | 76 +++++--------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  8 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  3 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 24 +++---
 drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c | 11 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 24 +++++-
 drivers/net/ethernet/intel/i40e/i40e_debug.h  | 47 ++++++++++++
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 16 ++--
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 +
 drivers/net/ethernet/intel/i40e/i40e_io.h     | 16 ++++
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  9 +--
 .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 57 ++++++++------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 59 --------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  9 ++-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
 .../net/ethernet/intel/i40e/i40e_register.h   |  5 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 59 +++-----------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 +
 include/linux/avf/virtchnl.h                  |  4 +
 34 files changed, 231 insertions(+), 251 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h

-- 
2.38.1


