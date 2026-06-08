Return-Path: <netdev+bounces-296555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jss5CxfBJmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-296555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:18:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4D656890
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:18:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Ut2PyVS/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296555-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296555-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 647E430523C5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0631E842;
	Mon,  8 Jun 2026 13:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9E366049;
	Mon,  8 Jun 2026 13:10:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924208; cv=none; b=XwsXqJk6NdvH6ufXU6uszdJaXIJ3+Zf+YJCe0Hi+I3lh7Ip8w31sFo1LiUBo29TYNqMqKZez9hJsEjyTGhsskyPU9KPVrInaaa3S7dMTYeHqwECeX5EPAae4DSfHYz1fgIUMGDQJ0FHbpZ3DG+gU0UGpITJigIsjIMoX61Wgevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924208; c=relaxed/simple;
	bh=IkBj2QADNGTcLqEJLi1DttYwdhAgglParnUhQsBeAik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfWmAHEeATKf9vyr1yEXfdAg08xsOd8tralrfQ40BgxQ6oqvFgFMbgKAQhVNYGrwrZcPCrJza+JM6NgVhT2Dp/QbhW70Q3V0cU7Actp4jJ33c5Vx9vsxNyVk4fVYpndwXksax6Yj4rs24rQTrd6q/aaM91gUe1EEe6gbI7JJpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut2PyVS/; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780924205; x=1812460205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IkBj2QADNGTcLqEJLi1DttYwdhAgglParnUhQsBeAik=;
  b=Ut2PyVS/4Vwimgb4feYNCXjzFrNQlimKhARliQ8qibj3RA3po7CAT93D
   Whvnyv5ljSVrkDM9OtPX7lhk4+m+Bapr2lTXBjq9Wy6Ef6w9hVNvlWdPz
   GdKNmW3fbxs2I5bKFqFzhCTHN+fSlZSUxoyuBeKMO+4OTSaX+xKGRAUqH
   cQ0OOZrQSrBe0xNKzaCCL47myY/KugtRHaeq00ThYXFmXCtsgZ6gwyuOs
   v1vdK/PJNVe7QEkjwZDtMZz1MKbojgvUPsNPRiqnkJZpKktUD6gfSJszY
   4a4KnInACmwOZ8yoxVbQybKEN+f+8wlxUGQXoq9+XM92dPSLEST6CAaXK
   A==;
X-CSE-ConnectionGUID: bsslh8/pSMOtlKvEg6J9Dg==
X-CSE-MsgGUID: Pw0YW05hQbSq2ySZoB3FUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92223722"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92223722"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:10:05 -0700
X-CSE-ConnectionGUID: PmHBckAUSQOwtcT54SMXkg==
X-CSE-MsgGUID: bWHDU2DVR7aZp5xErh4Xyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269252988"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:10:02 -0700
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
Subject: [PATCH net-next v3 4/4] selftests/xsk: Introduce mmap_size in umem struct
Date: Mon,  8 Jun 2026 18:39:37 +0530
Message-ID: <20260608130938.958793-5-tushar.vyavahare@intel.com>
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
	TAGGED_FROM(0.00)[bounces-296555-lists,netdev=lfdr.de];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[192.198.163.11:received,100.90.174.1:received,10.60.135.142:received];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EB4D656890

UMEM teardown currently recomputes the munmap() length from frame
geometry, shared-UMEM adjustment, and hugepage rounding. This duplicates
setup-time logic in cleanup and relies on re-deriving the mapping size
instead of using the size originally established for the mapping.

Store the final mapping length in xsk_umem_info as mmap_size when the
UMEM mapping is created, and use that value during teardown.

Also join the RX worker thread before cleanup in the single-thread
path. This establishes synchronization before reading umem->mmap_size
in teardown and avoids a potential visibility race.

This removes duplicated size arithmetic in cleanup and makes munmap()
use the canonical mapping size recorded at setup time.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 20 +++++++++----------
 .../selftests/bpf/prog_tests/test_xsk.h       |  1 +
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 17a467a7dd7f..72875071d4f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1581,7 +1581,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	struct xsk_umem_info *umem = ifobject->xsk->umem;
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int mmap_flags;
-	u64 umem_sz;
+	u64 umem_sz, mmap_sz;
 	void *bufs;
 	int ret;
 	u32 i;
@@ -1595,10 +1595,15 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ifobject->shared_umem)
 		umem_sz *= 2;
 
-	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	mmap_sz = umem->unaligned_mode ?
+		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
+
+	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 	if (bufs == MAP_FAILED)
 		return -errno;
 
+	umem->mmap_size = mmap_sz;
+
 	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
 	if (ret)
 		return ret;
@@ -1706,15 +1711,9 @@ void *worker_testapp_validate_rx(void *arg)
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
 	struct xsk_umem_info *umem = ifobj->xsk->umem;
-	u64 umem_sz = umem_size(umem);
-
-	if (ifobj->shared_umem)
-		umem_sz *= 2;
-
-	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
 
 	xsk_umem__delete(umem->umem);
-	munmap(umem->buffer, umem_sz);
+	munmap(umem->buffer, umem->mmap_size);
 }
 
 static void handler(int signum)
@@ -1857,8 +1856,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 
 	if (!ifobj2)
 		pthread_kill(t0, SIGUSR1);
-	else
-		pthread_join(t0, NULL);
+	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
 		clean_sockets(test, ifobj1);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 99003995d7c3..4313d0d87235 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -103,6 +103,7 @@ struct xsk_umem_info {
 	struct xsk_ring_cons cq;
 	struct xsk_umem *umem;
 	u64 next_buffer;
+	u64 mmap_size;
 	u32 num_frames;
 	u32 frame_headroom;
 	void *buffer;
-- 
2.43.0


