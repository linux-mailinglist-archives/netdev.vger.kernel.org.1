Return-Path: <netdev+bounces-87642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E08A3F50
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676BF1C20A0D
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775457889;
	Sat, 13 Apr 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wvZypPA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685757310
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045934; cv=none; b=Cwenyk74ueYZze2+yIienuU6nEGXI5JyRDbWN11hvtHtj+v+20UUmWX8UKw1aZutSDenuYU/qghF0/nVRJKCCh0KKM5arbMHgcPsqVBcSZr309IekzpdS2X1OVvWwxSREgz92xStZTQRs3b6ibBau/LevjiUuRxDRHgoF2PU7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045934; c=relaxed/simple;
	bh=DoKOborxdg9vEFlBWhzU4w/9KLbX6sSntzqrRAcT9Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhRnPeLN9AmYwGD22awFFr60W0c+rPcV3Y8BhDt9HKHTeZKD4xzgvOq6dkegrn9wnZyHRBlRFtXFICk/9Ok6iZNRD+Dr1xKxb346NQjG5NdTmpHdll1Xhv9pG5Mk5qeXBFgkNBpFwp68WOMvOzy85/DZutisMHJlyfEWuQTN+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wvZypPA2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e220e40998so13161355ad.1
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045932; x=1713650732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuG0zC7KJZKKRfVx+EmkeXdKZGVMHcd6tlFd7MhxRk0=;
        b=wvZypPA2CcS+WPFTo1/Efm6PnVQzg/y+NXYUErCzJoPoLEXd+BcIpc52a6GXoalkv8
         tnxC2O9xGRV7HWJBED8cFnEOS8+CtncVURokAFEha+/myrscBOGCZspMYzU+/pnqN1gg
         L1Pia7P8a9msbyiReuWSTbjo+7kv1RS8VdU2UqrRSeHyw0jLY4YeF8kDUB1zLITpRVvD
         U2fH3ZEAANEA+5VhAgy1Doj5SF7QEytC7lWiUve3Eca8XoJH7iSFtbj0p/2ng6qeqaiD
         x2R1UM54GGVJsHrRJqq0em6ONaexFQzhjk5BbiI1QwuqAVuXfOjbB73Lu8FDLKLZ4/Vh
         YuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045932; x=1713650732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuG0zC7KJZKKRfVx+EmkeXdKZGVMHcd6tlFd7MhxRk0=;
        b=sKuw2w+ti0SFN6BGDwccZKXtQwfLcOsYv5l5PvoQW7Upp0bzs4dDeWsAHdULjtN5wR
         LMu2jQu3Ccg5E9e+gP45VlrucBr7+bwop59jY4gq5kfOcsEDwkFzJzZaek0dJksMdI2h
         1i0tBFf4JOezCl40meQ3UpUO8OW+QcKFafM8AhbYUH1N1mojvDKgjvRcDozrDBcrrHeo
         hR9FufU5qEkLPhhkDfUBfxVzaXyMbPRfK1JWW5CMWmxYCXbYMatl6lNi9jwq3sMdnjeJ
         84v9R2JEf32aPnqQPdC8r4wT5pu7pUXuW3b+WqRk0sqI06+FhsqGAYyJ8A1oiYtt1bVa
         ku5Q==
X-Gm-Message-State: AOJu0YzoyorpaxyJxrh32qsmz73IVOJ3bWv68O8lyVWUg72gKCp3htiM
	ezJwBVwQnCYzzgL793Ni/bZAabgL52Oe3zyUdVbPzcAa06iJdvgS7tw8WZAy9nRQxqK+g8muxIv
	M
X-Google-Smtp-Source: AGHT+IFd/WT03qzuSP8CmjuruwqqiSCf8Sb7pYwDUUc6lPYhIA50tRLonGnWt1AmLlzo6JN0q7Mz7Q==
X-Received: by 2002:a17:902:c3c6:b0:1e2:ae83:3197 with SMTP id j6-20020a170902c3c600b001e2ae833197mr7110188plj.10.1713045931939;
        Sat, 13 Apr 2024 15:05:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 6/7] tc/action: remove unused args from tc_print_action
Date: Sat, 13 Apr 2024 15:04:07 -0700
Message-ID: <20240413220516.7235-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413220516.7235-1-stephen@networkplumber.org>
References: <20240413220516.7235-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file handle is not used, and total actions is always zero.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_basic.c    |  2 +-
 tc/f_bpf.c      |  2 +-
 tc/f_cgroup.c   |  2 +-
 tc/f_flow.c     |  2 +-
 tc/f_flower.c   |  2 +-
 tc/f_fw.c       |  2 +-
 tc/f_matchall.c |  2 +-
 tc/f_route.c    |  2 +-
 tc/f_u32.c      |  2 +-
 tc/m_action.c   | 28 +++++++++++++++-------------
 tc/tc_util.h    |  2 +-
 11 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/tc/f_basic.c b/tc/f_basic.c
