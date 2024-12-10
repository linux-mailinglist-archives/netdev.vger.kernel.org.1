Return-Path: <netdev+bounces-150538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D79EA9B7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8652218875F4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1502022D4EA;
	Tue, 10 Dec 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cZSR620X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3422CBF8
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816329; cv=none; b=KKxq3QMCFsh143ywKRt9G5plj8cjeyvx+BjmPl0cGkAh4OzVjz6+iGGJd5t9QQGEy8geOSDRNj8lGdS5RzB4NnsOO5D7lrEz3TKMhRyy9OefdsDU90qvcMIQJar44X9YAPg65v1fbi9ru7xtej+L/Vh6fEJGApLgOuNFetBEKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816329; c=relaxed/simple;
	bh=0Wtzi9lcaiPau4czf+LFfhPO3TP8+se2Xp3N/tt6QMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=suhWGkPJpWhuNfaeR5deogx5JNZd4/htPGbGD+XGlWTDCLwEDYRSHZHAwef3oViBfBeck8YYAvLWkSnhEtXAq6rSqdd2WdVZ+QK02iXs9kVk1Hp/1t//lAnY/wMaMYdM0ymWvkYp3RXIerYGY279IuvOgDGIudyGfFH5edolLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cZSR620X; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816327; x=1765352327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z8GTW16rnX1e9e5bbOInREx++eK9tNzUqUiepHG1OS0=;
  b=cZSR620Xfv1TqFEXbkFNyasm9c0rYQ6mXqkHBUf13/EbiOZI37xeAeh0
   1YVWZZjlZ4rtKVzVcX/XYwpdQl9ej9kmzUBt90Gb1Ndi7iTfPJT+9ydwZ
   yObkIsNv8oEIxNXnxB3byN+g5DgHYKnl5/eS/sSR3uuMgm8fHhWBc97jE
   E=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="391851381"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:38:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:21773]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.160:2525] with esmtp (Farcaster)
 id 9387f788-033e-4f15-9e50-0fe617e09fe6; Tue, 10 Dec 2024 07:38:41 +0000 (UTC)
X-Farcaster-Flow-ID: 9387f788-033e-4f15-9e50-0fe617e09fe6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:38:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:38:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/15] treewide: socket: Clean up sock_create() and friends.
Date: Tue, 10 Dec 2024 16:38:14 +0900
Message-ID: <20241210073829.62520-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are a bunch of weird usages of sock_create() and friends due
to poor documentation.

  1) some subsystems use __sock_create(), but all of them can be
     replaced with sock_create_kern()

  2) some subsystems use sock_create(), but most of the sockets are
     not tied to userspace processes nor exposed via file descriptors
     but are (most likely unintentionally) exposed to some BPF hooks
     (infiniband, ISDN, NVMe over TCP, iscsi, Xen PV call, ocfs2, smbd)

  3) some subsystems use sock_create_kern() and convert the sockets
     to hold netns refcnt (cifs, mptcp, rds, smc, and sunrpc)

  4) the sockets of 2) and 3) are counted in /proc/net/sockstat even
     though they are untouchable from userspace

The primary goal is to sort out such confusion and provide enough
documentation for future developers to choose an appropriate API.

