Return-Path: <netdev+bounces-217634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9CB395D2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655891758BC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66E2D661E;
	Thu, 28 Aug 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGwAKvhG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7825634;
	Thu, 28 Aug 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367099; cv=fail; b=IPkU6DtKOt5fSIW3MUSSdAx7Af7thfFzYKjAQzkR1+wicKMd+2ySruFyNOJf1zcaFUCv6szgXQFNIpqLK6f0IWhHlUY4ugw18iayUidbDBHcMspuGnwSavfR9126klrtZyHq4ooZIxUcSDJVaOm/Kld8RFD8pv5Q4eFQItV9uNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367099; c=relaxed/simple;
	bh=JQVolkVV0u5JBJkAiweW4HEdbF28wFmIfQ1TMcsKTNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GvNHrovrZArJSiWtcjQUlnBjEaUUwFOZLl8M4OV46se6cgmDRrIvaX3VPeDj44E+iL2AD/zcJi55RxGGLR5WFQQJh67mp3bl22e4+y1JOycubZ3XLcKqTerzU5fDonvx1ReO265g9rmNpqHba6PBryZDImjbkQ1//PVKGkY7auM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGwAKvhG; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTFuxXzgDJwonMOMiJXqfdDYEfjeMh/FvNKAyds2XfBE19XieKkg+5cCqghhjazJK3M2AZAY2G+O2eYaRR687hRdhjK6nGEDgV0I71evUkCxUxFlTu0podYIrwL+YFw3ev/SDlECiwD2lRpyODB+OezeTDHzar1HbHAPN8fV74chkM5lnXTryAIkudv5+V2RtQtBwUV5rVTTWLx5D6qmbWy5SoEZK2BNF+dQ1u29er+gizkd8g5X680lyNpGhyamJX8AOkTu19djhDJAhJc1bgvJW2eAJiI80vyn1MdDoNwG5yxB37/7iiAbIW4FEQcRGwr88Ew7t4InihfZdFnSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM0h8aNJYD3OimocuELVatsIV67hnuIXlIdctVTMPEI=;
 b=kSBfEaZJOEfyvCY91xHjnQuCKepdcxc0DxCmegAL/PI+i3mmnVPxpX7PkF8XozaX+2ibjVI/AdtYvVkFtpQxLmaCZBMRRGisYdSmjLcr61vizYWsVVa7CAqGmLPcHM56SWmLrQUaE7u5KL9tBlXwbuC+x5f+dd4GH+JCgJmJOrwJH3ex6qvpaoQUboR4Mzu+TOWudKqJ2mr0fOmbo7/sGRADP8hJMqj1VM6XR7wj+mEx/Cm/9nyEuhz4a3MEg67hk+SB6g5fPJsfd1O744IamwWIPrg9mfo/gmaYxDd+nsP/Hv8O3mq2gNOPxMM02T8bVjh2dtaoIgsHNynJimzsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM0h8aNJYD3OimocuELVatsIV67hnuIXlIdctVTMPEI=;
 b=cGwAKvhG25qD9yxyxywT9tcEMDkYMkyM5szx7OYoIDIFuH4XiV0CrV28yWwHIH23s7+hDr216S4qIZ/t/N/OzjjOWIJuE7ou3OpdbdlAD2tDzoeMb7b7fRhXeUX9NOkJB843evM0DWuJhXq95Izb18/Z2JRIi5kkKvuDEv1wUzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 07:44:53 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 07:44:53 +0000