index 6b36028f..b76092c6 100644
--- a/tc/f_basic.c
+++ b/tc/f_basic.c
@@ -134,7 +134,7 @@ static int basic_print_opt(struct filter_util *qu, FILE *f,
 	}
 
 	if (tb[TCA_BASIC_ACT]) {
-		tc_print_action(f, tb[TCA_BASIC_ACT], 0);
+		tc_print_action(tb[TCA_BASIC_ACT]);
 	}
 
 	return 0;
diff --git a/tc/f_bpf.c b/tc/f_bpf.c
index f265249d..ad40bc99 100644
--- a/tc/f_bpf.c
+++ b/tc/f_bpf.c
@@ -254,7 +254,7 @@ static int bpf_print_opt(struct filter_util *qu, FILE *f,
 	}
 
 	if (tb[TCA_BPF_ACT])
-		tc_print_action(f, tb[TCA_BPF_ACT], 0);
+		tc_print_action(tb[TCA_BPF_ACT]);
 
 	return 0;
 }
diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index d4201b91..ed7638ed 100644
--- a/tc/f_cgroup.c
+++ b/tc/f_cgroup.c
@@ -97,7 +97,7 @@ static int cgroup_print_opt(struct filter_util *qu, FILE *f,
 	}
 
 	if (tb[TCA_CGROUP_ACT])
-		tc_print_action(f, tb[TCA_CGROUP_ACT], 0);
+		tc_print_action(tb[TCA_CGROUP_ACT]);
 
 	return 0;
 }
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 07340f2a..0e27d216 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -350,7 +350,7 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 		tc_print_police(tb[TCA_FLOW_POLICE]);
 	if (tb[TCA_FLOW_ACT]) {
 		print_nl();
-		tc_print_action(f, tb[TCA_FLOW_ACT], 0);
+		tc_print_action(tb[TCA_FLOW_ACT]);
 	}
 	return 0;
 }
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 53188f1c..1d2cff46 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -3178,7 +3178,7 @@ static int flower_print_opt(struct filter_util *qu, FILE *f,
 	}
 
 	if (tb[TCA_FLOWER_ACT])
-		tc_print_action(f, tb[TCA_FLOWER_ACT], 0);
+		tc_print_action(tb[TCA_FLOWER_ACT]);
 
 	return 0;
 }
diff --git a/tc/f_fw.c b/tc/f_fw.c
index 190f79fc..80809f13 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -156,7 +156,7 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 
 	if (tb[TCA_FW_ACT]) {
 		print_nl();
-		tc_print_action(f, tb[TCA_FW_ACT], 0);
+		tc_print_action(tb[TCA_FW_ACT]);
 	}
 	return 0;
 }
diff --git a/tc/f_matchall.c b/tc/f_matchall.c
index 38b68d7e..2ecf028b 100644
--- a/tc/f_matchall.c
+++ b/tc/f_matchall.c
@@ -155,7 +155,7 @@ static int matchall_print_opt(struct filter_util *qu, FILE *f,
 
 
 	if (tb[TCA_MATCHALL_ACT])
-		tc_print_action(f, tb[TCA_MATCHALL_ACT], 0);
+		tc_print_action(tb[TCA_MATCHALL_ACT]);
 
 	return 0;
 }
diff --git a/tc/f_route.c b/tc/f_route.c
index 3b6f5c2f..0af2fde1 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -167,7 +167,7 @@ static int route_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 	if (tb[TCA_ROUTE4_POLICE])
 		tc_print_police(tb[TCA_ROUTE4_POLICE]);
 	if (tb[TCA_ROUTE4_ACT])
-		tc_print_action(f, tb[TCA_ROUTE4_ACT], 0);
+		tc_print_action(tb[TCA_ROUTE4_ACT]);
 	return 0;
 }
 
diff --git a/tc/f_u32.c b/tc/f_u32.c
index c04ec02d..6e2e00b1 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -1377,7 +1377,7 @@ static int u32_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 	}
 
 	if (tb[TCA_U32_ACT])
-		tc_print_action(f, tb[TCA_U32_ACT], 0);
+		tc_print_action(tb[TCA_U32_ACT]);
 
 	return 0;
 }
