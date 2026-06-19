Return-Path: <netdev+bounces-300568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wPMPA0WYNGpjcQYAu9opvQ
	(envelope-from <netdev+bounces-300568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:15:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA096A385C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=gonSWi1o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300568-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84093011F18
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513283115A5;
	Fri, 19 Jun 2026 01:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5A2772D;
	Fri, 19 Jun 2026 01:15:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831743; cv=fail; b=WtnZmKADurRAi5GW1zJM13JANbC5ZwwRjMI8e3i1mpgUm4Vp7y7ME189B8U1y8FXwfeYqWeJm75Xc3xuPnhJFeQw5p32ANqh2RjM1NfK1d66zLM8hKgA504s0C/8Sll/q4sDU0WgZ0484NexB0B5npuAj08vxlMR6JUy2hfgivU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831743; c=relaxed/simple;
	bh=bsxPmK+m0Lcw2pAMAkPt/UOozKlDA41HkTg3YcziHRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kE/HuNLD4KVWajr4+Y/yHnw2vs/U+8KyK3l5wZRvlpe6mKx96wtwvzH8RICkACwlAoOCs7wJtJCyyf6neuQE/ARg0K9bepvcft+gm+AKx8od+hRA6zhXJi3wGgWk5KAlrJbzKb1D5JdALSwRvU9Scyiue1mHZs+Q75gkfHIO9HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gonSWi1o; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J1D63v1307789;
	Fri, 19 Jun 2026 01:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4GT2XPMjdYss8cmUidJIRhEKO0Y04ZsHDujoVMIwCSk=; b=
	gonSWi1obPgNrW7CjCdqiJONtYZ/zoyiuY0qnA6nb6hgJB2YsEy2kMY2LiyIk56u
	9sXHr6UW8mtoxY1owZ21SOujauB9lHlavAQ4Ciya6pY7iAHtoxLU5wPYNHQSms08
	cT3jmqqJWA1m5q5aU7fSCnFvk0n1qXVpXrcCScVeunG2j1PNzYGInYMRvWFQ4Wjh
	A4UO9bvKFjp94hO6Z6kMq9f9j4IEQXaPPUMjWK3iQYFuo+2qlLJZaSoYFfaSXWzw
	TcMGQsJ9QsWOGKgcNvvwCD9F+DskJaBYNu4rRSqDNcRrS1aQfK2wneztEchTAXdU
	Zla/7ZG3mwF5DR1mtA3ebg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc3mhq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 01:15:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpE6BWn49TAOStWz3iGfYZAtZSoYXrd/g2e8eDB7uv5RvxfRCRfwGD24wfkKhBub95D4fg67zcf1Xs9gkqhkW1sKGTEoITfCpw6kY0EPZdNwlN5C3gDTYiqWNLxBb4VbwRfrDbhLiV5o4cJlJZX91J1jUxHR0FfqiBrwiVm9OOyyRQWxQi/2jBU8M1Fys74wjZHxRCLT/VO74e43inFZ5dMFqx6dUKEHYInwlzCdB9FadLRFFS7AjlNmJKDykTM/nNnid4z4PWgsgeq2CcJXwZ/BE0W00arfStJxQ/exDvmyKglIAUUfCIwsgSc+UVeL6jEbIPdfeE73q9BkRv5ETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GT2XPMjdYss8cmUidJIRhEKO0Y04ZsHDujoVMIwCSk=;
 b=kr5Q4iZQbSbJJ3oSz7my6mdB1RAsTGGBa3UR1P84HmxGEFnPolcyhChLydTyQSlMEvsbjkSJpl5LjCXjmwXES6kdCMs4rhLiNOgqd/HJxKMKegJkGVfNCL078l0+I93004K0ai5Iz3kIeaT9F99ruoD/Ztlan+UTZZteOCPITvX6gsPZoQE5k5AlpbXb/TpTpaqT5Uo3LcLiVTtIdIKjGhsT82VdjQ9nipI+tsRSAb97L8kdDnZaJ5kc4MqDSAueaa7l/757IuwuljCUjo/aTuvYc9QrSH0gI4V+iD0IQVQ6LGSVcO5lRxLNqGwpTVNz7aVcjNQdutc+UYKgCAW20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 01:15:14 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 01:15:14 +0000
Message-ID: <52e2dc9b-45ce-4779-8ca3-b4e022380db6@windriver.com>
Date: Fri, 19 Jun 2026 09:15:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
 <20260618150440.cLDwgyDM@linutronix.de>
 <3a4ba3da-47ee-4da7-b0da-af500ff1a369@windriver.com>
 <20260618155337._cxJpvd0@linutronix.de>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260618155337._cxJpvd0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6P301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::9) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7dfc44-d80a-41bf-9080-08decda03760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4aPdTfzfrCo4F3tzez6T3Rg1FNNRizegoWTX8AFdD0RMkgyEtgj+Ak2lRN/17NMb+9XCrKQ17LdI/cSL3HnDF8iJgi1tsxsdU/e1dwb47nPlzDTdvTcuO4kdbXdgIffjdxSj8mJfjK9KQ+/oJZafJh6k8+tsENyeNWEtjUm/yVp68Nb9XuwSenb3rGGKqeqakEhOPGobPMp7Hs+IOqWHGnY6Y1C+D/i56leZFm/++08o65aS0LctLPJWZYqNTb+0rjU0OpcRgqUFdTdiY1h5j21C8jFyAEkP4Z5a/v6W0zw3ts3hkcsfRYop6t007IoibqaJBTLqo6YyhukFHrwLDH0QW0Luv4JlBXcvJNsL7HJRNSZL6uTzXknWmKr13J8OkAcgFtLNR5N12laPfeoqV3ApNy4z/0e9vKlSkIfrBtn1tXrUfR0Ho23pwJ/gnKWLxPIrLV/IkXbNuIdTnwqpiQ80CsMMtTNTqDab7yaMLdHdp0axcPvtooT2lYOsUk53OLN4KKriRI/4yd0W0X5iRXg1PJkwH9XPMd5vie5CrXgZH4lkZXjbBYK6wr4LGMo1EB4C3sPz4nD7t+0ZqMMCWtJmTcC/dhH5BySqNLekREMKBVjK/aGrt+NySthuj9stOJeP2jtLlMMxqjKL95/LpmD6kELH5d7sQe4uULbAdjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXh4R01uS2dTNVBxL3ExelJTcG5leHFoTkJhN3FhNUY4QllCVTZsSWwzby9F?=
 =?utf-8?B?RjduM3d1N3IzZFpmQStGZk1tUVhvYUxPYS8ySUlNVHAvUUxjVVYxTGllOGJy?=
 =?utf-8?B?ckVvRnVaalB6VTlnSHViYlI5T3ZvRVowMURNcWZiVU0xWHFPWHZjZGRCZm81?=
 =?utf-8?B?WTNDSnE2bWt4eUlBTzBsa2JPK3c4N0dpWVhxS2E1SjY4S0FXd3hIdkt3YkNn?=
 =?utf-8?B?ZHRZY1NUMEN5ZHIrWVpUWGlxcmliQW5paFczbWxqRTBzalVzSEViMzlFKzk1?=
 =?utf-8?B?YjRhT21pbFRvRWhZUXhtbVViL3o1SVd0d0hCY3NwbGl6R2k4TVJJa0NvMEVZ?=
 =?utf-8?B?M1BuWWY2amlncHB0UEMyeklGRng5eTE1QzFkVUpqS2RxWDJQVzc1YXFOUlEv?=
 =?utf-8?B?Zm0zNnp1VFhrMEMwSTZxT2pEMCtmQy9KVDF5bTNaUkNaVkJpaURpWnltNHo1?=
 =?utf-8?B?d2dUeE9kRThjQnlOL09uQUxLaXFrSWdqNWJ0Z0VLUkZaSERiSmpGbDEyQWpl?=
 =?utf-8?B?b3RqdlYxOWgvL3lzaUFvN0lBSVpsNHhraWlKSzNzd2F3eVIvZlRVMEM1TVUr?=
 =?utf-8?B?cVhDSVErWmVDdUltbmJubDl6a1BIaTR4aTdtdEY1Y0FhejM1NE1uRlRNMFdL?=
 =?utf-8?B?aWxNK2k0WFFJZUp5TlJUdlBsRUVKN1lYN05GNGhHeFlBVGh2QXZTUDZ5Rytl?=
 =?utf-8?B?enc2QkJhdWhRTnRmOUF1OGpnVGsrYXZEWHVEaG11cXphZTdTRmJONEVwb2E0?=
 =?utf-8?B?MTdXZ2VzVENPdFVaTGhGTnBWc2U5RE9Hb1gzNXQwYnVhNXR4NXYyMkZlSVlI?=
 =?utf-8?B?akttOFBMUWtiQngyay94eWw1VjI0emx0bEFqa2pNOEdDNVIvN0ZrdXBiRm5K?=
 =?utf-8?B?UE9EK2pzWFNNcW11dnVWSlJzSTJQUjBacWlDeXVmcGMwQmVkeTU0VUJzNjBX?=
 =?utf-8?B?YVdWMG5PYTR3VGpHZTdRd1B5YmNaVG1IV3k1Q0VlaXhNOFZqYTk3SjRKeWI3?=
 =?utf-8?B?aGsxOVZTU256SjJOZTVmd0orUVBTTlVkNkw0NFI1QnJzRU9VcHVJT0cwM2Nx?=
 =?utf-8?B?dHl6K0RmUW9XbFllRWRBUDlqYTkxMlZSOE8wdTJZVDdYM09ZOVU3KzRSNnBM?=
 =?utf-8?B?NFpMOHFjajlOTmhNUHFkNFVqSGlPWkRWUWlDczVZVUpwTm1WYVVnREJYN1ZL?=
 =?utf-8?B?cCtnbGVGSTJSSzlYK3A3QWFSRE1FWjhRL3Z4K3JnTHZNWktkUUVVRzdOR1B0?=
 =?utf-8?B?d3Z5SzFTcVhBZ3BKUjd6Sk9PNTBON3lQWEo2WWhraEdyOTQxTGJucEFobjZ1?=
 =?utf-8?B?VExCQS9BVDZZS0dPS1lYbExwYXBmQVJ5MElNY2UrYmtmMzI0dkpwaWVFdkRa?=
 =?utf-8?B?S1JMRXlFYUwrSUpBQi9WMGpnR2h0K2EzTVlnS0MyWEk0OWc0RjF2UHFEZlcw?=
 =?utf-8?B?d0Rlc1BtOFFBK1ZWQ3k1YlRoUU5DRHJxcjZRK3Q1L0ZrcVVGenJRUGNqQjdv?=
 =?utf-8?B?T0dNN1ppUXhncnBEOTFTWERONzNtblBzTXQ0RjBYM2g3ampadTZ0UkJySlMw?=
 =?utf-8?B?Z1c4Nnc1cFlpbmQ5M1k3LzVCQWN0MGk4Tm1OdWdkUTZwUUVBRE5TTmt6aXYw?=
 =?utf-8?B?VkFqcENUUCt6QnNpVTl2Ny9FQVYwL20wNmN3ZkI0b1pNUXdyTG5tOU0vM3lq?=
 =?utf-8?B?OTBhckoxWCs2Y2NPMjlhYkZkdkErV1R2M3QwdlduMk9KYlZyVVhKK3hoQVVj?=
 =?utf-8?B?aFJ0T0lsL2F1S3lZQzVTSFZicjdKa3MvUE43MXhvK3pDcHdWZFlxVVNNbXhS?=
 =?utf-8?B?UmVPcGxuS2w1cC84OTlSRmxFbzZkOGZGSlkxN0UwNW1jc0pPeEdiUkZyL3pi?=
 =?utf-8?B?MXJzc3BDVHFYa0swajNMSnRPQm5qV3h6d3VaODFia1U3Q1V0SFFvd3dvUE9G?=
 =?utf-8?B?SGJ2OGZUaWdSYy85WFpYd243bTRhbVVSL2ZGZ2JYMDMzYyt3YnFFME0zeU9W?=
 =?utf-8?B?UldMZDhXTWxycUJTOG0raWt4RTJzQUhQbHhXR05DS2Q0VWxMemRDWkhpdE85?=
 =?utf-8?B?aHIxRGRXc3ZyZWtFSkxZM2x4Z1I0YlQwa3NESHdYdHJHd1lJcG9CODRTL3hX?=
 =?utf-8?B?VWtyYVhTZjVKdllBT1dFbE5EcFZ1b0x6cFdBQTB3VGVMT21OTjF0dk4wYUYv?=
 =?utf-8?B?M3l5bkZMNDJEVUU2dGdOL3paV2ZmMkxiRTNQZjJic2x3cXZYZ1QzdlVMclZa?=
 =?utf-8?B?NTBBRHdKSi9mTzB5c20wS2UzMW9ZRmgrdUNHU3RPYUJoM05OUjF5Vjdya2Fn?=
 =?utf-8?B?VFlGWXF5TnZXbERKKzRCTWJJajJjSHJBdkM4cG1TMWdKemRVTDh5Zz09?=
