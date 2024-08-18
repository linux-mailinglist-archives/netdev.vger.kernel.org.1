Return-Path: <netdev+bounces-119477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC958955D20
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B88C1F21623
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4112B8B;
	Sun, 18 Aug 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0MDTXw5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77221340
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723994160; cv=fail; b=rwDghVL3tUJ2uu+CS211kAo1QGiZurYStcmr7hxpYJDhbL6vVSsQuJl5AN/4lqOGa4Z3wLGUDNBnf983lTU4HfDIQywTx7P1OeAh86bJcJgwn65XTRHiARwJ4wIsMfOKyb1wKALaGNL4TsPzsRQb53rzDOCSvlgBMeKsGFE6zRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723994160; c=relaxed/simple;
	bh=zX/P7xEXNSDh8HCl7s9arTes9oe1z/dAfxqcqSVyj94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I2bRlqct/51JRQMPYYiZk06FG3EFiR+wdH5EchP79eOIVdCZyIIjA9n73aElVO8iA28JWZTMnShacXtOuoNCKpowazWMLXgvMmxuaxH94Ladm6agwyOSqv1UNMY5ilFc/IJCTc8zFKDo3PnQIW0kx0uni6cqJsYlPxktkJkvkGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0MDTXw5; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pccy0rmpCn993i6LomKkG/rqEtqYFh4jceXhNLZ/BJfBMaphFeSHd1I8BQlDe4bW0AdL3qOcLDEthi/x9WPMzL67Hqz0wkS6Ezx0or+P9q0FaaKvSiXg/1owAK7VRrcn7Z8JxtkmeeO9LYxZsqZADXCqwTLU9LvNzQ5MHqDmA79n5U/8AvEiWJggLthnIbwgsnwcoHHsSc+fRQyWO6bGuH+g1uSE3dIrcbBfXS0dAXxiqcsL2EQJyyirazC+5CJhKdeLp3Jt1YQW4OeobOmPMfeuPbT9cmw53WqlrcOPzcHFQ5fkGZKaU6QLwhZ0rF5jeQ9rd3Oo8SWllN3zbiTYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajG7aZuukcCVUE8luRRo+O4j1fcg5p+lMj21mzFRpEY=;
 b=Lq5MKjDegjCmWrqG50iBlkxSs1A9QKY3Ysu+2VpZOhUGogCll/uXr9Xb4L4i55gy8+QROrSSTnVDSLYZ8VP6Yv6MMX/NODVN8xO/3m4VxuIVg0yEVUVvVQRSdOzp72u6Nng+BgFq4dPp5bDvk5Imw5Lmo5zOgjmX/3UvhhVJ9E5mijc0lhMgC+ruAh42XifUU3zrtvWZEDDsabve1ndQ8it5LiN4KbsXW8Wrileci2LaUlDFU07JDphV6tLEIgBY5X/C0+COS3ZARPJMGGc/FluSOWqwzyt/o8Lfl2E9QvDP5o5gHxF00f+TvQ0bnhf6+hCPVFDYFQ8URG5rB+Vh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajG7aZuukcCVUE8luRRo+O4j1fcg5p+lMj21mzFRpEY=;
 b=c0MDTXw5SMe3MBhuhPXnN/45Wr7OqkabXpqxsy1EJDFPS+nsgbQ7cocBA9jt+u36STo5jq/Ylj2K/iL9Mp/dJR54wwtPemgM1vz61S22mV5DheeMSOCw1XeB6ywtFKR3i/2qlUsfrfXIPC4jjpYUT6AfYZ8V1vNr6vn4A+6Cgs1PyN+Q8OdgrLTL0Ya2lu+mdcmjh0ty4OvcVcRqjXMSRRxnpFENSu7r5ths53XVqewCpCPa3CM1IQR3Nj/p81Tpq1RG7sG3saHUDOhl8J+kr1J63NDFgRKKCVAI9jTmdoA7en/TtXYrzwHKDa+3Xb5oj77VWG3lXlCLySzxZEjWbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 15:15:55 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 15:15:55 +0000
