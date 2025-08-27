Return-Path: <netdev+bounces-217267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AAB38201
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B53B362267
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD43019B7;
	Wed, 27 Aug 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oY/Oxe6y"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013028.outbound.protection.outlook.com [40.107.44.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EC79F2;
	Wed, 27 Aug 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296871; cv=fail; b=Nvr/0fqMopzo/umo4e+lYkQzVZtyPjysun+VX33hRRjJbN/aZU8hNdZ5mR93yMQxdPHg/cLpNpn0ztTKNwzNz2BMqGsnUDUO7TTvjhXou1fZb9HYrY5JI93zxj5FuAzZ0OWznZy6UHXzXMsl23R3DJiC8mob3c9qJ/rBQzDEy6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296871; c=relaxed/simple;
	bh=Mtgel1focaELbU8p/oHy5+d/jJUB+yCHCOfXI1Yv6sY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cqwJBxi4q5rI5AxUTzIPMXo2HcWDb79sgobmZSvtMDb0/f3RnxTMWqNc1BSAhgTjndunNFoEMgPl9pZcH97IxygaRr1OTz20K9jZDdrS50Dl/Her/dcX8OijGFm16CtyxvJtzQDu6ytdE46s0XgTo5WjBrvaHadt/okge9aq/LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oY/Oxe6y; arc=fail smtp.client-ip=40.107.44.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYrsq8E8oyclTASdc7mnV9KuJxfVYUg7FXnGpXr0J5UofnEyWAFr0LQzW0ieGNf9AfQaahYK1uNBpu7xllCRdMHRrCp8khxzJRfVc+DBGtOtLfkvNUjAviaOf09L2fGAnGKqmCKhEGTuM9eCJ3xMo4Uw94Urp5bX2Weav8aZkVFePv1UkCJ9keFP+Qg5mCgYp/2WuRlZnEwqQXgipLGKWKds3Lj8KSm2k5kHKeXwSHGzP0f+uq3JhVvrz9kQsJF9rj1oP/twC8JzEf5CWEOooAlJLKUrpT4Br2i5ebqYla26QteLzBsPMzkm1l9P+Rvf/xTNKGY0GlJ8C37miCgxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/lClswQRHMDmjd97bGu+ksI8mrkzL47203cMlCEJ2M=;
 b=AC194hfMsz+JmzI+Ou0fyWdi7NkK374X6CP0tOVWX2ja9XVldrWOx3STwUT/Bpttz6KWfjGsUzKF/FCnqDUYwbkdOCx+9//EVe5wb6SCw2RaLR/U8nKFiVM/OOSRSvs/Lfq/Bk4g4ZFMhkNfmayb78gTfLP3SUDILAWmH+OEASEgPNvbXvkbjpBZYc04b92kVlnih6VjfiyPACe0bxbeNNhtadcs9WTE0M6g+GIHAHxE+Zb2/bi+fv2ZRBrU1GUoZRz+kRbjiUgL9oL21uJa22d5Hxc8OBrEHaOk3hBV2eOdUwN6aViGBmcUoc+8/hkGRCHGY2bKonogYIPSgPWRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/lClswQRHMDmjd97bGu+ksI8mrkzL47203cMlCEJ2M=;
 b=oY/Oxe6yDiNLaei5281AsNYZiAvtqPHJlsi5kMU5mfkDp4/issWf2Hn3if0H3f4BhenBW0YwaC9QlbVyQmknkYIwjttBm0W6wF093Zkh2by5ceuV0sDvYt4vix56QeuOpP4VvBwPtuNuszh1vN1BsD6LMwN+96mqAy8wxv8sZsCrZL5KzWYcEXd28hmeiV0ZX1Pam/2TjLCZ+bUrSwy+ZdPvGcFRA1DsAjg1lLRanzfK5OAkaB3aVo4/88p60cQKJ+3tqcMPZYf+cLaFcnWGZqqNGDaq7gsRytpB5nv8WJ3Yixjm7AZ1ubkHP9sBNOeTWQaWWMbufbAcTlm13h+bYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 12:14:23 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:14:23 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:HUAWEI ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next] net: hinic: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 20:14:12 +0800
