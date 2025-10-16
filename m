Return-Path: <netdev+bounces-230111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F24BE41D9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0BF454032B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E233451AE;
	Thu, 16 Oct 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIo2CC4j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB16341645
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627028; cv=none; b=ss7bQ2jsNVlGQg9unEHaLTwoIKeruAZqjPwKfLRXsC8FClr6Deqr6WvYcBIXgzLXKPHg8MVN9aw7DxP5KaD25GfEJh2iDP+8Mra6LrnfeIWDklORkVgp/VMIYZdjVGV+dhpYekCdfsOnaB7mchhjG1qMYWrOjgL4JjNBEfJ0o9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627028; c=relaxed/simple;
	bh=Zph5mz08v1SCyRZKVjXqZteqWYGqD0YZmOOcTr6iDlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QrPo2c7NLEJmbX5IsGetG9oawZE6M4BxMzhNtdiqXlNigijZlmqDr6hgZd1PueMttKVU8Go1b8ZD8C1UtSGdWix6tVhcmqVEaWMQTn02t4MGK55ZbtX3dFBHBGAcGbtUwXVXMOKeXZgOAAKCLYyzSk2GWXSj/eKhOjJAvMfV1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIo2CC4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760627026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gWBO6xXTedxKJZmHHvFfFwZos15AaeQ4x4Fu2kZ8uS8=;
	b=AIo2CC4jamSsi/aguRf2X2ysrvPnqIM979e+cSzH6pgHHR/7KSfQ9Fjw1+UR7K27HIrU3E
	hWbjFFrRbs/lY4FO2fDsy3OHYMkmZLdSn3yyMt0/SkuZNgJAycjbe/oerY+brBVnm9O6px
	Q4/36muMGr8Cxe4z9HWxQ5DwWYdpsAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-IOHRgZvAMky0crzVghRxAA-1; Thu,
 16 Oct 2025 11:03:42 -0400
X-MC-Unique: IOHRgZvAMky0crzVghRxAA-1
X-Mimecast-MFC-AGG-ID: IOHRgZvAMky0crzVghRxAA_1760627021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8F519560AD;
	Thu, 16 Oct 2025 15:03:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78A62195419F;
	Thu, 16 Oct 2025 15:03:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18-rc2
Date: Thu, 16 Oct 2025 17:03:28 +0200
Message-ID: <20251016150328.32601-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus!

The following changes since commit 18a7e218cfcdca6666e1f7356533e4c988780b57:

  Merge tag 'net-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-09 11:13:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc2

for you to fetch changes up to 6de1dec1c166c7f7324ce52ccfdf43e2fa743b19:

  udp: do not use skb_release_head_state() before skb_attempt_defer_free() (2025-10-16 16:03:07 +0200)

----------------------------------------------------------------
Including fixes from CAN

Current release - regressions:

  - udp: do not use skb_release_head_state() before skb_attempt_defer_free()

  - gro_cells: use nested-BH locking for gro_cell

  - dpll: zl3073x: increase maximum size of flash utility

Previous releases - regressions:

  - core: fix lockdep splat on device unregister

  - tcp: fix tcp_tso_should_defer() vs large RTT

  - tls:
    - don't rely on tx_work during send()
    - wait for pending async decryptions if tls_strp_msg_hold fails

  - can: j1939: add missing calls in NETDEV_UNREGISTER notification handler

  - eth: lan78xx: fix lost EEPROM write timeout in lan78xx_write_raw_eeprom

Previous releases - always broken:

  - ip6_tunnel: prevent perpetual tunnel growth

  - dpll: zl3073x: handle missing or corrupted flash configuration

  - can: m_can: fix pm_runtime and CAN state handling

  - eth:ixgbe: fix too early devlink_free() in ixgbe_remove()

  - eth: ixgbevf: fix mailbox API compatibility

  - eth: gve: Check valid ts bit on RX descriptor before hw timestamping

  - eth: idpf: cleanup remaining SKBs in PTP flows

  - eth: r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexey Simakov (1):
      tg3: prevent use of uninitialized remote_adv and local_adv variables

Bhanu Seshu Kumar Valluri (1):
      net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom

Breno Leitao (1):
      netdevsim: set the carrier when the device goes up

Celeste Liu (2):
      can: gs_usb: increase max interface to U8_MAX
      can: gs_usb: gs_make_candev(): populate net_device->dev_port

Dmitry Safonov (1):
      net/ip6_tunnel: Prevent perpetual tunnel growth

Eric Dumazet (2):
      tcp: fix tcp_tso_should_defer() vs large RTT
      udp: do not use skb_release_head_state() before skb_attempt_defer_free()

Florian Westphal (1):
      net: core: fix lockdep splat on device unregister

Harshit Mogalapalli (1):
      Octeontx2-af: Fix missing error code in cgx_probe()

I Viswanath (1):
      net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset

Ivan Vecera (2):
      dpll: zl3073x: Increase maximum size of flash utility
      dpll: zl3073x: Handle missing or corrupted flash configuration

Jakub Kicinski (4):
      selftests: drv-net: update remaining Python init files
      Merge branch 'intel-wired-lan-driver-updates-2025-10-01-idpf-ixgbe-ixgbevf'
      Merge branch 'tls-misc-bugfixes'
      Merge tag 'linux-can-fixes-for-6.18-20251014' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Jedrzej Jagielski (4):
      ixgbevf: fix getting link speed data for E610 devices
      ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
      ixgbevf: fix mailbox API compatibility by negotiating supported features
      ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

