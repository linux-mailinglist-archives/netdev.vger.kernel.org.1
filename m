Return-Path: <netdev+bounces-68191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5048460C1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742091C22445
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341385269;
	Thu,  1 Feb 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJXgtWGT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CA8526B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814988; cv=fail; b=G6flWBt0Ov77WrSSVNNg6mU90pFAlQAgc2xLAtG4sSuB5F7HamscYNASb8tGFj3yWi8Gfe+NlyiUFkNsemfPm8q+6tHFn1i7cvUOWm9JHb+NqpQ6jHfmbJ+zPhqFDikJyn/BiOhcfDTwZBVQSaAPOzwxxe7UDsBOmlCG23zJjSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814988; c=relaxed/simple;
	bh=Aa/fYcgDxNPeFC+zDDf9gu4O8gR4TO3/vvpR9Q1iad0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOrcjmNMu0sLcct7mmSgDV8yZ00BjH/O9G45/ep/LrerqUUW50AADv0UtH7BNXw807rZJS//O+Qzg26TX+l9s63a0opH3bqqYkdXzsF2phi2Y68pNodtuStvujwD9LFIgv3pp4TzgGAwxCkYgHB+uutyS7bM2FIwIJFnFcpw9kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJXgtWGT; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWha5piJt5NnR4KcKeIjxkI89UtN5L4+jKWXJ2KHdaY/jYXxmzLjK7Kk+Tgq+8OKupFjGzkRxN+TUCyqe0449Kna/hf6j9HCko5l57NPx6z6ApnHPJ3ds/0wr8X99nwfCpn3rFneKZuDN4hFXT+nrG3rnQCGKD/u9aaAlrU8QFEelI/fC2ouWDngyKlvie1Ci5p7JEvRbqBZJ+oTd8ZBoHyRqhJBAWMKyKTY5XRYUJV3v1u2J3c7lVae6AB89u04dsLwmMPGe63Ngxpb9Fg/rHiT+azDv9X15OBlppmNfWmxQCqfYkD86z0zVQ8cVZ1XdWPD2VvPzPDyuUHoiNw5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgE4hpPetwvpkWk6RoqAUVs6muaSXgX1j9ykFjPFFpE=;
 b=XhaT4Jq80c6UqfmTcVp+jwh8+9P7Iy0lgMczJXJ7FkuSHs1tC+Lq+a1uvDEEpfa4Q7yr/TjlU1otqTFcAodfX0O+PI2bprAK+wZvkbfTJWNey71bdNDEyzV0nOoN9CJXKMAFwxlnuU1AjP3X0dm9f3hGd5b9e3IM/taTjOD0mUJ/e81e3fknEuOziCyjpJdlbYy7n+vBLOgO1MRtCPT4lm2DSK7jrwnPxEZFr+b/ZIB/QdJpnoKF4bNks2R1lSkHUjIa54clE9xUutX4irSfLHHT7EU8pcouVOVAsioW49i2naS6bdv0/T1a3D+Hg7wQq6B8ptQd/6lXgxd5YD8S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgE4hpPetwvpkWk6RoqAUVs6muaSXgX1j9ykFjPFFpE=;
 b=JJXgtWGTMoUxwG8yHg4Kjr0BDzcyvLBVS7Z7MEio/ftwVvLKvuiiY+PA75w4JJxKdFWhvYoRNdCrIuZZGeIFIZbnX1JybqpodBD8vTmvTdmBd48CJnDzCOTOc+mN+W/xf2rgM5+TK2bRT0dD9Zr7JwS/UHAmpcLWSrJTfBIqygR8eKsLTK7RRxaxp51UEKj+9SlUdmQIijjovOijy2KZd2hROXo7wvTdoroC3Zb3+c0sMlF7TRosMBRz/kV1M5L13FPfb9EOhDs2YIEPgzpw443/lFOZVvLDp9M6KuokX6bUp+HqLbKAoSiHyrZBI32dZmO96szKQIF+iSEjX5Vvzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 1 Feb
 2024 19:16:23 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 19:16:23 +0000