Message-Id: <20250827121413.496600-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: a903b344-4b25-4aa1-e3fa-08dde563420e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L67tCXmsL+UEJ1saQ3qqVtTLTU7l/QtBJFvM+Sw/vlFZpoiJhCax2Z2LxDAB?=
 =?us-ascii?Q?hzSKyyL+OJRVInL4nmm1S5t+RsG6fNEeELUQD2RrVEwgM9NbmRMW388XmWRS?=
 =?us-ascii?Q?kC0Kksidp8vHl1scjGLQp5HnKymQ3I9P01ltH74IOdflhP9CjzCXhfKgRiqU?=
 =?us-ascii?Q?SYxHW7dqZZQ+dWiVws7raYvZD7rOgiIuDdYM7DMNVNpt4Jdxmvz2VV50DjwD?=
 =?us-ascii?Q?/Se0NGOKRCnYyOlXBicaxdkUA1nK6hsq+iMd7tlt58fnW6YLMKgi0G2UH0XS?=
 =?us-ascii?Q?/ruc1abX9An56pUuyvTFUqAsVrYFtSii2ZPBK6r8m2xoyOtHfuw7BxyLiFsZ?=
 =?us-ascii?Q?PYKS/hyaSVq9PwIbyu5U2xmes6qzUGXQHE7ihzZqTE8/EHe41cSDUz38WLd2?=
 =?us-ascii?Q?FV84ijBBKiEmwm1LZdqptDBfO/w9uWCxNxgQrPmH8sqb9yMCdtDdS8p1enBA?=
 =?us-ascii?Q?QMwWV/nx4Bz0VwxhuuDWT6ocblECRIN4UWDywe5gA1JBcJkMXIJRTbGGoYER?=
 =?us-ascii?Q?VQw7pvEsz6shBtonVfTnRE3QB3DYybSSzh1YLEyPL/WKhnU8F1ZFUn74MDKg?=
 =?us-ascii?Q?JtySxdlDX2Z+YACALVgCsE691xc9Cc9d9Rz2l4SE3t2EU0gh8+w9XtGH+ahy?=
 =?us-ascii?Q?m9/lWB9towxjo2A4T/X0VkmQ/jndpHUdXzp6fuC6qcGZwfrNpPpSDb8rP24U?=
 =?us-ascii?Q?+tkRAVBq/LVjyuDknKCMhAdR3oRkB/29X6SH2hcznUzoPRlH6NgppTzPyG4v?=
 =?us-ascii?Q?CgaGl2YBgv4oCNg9Z8JXxaIWdk8VyiE6Ook/K53K071EuWa3E7iUoJ1qixa5?=
 =?us-ascii?Q?Y/j+7eBOLwaoxZk+VJRRQj5hlLPfBeCgR1zPrPw4odrJHUUEAozjyaud0hSm?=
 =?us-ascii?Q?WhBWV4WKaq3VheICDXub7DSv2WrKTkScl6lwfTrL3oI8hBxPuRfU62PUFOZR?=
 =?us-ascii?Q?e/m3a8kJpa++fKZ/9fVOhz2x59poGudPqlc+VT6fOPYq+V92GwnSmTN81kZl?=
 =?us-ascii?Q?yTOm11CB3iC7bYbaWEwBMgCz+nFdjUOC8DmJrAOAgd3Sf+6uSPTGNykMfLXe?=
 =?us-ascii?Q?EQhga6x5rICYIZ1ZxtYfhUhaaoTs9ZBgw7z/7An+QsTsPHOpVowvuh/HrSIa?=
 =?us-ascii?Q?p8EqfPB0wJ+1lTF2fWA6b3XFHYWVOLoeeoTUfbdhF6uAjmoo0tNP7TnM+jyJ?=
 =?us-ascii?Q?QXorr8zCVW1ZxOr4PwyHanK1cN6WuJqPKYDQwBBgsr2KtawnlKs4LxGayjaO?=
 =?us-ascii?Q?lFBVVXTyDN64Tty/32HAEVhAP4Cyqb3hcPwiFOUx3mjDX3QG6a6nEMMY39yB?=
 =?us-ascii?Q?OR2SdzJDOmMq92gmgFMnc6O2MYAk5gjAE20z3ApqonLJdBpFCyfetq0ylqis?=
 =?us-ascii?Q?HsR/9/zZOmKoHEo1WR5akRrjD4spGLtzJ86RdbkajLp0uwb5c0V4E3Zsazv8?=
 =?us-ascii?Q?DUzpIbs7Q+bAroN6KHZHvlDaK53gthQWhSMLUvqhFRWEEH867HRCFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHrTydYDcsK8dI0ZSLqe23tgo3c9NzMqWriluOyC2Z9IWSXcmsCYdWGyY68T?=
 =?us-ascii?Q?T16kWGi3RmD+2rEShjwPeOFUsEascFvX39j2lY4vWYpD4k3FKQSzHdDxWIVI?=
 =?us-ascii?Q?2GubNSlYMs9mD4QVoLPTi5J3IrjWbbteFLq4/8jFbseU4dEqoLQvesV31bCx?=
 =?us-ascii?Q?n32KYwItPnlrl4dcMfIMmhxig+/2DqbiE1WXKjQhBhvQyBx/7Xdoh8YPz2+t?=
 =?us-ascii?Q?CNoK5N+sr6AYYpKvbp+bsTSmS8DqcAtz6t3Yx1VzJG0exyXHXuO/sRBY0FUD?=
 =?us-ascii?Q?nk8ibnSihwK+LgqSzUvmDuQPuTlXBalpprMRlLwt3xxp3cA81iwNZ3VbAWOg?=
 =?us-ascii?Q?6FIEGXFIePS0vdGzYWbX0QCqkuyPJ7SgvkOiVaz5nE6+LXF+7tK4/0LTn3Zq?=
 =?us-ascii?Q?DPTsEwLfMu3q9hxR04fs2wVK0mhOyYqFWUiAz3qKAV+J5t8lOH9DF2yrFzFY?=
 =?us-ascii?Q?RyGOGqCYP4laNMbprBlj5qq+W/EuVBfU6w7lh9ojpUfPJnx3xe2oVtfgh+/O?=
 =?us-ascii?Q?XLWoZtH1P1AsOfyShzVK2av6vhnFMeWrJVezrcCFShftmBpQnZlLVSceNsLR?=
 =?us-ascii?Q?Hn0iB217I4pLkA6TdAmRJFPlXxqKVpJWjg/r5IMghThxMtlPnQ/skj3nVQ9x?=
 =?us-ascii?Q?0y4dBwP2bODYSmCSH7ITv+M5TPqGiz4LtjD2Jny2/WzccosTNQmOuQOvRa9V?=
 =?us-ascii?Q?2wIyxKVgnlf68oPhHu2u/2EEBABBXJUwsrnY5DQqT+jlM8ZzGiKYWTt0TpI7?=
 =?us-ascii?Q?8z9up6IRwnlHA/ki2YIf4mYTQ5njPz6vII1CR4MyeMgMwjMi9YdpYk7ufTF1?=
 =?us-ascii?Q?Hhfph0wUdlZIOLeDwit00agCXlrb8VPB9HutXE76UNhszxf5GOTvks+MiMrA?=
 =?us-ascii?Q?zD3gasNUzx0cJrcE32bkscGMHDkJjRYuCID38gCk9H0rxxNRHFR7VOWmKhBr?=
 =?us-ascii?Q?kjeXiCAFz2lvp0ijea4x/8FNQM0wLx6kS2Z0l5Jv9eC2h7x4nUgTycwdl4AV?=
 =?us-ascii?Q?1y6jtJtg05/i9YH1p47GjYX2eNM2+0/qvo+WZz5lb2kDAKvXzXp3Y0TmJI39?=
 =?us-ascii?Q?nOGs/FTXXvhFk9XTX4rosuZRnfprA4JP2BTRwghvo65+IGFgnzJ4kL3X+I1x?=
 =?us-ascii?Q?JGxfR6WBDS/LGNSNtDV8ysRvxvvnX/+J8ZW1kYfV+tgfN0DC/nXsaV51zyxh?=
 =?us-ascii?Q?wfk1MOinRHcZtIGJe/u1FpU1i6v6tw8qg5TAJeqUzoiqmMrUqUyRPBT+SEbr?=
 =?us-ascii?Q?0FjK005t52Ke7NwWsa59OmlpdRhfBIeE2DI4/Nwi3K8Q+vUVSikYl+1Q5jAm?=
 =?us-ascii?Q?ojghXEwRvTp5SGNdJchlA2bUUwX2x011DB0WQ9O1kb5LtHSb+tNzr+ejOgXe?=
 =?us-ascii?Q?479c3GNEPff0YkQt9/sQVbqYoQn2qRTZLWycKSgZSt2hzFQ+FwkTbfk/jywz?=
 =?us-ascii?Q?VxxJVItaayorDzVfTLtm+f61P+20dAugMrg20HqKgNIc5tZmaZhZSCIXyqMM?=
 =?us-ascii?Q?8rbg0ZSPlP9vBHg1Be1GsKweL0RKp+oxy2dWq9BvWzHb8EYIBABN19XDPeaf?=
 =?us-ascii?Q?alHZ1+hEbLVErTZcymzP6c0YCvdBia7mP8P1O72c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a903b344-4b25-4aa1-e3fa-08dde563420e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:14:23.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW6j8ossQpT81zYWwN47a17nS8f7w689AMIgEPrcnFnzRyP6+QbwmI4f34m662YXMCuBtBUu0LKlikAAjUAKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6684

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_devlink.c | 3 +--
 drivers/net/ethernet/huawei/hinic/hinic_port.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 03e42512a2d5..6655831a7dda 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -174,8 +174,7 @@ static int hinic_flash_fw(struct hinic_devlink_priv *priv, const u8 *data,
 			memset(fw_update_msg->data, 0, MAX_FW_FRAGMENT_LEN);
 
 			fw_update_msg->ctl_info.SF =
-				(section_remain_send_len == section_len) ?
-				true : false;
+				section_remain_send_len == section_len;
 			fw_update_msg->section_info.FW_section_CRC = section_crc;
 			fw_update_msg->fw_section_version = section_version;
 			fw_update_msg->ctl_info.flag = UP_TYPE_A;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 486fb0e20bef..776904345554 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -1357,7 +1357,7 @@ static bool hinic_if_sfp_absent(struct hinic_hwdev *hwdev)
 		return true;
 	}
 
-	return ((sfp_abs.abs_status == 0) ? false : true);
+	return sfp_abs.abs_status != 0;
 }
 
 int hinic_get_sfp_eeprom(struct hinic_hwdev *hwdev, u8 *data, u16 *len)
-- 
2.34.1


