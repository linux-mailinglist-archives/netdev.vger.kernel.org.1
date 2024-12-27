Return-Path: <netdev+bounces-154338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44549FD1C9
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB01609DF
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058CC2BAF7;
	Fri, 27 Dec 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmoTHqfw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806B1876;
	Fri, 27 Dec 2024 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286714; cv=fail; b=tl1KVZmxozecjD1+deXiUFNkLuyCmT1OLAk9R05YHmwQyP+FkYRHW23U/EbiI9ri1BkS/wymkeqeyme3bKUe3kRPyjk0qol8iKnDguPhlX8LBRH7wUadZlhBVFHiQRnPQKQEFyY6auEbgdsi9SztoDBxgogSDA15yXOONv9xBmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286714; c=relaxed/simple;
	bh=eXHQ0SoSQx5rgFBzpJFMD9Jwrv8TRpJpT8+qlkTftn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KmEyQXjBUvz+xqOyZxxRBglQLfAAODON5d3ZVRQtn0M2c70GYhZSRSfVqHONi7v8hymIwuYxSxr8ZooiLkr9ZtHTKZgl67i4/+DwOLkOiEMw/cR42kfTYIIh6I01TbU1FbSkwqMWWVr/OIf+Ofok+2GB3+24F7n0zmrUy35EIzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmoTHqfw; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRASRdaIMWrEFfGpVlxvGJINRvuCE0osLo+EXPWBaKQj2zegSDl5DL6P6z1vA5GbpeW9Yn9uRxL1yqx69c65gddCMAv9w0iPDg47LdE5af37FqLj1tsj2z3b2PYbZLe9Be2pxVNXFrnJZLlkH4pSMF5yjzYqNgOvzXLWs6gmIige6e8LW9dZ1zE1bv+GeiN30kD441UzDJzETyRyDsGviY9Iv+qK10ZIuu2xQr87odSL56aVgeOOEPlPhrFILrW8Kg93zgo84kp5b2Vl/JKX6J4A/GTnwjXuTmVOc/mp8rNMw5qMtTRu5LltXkPH6D6+aVQPrq1ZRt2lA8gnYkVlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZMtxLdsI3Vb6AA1a4oDXGcjzF0pRTkVgDjaDDgXL2g=;
 b=nBmsM45oC1Y/dhjSamhdsWpbKp4N6gVXeuVPOwYM0e7/0C2Wxbx8wLethn3peasZA5eficKTijWsYJnNiymbntIKiQKTrcfg/+U+Z7O3iN13sbsExbe9dUwWd6y2AlOffFN5MSYfguVSP5TrxNCmuE2jcUf9dVE3b7pMh/6QJjWXZJp4LWUPQ/GqOoXUiWakfyMnhA0AXFtS81xFFTr09yK7BDUJuqzARn1pYc7cB757/9AzbWIxQ17NsDJl4FYECU/lDNDhfHEpgdeE6uqRmBxQOw0njXCQlJha9JRF5K1+n2QopDUapEv1ywfxBB0kv5DjObMa0l6U1pob0TiVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZMtxLdsI3Vb6AA1a4oDXGcjzF0pRTkVgDjaDDgXL2g=;
 b=CmoTHqfwXYvLzJyZ5uleGNMOX5IBP4BWLH5KqPoWkufNm9YUhshTIljgo3sgIP7z5Pi61xjVSlGuOSiUamHNW/aHsMpe5AfDxRkqt6uCCANezWiW9hlnw9fe5oYs3cWw2g1F0mSdsC4HtSw4O8VkVnOmBXN1Pb/GZzrLQEMmK6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 08:05:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:05:06 +0000
