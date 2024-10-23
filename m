Return-Path: <netdev+bounces-138246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5509ACB66
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD51C212F7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8D1AD9F9;
	Wed, 23 Oct 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgXOz8Sy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C011AD9C3
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690737; cv=fail; b=hf4uLXgE+Hx2s2RiS7k/0Ppgl2XT7W/E/Cif3e5V3dtlFS6L20IX29fV9UkRpUw8LIEv/Iouucf1ganr3Z8b/2BGkocAVjxhbxHdwYb+L7+m17dXc7hWOf1Y3X2JbvAZ9VJF+zlRRpRIw2bMzBx53vUza9ngWp4BKSD3ORvBIRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690737; c=relaxed/simple;
	bh=IQsckZLHIN1iWQSBRpFpe1dXb+N5ThtTVTsmi1yd7Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdEPZDoFmMFuaJZAwKB/qhkjGaEns41t39dDtn5f8eUs/J+rDfs6geu/lO3lpS/hE+fMw4qhjG0iTJWvd0dufsGqTG+43W1zz5IG0jF5a1kGxuZJ53y3+fiK/PoR1GzH1bdFI6Ytajxy4jgTU6t0PnjLmPieUO1h74OkLEfGmHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgXOz8Sy; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPjCw5nl/lwruEbRBdrNPsCaYLIdm5vx2BDliAQLCtnf5U/t1tasjI+8l0hlE67zFAM0Mjqvwjm7o/ZOWnB5Bn85mxNpVqZsub2a/FSofVOIMxMCTzT260fNZRn7Vv3FKdiD021fDwCw6jD6V5jTb1UEPzpZWEEu8783MaLxQvjsap+4Phw9XrdcfjLbiOf86Z7etRTBb3vKbGCnG7DOrmgJBIAoSth2xPq6Q0PjiDsmbNOqtki0ziFEp78yNPbpK93mWiT5KyR2EMLgBdZ7azNXYY3v0W1NLPQbXAFp8b412fb4tGqgwDxoCscgijxU1JRWRTM8XjtUYEzSE8TfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXdfN17cNfAJgoU33oZcdPEfznsc/KQh47e7SRgvnhc=;
 b=gcYJ2OQ9RnwJgZ4OVoEOcSXDcy+mCxBW2rfFzkezfa1xyd1IXUHQfq13B05ZwZEB8nUKA2ApaQzbCIoOLlXVPexDQxHKSeraQqikzoPxGglrhHkQGqMGMKvZw27ktYRgn1MFZriTx9HYemNVVh1SSsyBeiAvcW7DbYe+w+GxC04nF1Ox76NZVVCTWAAFclgeqlkJ91g4KoK51L9XsRf6QlGxRTZrO+OhEt4Flhrc4k1FmGWv/tyKK6ZgEI33SD/LexFsU3kJFgoXEwLxXQh2OTsDoVpgbHqyvmr4j3qvHJm8NxNjo0rrOAxrrYdVG3EOcpnzzTgUvkANIMzX570bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXdfN17cNfAJgoU33oZcdPEfznsc/KQh47e7SRgvnhc=;
 b=AgXOz8Sy0+4vMdxxPV7tdMM66js2yvJMQ5MDe2b6Amu85KtJvtcNxR0vtEk9h8EX/FxOB6i2CRcdSUrZwHPNJFkH+/0X3+WfAeccsYq5ptvDL9T2Bg44WkJj+JFv3bgHd3aN7nzRilOry081ayaqbtxL1OwfCGnkQfi7MLZ23mUdKZv00Tu3qucONCNTPvTsVfleKZU9oSobGSLzpv6ItGVdl/ZfNtdO6ETRhMVFpaCBECdHHKotEkn/PvSJzIWJAfbtf/DL+KQ0JPIi2R4nf1em291KcptFI2yIz9xXGutDNePgiGvOb30jCXEBfuUimgllYRQoifaTcd633d0qmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:38:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:38:52 +0000
Date: Wed, 23 Oct 2024 16:38:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Gax-c <zichenxie0106@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, petrm@nvidia.com,
	netdev@vger.kernel.org, zzjas98@gmail.com, chenyuan0y@gmail.com
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string
 in nsim_nexthop_bucket_activity_write()
