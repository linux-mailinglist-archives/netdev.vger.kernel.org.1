Return-Path: <netdev+bounces-87639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62178A3F4D
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54E7B214BF
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847B57315;
	Sat, 13 Apr 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="v1BBj6kH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8ED56B64
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045933; cv=none; b=MPMka6X7KubwtsJbsuvxwe5GWOV2QJ5MmJROm++aTTlP5DF5hx2RKIx3n0OCEqCOyHNsu2b3wuR0EwIuylIiUI+gxUjyB3cp+s2WqQH8cRq3hQldZxt037X/GC8/W9xaWT89K47G/8aGVe2nor6tH5TikxVecZzVbo0lSFE7xGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045933; c=relaxed/simple;
	bh=RqQxMm8f5HS3EJivC3U1Bk3lkI8CuQfdofo2EpaA0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZgmuzT+ZqWevoVgaM/hdms8o1vDp6vbqsGt3PngMeRoPwuBOjS9oLdvCft2UtO89WLIEtoRB+dEw3DnP7DvExvWE4Q1RVvd13tzVKbxjbDJtZQ/FhtocP8KZXuMcfE/kuqahDpu3NYLmbDQV7gTD1vWE/oTbgYbYy1ikIrqLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=v1BBj6kH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf406551aso1601404b3a.2
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045930; x=1713650730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyCEu2k0Ebvr+LbMmoI6zuSOabwfOsVHMOu4A+9qTiw=;
        b=v1BBj6kHGy+AMh6lzu/vAvTfFw3FMuTGg4a2N8t5VqSY543Ztvt0vSMIG+RLgl/yQ1
         iEsNhvQKiHBpCySrDLo0Nxtu1XqEiRIRgeX+5yigjVmXMvPnoraKGHve5AGuItJSqgiG
         PFAjgRVx5Uha57pi9OQkBX2cV0rF8trwefjXBmEfWcVqO9yt5lqIp8w4um8g0mjgmgqc
         HS1h3i/K1niKjbIuDBWsoPY3QOe4wrA88Jzt4IO+IWnHeerRK+tcs+OT0La5l5gF+4th
         gTK/GP8+3v9MaO/RuwZXZeEO5lqyB7J+00K/qo4ueQmAkfkJPYei3KIpSpvHZUCOqmUT
         Dr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045930; x=1713650730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyCEu2k0Ebvr+LbMmoI6zuSOabwfOsVHMOu4A+9qTiw=;
        b=O4fJaE5WkcQqzFSCrNI2r57msb9q3arpxE+Zfi8oKzzNpf1Q+0N9swX8m+Ob+MXDFI
         uU9d43P3Tsz+lezourso5OKVB+eHRqy50bVK8sNyC0JX+Y2iiEM3jQxI8lAtMTExYCdn
         rkI84T3v4soPQfmc1reDv66Il5HvEKd0AhExyejpap0HBvhRb3uyAX5FE9u/zGHWuNrV
         QXGEL/tlCgugnnSZ1uerw89SOqoKd8kmNO1+i+tVYvSz16hBVptPCdhnzVsfx9NAZ9JJ
         okWbTnxdtc2ApdMCxzCefAZKZQyAc/w3Y5Yv2/kUx+YAU2vaOm9ci13sIc5QBgu2YzPV
         SELQ==
X-Gm-Message-State: AOJu0Yw6d352fUELGE2ZDv72ti+nJBj5O3K+Gx4MKisEgC4slci8Gz8v
	qeeZqx5bCb+KxWuV0v1Ihiv8wLqU2x2ntQBNTS2PCYeABgpL09GFJnKfHNzkX4nCWOyhyokqA54
	K
X-Google-Smtp-Source: AGHT+IGPV8YKRieD/yzosGW1q0yT6HRJkvvGR8PunF506VMRniGxm+ZO+dxUygbJssdDxcCQrEGvKg==
X-Received: by 2002:a17:902:f709:b0:1e5:8629:44d with SMTP id h9-20020a170902f70900b001e58629044dmr6865890plo.1.1713045930412;
        Sat, 13 Apr 2024 15:05:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 4/7] tc/police: remove unused argument to tc_print_police
Date: Sat, 13 Apr 2024 15:04:05 -0700
Message-ID: <20240413220516.7235-5-stephen@networkplumber.org>
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

FILE handle no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_basic.c  | 2 +-
 tc/f_bpf.c    | 2 +-
 tc/f_cgroup.c | 2 +-
 tc/f_flow.c   | 2 +-
 tc/f_fw.c     | 2 +-
 tc/f_route.c  | 2 +-
 tc/f_u32.c    | 2 +-
 tc/m_police.c | 6 +++---
 tc/tc_util.h  | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tc/f_basic.c b/tc/f_basic.c
