Return-Path: <netdev+bounces-273943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD0OLdvIzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB8375DC0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F291301EB70
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181137CD4E;
	Wed,  1 Apr 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqMFBRIQ"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC137C11C;
	Wed,  1 Apr 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028340; cv=fail; b=hZghYhkVIuf7RmiAotGrksmAJYy2kMMFxfiGsGIX8FK2d3SnBuXaVS7qLFP3B3gXs5e5x794LhcYuWRgMEWQegA0qicQCMNr7RQoVDk9vrRUS99Y7I9wkSc90QZxtfI/NKyTR5d1ynsEvv4JlU8rZtsMbgWS7qwHUTbXzMVCdpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028340; c=relaxed/simple;
	bh=DUzu9JPZ0iDdWAdZRfuqMs0k09qIKgIY3BL9OGbeAg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wc8uUKZFS1mHSKNoHhCULQFQ6y87ukZpIhdR38Qr4g9Lb3j5SsfrzMNUQeRqklQC7lwDhC3x/FBKkH4p6GyBWtFesQ9+qtxRXJ319FHAEDzq+OlshOGewWs12g+TL4C42lcJPvOo+PBKZzIygb9hLUU/KGWal23PtjSLR8QPcLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqMFBRIQ; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA9WUbA+g1RnHRNe327h5lu8NS4DRGH0ArTJNncsJ0WHDt52XJEibp8n0SChEVhZGKgBoKlX8uLqHYqFUeHIs5+er2NoE3xXnzCX3iWxkjQBbecHoyq5pyEv2afEaCNvPg3RHIwTCaMR/41AsxkcW9jPw+SVmFmSNxGNAQHiGsiV/tDvpoxEOMtTL1pfOhr6G4jvLP1HL4AYV+z0XPuyk9cbZCx881rHnwB+p1D0uf2WBNg8qN8CBnCAKZiDzf/URxm/14aeFbWNYMFg9cHtV/P8l1vvAz+rObflyYfF6i6XinLJrSA9doLrckHBmQD6bdu6yoQXiw7tRYBmJfgtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZNpNaiwCycBf0NWcMjwbnMX+HYc8xWVrQ7mbgl+wAU=;
 b=o6j79+WnBRV41BYUuTIPobf4O2d8NCQP0XDEJUW5ELK7cE/Iwe+Pyf+hNcOF+BrgtypsPmJWBOU67C6j+Nftl8NMAJgh48yONi6yjCHs+DEukRjAmVn17TCV8210PYZ165EZCZOfnU09WqFWuSOEU/aVIlW8e3QaMGDMZqXy3h2n64yNcYD57HpQwnkU6hiTvLNajRG2sLGPOud6Lraal91/hjkM3OL8RBimJPjPsHsG/IDZJxjR4tU4gmZlbzBwofxWrVgZE5AoNscf1iBqDwgPeWwbDYJ/szB+odIk5Sp1V0fmnpwIi1DbjIZMiKukvSizdfNBYrkPHy39CpKFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZNpNaiwCycBf0NWcMjwbnMX+HYc8xWVrQ7mbgl+wAU=;
 b=DqMFBRIQVU6++jqaZdtfa6aVS0XmM/ZB7kuvbYFIxuujsB/xLHcKeCON6aMT+R7b+FrPUhVfneXT+IL/4cux7BQGLEjhRp0a/i+XiuFGNR6HKiFymHLp08RCQobIEgyVFAz7/EHzBiy3Qb/bIlAkqEJ6yIP2qZbjnfs0tiJ5WL31GTrCzDNnOXR81iul1x1JJR8aJURYdqBW4LCqRscH0bDw4resaxyV7vOauH9mgafbJNeVj20QQJPTZiioFO5dNk0GfOxduvYD0/xc9ufhxXiOdq0w5gACnVs4DEgE5AxOLXr4c0E3gYb4cgsNccPHVOJAh68dD2mcUXRR8j+xSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 07:25:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:25:33 +0000
Date: Wed, 1 Apr 2026 10:25:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC}
 and simplify calculation