Message-ID: <9a9e7815-4af9-4e47-8137-ffe9602da06e@amd.com>
Date: Thu, 28 Aug 2025 13:14:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] amd-xgbe: Add PPS periodic output support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250822103831.2044533-1-Raju.Rangoju@amd.com>
 <20250825170429.0f08fa1e@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250825170429.0f08fa1e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b557e09-ef58-4a8c-ae79-08dde606c65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjV5WGtYV0hFSEt6OVM0bEhURzBxQXFwNzRoeUhCa29MTzVTQ0VDK0FjSVF6?=
 =?utf-8?B?SlFWVEFKY3dKUno5ZDI1V3UzRVhyQTZiR0hwY3ZNQXU3eldvcmJYOGZRUU8r?=
 =?utf-8?B?b3JtZEdTTlN5bjZoNE5BRE52QkpzdmRSTVdJUnUrTG41aDVJb1JiQlROYVE5?=
 =?utf-8?B?RXNoM2pFRVFKenBxbjZQeWtNYkl3RXFJUmFkZG0vOG8zRm8rem9YMzI3OGkv?=
 =?utf-8?B?VW94NXdleG1DSHRXeEtXNlRiTDBENld5T0s5UFJpbTYvZFBrbi9NVmsyS1hY?=
 =?utf-8?B?RVVWVzNBdG1zY2hIVnY1SUlOU2NucDRoVVpoVEc0WDlsQlZKVWFUV29odlhw?=
 =?utf-8?B?VUpRaVhidHdUSERvRWhTMnNNNU4zbFZ2OFJWbEtpS3FBRHFIQ3pVWGN4ZXJu?=
 =?utf-8?B?emhWZTJxMndzaE9xdHQrNEdOOHJRbUlRVkNpUnFlRWhhUGZSMzRzcHdrYi8z?=
 =?utf-8?B?RlFVNWVocVRGUzVRQXREckxOMTg2cUpoVFR3ajllL2hiSXA3VFlRT09GZk5S?=
 =?utf-8?B?cjdZS1dJN0dPUTR5dStMWVNZdVNCOXU4aFE1N0EvZEorWjlMUTJFWGpTMDhZ?=
 =?utf-8?B?LzJWMWVEd2tGeDg3dkNkTlVMR001QndWcVZMZUd0b2d3YW5zZDJLS0ZEK21F?=
 =?utf-8?B?SVZlakNyZkZZNmZVZkVXK2JTclpZQWxXUnlwcmt5QTg5NW1ob2pURnN1NUYy?=
 =?utf-8?B?aWxydWkwQ29GNURjc0ExQklEOGwzRnJaaEhNSUxIeFJNMGw0RXJuVkV0eVRG?=
 =?utf-8?B?KzF0RjlIdEtHM0g4Z2VrTnNDczdqdVZHSWI4V0JRUDl1ZUdWaEFqci9MUzl4?=
 =?utf-8?B?UW1lYWM5VkVhRHljaC9MWExwWEQyMlZ0MDhtVHlHRk9zZUJ6aFdwd2t1c25i?=
 =?utf-8?B?Nm5jcmNncWF0QW05UGhWQUs4UTVuQVlMMmRNK3BCT3hWbHkvVi9CQ3MvSjFR?=
 =?utf-8?B?WmhrL1JkUUdCc0dmM1AwSC9raHpycW9LaVA4bTRUUlErUXFsUlZEVW92UnFy?=
 =?utf-8?B?RUpjVlQ0RDJENTYzTFhoYWpBT1djNEJFbWJlSS94TllHQkJHSThQNzJkY2tL?=
 =?utf-8?B?cGxVU2tpYW9UdmNzOEx2dmVxT2pXdFB6bWJGMWNXZ1pMMTRxMmFCQ2VLeWxS?=
 =?utf-8?B?SkZ2ZjcrNFZaTGtHOHBkc21YempzTkptbzhkU3ZEdFBHYzZlR0hjbTJRckNv?=
 =?utf-8?B?OW9rMzJNeEQ5Yk5JV3pZUXlOYzlyaGI4UlV4eUorcFg1MzRYSU05M0RHRmNY?=
 =?utf-8?B?VkZNM1FCZHlOSEZ3RHViM1NXV1ZBd3ZyRkl3ellhVDlLemlFdjRPT2o5aDlv?=
 =?utf-8?B?YzRGb09veWZuRGN1bFZVRGluN0VuUkFlbVBmSmxiQmo2M1U1MXppdFQ1VHI3?=
 =?utf-8?B?T3ljai8xVVpuczRYeXNoQ2M4d0hnbkdUVnNveEd5TnY4RlBMYld2ejVueVky?=
 =?utf-8?B?b2EwRTFnUXVuQWdmbUVGYVVkeFVqdVBkMFFVRjBwRjc3eWw3NCtKUVE2YmQz?=
 =?utf-8?B?VUJOem9mT3ZBMUZGemN4TS9xeDFMUG9HaDZDNFlpZWxodzR3aEpKRXhzR2Zw?=
 =?utf-8?B?S1FaMzVQS1hsK3c3RXZRTVVDdlR1T0x1ZlVQdGk2ZGRpTjVqQUJoNWxqTHd6?=
 =?utf-8?B?eFJvZjE0YXNGSnRURnUxQzhna3g0N0R5Uko1QUdaZXp2TWZab1F0Unp4TlJ1?=
 =?utf-8?B?U1FWd1htamFTbVY5bTJRNUFhY2QzbVB3Vkh4eWEzQjZwbWdudisyaks5aHl4?=
 =?utf-8?B?OUY5MXpBTHB2TDdJV2U2aWVwTDl0WFJvandsN3FvaDJ0VDZyMEhTa2x5VzRE?=
 =?utf-8?B?WHFBUkIzcnZBY090cFA0U3dMdExudDlXWWh6ZnZYdVdzY1NGL2JyaGFrVWJ4?=
 =?utf-8?B?cTVqUHlHV2ZOWEdlK3ZtcTVsRTZOOGpGMEJSZmV6ZUVqOUcvUUFiNDFhdExK?=
 =?utf-8?Q?4SXJXBJu7+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdTV3dUYnE5RUtMTDFNcFNLaGxnWk8rUlgzQWlzbm1oMks4cDlQR0ZSL2FD?=
 =?utf-8?B?UFBaVFFBS1dscTJJazZvVmpzdkUwUXNtZGUxcUl4WUdGUm1wSm8wYUxXcmZo?=
 =?utf-8?B?SStSR3hoQ2x0U3ZmenpObDg0MUxVcUJoTjQxMmRuWkUvQndrbDFYVDhkOWtE?=
 =?utf-8?B?Mkt0WHNGTGZBd000elE0RllxcVdJM1JwZVJNTG5Sd3lZRzQ5UDAyY1U5dHZs?=
 =?utf-8?B?eWMxUm50TE9sdm9IT0RBUHdtSGhmekxnM3F6UWhFazJnTG9kb1ZNcnF6Tk1x?=
 =?utf-8?B?U1FkNFVwZ2dFZXlvbnhLYk55cUtYLzE1VFIyM1dvdVR4encvNFM4WmpKaEFu?=
 =?utf-8?B?ZGtJU09XVUU4N0tIaloyRWEvOWN2dmRiRkt0RWJQdDhOVVFBOFNuSzlkdnl2?=
 =?utf-8?B?TWhRRk04QXpsQUxGMEJGR3QvQUpaQWNXa3Q5OVhreURrMW0zYlhHdGRIVThR?=
 =?utf-8?B?UFhCMUtNOXRQMFVnN20ydXJNQWRJWm01MThydEJJY25Bb0Vqd3VJZ2Zadkla?=
 =?utf-8?B?MmtPeFBGYlo0RkU5dkdTQ2F3blFiMU4wRUN6Z1daemV5clNCRWd4OEs3NHNk?=
 =?utf-8?B?VG96QzVMeW1yU3lFUDRWTUV6amxFZG5mc2RINU9ndk5jcHp3T2ZMV0NFcUsv?=
 =?utf-8?B?eVJmK2t6VU5tandUSVZwUjJFSUVLbHg5L2M4a0RuWkxHZDIrNzd5ZG9zQ3pW?=
 =?utf-8?B?SVlVVDRkWWJkM0dzUWdTam81RlVWeitYaFJUSytMQWhNa2Q1dkIrdmhaS1pL?=
 =?utf-8?B?dWJrenRuK1U4bW1OZGVpajdrcXhMb050Q1pzNFB1WnJGbTJpSzNLKzY3cEUz?=
 =?utf-8?B?UzROdnI4OURxWTFhanRRVlNPdDNlenRFNUtMZ1Qva3dqTitPNTNmeHdldU5u?=
 =?utf-8?B?MUp1ZGRLMHd4VGxVY2dZTm9OZEdwZURuOGt6QTIrZkxGRFpFNDhIVHA0OVRa?=
 =?utf-8?B?U2U2V05NYlFVdE9zZjFId3FYdlZOMDFadngxVWFZM3g2bkszOUx5ZzJVdkpu?=
 =?utf-8?B?UFIwYW5OQ283b25ja2NQelJoQm54OXdET0NtV3F0djE4L1hzd0dQcDMwOFl2?=
 =?utf-8?B?cTdzTFpTS0FjNWpTVTRPTTIyY1d0YXFPMzRKZlY5Wit0SiticVNBa2dHQ3Yy?=
 =?utf-8?B?STYyd29UMGpFb2FOVC8vZWZtZXZGNVl5eTRqekFFeXpXd3dxYUxsY05RT1JF?=
 =?utf-8?B?YlRNWXZjU2xLVGRsY3JmMGY4Q0ZwalVSSlJNSzBreW8yT3hIbnRETGtNc3Mx?=
 =?utf-8?B?UnZkd29TcitLVHhiV0NJNEFkaGF2ZGNRYTJkUTNvZW9wMnErSzc2eXlSRHd0?=
 =?utf-8?B?ai90MjVIcVZMcUlCUkE2YXBpTXh0WEUxa0hwY1dGbTVYREt6N214Q3djZFVU?=
 =?utf-8?B?Z2ZzUW02K0NaZjBYVTd2ejlNVTByMzNZWm5xcHhZS0wrUjZZSUZEWU5Eblg5?=
 =?utf-8?B?RkNpWlVTalY1cVBYU2owdU5PT3lWL2JDV2NJVDc0QnMzS000TDFEeTd6R3NL?=
 =?utf-8?B?NmVGdTVMWXhxNDZ2bnlWNzNZTERZbVdWT1dUN1B0NnhZRXNvREpLbDdRaTRP?=
 =?utf-8?B?TWh4SFR6OGpsbnZkUElCZjNnamtIdkdrZ294eTRPNTA5L2lGbmFrM2UzWWJT?=
 =?utf-8?B?RU52M2ZUTmp0QTFlNTkvMjBqTjlYc2lFQzkwbExQaHAweWdCSTZSenp1Z0N0?=
 =?utf-8?B?d2owTlg2RzlRTWJZdVNKbW5CTTIrZ1dBalpCWXJOTlJReUw4WU84UHF1MU1q?=
 =?utf-8?B?MlhaWm0vWWw2QUM1S2oyRzZHWWJkWTMxaW1HMDgwVVFqNlA0b0ZJZmxKcmY1?=
 =?utf-8?B?T3hYSUxCQXU5cVlxR1lZTWpoQkU0ZmZzYURnU0V0aW1CU25kZWVlaGVkODNs?=
 =?utf-8?B?bzhkNVA1R3A4blJoWUVmd0pIbERxU2dEellZN1hGQ1kwaDFjeFNSQVB6ZUpq?=
 =?utf-8?B?QkMzSVd2TzlPSTRaa2JaVUQrUU1vVXowN2ZRbnVDNENBS3J6ZWhmOXlIZzlt?=
 =?utf-8?B?WkJ2RDQ4d0ZndjR2NmF2VkdxUDRLV0lCbGN0NmRMQmZSMldwQ2lDM3Z1eXVt?=
 =?utf-8?B?ZmFoaGRoVnZGcWZjQ2JsOTViZW9wMTBnVVdmc0hzWXBmWUpBUkVUaU43ZVJJ?=
 =?utf-8?Q?Pj0oVpiuVCLSZtBdiDvnPgNLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b557e09-ef58-4a8c-ae79-08dde606c65b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:44:53.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VakGqkGdW9yZ6w+3qRv6UA+dNaVMp82RJ/dy7TqN9xTTQIO5szM/EkIvTWSqpWQyrlORRuzNkt/uBv+CqUBx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715



