Return-Path: <netdev+bounces-154220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D39FC22F
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABE57A0210
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544C1922C6;
	Tue, 24 Dec 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b="JOHcRL5G"
X-Original-To: netdev@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020109.outbound.protection.outlook.com [52.101.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505117996;
	Tue, 24 Dec 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071623; cv=fail; b=pMetj8DsEt0ZDiHQcXpvUtIKP8MJUYgJAf6EecsIjprqvGmYmSaJC8RJUvX38hN19znRKHvbiOTN1nqReGg19zIR89LohSiWzHsHvmnH/qdTe4uoXZcFhh/i6A4b63GBVA0qkH0NDxdQseoO8rwPO3Ub0xmiRcvoUmjbkirTlK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071623; c=relaxed/simple;
	bh=PHUYWP0aQ6cw4o2NtzuW6yjHCbER7xfcyZuVHxoOxtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XgCm5Lbhhqx76j235uLuxCwJfS2b3Y9o1wwrxfcmDHnzKbF7xpvqqQRLxYBUeekimvzhe4KMbPxRnJfINUj94yYUCCPG34fY5u31xnYT1x3J3Enpa0CwbfT9VsS9ceT60ApqX6stXtSZFcBMgmSfyndOLy+YiA2kZBq0r6KrCP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com; spf=pass smtp.mailfrom=lenbrook.com; dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b=JOHcRL5G; arc=fail smtp.client-ip=52.101.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenbrook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZkKWpGBHiZRpvKzyWn6OeqCo389Y8G9zks55q7Ajpa1ZxcD+ROebGWmI55o5XC2S9TTaF9PbWUG7tR+u8Hrp/dIA2IFFGBJsP0FI8UwVZxh0h//Ben2JgyQ351MQ4lLQ71H0PqcMZ6eEG9ORJzB9/+SFXV0ajNg9ab0vAEEIKSHVYLWTwUwWYuuUylGZ5+O+649Ac3tnP0ZMTEbXWV3a4J6BusbAutYNw9WuJ+5aqZsaO6n4A6n31qMBr9nmvTxuDmpzxY/xccIRfyPxw1sJCKUVinM712FmSJsC/E3NbiQ3hzZutHPmU6YD3xqJkXRKA93jXDyLfnsfBBDzT0qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE3cFb3wIV2yKz6CASGLX6bQ0tbLHCulhTa6ZfvIblE=;
 b=Edsz1fpos/V3qcu8J5gS2zXD+8+F4itlGDLA88bTVkW6bLFB44EBUmxlWlapq+PzGtNucdxR8tHyaQaMZ9wmYnsAnzBIQcAMLauQGzqE+HwDOBLrx3AQeu/Zm/NAbx4LRUBA7mImoO8RHe5NZVH1yBNn9nek42e5uXuvDcyFTRqPcJ9MmBM6hVUGgmVhfP/0fZFI9C8QfcHBof5LbOeCsij4i9RTiQU1K/kdnI7kariE9UmMrERxRkFkVtkpJ8vRkN80LG+5Kfs4H4QXtSTvy6BcLbyXQAJuzoh0nxnpEuhQ9Cd9zmSjmdWnx63seQN5ZefH8BIBWFLgJpqvUQr2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE3cFb3wIV2yKz6CASGLX6bQ0tbLHCulhTa6ZfvIblE=;
 b=JOHcRL5G9wSd7fC7IYGD0Y4K39RTaNNKOU3qKq7M6VD7rHf0bTEN6WmvefSrD8eObQyMH/xl6ZPeGUx0ciVfd9AUD3wkqWUQ4VjnIqja9t3jFf6K7pk2526WgLxSBovPs6zL4Z7FklWt8BjjKPfh7tEEBJx80CFiHiwzFnIanRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:54::18)
 by YT2PR01MB9144.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.22; Tue, 24 Dec
 2024 20:20:17 +0000
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541]) by YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541%7]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 20:20:17 +0000
Message-ID: <bef66501-f769-4196-924c-1ec9ba2cfc93@lenbrook.com>
Date: Tue, 24 Dec 2024 15:20:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241223195535.136490-1-kgroeneveld@lenbrook.com>
 <AM9PR04MB85059A742116F7E57D0DC32288032@AM9PR04MB8505.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <AM9PR04MB85059A742116F7E57D0DC32288032@AM9PR04MB8505.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0415.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::25) To YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:54::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5632:EE_|YT2PR01MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4e36b9-4976-4afe-e55a-08dd24586203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGVBUzQ5S0FydVRQN09TdHF1K2NGZGNXQzA4ZlBRbVZzd1RLMEZ4bzdUblRr?=
 =?utf-8?B?YjB2bDhJbXhPZ2lKbmpmZjZDSGtUc2xSYWllaTE5YmtlRllSSmxRVkduUFFQ?=
 =?utf-8?B?cFNBcUVIMEkvbGxVdHhtWXNyYThLUVExeTRSck13SW5SdmIzV2xsRFNIamk3?=
 =?utf-8?B?VmFBY0pwZ1hPU0ZqTW5uc1hYOUNGWFNxV1dDOUtCUU1IakJ2WGNCTXZjSjEz?=
 =?utf-8?B?b1lQaXNwTDVIQ2tDNUc1ZUE3S1hYZkExbDNVVWVRSTI0TURRWDJhc0JJR2Y3?=
 =?utf-8?B?T01QbXNMRlpzTW9Hb0Y5MU1jLzIzYUVsdmFndVpuSjdhbFBHK2cyeG9lOTZT?=
 =?utf-8?B?cVBLM0xzSTNMTVRNSXdEUmZQclhQRk1IM1BYT3dhN1lraTMybVZudk5XbXVX?=
 =?utf-8?B?NHc5SVp2bzdzdnV0TjZvdDJEUjBqbjRSQ01wVklnbGd4MmZZWjJJZG52aUFn?=
 =?utf-8?B?MkNlT2M4VUVVYVBNVko5N1VxSzJTaDJISTVhMWc2SVc3QmhXVzJxRUgrZ0sz?=
 =?utf-8?B?a2dMbFFHcXdhQjZkUUxoczF1cW5zYjhjeENmeG5TUHhYOENrVSsvRStLRmhn?=
 =?utf-8?B?aTh1eHZzaFRFVzV0RVpqSkpSL2JYU28zakY1RUFpS3F6ZFNXRzFkMGZKWTlZ?=
 =?utf-8?B?VW1pOEJEcHVvVysyb0VwUDZwdjNrenA5RW5xTlltSytKbFhzQWZRN1ZLVFM2?=
 =?utf-8?B?RTBqb0NQRmlEb0ZKaFhVUEkvWllSYm5mZ05JMU5QcTE3bE9CVnI1Y0RuZlZ0?=
 =?utf-8?B?bm1FV085Z1VLdE1MWVJINDJUN1BTVTJwZkY0RXVGMURUekRnVkxCWUxDUmNE?=
 =?utf-8?B?cm9SNlVSbGhvYWhxS3hXcmJwMXBRTUlKSm0rSWhsU1Y4YkxCcEQ3ci9ZYXh5?=
 =?utf-8?B?bzZDVElLZXFqMlZLY0JWZnhNMDFoQmhhTHh3OGdKdVhTRXpXakhSSEhJdGdS?=
 =?utf-8?B?MVZNTFFvMmpxWjMvbTNFTmpXSERXYWlzVVBHNXQ3SHJ3Y0lYYk85c0YxUVVI?=
 =?utf-8?B?QnVDUHVnOFkrNCtRUWZsRWd5NU5KZWsxNVdGMXp6Rm4vditiV01BVGhIc0Jm?=
 =?utf-8?B?MjlHWkFIczNOdmplZWg5Znk0Q0tSbHgxMlRvOGVnV1ZDZzVFd2RCelNDV3hx?=
 =?utf-8?B?V2dibXpjTFpZQ2FNUTdWMWJuZitwYkYwSDJjUGhWVmZQS1ByZW0ySE5SZEpP?=
 =?utf-8?B?NUNjWEtPdUNJQU9mZjlLUGRVN1B4UmNxdFRtTzNUSXEvYU45eWorMEkrenZE?=
 =?utf-8?B?QjQ3NnM4KzNlVVFhRzIrMi9Rb2NSSTcvYlc2VjRzN0Z5RFZ0YS9LbXFXWG5q?=
 =?utf-8?B?QWlpcURoWXhBNkV1YmJYZzJMaU12S2R5Q0RTUVFmRW51WmdMd0FqbXpreEpK?=
 =?utf-8?B?SFF6d3JNdTYrU3puWGV2NG5tcTJXSXgyWnFtakJlUVBqOWV2MzdndDgzWTRq?=
 =?utf-8?B?SDRPNVBJa20yc3JKbC9mR3hwTHcyNk5jblN0MWwxOXMrTjNSTXFQbmxvc1Ni?=
 =?utf-8?B?aW5yYUFRSHRMeG9vMGQ5Q0NNY3llYzlHNjE1YnlWcFRzS1A3Z0kxaXFmK2dD?=
 =?utf-8?B?eThiQzRUVzNjeUJ0UzVHekdvQlY1MXJrU3VnT3FMVzNYcU1kTUtZaUZPUlhU?=
 =?utf-8?B?YmQwQ3ovaldWMzdIZlN2eUE4cXZoMUVjQytxa0U0b3p1SGttcWVaa0lCdEJX?=
 =?utf-8?B?V2lacWNLWUJSSFpIdjBpZWtPYWs5RGlSYXR3NTZDb1hEY1l3TmlTbktKNXBu?=
 =?utf-8?B?UmNqd2I3amhLMVVjVVhwUVl1WUY2Q3lFVVdGOWFxcmRrckszZzJMTSsyN1lr?=
 =?utf-8?B?NjExZ2xWK3Nnd0p6VndpQ0F6NERJY09qMU9EYUZUNUk1MDJIb2kyMmozNGJW?=
 =?utf-8?Q?j1vRcoWlNzDbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFI5Y0lpVjNUSjRjVXM4am5Bem5QVEV4SXU0K0VDSkxQVjlCTmhNR3RSNGdT?=
 =?utf-8?B?QjRxMThzNmxSREV6ajUzV3M1S0wvcTVoNU5obWl4OTZQZXFYREtWRmpiVjNm?=
 =?utf-8?B?WDlCbksxTGxZNmt0aldrZ25yeHVmY3NqNTJEOSswMW5QYnN3TzBWNHVUeDJL?=
 =?utf-8?B?bWZzb1J2SGJoZDlXbTFnMUo1eUxWb0w3VUtsMUx5OElCeG9oVzhaSlQwbk0y?=
 =?utf-8?B?T0pZdE91aE83NGJ6SGhCU0ZhMmk1Mkh1RGFtd0U4R25YaGIrd3NCaWJCeDQ3?=
 =?utf-8?B?N1E3KzUwNXcrcEZvb3JjSEtsa2RPZkhhS0xjUlVYZVlkOXJhSTZzL3dZLzBU?=
 =?utf-8?B?UThjSGJ1bjA5TWRISUpWZUw0Vlg4RERPMnpuckFwNUNkMmFJQ2o5U1p6aUht?=
 =?utf-8?B?MEtTNFFnd1pqZzhUQitJR1lxY0s5NjkxRkpPMG1MNEErakRGdlhGL2hXK2Ew?=
 =?utf-8?B?Q1daMGdiVlhGKzZHRGJWQWdya3NnMlkzTWk1SXpvRy9KSjlEWExZOCtaMSts?=
 =?utf-8?B?c1RpS1NITlRKaWEyNlBjWEJpdW1zNkVQbC81N0N4dVUxRTJ3akx3VVVqaU00?=
 =?utf-8?B?MWkrMmJWL203azVXYUpXVlQ4cWQwTnQ4SnFSYUIwZFlDOW5ZbTNnOHJVUms4?=
 =?utf-8?B?RkkwTi9hWEF1SzZVSjhXeExmQ2JuelBiT3l1Wi9VQ0w1RXZYcXR2YnZkNjBQ?=
 =?utf-8?B?ZE1PQ2VSam5udytDRUU4cmM5TDdjeVRoc3M1elV2QU9KRlVhWFFlbWE3UFBa?=
 =?utf-8?B?cGRvSm5zaWNDUkRGRElKZFNreXlaR2xUOEh3bmZEbHl1UE9ob3FvRjU5R2tu?=
 =?utf-8?B?ZGJyVUl1K04rNVVWTUZGTDRCdjB0K1p0TDU2YzNXdlU0djBLT2Zndy9adDZT?=
 =?utf-8?B?WFV4RjBwYTcrWUpSN2p5dC85eit6SS9HVjdwdjVDaW9IaXA0UTd3NGV5RVpG?=
 =?utf-8?B?VjlKMUpkUFkzcUE2Q2dlMHZvc1lOWEtURk05dkUzNXpFN2tQb2xTN0RqL3p1?=
 =?utf-8?B?dEdVUVhFd2Z6ZWl3K2VrLzEyQlhsS1RmSURsZE1CZ05mT1M2Nmg1MFRNYTAv?=
 =?utf-8?B?ZysxT2tUSlp2SVMxWWJiWEVlQ3dnek5VV1pPTWhBTEw3QmJGczhsckpUK3ZJ?=
 =?utf-8?B?Z3FYbHZuYzdOUEJuamRoTXlEVGkzeTFLV1JNNW5FOWlESnhOY0R0blNQampi?=
 =?utf-8?B?TmlCWTlHMmkzYi9UY2dKQW1HZGlBZUFyQzFlL3JVN0lhMFE5UzJwMm52QmdI?=
 =?utf-8?B?Nk5MZ1oxZGhLT052blhnWEJMMzNHUENWOG9WOGpiQXVyVzlheElxU2RmQ09J?=
 =?utf-8?B?Y0JUUWdvNkhCcVRsNVpOVitaSFNHcmVPcXBGUWRuZDZzOGFzSHNQSmNtM25I?=
 =?utf-8?B?ZHhYNTJJR1MyODV1aEhBWHRwUUMybmVnM2tocllXelRqUG1nN2VOYTRSWklT?=
 =?utf-8?B?VHBYUnF3R1llcHhCOGdMZnY2YU9Jcm5TRDZBU2d3ZGV1NkZyQVlsWWkvTTNp?=
 =?utf-8?B?Q2RwVS8xa0Y4K1I3YXc0Tm9uT21ETTNmWnFZM09nTG53VFo2bzBZRDJnSFRC?=
 =?utf-8?B?WEkrTS9xL3RxSEtqaVZFci8vLytENG9Bb29DcS92SllmRTFteHNtbDJ6QVNT?=
 =?utf-8?B?NFZ1djYydU9KbFo0SWY0K0tzVHVtdmF4TkJMSEZVQ1UxUmVMa1VrWGdPREQz?=
 =?utf-8?B?YlI1TkZscTY3cDA3Y0RWcEYxd0NxSFluY2YyaytENTZ2MXhiU252Q2ovdUVw?=
 =?utf-8?B?eG82RVc0dlNEMjNSemE0c0JMSmNtQ1lBWU9FbTFlYWpvZmltRDlwM0FnbTNL?=
 =?utf-8?B?bmkvWjNSOS9kUG9vZUg5M28zNkNxTWdIb0xhMnMyYmdKU2JpSnR3WnEwdnZG?=
 =?utf-8?B?dmFzQzEvd0I1Tzg5VVdNTGlkY3dkeGdSNUd5S1ovSkU2YVdkZldPTUhCY0VR?=
 =?utf-8?B?dnFYYit2V2RFNW5kem1wZEdzOE9Kc1BpYXAvTU43S0FCVTNjM2pGV2xBR1ZZ?=
 =?utf-8?B?M3J2Sm5CY2dBbEZqWjRVb3c2bnVNOStJMWFoaWhXOG4rOUNWNjArWFZQcXhV?=
 =?utf-8?B?NkNsK04zc0hmUldPWGU4Q243VUI5b3IrS0FUT2hBd2piOUJPL2ZUNGgzMUlZ?=
 =?utf-8?B?R09iYmZCdG5qZFdydkRoeWd4SzlFZFUrQkdsQy96R1Rtck9kWnNlUklpMkpX?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4e36b9-4976-4afe-e55a-08dd24586203
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 20:20:17.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLDWySA6iPYEHEr+ICTrgFTBb8V2QU1IH87QMJu6aXTDljEXlQF4yCLPhPDnpcdj6hduP2jTQJQ3GI35Y+M688qr/RoIUcMsEn9ChTuMDD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9144