Message-ID: <624fcb6f-6f00-3b25-8057-0eed227e8156@amd.com>
Date: Fri, 27 Dec 2024 08:05:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 07/27] sfc: use cxl api for regs setup and checking
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-8-alejandro.lucero-palau@amd.com>
 <20241224172359.00002a2c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224172359.00002a2c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: faff0e12-8408-43df-43f2-08dd264d2cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2xDeHVUcnZaM2dsU1R2c214Um0yMmxYdk0rcGhVRVc2Y3ZBVVRjdCtrUWZJ?=
 =?utf-8?B?b1JvazVhUU5HVjlEc0ZIY1JmKytYSmpoKytlOTAxUlFha3gyZEwyUE9VSXdS?=
 =?utf-8?B?elhnWWRVU0RxR3VuYXVTejFiQW1PQjBJSTl4SjlDajkyQUJnMnpjWlRoUFB0?=
 =?utf-8?B?aW1LeHZ6K1E5bVdTNmVzQkVMSVNNMDY3b3JlZ3BLU0g4MEVGRVQ2b3haU0tl?=
 =?utf-8?B?ZUU0VHhueUdMaW9tZVpqQU5YNEhrS1Y5UTh6ZllCM1Z5VGVyNW02Tjd4L3dF?=
 =?utf-8?B?UzR5aVRpaCt4c012eTVDcG51QTNqbEcyQ3pVODUvMkdYK0lBZmx5Unh6cDBT?=
 =?utf-8?B?eTd3bk0wS2N0SXJ5RHY0SnR5c3Jpd1FjblFUOGM1bm5sRlEzMGlrWjI4RjN0?=
 =?utf-8?B?S1l0ay9TKy9idGJ6NklHVXZtWmFBbVpBWWVQS1o5a2x5ZDR4R0lpTjFxK25U?=
 =?utf-8?B?blRHeE1zeVdTUGNPL3FXVFVyQjRrVDJ6YVR4Tml6eFFYKzBwUzE3NXVvb3Fw?=
 =?utf-8?B?VzZud1BiaHBYdDB4NldTZnY3TFFvODlUditkNDU3Yi9Hdms0THBWbWx1eSty?=
 =?utf-8?B?eUZMVWc0WkYvMm92WlR6WWY1T0ZmZ3BmbXFJY3VJdVlYZTE3VE5oRUZBemRq?=
 =?utf-8?B?ejJtczZTTG1SK1dGV2FwZTMwRXNxV2hiL1hreTFnWm1NUDQ4Tm5acmh6UFhJ?=
 =?utf-8?B?QkRQVHB4S29yR05uTHhVS1FPRFZoWnh1RUQzOVlWT1RpN05KbTZ1YmJLUGY2?=
 =?utf-8?B?RGMzaWx5cVMyenc1bTh3WDJOaFNBRUhjeWVUQi9NLzhwOGV3bUl0dGpWL1RQ?=
 =?utf-8?B?bWRvSEh0VTFEZ2V3OU41V2JnOHQrdmRtOHBNWk1wUysyc1ZEeUNWcFNIalNi?=
 =?utf-8?B?VVkwUFJNaTRld1UwaXVSYTEwdnBvU0lpNFFGcHoxOXVDQXZhekRVcTBZS2Rx?=
 =?utf-8?B?c2NudWs5QnNKWnpiZWRJUlE1c3RxQ2dSbEVyVnRtQ2VhK3V3OGZwVk5pWWd6?=
 =?utf-8?B?a0FGczk0YWFWa2ZXY1o2bVczR1VGTDVNSnVZSml0cTlYZVFPSi9YT0pjdlJS?=
 =?utf-8?B?Wk1oUmR6WFBFbXdQU3N0c3NMeVhmT09sSlRvWHh5VjFEWlNYd0QrM2ozdnE0?=
 =?utf-8?B?UDNjTW5jUmFtbXpMaTByeHRXMS9oZjFuUDM1a01uRjdPalJENG90WGJVUGMw?=
 =?utf-8?B?Rm40Nks1Y0VrT0l1dXlaTitDNDFGZkxkN1QrVDZSQzJIN1RrV2xGKzBHYlo1?=
 =?utf-8?B?TjQ0WWxGbnduR0ltQ2hKeTdMcHpRMTlOdnhDaENxVURMdElCU3JrK2xBOFUr?=
 =?utf-8?B?ajBTdjI1dVRTUUw2NXpQYUZ2SlowaWFIeDdhTWZFNHNUVUdIa0lQTEh2MnE5?=
 =?utf-8?B?bDN1RFdWVFhkMnNrSStGTDk2czFTcEpESmxDOEVjbzRsbzgwSXZKeGhGVE1K?=
 =?utf-8?B?MG5COFd6TUxSWE5WUEllQlYwcTR1eDNnWkZJaUlRWXhTdm9Qd01ucVMwcFdZ?=
 =?utf-8?B?RmRuUXlKSVhZM1kxbjZLYzVrQ05MeVdEMHhBY0I4RTdQYTJqT1VqVitKeVNh?=
 =?utf-8?B?SHMzYTV3SEszdndSdXJjRzE2bWdIenM5VXYzUlNCbXhZbDJvY0dHVHJwemxK?=
 =?utf-8?B?dUlLYng0MGl3Q3NtcWw4c3FDTWtYaXZ1em14eDdIUnlOdkdVa0NDcjdEc01p?=
 =?utf-8?B?dU9QOW9Ca2dWNVVMdFlyUUtDcWwyVy9zSTc1WXVaY2U0eVp0MVYwN245L21M?=
 =?utf-8?B?Sjc4WEVuNlhjRFpCRU1FN0JuQS90bzBvU0JBNjJqMWhoRmRYcFlvWGFsSEtR?=
 =?utf-8?B?eXhacDJuTHRicEROSGtEY2w1L0ZsVmdka1U3d3RaZW5wUlFrM3oweTVVWnlK?=
 =?utf-8?Q?Q5h1jJPD0jRRF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVhpTnpUNWdSOFNQVHE5dzBCemNiK3pMUUhLaFYwbVZqaVhOSXlmMU5DQ1Jl?=
 =?utf-8?B?Nkk3VDdtU3VtVFRCemluVGtBSUplVUpaOHRSaTFKR0FaQUFWZHdHZk5MV0gy?=
 =?utf-8?B?ZFR6L0JXcS9QRmpibGZzcE5KdlQrS1dWQUFtYnhnL0lCdG9wV2RNMmJBckQv?=
 =?utf-8?B?cTVGd3VuN2EvbUJaWTlKc3hHVThGWXpJLzgyNDhYdHFhcGgwdEs1OEZ2Umla?=
 =?utf-8?B?Ty9tcURtRkhDejJmcE5yemJlZzZoYXhKazFxYUliclIwbW1TTjl6dGw2V0lo?=
 =?utf-8?B?QUFuTVFSK2RuK1NsZWl2VmE2eDN1N2lvNnAvdzlyN3gvNFlITlNvTWpwSmNn?=
 =?utf-8?B?bGNvbkhIZThrckIvVXBzK1JTd09MVEZtQzZNZU03WXlhdEZna2x5dExYTmVP?=
 =?utf-8?B?QjkrWlNPZkRyZkxzcENKaEJCRUlsQk1tc3VYTkhraXBzVlc2S1dHQU91M2s1?=
 =?utf-8?B?cEQ2SUQ0RmdzWEZYNUNwallIa29TOUpMbVYxeEZ2RU9oRlkxMVBLb0p1TSt0?=
 =?utf-8?B?VWRkaUlxRzF4YkZXZ1I0Y2EvbDdBd296STd1ZDJqQzRxeEJzMjRrSU9BdXNt?=
 =?utf-8?B?OWQzN0Q0QnZkN3d0ZFZDZEFuUTk5YnNVRGF6czNPNm54OXdFa0UwdFFOSENn?=
 =?utf-8?B?L0xEQlV6YUJyYzBHaW51RzNQRnE0VGtTWXhMNStzcTNCdzRBNVIyc0gwdVkz?=
 =?utf-8?B?Rld3V0NPUGcwdzBvUkdScnhpMU5XMmc5OEQ1NUMvaEgzQ0xHU2FzdTV3a3d6?=
 =?utf-8?B?T1hOeTI4NTlybzhQcTdXOWdoSVhWcW5ralRWSTY2S0k3QlhnSXJKZnU2MGpi?=
 =?utf-8?B?cHZkM05hLzhvYkRwOVlORElLSGRjaVlvdXZQRnNRaUlGZU9VWGNLUXh1N0F3?=
 =?utf-8?B?S2p3LzNUZzhyb2dOUmJvZk1iNTUvb0k1MFFUK1V5ZFljQ1dSZ0JnRVJvbVVU?=
 =?utf-8?B?bXRaSzFjdnd3OFp1OWltTTZ0NmJrd2xjM0hBbUQ0TlJrT2liVDFHSkphcUFr?=
 =?utf-8?B?MGxQZE11c1hMbVhkT1dqOUFrRUJMZWJqVjFoSXdSSWhhelUyR25JZWFFb205?=
 =?utf-8?B?RngzL2hFeXVGazZjRmtNRTNFTTJ4eEp1dzdFWCs2bk54bE5YUGZnbGpVR2Iv?=
 =?utf-8?B?VmN0U0dVTTl0WGROb2VjNmVCV0o2V2ZBWDZWV2xjSVNkVVE4T2djSFRMWW5s?=
 =?utf-8?B?U0o0TldvUWdRaFI3dDFxcExLV3NwYWlBRnB3UEkvc2w0RTRBZkhaS3Y0NEI2?=
 =?utf-8?B?d0t5VGFBMWFmdDJVeGZlZ3FJTGh6U1pPTDR3dEFNTWVSQjcrelVpOENhemdO?=
 =?utf-8?B?Q2RkNWdIMHJXeENYOFdzWmhhektQek95MmZWd3hqdmRRUnRONmhOTDZNRkdX?=
 =?utf-8?B?ckIxelBYUFJ1aFdORlU2OGJzZ3FnT3pBcWc1TVhlSitzd2ovZGxMRmhpNWR5?=
 =?utf-8?B?d0h1anl2V1d5bDhkK0F5dmRPVm9YZ2cwL2hwSDMxNFdyRE40cVZwK1E1czl0?=
 =?utf-8?B?N0J0aklHK0xXNzIxRGpVcmpFazFBWlp3UndWd3M1elZKQ0tTMjAzeHJma3h5?=
 =?utf-8?B?Vjlucjg4SisvNGE4VlNYQTc0QmNuSFE0WXJXcjB6OHdaVmVNbVcxWk5idENM?=
 =?utf-8?B?K2VjTjEzUXUxVlJwSkx6eU1lbzJZVlloWnorWFU3RER2TUpKWWNsVm9GK0Jj?=
 =?utf-8?B?ZS9uUkpPSjlndFl0czl4ZzJhT3phNDVTT0tqbUt6VFB6bSs3WmFMd09LVXQ4?=
 =?utf-8?B?UTZiV09oZFRBbTlLM1lVTGd1NkMvWDh2d0ZNMXdEdG1wUUhnM0M4YmxkbkRJ?=
 =?utf-8?B?RmpwQmlNTkhxTFE1V0ZyUFRBOEtoTXpMQVB6TVhsY2xtVUFkdG1XVktnWktY?=
 =?utf-8?B?QmhQbmhMQVdhY3M2c1pJU1BySUYxWGRDdlI4QXpNTUQ0ZGtsUHVsVFFZVFJI?=
 =?utf-8?B?a3RWRmIyR0tHelhNTlVsYjJVN1B6bW0xRkVFTy9BbDBycGFnN2ZFNkFyb01j?=
 =?utf-8?B?Mjc4SFlXR0Nzak1jbnluWDZ5cU81SmRQTDJ5Zm5KY3ZxNlhXRVZYSEFCQmwz?=
 =?utf-8?B?NUNFTzZSTVJwSjJFYUcvUzdPV09uVE1xZk1HbDlSNThjV2owd3VITDhCb0RJ?=
 =?utf-8?Q?xLxhaJOr8LOJiMUvU7s47tMQ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faff0e12-8408-43df-43f2-08dd264d2cb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:05:06.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB4Wqg+tOurE0qsyKr3YVnTbPtkUrtaxTplK666GSmMiFPYuxicKGTNVqo06rAt/f26UDmJfTNQsKllQp7ca/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


On 12/24/24 17:23, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:22 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Similar comments to on the earlier bitmap manipulation.
> It is simpler than you have here!


Yes, thanks.

I'll change it.


>
> Jonathan
>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 356d7a977e1c..d9a52343553a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -21,6 +21,8 @@
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> @@ -65,6 +67,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_resource_set;
>>   	}
>>   
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err_resource_set;
>> +	}
>> +
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> set_bit()
>
>> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
>> +
>> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
>> +		pci_err(pci_dev,
>> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
> bitmap format strings, not dereferencing the unsigned longs.
>
>> +			*found, *expected);
>> +		rc = -EIO;
>> +		goto err_resource_set;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

