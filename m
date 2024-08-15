Return-Path: <netdev+bounces-118854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327295333A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EE5B27EA0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9AC1AD9E8;
	Thu, 15 Aug 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZInfUyS4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF01AC43B
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731152; cv=none; b=puVp6QAojDu7EcdT5iLMLtI9QcS1v6n+ocv+gFObdCFp7bqHHVFBVqNnpJMVqkeNqpU4JJXv0cH4Qu46tu7n6xjQEwj6EWGAXzD9LsKpjW4EWNz+IsdlO8ZRT1rq/lDtmd+1QsyfuqPqAN5tpVYo77YvB3B5gDrWOJcF7XOmjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731152; c=relaxed/simple;
	bh=/vQ98zdywwXZv+PafE6PeQ6apN1qUVfqc2vsm9FA8q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AduaXVGzPjUq/SPpMMz4CaowJAxD7PXQVUvT7LYVtxoXPdMl+eLFJyaPkqLqVdUM1yyNghFuRijddW9tLJLpaO1vAwmzNjfuJ5cyuVb41s8vgoGDuUzjbduKXuoLtPV07fc+lXGJCKWeH/GIyi6S/l1rCiqv4VbB/P8bZuxvmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZInfUyS4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723731149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=18IiibUW8uV7Ku75Ug+0Oze0E3iYIZVNdqdiUswad08=;
	b=ZInfUyS4+MTR21h1q7/hfDnnAk4PJUqIY1+uanE1CGfqWd2lPoGIk31hONuEH3QnxO+cU1
	N6aJQh4yDr3Qh0BMhq79CgZEbM601oPuxwJdBEUj+QOrjFsl8TLyZk6+4VsA4vJ2atrXNi
	xPeMD1VGhmR4eXUM84yiUPMsTVGccc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-FI5w1WxaORKeyQLKxOu_zA-1; Thu,
 15 Aug 2024 10:12:27 -0400
X-MC-Unique: FI5w1WxaORKeyQLKxOu_zA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 261EA1955BEE;
	Thu, 15 Aug 2024 14:12:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.82])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E42F519560AA;
	Thu, 15 Aug 2024 14:12:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc4
Date: Thu, 15 Aug 2024 16:11:49 +0200
Message-ID: <20240815141149.33862-1-pabeni@redhat.com>
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

The following changes since commit ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d:

  Merge tag 'net-6.11-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-08-08 13:51:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc4

for you to fetch changes up to 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b:

  Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-08-15 13:25:06 +0200)

----------------------------------------------------------------
Including fixes from wireless and netfilter

Current release - regressions:

  - udp: fall back to software USO if IPv6 extension headers are present

  - wifi: iwlwifi: correctly lookup DMA address in SG table

Current release - new code bugs:

  - eth: mlx5e: fix queue stats access to non-existing channels splat

Previous releases - regressions:

  - eth: mlx5e: take state lock during tx timeout reporter

  - eth: mlxbf_gige: disable RX filters until RX path initialized

  - eth: igc: fix reset adapter logics when tx mode change

Previous releases - always broken:

  - tcp: update window clamping condition

  - netfilter:
    - nf_queue: drop packets with cloned unconfirmed conntracks
    - nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests

  - vsock: fix recursive ->recvmsg calls

  - dsa: vsc73xx: fix MDIO bus access and PHY opera

  - eth: gtp: pull network headers in gtp_dev_xmit()

  - eth: igc: fix packet still tx after gate close by reducing i226 MAC retry buffer

  - eth: mana: fix RX buf alloc_size alignment and atomic op panic

  - eth: hns3: fix a deadlock problem when config TC during resetting

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Abhinav Jain (1):
      selftest: af_unix: Fix kselftest compilation warnings

Baochen Qiang (1):
      wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

Benjamin Berg (1):
      wifi: iwlwifi: correctly lookup DMA address in SG table

Bert Karwatzki (1):
      wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192du: Initialise value32 in _rtl92du_init_queue_reserved_page

Cong Wang (1):
      vsock: fix recursive ->recvmsg calls

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Dan Carpenter (1):
      atm: idt77252: prevent use after free in dequeue_rx()

Danielle Ratson (1):
      net: ethtool: Allow write mechanism of LPL and both LPL and EPL

David S. Miller (2):
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-q ueue
      Merge branch 'vsc73xx-fix-mdio-and-phy'

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Donald Hunter (2):
      netfilter: nfnetlink: Initialise extack before use in ACKs
      netfilter: flowtable: initialise extack before use

Dragos Tatulea (2):
      net/mlx5e: SHAMPO, Increase timeout to improve latency
      net/mlx5e: Take state lock during tx timeout reporter

Eric Dumazet (1):
      gtp: pull network headers in gtp_dev_xmit()

Eugene Syromiatnikov (1):
      mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size

Faizal Rahim (4):
      igc: Fix packet still tx after gate close by reducing i226 MAC retry buffer
      igc: Fix qbv_config_change_errors logics
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Florian Westphal (2):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks
      selftests: netfilter: add test for br_netfilter+conntrack+queue combination

