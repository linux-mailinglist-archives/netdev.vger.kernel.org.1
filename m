Return-Path: <netdev+bounces-83209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C08915BD
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3BD1C22A6C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD62B9B0;
	Fri, 29 Mar 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LttTPZGE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521E4A99C
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704347; cv=none; b=TOndugsR1R5zQB09dCaf5fwzWjcwyZ15IVPx92Psk9MjW8CH3OYMDRc9nzVE2RYfH5G7ASPx63OPxshzQnf4EIe1J+C3tvSkrjNTOnAVxMlBvrcOKgAkCLBd2As85HEXyhKpO5UQyh6lHcTfyfyaBfxUDjsjt6iR+t114CIma5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704347; c=relaxed/simple;
	bh=SiFhzy8Dzb88IW3DhGTg7DK++p/eHDcqL5kDh9xXjbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbnK8eBX5vXEbcMoGeGjO7kDVA1KnN4syt+3I0MGFpLfA4H8zr8Xz4pt9bxig1E305xhbofvdnW5KXHgLIpYPJmNfjJ8zjwrl7nrdXKjW92e8inLcbUfvXBYiR543rvxWLyumO6OYzsJZJ7WKN8hv29eS8PPtpzAjOJ3NIzLI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LttTPZGE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711704346; x=1743240346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiFhzy8Dzb88IW3DhGTg7DK++p/eHDcqL5kDh9xXjbw=;
  b=LttTPZGEQ5/r/WkM+7CY3/deWIvUiiO02VqvyDmorGx2bnwZ5Kw33viw
   RvwriAz52CCP0Dfr1gmmmnCrjX6f4T6mRgRozEhOhjf9sve5LZdpQv6+N
   rUF2URGE70v1qr8QvxxjqJOAGxYiYfvsvXIy5MeHNM+svDsOtuC3RdV9F
   1zaE6djIdGjm8Stwsfz2Gp0rrHhYBFBBzLazVxUQKHQA7ws+ZdyDMfQAB
   ywFztgnTA6CjUymx+nVrt2+vezpCQD/q7DeGrMTe56iZbZsvdLLpwm6Gn
   Uy5u3I1qypHCKlxmc/vuhGxuLQ+waJLIWuYKUnGMOBJkrpZ7DnQ4aCzZB
   g==;
X-CSE-ConnectionGUID: YdjKs4QcRByJQHATRSuIbg==
X-CSE-MsgGUID: m/Q4KiwOTi6RwlYRNTqvWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7107013"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="7107013"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 02:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16986841"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 02:25:34 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E9EDF3433E;
	Fri, 29 Mar 2024 09:25:30 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com,
	anthony.l.nguyen@intel.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: [PATCH net-next 0/3] ethtool: Max power support
Date: Fri, 29 Mar 2024 10:23:18 +0100
Message-Id: <20240329092321.16843-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ethernet modules use nonstandard power levels [1]. Extend ethtool
module implementation to support new attributes that will allow user
to change maximum power. Rename structures and functions to be more
generic. Introduce an example of the new API in ice driver.

Ethtool examples:
$ ethtool --show-module enp1s0f0np0
Module parameters for enp1s0f0np0:
power-min-allowed: 1000 mW
power-max-allowed: 3000 mW
power-max-set: 1500 mW

$ ethtool --set-module enp1s0f0np0 power-max-set 4000

This idea was originally discussed here [2]

[1] https://www.fs.com/de-en/products/69111.html
[2] https://lore.kernel.org/netdev/MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com/

Wojciech Drewek (3):
  ethtool: Make module API more generic
  ethtool: Introduce max power support
  ice: Implement ethtool max power configuration

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  21 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  46 ++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  14 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 461 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
 .../net/ethernet/mellanox/mlxsw/core_env.c    |   2 +-
 .../net/ethernet/mellanox/mlxsw/core_env.h    |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/minimal.c |   8 +-
 .../mellanox/mlxsw/spectrum_ethtool.c         |   8 +-
 include/linux/ethtool.h                       |  35 +-
 include/uapi/linux/ethtool_netlink.h          |   4 +
 net/ethtool/module.c                          | 102 +++-
 net/ethtool/netlink.h                         |   2 +-
 17 files changed, 669 insertions(+), 50 deletions(-)

-- 
2.40.1


