Return-Path: <netdev+bounces-270440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GcLB50JwWmtPwQAu9opvQ
	(envelope-from <netdev+bounces-270440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:36:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DA2EF2C0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06C8E3010B80
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F1386C09;
	Mon, 23 Mar 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ps7KE2DC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDED386572
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258307; cv=none; b=uyzgE7hbeAajs5SZ3nCU1GVA8ok+bVOCidGVOkM3afUBRAsKdXsKp+rwnerI/Pd9tSmm/qwxXrBjoNZS/bAKB3SlMK9uMhIi0DJj8Xs5wBkOqAFe8uifQGS03BtDS8eJh6Li+ebD2WshO8htvf0d+sjM63Bs/B8r414mcIfZVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258307; c=relaxed/simple;
	bh=nCv6JrfTbinl7A/3qK28MS9LHF8fUjNeaeDPjE4EH44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdgIM8Bbh1P/9r9kM1WNXRFzOdLc7gD0JJsEwGkj1sQPcFscdxA8TXI4xHpQ+xRmlChF4hGKa6Dany4O3NFhx8KgxW81zYhnV/BQ0w0TNmPmWeX5bWBeHsoKmUHOFRKB25s7t7AmCRaWzC0yVNpKD+Dw4P8C1S6y2ZOTGjCq8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ps7KE2DC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C77D3F1CC
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774258297;
	bh=gEESZKfxvXFSfUUhWLI7fyEjb9Ih3f2o4yX3JzPSuQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ps7KE2DC+O6VtbD1inT8DBlDYgiZ955mbl9HKDsFYGmKr+nbF+Sfhma1kwfP0fRLp
	 KAUTJijzD0MxC6jlg1kERcRJW+hPW2ADDgnshLQbE2bqWSKJtfV9ZlSQlKG74h34K6
	 QukAPvfdP28N+qkJ8Yzjd6nebM6DfhPY9hQJvW03wTjsdIyQQMr+Se0IYx6ieHiImQ
	 tIRlMTOld354HYNCB6axH8Fn5xJ678/4OcVToGp0xjeuY4V7clkNC0OaMB5WIRMQuR
	 ySLm/UCcFYYxhoZxJZyTtXhbL1l1sdJQjW6mrOHnIqy6ohqHDT8R1YU4V+Rz1fQoa1
	 zxbs06hLhiR9ivCJpsBJsNX7eMqTLZI7OlmDBDw7UgwqpUmIs6+H8qhkdKtSlf4wP5
	 3DljFK8WqsTxVMp3ALP+dQgR1PPmOhxZojIY7Ml0nmW0FXcvEE/7bvxnRfOJb5xAoM
	 Pi+m0/QrWi0asvqutCGRwJ050dJV9LhcOuXHHk6rA5m99ac6nleBFOeynlUy+uYbEj
	 nKN0Ol0E18v+bFhkd3BcmO6qcdN8nkoN5SyoxnKGDiKlqVYlHxzVoXeHeS7jen8fgk
	 pGaf5OiQXLf7SzRD6cnoQXtUtwYwbH8UW1h5oMwbDmYNZhPg1tcW/w9z3HzDy5aP1i
	 hf4ZpSW8h7jfD5Yn+YHsZvZs=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c794edd9so3733032f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 02:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258297; x=1774863097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEESZKfxvXFSfUUhWLI7fyEjb9Ih3f2o4yX3JzPSuQ4=;
        b=PVB1cTzt7wmv/ZnOBo73iAqtspcyBBsNTdEjQo7tdM1cBUvsysTFHtBsaSliFwWsv0
         Zc5H4lOmW059hw72I7LzUvsG19lH1ocT3Zzca92Ae+knb1TQeevNvqSXLoJ8WgDOo8jN
         zBcMWJhSRFn9Q561VrbXr4V08bR4Jzk6snmZo4xsGGb2nsO1YOaSeSxSIgIqIMgqMUcI
         5QawKxSdxfki3zGNUhnDjAbDsxdGKrioaSS5nRO/2jL+cFbeyZFxBEH5MXSO+htAPgZ2
         FeK7kW+//tEJQkxnrfktLy32zHiUbEotDHM2psBr6jdktsBt39W6o0ut1hE3+PiaTk3E
         E0Aw==
X-Gm-Message-State: AOJu0Yxm13c5NPxbWVq+n5Y/9LrW3UhyLPzjC2xc0SJCKH8nv4iV/6G4
	shEVuWUyMljafrk9y5RXMtKCn07+Ctao5Z10yYh5RY+xYaY7NbxBeNQCB2yIKkwshiXanZlBRWe
	HcpEkYHL4kQRIBAtS/xawtcRzpwobMlryo6Su2wq+II3sHhEFctZ4crpruPNiV3CCZHt3UESG/k
	ZzKfiuaw==
X-Gm-Gg: ATEYQzyNlKK/YATBN2ilacDmAJ5BqU5Yndc62D6y0sEWtSnRfU2KpsMkdFHPA6xUfOo
	28h4m7QRuv5Q2izAZ6CofnJdM8rETCWatJWfhAaR2OKgtb8LmOGwuVFNaKePoofkeVg07eW4j1M
	wQL+OmF13vUkj9GQNN/Jnz6ROLjSSo1mNGZgwlnUkosZUSnx58gzbSVWgdshYaZIRVmFye9UgGV
	qVzbHM3Xa6VcMrCBl6KrtTqea6NY7jW6pqPvpMUj6Fm56JpEctF5jnxJhr+6vcfAykRy2d5FE+D
	SBojzwIINz2r7QGWNbLaYBmUhVMk80mKYa8Xr28BGDbw+6b5mX2f+pGUiUn1a62o0xtucMlss5C
	JKssf8U8h3TFEJsIMRNh/AAgbDLvQJpI/
X-Received: by 2002:a05:6000:2906:b0:43b:509c:4275 with SMTP id ffacd0b85a97d-43b6423bf47mr17477842f8f.16.1774258296634;
        Mon, 23 Mar 2026 02:31:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2906:b0:43b:509c:4275 with SMTP id ffacd0b85a97d-43b6423bf47mr17477769f8f.16.1774258296056;
        Mon, 23 Mar 2026 02:31:36 -0700 (PDT)
Received: from devstation.. ([194.120.133.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm18901032f8f.9.2026.03.23.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:31:35 -0700 (PDT)
From: Ioana Lazea <ioana.lazea@canonical.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	jay.vosburgh@canonical.com
Subject: [PATCH iproute2-next 1/2] tc/tbf: enable use of 64 bit burst 
Date: Mon, 23 Mar 2026 09:29:12 +0000
Message-ID: <20260323092918.11010-2-ioana.lazea@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323092918.11010-1-ioana.lazea@canonical.com>
References: <20260323092918.11010-1-ioana.lazea@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,networkplumber.org,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-270440-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.lazea@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 885DA2EF2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Modify the TBF queueing discipline configuration to allow burst sizes up
to the limits supported by the kernel API, which may exceed 4 GB at
higher rates.

In the current implementation, the burst option is effectively limited
to 4 GB because it is stored in a 32-bit field. However, the kernel
internally represents the burst in psched ticks (64 nsec each). At
sufficiently high rates, this representation can correspond to burst
sizes larger than 4 GB without requiring kernel changes.

Overflows (burst values that exceed UINT_MAX psched ticks) are now
correctly detected, and flagged as an error, rather than passing
arbitrary psched tick values to the kernel.

The change to increase the burst size to 64-bit introduced an issue with
TCA_TBF_BURST. The kernel expects this attribute as NLA_U32 (a 32-bit
unsigned value), but the updated implementation may produce a 64-bit
value, causing the tbf_policy check in the kernel to fail. However, when
TCA_TBF_BURST is omitted (which occurs when buffer64 >= UINT_MAX), the
kernel falls back to using the value assigned to qopt->buffer, which
correctly supports large burst sizes. Omitting TCA_TBF_BURST for large
bursts preserves backward compatibility and aligns with existing kernel
behavior. This change therefore ensures correct handling of large burst
sizes while remaining compatible with kernel and iproute2 expectations.

Signed-off-by: Ioana Lazea <ioana.lazea@canonical.com>
---
 tc/q_tbf.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tc/q_tbf.c b/tc/q_tbf.c
index 9356dfd2..cbe11025 100644
--- a/tc/q_tbf.c
+++ b/tc/q_tbf.c
@@ -37,12 +37,12 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	struct tc_tbf_qopt opt = {};
 	__u32 rtab[256];
 	__u32 ptab[256];
-	unsigned buffer = 0, mtu = 0, mpu = 0, latency = 0;
+	unsigned mtu = 0, mpu = 0, latency = 0;
 	int Rcell_log =  -1, Pcell_log = -1;
 	unsigned short overhead = 0;
 	unsigned int linklayer = LINKLAYER_ETHERNET; /* Assume ethernet */
 	struct rtattr *tail;
-	__u64 rate64 = 0, prate64 = 0;
+	__u64 rate64 = 0, prate64 = 0, buffer64 = 0;
 
 	while (argc > 0) {
 		if (matches(*argv, "limit") == 0) {
@@ -79,11 +79,11 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			const char *parm_name = *argv;
 
 			NEXT_ARG();
-			if (buffer) {
+			if (buffer64) {
 				fprintf(stderr, "tbf: duplicate \"buffer/burst/maxburst\" specification\n");
 				return -1;
 			}
-			if (get_size_and_cell(&buffer, &Rcell_log, *argv) < 0) {
+			if (get_size64_and_cell(&buffer64, &Rcell_log, *argv) < 0) {
 				explain1(parm_name, *argv);
 				return -1;
 			}
@@ -175,7 +175,7 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		fprintf(stderr, "tbf: the \"rate\" parameter is mandatory.\n");
 		verdict = -1;
 	}
-	if (!buffer) {
+	if (!buffer64) {
 		fprintf(stderr, "tbf: the \"burst\" parameter is mandatory.\n");
 		verdict = -1;
 	}
@@ -200,7 +200,7 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	opt.peakrate.rate = (prate64 >= (1ULL << 32)) ? ~0U : prate64;
 
 	if (opt.limit == 0) {
-		double lim = rate64*(double)latency/TIME_UNITS_PER_SEC + buffer;
+		double lim = rate64*(double)latency/TIME_UNITS_PER_SEC + buffer64;
 
 		if (prate64) {
 			double lim2 = prate64*(double)latency/TIME_UNITS_PER_SEC + mtu;
@@ -217,7 +217,11 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		fprintf(stderr, "tbf: failed to calculate rate table.\n");
 		return -1;
 	}
-	opt.buffer = tc_calc_xmittime(opt.rate.rate, buffer);
+	opt.buffer = tc_calc_xmittime(opt.rate.rate, buffer64);
+	if (opt.buffer == UINT_MAX) {
+		fprintf(stderr, "tbf: burst out of range\n");
+		return -1;
+	}
 
 	if (opt.peakrate.rate) {
 		opt.peakrate.mpu      = mpu;
@@ -231,7 +235,11 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 
 	tail = addattr_nest(n, 1024, TCA_OPTIONS);
 	addattr_l(n, 2024, TCA_TBF_PARMS, &opt, sizeof(opt));
-	addattr_l(n, 2124, TCA_TBF_BURST, &buffer, sizeof(buffer));
+	if (buffer64 < (1ULL << 32)) {
+		__u32 buffer32 = (__u32)buffer64;
+
+		addattr_l(n, 2124, TCA_TBF_BURST, &buffer32, sizeof(buffer32));
+	}
 	if (rate64 >= (1ULL << 32))
 		addattr_l(n, 2124, TCA_TBF_RATE64, &rate64, sizeof(rate64));
 	addattr_l(n, 3024, TCA_TBF_RTAB, rtab, 1024);
-- 
2.43.0


