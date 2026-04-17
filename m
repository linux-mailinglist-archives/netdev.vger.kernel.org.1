Return-Path: <netdev+bounces-279374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG1uLspl4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8541D5B8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1ECF301545D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EF33A9DD;
	Fri, 17 Apr 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="G/8s+cg9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTDDu937"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF4314D2D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444618; cv=none; b=DRt3M5/hPr+pVDE1jFt2oKgc00zzjAnVSO3q5qMNdLI3EB4hGi7WJ8YLyfSLQi000eoKgi0/W0Sey88CA5wTNcz98ojDyvNLZFAiATMMyE9nz4wMq8ELL4Eu7B8ORKpRXXiR+kJl54W97nHO53kn7FNq4GMFuMbEReFZVEm9qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444618; c=relaxed/simple;
	bh=AVTrAnQinRoayZa2A1sAbSI5S1Dz2F1HZn9KN7mXrxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu825xt/hoflW1UZGZ7F7Oq3EjPjmwqgL1ZAV2lKcOukZLinTIHzmtenSqrv0ICAItoaHLcO9sBPZsr3K6ei/tfYI1QrnzCAP5ERvDqwlyp9FOWMq7IjN4FgZyxJDivHGauCYtVkgDT8DEh5rBv4nkeVXyvqVBm2/dSJuE1WCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=G/8s+cg9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTDDu937; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 205741D001E8;
	Fri, 17 Apr 2026 12:50:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 12:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444615; x=
	1776531015; bh=F4cmBf+oHKHT8zGHeRU9MQ4bkTYoMyS4Sk5IEVE72Ho=; b=G
	/8s+cg9rhSzXrx0cy51ccBSTrsnD0HFmi+QAxTVMJ+ir1nFci/zRQZefuT/XTphM
	ybtnXdoucs4sKsl1KD+UOQatJw7/x/kb6dDREQ+rhJB9vl2+Qp4BwyJU/NZMYQaU
	rMMPURIgfXyhcoBhmJLMbVNhUrgdIm1ZgI33sH7U7FjwTRk1yYVQG3K578nIORfE
	+lH+tsgxuo2QfuhUxFTKRBgm5I7GFI/5JqoRN00OzxMq19nn0cKxaf7xffum1CoK
	p4kNRjqyznzJxKRtppk8X7yWlmGt0C2fnp/Lc2L7/yv+BiNin+RKkhtr4PiEXLfw
	WhRJJlURxxnRpG0XDBi7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444615; x=1776531015; bh=F
	4cmBf+oHKHT8zGHeRU9MQ4bkTYoMyS4Sk5IEVE72Ho=; b=UTDDu937bpJTgXhaL
	SdrmyOL39hfZ3QFsZe9XHpw7RTvFz8ajCemIc2FZSPbTSX613C8DTnCUJ6VSbbnk
	l7ZPXlkEWYxg+yyjOzEaSX5v3WiCpOdpCh7Asfp9uidXl2K/jZFoXxxIfNOD6t9R
	6PoxIk4Q7nGkyxn/4XJAdvL8XtwikB0YtC+Qsl8NWPqABUyEaRzAGQBjWoO6rQri
	EL9zsgrcq0Se0SfUdmAZGs8RlOZ9FABs4miP8ehXrh1YY9PcxoIUaiIjsiQ5/B91
	fyBb/dKdOJOidHMf6hXej6hyeDMQOrtRpLihxyAMG3dDgETsEsWLT2JBrTBL82Qh
	JAGSw==
X-ME-Sender: <xms:x2TiaV7OvfCzPDZsxbXaKmKcab-T0Ozww9rTmyDQ8zSa4X85Q3kXqA>
    <xme:x2TiaZ4SEC5uTokvVF8V9_xx28JR27rizAbR8g0ThfXVPzZ3rSSv4_R0AJ2Ta6WVy
    aR2ZEIOWX1_CNi_rhKR7Q_ZMMOQMTgCfQ-0_F4UPXInM0T6pAdizfDk>
X-ME-Received: <xmr:x2TiaRfvI6kuOaf5MCKVaXQcwL7HXtbSLhJNXQByPpFhm921MBpn30K86k7TFM9rEvP0qfNFDWITQDO6SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:x2TiadCEb4GrGsdZLjg6KV5yMw7d735YFO3UnO2hgVzJC2xvKoF-UQ>
    <xmx:x2TiaU-iz8okUcpiBknQISPawVWnKjhk59zSwtfgcV6TW7lAn6seLg>
    <xmx:x2TiaYJjpVeVTHN2RZVl6c9fegegBC2qPk3To1njG4UXJPtkJ6v8Xw>
    <xmx:x2Tiadg9lehvGkCvHNz_MdLNbNbll3dRHG5w6_Eue07rQdUN8uknTw>
    <xmx:x2TiaRuDMVO_pyQp4nfOVikFz9crhkcbDPBQmhB1WGqDGT7kCkvcDNXE>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:15 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 3/6] selftests: net: refactor server state into struct thread_ctx
