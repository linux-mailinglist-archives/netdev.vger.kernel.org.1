Return-Path: <netdev+bounces-284574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFBXLZlM+mndMAMAu9opvQ
	(envelope-from <netdev+bounces-284574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB44D35A5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99E930D31E5
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884904C956A;
	Tue,  5 May 2026 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/vrWz5y"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769B4C9543
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010813; cv=fail; b=cOmZk3uv9RhOOHbn/+6R6SCXhxmMhlMWNvpbV9gQA5nkEBWdkU37oTPOoyK+mM6HwzcUzAv8eQTwcBmTvKlnikdMLTFkPkHlsvXVJeId7xKtk8yE83Fd9uB8gRXKP/xypvxuHYWTToLsoI03csL11cD5Jgzb4/Dx/m/W2uPSfTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010813; c=relaxed/simple;
	bh=44E/Pyzeor4BMTj5JC3YJWg+NGmLBCzmxXJPFHiamjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WB75SkuFRgQsztaciFQLDF77jGhTsHie5s+bAAqLLUV/DyIlF3LbbzARimFOph1R5cmkOSNlJGBfSEDI9Sphey6O6UEihP44KbAxFb9G9ivAxrsQWS7Q12hI96f7mGJZb4kGiKlyvvqqUQ4NBMU9JFsB/4EXiMpHtTnofT4Pl80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/vrWz5y; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGafkktI50XvcJWta/Aychvk5ahiS8V3u23nEnTNTd6kWOEOPA/hBomxtwH6IbAeMRCns2WPN0zEKIvbPI7QC8jLYQ7TjgjSpl5aN10/Z5JPuE6U8j4jfahNnd0ooeADIBHDPRqQcoXLUrKYwREdu6/AaeBADhKs4C6jNWgUSDLWJXNY+VU8iFBlANgd4hIurGVMjXRmGgx729WLGAMNBhGO0bH7v1Ck/39kiEjyKP/ZJaWbW6RPGCN6/p277lKat8LkaIY8Vb+AWJ84yLSav5qYZh4PPujswiyRpzUXzgeXT8pdu1NPaLMQvGDG7z+QCYfq9s+vSLB8NkDaSc9zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yedqp78z9jASY/VUbCUhXRsOWC7jCY2JtK1x2U4BXs=;
 b=eEf5WssyR4fSiM2kx09vYjj3cEmJ9xhuf3zAgzf58dogHiwUQUQiTrWOPG9CXF6mHu/Lg0FIFuLlGKbPg+PyNOlxKhJJGpEO+rHgTQclzYB9YJtF/xVF0OYWZVRDv6UPJBP8l0ZCTDP7EHJgrcUQnlGi9sFP1gHbNc+90dliuSPTyPBEw54gb9zCHMHlcCCR11a6q0oGhc3cb2WJvvyzkUGVbZX6SCKiE11usTKW/h5HKm5Hx8AEVeeSSLgyvz1gTWuqHyP66keNmZsh1cqMCtzMPJIuskblEd9WDoZhqBsyrbXt0TvbHFP/YFxcPZDr5A/H3paJ6cC8HujP6CP7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yedqp78z9jASY/VUbCUhXRsOWC7jCY2JtK1x2U4BXs=;
 b=o/vrWz5ynqJx1GxuxrjdsSVOW6sSqA65gg7VPvlTF1ARbH2wTB8zQ0i7HwSL7jpgRKd/HiYBf0F93FDDDleuu7PMeuZL4/kot8P33fJb9S9NO2/ZF1uehvNyZaEDAnNl6T0K4mmPt0Pc4mXFWK02er3/sxpEeP32uWNIF6u/Vdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Tue, 5 May 2026 19:53:28 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:53:28 +0000
Message-ID: <a1a9ebf6-fde7-40bf-ada4-7b032a5fdafb@amd.com>
Date: Tue, 5 May 2026 12:53:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ionic: Report "link_down_events_phy" in
 ethtool statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-3-eric.joyner@amd.com>
 <20260501163951.0e0b7e97@kernel.org>
Content-Language: en-US
From: Eric Joyner <eric.joyner@amd.com>
In-Reply-To: <20260501163951.0e0b7e97@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::11) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: ad91aaa9-9f06-44fb-7d9f-08deaadffa10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1zPrfVRC4CFFCEQKQtm98s1Fp7otLMoc6miBZDYwRLrlVkor2gJBeOQFjcVoD+UI9DJDJYqKCC99u0kHG7mev3vHVTfRYzR/ai8Q+M6OG83CQAz1iroIa+KcncG4JdYH7rC8o3SYUhzncLpE8bHMwGWaVBjJ0oNocNUBL6OurD1IsBQNpkHexIXKP3HGDcxOG06Mx5kVrUuyJiIle7fujyc6AVgdCxkI/LxpbNQFmcVPn1FKSS/GyXwrp8ByRzxR2GglTB6rLwPl9CuoT1iwioijMmyyC11d162hzeTtU1LmthNz5+atkMJRrpuZyd2IYqPa0MTE9sTCOCj7KaKcZHzkqSwxekZg8i5p/L80JJSNWE6VElRBxtkMJHbkFdHJADfFxv8Qc5Qq5mYveCQmE4lyA+8EDl7JwV1gcfDtUjRPzkvGX4eFsxjgM3eiodf52YC0gnBkx+ZYsRLbefteH20mutLeswdJl4TwkvdbPYjuew9r+qCOGh3mY0QLNeFCQIXCLrQR1hXFunrqlIyKyqFimFPV4cCfO6ygWKLrqz91ejBWjpYJpxNzFRuXhOVupOyMUWdL96nY7FB9K+wWSAmAROdnUf/PGkXsvNx4TXJPVkwtm58oFtFH80IqaTP2nmImMlVxCuuYt/J4AXPSpscLIAbVXHGoNsrgQojOWi7LPE0D445YCxDf/CppRwGf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJiTFZOQXA3c0k2WFJiV0NaSmZxcFRZQkFTM2RoRTlzWUNFczJ1TEN0aVY3?=
 =?utf-8?B?Ukx6Ykt2bGU0OVFTZXV2U0NEUDhjWDlZbjVYUmE3T2VUTnlHa3ZEL1Q4TnBZ?=
 =?utf-8?B?OXRqUzFqcGxnZ2hlSTEzSkFLQm0rVTlWc1B6UmZ3V2JDNFJOMW9JZ2FibDVr?=
 =?utf-8?B?a3ZOV2dZQjAxem5xVHFLUFNDTWMwV251Z2pzeVc4YlBqSE1IS0l2VHlQaURj?=
 =?utf-8?B?K1ZkbVo5c0ZLbmp3TWRKaWFVT08xbXV4aGs3dGl1bjVZbFhwdGZDTUlDd3N6?=
 =?utf-8?B?dDFyS2JyNnFOZ3NrcXJ0MVd1Z3dsNEs1bjhLbWZSV21wNkpJZzJjSUVVQnl4?=
 =?utf-8?B?TWZJVnRQUitnYmx6QUpocHlBbHA5N1MvREVhblh6K3pLeTIyZFZ0dG9nMDRZ?=
 =?utf-8?B?YVpWSzhsQUtmSEpMQkMzYkxNRC9LcjdQRStvSXZ5TW83VHEyVlhRS3psK3Bt?=
 =?utf-8?B?SFlxVmtreDVjblZOaFdKRFJzazFYRmZ6NDdCbk9uZlRaRkVYMUtQbVFOeUVU?=
 =?utf-8?B?anNMY1hMN1lwVlBORUhpWGhJQTRpM3o4dUZuRmFWUnhnZ2ZOWnppY1VpbGFE?=
 =?utf-8?B?bEt3LzVxSHJZTzFHT3Y0V3JiT015MHMwSlRZdnBmbTZtQTdKMHZ2aXBVNmI3?=
 =?utf-8?B?eG5Fb09jU1RYb1d1ZkI2bThBc3RCVy9TRkk4TUZmL3k3WCtEOUx0NkVEQmpC?=
 =?utf-8?B?UG15S2dmWmhiVW5jWDN5cGJBckJkdVZSTktaZXc1V1dFbWRwYkFOdTl2Q2lU?=
 =?utf-8?B?UStTSjljM3N6aXNjdmxDdVZjdnFRT3Ivc0VFWWh0N1VCTmxiWHNoQnZiNC9W?=
 =?utf-8?B?eEJib08xTGRuZVplaisyNk9KK0p3d3JYTm5yYmxhY3VoSTZvSlhGYUtxc0JM?=
 =?utf-8?B?S0kzT2pud0JyTC9OTUdXejUrQ01sdHNmR0twZEdmRDl6a0VCZEpocXZWc0Rt?=
 =?utf-8?B?SlNDT0F3YjBiR0RZeit3REZaRnBrVUdIQTY0TWUvS2xYL2oyZUVOdXB4Tnlr?=
 =?utf-8?B?bUI0TkordW96OU5yUmQ4VXFDNUJROFFxcWhwcXdqSmJSTVNWRnJ6NGRod053?=
 =?utf-8?B?YkVRalVQaVo0ZVRqdE5FWjgweEo1UzdTSG1waWJYbHJMR2s4LzB2NEpNQzNu?=
 =?utf-8?B?UU81NU9HNVRvK1VuczRzK2JJNmJPVG1ncElPUWh3NVhiclVvMWM1RXU1a0RC?=
 =?utf-8?B?UTBtV3BQWFREYlJpbVNYR1pOYmJ6ZVhBdGowMXJCanlEczZzbnVjdzh0c2Yw?=
 =?utf-8?B?cG1sbDNtSTUyRytsTTk2Q1g5OCtVT2M3aDBxZG85b3ROUHVMb1FsWGFOTXFO?=
 =?utf-8?B?bTFERzZpWGFrYWYzMWx2dmQ1UjdpNEw0THA5Qy9zeHVvQjRrTEJYUUxtVUxT?=
 =?utf-8?B?UGdGU3ZEU01kY0JRVTZSamNvZzFyVUxqWTZPR1FMQ1dZZWpZMGVhUTRCKzNY?=
 =?utf-8?B?ZnY1eDVscjhick9aWGdZb1hCbVBjc2sxb0JraFJVc25MSGpEdDFNT1E4djlS?=
 =?utf-8?B?NXFsanMxeG9xaFdmOUExM3BTanlxYitibnlobXNZM3J0b2F5UzdOaGltcElG?=
 =?utf-8?B?aXkyYnI2REJaWjJ5NkVDaGk4WUtoTUM4SVZZYmtldXI1WHlSdUY2SWlqcSt6?=
 =?utf-8?B?dzF5UHBBRkpoWHV5TnBQcGV1N013RkI1MkRIVG9ZRDFtQURpeVFIZkE0d1Mw?=
 =?utf-8?B?ZzU2TTZ4VUdlU25EZVNOZkgwajRRNmZOZ2Y4QjJac0hhUnB0TXVqcW55T2Jz?=
 =?utf-8?B?cVp6QkdMeXA1RVdLS0c5WFNUUXF4TkI1bWhFcUFHejNORXRjS0M0NG5XZVFS?=
 =?utf-8?B?ZXIwYXJoNU9ya09NdVJXamVGYVZDaWsxMmF1c2l4Z1FYc0lzcnRlS05tTGw1?=
 =?utf-8?B?TUcxdzRyU1pNNzdRYmllMksrSVN5eWVQNnJxWXduVmpvZG9DQm5NYndkRDhV?=
 =?utf-8?B?NHhMNklCSjdiMlR2UUQvc2ZZR05wQzlva1VGQ2piaW83Mk5Lc1dCZWU3ZHdE?=
 =?utf-8?B?Vm1aUWNNcmFsZm55eTExTUVEM21wdjRKQThnc0E4Q2MrejM4eUpIWDdROUps?=
 =?utf-8?B?aXQrckY2L3dnaTNrT2NYWllnR3N3QkFCNy9oMmNlakF3ZjdRUXk3ajVFLy9S?=
 =?utf-8?B?RG16SVZoYzZPbE9DREk4VUNxS1FrakIvS2NaQjdDWENqQmY0aktHTFRkbHRp?=
 =?utf-8?B?YkptRmZ3RjVOemtPNk9WTDFQazR2cDNxaVdRZEFGNVNjQlNSUk96REJ3b3Z2?=
 =?utf-8?B?QjR5U3hnNjBFS1NtNVl6bVA1VlNlYlkxcEJzbTdmcWxwNWZibThhaDNTNGhP?=
 =?utf-8?Q?XaCxXlBBOYgatqLzQN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad91aaa9-9f06-44fb-7d9f-08deaadffa10
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:53:28.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V48hZYx+PP6aRrMSzjNgrqcorT3oSKSN89pDAsRuGVynYbataGbYzFuSGRK/onTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Rspamd-Queue-Id: 24FB44D35A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 5/1/2026 4:39 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, 30 Apr 2026 20:15:52 -0700 Eric Joyner wrote:
>> The number of times that link has gone down at the port level is tracked
>> by the firmware and sent to the driver via regular DMA writes to an
>> instance of struct ionic_port_status in the driver's memory.
>>
>> This statistic was never reported, but it is useful for diagnostics, so
>> add it to the "ethtool -S` stats output, grouped with the other
>> port-level stats that are contained in struct ionic_port_stats.
> 
> We have a standard stat for this:
> 
> struct ethtool_link_ext_stats {
>         /* Custom Linux statistic for PHY level link down events.
>          * In a simpler world it should be equal to netdev->carrier_down_count
>          * unfortunately netdev also counts local reconfigurations which don't
>          * actually take the physical link down, not to mention NC-SI which,
>          * if present, keeps the link up regardless of host state.
>          * This statistic counts when PHY _actually_ went down, or lost link.
>          *
>          * Note that we need u64 for ethtool_stats_init() and comparisons
>          * to ETHTOOL_STAT_NOT_SET, but only u32 is exposed to the user.
>          */
>         u64 link_down_events;
> };
> 
> 
> IOW the definition of this stat is - ignoring asymetric link faults
> this counter should match between link partners.

So, this is a little awkward to talk about -- we are already filling out that
field with a stat that's calculated by the driver; there's a task that monitors
link transitions and increments it.

But, I'm not sure if that method exists because of older firmwares or cards not
tracking the link_down_event count for us. So, I didn't want to just overwrite
this stat with the value from firmware because then we'd lose the count on cards
running firmware that doesn't do that counting for us.

So that's one reason why I put the stat in the generic ethtool stats output, and
gave it the slightly different name "link_down_events_phy" to distinguish it
(this also matches Mellanox's name for consistency) from this stat in the struct
you posted. Though reading the doc comment you posted, this new stat really does
belong there.

- Eric

