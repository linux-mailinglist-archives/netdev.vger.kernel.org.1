Return-Path: <netdev+bounces-179637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64CA7DF04
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D651C7A2230
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B66253B5B;
	Mon,  7 Apr 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CzGKsWlU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E623C8A7;
	Mon,  7 Apr 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032319; cv=fail; b=LuJL+YH/eRAw/Ok25CbpPgf3BEZhlDTOY06APFj8E488Bq8ijvNrh3zpo7cfMBzeAnUw4ta7Hrz80O9blsET6eMSkz0ousL0pB5BQ2epi7PteO7UX8pOLy6XE4QE2ZG5nO/0vj0Cdq5SOhyZMwkJa2pYCOvnReqNenxh8XAEewo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032319; c=relaxed/simple;
	bh=lPZlZVaCWs6ZSwD6xPgCTjLZmKlyV4X8Y/DRT0JsgAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KekGcilZYucOwdIMK6pHcJkicX4B++1dRdOFvArSzuec5xMbJYPNOjOjqeMWEV3uRoAiKgaJTvI6M6ASMAzjH6vWbAn+6DdvhPRcYOq07TPKze+1ELCnv6tZ74Gu08Q2Bm59djI1+GEj3xMfF8Stw7Sqa/p4W2Ou7TQCkTx6lSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CzGKsWlU; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDQiL/PA8xOZvOaDVjS8zQ3C9cwReu4x0suVp7OB13P6YHnfyKRIm2IHyxXSUvDoJWT1sRx/5Wtfhpbnllt4fhti9wt2+j8sgpCxzOhlVBGNrIm7TAgBisw88ZQgrQLW4d7Wbm45Gk3CMqtbp1P3wmST567aT7wdboXSAl81kKKxS7u69Vz2t6JI/75nPkfnTZrS0stKtKIYo2CIGAaR3URT6ie/pG7mCzXJ22W1fiR91yoc6Za+H6vWe4peNHFgGb1v/RQUAOhREIBdAmtSCJqjyh0saNfcCrGvccN1gNlggws9F1KvBgM0YITcQ81DZyUvtCjW9A7wWO2pzLtUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8pmid+pLwDo5qK+c0cCagavYE0hBSP6YG/itzIBjN8=;
 b=CTRewtk8j5oC+1colfY1CSMuD42t7NthbvFUa1yxhETvtMZHrKSi5r8Woqx1+PD/7ebqEOw3zHZGk8y457A4V7xFPdzBRWTkFb2nn9ZG8432kmivA1y1DhC9K75DetSdy0l0PzoTqaSPaL5VWts7aerI+HM3BGxO+RpKzBezvcmHlsyNIfCi7eWiJn6DPJMtVeeyM8PROXoUm/KhICpgVs7ATEvjLmps9MxAZm5b5PdDsx1gE8yYJs5YcjimtMKTGRdVugs7bTYYpank0UNuqbFGNNJBBBWup5toxM+6My05J7Stqof0Fo0YWHvpKKjF5cgxiHyWN4m9wBYGWq9GlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8pmid+pLwDo5qK+c0cCagavYE0hBSP6YG/itzIBjN8=;
 b=CzGKsWlU0sQzlbdZweeuT6wtzzvkCnYHg933X3glD0Ljw0hibFzYWrna/0Ftggli21S4+bX+MOLT5j/al+znmnhbUyF6Qji7z+JPgyiePlmw1H5eFZKgSuNBSRQLZbxZ61w0tsfj41riHU85hAecmwRKJN4Jo5nA6t30BxYyvkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 13:25:13 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:25:12 +0000
