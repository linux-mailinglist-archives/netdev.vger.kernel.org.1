Return-Path: <netdev+bounces-209549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEA1B0FD3A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91635435A8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23D22D786;
	Wed, 23 Jul 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkArfUW7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72898A95C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312762; cv=none; b=KExcfYwVWka1yUY2dEkjmooZGwIUDhRTd3FtTxNdH6v1w05om2NLxv0s0d58OgZQANASZ+QPvQnaqVIc0tQu2eCaUIBWE75gnW8WZ+sPEoW4peSLeZA57lE4i4ju2nZbIVPKWBGegvWssMb4LuYJnW5fYqE8TpcpBUlpjlgHVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312762; c=relaxed/simple;
	bh=xMRkc3hMEooERsYGMs3Q39oDE/IWErsDq+4OWl6ggGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4txtZsKf7cp+2Q25NPSF98yPOS63dcSnT505/LokOzrPo2fFDXLHIhmbc/Qqu4p1acIbY76LCj4HInAo0oy/p3b+hKYrDPeiNSZ5tgCG2EFFrNwXorZfOoJfC6bw+EyOJLPxEfNZp+Fb9l7JFgdhHO3YoS/6ztPIXfIvLQAt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkArfUW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65FFC4CEE7;
	Wed, 23 Jul 2025 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312761;
	bh=xMRkc3hMEooERsYGMs3Q39oDE/IWErsDq+4OWl6ggGc=;
	h=From:To:Cc:Subject:Date:From;
	b=qkArfUW7XalkEj7xkXsUraWJzbER2zC4yd1lBYWdMy9TolT1OL/sKjTb6EDyrL/+b
	 91JrqBbKrj5vANMC20WJ97aJVTixJ7iaVkZSLNkUFOtDQUYgT0i4JsmvYEKtyrYSh4
	 v/1WC4WsKNygCstq4cY0a8ZPojNZ7M9512SeURhUxnI/t8pZ0g+XWykesVEsiBW+UU
	 dXt6EGrtB/2q/yxwdNOTAOIH0Io5APyKWHJYjAem1pvrs+UMny2cRh4zQGjuoCUl0h
	 xPHSin04PwYZZbm6380pWffZ9g3tBrpQuZg8mN9kbExMXWengasKm12Um8Cv43yZud
	 yO4ckshxr5wVg==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH 0/6 net-next] net: Introduce struct sockaddr_unspec
Date: Wed, 23 Jul 2025 16:19:07 -0700
Message-Id: <20250723230354.work.571-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7563; i=kees@kernel.org; h=from:subject:message-id; bh=xMRkc3hMEooERsYGMs3Q39oDE/IWErsDq+4OWl6ggGc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNue9yFWf8eNRg27j+ztO0y9ticn9I5R0SSt1/kfugl JzyxUu1HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABO53sjIsKPT0yJYcsLXZaHz JZnN7yeGdHF5J6ZptB/zD9g/J6+2jeGfuodrqbb01YUO0fxJh/rLlq1e9polfv1FhfsRXOZ32A5 zAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

The historically fixed-size struct sockaddr is part of UAPI and embedded
in many existing structures. The kernel uses struct sockaddr extensively
within the kernel to represent arbitrarily sized sockaddr structures,
which caused problems with the compiler's ability to determine object
sizes correctly. The "temporary" solution was to make sockaddr explicitly
use a flexible array, but this causes problems for embedding struct
sockaddr in structures, where once again the compiler has to guess about
the size of such objects.

Switching to sockaddr_storage internally everywhere wastes a lot of memory,
so we are left with needing two changes:
- introduction of an explicitly arbitrarily sized sockaddr struct
- switch struct sockaddr back to being fixed size

Doing the latter step requires all "arbitrarily sized" uses of struct
sockaddr to be replaced with the new struct from the first step.

So, introduce the new struct and start the conversions.

Thanks!

-Kees


