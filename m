Return-Path: <netdev+bounces-276645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD15NfWF1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:44:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDA3BF063
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D63A30CE999
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7973D34A8;
	Wed,  8 Apr 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ifO5vo3J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0zlo+RD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762F3D3336
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666326; cv=none; b=sDjCsBI5khxICop5urS4vtOgyz942smUObIDh04qWECgm1yoXa27MlR+68+xAJQEGIS8Zr086NCoW/jpAF3dbHJ9/80PBFn8hObAwXIKB6WONJIWNMpjC2H7ck7YRidH5lqYdPOg3wJVuD+nHw2lAX1Wr+s7Zl5kcCWOeLeTX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666326; c=relaxed/simple;
	bh=85dPqa6q4XV4ZHGUP+QhKB8Mu+nYJz12lyXXceDStwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVuSgEA7kQoX9yrFg9/sqPQxSPDzOjCTjtvQvS/2IR20xyfhWB6V/08nuCJmQw2vjmkKylsLqYO0HUYJhBkSlSPgP29+coD//83ZRLeBXOaKhMyZiqeEyAW//xbO4bIW6IOcYZ5uOBegLQPRDpCJNS/t37m70BqSGoz3USUGadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ifO5vo3J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0zlo+RD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BCF0140007D;
	Wed,  8 Apr 2026 12:38:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 12:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775666324; x=
	1775752724; bh=N3wQ8vNfH3W9BEuk25UTZCIBMjxXTjt1yUn5vkHE3d0=; b=i
	fO5vo3JxASTqJ1Qg/mgPM0VGuv5MVjNWdJYsCljp2Gljh3WFEKSyspwD7yDvd3dV
	i2EK8XUxLg57HzqncLhogWUZsVFQeoxQVSZiBcNltZfgniBfVeQsKZm3Fr+y2XD6
	ngzTTqd+GaMk+3k7fQ5f/BnMc5YUE3mQ8Jc+r0uZG+lrlDywihYm2ECB3rHxZuEX
	AGDJACab93+uViatJX80ZYOF9D9F3FMoVWs13RT+y8G9Riq6wMWwVwM63/3Iq6ta
	n5meJb9QXI/wjYWAzbJVIQX6gHFjmQBBtF8jOtO3+dXkcRQi1qPc1GjZ27NfuK82
	+SyCkA0lFE2ciJ6WDGFRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775666324; x=1775752724; bh=N
	3wQ8vNfH3W9BEuk25UTZCIBMjxXTjt1yUn5vkHE3d0=; b=e0zlo+RDfWidxw5a6
	nUTs9fZ301fkPON0tEmTG0fGBwr/BxS6sy904/K8pLErMdsu3f1U1bR/NjalbX6n
	8HHZqly9g6yQwO0vwWRakHQ8zlW4+LMouSkZ3R7qbb6Oo2t0G94xK/GB3SzhyORG
	3Z4nnINqFjOQDN19h9bkf6/r2nhuvxx37o2L1jfKxLZtrI/YsdOFeR4OdShot6ZW
	dLsz113K8TFtGkTYTPwpHDlPlDuK6cZFu9Os/D4ICcS4iooNUS4w1tL/tdTOVeUv
	4zECM3xZDnzyYCj/IebZiCF2sJD10tTb/J4B9jiCqUiESXTAvN1ZpGBfEw99kG4q
	oHwRw==
X-ME-Sender: <xms:lITWaVCTZ1BOie3oH_YNOmB7D1DcWwovN-D_ijC-k_oJjGue7DX9jA>
    <xme:lITWaZg4x1DaKIx6onb9wIS2DQ13l58Vg_JJdGZ3FopMwMtwazr0Qj8WcwSGzKMkd
    CRTIScos9wM89SD0yeCMyTCM-lY4g8tSXOgbf7HjbaC9rcm9Sr3qvm9>
