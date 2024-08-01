Return-Path: <netdev+bounces-115082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BB945094
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81703B25394
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812A1B3F30;
	Thu,  1 Aug 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JhhN4Ab8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C93A1DA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529783; cv=none; b=pj3WK6rdDpjA9lyFRDWZwJKjblUKWpKUQhDA35K4jh7Zacfns04rSvefkGBXz364Jrpx5c1/wc/WizHXD91/CCL8yjuT/Y78C7sh4wkkdHcTzcygtvlakZf5b2zKBJdYIfWRNP8173ovoyOCyH3/Vzo+gk+kjI3q7zV/90RzcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529783; c=relaxed/simple;
	bh=laWYwd7qNBxqwr73ToKNGPeiDa3jqVGUnxWItnhxKPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZIrTFRinsvcWD4iRzN2XRp/JQTm1CYFFWKITyrQQMH1PcP5V4XJchw45Xxb+u9tzomdQe0wclI9sRcj5Pxa804s6m7vnks4gl0ByE2LSJyP3Qas+WExIwu9o0JoqRp43Dy7ljUmydKus3VALIO1G2DWMgN3FgZm6YVNBQK6SIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=JhhN4Ab8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ab34117cc2so4674194a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722529781; x=1723134581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1rtpHwGwr5QTj7wnsnWcGo7jFnAi5nfCUzW4xF5EQI=;
        b=JhhN4Ab87qp/Drrw4qcjdFCvn3VNNNxk8GyLklT3TU4+KcQlKz49CfXqRreTbv3b+a
         b/h/tQuwXiuG4ZmldQ56dqvRiAWJuwaYbQsVYIAe4L3VUqtFlPi4EgScIfpA2grXuPcK
         yt0ikKNC3gfykCnRYhjIeTTVVFBbRxYBU/eG/isTr0E7I9fH3IJLux/Lw60H4o0MbDLn
         Mn1SNEvT/vMsyJLPAalxJYLQJusX4p5nqas7t1Hp/TGrMbt3EU58GHYyai6mPvACKKKT
         R9w2t80Tr2l+PtT79usCmC9bIsHD/rqGDQzHoyxv8XlNVA9ygMFQ7hEKusODkWCUqyO2
         BTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529781; x=1723134581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1rtpHwGwr5QTj7wnsnWcGo7jFnAi5nfCUzW4xF5EQI=;
        b=aYeqUxfy9L/6RHB/FR8GmOoC7kp8s7Nq7dyyk1aPV7rpnT8S8nHzllAiA6EchxERca
         I8RCHFN9vyewXY0SLgR473OCqAjiLRrablKXCQMWDlbqvt6kPYV1Dcd+xLQSkgFxl0qM
         lqDSsrLKXrKNHh+/tlMNw67w9fgN+eszx1T0dNMJ8CLACz96nSItnyJRPdseJ92zF4cV
         3xZNf1EWi3jMTJVo/ckx4vEVWMssxBqiJfQANrklOAaCjAZ7dTnWr46aLyMUnrpPJcc/
         MnOypkm5O8LtfYletP8aRwBY5du3OXkSrtAYLaNadSREkN88hviuUJYqt3WPO+qmujjS
         8BvQ==
X-Gm-Message-State: AOJu0Yx4hUMCNrIt7P54VwLq9FSqowqE9awb1YqSuuxB5y8Q1TN7aDQt
	jfJSm3J1PLaZRaXYdGKfoAMgAdOc3aczvBI+NMMIemEk7D9cdtzzHlGyo8zAH95YMFMh3jBMoYd
	w
X-Google-Smtp-Source: AGHT+IHC5v4jpyE3ICHYH232neyJkEpQX3ye4aY8EWxPq46Kk1L9CfVyrGijJ//SUsOs9E/7M2hOaA==
X-Received: by 2002:a17:902:e541:b0:1fd:ae10:7242 with SMTP id d9443c01a7336-1ff572b9e3emr7392675ad.32.1722529780928;
        Thu, 01 Aug 2024 09:29:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53c59sm703495ad.69.2024.08.01.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:29:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: mlindner@marvell.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] MAINTAINERS: update status of sky2 and skge drivers
Date: Thu,  1 Aug 2024 09:28:42 -0700
Message-ID: <20240801162930.212299-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old SysKonnect NIc's are not used or actively maintained anymore.
My sky2 NIC's are all in box in back corner of attic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..a792523cde1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13537,7 +13537,7 @@ MARVELL GIGABIT ETHERNET DRIVERS (skge/sky2)
 M:	Mirko Lindner <mlindner@marvell.com>
 M:	Stephen Hemminger <stephen@networkplumber.org>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Odd fixes
 F:	drivers/net/ethernet/marvell/sk*
 
 MARVELL LIBERTAS WIRELESS DRIVER
-- 
2.43.0


