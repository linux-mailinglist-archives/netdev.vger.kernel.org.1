Return-Path: <netdev+bounces-130487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8E98AAED
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3591F2363A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63574198A32;
	Mon, 30 Sep 2024 17:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD418E354
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716681; cv=none; b=tmJKeZgwZraYQkkGaNEct3Liv3BhgTuI5NBxOdL+hLPk/emWAiwEMHIxbmNx38VN1hR1RzE3iBCWcPg0pdwH/B2PpD6hvfne7N5mjFBeURxCMc75hFCDGcehSNJiRsXJfbBrZFqp+q29srQekV1mpCBFI4TTWX+sSIw2f/Px1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716681; c=relaxed/simple;
	bh=9G6Zt3N0zb9smhrarp/q8rteUqcKdV3Z3Z9rNCBNVMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp/l17TPUZODwcmGb+KAQQjkadQDAveCzhZ1P3rR8w8ouN9uZA2AfJEEySB5H4LCPrjt4UUsuMHLxMaxUVMsxJPWlLlS7IBOVzLSrYLbkUD5/y0R2GZHCbGun7JiLNcV+AIVG4RKuzCt5nhS3E9ioOaZL3lZrVtguhPdWObalKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso3994616a91.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716678; x=1728321478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0RPDPuJyfg+QyBf02JgJt7NjOIlGo2fb6qUMubteQs=;
        b=e8K//mEtY0PlIVZLiFUhrJ7Ce9yoN4NH8tnaQI+1yZ/NRz7KdrVEEXYSVZHzTwSd31
         L88HIY6Pzj3t1+j12fuxBKjBENATP+AaKbYF7guv17rLYVdiOJZIwNvBfKkgXfgyhREe
         qmj0Bu5FP9/rReq+JhXkGN7E0wOmKI0tkbyJB4Q3EFrS4t3vcI0LVHe37Xj8RryVvLVW
         N3FHnxhxeSfL5E0le3OM33PBG1wYk3vu68BvDpd/ffMoxHEmEt46bnSEAHfawtCPhicW
         FqjIN6dG6H+ykpp3JOnuXzQV1Inc2AfpFySsnJUpfPLE2RfgTVrKd5l8a0PVOEFPhR6a
         DDaA==
X-Gm-Message-State: AOJu0YzkzVPaSwGSiDp4hEwUkOE9ie1jRdrBVSJ3rkRobBKwG2Ep5yHj
	Tq7AtDsmbmhOKXVI9FdiM+ZI3p/HkP/Ir9ojZhSxUcBhMcQNaAdkNbtp
X-Google-Smtp-Source: AGHT+IH1EyvvRePHhicm/03Vf3yhel/XIzwttgravrxGHBalOlh1Z1NJh2kC94m7Jn2IN0/Qh7sbXA==
X-Received: by 2002:a17:90a:8a8e:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2e0b8b1dbb9mr14672650a91.22.1727716678420;
        Mon, 30 Sep 2024 10:17:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c9d354sm8250256a91.25.2024.09.30.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:17:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 02/12] selftests: ncdevmem: Separate out dmabuf provider
Date: Mon, 30 Sep 2024 10:17:43 -0700
Message-ID: <20240930171753.2572922-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So we can plug the other ones in the future if needed.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 215 +++++++++++++++----------
 1 file changed, 134 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 9245d3f158dd..557175c3bf02 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -71,17 +71,118 @@ static char *ifname = "eth1";
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
-void print_bytes(void *ptr, size_t size)
+struct memory_buffer {
+	int fd;
+	size_t size;
+
+	int devfd;
+	int memfd;
+	char *buf_mem;
+};
+
+struct memory_provider {
+	struct memory_buffer *(*alloc)(size_t size);
+	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
+				 void *src, int n);
+	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
+				   size_t off, int n);
+};
+
+static struct memory_buffer *udmabuf_alloc(size_t size)
 {
-	unsigned char *p = ptr;
-	int i;
+	struct udmabuf_create create;
+	struct memory_buffer *ctx;
+	int ret;
 
-	for (i = 0; i < size; i++)
-		printf("%02hhX ", p[i]);
-	printf("\n");
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		error(1, ENOMEM, "malloc failed");
+
+	ctx->size = size;
+
+	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	if (ctx->devfd < 0)
+		error(1, errno,
+		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		      TEST_PREFIX);
+
+	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (ctx->memfd < 0)
+		error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+
+	ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0)
+		error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+
+	ret = ftruncate(ctx->memfd, size);
+	if (ret == -1)
+		error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = ctx->memfd;
+	create.offset = 0;
+	create.size = size;
+	ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
+	if (ctx->fd < 0)
+		error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+
+	ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			    ctx->fd, 0);
+	if (ctx->buf_mem == MAP_FAILED)
+		error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
+
+	return ctx;
+}
+
+static void udmabuf_free(struct memory_buffer *ctx)
+{
+	munmap(ctx->buf_mem, ctx->size);
+	close(ctx->fd);
+	close(ctx->memfd);
+	close(ctx->devfd);
+	free(ctx);
+}
+
+static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
+				     void *src, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst->buf_mem + off, src, n);
+
+	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
+	ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
+}
+
+static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
+				       size_t off, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst, src->buf_mem + off, n);
+
+	sync.flags = DMA_BUF_SYNC_END;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
 }
 
