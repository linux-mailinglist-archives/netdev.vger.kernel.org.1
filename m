Return-Path: <netdev+bounces-279376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMO+GOtl4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF04541D5C6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAACC302AD2D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1F33A9DD;
	Fri, 17 Apr 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Wi5wNiUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZet4TOe"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7534362120
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444624; cv=none; b=pUv9USuaHUsihzuiGo70OyM6hEFzsWw3rS+zfVXnUuwgQ6HgorGkOtC07IfpchvjnOmwjWCqkumF1K3XJG8mRGNJNnfZoxmTmnvYKzfcKGJeG19DmMpKJrwEGKsxZDfkP8VLUHF+K7/PAq17njCV4ySKgwYL1wghV2qkxX/UnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444624; c=relaxed/simple;
	bh=GZS9GEVplUbshrDsI21Qe5d90AZxlBbbsTCSt246YRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwfqLMdgqfzkYoCN82KPgL6PMDuztm9+X/PSaQYiBDMyRZMJgn1g+5BhSRv50rGaDjIi1Jzq9ZteCMSQeQEaAU+HwEyyf47SayhaxMZCuAKK/bvJWBaxmNgrAJqy5RlC8QZ7Yriu/FLA02WzoyOUFM80Mx3heCax4chj5pOn0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Wi5wNiUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZet4TOe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 44F221D001F0;
	Fri, 17 Apr 2026 12:50:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 17 Apr 2026 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444622; x=
	1776531022; bh=uXLeK9v52V9B+aoimP1PKVR2eeQoQNIajvbKbXvlUi0=; b=W
	i5wNiUn65F5p54N6wjprL6LH5r80D1K8eriYkEinKkihDGhtnz4ZdXslszqqyu7z
	vluPVqcdMdSymIKimzmM4vltV/mTbz6HiBWXvqaJh/GvCSaRTdjtywa0Udv5H7ri
	MzPwFjjsfMICP+L3YVDY12T60zhaiTy0fUG3T46scwHpXYS4TIR0StlPocruK2G/
	p81ExD7F04afQ1P//l6w/Aon3JoKJxy2VngRCc71wIY/dYxvcqSVrjAxbBHjCGsu
	lZLnsKH4vIGy841oiIbuQSqsT/9YBFtweRT3+OSqAZcKj2DyvFuKSDyzbEWTuJMz
	Lld8nVJbfYbSXsdXAhWhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444622; x=1776531022; bh=u
	XLeK9v52V9B+aoimP1PKVR2eeQoQNIajvbKbXvlUi0=; b=qZet4TOepz4gd7VXP
	BmRzAvyvkQocr1pHISODHByqSDMRLoZdQe+pjMRmbIXQX+JQ7gmvnaTBGYDXUFoA
	iYXVmXdDMM08g+iqnsGI652aa1Y/oGxi04xt+ODkMGN4qc4R6SEVLC1J4BCT3Pv/
	1lcIQ/u2DitPxJLi+HDiLmTH/eNk8dBs+yaV2UCKUsjQ65S9nmwvzcPBbeMhj1t3
	RZhS4fS8ZUNT65woN0Xq2M+KknjMoHC+JmpJWVGKuHxzOUn7rKiGr9/KQanSxOpD
	+kk6EPYPnRlutHWgyMlqtgHCHmVL3xyfaDOcFzBwx2/upKj8rmWqzFwI8AutItE8
	4/L6Q==
X-ME-Sender: <xms:zmTiaRp9YwqJUzbBu36K5Dx8K5dAqNMfY0umCgV4zdj2VkE1-OHyYA>
    <xme:zmTiaapg6BGJqlyD24rDmhkr-RyRe6o19bbAwSHY9K1gvi6Qtf4-Cga8QWB6YZwqn
    EAGwNw9n7pFqjBrs8RSRVEKnZBlr67Vq-1eJylPPXCWENiYkR6Z3HA>
