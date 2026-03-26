Return-Path: <netdev+bounces-271999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPeuC0UgxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:02:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F3334DC9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB34A3109C50
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02D3F8804;
	Thu, 26 Mar 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QluyQQsq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832B3F7ABC;
	Thu, 26 Mar 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525811; cv=none; b=tqkijdZSDByQrp0E64HOaUOzJY40TjuYRRC0pzhwIjxWYVaZnE30bsSp3Ns8dtyGddFUfUyakyV1rtw1ryKTPx8TjCRmBIhBZiw12lcLPBqbuuX3noF19OWOw8oPGSA1K3z+Z2wvB3ooL8lRp8OFpm2pOt9xlTrTb3lv6/8HLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525811; c=relaxed/simple;
	bh=0AYtxJhoqaYmH/rea/aKqhrXfui+FxIboHIJ69CFgXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrKTx40jXlEHN7pSEdrtmjmyysRZN0vygFGGh5AQUQ6Nxj2BZ1ojxNm6jIRHISvpRjDP1K45KXKVMpa4JhUct9MScmZHUKGZEJgek3/Ev90Arc587kR0d35+USYRxHjj9JTN0E+jqPzfnCXEscqbAd6h2SXtJdQp1MPjJGFtQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QluyQQsq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525803; x=1806061803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AYtxJhoqaYmH/rea/aKqhrXfui+FxIboHIJ69CFgXA=;
  b=QluyQQsqLafMcSSB7Kz3x1NNE69zYxm27j05vMvKYGYCG5OFxJcwzVsx
   Kor24rOp3Swe3/2lMZqFXNcef0INOhjQ6zcFI3PoGavdDj0DSbzeSQvQG
   /KtTfBucDYUAw2sDR5k6POwiRmEgAzi0QseQSQ3J5Ud0bpbQJnRBPFji8
   JmCn/4/SSXGbH5wQF6JKx9K4hXxvA+5kawk92ws2Unjj9KVEamzB5RQgz
   hY9MHWXXFm2Gy1VuAAlOqWsAA2YqvxiGghwWlamfIinPfsteJYBGZDxoK
   dxHXOXlZOReE6idKIMwOCF75Ul4JPa/H5Ws5IJvNv9HznEcexuSJIa9VU
   w==;
X-CSE-ConnectionGUID: g8/Qm86oQ8mXKObJzevTgA==
X-CSE-MsgGUID: jl/7lKqyQziRCsM41lIeHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776274"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:52 -0700
X-CSE-ConnectionGUID: ba45QOffRC2uTntamPhvzA==
X-CSE-MsgGUID: oh/JWsGkRN2r35+D3oSNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029077"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:49 -0700
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
Subject: [PATCH v4 net 08/11] selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom
Date: Thu, 26 Mar 2026 12:49:16 +0100
Message-Id: <20260326114919.519456-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271999-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 822F3334DC9
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
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ee60bcc22ee4..a96ca4b39d1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1959,15 +1959,17 @@ int testapp_headroom(struct test_spec *test)
 
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
+	u32 umem_tr = test->ifobj_tx->umem_tailroom;
+
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
 	}
 
-	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
+	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 2) + umem_tr, 0))
 		return TEST_FAILURE;
 	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
-		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
+		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr - 1;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
-- 
2.43.0