Message-ID: <f9339419-7abf-48ca-9c1a-bf84bb9a8ff1@nvidia.com>
Date: Sun, 18 Aug 2024 18:15:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning
 in metadata_dst memcpy
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20240818114351.3612692-1-gal@nvidia.com>
 <20240818080944.4c19255e@hermes.local>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240818080944.4c19255e@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: e95412ba-b614-4776-ce27-08dcbf98a7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0ZtYjFmWDV5WERoTWd5ZFd3UWxYM0s5alc0UkViS3dFR3J4aG1kWFFxT0VH?=
 =?utf-8?B?RnhReVZQVVNRMHlXT1RvNUFCcXlGWjZjRDkvSjk2SnpzWGdmektlWE9za1di?=
 =?utf-8?B?ajFCWTNqeHNyLzNxUDkwMTBCT25YYWVWQ2NjeGV3VGJvanhaeThKSzFYL01E?=
 =?utf-8?B?QjJOdENFWTVteVgwTkdFeDlCUC83eGlrajlOZVdtZFBsYktybkJLTmZEWXZ4?=
 =?utf-8?B?K3FmSlpxNEpKTDNGbUhGdit1SlB5ZzJJWEorekUwZzlqRlZnTTViUHZadFk4?=
 =?utf-8?B?ZXdBN2kvUjc0QUlCczBWTitqK3phbzBnTzFER0FXcFQrdUJ5N3ZPN2RJclYr?=
 =?utf-8?B?YWlHZUV5MzVXUHJLeVlMajVCL00xLzkxRTRXbDRQLzJOVFNmRjhnS2cxZHR0?=
 =?utf-8?B?U3YvUVZqc2ZEZnYwYmV0NHJkVlBvNFpIT0pQWTFld2V0ZGtCK3JBM3gvWk8w?=
 =?utf-8?B?MkYvVnU2VXpkZFF1aG1vdTBwSUFnYXBCWkRjaGcwWmVjMDA1cExkVzMxZEJR?=
 =?utf-8?B?NUR2RHEwbkd6Q2VIZkQ1WHB1dklFZlZ6TnJwWHQ5dnlGMTBBY1o4Sk91dnAx?=
 =?utf-8?B?Mmc2SUQ4aGVIUHBrQXpjRDNMcXpWQWIxaE1nTlE0TW5id3ZmUnBpZ3BmTnF5?=
 =?utf-8?B?L3lVeTd1cFZIV0RYZmI3WnBUSHZWRjdPeHM5OHNmUk5TWkY4cWRjTDRKNHJ1?=
 =?utf-8?B?YlIxd1dFa29tb0h2RldmK3ZRL2dMK251dHpmUTRRV3pVYVJoMmFzYmJYSERN?=
 =?utf-8?B?dVg2V24rRklnYXFQT094UHdadXhRTERjQUU5OHpXb1dCU1FTVjVUYXNnbEZ6?=
 =?utf-8?B?cjVmVVAxVzVxb2pTU1EvMEFNdGdyMWw4M0JibWVyWmV0K2hOVWNZbGtPMUV3?=
 =?utf-8?B?NVFkVGFXRTZzdW9UWEJpOXgycEM3b0Y2bnV0bFlaa3RkS3plZnVpMGZjd3ll?=
 =?utf-8?B?OHMwc2hHZDhCT01ydzN1TEt5THNwWG85NzVGQWVndlQ4STRDcDFSVEgvR2ZM?=
 =?utf-8?B?Q3RuWXBxSjM0a1dQVjBWbFV6L2QrRHE2VDlMUE9RVTEyb1Y5VXhab2pvNGJv?=
 =?utf-8?B?L0cvUE9UZHR4aUlJRk5pS2dLM0dWZERYcWVIVTIzV3MyQjNVaytyRFV3dGd6?=
 =?utf-8?B?RU0xTGNoYmh4SnZGYkhCNnhrVzZrci9ONUFEZTJucTI0d0VPcUlhS3BBeTBp?=
 =?utf-8?B?TUdKWnJzTmlPRWdocnhTU2s2Nm5IVTdOV01JTFFYdDI5VTZyMmJwbUhjY3RP?=
 =?utf-8?B?dGZJUUVheWhHL3VmWFBacU43T1h2Tkl6YjgrZWRiczBPa0ZOc3BaWStRM0N2?=
 =?utf-8?B?T1B3NWthSUNyTEtGZ3JZRERwNXNHam5ZRmNxRnVNeGIxTGdPWnNwR0JDQWRw?=
 =?utf-8?B?Mlptc3ByaVV0b0hSM0E5YWQzK1ZzRWsyaDFSSE50VndZQlZrVlhQY1NrOGZI?=
 =?utf-8?B?bjNqRVlrK1BJN0ZJaHc5aWxtU3pSYmZudjg3OHJaM2R4RDdMRWlHTzJzRkpD?=
 =?utf-8?B?OC9rb3dPWm51Wlh6WUNWY0FHeFNVaEp3cFVmT1IvYldJNzBGWnc4enFyTWtB?=
 =?utf-8?B?UkZFSTFTaExybG1tV01obzJMUWV2eVdTNDdTaHVXcEV6NnJ0eElxa0VGN2ls?=
 =?utf-8?B?TEpHYTlEMUxDSk41NTZXQ2xCNUUyb2dERzRWc1M0MTB5ZGF1MTJPRkFTVzJz?=
 =?utf-8?B?YkFUU3NwR1cxMWVXK1UvSnhyOHFTY09FbzgyQ29lVEZXRnhpekc3MXBOMkF2?=
 =?utf-8?B?MlhmblcvRitPRCs4ZDc4ZWxqU2lmWDRsdUYvYVZlSTFjT0ZkTk8vRGp2ZXE0?=
 =?utf-8?B?QkhLVFlWd0g2R2ZsM1FBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JFUEIzYkczdlFDRVRlVEVSbmpVNUxlWDBpRXVoQmhQSVMrUjdMNERCYmxY?=
 =?utf-8?B?Ly9PSUl3YjlmcEkwMGtTUnVva0VDREF0Q3l4c1Y2L3BVWmkwcDVvQkY2R2lZ?=
 =?utf-8?B?ZzFzUmw5VngvL3VqVU5TaUR4cFVoUVNtK3pHQmhidjRFRkN5M21scW82TlNO?=
 =?utf-8?B?WFRqNnM2REFLYUlWdmlPZnIza3JQUjFGamNFekNkbVc1NXRqSkVxbE9VV1Rq?=
 =?utf-8?B?R3lZSVFFZUR2clFsMzgrOUtXU1lvdDVJaWxuNUp6V0VDZmZ4dU9NeHdVQ0Jw?=
 =?utf-8?B?NnJ0WHk2UHkxYTF2NXMzQ0JlbWtWcTF3SUlTUVRHT0M4b1ptd1I0Ym1wZmZz?=
 =?utf-8?B?Y1ZSUWhGdlhZdWJHRjR4eW1OSENOaTR5Q0NraXBubVlSSlI0YUJyN2pTa3ht?=
 =?utf-8?B?M0g0MzZieENEL3QzNXhZMUNyb0t1ZXdHTjFyaHVvSG9EUzk3RnEvNncwL2Vn?=
 =?utf-8?B?aEVSUUNaOUpSelQ2OU4zMTFOSW1vR01POFpJVFpqUFVaMEhwNUNOS3lNVVBJ?=
 =?utf-8?B?cmhpUWh6TkJONVVIZDUwYWZqcnF1aUFwdGVkL2NGaDJkTFI0QWhRcVJIdUND?=
 =?utf-8?B?Uk5xODdMSHprbUxpRXFQaHpkVlVLdUpKeTA0ZTRnWUJXQWRqNEZnMmFZOUFY?=
 =?utf-8?B?YmtRRVZ1RktqTnB2R0RHMEwrVE9jaHkzdy9VL3JZbXhsQVdpRmwrOU5WNnFB?=
 =?utf-8?B?cHA3QnlaWHNpZ25FR1I2emNhbUdjUUJXM0pFZGpoMWIrdDNMa1hkait5SXZx?=
 =?utf-8?B?aGFiVGVQUHlGTW5uK3BZcnJweTkxelFlcmVURXo3RmhGMXRaajBIZmZ5Nnho?=
 =?utf-8?B?QWxUT21uRnBEK24zSEM0VHpPcXhzTVlXS2J3blZlYlhDM2w0YkhmVnkxNnQ5?=
 =?utf-8?B?d2JJb0hpb29kMEovWmJsRjF1RHRyenNRRDdMVy91K2E2azMzdlo4UytQRHY5?=
 =?utf-8?B?VjA1dlhYS3c3d0huTXJsTzJYY0U0N09yWlo0T1dmZXpBMWxNdm9OREZCMElh?=
 =?utf-8?B?b3ZKVFF4NGsxYTdzNC82SGlXTEp2VzFvYWtGT05uZE42M09wb1REUVlOQ0pF?=
 =?utf-8?B?OWNpQkx1Q29mdWVraWRldjhIbGRzQkROQm5vcEVPTlFTbHo2QnBNNFpEbXdy?=
 =?utf-8?B?b1BTR0ZnZXo2aVJJUDIzWS9RR2I1eGhDQUFVK1ZOM3JlOUl1aGlhWFIrODlu?=
 =?utf-8?B?ak9DT3lxZ0ZKeVdoWmdybEZtckpxRHY5UFdpZHNMWER0VHdDcGRGU1BWQyt5?=
 =?utf-8?B?NERoVUtDeEd5aFhqdmNmak1wdG5CUFQ2eVV5RDlmdlVlQ3pXdHgrbXBGNEtW?=
 =?utf-8?B?RG1RbldSRHlabUhNQzRhV0YxRWJ2REJHdjJIRjNuTTNCSy9yMHVlRitmS2FO?=
 =?utf-8?B?dUNvcS8veGdMTmtMSCtOdVBzcER4TmJUSERsbm5DUkFjYXo5ZmE4Y0krSmRO?=
 =?utf-8?B?Q3o0WEoxWk0yaGRtK29xWXZGdzI1QVFBSlJQWnh4MGRiZ1BCMmt5MnNVclJh?=
 =?utf-8?B?UEo0VFBST0Zta1o2MmN5bnJDNWVPVEE0NFd2YkcvTXNjdkE2UFN0WDc1cm9G?=
 =?utf-8?B?MmVEd3k2RmRlSG51MW1yZFBpeWdYeWpNYkIvc3hOVndFaGxqNUIzZ25xMjZk?=
 =?utf-8?B?MDl0UUVMM20wNkt0RFFxdk1qMDhyZ09nQnorYjBMSjRZaTB3cnU3OVU4b09I?=
 =?utf-8?B?cmJDSXFJSytMK3plTG8yQnhPZC94NEpDVzhtOW1VRlZkL3ZQWjI0ak04eEcz?=
 =?utf-8?B?RWlESFpIbDFxZEwxNjRRL09vb0xGT3FBaEhQWGFyL0lhbUxZUzB3aVBlZVU3?=
 =?utf-8?B?WUtKT1BJdXpuU1ljK0krUVZ2cG16bHNsbUZKMFF4a3ZuU3pRQW1CVURLZXZl?=
 =?utf-8?B?UVcwdWgrTXYvM2lkczh2SnQyUDNSMVlvRC92TndSYVVjcDVuNVRSZS95cGFy?=
 =?utf-8?B?T2g2UTh6QXZYR3RKVkpubWwzR2FVOU9qWGlrM3NpdENVRzZnam1xZXY0eHJv?=
 =?utf-8?B?cXRlWHZGdStnZjVJT3lhYmJIV0kwQnNsWGNjMXl6VmVyVGtBVUN5ZDRvODMr?=
 =?utf-8?B?eDhDcVN3N2dQdyt6VzNVckNZRUtZV24xN253UE9oTFRUNVNvOCtLMGEyazda?=
 =?utf-8?Q?7qb38SwUK0ynkzkULOz+mEQhl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95412ba-b614-4776-ce27-08dcbf98a7d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 15:15:55.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCF1B6UjHNbCRNBP5/sM5zxrDe9dUss+48PtNUVJUyx+8CrcaUn711tdJDX6k2XQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

On 18/08/2024 18:09, Stephen Hemminger wrote:
> On Sun, 18 Aug 2024 14:43:51 +0300
> Gal Pressman <gal@nvidia.com> wrote:
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 4160731dcb6e..84c15402931c 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -163,8 +163,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>  	if (!new_md)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> -	       sizeof(struct ip_tunnel_info) + md_size);
>> +	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> +		      sizeof(struct ip_tunnel_info) + md_size,
>> +		      /* metadata_dst_alloc() reserves room (md_size bytes) for
>> +		       * options right after the ip_tunnel_info struct.
>> +		       */);
> 
> This is an awkward /* midsentence */ place to put a comment.

I do not disagree, but it is quite common for unsafe_memcpy() callers.

