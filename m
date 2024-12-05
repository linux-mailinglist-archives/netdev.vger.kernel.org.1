Return-Path: <netdev+bounces-149425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7519E58FE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAD285C77
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765821C195;
	Thu,  5 Dec 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY4ChA6y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773271B0F22
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410615; cv=none; b=Rc/IGyP13dKcu18LbTX39rOslLYm1dPRu0vINq4d/NVO/Q2dahJa4Z/SbiGJLK9TZJBsmBB/e159o6AsPEYU99wZDx8U7itxS7AyXxvoqpKnhMddOKmLU9YQG3+DitlWXabSK4ymD/uD+HSh2P57CinHsuUq+tpWAdSikzGxFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410615; c=relaxed/simple;
	bh=O3AictZnwwdzBNmqYePdc1bEAfNfPUaShjj+kc4or5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHkiLpkfDjgVIdkXJpxRP8sqmzu3SMqymTjkbGeTkC82ya7o/H9u3N9rQ9dHL8hZ+2LHghdZnOV8zdd6YFIeXM2ZI7ndX87wMCeUFvGjH6y9QVtFsSbXl0F9JtZ5VpV9ANapmzuoOwZFjpfO1i6ItJi6W33EdPdkwwtfe0YijEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY4ChA6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733410612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7x+dQLzoUfE1chSNUNoG6EijuRVKSV36Vs0MFnyPBY=;
	b=CY4ChA6ylB7+fZ7Wny9ROCZroHNDihvqJZpEv1BS63TJMSJr3O5unYxdbkcQcuDu3MChx+
	0S8HMkGVgcUZedIcjbzn0g+uyvc5duFjSMkWcs/NUdKkxQYV088GfbbZT6KJvlAT2MD1iI
	5mVGNc2Ki+L4QnEslQEviKIYFjRUBb0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-qD-s7LQ9PkaIim-xUafrrw-1; Thu,
 05 Dec 2024 09:56:45 -0500
X-MC-Unique: qD-s7LQ9PkaIim-xUafrrw-1
X-Mimecast-MFC-AGG-ID: qD-s7LQ9PkaIim-xUafrrw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87FCA195608A;
	Thu,  5 Dec 2024 14:56:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97A9E1956094;
	Thu,  5 Dec 2024 14:56:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.13-rc2
Date: Thu,  5 Dec 2024 15:56:05 +0100
Message-ID: <20241205145605.209744-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Linus!

The following changes since commit 65ae975e97d5aab3ee9dc5ec701b12090572ed43:

  Merge tag 'net-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-11-28 10:15:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc2

for you to fetch changes up to 31f1b55d5d7e531cd827419e5d71c19f24de161c:

  net :mana :Request a V2 response version for MANA_QUERY_GF_STAT (2024-12-05 12:02:15 +0100)

----------------------------------------------------------------
Including fixes from can and netfilter.

Current release - regressions:

  - rtnetlink: fix double call of rtnl_link_get_net_ifla()

  - tcp: populate XPS related fields of timewait sockets

  - ethtool: fix access to uninitialized fields in set RXNFC command

  - selinux: use sk_to_full_sk() in selinux_ip_output()

Current release - new code bugs:

  - net: make napi_hash_lock irq safe

  - eth: bnxt_en: support header page pool in queue API

  - eth: ice: fix NULL pointer dereference in switchdev

Previous releases - regressions:

  - core: fix icmp host relookup triggering ip_rt_bug

  - ipv6:
    - avoid possible NULL deref in modify_prefix_route()
    - release expired exception dst cached in socket

  - smc: fix LGR and link use-after-free issue

  - hsr: avoid potential out-of-bound access in fill_frame_info()

  - can: hi311x: fix potential use-after-free

  - eth: ice: fix VLAN pruning in switchdev mode

Previous releases - always broken:

  - netfilter:
    - ipset: hold module reference while requesting a module
    - nft_inner: incorrect percpu area handling under softirq

  - can: j1939: fix skb reference counting

  - eth: mlxsw: use correct key block on Spectrum-4

  - eth: mlx5: fix memory leak in mlx5hws_definer_calc_layout

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Arkadiusz Kubalewski (1):
      ice: fix PHY Clock Recovery availability check