X-ME-Received: <xmr:zmTiaTPya106CB1U2wgB7mt_HSTHoctXfj3z1Ceu1z5evdICg_MkoxAJOFwIBoVZTJp2gG-gHyE2JfAG5zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugif
    segurghvihgufigvihdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zmTiabz_sxwCBUnXGZzLOFcJ8sjswRCfsZaBu2laha556y-wWPguEg>
    <xmx:zmTiacsA-GYB8l74NdtYPZqL2nYdkULsvztJD4VkxX79-tDySPjvHA>
    <xmx:zmTiaU4GCbzls-9hxeYAjjpGVSz6v0hHv4YwOWpuKhW2YUwjqR32xg>
    <xmx:zmTiabTWVCfLwF_i_NtfubNyIda6mVbSchq07DVpNCHUE2SQszgraA>
    <xmx:zmTiaZerHZ0yzpovlVNqDJMe9UemkdyBU9SMeC9xpPSRVXN8Zxf5NknN>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:21 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 5/6] selftests: net: add multithread server support to iou-zcrx
Date: Fri, 17 Apr 2026 09:49:51 -0700
Message-ID: <92d2cd96e0f392a6882bd770887742668d71965a.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com> <cover.1776444379.git.juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279376-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid]
X-Rspamd-Queue-Id: AF04541D5C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a multithreaded server with a two-phase architecture: a main thread
runs an epoll loop on the listening socket and dispatches each accepted
connfd to a worker thread by direct array assignment. After the accept
loop ends, a barrier release lets each worker submit one
IORING_OP_RECV_ZC SQE per assigned connfd (tagged with a connection
index in user_data) and process completions in its own io_uring CQE
loop. Each per-worker connfd array has a single writer (main, before
barrier) and a single reader (the worker, after barrier), so no
eventfd, mutex, or queue is required.

With multiple queues, connections are dispatched to the correct worker
by SO_INCOMING_NAPI_ID using a NAPI-ID-to-thread lookup table populated
via a new -n option.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 238 +++++++++++++-----
 1 file changed, 171 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 6eb738ef4b5cc..03ae5228cb5a4 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -87,8 +87,15 @@ static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
 static int cfg_num_threads = 1;
+static int cfg_napi_ids[64];
+static int cfg_num_napi_ids;
 
 static char *payload;
+static pthread_barrier_t barrier;
+
+#define MAX_CONNS_PER_WORKER	64
+#define FIRST_ACCEPT_TIMEOUT_MS	4000
+#define ACCEPT_TIMEOUT_MS	200
 
 struct thread_ctx {
 	struct io_uring		ring;
@@ -97,9 +104,11 @@ struct thread_ctx {
 	size_t			ring_size;
 	struct io_uring_zcrx_rq	rq_ring;
 	unsigned long		area_token;
-	int			connfd;
-	bool			stop;
-	size_t			received;
+	int			queue_id;
+
+	int			connfds[MAX_CONNS_PER_WORKER];
+	size_t			received[MAX_CONNS_PER_WORKER];
+	int			nr_conns;
 };
 
 static unsigned long gettimeofday_ms(void)
@@ -199,7 +208,7 @@ static void setup_zcrx(struct thread_ctx *ctx)
 
 	struct t_io_uring_zcrx_ifq_reg reg = {
 		.if_idx = ifindex,
-		.if_rxq = cfg_queue_id,
+		.if_rxq = ctx->queue_id,
 		.rq_entries = rq_entries,
 		.area_ptr = (__u64)(unsigned long)&area_reg,
 		.region_ptr = (__u64)(unsigned long)&region_reg,
@@ -224,53 +233,32 @@ static void setup_zcrx(struct thread_ctx *ctx)
 	ctx->area_token = area_reg.rq_area_token;
 }
 
-static void add_accept(struct thread_ctx *ctx, int sockfd)
+static void add_recvzc(struct thread_ctx *ctx, int conn_idx)
 {
 	struct io_uring_sqe *sqe;
 
 	sqe = io_uring_get_sqe(&ctx->ring);
 
-	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
-	sqe->user_data = 1;
-}
-
-static void add_recvzc(struct thread_ctx *ctx, int sockfd)
-{
-	struct io_uring_sqe *sqe;
-
-	sqe = io_uring_get_sqe(&ctx->ring);
-
-	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
+	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
+			 NULL, 0, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
-	sqe->user_data = 2;
+	sqe->user_data = conn_idx;
 }
 
-static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
+static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
 {
 	struct io_uring_sqe *sqe;
 
 	sqe = io_uring_get_sqe(&ctx->ring);
 
-	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
+	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, ctx->connfds[conn_idx],
+			 NULL, len, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
-	sqe->user_data = 2;
+	sqe->user_data = conn_idx;
 }
 
-static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
-{
-	if (cqe->res < 0)
-		error(1, 0, "accept()");
-	if (ctx->connfd)
-		error(1, 0, "Unexpected second connection");
-
-	ctx->connfd = cqe->res;
-	if (cfg_oneshot)
-		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
-	else
-		add_recvzc(ctx, ctx->connfd);
-}
-
-static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
+static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
+			   int conn_idx)
 {
 	unsigned rq_mask = ctx->rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
@@ -281,7 +269,7 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
-		ctx->stop = true;
+		ctx->nr_conns--;
 		return;
 	}
 
