Return-Path: <netdev+bounces-97642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF68CC7FF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60470B21028
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810220DF4;
	Wed, 22 May 2024 21:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB657CA6
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412225; cv=none; b=dA8kacpUxbOvzn6e3Nx2pNVi0Zpc9iDT5sX2kqAkxgwkh4686j6XlJto/ep2U4L/aNcQ0vCTkvaUmW/ww2PAIYvuT2JJWfYqoNm3Y9OcopxnVo4pnPNyW70aDFRWl4B01v8SQBJMJzwTUSqi/qgGezL6hrE4HeXSo0r8jBuBgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412225; c=relaxed/simple;
	bh=+lL3RWLKQLUaYmZrhhv6Mdennu+6wY7o4tw3Jb5jMu4=;
	h=From:Date:Subject:To:Content-Type:Message-Id; b=XRp++GknKpr2/t3WmBkrgeKSid1I3ppXQoU1wXrzRYxoRgOHx3mbppQrqpRZU3D1HVYW7LAsAuHAEmZalGku+BKAPeamxrv5EWFKDqxBAhkJBxHiZHaPD5NKA+qLOMCQIw8qQ1z/MsdN22oUTFPnzlg+bCuAi5SWpBCAS3ZKtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
Received: from [192.168.9.10] (helo=ws2.gedalya.net)
	by smtp-in-1.gedalya.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9tE6-000eod-1X
	for netdev@vger.kernel.org;
	Wed, 22 May 2024 21:10:22 +0000
Received: from root by ws2.gedalya.net with local (Exim 4.97)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9tE4-00000006L4I-46tH
	for netdev@vger.kernel.org;
	Thu, 23 May 2024 05:10:20 +0800
From: Gedalya Nie <gedalya@gedalya.net>
Date: Thu, 23 May 2024 02:43:57 +0800
Subject: [PATCH v3] iproute2: color: default to dark background
Content-Language: en-US
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-Id: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Since the COLORFGBG environment variable isn't always there, and
anyway it seems that terminals and consoles more commonly default
to dark backgrounds, make that assumption here.

Currently the iproute2 tools produce output that is hard to read
when color is enabled and the background is dark.

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