Date: Fri, 17 Apr 2026 09:49:49 -0700
Message-ID: <b3c216ea834345dd099e245220612cb4aacdc5f6.1776444379.git.juanlu@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279374-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 22B8541D5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move server-side state (io_uring ring, zcrx area, refill ring, receive
tracking) from global variables into a local struct thread_ctx. This is
a pure refactor with no behavior change: run_server still allocates a
single context on the stack and runs single-threaded, using io_uring
accept and recvzc as before.

This prepares the ground for the multithread server support in the
following commits, which spawns N worker threads each with their own
struct thread_ctx.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 156 +++++++++---------
 1 file changed, 80 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index c15916311f0dd..8dcb2f061f00a 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -87,14 +87,18 @@ static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
 
 static char *payload;
-static void *area_ptr;
-static void *ring_ptr;
-static size_t ring_size;
-static struct io_uring_zcrx_rq rq_ring;
-static unsigned long area_token;
-static int connfd;
-static bool stop;
-static size_t received;
+
+struct thread_ctx {
+	struct io_uring		ring;
+	void			*area_ptr;
+	void			*ring_ptr;
+	size_t			ring_size;
+	struct io_uring_zcrx_rq	rq_ring;
+	unsigned long		area_token;
+	int			connfd;
+	bool			stop;
+	size_t			received;
+};
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -138,7 +142,7 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 	return ALIGN_UP(size, page_size);
 }
 
-static void setup_zcrx(struct io_uring *ring)
+static void setup_zcrx(struct thread_ctx *ctx)
 {
 	unsigned int ifindex;
 	unsigned int rq_entries = 4096;
@@ -149,44 +153,44 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "bad interface name: %s", cfg_ifname);
 
 	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE |
-				MAP_HUGETLB | MAP_HUGE_2MB,
-				-1,
-				0);
-		if (area_ptr == MAP_FAILED) {
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE |
+				     MAP_HUGETLB | MAP_HUGE_2MB,
+				     -1,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED) {
 			printf("Can't allocate huge pages\n");
 			exit(SKIP_CODE);
 		}
 	} else {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE,
-				0,
-				0);
-		if (area_ptr == MAP_FAILED)
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE,
+				     0,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED)
 			error(1, 0, "mmap(): zero copy area");
 	}
 
-	ring_size = get_refill_ring_size(rq_entries);
-	ring_ptr = mmap(NULL,
-			ring_size,
-			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE,
-			0,
-			0);
+	ctx->ring_size = get_refill_ring_size(rq_entries);
+	ctx->ring_ptr = mmap(NULL,
+			     ctx->ring_size,
+			     PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE,
+			     0,
+			     0);
 
 	struct io_uring_region_desc region_reg = {
-		.size = ring_size,
-		.user_addr = (__u64)(unsigned long)ring_ptr,
+		.size = ctx->ring_size,
+		.user_addr = (__u64)(unsigned long)ctx->ring_ptr,
 		.flags = IORING_MEM_REGION_TYPE_USER,
 	};
 
 	struct io_uring_zcrx_area_reg area_reg = {
-		.addr = (__u64)(unsigned long)area_ptr,
+		.addr = (__u64)(unsigned long)ctx->area_ptr,
 		.len = AREA_SIZE,
 		.flags = 0,
 	};
@@ -200,7 +204,7 @@ static void setup_zcrx(struct io_uring *ring)
 		.rx_buf_len = cfg_rx_buf_len,
 	};
 
-	ret = io_uring_register_ifq(ring, (void *)&reg);
+	ret = io_uring_register_ifq(&ctx->ring, (void *)&reg);
 	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
 			       ret == -ERANGE)) {
 		printf("Large chunks are not supported %i\n", ret);
@@ -209,64 +213,64 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "io_uring_register_ifq(): %d", ret);
 	}
 
-	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
-	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
-	rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ring_ptr + reg.offsets.rqes);
-	rq_ring.rq_tail = 0;
-	rq_ring.ring_entries = reg.rq_entries;
+	ctx->rq_ring.khead = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.head);
+	ctx->rq_ring.ktail = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.tail);
+	ctx->rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ctx->ring_ptr + reg.offsets.rqes);
+	ctx->rq_ring.rq_tail = 0;
+	ctx->rq_ring.ring_entries = reg.rq_entries;
 
