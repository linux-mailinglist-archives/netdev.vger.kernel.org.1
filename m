Return-Path: <netdev+bounces-79568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7593F879E49
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A861F22E30
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0D14404E;
	Tue, 12 Mar 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qd2vVW5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0FE142636
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281677; cv=none; b=psv3N/IAsffbfVPUSxt0MKJ06dus403fzvLM5VrkU6A8XExbq3YyIJiqNBCQEbK0YlYwFeWqU6/eAeuF20wWZN/kxMZq3KjON3tLm7gCRh46FIwpJGc2uSuxy4TT+8UQ1SJQNQ/3S8FDlBkiFohmKnBdBXR1X7Y5phaUPXFkjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281677; c=relaxed/simple;
	bh=kSuWr4HYXMq3u+TmXZ8PlOVjiuVo0dXv0Tw/x3SiXCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHFrud9oPcDdIOL/W1QwpyLOV5KmN+zJNHm1ynz6YfvNYUoIzbLkF8QjNbn7qTVXcYv5qRaXXgLPOu+8LbBMmF+umt8SsTbEMoKUe+BTi5D0jLCbrVhoC2OTpV0McIjXB6G4mGyPobtPL0h5Gnsoeamk6azlQhSCSmUulSrCdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qd2vVW5F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ddbad556a8so8277355ad.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281673; x=1710886473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WupLu2/AyNsf40915UEa5w3vQstYKjAyFhm6zJPCmqc=;
        b=qd2vVW5F9xvk7zijz5mRlw1oEXm1rN2al7B71ZRTCt5TwzXxxvhKxjDswMfct6SgD2
         ApqIOkCthYA0PpoxZuHdagR/lks8Wb4uSSGaaGt2I2MBreSyx++2VHXB0vb9GYl1u3fv
         5MqHtwzXIiIX5pWpRGm7dF3Hx9MDj3/I61k1D165BlmAOy8A/NitzJPmfXtSmMFH95q2
         PMhgMgx4K2fuzjmHH5Pnnf+Cq8xTWYMOTuccup7GBQMDR1LewZZYoJ7ljUpS9vW+IerJ
         Ab0ZW/vkJ0ryIOkX2CWxs4Ni3XV9Et2JS51EM3G6Qe/C8NaXTyQEHpLLPf8RDrXMq5YQ
         e8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281673; x=1710886473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WupLu2/AyNsf40915UEa5w3vQstYKjAyFhm6zJPCmqc=;
        b=D5V0f5mtBbtaeQLQZqxONgClqQmmjf4SD/TWzoyAxkX81F3HJA7DurcPykEaVck1qE
         vCAegYY0hxQ7+WD+OcVkobIlLdQaH7TpZMlYKxTSDRm0vsgdT8M6NrcStHgZAjb6quyK
         /OSXUJXOg76IopZTA6WYF/wMYDrIGF/h2ld4MnTnvF/bRf/24JoawWTCWjabQH7NbInX
         HsxFzY1ZeqDCJ6hlaVC8NfGfKaDUGl14Kif3z4/MNTFC+qwl+v4+jW+xSEevaVcDS+Dm
         P1QGA5FA4y343SrFwLXIyF3RWqYkMr2k4cZh3ycJR7JUfP1IObfjAN18AjFg8PjLDDJ9
         +/jQ==
X-Gm-Message-State: AOJu0YzxILABPm8DVu4jHbWkyvMFNVkfOEhhOmIFN3jwcIxMAxr6V8dc
	fNg4Vl8r3MNsFq9RjY06ouxUP3DKEVJeAMW+VfTbLel4dbobezvkkoeyQ3BRZlNQ2nbv2eJtt3g
	t
X-Google-Smtp-Source: AGHT+IEzInFYI4OgdLKIDqHKoLPjDQ09QC7YaOKo0fiu9YUZ4C0GH/t3nDF1ioVGHjyEmpVgppL9Tw==
X-Received: by 2002:a17:902:ea94:b0:1dc:afd1:9c37 with SMTP id x20-20020a170902ea9400b001dcafd19c37mr8625486plb.24.1710281673366;
        Tue, 12 Mar 2024 15:14:33 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902e28a00b001dcfaab3457sm7240473plc.104.2024.03.12.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/4] tc: make qdisc_util arg const