Foster Snowhill (4):
      usbnet: ipheth: remove extraneous rx URB length check
      usbnet: ipheth: drop RX URBs with no payload
      usbnet: ipheth: do not stop RX on failing RX callback
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Frank Li (1):
      dt-bindings: net: fsl,qoriq-mc-dpmac: add missed property phys

Gal Pressman (1):
      net/mlx5e: Fix queue stats access to non-existing channels splat

Haiyang Zhang (1):
      net: mana: Fix RX buf alloc_size alignment and atomic op panic

Jakub Kicinski (3):
      Merge branch 'don-t-take-hw-uso-path-when-packets-can-t-be-checksummed-by-device'
      Merge branch 'mlx5-misc-fixes-2024-08-08'
      Merge tag 'wireless-2024-08-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jakub Sitnicki (3):
      net: Make USO depend on CSUM offload
      udp: Fall back to software USO if IPv6 extension headers are present
      selftests/net: Add coverage for UDP GSO with IPv6 extension headers

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Kalle Valo (1):
      Merge tag 'ath-current-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kuniyuki Iwashima (1):
      net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend().

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings

Marc Zyngier (1):
      net: thunder_bgx: Fix netdev structure allocation

Matthieu Baerts (NGI0) (1):
      selftests: net: lib: kill PIDs before del netns

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Oleksij Rempel (1):
      pse-core: Conditionally set current limit during PI regulator registration

Oliver Neukum (1):
      usbnet: ipheth: race between ipheth_close and error handling

Paolo Abeni (2):
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pawel Dembicki (5):
      net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: check busy flag in MDIO operations
      net: dsa: vsc73xx: allow phy resetting
      net: phy: vitesse: repair vsc73xx autonegotiation

Peiyang Wang (3):
      net: hns3: use the user's cfg after reset
      net: hns3: void array out of bound when loop tnl_num
      net: hns3: use correct release function during uninitialization

Phil Sutter (3):
      netfilter: nf_tables: Audit log dump reset after the fact
      netfilter: nf_tables: Introduce nf_tables_getobj_single
      netfilter: nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Subash Abhinov Kasiviswanathan (1):
      tcp: Update window clamping condition

Tariq Toukan (1):
      net/mlx5: SD, Do not query MPIR register if no sd_group

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Zheng Zhang (1):
      net: ethernet: mtk_wed: fix use-after-free panic in mtk_wed_setup_tc_block_cb()

 .../bindings/net/fsl,qoriq-mc-dpmac.yaml           |   4 +
 drivers/atm/idt77252.c                             |   9 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  54 ++++++--
 drivers/net/ethernet/cadence/macb_main.c           |   4 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  30 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |   6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  30 +++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   3 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   4 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       |   6 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   8 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |  76 +++++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.h           |   1 +
 drivers/net/ethernet/jme.c                         |  10 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  16 ++-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   1 +
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   2 +
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  17 +--
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  18 +--
 .../net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h  |   8 ++
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  10 ++
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h |   2 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  50 ++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  30 +++--
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |  16 +--
 drivers/net/gtp.c                                  |   3 +
 drivers/net/phy/vitesse.c                          |  14 --
 drivers/net/pse-pd/pse_core.c                      |  11 +-
 drivers/net/usb/ipheth.c                           |  20 +--
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  72 ++++++++++
 drivers/net/wireless/ath/ath12k/hw.c               |   6 +
 drivers/net/wireless/ath/ath12k/hw.h               |   4 +
 drivers/net/wireless/ath/ath12k/mac.c              |   1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  32 +++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.c    |   2 +-
 include/net/af_vsock.h                             |   4 +
 include/net/mana/mana.h                            |   1 +
 net/bridge/br_netfilter_hooks.c                    |   6 +-
 net/core/dev.c                                     |  26 ++--
 net/ethtool/cmis_fw_update.c                       |   8 +-
 net/ipv4/tcp_input.c                               |  28 ++--
 net/ipv4/udp_offload.c                             |   6 +
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   4 +
 net/mptcp/diag.c                                   |   2 +-
 net/netfilter/nf_flow_table_offload.c              |   2 +-
 net/netfilter/nf_tables_api.c                      | 147 ++++++++++++++-------
 net/netfilter/nfnetlink.c                          |   5 +-
 net/netfilter/nfnetlink_queue.c                    |  35 ++++-
 net/vmw_vsock/af_vsock.c                           |  50 ++++---
 net/vmw_vsock/vsock_bpf.c                          |   4 +-
 tools/testing/selftests/net/af_unix/msg_oob.c      |   2 +-
 tools/testing/selftests/net/lib.sh                 |   1 +
 tools/testing/selftests/net/netfilter/Makefile     |   1 +
 .../selftests/net/netfilter/br_netfilter_queue.sh  |  78 +++++++++++
 tools/testing/selftests/net/udpgso.c               |  25 +++-
 63 files changed, 790 insertions(+), 261 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/br_netfilter_queue.sh


