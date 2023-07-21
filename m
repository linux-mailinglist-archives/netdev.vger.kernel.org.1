Return-Path: <netdev+bounces-19848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48775C978
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDF01C216E4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434D1EA73;
	Fri, 21 Jul 2023 14:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136931EA6F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:14:51 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9B2D47
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689948888; x=1721484888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wn0rnpGWZ+NsWkHHiK1OYU4RJD1mCQb8yrP/hv0Nuqg=;
  b=Tc86yYM3Ud1DoLKhyz5qC8Mb7lEjb5OnC4SoRciax2K9Fl83h9eu9srf
   JzwvSW3rn8ZazDU7tVNYHU2udpfmOPKsnGsAZjWG+RIMom4JClrWcbivx
   e5na/WVA8boJGTTK0TdYBtV2X8ALJom+Kekwnde5g6TW75vYFk4NLfgo/
   zEuEC8U5qo0/qZR728JZ4AxnF3kzUg/jFM57+9gNe9n7RdWrnb5j1CDJf
   UpgiPySaGUhQGy3STur7/8U1Wma5C+dPxNqDYv6PpStQDXYODaJhohis7
   A9YsmvphKysoMfvaPOrV4ZAXa5ueQCNG3drm5zG336fENmm+cw7pSTfH/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433263375"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433263375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868256453"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 07:14:45 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 83581340C0;
	Fri, 21 Jul 2023 15:14:42 +0100 (IST)
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
Subject: [PATCH iwl-next v3 0/6] ice: Add PFCP filter support
Date: Fri, 21 Jul 2023 09:15:26 +0200
Message-ID: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for creating PFCP filters in switchdev mode. Add pfcp module
that allows to create a PFCP-type netdev. The netdev then can be passed to
tc when creating a filter to indicate that PFCP filter should be created.

To add a PFCP filter, a special netdev must be created and passed to tc
command:

ip link add pfcp0 type pfcp
tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
1:123/ff:fffffffffffffff0 skip_hw action mirred egress redirect dev pfcp0

Changes in iproute2 [1] are required to use pfcp_opts in tc.

ICE COMMS package is required as it contains PFCP profiles.

Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
stored in a __be16. All possible values have already been used, making it
impossible to add new ones.

[1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com

v2: Fixed minor issues, typos
v3: Rebase

Alexander Lobakin (2):
  ip_tunnel: use a separate struct to store tunnel params in the kernel
  ip_tunnel: convert __be16 tunnel flags to bitmaps

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
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   7 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_gre.c        |   9 +-
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  15 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  62 ++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../ethernet/netronome/nfp/flower/action.c    |  12 +-
 drivers/net/geneve.c                          |  46 ++-
 drivers/net/pfcp.c                            | 303 ++++++++++++++++++
 drivers/net/vxlan/vxlan_core.c                |  14 +-
 include/linux/netdevice.h                     |   7 +-
 include/net/dst_metadata.h                    |  10 +-
 include/net/flow_dissector.h                  |   2 +-
 include/net/gre.h                             |  59 ++--
 include/net/ip6_tunnel.h                      |   4 +-
 include/net/ip_tunnels.h                      | 108 ++++++-
 include/net/pfcp.h                            |  83 +++++
 include/net/udp_tunnel.h                      |   4 +-
 include/uapi/linux/if_tunnel.h                |  36 +++
 include/uapi/linux/pkt_cls.h                  |  14 +
 net/bridge/br_vlan_tunnel.c                   |   9 +-
 net/core/filter.c                             |  20 +-
 net/core/flow_dissector.c                     |  12 +-
 net/ipv4/fou_bpf.c                            |   2 +-
 net/ipv4/gre_demux.c                          |   2 +-
 net/ipv4/ip_gre.c                             | 148 +++++----
 net/ipv4/ip_tunnel.c                          |  92 ++++--
 net/ipv4/ip_tunnel_core.c                     |  83 +++--
 net/ipv4/ip_vti.c                             |  43 ++-
 net/ipv4/ipip.c                               |  33 +-
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_gre.c                            |  87 ++---
 net/ipv6/ip6_tunnel.c                         |  14 +-
 net/ipv6/sit.c                                |  47 ++-
 net/netfilter/ipvs/ip_vs_core.c               |   6 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  20 +-
 net/netfilter/nft_tunnel.c                    |  45 +--
 net/openvswitch/flow_netlink.c                |  55 ++--
 net/psample/psample.c                         |  26 +-
 net/sched/act_tunnel_key.c                    |  39 +--
 net/sched/cls_flower.c                        | 134 +++++++-
 56 files changed, 1505 insertions(+), 471 deletions(-)
 create mode 100644 drivers/net/pfcp.c
 create mode 100644 include/net/pfcp.h

-- 
2.41.0


