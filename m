Return-Path: <netdev+bounces-201520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8CAE9B92
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC8716A9C8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85325A327;
	Thu, 26 Jun 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8Xl2KU+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C84258CDF
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934006; cv=none; b=lcdl7f0JH2WMkqZf8BgbRzAS8QrtQAhxyHRI9Y1tTvanB3l3JSKgEnw2+quJORn+0lTTLdQX+wNQqcLewQgqsWNFl3dukTcXV2tMGh9z9UX9jYlra+BE6wta3hBJQMZTOVucZ6iZmL7Vbjg0olTybmN1pLG+991LSDYaJLAZQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934006; c=relaxed/simple;
	bh=xKtsGgpfYQFfhIZi3MjRFhPG5N7rtYzmk6pZhFtUwI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQnyYJymZS84OSo/QuiEfB6td5nP6fd0qxYJ8/xQ0A1G3cvkxAdK2VP4Ce7sQgfyU8gIOrwWIO28aPWZVcdDAmm6Q6BlfrQCNjDrCwXZNxdCkJ7bwtqQldALBxd5O3PYFt9jV+rescvzBTTI0/h7ikc6s4HCigxn/d+aZtqnRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8Xl2KU+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750934003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O6gBQsT5UkWJkcWaEI3s9eNYubAhl1ADsukjZ0FPhXo=;
	b=J8Xl2KU+30PMsUBUpe4/hpFTofKcgSETbE3/fWot2zFHZeY3aLJjS3V/3S+vXKDyoBvkCt
	WvkmS8Lh3CRGXGyHgxZyqUxCQMInQOKX8xTw8cuu0z2NTgNyjYhV17psDn6RHkEedN1sOS
	ckObrVaC2jMw0LKfvsFdPhRtrTRKo4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-diXXN65iOZOQHYz15U4psQ-1; Thu,
 26 Jun 2025 06:33:20 -0400
X-MC-Unique: diXXN65iOZOQHYz15U4psQ-1
X-Mimecast-MFC-AGG-ID: diXXN65iOZOQHYz15U4psQ_1750933999
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 256F2195F175;
	Thu, 26 Jun 2025 10:33:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.225])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B24FE196BAD8;
	Thu, 26 Jun 2025 10:33:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.16-rc4
Date: Thu, 26 Jun 2025 12:33:02 +0200
Message-ID: <20250626103302.22358-1-pabeni@redhat.com>
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

The following changes since commit 5c8013ae2e86ec36b07500ba4cacb14ab4d6f728:

  Merge tag 'net-6.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-19 10:21:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc4

for you to fetch changes up to 85720e04d9af0b77f8092b12a06661a8d459d4a0:

  net: libwx: fix the creation of page_pool (2025-06-26 11:02:23 +0200)

----------------------------------------------------------------
Including fixes from bluetooth and wireless.

Current release - regressions:

  - bridge: fix use-after-free during router port configuration

Current release - new code bugs:

  - eth: wangxun: fix the creation of page_pool

Previous releases - regressions:

  - netpoll: initialize UDP checksum field before checksumming

  - wifi: mac80211: finish link init before RCU publish

  - bluetooth: fix use-after-free in vhci_flush()

  - eth: ionic: fix DMA mapping test

  - eth: bnxt: properly flush XDP redirect lists

Previous releases - always broken:

  - netlink: specs: enforce strict naming of properties

  - unix: don't leave consecutive consumed OOB skbs.

  - vsock: fix linux/vm_sockets.h userspace compilation errors

  - selftests: fix TCP packet checksum

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Arnd Bergmann (2):
      net: qed: reduce stack usage for TLV processing
      wifi: iwlegacy: work around excessive stack usage on clang/kasan

Breno Leitao (1):
      net: netpoll: Initialize UDP checksum field before checksumming

Eric Dumazet (1):
      atm: clip: prevent NULL deref in clip_push()

Faisal Bukhari (1):
      Fix typo in marvell octeontx2 documentation

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Ido Schimmel (1):
      bridge: mcast: Fix use-after-free during router port configuration

