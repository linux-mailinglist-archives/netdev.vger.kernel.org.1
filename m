Return-Path: <netdev+bounces-273948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFcjDSvNzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:45:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97365376391
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096C0316EC9D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEE3822BF;
	Wed,  1 Apr 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0ZMOI6e"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5A199EAD;
	Wed,  1 Apr 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028569; cv=fail; b=i16jIcjIC1v9SZ93IhgZeveFBiAIP6aKDgv5bh2OIEIx2nrmLdMdXEe3HJbMN24068uD7/aqspXA6G/Geuf92fJbOegGuv+4CoGWF4KsLRwkq6i5fUNyql7dm8jcMvkiR2OqjPp+njddiU+YYW7u0ArCCASibEq43Uw3K51PNM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028569; c=relaxed/simple;
	bh=Y9ljPxxPRHGMyKoqycwZ0YWbbCVEyDPaPKsXs3AKQbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qQgcFfctI4KVZKOtWdcM52PfUUobhcpj/YUWT58pk6dibnE53x4zV0gvnuEoRNP5BxpcUgicVIRuc/54/yDE3QQlejmLm7ypapk/9C/zjJqK47pFVqHElGMb2m0gzxqXWn3wjoN1J7MoutsFwD1py94bIsmK9hEyXrhi5wsTOqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0ZMOI6e; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUEO1aB0CE4yhweR3rBzfFumiTGqL3J7TDY1JaewBxuZ0djH22AoheHrwfPYj6+yIQz4snmtgiDa3umbkLZu/OLrdvxVf2bmOjhlZDKlIgsurRje0oAYBPNhYdhXEaWlw5wys5UdJmXwPIguk/EEqDytHo2rBdhahKH44dq7ZezyknG6o2st0dfh+Vj9HSz0TvV/cF3zJifLS5Bd44TG6zqwqMJ3JXZCjf74bT1lhXiG0EmBk4TLIZGqjEHT2dzArE+tANlxeL3ykUh8YSh792zMBRFM7vX7R85iYXfcM1K+Bxs2VCNItKS7yXrJIQ3iPHiIV1FUsvERS6eOkBiG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYIRJHIFJSem6Kn893qDTxpEyyAliy21AcWwn3ydexA=;
 b=qinre0uXTKWgCLtuc5BxTKkZFugABSq/WUTNFSUwb2Lf6RuooGYaqGY/0uNZl8W3WkSjQmLGPRpYl8fjy397YEfJBBvakgzYq85wxjaSDIPfxPUsYXYzZJFCUtjd/QF9t4FRkniaFnel08/x+B2Ihnuzoixk1EIXSUKxUuHgdj1JW68KzOVVykrzDfGSdVUApXnxh9FvfKUO0r3Rar9B/fk4Us73Noe6Vrq+2SdoJ8/Og4rHnnXts7awiznmwxdkTbx52usqNO7G0ADQIWlSMdg9w/k1BZlaPXDyLEe9YAPJe53s6XO/08uH1qedUwerx+xVjLiaXOBzi8dIfy8Nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYIRJHIFJSem6Kn893qDTxpEyyAliy21AcWwn3ydexA=;
 b=O0ZMOI6e0WvSP0iGuaVigUQ25a/94eVyhOClgUS2gmhq8GH7H9PpgG6EfWoh9bv83qqbffHXRS1LBXZAx4BYN7YBFcwYLpw0gzgxnlPFeK3wAfcpiI9KA5tiMq4Qdx9Tb/f+b8lK76tG3I6V/x63OAblu5G6hR2Z5ewUWr7bd8psm7trdTRajWhcRZyPlzIAo3gE0t1CngONX26AeGY1XfquWS/84hyVVzekQUyJWvd25l7nhrpgTRAO+XriWNNulGUbZ7s8n3vXn/M5A37E+jc/qAEDBCgIxGvAqAp1QZ5w1wvG9OoywkKkOg1hpbo6udesH5rb+zHUhc78U+cvhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 07:29:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:29:24 +0000
Date: Wed, 1 Apr 2026 10:29:15 +0300
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
Subject: Re: [PATCH net-next v2 4/5] ipv6: mld: encode multicast exponential
 fields
