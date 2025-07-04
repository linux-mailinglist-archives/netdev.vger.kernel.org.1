Return-Path: <netdev+bounces-204177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B309AF95FE
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C3E16F1CD
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE019AD48;
	Fri,  4 Jul 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v3Ftp4VG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15785143748;
	Fri,  4 Jul 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640673; cv=fail; b=LuMzX8YdQ7Ch4eOc2g5r6b8QN7QmgMBjY07nHqCD7ye3/eXwL/bRwuaO4nwLBHm9LyTxVf6q3YXJEKv1rW6nMGskXm9icnPogQ2Lruqh2j/cnKF3KEwRzctbBhVF8TAdf7j0GPHHIn3mZBSNUdOIYpPtVHEvSVk+ke05bLGccbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640673; c=relaxed/simple;
	bh=8iO0XqUMg6kd4LHn6YkmP9qxXGuW48VcqRUmpYpDRKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qm0S3msDtxenc5KGtokQ5hzdMtnUWZu2cYgjGw2Qn65jok/fvoRqhrZmQfFmdbXiDCUdH8/kJod/bx19Rd0YryCpDatiOTFbinA3dIwzH8itDwhVOC3jBEhXz9Qw7tc71au20pc/xB+xo1JLallUJf/xVt0dOlQSwT90SB9hKdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v3Ftp4VG; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNxofOaItB+zk6diSkcTRAz4Gy+XKigRlVpe7PZH6lt3Cf01Sh6mtqEFHA/nws1ik65+TvvD8uIJwPsBLG+rzMCqlJ8RTFgjtIIggGzgvklxoKJAno91CPhidAxg7hKv/L1c/WreDF3wLxC5hNnaKxoAtTJAdQDWYnsneY5q0j0tVnM+Ghhq7YgiLErMF8r3o155AGVlQi9rr5BsNIaY+rFllntdSmfOz3oeQfTegxkuMZCFTtO4B52ZClzmZxh6w4Ai/p9ajTPUbS3TPiJnfW6wK+tIFR16NwYc7NmzL9ndii4J7ywWK27O8YBGXkWzUjHSEbNmHc7UgCWJYXcN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgkQwMwgkkwcnbGO5lTxlp3rESpoTefOpOku7XwO6qs=;
 b=QEmcarlknB6rQ/MB1JgWa+ZwDc371CoRsbXs3DhjW5mRpX5U77h+4ffYnXX1kOwV//zBpPH1WDT7T71gEfk5FMpaBsqaHAbFZWgG4cKe8LEMVIHJgfn8j2PssrNou4ZP8AGe3NGmgfiW3skIpqfR4O1qrIZypu2iv0gi/kex8b+5ySmKc66bW4wmgUrEegWsztDOBq+zL0qTbqne0Onmfo4IJjl17WKDD+CgxToMGgS7Fbj9nEIZFj5WxKeCiSTXrIzVMmPRMSXARywUeQvygs09p/esHrRXFDEA+Uqcy7qDfyqmLb/ihH+BNwunUQoJTiD7a3C3JxebtDUN3Y8c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgkQwMwgkkwcnbGO5lTxlp3rESpoTefOpOku7XwO6qs=;
 b=v3Ftp4VGFST0guJkfB+YBLxe4fCO1cfTNaDxl6N4ix7dEf0y4T+jR0KYkm6GKHrS5wJzBIr0fsRzOAKeMKcACP9FxOMGh9bw1vlH+T21biYLYoUPrTMS4kyaxFgshEVRti7J/KUOncP+Ri+J5w+SbsJKS3CDyyiCBIeva7bzO48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:51:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:51:05 +0000
