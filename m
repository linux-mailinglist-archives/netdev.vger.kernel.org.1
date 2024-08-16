Return-Path: <netdev+bounces-119220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9280954D42
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E828470B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921E1B8EA0;
	Fri, 16 Aug 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sxo3QjgD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5091BD4E4;
	Fri, 16 Aug 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820121; cv=fail; b=rb98O54hXC7wCVIl4gIXfBWxbzvJU8iQT3Vlc8Gb+qwCZvH773tiHdHiSztEo9MxLhdw18D7V9GZvxir2xHDUISyjbkSE/DQMb+asW1H/a7bhaFetRT5cODmnvc7QUb6jy1Kyp5Iyffi4GhUr3ic2xaPaYjB7fdtPa6y3Dr8jQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820121; c=relaxed/simple;
	bh=vR1LA9ra5NpK6L2tTOCzio2buWS+cTiwwXyGZarpSCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CofXrqwrooToQBNf8CBWdNh8/uxiFlY8skznWG32frZrO/YelH+ieCYKDDbjSMgPa1gq6MFlzTwnlrITKPN0mRpTXV1euPi4flQmtwXgULr7pd0WT7+7bbYTWjmrs52j07ZiYg5rVWdjlp0II7bebcHr6xaIM3tMounwG9iRn6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sxo3QjgD; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao8kjwnWes1LeEeNjWvBRgZk6gKVmLzwgI1Qn0XJYSt1DmJAFdFgppK+f30HxpFgXf1MDRRzvTlrf5iY/Jvb9JrJv8DzgPUezinv0mAlzcT2xeAptWdknxQmBMCefTjb9oynHTtEj5tYsl0I2zdTnpvfC7kimVghACmuLREB6TgUi0PDkDrhf/VEEv+1vpW8L6Bveilcr2DgmU5jFMiPMtPzWJc0G2TwmMVCuYcl8Wvu6CQTgj76jQulrGSTFcz0zdidoeADVe47P9Okw3KTJziZCnZsw3k3Sj0PxWO39+7fNRSXStH8yU4DQz8sDWc5MCg3g4kQRXbH/Jvu9eXVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeWrstF0Aho4JF0+d63pm4Y+wy8Be+IlnvPjJ7x08xg=;
 b=Y3ZxdzhrNs1/cxCL22eOF/VuD00a8STSV4+wFatbzl1gWLojnuSSMP3orhKVGI5hygMjoGOLwf2JRQvfhO2A+3suhhqjkQi7HkUm2Gq+myYU5qoJmZ87U0uBSGjvmNsVWUwVR4YxCDYk+aTUJVDQfyjLsedbPGHGReE6hnLnXzouGs4upjsRrLQem3xOGhV2z5CW5InFGjytVPHzQ8GvKtwJg2v0hjW2/lx90vJNPj1TR45MiIMmQJUFq2EPv2THzzec0d0dXJ25mx16xAwcVPcLPkfk1pdDTqB/cQdIvNF1tlBq1O6m9NX7YkjHL6BuSnGzp5x4n0PkNDVe+mF0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeWrstF0Aho4JF0+d63pm4Y+wy8Be+IlnvPjJ7x08xg=;
 b=sxo3QjgDn1ceA4KC0P6P2J92Viasr+9rOj5wyd6YHc1+rBIp/HVvp5AiN15UevkiSCVnM7et3xwP6TOdLR45fHBlYK/bH3TiR0WZTJVIWeAiDkmp1V8BW7WacD+BT2XgZ6lhmb7Y6hRWMdEXePnJHg0kP8z5Jtajqjk3o4PuBq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 14:55:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 14:55:17 +0000
