Return-Path: <netdev+bounces-223756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06088B5A463
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806DC485AFA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AAA32951B;
	Tue, 16 Sep 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oGxUtcBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C453323F5E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059873; cv=none; b=ZHwj/dC7kOPJpDeDSGGPjN5O9mXnL+KXwUnpzWsgYKJlEpMksXSM12dxkIEcCmTePCCCutHtinY/x0fQDaTqAkunrxjy1/jvVDcGuuwskmrulsEKnEYOefxdBJzMtxbC62bcrYwjN7ZpnqQZzWf9ohl5nSKnpSr5S2M+cEOdPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059873; c=relaxed/simple;
	bh=e07xLSUxOK6eLXYYTfTyQ4S54WftR8P51mTUqIU/WgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+biA3Fbwey8/JUwrJ+k3ZZa39MZy6BVn5gqQNPce/mMHUIFIZ88l8LojxUTn0WDA3yf3o5nqbyeRFYl6EHuiU9VZXcFjT92Ttk1BEoRfQdBmRtlZzDCfg+2+S4iA9nlIfN42YsLP9ZtozOFqwo0lYh29zgzHtmgmWwhJYrgejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oGxUtcBo; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D493B454BC;
	Tue, 16 Sep 2025 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758059870;
	bh=G9hId5oM/4qOzq1uy8KnJJPTcDtki2j/ymqy0nlr9cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=oGxUtcBodHcKphfR2DxrchPeXvcJ/ZIHuzquekb7MKSfKAfggUiFeEJXvbZlYj/o0
	 Y7ptUjLdo87GqUeWWre0xwzH22KjO7gSoSMbSPnLzklDEgyusWJMfBDgEPCHyydOK7
	 2VIhqDDsfBm0a10NQhUstNbd1UPtA4otjg47/kDSD/1TQE7zeUUjQJ8Cl/f7UwWq8x
	 Juu0ld1zITRI+xKw2+gkSWmgQzYkYCY34aAAYSUgsmikC9tpHl4K0DnibXwbywrdaM
	 xqlYz0bFSf9F0nUYStKuhO/UtXvSFNdDKDdzTSVhCVwja63e/qogHIZhJnu9k4KwK2
	 B/cdqay+ZlOwQ==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 4/4 iproute2-next] tc/police: enable use of 64 bit burst parameter
Date: Tue, 16 Sep 2025 14:57:31 -0700
Message-Id: <20250916215731.3431465-5-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
References: <20250916215731.3431465-1-jay.vosburgh@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Modify tc police to permit burst sizes up to the limit of the
kernel API, which may exceed 4 GB of burst size at higher rates.

	 As presently implemented, the tc police burst option limits the
size of the burst to 4 GB in size.  This is a reasonable limit for the
rates common when this was developed.  However, the underlying
implementation of burst is expressed in terms of time at the specified
rate, and for higher rates, a burst size exceeding 4 GB is feasible
without modification to the kernel.

	The kernel API specifies the burst size as the number of "psched
ticks" needed to send the burst at the specified rate.  As each psched
tick is 64 nsec, the actual kernel limit on burst size is approximately
274.88 seconds (UINT_MAX * 64 / NSEC_PER_SEC).

	For example, at a rate of 10 Gbit/sec, the current 4 GB size limit
corresponds to just under 3.5 seconds.

	Additionally, overflows (burst values that exceed UINT_MAX psched
ticks) are now correctly detected, and flagged as an error, rather than
passing arbitrary psched tick values to the kernel.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---

v2: add Jamal's ack
v3: no changes

 tc/m_police.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tc/m_police.c b/tc/m_police.c
index 5c7438b94d83..f5c538c93d2c 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -54,12 +54,12 @@ static int act_parse_police(const struct action_util *a, int *argc_p, char ***ar
 	__u32 ptab[256];
 	__u32 avrate = 0;
 	int presult = 0;
-	unsigned buffer = 0, mtu = 0, mpu = 0;
+	unsigned mtu = 0, mpu = 0;
 	unsigned short overhead = 0;
 	unsigned int linklayer = LINKLAYER_ETHERNET; /* Assume ethernet */
 	int Rcell_log =  -1, Pcell_log = -1;
 	struct rtattr *tail;
-	__u64 rate64 = 0, prate64 = 0;
+	__u64 rate64 = 0, prate64 = 0, buffer64 = 0;
 	__u64 pps64 = 0, ppsburst64 = 0;
 
 	if (a) /* new way of doing things */
@@ -78,9 +78,10 @@ static int act_parse_police(const struct action_util *a, int *argc_p, char ***ar
 			strcmp(*argv, "buffer") == 0 ||
 			strcmp(*argv, "maxburst") == 0) {
 			NEXT_ARG();
-			if (buffer)
+			if (buffer64)
 				duparg("buffer/burst", *argv);
-			if (get_size_and_cell(&buffer, &Rcell_log, *argv) < 0)
+			if (get_size64_and_cell(&buffer64, &Rcell_log,
+						*argv) < 0)
 				invarg("buffer", *argv);
 		} else if (strcmp(*argv, "mtu") == 0 ||
 			   strcmp(*argv, "minburst") == 0) {
@@ -173,7 +174,7 @@ action_ctrl_ok:
 	}
 
 	/* When the TB policer is used, burst is required */
-	if (rate64 && !buffer && !avrate) {
+	if (rate64 && !buffer64 && !avrate) {
 		fprintf(stderr, "'burst' requires 'rate'.\n");
 		return -1;
 	}
@@ -210,7 +211,11 @@ action_ctrl_ok:
 			fprintf(stderr, "POLICE: failed to calculate rate table.\n");
 			return -1;
 		}
-		p.burst = tc_calc_xmittime(rate64, buffer);
+		p.burst = tc_calc_xmittime(rate64, buffer64);
+		if (p.burst == UINT_MAX) {
+			fprintf(stderr, "POLICE: burst out of range\n");
+			return -1;
+		}
 	}
 	p.mtu = mtu;
 	if (prate64) {
@@ -265,9 +270,8 @@ static int print_police(const struct action_util *a, FILE *funused, struct rtatt
 	SPRINT_BUF(b2);
 	struct tc_police *p;
 	struct rtattr *tb[TCA_POLICE_MAX+1];
-	unsigned int buffer;
 	unsigned int linklayer;
-	__u64 rate64, prate64;
+	__u64 rate64, prate64, buffer64;
 	__u64 pps64, ppsburst64;
 
 	print_string(PRINT_JSON, "kind", "%s", "police");
@@ -296,8 +300,8 @@ static int print_police(const struct action_util *a, FILE *funused, struct rtatt
 	print_hex(PRINT_FP, NULL, " police 0x%x ", p->index);
 	print_uint(PRINT_JSON, "index", NULL, p->index);
 	tc_print_rate(PRINT_FP, NULL, "rate %s ", rate64);
-	buffer = tc_calc_xmitsize(rate64, p->burst);
-	print_size(PRINT_FP, NULL, "burst %s ", buffer);
+	buffer64 = tc_calc_xmitsize(rate64, p->burst);
+	print_size(PRINT_FP, NULL, "burst %s ", buffer64);
 	print_size(PRINT_FP, NULL, "mtu %s ", p->mtu);
 	if (show_raw)
 		print_hex(PRINT_FP, NULL, "[%08x] ", p->burst);
-- 
2.25.1


