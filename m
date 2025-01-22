Return-Path: <netdev+bounces-160224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7030A18E43
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF8F3AA4F5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925C21019A;
	Wed, 22 Jan 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DruaFAB/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FC20FAAB;
	Wed, 22 Jan 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538005; cv=fail; b=ofw3Zq6O12uSVGWVA20dl2EKN+Q5YogAoaTDq6Dy/Go9PDuDSlPq3LyFaeDf21yQyVoKv6GvHTY6EwgYWuXlAq9sSuH2p07hg1PW+DKTuBl8RvEMo7mUITFGnBvKXOvQiV+QwWlOifNCohqcm8sb/shOE0IB+pG+T5fa2w7Q4WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538005; c=relaxed/simple;
	bh=teJNlAzNACPV76/A8VNW/sE7b+O6FIBdzyA+DG1oG5w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qdYwyJCKIPkIHftnd06qs16QyYcRoRtSJhqxH921/JZFUt4HrTcsi99jM3A35zeiIAW30ysYhbiI2MFRBiFhN9w3IOdynExVexbHDBLUOj8O5TJn4GXyeCPknkvXJvwC39ywzQskg8mzY3C654EOOHdxy5nOzzv5F///YmTeBgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DruaFAB/; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyXK688kISLEV4Wvk3ygXEMu2DNY3HxraYJjIDOfbjL0m1tq/jNNumXTg56/G5MDOT0++ybGMKBU1c/blSvBjd1QkMK/cuxV74oBNoez+NivJ3yZXY1Wb1TQeNUp7td4OzO91YU0DLG2g8sIjO1E25n3J97iB1AVz7TL6ExdNlhCcJyYfFwZUYwx6N0mauHFk9oSLZJdra6vzxnEUnYNQvu5g3jqFHQudmxoQ+NnjddhieC3+ZKYj7XUsjSnVp2hxlPGE/BnKtyy+Jm6o5uECbEYNxVmuSeyTL0HaTFUvahTsbW8OeYHnTwQ6WCrfPwI1pt4eo6tyqtbzoa9gAz18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0Iy26XlmwXAiWy+3Xm8yds3598vdWBKSThy7u3eM/4=;
 b=ZpXY4w2qrC4MpgagJ15hXQVsv5logxpL5hp1WUqp+6SugUem2KeGFX6LxWkyEPlE8K2EO5iNCWMYrFOnDOGTRiTZ8sgjwtCRKAXtebaXL5HHETOREynXfHkb+7HP9nQhk+CwxwVBatGygwLv6jluXix//1gyJv1fzzasMAc3XkzLKV007TlkrZVY42ZlpqWasBWTKIs55j2jzQ0KF3zHT5uN4uUmTc1HtW8qZs8y5tqRK5/h2qaHMhk168s5SGhalb3nHhWHI9pQ6tVfKgeH9otnY2acRGYSaJy3zP0eAmMXxQX9KgJAQOecHD1Wl7GjzAdt239g035UFvAnyHdmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0Iy26XlmwXAiWy+3Xm8yds3598vdWBKSThy7u3eM/4=;
 b=DruaFAB/Ovml1JpMZlu4sciCuP1LmFcCTl1WJCAdX+futM6USWBuFvFu3+gtQkChHXBiFjHvAVyYf1DRJ9kS3V3Xdv1f6GpkOb6dbhJeQW4a8+KKjfxa13Joo3NlMPO4qkzzNCo1J20Lb3/SXpXpT1iNT4DtJU5thMAZf9U5KOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:26:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 09:26:39 +0000