Date: Tue, 12 Mar 2024 15:12:39 -0700
Message-ID: <20240312221422.81253-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312221422.81253-1-stephen@networkplumber.org>
References: <20240312221422.81253-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callbacks in qdisc_util should not be modifying underlying
qdisc operations structure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/q_cake.c     |  6 +++---
 tc/q_cbs.c      |  4 ++--
 tc/q_choke.c    |  6 +++---
 tc/q_clsact.c   |  4 ++--
 tc/q_codel.c    |  6 +++---
 tc/q_drr.c      |  8 ++++----
 tc/q_etf.c      |  4 ++--
 tc/q_ets.c      |  8 ++++----
 tc/q_fifo.c     |  4 ++--
 tc/q_fq.c       |  6 +++---
 tc/q_fq_codel.c |  6 +++---
 tc/q_fq_pie.c   |  6 +++---
 tc/q_gred.c     |  6 +++---
 tc/q_hfsc.c     | 10 +++++-----
 tc/q_hhf.c      |  6 +++---
 tc/q_htb.c      |  8 ++++----
 tc/q_ingress.c  |  4 ++--
 tc/q_mqprio.c   |  4 ++--
 tc/q_multiq.c   |  4 ++--
 tc/q_netem.c    |  4 ++--
 tc/q_pie.c      |  6 +++---
 tc/q_plug.c     |  4 ++--
 tc/q_prio.c     |  4 ++--
 tc/q_qfq.c      |  6 +++---
 tc/q_red.c      |  8 ++++----
 tc/q_sfb.c      |  6 +++---
 tc/q_sfq.c      |  6 +++---
 tc/q_skbprio.c  |  4 ++--
 tc/q_taprio.c   |  6 +++---
 tc/q_tbf.c      |  4 ++--
 tc/tc.c         |  6 +++---
 tc/tc_class.c   |  6 +++---
 tc/tc_qdisc.c   |  6 +++---
 tc/tc_util.h    | 19 ++++++++++---------
 34 files changed, 103 insertions(+), 102 deletions(-)

diff --git a/tc/q_cake.c b/tc/q_cake.c
index c438b765ec56..e2b8de55e5a2 100644
--- a/tc/q_cake.c
+++ b/tc/q_cake.c
@@ -88,7 +88,7 @@ static void explain(void)
 		"                (* marks defaults)\n");
 }
 
-static int cake_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			  struct nlmsghdr *n, const char *dev)
 {
 	struct cake_preset *preset, *preset_set = NULL;
@@ -415,7 +415,7 @@ static void cake_print_mode(unsigned int value, unsigned int max,
 	}
 }
 
-static int cake_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int cake_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_CAKE_MAX + 1];
 	unsigned int interval = 0;
@@ -614,7 +614,7 @@ static void cake_print_json_tin(struct rtattr **tstat)
 #undef PRINT_TSTAT_JSON
 }
 
-static int cake_print_xstats(struct qdisc_util *qu, FILE *f,
+static int cake_print_xstats(const struct qdisc_util *qu, FILE *f,
 			     struct rtattr *xstats)
 {
 	struct rtattr *st[TCA_CAKE_STATS_MAX + 1];
diff --git a/tc/q_cbs.c b/tc/q_cbs.c
index 788535c6a022..5adfee7f2505 100644
--- a/tc/q_cbs.c
+++ b/tc/q_cbs.c
@@ -29,7 +29,7 @@ static void explain1(const char *arg, const char *val)
 	fprintf(stderr, "cbs: illegal value for \"%s\": \"%s\"\n", arg, val);
 }
 
-static int cbs_parse_opt(struct qdisc_util *qu, int argc,
+static int cbs_parse_opt(const struct qdisc_util *qu, int argc,
 			 char **argv, struct nlmsghdr *n, const char *dev)
 {
 	struct tc_cbs_qopt opt = {};
@@ -103,7 +103,7 @@ static int cbs_parse_opt(struct qdisc_util *qu, int argc,
 	return 0;
 }
 
-static int cbs_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int cbs_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_CBS_MAX+1];
 	struct tc_cbs_qopt *qopt;
diff --git a/tc/q_choke.c b/tc/q_choke.c
index 7653eb7ef9c8..a16f5f680a46 100644
--- a/tc/q_choke.c
+++ b/tc/q_choke.c
@@ -27,7 +27,7 @@ static void explain(void)
 		"		 [ min PACKETS ] [ max PACKETS ] [ burst PACKETS ]\n");
 }
 
-static int choke_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int choke_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			   struct nlmsghdr *n, const char *dev)
 {
 	struct tc_red_qopt opt = {};
@@ -162,7 +162,7 @@ static int choke_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int choke_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int choke_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_CHOKE_MAX+1];
 	const struct tc_red_qopt *qopt;
@@ -203,7 +203,7 @@ static int choke_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int choke_print_xstats(struct qdisc_util *qu, FILE *f,
+static int choke_print_xstats(const struct qdisc_util *qu, FILE *f,
 			      struct rtattr *xstats)
 {
 	struct tc_choke_xstats *st;
diff --git a/tc/q_clsact.c b/tc/q_clsact.c
index 341f653f60b1..5bd9eb20ed0d 100644
--- a/tc/q_clsact.c
+++ b/tc/q_clsact.c
@@ -10,7 +10,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... clsact\n");
 }
 
-static int clsact_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int clsact_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			    struct nlmsghdr *n, const char *dev)
 {
 	if (argc > 0) {
@@ -22,7 +22,7 @@ static int clsact_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int clsact_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int clsact_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	return 0;
 }
diff --git a/tc/q_codel.c b/tc/q_codel.c
index 03b6f92f117c..15029b4cf5d1 100644
--- a/tc/q_codel.c
+++ b/tc/q_codel.c
@@ -28,7 +28,7 @@ static void explain(void)
 		"		 [ ce_threshold TIME ]\n");
 }
 
