Return-Path: <netdev+bounces-246364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F245CE9F3B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E4B3027CEB
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBB2765FF;
	Tue, 30 Dec 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrSRnYUO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA58272801
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105619; cv=none; b=Y4XLqPdcvz/KTCnHA/CEgDEQdCH3kyb27UJL8BOFM6qwS6hbkf5AiTw918hs3hFIL4Mq6ABryE59tbJPGP06he3gKfcG4egduh7NCxtRaLEASsLOHROQ6Iq82i3xHqT5uhfe8pD4NuAke7qMfaZ/jRtAOFB94Cqcb29Yhy1CcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105619; c=relaxed/simple;
	bh=CwvHtRBgb/5Lfad8VfIQjukEypFivFSRog5r3dVVAVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWKlGjxHriP94SevjIo2/O/hzbwBcmPg4CDBdN5rXCWt322CWm74sTBv70m5B7uuTXMQs7yJzFpFfCEmDo9yVZLLXqLGeRVNRpvm1Egv0DC+/hoIhlTk3UNTNfJdbm6gjIfzTxHNnMqmHBo/utejJQFe7J/KSZ71xlTAvTpq14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrSRnYUO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767105616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Aki0pbNDgoBoJ0xuMO7Tnaup45WZeF2EjoGHhaJ6dk=;
	b=UrSRnYUOgS6oPaBkVk77Nctm+N6DCwA0NMlhbyrxdSU/A25VfVle/UMfHFLq4HxZXc5xtG
	yjKKMVwAjF9fP9fP2EOg4afBaddJidfoOXQfjhvJioTeqk6YGN5/me4Iw9IgFy4A166xua
	9zwXx66LK+wpaKBmhJMaq0K0w6ECGhM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-vr2EnFcqMIun3ovoDkEM8g-1; Tue,
 30 Dec 2025 09:40:10 -0500
X-MC-Unique: vr2EnFcqMIun3ovoDkEM8g-1
X-Mimecast-MFC-AGG-ID: vr2EnFcqMIun3ovoDkEM8g_1767105609
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 173561956095;
	Tue, 30 Dec 2025 14:40:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.102])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19E9519560A7;
	Tue, 30 Dec 2025 14:40:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.19-rc4
Date: Tue, 30 Dec 2025 15:39:59 +0100
Message-ID: <20251230143959.325961-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

The following changes since commit 7b8e9264f55a9c320f398e337d215e68cca50131:

  Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-19 07:55:35 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc4

for you to fetch changes up to 1adaea51c61b52e24e7ab38f7d3eba023b2d050d:

  ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT (2025-12-30 12:04:36 +0100)

----------------------------------------------------------------
Including fixes from Bluetooth and WiFi. Notably this includes the fix
for the iwlwifi issue you reported.

Current release - regressions:

  - core: avoid prefetching NULL pointers

  - wifi:
    - iwlwifi: implement settime64 as stub for MVM/MLD PTP
    - mac80211: fix list iteration in ieee80211_add_virtual_monitor()

  - handshake: fix null-ptr-deref in handshake_complete()

  - eth: mana: fix use-after-free in reset service rescan path

Previous releases - regressions:

  - openvswitch: avoid needlessly taking the RTNL on vport destroy

  - dsa: properly keep track of conduit reference

  - ipv4:
    - fix reference count leak when using error routes with nexthop objects
    - fib: restore ECMP balance from loopback

  - mptcp: ensure context reset on disconnect()

  - bluetooth: fix potential UaF in btusb

  - nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

  - eth: gve: defer interrupt enabling until NAPI registration

  - eth: i40e: fix scheduling in set_rx_mode

  - eth: macb: relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()

  - eth: rtl8150: fix memory leak on usb_submit_urb() failure

  - wifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Previous releases - always broken:

  - ip6_gre: make ip6gre_header() robust

  - ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

  - af_unix: don't post cmsg for SO_INQ unless explicitly asked for

  - phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration

  - wifi: mac80211: discard beacon frames to non-broadcast address

  - eth: iavf: fix off-by-one issues in iavf_config_rss_reg()

  - eth: stmmac: fix the crash issue for zero copy XDP_TX action

  - eth: team: fix check for port enabled in team_queue_override_port_prio_changed()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alice C. Munduruca (1):
      selftests: net: fix "buffer overflow detected" for tap.c

