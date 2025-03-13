Return-Path: <netdev+bounces-174642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA1A5FA4E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E58B16C3F3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3C268FD0;
	Thu, 13 Mar 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJoIrJMj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5F268684
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880547; cv=none; b=BQAWV2Oc+nVjJtFJ8LkK+bqADC9MlOUfLzisp9HxKmUZEB0CU+B3fz6bhesVGHXQrMAKOqgSv6D5VzncnaVym80lH/4HPUQzQcsP679tcP3W4CDx0wv8hQBvsy79crntSmdwN6JZqmsVSMVsr053gAlhT2QQLzir3HcO0+O/v+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880547; c=relaxed/simple;
	bh=IE+yyt+Twhi03eB0V0837vY0bvjX0uAUqThjQlvreUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0Wnx9AgsxiwlwDvChc0Yxpe+BlLH0fA0IWFyxEiW9LBBz14Gn3pzAjVGLiM2eRqKPEWCwGmR1HgaY0bkG4jPw1uqTdsYbB81mNcpZ6cQv2pIdGWD+/3HkCIag+dmRy6SgOSVsrAUCjW60t9j2WFIgNdEYT/XGcZvURFD3wJKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJoIrJMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741880543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPOOfTznhSlJ+wnVn87jnW8Ze1Pd06MmFX823WWLj+4=;
	b=TJoIrJMjTD68bn0XbcNgGY2w6eXPadY/+LWJ6HJ1BulX+9T3hENX4fzG3xPI/3+WDlqgq7
	tTC7bWsvRr3GrAYQIxQlMN9LDEdtVKGzmOU8AB8NCcxGjW7C2XUkepi86SfU+oWw01k/U4
	G5R/ngnL4V1V5g/k/jtK8YOV32qDyos=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-qHcwkr6SNCCi7PpYT0iYMA-1; Thu,
 13 Mar 2025 11:42:21 -0400
X-MC-Unique: qHcwkr6SNCCi7PpYT0iYMA-1
X-Mimecast-MFC-AGG-ID: qHcwkr6SNCCi7PpYT0iYMA_1741880540
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02A871956087;
	Thu, 13 Mar 2025 15:42:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.177])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1616D18001DE;
	Thu, 13 Mar 2025 15:42:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14-rc7
Date: Thu, 13 Mar 2025 16:42:06 +0100
Message-ID: <20250313154206.43726-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus!

If you have CONFIG_CHROME_PLATFORMS enabled, your config will get
a new knob, too: BT_HCIBTUSB_AUTO_ISOC_ALT. I hope that would not
be a problem.

The following changes since commit f315296c92fd4b7716bdea17f727ab431891dc3b:

  Merge tag 'net-6.14-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-06 09:34:54 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc7

for you to fetch changes up to 2409fa66e29a2c09f26ad320735fbdfbb74420da:

  Merge tag 'nf-25-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-13 15:07:39 +0100)

----------------------------------------------------------------
Including fixes from netfilter, bluetooth and wireless.
No known regressions outstanding.

Current release - regressions:

  - wifi: nl80211: fix assoc link handling

  - eth: lan78xx: sanitize return values of register read/write functions

Current release - new code bugs:

  - ethtool: tsinfo: fix dump command

  - bluetooth: btusb: configure altsetting for HCI_USER_CHANNEL

  - eth: mlx5: DR, use the right action structs for STEv3

Previous releases - regressions:

  - netfilter: nf_tables: make destruction work queue pernet

  - gre: fix IPv6 link-local address generation.

  - wifi: iwlwifi: fix TSO preparation

  - bluetooth: revert "bluetooth: hci_core: fix sleeping function called from invalid context"

  - ovs: revert "openvswitch: switch to per-action label counting in conntrack"

  - eth: ice: fix switchdev slow-path in LAG

  - eth: bonding: fix incorrect MAC address setting to receive NS messages

Previous releases - always broken:

  - core: prevent TX of unreadable skbs

  - sched: prevent creation of classes with TC_H_ROOT

  - netfilter: nft_exthdr: fix offset with ipv4_find_option()

  - wifi: cfg80211: cancel wiphy_work before freeing wiphy

  - mctp: copy headers if cloned

  - phy: nxp-c45-tja11xx: add errata for TJA112XA/B

  - eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}

  - eth: mlx5: bridge, fix the crash caused by LAG state check

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Amit Cohen (1):
      net: switchdev: Convert blocking notification chain to a raw one

