Return-Path: <netdev+bounces-275999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BSvKUAK1WnMzgcAu9opvQ
	(envelope-from <netdev+bounces-275999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FEA3AF61D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA829300C372
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAF3B388D;
	Tue,  7 Apr 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvcu2GxP"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFE38F631;
	Tue,  7 Apr 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569467; cv=fail; b=nBBvIfNqKZZpJZso4WpikSngxxfa8prw4O2ocbMBfFrkkbCPRbynh71VRq5bqhjPnAU3gRu3DiSCEstC16xIFnBcc68fCNyP6v8DEd8/b/SyNNutC0650ANsKRvmJac25GdwPiQeyFVC8VZbKiyTjE4HC1sccbLdmNlqShL1Tnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569467; c=relaxed/simple;
	bh=6FEGT8Yv7dN2BxupKh16zPrAF51KoqNsta81aJed99U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGQ9CA8JzQELoNvBcEkHgWbbnbx8L5Cfb2XbqLCSNbt9X08IUrCg28UJovS95WSOOi8ukqt60IMZE4Jzk3QT60+g4xjNb6tw1c/4PjlhwcaJ2W5vp8LwgWVrQ/qa8Fu5WZbATHa8Z/BE2NXOgzczSVJwYyx2eHBCXhi7c1mlUEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pvcu2GxP; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvkVSa/udf9+88hOEvS4+F0EJaHvU7GFyYpHdNC+9FuDvgXyQ8V3pMQcDWRzAiYnUs7ZeHGiTv1nRlKNRL6f5rexQHMOpFzStR2pZCLiVPhY3lPslM10+sbYCS7uzKf1mcTwg375giiBGAoPLLfpQtOB1feTtyaUrapsVQGaQST1jBfWo3qdmzpVP9U6kVfRhtBmbClbAVCC1dZ71fYl4CjxAUDCuzyo0YjcJxXcycJhwFZN4Oqw+o1jsJeIduKgZp+hTtabHHOW6t+zfpYEOUcrzJUa5Z1Lk5XqhztuM69SX10jXBdtv5aHfl2d1P7B9X1yWFBlrVOs3w/LgtOfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fzHsRKD/tR2zXRIlzt+4DJ5PvQAEWVVTzJwCQWX/6A=;
 b=kBQEG1ZvYT1Q1uNssy6G0UYGLhWEMyi5DLJ3g0KrCXr9kyYHNu+X84UmasC6Eppmtc4rtHoEZBd5wqX4EhCizdexcznT4sSaRTKqK3zqgoWRClZqDI6Qb5doBX6QWGanjLIrfmqC8MoggaONk+vF2r/BPJ60nhypgN3mKOSHmQpagXNrMF2fdCCwfD2iZRlfUAo17FKCqGtoCcflVD4YKPz2rH7L+YxgVYnkToorbDYUxfNvT1yVVIKb2MqXm2m6BiMkHawkzZ1d0f3s8gmanG0yQ3esuuV9aotAxA/4sBx96tDuL6/nvZBH95D2yyvrYe8yCE21TJpqkLfJ55TDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fzHsRKD/tR2zXRIlzt+4DJ5PvQAEWVVTzJwCQWX/6A=;
 b=pvcu2GxPKERqTZozPFZHJyIj5JFdKYPdAbV/krlMmlHlq3w6Jnhq33VCfZZm5/HCbPfbTGwQbRwS36jDXbk3bjq74ebuuhBAUzbOMjm4YfvWrwObl2elH/16UrvNWS6Xt4wIqkNsjlPpWQfH3CjlKd0dgSFigSkVOrACbG20d1hQrsYLJ/ohp0cIV8K7uZ4cqxLQIP9jme90MKIiJP5OcCIxs6KhSzZEnFngKqhQGbPBepUg8FgoA20A+CQXXgYGshQqzxIBL4jm/WGb0zMvw/5mzKoJF9EBfS/W2sYj5HMrpS1Lc3bPhOyVaUuZcHH4sOebmGPfKr/SyqzarYxnLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 13:44:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:44:22 +0000
Date: Tue, 7 Apr 2026 16:44:11 +0300
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
Subject: Re: [PATCH net-next v3 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC}
 and simplify calculation
Message-ID: <20260407134411.GA849209@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-2-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403150050.1235-2-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 91db5b94-c7a8-4afc-6253-08de94abc676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gfT7qogVTcflgSwSmsqvT9X552tFGBzMdAwmhiKCUzG2oZ5I4i35UilDYzBDLZOSyRzJ/5V1nTHqLIskZHd8ovopoz2OzX7K/njbDUinct25QIQoZg0Ru36kc5r9CzpCQu0neCzXxplrQRWWF+keSXZlxL+Ir1EfFlyB4IgRkj/r2Qz4XSS9OhyX1Pe3XPOYUk0HTxvFdqhBN2b0lXLOpY4Pi5aLC9e238bBcdn2sMan9pR9MS+u+4XTTtXop8CMYP+SnMhyPB3p7gFjKu5NYA8nlCTJ0ebi4INT5kqfmUmWHJ7dZKMreOnqgSe1wUS9qlCor7NSsQzd1PbX68pyyHV6OQkLVHcsFPQ2gixfhWN0bkD50KuMaVAOEpWj9bmruMeTwXaUSxvRFkWyfu1Hv503kyj8FNuQ3c7WbC9BfYAGTyE9kywgWybDd8o4PMr1RG+D0m+uaGdYLl24BUNmfQ3VqnUjhsonwcBGmoZfM3+fhXJJpZr2Txvfl59J8CrJNW7L2lIcct2V4Qdq3MKhJs4Ai4Vl3y5i2nKhQ5EHNz1b4fOQssxtJALsVOEH9wSlPbrcmB98ZSroV6OcETb9etJGgYLTFNlIeET9AX3ZBLMjysPERzavGS/WkkN/XxDqKGARxxGGGjR5ZttYiv1vCBO/LBlWDhjuuWKmASCjkIZ3SfrfeWgqtIBmRGS2LgCAG821zwXbGuul+2HQC4wkTH3PxzRPEAwePkp8iC38CD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYvUIJJcfIq6ATtRqKW0x/6XuUT9IjIVBvJnoROUb/Bcdzpy3VFioHP0X0BK?=
 =?us-ascii?Q?EpWDnOuzcm5g+hDmWC+uiXdjGNqZB+aPay/5nTQAVBY6nl/Vd62YG2nmIzix?=
 =?us-ascii?Q?TK7E6NZju2V5nKSmow52avgMTk6cuSeclUDfTn1FfOowJX3v3UPz8k0mcGox?=
 =?us-ascii?Q?1Ep8517+uS4UgKSk0de8votaT4ezHaLa5ftk9NyCVZk8E/NKVE26IEPc57Ep?=
 =?us-ascii?Q?ItAPT85ssQSKSdA05D+9oDPfy9k4ssyyXj8M+tZ5e9/EjYRGng22CACf9iRX?=
 =?us-ascii?Q?6KpO8USTmjwyhzwL8X9KVbGYV5bwCLlaY/tGRJMLiqgvFqdm+LLLHRJR8pln?=
 =?us-ascii?Q?FpkmO5u/8eXP0qcXdVr4guMPLLBb2ZmqjTGsn79m7Sw+Xkrv5oDDzvzigOKa?=
 =?us-ascii?Q?aC7lBd4ktcvuh2x2DtlzgtvEqYhlgs/rhff/p2HMBd6YMODBUyQrm7o/Mwvp?=
 =?us-ascii?Q?S2KSjeLi4W04bzvN8/xyjz/GzBayRYgnmYtmIIkmSBWdriKVEihJa6bpVgMN?=
 =?us-ascii?Q?XaARDixAFQMf94vKtuyr8ZyNlXmDWyfV66DcUfVu/89mt2iNFHEY8asLMORg?=
 =?us-ascii?Q?LVHlfhU4RWRCBuP22GX48ajw4lYpAxQkD1YeJ9mWBu023su7GFndyRMPfZL5?=
 =?us-ascii?Q?YBarAamn4J4sW7/D02CJ2qKY2PSEFH+sZgBG2A+/yD4O9r7wGHR/lOCrSbpl?=
 =?us-ascii?Q?sZKZ0mmHPNGhcdJ/AMDHzJB9HVL5h0g63cuj3yn/r2xrSSOhJv1v5o2Z0tLz?=
 =?us-ascii?Q?/oFln8i6B9nOc0fydawvXpMqys1PvqtzqCUr05hSQ8NeSwnIu2zo5YOijb4U?=
 =?us-ascii?Q?wf79kOX/v2w8oAAFcxJ+0/NLF9m0eoEuWuK5nReXWqIbSv0MHT31jkyR4DwZ?=
 =?us-ascii?Q?6vOwctz30swKwnSCBq0EVhrDqxCijkQ4skgLOiwHqZYfMFmY3DTkKDvlIV4g?=
 =?us-ascii?Q?47KdkTuJCSqhIs8Ywopg8CNjjciiLGtX965tkjZiU1LmjHl5rKUPDVb6RJtI?=
 =?us-ascii?Q?A0XeSVs4poacQ8dI4AFmIVsAAuCLVDqSkVonvdSfjqaVshJ3xvdZUXoPMNP2?=
 =?us-ascii?Q?sBRgdek6wVWJMwK2USYY7Ni8QSeqRwtZaIsHA1v5CBk/cN/hg+ZE9fH0dgsE?=
 =?us-ascii?Q?+/oWTLxiC+JYgJ9jJR94M98TDKQWMunx6e7ArYESRL0Qx0SYllLRBkbmofFg?=
 =?us-ascii?Q?R5O3h5FA3oid/rmIFgbtXMDQh/hLsR1odIe6BiCKLY9jg6wJ7vtBqQYBEi+W?=
 =?us-ascii?Q?R8GSJ11SZSWWTr9ltNI9hI2mOHbXi9b1oveV7IIMqgXY9v6D8U6WKOCHn5Pi?=
 =?us-ascii?Q?pSrvqCvbhhOAfwVciKzmfF5DscEfDAFI3oV1vabepzPgCNsL25Lb1YaBx6cP?=
 =?us-ascii?Q?vKMsTKyYKLKBk3eS7FhaR+lyciB5EwXKnCfPXtAk7cBPXhkQD5QkdFy4qW1Y?=
 =?us-ascii?Q?aF3Z68h+1t4eQkgIwdDRY+5YIKjQ7KJgrR93hCkZVhDFKDzdyXOesiOhvf5L?=
 =?us-ascii?Q?6Hszm4anEivG0E5G9AoE4lkjpG3kohylhPPy/Fe7o0Z2yFqy73hLJvYdv+vK?=
 =?us-ascii?Q?CMEg0X+sy7RdIBe+bqF0snRscs343OOTtaizv1F9sofQMesMxHrSaVybsG8V?=
 =?us-ascii?Q?UglXWqe6SQvFgsAh12KnQyiGhvTZtomxAos/GE95ZEiWV0f1Zeb3uDT+qum4?=
 =?us-ascii?Q?hjNDcMN8NJXAkGaNuQaNcBkL8jQvAbnqtAdoIwB6tXTHN8+L8s18O3ymoSot?=
 =?us-ascii?Q?jw76j7gAoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91db5b94-c7a8-4afc-6253-08de94abc676
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:44:22.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcTXEYWxIVv+W3MbCLGjlgYMkhGrW4lLZmmapmlWuLw0mIs9hzzpjME4M/zfSMIzJhJYqF1E7eDzp+iZWIAyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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
	TAGGED_FROM(0.00)[bounces-275999-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C7FEA3AF61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:00:46PM +0000, Ujjal Roy wrote:
> Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
> calculate the Max Resp Time from the Maximum Response Code.
> 
> Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
> the Querier's Query Interval from the QQIC field.
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>

Looks fine, but see a few nits below

> ---
>  include/linux/igmp.h      | 84 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_multicast.c |  2 +-
>  net/ipv4/igmp.c           |  6 +--
>  3 files changed, 80 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index 073b30a9b850..0624410e75c6 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -92,15 +92,83 @@ struct ip_mc_list {
>  	struct rcu_head		rcu;
>  };
>  
> +/* RFC3376, relevant sections:
> + *  - 4.1.1. Maximum Response Code
> + *  - 4.1.7. QQIC (Querier's Query Interval Code)
> + *
> + * For both MRC and QQIC, values >= 128 use the same floating-point
> + * encoding as follows:
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
> +/* IGMPv3 QQIC/MRC 8-bit exponential field decode.
> + *
> + * RFC3376, 4.1.1 & 4.1.7. defines the decoding formula:
> + *      0 1 2 3 4 5 6 7
> + *     +-+-+-+-+-+-+-+-+
> + *     |1| exp | mant  |
> + *     +-+-+-+-+-+-+-+-+
> + * Max Resp Time = (mant | 0x10) << (exp + 3)
> + * QQI = (mant | 0x10) << (exp + 3)
> + */
> +static inline unsigned long igmpv3_exp_field_decode(const u8 code)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.1. Maximum Response Code
> +	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
> +	 */

I find it weird to have a comment at the beginning of the function when
there's already a comment above the function. Let's remove this comment
since this information is already present in the MRC/QQIC functions
below.

> +	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
> +		return code;
> +	} else {
> +		unsigned long mc_man, mc_exp;
> +
> +		mc_exp = IGMPV3_FP_EXP(code);
> +		mc_man = IGMPV3_FP_MAN(code);
> +
> +		return (mc_man | 0x10) << (mc_exp + 3);
> +	}
> +}
> +
> +/* Calculate Max Resp Time from Maximum Response Code
> + *
> + * After decode, MRC represents the Maximum Response Time (MRT) in units
> + * of 0.1 seconds (100 ms).
> + */
> +static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.1. Maximum Response Code
> +	 *  - 8.3. Query Response Interval
> +	 */