Kees Cook (6):
  net: uapi: Add __kernel_sockaddr_unspec for sockaddr of unknown length
  net/l2tp: Add missing sa_family validation in
    pppol2tp_sockaddr_get_info
  net: Convert proto_ops bind() callbacks to use sockaddr_unspec
  net: Convert proto_ops connect() callbacks to use sockaddr_unspec
  net: Remove struct sockaddr from net.h
  net: Convert proto callbacks from sockaddr to sockaddr_unspec

 include/linux/bpf-cgroup.h                |  6 +++---
 include/linux/net.h                       | 11 ++++++-----
 include/net/inet_common.h                 | 13 ++++++-------
 include/net/ip.h                          |  4 ++--
 include/net/ipv6.h                        | 10 +++++-----
 include/net/ipv6_stubs.h                  |  2 +-
 include/net/ping.h                        |  2 +-
 include/net/sctp/sctp.h                   |  2 +-
 include/net/sock.h                        | 14 +++++++-------
 include/net/tcp.h                         |  2 +-
 include/net/udp.h                         |  2 +-
 include/net/vsock_addr.h                  |  2 +-
 include/uapi/linux/socket.h               | 15 +++++++++++++++
 net/rds/rds.h                             |  2 +-
 net/smc/smc.h                             |  4 ++--
 crypto/af_alg.c                           |  2 +-
 drivers/block/drbd/drbd_receiver.c        |  6 +++---
 drivers/infiniband/hw/erdma/erdma_cm.c    |  6 +++---
 drivers/infiniband/sw/siw/siw_cm.c        |  8 ++++----
 drivers/isdn/mISDN/l1oip_core.c           |  2 +-
 drivers/isdn/mISDN/socket.c               |  4 ++--
 drivers/net/ppp/pppoe.c                   |  2 +-
 drivers/net/ppp/pptp.c                    |  4 ++--
 drivers/net/wireless/ath/ath10k/qmi.c     |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.c     |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c     |  2 +-
 drivers/nvme/host/tcp.c                   |  4 ++--
 drivers/nvme/target/tcp.c                 |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c           |  2 +-
 drivers/target/iscsi/iscsi_target_login.c |  2 +-
 drivers/xen/pvcalls-back.c                |  4 ++--
 fs/afs/rxrpc.c                            |  6 +++---
 fs/coredump.c                             |  2 +-
 fs/dlm/lowcomms.c                         |  8 ++++----
 fs/ocfs2/cluster/tcp.c                    |  6 +++---
 fs/smb/client/connect.c                   |  4 ++--
 fs/smb/server/transport_tcp.c             |  4 ++--
 net/9p/trans_fd.c                         |  6 +++---
 net/appletalk/ddp.c                       |  4 ++--
 net/atm/pvc.c                             |  4 ++--
 net/atm/svc.c                             |  4 ++--
 net/ax25/af_ax25.c                        |  4 ++--
 net/bluetooth/hci_sock.c                  |  2 +-
 net/bluetooth/iso.c                       |  6 +++---
 net/bluetooth/l2cap_sock.c                |  4 ++--
 net/bluetooth/rfcomm/core.c               |  6 +++---
 net/bluetooth/rfcomm/sock.c               |  4 ++--
 net/bluetooth/sco.c                       |  4 ++--
 net/caif/caif_socket.c                    |  2 +-
 net/can/bcm.c                             |  2 +-
 net/can/isotp.c                           |  2 +-
 net/can/j1939/socket.c                    |  4 ++--
 net/can/raw.c                             |  2 +-
 net/ceph/messenger.c                      |  2 +-
 net/core/filter.c                         |  4 ++--
 net/core/sock.c                           |  6 +++---
 net/ieee802154/socket.c                   | 12 ++++++------
 net/ipv4/af_inet.c                        | 12 ++++++------
 net/ipv4/datagram.c                       |  4 ++--
 net/ipv4/ping.c                           |  8 ++++----
 net/ipv4/raw.c                            |  3 ++-
 net/ipv4/tcp.c                            |  2 +-
 net/ipv4/tcp_ipv4.c                       |  4 ++--
 net/ipv4/udp.c                            |  6 ++++--
 net/ipv4/udp_tunnel_core.c                |  4 ++--
 net/ipv6/af_inet6.c                       |  6 +++---
 net/ipv6/datagram.c                       |  8 ++++----
 net/ipv6/ip6_udp_tunnel.c                 |  4 ++--
 net/ipv6/ping.c                           |  2 +-
 net/ipv6/raw.c                            |  3 ++-
 net/ipv6/tcp_ipv6.c                       |  6 +++---
 net/ipv6/udp.c                            |  5 +++--
 net/l2tp/l2tp_core.c                      |  8 ++++----
 net/l2tp/l2tp_ip.c                        |  6 ++++--
 net/l2tp/l2tp_ip6.c                       |  5 +++--
 net/l2tp/l2tp_ppp.c                       |  9 ++++++++-
 net/llc/af_llc.c                          |  4 ++--
 net/mctp/af_mctp.c                        |  2 +-
 net/mctp/test/route-test.c                |  2 +-
 net/mptcp/pm_kernel.c                     |  4 ++--
 net/mptcp/protocol.c                      |  5 +++--
 net/mptcp/subflow.c                       |  4 ++--
 net/netfilter/ipvs/ip_vs_sync.c           |  6 +++---
 net/netlink/af_netlink.c                  |  4 ++--
 net/netrom/af_netrom.c                    |  4 ++--
 net/nfc/llcp_sock.c                       |  6 +++---
 net/nfc/rawsock.c                         |  2 +-
 net/packet/af_packet.c                    |  4 ++--
 net/phonet/pep.c                          |  3 ++-
 net/phonet/socket.c                       |  6 +++---
 net/qrtr/af_qrtr.c                        |  4 ++--
 net/qrtr/ns.c                             |  2 +-
 net/rds/af_rds.c                          |  2 +-
 net/rds/bind.c                            |  2 +-
 net/rds/tcp_connect.c                     |  4 ++--
 net/rds/tcp_listen.c                      |  2 +-
 net/rose/af_rose.c                        |  4 ++--
 net/rxrpc/af_rxrpc.c                      |  4 ++--
 net/rxrpc/rxperf.c                        |  2 +-
 net/sctp/socket.c                         | 13 +++++++------
 net/smc/af_smc.c                          |  6 +++---
 net/socket.c                              | 12 ++++++------
 net/sunrpc/clnt.c                         |  6 +++---
 net/sunrpc/svcsock.c                      |  2 +-
 net/sunrpc/xprtsock.c                     |  6 +++---
 net/tipc/socket.c                         |  6 +++---
 net/unix/af_unix.c                        | 12 ++++++------
 net/vmw_vsock/af_vsock.c                  |  6 +++---
 net/vmw_vsock/vsock_addr.c                |  2 +-
 net/x25/af_x25.c                          |  4 ++--
 net/xdp/xsk.c                             |  2 +-
 111 files changed, 278 insertions(+), 245 deletions(-)

-- 
2.34.1


