Return-Path: <netdev+bounces-164566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E5A2E3E5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447CF1672B0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFB19F43A;
	Mon, 10 Feb 2025 05:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60B188915;
	Mon, 10 Feb 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167170; cv=none; b=dtrBYB9m86fPkrkt2xtGtbusZwEwIRaBD/fRmi3M8jh9Rd0jqOpZPtG8MugXmzUWe8H2lHDbl5DNI5SVfSEn21ZPaEcUj+DuDylQ9HI0J2aki44CcEbTs1gTS0WcEEPtsbUsVGqJSHL53dbLj/ZgjNUubT2nHZmVamx/LtoTNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167170; c=relaxed/simple;
	bh=MHb9TyuXgUHeuarU9Yir/7RmkDw32ubVkuACnX19mig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re9ZpbbqxcX6hzd+6ucZz6YoVUkdPjc00Xz5zTFgJEb1MF7OASjPpy9I1nsAephRJ+8FdAPhzI7n+AWlLmzrItogC3d8LVDrXQwZFfUiyhh4qa5dI5AoGks1L4xU/TfU1JdJ9hMDQeQlrmCf9Z6ELABjXV24NE7TcJ+MbUklVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yrv2Y6hstzWffR;
	Mon, 10 Feb 2025 13:56:05 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 812F21402DB;
	Mon, 10 Feb 2025 13:59:25 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
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
Subject: [PATCH v2 1/5] net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
Date: Mon, 10 Feb 2025 13:47:06 +0800
Message-ID: <20250210054710.12855-2-lihuisong@huawei.com>
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
 .../net/ethernet/aquantia/atlantic/aq_drvinfo.c    | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c b/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
index 414b2e448d59..787ea91802e7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_drvinfo.c
@@ -113,19 +113,9 @@ static const struct hwmon_ops aq_hwmon_ops = {
 	.read_string = aq_hwmon_read_string,
 };
 
-static u32 aq_hwmon_temp_config[] = {
-	HWMON_T_INPUT | HWMON_T_LABEL,
-	HWMON_T_INPUT | HWMON_T_LABEL,
-	0,
-};
-
-static const struct hwmon_channel_info aq_hwmon_temp = {
-	.type = hwmon_temp,
-	.config = aq_hwmon_temp_config,
-};
-
 static const struct hwmon_channel_info * const aq_hwmon_info[] = {
-	&aq_hwmon_temp,
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
 	NULL,
 };
 
-- 
2.22.0


