Return-Path: <netdev+bounces-282003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK/oEU/n8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-282003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D490C4897BB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A371E301651F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DD33C1B7;
	Tue, 28 Apr 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nc/asKT9"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533333C18E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395511; cv=none; b=fJJO1rJRHLld3H4O+HfZaHAeyEtS+ugabpa2I273VVZr8hHlLQqFQOwsv+xIWe/8mxlClLmgIARHZHuJxTgjPXWhfv1WGu+d1K/LrvbBIJXe13Ca7eYNu/hfPvuPB7QOkB77znsM5wF6CgWCnNxtG7iDg4ZXld7UPcrAh0RCQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395511; c=relaxed/simple;
	bh=fhQVGn8eCoyqgWZRFpQIKMnhVqGyNWNReSidO871/aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hwnkhcuc8rdlmNrAJyfVo6vZ3uOUBCyFBNNbi++00SecYDm/w4gMi+bfbZexGEneo7cRdsQJopq6XzCyL5orsbQFcypL8jPvyZFaZNu0Fr1JL9B8eTf47RCkeQXBNqShtSQCZZw6ziU8W/92vZIi6x4yvePq04R+VnhanymJ6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nc/asKT9; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395509; x=1808931509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdV9Q0EwyYv6Y1Cx4DKYff4Ebn/kaxIhmn6o8hitAW0=;
  b=nc/asKT9ItJn2QqejjR/a4dOGEs1CIHJwm7In4QP0UdSroxsyafTxoNX
   61kw3kSGtWODLV0qfsz6sTcSiGr2ypKNy8BwZA70el2Ke21xUtsFj8OKO
   FISu+p4kq+GJcNUeei77A6VuMi8erwNyqR36DlvNv4/6EPcbt1bpzAV6D
   5hm+myI+u/IJ2c/7kKpOqvNyDla+ceCyGuUcYT6XsCrN68ee3tBNc9h58
   ofgMdrrhXdtbsTBB09yRfdRIU+E1BGFG0faRqAqBWuryaFzhUUQGFKsZh
   fVEfeXn1wEkxusozYOafLJzeZpztDO2xzsKTe0SSi3mNxcBC0TfrI4euC
   A==;
X-CSE-ConnectionGUID: xLiODDXoQOu9vBXCh2DpIw==
X-CSE-MsgGUID: mzxXHUOdRAKX/zt0R+elNQ==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="18276025"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25361]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id 53bc9453-6f43-4c5a-bc51-2ac598195858; Tue, 28 Apr 2026 16:58:27 +0000 (UTC)
X-Farcaster-Flow-ID: 53bc9453-6f43-4c5a-bc51-2ac598195858
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:25 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:20 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>
Subject: [PATCH net-next 3/8] selftests/ptp: Add testptp support for attributes ioctls
Date: Tue, 28 Apr 2026 16:54:21 +0000
Message-ID: <20260428165659.2811-4-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428165659.2811-1-akiyano@amazon.com>
References: <20260428165659.2811-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: D490C4897BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282003-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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


