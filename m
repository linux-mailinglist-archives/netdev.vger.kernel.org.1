Return-Path: <netdev+bounces-87637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD98A3F4B
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986AA1C20D13
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808556B72;
	Sat, 13 Apr 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iLV7gb9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB256B66
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045930; cv=none; b=AMdoyGlAKZEWaJnCVFG9tVltFHC73yewapfc8C7BOJI92suSvOCKgYG8Z5UXqqxI6bwUyQmUWeuB49epMv4tHxUiRcRrcdJxias+gO/Q6XA1oybhSRZWre+Bm1kcVBn+50khBvojRhlHML5V1goIORPuUgSi7BQplN0QSWjtwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045930; c=relaxed/simple;
	bh=zOuW04K6nU2M6/O+pQx+VAURU/cCrgRvJXjFIlrCI20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbAbpuE7ulTV7LhhOABSekMFdPCiazdlMJFH+g3HBfRdgGZzd6keKlBFyA0GptUnuaGdL+ozuF8NpHjD7hzjCoXkGnRVVrRruAc1cpnduVjHJ+NNYTiqethqTHqvS7RcH45XtH2tct4Km9fgpyFT4eNZWFLz5UGV/WMWshr+f18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iLV7gb9P; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ee0642f718so1630212b3a.0
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045928; x=1713650728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsQvzsw2W1zaLCAxBLZHIkfzakye2H14iWudFAXI19g=;
        b=iLV7gb9PxfZ4vHdArE0OfUlBbKuz+H4008tZ6Stf9OrTE08nuJ2s+B0X10BxhvrFjg
         ULjNw6XcqpPKZ72+d+kTq7hq6pHk/N3vNMYW7HCQ4TIDHM6WO+i5NyCi9DXsFC8P24qB
         S5TrOOcqtyyMPvMVOQQx9ETgQRuMJdcC2PsihjMWZL87gK/p4qrhtJt/3aZrHDFBvMgF
         LrLTK8gqejLrS5d6LyQaMDP6Om+EXtnlQDlIG4wPf5I2CLESQz8QyXSXGf/cqJTcr6zZ
         jxyXCwhML6SJLSoA1zS0pegcsWxKrtBHzuVgbH8IttGlsxp9GrtMc+3qJVxlnbtjHcj2
         YApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045928; x=1713650728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsQvzsw2W1zaLCAxBLZHIkfzakye2H14iWudFAXI19g=;
        b=XtCa6W5dOzzmRxGpdggVhpFFCX0iXiKUfgi8TeXTgHAVswESihBkvHgfRTvbiVtg6i
         IZY1uPq6JgAj11CT3ghUNOJLJzmxGzo4zhiuvh2Zm4b2S4iGSGRmfsM+a+PmyHLWtjyt
         wCGyDRrfBlpctd+DXJpcSDfMcPheiHi1eD8TqtAcwmhEfSRgNaLgg0h6lpo2A+fWuP/L
         HmE3HZslv6VTE3vPAJZJlI6DJiRtl3RIMEShcuReRh+CTX+A0gd1oI0wMGe3DX0Bz+oT
         4xWRVHiQDugEaV26Ts7wfvQnzyOXbU6S+l4wlrjip/eoL9J1JytS01LaJRWhhBDNdyG7
         5HwA==
X-Gm-Message-State: AOJu0YwCbRmRDIPg9ZecNepn7TM34ixH72GqiWapiB3GNG0p5Mw2rXF8
	EIhcgwTjQ2IMExE3PbYqgCv3Ah6oHoIRRTcBpJDIb7eb6NwZWZc62G6Bq4SXuxBHUYVyVcCgSJs
	q
X-Google-Smtp-Source: AGHT+IGdNKuZo6/Y9X7rCFh7oPCZ3oQHqxJVpWnvVQOieREnjnaH3nB+EpnM08sSpKNSu9Fjpd9K2g==
X-Received: by 2002:a17:903:2443:b0:1e5:62:7a81 with SMTP id l3-20020a170903244300b001e500627a81mr8503603pls.22.1713045928177;
        Sat, 13 Apr 2024 15:05:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 1/7] tc/u32: remove FILE argument
Date: Sat, 13 Apr 2024 15:04:02 -0700
Message-ID: <20240413220516.7235-2-stephen@networkplumber.org>
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

The pretty printing routines no longer use the file handle.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_u32.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index 8a241310..f8e1ff6e 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -820,7 +820,7 @@ static int parse_hashkey(int *argc_p, char ***argv_p, struct tc_u32_sel *sel)
 	return 0;
 }
 
-static void print_ipv4(FILE *f, const struct tc_u32_key *key)
+static void print_ipv4(const struct tc_u32_key *key)
 {
 	char abuf[256];
 
@@ -895,7 +895,7 @@ static void print_ipv4(FILE *f, const struct tc_u32_key *key)
 	close_json_object();
 }
 
-static void print_ipv6(FILE *f, const struct tc_u32_key *key)
+static void print_ipv6(const struct tc_u32_key *key)
 {
 	char abuf[256];
 
@@ -971,7 +971,7 @@ static void print_ipv6(FILE *f, const struct tc_u32_key *key)
 	close_json_object();
 }
 
-static void print_raw(FILE *f, const struct tc_u32_key *key)
+static void print_raw(const struct tc_u32_key *key)
 {
 	open_json_object("match");
 	print_nl();
@@ -985,14 +985,14 @@ static void print_raw(FILE *f, const struct tc_u32_key *key)
 static const struct {
 	__u16 proto;
 	__u16 pad;
-	void (*pprinter)(FILE *f, const struct tc_u32_key *key);
+	void (*pprinter)(const struct tc_u32_key *key);
 } u32_pprinters[] = {
 	{0,	   0, print_raw},
 	{ETH_P_IP, 0, print_ipv4},
 	{ETH_P_IPV6, 0, print_ipv6},
 };
 
-static void show_keys(FILE *f, const struct tc_u32_key *key)
+static void show_keys(const struct tc_u32_key *key)
 {
 	int i = 0;
 
@@ -1002,7 +1002,7 @@ static void show_keys(FILE *f, const struct tc_u32_key *key)
 	for (i = 0; i < ARRAY_SIZE(u32_pprinters); i++) {
 		if (u32_pprinters[i].proto == ntohs(f_proto)) {
 show_k:
-			u32_pprinters[i].pprinter(f, key);
+			u32_pprinters[i].pprinter(key);
 			return;
 		}
 	}
@@ -1333,7 +1333,7 @@ static int u32_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 			int i;
 
 			for (i = 0; i < sel->nkeys; i++) {
-				show_keys(f, sel->keys + i);
+				show_keys(sel->keys + i);
 				if (show_stats && NULL != pf)
 					print_u64(PRINT_ANY, "success", " (success %llu ) ",
 						  pf->kcnts[i]);
-- 
2.43.0


