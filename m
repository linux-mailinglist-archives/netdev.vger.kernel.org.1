Return-Path: <netdev+bounces-81067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759A885A47
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AAB283210
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5384FD4;
	Thu, 21 Mar 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+eJFsu3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7484FAB;
	Thu, 21 Mar 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029927; cv=none; b=GQx2dAgH6tFHkDehTEHC1EzZBvQX/fuNS6eHIXpVZYN/2TzP3ewOZkj+rBV26ME760ClMpizpF4lHEocUl9e0WoFDHsZm/HzNXJNQAHul2p+BR/lezk/uw/fgF5bfDeAREoulLJliiiQPmxQXmVV7bh3F20qYAWom5r6gEUE9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029927; c=relaxed/simple;
	bh=hBmhM4yNE9bIwRPkbyIQxY1VuKDep4BXHxhqAzHSN3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdoMk5oJLBiyxOUBnU7ALODffgumX0BCReD+qsDm4sBlelnub1jNYieyGQigD3FD88hUemzKJtYp7Cxvltgfn7x3H98b6uaO3z230qk6aMb2qem04hfOV6kYsr3FIVXjaPfEgdsfU/NB+v8EtqRRVmunLYVMfIzQehsTL58IhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+eJFsu3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029925; x=1742565925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBmhM4yNE9bIwRPkbyIQxY1VuKDep4BXHxhqAzHSN3c=;
  b=W+eJFsu3AhJF/zO8puG2NgmmwX9sMs+w1mf/ilgCvVO5flsSLxnox9ig
   66IXsVHmdDoH+kcveWS4m8z8T9I3RWLPHvvxiQqsD8ov5f9sXteX8+f/j
   lk0ksZQf+fkIcHqWi1jYW2G7jiYo+N4NFGdUxY8+CVTEGC4LTQ/EfCW1q
   yY18DpE907dj+U5pE4I/gTP4WrVh1/S5ugUdgzOUYaqGQ6pwnEel8AwkH
   1KhJkRkNw0e32sJ8C6Q9GTefmpGzT5lbkgTt8A0Alpq7HbsOVa4YyEqwV
   oWJE2oB1IKHfKe8+jNg5WJr+quJK063bKnEBhd2VrXwlICquNc9vdleKD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5910946"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5910946"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911304"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:21 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v2 2/7] selftests/xsk: make batch size variable
Date: Thu, 21 Mar 2024 13:49:06 +0000
Message-Id: <20240321134911.120091-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321134911.120091-1-tushar.vyavahare@intel.com>
References: <20240321134911.120091-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the constant BATCH_SIZE into a variable named batch_size to allow
dynamic modification at runtime. This is required for the forthcoming
changes to support testing different hardware ring sizes.

While running these tests, a bug [1] was identified when the batch size is
roughly the same as the NIC ring size. This has now been addressed by
Maciej's fix.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=913eda2b08cc49d31f382579e2be34c2709eb789

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 20 +++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index b1102ee13faa..eaa102c8098b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -239,7 +239,7 @@ static void enable_busy_poll(struct xsk_socket_info *xsk)
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
 
-	sock_opt = BATCH_SIZE;
+	sock_opt = xsk->batch_size;
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL_BUDGET,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
 		exit_with_error(errno);
@@ -439,6 +439,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
 			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			ifobj->xsk_arr[j].batch_size = DEFAULT_BATCH_SIZE;
 			if (i == 0)
 				ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
 			else
@@ -1087,7 +1088,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			return TEST_CONTINUE;
 	}
 
-	rcvd = xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
+	rcvd = xsk_ring_cons__peek(&xsk->rx, xsk->batch_size, &idx_rx);
 	if (!rcvd)
 		return TEST_CONTINUE;
 
@@ -1239,7 +1240,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 
 	buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
 	/* pkts_in_flight might be negative if many invalid packets are sent */
-	if (pkts_in_flight >= (int)((umem_size(umem) - BATCH_SIZE * buffer_len) / buffer_len)) {
+	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
+	    buffer_len)) {
 		ret = kick_tx(xsk);
 		if (ret)
 			return TEST_FAILURE;
@@ -1249,7 +1251,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 	fds.fd = xsk_socket__fd(xsk->xsk);
 	fds.events = POLLOUT;
 
-	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
+	while (xsk_ring_prod__reserve(&xsk->tx, xsk->batch_size, &idx) < xsk->batch_size) {
 		if (use_poll) {
 			ret = poll(&fds, 1, POLL_TMOUT);
 			if (timeout) {
@@ -1269,10 +1271,10 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			}
 		}
 
-		complete_pkts(xsk, BATCH_SIZE);
+		complete_pkts(xsk, xsk->batch_size);
 	}
 
-	for (i = 0; i < BATCH_SIZE; i++) {
+	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
 		u32 nb_frags_left, nb_frags, bytes_written = 0;
 
@@ -1280,9 +1282,9 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			break;
 
 		nb_frags = pkt_nb_frags(umem->frame_size, pkt_stream, pkt);
-		if (nb_frags > BATCH_SIZE - i) {
+		if (nb_frags > xsk->batch_size - i) {
 			pkt_stream_cancel(pkt_stream);
-			xsk_ring_prod__cancel(&xsk->tx, BATCH_SIZE - i);
+			xsk_ring_prod__cancel(&xsk->tx, xsk->batch_size - i);
 			break;
 		}
 		nb_frags_left = nb_frags;
@@ -1370,7 +1372,7 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 		}
 
-		complete_pkts(xsk, BATCH_SIZE);
+		complete_pkts(xsk, xsk->batch_size);
 	}
 
 	return TEST_PASS;
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index f174df2d693f..425304e52f35 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -44,7 +44,7 @@
 #define MAX_ETH_JUMBO_SIZE 9000
 #define USLEEP_MAX 10000
 #define SOCK_RECONF_CTR 10
-#define BATCH_SIZE 64
+#define DEFAULT_BATCH_SIZE 64
 #define POLL_TMOUT 1000
 #define THREAD_TMOUT 3
 #define DEFAULT_PKT_CNT (4 * 1024)
@@ -91,6 +91,7 @@ struct xsk_socket_info {
 	struct pkt_stream *pkt_stream;
 	u32 outstanding_tx;
 	u32 rxqsize;
+	u32 batch_size;
 	u8 dst_mac[ETH_ALEN];
 	u8 src_mac[ETH_ALEN];
 };
-- 
2.34.1


