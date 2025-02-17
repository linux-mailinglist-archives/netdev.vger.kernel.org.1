Return-Path: <netdev+bounces-167021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B1A3851E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3CC188DC5D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB229D05;
	Mon, 17 Feb 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qsmYntL6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E07748F;
	Mon, 17 Feb 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800162; cv=fail; b=QhLXXVTB46I83CUEt3b+ADB90bkfWmQhu08+pSkcsbNlsV6Hh0mp7ZNiHLGRAqCCg38LFSt3zKCzLLkG4sB4leyhaOufxL3k5zoYGY5EFiBfx4QA7Tb3VsqqNZkY1As84o9nOKASyF8iT3U69F8UHf097Te597F8F/daIp5hJQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800162; c=relaxed/simple;
	bh=2siAUyLZUxnpQHRjvQuaCeg4RVj4JP06s5Qu3tEFIWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLUECNO3pLs2Yv+eLU0c2gKGHq9dDwa7ZuRRzBxfvZxx3xtfJjLiFT0FFR0pEU56WvacyDlvFo/IHI+0PcRn1RkciyEBhVLq3SLG0cISgwmlNJv63x2ScVXpLfGEdN8BKM6FzpGwbyRX6+0gVfeg07eYyOkGAz5H5iHFtEHrrJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qsmYntL6; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly1adBMm7YvE9i1dZEXzYjtVpNVH/RTn5OOhf6t1PTU5b5BtJQrW8DuMY1Ptrm8Ae/VELQAGtD3Sg91bKMI3OMvTt7togpUToKDITNAOtIHpsqK8SJntJzDXGfpMS33DUdNE2Q2YiALhUTcxRpoesmTXQjngcO3Uj5KTLo8siRBrLN8Vrv4sEW8gZfNuZ6CmJSbRX6mRHxSrbbQG4KECGXvn6nHtxmZKhatugbiglidhh6vkAEP40DYFr83gFy6W9DlfUmxwt4GEYwj5TgAv7oOenLaLIqJufh3WDktOFd0dx9zTY4xd/QSg+Sm9etwxFBPdnqPrQqvuhKzOWzRpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71980WQPPJ6izqpDtJ73vjbcknFAsHWt+HctxlZRjOw=;
 b=PcbIuxd185aKlv+HWs+g8/b9oElOdOsn6cT7VeQ/siwZ7NJNfxeYOVrgvBWWO7trl8J401ue/tkO13ogOT9v8uHLVFth6ZjPXIDiImlj/RUGIXBSy9kl8EP6TptoFDeBmYlvPb/0BULyYNur5dhRBC1Y0cHCDLzkDxdM1PMKFpBH5Vh843sdReXmic26MkAjYfhhszId/exjl8fLlEuuoumKuLYmFYFZMYxBF93ND/YXpAXo3XEFR3k2NWfDmnbpX50lp4UXC5+r/8a91PZqxyFHkdYywXi7atkfivlnFseUdYppAYTGMyGE7ChTV0hm0w3EYKAdUXM/l9SH2vgT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71980WQPPJ6izqpDtJ73vjbcknFAsHWt+HctxlZRjOw=;
 b=qsmYntL6vn8K6B1o0mtRTlaylBkMQbQoMSggGNpFHIAXkDwo7eo9CY+k2iaAK0qNaGbtw44Q6ZQzVz6L8fO8jkXHzREVed8xoRhfQ/ZadRE37dTK9uuvWlBeTP2xgDRcQmIiOJ3aSI0DdFNL5Oxl5GiM2xTl+Wsu9ettV2vsIzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 13:49:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:49:16 +0000
