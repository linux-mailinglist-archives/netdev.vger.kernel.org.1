Return-Path: <netdev+bounces-135529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4099E339
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AA6B20DD3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9D1E0DB0;
	Tue, 15 Oct 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fxFTMrlK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02A1DF25F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986303; cv=fail; b=EIB/kZ6mZcwnqJ/D2xhQPHatZ9HWRcN+bJIk7HlZ7uqoHFzhFAuNBHhlKmdU/HBVLV++SVsNAbq5NksfI86gXXyXts4yedho7wgooVpsU1BdWAVcwxed3SozUiN91pzqdZM8749Y10RAMa1vk3H/k9VJkqDPXmya1S/cLPEOZIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986303; c=relaxed/simple;
	bh=WqzaCdgs8/YezYN482pi9ARJh8nOv11Nq9xYxYxGqLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H91eQctkMGgVorN6OnEUiJ2E8EXwJNHdv8XXW2U5CP48vYYDi3RGSJdxKnRB9LcQsKJ0KlgRDUmdcNxThklWkVe3T+9zM0BhedTzdXiRrRhEMGz04GHKPTabMar2RU8Di/xnS3A1TKL++E/9TzCrMmEg03qlTnCoFUAmsjmzZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fxFTMrlK; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNzg+LQGdLBHtZnNhPdaWkVPZSWii1wa+ePFgHfrJdKpJ6Jvf7hZ3B8kwKZUx4i1U+cMhLCTfUP0+zIgg651kSCmXs8GFG1uIZ8TM42PFdVQMI6FkPrBsa3Is+pegQPgdhjBoZnS6nhbdcGUZg+B6Y+RHIAif95KO1udftSz1Q/V9xI2G3wAmBvhquojW0fXC5bByEq/blStKZDj5kulwk8EQ+mrtca1yVpGz8T4G0Ophp86KZ2iS/+uwr9OQGq6iE8owIajusNks2udyO1uCvI76TeuWCswZ+8kthRDh1AolAfbUQQabar5sM5yNeVHQ32cfHDu8PG9yBiIn5P3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbKKa8iKImKFheg5XQy5J3ioh3esHZ88/JvVMGG10ck=;
 b=u0dhmBhgAnpEgG1tS+8zb/FjY+ldVZtByFyrV5w/NSgmsj0PMbihUYARDkxkecnyuLU8s4Y/eZx6Qa/Py9JtAOOKboSn4khhPCz/fD7TeaZQ56roftvc6If9mtzUhFw4N6kKuoSH4OnNHymR9yQNYDNOSptfo6tgwAAYbQ77qt4zB2P381FGs83UyrnF6BZyzmdMGCFElsQHrgMQ2a2qnJ851mfS3HbsVvf2Tf/vG0aft+ujUKNMiCBoTb3sh2Ra27IAw8/7Wsnqm+9nolSyDuTk1DO9VHcyshwaXrvwhMkqf3qk3K/rJW59iR3PGLZNUZdxSwlLz3nEkz91JUiwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbKKa8iKImKFheg5XQy5J3ioh3esHZ88/JvVMGG10ck=;
 b=fxFTMrlKXruJEirrBiTsriXmsB05BeHgj+HQ1s74X1NMfV21FOCwbZpZeEYJzWcc1Gze77Wd9qLepXhxeG8ImSIGgEmsO9clZKaFPdIX5nM+F6WeB36Iu3ENifdAO6bAamVQwHpjcySg3CbZpPbBnb8iKiufLatdicOL6HmN15wxQAHtgXy/Kb5q5zvrlDZrMAsUwL2/BIqPbjuA/eYgDUHErxhtjXoVjcWa5wg2qEuzNiiBqxoCc1F3OZYIdS6MNKGYxjL06qajiVlMjsmaqg2gx82fLBL9TJerlVVybD5/M7+8d3rsFwkb2kbc3/7qUerFbG4gvX0olHGi/63y5A==
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 09:58:18 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::5b) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 09:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:58:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:58:05 -0700
Received: from [10.19.163.10] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:58:01 -0700
Message-ID: <89ccd2ac-5cb8-46e1-86c0-efc741ff18c9@nvidia.com>
Date: Tue, 15 Oct 2024 17:57:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] macsec: Fix use-after-free while sending the
 offloading packet