Andrei Botila (2):
      net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
      net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

Benjamin Berg (1):
      wifi: mac80211: fix MPDU length parsing for EHT 5/6 GHz

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices

Cong Wang (2):
      net_sched: Prevent creation of classes with TC_H_ROOT
      selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT

Dan Carpenter (1):
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()

David S. Miller (1):
      Merge tag 'wireless-2025-03-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Edward Cree (1):
      MAINTAINERS: sfc: remove Martin Habets

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms
      wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state

Florian Westphal (2):
      netfilter: nf_tables: make destruction work queue pernet
      selftests: netfilter: skip br_netfilter queue tests if kernel is tainted

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Guillaume Nault (2):
      gre: Fix IPv6 link-local address generation.
      selftests: Add IPv6 link-local address generation tests for GRE devices.

Hangbin Liu (2):
      bonding: fix incorrect MAC address setting to receive NS messages
      selftests: bonding: fix incorrect mac address

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Hsin-chen Chuang (1):
      Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL

Ilan Peer (1):
      wifi: iwlwifi: pcie: Fix TSO preparation

Ilya Maximets (1):
      net: openvswitch: remove misbehaving actions length check

Jakub Kicinski (6):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-25-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2025-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'net-phy-nxp-c45-tja11xx-add-errata-for-tja112xa-b'
      Merge branch 'eth-bnxt-fix-several-bugs-in-the-bnxt-module'
      Merge branch 'net_sched-prevent-creation-of-classes-with-tc_h_root'

Jianbo Liu (1):
      net/mlx5: Bridge, fix the crash caused by LAG state check

Jiri Pirko (1):
      net/mlx5: Fill out devlink dev info only for PFs

Johannes Berg (3):
      wifi: rework MAINTAINERS entries a bit
      wifi: nl80211: fix assoc link handling
      wifi: mac80211: fix SA Query processing in MLO

Joseph Huang (1):
      net: dsa: mv88e6xxx: Verify after ATU Load ops

Jun Yang (1):
      sched: address a potential NULL pointer dereference in the GRED scheduler.

Justin Lai (1):
      rtase: Fix improper release of ring list entries in rtase_sw_reset

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()

Kory Maincent (1):
      net: ethtool: tsinfo: Fix dump command

Larysa Zaremba (1):
      ice: do not configure destination override for switchdev

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"

Marcin Szycik (1):
      ice: Fix switchdev slow-path in LAG

Matt Johnston (3):
      net: mctp i3c: Copy headers if cloned
      net: mctp i2c: Copy headers if cloned
      net: mctp: unshare packets when reassembling

Mina Almasry (1):
      netmem: prevent TX of unreadable skbs

Miri Korenblit (3):
      wifi: iwlwifi: trans: cancel restart work on op mode leave
      wifi: mac80211: don't queue sdata::work for a non-running sdata
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when jiffies wrap around

Oleksij Rempel (1):
      net: usb: lan78xx: Sanitize return values of register read/write functions

Paolo Abeni (4):
      Merge branch 'bonding-fix-incorrect-mac-address-setting'
      Merge branch 'gre-fix-regressions-in-ipv6-link-local-address-generation'
      Merge branch 'mlx5-misc-fixes-2025-03-10'
      Merge tag 'nf-25-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pauli Virtanen (1):
      Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready

Przemek Kitszel (1):
      ice: register devlink prior to creating health reporters

Sebastian Andrzej Siewior (1):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.

Shay Drory (2):
      net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
      net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch

Shradha Gupta (1):
      net: mana: cleanup mana struct after debugfs_remove()

Taehee Yoo (8):
      eth: bnxt: fix truesize for mb-xdp-pass case
      eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
      eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
      eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
      eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
      eth: bnxt: fix memory leak in queue reset
      net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
      selftests: drv-net: add xdp cases for ping.py

Vlad Dogaru (1):
      net/mlx5: HWS, Rightsize bwc matcher priority

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Xin Long (1):
      Revert "openvswitch: switch to per-action label counting in conntrack"