Message-ID: <39dbf7f6-76e0-4319-97d8-24b54e788435@nvidia.com>
Date: Thu, 1 Feb 2024 11:16:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
 jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 ecree.xilinx@gmail.com, Yossi Kuperman <yossiku@nvidia.com>,
 William Tu <u9012063@gmail.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240131151726.1ddb9bc9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 707be26e-5202-425f-cd40-08dc235a477e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+cI85v+u64KwrFOu+1yKJglavqGD96gndYutVNhcCqMd3vkY7xABixcYa45nOe75cem7GZU+CUlEC/IpAB/Faypmbcm2CZXVRsyAjoHpIc+2b6NTokk9R4+XiX7LqJ2x5wGxFeln9+1zbSQZjsotYuJLcY/zFOaYwrhKTTrvsulv5dJ9pmKJggsxqFaO6JRw4SVk/WKkGkz9cY4/rnjFk2uAqQxZLUET2JDsPFa3gakuzS0AgBGtzaOSRWEfvXNJFTEGmK2vdQqBvvQ/UAFyc+QS8DHYOSip7sAClw6ao1/kJcI5Bfl8F1TCpUwwoBQ38MVfaqMOWk3QQDo8BDK/Wn40uFL3qkwqQ3lcWlViyhEax8ERoAuTTrWdyGkFoqtm5RksALjizRQ3J3XcRKxl4L3oUCXttS7TfDsH/yaF3l88UDb9ouwotISyc90DwrhTZF7GD4ZfcUOsR5G0p13+MeOyUL+HPbdiYfqf8wzuHx2x5JFLW+3U6HorEhUpowTP07/XH0nmiHaoyLAqb904WL//0lTQcIlHQjBDWebo96jxrl59YNV5G/nS7Y5BQXYGNIlip0AZluMSRPFvMSufTpnZ99C8sMxgwoyCeoHJJz+p+Xd9PhsRvuzdSlCKSRO6e2ZNkDyT38l2bYsY9RkU1UBjvx2vScW4vER4haI9+2Y9AMD+0Mh/VHKeluMmkqOAxvbIN6kpM5nTPRaomVqFhrFY4vRyld5o79eV84LjTuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(41300700001)(5660300002)(6512007)(26005)(2616005)(38100700002)(478600001)(6916009)(8936002)(4326008)(54906003)(8676002)(53546011)(66556008)(6486002)(966005)(66946007)(6506007)(2906002)(66476007)(316002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZsR2VOL0t4ZEM5TE5uWlFpT2t6V0cxSVlad215Sk5Rak5tYThMbDc0OFRO?=
 =?utf-8?B?dDhvdTRRT2taeHlkdEc2ZjE3YmV0TUl4NXVsRmh5TDhZR3JpRHB0cE9FVG1n?=
 =?utf-8?B?ZThGdGNHSXZYdE9hcWtlaTRYYmVVR0dxQm1vMm5mcVRwSGlFeFpmSk5mODBi?=
 =?utf-8?B?QU5UMGxDQUl4YSt2NmRSNUVEREVJZGhjWnNINlFYZUNqdVhvRUQzMXAwLzhH?=
 =?utf-8?B?VjdYaERCQ3hqekpZS3I1dWhlcXVodVR6TCtSV2FMNy9qRWJDUENJQ2wxc0wx?=
 =?utf-8?B?R1N4ZmxubTJCZkszYklRWGVkOEdQVlo1dWpKWHlYaGtkVUpYQ3Y0Q3RCbG5j?=
 =?utf-8?B?dEtpS1pZTHBOeUU4ZXh3alF6SGJLSzVWbnJ2WDExSnN1bW11UHNCSzlWbUdT?=
 =?utf-8?B?YjZnN2s2U29jbmZ2eTZRUlRqbGpqblpVd3o0UnBkNUJjU01FMGZDUG16QkNO?=
 =?utf-8?B?cEV4ZjIyMXZHaUFkRkpiaDhIZTBGbXlDRGoxUklGYXV4K1NyMWlGaStYczg0?=
 =?utf-8?B?cE5aaTJqMFMzaVhTdzBWRDF5V0wyNmNVUG9KVW5TTjlJK01mSGpWODVod095?=
 =?utf-8?B?SDdLWUd4T1JZdUJTNUpjRHZpR2V2eWNTQlRqYjU2VytGNGs0VzVDc01BSlJp?=
 =?utf-8?B?U2g4cGNTRk5VUXgxQnpnOE4rWTNQYlJuY0hyRnRPYzRYRlhrbHJtM3I5eVdC?=
 =?utf-8?B?VS9Sam91WFZ6WnpyeTJFZCtqWS9DOHpFVFRMMGtuZS9kdWV6WDNmYkMydGtz?=
 =?utf-8?B?WTBzclluY2doZTI3YU1mVDRnRkZqVmhhUVF6ZTcyY1JFcGNKYnVEMW12QVRO?=
 =?utf-8?B?cVMwMVZXVFNEQU5uc09xRHJyRHRJVFF5QXJ6RmtHbEtFbSs0dlhsb3lsKzgy?=
 =?utf-8?B?MU9rdkFjWVlpcEFNdWhRV3VTekNZTDJBc1dDaWVDSjRmRGd4em93Mko1OSti?=
 =?utf-8?B?eDUrTGtHMC9wU1JjdnkxNXorVGg3Q3N4Rm1qcmJUSHdFa2RsWGFUNHM3cFVG?=
 =?utf-8?B?cjM2ZGF5UXVRU3ZpM3dZc2VCU3ovOTA2NnBya0w1OHU3dlZOZjVuYWliejhI?=
 =?utf-8?B?NFE0TzJxS1l6cWo3Q1BncUVxbWkwY1VvRjk3NHJ0Y1Jmc0pVVUxIaytkVit4?=
 =?utf-8?B?eHJDUXdWRDVnbjNTVVlQU2hBeGNabDN5MGdEazhnWUx0K3NGYlIwdWlBc0h2?=
 =?utf-8?B?blRrdGtTZVZrR0JZeXoxOS95aXI1S2dQL0VnZHdTazhZclR4U3NjU0g0dEJs?=
 =?utf-8?B?MUtwNEhLd2FMdjk4U3VHZy9yTWJHTlJ0OVJidVU4anRHK2VJOVpZQ2ovbE1Y?=
 =?utf-8?B?TnRsdTRMR0xOM1dwbjJuNVVubjAxZWJpUUdHaHR2cWRmbkVoYS9NNFYrNGl1?=
 =?utf-8?B?UEdRb2lrSG5Jb2VXNzc2T1ZHZEVHeVhHZzNlejVTQUJPTTZKS0hQNXk4SlBV?=
 =?utf-8?B?blNGRXNMbGVHcnFva004OVByL2FxMXJCQU56M2t2UEFBbGNIQzVsQXpmOTd1?=
 =?utf-8?B?dGdyeWZMcks5KzFBZFcxVVo2SEgraTM0NE1CSU5XU3UvNnpPRGlrMnBIU2ZP?=
 =?utf-8?B?ZDdZamp6eHp6bWNFbmNkTDlDWGFQRGxDWW1rd1d3NlRVSUVDdDNQeU81SDBS?=
 =?utf-8?B?emhPYmo4MDdwN1BVbHFzZmZORUJBdFpCTW1NU0s3Ni9tbXY4OTFaRjIvVHRN?=
 =?utf-8?B?R3htcFRCdVJtTlFnMGR2MlpEcDdoOWx1SUNKOHpZa2FRV0J0ejc3SGRXTHRS?=
 =?utf-8?B?WlhCdm4wbjZmV0hBekdEeHUyWUtrVFRFNVZrZWE5cjJETUp1bUx1VGpyTUEx?=
 =?utf-8?B?aElkbzZ4KzRZWnFBSXdSb25TUnJHOS9kYnFqSXI1TWJPSXJkSk5qVTl3OWxI?=
 =?utf-8?B?blQza2x6aU9rYzBDSm5tYVNEZHhnSURaQnFQUmthTGlBSHNTVkdDdVVkRlJC?=
 =?utf-8?B?cDFNUGZLVElKUDdnZDVzd0x0TzhXSjgxcjBpYXg0VFdpZ090WWc3MkVGVjU4?=
 =?utf-8?B?QTYrQ1Y3WE5Od1orbWtwT1l6aGZsZ1V1TFBsd3BzWGNaMVZaUjRYelA5ZFhD?=
 =?utf-8?B?OERUaUEzMCtEaE52clhFeXhUOVRXcXR3bEI3N21CN2c4Y3JkU09sN0Z1S3hM?=
 =?utf-8?Q?CHarh7xq++FSFHA6DwSXOMBxs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707be26e-5202-425f-cd40-08dc235a477e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 19:16:23.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MghdtWDc/OfMAs1k09jvhyoOPpMYV3ZHyj8M5bTnT4qbUeXL/i4B7eXCfiKgYp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025