Jakub Kicinski (13):
      Merge tag 'wireless-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      netlink: specs: nfsd: replace underscores with dashes in names
      netlink: specs: fou: replace underscores with dashes in names
      netlink: specs: ethtool: replace underscores with dashes in names
      netlink: specs: dpll: replace underscores with dashes in names
      netlink: specs: devlink: replace underscores with dashes in names
      netlink: specs: ovs_flow: replace underscores with dashes in names
      netlink: specs: mptcp: replace underscores with dashes in names
      netlink: specs: rt-link: replace underscores with dashes in names
      netlink: specs: tc: replace underscores with dashes in names
      netlink: specs: enforce strict naming of properties
      Merge branch 'netlink-specs-enforce-strict-naming-of-properties'
      net: selftests: fix TCP packet checksum

Jiawen Wu (1):
      net: libwx: fix the creation of page_pool

Johannes Berg (2):
      wifi: mac80211: finish link init before RCU publish
      Merge tag 'iwlwifi-fixes-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Kiran K (1):
      Bluetooth: btintel_pcie: Fix potential race condition in firmware download

Kuniyuki Iwashima (6):
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      af_unix: Don't leave consecutive consumed OOB skbs.
      af_unix: Add test for consecutive consumed OOB.
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      selftest: af_unix: Add tests for -ECONNRESET.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Long Li (1):
      net: mana: Record doorbell physical address in PF mode

Miri Korenblit (1):
      wifi: iwlwifi: mvm: assume '1' as the default mac_config_cmd version

Paolo Abeni (2):
      Merge branch 'af_unix-fix-two-oob-issues'
      Merge tag 'for-net-2025-06-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Shannon Nelson (1):
      CREDITS: Add entry for Shannon Nelson

Shuai Zhang (1):
      driver: bluetooth: hci_qca:fix unable to load the BT driver

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Thomas Fourier (2):
      ethernet: ionic: Fix DMA mapping tests
      atm: idt77252: Add missing `dma_map_error()`

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yan Zhai (1):
      bnxt: properly flush XDP redirect lists

 CREDITS                                            |   5 +
 Documentation/netlink/genetlink-legacy.yaml        |  15 ++-
 Documentation/netlink/genetlink.yaml               |  17 ++-
 Documentation/netlink/netlink-raw.yaml             |  18 ++-
 Documentation/netlink/specs/devlink.yaml           |   8 +-
 Documentation/netlink/specs/dpll.yaml              |   2 +-
 Documentation/netlink/specs/ethtool.yaml           |   6 +-
 Documentation/netlink/specs/fou.yaml               |  36 +++---
 Documentation/netlink/specs/mptcp_pm.yaml          |   8 +-
 Documentation/netlink/specs/nfsd.yaml              |   4 +-
 Documentation/netlink/specs/ovs_flow.yaml          |   6 +-
 Documentation/netlink/specs/rt-link.yaml           |   4 +-
 Documentation/netlink/specs/tc.yaml                |   4 +-
 .../device_drivers/ethernet/marvell/octeontx2.rst  |   2 +-
 drivers/atm/idt77252.c                             |   5 +
 drivers/bluetooth/btintel_pcie.c                   |  33 ++++-
 drivers/bluetooth/hci_qca.c                        |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   3 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c      |   8 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   4 +-
 include/net/bluetooth/hci_core.h                   |   2 +
 include/uapi/linux/mptcp_pm.h                      |   6 +-
 include/uapi/linux/vm_sockets.h                    |   4 +
 net/atm/clip.c                                     |  11 +-
 net/atm/resources.c                                |   3 +-
 net/bluetooth/hci_core.c                           |  34 ++++-
 net/bluetooth/l2cap_core.c                         |   9 +-
 net/bridge/br_multicast.c                          |   9 ++
 net/core/netpoll.c                                 |   2 +-
 net/core/selftests.c                               |   5 +-
 net/mac80211/link.c                                |   6 +-
 net/mac80211/util.c                                |   2 +-
 net/unix/af_unix.c                                 |  31 +++--
 .../selftests/drivers/net/hw/rss_input_xfrm.py     |   2 +-
 tools/testing/selftests/net/af_unix/msg_oob.c      | 142 ++++++++++++++++++++-
 41 files changed, 378 insertions(+), 116 deletions(-)


