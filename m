Return-Path: <netdev+bounces-237192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47081C470A1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB13A2F04
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193431F3B87;
	Mon, 10 Nov 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wE9VqL8e"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A020B80B;
	Mon, 10 Nov 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782473; cv=fail; b=d3Qn3EEu3ybZSx88K+mnaWBQPRg0+qUlCRN5ln/aOaweAeAN8j3Xjshio183hrOI5+eOK1cNrNhpRPk0QexPQt89j3eRRFWuaM1qBWbml6Zjaor8fcMWJn+YO91ifGQsndnuX3mVmbZ8HEkP1EQRrAqimmlV4q6WvJLwnp0iTY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782473; c=relaxed/simple;
	bh=hAXWAYLzlYWIw03AwTZje2YJbr0jSLgZ0N2G2hil7dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paasmOJCe/1Zf/FdRaFiyD/4SZ8ddNggmHB497nGpksqYw9fUPfnVqwoF5IXJ2NbYL8wuYdoEBUJxgOW5+j+4TtWXWuTe4Q8IBtaaJ1RpT+zXxkF8lqTgJdHMYhL/HaalMsz8a6owHFGaj9xwELDsjUDZDQxPBY5gUpONzYfjWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wE9VqL8e; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzKbi/vDMCJDYvnO7bFOYLC1AoH9chh/KM5pKb6fLyTQPxgh2SjambCluGVLl/ouulTVvS5q+fXC32ijUilgoCiuccrG/OKLXWWFr/R9/aW8xlX5welP+cbPOYSsXgBca7x7QoGopef3MzzJ+NE5sKkKur9qZwG9m/BRjkUS6jQTDIhnpOB4yqOPAKw1SCL+VXE7D94Gh/5J3nzpPLJ6Tf3FL4WEg+WWGC2hbrMk7lNGjaek2NMdT3Jlk2FdI0uns/n8L+KuPBDrauYvw2qpx3sglxjfjpLo8xeCGMZ2NCMbW3+P89I6sXfwvr7pDlhDilzZ7eyYzz9f4ET1SmrVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSG9QzFcFExpYsjLuGuSLVd1f/5D9klLVmSA29l5kYY=;
 b=pverCCzIECHFpw2OdkNaOTGtP05NVB5ahEMzQnJfA6G0jO6uL3QdCzUqiZoM3LTMjzOu07bh9vZeMJSQc3vdPX3Tgwecig5jcA2PPWMo/RL3Op1dxpcW2A4lyBXntQUlmvVEFJSwJ8cIiXYEcRhgbmd0JxUXyzF1ggKzwm7FDvDvmSrXO5GXlZz9WP1VmiStoPd5jH3q9Sixcuyp5l06GzKBGch485v62rr4O/CJ0+hvmV2bR8aEn2tBDxMUu+w3Rj09KvQCFyoomq2HoMrteRCdnw5foUcUuwBnOrMPKnqN/Ix7B1RUXPfreFr1iixznZjAp/HOeW42U21mBPiYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSG9QzFcFExpYsjLuGuSLVd1f/5D9klLVmSA29l5kYY=;
 b=wE9VqL8exEx+aISfyClFdZxTV9Z8/nY22FasrhLJqTUi7HzDyWOajUkTLmoOYEiIm3bUteNgEsTfiLpW6+CPck4E7GIi5MTf9lU7QJAc5o21+D5VgE57xhaq4fyh2xJvZk0TcgawpcsrAVFY42d2BqJU97YHEpFLl97gf2htlZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 13:47:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:47:46 +0000
