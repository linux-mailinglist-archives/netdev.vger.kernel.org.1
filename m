Return-Path: <netdev+bounces-265639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBooG3wAr2kLLgIAu9opvQ
	(envelope-from <netdev+bounces-265639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:16:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529823D849
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E85CC30B0E57
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DC3E7162;
	Mon,  9 Mar 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKsXT9iU"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126853B52E6;
	Mon,  9 Mar 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075109; cv=fail; b=dogBKgeiKaVSzaMsD+hh8CKWTG/Gbm4VVSqdXgEMiFjD1pIp+Wj0MjGyAr7VIKtxIBpg8ufj7GsRg2q02Y99asghzEOqhceV3vcvH9R9YA4+mS6gS9mPHuQPtFKtxl1qosKQDDyGKQPWHDS3SnTzSi8tkEt/K0suKonaoDsQ/2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075109; c=relaxed/simple;
	bh=flVlsIj6fPtjjYTCKxMetNkvyltdYnGuL/5wA7/O7m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l47PBcI+XqR5UjqZHTpU2IAUKPodbil3/kZCCiptZ+3JerLtBFUREw9lxyAiDDSUkRByjt9gmQcMhpYKWqyfMutjETU7l1O9DOl1xOf5o8bldErmYT1FqXQ13Rwb3Xl+KidJvxvAMKbG9cxpkqTcf72812jR80xispk1wmg2iNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKsXT9iU reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyD1njZJzBKQBMv6vDKo4xtNq7W9HFB7U7X0vo+qkrL9pkFAQ+dcxoQcKdS182PAaep3lPx6RlO0tlXcvdWnYHn1XLtrw8awEsQ56Pf1koLKTPabalQnoi8chCRqY96rbuS9BseiqgBK3m3NpexdEFyUpCIXUa+hnB2H+vQ3kNqAcLdQjjkPlpwnSBTKeoe4NNL94sipDS5jY7tau1Jm5ZSYE6yqwgAPVAHZliade5XKf1n4Udpvbqi6U6x/0C6rfVDVKlT1bQ6Zeh0PfGSJ7zgAzaliF0aBU7SPXkrZpibRP8DJp5o68T388YEN/d6t0fmxDzGkupLsk7k/rUi8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlPIPNLZ/wAw81RZqdFIUwUFJVVE7iDZyn2RKgDQTeM=;
 b=xRNdJOg6VH7kLmYe7mdE+Wxy4r2bL+jcgJQrWb6oJ+n9wrx/mDaNVWlDDHzuvuesueQPguICEOb5Pg4N04lz/I8a6IKR2d6Y/8E/Z2g9ndE1PfsGGU/9IorMsNVVWBsM/Zeit4WB07+UeT3sFamlw7K+PZ9RRBUJ/6fxQhYS3GZg0I9PTEHdhqhJfXZKFisL/eRKPXrxDrCLdDJwK7mQjckIJPDmsMmloksMH0JEUt3F8DBfDEPrJqNCe4kQbAomUYyWJGDB6x0SnmUmlHHqlYnNWTJoBkmGonQkx50GXiwz9o0kWP2QJlqSQmxE5bLGq/G58uUOhtw8HP9WtQ8/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlPIPNLZ/wAw81RZqdFIUwUFJVVE7iDZyn2RKgDQTeM=;
 b=iKsXT9iUY8jdV9UnmQX9cAdF9oIBMWLeic1HfEeV4g/7JIWs7BuH86R+/WhFNMXB3v4xbLifWDN2TnCHPA4svwWEIe3+vLDKBwfouodgviWR9RN9UyyvOYMDbc1T/fcbHW/GKVOck7ykOhFeOiHG14IkNzx9OLESQ7yUtdvE8SXl/brD/ZVTB1lyVem+tfintM+5vnnAF7VM4cvd20RFrLgw3czBlBrkqkZMvUoG9d2NKqaKVpZFVZBV1ocYYMhZwFgYZAdl6cMjr5X3i8SxJIWrleXVSpBEDFPa+nInyoJIga32Wfz2YSK3XYdb4AtjTN7/jSHG7GXCObHrpyf2Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:51:43 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 16:51:43 +0000
Date: Mon, 9 Mar 2026 18:51:34 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v4 13/14] net: bridge: mcast: use combined
 active state in fast/data path
