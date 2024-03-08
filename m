Return-Path: <netdev+bounces-78803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A67876973
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A4D1C20FF1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFDA28DAB;
	Fri,  8 Mar 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WwjcRtRx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEF286AF
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918230; cv=none; b=rH31uwCvFqRC053nU4141eiSHuzo1fRhkePkMhbI7mAV08tk0zdiZ9Rr+M9TymZMxaCAqoiqLyVMB1gQ1sHXVxxRbVE4KlObmaMHyjXklIWt9e1F179VnPJ9fFsbcijntoW1sZyyf/Z/+iCehTUcWZ4Xu8zREGUztHJh9B9+Bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918230; c=relaxed/simple;
	bh=Q6aOCwF7B4mqldpN86KMTTRsOdvz/XCWq4AmmqKYvuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFDDa+kDAU2FYUXnsd1W09ZgZ440vXkK/8NwAbsmyQAj1Gz/3PtG6/dW4L0Z1iphALf9zhmv2d2wVLYzb5WKaBy/mL/jECkmtsgNpNYNbIneDZ5f8P43PRLYiHqu4BNOG0ZAkHZZB+TWi5akjM86dlrBqnuoTTUHC9Mgx5nV6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WwjcRtRx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so998851b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709918227; x=1710523027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjn1arFOZtY42L3iMyfXjex5TTyrofWpn5NwE42plWs=;
        b=WwjcRtRxQG8Fnwsffagu0MmZZZXkH2Zh3yno6+Id79sMvPlalsRAwuVgQRtS7XwVWy
         r2MBP+mznaknfnbWx1yqxaecEm1YlZoyX8lPU6D+3h046SJqJgVpLbPf3d72uU/8Eyoc
         1aE6t7rx0rxnd+Imi3nGLB6RZ+CyrFwiOOL7qJm3cxcEJtF2AqVHZaPqOqONODO8foYp
         sf2tNIyX9FO8lQXBasRWWePGkndqYx9+t02K54kzK18WZychjAIDrtm0YjgXwZTthkUN
         C2twJUaX7kS6z0Z1tcmCLQEAugvJEKxCrRh7XoWymW9ziTihAgeNImZDSbMVm52XQhho
         fK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918227; x=1710523027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjn1arFOZtY42L3iMyfXjex5TTyrofWpn5NwE42plWs=;
        b=BN56PjrlVWGbnjtAZf3vhM71+nTd3ighP7Du/06kYuIbHMbFOq6FE0iW7JozofGDJn
         jCWpUwjNLgpGls4CIT+ZJNNaZENLTazAgAoQnVn/DyNhzU/vTmOnhKi5nr5u0najpHoH
         JRZbtQ//hjrT6qxLfjJbrAh8ZzV1PvnyCn2CM0qaC1SIIxXrnQ7RNMeh5hbtSGE7DBan
         iWCdT21RusF1/wMfH9QKx02CzYss7M60Z0fj1UNcCwM1Ssz5/lbAJsqn4p1kkRhXeAKn
         MfzQ743DNgX4BS71sk794ViM+dZMEA9Ff7GS+Vk4WEFXSmmyhBUPECV+cJ5q/Y4XR8QI
         SmEA==
X-Gm-Message-State: AOJu0YzH3TSTD1XxwV9vf6Vh9aI0nLCCA45HPnNInaOmwUj5mTX8kIn2
	sJHhURYwJ6iD0GUHhJhWXWDM/5s04jwf26BCcyZ6PXaPI2eHdqbxR+sTrSz1TlzZHuM0+npgSGI
	bRnk=
X-Google-Smtp-Source: AGHT+IHZ1lVeVdoMxHsMo0KvSjz6mJzdAFg17R6UNNLBA5hHr6ccMAMq3UZeRO5RozbS4ngXsBiSoQ==
X-Received: by 2002:a05:6a00:b95:b0:6e6:4ebc:3cd with SMTP id g21-20020a056a000b9500b006e64ebc03cdmr8535090pfj.27.1709918227287;
        Fri, 08 Mar 2024 09:17:07 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm14771413pfq.16.2024.03.08.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:17:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Marc Blanchet <marc.blanchet@viagenie.ca>
Subject: [PATCH iproute2-next 2/3] netem: use 64 bit value for latency and jitter
Date: Fri,  8 Mar 2024 09:16:00 -0800
Message-ID: <20240308171656.9034-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308171656.9034-1-stephen@networkplumber.org>
References: <20240308171656.9034-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current version of netem in iproute2 has a maximum of 4.3
seconds because of scaled 32 bit clock values. Some users would
like to be able to use larger delays to emulate things
like storage delays.

Since kernel version 4.15, netem qdisc had netlink parameters
to express wider range of delays in nanoseconds. But the iproute2
side was never updated to use them.

This does break compatibility with older kernels (4.14 and earlier).
With these out of support kernels, the latency/delay parameter
will end up being ignored.

Reported-by: Marc Blanchet <marc.blanchet@viagenie.ca>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/q_netem.c | 83 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/tc/q_netem.c b/tc/q_netem.c
index 4ce9ab6e529b..86cabbfe7b3a 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -170,26 +170,6 @@ static int get_distribution(const char *type, __s16 *data, int maxdata)
 #define NEXT_IS_SIGNED_NUMBER() \
 	(NEXT_ARG_OK() && (isdigit(argv[1][0]) || argv[1][0] == '-'))
 
