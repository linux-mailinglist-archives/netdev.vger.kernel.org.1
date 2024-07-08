Return-Path: <netdev+bounces-109966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9C92A8BC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976E5282871
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B33148FFC;
	Mon,  8 Jul 2024 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eiHtzwuv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C24147C71
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462204; cv=none; b=O1T6QSlbzEU4WP6+WNuEAfarnonEKXGKM9QpNNkjNVtw9JVmuWNGE31xyjr9ewh99jtK0fn4YHJvUkpDUPIgk858kut4zOvv0eKOCodEnuZ8YqkkNjUpb3cGJ6lxRhp8ShiJJfJ5RXQxvJOA+e6KOqwi1lJPQ/roj6kg8pKM0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462204; c=relaxed/simple;
	bh=yCfv3TaoW57YSNe5p8cD7U1VZqQcTLjkJk7+vs0AgGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDtqCN0LwsslL4gcCfuqk4MgdTQyu7j+VcAC1VKV9tSABVQHi3d5HBRpdyc0+1onwTPJon2OB5+rAJBzpTnjmMPbSghu4W0xv1MavtUgykHoIKYsaXQkqJvG8W+PgOD5PRksQby8cQA9fVCWGCg1S6KTsBfwcKwltC9eZ82g8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eiHtzwuv; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720462203; x=1751998203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AV3vAoghG7fXXAY/Yju7KLNsspdhz7FzvKsNN9lgwQA=;
  b=eiHtzwuv4PaYhtAQmsVyEjQqwhjhdE+oEGAg1Su1FDdi5jEU1FXrLfXB
   0Y38pQTpyB2tp1WGs1l5Ja1kHyuj91krxx40pXv0owss+7uoaogg5qKNF
   lIjNbl00AxKbqe4oy58Dgka56WtfwcqNwrFbLfebIWK+Yu2aRkg41RnIg
   o=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="739696128"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:09:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:51047]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.123:2525] with esmtp (Farcaster)
 id 2cc7d817-3f38-4061-b23f-4345c0a548c6; Mon, 8 Jul 2024 18:09:57 +0000 (UTC)
X-Farcaster-Flow-ID: 2cc7d817-3f38-4061-b23f-4345c0a548c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:56 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Dmitry Safonov <dima@arista.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/2] selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect tests.
Date: Mon, 8 Jul 2024 11:08:52 -0700
Message-ID: <20240708180852.92919-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240708180852.92919-1-kuniyu@amazon.com>
References: <20240708180852.92919-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
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


