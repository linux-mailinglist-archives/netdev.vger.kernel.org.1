Return-Path: <netdev+bounces-114965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6251944D07
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8621F22009
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3641A071A;
	Thu,  1 Aug 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb2JsyNu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5D183CC5
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518370; cv=none; b=jsl2MJvPgcrIfqsazDxn0nY57NMAaX4MYhOdxYmrWWLDpC6SD5Rd2L7ADAidw10YLzSdUkKYjuJ4Y+S9n8agj89fviW1f7zVrZ37v5G4qTEd9jrtsDDaQFJi/CuPq28JbTvnYjmCgnDbTqXIECNpoLEoReUsd1Do2oZ+e4qu1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518370; c=relaxed/simple;
	bh=FvT4ltYhaFMQo99kffm7ECH/xzet28MQJZKjTF7VN3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hjAY9u6WXoSjUYk+/WOP/RCzeVNvTu6jRq28XD27UggV1qYrdAsPcBT8sdRGeq5qF/7OmaxaDcBo3oPEsA7QAtegbznkDmCCK2AvlRW3ZxK9K53jN2n4iUSDjMTh07ZkHpdiUvgh97svJYNbzSTlkNUs6FssM2LmL/BuxWcsCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb2JsyNu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NuOxy3I4igpy523k8aVlRE82KGZwshwBdGc8hfmMuOM=;
	b=fb2JsyNudSoXsdVSc/vy7HREDTEKNsANVaUiJGNRXm2Fc0KOGc1i1RBwfz/HR5DFm/EuU8
	Q0S76HdeKHnA7c7RC3njIaaf1fWxBewMuNhjgTFrMOVUVwM/8hZiLrErGflEQKbLsM2GTV
	sG0qGqm5JCOo5c8Enyop03vQBtRxm0k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-IbbS7umeM4WkJQb1Nh98lw-1; Thu,
 01 Aug 2024 09:19:26 -0400
X-MC-Unique: IbbS7umeM4WkJQb1Nh98lw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD3851955D42;
	Thu,  1 Aug 2024 13:19:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3362D1955D44;
	Thu,  1 Aug 2024 13:19:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc2
Date: Thu,  1 Aug 2024 15:19:17 +0200
Message-ID: <20240801131917.34494-1-pabeni@redhat.com>
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

The following changes since commit 1722389b0d863056d78287a120a1d6cadb8d4f7b:

  Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-25 13:32:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc2

for you to fetch changes up to 25010bfdf8bbedc64c5c04d18f846412f5367d26:

  Merge branch 'mptcp-fix-duplicate-data-handling' (2024-08-01 12:30:16 +0200)

----------------------------------------------------------------
Including fixes from wireless, bleutooth, BPF and netfilter.

Current release - regressions:

 - core: drop bad gso csum_start and offset in virtio_net_hdr

 - wifi: mt76: fix null pointer access in mt792x_mac_link_bss_remove

 - eth: tun: add missing bpf_net_ctx_clear() in do_xdp_generic()

 - phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c

Current release - new code bugs:

 - smc: prevent UAF in inet_create()

 - bluetooth: btmtk: fix kernel crash when entering btmtk_usb_suspend

 - eth: bnxt: reject unsupported hash functions

Previous releases - regressions:

 - sched: act_ct: take care of padding in struct zones_ht_key

 - netfilter: fix null-ptr-deref in iptable_nat_table_init().

 - tcp: adjust clamping window for applications specifying SO_RCVBUF

Previous releases - always broken:

 - ethtool: rss: small fixes to spec and GET

 - mptcp:
   - fix signal endpoint re-add
   - pm: fix backup support in signal endpoints

 - wifi: ath12k: fix soft lockup on suspend

 - eth: bnxt_en: fix RSS logic in __bnxt_reserve_rings()

 - eth: ice: fix AF_XDP ZC timeout and concurrency issues

 - eth: mlx5:
   - fix missing lock on sync reset reload
   - fix error handling in irq_pool_request_irq

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      fbnic: Change kconfig prompt from S390=n to !S390

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Andy Chiu (1):
      net: axienet: start napi before enabling Rx/Tx

