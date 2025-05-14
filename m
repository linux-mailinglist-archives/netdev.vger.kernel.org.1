Return-Path: <netdev+bounces-190474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06982AB6E3B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831271BA22E5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7561AA1DA;
	Wed, 14 May 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWxnClJ6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA317A2ED
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233417; cv=fail; b=sXeZ88iUbaozR9AQTPtiI2p5gC3ecEAg6DOB8v2bqVwduMfqWpOeR1Zd/RyJm6RHAldCi1g72EvEHMKWFA9MWGBO4WPcsVIMDOLf5eRsmzh7IbgqADFCpwCv1zvYGjD+YlQYvmQLsWVux4NXmhjfcVfhwpfPohthisMukwzDxM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233417; c=relaxed/simple;
	bh=chSBqqH2CUOxGMeQ96E0xc5046zaFEmG2kyDP4/kR6E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VuCWMaG1afSIDd0V+Frzq/KuQNk4zx1KOFtBvpm/5AHhwcqQWPwPKVRqCmmb0GCQlRXY+Qh70aeexXp/VIsx2MMG2/cHLw9VQ1ZAJc3MYAGpfu/lsmll+C404B6zvSLNjnjDVE0NAQWWtjIqxclxQiCpVMIBeOWS11K8UfYzlfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWxnClJ6; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTq3KXX9wcH6dw4YDrqb5r4noVyGrNycOtDkYD5TmSTIcHEn2kIccKtgksp1ut9sFMLMRVq92aySDL9nWlwc1dN9Jr9y/L4MqVhLydNWpFMvGReBcUhrY5t3XDkJv39YUNDoTI0X8ZA5ZYIAut3L89ILrZ9p02bJ8dPiAhtSZLtOvfLQA/qj0aV9S/DkK9vGgg0Jhv0bGFcw0io7eepP8dE1w8neA7K5PJc7ycqjXrl6nHhpB0jZdFeNnfWnVjnX1wQbc1jbjHucBlL+vnD7oA2CU09cGqjKG9l1KSQV0s3RS8t7VgODslC0rZbP28cpr097x8E/OlJ0hS5GvuhSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxU8RiZv1nsUE2DY1fO5NNar3rY2hY6ic18URygcO84=;
 b=Q3iaN8VfyjM3Et5XdUK5vlhFZic3v6vZWqWZtyMXOxOVoi8E/qm57JYORbwulKJ1pc8R8Itzlp6FrpNzmzPQafPH6g+Z6wl0GDw5FUDUqPSRlw1bYng8Rc5ejLU9k0QYSv3OeqB9Bubg5Efs3emQvg3s7YaFaUuBGQfl/+EZRZwVN3/B+qvRSGJnx9RcJYT3hz0tyVh+9mrYDHQikQlGR5hM0q0Kwg54LfWS5ROJDZivSWOj6KiuTKitaSKY6KBsDiTxO09UTC3hZbJQWyxKa/4IYAOe7ZaF6hAaiyLCJIr+UpdiX2cv8uTldfrheAwj2cc4C9+YN/w5Ns6B7C1XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxU8RiZv1nsUE2DY1fO5NNar3rY2hY6ic18URygcO84=;
 b=BWxnClJ6SwMKYRrwCCBoRPAjh3aRczyd2EW/qahnfo8IiYXFbv9Ro5hIUw+R0dmjDFFYJ02+f5fYFaTDTBGmw5pcJ+zJ/xa7pMinL/frbnn8FvCP7aNiO58zirCDU0OzY6yy+147vF8oFU0R70OwlW2hYLGY25z+BCB6sPnb1I7xC8E73fj92NigN5glcqWt/OGi7oCaHd7Chq91xSITfXSVlF1EGRFtom5mWssAKRz8YAexex3i4FZY2kj3tekIMUT4rrcGbLc/VcqQOlMZX+gz1Cx0FoCG0d2GoS8rau7OrN/jN+YMmKOJuHcz/66ULkOaenj21C3GGO3vnH1r8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 14:36:51 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8722.021; Wed, 14 May 2025
 14:36:51 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>
