Return-Path: <netdev+bounces-189982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232A8AB4B96
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A21885D3D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED317DA93;
	Tue, 13 May 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SoyNEuqS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE15258
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116198; cv=fail; b=EXsfKi9PHmV6hCzN6f8DboGHKUB3did847ah+u+4+qdqSvmGojamaabtYYS5bLmH6KDvPCHYdFANFIQmAPPbdZfgT2H9EiHI/2fmf7mN4fKf/lDfe9DNZD7Xmqimg1iYHFA/NMvkGLs1hIDqcxobAUtA7f9piCnd3ujRycBJOqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116198; c=relaxed/simple;
	bh=8J6fPdZ286cMsahZPGR4HQwyPrq4yiB5MuQ+mpXdOe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrEyd3sdoRJnPC7C4uekxMC0bjbAwA5EXJE79QzGlR1HmS0A1+kePUaVi+hwQVdWElRfYJNPqJ6LBxharZ+ksXeM7CkWsXlWzQxtjhUpAaLy3nj16iBAt7MDEFclTs7wS0M1N0DqN1GIaTbn7fYpKg0FScYIBaGApVIiOymSg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SoyNEuqS; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoSg37/rkLNvsZbQ/PvjLtLpj/kGVcQ8N9DetH8hov/3671ijGRhx3UlPIJuYjpj3Y+zXTTnlf5P3vVhFkDxvCDWQsFTkmm0KVxkkq99b9it/kmrmsgmmR/ewpx9t+NSqKsgkbYI94oK8GH2uplUmm09tWuIQxtZYXfIViQGlSJf+0NDnt/vKwwLYDHWvkJmEJJ5Xpn8yGpt/fc4ERmkZs3n21IwuK4pM1xLdGGBMnI6dwtoGJS1W+RvLM2WHSGK6sI0sNkDeK2KeWkLLfywekdSJny9oEGm0pz0XJLEOP4LZLEfr5QbKSRsuoUAqshofnPxX1PlNNv93znCjNzdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWlNsrRe20nLfGMALZLsUZJK6SHx4l1IT8w1/OLB1/g=;
 b=vC/CdfmucXRoCQKDhwZdlg8moWbOmV1P9AIyvC6Fv2hsRmdyfOiQvwFMnM7sF245H0Stv8HF4r0AJngg2h4o5J5EPACt8qrK6a7isXqcxyagHb/Se8NcN32L1x4I/+wfzJB0ldFwvC/0PKhd1NP07EPBQMbgDPlSdK3h2Qjozg6Uw30cRzR+FJcmAJ4KuJLe+zEZXe7PgyTW4D1ZmZh0DJ5OYAPYApYnZcZq7DVhl6d8lA/f4e7CAZQelz3zHKImEOnFrw2iNUNSu7WfooPorxYZ7x4AuYW9FqJKN8aU9gOiNdm88fnl+6spi4leNnzUK6CnFNvV4ld0P9XypGVbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWlNsrRe20nLfGMALZLsUZJK6SHx4l1IT8w1/OLB1/g=;
 b=SoyNEuqSENvQC7C6jF40Ya8K3T94Yp931WgvJVhyGEeVJn/sWRXC5Y5vnMcodkSd2HkIZG8HUo+Omf7vScPY+7KAZgZalE7+8lMqQtGOwNluVVj2BlcvPe3LLScnrvYgDjBw1/AqZUKWpjC/++i390oWd4lwWJ2qzT97wL6xAXwV33zEO3A7vzbCaPWNPRz7IOnENqYOqYJE3ks0zO2H4tYSxA3N5Y5gYkf7C9I8XB6fWskfq8FVui+rpUrAlfXLwpesF4Oox0T7iv9LKrP8uXl4vDTUxzQtekh6922z79CGnjzcD7jHe7VqVqJbZzHKV9FXZci/65TtWtYrgW3+aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 06:03:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:03:11 +0000