-static int codel_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			   struct nlmsghdr *n, const char *dev)
 {
 	unsigned int limit = 0;
@@ -95,7 +95,7 @@ static int codel_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int codel_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int codel_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_CODEL_MAX + 1];
 	unsigned int limit;
@@ -147,7 +147,7 @@ static int codel_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int codel_print_xstats(struct qdisc_util *qu, FILE *f,
+static int codel_print_xstats(const struct qdisc_util *qu, FILE *f,
 			      struct rtattr *xstats)
 {
 	struct tc_codel_xstats _st = {}, *st;
diff --git a/tc/q_drr.c b/tc/q_drr.c
index 03c4744f6f26..add684d551f8 100644
--- a/tc/q_drr.c
+++ b/tc/q_drr.c
@@ -28,7 +28,7 @@ static void explain2(void)
 }
 
 
-static int drr_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int drr_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	while (argc) {
@@ -44,7 +44,7 @@ static int drr_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int drr_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
+static int drr_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 			       struct nlmsghdr *n, const char *dev)
 {
 	struct rtattr *tail;
@@ -75,7 +75,7 @@ static int drr_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int drr_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int drr_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_DRR_MAX + 1];
 
@@ -90,7 +90,7 @@ static int drr_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int drr_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
+static int drr_print_xstats(const struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 {
 	struct tc_drr_stats *x;
 
diff --git a/tc/q_etf.c b/tc/q_etf.c
index d16188daabbd..4e89f723428b 100644
--- a/tc/q_etf.c
+++ b/tc/q_etf.c
@@ -39,7 +39,7 @@ static void explain_clockid(const char *val)
 		val);
 }
 
-static int etf_parse_opt(struct qdisc_util *qu, int argc,
+static int etf_parse_opt(const struct qdisc_util *qu, int argc,
 			 char **argv, struct nlmsghdr *n, const char *dev)
 {
 	struct tc_etf_qopt opt = {
@@ -107,7 +107,7 @@ static int etf_parse_opt(struct qdisc_util *qu, int argc,
 	return 0;
 }
 
-static int etf_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int etf_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_ETF_MAX+1];
 	struct tc_etf_qopt *qopt;
diff --git a/tc/q_ets.c b/tc/q_ets.c
index 7380bb2f08b0..dea5f0446501 100644
--- a/tc/q_ets.c
+++ b/tc/q_ets.c
@@ -57,7 +57,7 @@ static int parse_nbands(const char *arg, __u8 *pnbands, const char *what)
 	return 0;
 }
 
-static int ets_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int ets_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	__u8 nbands = 0;
@@ -182,7 +182,7 @@ parse_priomap:
 	return 0;
 }
 
-static int ets_parse_copt(struct qdisc_util *qu, int argc, char **argv,
+static int ets_parse_copt(const struct qdisc_util *qu, int argc, char **argv,
 			  struct nlmsghdr *n, const char *dev)
 {
 	unsigned int quantum = 0;
@@ -276,7 +276,7 @@ static int ets_print_opt_priomap(struct rtattr *opt)
 	return 0;
 }
 
-static int ets_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int ets_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_ETS_MAX + 1];
 	__u8 nbands;
@@ -310,7 +310,7 @@ static int ets_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return ets_print_opt_priomap(tb[TCA_ETS_PRIOMAP]);
 }
 
-static int ets_print_copt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int ets_print_copt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_ETS_MAX + 1];
 	__u32 quantum;
diff --git a/tc/q_fifo.c b/tc/q_fifo.c
index 9b2c5348d375..489208dcf74f 100644
--- a/tc/q_fifo.c
+++ b/tc/q_fifo.c
@@ -22,7 +22,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... <[p|b]fifo | pfifo_head_drop> [ limit NUMBER ]\n");
 }
 
-static int fifo_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int fifo_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			  struct nlmsghdr *n, const char *dev)
 {
 	int ok = 0;
@@ -52,7 +52,7 @@ static int fifo_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int fifo_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int fifo_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_fifo_qopt *qopt;
 
diff --git a/tc/q_fq.c b/tc/q_fq.c
index 7f8a2b80d441..f549be20f19f 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -47,7 +47,7 @@ static unsigned int ilog2(unsigned int val)
 	return res;
 }
 
