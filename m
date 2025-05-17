Return-Path: <netdev+bounces-191272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6ADABA80F
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A66C1BC2355
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E613633F;
	Sat, 17 May 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NG7q6UBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFD15B971
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747454020; cv=none; b=KdU1McyH+dJ37rp+2YsWcpduiEOj2z8KhRlFDXImL0Gvi+zoSau5nyyQ9rI/O9ZqGaPFkhSfu1dD+i+OsDXSEbxMrHYKiSydZiZj95peaq/CnfNyZcpiNouKDzg3hog485jt466XaV251TBz0a0OzZ9SSYuHQG1Xtf0LE8RXpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747454020; c=relaxed/simple;
	bh=yS0LHTUHjZeufGohZ/G1LkLYzmVuC8hQGvqm+fnY0h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cq8ffpivvFfecmiBO5vnb89y7qTkGYW0yX9cpoaP36rz7DHp3Gze6b6MCWhmC6Xd0k4zzB8R3hvg4YqJfze7S9Xu1WzBQswyxLTGVHvtrwa+UJpm7hRdaPy+yXRjGt+WOHsRw7pKPqf3dTm6hTigdBowmHA4S0kj4Pgn03Vi/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NG7q6UBm; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747454019; x=1778990019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mr+HGfc/NDHwPhm1cPT7tfkvFkLNtbK2fi3H5uBrWE=;
  b=NG7q6UBm2dGfp/RuZ5OolLpOASHzt3O6OguPW0t77RrKRpyQunS2p22F
   RlFOuKdSf6gz2qxQID9/nCjH364w8bCB2xW9zKNgZEHMX6UjbjY4/LEUf
   Hgv9UW4ULGS4Jn1dp1t8jvSCrl1VlrT/2TJtkfRwot24asRZGi0MzcjCV
   CrbtCXBCOJKGKduPB0sJoItCo0XmyE6cEydhQYLNlv5IbQrXdcE2NKCF3
   brQU5rTm+znz6HD2UalwiffzKwfQdf7vpGe2TFZTCqnrTjDXPOoiwjbYO
   Jo4q0bJRe4YBzWKe3SkxowWKnsIXT2NAU6DMEKdZPIGZ5cOI9Fu29J/3u
   w==;
X-IronPort-AV: E=Sophos;i="6.15,295,1739836800"; 
   d="scan'208";a="521458795"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 03:53:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:6576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.20:2525] with esmtp (Farcaster)
 id 1aaedcd2-cc5a-40ae-954a-e5bf231bd456; Sat, 17 May 2025 03:53:33 +0000 (UTC)
X-Farcaster-Flow-ID: 1aaedcd2-cc5a-40ae-954a-e5bf231bd456
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.194.153) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 17 May 2025 03:53:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/6] socket: Replace most sock_create() calls with sock_create_kern().
Date: Fri, 16 May 2025 20:50:26 -0700
Message-ID: <20250517035120.55560-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517035120.55560-1-kuniyu@amazon.com>
References: <20250517035120.55560-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Except for only one user, sctp_do_peeloff(), all sockets created
by drivers and fs are not tied to userspace processes nor exposed
via file descriptors.

Let's use sock_create_kern() for such in-kernel use cases as CIFS
client and NFS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.c    | 6 ++++--
 drivers/infiniband/sw/siw/siw_cm.c        | 6 ++++--
 drivers/isdn/mISDN/l1oip_core.c           | 3 ++-
 drivers/nvme/target/tcp.c                 | 5 +++--
 drivers/target/iscsi/iscsi_target_login.c | 7 ++++---
 drivers/xen/pvcalls-back.c                | 6 ++++--
 fs/ocfs2/cluster/tcp.c                    | 8 +++++---
 fs/smb/server/transport_tcp.c             | 7 ++++---
 8 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e0acc185e719..cec758cec7fd 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -1026,7 +1026,8 @@ int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		return -ENOENT;
 	erdma_qp_get(qp);
 
-	ret = sock_create(AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		goto error_put_qp;
 
@@ -1305,7 +1306,8 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET)
 		return -EAFNOSUPPORT;
 
-	ret = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 708b13993fdf..bea948640aba 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1391,7 +1391,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg_qp(qp, "pd_len %d, laddr %pISp, raddr %pISp\n", pd_len, laddr,
 		   raddr);
 
-	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_kern(current->nsproxy->net_ns,
+			      v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		goto error;
 
@@ -1767,7 +1768,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET && addr_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
-	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_kern(current->nsproxy->net_ns,
+			      addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		return rv;
 
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a5ad88a960d0..1451ec859a32 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -659,7 +659,8 @@ l1oip_socket_thread(void *data)
 	allow_signal(SIGTERM);
 
 	/* create socket */
-	if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
+	if (sock_create_kern(current->nsproxy->net_ns,
+			     PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
 		printk(KERN_ERR "%s: Failed to create socket.\n", __func__);
 		ret = -EIO;
 		goto fail;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 12a5cb8641ca..4e499df746f4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2078,8 +2078,9 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       port->addr.ss_family, SOCK_STREAM,
+			       IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index c2ac9a99ebbb..c085a3aaca6e 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -796,10 +796,11 @@ int iscsit_setup_np(
 		return -EINVAL;
 	}
 
-	ret = sock_create(sockaddr->ss_family, np->np_sock_type,
-			np->np_ip_proto, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       sockaddr->ss_family, np->np_sock_type,
+			       np->np_ip_proto, &sock);
 	if (ret < 0) {
-		pr_err("sock_create() failed.\n");
+		pr_err("sock_create_kern() failed.\n");
 		return ret;
 	}
 	np->np_socket = sock;
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index fd7ed65e0197..c404678e1924 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -406,7 +406,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 	    sa->sa_family != AF_INET)
 		goto out;
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, 0, &sock);
 	if (ret < 0)
 		goto out;
 	ret = inet_stream_connect(sock, sa, req->u.connect.len, 0);
@@ -646,7 +647,8 @@ static int pvcalls_back_bind(struct xenbus_device *dev,
 		goto out;
 	}
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &map->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, 0, &map->sock);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index fce9beb214f0..491916662561 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1558,7 +1558,7 @@ static void o2net_start_connect(struct work_struct *work)
 	unsigned int nofs_flag;
 
 	/*
-	 * sock_create allocates the sock with GFP_KERNEL. We must
+	 * sock_create_kern() allocates the sock with GFP_KERNEL. We must
 	 * prevent the filesystem from being reentered by memory reclaim.
 	 */
 	nofs_flag = memalloc_nofs_save();
@@ -1600,7 +1600,8 @@ static void o2net_start_connect(struct work_struct *work)
 		goto out;
 	}
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		mlog(0, "can't create socket: %d\n", ret);
 		goto out;
@@ -1984,7 +1985,8 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 		.sin_port = port,
 	};
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while creating socket\n", ret);
 		goto out;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index abedf510899a..e1e9cbe5742f 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -427,18 +427,19 @@ static void tcp_destroy_socket(struct socket *ksmbd_socket)
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
+	ret = sock_create_kern(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
 	if (ret) {
 		if (ret != -EAFNOSUPPORT)
 			pr_err("Can't create socket for ipv6, fallback to ipv4: %d\n", ret);
-		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
-				  &ksmbd_socket);
+		ret = sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				       &ksmbd_socket);
 		if (ret) {
 			pr_err("Can't create socket for ipv4: %d\n", ret);
 			goto out_clear;
-- 
2.49.0


