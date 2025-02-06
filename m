Return-Path: <netdev+bounces-163513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE3A2A88A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23CC18893ED
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2422E3FC;
	Thu,  6 Feb 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II48N7hC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352522DFBE
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845131; cv=none; b=XPAWQgLlRpBC28y2O9gH/oiRWfdi387vRD6EDURHwiWHhKTA28WrIkDkOFzBFGEoiL4B0dlnTiMG0Do3cOl4QNKZjmfb0r3ymS6s7G5lSHeHit+FObglyYlNLG73lb6aP5SXEOuhcZDFj4BZzaCEVxMBlSJg+mHZ14LEiGmwnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845131; c=relaxed/simple;
	bh=D6rSv5QJt8rljmi1u+LhaGbvWVdAvFOUbjBSD9nJTkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccb841ZBi4Fq2G5zRSt8zyfBfC8fz2GeeNp0lh/x970NKZ/sJT8fsgeJmVwNlzb8gimN60S2cqmx3S+1kINLcPJ843SWYXFp9/i/Jn90Z5kILy4tG40w+4Wmhznc2UL0QnbqumAK9mKwkGIdqFWBMV9QTmlkbHObw10edmN3I/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=II48N7hC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738845128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K1Qok3qY+Sgc1nq8fGNVOEuzrOY5wRE4ZSW4ewvvA58=;
	b=II48N7hCv097474MAjEq8Vm35XaFOhCwtK3aluMzhLI1QgZAo5VLaPaWh6o3Fnq2HMyrx+
	OzA+BtDOwiRAsmQ0o3vs2+DnvwgaZZGrgCe2rdCms2+K7axuGSgSMFc6hvsLS8e9cGSr3/
	l+2Mgdt/Swbjnc8sFt+5wV5PrIn7lQs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-_goKTm1ENwuqRiiM2bRrZw-1; Thu,
 06 Feb 2025 07:32:03 -0500
X-MC-Unique: _goKTm1ENwuqRiiM2bRrZw-1
X-Mimecast-MFC-AGG-ID: _goKTm1ENwuqRiiM2bRrZw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FA401955DD0;
	Thu,  6 Feb 2025 12:32:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0CE01800352;
	Thu,  6 Feb 2025 12:31:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14-rc2
Date: Thu,  6 Feb 2025 13:31:06 +0100
Message-ID: <20250206123106.37283-1-pabeni@redhat.com>
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

Interestingly the recent kmemleak improvements allowed our CI to
catch a couple of percpu leaks addressed here.
We (mostly Jakub, to be accurate) are working to increase review
coverage over the net code-base tweaking the MAINTAINER entries.

The following changes since commit c2933b2befe25309f4c5cfbea0ca80909735fd76:

  Merge tag 'net-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-30 12:24:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc2

for you to fetch changes up to 2a64c96356c87aa8af826605943e5524bf45e24d:

  Revert "net: stmmac: Specify hardware capability value when FIFO size isn't specified" (2025-02-06 11:53:54 +0100)

----------------------------------------------------------------
Current release - regressions:

  - core: harmonize tstats and dstats

  - ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels

  - eth: tun: revert fix group permission check

  - eth: stmmac: revert "specify hardware capability value when FIFO size isn't specified"

Previous releases - regressions:

  - udp: gso: do not drop small packets when PMTU reduces

  - rxrpc: fix race in call state changing vs recvmsg()

  - eth: ice: fix Rx data path for heavy 9k MTU traffic

  - eth: vmxnet3: fix tx queue race condition with XDP

Previous releases - always broken:

  - sched: pfifo_tail_enqueue: drop new packet when sch->limit == 0

  - ethtool: ntuple: fix rss + ring_cookie check

  - rxrpc: fix the rxrpc_connection attend queue handling

Misc:

  - recognize Kuniyuki Iwashima as a maintainer

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Cong Wang (2):
      netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
      selftests/tc-testing: Add a test case for qdisc_tree_reduce_backlog()

David Howells (3):
      rxrpc: Fix the rxrpc_connection attend queue handling
      rxrpc: Fix call state set to not include the SERVER_SECURING state
      rxrpc: Fix race in call state changing vs recvmsg()