Message-ID: <20260309165134.GA2021040@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-14-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-14-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: c9677233-df95-4fc1-b69a-08de7dfc24a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	4LRlvUlkbM0EYqlHbP6o8MoF6LXM/vKKkjruemD7xzMeYqgFchxABt6/oY2DZXehTpvgpPUIfnUkVQ9fI+/FJ42DWlrPeWImkArW7Uqd4rSxIJ6mfeaoHGaVqjat1RWyM60DlK7ZsOa/kCuQNU0+4YBKGJVQRknTufmNV0DWRae802J5MZRtY2CP21Ier66e3s4K7tBJZeWqeRdq0y7aHNiKyWXvSw5FDHdFkppDtKurWmS7Y/biOXiaMniRPiXTFzxg/H71/nasdQaBJzaMrKE/2VQtNJVyneDRkkh8+5gEDJS/pz7f4mj2zPm5EPgQsFLlZau7bcbLHGLkh1OF5NdnwswqppLwk462DfiPhzcXQcxInc/bfOb6c29JbpZtrAscNrdHGdJ1Xhw4Tw3pa38h0hI/Uat6meGwg5RcbOrCTrYnou9K0RYBXyNublqqdI+xpiGi9S+qVpWuyGT9b03hENI/Jv2uOgnMshmn8EOnDMMHBi5ex0n074a9yCJU96DuMMS+eqcFgAVDioo8GDSBR7vn6VjdW/iQ2hDxK5W5tPa+uwOC56vUwiENECKNRzz7HmvXfawAHHhpoqmnwl6QNXEZHPAQ4DNtURzD8+GF8SsELOR+pPGCBtNo0tD795wobt9nj6jDVMyx/ub1nSa+itFUPvYAZZ81g0t9mXE+zKI3Xq/VzKGGClPaC3pNfLJ8oesOqLrqLikrT/r7mDDA7WvJ3yKoO2jWnhig3dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?O7vnFJiNEKN+sP0OfGzZgCvY36FAoqPMmNig4uYQThtNaRKRFVKtXUVHjo?=
 =?iso-8859-1?Q?ipsUW/mKH9oFQa1tJZgCEEHS++rOycumrUWng4eT/Pp5aUf/ifcU49Rtmi?=
 =?iso-8859-1?Q?hP/RxE/ZySBA5GMdBNWGO8Gv9VSR85GuI5NCbp1cNJ48PdwH81p+xO51Fi?=
 =?iso-8859-1?Q?vh9spWHgR3wbiaePGiJ8nUn9UPzQt5E8MKPauwBF9xm/keU4bxjRENP7De?=
 =?iso-8859-1?Q?qxV+kzwdUoXj9VZbW9lSPA5iVVdAScGsFHU81rhxX7VgpWailo7UZAkJNy?=
 =?iso-8859-1?Q?Ob/BAfAGehMtSWYkn0lJsfGKZk0J7BaT+u0HEKaU4wwoi9q9NUQ5VltCFT?=
 =?iso-8859-1?Q?WtIwZamYQ9LjtUjVU4GUBXo0EnY6u8DqjexN1v2RMu29ugCypjzGQ99/sP?=
 =?iso-8859-1?Q?rldViUCIyf0YrrgFRt8c2FDP94yw+lJbUF7V2A1GGz+9OWUe/mZBS1Nklb?=
 =?iso-8859-1?Q?AyH85sa+ESkqcY9WD0nH+iQEP2GOfKAkKxKlmh5MfsQkfvmuxsMcB9hyBt?=
 =?iso-8859-1?Q?nDp7mDuxgY7s3/UbD3AivIKpJAab868TaPwxUJl429mwcEmL/vdLCAqoSE?=
 =?iso-8859-1?Q?OOcduqqMcixKOvwW/lBJ9PKqPj+X0SjA6QlHl6Ho3Kxb0MLIiARhguwL2G?=
 =?iso-8859-1?Q?fNzbOg0rEtCeLeRsuWRt9Wq/ZelIlBFl+KH59wjxFuauPCN96yObhkmh3O?=
 =?iso-8859-1?Q?MQlBUCEXYEuZBi3jZKbpn9ym3L6Z9zqcxT/H97oC2Rjj3aVeHDWi2ef+u8?=
 =?iso-8859-1?Q?Z8XdiwiWLQMsK81g92KTpKtDSMubMDAsuDPkS8vc/c9Olfsze+383saBZ1?=
 =?iso-8859-1?Q?1ks3fER/Lzh3akQZBJid1BJjel3bIG96hMixj+Oa0/hH7FGVGVvIYIU3MK?=
 =?iso-8859-1?Q?C+7ChOEE4Gc18BqanbN0wZ4K5cR5D4S4eQxvPf5T5knLfYyNDGRPT41yqk?=
 =?iso-8859-1?Q?aLmcx7XTvNzlJtC8BW5Hhcslf6n9BpLzok72syN9kMhGPqKsKc67ZViBOQ?=
 =?iso-8859-1?Q?yeIApkUctZkJJ4nLcpDaWjx6E/HKF+T8G6w5NmqCUGsYeuJ8zo3mJCwu76?=
 =?iso-8859-1?Q?1tTgvFqdaBfyfyzvkCyoS1E0x4+Cixssh21wg5WRywNQmmpGcDCP7BjgM8?=
 =?iso-8859-1?Q?57hf+KmxAVKXY98+JLvt/Bw3DnZM/09ATiPgNhouFIJ2Gk1oNZ4LbskaAd?=
 =?iso-8859-1?Q?DhqOuXSW/+UVCK/x89DqHxU91vm7Yu7/rZJJY1C21HVvlqaAHBNmIkcCXo?=
 =?iso-8859-1?Q?+YvYSvnNeLUBw0L/bzN6arNswEDqECH/DtELgJb8DT89DS+jPIhBEUY6Yh?=
 =?iso-8859-1?Q?aO51mpwOYA4VLkBFGjFkD+Rq3KksGtZFWohsMNH+sg0jCjPNR8IHDkD5lc?=
 =?iso-8859-1?Q?zkayAzRRqxLDIJsNMTS6gISyshzghbvPdQDcDVADtNxR5O02Qd6OSosp1x?=
 =?iso-8859-1?Q?VAl2ftdvOibB75zc9bJYGzkMwbXwxuqSSuPYfI9BmBSjCWSmTH7wGmPvLM?=
 =?iso-8859-1?Q?Ll8as7DcJv+Wr1x6sTH/3p9l4a9hn4Un8KueXhOZErjkcGjM+P/Bd+C9xs?=
 =?iso-8859-1?Q?9vttde6N0TcbzSVE8YZDFV7si7HYtG/voQJnXvFjUY0E7pQ5p2dxFxu0Se?=
 =?iso-8859-1?Q?v5oq0TU4M4Qb4XjkZzBWy0ICs98lAVrMPRD65LJ8VrfiYNC0/GtKM+9YbZ?=
 =?iso-8859-1?Q?ivWHmcTrePwblx3Qmv2AXoe4Y0ABcfax/CJerjOoRzelqHn/HMwY2q22YY?=
 =?iso-8859-1?Q?oEGLOUY0E6Snjo94YTM39HtbutKlXN9d9pySS4oA4Bj3UFTW4zYfQ+evAE?=
 =?iso-8859-1?Q?dFoSsL9wWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9677233-df95-4fc1-b69a-08de7dfc24a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:51:43.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z278VQ+V7/yLALT3d8Rm2JWp2/iKodQ3zicnnyxES9rdBFDGC1KWvN1ANvlwKxO1xnO54t5oKlUYwCGUOMlsRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
