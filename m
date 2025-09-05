Return-Path: <netdev+bounces-220449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDEB46017
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978EF5C5BBD
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64837C0EC;
	Fri,  5 Sep 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="s3FkVBk4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2101.outbound.protection.outlook.com [40.107.94.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209473191B1;
	Fri,  5 Sep 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093135; cv=fail; b=kFkcU+o9f5F0YSONJmeNyexz8uUi36eXsJ+JCgG9E0u5PDFq4dWfX/lBXQ869XdmjprqVm6D7oyD7nHuH9gSyfW925JKnSR6uDd7wZ0xXCaI7etpZV1IWKMZtR5sed51YUVeNse9NX4gDTCaFnEaTIGyEIyNHNqd8sPAW8SYc80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093135; c=relaxed/simple;
	bh=D6gW60LKlSX8zhwUIZ4k4QDrrpzuy+c1Zo7KsWeKsfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LeKA9axCKT8THw5xuNknUre0/9YOtWbcvauWG8n9413kE234ks5MeIPlQIswykv5a00lco5EmEX6lOnO1bpSsbqBhmfqysF4suWH+BSvBoBD5u4fiXA7VSYmLGAcMUBEBjil0SLr2dSqfghprnV5S456M61Ql6Z5fflBZ71AiEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=s3FkVBk4 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQmC8+zUMNxuwF0qSvPlI66flb63iDFHr26vZpwxX8/uBg6mrWPzAZSHs2VtPkt852nFfENCX/My8Wno22vWaMYIGpdweQ+ftBaD0RbqNZF3XScxRG231TrZ6xg5PwG8YE8TnLRU5ontvvlqyG4l8Q7R2xP23/VcInEui0G85oMNEu2jwVvOEe4TBvDR2+55rE8NdW2F9xYCC3cUR3EpEuGd4M+MFbtzRb3U5DKi6EflGg9o6pn+FHC+Hng06Uh3Ousg/9PkWMJN8hi/lJW6lAbbtqQ9CQF0J/GWQvaauKpovfW2N+AtjPN/YeocO+PzEyofZczwVh2syqxqmNT/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbvfhL7R7C13C1IdmF/sOxcJjrDRN3qLoGBwESwE9WQ=;
 b=GrqFx4rXFVVQt8GN4GFfwpOugMpQ2/DjQWANykT+cH5vYTKGvFvd387ffdJttEuojr+fA39Fm1KZEDfR8U2SOCyy2UHNrYm4I3OlR9DlGoFJ7Xmn47YtSJpnEfNX4My2+bTj/BNQEuLs18DQCG7l2NI0yTN67ZAsWiPpPdw9asGbnNboLAmVKKL553QVopR8KKq7i6IEqkfTVMe4XtZnnZVEwYjOxPlDvscNFTLPjPJmwP8ezb35zEyNYKcP8DGSm3o0EUpBxJgiSiucTX6+CK1vdJWkApxU1UtnGrvUzEolbyxI6mGoxJLXOCsFnaWliJyBj3WGBM3kYFABq/pd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbvfhL7R7C13C1IdmF/sOxcJjrDRN3qLoGBwESwE9WQ=;
 b=s3FkVBk4ai3zEiYrBVOZUerhRBJ98ABaBlPIa6AcBP1NT3lJPiAhskO6bZvl4927FfNmfcpXzeOUrLkgZktUTeKdaZqNF5XCp7gXBoBIS8r+3FAB1DqTa4vq04brJGpmL0fTJRPPCkXxlCtDFeO7IQK3pGnwUV7oW6NTXXDu7qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DM8PR01MB7157.prod.exchangelabs.com (2603:10b6:8:e::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Fri, 5 Sep 2025 17:25:29 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 17:25:29 +0000
Message-ID: <92cd81ad-5454-4375-bd68-f0aa4bd4f439@amperemail.onmicrosoft.com>
Date: Fri, 5 Sep 2025 13:25:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, admiyo@os.amperecomputing.com,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
 <20250827044810.152775-2-admiyo@os.amperecomputing.com>
 <25237d53-a93d-4c1f-a7a4-4b6ed03e10e4@oracle.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <25237d53-a93d-4c1f-a7a4-4b6ed03e10e4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DM8PR01MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6799547a-6cb9-40fa-5c7b-08ddeca135e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzY5aEhrSktuR1JOdW5SVnFGYXRhdlBvT21KYkhQdTR6WDg0Q1NVbTVBVVdO?=
 =?utf-8?B?Qng5UnZCRFJjOUNtL0pQTStRb3hnOUtKT3BUbFFocDREMnN3QjMvNzlRSWpr?=
 =?utf-8?B?SitXQ0ZyNWUxcGpYYXdDcFdqQzhXaVo0L3J3NW1yVkZMRkZZemd6L3kyV3dy?=
 =?utf-8?B?K2hXblZJNHJ4ZzVxQ3c2QnU2cWhrWHg2dGFLVDl0RDhYRGwxUkhLMWFMUk1H?=
 =?utf-8?B?Wk9ta3EyN25jNWRUMk95ZlR1emZXTW9XbldHWGlGMFdmd1Rlcm1IUEYzb0hI?=
 =?utf-8?B?QU41a1Z1Q09adU54dUM4NUoxZ214ZU1mM2tzSjdMclJKcFpIa0VDWVNrZk05?=
 =?utf-8?B?RDFZaEp4N2ZDMVg3YSthRjFXNzR6RFEwVkZQTG01emxFNmZDNE9rVGQwUlY0?=
 =?utf-8?B?bTQralBLMjg4R3UzNDhtTklkWXhKUlpvWjVON0t2Vm95Q1JSMzFuZjNpSHJu?=
 =?utf-8?B?TmtaWVJXcFpzY1Zia05Kc3VCajUrOWhveFNVUjQyQTkxN1BOcEdlZkMyQ20v?=
 =?utf-8?B?bGh0Y1hYdndRMjJJNWlLeGEvek13cmMzMXJ5MWNPY3M2a0hwNFRLUjhGWWNV?=
 =?utf-8?B?dEdBZFBYOXdvaVFYVVoyWlJ0dlJWM3M1aWxvSmg1QnNFTk03emtkYnRZQnkw?=
 =?utf-8?B?bklwNi9vZHE0S015NmNuRmxNZHhpejMzeGErTVZoc1Nlb0UyUU9yUWRiZlJs?=
 =?utf-8?B?Znc2MXNiWnhFdGIwYWhmb0dWNGljTzk5dFlURnN4ZjRsRXBocjB1YXBKUXhW?=
 =?utf-8?B?KzJxcU5Ha1VzM3BvMG5KakMyc0RkRXJ5cWFVTEhZY0lvMStxVzd3aFhpTENW?=
 =?utf-8?B?RjE1Sk4vVTJ2Q1dNd3BIcW1VKzNNMGlaVVJWOENHMjZHM29FdEtnNStHU2lC?=
 =?utf-8?B?V1NVcWxnaEhnR0ZPWU55RWEwVXV4TldTOWQzNmxQS3JWWFFxMFNhRFBXOFBm?=
 =?utf-8?B?YkNWRjRLdDRxOTR2LzVmWFg2dm0wVDltVGVXQmQ5UDZzL2F2dlJzUzA1b1Uv?=
 =?utf-8?B?cU9Sd29CZlo5QUdqdkdFL3p3S2x6bUpWTlEzMFVyY2FtQXArWnFnT0dKSkZt?=
 =?utf-8?B?Ym5hQzlXYWxWYVZDSWNsalRzZW9PSExRWlpaMkl5NTVxM2dlOWN1c3p1dFN0?=
 =?utf-8?B?eUJOZmVQS0xkMkV2REJ3RmdjZXYxNDBnUkRSNWgxZ1Faa0xzWEdMNU5lWVZx?=
 =?utf-8?B?NWY5S21mUExuZm9VRFpBOE1DN0ZYYWpTL05tajRzOENrUDNTeFF1ZkxXUlZt?=
 =?utf-8?B?YmtOZWR6VTQ5RXBVYWMxdWFHaVNLTTVHY1BoK1RkbFFneWhVdkUyWGxqWkdu?=
 =?utf-8?B?Sm5YeC9vaHZPZjdBa0haK2x1VnZXeUUwVHJJK28yL1lNY2lxeTB0d2cwRkkz?=
 =?utf-8?B?VjlkWXN3SmFJRDhBa2k0NStYRUppTWVIbGZaL0toUFpyK0tWNlJDZzVGclVi?=
 =?utf-8?B?S0xNU1hvTnBuL1VjcEVtWmJXRmdlVHFJc2FZU1hVK2V4V0pKblpoSU5VL3pk?=
 =?utf-8?B?SVFYMnQzK2ZNUlpwcUZjd3grSTVWeXJOZlA0R21IMDhTdTFtSWRISHNWTkU0?=
 =?utf-8?B?Rk0vTWZwTllkSm85Mmk3SWU3Vk9nM1ZaS3EvdDVRVGFrL213MDA1ODlYS3M0?=
 =?utf-8?B?blAzOVZ3aDJGMm5uaGtYSkZGTUZIeEQ4ZUVYQWVNSzBkUkFrZDRjSVdrYW9r?=
 =?utf-8?B?ZytwTkRsZU9yYzdGcXJ4Wjk0Vkd5NmtXWjViRjVUdlFVYmRkS1dwdHRSc3dT?=
 =?utf-8?B?YzY1akg0RjR5ZXVtUWNvSjdMeXA2eWFuSWdSaWIwSFVGbnNDZERSdEU2QVo2?=
 =?utf-8?Q?fcGWGsCLYuGylbYC1HmApW8SSMvv0OpRYBFKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNaNlZxSGxsS2xIVmpidUJUNUQwdG5RR0QxRzBtNnltUnMxYTdPbEtlT2Mx?=
 =?utf-8?B?K0EyVm5TZkFrT3ZpOFY0VnJ0dnVpN0ZRYy9zb0FaTlpoY0xKOTAyQk5ZMnJO?=
 =?utf-8?B?NjZHNWNDOS9LR2ZPbjk4ZlU2YU4vUnlxQkUwTnExcFZCVTRwcFZmNGh3NXZ4?=
 =?utf-8?B?S01NNkUrTnFKc3AyZ1dxNjdGKzg2blpwRUUwSG8ybzd1d2pIY2hiSVdEeFl4?=
 =?utf-8?B?WFBHK1RpWmhGMXZYaW5PNS9QUktRaW44ZWFoSE1WQXlHM3BvdGRSSWFwbGpj?=
 =?utf-8?B?bThjSnNDYWV5aDh3eld4R1FtRXJ1cnZYbWY4RDJpT0R0R0JyWFRXODJVbnQ0?=
 =?utf-8?B?bVVNdjZhN0RRQWpjSXAxSGo0SXpJU25Wa09QcXJzcXZvTlNDVEQ1NU5lZDRR?=
 =?utf-8?B?OHJTak94ODQxZGt2Q2ZuaURyTmVBQkFDbzhPaytFVWI2QkRCd3prKzQxMS9S?=
 =?utf-8?B?LzdKQmtXVzRJSTlvWU5jTEdVb0NZWUdoRzlYZW9uVGhLSndnQm1Pc2l6VTVI?=
 =?utf-8?B?MXgxMmI5SzVTNkRNRUVwUFpVWEtXSVNzbkRKMWR6VktwcXB0U1huRGp1YnJr?=
 =?utf-8?B?aWtmcU9xdUx2dzhmMk5wMjljVmgxcWw3THpJMUs4cTEvUU9RN3ZUWExTZ1Vp?=
 =?utf-8?B?aEcralpLbkM0c0YwMFNRaWI5SmlpMVQ1bVBmSmVnQ3l5ZzBuVzF5SzB6WXc2?=
 =?utf-8?B?WE1uaXpiVVNGUUpMakQraUoxdHg4S25HUGdNNkkrbzR3ZjVhb1E1NGRoSXVZ?=
 =?utf-8?B?WHUwZVNpaXJoNWlYSGt1T3JDUmxhdDlJK0lnQ0o0Mmx1dUtHbTRCZjh2a2RI?=
 =?utf-8?B?d3FUWkhOZndlQktXOTJ5bHV6cHlhZHRsZFFDZDVUbkxoazY1Umg3eHJkMG1k?=
 =?utf-8?B?SURVeXRudkc1dlhBcGRMeVJWNFJZOHBnaXdoOEZQRXRxYVc4MlBiT3ZUUUly?=
 =?utf-8?B?REhyMThPQzY2bTU1ZElpV0Nlb3IxWFVXZUpXNmtvR0VIemZRZWNuSzNhWFR4?=
 =?utf-8?B?Uml6U1Q5VXJyVktUZGVhdlh0VmlCVU53cFBEcHM3NnBIYVB2SlZmcldUSjB0?=
 =?utf-8?B?dXV6WCtwS2dhUDM0S3FFakdOL0U5NTZ4UFRkb0hFVzlvbUJjMnN1bW5uTHdU?=
 =?utf-8?B?ZTlRbDdUb0pZN2JRZ0oweVUwb2tXbEJYVGIrT2RFQXlPZlNrbG9YVUFDQVly?=
 =?utf-8?B?LzZrNSsvNjBWUVRiUmVtaEdScGhPYWlXU3pBeEc4RHV5RUpMdWFod0hMNUZ3?=
 =?utf-8?B?cW1YUEowa0lMZ2xaa1MzaTJqTkZZc3FDUFVrK1FWYUE2enRWaU5yS09LeExE?=
 =?utf-8?B?U2dnbEdUM3cxQk15RS9pZ09CMnIwaGRqTXhZOTNXYjBwd3k5UXkwTUI4cDM0?=
 =?utf-8?B?b1FabU1XRkRIM2QyM1J0ODNMRkNySXp2Z3R2S1hkQy9KMitDSEZKcVdCbGtQ?=
 =?utf-8?B?TjFLbEJXdzRRYmpBNmZySHEyVDZ3dW52ZlZUZzI5UlVuT3dJNmZacWswZGRC?=
 =?utf-8?B?VHVtQWpkTkJ4akkvZkR4M0hPUnB5SDlkUzNtODhLdVFyWjRueWhuWURxR2RZ?=
 =?utf-8?B?S2ZjajlzUjlxNlhJQ1lqandJN3ZOMTBoUE5wd3o0ZTcwRXRyQlNwU2UxRXpq?=
 =?utf-8?B?aXkvR2VTeVZpU2hlSjZDQzhTbzJ3d0kzQU1GRVFZWVM1NDhsNjZmVU9mdE1K?=
 =?utf-8?B?UUFSY0FWSGFPbHVrV2xPcVZaeStYK3ppb1NLM2wwbklkM3VVazhid1YzTDlz?=
 =?utf-8?B?RS82UTFnNWtDd0pXZnlYYWEwUW1VWSs3a3ZvNDRiMHZlcTdObWpKSjFPUWpC?=
 =?utf-8?B?UVhnYTdqTTM2RG1ZRXNFa2lQYlIyMUczaGlZMW9FS25acVhPcjAwdTVHQ08x?=
 =?utf-8?B?M3dzbFVHamoyVm1EalFtcGd6SkxBWHVsMlFMbGNrbEhMcmZBaGhyWmg5MnNN?=
 =?utf-8?B?RlFNYTdvcWVyVm9Wa1JqRHJzSzZwQXRhTTd2QTUyQnJnMWF6eURTNHJuSnlx?=
 =?utf-8?B?LzhtcmZYOGl2M01rMkxHWmRLRisxOEJNTlNoU082WDloVFZsRG55L1VsWGpC?=
 =?utf-8?B?RGF6VzcxUVZkbnRuQzJEOWUyZ096S3ZjQXM2Z0twRFdWUFNoZk1VNDBKRFJO?=
 =?utf-8?B?N2VEVlRmZmZFcEdpWTlYR3hVQTk4TXRVNWcrYUdrQVcrY2VkcmlQNzN6Umtr?=
 =?utf-8?B?bkprTVpTWmVtK2dPL2w2VFUzR2E5YkxUVFNjb2EwcTBqblZzK25ZdEZnTmhW?=
 =?utf-8?Q?zFSRy66JRcFr9wZc4GPNXw4S5BDUhGTt1mKlmlsVZM=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6799547a-6cb9-40fa-5c7b-08ddeca135e4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 17:25:29.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Voy0GzNv4IZOhy3w1k9DxeYHQSR+Us9tQmnAi+w61nlkTlOI5s0lOJ+2JtmXcRl643NsYLRSPhlZvDMu4cczM3vsJW01WRWc+y4KZsSjQ3yqXDd2l8r5fHf3Axu3x7Rk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7157


On 8/29/25 15:32, ALOK TIWARI wrote:
>
>
> On 8/27/2025 10:18 AM, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@os.amperecomputing.com>
>>
>> Implementation of network driver for
>> Management Control Transport Protocol(MCTP)
>
> it is Management Component Transport Protocol (see DMTF spec).

How  have I missed this this past year?  Thanks.

>
>> over Platform Communication Channel(PCC)
>>
>> DMTF DSP:0292
>> https://urldefense.com/v3/__https://www.dmtf.org/sites/default/files/standards/documents/*__;Lw!!ACWV5N9M2RV99hQ!JkW80M1xGJjvaXd72o192mqV0uzOu511ibGTz-JCtmbsM_IrpuZ0jJeeQFOug5UHp8fNY1dX2Lk0_hPUUY__KokwgtE$ 
>>
>> DSP0292_1.0.0WIP50.pdf
>>
>> MCTP devices are specified via ACPI by entries
>> in DSDT/SDST and reference channels specified
>
> SDST -> SSDT

My mnemonic is Same Stuff, Different Table.  Thanks.


>
>> in the PCCT.  Messages are sent on a type 3 and
>> received on a type 4 channel.  Communication with
>> other devices use the PCC based doorbell mechanism;
>> a shared memory segment with a corresponding
>> interrupt and a memory register used to trigger
>> remote interrupts.
>>
>> This driver takes advantage of PCC mailbox buffer
>> management. The data section of the struct sk_buff
>> that contains the outgoing packet is sent to the mailbox,
>> already properly formatted  as a PCC message.  The driver
>> is also responsible for allocating a struct sk_buff that
>> is then passed to the mailbox and used to record the
>> data in the shared buffer. It maintains a list of both
>> outging and incoming sk_buffs to match the data buffers
>
> outging
Thanks
>
>>
>> When the Type 3 channel outbox receives a txdone response
>> interrupt, it consumes the outgoing sk_buff, allowing
>> it to be freed.
>>
>> Bringing the interface up and down creates and frees
>> the channel between the network driver and the mailbox
>> driver. Freeing the channel also frees any packets that
>> are cached in the mailbox ringbuffer.
>>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   MAINTAINERS                 |   5 +
>>   drivers/net/mctp/Kconfig    |  13 ++
>>   drivers/net/mctp/Makefile   |   1 +
>>   drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 386 insertions(+)
>>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bce96dd254b8..de359bddcb2f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14660,6 +14660,11 @@ F:    include/net/mctpdevice.h
>>   F:    include/net/netns/mctp.h
>>   F:    net/mctp/
>>   +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) 
>> Driver
>> +M:    Adam Young <admiyo@os.amperecomputing.com>
>> +S:    Maintained
>> +F:    drivers/net/mctp/mctp-pcc.c
>> +
>>   MAPLE TREE
>>   M:    Liam R. Howlett <Liam.Howlett@oracle.com>
>>   L:    maple-tree@lists.infradead.org
>> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
>> index cf325ab0b1ef..f69d0237f058 100644
>> --- a/drivers/net/mctp/Kconfig
>> +++ b/drivers/net/mctp/Kconfig
>> @@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
>>         MCTP-over-USB interfaces are peer-to-peer, so each interface
>>         represents a physical connection to one remote MCTP endpoint.
>>   +config MCTP_TRANSPORT_PCC
>> +    tristate "MCTP PCC transport"
>> +    depends on ACPI
>> +    help
>> +      Provides a driver to access MCTP devices over PCC transport,
>> +      A MCTP protocol network device is created via ACPI for each
>> +      entry in the DST/SDST that matches the identifier. The Platform
>
> should be DSDT/SSDT ?
Yes
>
>> +      communication channels are selected from the corresponding
>> +      entries in the PCCT.
>> +
>> +      Say y here if you need to connect to MCTP endpoints over PCC. To
>> +      compile as a module, use m; the module will be called mctp-pcc.
>> +
>>   endmenu
>>     endif
>> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
>> index c36006849a1e..2276f148df7c 100644
>> --- a/drivers/net/mctp/Makefile
>> +++ b/drivers/net/mctp/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..c6578b27c00c
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,367 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2025, Ampere Computing LLC
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>
> DSP0256 vs DSP0292 mismatch