@@ -290,11 +278,11 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 
 	if (cfg_oneshot) {
 		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
-			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
+			add_recvzc_oneshot(ctx, conn_idx, page_size);
 			cfg_oneshot_recvs--;
 		}
 	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
-		add_recvzc(ctx, ctx->connfd);
+		add_recvzc(ctx, conn_idx);
 	}
 
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
@@ -304,10 +292,10 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
 	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(ctx->received + i)])
+		if (*(data + i) != payload[(ctx->received[conn_idx] + i)])
 			error(1, 0, "payload mismatch at %d", i);
 	}
-	ctx->received += n;
+	ctx->received[conn_idx] += n;
 
 	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
 	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
@@ -320,28 +308,80 @@ static void server_loop(struct thread_ctx *ctx)
 	struct io_uring_cqe *cqe;
 	unsigned int count = 0;
 	unsigned int head;
-	int i, ret;
 
 	io_uring_submit_and_wait(&ctx->ring, 1);
 
 	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
-		if (cqe->user_data == 1)
-			process_accept(ctx, cqe);
-		else if (cqe->user_data == 2)
-			process_recvzc(ctx, cqe);
-		else
-			error(1, 0, "unknown cqe");
+		process_recvzc(ctx, cqe, cqe->user_data);
 		count++;
 	}
 	io_uring_cq_advance(&ctx->ring, count);
 }
 
