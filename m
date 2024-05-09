Return-Path: <netdev+bounces-94891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584268C0F08
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D958E1F218F4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED29148303;
	Thu,  9 May 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws4GgjsY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36C12FB3F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255670; cv=none; b=X8WiJtxMcgU6YhnjCv0msLK11SemuHDfkrPLWQfsmg04WnxNGCjH3d5RXQ4PyDF3m+uGJl+Mp37LsbEDttL1mTng6HR855HaL+QTQQUwwqPnLLwai9nXbdzBzRjvfsc+S6gjRD5fY1Du+LGfRKLCqkIpccQ0vvNFub/a299NPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255670; c=relaxed/simple;
	bh=vfzbXmrl/AwHVMDZUI8PRatAwjjoI5XimVa1uLdey4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qk6Cs3b0IBB7VZ+c3SDF2QW/HGtOfXMkVZwAXDftilO8yX7MQAtzkiaU3zA+T8A/+cRR6TByipLjymtbiTcRVYwZ59aYJN4Km02W8++UKNpQvXY57HbPhcszrmtkA+wUd0sMNYeKtkRTdKxqbwYCleAxwAJWZDDA2IcV8N9hTGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws4GgjsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715255667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y3JZ5LkzbJDwZzWqwn1ukS8ZJVZyGGaxdZIhbOgoOzQ=;
	b=Ws4GgjsYINDiqHEA3uXV+QxqPZfg+EWMCzYmIxgrVtx+1rQjfyJmfk+fS4SPCO38ysZzg1
	k39lROnNKyFpF/VnRGv10QOztn+GoYISDk3KHNMt9pgYmwM2Smrmni4EPW1AefPI1bTW38
	H+2J5OsVnJgw2eJRDKlEA6L7yrMazfY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-Nd94kMKCP5WJOtrd0EZe4Q-1; Thu,
 09 May 2024 07:54:25 -0400
X-MC-Unique: Nd94kMKCP5WJOtrd0EZe4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F8601C3F0FB;
	Thu,  9 May 2024 11:54:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0670136EC;
	Thu,  9 May 2024 11:54:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9-rc8
Date: Thu,  9 May 2024 13:54:11 +0200
Message-ID: <20240509115411.30032-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Linus!

The following changes since commit 545c494465d24b10a4370545ba213c0916f70b95:

  Merge tag 'net-6.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-02 08:51:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc8

for you to fetch changes up to 6e7ffa180a532b6fe2e22aa6182e02ce988a43aa:

  net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports (2024-05-09 11:48:20 +0200)

----------------------------------------------------------------
Including fixes from bluetooth and IPsec.

The bridge patch is actually a follow-up to a recent fix in the same
area. We have a pending v6.8 AF_UNIX regression; it should be solved
soon, but not in time for this PR.

Current release - regressions:

 - eth: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

 - net: bridge: fix corrupted ethernet header on multicast-to-unicast

Current release - new code bugs:

 - xfrm: fix possible bad pointer derferencing in error path

Previous releases - regressionis:

 - core: fix out-of-bounds access in ops_init

 - ipv6:
   - fix potential uninit-value access in __ip6_make_skb()
   - fib6_rules: avoid possible NULL dereference in fib6_rule_action()

 - tcp: use refcount_inc_not_zero() in tcp_twsk_unique().

 - rtnetlink: correct nested IFLA_VF_VLAN_LIST attribute validation

 - rxrpc: fix congestion control algorithm

 - bluetooth:
   - l2cap: fix slab-use-after-free in l2cap_connect()
   - msft: fix slab-use-after-free in msft_do_close()

 - eth: hns3: fix kernel crash when devlink reload during initialization

 - eth: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family

Previous releases - always broken:

 - xfrm: preserve vlan tags for transport mode software GRO

 - tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets

 - eth: hns3: keep using user config after hardware reset

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Antony Antony (2):
      xfrm: fix possible derferencing in error path
      xfrm: Correct spelling mistake in xfrm.h comment

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

Daniel Golle (1):
      dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

David Howells (2):
      rxrpc: Fix congestion control algorithm
      rxrpc: Only transmit one ACK per jumbo packet received

Donald Hunter (1):
      netlink: specs: Add missing bridge linkinfo attrs

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (4):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
      ipv6: prevent NULL dereference in ip6_output()

