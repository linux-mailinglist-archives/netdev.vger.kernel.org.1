Return-Path: <netdev+bounces-201408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82AAE956B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235E31C22427
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5321FF44;
	Thu, 26 Jun 2025 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="DFDR/7/a"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022115.outbound.protection.outlook.com [52.101.126.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294521922FB;
	Thu, 26 Jun 2025 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917264; cv=fail; b=goCsICBehRuTuzy/3b2e+kpiv2LkdmkCIZ8x7ByVVPqU2LSVywxPJqymgM+r4YhNy3y6oUZDeirHL4d3CWGPNEkVWuofRYC4RSTjNaj+qYRwhF8FPLpfIwwVcO6O+23Y65uu4Swz1mBliKcgob9Z5J/1IP2wcu6GvLGWbAFoYK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917264; c=relaxed/simple;
	bh=MswKia+H+xLtWHcnD6B0zw1Vt4oSFbkwenJHlik687c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ElXv5zsLd/WhB1B9N7vkRy1lHDo40NP2dWAm744jrljR7vIp9B0sz5bp8SBG/wBEOxhc7hJvp/jIl4K9tIk6RkzllE3wTRLrNHBiTr+2Do8y8Mh8sZEdgwkxABbYjfRHX2npH5ZkoMe8khyr0WgMJyUsAf3gRhHv8/oBFKbt2qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=DFDR/7/a; arc=fail smtp.client-ip=52.101.126.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KglrdJNPc3AY7rKtbeDMzf7zXFPQJB2qjsbR5PUx9n8TIaoXw0SRgu02V2iIKjHwtX+w6GcyYYj/DPijZzBBkfKUCw9tcZEmo0m5Wx/K1+d7qjn9yeg7ufP81zFzew8zGAhsZmszgRusnPRmDLW9fCxKfR2BWSwL28mgXyUG5UxDmAMtbcEQC/G144Usx74U7llimjlpanaqyNLBhqTikDXu3NmDpiIybhVFwowQJgO+E5LOCK2IzJeEAUWL6E4FWtGNckbMGokv3GO7jpjzzt8Z3ndg6IqoKYr+lj/7Bm5852zGVafYr1Y3+xR+O8dbDbY6S9lcB1vpzXwveX4Z3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiSi62jw2/RJ8vh4/SXtvMj2MadV0ZiHulqD/26NFA0=;
 b=HMr5Vp+480m64SdnajMs+HvBaoj1zKMVB/bqJ6wrBWZeWQO080XX6DwaNQ2skmPqRv/6G80lPO20xFD+rUZ2KziR5RyKgkOB4GrXth8q57VudwAO1OPWhEdvrylX5eMpvrZCkWxk3MdE4wicxfPplVWlo7Siva0SXpPtn8pHxT6gq4mRGfBAQBx/HJIcqHkdYmchwuzbddXX5SiqnOit/Tvbjb3YSrOKXgkiR0UA5dQnmCNZdigrnpkT+zhP2yzUTt7/cIdYG4n4qzmQEFd5wnr+34nX+gxgZZEni2DkXrA2UwJKaVt3+iK/lebBrh7D3fZPC+pk51keiz+B4rp64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiSi62jw2/RJ8vh4/SXtvMj2MadV0ZiHulqD/26NFA0=;
 b=DFDR/7/ayczDy833QfcXL84zq6E/LOrxZt/Yw/Ts+2dAV43t5GNTieFAzafGX5zf/ZFnluCZy2npgfGdW6aFAHJePX2XQ8qkfaN9iXUFxqTFWXVYbAeOGiL1WAmE1qHuMpcA7i2ETacnP0qWx0cO5pISbJ0Oeyodq8XOVDWM/dyJJV9Uw1VxwdGgsNUXq1BzKKKudAFA/FSEEWvjwrzG1LtNZtxqjCPAYwCHSFAOhRz8R5h8tL2OYsRS/Z4IBi9Lmc0+RQbVwtmHjN85TtLJJfTxIXUWXgOAS4+OA89k7EezOBg7iqXh+q+MloQQ4mEElpdZLSK4ex7BqhLWXEH4hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB7880.apcprd03.prod.outlook.com (2603:1096:990:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 05:54:16 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 05:54:15 +0000
Message-ID: <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
Date: Thu, 26 Jun 2025 13:53:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 69323f84-2d13-437f-05a6-08ddb475e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzFtdkVtNmVKT2NrRjc5d2o2QTNHNEtHVTBlU0ZGam5pQ0RPTGd0cGN4ZWFq?=
 =?utf-8?B?VVJiSUhIZ0IvdGtoQ2pabjJtYVZOUWw1VGtsUHVPMUg4clRvd0Vid3ZqRC94?=
 =?utf-8?B?eVFrcExVRWU1eTFRY1dFZFJ3b3EvZW5yV3loNFhvcXBvMXJFSHJtREw4d21W?=
 =?utf-8?B?alJGU3dDRk5jbkhtS1Q3VUFWR2dFbGJ5SUhOMWV6V2JOZFNOT3VicmJwSGVt?=
 =?utf-8?B?a3UzYXl2Qmw2dDVKdEFvTXBnRkxoK2dOaWZIUFZJZWFoOUluVms3Mmx5ekdU?=
 =?utf-8?B?Y0F6Qi9ESnZRUk9ha3pXMmt3VGYzdUZwZTZEUGlWTmxVOWFjWGRxb3JCU3ZP?=
 =?utf-8?B?N1NBL3JkazVKbU02djBpejdXcU5UOVZRdCt0NzdPbWZaWEkzN3ZFYTdTdFNX?=
 =?utf-8?B?Y0U1NWIzN3dpWEhhK2lzL2hzMmxoQ3NUaGVyUjBadENiR0FtUjg5VTl0Qy9j?=
 =?utf-8?B?UTR2dHBteGhITDJTdS9qN3lBWU1vanhZZE9NVTBReVBmazcwODU4bERUVDZ2?=
 =?utf-8?B?QWZoZmRDamc5eGxqb2NFS2JMQ1N5TlVTV3hudi9WZmNobmJoRW93Wjd5cXNM?=
 =?utf-8?B?UW4zUTlsN2htMTRETzhMN0lUWEh4UndGaDJ4Smt1bkx1S054aU94MnV3Vzg2?=
 =?utf-8?B?eStWRUJGbmhROWE5cXRlZjhQU3B1Z2Zjc3pUTythb3A3SmNmQkx6N2ZOUWhB?=
 =?utf-8?B?YnArM0Q3U0dDTkZpY1FTMjRvYlVCS3JBQUV6bWRWdStrVWUyTHU2QjFTbDRO?=
 =?utf-8?B?ZlIxZmw1elk3ZlpMc3dYQXVaRHA2Wkd4UGxPbUxEenJqa1pnU3Q0d21WNDZm?=
 =?utf-8?B?SkI1anlSVW5sc0phd05yUzJRb3VOSTN2YUtLbWZLNnNwVW1DRkw0UUhIODNh?=
 =?utf-8?B?N1U5R2xaOU00Q3BOVkhRZk84dWpOQmFKTkE1eU10Zld4RkJMUUY3dHlJOTNm?=
 =?utf-8?B?NFpQcTE2YStlSk9mbHlBWURFU0RCVmEvVzdQQ1hXZ3BkOWhDMnJxZTZ2V2lq?=
 =?utf-8?B?b21ad1lmTGhBd1Vqd2dPV1ZqeEVjTEdXbXJKVWVKeHdRY2MvRk9VTlQzRy9w?=
 =?utf-8?B?b3UyNVdGMWwrdmxuNEpmelZ0T3BmK0RiRFRncjFnSzR5bSs4bElLWTNLbzd3?=
 =?utf-8?B?T2tJeXFtbmhoZUdVdEZUNXQxa09tTFNscHo5YVJBM1JwbFhiKzhCZkh1R0Yr?=
 =?utf-8?B?NW5PeDZBV3lobzByY2h0SkRwOExxT3dnd0l0OVlDbG5pSWlvTkc5OG5BbHBO?=
 =?utf-8?B?NFpzenlHYTVuaURVdFIzS1B3TDlJRXBMVWFGRmozdkE1eDJ4U1VJcWF2Mml3?=
 =?utf-8?B?MktJQSt1VWpQRitzRVpNOGUrWE1pRnlKdG5qS2YrNDZLTU1jdzRvd3RoVXYw?=
 =?utf-8?B?RU1Ydi9aNHFLNUlFaWc4S1J0QVI4UzZHbW9qOWdFRFlBZkRjSzlkMVh0cXdL?=
 =?utf-8?B?TGRzeUFwUE1Fblp5RWNaVGN0TXFsa0NIWCs2aDVUbDI5ZHkrY1lyQXg5WXVV?=
 =?utf-8?B?Tm1GOHoydWNmNVorUjI0dW9MaG4rZVJGQmg1MGtibTVoUHBtbWdwUnp2MDlI?=
 =?utf-8?B?NWlWUVBEVGUraXhpOXYzRGd6SzF1alVkeHIwUnRUZEM0Qzl3TkRkRjZLTmZp?=
 =?utf-8?B?bmtpc3lBdVVrbjZLWWgzQ0pQR09wQS94K0Z5bkErcWdtU2hhdDBBbGc3eTl5?=
 =?utf-8?B?UnNTY3JFWThyUUNaZ2pKRGFjb09mWTNaNmIyNzZpVFVJK0ViTE1Zc3hSL1hr?=
 =?utf-8?B?K2ZXNTk1ZEUrRUE5b2t4eklyN1JSZjM0NFEvZkpLZERMalpSdUkxK2d2M2Fi?=
 =?utf-8?B?QzJWbE5DYVFJU1Z6L28vZ3JzOWFsbHp6RWQ4RVN1bGkyR3JiUEVMR2sxRmxW?=
 =?utf-8?B?Vlo1dTBCWVA5cXl0WGZYVzBGOHo3QmhmcC96VnRSRlQvUVBiTWd6MHhDa0hR?=
 =?utf-8?Q?tNnYaSBY9tM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGo5dTNtNHRqQXZHSENoQzMxZ3Y1UEZUYjNnNW1TU0tXTE4zMzJtcjluMmda?=
 =?utf-8?B?dUtKMHlneEx4VXlpOFBnbnBmdkthYnNEL3o5M1o4TWJkc3ljc3VnQjVUbUVI?=
 =?utf-8?B?cWNxL2phRERTa3BYaWZMWFJxeDh5ZGhHRlc0Y2l3T0F0TUFLcDcwSkVSMENy?=
 =?utf-8?B?bjVYSDBjdk81aGlBZUljTzZBUy90TGJxUmxmcmhkNU0zUXpZV0hJSFA2Vmhv?=
 =?utf-8?B?ZFhEaWVGQTZIWXRZRTJpN1FKaldLRFRscnBOcUl6ZUdqZ3Y1WDVwVnhDSmYw?=
 =?utf-8?B?bkFBM1RBY2hSaDdORlVEMzM2SkFoUmMvbVYrZ1BIV3FodjdHa3lSb0pHb1NU?=
 =?utf-8?B?dHBhcXVIQktRNU10eHlNaUtaRDIwbzl1WWI0SjZSUXNVNTRHVHpDVERLbkhu?=
 =?utf-8?B?WnRnbnluR2x5UTBZYXdaQ2pLTE4zcFVqUGdDaGV5azF0dlZ6TlRxdTd1RWJx?=
 =?utf-8?B?eTZpNmMvOGJZSmFhZGdBMzZDZzFYNU1zNzVRZG4zd0JOVElXNS8zRlRBWHlT?=
 =?utf-8?B?MFVJbGdOSEJOc1hYbnptbnFVOURxWEhVSzNpSGs4WWtDamlTUTYrTWUzOGVR?=
 =?utf-8?B?L1p6RGJvNys2c2VHV3RNanRKa0pudWtsbmtjOE5LeDU5K1FyVE9UdkFJRFR1?=
 =?utf-8?B?S0s4dVF0ZXIzZXZrNW9EczNKSWMzSG4zNkF6UTQ3SHFMQmIvMy8wVmIwQzRs?=
 =?utf-8?B?U2pWSDhocytqNjFMU3c3RWNpeCt4V3VRN2tpOTdYeFB2V1o1Z01CWEFuWDNt?=
 =?utf-8?B?cEdheHQxTG10d0FPaUNtcE9GUEdQYXdlUmp2Q2FBTkNydDE3dEhzbXc0SzBi?=
 =?utf-8?B?bjQ3alAzUHliYmFFS2RNVTh1NHkyVGxYVldRU0l2dmRiSysrUmhTRi96QUdr?=
 =?utf-8?B?QWR3ZTJ1QS8vRXg0YStwb3hsZEJFRmV1dTE0S0RycStYZy9NTDVkRUxDakpZ?=
 =?utf-8?B?akZPVDlSMlNkSEg5djVxbUpvNC9USU81RGthc3JWTjJicjhTNWVRNG5rQ2pL?=
 =?utf-8?B?S25taXFOZGFGamNzd29NbS90ZWhiNFZkMDl4MzJLRG4zOHBpM2crVVpkOGx4?=
 =?utf-8?B?K0JZb0czamwvUG9TRXVsbjk5dGV2czJQZWUwbzdRNnBzM1oxL1RWUmYvRlNm?=
 =?utf-8?B?cTYyZnJEcUZKaEtmVnV3dFgyaDRzcHlBeUFLeS9ZWU5Kek5QaFd4Zzh3b3BM?=
 =?utf-8?B?UkFCYWkyUXl1Zm9pV2E3SCtaM2E5SFcvS3V1YmVjWC9GdUNKWVcvZ1gyYkh2?=
 =?utf-8?B?WVpBaXJ4bnl2eWU0WnFKV1JneXJ4RVNmTW5kOFJiVkpqTHBzcjR3Mis5MDdy?=
 =?utf-8?B?NS93YWxJYzNNU3drZWdqOXE5dFRhZjlDUytRcmlvNklzRnVNTHRTUkhDWDl5?=
 =?utf-8?B?eDQyYWdnczNoODVhNW14Q1Nyd1BrR2ZSb0Y3NXA3Zzk0YXo2aVExTytobnJo?=
 =?utf-8?B?cjJkL25mc2NEampCT2thaWRLVGVVRFA3TW1wSzMvRlZNRDlkZTFTckdFVGxD?=
 =?utf-8?B?bVJyMXRSL1ZzOXJkL0lPektISFJlVnRuQjZBSUYycG00RmIwZlF0bEhIRTU4?=
 =?utf-8?B?NE9LRWYrVUNZMVM5UFlSTWQrNzdUQ3Q3ZkZaL3BYTVVHY0ExbGpsUi9zZkJv?=
 =?utf-8?B?YUF2Q0tpcXhhbjl6bjNSamJaVFh3RjFRQVhwUnBxbHdFNHVJNDNRa0dWUnhi?=
 =?utf-8?B?Y0dybjhVOGxKQzZrN3ZBUHlRMHZRcjY3YS9MQk1EMHI0Y0hCc3oySjg0cWRO?=
 =?utf-8?B?cEJ4N1UweG5lZlhqbks5T2JXZU5xQk5tekYzSXg3VmVBcERLOG1nZmtoRmNs?=
 =?utf-8?B?YTBuaXIvS012NU9Ud040ZG9RNFFQVFZoTmlSbmpUekV0TEVDOVhCMm0vbUxn?=
 =?utf-8?B?WHVlM3NlNE1GVXFxaFYzSHloeENOc1lweEp2WXpKazMwUUNkbjJ4cXVGdmtO?=
 =?utf-8?B?OCtrNExPRU9PcGVBbDE5THBpajc4anovZDg2VW02YlNkR3dXMEJFamtTL3My?=
 =?utf-8?B?a3BmcGRGWTlJVy9zVmRWdnR6OFR2UDFjVnBNV0p3OGJnODVUQ0VvVzZzZjhj?=
 =?utf-8?B?b2JpV3l3ampUNFJHNGtOOE5NaXM2Y2xKR3laZ2xVNnBEZmZiWndIcFBZcCs5?=
 =?utf-8?Q?ic6m+DzaHzanV3BwBonhlttlN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69323f84-2d13-437f-05a6-08ddb475e217
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:54:15.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQO/hBfE2wxnRi8jL5VXlbrpstbVL53+6ST39rMjvN6KaM9hNBViZzsGwohVmoFSUsExnmV6xAlu2MPWiDb6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7880

Hi Pauli,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>> event (subevent 0x1E). Currently, this event is not handled, causing
>> the BIS stream to remain active in BlueZ and preventing recovery.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v2:
>> - Matching the BIG handle is required when looking up a BIG connection.
>> - Use ev->reason to determine the cause of disconnection.
>> - Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
>> - Delete the big connection
>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
>> ---
>>   include/net/bluetooth/hci.h |  6 ++++++
>>   net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 82cbd54443ac..48389a64accb 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>        __le16  bis[];
>>   } __packed;
>>
>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>> +struct hci_evt_le_big_sync_lost {
>> +     __u8    handle;
>> +     __u8    reason;
>> +} __packed;
>> +
>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
>>   struct hci_evt_le_big_info_adv_report {
>>        __le16  sync_handle;
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 66052d6aaa1d..d0b9c8dca891 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>        hci_dev_unlock(hdev);
>>   }
>>
>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>> +                                         struct sk_buff *skb)
>> +{
>> +     struct hci_evt_le_big_sync_lost *ev = data;
>> +     struct hci_conn *bis, *conn;
>> +
>> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
> This should check bis->type == BIS_LINK too.
Will do.
>
>> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &&
>> +                 (bis->iso_qos.bcast.big == ev->handle)) {
>> +                     hci_disconn_cfm(bis, ev->reason);
>> +                     hci_conn_del(bis);
>> +
>> +                     /* Delete the big connection */
>> +                     conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
>> +                     if (conn)
>> +                             hci_conn_del(conn);
> Problems:
>
> - use after free
>
> - hci_conn_del() cannot be used inside list_for_each_entry()
>    of the connection list
>
> - also list_for_each_entry_safe() allows deleting only the iteration
>    cursor, so some restructuring above is needed

Following your suggestion, I updated the hci_le_big_sync_lost_evt function.

+static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
+                                           struct sk_buff *skb)
+{
+       struct hci_evt_le_big_sync_lost *ev = data;
+       struct hci_conn *bis, *conn, *n;
+
+       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
+
+       hci_dev_lock(hdev);
+
+       /* Delete the pa sync connection */
+       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
+       if (bis) {
+               conn = hci_conn_hash_lookup_pa_sync_handle(hdev, 
bis->sync_handle);
+               if (conn)
+                       hci_conn_del(conn);
+       }
+
+       /* Delete each bis connection */
+       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
+               if (bis->type == BIS_LINK &&
+                   bis->iso_qos.bcast.big == ev->handle &&
+                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
+                       hci_disconn_cfm(bis, ev->reason);
+                       hci_conn_del(bis);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}

>
>> +             }
>> +     }
>> +
>> +     hci_dev_unlock(hdev);
>> +}
>> +
>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>                                           struct sk_buff *skb)
>>   {
>> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
>>                     hci_le_big_sync_established_evt,
>>                     sizeof(struct hci_evt_le_big_sync_estabilished),
>>                     HCI_MAX_EVENT_SIZE),
>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>> +                  hci_le_big_sync_lost_evt,
>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>> +                  HCI_MAX_EVENT_SIZE),
>>        /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>        HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>                     hci_le_big_info_adv_report_evt,
>>
>> ---
>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>>
>> Best regards,
> --
> Pauli Virtanen

