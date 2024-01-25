Return-Path: <netdev+bounces-65701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6120C83B660
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91111F215DC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C197E1;
	Thu, 25 Jan 2024 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="aR5vBz/J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002D1860
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144832; cv=fail; b=jYxaMZTakNytNJ2Lx1dINnT54Yg/T+VCL6RJAQ2xyeHV5LPtPGm6u2Cbf/4W1YsQm0fyjU9+/NE8esYOcI40hBLYgDJzGG3l6Tp2TqhFHQvQLEhYupa4R0iqA2/3ZmrHSST7tKwr3KUnH5vM+HD1rOT6JSv0HL7cfc+H0UKjjAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144832; c=relaxed/simple;
	bh=5iV8NLuxL3NALd9AG8Ck2VjG4GduKUL1Hl87Rtx/f68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sfr6gFhuuPcOfWi2AGohWzGDOvOUuyxQTLezGhFIiCBHBVxF9gKMb4RxU5NhDdAfwW6JTID6cO6bQ77zG2IfYiYwxEIFtI+/lmnLKamTT2Uo4OLgLmW1H++wFJ21POJZWTxaXYXL9ZELIZblp7GoLqGxfBpKZWCJuyQh7IMVbTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=aR5vBz/J; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P0AfB5001945;
	Wed, 24 Jan 2024 16:37:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=obRUjc/QZQkG0SkCvd092MB4Pw/YZ6mOKozM+ocHaEI=; b=
	aR5vBz/J54bTbTVBNdvaoi/ohmIgtrfY2846H/3ReYC+K8OHfPx4LRzIKGMplqd9
	VBJhKEj54m9BtoKrAc520V+CRvSdki2qzoJsJTBWKuqzUzOd0QLi7kBadGo7nd2X
	30222um2TvAtuc4mDVPxX2O6y1DkQGXL6kuiQKfxsRYO8aB+LA61Xr1aOf2mtm0m
	iwdR6wp/hqxK1lrAaagJeWxJE9kravwARk07JM6s/nhRspUvEssMJcWj173lvfCl
	q3Bh3RcAOwXj7nsUhDizrzU8nORnOKrbKchfKYJRcFwOh2KyPFtg4qLwYROfvtXL
	soa9KV7siapnRNicJb0gXg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vucv4r0gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 16:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ1F5P6E0EAD2H9RPLi1anlpQrjR5l7jRLXikJhxAZoUl2LTBrSv2g/ry3z0/d1WsVJdxnAYRoZ6tV+lGVgTVEEv1483DnYdDUreTZy4/XR+mhxHsZ/fS86yP4/u5CBe2+SRtEGRN4uPJMnS4NxOCjor64FeAJYgk2Y0Vbq+MX2WOIPr4c1FfBGDM0/fk9cmU44tdBxJm5B8HIa4QHeToGO/STc2agsVQIbbuuY4c0w4/xlw2EJ4irC8+tTbqH0IfY0+w6AzFocrKsWqZJ/u5Tt5ywgeN4Qjo7DSxY8LlgeV7tyy5ZR/iVsEdRvnaweqUrimpZ65FsNy9rFA3BDrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obRUjc/QZQkG0SkCvd092MB4Pw/YZ6mOKozM+ocHaEI=;
 b=QupwWbPCzrbhEp1OXLl79DD8IC96+NH6/EI0kg7TAoH4/TidOPprjEEQdJWNPNI/4/C1pHzVIVvpgXzir2mJ0+jHkurrLRgwg1b6sQuhrSOfFeSIWgKNR5pWcsY+FATErF/p3oBXfX6S/RTfB+PY6D7twLs7QpwBAELv7EimGvzpWvnnHRsRRpMRa1/+fP/DENosNxyd0SiRvUgEw3blW51kzQNDz5ov2U+bKfH64/AcbdQL2bL6ehnCDRD1W176O/e/jap/Th/npqPquyGNUqqO81CnCUAg2jbJsqK5TJ9kidcnbgK++bixLSLk3jo4jAcYuFIY4rAMCUPsUJRiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) by
 DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 00:37:10 +0000
