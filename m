Return-Path: <netdev+bounces-77112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFA8703D0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE0B1F21448
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0F3FB02;
	Mon,  4 Mar 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9MpibyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72083D38F
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561637; cv=none; b=DwJzXq1L6qiNNRGHrIEAI+xONx0Cq1Hffa9kYPhoEqnY/u2ikQh4t4jLAexTFSCAuE5SIAEYMTq8yDMLSsucVTv5wALMXSySawqLvkpiezFm+7T/H2pHgoeA4VL/gkr59Kh+waskmHdYW57O1lBKXwYcp6+GHDOgQiAfiA3ztrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561637; c=relaxed/simple;
	bh=Aad7MMKGDzpxnSWvQGJ4WEEZZCX6kT2dBP2piIPGUt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZhcXQ8ppmOdvB0+wwQv7HLZRmnxuAI9+H48My8Q7y8mDIjJ3EIl9jRmRlWxzx5WCfgofyWcQiT3VXf7Ys762FHWGX3Na9R/X0BeeyKhtm4QtRwfs8eg0P9C6F5mAlcv2ORwkWMDX1g9h4DEgn4NnTW333Jq71W9gB1TzmLHMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9MpibyB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51327cd65beso1226266e87.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709561634; x=1710166434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rF54vFix7dxyUi1kP6t1a8edrxcuKO8fcdOpKw+Ic88=;
        b=U9MpibyBsa87A7OKwa4by6G5yY2QFoc4tBwXCieT7OmLvmmeApLuJcVdSE1yGnbdx9
         dCLgKSBqn59ka8zbXOlVnA4KRa6Vgtsx0Qw0xb6neqviOgf+UV3rW172Si/aHx2RMN2I
         DXFVpYAx4lmmnnkWvywZB0CXmwl/rFlNSjYzbqNTPEgCE6xyeYNr+mXFscJ3u8SOOMxn
         E9DVQRKMI8K9Ugqib4olRjZhqmL0ZRMzlaazHz6bfgiWBNfeglINd1UPRKTXJPNGVbYu
         beD5O38IW4IYfxNLIe2L9uoyc2hSKjo0O9SVRxuZ2+RAGl1EAOblxvlqaJW1MHPckiyL
         aDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709561634; x=1710166434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF54vFix7dxyUi1kP6t1a8edrxcuKO8fcdOpKw+Ic88=;
        b=IcBHXYtVzTmSm39sH9Vd4maI0FtftRfjZcSd1dmNr+XRavrqF1rK+O0yCZF0PHpawD
         JBdGYz/66PHhoCqS28zfJD2zhuLbha1FqxuFwqcI004GZPJXcFiGxa9NUdPejBhcG7YQ
         RJfB4NqBx7n5feiZnlnmjRuBA4nN7D/x7vdkYqVq08Zjn5TqV1olGhm2OECcfbQ3HSvr
         TFv6mquvTBFRGUU8c0TmWoJocwJXAPBOZouESamqWgI31I2WV2tgTKV+8j5mF/z9X8hk
         ttjGPf7gh+cNgnee14X9SlCjAjaxRPW/1YWryuQWihBNH1iFPQF0yzb/Uwf8DMJV5fdw
         I2Ag==
X-Gm-Message-State: AOJu0YyMCWrP31aTrfta5DBGn2jw9W+Ipwagi0vlfjkgmEoqB98A3kSg
	xSu5sMmku4DpsFdD1m4AOvKNU5b2p+yJDD6+FyiGr9irZJCHx0YCYPH1GvdQTB3MUQ==
X-Google-Smtp-Source: AGHT+IE9WzpgIVMYlvSUtj1ajVl3lqr/gL0+StUHYga3HtsilhgsCMeUMPX7W4hBCXk759lyya5bpQ==
X-Received: by 2002:a05:6512:3e20:b0:513:4b49:e1e5 with SMTP id i32-20020a0565123e2000b005134b49e1e5mr980084lfv.1.1709561633587;
        Mon, 04 Mar 2024 06:13:53 -0800 (PST)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id j10-20020ac253aa000000b0051325475bb1sm1730818lfh.229.2024.03.04.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 06:13:53 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2-next v3] iproute2: move generic_proc_open into lib
Date: Mon,  4 Mar 2024 09:13:40 -0500
Message-Id: <20240304141340.3563-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the function has the same definition in ifstat and ss