X-Exchange-RoutingPolicyChecked:
	X0xV+9J5XaJNQ17PwkSbW009parL+zGGtJJGCaIVdJvVvV7FqP2frE4uY08G5aGxNMOH0LouGtBcr7mogrnypfwK1++Km7Ll4PAb4QI8EjnY6UGEDjAOyrdooy+DueLhTDQC36icGLvAwrJGiBUjNiZPLxzlskJTdHBtgKAvFED+IQN5aYq3QayWABv5sP99+xzPO/Cytap8rcoTmy/uXa27xtC/+d+vNTJq6zX2L1hPUmrE8Por/zolWGY4dhD6vRZcl6Y4JRnBGf1CVcJ3ffC/iu5AzrRMPArWNbTNkJ9t9xqV6EegiQc1LMk6povGK7zGXlRCIOZ1GLffqfqtqw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7dfc44-d80a-41bf-9080-08decda03760
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 01:15:14.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXi44af2yuEapDOwQFoj7cjYaTazjEIeEsONGnwa3nm8jEHMf9RX2wcRWEnSS/1SEjP5RFie4TEXeXSDgUXwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDAwOCBTYWx0ZWRfX18I7WoENH+VG
 Z1OX+lUkZoayu523cT8mRd7CKhjdiH9C8CqYmucCtHrP5qN+8cpJk0jqZEKYZekSFhunbmWZ/T+
 OZRsWA3WnZve8YfGV0tfQ9fC7JJ5ngEXO8ImfFt1JhasuWVFXk9h
