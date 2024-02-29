Return-Path: <netdev+bounces-76160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F98C86C986
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BE71C20E8C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640267D3EB;
	Thu, 29 Feb 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD+DW21k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A165A7AE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211316; cv=none; b=SIB9LrUL19nJtyiUpjeuPM7jfS1vATl53BSEnWJ9GRJXRu2sEFUNN0TsTZc3YsPzoKuKFN4wPxgmQ3C73tbCYjKrs+QjJENSe9bmErwIX8Z8F8XT5kzUtosrdlu+eUra2PmSzQBgi0/P/Xu7JGD3OOm/CqaWhuvFWvjE1R3BTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211316; c=relaxed/simple;
	bh=kMb9aMUzQBSforgl2DFWYSr/SbuIJFh/n95FwnaLxlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pF4sa6VoBOb6DwGu1sC9WWWiLgxf7GzMFAEb1Y8/4kXlJy8DUihOLArjK/zY1AMCyGT7m1a4k9p4O3CWoPVSleRBOLpQ7OjJhTznKFr44uZZ0e8kr5dFjQUDEjNasy7Pr83ozX1Pv/scGx9PBkuSS59LpEVdGvRTsKOoEY9M4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD+DW21k; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso42478e87.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709211312; x=1709816112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=waHOmmopUwg4dwiaI2ZXzusWB0J3AUy3GuEFy7B/L/E=;
        b=LD+DW21ky4B++Vy6WG5vFK2hjRdmpubgkAYf7Cnz+/hLXR3+QjGmuPwVBEL4XyejwR
         hmP0xh1WINAZrkVcIlT5rg18SGJx9y4IRB7hkrspb4sEqONBqnzMjrmT+Sg9am3+wsB8
         SZLYFqVeLqfgHrcBeruEjDGTySZ75LpkXvjCYNi66dYovhesxZ1ItU7cGwyuocafc1vM
         RyCthXuhY6ynbfjgUevoLA2tvtkVulk1l/4e0je3s/n5Gm8YhV9Rg7SCOxwp+knu01si
         rEJsIHdOW1DBwE4qli2nOSwMBy6sGyr4T4sAdH6eCr6zOH3FZqk7FF520PlB4EAKypBt
         RqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211312; x=1709816112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waHOmmopUwg4dwiaI2ZXzusWB0J3AUy3GuEFy7B/L/E=;
        b=cX5sID167sdvpRq+9l4MmD4uF3eSyoZKwhkgf2t7YJrCXGzCqGna5KRFDHXVA1c+s2
         ePop7pqqgi+7tibQRgepPf79e8eCNS6PmsnjgrtU46C/W0nYDaa8xHvyWwY2HMNNvTxM
         lBG2Ok4+iNe+HBufcPK4SeU3S63oO13yYknxoqt1XwTpOM9tgmjgnEMc36/MYWWCfpyQ
         Wvrphl5vImy1Zso+mpqG56ewyZcCCTW2gXoK5opCNTdn+rK8I3FU310lY0rGY7eL0VS/
         9IhsYM9Y3h6Bz4lkZxb4nIsXXtz5isJuWa4K7+RpOvN+q0DeckkV46hbshJA1Hy15obl
         +mXw==
X-Gm-Message-State: AOJu0YyNugsVHzieGU+q3Uvl4qj3J2cT4gwN7kUNv2Tld4MJK9rllWi0
	t72LtkrHot3d+yCxS/r8+zMIWFXVuY4ellCbDdei2oNR9k7jv9yf
X-Google-Smtp-Source: AGHT+IHfJ7FAwU5o9nrbWqWhvqJm9/XKc8Z0H4/QN8VLw9ZMAB08SCUbhJSqnsskPklH1LflBWbhfA==
X-Received: by 2002:a19:f804:0:b0:513:258f:5ef3 with SMTP id a4-20020a19f804000000b00513258f5ef3mr1033870lff.1.1709211312348;
        Thu, 29 Feb 2024 04:55:12 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id u2-20020ac25182000000b0051317775ff5sm236883lfi.250.2024.02.29.04.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:55:11 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 v2] iproute2: move generic_proc_open into lib
Date: Thu, 29 Feb 2024 07:54:49 -0500
Message-Id: <20240229125449.3268-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the function has the same definition in ifstat and ss

v2: fix the typo in the chnagelog

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
index 2c10feaa..63d177d1 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -43,35 +43,22 @@ int npatterns;
 char info_source[128];
 int source_mismatch;
 
-static int generic_proc_open(const char *env, char *name)
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
index 5296cabe..11a0ed57 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -457,19 +457,6 @@ static void filter_merge_defaults(struct filter *f)
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


