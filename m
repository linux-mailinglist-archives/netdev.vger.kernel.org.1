Return-Path: <netdev+bounces-138641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF8B9AE717
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9468D1C22099
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD71E2847;
	Thu, 24 Oct 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1sA9BWD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F61E0487
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778506; cv=none; b=P5C+kzGAF0LPnO4uDo6WtPIdlYc/2oE/btwwcIBX+W3M6EprvD1JvphGIJ/zq5PehuZAWnQtCxI0+5LTZfyVtlfB9STL3Kok/NX5U6h4g1xdZdGTQY5OzYHjdg0N6HBW9wJvr+CRaFkS2zvKYGvCEnGAP+Yc6wQrQrcUyICyLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778506; c=relaxed/simple;
	bh=8ImcHalUgCL8587f2BXE02nMbQZdkuw2xShqJzdTrj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M8W6bCumlXMqq062SkqLyNBENSdK+o/9G8S+jFhRHQ5yJGcLgZQaCCBD2OZwxzTKhJAXIJl4PnhEVhK2dkbTnomW+HCTyzGhDu2VkwTALZEvp5aS4rNymjg+qcv3MEP8iWMfjZkkGIGr3iJo9lPfeHVA9FrJOPrpg53yFb5ipdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1sA9BWD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=18n2odyNwU1SQdUZ77ikVnsZFIxBmlUdLXegcsCnMVQ=;
	b=X1sA9BWD1Ege4l3Mt+NDdHdmcmBxVROIgX6dDmroXyaQ2c2xUvweFQdNs28a3vKPnk2dha
	1co//e6ncf853lJVA54iQSFTjGdCB77emSoOprG4WebyUo4AvbJC1B4uyyaH5RZq2NvN0Z
	EPz044rbC889GZ3WBgpHpZdW62acM0Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-CWBWbK72NVeIl9eqsEUAog-1; Thu,
 24 Oct 2024 10:01:37 -0400
X-MC-Unique: CWBWbK72NVeIl9eqsEUAog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAD111955F41;
	Thu, 24 Oct 2024 14:01:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2191E195607C;
	Thu, 24 Oct 2024 14:01:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc5
Date: Thu, 24 Oct 2024 16:01:01 +0200
Message-ID: <20241024140101.24610-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Linus!

Oddily this includes a fix for posix clock regression; in our previous PR
we included a change there as a pre-requisite for networking one.
Such fix proved to be buggy and requires the follow-up included here.
Thomas suggested we should send it, given we sent the buggy patch.

The following changes since commit 07d6bf634bc8f93caf8920c9d61df761645336e2:

  Merge tag 'net-6.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-17 09:31:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc5

for you to fetch changes up to 9efc44fb2dba6138b0575826319200049078679a:

  Merge branch 'net-dsa-mv88e6xxx-fix-mv88e6393x-phc-frequency-on-internal-clock' (2024-10-24 12:57:48 +0200)

----------------------------------------------------------------
Including fixes from netfiler, xfrm and bluetooth.

Current release - regressions:

  - posix-clock: Fix unbalanced locking in pc_clock_settime()

  - netfilter: fix typo causing some targets not to load on IPv6

Current release - new code bugs:

  - xfrm: policy: remove last remnants of pernet inexact list

Previous releases - regressions:

  - core: fix races in netdev_tx_sent_queue()/dev_watchdog()

  - bluetooth: fix UAF on sco_sock_timeout

  - eth: hv_netvsc: fix VF namespace also in synthetic NIC NETDEV_REGISTER event

  - eth: usbnet: fix name regression

  - eth: be2net: fix potential memory leak in be_xmit()

  - eth: plip: fix transmit path breakage

Previous releases - always broken:

  - sched: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

  - netfilter: bpf: must hold reference on net namespace

  - eth: virtio_net: fix integer overflow in stats

  - eth: bnxt_en: replace ptp_lock with irqsave variant

  - eth: octeon_ep: add SKB allocation failures handling in __octep_oq_process_rx()

Misc:

  - MAINTAINERS: add Simon as an official reviewer

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aleksandr Mishin (4):
      octeon_ep: Implement helper for iterating packets in Rx queue
      octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
      fsl/fman: Save device references taken in mac_probe()
      fsl/fman: Fix refcount handling of fman-related devices

Dmitry Antipov (2):
      net: sched: fix use-after-free in taprio_change()
      net: sched: use RCU read-side critical section in taprio_dump()

