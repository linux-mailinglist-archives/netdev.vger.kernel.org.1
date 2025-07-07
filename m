Return-Path: <netdev+bounces-204571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FEAFB3CA
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B351AA120C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23229ACD4;
	Mon,  7 Jul 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrvKY/qA"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E24288CAC;
	Mon,  7 Jul 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893261; cv=fail; b=mcmE3M/dNqD9tn3Y7Zt/BNYAbhUcdLc8dGE+/HuQLD1y2U3Wy+tjWi8QO0RwZkCZ5/kSvuHROJK3HVhaJWsC5Lwljb7690CyUjGpuPexql+9Sv7vs4OmKFSSo+AQqJIqjm0tB8bye6BwUxIEZ076gByIhP1VX/T9TiGgIfGJvH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893261; c=relaxed/simple;
	bh=2HFC/Y8zWtZyqCNY67S0JCp4farK2BOQ7FRHRq9/cRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7oeIoZbR635OgNu/gvkJ9+OGUWa2gtoOGkOaHcC3LSdRK06OC+nt7kpSTysKCSCEyU12d0HOgJF5NRopkTzk6y5PTmKZxyqhL17Nz7Yv6Fqvzn+WZqCBA9CR6nLgJg4hF5N88hy+AZE7KqUKPFtcknw4bHAYPMnoxuKbWbC+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrvKY/qA; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBKLt9L7IROVrBNx87H3YKFFq0ooG9QhJ6Y/97lfaCSkrlwaH428S28A/QQcwEDcvY/0JyJE3uAtIKfwCSZ6WSgfExS/grPanIJYcYRi9vFRuyBDFk2NXZmFyXQxd+Hm9JOZcoYkrM/im81PO9LCe17uu9Yvh0VxfdHcNbf86INvl7M9ur2DoOiDxrj3Y67I8nsY99xaIkTUUsxEfK9EbJFLHppa4v2j5A/CF4zSztbCBZG7SB0sgSGmjYHrGH4KnoiKM8c01SuO9FlgTC1r2smIy8aTZxuBj+6HMCzMWgC9cDMApvhIBwCV9EU0avFRE3C2tgRVu8AJrkSmZ27ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP8JbXmccqwy7FqfSSKlLl0aZs8mI5XnUc1HN+3jD9g=;
 b=s3m3+bdpK0Hu0PePgR/U8CEUMcR1KDFQzqdGqSHKN5ZpgRYti11AhPoIptPoz4LfjLOFyWxAEKLWWOGdZZNgww/T6ps8+LP8LZ9kC/p/qzaW3Cq83c0BYah63Vytuwre7gXsaqCl7/mouviRibph0M+N/1FQl27XgL49MCOjUYV5pQP8UxkyZrgCB6fQ0YE8joeYYMKTyvNoxRhcpQ6hl+v/mR1u7uvsPDdiItWOq6a100NX+3i1d3G1WDkGUlYCn/10QLqZFhTm40Gat0GT8Z1X/A08bZWXFpfoCPjJ0fzT/8o3ybob3siyXwdQhC8JzvjQP76FeQV8AW49+9idIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP8JbXmccqwy7FqfSSKlLl0aZs8mI5XnUc1HN+3jD9g=;
 b=RrvKY/qAPQE2+11yEdxdFd8DJTmHbWvKeTaZeDGSMQMgYtwcXgv6KsMHfE6fwl+G8znxaMSp21Fu8R3VnxDt5tJ4JwwEZMxCaUPMTyjcLIw9bJfIy2pgCMCjApTw7lBJQ9AyEvDMIpGgs/E1aqM50LeRUDRGUWRNo1iPQyZJO1SUqIHE0fdRK3RV45H5l0sDvswIL9Do08SsHei/cl9UQV8tzHF0d3hWnQ7BMc1AICXdNQljq/+scZ7eXajPGM/EvH0t/STqFBw555wqPSgx+ixP0/Pw8zQ0qPEeGkuA7VjFmDIDMpaAoMxV3qcxPk2Nc3gBKg+XA5v+F5wc4JiBMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7917.eurprd04.prod.outlook.com (2603:10a6:102:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 13:00:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:00:55 +0000
Date: Mon, 7 Jul 2025 16:00:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
Message-ID: <20250707130052.wwd7e6fenp7imvy7@skbuf>
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701193639.836027-1-Joseph.Huang@garmin.com>
X-ClientProxiedBy: VI1PR08CA0209.eurprd08.prod.outlook.com
 (2603:10a6:802:15::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db614eb-d828-4c98-5123-08ddbd564f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1z46uU/cbPQMrbXx3BCX9mgq1wLHwjtAMElh734CZK6j55aO6spMyL0YYk3V?=
 =?us-ascii?Q?SRMITMOT28/6oSBgvxjNtEE+2YvlFgTJyQrKfOEfBx7psv7jeSUHl/oDnZ3t?=
 =?us-ascii?Q?C5ZB+LTe4+AmbCkbtmM8m0mja+2BmR75kdzd9uoefYJyn47KT6wZoBcWZrXI?=
 =?us-ascii?Q?etTsO9P/SA4+HzWKpU9bWQhPQl4MlaY25Z7nMvv5v7qjWv5Qku5xknfhbgpw?=
 =?us-ascii?Q?9W4+mAN2JiT+6IV5NmCnTdR5EtnlSPFsVJp4ZILtHuaKvyYPYjSHbua1KR1r?=
 =?us-ascii?Q?RnJIUwfn6FFpzelNyjfjZHm7jLjPsq3h+TNMIINCgF7SRPmBCjeMb/GGA+bQ?=
 =?us-ascii?Q?+tcLeKxUITHSw/TRCnLbsyVyl0cEh8i9HJV4lo8NQY3n8wMLclSAO5T0rp5o?=
 =?us-ascii?Q?bbi5WTJXKqcWNujG5RL+cI8u/Fq2Yd085iTb0lBBMNcpr/1FqlnLyy/dP7fL?=
 =?us-ascii?Q?9oScBHiBzUtfgwNZFx1CLzg9dIK5pTdWcZEMYeCcV4Z3ui1+glCKYop1qoLI?=
 =?us-ascii?Q?Qa1SF0bqDZXdOka0Jn0fU21KC2etOtIPeo108C6uxJw/hLcs/haXkxoJOaga?=
 =?us-ascii?Q?r8wk8xjxn1Hp8RonBdwAxxJZM1r6nyBfFifAu7022137dPo5O1/TCtA+nrWX?=
 =?us-ascii?Q?wPZDtnHqDuPMbXr8mRUldQHpRGU5d6k3W09Mc+hfU7HWoygDoCWlmZ1iFbX2?=
 =?us-ascii?Q?ptDBQB5pWM9GIJdlk/13GSpdA0786uyYKjRsG4TZnbvRFqn2peQX6z73vLUc?=
 =?us-ascii?Q?TvKYt3G3nK+1J9Rgp15Td5Zp6nLHnLm512xRPxCLBPWW2M8SZUq+b6UtCjla?=
 =?us-ascii?Q?BrSMlt7ExCM4QeEdca7GDQP/VKrGKzaeq75PbFas5BTmIYdKhaII9pCtrqzU?=
 =?us-ascii?Q?1AP9uiMh0hojiEqhZoHVmSz+0yuerlwN5U7+lqq2wMtHwUc38PwCZ3ekxroq?=
 =?us-ascii?Q?stlK1JkqQ5r2p4hj+08lfMOVGv/TQh9vI/YlEf/o1bUhwNB4vPZXG76xgGSe?=
 =?us-ascii?Q?lyaOcIvA+mjnU+eyhxks/fHh+atgIVZLbEXNq4OCIujGWp4vedM/lll1ID80?=
 =?us-ascii?Q?c8kLNefzeyXI6B7GFb+a2xuPkSInIcCZ17N7dJxQD8J04F3MRDoAS5f3LkP/?=
 =?us-ascii?Q?nSl4gSDr5ffSlfn7mvXJI81Mym3kc6gpeogVpyAtqRlJkEa83jaYA1vjv7nf?=
 =?us-ascii?Q?aAsqukVXb28jbwH6yTtiQy9klJHRabNm1nJd8fcs6DABJM29s8RIl6jMiCM+?=
 =?us-ascii?Q?9m22BTuMTLb6J+XagH4C5M8XUDmg9OXVdCEjzLVxsWng4OKzrg9uqcIsWnUP?=
 =?us-ascii?Q?MG+xgbXOAk92Wde0hlaP871qHP02WlpjifTM2FYCfl36ztN5Yzm74RBTelxJ?=
 =?us-ascii?Q?y+hjD79PRZtb8gVN9wVW96uOnAI2SB0GvuExgPZHNzZlZlS4eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzwnubzmZ6u7JJkTZ0CvN9ehvnJIQOPNh1YoK7ynvV2kTN3Vhga+AMEo4DUV?=
 =?us-ascii?Q?ZpqQ/7pYjtYwi+czT1BN2nvMjf/7GWeSaSaLD5iT1SN4R9H6fMnmd0ayLyoX?=
 =?us-ascii?Q?lVV7tJvrj9GdoZUu8r/c77Biq2MyECyQsME0Azyf+tIE6uo7hALt7uXPzcDE?=
 =?us-ascii?Q?6si+KxW7yGI/MWZRBtMS6eFHkYvn7XQeAmXL+3QLTbLuzqlH+sjTk9ZmvVqZ?=
 =?us-ascii?Q?XgUR3UH5+KaG4ZzrLQPV0vTm1VrLQUhYNNRrxqCNs+j07M1zFcZLeBBxhCep?=
 =?us-ascii?Q?eShJlT+Ig/64E++5Uiunt3K8hr9Bl0o7H9vuyhNUXgeVw9t1MTmgtqJhAIeQ?=
 =?us-ascii?Q?lYTodyYqCDZ0+CIe0omZcPL2Gpo7B/xpJTJQ/TO1Gugg9lSlR/wazaomrap6?=
 =?us-ascii?Q?qe6/AHbLNEtXzSlKfnfP6cCdfAu+ZN2FbCIwnBdiGlIWgW3HMW5asTsHPVat?=
 =?us-ascii?Q?m1KcvsaDuibdB0f7BfltoDbWAUuZmrsLbdtRpzYuSHfk3YD4I9z/dftbkW6C?=
 =?us-ascii?Q?//GvVsv3GuQojh0udjW57nlkp90RHiAryylsvK8TrgP6uO6TqzYXuPlCNf8Q?=
 =?us-ascii?Q?vRaz8rItTl584GH2huRjTpivdxYj26tKKrPXbOFWr7+uWt61DGKAHliCt86/?=
 =?us-ascii?Q?/sqk5skiu+Sg9OtIdZELZI/8nIVSEM9cI9BZ2O31dgFsLNmh9hK8qC2TVRw6?=
 =?us-ascii?Q?2NYoFU7DBHz7yQMUXgaPJ0PEM5VJhlnM4/BqsuZO4B+m7xDJhoNW0iA+Znf6?=
 =?us-ascii?Q?2Qs50wrPaDLIdcNhwxGpcpQw29jPiQqRmpG1ZqOyS1OxiD4qmv6p8bLEDwjw?=
 =?us-ascii?Q?rJU9AC45TNkHx1K5jcgBpjcRb1sqSFeT9k/r7LAxYhM7Xio6cB5atDxxTFLh?=
 =?us-ascii?Q?z8JVD6SKq0FH/4onocoLpOKeF3me/yNNOorDulk6dnuUirh3GetTNjSFFGTV?=
 =?us-ascii?Q?iWklypV5jVj2NVY9QtruwD59lAZ1nCbFJCgBhMZUBAoMhrK756U0ho78LQVW?=
 =?us-ascii?Q?1mhvZUT+gCdljJCVe4e+pN4p0RD2DwXoAnVBlKPR+PkOSEUzF8T/P9nFMpMC?=
 =?us-ascii?Q?/vGeFWQBWp/n4mnbiy4KaqQ7lb7lXlfUnWFtwDjmjZHrQdGu755EogAP5flT?=
 =?us-ascii?Q?5FjtkXsh3Rt/hUXg9sjjwLWelwJsXFDqs1/2FG6oBpdGQpf9zCAsrxwX1xJ8?=
 =?us-ascii?Q?iSj7bh7vRiQYQjfmuvvgcCrmoW0Z813kqbuzYn9E5YfXek40WPa9RIuTGTj5?=
 =?us-ascii?Q?JJ3xO9dDYIEcsx1cPI119NAn0Ov1XF5eda3mNkxJmLJhWH7SNF5G8R0zeAJ4?=
 =?us-ascii?Q?zE1J5Y8xs/sJ5bKcJ9Ipv8gS12DWkK2sH5KaUEChNEpIMtPKkixPngVHQf8F?=
 =?us-ascii?Q?8QhEmbwY0jJ37DYI1xAhNI/5+kQoc8PYE6HTb23m4xdJlvqpDDWMVsGiXfKW?=
 =?us-ascii?Q?/tNZyZfU/wGKIhpA3QarqAJJIpqvWmQY9kDnWRUPPIwBHAwfmnqRiGREfdTh?=
 =?us-ascii?Q?k/4ywcWpsxbhwRIOxu+8NC+jh9QRMmFDCP3MJ2isBG74cZr+BcWTns44otTt?=
 =?us-ascii?Q?2130mfwCdjqR/d3OSNkNrte+zH4arHbW9wzPBRvWQk5UfbwWTUlU4hUx50OB?=
 =?us-ascii?Q?GhscNwZm2C3eaFMBB60W3CjHu9R0fBUXk69zO44qRtKpVfuDCVRDG+2b76bv?=
 =?us-ascii?Q?Po4Iew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db614eb-d828-4c98-5123-08ddbd564f53
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:00:55.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmT7hqHGAug2nXmZyZsgOfmFoVBooTX4T907YKlhdMKVWBzisYYojg9GJqL3Cir+gX/XiHbItzgphh/MU5rbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7917

Hi Joseph,

On Tue, Jul 01, 2025 at 03:36:38PM -0400, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..757c34bf5931 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>                 return false;
> 
>         return (p->flags & BR_TX_FWD_OFFLOAD) &&
> -              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
> +              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
> +              !br_multicast_igmp_type(skb);
>  }
> 
>  bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
> --
> 2.49.0
>

Can you please incorporate the extra clarifications made to Tobias in
the commit message? They provide valuable background.

Also, keeping in mind I have no experience with IGMP/MLD snooping:
aren't there IGMP/MLD messages which should be delivered to all hosts?
Are you looking for BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) as a substitute
to br_multicast_igmp_type() instead?

