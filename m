Return-Path: <netdev+bounces-226247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80005B9E7B2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EFE426995
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EB263899;
	Thu, 25 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dt3KnGcT"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAB1EB9E3;
	Thu, 25 Sep 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793523; cv=fail; b=FzVfpI6qxKVwb5KQtO90fycVGbyk6n81iwDMvobu3p6Wf6ZB8+9VSSjoJFY5EMieHbp9j95P7g5W43dyarHzDZbigaXj3nlwcnB2U6okvzMY9JOcopqyW1246hTl//gdajiuJK6yEEETrbMZqfkzagVlzGRT3XS1iQ+Gjj8dCsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793523; c=relaxed/simple;
	bh=/OPctKXMhSaGSniutUp62YgwAj+FdQYD+kMz9UjM1Tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pi4TNzcYLGkwQ17EhE3heuFKustMLgyjfn2RPdYnufLrTadbBqnJqjkO4lFjQUyALkzMT2CnnlEWImAorFhh0fxV0+Fbv2eHAJP89lnqwyVhg6s/8Mb2V9v6nEa/Bd4fILgY9u0tDZLhDmjZMLdr8oTjipSdRIZRYOuAnNcZmw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dt3KnGcT; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuk1nebJcJS9VfUJhXVdI2wOplQaCf4FrrJskhhBIEil+mKVEMZ/S2GhY3PEH7ChcG+zmVPgB5wYPX+Q9CwfZh6fJc4AKKzgLByioLEKI9/mOPn3jqtVVal7SnRT6S1O7BGF0P3a4WgAjwrDMkrq1bl8u2ipk0p2dNuPduj8pvu6+9xzVBdezxhCnaEdBB7YTuGwmmBpYQq8tmM7bcfnn4FZbD3X3JoA9gnK1mZtTaZRyRSJzVBtF7ER5TKDMDy9iRLAKB8u72+X/mU5VovD26vWcS53L0iftabtiK2HojkJXV4JMdOHun/z6Z1Lbkq1EnkF0fWbBhPnRz8YKldh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6kqyrNEt3Y9pb8Izz1BUFb7Jkgon1a6mdPokMTz9PI=;
 b=pknBrAl5K8rC/O9ub0CJdN0HJHti2JM2fanby2O74Sjn+5NZL/UUtHi4LR5jeMidjvcHsuFde0E3kSdH+z9uijK/Egm/So8w8phTl4Wpe0rdzrAGf4/4vFrPBxU2t11sy6mAARedZ3f5Tt/9Qr0tQoi3hPY1osrd+VhrqaPMEfLMmfEEwGBb7sU4QSeqbYdqh9/RldUz4Ai/+n/Fu/D9FG2nmqUFglN10Eq2MwBdYTyjm2lWlc57SJdywRYfSTI7UmAfEqWf3uDE7lAsPKzZgavGFna+iR0s3+cFeC6vQkG3zsONINnaDQ1nCX8Wvq2UDa++LlO/9sM5FUUnWOQM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kqyrNEt3Y9pb8Izz1BUFb7Jkgon1a6mdPokMTz9PI=;
 b=dt3KnGcTcEGdCZjgVGQU8GEKCYwUsCPZGLPXvX5LXhBsMbl7pXmF06B93Gbb868TkzQXaWGUDS5ZSw+p+8yQE2WDU06wfM/SXVSKTuRyTHG6ZAP1EIVtD5CnuN5IdQ9KkZLDNqRURMzG7KoVOfrQtAN5lcdONRI59oN1TyOamaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 09:45:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:45:18 +0000