Message-ID: <5f09f8d3-5bc1-40a1-a9fa-1ffe14bf2eaa@amd.com>
Date: Mon, 10 Nov 2025 13:47:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <20251007151143.0000744f@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007151143.0000744f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: dcff7c02-a110-42a6-5ffa-08de205fbad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SThXc0JwcHBySlhJdVo4dTJyamQrSUkyRnIvYWFpSVF3T2tSVUZMN21nMVNz?=
 =?utf-8?B?M3E5U0Y0alZtS1RBY1RncW1NNys1WUZOQUx2WXNuWTMvYWF4anR3QWJRTFVl?=
 =?utf-8?B?Wm9ROW1KbUJTOTQ5eDY0SE1vUk5PZ0k5WVp5ZGkvejhsQ05CQkpSdU4xY2tS?=
 =?utf-8?B?WkpBTXhwQ0F2QzZVYi9QelVEam1xQVlDelI4V3JvZk5uTTBydldjclJJRE92?=
 =?utf-8?B?eEFIZ2YrYzVybjJZZ21UckY3TWlJUzM4L21Ia1FsYk1BR0czVUVjalM1anFJ?=
 =?utf-8?B?RHcxN3kxVlVlUFVPQjgvclpSdEVoZTQvc0QxdEQ1SXJxL2xBRjN4NmJhUGZK?=
 =?utf-8?B?WmVXSjFNeGNST05yNFozNFd5Vk94aVFLNysrUXh1QitJWG1uY3FOS1ZZQU1x?=
 =?utf-8?B?cG95eEd4WWd5dG9PejBPeXFvSm5mOVhwekhsUmE4L2I1V2Z0OW90eGIrdFBJ?=
 =?utf-8?B?anJMRmFTalg1NHJQRkg5aGRaTCtoVXpsTkREalJSbmxOWi96Yi9udi9YZkxL?=
 =?utf-8?B?SjlxS3dnMVZrNWhaZ3hzTUJ0WGhuUVpuTmltR3dnU3ZXMHRkbERUd3M2NDhF?=
 =?utf-8?B?NmVkd2FwT251NWxRRnlRWVl0YUN6bDlNUUpsc1BMMDFaVnpLUWtDMEhVUk9r?=
 =?utf-8?B?NkxsckxmckFlZis0U3U5dVdWMWJKYVQ4MjdObEpvY2lHcEY0Mkh6V3RkMEZ5?=
 =?utf-8?B?amE2bzI3Y1pHVlZYUys0NktXU25kK2JlZmRpeFM3ZHFCT3RzTytXb0VlTG52?=
 =?utf-8?B?djBhY04yVnoySUd4V0xxdWJvL0JVSXd3SHBET09SRVBPV3pWRXpzRTZER3Z2?=
 =?utf-8?B?QzJmVkhDTmdaanlSZVRLaC90Syt1M2E5WTRaUlZ2VTNTMVpwV0JLanI0OWRT?=
 =?utf-8?B?NnhuNGUxZnF2WHh4YjREeDVCWkU4Ukc5TTdFb3Z6TE9uRHY1L2lta0dBVHB6?=
 =?utf-8?B?N2Q5VXVLa0xMYnFrL1R4MEkrOExNYTJIaVpQcDBLZzFzTlNUbnpDblJTdit3?=
 =?utf-8?B?Z25wTVBKcjg1bDRLbmhldDhnTFZiTGJzR0ZMczhDdlN0eDZ4RXJLVWdqc2Rk?=
 =?utf-8?B?c2p0NWdyNzIreTlZdWJzTC9TYzZSZk9RZHczZGN6Zkh3bTY3R041THZFMUNW?=
 =?utf-8?B?K1dNTEp1YlA2dW05Rnc1a3d5Z1NnL2VBejR4MENNekdYNmVwd09FTnRCaC84?=
 =?utf-8?B?RFFOM1VneXN6MGgxV1BLR2R5VC9uMHBYaVRPY2hQYWpVM0NKeWozVTQ5Q0ti?=
 =?utf-8?B?Tzh2UHp4V3E4Z0tBU3VLTEM3UjNhWTE5a3ExckFqSy92MmtFeW1QS3JjSlFC?=
 =?utf-8?B?UzZtRHVFUk5QV3g0K3RBZGd0dUZLZTBBa29EbGIrWCs1WWN3WmE1WUg0d3o5?=
 =?utf-8?B?eElHTUorcDZIZGd0cjk2YW1GalZMOWdLaVpJM2Nkc25TUlU3Uk1XNzNNNWp0?=
 =?utf-8?B?OUVscXhPb3h0d3ltRS80UjhJRjJRN0JjYzNGRUVRTFIvaXFjc08ydHRDV2tT?=
 =?utf-8?B?aStVTDZ2QTJzOGk5SUV1NTR1ekdjR0o4N2wyeXlkYllNMkZ2dko0OFUrb1Vp?=
 =?utf-8?B?QW1SbGJaTStZZU95eFlCOU93Vk42ZjdJWGxVZkhpcUprU0NaVHdjanYyL2Zu?=
 =?utf-8?B?Zldxb0tuRjZiNzVLbGt2ak4xL1dEei94YW50Z21zNDFRNXE5UUZIdEk5dVhp?=
 =?utf-8?B?WUN6R2dJQUZEaHhtSU54S1VUSlFUSGZWS1UyaHp0L1VJTFhTQk1wQVRJZHp5?=
 =?utf-8?B?ZldWTFVZc0FUTmtOT0FXN1NQZkZpY2llRVVwMWxWNWJZSHpuYVlUVm9YQWlV?=
 =?utf-8?B?b05EYWZxaW9wbGJjTzBFODU2S2ZpS043U0RZRE9oRnVSVFdBSUdSZjAzWkFI?=
 =?utf-8?B?V2dXUE9zZ2FrTnp3azVGU2Q0d1RxNkNjemcwM3lrL2lMMWlvUzJKWC81ejZs?=
 =?utf-8?B?L29ldnRCSGN4RVlUYlo0TGFjRUNQeFFHQzE2cTBzUkswYkF2OEpzRk9hRlpL?=
 =?utf-8?B?M1FnTE5vRlRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFlxdGt2WE0zTnRSMm10OWlUclZMRE5iOVhHTTJyWi9tNlFoQTFzaHBselZC?=
 =?utf-8?B?bEdKakUrNm9XMEpQcWVWb1FLRHVpUWsxWjR2VlluT3RBdGh2ZWhia0hZL2Jx?=
 =?utf-8?B?L3ZDQTkvWVNZb09EYnVUNGhEV0NuL2xScytBVXowOVc1RTM5UThkaUpuUE9p?=
 =?utf-8?B?NlR5WmtyM3JLMjdXamRobUpDWmxjM2M2bjY4NWkvbzNUTmJGUkpYMkhXZkNT?=
 =?utf-8?B?czlrMmY4QmhPbkQ1V3I2MjRSREE5cVZCTHBuVy8vNUZRRndVa1hUbWdWOFd3?=
 =?utf-8?B?NzFzV1FoWlpxYmZDbElOdDd0S01MTnlzR1kzbS94Zi9sRzhLM3BSbEl6Zm9x?=
 =?utf-8?B?aFpQL0JRbWpHVXJvQmRWYy80UGEyeisvOHVQQXE2RFFKZFlhQWt6Y1NZSGlY?=
 =?utf-8?B?eTZlVjFlV3FIR2FwUW5BTDFKYXlaTFIxZHFlcjJiOEpxU0drY1FTdjA0WkZE?=
 =?utf-8?B?SHNZRmFCdHhaZ1d1NjE5ZnhkdjJ0SW9vNUhib0RHSVBabGUrTnZtVEkwem5p?=
 =?utf-8?B?WVhVYVNCMlpjTnVBZmRCdUZIMFB4NGVhOEhPRG1VTTZpMFFXaSswUktrb0Jh?=
 =?utf-8?B?ZWhvMTJ4a1B2NjkzaFlMenN2RVlRaEFPSDVRdFdZRmx6Z3oydXc3Kytsc3JT?=
 =?utf-8?B?Z2ZoUjlESmw0REJNNjYwYW00dUlKNnF1c3JIVktESkFQNDRsZkRpR2JNZDIw?=
 =?utf-8?B?NFRJSTlmTVB5Z3VyZWFNU1QrNjZDTG1RZEFMMk9IUWVoalZoNHhxL3J3dVhP?=
 =?utf-8?B?MmJXak5NNStGTTNyWS8yRjJhSnllT05kSWpxbkhybmd0TDZIYWpxVGhHcG5L?=
 =?utf-8?B?QXpyWnF3TVNTZXJJZWpNT052eHNwbGpPTkM3TVM3ekhVSjlvYXZVYStLc2w1?=
 =?utf-8?B?amdpSENhcXBKK3dDT0Z6MFRzRXYrSUJwRGRCWXNVa1Bzd0puR1dlU1BNSjdD?=
 =?utf-8?B?cU9SZmVUYjJubnpUdWNnRjZ3QW0vYVZUeWR6KzRYTXg0MS93b3grS1hHYldH?=
 =?utf-8?B?UG1BaGR5cllET2VoMGcvUU43enNGdExOVmNwK0lrYWQrM3QzQVR4cnYzd0wz?=
 =?utf-8?B?MGxJTzdSSkMzeVgwL1N5VU9NMERwRU1TYS9CcE9UbFhQeEFMbGhqNnowLys4?=
 =?utf-8?B?a2E1b2xEeXRsdWhmanhMYWdHZnhOZ0d2cEYySXFnRlgxVkQ4Y0dzZW9JOEhh?=
 =?utf-8?B?NkVMRDlSb29pT1ArVWFaUlFNMzQxelVqL1VSV01XM01hdmkzME1hUlNmNkNa?=
 =?utf-8?B?aUxndll3MkJxZ2VjZFREeGhjcURZa1FWZGwzVVpCQ3pXeTJsKzdTejlmMm8w?=
 =?utf-8?B?T0M4MnZpcllYblM4ZUhYU0VkV2gyUW15RDkrbVpWT2pkT2dOL2pkcFY2VTNS?=
 =?utf-8?B?Rk16Zk1tUU0xbjgxSEx4dDZaTjh0Y2xwK3F5S3I4U0hBK3ZWbENoRnFDSlg4?=
 =?utf-8?B?czBNTUp6cjhJVkwzRS82Y0RXY0lISEErdnNoUjNPV0J4VGI2Z1p4aDduWnp6?=
 =?utf-8?B?T1poYzZLUW8rd1hrTkdxdFo4ayttMDQzR3k4SCsrZGRZRnNETC9QSGRkZmRZ?=
 =?utf-8?B?YXB5MUFiQWdjSkhZM216SVFEOXl6TG5MWTJTOExybVkzQWx0SkNXa0lweXZt?=
 =?utf-8?B?L1JEM1lZU1ZVREgwcHgwOWxsUkFNZ29KakEyMS9lUjgzb1NONU1rNFJ1bW01?=
 =?utf-8?B?TWdMK3FaK3VHTlhDcndldmtsSDRoWlg0c2Y4Nkp0SnJUM2J0aWR4K2NVQTNW?=
 =?utf-8?B?aS9OQmhvR09LbHg5NXYrTGhwK1JXYkJxeFZXZlZlYWFyRmRPTis5VU14QWJV?=
 =?utf-8?B?RDBGV1FTNU5TNEZWdXN0SEhrQ01FZHBjWm5ra0phbDd0aHpHbVptbVZzaFZu?=
 =?utf-8?B?bjRCa3c5cTY1OE9oK29DM3Fwc0dHdVl3QkJUQldqZkd6Y280MjlIZ1huaWg0?=
 =?utf-8?B?LzhPV2cyT3NlMXlyN0tQTEV0QmUzY2JYN3h3djlnWGl5c0lITVhudnd3YmJC?=
 =?utf-8?B?N240OE9nRlNnWjcvRVQ3UGN3WlRRQUswUE9hQ2gvWnBOeWROYzFtWGJldDFy?=
 =?utf-8?B?SkJrVkJyaEZuY1pyKzNrVWMwK2d3RWg1MnNHdHoycUl1cm52L3A0RDFobmJs?=
 =?utf-8?Q?ilVz000Lkc2nJALSRA11+wpNq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcff7c02-a110-42a6-5ffa-08de205fbad6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:47:46.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8ggtXkgXb6gggAUfKHu75Q5GGl8n8Q65o+vLjaAxzV/l9kY39cLXDZ5tJfdnboqZTq9whAHRZMEYKhAZB+/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124