Message-ID: <Zxj8YME6wXzPB_7q@shredder.lan>
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022171907.8606-1-zichenxie0106@gmail.com>
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 94359a77-d184-44d4-63d6-08dcf368084f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/tnraplahCh7SYwcps3L7XMO0POg2HnVI4Szrja4+bs0rpiwIc8SxIPGGmi7?=
 =?us-ascii?Q?8+ZbGurTFWvp5FbdY/W8sROg8oZU7yrSnGuTsuWCj2TfLfUubaUB5d+HqTY1?=
 =?us-ascii?Q?gBheoK8t992GREYERaEaC2jrwVWu42mPXXmQt8DxB/RcWErJSUAGReAsVPd0?=
 =?us-ascii?Q?kM4ovENJMLaHgmPSI4w2d/KTnRzk/x8ksheQfdG7UWFC3OadzF6UgBinWhxJ?=
 =?us-ascii?Q?UkcO0VhtRCeJax7v9Z8N2HNWOrgY3xc/B0w/TfZDjidpxFsWVr/ugi0C3Ren?=
 =?us-ascii?Q?WGCYSrb5s18ozbNnsJAp80lutBgahVvkhDKPOfw8Hn3JLgRdzFgCEhAGmhPF?=
 =?us-ascii?Q?K1cOot9t9EntHzrr3Vf5qVoBTO33qJeP3oZ9a/TJLb1K8cbKzBeiKQMRd6RJ?=
 =?us-ascii?Q?pOg9LLvhcGG5sLnrwehH8+kmHH52o2i93Ryp3e+FKUblkvdCRaKPHaJDmZe8?=
 =?us-ascii?Q?MbKHklX2S9p6ucJ+OBkyO/d03h/YRraHweOdnLJnXaJCrF+teh5wNNV93LL/?=
 =?us-ascii?Q?LeBvb5Molohs5p3Kr2w+SWGErcidv6KWuyMmvPWJHHKwxVYuGcdKtY146ke4?=
 =?us-ascii?Q?Zb0DEgauVrx0rqGeos789dKh2085MdNK8eptbeE08OUlnTO21tCSl+0GFvSy?=
 =?us-ascii?Q?rD2d+nm5Oy8FP3TwQpTuuT5jsGSzYz9i9Lr2q5xBMIGQrZb8D4y00KO4LMx+?=
 =?us-ascii?Q?EGhO55+OjjyVSvaGxB3+JCgQwgR3yWb/KMJjltu89c+cCWoJaSS2zx9zKyEA?=
 =?us-ascii?Q?cOTAF4N6D5reF7d7LbodvrHXfz2WQCR/PyswuIZtZqy7XuvLdk9V2D4Afvqx?=
 =?us-ascii?Q?prvnTh0WcObwpOZNa4Al3l/JfVUth12YZxoR+OgLihlxjCGVTGPIX/MeyTn3?=
 =?us-ascii?Q?NJfNJgX/5eHE3/nEqU0yDUBL4PxaVFTw86ZGOYyIwASLRv9vwsuKZbjA1MFi?=
 =?us-ascii?Q?Hg0CKnGF2/NnpB/hHndETluF3bqyXu6uBMte0HOtfg6tAvE3GyVcQ3MbinoZ?=
 =?us-ascii?Q?KLqts5eive4vcB1162jqCRjZ48kzY5L/hLRNw8Sugp3+NH1L7RDQn6VsEXIb?=
 =?us-ascii?Q?4DbLU7Xvi0NbEdjpnzynMLBOoD5vc9uYpL5jcFnVF+mTpWUGfX8Z/btfZkBQ?=
 =?us-ascii?Q?g55yCp3v9aLLuUUl7YXrfVitNu9zbx3ahQYP7VluOc5jFj1ubSsgD02u6beg?=
 =?us-ascii?Q?vv0fGp3Bh8lm2JCLQmvKY9rDJVDqnpRDv4jhCScWsEAGkixZNcf5rmLUMMsI?=
 =?us-ascii?Q?JI0uLqGUG+sWFP2Zkx4v79o+3b/D9HGfqyvK3blbrGd1h0zzDIF/a379J10/?=
 =?us-ascii?Q?yuVvTs5VOp6SkC273qL5vU8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVhS8pr6CJijZDlIhh/ilFsn9yLSXGvcQK8PqIVo6T/5FxwiI6uX+D+PLpsV?=
 =?us-ascii?Q?MVm9uYxJholUwSxfpwOK+VcR7ihwFWh3T7eFLJ5YVe1H/1MVAoBnbQhhpMEk?=
 =?us-ascii?Q?t+QGLb6K13qNrh6RkYxeGQsSS27DIHn0h46T3ixyFEufg4Ncn/Fv+28IiFuF?=
 =?us-ascii?Q?a1FFXRJfRrG5/iG7ZWk34q9gkHphKve4n0hYMPXbWg9uvTxQ7FmFgmlKGmmA?=
 =?us-ascii?Q?qPl0xmZ8/pQWpqnXA9BYhZ6QgmFsukLA+Qy9IaxFm1G+/ztCXgNsELQQ6jFR?=
 =?us-ascii?Q?5kxJvhOZcj8BdtIsV3r6fQu3llwBfyvYMWgLfoiiAwq8IZbtd2JlyNMtBYJk?=
 =?us-ascii?Q?3VW1Sf9LA1QvsIEWxkgtQ98kfWcttUmrnu2dRsm1+ZB/VBQyFUmsXlNSwSVZ?=
 =?us-ascii?Q?Y/72tQ8TB9CyZCT4zTeKIOsBNJOVhsExxwP1MJvdZFSJuPsEzb6WORRNpIu5?=
 =?us-ascii?Q?SXwXVy0Jg4cRfOghxxg4Bza/vluBmOY/GZ+xoSBiBhrzJf2aK+CZBI24HiM5?=
 =?us-ascii?Q?LVpONqNu7KGN/+C/dCYVSiILLVbvCg8DOD/IsqeBduv3hieSSYS98b2DY48W?=
 =?us-ascii?Q?dIbkk0EViT5ewN1WnuFkFvY7lBTBKnoKV14DyTLSQOzsoyy5fgQBovLIFvpu?=
 =?us-ascii?Q?vSgS/28e8aQorcl1aqDauQV0ytJMNj6e3xQ6vBk244kDYAodsDIHKChcFYTx?=
 =?us-ascii?Q?qSeWe1mZtUnNYJQ2bIVPOCZz6baWjgLIbe39RLYYZNB1l8joQ/eufBMoDtV9?=
 =?us-ascii?Q?jyXurgD0QlWcYWZ4Zz6UIPAz5YwHal0R4ciTCPnMdufJ+cDXVY0sctzX3UeU?=
 =?us-ascii?Q?VD8wuAKtRlu+/qTGombNmhQNyRd0JRW+bfD8XgRtpOORN6ffqHYwTMI15D0v?=
 =?us-ascii?Q?BC6D+B9PZdZ4NJmPqsjD8vuIbxyzwZrfzA5d9Xh56eKJAzaT10h1hYXfj0R/?=
 =?us-ascii?Q?Ryekq2+fBJOlVCXtRHDUTtMrb/gtHXEn0R5Ke5YdaL6DP9/4tHPDQ9Kechkc?=
 =?us-ascii?Q?/gysLWzNmqhH05zZ2pusLfLsIS99jL/+iZTGLUmnIu8/1MrtJt5Rhib9ACVe?=
 =?us-ascii?Q?zWB8LrbaNEq6o8i/FmwnNJHeVDPxV1EqkmPUUehxe31rWlhK3oHEVe3ge1S9?=
 =?us-ascii?Q?+QnnDmCj1gWgwRIrxVaX0EWjkDoQzMwEDC/QdhUEd/MlxrUAxTNljq/Gd1W4?=
 =?us-ascii?Q?sUO2QkMxnOaZ92p1FVgkLVW/wuYTDZRd6rPSrzvl/AfLgY5hIceVdjkdOxPM?=
 =?us-ascii?Q?NwiMOGFzo1bUSrE07osxwNJDOFbXN+G9RMzKXCuCOGakLssP/XGIcrDLGM4w?=
 =?us-ascii?Q?e1c8bnYDtYlUY7eq3PHczsBeC4DExvYY81HNfk4Sn7cJHPpADBNYW3wuyFnk?=
 =?us-ascii?Q?r1hgYeeZsq7xJlcDoEwXULj5PuZgj1ZdtXsjhc/HVr4n3UajdUCpeIGy+6sX?=
 =?us-ascii?Q?NDYAinAGuUIvM60DXDET4xiKekJRBSlpkXSdYspXKPMOrOyU+/WlWLFWoZ7u?=
 =?us-ascii?Q?r+DtS0vnKi6r8ljC0FNqlFIlzOI6U5X+SVad7R/t4HyMwv6EYt1RobwQf9YB?=
 =?us-ascii?Q?cHbk3e3oyComaNaJK9O/4J6uU2NMHMFLjVZAc1iR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94359a77-d184-44d4-63d6-08dcf368084f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:38:52.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yY9CHl9b7bypLCJKlAfwusr7bA6wnFPVga772g0zddWMR/qm82xY7CcCuxagGLRrUCohH/jcSyPRvvGS91bXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

On Tue, Oct 22, 2024 at 12:19:08PM -0500, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> This was found by a static analyzer.
> We should not forget the trailing zero after copy_from_user()
> if we will further do some string operations, sscanf() in this
> case. Adding a trailing zero will ensure that the function
> performs properly.
> 
> Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
> v2: adjust code format.
> ---

For next time:

1. Subject prefix should be "[PATCH net v2]"
2. Wait 24h before reposting

See:
https://docs.kernel.org/process/maintainer-netdev.html