-static void run_server(void)
+static void *server_worker(void *arg)
 {
-	struct thread_ctx ctx = {};
+	struct thread_ctx *ctx = arg;
 	unsigned int flags = 0;
-	int fd, enable, ret;
 	uint64_t tstop;
+	int i;
+
+	flags |= IORING_SETUP_COOP_TASKRUN;
+	flags |= IORING_SETUP_SINGLE_ISSUER;
+	flags |= IORING_SETUP_DEFER_TASKRUN;
+	flags |= IORING_SETUP_SUBMIT_ALL;
+	flags |= IORING_SETUP_CQE32;
+
+	io_uring_queue_init(512, &ctx->ring, flags);
+	setup_zcrx(ctx);
+
+	pthread_barrier_wait(&barrier);
+
+	if (cfg_dry_run)
+		return NULL;
+
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < ctx->nr_conns; i++) {
+		if (cfg_oneshot)
+			add_recvzc_oneshot(ctx, i, page_size);
+		else
+			add_recvzc(ctx, i);
+	}
+
+	tstop = gettimeofday_ms() + 5000;
+	while (ctx->nr_conns > 0 && gettimeofday_ms() < tstop)
+		server_loop(ctx);
+
+	if (ctx->nr_conns != 0)
+		error(1, 0, "test failed: %d connections incomplete",
+		      ctx->nr_conns);
+
+	return NULL;
+}
+
+static int find_thread_by_napi(int napi_id)
+{
+	int i;
+
+	for (i = 0; i < cfg_num_napi_ids; i++) {
+		if (cfg_napi_ids[i] == napi_id)
+			return i;
+	}
+	return -1;
+}
+
+static void run_server(void)
+{
+	struct epoll_event ev = { .events = EPOLLIN };
+	int timeout_ms = FIRST_ACCEPT_TIMEOUT_MS;
+	struct thread_ctx *ctxs;
+	pthread_t *threads;
+	int fd, epfd, ret, enable, i;
+
+	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
+	threads = calloc(cfg_num_threads, sizeof(*threads));
+	if (!ctxs || !threads)
+		error(1, 0, "calloc()");
 
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
@@ -359,26 +399,78 @@ static void run_server(void)
 	if (listen(fd, 1024) < 0)
 		error(1, 0, "listen()");
 
-	flags |= IORING_SETUP_COOP_TASKRUN;
-	flags |= IORING_SETUP_SINGLE_ISSUER;
-	flags |= IORING_SETUP_DEFER_TASKRUN;
-	flags |= IORING_SETUP_SUBMIT_ALL;
-	flags |= IORING_SETUP_CQE32;
+	pthread_barrier_init(&barrier, NULL, cfg_num_threads + 1);
 
-	io_uring_queue_init(512, &ctx.ring, flags);
+	for (i = 0; i < cfg_num_threads; i++)
+		ctxs[i].queue_id = cfg_queue_id + i;
+
+	for (i = 0; i < cfg_num_threads; i++) {
+		ret = pthread_create(&threads[i], NULL, server_worker, &ctxs[i]);
+		if (ret)
+			error(1, ret, "pthread_create()");
+	}
+
+	pthread_barrier_wait(&barrier);
 
-	setup_zcrx(&ctx);
 	if (cfg_dry_run)
-		return;
+		goto join;
 
-	add_accept(&ctx, fd);
+	epfd = epoll_create1(0);
+	if (epfd < 0)
+		error(1, errno, "epoll_create1()");
 
-	tstop = gettimeofday_ms() + 5000;
-	while (!ctx.stop && gettimeofday_ms() < tstop)
-		server_loop(&ctx);
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) < 0)
+		error(1, errno, "epoll_ctl()");
+
+	while (1) {
+		struct epoll_event out_ev;
+		int nfds, idx, connfd;
+
+		nfds = epoll_wait(epfd, &out_ev, 1, timeout_ms);
+		if (nfds < 0)
+			error(1, errno, "epoll_wait()");
+		if (nfds == 0)
+			break;
+		timeout_ms = ACCEPT_TIMEOUT_MS;
+
+		connfd = accept(fd, NULL, NULL);
+		if (connfd < 0)
+			error(1, errno, "accept()");
+
+		if (cfg_num_napi_ids > 0) {
+			int napi_id;
+			socklen_t len = sizeof(napi_id);
+
+			ret = getsockopt(connfd, SOL_SOCKET,
+					 SO_INCOMING_NAPI_ID,
+					 &napi_id, &len);
+			if (ret < 0)
+				error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
+
+			idx = find_thread_by_napi(napi_id);
+			if (idx < 0)
+				error(1, 0, "unknown NAPI ID: %d", napi_id);
+		} else {
+			idx = 0;
+		}
+
+		if (ctxs[idx].nr_conns >= MAX_CONNS_PER_WORKER)
+			error(1, 0, "worker %d connection overflow", idx);
+		ctxs[idx].connfds[ctxs[idx].nr_conns++] = connfd;
+	}
 
-	if (!ctx.stop)
-		error(1, 0, "test failed\n");
+	close(epfd);
+
+	pthread_barrier_wait(&barrier);
+
+join:
+	for (i = 0; i < cfg_num_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	pthread_barrier_destroy(&barrier);
+	close(fd);
+	free(threads);
+	free(ctxs);
 }
 
 static void *client_worker(void *arg)
@@ -438,8 +530,8 @@ static void run_client(void)
 static void usage(const char *filepath)
 {
 	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
-		    filepath);
+		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads> "
+		    "-n<napi_id_csv>", filepath);
 }
 
 static void parse_opts(int argc, char **argv)
@@ -457,7 +549,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:n:")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -501,6 +593,18 @@ static void parse_opts(int argc, char **argv)
 		case 't':
 			cfg_num_threads = strtoul(optarg, NULL, 0);
 			break;
+		case 'n': {
+			char *tok, *str = optarg;
+
+			cfg_num_napi_ids = 0;
+			while ((tok = strsep(&str, ",")) != NULL) {
+				if (cfg_num_napi_ids >= 64)
+					error(1, 0, "too many NAPI IDs");
+				cfg_napi_ids[cfg_num_napi_ids++] =
+					strtoul(tok, NULL, 0);
+			}
+			break;
+		}
 		}
 	}
 
-- 
2.52.0