Yevgeny Kliteynik (1):
      net/mlx5: DR, use the right action structs for STEv3

 MAINTAINERS                                        |  38 ++--
 drivers/bluetooth/Kconfig                          |  12 ++
 drivers/bluetooth/btusb.c                          |  41 +++++
 drivers/net/bonding/bond_options.c                 |  55 +++++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  59 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  25 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   6 -
 drivers/net/ethernet/intel/ice/ice_lag.c           |  27 +++
 drivers/net/ethernet/intel/ice/ice_lib.c           |  18 --
 drivers/net/ethernet/intel/ice/ice_lib.h           |   4 -
 drivers/net/ethernet/intel/ice/ice_main.c          |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   3 +
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   3 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h       |   4 +
 .../mellanox/mlx5/core/steering/sws/dr_ste_v1.c    |  52 +++---
 .../mellanox/mlx5/core/steering/sws/dr_ste_v1.h    |   4 +
 .../mellanox/mlx5/core/steering/sws/dr_ste_v2.c    |   2 +
 .../mellanox/mlx5/core/steering/sws/dr_ste_v3.c    |  42 +++++
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  11 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  10 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |   8 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |  10 ++
 drivers/net/mctp/mctp-i2c.c                        |   5 +
 drivers/net/mctp/mctp-i3c.c                        |   5 +
 drivers/net/phy/nxp-c45-tja11xx.c                  |  68 +++++++
 drivers/net/usb/lan78xx.c                          |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  11 +-
 include/net/bluetooth/hci_core.h                   | 108 ++++-------
 include/net/netfilter/nf_tables.h                  |   4 +-
 net/bluetooth/hci_core.c                           |  10 +-
 net/bluetooth/hci_event.c                          |  37 ++--
 net/bluetooth/iso.c                                |   6 -
 net/bluetooth/l2cap_core.c                         |  12 +-
 net/bluetooth/rfcomm/core.c                        |   6 -
 net/bluetooth/sco.c                                |  25 ++-
 net/core/dev.c                                     |   3 +
 net/core/devmem.c                                  |   4 +-
 net/core/netpoll.c                                 |   9 +-
 net/ethtool/tsinfo.c                               |   3 +-
 net/ipv6/addrconf.c                                |  15 +-
 net/mac80211/eht.c                                 |   9 +-
 net/mac80211/rx.c                                  |  10 +-
 net/mac80211/sta_info.c                            |  20 ++-
 net/mac80211/util.c                                |   8 +-
 net/mctp/route.c                                   |  10 +-
 net/mctp/test/route-test.c                         | 109 +++++++++++
 net/netfilter/ipvs/ip_vs_ctl.c                     |   8 +-
 net/netfilter/nf_conncount.c                       |   6 +-
 net/netfilter/nf_tables_api.c                      |  24 +--
 net/netfilter/nft_compat.c                         |   8 +-
 net/netfilter/nft_ct.c                             |   6 +-
 net/netfilter/nft_exthdr.c                         |  10 +-
 net/openvswitch/conntrack.c                        |  30 ++--
 net/openvswitch/datapath.h                         |   3 +
 net/openvswitch/flow_netlink.c                     |  15 +-
 net/sched/sch_api.c                                |   6 +
 net/sched/sch_gred.c                               |   3 +-
 net/switchdev/switchdev.c                          |  25 ++-
 net/wireless/core.c                                |   7 +
 net/wireless/nl80211.c                             |  12 +-
 .../selftests/drivers/net/bonding/bond_options.sh  |   4 +-
 tools/testing/selftests/drivers/net/ping.py        | 200 +++++++++++++++++++--
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/gre_ipv6_lladdr.sh     | 177 ++++++++++++++++++
 tools/testing/selftests/net/lib/xdp_dummy.bpf.c    |   6 +
 .../selftests/net/netfilter/br_netfilter.sh        |   7 +
 .../selftests/net/netfilter/br_netfilter_queue.sh  |   7 +
 tools/testing/selftests/net/netfilter/nft_queue.sh |   1 +
 .../selftests/tc-testing/tc-tests/qdiscs/drr.json  |  25 +++
 86 files changed, 1252 insertions(+), 361 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh


