Return-Path: <netdev+bounces-164565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFDA2E3E4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944DF1888C28
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2219CD01;
	Mon, 10 Feb 2025 05:59:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63B2F2E;
	Mon, 10 Feb 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167170; cv=none; b=cASsrYriFL0YPUXTj9XEX8cjRnDijInWweIU+dks9//tYMskIGmWgeN2h2ohYPrDjp70Ea78N5g/Il7z9Ol4SfDnIWFkOO116iWxsi6ZT8QvYh37JYG+xH+vByVTu2Z51uhnK7FWL15MMow9PCFyTRXBUwWtgGzVITvh+oTdfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167170; c=relaxed/simple;
	bh=mWX/fp1URit59PoIjt60VZfGFkJQZLYn2jvxHT7rK+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7dtXnQpdw9khzzGo+SC9GAnVyC1WAgKMm6PmUp/wNPsCxHl5RVoFnEJmEyHRTwpLWygWb2OWrmAdQvljLmYT7MKy5GKuU4Ur0eCtxbim7AKT4Q2eXLL8o8bPEbhhRFTw3D1BoEp7CT+7oD+m4xdBbNOLuGxT1o+S/tV8gMTSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yrv1K4fxSz11Px7;
	Mon, 10 Feb 2025 13:55:01 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B3991402DB;
	Mon, 10 Feb 2025 13:59:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 13:59:25 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 13:59:24 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oss-drivers@corigine.com>
CC: <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<louis.peens@corigine.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<kabel@kernel.org>, <zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/5] net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Mon, 10 Feb 2025 13:47:07 +0800
Message-ID: <20250210054710.12855-3-lihuisong@huawei.com>
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
 .../net/ethernet/netronome/nfp/nfp_hwmon.c    | 40 +++----------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c b/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
index 0d6c59d6d4ae..ea6a288c0d5e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_hwmon.c
@@ -83,42 +83,12 @@ nfp_hwmon_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
 	return 0;
 }
 
-static u32 nfp_chip_config[] = {
-	HWMON_C_REGISTER_TZ,
-	0
-};
-
-static const struct hwmon_channel_info nfp_chip = {
-	.type = hwmon_chip,
-	.config = nfp_chip_config,
-};
-
-static u32 nfp_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT,
-	0
-};
-
-static const struct hwmon_channel_info nfp_temp = {
-	.type = hwmon_temp,
-	.config = nfp_temp_config,
-};
-
-static u32 nfp_power_config[] = {
-	HWMON_P_INPUT | HWMON_P_MAX,
-	HWMON_P_INPUT,
-	HWMON_P_INPUT,
-	0
-};
-
-static const struct hwmon_channel_info nfp_power = {
-	.type = hwmon_power,
-	.config = nfp_power_config,
-};
-
 static const struct hwmon_channel_info * const nfp_hwmon_info[] = {
-	&nfp_chip,
-	&nfp_temp,
-	&nfp_power,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_MAX,
+			   HWMON_P_INPUT,
+			   HWMON_P_INPUT),
 	NULL
 };
 
-- 
2.22.0


