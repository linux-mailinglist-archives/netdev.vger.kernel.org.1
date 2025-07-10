Return-Path: <netdev+bounces-205788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB089B00247
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1091D163B32
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC761195FE8;
	Thu, 10 Jul 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5ZnZxQV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744F11CA0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151541; cv=none; b=BjQ9Wr/DrFseu5n03k0qT+Ycx/B/idJNeWFVlCl9hjV3GUFix2uhLFwH8J+ixgcFo1LEGb9JUSJvgTGT0RxbbNGLuuw9UGDokcQ88u0LEx1lGEKRgJpc8WgqmmeliDwAAZxvCTzMavmp7ot95UAiUnwdXlZAztktL4X3PM8gV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151541; c=relaxed/simple;
	bh=qzM1J0IyqdNKe7xLcZao/gywxjKq1jYq0uST8bF7sn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVWqbdjQw98F+aQLmq+7LFWgrg8da5q1y3dDG1UjQO3pTsz12Rk2uieaV2v9sYZk7n7VHAOobI6HnfN87bc0eujbvCuCO7Po8/WvwEUwQluziuTVuRxJAcmypCJNUgX90MIC5NCXUcXds/6+WaqccHR9ybUeIGlwupoqgbYjqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5ZnZxQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752151538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2BqWVLy/q6rFPIIJjYRdyMkSRIe24b5r477c8HimWtw=;
	b=K5ZnZxQV/xbGlkjKjJjkyI97LZf1wlv65k5gH0PbeWA23usoG6vOIVXsfKxMRlvCPIwxaz
	n4OR0MIb/CbqO9lA3BXQGR5ZXY6rTvDjt+4+cX2vMseo7UxPdMVz6/Snhq4ijPOpto+CC7
	HTNCOh+8dn/nLNgN8IGyej6/CX3lV5Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-PQ5puK5KN1aNduoGAIufKA-1; Thu,
 10 Jul 2025 08:45:35 -0400
X-MC-Unique: PQ5puK5KN1aNduoGAIufKA-1
X-Mimecast-MFC-AGG-ID: PQ5puK5KN1aNduoGAIufKA_1752151534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB91C18089B5;
	Thu, 10 Jul 2025 12:45:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2D0419560AD;
	Thu, 10 Jul 2025 12:45:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.16-rc6
Date: Thu, 10 Jul 2025 14:45:26 +0200
Message-ID: <20250710124526.32220-1-pabeni@redhat.com>
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

A slightly larger number of regressions than usual, but I'm not aware of
any other pending ones.

The following changes since commit 17bbde2e1716e2ee4b997d476b48ae85c5a47671:

  Merge tag 'net-6.16-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-03 09:18:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc6

for you to fetch changes up to dd831ac8221e691e9e918585b1003c7071df0379:

  net/sched: sch_qfq: Fix null-deref in agg_dequeue (2025-07-10 11:08:35 +0200)

----------------------------------------------------------------
Including fixes from Bluetooth.

Current release - regressions:

  - tcp: refine sk_rcvbuf increase for ooo packets

  - bluetooth: fix attempting to send HCI_Disconnect to BIS handle

  - rxrpc: fix over large frame size warning

  - eth: bcmgenet: initialize u64 stats seq counter

Previous releases - regressions:

  - tcp: correct signedness in skb remaining space calculation

  - sched: abort __tc_modify_qdisc if parent class does not exist

  - vsock: fix transport_{g2h,h2g} TOCTOU

  - rxrpc: fix bug due to prealloc collision

  - tipc: fix use-after-free in tipc_conn_close().

  - bluetooth: fix not marking Broadcast Sink BIS as connected

  - phy: qca808x: fix WoL issue by utilizing at8031_set_wol()

  - eth: am65-cpsw-nuss: fix skb size by accounting for skb_shared_info

Previous releases - always broken:

  - netlink: fix wraparounds of sk->sk_rmem_alloc.

  - atm: fix infinite recursive call of clip_push().

  - eth: stmmac: fix interrupt handling for level-triggered mode in DWC_XGMAC2

  - eth: rtsn: fix a null pointer dereference in rtsn_probe()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      net: thunderx: avoid direct MTU assignment after WRITE_ONCE()