Received: from DM6PR11MB3404.namprd11.prod.outlook.com
 ([fe80::30b0:3821:7733:bc6b]) by DM6PR11MB3404.namprd11.prod.outlook.com
 ([fe80::30b0:3821:7733:bc6b%6]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 00:37:09 +0000
Message-ID: <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
Date: Thu, 25 Jan 2024 08:37:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Content-Language: en-US
To: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Vitezslav Samel <vitezslav@samel.cz>, netdev@vger.kernel.org
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
 <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
From: heng guo <heng.guo@windriver.com>
In-Reply-To: <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3404:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5962a9-29b9-4418-6bc5-08dc1d3dc37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5ms8vcSWmZ+5KJdFFvwVuzebm6hPzOqwj8dHNiNaCUWPF+d2krKvSjyLfNQFnl9Vk8D2K3Es+fW9LJEx7wVEd+lzBkJ5AXpoZwp1he8eJbyH6K0Q6oadvf680bXwJjzqDCHbhwELnKZulhZucSLNmkExoS3RUF7qmtbKlfPKfU9O0WsBk8wwzDctFNraVbNgWz79dRHcDay92w/phKG9r9jtwnyWlgsarkE+r08ATxkfzljK0aragtmGtAifW3R6mXwsz3qUFNx5mkOpiQ7n/JGgLG0M76m4+e3WcVw6Oby4GeXKOFWw8IqzaO9W5TszzJJpR2CqAzM1OwHoBJiOralwvC02rs/OaBzv/YvcposnL3IZtZU3Hzx54wzON8rKk6pgHDS15xv3MqmE3PvBA2i3TcgJXGaZ01l6tpLOfYmGM+zPWmMEKst/xliw1i3RaVEdNZbn/juZIE3a26GweoPZz/6s4KP2qvkgWQItqnN/wg69lzCeRolGSuDuKBY3R5r1fr30u7geRa3uzVJ2j6n61Yy68byvg+O4LpgLFE5e8L2pa5HtZJr58Q/tutgMsMjE+pzos1Gw8GjyY0uGUsBlyrhHvI3a5PRSXk04LYB+YZd9PD8AT98rj6MmThY9QURHX8El6xbH6R0wC9w5kVH2h3yzOPUaGnBp+nnPnIglGPcR2L7RgHBZdk4HKNqETZ0dmBH/pPhkKAA02gcNIQeUfsfvOXMAzWIJVCG9QDo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3404.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(396003)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(53546011)(6506007)(66574015)(26005)(83380400001)(2616005)(8936002)(4326008)(36756003)(8676002)(2906002)(316002)(66476007)(15650500001)(5660300002)(66556008)(31696002)(86362001)(66946007)(110136005)(6666004)(41300700001)(966005)(6486002)(478600001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjdrMEx3R0hWWDN3VVhKVC9wdW0vbDNJbk1POVE3ci9FZThhUzl5RTRHVzJL?=
 =?utf-8?B?RndmWTdlYTN1dEF6OGJOSWxWQk1EVVNtUW1QQk4wcHlNWnZDc05WR3hhOUpy?=
 =?utf-8?B?cDgxZkFlb0VScEcrMG45UUxDQkJJUHJlUG9GY1YxNVdhb2poRlhvT2J0OHNI?=
 =?utf-8?B?cnhWYmxNWkhZR3lvdnNES3lQTXVmZ2RRKzdwQi9GbDlyaG1GTVovdnptUmh4?=
 =?utf-8?B?UDZrd0FzbjFkQkdxRzcwSzZXcng0QzlkTGxHK3NCOU81RnpuRmp0SkhKdHVl?=
 =?utf-8?B?ZjFQSFl4aGFqMWVvaERNSTJGeDErM1llVWJiaFVHZ1owNGNjSmZ0S1dvWUsy?=
 =?utf-8?B?NDFTanNlRFdSaWNPbjJrQUtscnprbUJZZ25WZm5rNDRXWWF2SHVxa04vUW5l?=
 =?utf-8?B?SnJQbzBHWEdUUWdWRTA3TXJ3V1JDK3Z3aUJIM01uUktEc284K3QwRVdkMlhu?=
 =?utf-8?B?dXF0c0UrZ3pwNmhhdklIRXZRTFFSR2RxVUNvSHMwbEZ1cVJzZEwxeHIwWndu?=
 =?utf-8?B?SWZtQlVNRVJTNjdMeWhpTlVTNUVPQVhEOGRNVFUyRm5wcnE4QitlSDVMUVZw?=
 =?utf-8?B?bVRVL1JzOUl5NVVyb0h1NU41RnFkakIxQUQxeEMwYVgxMGhtQUVrM3RFOWZr?=
 =?utf-8?B?TEovVGRYeVU2MXJ1Tlc5UHFBSWdITml4a2xDNlJzSlZXS2dVTmhWZ0NxVlhl?=
 =?utf-8?B?SGtWTmROU3grV0xpdVZTUDB3OGdTZVBzaUk0NmxGempvNkNQOWhQVytPZFV4?=
 =?utf-8?B?MWdBenJ6eVhZT2J6cDRFWjdLTUhTdGM5ZGVqMWRVZTRENUZHOE1GTDRKQzNx?=
 =?utf-8?B?N09XNmZwYlF6aFU5dFlxUWtGWlE4VGYzZjkwTXgyZkZ1bzVqNVNOM0pYL1h1?=
 =?utf-8?B?a1dKaTl1ZEpjbnd1bXcwNDduYTA5alI5T3UvbWRMb0xJOVEwbm5aNVprNG85?=
 =?utf-8?B?NTl4MUpIM0hQNVhsOVA0NG40ZTlQMlB3SHpkZXF5bWx4T1UveE1aRys0d1Az?=
 =?utf-8?B?N1o1ZzFrODIwa0VSZ2Ewb0JuSEdFWG9raVZKZzRGN2RDdFJiejRGVXc4eEFN?=
 =?utf-8?B?aFRUWGFpZExzcS9NZktlanNWd1RRbHhMWjNiYmN5TlpXQmlSbk90OTNJa0c5?=
 =?utf-8?B?eUs1dlhpSHRiQmRaVTVHNUpkZTBWeXcybEd5UVZmaE9FQ082Q0VNaVBIS0hE?=
 =?utf-8?B?MjBvdGJQWjFxdjZpY0o5eHp5Sk0wMkl5ME03UEpKRDFSM09yUXcvclVyci80?=
 =?utf-8?B?VlZVQnJDYzg0c004UVg3RmxoSjVHQ2l2WHNlNVJyQ1gwWGJVRFdqRnBoU1Iv?=
 =?utf-8?B?eUM4RVFSL25VdkE5NG5aRUF2dGtJcVFZSlFjcnhnL1picjlhTnUyODhqT205?=
 =?utf-8?B?Z0Z5MmhqQU92WFZFOWlETjVNRXRMWGtwaXdmam9OdWdmdC9JMkM2TlFmRXor?=
 =?utf-8?B?dzlXZHdDcVcvbWFPTzliZU9CRlJWVE1tcG11S1JBcjZuenRoKys3UkgxaC9D?=
 =?utf-8?B?MmNpeW1uSkZJMDdGSmJOUVhOVVdNa1VraGR4aFJuT2cyQ1prN1BXb2FldUVi?=
 =?utf-8?B?SWJteVVneTlpQjZXWDAzejZMVDI5NW1LR2JZcHlocXE2SmpqcDJnSVlQVWNU?=
 =?utf-8?B?NHZ0N0lKQ0h6bFlMdUJnTjhmdVlPQzhDNld0ZHhmV29OL01NbGlxNkw1b25Y?=
 =?utf-8?B?blNTbWptNXhreTgyQzVxSUlqdkFiakEyVUNQb2JqNllMWCtjeVk4ZkE5eVY1?=
 =?utf-8?B?NVRyK1N4ZEthTjY1S2RRei9nTWlaMWVnS0xEMFBYZ2NTbTdWby8wMjhLVmMx?=
 =?utf-8?B?M2tJbmRsVmV2aFVlS2NKdFg3Nk5MQ21YSzM4VHJsT0FlbkpMUGFPTFpvSlNX?=
 =?utf-8?B?dkZYVjlaTmxZSzR1NzFQK3dWd29UV3FlSkVMR0JPNzVPQmd3NHJpTWFRbkhJ?=
 =?utf-8?B?K1dwQXZKTGMxcGpZa2YwSUxQdWFjcmMzb1lzVnBsZUM5eFZkc3lTZWFNNm1F?=
 =?utf-8?B?SFlUYi9QNlhLT1JkR1pxTGtqOGJ2VGM5VVg4UzVoNEtRZmVWODJvZ0tsOW1i?=
 =?utf-8?B?MloxSy83NGEzbFM5anZZOU03TlVsNWhXTHdab21lV0ZQbzFtbk02Z01FNWFx?=
 =?utf-8?Q?NUM4HL40lNE8KrFvXlS+gmGAI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5962a9-29b9-4418-6bc5-08dc1d3dc37a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3404.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 00:37:09.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGFUVKwYcuyxN/ViU7ekCw/FxvgeODyE1DstcvO3bPnbTFymPW2nragpLTEIRSfF/X/Tk8BjQWCONfl2fHifsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-Proofpoint-GUID: QxlOHbyU_M5uR1eEQpQpYHaNgt8QyNmq
X-Proofpoint-ORIG-GUID: QxlOHbyU_M5uR1eEQpQpYHaNgt8QyNmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250002


On 1/25/24 05:55, David Ahern wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 1/24/24 1:30 PM, Jakub Kicinski wrote:
>> Thanks for the analysis, Vitezslav!
>>
>> Heng Guo, David, any thoughts on this? Revert?
> Revert is best; Heng Guo can revisit the math and try again.
>
> The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
> shown in proc but never bumped in the datapath.
[HG]: Yes please revert it. I verified the patch on ipv4, seems I should 
not touch the codes to ipv6. Sorry for it.
>> On Sat, 20 Jan 2024 10:23:18 +0100 Vitezslav Samel wrote:
>>>       Hi!
>>>
>>> In short:
>>>
>>>    since commit e4da8c78973c ("net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated")
>>> the "Ip6OutOctets" entry of /proc/net/dev_snmp6/<interface> isn't
>>> incremented by packet size for outbound forwarded unicast IPv6 packets.
>>>
>>>
>>> In more detail:
>>>
>>>    After move from kernel 6.1.y to 6.6.y I was surprised by very low IPv6 to
>>> IPv4 outgoing traffic ratio counted from /proc/net/... counters on our linux
>>> router. In this simple scenario:
>>>
>>>       NET1  <-->  ROUTER  <-->  NET2
>>>
>>>    the entry Ip6OutOctets of ROUTER's /proc/net/dev_snmp6/<interface> was
>>> surprisingly low although the IPv6 traffic between NET1 and NET2 is rather
>>> huge comparing to IPv4 traffic. The bisection led me to commit e4da8c78973c.
>>> After reverting it, the numbers went to expected values.
>>>
>>>    Numbers for local outbound IPv6 seems correct, as well as numbers for IPv4.
>>>
>>>    Since the commit patches both IPv4 and IPv6 reverting it doesn't seem like
>>> the right thing to do. Can you, please, look at it and cook some fix?
>>>
>>>       Thanks,
>>>
>>>               Vita
>>>
>>> #### git bisect log
>>>
>>> git bisect start '--' 'include' 'net'
>>> # status: waiting for both good and bad commits
>>> # good: [fb2635ac69abac0060cc2be2873dc4f524f12e66] Linux 6.1.62
>>> git bisect good fb2635ac69abac0060cc2be2873dc4f524f12e66
>>> # status: waiting for bad commit, 1 good commit known
>>> # bad: [5e9df83a705290c4d974693097df1da9cbe25854] Linux 6.6.9
>>> git bisect bad 5e9df83a705290c4d974693097df1da9cbe25854
>>> # good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
>>> git bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>>> # good: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>>> git bisect good 6e98b09da931a00bf4e0477d0fa52748bf28fcce
>>> # good: [9b39f758974ff8dfa721e68c6cecfd37e6ddb206] Merge tag 'nf-23-07-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
>>> git bisect good 9b39f758974ff8dfa721e68c6cecfd37e6ddb206
>>> # good: [38663034491d00652ac599fa48866bcf2ebd7bc1] Merge tag 'fsnotify_for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
>>> git bisect good 38663034491d00652ac599fa48866bcf2ebd7bc1
>>> # good: [7ba2090ca64ea1aa435744884124387db1fac70f] Merge tag 'ceph-for-6.6-rc1' of https://github.com/ceph/ceph-client
>>> git bisect good 7ba2090ca64ea1aa435744884124387db1fac70f
>>> # bad: [ea1cc20cd4ce55dd920a87a317c43da03ccea192] Merge tag 'v6.6-rc7.vfs.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
>>> git bisect bad ea1cc20cd4ce55dd920a87a317c43da03ccea192
>>> # bad: [b938790e70540bf4f2e653dcd74b232494d06c8f] Bluetooth: hci_codec: Fix leaking content of local_codecs
>>> git bisect bad b938790e70540bf4f2e653dcd74b232494d06c8f
>>> # bad: [6912e724832c47bb381eb1bd1e483ec8df0d0f0f] net/smc: bugfix for smcr v2 server connect success statistic
>>> git bisect bad 6912e724832c47bb381eb1bd1e483ec8df0d0f0f
>>> # bad: [c3b704d4a4a265660e665df51b129e8425216ed1] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
>>> git bisect bad c3b704d4a4a265660e665df51b129e8425216ed1
>>> # bad: [82ba0ff7bf0483d962e592017bef659ae022d754] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
>>> git bisect bad 82ba0ff7bf0483d962e592017bef659ae022d754
>>> # bad: [dc9511dd6f37fe803f6b15b61b030728d7057417] sctp: annotate data-races around sk->sk_wmem_queued
>>> git bisect bad dc9511dd6f37fe803f6b15b61b030728d7057417
>>> # good: [7e9be1124dbe7888907e82cab20164578e3f9ab7] netfilter: nf_tables: Audit log setelem reset
>>> git bisect good 7e9be1124dbe7888907e82cab20164578e3f9ab7
>>> # bad: [4e60de1e4769066aa9956c83545c8fa21847f326] Merge tag 'nf-23-08-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
>>> git bisect bad 4e60de1e4769066aa9956c83545c8fa21847f326
>>> # bad: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
>>> git bisect bad e4da8c78973c1e307c0431e0b99a969ffb8aa3f1
>>> # first bad commit: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
>>>
>>>

