Return-Path: <netdev+bounces-282634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFU4CsfL8mmWuQEAu9opvQ
	(envelope-from <netdev+bounces-282634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382D49CCDA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37B063016818
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406CB3382C5;
	Thu, 30 Apr 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IzQ1gOXe"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE792848AA;
	Thu, 30 Apr 2026 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519539; cv=none; b=MH/EfGbxEpqyz6s1z4w/QmWTwADST1BX44aY3tyYSlai3pScITE8tlzizonNlN1wcBGEx6+Ra6h+V1bOEuNumB5fM64j8dqRwmVR2wBEMRXxNZe5YaD6aWyTf1bx2y1999y5sMrmCYa/d/lwU9OS6hkgavKOHi69TeWGC4rjesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519539; c=relaxed/simple;
	bh=/dTpzmkZyWHnlgGcUYC/4QWQzSm362ukIfQOXyZRdTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIJn+CNkYU8l1itg5LT3aomYCQS01bN2awG3cDA8Sr9meAL77pYgbTS/tAYUeiFfJPpP747K52icHpq85xNnonQgd/cfPqMOgjFOd9IQSYL1QFxSftGXxCNHFStUByOGTJsLGPhT2D5zjicpRr/jIAA35JpzaPtK7ltZ0XqdPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IzQ1gOXe; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777519538; x=1809055538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWOAAnFub8AMT7FdRtKJc/Hk8Pxdbj6VVKcyAdlo/Ys=;
  b=IzQ1gOXejVxxGDLCkMhBa7WI65Gc7C5sltkQQ+cyaTLEKk6jsm1TsYW5
   N1ZGS0+Re0CohO1agsd2CWEQEEB9kyToP7+u24x+R6yKDzqQb/wIsHJxx
   nDQB9LZUmRG3eTqxbUd5d+MsHJGCgx6wm3nwzotPQF6+yWgUChhGxI7Hq
   Gw+hhIEgrO1ZDq2JflzwrbQndfSQTQr6zD3NJ+ZrubAdxIo8PWac4BVmp
   +aiuHMNLRBV2Xh0ye29mOZJChW5tKTMvGRZCi+3lJqd0ldT3FECeaXfj/
   jPcMhgFvlYNESZXAUXWXevIG4KM2luvjgt1fEKtSYBqWe0PewpyifnLSi
   A==;
X-CSE-ConnectionGUID: HLIT/7jmRQuxP3jSRRFRhw==
X-CSE-MsgGUID: SzXxlX/dQweW4jrQvvwBuA==
X-IronPort-AV: E=Sophos;i="6.23,207,1770595200"; 
   d="scan'208";a="18552361"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:25:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:9823]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id 601a5e99-47a7-4ac5-9044-d269cabedf25; Thu, 30 Apr 2026 03:25:34 +0000 (UTC)
X-Farcaster-Flow-ID: 601a5e99-47a7-4ac5-9044-d269cabedf25
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:32 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:27 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH v2 net-next 2/8] selftests/ptp: Extract print_system_timestamp helper in testptp
Date: Thu, 30 Apr 2026 03:24:59 +0000
Message-ID: <20260430032507.11586-3-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430032507.11586-1-akiyano@amazon.com>
References: <20260430032507.11586-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 9382D49CCDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282634-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Extract the repeated switch-on-clockid pattern used for printing
system timestamps into a reusable helper function. This removes
code duplication in the -x (PTP_SYS_OFFSET_EXTENDED) output path
and prepares for additional callers.

No functional change.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 tools/testing/selftests/ptp/testptp.c | 70 ++++++++++++---------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index ed1e288..d3bcfd0 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -153,6 +153,28 @@ static void usage(char *progname)
 		progname, PTP_MAX_SAMPLES);
 }
 
+static void print_system_timestamp(int sample_num, __kernel_clockid_t clockid,
+				   long long sec, unsigned int nsec,
+				   const char *when)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		printf("sample #%2d: real time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	case CLOCK_MONOTONIC:
+		printf("sample #%2d: monotonic time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		printf("sample #%2d: monotonic-raw time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	default:
+		break;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	struct ptp_clock_caps caps;
@@ -608,46 +630,18 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("sample #%2d: real time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("sample #%2d: monotonic time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				default:
-					break;
-				}
+				print_system_timestamp(i, ext_clockid,
+						       soe->ts[i][0].sec,
+						       soe->ts[i][0].nsec,
+						       "before");
+
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("            real time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("            monotonic time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("            monotonic-raw time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				default:
-					break;
-				}
+
+				print_system_timestamp(i, ext_clockid,
+						       soe->ts[i][2].sec,
+						       soe->ts[i][2].nsec,
+						       "after");
 			}
 		}
 
-- 
2.47.3