Message-ID: <032d42a4-a02c-c928-8bc2-1f20145a52de@amd.com>
Date: Fri, 16 Aug 2024 15:54:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/15] cxl: add function for setting media ready by an
 accelerator
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-7-alejandro.lucero-palau@amd.com>
 <20240804182646.00004a56@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804182646.00004a56@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c279516-12d8-4478-aa74-08dcbe0370b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REM3YTN6UFhFR3VkUXN6V245VytlUHhpZnM0NklKZXhVZXZFUUpBa3lPRGFM?=
 =?utf-8?B?UnRsMVhMdlBYQUdoZ0huUmFSS3dObEwrcHFLdVpETFJIVE1Wb1c3SmYxRXVU?=
 =?utf-8?B?dmVJMzdWVnA3eGJzQk1uSWo2MEhLcFBJVTB4aFhhUWtrQS8xdGhTRms3NlN6?=
 =?utf-8?B?UjZCWk4zV2hXUkJYdjFMWlp1M0RwbThkUXloakFwMm9ZYVFWQmZIZUFLL1hk?=
 =?utf-8?B?VmJuQXdxNXdpcTdjcmdMWjd2OWJYWCtCektFVzNFZlRhbWs3QzNSa2FlTk12?=
 =?utf-8?B?OTNrV2pvV2NFbURUS3Zvc0x1RWd1TFZhTU5BZ3hYSjZxVjdGWDV0TkJ2YVRu?=
 =?utf-8?B?OUN1ZlFqQWdIVDhzS0V1Q3VhcmNxV0w5QnVEc2JtZmYrNXQ1eFZTc3JHdW5E?=
 =?utf-8?B?QTVMSis0UjFxNXpHUGNlYTJmQnQvUnhjMnh0OHlEaHRDRzd4bStEK3JMam50?=
 =?utf-8?B?dWtWNi93VWFkbkJJSXd4cnVvd3pyM2MrMW1yVDFGVCtMY0hQT0lRN3BWbFYr?=
 =?utf-8?B?bXJJZWdIanl6VHlvWWxiR2ZwS3cxTUt3bTBSRklxbFNIdTRHbDh3bFprV0ZJ?=
 =?utf-8?B?NUIyWlJ4K2ZQS2lRQnZtMUQrQ3RIRU9FYlN2NTlLUnJwRDNOb0QyY3FPVWNN?=
 =?utf-8?B?SlQzVDhESUtXNk14WW5VTHFGa2JSamNFc09FNzhLYmNrejFKbmVhSE5VYmJN?=
 =?utf-8?B?dDVtYzd5a1J4L2c3VEV1ZW5oT3ViRE1aQkU2cjlJQ1JGT0dzSmNQVGFCZTVq?=
 =?utf-8?B?UHRvK2p5eFhTNVJGUUVHVkJNMlBDa0lWU0ZYV2hvc0MyRktFVGpteHdXTktU?=
 =?utf-8?B?SmlnNzEwbTRkamhtRnRnaDkweGU1YkFkRnJRMENLbyszdHVlaXd2TnFJK29Q?=
 =?utf-8?B?N3BVZlhEUUY1eGdGU2JFM3JlSGFQK0p0NmYwNjI4SWtJY1NkOXZRNVQ0azFD?=
 =?utf-8?B?aHo0Y2VpTmJEVTZWcFR5R3hId3RZeTlUQzFGTGNJQnJ3aU11L0pjSFhaV2lT?=
 =?utf-8?B?TWFmUGhmY1hlL2lGbDBPZnBJZFJmdjRRa2JRVjZJaEdrQ3c3VmRpaTRiUzE1?=
 =?utf-8?B?OE5Ma3ljQWYzYUdycUpJWitESk11bjVQOGdJWUVJazVlbkI3Q1RNcVRScWxs?=
 =?utf-8?B?WUV4eUhpWVlSSWRmaHVldzQ2MUZJekVTTjBpNjV2SEN3aThHOTNwdVI1cHlx?=
 =?utf-8?B?ejhPQ0t2U1hpbWlhbHZ5ZCtmT2JSWGpFdHMzcEN2aktNL01pYXo1OEl2a3o2?=
 =?utf-8?B?Vm5FUUVWSVZsdFd6SW5hY0JGaVlXZVkxd1Rsb0sxNHNrWDUrd0kxZGhMd21V?=
 =?utf-8?B?LzJmTGF2eW5maEI2ZlhzNHFDeEc4YXJWQkJ3ZXFjL0FYbTBQa2NZK0Ivdlox?=
 =?utf-8?B?V0pGMG1HRDBWYWdZcHpYUXczSTZueU1ERVVlN0FiVUhSQXBDNG9vOFpyQ1cy?=
 =?utf-8?B?UWRiVXNmM1g0SkRLRklkSzAvL3gyaXZhZnVxK2FBdjF0dytPUWdoRjROUER2?=
 =?utf-8?B?VXd5Z1dLdlBEa0xSVitvNzhRVUtoOHpzL1d6Y3JsTHYxTXdzY0xnNlVRTDRm?=
 =?utf-8?B?OUJFdEhKMWU0ZDZNVmJlbGxLQWF1TVBTeU03alY3UEJscWNyYzJoSjAvWFhp?=
 =?utf-8?B?b3prOTRTS2RXNUhXRG9tcDBRS0tkY00wdUZibDhXam5BVFBFMmpHUHdMdW5x?=
 =?utf-8?B?SVlDWjBDeXoyRE5hQlloM3crOE5YaG5Temp6N3kzVXFEUktyWlpKUTFBbnpl?=
 =?utf-8?B?NE4zRnl5bTNlNFMvWHNQam9Oc2w0UElCelJrUDBWZDNBTWdjRlgrMVFQWWRh?=
 =?utf-8?B?SlhlTHRYeS9uaDFGKzR0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhzYlIyOTBrdE1WM0xtZU5yWGNoMGtmZU84TFZQOTRoeTl4MjFjdE9DVzZw?=
 =?utf-8?B?YWVyR0xwNktvNkZxV3ROUlNITUpIR29tU3YxallRYWZybURPQnFoTHFLY0c5?=
 =?utf-8?B?OXJGM0gyOUd5R1MrcDFUV05MV3ZyckJmaDNUVUs0bENkSmZIdVhEWGFQTE9v?=
 =?utf-8?B?R25iWkpQRTFEQjJoa1hyUXN1UGx2dkFyL0hySkV6ZElZaWEzRGJ0ZTBQYkps?=
 =?utf-8?B?dStSMzR5Sy81K1ZlMjRNQmh6Z2c1RStER2FCbG5IRVdUbS9rOGxjREExL21j?=
 =?utf-8?B?d3lIK1hyTjVpcG5tRFpOQUNPWUo0QlBpUGdiR2xnY0RTZ3grQ3JEQm1MblRj?=
 =?utf-8?B?R0QwUk5PM1B1NytIczhObDg3RFdhWmQramcvZlhLN21ZWUJ4TlBPT3dQZjlp?=
 =?utf-8?B?MDR1SGJGQjhSZmRJa084enl0QjFlUE10Vk5UMWtOY3U4SlhLQmdDb2ZMUWZs?=
 =?utf-8?B?QlEvWWpIRklqTUo5SDZDQWJFZ2t3ZFZMVkZSdDV0bGtteldIU1Q0UHFjUjli?=
 =?utf-8?B?NUpMZzVXYW1oNkIwaEFKZzdscTBMc2dzeEFDWWJWNGlVNndubGNvWWFEVlg1?=
 =?utf-8?B?WkdIWDlUUy9vVGluRUJka3ZmZUl1Y2tNc2RmMW4yZ3RCUGhRd1I5bVpJZzI4?=
 =?utf-8?B?UGp0cit5aklsb0h6NEhoSjMzWEJQSEt6QlA0Ym1xemNvMC8rWDFhRjBIcTNz?=
 =?utf-8?B?cWlwK0hKVTNIbGxFK2FSbTJTZ3hqUG15SnhMazdBYkJQdmFVdmhhTDVJL0xl?=
 =?utf-8?B?SnBxYVZkV0hCbjRnaWcrVVRnWnBydGx6OHRSM0phWTFzQkVHVFRyd09nQUxL?=
 =?utf-8?B?UmJyTk1KVGpFZEJXYmRwakFBVlFpMEtrWTVncEJia25xeVRmb3lodmUyZEdT?=
 =?utf-8?B?VGxpY3hkRUQzelNGREVxQnQybHZQeXAzWGFldjFpU3R2MUFheWFPcENGTUV4?=
 =?utf-8?B?MWtlWWhBcUw0TGU2dHJZeFU4bDUwaE54a1l6SHhhakdSNFNvN0ZjaDVJc25y?=
 =?utf-8?B?NWh2eEtOQXRaMGIzcXRNR1hza0Z3UWhxV2dJOEhOOFdETno4ODBCbmt4cFdV?=
 =?utf-8?B?azh2dGNMd0p3UjRld1Rlc1NhQTZvUWlkb0ZkM2VpV3J5N3lhV2VFYzFnc1hq?=
 =?utf-8?B?aVkrYkw0ZTdXbTZjZjRyZEc3ZDAzOS82ZytFT0gra0I2US9mL0RrUkhrK0F6?=
 =?utf-8?B?UGVKejJvNTVFbkx0NGg1YWJGK2tuWlllVUppaEpDdVZQVWtYc1A0dk5WK0lU?=
 =?utf-8?B?M0V0NnRUcXJzcitqZU96VXZzU1Z6Vm9QWXlPMCtLaHViMGZEVTdZejdNekxW?=
 =?utf-8?B?Rkt1Nkw0QVc3dkIwSzF6SGY3azJsaW1mUU1BcGpnV3VDQmJmZEVmYTM3bGpV?=
 =?utf-8?B?bTdHcmVRVWd1VGpwT0JFTmk0UzBQWmIyb1BnWkRkU2NveEdYYVYwd0dVVGxs?=
 =?utf-8?B?cGl6OStFYmdyNmxvY211UUxoTHcvTHhlN2VJbGZscUVuZlFGSXFwdFhjaU9k?=
 =?utf-8?B?aEd4aEVkSW5jNXJVVCtiRTh2WTNxMlhnRkdqUCtlSW5pL0xzTStEMndRU2w3?=
 =?utf-8?B?WDJHc0FuTFhqd0lkVVprMHhvbmpsWFhlRjBqeVVMTUFxWHptODhlVVhTNWwx?=
 =?utf-8?B?MmJSTFpKWW8wZDB0Vi9qYktsa0pjL1R0Z0gyK1ZNcFVvd2xzOXVRQWE0by9n?=
 =?utf-8?B?UXlBaXhsWEZlaHFTbldoejlhaXlmZWtDM21qd1VnSC84aHRaUEhrbHFEaDM1?=
 =?utf-8?B?ajJleHJqelFFdVlDQUxqSUJNMW8xU011SHpvVS82NXR4bnFSaVBzVDdWOUVJ?=
 =?utf-8?B?akZQZHIrelU3dk8rRXJEdkF4MmpaYlZYdlplcmtVdnpIdjlUS0VNTUpwbkw2?=
 =?utf-8?B?VU5aeGMxakc1Qk40aGNKdTMrT1JHeWY5WE9IUEU0MExjVmtPUWQrSUp1bXd6?=
 =?utf-8?B?cWZhUkVSVnh5c0xOSHIwQXNPdmhnR1QxeHI4YS9XdUtNR21FZWcxdFpLT3NI?=
 =?utf-8?B?a3M0UHJBUERwLzVZT0FxbzZYRGQrdzE1VHVLdVBNMXRteDBrc2NKcGQ4T3JL?=
 =?utf-8?B?SHc1SFBEZmxVVmlCNGlxUEhLNzVQNUpnWVlMckpzR04vWU5oY2I1bUxuUnZJ?=
 =?utf-8?Q?4QI1nfFnhYF7eO8Qa5W06UweF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c279516-12d8-4478-aa74-08dcbe0370b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:55:16.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffDge/n8NeglaRG2PZCxaAzaTdkNQEEI7y8/3eLAxoUjhVfy9PjgBHT0XNhzOU/zXgrGHbE/8Pef1SfgQw4HgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266