-static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			struct nlmsghdr *n, const char *dev)
 {
 	struct tc_prio_qopt prio2band;
@@ -337,7 +337,7 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int fq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int fq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_FQ_MAX + 1];
 	unsigned int plimit, flow_plimit;
@@ -490,7 +490,7 @@ static int fq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int fq_print_xstats(struct qdisc_util *qu, FILE *f,
+static int fq_print_xstats(const struct qdisc_util *qu, FILE *f,
 			   struct rtattr *xstats)
 {
 	struct tc_fq_qd_stats *st, _st;
diff --git a/tc/q_fq_codel.c b/tc/q_fq_codel.c
index 9c9d7bc132a3..a619d2b346b1 100644
--- a/tc/q_fq_codel.c
+++ b/tc/q_fq_codel.c
@@ -29,7 +29,7 @@ static void explain(void)
 					"[ drop_batch SIZE ]\n");
 }
 
-static int fq_codel_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int fq_codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			      struct nlmsghdr *n, const char *dev)
 {
 	unsigned int drop_batch = 0;
@@ -157,7 +157,7 @@ static int fq_codel_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int fq_codel_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int fq_codel_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_FQ_CODEL_MAX + 1];
 	unsigned int limit;
@@ -250,7 +250,7 @@ static int fq_codel_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt
 	return 0;
 }
 
-static int fq_codel_print_xstats(struct qdisc_util *qu, FILE *f,
+static int fq_codel_print_xstats(const struct qdisc_util *qu, FILE *f,
 				 struct rtattr *xstats)
 {
 	struct tc_fq_codel_xstats _st = {}, *st;
diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
index 9cbef47eef88..dc2710cdbbe6 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -36,7 +36,7 @@ static void explain(void)
 #define ALPHA_MAX 32
 #define BETA_MAX 32
 
-static int fq_pie_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int fq_pie_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			    struct nlmsghdr *n, const char *dev)
 {
 	unsigned int limit = 0;
@@ -172,7 +172,7 @@ static int fq_pie_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int fq_pie_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int fq_pie_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_FQ_PIE_MAX + 1];
 	unsigned int limit = 0;
@@ -269,7 +269,7 @@ static int fq_pie_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int fq_pie_print_xstats(struct qdisc_util *qu, FILE *f,
+static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 			       struct rtattr *xstats)
 {
 	struct tc_fq_pie_xstats _st = {}, *st;
diff --git a/tc/q_gred.c b/tc/q_gred.c
index f6a3f05eb95e..84fc91244aed 100644
--- a/tc/q_gred.c
+++ b/tc/q_gred.c
@@ -39,7 +39,7 @@ static void explain(void)
 		"           [ probability PROBABILITY ] [ bandwidth KBPS ] [ecn] [harddrop]\n");
 }
 
-static int init_gred(struct qdisc_util *qu, int argc, char **argv,
+static int init_gred(const struct qdisc_util *qu, int argc, char **argv,
 		     struct nlmsghdr *n)
 {
 
@@ -115,7 +115,7 @@ static int init_gred(struct qdisc_util *qu, int argc, char **argv,
 /*
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 */
-static int gred_parse_opt(struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
+static int gred_parse_opt(const struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
 {
 	struct rtattr *tail, *entry, *vqs;
 	int ok = 0;
@@ -406,7 +406,7 @@ gred_print_stats(struct tc_gred_info *info, struct tc_gred_qopt *qopt)
 	print_size(PRINT_ANY, "bytes", "(%s) ", bytes);
 }
 
-static int gred_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int gred_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_gred_info infos[MAX_DPs] = {};
 	struct rtattr *tb[TCA_GRED_MAX + 1];
diff --git a/tc/q_hfsc.c b/tc/q_hfsc.c
index 609d925a42e5..aed7130cc8e6 100644
--- a/tc/q_hfsc.c
+++ b/tc/q_hfsc.c
@@ -65,7 +65,7 @@ explain1(char *arg)
 }
 
 static int
-hfsc_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+hfsc_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	       struct nlmsghdr *n, const char *dev)
 {
 	struct tc_hfsc_qopt qopt = {};
@@ -97,7 +97,7 @@ hfsc_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 }
 
 static int
-hfsc_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+hfsc_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_hfsc_qopt *qopt;
 
@@ -114,7 +114,7 @@ hfsc_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 }
 
 static int
-hfsc_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
+hfsc_print_xstats(const struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 {
 	struct tc_hfsc_stats *st;
 
@@ -136,7 +136,7 @@ hfsc_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 }
 
 static int
-hfsc_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
+hfsc_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 		     struct nlmsghdr *n, const char *dev)
 {
 	struct tc_service_curve rsc = {}, fsc = {}, usc = {};
@@ -220,7 +220,7 @@ hfsc_print_sc(FILE *f, char *name, struct tc_service_curve *sc)
 }
 
 static int
-hfsc_print_class_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+hfsc_print_class_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_HFSC_MAX+1];
 	struct tc_service_curve *rsc = NULL, *fsc = NULL, *usc = NULL;
diff --git a/tc/q_hhf.c b/tc/q_hhf.c
index 95e49f3dd720..939e490939e6 100644
--- a/tc/q_hhf.c
+++ b/tc/q_hhf.c
@@ -26,7 +26,7 @@ static void explain(void)
 		"		[ non_hh_weight NUMBER ]\n");
 }
 
