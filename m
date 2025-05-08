Return-Path: <netdev+bounces-188991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2882AAFC68
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C93B2A62
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEE252917;
	Thu,  8 May 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DCVmK1Wr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289C252911;
	Thu,  8 May 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713360; cv=fail; b=uv2qZmsyrv6TN0WELv8/JLXGUt+cBnE6TDrb+k+cGTxh1fjANI/g4Rq1VStigUbyqCHx+pW1lui4T4Rx2SYvPMrh/aLfJL4sKT6JSsrzkjIbBZXyEgGsIkAdG9iycKvQwUWXz7WXPYj0b4+F336BCJQWpvNtIu5AgElNol3B4Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713360; c=relaxed/simple;
	bh=4vO1wRv43SecTaId1Bha5K/LAJ0/HK+IIRpLpYR+jTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxhqWqhNqLDKunCYhrqEj0PyYc63PguxbuIWb9a+efsuJh8czAAHPjYcJyZb4LI8wLtILDHUTl1+ubZxykbuMjttpN5RT9yjuBn/95Ro0iacSBDf5MWZwF3bahjNSOMx+qqkdbLFTZtYQNYg40q+FsP8hxsWjQHRv19sodu/v30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DCVmK1Wr; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0bCsygGIiPv3iavoBsVE/jjHoZwzpvCgPQqi/EX5VK40tovYImXriwpKTMmse2UekCwdd7z/GDwNW5L5WxmiuTf/p4PKBy97znRwGEHxjGhu9H6N14XwXCQiZseiQ2qL+ReFdrZiXodMjrHtFUV/Z/eCnYjIc0CFwAv4vZn6BWSsIUBeiMEEKE0FDBsIlAuVZvR2KOUO6WEm3oousba69YShS5VT3OXX4m7nxwbio4asqpaKgueNG0xKQNVzWmYdh6cbQajoc6joEveqQTtVp45tpoWPzZWbeB5P+uH9bpsQMIGFNHC4MSdjrYg8a07gcYf6dLKuDF7teKBO8OKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESSFPYrg3q8Fqd5WbIZv7Co5MZgAUelkaInYSaPvJBs=;
 b=e19tchhPMCg6P8w24hR7nwCDro//6gNo8P2aW4lMcgBPEz95xr0lCTHi61CagTlSM4IuvVlfcGFlMfE5shnVCxgH3PYOoFIr+6BerJIvIdyzEC0sckuowRhJxabYNcjEBsGA0NmFIXOd7hgRvActDCcVc5A96/tn0gGuxLisgrqUtQURy2vHl696QJSpuOarPBx2TCCSwRmmLCjfBhr275JhhAu/67mASbRw9E7X5epPKWyptgbzjYpca+nAfmjSWMc/SnYyEnpX6x/slMeMqvm+tam6RBLvxEqTR2NpeVwxMQbVgS55z3e56TESH1Nd3eslW9U7nbhlaVvnd0bSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESSFPYrg3q8Fqd5WbIZv7Co5MZgAUelkaInYSaPvJBs=;
 b=DCVmK1WrB5y740SAcDvKMxW98eSz5g1ZcSAptX+0+QTvQaMxVKWFVGbENEy5k27i/dyjanlllcAtBQUisnLIZOff/zz9mCiIkM4ZFFoJd5QGfI1H9pQQaTq1/PHBVT0nCX1bBs0DfNZN9qMqkC/+qOtjygrdh1WvSVjIRYpumH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 14:09:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 14:09:10 +0000