On 2024-12-24 07:56, Wei Fang wrote:
> Please simplify the log, it's too long.

I will simplify it.

>> @@ -1943,10 +1943,12 @@ static int fec_enet_rx_napi(struct napi_struct
>> *napi, int budget)
>>   	struct fec_enet_private *fep = netdev_priv(ndev);
>>   	int done = 0;
>>
>> +	fep->rx_err_nomem = false;
>> +
>>   	do {
>>   		done += fec_enet_rx(ndev, budget - done);
>>   		fec_enet_tx(ndev, budget);
>> -	} while ((done < budget) && fec_enet_collect_events(fep));
>> +	} while ((done < budget) && !fep->rx_err_nomem &&
>> fec_enet_collect_events(fep));
> 
> Is the condition "!fep->rx_err_nomem" necessary here? If not, then there
> is no need to add this variable to fec_enet_private.

For my test case it often seems to loop forever without making any 
progress unless I add that condition.

> One situation I am concerned about is that when the issue occurs, the Rx
> rings are full. At the same time, because the 'done < budget' condition is
> met, the interrupt mode will be used to receive the packets. However,
> since the Rx rings are full, no Rx interrupt events will be generated. This
> means that the packets on the Rx rings may not be received by the CPU
> for a long time unless Tx interrupt events are generated.