X-ME-Received: <xmr:lITWaeOeFJLn5hXSTxfIHqdpvJqcCslgtZK114hMgsAwJbO86mkE0eAjBFdvPV8gi8p6ULLrxmuVZ6ah7OPQNp9PrxA9JKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhuse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:lITWaa7hpTTF4MKurhwPjqXx1HzcLf-mKI3hZWOzPwv2_QKnYArMhg>
    <xmx:lITWac3okU3bRuUCi_WAItpKRSDwEy24YM9o_m9tQNivGOp_HnrCHg>
    <xmx:lITWabY43B4cyjmXgo9bU1tN4Ua53B0BS4D-B1B0a4mnT3V7QwoP1w>
    <xmx:lITWaUBcFPbtHFnNFzwCSjhTX44co7GfUyJDoJcAfPfEzoHOrpH3Kg>
    <xmx:lITWaYaJGMMsIzWkf73M7hnjwIM-eCIUmSVJi2FclGxsPmolwSvck5U7>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:43 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 5/5] selftests: net: add rss_multiqueue test variant to iou-zcrx
Date: Wed,  8 Apr 2026 11:38:16 -0500
Message-ID: <20260408163816.2760-6-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
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
	FREEMAIL_CC(0.00)[fastmail.com];
	TAGGED_FROM(0.00)[bounces-276645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:dkim,fastmail.com:email,fastmail.com:mid,messagingengine.com:dkim,cfg.target:url]
X-Rspamd-Queue-Id: 36FDA3BF063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add multi-port support to the iou-zcrx test binary and a new
rss_multiqueue Python test variant that exercises multi-queue zero-copy
receive with per-port flow rule steering.

In multi-port mode, the server creates N listening sockets on
consecutive ports (cfg_port, cfg_port+1, ...) and uses epoll to accept
one connection per socket. Each client thread connects to its
corresponding port. Per-port ntuple flow rules steer traffic to
different NIC hardware queues, each with its own zcrx instance.

For single-thread mode (the default), behavior is unchanged: one socket
on cfg_port, one thread, one queue.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 81 ++++++++++++++-----
 .../selftests/drivers/net/hw/iou-zcrx.py      | 45 ++++++++++-
 2 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 646682167bb0..1f33d7127185 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -102,6 +102,7 @@ struct thread_ctx {
 	bool			stop;
 	size_t			received;
 	int			queue_id;
+	int			port;
 	int			thread_id;
 };
 
@@ -353,35 +354,47 @@ static void *server_worker(void *arg)
 
 static void run_server(void)
 {
+	struct epoll_event ev, events[64];
 	struct thread_ctx *ctxs;
+	struct sockaddr_in6 addr;
 	pthread_t *threads;
-	int fd, ret, i, enable;
+	int *fds;
+	int epfd, nfds, accepted;
+	int ret, i, enable;
 
 	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
 	threads = calloc(cfg_num_threads, sizeof(*threads));
-	if (!ctxs || !threads)
+	fds = calloc(cfg_num_threads, sizeof(*fds));
+	if (!ctxs || !threads || !fds)
 		error(1, 0, "calloc()");
 
-	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (fd == -1)
-		error(1, 0, "socket()");
+	for (i = 0; i < cfg_num_threads; i++) {
+		fds[i] = socket(AF_INET6, SOCK_STREAM, 0);
+		if (fds[i] == -1)
+			error(1, 0, "socket()");
+
+		enable = 1;
+		ret = setsockopt(fds[i], SOL_SOCKET, SO_REUSEADDR,
+				 &enable, sizeof(int));
+		if (ret < 0)
+			error(1, 0, "setsockopt(SO_REUSEADDR)");
 
-	enable = 1;
-	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(int));
-	if (ret < 0)
-		error(1, 0, "setsockopt(SO_REUSEADDR)");
+		addr = cfg_addr;
+		addr.sin6_port = htons(cfg_port + i);
 
-	ret = bind(fd, (struct sockaddr *)&cfg_addr, sizeof(cfg_addr));
-	if (ret < 0)
-		error(1, 0, "bind()");
+		ret = bind(fds[i], (struct sockaddr *)&addr, sizeof(addr));
+		if (ret < 0)
+			error(1, 0, "bind()");
 
-	if (listen(fd, 1024) < 0)
-		error(1, 0, "listen()");
+		if (listen(fds[i], 1024) < 0)
+			error(1, 0, "listen()");
+	}
 
 	pthread_barrier_init(&barrier, NULL, cfg_num_threads + 1);
 
 	for (i = 0; i < cfg_num_threads; i++) {
 		ctxs[i].queue_id = cfg_queue_id + i;
+		ctxs[i].port = cfg_port + i;
 		ctxs[i].thread_id = i;
 	}
 
