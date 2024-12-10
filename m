Return-Path: <netdev+bounces-150551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891C9EA9F5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EE18816FE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DDE23497E;
	Tue, 10 Dec 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T/liWnVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB3230D1E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816604; cv=none; b=fjw+ElNg7r2zs23lEinoxPfDdz/Q9EwgAcDDRtZFO2xWkgRHR49uFU86xjYD8asMJgt85VsfLVml5KqQ9NTrJTZLcLciKCzqPQxigaugQ0wXa/ufNcDARj9tSjWgJCVzFEZK0H/1lwuG7zFJ6PiStY4lrc79ZXTYIDtSj10ZVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816604; c=relaxed/simple;
	bh=pK1v2YUk9ACHGzg/MMQWeDpMNB7G2J6Er9NdUV6RJ6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcVN54wDQvZliYiBm+xolXRM4Le88tOT63rtvgTwh+lvhhI4YkSEH1ve8M8zsWLRDdTk4HLy6SnRAh0hFXoOo1e7kDoAZzQF9SvQ/TFfg8bx3p+jQ03PWFfYgvtdQuZgRC4Vyxamj3yB9qFX2EUV+57VkX9eCdfKoOwtvo3EQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T/liWnVg; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733816599; x=1765352599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEnDyHprgAdeGVlkRNXITlI1yxsxgw6PFUhnNDUNZSU=;
  b=T/liWnVg00ErL0SYhhCmYa4uLPAF5y0hp+36dPDFa2E3YmTRi8CM96id
   7JIxbQAZQivWAJHh0JJv+XTZu3bQkFRMQ2HDzpYjHKtta4Y3MeraaZnrk
   pGl1bmbMSIaT3wBPOp8R7wtAa8LvQmNv3le46D+LSHMWI5d5lwAQQv3L2
   o=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="253616463"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 07:43:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:2137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.76:2525] with esmtp (Farcaster)
 id 184efc24-f9fb-4613-886f-0cc9d8a2385e; Tue, 10 Dec 2024 07:43:14 +0000 (UTC)
X-Farcaster-Flow-ID: 184efc24-f9fb-4613-886f-0cc9d8a2385e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 07:43:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 07:43:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 13/15] socket: Use sock_create_net() instead of sock_create().
Date: Tue, 10 Dec 2024 16:38:27 +0900
Message-ID: <20241210073829.62520-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
References: <20241210073829.62520-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create() is a bad name, and no one really cares about what it's for.

In fact, except for only one user, sctp_do_peeloff(), all sockets created
by drivers and fs are not tied to userspace processes nor exposed via file
descriptors.

Let's use sock_create_net() for such in-kernel use cases.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.c    | 6 ++++--
 drivers/infiniband/sw/siw/siw_cm.c        | 6 ++++--
 drivers/isdn/mISDN/l1oip_core.c           | 3 ++-
 drivers/nvme/host/tcp.c                   | 5 +++--
 drivers/nvme/target/tcp.c                 | 5 +++--
 drivers/target/iscsi/iscsi_target_login.c | 7 ++++---
 drivers/xen/pvcalls-back.c                | 6 ++++--
 fs/ocfs2/cluster/tcp.c                    | 8 +++++---
 fs/smb/server/transport_tcp.c             | 7 ++++---
 9 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 771059a8eb7d..5014237127cb 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -1023,7 +1023,8 @@ int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		return -ENOENT;
 	erdma_qp_get(qp);
 
-	ret = sock_create(AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		goto error_put_qp;
 
@@ -1299,7 +1300,8 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET)
 		return -EAFNOSUPPORT;
 
-	ret = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 86323918a570..4c8f0e3ec0ce 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1391,7 +1391,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg_qp(qp, "pd_len %d, laddr %pISp, raddr %pISp\n", pd_len, laddr,
 		   raddr);
 
-	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_net(current->nsproxy->net_ns,
+			     v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		goto error;
 
@@ -1766,7 +1767,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET && addr_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
-	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_net(current->nsproxy->net_ns,
+			     addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		return rv;
 
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a5ad88a960d0..04733bcc8d07 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -659,7 +659,8 @@ l1oip_socket_thread(void *data)
 	allow_signal(SIGTERM);
 
 	/* create socket */
-	if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
+	if (sock_create_net(current->nsproxy->net_ns,
+			    PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
 		printk(KERN_ERR "%s: Failed to create socket.\n", __func__);
 		ret = -EIO;
 		goto fail;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..67cc56471e2a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1682,8 +1682,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      ctrl->addr.ss_family, SOCK_STREAM,
+			      IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..dff8c56d1783 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2042,8 +2042,9 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      port->addr.ss_family, SOCK_STREAM,
+			      IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 90b870f234f0..b7135b6d96d7 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -837,10 +837,11 @@ int iscsit_setup_np(
 		return -EINVAL;
 	}
 
-	ret = sock_create(sockaddr->ss_family, np->np_sock_type,
-			np->np_ip_proto, &sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      sockaddr->ss_family, np->np_sock_type,
+			      np->np_ip_proto, &sock);
 	if (ret < 0) {
-		pr_err("sock_create() failed.\n");
+		pr_err("sock_create_net() failed.\n");
 		return ret;
 	}
 	np->np_socket = sock;
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index f0f8b4862983..83b6bfff5cd4 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -406,7 +406,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 	    sa->sa_family != AF_INET)
 		goto out;
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      AF_INET, SOCK_STREAM, 0, &sock);
 	if (ret < 0)
 		goto out;
 	ret = inet_stream_connect(sock, sa, req->u.connect.len, 0);
@@ -647,7 +648,8 @@ static int pvcalls_back_bind(struct xenbus_device *dev,
 		goto out;
 	}
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &map->sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      AF_INET, SOCK_STREAM, 0, &map->sock);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 6ef03a02d19b..9e0571ec3ca1 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1558,7 +1558,7 @@ static void o2net_start_connect(struct work_struct *work)
 	unsigned int nofs_flag;
 
 	/*
-	 * sock_create allocates the sock with GFP_KERNEL. We must
+	 * sock_create_net() allocates the sock with GFP_KERNEL. We must
 	 * prevent the filesystem from being reentered by memory reclaim.
 	 */
 	nofs_flag = memalloc_nofs_save();
@@ -1600,7 +1600,8 @@ static void o2net_start_connect(struct work_struct *work)
 		goto out;
 	}
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		mlog(0, "can't create socket: %d\n", ret);
 		goto out;
@@ -1986,7 +1987,8 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 		.sin_port = port,
 	};
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_net(current->nsproxy->net_ns,
+			      PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while creating socket\n", ret);
 		goto out;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 0d9007285e30..ada40b0502a1 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -423,18 +423,19 @@ static void tcp_destroy_socket(struct socket *ksmbd_socket)
  */
 static int create_socket(struct interface *iface)
 {
+	struct net *net = current->nsproxy->net_ns;
 	int ret;
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct socket *ksmbd_socket;
 	bool ipv4 = false;
 
-	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
+	ret = sock_create_net(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
 	if (ret) {
 		if (ret != -EAFNOSUPPORT)
 			pr_err("Can't create socket for ipv6, fallback to ipv4: %d\n", ret);
-		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
-				  &ksmbd_socket);
+		ret = sock_create_net(net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				      &ksmbd_socket);
 		if (ret) {
 			pr_err("Can't create socket for ipv4: %d\n", ret);
 			goto out_clear;
-- 
2.39.5 (Apple Git-154)


