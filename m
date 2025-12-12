Return-Path: <netdev+bounces-244534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB12CB99D7
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012BB306800F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202E22F74D;
	Fri, 12 Dec 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LuGjNnfo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LuGjNnfo"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839D191F98;
	Fri, 12 Dec 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765566121; cv=fail; b=E2fAtN+vmvuO+VqurevJJ7EOpJTT27iNEFBBKDtjZ18CdUBy0gAlQOxJNPeMaiSpCHPh3RtPcZupNX/SF9AWEdsbhwfc9vDhbHDZkm+4/1yeN/xA7ApeafBT4QG8kO0imYnNZwOM7mpv+R4uB/ZqxR3iht8JePj/r4LKOBdUYC8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765566121; c=relaxed/simple;
	bh=pAJTH4iowI603ZCk5akFXKtUZvJy4S7aEihHqQg+ApE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5ZgXHzbRG/ujYZshSubTBGrBvANXCgqrJFqA9hC8bmykyDRRqj09c/wSZMNU6TyPb10Roj81OlHV2c2NjjfVSAsiYXyBF5VoYUKPDglERR11h2y3bwOb0bs7LRk5v7i06LYw2vt8aKZncN0BcSGO+HX8q6YhcNWCWv5LaZ8wdA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LuGjNnfo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LuGjNnfo; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xIpm9GRNnVXXnmLQxVesJ2sGRYjAn7Lkc0utrlWu+WJDbGe2r2RUL7pxd1xGGIzPzAUuZyrOf4XgDe4q+/ft4bkyxUpOJ7fVVsdkPXD9R1zzXvAqsliwdGEyUVCIkk4Xju0mmvS0Ownqzxr9FBFccbOX6JWQG8asIMWDBDyXUUN0SbeHpkgucilLFi2oZy6XoBSkKshuBz9egmJ23Z9W+Y7Ki8YYYAo5biws29i6ZTFAq/lTAGJ4pi3NuRX//begJlPcYC2fSpzqs68XgmBiLtwYhT0mN2DTnsoIS/4M9b8gwatYt6Um/OGmTopSH7Xdjgn3Ky97PjZNntDTx6ahng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hu90L6XVF7KGzrtegiHJNnkeeY0PDgQj0ISIhLykio=;
 b=mJyJ38tfRXl5C9YrZE+b+5xe389gMhl75PnKkO/PdsIS3zlOm50+Dioa9fUVNdpOcl+fU3/5LH2YF7vAkVjBNoXJEwIzZNGSwdIScaxRymQb3lsZnO6D7chqQOjUFvjo3zHDEHDyPb75n7upiRSYnLzkLYO2G9E9ZFkQcRLOF2E07H/Gt/vCk5Rj4FCOTKs9FQfT39Fk9tZfbNwyqfv87dukucsro2Zt64NAASbP/SLulYH2cH+58wgZlgok8cFwhqIL7ylSUdy81fpLe9qrH2AGVhfYUluAvedIdeYFwytdqr+ZiueTOngFVWuY5NDBHsoXQH8b8KLQhFfSmTl5BQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=fluxnic.net smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hu90L6XVF7KGzrtegiHJNnkeeY0PDgQj0ISIhLykio=;
 b=LuGjNnfoAtBeJ/QEjQBugbhagIVpsgPmRqblSXACRDzkpCVktr35qOqFxXCLkz/BWyGL7YCDH4pYwDkM8UOk8+u/KtBRI00sAFMpqkVWYoKHm/yF+gK09hvlG6wRyWMr+HCBTdeoaiTr+Zwz9zP81HW16sE18ioxmRgyIi6Yz1A=
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by DB9PR08MB8228.eurprd08.prod.outlook.com
 (2603:10a6:10:37f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 19:01:50 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::b9) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Fri,
 12 Dec 2025 19:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Fri, 12 Dec 2025 19:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsnBaAtENVwYXpwqr4bXjJeSmdMhHUKw8ICZNi/bNwbW+yqLs9+W44XeEZ1IBiqHZaTnMY4KjUGzz3MDVv5MVS9GNjIBcaaEkt0ud8so/JzGtq464T7WmVnT1rd0Z/fA28o0bRvh/VkzlXaBIPBoOULkvvwOc0NJNzmq3fJwA19z30aI8qRqF02EL1ZSUyY9WWyQYBXaA/lpHStKEHxAzqGu4fTDHVGZumkSV+fDdl3An738HX0nndm6cMAi0wvDCxz+uY2h27xEdMR0GUJvMwTize3c7CVeNB5c3LyNiw8puzrcDVLlW2aTL5iVPeZc8G1MLKqL0wH67Xzg7F/gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hu90L6XVF7KGzrtegiHJNnkeeY0PDgQj0ISIhLykio=;
 b=OkY79mrZBigOBGTFghzVRKEptDMpvsnG5tTvXcKZ8HiNhSULve/uZwRRbHuJmFz2tnM8cokwSoT96QJgnXWdrf43JRAhoh3eH9QAgd2PczrhzRCGeI/zok3WEChvStrYhzbFxduVGdQy5vg3cLHnkj6LH6dDjDEuqQYl9BCZgLSQTzorJl5/4F6lAh1ZCPo9hgI+0klm8O9NQojWrgccT1Nan59HiudXBtZdXb83gkuRDtuKwmPSQjgzyAOs9vi1FFFSgtwE9WOYW4nqR9Cw/dOAseIA6eiPulTawxcMwVi3C25deR47poSfpC/7Olj8E2ZUvTxwsapphVy6IgisnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hu90L6XVF7KGzrtegiHJNnkeeY0PDgQj0ISIhLykio=;
 b=LuGjNnfoAtBeJ/QEjQBugbhagIVpsgPmRqblSXACRDzkpCVktr35qOqFxXCLkz/BWyGL7YCDH4pYwDkM8UOk8+u/KtBRI00sAFMpqkVWYoKHm/yF+gK09hvlG6wRyWMr+HCBTdeoaiTr+Zwz9zP81HW16sE18ioxmRgyIi6Yz1A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 19:00:45 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 19:00:45 +0000