diff --git a/tc/m_action.c b/tc/m_action.c
index feb869a9..6910562e 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -41,7 +41,7 @@ static void act_usage(void)
 	 */
 	fprintf(stderr,
 		"usage: tc actions <ACTSPECOP>*\n"
-		"Where: 	ACTSPECOP := ACR | GD | FL\n"
+		"Where:		ACTSPECOP := ACR | GD | FL\n"
 		"	ACR := add | change | replace <ACTSPEC>*\n"
 		"	GD := get | delete | <ACTISPEC>*\n"
 		"	FL := ls | list | flush | <ACTNAMESPEC>\n"
@@ -360,7 +360,7 @@ bad_val:
 	return -1;
 }
 
-static int tc_print_one_action(FILE *f, struct rtattr *arg, bool bind)
+static int tc_print_one_action(struct rtattr *arg, bool bind)
 {
 
 	struct rtattr *tb[TCA_ACT_MAX + 1];
@@ -382,7 +382,7 @@ static int tc_print_one_action(FILE *f, struct rtattr *arg, bool bind)
 	if (a == NULL)
 		return err;
 
-	err = a->print_aopt(a, f, tb[TCA_ACT_OPTIONS]);
+	err = a->print_aopt(a, stdout, tb[TCA_ACT_OPTIONS]);
 
 	if (err < 0)
 		return err;
@@ -466,7 +466,7 @@ static int tc_print_one_action(FILE *f, struct rtattr *arg, bool bind)
 }
 
 static int
-tc_print_action_flush(FILE *f, const struct rtattr *arg)
+tc_print_action_flush(const struct rtattr *arg)
 {
 
 	struct rtattr *tb[TCA_MAX + 1];
@@ -486,16 +486,18 @@ tc_print_action_flush(FILE *f, const struct rtattr *arg)
 		return err;
 
 	delete_count = RTA_DATA(tb[TCA_FCNT]);
-	fprintf(f, " %s (%d entries)\n", a->id, *delete_count);
+	print_string(PRINT_FP, NULL, " %s ", a->id);
+	open_json_object(a->id);
+	print_int(PRINT_ANY, "entries",  "(%d entries)\n", *delete_count);
+	close_json_object();
+
 	tab_flush = 0;
 	return 0;
 }
 
 static int
-tc_dump_action(FILE *f, const struct rtattr *arg, unsigned short tot_acts,
-	       bool bind)
+tc_dump_action(const struct rtattr *arg, unsigned short tot_acts, bool bind)
 {
-
 	int i;
 
 	if (arg == NULL)
@@ -509,7 +511,7 @@ tc_dump_action(FILE *f, const struct rtattr *arg, unsigned short tot_acts,
 	parse_rtattr_nested(tb, tot_acts, arg);
 
 	if (tab_flush && tb[0] && !tb[1])
-		return tc_print_action_flush(f, tb[0]);
+		return tc_print_action_flush(tb[0]);
 
 	open_json_array(PRINT_JSON, "actions");
 	for (i = 0; i <= tot_acts; i++) {
@@ -518,7 +520,7 @@ tc_dump_action(FILE *f, const struct rtattr *arg, unsigned short tot_acts,
 			print_nl();
 			print_uint(PRINT_ANY, "order",
 				   "\taction order %u: ", i);
-			if (tc_print_one_action(f, tb[i], bind) < 0)
+			if (tc_print_one_action(tb[i], bind) < 0)
 				fprintf(stderr, "Error printing action\n");
 			close_json_object();
 		}
@@ -530,9 +532,9 @@ tc_dump_action(FILE *f, const struct rtattr *arg, unsigned short tot_acts,
 }
 
 int
-tc_print_action(FILE *f, const struct rtattr *arg, unsigned short tot_acts)
+tc_print_action(const struct rtattr *arg)
 {
-	return tc_dump_action(f, arg, tot_acts, true);
+	return tc_dump_action(arg, 0, true);
 }
 
 int print_action(struct nlmsghdr *n, void *arg)
@@ -585,7 +587,7 @@ int print_action(struct nlmsghdr *n, void *arg)
 	}
 
 	open_json_object(NULL);
-	tc_dump_action(fp, tb[TCA_ACT_TAB], tot_acts ? *tot_acts:0, false);
+	tc_dump_action(tb[TCA_ACT_TAB], tot_acts ? *tot_acts : 0, false);
 
 	if (tb[TCA_ROOT_EXT_WARN_MSG]) {
 		print_string(PRINT_ANY, "warn", "%s",
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 2d38dd58..a1137bc2 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -110,7 +110,7 @@ int parse_action_control_slash(int *argc_p, char ***argv_p,
 			       int *result1_p, int *result2_p, bool allow_num);
 void print_action_control(const char *prefix, int action, const char *suffix);
 int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
-int tc_print_action(FILE *f, const struct rtattr *tb, unsigned short tot_acts);
+int tc_print_action(const struct rtattr *tb);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
 void print_tm(const struct tcf_t *tm);
 int prio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt);
-- 
2.43.0