-static int hhf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int hhf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	unsigned int limit = 0;
@@ -117,7 +117,7 @@ static int hhf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int hhf_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int hhf_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_HHF_MAX + 1];
 	unsigned int limit;
@@ -179,7 +179,7 @@ static int hhf_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int hhf_print_xstats(struct qdisc_util *qu, FILE *f,
+static int hhf_print_xstats(const struct qdisc_util *qu, FILE *f,
 			    struct rtattr *xstats)
 {
 	struct tc_hhf_xstats *st;
diff --git a/tc/q_htb.c b/tc/q_htb.c
index 9afb293d9455..545152ff2a74 100644
--- a/tc/q_htb.c
+++ b/tc/q_htb.c
@@ -53,7 +53,7 @@ static void explain1(char *arg)
 	explain();
 }
 
-static int htb_parse_opt(struct qdisc_util *qu, int argc,
+static int htb_parse_opt(const struct qdisc_util *qu, int argc,
 			 char **argv, struct nlmsghdr *n, const char *dev)
 {
 	unsigned int direct_qlen = ~0U;
@@ -107,7 +107,7 @@ static int htb_parse_opt(struct qdisc_util *qu, int argc,
 	return 0;
 }
 
-static int htb_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
+static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 			       struct nlmsghdr *n, const char *dev)
 {
 	struct tc_htb_opt opt = {};
@@ -263,7 +263,7 @@ static int htb_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int htb_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int htb_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_HTB_MAX + 1];
 	struct tc_htb_opt *hopt;
@@ -354,7 +354,7 @@ static int htb_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int htb_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
+static int htb_print_xstats(const struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 {
 	struct tc_htb_xstats *st;
 
diff --git a/tc/q_ingress.c b/tc/q_ingress.c
index 3df4914c7d64..294b0051225c 100644
--- a/tc/q_ingress.c
+++ b/tc/q_ingress.c
@@ -16,7 +16,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... ingress\n");
 }
 
-static int ingress_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int ingress_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			     struct nlmsghdr *n, const char *dev)
 {
 	while (argc > 0) {
@@ -33,7 +33,7 @@ static int ingress_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int ingress_print_opt(struct qdisc_util *qu, FILE *f,
+static int ingress_print_opt(const struct qdisc_util *qu, FILE *f,
 			     struct rtattr *opt)
 {
 	print_string(PRINT_FP, NULL, "---------------- ", NULL);
diff --git a/tc/q_mqprio.c b/tc/q_mqprio.c
index 7a4417f5363b..493c6eb5d641 100644
--- a/tc/q_mqprio.c
+++ b/tc/q_mqprio.c
@@ -46,7 +46,7 @@ static void add_tc_entries(struct nlmsghdr *n, __u32 fp[TC_QOPT_MAX_QUEUE],
 	}
 }
 
-static int mqprio_parse_opt(struct qdisc_util *qu, int argc,
+static int mqprio_parse_opt(const struct qdisc_util *qu, int argc,
 			    char **argv, struct nlmsghdr *n, const char *dev)
 {
 	int idx;
@@ -314,7 +314,7 @@ static void dump_tc_entries(FILE *f, struct rtattr *opt, int len)
 	}
 }
 
-static int mqprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int mqprio_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	int i;
 	struct tc_mqprio_qopt *qopt;
diff --git a/tc/q_multiq.c b/tc/q_multiq.c
index b1e6c9a83708..63fffed42cf2 100644
--- a/tc/q_multiq.c
+++ b/tc/q_multiq.c
@@ -28,7 +28,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... multiq [help]\n");
 }
 
-static int multiq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int multiq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			    struct nlmsghdr *n, const char *dev)
 {
 	struct tc_multiq_qopt opt = {};
@@ -48,7 +48,7 @@ static int multiq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int multiq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int multiq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_multiq_qopt *qopt;
 
diff --git a/tc/q_netem.c b/tc/q_netem.c
index 4ce9ab6e529b..3954d1f3e486 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -190,7 +190,7 @@ static int get_ticks(__u32 *ticks, const char *str)
 	return 0;
 }
 
-static int netem_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int netem_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			   struct nlmsghdr *n, const char *dev)
 {
 	int dist_size = 0;
@@ -661,7 +661,7 @@ random_loss_model:
 	return 0;
 }
 
-static int netem_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int netem_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	const struct tc_netem_corr *cor = NULL;
 	const struct tc_netem_reorder *reorder = NULL;
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 177cdcae0f2e..04c9aa614b2b 100644
--- a/tc/q_pie.c
+++ b/tc/q_pie.c
@@ -30,7 +30,7 @@ static void explain(void)
 #define ALPHA_MAX 32
 #define BETA_MAX 32
 
-static int pie_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int pie_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	unsigned int limit   = 0;
@@ -124,7 +124,7 @@ static int pie_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int pie_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int pie_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_PIE_MAX + 1];
 	unsigned int limit;
@@ -198,7 +198,7 @@ static int pie_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int pie_print_xstats(struct qdisc_util *qu, FILE *f,
+static int pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 			    struct rtattr *xstats)
 {
 	struct tc_pie_xstats *st;
diff --git a/tc/q_plug.c b/tc/q_plug.c
index 8adf9b9604e7..257735a2dd67 100644
--- a/tc/q_plug.c
+++ b/tc/q_plug.c
@@ -22,7 +22,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... plug [block | release | release_indefinite | limit NUMBER]\n");
 }
 
-static int plug_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int plug_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			  struct nlmsghdr *n, const char *dev)
 {
 	struct tc_plug_qopt opt = {};
@@ -62,7 +62,7 @@ static int plug_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int plug_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int plug_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	/* dummy implementation as sch_plug does not implement a dump op */
 	return 0;
diff --git a/tc/q_prio.c b/tc/q_prio.c
index a3781ffe8b2c..41bd98a58b1b 100644
--- a/tc/q_prio.c
+++ b/tc/q_prio.c
@@ -22,7 +22,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... prio bands NUMBER priomap P1 P2...[multiqueue]\n");
 }
 
