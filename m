Return-Path: <netdev+bounces-222842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55ADB56764
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 11:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B4817A6E0
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453121019C;
	Sun, 14 Sep 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVIcnQln"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC21FF30;
	Sun, 14 Sep 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757842556; cv=fail; b=bGFUGOxusPAS5uAo27FdNoXDnxNNli+A40B3hoAPBdVVloZCcJregCjDcZI4s6+atn+i2uVvPsg0d2LwIncFnWyYBKvURb4PCiLysHREAsrlhOTWrVd8vLshYQlO359u6MLDOZL6HFF0LUnlafys01iWkRzZCkqndxhVIbAvgK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757842556; c=relaxed/simple;
	bh=+M3CK179e3HOWdZBJnAeUib1CagJYR6xnhGj5grrIWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0bXJ06cAVPb4R/Zv/HFZrkcpysdizhoJMu26Mz2tV6LVcUgXqZ7iq3fj2tvSytwne+qKCkRnp2Xhp6DwHiycH8q7l91EsgMkvFwk3++I+Wy+bxm98P/0qACLhagEGBo8SzBPasksFTulOQ5QrcKD9xTYj9XxcFFnJ1THp7qkNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVIcnQln; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAm3WcxSWeNFLrmKCyMykHBGiPP/RbfwwjtFfZW658IEFGTobuzwcDQtRrxgw5TlxhCt+odPDEYvRI37kV+MbEeWwzCTHI4WzLS9TrHYLq+k73VPTEXsdGOmo0JyObT8tDFk6a7aEc5BzIzr4+LaMr7Ht+pkaEgfUkF6CAUQMf2X2YSrOBngHcGfD67E9L+n/a7OGZ0ldSs6WfUel73dCcuuMdrCAe6NGxWCTGAaBg9v4uyUimSJE+frBvS8tLzidCdsa8Pr6aSZCpIfSxbZ5Tg6uR8vAMULeFMCX+fEDGHlZG8W/SP5EUVZXDQa0mXtqZST/AJJSb05O5leUl06kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbN9ifxozAxSI1EAEIhfRByoOSyaGKHjUZ7M17EOyAM=;
 b=KJWJQhnXJRuP+34rQD6tHZ8Y8J4qF58Y2xS8fhzHqD+PxySFFWgDCR5p3QfilFBhzR67ZZtOqNfMmVZDJjssgFmDcqdIflFxwGhWDsH4SNViqG6UYtKPE8Akq7mff6bL3uotAfj9CU03RTzydx0h/qSbpyS/vQABH6AKwCageBZ8Oee/K6S0P27WWYsJsEPf/VubMwTIAjXSIbsxSfu/oISAUmy4nUfpxSPfPm6cR9/ZQ2cmYfS+TK4fpEui+zURzauv3uTWkRTxO5JPF1VfK7qJ5dZCkTAkKz9X8fzlUsQf8qnGpaGlNcHAR9E91ZNAgOtvo6b/Q/9gc1eTzjJYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbN9ifxozAxSI1EAEIhfRByoOSyaGKHjUZ7M17EOyAM=;
 b=LVIcnQlnkjnF8GPhIagSKKx9HrvjUW4sE1bubjaI8UZwXOQTfuOssVYSWQdBssQMHTlNDTEzogdCmrM3U8lyMEkHxRLwGhhAEuYH1m+mS5kHdoxQL51/ilctLX+mer/1ivtKRV6uPFPiadeh3zxL3sXZPVgZn9vYlry0PtifDxNqj/Y0go4uPplWW+5RgTUZe3cg25/yn631iE4C9hwrvOEZls5fS8xdAnRB03PrqDxV8tDpN2DUlGzodCcxjgKVTUEKG6vGw46EWeWxS+pE9Ly+plDsV8+6NqAJQT1a9DCY4Zf1LT9rSLanxtvPxHUYXInH20gK7SF8rUsoPA4WSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sun, 14 Sep
 2025 09:35:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 09:35:50 +0000
Date: Sun, 14 Sep 2025 12:35:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_cnt: use bitmap_empty() in
 mlxsw_sp_counter_pool_fini()