Message-ID: <eabbe979-f6d1-42fb-880e-66b1f9a4e617@amd.com>
Date: Mon, 7 Apr 2025 14:25:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/23] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-12-alejandro.lucero-palau@amd.com>
 <20250404173716.00004438@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404173716.00004438@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0487.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::6) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5577b567-bdee-4479-f448-08dd75d7a04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2Rjc0NrUEw5REhINVhSczJlSlJLUTBweGc1NkI4RDZxYTVRM3ZTSS9XK0JH?=
 =?utf-8?B?L0pVcmZpRXE3UmxiSjYzdmFRc3JPNG9pTzlxbndRVmFCUWpPY2pyZjgxTnMz?=
 =?utf-8?B?K2FtUlZIeEJSd1Rac3drN1g1a3V1SzNVYkVxWnR2eUxkaTZLaktDQmdxTmNo?=
 =?utf-8?B?RnU1bmdZZ0cxZmJjdzVjUkpYbHhzSHY4OHdrSDBpUGIvZDFiN1FmZjYvU1Fa?=
 =?utf-8?B?enFqYzN5OFNtelZWSTFsNndJcGtVRVNNdDk1aEZjSTNlRTVva01VNnI5OTVp?=
 =?utf-8?B?RGdQVjF2TWVvYjB5NVRNN0JkeVFGUVhpQnhuT0lvaDZHRG9XWTY3VzlhUmJM?=
 =?utf-8?B?NXN4Q0RzQlZaYnFpcURlMFVqRE5rL1NoM2IyMHJTMVVya3d0bDdOeHllMXMv?=
 =?utf-8?B?TFpCNFp5Y215akRIY2cxb0xPRkJpSUVmOGFLanFja01sczNpVFl1WEMwUExI?=
 =?utf-8?B?R3crQ0MvZUVZa3ZMUFBNVkoxcGZYNnc3eC9NZXlWYXN1OCtWZDIwOEVlQ3Yr?=
 =?utf-8?B?aDA1NG9KNVFhU1ZjRDBISzNSRlRiaWtJck8xMk9WYkh6OElLL2RROWdLQnZj?=
 =?utf-8?B?VnZHaXZUOXBWbUxjZmtZdkNXckovVkhyZUxTTlhzZitDcW8vbUhYSW0reTFF?=
 =?utf-8?B?WDdML2t6RWt4UWdaM1l2U1F3UUFVaWF3dnNadlNJZXdQZ2JlNmlmV3IvMTRw?=
 =?utf-8?B?dnR6Z3FWZThaenM4T0k4VFJZNDl3dHJZQTBwNCtGSkhiTXNaRG9kbzc4L3pm?=
 =?utf-8?B?L3hxQjd1RFliVXZxTWRXSWJGcUVPM01KdVVVOVhIOHluclB2WmdZQXZnaXZu?=
 =?utf-8?B?MjZFVVJYcWk3VjgyOEYrMU03OGN0MnhVcVB3a1NDUTZXaXRHbFhlTStyeTR5?=
 =?utf-8?B?VlB2Vnc0MVpSbzhSNndVRTJnTERZc2hRV0Yxb2I3bGdtRWVFY0lhWnNUNjR5?=
 =?utf-8?B?Rk9sbVM0UHdoVVhlZWdnNkdiUGtTZzUvYlVZTnZrUzJ2V3RTY1F2Q1Y4NXdB?=
 =?utf-8?B?MTBDQndzRG93elBmRU5EdzFNNWtEUEk3N2VhQnBSSmxOUnVTdW9tblRGTXE5?=
 =?utf-8?B?V3JyZmltaUVoYllqcFdQQ3doUkNBdUkvZUR6L29UWXRPS0FJN2JwbWcvbzky?=
 =?utf-8?B?bTlkWHFveXNYcUxzbW8wUjRON1lDMy84SURtQzFJVHJJNVBLTE1McW9mNGQr?=
 =?utf-8?B?T0tFcWdGZzhWbkU3SytENk15L2IvTkRpelpuZ3pyZGkwM0N2WGFjVVRsc2Zr?=
 =?utf-8?B?aitBVm5URkFDSVhWOENsL2dPMm9tQ3lFU1kwNGFnZWJKcXdsVnNSOGE2dm9M?=
 =?utf-8?B?eldRbDAzanAwUTlMS0pjSnljZHlwdThIdDA3S25QRlhQR1dkbUgydThuUTJK?=
 =?utf-8?B?cEFFWU1sY0NvVW41MmluazNJcjBrNEhOek5scFg4VWphZnlITVhaa0hFa1NV?=
 =?utf-8?B?RUFMdnV1OFhkYzlGNFE4VGVCR0t0TWxqS09KcGMvMFU5SHJkTjhoR3Irc0Nr?=
 =?utf-8?B?OEJzaDhxdWR1YXRHWU1JR2hGcVBaNktnaytDSzZpNy9VM1hBNXF0Y1d1NG1E?=
 =?utf-8?B?QWU4dzRqZXdTMUJIZ0w0TnY3MHpMQStzUFI3ejhyT3dNT2J2ditOaGNaOXNn?=
 =?utf-8?B?dTEzL0FjVDY5d1E2OFZLOE9ralBGUWg0RVJpM2xrREVMQzAwYTc1N0NWSFdp?=
 =?utf-8?B?c3dXaHZpU3ZxWEwzUWNLclAzb3ppSGJVaE4rR2s4SUlmZXlBRkNaSVdNWUtp?=
 =?utf-8?B?c1oway96SFJjamdSVHZseGdweWYra3FmWElsVGhSZVZwVWRaQVpmZWZRT2Rt?=
 =?utf-8?B?SjR0aVppTkJEdHllV0JsdUlNa2JUZG5saTZidnB4eDh5WVBtdUMvRW9ranZt?=
 =?utf-8?Q?Trk6R2NApMgZJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFplUXNtOTJvUW91SHFFdnB0RUtQRXBhT1RwYThlWVRmU2tabHAzVk5OblRY?=
 =?utf-8?B?NkIwMW1XTkZOVjU5d2t5cXVhL2hwdE9LeE50c3F4TE1lTEUyN1JXd0tYRXA4?=
 =?utf-8?B?WUdzMjllRGd4T2RTOU1vV1JIbFNNekF0QzI4ZlRPK3pIcGhoKy94aFFZRzE4?=
 =?utf-8?B?WWF2bFVTejBZck92YStlSkVSNGJibFR6ZUhKU3FVeFZHZ25NNzdLQ1ZDM1Q3?=
 =?utf-8?B?Q0NxeTkrR2Y5eVVkOEVPb1BJVUtHb2gvejNTcUJHL2JtOXRwN1pZcTE0RFJq?=
 =?utf-8?B?RzdrSWU2dzUveEpxWVY3c0wzQzZFcUJQUSthSWQ0d2dWUU1sc1BHZkZRanJn?=
 =?utf-8?B?bDc0VGJlamRzdXA3OUZLMk85em5qV2Z3R05NV0s4T2lmUSs4Z1prM0IvbTBl?=
 =?utf-8?B?QWdza2NBSXdqb0pzeVNLTUw1N002WlpXWFpiUlNOYmcrKzJiL2JPc1czUkQ1?=
 =?utf-8?B?bnprbGhTaGxNWDBSZDZFblprWkFERUo5QXgyMVcyWlJzWW55QnFPdXIxTzJ5?=
 =?utf-8?B?bzNEUlE2QWlwdGpnM2RHK1RwZUt3VXRoc2oycHArUjJqdVQrQ2NvZzhsOW8w?=
 =?utf-8?B?VGdQcnBhcXd3TS9ZRmF6bFhlOHBwcHZBR1FuMnQ5a2dFaXdRVkdMelp1dVZa?=
 =?utf-8?B?bGlnam9kNlRRVnZyeWV3d1hqb0FPWVVodU9LYUxmWXdZQTF1b1lCRis3YkZM?=
 =?utf-8?B?WklsSzdCdGlYbFFuUTFtZUptbXgycjZoV2VxdWVOR1B4NE4zODNGakEwSUxl?=
 =?utf-8?B?Z2l6ak45RlpNRGt6aVR0UHlQVkNaRTN0LzFLMWJ0c1Rab01qZ3hxdzVMNEhT?=
 =?utf-8?B?L1VVampRL3c4MDl4aDRUTUFEcmVwMEd4ZllBZndZR0ZuS1NySkIvTU5wVUJ6?=
 =?utf-8?B?NytkUTBVdXFyZjRPeUpCcDRmS2ZpTzFlWFoyVzBYYTJISWlqWTI0L3ZBSEo2?=
 =?utf-8?B?cVJVQlFNOFgyRXluVngyMUROSVl0Yk9oY3YzWm8wZlVqMDRaNWxGbEdjRmxL?=
 =?utf-8?B?TXZqVmR3SlhuWjVkNVgzN2NSVktKdHdacENVanYrcXN4cmV4WUdMNm1HMTdk?=
 =?utf-8?B?K1l6WHJwY2cramx2MXlucWVYem5oSHJ5M29tZU04VE1lRFRoaHMyOHZaUXpW?=
 =?utf-8?B?N2xvcHpha2w5dWIrTU9wYnNqd3BJb1d1VmtrMVJ1WHZSNGQ4Qzdla1dDZ3lt?=
 =?utf-8?B?NUZxaHNySmN6YTg0a010ZmFqWHkvaUxTWUpaYWVQM3pQc0hrdnB6MHUydE5u?=
 =?utf-8?B?ZzJZYTNOQWxkZkIzcjZCenJJVVZwcXYzaklIeUxDcjFMcEpDeEw4Ymg3WGNM?=
 =?utf-8?B?QmxUS3JxaVpxV3VCeThncFQzRUxLNlNHODNOcFQwdVFUdisyN2hwOWsvRDJ6?=
 =?utf-8?B?Z2pDZmJWbUZYOTZTZGN1d0F5Y2JQRDNkdkJxWDhGemNsWllzMHhySGwzbFVV?=
 =?utf-8?B?eGxxVXRVdDFSQWI5c2lpVEtxSFptNU1tVXhGY1FHNGtzSlIzM1E3akxzT2Y1?=
 =?utf-8?B?bEg1NTdoV2JHRThKaGVVdUdkRnpBUWdzdjZCQUJSc0pZalNRSThTSmtMREI1?=
 =?utf-8?B?aEp2VjhESFc3WUdkckJxakRBbVVONkN1aEE2b1JjZUdiSnN0QTVPcXpjWExQ?=
 =?utf-8?B?OXlkLzdQaUZpMkpEb3dJVFRVRm5iQktOSGR1QVU1WVV2M0dyUnhDQUV2N3FU?=
 =?utf-8?B?eWdBT3ArY1NpSnExWXk1dnRwR0wzVytsbytWTFoxTG1zQ3lHdXZodXMvNDlz?=
 =?utf-8?B?c0FNSWVaZUZoYjB3ajZpSnpFMnV3NEQwRlRubDRXeXEwMXUxT1R1UGpCdFV3?=
 =?utf-8?B?VnRYdmRXVVJQNkdnWFZseWljS2hYbzI0bllDMDVQckpBTEJGT3JPdjhBbmd0?=
 =?utf-8?B?T2JwSjdoU1VuTTBsU2NBYjV1VTJyOWNoTDJyMFhtREFsRkVMdzc0SkdKN2pv?=
 =?utf-8?B?N1ZxTmEyaURkMEpudlRDVlVZT25DUHVxUHFXZ0dFb2R1MFlsT1dTNDJucUV2?=
 =?utf-8?B?em9rVjhSeVFGZ2JQZjR4aHBwejFzWFRCdjZUWGoyL0FSMFdTcWloQkdrRVZ4?=
 =?utf-8?B?ZTUxamJlOENGbkxiaFY0L0xWMHdlNm9WN2tRVmtKNlZzZkRLbnErRFI3ajgy?=
 =?utf-8?Q?IfYW0Q9MqMm6b6ITAOROKVF+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5577b567-bdee-4479-f448-08dd75d7a04c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:25:12.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PebBqjxciP5TTReEJXOwG9SwBtAV73Fi7VNc1NaXsW76RxVwqAOgc2rHhtREEbw5h+4fMPuIMql81xYRp1Fh1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333


On 4/4/25 17:37, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:43 +0100
> alejandro.lucero-palau@amd.com wrote:
>
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
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  11 ++-
>>   3 files changed, 173 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..59fb51ff8922 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
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
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> Hmm. Is this a subset test?
> if (!(cxld->flags & ~ctx->flags)) or something like that?
> Or just use bitmap_subset() on it if they are both unsigned longs.
>

I guess bitmap_subset can be used since the cxld flags could contain 
more than those required by the caller.

I'll use it.


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
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
> max is already 0 in this path.
>

Right. I'll remove this one.

Thanks!


