Return-Path: <netdev+bounces-195439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87565AD02D4
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C2616B3B9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BCF9EC;
	Fri,  6 Jun 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VefRGHvH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87528466F;
	Fri,  6 Jun 2025 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215399; cv=fail; b=qhyaFrqNwmhcQU+5Tg9n+YVQmcbuMot3QHmy/y2HzFEj9N4gvmRgBs6UGWAaN+FdHBHvjGYecf18WTWswEABW8W2FQjixIFpeDEU/YgxElVirjQtN03AywwOM5fH2tK3BgvpJN5SfQR4DKYzpaMMb5oDtpAcoO9AHBvGBlw28do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215399; c=relaxed/simple;
	bh=ebUGJHoTFhL+TTdANyLNNMgoOVo+/ynPpRy9fwSBkIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6nJ0DjGD7l7vpOYqE72WB0eqaiIAWs/dL0VveeHVKLQXibjzRFNtAcSc/NbJIfG+Pn0yB9Bm2YRgelpDNqTLplig4++Bit7NCXBsQAx6ep3aEKJ1hAfPfasHBbDiaNjJiG26ws3U9k/9Db80W7bZCU7FPeUBfRol7jIE/YVt/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VefRGHvH; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFQ7dFbbkJN9yArwcG+0VZ0QCv/Kac3wb3Bk8FL58fAfve5MVR1gvGFRndlDm4FH8oBybZ66DreAjlBaFucLMaWoCuLVceqHPrMZ3gvyMsYHagVKlIUh+UoybofklKPmONAQsnEfCEaLieGI/IbE3gelY8FQxg/XjCfuQKVnZ8H3PVE5WoqUyxZbHl6LfuqADPyZxswrXgjFhJMLFlXLfdNd2NH8lrVKh/KAInMAcr3GDatxvz5k3KLr7CqKOes4+59pZVbKkNtCodeEDd2TPSwJChaX5smKj1pdGfe3g4cg2g7LMW0e3Fzj/fY929Gyl/BtoZfOaCbKlX1uZDw/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wyb1dtZYmhh6Tlj+x2iwkWb3Dj9KQ6TX8cMP0e3jIQ=;
 b=akkeMPdtqdQDLtmtE5NAv2yRqrh2sI6+3xX5ZBc557iWnBhvNv0ZlB2ZwORbRfTlXHx6wg3df7D9HcXa4wgs+CQ9+6ueU5to9KysLt4lC9Ud5ZEYLIkH8xWI51CPBQ9GMS5HuraxruRMUsuRjtzUZxCdQd3yYRdAPH/thb8XfX87tluDMyG5Wo9byGhv3ksuF8yJEq5W8fDmRpX8XyQFnXgdWZsFWcvoPO0Aa3PD4hGvcJSiagXmowXSP0E2fDTriFB/g/k4Oxh/zOs1KUkVGiwAj0nP85zDArfLEwKKeTdHOXo3N7fAMC3YShouccJe7qcc/mnIk24klzc7J7lC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wyb1dtZYmhh6Tlj+x2iwkWb3Dj9KQ6TX8cMP0e3jIQ=;
 b=VefRGHvHcUSNeIlS4/XAostXI7RlTZPacVQ82JdIK6reEg4OBwUl5DiPEvKMAvL9C/MNHwy49R+pPnmXQ595KFgQfiKKd+MjUW+DFZuPWL/LkeY8JS33+mx5qg4uwiAfiOnyPaiEFYf9myWswkSGEU2R6p1nzVIxfHvihmOrVPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 13:09:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 13:09:54 +0000
