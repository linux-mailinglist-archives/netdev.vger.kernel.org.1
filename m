Return-Path: <netdev+bounces-147758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857479DB996
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDC4B20E3E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E511ADFF9;
	Thu, 28 Nov 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIoBbDGl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE40192D77
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804102; cv=none; b=buzMLUSkALUT6mPrdSMW36U6kQ7x/XqvwYsY+pbBFSX04nj8NfA45zairzaPtsThE0MWL5JMmYPZm4KElfpQfC/rN21h8WGtjBTv4oRQXj+gVtJf8KTteUIs90xHPjq6miTOwXCP1WL3J9wSq/nJXhtwhmrYiB5E5KAUaEG/Nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804102; c=relaxed/simple;
	bh=R8TjSpi/afDr6JkuNWcxq4jz+9ahghAamlgXiBn1OOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnAphNkC+MrD0lper7pcd4yhjt+BlRxBjq2IuF7xOSxhGFgrCntQWPiP/vaSxvphCps9npRUsxI5QR9GUEpOM9/2yDCHcVYQIUvMyb4qd64mydNMidAksmguzve5WyzGtEDVRknB2vc/ZSNOsVI0JagSSlKcQFsl7FGxCweGwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIoBbDGl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732804100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C8y9rNhtPEDKFIvEh+1mbCwk+d6L94p51TvKBj3PoGY=;
	b=TIoBbDGlozagyYn2aGaO0UQ58Kzfxo83wglNKRX+MwEhLpjivQJoyLdWYeCO03tit1UvTc
	S3HddJocIn+nJmV5o5U1HwBtwXmlBRX+LPxLwxYpKaSGKBjERNAK76/nAmNzQgUSUBKaLP
	sgrCeOxkDPHcWuarSzbA0kYeU5wTy7I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-xoquMNu1P6COeVfIifcM-w-1; Thu,
 28 Nov 2024 09:28:16 -0500
X-MC-Unique: xoquMNu1P6COeVfIifcM-w-1
X-Mimecast-MFC-AGG-ID: xoquMNu1P6COeVfIifcM-w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D23A1955F68;
	Thu, 28 Nov 2024 14:28:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8282A300018D;
	Thu, 28 Nov 2024 14:28:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.13-rc1
Date: Thu, 28 Nov 2024 15:27:38 +0100
Message-ID: <20241128142738.132961-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus!

Very calm week, thanks to US holidays.

The following changes since commit fcc79e1714e8c2b8e216dc3149812edd37884eef:

  Merge tag 'net-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-11-21 08:28:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc1

for you to fetch changes up to 04f5cb48995d51deed0af71aaba1b8699511313f:

  Documentation: tls_offload: fix typos and grammar (2024-11-28 12:09:06 +0100)

----------------------------------------------------------------
Including fixes from bluetooth.

Current release - regressions:

  - rtnetlink: fix rtnl_dump_ifinfo() error path

  - bluetooth: remove the redundant sco_conn_put

Previous releases - regressions:

  - netlink: fix false positive warning in extack during dumps

  - sched: sch_fq: don't follow the fast path if Tx is behind now

  - ipv6: delete temporary address if mngtmpaddr is removed or unmanaged

  - tcp: fix use-after-free of nreq in reqsk_timer_handler().

  - bluetooth: fix slab-use-after-free Read in set_powered_sync

  - l2tp: fix warning in l2tp_exit_net found

  - eth: bnxt_en: fix receive ring space parameters when XDP is active

  - eth: lan78xx: fix double free issue with interrupt buffer allocation

  - eth: tg3: set coherent DMA mask bits to 31 for BCM57766 chipsets

Previous releases - always broken:

  - ipmr: fix tables suspicious RCU usage

  - iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

  - eth: octeontx2-af: fix low network performance

  - eth: stmmac: dwmac-socfpga: set RX watchdog interrupt as broken

  - eth: rtase: correct the speed for RTL907XD-V1

Misc:

  - some documentation fixup

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Choong Yong Liang (1):
      net: stmmac: set initial EEE policy configuration

David Wei (1):
      selftests: fix nested double quotes in f-string

Edward Adam Davis (1):
      Bluetooth: SCO: remove the redundant sco_conn_put

Eric Dumazet (2):
      rtnetlink: fix rtnl_dump_ifinfo() error path
      net: hsr: fix hsr_init_sk() vs network/transport headers.

Guenter Roeck (1):
      net: microchip: vcap: Add typegroup table terminators in kunit tests

Hangbin Liu (3):
      net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged
      selftests/rtnetlink.sh: add mngtempaddr test
      selftests: rds: move test.py to TEST_FILES