To: Sabrina Dubroca <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Chris Mi <cmi@nvidia.com>
References: <20241014090720.189898-1-tariqt@nvidia.com> <Zw4uRHzqS05UBMCg@hog>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Zw4uRHzqS05UBMCg@hog>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 03954bc0-5ac5-4df0-53b0-08dcecffe4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3hsMGpaL1JoUGFiR3JLNlE5N2h4VGNicDM0bS9XbGtPMFdiTUlUMVR5bFlM?=
 =?utf-8?B?VUlpUTJtOGkvUFRwNmJzckxBMUNnVHB3Rnd1R09qT2xIQWJOVU02ZHdDUzMz?=
 =?utf-8?B?RU83UWlvWWZZakFhMVJabXFSUlNJejRnb1hnWkFXVEhOVnNGdzFQSnhMalp2?=
 =?utf-8?B?bmR4WjVsdHJRSmorcFd3cWFMZ2x5QlNudVdpMFdjeW9jeWZxUHBoV0g5V3FC?=
 =?utf-8?B?aUpmQzFLcGpSRHdPeGxuRVl4SUgxQWlMRlQ5YzFQWVFXc3V0M2dCeEtDTC85?=
 =?utf-8?B?YkpGYlFsUVhNWnZVcGJNZHpYL2Vpa2xRQkIyTEFXM21GMTZpSXlJTzhPYkVv?=
 =?utf-8?B?WnBQUFNTV3lXNy93RnZJT2pENEw3bEdBN0E1R09jelpNT1FwTDU1VzVMTlNW?=
 =?utf-8?B?U2U1QUZFcklPVEhST2lRb1hhS3hOWm5NRHR5RW1ScHBqUmdQdkI0TU9kdlVI?=
 =?utf-8?B?Tmc4SG01K3M1Wk84cXhvYVU0cHVYRmRNRjBDcjBlZHFyWlNBbHdQR3plVUFJ?=
 =?utf-8?B?ZUhWN1dZSS9WUGk5VVpYSEVPOEJaVWxiVkdSR2NYVGFRakhuZnhDSEYwNjky?=
 =?utf-8?B?MURhTmdUMTFRc0Q3RFZvOUF2bk5IMnpvWlJrcU56WlI5TG5GNmxMME9nTW9u?=
 =?utf-8?B?UnE2WjVHSHpuN1V2dm1WeFNodkJLUWgrQ2FUUGZZRGJxTHlkZFFubm1iZzQr?=
 =?utf-8?B?Z3NvMk9OWmsvRUZ6R0Z6bFo4N3NNcks2clF5cXU1cTFuU3c2ME51VHM3c0dG?=
 =?utf-8?B?K1IwYWdtVzFnaG9ndks1RmxlTWxjWWRtdGQ5dnB6RlFBZmVDUHlYd0RlUlRG?=
 =?utf-8?B?ejdVMDNoNjhNcVJoTE9ZeTVYZGM1U0hReDJ1OGRkUGdzeFd2Zk1uRHZSU0lD?=
 =?utf-8?B?WG9FSFJOQzJnNjdvbkxyNmM3bktvRUN1R29teHF2STBhWVk3TnpjdVNYRU80?=
 =?utf-8?B?NmlnL2ZVYXBsK0RNL2RscHVqT0ptZHVoK3JzcThKbit3clhjNUdiS1RFYzVk?=
 =?utf-8?B?cXdzWnJIK3dmMHJmUWhEcnloVHVzcUphSURJSTNlOGszUFlyWXpYOFdxckI5?=
 =?utf-8?B?cTVJYXFWL1RidTZuR1AvZFUzcGhKbDVBdkZGQmNzMVVXYzI3Z1hhQTdGQWlt?=
 =?utf-8?B?bW5NNk9PWDRtRmFPVk1rNERuZmxPc0dkRUIzV1AvWWt0aU43ZlkwUUhFVkxK?=
 =?utf-8?B?WldLWUF0VnBPekg0TVdQTHl4MEU1OGx6dHZyRlloTDZYeDlWRzRUQVhnRVN0?=
 =?utf-8?B?M2srWWZFTFpLRE5FTUVHU0laTUhBdlo0bjNvamdwMkQrU2ZwV2xISW9YcWhy?=
 =?utf-8?B?YzVzNDM2TFVPeUJuVVBEbk8zaXFJb0ZKUUcrWTJwUzFkOWhoVGkzKytHdXNS?=
 =?utf-8?B?LzZwbUlnejVHRDNNWG9pVkZpSE1Gb3hKbHdCa09vc3F2NU9JNHhiL3UwZEFQ?=
 =?utf-8?B?Mzk2ZlowUWZVSUxTWmhlNzNTQzgvbEp4TmhKZERQTWliT0cySTFrMnBTYjJU?=
 =?utf-8?B?YXVOaVhCTml5S01MVU1kSkt5ZTJqaFU3emtiemdDVDZhd3kxSmdZTDRhWnFI?=
 =?utf-8?B?VlA1cU5pSnN2R2RIU2hQb0tUTUdRZ3NYV2dwSnlOQjU1ekJwUzdJTTNzeHpR?=
 =?utf-8?B?bXdBRWtJRmFTM2pzcXhsbGFwT0pJQVJOUFFhNjAwbTJreUlKL3lnTW1ob0do?=
 =?utf-8?B?WHp6YnloTUZHb0FpWUF2OUpyMDNsMkRyOWxFL1lEVjV0VUlhMnFoREhmcTFI?=
 =?utf-8?B?ejlOeXVGQUptRkExNkR4aGFtOWpFSlUvT3R2ZjFYTnE5bXo0M3IxdWI5Z2di?=
 =?utf-8?Q?W3dSicOGlgg1ChbEAju9t+DxbWuirFCeST06E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:58:17.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03954bc0-5ac5-4df0-53b0-08dcecffe4ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388



