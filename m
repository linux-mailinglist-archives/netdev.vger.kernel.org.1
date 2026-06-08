Return-Path: <netdev+bounces-296554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dwqKOvfAJmoJkAIAu9opvQ
	(envelope-from <netdev+bounces-296554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:17:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D7656876
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:17:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DE+C+YzV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296554-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D26D63081E98
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13A350A18;
	Mon,  8 Jun 2026 13:10:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B744071E3;
	Mon,  8 Jun 2026 13:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924203; cv=none; b=IKY0O2KDe3mkCKU0Y/1OpK3BemOU8rtjDMwWTvH1OJdFsNiv844pj56CRlqxhxg1gNxv+jA0ADceRFufcxiPs6yyN9Qy4wtn7vt/wk/nfCLttG0QEvDReiuUxbjxonyUIK4Zmco0VaJdBA1RIFt9GucAgHhPYOzVwkaiK5nvlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924203; c=relaxed/simple;
	bh=7hMyq5/LMcXx5x6eowxx4aYN+2zQUUL53tBhYM5bI9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVw/ulDysThM55CKtvmNmuoTZ84Vt524pZTdiEltJXXA9I2Ig6nlWKlifStMG6btVx/a9nNvRfi09SFHlqfEQMrICQFUBLWS+GvDcoFPKr1FLKtP3d+6O3laV7jojK62JnNeHZEQnlxshnUOkdJo3tmNR+A0ez0X1qu4muUOQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DE+C+YzV; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780924202; x=1812460202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hMyq5/LMcXx5x6eowxx4aYN+2zQUUL53tBhYM5bI9Y=;
  b=DE+C+YzVIWKD2J5BMoXherlUGL+xIISC+NMHX+01ohA9H4ax4Uq3YicK
   9LvxLAyxpRWRQFi+HEgeM/Fx5ThDu0d/z5+gvL2MwoPq48Aqrs4kKwKfL
   GYK5WvvPWjCM4MTOuIX83vqlbAylNE8t6B2PpJPXMuLJyu0xuPa12zQ4w
   Wm15EIzNjj2SGHKwsr0jKFiNLTCsgf5DN/WUh3ST70ihfz8XCauMmdDEa
   aaOZCsxEK7uEawsC3PNaHHPZd5sRzO+xklI4Cc0qC/4k4rXbajjv9gzLy
   JM+T4bmUwSxLwnSbjw/XxZwxE9EflDKlJShAb2KVzjBbWofA1YDyFqV53
   w==;
X-CSE-ConnectionGUID: cXBu2LDPQ6aVJWOh2bJMzg==
X-CSE-MsgGUID: KgZ6DOz5QLSW3QUd0zFT3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92223712"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92223712"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:10:02 -0700
X-CSE-ConnectionGUID: /cxZs1CcS2KSWwBCiDcUPw==
X-CSE-MsgGUID: HU0ddQl7QXmssZG2kI+kSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269252958"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:09:58 -0700
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
Subject: [PATCH net-next v3 3/4] selftests/xsk: Use umem_size() helper consistently
Date: Mon,  8 Jun 2026 18:39:36 +0530
Message-ID: <20260608130938.958793-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608130938.958793-1-tushar.vyavahare@intel.com>
References: <20260608130938.958793-1-tushar.vyavahare@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296554-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DNSWL_BLOCKED(0.00)[10.60.135.142:received,2600:3c04:e001:36c::12fc:5321:from,192.198.163.11:received,100.90.174.1:received];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[intel.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.60.135.142:received,100.90.174.1:received,192.198.163.11:received];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5D7656876

Replace remaining open-coded `umem->num_frames * umem->frame_size`
calculations in test_xsk.c with the existing `umem_size()` helper.

This keeps UMEM size computation centralized, avoids duplicated arithmetic,
and improves readability with no intended behavior change.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 8356a4bb6d4c..17a467a7dd7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -829,11 +829,11 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 {
 	u32 seqnum, pkt_nb, *pkt_data, words_to_end, expected_seqnum;
 	void *data = xsk_umem__get_data(umem->buffer, addr);
+	u64 umem_sz = umem_size(umem);
 
 	addr -= umem->base_addr;
 
-	if (addr >= umem->num_frames * umem->frame_size ||
-	    addr + len > umem->num_frames * umem->frame_size) {
+	if (addr >= umem_sz || addr + len > umem_sz) {
 		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
 		return false;
@@ -1586,7 +1586,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	int ret;
 	u32 i;
 
-	umem_sz = umem->num_frames * umem->frame_size;
+	umem_sz = umem_size(umem);
 	mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 
 	if (umem->unaligned_mode)
@@ -1706,12 +1706,13 @@ void *worker_testapp_validate_rx(void *arg)
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
 	struct xsk_umem_info *umem = ifobj->xsk->umem;
-	u64 umem_sz = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 
 	if (ifobj->shared_umem)
 		umem_sz *= 2;
 
 	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
+
 	xsk_umem__delete(umem->umem);
 	munmap(umem->buffer, umem_sz);
 }
@@ -2095,7 +2096,7 @@ int testapp_send_receive_mb(struct test_spec *test)
 int testapp_invalid_desc_mb(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Valid packet for synch to start with */
 		{0, MIN_PKT_SIZE, 0, true, 0},
@@ -2105,7 +2106,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
@@ -2136,7 +2137,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 int testapp_invalid_desc(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
 		{0, MIN_PKT_SIZE, 0, true},
@@ -2147,11 +2148,11 @@ int testapp_invalid_desc(struct test_spec *test)
 		/* Packet too large */
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
 		/* Up to end of umem allowed */
-		{umem_size - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
+		{umem_sz - MIN_PKT_SIZE - 2 * umem->frame_size, MIN_PKT_SIZE, 0, true},
 		/* After umem ends */
-		{umem_size, MIN_PKT_SIZE, 0, false},
+		{umem_sz, MIN_PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
-		{umem_size - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
+		{umem_sz - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
 		/* Straddle a 4K boundary */
 		{0x1000 - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
 		/* Straddle a 2K boundary */
@@ -2169,9 +2170,9 @@ int testapp_invalid_desc(struct test_spec *test)
 	}
 
 	if (test->ifobj_tx->shared_umem) {
-		pkts[4].offset += umem_size;
-		pkts[5].offset += umem_size;
-		pkts[6].offset += umem_size;
+		pkts[4].offset += umem_sz;
+		pkts[5].offset += umem_sz;
+		pkts[6].offset += umem_sz;
 	}
 
 	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
@@ -2404,7 +2405,7 @@ int testapp_unaligned_inv_desc(struct test_spec *test)
 
 int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 {
-	u64 page_size, umem_size;
+	u64 page_size, umem_sz;
 
 	/* Odd frame size so the UMEM doesn't end near a page boundary. */
 	test_spec_set_frame_size(test, 4001);
@@ -2413,10 +2414,9 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 	 * the UMEM but not a page.
 	 */
 	page_size = sysconf(_SC_PAGESIZE);
-	umem_size = test->ifobj_tx->xsk->umem->num_frames *
-		test->ifobj_tx->xsk->umem->frame_size;
-	assert(umem_size % page_size > MIN_PKT_SIZE);
-	assert(umem_size % page_size < page_size - MIN_PKT_SIZE);
+	umem_sz = umem_size(test->ifobj_tx->xsk->umem);
+	assert(umem_sz % page_size > MIN_PKT_SIZE);
+	assert(umem_sz % page_size < page_size - MIN_PKT_SIZE);
 
 	return testapp_invalid_desc(test);
 }
-- 
2.43.0