Regarding 3), we introduce a new API, sock_create_net(), that holds
a netns refcnt for kernel socket to remove the socket conversion to
avoid use-after-free triggered by TCP kernel socket after commit
26abe14379f8 ("net: Modify sk_alloc to not reference count the netns
of kernel sockets.").

Finally, we rename sock_create() and sock_create_kern() to
sock_create_user() and sock_create_net_noref(), respectively.
This intentionally breaks out-of-tree drivers to give the owners
a chance to choose an appropriate API.

Throughout the series, we follow the definition below:

  userspace socket:
    * created by sock_create_user()
    * holds the reference count of the network namespace
    * directly linked to a file descriptor
      * currently all sockets created by sane sock_create() users
        are tied to userspace process and exposed via file descriptors
    * accessed via a file descriptor (and some BPF hooks except
      for BPF LSM)
    * counted in the first line of /proc/net/sockstat.

  kernel socket
    * created by sock_create_net() or sock_create_net_noref()
      * the former holds the refcnt of netns, but the latter doesn't
    * not directly exposed to userspace via a file descriptor nor BPF
      except for BPF LSM

Note that __sock_create(kern=1) skips some LSMs (SELinux, AppArmor)
but not all; BPF LSM can enforce security regardless of the argument.

I didn't CC maintainers for mechanical changes as the CC list explodes.


Changes:
  v2:
    * Patch 8
      * Fix build error for PF_IUCV
    * Patch 12
      * Collect Acked-by from MPTCP/RDS maintainers

  v1: https://lore.kernel.org/netdev/20241206075504.24153-1-kuniyu@amazon.com/


Kuniyuki Iwashima (15):
  socket: Un-export __sock_create().
  socket: Pass hold_net flag to __sock_create().
  smc: Pass kern to smc_sock_alloc().
  socket: Pass hold_net to struct net_proto_family.create().
  ppp: Pass hold_net to struct pppox_proto.create().
  nfc: Pass hold_net to struct nfc_protocol.create().
  socket: Add hold_net flag to struct proto_accept_arg.
  socket: Pass hold_net to sk_alloc().
  socket: Respect hold_net in sk_alloc().
  socket: Don't count kernel sockets in /proc/net/sockstat.
  socket: Introduce sock_create_net().
  socket: Remove kernel socket conversion.
  socket: Use sock_create_net() instead of sock_create().
  socket: Rename sock_create() to sock_create_user().
  socket: Rename sock_create_kern() to sock_create_net_noref().

 crypto/af_alg.c                               |   7 +-
 drivers/block/drbd/drbd_receiver.c            |  12 +-
 drivers/infiniband/hw/erdma/erdma_cm.c        |   6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c            |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c            |   6 +-
 drivers/isdn/mISDN/l1oip_core.c               |   3 +-
 drivers/isdn/mISDN/socket.c                   |  17 +-
 drivers/net/ppp/pppoe.c                       |   5 +-
 drivers/net/ppp/pppox.c                       |   4 +-
 drivers/net/ppp/pptp.c                        |   5 +-
 drivers/net/tap.c                             |   2 +-
 drivers/net/tun.c                             |   2 +-
 drivers/nvme/host/tcp.c                       |   5 +-
 drivers/nvme/target/tcp.c                     |   5 +-
 drivers/soc/qcom/qmi_interface.c              |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |   7 +-
 drivers/xen/pvcalls-back.c                    |   7 +-
 drivers/xen/pvcalls-front.c                   |   3 +-
 fs/afs/rxrpc.c                                |   3 +-
 fs/dlm/lowcomms.c                             |   8 +-
 fs/ocfs2/cluster/tcp.c                        |  10 +-
 fs/smb/client/connect.c                       |  13 +-
 fs/smb/server/transport_tcp.c                 |   7 +-
 include/linux/if_pppox.h                      |   3 +-
 include/linux/net.h                           |  11 +-
 include/net/bluetooth/bluetooth.h             |   3 +-
 include/net/llc_conn.h                        |   2 +-
 include/net/sctp/structs.h                    |   2 +-
 include/net/sock.h                            |   3 +-
 io_uring/net.c                                |   2 +
 net/9p/trans_fd.c                             |   8 +-
 net/appletalk/ddp.c                           |   4 +-
 net/atm/common.c                              |   5 +-
 net/atm/common.h                              |   3 +-
 net/atm/pvc.c                                 |   4 +-
 net/atm/svc.c                                 |   8 +-
 net/ax25/af_ax25.c                            |   7 +-
 net/bluetooth/af_bluetooth.c                  |   9 +-
 net/bluetooth/bnep/sock.c                     |   5 +-
 net/bluetooth/cmtp/sock.c                     |   4 +-
 net/bluetooth/hci_sock.c                      |   4 +-
 net/bluetooth/hidp/sock.c                     |   5 +-
 net/bluetooth/iso.c                           |  11 +-
 net/bluetooth/l2cap_sock.c                    |  14 +-
 net/bluetooth/rfcomm/core.c                   |   3 +-
 net/bluetooth/rfcomm/sock.c                   |  12 +-
 net/bluetooth/sco.c                           |  11 +-
 net/bpf/test_run.c                            |   2 +-
 net/caif/caif_socket.c                        |   4 +-
 net/can/af_can.c                              |   4 +-
 net/ceph/messenger.c                          |   6 +-
 net/core/sock.c                               |  26 ++--
 net/handshake/handshake-test.c                |  33 ++--
 net/ieee802154/socket.c                       |   4 +-
 net/ipv4/af_inet.c                            |   7 +-
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/af_inet6.c                           |   4 +-
 net/ipv6/ip6_udp_tunnel.c                     |   4 +-
 net/iucv/af_iucv.c                            |  13 +-
 net/kcm/kcmsock.c                             |   6 +-
 net/key/af_key.c                              |   4 +-
 net/l2tp/l2tp_core.c                          |   8 +-
 net/l2tp/l2tp_ppp.c                           |   6 +-
 net/llc/af_llc.c                              |   6 +-
 net/llc/llc_conn.c                            |  11 +-
 net/mctp/af_mctp.c                            |   4 +-
 net/mctp/test/route-test.c                    |   6 +-
 net/mptcp/pm_netlink.c                        |   4 +-
 net/mptcp/subflow.c                           |  12 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   8 +-
 net/netlink/af_netlink.c                      |  11 +-
 net/netrom/af_netrom.c                        |   7 +-
 net/nfc/af_nfc.c                              |   5 +-
 net/nfc/llcp.h                                |   3 +-
 net/nfc/llcp_core.c                           |   3 +-
 net/nfc/llcp_sock.c                           |  10 +-
 net/nfc/nfc.h                                 |   3 +-
 net/nfc/rawsock.c                             |   5 +-
 net/packet/af_packet.c                        |   4 +-
 net/phonet/af_phonet.c                        |   4 +-
 net/phonet/pep.c                              |   2 +-
 net/qrtr/af_qrtr.c                            |   4 +-
 net/qrtr/ns.c                                 |   6 +-
 net/rds/af_rds.c                              |   4 +-
 net/rds/tcp.c                                 |  14 --
 net/rds/tcp_connect.c                         |  15 +-
 net/rds/tcp_listen.c                          |  17 +-
 net/rose/af_rose.c                            |  11 +-
 net/rxrpc/af_rxrpc.c                          |   4 +-
 net/rxrpc/rxperf.c                            |   4 +-
 net/sctp/ipv6.c                               |   7 +-
 net/sctp/protocol.c                           |   7 +-
 net/sctp/socket.c                             |   6 +-
 net/smc/af_smc.c                              |  38 ++---
 net/smc/smc_inet.c                            |   2 +-
 net/socket.c                                  | 145 +++++++++++++-----
 net/sunrpc/clnt.c                             |   4 +-
 net/sunrpc/svcsock.c                          |  12 +-
 net/sunrpc/xprtsock.c                         |  16 +-
 net/tipc/socket.c                             |   8 +-
 net/tipc/topsrv.c                             |   4 +-
 net/unix/af_unix.c                            |  17 +-
 net/vmw_vsock/af_vsock.c                      |  10 +-
 net/wireless/nl80211.c                        |   4 +-
 net/x25/af_x25.c                              |  13 +-
 net/xdp/xsk.c                                 |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   4 +-
 107 files changed, 508 insertions(+), 399 deletions(-)

-- 
2.39.5 (Apple Git-154)


