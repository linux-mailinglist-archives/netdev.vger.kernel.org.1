Return-Path: <netdev+bounces-164568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB6A2E3EA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D5188A269
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF861B2182;
	Mon, 10 Feb 2025 05:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C5188596;
	Mon, 10 Feb 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167178; cv=none; b=I76W+cqDofl/MdqIxnRAY7lcNp4xt88ZhUEEN8XNpdeTYv4bXlHKJzB+qt/VngjY7tXa0Gr/2WwtJt72/YT+DkbglFPJEpzqNgHxmLtAbRxReNV7bIHAUQo/NVw1Glcq4+n/8kSsgFqWY+GyFQ7kc6bfp1GyJbcGvfv3xUta45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167178; c=relaxed/simple;
	bh=lDXRb/Tz5n+mdCPvdJI7TgU/tycGAjSob+lVDychdiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfqalpo0g4HQyYa+d2z65gbJxZpiz8aqAfvC+2Lz2SgOcZrUFV423HU07nP5iJwPmxGHePsalJ1U+QFAzPvtirMmr+jcUyq3zITQqPWP81vEO+25wOsCNIe+1bFBY83U3jRD4iN7tfoZdVP59RQCm0rE4FjYXVhjXPNsc9keKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yrv285trDz2FdHN;
	Mon, 10 Feb 2025 13:55:44 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id E26A818001B;
	Mon, 10 Feb 2025 13:59:27 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 13:59:27 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 13:59:26 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oss-drivers@corigine.com>
CC: <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<louis.peens@corigine.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<kabel@kernel.org>, <zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 5/5] net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Mon, 10 Feb 2025 13:47:10 +0800
Message-ID: <20250210054710.12855-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250210054710.12855-1-lihuisong@huawei.com>
References: <20250210054710.12855-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Use HWMON_CHANNEL_INFO macro to simplify code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/net/phy/aquantia/aquantia_hwmon.c | 32 +++++------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
index 7b3c49c3bf49..1a714b56b765 100644
--- a/drivers/net/phy/aquantia/aquantia_hwmon.c
+++ b/drivers/net/phy/aquantia/aquantia_hwmon.c
@@ -172,33 +172,13 @@ static const struct hwmon_ops aqr_hwmon_ops = {
 	.write = aqr_hwmon_write,
 };
 
-static u32 aqr_hwmon_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0,
-};
-
-static const struct hwmon_channel_info aqr_hwmon_chip = {
-	.type = hwmon_chip,
-	.config = aqr_hwmon_chip_config,
-};
-
-static u32 aqr_hwmon_temp_config[] = {
-	HWMON_T_INPUT |
-	HWMON_T_MAX | HWMON_T_MIN |
-	HWMON_T_MAX_ALARM | HWMON_T_MIN_ALARM |
-	HWMON_T_CRIT | HWMON_T_LCRIT |
-	HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM,
-	0,
-};
-
-static const struct hwmon_channel_info aqr_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = aqr_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const aqr_hwmon_info[] = {
-	&aqr_hwmon_chip,
-	&aqr_hwmon_temp,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT |
+			   HWMON_T_MAX | HWMON_T_MIN |
+			   HWMON_T_MAX_ALARM | HWMON_T_MIN_ALARM |
+			   HWMON_T_CRIT | HWMON_T_LCRIT |
+			   HWMON_T_CRIT_ALARM | HWMON_T_LCRIT_ALARM),
 	NULL,
 };
 
-- 
2.22.0


