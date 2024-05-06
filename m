Return-Path: <netdev+bounces-93649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144808BC9C1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3513282FC9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FE6CDAC;
	Mon,  6 May 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHJV42c0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92275A788
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984924; cv=none; b=bsLRH5V187L5xWQZ05lDDe2cMYMyI0Qs9/QYvpWjdBPwxuAwZIYZeyhVWS0Hp4TK1jMb1bnp2UWF2pxHKtx1DxaQajGHnRAZjPqmNC/7X4Q6K+VJTtC0PXxB37yzokA8KI2yIe4jNFjoUk3nSZB3RX/6qC8sXejRd1wuY0VnftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984924; c=relaxed/simple;
	bh=VufGN84yFM1G4uypzEns0FUOmUjQkqvEB/lAaxOygas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJpeun6aW1y091P1/FnDVPxOPzQ/NBH6VO0Hov9Q1XQhY4bMVW3sCqGMvZQxC7W4pBv4gNRb3ly4gD9VSThxw77nwv+HXepIjXr0fn6qyGXYs5OrpHi/YWZEoYlPreDc0pH6s2+Xh1UYmOkgX4XD+lVI0lKBWd0KWldTpjGARe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHJV42c0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984923; x=1746520923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VufGN84yFM1G4uypzEns0FUOmUjQkqvEB/lAaxOygas=;
  b=bHJV42c0hfy6Nee3hGK21h6g1L72miXld8gTKCi2fwpGxMB1Nt0p5x84
   s1PUP2Av5jFTHIybrMnOiyAZnVRwHjh3O4SrKBb43NrmnJHhKdDd0j33K
   L3cyOvv6zuyhVS9IoRKdfy7kaSV7xz6nH8Q7ywR0ocBWiwo6U2vby72bw
   TU8lLWS7MVXveNci24IS0ucZ2v655mjLJI9TuCkd+5SpiCgHxkSsQWMXo
   uZGjJCC1SEsuyEvYDsXiaZkjOI5LG90CBnso5uQCVn03pfbu3vprENnP4
   Uw7/fwWJ1Jn3YOgEFKKWJDmCcrwoA602nGwoDau3jMQg3b7q1zyMG9pSP
   g==;
X-CSE-ConnectionGUID: fLFSgXVaSwqtQhHkaL5a9A==
X-CSE-MsgGUID: Di3qYLKpSIGtijSmcbpnVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14505073"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14505073"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:42:03 -0700
X-CSE-ConnectionGUID: j0V75Ua5RWaVwFj2/wfZLg==
X-CSE-MsgGUID: ADU2y4hgQPSAHL1KzP645Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28050115"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2024 01:41:59 -0700
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
Subject: [iwl-next v2 0/4] ice: prepare representor for SF support
Date: Mon,  6 May 2024 10:46:49 +0200
Message-ID: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
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

v1 --> v2 [2]:
 * add returns for kdoc in ice_eswitch_cfg_vsi

[1] https://lore.kernel.org/netdev/20240213072724.77275-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240419171336.11617-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (4):
  ice: store representor ID in bridge port
  ice: move devlink locking outside the port creation
  ice: move VSI configuration outside repr setup
  ice: update representor when VSI is ready

 .../net/ethernet/intel/ice/devlink/devlink.c  |  2 -
 .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 85 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 14 ++-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_repr.c     | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
 9 files changed, 90 insertions(+), 39 deletions(-)

-- 
2.42.0


