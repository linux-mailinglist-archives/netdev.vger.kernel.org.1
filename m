Return-Path: <netdev+bounces-144812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81369C8789
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1F92897B4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3E1F8EFE;
	Thu, 14 Nov 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbi/Z2OF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51D1F80CC
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579616; cv=none; b=FXfZPDK6YVZQtL4UWz6ERna+ZOF3/PTV4aMFrKJ5QkUibQMyAAezCXPQqq+/r+VU1rw/Os88jb3h6gexdheCFY732+T9QTCTk1Fe2lm+Mm+/DBUA06CC34eNx56b0ojy6oDqnDhmpp/MFi3vE2kseSsDBC7sYh/Kg9d7PYkyv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579616; c=relaxed/simple;
	bh=vLE63ELEvQr26uuqEyP/8j3Xi0tXnpNu1bfp7UAA7xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MNutDPgteLprNCOxrclHbhTuX2QINCqqN4KLH3Hg2Fpx3K1GclexOu7QWBaY4RZuqDEB7tOGingAQK4cdkxU1v2GBI2g1LyD7aUmHe+HFjTreXA0Ob+J/M4aKcVoXmqnbii2w9piBClVjdkDwRsv+59iPSIzNf5da82EbLMQySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbi/Z2OF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c70abba48so3984845ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731579615; x=1732184415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpBSOtueICApbmp1KfKlEaeRkXCsULfiG4miYoF8lTM=;
        b=Dbi/Z2OF1OWMDz6rrLpep7np9DU//0Q//9PCDSFkjpFQhgBn7P6yBV/dKIOCDaXAvF
         cniawbjRrAdg6n2k0k0msUx/xg9QNtcfVLSL/hjlkzUgCmMv2VW97piH7eAVgGMtFG+V
         lNbFnHmRy6pyZhxSGbXFqF/lrbMofMVXvgIgm5Om5kpbIZEr8jeG3QDGe9Iu2W9Pj8Ok
         4oKDWuXoZAa9qBJqWSkMtIbObVKB5U+TupnJNkkIUtogNLRbSGv+XuhlPMa8Ah3LTkdX
         cmwtAkoX2ukFGGwG9cYVFMpXDofkdTiNah45OZy6dbRlM7c5R13ZNihhQ2j1VcVts7Ub
         nP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579615; x=1732184415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpBSOtueICApbmp1KfKlEaeRkXCsULfiG4miYoF8lTM=;
        b=t5nN9q8aELmTbISKhd/CAOx5bQXCp8Gb77iVrtrK9TfL01068ht2sjOjvmZLbjDcYe
         r19qzMSkSr96Z4km9+DNUUHeg6wWRNw1rsQq0W3tiUe0Cyh8s/fX5oU/72llzE+gzp2L
         cFo1qBIP67jm2vcKHlolEp8tdKeDxnxo7yTjxLUa0fyeDLEDfYO8/EQ7s+af5sRudBHf
         eRkU9SFSWxQ+qTowadkr94bRzw1bEcXi2yXuXkFxPW5vwc2tv+1QpLRTJEeMAwRCIx26
         Sbv0fYIEsalG5Qc3oXetaBuoE8nKkkgwDMdbFzFH+WJyFYI3SjJAvQYEoWDYGMPv0KkL
         yYyw==
X-Gm-Message-State: AOJu0Ywv1LqHiIpUUuzNV6OwDWXIgFkLcnSFnXU+2ncYcXBZbF5vma6G
	a02qF7+KtTTXrMLBck5lxP3FeBsxNHtTBuphv3Buh63T0z7wuqoFW5+3m+ZC
X-Google-Smtp-Source: AGHT+IGmgU+mBxzLc6QNDijGpeoZEQ3ldaKJ/xxCJolxNrmQLA624fTfj+KnuVFiMsFaBXvHB17Omg==
X-Received: by 2002:a17:902:c950:b0:20c:93c2:9175 with SMTP id d9443c01a7336-211c502b5f7mr20482795ad.30.1731579614613;
        Thu, 14 Nov 2024 02:20:14 -0800 (PST)
Received: from localhost ([2402:7500:56b:5617:bc95:bb12:95c0:c1f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c4a55dsm7553545ad.69.2024.11.14.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:20:14 -0800 (PST)
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
Subject: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
Date: Thu, 14 Nov 2024 18:20:02 +0800
Message-Id: <20241114102002.481081-1-wojackbb@gmail.com>
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

We tested Fibocom FM350 and our products using the t7xx and they all
benefited from this.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
V2:
 * supplementary commit information
---
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


