Return-Path: <netdev+bounces-209554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCCB0FD3E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07EA545851
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F482737EC;
	Wed, 23 Jul 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDZQwogx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F8272E74
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312771; cv=none; b=oGUx4VHulIcvhTk9gwYP85Uy2WBWA3vbcMMxxfdBAH00+xEXrCqKocnTWpzO7E+tMGfO1gseZFb/T1ck8wWTo8McBl5b5CmYzifemxTUoI586RWrf6K2wogoG5JJzaauBF4SBVUPxdjFPFHYxADmeatSqvzpEY5bhwoW9EcUukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312771; c=relaxed/simple;
	bh=FuhhhY5ANuImzoxM3Jf7xkn9cId7bsTA9CMtNIoSvXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqa8lHqKDlLbaS7C9dtlSDt79MFOpYf35sp7CXkGOOx5TUJrOhf+/DOqmU1e35Ttg/vo26denRGSlD3X1rKifwrClGX4Nd9vgEfyONU5NkMvbosTRImC7q9wPo2zYxb1/rDUFlNDCfOarqz7g1F7RHI9kfbqhzip8Trj+qgnoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDZQwogx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F579C4CEE7;
	Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312770;
	bh=FuhhhY5ANuImzoxM3Jf7xkn9cId7bsTA9CMtNIoSvXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDZQwogxF+Ty3QES1a0SWFS9PxJZj925f2RR3P1mArw6raOv5ujunG+M6b26ICY2R
	 tjzv2nfjC2baoCueP7I/1ppHJ2f/5+zp8/MkLzNT/w0cMCpKdJKB4tA/uqXNPpDbKI
	 TP39kzdduCx+6t6A70eAtWj81QaIUKQlNzpuU1Ejmkuj/i5YDh2H9m+Y7bJz7JNdNu
	 d8vjn4qBwnlNbWqBLyXkBYDQOguLW0mYNuymjNplSv73DjBBEiYyK3jefeWTJly1tl
	 3DDIOJe8wA+B04y3MSVlf9lfmkLV32GwN1WetlZ2eMYw8Qdtsa5iZ1wHtGPRnN6gaW
	 IcKXpmOdEzaPg==
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
Subject: [PATCH 4/6 net-next] net: Convert proto_ops connect() callbacks to use sockaddr_unspec
Date: Wed, 23 Jul 2025 16:19:11 -0700
Message-Id: <20250723231921.2293685-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723230354.work.571-kees@kernel.org>
References: <20250723230354.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48877; i=kees@kernel.org; h=from:subject; bh=FuhhhY5ANuImzoxM3Jf7xkn9cId7bsTA9CMtNIoSvXg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNuR8Wu5x9HMlqtKftWsj0urwUk7aGhxGKd1bw7c0/N EPd6rlTRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET4MxgZfjRcbnzBUbffYMPa qbXcAWvv9XSELj/i8XbR2T2llzY3TWVkmPxi37YagbfH77006/d2uSS8aalHae+3L03Wr+2Mth3 g4gcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update all struct proto_ops connect() callback function prototypes from
"struct sockaddr *" to "struct sockaddr_unspec *" to avoid lying to the
compiler about object sizes. Calls into struct proto handlers gain casts
that will be removed in the struct proto conversion patch.

