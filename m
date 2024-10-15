Return-Path: <netdev+bounces-135600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365499E51D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D239A1F245A7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA591E32CF;
	Tue, 15 Oct 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sqc3dk+i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392701DD9BD;
	Tue, 15 Oct 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990428; cv=fail; b=RzIAJqDXxw6iEwO2PXSZvLooeD8IDiaT1glzixvnkQCoNZbrT81UVf3g0sV+msgNgZqjMO/GinF9ENK467kKZUuMzXPJzo9VIoxOkEFYlp8enSUn7Et7EXhzXz6MckS0Kd5Xc3Zjq35DHU/hRoBrGXskb5fur0dWI3jdFuD9JMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990428; c=relaxed/simple;
	bh=uj72oc/ouyt6XaieYgEPlzeqvpSafUP5z/kKZTsYJjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbvwU1B3wI7tSesSgghXX3eYcJSpfvq/Ruz9XEwsJ6OchBUaAOsjNeMQyRHBk98ycOXvtulcawMCOT1nv0xdmf3Lwgl6lYknLrJCOQZ4PR9yqg730mYF/fj8CiiMKicy6z3SjR4PDHN/q4Sxl1k7LD6etnB8r39FSe9ChO/3gTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sqc3dk+i; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra11eLWbFh59nlZ/1O9QXpl+5VFSlXFVPa0d1HOGOYWoz7QufFOPLXsGeiDIqQMYL9UgHMZGwtZnTkVFs500lGJtkCDMwppReyh0axlnceDG+Zi58/L39ipvvydIM6jqVsu5Wg9ig2dqC36/x9XR1UMKmKRqIOhPFMCUtYP8hicA2uWmHzC5EboZDPeoSAN7v6D9InoFspY/y1cRbQzCPU3jV/F2fgvUrWJK9LyRl1E6TWypJZSDYAZRDmsa9p7WkuZ26r3MKtjuhVMXh48RVGVt0ksPIJ8fm95fMhfo6E0fEDJb2VwY6gimwXmn/ZvBkTKEPjE5Ci7iruXGFxGGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIYe0A1UAAbiF8aDklxDvu/5m1UIqgjoX/B0BjcMIAE=;
 b=qyQ5XNjxepCkJwILrDaKUtuzWG/pDZz68CFdwP6Fg4IqTdfPBUn0W+RyjJN0PKt32XvxdkjdhYF68Cp4ziFkjjoDewoTEa9VYh95nDb2NkkuI+HnxyoQOAJjycU89duJcSJVXBpiipi2ZPS6D/+N8oTokjPC0Mj+0Xi0FI78Wj+qzrLrnVk4BW5YpuT6kCQTjMxfuK1g+pL5u2+R4glHrtdjWire58hHqAwfWyohmyRQcGulCAb/qTdtCQNMRWkTc3d+PFG9HhT9oWvXBSiMZAubErV/8lGMR2xQ0n39dFmmyRW/5o93ElgvzGwF8coPnuzOj1jfb+mHY25sP/SkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIYe0A1UAAbiF8aDklxDvu/5m1UIqgjoX/B0BjcMIAE=;
 b=Sqc3dk+irlE0FYKklPkKFdAu6WBhZEyVrbtlAz/FA1/DH7wS7dj0gVuUNY3vm0AmDqYDGMV3LSAiv3j9hw67IJLY8Z8nb1AnB8euCyGsh1qb1OVCtsm9T5b2DqPDHe+ZY8msH7d+nkxrt6TkxMklKUaWCr7pEcNxHYjJtlthW1SHPrKY6+qxfiQjCumKHbiHL3Uhj6bHyKCymjMxq8zwvbUzTrjiK9cDPAfBZ3a4bHoypyBstZ98x5yT2NcN6vh4IelqfnDPU09O83Y13HNmyyUrvuOYePfKDEBKVXo3AIJe8pdkEDfuyH8IXqO4x6B4EeQeYyhqPHbFAJCeJeCWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 11:07:04 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 11:07:03 +0000
