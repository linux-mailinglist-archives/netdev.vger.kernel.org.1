Return-Path: <netdev+bounces-173634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D4A5A41E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7EB174D01
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC241DE2A4;
	Mon, 10 Mar 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EErT9PAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4C1DB34B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636427; cv=none; b=o2gbHs85yhHNcZPCkff5hlaQeSOcL7Xrq3797N3svmhsNmVOcR+Ty3yRVv5GtnweFdFsBU0pRKeQ11ubC2qZFTje1nWls9nV+LI60CBMiBkT3Q4rHuFKFRRyiAvKzrDtEOniLMSBLyp+uwh0vvx5lBXHmmKcxawPZ29xeYuZq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636427; c=relaxed/simple;
	bh=Prtyl7E/OlZQmsd6sENJ+knoOF4yA3rsdozFEUHWSak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+Len9O0P6MrpvwfG/ulcy9f5zbauUQcsRZXLONsFswX/Lw3LYqAfwi2WZJxubRriVd+3R043N6PQ1ekTGZGfNjxE5F5P8NknTg+GY5fgeMFJT783VvwObBDLnG9ExshCFzLMJfH8Mkx8BrBFdY6nuo7LXl/WnsqaIMzHgRa24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EErT9PAj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso957697166b.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741636424; x=1742241224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxZqrAtWrwXuDZH8ojUwm9VHH8qf76N0gCXHNO5fdEI=;
        b=EErT9PAjWSmrH6EUgYmo3hAPeq7l2tqwV5aeJ7WjKy1v7ArQ084vSe9XKOrwjiafjE
         MQHiCcB+6rhM+hbYimamaudu4zhrY58AWQd44zJY/yK5yiyXfRI0Xh7klEoz2LtNv0yT
         RfWpj5vHAgLIFAwnc2CD6O4h7exPraCqgzx/Yi+OYfql1iuXh9syjHWzGX0O1L6oQxgm
         t4t8/ICt9c/mGYck2RlKWkWKhRpxBeL4SquooJuuULx15XOeFgKljoiucZiDKohGwxdI
         +MP+wCT82mQD+ELHelCIv5/XvsNMDhPu83ApcHqBe17kTY15fgmL5iC2FCb6HeL+4T5x
         d//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636424; x=1742241224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxZqrAtWrwXuDZH8ojUwm9VHH8qf76N0gCXHNO5fdEI=;
        b=WR5pdWJGBxIFv7+AT+2hOAYiHaWVuuHKJRxGUJqvBSngH2pXBIDgP39YGT2j8fIwZs
         PZu1R78UADxs7ZZdCWmZiRGNQBnRSBVU0rOfuyZXfiyziyK7zJhpngGVYTZYJohcRcR+
         s0C0h9+ss44AQzMwUlaf+T8zP1ThyD4jNU+LkjL7SoxFkigJrZf1+NZ2b3aSzBFG+5/8
         wcBfwNXuiWGDenzOYO3RjwMtLbrc/ROdSmC6xW2qzex35eCIOVhsIZQ3cUch645PTlQ8
         Js2bJn7nkXAB2DcjvS6iSEY9OgUKOu88nTuOoDkzXgap3FonLyGh8Gcu7C0PaGNrCoyx
         /Zlw==
X-Gm-Message-State: AOJu0Yxk8xj0Qh9YiUHKuNvNGUdhPmEAur76y8Mg+tKgWVEFwrC+0UVJ
	2KLJGkorTmIE1p9G+tAnp8/2/OgRZfq9RdpoDCLEkxQpjJNJiylYB79PkA==
X-Gm-Gg: ASbGncsHpv2q/Dbd7kcjRcsqxIAMIr2AxcUU+3jG9/R0/Jxny7u7zUozXQ6zhdruJTP
	mBcGovDAMs3TEfLiwvRNEEJczzDmzuNOY0/KH7DdJcqwHwWgzdzGSvVX4FrxYMXUwuXk3tnMtxC
	1egieZYF3JV+cDIy/CjR7BdvN5+FzSbr/npgiPTLRTaTqSS4heh8kxfb+V8v4pLlfLyriU538bQ
	MHu6U2QA/vM5yExVm2B/6TsHuwy9z0vNK00YGlXAz/3pSbgD9QZnqjhdd5BTxRvH00iF4MLSC1c
	cSHQ+u3WQQTpaZDoMaNmYvHfkzo2ZJSpS07TQQ8sk60pDZ+cx8lu8Vz9vOwH+e8ZssMjQphvN+D
	zynh4J1T7PqYO6kHa+zZh
X-Google-Smtp-Source: AGHT+IGbTWQ+uyqVLrdNSVOlRJhSkQ4+M66G2boo1JvP0MU+3Tu4TS16mTY8aUimbTvaccv9yWEQJg==
X-Received: by 2002:a17:907:7e88:b0:ac2:4b9:dff8 with SMTP id a640c23a62f3a-ac2b9e2397dmr107373766b.32.1741636423596;
        Mon, 10 Mar 2025 12:53:43 -0700 (PDT)
Received: from fedorarm.. (net-31-156-149-71.cust.vodafonedsl.it. [31.156.149.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a09ca468sm221142166b.5.2025.03.10.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:53:43 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Phil Sutter <phil@nwl.cc>,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH iproute2-next] color: default to dark color theme
Date: Mon, 10 Mar 2025 20:53:38 +0100
Message-ID: <20250310195338.4093-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The majority of Linux terminals are using a dark background.
iproute2 tries to detect the color theme via the `COLORFGBG` environment
variable, and defaults to light background if not set.

Change the default behaviour to dark background, and while at it change
the current logic which assumes that the color code is a single digit.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 lib/color.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index cd0f9f75..b7bb7000 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -72,7 +72,7 @@ static enum color attr_colors_dark[] = {
 	C_CLEAR
 };
 
-static int is_dark_bg;
+static int is_light_bg;
 static int color_is_enabled;
 
 static void enable_color(void)
@@ -124,14 +124,15 @@ static void set_color_palette(void)
 	char *p = getenv("COLORFGBG");
 
 	/*
-	 * COLORFGBG environment variable usually contains either two or three
-	 * values separated by semicolons; we want the last value in either case.
-	 * If this value is 0-6 or 8, background is dark.
+	 * COLORFGBG environment variable usually contains either two or three values
+	 * separated by semicolons: if this value is 0-6 or 8, background is dark.
 	 */
-	if (p && (p = strrchr(p, ';')) != NULL
-		&& ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
-		&& p[2] == '\0')
-		is_dark_bg = 1;
+	if (p && (p = strrchr(p, ';')) != NULL) {
+		int bg = atoi(p + 1);
+
+		if (bg == 7 || (bg >= 9 && bg <= 15))
+			is_light_bg = 1;
+	}
 }
 
 __attribute__((format(printf, 3, 4)))
@@ -150,8 +151,8 @@ int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...)
 		goto end;
 	}
 
-	ret += fprintf(fp, "%s", color_codes[is_dark_bg ?
-		attr_colors_dark[attr] : attr_colors_light[attr]]);
+	ret += fprintf(fp, "%s", color_codes[is_light_bg ?
+		attr_colors_light[attr] : attr_colors_dark[attr]]);
 
 	ret += vfprintf(fp, fmt, args);
 	ret += fprintf(fp, "%s", color_codes[C_CLEAR]);
-- 
2.48.1


