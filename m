Return-Path: <netdev+bounces-34405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2440C7A4180
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD918281C73
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380636ADF;
	Mon, 18 Sep 2023 06:48:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCF1878
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:48:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69397
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695019688; x=1726555688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GS1gck9ANbiz+tFMOrhAj4TzAhzOgIqU7Aa0jlYpc2w=;
  b=DBsXllqD+3FDISHObULgaC+7aaFn9VeKNGpMmzaJWDaJAEKAOBolxp3P
   GaAKkDPuckCJRVNe+TiyK14v7TIJLeORRnJByvKX3Q7oscQaVb0z6278O
   NH2PimuAVpZbRhrh8xGMZBvh6QC0QUaN7iedKmGWA7/NVqEtbSQRkeKs0
   lpt6zmBEQfv7atoJBvZ2wCPoMPllGF8gxqwk3ED0Y8hcRG9/gXg2xMAkI
   bLnMz6TrO7nmfFzxSrSosArVYMH/r40QwIK06bIrQGiliFGelUFMJGDHQ
   rLOlvbazFLWTA7HH01KzDpf+SbnH0ZDj5HEs8FsWwOaLWVMaQ5V2Ga6su
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="369907508"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="369907508"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="869452216"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="869452216"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2023 23:48:06 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 0/4] change MSI-X vectors per VF
Date: Mon, 18 Sep 2023 08:24:02 +0200
Message-ID: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This patchset is implementing sysfs API introduced here [1].

It will allow user to assign different amount of MSI-X vectors to VF.
For example when there are VMs with different number of virtual cores.

Example:
1. Turn off autoprobe
echo 0 > /sys/bus/pci/devices/0000\:18\:00.0/sriov_drivers_autoprobe
2. Create VFs
echo 4 > /sys/bus/pci/devices/0000\:18\:00.0/sriov_numvfs
3. Configure MSI-X
echo 20 > /sys/class/pci_bus/0000\:18/device/0000\:18\:01.0/sriov_vf_msix_count

v1 --> v2: [2] (Sorry for long time between versions)
 * rebase
 * reword commit message in ice: implement num_msix field per VF

[1] https://lore.kernel.org/netdev/20210314124256.70253-1-leon@kernel.org/
[2] https://lore.kernel.org/netdev/20230615123830.155927-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (4):
  ice: implement num_msix field per VF
  ice: add bitmap to track VF MSI-X usage
  ice: set MSI-X vector count on VF
  ice: manage VFs MSI-X using resource tracking

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 257 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  13 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 7 files changed, 258 insertions(+), 24 deletions(-)

-- 
2.41.0


