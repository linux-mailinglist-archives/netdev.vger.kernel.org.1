Return-Path: <netdev+bounces-307485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ItfyOmRHVmrz2gAAu9opvQ
	(envelope-from <netdev+bounces-307485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66F755CCD
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=goy5Y0GV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307485-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 129B835E23CF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A931481A81;
	Tue, 14 Jul 2026 14:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CCE481256;
	Tue, 14 Jul 2026 14:08:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038114; cv=none; b=b2Bs415vA+F89OU1RKVn6J062m9tJnAIJlJueAtOhzJEp0ZKmzflCFYzIrn1TMVopAzyTJtmHo5PtHGYdZsSaUgIPpD7gN2M1oyQWEIS0Y9BEs6P2P30fCZD+gQknIh+F66gwLRGp+MjJfYc2552qy+tfMg7t3EIxHZsXRrZOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038114; c=relaxed/simple;
	bh=u478NMbtsRva1LZrqkCrRxxL0J701DD1osUrLGCq5mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmIXrAwtCuAwfdYdPQ/k83NXXIx9TGyeOQBB/7RA9k2IHYUaZjtquYgs+1PoH+Yh7wng/h+nBFkzPfLR9DH5YBA3ydUiurGQ4H2PF+M96m7AVudBaTsY3lzGLzuptfRDNaAph1PKtwEx5jmSwnoQonzSVBR+t9wjsBMRxhm6QLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goy5Y0GV; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038111; x=1815574111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u478NMbtsRva1LZrqkCrRxxL0J701DD1osUrLGCq5mQ=;
  b=goy5Y0GViqu+7o9z+VwYzjhHMXuOInkws70JFSY66+QrdsKclGyujt/M
   nzMSwmxKUi9i50BG0thFF6QfZeaq9kpTU4O6uGLLjKRvgR+Oa9TmJarj8
   /bn9+xkvltksQYO/WNILzCZquaS5+yt8Gsa+NI8ng9dnE3J5ABzkPTo4t
   MjbqZ8tvq6z3gRBOdSrvmPHC5FCxx0X8nvfzVvXKT2eeRBSsnHZ209dTV
   V6qCfla9jyW1OVDLRdN9XD+dsevm92Ygwd6EcDD3+eLNFW1ItB92aIs68
   YjUQQKA2LoF/H3nAfopbS5xEzGaTOpxic30M2j9xqJTeixDzBuDfcM3jQ
   A==;
X-CSE-ConnectionGUID: RkHLrAR0RHSTyBv4uO5CxQ==
X-CSE-MsgGUID: TaqVG9E0SSmTYaAEwLxz2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110207051"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110207051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:07:44 -0700
X-CSE-ConnectionGUID: eFka8kkZSdyoxMLIf7jTfA==
X-CSE-MsgGUID: iysSx90RTc+8oaVGGglN4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254120996"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 14 Jul 2026 07:07:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 5/6] selftests/xsk: fix too-many-frags multi-buffer Tx test
Date: Tue, 14 Jul 2026 16:07:21 +0200
Message-Id: <20260714140722.111645-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307485-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B66F755CCD

The too-many-frags test describes a packet that is valid from the Tx
ring ownership point of view, but invalid for transmission because it
exceeds the supported number of fragments.

Keep the generated Tx descriptors valid so that __send_pkts() accounts
them as outstanding descriptors that must be reclaimed through the CQ.
Then mark the corresponding Rx packet invalid so the test still does
not expect the oversized packet to appear on the receive side.

Add a valid synchronization packet after the oversized packet so the
test can verify that the Tx path drains the bad packet and resumes at
the next packet boundary.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 6eb9096d084c..de17dd48f176 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2270,7 +2270,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2288,24 +2288,30 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with the max + 1 amount of frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
-		pkts[i].valid = false;
+		pkts[i].valid = true;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
 
+	/* The generated Tx stream must keep the too-big packet valid so that
+	 * __send_pkts() accounts its descriptors in outstanding_tx. The Rx
+	 * stream, however, must not expect this packet on the wire.
+	 */
+	test->ifobj_rx->xsk->pkt_stream->pkts[2].valid = false;
+	test->ifobj_rx->xsk->pkt_stream->nb_valid_entries--;
+
 	ret = testapp_validate_traffic(test);
 	free(pkts);
 	return ret;
-- 
2.43.0


