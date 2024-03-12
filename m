Return-Path: <netdev+bounces-79570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEB879E4B
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B0B21ADD
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B91448C0;
	Tue, 12 Mar 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hGpnyLno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC3144020
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281677; cv=none; b=egkRkZdNsBC9leSyb5TUqZFhgfvkyDTTR6hP1UtigtOZClOAmSQPk9Ry/t9lHltGwM36Ei7CXyRjYlpVAbubDBwUI6bGANr7r4kQz2YFjKcPg85tyIon2un9KTPR6KZuYQA0sNlAZ9BI2V+Go1CJEQEyk1KXfV5fC8FXeXnerZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281677; c=relaxed/simple;
	bh=qgXCGolpeqyoA7jmuGRwpDe8Z34ghJ2jbVn9Fm3RFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMvp4wr6pGwCKLPpYy8mHZfJ0cjYk4tZj3CphGawwpx+vYzULCXF6B8mAToyPooerKlgZ7R7pM8hnFP9kvjOQo1/5xctgmIbdDB355V52mrgtS775Jy/PPBxn3L557WDRhycyr+dyxZRdf7LaI3OIaHywzxG3NJ3A3yljNXfUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hGpnyLno; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd916ad172so23158435ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281675; x=1710886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gEiCM1jx27sar3LPmESI0xMYjbB5scD0lmI2N8CVFI=;
        b=hGpnyLnoPZhNRSY5rz5hhQR+RFF6pBQ6gIIXBhhVy3cuhS+epb2AcbdV69KhuBKto2
         e6lcfbpKPn2SvljY06rv2Pq2ZB3NgSYafM6bhF8yrMVAWk3B2phqXSUf+tKM7CeHIpxO
         v5AyJDEQcIH7GMB8yz7x0rM/ihwxhfGFEPYFRLNzZHW34GOHOVTZfr4JAVtTYXdNJXvr
         47NmxyGaZxWPB93DeIAZIpU+i2DXpwmDkzp+iXAyvbe0NG5s8Hpn2AJGkLBBrsKyeHxU
         gP7o7Fdi7vmdA9tVJdYwwNYD4sckBo01sYDufZ3tYDiv1tKRzj0HvcwH02vtWC8+nwyW
         Y2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281675; x=1710886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gEiCM1jx27sar3LPmESI0xMYjbB5scD0lmI2N8CVFI=;
        b=oLV9YmXAc0YHi8qWQkUSWXSAW2/Mmuumhpiaq35yxXAJIFcWIHHTUXMoSjRk+Z/Y9s
         eGbNvpOQWIGPaehv8TuCxp9+XjtVlSGiDdDlKkfxocMTqKl8cryqSDcGpfM+ZV/2RE1+
         wU9HXoq/o9lHShC0/DUV61Tz1WcwtKEcfUI5pVmktXYJq/7Cu6sISEy+uy1y50PUUbxD
         BdLSHnxvAP8BNn60bzxXL0s4bH1hA4proLz3N8lxr2Aqln2tlkczcNOUcBh1cR+jCPdw
         PDS18rlaVGtjP7fLpFkCG/VHrUAil8z+tSQKlt1TrUsEGtBFpJXbxGVGixBd2mo2mMPj
         60EA==
X-Gm-Message-State: AOJu0YwNFEsU+Ijv8M1MVYja45zehVhVFmJzyvmPtEsx/G30egH7yVrb
	qF+rmESj4hAEr6RKBsqOrjCNoYaVqObYbx/16mAuTvcAD4XJ/cmgK40GGLrddmbaIDHI25lEPR8
	w
X-Google-Smtp-Source: AGHT+IHzv4N05KGdmrRPtsocQVJeW0c6lxtYsrQGQ4GqzFBqSAsw9nK7XBoSAx2aKLbzNpGut8qJdA==
X-Received: by 2002:a17:902:ec88:b0:1dd:9090:a35c with SMTP id x8-20020a170902ec8800b001dd9090a35cmr2166255plg.9.1710281674851;
        Tue, 12 Mar 2024 15:14:34 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902e28a00b001dcfaab3457sm7240473plc.104.2024.03.12.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/4] tc: make action_util arg const
Date: Tue, 12 Mar 2024 15:12:41 -0700
Message-ID: <20240312221422.81253-4-stephen@networkplumber.org>
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

