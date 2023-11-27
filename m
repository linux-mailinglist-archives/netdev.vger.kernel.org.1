Return-Path: <netdev+bounces-51454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181967FA9ED
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB9281850
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D053DBA5;
	Mon, 27 Nov 2023 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lm7wVCyl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85506D5F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:10:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICxoeqaXBockIwziZGpvQRl1gXc0CVc0NQnvCxFEcL7qVkwhfkFojxunvzIQtUCLkjplp3u5Pn2wdqX75XFL2InP+KMBZv3fzhxT4NXBK39KE2dr9e9Ze+uVYxOWl5Qb6+j56XjU5TFU7iLaw1F6HT8epHctyXF2th61iJ9S8bUVZApSobiGDGAzjril733Mq3Ev2N3LOA52+3RWhwTJGhWW96782ZoiHvdYVuMt9XzN5In6IGhm4zjjEnDCCi2RyMmS+Y/4+hSaq4DSGzt/QoTER/iXuvBPq9Vlj9YLBF8DgL7DWDAkdTYgEyfBA6M+SV3fIhWv2535evhWonzdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw1q8glpMfv5HPOJ4VHKGZdezdhUfz8cxGi5TIBY/YI=;
 b=XdzRVQdwGqvHY5gbIcsggGZ2HgCef0Vo/cFsmDKOhoU++0m70hdTxTJuOk3ttgVD+JIbvJRhup4GN9DRNgZaByd1ovZhCdLWNlQ9jos4A0mSkW1FQOPivxpouJgEBBkvZqdhg2FCw7cg0sZmHxPEnn0qFm/XDOUL0gVrC3215gwj7Pb0s82eQ4xyFcOKHMY49wjHKKyD4FJs7NKFj4IWMTv6GzCgGlShpNBA3t1tpbROSBcrxCYPDLASa/uiQjdXV8wxBLtZSwwoJ/T0JlmsXLhsELvlxwVp3A2udVwW2fGLquhqGs5g63DX5Bz/dLsH9Wlvm6UWo7fKvzHGxFo8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw1q8glpMfv5HPOJ4VHKGZdezdhUfz8cxGi5TIBY/YI=;
 b=Lm7wVCylbCVj26kfKcp97QeIDbsEI02mJFtgZy6kRGgm0m2GaCNb+3XsTQIhAQw12uLcqTqf1nF1pv8ijTsThT449Og4BgTqxnwdFVX0aa7PaIY2dHigKhLSMOSfbYAUrXsg68m1ccRKfHh36C6fDWqq2Ie4ABs7Q/ZvSpjOq/tTCl7W2RZVvfEt287ZT3936NpT9NaKiqFobvMfmI33w62J9I8mU0HheGnkYiHgYrtPtV0gHUV+XKvJNwLaDvaNcbulkhkUd4A2IyF1lQoqe698OC7hTi15kt8p2EumhV2MRbuqGz0bNv+wxVP6d0SuXtxKKPmvGc2NDLSiSvrmZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 19:10:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 19:10:27 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,  Leon Romanovsky <leon@kernel.org>,  Saeed
 Mahameed <saeed@kernel.org>,  Gal Pressman <gal@nvidia.com>,  Tariq Toukan
 <tariqt@nvidia.com>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next v1 2/3] macsec: Detect if Rx skb is
 macsec-related for offloading devices that update md_dst
