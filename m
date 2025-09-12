Return-Path: <netdev+bounces-222650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF19B5542F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9E25A4A68
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217B264A74;
	Fri, 12 Sep 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="9oVzNA9/"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021115.outbound.protection.outlook.com [40.107.208.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6A263F49;
	Fri, 12 Sep 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692509; cv=fail; b=nAgk45nc/bdtQmgqpqgxt/ov/RZfZoiZ13RARgZRE0DlXwNBvoQKyZrOFr37otr5wJcM0CDJ8kc2Bc/vMxfvFedIS0swCWGMN3eX3Cy0c4QZue6leYGWxy5DwbwvWmf7sLOVwgS4d3JtGLzS3CnDhmUscU5fblEitwJkXl6X6LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692509; c=relaxed/simple;
	bh=fKbHUj4KZvgfm0H530IRU2Zomo7lbtEmN91BiHtTmic=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uONJLDXBWXXTlY+naPjchWwZpEmR7TSvgnCuSih8s3aEaCjM22Vb0o9KkxO4yEfozMAx6a5mUKZEC/wHdGAowaqJQtk4mPrh/RQRU3vo5LJCO5SSEwifwvvliLLiqHJAIreGpZfQkf+8qS6MIU+tnZllyJX/xshY//vnC+aazqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=9oVzNA9/ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR/ysXavNUaJNnD6gaoc+/NmEFAqlGIU2KrPNxUwXcyDYGDFCUxh7QTLhg+axYVhmTyCZWAE1e2Z7KZn7+dhQpxDGs4Fr4VoZXEloBkqWIgmKILwM6FxpacSyKMrIzXnRW3BCd7R1ISvg64m4LUtZpHQyujIqC87nUd77O+6s9DuuCbT4xSEODnpx8I3bvMIP4HbAStGIbRLgVtCILnIl8CEoiCsQZBufvwclbYNhIDbzk1+2Ycxl0/5BFy6e91gU4M44h8hmZ7dY6PpiMXYKvYLFN5QJEqPPtrjqzhfh1zNycy4G6DyBniWmDGM+Q9rIUiouBjbiZqVo5xNTWKSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cV0gf4D+SRWExKRThe0yN63LfRAMdt5YYAk51PHPRs=;
 b=n6cAzyZ8Sz/8uXqXkxthcuH/m44XPHQkQRlyehswoIztG2AHRY13rg6qxDPrn02f+XruLHiP7pxO9DBRDjrNTM+lKmItmzsq1DyffVmZeG9gsYHZttep0ZzDyBU850LAoWfws1UUx59864Sf7j2/UBkGOJroFlqFUneMZWDhCp14ay9WSEYjdtWGSfkd391vuwRONQYwdXuWyqTdM8Y85OqpVsO6xgBqAAfOp2zRdl10QlW8sAMGw++IfFlm29jDF7GCofE6nC8wUWvPHbSlnkpPBsNAWdswzLaLJCBWhfvOMt9DhAizkF3/ozXspzmW2DA5drT2Z9O9JcqwlTV9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cV0gf4D+SRWExKRThe0yN63LfRAMdt5YYAk51PHPRs=;
 b=9oVzNA9/iAMdV+tUxFHVeg15JJhTgUU/avzxlkZ1gGACOoufUvR+djVtCY6/yr69gkaGsUNdqihCWVEpJjGP6RHM3fSbYAb7S5pkSf3uyx3xRLvlQ//+y7LkgppLH5pENVbxG+znstPWx5WsadAVI8P4kRT1oWWxoIPYB04T+ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS7PR01MB7592.prod.exchangelabs.com (2603:10b6:8:74::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 15:55:04 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:55:03 +0000
Message-ID: <c9f9d997-1844-4628-bc30-bff8725ef75c@amperemail.onmicrosoft.com>
Date: Fri, 12 Sep 2025 11:54:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: admiyo@os.amperecomputing.com, Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <1ec0cb87-463c-4321-a1c7-05f120c607aa@amperemail.onmicrosoft.com>
 <aL70PVhM-UVi5UrS@bogus>
 <bbe0a7fa-7c7e-4d59-839c-23e8fa55a750@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <bbe0a7fa-7c7e-4d59-839c-23e8fa55a750@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8P220CA0037.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:47::7) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS7PR01MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 400d807b-34d6-4fe3-ca72-08ddf214bcbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE1YL3Y4NEh5U3o1SWI2RzZYY2hJeS80eFBsSEtwdmlMNllDTWJ1OExScUUv?=
 =?utf-8?B?WjBmYWhOT2h3ZXIyeDBCcHVJeUpkV3V5aU1nbFoyNldZak1HeEtsOExmcXBN?=
 =?utf-8?B?a0F3dkxMdmpYVzB6RDNXTGd0N0dUZDhNTDBpRXROU3lQSndyVGVaRU9jNmZJ?=
 =?utf-8?B?K0RZT0JzMGh1QU1Ncm9JSjBaQTFJNEl5QlcvcU5pZDg2WDhHamNtVGdvZkpM?=
 =?utf-8?B?c1VFSFBJaHFJTTNhc0x0U2xaMFlGWW9sQ0hTZlZZT2tjcmZnOS9ta3NNdnJV?=
 =?utf-8?B?TFFpR1NsRVVEbllLalV6c25HQ0JGWDdubENZZEEwbzI3OThnclZEc2FOZG1G?=
 =?utf-8?B?c0FBZWgwOUc5UkQzcWxNdGJqc3pCSHZjUzlndGRaWmlvekc0N3dmSWlsWmFW?=
 =?utf-8?B?NkswMmRwTnpyalozaUx5L21KYVYzc09zc0dJenVGK1FvaGMyN0ZBR3ZPTjQ3?=
 =?utf-8?B?bGFYMVVETUNHTThZQlNzQ1JQbkt1aUZ4em1XR1JtUXczU1JLVmtnVzdIcGpq?=
 =?utf-8?B?SW9iMnpLRnp5aVFSWGhvUktCbzJhRHkzZVVxZ05tdnVnRzdCV1Yrc015QXZH?=
 =?utf-8?B?d2UvQ0VGWmhFNFRFaCtqaHptd2dsT0kzQ1F4czVyamZGS3B4b01URjA4UWVS?=
 =?utf-8?B?b3ZST3NJU0hpandHTU1HT29pd092Nys4OGRBY284endHcnRSbm1Id0JLbkc1?=
 =?utf-8?B?QlQ0bVNGWHp2VXlwcEtwY2RGTXVyRkphOFVMTEx0MHlVd0R6aGdhczljR1hj?=
 =?utf-8?B?aHF6KzV6bm5zcDcvK01CaWlraUZsUFFkaVhrdndkUmNyWW83Wk9xMTlrTVU4?=
 =?utf-8?B?WFpxZzVndVhrKzNGcC9Rc0Y1WXlxdUR5ZFRmTnR5TWJaS3g3Mk0zRysvcVZa?=
 =?utf-8?B?WkIrYXZNeFBMUDhZYzY1blZqSnFYb29EVHNrc0Z0WUNCNW5vZkowUE1xR1Jx?=
 =?utf-8?B?cjlsd09pL0NadEN3bS9EcnpPVUhyN2tueHFuV3F0TENueldIdkU5UEFZT0Jv?=
 =?utf-8?B?aE0vTm5yN1p0RHdHVlQvKzd3bGN6aStMbi9xdE9GU2FKemNBaFZ3MGhVRTRZ?=
 =?utf-8?B?SzlYWndDOFV0ZDl1QnhiczBRZk0wK1VIZmwzZzhKemJnWUlBZVNTOTdqdDI4?=
 =?utf-8?B?ZTZiMVZjRU1QWEV0SHdsU3JGMlJXdm16RmZ0dUN0SDltaVpQOU81SzJzeCtr?=
 =?utf-8?B?R1RIM2JHTVloL0IwSnhxeTE2WEhSakkxRElDL1RHdDAyWUM4Q2hLYlRuWHBW?=
 =?utf-8?B?TEVocFJMWlRSSzZVVGRJbmdiMHpoYjZkam5aNzVBc0VsME5SVGdVUDlNeHUv?=
 =?utf-8?B?V0ZhcmpQcXBYckJRb2hpZi9IUnlBZXRTSy9UNmV3dUltaktmbHI0ZmNnanJM?=
 =?utf-8?B?T2cwNXhtODU1THh2VlVxOXFEWVFRMk9DTXZISDdGK29RS3Qwa1lEU01oTlE3?=
 =?utf-8?B?MUFLTUdnWlZKaGhYMnVMNzFjcm13dFllM2d2dmp2RFRXNHBWREJ5Mk1MSXhj?=
 =?utf-8?B?aGs0YW81eXM2c1p4VTluSGY3Q2Z3SlFxSGVJN0h5YSt4ZmFtcjIyK1U0bGxh?=
 =?utf-8?B?aGFBL3piK1RKejdqcHl2KzBhVFZIZXZYNlhKYjlyUXZNMDAvUkdIWkRqYzUw?=
 =?utf-8?B?aEZLeUFvU0crQVhZUHM2c2NQQ25kZ0lmbCs1dUh0ZHpwVHdqY0NaalNQc0JV?=
 =?utf-8?B?RzE0WTNZSUZpMXluUDg3LytJdE1lSHJJWWJtN3F4VzhSV1pyT2lXMXB1L3Jo?=
 =?utf-8?B?N0NKamIvb1hGVXFEaXNOekVWVENvcHFidGc0bXpCUVpwZHFuNk50VmZnNEk5?=
 =?utf-8?B?TFhNTVJDakVuYzJtTlltNXdUQ2htbTJmSlZCdUEzbjF0NUxjUE1iNnhOZmYz?=
 =?utf-8?B?RHoxb1dUU0RQOFpPcXE5MGYrb3liRGIzUXlEOTJuaTAvazh4aHNRdWpFL3dz?=
 =?utf-8?Q?2bpWMF7kRPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFg3QkNGM2l0YnQvKzNBS1gremN0MTljbWVzbjZQMmJiWTFDZ2tGcXFuNEd5?=
 =?utf-8?B?Z3ZYQzNnT3ZXTEFxQUE1N2FkT2l5S08ycmhNWEQ3bkNIQ20vbSswSWhQWFhX?=
 =?utf-8?B?OVdQUVNVcU9BcXBKcFpNT2l5MXc5YlhEVDNSL0p1MG5vUUhyVVNKVUhuMWw1?=
 =?utf-8?B?VjZvMmtGemU1aGd3MkhyZE1Ld1JXL25UTnR6Y2FDaEVCcjI3bDlCeDUwSnZX?=
 =?utf-8?B?RXBac29IdEFlZjJEdDBBMTVVWEFrUDhMdS9tYnl6YnE1MXJVb01Zd0IySFNJ?=
 =?utf-8?B?aS9YUHVoMElMZkZjMjVITUN6dm5ObndaY2NaQnZ0OTdSSTgyemE5MHFZSzdw?=
 =?utf-8?B?d1JGMFVybllnU0VPcGY3QktBU0IrS1doNlU5NXpmZkM0SnJMb1RxNm9SK0Mx?=
 =?utf-8?B?WFpOeGlrSEF2WllnalZSQmhWZEVkSVR0cmxrT1M4MGhpSGV3TFZyeCtudDRH?=
 =?utf-8?B?elh6LytYaEN2MWZucjRzNEI1ZFhjM1UxTGpKZHBkZkhsa2VoZ0N5bk9HUHhz?=
 =?utf-8?B?MDFuc09CK3AwZVNIU3JRTU5Dc01WUjFaRlRxWW9adXdEUDVxdkJwTWNzYkFx?=
 =?utf-8?B?aHExaUxLbktjYzhZbWEvN0VaR0JPNEVTQWRvNytqZTBBdmU2SElLNUNDSzJN?=
 =?utf-8?B?dmFBdVUyNkwzTllqenZMa0kvWGgycDYvaFpySlJtaWdaK0Z3OHEwTWt1WWRP?=
 =?utf-8?B?SHhhSitva2RheFhzaTBjUy9NR2VqN2xkN01hdmNDUkxONW5Xc3RNbnFyZGxn?=
 =?utf-8?B?NGFXcHkxeVZ6ejdMTEc0eDU1VVVwT3hCY043NVB6ZytIbytmcENlQk8wTVZs?=
 =?utf-8?B?Vm1VbWNFZTVoa2N4ZGc2ZXkydU9QNUNFeFczcVh3dDhqblFiZURXTndodEFD?=
 =?utf-8?B?QmszdDVGRytkMU5LVDF6NFdoR2tGQkxNTm85VEJDU1o1RlBlUjNTOFI2M25n?=
 =?utf-8?B?Rk1kT29CL3VVTkJSb0hKNlJvWDJNcXdCdXdDd3g1VEI0anZ6cHdxYXR2MDg5?=
 =?utf-8?B?c3VFQzZaVGlXbHg2bDUxRklGMmVhZTgrdjdqYmFGaEw1MGM4eHRtQWUwdXNh?=
 =?utf-8?B?QUFXTXVJOVBJWXVtL081ZVVwcVowek40a0k1M2o3eEhZY1Nybm5WZXljME9J?=
 =?utf-8?B?REhpc2dpbFdvQlR2TjE4RlVlaEI4aTZycEdrTWlnSGRMSjNsNDAzVVVlNW55?=
 =?utf-8?B?NUl4bTNYUnFCUzJiUFBhbXNwTjBvRjN1SzhkSGZKdU82cUYwdHVUS1ZlQ2FP?=
 =?utf-8?B?MUk3ZWREbVhrK0ZZU2ZBMHNyTnV2QXM5L29kSmhrYXBPVUxnRWduUmZqRUEv?=
 =?utf-8?B?OU53QmVlTmVIekZlOEtEMHRlT1hDeGtqYVdENGFweFpNUW0yNEZFcFFROWx2?=
 =?utf-8?B?SGJYSGJOcnpNeFMxVTZQbXkvNC9NTm5Id0pvbHB6QUJuS3ZpZHZuKzBqQTF0?=
 =?utf-8?B?cVNUUHFLOUVSOFVkc29rVUNCUE9Obmk3bEZucTFqVnlnRUNhdmJNVnY5N2N4?=
 =?utf-8?B?ZkxwUnIwellSYThKOGRCZ1FHWExMVUR5K0RDMkY0czllME1td1M5bTNXWlF5?=
 =?utf-8?B?aVRjaFc1d21GVHdiaW1DSmJIMWxldHFqWm9rWERMY2FIQUxRRXBFOWpZNzRk?=
 =?utf-8?B?Q3JFU2hqT0lhOVhDOHRwZ3NsSHdGSmdVTUNhNGhuRGR0V1NOOS9sRHdQYWhV?=
 =?utf-8?B?cjVwdGwwdk10WmNFdUxHckdMcjJQOUJITDJvbWJ3WWlIT0pReW9CbFZkMkxZ?=
 =?utf-8?B?OEVyaW9rRFBKd2dSaTQ1S0VhQmpSMWM3T1gxOEpqM2V3dTZTZXU5VFNkUDZN?=
 =?utf-8?B?K1ViQnB1ZGNXd1NhQTJ5cC80dXZwaGJYT0hIaWFUWU51L1ZPU2lFUFRxVy9U?=
 =?utf-8?B?OHl2S0xWSXRzMlY4WDVTU0l2bXU5OFREQWRkc3pHZVJSVEl0MXZOV0JEMFBz?=
 =?utf-8?B?STlRZGZJVzdYS3dtU0h0OFRCWUc2NlN2YXRxN0tkZ1dUdVdCN1k3a0Y2djdr?=
 =?utf-8?B?SlJYblpZZjRnRlIxM3ZPMUhVNEhVSWlPa04wMGNlR0tqUmUxWHgyQWFnVVpP?=
 =?utf-8?B?QXlPeVAvaktScTFneWVBcXQxZStWbjBtNkNxeEJIdzM5OVV0YUZpVVM1T1J3?=
 =?utf-8?B?SWhVbE01Y2RlVjJTdEQ4ajlzVzdqdVpXbjlhanRMK1BHaWxxUHdidXc2YlZo?=
 =?utf-8?B?ZzZtSEgwS294UlB0Y01xem1RWTBERzFYSlRTYW5pcEZveVlYMjFKd1F6SHI3?=
 =?utf-8?Q?Y0Ykhd4wJfQ429CsV/C/wWDVL5AGAALRGMtVrY77ww=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400d807b-34d6-4fe3-ca72-08ddf214bcbb
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:55:03.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U//DDaBCpRj9ifvTfUySS4RJbKPHZbO6V3QyvpMLiRnTvG8OxsmJHjn9nbP87AwiUvFlEoasmdFw2uAZwI3lAC9JfMaRzxlAyaNfwBQ0nIgzRu6ZjuUnPLbkvIHwq9fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7592


