Return-Path: <netdev+bounces-185502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14691A9AB67
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9949092102C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DCE221FD2;
	Thu, 24 Apr 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/J6kptg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1551F418D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492840; cv=none; b=Z+Q1zDT+ANkwBNRQoSuYe8dmWg63Ky5DalFac1OFl43rNd7F7Y1/sbnECIhPhlslxrqOG7oTnqCpI+5QBWX9/uvnM3Z9k6+O67xEJFZ1BYWDmwRSOp5JFPgnseDlG4AIwR8dvMzhc5VqTJYnJ+qww5EK5+yYtIsJlgAxTCiUAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492840; c=relaxed/simple;
	bh=ClSuI/NrvM2Zv2F5frbCCuGI835blwkR2VL0hs57iWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Py1kBXgk2ggoeJXM5XCjZZa4pIuDwm9kB9RDhGAuJFFJpB0zkSqiEpNppSwfubFhSTEKC/qIeU4mOOk/LpGLHMZC41+joK19xGocy5QmRpfj5iLX7BMC7mJCfEYEjJQIG+jIbGhKosoxIgd04EDD98xUwmnPsY/jqqlD9clEc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/J6kptg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745492837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9CA4AQabpeQLLbZ9nuW0/281YggIsBTeEJ2zypjMHmI=;
	b=H/J6kptgEVpWqFcSN9jdsXeHhImWIuEpSClEt55fx1eFmGS66+gSG+0OUz93x9X1ESvVKf
	8DNVsKKD4Yy163Zd/t6bo5kjLfbDNYrFHHuPvu9qgStDAnphYpn2wD0W15RNMg7t/+oy8/
	6P+ci16OYwuVjyboPubmlMgeZg2JJvo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-vW-KsgkNMf2Yp0LHDUUUsw-1; Thu,
 24 Apr 2025 07:07:14 -0400
X-MC-Unique: vW-KsgkNMf2Yp0LHDUUUsw-1
X-Mimecast-MFC-AGG-ID: vW-KsgkNMf2Yp0LHDUUUsw_1745492833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DFCB1800370;
	Thu, 24 Apr 2025 11:07:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.223])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDC4918001D5;
	Thu, 24 Apr 2025 11:07:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.15-rc4
Date: Thu, 24 Apr 2025 13:06:59 +0200
Message-ID: <20250424110659.163332-1-pabeni@redhat.com>
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

The following changes since commit b5c6891b2c5b54bf58069966296917da46cda6f2:

  Merge tag 'net-6.15-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-17 11:45:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc4

for you to fetch changes up to cc0dec3f659d19805fcaf8822204137c9f27a912:

  Merge branch 'net-stmmac-fix-timestamp-snapshots-on-dwmac1000' (2025-04-24 11:50:46 +0200)

----------------------------------------------------------------
No fixes from any subtree.

Current release - regressions:

  - net: fix the missing unlock for detached devices

Previous releases - regressions:

  - sched: fix UAF vulnerability in HFSC qdisc

  - lwtunnel: disable BHs when required

  - mptcp: pm: defer freeing of MPTCP userspace path manager entries

  - tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

  - eth: virtio-net: disable delayed refill when pausing rx

Previous releases - always broken:

  - phylink: fix suspend/resume with WoL enabled and link down

  - eth: mlx5: fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()

  - eth: xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()

  - eth: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and XDP_PASS

  - eth:  stmmac: fix dwmac1000 ptp timestamp status offset

  - eth: pds_core: prevent possible adminq overflow/stuck condition

Misc:

  - a bunch of MAINTAINERS updates

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexey Nepomnyashih (1):
      xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()

Alexis Lothore (1):
      net: stmmac: fix dwmac1000 ptp timestamp status offset

Alexis Lothoré (1):
      net: stmmac: fix multiplication overflow when reading timestamp

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: net: revise NETSYSv3 hardware configuration

