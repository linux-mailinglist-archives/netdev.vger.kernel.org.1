Return-Path: <netdev+bounces-36649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA67B10AB
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 04:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D5DA3281577
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 02:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338801872;
	Thu, 28 Sep 2023 02:12:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5C2F3F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 02:12:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8BAC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 19:12:16 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S1pqMO005141;
	Thu, 28 Sep 2023 02:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=JWIqgXe/ojI3AC0Vt78Aq25tmG9XbOEF3OkI/lRm6hQ=; b=
	nN3sBoJcjL8gAdHRKuC50brylYYM06orRN6VZyrlYvSYyYXMRu0zJPl5XXt6SqNK
	oX5C/PcQST17Iw7op/YBQICKAxBPrQBZXUfWzdslg6A+1+BJTXcjg8N9M/3h7D0L
	iI6MCPGpbcoDU3dc6tOs31+QjabHty32rlrvt37u+tksylYE0VLaimEordLDUhiG
	6tDQ9rKCjjY+VbVqQhDo/HO1SXbmvFFwrEh1skrwSWv3F2NmIkY7Mth8vRjOMrma
	KmffntyTK6J0/lXxeBHbSNirqbdgdPbBABSh35d3/z34jpuhVOeGoraMMl2biOc3
	LhOZt9GoKWsKlHc182Pxpg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9q06cjp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 02:12:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMWzireZ5FxdN+Sg6EF037Oj6+Wk9dcnM0qiImMlxZURRJ03MgsfJX545JbMxE6zFttkHevSGDW4ClCkm0Ewtgc2mZ/y4abWwYy0dDyjBi/4OuG+i/XpFkEokNxOTbohtScW04FKg1eEWVZk5ooT63O5w0UoaCRjIzf2fq7KjrQl3aNZPJNj7hYV8DgX9PsNnEqIKITgRpxTYecrD5grsH5Pu7zBxkjQ2BKNsDVGoWxDa/o/iIzJMyYUo3iBXCDI2fDcb1MiEnEDZAIQUg51PZgSsXrS5+8TF5ZafdHCsB5xM5vfvGW2VW72ZvY6pr4oRkVDtNmC7hdpHpjrumPJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWIqgXe/ojI3AC0Vt78Aq25tmG9XbOEF3OkI/lRm6hQ=;
 b=nYM5JXLBbDzW20J65XbZX9gnZx5ws9t01/hIt4WFhDn/Qf9Gh0HtmJEV2qvRBRwWOvTtzQnfLjjltbU+8vDrO18F0BMLeYQHKg0tqTrsK8XmViKsDG0B83LUq6JWtb2OCr3ePiPiaQ86E/SBCituWQPLwRn9PGJNCiSeNPri3r1rO9Ktnm8a8uGCoJOygbh/ML5Nla6tip0cTTq1IpN63poFrC3gQN2MbPowIzm5zW1KW0cvDD5U4v3wTP7cE19UTGXCcTSmAnd2Kia3X6GzCP/2CpleMSJTl2t7ABozwzdpEUOUWQCX7DiPB6H89yUKkPYHlWiZw8dGC1d0EB1e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) by
 DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 28 Sep 2023 02:11:59 +0000
