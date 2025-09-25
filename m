Return-Path: <netdev+bounces-226362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91050B9F955
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900AD7BD588
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331A23D7C7;
	Thu, 25 Sep 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlAns0s6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BD233145
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806721; cv=none; b=PCQHWSsV3UR+PTyhyJB4iCITujnAgJY0TQ5fsjwk9MpFo9irOzhp59CD6tGCpzqkVsKhwvN66rqwkayliA/xNIP0ueEnVJ9OHiujonDcZBHmoX/K8U8OI2DCMDKb/RNk0KEgh9tSSLcTV98npG45wiIAiTd04owb7/+giSh0bNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806721; c=relaxed/simple;
	bh=jTzL17HFK1c7+mgAykOkTzCuS3EP3Lk7nHiSpVjNIQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3VLMWqjhZ0Xo4wzM5Z+ok00+NjbX+4r00zHSxb8oQvqtaWLlocI/g0XvIj5oxG6u9N/L97Z8dpscS64CQQ5hWbGJx7f3/NIv3jImz/SPgnwDQ0dcCWLGRr9jHwf5XH/VqGj/O62WTZezCkM2OU/DL56xDrGTv95tKeTIKVQhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlAns0s6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758806718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xdMIKqdFt0Lw0gtozRUBLh+0hn0Gwhguue/NQ9kDJlg=;
	b=KlAns0s6vdsNYFoaerwqYsBDMGhys1VDnDJ/YFeW+iMRHU9FW2Uuinsvn8LJI3n6Vwy0/q
	6a8teYxTQ2X6eaQo0jX3PFhWGWllm7qXDAG/wREhpCNXZzrj1XnrPv2itipxLWF4JwpfBP
	MTRop/3zrAvzG9KpArYTunYdubmoEhQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-s6zK_NuVP4ytLGY3d55kWg-1; Thu,
 25 Sep 2025 09:25:16 -0400
X-MC-Unique: s6zK_NuVP4ytLGY3d55kWg-1
X-Mimecast-MFC-AGG-ID: s6zK_NuVP4ytLGY3d55kWg_1758806714
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E267B180034A;
	Thu, 25 Sep 2025 13:25:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBD5919560A2;
	Thu, 25 Sep 2025 13:25:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.17-rc8
Date: Thu, 25 Sep 2025 15:25:02 +0200
Message-ID: <20250925132502.65191-1-pabeni@redhat.com>
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

The following changes since commit cbf658dd09419f1ef9de11b9604e950bdd5c170b:

  Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-18 10:22:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc8

for you to fetch changes up to d9c70e93ec5988ab07ad2a92d9f9d12867f02c56:

  octeontx2-pf: Fix potential use after free in otx2_tc_add_flow() (2025-09-25 11:04:34 +0200)

----------------------------------------------------------------
Including fixes from Bluetooth, IPsec and CAN.

No known regressions at this point.

Current release - regressions:

  - xfrm: xfrm_alloc_spi shouldn't use 0 as SPI

Previous releases - regressions:

  - xfrm: fix offloading of cross-family tunnels

  - bluetooth: fix several races leading to UaFs

  - dsa: lantiq_gswip: fix FDB entries creation for the CPU port

  - eth: tun: update napi->skb after XDP process

  - eth: mlx: fix UAF in flow counter release

Previous releases - always broken:

  - core: forbid FDB status change while nexthop is in a group

  - smc: fix warning in smc_rx_splice() when calling get_page()

  - can: provide missing ndo_change_mtu(), to prevent buffer overflow.

  - eth: i40e: fix VF config validation

  - eth: broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      bnxt_en: correct offset handling for IPv6 destination address

Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Carolina Jubran (1):
      net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD

Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Dan Carpenter (1):
      octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Ido Schimmel (3):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops
      selftests: fib_nexthops: Add test cases for FDB status change

Jacob Keller (4):
      broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
      broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: document behavior of PTP_STRICT_FLAGS
      libie: fix string names for AQ error codes

Jakub Kicinski (7):
      Merge branch 'broadcom-report-the-supported-flags-for-ancillary-features'
      Merge tag 'for-net-2025-09-22' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'ipsec-2025-09-22' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'linux-can-fixes-for-6.17-20250923' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'nexthop-various-fixes'
      Merge branch 'mlx5-misc-fixes-2025-09-22'

Jason Baron (1):
      net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

Lukasz Czapnik (8):
      i40e: add validation for ring_len param
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix idx validation in config queues msg
      i40e: fix input validation logic for action_meta
      i40e: fix validation of VF state in get resources
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting

Marc Kleine-Budde (1):
      Merge patch series "can: populate ndo_change_mtu() to prevent buffer overflow"

Moshe Shemesh (1):
      net/mlx5: fs, fix UAF in flow counter release

Paolo Abeni (1):
      Merge branch 'lantiq_gswip-fixes'

Petr Malat (1):
      ethernet: rvu-af: Remove slash from the driver name

Sabrina Dubroca (2):
      xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
      xfrm: fix offloading of cross-family tunnels

Sidraya Jayagond (1):
      net/smc: fix warning in smc_rx_splice() when calling get_page()

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

Vladimir Oltean (2):
      net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
      net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port

Wang Liang (1):
      net: tun: Update napi->skb after XDP process

Yevgeny Kliteynik (1):
      net/mlx5: HWS, ignore flow level for multi-dest table

 drivers/bluetooth/Kconfig                          |   6 +
 drivers/bluetooth/hci_uart.h                       |   8 +-
 drivers/net/can/rcar/rcar_canfd.c                  |   7 +-
 drivers/net/can/spi/hi311x.c                       |  34 +--
 drivers/net/can/sun4i_can.c                        |   1 +
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   3 +-
 drivers/net/can/usb/mcba_usb.c                     |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   2 +-
 drivers/net/dsa/lantiq_gswip.c                     |  21 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   2 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  26 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 110 +++++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +-
 drivers/net/ethernet/intel/libie/adminq.c          |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  25 +-
 .../mellanox/mlx5/core/steering/hws/action.c       |   4 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |  11 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.c |   8 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |   3 +-
 drivers/net/phy/bcm-phy-ptp.c                      |   6 +-
 drivers/net/tun.c                                  |   3 +
 include/linux/mlx5/fs.h                            |   2 +
 include/net/bluetooth/hci_core.h                   |  21 ++
 include/uapi/linux/ptp_clock.h                     |   3 +
 net/bluetooth/hci_event.c                          |  30 ++-
 net/bluetooth/hci_sync.c                           |   7 +
 net/bluetooth/mgmt.c                               | 259 +++++++++++++++------
 net/bluetooth/mgmt_util.c                          |  46 ++++
 net/bluetooth/mgmt_util.h                          |   3 +
 net/core/skbuff.c                                  |   2 +-
 net/ipv4/nexthop.c                                 |   7 +
 net/smc/smc_loopback.c                             |  14 +-
 net/xfrm/xfrm_device.c                             |   2 +-
 net/xfrm/xfrm_state.c                              |   3 +
 tools/testing/selftests/net/fib_nexthops.sh        |  52 ++++-
 41 files changed, 548 insertions(+), 201 deletions(-)


