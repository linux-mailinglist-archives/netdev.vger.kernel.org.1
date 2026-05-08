Return-Path: <netdev+bounces-285808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML/IKb/e/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257D4F6B8D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546533009176
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298D3E121B;
	Fri,  8 May 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZoTwqiL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB43E0C6F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245185; cv=none; b=nVOuCD4EomqZy1vmI+xC8DOhuAUyQP6v+SChiW6cYQaVIj1JmgChGs3f+u1fwhDXIANVyDzNsPZc/RrKxEYr98a6+daHC+FAE/Tv+bqjx6+vrgwzCFvV3RkkqiJX5b2QW0P1XNqE5RSwnmldYpDajDVaJJjdA3ng75JJzRQfzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245185; c=relaxed/simple;
	bh=Cecj/jI4Hf3y5GjyNmlPt5sbEVv1v3dHbPozo7/APAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRQrkrMqKQP3k6PrmrIF9+rVadBr97LU4CyKcbX4nmXeVJA8xaIxs/YGZfogzgnXZpaBWTBUTFYO/URBt1W7UMmuiwL80tSYggHfQgp8wuMSbgZs+C77m66xOeLkCwUHgVeQpOuIJ89aeTg/q7qDY3/GGrPZ4qZJv0LNWQp62YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZoTwqiL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245183; x=1809781183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cecj/jI4Hf3y5GjyNmlPt5sbEVv1v3dHbPozo7/APAo=;
  b=EZoTwqiL4W58eQ1jRddb5zfEAd77kIhEtL+lqbOFgItFle/SCQgAuCeo
   Ikl77gOvz7G3992rZG8DwtjiM4FhKdy3txCyox9NhZU5iuayC4ALsJi1C
   OgxuEhwr4jbnRakYXt7wZbjl1S5zxdxVzkEbCtuc7FTuwQ9eQoCk9u2UV
   LQeTDwDmsI5Bf5O7c/A/kqwZsbXmW6x+bsfWQbTQBZo5ohG7P5VEAOEjs
   8Fa4SbRoLtfter13KDRwelON1pGyBA7o2vZ+WbJFahmCpd9gZHfv/ZK7B
   w4PkVvEkriYY2xEwhCVV8Dm1dtzgm0f1zWGGKY1pEzcmry2X/QtpCzcSJ
   g==;
X-CSE-ConnectionGUID: 5k4Qx7TMRAe4Ia1OShCKYg==
X-CSE-MsgGUID: oiU+tLglTXimtY4tGYSfkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199845"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199845"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:59:43 -0700
X-CSE-ConnectionGUID: 71w7MdL8REmoYuq4rRbu+Q==
X-CSE-MsgGUID: KgGuZ4MPQ825zBvYOvUa1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730090"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:36 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 58E6F28795;
	Fri,  8 May 2026 13:59:34 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Fri,  8 May 2026 14:41:53 +0200
Message-Id: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5257D4F6B8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285808-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url]
X-Rspamd-Action: no action

Code is also available here:
https://github.com/pkitszel/linux/tree/xlvf-iwl

There are two dependecies:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260429102426.210750-4-jtornosm@redhat.com
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260427151827.43342-1-mschmidt@redhat.com

The purpose of this series is to allow iavf to use more than 16 queue pairs,
in two modes, up to 64 and up to 256 queue pairs.

Devlink changes:
1. Extend devlink by two callbacks used by shared devlink.
   Callbacks provide option for the driver to have constructor/destructor
   for the priv data attached to the shared devlink instance.
   Use the callbacks from ice.
   mlx5 is just touched to have additional param passed.
   Non-null additional param for the constructor is used in: "ice: represent RSS
   LUTs as devlink resources"
2. Extend devlink resources API to allow user to assign resources.
   Before it was only the driver to assign resources, without any way for user
   to interact. ice' RSS LUTs are exposed that way.

More about the interface:
In order to support more queues for VF, we must give it a bigger RSS table
(GLOBAL LUT or PF LUT). There are 16 GLOBAL LUTs on E810, and there is one
PF LUT for every PF on given card. Both kinds of the mentioned LUTs could
be (re)assigned to VF. PF must hold at least one of the mentioned LUTs at
any given moment. GLOBAL LUT allows VF to use up to 64 queues, PF LUT lets
it to use up to 256 queues.

RSS LUTs are exposed for the user for assignment via devlink resources
API, which I have extended to make it possible.

We have also some "little cleanup" patches, Admin Queue extension
for GLOBAL RSS alloc/free, and two rather big "new opcodes" patches by Ahmed
and Brett.

I introduce also a "whole device" aggregate over all PFs on
given card, via shared devlink instance.

I also extend devlink resources to have custom occupancy setters, that allow
user to modify PF device LUTs assignment.

Finally there is a patch that adds devlink instance for VF and registers
devlink resources on it, combined with all the glue code to make actual
use of the whole series and desired larger number of queues accepted to VF
This (the last) patch contains usage examples.

There is one resource added that just groups GLOBAL and PF LUTs under it -
there are 3 rows of data for each device (PF/VF/whole-dev):
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 1 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
technically the aggregate "name rss" line could be eliminated with just
the two last ones kept (then renamed to "rss_lut_2048" form current
"rss/lut_2048"), I like it like this, but this was just an opinion.
The rest of the series is rather much needed, but I'm always open to
discussion.

Devlink resource changes were RFC-proposed a year ago, link in the patch.

Ahmed Zaki (1):
  iavf: use new opcodes to request more than 16 queues

Brett Creeley (2):
  ice: add VF queue ena/dis helper functions
  ice: introduce handling of virtchnl LARGE VF opcodes

Przemek Kitszel (12):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray
  ice: simplify ice_vc_dis_qs_msg() a little
  ice: add helpers for Global RSS LUT alloc, free, vsi_update
  ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
  ice: bump to 256qs for VF
  iavf: extend iavf_configure_queues() to support more queues
  iavf: temporary rename of IAVF_MAX_REQ_QUEUES to
    IAVF_MAX_REQ_QUEUES_VCV1
  iavf: increase max number of queues to 256
  devlink: give user option to allocate resources
  ice: represent RSS LUTs as devlink resources
  ice: support up to 256 VF queues

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  18 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  22 +
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  52 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  26 +-
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 include/linux/intel/virtchnl.h                | 136 ++++-
 include/net/devlink.h                         |  33 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   7 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 125 +++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 262 +++++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
 .../net/ethernet/intel/ice/devlink/resource.c | 572 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 105 ++--
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  78 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  43 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  14 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  41 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  54 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 480 +++++++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  36 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  47 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   2 +-
 net/devlink/resource.c                        |  98 ++-
 net/devlink/sh_dev.c                          |  38 +-
 35 files changed, 2102 insertions(+), 221 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.39.3


