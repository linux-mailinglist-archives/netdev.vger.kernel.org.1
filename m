Return-Path: <netdev+bounces-89698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB178AB425
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2611F21D13
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262B13174E;
	Fri, 19 Apr 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kO20SppU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC856477
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546524; cv=none; b=SAxh3S4+5RzTD0Kc9RPfWq1WqXBLZ+EjP9mAQsIMpRziy4gpS4/RdJirTpcMOZRU8b7mzpMN6AmIkCqtGpTA3nvv7w3jRL8ey4ns0muItVpjuFkyYBz7qsCQXnvxp9ZLbvzXjAuT2sN+AFfarLstH0zs3G2RvpNWU6f/vk8lmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546524; c=relaxed/simple;
	bh=s4on6KqscIj+i61ZkHKc2rTAqi75W5FdAmg0f9wcHmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPABONk//TWrvK1FqnDE9kJth3mQsN07TC4jtDKFdSLxB8CzBgbNFCDhcfKkZGJwd3rwq+VE4NsfzuSmMCh8e9laB2rglrYaLxIyPQtqcVFYY9C1J0o282v2r6mNUQF0+Px9aPYJ7LFTtWrreb/mCRqH0sSp3ZRNOCeuMVAl1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kO20SppU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546523; x=1745082523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s4on6KqscIj+i61ZkHKc2rTAqi75W5FdAmg0f9wcHmM=;
  b=kO20SppUB8KixFlt95NuscuV3HA/WYidYAAALVZnKkXwOWCvaIEWVxIc
   nqNiDbxhZuetEGVr6r76fFaT1eBsTK+Y5yoSgyS+THXdB5w6TBUiJGgC3
   NJXfdxlXXtTfedmOcYgvl7wv/QIGcQUXF2TFEriv5fwLjS1djcUYFDgo5
   SLmKlg9+uEM5MtmGaAqVpdJLECHrNbNQsmnE+RlBKk3LTb9h840Ocwg8r
   qx2B5IoSAa9uW9FpyW+iVMcS8/dKq9V7veKSE97f9sK9kJg44nJfk+vZ/
   YuByfZEZVUhYEfsPScuXW0QWrhIVIfixRV6F/1n/QHkkTaeXLzmqtHHhc
   w==;
X-CSE-ConnectionGUID: t4ceL4CTQAenWDl+Rm9k2A==
X-CSE-MsgGUID: /w5oG56ZT46Vrr4ZIKsJXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26674280"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26674280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:08:42 -0700
X-CSE-ConnectionGUID: E5NBiPFlQxONdFc/Y4dRUg==
X-CSE-MsgGUID: CCQlko+pSUSBYdl9YZXOHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27847158"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa005.fm.intel.com with ESMTP; 19 Apr 2024 10:08:39 -0700
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
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com
Subject: [iwl-next v1 0/4] ice: prepare representor for SF support
Date: Fri, 19 Apr 2024 19:13:32 +0200
Message-ID: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a series to prepare port representor for supporting also
subfunctions. We need correct devlink locking and the possibility to
update parent VSI after port representor is created.

Refactor how devlink lock is taken to suite the subfunction use case.

VSI configuration needs to be done after port representor is created.
Port representor needs only allocated VSI. It doesn't need to be
configured before.

VSI needs to be reconfigured when update function is called.

The code for this patchset was split from (too big) patchset [1].

[1] https://lore.kernel.org/netdev/20240213072724.77275-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (4):
  ice: store representor ID in bridge port
  ice: move devlink locking outside the port creation
  ice: move VSI configuration outside repr setup
  ice: update representor when VSI is ready

 .../net/ethernet/intel/ice/devlink/devlink.c  |  2 -
 .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 83 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 14 +++-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_repr.c     | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
 9 files changed, 88 insertions(+), 39 deletions(-)

-- 
2.42.0