Felix Fietkau (1):
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Gregor Herburger (1):
      net: phy: marvell-88q2xxx: add support for Rev B1 and B2

Gregory Detal (1):
      mptcp: only allow set existing scheduler for net.mptcp.scheduler

Ido Schimmel (1):
      selftests: test_bridge_neigh_suppress.sh: Fix failures due to duplicate MAC

Jakub Kicinski (3):
      Merge tag 'for-net-2024-05-03' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'ipsec-2024-05-02' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'rxrpc-miscellaneous-fixes'

Jian Shen (1):
      net: hns3: direct return when receive a unknown mailbox message

Johan Hovold (7):
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix firmware check error path

Kuniyuki Iwashima (1):
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Lukasz Majewski (1):
      hsr: Simplify code for announcing HSR nodes timer setup

Marek Vasut (1):
      net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

Paolo Abeni (1):
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peiyang Wang (4):
      net: hns3: using user configure after hardware reset
      net: hns3: change type of numa_node_mask as nodemask_t
      net: hns3: release PTP resources if pf initialization failed
      net: hns3: use appropriate barrier function after setting a bit value

Potnuri Bharat Teja (1):
      MAINTAINERS: update cxgb4 and cxgb3 network drivers maintainer

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Shigeru Yoshida (1):
      ipv6: Fix potential uninit-value access in __ip6_make_skb()

Steffen Bätz (2):
      net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family
      net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports

Sungwoo Kim (3):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()
      Bluetooth: HCI: Fix potential null-ptr-deref

Tetsuo Handa (1):
      nfc: nci: Fix kcov check in nci_rx_work()

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Vincent Duvert (1):
      appletalk: Improve handling of broadcast packets

Wen Gu (1):
      net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Yonglong Liu (2):
      net: hns3: fix port vlan filter not disabled issue
      net: hns3: fix kernel crash when devlink reload during initialization

 .../devicetree/bindings/net/mediatek,net.yaml      |  22 +---
 Documentation/netlink/specs/rt_link.yaml           |   6 ++
 MAINTAINERS                                        |   6 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts    |   3 +-
 drivers/bluetooth/btqca.c                          | 110 +++++++++++++++----
 drivers/bluetooth/btqca.h                          |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  39 +++++--
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  52 ++++-----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   5 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  20 ++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   2 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |  16 +--
 drivers/net/phy/marvell-88q2xxx.c                  | 119 ++++++++++++++++++---
 include/linux/skbuff.h                             |  15 +++
 include/net/xfrm.h                                 |   3 +
 include/uapi/linux/xfrm.h                          |   2 +-
 net/appletalk/ddp.c                                |  19 +++-
 net/bluetooth/hci_core.c                           |   3 +-
 net/bluetooth/hci_event.c                          |   2 +
 net/bluetooth/l2cap_core.c                         |  24 +++--
 net/bluetooth/msft.c                               |   2 +-
 net/bluetooth/msft.h                               |   4 +-
 net/bluetooth/sco.c                                |   4 +
 net/bridge/br_forward.c                            |   9 +-
 net/core/net_namespace.c                           |  13 ++-
 net/core/rtnetlink.c                               |   2 +-
 net/hsr/hsr_device.c                               |  27 +++--
 net/ipv4/tcp.c                                     |   4 +-
 net/ipv4/tcp_input.c                               |   2 +
 net/ipv4/tcp_ipv4.c                                |   8 +-
 net/ipv4/tcp_output.c                              |   4 +-
 net/ipv4/xfrm4_input.c                             |   6 +-
 net/ipv6/fib6_rules.c                              |   6 +-
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/xfrm6_input.c                             |   6 +-
 net/mptcp/ctrl.c                                   |  39 ++++++-
 net/nfc/nci/core.c                                 |   1 +
 net/phonet/pn_netlink.c                            |   2 +-
 net/rxrpc/ar-internal.h                            |   2 +-
 net/rxrpc/call_object.c                            |   7 +-
 net/rxrpc/input.c                                  |  49 ++++++---
 net/smc/smc_ib.c                                   |  19 ++--
 net/xfrm/xfrm_input.c                              |   8 ++
 net/xfrm/xfrm_policy.c                             |   2 +
 .../selftests/net/test_bridge_neigh_suppress.sh    |  14 +--
 47 files changed, 519 insertions(+), 205 deletions(-)


