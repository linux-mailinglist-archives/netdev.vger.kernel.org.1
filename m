Return-Path: <netdev+bounces-299895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b39/IYJ0MWoGjwUAu9opvQ
	(envelope-from <netdev+bounces-299895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44B691AFF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lVmlBiza;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BE5F3063628
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615A43E486;
	Tue, 16 Jun 2026 15:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F63B840B;
	Tue, 16 Jun 2026 15:50:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625030; cv=none; b=D+Ngyx3EfgUZlDPA/fHiwIu3/Bc/Ztq5iVsFLty6PQPfHBg+jc+Nh5fYTW/JWXG9xiI8uy/BXzspEHbkq4AyYljp1UThSnpj0DBAlFKRYAlDc+MsgjYPgTzc4+DjMyEEW8kjyWjQOrW1O7Bx+y5ci3YASe2Srdc+FuQ0bkyb0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625030; c=relaxed/simple;
	bh=HJQ9FhM6s4PNIhrbdaaSloqKORuBviT369jjX+4aPhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhXTJ8/3kGYkU8A1OSRo+IlzCBoe198tqcV2p8W6Rq7MPoBtnaoqeTUDUVfsWfKyTO1ZjBjxDpfvkcZdiT18wUKnUrkCJmac+UgpoXVvVfmCXQEXPPDs5I/i4GEhPNFJSx7rgowcCGVS9o63mtDnbCVGNWtYvGBQAENO7o4gz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVmlBiza; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781625029; x=1813161029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJQ9FhM6s4PNIhrbdaaSloqKORuBviT369jjX+4aPhw=;
  b=lVmlBizaAQagkoSAXW5/a8lffoKU+nzP22AHXOJLIThN8NFQEqSyYIlK
   MnM4V9ufVMynlWKd+CYnCZK+kUkfs8E5pXNbk+W9/OHKm3G0/wsdhusR9
   XXPOmJ9YXjWSi0y9I1/9o5th9MfbHiQ1vgF3L16x47DTAexmea5ncwH0z
   zZ9XQgdr3zXZihCBsPVb5geFKU8ameQxF1nA0XtFw4xJQP1/2APZdEtJY
   4ENz8U77wBPjcpfZVQJd6sdmfzjMShNvtVf/AC2/fXtdfekAjHV1HeG5f
   TAbClTYn+Dv1DlcO0dNV1R9dep39JDVVUPfrbucuDWNiQ0hnrAQe38C/D
   g==;
X-CSE-ConnectionGUID: 4hYKpbcJTnKTni3zE54N5w==
X-CSE-MsgGUID: sI+2QnV9RIefT+jIVOzuJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86233003"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86233003"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:29 -0700
X-CSE-ConnectionGUID: nNzsAOupTCyXyjLoWps5AQ==
X-CSE-MsgGUID: yfaJ5D0LT8GReLUimvulvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247684314"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:25 -0700
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
Subject: [PATCH net-next 2/3] selftests/xsk: fix timeout thread harness sequencing
Date: Tue, 16 Jun 2026 21:19:53 +0530
Message-ID: <20260616154955.1492560-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:tushar.vyavahare@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299895-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C44B691AFF

Prevent workers from running before XDP program attachment completes.
The previous ordering allowed races between worker startup and setup.

Attach XDP programs before entering traffic validation.

Remove SIGUSR1-based worker termination and use pthread_join() for
thread shutdown so blocking syscalls are not interrupted.

Use barriers only for dual-thread runs so participants match and
teardown ordering stays deterministic.

This removes setup/startup races and stabilizes harness sequencing.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 33 ++++++++++---------
 .../selftests/bpf/prog_tests/test_xsk.h       |  1 +
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ca47a16ceb1a..d4702d2aac5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -7,7 +7,6 @@
 #include <linux/netdev.h>
 #include <poll.h>
 #include <pthread.h>
-#include <signal.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
@@ -1671,7 +1670,8 @@ void *worker_testapp_validate_rx(void *arg)
 				       strerror(-err));
 	}
 
-	pthread_barrier_wait(&barr);
+	if (test->use_barrier)
+		pthread_barrier_wait(&barr);
 
 	/* We leave only now in case of error to avoid getting stuck in the barrier */
 	if (err) {
@@ -1710,11 +1710,6 @@ static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 	munmap(umem->buffer, umem->mmap_size);
 }
 
-static void handler(int signum)
-{
-	pthread_exit(NULL);
-}
-
 static bool xdp_prog_changed_rx(struct test_spec *test)
 {
 	struct ifobject *ifobj = test->ifobj_rx;
@@ -1819,9 +1814,18 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		return TEST_FAILURE;
 	}
 
-	if (ifobj2) {
+	err = xsk_attach_xdp_progs(test, ifobj1, ifobj2);
+	if (err) {
+		ksft_print_msg("Error: failed to attach XDP programs: %d (%s)\n",
+			       err, strerror(-err));
+		return TEST_FAILURE;
+	}
+	test->use_barrier = !!ifobj2;
+
+	if (test->use_barrier) {
 		if (pthread_barrier_init(&barr, NULL, 2))
 			return TEST_FAILURE;
+
 		pkt_stream_reset(ifobj2->xsk->pkt_stream);
 	}
 
@@ -1829,27 +1833,26 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 	pkt_stream_reset(ifobj1->xsk->pkt_stream);
 	pkts_in_flight = 0;
 
-	signal(SIGUSR1, handler);
 	/*Spawn RX thread */
 	pthread_create(&t0, NULL, ifobj1->func_ptr, test);
 
-	if (ifobj2) {
+	if (test->use_barrier) {
 		pthread_barrier_wait(&barr);
 		if (pthread_barrier_destroy(&barr)) {
-			pthread_kill(t0, SIGUSR1);
+			test->use_barrier = false;
+			pthread_join(t0, NULL);
 			clean_sockets(test, ifobj1);
 			clean_umem(test, ifobj1, NULL);
 			return TEST_FAILURE;
 		}
+	}
 
+	if (ifobj2) {
 		/*Spawn TX thread */
 		pthread_create(&t1, NULL, ifobj2->func_ptr, test);
-
 		pthread_join(t1, NULL);
 	}
 
-	if (!ifobj2)
-		pthread_kill(t0, SIGUSR1);
 	pthread_join(t0, NULL);
 
 	if (test->total_steps == test->current_step || test->fail) {
@@ -1887,8 +1890,6 @@ static int testapp_validate_traffic(struct test_spec *test)
 		}
 	}
 
-	if (xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx))
-		return TEST_FAILURE;
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 20eaaa254998..03753ddc5dcd 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -208,6 +208,7 @@ struct test_spec {
 	bool adjust_tail;
 	bool adjust_tail_support;
 	bool poll_tmout;
+	bool use_barrier;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
-- 
2.43.0


