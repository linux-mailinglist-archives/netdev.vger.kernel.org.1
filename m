Return-Path: <netdev+bounces-159798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28EA16F65
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9492188076B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD341E8824;
	Mon, 20 Jan 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qJWKjvZR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B041B4F02;
	Mon, 20 Jan 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387644; cv=fail; b=dAV4BW21e6ymARQLPFHfSLtF/KL9p/Xm6yee2VAnvWbP/Zcl6Mh2VZ8cpfmnb4PE7RRT5UN6Tad/NOCJHeIvLJX1Esf2MXI2lx8hr3Dr7ppemcAUDl93y2eLq8D+X2TFCH2zc12XcjM5tz3cu+yAxXuwAjgbvBQacEpgQq8tkgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387644; c=relaxed/simple;
	bh=LgyDeVW83zr6k/xGQuwwp2XxUHcu2NOx5w4m5EV7EkE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aijibx+KxWOjYUg0wrjIPK7Uh8IEtIaKtdK9RHK6nakj2a21yhxKlt+9008WB/lsj1DvQp+VPHp3CzmEvZnG1HkxaEVjvGEkU2N6B5wZ1eMguTyebyLDR7QtNCt77c9kKiQttPmx2+MtCpYb/fCwvd4wUjgtNGqc7B8olNkaRA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qJWKjvZR; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXLpB6FvC4sttuOYbr6O49xlteMd1jBxhHQSU19l6TSkNsqh2K62VbjyQiH1uH19BCX7QgEfd5jx/XsuIRchGUMO1pQb2tJnqZQeoerjjP2AgoGT9xLLslDCTEconPkYormhCCBObffUzhNdFPvO9/F/EI87ovLjcTU6uyyxqS8g2D+2ZYgCLaC4dtsI+TGCH5fw3194yMQlgorxb/dgNPkqYBDq4b+02YTwkpNmS8EDXaWBTd1nG8+bAvRkopRzPy1vFrBilquwm7eZdp2sMBjRRaamM2XEMRT9SalzUKyuwDBERUF2oXNlJ7Ml8zBqu9Y5KN2kgMBxHvUTv09O+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhDOJfFYoynDoNUJKP9TJzrTRGNrcPyoOfCx9zEnqvA=;
 b=PhDML10V0FNcCaUlu/aWr32yvSk+eP5a8VjwYj5w9qmoCG7j8Ae1Sm8gnkn4Yrl9lND9gBHNjZalZHiZ+okwQidyMdtwXZCN611mZYA0VkmLYCM2zrRrN3V+Bzc1OuFD73cVPvclf0cUNHdos7Av8IhqOozMkbIzd6zUIeCybMbg+gISoRXeQJtwntMEK1PXHzwl7PX1PPxUruyXgDSYU4vuVckg0gUVPF74TctVw4m+gXfZPr0/DNzeaVAzFD2RqUL5tTK25bIm9gqnlCWo2GdVKbBWwN4uIsfTixkRn8c1ZlPcYpYsuhNaUB4GP9Cv6PUEkxK3wT8d4G7MvM+9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhDOJfFYoynDoNUJKP9TJzrTRGNrcPyoOfCx9zEnqvA=;
 b=qJWKjvZR4rmvYKEE6zrVW+8g+msE7LZ4xJFZN7LZpLk0BwPNCoxMduYtFzwlHQcai6LYB2cSLFvqU6xPKzSOFCDdgT9jzTo8d+jQOhYfVogU/asGfD6noVPm0S68WK+9Kjny4i6AhKMfbZIM0R5f6HXGS9FQhc2oc5DC8E/M28Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 15:40:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 15:40:40 +0000