Arnd Bergmann (2):
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
      Bluetooth: btmtk: remove #ifdef around declarations

Baochen Qiang (1):
      wifi: ath12k: fix reusing outside iterator in ath12k_wow_vif_set_wakeups()

Bartosz Golaszewski (1):
      net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c

Breno Leitao (1):
      net: Add skbuff.h to MAINTAINERS

Chris Lu (2):
      Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error

Chris Mi (1):
      net/mlx5e: Fix CT entry update leaks of modify header context

D. Wythe (1):
      net/smc: prevent UAF in inet_create()

Dan Carpenter (1):
      net: mvpp2: Don't re-use loop iterator

David S. Miller (2):
      Merge branch 'ethtool-rss-fixes' into main
      Merge branch 'mptcp-endpoint-readd-fixes' into main

Eric Dumazet (1):
      sched: act_ct: take care of padding in struct zones_ht_key

Faizal Rahim (1):
      igc: Fix double reset adapter triggered from a single taprio cmd

Heiner Kallweit (1):
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Herve Codina (2):
      net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex
      net: wan: fsl_qmc_hdlc: Discard received CRC

Jakub Kicinski (13):
      netlink: specs: correct the spec of ethtool
      ethtool: rss: echo the context number back
      Merge branch 'ethtool-rss-small-fixes-to-spec-and-get'
      Merge tag 'wireless-2024-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2024-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      eth: bnxt: reject unsupported hash functions
      eth: bnxt: populate defaults in the RSS context struct
      ethtool: fix setting key and resetting indir at once
      ethtool: fix the state of additional contexts with old API
      selftests: drv-net: rss_ctx: check for all-zero keys
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'mlx5-misc-fixes-2024-07-30'

Jeongjun Park (1):
      tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

Jiri Olsa (1):
      bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test

Johan Hovold (1):
      wifi: ath12k: fix soft lockup on suspend

Johannes Berg (2):
      wifi: mac80211: use monitor sdata with driver only if desired
      wifi: cfg80211: correct S1G beacon length calculation

Kiran K (1):
      Bluetooth: btintel: Fail setup on error

Krzysztof Kozlowski (1):
      net: MAINTAINERS: Demote Qualcomm IPA to "maintained"

Kuniyuki Iwashima (3):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in ip6table_nat_table_init().

Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy
      Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

Ma Ke (1):
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Fijalkowski (7):
      ice: don't busy wait for Rx queue disable in ice_qp_dis()
      ice: replace synchronize_rcu with synchronize_net
      ice: modify error handling when setting XSK pool in ndo_bpf
      ice: toggle netif_carrier when setting up XSK pool
      ice: improve updating ice_{t,r}x_ring::xsk_pool
      ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
      ice: xsk: fix txq interrupt mapping

Maciej Żenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Mark Bloch (1):
      net/mlx5: Lag, don't use the hardcoded value of the first port

Mark Mentovai (1):
      net: phy: realtek: add support for RTL8366S Gigabit PHY

Matthieu Baerts (NGI0) (7):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: mib: count MPJ with backup flag
      selftests: mptcp: join: validate backup in MPJ
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: check backup support in signal endp

Michal Kubiak (1):
      ice: respect netif readiness in AF_XDP ZC related ndo's

Moshe Shemesh (1):
      net/mlx5: Fix missing lock on sync reset reload

Paolo Abeni (9):
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      selftests: mptcp: add explicit test case for remove/readd
      selftests: mptcp: fix error path
      Merge branch 'mptcp-fix-inconsistent-backup-usage'
      Merge tag 'nf-24-07-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling
      Merge branch 'mptcp-fix-duplicate-data-handling'

Pavan Chebbi (1):
      bnxt_en: Fix RSS logic in __bnxt_reserve_rings()

Rahul Rameshbabu (1):
      net/mlx5e: Require mlx5 tc classifier action support for IPsec prio capability