-	area_token = area_reg.rq_area_token;
+	ctx->area_token = area_reg.rq_area_token;
 }
 
-static void add_accept(struct io_uring *ring, int sockfd)
+static void add_accept(struct thread_ctx *ctx, int sockfd)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
 	sqe->user_data = 1;
 }
 
-static void add_recvzc(struct io_uring *ring, int sockfd)
+static void add_recvzc(struct thread_ctx *ctx, int sockfd)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void add_recvzc_oneshot(struct io_uring *ring, int sockfd, size_t len)
+static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void process_accept(struct io_uring *ring, struct io_uring_cqe *cqe)
+static void process_accept(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 {
 	if (cqe->res < 0)
 		error(1, 0, "accept()");
-	if (connfd)
+	if (ctx->connfd)
 		error(1, 0, "Unexpected second connection");
 
-	connfd = cqe->res;
+	ctx->connfd = cqe->res;
 	if (cfg_oneshot)
-		add_recvzc_oneshot(ring, connfd, page_size);
+		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
 	else
-		add_recvzc(ring, connfd);
+		add_recvzc(ctx, ctx->connfd);
 }
 
-static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
+static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 {
-	unsigned rq_mask = rq_ring.ring_entries - 1;
+	unsigned rq_mask = ctx->rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
 	uint64_t mask;
@@ -275,7 +279,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
-		stop = true;
+		ctx->stop = true;
 		return;
 	}
 
@@ -284,56 +288,56 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 
 	if (cfg_oneshot) {
 		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
-			add_recvzc_oneshot(ring, connfd, page_size);
+			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
 			cfg_oneshot_recvs--;
 		}
 	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
-		add_recvzc(ring, connfd);
+		add_recvzc(ctx, ctx->connfd);
 	}
 
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
 
 	n = cqe->res;
 	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
-	data = (char *)area_ptr + (rcqe->off & mask);
+	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
 	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(received + i)])
+		if (*(data + i) != payload[(ctx->received + i)])
 			error(1, 0, "payload mismatch at %d", i);
 	}
-	received += n;
+	ctx->received += n;
 
-	rqe = &rq_ring.rqes[(rq_ring.rq_tail & rq_mask)];
-	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | area_token;
+	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
+	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
 	rqe->len = cqe->res;
-	io_uring_smp_store_release(rq_ring.ktail, ++rq_ring.rq_tail);
+	io_uring_smp_store_release(ctx->rq_ring.ktail, ++ctx->rq_ring.rq_tail);
 }
 
-static void server_loop(struct io_uring *ring)
+static void server_loop(struct thread_ctx *ctx)
 {
 	struct io_uring_cqe *cqe;
 	unsigned int count = 0;
 	unsigned int head;
 	int i, ret;
 
-	io_uring_submit_and_wait(ring, 1);
+	io_uring_submit_and_wait(&ctx->ring, 1);
 
-	io_uring_for_each_cqe(ring, head, cqe) {
+	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
 		if (cqe->user_data == 1)
-			process_accept(ring, cqe);
+			process_accept(ctx, cqe);
 		else if (cqe->user_data == 2)
-			process_recvzc(ring, cqe);
+			process_recvzc(ctx, cqe);
 		else
 			error(1, 0, "unknown cqe");
 		count++;
 	}
-	io_uring_cq_advance(ring, count);
+	io_uring_cq_advance(&ctx->ring, count);
 }
 
 static void run_server(void)
 {
+	struct thread_ctx ctx = {};
 	unsigned int flags = 0;
-	struct io_uring ring;
 	int fd, enable, ret;
 	uint64_t tstop;
 
@@ -359,19 +363,19 @@ static void run_server(void)
 	flags |= IORING_SETUP_SUBMIT_ALL;
 	flags |= IORING_SETUP_CQE32;
 
-	io_uring_queue_init(512, &ring, flags);
+	io_uring_queue_init(512, &ctx.ring, flags);
 
-	setup_zcrx(&ring);
+	setup_zcrx(&ctx);
 	if (cfg_dry_run)
 		return;
 
-	add_accept(&ring, fd);
+	add_accept(&ctx, fd);
 
 	tstop = gettimeofday_ms() + 5000;
-	while (!stop && gettimeofday_ms() < tstop)
-		server_loop(&ring);
+	while (!ctx.stop && gettimeofday_ms() < tstop)
+		server_loop(&ctx);
 
-	if (!stop)
+	if (!ctx.stop)
 		error(1, 0, "test failed\n");
 }
 
-- 
2.52.0


