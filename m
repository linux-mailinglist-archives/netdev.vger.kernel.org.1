Return-Path: <netdev+bounces-217316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F93B3850E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A09189FC39
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC61C5496;
	Wed, 27 Aug 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkxLh2gj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FE3FE5F;
	Wed, 27 Aug 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305259; cv=fail; b=CeXiWg0JiIBt2wqWtVWQZh0IRaGZhn9Ws6nQhw2Q3eVcwhchtRyN10WC86/+xAtj3XiAV1rxGHNikNHyi/IjVrHmOOe9RMJ25LoVBCgw1gb6Z+wlCOSmVrmh5v9ffXrRtFQlZcH4gzwGS6MQEBb6un2ktLq7esV/dXLWyKzCSRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305259; c=relaxed/simple;
	bh=LMlId26aTElIv1hKuNG3QMiItudZEIiUaxJBmEFPLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/4d//r8nn+izVQlASx+WO7f6KP+DAwLZ8OZauZEumy9zFreu9TK2XldOV+vsg0AM+66/dQZ6N3T7nFXwYwBimJIOqzoDRkvdBpJnIB5vAlJ/mBSNzIAP77GJOLeT07231aqgKzJt5OhEpgxYpXgFljl9njBwxWjFQcNc6Q2LYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkxLh2gj; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd6QB9ZvkDhyigY2WGKWD5cBuK+LwqNp+AHxPdYTAg1o/xXh4EYZTnntfVlgeeU9yxjag0YsFw0X3w5xUCBFvi7iM/XfvQof/fNofcXtXGe2e37t4yPXsSXzUCLA6MVnTUKmHfYonsPrArsq4QZ5PYJME9lNoBCxvnPtEq9XkjgdVfR7bPKq/NtheEKsJ8j9s607tHUJxLd3BO02KeMDlDy0XqGPk9q1zH84jp+hDcmIvQ42CsXhzUsNzZ6l2fztej/T70z56bHUNP5c1blrR5v4JPta66PCYfr2CCzpv3PAPr1pvH+6vsJLgiSgVsdgkn+nUU4yPjhDt2XtudOfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YTANuXXdnGCHkms4NSHDsqcqL1BBYcofW5DBj44TNk=;
 b=jiF9oYPgbVpJHoAZAcQdLnAssxFpo7khxi90PRXy7lB4amhbkaGBSIUn3+bISFilGz90a9D/9dmb3B6ZHHiSsHa18tqblIoYFmVg0gaEo7oItgz31zL/Y9bf7lolmHm0bour3QgJcjzyFmyDLzwzLLqDtnjMO6ATT7NSV7gEmsYC7DHrHmfN/+GrEALuQi5mTcLkziLjJkL2H7FG6wHfNAIfUchCdwIx7US0/1ovDzAZXGYQZTuTVAvLmsOn1v9gM/JPGF9nntauk8kR+UnH2OOn1+uDbMpcUliFG7h255UrLKqaDBBxtPozrh2UBc5x8ZHyQ1fnhWGCADrctwnNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YTANuXXdnGCHkms4NSHDsqcqL1BBYcofW5DBj44TNk=;
 b=bkxLh2gjwAX99OEhi3Mj1SNv2ZvVRWv3TAko6XDvEpKtBjNjBHvCKIK5oPtlsKBeibXzN67h0AC3d14fqRvM5NUVc1Kr0AUxYQ4EzJCWdBtIo1OYSh4Xo6k3Kpl/leUunxUpy+GEHPT09XpesrYQ4C/e1SIUGiUI4Iwiy30QyTQYVCTPjM/jLjJrR0P+m7+rFwSeLlkr4nRU0UVQakvB4+zmL5LjlnALrMhcalYh7sg/SKLqFomP9Qve46/+ZWCLs9Yk+qpQ8KSInfzQLo/Rx3iq1QEI1gWj5NTCsw5GEtAhFyaEfNZoz+vyXSYlFuBZY7KehTez0if22d6EGMqwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:34:13 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 14:34:13 +0000
Date: Wed, 27 Aug 2025 14:34:01 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/7] net: devmem: pre-read requested rx
 queues during bind
