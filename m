Return-Path: <netdev+bounces-294592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p+dgF8HOH2qgqAAAu9opvQ
	(envelope-from <netdev+bounces-294592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70321634D43
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:50:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Up40tY3I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34625304A9B5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6AB3921DF;
	Wed,  3 Jun 2026 06:48:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7D395ADF;
	Wed,  3 Jun 2026 06:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469287; cv=none; b=ueaJfPUyi2w3+c+5YJV7VMeZnum+E583amS8dfiFRJDCocbBHcSjEAjPpuDupQ3329L4y6DsQn6kg1OY4F+U22mQSPOW0TprcmDMU4V2v/zeFxElEMElROYLoxcswzdJBWwUq/6JqfblVrngmvVnogv4qbi3s3q1/UEHCzU03KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469287; c=relaxed/simple;
	bh=Z1R/vI/Hcyhdht0Pz4jgGBs+oMgn+RJwHC9qXjc7o4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubN7AQ+QYdQs4mjImPcbTvPtgOMYB0hBEaIc4Wn5nQVl0ujvU66DDP1z5LAkrrxG1pLTqcRu+zNapdpBYDKQ/65TeLTNU9UwdqvvGpB9qvAMVJS5Et6H6N+0vOj4zkWAGAjVTfMZ9m5syHqeC9A8GgEM46KMyAhXdg+ySuYKcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up40tY3I; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469287; x=1812005287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z1R/vI/Hcyhdht0Pz4jgGBs+oMgn+RJwHC9qXjc7o4k=;
  b=Up40tY3IluTJ1h2kd0UD6Rfd5w2YS8hc7prQSyqeVGWu0Rm6R+GYHjxD
   0td+5IeuGo7WQrxrdySoBAF25Iy0d0/4FdP+vr8cYifotgj478aXVKBUH
   jEW3ZR4uBWENm0OcrcVAN4AqXTjjicRR+07Nen/pZDOeQQY1nUJYhCsGk
   letQvLvn2Ug/9vJ81Exhfm15/GUWB2YkPVIOJ6JDaR7yu/qixoO126hsQ
   1Gfwkw3Hroo6bA2PpAI4dtQqaW3rQpDBR7Muaz1xcFXhka7K/ZvKSwvUC
   gMBPkak8JRIkjISC7FtYRVcDxCC8N99WNbI6b+aimGt24vVUJM2AVuocX
   Q==;
X-CSE-ConnectionGUID: HPJSmO4qRCqPMWtfpsmdaA==
X-CSE-MsgGUID: rBl1rVvATC65Sc+jHzNbhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81449126"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81449126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:48:06 -0700
X-CSE-ConnectionGUID: H9VOC3ciS4aZzSWgoPhQww==
X-CSE-MsgGUID: gqgjyl8ERSK8jh0nC6wUNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237778939"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:48:02 -0700
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
Subject: [PATCH net-next v2 3/4] selftests/xsk: Use umem_size() helper consistently
Date: Wed,  3 Jun 2026 11:33:26 +0530
Message-ID: <20260603060327.298389-4-tushar.vyavahare@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294592-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70321634D43

Replace remaining open-coded umem->num_frames * umem->frame_size
calculations in test_xsk.c with the existing umem_size() helper.

This keeps UMEM size computation centralized, avoids duplicated arithmetic,
and improves readability with no intended behavior change.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e0d34111b2f..f1730466ffd9 100644
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
@@ -2097,7 +2098,7 @@ int testapp_send_receive_mb(struct test_spec *test)
 int testapp_invalid_desc_mb(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Valid packet for synch to start with */
 		{0, MIN_PKT_SIZE, 0, true, 0},
@@ -2107,7 +2108,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
@@ -2138,7 +2139,7 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 int testapp_invalid_desc(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_tx->xsk->umem;
-	u64 umem_size = umem->num_frames * umem->frame_size;
+	u64 umem_sz = umem_size(umem);
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
 		{0, MIN_PKT_SIZE, 0, true},
@@ -2149,11 +2150,11 @@ int testapp_invalid_desc(struct test_spec *test)
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
@@ -2171,9 +2172,9 @@ int testapp_invalid_desc(struct test_spec *test)
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
@@ -2406,7 +2407,7 @@ int testapp_unaligned_inv_desc(struct test_spec *test)
 
 int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 {
-	u64 page_size, umem_size;
+	u64 page_size, umem_sz;
 
 	/* Odd frame size so the UMEM doesn't end near a page boundary. */
 	test_spec_set_frame_size(test, 4001);
@@ -2415,10 +2416,9 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
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


