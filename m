Return-Path: <netdev+bounces-141698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A69BC0DC
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553271F22B31
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA61FF043;
	Mon,  4 Nov 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f831bjnE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37481FF037;
	Mon,  4 Nov 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759119; cv=none; b=DbMdEnsQ/LKApTwdRBbxq7SKAa2+V0ZTmxojd1Iv9DFY/UdI33MWR1HrvWqV7VIpSWFRdIDBAn5XPQIMIeM98pkFb9iXN/LBIqP9t9CwSm2CKvhpnKISjxb6EQH580lSEc2YdwDYp873M17xWo/alwClM1luVL6tEikxZZsMRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759119; c=relaxed/simple;
	bh=eOql+4yuzIxnKVe9PYLRve1kg+P1CWOfUj2yARTYk9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yjm34hUh9qaHf83Lj/AjYqQV/FMjPh3xIA2bg+48R7JwX0nE5oRJOGuYALZFLmn+ke18/tJ0TnG6Gzo4ZvJgwoWOMnTjSocg8DWCPiUkycSd0RFljQCyDCv02WKZis/HqRb1R1kvbzyWOADECBHtr7EJIjIMkHZqTPE8RJ5pGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f831bjnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F815C4CED0;
	Mon,  4 Nov 2024 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759119;
	bh=eOql+4yuzIxnKVe9PYLRve1kg+P1CWOfUj2yARTYk9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f831bjnEcE71QXyCNEyNmqCcI1kK/qcncC/DtV1JZjNRgpagPHAxGNRPj9iE7wyjC
	 UYPw0YFxyxm4A8Uv3LV6XbqVFOKVNA1nBQVq6vO4jqgtcIp1jvWRSQgkLNd5vNxNut
	 NfUoYWm7bZ3KZ3UTc/DxU8ek1lDbcgRCK5CYmXZsmi8Jf70soPMRBsM1vedlhq4XZr
	 23HH1ILjZphXpaPTkbReraPbHL8yIMXZLsRYnlS8TU06wKMB+kWNYTBnDZ9TPoiVpg
	 0vTxfa5PvQgic+3d8sl/e3gRtD9SL3yAhLrvsXzrZ0yldXbYpdhuhEPKmxfeiYCgTK
	 Kr7EcgIW4q0Ww==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 5/5] net: Convert proto_ops::getname to sockaddr_storage
Date: Mon,  4 Nov 2024 14:25:07 -0800
Message-Id: <20241104222513.3469025-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=56057; i=kees@kernel.org; h=from:subject; bh=eOql+4yuzIxnKVe9PYLRve1kg+P1CWOfUj2yARTYk9s=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmanodCuAzSL7i9vaCie/0Xu+3PCyeFiqcwfhf3Xewj9 2/yjF+vO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACayaB7Df/cDqyets2EoNNy4 nF9f6MHkfOWvnXxMN5S1ts6NOGvu5srI8FM30ih81b3PIomzNsxmYrqe3VV/PrPuJX9SlKSitNw EZgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The proto_ops::getname callback was long ago backed by sockaddr_storage,
but the replacement of it for sockaddr was never done. Plumb
sockaddr_storage through all the getname callbacks and adjust prototypes
and needed casts. Mostly casts to sockaddr are removed, though to avoid
spilling this change into BPF, cast the sockaddr_storage instances to
sockaddr for the time being.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/infiniband/hw/erdma/erdma_cm.h        |  4 +-
 drivers/infiniband/hw/usnic/usnic_transport.c | 16 +++---
 drivers/infiniband/sw/siw/siw_cm.h            |  4 +-
 drivers/isdn/mISDN/socket.c                   |  2 +-
 drivers/net/ppp/pppoe.c                       |  2 +-
 drivers/net/ppp/pptp.c                        |  2 +-
 drivers/nvme/host/tcp.c                       |  2 +-
 drivers/nvme/target/tcp.c                     |  6 +--
 drivers/scsi/iscsi_tcp.c                      | 18 +++----
 drivers/soc/qcom/qmi_interface.c              |  2 +-
 drivers/target/iscsi/iscsi_target_login.c     | 51 +++++++++----------
 fs/dlm/lowcomms.c                             |  2 +-
 fs/nfs/nfs4client.c                           |  4 +-
 fs/ocfs2/cluster/tcp.c                        | 25 +++++----
 fs/smb/server/connection.h                    |  2 +-
 fs/smb/server/mgmt/tree_connect.c             |  2 +-
 fs/smb/server/transport_ipc.c                 |  4 +-
 fs/smb/server/transport_ipc.h                 |  4 +-
 fs/smb/server/transport_tcp.c                 |  6 +--
 include/linux/net.h                           |  6 +--
 include/linux/sunrpc/clnt.h                   |  2 +-
 include/net/inet_common.h                     |  2 +-
 include/net/ipv6.h                            |  2 +-
 include/net/sock.h                            |  2 +-
 net/appletalk/ddp.c                           |  2 +-
 net/atm/pvc.c                                 |  2 +-
 net/atm/svc.c                                 |  2 +-
 net/ax25/af_ax25.c                            |  2 +-
 net/bluetooth/hci_sock.c                      |  2 +-
 net/bluetooth/iso.c                           |  6 +--
 net/bluetooth/l2cap_sock.c                    |  6 +--
 net/bluetooth/rfcomm/sock.c                   |  3 +-
 net/bluetooth/sco.c                           |  6 +--
 net/can/isotp.c                               |  3 +-
 net/can/j1939/socket.c                        |  2 +-
 net/can/raw.c                                 |  2 +-
 net/core/sock.c                               |  4 +-
 net/ipv4/af_inet.c                            |  2 +-
 net/ipv6/af_inet6.c                           |  2 +-
 net/iucv/af_iucv.c                            |  6 +--
 net/l2tp/l2tp_ip.c                            |  2 +-
 net/l2tp/l2tp_ip6.c                           |  2 +-
 net/l2tp/l2tp_ppp.c                           |  2 +-
 net/llc/af_llc.c                              |  2 +-
 net/netlink/af_netlink.c                      |  4 +-
 net/netrom/af_netrom.c                        |  2 +-
 net/nfc/llcp_sock.c                           |  4 +-
 net/packet/af_packet.c                        | 15 +++---
 net/phonet/socket.c                           | 10 ++--
 net/qrtr/af_qrtr.c                            |  2 +-
 net/qrtr/ns.c                                 |  2 +-
 net/rds/af_rds.c                              |  2 +-
 net/rose/af_rose.c                            |  2 +-
 net/sctp/ipv6.c                               |  2 +-
 net/smc/af_smc.c                              |  2 +-
 net/smc/smc.h                                 |  2 +-
 net/smc/smc_clc.c                             |  2 +-
 net/socket.c                                  | 10 ++--
 net/sunrpc/clnt.c                             |  9 ++--
 net/sunrpc/svcsock.c                          |  8 +--
 net/sunrpc/xprtsock.c                         |  4 +-
 net/tipc/socket.c                             |  2 +-
 net/unix/af_unix.c                            |  9 ++--
 net/vmw_vsock/af_vsock.c                      |  2 +-
 net/x25/af_x25.c                              |  2 +-
 security/tomoyo/network.c                     |  3 +-
 66 files changed, 166 insertions(+), 166 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.h b/drivers/infiniband/hw/erdma/erdma_cm.h
