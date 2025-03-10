Return-Path: <netdev+bounces-173644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B658A5A50E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5CE188EF0F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FE1DE8A2;
	Mon, 10 Mar 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnwArEGU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21161DE8AB
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638975; cv=none; b=PhhocHr+/8ehDO4aCo7FQuCzYNb+vSbDpDe7NjpL9gr+3YPZyb0GWK2aRMeAR8PTEHQm4OFQGCymJn7zFcuWR75rM3vAPhjYh0HhB2gFyp88aFtrQBpxmflhXY9nQOYNusbh6VFwyfcC0eWcCEU1kDZeT/Jms4TyCyfmNAJczaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638975; c=relaxed/simple;
	bh=8JLDPX1BWeEeuSytFZ3BFS9cespjL69UN5VidVDW45w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=On4Hw3PBi+N5sgDqr5I3nb7hOLw0kXDq+f/sZ61DblvO9ww8nTpPrA7Cb3dKMbqbjaVf2utwfbd63AjlyKyy2Ez1YdY0N7/EDlLC4ScZmNya74yluB41u3FzKRu4QDXVUECHPollhZEkFsSLvXBScHGc/v58nhUKmCHdSi0S+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnwArEGU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso28119785e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741638972; x=1742243772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fekKUzdkCeIyxmBwxXxgnlga3QYoezJb1Cb1BZdY6eU=;
        b=VnwArEGUhJewb/JbTrPYifKdnYGM+1X0omu0Hb3tNeBMEg9Fkl1pNMh3Zz7IEiiZ2D
         8kEjfUSddV4IqfJFi8fh4FFVCNpHpgOcyTivdHhxs7ZSGGODdiix5MdRGoiR9S2oInfa
         4yriqSzvwXyKMtkfGkswQSfq3yLqovu4wDPdSO6I1pDkCpLn/IEXYdZvPYHC1XG99Tdw
         LRgBvjsKhvwo6KpvUO/o2joR9+5ng8lLt07QM+1P/p7Q16y7AeZERUd8L9NSIW4qEIkr
         Lgz+rPgnaR2e1U+SeFvpl9KdHyDd0qle1lhz3qrWusWHPz6rLH3UFXXxkVBgEVQH7ACO
         tbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638972; x=1742243772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fekKUzdkCeIyxmBwxXxgnlga3QYoezJb1Cb1BZdY6eU=;
        b=cBilPW0ZlxZpN2r/wReQIRRs/f2FhExvJPTpnMymnLsdWq8W956OtJ4d0hHtG2sw/d
         aeI2AvHIhRdF+C2CIp0fK026TEU6XY8W2l6wGap+3G9HpQmwv+BF2L9YCVirwTsYZOZp
         MkMxcRWf2laDyJ8GfxMo/taEaKN6AWOFnDKZR1ml8ILWUKICC3xxXiqyU2Y84TVyHon/
         MAgKC8mpemwXE0cG+sOYC2eXT5Fel78Ia5tbykKOsjoiQZVUmirCad4RtIVZWNRrWn+7
         /R3jScYFYpFfzftRzAwhs3vBzqzEkG+/Nrepoa+1xDxdosJ3xC3rSHL9sPELCWQHCW6D
         Cp1A==
X-Gm-Message-State: AOJu0YxNE+S0JI17+9QdlzskAd7hT+k2TVXW5ZdB0wAsnvwiYEHJNwPh
	iaXWdBGSFsGRXrN8BoFsEOCBHoY/F316E4QT+p+WJXaEZm5epanZVzeawg==
X-Gm-Gg: ASbGncvFPEeVmQFl4WpkWdlDEprUJMd26KeYwg78qLE7Y1afdGf8l+q81LMHN6g9t2q
	Rbb/nBoAzNbSg7i+i3a+zA7nFdY5ABSNbFN4pFIZHRpJ3ukYFD7LKz5seLR1NwRlX2yALTW54Bl
	ES7vL0Y2xx5BiPtxJrgTVVOYT86sCmeMP1oMbKspc2kjSNM7bzMbrN1T5rc4NtzwRTOyfViBY1j
	6QSBgn1jJ3gnQ7RrLoRsXMlMm+rDQ8UnjryMaUAKq7TnD/HOXZKMkci9pBReqpoSqQs5Natr4JA
	wESkIMIqFNsuepIfMScu7gaWbPJE5BsBu+g/z/hQ7CkCgiAXFQpHlKfvbQQWEbCnWTNpWPoiCbf
	mkGM/9bTasMlFIq89BCvJ
X-Google-Smtp-Source: AGHT+IHX1Q1WR72w3FUUIJYD/a5ikU6zgHK5LdDOBJ0ST6phe1790WqG1uyI83bFmEQa5NHr/D9qiA==
X-Received: by 2002:a05:600c:3b9b:b0:43c:f822:58ed with SMTP id 5b1f17b1804b1-43cf822599dmr39734585e9.27.1741638971730;
        Mon, 10 Mar 2025 13:36:11 -0700 (PDT)
Received: from fedorarm.. (net-31-156-149-71.cust.vodafonedsl.it. [31.156.149.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cef25f075sm73173465e9.28.2025.03.10.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:36:11 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Phil Sutter <phil@nwl.cc>,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH iproute2-next v2] color: default to dark color theme
Date: Mon, 10 Mar 2025 21:36:09 +0100
Message-ID: <20250310203609.4341-1-technoboy85@gmail.com>
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
 lib/color.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index cd0f9f75..b883aa1c 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -72,7 +72,7 @@ static enum color attr_colors_dark[] = {
 	C_CLEAR
 };
 
-static int is_dark_bg;
+static int is_light_bg;
 static int color_is_enabled;
 
 static void enable_color(void)
@@ -128,10 +128,12 @@ static void set_color_palette(void)
 	 * values separated by semicolons; we want the last value in either case.
 	 * If this value is 0-6 or 8, background is dark.
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
@@ -150,8 +152,8 @@ int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...)
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


