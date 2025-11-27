Return-Path: <netdev+bounces-242312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9EC8ECB5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAD97353199
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E4333739;
	Thu, 27 Nov 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5Dsq1qq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1B2FBE03
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254333; cv=none; b=WpnSDYmepddbCa8YaVqHBxxleX1KFDzGpGGx/7y5yHe5PuGTfI+fmmBZ7iDv85nfcyj3k573qpeNXS5UlDlPydAuOsz17bfMDQrE9sfAbTJFuwXHZEgLOxGDFE9+I9VnOql+azuXahT345VH00ryc1oh0zhx31DracZruBE2tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254333; c=relaxed/simple;
	bh=U/9boMjt36wt9x4xKyaP0x/QdGpbuuN6EEXiWms98EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6w1N4MIi+kZkkW5dDNnZEJU0grHKDm3ZEKZm9G1g0eDQf8Ly9YQQiq3k75pgwg9PaRnkXJFIPLOj4gkH2pLIRf6c7M36hP1m3wDJbEvHDTL2rcP/81TUiPI2kpOHKNjbeA02pfzmLo6JMl7eWcxcVVoSuhnTBtewBl8vByB4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5Dsq1qq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764254330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MqBqOmVjVY1/zEK4FjHFWDDe1Eu3blA56gyNLfT+3PI=;
	b=K5Dsq1qqlS+SUT2SR82phKYfTTcZfLbnhiWfVWRTJmZ9ZPpA0uvNBxqCxGomJ4TxcJED6x
	AgAr2yCP0aj6mDJpsKIL3j7h+WrJX+abV59le9jK5QgdtFvbc1KZ4sRv8H6mhrjDjYYk8b
	cusuu17DJUeJmifCsogpNLsv1yGc2e0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-U5-3eLzNNzOQHj3OyAZEVQ-1; Thu,
 27 Nov 2025 09:38:44 -0500
X-MC-Unique: U5-3eLzNNzOQHj3OyAZEVQ-1
X-Mimecast-MFC-AGG-ID: U5-3eLzNNzOQHj3OyAZEVQ_1764254323
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B407180122F;
	Thu, 27 Nov 2025 14:38:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.178])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3038818004A3;
	Thu, 27 Nov 2025 14:38:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18-rc8
Date: Thu, 27 Nov 2025 15:38:30 +0100
Message-ID: <20251127143830.279720-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Linus!

The following changes since commit 8e621c9a337555c914cf1664605edfaa6f839774:

  Merge tag 'net-6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-20 08:52:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc8

for you to fetch changes up to f07f4ea53e22429c84b20832fa098b5ecc0d4e35:

  mptcp: Initialise rcv_mss before calling tcp_send_active_reset() in mptcp_do_fastclose(). (2025-11-27 13:10:16 +0100)

----------------------------------------------------------------
Including fixes from bluetooth and CAN. No known outstanding
regressions.

Current release - regressions:

  - mptcp: initialize rcv_mss before calling tcp_send_active_reset()

  - eth: mlx5e: fix validation logic in rate limiting

Previous releases - regressions:

  - xsk: avoid data corruption on cq descriptor number

  - bluetooth:
    - prevent race in socket write iter and sock bind
    - fix not generating mackey and ltk when repairing

  - can:
    - kvaser_usb: fix potential infinite loop in command parsers
    - rcar_canfd: fix CAN-FD mode as default

  - eth: veth: reduce XDP no_direct return section to fix race

  - eth: virtio-net: avoid unnecessary checksum calculation on guest RX

Previous releases - always broken:

  - sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()

  - bluetooth: mediatek: fix kernel crash when releasing iso interface

  - vhost: rewind next_avail_head while discarding descriptors

  - eth: r8169: fix RTL8127 hang on suspend/shutdown

  - eth: aquantia: add missing descriptor cache invalidation on ATL2

  - dsa: microchip: fix resource releases in error path

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/net: list Aswin Karuvally as maintainer

Alexey Kodanev (1):
      net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Bastien Curutchet (Schneider Electric) (5):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Don't free uninitialized ksz_irq
      net: dsa: microchip: Free previously initialized ports on init failures
      net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()

Biju Das (1):
      can: rcar_canfd: Fix CAN-FD mode as default

Chris Lu (1):
      Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface

Daniel Golle (2):
      net: phy: mxl-gpy: fix bogus error on USXGMII and integrated PHY
      net: phy: mxl-gpy: fix link properties on USXGMII and internal PHYs

Danielle Costantino (1):
      net/mlx5e: Fix validation logic in rate limiting

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Eric Dumazet (1):
      net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()

Fernando Fernandez Mancera (1):
      xsk: avoid data corruption on cq descriptor number

Gui-Dong Han (1):
      atm/fore200e: Fix possible data race in fore200e_open()

Heiner Kallweit (1):
      r8169: fix RTL8127 hang on suspend/shutdown

Horatiu Vultur (1):
      net: lan966x: Fix the initialization of taprio