The callbacks in action_util should not be modifying underlying
qdisc operations structure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_action.c     | 4 ++--
 tc/m_bpf.c        | 4 ++--
 tc/m_connmark.c   | 4 ++--
 tc/m_csum.c       | 4 ++--
 tc/m_ct.c         | 4 ++--
 tc/m_ctinfo.c     | 4 ++--
 tc/m_gact.c       | 4 ++--
 tc/m_gate.c       | 8 ++++----
 tc/m_ife.c        | 4 ++--
 tc/m_mirred.c     | 6 +++---
 tc/m_mpls.c       | 4 ++--
 tc/m_nat.c        | 4 ++--
 tc/m_pedit.c      | 4 ++--
 tc/m_police.c     | 8 ++++----
 tc/m_sample.c     | 4 ++--
 tc/m_simple.c     | 4 ++--
 tc/m_skbedit.c    | 4 ++--
 tc/m_skbmod.c     | 4 ++--
 tc/m_tunnel_key.c | 4 ++--
 tc/m_vlan.c       | 4 ++--
 tc/tc_util.h      | 8 ++++----
 21 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/tc/m_action.c b/tc/m_action.c
index e0b9ebeedf5e..36bb59edcdde 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -59,7 +59,7 @@ static void act_usage(void)
 	exit(-1);
 }
 