@@ -397,12 +410,36 @@ static void run_server(void)
 	if (cfg_dry_run)
 		goto join;
 
+	epfd = epoll_create1(0);
+	if (epfd < 0)
+		error(1, 0, "epoll_create1()");
+
 	for (i = 0; i < cfg_num_threads; i++) {
-		ctxs[i].connfd = accept(fd, NULL, NULL);
-		if (ctxs[i].connfd < 0)
-			error(1, 0, "accept()");
+		ev.events = EPOLLIN;
+		ev.data.u32 = i;
+		if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[i], &ev) < 0)
+			error(1, 0, "epoll_ctl()");
 	}
 
+	accepted = 0;
+	while (accepted < cfg_num_threads) {
+		nfds = epoll_wait(epfd, events, 64, 5000);
+		if (nfds < 0)
+			error(1, 0, "epoll_wait()");
+		if (nfds == 0)
+			error(1, 0, "epoll_wait() timeout");
+
+		for (i = 0; i < nfds; i++) {
+			int idx = events[i].data.u32;
+
+			ctxs[idx].connfd = accept(fds[idx], NULL, NULL);
+			if (ctxs[idx].connfd < 0)
+				error(1, 0, "accept()");
+			accepted++;
+		}
+	}
+
+	close(epfd);
 	pthread_barrier_wait(&barrier);
 
 join:
@@ -410,23 +447,29 @@ static void run_server(void)
 		pthread_join(threads[i], NULL);
 
 	pthread_barrier_destroy(&barrier);
-	close(fd);
+	for (i = 0; i < cfg_num_threads; i++)
+		close(fds[i]);
+	free(fds);
 	free(threads);
 	free(ctxs);
 }
 
 static void *client_worker(void *arg)
 {
+	struct thread_ctx *ctx = arg;
+	struct sockaddr_in6 addr = cfg_addr;
 	ssize_t to_send = cfg_send_size;
 	ssize_t sent = 0;
 	ssize_t chunk, res;
 	int fd;
 
+	addr.sin6_port = htons(cfg_port + ctx->thread_id);
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
 		error(1, 0, "socket()");
 
-	if (connect(fd, (struct sockaddr *)&cfg_addr, sizeof(cfg_addr)))
+	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)))
 		error(1, 0, "connect()");
 
 	while (to_send) {
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index e81724cb5542..c918cdaf6b1b 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -35,6 +35,12 @@ def set_flow_rule(cfg):
     return int(values)
 
 
+def set_flow_rule_port(cfg, port, queue):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {queue}").stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
 def set_flow_rule_rss(cfg, rss_ctx_id):
     output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} context {rss_ctx_id}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
@@ -100,18 +106,51 @@ def rss(cfg):
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
 
+def rss_multiqueue(cfg):
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 3:
+        raise KsftSkipEx('Test requires NETIF with at least 3 combined channels')
+
+    rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
+    defer(mp_clear_wait, cfg)
+
+    cfg.num_threads = 2
+    cfg.target = channels - cfg.num_threads
+    ethtool(f"-X {cfg.ifname} equal {cfg.target}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    for i in range(cfg.num_threads):
+        flow_rule_id = set_flow_rule_port(cfg, cfg.port + i, cfg.target + i)
+        defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+
 @ksft_variants([
     KsftNamedVariant("single", single),
     KsftNamedVariant("rss", rss),
+    KsftNamedVariant("rss_multiqueue", rss_multiqueue),
 ])
 def test_zcrx(cfg, setup) -> None:
     cfg.require_ipver('6')
 
+    cfg.num_threads = getattr(cfg, 'num_threads', 1)
     setup(cfg)
-    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target} -t {cfg.num_threads}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840 -t {cfg.num_threads}"
     with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(cfg.port, proto="tcp")
+        for i in range(cfg.num_threads):
+            wait_port_listen(cfg.port + i, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
 
 
-- 
2.53.0


