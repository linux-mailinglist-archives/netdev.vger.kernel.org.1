Return-Path: <netdev+bounces-142328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F69BE476
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD22B20E5D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252971DE2D5;
	Wed,  6 Nov 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMb0Flhq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E71DB92C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889627; cv=none; b=uSUNs+biNLqG2mTM3fur1O1pmw9YjDfvWJcgCpLqlG1CSHwNKAyPJRVYSb148iFHDAhw6SEeVWGMWPUCQOB0rvvRf4FHLXNxjJyGTBenSbyULQwT0dHQznaPZgcxl8/JtlmYPi73RSZ0wnAq+00WkmG2WuKClTSdIEruIcIGon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889627; c=relaxed/simple;
	bh=vgc1Ys9QkOqUWQKYHzFMYSA3Go6hm/nnPiQ2TU1a1TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tB+pXKGfzKvIEFFc72Zgejk0ggdu53TVmmKsEqDqS1CJFiNJCV61mC7rbDoDPyIwD4DBjJr10Kjif3R5yz/i0EGGEFy91uj7qKZCahm0uvAXKRGYzg/5VUuX6nWYx1nel0NQpebJzSm/qOVff307KUDoR9kOI6bDH4UjlDqzx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMb0Flhq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf6eea3c0so53139155ad.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730889625; x=1731494425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQpKY05JOYjPURTPx5+mIgiP69yD+/zLK9ykR+kpvfU=;
        b=LMb0Flhqo9mEeZLkdKfzPGACrklYLOnN9CrmTzQ+vDyOsDrNSIBOB4EKja0nrU4VA3
         A06hbmsJjr2nCLRD1PaKsTOxsunc/nINTg8guZNRLoA4i/gthO+1sjLTgLKZ3bo8t55+
         Dt7WtRSN+MO9CiMxmKlKZJpnMcWXtmVzegn+veuOzIqhf8qafcs6g9QGs0hxDKyMt4EA
         lQLtYsHxa8LiG1nenddwoNQyx5N22WT3bjkOGTWoHy24vpSavifCM2YTvu/Pn4l4srmT
         KL30V/RslK0q4xXEoLfQVewqpvx9J55CFxJuVth7tVZPEwfJA2K+VdJ9HMJuMxatrI8A
         3EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889625; x=1731494425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQpKY05JOYjPURTPx5+mIgiP69yD+/zLK9ykR+kpvfU=;
        b=G9BAh7rboh+OLr88w5a3lae9/qhrr/vHRs/rmBQ5FccvTw1wth4ErboolFj2kCRIPY
         lcLjAzy1E+BByHXsxZ2oF42xWhVCydbpzXI3MRZ8LZXGFc075IYH5kZQ32gapseSvPyd
         h/ggIttZ4odqXsi10BnC2zOmN5G/tXfV2Ot8pMmUkEVQucwwu6upmLRX1MNbGpzb5cnU
         SCNoMU4awQED5wfWyq74KTeThb/iE3L4sjQxMHl4F/pLHcGIu1FVMuSBMaJ4qAHG0FnZ
         wiTZ7m6JzULNOo0lArOBZU8HctDVxdEYifHyecFH831/YBkpqreZQ0xl9iW+AbXLmoCJ
         7Jug==
X-Gm-Message-State: AOJu0Yw/Dg/GNxKY0ic5j757brVD9I/0yHS4VZAd9kpWKrTq2dRtr12F
	853iicjY+dY7wrPKyYyIakVHsHjrhzxtwy6+PqnYG3waoPcbaN5shMrJUaiF
X-Google-Smtp-Source: AGHT+IGvjohxVmrQdcKedikuyP9N2c3M9m+qVYjGg+QtCTZHvb6uatr86RbigY6MnbpF+FTXLqG9rw==
X-Received: by 2002:a17:902:d4ca:b0:20c:a387:7dc9 with SMTP id d9443c01a7336-210c69e32dfmr564467445ad.29.1730889624690;
        Wed, 06 Nov 2024 02:40:24 -0800 (PST)
Received: from localhost ([2402:7500:579:df4c:d854:3b57:31f1:c2a7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda5fsm93414575ad.7.2024.11.06.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:40:24 -0800 (PST)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [net-next] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
Date: Wed,  6 Nov 2024 18:40:05 +0800
Message-Id: <20241106104005.337968-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Because optimizing the power consumption of t7XX,
change auto suspend time to 5000.

The Tests uses a script to loop through the power_state
of t7XX.
(for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)

* If Auto suspend is 20 seconds,
  test script show power_state have 0~5% of the time was in D3 state
  when host don't have data packet transmission.

* Changed auto suspend time to 5 seconds,
  test script show power_state have 50%~80% of the time was in D3 state
  when host don't have data packet transmission.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..dcadd615a025 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -48,7 +48,7 @@
 #define T7XX_INIT_TIMEOUT		20
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
-#define PM_AUTOSUSPEND_MS		20000
+#define PM_AUTOSUSPEND_MS		5000
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
-- 
2.34.1