Message-ID: <0063f9c6-9263-bc4a-c159-41f9df236a7c@amd.com>
Date: Mon, 20 Jan 2025 15:40:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
 <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0109.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd6ea8c-c473-4763-0b50-08dd3968cb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWxIMGVRTEFyTm9yaXBVSU5TbkZ2eUxNVHZxYTdlYkJiejNOWHkvamYzMndS?=
 =?utf-8?B?SlAxYlNIcDV2ZThHeTlzRFplblphMFpLZzQySjFXSWtYenRGYzlKWC9peXBQ?=
 =?utf-8?B?YTFCNFFNOUdYblZwdFpUZThxVk9raVNBbXRJL1ZRNENlallnaUIvQkJnV2F3?=
 =?utf-8?B?THhnOTVyOXBFY3NOYmhhUU4remZJQTVxZmR5NjRObjBPelFxeDJBOXlacUhl?=
 =?utf-8?B?dm9tL2Y5M0x5anJicUxVakgyNjVIWVA1M0dPZm5jK0NHNlhRMm9MU0RqVGRH?=
 =?utf-8?B?SHkxZlFUYS81L1ltL3llekZYUWc3Mm9RU3VMTGFCbGpEakVYKzZ4MnlsVElk?=
 =?utf-8?B?SmZuYVhMTTFaUWRGNnZtK0FDeFgwOXhOZG5ZWU5MWVlDSUM3VnNtTzB4N2V5?=
 =?utf-8?B?MGg2TW14cDFvK3NtNDk2V1RIdERsK3lVeTcraG5aQjB3L2pxUlNiOUlqTG9E?=
 =?utf-8?B?a1lMMmxtRDhRdk9mM1RSaCtBdWFTR1l0ODhwVVFVRUNUMUNpWjlQMjBQaE9p?=
 =?utf-8?B?MnlvN1ZoV3pxQ2lKQVlqemYyaFZpdzZyeG1tNTRTMnlsUkdDYlF5b2pSYmNz?=
 =?utf-8?B?OWp4ZjFOY0x1ejNHbmJQb2FHTFVKK1kxLzlFNnh2REQ3ZEFYYVNnZjBRMURy?=
 =?utf-8?B?Ly8zZGJHZ015cDRiWlpHS21OZFg5Zkc0dE1NQm8wdHVpdHZqYXFTVklLeWxm?=
 =?utf-8?B?Q3RrNWZoSXBINkRTd25TeG1LbG5JRXQ5cVkvMmhJcUZ6blVKSUVKaHBtVHBm?=
 =?utf-8?B?aUJ0QVI4NjVTOWViSFFaOVdCOXpXQ0dIY1VWdFRob2szQUNoSXMwZVE1THNz?=
 =?utf-8?B?SXNTTGtiMUZxcGJFV2h1MWREWDZCaTd1emR4VDU5Ym50Q2hBb0IzZlVldkF4?=
 =?utf-8?B?dUxhK1R0d1cwaEVCZWF5aTNHQ0w2dEw4dEJVRkRvZ0s0K0JuMjF0U053OVlI?=
 =?utf-8?B?RFVQdk8rSTZ6T3lRZW9Vdk9hL0x5S0Z0c25pK0NZcEtWYkZ3SDBhRUhXQ0xn?=
 =?utf-8?B?dU45eW9Rck80TXZycW9WaSt1aC9DU1hiaC93U0Fpdjkxb2hUamFGMmJxdmlT?=
 =?utf-8?B?c3pLVXBoVlViTkk2SzFjd01Jb0YrOXNtT0kvM3Fpays3MTQwS2ZlQlpvU3lG?=
 =?utf-8?B?cTZXNlZKMnkxOWtIY2V1ZGZHY3BOK0ZRNm5TOEk2OEJiTFFnSUljZkp4TW81?=
 =?utf-8?B?bGZPYzJSUVBjZy9uR0lBVzJnZ2pLSm9oSjFEQzMreWhUdU1mTmkxOTZjSTlX?=
 =?utf-8?B?eW5PdzNMMUZJeGtZaVFid0hFelVKSG9oWWp6eWs4VGVBV091bkNFMTA4REJX?=
 =?utf-8?B?REg4dzJWNWRNcUxLQnhuQkc4KzVYZS9nK0ZuWllNQ3VXQTMrWUsydGpRZ1pI?=
 =?utf-8?B?eGh2ak1CUFRkejZXTmJ1TDhBbUVCNUZKSlVKTFBPMlRWcjk3QTVuWk1VMk5H?=
 =?utf-8?B?cmpQb2hPbU1oaU1FM21aMk53cUwrSUUxN1FNekpIVUk2NmQ0OTNmK0h4Z3Mv?=
 =?utf-8?B?TitTajBBVXpIRjBzMTV6eVV5RkNPZTVlZ1VnOWRWNlh5MTJTSG54K21tdmt1?=
 =?utf-8?B?OGRrNklUQzByMmpOa0VvS3VPUlkrYVVBZXExQzYrVkxpdVlOK1JZQTVmbjdh?=
 =?utf-8?B?VGNrVG1IWHQrYkdKRHNOZkVhZzFZWE8zQ3dmdWV0MmdLM2VCRjhhRlpGL3FZ?=
 =?utf-8?B?L3hCeW9Ea3huV0NQTjBtVUhXc2Vyci9oZFlxdGE3dEdBbTdDTklBOE90b3Iz?=
 =?utf-8?B?NkxuS2pLWXo2SFJpdllMNTNzZGdkQmlNdlVOV1UxMzZ0UzZVVGt4YzVDTzdF?=
 =?utf-8?B?c2d4RTM0LytVeVZUbXlwRUt1d0Z6K3dDelk2UjVQSVdEWmNyQlUzdDE4c0dP?=
 =?utf-8?B?M0Zzb3FnakpGMnZXY3BaekVYUVc1SnNBakxKdTR2dlBHMWdLLzEyb05Ed1pr?=
 =?utf-8?Q?qYUcj4p46HQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk9Gb3hLZUxoYlhBa2ZVQU9ObXBTa2p5SkN2N3FFZWxFK1NTVDR4WGwxOS9y?=
 =?utf-8?B?aG1heitTekkvbGlaZFU2NFBSdnZwbDBrVnByUklCTHhNTytFMWk1R2xOVHEz?=
 =?utf-8?B?NFF2MVcrVnQyY3dOamNkQnRvRmJ6V1BzUTh6RjJRdjM0TUs4Zmx5dGRkKzBt?=
 =?utf-8?B?cDFoaTVxM1RJc1NReFlXYVhJOGF0UWJtMUR5SzZNb1MxQ2FSbXdEbGpEL2pP?=
 =?utf-8?B?OTFpeU9RbXFEbWYyUnk5anlSRzRQLzU3UEQyL2o2OUE4TDhsa2wrMndIN0RQ?=
 =?utf-8?B?L3Ayd21lakx0ZDFsODdnQ090TS9zcnd5SjFJdlQ0WDRPazdtY3QzcHFEbFNi?=
 =?utf-8?B?TXFLZWY1MUVZeGRYSmJ6OTBKdzBKQ2lQTFpYcmVrNlJPblNQL1pPdHE4RDFB?=
 =?utf-8?B?M3VFZWd6TDVnVFNUdnE5cmlic2xiNDRSK0g5L1RqVFlqNG1RRzErZ0Vxb3Ey?=
 =?utf-8?B?a1FnZW5GSkJzYXMvQ3lOc2swWDE1emwrNkU4NHpNa1JFdXp5a3NCaGNLT3M3?=
 =?utf-8?B?Vmp2bTErei85ZW4rc1ZJN2ZFdjZHcmhXbUtjYkthQTNMYnRMaktaWVlBeWE3?=
 =?utf-8?B?S3c0cW9NdnRZbndLdVlnNEhad1BNNXVhSEExa0ttWGJ0MmxhZWJIK1VYSjFZ?=
 =?utf-8?B?N2NveHdjcGVUVVJiMHVicE1QUnN1Sit1VStpbXFwd0hXZXhvSnJ2YU0wSlNm?=
 =?utf-8?B?OWM3SS9maUZtQXJ2RUsxbkJqSTR3RnU4bmJsNWpic1lCWFZKcFMwd3JuYS9U?=
 =?utf-8?B?YUgvdldOUXdkbWlpWTBnVEFPUS9SSEpMNFZ2RmZPSXlycFVacGNiU3ZUajBD?=
 =?utf-8?B?TllIQ0wvbGRoOGJFYXRCR3pVOGZuRzNQV1VlZWZzeEhRbmRNMUFjUUEzQmRp?=
 =?utf-8?B?KzdEYVVqNTZvaUhhMDljOHRyRkpCRnBmdjkwY1BtM2VzUFd6djYzSXJ3WGpV?=
 =?utf-8?B?ekNzbTU2dkxGeEQ4eGtweklGWGtaVUV6cjJrYkVsMVFad0RLRE5QcnhoVFhI?=
 =?utf-8?B?VVJ1cUxBRjB6aU5WbVNSSkVNS1pjSWxoeFVIU29aZ29CTWR5M2NzN05BMVNH?=
 =?utf-8?B?WWJCK29yLzRMYnVacWw0dzZCMi85eG9XNVczYXdyZjhrQ1M3bzh3QUNTQ1lD?=
 =?utf-8?B?WjFaVS9FNzRNTk1aSm12aU1xNXdkVXFVbkw2c0RJZmFvRThzWm16Wlk2TnBS?=
 =?utf-8?B?WTFNYXVTL0RCcWlTWWp6dGowSEdreXJqek90bkp2UTZteCtXbEpnamlGcjV6?=
 =?utf-8?B?cE95dXpJalZQbGVrbXlCdGF6K1FubDhMaE9SbHczODV2NDRXSGY1ckVIdTBp?=
 =?utf-8?B?bjRIcWtIajlUV1k3ZXBzNS9oam9HWFpHSmM0blVjaXlZbklobkhuQkt0ckcy?=
 =?utf-8?B?VGk2K0RuaDgvY0hHYUNMV3RtTm9MNDJJcTFFY1p6TEs4Rk1DdVBDYzI3d05q?=
 =?utf-8?B?MlFWWXNoWmJCV24vMHR1NTljc0pYNzNsM09vWGk5bHdvS3o4OEIyU0QwZ292?=
 =?utf-8?B?OXZPc2VUYTVqK3Y1dUFVbXFZZ0h3U282WmR5a2NiSnhkcnFJd1R0UHdCeWhK?=
 =?utf-8?B?SFpxcXAzWXI2VkMrcllaSjNnYnEwK3VoRVdQQ1hZRnJ0cXFVeThSMUJHVkxC?=
 =?utf-8?B?ZytTMnpQR1dkVmxtdFV0SVdxcHdlSEtJSjlIQnRZN3JWNHJmaVcwWS8zSzBz?=
 =?utf-8?B?SC9VUCtocm0yWDJ5U29PdjJ1UmpEamZodlNwKzhablhlT0N6STc1STFPckRa?=
 =?utf-8?B?QkRQem1aUzZhdGNoY3piYnZieDZGaXZPdC9nb2tKUlVKNE85c1NLbmFLQU00?=
 =?utf-8?B?MnF5ZFE4OWJpWWg5MDlNL0NwdVYzZVllMkdZelEvMHhqYnVDMDZOa2JlMnpa?=
 =?utf-8?B?aHFIUGl5aExyWmhIZUxYL3ZNQy85bWxjODRMaFIyTUtXbE1CMXpHSDE2MExv?=
 =?utf-8?B?WENJWis3bUs4NDdqcGxrUU1pRTZrYnRQdTN0T2xvTTNZNzUwQlBsbE13eFpv?=
 =?utf-8?B?dVZ0YzdSeWd5L3Q5TTlkbnpseHBERytXUUhQWE9sZmRNVHV0QjVIaGU0Wjhn?=
 =?utf-8?B?Qk9xN20xM0FLd21BSG9GcXJrZnFXNXppTmhkV3ExTWJjaXJnakhwdWRjYkdM?=
 =?utf-8?Q?sEBAmJgFZehkKqijUuu7rkbE6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd6ea8c-c473-4763-0b50-08dd3968cb00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:40:40.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYS8yw3PjYRKSWGzww1JQqapL17PntbwZy8h+notcMvrqykX+mJqyGXu8VAB6qoZ/swefC3W8rANMyvZqip4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918