292 is MCTP over PCC

https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

256 is Redfish.  What is the mismatch?


>
>>
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/hrtimer.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +#include <acpi/pcc.h>
>> +
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_DWORD_TYPE          0x0c
>> +
>> +struct mctp_pcc_mailbox {
>> +    u32 index;
>> +    struct pcc_mbox_chan *chan;
>> +    struct mbox_client client;
>> +    struct sk_buff_head packets;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +    struct net_device *ndev;
>> +    struct acpi_device *acpi_device;
>> +    struct mctp_pcc_mailbox inbox;
>> +    struct mctp_pcc_mailbox outbox;
>> +};
>> +
>> +static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct mctp_pcc_mailbox *box;
>> +    struct sk_buff *skb;
>> +
>> +    mctp_pcc_ndev =    container_of(c, struct mctp_pcc_ndev, 
>> inbox.client);
>> +    box = &mctp_pcc_ndev->inbox;
>> +
>> +    if (size > mctp_pcc_ndev->ndev->mtu)
>> +        return NULL;
>> +    skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +    if (!skb)
>> +        return NULL;
>> +    skb_put(skb, size);
>> +    skb->protocol = htons(ETH_P_MCTP);
>> +    skb_queue_head(&box->packets, skb);
>> +
>> +    return skb->data;
>> +}
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void 
>> *buffer)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct sk_buff *curr_skb = NULL;
>> +    struct pcc_header pcc_header;
>> +    struct sk_buff *skb = NULL;
>> +    struct mctp_skb_cb *cb;
>> +
>> +    mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, 
>> inbox.client);
>> +    if (!buffer) {
>> +        dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +        return;
>> +    }
>> +
>> +    spin_lock(&mctp_pcc_ndev->inbox.packets.lock);
>> +    skb_queue_walk(&mctp_pcc_ndev->inbox.packets, curr_skb) {
>> +        skb = curr_skb;
>> +        if (skb->data != buffer)
>> +            continue;
>> +        __skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
>> +        break;
>> +    }
>> +    spin_unlock(&mctp_pcc_ndev->inbox.packets.lock);
>> +
>> +    if (skb) {
>> +        dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
>> +        skb_reset_mac_header(skb);
>> +        skb_pull(skb, sizeof(pcc_header));
>> +        skb_reset_network_header(skb);
>> +        cb = __mctp_cb(skb);
>> +        cb->halen = 0;
>> +        netif_rx(skb);
>> +    }
>> +}
>> +
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct mctp_pcc_mailbox *box;
>> +    struct sk_buff *skb = NULL;
>> +    struct sk_buff *curr_skb;
>> +
>> +    mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, 
>> outbox.client);
>> +    box = container_of(c, struct mctp_pcc_mailbox, client);
>> +    spin_lock(&box->packets.lock);
>> +    skb_queue_walk(&box->packets, curr_skb) {
>> +        skb = curr_skb;
>> +        if (skb->data == mssg) {
>> +            __skb_unlink(skb, &box->packets);
>> +            break;
>> +        }
>> +    }
>> +    spin_unlock(&box->packets.lock);
>> +
>> +    if (skb)
>> +        dev_consume_skb_any(skb);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct 
>> net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +    struct pcc_header *pcc_header;
>> +    int len = skb->len;
>> +    int rc;
>> +
>> +    rc = skb_cow_head(skb, sizeof(*pcc_header));
>> +    if (rc) {
>> +        dev_dstats_tx_dropped(ndev);
>> +        kfree_skb(skb);
>> +        return NETDEV_TX_OK;
>> +    }
>> +
>> +    pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +    pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +    pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +    memcpy(&pcc_header->command, MCTP_SIGNATURE, 
>> MCTP_SIGNATURE_LENGTH);
>> +    pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +    skb_queue_head(&mpnd->outbox.packets, skb);
>> +
>> +    rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
>> +
>> +    if (rc < 0) {
>> +        skb_unlink(skb, &mpnd->outbox.packets);
>> +        return NETDEV_TX_BUSY;
>> +    }
>> +
>> +    dev_dstats_tx_add(ndev, len);
>> +    return NETDEV_TX_OK;
>> +}
>> +
>> +static void drain_packets(struct sk_buff_head *list)
>> +{
>> +    struct sk_buff *skb;
>> +
>> +    while (!skb_queue_empty(list)) {
>> +        skb = skb_dequeue(list);
>> +        dev_consume_skb_any(skb);
>> +    }
>> +}
>> +
>> +static int mctp_pcc_ndo_open(struct net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev =
>> +        netdev_priv(ndev);
>> +    struct mctp_pcc_mailbox *outbox =
>> +        &mctp_pcc_ndev->outbox;
>> +    struct mctp_pcc_mailbox *inbox =
>> +        &mctp_pcc_ndev->inbox;
>> +    int mctp_pcc_mtu;
>> +
>> +    outbox->chan = pcc_mbox_request_channel(&outbox->client, 
>> outbox->index);
>> +    if (IS_ERR(outbox->chan))
>> +        return PTR_ERR(outbox->chan);
>> +
>> +    inbox->chan = pcc_mbox_request_channel(&inbox->client, 
>> inbox->index);
>> +    if (IS_ERR(inbox->chan)) {
>> +        pcc_mbox_free_channel(outbox->chan);
>> +        return PTR_ERR(inbox->chan);
>> +    }
>> +
>> +    mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
>> +    mctp_pcc_ndev->outbox.chan->manage_writes = true;
>> +
>> +    mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
>> +        sizeof(struct pcc_header);
>> +    ndev->mtu = MCTP_MIN_MTU;
>> +    ndev->max_mtu = mctp_pcc_mtu;
>> +    ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +    return 0;
>> +}
>> +
>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev =
>> +        netdev_priv(ndev);
>> +    struct mctp_pcc_mailbox *outbox =
>> +        &mctp_pcc_ndev->outbox;
>> +    struct mctp_pcc_mailbox *inbox =
>> +        &mctp_pcc_ndev->inbox;
>> +
>> +    pcc_mbox_free_channel(outbox->chan);
>> +    pcc_mbox_free_channel(inbox->chan);
>> +
>> +    drain_packets(&mctp_pcc_ndev->outbox.packets);
>> +    drain_packets(&mctp_pcc_ndev->inbox.packets);
>> +    return 0;
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +    .ndo_open = mctp_pcc_ndo_open,
>> +    .ndo_stop = mctp_pcc_ndo_stop,
>> +    .ndo_start_xmit = mctp_pcc_tx,
>> +
>> +};
>> +
>> +static void mctp_pcc_setup(struct net_device *ndev)
>> +{
>> +    ndev->type = ARPHRD_MCTP;
>> +    ndev->hard_header_len = 0;
>> +    ndev->tx_queue_len = 0;
>> +    ndev->flags = IFF_NOARP;
>> +    ndev->netdev_ops = &mctp_pcc_netdev_ops;
>> +    ndev->needs_free_netdev = true;
>> +    ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>> +}
>> +
>> +struct mctp_pcc_lookup_context {
>> +    int index;
>> +    u32 inbox_index;
>> +    u32 outbox_index;
>> +};
>> +
>> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
>> +                       void *context)
>> +{
>> +    struct mctp_pcc_lookup_context *luc = context;
>> +    struct acpi_resource_address32 *addr;
>> +
>> +    if (ares->type != PCC_DWORD_TYPE)
>> +        return AE_OK;
>> +
>> +    addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
>> +    switch (luc->index) {
>> +    case 0:
>> +        luc->outbox_index = addr[0].address.minimum;
>> +        break;
>> +    case 1:
>> +        luc->inbox_index = addr[0].address.minimum;
>> +        break;
>> +    }
>> +    luc->index++;
>> +    return AE_OK;
>> +}
>> +
>> +static void mctp_cleanup_netdev(void *data)
>> +{
>> +    struct net_device *ndev = data;
>> +
>> +    mctp_unregister_netdev(ndev);
>> +}
>> +
>> +static int mctp_pcc_initialize_mailbox(struct device *dev,
>> +                       struct mctp_pcc_mailbox *box, u32 index)
>> +{
>> +    box->index = index;
>> +    skb_queue_head_init(&box->packets);
>> +    box->client.dev = dev;
>> +    return 0;
>> +}
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +    struct mctp_pcc_lookup_context context = {0};
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct device *dev = &acpi_dev->dev;
>> +    struct net_device *ndev;
>> +    acpi_handle dev_handle;
>> +    acpi_status status;
>> +    char name[32];
>> +    int rc;
>> +
>> +    dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
>> +        acpi_device_hid(acpi_dev));
>> +    dev_handle = acpi_device_handle(acpi_dev);
>> +    status = acpi_walk_resources(dev_handle, "_CRS", 
>> lookup_pcct_indices,
>> +                     &context);
>> +    if (!ACPI_SUCCESS(status)) {
>> +        dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
>
> FAILURE to lookup -> failed to lookup

OK


>
>> +        return -EINVAL;
>> +    }
>> +
>> +    snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
>
> mctp_pcc%d ?

