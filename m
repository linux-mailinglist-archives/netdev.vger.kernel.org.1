Return-Path: <netdev+bounces-110615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F400F92D747
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B587028136B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA711194C73;
	Wed, 10 Jul 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N1wdVqE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50034545
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631639; cv=none; b=aXXW96nV13Il1HPzXzoZMOYQrVMwBdG8f9IVy4zLY9WAP7VsLOD+4wPoXv5M3jMqork1Jj2LhTOIyCzgg8YZaxqN0hCnOpFw0cSA589NqvyRyG/a9kTTmdQKOV/IVqMHG5DBLgjfKPi/nd3w2dNORwEwAWHxZJlEtErYTSLmD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631639; c=relaxed/simple;
	bh=dYA4Z+zPMZF7srwxhPUtoyKSvcIgPp5lVazwBcLxjBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLJ0GBWQ+fijnhUqnpPWRb+C8/9BCMp0FWt2mfLk/rptXzBFyNPgi2A7XA4kx41e/F1+CBMLN+r2u0TAjLjim/H6TQbrg04Tsj+QsTzQCFjXoh1684lmSILfKRkCAeZfJNC4GRFv8gA3DN6dorsMVurkm/SVbjW4eidGXW9cKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N1wdVqE3; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720631638; x=1752167638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFL2moTHfGaW1s+IW47pWEaJNcsZeBtRBwQH5oZyBJ8=;
  b=N1wdVqE30j1sFwsxlrTZf9Q7v4NBt38uTxN2KVnlgDjSOWL/4iPm4McO
   SS/95zh2fzL5TSsv8+wruZTynttcEDf2yulGPf+2Svg85jWJEbReaBkFd
   OG0E8UlZuNGrTJUaVZp7adU3lPXSB7itNPJWiB1rOVAllxAPEL6RYAFJ/
   s=;
X-IronPort-AV: E=Sophos;i="6.09,198,1716249600"; 
   d="scan'208";a="217726736"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:13:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:41876]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.189:2525] with esmtp (Farcaster)
 id 9e78013d-932b-423b-9323-8e67a27076dc; Wed, 10 Jul 2024 17:13:54 +0000 (UTC)
X-Farcaster-Flow-ID: 9e78013d-932b-423b-9323-8e67a27076dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:51 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Dmitry Safonov
	<dima@arista.com>
Subject: [PATCH v3 net-next 2/2] selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect tests.
Date: Wed, 10 Jul 2024 10:12:46 -0700
Message-ID: <20240710171246.87533-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240710171246.87533-1-kuniyu@amazon.com>
References: <20240710171246.87533-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

tcp_ao/self-connect.c checked the following SNMP stats before/after
connect() to confirm that the test exercises the simultaneous connect()
path.

  * TCPChallengeACK
  * TCPSYNChallenge

But the stats should not be counted for self-connect in the first place,
and the assumption is no longer true.

Let's remove the check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
---
 .../selftests/net/tcp_ao/self-connect.c        | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index e154d9e198a9..a5698b0a3718 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -30,8 +30,6 @@ static void setup_lo_intf(const char *lo_intf)
 static void tcp_self_connect(const char *tst, unsigned int port,
 			     bool different_keyids, bool check_restore)
 {
-	uint64_t before_challenge_ack, after_challenge_ack;
-	uint64_t before_syn_challenge, after_syn_challenge;
 	struct tcp_ao_counters before_ao, after_ao;
 	uint64_t before_aogood, after_aogood;
 	struct netstat *ns_before, *ns_after;
@@ -62,8 +60,6 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 
 	ns_before = netstat_read();
 	before_aogood = netstat_get(ns_before, "TCPAOGood", NULL);
-	before_challenge_ack = netstat_get(ns_before, "TCPChallengeACK", NULL);
-	before_syn_challenge = netstat_get(ns_before, "TCPSYNChallenge", NULL);
 	if (test_get_tcp_ao_counters(sk, &before_ao))
 		test_error("test_get_tcp_ao_counters()");
 
@@ -82,8 +78,6 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 
 	ns_after = netstat_read();
 	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
-	after_challenge_ack = netstat_get(ns_after, "TCPChallengeACK", NULL);
-	after_syn_challenge = netstat_get(ns_after, "TCPSYNChallenge", NULL);
 	if (test_get_tcp_ao_counters(sk, &after_ao))
 		test_error("test_get_tcp_ao_counters()");
 	if (!check_restore) {
@@ -98,18 +92,6 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		close(sk);
 		return;
 	}
-	if (after_challenge_ack <= before_challenge_ack ||
-	    after_syn_challenge <= before_syn_challenge) {
-		/*
-		 * It's also meant to test simultaneous open, so check
-		 * these counters as well.
-		 */
-		test_fail("%s: Didn't challenge SYN or ACK: %zu <= %zu OR %zu <= %zu",
-			  tst, after_challenge_ack, before_challenge_ack,
-			  after_syn_challenge, before_syn_challenge);
-		close(sk);
-		return;
-	}
 
 	if (test_tcp_ao_counters_cmp(tst, &before_ao, &after_ao, TEST_CNT_GOOD)) {
 		close(sk);
-- 
2.30.2


