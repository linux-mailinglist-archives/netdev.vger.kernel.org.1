Return-Path: <netdev+bounces-131610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DC98F047
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56EE1F22AFE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9D19B3FF;
	Thu,  3 Oct 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOdIkUyq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C02BAFC
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961813; cv=none; b=QQeDP+RWhdcmWcUYvKEnLmqIcGHqkMRSab0Ff8OzrTIZ5NEBlAXs0rkeEr1m1DzPp03h0C+WQDq2c47vQmdZ1PbGu1bibrN2cLgrR6IPzYFKbbycyJco838ixC51sq9SPKNehfYV4hVmKkXqsIv4ilhJZZrbVjQEyqoSQKPWCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961813; c=relaxed/simple;
	bh=+g4D41G9E/gTcvaT6Lc/6aR0I06Xgk+K8ZtCl8/7JQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sLF75/xn07Ql53hoan8oA1OmD9bFeyR8TFYkIxNcPkXIsc9nlh0ZvI3ItzNtBa1BHbVt1+3axuUgi3HzdHDZaiXkpueiLbEBXu3KPweemWJGHYcv+SS1lsDKUyWDhsw9skn9e0aGrA99ZiuiVGgxIkFUvRrDaMl5r14ChbhYHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOdIkUyq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727961809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Udh+D3KcyXmjXENW577w+3fYh/n4oDV27euJaC3aD8=;
	b=gOdIkUyqSx1dtelL43p2C68Y0njxpqVOQVED6AjXE4iaUCeHKjEzh+29r8z/nK45Hp5mkb
	Vv72EWYEs/IfpKk2TPAYSQ0Hg+F+lMZCu+g9soAevowSFeD59DHQBDyaaI/4wdIqK6L5+I
	4ChdKb69ZeQIBgOkUxMDZNDRp2fVhac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-NiMhYkClMLu2yiWBKj-dog-1; Thu,
 03 Oct 2024 09:23:26 -0400
X-MC-Unique: NiMhYkClMLu2yiWBKj-dog-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B989819560BD;
	Thu,  3 Oct 2024 13:23:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.141])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D7551956054;
	Thu,  3 Oct 2024 13:23:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc2
Date: Thu,  3 Oct 2024 15:23:02 +0200
Message-ID: <20241003132302.26857-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Linus!

The following changes since commit 62a0e2fa40c5c06742b8b4997ba5095a3ec28503:

  Merge tag 'net-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-09-26 10:27:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc2

for you to fetch changes up to 8beee4d8dee76b67c75dc91fd8185d91e845c160:

  sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start (2024-10-03 12:18:29 +0200)

----------------------------------------------------------------
Including fixes from ieee802154, bluetooth and netfilter.

Current release - regressions:

  - eth: mlx5: fix wrong reserved field in hca_cap_2 in mlx5_ifc

  - eth: am65-cpsw: fix forever loop in cleanup code

Current release - new code bugs:

  - eth: mlx5: HWS, fixed double-free in error flow of creating SQ

Previous releases - regressions:

  - core: avoid potential underflow in qdisc_pkt_len_init() with UFO

  - core: test for not too small csum_start in virtio_net_hdr_to_skb()

  - vrf: revert "vrf: remove unnecessary RCU-bh critical section"

  - bluetooth:
    - fix uaf in l2cap_connect
    - fix possible crash on mgmt_index_removed

  - dsa: improve shutdown sequence

  - eth: mlx5e: SHAMPO, fix overflow of hd_per_wq

  - eth: ip_gre: fix drops of small packets in ipgre_xmit

Previous releases - always broken:

  - core: fix gso_features_check to check for both dev->gso_{ipv4_,}max_size

  - core: fix tcp fraglist segmentation after pull from frag_list

  - netfilter: nf_tables: prevent nf_skb_duplicated corruption

  - sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

  - mac802154: fix potential RCU dereference issue in mac802154_scan_worker

  - eth: fec: restart PPS after link state change

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aakash Menon (1):
      net: sparx5: Fix invalid timestamps

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Csókás, Bence (2):
      net: fec: Restart PPS after link state change
      net: fec: Reload PTP registers after link-state change

Dan Carpenter (1):
      net: ethernet: ti: am65-cpsw: Fix forever loop in cleanup code

Daniel Borkmann (2):
      net: Add netif_get_gro_max_size helper for GRO
      net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix overflow of hd_per_wq

Eddie James (1):
      net/ncsi: Disable the ncsi work before freeing the associated structure

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Eric Dumazet (5):
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net: test for not too small csum_start in virtio_net_hdr_to_skb()
      ppp: do not assume bh is held in ppp_channel_bridge_input()

FUJITA Tomonori (1):
      net: phy: qt2025: Fix warning: unused import DeviceId

Felix Fietkau (1):
      net: gso: fix tcp fraglist segmentation after pull from frag_list

Geert Uytterhoeven (1):
      net: microchip: Make FDMA config symbol invisible

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Hangbin Liu (1):
      selftests: rds: move include.sh to TEST_FILES

Hui Wang (1):
      net: phy: realtek: Check the index value in led_hw_control_get