Message-ID: <6a2cb965-32a6-4cce-9072-aa815e7181c0@amd.com>
Date: Fri, 4 Jul 2025 15:51:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/22] sfc: get endpoint decoder
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
 <20250627101024.00002585@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627101024.00002585@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:8::34)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 09439cbd-add1-4294-6196-08ddbb0a33be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzRnYmd0Ymo2NUpQK0REamVKN2RpSGZOUWVZSmlkTm9wMHJqREFDakt0ck9n?=
 =?utf-8?B?OWdrUVNzUTZrYWszd3lac1ZjaUY0RG5jRjYxNjYwd1NsMGV5SjZrZm12UmQw?=
 =?utf-8?B?SVhHU0d2ZWxPVjZ3aDB0ZXIxZGZmbWZjV3RxV0JBOXFVSDR4TUFmMncyUHNw?=
 =?utf-8?B?ZUw1MW1qT1lleURtaUw3cUJTNzVqMytRVlFnV2VJQ3lzTENiL1NqbHFtTFVB?=
 =?utf-8?B?ampsSDRNbWRWZE9kRDE3TWlPbVJZZDVLallmUi92M3g5dGE3VmdvTExXR1g4?=
 =?utf-8?B?UHNwZWN5Y3ZaVnhkRjlNcUt6VEY3MmxmbWNrYk5tRFppUnFFam9MTEJZNWk4?=
 =?utf-8?B?MUEyUTNvRVNFczlXVmVKUWdNejltRWU3cTJubUJHMk5Odm5TMXpFN2VMY09F?=
 =?utf-8?B?Q3FnUUhrWXh2WnI0aDREOS9iSmthSG5wbExvekgyZWJhclluWlZoR2srWmZK?=
 =?utf-8?B?Lzl2eDJiVldoL3VyWFBWb1cxb0JlakVQcng3bjRCZlJ4SDZraXFoR2xzN1Nw?=
 =?utf-8?B?NVBQRUdBVWwvWGxGV2VXN0pTZi9VVlNhY0RHVzdpR2Q1VU1ITEVsclVTNytv?=
 =?utf-8?B?WG9XMlEvZVhoTm5HZEF0NFpIUUprUjlGQ3liK205OXRqY3IvYUFLTW5rMXdz?=
 =?utf-8?B?SG5OUTFQQTdpOGFxS0Q1a2UyUzVTSnkwSlVwR1czOEJId2lXUThFOUROUVpG?=
 =?utf-8?B?eUNObTVxM2VzTmtiNlhSZmJNcDhSUnB1SDFCTjlqTUdHM1dWVXNQNnpGekZr?=
 =?utf-8?B?bG42L1Z6RzY5eklSSEZrTGZGcnh0cU5jODN3SWxRbzVwU0M5bzdtSlhiYmFK?=
 =?utf-8?B?R2h6VTBEQSs3R2N0NTdvUythQmpnOXZUd01ESkJPajRNcmt0OFdGWVBOZ05u?=
 =?utf-8?B?U29TVlh4bm9BbkYxSmUzMUw5dHhTSWxJU3l2VmZEYkJ0Y3JqUFBleWhjMWlZ?=
 =?utf-8?B?d2F4Sk1RVjFMb3FTZ3I3dWdUUHVPa055RGRZK3VQMk1oZGtsRTc2Z1NWakVU?=
 =?utf-8?B?a2xuS2ZzRGRlRzNTcXNJbkxTT0VXbCtoRlkrN1JqY09UdnZybDJNVmg1dnZj?=
 =?utf-8?B?TnBxVUkySmlZbFQ2U1cydVQxaXozcjRnVFAzdTluc3owd1pxdVhQMzZHU3RZ?=
 =?utf-8?B?SWlGMWRBVEVSbDNJYzNrVlV3ZWsrb0lnQ1FRTnBpRVRUb3hQVkdGYmQxS09q?=
 =?utf-8?B?TDNWbzZERy9lNEVXdU50ZWJlTi80Mm1sRW44MFJuZjFGOW1hYmp5TXVDZHUx?=
 =?utf-8?B?NlY2dVlxT1JFTlQxdmZnZUFkOVRZWkx3U3V0b3cvZVRTRzFiYlF2OTBzdFY0?=
 =?utf-8?B?UmgwZm02RjRXcmtBRmJDb1laQXFjRVU2TEI3UHcraUJPbmk2WjVTV2p4RU91?=
 =?utf-8?B?dHRGOW1FZnp0aUNNU1hQdWpoUEh0WlFQSFJZMmswL0JZR3dxajNNeTEyTnpr?=
 =?utf-8?B?ZjlKLzR3Y0ZkeEFiUDFGSDZIN1BJRWlySVhQRUNwS2VWcTA5dkpCaVZ2ZTQx?=
 =?utf-8?B?OTNXR00xTFlGSW9DWDRMSVJRMlF4MXN1R2NUbUYyNWFPZGUrOEJMTVJURFVE?=
 =?utf-8?B?VGtEWVh6QU5XeWR3SVRyZ0RybTJDbjkwbVJmaWgyWXE0SjZyU1lJbThobHJ6?=
 =?utf-8?B?K3FSQnRxQ0hlMGIyL0x6MUdqeGZPNFVEU1ZLUjVFVzFpMFRDWitvczFyZjlh?=
 =?utf-8?B?ZE1IQ0t3Y3QzNWtZb2dDYXZkbDBjUFVhYUZ0aURsNndCZUFaaWVYWmRQaWVU?=
 =?utf-8?B?MXhkQ1pDcitpSXR0RWFURjhkcjlvZndlSitjY3c2Y2JVMDc3cSt5bjV5OHdS?=
 =?utf-8?B?QnN2MzJiU1BFSjRxNlBEcnIzNVlWUS9RZnFod2JNUGovWEppZFhNbW9iOWR4?=
 =?utf-8?B?S1VzelZqaFo5SXppT3VqM0pKSUt6cWdRZlNGTmQvUVpsKzJzd1Z6eFd3R2lH?=
 =?utf-8?Q?Zh+jss9RkrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZURXVSeTFpMWUvK255YnV6MXVtMVJISVh4TFdoc3dWbTRTckRiVFN1bTQr?=
 =?utf-8?B?R0dVNlhmMlhjZlpxNDFlUVBaUjErc0wyZ2xlMGRiSDdLTkhtbmV5MU1vZ21R?=
 =?utf-8?B?Q052ekVpdlNuNDdkZjlsOXBMeHJWQmdqb2EyVEdNRDF5NnF2Rjl1RG5kVk1Z?=
 =?utf-8?B?MmQ3Z2ZvSlFTdlFlcDBMTlJWU2FXaEczUmlsdXN3RUpvdzUySUJIWjhWbFFE?=
 =?utf-8?B?bW9icVhyVjE5Wnk0eDdBVVlHVGdrRStsdzV6NFVBbzhRaXFVVHRaWkc1U0Q1?=
 =?utf-8?B?c0FrczBRMVJVZmxmQ3lPVmZod2JGMEQzQStRRk10VDVlTVVXZTh3SmZFNFY4?=
 =?utf-8?B?VkhSai9OYkxJNmRTYUpzd2xuVHJ0NUtWZTgrZXV1SW1FVEZsb1hwNnU2Q1lX?=
 =?utf-8?B?VHZ6NDNGRng5aVJtMDJ5L0Q1bVlwd2wvblkweUQzOUREYkVXYnA2S0ZLYXlh?=
 =?utf-8?B?QW9WdUJHZGI0Q2NHT0tpeVBBZGFMQUxBM0Q2d0diVkZyZzl5ZitPa04zb2dJ?=
 =?utf-8?B?U3ZVcEIxOGU2cTRlM3Z2UmEvbVZiYUJqNVYxTFN5b1lHZnd5VmRZN1FBNHlO?=
 =?utf-8?B?WUdMSC84VHdiNUE3NndqQXM4OFpwRG85TjlsNTd2ZVdDOG1QMkF0eGJHTHlB?=
 =?utf-8?B?RENpQUZITzZzeG9JelhGc3lRcTJkWkdpMFFKMUVOQ2I2NWxhdThWS09jczNQ?=
 =?utf-8?B?Qkt4VEs2UW53SnlHd25sTmliVytlWWJvbHJBdWdtMjV4YWwzM0NIVU5oenNF?=
 =?utf-8?B?dkMxOXRJa2F0cFIwbktQb3hQRnVneG16bWNac1FMQ0tPTTc4SzBva0JVSWR3?=
 =?utf-8?B?QWVoN3hQSWtGdVJGSm9RSW1JODlZNlg3bGFaTTMrV3Zqamd0enQvZnFpbDdJ?=
 =?utf-8?B?dUM4eEhyaE0yaEZYTXhoSTZVSXRabHhVc0c0L05RR1FMcVhjbHE5ODdJSFlV?=
 =?utf-8?B?RktsamZ2cnU1MTE2b3kzUmhpRG1yNHhETWU1a3ZyT0RKaDB3TjN4TENmVGU2?=
 =?utf-8?B?cDNNeHc5NWdYM20vN3VJQU1raCtmeXBTUkpVaXduVDdSYnVSSzRSS21rcXow?=
 =?utf-8?B?a01kaFFkREdkOW9YSm1mNXlMN3A4cDBVSUd2cW1idUpNYndNdSsyRlZZemhJ?=
 =?utf-8?B?ME5tVzdSRjBNa2QySEVsamRkMTB4SHRYY2pLSnZKQzFNUzNhb2J4THdaaHRZ?=
 =?utf-8?B?QWNkUi9YQzFTcHZaS2ZxUWMzNFNqekMva09CaW9QMk5iMGJZUGlCelFRMUlJ?=
 =?utf-8?B?cGFSZWtkSWJjSEwrZERLMUtrRjhwSFZWZENySHNFZnhiYTFSNGxVdE1VdkhM?=
 =?utf-8?B?QnhFUXJRdHdRK1JnR0ZwWXdCV3crbmVTbzZKTzI0SG9TbXBGc3JUTXI4MkZF?=
 =?utf-8?B?U096QWlyWjlTeTZ4cTV3MXBIR2JIcUwxWitZTmxwdFMrQUZ6MTR1Mk94S1Bx?=
 =?utf-8?B?UkZXckk4SmcyRnZmTExHNkphcWZnWFNUU0tQVk5LUmphcjFnc0hrVTRrM280?=
 =?utf-8?B?RHFQREhnMHdvVi9XWjZzL1R6dHZuT0NyT3RTaDJCNmYrZ0twWWhKOHZzaFcw?=
 =?utf-8?B?TW0rY2lpbkJTU0tUWjdybmhEUVhhMndvWVV1Rmo3ZUxDWlpKY20zR3hRSkF6?=
 =?utf-8?B?TUVJMVFHWlVpZTRYMkhtd1BnQ1hTSEhrMkFydGo5b2h5a08rSGRsS2N1ajRz?=
 =?utf-8?B?U0ZEUE5zczQya1lIYkZaSmpYMitnT1pJbWFRbTJJbmk0a2p0emlYbWVjaFRI?=
 =?utf-8?B?QmZCWlBNeitTMUdobG55NUxNWTdwY212dlVNZGpYWGFYQStLVDhSSUlQc2xD?=
 =?utf-8?B?ZVN5VU9leFRqS1diR1BVOVZITVJYNVpjd09NRTVRNmJ6RjBoWDMwUERnZ3c1?=
 =?utf-8?B?THJ2QlNReXM1czRjTWp2TVBvNSt3WkpWblhpbkxqZWZWeDFWQ0VRcm9zLy9F?=
 =?utf-8?B?Y21IQXhtdTBVeHp6M1ZyN1hTRXJ3dWs0UDNkYmYzazdMUlJnRnI4VmUreldP?=
 =?utf-8?B?aUhraDVrSFFnYkpFb3FUSzNFQm8vOFkyV0NIMjRUc210QzZzTGJObGt4ekxF?=
 =?utf-8?B?bFVMVWJtNlFSeVlOajlSMzR5UWNJSE5SU1dvTHp2RXBNMEVUeEl2S05hdVNZ?=
 =?utf-8?Q?6qHvymM5OaJEkGEOaML0rqlEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09439cbd-add1-4294-6196-08ddbb0a33be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:51:05.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWJAHk9kMNOSi8I5bFcUr87Ncbd4tbrAQOnTcV2iPzBe2kQwuNBsyQsTnpMlw373hsFHMI8t5IX0HwJtf43g3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774