On 9/8/25 12:44, Adam Young wrote:
>
> On 9/8/25 11:20, Sudeep Holla wrote:
>> If you are really interesting to consolidating, then move all the buffer
>> management into the core. Just don't introduce things that just work on
>> your platform and for your use case. You need move all the drivers to 
>> this
>> new model of accessing the buffers. Otherwise I see no point as it is 
>> just
>> another churn but in core mailbox PCC driver instead of a client driver
>> using PCC. So, I am not OK with the change as is and needs to be 
>> reworked
>> or reverted. I need sometime to understand your email and requirements.
>
> This is kindof a large request.  I can start working on getting the 
> other drivers to use the common mechanisms, but I do not have a way to 
> test most of them, and there are numerous drivers.  I don't like 
> making changes that I cannot test myself, but if we can get the other 
> driver maintainers to test and review, I am happy to participate.
>
> I know we use the CPPC driver, and I can show how that one would be 
> consolidated.
>
> Here is a potential path forward:
>
> 1. Revert the current patch, specifically to remove the callback 
> function.
>
> 2.  I will post a minimal patch for the change to the mailbox api
>
> 3.  I will post patches that modify the other drivers to pass NULL in 
> to the send_message path.  These will need to be reviewed and tested 
> by the other driver maintainers
>
> 4. I will post a revised patch that only performs the buffer 
> management for the send path.  This is essential for the MCTP over PCC 
> driver, and for anything that wants to follow the PCC spec correctly.  
> This will remove pcc_mchan->manage_writes = false; This path will be 
> triggered by passing a non-NULL pointer into the send data path. This 
> is roughly half to the current patch.
>
> 5.  I will post a revised patch that makes use of the mailbox API 
> callback defined in step 2 to allocate the memory used for the read 
> stage.
>
> 6.I will repost my MCTP over PCC driver  that makes  use  of the 
> updated patches.
>
> Any point after step 3, we can start migrating the drivers to use the 
> send mechanism.  After step 5 we can migrate the drivers to use the 
> receive mechanism.
>
>
> A shorter path forward would be:
>
> 1.   I will post a minimal patch for the change to the mailbox api
>
> 2. I will post a revised PCC Mailbox patch that makes use of the 
> callback function, as well as an updated MCTP-PCC driver that makes 
> use of that callback.  We deprecate the existing rx_alloc callback in 
> the PCC Mailbox driver and ignore it in the PCC Mailbox.
>
> 3. Convert the other drivers to use the managed send/receive mechanism.
>
> 4.  Remove the flag pcc_mchan->manage_writes
>
> I will stay engaged through the entire process, to include providing 
> patches for the updated drivers, testing whatever I have access to, 
> and reviewing all code that comes along these paths. I obviously 
> prefer the shorter path, as it will allow me to get the MCTP-PCC 
> driver merged. My team is going to be writing another, similar Mailbox 
> implementation to the PCC mailbox. The more common behavior between 
> the two implementations, the less code we will have to vary between 
> drivers that make use of the mailboxes.
>
>
I will post an updated version of my patch series that starts to follows 
this second path.  I will not include the CPPC patch in there yet, as I 
need to get my head around what they are doing inside that driver.

Is there a forum in which I should cross post the Mailbox changes?  I 
plan on creating a new, mailbox API level  call back and I assume there 
will be a larger audience interested in reviewing that.


>
>

