Return-Path: <netdev+bounces-158577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C22A128EA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47123A2FD1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086741553BB;
	Wed, 15 Jan 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h3AQBKwp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5495143C63
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959266; cv=fail; b=JhdX7zectgVPDgHC9NhmE24JCXtDP6USHXLhp8dt1NGUYIkrP34HBKompM6UoZyg3lsxb3LTHOx7OkDuN5+x+MTH5DNHz1ubXXDxzMJrlmvQ7g9vJa/ytVWWMLOs4X1TjrIICmqxbXF0pJY9r0zb2lANgTfLoWZyZ4Fxjyuk7YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959266; c=relaxed/simple;
	bh=xmh1IDBs2tPOP5PX+J7WnNQbFs82f89oU/KaCx8sUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxoUslPdER1f9WesOMo6nP5BG4wVPm/c9K7Y2xxi2e3udnm0lpd2ftQS4QhNI6r+2zskcnSx0Ujgs5u54ZHs0IW87w+ujFT3n1RWdt6aLVGvJb4pamnPc2ToI9tcsOLL4+0Waa2GjqxWYiWLigaNc2MxuMat8+aENqBti1mm4S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h3AQBKwp; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZVLKBzkhOap/8npirdxAUGje+MU2aU2AaFDeufZxYFZFT9F8jjSfG9H0tW9wFF9pdwg2QpsOuQlbI2Dq0o5FlxEbzZxReTRzR55qMKEhAC5XcBz0UdbeCkg+MN2iTPlj2R310yj2pCLtgoECTegSbsr749YrFWlfil9Bh24ZmTFMsWaN5M5/sLrXLrW2QBOPeyYjv6cMTFWklLF4nrbkMZUliphoeBaVq5kUdw2OU9ew6R8S87giCVaFkb00ErKduZdYS4xps1xR3dGrW1TT8iRSX+bpJ8Fl8jbFqhbUI/XEpN1qj8aj4Pn2n47WKTlE4UDbtIuMYfRS6S+S3WTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj1K2cYTUiuq+91ecL8yjjAJE4Lhlbhp+fsWaVQg8vw=;
 b=AUzr+S/hgkD7yWPPal0DGmhDI1mLcQN0YDMEAqp3xP3H/pbeP/nHmvFGSr431rtxB1iUbAQ0rJWgFuX9+L4EMOVqEJcB5Z2oKOUGJKWJ0/AHLUs8uIssm2KC8/5j/C80kPdt855BbFTw7XJ0gFqsW4cbEW8+c2azvkcuqZL3YUq+BHxeDbcvZcnSig/48if7sidh3PZeSt32Vy9efDtqvWkN6ZORFNL0qDmFTVoDWQl10Gw5rTdtTpvncw97jUn/b+xPs6k8YpcmocueImrCsa69GQ2FV4vPrLIm8hO41n5cf+6OLjYaCvafpnjP0P6owyK8ksbGsd/eLv79DsxRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj1K2cYTUiuq+91ecL8yjjAJE4Lhlbhp+fsWaVQg8vw=;
 b=h3AQBKwpQsbiteOK5E9uOtQu+/ACBsNpoN5O5gxQw/RCIiE2rEwH41Na2VFJ3vxgBIgJ5z00mLTlD+ESC3GhLGF7rhV82gGn/X3zRPelIOrU05C9zHXjiyuo4hi2oFVmm8RGppXYPtUpg2SBd0XYhfFn1YdtE3TUvWo5sqDMUviF/+9Z9lN9WynsUSNMIVdU18QTitqlQjslEDMDzZuiw4D+JX8/sxrxTbW1PmrOrKTDkwth76BwskvCwE0hKhIStFUP1krhTMg6banOWuBRyaBklgDMvg0j9bjjySru/3iGlhJiM7Lf0MQfxhp3nP44TNTKT8lVmmaN9obYEgJK1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:41:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 16:41:00 +0000
Date: Wed, 15 Jan 2025 18:40:50 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] ipv4: Prepare inet_rtm_getroute() to
 .flowi4_tos conversion.