On 1/18/25 01:51, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>   drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  2 ++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5821d582c520..493ab33fe771 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>> +				     struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>> +	/*
>> +	 * This call can return -ENODEV if regs not found. This is not an error
>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>> +	 * mapping them should not fail. If they should exist, it is with driver
>> +	 * calling cxl_pci_check_caps where the problem should be found.
>> +	 */
> There is no common definition of type-2 so the core should not try to
> assume it knows, or be told what is mandatory. Just export the raw
> helpers and leave it to the caller to make these decisions.


The code does not know, but it knows it does not know, therefore handles 
this new situation not needed before Type2 support in the generic code 
for the pci driver and Type3.

This is added to the API for accel drivers following the design 
restrictions I have commented earlier in another patch. Your suggestion 
seems to go against that decision what was implicitly taken after the 
first versions and which had no complains until now.

More about this same issue below.


>> +	if (rc == -ENODEV)
>> +		return 0;
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +}
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, cxlds->capabilities);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
>> +		return rc;
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map,
>> +				    &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
> Only after we have multiple instances of CXL accelerator drivers that
> start copying the same init code should a helper be created that wraps
> that duplication. Otherwise move this probing and error determination
> out to SFC for now.

I do not think moving this to the accel driver makes sense at this 
point, but I think it is worth to try to share this as much as possible 
with the current pci driver for Type3.




