Return-Path: <netdev+bounces-220476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A236B4646C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73E27A9058
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3230288C3D;
	Fri,  5 Sep 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="jY4aK5Ot"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2118.outbound.protection.outlook.com [40.107.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D428640D;
	Fri,  5 Sep 2025 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103121; cv=fail; b=EwzLUwA42Agdjzh1Et8E0M05Wrd4IvQwBeqTd38yyhJ+XEuifS1iyxImMcNh4NJrotK3SG21j883FaOHq4apyi59OKMF5SIyuoRMuZleCV9g/HqZMfhnkNM1wuh+nq+49/muFq2qeGc4k06N1Lb24Z6yNM8XgGFG/DDtSe9ZhS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103121; c=relaxed/simple;
	bh=+duclj+UXo6+WTh5/LaezsGgJXqq9kJg4GnJi6iVVF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSP5hrUa1GXtaZe5fsG3QsmjpNTz14+KYQdN7F6hbP7PR1muHWSeYtkE8DKkLuWbxAKQDlRDr+BU8jPF+1iwd1ev24wvL1d21OSWrCapcdhb1tP0NG7WfNUu9g2TBCU6ufyOvR8vjZOua0ORr8vfE/ggiKxl9sA2ePUp2OpJ6hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=jY4aK5Ot reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qusUxertVTC8PhLMKu++filb9Gal+ePvTirmaKX0Hl6mDxE9XoywKAfLE/FYF1iYSE1QZmN7RvjI+db8UdwEkTOVgvEFcxp20p9raoPSL9h2G66V06p+wTcgwG6LHiK33m1dZn1/M9t3hJMlifFv3Sm7NcoqOL5MMJoEgUS0aNrlrcyHvfItvUJh6mBUL+0l2EWlS7PbQsFeiOJh/h59/zAA60WOx0EOtvuNfYMu80gIBOkKJt4AFgerV4iUFqYNhasIfaYObpkTlvK8VMm4K6Q6m+Ewj5s+Kd5YXTKjWrZTcu9Ok4XQNuyKEiVu1ajd7O6XoZ0OPY+ap5duiC/56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm2mhcY4xU3I9nBFiunVzMm+hD/0egLpQuaDX613+6g=;
 b=CTeBYwWb/rhEniaHW9ESNd5KnHhqeoKpboN9iouG+H54+lLXxYFnTfMiIZjo0tMM7Uwp4QFWs07Vn8bc+hBzvDug/PYeQoIjkH3JAYgpRUqRv0u6SEWMmDrPr4vapAyxlOZ0O0Yl6XSvjxkeE/ntR/bItMAnygGRaX4rOp72/RaFzwMZUUEd/BUkzLyMTKDeNYiHXhDrSOgCREtY0kzV+tDpK+VVZAEJvfJwRazzbEOm54r6d4AZ9OW9bqgQdfpOo4qraETP5ZhYpkgia+VMd5axJE8Pk7WjGpBt+uXpfa+y6EIKLzB1ZQNEbSonwbRCYvnaLUbIgp7iHMvsdTEHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm2mhcY4xU3I9nBFiunVzMm+hD/0egLpQuaDX613+6g=;
 b=jY4aK5OtuRFlOg6sI2n3GD9OqhRAm2QtwCiW9/QyHaRJa4ZDX0MpDlW5+fPEvnSYRf17Zs+uC8nFDZJm4lwZbfds1QIRXguV1izyL+xUYdfHiawl5vUiPxfCafnErDboGykksAqNvQ/MVTGFQa+LUjgtLZYah63Jqe9BuNCiweo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8262.prod.exchangelabs.com (2603:10b6:930:c8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Fri, 5 Sep 2025 20:11:53 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:11:51 +0000
Message-ID: <b577d90e-e8e8-4117-a5a0-c6644f2bb151@amperemail.onmicrosoft.com>
Date: Fri, 5 Sep 2025 16:11:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v28 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
 <20250904040544.598469-2-admiyo@os.amperecomputing.com>
 <b4891bd683d4802d6ab3c542b446c14081ecf8d6.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <b4891bd683d4802d6ab3c542b446c14081ecf8d6.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0120.namprd15.prod.outlook.com
 (2603:10b6:930:68::9) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9f5384-a23a-440b-84ad-08ddecb8739a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEUweVppeVB0M2JsdU5uSXlrUEZQMHFwQjZqM0lBZGdybUg3anBQb3JNUDds?=
 =?utf-8?B?VkFaQ21Rb2NPdlQvV29Ob3JyczNRckovY2FZMEs1Mko3aUZxaUQrSk8yUHNB?=
 =?utf-8?B?eHM1MHpCSTZzdkxyYlpLMmF1UVQraWl4djV0N2VEL1Q4RkpKVUxlb0kyamgr?=
 =?utf-8?B?L29QNitTL2xnVnVnOEZiYlhZQXlkNC9RdGpyNDFVbUJ3VEx5RzdqLzZSZEcz?=
 =?utf-8?B?R3BsaXAzRy9BdjZ2azN0NHJPQ01UUkdtc1dNR0tyYXVHdUExbFlKWVdoZDR0?=
 =?utf-8?B?SGkwS2NtSWxKSkxoUkU3V1plN05BalE5VXdLL2gzR2tza21LR1B6cmx2QzNT?=
 =?utf-8?B?NmE3a2pPWVJSNkQ4enVBemhqR3FHY0RjTkRvRnMrQnFqNkpBL0FCbmUxLzlo?=
 =?utf-8?B?b0s0engxZmpqZ0E1MWNTUUpNRERtbG1iRitKTitpVlN2Zm15TXkvcC9vU1Bu?=
 =?utf-8?B?V0dLSEtNbzR5SnFQVEdXeW1KeFMxSDF4Q2w5Z2lmQjArdlRULzBqR3BFSGUr?=
 =?utf-8?B?aldWaDgxSXBXdE82RUN1d1g3RGxxSUxVUkdMd1lCTll1WFJkWUVIbmMvcFBn?=
 =?utf-8?B?bTgzd1dYK0FVZzdKUnVpTS9XcEtENk1QclJDVktxOGI2M0JYU0cvU0hiYWZy?=
 =?utf-8?B?N0c5dmE4aEhQN2o5SExCRkZqeDJMZEFoUzgvSUJWajJ2cTh4YndtMVFIUHFa?=
 =?utf-8?B?c2xBRjJGeUtIalRGZkFIdUt3bUowU3VvOHdOTTFCOTZhdk11N2VvN3RONUhl?=
 =?utf-8?B?MnFMSmZJSU5qT21iSDN5UjJqT0N4L0NjeEJSUEZVV1VIT21MOTBtN3Z0c2FI?=
 =?utf-8?B?eU1Sc3kxeHhPeVFGNGNrcWU0MXNJWXFiUUFHQnBHMWM2ZmR2TXR5NDhxOGdi?=
 =?utf-8?B?akRZeUh4M2dpaEtoaFI5dHh3dG5EcVJrdG9jNW9TVFlQRDhQWWNkd2wxb3Bz?=
 =?utf-8?B?RGY3cnF5b1hBTTRtd2dYN1ZOLzR1L0haU25CS3NDcWFCak85bVAya0gxejhO?=
 =?utf-8?B?T3JKS0pQSnF6YW5IVkZCQ21jMGw3c21vSDVVZk9UQS95aWhBVS8wWWxhcENo?=
 =?utf-8?B?Z3VTWWxJVGpDNVlRcWs4M3lnTmprTGo1TmJzMTM5MzdTTzVTWnFYbWM3UVhs?=
 =?utf-8?B?aTJwYTJ2VFpCVnVpUTNydFdtOExkOHdRMjdZWHBNK3Y3MW85b3VFcUdDWGYw?=
 =?utf-8?B?cFpaS245ZkhiczFReTlVS0oxOXNmYVAveHQ3K1VvOWR5dnVadmVPVG1GaHNq?=
 =?utf-8?B?VHZHdlAzVjlpcE0rbExJN3BLck9JMDdwdS93QzVCRG1MSnIyRnh0dnVNRVFP?=
 =?utf-8?B?SU9EWC9LYkIvRnJROGtmcWRZZlpZY2tha2kyTVVibU8vYTJSZy9ubGZWczFS?=
 =?utf-8?B?L21hOEJDc3ZEQ3ZDWE1IWk85RmR0UUhZdDlRWjFydDNZekxYbzRtM0RlSXl1?=
 =?utf-8?B?b0hOY2gyVW53V29BYmpSbzV1UmtRenp0T0d2ZFJVazErMFpiUDl2SkNUa09Y?=
 =?utf-8?B?YmdnaStpU3VFaDYyS3B5REJmcWFiV24xQW5NeUUxNDhUYlZDS3ZNdUFETUdQ?=
 =?utf-8?B?KzdyQ3krVkhWQUNjM29vQ3RmR0gwNFlkSmRET0pteTZ3LzVJZk9BOVZiVkJt?=
 =?utf-8?B?ZW0vMlFZQ0ZBQVIxTmZRNjNZVnQvcWlwTVE2ajRMWG9pejFxeTBscDNFRW9G?=
 =?utf-8?B?ZjlNSnlhei9tWnlCNjkzRG5DakJPRDcyeC8zdFR0dlcxdG0yQnRyWThPU0pO?=
 =?utf-8?B?c3ZLbFdwL0tjYVh0VS9FbDRqbVVPV1N3bUpycjBVeEdzWHpVYUpaUWR4dC9F?=
 =?utf-8?B?emxENmFZVlJVc21UNHdjYlNHbjNQNHlKR21jUlFzT01wR2h2MXNWL1dlZ0d2?=
 =?utf-8?B?bDhvZjdZRHd2UDZEcVNkMjBXQjZCdUc3eW1PVTI5R29jRzRReFRFbVhKY2lZ?=
 =?utf-8?Q?2uuelT6oAC0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJQUFYrSXBaeXJkNlB2S0xmWFUyWmY3K2xOMjRGZFJDcW1lemIzMGF3WVFR?=
 =?utf-8?B?VzJPcUJqLysyOWc0MzJVclgyVjJ3c0J0T3QvOFRCR1JTNnpqczJDZ1BLcXNZ?=
 =?utf-8?B?RTNNZVkzQjVPQTljSENITllRSEVmY3kzdmd2aEhZaDJxOEEyNTJQVnFyaXVz?=
 =?utf-8?B?Uyt0RDNCK1VGM1lSQmJsVkxDTVhTYUlaV1NRR2NGNU5CSGJZa1FqWUlzclkr?=
 =?utf-8?B?M2FpK0daNFRvU2pZYVM4TDhETW1kekFVWFVjaHpzQkQ4UWxIT3ZMZDlLZkNM?=
 =?utf-8?B?NFlQeG10RWRRZW0rQ3B1eTcySjdtZkdwQTBybkFvS0ZQdFA1NFZiK3RGQ2VZ?=
 =?utf-8?B?L0hLazlMdFNpZndGWnlxVTJVQXg4cVBzdlc2bFdzYnUxd1pNMWVDRHRJOXpF?=
 =?utf-8?B?bE50bzJRQW8ycnA3dUhHM3MwL2czTDE2YjZlOVkxMnVxTWcxQmNiWVZTNWRw?=
 =?utf-8?B?VnRGS1FHUGtUR05ZeFZqUTM2QXphb3RGcVVreGNKSk9hVUE0K2FHK1pSYjB6?=
 =?utf-8?B?SjhyNEJZdUpidEJGdzFObTFtRHNmZkFNMEt4eDVtblFleGlxRW5FM2RZVjdJ?=
 =?utf-8?B?QXZmemdRS1RscUZ1L3NHWkdDMSsvVVRVWGlSTm1OSmsrVTVnd3ZGbCtJVmpm?=
 =?utf-8?B?ZkxmNFQ1RHNhVVdkUmlXMUxUSGNOOEpQRGc0VkxpSEdmdlhjSFVZNXhMQzRH?=
 =?utf-8?B?RGx5Ujh1cGVGZzh0NjhhdTY4YlMvVDQ4dmJsT2tMZVlGUXNmWlFFdnJQWFdS?=
 =?utf-8?B?MDBlZlhRNGw0NklLMStieE5YZVA1UnJWUFJwaWdyeEZMWVk5UFp5UmVXdGpC?=
 =?utf-8?B?WGcxdFFhZjVCMkJXTUYvbnl3MzU1aGdvMEJKajh1Q0I3T2xwZFRvVFE5aHYy?=
 =?utf-8?B?cENLL0loRVFxM1hQWTZ2ck03Z0p2MFlUUFc1TWIybVl1L0ZjUW9YYnAxeksz?=
 =?utf-8?B?RWVCVE10MXJWMzBlN0tScTIvV0p3c0tDNkZsUWhSelNicWcraXIyVnVwL2xa?=
 =?utf-8?B?clVkY0FCVUFyNnBQbmpvMDRNY0dCRkxQN1k0RndkY2FkUS80Ly9ESW11anZY?=
 =?utf-8?B?dmlSNWlQSDBoWlM4L3prZjVScHQrV1IzWENKY3FxeXNIdGRjNDI0S2lzK29G?=
 =?utf-8?B?MXl5YnFITHNiQzBBKzR1VVNnQXB4NnpHWHBwRDVFbU9KMTZhTXFva0dTdFA5?=
 =?utf-8?B?c2xMM0FVa1VnSGhXZDJxNGxIRGtaMGllRnJpM2JOenlwL0VLZlRsbDRnajho?=
 =?utf-8?B?eVMxTFN3S2cyYXkraUJ0cXZERVVwOTFRYVlYY2R4Tzk2bFNTYStBek9GYVA0?=
 =?utf-8?B?cmIrei9iMGhSSFUxU1lkczRldTdnTTN0bkhUZ0JTMFpIcW1Ud1pZOXBXbmdE?=
 =?utf-8?B?RzhuSDF5bU0vdm9aa0I4VFg0OG1kYk9OU0tUNHFzZWtDMzR5SHc2NGk1V3Zm?=
 =?utf-8?B?TlVSUHhsQzNMY1hHNFVIZTlTb3RLa3dFdjkwVkd1TTJqTGJGSGw3WHpVVmJM?=
 =?utf-8?B?bUtiemFzUXpqdjZISWZ3UkZialZPZlpsQVNYdHdTWVBZSmlVa3IvT2tNaGJy?=
 =?utf-8?B?SEZVaGQ0MjNXa2x4TStBbzc1Z05HZ0pBMzQrY3hsOXlPbFdoL2Q1VkVIeW1P?=
 =?utf-8?B?NVA1YXliNmRiYzBZL2NhMzZUM0kwamxFVUZqSUxSejk4dC9sZis0V1FNQjRs?=
 =?utf-8?B?MWw5Sys2OEZsNXpjVnU0clc0UnV5K2xMVll5S3JuNUI2RDhNZjN0WnVOd1Vy?=
 =?utf-8?B?RndoN1hrVmsyLzIxT2xEeWZEV2tjRE5VVGNKQnR1VXZWWVRQeWdyaWx1OXJr?=
 =?utf-8?B?dlJ4OUwzcVFnS3NXWmM3TEVCZ2lxRlF0elp5UldseWs0U21wVFlxUjYxN21U?=
 =?utf-8?B?bGp0ZUlJYTBXVC84UisxSVdybXY4NnBNbGxHOGtRQlhzYnBFdlYvZEdJd2lO?=
 =?utf-8?B?YU53OXZFYmlDSU9RZE1BeDZ3bk5ackxSVkxOcmorRUM2RlNJMzgvS3BCQzJs?=
 =?utf-8?B?UnJHclZUMlo0U2ttYzBFaDlqQXJ5cC9WMWxxM1ZLVHlzdm5kbU43VE42NDd6?=
 =?utf-8?B?Z1pmWjhLeC9vc2lPYkYzSEk5c1pYSkxpd25aOWd4SW9GQWkrejNVdm45d3Ar?=
 =?utf-8?B?dWdkNkFjSHl5Vld3KzF0K3pvWjZFcnpjRDRTM3JQWURCYlhleEcycDkwSVNR?=
 =?utf-8?B?MzhBZUtDVHpTSVlYWkRPK1QvZTFQd0hIL1RBR2tzUVhWRkZNZjdrN0hNbllD?=
 =?utf-8?Q?kKicBszO2yUMqDeRG3Z8iHlUODQVxsyz2zMcywm3Jc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f5384-a23a-440b-84ad-08ddecb8739a
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:11:51.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxhNxM084iuAVDD4cUkeSsCD3MNgDWsDPKRIbqGv8IYM2Jz+I5NLi+AcqszgR+7HspyFP1ilMDHQpzkWKz47B11Dqou3YTTPLaC2XQeHegG0AHiXPZOylg0jfvWXo4WC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8262


On 9/4/25 02:16, Jeremy Kerr wrote:
> Hi Adam,
>
> You seem to have missed any fixes from Alok's review here.

Yes, I missed that message.  I will make them in my next version.  
However, something more significant in this one might delay that....


>
> Further comments inline:
>
>> +static int mctp_pcc_ndo_open(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev =
>> +           netdev_priv(ndev);
>> +       struct mctp_pcc_mailbox *outbox =
>> +           &mctp_pcc_ndev->outbox;
>> +       struct mctp_pcc_mailbox *inbox =
>> +           &mctp_pcc_ndev->inbox;
>> +
>> +       outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +       if (IS_ERR(outbox->chan))
>> +               return PTR_ERR(outbox->chan);
>> +
>> +       inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
>> +       if (IS_ERR(inbox->chan)) {
>> +               pcc_mbox_free_channel(outbox->chan);
>> +               return PTR_ERR(inbox->chan);
>> +       }
>> +
>> +       mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
>> +       mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
>> +       mctp_pcc_ndev->outbox.chan->manage_writes = true;
>  From v25:
>
>> Minor: you have the convenience vars for ->inbox and ->outbox, may as
>> well use them.
> Also: you're setting the client rx_callback *after* having set up the
> PCC channel. Won't this race with RX on the inbox?

I think this might be a deal breaker.  I was trying to avoid making a 
change to the mailbox API, but I think I need a new client scoped  
callback to replace the one that I added here: there is no way to avoid 
the race condition without an atomic request_channel.  I added this to 
the channel (there is no PCC specific client) to try and minimize churn 
on this set, but I think I need to do it the right way.

And, since Sudeep is unhappy with the changes to the PCC mailbox anyway, 
I would expect a rewrite of that layer to happen before I get to address 
this.


>
>> +static int initialize_MTU(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +       struct mctp_pcc_mailbox *outbox;
>> +       int mctp_pcc_mtu;
>> +
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +       outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +       mctp_pcc_mtu = outbox->chan->shmem_size - sizeof(struct pcc_header);
>> +       if (IS_ERR(outbox->chan))
>> +               return PTR_ERR(outbox->chan);
> You have already dereferenced outbox->chan before this confitional. Move
> the usage to after this check.
Will do.
>
>> +
>> +       pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
>> +
>> +       mctp_pcc_ndev = netdev_priv(ndev);
>> +       ndev->mtu = MCTP_MIN_MTU;
>> +       ndev->max_mtu = mctp_pcc_mtu;
>> +       ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +       return 0;
>> +}
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +       struct mctp_pcc_lookup_context context = {0};
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct device *dev = &acpi_dev->dev;
>> +       struct net_device *ndev;
>> +       acpi_handle dev_handle;
>> +       acpi_status status;
>> +       char name[32];
>> +       int rc;
>> +
>> +       dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
>> +               acpi_device_hid(acpi_dev));
>> +       dev_handle = acpi_device_handle(acpi_dev);
>> +       status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
>> +                                    &context);
>> +       if (!ACPI_SUCCESS(status)) {
>> +               dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
>> +       ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
>> +                           mctp_pcc_setup);
>> +       if (!ndev)
>> +               return -ENOMEM;
>> +
>> +       mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +       mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>> +                                   context.inbox_index);
>> +       mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
>> +                                   context.outbox_index);
>> +       if (rc)
>> +               goto free_netdev;
> 'rc' has never been set at this point.

Artifact of old code  that has been moved.  I will remove the RC. 
mctp_pcc_initialize_mailbox is simpler now, and has no failure case.


>
>> +
>> +       mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
>> +       mctp_pcc_ndev->acpi_device = acpi_dev;
>> +       mctp_pcc_ndev->ndev = ndev;
>> +       acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +       initialize_MTU(ndev);
> initialize_MTU() has an int return value; either make that void, or
> handle the error here.

I will handle it here.


>
> Cheers,
>
>
> Jeremy