Please move this to the comment above the function

> +	return igmpv3_exp_field_decode(ih3->code);
> +}
> +
> +/* Calculate Querier's Query Interval from Querier's Query Interval Code
> + *
> + * After decode, QQIC represents the Querier's Query Interval in units
> + * of seconds.
> + */
> +static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
> +{
> +	/* RFC3376, relevant sections:
> +	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
> +	 *  - 8.2. Query Interval
> +	 *  - 8.12. Older Version Querier Present Timeout
> +	 *    (the [Query Interval] in the last Query received)
> +	 */

Likewise

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
> index a674fb44ec25..d7eff36d98c3 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  		 * different encoding. We use the v3 encoding as more likely
>  		 * to be intended in a v3 query.
>  		 */
> -		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
> +		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
>  		if (!max_delay)
>  			max_delay = 1;	/* can't mod w/ 0 */
>  	} else { /* v3 */
> @@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  			ih3 = igmpv3_query_hdr(skb);
>  		}
>  
> -		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
> +		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
>  		if (!max_delay)
>  			max_delay = 1;	/* can't mod w/ 0 */
>  		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
> @@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  		 * configured value.
>  		 */
>  		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
> -		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
> +		in_dev->mr_qi = igmpv3_qqi(ih3) * HZ ? : IGMP_QUERY_INTERVAL;
>  
>  		/* RFC3376, 8.3. Query Response Interval:
>  		 * The number of seconds represented by the [Query Response
> -- 
> 2.43.0
> 

