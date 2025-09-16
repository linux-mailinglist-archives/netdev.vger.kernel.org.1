Return-Path: <netdev+bounces-223722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E2B5A3E3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA473326F41
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A2304BD0;
	Tue, 16 Sep 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Krgx0eV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38B2F9D96
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057871; cv=none; b=FO2hlLG6mA5AYR4x1ChqkFAlpNpynJ+1ot4k2aWvihNgC8vPZ389Z9Sny7shbolIAVZIqNuMIbrCqZki6e08BACqryEwkFLcH9+iWgpv7KNV1r9BMXF+PNN6OCNfD6XtFozeyJesBBj15S0S2fWEEu+IuThUGVDFAS0ryKN6L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057871; c=relaxed/simple;
	bh=87b/82JUd/W9hh11ViBvUiGvoOhRAZjI2hJMv6z24us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cb3v2xbvWbaGWE1I8vIc4nWGYzELfuKouquRxzJX74ar8Sbv+/TGbAs193c65VMEg9rTfhQFyQmZvgDSu0Iddifv0Lqr6s7PDSwN+jYwdZOWq+T0d76UtMPAu+gorWXPUmMcASVF1O0w1vQJHb+59VoJc6kXzwv8hL2y1Qnueu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Krgx0eV+; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1F198454BB;
	Tue, 16 Sep 2025 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758057861;
	bh=VuxP3Wx6z9/X9NjK4kkMjs3/qJp8omCIcRXe7pQPw4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Krgx0eV+bFy0jpaGg5C8bZN03ahDLyeCBHoC9OThXSp8gz18MPeuRwD37h7uYH2sx
	 UOKXtYGdu6orGOrscBfrKwQSKXReIM3YKOiFKNXCdYUfR1AsiceUUVEP0VhHsTddsF
	 U9Ay0L0koYr2cpSuX8R1COaZZne2hmJI7GPkmx99VpUpA1saPVwoiMGX/SGHEe5ptN
	 GS+DsawGBXuteOrSGBLIn6m+3tH6vhp3gC1QWeI6z+F0lU/qOMdDJ6sfIv3LMAEIxZ
	 +SWW43/3dNZuwS8vNFXus75dsz9x3ak++ZdnWdXCCaxhmnkcjGOdq4TMvefNOJrAlX
	 2unJjhYqlDLkA==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 4/4 iproute2-next] tc/police: enable use of 64 bit burst parameter
Date: Tue, 16 Sep 2025 14:24:03 -0700
Message-Id: <20250916212403.3429851-5-jay.vosburgh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
References: <20250916212403.3429851-1-jay.vosburgh@canonical.com>
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


