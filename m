Return-Path: <netdev+bounces-143058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7D9C0FF3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F904282BDB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFC21833C;
	Thu,  7 Nov 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1/NL0zA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB880218337;
	Thu,  7 Nov 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012334; cv=none; b=I6Izh9piEommVpZxa5X056U/3DX5SC9Of4SUTqb9o/jvdnhhzUHWutaJlF+UvIl7DhC0UhyluCRVADE9BbfMydHLBE1/IXmfOz7dRiCVxDWmGKGdWV5pYB4sWv2exUl3iyIXpSv3ab3WUCM/XPJixDVOmA7AFTL4DNLJSWLpaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012334; c=relaxed/simple;
	bh=eENU9Ew7xHw7MI0ZFn6qoyCmfwr99+4/gfV3NTtKtvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dydaw1m66bbDyoBfmBy699XIdu2kc1ObzK+0UuWjqqx9u+OZICy29ax3wNqZgeR2RT12UR9b49cYXnTAS8fGKgBtDxf09CK9UIJsWUB6dGk1/vXg/Fw/9YQ507/DbO/IceFyIOEnDzk/elMUoj+Whx+SYgiO3RtTyyHrtcfBgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1/NL0zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1096DC4CED7;
	Thu,  7 Nov 2024 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012334;
	bh=eENU9Ew7xHw7MI0ZFn6qoyCmfwr99+4/gfV3NTtKtvs=;
	h=From:To:Cc:Subject:Date:From;
	b=d1/NL0zAqG1jNRWe/LlOWEt0C8qydEE1eN1mwJ0jgEx3DRx+Ef3XL6qLkAr2TxKfJ
	 oaYw5RoGTeYQfvytDbYN+TeNFutE7BS0ep2jy5FswBHaI2lv0knFrrNM+h0Qq26Vfz
	 ybw5YNN6bFGFtvRkHK7B9rzsCI3T+34f8OpqR5K4E8plEnJpLdcpu1EHKT78OVECnj
	 cozih0sW5gG8KQ+Q/vtx200LG9EB+KgsV6j7tQBbtGcbKrvVbz+/62Y8Kyh6WkAJ/q
	 msQcmUASu8jaDHnSSAcR9IcmKrYB2XxNFD9z5LKBBaexO30Or5E/J8yWSAJeqxsX6g
	 4nZ6gyzYkokHw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.12-rc7
Date: Thu,  7 Nov 2024 12:45:33 -0800
Message-ID: <20241107204533.2224043-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 5635f189425e328097714c38341944fc40731f3d:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2024-10-31 14:56:19 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc7

for you to fetch changes up to 71712cf519faeed529549a79559c06c7fc250a15:

  drivers: net: ionic: add missed debugfs cleanup to ionic_probe() error path (2024-11-07 11:40:50 -0800)

----------------------------------------------------------------
Including fixes from can and netfilter.

Things are slowing down quite a bit, mostly driver fixes here.
No known ongoing investigations.

Current release - new code bugs:

 - eth: ti: am65-cpsw:
   - fix multi queue Rx on J7
   - fix warning in am65_cpsw_nuss_remove_rx_chns()

Previous releases - regressions:

 - mptcp: do not require admin perm to list endpoints, got missed
   in a refactoring

 - mptcp: use sock_kfree_s instead of kfree

Previous releases - always broken:

 - sctp: properly validate chunk size in sctp_sf_ootb() fix OOB access

 - virtio_net: make RSS interact properly with queue number

 - can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation

 - can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration
   when switching CAN modes

Misc:

 - revert earlier hns3 fixes, they were ignoring IOMMU abstractions
   and need to be reworked

 - can: {cc770,sja1000}_isa: allow building on x86_64

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksandr Loktionov (1):
      i40e: fix race condition by adding filter's intermediate sync state

Alexander Hölzl (1):
      can: j1939: fix error in J1939 documentation.

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

David Howells (1):
      rxrpc: Fix missing locking causing hanging calls

Diogo Silva (1):
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Eric Dumazet (1):
      net/smc: do not leave a dangling sk pointer in __smc_create()

Florian Fainelli (1):
      MAINTAINERS: Remove self from DSA entry

Geert Uytterhoeven (1):
      can: rockchip_canfd: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP

Geliang Tang (1):
      mptcp: use sock_kfree_s instead of kfree