No as per Jeremy Kerr's suggestion.


>
>> +    ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, 
>> NET_NAME_PREDICTABLE,
>> +                mctp_pcc_setup);
>> +    if (!ndev)
>> +        return -ENOMEM;
>> +
>> +    mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +    /* inbox initialization */
>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>> +                     context.inbox_index);
>> +    if (rc)
>> +        goto free_netdev;
>> +
>> +    mctp_pcc_ndev->inbox.client.rx_callback = 
>> mctp_pcc_client_rx_callback;
>> +
>> +    /* outbox initialization */
>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
>> +                     context.outbox_index);
>> +    if (rc)
>> +        goto free_netdev;
>> +
>> +    mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
>> +    mctp_pcc_ndev->acpi_device = acpi_dev;
>> +    mctp_pcc_ndev->ndev = ndev;
>> +    acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +    /* ndev needs to be freed before the iomemory (mapped above) gets
>> +     * unmapped,  devm resources get freed in reverse to the order they
>> +     * are added.
>> +     */
>> +    rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>> +    if (rc)
>> +        goto free_netdev;
>> +
>> +    return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
>> +free_netdev:
>> +    free_netdev(ndev);
>> +    return rc;
>> +}
>> +
>> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
>> +    { "DMT0001" },
>> +    {}
>> +};
>> +
>> +static struct acpi_driver mctp_pcc_driver = {
>> +    .name = "mctp_pcc",
>> +    .class = "Unknown",
>> +    .ids = mctp_pcc_device_ids,
>> +    .ops = {
>> +        .add = mctp_pcc_driver_add,
>> +    },
>> +};
>> +
>> +module_acpi_driver(mctp_pcc_driver);
>> +
>> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
>> +
>> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
>
> Thanks,
> Alok
>