Message-ID: <0087470d-9f1b-42e6-bdc9-00b7329b8fbe@amd.com>
Date: Thu, 8 May 2025 15:09:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/22] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
 <aBwFVdyGIis5fncS@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwFVdyGIis5fncS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5a1b6c-fa34-44e7-ba7c-08dd8e39e78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFByYVZTWm9ONzVGc3VvSFdhSE1jOGlsc1lMMEk5S3JVSTZWWmloMUlBK3Uw?=
 =?utf-8?B?aHhMblB5Q2prTWQ4cCtXL0ZJV1Z6cnEwYkhLWTJzK3lVK0Y3QTdiVmZUM3hi?=
 =?utf-8?B?bTZiK2JNRUlFK2VSbi9jdWlvVEwzOWhDM2hNWHB2dXlZSy9wQnhVakNQeVBD?=
 =?utf-8?B?dmI5a2NVb3RzNHNFZFM5TmJaWUR5QzlXWkZQb0t4RTY3cXFtY3VHeFg4cmRP?=
 =?utf-8?B?akpaSUUyT2M5NUNxQ2FVaWVqd3lNeWhHUnlCRDZoMXJVR0VORDl1SzVKUi9W?=
 =?utf-8?B?cTVhbnFZMmo3TG9Xa1ZhcTlYUStkNVF3c2g0SzBCblg3clA0WlF6cTBnKzd2?=
 =?utf-8?B?T3JxUVA1SlE2THl6VmZIckF5amtPOUV5Y2FrZlNLQ3JTNW9VbnBRMW9Bem9y?=
 =?utf-8?B?Wmx0cW9kUkZxS0cwVHBsSDY4ZUxpRkZmQitENkpLUWpQZm1td2NxYUpmekwv?=
 =?utf-8?B?ZFExekh3NGZ1U1QrL0h2eWp0UG9RU1Z3dVViajloZzEvaUdwdVJabHFlWDRl?=
 =?utf-8?B?Y21iSkNWblNQdE8vM016c3NSY2Z1c3UranZiL1pGemJJQS96VTdaNFozQldt?=
 =?utf-8?B?OEc4M1VZd0hYZ1hrTmFVK0pwQWQ0aUpybmcwWWdmcERyZVZMa3U0bDB3NVV4?=
 =?utf-8?B?b2MrZDloZExibm1udGMwZlVqWVNnRDJ3bVNkWG85OHZ1SFB2d1lza0QyL1pm?=
 =?utf-8?B?RW5aRnFzTHc2aUlhc0pFZ25oSHdnYU5iTFdQVDFERjlJT0lpSTk0b2hybjJz?=
 =?utf-8?B?clRwK3Z5QTFBMStaejNPWFVqdS9hVnMyRS9Salh3b0lGdDN4MUU4VXkrZ0ov?=
 =?utf-8?B?R2VWcC9RYldkblhGNXV1MHVlYTNqN1dJR0RUQ0lPYllTMkx3bmxRYy9WVGx1?=
 =?utf-8?B?cVFkbXExY1BSTm5ta29QTU5oeUtHTkVOcWQ2K0VpcFNYU0RqTzg0ejZmRzM1?=
 =?utf-8?B?dGhDdTdwb1U3dWtqOGIxamwyek00ejNXYUhoTGdzVnpYa0xLN25CZUVjZWZK?=
 =?utf-8?B?S3o4N0VKejlKS3BwZUFWTWs0UU8vL2t5Vnl1RmxoaHJ5REw0U3M3SHE0ODJ2?=
 =?utf-8?B?aGNwblhzdlZjQXpmMW43TkdBVDdoUVl0alh4RmIybG5BcjBDZ0pLU0V3SG9F?=
 =?utf-8?B?NkdGM3ozTjFabVlGbUpQZWFRcklGOHdzcjVMZ0dDYi81clN0UzNwSTJHdmlH?=
 =?utf-8?B?RGNTVVhCK3Yvc0F0MDhYVGhtcDdjbFFpd0tabCs1alJ3UkIxY1J3a29Vb25u?=
 =?utf-8?B?WGFmKzVqWTJQbjdZUFgzNXpVZXN0ZDRvUDR5ZkJwQStiZk1GeTZuZlUvS0lL?=
 =?utf-8?B?RTVHYWhaUjJQaUFoc0VrWnBoMUZJNWc5Sk94emx2L3FETWJRLy9mNG9nLy9T?=
 =?utf-8?B?bENaSzNiNDJNQ2ptZ1F5QUt5T3BRTHJYTnNoaVlFUXNWSGdTRjJkZnBpMDBU?=
 =?utf-8?B?U2FSTnNCdmx3Z2JiU1dKbnBTc0IyYUNHRTVWdEhabS9vckNsRzFXUnBjWXND?=
 =?utf-8?B?WTZFOGpNc0Vka0tDOW9SK2ZwT1ZQRjFwVjQvUFYwVm1QcWd0Q1I0UHppL0Fa?=
 =?utf-8?B?VTJtcXE5Smw2YlJFWW9qNVNOWU9waEEva1gwNkdOY2JTY2xkZ1Q3RDVFWWQz?=
 =?utf-8?B?NFozdGI1TnZyNVJBY3BsWTI0NnU5dm1PQkpYcjlnZFI5cTlncnNzcldFcmNk?=
 =?utf-8?B?bzBSbnRYc2JBRm05R2hSU0pETzdReTAzNWhhRUx5aFJuVjl6SjRMR0VGajdN?=
 =?utf-8?B?dmtMZ0tFazdYamlCV2pVNTZjc21FdERQMFhhbGhRcFI2MGUvK1VyMVlObzlh?=
 =?utf-8?B?WjgvT2NPTDlHWkNlNHhEdWlzZ3NXeGpCTHU0YlFmV3pyRnc3bURmTDE2ZUVN?=
 =?utf-8?B?eGlqY1A3aWcwRzZURXV4MVhMWHNBV285em1FZXZNUFI4WmgrdXM1UVFLSHpK?=
 =?utf-8?Q?F0MG2CMJL7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2t6ZGJJclliOXI2bkZPSnlTTHF2S1ZlSWxGdUt2RngyNGdBNmRGZ0pNSHRo?=
 =?utf-8?B?Z1lqZ25UM1lIcTFaZFBqVWo4NXZDVDZMUFI0QXQzZmMxT1hGampxb3lwVGRk?=
 =?utf-8?B?dkdVMU1iaXRCb3VRbWpkUHB0Sk01cDZCUEprTEIxZHhBbmtPbEFmNjBrWFFJ?=
 =?utf-8?B?NlRiY0ZIK2laZmhxWm5JOGtpTHJKY09XT2I0RjdYWTlzZUVwdldUREZTdzBq?=
 =?utf-8?B?NEQ1anZFVlEzRnI4eDAvbXBPL09BVENLZlkySnRjODI0ODlyK0tZN0ltQXBB?=
 =?utf-8?B?bmp2R2RFbGg1aFMxUFF0aG1VTDQ3Skd4K0R4a3lSR2VNc21xUGdtR2t5cG5q?=
 =?utf-8?B?OFgrTGtEOU5DSFJsZDJ6MEdySERVY0UzKytPWVRGa0tJOHhXMXV1ZXMxVER5?=
 =?utf-8?B?VHhwY2VIWmc4MFkyQk9lWHRzeHpSS3dqVE5lU25hbjBmWFY3TFpGTFNuRXl1?=
 =?utf-8?B?a05pNGhYUkwvSmRGVUtYT2tzbDJPSmV6bWhEQ21xOG5hWlFaRGY4YlVZTndx?=
 =?utf-8?B?Q2xmL1FrUGhHL0JZeCtrblJiSW8zbFVYQVJORC9rSVZZdFQ5eEFndnRBTE1r?=
 =?utf-8?B?dmVjd1FiZi9ZQk5TNDBXKzM3bzlzZlJoblF0MDdad0RGdDBnd2p0Ykw1UU10?=
 =?utf-8?B?UituRUJOblJySnhuZ0NxTWhVYTNWNXgwTjF0TTdXb1paUjJUd3NOQ01zUU5i?=
 =?utf-8?B?MWtQOUdMVyttVmsrT0w1a2x1UEhGZG8xeERPeS8zWTNNTDk3ZFJtT1c1c0Rk?=
 =?utf-8?B?Ym52dG5kY1hKMEpTcWJHU0hwdkQzZEhSWjZ0VG1EWHhkdHoxTTltU2hSWHNG?=
 =?utf-8?B?MlVUU1FNT090dkk1cWxOWjYwTmZKcGlNQXMzVWN0aVFheU1JT3g5SlVZbk16?=
 =?utf-8?B?cGxpRVRDVldyZ3R3ci9BZzlWaXNlQk1FTnJxVThYejUrYTZRM2h1TG4zcEN3?=
 =?utf-8?B?bmJ3Q1lHL0g4M0gvc0pDSFVZVGNzUXRMQ3ZxSXJsQ2dzc016T201cnhrY1hj?=
 =?utf-8?B?ajlkYTh0ZDFaMFA3RmpjWDlSdUlhZWQ4bHd0KzZMYmlleGc2c3hSWDA1NnB1?=
 =?utf-8?B?MW9DUWllb2FlUnBGZmtiZjVmNS9nRU5PWEd6QUwxdkMxYkNzSEhtb2x3bURB?=
 =?utf-8?B?SzB3S3BRZWJ5NC9ZZVdPMWpDbDlybk45OE5UZGozTDVSOCtMZFljdVcvUFZZ?=
 =?utf-8?B?cWlmdWM4L0FHSW0yTWNKQWtoTVdWWHE2VWtHSTdlUGMyT1d3T3QrUU9hL2Fy?=
 =?utf-8?B?ZE9XS0dscThmRk9qUWJsV3hOcmZUYWZSQUN1L0tPSHd6bFFrN0QrZzFzTEd3?=
 =?utf-8?B?RTdmQWVKWFl5N3lkUEJEUWNTbkJYQXlMQXViOWtoUk1sdTFRZ1ZWU2RER1RD?=
 =?utf-8?B?ZXZ6Z0U0eUNjOGhhMlErTWp5cFdjaWdIZGRneTl3RjZNMHZyaWRraFppbTRz?=
 =?utf-8?B?bTdzWHVwbnI1SjYwcjMzRjZKRWNJN3VKdHk5VlNPbnl5SFpYUzFXVi8zb2xN?=
 =?utf-8?B?NzJVMlFiVm5QYmE1RTJoU3c2ZkhhRFNOdFp6OHRwaEFCUHdlUXZkU0lHbWZ0?=
 =?utf-8?B?NStaMVJYZXhid0JkWnRzelEvWmZhMm9xeXFVVDIwcGJWK2NSWmdYQXQvS3hT?=
 =?utf-8?B?cE41RHNtWEE4OXVGbCtRYkhBdW9VQnBPL29KbUtOR2tuZjJKQStkTjhORmxP?=
 =?utf-8?B?MlltV0tHeTk2WVpBYll6eFdLUHFJaXNCckd4bktXRUg3dTYyd09UcmdVWEVv?=
 =?utf-8?B?aFdhb3pZcGtXZlRQV3Rrblp4ZnNrTXZGeVZ6S1VlY2hKU1JRVytnK1J6T3pB?=
 =?utf-8?B?b29LM043MFNUWlFacmxLd2xENTJBUGxIdzhnNnllMTlQTmJwMS94STR2WUli?=
 =?utf-8?B?OFp1SS9yV2U5dW1JaEJFcitYUFFEYXJGK2pDVDJ3QkI4aXJ6bzFHUHFIenNn?=
 =?utf-8?B?YzZiTnluemEvUW04VStjSkphOHBiL0o0VVJvbGVtVXdPL3hqeldJVnQ5WEUz?=
 =?utf-8?B?dm80dzFXbkpxZ2hlT09uRmRYOWk3bHk5VzFoYllaQWtsdll1NlF6VXhWRHlt?=
 =?utf-8?B?cWNGSlZVU2ZHN0JUdDB3d3dRR3ltb3ZTN25rdGVxZEFvV1NPZXZiZ1BpOTdh?=
 =?utf-8?Q?Lr9oCTZRegeN0XRJ+jNKT5Cwr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5a1b6c-fa34-44e7-ba7c-08dd8e39e78e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:09:10.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIejir5zIACGvXMbc1BQww05T2kmS59duPsM94aV2EVmN/3yOIugDXJ+z4aMHZ0ZwTSAavcGRTQnSiDT9HuaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242


