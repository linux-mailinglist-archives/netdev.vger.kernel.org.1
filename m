Return-Path: <netdev+bounces-270696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIk0DgKUwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E72FC363
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073F9303054A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C61383C79;
	Mon, 23 Mar 2026 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7zEvMkP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306393C1978;
	Mon, 23 Mar 2026 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293931; cv=none; b=EkN6mvFZUlx14AmHKxHEDD/3yFFV+qWR70J1olDxbMQ0k58Y37TI4IgbFtXTpq1VEoyrheBNKnG/LETdLBCxm2kAp2iIuCMb6nwo/n+NhjX8wPZi5BLwXSgJ+qxy5j5pUaXTLYVNyXNpLfLWPPhSS6MWaL4Shblh6uNqZiPLBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293931; c=relaxed/simple;
	bh=UNkNuqS2gKGIqlKemTtDj4KWy3fLQBUGxeOyGEk+i5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiT1Qz9VwEnNsCKXAkILnw/pCiD6rkXGYpCocCrQ5PoUD0JskplrVAr92T/E0LcoTr7ZQCsVvNlr1XyFqQ8kaQobjHng9nhK5ve216O8/h2YA+btltsXEYeTK4e4kiZx1fIe6EywBfuBITpwnXh/5XXw4ad0+PCbE+8hbWqPGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7zEvMkP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774293931; x=1805829931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNkNuqS2gKGIqlKemTtDj4KWy3fLQBUGxeOyGEk+i5Q=;
  b=H7zEvMkPNnqjR8RZFJuKmla8RGwZ29DrZlqIxPN1MLdLNXrMlfPdlpLm
   gdIMeE8UlBt+KiyQC1e8a4KShKjZHz+ELBe1ThL6eMmXv+9cyMlVK7Rzp
   ndTehWGuz5pBcLt3sqYCrPiEf10PuNycbYmRH8zz0zzfMIdOCr9W4J5T5
   UB4yDUW+eRCUaIZKEvHmpi5eUn6/vy9eR4h2oSSj53fzGjO0Q1E8KkWD0
   PizQYU2mhyWOmiU3ougtXaVsUvzYwp4hftvlF1R/25Kfq7JI+ea2TGbvS
   ri1aHUX0c+TGOgMaVWKEXXG+JtVU2uMGnjtGOvUsIMJyJJN8vWPpvpsK7
   Q==;
X-CSE-ConnectionGUID: hwW9pDtCQBSakSimauTUvA==
X-CSE-MsgGUID: z2x876VcRyCXCetfI6RJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75013354"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75013354"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 12:25:30 -0700
X-CSE-ConnectionGUID: qEyBmZXjRXW7/JP8u47JuQ==
X-CSE-MsgGUID: fZh/VqkNT0WiYRSf6QGr2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228187922"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 12:25:28 -0700
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
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 7/8] selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom
Date: Mon, 23 Mar 2026 20:24:56 +0100
Message-Id: <20260323192457.504631-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
References: <20260323192457.504631-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270696-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: F09E72FC363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since we have changed how big user defined headroom in umem can be,
change the logic in testapp_stats_rx_dropped() so we pass updated
headroom validation in xdp_umem_reg() and still drop half of frames.

Test works on non-mbuf setup so xsk_pool_get_rx_frame_size() that is
called on xsk_rcv_check() will not account skb_shared_info size. Taking
the tailroom size into account in test being fixed is needed as
xdp_umem_reg() defaults to respect it.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 95cbbf425e9a..697b1502bf27 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1984,10 +1984,10 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 		return TEST_SKIP;
 	}
 
-	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
+	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 2) + XSK_UMEM__PACKET_TAILROOM, 0))
 		return TEST_FAILURE;
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
-		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
+		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - XSK_UMEM__PACKET_TAILROOM - 1;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
-- 
2.43.0