Received: from DM6PR11MB3404.namprd11.prod.outlook.com
 ([fe80::2854:196d:481:6d95]) by DM6PR11MB3404.namprd11.prod.outlook.com
 ([fe80::2854:196d:481:6d95%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 02:11:58 +0000
Message-ID: <05faefff-181d-3a69-8b74-69381c62cdb7@windriver.com>
Date: Thu, 28 Sep 2023 10:11:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/1] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS
 increment after fragment check
Content-Language: en-US
To: davem@davemloft.net, sahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, filip.pudak@windriver.com
References: <20230914051623.2180843-2-heng.guo@windriver.com>
 <20230921092345.19898-1-heng.guo@windriver.com>
 <20230921092345.19898-2-heng.guo@windriver.com>
From: heng guo <heng.guo@windriver.com>
In-Reply-To: <20230921092345.19898-2-heng.guo@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To DM6PR11MB3404.namprd11.prod.outlook.com
 (2603:10b6:5:59::29)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3404:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: d75b30ec-9162-48b0-3ec8-08dbbfc84b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4ul8GJRgBM8ikV742Tro7h9JtAypMY1NJCsm0OezG7oqJMD/9C2mTZZzZZu1iakJ7l2crFA+wNLdsb+VvxckqtNmdDxM7FvtTgJxDHgUxBx+vdvM/QnUVgmmWQj3uumOADkFiBpJIr9yTuB6n+zH8rwe0e9iF7q4bVTcwNAKJGjtiM7ImNN3r3W8cgEx1tzHTqeK5vpMAv7jDJ01R5DJLvmX7an9KA4ijMXqX1QeEVK9rBA/WW7H7857MY5Z0PjSr2pB9r7mzZ8aJfUo/XfEsekjVFfI3e/bV8WahegofG9imijH732ToM7HAeqt33St0oyzyi8v+72g9D7zzhllMKUJ9eLFvtDSkIPkNgxhWM3WXpPdIOeDeMR/QXx9ufxek+YSZwiZ8+KZgU7IQgAubcydxd/VOeNXrbjM59WkD133e+uMt4mRgdMMWrw9wwshmlOTBB03eTiQKVlGV1LbFp6xx5GKZ5Bxf0LUQ6KjAgmKNMcM+w7/dJc+ntigahj6oiR/o4vHNNaSAtm4kgBYrPwTCP2CzxhJHkKJmLiEpZhYRjfgnOJ46VLBFQ60kaKj5P60/dBMuM7jGMeoiuSRUXNv8MlLnD4A9x4wPSL443mD7MSkpuoHXI2jhKlVG4NNDqMYxygJU3GDlGP/FpXlsQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3404.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39850400004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(2906002)(38100700002)(31696002)(6506007)(86362001)(6486002)(53546011)(83380400001)(36756003)(478600001)(6512007)(4326008)(26005)(66556008)(316002)(66946007)(8936002)(2616005)(8676002)(66476007)(5660300002)(107886003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkpTVkFGckRDSWJCWmpQTndJTWYyVDB6Y1N3RzdsaEhkSDhlZXZxeTMvNFIr?=
 =?utf-8?B?bGlwZGxTWDRlK1g2b1lTY09ISHJEQTQ5NkFvd2VOei94UDFwai9mSjNPUERN?=
 =?utf-8?B?OVE0ME5JOXp4aFBCWnZRdHlOYjZRTGlRSmV6SFZzRW9oSjFEZlhqOGduemto?=
 =?utf-8?B?TTZobXVvTUxLdzJTRWV6TDNwUnp3TUpOT2xNQURqN2x5OEhydEZpUFl5eUkw?=
 =?utf-8?B?VEJZVG9NZUZyUlc4ZWFzNHJCcTVUdnBsTTlMeDhRd3FjenZUZVR2YW5aWWRm?=
 =?utf-8?B?QmU0Ris3dGl4RnV4UjVYV3d4TEFWT3EyVVFkYWcvdXprZkVPdWtGdittdjhj?=
 =?utf-8?B?TWhpTUcrMzJwekU4NU9FN0hidDVtVlFuNVl3dXZVeGNiSS8wTTVNVjRFbnlZ?=
 =?utf-8?B?YWcvYitScVBmSUJqOE1TYkYwb055WW9ueVRtRnZnWElvNXplaEdhTFQzVTQ1?=
 =?utf-8?B?eUVFdFhyamtzdU1EWFhySXZKWGkvVExvM0tCSVpLc0RWVXlGaG9hOTVRK0NV?=
 =?utf-8?B?ZWFic0ZVS284dVdVS1Q4cVpVMWdqT25CL2JaSjNQZlh0UlhkSVZLajREOG9v?=
 =?utf-8?B?cGZvdzhqQmtzcW1CeVhiK2lja2FSNVpDd1d0WEhkdktYWUl2LzVNMDB1MWc5?=
 =?utf-8?B?cEtDOXA2VzMrMGU3am82c1EyTFFiSDZldWJNM09ZdnI1R2NqVVlodlFWemo4?=
 =?utf-8?B?MVhVdVBKQVVBZzVGczlkaFk5cVNYUHVranl3WE9EaHdMZkIzYTEvcENkemZI?=
 =?utf-8?B?d1lpdWlNZWFpZnBGTFJXQUdjYVY1bEtXTmtpM3hUT3VmYTRIRDExMVNpSlpY?=
 =?utf-8?B?TkJoa3YrYTducG5FbzdvOW8wYk5YRmlsNVBabjhkL3RnOEpFeWxyYXI1NDRh?=
 =?utf-8?B?Y1BFL2tCVUU2MG01WXA1c01BS3pGT1VvQUN1aDUwcHB3MWtRR3g4YnU1R0Iw?=
 =?utf-8?B?QkVqMkc2MWM5bnVVL204bnJjYlpJNFBUbkhlT2RuQ3BLMEl0eGFZSjBxQStN?=
 =?utf-8?B?aysyR2FybHNyRkRHN0s3d2tJc0RvVmlyMjhMbkgzZVJWYk5BcituTGluaGp1?=
 =?utf-8?B?VEJiQjJVdjRhcjBPbzlJZEJUbW1iQnd6Qi9Qc0lmZ2phS09PUmthZ251TElw?=
 =?utf-8?B?aFRZR3hyNlFkYXhRdmptUmc4bXVFdTlVay9hc0w5dTJsOU40Tk44UkhiZEh0?=
 =?utf-8?B?UDMrOWtjY0pWRmlMWjUyeEJ0TFFoK2I3QWNOcFhCRmc4YnJULzFWYUNaMXRr?=
 =?utf-8?B?MXZGY3lVcVk1bExMdHBNb1BTWjRBUTZIY1JSMjlGbUpWak1uQWRIQ2FVNkxW?=
 =?utf-8?B?VEk2L3czSmpXSFdnTWJQVmQrYy90UksvcUY4SThucmNQNWJMTU1UZUZ0d2Z5?=
 =?utf-8?B?K1ROSVYzRGRROU0yU05waUZyck9Mcm9jM3Y4aVhQb3hHY0hwZWZ5MkR1aThX?=
 =?utf-8?B?OWtqZG9lVHBIaXNGbGlSUFFabUl3MFUyUnhUSDZXcEgwRnBsUytrbDRIcXdF?=
 =?utf-8?B?Zyt5N1FiSWtzYml4QmN2QzFvYlBsSEdLbHJWVU9YTFJBbEtmMEFTcS9QUHk1?=
 =?utf-8?B?L3BLaCtxT09IVnhlVzF4RzVoYnhOc2thekpiMEtrcVcwd0lucjlFbVo4SEZl?=
 =?utf-8?B?NmhKMXd3SStmeWljWTNtNTRqVWdJTXVLS3ZiZm9NM3BCdjhyTHc1WU9LS2p4?=
 =?utf-8?B?RCsveHZjak9WbWtqMzBZVmRabU9qVDVHdGdyMlFpVWU2MWZEVDdrc2hOemgv?=
 =?utf-8?B?Q0ZubFMwNFFWdm5DQmd5L3dhbUZYR0JuTGNNd1JYekt2czBrc1BZVEVINzBZ?=
 =?utf-8?B?SDRMTWpYdVY4aEEzSXFBc2pzTWNwNXJsM1h1cVVDWHhwbmN5cEU4S3ZBSVJV?=
 =?utf-8?B?T0dGeUZzcE9sdGx6cUtUTXg2czZVejB0Y05HWUNJV0V2d1hRTWQvMVJwTC9C?=
 =?utf-8?B?RGk2dXhGa3JlUnhiZjdqU2YwMFVOR0pnM3dlNEhJb3B6K3JpNXp2NlpXWDlv?=
 =?utf-8?B?OWYzcEZKbEp2bDhseVB4Z2gwZ2dzVGRXVG5rU21vNkJLM0c2RFNPOEZlelhE?=
 =?utf-8?B?bUNHRERhV2hGRTNtbkd0cFZVZG1mb1dyVUlHdDhaZW1NcFF3Q251QlE5c1d0?=
 =?utf-8?Q?0KyDUzDlZE5vwltSsgYYurs1u?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b30ec-9162-48b0-3ec8-08dbbfc84b85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3404.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 02:11:58.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ6b8jEZOnTX7gdGJZy69f4MfwU1+PxdQqMAPN1PA0C+/LcZerH83o7mBzoa0ZZn/YI1Cba3TohaOJzSs8gb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-Proofpoint-GUID: FKhTH-M9x-ta77DvzsWz-7Rq4KVQqb54
X-Proofpoint-ORIG-GUID: FKhTH-M9x-ta77DvzsWz-7Rq4KVQqb54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=908 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309280018
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Could you please take time to review this patch?


Thanks a lot,

Heng

On 9/21/23 17:23, Heng Guo wrote:
> According to RFC 4293 "3.2.3. IP Statistics Tables",
>    +-------+------>------+----->-----+----->-----+
>    | InForwDatagrams (6) | OutForwDatagrams (6)  |
>    |                     V                       +->-+ OutFragReqds
>    |                 InNoRoutes                  |   | (packets)
>    / (local packet (3)                           |   |
>    |  IF is that of the address                  |   +--> OutFragFails
>    |  and may not be the receiving IF)           |   |    (packets)
> the IPSTATS_MIB_OUTFORWDATAGRAMS should be counted before fragment
> check.
>
> The existing implementation, instead, would incease the counter after
> fragment check: ip_exceeds_mtu() in ipv4 and ip6_pkt_too_big() in ipv6.
>
> So move IPSTATS_MIB_OUTFORWDATAGRAMS counter to ip_forward() for ipv4 and
> ip6_forward() for ipv6.
>
> Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
> Signed-off-by: Heng Guo <heng.guo@windriver.com>
> ---
>   net/ipv4/ip_forward.c | 4 ++--
>   net/ipv6/ip6_output.c | 6 ++----
>   2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
> index 66fac1216d46..8b65f12583eb 100644
> --- a/net/ipv4/ip_forward.c
> +++ b/net/ipv4/ip_forward.c
> @@ -66,8 +66,6 @@ static int ip_forward_finish(struct net *net, struct sock *sk, struct sk_buff *s
>   {
>   	struct ip_options *opt	= &(IPCB(skb)->opt);
>   
> -	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
> -
>   #ifdef CONFIG_NET_SWITCHDEV
>   	if (skb->offload_l3_fwd_mark) {
>   		consume_skb(skb);
> @@ -130,6 +128,8 @@ int ip_forward(struct sk_buff *skb)
>   	if (opt->is_strictroute && rt->rt_uses_gateway)
>   		goto sr_failed;
>   
> +	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
> +
>   	IPCB(skb)->flags |= IPSKB_FORWARDED;
>   	mtu = ip_dst_mtu_maybe_forward(&rt->dst, true);
>   	if (ip_exceeds_mtu(skb, mtu)) {
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 54fc4c711f2c..8a9199ab97ef 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -448,10 +448,6 @@ static int ip6_forward_proxy_check(struct sk_buff *skb)
>   static inline int ip6_forward_finish(struct net *net, struct sock *sk,
>   				     struct sk_buff *skb)
>   {
> -	struct dst_entry *dst = skb_dst(skb);
> -
> -	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
> -
>   #ifdef CONFIG_NET_SWITCHDEV
>   	if (skb->offload_l3_fwd_mark) {
>   		consume_skb(skb);
> @@ -619,6 +615,8 @@ int ip6_forward(struct sk_buff *skb)
>   		}
>   	}
>   
> +	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
> +
>   	mtu = ip6_dst_mtu_maybe_forward(dst, true);
>   	if (mtu < IPV6_MIN_MTU)
>   		mtu = IPV6_MIN_MTU;

