Return-Path: <netdev+bounces-305795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lPu5OYNFTmroJwIAu9opvQ
	(envelope-from <netdev+bounces-305795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972D726629
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qcJehTMQ;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305795-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305795-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A61B301C953
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03F43CEEF;
	Wed,  8 Jul 2026 12:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E53C1080
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:41:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514495; cv=fail; b=eCJKwC+y0LlBUA67A2FEbGFpjkr/dIGHCT8DoOLL5xlm0O2zhfUJoJl2MHqGwy6GfweyCJsB1j+07A3ZzCASYwEhGKP/TK5Ff6YEz0OSRyDrcsvo8Js9wAQswURDSepg4UEO/IdZSx08TeI0jcbiFwX9kdkat4EwqbYC/501+3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514495; c=relaxed/simple;
	bh=FO6aQUGJexejNEZuSdJtwIPn0HSKTChxOUpgRWzVLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ffU+xVZXfBS6HFMa+BxOCPAe/O8gu9FJZ4wI7V5PuzXFTtegaJikUCXC3tea5+GK5kKUcyqHrrWHgoC7fVXXQSl1uaXmMHH/nmOUQn40RY72tlBYpSbC4vz9yBRB5gunyMQ1Pzi4BeR+UHDFnKzHLk3ZdRdtLhkH8L67H/PCDKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qcJehTMQ; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV1SSUo3Iv4ynX9nbG1SL6nRe/v/WtwDstvPmEj9jzAwpKfvzqhlTcm5jXUazHviysQMTq2RsmW5ZMhW7IBqaBQv9mgTJ+LSG2Ha2SxFkL1wV8urlq0Q8SASOUyCrPpK+XefyyYiiIas2y5bUVoCnKcigtzoGXYaFdRu8YyL/ZueXQ0eAFR2SAPVWLHeJo0L/1XY29g8RBTb21Uj7f7RyHgcRyFZAVB2pB2cl5ybdnT9cUrcPISvZMTTBW7lcDxaEbGX0Sz+H6oE4zUrkWgOP/eIPFWZ6cunhk1AvLqM9TJpWEGbNkR+/j3bx0lBvTkIRwO0xYv+lDsu2Ww63zaqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsyh+rTspxLHRtpF3CgkxwFxJZokxyxtj2vdroXutVs=;
 b=G/HIGlgazK/ydf1eSF/0RXKnFkPn/JQy2MzxM2I8e2c11EnAHbXoLVz3bwjVzlATKIywn/eUuoTG4zV0RnSJi+JrA4QRxXjmjxXXSDDv8jt3Y3iJsqPce0at/nrlOy6VQWX2np57e+Y5zCRQBYUAbn32ZF181TgIj6J2GlXQQzO8NIFs0Fzfz5EZUoboNsVuMOIAsCpSXRdTJtXCoeCfYuACssO1MxYBCxjhzz4EtK68AM1QOU/u2PcYduxgahl5CmhQ+NnifZrgaywxXyk+Q5d30Tol1ct+d+zAYADHS+h2P6lLmibGfHP9MB9iheVV8cbb6Xu2xArvPWG5tjmUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsyh+rTspxLHRtpF3CgkxwFxJZokxyxtj2vdroXutVs=;
 b=qcJehTMQQvT6NvI+cqkmkDNF4lgVzksWeOG8oNpEr3cNPjGUuCttOG/+trSN00srneFW37OOWzuRCdboCvCCGC6WVUD0SitUglcRjYsfNpaixzWYE6X3GdWySOyIGv5HE5zTk5zvuc32wAkuC6m3WNwjYWd8nhAeg/mkYnQTbJrPEIiUr6qRX5jhCzaHvCgH1Ralp1oyFzziqD0yhRoq/k/pGUxGG0KZ7tngqR9z4ONEfEnS2YzBXOsmVvQdVTd1jPHYPi7Xv2wYYlWkTB5w/ue8/b0OuKTYaQ/8hS4JGrofXJC7tU1D3Xq77K2kA98B32yPwSuGz0DIA9fwJGV2Qw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:41:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:41:29 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/3] mlxsw: Make the driver ops-locked