Message-ID: <b34f139e-6fe3-4a4b-8090-1abe3788ecba@amd.com>
Date: Mon, 17 Feb 2025 13:49:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/26] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-15-alucerop@amd.com>
 <Z61wWucUQnzjcEh3@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z61wWucUQnzjcEh3@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: fab901f0-e06b-420c-8b04-08dd4f59ded5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnZpaGZZODI1NGlJeG0xL01wTTZqNDQ1NytRN0FyT2VvOGhDRDZuT1NjWWJK?=
 =?utf-8?B?OEdhc2hDZEhWR0hzNzFWcEwwZWVhQlZlSjBJWWV5V3hOU1BYLzZabyt1M1JS?=
 =?utf-8?B?YkF1QkRyVSswcDhFVmIzM3MwZHJlUmF0Wkxvc1FpM1k1cjlXb28vcGQwSUZs?=
 =?utf-8?B?VTVjd09reTNBMHdOYXVncU12MW5JaW05cy92WFMrTXpCZnZqYm5JcnY5ZUg0?=
 =?utf-8?B?VjRkRkdsQ2lLQk5LdlNXUDI0OHR5TVZFNU9Pbmc5ekFCQy92Tm9rRmhNb1ZQ?=
 =?utf-8?B?MThnN1J0KzB6bzdqRExIZFZvNlpQRnJtekVNdVB6NzVtVG1mZXVNR243L3E4?=
 =?utf-8?B?cC9ORHNMSFl5cXFYSmFCVGVYY3hGMjBKRDVZQk5WL01iN0IxdjFqN2lWdGNZ?=
 =?utf-8?B?bzFXRm5pSDVaWU0rRHgwYkdyM0F5NkkzMDdaK3JET1pISnlBMHpQL3lodGUy?=
 =?utf-8?B?cVJWMkJseWd5cXF4UklZOWVwMmdicVNoZnUxcEhpUGYvQ3FtMEQzenZqOGI3?=
 =?utf-8?B?bmtwSnVtTUg3NXE3ODVTZDgvTC83b0lKOXhHbHYyTzgrcE5JblNTOXVnN2ti?=
 =?utf-8?B?STUxQkNKb0ZGQkE4Qjkrc2tsUFpDdThOdllTUnU5ZjJpdnNZOTdzZHJJd3U4?=
 =?utf-8?B?SitNc2plUVJMNGRiWGdBR0pFRVp6TlVvOFBLOHlXNHFqelNVRFBWQU5uTEY1?=
 =?utf-8?B?b20xYStqaEppMGFYbEYxREVxMEpzR3R3VjVoNGZXbmJOUDcxVkdWUjN1ZGZ2?=
 =?utf-8?B?MXhCMy9BUytoUVVuZVRhMTNyNytGYnM0SFhVNmJGS2t3YnpJMWFaa2NHOGwr?=
 =?utf-8?B?TytNZmhPZGpQcVJHMy95UUE2MWhZTGFWNFZhdTl0MzFzWFFXUGhZeGhuN2Jw?=
 =?utf-8?B?RkFIendSbzdzckpRRVRnSkRMYk5RMUdNK3F5V3o3RVVPYU5sVFNlVHpldkt3?=
 =?utf-8?B?UWNiL1p5Wm9udGo0R3F3aFIrcTN3bnhyTXkzQUQwK2Ftc21wSDliNmd2Nmhp?=
 =?utf-8?B?Zy92b3QweFNNeVVHUUdMNkhsamh2QUtpdUJ3ZmM1cUt5Z2t3TE5uajFLbmFS?=
 =?utf-8?B?Y3Q2dEhxZGFFQjJTNm9UNGxMaFYrcGJhYWhWa1VkMTl0L3VFWGdFRmI1bWsx?=
 =?utf-8?B?cmlKVE0vaU4rbkk2QXBYZEpyRDBRN0d1ODNMaHFLcUVlRDdmY1N4dXlWdlp1?=
 =?utf-8?B?UlF4TG1SRUw0ajh3MS9DYnFTUHVISEh2QXRsdG52UHQ3MngxTGNUVCtWWGZn?=
 =?utf-8?B?ODBnYkY1dzBrVXlOd3dteGI2eXJSRXdVK29yV3A0eGtVWnZ6QUZCZEY0KzVE?=
 =?utf-8?B?d1ZvdlVSK09ZQW5LRTZnWUxrbFhKVTlrRFlJZERNOUlTTy9PUGxYZHAyNEZQ?=
 =?utf-8?B?MVRUTEVTWnI1eVJwRHlJOVU1Nk5LL2thVHhOUmhGZWNCajRiVUlLdEFoT0FT?=
 =?utf-8?B?bFBKSDlPS091VzBuRFpocitaREJwV1Yva1AzRXExNU1wQ3FsMk02TWgrRStx?=
 =?utf-8?B?aVplbmE5dHgxUGs2OG5vYTNqV3dpVWhCSGUrL2tIL1hMcjdtRU0yVThJUHJS?=
 =?utf-8?B?LytyVGlQVk5vT0pPL3hVVHhQQ3BVVnZRY1hLZWFkS25OYnpoN0duMXNTRW9B?=
 =?utf-8?B?bEs1cHRGM0d2WGFXSS9NMmIwRVgzSVpPeHd1eHRKbWxFZjMvVHlCUUY5MEcr?=
 =?utf-8?B?MTB0TGdDS09MZDNGSHVxV1VsL2dITWpWOHZnd0tZTEhKY29nR1hwRXgvWWtO?=
 =?utf-8?B?RHRYeHR3R0ZCN1NobHJkWXNzWkVKVzJjaTRRN0ZaeUs1MzFmYlNMZUpBeUdu?=
 =?utf-8?B?VEcxaXpyWE1neU4rUzEzcURqQTBRQVRsRm1ZV1dTa0hzelJ5T1QvY0huLzNP?=
 =?utf-8?B?anRQMGlLaGFMWThHd2dZMjluc1pOdjZPS3ViZXNaQ2lwUGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnhCc1hqcXM0aUdHbWNCNlFGWi92RHlhTlpPWTV2SEltOURIRnVKTUtQVFpV?=
 =?utf-8?B?UjlYelBhbnFNWHJxMVVlZ3FBYkh6VUpLT09oUjNzcDVWaEZSenVDM0crTzdF?=
 =?utf-8?B?K0Iwazh2VitNMU9GZGN6cllEZUU0ZGZaZGg2eTM0clRMQlJuUUdsNC93S3Iy?=
 =?utf-8?B?MkV1Q2V1L254dWIvK2wvY0VVUlhwVTdlc2FORjYycVNZZXVNK0lCWjFIaGJM?=
 =?utf-8?B?OFFrZGxaakJ2b1kvWklYRlNzTTl6L0J3N2IwY3VIZURQcVp6d21wQTdadHlG?=
 =?utf-8?B?R0lwaDJ5MHRnWGJuczgxN05UbzUyeDIzYU1RWU9xZXNsSnRXWElVcEdIZlBK?=
 =?utf-8?B?dzNhOEt2YmZqQVoxbFcyUmRDVUM0ekp4ZWxpNEs3cE0xb3hCLzREcExZR1g2?=
 =?utf-8?B?Y0FIUVo3SzdabHZMU3hxQWFWWGV6b0NlL1R5S1RZamJpOTM3QVd4RTlvaENo?=
 =?utf-8?B?ZVNUNmQ1MlQvT0FXazh6YUJvNnB5Y1hTZGtMMG9taFp1bmErVE5vNVJPZktY?=
 =?utf-8?B?cFc4UmFpdlorYWNhTnAwV0NaZVhlM0dBTXpYRktZWnY5SFd3a2Z4NUcxQ0hs?=
 =?utf-8?B?aXpQYUswNnlFTXY0R3VJRlZpUEJKMjNmV1FMMUJVYW9HUm1XVlBHWTMwVVJ4?=
 =?utf-8?B?Tm1hTkN4eE84aTlHcyt3RnBOcEpiUENCOXJIbXBySi95c2dFY1RiM3llM2Qx?=
 =?utf-8?B?TjZ3T3l2bEYwR0hRQ3VUYmpWaFBuOTBxNWI5RzFPUVFHcm9TY2lPWkJZc3o5?=
 =?utf-8?B?QUpySUQvYW4rVWhBWGlkLzA5TVhpbGk5MEsrU3p0OXY1Z3R4ZVhFdzJrU1Yw?=
 =?utf-8?B?WlpJVC9rRnhkSUkvZ3o5SjV5VlhKWUYrTHNldHBLdE14VkdkVUZSK3pFcXJN?=
 =?utf-8?B?MlRQWUVhdEwwK3RlS2s3elByYmJzNkw5SDNHTFFTdkpuOGx2eXNWeDYzR3lq?=
 =?utf-8?B?Qkp0ZkRNVEQ5T21VR0hvWWludGFHTWRsb2FGWUtHM0FWM2NwQXdWUXk2enY0?=
 =?utf-8?B?YmJXRTY2cStrL1BuSnhMUXZiTEZQRGFVZlhPaXBtcUY5OWV1MXdHS25yNTdX?=
 =?utf-8?B?aEgwbmhVa2tuSUhZbC95WkRMbFd0a2UyMytYTkl2Q3ZZQVl6bW82bHFoMnB4?=
 =?utf-8?B?RGkvWk42dy90RDJoTEZNUnp0UWl0aUN1Y3E0bzh0a3V3YS9FOVYzOXdwRHNa?=
 =?utf-8?B?cHVpZFBjQlFOcDBvTlpEYUpiMzY0eWRtZWhuQ2RwWFZuRjFNYm82QkxITVNX?=
 =?utf-8?B?alQyaGRad1RMZHNhR2dYMmNVSVJkenlpbmxqTkpYS1FwaXUySkZpSGZFUW5j?=
 =?utf-8?B?bDY5ZG1QL1ZySk1uOE0wM1QxNEMzcmVoa0VkS0wrTVpLNnZ3TW1oQjZhTHJ5?=
 =?utf-8?B?Z2dwR1FLOG54V0NOT2RHbUVNbDl0YlJIalZmWjdLTVdzSUtlejdmTDQrZlBn?=
 =?utf-8?B?SXhoNmQ5VlM2K0VBM005ZEZzdHBQR3lWQmkwNVFiQnBlZ2hCdVlXRkhQMWpE?=
 =?utf-8?B?YkZEUTJhOTQyREtKTkFrdi80QXJQZWw1U2VMeWVkY2lDUFpyUVFIdWZVV25t?=
 =?utf-8?B?Tm92Z25mUnllbWtQVkFkN3RldXNFbmlIWjVKQm9oekxDVGFVRUpmMTBsZEw0?=
 =?utf-8?B?WUE5WmdvL1ZCS2VGUkZzWGpvWk44Tmw1dk0zZ0lsbE5rVTJKbVRrYktmRHZM?=
 =?utf-8?B?SW94WDNIbCtWR0pqd05WUjg5dmdFVFRXUFRvN3dZOWdIS3o3MWpMempuSXpN?=
 =?utf-8?B?cXNOcmZEakdjU0hMMHc3ZWdCdWEvaXd1Y0RHSXQ4bTdoMWlHVFIxZG5uKytD?=
 =?utf-8?B?Tk5PUy83Y3BqbnZKM2lHdmV1aGM1bUJ6enBPN0c5bjVtRHJ3UTFuemhsRVZi?=
 =?utf-8?B?eVc2ek5VSkREOHViQjlTQk1rUXAzVVVUYVhwcElyQWxFYkkyZDM4a2VQWHRY?=
 =?utf-8?B?ZnlKeExRbnAzbG9NOFNvWkVpTzdRL0JraW5NNVNrUnUzdmMvTW1IcVNJaTRq?=
 =?utf-8?B?SWtmekM2eVRNSkZVNEo2cjdlcmtCUGJEM2krczh0U1Q1bTZYQU9wcDZvNyt2?=
 =?utf-8?B?SEgwZjBQcExLZmFHa1AvZ3ovV1VCM2dPV2NtcWZKREtmM2N2MHB6Y3ZOdWRH?=
 =?utf-8?Q?3QciaqFkZZHspJlC+/l50Hh3h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab901f0-e06b-420c-8b04-08dd4f59ded5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:49:16.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlplP8HKGNNsE7G4cb31atqHRzDfSXQe/A/6yQp3Uu47GiXPI8d7fQlSN6ZceKFg9r4Qt13gPaYX0+lzYsRJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347


On 2/13/25 04:08, Alison Schofield wrote:
> On Wed, Feb 05, 2025 at 03:19:38PM +0000, alucerop@amd.com wrote:
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
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Checkpatch WARNS on more than one of these in the set.
> Dan's SOB goes after his Co-dev tag.


I've commented about this in other patchset versions. I think Dan 
co-developed makes sense since it is based on his original patchset 
dealing with initial type2 support, but it does not seem right to me 
adding a SOB.

If this is a problem, I will just comment about the original work and 
remove the co-developed line.


>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  10 +++
>>   3 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 84ce625b8591..69ff00154298 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
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
>> +	int found;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +
> Above deserves another bracket at least on the outer for loop:
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> "Also, use braces when a loop contains more than a single simple
> statement"


I'll do.


>
>> +	if (found != ctx->interleave_ways) {
> Adding on to Simons feedback: Even if found is OK as 0, prefer it be
> initialized so we don't have to think about it on every static report.
>

OK. I'll do.

Thanks