On 10/7/25 15:11, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:26 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> One new question below (and a trivial thing beyond that).
>
> If you adopt one of the suggested ways of tidying that up, then keep the RB
> if not I'll want to take another look so drop it.
>

I will drop your RB since it is not clear to me if your suggestion below 
makes sense.


>>   #ifdef CONFIG_CXL_REGION
>>   extern struct device_attribute dev_attr_create_pmem_region;
>>   extern struct device_attribute dev_attr_create_ram_region;
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 26dfc15e57cd..e3b6d85cd43e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>>   
>>   	rc = __construct_region(cxlr, cxlrd, cxled);
>>   	if (rc) {
>> @@ -3621,6 +3639,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	return cxlr;
>>   }
>>   
>> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
> Why pass in an array of struct cxl_endpoint_decoder * if this is only
> ever going to use the first element?
>
> I think we need to indicate that somehow.  Could just pass in the
> relevant decoder (I assume there is only one?)  Or pass the array
> and an index (here 0).


Just the first one is use for creating the region, what means the 
struct/object which will be initialised with the attaching phase later on.

The region will be created with the target type and mode of the first 
decoder used, but the attaching implies to check the other decoders 
align with this. And all the decoders are used for that and for 
calculating the hpa size to request.

So I do not think there is a problem here, at least regarding your concern.


>
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	int rc, i;
>> +
>> +	struct cxl_region *cxlr __free(cxl_region_drop) =
>> +		construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	guard(rwsem_write)(&cxl_rwsem.region);
>> +
>> +	/*
>> +	 * Sanity check. This should not happen with an accel driver handling
>> +	 * the region creation.
>> +	 */
>> +	p = &cxlr->params;
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s  unexpected region state\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>> +			__func__);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			if (!cxled[i]->dpa_res)
>> +				break;
>> +			size += resource_size(cxled[i]->dpa_res);
>> +		}
>> +		if (i < ways)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		rc = alloc_hpa(cxlr, size);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +
>> +		for (i = 0; i < ways; i++) {
>> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
>> +			if (rc)
>> +				return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return no_free_ptr(cxlr);
> return_ptr()
>> +}