Ido Schimmel (1):
      bridge: mcast: Fail MDB get request on empty entry

Jakub Kicinski (3):
      Merge tag 'ieee802154-for-net-2024-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      Merge tag 'for-net-2024-09-27' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'mlx5-fixes-2024-09-25' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux

Jianbo Liu (1):
      net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice

Jiawei Ye (1):
      mac802154: Fix potential RCU dereference issue in mac802154_scan_worker

Jiawen Wu (1):
      net: pcs: xpcs: fix the wrong register that was written back

Jinjie Ruan (4):
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Mohamed Khalfella (1):
      net/mlx5: Added cond_resched() to crdump collection

Paolo Abeni (3):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-two-fixes-for-qdisc_pkt_len_init'
      Merge tag 'nf-24-10-02' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Phil Sutter (2):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      selftests: netfilter: Fix nft_audit.sh for newer nft binaries

Ravikanth Tuniki (1):
      dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems

Roger Quadros (1):
      net: ethernet: ti: cpsw_ale: Fix warning on some platforms

Sean Anderson (1):
      doc: net: napi: Update documentation for napi_schedule_irqoff

Shenwei Wang (1):
      net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check

Vladimir Oltean (1):
      net: dsa: improve shutdown sequence

Willem de Bruijn (2):
      vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
      gso: fix udp gso fraglist segmentation after pull from frag_list

Xin Long (1):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

Yevgeny Kliteynik (3):
      net/mlx5: Fix wrong reserved field in hca_cap_2 in mlx5_ifc
      net/mlx5: HWS, fixed double-free in error flow of creating SQ
      net/mlx5: HWS, changed E2BIG error to a negative return code

zhang jiao (1):
      selftests: netfilter: Add missing return value

 .../devicetree/bindings/net/xlnx,axi-ethernet.yaml |  3 +-
 Documentation/networking/napi.rst                  |  5 +-
 drivers/bluetooth/btmrvl_sdio.c                    |  3 +-
 drivers/net/ethernet/freescale/fec.h               |  9 ++++
 drivers/net/ethernet/freescale/fec_main.c          | 11 ++++-
 drivers/net/ethernet/freescale/fec_ptp.c           | 50 +++++++++++++++++++
 drivers/net/ethernet/lantiq_etop.c                 |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c   |  3 ++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  8 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  1 -
 .../net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c  | 10 ++++
 .../mlx5/core/steering/hws/mlx5hws_bwc_complex.c   |  2 +-
 .../mlx5/core/steering/hws/mlx5hws_definer.c       |  4 +-
 .../mlx5/core/steering/hws/mlx5hws_matcher.c       |  2 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.c |  8 ++-
 drivers/net/ethernet/microchip/fdma/Kconfig        |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  6 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18 +++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 | 12 ++++-
 drivers/net/ethernet/ti/cpsw_ale.h                 |  1 +
 drivers/net/ieee802154/Kconfig                     |  1 +
 drivers/net/ieee802154/mcr20a.c                    |  5 +-
 drivers/net/pcs/pcs-xpcs-wx.c                      |  2 +-
 drivers/net/phy/qt2025.rs                          |  4 +-
 drivers/net/phy/realtek.c                          |  3 ++
 drivers/net/ppp/ppp_generic.c                      |  4 +-
 drivers/net/vrf.c                                  |  2 +
 drivers/net/wwan/qcom_bam_dmux.c                   | 11 +++--
 include/linux/mlx5/mlx5_ifc.h                      |  2 +-
 include/linux/netdevice.h                          | 18 +++++++
 include/linux/virtio_net.h                         |  4 +-
 include/uapi/linux/netfilter/nf_tables.h           |  2 +-
 net/bluetooth/hci_core.c                           |  2 +
 net/bluetooth/hci_event.c                          | 15 +++---
 net/bluetooth/l2cap_core.c                         |  8 ---
 net/bluetooth/mgmt.c                               | 23 +++++----
 net/bridge/br_mdb.c                                |  2 +-
 net/core/dev.c                                     | 14 ++++--
 net/core/gro.c                                     |  9 +---
 net/dsa/dsa.c                                      |  7 +++
 net/ipv4/ip_gre.c                                  |  6 +--
 net/ipv4/netfilter/nf_dup_ipv4.c                   |  7 ++-
 net/ipv4/tcp_offload.c                             | 10 +++-
 net/ipv4/udp_offload.c                             | 22 ++++++++-
 net/ipv6/netfilter/nf_dup_ipv6.c                   |  7 ++-
 net/ipv6/tcpv6_offload.c                           | 10 +++-
 net/mac802154/scan.c                               |  4 +-
 net/ncsi/ncsi-manage.c                             |  2 +
 net/sctp/socket.c                                  |  4 +-
 .../selftests/net/netfilter/conntrack_dump_flush.c |  1 +
 tools/testing/selftests/net/netfilter/nft_audit.sh | 57 +++++++++++-----------
 tools/testing/selftests/net/rds/Makefile           |  3 +-
 tools/testing/selftests/net/rds/test.py            |  0
 55 files changed, 310 insertions(+), 127 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py