Message-ID: <7e5c00b6-ea48-4f88-8dc9-c60d544c58c2@nvidia.com>
Date: Tue, 15 Oct 2024 12:06:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net: stmmac: dwmac-tegra: Fix link bring-up sequence
To: Paritosh Dixit <paritoshd@nvidia.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Bhadram Varka <vbhadram@nvidia.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20241010142908.602712-1-paritoshd@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241010142908.602712-1-paritoshd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 849a7e27-9d2a-4fec-32e4-08dced097fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WThiZ3FuUlF6cHdCUnYwajhjVmdFL3ZudjlybnhBd0wydEF4YlV5QmlBRENI?=
 =?utf-8?B?UDYzQ01ZZm9sdTZNb1R5NmNkdkg0ZTV1bTNxTDlwcmNaZFAzR3kvQWducDVp?=
 =?utf-8?B?b3Q0WEFqUXZRbEhBWC9wb1dVUWp6bWtYUzJmVUJwbldua0RZaWc0bDhsODlX?=
 =?utf-8?B?c05peTZwclN4U1ptK2F1elA5SXBxK2lGZ2FYdHJhSlNPbVdLVE5jNEtTT29s?=
 =?utf-8?B?cEg0Mk41ZXRnd0RwMTU0RXFtRXNaTCtZaWFlQ0hsOHRBcFpnTkFYNEd5bWJx?=
 =?utf-8?B?ekZxTUxHRVBwZHRueUJMVVNmOEhrUHNOWUFOU1ZFRytNWXpYVTBBUXByWVJ0?=
 =?utf-8?B?Z1pCSmovNzFYUGxvZWNJMUllYTB0TVQ3RHZqUHBGNlB6R2p1US9UMjdwK1ha?=
 =?utf-8?B?YWRBUStJanJuTXBtTVM1RTZ2THdWa0tqMU9vMXdrZ2pnV3JWSUhnZEYrMk9Q?=
 =?utf-8?B?R1kvMDYwdVpWZ2lKWkhQL0xvcEowczA1YW85amtCMjdYdFpBS1VKK2ZsSXIx?=
 =?utf-8?B?cUIzV001QXZqbFJUMmRlV0lIU1N4ZU1FTHpYd2t4K2FSY3hpVzllRnNmVmJD?=
 =?utf-8?B?cDNxNE5LSWhmeXhhdUlFM1VEQ0lFcFVaamE0djVDYVl0UDZHcTVIOGgrcmpU?=
 =?utf-8?B?UmhIMzBKV1hGekV2Z2ZSQTZpUWdlazJTSlBTeFIyWjBMQzR4SkFla3ZjVEdl?=
 =?utf-8?B?c3RlaDdWbGdDcWl4RVFrNGt4OEJzZG5ZSURNZFRZOElPYzdLcHFKcHBSaUow?=
 =?utf-8?B?QkpmYXBRczFOTlo4WHhSbjU0OXFPQUpCRk1acEY5akRjUXhXbzVlaW56VWZS?=
 =?utf-8?B?T2d2NWF0aVA3d2t0c04rSjJkU2s5RjJDWjlwb2JsckozcStZdDBSeEZrZ25L?=
 =?utf-8?B?Qk5yNUZ5ZDBDNkNOVGF0QUVtYnY5UG4xY2JYUmxpVlhMTUI4dFNsMmd5a0dF?=
 =?utf-8?B?MEtHOERUNDR3eFh3bFE2QUlIVjVic0NZVERYWFQ3aFJUMDRoQ1NIejBxK2NZ?=
 =?utf-8?B?NGl1WS9kOWtnZFlPZVhjMXMxa0JjK2QwUkx1OUZzZ28xNmdQOWo1Q1F2Y3RX?=
 =?utf-8?B?eVJvcHNqOU8yVTZmMHJYNGRMdWdqUWd6aUpxUmJZcUNmRFNxakFJdzFCT3l4?=
 =?utf-8?B?QlkwQkg3Y3JPazdIL3B5anRnMFMxWHYwQTdhTTBKUEVOUmJUWnlzemFrM1VE?=
 =?utf-8?B?b08yaERLQjZySk1oWEFBWHdYdXNPczZPQ1VTb1dpNmVmVHE1YVowS3habjA3?=
 =?utf-8?B?RXV4R2ZDUjl5WTQ2eVhxTXVITXY4NVJOVzJETmRKMFNFNG9sdHlFOUUyMUdU?=
 =?utf-8?B?bU8wRExYOE5qcFRUQWFnbkRxaDB1OGZxTTROdXZlTGs3YlppQVJuTXF0Zk1T?=
 =?utf-8?B?Y0FGbkJ0aHdZL0NoeElhK2J1K3hYOC9zTzNnT1BYVUdReUM3Tm9oUlRQT2l5?=
 =?utf-8?B?OUROa1N6Si91QUJhd01TOVR0WWxaOVBlOHR5NjVYUkNpUGNlR3YvdGxZM3Bn?=
 =?utf-8?B?N1NCMFYxUzExN3lOME11bGlwVkFYdExVTTRLeVdBTGVKRU4ybVRJb2NibXJZ?=
 =?utf-8?B?T1U3ZlJBNjIraGVPRk85cVlVT2Z5eWdjcDJjYS9XRGM1blBkeU9XNWh2eUZF?=
 =?utf-8?B?L0xyNmUwSWU2bGdlUEFwVVhiYUExRFMwOHYzTjJlODZSWmw4SFprYUFSQW9Q?=
 =?utf-8?B?MEg1ZWNqVEdrU1A1aVAxTld3d1V3ZVUycHl5VGVrOUhvYko4Sms0YWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K250T20zcURsM0hvTmFJdXYreFAweWpTMUF4NVd3NTVqYm1SMlhEWjgvQzdT?=
 =?utf-8?B?V0FDRzNmRzIvNitRZWtqSDE1b3oyRS9QVlQxOFdTYituOGRFMTJXUUZib3pZ?=
 =?utf-8?B?clBiUkI5M2lDTWt0MXh3MkJTQ0JPaHliMTZCcWdlN0huZ2tPTnhTYzFtZXVs?=
 =?utf-8?B?cG1JZDNOMzR2N3BiVTB6RXRGWlpJMFU1VUI0L05NQkhyWnk2ODZ3Z2VvYWIx?=
 =?utf-8?B?MDR3Y25DT1FMUTZzOEFwVWE0YVI3QXp1eHpQQVRHSjVPa1B2L3FWVkp5VUU4?=
 =?utf-8?B?eHdZQTVWTHZJOS9maGRydDkwVE5FQWlCdVdTaWtOaC9sZlQyRVVnNjZReVlV?=
 =?utf-8?B?M2xRR1hkYU5jejBxaHl5bkFSYzVXWXhueHZ4V0JadXNoRTdMcmFhRjlaZWVj?=
 =?utf-8?B?NU52QktkbmdMcmRENXZLT1JnS2RIR0wzYnRkb3VCcDE5R3VZNUorbE1QK25L?=
 =?utf-8?B?RnFlaHAxcml4ZVVCbHU4UmQ5TDI0NUhsQVZYZ0EwNzZZdW5QM3JVUUlKbjEr?=
 =?utf-8?B?bXJyOGV6cDRFYlBUU0dzSkdIeFU0ZzJ3R2J4cTBjVFVwM05TVWdRdVNuVWp1?=
 =?utf-8?B?VTFVOHRJVFNnVzlGZmJYWUhhR3kxYUZ0aFo4Y3QydVlNVGsyUEN5WDZ6c053?=
 =?utf-8?B?czJkeWR0UjRuMWNHS2tyN1Jkbm1TdzJpcU4za24zN0lRdWlXKzU4bGF3Rjgr?=
 =?utf-8?B?TFp6WHdqaFI3M09sMWY2MHF1Q0JXbDdzOW1YeGVIUXRaYjgrL1h0dU1ubDFx?=
 =?utf-8?B?RTZiaHpXMS9vTmtNMkZFL2JockRUakFwOTBhVWozTnhYN04zbkVjM2VuSEp4?=
 =?utf-8?B?Mk9kOU1YdmZCajZTYjZGZWJSZ0JPYVA3VDZsd3ZzTkxUOU1QcXhwYVc3MjZT?=
 =?utf-8?B?K0g5TFdwemttT1JSS0Z0SzdqVndJOXZ1YVlyOGN6c2JlcUlsU0QrbjU0QVRm?=
 =?utf-8?B?MHZWTi9zcW9ZRzc0d21KWC9jL1Q3QWdFdG1XOE52YWVIZ1hJOHc4N244Q0Jw?=
 =?utf-8?B?UXFRM09JK0x2UlltWS84OVQrY0Y2QlVpL2Q4SllrK1ZHdXNQSzRNcXJkRnVT?=
 =?utf-8?B?NE00MHhDQmxLSW83a3VhSnhlem5qM0x5RE55WE4rRDEwSlJDLzlySkRZWG1w?=
 =?utf-8?B?RHcyYjlidFdtZjJEZ28yTDgzYktKZmcrclF0MjBxZE1jN0VPOWpvZnlWY2xY?=
 =?utf-8?B?NjVURGZySnVwRHF4OXJiekQzTkVWbnJpV3pyTjR5MmtDZWwrNzJHdWIvV3Zr?=
 =?utf-8?B?a2pUVlFQUmw1N1M0ZnV2WXFIdzg1N01CNCtlZDlzaFpKOVZLRWNUMHdtSzVV?=
 =?utf-8?B?OHVtbmJlWmxWbUNmdjRJWUNGZjFDc0VlZHk4TWtzNkhCdFBaNVU3SXUxazhT?=
 =?utf-8?B?ZkdlNlpkbzhDU3F0Rzh2NktJZWVjTUFKOFhFNWJMUHJrSUNlOE1nUGhDbWZo?=
 =?utf-8?B?NDNSOGI3TWRMZG4vRXdUQ2tGMlZGUlBBSUJrRzJKM0NJekxmOXU4SWFKbmVn?=
 =?utf-8?B?R3ozejB1VGo2UVJaUGtQa2JaUXlUUUVjYStObTVlUjZpTExFaHZJMU1NUnZ3?=
 =?utf-8?B?eTJ3TkpZc1krUzZBN3EwMTJHQU9rTGg4Vk0xUEFkanpzM1h0YmRHTFkrcGl6?=
 =?utf-8?B?R0Z4OVpGNlJDaGFtN0VMUURQd2tnWkVCUmMvak5nZGZweUw1bnYvcFdObXB2?=
 =?utf-8?B?blptRStsY20zbzFFcm1mRnBKREFmeGlJem50UjI2ekY5azBzZkIwK05xaktn?=
 =?utf-8?B?Q201bGN2Tll4Wk01NGpLNkthZXdxR0s5Y0dvU3BtemdHQmE0Q1lGbFdpeGdr?=
 =?utf-8?B?N2J6VkxxTTl1cVZNemMvOVA3Uno0VFpVK1lLRVF0TDQ5NFdzSlpralVWQVNn?=
 =?utf-8?B?OVVGNE5XYWVJMFJVeGEyQjU5YjVUS045WHRERmF3UmszaVV0TlZGTkg2RGFH?=
 =?utf-8?B?RmNnZDdYNUpmZCtVaVQ4Qzl3ZmxrMjhLL3NtQnJYRTltcm9uUFFSRnYzZFlV?=
 =?utf-8?B?b3M5bHFMSHlLOThPMXFVY3BTMVBBZFFDa2NtbHd5OHZ3U3lKSmRrQ2N2OHRX?=
 =?utf-8?B?b0c5aC9ITmRWK2lONlBnNU4ycWJGaitxQXc4SktYNmsvWG5JSGhaa09IQis3?=
 =?utf-8?B?V1E3YWYxMW1vVFR4ZVhHR1g4RVJpNVY3MXRhdUZ2Qk9tdnVMcVFCZGhST3ly?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849a7e27-9d2a-4fec-32e4-08dced097fcd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:07:03.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3nP2B2fZkxDAimS0cbpLyVvnwduPuR/eaPx7lVnT+t3AkUXe4JBwVn3/lka73POwIq2VFIrVJzJxMZtBFhxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176


