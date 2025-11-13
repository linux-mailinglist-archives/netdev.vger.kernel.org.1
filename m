Return-Path: <netdev+bounces-238428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4CC58C7A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCCE835DD7B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D1357A23;
	Thu, 13 Nov 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU3caXdw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E103570C4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049627; cv=none; b=PbgS+fbJMRsw2+/B74VCSBFfRvNuCMUmaSjK3+fgQX6dkUokSh7OHb9+yuhX/4fCn0YUCwObPzHKN4Y906lNfBAUryczgwbnsSfEu20dTaIvSxsD1La2FbFwoujmndLlMT1/e2fQjOshDV5JChsDaElJmGSJxJu9sZH78VwNO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049627; c=relaxed/simple;
	bh=fs36cOUypsIqmEjTN9WQnd6FnP2OpxpQiVkKChc/Ea0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcC4RweZ2Ylxn+jbMGYy2yl7If18i8UaLa2m351OLAQvMI0tZGu1aIqCqx6aYF4GPF/r2/KJlkaCCFjTOPja9xTRZOG34LAQMoybC5KPwA8HJxT4X9FmP/1NOof/h1IAvwRWPi3w3AvXPIXyXYgBDRz/jdapjxu6NlqO0GTCxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU3caXdw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763049623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtuJ5WPRJ3+NyETDt+F7wACsMcYGnlc4oGOkyHDP0jc=;
	b=hU3caXdw8tX7EijmFRW8NhnFKBKxZXzEUBhTTqeHUX1oKMPUDcx4pm7OYq4apZn7cor9e+
	IFaJM3eKM3gbRPtXsKNyOgVXHyebpiDzpIzfxRXnrA/7LIMdVZ0lKak31r9vATVO/1zf+W
	7RTdZ7jiBNnhLm1jr8IqIDmUJJH0se4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-MdG0uWS1NU-OOh4dFPbTUg-1; Thu,
 13 Nov 2025 11:00:20 -0500
X-MC-Unique: MdG0uWS1NU-OOh4dFPbTUg-1
X-Mimecast-MFC-AGG-ID: MdG0uWS1NU-OOh4dFPbTUg_1763049618
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A32A1956095;
	Thu, 13 Nov 2025 16:00:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27E54300018D;
	Thu, 13 Nov 2025 16:00:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18-rc6
Date: Thu, 13 Nov 2025 17:00:09 +0100
Message-ID: <20251113160009.177530-1-pabeni@redhat.com>
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

The following changes since commit c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0:

  Merge tag 'net-6.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-06 08:52:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc6

for you to fetch changes up to 94909c53e442474a432c57c96b99d99357ac3593:

  Merge branch 'hsr-send-correct-hsrv0-supervision-frames' (2025-11-13 15:55:06 +0100)

----------------------------------------------------------------
Including fixes from Bluetooth and Wireless. No known outstanding
regressions.

Current release - regressions:

  - eth: bonding: fix mii_status when slave is down

  - eth: mlx5e: fix missing error assignment in mlx5e_xfrm_add_state()

Previous releases - regressions:

  - sched: limit try_bulk_dequeue_skb() batches

  - ipv4: route: prevent rt_bind_exception() from rebinding stale fnhe

  - af_unix: initialise scc_index in unix_add_edge()

  - netpoll: fix incorrect refcount handling causing incorrect cleanup

  - bluetooth: don't hold spin lock over sleeping functions

  - hsr: Fix supervision frame sending on HSRv0

  - sctp: prevent possible shift out-of-bounds

  - tipc: fix use-after-free in tipc_mon_reinit_self().

  - dsa: tag_brcm: do not mark link local traffic as offloaded

  - eth: virtio-net: fix incorrect flags recording in big mode

Previous releases - always broken:

  - sched: initialize struct tc_ife to fix kernel-infoleak

  - wifi:
    - mac80211: reject address change while connecting
    - iwlwifi: avoid toggling links due to wrong element use

  - bluetooth: cancel mesh send timer when hdev removed

  - strparser: fix signed/unsigned mismatch bug

  - handshake: fix memory leak in tls_handshake_accept()

Misc:

  - selftests: mptcp: fix some flaky tests

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Akiva Goldberger (1):
      mlx5: Fix default values in create CQ

Aksh Garg (2):
      net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
      net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism

Alexander Sverdlin (1):
      selftests: net: local_termination: Wait for interfaces to come up

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Carolina Jubran (1):
      net/mlx5e: Fix missing error assignment in mlx5e_xfrm_add_state()

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Cosmin Ratiu (1):
      net/mlx5e: Trim the length of the num_doorbell error

D. Wythe (1):
      net/smc: fix mismatch between CLC header and proposal

Eric Dumazet (2):
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: limit try_bulk_dequeue_skb() batches

Felix Maurer (2):
      hsr: Fix supervision frame sending on HSRv0
      hsr: Follow standard for HSRv0 supervision frames

Gal Pressman (4):
      docs: netlink: Couple of intro-specs documentation fixes
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
      net/mlx5e: Fix potentially misleading debug message

Horatiu Vultur (1):
      net: phy: micrel: lan8814 fix reset of the QSGMII interface

Ilan Peer (1):
      wifi: mac80211_hwsim: Fix possible NULL dereference