Date: Fri, 12 Dec 2025 19:00:41 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: nico@fluxnic.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	dongdong.deng@windriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] smc91x: fix broken irq-context in PREEMPT_RT
Message-ID: <aTxmWSejm6yH3C7h@e129823.arm.com>
References: <20251212185818.2209573-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212185818.2209573-1-yeoreum.yun@arm.com>
X-ClientProxiedBy: LO4P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAVPR08MB9674:EE_|DU2PEPF00028D0B:EE_|DB9PR08MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a518833-90b8-4ce3-94fb-08de39b0e72e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iaCWnc9yXUIFsPDU+QoTDBlpPiuBWMm1gw6pY8EiWTiWDwxp2Das6Q3d6hoM?=
 =?us-ascii?Q?zqBdTNvT8rX5osNUH6wJIrciUTh3x3EaAd7VGRxPnegzYdQ1XAQTa9LcOSZl?=
 =?us-ascii?Q?qGju9LKv3KxTn+YqSEfQ07VxQr08jt3dxA5Pl7wntmH+YrCiUZ3T5H5GqnCB?=
 =?us-ascii?Q?hO32urprPC+oOWR+0pY3UrkBGw90U312gNWNw62O6NnHfmMxf4bAqMkwPFjt?=
 =?us-ascii?Q?M/2k4WwDprL5st6ptf1C02Pu+xEJzsOKLXm4ifCkAI3c81kgxd/o29QYIPIn?=
 =?us-ascii?Q?IH0956+j7WGg1R3u4zrC1TsNZG1IfVITU91N/LsuwseF7o66gWjn6ZvOo8fo?=
 =?us-ascii?Q?VNZwEW3nmnuvP+eNl3q45K9E7H4CJIwEBS3zSt46ow/MKXnmBNeq0e+aJ8tG?=
 =?us-ascii?Q?JjnpDdazsQ3GhzBRw8JSP1ZYNC4UVL2FN/LEYM2z4uRboVw5DYZZLz2bmh2k?=
 =?us-ascii?Q?d0HfwsaRSEdmgXl4OrEhIv+HxUdyVRh/n/xQNQjxCqJv/LN7Sf4OirhI4OuL?=
 =?us-ascii?Q?j3AACisG/Ukq0s2bs86jhA1hzWelTYIW/rXclwZKiF2nhDTvo+u6bw3isMHm?=
 =?us-ascii?Q?0eBYlnfAID40mv1jQP6tAdohwyVepcoa8HMJ/uW//NJPvjB+hN8TpoDneAo1?=
 =?us-ascii?Q?fYK+t/LSA4rgzDkxHCVYb3jwAPnxf/pe6PiRhROZU0srtp06nE1kCdPlZ5Ej?=
 =?us-ascii?Q?Hg722iqXmAkXV1hrc8Tw7xAGkMDjJgptuu+BvLUqjJRlb/s/kDirqOgipy3z?=
 =?us-ascii?Q?ZOUz2CODJR/6uZqYj0sUkNXAOmX4FH25WI54YScNf5I8hOUq7L7pOv2lGl9R?=
 =?us-ascii?Q?3CwCfG5vZ+qj5B487JbnHft9MqDf9Ngt8OwiCSS3x/tQpx2i/iSJ854qGoVl?=
 =?us-ascii?Q?mEcxbPObh2x2U8JKrBlz9DTc3qNvB1uUE+OtIG4XqKKYvGv9CzrjX0gyZSN7?=
 =?us-ascii?Q?fQES7D8FUoVyE0Gbxf2OPT3GB/wCCfJcL0g4oaCn/P3QJpPNaOQchFLtSGCS?=
 =?us-ascii?Q?OXD7tlYGnFmS6vDdU7h9205X29c/YYOT1vDfcC53n+iUsYfyql1pYDPHfsw1?=
 =?us-ascii?Q?y+bF7O0+1JdZsUKozRAVL3FXyMsYwSMKWG5L6OKmqMV5/NDQ157v97cthc2C?=
 =?us-ascii?Q?Ja+8zifDhndtPNBQEMO+hYaBGyLrnLsbFU1kvNCCfNpGaPVnHtjlX+2Dlsqp?=
 =?us-ascii?Q?N7f/mupXPvYCti9FjdzExWcbiZOtXZkCTgZRRH8K420Dec3jy5mzn/XqRfid?=
 =?us-ascii?Q?D39gZQMbKa9l+j4O4W230O+biaBvi+R66SqU99/KUaX8DW7zMCO81P87AFXQ?=
 =?us-ascii?Q?Erq6yn8Lf8KHpX0MYy+ej/3H0vsTsNSf5oswUDIguQuPpxgJlQpvZPih7ZxO?=
 =?us-ascii?Q?7H+OqofwRcplysgkjIsPOfq/ees0a3gzztc+RKdNZZs0zGvkpJNsN5NenxTS?=
 =?us-ascii?Q?+1XVLhI+vd/9do6sDQQBapNKrsBZscr/rKL9fKJnW2I/+MzieAOtBS4HeJM1?=
 =?us-ascii?Q?7qd8GdMPDGSx+uTa6/pnTeleOeNgvpMhxEnt?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9674
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71e57425-cf82-4e3c-d76e-08de39b0c101
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|14060799003|7416014|376014|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNJmsQ2T/Pq++p0uffpWjDm+RPC6hqqxLifi3EFoJ58A138r60dQegJmXMel?=
 =?us-ascii?Q?SK/h0rTZgd7PI95JyeEwBoV4s5RtdyCnDeqpU4Se4Du42vaSInb91p+29EVl?=
 =?us-ascii?Q?MNlZIdNDvzJXimHrpRukYDwJi6jslLHMcoNtA89PilwznW9BKvyK7GX7jc09?=
 =?us-ascii?Q?v1RYIhP/Wo2pQWrqcIiWGU5afNzBWnsigcSvUNm5WuHWE0COj6KI5m82Yfi3?=
 =?us-ascii?Q?D0l3p2OzzWJ0UTE8dsDWlBHodWqFwppwYKCTtAFOp52OJ22g2jQe84yPXym/?=
 =?us-ascii?Q?WS21YwBCfKCoT7+h1H3ZpjoCT5YZERZqZ0tsAtqTmpYhhg5tTR3DeVSsoxnY?=
 =?us-ascii?Q?P+fHdyXLVXnQZWzA07riDELMT0nCEATGDphwaL4pXPxVAhxWJNxb7OL4bFja?=
 =?us-ascii?Q?7o3RmW4qXCxH55cnFcb121/wKM7UHr7UYws3YPIhDlKfvsg1ohtnZ9OLc0qo?=
 =?us-ascii?Q?qNPTTlJ8UKwuYRhq1SxMrO/HfXGo29Y/QfAvnVl9nV63d2KGb86il2bYubMC?=
 =?us-ascii?Q?d7mFffYX9W5LKYoVJOuQlgZTDcjK/pIsOaCCJJCYz0bDgDC3pYdfxvQrRbRV?=
 =?us-ascii?Q?2qiHWfla/f9mEAbs4Uc/Ax1Za5+dWoR3WeYL6QjDOdEBW3ehGWGD+aEMt4AT?=
 =?us-ascii?Q?vG3ECSlD/88k8UOCc3rNp+Hhd+oV/DuomS8vgS9yRsHY87UwAj74i+hA0W4/?=
 =?us-ascii?Q?h0M0YMeypoRrJgMtWImCGyBQQ41Qdj3JwkKcjmDYS0PtklebhxykF9jkuNlX?=
 =?us-ascii?Q?J5A9hVMdHGIQB5Wu9EnGiKI7icG+GS7jV6hiJUwbUQIJmrPvlpIrxE8mXg/r?=
 =?us-ascii?Q?YmNF7ueKe0RYEgz7t3a/T3gKcvASkNsYHH1NRRVnnpNmgG9YRg0UQY7flb4y?=
 =?us-ascii?Q?9WH77XRrQNuPWvQHpTF21Jwrvb0PjCScGKdUD1+uMT2dzwlBPrqhzHkij0Xc?=
 =?us-ascii?Q?uiIk1/dc9OtQr40Vp4R9eOWtiF//Vp/uDehy/lkHNsQrGeH+gwpLaPRX2jqk?=
 =?us-ascii?Q?AFSU99gVHWgcRYGzDheJIYitISnlbEVbCJl8yoTwAlzxWSD1s9XcuOOCqsdE?=
 =?us-ascii?Q?XPzviQKh0095AG2peANoTT1VL3rslVcEvld6K+yOm7di/cbCDjqDb82QQYYy?=
 =?us-ascii?Q?z2IUH5q0Rp9sO03r8xcaVtDe3LnGEovqerkU2zhBC/GDLbZyrIS2C+hzfH0r?=
 =?us-ascii?Q?XwAX3vPXC0XINx5FvJnQd3XYvtEILpkXL/pfiEmUk+aisTai1eTsOPvrIwen?=
 =?us-ascii?Q?gNWOSHvfCUsoaqe0/zGblm5uX4Nf7A2u786CGJ/pP+pohqLVYNixaySC+mlG?=
 =?us-ascii?Q?Nw8jwwq3M1bpMP4D2XkilINQBd8ZJOsy7KdLqvxYjhtl2zxmPWrRNbtosJLm?=
 =?us-ascii?Q?h8vvFPXVn1QaWu+DVhTEKv/P0eTuFYiAVPuy5UuSZ8GjXYe6HmrgXEMZWEqX?=
 =?us-ascii?Q?41Da9W3IQhZbYtZVLXYBPpHuw/mL/8VLEzbykzvySunjzQVDiCmDG9yC+qzx?=
 =?us-ascii?Q?EVKTiqyW/pV2vr0wXHA5fh6mTYteabOZEsn5Uayl9cbgUZXEbvu3FlC60QhH?=
 =?us-ascii?Q?BOcVOrn5lAvyqyObwE31rHhMGoNyvsa5rnTyhw5y?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(14060799003)(7416014)(376014)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 19:01:48.7779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a518833-90b8-4ce3-94fb-08de39b0e72e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8228

