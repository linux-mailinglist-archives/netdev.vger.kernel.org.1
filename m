Return-Path: <netdev+bounces-271151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE54B+W1wmlolAQAu9opvQ
	(envelope-from <netdev+bounces-271151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8B3189DB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D824305CE19
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D337A48B;
	Tue, 24 Mar 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IY+VInwZ"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC4344DA8
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367754; cv=fail; b=dbzIwFc75vmwCpj+gGYD1b3P0lE9HJ3qQwrlRQVxljQFghswxyDs7sevE6KA0ZNC5rl92moplfG8s9+b+4dJVXCPVJ+8NDdeWi7VtVtoVwtvWuVbseEsz/IMwO52IIYVZh2OJ5pPA4WmZEd2DjApnuL4thEGVJ99JG4RIjrzLGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367754; c=relaxed/simple;
	bh=N9NwaC12P/hG8rxFgCXB6zF+Jg6PYdmXptlwDkGQ+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q2lF2Ueh6CP3WPyfjwPjcxgw/Ty/NRX08mtvejx2EYI9o5UW9AO6OjPu1JrCYzOohnsNpeK/pID8INSm8s6E8gmqew8OXUPN/pjcistNxHXEYaMiE9Chjeignj5SBZJyAc3FMtel+2Nh9O3Wb/i+REBxsu+CZqQ765Ve6UZ7M2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IY+VInwZ; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnN9OcyxzL4rGW6uqaASQqaAYNQlh2Icq71e/lEqgqfm/sUBcnxY3UbCwTGn1fvhS/bkC3R8PEKcxe79h47os1IrcB3Meni/yqnvp8yGIF4ZGM93DhXwpu61PNYbtH6vif/p+A5CaaXiVENQlhZDPcj3vw0FCNPbVdDdCqfaPSF9gwCCrzDHXVQGsiG8Y/sdk63zcmBzQ2Km7CPMFT8eO6afnsDIHfX3/e45bKy8IoO/igckgjgtsYnpKtMMhg1ga1xO5MkxyqkXXXMm4rSGBdL0HGsfeIi6kEgKBDcXwaQfIrHv2IVf1tX8KtpXY9yaxuc3MO6/l/spz5LrgNM2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biUIeKfzgQTPiod9OL8RkbJZ2PB4sJeoRyxYOqXMWoo=;
 b=A35LDW5BL+HhE2do0tfGXXX8bF8N/LyximY18OgcdDlzE3h2L/N5ErEQbILi0SX3PukXEprzKvj5H9JS6Zw0LaLiS0fXPKIurT8koj4PuyLtTEXHGlJMQ9Bh4jYj3zqdXm1VMysKsiRPRVmUsmEmUAAi/jxL1Ftwc9zGWUPhpMMw3Ftq+O60uQi5O/FfTAVCPWwGyMrQCyMxtxd9iycFudtR6MTRPmVxW53YO8Q5Y4cMxvouewu50iBFag1Ji983KItjgiK3hoUO5urx09yUQ/yCCIzSLXSq0YvnDfLf0yux59PiosjMUnr13afGiTuzIczgERl2jm7I4KL/wuo7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biUIeKfzgQTPiod9OL8RkbJZ2PB4sJeoRyxYOqXMWoo=;
 b=IY+VInwZSkYthYbBiaohe6AEmzHlp0LkbMVdU+h/Fba1RCt1BFWDN9hE0/9RR+Ye8Hz4mQc3gxsJ00unyRIe45QMF1l9kmGxk8sERXnDylxPdE1PXPlG2qTx7bmiI8rK1ZRtWAZOFhbGQghji/v5NTglzAqeV+5AkfY6rlEZPJ3QjZauGTAmAW/vnEgeNjD/ccVDOr7M4QlCiHbXkerrLUJelNRe5Tumwuwnmt9ExyBmc1+HbqKGx3e8TFfxTTUJiEk+7cVpPaEpMd51IXybejOd7amo7WJtd7QfuLNysp8BbFZqXHuRg0A3kD/i/3pOpnJM/5/9bh103+IaiH+85w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:55:44 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 15:55:43 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/3] vrf: A few cleanups
