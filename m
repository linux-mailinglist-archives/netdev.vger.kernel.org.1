Return-Path: <netdev+bounces-76159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCA86C984
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB631F230BF
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C947D3EB;
	Thu, 29 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxJpP6aK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33095A7AE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211192; cv=none; b=Y293m9YUS/Dax88a/TZE+pzaXLGfcR/5fDZArWjbTt6f+8AYAPWyYMepXPzHqHjaila8mEWxyq7+NhlxJDX02mGuGP5s2IKN7Qr3DFaI5pRdIII4JZNVcPD3zBk9aH7NHybhE7Zd4REMhbdz5l9CTVR8sGNrLvZPBIXa4/otHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211192; c=relaxed/simple;
	bh=RxQWUN5hw/KLeAipcjRcT2++TxAleuUuv7usyrE2y9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+7qKxBv/BJV/wpdVUZTAESdiu/xugWroO1IgHjpfHSleOdDUfA9zeUInWtC4arD0HjP9yEdVwoK+TTG68QnLbTnFKUd4rBVcpK83Rxl1VdeGMXhnJCGSSgSfcKFan6deCZ2rn8irxupboUcICTondEmKEmDSZLKdRLJGxf+7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxJpP6aK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513056fe2b0so242199e87.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709211189; x=1709815989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqL4p1r87zz8pnjvxtpe0BWG8roah9/YtMy/oaImtnQ=;
        b=YxJpP6aK80LvdKCvLydBj10kOUSpGfbz9apkVUuyTHYsaZDUaGty6PT5N0fdYgpr5G
         kzkCtqte6X0eSfM5b5jgHUkrm4kGZCb0C9Hfhq6mEm3zgg79/WG6KnxjcTTJ8u3uAzyT
         6eZMrtIT210aWs4nrj0ACq6sVN7uPSGU/sBnbWO9O852HhII3c9S+UcUTassbIcO4I/Q
         n8U32Oj8cwmMzXOl798n4mRIW/rnf9loFWZVHpMQ91rb3f0X0aviEr8PN7uYVwF6yiLm
         xq+qX8WdTcz3RaxrVMzHhhSVfMSHvyhrI3r6lGqXVNEOO0yFdZHgbHw/NrdwkexYa/BY
         NhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211189; x=1709815989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqL4p1r87zz8pnjvxtpe0BWG8roah9/YtMy/oaImtnQ=;
        b=ZmjLaIgDY8dxjffeDh+NmbeVNPRtaNNh7+A/jD8+sRSk49dD2l6hWzjdC1TfMOdiKD
         robQCJlL0xs45tg73ECc7dpr8aoGrnmqZ48MISE2dJRtLd9ViwlHW19gvhTphFG8Upai
         gj5CKwBOToo/r5F5m6JiT4NQHg4lkH3KA0tE8cir4AiMEECuQo2T/nkp2cTtzxH4vwlv
         caQ7NQ5SH4ohuZ+uZdePvqJs2wErUTYf0rNz0TzQbnisM61U3mrYJNvVU5my3f6zFq5H
         KEEapjIGVltds+JGzyppZMTMXmid4p0FvDxAAibhc5RJbdGwPpwPyeUlF8W6FK18Ek6m
         KqDg==
X-Gm-Message-State: AOJu0Yxp2gKWnYlTMtfS/+/9mn75yvO0Sh4Mzbf/QN9k66JmL/VCmSBb
	y1UBvZloTsYl8T2nAAORvQrqFghBLnYjBh1wJeAV22pwAPvtyuMQCLsHr+lTJsQrrA==
X-Google-Smtp-Source: AGHT+IH8PLZTLI9JtxTbucEPTdWq/Uid0zVqhInOU3PYfskywu6ctFjJVt+bl6GAaTkE7TcP2rKR6g==
X-Received: by 2002:a05:6512:23a9:b0:512:bc0e:27fe with SMTP id c41-20020a05651223a900b00512bc0e27femr1674583lfv.1.1709211188454;
        Thu, 29 Feb 2024 04:53:08 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id dw13-20020a0565122c8d00b00513149c310fsm240779lfb.15.2024.02.29.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:53:08 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] iproute2: move generic_proc_open into lib
Date: Thu, 29 Feb 2024 07:52:58 -0500
Message-Id: <20240229125258.3192-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the function has the same defenition in ifstat and ss

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