index a26d80770188..4e46ba491d5c 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.h
+++ b/drivers/infiniband/hw/erdma/erdma_cm.h
@@ -141,12 +141,12 @@ struct erdma_cm_work {
 
 static inline int getname_peer(struct socket *s, struct sockaddr_storage *a)
 {
-	return s->ops->getname(s, (struct sockaddr *)a, 1);
+	return s->ops->getname(s, a, 1);
 }
 
 static inline int getname_local(struct socket *s, struct sockaddr_storage *a)
 {
-	return s->ops->getname(s, (struct sockaddr *)a, 0);
+	return s->ops->getname(s, a, 0);
 }
 
 int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *param);
diff --git a/drivers/infiniband/hw/usnic/usnic_transport.c b/drivers/infiniband/hw/usnic/usnic_transport.c
index dc37066900a5..7c38abc25671 100644
--- a/drivers/infiniband/hw/usnic/usnic_transport.c
+++ b/drivers/infiniband/hw/usnic/usnic_transport.c
@@ -174,24 +174,24 @@ int usnic_transport_sock_get_addr(struct socket *sock, int *proto,
 					uint32_t *addr, uint16_t *port)
 {
 	int err;
-	struct sockaddr_in sock_addr;
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr_in sock_addr;
+	} u;
 
-	err = sock->ops->getname(sock,
-				(struct sockaddr *)&sock_addr,
-				0);
+	err = sock->ops->getname(sock, &u.storage, 0);
 	if (err < 0)
 		return err;
 
-	if (sock_addr.sin_family != AF_INET)
+	if (u.sock_addr.sin_family != AF_INET)
 		return -EINVAL;
 
 	if (proto)
 		*proto = sock->sk->sk_protocol;
 	if (port)
-		*port = ntohs(((struct sockaddr_in *)&sock_addr)->sin_port);
+		*port = ntohs(u.sock_addr.sin_port);
 	if (addr)
