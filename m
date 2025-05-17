Return-Path: <netdev+bounces-191266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB5ABA807
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84311B65B73
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7111487F4;
	Sat, 17 May 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SNdx4SHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB779CD
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453897; cv=none; b=sFJ4x5XEaRlG2rZAudrKwr62TeG4PgRuLdrRJ2J6ux51OfiBqw8hotqEpSkCtNYJnZSdPgMogoGURuakhgmzvtDHy9WPNedAD608lKk09xCDcQnhhmRs04JG1VghPlPmjHMF2Cglo+AwDxF4fQiyKs/v2TRnevegFX8E8BvWquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453897; c=relaxed/simple;
	bh=bxAlXYFpHNLtgVDCFAdkpeixPMg1pUeaRDX5pEjoEnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EBK3TqjKo8uncFoNRG0UfrJ7m4PhMT+41E32GCHCz5UO7TY8A4LyceTRPeubF4O2HlLFTvW7rVCRXwgLbaHKqlnR8Aw06hA6xQ9hUNdOUZvzzdnB/SWVjeqwkBdyrrGyTW42W+A3GLE6g+om8AhHa0WEcTQTh/pUs768WNUTlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SNdx4SHQ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747453896; x=1778989896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nUkxVH+Fqiq19Vk/X3f1/5hjhaPOKcOQ/x732CLBh8w=;
  b=SNdx4SHQCd83nvhv566mEKz7vf/t3+NKAbjJdAvBc/1/vO3M7L4VGfWI
   l3SA9mX7nFYUhDuHz9hiaQRiJssHyyyXnYYn3w+XXU7GW28YJ1FLoUEP7
   4Z1TjdLos6IAewTolK7XPhsL538oj6bvWXDAopg3+2DP1Ut58HHNtKmKP
   XizQtZtrfFZuF+ngowXSW9GCa0J11tiYfgIrvHY4b2hkF/cYsQdQjTFCZ
   FeE0r5sdNLJi1dsbjUAXCq8edq3wX7rTymhZHj+aBZxFKBOgSndrimdDi
   DnYDSAJ0IeMqhNohq9Cikx2Wjd7Ii9/pcbGQBgsqNovpF+EWAAjrVGFiH
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="298765353"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:51:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:51782]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.193:2525] with esmtp (Farcaster)
 id 86145772-a3ec-4889-8c8d-3db8f3be7206; Sat, 17 May 2025 03:51:32 +0000 (UTC)
X-Farcaster-Flow-ID: 86145772-a3ec-4889-8c8d-3db8f3be7206
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:51:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:51:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/6] socket: Make sock_create_kern() robust against misuse.
Date: Fri, 16 May 2025 20:50:21 -0700
Message-ID: <20250517035120.55560-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are a bunch of weird usages of sock_create() and friends due
to poor documentation.

  1) some subsystems use __sock_create(), but all of them can be
     replaced with sock_create_kern()

  2) some subsystems use sock_create(), but most of the sockets are
     not tied to userspace processes nor exposed via file descriptors
     but are (most likely unintentionally) exposed to some BPF hooks
     (infiniband, ISDN, iscsi, Xen PV call, ocfs2, smbd)

  3) some subsystems use sock_create_kern() and convert the sockets
     to hold netns refcnt (cifs, mptcp, nvme, rds, smc, and sunrpc)

The primary goal is to sort out such confusion and provide enough
documentation for future developers to choose an appropriate API.

Before commit 26abe14379f8 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets."), sock_create_kern() held the
netns refcnt, and each caller dropped it if unnecessary:

  sock_create_kern(&init_net, ..., &sock);
  sk_change_net(sock->sk, net);

But that implicit API change ended up causing a lot of use-after-free
outside of net/.

Patch 2 renames sock_create_kern() to __sock_create_kern() to mark it
as a special-purpose API, and Patch 3 restores the original
sock_create_kern() that holds the netns refcnt.

Technically, this is v4 of the series below [0], but since some time
has passed and now we don't touch struct net_proto_family.create() to
reduce the amount of changes, I'm restarting this as v1.

[0]: https://lore.kernel.org/netdev/20241206075504.24153-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  socket: Un-export __sock_create().
  socket: Rename sock_create_kern() to __sock_create_kern().
  socket: Restore sock_create_kern().
  socket: Remove kernel socket conversion except for net/rds/.
  socket: Replace most sock_create() calls with sock_create_kern().
  socket: Clean up kdoc for sock_create() and sock_create_lite().

 drivers/block/drbd/drbd_receiver.c            |  12 +-
 drivers/infiniband/hw/erdma/erdma_cm.c        |   6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c            |   2 +-
 drivers/infiniband/sw/siw/siw_cm.c            |   6 +-
 drivers/isdn/mISDN/l1oip_core.c               |   3 +-
 drivers/nvme/host/tcp.c                       |   5 +-
 drivers/nvme/target/tcp.c                     |   5 +-
 drivers/soc/qcom/qmi_interface.c              |   4 +-
 drivers/target/iscsi/iscsi_target_login.c     |   7 +-
 drivers/xen/pvcalls-back.c                    |   6 +-
 fs/afs/rxrpc.c                                |   2 +-
 fs/dlm/lowcomms.c                             |   8 +-
 fs/ocfs2/cluster/tcp.c                        |   8 +-
 fs/smb/client/connect.c                       |  11 +-
 fs/smb/server/transport_tcp.c                 |   7 +-
 include/linux/net.h                           |   7 +-
 net/9p/trans_fd.c                             |   9 +-
 net/bluetooth/rfcomm/core.c                   |   3 +-
 net/ceph/messenger.c                          |   6 +-
 net/handshake/handshake-test.c                |  32 ++--
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |   2 +-
 net/l2tp/l2tp_core.c                          |   8 +-
 net/mctp/test/route-test.c                    |   6 +-
 net/mptcp/pm_kernel.c                         |   4 +-
 net/mptcp/subflow.c                           |   7 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   8 +-
 net/qrtr/ns.c                                 |   6 +-
 net/rds/tcp_connect.c                         |   8 +-
 net/rds/tcp_listen.c                          |   4 +-
 net/rxrpc/rxperf.c                            |   4 +-
 net/sctp/socket.c                             |   2 +-
 net/smc/af_smc.c                              |  18 +--
 net/smc/smc_inet.c                            |   2 +-
 net/socket.c                                  | 138 ++++++++++++------
 net/sunrpc/clnt.c                             |   4 +-
 net/sunrpc/svcsock.c                          |   9 +-
 net/sunrpc/xprtsock.c                         |  12 +-
 net/tipc/topsrv.c                             |   4 +-
 net/wireless/nl80211.c                        |   4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   4 +-
 42 files changed, 221 insertions(+), 186 deletions(-)

-- 
2.49.0


