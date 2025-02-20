Return-Path: <netdev+bounces-168226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B015A3E289
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065751883B99
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF61213243;
	Thu, 20 Feb 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="alngej9I"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020118.outbound.protection.outlook.com [52.101.61.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2711D63D9;
	Thu, 20 Feb 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072693; cv=fail; b=M4XcadZLDgWx3u2SJEM0Damb4c2sJuJCuYg0m2a8vR66mK01Nu9E28UpcoX8pdA/HPWQ3WuwGvLZTnfQcuu/XU9oNzhKGNGIjJG1UFC9DJlBBVeE7QV1jlmPB4uAuIvFVgefgUfutEsdLuznFvCp4d+EE/swwOcKpZVUWvyZAaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072693; c=relaxed/simple;
	bh=i1mEkhwEgad59Yjy82k+Wt0v76OjdWdpRFzptdKUQi8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W3xOQcmwK6+FTZ6jAPSIAvfcPAM1rZwVPQ5b8/PGeJKzQRkeIX6Vt8p8INKA5K081Kh9gpolZmir33W6Q2K0vSksJfzDm7CRfPjhtCNWlDiJWzCxILKAM83/iOf7nn5xZnVm7Umoi9C9DhQs6lzQw1OoCl7mFWkka3neyO35WGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=alngej9I reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HitKWjeyynOaB40dhRijdUjm95mRtiEAVOt36GcNa10Uu7LfxA76i/HCUha0mgP9d2S9quGFWzmFc69RT99GDccpguB0e/QqvBb3oWqUM+kP6k4KZAQpINI9AZOfMBnb6HPNorDcLikaCRFHduwirQZy4JWj3FKUHiSiLTJDNmN25AgEgq1G4os7sdDFEHNpQ39PGiU4NIgBYp8Wlg/RhSKGJluQDo2VKYHxEmAPNGrssmN8djWfkijXib9bcijdfkBKxxco1w4Y1B6MPW8PmLSHz6Hk0iQ1UVV49op3N6TE4huK+9j9So2n7/drb2tm0W9ahsLH0k1WD75IoaY0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lid1BYdv3YWyp8FiVMaOiBVcA+QPBUbA/38N/sEVvFg=;
 b=NJqmuBAfO9dunWFCFqnkLNQ1HXb8GMuzyFg5v5cFuObbO/jMm5u2SxxpJRvZgqoFFEccma7fNhBTTxRLJ8a66N8yLVC18LuBy8m+llhCoVuryj+UGdfMFXmL1VuB4iReQyWubsYG4vLYtGoZbD/foz6VabWDLtS0HKILZd6aVLJ4G/FoKR+qdT9UONfx58ACb0lhqMthYq3U6uJ//QfDlmouLZ1IZA/np3533az/05lCgtT5rnaUekJsHCRDMljnifUR1bMZTooZlsBf4kKkmyH7Tf6+x8YNoyyV3lsDN7KpbaheyZ3rdPXDeATHIYUUARtEZVPSL4ifNdrS/nCkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lid1BYdv3YWyp8FiVMaOiBVcA+QPBUbA/38N/sEVvFg=;
 b=alngej9IJwjCj9Y03P6MbF/dKBTpkRgKJdLqKKX/goqNPCZFT46Ql9Pymf4Q2OloFuqcBriH6oBIhSwWSoi35ZLPvcCjUfmrb6594XhTYWQ11lPWhCZk5D2T1gKV80MyTNR14qjzcYGnnA/OITmE5klpQjVKW8PIVVvsN+z9Rdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CO1PR01MB6632.prod.exchangelabs.com (2603:10b6:303:d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 17:31:25 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:31:25 +0000
Message-ID: <8f5a1f2d-5ff2-43f8-8964-a992d5554db6@amperemail.onmicrosoft.com>
Date: Thu, 20 Feb 2025 12:31:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
 <20250205183244.340197-2-admiyo@os.amperecomputing.com>
 <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
 <b2ab6aa8-c7c7-44c1-9490-178101f9d00e@amperemail.onmicrosoft.com>
 <1b38b084be4dd7167e80709d3b960ac1b4952af3.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <1b38b084be4dd7167e80709d3b960ac1b4952af3.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::24) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CO1PR01MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 982d4542-35a6-4e72-6a9e-08dd51d46670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czVLU2UwWi9Kc2xMVldCdVY1aFdNdHduZmx2dDFwOXJ6TE1VSHpWZlJJcDhT?=
 =?utf-8?B?bkdQZjlNUENRMCtuaWNQaFQ4ejFPcHpIbGxhQUowT1VRNDE0VTdWMXA2OCtX?=
 =?utf-8?B?eTlwb2xUNGtYSGxscW5GZWM4WGpNWmFocStjQkVDWjFoY2pweHdWOUIvcGdE?=
 =?utf-8?B?Q0x3TVFPZ01ZZENobWQyS3pudCtxa1EzTUNGVVJ2U1kvSGtqQnNNbUd1MVpy?=
 =?utf-8?B?TXVlMGNVb3NLeVdtZnFjQjNKNC9ZTnR0b2piOG9MYWZlNHBvTjFvWithWTNW?=
 =?utf-8?B?RjF6T3poV2pybzd2THRMQ1Eva2c1OEZ1dnNkdDNhZHlSM1Z5dEswa3l0RHdX?=
 =?utf-8?B?UTdZeXowbE4wbStUTE5iNjc5NXJCN3h2a1h6emo2L0Fsc2dBUWx3Mm1ENkJM?=
 =?utf-8?B?U2ZjdXI1a1M0VVIyRmhXUmxQNkg3b0MrUlBJMG9EL0xtM3krOUFkWjZxeTBN?=
 =?utf-8?B?Zm4yTU4xUlZUYmgrYit3T0FTa3pkWVp6NmcyY0cra1h2QzRLQ2ZmSnhpRVkw?=
 =?utf-8?B?RU53VVR3OCtYKzFNQnVHa1EzeWs3WGJYSks4YldqU1V4ZUxreVNES1VPQjJv?=
 =?utf-8?B?ZjlsU05jODFvYUc3Wk5BZkpxbFcrV0RraVFobG1PS01EK3d0enlaZ3BTOGlV?=
 =?utf-8?B?VXZnWjRWbFVsaXZ5ZDZiT1cwTWhsYUl5NDJyRDBHZWdlMWpWZHJnVHlLbUho?=
 =?utf-8?B?eEM1VUV5VkRVbjgvYWpHN2xqcW9jUzNqSHpRaGNaSkFrdmp6RU5sdi9VYkw4?=
 =?utf-8?B?UmpneVpWVlo2TG5KaUdBZ3dtZ2lWK0RQUHBQdXh2L0tKb3RJNlUvUllKWjRl?=
 =?utf-8?B?bkhJM1V4NU1hRzJEVHczTHRKMlRUdzRPd012UE4rdFBzSm5tMkV5NnN2b0Nu?=
 =?utf-8?B?NlZpR0xxb0lmVUptRFpOY2x5NlBqT0krWDFVdHp1Qy9SRTVkS25pN3htSlc4?=
 =?utf-8?B?MGpSc29IMWhkM0JtRWNxdGNLMHQyMTF0Qmw2NzUrdHNBc21tZGRwdVpFUGhY?=
 =?utf-8?B?VXFXZEw3a0QzNm1wRSttT3FnUjZBd29va0pMOWVOWkJSTFhVVU16QkZvNU9u?=
 =?utf-8?B?ZW16RXNLWEMrSm9Hd1B6MDJxb2F3UzA2R3M1Um1aek5Sc0dkN3J4dGxQYUIz?=
 =?utf-8?B?bDJjdjB4aUNER1Nybk5mSHJURmNEcFFmd3M0N08rQmhmQ01PWENoOFlaUkNk?=
 =?utf-8?B?eVpvV0J3Z1EyK1hlQWRpcU5DWkFXWUZwcGpQRG5RdmxoUEFKRUpSVG80bHJ0?=
 =?utf-8?B?ekdDY2I3T25FS2ZyK1p3VHpqT1NvTzhDYlN5VFNESVBHeCtxV2RSQk5xNWNW?=
 =?utf-8?B?c1NhRVlVOWZ5Wk9UT1l4aVYwQmlmcVNwSFY3TUE5cng3S3U3c0dZZ3VuUmVN?=
 =?utf-8?B?bEphdTFKKzZrbXhYbzRsZ3NxZzNYUHZYZjJTaWNjM1F4YWRVOWU0WjY2ajhE?=
 =?utf-8?B?NDBFRW9wNTc1L0lTMjVkTUwrbFF4cnNuTVhNMkh0YmVaZEtScFhhd083QTM2?=
 =?utf-8?B?ZEVkc1NiVGwyVVFWSlh1eDgyRko3RXMySlcyMDJpVE8ybG5yQTVlbDNQeWF5?=
 =?utf-8?B?ZHdQODV4ZUtXQnAxc1M3U09lV1AvTmY0NmF5K3BETUZheVVVaHJtRHdoMGNG?=
 =?utf-8?B?ajRGcDZTRWM4L2VSUkZMLzNUb00wSFBxUGJXeG43VS9iQkxKcUtlemhjQjVw?=
 =?utf-8?B?ck9EalhUWDdqc0FsQmJ6U1hBQTdrc3VsTy9YVTJOUlVPRldpTUsvbFl5NUdG?=
 =?utf-8?B?d3hjaUxQcmNlcVg1aERITWJSNXNPSEZRa1FBYkR5VmVtanZUcjVKM2p3SEFx?=
 =?utf-8?B?YWU5dzM3SGlqeWVidS9sM2FQWkhyTytTaUdpN2JBa1diMWJtdENtSzNyTStS?=
 =?utf-8?Q?sQDM3YYXF83Gw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2dqRzdMT3hNbWlaVUVVQ29OTERDS0gwaFN6Zk96cXNXcStQRVRNeS9JU0pa?=
 =?utf-8?B?dk1QbmxpZUY5VUE3TzY0aWtYR0MzNGxwcUZXa3cveEhVK2RlSWovRERwWWJT?=
 =?utf-8?B?bHFTV3Jsbk9DdTJ1TEN3RTNKVHhqOGpRT0tKeC9WMnRiYXY0VHBWT3FlaG9m?=
 =?utf-8?B?UWlnYVRuL1BmQ0VxdHpEUm9kTjBPWHlsNFMzZWVkUGRyMTV6YXBOVmJjUDBv?=
 =?utf-8?B?TzRGYVRubnBubXB2RkZ4c2dEd01wb2pkUExqSGFpeGxCcHBtWWVWemtFejYy?=
 =?utf-8?B?c0xhak02WFBHM042blJsc0x6dWI3dE0rVWZtSnhsb3BZU0hwQjJ0eVFUY1B0?=
 =?utf-8?B?M1ZJaDYvN0dMQmVCeDZXVmtvejJBNVFFZ1dHZms1UzlQclRieVRFK1FCWUVn?=
 =?utf-8?B?TVNGUnh5aEhqdWhuTVRqMzF4b2ZXUllwTnpkbDFueHZyMVBHcUdxTVR3YlIv?=
 =?utf-8?B?Z2VmejBTdUI4WFRXNmtBZGgxeDJ6T055Q3JDNmpRRjh2Ymo2eE9GRk1jb2Q4?=
 =?utf-8?B?dWFvbjV3KzRLSVZXdkF3V3o3WmpYQVBhWnZYWlpXbE9hMm1RYzdnTS9XMVQ0?=
 =?utf-8?B?aG81WDhjR20vMzBLeHpRTlRHWkVueTZGaFBTZmJwbjNhM0xsVHd3cS9iVnJC?=
 =?utf-8?B?RVhUSm1CTzFFNGJ2WVloVnE4dEtzRlVxRmFnUFFRZThkNEtEUUhveGMyQ0wv?=
 =?utf-8?B?MUhFckdwYXVJSCtnRzBZMTc3NTNXcC8rYmQxOHpwNWV3QjBuR0dHU2I0ck15?=
 =?utf-8?B?Y21vV0VaVU9QdDdDTDJRU3Z4eEcwbHR2Si9oQkJVZytBLzJ5bGJiM3BJV2dI?=
 =?utf-8?B?ZkpFQ2ZJaWpJd1hBKzJFM2JrTnU0NVcvcDdESUtscEVQZ0h2VzZacDBVajkz?=
 =?utf-8?B?dFNUaE5SNm1EWXBQQXEzNGErN0xCTS9GN04yeFlJZzJSOVpIeFFoVFIvWVp3?=
 =?utf-8?B?S2xNTmh0cTc1VVU0TmxZbTR3RVowcTZSYUdlMWc5cHIvdXVHdTU5bUhyN1lh?=
 =?utf-8?B?Mi9FQ1B5bW5rQklJcHgxZVBEZTh5VlpkaFlSaHJ3aldQK0w0TWxIbHFxaHNO?=
 =?utf-8?B?Y0daYWFSVmxwVitJakZDUitoWUQ0MmN0UU5jMjdmelZaTDc0UXpoOHJocWpQ?=
 =?utf-8?B?VnBUcUlJVklGWFZodk1EQlVheVlRNW9DV1hucTNCTTZVaVVMS1RseDRldmxp?=
 =?utf-8?B?UmVjVGFOaFFib3QwV0dJbUU4NFdFZEEvSDJhbXRVUElmVFp2enpOdnFGRDlC?=
 =?utf-8?B?REpndnFKUW50SHV0NHlKamdjMUl5V2M1UzlObC90ejJyT09nQnFoaUIyQjB6?=
 =?utf-8?B?MzErOUl1bTFSa2JFU0VpeUNwblV1RDVYUkRCZEcxcmFOU0JIc0kxUVRjMjV1?=
 =?utf-8?B?aWJCL1NUMFI2TXBZdktrS3czcjFWWDM0VGVBRTIvKzZjczdnakppUjFnS3My?=
 =?utf-8?B?Qm40clZvNUhVWVZMU3FlZ1ZXaWErbVpkN3BvK1F0TXNPNk5Vdy9uUkRzQWQz?=
 =?utf-8?B?OTdqejN0aHNpRDB4ekYyblJrUXVSeitkN2R5VC9jbDFQb2Noc3Zlb0Vidytn?=
 =?utf-8?B?OXJreWEzMWQyV2krUTNaSGVJTWZtMjRtZlUzL1ZvNkVta0Q5MkJ4WWorYW5m?=
 =?utf-8?B?V1pKQUUyQWxYUzRJd3NyZE52ZlNtR2p5RmNZM0o2UCtJN1MzY0dFZTg3Y1Rr?=
 =?utf-8?B?WGsyTzVzV29OWHBDUUp6MHdnSE5waTRCSVRFUDF1YzJ2TFRFRmpESCtmc3Nv?=
 =?utf-8?B?eWUwWXFjcWxNSW9yQ3JCWEcvbWlzckpYSHl4UHUvVjR2aXROTjc5blE3NG00?=
 =?utf-8?B?SlhIZmlLWXNtbDFtbmRzRmY0bktkekVWdXh1dFZqNzdIREI4WjVMWUVseEto?=
 =?utf-8?B?SWhYYkloMmt0bVRuWWhuL0VkSHJKYnJqYmxaUnN5Y0JzNHJJcFl5WmM1WG9R?=
 =?utf-8?B?SFltVEtCa05XcTB2Zkx4L3BPTXV6SHV2T250S3p3TDhOOFY5d2ZYZnZNQjhy?=
 =?utf-8?B?UkVPNFFRR3NuOG1Ta0VrOFRQTmVVOGxJN1JmNVhZS0dKOTlIdFZLTmlqWGhV?=
 =?utf-8?B?T1dPWnZTbWRDRHVtL1B2c2s0eklpcDRDMWNEU05BSkxmMzNzWTBKVEkyOSta?=
 =?utf-8?B?bCtDYWRaNk9jR0djWms2dGxjM0IyOXNaeTFPdExmTFp5MTQ2dUpjWGh0SnE0?=
 =?utf-8?B?dDJsWlY4NVU2bkt4TGFQTnN4SkR6YjV5TmFZWkNUdzJ5cVhHWTlEZ0JYczRW?=
 =?utf-8?Q?Nh1KLR2PtjmrzzYl9SSfZ5IxxGsI5mDB/7XrY2pwuc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982d4542-35a6-4e72-6a9e-08dd51d46670
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:31:25.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nCua4ZYQQC9tGQOIAO7Ve+ubhj2ljr3CXTHlgfdi/zDEBVyQbKQ/E8ZAQmsnwbOGXcVOjSXI6TTaXR1ZjEDJK4eWl0QZe2Qaj9kvuzNg00VPaxvolbL+FGoi+6Q1RPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6632

On 2/6/25 19:30, Jeremy Kerr wrote:

> Hi Adam,
>
>> Is that your only concern with this patch?
> Yes, hence the ack. If there are other changes that you end up doing in
> response to other reviews, then please address the spacing thing too,
> but that certainly doesn't warrant a new revision on its own.
>
>> What else would need to happen in order for this to get ACKed at this
>> point?
> It already has an ack from me.
>
> As for actual merging: If the netdev maintainers have further reviews,
> please address those. If not, I assume they would merge in this window.

Should I resubmit this patch with a title that includes net-next in 
order for it to be picked up?  I can see that there is stuff being 
pulled in and net-next for 6.14 is at RC2.

The write up here refers to a patchwork site that has nothing on it. 
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Is there a better set of instructions to follow?





>
> Cheers,
>
>
> Jeremy

