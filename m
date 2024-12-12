Return-Path: <netdev+bounces-151544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973139EFF49
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4909163929
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA71DED59;
	Thu, 12 Dec 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IzJQtv2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A341DE2A9
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042366; cv=none; b=apvtCwot+R9x7zXWCyReNPlQl05yrtydM21aB/Boess0o0PGw2GeQ+D/tgNTCNH/3M1ZzPdwWudO/pGNVZ1PowvohqDC4JHNGmwOsZdFcm/3PQDlDKwRRE6X+YwqFOsPJvt4TYnPI2OoX1SIVH/i7r0G/rZuYN9NS3QbNnCXDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042366; c=relaxed/simple;
	bh=UCschTUXG8B+cffoozbV5wQmPqrnBlI/jfwv4zqZ4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgr1+7NFtFd12kY7gJrJwvQvn3wCw1vG4N9gXvq9yacU/Hf5D1r1LJRmAN34vgenIQbins//b2VfR7HVOuNxbiVtzDmwNVWMod+KLKHv7/kr/KBY4rXMG7h35iFztGyOGzKyesjDp19eKvhnmQvMEx8As6fVp/fgJRN0l/BByRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IzJQtv2C; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so948217a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042363; x=1734647163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnT7YTCnab/Y0VtR9F2A3nXG/fKpdDUTqgBlIhVljlQ=;
        b=IzJQtv2CVLD4RYsLNhLbrYUfBc4XiMTRv3UCml17HSiafiuklbhyNYJASXAc8R1Cc9
         z4awu6llXYkpDbDKuBidwkYomhCYAr/pJiKzKBaq8rZiMe+OM+vqawFNN0uzWqbBrWlQ
         clMdGVlwDD1bD08W3C+KKz8xYz0CEyVEiWBe5i4ugopX2Yh/Uot+6UryYTo6mIbPSDK/
         0KY0iw+7w9s3X/IThtk/NMhzfphioPXxHKBdYC33UxgusHyXVlioK6UqOJLO8bu/llYv
         AXzRHprwdclHTok0rBfn1Oua/HI7hhudX0244RiaOHZ01dk49NMWF9XKXxbdUnJ4cl2U
         283g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042363; x=1734647163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnT7YTCnab/Y0VtR9F2A3nXG/fKpdDUTqgBlIhVljlQ=;
        b=qgqs6E+NdTBB2uADYbFjsCHd+MkMRw8O7dsVrveuCalhkg/xJ6xoDT0eZqentXovaa
         +ZPgEFJ/NaJ2SLWbb3pPB6Wv4DM4wnzR8TH+4/t6IaL6yuyNqalDXQ0fMcftW8Bm6bT/
         hMZqCkltFf/BgD6IX3pwCis3XKGoOE3jGU2BZjdGcDtF2Cxei6zZToEWH1/5I5hheTzC
         d9mTSYaAHJnwJikvUj6y2Oy6XHecQgkDk2Sn+5JLB+5r+3lyV6t29ALozgBTkSv5BL4b
         nwNDj5W9bjlKs3mXhK2nuFJNP3pjhNtbucv/z9qVgECoRNiFIcZyQnG8Agw7q0I2AXMf
         Gfng==
X-Gm-Message-State: AOJu0YzS9hC2BTEr0gls7MBSI3vzq5BwJ5CBg9KNViS1JvNikPeFC7Gf
	7RKMCU1TQms/PqVUAR0U7y+G1EM9f/rSdlBF2V4KexkMDtyzYAbSCwLbdMLkm/nKnYtbpgX954W
	2
X-Gm-Gg: ASbGnctS+zLUSSWP+2l2ScFkhOoEJPAwQ+Gg23KC8rhSzzsRkUhW+prKc+9145HXLGt
	AkVjWATFsD04LuNxsJqVAl3Pc1IFixq334SE7uzDBtBf1eg8l3qYTUoLdn2poXshtVJsL1US2Yi
	lWJr+dTtwkg5miExH1vT+rxVjwFVZDsWsQveTfigKyLgVlgKJa8a2KE9Q5VX45EoftOfU187G9o
	hymsVIPGyKqV3wA9mocFWFne9rdL4zsIiFyHAJb8V25dXlZKzDtok5n7zrPO/ODakCpL/nKvry6
	hXo67kLwsCUn0JPGa/zVQclHo7EdsDSrvw==