-/*
- * Adjust for the fact that psched_ticks aren't always usecs
- *  (based on kernel PSCHED_CLOCK configuration
- */
-static int get_ticks(__u32 *ticks, const char *str)
-{
-	unsigned int t;
-
-	if (get_time(&t, str))
-		return -1;
-
-	if (tc_core_time2big(t)) {
-		fprintf(stderr, "Illegal %u time (too large)\n", t);
-		return -1;
-	}
-
-	*ticks = tc_core_time2tick(t);
-	return 0;
-}
-
 static int netem_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 			   struct nlmsghdr *n, const char *dev)
 {
@@ -208,6 +188,8 @@ static int netem_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	__s16 *slot_dist_data = NULL;
 	__u16 loss_type = NETEM_LOSS_UNSPEC;
 	int present[__TCA_NETEM_MAX] = {};
+	__s64 latency64 = 0;
+	__s64 jitter64 = 0;
 	__u64 rate64 = 0;
 	__u64 seed = 0;
 
@@ -221,14 +203,20 @@ static int netem_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 		} else if (matches(*argv, "latency") == 0 ||
 			   matches(*argv, "delay") == 0) {
 			NEXT_ARG();
-			if (get_ticks(&opt.latency, *argv)) {
+
+			/* Old latency value in opt is no longer used. */
+			present[TCA_NETEM_LATENCY64] = 1;
+
+			if (get_time64(&latency64, *argv)) {
 				explain1("latency");
 				return -1;
 			}
 
 			if (NEXT_IS_NUMBER()) {
 				NEXT_ARG();
-				if (get_ticks(&opt.jitter, *argv)) {
+
+				present[TCA_NETEM_JITTER64] = 1;
+				if (get_time64(&jitter64, *argv)) {
 					explain1("latency");
 					return -1;
 				}
@@ -552,7 +540,7 @@ random_loss_model:
 	tail = NLMSG_TAIL(n);
 
 	if (reorder.probability) {
-		if (opt.latency == 0) {
+		if (latency64 == 0) {
 			fprintf(stderr, "reordering not possible without specifying some delay\n");
 			explain();
 			return -1;
@@ -573,7 +561,7 @@ random_loss_model:
 		}
 	}
 
-	if (dist_data && (opt.latency == 0 || opt.jitter == 0)) {
+	if (dist_data && (latency64 == 0 || jitter64 == 0)) {
 		fprintf(stderr, "distribution specified but no latency and jitter values\n");
 		explain();
 		return -1;
@@ -582,6 +570,14 @@ random_loss_model:
 	if (addattr_l(n, 1024, TCA_OPTIONS, &opt, sizeof(opt)) < 0)
 		return -1;
 
+	if (present[TCA_NETEM_LATENCY64] &&
+	    addattr_l(n, 1024, TCA_NETEM_LATENCY64, &latency64, sizeof(latency64)) < 0)
+		return -1;
+
+	if (present[TCA_NETEM_JITTER64] &&
+	    addattr_l(n, 1024, TCA_NETEM_JITTER64, &jitter64, sizeof(jitter64)) < 0)
+		return -1;
+
 	if (present[TCA_NETEM_CORR] &&
 	    addattr_l(n, 1024, TCA_NETEM_CORR, &cor, sizeof(cor)) < 0)
 		return -1;
@@ -676,6 +672,8 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	__u64 seed = 0;
 	int len;
 	__u64 rate64 = 0;
+	__u64 latency64 = 0;
+	__u64 jitter64 = 0;
 
 	SPRINT_BUF(b1);
 
@@ -734,6 +732,18 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 				return -1;
 			rate64 = rta_getattr_u64(tb[TCA_NETEM_RATE64]);
 		}
+		if (tb[TCA_NETEM_LATENCY64]) {
+			if (RTA_PAYLOAD(tb[TCA_NETEM_LATENCY64]) < sizeof(latency64))
+				return -1;
+			latency64 = rta_getattr_u64(tb[TCA_NETEM_LATENCY64]);
+
+		}
+		if (tb[TCA_NETEM_JITTER64]) {
+			if (RTA_PAYLOAD(tb[TCA_NETEM_JITTER64]) < sizeof(jitter64))
+				return -1;
+			jitter64 = rta_getattr_u64(tb[TCA_NETEM_JITTER64]);
+
+		}
 		if (tb[TCA_NETEM_SLOT]) {
 			if (RTA_PAYLOAD(tb[TCA_NETEM_SLOT]) < sizeof(*slot))
 				return -1;
@@ -749,24 +759,23 @@ static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 
 	print_uint(PRINT_ANY, "limit", "limit %d", qopt.limit);
 
-	if (qopt.latency) {
+
+	if (latency64 != 0) {
 		open_json_object("delay");
-		if (!is_json_context()) {
-			print_string(PRINT_FP, NULL, " delay %s",
-				     sprint_ticks(qopt.latency, b1));
 
-			if (qopt.jitter)
-				print_string(PRINT_FP, NULL, "  %s",
-					     sprint_ticks(qopt.jitter, b1));
-		} else {
+		if (is_json_context()) {
 			print_float(PRINT_JSON, "delay", NULL,
-				    tc_core_tick2time(qopt.latency) /
-				    1000000.);
+				    (double)latency64 / 1000000000.);
 			print_float(PRINT_JSON, "jitter", NULL,
-				    tc_core_tick2time(qopt.jitter) /
-				    1000000.);
+				    (double)jitter64 / 1000000000.);
+		} else {
+			print_string(PRINT_FP, NULL, " delay %s",
+				     sprint_time64(latency64, b1));
+			if (jitter64 != 0)
+				print_string(PRINT_FP, NULL, "  %s",
+					     sprint_time64(jitter64, b1));
 		}
-		print_corr(qopt.jitter && cor && cor->delay_corr,
+		print_corr(jitter64 && cor && cor->delay_corr,
 			   cor ? cor->delay_corr : 0);
 		close_json_object();
 	}
-- 
2.43.0