Message-ID: <20260401072915.GD1725933@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-5-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-5-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 61609adf-083e-4e49-7b46-08de8fc065fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sLapu+MV2yJrqmjdE5JTbJlxjARIorNUJ5mI83cw9hR4+EwIT6pNsG0D+J7hHV3nNdRWuOORele3CJw1KSiEW9Rsxgq9viYctqTSwri+lokoECEiEIUoth+1Ji+AbcgK9vubQHW3mMpMgJ22G12XoglWNfzLUxhf2x9f0gqyCLv41poKLbEQ4nRIwYo2fn9nXhwmu0y296N3hJybMVy89zAThI3McinSh1NyLyhGEsHv9t1uAPyhe8x33D3YJ2JujMaqGFki79etdynBR9ZJS1tbBF+f06hj1nBOPISOHfYNsCXkKdOJosULExS/NsHOiwNgWnmcWSZOvKdXJZUa5B6DazC3zNAsiAvu2XYcG9KbrC5MX/i6X92Y8z+CwzGjeFD7EVfdUEqzes5uh9AhSc6QA8jKBNE54Pm5Hr62jH4hgb63tam5Rl5U3eKmod26rGEOQcJiLWq3NF9PeozPlZ9kW57Rkvm+VrRYIjz7vpYsHTPbiDvOrG7LxVqVCcmUntWU5qXvbs13PAJ4LJntgXS88mhf/lbzVQD4il9a2ABrOBJWQWUt06zVI5ZrGYze491KZ8FLfho669x8sDmCdpRbwle7wwpawQjZ9oJCkTmmrBbaa4BGxm8TuG9DV1bbnjwS+1jmAEgwp2gr6xkpDbladmt5XZC+0Y1eCff0q+sLAVn7plJkuu1xNqcqxMq1oFWzJ8myjqOnlrZaO0ebyuVHSHK0W0tjGc78BSJe22E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdSi1Xs2PifshplKvWBOzYJ3M5xunD0uGopJvY95tS6MCGHTW8Q5A4ZejZVy?=
 =?us-ascii?Q?IfbR1xtgi0AaF80oNWGulOGZvSGISl+kZLmVJqG3xxYmGHYAegNPKS2JncNS?=
 =?us-ascii?Q?lWTGa1doSxnhjy++mF7h9QwjbnvnjyzJBuFGpsPlQcyzUQTzJQ7V8BCDAeKY?=
 =?us-ascii?Q?+9WKqwjNe4pPxTlTAmOIOVcKyHAfcThIeA+TGuEHYCMxR67h7dC1NCbXAHjI?=
 =?us-ascii?Q?s4frCQLXbS0ADnSvIWusRh/LPPwvlxk106nepmy5oSfFU5FBd/g3bFi9mAQU?=
 =?us-ascii?Q?4J4CZhV+OrimAp0cIFcALwc06W+ibKQtpXDpcD7i2e4mWEQ+snJKNcpV0v1Z?=
 =?us-ascii?Q?cQPfpzPAY1xObCpqTxWRf934aipfdZQK/2WqIRgxYaZnqLQxOmyJ2FkAreTP?=
 =?us-ascii?Q?4Hw80ZZ1nDRioiU+gJXewZ9l3HrNbdAA77l6Qzw1zDGGQk6st+0QDE8zii/x?=
 =?us-ascii?Q?1yg2zd1CgdqlCn9I2gtrWV0eOZxIx1NkmD4jctRdAjJFQPomQMNlTiqBndFN?=
 =?us-ascii?Q?MM87sFzWKYoa0c63natoolK43TLLPxQhMyk5itF9Ah7Crx7QH348V3c6+otm?=
 =?us-ascii?Q?Pop7zE84c+MGLGSTVmWglDvmhVlxnvGkzsVTC8EfFKtGK04ft4XnrrJO0K8s?=
 =?us-ascii?Q?g0Lw6lv5Nth26f3xWVOlkAlBvmYi6+zTh7NABYqzRszZ9xd3hFxswdKk609t?=
 =?us-ascii?Q?xsjdYzsPZSVqSpT4wU6B9C+eAL9RWW6qnqJ2Yz29sADEvmS+iR2V0fQf1MuN?=
 =?us-ascii?Q?+XZC0z6nZ+YvL1jHh6utgb5eqaItngK2LHzOG7tuRFnUT+s3wp4cogRYRyE0?=
 =?us-ascii?Q?DHtZn+iwKpioOlvZCK0iAWCqVBMFOxHG8RtKP0W7vc0fVSvu++ezHKpW4w0a?=
 =?us-ascii?Q?k4RNIzxk4YB+fS+UfPTx/QpugawAGlGUIy0tzN3xN0nhJkh85Jk1RGBMYH4N?=
 =?us-ascii?Q?VaP9kaH1YMPyGHG7safDM6koOQ3S8YdBOQwNb4cO/e5QYYxan4SQGlvvzsKM?=
 =?us-ascii?Q?rKHZphriK5gKVGrEGgzNNDJXcFc2QKZir5cisK5WosKSyX55suy9X999D5nM?=
 =?us-ascii?Q?KQ6D/qFs2NaNJg05CFMOQj5EmyCJTuDunRX/g68sWyjB83+cLwmFQQs6wW80?=
 =?us-ascii?Q?6rJbGzB7JpMwuMWjBlmgrAlhiMOdpc7Qe5uBHQlxSb2kfWDBf1jePxKv5GhQ?=
 =?us-ascii?Q?pY2KuxIIJFf7iXGoa0D6v3/st3IN+1OKAjcvQ+vgWXfyfQHdwgt1Hd9nCcA1?=
 =?us-ascii?Q?TaN88coL/45UtHEfga8YXLI+WsZwkw6UAjey5nD9jCeSfLf3bK0GdcI1wVLx?=
 =?us-ascii?Q?hrcgfVwj6F9CHlsm944cmtjeH0ofxqSSs4jDOn1lj43D//PxrtuRqZ3YdZTv?=
 =?us-ascii?Q?lat1YEn4Y9G1ibw3jnxyOfHazQL2tK34h4RXsmEwdx5kq6nZ5BF+0S+lHXdW?=
 =?us-ascii?Q?6iChIH/oKpv9SmJaIfOrrrRu+QO67r4PujmjJ++8vUtcdt6iX0jeKDdj9/aR?=
 =?us-ascii?Q?vun2mU7oZhFdlK/qtsJgfaIy42Ra0EXBcqJDP2r1rv538lDtwp7QeuCn0t9l?=
 =?us-ascii?Q?EHjEIdFmTqt3lKg555PAzodUlwR0C3OqmVtSOOxUq+IzcHVrdmnMNnoFwTIv?=
 =?us-ascii?Q?s0iwur9St/8FK445TVh3qzVKRlGFxIZwqBN1MoaIOnSiQ0d82QHoSDA5OKJT?=
 =?us-ascii?Q?ddXXG8EXWlRacPavTbn9YEiTLF4rN5s7DGuKyINKxkiqgKCY2/y58u74IBbW?=
 =?us-ascii?Q?RyyXE5xNZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61609adf-083e-4e49-7b46-08de8fc065fb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:29:24.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfS+EbKegTAF8w9pzUK+tR66hnUwLEbpHUGFWKlhsqs46nx8HK77hOx0MTIqykzLXdks3ElywBsZR89eQkRqwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273948-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97365376391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:16:10PM +0000, Ujjal Roy wrote:
> In MLD, QQIC and MRC fields are not currently encoded when

s/currently/correctly/

> generating query packets. Since the receiver of the query
> interprets these fields using the MLDv2 floating-point
> decoding logic, any raw interval value that exceeds the
> linear threshold is currently parsed incorrectly as an
> exponential value, leading to an incorrect interval
> calculation.

[...]

> +static inline u16 mldv2_mrc(unsigned long mrd)
> +{
> +	u16 mc_man, mc_exp;
> +
> +	/* RFC3810: MRC < 32768 is literal */
> +	if (mrd < MLD_MRC_MIN_THRESHOLD)
> +		return (u16)mrd;
> +
> +	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +	if (mrd >= MLD_MRC_MAX_THRESHOLD)
> +		return 0xFFFF;
> +
> +	mc_exp = (u16)(fls(mrd) - 16);
> +	mc_man = (u16)((mrd >> (mc_exp + 3)) & 0x0FFF);
> +
> +	return (0x8000 | (mc_exp << 12) | mc_man);
> +}

[...]

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 27010744d7ae..c2d144f6a86e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>  		break;
>  	case 2:
>  		mld2q = (struct mld2_query *)icmp6_hdr(skb);
> -		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
> +		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(mldv2_mrc(interval)));

This looks wrong. mldv2_mrc() is supposed to receive the maximum
response delay in milliseconds, but you are passing jiffies.

>  		mld2q->mld2q_type = ICMPV6_MGM_QUERY;
>  		mld2q->mld2q_code = 0;
>  		mld2q->mld2q_cksum = 0;
> @@ -1190,7 +1190,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>  		mld2q->mld2q_suppress = sflag;
>  		mld2q->mld2q_qrv = 2;
>  		mld2q->mld2q_nsrcs = htons(llqt_srcs);
> -		mld2q->mld2q_qqic = brmctx->multicast_query_interval / HZ;
> +		mld2q->mld2q_qqic = mldv2_qqic(brmctx->multicast_query_interval / HZ);
>  		mld2q->mld2q_mca = *group;
>  		csum = &mld2q->mld2q_cksum;
>  		csum_start = (void *)mld2q;
> -- 
> 2.43.0
> 

