Return-Path: <netdev+bounces-265542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMrxIKHFrmn2IgIAu9opvQ
	(envelope-from <netdev+bounces-265542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:05:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC9239651
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9A6300F95B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9503BED3D;
	Mon,  9 Mar 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KdGrReRl"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B73ACEFB;
	Mon,  9 Mar 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061056; cv=fail; b=mRpejmGbRPv0za56l/HkNfE3O3nqInGG3SCjIujpVwSXjw13gMi1LnjREVZHfKZdIucjan1e24AH/DIv/dKKwd+KXOE8+mCn8amLqT7QuEb1tYKrqZlD2tY9pI526vRIFxPLtywCnT/9AfqVI6W1o33Rs5DezHnuzNLjh257bTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061056; c=relaxed/simple;
	bh=KU3zwjsk1+/Ep3Zn9zovDjiHmRXVX8CcqkXTBtx8Xgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vBnnoZUGghvrTaoUUviaHR6YiQFUIokhyo4RHYKXP21thHEaO8GiJNhqIP4fdEZPGvzPqJUpLo8BCngT5d4yYRG8Gz28hlzbpWz9Le7Oas2WHAJrDfk+tMNQHOHC1BTtEkCpKSsQR/JJfIEqujgsS8xc8CKvTferoG3sgYaKTXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KdGrReRl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyVquacBkqHXFnE/WnFGm3iR/GjC3DH7s+pySmpOeaofoK+z9sTHqUAxhFBSfYGCHtLwWnpwyg1JJCb9yH3DjvQ/MXJQccAA/8jF8uWVhog6b69fRvUflXuy1H2xwWYF11YIC+FTc8KhCVpgWZyBEhKU2Sdk/r6VfRDSLwfYycESfp09N9sM5uKcPVmGFbx3IQy0ODm8ejJSgB7Rgd4xOW5K4PoIWtstMlKPuw8ACWSQyAIY72qnccGp3mz69DPiKMubmX/XZjBWrjSBk96wizipNSA+XDU08nqMdyYCAgk/IJc0XMWq724u0e64yY/W7LoiDOzm1jqAGYOWBat8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu42jQb/MyO/hNfSDeG6foMxXgiYjlAffDvVc9wm+eg=;
 b=IriVihO3hONcCuAK+aUderwkKPGWgX6a5AFgPPb3isChwU/WYyG4XfyOFNbx2Y8K9uVvWCcarMnqV3GAsyls8t+XaARtDFu5p/4UpEqGWs+YjFo1zme2mlTpFGurBHniDtzMxifvEJXWynidIGZJwJzxPexrZjaP5t6LWQpvH5RxJnuVV2W7iCs4tb/0b5eVqfHNqPbMYeoG5ouFOErU9zm+k61Gct/SnozxadqzuG3vBfVFxwiuBI7jvFn3gTNkYVaQpP3yYF5svR/4HdPInSMzlY9Wdgi+XxOtPReo16OvSA9xtoTdsV+AD/aZXGwwIClodz3FBPodqiEDcoGo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu42jQb/MyO/hNfSDeG6foMxXgiYjlAffDvVc9wm+eg=;
 b=KdGrReRlKxtyUifZEZPWQXLp5Ikf5K00Fn4KfiLYiGRn29WuqZ2D87V7yCz9CLOF7pTyPk8LFPOK6wmGLAU2GIHDDFejRSkuJCSZRiluE0Yep4iPAxlEvfpioYD4zpzSfHXA/e0oeof+ccfU6/qNsYU0ZGs/CTBcwVKgM3ufKzUTZBSw3cZKJnfkaH4UVT6fhtooDTbTC5GLgLcHPoFdQydxJQi4CX/inB6IW0aMx6wZt0QPxirYuBdVrPRljt/axUD5bk+Ar5H5G9ZjqYrx87wscYILP3dt3H9Ws5z5s9a1tC4NysF4l4YcnNYI3diUlyRqezVpH3JvHWY93Bp0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 12:57:32 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 12:57:31 +0000
Date: Mon, 9 Mar 2026 14:57:21 +0200
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
Subject: Re: [PATCH net-next v4 04/14] net: bridge: mcast: track active
 state, IGMP/MLD querier appearance
Message-ID: <20260309125721.GA1929478@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-5-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-5-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b96e4c4-4949-41cc-d849-08de7ddb6d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	w++xOddku6VyouKTuAF4tqUEqAqxeuy2kFx14hkC9c8bqZCb1r/cheixTdio4kiRDTbwb5D1zNPl7s6fFQ0FFHbJhmBw/efMOR7zr1usadHZKibOLrRoDPt1nMIwH6gm6UCBy03ijNH7ZwliJz+La1vS4ypxUZozcMyX48oWgTUPwl7K3l4uxt/39Dnfpq9VyWI9wTJ3CDe2tto52+ChTUttDf6FOZ+ptioImGjqlpR+shDxYojxA7gjwNpqVmmGfez+fZuDXWspBHsn9pdraMueq3Q3o5Xjh8R8BaDhhFqamrKXQPmR8KbY0tUCbaytkKAlgWhAQjxEM36VuJiQZRrQzh6Ln2W2E4+dsepRtkQPrpqOhLy+K37hGhLJnD1vLF41Iw0JSx0YQGJwke0lcobDWW3BlDzKDNJCkYnBURVvAP4vL446jWwQytEmtjY77BZ6z5iWl4FWh6ueAULcZcfb37TwNQVTkeQoplKiwpqxs4yWqnrCjb3FmPT6kZdx8Qfus8MZfEnXLu9U6PxKr41dOX8Hvxlav60uBApe+0IS6HzHtpvm6AiWo2C6YLKWuHBdK+CbvqxMU1G8Ok855s1nvlDpvlk3ZJDm8LYM6dc+cVtRTvT8ce0jr7cYKREpmaeY4gWHwjJXAgiDJWJoi4yXJSjtSACWMnM/S6At40Dwz1XIsTvU76DrAQe4TdlWoIsZKEvgE6EyEbyLUHSU18ftengvlfPTac1UInevVaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?eHlcPg4K9xwrAe2Q/CMxY5Ly4+wf6KQbqV8O2WObkX2Eq/yEZO1JxqO1LF?=
 =?iso-8859-1?Q?t21JmVoAjEVlN2DrOCxcmikzEFdX4s3C+zssD9kz3j0yjaBoKKibxD0MFn?=
 =?iso-8859-1?Q?2swOBBiNxEIvztOMsiaix4MqGV+UCQjBgydlE0mr5+rW5OcVbYA+Ne3Qpk?=
 =?iso-8859-1?Q?JxnIE8KFp5bLcRBH2w7L45Y3SluhbDX3jc09D8ulMpnKufCLpTOFErMxzF?=
 =?iso-8859-1?Q?6Q4JR43JZZU76PqG0+EcjOKC09nMK2AQmGgmBrCBr/mnrjfTt1limAZKmC?=
 =?iso-8859-1?Q?pKngRRrdXIVdvU5/7MWjaR3aKdPP+S1p90Zdqm20KI18Kch/RczBqHc7Yh?=
 =?iso-8859-1?Q?1Rcrrey2f+Zgx3xQ29PSNdfc7ahgcGB9XNGgJ1qrB+QNTZOFvHdcGlasbe?=
 =?iso-8859-1?Q?7tH2ZhhPaHbJjT9pxar9otOBPEOk5Ro2uOC5CbBAPpeihFht46ZoMk9mDj?=
 =?iso-8859-1?Q?GB1ihODtReClFSFNKzdmCJoeyTU6pjUX+juaz7sccucUBGLHXa/B3FBISS?=
 =?iso-8859-1?Q?4dP14JNkXU7s2dmGYj9hrGZltH66jc0/eaYQF4GwD3NIZicH4MZjYVR1ca?=
 =?iso-8859-1?Q?iB14+n4TPJsK7yBg/8J/1gAMxYBcjxDY606HVdfBsQz2S9heKUYsPF/+ZU?=
 =?iso-8859-1?Q?zwPwGdNjVVIY9pDdMQUHFJ7ARoMTa54uMJy2nwgsdi4kRbnoOoup6d08IQ?=
 =?iso-8859-1?Q?LM8PeMNaDJrIOmJK6G3kLwZeKWBQXvO7U7OafNsfjzUN2oeNe3WO7L6y6c?=
 =?iso-8859-1?Q?yNToh5YR7jzlpzBLnpiDbexn0tI5mou3/BEPtut6l1F9uEyIqPUWu0R6GA?=
 =?iso-8859-1?Q?DdzeY/DtzZYsH0Q7N5i2sp5pfwf6NtzUhrsqnNXosJCZcXzR5l7eEuMQMk?=
 =?iso-8859-1?Q?67l4RtiXpfGgtIXqFg2m7keH7BsVnFSfYmuBO6CcNvSufSTkjX0rbEAZS9?=
 =?iso-8859-1?Q?KZs7QPGsNjt+UIuSg7sQJ+XzJwhkB2vvnWuxVYc+sRnXRuwchMBG8K8h1H?=
 =?iso-8859-1?Q?h64kUFOffPIzGtZQQnJmQHnqQ6g0gTVSI8PfJdltTDGEWEWxg1qvUKpAQm?=
 =?iso-8859-1?Q?srmpiHQR7rq9osDVnqQkMK+LJ4ucztvSSG+g4DC2AA8/A9BnDqu7qEkn8d?=
 =?iso-8859-1?Q?aThi6IE39PsfhNKu8oCanVKE7u1cXEdKExZuJsC4oKOF05oP3uFIivT5ne?=
 =?iso-8859-1?Q?lqZvCTrzNm4O+RJsdt+0mPzDyEWo6wuBTbX7Nat+un0Tspikn521YAA47+?=
 =?iso-8859-1?Q?/AhWiM8YCeEobChE58z6jlqsdbHNIPGaAHbZ0S8U+t0mABiJYUwBJah87A?=
 =?iso-8859-1?Q?1/Yzd5xa6HV4M6H5P2WMnYA+Ry10jv+gKXLrtirdWMd7rtX0DTVqdC7Ygr?=
 =?iso-8859-1?Q?HeArXFSETO964FYlEsz0XHvkbD1DrUKk6gU6cnbAFZqu7tyV7FwbqHSrpw?=
 =?iso-8859-1?Q?8bM13Kif2leZGOSw3JMVJ2+yDCWHAoT7PDnmdxn21ibD8AfM/Sn/d3nFUT?=
 =?iso-8859-1?Q?ThjSZpSg3LQPNQEezP3x6BBsqib6UbbzL2YJ7q0orNN7vCzoCXESh38o8d?=
 =?iso-8859-1?Q?M4wzrKGcEevsNKOz6vGaKxmRiQsKaeXpMFnT2jOGyp8vLMzmYDcdX3kx8Y?=
 =?iso-8859-1?Q?P9DscL57m2CJsdB1sWeCOZZ6eavuQ8PF5UyXfzpMZ56wdNQ082DHVk1ASx?=
 =?iso-8859-1?Q?3XJoYS6iVg5Vk9WjVcYWbWzUsPcDCSEm+WGScLzeXGSXvsBg8jST7pOlkO?=
 =?iso-8859-1?Q?jpFchlxWhskgjyvus2PrGqGrfLWegPLaJ2A42AxgJmHaE6T539nBYAhc0g?=
 =?iso-8859-1?Q?UJz6oQWt5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b96e4c4-4949-41cc-d849-08de7ddb6d1d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:57:31.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVuEUuhWK74upixaWETXEFUnkXlB2u5pfcbPhvE70CIvrU0ydv9AMUMkCjNeqLuYJ1XhmNrblE9y3snalEq0XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
X-Rspamd-Queue-Id: 03FC9239651
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265542-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.258];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:38AM +0100, Linus Lüssing wrote:
> @@ -4245,7 +4355,7 @@ void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
>  	brmctx->ip4_other_query.timer.function =
>  		br_ip4_multicast_querier_expired;
>  	brmctx->ip4_other_query.delay_timer.function =
> -		br_multicast_query_delay_expired;
> +		br_ip4_multicast_query_delay_expired;
>  	brmctx->ip4_own_query.timer.function =
>  		br_ip4_multicast_query_expired;
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -4254,7 +4364,7 @@ void br_multicast_reset_timer_cbs(struct net_bridge_mcast *brmctx)
>  	brmctx->ip6_other_query.timer.function =
>  		br_ip6_multicast_querier_expired;
>  	brmctx->ip6_other_query.delay_timer.function =
> -		br_multicast_query_delay_expired;
> +		br_ip6_multicast_query_delay_expired;
>  	brmctx->ip6_own_query.timer.function =
>  		br_ip6_multicast_query_expired;
>  #endif

Patch looks fine to me, but it will probably need to change a little
because of this hunk and my earlier comments

