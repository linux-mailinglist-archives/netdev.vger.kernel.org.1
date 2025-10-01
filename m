Return-Path: <netdev+bounces-227431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733DDBAF24E
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 07:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED2519267B7
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 05:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AEC246333;
	Wed,  1 Oct 2025 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="CNbGa+ND"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9156B81;
	Wed,  1 Oct 2025 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759296352; cv=fail; b=d9WrEBNP3+5IuC9fWdzIP9nYcK8Fanb878HCM5SOctRy2hUsjMTntsVuPBD2LJnizsAzMyRK3kQs/XXOItZbNj543OfkIVGwc1VsmVoq4bTKS742wjysx09onAIhzWSpz8xAoG+LauGzwzMXF7id9OyDQkfC7QywWomoN+Wx2bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759296352; c=relaxed/simple;
	bh=X4DcxO45q1DA+A4sLWBCYnw7KXpYI7YM2SzgHDa2QrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MEmMOttRFPeZi6njokTBIjt0qiPlzYqTCXMBoszim/x5UvShi8V5xdbmxnDvdRPoA5010inATYwuApARa8YggUuUy1ESrEiH0E7LW26CqGt1xue6Ki6ZPg6tZCqzfyPa5YCn56q+QLHR+8qTAkmZ5qv0a1fB49vtqYksLi3s7/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=CNbGa+ND reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.201.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC4i0xjmbtP6j3lCQqZJzTZn/ypYMG2Xe3TD8GewIpqpGbp487ENEZVo/7q2D0g3MhQ8yaK2jjQLPtthZJZEd+x0Fdj27MfZ+8nQz4GNSfRRNxElLxppcfYtHAbroAeXBShIpli4iVkPTJdKE4HKltK/Q727iYLMEQ8CZPw+7MpSZMYliYi6V14otYt5LB4n7qGJlwdBB8MrC2Tce8M/ebyVRF3NXQGnr34kzqC72jAKJXRqdU+dI23JCxMsHy9gLqbPLf8yHumk9dMr0biF1S2jKv7Jc9Ma70YMvEIgaVEd/n5cdyvLiy7DSa2F5c4lCagZ3Akj5iCmPQapyoxtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8XPha4Sn/juP8U+hvdbpvF1adZG9DGWhFZUkG9QeeQ=;
 b=lyTkmVObl0pf/iKHWOpWH9Dtusxb19PAe2IM61hyX2PlyyTGJTAc2FKBSaVwfY9EP8rajgLxYT/F95JUX70Y5mV93iVI+1cqekJFJH8zgmHTACne5hu05t7CCGVZeYahCnZXWgSYGDP6LIBwRdf1Qn46iDLH784eq2yKMaDQrJRe3mZGnxJuozqWADCQwtMkmHZ/A11S0P7pX1uPwibmsMjgSF1GV6ZXU6BWGUeFU9h/OG40oygirD6EKtDw4MSs8qMT9QjHQtpQccK/PVAxlMpIyip5UHStrcsQ6iFbrQWbhgagJCKH/3kvs7KNCeAH2pXO+w3DVUSx+AgUY2W8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8XPha4Sn/juP8U+hvdbpvF1adZG9DGWhFZUkG9QeeQ=;
 b=CNbGa+NDert2/IPzcE6ES/17FNPQxpTdSNTRa3zP5dINFgxOX+gWgGVmHp/QxIaxkMYHOsXjAmWNWS24Ktpm9sZnsHz3AW6iAVB13rCXuy5NAytbB5vWmomogRLcDqETgcV3Nr19uJ2LvLK5X5wKPusp/FKZaobMe9UpwzONmA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB6207.prod.exchangelabs.com (2603:10b6:a03:29d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Wed, 1 Oct 2025 05:25:46 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 05:25:46 +0000
Message-ID: <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
Date: Wed, 1 Oct 2025 01:25:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:930:4f::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 324e450e-0d5e-4460-9bce-08de00aaf93f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b00zZTFjem1TK0RtUlBhRW1rQ1E1dHZwMG1LMjNGOStVcVJ1YlJ0R2NZckxq?=
 =?utf-8?B?U0VWUkRmcTRldlNrTEFBS3JSYU1COGNKV1V2MStWNlhHbkNzUGdRVVUvMWEv?=
 =?utf-8?B?T09Xc1dVZ0lJdFZyQyswcFFLUmlVWS8xU1MrUW80TlJHejJOMkFMV0tmNmRT?=
 =?utf-8?B?WW1KVUlJa3ZZQjdRSXVXVzRKNVJ0UmJ4dzlPdmZWRi85RFVkWE84elhkYmtV?=
 =?utf-8?B?aDNJV2ZwWDZraGVQM3VuVUVqWFk5anVuSW43UW9mRGtieU5aSlIwcGM0Rzh5?=
 =?utf-8?B?L1BEOWpTcllwUWJOdTZxN1lEaWdFeDErR3JlWGpFSlpWR2Y4SHZ4SlhJNXYr?=
 =?utf-8?B?c1dlUkJzN3VxRDZoSUNucFI5L3FFdEIyVjRnWDAweWpnNDdKakc0M3RCTytQ?=
 =?utf-8?B?bjFnaTRQbXN1UlZWQ3RkcFdQdGV5SUE2OFYxbVdQZm13M0dOUC81d1lCQm9Z?=
 =?utf-8?B?NTRsY2I4MnNRZjQvWkl0WmpETk9yOHZJZ2xWY2FBT2ZZVjViYjdHNC8wZ29h?=
 =?utf-8?B?ODhKUFcxWTBsQ2Zacm9vcjA4djdUYXhCU2RlcWppMDFFaXIrTFJVWFlpeUdS?=
 =?utf-8?B?NTh1bWNZUXNWRWhTb1lGcnVZQm8wWVdQcUhlRCtjb0ZIWFJKazBTMEtyYzRL?=
 =?utf-8?B?VC9IYmZVSDRMNGU2a3cyWjdzWWNPQVNmZG5aWnBNMktVdVMrMGZsU2RxY1ZR?=
 =?utf-8?B?V1E2NnJTbEMxUnFZZWEzN1dvYVA0cE5VcXRCVTdvNjRzNjQ2TW9mSEFTckh0?=
 =?utf-8?B?ZVp3cXhmUWJtajU4NEVjNWJvdFYyQy9HSFp4QlFVc043dlg5eU9hZVNDV3Zr?=
 =?utf-8?B?aHVzRkUrVlg1MlE0dVczVG54MGxCelB3ak5WeGRkMkNpeWpBSkNON0czVUdi?=
 =?utf-8?B?RVkxdVg5VURzaFg0WEFxeEdmMklnTmh3UHJsam1kWjh5NVBWcFI3ekdEeC81?=
 =?utf-8?B?eDd5SjV3b01ZQlNmZzg5bFRzOXJUM05GTlhJeTRac3ZjU1FIRzRXaklEVUk4?=
 =?utf-8?B?Z1FOOElndFBrd1BOL3VEMWt2R1lYelYvYVRpNXMxR2VZazJFTVI1TWZHclc3?=
 =?utf-8?B?QXR6UXlFODZJcVhlMDB6RjdYc0ltQ2xkeUNnS1FJVC9TN2pqK2JiVkJnTC9X?=
 =?utf-8?B?TDRoblg5S3ppUjlVNmVFWEtxa0ZnTy9GZytxaFlzeVBPeW92WTRkMGxZcU9w?=
 =?utf-8?B?dGFTcnVwdjRCRHF1NnM3R0drL2NxREEwakhIRW1TMGhpa2ZSdWFob1ZtOGx3?=
 =?utf-8?B?Mml1RkdteGgzMlYwRG9xaDVsaGt1Y3RrNzlpRXpRNStXMXorb0UwRkdiZmlS?=
 =?utf-8?B?L3BuVFFSdXQ5cXFHeEFGWWJqcUlhLzRzckwwTmpFcDBoRUhHRlduWjN3UmtM?=
 =?utf-8?B?TU5iaDFiVnVLcERobDZoN3FUTUl4QnF4WStaZEhmM1hJS01MODIyTFlvSFNq?=
 =?utf-8?B?OVQ2U2RQM2VTa25OMFJzN2luKzN2dDNYUnp5K05uQmwyUTd1OFhwU2I1SmQ3?=
 =?utf-8?B?STk1ZVd6Y0RmUzV6eTNQRlhBT0Mxc2VwVG5Za2xpZStScVlEV1c2NVJBVFNh?=
 =?utf-8?B?VkVFdUNCSzRXRVZ1MjNLanBtVktCUVJpTGFjeXFEcjJSTnIrZnd2NDdkeXVE?=
 =?utf-8?B?aVFMRE0wbTRwMk9SdHZsZWo1TnpHZFIwcU1odXQ5cWNrQjlrb2drT3hBRVZk?=
 =?utf-8?B?Uno0ZitYRCs1eDFoejFTWXVNNGhzUmhRVTZESHJQQzROZjhJVmJ5bnNzZzB5?=
 =?utf-8?B?SDlmWlRsUVRIL00vVGcrYzBLYklnTGczODBlSXFCWWxacXdMeEVIb0o5VndM?=
 =?utf-8?B?c2w5WVZOaGk3ZVZDNjNxVmt4QXp6TFNvZDR2YlUzOFRaQWVSSWFPRjY4b2Jl?=
 =?utf-8?B?TFNTdHFLV20vcDI0aDRPWE96UmdOUnhEV0xvNC9iZFZ6RlByc0hZQnl5Lzlt?=
 =?utf-8?Q?+p06eQ0T3Y0d5eMEQCUGDHnamqJUHCCo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRicDFDMDYyb3M3d0hIZnQ5aXI4Ymd3M0tTd2tsSG1rcENYVHIyMnNLbGY5?=
 =?utf-8?B?L21RVVVaSmhyMElYZTNvNGp3d3NSMWJmRkVVdVlTd0hFZ3YvUnUwME1TS0Ra?=
 =?utf-8?B?M0tBRDNraEZyVS9MM2pnWUFOeGFzM0V3V2NCRkd2cjJEcXVRY1lONVdadHBn?=
 =?utf-8?B?M3Z6WGlsTXdHN0FWR1FnR1JuZmtuUG5KbStWVE1TYjUxdDFtK0FEQXZwMGNq?=
 =?utf-8?B?RE5QdzQyQ214by84aG8ycFlGWm9LaGt2Ti85U2tBa2szTEljZzZPKzcxSDd6?=
 =?utf-8?B?bHJmeVI3T3FsSGxsUk5BdklnanBNTi94S2VNZThybDlzSEdUS3JHRlkyVjNy?=
 =?utf-8?B?RTQyUXQzRkFNUTQydjAyRzZNRHR3a2tPam8wSEVOUXdPQnVsaVdieDl6MmNx?=
 =?utf-8?B?U0xobVNoYmhkZ05vcHNySklxRkZUZ2IvRXlzU3pBUjdieSttdWpReEdXZ2s2?=
 =?utf-8?B?YzIwMUs4dlJTNGJKNko4MVZ0Vmk4bkVnTlUzTkVrQkN0Mk1VWHBhOTdPaXBj?=
 =?utf-8?B?T2xkZk1XTkhoMW95WUhkNU9CVHU3SWFEWWJOU042OUh3VjU3cEY2QmZPMGxI?=
 =?utf-8?B?Q3JWNXVGMW5DLzFRVXE5dUNMMUhvcFBIZnVtTEpxZHVxaWhRRjBBWCtqRmV1?=
 =?utf-8?B?MGNCbFhrRkh2cEZYMVo5WnVJUk96dmtFcC9rU2I4Ry8rb3VHNWN2ZUlKcFQy?=
 =?utf-8?B?c0srVlB0cXdOR3ltdmdlQXB0N2tzWTFyNEt1NHNLNmRIMS8veWxUSGc1V2dk?=
 =?utf-8?B?SW5LRGdUZDJnSmUvYmZmWW1BZDh5ZmJzbllnbjd1V2MvUENLeDFMc1BLcC93?=
 =?utf-8?B?a0hiZlBhQWNHM1JOZ1p4Y29qY1ZWK2xZSm12R0U1aXoyQ3NVOVh6c2YxM0FS?=
 =?utf-8?B?Y2xKL251NU9nZGVRelZjNS91ZXNxZUlMSEw5UDBpZTltdDUvT01aSTRad0dN?=
 =?utf-8?B?TVNTdzJOeEFtb3llZlBJUGk3cEdjVmp6aXR4eDdRNTRDYUE2Sjl6YVdURTJB?=
 =?utf-8?B?QTcxNTZpdHZkWUtYUjlVQlFkK2owMnJxV0N4emZzS0RkWklkSHhTNHRiL3lv?=
 =?utf-8?B?YWlhNU00UW1OMWc1Z2JSNFdLWk9JU1IzTk1wU2FaS01iRzdCTjByd1lkeFNo?=
 =?utf-8?B?L05jT0pXNE5ockIwSXBFa0ZhUEtYK3kzN09KVHNicE9MdHlmQldQQ3ROb1A1?=
 =?utf-8?B?VThMaG5IMFd3cXFrdktvLzVySlU0Y2FmM2xTNzIranJDMnJzbktMcWp2MVdN?=
 =?utf-8?B?clJmcXNYYXFFVXRhRExnSWxObnNNL05nRURwaDdTQmVvejRadDNUaGw2RHNi?=
 =?utf-8?B?YldHeFlPS2hRUE5ZOGJwL0llaTZLN0Z5YXE1a3ZIcWpZcWRKNU9MR3BaQ1E5?=
 =?utf-8?B?eVd1UCtFbEhBVTdMM3NJb3JmVlR4MU9TaWd5cGRVSUcxaUJUU1JrSWZzajZG?=
 =?utf-8?B?Y1dnSzRkU2dNZEltbFhOOWhuWEhKYU54a1FmdzBRbUZSeUo5ZHUvWUVNREoy?=
 =?utf-8?B?a3VsTm9yaWpha3QzNVVUbUpEQWpGVFZVem5GanMyMGx4Mk96RnNpdDhLMWxE?=
 =?utf-8?B?M0hiNm9QREtObU5MT2VvbDJtS2pETnlOYnptb2F4MmJ5MzhHSlkrVG1NeG05?=
 =?utf-8?B?TnIrdzNwYit0WFRPNlRWUjlhbU5TQUZRU2FKZk52eERMM0IvdnZQeU90WUll?=
 =?utf-8?B?d1U0WjlmOE1YOGJBSFNtSXpSdDl2dTBsZS9OT0E5QSsxVzNGeUkzUkRaUEtW?=
 =?utf-8?B?WW9WeE1hNThHWS9VRWJ4RmNUQkFPRWpHQlpQVFZYU0V6Q0lnbDl6a0pYQVpJ?=
 =?utf-8?B?SjNJbnNFbnk0OWY0T2hHN2J4RmV3TVdkL3FuSDE5S3UwWlFpUUsvM2MzcVhE?=
 =?utf-8?B?ekxuVGRnTWVzTEtRaFhaT21xYXQ0UU5UWUp6R1FGK3h1RmtUVTJpL1N4d3lt?=
 =?utf-8?B?Y1FyckZyZjZaVXJmL2RkMi96S3doQlQzYVdqVUNrSnpiMXVwQ20vSTRMKzhz?=
 =?utf-8?B?STI2N2RsZktMMGhXcmtDOHZvaWpEa20xQXc5K1NtSGUwS3VkRGVEWTYyRU1S?=
 =?utf-8?B?OWlvNE1jUjRxc2ZNald6VmZnS2FSaGNqbW1lQ2I5LzVUYms3VjExdjlrQzEv?=
 =?utf-8?B?MytES0pvR3NtYjBZMVhrVDhWNGowWklONkZLdWl3bUZMcHpCU3gwYklTQjFi?=
 =?utf-8?B?U0xuRGQ5cWp2cUFSSU9kOEtLcnJYcXRMdDlOZGx2Z1RYOVMzRFNhUkkycGE4?=
 =?utf-8?Q?WOJlxJDje5EX/P9K2EEsbWxV4W23sFL1fvMI4+L9Ok=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e450e-0d5e-4460-9bce-08de00aaf93f
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 05:25:46.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01MXslamsr2AGmmG4+Cks+4HJOdmWrq9Jeafe7ERbuC0DcJRErEF/UXXRcntuwwDDEv2d02JwLZdsUJdH1Ic83Q1IfVBF9JKglnHl1aCtgOqKgJG1/Qv01YbVGIDpkfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6207


On 9/29/25 20:19, Jassi Brar wrote:
> On Mon, Sep 29, 2025 at 12:11 PM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
>> I posted a patch that addresses a few of these issues.  Here is a top
>> level description of the isse
>>
>>
>> The correct way to use the mailbox API would be to allocate a buffer for
>> the message,write the message to that buffer, and pass it in to
>> mbox_send_message.  The abstraction is designed to then provide
>> sequential access to the shared resource in order to send the messages
>> in order.  The existing PCC Mailbox implementation violated this
>> abstraction.  It requires each individual driver re-implement all of the
>> sequential ordering to access the shared buffer.
>>
>> Why? Because they are all type 2 drivers, and the shared buffer is
>> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
>> for status.  It would be execessive to kmalloc a buffer of this size.
>>
>> This shows the shortcoming of the mailbox API.  The mailbox API assumes
>> that there is a large enough buffer passed in to only provide a void *
>> pointer to the message.  Since the value is small enough to fit into a
>> single register, it the mailbox abstraction could provide an
>> implementation that stored a union of a void * and word.
>>
> Mailbox api does not make assumptions about the format of message
> hence it simply asks for void*.
> Probably I don't understand your requirement, but why can't you pass the pointer
> to the 'word' you want to use otherwise?
>
> -jassi
The mbox_send_message call will then take the pointer value that you 
give it and put it in a ring buffer.  The function then returns, and the 
value may be popped off the stack before the message is actually sent.  
In practice we don't see this because much of the code that calls it is 
blocking code, so the value stays on the stack until it is read.  Or, in 
the case of the PCC mailbox, the value is never read or used.  But, as 
the API is designed, the memory passed into to the function should 
expect to live longer than the function call, and should not be 
allocated on the stack.