Aloka Dixit (1):
      wifi: mac80211: do not use old MBSSID elements

Ankit Garg (1):
      gve: defer interrupt enabling until NAPI registration

Anshumali Gaur (1):
      octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"

Arnd Bergmann (1):
      net: wangxun: move PHYLINK dependency

Bagas Sanjaya (1):
      net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct

Bitterblue Smith (1):
      Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"

Brian Vazquez (1):
      idpf: reduce mbx_task schedule delay to 300us

Dan Carpenter (1):
      wifi: cfg80211: sme: store capped length in __cfg80211_connect_result()

Daniel Zahka (2):
      selftests: drv-net: psp: fix templated test names in psp_ip_ver_test_builder()
      selftests: drv-net: psp: fix test names in ipver_test_builder()

Deepakkumar Karn (1):
      net: usb: rtl8150: fix memory leak on usb_submit_urb() failure

Deepanshu Kartikey (2):
      net: usb: asix: validate PHY address before use
      net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Dipayaan Roy (1):
      net: mana: Fix use-after-free in reset service rescan path

Dmitry Antipov (1):
      wifi: mac80211: fix list iteration in ieee80211_add_virtual_monitor()

Eric Dumazet (3):
      ip6_gre: make ip6gre_header() robust
      net: avoid prefetching NULL pointers
      usbnet: avoid a possible crash in dql_completed()

Ethan Nelson-Moore (2):
      net: usb: sr9700: support devices with virtual driver CD
      net: usb: sr9700: fix incorrect command used to write single register

Frode Nordahl (1):
      erspan: Initialize options_len before referencing options.

Gregory Herrero (1):
      i40e: validate ring_len parameter against hardware-specific values

Guangshuo Li (1):
      e1000: fix OOB in e1000_tbi_should_accept()

Haoxiang Li (1):
      fjes: Add missing iounmap in fjes_hw_init()

Ido Schimmel (2):
      ipv4: Fix reference count leak when using error routes with nexthop objects
      selftests: fib_nexthops: Add test cases for error routes deletion

Jacky Chou (1):
      net: mdio: aspeed: add dummy read to avoid read-after-write issue

Jens Axboe (1):
      af_unix: don't post cmsg for SO_INQ unless explicitly asked for

Jiayuan Chen (1):
      ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

Jiri Pirko (1):
      team: fix check for port enabled in team_queue_override_port_prio_changed()

Johannes Berg (2):
      Merge tag 'rtw-2025-12-15' of https://github.com/pkshih/rtw
      wifi: mac80211: don't WARN for connections on invalid channels

Jonas Gorski (1):
      net: dsa: b53: skip multicast entries for fdb_dump()

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Kohei Enju (1):
      iavf: fix off-by-one issues in iavf_config_rss_reg()

Larysa Zaremba (1):
      idpf: fix LAN memory regions command on some NVMs

Lorenzo Bianconi (1):
      net: airoha: Move net_devs registration in a dedicated routine

Miaoqian Lin (1):
      net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration

Moon Hee Lee (1):
      wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Morning Star (1):
      wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Paolo Abeni (7):
      mptcp: fallback earlier on simult connection
      mptcp: ensure context reset on disconnect()
      Merge branch 'mptcp-fix-warn-on-bad-status'
      Merge branch 'selftests-drv-net-psp-fix-templated-test-names-in-psp-py'
      Merge tag 'for-net-2025-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'wireless-2025-12-17' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Pauli Virtanen (1):
      Bluetooth: MGMT: report BIS capability flags in supported settings

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

Przemyslaw Korba (1):
      i40e: fix scheduling in set_rx_mode

Pwnverse (1):
      net: rose: fix invalid array index in rose_kill_by_device()

Rajashekar Hudumula (1):
      bng_en: update module description

Raju Rangoju (1):
      amd-xgbe: reset retries and mode on RX adapt failures

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: revert use of devm_kzalloc in btusb

Rosen Penev (1):
      net: mdio: rtl9300: use scoped for loops

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid needlessly taking the RTNL on vport destroy

Vadim Fedorenko (2):
      net: fib: restore ECMP balance from loopback
      selftests: fib_test: Add test case for ipv4 multi nexthops

Ville Syrjälä (1):
      wifi: iwlwifi: Fix firmware version handling

