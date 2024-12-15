Return-Path: <netdev+bounces-151980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECB9F22FF
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047827A0F65
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7D1487D1;
	Sun, 15 Dec 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgVmlWFI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18021119A;
	Sun, 15 Dec 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255326; cv=fail; b=BMrk9XJJhr4Jrr0KooX1xoAZKoYIBF5YCKql+1Cd2+SG3c5oPzL4jroqYUiqEDIjXJm/cQdcfaQb8ClABhT0RV2nz4NCnvf4TV6qkGk4MiASrYBSwET0HDmIbBes9G2gNj/WDdYv5R5YnKFecr+Je4VncDljuT9+y/byq/Uq330=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255326; c=relaxed/simple;
	bh=g2On3w8lBHo/L2GXdjtsT+/wfYTOofPt4Yr8iP8O2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F4M515jno9Y7Mak1mpI4tx09Ob+E/HCoB65/kcKR+Ac+D71I3fjA43e0rex4o1Y29J75aqsCrNR3NmIix+MMHQ7vNIbbHiBrCLFC4/pLTYQxMo0yODnVYcKJgbY0CT+c53oxxG/CD+p0fqTVnwNbFdUtEmGNx2x3/UdfPE7UxVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgVmlWFI; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWUfEq5dj6XGpjhl+7xnOTC3hej+69WiV/YpGrdju1nXk+SG3sbX9HT2eM85Lj+kMEiKWnCoK4idN0sPZ9Fu2FgLjlWGHzMiYhKsnHRQ06YzFbgkE9mRoMbHif2cwFJWVgfPCgFuEZdrRMjIFz7clGbpmjccvZbjEjmzwJYKJx5opdV4TKSsLixyPFegaqWd1vYJMxae+qRNd05NrBji6gQ1srTWjn6p4sUybAf4Huio2DLslLvUVceAL5YiJkK7Hcbyw8PhMK1xyYjp5Qut6wRoQL9RB5krh3hKm1ychzhX4KtjpGIR9JwysYqSSGsXW4A5coK9f6CwCkjuCISyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2On3w8lBHo/L2GXdjtsT+/wfYTOofPt4Yr8iP8O2fA=;
 b=EQWD+YBNUrpzCLV7iVOBGUhVwvnEKFTb2v1+3A0/nSbA9lnWPNqTLUrmeM3Vx+19H9ZfXJCJZwspvoaCF5tICgwXZ/TZPcqU6oy2+/gQGkK82C4eyekSrHAm78sfO0xEU6352K/cWajJg0dov4Z7Kqm8tLZx8Njbuvw7EuuEqnKwSGdQ2YsNOQ0UuAbHSmKIItQ8ILAwiXZ6ZNhSZuRwbg5+cIEoZ4c6RllhCWyFiF4ngkktLKf5G0qSNtazocCopzrbZKSKGn688k9W8z9zpyHxBDmB1rHNhpnt6BM/MxxQ6Ru18iwM9eWIR8JN2dtjQn7KfHfR8EOQ9A302M32NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2On3w8lBHo/L2GXdjtsT+/wfYTOofPt4Yr8iP8O2fA=;
 b=lgVmlWFIb/AASyutPztN2rBCAwr1QsvcSYfKviHYMwkKlZh13ySs1TUTZOa/SOjPFTJMq07c9nIBT4KWyQRur0UT7bmWyYP5PKnD2FjCMHh7LIUNXHzUnnH8BeMyKbVV1bZpqQypqioakmK7sAB7BwVyRGjPEP2phaEAZOPCw/sOwcijnO0RKLynxAveq84D/fR3XzjfT2sHULv50nxNUykFlern0p7xr4km3jCiE88z0+SWSvXBLFVKVeTbpp+WOZzZMY/hlhmOczMIGdZ0SQQgzQwfqSMwnBYd3IwhdHp/Q/wsLX7Z/BkgYv1CBH20Gp4xh1kIONYflbk8g3OiLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sun, 15 Dec
 2024 09:35:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 09:35:21 +0000
