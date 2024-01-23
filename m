Return-Path: <netdev+bounces-64945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E383865A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 05:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FF41C23831
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707377E6;
	Tue, 23 Jan 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QPyeplog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0A3C3F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705984216; cv=none; b=DcT4BTYUPwCbl/CFLpqm8Af/XpzMoFSBTM7tTx2+/DhpImYH+mUHP/N6j59rtZHenK+Lc1LIakuG2Rcb3RUGDtmh8oYqGjDNinBtClz1zPzudU1Mwz30d9+ZQx8YGV6QLyiPpyg5nPqcYQMxve9suPjrFi8g2iWR7VyPk6cgT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705984216; c=relaxed/simple;
	bh=XnVk7/Wv9NSGQ1ebR0dMix4q5G88VcF6lPEm8CHx0/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWpcVJ7mkLNC5yIzZF9oQ1yI4KM3+YxYcsQ1Lic622MFVkAn7prsBirvdvd9eDoJjTskKHf2AgYeUG4Av3toHflXS/VitJHOx0CkhW3+bVlll1/nsVDo+IJsr5EE6+DgfGnnna5L4vOjPI1SR0T51H8ENGI9gHUoYpPQxp1h3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QPyeplog; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d711d7a940so33292135ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705984213; x=1706589013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VACM3RPTKqyu+giGfbC9BEvgjPZjBLFLMSF9kyTesZQ=;
        b=QPyeplog6MqSaPLnfbPuSJtoNTNwrpHBGxDaN8C5VQUU5+IGuR6tR6ztyB2oNZ+gW3
         d1O0TSlr2kHe1z1YcRsRghAM6mjCMG0+uU5vfzK/F3AhZlmnjPfzjsEu/xqFkZRV/m4Y
         MjK2d42p10rPybTvNcQl7ynWN4x8iQzkNBM83IogsaQtBdjOi2lCIA1du5JZJTC9YDhX
         WMobJlzVjkw8Z100EXF0n8+7eyEzxwSe2lmOXMFEy438R/sQlm3/+fDKWGHqQSmy7C6S
         ooruP+/qb1AiFUigholM5PQoAp7Y3wy4dsTB2rkSVT3Z23frViS4X3+BIiBhJJyW5tFw
         xrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705984213; x=1706589013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VACM3RPTKqyu+giGfbC9BEvgjPZjBLFLMSF9kyTesZQ=;
        b=D5QMMIoP5Q4nLIQtmgvh9MJEXalYpFb2RB4j5t9Rov3mj4r7Jlxw/3wFvhdHhwUrYR
         omni4kkIT0zClm/CiSMSI5r5SaimbW5nM4IRDq7xB8NO2YzomPaQazDk6DaOPSBB5NS0
         KkZCkOwqlFZjPLuDDQSBT35640JGpMrsQt5oRxhiWp2NY+lh4pfIvqR/CuVBIPHKkJcN
         IX7HW9X8DCfyYDcsl6DOYtobhfKFxqKcLiJYMGe3lAgSRZNid7lcrXKDWFuiGVxcMVQH
         Pj5gHPwBS6iYA32y75sdkRYUn6F7g4mwyC9028Swh9k3AGaXE7jtxKUvebKXeYXC5Do6
         ANrQ==
X-Gm-Message-State: AOJu0YwOFAlZSuqWlWI+gvIEECBc8/2Vj0zVtdOL2JL9c0DAXrT1HQXt
	5l38W7UMll6hfCdjXYhHhKQTcXWGUYYBBFkssnx8Tz7+lSvmfspE/XL/WBiXA15IJJ35dV/gz4Z
	Q6O4=
X-Google-Smtp-Source: AGHT+IFpwpyij4XkjaYxWFikiOwhZzu/OILG7RLrHAvN/g55Y5d4kN8tU0xT3HfTP5ypcyzmGZSfww==
X-Received: by 2002:a17:903:228c:b0:1d6:f185:f13b with SMTP id b12-20020a170903228c00b001d6f185f13bmr7088224plh.17.1705984213575;
        Mon, 22 Jan 2024 20:30:13 -0800 (PST)
Received: from hermes.lan (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001d72cf69508sm4672254plb.23.2024.01.22.20.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 20:30:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH iproute2] color: handle case where fmt is NULL
Date: Mon, 22 Jan 2024 20:30:10 -0800
Message-ID: <20240123043010.266210-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases where NULL is passed as format string when
nothing is to be printed. This is commonly done in the print_bool
function when a flag is false. Glibc seems to handle this case nicely
but for musl it will cause a segmentation fault

Since nothing needs to be printed, in this case; just check
for NULL and return.

Reported-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/color.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/color.c b/lib/color.c
index 59976847295c..cd0f9f7509b5 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -140,6 +140,9 @@ int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...)
 	int ret = 0;
 	va_list args;
 
+	if (fmt == NULL)
+		return 0;
+
 	va_start(args, fmt);
 
 	if (!color_is_enabled || attr == COLOR_NONE) {
-- 
2.43.0


