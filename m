Return-Path: <netdev+bounces-54887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE4808DC0
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFCE1C209A6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246647F46;
	Thu,  7 Dec 2023 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dC81DU9n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8BE10D1
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701967715; x=1733503715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ai92a1bnHOo9EOrNqsNG9g3WR6dgPWWCudljwSfRnZo=;
  b=dC81DU9nVkJpB35RribD1by74k/uCTWo5/cjxTPMLf+jvoZvcGeG2Gqq
   fSN2o9CpE4sI1VqDN/PG8KbQUT3r4t/ZpKm+MWuqVqohW9EHFT7t/NhzX
   l6icsrllm+d3b0cxAi2YALZiFp00zs+7FPzFwLi06gk1GLcLgC7DBduXZ
   MiyQGKfnepLNcvYGWQ6V2qU9xbctSKvZDRrz2kJqrSH4ioBW07A73rk0v
   HkUFln+/qK4AtK1UzBOFHJB5Qd0MxHvf0ex8IkLu//eKVdh2l5LBAOwZG
   ZwyUbLJ5GER6Tb5Uj5xrAg2Dx8fOiqvs1fCKKTHsBAEzZaUP5IMRR5Mvn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="373759516"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="373759516"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 08:48:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775477318"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="775477318"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2023 08:48:31 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 55EF935421;
	Thu,  7 Dec 2023 16:48:29 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com,
	davem@davemloft.net,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	simon.horman@corigine.com,
	idosch@nvidia.com,
	andy@kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v4 0/7] Add PFCP filter support
Date: Thu,  7 Dec 2023 17:49:04 +0100
Message-ID: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for creating PFCP filters in switchdev mode. Add pfcp module
that allows to create a PFCP-type netdev. The netdev then can be passed to
tc when creating a filter to indicate that PFCP filter should be created.

To add a PFCP filter, a special netdev must be created and passed to tc
command:

  ip link add pfcp0 type pfcp
  tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
    1:12ab/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
    dev pfcp0

Changes in iproute2 [1] are required to use pfcp_opts in tc.

ICE COMMS package is required as it contains PFCP profiles.

Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
stored in a __be16. All possible values have already been used, making it
impossible to add new ones.

[1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
---
This patchset should be applied on top of the "boys" tree [2], as it
depends on recent bitmap changes.

[2] https://github.com/norov/linux/commits/boys
---
v3: https://lore.kernel.org/intel-wired-lan/20230721071532.613888-1-marcin.szycik@linux.intel.com
v2: https://lore.kernel.org/intel-wired-lan/20230607112606.15899-1-marcin.szycik@linux.intel.com
v1: https://lore.kernel.org/intel-wired-lan/20230601131929.294667-1-marcin.szycik@linux.intel.com
---

Alexander Lobakin (3):
  ip_tunnel: use a separate struct to store tunnel params in the kernel
  ip_tunnel: convert __be16 tunnel flags to bitmaps
  lib/bitmap: add tests for IP tunnel flags conversion helpers

Marcin Szycik (2):
  ice: refactor ICE_TC_FLWR_FIELD_ENC_OPTS
  ice: Add support for PFCP hardware offload in switchdev

Michal Swiatkowski (1):
  pfcp: always set pfcp metadata

Wojciech Drewek (1):
  pfcp: add PFCP module

 drivers/net/Kconfig                           |  13 +
 drivers/net/Makefile                          |   1 +
 drivers/net/bareudp.c                         |  19 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   9 +
 .../net/ethernet/intel/ice/ice_flex_type.h    |   4 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  12 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  85 +++++
 drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  68 +++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_gre.c        |   8 +-
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  56 ++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../ethernet/netronome/nfp/flower/action.c    |  27 +-
 drivers/net/geneve.c                          |  44 ++-
 drivers/net/pfcp.c                            | 302 ++++++++++++++++++
 drivers/net/vxlan/vxlan_core.c                |  14 +-
 include/linux/netdevice.h                     |   7 +-
 include/net/dst_metadata.h                    |  10 +-
 include/net/flow_dissector.h                  |   2 +-
 include/net/gre.h                             |  70 ++--
 include/net/ip6_tunnel.h                      |   4 +-
 include/net/ip_tunnels.h                      | 139 ++++++--
 include/net/pfcp.h                            |  90 ++++++
 include/net/udp_tunnel.h                      |   4 +-
 include/uapi/linux/if_tunnel.h                |  36 +++
 include/uapi/linux/pkt_cls.h                  |  14 +
 lib/test_bitmap.c                             | 100 ++++++
 net/bridge/br_vlan_tunnel.c                   |   9 +-
 net/core/filter.c                             |  26 +-
 net/core/flow_dissector.c                     |  20 +-
 net/ipv4/fou_bpf.c                            |   2 +-
 net/ipv4/gre_demux.c                          |   2 +-
 net/ipv4/ip_gre.c                             | 144 +++++----
 net/ipv4/ip_tunnel.c                          | 109 +++++--
 net/ipv4/ip_tunnel_core.c                     |  82 +++--
 net/ipv4/ip_vti.c                             |  41 ++-
 net/ipv4/ipip.c                               |  33 +-
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_gre.c                            |  85 ++---
 net/ipv6/ip6_tunnel.c                         |  14 +-
 net/ipv6/sit.c                                |  38 ++-
 net/netfilter/ipvs/ip_vs_core.c               |   6 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  20 +-
 net/netfilter/nft_tunnel.c                    |  44 +--
 net/openvswitch/flow_netlink.c                |  61 ++--
 net/psample/psample.c                         |  26 +-
 net/sched/act_tunnel_key.c                    |  36 +--
 net/sched/cls_flower.c                        | 134 +++++++-
 57 files changed, 1652 insertions(+), 495 deletions(-)
 create mode 100644 drivers/net/pfcp.c
 create mode 100644 include/net/pfcp.h

-- 
2.41.0


