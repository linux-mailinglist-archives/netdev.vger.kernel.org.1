Return-Path: <netdev+bounces-140765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28E9B7F09
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B781F21351
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD716BE1C;
	Thu, 31 Oct 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="hoq5spd3"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94874136E30;
	Thu, 31 Oct 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389858; cv=fail; b=kXhV0w/UW0K3VVZu2Nwd7kH1NkmcPsJddQP+y9/c6TorVC+4bcFG1Jl6hSMLFluLCFH8eU/tsZiUSfg5C2zJdzW8Pv26bHv1IzD7ldB1P+Ju07vPXepq/adZhy+hz1DRknvqSloCxI936srr8KjLi4pa93DnMO2oaUu8orQ8lrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389858; c=relaxed/simple;
	bh=+IbuHEEeffWcnythheV14616a3/pF1ItByuN4QdxEpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AdDxWPArw1NzJz40RUpTsJ39gGRxkS1m+kV+dEZbjFhgWoDtZqbwDJednR/Torma3fidwo3cpOdS6iNpV6tbJ39qvraO/LK8lGaC0s5gktM/j7XAtSFmqnsmepENqs2UbXiHDw8MzXC0qOzCw6fcn89lzZozRvibZzq+vE41Y3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=hoq5spd3 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.193.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+0Rm+wJm+X1Zruj7yDNsLd9IaHnKRZ33w6hK6N8XoUWpPAyddgi4EOeVGLun64N9NGtGUD6zmUX+sR7Sy29PcrForVMB36faeAIzGj+TH5M3hdm4WklSnmoSh+GW5aphae8AkGoQvQAQx25hJtfYaQBHJF5lDczkd3gZwceF8J70iWRt7jJY9XKg01DbPFeMcLuAUhgH9kmAaaZmNfNrZmAY6XlbW10N7kvpnc83fXuah5Y8OJTID5l+QFKpqPXS0oWZZjggBUE0JA9VEq6RS6n0H5ZLSJGtNoJRk51mh7/77KNva/MSbQeqwlrU9pA1Ok4W3IA2WipgegHYFLMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxDVdmSqmlbKdyCAF6zEoRY6idZJwZnFYCcfz6H9EBg=;
 b=v5Qqwo34aa4aPxOSABSFQ/cF6C1w4aL5AMDv8/bamTkEeqi1rGvlsaDottl2kN4mBlds5pDQGCu81AGKLXOPH06PdBxyYI7RYrEqLtALg1j/piKzGKru7t7/bnJ5pFu3BpYozGM0BCTIOoz2L/fj9oZ2KdY12/mPaUJ6ObqaFcOeKZ1IPIrmpb9b1SWP+XDJLKjNift5W0g44l3nBA5TEqPB5f+KkvegaqLby1pqwMf8JzE0F5mEfxpTkTikc0Gmzo304l3tKV1L24LpwHMAlFMQcWOep/fUOYvAjx2GSS0Qn0dYP63ixp1/MtmdaW8GSCac0xoPm7tUtjeqFEiSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxDVdmSqmlbKdyCAF6zEoRY6idZJwZnFYCcfz6H9EBg=;
 b=hoq5spd3mh5UowvkGbgXPvIchBhPZfZZ0iwpAYAgU6KsZxH7Hi/W6bS/2o9jbekBLDRRSVskXhHhMYpgDtiAujQrgEL1sSXmqkXqSpebOE5liwa4KoFZ/m1g/+/LGoOXeEL3Q8aG4S6YeAvGn2RnwY5EsPLuK7a6lTOgX20HKBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CO1PR01MB6661.prod.exchangelabs.com (2603:10b6:303:da::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.10; Thu, 31 Oct 2024 15:50:52 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:50:52 +0000
Message-ID: <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
Date: Thu, 31 Oct 2024 11:50:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0006.prod.exchangelabs.com (2603:10b6:208:10c::19)
 To SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CO1PR01MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ca8b6a-3c75-4910-8d50-08dcf9c3cc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekdXd0p2WXZickVDS1ZzQ0kzQk5hK2FLc2I2aVVSVG4zUGF1RHRkV0JhcjFS?=
 =?utf-8?B?YTNXelB0L1JlSmcxNjdKOXU4cnZkdW9Cemx5VkVxM0I4ZnF2bVNkWUEvVFk4?=
 =?utf-8?B?NnpvZHd0U2FXRG1waGozUEtsNWRvSHRxd0F1TFN0N2VvcVRLay9uSEVmMU9B?=
 =?utf-8?B?VE5lSzhUMzFEVVQzN0tkbG42ZmwxMXJzYnkxZ3ZwTGMxdnI0dTU1N0xUTVJI?=
 =?utf-8?B?QUNzTjFKbGFrNzh4ZXl3NGFybmdPZnVwR1pLSldVTk04c2FaRG9RSVF5UFNz?=
 =?utf-8?B?bjJJY2ZFalVLTXZUM0FPTEZzeFEzWXJKekRmQUpPeXY2SG5INUt3MWdkSm5n?=
 =?utf-8?B?UEVNbXk1dUF0SGhlSjRZdDdFMjFLQ051QVhXeDZXL2kyR0t2TlZnSlU4TTFU?=
 =?utf-8?B?VktRTyt5K2tZZHdCZEtTWmRybU5pOFF1cFlVeHRPMXFkd29KRXQ5UFh2MXpH?=
 =?utf-8?B?TTl4VDE0QWxwaWRDMURST0poZVVQZ3Foajh5NXdnUjhuRHl1ZjdsTkxvMVFu?=
 =?utf-8?B?d0oyMm9XbXlPRlVhTXVWamMvMmwwZmdPTFg4VUNtMEtrQkhxais2VmtrQzYw?=
 =?utf-8?B?bXlUZ285S0NQaW9NK0ZkNHg0OUxsc3ZDbmp2MXNzdzRWR0s0N0pLb2VVYXBH?=
 =?utf-8?B?VXRjOUkxTll1cGY2R2lQcWZkYjVMZ0VEc1BsUm45SmwyZlYzeC9OUEhYcGtj?=
 =?utf-8?B?SjlWWlA3cTZaZklVNENvaE9QWERtOHFiQW12a3R2S2tKRXcrenVGRWExTjQv?=
 =?utf-8?B?RG5JVEpwS2tueWpFU29pY0dFUnE1L0t6eWVMS1h0ZWQzTHNZc3gyZjBOd0dq?=
 =?utf-8?B?VmtjSzF2Rm5QSUFOZlN1SkNEdXBJOVBWcHR2bkZkSHlYTExhYkI5YmExTkgw?=
 =?utf-8?B?K1phbnBkZ0RzWS9SNkcvallubnJaVTVpUDQ2WFFDdEJsRkhxNm1xM2dHR2pp?=
 =?utf-8?B?MGdXd0Z2dGthT3BTazN4U2JySzR6bURwcjM2a08wamJENmhneWxmNCswUWly?=
 =?utf-8?B?M0tYQ0VTcDJaNXFDVE9GVkpyeVg1UWFieEpVNlNkd01SMjJUUjk0UzlYRGtR?=
 =?utf-8?B?c25UU2lnOFNNQy9INFFILzZmRmFXYTd0SFVUWUhmMi9PbkJYdDBVU3ZjOHhW?=
 =?utf-8?B?UlJsVWNIOUp5aHNMSWN5dFRtb1FlNGl5T01QaVhud3lYeXpqdXptMDc3NFpj?=
 =?utf-8?B?ZWFvaHhxYnJIbzZZK2VkVFhRemlyeTl3MDEvaW50emRLVFlWd0NPSytXc29O?=
 =?utf-8?B?eURIU2YwNEZ2NGF5QW5JOGovNTJ6aklqcVJEbCtMSHlsbkJCV0xUMXVCYmtC?=
 =?utf-8?B?YWlYWmlCVFQzMGpHb3FUbVkzNUxTa3hpYnJlWnRmNFJvYThJRktJczEwTlEz?=
 =?utf-8?B?UGlMRUJ3KzhnYXAvSFliNTd0ZGVTQzB1WTNqc3BFYUhxdjBQemZnQ0RTVXVG?=
 =?utf-8?B?aXVCUTlLeVlzdzYxcUN4dDU3eDF5WlJ6bE1yc0owZkgzWkltZmY0Q2N1bUcr?=
 =?utf-8?B?cnFjclpnZk9ONDdRcmdKc2FlR3JKdWtObVhGdUZjNU1XaVNEbDg0bUt5cnVM?=
 =?utf-8?B?K3o0UTNIQXV3djRtVjlBZ3hVbUJnN2ZQRFNGVmlBc2sxa0hUYzRva01rN0NY?=
 =?utf-8?B?NUNaTEJpR1AxQkw1R1hRMzZ4bFpMWCtuLzE4UlBQWi9aOVRrZGVRMlJ5SUlj?=
 =?utf-8?B?YXZmS1pvcjN3dTFoMkQ4R1NYV2hYRW10cnlFRktXdXI0UkVMeE5BOW9vM2ZZ?=
 =?utf-8?Q?fBghE2dacp2mPCUp3VygXLTmeIHBghKWevmNPus?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHk5cjVIK3V1Mm1VVithOWQyNE1yVk9IUUh1L2N6RUxtdHBDQUZNNCtrdFRv?=
 =?utf-8?B?emdjVHVtem5tQXZVMkdaN0NmMXR5bnJmRml3cFE3L3hKOFdGSk9nS29hNWFm?=
 =?utf-8?B?RFR4WVlkaXh1dlp6ODNFYjVjZXBPZXZ6RzRCSzhDUitIRi9wQ0Y4Q3E2WGUy?=
 =?utf-8?B?a2IxdWYxdWNja29jN1dTbFlsVG9GSlI4SUdFaGg4cHVlZnNSdnB5MGorSjFi?=
 =?utf-8?B?ZjlLTFdOc1M3b2Q0MC9ERStZUG4rMlp4aGVvVDhOZjJzaE1INXMwdUh0MVNB?=
 =?utf-8?B?N3JzbWNSb25qRU1KTElKbVVwZGhGMk41RFlOakcrczlvalZ4ZkJjR1paM2xK?=
 =?utf-8?B?dUdnU21ZYmpBUitQNlEvRmNjZnE3NldhazNaR0NGV1RjYm1WcXpkbHUxalY3?=
 =?utf-8?B?YTFJdUwxbktxSklORFBqdFhWbmZlZ3BqYU5pUjNGOUtzcG5RVWE5L0I3WThq?=
 =?utf-8?B?SzdTY2lqWm10ZWhhU1pwVlZGYklUaU81Yzh0VUQyRW83amV2R3Z1Mm9JWENJ?=
 =?utf-8?B?aXZaNE5JOHEzSXUvL3JpRThoUk45TGUwY05hTjlxMHpvRnZ5V1V0OWtjeTZT?=
 =?utf-8?B?anBrSEU3Q0pjTlR1QjYyS3NiZUhDV0xMYnVFK0pnMEhXM1ozUklHcFd4Tk5W?=
 =?utf-8?B?dDdWSkhmZjY0YlBxbDNmdE8zaFdIcjFlOHpENHI3Slo2Tkh5RHNscVFydXdV?=
 =?utf-8?B?MVZBRzd6Z2MrREo4UHkvcms1bW1oZEVSbmx5SjB1R3BxMjVPR0k2U1J0MDFU?=
 =?utf-8?B?eHppSzdFSzQ5cDY1V1llcTZOL0Q4UkxQYjdFUk03cDlnRGJhdnZka0NnRDR4?=
 =?utf-8?B?VFpRQ25tblE0bXpPUlh3TG9ZYlZKREJqZ0ZPSnVLN044NzhJYmNMeHhwYjFk?=
 =?utf-8?B?czFaa05DcEx2UkU3cGJWSklIQ2hPL0FiSXUydW1za2JaRFlZTTJpTytpYitl?=
 =?utf-8?B?SWVmUHBaSGFIUjdPSndtMzAzMmhCU0lxWlBtaExhT3BGUWdwWllhLzhraTFh?=
 =?utf-8?B?bUdEVU9TSkZ6bWFmZVZGbjVmbysvSWlYdDdyc1lKM2dqemxoeUI0dGcvNGJG?=
 =?utf-8?B?czNKTGpaYmg3bDFrYjZDdjQrcWlRaGloYlF5OUVhZldCS00wNXJXZlZ5VjFa?=
 =?utf-8?B?WGZRUG5yOUlSY2JxY3VvOUZoV3E3aTlzTE93dlhuOUxHK1drL1U2RDBnZXRY?=
 =?utf-8?B?WkhXbXo3WkcwOFFMYTVVVHZacnlhR3ZjZEhkT2loQ2txdE4wK2MyNVFRbURS?=
 =?utf-8?B?ZEsyUGsxU1A4bDRrcFpnVHJtZGl1Zk1iVUZ0Zm9IUUtJRVpPZlVhc1lRRGF6?=
 =?utf-8?B?dGkrWXZFdGZNQUR3SCtFSE50R1BwMlpmZWdha29GSEFzZFIzTXRkWExab1U3?=
 =?utf-8?B?NWxNM3lDcmVYVEMwdkhmZGp4MXBGQ1ZYcityeFl6Tm9GeE1jQ0hSclVpM2Nm?=
 =?utf-8?B?ZVcrck9pWWN4WTFaU1FLVVlxMTV6SnN3MFFwTXB0L1JTVlFMUWJ4d2lhR0Nt?=
 =?utf-8?B?aUhBb0hOMlBRdk1LNHNuMmFLOVNuU2dKdFk4a2ZFT2RqbjJrUXQzbWNqMVFh?=
 =?utf-8?B?ZzNEMk4yazIzeHRxZUxjUE5QaE9pTk0yZGVXSWtRVlRuZGUycWpvVm1GVkNX?=
 =?utf-8?B?eXdDRmRwb2VkNVlDNU1jdVh0eVdmQjBaRWgxRGVxZ3M1TG9uN3ZpaGhWUVZQ?=
 =?utf-8?B?QmNyTlFrTkFlWmRnbnQwM1J3OVp1VnFEUzlMWi9KWmY3T0lIL1RnbVRORFJw?=
 =?utf-8?B?N3IrcUJraEZrVFp1RlczbmFReTl3NGtlMHdFZXZGbXhqdlV2SWx6ZU9XWjVH?=
 =?utf-8?B?bXJiT2FZRWMzNVJ2VzVYSGNRY2hxYnkrY2JtZTRzVEJFZ3c4NlcrYXE2ZkVz?=
 =?utf-8?B?akYwdFhKTkFBZXdqU015ZFJ1US83U1MxcldEcFNaZWRjb2dUMkV2Um5TSzNX?=
 =?utf-8?B?eEVqMFRkTDFnMkxMYUpObUNwclFwVUFUOVJjM28vNmZEMEZYWjRycDRTSDN4?=
 =?utf-8?B?WW9DdVRKM0VHUTE3d2tLUVFVNmxYVkI3d3R0ckRuYW4yZmdSOC9FOG9UaHVZ?=
 =?utf-8?B?aFNmR1dqQ3p2UDd1QVdTL3FSVE53dmVjMGEvbTlTS3F2QlgyS1I0NnpIWE1X?=
 =?utf-8?B?ZXZhK3RZOTV0OWN3TVcvQVRqcWNsTzQ4eXEzc01NUWMwL29paG0rbXphRzZs?=
 =?utf-8?B?cUZWVDZvMTBTNWZRbGYzODRyR29kWWp4SmNoOXp5RENNOGNIbm02dFlJUFpK?=
 =?utf-8?Q?ZXohGkWyF+1U4IMjkdyGAC/xY++5Jaoq2V9Q/O5jsM=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca8b6a-3c75-4910-8d50-08dcf9c3cc42
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:50:52.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nHPI3a+Z73XAod9khF3wbflSLPQ3chXqJj7ikQ4ia9xE9S5XDlItKVXLBdWdArwZKV9YYRyaWbbwyX8TDJN2/+E0snM+NQIGAEbhuERmDCXVMEulYEyhh+sCJVih6rI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6661

We need a hardware address to create a socket without an EID in order to 
know where we are sending the packets.

The Hardware addressing is needed to be able to use the device in 
point-to-point mode.  It is possible to have multiple devices at the 
hardware level, and also to not use EID based routing.  Thus, the kernel 
needs to expose which device is which.  The Essential piece of 
information is the outbox, which identifies which channel the  message 
will be sent on.  The inbox is in the hardware address as well as a 
confirmation of on which channel the messages are expected to return. In 
the future, it is possible to reuse channels and IRQs in constrained 
situations, and the driver would then be able to deduce from the packet 
which remote device sent it.

Probably not correct to say the  there is no hardware addressing on the 
packet.  Instead, there is a portion of it on outgoing packets, and a 
different portion on incoming packets.

The hardware address format is in an upcoming version of the spec not 
yet published.

The namespace is for future expansion.  I expect this to always be 0.

I'll fix the other review corrections shortly.


On 10/30/24 21:28, Jeremy Kerr wrote:
> I recall querying this in v1, not sure if there was a response, but:
>
> Given there is no hardware addressing in the packet format, what is the
> meaning of the physical address on the interface? It's a little strange
> to define a hardware address here that isn't used for actual addressing.
>
> For point-to-point links like this (and the serial transport), it's fine
> to have no hw address on the device.
>
> If this is purely local-machine-specific instance data, I suspect that
> this belongs elsewhere. A read-only sysfs attribute could work?