Message-ID: <fd492a06-5004-40ef-a0b7-c005af43f2f4@amd.com>
Date: Thu, 25 Sep 2025 10:45:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/20] sfc: get endpoint decoder
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
 <20250918155344.00000483@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918155344.00000483@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 17455a3c-d4fb-403a-68b7-08ddfc183ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZKUmNTVTZpMDVEYjZObGlMWGNKK0hZaDY4bGRaU2lqb2ZHckV4TVlnclJD?=
 =?utf-8?B?MnVRd29xcmhrVksyQ3JvNjJlV1hqc2g5ejZSazBQVElaalJwRHllOGk1WXBE?=
 =?utf-8?B?OVpBMHJpK1pxMjNMNTBpWnQ5MjNSaVdzQzV5VDdhT2ptTktYdi9ocjBlV0Fw?=
 =?utf-8?B?YXJ4VWhFQUplVnRaSXZFRWRVTHdoWE1HM3A0RmVTRkprUUhOT3lVWUdhMTN3?=
 =?utf-8?B?dFN6TmpqbHl1NnZkTjNrTnlqcStwTzVudVNERVlOVFFidyt6Zm84WUI0b2No?=
 =?utf-8?B?NGFOVTFVbmJJZGYxNWU1MFdtdUUrQTBCSG5ob1BMTDBSMW5TeFI2NmwvWDVK?=
 =?utf-8?B?dlhRU1N6c3A4ME9CTm1pS1NkeG1Fc0xYZXQzcHNVNXo5eVVpOUV6aGEwRkxS?=
 =?utf-8?B?ZVlKNnBZa25rZ2VobHY0ZE9IbkpWK1BZakZhMHY0N1lQWm52WkQ4TjJPZ25m?=
 =?utf-8?B?Zm5TeWdtOHZUWTFpTFdIaG8vNlFXLy9xb2FVdkcxVmpkOWZ1d2pBemI3ZkF1?=
 =?utf-8?B?NkFxM3YvQ3ZxaElRSi9PLytLakpIbXlIWDJ3Q3hjcjZ2dDhZRXJadU44T0VT?=
 =?utf-8?B?cjdiS09UK0gwMXZDTUFmVkdqc3dJMXVUOXpxRkNGSFVGWThFV0pFUWg5YmVO?=
 =?utf-8?B?VUE3UGlzRHhaMk5Td2NEVWtLSS9ySi9BNG8rV2N6WVVhM0ZVVExnSnh6U2dR?=
 =?utf-8?B?N2pCRngreUduOGQwK1BCS3JHbFV5alY1cmJqd1ZEdEw5QllLajRPMGxpTUVW?=
 =?utf-8?B?UDdrbVBUMHhpNmRSZzlRbTUrUWI2YXJLS2ZvOUxBNDQ2U1o2UHJTTm5IUDZZ?=
 =?utf-8?B?cVJScHBoMkhyMVUvRUJhUmFjV0ZIV0JoWlNjWTRxRlpwRGl0bUltbVZQSUMy?=
 =?utf-8?B?SXNiYThSUUM0TlMzMmtWRWRiUC9aNnpSaEd0SktaRURoVUZETmdYVjlTOERa?=
 =?utf-8?B?SGdlN1o5RnBSUGdiOHEzNXpnK3hQV3hEVkFvZlJKOUFHd2lYNk5jZTVUdG5h?=
 =?utf-8?B?RnMycUpKM1h3Q2NQb0hTNFF4aUh5SzltVUJkZnZhS0xIVlFLWnl3ZGI3U0xB?=
 =?utf-8?B?bFlTaXRvSkJiT0RQQ3pWU1hTZ3RqUE5vcURmTUZDNnIyR25ybVVvaWJ1eFZF?=
 =?utf-8?B?b29zNXFGSTlBalB3dUJOdjNyMmFuNDQyK1FuOC9VSitMYUp3alVCYStZeGx4?=
 =?utf-8?B?ODBuVWprS0dZU1Z6Um1VU2htZDR0aTNMbmY4bklBYnlyV2hXQTFiTHRZWlla?=
 =?utf-8?B?cXIvekRQVXBoaTMxTjdvMnlha1p3cEVDZnNTbUFOdTlISkppeG12U2tCSWx1?=
 =?utf-8?B?VDVNQmdEaldPMk1YYkVDakRuc2ovcHV6VlNxajVpQ2ErZ2VEeDJLTzRrUGg5?=
 =?utf-8?B?TUVSL2pwNTRnUTN5ZHBnbVNEZjZzRjlrb2FiamJvOGV3ZThXby9yRFFtbElh?=
 =?utf-8?B?Ry9taWRELzVQT2RUYTRNUjVuZ1dTV1orYTNCODlZZkVBREdrczc5a0JaeUlL?=
 =?utf-8?B?M0wwNm1kV0JJUEIzWnpKYnkwQWo1eC9XZG56enZ6M1E2aGZxaHBYT2tpeVhR?=
 =?utf-8?B?M1RSQm5GQXhCUVJhTWVRbzkvQnQrMXRuWnJIY1Zab1JZZFE4VzBXcnNLRWp1?=
 =?utf-8?B?QUErb1VreU5ReHNXaXpoaDR2QUZUSmFTSTEyUVgzYVc1c0xBWGpqMTNMWEZO?=
 =?utf-8?B?OEZ1dVh1NGxnRlZ5WnZwblFpMEQzenRSTVhxbVBQNWFPTHRobjJjYnFFamJj?=
 =?utf-8?B?QklDMWpHS0s2NnRKd3Y4MVBtRnhHWTlabkFvbXVHMElrczRDeS9scjEvdFBL?=
 =?utf-8?B?dzU1bjVPSEtEUWs0amhhUXlsKy9kd1RKWWdhZnYrcnJkdS9vTFBjaDhxWERn?=
 =?utf-8?B?RTNkRWJMUmswS0dlS3VMSmt2K3l3by9CUDlPVFNmNCtNYTdwOE10cXRmUkd4?=
 =?utf-8?Q?h2FG19McH8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5WUFlXVnpTWVMzK01aVFpkeWFSWW9ISVRnNWlSVzNxVGIrK3Vud1FSQW1u?=
 =?utf-8?B?RmZMWHdBN0dlUzd4R1VrNHpBY2ZIWkJNc0d2bUpLRUxnbDBWT2l5Q2FsWG9r?=
 =?utf-8?B?YTZBWTVPNElab2U0YXhLakt1dFVMd0orZHpUQjV5bVFwS3grYWVyS1czWmZh?=
 =?utf-8?B?Rm8wS0NyZEk5NFJQODRRaFZ3MmlWaW9OcHpRTmUzM082YTF6MVhYSVdObVp3?=
 =?utf-8?B?VFExMjA5MG0wTW12QTJVS0x5a3JGOGpVSERNcDJRZXVGNTI0bGZHVWhTL0dn?=
 =?utf-8?B?bUpoUDBlWXFhQVk2aVBFU2NjUFAzZ1JtaVVDUjN6TmpNYmZGV2lQcHBYVXBt?=
 =?utf-8?B?NW5aVTAxNlo2V1pnc1l3eFczSDZOWVN0VUM5TGdqZ1J6a2tLM2RESXlzNEcr?=
 =?utf-8?B?SXNsbEhsTS9ZTGlYa1FHOE9kRURLNHFORWhCN2NZYmdlVU83NzNYZllsaEND?=
 =?utf-8?B?SUc2YjBWK2IyQWhIS3c2aEVURjhoWnlGWTJJTGRUL3g5OWRVU2ZQNnlLUVBN?=
 =?utf-8?B?UVd0YkZzRFMwTWdiK0t6encvN0UrZzhmY3FUTk45UDM2bHBDUnpYdUxCaC81?=
 =?utf-8?B?UmxBNk1hNzRJOW9PMGwyb2pCVFpmcWg2WGZSbVdsSWlVaXRuQkhaTGNGYnVI?=
 =?utf-8?B?MjFMdXc1a1VSRC9lTWVhVU91b0pndTFIMWp5NTJ0c0NFcjdEcXhCbWpMNEI3?=
 =?utf-8?B?TTRQMi8rc1FsUWF0RXUyZDh2bEdGOElVRVc4QjBXU2h1UnBjNk10b1hRSkNS?=
 =?utf-8?B?eldmekd0MDI1d1dhcDVkNjc5aGNJNzQwN3gyZ3lvNDVkdGdiTWlQdVMxSzVa?=
 =?utf-8?B?UmdpTEpjN1lZcDFoWkc2RzdxZkhOZk5rRzJ1cXN1T2h1TERkK1VrbU9scUpw?=
 =?utf-8?B?SGRoUWhHYWZEVVNtQVR3WS81ZFlhWUNMUUEwYkpic21nbUpjOUJsZERQQTVT?=
 =?utf-8?B?bHV4Q1V4UHc4QXN1QjQ3YnliV2w1bXZycjZrNHJOSXpDdGpwUmpkNWRxNlRp?=
 =?utf-8?B?Ry9MbGVlLytMRTlYNm9nQk9ydkE1SXdMWndNOW44WVpzemQ3MW85RWxQcFdN?=
 =?utf-8?B?dVNTclRsTU1IN1NkeDNKcC83TEVWNldtL250OVViTld5ekVUSzN3WVVaZG1o?=
 =?utf-8?B?RXRQVHA4YkdSeGlQdm5VMkVjMmp5T1d6c2QyZUFRR3VmSDZPSGRaVzE3YzRz?=
 =?utf-8?B?M3ZhMWRwZGZYcEptaGp4K2pqS24veS9XOCtKVmRYL3lsa1Ntb1J0TU04WFA5?=
 =?utf-8?B?dEtzUDg0NFZnS2ZVdkJEd2Zva1ViL09LNERldjh4QUtGNHdNRjdkMWRrZ1Jw?=
 =?utf-8?B?R0gza3ZaUHl0a0ZqMWpiMnBRT0xpRXl3bFk5c3p0d0EyZ0V1VXZ2eSt1WjZV?=
 =?utf-8?B?L2w3d0M5cU4wNVVoT0x2a05HOVJvNk1rRFozS0d6dFQ1NnBndmV6aFNpNmo5?=
 =?utf-8?B?WENNenFFemdyUjNBQzlwVFA3RVpHZWcwR0JsSmtHaTZGSm9aL3J6dnlKV1Rj?=
 =?utf-8?B?RUo1T3JLMHptMjdvMldOd0o2aWVZYmRrNUxtT0RFODVqTHAxSmFJazZHVmlG?=
 =?utf-8?B?S2k2UmxRVWJMRERTR3B1K3BrN2xWSk5yVTJ2eUcvQlRrZmg2ek14SWl4Z0gy?=
 =?utf-8?B?TVBVcWZvUmQveGtxYzF0Uy9wdngreTFMWDluU1dDRG5paUt2RUg1TUpVMTBj?=
 =?utf-8?B?QmNTN3JPOG0wMW42NHRmOG5yMkxxZTNENkN6d1orS2dkQllaZEJIRHE4SDcr?=
 =?utf-8?B?bTFaYytKbXJoeVNlS28rWmdaY2RqdFVXb053WUMwVFZrbVh2eGIzbVZEckE5?=
 =?utf-8?B?aDZMQWRDVHFVZk8rbjZCenFuUVlXMWt0ZWxFRmRvOC9Xb29BWTJZR1ptMkNq?=
 =?utf-8?B?ckY4Y2poS3NaRUNDOGhleDdyUW4xUEc0dFMwdUVtT0o2T2xlUEVsZE1POWo0?=
 =?utf-8?B?dnN1TkxNaW1Jd2pNVEd1S09UM2FnOUpubFZOcFY0bEp2RG1rMkdpU1piS3ZU?=
 =?utf-8?B?TTBzbnE5N0hQNzVNSWhUeVY1VElXeW5MZkRncUJUakk0WTNsRHBwU3MzcDkz?=
 =?utf-8?B?czE1YWYzK1pLeG1BbXRYS25BcURwb0hxYjZDMFFNdmxWYzhiM1gwNjhiaVVO?=
 =?utf-8?Q?QCXH0OeFRV5wVCBmIxb5v+0GH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17455a3c-d4fb-403a-68b7-08ddfc183ce2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:45:18.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxb5f2D41ZJjON0I/qikczc8yvxIbUpQr1p3PS9WL7wZKkUxEwNbg6hljYzQI2pVrcf9ND3Ua9pJwMi14D1YTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841