Chen-Yu Tsai (1):
      dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info

Christophe JAILLET (1):
      net: airoha: Fix an error handling path in airoha_probe()

David Howells (3):
      rxrpc: Fix over large frame size warning
      rxrpc: Fix bug due to prealloc collision
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

Eric Dumazet (2):
      tcp: refine sk_rcvbuf increase for ooo packets
      selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt

EricChan (1):
      net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2

Haoxiang Li (1):
      net: ethernet: rtsn: Fix a null pointer dereference in rtsn_probe()

Jakub Kicinski (8):
      Merge branch 'fix-qca808x-wol-issue'
      Merge tag 'for-net-2025-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'allwinner-a523-rename-emac0-to-gmac0'
      Merge branch 'vsock-fix-transport_-h2g-g2h-dgram-local-toctou-issues'
      Merge branch 'net-phy-smsc-robustness-fixes-for-lan87xx-lan9500'
      Merge branch 'atm-clip-fix-infinite-recursion-potential-null-ptr-deref-and-memleak'
      Merge branch 'tcp-better-memory-control-for-not-yet-accepted-sockets'
      Merge branch 'rxrpc-miscellaneous-fixes'

Jason Xing (1):
      bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL

Jiayuan Chen (1):
      tcp: Correct signedness in skb remaining space calculation

Kuniyuki Iwashima (5):
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().

Louis Peens (1):
      MAINTAINERS: remove myself as netronome maintainer

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix not disabling advertising instance
      Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
      Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
      Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

Luo Jie (2):
      net: phy: qcom: move the WoL function to shared library
      net: phy: qcom: qca808x: Fix WoL issue by utilizing at8031_set_wol()

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Oleksij Rempel (3):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Force predictable MDI-X state on LAN87xx
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX

Ryo Takakura (1):
      net: bcmgenet: Initialize u64 stats seq counter

Stefano Garzarella (1):
      vsock: fix `vsock_proto` declaration

Victor Nogueira (2):
      selftests/tc-testing: Create test case for UAF scenario with DRR/NETEM/BLACKHOLE chain
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  2 +-
 MAINTAINERS                                        |  4 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 10 ++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  6 ++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 12 +---
 drivers/net/ethernet/renesas/rtsn.c                |  5 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 24 +++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  4 +-
 drivers/net/phy/qcom/at803x.c                      | 27 --------
 drivers/net/phy/qcom/qca808x.c                     |  2 +-
 drivers/net/phy/qcom/qcom-phy-lib.c                | 25 +++++++
 drivers/net/phy/qcom/qcom.h                        |  5 ++
 drivers/net/phy/smsc.c                             | 57 +++++++++++++--
 include/net/af_vsock.h                             |  2 +-
 include/net/bluetooth/hci_core.h                   |  3 +-
 include/net/pkt_sched.h                            | 25 ++++++-
 net/atm/clip.c                                     | 64 ++++++++++++-----
 net/bluetooth/hci_event.c                          |  3 +
 net/bluetooth/hci_sync.c                           |  4 +-
 net/ipv4/tcp.c                                     |  2 +-
 net/ipv4/tcp_input.c                               |  4 +-
 net/netlink/af_netlink.c                           | 81 +++++++++++++---------
 net/rxrpc/ar-internal.h                            | 15 ++--
 net/rxrpc/call_accept.c                            |  4 ++
 net/rxrpc/output.c                                 |  5 +-
 net/sched/sch_api.c                                | 33 +++++----
 net/sched/sch_hfsc.c                               | 16 -----
 net/sched/sch_qfq.c                                |  2 +-
 net/tipc/topsrv.c                                  |  2 +
 net/vmw_vsock/af_vsock.c                           | 57 ++++++++++++---
 .../tcp_ooo-before-and-after-accept.pkt            | 53 ++++++++++++++
 .../tc-testing/tc-tests/infra/qdiscs.json          | 37 ++++++++++
 33 files changed, 421 insertions(+), 175 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt


