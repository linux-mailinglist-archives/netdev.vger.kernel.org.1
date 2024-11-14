Return-Path: <netdev+bounces-144906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591679C8B76
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE9D1F2648F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B71FAEFF;
	Thu, 14 Nov 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/ReJGlc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176361FAEE3
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589756; cv=none; b=eyg8w16hwtLkhcjWi/ZVPtOYJ/7NDXcuGH/hDhoOPEoiDRS6RA8pfn1WzQluC8FdTsiXt4Igy7t9DLw57v+VsBaq8QMAqhxgF+4og3tKvuHVprUrFe9Cono7pa2XbW3VRE69FvouEblWBQWuSH9ZJMPbVZlOEIfawO3mLl/zyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589756; c=relaxed/simple;
	bh=aZYjXmoZfp2HAOnzz7bgqnX8Ynj7sG9uIkMetOKcoB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8WrL51q329Fy+BiVpu4jLglOMh+BndzYn36vlbzh9RtUbAhwnzoafrBTj7CLRRlABn6frVT0ngUEsLvHvZoichlCE1N8y+E/whGwaB4z7D2egw6Py3HFoH0dTvp0FyKWIhEjwp8wkNnFGlsDILn0lKL89/N9WlBZxXUHTD3TIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/ReJGlc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731589753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RnN6qfrNHf3p41oLspRaSVbFnU2zYVZg7YbyYzfMlzM=;
	b=g/ReJGlcAUwfTh7BMvCyBKSCYaa0gGTbCvCpMsy7zNPLIhH50DHFk2LgPEdXDw4iRKBwQd
	oTyniAX+sepxomvRrQDl4HRUT+g5lVcJHjhNT9rc+42m2HHEUuP24lCImyPUxAZigUJBP3
	aSNEKx2nxd0je7FtnDS8T2WUl1gWgaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-HuKPNk6mOCKjuQwBOvFkJA-1; Thu,
 14 Nov 2024 08:09:10 -0500
X-MC-Unique: HuKPNk6mOCKjuQwBOvFkJA-1
X-Mimecast-MFC-AGG-ID: HuKPNk6mOCKjuQwBOvFkJA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F15351945112;
	Thu, 14 Nov 2024 13:09:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2061D1955F3C;
	Thu, 14 Nov 2024 13:09:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc8
Date: Thu, 14 Nov 2024 14:08:46 +0100
Message-ID: <20241114130846.94852-1-pabeni@redhat.com>
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

The following changes since commit bfc64d9b7e8cac82be6b8629865e137d962578f8:

  Merge tag 'net-6.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-11-07 11:07:57 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc8

for you to fetch changes up to ca34aceb322bfcd6ab498884f1805ee12f983259:

  net: sched: u32: Add test case for systematic hnode IDR leaks (2024-11-14 11:39:17 +0100)

----------------------------------------------------------------
Including fixes from bluetooth.

Quite calm week. No new regression under investigation.

Current release - regressions:

  - eth: revert "igb: Disable threaded IRQ for igb_msix_other"

Current release - new code bugs:

  - bluetooth: btintel: direct exception event to bluetooth stack

Previous releases - regressions:

  - core: fix data-races around sk->sk_forward_alloc

  - netlink: terminate outstanding dump on socket close

  - mptcp: error out earlier on disconnect

  - vsock: fix accept_queue memory leak

  - phylink: ensure PHY momentary link-fails are handled

  - eth: mlx5:
    - fix null-ptr-deref in add rule err flow
    - lock FTE when checking if active

  - eth: dwmac-mediatek: fix inverted handling of mediatek,mac-wol

Previous releases - always broken:

  - sched: fix u32's systematic failure to free IDR entries for hnodes.

  - sctp: fix possible UAF in sctp_v6_available()

  - eth: bonding: add ns target multicast address to slave device

  - eth: mlx5: fix msix vectors to respect platform limit

  - eth: icssg-prueth: fix 1 PPS sync

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandre Ferrieux (2):
      net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.
      net: sched: u32: Add test case for systematic hnode IDR leaks

Breno Leitao (1):
      ipmr: Fix access to mfc_cache_list without lock held

Carolina Jubran (1):
      net/mlx5e: Disable loopback self-test on multi-PF netdev

Chiara Meiohas (1):
      net/mlx5: E-switch, unload IB representors when unloading ETH representors

Dragos Tatulea (1):
      net/mlx5e: kTLS, Fix incorrect page refcounting