Jakub Kicinski (5):
      Merge tag 'linux-can-fixes-for-6.12-20241104' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Revert "Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'"
      Merge branch 'mptcp-pm-fix-wrong-perm-and-sock-kfree'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-24-11-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jean Delvare (1):
      can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST

Jinjie Ruan (1):
      net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()

Johan Jonker (2):
      net: arc: fix the device for dma_map_single/dma_unmap_single
      net: arc: rockchip: fix emac mdio node support

Marc Kleine-Budde (3):
      can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
      can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes
      can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation

Marcin Szycik (1):
      ice: Fix use after free during unload with ports in bridge

Mateusz Polchlopek (1):
      ice: change q_index variable type to s16 to store -1 value

Matthieu Baerts (NGI0) (1):
      mptcp: no admin perm to list endpoints

Nícolas F. R. A. Prado (1):
      net: stmmac: Fix unbalanced IRQ wake disable warning on single irq case

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Paolo Abeni (3):
      Merge branch 'net-ethernet-ti-am65-cpsw-fixes-to-multi-queue-rx-feature'
      Merge branch 'virtio_net-make-rss-interact-properly-with-queue-number'
      Merge branch 'fix-the-arc-emac-driver'

Pavan Kumar Linga (2):
      idpf: avoid vport access in idpf_get_link_ksettings
      idpf: fix idpf_vc_core_init error path

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Philo Lu (4):
      virtio_net: Support dynamic rss indirection table size
      virtio_net: Add hash_key_length check
      virtio_net: Sync rss config to device when virtnet_probe
      virtio_net: Update rss when set queue

Roger Quadros (2):
      net: ethernet: ti: am65-cpsw: Fix multi queue Rx on J7
      net: ethernet: ti: am65-cpsw: fix warning in am65_cpsw_nuss_remove_rx_chns()

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix possible double free of TX skb

Suraj Gupta (2):
      dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
      net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts

Thomas Mühlbacher (1):
      can: {cc770,sja1000}_isa: allow building on x86_64

Vitaly Lifshits (1):
      e1000e: Remove Meteor Lake SMBUS workarounds

Vladimir Oltean (1):
      net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd tracepoint

Wei Fang (2):
      net: enetc: set MAC address to the VF net_device
      net: enetc: allocate vf_state during PF probes

Wenjia Zhang (1):
      net/smc: Fix lookup of netdev by using ib_device_get_netdev()

Wentao Liang (1):
      drivers: net: ionic: add missed debugfs cleanup to ionic_probe() error path

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

 CREDITS                                            |   4 +
 .../devicetree/bindings/net/xlnx,axi-ethernet.yaml |   2 +-
 Documentation/netlink/specs/mptcp_pm.yaml          |   1 -
 Documentation/networking/j1939.rst                 |   2 +-
 MAINTAINERS                                        |   1 -
 drivers/net/can/c_can/c_can_main.c                 |   7 +-
 drivers/net/can/cc770/Kconfig                      |   2 +-
 drivers/net/can/m_can/m_can.c                      |   3 +-
 drivers/net/can/rockchip/Kconfig                   |   3 +-
 drivers/net/can/sja1000/Kconfig                    |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |   8 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |  10 +-
 drivers/net/ethernet/arc/emac_main.c               |  27 +++--
 drivers/net/ethernet/arc/emac_mdio.c               |   9 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth_trace.h   |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  18 ++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |   9 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |   5 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  59 +---------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 -
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  33 ------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  45 ++------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   3 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.c    |   9 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  40 ++-----
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |   9 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  17 +--
 drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  12 ++-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |   3 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |   4 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  11 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   5 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   3 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  75 ++++++-------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |   6 +-
 drivers/net/ethernet/vertexcom/mse102x.c           |   5 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   4 +-
 drivers/net/phy/dp83848.c                          |   2 +
 drivers/net/virtio_net.c                           | 119 +++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |   2 +-
 include/net/netfilter/nf_tables.h                  |   4 +
 include/trace/events/rxrpc.h                       |   1 +
 net/mptcp/mptcp_pm_gen.c                           |   1 -
 net/mptcp/pm_userspace.c                           |   3 +-
 net/netfilter/nf_tables_api.c                      |  41 +++++--
 net/rxrpc/conn_client.c                            |   4 +
 net/sctp/sm_statefuns.c                            |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc_ib.c                                   |   8 +-
 net/smc/smc_pnet.c                                 |   4 +-
 57 files changed, 333 insertions(+), 337 deletions(-)

