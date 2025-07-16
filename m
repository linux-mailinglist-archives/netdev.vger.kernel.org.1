Return-Path: <netdev+bounces-207518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CBB07A75
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05C0189B170
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448022627EF;
	Wed, 16 Jul 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HN7Jtlw0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC42F49F6;
	Wed, 16 Jul 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681460; cv=fail; b=WyQRtj/EDahk6UTjh94NoEbRZCBJHGrDjjIWya7F2u23JuVc0csED8ueVn7NFFd3BUQAOs+3S3nn8FIG6gZFky94TJikUi+5CYrLBOhoG8/3ysEgVsDZAukcO1v+0hH4ObbPQ0zTisPwvBYMNjtPoXZEvV4zQCoce2C3TyclVtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681460; c=relaxed/simple;
	bh=95sJahQiYjn4im+NHL8AYpEAG47QjzSRyycryBlIu2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dC/K8o9m07vDAKl3yZ2T4rpvXdfTNHfheI3haYxnQpV/yp+N+aPmeuEuk6WKurTL4XsySRXiwj51QBSIhQesfWzQOmUIkCVunLOxTOUubnqaGYzpHKdwaYG30/+AksRtM7UInvqVaQM8RofRqwDk06jSsHmr0CnbnzeMwiyxgXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HN7Jtlw0; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=valGi53DiXiahw3+PFxMVBY13aaAupr9Vd+b2bFEbi2MTD3O+a3ct3kQyJKql5RsqJtOGfM7EJXGsWCnr3PVamvGv9PyZ5xfgnES4TyPBxbJSrBasBEsc2Vo/IVi+H1F+XrVIMSKnOdKR6vDH3oB7Ku3dd4KfEdUXat+YVs4s3AfXR89FjMdK5nshX6J9+6bG8BQgSH4eeU0XtZn4OeA6KfAh/BSWB+8jjVnlf0MD/LuVvkyxD2kK9ZRkoebnU7h2TFoNi/uBxgczaE3+eZv82F4AqcleFE82lTsiLx81qrh9Asj+0RUZKwod/7qlTK6SSfuxa2ruND9i5ak7fnNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaSY9VNKF0/xLoayNw//v9m06SCAfzmXT8rhjdXUzPY=;
 b=Ik4CXmIqVdhTXKukuiPD8HQB1i+bgSKG44lg3RMVbuh315/hwiBeagTmX9JR0S1uD28tCCTcnsdWmy64zBA2379PLHLCV5VHxDPMFWQMSQ/uxxCzrKgA8OsSY2UXVivuUTZgaoaLfddBCUvJemE179jTO2obedpZUf4NV51SSCK0YrgCTQZFdL5T5yJ+m/WLc/EdOqh28KnCiYt63YoV8dv0cgJ323IzAvIlj4MuvUe5FcmrFl17JRhtWccuoIQ8U4f9Nv1mcbzd73MNVzUhod3EAUMO8y+eQzCB3TdE44TzYsTLVL8HXMGseKlv1H50opZWjG5zlgQsLM39+JLcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaSY9VNKF0/xLoayNw//v9m06SCAfzmXT8rhjdXUzPY=;
 b=HN7Jtlw06af/wnZcHh6jEr36AhqxwIP4NOLMzX+uumvbUiwI/mn+1EhzeghRWqIMJPYrrz72RcQXtrRSOmivVOGgZ71o46Vuur3YAj5rgisK4sDx7WuNeGri5RYbpHbuEkf/zskLG+tGLBRVX2jgshRVJxuSn6O76lJxVAiHCgcJ1KBKnhVoS3+BY310Q10EU3qZPbiqYEgLvy5Vg8FAVQkuOB8D6EQjCzYV7WSKnmORJf71VSm9uVsWqETycSRlZseYMXPcErBTi3+ZgKyQIk44DcvpH6U3QHlZPaLfZISpG46XkrZQTYL6qBmp97ot6gUDhmeeim8k666x4cafJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 15:57:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 15:57:35 +0000
