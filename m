Return-Path: <netdev+bounces-97634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835D8CC766
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC48281A93
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D55FBB3;
	Wed, 22 May 2024 19:40:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285E2D7B8
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406836; cv=none; b=RI2tO0aSSzC1uH89qvfdI6NJJe74FRSMEmqTeh0rGwqfGJaqCntAEe3AfO424RwEWH05A/OJ/BBfLVhxv5FDxgo6x8FGpTuumsyQg9gIVAvpUHO8ZIzrbgsGeSlq3v0ZoETvmFoyeSnN4WxxflY7sT8Tdmb4Qywi7/2WP6bWyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406836; c=relaxed/simple;
	bh=RKvkDYjSasLYARaG8YJ3iaWeuYIm12OiZTInnU7oPs8=;
	h=From:Date:Subject:To:Content-Type:Message-Id; b=HwsBLysJVteGIEL2i2B/ZNWIfrLlWFb4lItBrHv9ZP47lctsYUmjekrs6rEo0SK6JFmfwLfEdvxu2HgkRgrDa0i5Krolh8+g+4uxYmLq5JxuNsxBs6HUkx+VzcpWHyfmBmnLLtWuEqaRZwiI0Hj6c5f07f4N1Qcv8qd7TFVvbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
Received: from [192.168.9.10] (helo=ws2.gedalya.net)
	by smtp-in-1.gedalya.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9rpB-000efy-1o
	for netdev@vger.kernel.org;
	Wed, 22 May 2024 19:40:33 +0000
Received: from root by ws2.gedalya.net with local (Exim 4.97)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9rpA-00000006Jy7-18Q5
	for netdev@vger.kernel.org;
	Thu, 23 May 2024 03:40:32 +0800
From: Gedalya Nie <gedalya@gedalya.net>
Date: Thu, 23 May 2024 02:43:57 +0800
Subject: [PATCH] [resend] color: default to dark background
Content-Language: en-US
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-Id: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Signed-off-by: Gedalya Nie <gedalya@gedalya.net>
---
 lib/color.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index cd0f9f75..6692f9c1 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -72,7 +72,7 @@ static enum color attr_colors_dark[] = {
 	C_CLEAR
 };
 
-static int is_dark_bg;
+static int is_dark_bg = 1;
 static int color_is_enabled;
 
 static void enable_color(void)
@@ -127,11 +127,11 @@ static void set_color_palette(void)
 	 * COLORFGBG environment variable usually contains either two or three
 	 * values separated by semicolons; we want the last value in either case.
 	 * If this value is 0-6 or 8, background is dark.
+	 * If it is 7, 9 or greater, background is light.
 	 */
 	if (p && (p = strrchr(p, ';')) != NULL
-		&& ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
-		&& p[2] == '\0')
-		is_dark_bg = 1;
+		&& (p[1] == '7' || p[1] == '9' || p[2] != '\0'))
+		is_dark_bg = 0;
 }
 
 __attribute__((format(printf, 3, 4)))
-- 
2.43.0