Raju Lakkaraju (1):
      net: phy: micrel: Fix the KSZ9131 MDI-X status issue

Sean Wang (1):
      wifi: mt76: mt7921: fix null pointer access in mt792x_mac_link_bss_remove

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_ptys

Shay Drory (2):
      net/mlx5: Always drain health in shutdown callback
      net/mlx5: Fix error handling in irq_pool_request_irq

Stanislav Fomichev (1):
      selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp

Subash Abhinov Kasiviswanathan (1):
      tcp: Adjust clamping window for applications specifying SO_RCVBUF

Veerendranath Jakkam (1):
      wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done

Willem de Bruijn (1):
      net: drop bad gso csum_start and offset in virtio_net_hdr

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule

 Documentation/netlink/specs/ethtool.yaml           |   2 +-
 Documentation/networking/ethtool-netlink.rst       |   1 +
 MAINTAINERS                                        |   3 +-
 drivers/bluetooth/Kconfig                          |   2 +
 drivers/bluetooth/btintel.c                        |   3 +
 drivers/bluetooth/btmtk.c                          |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  14 +-
 drivers/net/ethernet/intel/ice/ice.h               |  11 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  10 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           | 184 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_xsk.h           |  14 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  33 ++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   1 +
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   5 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   1 +
 .../ethernet/mellanox/mlx5/core/steering/dr_rule.c |   2 +-
 drivers/net/ethernet/meta/Kconfig                  |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   8 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +-
 drivers/net/phy/aquantia/aquantia_main.c           |  29 +++-
 drivers/net/phy/micrel.c                           |  34 ++--
 drivers/net/phy/realtek.c                          |   7 +
 drivers/net/usb/sr9700.c                           |  11 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |  31 +++-
 drivers/net/wireless/ath/ath12k/pci.c              |   3 +-
 drivers/net/wireless/ath/ath12k/wow.c              |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   1 +
 include/linux/virtio_net.h                         |  16 +-
 include/trace/events/mptcp.h                       |   2 +-
 net/bluetooth/hci_core.c                           |   7 -
 net/bluetooth/hci_event.c                          |   5 +-
 net/bluetooth/hci_sync.c                           |  21 +++
 net/core/dev.c                                     |   1 +
 net/core/rtnetlink.c                               |   2 +-
 net/ethtool/ioctl.c                                |  43 +++--
 net/ethtool/rss.c                                  |   8 +-
 net/ipv4/netfilter/iptable_nat.c                   |  18 +-
 net/ipv4/tcp_input.c                               |  23 ++-
 net/ipv4/tcp_offload.c                             |   3 +
 net/ipv4/udp_offload.c                             |   4 +
 net/ipv6/ndisc.c                                   |  34 ++--
 net/ipv6/netfilter/ip6table_nat.c                  |  14 +-
 net/iucv/af_iucv.c                                 |   4 +-
 net/mac80211/cfg.c                                 |   7 +-
 net/mac80211/tx.c                                  |   5 +-
 net/mac80211/util.c                                |   2 +-
 net/mptcp/mib.c                                    |   2 +
 net/mptcp/mib.h                                    |   2 +
 net/mptcp/options.c                                |   2 +-
 net/mptcp/pm.c                                     |  12 ++
 net/mptcp/pm_netlink.c                             |  46 +++++-
 net/mptcp/pm_userspace.c                           |  18 ++
 net/mptcp/protocol.c                               |  18 +-
 net/mptcp/protocol.h                               |   4 +
 net/mptcp/subflow.c                                |  26 ++-
 net/sched/act_ct.c                                 |   4 +-
 net/smc/af_smc.c                                   |   7 +-
 net/wireless/scan.c                                |  11 +-
 net/wireless/sme.c                                 |   1 +
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../selftests/bpf/prog_tests/uprobe_syscall.c      |   2 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  37 ++++-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   8 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 103 ++++++++++--
 73 files changed, 694 insertions(+), 303 deletions(-)