Date: Tue, 13 May 2025 09:03:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: mlxsw: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <aCLglK2df5Z05z3B@shredder>
References: <20250512154411.848614-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512154411.848614-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2896097b-307c-485f-f1fb-08dd91e3d71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdMjr1InkmXDfsy6Xl18WLIA5NiSFajo0vw5hIyXjqKrBMjaFdnkLz6dIOXO?=
 =?us-ascii?Q?bVCpxcKM4MzDU0LOjp3msaATClH6bLJVIBrcOqDyIUaT02eR/fmcTRuMYokl?=
 =?us-ascii?Q?V3TIayPzUht0yYXxL8Ol6DkwZC4ACU8CJlieW1GZ1nCJr7uuR3d2Hi/Dr4xn?=
 =?us-ascii?Q?VT3zLo2ZmVvkWcBLqvjeFyOKErmfpK3oaQdlct6F+lW3Ml/uA4t/Wugcsb8a?=
 =?us-ascii?Q?0/qcs5w+qaL5kxEHvueqKd59kH+awBnO2qu3RH41zFPINSVkCnU0pNRWXwkq?=
 =?us-ascii?Q?BAG7dAYxoXkD5lb2+wNMej5Bfr1ks6/okFU7jq/ijz4NzMuZk+rRfFn/VjcR?=
 =?us-ascii?Q?pm6nikXLcZGrs9ZucMmKoGgFOKd6IJq86Yt2CFva7+H8uC62uZfOxAncvPIz?=
 =?us-ascii?Q?QPeLT4J7t3oY/mNlCkazLRaTHO8wIl+sV3C/65nsMcVyeiylwUcDrQwXKlMQ?=
 =?us-ascii?Q?mKLyWC4xqIoeiwMSFjMuO/ibk2JwzfSTsv7pq+TqE8JbvhePJnCevp+Vuzvi?=
 =?us-ascii?Q?7gJqu+SQdvGuhRGim7xMPGaiN6s9nRYoalopu2Mbh092qocIuRMw9TrZ/+xt?=
 =?us-ascii?Q?oKj/C0kxCxjoy88Swpnek1cCOvMDb0+lWuLq8ae9uTW8XO/miFN1/hDp0wh1?=
 =?us-ascii?Q?7aeMt7gzB5IQ+ZcYUkS+bZkoR+j8j1DvUPNdFsKge6gC6o0j4dJaE/QhJPXI?=
 =?us-ascii?Q?NFASrxxQCUwB+Tsd08pArr4YlWXrh6BdZdtTF0GiXbTuLW8nHyIIQTWgseQ2?=
 =?us-ascii?Q?UJY/EGfEmZ/RD/xOE+IKvMFtcD5+OaLmTPwQYw97fGY4nk/9qJxJKo7+0Apl?=
 =?us-ascii?Q?wze+04FYCNuFDLj5VUqgaB51VvdEaNW+xMVm1uL5ZwnnUHLJ2J2nVrAdED3N?=
 =?us-ascii?Q?TQqIkopOTapd2A573krwJsHVVxaNy8+GqZ4WFbDmgDJEMGpuFm967gxPPanv?=
 =?us-ascii?Q?V7RO1UuXS1VWPnFpEFyUTpldtkwUjU/gOfSF+51eV94J3SvDnWC8lzgUPo6b?=
 =?us-ascii?Q?QIQ/ld79wiPTBBIUaVibD+SBRcAC00sMzsx+Gbgni2WD7q8AvFd2TfsT6PXX?=
 =?us-ascii?Q?7/zUA0dE6F/jHJX3uGZiDFMzjHwDR9u3o2QkY/epTIUSwMwemdntQ3t3JAID?=
 =?us-ascii?Q?hMEtsmgnZZmif98m96PNVED8xk8t50JYme1wrHuKEmQxW76Ejqn4+1rD6aBo?=
 =?us-ascii?Q?+cvqJMyPvXJrQGLaWOLHaeNiwWVnkX3bQj8fxTVBvnrda0VbDUjIRrJt68Ga?=
 =?us-ascii?Q?kL5vTsVIWMind3vYDBA0Cg8TF4S59jK/UGxKHEctgCfFit8QoqNLnmYHvD4y?=
 =?us-ascii?Q?iKcGIfbmjmvJ+fkYSyb+0D8pvfKyyWOWYOXr8z7r3jR0ZYg0RfAZ22XJ2bm3?=
 =?us-ascii?Q?Pxnt9G35xCyohgzyGGbXLShghJig8lnxN6W/IboLsU81m0nkfuyz4CP+HiCo?=
 =?us-ascii?Q?S7jrHgcXfaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUveFDfbryTm7JUaQVvpVBNDkyFG8YudD/iR7lBFCFwJ8EYB6L7ClmqgCwYk?=
 =?us-ascii?Q?iW5WcXcNrDbQDPBd2uHeVfBjxt2nqZNRPgJhi8O2SU0kQxrHxwMd98U56GnQ?=
 =?us-ascii?Q?cpzbmZwOF4uPrife5r0tPLbn4soE8bLLEC7R1BhqiLuyYGptEvef0UYfabrg?=
 =?us-ascii?Q?FGcbKfxKeyaggupgpCyQjyvUozknveLyDTi//FjUQttwxo6uBs3azRJ4djOl?=
 =?us-ascii?Q?xO/q48VGykVNPEM6XCsX6qS3GkcQsIXjc4QYmt3pxcjIi7zW/r8EPtstnrW3?=
 =?us-ascii?Q?6S9LN4jxrjrYdqpcLsHW3IeinE0l5V4pZzBNe4ufovJnB0TE8ZXST4Kry3g4?=
 =?us-ascii?Q?cGk9tHcsouijWq5WVcLKk26SawjiES7TSAypywvhd/8/XRxmbx7ydOct4nel?=
 =?us-ascii?Q?8SYEn/QomJ0WkeMgoZukMKsTfzdG7PtZ3IVVjRW4kdh8h/MKC2nTndYKao2g?=
 =?us-ascii?Q?g5Hmj6+zmBkkSapDoiOjhlxPqJqg3lHDktgg6fLmK7uCkklKAK02PnHEUArC?=
 =?us-ascii?Q?rvtUcCqMlrhbNvmiT6gdgL9bsfh/BUXSP2iyYWN3srQGfvbOSgkiAX0XBscZ?=
 =?us-ascii?Q?ymmTnOliy7AcCF9HJfPzbbtNTLVwh9HTGp15kiRJaAi8GEp1EJF6n07r0PVC?=
 =?us-ascii?Q?jPfowiFYa67UAJKXFJzU7njwj/P1n9bXDw32oHfFVotnJvspNphHWEgS9VqZ?=
 =?us-ascii?Q?9dYoqXb2HrGHnKtzJaCAHgqP4JvupFBHVmRy3GKgv9b1Yl77v/6XhwIhD/T+?=
 =?us-ascii?Q?tJr+9aN8R2PVb325XlkmFkX0wS4uBAoaUNIqG8pPlRKXCLxJRiynck/x3P2z?=
 =?us-ascii?Q?IQCxJ1gfw40+ArwSsowLKeWyr9+5y5F0AdMnbMmwetmAPdVa/s9yb0UuADN+?=
 =?us-ascii?Q?qTxPvsYPTSAR/jb/l67ALUH/zWvs2pj53Z1HMvWXVKd9HjSxbquX3pO57Sps?=
 =?us-ascii?Q?MTtAneDurzyhjiHQlHde2s8+vNGYtlaLOxiKpmJ+Sv7Opn2IeEYENDj3KcNC?=
 =?us-ascii?Q?AmpFS1XGDcHVVxJkCMAruw6xtHzvEi+IOuBHzBZhIWKyug317G79eFTshO5B?=
 =?us-ascii?Q?b80fnvNYjrs0zwDyEp3uUagVWIcg6XQHoB5WGVRGyz98U5V1W5AmvaH/tDxP?=
 =?us-ascii?Q?nbaCudeXor1uyRt/7rYGlobErd8YnxdARxO+6zpOqzvw54F+v8bB9fau8FYA?=
 =?us-ascii?Q?S6jBKapNzynLUtATcy/fGUwZeWxqyuvCe8feAczHvUrtC1agxWwNb3Fa1SNO?=
 =?us-ascii?Q?IXNNwr8Dgg0fhVsCUXJlfZCqU4iWU1P8/rvyQrQXllubgV9cOjr3/XC2qPKa?=
 =?us-ascii?Q?yIJj7R4VR1sVR/vjrFCW4jQub9EejUiReIuQNIVPIqp9Id+M8bd9O1OCHq/N?=
 =?us-ascii?Q?r5zxkym3Humc4UexBRRhB5KJZ3FPkBHd7ExTZkKsdnVXbzWf3LfrHtcWiNVr?=
 =?us-ascii?Q?c/Rb+45d7NegD/V6sN8bcjhmL9hZiGnCzx+g//RHO265xjO/NTemmpdXQXFK?=
 =?us-ascii?Q?mcLTsC1eWAL1HA97+xbplq3M8TxVPFrmTzCBNBMq82oLo4h5iWeQu1Z3Qg7B?=
 =?us-ascii?Q?+d4itqmLyP8m6rFJg0Ofa2VpJt3VGUZo36K32GCT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2896097b-307c-485f-f1fb-08dd91e3d71d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:03:11.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqpGF9q0g9W2UpeQjQPjU0kBH8BK/1whc1kbD3ZDfg/4h2K8/9ypT2qW7XnS9MQhQxhFClBVpY82FGSZgYa6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

On Mon, May 12, 2025 at 06:44:11PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the mlxsw driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> The UAPI is still ioctl-only, but it's best to remove the "ioctl"
> mentions from the driver in case a netlink variant appears.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