Message-ID: <20260401072523.GA1725933@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-2-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-2-royujjal@gmail.com>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 299b4b2c-a14a-4cea-771e-08de8fbfdcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mxUu2VIRzA+HPzJT+IG4RooCj0LQRu1NrpGDkKlF/TLISfEsnKFkazLzFybgvwoR+9NjEzv0FhxFyy3htY0oouhHrB7a0S9nYBDGoGzF6tUEi02YIb+wS6tPfWdvVBn6nXkYp2xCf5ZR77/TAIYoSaAm9FNEOcEl8jGN/ltzBxQHgu8N84Imj2u+GRNfYSvCHc6oD2HVcWEy81HNECHhwsirqXDWZFwC5DCTIpjPPxHp0cvlxTEE6c4MNN9NZLvJcRQtEIzHWSfl9DXsfc1QH/qliDcTi1Zprlk8rj9kkwcDAAO7db3ZC9jljm0diIOQjCd9D4VMnADktW8UNppXCcKqI3G+8rdrZattOyP3wa2RY5hKR/7J89m5NQv+A9Wp+AfW0/RpyT8qGiGDPxKLYHTcZ1iznxXRKT27y5aR/6DcNtATaFAxFjKeafdWZXiNwVYl7SwwvIuoYqIJY9DMsb2LB+xH3pIeti64aGW6SRH8K63XXnpvQ5yZ7SuN+6xYj/b9U+2Q10YcMUgky+stqbXmo/9qAmwmBMVzzsRAE5kOugvpKf0LT5QL/UfgG6o7lk3WsLk2dASnC7ae6Wl4Zf6Jehp84KWd4xuPNbfNfvaG1S+2IhfvwsRUtJFUDHoxn3E0LqME4TiVVYaZT34l0vbc3RWsRoon2AGJ5ykB1PTzonrgBHfMnFY6kE3TnPVgEaGwTDLpoO/qxmz55CITVpgX4EeYeuhbicxf70GEsGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4UgJBRdd1tIrFWeoNGmfMyECVemo6ibjEIAHua5awgzzo974lXOTsk9PIuez?=
 =?us-ascii?Q?IB/Ev1GfP7LH7ZGColcGfaziHakHR2MJZ9m+oyVKvo1uS68sb0VnvN3hXFs9?=
 =?us-ascii?Q?7U1MRnAMgP3d959q4wLg09NV7GAOjAhG2K75kAah9fBKzmPmF4prX9t6ipt6?=
 =?us-ascii?Q?hVTG5BAsRJMTHnJH+WrrWIhZcz9hrR9jksdpNjnnfJbiP0T/dAk4RmCawBQV?=
 =?us-ascii?Q?HTzw4/6dxpLDCB48RDlGxQUPZqPOtOV5fAbVlT26C40hTNf3Iv9JX1s+IYHQ?=
 =?us-ascii?Q?5Zy4okaKeGdu3kcrB1uI9rt9Eh3C0oLfjfLpGVdnA9g/+/NEjE3iJabjNwiA?=
 =?us-ascii?Q?9+bL/vl9xSQSG9Hia65qKHRwIlkV05+3Kg1TN8N5elrafxtXhZJp4GLVUQb2?=
 =?us-ascii?Q?kLPx7K+Z07dVygsnmJePKvXVLOqqCMf2Py4ZqATAK5//cYsNIgRJPWCVvbd6?=
 =?us-ascii?Q?5SOK4AZGFewm0E/GZ4BtXzOP36NYGvVIPiTVQ6CtHpG8on+NuTFj3Q+2weOd?=
 =?us-ascii?Q?Q6bjOsUNjAPZPvzPxwltj5foRexJYhlzhbSp3p+xdwEYzIHI7yoE+FXZa0LK?=
 =?us-ascii?Q?aqUjLBlo1pjcsuQ68g+MewMTbITck1xEo2D4rGl5APReWes3rI0hw0Di8Gi1?=
 =?us-ascii?Q?hWeRqSQhd/G46b2+4u4ueAGvNnKkgIqGPsznU2EdPSXf17q7NTtFI5gYuNx0?=
 =?us-ascii?Q?QMI8xDTF/PExKIJ/63TNpjTIrYk9XtdO2JgN0hbIXYsP66mEocfpTFzJ0AoB?=
 =?us-ascii?Q?+mxQFL8UyPNeGv+f/BruVewzYqYcPwb7Xz1vlzZvA31qOozD2eUVkbxyB7bw?=
 =?us-ascii?Q?1kSqsKVfVXM8eE+wlQDCeYSxP8dBadD7TITqBtrpQ5DkeI1E2g09w3RmOp+k?=
 =?us-ascii?Q?upIlUt8crW+xavZZs0lWa89FCKa09ApXWKFfmcptisfomR10yFg3HpS/Vc6A?=
 =?us-ascii?Q?ZitjsfB133xNbFpzAbaMBqLQRMLb553nK0oX2OnXuBkdCed0zgP0sHNJyki3?=
 =?us-ascii?Q?NVhMxgHwD9oDC8HQTK5JM3bdNCKgu5aEQtk9+Ne1gRqEhavcVSDIUt2Jlp+c?=
 =?us-ascii?Q?co+5RDHy33YqF3fQ2DXlSmUQFVwJb359Qu6sXixeul9MUddyHCyX/sKnzLL0?=
 =?us-ascii?Q?s/XuwSiyixGbRXJqTnjk2RzwaKkxk9gnRKxuXm9n4ix3rstg3jDNS+aDDZem?=
 =?us-ascii?Q?E+UKyLDHy1oq0gET0J0Jvww/agMit1xCgCjSogYlP5CEDEXM79raNj60cnbw?=
 =?us-ascii?Q?SLztP528uGEyabPwzNN/wLydIpWMhNtDamlvhj6u6GoTupbctBk/01nM/lCc?=
 =?us-ascii?Q?MeGRvYRP4ZvuX/U8VLaNfrlK0Y1EqDgfjNb13g1VpGHkqDJuL4+N2iS6UkiA?=
 =?us-ascii?Q?cz7mcnJVWVoff8syysfKsuDibrKa73z12EdneOqNNrG+zXU5NeCT3ZA2C5ji?=
 =?us-ascii?Q?aibX2bcjYdgT+WT8NW9s91x5kheJwlU6KJ76wfqPFBJm/SMKcqylb7UF3n9F?=
 =?us-ascii?Q?aXUuZ1VB2W6t3gvcmAPNbkqBGKneKe6ZYcVV5OI59qBN0J5zmhdN+xlC1U2/?=
 =?us-ascii?Q?gmTqP3OJVPjX24cFrtEogFykAbgKtxiQwds+9d7+K3bXLQnTab7weAgOY4jJ?=
 =?us-ascii?Q?Dq5DjQoQeqMzO6Q0/VONT89mgChJ9SxruAYlriTDyk1n2+E1WIcl4Eg6meFH?=
 =?us-ascii?Q?NKAuJYh3E8EHhH5NbuYdvGpOuRwOhj87eFbq6i+/Z8MZUUxt7MtEu4e2/+e7?=
 =?us-ascii?Q?i5Rvt7svGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299b4b2c-a14a-4cea-771e-08de8fbfdcad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:25:33.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEmfRxoSop6+t3c70hX1LufcjTk2vNizpm/ZJevwTEnzPoiPszCfNsFteSWuuVwIcVXhudyiysk2ujNCVeux9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273943-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: BBDB8375DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:16:07PM +0000, Ujjal Roy wrote:
> Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
> calculate the Max Resp Time from the Maximum Response Code.
> 
> Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
> the Querier's Query Interval from the QQIC field.
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>  include/linux/igmp.h      | 78 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_multicast.c |  2 +-
>  net/ipv4/igmp.c           |  6 +--
>  3 files changed, 74 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index 073b30a9b850..3c12c0a63492 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -92,15 +92,77 @@ struct ip_mc_list {
>  	struct rcu_head		rcu;
>  };
>  
> +/* RFC3376, relevant sections:
> + *  - 4.1.1. Maximum Response Code
> + *  - 4.1.7. QQIC (Querier's Query Interval Code)
> + *
> + * If Max Resp Code >= 128, Max Resp Code represents a floating-point
> + * value as follows:
> + * If QQIC >= 128, QQIC represents a floating-point value as follows:

You have "as follows:" twice. Reword it to make it clear that both
fields are encoded the same.

Please also mention that MRT is in units of 100ms (0.1 seconds) and that
QQIC is in units of seconds.

> + *
> + *  0 1 2 3 4 5 6 7
> + * +-+-+-+-+-+-+-+-+
> + * |1| exp | mant  |
> + * +-+-+-+-+-+-+-+-+
> + */
> +#define IGMPV3_FP_EXP(value)		(((value) >> 4) & 0x07)
> +#define IGMPV3_FP_MAN(value)		((value) & 0x0f)
> +
> +/* IGMPV3 floating-point exponential field threshold */
> +#define IGMPV3_EXP_MIN_THRESHOLD	128
> +
>  /* V3 exponential field decoding */
> -#define IGMPV3_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & (value))
> -#define IGMPV3_EXP(thresh, nbmant, nbexp, value) \
> -	((value) < (thresh) ? (value) : \
> -        ((IGMPV3_MASK(value, nbmant) | (1<<(nbmant))) << \
> -         (IGMPV3_MASK((value) >> (nbmant), nbexp) + (nbexp))))
> -
> -#define IGMPV3_QQIC(value) IGMPV3_EXP(0x80, 4, 3, value)
> -#define IGMPV3_MRC(value) IGMPV3_EXP(0x80, 4, 3, value)
> +
> +/*
> + * IGMPv3 QQI/MRT 8-bit exponential field decode.
> + *
> + * RFC3376, 4.1.1 & 4.1.7. defines the decoding formula:
> + *      0 1 2 3 4 5 6 7
> + *     +-+-+-+-+-+-+-+-+
> + *     |1| exp | mant  |
> + *     +-+-+-+-+-+-+-+-+
> + * Max Resp Time = (mant | 0x10) << (exp + 3)
> + * QQI = (mant | 0x10) << (exp + 3)
> + */

