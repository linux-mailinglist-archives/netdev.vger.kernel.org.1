Return-Path: <netdev+bounces-149633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF289E685A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5710916216D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34461DE4C7;
	Fri,  6 Dec 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sjqeimp+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDB1DD88F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471988; cv=none; b=l3taYmxi2XgCtsjaqPV/vdUSVo1drKK2+KUd5GcJGZLtXqh5J0Uf92shrJabhtvG98bih/hb+aJ/65BSQRTyC0Wx4038QJ7LgtA4J6W8RJ+Gde9F3yT14r9KAayKKoxIeWhTso8NuEXO1k91nyEtvrc8d0tRsPPsEaZ48U1mUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471988; c=relaxed/simple;
	bh=9jBy966EK2U3i1UcYOWDeSRoyX8cE9/IKJt0Auwa3ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEr2npkxfQlEAp5RZOKdJbNd5e3iMafgDXqLrX2ebDxdQ0G1SEANBhBJBOtdnUDXbSrs6eL+aP1p4mptg167kLmWIGGks0cyHSDW6Gkz5p6OGqUBVHI2rYCFEnTco2oUtbEk5uRjQ4E3QqvBzEZ5eDt00qppI02WzWPpu3uofR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sjqeimp+; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733471987; x=1765007987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N70hOMJe4ucPXxR/LYj695bsUdHNYg8B/HLUTY0ZbCg=;
  b=Sjqeimp+Fz/BW51iv7Wm/u0KWCg8B1q0RKlBYwFZOwwxytNKUhlRGF7H
   8pkVaEhXg6+fbjfbPkoC/SYJBRA1qNnppcARmqE6DMUM23VOKFWnQNiX+
   kGLGpL/4MUzx+bxZhpCPNkutrZYiF7J92F8vnr+jhnY8XCNjNZBC9syEl
   g=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="700866627"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:59:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:24862]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 15ac51b9-1348-4824-a6d3-92ca8d5886af; Fri, 6 Dec 2024 07:59:43 +0000 (UTC)
X-Farcaster-Flow-ID: 15ac51b9-1348-4824-a6d3-92ca8d5886af
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 07:59:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 07:59:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 13/15] socket: Use sock_create_net() instead of sock_create().
Date: Fri, 6 Dec 2024 16:55:02 +0900
Message-ID: <20241206075504.24153-14-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create() is a bad name, and no one really cares about what it's for.

In fact, except for only one user, sctp_do_peeloff(), all sockets created
by drivers and fs are not exposed to userspace via file descriptors.

Let's use sock_create_net() for such in-kernel users.

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


