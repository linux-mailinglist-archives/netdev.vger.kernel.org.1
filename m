Return-Path: <netdev+bounces-88728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC98A85AF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D5F2815CC
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87039140362;
	Wed, 17 Apr 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZz43bXM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42811411E7
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363337; cv=none; b=NI8JoIVGjyHI4YZMRKn7eOgscFf3HHsjMYhAsAV6JBCHF1xWh4K4giK18MWzsd+DWAtXylySm7IoHAvbMp3tW3Z/Xz/JnBJx8uzC73h3Zhbm31HuYUUr0thwWnDloi8yuXdHHFj9Psrd2DbpTTVoze3Lrn9gVZkr9lWA0KCRZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363337; c=relaxed/simple;
	bh=IwfWNPWVBZNxZI3Dk4aMQgJmBNpm4beFZBiuwuZ5v/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwumFFXSWZkVgtOT8a/0VvCtPJN+MF6ojEjhr85zsUhANhq1mmtM6akeSZbb2hoS92+HtNG56KHhiqsFbynoWRywTxQvSkTmKCCszQs1Ld+UF6aPC3pKedcrkh8Dj3VUyaQj9BcDlSzLPcHC7waVLLwODDm6zNHyl3UsDlYSIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZz43bXM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713363336; x=1744899336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IwfWNPWVBZNxZI3Dk4aMQgJmBNpm4beFZBiuwuZ5v/k=;
  b=OZz43bXMeWj2vr4At1qQHx2hOt9lO5oCb/wzZM/lgx1S3BcSqIaulPQ6
   EHetjKNR9MRiFhgls+rY/oOrhQJolx5QXoRUvqIl4Q5QLQcREYe9J9Ss3
   fd3b3k+BJab4b2oGJyV6302YdODjPIG8avIqJnXUVyS6PIUCWS9OWyYj0
   oUBpuBRVYJQLFg0mSLKcGXYJQzdxMeL/QeBJlalEH47GQki2VaSQ1kMNh
   izmRdNbRtw7iLTHl7TY22c6LpHwmhjiEroyiG1QMI7Lzt/+8uaVYMMMuk
   bd17CMg85PWaPEAxS1AyaL3oifoAKPJJtyWlS0RzwkT/CMBtpEDrt6kmi
   w==;
X-CSE-ConnectionGUID: G+y8dcIgRvmqG/i+ouw0yQ==
X-CSE-MsgGUID: q1aUtDKcRp+lX0xazTx5bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737121"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:15:36 -0700
X-CSE-ConnectionGUID: 5Zq7/RrJRbmKLLdSfckYMw==
X-CSE-MsgGUID: TdjBa5heSNG8iU7qC1Grlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="60050415"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 17 Apr 2024 07:15:32 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: [iwl-next v4 0/8] ice: support devlink subfunction
Date: Wed, 17 Apr 2024 16:20:20 +0200
Message-ID: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is second patchset split from subfunction patchset [1].
Important changes from previous version:
 * remove unnecessary checks for devlink port type
 * link correct devlink port to subfunction netdev

Follow up patchset with subfunction port representor will be the last
patchset for subfunction implementation in ice. It is a little
unpleasant to split it like that, because devlink port should be linked
with port representor netdev. In this patchset use devlink port without
linking it. It will be done correctly in the follow up when subfunction
port representor is available.

Currently ice driver does not allow creating more than one networking
device per physical function. The only way to have more hardware backed
netdev is to use SR-IOV.

Following patchset adds support for devlink port API. For each new
pcisf type port, driver allocates new VSI, configures all resources
needed, including dynamically MSIX vectors, program rules and registers
new netdev.

This series supports only one Tx/Rx queue pair per subfunction.

Example commands:
devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
devlink port function set pci/0000:31:00.1/1 state active
devlink port function del pci/0000:31:00.1/1

v3 --> v4: [4]
 * get rid of unnecessary checks
 * fix cosmetic issues (whitespaces, wording)
 * move unrelated chunks to separate patch
 * move implementing activation/deactivation to last patch

v2 --> v3: [3]
 * fix building issue between the patches; allocating devlink for
 subfunction need to include base subfunction header
 * fix kdoc issues

v1 --> v2: [2]
 * use correct parameters in ice_devlink_alloc() thanks to Mateusz

[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240408103049.19445-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240410050809.125043-1-michal.swiatkowski@linux.intel.com/
[4] https://lore.kernel.org/netdev/20240412063053.339795-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (1):
  ice: treat subfunction VSI the same as PF VSI

Piotr Raczynski (7):
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: allocate devlink for subfunction
  ice: base subfunction aux driver
  ice: implement netdev for subfunction
  ice: allow to activate and deactivate subfunction

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  50 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  38 ++
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 327 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 15 files changed, 1048 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

-- 
2.42.0