> When smc91x.c is built with PREEMPT_RT, the following splat occurs
> in arm FVP_RevC:
>
> [   13.055000] smc91x LNRO0003:00 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> [   13.062137] BUG: workqueue leaked atomic, lock or RCU: kworker/2:1[106]
> [   13.062137]      preempt=0x00000000 lock=0->0 RCU=0->1 workfn=mld_ifc_work
> [   13.062266] C
> ** replaying previous printk message **
> [   13.062266] CPU: 2 UID: 0 PID: 106 Comm: kworker/2:1 Not tainted 6.18.0-dirty #179 PREEMPT_{RT,(full)}
> [   13.062353] Hardware name:  , BIOS
> [   13.062382] Workqueue: mld mld_ifc_work
> [   13.062469] Call trace:
> [   13.062494]  show_stack+0x24/0x40 (C)
> [   13.062602]  __dump_stack+0x28/0x48
> [   13.062710]  dump_stack_lvl+0x7c/0xb0
> [   13.062818]  dump_stack+0x18/0x34
> [   13.062926]  process_scheduled_works+0x294/0x450
> [   13.063043]  worker_thread+0x260/0x3d8
> [   13.063124]  kthread+0x1c4/0x228
> [   13.063235]  ret_from_fork+0x10/0x20
>
> This happens because smc_special_trylock() disables IRQs even on PREEMPT_RT,
> but smc_special_unlock() does not restore IRQs on PREEMPT_RT.
> The reason is that smc_special_unlock() calls spin_unlock_irqrestore(),
> and rcu_read_unlock_bh() in __dev_queue_xmit() cannot invoke
> rcu_read_unlock() through __local_bh_enable_ip() when current->softirq_disable_cnt becomes zero.
>
> To address this issue, replace smc_special_trylock() with spin_trylock_irqsave().
>
> Fixes: 8ff499e43c53 ("smc91x: let smc91x work well under netpoll")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> This patch based on v6.18
> ---
>  drivers/net/ethernet/smsc/smc91x.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
> index 9d1a83a5fa7e..b7fef6ce8615 100644
> --- a/drivers/net/ethernet/smsc/smc91x.c
> +++ b/drivers/net/ethernet/smsc/smc91x.c
> @@ -516,15 +516,7 @@ static inline void  smc_rcv(struct net_device *dev)
>   * any other concurrent access and C would always interrupt B. But life
>   * isn't that easy in a SMP world...
>   */
> -#define smc_special_trylock(lock, flags)				\
> -({									\
> -	int __ret;							\
> -	local_irq_save(flags);						\
> -	__ret = spin_trylock(lock);					\
> -	if (!__ret)							\
> -		local_irq_restore(flags);				\
> -	__ret;								\
> -})
> +#define smc_special_trylock(lock, flags)	spin_trylock_irqsave(lock, flags)
>  #define smc_special_lock(lock, flags)		spin_lock_irqsave(lock, flags)
>  #define smc_special_unlock(lock, flags) 	spin_unlock_irqrestore(lock, flags)
>  #else
> @@ -658,6 +650,7 @@ smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		return NETDEV_TX_OK;
>  	}
>
> +	pr_err("[LEVI:%s:%d] before xmit_one %d\n", __func__, __LINE__, irqs_disabled());
>  	smc_special_lock(&lp->lock, flags);

Ah sorry. I'll send again with removing debug log...

>
>  	/* now, try to allocate the memory */
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

--
Sincerely,
Yeoreum Yun