X-Google-Smtp-Source: AGHT+IHRbJGsVtXmnxR2DbD51zEp7URifrcEXlohQ+Vo3lu7hbhAvYp9nPL/6WF4VIyEcs3fR4y7xw==
X-Received: by 2002:a17:90b:1fc8:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2f28fb71d6bmr632537a91.9.1734042363308;
        Thu, 12 Dec 2024 14:26:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:26:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 5/6] flower: replace XATTR_SIZE_MAX
Date: Thu, 12 Dec 2024 14:24:30 -0800
Message-ID: <20241212222549.43749-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
References: <20241212222549.43749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flower tc parser was using XATTR_SIZE_MAX from linux/limits.h,
but this constant is intended to before extended filesystem attributes
not for TC.  Replace it with a local define.

This fixes issue on systems with musl and XATTR_SIZE_MAX is not
defined in limits.h there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_flower.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index 3b61c219..6fc2c6a1 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <net/if.h>
-#include <linux/limits.h>
+
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
@@ -22,6 +22,9 @@
 #include "tc_util.h"
 #include "rt_names.h"
 
+/* maximum length of options string */
+#define FLOWER_OPTS_MAX	4096
+
 #ifndef IPPROTO_L2TP
 #define IPPROTO_L2TP 115
 #endif
