Return-Path: <netdev+bounces-136298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0B9A141C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579E4283E4D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52A217300;
	Wed, 16 Oct 2024 20:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65449216A16
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110872; cv=none; b=EGjxMP2naB/EzakwhPvm3akLriQ8p72zg7CCdhwJM1HjW0A0JhSnH8tZKGaQW54C6GjOkbUZPRZ4j4ZgvhPXBN3/GlvCP7nURgOupZZEelLpB8LJrn36Xr7jWEUT8dmXIqh0GKylj/Ng2CkFj7mynUVgso53E2efU2Kpncy5kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110872; c=relaxed/simple;
	bh=lDXxHrfAyZB51i7a1SL17ZoYS2zXpxdkeVmc69zmKHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLwspzCGeB8u3pp50EI0dilHMDtBgB31tMd2qOzPzupAGyJY7o6if5BJf8k8zZoFkyxT0fkofrPt4UEzJ8ciZOmXICIt2nC1GikRG+2Nb5JJWo8g+5iF2PNbFcRzzye5n5hBMYBTk+e2n9cXtXS/qyR4q+9Ld1SXgsjwrfpoatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ce65c8e13so2343515ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110870; x=1729715670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z50qUiC3CRoH/x5qXO33Gm0c+bCScrhRnG1rJfxNs4o=;
        b=J4uf9TBMytRmn+kleATZOZeJg3YppHOmUhls4/TdGsWg6BQL8q2AnEbxMJFjdmqUtO
         pFALMrDH3/l6PcLgMDto08qSxZAXRD+cQXQiADWV7c/+wPCB5kaGW++Ml0FdtTPrRj/b
         KFs22xYF5d6Di5cog206WlCdOpfiFiK/iFczwgmJNKFFAmY/w84KxyhnaQaZtDmVmvs8
         29UkuMxN1yRvxnmkMC1jWqL5kPfG6COztns+t81XRIW/nVZqDZpyAleqHQ0VjH59/zrR
         76x4fMQP7lDmQGmD61NYZxT9CMdTwzZW+Ma2d+jhb1dQYOD2OPSaszFGFm4bDVddocO3
         s5+w==
X-Gm-Message-State: AOJu0YybtKDuSpFpGOoWwtd8hRyCfjPqomNoV6ImTqimzFd3+MiBieEv
	CsrnBd2PkqNR2PMP3ksZxKWlW6pL9gxntquFRfo1T09l268W9SrLi6MPcro=
X-Google-Smtp-Source: AGHT+IFPoWsRUWnAr7ppUswNcMtpY/BCZQ1YQjrGUZJIqYRnTQcos9nkC3Y897QQaNhWGn9ER2NSsA==
X-Received: by 2002:a17:903:2301:b0:207:1675:6709 with SMTP id d9443c01a7336-20ca1321ab8mr249072565ad.0.1729110870421;
        Wed, 16 Oct 2024 13:34:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1806c1cbsm32448815ad.307.2024.10.16.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 06/12] selftests: ncdevmem: Switch to AF_INET6
Date: Wed, 16 Oct 2024 13:34:16 -0700
Message-ID: <20241016203422.1071021-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
can be used to do v4.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 85 +++++++++++++++++---------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 776009bf1dbd..e420d5d513c8 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -242,13 +242,22 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
-static int configure_flow_steering(void)
+static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+	const char *server_addr = server_ip;
+	const char *type = "tcp6";
+
+	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
+		type = "tcp4";
+		server_addr = strrchr(server_ip, ':') + 1;
+	}
+
+	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
 			   ifname,
+			   type,
 			   client_ip ? "src-ip" : "",
 			   client_ip ?: "",
-			   server_ip,
+			   server_addr,
 			   client_ip ? "src-port" : "",
 			   client_ip ? port : "",
 			   port, start_queue);
@@ -299,13 +308,43 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int enable_reuseaddr(int fd)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	return 0;
+}
+
+static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
+{
+	int ret;
+
+	sin6->sin6_family = AF_INET6;
+	sin6->sin6_port = htons(port);
+
+	ret = inet_pton(sin6->sin6_family, str, &sin6->sin6_addr);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
 int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
-	struct sockaddr_in client_addr;
-	struct sockaddr_in server_sin;
+	struct sockaddr_in6 client_addr;
+	struct sockaddr_in6 server_sin;
 	size_t page_aligned_frags = 0;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
@@ -317,9 +356,12 @@ int do_server(struct memory_buffer *mem)
 	int socket_fd;
 	int client_fd;
 	size_t i = 0;
-	int opt = 1;
 	int ret;
 
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
+
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
@@ -328,7 +370,7 @@ int do_server(struct memory_buffer *mem)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
@@ -349,29 +391,16 @@ int do_server(struct memory_buffer *mem)
 	if (!tmp_mem)
 		error(1, ENOMEM, "malloc failed");
 
-	server_sin.sin_family = AF_INET;
-	server_sin.sin_port = htons(atoi(port));
-
-	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (socket < 0)
-		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
-
-	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (socket < 0)
 		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
-			 sizeof(opt));
-	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
-
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
-			 sizeof(opt));
+	ret = enable_reuseaddr(socket_fd);
 	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, reuseaddr]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -383,16 +412,16 @@ int do_server(struct memory_buffer *mem)
 
 	client_addr_len = sizeof(client_addr);
 
-	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
-	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+	inet_ntop(AF_INET6, &client_addr.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Got connection from %s:%d\n", buffer,
-		ntohs(client_addr.sin_port));
+		ntohs(client_addr.sin6_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
-- 
2.47.0