X-Proofpoint-GUID: p2AZyg9VfGFoL9EGtTWvWqF0N69Penc5
X-Proofpoint-ORIG-GUID: p2AZyg9VfGFoL9EGtTWvWqF0N69Penc5
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a349825 cx=c_pps
 a=wszTalFPv2ofqEyTcV7qHQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=gW1b_AsNN7WR1WK2oxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDAwOCBTYWx0ZWRfXwbSBENdwYMHF
 f8/h+ua+HK+5omlejByNesadCPl9s9mNt98ndPP6dyBHgWWYZQ8QhA0X4GsYEKe8MS3DlyTCcsA
 SvTKUZIGg8Gv2YIxdLWOAQP7I/XRqWQX3jV24dI5HnsBlllwPSVP0EAZiTw0wp0Q2h0kGECL3VH
 h+l+SoN6DQ5wB0MeMLPL1tbR12oY5Ug2g+r3VV+qbIZdolPsR9+ybx5CtCJoc9BBIyGXechLui9
 CBBmTgZ9L7Q2tnfNk6TJoeSCEi7Rgfz1rYOAZfe4s++kzbxilDiEqFBKxUV5QkU++n38PvbE0ZQ
 N+XL6MonlAWsfce0/n4blvltOostMXEZS+8+QIbAfPq1kY3ZYDn0/fMpxFixlCO4zidggJXiCIb
 YhHCZEN2G0xH9ke6lNjjYDGmCR1lhqOlEiavljHCEJWTIivR9pkIsbJWDFnG6QGfabAN0lxIa5u
 n6TKyX4TDxMCeZ/eRiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300568-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:dkim,windriver.com:mid,windriver.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DA096A385C



