Return-Path: <netdev+bounces-281729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIBJCbt38GlgTwEAu9opvQ
	(envelope-from <netdev+bounces-281729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:02:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74E480D34
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AEA3187D8A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D83D649F;
	Tue, 28 Apr 2026 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIKNYYSq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA000392C56;
	Tue, 28 Apr 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365974; cv=none; b=oG001NDOzZYGJ5GYd8VeSpaNIDk7mnKTcYU/cH7Ctip6LS2Z6U4TBlqKM48jKuDhw0YSG9e4ZUluFZL1eIpt1Re/aXJwHEEbW9dSSSz1S9xQCXZ5GbGmwDnPhDA1yg4KFlN7mDCR6eHLSGC4LSjW03/xTEhwvrzEIpbrlEtDYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365974; c=relaxed/simple;
	bh=+WT5r0CvnqnNYuw1gNdsdQzzpiO7VxeA7OPxGvWUWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX1DL7+5bbKmbV2kdkYiev4XQDktUFtLwK6Du62xrfYsczVW2TQEcD/w0PObOdWMtfjgg4H3ZZICaD0ucVuJcfQ2gsvJFcdpwaWpvPmCHrCTEYHStCXDKk/fya2/rnjdJ+cwbxqazrElYE3EDOtd5RpMAJnffeMJihyI3b8UZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIKNYYSq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365973; x=1808901973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WT5r0CvnqnNYuw1gNdsdQzzpiO7VxeA7OPxGvWUWJs=;
  b=dIKNYYSqnuwSRKT/qg6Oa+OwDXQG86pPmlSZpUgPuecsb29yahohCmj5
   eLOYG309i8MhMGTDDfZaTFMNcPYzsQHvBXTSR18fajOYk1AoSKlvuZQqM
   WoKXn9WdBjsF/huvYH0AF9CdBwaGc8UYqysBB+sTMunCFYA1zUbnmueCj
   nuSf0p9B0jYUnxzwNr6LdMJsfvzTJBcwrrGvmSfbeI0qaY7HB8EPwg1Mr
   qaWE9bKU339WoraNMhogF4Ls2BIa9MoWyiGMtCWAsFHYg4i+v7f64xhQH
   wz4xJERlD6mAICAEsGdfSzJvx6u5ADAzNQhHaTEK9Mg6Nd1Z+osVVAAGX
   w==;
X-CSE-ConnectionGUID: 3uvIY10ESN2EFvddxX64yA==
X-CSE-MsgGUID: A2FfoD9qTiSAnmPrUDKK/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433259"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:12 -0700
X-CSE-ConnectionGUID: KWSbMBNDRWqoZnIpYCpeaQ==
X-CSE-MsgGUID: AxRUI5lCR1W97O6tdYokJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027316"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:08 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH 2/5] selftests/xsk: Eliminate umem reference from ifobject
Date: Tue, 28 Apr 2026 13:33:13 +0530
Message-ID: <20260428080317.702124-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080317.702124-1-tushar.vyavahare@intel.com>
References: <20260428080317.702124-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A74E480D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Each AF_XDP socket is associated with a UMEM, but ifobject currently
keeps only a single ifobject-level UMEM reference. That makes it awkward
to model cases where multiple sockets on the same interface eventually
need distinct UMEM instances.

Move UMEM storage into xsk_socket_info and keep xsk_socket_info::umem as
the active pointer used by the code paths. For now, all sockets on an
interface still point at the first socket's UMEM, which preserves
existing behaviour while removing the ifobject-level ownership.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 124 +++++++++---------
 .../selftests/bpf/prog_tests/test_xsk.h       |  32 ++---
 2 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index d5cd8f590b25..ad5ada9216fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -65,9 +65,9 @@ static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
 	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
 }
 
-static bool is_umem_valid(struct ifobject *ifobj)
+static bool is_umem_valid(struct xsk_umem_info *umem)
 {
-	return !!ifobj->umem->umem;
+	return !!umem->umem;
 }
 
 static u32 mode_to_xdp_flags(enum test_mode mode)
@@ -229,24 +229,26 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->tx_on = false;
 		}
 
