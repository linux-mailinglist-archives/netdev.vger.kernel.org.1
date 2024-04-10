Return-Path: <netdev+bounces-86390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF289E955
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240962852E6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184410961;
	Wed, 10 Apr 2024 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSHEtlKU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D54D51A
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725417; cv=none; b=RDPno9+5CeRxHvmlGpHsLD2pgZsrDDUndgJoeBwf7QQwmzbQHlDprK/gbzwn00FJFj3THC5BJjedhFKxuaNxRhrlVSprMoO3ILmF4m7zPkGzz8hmoEdYyXdVhcU/nyd/a1JcSIg3mCOpw0U2VChA+OzDvlLNV/N/hDsG7gb19WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725417; c=relaxed/simple;
	bh=W1ZYgVuzm2bAtZpkE6s/m0uAXudswt6pgaoOfJavFEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFL5E9X0HKBQdU02M/cOm7jArvqQa2UXOd+vNCMnskueYhplmFvaG9O7PzAMGcA3bOFtop6omexlV9HO0UPtq8xgUhno6Aq7stQnl1Rfw51SxCE+N2XKJRCh0QTq1Liu+vBDKFxHRHFUEJlx4LbKvBv7ksFPB8S0V2MVmivey/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSHEtlKU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712725416; x=1744261416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W1ZYgVuzm2bAtZpkE6s/m0uAXudswt6pgaoOfJavFEI=;
  b=YSHEtlKU+4jFgQ6jcgLjg5zasuwWcwOuX/zg3HQoSIZ1qmEmbolPGKbp
   XLUYEs8ZyQB30T1SCLfu9Kkk6SsghnRESAXKOQlaIpmdkqp6TPKSMGJkG
   oO7IgwSyeTTyXdcI4+0PuBCfbGovaqR+WUXr23gc3HHsDfT7INYYN9TYF
   Avu/eqhP2maLFJH8popv/KmorZ0y6JVBwGHo5YW+Ai1i7PL4aliRRh9r2
   l/LnoxqZFay5T7O7s5OV5BxvY3XWZTYyTrGNVn13YTd0noW4BNj8chOBX
   6U2SAAvmW07c1jnsgn1I6ozYwC3uPLPi0oON6UgISXty5c6LDqH3cr26w
   g==;
X-CSE-ConnectionGUID: lQgbSGpqQ1261VCUee/ang==
X-CSE-MsgGUID: RftqYEBjSqC8LjiI2eeG9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19456189"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19456189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:03:35 -0700
X-CSE-ConnectionGUID: KxTTcR3dTu6B8W3YzHxEGg==
X-CSE-MsgGUID: jUjLoal7Qg6Im28F/904sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57875969"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2024 22:03:32 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v2 0/7] ice: support devlink subfunction
Date: Wed, 10 Apr 2024 07:08:02 +0200
Message-ID: <20240410050809.125043-1-michal.swiatkowski@linux.intel.com>
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

v1 --> v2: [2]
 * use correct parameters in ice_devlink_alloc() thanks to Mateusz

[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240408103049.19445-1-michal.swiatkowski@linux.intel.com/

Piotr Raczynski (7):
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: allocate devlink for subfunction
  ice: base subfunction aux driver
  ice: implement netdev for subfunction
  ice: allow to activate and deactivate subfunction

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  44 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 512 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  37 ++
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 317 +++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 15 files changed, 1040 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

-- 
2.42.0