Date: Tue, 24 Mar 2026 17:55:18 +0200
Message-ID: <20260324155521.525292-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc67c80-3a0e-4413-fd31-08de89bdce3b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	26QZsioAdMsRT7/G2WoGBq4T+yEnDLfCVqLaxZOE8kOlIGcfGM4FuJv/1lBw0Zg/T1ckIYqbjwgPRWPLjg9+ZlyDq8XzBkrZnXz/d3xIhSuTSFPajE01x1I5fdk7Lh+RHBbU8aERtEjP+NsKAnETCX8nMEdvUUvRxraqB1DpHQJBHPwJOfUY1vEBjXXvp67yzWY1VSjwvramg4sXQn1aVVLG1VhRQLK+x8jzbEegCLvdP8LTdcPYVTDWiEP4eoPGjdBulPMPaBr5SrTeuNU9JCsJTTMof7PCXZ/201WvMfZIxEl6sImwvKdlOcGH+BzD0AmCwWfj0Y7b0W8QSYdjFP2y9jhxoLgoEqsgLeoYRzONv/IFy+0koXI4Wn2luyixTOx3jWeTbgC6tDvwQxidKmwVSHV/LEQp3Ed/yFwqR8fDH/l3lDoG0IBpxYyT0xuHqlRrMV/m/lTDJaw0RTqYAvRHVsuxt/CSIBa0UVVNqtX+1wq5SB+YBNV/ziGBw+FkdPhZdU+3wyj1tl09ZJP6+P6Ec1yQo0Lj/iQNMBk1Vyac8Li/YlvJ/7BMNTr6U7fZdBq2ZYgT3wnNWA0O72CQ5iryc9rSHPV048tXuha5RRp6F/5Hlo2s/an+oFWpejLJkRrZg55/HXydnEWzKpqfP1AHfTwmkKoaoraq6orRLtrP1Cbst9Ij3p1j4ZsVJwpG+2fmrOVuKD5uqFAiV8EzK16ZVx8pOLTwTRNrgMqRed0teDCoqd04IgVnSXJwfAeY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyvmGtfxGMTBsIBTWbW/2XTx64C50fOjNJQUPs68ZicYROXzzcCOQPbA5xq2?=
 =?us-ascii?Q?REKn+BBgjZKdHuYtgVjEDqzsplUbiTxD61l/cmtKfNZqHq/FUDqBd5FnU6dh?=
 =?us-ascii?Q?jnel1pVQTJs/n4K6sjrv64SBcyYY0jWQaFjjF+7q46dJJ4HgxZfUwagBW6fi?=
 =?us-ascii?Q?Rtqgv8NT7IlB4doql7cTqyRuri5cXPf81yTnns5buT4cb7zgUXOihnw5dwJy?=
 =?us-ascii?Q?M0qxF3+3QhY3zhJkci6nQDUAMNfY5fpCdZ3FqDxQdqrNOwOuKSzNLlY1ETwj?=
 =?us-ascii?Q?BglVTbrVDGZyEPdhNNOGA8qKG+iI+X1C7jpyhti0YpmEVyloCFhEiGEUGM3Z?=
 =?us-ascii?Q?V/M3XcF/NwwApTOz81uXKa6EOAyphuB66G4PwHzY7AVG+gVBNjdr3BlsUyfv?=
 =?us-ascii?Q?T19ZC6JtspPra4hg+hJCqhcCJsYpI7vmSh9P63c4MJ6v+ZRhO1UBNmgl6TQ1?=
 =?us-ascii?Q?C/xRPLQGdWWPJlhaSdRpClGqOh8Wuntic57o8fyU/ihEXEiduvrlBecjxpWN?=
 =?us-ascii?Q?WGy4xx5ngRKBMMGnvGdOzk3t/W9FBDEg9eCyuDYEUxxqPyrrKCxg9VkPJP9S?=
 =?us-ascii?Q?wEkVUopQxRVEXQIUHZuniUoV+J/YDxIoTgsZApAGlIimEM7PRMTEigm3wUsk?=
 =?us-ascii?Q?M+oXJMmUpypW5xMTKFm/2gimRuT5mOdeAwJTKl4jiONW2a9bNqjFYa4FNkle?=
 =?us-ascii?Q?ajWECY563uWg+Yd5JC0yYCdf7Drsx+a6OP+web1pd3b88YPWs/ld2LjWICCQ?=
 =?us-ascii?Q?HcJe8iQhy0ZY4+HvppI+XyYVonGzdJLvQn1yGDw2ALeZ5d/IygHrlqxqu4dD?=
 =?us-ascii?Q?NbsniuNxrlGWMh88Il7huZQSrfquidKZejsvqRoHfEAdWJbVWVeTXhqi6HHm?=
 =?us-ascii?Q?Y/thnQ5yPVXn3tbrlL5mvDIjHdjlEP3en45MOXa/XXBrnpIn2eekj7cknD6P?=
 =?us-ascii?Q?Fjm2ySDCUJcJ/u8nqf9s7N25eCHTq5Aqy/vu1tUOFGAYt2Jo5rNJz1ERbv3R?=
 =?us-ascii?Q?sCyDibMy3wvvzCeTpntFq8N9APvrgypz8i969GiQ2VS8fcaPpZQ3a3h6fF8R?=
 =?us-ascii?Q?QKTYNAzl1zqH0tPGgR39epmI/V2jPqTbinBFApiXAiDCZoeqATRYhuRjOYqg?=
 =?us-ascii?Q?Njxvb3Xr89/yiGzEBTLVT3gEblMHIFR5GYS2a3Jc8u3aB7q9gcXAWr8FNKIe?=
 =?us-ascii?Q?xxzn6hF1+8YUknbpTK1skm54hwM4xSgLllloayxnck1sNh/N0iJbbK7V3Vbv?=
 =?us-ascii?Q?jJ5/hWiRxp820MVLTrmQQnFw+8aaHL/p5d31EQkI+0kOhlhpGOeOtpYpcSm1?=
 =?us-ascii?Q?uVt1D/uYEj4/rvHO6OAlSRKIIND0L8qN7RHX3HIJmsMfls/B9JRCdh1xMgo5?=
 =?us-ascii?Q?5QC/7DlGrvPyW8HP3OFmgdMDKMYlPAcA8gWWCIJzvJ+5fPMbxsMTrfXzd662?=
 =?us-ascii?Q?KPyeWReB/mIT3hi2p67ils5ZL9z1P33V0ZqlIimPhyyn6DwvAmhxMKdMPR0H?=
 =?us-ascii?Q?vwsuljju17RDpcgSJRQFUneIsiyT0PS6dQoTD91txUdG/gVVC2umxbGnHJza?=
 =?us-ascii?Q?VwB0awz39BY0mBtHkJiGm/XiRFprDEjVQ5mwssY8lDGCPJytiH+9Hnsycnrm?=
 =?us-ascii?Q?iQfg1Cn4hHyenYGxzSTd9m1GSsk8oonF4XVnonlkuZuzAixzeqdMPNRpLwW0?=
 =?us-ascii?Q?Zw7cs7E1xGFn8DPBGA1crGg/8lk+GMPOyje4q3XGLwj3CtpLhWYfawjCek1z?=
 =?us-ascii?Q?7PkwIElzjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc67c80-3a0e-4413-fd31-08de89bdce3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:55:43.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXnXtzJK/92IodfdvmyV1gKbpcD6n25SVtJAB9o8FF5XIryA6QjJP/bv2rITH0aUGSp8Rz9yvsBluxqyipwluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271151-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AC8B3189DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Perform a few cleanups in the VRF driver. Noticed these while reviewing
a recent patch [1]. See individual patches for more details.

[1] https://lore.kernel.org/netdev/20260310105331.2371-1-lirongqing@baidu.com/

Ido Schimmel (3):
  vrf: Remove unnecessary NULL check
  vrf: Use dst_dev_put() instead of using loopback device
  vrf: Remove unnecessary synchronize_rcu() invocations

 drivers/net/vrf.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

-- 
2.53.0