-		memset(ifobj->umem, 0, sizeof(*ifobj->umem));
-		ifobj->umem->num_frames = DEFAULT_UMEM_BUFFERS;
-		ifobj->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-
 		for (j = 0; j < MAX_SOCKETS; j++) {
-			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
-			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			struct xsk_socket_info *xsk = &ifobj->xsk_arr[j];
+
+			memset(xsk, 0, sizeof(*xsk));
+			xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			xsk->umem = &ifobj->xsk_arr[0].umem_real;
 			ifobj->xsk_arr[j].batch_size = DEFAULT_BATCH_SIZE;
 			if (i == 0)
-				ifobj->xsk_arr[j].pkt_stream = test->tx_pkt_stream_default;
+				xsk->pkt_stream = test->tx_pkt_stream_default;
 			else
-				ifobj->xsk_arr[j].pkt_stream = test->rx_pkt_stream_default;
+				xsk->pkt_stream = test->rx_pkt_stream_default;
 
-			memcpy(ifobj->xsk_arr[j].src_mac, g_mac, ETH_ALEN);
-			memcpy(ifobj->xsk_arr[j].dst_mac, g_mac, ETH_ALEN);
-			ifobj->xsk_arr[j].src_mac[5] += ((j * 2) + 0);
-			ifobj->xsk_arr[j].dst_mac[5] += ((j * 2) + 1);
+			memcpy(xsk->src_mac, g_mac, ETH_ALEN);
+			memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
+			xsk->src_mac[5] += ((j * 2) + 0);
+			xsk->dst_mac[5] += ((j * 2) + 1);
 		}
+
+		ifobj->xsk->umem->num_frames = DEFAULT_UMEM_BUFFERS;
+		ifobj->xsk->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 	}
 
 	if (ifobj_tx->hw_ring_size_supp)
@@ -305,18 +307,19 @@ static void test_spec_reset(struct test_spec *test)
 
 static void test_spec_set_unaligned(struct test_spec *test)
 {
-	test_spec_set_unaligned(test);
+	test->ifobj_tx->xsk->umem->unaligned_mode = true;
+	test->ifobj_rx->xsk->umem->unaligned_mode = true;
 }
 
 static void test_spec_set_frame_size(struct test_spec *test, u32 size)
 {
-	test->ifobj_tx->umem->frame_size = size;
-	test->ifobj_rx->umem->frame_size = size;
+	test->ifobj_tx->xsk->umem->frame_size = size;
+	test->ifobj_rx->xsk->umem->frame_size = size;
 }
 
 static void test_spec_set_frame_headroom(struct test_spec *test, u32 size)
 {
-	test->ifobj_rx->umem->frame_headroom = size;
+	test->ifobj_rx->xsk->umem->frame_headroom = size;
 }
 
 static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
@@ -1007,7 +1010,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 
 		if (!ret) {
-			if (!is_umem_valid(test->ifobj_tx))
+			if (!is_umem_valid(umem))
 				return TEST_PASS;
 
 			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
@@ -1167,7 +1170,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
-	struct xsk_umem_info *umem = ifobject->umem;
+	struct xsk_umem_info *umem = xsk->umem;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
 	int ret;
@@ -1226,7 +1229,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 		while (nb_frags_left--) {
 			struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
 
-			tx_desc->addr = pkt_get_addr(pkt, ifobject->umem);
+			tx_desc->addr = pkt_get_addr(pkt, xsk->umem);
 			if (pkt_stream->verbatim) {
 				tx_desc->len = pkt->len;
 				tx_desc->options = pkt->options;
@@ -1319,7 +1322,7 @@ bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	bool timeout = !is_umem_valid(test->ifobj_rx);
+	bool timeout = !is_umem_valid(test->ifobj_rx->xsk->umem);
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
@@ -1504,14 +1507,20 @@ static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 
 static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
 {
-	int ret = xsk_configure(test, ifobject, test->ifobj_rx->umem, true);
+	struct xsk_umem_info *umem_rx;
+	int ret;
 
+	if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem ||
+	    !test->ifobj_rx->xsk_arr[0].umem->umem) {
+		ksft_print_msg("Error: RX UMEM is not initialized before shared-UMEM TX setup\n");
+		return -EINVAL;
+	}
+
+	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
+	ret = xsk_configure(test, ifobject, umem_rx, true);
 	if (ret)
 		return ret;
-	ifobject->xsk = &ifobject->xsk_arr[0];
 	ifobject->xskmap = test->ifobj_rx->xskmap;
-	memcpy(ifobject->umem, test->ifobj_rx->umem, sizeof(struct xsk_umem_info));
-	ifobject->umem->base_addr = 0;
 
 	return 0;
 }
@@ -1564,6 +1573,7 @@ static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
+	struct xsk_umem_info *umem = ifobject->xsk->umem;
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int mmap_flags;
 	u64 umem_sz;
@@ -1571,10 +1581,10 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	int ret;
 	u32 i;
 
-	umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
+	umem_sz = umem->num_frames * umem->frame_size;
 	mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 
-	if (ifobject->umem->unaligned_mode)
+	if (umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
 
 	if (ifobject->shared_umem)
@@ -1584,11 +1594,11 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (bufs == MAP_FAILED)
 		return -errno;
 
-	ret = xsk_configure_umem(ifobject, ifobject->umem, bufs, umem_sz);
+	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
 	if (ret)
 		return ret;
 
-	ret = xsk_configure(test, ifobject, ifobject->umem, false);
+	ret = xsk_configure(test, ifobject, umem, false);
 	if (ret)
 		return ret;
 
@@ -1597,21 +1607,19 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (!ifobject->rx_on)
 		return 0;
 
-	ret = xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream,
+	ret = xsk_populate_fill_ring(umem, ifobject->xsk->pkt_stream,
 				     ifobject->use_fill_ring);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < test->nb_sockets; i++) {
-		ifobject->xsk = &ifobject->xsk_arr[i];
-		ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, i);
+		ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk_arr[i].xsk, i);
 		if (ret)
 			return ret;
 	}
 
 	return 0;
 }