Hariprasad Kelam (5):
      octeontx2-af: RPM: Fix mismatch in lmac type
      octeontx2-af: RPM: Fix low network performance
      octeontx2-af: RPM: fix stale RSFEC counters
      octeontx2-af: RPM: fix stale FCFEC counters
      octeontx2-af: Quiesce traffic before NIX block reset

Heiner Kallweit (1):
      net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled

Jakub Kicinski (3):
      netlink: fix false positive warning in extack during dumps
      selftests: net: test extacks in netlink dumps
      net_sched: sch_fq: don't follow the fast path if Tx is behind now

James Chapman (1):
      net/l2tp: fix warning in l2tp_exit_net found by syzbot

Justin Lai (3):
      rtase: Refactor the rtase_check_mac_version_valid() function
      rtase: Correct the speed for RTL907XD-V1
      rtase: Corrects error handling of the rtase_check_mac_version_valid()

Kuniyuki Iwashima (1):
      tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Leo Stone (1):
      Documentation: tls_offload: fix typos and grammar

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
      Bluetooth: MGMT: Fix possible deadlocks

Maxime Chevallier (1):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken

Michael Chan (2):
      bnxt_en: Refactor bnxt_ptp_init()
      bnxt_en: Unregister PTP during PCI shutdown and suspend

Michal Luczaj (3):
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input
      net: Comment copy_from_sockptr() explaining its behaviour

Oleksij Rempel (3):
      net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Paolo Abeni (10):
      Merge branch 'correcting-switch-hardware-versions-and-reported-speeds'
      Merge branch 'ipv6-fix-temporary-address-not-removed-correctly'
      Merge branch 'octeontx2-af-misc-rpm-fixes'
      Merge branch 'bnxt_en-bug-fixes'
      Merge branch 'net-fix-some-callers-of-copy_from_sockptr'
      Merge tag 'for-net-2024-11-26' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      ipmr: add debug check for mr table cleanup
      ip6mr: fix tables suspicious RCU usage
      ipmr: fix tables suspicious RCU usage
      Merge branch 'net-fix-mcast-rcu-splats'

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Rosen Penev (1):
      net: mdio-ipq4019: add missing error check

Russell King (Oracle) (1):
      net: phy: fix phy_ethtool_set_eee() incorrectly enabling LPI

Saravanan Vajravel (1):
      bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down

Shravya KN (2):
      bnxt_en: Set backplane link modes correctly for ethtool
      bnxt_en: Fix receive ring space parameters when XDP is active

Sidraya Jayagond (1):
      s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

Somnath Kotur (1):
      bnxt_en: Fix queue start to update vnic RSS table

Vitalii Mordan (1):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines

Vyshnav Ajith (1):
      Fix spelling mistake

 Documentation/networking/cdc_mbim.rst              |   2 +-
 Documentation/networking/tls-offload.rst           |  29 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  37 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |   3 +-
 drivers/net/ethernet/broadcom/tg3.c                |   3 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |  70 ++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |   5 +
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |   7 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  87 ++++++++++----
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h    |  18 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  45 +++++--
 drivers/net/ethernet/marvell/pxa168_eth.c          |  14 +--
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  17 +--
 drivers/net/ethernet/realtek/rtase/rtase.h         |   7 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |  43 ++++---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +
 drivers/net/mdio/mdio-ipq4019.c                    |   5 +-
 drivers/net/phy/phy-c45.c                          |   2 +-
 drivers/net/phy/phy.c                              |  52 +++++----
 drivers/net/usb/lan78xx.c                          |  40 ++++---
 include/linux/phy.h                                |   2 +
 include/linux/sockptr.h                            |   2 +
 net/bluetooth/mgmt.c                               |  38 ++++--
 net/bluetooth/sco.c                                |   2 +-
 net/core/rtnetlink.c                               |  14 ++-
 net/hsr/hsr_device.c                               |   4 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/ipmr.c                                    |  56 ++++++---
 net/ipv6/addrconf.c                                |  41 +++++--
 net/ipv6/ip6mr.c                                   |  52 +++++++--
 net/iucv/af_iucv.c                                 |  26 +++--
 net/l2tp/l2tp_core.c                               |  22 +++-
 net/llc/af_llc.c                                   |   2 +-
 net/netlink/af_netlink.c                           |  21 ++--
 net/rxrpc/af_rxrpc.c                               |   7 +-
 net/sched/sch_fq.c                                 |   6 +
 .../selftests/drivers/net/hw/lib/py/linkconfig.py  |   2 +-
 tools/testing/selftests/net/Makefile               |   3 +-
 tools/testing/selftests/net/netlink-dumps.c        | 129 +++++++++++++++++++++
 tools/testing/selftests/net/rds/Makefile           |   5 +-
 tools/testing/selftests/net/rtnetlink.sh           |  95 +++++++++++++++
 46 files changed, 811 insertions(+), 226 deletions(-)