Eric Dumazet (1):
      net: fix races in netdev_tx_sent_queue()/dev_watchdog()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Florian Westphal (2):
      xfrm: policy: remove last remnants of pernet inexact list
      netfilter: bpf: must hold reference on net namespace

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hangbin Liu (1):
      MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Jakub Kicinski (1):
      MAINTAINERS: add Simon as an official reviewer

Jesper Dangaard Brouer (1):
      mailmap: update entry for Jesper Dangaard Brouer

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Kory Maincent (1):
      net: pse-pd: Fix out of bound for loop

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Disable works on hci_unregister_dev
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

Michael S. Tsirkin (1):
      virtio_net: fix integer overflow in stats

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Oliver Neukum (1):
      net: usb: usbnet: fix name regression

Pablo Neira Ayuso (1):
      netfilter: xtables: fix typo causing some targets not to load on IPv6

Paolo Abeni (5):
      Merge branch 'fsl-fman-fix-refcount-handling-of-fman-related-devices'
      Merge tag 'nf-24-10-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'ipsec-2024-10-22' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'for-net-2024-10-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'net-dsa-mv88e6xxx-fix-mv88e6393x-phc-frequency-on-internal-clock'

Peter Rashleigh (1):
      net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Sabrina Dubroca (1):
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Shenghao Yang (3):
      net: dsa: mv88e6xxx: group cycle counter coefficients
      net: dsa: mv88e6xxx: read cycle counter period from hardware
      net: dsa: mv88e6xxx: support 4000ps cycle counter period

Tim Harvey (1):
      net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x

Vadim Fedorenko (1):
      bnxt_en: replace ptp_lock with irqsave variant

Vladimir Oltean (1):
      net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

Wang Hai (2):
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Yuan Can (1):
      mlxsw: spectrum_router: fix xa_store() error checking

 .mailmap                                           |   5 +
 MAINTAINERS                                        |   2 +
 drivers/net/dsa/microchip/ksz_common.c             |  21 ++--
 drivers/net/dsa/mv88e6xxx/chip.h                   |   6 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c                    | 108 ++++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  22 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |  70 +++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |  12 ++-
 drivers/net/ethernet/emulex/benet/be_main.c        |  10 +-
 drivers/net/ethernet/freescale/fman/mac.c          |  68 +++++++++----
 drivers/net/ethernet/freescale/fman/mac.h          |   6 +-
 drivers/net/ethernet/i825xx/sun3_82586.c           |   1 +
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |  82 +++++++++++-----
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   9 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
 drivers/net/hyperv/netvsc_drv.c                    |  30 ++++++
 drivers/net/phy/dp83822.c                          |   4 +-
 drivers/net/plip/plip.c                            |   2 +-
 drivers/net/pse-pd/pse_core.c                      |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/usbnet.c                           |   3 +-
 drivers/net/virtio_net.c                           |   2 +-
 drivers/net/wwan/wwan_core.c                       |   2 +-
 include/linux/netdevice.h                          |  12 +++
 include/net/bluetooth/bluetooth.h                  |   1 +
 include/net/netns/xfrm.h                           |   1 -
 include/net/xfrm.h                                 |  28 +++---
 kernel/time/posix-clock.c                          |   6 +-
 net/bluetooth/af_bluetooth.c                       |  22 +++++
 net/bluetooth/hci_core.c                           |  24 +++--
 net/bluetooth/hci_sync.c                           |  12 ++-
 net/bluetooth/iso.c                                |  18 ++--
 net/bluetooth/sco.c                                |  18 ++--
 net/ipv4/xfrm4_policy.c                            |  40 ++++----
 net/ipv6/xfrm6_policy.c                            |  31 +++---
 net/netfilter/nf_bpf_link.c                        |   4 +
 net/netfilter/xt_NFLOG.c                           |   2 +-
 net/netfilter/xt_TRACE.c                           |   1 +
 net/netfilter/xt_mark.c                            |   2 +-
 net/sched/act_api.c                                |  23 ++++-
 net/sched/sch_generic.c                            |   8 +-
 net/sched/sch_taprio.c                             |  21 ++--
 net/xfrm/xfrm_device.c                             |  11 ++-
 net/xfrm/xfrm_policy.c                             |  53 +++++++---
 net/xfrm/xfrm_user.c                               |  10 +-
 46 files changed, 565 insertions(+), 258 deletions(-)