-void print_nonzero_bytes(void *ptr, size_t size)
+static struct memory_provider udmabuf_memory_provider = {
+	.alloc = udmabuf_alloc,
+	.free = udmabuf_free,
+	.memcpy_to_device = udmabuf_memcpy_to_device,
+	.memcpy_from_device = udmabuf_memcpy_from_device,
+};
+
+static struct memory_provider *provider = &udmabuf_memory_provider;
+
+static void print_nonzero_bytes(void *ptr, size_t size)
 {
 	unsigned char *p = ptr;
 	unsigned int i;
@@ -201,42 +302,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
-static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
-{
-	struct udmabuf_create create;
-	int ret;
-
-	*devfd = open("/dev/udmabuf", O_RDWR);
-	if (*devfd < 0) {
-		error(70, 0,
-		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-		      TEST_PREFIX);
-	}
-
-	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
-	if (*memfd < 0)
-		error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
-
-	/* Required for udmabuf */
-	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
-	if (ret < 0)
-		error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
-
-	ret = ftruncate(*memfd, dmabuf_size);
-	if (ret == -1)
-		error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
-
-	memset(&create, 0, sizeof(create));
-
-	create.memfd = *memfd;
-	create.offset = 0;
-	create.size = dmabuf_size;
-	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
-	if (*buf < 0)
-		error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
-}
-
-int do_server(void)
+int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -244,23 +310,18 @@ int do_server(void)
 	struct sockaddr_in client_addr;
 	struct sockaddr_in server_sin;
 	size_t page_aligned_frags = 0;
-	int devfd, memfd, buf, ret;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
 	bool is_devmem = false;
-	char *buf_mem = NULL;
+	char *tmp_mem = NULL;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
 	char iobuf[819200];
 	char buffer[256];
 	int socket_fd;
 	int client_fd;
 	size_t i = 0;
 	int opt = 1;
-
-	dmabuf_size = getpagesize() * NUM_PAGES;
-
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	int ret;
 
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
@@ -284,13 +345,12 @@ int do_server(void)
 		queues[i].id = start_queue + i;
 	}
 
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
-	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-		       buf, 0);
-	if (buf_mem == MAP_FAILED)
-		error(1, 0, "mmap()");
+	tmp_mem = malloc(mem->size);
+	if (!tmp_mem)
+		error(1, ENOMEM, "malloc failed");
 
 	server_sin.sin_family = AF_INET;
 	server_sin.sin_port = htons(atoi(port));
@@ -341,7 +401,6 @@ int do_server(void)
 		struct iovec iov = { .iov_base = iobuf,
 				     .iov_len = sizeof(iobuf) };
 		struct dmabuf_cmsg *dmabuf_cmsg = NULL;
-		struct dma_buf_sync sync = { 0 };
 		struct cmsghdr *cm = NULL;
 		struct msghdr msg = { 0 };
 		struct dmabuf_token token;
@@ -410,22 +469,17 @@ int do_server(void)
 			else
 				page_aligned_frags++;
 
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+			provider->memcpy_from_device(tmp_mem, mem,
+						     dmabuf_cmsg->frag_offset,
+						     dmabuf_cmsg->frag_size);
 
 			if (do_validation)
 				validate_buffer(
-					((unsigned char *)buf_mem) +
+					((unsigned char *)tmp_mem) +
 						dmabuf_cmsg->frag_offset,
 					dmabuf_cmsg->frag_size);
 			else
-				print_nonzero_bytes(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
-
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+				print_nonzero_bytes(tmp_mem, dmabuf_cmsg->frag_size);
 
 			ret = setsockopt(client_fd, SOL_SOCKET,
 					 SO_DEVMEM_DONTNEED, &token,
@@ -450,12 +504,9 @@ int do_server(void)
 
 cleanup:
 
-	munmap(buf_mem, dmabuf_size);
+	free(tmp_mem);
 	close(client_fd);
 	close(socket_fd);
-	close(buf);
-	close(memfd);
-	close(devfd);
 	ynl_sock_destroy(ys);
 
 	return 0;
@@ -464,14 +515,11 @@ int do_server(void)
 void run_devmem_tests(void)
 {
 	struct netdev_queue_id *queues;
-	int devfd, memfd, buf;
+	struct memory_buffer *mem;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
 	size_t i = 0;
 
-	dmabuf_size = getpagesize() * NUM_PAGES;
-
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
 
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
@@ -482,7 +530,7 @@ void run_devmem_tests(void)
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Binding empty queues array should have failed\n");
 
 	for (i = 0; i < num_queues; i++) {
@@ -495,7 +543,7 @@ void run_devmem_tests(void)
 	if (configure_headersplit(0))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Configure dmabuf with header split off should have failed\n");
 
 	if (configure_headersplit(1))
@@ -508,7 +556,7 @@ void run_devmem_tests(void)
 		queues[i].id = start_queue + i;
 	}
 
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
 	/* Deactivating a bound queue should not be legal */
@@ -517,11 +565,15 @@ void run_devmem_tests(void)
 
 	/* Closing the netlink socket does an implicit unbind */
 	ynl_sock_destroy(ys);
+
+	provider->free(mem);
 }
 
 int main(int argc, char *argv[])
 {
+	struct memory_buffer *mem;
 	int is_server = 0, opt;
+	int ret;
 
 	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
 		switch (opt) {
@@ -562,8 +614,9 @@ int main(int argc, char *argv[])
 
 	run_devmem_tests();
 
-	if (is_server)
-		return do_server();
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
+	ret = is_server ? do_server(mem) : 1;
+	provider->free(mem);
 
-	return 0;
+	return ret;
 }
-- 
2.46.0