-static int prio_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int prio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			  struct nlmsghdr *n, const char *dev)
 {
 	int pmap_mode = 0;
@@ -89,7 +89,7 @@ static int prio_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-int prio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+int prio_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	int i;
 	struct tc_prio_qopt *qopt;
diff --git a/tc/q_qfq.c b/tc/q_qfq.c
index c9955cc96a97..d4c0a5916587 100644
--- a/tc/q_qfq.c
+++ b/tc/q_qfq.c
@@ -30,7 +30,7 @@ static void explain_class(void)
 	fprintf(stderr, "Usage: ... qfq weight NUMBER maxpkt BYTES\n");
 }
 
-static int qfq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int qfq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	if (argc > 0) {
@@ -43,7 +43,7 @@ static int qfq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int qfq_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
+static int qfq_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 			       struct nlmsghdr *n, const char *dev)
 {
 	struct rtattr *tail;
@@ -80,7 +80,7 @@ static int qfq_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int qfq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int qfq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_QFQ_MAX + 1];
 
diff --git a/tc/q_red.c b/tc/q_red.c
index f760253d13b2..1aa6d2b174a2 100644
--- a/tc/q_red.c
+++ b/tc/q_red.c
@@ -40,7 +40,7 @@ static struct qevent_util qevents[] = {
 	{},
 };
 
-static int red_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int red_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	struct nla_bitfield32 flags_bf = {
@@ -180,7 +180,7 @@ static int red_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int red_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int red_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_RED_MAX + 1];
 	struct nla_bitfield32 *flags_bf;