v2: fix the typo in the chagelog
v3: rebase on master

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 include/utils.h |  2 ++
 lib/utils.c     | 14 ++++++++++++++
 misc/nstat.c    | 29 ++++++++---------------------
 misc/ss.c       | 13 -------------
 4 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 9ba129b8..a2a98b9b 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -393,4 +393,6 @@ int proto_a2n(unsigned short *id, const char *buf,
 const char *proto_n2a(unsigned short id, char *buf, int len,
 		      const struct proto *proto_tb, size_t tb_len);
 
+FILE *generic_proc_open(const char *env, const char *name);
+
 #endif /* __UTILS_H__ */
diff --git a/lib/utils.c b/lib/utils.c
index 6c1c1a8d..deb7654a 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -2003,3 +2003,17 @@ int proto_a2n(unsigned short *id, const char *buf,
 
 	return 0;
 }
+
+FILE *generic_proc_open(const char *env, const char *name)
+{
+	const char *p = getenv(env);
+	char store[128];
+
+	if (!p) {
+		p = getenv("PROC_ROOT") ? : "/proc";
+		snprintf(store, sizeof(store) - 1, "%s/%s", p, name);
+		p = store;
+	}
+
+	return fopen(p, "r");
+}
diff --git a/misc/nstat.c b/misc/nstat.c
index 7beb620b..07d010de 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -43,35 +43,22 @@ int npatterns;
 char info_source[128];
 int source_mismatch;
 
-static int generic_proc_open(const char *env, const char *name)
-{
-	char store[128];
-	char *p = getenv(env);
-
-	if (!p) {
-		p = getenv("PROC_ROOT") ? : "/proc";
-		snprintf(store, sizeof(store)-1, "%s/%s", p, name);
-		p = store;
-	}
-	return open(p, O_RDONLY);
-}
-
-static int net_netstat_open(void)
+static FILE *net_netstat_open(void)
 {
 	return generic_proc_open("PROC_NET_NETSTAT", "net/netstat");
 }
 
-static int net_snmp_open(void)
+static FILE *net_snmp_open(void)
 {
 	return generic_proc_open("PROC_NET_SNMP", "net/snmp");
 }
 
-static int net_snmp6_open(void)
+static FILE *net_snmp6_open(void)
 {
 	return generic_proc_open("PROC_NET_SNMP6", "net/snmp6");
 }
 
-static int net_sctp_snmp_open(void)
+static FILE *net_sctp_snmp_open(void)
 {
 	return generic_proc_open("PROC_NET_SCTP_SNMP", "net/sctp/snmp");
 }
@@ -277,7 +264,7 @@ static void load_ugly_table(FILE *fp)
 
 static void load_sctp_snmp(void)
 {
-	FILE *fp = fdopen(net_sctp_snmp_open(), "r");
+	FILE *fp = net_sctp_snmp_open();
 
 	if (fp) {
 		load_good_table(fp);
@@ -287,7 +274,7 @@ static void load_sctp_snmp(void)
 
 static void load_snmp(void)
 {
-	FILE *fp = fdopen(net_snmp_open(), "r");
+	FILE *fp = net_snmp_open();
 
 	if (fp) {
 		load_ugly_table(fp);
@@ -297,7 +284,7 @@ static void load_snmp(void)
 
 static void load_snmp6(void)
 {
-	FILE *fp = fdopen(net_snmp6_open(), "r");
+	FILE *fp = net_snmp6_open();
 
 	if (fp) {
 		load_good_table(fp);
@@ -307,7 +294,7 @@ static void load_snmp6(void)
 
 static void load_netstat(void)
 {
-	FILE *fp = fdopen(net_netstat_open(), "r");
+	FILE *fp = net_netstat_open();
 
 	if (fp) {
 		load_ugly_table(fp);
diff --git a/misc/ss.c b/misc/ss.c
index 3ebac132..87008d7c 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -478,19 +478,6 @@ static void filter_merge_defaults(struct filter *f)
 	}
 }
 
-static FILE *generic_proc_open(const char *env, const char *name)
-{
-	const char *p = getenv(env);
-	char store[128];
-
-	if (!p) {
-		p = getenv("PROC_ROOT") ? : "/proc";
-		snprintf(store, sizeof(store)-1, "%s/%s", p, name);
-		p = store;
-	}
-
-	return fopen(p, "r");
-}
 #define net_tcp_open()		generic_proc_open("PROC_NET_TCP", "net/tcp")
 #define net_tcp6_open()		generic_proc_open("PROC_NET_TCP6", "net/tcp6")
 #define net_udp_open()		generic_proc_open("PROC_NET_UDP", "net/udp")
-- 
2.30.2