-
 void *worker_testapp_validate_tx(void *arg)
 {
 	struct test_spec *test = (struct test_spec *)arg;
@@ -1691,14 +1699,15 @@ void *worker_testapp_validate_rx(void *arg)
 
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
-	u64 umem_sz = ifobj->umem->num_frames * ifobj->umem->frame_size;
+	struct xsk_umem_info *umem = ifobj->xsk->umem;
+	u64 umem_sz = umem->num_frames * umem->frame_size;
 
 	if (ifobj->shared_umem)
 		umem_sz *= 2;
 
 	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
-	xsk_umem__delete(ifobj->umem->umem);
-	munmap(ifobj->umem->buffer, umem_sz);
+	xsk_umem__delete(umem->umem);
+	munmap(umem->buffer, umem_sz);
 }
 
 static void handler(int signum)
@@ -1860,9 +1869,11 @@ static int testapp_validate_traffic(struct test_spec *test)
 {
 	struct ifobject *ifobj_rx = test->ifobj_rx;
 	struct ifobject *ifobj_tx = test->ifobj_tx;
+	struct xsk_umem_info *umem_rx = ifobj_rx->xsk->umem;
+	struct xsk_umem_info *umem_tx = ifobj_tx->xsk->umem;
 
-	if ((ifobj_rx->umem->unaligned_mode && !ifobj_rx->unaligned_supp) ||
-	    (ifobj_tx->umem->unaligned_mode && !ifobj_tx->unaligned_supp)) {
+	if ((umem_rx->unaligned_mode && !ifobj_rx->unaligned_supp) ||
+	    (umem_tx->unaligned_mode && !ifobj_tx->unaligned_supp)) {
 		ksft_print_msg("No huge pages present.\n");
 		return TEST_SKIP;
 	}
@@ -1975,6 +1986,7 @@ int testapp_headroom(struct test_spec *test)
 
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
+	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
 	u32 umem_tr = test->ifobj_tx->umem_tailroom;
 
 	if (test->mode == TEST_MODE_ZC) {
@@ -1984,8 +1996,8 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 
 	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
 		return TEST_FAILURE;
-	test_spec_set_frame_headroom(test, test->ifobj_rx->umem->frame_size -
-			      XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr);
+	test_spec_set_frame_headroom(test, umem->frame_size - XDP_PACKET_HEADROOM -
+			      (MIN_PKT_SIZE * 2) - umem_tr);
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
@@ -2078,7 +2090,7 @@ int testapp_send_receive_mb(struct test_spec *test)
 
 int testapp_invalid_desc_mb(struct test_spec *test)
 {
-	struct xsk_umem_info *umem = test->ifobj_tx->umem;
+	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
 	u64 umem_size = umem->num_frames * umem->frame_size;
 	struct pkt pkts[] = {
 		/* Valid packet for synch to start with */
@@ -2119,7 +2131,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 int testapp_invalid_desc(struct test_spec *test)
 {
-	struct xsk_umem_info *umem = test->ifobj_tx->umem;
+	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
 	u64 umem_size = umem->num_frames * umem->frame_size;
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
@@ -2397,7 +2409,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 	 * the UMEM but not a page.
 	 */
 	page_size = sysconf(_SC_PAGESIZE);
-	umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
+	umem_size = test->ifobj_tx->xsk->umem->num_frames *
+		test->ifobj_tx->xsk->umem->frame_size;
 	assert(umem_size % page_size > MIN_PKT_SIZE);
 	assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
 
@@ -2455,9 +2468,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->total_steps = 2;
 	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
 	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
-	test->ifobj_rx->umem->num_frames = max_descs;
-	test->ifobj_rx->umem->fill_size = max_descs;
-	test->ifobj_rx->umem->comp_size = max_descs;
+	test->ifobj_rx->xsk->umem->num_frames = max_descs;
+	test->ifobj_rx->xsk->umem->fill_size = max_descs;
+	test->ifobj_rx->xsk->umem->comp_size = max_descs;
 	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 
@@ -2595,25 +2608,16 @@ struct ifobject *ifobject_create(void)
 		return NULL;
 
 	ifobj->xsk_arr = calloc(MAX_SOCKETS, sizeof(*ifobj->xsk_arr));
-	if (!ifobj->xsk_arr)
-		goto out_xsk_arr;
-
-	ifobj->umem = calloc(1, sizeof(*ifobj->umem));
-	if (!ifobj->umem)
-		goto out_umem;
+	if (!ifobj->xsk_arr) {
+		free(ifobj);
+		return NULL;
+	}
 
 	return ifobj;
-
-out_umem:
-	free(ifobj->xsk_arr);
-out_xsk_arr:
-	free(ifobj);
-	return NULL;
 }
 
 void ifobject_delete(struct ifobject *ifobj)
 {
-	free(ifobj->umem);
 	free(ifobj->xsk_arr);
 	free(ifobj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 1ab8aee4ce56..accda2456fe6 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -80,9 +80,25 @@ typedef int (*validation_func_t)(struct ifobject *ifobj);
 typedef void *(*thread_func_t)(void *arg);
 typedef int (*test_func_t)(struct test_spec *test);
 
+struct xsk_umem_info {
+	struct xsk_ring_prod fq;
+	struct xsk_ring_cons cq;
+	struct xsk_umem *umem;
+	u64 next_buffer;
+	u32 num_frames;
+	u32 frame_headroom;
+	void *buffer;
+	u32 frame_size;
+	u32 base_addr;
+	u32 fill_size;
+	u32 comp_size;
+	bool unaligned_mode;
+};
+
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
 	struct xsk_ring_prod tx;
+	struct xsk_umem_info umem_real;
 	struct xsk_umem_info *umem;
 	struct xsk_socket *xsk;
 	struct pkt_stream *pkt_stream;
@@ -97,21 +113,6 @@ struct xsk_socket_info {
 int kick_rx(struct xsk_socket_info *xsk);
 int kick_tx(struct xsk_socket_info *xsk);
 
-struct xsk_umem_info {
-	struct xsk_ring_prod fq;
-	struct xsk_ring_cons cq;
-	struct xsk_umem *umem;
-	u64 next_buffer;
-	u32 num_frames;
-	u32 frame_headroom;
-	void *buffer;
-	u32 frame_size;
-	u32 base_addr;
-	u32 fill_size;
-	u32 comp_size;
-	bool unaligned_mode;
-};
-
 struct set_hw_ring {
 	u32 default_tx;
 	u32 default_rx;
@@ -123,7 +124,6 @@ struct ifobject {
 	char ifname[MAX_INTERFACE_NAME_CHARS];
 	struct xsk_socket_info *xsk;
 	struct xsk_socket_info *xsk_arr;
-	struct xsk_umem_info *umem;
 	thread_func_t func_ptr;
 	validation_func_t validation_func;
 	struct xsk_xdp_progs *xdp_progs;
-- 
2.43.0