-		*addr = ntohl(((struct sockaddr_in *)
-					&sock_addr)->sin_addr.s_addr);
+		*addr = ntohl(u.sock_addr.sin_addr.s_addr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
index 7011c8a8ee7b..804559be83d4 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -94,12 +94,12 @@ struct siw_cm_work {
 
 static inline int getname_peer(struct socket *s, struct sockaddr_storage *a)
 {
-	return s->ops->getname(s, (struct sockaddr *)a, 1);
+	return s->ops->getname(s, a, 1);
 }
 
 static inline int getname_local(struct socket *s, struct sockaddr_storage *a)
 {
-	return s->ops->getname(s, (struct sockaddr *)a, 0);
+	return s->ops->getname(s, a, 0);
 }
 
 static inline int ksock_recv(struct socket *sock, char *buf, size_t size,
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index b215b28cad7b..2a3bcbf6d15b 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -549,7 +549,7 @@ data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 }
 
 static int
-data_sock_getname(struct socket *sock, struct sockaddr *addr,
+data_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
 		  int peer)
 {
 	struct sockaddr_mISDN	*maddr = (struct sockaddr_mISDN *) addr;
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 2ea4f4890d23..518b3f0e2701 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -717,7 +717,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 	goto end;
 }
 
-static int pppoe_getname(struct socket *sock, struct sockaddr *uaddr,
+static int pppoe_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		  int peer)
 {
 	int len = sizeof(struct sockaddr_pppox);
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 689687bd2574..9f3b38e311f4 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -479,7 +479,7 @@ static int pptp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	return error;
 }
 
-static int pptp_getname(struct socket *sock, struct sockaddr *uaddr,
+static int pptp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 	int peer)
 {
 	int len = sizeof(struct sockaddr_pppox);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89c44413c593..6647d0e754ad 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2648,7 +2648,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		goto done;
-	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
+	ret = kernel_getsockname(queue->sock, &src_addr);
 	if (ret > 0) {
 		if (len > 0)
 			len--; /* strip trailing newline */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index df24244fb820..87324c723ed4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1689,13 +1689,11 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
-	ret = kernel_getsockname(sock,
-		(struct sockaddr *)&queue->sockaddr);
+	ret = kernel_getsockname(sock, &queue->sockaddr);
 	if (ret < 0)
 		return ret;
 
-	ret = kernel_getpeername(sock,
-		(struct sockaddr *)&queue->sockaddr_peer);
+	ret = kernel_getpeername(sock, &queue->sockaddr_peer);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index c708e1059638..0a457f8a5062 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -794,7 +794,7 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn;
 	struct iscsi_tcp_conn *tcp_conn;
-	struct sockaddr_in6 addr;
+	struct sockaddr_storage addr;
 	struct socket *sock;
 	int rc;
 
@@ -825,19 +825,16 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
 		}
 
 		if (param == ISCSI_PARAM_LOCAL_PORT)
-			rc = kernel_getsockname(sock,
-						(struct sockaddr *)&addr);
+			rc = kernel_getsockname(sock, &addr);
 		else
-			rc = kernel_getpeername(sock,
-						(struct sockaddr *)&addr);
+			rc = kernel_getpeername(sock, &addr);
 sock_unlock:
 		mutex_unlock(&tcp_sw_conn->sock_lock);
 		iscsi_put_conn(conn->cls_conn);
 		if (rc < 0)
 			return rc;
 
-		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
-						 &addr, param, buf);
+		return iscsi_conn_get_addr_param(&addr, param, buf);
 	default:
 		return iscsi_conn_get_param(cls_conn, param, buf);
 	}
@@ -853,7 +850,7 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 	struct iscsi_conn *conn;
 	struct iscsi_tcp_conn *tcp_conn;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn;
-	struct sockaddr_in6 addr;
+	struct sockaddr_storage addr;
 	struct socket *sock;
 	int rc;
 
@@ -883,14 +880,13 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 		if (!sock)
 			rc = -ENOTCONN;
 		else
-			rc = kernel_getsockname(sock, (struct sockaddr *)&addr);
+			rc = kernel_getsockname(sock, &addr);
 		mutex_unlock(&tcp_sw_conn->sock_lock);
 		iscsi_put_conn(conn->cls_conn);
 		if (rc < 0)
 			return rc;
 
-		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
-						 &addr,
+		return iscsi_conn_get_addr_param(&addr,
 						 (enum iscsi_param)param, buf);
 	default:
 		return iscsi_host_get_param(shost, param, buf);
diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index bb98b06e87f8..d495e63aa2ee 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -593,7 +593,7 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = kernel_getsockname(sock, (struct sockaddr *)sq);
+	ret = kernel_getsockname(sock, (struct sockaddr_storage *)sq);
 	if (ret < 0) {
 		sock_release(sock);
 		return ERR_PTR(ret);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 90b870f234f0..9fcbfba43035 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -907,8 +907,11 @@ int iscsi_target_setup_login_socket(
 int iscsit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 {
 	struct socket *new_sock, *sock = np->np_socket;
-	struct sockaddr_in sock_in;
-	struct sockaddr_in6 sock_in6;
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr_in sock_in;
+		struct sockaddr_in6 sock_in6;
+	} u;
 	int rc;
 
 	rc = kernel_accept(sock, &new_sock, 0);
@@ -919,47 +922,43 @@ int iscsit_accept_np(struct iscsi_np *np, struct iscsit_conn *conn)
 	conn->login_family = np->np_sockaddr.ss_family;
 
 	if (np->np_sockaddr.ss_family == AF_INET6) {
-		memset(&sock_in6, 0, sizeof(struct sockaddr_in6));
+		memset(&u.sock_in6, 0, sizeof(struct sockaddr_in6));
 
-		rc = conn->sock->ops->getname(conn->sock,
-				(struct sockaddr *)&sock_in6, 1);
+		rc = conn->sock->ops->getname(conn->sock, &u.storage, 1);
 		if (rc >= 0) {
-			if (!ipv6_addr_v4mapped(&sock_in6.sin6_addr)) {
-				memcpy(&conn->login_sockaddr, &sock_in6, sizeof(sock_in6));
+			if (!ipv6_addr_v4mapped(&u.sock_in6.sin6_addr)) {
+				memcpy(&conn->login_sockaddr, &u.sock_in6, sizeof(u.sock_in6));
 			} else {
 				/* Pretend to be an ipv4 socket */
-				sock_in.sin_family = AF_INET;
-				sock_in.sin_port = sock_in6.sin6_port;
-				memcpy(&sock_in.sin_addr, &sock_in6.sin6_addr.s6_addr32[3], 4);
-				memcpy(&conn->login_sockaddr, &sock_in, sizeof(sock_in));
+				u.sock_in.sin_family = AF_INET;
+				u.sock_in.sin_port = u.sock_in6.sin6_port;
+				memcpy(&u.sock_in.sin_addr, &u.sock_in6.sin6_addr.s6_addr32[3], 4);
+				memcpy(&conn->login_sockaddr, &u.sock_in, sizeof(u.sock_in));
 			}
 		}
 
-		rc = conn->sock->ops->getname(conn->sock,
-				(struct sockaddr *)&sock_in6, 0);
+		rc = conn->sock->ops->getname(conn->sock, &u.storage, 0);
 		if (rc >= 0) {
-			if (!ipv6_addr_v4mapped(&sock_in6.sin6_addr)) {
-				memcpy(&conn->local_sockaddr, &sock_in6, sizeof(sock_in6));
+			if (!ipv6_addr_v4mapped(&u.sock_in6.sin6_addr)) {
+				memcpy(&conn->local_sockaddr, &u.sock_in6, sizeof(u.sock_in6));
 			} else {
 				/* Pretend to be an ipv4 socket */
-				sock_in.sin_family = AF_INET;
-				sock_in.sin_port = sock_in6.sin6_port;
-				memcpy(&sock_in.sin_addr, &sock_in6.sin6_addr.s6_addr32[3], 4);
-				memcpy(&conn->local_sockaddr, &sock_in, sizeof(sock_in));
+				u.sock_in.sin_family = AF_INET;
+				u.sock_in.sin_port = u.sock_in6.sin6_port;
+				memcpy(&u.sock_in.sin_addr, &u.sock_in6.sin6_addr.s6_addr32[3], 4);
+				memcpy(&conn->local_sockaddr, &u.sock_in, sizeof(u.sock_in));
 			}
 		}
 	} else {
-		memset(&sock_in, 0, sizeof(struct sockaddr_in));
+		memset(&u.sock_in, 0, sizeof(struct sockaddr_in));
 
-		rc = conn->sock->ops->getname(conn->sock,
-				(struct sockaddr *)&sock_in, 1);
+		rc = conn->sock->ops->getname(conn->sock, &u.storage, 1);
 		if (rc >= 0)
-			memcpy(&conn->login_sockaddr, &sock_in, sizeof(sock_in));
+			memcpy(&conn->login_sockaddr, &u.sock_in, sizeof(u.sock_in));
 
-		rc = conn->sock->ops->getname(conn->sock,
-				(struct sockaddr *)&sock_in, 0);
+		rc = conn->sock->ops->getname(conn->sock, &u.storage, 0);
 		if (rc >= 0)
-			memcpy(&conn->local_sockaddr, &sock_in, sizeof(sock_in));
+			memcpy(&conn->local_sockaddr, &u.sock_in, sizeof(u.sock_in));
 	}
 
 	return 0;
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cb3a10b041c2..c5467753c72d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -993,7 +993,7 @@ static int accept_from_sock(void)
 
 	/* Get the connected socket's peer */
 	memset(&peeraddr, 0, sizeof(peeraddr));
-	len = newsock->ops->getname(newsock, (struct sockaddr *)&peeraddr, 2);
+	len = newsock->ops->getname(newsock, &peeraddr, 2);
 	if (len < 0) {
 		result = -ECONNABORTED;
 		goto accept_err;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 83378f69b35e..a7428367a526 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -248,7 +248,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 		struct sockaddr_storage cb_addr;
 		struct sockaddr *sap = (struct sockaddr *)&cb_addr;
 
-		err = rpc_localaddr(clp->cl_rpcclient, sap, sizeof(cb_addr));
+		err = rpc_localaddr(clp->cl_rpcclient, &cb_addr, sizeof(cb_addr));
 		if (err < 0)
 			goto error;
 		err = rpc_ntop(sap, buf, sizeof(buf));
@@ -1352,7 +1352,7 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 	if (error != 0)
 		return error;
 
-	error = rpc_localaddr(clnt, localaddr, sizeof(address));
+	error = rpc_localaddr(clnt, &address, sizeof(address));
 	if (error != 0)
 		return error;
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 2b8fa3e782fb..28996cd2300d 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1779,7 +1779,10 @@ int o2net_register_hb_callbacks(void)
 static int o2net_accept_one(struct socket *sock, int *more)
 {
 	int ret;
-	struct sockaddr_in sin;
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr_in sin;
+	} u;
 	struct socket *new_sock = NULL;
 	struct o2nm_node *node = NULL;
 	struct o2nm_node *local_node = NULL;
@@ -1815,15 +1818,15 @@ static int o2net_accept_one(struct socket *sock, int *more)
 	tcp_sock_set_nodelay(new_sock->sk);
 	tcp_sock_set_user_timeout(new_sock->sk, O2NET_TCP_USER_TIMEOUT);
 
-	ret = new_sock->ops->getname(new_sock, (struct sockaddr *) &sin, 1);
+	ret = new_sock->ops->getname(new_sock, &u.storage, 1);
 	if (ret < 0)
 		goto out;
 
-	node = o2nm_get_node_by_ip(sin.sin_addr.s_addr);
+	node = o2nm_get_node_by_ip(u.sin.sin_addr.s_addr);
 	if (node == NULL) {
 		printk(KERN_NOTICE "o2net: Attempt to connect from unknown "
-		       "node at %pI4:%d\n", &sin.sin_addr.s_addr,
-		       ntohs(sin.sin_port));
+		       "node at %pI4:%d\n", &u.sin.sin_addr.s_addr,
+		       ntohs(u.sin.sin_port));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1838,8 +1841,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
 					&(local_node->nd_ipv4_address),
 					ntohs(local_node->nd_ipv4_port),
 					node->nd_name,
-					node->nd_num, &sin.sin_addr.s_addr,
-					ntohs(sin.sin_port));
+					node->nd_num, &u.sin.sin_addr.s_addr,
+					ntohs(u.sin.sin_port));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1849,8 +1852,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
 	if (!o2hb_check_node_heartbeating_from_callback(node->nd_num)) {
 		mlog(ML_CONN, "attempt to connect from node '%s' at "
 		     "%pI4:%d but it isn't heartbeating\n",
-		     node->nd_name, &sin.sin_addr.s_addr,
-		     ntohs(sin.sin_port));
+		     node->nd_name, &u.sin.sin_addr.s_addr,
+		     ntohs(u.sin.sin_port));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1866,8 +1869,8 @@ static int o2net_accept_one(struct socket *sock, int *more)
 	if (ret) {
 		printk(KERN_NOTICE "o2net: Attempt to connect from node '%s' "
 		       "at %pI4:%d but it already has an open connection\n",
-		       node->nd_name, &sin.sin_addr.s_addr,
-		       ntohs(sin.sin_port));
+		       node->nd_name, &u.sin.sin_addr.s_addr,
+		       ntohs(u.sin.sin_port));
 		goto out;
 	}
 
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index b379ae4fdcdf..6839fbefdaf0 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -140,7 +140,7 @@ struct ksmbd_transport {
 
 #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
 #define KSMBD_TCP_SEND_TIMEOUT	(5 * HZ)
-#define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
+#define KSMBD_TCP_PEER_SOCKADDR(c)	(&((c)->peer_addr))
 
 extern struct list_head conn_list;
 extern struct rw_semaphore conn_list_lock;
diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index 94a52a75014a..1f2b11df6229 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -22,7 +22,7 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	struct ksmbd_tree_connect_response *resp = NULL;
 	struct ksmbd_share_config *sc;
 	struct ksmbd_tree_connect *tree_conn = NULL;
-	struct sockaddr *peer_addr;
+	struct sockaddr_storage *peer_addr;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	int ret;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 8752ac82c557..05ea6426b341 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -588,7 +588,7 @@ struct ksmbd_tree_connect_response *
 ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
 			       struct ksmbd_share_config *share,
 			       struct ksmbd_tree_connect *tree_conn,
-			       struct sockaddr *peer_addr)
+			       struct sockaddr_storage *peer_addr)
 {
 	struct ksmbd_ipc_msg *msg;
 	struct ksmbd_tree_connect_request *req;
@@ -615,7 +615,7 @@ ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
 	strscpy(req->share, share->name, KSMBD_REQ_MAX_SHARE_NAME);
 	snprintf(req->peer_addr, sizeof(req->peer_addr), "%pIS", peer_addr);
 
-	if (peer_addr->sa_family == AF_INET6)
+	if (peer_addr->ss_family == AF_INET6)
 		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_IPV6;
 	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
 		req->flags |= KSMBD_TREE_CONN_FLAG_REQUEST_SMB2;
diff --git a/fs/smb/server/transport_ipc.h b/fs/smb/server/transport_ipc.h
index 5e5b90a0c187..0a69e758430e 100644
--- a/fs/smb/server/transport_ipc.h
+++ b/fs/smb/server/transport_ipc.h
@@ -16,13 +16,13 @@ ksmbd_ipc_login_request(const char *account);
 struct ksmbd_session;
 struct ksmbd_share_config;
 struct ksmbd_tree_connect;
-struct sockaddr;
+struct __kernel_sockaddr_storage;
 
 struct ksmbd_tree_connect_response *
 ksmbd_ipc_tree_connect_request(struct ksmbd_session *sess,
 			       struct ksmbd_share_config *share,
 			       struct ksmbd_tree_connect *tree_conn,
-			       struct sockaddr *peer_addr);
+			       struct __kernel_sockaddr_storage *peer_addr);
 int ksmbd_ipc_tree_disconnect_request(unsigned long long session_id,
 				      unsigned long long connect_id);
 int ksmbd_ipc_logout_request(const char *account, int flags);
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index aaed9e293b2e..71e0ed852006 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -160,9 +160,9 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
 	return new_iov;
 }
 
-static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
+static unsigned short ksmbd_tcp_get_port(const struct sockaddr_storage *sa)
 {
-	switch (sa->sa_family) {
+	switch (sa->ss_family) {
 	case AF_INET:
 		return ntohs(((struct sockaddr_in *)sa)->sin_port);
 	case AF_INET6:
@@ -182,7 +182,7 @@ static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
  */
 static int ksmbd_tcp_new_connection(struct socket *client_sk)
 {
-	struct sockaddr *csin;
+	struct sockaddr_storage *csin;
 	int rc = 0;
 	struct tcp_transport *t;
 	struct task_struct *handler;
diff --git a/include/linux/net.h b/include/linux/net.h
index b75bc534c1b3..e31baa3fb360 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -175,7 +175,7 @@ struct proto_ops {
 				      struct socket *newsock,
 				      struct proto_accept_arg *arg);
 	int		(*getname)   (struct socket *sock,
-				      struct sockaddr *addr,
+				      struct sockaddr_storage *addr,
 				      int peer);
 	__poll_t	(*poll)	     (struct file *file, struct socket *sock,
 				      struct poll_table_struct *wait);
@@ -353,8 +353,8 @@ int kernel_listen(struct socket *sock, int backlog);
 int kernel_accept(struct socket *sock, struct socket **newsock, int flags);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags);
-int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
-int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
+int kernel_getsockname(struct socket *sock, struct sockaddr_storage *addr);
+int kernel_getpeername(struct socket *sock, struct sockaddr_storage *addr);
 int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how);
 
 /* Routine returns the IP overhead imposed by a (caller-protected) socket. */
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5321585c778f..fde6791c1137 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -223,7 +223,7 @@ unsigned int	rpc_num_bc_slots(struct rpc_clnt *);
 void		rpc_force_rebind(struct rpc_clnt *);
 size_t		rpc_peeraddr(struct rpc_clnt *, struct sockaddr *, size_t);
 const char	*rpc_peeraddr2str(struct rpc_clnt *, enum rpc_display_format_t);
-int		rpc_localaddr(struct rpc_clnt *, struct sockaddr *, size_t);
+int		rpc_localaddr(struct rpc_clnt *, struct sockaddr_storage *, size_t);
 
 int 		rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
 			int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index c17a6585d0b0..2bc95e0171e7 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -54,7 +54,7 @@ int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 #define BIND_NO_CAP_NET_BIND_SERVICE	(1 << 3)
 int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		u32 flags);
-int inet_getname(struct socket *sock, struct sockaddr *uaddr,
+int inet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		 int peer);
 int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int inet_ctl_sock_create(struct sock **sk, unsigned short family,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 248bfb26e2af..e0ee07a8486e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1214,7 +1214,7 @@ void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
 int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
-int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
+int inet6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		  int peer);
 int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int inet6_compat_ioctl(struct socket *sock, unsigned int cmd,
diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..6ec875591415 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1819,7 +1819,7 @@ int sock_no_bind(struct socket *, struct sockaddr *, int);
 int sock_no_connect(struct socket *, struct sockaddr *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, struct proto_accept_arg *);
-int sock_no_getname(struct socket *, struct sockaddr *, int);
+int sock_no_getname(struct socket *, struct sockaddr_storage *, int);
 int sock_no_ioctl(struct socket *, unsigned int, unsigned long);
 int sock_no_listen(struct socket *, int);
 int sock_no_shutdown(struct socket *, int);
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index b068651984fe..b0a5137e9dce 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1258,7 +1258,7 @@ static int atalk_connect(struct socket *sock, struct sockaddr *uaddr,
  * Find the name of an AppleTalk socket. Just copy the right
  * fields into the sockaddr.
  */
-static int atalk_getname(struct socket *sock, struct sockaddr *uaddr,
+static int atalk_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			 int peer)
 {
 	struct sockaddr_at sat;
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 66d9a9bd5896..897b82de7a5b 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -86,7 +86,7 @@ static int pvc_getsockopt(struct socket *sock, int level, int optname,
 	return error;
 }
 
-static int pvc_getname(struct socket *sock, struct sockaddr *sockaddr,
+static int pvc_getname(struct socket *sock, struct sockaddr_storage *sockaddr,
 		       int peer)
 {
 	struct sockaddr_atmpvc *addr;
diff --git a/net/atm/svc.c b/net/atm/svc.c
index f8137ae693b0..b02f5833cc9a 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -423,7 +423,7 @@ static int svc_accept(struct socket *sock, struct socket *newsock,
 	return error;
 }
 
-static int svc_getname(struct socket *sock, struct sockaddr *sockaddr,
+static int svc_getname(struct socket *sock, struct sockaddr_storage *sockaddr,
 		       int peer)
 {
 	struct sockaddr_atmsvc *addr;
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d..e203cd453592 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1447,7 +1447,7 @@ static int ax25_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int ax25_getname(struct socket *sock, struct sockaddr *uaddr,
+static int ax25_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 	int peer)
 {
 	struct full_sockaddr_ax25 *fsa = (struct full_sockaddr_ax25 *)uaddr;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2272e1849ebd..3fe844460fc4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1478,7 +1478,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
-static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
+static int hci_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
 			    int peer)
 {
 	struct sockaddr_hci *haddr = (struct sockaddr_hci *)addr;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d5e00d0dd1a0..a1935026c931 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1213,15 +1213,15 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
-			    int peer)
+static int iso_sock_getname(struct socket *sock,
+			    struct sockaddr_storage *addr, int peer)
 {
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
 	struct sock *sk = sock->sk;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	addr->sa_family = AF_BLUETOOTH;
+	sa->iso_family = AF_BLUETOOTH;
 
 	if (peer) {
 		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee5..6a6db32a0a27 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -382,8 +382,8 @@ static int l2cap_sock_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
-			      int peer)
+static int l2cap_sock_getname(struct socket *sock,
+			      struct sockaddr_storage *addr, int peer)
 {
 	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
 	struct sock *sk = sock->sk;
@@ -397,7 +397,7 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 		return -ENOTCONN;
 
 	memset(la, 0, sizeof(struct sockaddr_l2));
-	addr->sa_family = AF_BLUETOOTH;
+	la->l2_family = AF_BLUETOOTH;
 
 	la->l2_psm = chan->psm;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..8253dd2094fc 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -529,7 +529,8 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int rfcomm_sock_getname(struct socket *sock, struct sockaddr *addr, int peer)
+static int rfcomm_sock_getname(struct socket *sock, struct sockaddr_storage *addr,
+			       int peer)
 {
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a5ac160c592e..370394d1d7fb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -701,15 +701,15 @@ static int sco_sock_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int sco_sock_getname(struct socket *sock, struct sockaddr *addr,
-			    int peer)
+static int sco_sock_getname(struct socket *sock,
+			    struct sockaddr_storage *addr, int peer)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	addr->sa_family = AF_BLUETOOTH;
+	sa->sco_family = AF_BLUETOOTH;
 
 	if (peer)
 		bacpy(&sa->sco_bdaddr, &sco_pi(sk)->dst);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16046931542a..5afb88885548 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1352,7 +1352,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	return err;
 }
 
-static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+static int isotp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
+			 int peer)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..66ea829811ab 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -598,7 +598,7 @@ static void j1939_sk_sock2sockaddr_can(struct sockaddr_can *addr,
 	}
 }
 
-static int j1939_sk_getname(struct socket *sock, struct sockaddr *uaddr,
+static int j1939_sk_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			    int peer)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/can/raw.c b/net/can/raw.c
index 00533f64d69d..8f76514dffe4 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -530,7 +530,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	return err;
 }
 
-static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
+static int raw_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		       int peer)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..ac9de043bcbf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1908,7 +1908,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	{
 		struct sockaddr_storage address;
 
-		lv = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 2);
+		lv = READ_ONCE(sock->ops)->getname(sock, &address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
@@ -3337,7 +3337,7 @@ int sock_no_accept(struct socket *sock, struct socket *newsock,
 }
 EXPORT_SYMBOL(sock_no_accept);
 
-int sock_no_getname(struct socket *sock, struct sockaddr *saddr,
+int sock_no_getname(struct socket *sock, struct sockaddr_storage *saddr,
 		    int peer)
 {
 	return -EOPNOTSUPP;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..252e43d18ff7 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -794,7 +794,7 @@ EXPORT_SYMBOL(inet_accept);
 /*
  *	This does both peername and sockname.
  */
-int inet_getname(struct socket *sock, struct sockaddr *uaddr,
+int inet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		 int peer)
 {
 	struct sock *sk		= sock->sk;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ba69b86f1c7d..3a6ba7a2fdae 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -520,7 +520,7 @@ EXPORT_SYMBOL_GPL(inet6_cleanup_sock);
 /*
  *	This does both peername and sockname.
  */
-int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
+int inet6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		  int peer)
 {
 	struct sockaddr_in6 *sin = (struct sockaddr_in6 *)uaddr;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index c00323fa9eb6..d7ee6d7b9b1c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -848,14 +848,14 @@ static int iucv_sock_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int iucv_sock_getname(struct socket *sock, struct sockaddr *addr,
-			     int peer)
+static int iucv_sock_getname(struct socket *sock,
+			     struct sockaddr_storage *addr, int peer)
 {
 	DECLARE_SOCKADDR(struct sockaddr_iucv *, siucv, addr);
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 
-	addr->sa_family = AF_IUCV;
+	siucv->sa_family = AF_IUCV;
 
 	if (peer) {
 		memcpy(siucv->siucv_user_id, iucv->dst_user_id, 8);
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 4bc24fddfd52..ed92eabb8552 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -373,7 +373,7 @@ static int l2tp_ip_disconnect(struct sock *sk, int flags)
 	return __udp_disconnect(sk, flags);
 }
 
-static int l2tp_ip_getname(struct socket *sock, struct sockaddr *uaddr,
+static int l2tp_ip_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			   int peer)
 {
 	struct sock *sk		= sock->sk;
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f4c1da070826..59a5e74b2561 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -443,7 +443,7 @@ static int l2tp_ip6_disconnect(struct sock *sk, int flags)
 	return __udp_disconnect(sk, flags);
 }
 
-static int l2tp_ip6_getname(struct socket *sock, struct sockaddr *uaddr,
+static int l2tp_ip6_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			    int peer)
 {
 	struct sockaddr_l2tpip6 *lsa = (struct sockaddr_l2tpip6 *)uaddr;
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 53baf2dd5d5d..ae1536ed5a5b 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -886,7 +886,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 /* getname() support.
  */
-static int pppol2tp_getname(struct socket *sock, struct sockaddr *uaddr,
+static int pppol2tp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			    int peer)
 {
 	int len = 0;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 4eb52add7103..9cc28550b25b 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1023,7 +1023,7 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
  *
  *	Return the address information of a socket.
  */
-static int llc_ui_getname(struct socket *sock, struct sockaddr *uaddr,
+static int llc_ui_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			  int peer)
 {
 	struct sockaddr_llc sllc;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0b7a89db3ab7..eda7f2203c6f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1128,8 +1128,8 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
-static int netlink_getname(struct socket *sock, struct sockaddr *addr,
-			   int peer)
+static int netlink_getname(struct socket *sock,
+			   struct sockaddr_storage *addr, int peer)
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 6ee148f0e6d0..637a88782292 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -835,7 +835,7 @@ static int nr_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int nr_getname(struct socket *sock, struct sockaddr *uaddr,
+static int nr_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 	int peer)
 {
 	struct full_sockaddr_ax25 *sax = (struct full_sockaddr_ax25 *)uaddr;
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 57a2f97004e1..1ba19e542320 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -500,8 +500,8 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
 	return ret;
 }
 
-static int llcp_sock_getname(struct socket *sock, struct sockaddr *uaddr,
-			     int peer)
+static int llcp_sock_getname(struct socket *sock,
+			     struct sockaddr_storage *uaddr, int peer)
 {
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index aa5e368a744a..31fdbde64998 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3639,27 +3639,28 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	return err;
 }
 
-static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
-			       int peer)
+static int packet_getname_spkt(struct socket *sock,
+			       struct sockaddr_storage *uaddr, int peer)
 {
+	struct sockaddr *addr = (struct sockaddr *)uaddr;
 	struct net_device *dev;
 	struct sock *sk	= sock->sk;
 
 	if (peer)
 		return -EOPNOTSUPP;
 
-	uaddr->sa_family = AF_PACKET;
-	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
+	addr->sa_family = AF_PACKET;
+	memset(addr->sa_data, 0, sizeof(addr->sa_data));
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
+		strscpy(addr->sa_data, dev->name, sizeof(addr->sa_data));
 	rcu_read_unlock();
 
-	return sizeof(*uaddr);
+	return sizeof(*addr);
 }
 
-static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
+static int packet_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			  int peer)
 {
 	struct net_device *dev;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 5ce0b3ee5def..711c70cc110a 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -311,17 +311,17 @@ static int pn_socket_accept(struct socket *sock, struct socket *newsock,
 	return 0;
 }
 
-static int pn_socket_getname(struct socket *sock, struct sockaddr *addr,
-				int peer)
+static int pn_socket_getname(struct socket *sock,
+			     struct sockaddr_storage *uaddr, int peer)
 {
+	struct sockaddr_pn *addr = (struct sockaddr_pn *)uaddr;
 	struct sock *sk = sock->sk;
 	struct pn_sock *pn = pn_sk(sk);
 
 	memset(addr, 0, sizeof(struct sockaddr_pn));
-	addr->sa_family = AF_PHONET;
+	addr->spn_family = AF_PHONET;
 	if (!peer) /* Race with bind() here is userland's problem. */
-		pn_sockaddr_set_object((struct sockaddr_pn *)addr,
-					pn->sobject);
+		pn_sockaddr_set_object(addr, pn->sobject);
 
 	return sizeof(struct sockaddr_pn);
 }
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00c51cf693f3..836c9a4a2119 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1115,7 +1115,7 @@ static int qrtr_connect(struct socket *sock, struct sockaddr *saddr,
 	return 0;
 }
 
-static int qrtr_getname(struct socket *sock, struct sockaddr *saddr,
+static int qrtr_getname(struct socket *sock, struct sockaddr_storage *saddr,
 			int peer)
 {
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf30..0409983eb9fb 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -697,7 +697,7 @@ int qrtr_ns_init(void)
 	if (ret < 0)
 		return ret;
 
-	ret = kernel_getsockname(qrtr_ns.sock, (struct sockaddr *)&sq);
+	ret = kernel_getsockname(qrtr_ns.sock, (struct sockaddr_storage *)&sq);
 	if (ret < 0) {
 		pr_err("failed to get socket name\n");
 		goto err_sock;
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..6d0cef028454 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -111,7 +111,7 @@ void rds_wake_sk_sleep(struct rds_sock *rs)
 	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
-static int rds_getname(struct socket *sock, struct sockaddr *uaddr,
+static int rds_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		       int peer)
 {
 	struct rds_sock *rs = rds_sk_to_rs(sock->sk);
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 59050caab65c..406c12bf35eb 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -984,7 +984,7 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static int rose_getname(struct socket *sock, struct sockaddr *uaddr,
+static int rose_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 	int peer)
 {
 	struct full_sockaddr_rose *srose = (struct full_sockaddr_rose *)uaddr;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index f7b809c0d142..b078100d5f25 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -1058,7 +1058,7 @@ static int sctp_inet6_supported_addrs(const struct sctp_sock *opt,
 }
 
 /* Handle SCTP_I_WANT_MAPPED_V4_ADDR for getpeername() and getsockname() */
-static int sctp_getname(struct socket *sock, struct sockaddr *uaddr,
+static int sctp_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			int peer)
 {
 	int rc;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0316217b7687..c3471e18a1ee 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2741,7 +2741,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
 	return rc;
 }
 
-int smc_getname(struct socket *sock, struct sockaddr *addr,
+int smc_getname(struct socket *sock, struct sockaddr_storage *addr,
 		int peer)
 {
 	struct smc_sock *smc;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index ad77d6b6b8d3..43ad7598ac19 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -48,7 +48,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
 		int alen, int flags);
 int smc_accept(struct socket *sock, struct socket *new_sock,
 	       struct proto_accept_arg *arg);
-int smc_getname(struct socket *sock, struct sockaddr *addr,
+int smc_getname(struct socket *sock, struct sockaddr_storage *addr,
 		int peer);
 __poll_t smc_poll(struct file *file, struct socket *sock,
 		  poll_table *wait);
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 33fa787c28eb..6eeb5decc51e 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -571,7 +571,7 @@ static int smc_clc_prfx_set(struct socket *clcsock,
 		goto out_rel;
 	}
 	/* get address to which the internal TCP socket is bound */
-	if (kernel_getsockname(clcsock, (struct sockaddr *)&addrs) < 0)
+	if (kernel_getsockname(clcsock, &addrs) < 0)
 		goto out_rel;
 	/* analyze IP specific data of net_device belonging to TCP socket */
 	addr6 = (struct sockaddr_in6 *)&addrs;
diff --git a/net/socket.c b/net/socket.c
index 601ad74930ef..fada898c3dfc 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1949,7 +1949,7 @@ struct file *do_accept(struct file *file, struct proto_accept_arg *arg,
 		goto out_fd;
 
 	if (upeer_sockaddr) {
-		len = ops->getname(newsock, (struct sockaddr *)&address, 2);
+		len = ops->getname(newsock, &address, 2);
 		if (len < 0) {
 			err = -ECONNABORTED;
 			goto out_fd;
@@ -2113,7 +2113,7 @@ int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 	if (err)
 		goto out_put;
 
-	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 0);
+	err = READ_ONCE(sock->ops)->getname(sock, &address, 0);
 	if (err < 0)
 		goto out_put;
 	/* "err" is actually length in this case */
@@ -2153,7 +2153,7 @@ int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 			return err;
 		}
 
-		err = ops->getname(sock, (struct sockaddr *)&address, 1);
+		err = ops->getname(sock, &address, 1);
 		if (err >= 0)
 			/* "err" is actually length in this case */
 			err = move_addr_to_user(&address, err, usockaddr,
@@ -3658,7 +3658,7 @@ EXPORT_SYMBOL(kernel_connect);
  *	Returns the length of the address in bytes or an error code.
  */
 
-int kernel_getsockname(struct socket *sock, struct sockaddr *addr)
+int kernel_getsockname(struct socket *sock, struct sockaddr_storage *addr)
 {
 	return READ_ONCE(sock->ops)->getname(sock, addr, 0);
 }
@@ -3673,7 +3673,7 @@ EXPORT_SYMBOL(kernel_getsockname);
  *	Returns the length of the address in bytes or an error code.
  */
 
-int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
+int kernel_getpeername(struct socket *sock, struct sockaddr_storage *addr)
 {
 	return READ_ONCE(sock->ops)->getname(sock, addr, 1);
 }
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c3..8af253f5ad08 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1445,7 +1445,7 @@ static const struct sockaddr_in6 rpc_in6addr_loopback = {
  * negative errno is returned.
  */
 static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
-			struct sockaddr *buf)
+			struct sockaddr_storage *buf)
 {
 	struct socket *sock;
 	int err;
@@ -1490,7 +1490,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 	}
 
 	err = 0;
-	if (buf->sa_family == AF_INET6) {
+	if (buf->ss_family == AF_INET6) {
 		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)buf;
 		sin6->sin6_scope_id = 0;
 	}
@@ -1510,7 +1510,7 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
  * Returns zero and fills in "buf" if successful; otherwise, a
  * negative errno is returned.
  */
-static int rpc_anyaddr(int family, struct sockaddr *buf, size_t buflen)
+static int rpc_anyaddr(int family, struct sockaddr_storage *buf, size_t buflen)
 {
 	switch (family) {
 	case AF_INET:
@@ -1550,7 +1550,8 @@ static int rpc_anyaddr(int family, struct sockaddr *buf, size_t buflen)
  * succession may give different results, depending on how local
  * networking configuration changes over time.
  */
-int rpc_localaddr(struct rpc_clnt *clnt, struct sockaddr *buf, size_t buflen)
+int rpc_localaddr(struct rpc_clnt *clnt, struct sockaddr_storage *buf,
+		  size_t buflen)
 {
 	struct sockaddr_storage address;
 	struct sockaddr *sap = (struct sockaddr *)&address;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 825ec5357691..dcd4a32b4250 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -903,7 +903,7 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 
 	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 
-	err = kernel_getpeername(newsock, sin);
+	err = kernel_getpeername(newsock, &addr);
 	if (err < 0) {
 		trace_svcsock_getpeername_err(xprt, serv->sv_name, err);
 		goto failed;		/* aborted connection or whatever */
@@ -925,7 +925,7 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	if (IS_ERR(newsvsk))
 		goto failed;
 	svc_xprt_set_remote(&newsvsk->sk_xprt, sin, slen);
-	err = kernel_getsockname(newsock, sin);
+	err = kernel_getsockname(newsock, &addr);
 	slen = err;
 	if (unlikely(err < 0))
 		slen = offsetof(struct sockaddr, sa_data);
@@ -1478,7 +1478,7 @@ int svc_addsock(struct svc_serv *serv, struct net *net, const int fd,
 		err = PTR_ERR(svsk);
 		goto out;
 	}
-	salen = kernel_getsockname(svsk->sk_sock, sin);
+	salen = kernel_getsockname(svsk->sk_sock, &addr);
 	if (salen >= 0)
 		svc_xprt_set_local(&svsk->sk_xprt, sin, salen);
 	svsk->sk_xprt.xpt_cred = get_cred(cred);
@@ -1545,7 +1545,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	if (error < 0)
 		goto bummer;
 
-	error = kernel_getsockname(sock, newsin);
+	error = kernel_getsockname(sock, &addr);
 	if (error < 0)
 		goto bummer;
 	newlen = error;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0e1691316f42..1b071359defb 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1708,7 +1708,7 @@ static unsigned short xs_sock_getport(struct socket *sock)
 	struct sockaddr_storage buf;
 	unsigned short port = 0;
 
-	if (kernel_getsockname(sock, (struct sockaddr *)&buf) < 0)
+	if (kernel_getsockname(sock, &buf) < 0)
 		goto out;
 	switch (buf.ss_family) {
 	case AF_INET6:
@@ -1777,7 +1777,7 @@ static int xs_sock_srcaddr(struct rpc_xprt *xprt, char *buf, size_t buflen)
 
 	mutex_lock(&sock->recv_mutex);
 	if (sock->sock) {
-		ret = kernel_getsockname(sock->sock, &saddr.sa);
+		ret = kernel_getsockname(sock->sock, &saddr.st);
 		if (ret >= 0)
 			ret = snprintf(buf, buflen, "%pISc", &saddr.sa);
 	}
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 65dcbb54f55d..56f609c7f2a6 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -741,7 +741,7 @@ static int tipc_bind(struct socket *sock, struct sockaddr *skaddr, int alen)
  *       accesses socket information that is unchanging (or which changes in
  *       a completely predictable manner).
  */
-static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
+static int tipc_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 			int peer)
 {
 	struct sockaddr_tipc *addr = (struct sockaddr_tipc *)uaddr;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 001ccc55ef0f..0f71ed2f35e7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -813,7 +813,7 @@ static int unix_stream_connect(struct socket *, struct sockaddr *,
 			       int addr_len, int flags);
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, struct proto_accept_arg *arg);
-static int unix_getname(struct socket *, struct sockaddr *, int);
+static int unix_getname(struct socket *, struct sockaddr_storage *, int);
 static __poll_t unix_poll(struct file *, struct socket *, poll_table *);
 static __poll_t unix_dgram_poll(struct file *, struct socket *,
 				    poll_table *);
@@ -1789,7 +1789,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 }
 
 
-static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+static int unix_getname(struct socket *sock, struct sockaddr_storage *uaddr,
+			int peer)
 {
 	struct sock *sk = sock->sk;
 	struct unix_address *addr;
@@ -1817,10 +1818,10 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 		memcpy(sunaddr, addr->name, addr->len);
 
 		if (peer)
-			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)uaddr, &err,
 					       CGROUP_UNIX_GETPEERNAME);
 		else
-			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
+			BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)uaddr, &err,
 					       CGROUP_UNIX_GETSOCKNAME);
 	}
 	sock_put(sk);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 35681adedd9a..ee8542bb274e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -927,7 +927,7 @@ vsock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 }
 
 static int vsock_getname(struct socket *sock,
-			 struct sockaddr *addr, int peer)
+			 struct sockaddr_storage *addr, int peer)
 {
 	int err;
 	struct sock *sk;
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 8dda4178497c..f97876d30935 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -913,7 +913,7 @@ static int x25_accept(struct socket *sock, struct socket *newsock,
 	return rc;
 }
 
-static int x25_getname(struct socket *sock, struct sockaddr *uaddr,
+static int x25_getname(struct socket *sock, struct sockaddr_storage *uaddr,
 		       int peer)
 {
 	struct sockaddr_x25 *sx25 = (struct sockaddr_x25 *)uaddr;
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 8dc61335f65e..450fd7a37ca4 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -658,8 +658,7 @@ int tomoyo_socket_listen_permission(struct socket *sock)
 	if (!family || (type != SOCK_STREAM && type != SOCK_SEQPACKET))
 		return 0;
 	{
-		const int error = sock->ops->getname(sock, (struct sockaddr *)
-						     &addr, 0);
+		const int error = sock->ops->getname(sock, &addr, 0);
 
 		if (error < 0)
 			return error;
-- 
2.34.1