Jonas Gorski (1):
      MAINTAINERS: add myself as maintainer for b53

Justin Iurman (1):
      MAINTAINERS: new entry for IPv6 IOAM

Kamil Horák - 2N (1):
      net: phy: bcm54811: Fix GMII/MII/MII-Lite selection

Koichiro Den (1):
      ixgbe: fix too early devlink_free() in ixgbe_remove()

Linmao Li (1):
      r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H

Lorenzo Bianconi (1):
      net: airoha: Take into account out-of-order tx completions in airoha_dev_xmit()

Marc Kleine-Budde (7):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      Merge patch series "can: m_can: fix pm_runtime and CAN state handling"
      can: m_can: replace Dong Aisheng's old email address
      Merge patch series "can: add Transmitter Delay Compensation (TDC) documentation"

Marek Vasut (1):
      net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not present

Milena Olech (1):
      idpf: cleanup remaining SKBs in PTP flows

Nicolas Dichtel (1):
      doc: fix seg6_flowlabel path

Raju Rangoju (1):
      amd-xgbe: Avoid spurious link down messages during interface toggle

Rex Lu (1):
      net: mtk: wed: add dma mask limitation and GFP_DMA32 for device with more than 4GB DRAM

Sabrina Dubroca (7):
      tls: trim encrypted message to match the plaintext on short splice
      tls: wait for async encrypt in case of error during latter iterations of sendmsg
      tls: always set record_type in tls_process_cmsg
      tls: wait for pending async decryptions if tls_strp_msg_hold fails
      tls: don't rely on tx_work during send()
      selftests: net: tls: add tests for cmsg vs MSG_MORE
      selftests: tls: add test for short splice due to full skmsg

Sebastian Andrzej Siewior (1):
      net: gro_cells: Use nested-BH locking for gro_cell

Tetsuo Handa (1):
      can: j1939: add missing calls in NETDEV_UNREGISTER notification handler

Tim Hostetler (1):
      gve: Check valid ts bit on RX descriptor before hw timestamping

Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

Wang Liang (1):
      selftests: net: check jq command is supported

Yeounsu Moon (1):
      net: dlink: handle dma_map_single() failure properly

Yi Cong (1):
      r8152: add error handling in rtl8152_driver_init

Zqiang (1):
      usbnet: Fix using smp_processor_id() in preemptible code warnings

 .mailmap                                           |   1 +
 Documentation/networking/can.rst                   |  71 +++++++-
 Documentation/networking/seg6-sysctl.rst           |   3 +
 MAINTAINERS                                        |  11 ++
 drivers/dpll/zl3073x/core.c                        |  21 +++
 drivers/dpll/zl3073x/fw.c                          |   2 +-
 drivers/dpll/zl3073x/regs.h                        |   3 +
 drivers/net/can/m_can/m_can.c                      |  66 ++++----
 drivers/net/can/m_can/m_can_platform.c             |   6 +-
 drivers/net/can/usb/gs_usb.c                       |  23 ++-
 drivers/net/ethernet/airoha/airoha_eth.c           |  16 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |   5 +-
 drivers/net/ethernet/dlink/dl2k.c                  |  23 ++-
 drivers/net/ethernet/google/gve/gve.h              |   2 +
 drivers/net/ethernet/google/gve/gve_desc_dqo.h     |   3 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  18 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   3 +
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |  15 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  79 +++++++++
 drivers/net/ethernet/intel/ixgbevf/defines.h       |   1 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |  10 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   7 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  34 +++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h           |   8 +
 drivers/net/ethernet/intel/ixgbevf/vf.c            | 182 +++++++++++++++++----
 drivers/net/ethernet/intel/ixgbevf/vf.h            |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   1 +
 drivers/net/ethernet/mediatek/mtk_wed.c            |   8 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   5 +-
 drivers/net/netdevsim/netdev.c                     |   7 +
 drivers/net/phy/broadcom.c                         |  20 ++-
 drivers/net/phy/realtek/realtek_main.c             |  23 ++-
 drivers/net/usb/lan78xx.c                          |  19 ++-
 drivers/net/usb/r8152.c                            |   7 +-
 drivers/net/usb/usbnet.c                           |   2 +
 include/linux/brcmphy.h                            |   1 +
 include/net/ip_tunnels.h                           |  15 ++
 net/can/j1939/main.c                               |   2 +
 net/core/dev.c                                     |  40 ++++-
 net/core/gro_cells.c                               |  10 ++
 net/core/skbuff.c                                  |   1 +
 net/ipv4/ip_tunnel.c                               |  14 --
 net/ipv4/tcp_output.c                              |  19 ++-
 net/ipv4/udp.c                                     |   2 -
 net/ipv6/ip6_tunnel.c                              |   3 +-
 net/tls/tls_main.c                                 |   7 +-
 net/tls/tls_sw.c                                   |  31 +++-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |  40 +++--
 .../selftests/drivers/net/lib/py/__init__.py       |   4 +-
 tools/testing/selftests/net/lib/py/__init__.py     |  29 +++-
 tools/testing/selftests/net/rtnetlink.sh           |   2 +
 tools/testing/selftests/net/tls.c                  |  65 ++++++++
 tools/testing/selftests/net/vlan_bridge_binding.sh |   2 +
 57 files changed, 817 insertions(+), 182 deletions(-)