No binary changes expected.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/bpf-cgroup.h             |  6 +++---
 include/linux/net.h                    |  4 ++--
 include/net/inet_common.h              |  6 +++---
 include/net/sctp/sctp.h                |  2 +-
 include/net/sock.h                     |  2 +-
 include/net/vsock_addr.h               |  2 +-
 net/smc/smc.h                          |  2 +-
 drivers/block/drbd/drbd_receiver.c     |  2 +-
 drivers/infiniband/hw/erdma/erdma_cm.c |  2 +-
 drivers/infiniband/sw/siw/siw_cm.c     |  2 +-
 drivers/net/ppp/pppoe.c                |  2 +-
 drivers/net/ppp/pptp.c                 |  2 +-
 drivers/net/wireless/ath/ath10k/qmi.c  |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |  2 +-
 drivers/nvme/host/tcp.c                |  2 +-
 drivers/slimbus/qcom-ngd-ctrl.c        |  2 +-
 drivers/xen/pvcalls-back.c             |  2 +-
 fs/coredump.c                          |  2 +-
 fs/dlm/lowcomms.c                      |  2 +-
 fs/ocfs2/cluster/tcp.c                 |  2 +-
 fs/smb/client/connect.c                |  2 +-
 net/9p/trans_fd.c                      |  4 ++--
 net/appletalk/ddp.c                    |  2 +-
 net/atm/pvc.c                          |  4 ++--
 net/atm/svc.c                          |  2 +-
 net/ax25/af_ax25.c                     |  2 +-
 net/bluetooth/iso.c                    |  2 +-
 net/bluetooth/l2cap_sock.c             |  2 +-
 net/bluetooth/rfcomm/core.c            |  2 +-
 net/bluetooth/rfcomm/sock.c            |  2 +-
 net/bluetooth/sco.c                    |  2 +-
 net/caif/caif_socket.c                 |  2 +-
 net/can/bcm.c                          |  2 +-
 net/can/j1939/socket.c                 |  2 +-
 net/ceph/messenger.c                   |  2 +-
 net/core/sock.c                        |  2 +-
 net/ieee802154/socket.c                |  4 ++--
 net/ipv4/af_inet.c                     | 14 +++++++-------
 net/ipv4/tcp.c                         |  2 +-
 net/ipv4/udp_tunnel_core.c             |  2 +-
 net/ipv6/ip6_udp_tunnel.c              |  2 +-
 net/l2tp/l2tp_core.c                   |  4 ++--
 net/l2tp/l2tp_ppp.c                    |  2 +-
 net/llc/af_llc.c                       |  2 +-
 net/mptcp/subflow.c                    |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c        |  2 +-
 net/netlink/af_netlink.c               |  2 +-
 net/netrom/af_netrom.c                 |  2 +-
 net/nfc/llcp_sock.c                    |  2 +-
 net/nfc/rawsock.c                      |  2 +-
 net/phonet/socket.c                    |  4 ++--
 net/qrtr/af_qrtr.c                     |  2 +-
 net/rds/af_rds.c                       |  2 +-
 net/rds/tcp_connect.c                  |  2 +-
 net/rose/af_rose.c                     |  2 +-
 net/rxrpc/af_rxrpc.c                   |  2 +-
 net/sctp/socket.c                      |  4 ++--
 net/smc/af_smc.c                       |  4 ++--
 net/socket.c                           |  6 +++---
 net/sunrpc/clnt.c                      |  2 +-
 net/sunrpc/xprtsock.c                  |  4 ++--
 net/tipc/socket.c                      |  2 +-
 net/unix/af_unix.c                     |  8 ++++----
 net/vmw_vsock/af_vsock.c               |  6 +++---
 net/vmw_vsock/vsock_addr.c             |  2 +-
 net/x25/af_x25.c                       |  2 +-
 67 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 082ccd8ad96b..a3412b661b63 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -241,7 +241,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))					       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, NULL, NULL);  \
 	__ret;								       \
 })
@@ -251,7 +251,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, t_ctx, NULL); \
 		release_sock(sk);					       \
 	}								       \
@@ -269,7 +269,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(atype))	{				       \
 		lock_sock(sk);						       \
-		__ret = __cgroup_bpf_run_filter_sock_addr(sk, uaddr, uaddrlen, \
+		__ret = __cgroup_bpf_run_filter_sock_addr(sk, (struct sockaddr *)uaddr, uaddrlen, \
 							  atype, NULL, &__flags); \
 		release_sock(sk);					       \
 		if (__flags & BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE)	       \
diff --git a/include/linux/net.h b/include/linux/net.h
index c57cf4eaaf11..25a7c37977fd 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -168,7 +168,7 @@ struct proto_ops {
 				      struct sockaddr_unspec *myaddr,
 				      int sockaddr_len);
 	int		(*connect)   (struct socket *sock,
-				      struct sockaddr *vaddr,
+				      struct sockaddr_unspec *vaddr,
 				      int sockaddr_len, int flags);
 	int		(*socketpair)(struct socket *sock1,
 				      struct socket *sock2);
@@ -350,7 +350,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 int kernel_bind(struct socket *sock, struct sockaddr_unspec *addr, int addrlen);
 int kernel_listen(struct socket *sock, int backlog);
 int kernel_accept(struct socket *sock, struct socket **newsock, int flags);
-int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
+int kernel_connect(struct socket *sock, struct sockaddr_unspec *addr, int addrlen,
 		   int flags);
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 3ebd2aa0f052..a339a0e2e7e7 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -23,11 +23,11 @@ struct sockaddr;
 struct socket;
 
 int inet_release(struct socket *sock);
-int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_stream_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			int addr_len, int flags);
-int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int __inet_stream_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			  int addr_len, int flags, int is_sendmsg);
-int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_dgram_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		       int addr_len, int flags);
 int inet_accept(struct socket *sock, struct socket *newsock,
 		struct proto_accept_arg *arg);
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index e96d1bd087f6..228c36f52091 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -85,7 +85,7 @@ void sctp_udp_sock_stop(struct net *net);
 /*
  * sctp/socket.c
  */
-int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
+int sctp_inet_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		      int addr_len, int flags);
 int sctp_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 int sctp_inet_listen(struct socket *sock, int backlog);
diff --git a/include/net/sock.h b/include/net/sock.h
index 66f29f6be5cd..d62f995a1f61 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1890,7 +1890,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
  * does not implement a particular function.
  */
 int sock_no_bind(struct socket *, struct sockaddr_unspec *, int);