-static int print_noaopt(struct action_util *au, FILE *f, struct rtattr *opt)
+static int print_noaopt(const struct action_util *au, FILE *f, struct rtattr *opt)
 {
 	if (opt && RTA_PAYLOAD(opt))
 		fprintf(stderr, "[Unknown action, optlen=%u] ",
@@ -67,7 +67,7 @@ static int print_noaopt(struct action_util *au, FILE *f, struct rtattr *opt)
 	return 0;
 }
 
-static int parse_noaopt(struct action_util *au, int *argc_p,
+static int parse_noaopt(const struct action_util *au, int *argc_p,
 			char ***argv_p, int code, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index da50c05e1529..9dba4be58118 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -69,7 +69,7 @@ static const struct bpf_cfg_ops bpf_cb_ops = {
 	.ebpf_cb = bpf_ebpf_cb,
 };
 
-static int bpf_parse_opt(struct action_util *a, int *ptr_argc, char ***ptr_argv,
+static int bpf_parse_opt(const struct action_util *a, int *ptr_argc, char ***ptr_argv,
 			 int tca_id, struct nlmsghdr *n)
 {
 	const char *bpf_obj = NULL, *bpf_uds_name = NULL;
@@ -151,7 +151,7 @@ opt_bpf:
 	return ret;
 }
 
-static int bpf_print_opt(struct action_util *au, FILE *f, struct rtattr *arg)
+static int bpf_print_opt(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_ACT_BPF_MAX + 1];
 	struct tc_act_bpf *parm;
diff --git a/tc/m_connmark.c b/tc/m_connmark.c
index 8506d95af5ec..8b5630f66c5e 100644
--- a/tc/m_connmark.c
+++ b/tc/m_connmark.c
@@ -32,7 +32,7 @@ usage(void)
 }
 
 static int
-parse_connmark(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
+parse_connmark(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	      struct nlmsghdr *n)
 {
 	struct tc_connmark sel = {};
@@ -94,7 +94,7 @@ parse_connmark(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	return 0;
 }
 
-static int print_connmark(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_connmark(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_CONNMARK_MAX + 1];
 	struct tc_connmark *ci;
diff --git a/tc/m_csum.c b/tc/m_csum.c
index f5fe8f550a06..21204e5bf7b6 100644
--- a/tc/m_csum.c
+++ b/tc/m_csum.c
@@ -81,7 +81,7 @@ parse_csum_args(int *argc_p, char ***argv_p, struct tc_csum *sel)
 }
 
 static int
-parse_csum(struct action_util *a, int *argc_p,
+parse_csum(const struct action_util *a, int *argc_p,
 	   char ***argv_p, int tca_id, struct nlmsghdr *n)
 {
 	struct tc_csum sel = {};
@@ -148,7 +148,7 @@ skip_args:
 }
 
 static int
-print_csum(struct action_util *au, FILE *f, struct rtattr *arg)
+print_csum(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_csum *sel;
 
diff --git a/tc/m_ct.c b/tc/m_ct.c
index 8c471489778a..4b7d322c8d4f 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -225,7 +225,7 @@ static int ct_parse_labels(char *str, struct nlmsghdr *n)
 }
 
 static int
-parse_ct(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
+parse_ct(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 		struct nlmsghdr *n)
 {
 	struct tc_ct sel = {};
@@ -488,7 +488,7 @@ static void ct_print_helper(struct rtattr *family, struct rtattr *proto, struct
 	print_string(PRINT_ANY, "helper", " helper %s", helper);
 }
 
-static int print_ct(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_ct(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_CT_MAX + 1];
 	const char *commit;
diff --git a/tc/m_ctinfo.c b/tc/m_ctinfo.c
index 996a36217dfe..dbd5c0b32c50 100644
--- a/tc/m_ctinfo.c
+++ b/tc/m_ctinfo.c
@@ -35,7 +35,7 @@ usage(void)
 }
 
 static int
-parse_ctinfo(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
+parse_ctinfo(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	     struct nlmsghdr *n)
 {
 	unsigned int cpmarkmask = 0, dscpmask = 0, dscpstatemask = 0;
@@ -181,7 +181,7 @@ static void print_ctinfo_stats(FILE *f, struct rtattr *tb[TCA_CTINFO_MAX + 1])
 			     rta_getattr_u64(tb[TCA_CTINFO_STATS_CPMARK_SET]));
 }
 
-static int print_ctinfo(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_ctinfo(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	unsigned int cpmarkmask = ~0, dscpmask = 0, dscpstatemask = 0;
 	struct rtattr *tb[TCA_CTINFO_MAX + 1];
diff --git a/tc/m_gact.c b/tc/m_gact.c
index 225ffce41412..670d59f03ee6 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -66,7 +66,7 @@ usage(void)
 }
 
 static int
-parse_gact(struct action_util *a, int *argc_p, char ***argv_p,
+parse_gact(const struct action_util *a, int *argc_p, char ***argv_p,
 	   int tca_id, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -157,7 +157,7 @@ skip_args:
 }
 
 static int
-print_gact(struct action_util *au, FILE *f, struct rtattr *arg)
+print_gact(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 #ifdef CONFIG_GACT_PROB
 	struct tc_gact_p *pp = NULL;
diff --git a/tc/m_gate.c b/tc/m_gate.c
index 37afa426a2c8..33ee63bb316c 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -56,9 +56,9 @@ static void explain_entry_format(void)
 	fprintf(stderr, "Usage: sched-entry <open | close> <interval> [ <interval ipv> <octets max bytes> ]\n");
 }
 
-static int parse_gate(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_gate(const struct action_util *a, int *argc_p, char ***argv_p,
 		      int tca_id, struct nlmsghdr *n);
-static int print_gate(struct action_util *au, FILE *f, struct rtattr *arg);
+static int print_gate(const struct action_util *au, FILE *f, struct rtattr *arg);
 
 struct action_util gate_action_util = {
 	.id = "gate",
@@ -135,7 +135,7 @@ static void free_entries(struct list_head *gate_entries)
 	}
 }
 
-static int parse_gate(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_gate(const struct action_util *a, int *argc_p, char ***argv_p,
 		      int tca_id, struct nlmsghdr *n)
 {
 	struct tc_gate parm = {.action = TC_ACT_PIPE};
@@ -441,7 +441,7 @@ static int print_gate_list(struct rtattr *list)
 	return 0;
 }
 
-static int print_gate(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_gate(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_gate *parm;
 	struct rtattr *tb[TCA_GATE_MAX + 1];
diff --git a/tc/m_ife.c b/tc/m_ife.c
index 162607ce7415..dfd85561e1c1 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -44,7 +44,7 @@ static void ife_usage(void)
 	exit(-1);
 }
 
-static int parse_ife(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_ife(const struct action_util *a, int *argc_p, char ***argv_p,
 		     int tca_id, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -211,7 +211,7 @@ skip_encode:
 	return 0;
 }
 
-static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_ife(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_ife *p;
 	struct rtattr *tb[TCA_IFE_MAX + 1];
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index 60bd90452ccb..cfecd59c7551 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -88,7 +88,7 @@ static const char *mirred_action(int action)
 }
 
 static int
-parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
+parse_direction(const struct action_util *a, int *argc_p, char ***argv_p,
 		int tca_id, struct nlmsghdr *n)
 {
 
@@ -258,7 +258,7 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
 
 
 static int
-parse_mirred(struct action_util *a, int *argc_p, char ***argv_p,
+parse_mirred(const struct action_util *a, int *argc_p, char ***argv_p,
 	     int tca_id, struct nlmsghdr *n)
 {
 
@@ -299,7 +299,7 @@ parse_mirred(struct action_util *a, int *argc_p, char ***argv_p,
 }
 
 static int
-print_mirred(struct action_util *au, FILE *f, struct rtattr *arg)
+print_mirred(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_mirred *p;
 	struct rtattr *tb[TCA_MIRRED_MAX + 1];
diff --git a/tc/m_mpls.c b/tc/m_mpls.c
index dda4680509a9..ca3a18a9a1ef 100644
--- a/tc/m_mpls.c
+++ b/tc/m_mpls.c
@@ -72,7 +72,7 @@ static bool check_double_action(unsigned int action, const char *arg)
 	return true;
 }
 
-static int parse_mpls(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_mpls(const struct action_util *a, int *argc_p, char ***argv_p,
 		      int tca_id, struct nlmsghdr *n)
 {
 	struct tc_mpls parm = {};
@@ -211,7 +211,7 @@ skip_args:
 	return 0;
 }
 
-static int print_mpls(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_mpls(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_MPLS_MAX + 1];
 	struct tc_mpls *parm;
diff --git a/tc/m_nat.c b/tc/m_nat.c
index 95b35584a23e..a3f86e190166 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -76,7 +76,7 @@ bad_val:
 }
 
 static int
-parse_nat(struct action_util *a, int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n)
+parse_nat(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n)
 {
 	struct tc_nat sel = {};
 
@@ -136,7 +136,7 @@ skip_args:
 }
 
 static int
-print_nat(struct action_util *au, FILE * f, struct rtattr *arg)
+print_nat(const struct action_util *au, FILE * f, struct rtattr *arg)
 {
 	struct tc_nat *sel;
 	struct rtattr *tb[TCA_NAT_MAX + 1];
diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index 32f03415d61c..83a0c42e58aa 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -620,7 +620,7 @@ static int pedit_keys_ex_addattr(struct m_pedit_sel *sel, struct nlmsghdr *n)
 	return 0;
 }
 
-static int parse_pedit(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_pedit(const struct action_util *a, int *argc_p, char ***argv_p,
 		       int tca_id, struct nlmsghdr *n)
 {
 	struct m_pedit_sel sel = {};
@@ -745,7 +745,7 @@ static int print_pedit_location(FILE *f,
 	return 0;
 }
 
-static int print_pedit(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_pedit(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_pedit_sel *sel;
 	struct rtattr *tb[TCA_PEDIT_MAX + 1];
diff --git a/tc/m_police.c b/tc/m_police.c
index 46c39a818761..8d6887eefc7d 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -17,9 +17,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static int act_parse_police(struct action_util *a, int *argc_p,
+static int act_parse_police(const struct action_util *a, int *argc_p,
 			    char ***argv_p, int tca_id, struct nlmsghdr *n);
-static int print_police(struct action_util *a, FILE *f, struct rtattr *tb);
+static int print_police(const struct action_util *a, FILE *f, struct rtattr *tb);
 
 struct action_util police_action_util = {
 	.id = "police",
@@ -42,7 +42,7 @@ static void usage(void)
 	exit(-1);
 }
 
-static int act_parse_police(struct action_util *a, int *argc_p, char ***argv_p,
+static int act_parse_police(const struct action_util *a, int *argc_p, char ***argv_p,
 			    int tca_id, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -260,7 +260,7 @@ int parse_police(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n)
 	return act_parse_police(NULL, argc_p, argv_p, tca_id, n);
 }
 
-static int print_police(struct action_util *a, FILE *f, struct rtattr *arg)
+static int print_police(const struct action_util *a, FILE *f, struct rtattr *arg)
 {
 	SPRINT_BUF(b2);
 	struct tc_police *p;
diff --git a/tc/m_sample.c b/tc/m_sample.c
index 769de144cbe0..642ec3a6ea7e 100644
--- a/tc/m_sample.c
+++ b/tc/m_sample.c
@@ -31,7 +31,7 @@ static void usage(void)
 	exit(-1);
 }
 
-static int parse_sample(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p,
 			int tca_id, struct nlmsghdr *n)
 {
 	struct tc_sample p = { 0 };
@@ -133,7 +133,7 @@ static int parse_sample(struct action_util *a, int *argc_p, char ***argv_p,
 	return 0;
 }
 
-static int print_sample(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_sample(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_SAMPLE_MAX + 1];
 	struct tc_sample *p;
diff --git a/tc/m_simple.c b/tc/m_simple.c
index fe2bca21ae46..9715955e0187 100644
--- a/tc/m_simple.c
+++ b/tc/m_simple.c
@@ -90,7 +90,7 @@ static void usage(void)
 }
 
 static int
-parse_simple(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
+parse_simple(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	     struct nlmsghdr *n)
 {
 	struct tc_defact sel = {};
@@ -155,7 +155,7 @@ parse_simple(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	return 0;
 }
 
-static int print_simple(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_simple(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_defact *sel;
 	struct rtattr *tb[TCA_DEF_MAX + 1];
diff --git a/tc/m_skbedit.c b/tc/m_skbedit.c
index d55a6128494e..b55c3249e6fa 100644
--- a/tc/m_skbedit.c
+++ b/tc/m_skbedit.c
@@ -41,7 +41,7 @@ usage(void)
 }
 
 static int
-parse_skbedit(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
+parse_skbedit(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	      struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -177,7 +177,7 @@ parse_skbedit(struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	return 0;
 }
 
-static int print_skbedit(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_skbedit(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_SKBEDIT_MAX + 1];
 
diff --git a/tc/m_skbmod.c b/tc/m_skbmod.c
index b1c8d00dfe47..c467f3f005ac 100644
--- a/tc/m_skbmod.c
+++ b/tc/m_skbmod.c
@@ -40,7 +40,7 @@ static void skbmod_usage(void)
 	exit(-1);
 }
 
-static int parse_skbmod(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_skbmod(const struct action_util *a, int *argc_p, char ***argv_p,
 			int tca_id, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -156,7 +156,7 @@ static int parse_skbmod(struct action_util *a, int *argc_p, char ***argv_p,
 	return 0;
 }
 
-static int print_skbmod(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_skbmod(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct tc_skbmod *p;
 	struct rtattr *tb[TCA_SKBMOD_MAX + 1];
diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
index ff699cc8917d..2032a72194cd 100644
--- a/tc/m_tunnel_key.c
+++ b/tc/m_tunnel_key.c
@@ -311,7 +311,7 @@ static int tunnel_key_parse_tos_ttl(char *str, int type, struct nlmsghdr *n)
 	return 0;
 }
 
-static int parse_tunnel_key(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_tunnel_key(const struct action_util *a, int *argc_p, char ***argv_p,
 			    int tca_id, struct nlmsghdr *n)
 {
 	struct tc_tunnel_key parm = {};
@@ -688,7 +688,7 @@ static void tunnel_key_print_tos_ttl(FILE *f, char *name,
 	}
 }
 
-static int print_tunnel_key(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_tunnel_key(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	struct rtattr *tb[TCA_TUNNEL_KEY_MAX + 1];
 	struct tc_tunnel_key *parm;
diff --git a/tc/m_vlan.c b/tc/m_vlan.c
index c1dc8b428e61..40d62fa0f282 100644
--- a/tc/m_vlan.c
+++ b/tc/m_vlan.c
@@ -56,7 +56,7 @@ static void unexpected(const char *arg)
 	explain();
 }
 
-static int parse_vlan(struct action_util *a, int *argc_p, char ***argv_p,
+static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
 		      int tca_id, struct nlmsghdr *n)
 {
 	int argc = *argc_p;
@@ -227,7 +227,7 @@ static int parse_vlan(struct action_util *a, int *argc_p, char ***argv_p,
 	return 0;
 }
 
-static int print_vlan(struct action_util *au, FILE *f, struct rtattr *arg)
+static int print_vlan(const struct action_util *au, FILE *f, struct rtattr *arg)
 {
 	SPRINT_BUF(b1);
 	struct rtattr *tb[TCA_VLAN_MAX + 1];
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 51f9effc27b1..5ae3fafd2dd2 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -58,10 +58,10 @@ struct filter_util {
 struct action_util {
 	struct action_util *next;
 	char id[FILTER_NAMESZ];
-	int (*parse_aopt)(struct action_util *a, int *argc,
+	int (*parse_aopt)(const struct action_util *a, int *argc,
 			  char ***argv, int code, struct nlmsghdr *n);
-	int (*print_aopt)(struct action_util *au, FILE *f, struct rtattr *opt);
-	int (*print_xstats)(struct action_util *au,
+	int (*print_aopt)(const struct action_util *au, FILE *f, struct rtattr *opt);
+	int (*print_xstats)(const struct action_util *au,
 			    FILE *f, struct rtattr *xstats);
 };
 
@@ -112,7 +112,7 @@ int parse_action_control_slash(int *argc_p, char ***argv_p,
 			       int *result1_p, int *result2_p, bool allow_num);
 void print_action_control(FILE *f, const char *prefix,
 			  int action, const char *suffix);
-int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
+int police_print_xstats(const struct action_util *a, FILE *f, struct rtattr *tb);
 int tc_print_action(FILE *f, const struct rtattr *tb, unsigned short tot_acts);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
 void print_tm(FILE *f, const struct tcf_t *tm);
-- 
2.43.0