On 1/31/24 3:17 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
>>> I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
>>> all do buffer sharing. You're saying you mux Tx queues but not Rx
>>> queues? Or I need to actually read the code instead of grepping? :)
>> I guess bnxt, ice, nfp are doing tx buffer sharing?
> I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
> I'm 99.9% sure nfp does.
>
> It'd be great if you could do the due diligence rather than guessing
> given that you're proposing uAPI extension :(
>
*

(sorry again, html is detected in previous email)

due diligence here:


Summary

======

1. The VF-reps that simply "use" PF-rep's queue for rx and tx:

    sfc, ice (under review), bnxt, and nfp

2. VF-rep that has its own rx/tx queue:

    ice (1 rx/tx queue per rep), mlx5 (multiple rx/tx queues)


case 1: no way to prioritize important VF-rep’s traffic

case 2: scalling to 1k repr will wastes lots of memory.


Details

=======

Based on reading the code around open_repr, napi_poll for repr, and 
search commit message.

ICE

---

has dedicated 1 rx/tx ring for each VF-REP. Patches from Michal under 
review for VF-REP to share PF-REP’s queue.

see:

ice_eswitch_remap_rings_to_vectors, it is setting up tx rings and rx 
rings for each reps. "Each port representor will have dedicated 1 Tx/Rx 
ring pair, so number of rings pair is equal to number of VFs."

