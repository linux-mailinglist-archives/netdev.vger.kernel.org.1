Return-Path: <netdev+bounces-282635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pv8J83L8mmWuQEAu9opvQ
	(envelope-from <netdev+bounces-282635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA949CCEB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17968300C6D0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0AF340DA6;
	Thu, 30 Apr 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KCuc3kMs"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD22D5432;
	Thu, 30 Apr 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519540; cv=none; b=VmtVq6xYwEuU1Q6jAaUJ7OkMTrV1mjD0PL49euudWiLlThzaHtErwxUxSU5CgCilA/aapCTbOkf/a42kjVCJKxDr4spodjmoHa3Hj+NiWWT5975d0s1drbXqXJcFob/6oqjNJY13ojp8vcegNBMFAUAYKN99BgG9a4TOlZWTZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519540; c=relaxed/simple;
	bh=fhQVGn8eCoyqgWZRFpQIKMnhVqGyNWNReSidO871/aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp//C+GgRUEHW4qJ/LFtC9WgcHz/R1PgxRRT71cuD3NxFPgYFij8CdrXPW8Xu0/cbasdGZskfEWulomhEy3Zgfc5Xs5IGeObhdItXOosrfAwL8HGbaskaowLsRM42EMKR9LtGtMNDa928J1Y4kiqpyZHoN9aNiflgOItaxRr89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KCuc3kMs; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777519539; x=1809055539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdV9Q0EwyYv6Y1Cx4DKYff4Ebn/kaxIhmn6o8hitAW0=;
  b=KCuc3kMsGei8q81aNtYhnvr8aXBWJgFB2PwZCduYAkzAezn1tTxsSpUO
   T2mGStYXAiP72a89xVFcWt1yc539QHQd5JVTyojGsALVBW0B3LxFpsnML
   UFVi6XMFrqydpPPlg83/QvAvt6hj0cnKWA6DmeYxJmmHFFes+tL9/+fTW
   vQoAtHgNSWiZIHp3VHM9cxrObnw/F8LBaJCEE9NiEP8l1iA6NH+jqhwif
   Nwf8z2jc6DyK9VZCpPRO/Twk/CmewcYZKMxjJwkoeaNnEgf3hSqYk+tvd
   HK+YGslsh4wgVkf/eHYAUAyQTXsr+aSqzOFcs+178jKwjMzuhrcgmQHsh
   w==;
X-CSE-ConnectionGUID: IMiP67+0R3qPBue4zANt1A==
X-CSE-MsgGUID: 1OqeCE4lSjaEkpurnAp6ug==
X-IronPort-AV: E=Sophos;i="6.23,207,1770595200"; 
   d="scan'208";a="18552363"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:25:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:21520]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.227:2525] with esmtp (Farcaster)
 id 4fedb9f3-03fe-4bbe-9463-d3bf9d40dc1c; Thu, 30 Apr 2026 03:25:37 +0000 (UTC)
X-Farcaster-Flow-ID: 4fedb9f3-03fe-4bbe-9463-d3bf9d40dc1c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:36 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 30 Apr 2026 03:25:32 +0000
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
Subject: [PATCH v2 net-next 3/8] selftests/ptp: Add testptp support for attributes ioctls
Date: Thu, 30 Apr 2026 03:25:00 +0000
Message-ID: <20260430032507.11586-4-akiyano@amazon.com>
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
X-Rspamd-Queue-Id: A2CA949CCEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282635-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add support for testing the new PTP_SYS_OFFSET_EXTENDED_ATTRS and
PTP_SYS_OFFSET_PRECISE_ATTRS ioctls in the testptp utility.

New command-line options:
  -a: Get extended offset with attributes (error_bound, clock_status,
      timescale)
  -A: Get precise cross-timestamp with attributes

These options allow testing and validation of PHC devices that provide
clock quality information alongside timestamps.

Also display the new clock_attrs capability in the -c output, and
update print_system_timestamp to print unrecognized clock types instead
of silently dropping them.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 tools/testing/selftests/ptp/testptp.c | 105 +++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index d3bcfd0..99eb346 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -147,10 +147,13 @@ static void usage(char *progname)
 		" -t val     shift the ptp clock time by 'val' seconds\n"
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
+		" -a val     get extended timestamps with attributes (error_bound,\n"
+		"            clock_status, timescale, counter), up to %d samples\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -A         get a precise cross timestamp with attributes\n"
 		" -y val     pre/post tstamp timebase to use {realtime|monotonic|monotonic-raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
-		progname, PTP_MAX_SAMPLES);
+		progname, PTP_MAX_SAMPLES, PTP_MAX_SAMPLES);
 }
 
 static void print_system_timestamp(int sample_num, __kernel_clockid_t clockid,
@@ -171,6 +174,8 @@ static void print_system_timestamp(int sample_num, __kernel_clockid_t clockid,
 		       sample_num, when, sec, nsec);
 		break;
 	default:
+		printf("sample #%2d: unknown clock %d %s: %lld.%09u\n",
+		       sample_num, clockid, when, sec, nsec);
 		break;
 	}
 }
@@ -188,6 +193,8 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_sys_offset_precise_attrs *xtsa;
+	struct ptp_sys_offset_extended_attrs *soea;
 
 	char *progname;
 	unsigned int i;