Message-ID: <9c1954ed-8ae8-a029-6a37-2065c6addbc2@amd.com>
Date: Wed, 22 Jan 2025 09:26:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
 <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
 <d71fd820-5dd8-0010-226e-f8f6b224de1d@amd.com>
 <67903147bc715_20fa2942e@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67903147bc715_20fa2942e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: fe80b1d4-f27f-4aa0-8378-08dd3ac6e00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXFKcVBZZVl4d3VudE9RSTRVaThFVlRUMFBUR0xXYk5UTGx2V3d6ZUE3ZHAx?=
 =?utf-8?B?b3JpUEJPN0x1MGphT2pZNUxnZnc1UkVXUTVoUHAxRjdWc3p6ZW1pb3kvTmdn?=
 =?utf-8?B?Qm1vQnRWNG1ZU0ptRGpmeUE1YW54d1g4T0JVdWw5Wmpvek1lTHNObDFiYTdB?=
 =?utf-8?B?b0hYTWIvaDVqMkY0YmNhdUs4ZnF0YXhSSnRhb25PYWxJZVpkWHc5ZElldCt0?=
 =?utf-8?B?YnhLVkp5amcwOXFTQTlNMyt3UEdlbmUxbGtWRGE2VTRNK0NyZ3Y4L09QdEx6?=
 =?utf-8?B?UkdBM1pCRWpMaVBFdU0wSFcydG1VL3FBdVRrYU9TTkhyZHhQSXZIS3BYZm9R?=
 =?utf-8?B?cDZsVis4MjJrTEJEamErdjBqbzVsbXRPOHhrQWl4Tk1WbXhSZWtCcVEyM1Zw?=
 =?utf-8?B?bHdQRXdsa0V2SEtrSlNwblZ1VHFZSGJmaTZSMXpBTjNQMFZaQVdsSlVzNFJm?=
 =?utf-8?B?VlV4VTFzY0IrYk1GVmQ4ZmljRE9ITG9xbkxzUXRuNlU3WTJJT3lGYis5SVVn?=
 =?utf-8?B?NTU4dkczY04yVmJVYXVYeHRoQm5GTHN1VmFicndFZS9sc1NOY3JUR0MyYkV2?=
 =?utf-8?B?bWEvYktpa29YQ2RkdTZteGVXTFdJWFlFT0ZWUmhoRml4VnRUdzdZNWpHSVNU?=
 =?utf-8?B?WlZpODhBRnNoVlZWOXBIV2djeUVGS0pBODl4ZmozbkFXdnZUWDY4UGxtUmJB?=
 =?utf-8?B?ekFTeXQ2QjZPT21JUko1TW0reXM5b2NLL1pFcFJibEM2RkhiVkM5bE10eEMv?=
 =?utf-8?B?b0JMejRWcnZ0alMxVWZEWGx6UUkxNDdUQ0lGckVBWWJhRnhHVWQrdURibnhJ?=
 =?utf-8?B?cnBXMTRJbHR1ajJVUGFxTUxUKzBIWjJNMVlXSGJPaWFJMzJlNEhGaFIvdm83?=
 =?utf-8?B?ODZGdHF0N25hT202dzUvTXJuVDMrcGhjTXovcnlZL2dMQmVnMXczWmJGNzhJ?=
 =?utf-8?B?YU1hZUw2M1ZVdExVNE5rQ1NkSC9YU2VvcC9hK3VmVnFuZVBIR0d5N3VNSUR1?=
 =?utf-8?B?aDEyL3JuSE5iVlVrNjV1MllES29aZW50cUVQQjUyT0RJSHAxMGZkSlJXem8x?=
 =?utf-8?B?L0t0dmpsenV4U1B2SC9Yc05HN2xRQkV5Q3MybTA1Yjk3SUpDUmExcUpYN2Nw?=
 =?utf-8?B?eEw0YXlyaWU4R1NaclNFb1VFUGdwbitGK3o5NXBjbXhITmxWNnkzY2tOMmkv?=
 =?utf-8?B?T3ZhRlByVnRzYkNJTzJsN2NXZzhoaGp1VThUNUdpZURZdUFOR2UwQ2xNM2tC?=
 =?utf-8?B?K08vSURDdEJaSUJod0lNaXF2L0lwL3UxN0F0L3ZPdmtLRXBFMVdzMVltQUZj?=
 =?utf-8?B?NHZhL1l4cDdNSHRmZzhkQWgrVEJFU291dW9nYkJuSXlOK2llUjFoL3FqdkRN?=
 =?utf-8?B?WnIydk5LaDAzdGtBT2JFRXBySjNWNklmU0llOVFGMm45NWE3TTQzSHhpMVNN?=
 =?utf-8?B?NnpoUkF6MVFqZkpwbnk3OW1hd2gyWmVWTHVjRWNhNDJ5K25yNUpMTVBlSzlG?=
 =?utf-8?B?TUNCWmNRQkRpTjFkdDVJT0VLYXV1U0EyUmFjUEhFbzdIUTVzNXhrZUgwV2sy?=
 =?utf-8?B?bTc3Z1lsUDd4OWd5SWxDTXU5NEpIdWltZnIvSm9vNlJtYTdkdlo1dmZPV0wr?=
 =?utf-8?B?NDE3bVZweUNsMzQ3NldnbXJvVzhHM3dXVkc3bDVRcTB4VStvQlRoY1B2L1B6?=
 =?utf-8?B?WFc4Zi9ucGhvdDVGelFIWnR1NnlnS29DVWtsc1NGaUZDTnZvVk5SYUc1TElH?=
 =?utf-8?B?YTdiS0hIODJ0SmdrV2lZRHl6Q3l3VHVJMHJpaEJDSTdFOXM1UE82WjRTdnJx?=
 =?utf-8?B?d09VbVV1OWVCOFUxcERseWhrazFldjlsL3Q0cHc0R0UrUXZ2V1g2STVYZEN4?=
 =?utf-8?B?MEVtWGVybStCY3o3Y0wza1BPNndndDhRYjZZQ29Ta1BMY01uNUx5QTRFOHhC?=
 =?utf-8?Q?Xqa5zyAh42M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0Vjc0dEQkVWcUoxWGpUeTZLanp5KzBJelVDb29xSHdRQzVaQlR0N0ZuSDBz?=
 =?utf-8?B?dE1qcEpBek1BNUtVTHNJRStjdTdNR3VTeDNGQlFqaGwxM2x2MEVnbWQ3d0U5?=
 =?utf-8?B?d2JRbmlWcnNaOGpNNUV2VEdRZHZ6aWpUVW5IL09yb1dMcUZsSVY0TFh5dUpF?=
 =?utf-8?B?REFVQjVkYlo0aktRa3ZLb1o1TzZ6UXFzSjh1VmlxUnQrZmRtaFZkc3NQeGto?=
 =?utf-8?B?RlRQMzJ0dUlOd3ZOalcvMG1abm9taDNBNDlSM3NCK3VINnVZSzVMQ3p2MWFF?=
 =?utf-8?B?bjM1NUJ3TzdmQlhLaWl2a0hmSy92c2FKOFh0aFVjOVhrWVpwdHhJL1ljK0xo?=
 =?utf-8?B?Yk9DcVJEN0xuVHRmVVcvd2h0djhxdzRjQS8xMTJZL2lxcjFmRGZGTUhFdDRy?=
 =?utf-8?B?eER3RXVLa3hsM2liWVdIaG9OVEJFRG1SWXN1dC9hVnBGVExPeDNEZjBCVnBl?=
 =?utf-8?B?dDk3Ukt1WmJYRExRWEFOT201Q3Z4SXFOUWN5WC9uOFRxODhmeGVWaThPVnJB?=
 =?utf-8?B?ZE1zTlFhMVdJcFNnc3E5d3VObVR0aDJvUG9NWEdXMXZmUGk0c3BMb25ieGNJ?=
 =?utf-8?B?b2Urb0hmYVAvVnJXZlFxQzlwMlRubFVDWWVZemZwUUlpYm1ydkpCVC9xU1pu?=
 =?utf-8?B?bXg2d3IwQitOWmlOSmhXSUlra202NUYxNWJGRTRUcnBCVnJsUDBNeUZ6NzlB?=
 =?utf-8?B?WXIydjlhdy8ycUVnOWJzRDBTWUdtUFFmbERrbFBpdTVOV1M0eUFCNDFRaTM1?=
 =?utf-8?B?NG5rdDFPTWZsMmdiT2tzOHV4M3NlWmM3K2RwSjczQzduVWlyTXZ0K0NkNzZN?=
 =?utf-8?B?VmwxdFlFZjRRZE5KMHlTNXBHVkxCWmZ3L0Y4eno1MmdIeEtNTU8wZ2VobmUw?=
 =?utf-8?B?cmhKR2krUllPY2NRUUFnK0pKakJGVnJLQjRTSkx0VEF1K1dsWFlPTDJuWm9J?=
 =?utf-8?B?MXFJeXlPeVVXRmo0dGdEZzFaWVh2MXZ4NGxmbUVGdFlMaEg5OCtvTDV3Njho?=
 =?utf-8?B?N1dLUWhFRUxNaVRmL3pPd1grN0hHdUJveHpFZ3habE9yQnhGRUN4MFpmVndo?=
 =?utf-8?B?bVcwNTc2RVdKZjdmKzVKTGdWVEVUS1BtOFFIUUlIa0l1NTFYemV1eDkrMlhi?=
 =?utf-8?B?bVJtd3MxL3puYjVOU3Y0QWJmR3F4UjVPR2V3MzBUZ3BoN3NISGRQS3Y3cnV1?=
 =?utf-8?B?R0tCVXZ6c0Y3c2hkUE5OSjFpWU9zNjdxc3M3REdybmZGL1dXN0FzSzFPQ3BR?=
 =?utf-8?B?ZG1LaFdRS3FFMzNZS3VjNkhaY0Nja1UvWFBpUnM0OWo3ajhIaVc3ZXNRMEQy?=
 =?utf-8?B?Sm9NdXlwdkN6SE1TWldVcHFCckM5M1I3TFlmS2plWksrRmZsVDd1azVBOWxB?=
 =?utf-8?B?dmIxb2ZyUVJqcUU4dGZPRnJEaEdUTURKMDhiNWxtd3dhR0lWM2xJcHk4YVFZ?=
 =?utf-8?B?NUNtUW4vRFNzbzJnay9Sb3BBaFZUdkFNczNKMDRCUkN4aDNqa2grQmxMcVdh?=
 =?utf-8?B?WThXTHZxWkpBLytmYXFNVVV0RFE4WWFNMHdLNk5IdDNISWEvOUJJSEh2cFlr?=
 =?utf-8?B?TElCdS9icStKbW1wQjNzVk9LY2ZDWWVmeUtwU0ZlUDFjU2Fad3Q3bXhEclZ4?=
 =?utf-8?B?K3p1R21zZVFPZVlidi96MHpWSWxRcHBtaWJ4bkpRejZSOXVKblhhdWU4ZjJQ?=
 =?utf-8?B?ZVJuc2hRK3dYWGdyRWNVZ3M1WG96dEVPQm0wdmUxY1c4SU9uTEhZT0hHWXBL?=
 =?utf-8?B?eHhkK1doYmFIUnpzdEZaeGJkUEZkb2FxNWJsT04wQ2toYnhaWk1nTFo4SDZS?=
 =?utf-8?B?dGNPTXh2NkFJZ0Vrd2NNUi9rUEJ6S2dtcEh3NEExbEdJc0dJYWtiS3kwTGU1?=
 =?utf-8?B?SWhSQWlxZFA5eWxOSDA4eXVFbVhlZ1QzdEZRbWM3SGd6aEYrVllBS2xid3Zq?=
 =?utf-8?B?VExSd25QQWVuMExMT005UlRKaytFR2tpZmRkYStYa2FmOHJ1VUtLRHUyVFJO?=
 =?utf-8?B?aXF6amV6RU9KRTJmenRvZW4yNGp6eXVXRSttb0liM05GVE1RZmJ5cXk0NzRT?=
 =?utf-8?B?L2tyVVdnTGZIcG01UGo4elFpRkc4b3hwbC9iNWVBK1VTNlpqNGdJUkdydnVp?=
 =?utf-8?Q?Gv/EDVZX4Yps6FayACQPljeKI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe80b1d4-f27f-4aa0-8378-08dd3ac6e00c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:26:39.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZVoeZJJdrTCwE1dJvvgxob9UCDpmgsVhm9x4jeuUIVZ0e24sp9zIyRBh2dchb1UyHU8adQyu2BpomXhJleKRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521