Message-ID: <Z4flEv2n52lxrTED@shredder>
References: <7bc1c7dc47ad1393569095d334521fae59af5bc7.1736944951.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc1c7dc47ad1393569095d334521fae59af5bc7.1736944951.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eb599f-cc13-4c10-bd07-08dd358364da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yasl1ribXlBD4M47ZtWtucJIOwmpKq1ebdH0yfsTkbjFC4vtNTxZoCeOB+EY?=
 =?us-ascii?Q?kygM8SjWHJMtDYWbNGF+gcwAsbXW+ASHKduRY9kH9/UJe3UKMw8lFyeHURnE?=
 =?us-ascii?Q?iTUjnFMEIrjrG6fc2NvjRrvpP2ow9C6ZyYHdWSXkO8XRP9UId/oN7dufpQrV?=
 =?us-ascii?Q?/D4qt+twupuYwVI5NNMerN82PA/SSVJQ2DtnSGIvtcGptzhhwHIjOeBiEFGO?=
 =?us-ascii?Q?hiUYzy7qvejzQWMHc134nxNOckNDCYr/YYtrQkgTY5ppKegrUECF1tIgbsXn?=
 =?us-ascii?Q?fia5wFJNiJW03/EUDcfMkQy0jeUZ2XxFYUgvncV7kxwR/uAQYSInn5P7MNVJ?=
 =?us-ascii?Q?pivZVfx/OhOEBXXlKhEHwl/KmuLBzH4U7yLLgMaFgJ2CNfCwX+O328etBcte?=
 =?us-ascii?Q?cIGHK8YNSFMZcr7mXcZ+iwFlFH3sl0g39dU93wO9cGzBc4ms4JewBAEYPyVw?=
 =?us-ascii?Q?DVUdRspRybmmOf7wXNa4jFprWGXt8FEtSwXXBhZtJLRzNgJ7lWsqTRP7a6kT?=
 =?us-ascii?Q?UgE0TPTmp0V95dlEIIo8hXSxgc4u3B05c7muLv7vvuD+na1sltrOYT7TehXT?=
 =?us-ascii?Q?dAC6g5eJ/l7VayUaVRYTY02JrONKC+0Kb1hh3UekYd2iJr3B19KM1zK30gBy?=
 =?us-ascii?Q?6GBTZo91D+G2Jmoz+TXU2ZqvN7Si479vjgkMJuHHnqZkJzonSOFbTdmwQWD2?=
 =?us-ascii?Q?Qd7xwM5pU6jUnN+HZU3fJe4zw6z5XuJHyQ5BBNkrDxEr0qpG/gkTr1Vu4zYY?=
 =?us-ascii?Q?VegBlM5JzBU7MpgxCGi5HOX5K3UORXxV4E19Q6wDfMql7vNlpDWG2nphA0yz?=
 =?us-ascii?Q?ML4Kp9sFe4zCiz6/oH/iA/hlt2FRGPC6HO0ZZe4tGwnlJC1qIbI8zLo3UWi2?=
 =?us-ascii?Q?oMeem7TIUBDDAxjF08NHQF0UqyC/92xExwVkavovWWqBOW7TNxUGF47krj6M?=
 =?us-ascii?Q?b4bOVfdJ3BflattIYi8NM8KYAY+nQcaw8X+VYsjTBOihvcwEm75Ktcdy69af?=
 =?us-ascii?Q?3GlM08hGX2YPLw0bjiiL8d/4J0/Ucw43ocjjZNxUgNt73tl/Ae3x1jGM8J4C?=
 =?us-ascii?Q?6FV+v40TWgXRyE25gru0rE7WqQh4jxB2mcsAL19ZXz6ySncQdndbwvD1cj5m?=
 =?us-ascii?Q?A8pzSg9Dfaeg2Zv+1mW683uHrbtCl1N32FouHERe2gPwmJNh8I5+mA0UeHrH?=
 =?us-ascii?Q?QFUJN/K+8iGC8kPGyugl7g9h25ZyCWVwpQL8Exuzc4k1KcKmxovKTVk+PrvH?=
 =?us-ascii?Q?/65eLi02H36R4ExGcLBViZD/Koe5ER1UDayHYYDsjmOElaebuC401KDmrhW3?=
 =?us-ascii?Q?iXF+WUBsXKb2rqs25RsGx0A1zM4TIzG9tEJRP0N1yKEW8/cKSIqXW0fBAtfV?=
 =?us-ascii?Q?RwGBF0gkl54H7AjSEkZqLElZry6z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jIGMmm1Xru1e81dSSdFPm/YewFpBd8oewM4HtgEKQMOrjUTVE+9y8qG96RP3?=
 =?us-ascii?Q?qKr9PpaV+PerW4mHaBAl8pjFu9QVDmuJTdpwvz/murVII39X0nXL6eAvLKcE?=
 =?us-ascii?Q?yIowOzIIvE/C4mUTiXYKU8xX1zVD/8xF0aM9eLdNwpyb+2X9QxWCzMKD7CPq?=
 =?us-ascii?Q?+fpi3DAeOI1sytwM1SsxN1ZHX2SY06b1RSHqXB5PFHa6I+pj1ot3clhsV2vK?=
 =?us-ascii?Q?VsoGSr2lIasvKUNsu0xceFWod2/87d6ZvpH/cxYKDNm26lV01+ezxNIk/NaA?=
 =?us-ascii?Q?IQ6+C6lA3I3ps6WFMYUiro6PG49MX2ySZluBggKQyQQEIGLz18ZpzVck8KdM?=
 =?us-ascii?Q?EfY1DwacWlMSiE4oOmWzN5PzDPNUf0k07rUNtGLRWHJO/iO97w9R1oATNBfQ?=
 =?us-ascii?Q?5TBSk1SvYq2OcLIdhS7mBrSksH9u2XWgnVGzrhqNb8XbcubOXnsfiKD1Zzna?=
 =?us-ascii?Q?J9W54uBSAxMv+tfVR/9Mt8e8X2q+xSqZYsytjToima5c4JhnONINxaa+9ytY?=
 =?us-ascii?Q?FSJW8b5U2OyZ+MxRuTA1kC68j4zpBQ3tDYXtLqaSex5er5EYsQpGDx7CiWEb?=
 =?us-ascii?Q?M0XBYnl6D89jeMSkTQKMjgABEoV1vQcQNa0ple/dfDSLPT8MN20Kfbrv9NSd?=
 =?us-ascii?Q?4hnNMOyGRL7vBPtRX3/1EhWsbq5tBi5h+0AMpoi6ySVdxHSDHWfYgeAuRY4B?=
 =?us-ascii?Q?/EAFj+0DHf6REXCBGzmt8XWlkgnZmiz261mEaNc+4UcLTbouNzE155GgooXK?=
 =?us-ascii?Q?jYZaj105dWN5L7OFlt27AHVX6o/jwjEkrqPZ4oS+MZh5g6ph01RM8BsrVFPB?=
 =?us-ascii?Q?ukPWwI/PXh2YKFit9ZBWUv9q+JlhasU7DO3EZhbafrc3sbhPCsgelCyrnGo8?=
 =?us-ascii?Q?2/yfYT+u/4aVPXNGfHG68L/gA63LJUZ7bb+pQJZWZodlHxlXLbLUJnbPSqqo?=
 =?us-ascii?Q?fZNQfiR+285S/TS0JpY6umOOtUBrPJnMhhZd7Lk+1kO+rUkv3fR+7er4ESvJ?=
 =?us-ascii?Q?aWEwBRA9TfGUh8tulW/t4c0BJXz6HsejsVI/BQHJg0e3ttYkySWtKmfreCGX?=
 =?us-ascii?Q?goJ8Y5HwtF1cUqiIEcmoFE8tyY6t45aHh+3xXwRGJjxvaAmiRFA5GOjnYUG0?=
 =?us-ascii?Q?Pm2xLPMLG2KGJiSK41RA0SsMyku52ofDpcvXzB8ZiowYV12MmDCDLuM9FETT?=
 =?us-ascii?Q?EWIjQflPWWj0DAe5t2ullkUbOm7GKTzlycMCNa8aYrh9zKdXKI2uccHHhy6p?=
 =?us-ascii?Q?zY7brEyIHxWroUXO82Cm7B8Ok5sNh5dWxE90FTcYCB1xwejYSfdygmrvKurg?=
 =?us-ascii?Q?Hb2+mXKTGFFKNKT85dIRyNoeVL3UcEdGRNU1Z1nf9PmwjM+rIqKGygI6i/Ul?=
 =?us-ascii?Q?2E2tpxvzDAX1rSYYC45/WLpXQoFKzKwcfUxmcNYsq2fHbIcyssGPlxF0TLPE?=
 =?us-ascii?Q?cr2ibBpolfEQlouZsE+TIBT2STcpMZmRM3S68jukPhxCDLZ2LTD2sneyluwU?=
 =?us-ascii?Q?tuEoTAo8Qc/BjQ+TXYmOTe9AfActwmG5xJPHzDM0hMqxFGj6O8bjwOnvTgMX?=
 =?us-ascii?Q?zqniYJzu1373ysvRbEfJoJD2mO9+kgkkzTOTapni?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eb599f-cc13-4c10-bd07-08dd358364da
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:41:00.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LbY/iOjjjfKeDIOW1QZityK9/JUDycEEbQqFZQ1qssnO1SiZhCQIVDEQ7+XrVmIYQsh1XK0lBb7JLmhDUc1Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

On Wed, Jan 15, 2025 at 01:44:52PM +0100, Guillaume Nault wrote:
> Store rtm->rtm_tos in a dscp_t variable, which can then be used for
> setting fl4.flowi4_tos and also be passed as parameter of
> ip_route_input_rcu().
> 
> The .flowi4_tos field is going to be converted to dscp_t to ensure ECN
> bits aren't erroneously taken into account during route lookups. Having
> a dscp_t variable available will simplify that conversion, as we'll
> just have to drop the inet_dscp_to_dsfield() call.
> 
> Note that we can't just convert rtm->rtm_tos to dscp_t because this
> structure is exported to user space.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