Eric Dumazet (1):
      net: rose: lock the socket in rose_bind()

Florian Fainelli (1):
      net: bcmgenet: Correct overlaying of PHY and MAC Wake-on-LAN

Ido Schimmel (1):
      net: sched: Fix truncation of offloaded action statistics

Jacob Moroni (1):
      net: atlantic: fix warning during hot unplug

Jakub Kicinski (17):
      net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels
      net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      MAINTAINERS: list openvswitch docs under its entry
      MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
      MAINTAINERS: add a general entry for BSD sockets
      MAINTAINERS: add entry for UNIX sockets
      Merge branch 'maintainers-recognize-kuniyuki-iwashima-as-a-maintainer'
      ethtool: rss: fix hiding unsupported fields in dumps
      ethtool: ntuple: fix rss + ring_cookie check
      selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure
      selftests: drv-net: rss_ctx: don't fail reconfigure test if queue offset not supported
      Merge branch 'ethtool-rss-minor-fixes-for-recent-rss-changes'
      Merge branch 'net_sched-two-security-bug-fixes-and-test-cases'
      Merge branch 'rxrpc-call-state-fixes'
      MAINTAINERS: add entry for ethtool
      MAINTAINERS: add a sample ethtool section entry

Jiasheng Jiang (1):
      ice: Add check for devm_kzalloc()

Lenny Szubowicz (1):
      tg3: Disable tg3 PCIe AER on system reboot

Maciej Fijalkowski (3):
      ice: put Rx buffers after being done with current frame
      ice: gather page_count()'s of each frag right before XDP prog call
      ice: stop storing XDP verdict within ice_rx_buf

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: connect: -f: no reconnect

Paolo Abeni (1):
      net: harmonize tstats and dstats

Quang Le (2):
      pfifo_tail_enqueue: Drop new packet when sch->limit == 0
      selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when limit==0

Russell King (Oracle) (1):
      Revert "net: stmmac: Specify hardware capability value when FIFO size isn't specified"

Sankararaman Jayaraman (1):
      vmxnet3: Fix tx queue race condition with XDP

Willem de Bruijn (1):
      tun: revert fix group permission check

Yan Zhai (1):
      udp: gso: do not drop small packets when PMTU reduces

 MAINTAINERS                                        |  43 ++++++
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  16 ++-
 drivers/net/ethernet/broadcom/tg3.c                |  58 ++++++++
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          | 150 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |  43 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  35 +++--
 drivers/net/tun.c                                  |  14 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c                  |  14 +-
 include/linux/netdevice.h                          |   2 +-
 include/net/sch_generic.h                          |   2 +-
 include/trace/events/rxrpc.h                       |   1 +
 net/core/dev.c                                     |  14 ++
 net/ethtool/ioctl.c                                |   2 +-
 net/ethtool/rss.c                                  |   3 +-
 net/ipv4/udp.c                                     |   4 +-
 net/ipv6/ioam6_iptunnel.c                          |  14 +-
 net/ipv6/rpl_iptunnel.c                            |  15 ++-
 net/ipv6/seg6_iptunnel.c                           |  15 ++-
 net/ipv6/udp.c                                     |   4 +-
 net/rose/af_rose.c                                 |  24 ++--
 net/rxrpc/ar-internal.h                            |   2 +-
 net/rxrpc/call_object.c                            |   6 +-
 net/rxrpc/conn_event.c                             |  21 +--
 net/rxrpc/conn_object.c                            |   1 +
 net/rxrpc/input.c                                  |  12 +-
 net/rxrpc/sendmsg.c                                |   2 +-
 net/sched/sch_fifo.c                               |   3 +
 net/sched/sch_netem.c                              |   2 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   2 +-
 tools/testing/selftests/net/udpgso.c               |  26 ++++
 .../tc-testing/tc-tests/infra/qdiscs.json          |  34 ++++-
 .../selftests/tc-testing/tc-tests/qdiscs/fifo.json |  23 ++++
 36 files changed, 446 insertions(+), 178 deletions(-)