Jakub Kicinski (2):
      Merge tag 'for-net-2025-11-21' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-6.18-20251126' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Jason Wang (1):
      vhost: rewind next_avail_head while discarding descriptors

Jeremy Kerr (1):
      net: mctp: unconditionally set skb->dev on dst output

Jesper Dangaard Brouer (1):
      veth: reduce XDP no_direct return section to fix race

Jiefeng Zhang (1):
      net: atlantic: fix fragment overflow handling in RX path

Jon Kohler (2):
      virtio-net: avoid unnecessary checksum calculation on guest RX
      MAINTAINERS: separate VIRTIO NET DRIVER and add netdev

Kai-Heng Feng (1):
      net: aquantia: Add missing descriptor cache invalidation on ATL2

Kuniyuki Iwashima (1):
      mptcp: Initialise rcv_mss before calling tcp_send_active_reset() in mptcp_do_fastclose().

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Marc Kleine-Budde (5):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
      Merge patch series "can: gs_usb: fix USB bulk in and out callbacks"
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Mohsin Bashir (1):
      eth: fbnic: Fix counter roll-over issue

Nikola Z. Ivanov (1):
      team: Move team device type change at the end of team_port_add

Paolo Abeni (3):
      Merge branch 'net-dsa-microchip-fix-resource-releases-in-error-path'
      mptcp: clear scheduled subflows on retransmit
      Merge branch 'net-fec-fix-some-ptp-related-issues'

Pauli Virtanen (1):
      Bluetooth: hci_core: lookup hci_conn on RX path on protocol side

Sayooj K Karun (1):
      net: atm: fix incorrect cleanup function call in error path

Seungjin Bae (1):
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Shaurya Rane (1):
      net/sched: em_canid: fix uninit-value in em_canid_match

Slark Xiao (1):
      net: wwan: mhi: Keep modem name match with Foxconn T99W640

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

Vladimir Oltean (1):
      net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic

Wei Fang (4):
      net: fec: cancel perout_timer when PEROUT is disabled
      net: fec: do not update PEROUT if it is enabled
      net: fec: do not allow enabling PPS and PEROUT simultaneously
      net: fec: do not register PPS event for PEROUT

 MAINTAINERS                                        |  19 ++-
 drivers/atm/fore200e.c                             |   2 +
 drivers/bluetooth/btusb.c                          |  39 +++++-
 drivers/net/can/rcar/rcar_canfd.c                  |  53 ++++----
 drivers/net/can/sja1000/sja1000.c                  |   4 +-
 drivers/net/can/sun4i_can.c                        |   4 +-
 drivers/net/can/usb/gs_usb.c                       | 100 ++++++++++++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |   4 +-
 drivers/net/dsa/microchip/ksz_common.c             |  31 +++--
 drivers/net/dsa/microchip/ksz_ptp.c                |  22 ++--
 drivers/net/dsa/sja1105/sja1105_main.c             |   7 -
 .../net/ethernet/aquantia/atlantic/aq_hw_utils.c   |  22 ++++
 .../net/ethernet/aquantia/atlantic/aq_hw_utils.h   |   1 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  19 +--
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |   2 +-
 drivers/net/ethernet/freescale/fec.h               |   1 +
 drivers/net/ethernet/freescale/fec_ptp.c           |  64 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   2 +-
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   |   5 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  19 ++-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |   4 +-
 drivers/net/phy/mxl-gpy.c                          |  20 +--
 drivers/net/team/team_core.c                       |  23 ++--
 drivers/net/tun_vnet.h                             |   2 +-
 drivers/net/veth.c                                 |   7 +-
 drivers/net/virtio_net.c                           |   3 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |   2 +-
 drivers/vhost/net.c                                |  53 +++++---
 drivers/vhost/vhost.c                              |  76 +++++++++--
 drivers/vhost/vhost.h                              |  10 +-
 include/linux/virtio_net.h                         |   7 +-
 include/net/bluetooth/hci_core.h                   |  21 ++-
 include/net/pkt_cls.h                              |   2 +
 net/atm/common.c                                   |   2 +-
 net/bluetooth/hci_core.c                           |  89 ++++++-------
 net/bluetooth/hci_sock.c                           |   2 +
 net/bluetooth/iso.c                                |  30 ++++-
 net/bluetooth/l2cap_core.c                         |  23 +++-
 net/bluetooth/sco.c                                |  35 +++--
 net/bluetooth/smp.c                                |  31 +----
 net/mctp/route.c                                   |   1 +
 net/mptcp/protocol.c                               |  19 ++-
 net/sched/em_canid.c                               |   3 +
 net/sched/em_cmp.c                                 |   5 +-
 net/sched/em_nbyte.c                               |   2 +
 net/sched/em_text.c                                |  11 +-
 net/xdp/xsk.c                                      | 143 +++++++++++++--------
 49 files changed, 700 insertions(+), 353 deletions(-)