On 6/18/2026 11:53 PM, Sebastian Andrzej Siewior wrote:
> On 2026-06-18 23:45:51 [+0800], Zhou, Yun wrote:
>>> Having a NAPI instance with IRQ per queue and those configured and
>>> spread among CPUs should cause less trouble and is what others do.
>>> In fact is the only net driver using per-CPU interrupts.
>>>
>> It is a SoC limitation. Armada XP's MPIC provides a single shared
>> interrupt for the ethernet controller with per-CPU masking for
>> interrupt steering — there are no per-queue MSI vectors. The percpu
>> IRQ model was the only way to distribute interrupt handling across
>> CPUs given this hardware constraint.
> 
> Is this a hardware constraint or more a software design choice? From the
> other comment it read like it could be changed.
> There is nothing wrong to provide 4 interrupts for a device from the
> device-tree and then allocate and request all four. This requires that
> SMP affinity is supported properly in order to spread it across CPU. You
> would also be able to reduce the amount of queues/ interrupts via
> ethtool if you would like to isolate a CPU for NOHZ reasons.
> 
This is a hardware constraint, not a software design choice.

On MPIC platforms (armada-370/XP/38x), the mvneta interrupt (e.g.
hwirq 8) is a per-CPU hardware interrupt line (hwirq < 29 in MPIC).
It is a single physical interrupt source that MPIC routes to all CPUs
simultaneously — each CPU has its own per-CPU mask register to
independently control whether it responds to that same line.

There are not 4 separate hardware interrupt lines that could be
individually allocated. The irqchip driver (irq-armada-370-xp.c)
marks these hwirqs as IRQ_PER_CPU_DEVID in mpic_irq_map():

       if (mpic_is_percpu_irq(hwirq)) {
           irq_set_percpu_devid(virq);
           irq_set_chip_and_handler(virq, &mpic_irq_chip,
                                    handle_percpu_devid_irq);
       }

This means request_percpu_irq() is the only valid registration
method — a plain request_irq() would fail with -EINVAL because the
irq descriptor requires IRQ_PER_CPU_DEVID semantics.

The multi-interrupt approach (like MSI-X NICs) would require the
hardware to provide multiple distinct interrupt lines per port,
which this SoC does not have.

BR,
Yun