Vladimir Oltean (2):
      net: dsa: properly keep track of conduit reference
      net: dsa: fix missing put_device() in dsa_tree_find_first_conduit()

Wang Liang (1):
      net/handshake: Fix null-ptr-deref in handshake_complete()

Wei Fang (2):
      net: stmmac: fix the crash issue for zero copy XDP_TX action
      net: enetc: do not print error log if addr is 0

Will Rosenberg (1):
      ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()

Xiaolei Wang (1):
      net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()

Yao Zi (1):
      wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP

Yeoreum Yun (1):
      smc91x: fix broken irq-context in PREEMPT_RT

 drivers/bluetooth/btusb.c                          | 12 +++-
 drivers/net/dsa/b53/b53_common.c                   |  3 +
 drivers/net/ethernet/airoha/airoha_eth.c           | 39 ++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  2 +
 drivers/net/ethernet/broadcom/Kconfig              |  8 +--
 drivers/net/ethernet/broadcom/bnge/bnge.h          |  2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           |  3 +-
 .../net/ethernet/freescale/enetc/netc_blk_ctrl.c   |  8 ++-
 drivers/net/ethernet/google/gve/gve_main.c         |  2 +-
 drivers/net/ethernet/google/gve/gve_utils.c        |  2 +
 drivers/net/ethernet/intel/e1000/e1000_main.c      | 10 +++-
 drivers/net/ethernet/intel/i40e/i40e.h             | 11 ++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ----
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  5 ++
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  8 +++
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  2 +-
 drivers/net/ethernet/smsc/smc91x.c                 | 10 +---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 17 +++++-
 drivers/net/ethernet/wangxun/Kconfig               |  4 +-
 drivers/net/fjes/fjes_hw.c                         | 12 +++-
 drivers/net/mdio/mdio-aspeed.c                     |  7 +++
 drivers/net/mdio/mdio-realtek-rtl9300.c            |  6 +-
 drivers/net/phy/mediatek/mtk-ge-soc.c              |  2 +-
 drivers/net/team/team_core.c                       |  2 +-
 drivers/net/usb/asix_common.c                      |  5 ++
 drivers/net/usb/ax88172a.c                         |  6 +-
 drivers/net/usb/rtl8150.c                          |  2 +
 drivers/net/usb/sr9700.c                           |  9 ++-
 drivers/net/usb/usbnet.c                           |  3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |  7 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |  7 +++
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |  3 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |  4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |  3 +-
 drivers/net/wireless/ti/wlcore/tx.c                |  5 ++
 include/net/dsa.h                                  |  1 +
 net/bluetooth/mgmt.c                               |  6 ++
 net/bridge/br_private.h                            |  1 +
 net/core/dev.c                                     |  8 ++-
 net/dsa/dsa.c                                      | 67 +++++++++++----------
 net/handshake/netlink.c                            |  3 +-
 net/ipv4/fib_semantics.c                           | 26 ++++----
 net/ipv4/fib_trie.c                                |  7 ++-
 net/ipv4/ip_gre.c                                  |  6 +-
 net/ipv6/calipso.c                                 |  3 +-
 net/ipv6/ip6_gre.c                                 | 15 ++++-
 net/ipv6/route.c                                   | 13 +++-
 net/mac80211/cfg.c                                 | 10 ----
 net/mac80211/iface.c                               |  2 +-
 net/mac80211/mlme.c                                |  5 +-
 net/mac80211/ocb.c                                 |  3 +
 net/mac80211/rx.c                                  |  5 ++
 net/mptcp/options.c                                | 10 ++++
 net/mptcp/protocol.c                               |  8 ++-
 net/mptcp/protocol.h                               |  9 ++-
 net/mptcp/subflow.c                                |  6 --
 net/nfc/core.c                                     |  9 ++-
 net/openvswitch/vport-netdev.c                     | 17 ++++--
 net/rose/af_rose.c                                 |  2 +-
 net/unix/af_unix.c                                 | 11 +++-
 net/wireless/sme.c                                 |  2 +-
 tools/testing/selftests/drivers/net/psp.py         |  6 +-
 tools/testing/selftests/net/fib_nexthops.sh        | 15 +++++
 tools/testing/selftests/net/fib_tests.sh           | 70 +++++++++++++++++++++-
 tools/testing/selftests/net/tap.c                  | 16 ++---
 71 files changed, 428 insertions(+), 194 deletions(-)