On 1/21/25 23:44, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>>> So, I am not sure this code path has ever been tested as lockdep should
>>>> complain about the double acquisition.
>>>
>>> Oddly enough, it has been tested with two different drivers and with
>>> the kernel configuring lockdep.
>>>
>>> It is worth to investigate ...
>>>
>> Confirmed the double lock is not an issue. Maybe the code hidden in
>> those macros is checking if the current caller is the same one that the
>> current owner of the lock. I will check that or investigate further.
> Are you sure?


I'm sure it does not seem a problem ... with only 
CONFIG_LOCKDEP_SUPPORT=y what was what I saw in a quick search in the 
kernel config file.

But it triggers as expected if the right configuration does exist at 
kernel hacking->Lock debugging ->*


Moreover, my comment yesterday about checking current vs owner does not 
make sense since it is one of the reasons to check ...


Happy you spotted it. As I said, I think no special lock is needed for 
the following code, but I'll double check before v10.

Thanks!


> This splat:
>
>   ============================================
>   WARNING: possible recursive locking detected
>   6.13.0-rc2+ #68 Tainted: G           OE
>   --------------------------------------------
>   cat/1212 is trying to acquire lock:
>   ffffffffc0591cf0 (cxl_region_rwsem){++++}-{4:4}, at: decoders_committed_show+0x2a/0x90 [cxl_core]
>   
>   but task is already holding lock:
>   ffffffffc0591cf0 (cxl_region_rwsem){++++}-{4:4}, at: decoders_committed_show+0x1e/0x90 [cxl_core]
>   
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
>   
>          CPU0
>          ----
>     lock(cxl_region_rwsem);
>     lock(cxl_region_rwsem);
>   
>    *** DEADLOCK ***
>
>
> ...results from this change:
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 72950f631d49..9ebe9d46422b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -560,9 +560,11 @@ static ssize_t decoders_committed_show(struct device *dev,
>          struct cxl_port *port = to_cxl_port(dev);
>          int rc;
>   
> +       down_read(&cxl_region_rwsem);
>          down_read(&cxl_region_rwsem);
>          rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
>          up_read(&cxl_region_rwsem);
> +       up_read(&cxl_region_rwsem);
>   
>          return rc;
>   }
>
> ...and "cat /sys/bus/cxl/devices/port*/decoders_committed".