Message-ID: <6ch2zw5qv6ntgxgufebbmu3ixs4xg5duh7aoth3ept5ybgtsm7@55zj6mtd7izz>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
 <20250825063655.583454-7-dtatulea@nvidia.com>
 <20250826173321.4ad50edc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826173321.4ad50edc@kernel.org>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 66292676-5085-4ea2-ddfb-08dde576cb1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14N4r8Iq233r8ppFXtAFUSfMtDo2KmyUw/SALrrOonvAeW9kZhsTEHFg2QGr?=
 =?us-ascii?Q?lKNoSoO0tNGFMXtGr9Je6X4SnwRssAqJVpmpdQqkMrTlKBRUvlw+j4hrU05P?=
 =?us-ascii?Q?8X6+FBUZ31wenzvlARac23a4iTFl4Y6NUMgNpRQYMtqgqHxxfbtITePvYwmD?=
 =?us-ascii?Q?6KYckdjEEmsCgipl8LRO/fHl+BxbbItb4JKqG+EVpn1Mw17m/FtdvxdL2l16?=
 =?us-ascii?Q?b8S2kiFLyhmJTZq0qMfZxvOA4Y57mgIKjjKBZ3HJtFrwQcTu/Gwm8X7JRiL/?=
 =?us-ascii?Q?3XTVgT//e4fCcHAn1HaCFuFJsiOblWa1t9hb7MXt3yWL6jdGzMl7C8XONE6v?=
 =?us-ascii?Q?hXY/yAPoP5NH84LQxhl1VrfKUSJjKsn+4vvOLqW5lMtR7sY7mMcalBLUUYAI?=
 =?us-ascii?Q?1PJ5poCMUB9zpjPiGmvNsCgKSJOSvQaggkOE7MvNY4JTIg4+sZmAgri7N+Rr?=
 =?us-ascii?Q?HifMlH6E/O8BzjYMe8tkmZw37GFzcHsMrePGm1PHZjsRGTydc1pCPToNAhK4?=
 =?us-ascii?Q?+Fdmmy10dHlalNJg7d//vswk9CvCmMVR8nd29b5rkkiTMB2cj7dVneT+tXMw?=
 =?us-ascii?Q?WHi2ZbpG6E6Zcc6DANNsR+bFleL9bKxcbwpUhe6I/9d1Pr43sVVscaqEEP5T?=
 =?us-ascii?Q?qATxj8a2/gAnUDpxA15PsLHn4MzCWw20Qw2dAFwQ/FRg4uVD5NSe5BtOeazZ?=
 =?us-ascii?Q?w5HGSKW3lyaWxzJF+dTI1vkQfocMpCLXfyT7C8reB5mTIDtRQAIM29gTWbYi?=
 =?us-ascii?Q?FAsp1j0Sncuv7kfLrESg9Mw73aVK7qDARJrZLLjPTp1pgXFkliTpOpboVxaZ?=
 =?us-ascii?Q?5b33eG5ovAZo6HK665JtMSbGbdmRwDK+/3Ho1TfmLV4wJJSBaSibgC4is8TI?=
 =?us-ascii?Q?qm3Q8qtpZ2RVr1bj84M5x2kyGgPzSmBp2l8xx4CbFVi5eYTAmxRegppN2Ymt?=
 =?us-ascii?Q?DLoDSTFDw8W16eqdGiE7RyMkjwvYKRfYuyWWdxAUtOb3dmMcAIcs8qDJnK4W?=
 =?us-ascii?Q?DBeg+vpVYNH3Omc2sSi2GK1XVL2YG85RwdkJFY1KwoO73urnw1+WdaapCEpI?=
 =?us-ascii?Q?0zcVxV9e5knD0JEppOVEy1TKTuwvjykZz2hLVNRgicp4O7DvPdhSPSIvfk8b?=
 =?us-ascii?Q?at5Ef1TocSCt4N2O7rXYzwbMz4E2fAYMXe+BCJcFVKLFE9vruXGo3wy6ECGw?=
 =?us-ascii?Q?2aLjFTeBmNwfBc/FuFJsYR3vVH4cKux6em1+vXpLd/pGFonT5YH+VcXDUBzQ?=
 =?us-ascii?Q?PuIryTXX2zSvnDf7D/bg/f0vAJ7BjtK6fwRQSX0o++A2YcICs0QXSBP5fEC9?=
 =?us-ascii?Q?qeC817A9GOLZGpUjtUKwtFwvpHwv48ZUCYXCWxVJG09K2CgACzNtGwYg8Xp+?=
 =?us-ascii?Q?XtFj9kK1PgqbIdsEDGhjQ56f7p9wXegyFvqdLq41svoqoThHDaAnn4tbMt92?=
 =?us-ascii?Q?A0NhtEdm5Nw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lJWFCTsRvFYig9biOcxdQ2+bChcgGNWNJdEKtXiQN8HkdJRAkB2PqoXJzCz?=
 =?us-ascii?Q?10KLGdAkqVUHlK29Lf0Hzgla4/+ba25rBfG/KP4RH3aWkcGwqMpLZvmTrXfH?=
 =?us-ascii?Q?VasQE4lE3skLK8TqT8gkQ1XhgGQVADT7JN/23dj7bP+ZKeU5InQ8L8m0GlMJ?=
 =?us-ascii?Q?x3MfnspvCDk/rdTWQYyFGo6JFjOjBikb8gZv/sqhEUF23oxu9SDTEpRmmrHR?=
 =?us-ascii?Q?ou5IpdbHtaCJhkrtvm2GAK1UL7AMhZ1tjBhZna5B7uEUU26DSg1pVmo4YM+U?=
 =?us-ascii?Q?z0gCKWzonSJ4f22n7KF75JTMX1oUS2gWW+FHlyJGuwK8tigItG5H2KZqk3NQ?=
 =?us-ascii?Q?gJrN2fV4NAbDK/pI3RdzI+wb2Poszw7Z1E/bm2zZ0e7F/DAYaJsBpZLf6Msa?=
 =?us-ascii?Q?sIOPotpxdXH+s/4rA+9RE8CpXRy2JedYmd9kg3YO0phQOnotlnE99RPvW7GU?=
 =?us-ascii?Q?uTOG0IUQiNrweeutps+BbQ60gRsZ8i1Fki586cXKhzpbN4pIA0WQEGBrLR7k?=
 =?us-ascii?Q?uQOxKQQFPYdIlg78EfigbCw5C11w5X2LSBxj+R10DLOATYOQ7D1dHxsC/y/T?=
 =?us-ascii?Q?h2sCT/46pQFcteldSJoNhky8/7Ayg4Cf/OlUEUHvLan/bMgeXVu810b9t6Pu?=
 =?us-ascii?Q?1FIDu1aEf6ywPnzc05d+Uc/En42HiHOYQIYvu7AoNnbOpG9XQ1CrUti9wkS/?=
 =?us-ascii?Q?7vxYE4Yfh0D0R4A5lgQHtrbyn77AW4rDd+d1zpPOuRq3xB230Yh8PI9Qi5lz?=
 =?us-ascii?Q?FptP1rGdQmVH2aOTawqAvEbqEpAIjXpJqJO9ILAozLxJT13bdpJbPTt/uGUS?=
 =?us-ascii?Q?sJ8T96KYtMWH9rboJjrc9krAQvpt5+S09G58ETZm/yf5CbDE9o0IXZ7FcB7A?=
 =?us-ascii?Q?k20xNzQO3LQgEsrvJMEgQeheq63CKxeD7eB/MX7zo+DZJnx8JajkOUPzTnJj?=
 =?us-ascii?Q?AmZ880CaRua/F14Ir0K7YAHbD6VVW4CCYdsjCn+x/a4jWZUhTsjTQgnXosUK?=
 =?us-ascii?Q?hpfR0a9bOQAAmFS0lU3rPj/fqZx+zpFBr96YiIek5mb4D5GYtF3SW2P8VGJa?=
 =?us-ascii?Q?bvXUzIV500Sbgn8P85oJlN7ECZ2fBeediDTJaSNYpfjXEBlv7NYUKLMGG19e?=
 =?us-ascii?Q?eSiW0I4rgqyLFSI6Q8428DltvXXMC5n+xrT7aHRE1t5a9iyiuSz1XR2UQEDV?=
 =?us-ascii?Q?+i/CoFBWrhzJlSKEVcLAbTDEW7KH3rnxXsEj34hNqCzpgdUAF/WMfgjryZvR?=
 =?us-ascii?Q?Wihct/C2hOcnSwJcJmqHUSvmlp1Nw2hzbmXHNBp3ku/x/LeHnZoJyYQFRvRT?=
 =?us-ascii?Q?7jgo7mxH0CUFcwb5QvZ35L4be5sxqmXdJHdJuDPFSWHu/9Q/fLBWy0TH8VGw?=
 =?us-ascii?Q?JT3HJkkAjhyQ9HpPKiAPlzrXtT9pDy4gnUZHc11P44d91uCzI95R+nb+iL2I?=
 =?us-ascii?Q?3CokTpbzqAS97xTZyYEREbi5/hArb8MRXnBVJCglyKZXEkwF0EkHQHkb3hZV?=
 =?us-ascii?Q?0wUPN99t3VxwZX6Yw5wPfe42zEUafg+xK4Jsl6r6NGrjB05FO3R3RwEsDtJr?=
 =?us-ascii?Q?ajtigq/K3loYmMXXBjQxuU8gd0wS4VlRdP/m5H9I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66292676-5085-4ea2-ddfb-08dde576cb1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:34:13.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tzrs2Yiq0OcryKV3wbZ1w/fTW5Z+wihvn4sn137jO0QgYQwCcUfqE+SB1qh7ZyJzDuOgaXpSfDXuKcxcs8EzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

On Tue, Aug 26, 2025 at 05:33:21PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 09:36:38 +0300 Dragos Tatulea wrote:
> > +		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> > +		if (rxq_idx >= rxq_bitmap_len)
> > +			return -EINVAL;
> 
> Sorry, missed this in v4, could you add NL_SET_BAD_ATTR() here?
Yes. Will send a v6 soon.

Thanks,
Dragos