In-Reply-To: <ZV9jzHCQy1DZvyfk@hog> (Sabrina Dubroca's message of "Thu, 23 Nov
	2023 15:38:04 +0100")
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
	<20231116182900.46052-3-rrameshbabu@nvidia.com> <ZV9jzHCQy1DZvyfk@hog>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 27 Nov 2023 11:10:19 -0800
Message-ID: <87wmu36mhw.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce6d9ab-db03-4714-7bfc-08dbef7c8418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hKMsnm6L1lOMtzYt0qU/pjxV84zHxdEWB7ZnnZF3T76UuKbyFf0pEP1IJE4+qoDAekoMlqAGVda/3yvB2OgqsVGSoKvUUhpxsnhogM5kyXgKFY273rx1qZWlV2/zr1+WgutZ7lPASiimI7650OMv2onIgzm2tK8RoLNAGwfA13zc2FTUPL07FXAOjmTyToVfGGo+YME0XAyYTvlzPCOCvUN+SDtgxrJE9K1wPpfZgA80+62uFbYwnXDIU7Js6o/KYJVJ/TCmz1GCZEFLHQy2FPTCnrENDVX6oFWnw2zCAqaq8d4dlOVcoT/bKBga+XrQzCJulYrg9TfTwvV8tfEGF3ovjHvnvYXiyqqjDQGYt7RsjLTuozXVUM9c60Zi3bwtuFxG5fGpc/LuV3VlqfysiXfd1olXNyp9GbYer0C859ncHSOV5SCA4QowFPShQQn1z/cWrmGqnaiKnldaHZtvX8OOGzVYyCxaiNwG5ax/vDV9mfNn7H7MFfh/jZt6WElpt3eLcUr4Lp4kB/NIeUSHSSsi5GvjuYJk2amfHIJn5pWgSz3y8YSpmEOdHg9mbDSh1soQBSVptq3hU0EuMXbpPjpWP1Lz5oPh3cpA7SO7Jyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(36756003)(41300700001)(2906002)(4001150100001)(15650500001)(83380400001)(5660300002)(26005)(86362001)(2616005)(6506007)(8936002)(8676002)(4326008)(6666004)(6512007)(6486002)(966005)(478600001)(66476007)(66946007)(66556008)(54906003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yz7uep3DAe5Kt07yejX2R9ikJtGzacQpIt6+SjVSeSBsqpqNcLrjyJOUDK9L?=
 =?us-ascii?Q?W6pTVUVhN+DEj7tc48ATrH4/Mi5VskohU9l0DTLhpqzv9YxRg6FYPvMr/OsZ?=
 =?us-ascii?Q?FKscR9xt5/m/hCrbn6TMBoMfbz2vu7mg7uyR0XbR8lmDD1a57Rk+BKADcq6O?=
 =?us-ascii?Q?x/A9zheBjvMrLPK2CU/5PQ6hPP/R1xp58R6In7XJfQ4ic80gN0PArL6wgKH+?=
 =?us-ascii?Q?ZxoGZxGV43ECJ2hPAEttn0LKHbRwZ8yHai2wT+NjoFHhWyNq2k8QfxbXDJnU?=
 =?us-ascii?Q?jGlsv/PaPbthaQUtUiHELxVTuWYciW6G70/QvUgykJmFsU+3Ijou2S3tNVUX?=
 =?us-ascii?Q?FKzmjciHc+m8YKZeNcV221E4XF36znkOXca8K5kcjYBu7CHOZME/A1YnTlgm?=
 =?us-ascii?Q?vXemTg/fo8e9joJrRO5nNu1V0eQD4HomxQ681Yw0+yF7gdiMLE+/RKxW0WrF?=
 =?us-ascii?Q?kXtqL6tfYRvq6ypjkXonbuQNqjXaSVkmjGHeECIVAOTw8GTp1weVHSPRo+mN?=
 =?us-ascii?Q?Y2PnE25MaRl+quMXtwtvOp2/YnkbY6kGeaaMdXH8YsGMv4gxif1oD1VuwPV9?=
 =?us-ascii?Q?rcTuJ1UELUoexDZoRBwwERTKhWE8GF3qzLg+N7s5P4LvvMADxX2wfzUQ45Q0?=
 =?us-ascii?Q?IB8vjqFOMpTxOOxUz4yrBvROl9WkerYYjcaY+y1LFkqTIigp8RWmtrPoC6eg?=
 =?us-ascii?Q?S7Qu5tu7VGBbMM7ANJZ1aD/IsFd05fasMJtFs2iT4VKHxYylPGoALohoJsKS?=
 =?us-ascii?Q?rhsZSSp5uYYGgN9jiam++RnNfp4vcekTli+oY6IhipJHvCBBChSm++0K5Fgc?=
 =?us-ascii?Q?EViYOHNI1/C0xp4soRs0HABFSuq4Cc0mCR9SaHTMyCaayTgft0zJ++4/Jvhv?=
 =?us-ascii?Q?8dLH4E1vcam0Cms2Zv32HCIyqzElUmQwagnzh+r9EEkh34DQm2wLko1R40ZA?=
 =?us-ascii?Q?RtjAB8/jPbLjvCMrZeVQDFOkZX7x7PtLckCbZCQodrMniJcrO0kGO3UvaTHo?=
 =?us-ascii?Q?pn9KQrs8QHT4j0OtjJUUtm26oSGvgQ3toxPxUJhEsVBmQqCQtppGOQQyjES5?=
 =?us-ascii?Q?yTwHhP8JyQHqfZ83zzzsoh9IrlkBcDkakDTywvlqKyTnuEGvHGfij9T3y9O4?=
 =?us-ascii?Q?8JAkfBwg2AwpLqiFXb/ylALoXFMz4h2LfxAJzk1KbX2cp3m/CdwmaUTLrLMT?=
 =?us-ascii?Q?GnLZcOkQIUtUJ95gOPnM7kKGMCWKmiKQrTTilVxUdF31JsQW6cDDJUlmeLc4?=
 =?us-ascii?Q?8EKh0yLTIio3N/rHj3vGcZ2ew+yvDBcqRnen9njeDxoi/I2RiNTKhKnVfs8o?=
 =?us-ascii?Q?4uiRNcDjVYlDiGvnET0nxGypDntemhABtSuxPbvcObjaGnr+ipxyxHuSKNlG?=
 =?us-ascii?Q?x1vszEIw2BMaapkLbaeehxAiVX9aBb13iU/ThM8e6r4y39Yf/TcAOSx2XsoK?=
 =?us-ascii?Q?SvXRUFgP2Nm37NW+cf3D6L9GC/SgRtSWBBZpWPrUeoo6oTKPUJTuw/38Rk3U?=
 =?us-ascii?Q?Gzz6EsLs5dccUjEwQnZqcmZhGDLymCgHrDmGJdbFtt6aD10yNLiqLF+t4aJi?=
 =?us-ascii?Q?9BeqtpL5zfw+ClEYpSiprF8YHDLRIOXBrUIJXO2P9frvW5oYX96aEDA5360O?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce6d9ab-db03-4714-7bfc-08dbef7c8418
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:10:27.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8PLv1lSHkyQoY0ZBVQ/EfDEtsu+duS5K+QJJTMtDGLvvbmv8L3nByWsP5YWBRPuz7ueiWs4iiLTe39qvmDslw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

On Thu, 23 Nov, 2023 15:38:04 +0100 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2023-11-16, 10:28:59 -0800, Rahul Rameshbabu wrote:
>> This detection capability will enable drivers that update md_dst to be able
>> to receive and handle both non-MACSec and MACsec traffic received and the
>> same physical port when offload is enabled.
>> 
>> This detection is not possible without device drivers that update md_dst. A
>> fallback pattern should be used for supporting such device drivers. This
>> fallback mode causes multicast messages to be cloned to both the non-macsec
>> and macsec ports, independent of whether the multicast message received was
>> encrypted over MACsec or not. Other non-macsec traffic may also fail to be
>> handled correctly for devices in promiscuous mode.
>> 
>> Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
>> Cc: Sabrina Dubroca <sd@queasysnail.net>
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> ---
>>  drivers/net/macsec.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
>> index 8c0b12490e89..e14f2ad2e253 100644
>> --- a/drivers/net/macsec.c
>> +++ b/drivers/net/macsec.c
>> @@ -1002,6 +1002,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
>>  	rcu_read_lock();
>>  	rxd = macsec_data_rcu(skb->dev);
>>  	md_dst = skb_metadata_dst(skb);
>> +	bool is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
>>  
>>  	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
>>  		struct sk_buff *nskb;
>> @@ -1014,10 +1015,13 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
>>  		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
>>  			struct macsec_rx_sc *rx_sc = NULL;
>>  
>> -			if (md_dst && md_dst->type == METADATA_MACSEC)
>> +			if (macsec->offload_md_dst && !is_macsec_md_dst)
>> +				continue;
>> +
>> +			if (is_macsec_md_dst)
>>  				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
>>  
>> -			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
>> +			if (is_macsec_md_dst && !rx_sc)
>>  				continue;
>>  
>>  			if (ether_addr_equal_64bits(hdr->h_dest,
>
> Why not skip the MAC address matching if you found the rx_sc? The way
> you're implementing it, it will still distribute broadcast received
> over the macsec port to other macsec ports on the same device, right?

That's true. Once the rx_sc is found, the skb can be diverted to the
macsec port.

>
> If the device provided md_dst, either we find the corresponding rx_sc,
> then we receive on this macsec device only, or we don't and try the
> other macsec devices.
>
> Something like this (completely untested):
>
> 	if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
> 		struct macsec_rx_sc *rx_sc = NULL;
> 		bool exact = false;
>
> 		if (macsec->offload_md_dst && !is_macsec_md_dst)
> 			continue;
>
> 		if (is_macsec_md_dst) {
> 			DEBUG_NET_WARN_ON_ONCE(!macsec->offload_md_dst);
> 			rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
> 			if (!rx_sc)
> 				continue;
> 			exact = true;
> 		}
>
> 		if (exact ||
> 		    ether_addr_equal_64bits(hdr->h_dest, ndev->dev_addr)) {
> 			/* exact match, divert skb to this port */
> 	[keep the existing code after this]
>
>
> Am I missing something?

I just have one question with regards to this (will be testing this out
too). For the exact match case, if the receiving traffic was macsec
encrypted multicast, would the pkt_type be PACKET_HOST or
PACKET_BROADCAST/PACKET_MULTICAST? My intuition is screaming to me that
'[keep the existing code after this]' is not 100% true because we would
want to update the skb pkt_type to PACKET_BROADCAST/PACKET_MULTICAST
even if we are able to identify the incoming multicast frame was macsec
encrypted and specifically intended for this device. Does that sound
right?

--
Thanks,

Rahul Rameshbabu