Cong Wang (1):
      rtnetlink: fix double call of rtnl_link_get_net_ifla()

Cosmin Ratiu (2):
      net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
      net/mlx5: HWS: Properly set bwc queue locks lock classes

Daniel Xu (2):
      bnxt_en: ethtool: Supply ntuple rss context action
      selftests: drv-net: rss_ctx: Add test for ntuple rule

Dario Binacchi (11):
      can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: hi311x: hi3110_can_ist(): update state error statistics if skb allocation fails
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
      can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics

David S. Miller (1):
      Merge branch 'enetc-mqprio-fixes' Wei Fang sayus:

David Wei (3):
      bnxt_en: refactor tpa_info alloc/free into helpers
      bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap()
      bnxt_en: handle tpa_info in queue API implementation

Dmitry Antipov (2):
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting

Dong Chenchen (1):
      net: Fix icmp host relookup triggering ip_rt_bug

Eric Dumazet (7):
      tcp: populate XPS related fields of timewait sockets
      selinux: use sk_to_full_sk() in selinux_ip_output()
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      ipv6: avoid possible NULL deref in modify_prefix_route()
      net: hsr: must allocate more bytes for RedBox support
      geneve: do not assume mac header is set in geneve_xmit_skb()
      net: avoid potential UAF in default_operstate()

Fernando Fernandez Mancera (1):
      Revert "udp: avoid calling sock_def_readable() if possible"

Gal Pressman (1):
      ethtool: Fix access to uninitialized fields in set RXNFC command

Geetha sowjanya (1):
      octeontx2-af: Fix SDP MAC link credits configuration

Ido Schimmel (1):
      mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jacob Keller (2):
      ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
      ixgbe: downgrade logging of unsupported VF API version to debug

Jakub Kicinski (6):
      Merge branch 'bnxt-fix-failure-to-report-rss-context-in-ntuple-rule'
      MAINTAINERS: list PTP drivers under networking
      Merge tag 'linux-can-fixes-for-6.13-20241202' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'bnxt_en-support-header-page-pool-in-queue-api'
      Merge branch 'mlx5-misc-fixes-2024-12-03'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jianbo Liu (1):
      net/mlx5e: Remove workaround to avoid syndrome for internal port

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joe Damato (1):
      net: Make napi_hash_lock irq safe

Joshua Hay (1):
      idpf: set completion tag for "empty" bufs associated with a packet

Konstantin Shkolnyy (3):
      vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
      vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
      vsock/test: verify socket options after setting them

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Marc Kleine-Budde (3):
      can: dev: can_set_termination(): allow sleeping GPIOs
      Merge patch series "Fix {rx,tx}_errors CAN statistics"
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.

Marcin Szycik (1):
      ice: Fix VLAN pruning in switchdev mode

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Oleksij Rempel (1):
      net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850

Pablo Neira Ayuso (3):
      netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
      netfilter: nft_inner: incorrect percpu area handling under softirq
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Paolo Abeni (4):
      Merge branch 'two-fixes-for-smc'
      ipmr: tune the ipmr_can_free_table() checks.
      Merge branch 'vsock-test-fix-wrong-setsockopt-parameters'
      Merge tag 'nf-24-12-05' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Patrisious Haddad (2):
      net/mlx5: E-Switch, Fix switching to switchdev mode with IB device disabled
      net/mlx5: E-Switch, Fix switching to switchdev mode in MPV

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Przemyslaw Korba (1):
      ice: fix PHY timestamp extraction for ETH56G

Shradha Gupta (1):
      net :mana :Request a V2 response version for MANA_QUERY_GF_STAT

Tariq Toukan (1):
      net/mlx5e: SD, Use correct mdev to build channel param

Tore Amundsen (1):
      ixgbe: Correct BASE-BX10 compliance code

Vladimir Oltean (1):
      net: enetc: read TSN capabilities from port register, not SI

Vyshnav Ajith (1):
      docs: net: bareudp: fix spelling and grammar mistakes

Wei Fang (1):
      net: enetc: Do not configure preemptible TCs if SIs do not support

Wen Gu (2):
      net/smc: initialize close_work early to avoid warning
      net/smc: fix LGR and link use-after-free issue

