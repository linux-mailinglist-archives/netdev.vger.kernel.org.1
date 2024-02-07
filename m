Return-Path: <netdev+bounces-69979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E384D2A0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F7B1C24711
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A0126F0C;
	Wed,  7 Feb 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5lr5q6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6C126F0B
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336562; cv=none; b=UvgFwcKdjaVX2rrAPr5lnL8OgKFLMoyaF9YQOswvNz2EwU7hAtqJif+E0+LhWEQes1MU5R5URVnKMmaT10cvsi1dD7PwldkiHWyutxMp65AQskJ8uZtJYwUjs3Vk3R6se0FIn8n6TrBXHb+CmsOnPBFj0H6dL9kPJicgRNbMWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336562; c=relaxed/simple;
	bh=2HKfLsGBKWZtT9ToVjE5xbyaP9Hkd4XNm8jbjc6FJEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YC1XxiuNrHD7LRzZM8kOa5Qas1jAp8Elt6H3hE8fp0fZFWaQ3o1YQKc4ZE8YWkrTUR+iWY5WR0o+9FWcb3FJxDOtbqBIIpzAe758JkTxWkwe8ejASXiDbuPK2sSKsQqQ7j58/sJ05nNJdXAR9/it81CiVZRSm9ypW/9/7GCGDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5lr5q6W; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51142b5b76dso1718950e87.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707336558; x=1707941358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NSFzsd2krYQoyvWOh/dTgU21d75kEdZiO5Ggc8Azps=;
        b=a5lr5q6W5YHsl/z05ZasD32MCALBr9pb2NqxrNKBUHoWWmgB62nrBfWT90jldR7eWb
         qfIXKBHAQIWsizx61SN1wxhXrtYGAdArfqVmPEv8PmzeKz2eG7p2e13Sg7XOqryGavCx
         Yooi8p6Uvi8o4yogfR2iIHMExsZhz85InmGdxgE+g4Z9SFNeA7BBf0PmeR1WCMm5cO7m
         AW5WCoFtMjMBg31gXEowUKMQJRioiSLrTWK5juGAT41Cblcd8OF5j1XWFap84my+EwuJ
         kVrImtPhQeaAEhBgqQLfpJq0iYzCx9C3+i0/bRgn5qvYhD0Ry1c0yaqs/pyIb02xv9mj
         iThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707336558; x=1707941358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NSFzsd2krYQoyvWOh/dTgU21d75kEdZiO5Ggc8Azps=;
        b=vO7mTzoY0J7hubbuVYTlTx0RVlgCb3LCoRTjEtlIQe3dNEwDJqtaWWyzKtxNM9isAb
         ndRW8dFQX24xs4JjASYaeo2YItQYjDOBFIB1hLFM5gw7tr+q8qA6yzz6tmEkRNZFBijn
         T8mSUvxCQeOMc0fsrr7EvKTudn9TGxMiigjYDcUVPkZdYBLBeSHdwMRL3PhKKdTKXjdq
         gn8LexBX9sPI5u96d4jJIMeO4DjEV65udR925W1HWfAyTC+k8nrq0ibPsx+UjkQr5AkB
         mUNW5bRhz+M0+OpA48k+25nXtmAspDoG79SMkAjHA7gbclYpx5NpnvoM3oOCTtxlgPks
         6RJA==
X-Forwarded-Encrypted: i=1; AJvYcCWLDKVwUgAdh5YSOSo7l6YMj5au2D+kdYUAAOPh7Svd/DubpQ6G+G84pDfHfzPHPABv9l2AcS/S58zQ3oCBZxbN91Xg/bQv
X-Gm-Message-State: AOJu0Yx+R5KQJqxnSFAL6Vwn7f1SK6KFq2odhW38yJM7EhTXlSfgjr8q
	7XaTZewGABiGLyyvFl9ZeKIMESCKDEqZVOrVDR3BT4cPFkUEl6sZ
X-Google-Smtp-Source: AGHT+IGX/A6vhp/2iYXS6p1gzCZ6Eu0+ygO70R4gM7/lDhmWdFvfskcc+c31G51QB+7l54X2Wl8Vfw==
X-Received: by 2002:ac2:5df6:0:b0:511:3cfd:fdaa with SMTP id z22-20020ac25df6000000b005113cfdfdaamr4716617lfq.68.1707336558244;
        Wed, 07 Feb 2024 12:09:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8qDFx9zOi55dFphQ9slx9fuYQC5paRacHYW0AHeSs/Zj63ar4rPHpYrsXIwg7w7choEC+cmXTAmYCSQPzrgAJQVV/glFA
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b005114dc093desm302671lfd.259.2024.02.07.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:09:17 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] genl: Fix descriptor leak in get_genl_kind()
Date: Wed,  7 Feb 2024 23:08:23 +0300
Message-Id: <20240207200823.7229-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 genl/genl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/genl/genl.c b/genl/genl.c
index 85cc73bb..74100dad 100644
--- a/genl/genl.c
+++ b/genl/genl.c
@@ -71,6 +71,9 @@ static struct genl_util *get_genl_kind(const char *str)
 	snprintf(buf, sizeof(buf), "%s_genl_util", str);
 
 	f = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (f == NULL)
 		goto noexist;
 reg:
-- 
2.30.2