Subject: [PATCH] ptp: Add sysfs attribute to show clock is safe to open RO
Date: Wed, 14 May 2025 17:36:21 +0300
Message-ID: <20250514143622.4104588-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5087ca-05c6-485d-0250-08dd92f4c3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHPRjOetrajKbY+4xCLHVZbuThBO6Nb6hPP33KhqodYVjdfPLEL2ONNUsGim?=
 =?us-ascii?Q?5bEgTW/WJRcnyvr5SjQgCZCyZ2IICbkuGxgHMgOD0dFYJ2HqVc1IhfrfFSyu?=
 =?us-ascii?Q?gZtPA5IaVgH/20uG0AZ8MFY83Zte005VAgjw4WFNZSV8sYSFMV/xPOdVHDhX?=
 =?us-ascii?Q?IaG1LvmsO1WxTv/oqf6Q1mb9ngRdmdQ7+wpZPB9DcdDfGoo1Ewinj+t5uf6e?=
 =?us-ascii?Q?J39H8o+FWzs8Hh9FWthLeapG4rQwJs1U7Mjw80X2wklxX9qmq1Hsqv5TRx0m?=
 =?us-ascii?Q?w8dMD6i2RakjahnHKfPJ9GKVGPZccpw4mjMGFodfd92VmxPsscpG0RDg6CJa?=
 =?us-ascii?Q?FVw066jNwo4uKFzIhNonJNEaXBwuMEL/n7VV+G45ePSiweFAbDBNO7uCI84C?=
 =?us-ascii?Q?J/g92eNP4OMx7JMI64dokC8nYJFsaXnVxmoQeCSFUVq+W9P1qk7v7k9NKBq9?=
 =?us-ascii?Q?geUlHMnPKX3rbnHD21mRQ0KFe9/wnOo2rirrbujr3f0YthGACPk/1Mm89AwX?=
 =?us-ascii?Q?FHkaG0OluAC/ZDYrgVaWHa0v1uT8B5n8uy85/18Rdy7rIi/czP/vCkVra6ve?=
 =?us-ascii?Q?0eaDlCfYorDCh/R9KFO20OTSBCtDpJQcJx0uJmTtjwnzeUQ4zKKSNgQK4G0A?=
 =?us-ascii?Q?Dm85q5OC8DQtxy++rBu6JKIh6zAmvNkald9vzF2TXhq/w4vvtMIPlrVvofYJ?=
 =?us-ascii?Q?ZSoge5wx3hNIIer/SxA3KRvg1u4+Pwpc0hWJXw1n2JXTNk8u8dJQfCikX6Hi?=
 =?us-ascii?Q?PyApHEHZfQWRgY+OEAWd06XZKPIlUhIuuNJbtwJN/v9hhS3fR5piInGNpUCj?=
 =?us-ascii?Q?mPWsVBaX1TPNuu+b3xpuT0TMHo3QUzPmoJ8M1+Vp7YAPTMOUZvT35dzXAinW?=
 =?us-ascii?Q?/5MhagVA0uDC0QxePkQ2NltNPPfs8LQU2zAL9a51xWKjvCtBQU+gadMFZ+/4?=
 =?us-ascii?Q?xwkG9/QFUsBQpe4yCJ27iqwILP9izR1ip2wR3TgjCVJeCgfxkLCov1RRn5zQ?=
 =?us-ascii?Q?pOz78cq01PYvH3BLuRrYC9yun2+mvsjt0J+1lvLaJao4wWrQlfkXeW6uO3vn?=
 =?us-ascii?Q?GLK9/Mrw6mACxQNcR6WWUGjuJdaoBDEU2FUW9sW3NUBbYlzazFlI2cyzwo1y?=
 =?us-ascii?Q?VStbVUktT8xoUWd0N38SANTSIHQoHgJ7Jo84i27xkEGTIOX0sfbQGMh5BWoy?=
 =?us-ascii?Q?nLqmeEoPQn3ZsVOMeSwvdVLYzs+GOlPkXXsvC2EyDJfcQ8ABxF9qBzBW2lFC?=
 =?us-ascii?Q?eFhOOCCCYQpj/nvfsVzvKJls/gzbD9k9r4S8ycyvU7G5sYQL45RbATmRm61l?=
 =?us-ascii?Q?fjncihn25wKxdiZbtfNYwFhaPWtORTXgk99ehlgP2t/xT91egOcpoCbdN929?=
 =?us-ascii?Q?Cr/wg5pIGIFCxesIYUWdgfOI+e97FLSkaLsdzIdMhuj3ZXBft6mwpaNARTZF?=
 =?us-ascii?Q?xM630h/TxF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3B0Vhi+B5tuP2i7wgR6HeWDRNg8G/ET6b+H8bezL4vnqy7W4ecfZSGaL2Kg2?=
 =?us-ascii?Q?gYKU37TbNGIaH/lIXHrUuq2dIgd02xp6eeKHmszOu5vPd/iLu7ZZeukml4ll?=
 =?us-ascii?Q?sXUH8yDB/bZXCVFLKRoZl0MRXILShQYy0hxns+J3M0V/tP+Y9k81/UBYZkDZ?=
 =?us-ascii?Q?2/CxnooP0Q7GY0QVsOPzDEXkFPf8/j3aD6rWYmmjzYsFBHRlmCoFoCR4/DPv?=
 =?us-ascii?Q?4JejBBWBTegIBgsr2U2VpYawyJYXfwI8O5i/p88XeTVxb4K5Q3WxpR80e8t2?=
 =?us-ascii?Q?WZBP8FEK5bpNhkqMy5DpyeeMO+xGpVYF68yzZl4Cu9Qb/XNXGmyVGy4TzsAu?=
 =?us-ascii?Q?wQchgWsKKcWsX3P8RrYvQ402KD39bAFGeQXZM5rIWiJCbyD04j+cUGbLSGi2?=
 =?us-ascii?Q?QKZJ6rEKSRlQ4yYFKZOo17sh06FECM5BlHCpa2l+B7eE5SIjfB2J2VOBK1K9?=
 =?us-ascii?Q?YU+0MND6Z73RJFlCYtZGtpWoL71/lHDNXe4mvpBG1InxHAG0x5y+EEqH2QDc?=
 =?us-ascii?Q?ub6/hs22uyksArHq5MkMekvyKJjFM12ONn2VMcVH0tkYS9Mcl/7iItg0QKo+?=
 =?us-ascii?Q?J2qTBRqeDdzVZUTsQoSiU4NTrc5hcSSEtwjKfDqcg5VvYHUuxpXwgGaDUMkX?=
 =?us-ascii?Q?taPhuuaSwUMa8cajQBn0PLcgtrnbipGKrcOae8S/EScP4m23CUonNs1XCrG9?=
 =?us-ascii?Q?U5raS39CA2UM+8B4MSvlQQHIp6KozI7ttoc0DvcGfFIDm1tz6LUyxhhGZC8i?=
 =?us-ascii?Q?yQ8og6b4B48+jj+KGbLuejZf5WfwknUFgCMv7AsNon+zKcZhRDoYxW+lC8hw?=
 =?us-ascii?Q?M+KNebkiWrRShw81OEWJvyGL98cDSExRFFTjHRqJV9QDn/L3KVn2MdaKreei?=
 =?us-ascii?Q?CD0gCYCArRCoHybHE72fGIhSWjrE41+7YU3XiH/L2ohZkKZ27JhJJ/ojMBG9?=
 =?us-ascii?Q?Zs/+DGEHPkydyO5wZL4cEmsisYop/S4VU8N5kSt5R6moFuLGXr4zixP1WumQ?=
 =?us-ascii?Q?PwNxmOZufaAkbdK51tSjzIUZa6q3t+b6FlbqMPrzTHUf+LqCKp60sSEQMXds?=
 =?us-ascii?Q?C1W0Zr91EYHfJRN2TtQbr89drngryNzzr+GAEY+Td/gJ6WQZfqC8K4vLASRL?=
 =?us-ascii?Q?U04SIDGKzmHYJhTjdAVlQHgle8a9DflB7YY1xia/GrS/IMLU5tcx6TB4x6Fw?=
 =?us-ascii?Q?Rn1DT/B09xTc516Gm7x71/hTTEXk1jDNJTUQnC/W9vBlsj7BRkkcmXasM81w?=
 =?us-ascii?Q?0kVDhogHNegq3dXJ6LrGDERmXh64X3ytGiFQMVhL2bF0aF22UhaM5cn6eyjI?=
 =?us-ascii?Q?lioteixPXnbmX+RYwkgfsFe+OzPC0XB5ccnbeAlurVXFkaH/sazZZvVOLuZu?=
 =?us-ascii?Q?7TPJUmc6jI6AjphId9TV3T5m3bmxqoQRSuuHq/dtWd7zYymAHXy0cu0+uOWT?=
 =?us-ascii?Q?V6tlJAzJmq+AAAx/vC3gzOjmDVFQlivggTTFrGQjA5ztrTl3Vhj5bptVITIV?=
 =?us-ascii?Q?DqZo2YTVRmFOwKiiGEIc9g9X/0ETwZ9kRANgocTWKarE2Br7plu7xQgr4NTq?=
 =?us-ascii?Q?/WarCiJABD8zzOhEDcOvemzbRmGiYVFktpakYFZn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5087ca-05c6-485d-0250-08dd92f4c3a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 14:36:51.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIHWy5tUORoyVWTLlYVGVF6bE9i5QLsuo/FcFiDgjAx8pzcaqJbmltwEWgA33bWO0Gi8M0cARIMrIHF/c+4zbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

Recent patches introduced in 6.15 implement permissions checks for PTP
clocks. Prior to those, a process with readonly access could modify the
state of PTP devices, in particular the generation and consumption of
PPS signals.

Userspace (e.g. udev) managing the ownership and permissions of device
nodes lacks information as to whether kernel implements the necessary
security checks and whether it is safe to expose readonly access to
PTP devices to unprivileged users. Kernel version checks are cumbersome
and prone to failure, especially if backports are considered [1].

Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
static string.

[1] https://github.com/systemd/systemd/pull/37302#issuecomment-2850510329
---
 drivers/ptp/ptp_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd95..763fc54cf267 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -28,6 +28,8 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_phase_adjustment);
 
+static DEVICE_STRING_ATTR_RO(ro_safe, 0444, "1\n");
+
 #define PTP_SHOW_INT(name, var)						\
 static ssize_t var##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *page)	\
@@ -320,6 +322,7 @@ static DEVICE_ATTR_RW(max_vclocks);
 
 static struct attribute *ptp_attrs[] = {
 	&dev_attr_clock_name.attr,
+	&dev_attr_ro_safe.attr.attr,
 
 	&dev_attr_max_adjustment.attr,
 	&dev_attr_max_phase_adjustment.attr,
-- 
2.43.5


