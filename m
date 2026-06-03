Return-Path: <netdev+bounces-294591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WmGgHFvOH2qOqAAAu9opvQ
	(envelope-from <netdev+bounces-294591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2C634CFF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="m/Etxy/P";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294591-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20B5B3052608
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5D3932E8;
	Wed,  3 Jun 2026 06:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10E391E43;
	Wed,  3 Jun 2026 06:48:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469285; cv=none; b=Sc2KB516fpnohcJUQcYiK4RKezEuil70WM8zJhIut1hA1R7RCEHr6FMnupzDVGEm27F80b6nZPfgT7b2ulzKR/q4ft7GQcjEqN0xW3C1hip41SWB5EYhMEj1jFuKeJZ08okyKj2K1OWtzZf7IAPMn4gvTxFQXkV5Wyk9TfmMIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469285; c=relaxed/simple;
	bh=Elpich4eqL6Ow3PDRrQ0mJUN6dE5VocVFCC9+KB3IY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdbU2+uDxvsrkoxfPGnUBXaS2phPC9vMFz+V2sPL86//hntdh1390YFf84Ju4Bd4NcvrUjbpj5KXecYov51cEr2kka+8IwbIDh8QCKf0+Jmj/vHlrTFyPdBN6eqoJZr8uchQj1C6Nv/MdawnNEDOzbYyStT97Y9Vm16svWVnCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/Etxy/P; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469283; x=1812005283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Elpich4eqL6Ow3PDRrQ0mJUN6dE5VocVFCC9+KB3IY0=;
  b=m/Etxy/PmtPn282IWMv9UBeYSPGvIb0oQcAzeiA4Ji82tyMJeCTrl2zY
   L5Kq/0UGulrQM6VnBTX5Ljdgrnz3rBEoJyv04t2UFckpxemLBak+kiaaO
   5gb7CCk8AAGD1VAsEZtY+eBDBSHvJU0QWpdGTOskrOkDEhoTuxpHrf3pk
   2PacR1wb5ZTsfUaXTuq4AQyYVL8sq87xvgZ0D/5tPiYUeEv7vMcu8dZZo
   ATgFhxK6RyKhDqRepFGq58R1MQzgt0Kggrad6gc2CXHPIS9MxSxejeS/x
   3WS/V8vcIaZW3H+6TZ9N+vmGGoboeRWl9GP+Y75byZFf8Ooh5TMdWopnC
   Q==;
X-CSE-ConnectionGUID: g86XF6TPS+uOTEgoHjOP6A==
X-CSE-MsgGUID: S6A7LYivQX+GMeAHzHWoMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81449104"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81449104"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:48:03 -0700
X-CSE-ConnectionGUID: yEw/8gBSSuerGPRb8jTZlg==
X-CSE-MsgGUID: RtFCZzRGTjuxWH14DyySaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237778930"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:47:58 -0700
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
Subject: [PATCH net-next v2 2/4] selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
Date: Wed,  3 Jun 2026 11:33:25 +0530
Message-ID: <20260603060327.298389-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603060327.298389-1-tushar.vyavahare@intel.com>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294591-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14C2C634CFF

Move UMEM ownership from ifobject to xsk_socket_info and access it
through xsk->umem.

Allocate one shared umem_real in ifobject_create() and let all
sockets reference it through xsk->umem, while keeping ownership in
xsk_arr[0]. Keep the existing goto-based error path in
ifobject_create() and free the allocation once in ifobject_delete().

Reset the existing umem_real in __test_spec_init() with memset()
instead of reallocating it.

Preserve shared-UMEM behavior by copying RX UMEM state into a TX-local
UMEM state in thread_common_ops_tx() and reset base_addr/next_buffer
before TX socket configuration.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 133 +++++++++++-------
 .../selftests/bpf/prog_tests/test_xsk.h       |   2 +-
 2 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 3369450da974..7e0d34111b2f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -65,9 +65,9 @@ static void gen_eth_hdr(struct xsk_socket_info *xsk, struct ethhdr *eth_hdr)
 	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
 }
 
-static bool is_umem_valid(struct ifobject *ifobj)
+static bool is_umem_valid(struct xsk_socket_info *xsk)
 {
-	return !!ifobj->umem->umem;
+	return !!xsk->umem->umem;
 }
 
 static u32 mode_to_xdp_flags(enum test_mode mode)