Date: Wed, 16 Jul 2025 18:57:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
Message-ID: <aHfL5kwwd72U5zGh@shredder>
References: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ca8aa4-f9d8-42a8-3ec2-08ddc4817b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZKO8RDuSEaovln29lFjjn2o3KDCho2mQvkrt3WraK6F9tFkcJO57bsHsJTd?=
 =?us-ascii?Q?yNdMWjeFURqrfSTZacgwoMnfk8iCp+5DQUtRRiNZ9LzROAckCiMlLf/XGQ3x?=
 =?us-ascii?Q?JEObr8WrPa5lAXEr3uWbYJ48aYsa+ae+YfhjUL+ue/PqOq8YGKPgPEBfUVhn?=
 =?us-ascii?Q?UAoz7WjJQO6UaQWDCPiYp3nYr3m6tFzQHqbD6mRFYbayLhQSsj/EvXN1Q+xa?=
 =?us-ascii?Q?Or54GS8A2RcJr/5Ms8G/xNln5JaWwrkIiVpmqVfr7j2eA3JFHzzbEhmFuYwq?=
 =?us-ascii?Q?1PucFEs3TlCp6Ofb1jeN92BG53hWgxMyVQAou+baLTysPjOnWGbXMOEbrpUK?=
 =?us-ascii?Q?U8TZWEo5/VsauNA/mAsuo9dnmb2pqogIBRynljF8N8E2GxtONcgGBoUoHkzN?=
 =?us-ascii?Q?VAb5MBAn4yiSwt17od4qNSBLB1jqLb6BciT7bEDpznvwNzKXtaMIdOLqTedf?=
 =?us-ascii?Q?6fKnBpw8eQ7Ehbzo//oUe9X3iNHMiaVbcs2KNuMn63sEctkIzuPI1RSJkuhg?=
 =?us-ascii?Q?0j12oml70MWEL6kc0w02S/ZK0Dhrkpa7CypPOjlAtkW1giwL8u/WAfSYi7mI?=
 =?us-ascii?Q?AWj2EFnNlHQdSF/LHGqJ8ljefIlvqzb4QUuNRRjJbOsDDbSc/3/E2AqFC2By?=
 =?us-ascii?Q?GVuTflUrL/5X5rtL9XtzUQmr0kBPGr8k3YwnZ89iUZkaP2Mh0DoD2ybFAoDP?=
 =?us-ascii?Q?w8+oo4qSuc+6q062pq4r04MjUO+oVSZ6UbgY7q4K91enD9FWPxgyrkGTYWXc?=
 =?us-ascii?Q?adM2J86uo0M9MELbPisiboztlFZ7SIfLzAV1+Fq+b1mAbmC042PWwUS934wt?=
 =?us-ascii?Q?fIWomWDyRVoCOVugd3YzwpCuZYjzinrysj/woQQH4ksBCKY6QJNarVSl2uqG?=
 =?us-ascii?Q?Sh9S2qcuMpWcIPlMxUFy7MuDms2H7rKC8JYcl/tHJvIq/Zh2ih6UCkz3obN+?=
 =?us-ascii?Q?/GxaJIM6tGLLAh1Rne422BSsSsbqjEc93RM8fsd7m5252k5b12njBpHVEd5c?=
 =?us-ascii?Q?2Zcgv6l6QIPE0Koh7We6reyWfJHqtLnl70PkLoHCXKAMfE9ZXBnjC+lsVdBE?=
 =?us-ascii?Q?PwIms8qdz8FBKLEULJKYwAVOsMVrSKwjY5NuXGtYpsVYjHp4BKSK9g5Qe+wh?=
 =?us-ascii?Q?gbz2zuAOegU9asLGDZK9o2TqXoOGX3S+nhVrm/GAuDkrj6k23Ml/W5P4AlXD?=
 =?us-ascii?Q?ZRyKcEyO3U4rjG+DANafYMuSejoVNLq5onbGm8PUzCXIrL7h5jUxU+F+Vr5K?=
 =?us-ascii?Q?InMQcR8x+JxuPhNuw8NFk6FTGPMxqjk5v/F55kF1Aoa5lEnf1CQTSiD2V+5d?=
 =?us-ascii?Q?9SmOKJDqUodWX3swo+gFG6VkoahYlFoHmd9LOUk9NpdUh1qsO+OtEquW8e7l?=
 =?us-ascii?Q?hvEKTiSG9c0wcP6+sJcDXv+vPeuOgoQgCMpLBY2uNMu9B4CJ9bsdBN31Uknp?=
 =?us-ascii?Q?xE9CxVkRZCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCg+kj+D/QSEK4ClG9EeNKWwqEeEn7UsFr1ooKLjS3I4c6NkikgYa0/U60pw?=
 =?us-ascii?Q?39YT5fEnHA2Za91JR0Z32Q0XtaZqgzrbKqsXp1TwyY2K8Ocm4+V5N9GOQZSu?=
 =?us-ascii?Q?fxPLq6PmVrviN6D5Poui+RFdvj/3muiUP5tnFOSDKNV7DivYJNKu06AgXNZt?=
 =?us-ascii?Q?Y70wtP700lDwKMIWj7O/2y8m2b7VDXtaBwnIUtqIFvlIN4UrP1Ym+VAfZ10z?=
 =?us-ascii?Q?opIww3VBhUtCe//CfJJOVe0ttbjzKUI4lmqql+X6GZNo8eiKuoHuv1KdZrDB?=
 =?us-ascii?Q?rfCi5ebZHxXv2Pin73v7UpdDSGf9PVhwnJyP67c5WjtcOUyaEq6UB3l4wiO3?=
 =?us-ascii?Q?jNFq8KxAShrO6JOYaFvbRmR7R0oh6nROEVmG47m7zslGF1dn+DmjtPrY/yjh?=
 =?us-ascii?Q?9rz1GgTWCD8DiLhu7ctVNFspsKXnfhoSSECNTE0xHLKeEj9OcE2SB6Y3/X3a?=
 =?us-ascii?Q?Siey2HDBMCUFJFadLy5sE6VJysTkIWW+fF/HYej9stnDXPkIG3mFzMNfWXQU?=
 =?us-ascii?Q?2aKFRoRKJRl0ndNDn39zZxNpq1tj5hOmqbUmma6ZbTdfH3PA/n4kKmvSZjfc?=
 =?us-ascii?Q?pUsEYevNpcvTFtEwYc5eHD4GG0+XkwghmTATFhkxUzyBEzCGm1Q+aKqVkHbF?=
 =?us-ascii?Q?rXXIkMUi5oJS5Z7LLNHbNNzOBzWH1U+dtKQtCXF5HuLeR6zyPvo/go+JjJuf?=
 =?us-ascii?Q?WO/36cFTNI444YyykdWVGsl2cQSu2G3yGZilXoFXz+hspk082gEZQUrn0DUN?=
 =?us-ascii?Q?4hDIwGMaTVH2c4h/48pvaheAQE2ZvVCQB955nbTis1BKWHlqU7n9lm2aB15T?=
 =?us-ascii?Q?eOhW1+N4EAzbLfllr7aD4NmZDJGswXLzrqne+XugTdnMqllSMndfWN8kH4gR?=
 =?us-ascii?Q?/+TrHFfD8Z8h0ylG3upSTr/JxzuCTttoMREwKRRgkceimVuEIIRxuNiU2uBf?=
 =?us-ascii?Q?L64ijNdC9a0YcMK3QIvyULNBIXZUUk3fm2vantvryFK2azEb/FWZCbADzrgD?=
 =?us-ascii?Q?NiQQUv2G5HS06YXIgBNU+GS6adBcq2Ynfd/GajO1BBRH6RoqhuP0bKnxhhKA?=
 =?us-ascii?Q?G2qUVfiLs7aeQy7TPjpDTzPqy6CjU/ucmjLOHzXa1kKiMiC4ILIWt63EQXYK?=
 =?us-ascii?Q?LbBnLaSnkvQme3Y1iEHG+Xla492runk+vWALcaQKPuay6Grlx3YiQ/pBvmvh?=
 =?us-ascii?Q?pGyjs0fIF5RGTsFF0cuuwBmNtofnGnHoR3/ofjWgKvKPMe8J+4Zu7KJA2qFd?=
 =?us-ascii?Q?kQHipqW9QkDXgXPEUKgmtsKQDnnrv9lt7FOb9zpxGjoFpd+AnZtfn6bYXumX?=
 =?us-ascii?Q?GcUcINSeL6QGxtYaBISYy9TdSmCCm5CTiV18zEhOOUwSt5lj7T5A/SkgHMkv?=
 =?us-ascii?Q?OLZ1QOq2N7lKF4ffUO1vmFmVBuTgb8w62QvtXZvoqX48CB7rtVm8ZeVmcfYt?=
 =?us-ascii?Q?1VjVAxtOB44o+BT4IapEA8dWAWfFvT0YfVA5mxE4nfWY3BYI5WCtnNSt6+MF?=
 =?us-ascii?Q?JlS8RSfYr55ErEc01MpVWk63xVlhLCiKayB6UlOgsNTnKpk2GPVfd7lClb0z?=
 =?us-ascii?Q?Z343SVe+9pLYjEBSwkSSqmf29iu0ujRNYnAi1nGc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca8aa4-f9d8-42a8-3ec2-08ddc4817b4c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:57:35.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVcEbw+b0banAjk8GK59e2B833WFxEXaYEWJOycsRjCzsJ247hc+nFNAu0o5GT4VU6zqmrNd4TsWlsWRvQq1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477

On Wed, Jul 16, 2025 at 11:35:50AM -0400, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
>        mcast-listener-process (IP_ADD_MEMBERSHIP)
>           \
>           br0
>          /   \
>       swp1   swp2
>         |     |
>   QUERIER     SOME-OTHER-HOST
> 
> In the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well. (Example and illustration provided by Tobias.)
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