On 8/26/2025 5:34 AM, Jakub Kicinski wrote:
> On Fri, 22 Aug 2025 16:08:31 +0530 Raju Rangoju wrote:
>> +#define PPSx_MASK(x) ({						\
>> +	unsigned int __x = (x);					\
>> +	GENMASK(PPS_MAXIDX(__x), PPS_MINIDX(__x));		\
>> +})
>> +#define PPSCMDx(x, val) ({					\
>> +	unsigned int __x = (x);					\
>> +	GENMASK(PPS_MINIDX(__x) + 3, PPS_MINIDX(__x)) &		\
>> +	((val) << PPS_MINIDX(__x));				\
>> +})
>> +#define TRGTMODSELx(x, val) ({					\
>> +	unsigned int __x = (x);					\
>> +	GENMASK(PPS_MAXIDX(__x) - 1, PPS_MAXIDX(__x) - 2) &	\
>> +	((val) << (PPS_MAXIDX(__x) - 2));			\
>> +})
> 
> These macros are way too gnarly, please simplify them.
> For a start I'm not sure why you're making your life harder and try
> to have a shifted mask. Instead of masking the value before shifting.

Sure, will simplify them v3.

> 
>>   static int xgbe_enable(struct ptp_clock_info *info,
>>   		       struct ptp_clock_request *request, int on)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct xgbe_prv_data *pdata = container_of(info, struct xgbe_prv_data,
>> +						   ptp_clock_info);
>> +	struct xgbe_pps_config *pps_cfg;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	dev_dbg(pdata->dev, "rq->type %d on %d\n", request->type, on);
>> +
>> +	if (request->type != PTP_CLK_REQ_PEROUT)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* Reject requests with unsupported flags */
>> +	if (request->perout.flags)
>> +		return -EOPNOTSUPP;
> 
> Are you sure kernel can actually send you any flags here?
> ops->supported_perout_flags exists

Yes, it looks like ops->supported_perout_flags is already taking care of 
this. Thanks, I'll drop the above check.

> 
>> +	/* Validate index against our limit */
>> +	if (request->perout.index >= XGBE_MAX_PPS_OUT)
>> +		return -EINVAL;
> 
> Are you sure kernel can send you an index higher than what driver
> registered as supported?

looks like kernel is already handling it and this extra check isn't 
needed anymore. I'll drop it. Thanks Jakub.