@@ -213,6 +213,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
+		struct xsk_umem_info *umem_real;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
 		ifobj->use_poll = false;
@@ -229,24 +230,30 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->tx_on = false;
 		}
 
-		memset(ifobj->umem, 0, sizeof(*ifobj->umem));
-		ifobj->umem->num_frames = DEFAULT_UMEM_BUFFERS;
-		ifobj->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
-
+		umem_real = ifobj->xsk_arr[0].umem_real;
+		memset(umem_real, 0, sizeof(*umem_real));
 		for (j = 0; j < MAX_SOCKETS; j++) {
-			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
-			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-			ifobj->xsk_arr[j].batch_size = DEFAULT_BATCH_SIZE;
+			struct xsk_socket_info *xsk = &ifobj->xsk_arr[j];
+
+			memset(xsk, 0, sizeof(*xsk));
+			xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
+			if (j == 0)
+				xsk->umem_real = umem_real;
+			xsk->umem = umem_real;
+			xsk->batch_size = DEFAULT_BATCH_SIZE;
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
@@ -305,14 +312,14 @@ static void test_spec_reset(struct test_spec *test)
 
 static void test_spec_set_unaligned(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
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
 
 static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
@@ -623,10 +630,10 @@ static void pkt_stream_cancel(struct pkt_stream *pkt_stream)
 	pkt_stream->current_pkt_nb--;
 }
 
-static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
-			 u32 pkt_nb, u32 bytes_written)
+static void pkt_generate(struct xsk_socket_info *xsk, u64 addr, u32 len, u32 pkt_nb,
+			 u32 bytes_written)
 {
-	void *data = xsk_umem__get_data(umem->buffer, addr);
+	void *data = xsk_umem__get_data(xsk->umem->buffer, addr);
 
 	if (len < MIN_PKT_SIZE)
 		return;
@@ -1003,7 +1010,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			return TEST_FAILURE;
 
 		if (!ret) {
-			if (!is_umem_valid(test->ifobj_tx))
+			if (!is_umem_valid(test->ifobj_tx->xsk))
 				return TEST_PASS;
 
 			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
@@ -1163,7 +1170,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
-	struct xsk_umem_info *umem = ifobject->umem;
+	struct xsk_umem_info *umem = xsk->umem;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
 	int ret;
@@ -1222,7 +1229,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 		while (nb_frags_left--) {
 			struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
 
-			tx_desc->addr = pkt_get_addr(pkt, ifobject->umem);
+			tx_desc->addr = pkt_get_addr(pkt, umem);
 			if (pkt_stream->verbatim) {
 				tx_desc->len = pkt->len;
 				tx_desc->options = pkt->options;
@@ -1234,7 +1241,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 				tx_desc->options = 0;
 			}
 			if (pkt->valid)
-				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
+				pkt_generate(xsk, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
 					     bytes_written);
 			bytes_written += tx_desc->len;
 
@@ -1315,7 +1322,7 @@ bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
 
 static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 {
-	bool timeout = !is_umem_valid(test->ifobj_rx);
+	bool timeout = !is_umem_valid(test->ifobj_rx->xsk);
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
@@ -1500,14 +1507,25 @@ static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 
 static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
 {
-	int ret = xsk_configure(test, ifobject, test->ifobj_rx->umem, true);
+	struct xsk_umem_info *umem_rx, *umem_tx;
+	int ret;
 
+	if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem->umem) {
+		ksft_print_msg("Error: RX UMEM is not initialized before shared-UMEM TX setup\n");
+		return -EINVAL;
+	}
+
+	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
+	umem_tx = ifobject->xsk_arr[0].umem_real;
+	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
+	umem_tx->base_addr = 0;
+	umem_tx->next_buffer = 0;
+
+	ret = xsk_configure(test, ifobject, umem_tx, true);
 	if (ret)
 		return ret;
 	ifobject->xsk = &ifobject->xsk_arr[0];
 	ifobject->xskmap = test->ifobj_rx->xskmap;
-	memcpy(ifobject->umem, test->ifobj_rx->umem, sizeof(struct xsk_umem_info));
-	ifobject->umem->base_addr = 0;
 
 	return 0;
 }
@@ -1560,6 +1578,7 @@ static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
+	struct xsk_umem_info *umem = ifobject->xsk->umem;
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int mmap_flags;
 	u64 umem_sz;
@@ -1567,10 +1586,10 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	int ret;
 	u32 i;
 
-	umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
+	umem_sz = umem->num_frames * umem->frame_size;
 	mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 
-	if (ifobject->umem->unaligned_mode)
+	if (umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
 
 	if (ifobject->shared_umem)
@@ -1580,11 +1599,11 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
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
 
@@ -1593,14 +1612,13 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
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
@@ -1687,14 +1705,15 @@ void *worker_testapp_validate_rx(void *arg)
 
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
@@ -1856,9 +1875,11 @@ static int testapp_validate_traffic(struct test_spec *test)
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
@@ -1965,12 +1986,13 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 
 int testapp_headroom(struct test_spec *test)
 {
-	test->ifobj_rx->umem->frame_headroom = UMEM_HEADROOM_TEST_SIZE;
+	test->ifobj_rx->xsk->umem->frame_headroom = UMEM_HEADROOM_TEST_SIZE;
 	return testapp_validate_traffic(test);
 }
 
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
+	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
 	u32 umem_tr = test->ifobj_tx->umem_tailroom;
 
 	if (test->mode == TEST_MODE_ZC) {
@@ -1980,7 +2002,7 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 
 	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
 		return TEST_FAILURE;
-	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
+	umem->frame_headroom = umem->frame_size -
 		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
@@ -2074,7 +2096,7 @@ int testapp_send_receive_mb(struct test_spec *test)
 
 int testapp_invalid_desc_mb(struct test_spec *test)
 {
-	struct xsk_umem_info *umem = test->ifobj_tx->umem;
+	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
 	u64 umem_size = umem->num_frames * umem->frame_size;
 	struct pkt pkts[] = {
 		/* Valid packet for synch to start with */
@@ -2115,7 +2137,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 int testapp_invalid_desc(struct test_spec *test)
 {
-	struct xsk_umem_info *umem = test->ifobj_tx->umem;
+	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
 	u64 umem_size = umem->num_frames * umem->frame_size;
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
@@ -2214,7 +2236,7 @@ int testapp_poll_txq_tmout(struct test_spec *test)
 {
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
-	test->ifobj_tx->umem->frame_size = 2048;
+	test->ifobj_tx->xsk->umem->frame_size = 2048;
 	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
 		return TEST_FAILURE;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
@@ -2393,7 +2415,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 	 * the UMEM but not a page.
 	 */
 	page_size = sysconf(_SC_PAGESIZE);
-	umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
+	umem_size = test->ifobj_tx->xsk->umem->num_frames *
+		test->ifobj_tx->xsk->umem->frame_size;
 	assert(umem_size % page_size > MIN_PKT_SIZE);
 	assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
 
@@ -2451,9 +2474,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
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
 
@@ -2594,8 +2617,8 @@ struct ifobject *ifobject_create(void)
 	if (!ifobj->xsk_arr)
 		goto out_xsk_arr;
 
-	ifobj->umem = calloc(1, sizeof(*ifobj->umem));
-	if (!ifobj->umem)
+	ifobj->xsk_arr[0].umem_real = calloc(1, sizeof(struct xsk_umem_info));
+	if (!ifobj->xsk_arr[0].umem_real)
 		goto out_umem;
 
 	return ifobj;
@@ -2609,7 +2632,9 @@ struct ifobject *ifobject_create(void)
 
 void ifobject_delete(struct ifobject *ifobj)
 {
-	free(ifobj->umem);
+	if (ifobj->xsk_arr)
+		free(ifobj->xsk_arr[0].umem_real);
+
 	free(ifobj->xsk_arr);
 	free(ifobj);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 1ab8aee4ce56..99003995d7c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -83,6 +83,7 @@ typedef int (*test_func_t)(struct test_spec *test);
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
 	struct xsk_ring_prod tx;
+	struct xsk_umem_info *umem_real;
 	struct xsk_umem_info *umem;
 	struct xsk_socket *xsk;
 	struct pkt_stream *pkt_stream;
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