Date: Wed,  8 Jul 2026 15:39:30 +0300
Message-ID: <20260708123933.1303291-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 1679df1b-dc31-4e53-d9b1-08dedcee3b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	xb7UZ6odB0tT2f/MX5NPZpFzubaayF4PlqNvCG2Gm1HoDD6GwY7m/9o1z4N3jeKU30xzkyW3guq44eOBwRpswKCxhNKd4ebXdnDNRD7gaB6BAvrqqCMXSf0kktIlFhaUP7hlVHSZL/l4whSKJb46KzC4ktXD7sL4cNS/mt9DMmlnO+6kgTinIrW2NnsahLOnw0GulBIlLhW/z96sk2fHwTfeK4T13WFFkGBOLBd5Ny7sOY/TdPk4rydTvrfit84l1fMi6m5z6FF4XJo1m4obKTcyj7tO9J3lNGjdpzKYi1JDZTINuznZbojvU207BBIONqQWE8KYA4R67ld+IeeejcI2cNZoWa/v+9SsW4HBHEFvjlkdksFgDx6HWm+gvA04dhFh4xbnm96/QG4rF1nvLFcRwz9bAo323LBce+iw0SN3BIzxFMt2o7sok8pHg4prdp+cjSqdLVjlK9g9Pfq9XRGDSxPQgM0H1wIl0HgYpmSEDk1l6+fromtFghUXSeAxSHzsbIuEWbgmLYdvjjno6iBhk1EGLsIHvbz0n3uB8bIh99/Pg/ugEnOV1alSfJrnQ6168M7P11adAfmHzhUlZ7J4zoPdkIUc29iCeV6wGHJzM/cnAn0PNz1+tCiY9QuYxvdyrTIO9nASDYfKtY9Hbg5J5FNQKeqZWzOClc8mvYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I33ADwSGGZC9mcdb+pENDhLnJtm90JEaUvE0J0Ak+0hXORbuT/NMzllu56YQ?=
 =?us-ascii?Q?tvf+t3/EXG9OA/Mx+OQGkOTy9gvCQ7TY6BYIvWqvdfjA4+3GH224lcMc6GaL?=
 =?us-ascii?Q?7v1M+cXExb4NpSmOqkKFO3ZzqHONYg/ZQtDsPayouFeI9FhYajYrkz7Qup3a?=
 =?us-ascii?Q?0uWKqkxJGCl7aSkvyr6LseQ2sCoKZNW6UFzc+8c6NMlPJU8SvThVRX2W0UWM?=
 =?us-ascii?Q?8ikp5LtNCDeDAe0W7gc2tk4fMGrEsZMmopEnP05yZ3xvo9kMkZA0k+GoMRWD?=
 =?us-ascii?Q?/Cmay8Heg2NU3BU38tbaNnzgYiWM9qfIIRnziWPIyrgVOnnG/GS+fZ8tppzZ?=
 =?us-ascii?Q?359ZbWeytT6ssglKrBrXD1r/bn8P+rgbpTc9CeRaePb7K3G5vT43GyS/V8hx?=
 =?us-ascii?Q?O2XhWkm7xvqQlB2f/+knhXT81HIdsOf/mXOA9Ap4JXD5F4BaRGt8CR8CS1MV?=
 =?us-ascii?Q?Tatg+aGNmRkFpRTq2Px105vbpKqeV7PxNIhWFj4JP/wEgsFO7K0x/y3BHylt?=
 =?us-ascii?Q?lKVkFjYiddJPert4kJhNToAPobgrzj4rbURKrJTTlxqCph2cDQ5GGFgMrO9p?=
 =?us-ascii?Q?TeT7yOqgdFYxUFRfHngwPrWaMYcaoVi/qmwQhpVqdx0HQa8+7vceCoxbJrUg?=
 =?us-ascii?Q?7QGSsKKudXfMaYGK1ITKNhlVlTG2H8iaJ6x2A/txDAiKVfPxd1ek+YORfnKV?=
 =?us-ascii?Q?PC7d/Bht3S1GmtxudEXniLMxqSoaKVGvQc/uAicY08/eAYqT1pSO7PeM0ae5?=
 =?us-ascii?Q?Ye2VRQSc6LjeZtKimKhHn8YOsW9qC91uToHKD/waCghEMg7MIKAeORI2PQoZ?=
 =?us-ascii?Q?hYNuNKQuruSnYue+uu1CY5axs9muda2eA4CT+/A+vIc2H5RAh/7Evu3nIwgU?=
 =?us-ascii?Q?kzuOg9+ektxYWugcWUtymx2vM2Ku5bGKVxWwYkahvrAqUkr40rp08MjKYxlS?=
 =?us-ascii?Q?n7/n/3tmfmYXLfIFshtloCUfs5BAD7xgD4MbRGD3pUEwJ99TVVm13g/VxMNb?=
 =?us-ascii?Q?yT9CEd3p+RJQvoucHtc9CJdQi5FaYWjAWljKuYSXAHKw4B6csn1DjokQ6knk?=
 =?us-ascii?Q?+p59CnvClh2pRmkSlECJvVxOoeBt7KJE2aT8wQLfsn0T6bDfndnKVWMl/plm?=
 =?us-ascii?Q?zyFR9zHwMYix4hx+Qx5Pzxnr/4a3P1reDnAcm8AAXyyrk5OZYLFR5J23Hdot?=
 =?us-ascii?Q?gocGney2xjIC1w1advRt1EmwR9pqk2x8KnI4364Q88gKPIKHiBObU8oGmcof?=
 =?us-ascii?Q?tFVP1IlkohGnqZ7YOB56wIuB+bg+LiZWf/jZShe7xk+4wZ5nzf+BJIi9zNet?=
 =?us-ascii?Q?v80RHc+IywPFbsMEDW7X/55M/IVRB/YlOlHwfMd3yzm5izvcy0rVfoXt6ceL?=
 =?us-ascii?Q?ykdcAo3d5cSSlKlLfeuRM1mvmdn0gGLUn2iwXZfplyPDtRO/vYylB01jldIH?=
 =?us-ascii?Q?vCaka9xHoPj19SlUieE/KsYXNw+SJ8cX2/vhJSrAMf8v6AejCgsRfflQqkHf?=
 =?us-ascii?Q?tP8cgbTVyilZfvIe4TWspzF+sOFJFBx7e2mqwnV3maNy2sOkloYdIZZazEtx?=
 =?us-ascii?Q?/roQgC9Xx30DZIl+V2ykcDKSFLE8i9wAHy8l3WJhkgDtkuNx8mOC6Tzo4Je3?=
 =?us-ascii?Q?fCkFwdH0ofTg64MV8mbJ2QVB9eUa7kyYEZ6nXT3GgEqouW6cBd8eTAjz80L0?=
 =?us-ascii?Q?Mm0RLfIvR44O6Y+gcjGBKrpDmScrKwjDreDno0Y2a7LiHCJH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1679df1b-dc31-4e53-d9b1-08dedcee3b4d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:41:29.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STo20Px+WzB3c9ZUfyPMfR+9GJmk0YeutnKV61lTiiZqEPEIGWyWSc5JanqkmI805XLXcPNNJb4g/z6yoU1y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:idosch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305795-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5972D726629