Date: Sun, 15 Dec 2024 11:35:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <Z16i0MArCT_46dKa@shredder>
References: <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
 <Z1mmnIPjYCyBWYLG@shredder>
 <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
 <Z1rWRorUo7ivWJdO@shredder>
 <3bdc6e3c-49d4-46ec-9c36-85e324e5e2b4@bisdn.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdc6e3c-49d4-46ec-9c36-85e324e5e2b4@bisdn.de>
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: bffac5a5-16b6-4591-8242-08dd1cebcb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gN07Z+x7r9v/EvDiQhJkg7Nf4BWA9WOLTCiSvDZufPVEKvkz0CoZ5r1FhiF?=
 =?us-ascii?Q?KdJbibLlz954ZW2snOXF5zy2evf8dmFvzvrKTvyURXaRBbRiElg1Q3S2BcUs?=
 =?us-ascii?Q?4XznZxxsQ3AqkusUc8FiX97Lel8g1tR4CB3ALPeZdAaX26tUCTsgNZadppQg?=
 =?us-ascii?Q?CfU91/qAqr1zv34hyuhHEj+Q7Hk+GgIK9d/4xOMBztMLdGnlt/aWO0AyEW7S?=
 =?us-ascii?Q?mQhzWKY5da9PDofCDSscYJwal3fyhzxfjL3L36S1Yzw3JNMR2/NBkitwxIRY?=
 =?us-ascii?Q?6gLYKUqH0Wt7mlQEbsASBce54KtAMwh02t8qOvdKtwu8sX8hGsaWxp5qTEND?=
 =?us-ascii?Q?Yy6tUg7T8qO9t2Z5pPjeUrlu5my4Vrqgw7BUFku2aXdAGeyCGF+oxZZbEPqT?=
 =?us-ascii?Q?75tWc1HHDr0p2eSL96vDYYriCNGGChh2Z5oKfh+nt0LYT+TX9UjwgNztRm5i?=
 =?us-ascii?Q?v0YuZ3C8pPTs4p3I5Li+OiVjv2Y5h2vU7noSa4PJ8CqHrrb+uSJstblUB9S+?=
 =?us-ascii?Q?tBo0iYxUJSX6xWxc6bH5zg4SK4pAxeSC9NcBBKvSg6zLeGJiX7gbU9LzUH3x?=
 =?us-ascii?Q?rbfx5F80aWNGJMjCF0VaAuiBSm/T6Ekc0AR/sP8+TeXrC7xctRCFDJ8NZLag?=
 =?us-ascii?Q?zqNzrtmpWqUlJBRXKJBVHulCy609hxWoSBKnOO3sFaVlXMu1s5TRt0Zg5cUB?=
 =?us-ascii?Q?FDdnvjnlCc8F0Bav9MaE81RTIsbcpSsiSH4iQdMQt6wncxfIPfOSeVU0RKpm?=
 =?us-ascii?Q?QSVUz86uPjgT70i60JR7w4hiW+8nTFRpxEFOHXZ0qMl1LpSpdpAbyb2YrZKw?=
 =?us-ascii?Q?QLoMRxQEZaG7wWaZ+1NLoMaZSDE90gLjG6Brpu56nKpRAdyWDIVp/SiwKFej?=
 =?us-ascii?Q?c6H2ZIjAGdk1+ST7/xSN4e0Qu+YbpNiVy+9Xy8PqHyPyZ0KQx7ODyLYxWxgV?=
 =?us-ascii?Q?t6EGdrqCcZpQ3Em54RTxjH7xFXgh3UrNUu6qZC2IHMaRTWZidYtwK57aLABA?=
 =?us-ascii?Q?OzDuRUA1qaju7edqIMMifF5QJf/L7Kog/vIBpBx8GqDQ777ZpTHnAwTK1231?=
 =?us-ascii?Q?kBQJX4MGCG8X4GtrkFJZTiXaocK9RoZ4ZlA6Oz4NK1FCae336EYJrGmSUZaz?=
 =?us-ascii?Q?s1UT/bIgaHN0U85AdH5JYfcGgCY9GL7x+bTaHy4H0K4jCDbA4Zpl6G5QxESf?=
 =?us-ascii?Q?OgAekbgxMwqILyom9hxeHox+Pa7HhayCJi37zWMIepvdDbtOXrzKuMNJAdwF?=
 =?us-ascii?Q?TlwvcmejDLmU+Q2S29Dk4fzS8nXv3/AtmDxShzgk05jjKUIhnlbgrl3EwvFa?=
 =?us-ascii?Q?Nbt1x1sGkSlLswA9B9BT1lcmWez4MR6ks5YrnpQpgvcfaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/7vBCw7PB+QlACBqw4rFDqrp/Pyq8IRqqdbQtQ72ad6G7ju1gIWJbZFwoaV?=
 =?us-ascii?Q?FmHsgWaQW51JZYUK2TouYP7s407N0EtVzPdWYEjD/q4iad8XlgFuU22A/G+u?=
 =?us-ascii?Q?t3esqJW6d+wF9w7knQRTR7MvN2S6SyI9CHMQD2anNVOXa6JNKgQYLtDBMU2V?=
 =?us-ascii?Q?jO6an1oiVOlNpxQcLI1jo045aLhwHf/WMmGP+9QjW96RXM5qaglG6dyKDo7q?=
 =?us-ascii?Q?Ul2IOzGpDL9WqP3jmRfiuqkkHzezAHVb5hEDssFq87ehnD4flfwq3bcUjuRX?=
 =?us-ascii?Q?E7rxUBcm0qq1Rg4FjqKmsU5ql/dOi/A5obVaIeurmrgCoXB8SXpvHEXDUo+b?=
 =?us-ascii?Q?xXZ1Lr44FdEJY+GT0TvmFMRLcyfo+6U9NnGGc2lgaxxz1elzUH2fIte4i80o?=
 =?us-ascii?Q?ItbsWPEAJhPzigaEAYob79TEvkn2QO8LHHJmJMHz8TDcVyHPrp4IjSPgU/zF?=
 =?us-ascii?Q?zM3r0kMxTMSaL3tQYaxcaRY9YKAfkOKlvJ9ymPNaczy5z0wwDrDFcKuZDuFH?=
 =?us-ascii?Q?dsauXCqQj82qtGPuAHBffiyNfL6SXpSdy+IUYn0v0HFLehDpSKF5Pn2Qmahe?=
 =?us-ascii?Q?vjxqVKXceqDeMbEVNeG7y3xAJ7lsVXeNiKZkXbZ29ahSQ16g6M8mdMa9DOEU?=
 =?us-ascii?Q?HbhEd1TtlCFRkS6RaOPpgypNkfoFB46Tlsw1dQCO/pvphugxjsIRrghsCtq7?=
 =?us-ascii?Q?vr+3ZlYYocb3nacOV5Z7mSQOplKveBBi7AB72MjZ8Lk2pMHsm/5zZ/TswxiU?=
 =?us-ascii?Q?MMvpbp5c4ZvJ3f0DJuDyi/T1aCcuvqbux9qwHL32lGl/JfaG3I+H6wbcDhWU?=
 =?us-ascii?Q?aqJF/MYgrNyvC5H2tVlleZ7i/YWHCa7PfJztsJrxuvc8LnDTq/eoI3qDQbQ0?=
 =?us-ascii?Q?j7ML4j+lw1zFmkSZeZNDy7PORxvezg1AL65e8scqDGVdsN50fHotv1DzzSvn?=
 =?us-ascii?Q?83mI+tGakJPY9UkD6cgZDC/S8ZIJkh7oz5XjcHTCjmtiI8VGpcmg7y8m47rj?=
 =?us-ascii?Q?qepbIGGbiVZwA7lWvR2FrF02rXGoLAJoluOx0QwfGZT7O+vVjGWUfbd3DzlO?=
 =?us-ascii?Q?BXFpjVoUkD5JXg+PM/wO50HrVFYwDLD4DUXFTL/CT5mMO0AJsk8g5IuPU6sB?=
 =?us-ascii?Q?ZtdYqQPBbHs2QD/AzgMf3B/dskDtZMiqCsknsiCpKAa1mrn1lfdbYv5pWtTl?=
 =?us-ascii?Q?ORSyCLrJ90bR42SsFGD38+R6EfWD9EAIiEw3Q/jUn09Y2xro0w3w0NNQg68e?=
 =?us-ascii?Q?XN8u9ha5lGuWN4PM4c7j+VAq2O+gyGELDIJsNHaw3FngzyIv7fHItuoOH45i?=
 =?us-ascii?Q?7tI1VW/OEaGIOtLCgQ5EQBYS9CdP3OqAw1dD+AxFDsa2rBOV2YztT+7LTuHl?=
 =?us-ascii?Q?vzqrSC0jglTJNGE+oAAFTptJHF25+Wtzx0NBSvlC3oeget6El9ow+DrRTGV2?=
 =?us-ascii?Q?NccVPzCAvKNSVHLDw4SURcS37/0u3Qh4VieAnnccC0MP+MLPU8iFcWKEGjVF?=
 =?us-ascii?Q?DGIzSQLjRc2FAOu8EdaQGyz4OR/RqEuAAIodjcJm3mKOAwItKJFuteNzr2eU?=
 =?us-ascii?Q?CNZYEwxZnDt5k77QOYMHRo66Em6cWKEyhQtOvtHY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffac5a5-16b6-4591-8242-08dd1cebcb6b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 09:35:21.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCb+VtiGX2tkclzzUOKBZAoeotjG11daDtI40mtydQCAsU5O0QnI2ULtPTiVHhJqdhmLL5n12gF+vHkHRU5z9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

On Fri, Dec 13, 2024 at 12:25:20PM +0100, Jonas Gorski wrote:
> So in conclusion, I agree with the original patch. Shall I resend it? Should
> I extend the commit message?

Yes. I would use something like:

"
There are legitimate use cases for enabling learning on a locked bridge
port such as MAC Authentication Bypass (MAB) or when user space
authorizes hosts using dynamic FDB entries.

Currently, by default, the bridge will autonomously populate its FDB
with addresses learned from link-local frames. This is true even when a
port is locked which defeats the purpose of the "locked" bridge port
option. The behavior can be controlled by the "no_linklocal_learn"
bridge option, but it is easy to miss which leads to insecure
configurations.

Fix this by skipping learning from link-local frames when a port is
locked.

Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locked mode")
"