X-Rspamd-Queue-Id: 2529823D849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.959];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:47AM +0100, Linus Lüssing wrote:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 6faa484dede7..aa2edb63a97b 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1067,6 +1067,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>  	return skb;
>  }
>  
> +static bool
> +__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> +			      struct bridge_mcast_other_query *querier,

Both can be const

> +			      bool is_ipv6)
> +{
> +	bool own_querier_enabled;
> +
> +	if (brmctx->multicast_querier) {
> +		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> +			own_querier_enabled = false;
> +		else
> +			own_querier_enabled = true;
> +	} else {
> +		own_querier_enabled = false;
> +	}
> +
> +	return !timer_pending(&querier->delay_timer) &&
> +	       (own_querier_enabled || timer_pending(&querier->timer));
> +}
> +
>  static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)

Same (br_ip6_multicast_querier_exists() as well)

>  {
>  	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query,
> @@ -1081,6 +1101,21 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  }
>  #endif
>  
> +static bool
> +br_multicast_querier_exists(struct net_bridge_mcast *brmctx, u16 proto)

Same

> +{
> +	switch (proto) {
> +	case ETH_P_IP:
> +		return br_ip4_multicast_querier_exists(brmctx);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:
> +		return br_ip6_multicast_querier_exists(brmctx);
> +#endif
> +	default:
> +		return false;
> +	}
> +}

[...]

> +br_multicast_snooping_active(const struct net_bridge_mcast *brmctx,
> +			     __be16 eth_proto,
> +			     const struct net_bridge_mdb_entry *mdb)
>  {
> -	bool own_querier_enabled;
> -
> -	if (brmctx->multicast_querier) {
> -		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> -			own_querier_enabled = false;
> -		else
> -			own_querier_enabled = true;
> -	} else {
> -		own_querier_enabled = false;
> -	}
> -
> -	return !timer_pending(&querier->delay_timer) &&
> -	       (own_querier_enabled || timer_pending(&querier->timer));
> -}
> -
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> -{
> -	switch (eth->h_proto) {
> -	case (htons(ETH_P_IP)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip4_other_query, false);
> +	switch (eth_proto) {
> +	case htons(ETH_P_IP):
> +		return READ_ONCE(brmctx->ip4_active);
>  #if IS_ENABLED(CONFIG_IPV6)

This can be removed given that 'ipv6_active' is always available

> -	case (htons(ETH_P_IPV6)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip6_other_query, true);
> +	case htons(ETH_P_IPV6):
> +		return READ_ONCE(brmctx->ip6_active);
>  #endif
>  	default:
>  		return !!mdb && br_group_is_l2(&mdb->addr);
> @@ -1458,9 +1437,10 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
>  	return false;
>  }