Message-ID: <6be8b643-75bd-4f82-ae9e-9c04fbfefe1d@amd.com>
Date: Fri, 6 Jun 2025 14:09:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 13/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
 <682e364b9dc25_1626e100f8@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e364b9dc25_1626e100f8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0362.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: fb95f886-12c1-43ae-dd45-08dda4fb6d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V21OM3htcUxuNTVZS2hudmNnc1Y0cU50V093RUlObVorTkFrc0pHYTc5SW1D?=
 =?utf-8?B?cy9CT1p5dkQ3bWQvNFBlQkpjMGRsenFuS0p5YkFONnNCTitFSjVhdFE0ZDN6?=
 =?utf-8?B?cjVWSUpveHpaL2RFZDNaV1hoSWZzaDNqUGQ3YWx5c0Z3RnZhdUIrM0c3S0wy?=
 =?utf-8?B?WU9SS05CelNqTktFTko0S0IvdXhGanRoYzNCemhxeVVpcW03aGhtM0tlaTE3?=
 =?utf-8?B?WEFSQlU2TS9ldjBodU1HNHgxa1FVVlQ4SHF2aE9LV3Q2WXRWUG9abXNFZTBX?=
 =?utf-8?B?MXhwbHlrREF6dEFSR1lGdHphSXNsclgzeU8vOUw2aThoMnZhQmhJdENjRHJV?=
 =?utf-8?B?R2hLa0Z5bFVJck9LOXF2YktmYXNwOGNRTXdTRXd0Z1NYVXhNOUg1MVJBUUU5?=
 =?utf-8?B?VWVwZk1qdGxWUytFVlpNNWlVcDNiQzNwWUxxWkl6MVJ2aGp3TlB2cGNNOENv?=
 =?utf-8?B?NTFYNWtvNG1TWXVyQ0hwQ0RyUVpTZ2Y0UTdUaUhoZGRJaU1FUEZ2cndLa0Jh?=
 =?utf-8?B?MzQwUFZQUWcxNnY3aEt2cGV6bVh0NWhsbjFxLzlqcTRZamgxSllnMWxNQkpv?=
 =?utf-8?B?SUJkZWNkVGIrRnhOb0JTcFlqbFVOL0JOVTR5YSswdG5hcEE3Y3ovRHovMXY3?=
 =?utf-8?B?Sit3TzFiU2pqYkRTTEFVUnA4TnhCeWk3K1RjTXkyai93OWtZMmwzK2gwUHVY?=
 =?utf-8?B?VHBtRHZLcU5lZHA5a2txNi9Oejc5UnpiOXVTRTc1VVh5M2dVYXRoYXQrVXcz?=
 =?utf-8?B?N09FdHFMeG4zWVlNc0x2YkZsNk5RZzRTVXp1REhLMERrSEpHbi9uUHJ3WC9o?=
 =?utf-8?B?ZkltU29GTHptRXlzNmJBWW5iWjEvNkRNUTBpZ1A3YnZUdVVOcnBBaGhJR2F0?=
 =?utf-8?B?KzkvRXRHdHRCeS9DMWdwbC9KZ01zdVZZV05zNFJvdlhGb1FXK2drNW43L3ZZ?=
 =?utf-8?B?YXpHNEptZ2p5dkRNUllFdUVOTGVkVjdWSW9SUUlrZEY3WUtuUU5ZVHhIdmQx?=
 =?utf-8?B?Z29DMDBCeHoxSEJYTlp3QnJLRFc3NjlzVTVmQU1FcEdlSEQzdVRBN0lRMDY3?=
 =?utf-8?B?RDFqYzZSQkRVSWhiNDVpb2h1TWFvdFV4ZVorYStScm03Z1JXT1IvbFVFeG5P?=
 =?utf-8?B?Z0lndDVVSGp0ZU1WMzJqY3hKNnROaGozZWJQOW55bHAvRmN5K2lsR0ZOSUwv?=
 =?utf-8?B?MzArMGFYOXUwUk8vYlpYeDY5Unp5TUFzNlZxb0o1V1JxN2l2TGZxUGdBZ2FU?=
 =?utf-8?B?bUV5QU1HdkRlNjI1ZTZlOXdlL3A2MzNGKzhzVFlBZEtGb0tJWExSVEE5cWpP?=
 =?utf-8?B?WURNWHk1VGtGeUN0cThKdkdOOVNlVjJRb0hHWWxNRit5dHhQM0ZoN25rVnA0?=
 =?utf-8?B?RFh5N1YvdUpPQ3E5MW13M24zK3JSV251QnUwQW1hMVZ5c1BnNmdEQ3NWNnBQ?=
 =?utf-8?B?ck5DcFk3Vmh1U0l4dURwZ1J6dFVZOFFkUGE5NU9UYnlHZFRoSHdCT0k5WEZY?=
 =?utf-8?B?WmN0Z1h5bFBtRFMrZWpRUnk3MDhOWWlJTkJNZC9JTzhrSWZvbGFZVXVsR0RB?=
 =?utf-8?B?NU13bHNHejdLM25kaTBCWk5FbHZKNytPWTdCN3hNaVlDOHRhcFlaTGRUd1Q2?=
 =?utf-8?B?bGJJRHFRbWRKOERyazdjOHlpazFHaWNhMVYyNFhTczNaL1o0V0hmajhqeHF3?=
 =?utf-8?B?eitMSU9oUUtpZUM4VnFpaGhiUVZqZmVCMERDMU9kOUg5RG9KMzVQWllIVkRO?=
 =?utf-8?B?RW1ldjRiSzVNR0FId2ZuRG10UlhHRjFIWWQzUmlpM3IxcFI0SU1iWHhzdXhz?=
 =?utf-8?B?NXZWRjQzOGhVNlc4dDUyZEFRZXdtODhETWZCcW1xUzA0ZDFpS0FiTE5NR29q?=
 =?utf-8?B?eVNaTUpTaUM3L0VkK3FxNERaSTUxVFh5eENSNmFzeU5ncEVJeFEraGxqL2dh?=
 =?utf-8?B?NU9iNU5hU2grYkFGd1l0T2VoYzlKWWZnM2oyem5aMFk2NzR1Y0tvVnpsRFFW?=
 =?utf-8?Q?J1Gxf57fJNCyC50gqgfNhKxrAwti70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNyNEZINjRoV0Z6Y3U4RElRZmkreG5odmNDNGtpSWU0VWQrdnRiYzg5YUNo?=
 =?utf-8?B?cUdqTVhJN2FNRDAzNUszMko5YzFuQ0JzRWV0VE5GR0hQQnpBZldvUXFGSk1N?=
 =?utf-8?B?UEtXc3BtVkk0RkRtV0JERDN3YU1MZ2htc2Uzenc4VzVuVmpKMHhxSzA1Zm42?=
 =?utf-8?B?Tm1JNldXK2tCUnVKd2ZDa0FpenF6WE5YR2xIMFNYWUErTEhtTmFSQXdKOHVY?=
 =?utf-8?B?OGs5VDhvNDFuWWQ2RVJHSXNINE9JbVVjSUd0ZTBtWC9qblBHWG1GR2g2SjFk?=
 =?utf-8?B?Z2dCVHRuNTNQb2RLT1dyakpzclArd2NON3ZQZXNCbm5lbHZJdFNrMXNQVi9C?=
 =?utf-8?B?dWhMVlY3ck1BSVIyL3VzM2FDcHl3YUY5c09HRFFSNHZVU0J0K3NTRDJSNU9n?=
 =?utf-8?B?N2o3aEVWN1BpNHNWTkNsb1RhUUhPU0RGV3V5dGE4SFhuYWhVd1FsV1lBK2Rz?=
 =?utf-8?B?dGVZM1dFNXduQ3FNQzV2MjJJV00rNStYTTZmV01YY0VuUHBNMVNnU2oycXJv?=
 =?utf-8?B?dXgxSjVmb1VGLzNmZnBOSTBDTjhNalFraUowd0Z2ZjB4emhhTmlGU2lvZzE1?=
 =?utf-8?B?Sjg3VTlkRFJhcGlkaWY1RUZQRkRsczZHWG96dkV6b2xJREVDTHliUmVjdWFI?=
 =?utf-8?B?YW5LdXJpazJFdDl5MXdPeHhnN2E5ZjFTZHQ3anlRUVVoSWNkZVNaZ3B3K2hJ?=
 =?utf-8?B?SmNEWVVxa2plaVlHRGpERUt6YXhlMEZ6SXpDSkY2OWx2dS85L3I0OXcwNTd2?=
 =?utf-8?B?WlhJZ0M0eUQ4NXlaMlRmVEErclczWWVPYkVsWU9ESWxvMy9SaTNDeWdLcFJH?=
 =?utf-8?B?K2xubStzNXZhbVl0SENuZ0dVNUQ5SDEzNUY5TUR6N1F4TEFZaG9oUndaSnM4?=
 =?utf-8?B?cnlyWmVHNHFNMVNWWmlpeGtQQ29sVGVFNHdDM2kzbCsxa0sremJkUFNuc0pu?=
 =?utf-8?B?WlY0T1BxVm1kSkJiQzQzTW94N3o1UUlMSlR6cHVhUHkySzBDUWFBQVl1LzRq?=
 =?utf-8?B?VWNRQ2tCT1EyWlR5QWlpRXlVYU5hR3NDNVNVMFVFcGg5dDJHMjk3UXVicXVh?=
 =?utf-8?B?KzFmYzh6L2lyRDdVMkhVQkhZQ3ArN2Q0NDkxek1IOURpdWFZK08zODUzTUY2?=
 =?utf-8?B?dEVuVTFxWXhmc1dJaThDQnhjQy9aRjRCRmZxQjFYZHZubW1LVGNQY0xBSkNi?=
 =?utf-8?B?bmc4am1vWEhBRVhHanNNUm44cVdKN3NKYWFQMnB0bXJ1SHNWYmFGYi9relhI?=
 =?utf-8?B?QkhhaDg3bTNYdFVMOEFoL0JUODJPWVlBeThNaTFrQVBrUFRVMzFGTWR5QU04?=
 =?utf-8?B?TGhocXdJcGFrMklFRXRUVDYzNmcyK1BiUnVwOVRrWkNaOUFNMDdISlNKWUV5?=
 =?utf-8?B?a1puaS81K01SVGFSTXlMYWxWTnlRanpyRU5md0E0Y3l6L2ZLd01zOFJOeTJl?=
 =?utf-8?B?NzF3T0wvZCtrZ1FZS1hoRlpobnJULzRja29DU09sZXNVQlY5VmttQUtna0Jq?=
 =?utf-8?B?N3N5TXMyVENQWGE2RlB3aUF4RVUrc0p6VUVDYlJ1akhhSzU3QUpqcUwyOTAx?=
 =?utf-8?B?K0lqN1B0clV1MzFyeWNDWXp3ZS9XMjJDK0VJaWpFYkdVNm9PN3l4c3c4bkd1?=
 =?utf-8?B?eklTdHVuU2k4ZFFjRzFWdytIRDBvbzAzTzJEbGpvbEZYUTBrVjVsOEQ5NTMv?=
 =?utf-8?B?NTFMaWpnbGZzS05TMnFVMzZLL2ZYUDZmL0ZOVWlxYmtBSE5DSWlzNlkzUHVB?=
 =?utf-8?B?Ykdnb0FERDZodVRUYmlkbmE2T2JmbXNBd3MyQ211VFJpMTN6R0p6R2ZpbXZh?=
 =?utf-8?B?S1F1aHRGc1BzU0NISVc5czlXZXhSZW9NUmNMSWRBTkVzNlRkZEo1T0lKcDh3?=
 =?utf-8?B?dlJacVUwaFUxNE4yY0ZadkI3RWxVT0RJZWxIMG91cVZKVmJjNWppcUJoSXpD?=
 =?utf-8?B?dWdmY0VDUms0QkhScHlYR2d3MGNWQkJaOS84cXNZRTN5d1NNZXpLOGJOK0px?=
 =?utf-8?B?T0IxNU9JUW1CZW1MVlZ0Si9wWHg0ZmpzQ1pZaE4xOGhucTdma0tiWks5TTNT?=
 =?utf-8?B?TUtFY1VwZUJyVkZTVnpmSVpZL204QVQzdjBSVEdSWkJSeHZYbXpjM2wvaGlQ?=
 =?utf-8?Q?agUYv+66Zzi2yUWWpbl+pcWVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb95f886-12c1-43ae-dd45-08dda4fb6d72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 13:09:54.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXRDZilXEkLth/A8uW71otU5zNleHwfyPnJz49SacBkNEhYoG5vcFEo8wfx9dlM8Cn9Ye3RVfbw2FKAb6F062Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125