Eric Dumazet (1):
      sctp: fix possible UAF in sctp_v6_available()

Geert Uytterhoeven (1):
      MAINTAINERS: Re-add cancelled Renesas driver sections

Geliang Tang (2):
      mptcp: update local address flags when setting it
      mptcp: hold pm lock when deleting entry

Hangbin Liu (2):
      bonding: add ns target multicast address to slave device
      selftests: bonding: add ns multicast group testing

Jakub Kicinski (7):
      netlink: terminate outstanding dump on socket close
      selftests: net: add a test for closing a netlink socket ith dump in progress
      selftests: net: add netlink-dumps to .gitignore
      Merge branch 'mptcp-fix-a-couple-of-races'
      Merge branch 'mlx5-misc-fixes-2024-11-07'
      Merge tag 'for-net-2024-11-12' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'mptcp-pm-a-few-more-fixes'

Kiran K (1):
      Bluetooth: btintel: Direct exception event to bluetooth stack

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix calling mgmt_device_connected

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix 1 PPS sync

Michal Luczaj (4):
      virtio/vsock: Fix accept_queue memory leak
      vsock: Fix sk_error_queue memory leak
      virtio/vsock: Improve MSG_ZEROCOPY error handling
      net: Make copy_safe_from_sockptr() match documentation

Mina Almasry (2):
      net: fix SO_DEVMEM_DONTNEED looping too long
      net: clarify SO_DEVMEM_DONTNEED behavior in documentation

Moshe Shemesh (1):
      net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Nícolas F. R. A. Prado (1):
      net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wol

Paolo Abeni (4):
      mptcp: error out earlier on disconnect
      mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
      Merge branch 'virtio-vsock-fix-memory-leaks'
      Merge branch 'bonding-fix-ns-targets-not-work-on-hardware-nic'

Parav Pandit (1):
      net/mlx5: Fix msix vectors to respect platform limit

Russell King (Oracle) (1):
      net: phylink: ensure PHY momentary link-fails are handled

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix tx_bytes calculation

Vitalii Mordan (1):
      stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines

Wander Lairson Costa (1):
      Revert "igb: Disable threaded IRQ for igb_msix_other"

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Wei Fang (1):
      samples: pktgen: correct dev to DEV

William Tu (1):
      net/mlx5e: clear xdp features on non-uplink representors

 Documentation/networking/devmem.rst                |   9 ++
 MAINTAINERS                                        |  30 ++++++
 drivers/bluetooth/btintel.c                        |   5 +-
 drivers/net/bonding/bond_main.c                    |  16 ++-
 drivers/net/bonding/bond_options.c                 |  82 ++++++++++++++-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |   4 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  15 ++-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  32 +++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |  25 +++--
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  13 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |  12 +++
 drivers/net/ethernet/vertexcom/mse102x.c           |   4 +-
 drivers/net/phy/phylink.c                          |  14 +--
 include/linux/sockptr.h                            |   4 +-
 include/net/bond_options.h                         |   2 +
 net/bluetooth/hci_core.c                           |   2 -
 net/core/sock.c                                    |  42 ++++----
 net/dccp/ipv6.c                                    |   2 +-
 net/ipv4/ipmr_base.c                               |   3 +-
 net/ipv6/tcp_ipv6.c                                |   4 +-
 net/mptcp/pm_netlink.c                             |   3 +-
 net/mptcp/pm_userspace.c                           |  15 +++
 net/mptcp/protocol.c                               |  16 ++-
 net/netlink/af_netlink.c                           |  31 ++----
 net/netlink/af_netlink.h                           |   2 -
 net/sched/cls_u32.c                                |  18 +++-
 net/sctp/ipv6.c                                    |  19 ++--
 net/vmw_vsock/af_vsock.c                           |   3 +
 net/vmw_vsock/virtio_transport_common.c            |   9 ++
 samples/pktgen/pktgen_sample01_simple.sh           |   2 +-
 .../selftests/drivers/net/bonding/bond_options.sh  |  54 +++++++++-
 tools/testing/selftests/net/.gitignore             |   1 +
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/netlink-dumps.c        | 110 +++++++++++++++++++++
 .../selftests/tc-testing/tc-tests/filters/u32.json |  24 +++++
 41 files changed, 543 insertions(+), 109 deletions(-)
 create mode 100644 tools/testing/selftests/net/netlink-dumps.c