Message-ID: <aMaMaxK0_3XuX_PF@shredder>
References: <20250913180132.202593-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913180132.202593-1-yury.norov@gmail.com>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 732de3cf-cb6b-4ba7-c36a-08ddf37217b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDl07cJ/kWdaFHvIRkXEFRUGMYwHDznS9zHOSR6vV1Ffxv0HfKaGiOrkpIPj?=
 =?us-ascii?Q?A59Hvz28dck+UxleDBPC/JrSJjNdpkWmbtg4oJMlwq6ZgChY0hN8UD2+eKKm?=
 =?us-ascii?Q?ot66qSRHvkOGrZgKPvP7aggCbXnag5vzy0XUIlcfwNMDB7j//S6sMcM0ZXCK?=
 =?us-ascii?Q?D9qgzol0WEmWZAN1xY/Lbptl27rdNqVKdjT5RFMHTHLYpl14d0q5fzd2XRto?=
 =?us-ascii?Q?/7C/SIv9nL031VHRx969CrT4/cd2dMaJLXLsoaE+GPJCi2RA+J1VKd3mxd1c?=
 =?us-ascii?Q?6u/SMXH+nBRJq5JcOs/X2buk32tT3eFe9LPtK5QaCR2x8uoAfXbXnPFP8yvP?=
 =?us-ascii?Q?zkPV+3mwxDCqTLpX2oMmxJ+JJQNqi3t8Lcuz+MAASTs2C1197UU86EURkfDd?=
 =?us-ascii?Q?x8xkNoGqAQMuXwZYUShktko0tdkBZ2mCwx0zE+kXleP6ufawfz9afWLQhsmp?=
 =?us-ascii?Q?QTnwypPP08YC3ucC43n6KXyfXs5CJXayK7Xwp8KRNh9rAQKNuKg6y9tdh89R?=
 =?us-ascii?Q?TVD+2+cTAMclFHTaw4JXMpY5q9oCNRU3olZYgwKszg6exsnCp0+BEFWzrEao?=
 =?us-ascii?Q?gLubMMzsf5V751uvvqzsva2xGFAsIfaMx4UHhaVXYXbQpoc4LNgukXRSY1TD?=
 =?us-ascii?Q?yxijWho9KRDCMV5OFyHiAp9KYnW3oq3xPm0YP4Ah0i+7mc8S4nEOkVA5KMXa?=
 =?us-ascii?Q?BPeNAtaSQJyO7m4/LTuhVceSgJTn0vT5Bj3oWV0yhoT4wgxmcl8Oa/e9eG9H?=
 =?us-ascii?Q?o8UIfxAJDvqdwhbqp/DWvwV1TNtyuHSUPFAwlREqV+ycKh43AvIscz2NmBoa?=
 =?us-ascii?Q?Ote+PW0fpYnG97yXP8TgjjBARPcx2LpdXEh5+eL2v75Guj4xx89gnxSt2Gtt?=
 =?us-ascii?Q?URJtWA1KplMnLG/gURDmaJ4q8n4XHoapbGTW9s3QTrKsx/JuR/RjK8GPJXSP?=
 =?us-ascii?Q?vFSY6ITfQ3VaHPMonhWuOeARkD7u/wUj9/2MjK0tGoC9Ku4IBYEXTg7PLOQo?=
 =?us-ascii?Q?yvq7CCPD7T9sdMPYZPdnb5jbKkxOcekNSIktXWHSg1iuAzWhEWpQnKAw7jw6?=
 =?us-ascii?Q?n7f4vr6362w4pK+2JXVDMsXWe4dlYYgBaB5O252iuYvT4h0E4SJnPmvQUdes?=
 =?us-ascii?Q?Tg6z7fV6FfgT4jdj8W1VFx9MfrvOj7x4b26gryRh81kP2Dm0XyXDEOr547s+?=
 =?us-ascii?Q?fi2xGvrqdUASmwC5xwSQj9edRtWzbuVw6QDs0MqriKY2nX8m1qo2c4+LgQyk?=
 =?us-ascii?Q?GOOmMFFKpUCppFP50iBsprtyp8mMxKU4rDPKjbogru1Pt6ss8vBk3tbZ4rO4?=
 =?us-ascii?Q?yKclsfYH8p9m0Oqnv00DPMdxN5JHcWUKkZucpZ2UwiUYWkC/GHyyYCeYlkUc?=
 =?us-ascii?Q?45XwC5g7Ow9hzrWF8YvOklhdE/xacCBG445wWb91rB1g2lnnmXJck8ydq5C1?=
 =?us-ascii?Q?Au9oLKbUhGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IS3AexePmhbsLiCrTuhocllBbVBAMsMTXieGftU8UKoP5A9rjtskCrRYeT1j?=
 =?us-ascii?Q?Yl0EF48H0R2w3FXTWM07dd4GJB5JIV78Br0JrtbvIoJffBzj8yAU35EWyV8J?=
 =?us-ascii?Q?sz/XhwZouXCXaNruHDs2dJt5SL29uOrdRj4afI55bdjTdeqIo6fFTcuPTkyM?=
 =?us-ascii?Q?k0cZ7YIQqE2wLscULTDknOqRCXn0AzS/g+h4t5tPn3J3mGRk/0UlX6nUwclY?=
 =?us-ascii?Q?EcgrKc25yYxiCrXrB3IVPDohFJIXUeMH8WJ7imPUwPR5Co5EYcAhbpP/aKMO?=
 =?us-ascii?Q?bm2rlt2+FkDH3cM08VqeaE9SadU5XFy8aRIN9H1qs2nN/+FUzicGuw2T/j7K?=
 =?us-ascii?Q?ysGPMe338VzKgydvHIIT3wHC5T2KtrvIueeHIFGz4BMUSXqxfb152gQf6DDL?=
 =?us-ascii?Q?SUH8bqLNwFigeFiGOzmSw2qKJoIXJ+JFO9XCl604naphAnyUWQBtJucWx34y?=
 =?us-ascii?Q?tqlQoBMkUh17QcHdcdMCuTzocZqVZ+JMcOTMjSbb+0rcuroClEJePd4E25n5?=
 =?us-ascii?Q?dkRSBrM6zVuqRtnEIqJUlasjjgxcJKN1puwZIEA3SWGfXEhTWSlMl5GoP49Y?=
 =?us-ascii?Q?1k0XJ8FtxWHWwQZv1MX2qe7xVbExg/u5SaK4OeiZxl1dZO/fhVNwY9vUi+dz?=
 =?us-ascii?Q?qiyq8D9JNsu8g3OfD8Z8jmoDHJ6h7+hEMu3D4KUdif64EXi5IVqZ5f94/q3c?=
 =?us-ascii?Q?zDsYLef1CRYaMPOYXVb+K8a5zIwOVCe6qRX3/uh/0PYLxG9pToatrLtbojw+?=
 =?us-ascii?Q?1DmGCP2AQmajlNKhUPsk1A3rD/d7v7tVOYgC/Gei+zD4opKRd9IGtCVmjiTs?=
 =?us-ascii?Q?YSO1Yd+wFdAWXT96CwJV09APc1L5rPCXm/bEY0yZAG2XKZmBCFDLFsY8+mBR?=
 =?us-ascii?Q?y6U6/igU2mQT6Bl3XcJ13aL9axRQYbQSgy6XM0LIeA6qX8qPPqjqcCYbspNx?=
 =?us-ascii?Q?2yLH7MxZzys25eXBn6Ws88rD3vqQF/0HEDGpFOaNz0xzcUKW0PAO4UePxFth?=
 =?us-ascii?Q?by+hYB0keAfNsFn50Nu8eFY0wfoazdyaTHb/0l901hSuynREgjcaDia3iP0k?=
 =?us-ascii?Q?GDZMIfar6GZhshCwAzxZi+l8KaWDhxnX0WQ2HL4qZ720ZgFXb+9fQ1x6BwBM?=
 =?us-ascii?Q?MqH2EdkBg5IXoEXqHCIqnxgiDrZ0wkM8jC7ELvxpOKiC7vxECr/j9EiZ28C/?=
 =?us-ascii?Q?D6acoi23ewBdnzZywEUpvfHLLF2egNyA5gmONvSLV92igjj5sHsvsteKPynn?=
 =?us-ascii?Q?vIHTzldk2QW5AUYL1QXW24HY35mKniUMd3cjFJ6TUsJQjaJpgj9rXcCh7TRh?=
 =?us-ascii?Q?p3h5cS2qwH26+SdtCypH+E9sPKA/xpDOf1RqzPV8uL5Xbk1anS+xdTGkfXWq?=
 =?us-ascii?Q?jLolEfb4+WuTXAPab09XpNf1JNDdI9mKggSMDrAv2s6HE8LFnGEvBh0t4eHs?=
 =?us-ascii?Q?yoijnDI6TkLUWR9AMDNrCRjq0cyfEk3lMaBNIYr7SRuru0cWXBAwXCdgTz6F?=
 =?us-ascii?Q?WiHpweRsmtjmcLjhQa1QCAqozqNy/9+RLpKemwx+ARegATCuSXet2GLqrZPm?=
 =?us-ascii?Q?aaElx72xp7Q8qoDQhFStgnMk2wY4V84MnU+FWfIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732de3cf-cb6b-4ba7-c36a-08ddf37217b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 09:35:50.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uQwx2ed4FLcHqFeelbyvUnV0HxYffCQY/X3DCSn7iuj5sYjCcURstMJtd/aMrjWGvVYTd53J8bfADwwdqlqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

On Sat, Sep 13, 2025 at 02:01:31PM -0400, Yury Norov (NVIDIA) wrote:
> The function opencodes bitmap_empty(). Switch to the proper API in sake
> of verbosity.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