and later on it's setting up 1 napi for each rep, see ice_eswitch_setup_repr


BNXT

----

no dedicated rx/tx ring for rep. VF-REP rx/tx share PF-rep's rx/tx ring.

see

commit ee5c7fb34047: bnxt_en: add vf-rep RX/TX and netdev implementation

"This patch introduces the RX/TX and a simple netdev implementationfor 
VF-reps. The VF-reps use the RX/TX rings of the PF. "


NFP

---

VF-rep uses PF-rep’s rx/tx queues

see:

https://lore.kernel.org/netdev/20170621095933.GC6691@vergenet.net/T/ 
<https://lore.kernel.org/netdev/20170621095933.GC6691@vergenet.net/T/>

“The PF netdev acts as a lower-device which sends and receives packets to

and from the firmware. The representors act as upper-devices. For TX

representors attach a metadata dst to the skb which is used by the PF

netdev to prepend metadata to the packet before forwarding the firmware. On

RX the PF netdev looks up the representor based on the prepended metadata”


and

nfp_flower_spawn_vnic_reprs

nfp_abm_spawn_repr -> nfp_repr_alloc_mqs

nfp_repr_open -> nfp_app_repr -> nfp_flower_repr_netdev_open


SFC

---

VF-rep uses PF-rep’s queues, or PF-rep receives packets for VF-rep


See:

efx_ef100_rep_poll

efx_ef100_rep_open -> efx_ef100_rep_poll


“commit 9fe00c8 sfc: ef100 representor RX top half”

Representor RX uses a NAPI context driven by a 'fake interrupt': when

the parent PF receives a packet destined for the representor, it adds

it to an SKB list (efv->rx_list), and schedules NAPI if the 'fake

interrupt' is primed.


MLX5

----

VF-reps has its own dedicated rx/tx queue


all representor queues have descriptors only used for the individual 
representor

see mlx5e_rep_open -> mlx5e_open_locked -> mlx5e_open_channels -> queues

*