You are mixing two different styles of comments. Please use netdev style
comments like you have above:

/* IGMPv3 QQI/MRT 8-bit exponential field decode.
 * [...]
 */

Same in other places throughout the patchset.

> +static inline unsigned long igmpv3_exp_field_decode(const u8 code)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.1. Maximum Response Code
> +	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
> +	 */
> +	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
> +		return (unsigned long)code;

return code;

> +	} else {
> +		unsigned long mc_man, mc_exp;
> +
> +		mc_exp = IGMPV3_FP_EXP(code);
> +		mc_man = IGMPV3_FP_MAN(code);
> +
> +		return ((mc_man | 0x10) << (mc_exp + 3));

return (mc_man | 0x10) << (mc_exp + 3);

> +	}
> +}
> +
> +/* Calculate Max Resp Time from Maximum Response Code */
> +static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.1. Maximum Response Code
> +	 *  - 8.3. Query Response Interval
> +	 */
> +	return igmpv3_exp_field_decode(ih3->code);
> +}
> +
> +/* Calculate Querier's Query Interval from Querier's Query Interval Code */
> +static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
> +	 *  - 8.2. Query Interval
> +	 *  - 8.12. Older Version Querier Present Timeout
> +	 *    (the [Query Interval] in the last Query received)
> +	 */
> +	return igmpv3_exp_field_decode(ih3->qqic);
> +}
>  
>  static inline int ip_mc_may_pull(struct sk_buff *skb, unsigned int len)
>  {
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..9fec76e887bc 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -3518,7 +3518,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
>  			goto out;
>  
>  		max_delay = ih3->code ?
> -			    IGMPV3_MRC(ih3->code) * (HZ / IGMP_TIMER_SCALE) : 1;
> +			    igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE) : 1;
>  	} else {
>  		goto out;
>  	}
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index a674fb44ec25..8c6102737096 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  		 * different encoding. We use the v3 encoding as more likely
>  		 * to be intended in a v3 query.
>  		 */
> -		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
> +		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);

Given you are modifying the line, adjust it to:

max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);

Same in other places where you are already modifying a line.

>  		if (!max_delay)
>  			max_delay = 1;	/* can't mod w/ 0 */
>  	} else { /* v3 */
> @@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  			ih3 = igmpv3_query_hdr(skb);
>  		}
>  
> -		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
> +		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);
>  		if (!max_delay)
>  			max_delay = 1;	/* can't mod w/ 0 */
>  		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
> @@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  		 * configured value.
>  		 */
>  		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
> -		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
> +		in_dev->mr_qi = igmpv3_qqi(ih3)*HZ ?: IGMP_QUERY_INTERVAL;
>  
>  		/* RFC3376, 8.3. Query Response Interval:
>  		 * The number of seconds represented by the [Query Response
> -- 
> 2.43.0
> 