On 10/15/2024 4:56 PM, Sabrina Dubroca wrote:
> 2024-10-14, 12:07:20 +0300, Tariq Toukan wrote:
>> From: Jianbo Liu <jianbol@nvidia.com>
>>
>> KASAN reports the following UAF. The metadata_dst, which is used to
>> store the SCI value for macsec offload, is already freed by
>> metadata_dst_free() in macsec_free_netdev(), while driver still use it
>> for sending the packet.
>>
>> To fix this issue, dst_release() is used instead to release
>> metadata_dst. So it is not freed instantly in macsec_free_netdev() if
>> still referenced by skb.
> 
> Ok. Then that packet is going to get dropped when it reaches the
> driver, right? At this point the TXSA we need shouldn't be configured

I think so because dst's output should be updated. But the problem here 
is dst free is delayed by RCU, which causes UAF.

> anymore, so the driver/NIC won't be able to handle that skb. It would
> be bad if we just sent the packet unencrypted.
> 
> 
>> Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
>> Reviewed-by: Chris Mi <cmi@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/net/macsec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
>> index 12d1b205f6d1..7076dedfa3be 100644
>> --- a/drivers/net/macsec.c
>> +++ b/drivers/net/macsec.c
>> @@ -3817,7 +3817,7 @@ static void macsec_free_netdev(struct net_device *dev)
>>   	struct macsec_dev *macsec = macsec_priv(dev);
>>   
>>   	if (macsec->secy.tx_sc.md_dst)
> 
> nit: dst_release checks that dst is not NULL, so we don't need this
> test that I added in commit c52add61c27e ("macsec: don't free NULL
> metadata_dst")

Good point. I will remove this test in the next version.

Thanks!
Jianbo

> 
>> -		metadata_dst_free(macsec->secy.tx_sc.md_dst);
>> +		dst_release(&macsec->secy.tx_sc.md_dst->dst);
>>   	free_percpu(macsec->stats);
>>   	free_percpu(macsec->secy.tx_sc.stats);
>>   
>> -- 
>> 2.44.0
>>
> 