On 10/10/2024 15:29, Paritosh Dixit wrote:
> The Tegra MGBE driver sometimes fails to initialize, reporting the
> following error, and as a result, it is unable to acquire an IP
> address with DHCP:
> 
>   tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready
> 
> As per the recommendation from the Tegra hardware design team, fix this
> issue by:
> - clearing the PHY_RDY bit before setting the CDR_RESET bit and then
> setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
> data is present at UPHY RX inputs before starting the CDR lock.
> - adding the required delays when bringing up the UPHY lane. Note we
> need to use delays here because there is no alternative, such as
> polling, for these cases. Using the usleep_range() instead of ndelay()
> as sleeping is preferred over busy wait loop.
> 
> Without this change we would see link failures on boot sometimes as
> often as 1 in 5 boots. With this fix we have not observed any failures
> in over 1000 boots.
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Signed-off-by: Paritosh Dixit <paritoshd@nvidia.com>
> ---
> Changes since V1:
> - Replaced ndelay() with usleep_range() as sleeping is preferred over
> busy wait loop.
> - Replaced c99 comments '// ...' with ansi comments '/* ... */'.
> 
>   drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> index 362f85136c3e..6fdd94c8919e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> @@ -127,10 +127,12 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
>   	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_AUX_RX_IDDQ;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_SLEEP;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	usleep_range(10, 20);  /* 500ns min delay needed as per HW design */
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CAL_EN;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> @@ -143,22 +145,30 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
>   		return err;
>   	}
>   
> +	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_DATA_EN;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> -	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> -	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
>   	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
>   	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>   
> +	msleep(30);  /* 30ms delay needed as per HW design */
> +	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> +	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
> +	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
> +
>   	err = readl_poll_timeout(mgbe->xpcs + XPCS_WRAP_IRQ_STATUS, value,
>   				 value & XPCS_WRAP_IRQ_STATUS_PCS_LINK_STS,
>   				 500, 500 * 2000);


This might be a bit late now seeing as it is applied but ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

