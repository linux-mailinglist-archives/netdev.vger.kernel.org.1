Return-Path: <netdev+bounces-268235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLtAFmBDuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B361329E919
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69703300A616
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343AE33B6F1;
	Mon, 16 Mar 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cApItXZk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9133C182;
	Mon, 16 Mar 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683207; cv=none; b=A182t9TIr0Mpcoe5C1eKgavuEbBbzqFm30G6tezV3/b1kyCn7rdf5VglaBLtg6M+5XZMhJOeEhBbzKTR43NECDq7Hc53EmiYnAm3JQFnRL2b7EYhDgJ6regLsiFccHp/yNyzFLAQ0sFuPwtYu05rxG3NFGWM4XjcjR6Gq4vra2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683207; c=relaxed/simple;
	bh=ikgy0r+v2RODPC6OJJmPhnlbRY3fB8ZWcbddIAXtxl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBXwNIISpLKoUFvU42xD0z+hhd1kiiiDyQpknV1mXrUW35F61fMV1Yl3GUl227iIKUmRwg9m6rF8ki7SiseKWUzO+4BA9xuxvt5Go0tsGipGRjHr2cY2B5wpho6hpMYXegiUaMyCui+i6VbcMenfpwUA2juy2BEOTx5FupMPfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cApItXZk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683206; x=1805219206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ikgy0r+v2RODPC6OJJmPhnlbRY3fB8ZWcbddIAXtxl8=;
  b=cApItXZkUNceVjvqniZWy/x6vSYMDiJE7CNxHJuGtNEDQP5viweF4nYe
   3CGivLshI7lEfx2UVMfSieVzDCXkLs4zgPHiGP2lNDc2TAVD7VA9KxNB9
   540MAqsAFb9m/OW0aHTd0/NKJghcDdc/dEj3sMfhf+v6ehgU3RBfscP/P
   ys+vUDZrF2cM4hGTUYsumZR/slQBe6ctoiUiL8yZP8KPBijbLSOD3ga9J
   zTj6BlGkZ4jK64fPfN3iA+0O2TgFWOGnmna7xP6TD6tO2WqTMLCx+9Ddt
   IPWVVL71tXVV8/DzNc+s5Ltu4+rRGAsBK767l0HxPjmuzcTfDhC8pkdet
   g==;
X-CSE-ConnectionGUID: cCv+Kw7uQiu9C2ta9pcdsw==
X-CSE-MsgGUID: CB8uMS47R52VI2rYWk+SiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62275732"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62275732"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:46:45 -0700
X-CSE-ConnectionGUID: YwgV5J2tRSi9oWXloGpxYg==
X-CSE-MsgGUID: DzseWbNYSRee7L2G7QB4YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222075756"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2026 10:46:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 5/6] selftests: bpf: fix pkt grow tests
Date: Mon, 16 Mar 2026 18:45:49 +0100
Message-Id: <20260316174550.462177-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268235-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B361329E919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip tail adjust tests in xskxceiver for SKB mode as it is not very
friendly for it. multi-buffer case does not work as xdp_rxq_info that is
registered for generic XDP does not report ::frag_size. The non-mbuf
path copies packet via skb_pp_cow_data() which only accounts for
headroom, leaving us with no tailroom and causing underlying XDP prog to
drop packets therefore.

For multi-buffer test on other modes, change the amount of bytes we use
for growth, assume worst-case scenario and take care of headroom and
tailroom.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..a496f1784b66 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2551,16 +2551,31 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 
 int testapp_adjust_tail_grow(struct test_spec *test)
 {
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
 	/* Grow by 4 bytes for testing purpose */
 	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
 }
 
 int testapp_adjust_tail_grow_mb(struct test_spec *test)
 {
+	u32 grow_size;
+
+	if (test->mode == TEST_MODE_SKB)
+		return TEST_SKIP;
+
+	/* worst case scenario is when underlying setup will work on 3k
+	 * buffers, let us account for it; given that we will use 6k as
+	 * pkt_len, expect that it will be broken down to 2 descs each
+	 * with 3k payload;
+	 *
+	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
+	 */
+	grow_size = XSK_UMEM__MAX_FRAME_SIZE - XSK_UMEM__LARGE_FRAME_SIZE - 256 - 320;
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	/* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
-	return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
-				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
+
+	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
 }
 
 int testapp_tx_queue_consumer(struct test_spec *test)
-- 
2.43.0