Wojciech Drewek (1):
      ice: Fix NULL pointer dereference in switchdev

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Yuan Can (1):
      igb: Fix potential invalid memory access in igb_init_module()

 Documentation/networking/bareudp.rst               |  11 +-
 MAINTAINERS                                        |   1 +
 drivers/net/can/c_can/c_can_main.c                 |  26 ++-
 drivers/net/can/dev/dev.c                          |   2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  58 ++++--
 drivers/net/can/m_can/m_can.c                      |  33 +++-
 drivers/net/can/sja1000/sja1000.c                  |  67 ++++---
 drivers/net/can/spi/hi311x.c                       |  55 +++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |  29 ++-
 drivers/net/can/sun4i_can.c                        |  22 ++-
 drivers/net/can/usb/ems_usb.c                      |  58 +++---
 drivers/net/can/usb/f81604.c                       |  10 +-
 drivers/net/can/usb/gs_usb.c                       |  25 ++-
 drivers/net/can/vxcan.c                            |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 205 +++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   8 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  12 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  19 ++
 drivers/net/ethernet/intel/ice/ice_common.c        |  25 ++-
 drivers/net/ethernet/intel/ice/ice_main.c          |   8 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   5 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   6 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c          |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h    |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |   1 -
 drivers/net/ethernet/marvell/octeontx2/af/common.h |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  32 ++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   5 +-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  |   2 +
 .../mellanox/mlx5/core/steering/hws/send.c         |   1 +
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   6 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   1 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   4 +-
 drivers/net/geneve.c                               |   2 +-
 drivers/net/netkit.c                               |  11 +-
 drivers/net/phy/microchip.c                        |  21 +++
 drivers/net/veth.c                                 |  12 +-
 drivers/ptp/ptp_clock.c                            |   3 +-
 include/net/inet_timewait_sock.h                   |   2 +
 include/net/net_namespace.h                        |   5 +
 include/net/netfilter/nf_tables_core.h             |   1 +
 net/can/j1939/transport.c                          |   2 +-
 net/core/dev.c                                     |  18 +-
 net/core/link_watch.c                              |   7 +-
 net/core/rtnetlink.c                               |  44 ++---
 net/dccp/feat.c                                    |   6 +-
 net/ethtool/bitset.c                               |  48 ++++-
 net/ethtool/ioctl.c                                |   3 +-
 net/hsr/hsr_device.c                               |  19 +-
 net/hsr/hsr_forward.c                              |   2 +
 net/ipv4/icmp.c                                    |   3 +
 net/ipv4/ipmr.c                                    |   2 +-
 net/ipv4/tcp_minisocks.c                           |   4 +
 net/ipv4/udp.c                                     |  14 +-
 net/ipv6/addrconf.c                                |  13 +-
 net/ipv6/ip6mr.c                                   |   2 +-
 net/ipv6/route.c                                   |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |   5 +
 net/netfilter/ipvs/ip_vs_proto.c                   |   4 +-
 net/netfilter/nft_inner.c                          |  57 ++++--
 net/netfilter/nft_set_hash.c                       |  16 ++
 net/netfilter/nft_socket.c                         |   2 +-
 net/netfilter/xt_LED.c                             |   4 +-
 net/sched/cls_flower.c                             |   5 +-
 net/sched/sch_cake.c                               |   2 +-
 net/sched/sch_choke.c                              |   2 +-
 net/sched/sch_tbf.c                                |  18 +-
 net/smc/af_smc.c                                   |   6 +-
 net/tipc/udp_media.c                               |   2 +-
 security/selinux/hooks.c                           |   2 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  12 +-
 tools/testing/vsock/control.c                      |   9 +-
 tools/testing/vsock/msg_zerocopy_common.c          |  10 -
 tools/testing/vsock/msg_zerocopy_common.h          |   1 -
 tools/testing/vsock/util.c                         | 142 ++++++++++++++
 tools/testing/vsock/util.h                         |   7 +
 tools/testing/vsock/vsock_perf.c                   |  20 +-
 tools/testing/vsock/vsock_test.c                   |  75 ++++----
 tools/testing/vsock/vsock_test_zerocopy.c          |   2 +-
 tools/testing/vsock/vsock_uring_test.c             |   2 +-
 87 files changed, 985 insertions(+), 454 deletions(-)