@@ -232,7 +232,7 @@ static int red_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int red_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
+static int red_print_xstats(const struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
 {
 #ifdef TC_RED_ECN
 	struct tc_red_xstats *st;
@@ -252,7 +252,7 @@ static int red_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstat
 	return 0;
 }
 
-static int red_has_block(struct qdisc_util *qu, struct rtattr *opt, __u32 block_idx, bool *p_has)
+static int red_has_block(const struct qdisc_util *qu, struct rtattr *opt, __u32 block_idx, bool *p_has)
 {
 	struct rtattr *tb[TCA_RED_MAX + 1];
 
diff --git a/tc/q_sfb.c b/tc/q_sfb.c
index a2eef281e10f..6a26b71a83e1 100644
--- a/tc/q_sfb.c
+++ b/tc/q_sfb.c
@@ -40,7 +40,7 @@ static int get_prob(__u32 *val, const char *arg)
 	return 0;
 }
 
-static int sfb_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int sfb_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	struct tc_sfb_qopt opt = {
@@ -131,7 +131,7 @@ static int sfb_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int sfb_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int sfb_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[__TCA_SFB_MAX];
 	struct tc_sfb_qopt *qopt;
@@ -173,7 +173,7 @@ static int sfb_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int sfb_print_xstats(struct qdisc_util *qu, FILE *f,
+static int sfb_print_xstats(const struct qdisc_util *qu, FILE *f,
 			    struct rtattr *xstats)
 {
 	struct tc_sfb_xstats *st;
diff --git a/tc/q_sfq.c b/tc/q_sfq.c
index 17bf8f63f105..37ebd977cb9a 100644
--- a/tc/q_sfq.c
+++ b/tc/q_sfq.c
@@ -30,7 +30,7 @@ static void explain(void)
 		"		[ ecn ] [ harddrop ]\n");
 }
 
-static int sfq_parse_opt(struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
+static int sfq_parse_opt(const struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
 {
 	int ok = 0, red = 0;
 	struct tc_sfq_qopt_v1 opt = {};
@@ -196,7 +196,7 @@ static int sfq_parse_opt(struct qdisc_util *qu, int argc, char **argv, struct nl
 	return 0;
 }
 
-static int sfq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int sfq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_sfq_qopt *qopt;
 	struct tc_sfq_qopt_v1 *qopt_ext = NULL;
@@ -255,7 +255,7 @@ static int sfq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int sfq_print_xstats(struct qdisc_util *qu, FILE *f,
+static int sfq_print_xstats(const struct qdisc_util *qu, FILE *f,
 			    struct rtattr *xstats)
 {
 	struct tc_sfq_xstats *st;
diff --git a/tc/q_skbprio.c b/tc/q_skbprio.c
index b0ba180ab9c4..910ea998330a 100644
--- a/tc/q_skbprio.c
+++ b/tc/q_skbprio.c
@@ -23,7 +23,7 @@ static void explain(void)
 	fprintf(stderr, "Usage: ... <skbprio> [ limit NUMBER ]\n");
 }
 
-static int skbprio_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int skbprio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			     struct nlmsghdr *n, const char *dev)
 {
 	int ok = 0;
@@ -58,7 +58,7 @@ static int skbprio_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int skbprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int skbprio_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct tc_skbprio_qopt *qopt;
 
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index c47fe244369f..416a222a8ef6 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -134,7 +134,7 @@ static void add_tc_entries(struct nlmsghdr *n, __u32 max_sdu[TC_QOPT_MAX_QUEUE],
 	}
 }
 
-static int taprio_parse_opt(struct qdisc_util *qu, int argc,
+static int taprio_parse_opt(const struct qdisc_util *qu, int argc,
 			    char **argv, struct nlmsghdr *n, const char *dev)
 {
 	__u32 max_sdu[TC_QOPT_MAX_QUEUE] = { };
@@ -545,7 +545,7 @@ static void dump_tc_entries(FILE *f, struct rtattr *opt)
 	}
 }
 
-static int taprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int taprio_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_TAPRIO_ATTR_MAX + 1];
 	struct tc_mqprio_qopt *qopt = 0;
@@ -623,7 +623,7 @@ static int taprio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int taprio_print_xstats(struct qdisc_util *qu, FILE *f,
+static int taprio_print_xstats(const struct qdisc_util *qu, FILE *f,
 			       struct rtattr *xstats)
 {
 	struct rtattr *tb[TCA_TAPRIO_OFFLOAD_STATS_MAX + 1], *nla;
diff --git a/tc/q_tbf.c b/tc/q_tbf.c
index f621756d96e6..9356dfd2abcb 100644
--- a/tc/q_tbf.c
+++ b/tc/q_tbf.c
@@ -31,7 +31,7 @@ static void explain1(const char *arg, const char *val)
 }
 
 
-static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
+static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	struct tc_tbf_qopt opt = {};
@@ -245,7 +245,7 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int tbf_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
+static int tbf_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 {
 	struct rtattr *tb[TCA_TBF_MAX+1];
 	struct tc_tbf_qopt *qopt;
diff --git a/tc/tc.c b/tc/tc.c
index 7a746cf5115e..5191b4bd8cde 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -48,7 +48,7 @@ static void *BODY;	/* cached handle dlopen(NULL) */
 static struct qdisc_util *qdisc_list;
 static struct filter_util *filter_list;
 
-static int print_noqopt(struct qdisc_util *qu, FILE *f,
+static int print_noqopt(const struct qdisc_util *qu, FILE *f,
 			struct rtattr *opt)
 {
 	if (opt && RTA_PAYLOAD(opt))
@@ -57,7 +57,7 @@ static int print_noqopt(struct qdisc_util *qu, FILE *f,
 	return 0;
 }
 
-static int parse_noqopt(struct qdisc_util *qu, int argc, char **argv,
+static int parse_noqopt(const struct qdisc_util *qu, int argc, char **argv,
 			struct nlmsghdr *n, const char *dev)
 {
 	if (argc) {
@@ -102,7 +102,7 @@ static int parse_nofopt(struct filter_util *qu, char *fhandle,
 	return 0;
 }
 
-struct qdisc_util *get_qdisc_kind(const char *str)
+const struct qdisc_util *get_qdisc_kind(const char *str)
 {
 	void *dlh;
 	char buf[256];
diff --git a/tc/tc_class.c b/tc/tc_class.c
index f6a3d134f595..6d707d8c924f 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -61,7 +61,7 @@ static int tc_class_modify(int cmd, unsigned int flags, int argc, char **argv)
 		.n.nlmsg_type = cmd,
 		.t.tcm_family = AF_UNSPEC,
 	};
-	struct qdisc_util *q = NULL;
+	const struct qdisc_util *q = NULL;
 	struct tc_estimator est = {};
 	char  d[IFNAMSIZ] = {};
 	char  k[FILTER_NAMESZ] = {};
@@ -213,7 +213,7 @@ static void graph_cls_show(FILE *fp, char *buf, struct hlist_head *root_list,
 	struct hlist_node *n, *tmp_cls;
 	char cls_id_str[256] = {};
 	struct rtattr *tb[TCA_MAX + 1];
-	struct qdisc_util *q;
+	const struct qdisc_util *q;
 	char str[300] = {};
 
 	hlist_for_each_safe(n, tmp_cls, root_list) {
@@ -298,7 +298,7 @@ int print_class(struct nlmsghdr *n, void *arg)
 	struct tcmsg *t = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
 	struct rtattr *tb[TCA_MAX + 1];
-	struct qdisc_util *q;
+	const struct qdisc_util *q;
 	char abuf[256];
 
 	if (n->nlmsg_type != RTM_NEWTCLASS && n->nlmsg_type != RTM_DELTCLASS) {
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 84fd659f7d1f..7eb9a31baa31 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -42,7 +42,7 @@ static int usage(void)
 
 static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
 {
-	struct qdisc_util *q = NULL;
+	const struct qdisc_util *q = NULL;
 	struct tc_estimator est = {};
 	struct {
 		struct tc_sizespec	szopts;
@@ -217,7 +217,7 @@ int print_qdisc(struct nlmsghdr *n, void *arg)
 	struct tcmsg *t = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
 	struct rtattr *tb[TCA_MAX+1];
-	struct qdisc_util *q;
+	const struct qdisc_util *q;
 	char abuf[256];
 
 	if (n->nlmsg_type != RTM_NEWQDISC && n->nlmsg_type != RTM_DELQDISC) {
@@ -476,7 +476,7 @@ static int tc_qdisc_block_exists_cb(struct nlmsghdr *n, void *arg)
 	struct tcmsg *t = NLMSG_DATA(n);
 	struct rtattr *tb[TCA_MAX+1];
 	int len = n->nlmsg_len;
-	struct qdisc_util *q;
+	const struct qdisc_util *q;
 	const char *kind;
 	int err;
 
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 623d9888a5ad..bcd661ea4626 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -29,19 +29,20 @@ enum
 #define FILTER_NAMESZ	16
 
 struct qdisc_util {
-	struct  qdisc_util *next;
+	struct qdisc_util *next;
 	const char *id;
-	int (*parse_qopt)(struct qdisc_util *qu, int argc,
+	int (*parse_qopt)(const struct qdisc_util *qu, int argc,
 			  char **argv, struct nlmsghdr *n, const char *dev);
-	int (*print_qopt)(struct qdisc_util *qu,
+	int (*print_qopt)(const struct qdisc_util *qu,
 			  FILE *f, struct rtattr *opt);
-	int (*print_xstats)(struct qdisc_util *qu,
+	int (*print_xstats)(const struct qdisc_util *qu,
 			    FILE *f, struct rtattr *xstats);
 
-	int (*parse_copt)(struct qdisc_util *qu, int argc,
+	int (*parse_copt)(const struct qdisc_util *qu, int argc,
 			  char **argv, struct nlmsghdr *n, const char *dev);
-	int (*print_copt)(struct qdisc_util *qu, FILE *f, struct rtattr *opt);
-	int (*has_block)(struct qdisc_util *qu, struct rtattr *opt, __u32 block_idx, bool *p_has);
+	int (*print_copt)(const struct qdisc_util *qu, FILE *f, struct rtattr *opt);
+	int (*has_block)(const struct qdisc_util *qu, struct rtattr *opt,
+			 __u32 block_idx, bool *p_has);
 };
 
 extern __u16 f_proto;
@@ -72,7 +73,7 @@ struct exec_util {
 
 const char *get_tc_lib(void);
 
-struct qdisc_util *get_qdisc_kind(const char *str);
+const struct qdisc_util *get_qdisc_kind(const char *str);
 struct filter_util *get_filter_kind(const char *str);
 
 int get_qdisc_handle(__u32 *h, const char *str);
@@ -115,7 +116,7 @@ int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
 int tc_print_action(FILE *f, const struct rtattr *tb, unsigned short tot_acts);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
 void print_tm(FILE *f, const struct tcf_t *tm);
-int prio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt);
+int prio_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt);
 
 int cls_names_init(char *path);
 void cls_names_uninit(void);
-- 
2.43.0