Jakub Kicinski (5):
      Merge branch 'fix-iet-verification-implementation-for-cpsw-driver'
      Merge branch 'net-netpoll-fix-memory-leak-and-add-comprehensive-selftests'
      Merge tag 'for-net-2025-11-11' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'selftests-mptcp-join-fix-some-flaky-tests'
      Merge tag 'wireless-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Johannes Berg (4):
      wifi: mac80211: reject address change while connecting
      Merge tag 'ath-current-20251110' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: iwlwifi: mvm: fix beacon template/fixed rate
      Merge tag 'iwlwifi-fixes-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Jonas Gorski (1):
      net: dsa: tag_brcm: do not mark link local traffic as offloaded

Junjie Cao (1):
      wifi: iwlwifi: fix aux ROC time event iterator usage

Kriish Sharma (1):
      ethtool: fix incorrect kernel-doc style comment in ethtool.h

Kuniyuki Iwashima (2):
      tipc: Fix use-after-free in tipc_mon_reinit_self().
      af_unix: Initialise scc_index in unix_add_edge().

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
      Bluetooth: hci_event: Fix not handling PA Sync Lost event

Matthieu Baerts (NGI0) (6):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: connect: trunc: read all recv data
      selftests: mptcp: join: properly kill background tasks

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Miri Korenblit (1):
      wifi: iwlwifi: mld: always take beacon ies in link grading

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

Nicolas Dichtel (1):
      bonding: fix mii_status when slave is down

Nicolas Escande (1):
      wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()

Paolo Abeni (3):
      Merge branch 'net-sched-initialize-struct-tc_ife-to-fix-kernel-infoleak'
      Merge branch 'mlx5e-misc-fixes-2025-11-09'
      Merge branch 'hsr-send-correct-hsrv0-supervision-frames'

Pauli Virtanen (6):
      Bluetooth: MGMT: cancel mesh send timer when hdev removed
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: L2CAP: export l2cap_chan_hold for modules
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: 6lowpan: add missing l2cap_chan_lock()

Pawel Dembicki (1):
      wifi: mwl8k: inject DSSS Parameter Set element into beacons if missing

Ranganath V N (2):
      net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

Victor Nogueira (2):
      net/sched: Abort __tc_modify_qdisc if parent is a clsact/ingress qdisc
      selftests/tc-testing: Create tests trying to add children to clsact/ingress qdiscs

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Xuan Zhuo (1):
      virtio-net: fix incorrect flags recording in big mode

Zahari Doychev (1):
      tools: ynl: call nested attribute free function for indexed arrays

Zilin Guan (1):
      net/handshake: Fix memory leak in tls_handshake_accept()

 .../userspace-api/netlink/intro-specs.rst          |   4 +-
 drivers/bluetooth/btrtl.c                          |  24 +-
 drivers/bluetooth/btusb.c                          |  13 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  11 +-
 drivers/net/bonding/bond_main.c                    |   5 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/cq.c       |  23 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  33 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   1 -
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |  15 +-
 .../mellanox/mlx5/core/steering/hws/send.c         |   7 -
 .../mellanox/mlx5/core/steering/sws/dr_send.c      |  28 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c            |  51 ++-
 drivers/net/phy/mdio_bus.c                         |   5 +-
 drivers/net/phy/micrel.c                           |  12 +-
 drivers/net/virtio_net.c                           |  16 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  12 +-
 drivers/net/wireless/marvell/mwl8k.c               |  71 +++-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  14 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   6 +-
 include/linux/ethtool.h                            |   2 +-
 include/linux/mlx5/cq.h                            |   1 +
 include/net/bluetooth/hci.h                        |   5 +
 net/bluetooth/6lowpan.c                            | 105 ++++--
 net/bluetooth/hci_conn.c                           |  33 +-
 net/bluetooth/hci_event.c                          |  56 ++--
 net/bluetooth/hci_sync.c                           |   2 +-
 net/bluetooth/l2cap_core.c                         |   1 +
 net/bluetooth/mgmt.c                               |   1 +
 net/core/netpoll.c                                 |   7 +-
 net/dsa/tag_brcm.c                                 |   6 +-
 net/handshake/tlshd.c                              |   1 +
 net/hsr/hsr_device.c                               |   5 +-
 net/hsr/hsr_forward.c                              |  22 +-
 net/ipv4/route.c                                   |   5 +
 net/mac80211/iface.c                               |  14 +-
 net/mac80211/rx.c                                  |  10 +-
 net/sched/act_connmark.c                           |  12 +-
 net/sched/act_ife.c                                |  12 +-
 net/sched/sch_api.c                                |   5 +
 net/sched/sch_generic.c                            |  17 +-
 net/sctp/transport.c                               |  13 +-
 net/smc/smc_clc.c                                  |   1 +
 net/strparser/strparser.c                          |   2 +-
 net/tipc/net.c                                     |   2 +
 net/unix/garbage.c                                 |  14 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |  12 +
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 361 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  78 ++++-
 .../selftests/drivers/net/netcons_torture.sh       | 130 ++++++++
 .../selftests/net/forwarding/local_termination.sh  |   2 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  18 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  90 ++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  21 ++
 .../tc-testing/tc-tests/infra/qdiscs.json          |  44 +++
 65 files changed, 1202 insertions(+), 312 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh
 create mode 100755 tools/testing/selftests/drivers/net/netcons_torture.sh