@@ -208,7 +215,9 @@ int main(int argc, char *argv[])
 	int list_pins = 0;
 	int pct_offset = 0;
 	int getextended = 0;
+	int getextendedattrs = 0;
 	int getcross = 0;
+	int getcrossattrs = 0;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -226,7 +235,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:E:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
+	while (EOF != (c = getopt(argc, argv, "a:Acd:e:E:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -311,9 +320,22 @@ int main(int argc, char *argv[])
 				return -1;
 			}
 			break;
+		case 'a':
+			getextendedattrs = atoi(optarg);
+			if (getextendedattrs < 1 ||
+			    getextendedattrs > PTP_MAX_SAMPLES) {
+				fprintf(stderr,
+					"number of extended attrs timestamp samples must be between 1 and %d; was asked for %d\n",
+					PTP_MAX_SAMPLES, getextendedattrs);
+				return -1;
+			}
+			break;
 		case 'X':
 			getcross = 1;
 			break;
+		case 'A':
+			getcrossattrs = 1;
+			break;
 		case 'y':
 			if (!strcasecmp(optarg, "realtime"))
 				ext_clockid = CLOCK_REALTIME;
@@ -367,6 +389,7 @@ int main(int argc, char *argv[])
 			       "  %d programmable pins\n"
 			       "  %d cross timestamping\n"
 			       "  %d adjust_phase\n"
+			       "  %d clock_attrs\n"
 			       "  %d maximum phase adjustment (ns)\n",
 			       caps.max_adj,
 			       caps.n_alarm,
@@ -376,6 +399,7 @@ int main(int argc, char *argv[])
 			       caps.n_pins,
 			       caps.cross_timestamping,
 			       caps.adjust_phase,
+			       caps.clock_attrs,
 			       caps.max_phase_adj);
 		}
 	}
@@ -648,6 +672,50 @@ int main(int argc, char *argv[])
 		free(soe);
 	}
 
+	if (getextendedattrs) {
+		soea = calloc(1, sizeof(*soea));
+		if (!soea) {
+			perror("calloc");
+			return -1;
+		}
+
+		soea->n_samples = getextendedattrs;
+		soea->clockid = ext_clockid;
+
+		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED_ATTRS, soea)) {
+			perror("PTP_SYS_OFFSET_EXTENDED_ATTRS");
+		} else {
+			printf("extended timestamp request returned %d samples\n",
+			       getextendedattrs);
+
+			for (i = 0; i < getextendedattrs; i++) {
+				print_system_timestamp(i, ext_clockid,
+						       soea->ts[i][0].pct.sec,
+						       soea->ts[i][0].pct.nsec,
+						       "before");
+
+				printf("            phc time: %lld.%09u, error bound: %u, clock status: %u, timescale: %u\n",
+				       soea->ts[i][1].pct.sec,
+				       soea->ts[i][1].pct.nsec,
+				       soea->ts[i][1].att.error_bound,
+				       soea->ts[i][1].att.status,
+				       soea->ts[i][1].att.timescale);
+
+				if (soea->ts[i][1].att.counter_id)
+					printf("            counter: %llu (id: %u)\n",
+					       (unsigned long long)soea->ts[i][1].att.counter_value,
+					       soea->ts[i][1].att.counter_id);
+
+				print_system_timestamp(i, ext_clockid,
+						       soea->ts[i][2].pct.sec,
+						       soea->ts[i][2].pct.nsec,
+						       "after");
+			}
+		}
+
+		free(soea);
+	}
+
 	if (getcross) {
 		xts = calloc(1, sizeof(*xts));
 		if (!xts) {
@@ -671,6 +739,39 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (getcrossattrs) {
+		xtsa = calloc(1, sizeof(*xtsa));
+		if (!xtsa) {
+			perror("calloc");
+			return -1;
+		}
+
+		if (ioctl(fd, PTP_SYS_OFFSET_PRECISE_ATTRS, xtsa)) {
+			perror("PTP_SYS_OFFSET_PRECISE_ATTRS");
+		} else {
+			puts("system and phc crosstimestamping with attributes request okay");
+
+			printf("device time: %lld.%09u\n",
+			       xtsa->device.pct.sec, xtsa->device.pct.nsec);
+			printf("error_bound: %u ns\n",
+			       xtsa->device.att.error_bound);
+			printf("status: %u\n",
+			       xtsa->device.att.status);
+			printf("timescale: %u\n",
+			       xtsa->device.att.timescale);
+			if (xtsa->device.att.counter_id)
+				printf("counter: %llu (id: %u)\n",
+				       (unsigned long long)xtsa->device.att.counter_value,
+				       xtsa->device.att.counter_id);
+			printf("system time: %lld.%09u\n",
+			       xtsa->sys_realtime.sec, xtsa->sys_realtime.nsec);
+			printf("monoraw time: %lld.%09u\n",
+			       xtsa->sys_monoraw.sec, xtsa->sys_monoraw.nsec);
+		}
+
+		free(xtsa);
+	}
+
 	if (channel >= 0) {
 		if (ioctl(fd, PTP_MASK_CLEAR_ALL)) {
 			perror("PTP_MASK_CLEAR_ALL");
-- 
2.47.3