index 1ceb15d4..6b36028f 100644
--- a/tc/f_basic.c
+++ b/tc/f_basic.c
@@ -130,7 +130,7 @@ static int basic_print_opt(struct filter_util *qu, FILE *f,
 
 	if (tb[TCA_BASIC_POLICE]) {
 		print_nl();
-		tc_print_police(f, tb[TCA_BASIC_POLICE]);
+		tc_print_police(tb[TCA_BASIC_POLICE]);
 	}
 
 	if (tb[TCA_BASIC_ACT]) {
diff --git a/tc/f_bpf.c b/tc/f_bpf.c
index a6d4875f..f265249d 100644
--- a/tc/f_bpf.c
+++ b/tc/f_bpf.c
@@ -250,7 +250,7 @@ static int bpf_print_opt(struct filter_util *qu, FILE *f,
 
 	if (tb[TCA_BPF_POLICE]) {
 		print_nl();
-		tc_print_police(f, tb[TCA_BPF_POLICE]);
+		tc_print_police(tb[TCA_BPF_POLICE]);
 	}
 
 	if (tb[TCA_BPF_ACT])
diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index 291d6e7e..d4201b91 100644
--- a/tc/f_cgroup.c
+++ b/tc/f_cgroup.c
@@ -93,7 +93,7 @@ static int cgroup_print_opt(struct filter_util *qu, FILE *f,
 
 	if (tb[TCA_CGROUP_POLICE]) {
 		print_nl();
-		tc_print_police(f, tb[TCA_CGROUP_POLICE]);
+		tc_print_police(tb[TCA_CGROUP_POLICE]);
 	}
 
 	if (tb[TCA_CGROUP_ACT])
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 4a29af22..07340f2a 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -347,7 +347,7 @@ static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
 	if (tb[TCA_FLOW_EMATCHES])
 		print_ematch(f, tb[TCA_FLOW_EMATCHES]);
 	if (tb[TCA_FLOW_POLICE])
-		tc_print_police(f, tb[TCA_FLOW_POLICE]);
+		tc_print_police(tb[TCA_FLOW_POLICE]);
 	if (tb[TCA_FLOW_ACT]) {
 		print_nl();
 		tc_print_action(f, tb[TCA_FLOW_ACT], 0);
diff --git a/tc/f_fw.c b/tc/f_fw.c
index 5e72e526..190f79fc 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -146,7 +146,7 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	}
 
 	if (tb[TCA_FW_POLICE])
-		tc_print_police(f, tb[TCA_FW_POLICE]);
+		tc_print_police(tb[TCA_FW_POLICE]);
 	if (tb[TCA_FW_INDEV]) {
 		struct rtattr *idev = tb[TCA_FW_INDEV];
 
diff --git a/tc/f_route.c b/tc/f_route.c
index ca8a8ddd..3b6f5c2f 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -165,7 +165,7 @@ static int route_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 		print_color_string(PRINT_ANY, COLOR_IFNAME, "fromif", "fromif %s",
 			ll_index_to_name(rta_getattr_u32(tb[TCA_ROUTE4_IIF])));
 	if (tb[TCA_ROUTE4_POLICE])
-		tc_print_police(f, tb[TCA_ROUTE4_POLICE]);
+		tc_print_police(tb[TCA_ROUTE4_POLICE]);
 	if (tb[TCA_ROUTE4_ACT])
 		tc_print_action(f, tb[TCA_ROUTE4_ACT], 0);
 	return 0;
diff --git a/tc/f_u32.c b/tc/f_u32.c
index f8e1ff6e..c04ec02d 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -1365,7 +1365,7 @@ static int u32_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 
 	if (tb[TCA_U32_POLICE]) {
 		print_nl();
-		tc_print_police(f, tb[TCA_U32_POLICE]);
+		tc_print_police(tb[TCA_U32_POLICE]);
 	}
 
 	if (tb[TCA_U32_INDEV]) {
diff --git a/tc/m_police.c b/tc/m_police.c
index 02e50142..d7a396a2 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -260,7 +260,7 @@ int parse_police(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n)
 	return act_parse_police(NULL, argc_p, argv_p, tca_id, n);
 }
 
-static int print_police(struct action_util *a, FILE *f, struct rtattr *arg)
+static int print_police(struct action_util *a, FILE *funused, struct rtattr *arg)
 {
 	SPRINT_BUF(b2);
 	struct tc_police *p;
@@ -356,7 +356,7 @@ static int print_police(struct action_util *a, FILE *f, struct rtattr *arg)
 	return 0;
 }
 
-int tc_print_police(FILE *f, struct rtattr *arg)
+int tc_print_police(struct rtattr *arg)
 {
-	return print_police(&police_action_util, f, arg);
+	return print_police(&police_action_util, NULL, arg);
 }
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 851c2092..de908d5e 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -98,7 +98,7 @@ int get_tc_classid(__u32 *h, const char *str);
 int print_tc_classid(char *buf, int len, __u32 h);
 char *sprint_tc_classid(__u32 h, char *buf);
 
-int tc_print_police(FILE *f, struct rtattr *tb);
+int tc_print_police(struct rtattr *tb);
 int parse_percent(double *val, const char *str);
 int parse_police(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
 
-- 
2.43.0