These are the types of things I was worried might exist with my patch.

> Another approach is to discard the packets when the issue occurs, as
> shown below. Note that the following modification has not been verified.
> 
> -static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> +static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>                                  struct bufdesc *bdp, int index)
>   {
>          struct page *new_page;
>          dma_addr_t phys_addr;
> 
>          new_page = page_pool_dev_alloc_pages(rxq->page_pool);
> -       WARN_ON(!new_page);
> +       if (unlikely(!new_page))
> +               return -ENOMEM;
> +
>          rxq->rx_skb_info[index].page = new_page;
> 
>          rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
>          phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
>          bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
> +
> +       return 0;
>   }
> 
>   static u32
> @@ -1771,7 +1775,10 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>                                          pkt_len,
>                                          DMA_FROM_DEVICE);
>                  prefetch(page_address(page));
> -               fec_enet_update_cbd(rxq, bdp, index);
> +               if (fec_enet_update_cbd(rxq, bdp, index)) {
> +                       ndev->stats.rx_dropped++;
> +                       goto rx_processing_done;
> +               }
> 
>                  if (xdp_prog) {
>                          xdp_buff_clear_frags_flag(&xdp);

Thanks for the suggestion. I had considered something similar but I was 
not sure it was safe to just jump to rx_processing_done at that point in 
the code. I will try your patch and if it seems to work okay I will 
submit a new version.

I probably will not have time to work on this further until the new year.

Kevin