Brett Creeley (3):
      pds_core: Prevent possible adminq overflow/stuck condition
      pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
      pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Bui Quang Minh (1):
      virtio-net: disable delayed refill when pausing rx

Cong Wang (3):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
      selftests/tc-testing: Add test for HFSC queue emptying during peek operation

Daniel Golle (1):
      net: dsa: mt7530: sync driver-specific behavior of MT7531 variants

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Geliang Tang (1):
      selftests: mptcp: diag: use mptcp_lib_get_info_value

Henry Martin (2):
      net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
      net/mlx5: Move ttc allocation after switch case to prevent leaks

Jakub Kicinski (7):
      Merge branch 'net-mlx5-fix-null-dereference-and-memory-leak-in-ttc_table-creation'
      net: fix the missing unlock for detached devices
      Merge branch 'maintainers-update-entries-for-s390-network-driver-files'
      Merge branch 'enetc-bug-fixes-for-bpf_xdp_adjust_head-and-bpf_xdp_adjust_tail'
      Merge branch 'mptcp-pm-defer-freeing-userspace-pm-entries'
      Merge branch 'net_sched-fix-uaf-vulnerability-in-hfsc-qdisc'
      Merge branch 'pds_core-updates-and-fixes'

Johannes Schneider (1):
      net: dp83822: Fix OF_MDIO config check

Justin Iurman (1):
      net: lwtunnel: disable BHs when required

Mat Martineau (1):
      mptcp: pm: Defer freeing of MPTCP userspace path manager entries

Maxime Chevallier (1):
      MAINTAINERS: Add entry for Socfpga DWMAC ethernet glue driver

Oleksij Rempel (1):
      net: selftests: initialize TCP header and skb payload with zero

Paolo Abeni (1):
      Merge branch 'net-stmmac-fix-timestamp-snapshots-on-dwmac1000'

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Russell King (Oracle) (2):
      net: phylink: fix suspend/resume with WoL enabled and link down
      net: phylink: mac_link_(up|down)() clarifications

Shannon Nelson (1):
      pds_core: make wait_context part of q_info

Simon Horman (2):
      MAINTAINERS: Add ism.h to S390 NETWORKING DRIVERS
      MAINTAINERS: Add s390 networking drivers to NETWORKING DRIVERS

Tung Nguyen (1):
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Vladimir Oltean (3):
      net: enetc: register XDP RX queues with frag_size
      net: enetc: refactor bulk flipping of RX buffers to separate function
      net: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and XDP_PASS

 MAINTAINERS                                        |  9 +++
 drivers/net/dsa/mt7530.c                           |  6 +-
 drivers/net/ethernet/amd/pds_core/adminq.c         | 36 +++++------
 drivers/net/ethernet/amd/pds_core/auxbus.c         |  3 -
 drivers/net/ethernet/amd/pds_core/core.c           |  9 ++-
 drivers/net/ethernet/amd/pds_core/core.h           |  4 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |  4 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       | 45 ++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 24 ++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        | 10 +++-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c   | 26 +++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
 drivers/net/phy/dp83822.c                          |  2 +-
 drivers/net/phy/microchip.c                        | 46 +--------------
 drivers/net/phy/phy_led_triggers.c                 | 23 ++++----
 drivers/net/phy/phylink.c                          | 38 +++++++-----
 drivers/net/virtio_net.c                           | 69 ++++++++++++++++++----
 drivers/net/xen-netfront.c                         | 17 ++++--
 include/linux/phylink.h                            | 31 ++++++----
 net/core/lwtunnel.c                                | 26 ++++++--
 net/core/netdev-genl.c                             |  9 ++-
 net/core/selftests.c                               | 18 ++++--
 net/mptcp/pm_userspace.c                           |  6 +-
 net/sched/sch_hfsc.c                               | 23 ++++++--
 net/tipc/monitor.c                                 |  3 +-
 tools/testing/selftests/net/mptcp/diag.sh          |  5 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          | 39 ++++++++++++
 29 files changed, 344 insertions(+), 195 deletions(-)