Make the driver ops-locked in order to allow ethtool operations to be
invoked without RTNL being held.

An ops-locked driver has most of its NDOs, all of its ethtool operations
and some net device notifications run with the netdev instance lock
held.

In the specific case of mlxsw, the driver is not using any functions
that acquire this lock nor functions that expect the lock to be held for
an ops-locked driver. Therefore, converting its NDOs to run with the
lock being held is trivial except for a small quirk which is handled in
patch #1.

The driver does not generate any net device notifications, so there is
no risk of nested notifications of the ops-locked types. For the
notifications that run under the instance lock, RTNL is also held, and
the driver does not acquire the instance lock itself, so no changes are
required in its notifier handling.

Ethtool operations can be invoked without RTNL except for two operations
that are annotated in patch #2.

Lastly, patch #3 converts the driver to be ops-locked.

A probe on rtnl_lock() shows it is no longer taken when dumping
statistics:

 # perf probe --add rtnl_lock

Before:

 # perf stat -e probe:rtnl_lock -- ethtool -S swp1 --all-groups
 [...]
                  1      probe:rtnl_lock

After:

 # perf stat -e probe:rtnl_lock -- ethtool -S swp1 --all-groups
 [...]
                  0      probe:rtnl_lock

No issues were reported after running a full regression with a debug
config that has lockdep enabled.

Ido Schimmel (3):
  mlxsw: Convert to async version of ndo_set_rx_mode
  mlxsw: ethtool: Prepare for RTNL-less ethtool operations
  mlxsw: Tell the core to use the netdev instance lock

 drivers/net/ethernet/mellanox/mlxsw/spectrum.c         | 8 ++++++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.54.0


