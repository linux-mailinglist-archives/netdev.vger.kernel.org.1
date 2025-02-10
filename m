Return-Path: <netdev+bounces-164567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F07A2E3E8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C809188987E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F776191F79;
	Mon, 10 Feb 2025 05:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A19188915;
	Mon, 10 Feb 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167177; cv=none; b=B0aOHhjW58WOtzIXsTEnqSeWdV6dzN5BA/iu4uV1G7hxGtLIvD+UvfrGfxa+Qfz8NG7C7+D8JufIShNrlOoxWSFk9tCpQhsGUYFOBKZfs5vM0ynvc2vWlvA5NuH2WYUR9CZ466jM2pP4RjO3yaby52t7pdWooIIk3Vup7XD/X5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167177; c=relaxed/simple;
	bh=xKblWWGxTE5azXr82EvnLeeQK5P/EFTNCVtLQSBacDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoKRdQyNjO8ZgiIa3yJ95Sa9E0tHelVOwegtxTNHDAkKICHnc3gPJ030700GNy1sda3OMCo9kP+0GMJbtyF3xy7b7HAyv6GgFP1r4dQOH/AzqddAr8OhUDjDDItnj0LtjUejdB8QiWmMRjlYGp2EBdyzOUEM/EMbBWf/HIptNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yrv28203Jz2FdHM;
	Mon, 10 Feb 2025 13:55:44 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 5990414022F;
	Mon, 10 Feb 2025 13:59:27 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH v2 4/5] net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Mon, 10 Feb 2025 13:47:09 +0800
Message-ID: <20250210054710.12855-5-lihuisong@huawei.com>
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
 drivers/net/phy/marvell10g.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 623bdb8466b8..5354c8895163 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -230,29 +230,9 @@ static const struct hwmon_ops mv3310_hwmon_ops = {
 	.read = mv3310_hwmon_read,
 };
 
-static u32 mv3310_hwmon_chip_config[] = {
-	HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
-	0,
-};
-
-static const struct hwmon_channel_info mv3310_hwmon_chip = {
-	.type = hwmon_chip,
-	.config = mv3310_hwmon_chip_config,
-};
-
-static u32 mv3310_hwmon_temp_config[] = {
-	HWMON_T_INPUT,
-	0,
-};
-
-static const struct hwmon_channel_info mv3310_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = mv3310_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const mv3310_hwmon_info[] = {
-	&mv3310_hwmon_chip,
-	&mv3310_hwmon_temp,
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
 	NULL,
 };
 
-- 
2.22.0