-int sock_no_connect(struct socket *, struct sockaddr *, int, int);
+int sock_no_connect(struct socket *, struct sockaddr_unspec *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, struct proto_accept_arg *);
 int sock_no_getname(struct socket *, struct sockaddr *, int);
diff --git a/include/net/vsock_addr.h b/include/net/vsock_addr.h
index cf8cc140d68d..75810bb78969 100644
--- a/include/net/vsock_addr.h
+++ b/include/net/vsock_addr.h
@@ -16,7 +16,7 @@ bool vsock_addr_bound(const struct sockaddr_vm *addr);
 void vsock_addr_unbind(struct sockaddr_vm *addr);
 bool vsock_addr_equals_addr(const struct sockaddr_vm *addr,
 			    const struct sockaddr_vm *other);
-int vsock_addr_cast(const struct sockaddr *addr, size_t len,
+int vsock_addr_cast(const struct sockaddr_unspec *addr, size_t len,
 		    struct sockaddr_vm **out_addr);
 
 #endif
diff --git a/net/smc/smc.h b/net/smc/smc.h
index cd2d8a6c52e5..4a91c562196b 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -44,7 +44,7 @@ void smc_release_cb(struct sock *sk);
 int smc_release(struct socket *sock);
 int smc_bind(struct socket *sock, struct sockaddr_unspec *uaddr,
 	     int addr_len);
-int smc_connect(struct socket *sock, struct sockaddr *addr,
+int smc_connect(struct socket *sock, struct sockaddr_unspec *addr,
 		int alen, int flags);
 int smc_accept(struct socket *sock, struct socket *new_sock,
 	       struct proto_accept_arg *arg);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 5b1af3a44882..28c414f16f86 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -646,7 +646,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	 * stay C_WF_CONNECTION, don't go Disconnecting! */
 	disconnect_on_error = 0;
 	what = "connect";
-	err = sock->ops->connect(sock, (struct sockaddr *) &peer_in6, peer_addr_len, 0);
+	err = sock->ops->connect(sock, (struct sockaddr_unspec *) &peer_in6, peer_addr_len, 0);
 
 out:
 	if (err < 0) {
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e819e9d627d1..ae20465678df 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -996,7 +996,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	ret = s->ops->bind(s, (struct sockaddr_unspec *)laddr, laddrlen);
 	if (ret)
 		return ret;
-	ret = s->ops->connect(s, raddr, raddrlen, flags);
+	ret = s->ops->connect(s, (struct sockaddr_unspec *)raddr, raddrlen, flags);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7c3883bcaccf..1a48dad39eb7 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1344,7 +1344,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	if (rv < 0)
 		return rv;
 
-	rv = s->ops->connect(s, raddr, size, flags);
+	rv = s->ops->connect(s, (struct sockaddr_unspec *)raddr, size, flags);
 
 	return rv < 0 ? rv : 0;
 }
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..69632ac90378 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -606,7 +606,7 @@ static int pppoe_release(struct socket *sock)
 	return 0;
 }
 
-static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
+static int pppoe_connect(struct socket *sock, struct sockaddr_unspec *uservaddr,
 		  int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 64068312f050..d81929fc8dfd 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -411,7 +411,7 @@ static int pptp_bind(struct socket *sock, struct sockaddr_unspec *uservaddr,
 	return error;
 }
 
-static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
+static int pptp_connect(struct socket *sock, struct sockaddr_unspec *uservaddr,
 	int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index f1f33af0170a..84e65b24e656 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -986,7 +986,7 @@ static int ath10k_qmi_new_server(struct qmi_handle *qmi_hdl,
 
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "wifi fw qmi service found\n");
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)&qmi->sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unspec *)&qmi->sq,
 			     sizeof(qmi->sq), 0);
 	if (ret) {
 		ath10k_err(ar, "failed to connect to a remote QMI service port\n");
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 378ac96b861b..418435ad7cc6 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3186,7 +3186,7 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	sq->sq_node = service->node;
 	sq->sq_port = service->port;
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unspec *)sq,
 			     sizeof(*sq), 0);
 	if (ret) {
 		ath11k_warn(ab, "failed to connect to qmi remote service: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..5c64ca1e2815 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3732,7 +3732,7 @@ static int ath12k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 	sq->sq_node = service->node;
 	sq->sq_port = service->port;
 
-	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr *)sq,
+	ret = kernel_connect(qmi_hdl->sock, (struct sockaddr_unspec *)sq,
 			     sizeof(*sq), 0);
 	if (ret) {
 		ath12k_warn(ab, "qmi failed to connect to remote service %d\n", ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 43c34573e875..d139267492c9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1864,7 +1864,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	dev_dbg(nctrl->device, "connecting queue %d\n",
 			nvme_tcp_queue_id(queue));
 
-	ret = kernel_connect(queue->sock, (struct sockaddr *)&ctrl->addr,
+	ret = kernel_connect(queue->sock, (struct sockaddr_unspec *)&ctrl->addr,
 		sizeof(ctrl->addr), 0);
 	if (ret) {
 		dev_err(nctrl->device,
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 4fb66986cc22..edc207e33337 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -463,7 +463,7 @@ static int qcom_slim_qmi_init(struct qcom_slim_ngd_ctrl *ctrl,
 	}
 
 	rc = kernel_connect(handle->sock,
-				(struct sockaddr *)&ctrl->qmi.svc_info,
+				(struct sockaddr_unspec *)&ctrl->qmi.svc_info,
 				sizeof(ctrl->qmi.svc_info), 0);
 	if (rc < 0) {
 		dev_err(ctrl->dev, "Remote Service connect failed: %d\n", rc);
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 275d9e7060f6..c19cd6e4e236 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -409,7 +409,7 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 	ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);
 	if (ret < 0)
 		goto out;
-	ret = inet_stream_connect(sock, sa, req->u.connect.len, 0);
+	ret = inet_stream_connect(sock, (struct sockaddr_unspec *)sa, req->u.connect.len, 0);
 	if (ret < 0) {
 		sock_release(sock);
 		goto out;
diff --git a/fs/coredump.c b/fs/coredump.c
index f88deb4701ac..46aab19193de 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -708,7 +708,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	 */
 	pidfs_coredump(cprm);
 
-	retval = kernel_connect(socket, (struct sockaddr *)(&addr), addr_len,
+	retval = kernel_connect(socket, (struct sockaddr_unspec *)(&addr), addr_len,
 				O_NONBLOCK | SOCK_COREDUMP);
 	if (retval) {
 		if (retval == -EAGAIN)
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 435ec6b9d194..ef749b8b7e6b 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1599,7 +1599,7 @@ static int dlm_connect(struct connection *con)
 
 	log_print_ratelimited("connecting to %d", con->nodeid);
 	make_sockaddr(&addr, dlm_config.ci_tcp_port, &addr_len);
-	result = kernel_connect(sock, (struct sockaddr *)&addr, addr_len, 0);
+	result = kernel_connect(sock, (struct sockaddr_unspec *)&addr, addr_len, 0);
 	switch (result) {
 	case -EINPROGRESS:
 		/* not an error */
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 66054520122f..485c19cdbb58 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1638,7 +1638,7 @@ static void o2net_start_connect(struct work_struct *work)
 	remoteaddr.sin_port = node->nd_ipv4_port;
 
 	ret = sc->sc_sock->ops->connect(sc->sc_sock,
-					(struct sockaddr *)&remoteaddr,
+					(struct sockaddr_unspec *)&remoteaddr,
 					sizeof(remoteaddr),
 					O_NONBLOCK);
 	if (ret == -EINPROGRESS)
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 0db181cd9c2f..96351896b7f9 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3410,7 +3410,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		 socket->sk->sk_sndbuf,
 		 socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
 
-	rc = kernel_connect(socket, saddr, slen,
+	rc = kernel_connect(socket, (struct sockaddr_unspec *)saddr, slen,
 			    server->noblockcnt ? O_NONBLOCK : 0);
 	/*
 	 * When mounting SMB root file systems, we do not want to block in
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index f6847afa9d09..2511f9d12af0 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1025,7 +1025,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	}
 
 	err = READ_ONCE(csocket->ops)->connect(csocket,
-					       (struct sockaddr *)&stor,
+					       (struct sockaddr_unspec *)&stor,
 					       sizeof(stor), 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket to %s\n",
@@ -1065,7 +1065,7 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 		return err;
 	}
-	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr *)&sun_server,
+	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr_unspec *)&sun_server,
 			sizeof(struct sockaddr_un) - 1, 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket: %s: %d\n",
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index f00e22318dfa..4d4a67654378 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1204,7 +1204,7 @@ static int atalk_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int ad
 }
 
 /* Set the address we talk to */
-static int atalk_connect(struct socket *sock, struct sockaddr *uaddr,
+static int atalk_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			 int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index c57d6ac7cede..88f53237c80a 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -56,10 +56,10 @@ static int pvc_bind(struct socket *sock, struct sockaddr_unspec *sockaddr,
 	return error;
 }
 
-static int pvc_connect(struct socket *sock, struct sockaddr *sockaddr,
+static int pvc_connect(struct socket *sock, struct sockaddr_unspec *sockaddr,
 		       int sockaddr_len, int flags)
 {
-	return pvc_bind(sock, (struct sockaddr_unspec *)sockaddr, sockaddr_len);
+	return pvc_bind(sock, sockaddr, sockaddr_len);
 }
 
 static int pvc_setsockopt(struct socket *sock, int level, int optname,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 1e7e4b412d1d..23b6db13d2b7 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -153,7 +153,7 @@ static int svc_bind(struct socket *sock, struct sockaddr_unspec *sockaddr,
 	return error;
 }
 
-static int svc_connect(struct socket *sock, struct sockaddr *sockaddr,
+static int svc_connect(struct socket *sock, struct sockaddr_unspec *sockaddr,
 		       int sockaddr_len, int flags)
 {
 	DEFINE_WAIT(wait);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index ea336cd4c9e9..888e72b7ebec 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1175,7 +1175,7 @@ static int ax25_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int add
  *	FIXME: nonblock behaviour looks like it may have a bug.
  */
 static int __must_check ax25_connect(struct socket *sock,
-	struct sockaddr *uaddr, int addr_len, int flags)
+	struct sockaddr_unspec *uaddr, int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	ax25_cb *ax25 = sk_to_ax25(sk), *ax25t;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a8d9808a66fe..dbc7fb644bd6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1060,7 +1060,7 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 	return err;
 }
 
-static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
+static int iso_sock_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			    int alen, int flags)
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5e68d113a17e..dde434a1404d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -178,7 +178,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, in
 	return err;
 }
 
-static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
+static int l2cap_sock_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			      int alen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 74fbf656e4a2..15c89f644097 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -808,7 +808,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
-	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
+	*err = kernel_connect(sock, (struct sockaddr_unspec *) &addr, sizeof(addr), O_NONBLOCK);
 	if (*err == 0 || *err == -EINPROGRESS)
 		return s;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index f253d43683ce..2e1ec4bc7196 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -371,7 +371,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr_unspec *addr, i
 	return err;
 }
 
-static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+static int rfcomm_sock_connect(struct socket *sock, struct sockaddr_unspec *addr, int alen, int flags)
 {
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 0b65fafd5bde..fdce0e96702a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -632,7 +632,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr_unspec *addr,
 	return err;
 }
 
-static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
+static int sco_sock_connect(struct socket *sock, struct sockaddr_unspec *addr, int alen, int flags)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 039dfbd367c9..885b599731e7 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -734,7 +734,7 @@ static int setsockopt(struct socket *sock, int lvl, int opt, sockptr_t ov,
  *  o sock->state: holds the SS_* socket state and is updated by connect and
  *	disconnect.
  */
-static int caif_connect(struct socket *sock, struct sockaddr *uaddr,
+static int caif_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 5e690a2377e4..a1cdfa580a3c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1657,7 +1657,7 @@ static int bcm_release(struct socket *sock)
 	return 0;
 }
 
-static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
+static int bcm_connect(struct socket *sock, struct sockaddr_unspec *uaddr, int len,
 		       int flags)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index dc93ae4ce71a..8ace44d5daa7 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -532,7 +532,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int
 	return ret;
 }
 
-static int j1939_sk_connect(struct socket *sock, struct sockaddr *uaddr,
+static int j1939_sk_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			    int len, int flags)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..e0af7c78b7b1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -459,7 +459,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+	ret = kernel_connect(sock, (struct sockaddr_unspec *)&ss, sizeof(ss),
 			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
diff --git a/net/core/sock.c b/net/core/sock.c
index fbc1fe4eab98..0f47ac2b242d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3439,7 +3439,7 @@ int sock_no_bind(struct socket *sock, struct sockaddr_unspec *saddr, int len)
 }
 EXPORT_SYMBOL(sock_no_bind);
 
-int sock_no_connect(struct socket *sock, struct sockaddr *saddr,
+int sock_no_connect(struct socket *sock, struct sockaddr_unspec *saddr,
 		    int len, int flags)
 {
 	return -EOPNOTSUPP;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index c1b832afb27b..4c7283453fba 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -107,7 +107,7 @@ static int ieee802154_sock_bind(struct socket *sock, struct sockaddr_unspec *uad
 	return sock_no_bind(sock, uaddr, addr_len);
 }
 
-static int ieee802154_sock_connect(struct socket *sock, struct sockaddr *uaddr,
+static int ieee802154_sock_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 				   int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -118,7 +118,7 @@ static int ieee802154_sock_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (uaddr->sa_family == AF_UNSPEC)
 		return sk->sk_prot->disconnect(sk, flags);
 
-	return sk->sk_prot->connect(sk, uaddr, addr_len);
+	return sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 }
 
 static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ec5ae709084d..0cee0020affc 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -565,7 +565,7 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	return err;
 }
 
-int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_dgram_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -582,14 +582,14 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		return prot->disconnect(sk, flags);
 
 	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-		err = prot->pre_connect(sk, uaddr, addr_len);
+		err = prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
 		if (err)
 			return err;
 	}
 
 	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
 		return -EAGAIN;
-	return prot->connect(sk, uaddr, addr_len);
+	return prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 }
 EXPORT_SYMBOL(inet_dgram_connect);
 
@@ -621,7 +621,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
  *	Connect to a remote host. There is regrettably still a little
  *	TCP 'magic' in here.
  */
-int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int __inet_stream_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			  int addr_len, int flags, int is_sendmsg)
 {
 	struct sock *sk = sock->sk;
@@ -669,12 +669,12 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			goto out;
 
 		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
-			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+			err = sk->sk_prot->pre_connect(sk, (struct sockaddr *)uaddr, addr_len);
 			if (err)
 				goto out;
 		}
 
-		err = sk->sk_prot->connect(sk, uaddr, addr_len);
+		err = sk->sk_prot->connect(sk, (struct sockaddr *)uaddr, addr_len);
 		if (err < 0)
 			goto out;
 
@@ -739,7 +739,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 }
 EXPORT_SYMBOL(__inet_stream_connect);
 
-int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+int inet_stream_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			int addr_len, int flags)
 {
 	int err;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 31149a0ac849..61352d5eeeaf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1042,7 +1042,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 		}
 	}
 	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-	err = __inet_stream_connect(sk->sk_socket, uaddr,
+	err = __inet_stream_connect(sk->sk_socket, (struct sockaddr_unspec *)uaddr,
 				    msg->msg_namelen, flags, 1);
 	/* fastopen_req could already be freed in __inet_stream_connect
 	 * if the connection times out or gets rst
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 51648121ff27..ae5aaf17a0aa 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -37,7 +37,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 		udp_addr.sin_family = AF_INET;
 		udp_addr.sin_addr = cfg->peer_ip;
 		udp_addr.sin_port = cfg->peer_udp_port;
-		err = kernel_connect(sock, (struct sockaddr *)&udp_addr,
+		err = kernel_connect(sock, (struct sockaddr_unspec *)&udp_addr,
 				     sizeof(udp_addr), 0);
 		if (err < 0)
 			goto error;
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 78d7297e3db7..a6533976ebc4 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -52,7 +52,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 		       sizeof(udp6_addr.sin6_addr));
 		udp6_addr.sin6_port = cfg->peer_udp_port;
 		err = kernel_connect(sock,
-				     (struct sockaddr *)&udp6_addr,
+				     (struct sockaddr_unspec *)&udp6_addr,
 				     sizeof(udp6_addr), 0);
 	}
 	if (err < 0)
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 6ab3354402fc..ba25f6545b9a 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1513,7 +1513,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			       sizeof(ip6_addr.l2tp_addr));
 			ip6_addr.l2tp_conn_id = peer_tunnel_id;
 			err = kernel_connect(sock,
-					     (struct sockaddr *)&ip6_addr,
+					     (struct sockaddr_unspec *)&ip6_addr,
 					     sizeof(ip6_addr), 0);
 			if (err < 0)
 				goto out;
@@ -1538,7 +1538,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 			ip_addr.l2tp_family = AF_INET;
 			ip_addr.l2tp_addr = cfg->peer_ip;
 			ip_addr.l2tp_conn_id = peer_tunnel_id;
-			err = kernel_connect(sock, (struct sockaddr *)&ip_addr,
+			err = kernel_connect(sock, (struct sockaddr_unspec *)&ip_addr,
 					     sizeof(ip_addr), 0);
 			if (err < 0)
 				goto out;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 767b393cbb78..635bf04279ac 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -701,7 +701,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 
 /* connect() handler. Attach a PPPoX socket to a tunnel UDP socket
  */
-static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
+static int pppol2tp_connect(struct socket *sock, struct sockaddr_unspec *uservaddr,
 			    int sockaddr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 889804f0e4f4..f79c05a6db70 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -477,7 +477,7 @@ static int llc_ui_shutdown(struct socket *sock, int how)
  *	This function will autobind if user did not previously call bind.
  *	Returns: 0 upon success, negative otherwise.
  */
-static int llc_ui_connect(struct socket *sock, struct sockaddr *uaddr,
+static int llc_ui_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			  int addrlen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2f8896fe3319..05bcf0046b86 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1675,7 +1675,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 
 	sock_hold(ssk);
 	list_add_tail(&subflow->node, &msk->conn_list);
-	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
+	err = kernel_connect(sf, (struct sockaddr_unspec *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCONNECTERR);
 		pr_debug("msk=%p local=%d remote=%d connect error: %d\n",
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index c9a97f8a6ce0..860a06b5bbbb 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1501,7 +1501,7 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+	result = kernel_connect(sock, (struct sockaddr_unspec *)&mcast_addr,
 				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e633c2e1224d..da4ea06bd7d4 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1056,7 +1056,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unspec *addr,
 	return err;
 }
 
-static int netlink_connect(struct socket *sock, struct sockaddr *addr,
+static int netlink_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			   int alen, int flags)
 {
 	int err = 0;
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 4accfe4abeb9..7d58330dcc9c 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -632,7 +632,7 @@ static int nr_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_
 	return 0;
 }
 
-static int nr_connect(struct socket *sock, struct sockaddr *uaddr,
+static int nr_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 	int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 7d4fe806c4bf..6dccbf8e0523 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -648,7 +648,7 @@ static int llcp_sock_release(struct socket *sock)
 	return err;
 }
 
-static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
+static int llcp_sock_connect(struct socket *sock, struct sockaddr_unspec *_addr,
 			     int len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 5125392bb68e..7b0ca19f483f 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -73,7 +73,7 @@ static int rawsock_release(struct socket *sock)
 	return 0;
 }
 
-static int rawsock_connect(struct socket *sock, struct sockaddr *_addr,
+static int rawsock_connect(struct socket *sock, struct sockaddr_unspec *_addr,
 			   int len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 95d07e7f6c2c..a410f4001869 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -214,7 +214,7 @@ static int pn_socket_autobind(struct socket *sock)
 	return 0; /* socket was already bound */
 }
 
-static int pn_socket_connect(struct socket *sock, struct sockaddr *addr,
+static int pn_socket_connect(struct socket *sock, struct sockaddr_unspec *addr,
 		int len, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -252,7 +252,7 @@ static int pn_socket_connect(struct socket *sock, struct sockaddr *addr,
 	pn->resource = pn_sockaddr_get_resource(spn);
 	sock->state = SS_CONNECTING;
 
-	err = sk->sk_prot->connect(sk, addr, len);
+	err = sk->sk_prot->connect(sk, (struct sockaddr *)addr, len);
 	if (err) {
 		sock->state = SS_UNCONNECTED;
 		pn->dobject = 0;
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 5c952946f9f0..e16859b7a111 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1084,7 +1084,7 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 	return rc;
 }
 
-static int qrtr_connect(struct socket *sock, struct sockaddr *saddr,
+static int qrtr_connect(struct socket *sock, struct sockaddr_unspec *saddr,
 			int len, int flags)
 {
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, saddr);
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 086a13170e09..6ce3127737dd 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -533,7 +533,7 @@ static int rds_getsockopt(struct socket *sock, int level, int optname,
 
 }
 
-static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
+static int rds_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index d807d5d11ad2..d2d988cd1d9b 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr_unspec *)addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 51c9b6d46a3e..c34736f54682 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -765,7 +765,7 @@ static int rose_bind(struct socket *sock, struct sockaddr_unspec *uaddr, int add
 	return err;
 }
 
-static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags)
+static int rose_connect(struct socket *sock, struct sockaddr_unspec *uaddr, int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct rose_sock *rose = rose_sk(sk);
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index ea506d7f83cd..d9a28b3b1fd2 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(rxrpc_kernel_set_notifications);
  * - this just targets it at a specific destination; no actual connection
  *   negotiation takes place
  */
-static int rxrpc_connect(struct socket *sock, struct sockaddr *addr,
+static int rxrpc_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			 int addr_len, int flags)
 {
 	struct sockaddr_rxrpc *srx = (struct sockaddr_rxrpc *)addr;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 4921416434f9..af736c5aa902 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4823,7 +4823,7 @@ static int sctp_connect(struct sock *sk, struct sockaddr *addr,
 	return err;
 }
 
-int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
+int sctp_inet_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		      int addr_len, int flags)
 {
 	if (addr_len < sizeof(uaddr->sa_family))
@@ -4832,7 +4832,7 @@ int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (uaddr->sa_family == AF_UNSPEC)
 		return -EOPNOTSUPP;
 
-	return sctp_connect(sock->sk, uaddr, addr_len, flags);
+	return sctp_connect(sock->sk, (struct sockaddr *)uaddr, addr_len, flags);
 }
 
 /* Only called when shutdown a listening SCTP socket. */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c7d3318fd4d2..5bd6ba6cacd0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1645,7 +1645,7 @@ static void smc_connect_work(struct work_struct *work)
 	release_sock(&smc->sk);
 }
 
-int smc_connect(struct socket *sock, struct sockaddr *addr,
+int smc_connect(struct socket *sock, struct sockaddr_unspec *addr,
 		int alen, int flags)
 {
 	struct sock *sk = sock->sk;
@@ -1697,7 +1697,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
 		rc = -EALREADY;
 		goto out;
 	}
-	rc = kernel_connect(smc->clcsock, addr, alen, flags);
+	rc = kernel_connect(smc->clcsock, (struct sockaddr_unspec *)addr, alen, flags);
 	if (rc && rc != -EINPROGRESS)
 		goto out;
 
diff --git a/net/socket.c b/net/socket.c
index f49576fdd810..700fedefdf88 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2083,7 +2083,7 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 	if (err)
 		goto out;
 
-	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)address,
+	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unspec *)address,
 				addrlen, sock->file->f_flags | file_flags);
 out:
 	return err;
@@ -3646,14 +3646,14 @@ EXPORT_SYMBOL(kernel_accept);
  *	Returns 0 or an error code.
  */
 
-int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
+int kernel_connect(struct socket *sock, struct sockaddr_unspec *addr, int addrlen,
 		   int flags)
 {
 	struct sockaddr_storage address;
 
 	memcpy(&address, addr, addrlen);
 
-	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unspec *)&address,
 					     addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 5ab0404da2cc..1e60c9ff5ec9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1474,7 +1474,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 		goto out_release;
 	}
 
-	err = kernel_connect(sock, sap, salen, 0);
+	err = kernel_connect(sock, (struct sockaddr_unspec *)sap, salen, 0);
 	if (err < 0) {
 		dprintk("RPC:       can't connect UDP socket (%d)\n", err);
 		goto out_release;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b24dcbc7f8c4..958f3941344d 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1985,7 +1985,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 
 	xs_stream_start_connect(transport);
 
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, 0);
+	return kernel_connect(sock, (struct sockaddr_unspec *)xs_addr(xprt), xprt->addrlen, 0);
 }
 
 /**
@@ -2385,7 +2385,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 	/* Tell the socket layer to start connecting... */
 	set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
+	return kernel_connect(sock, (struct sockaddr_unspec *)xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
 }
 
 /**
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 16ad50451c61..7ab846e384c4 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2565,7 +2565,7 @@ static bool tipc_sockaddr_is_sane(struct sockaddr_tipc *addr)
  *
  * Return: 0 on success, errno otherwise
  */
-static int tipc_connect(struct socket *sock, struct sockaddr *dest,
+static int tipc_connect(struct socket *sock, struct sockaddr_unspec *dest,
 			int destlen, int flags)
 {
 	struct sock *sk = sock->sk;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 465e7822604c..49e720e4ce89 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -855,7 +855,7 @@ static int unix_listen(struct socket *sock, int backlog)
 
 static int unix_release(struct socket *);
 static int unix_bind(struct socket *, struct sockaddr_unspec *, int);
-static int unix_stream_connect(struct socket *, struct sockaddr *,
+static int unix_stream_connect(struct socket *, struct sockaddr_unspec *,
 			       int addr_len, int flags);
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, struct proto_accept_arg *arg);
@@ -877,7 +877,7 @@ static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
 static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
-static int unix_dgram_connect(struct socket *, struct sockaddr *,
+static int unix_dgram_connect(struct socket *, struct sockaddr_unspec *,
 			      int, int);
 static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_seqpacket_recvmsg(struct socket *, struct msghdr *, size_t,
@@ -1523,7 +1523,7 @@ static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
 	unix_state_unlock(sk2);
 }
 
-static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
+static int unix_dgram_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			      int alen, int flags)
 {
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)addr;
@@ -1642,7 +1642,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 	return timeo;
 }
 
-static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+static int unix_stream_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 			       int addr_len, int flags)
 {
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b817247f16e6..4790c1ebee1b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -994,7 +994,7 @@ vsock_bind(struct socket *sock, struct sockaddr_unspec *addr, int addr_len)
 
 	sk = sock->sk;
 
-	if (vsock_addr_cast((struct sockaddr *)addr, addr_len, &vm_addr) != 0)
+	if (vsock_addr_cast(addr, addr_len, &vm_addr) != 0)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -1337,7 +1337,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int vsock_dgram_connect(struct socket *sock,
-			       struct sockaddr *addr, int addr_len, int flags)
+			       struct sockaddr_unspec *addr, int addr_len, int flags)
 {
 	int err;
 	struct sock *sk;
@@ -1537,7 +1537,7 @@ static void vsock_connect_timeout(struct work_struct *work)
 	sock_put(sk);
 }
 
-static int vsock_connect(struct socket *sock, struct sockaddr *addr,
+static int vsock_connect(struct socket *sock, struct sockaddr_unspec *addr,
 			 int addr_len, int flags)
 {
 	int err;
diff --git a/net/vmw_vsock/vsock_addr.c b/net/vmw_vsock/vsock_addr.c
index 223b9660a759..39188482feca 100644
--- a/net/vmw_vsock/vsock_addr.c
+++ b/net/vmw_vsock/vsock_addr.c
@@ -57,7 +57,7 @@ bool vsock_addr_equals_addr(const struct sockaddr_vm *addr,
 }
 EXPORT_SYMBOL_GPL(vsock_addr_equals_addr);
 
-int vsock_addr_cast(const struct sockaddr *addr,
+int vsock_addr_cast(const struct sockaddr_unspec *addr,
 		    size_t len, struct sockaddr_vm **out_addr)
 {
 	if (len < sizeof(**out_addr))
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index b6a42ea0e3be..8a5eae271fed 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -743,7 +743,7 @@ static int x25_wait_for_connection_establishment(struct sock *sk)
 	return rc;
 }
 
-static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
+static int x25_connect(struct socket *sock, struct sockaddr_unspec *uaddr,
 		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
-- 
2.34.1