On 5/8/25 02:13, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:14PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
> This commit message lacks a why.
>
> It would be useful to state whether or not it makes any functional
> changes to the existing cxl driver hpa handling. Seems not.
>

I have had to think about the why and I'm not sure I have the right 
answer, so maybe other should comment on this.


I think with Type2 support, regions can be created from the drivers now, 
what requires more awareness and to find the proper HPA/cxl root port. 
Until now regions are created from user space, and those sysfs files 
hide the already established link to the cxl root port ... but I can not 
tell now for sure how this is being performed at decoder init time where 
a region is created for committed decoders (by the BIOS).


A comment from Dan will be helpful here.


>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  11 +++
>>   3 files changed, 178 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 80caaf14d08a..0a9eab4f8e2e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,170 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	/*
>> +	 * None flags are declared as bitmaps but for the sake of better code
>> +	 * used here as such, restricting the bitmap size to those bits used by
>> +	 * any Type2 device driver requester.
>> +	 */
>> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
>> + *	    decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(CXLRD_DEV(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 4523864eebd2..c35620c24c8f 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 9c0f097ca6be..e9ae7eff2393 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -26,6 +26,11 @@ enum cxl_devtype {
>>   
>>   struct device;
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +#define CXL_DECODER_F_MAX 3
>> +
>>   /*
>>    * Capabilities as defined for:
>>    *
>> @@ -250,4 +255,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>>   int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlmds);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>>   #endif /* __CXL_CXL_H__ */
>> -- 
>> 2.34.1
>>
>>