On 6/27/25 10:10, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:45 +0100
> <alejandro.lucero-palau@amd.com> wrote:
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
>>   drivers/net/ethernet/sfc/Kconfig   |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 32 +++++++++++++++++++++++++++++-
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 979f2801e2a8..e959d9b4f4ce 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>>   config SFC_CXL
>>   	bool "Solarflare SFC9100-family CXL support"
>>   	depends on SFC && CXL_BUS >= SFC
>> +	depends on CXL_REGION
>>   	default SFC
>>   	help
>>   	  This enables SFC CXL support if the kernel is configuring CXL for
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index e2d52ed49535..c0adfd99cc78 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>> +	if (IS_ERR(cxl->endpoint))
>> +		return PTR_ERR(cxl->endpoint);
>> +
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max_size);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto endpoint_release;
>> +	}
>> +
>> +	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
>> +			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
>> +		rc = -ENOSPC;
>> +		goto put_root_decoder;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>> -	return 0;
>> +	goto endpoint_release;
> I'd avoid the spiders nest here and just duplicate the release
> or if you really want to avoid that duplication, factor out everything where
> it is held into another function and have aqcuire/function/release as all that
> is seen here.
>

I'll duplicate the release for the default successful return.

Thanks


>> +
>> +put_root_decoder:
>> +	cxl_put_root_decoder(cxl->cxlrd);
>> +endpoint_release:
>> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>> +	return rc;
>>   }
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (probe_data->cxl)
>> +		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

