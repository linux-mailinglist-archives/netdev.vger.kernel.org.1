Return-Path: <netdev+bounces-273672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK+sJRjjy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:07:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82836B696
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B074A304E2D1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B74401A2D;
	Tue, 31 Mar 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeRdezB8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C800401A30;
	Tue, 31 Mar 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969358; cv=none; b=iWgZId+WLcuVYg+QJqgtYKJikwhuS2fS7tKEIttlXLv2QxxiMngITFNCF6t0BfVLHv82GAsKxuG12oQyUw9o9peHI2QdAUJoRBya/WSMnY9ybDUrSDEBVRQjlO+Mw50zuUJ6nY1V+Jhp6NU0BtKlHbJ9Lhe8e9sqB9B9IudvDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969358; c=relaxed/simple;
	bh=J57BK9sBNCaQf7KgZJxvzeutVaG94MCuRhfmbZmW3+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1moZFLSAgyt62mMFW28QelC9gRLzOGJBD56Zctey0a8YiOMtzRD+cU+iGezP1wJLm5aHhd9kMlMUJcu1gdHcRhTQVYnTv8dyKaMcnr6iPClYm0LCzAGukudPCM5pQstwKSfdAL5Bd5hYx3G5O0sPAXN00eXaJCp2XYndsado08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeRdezB8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969358; x=1806505358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J57BK9sBNCaQf7KgZJxvzeutVaG94MCuRhfmbZmW3+E=;
  b=UeRdezB8E8XJXspkYi2BO/22MecBuxnzwF7/ivj3U4gYZ1SDEUKGGFkw
   IASZEA+JVk1b+b5q/tSb0QUlzOB7U8btI/DNXwtsa+X6BgusnIVtQzakM
   3tkfIiadL7uqzeLACHUeOMYywGVgtPx1q/4Lg96VpOtjcy4E09eSr3mnn
   rlhdSYt59xg7Lz0BEIBy99csARrcbT/I7Yug9h5VpWcPgz8Dspurop+YH
   hmwoVi9z1s3++iWhIGJNnmTz5O5bOmlZYFBBAAorhX7wE2oz1Eyn3QJCF
   mB5aL5mvTDzoT6k45mKWxocY/C7/YhCWdNR6sPJ4yMtW1abHOeBaR53E/
   A==;
X-CSE-ConnectionGUID: NreGN833T6adJkReLCtvlA==
X-CSE-MsgGUID: bAIlkKeTRLe5QDc+Mg0/qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046171"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:37 -0700
X-CSE-ConnectionGUID: WAdFDX7nQn+/seJUtMpA7A==
X-CSE-MsgGUID: 0TReCKR/Tjyu7vwZFuDZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735609"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:33 -0700
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
Subject: [PATCH v5 net 06/11] selftests: bpf: fix pkt grow tests
Date: Tue, 31 Mar 2026 17:02:08 +0200
Message-Id: <20260331150213.550797-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273672-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DB82836B696
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

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 62118ffba661..ee60bcc22ee4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2528,16 +2528,34 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
 
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
+	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
+		    XSK_UMEM__LARGE_FRAME_SIZE -
+		    XDP_PACKET_HEADROOM -
+		    test->ifobj_tx->umem_tailroom;
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