On 9/18/25 15:53, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:38 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index d29594e71027..4461b7a4dc2c 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -99,16 +99,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   	if (IS_ERR(cxl->cxlrd)) {
>>   		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> -		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>> -		return PTR_ERR(cxl->cxlrd);
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err_release;
> Push back into patch 10.  I was wondering why you didn't do this there, thn
> found it here.


Using a goto label in patch 10 does not save lines with clarity not 
being improved either. With more code below doing the same type of 
unwinding, it makes sense now.


Anyway, after removing patch 8, the unwinding is simpler and does not 
require goto labels. Coming with v19 ...


Thanks

>
>>   	}
>>   
>>   	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
>>   		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
>>   			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
>> -		cxl_put_root_decoder(cxl->cxlrd);
>> -		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>> -		return -ENOSPC;
>> +		rc = -ENOSPC;
>> +		goto err_decoder;
>> +	}
>> +
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR(cxl->cxled)) {
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		rc = PTR_ERR(cxl->cxled);
>> +		goto err_decoder;
>>   	}
>>   
>>   	probe_data->cxl = cxl;
>> @@ -116,12 +123,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   
>>   	return 0;
>> +
>> +err_decoder:
>> +	cxl_put_root_decoder(cxl->cxlrd);
>> +err_release:
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>> +
>> +	return rc;
>>   }
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> -	if (probe_data->cxl)
>> +	if (probe_data->cxl) {
>> +		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>> +	}
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