@@ -1252,7 +1255,7 @@ static int flower_check_enc_opt_key(char *key)
 
 static int flower_parse_enc_opts_geneve(char *str, struct nlmsghdr *n)
 {
-	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	char key[FLOWER_OPTS_MAX], mask[FLOWER_OPTS_MAX];
 	int data_len, key_len, mask_len, err;
 	char *token, *slash;
 	struct rtattr *nest;
@@ -1265,7 +1268,7 @@ static int flower_parse_enc_opts_geneve(char *str, struct nlmsghdr *n)
 		if (slash)
 			*slash = '\0';
 
-		if ((key_len + strlen(token) > XATTR_SIZE_MAX) ||
+		if ((key_len + strlen(token) > FLOWER_OPTS_MAX) ||
 		    flower_check_enc_opt_key(token))
 			return -1;
 
@@ -1275,7 +1278,7 @@ static int flower_parse_enc_opts_geneve(char *str, struct nlmsghdr *n)
 
 		if (!slash) {
 			/* Pad out mask when not provided */
-			if (mask_len + strlen(token) > XATTR_SIZE_MAX)
+			if (mask_len + strlen(token) > FLOWER_OPTS_MAX)
 				return -1;
 
 			data_len = strlen(rindex(token, ':'));
@@ -1288,7 +1291,7 @@ static int flower_parse_enc_opts_geneve(char *str, struct nlmsghdr *n)
 			continue;
 		}
 
-		if (mask_len + strlen(slash + 1) > XATTR_SIZE_MAX)
+		if (mask_len + strlen(slash + 1) > FLOWER_OPTS_MAX)
 			return -1;
 
 		strcpy(&mask[mask_len], slash + 1);
@@ -1318,7 +1321,7 @@ static int flower_parse_enc_opts_geneve(char *str, struct nlmsghdr *n)
 
 static int flower_parse_enc_opts_vxlan(char *str, struct nlmsghdr *n)
 {
-	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	char key[FLOWER_OPTS_MAX], mask[FLOWER_OPTS_MAX];
 	struct rtattr *nest;
 	char *slash;
 	int err;
@@ -1326,14 +1329,14 @@ static int flower_parse_enc_opts_vxlan(char *str, struct nlmsghdr *n)
 	slash = strchr(str, '/');
 	if (slash) {
 		*slash++ = '\0';
-		if (strlen(slash) > XATTR_SIZE_MAX)
+		if (strlen(slash) > FLOWER_OPTS_MAX)
 			return -1;
 		strcpy(mask, slash);
 	} else {
 		strcpy(mask, "0xffffffff");
 	}
 
-	if (strlen(str) > XATTR_SIZE_MAX)
+	if (strlen(str) > FLOWER_OPTS_MAX)
 		return -1;
 	strcpy(key, str);
 
@@ -1355,7 +1358,7 @@ static int flower_parse_enc_opts_vxlan(char *str, struct nlmsghdr *n)
 
 static int flower_parse_enc_opts_erspan(char *str, struct nlmsghdr *n)
 {
-	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	char key[FLOWER_OPTS_MAX], mask[FLOWER_OPTS_MAX];
 	struct rtattr *nest;
 	char *slash;
 	int err;
@@ -1364,7 +1367,7 @@ static int flower_parse_enc_opts_erspan(char *str, struct nlmsghdr *n)
 	slash = strchr(str, '/');
 	if (slash) {
 		*slash++ = '\0';
-		if (strlen(slash) > XATTR_SIZE_MAX)
+		if (strlen(slash) > FLOWER_OPTS_MAX)
 			return -1;
 		strcpy(mask, slash);
 	} else {
@@ -1376,7 +1379,7 @@ static int flower_parse_enc_opts_erspan(char *str, struct nlmsghdr *n)
 		strcpy(mask + index, ":0xffffffff:0xff:0xff");
 	}
 
-	if (strlen(str) > XATTR_SIZE_MAX)
+	if (strlen(str) > FLOWER_OPTS_MAX)
 		return -1;
 	strcpy(key, str);
 
@@ -1398,7 +1401,7 @@ static int flower_parse_enc_opts_erspan(char *str, struct nlmsghdr *n)
 
 static int flower_parse_enc_opts_gtp(char *str, struct nlmsghdr *n)
 {
-	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	char key[FLOWER_OPTS_MAX], mask[FLOWER_OPTS_MAX];
 	struct rtattr *nest;
 	char *slash;
 	int err;
@@ -1406,13 +1409,13 @@ static int flower_parse_enc_opts_gtp(char *str, struct nlmsghdr *n)
 	slash = strchr(str, '/');
 	if (slash) {
 		*slash++ = '\0';
-		if (strlen(slash) > XATTR_SIZE_MAX)
+		if (strlen(slash) > FLOWER_OPTS_MAX)
 			return -1;
 		strcpy(mask, slash);
 	} else
 		strcpy(mask, "ff:ff");
 
-	if (strlen(str) > XATTR_SIZE_MAX)
+	if (strlen(str) > FLOWER_OPTS_MAX)
 		return -1;
 	strcpy(key, str);
 
@@ -1433,7 +1436,7 @@ static int flower_parse_enc_opts_gtp(char *str, struct nlmsghdr *n)
 
 static int flower_parse_enc_opts_pfcp(char *str, struct nlmsghdr *n)
 {
-	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	char key[FLOWER_OPTS_MAX], mask[FLOWER_OPTS_MAX];
 	struct rtattr *nest;
 	char *slash;
 	int err;
@@ -1442,14 +1445,14 @@ static int flower_parse_enc_opts_pfcp(char *str, struct nlmsghdr *n)
 	slash = strchr(str, '/');
 	if (slash) {
 		*slash++ = '\0';
-		if (strlen(slash) > XATTR_SIZE_MAX)
+		if (strlen(slash) > FLOWER_OPTS_MAX)
 			return -1;
 		strcpy(mask, slash);
 	} else {
 		strcpy(mask, "ff:ffffffffffffffff");
 	}
 
-	if (strlen(str) > XATTR_SIZE_MAX)
+	if (strlen(str) > FLOWER_OPTS_MAX)
 		return -1;
 	strcpy(key, str);
 
-- 
2.45.2