On 8/4/24 18:26, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:26 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type-2 driver can require to set the memory availability explicitly.
>>
>> Add a function to the exported CXL API for accelerator drivers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 7 ++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
>>   include/linux/cxl_accel_mem.h      | 2 ++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b4205ecca365..58a51e7fd37f 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -714,7 +714,6 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> -
> Grumpy maintainer time ;)
> Scrub for this stuff before posting.  Move the whitespace cleanup to the
> earlier patch so we have less noise here.
>

I will avoid this kind of things in v3.


>>   void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>   {
>>   	cxlds->cxl_dvsec = dvsec;
>> @@ -759,6 +758,12 @@ int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
>>   
>> +void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds)
>> +{
>> +	cxlds->media_ready = true;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_media_ready, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 37d8bfdef517..a84fe7992c53 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -56,6 +56,11 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	if (cxl_accel_request_resource(cxl->cxlds, true))
>>   		pci_info(pci_dev, "CXL accel resource request failed");
>> +
>> +	if (!cxl_await_media_ready(cxl->cxlds))
>> +		cxl_accel_set_media_ready(cxl->cxlds);
>> +	else
>> +		pci_info(pci_dev, "CXL accel media not active");
> Feels fatal. pci_err() and return an error.


As I commented yesterday when this patch was pointed to in another patch 
review, this is unnecessary in our case and it will be fixed in next 
version:

cxl_await_media_ready will not be invoked only using the accessor for 
manually setting the media ready.

Thanks


>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index 0ba2195b919b..b883c438a132 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -24,4 +24,6 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   			    enum accel_resource);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>> +void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
>> +int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>   #endif