On 5/21/25 21:23, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/hdm.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  5 +++
>>   2 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 70cae4ebf8a4..500df2deceef 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>>   	return base;
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + *
>> + * @cxled: endpoint decoder linked to the DPA
>> + *
>> + * Returns 0 or error.
>> + */
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *port = cxled_to_port(cxled);
>> @@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	devm_cxl_dpa_release(cxled);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>>   
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -686,6 +695,83 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	if (cxled->cxld.id != port->hdm_end + 1)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct device *cxled_dev;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
>> +	up_read(&cxl_dpa_rwsem);
> In another effort [1] I am trying to get rid of all explicit unlock
> management of cxl_dpa_rwsem and cxl_region_rwsem, and ultimately get rid
> of all "goto" use in the CXL core.
>
> [1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.com
>
> So that conversion here would be:
>
> DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&cxled->cxld.dev))
> struct cxl_endpoint_decoder *cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> {
> 	struct device *dev;
>
> 	scoped_guard(rwsem_read, &cxl_dpa_rwsem)
> 		dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> 	if (dev)
> 		return to_cxl_endpoint_decoder(dev);
> 	return NULL;
> }
>
> ...and then:
>
> struct cxl_endpoint_decoder *cxled __free(put_cxled) = cxl_find_free_decoder(cxlmd);
>
>> +
>> +	if (!cxled_dev)
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +
>> +	if (!cxled) {
>> +		rc = -ENODEV;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
> The current user of this interface is sysfs. The expecation there is
> that if 2 userspace threads are racing to allocate DPA space, the kernel
> will protect itself and not get confused, but the result will be that
> one thread loses the race and needs to redo its allocation.
>
> That's not an interface that the kernel can support, so there needs to
> be some locking to enforce that 2 threads racing cxl_request_dpa() each
> end up with independent allocations. That likely needs to be a
> syncrhonization primitive over the entire process due to the way that
> CXL requires in-order allocation of DPA and HPA. Effectively you need to
> complete the entire HPA allocatcion, DPA allocation, and decoder
> programming in one atomic unit.


I do not understand this atomic requirement. As I understand this, 
dpa_alloc, with the proper locking, will satisfy just one request if two 
content, with the second one requiring another try. Once the decoders 
resources have been obtained, there is nothing to worry about assuming 
the commit of those decoders will be performed with the proper locking 
as well.


>
> I think to start since there is only 1 Type-2 driver in the kernel and
> it's only use case is single-threaded setup this is not yet an immediate
> problem.

