Return-Path: <netdev+bounces-182599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B6A8946D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11F81891B06
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7931A5BAC;
	Tue, 15 Apr 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkNxSbCH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F4634;
	Tue, 15 Apr 2025 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700978; cv=fail; b=kv8JrUug4ethG5n3KQnLWaWCpaONKAjysfs1XZMI1eoPU8tuXFbZPXwDdJxJY1hK1zgs4qd/OfJEHH2L/yoKfrQ1R0r49D6csc5XJJd4PmHfPJUgJYNLjhVLu9DwV8sBd2cqPXKJOopvQs7EWZYpKML0mRuma1ousNfYJQrYyik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700978; c=relaxed/simple;
	bh=BypFW6SQYhYGpEdyk6waI/DRb7ZXoaTZt6jL6OM9V9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=adg7Zp/jVKQgxD3+yxBNc2DScaCKpgPmjiLgbRSfGq24q/Vog+63ZHI8otFlk6GIINgt9dLE+fmQx4d+iRFOjHu5+sH4h2j4aw0uhog6oCUSuQUZujjNNiT2DnVRYMhQkNJGKG2N1ZSUptBMJ0TG2RZatQeCUgVdb5QDA+9/8Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkNxSbCH; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6wQox5recW4R57OBm5ktI6DSDYBdORVzBL9fhdz4G8qXOLHcL1Y5CzH85QbM1ToG+eEtGeZnEL/7JoV4HA6zicOaZxtqc7ZFGaEn79B/GNt5HOTrBaJwOMYE3Z31y31874yUNSL3qHsWucrZs4/AqiPxmmdeRp9yoUdl43vrJClINqv1sFtF6m9/K070nNHczkPmQR6f29Sv8vnNZ9Qp6aaN6uNLbRfb2mgkS9gKZsdzkVE/jHTR6dgbsvCJiGzjr0+YIH4fvdDEV6uiBeloq6U8+9JEYJLLwP4t7klkg81uL1KPRo99Dk0dJCEkUdkV2nX95OfvZoxQToZ+O9Crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt0bpPdJ6JUUHW6pCyjP2d3MnAulQn8uRanSkCYYijg=;
 b=m3S7VuOBLbcMZOJjESc87rzC20R5kBTfp/iG7T/yTQlX2KSSPuOz3ZSsERDL7nKpKrk3XFgbKZvjpbE6kWMp8GCVnxIqjbzZLjcJUmMJu+BEIw1yWoUVs5ecNkBxuti0JhVBFVPNmKg8AY8KX+WphBOq4mYzQpxX1eN8KkBYcxkj7p6fuTOHG17X8dpv76Os02NPfZdBGnjQoIqBz2UOfP2I0vp7Z2tF5+noQkPFQxeuikapCnYeVOGHabTHoQfzO8GiOzG/+vybvFISuwrFtiEFmEkTxjHMFZJ7H21ohnFAKx8RwESTt2bqeG+DNQBq4t00mnuhFkmG7p8kKgRuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt0bpPdJ6JUUHW6pCyjP2d3MnAulQn8uRanSkCYYijg=;
 b=SkNxSbCHVML9YrK1qHp7Hgf3qedLle5qJ6yoRiiYYHiEyuU7YtrcY3ZgkdCzHd1PULI/NfXEd821pfL0u1/LDn//U+4Z5/lkUiH3AE9PkXwbM+xLo9ARDOtWnpeppBXi4AeAiJxqwWcQu1JSrBtgh6c7CIonBOSfNGI1uC8o0B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 07:09:34 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 07:09:33 +0000
Message-ID: <0f1ac76d-1b69-4517-8b13-0fc46e1ff948@amd.com>
Date: Tue, 15 Apr 2025 08:09:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/22] Type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <Z_18VpePAHGj6vM7@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z_18VpePAHGj6vM7@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3282b5-1668-4f18-b264-08dd7bec6d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVJ3OU1vRHpHaFZ4OFNBaEdqdDRvK1lCRGRSRVdvOUFySFkyekxNbEFtbDBn?=
 =?utf-8?B?c2ZmbE40RTh0dnc4ZU0wRlAwNnVlc1ZqQnljZHV0MXhOSTVkVWVia1lQYzFJ?=
 =?utf-8?B?VzBNVG5RWjhUVmV1dUhueS9VaUVYZW0zTWhETEN3N05oQTY0V3d4eklWVDJa?=
 =?utf-8?B?azluQWhOTDJvMU0xQkpTWCtWbW4zdVJ2Si9PcDNGZ3dvMDVCdU42V3V2UVlN?=
 =?utf-8?B?K3RaTXZ3SWIxVSsyRWZWd0pKUDJiZzNUWjdJc2ZXR3ZrVWhlS0lvY0prV0tE?=
 =?utf-8?B?U3hjeFVLdzRZMkhmTEJJUVBOenNWeGhzdnZWT0FPTk5NekZVbklsaUhKVy9v?=
 =?utf-8?B?VHVWdVVQemdWVkpkSXJHaW1PcU1vTG8vVFcrY3AyNXlVancxbGxvSzV5K3NT?=
 =?utf-8?B?MC9vS3hvZFArL2NzOHh3TVpTTUcwbHFEMlcrcU1IdXdTNkRDeFRTN2dwQyty?=
 =?utf-8?B?dUJpWDdYcysxdFZ6c3NyYVV4SHIzL3MyUlM4dEZhQXgzVS8rMDNTZEg5MWtC?=
 =?utf-8?B?K3h6bDdwOTZOZmd3ZVpmc2RjY0NubFBxNlVHZmdQOUtsVTJZTjYwSFRwOGI2?=
 =?utf-8?B?VUpXVTVwQUZpWEJNWVd6R0NYcEgyMkVxYWJYT0dkbmxJem00TWhlVDNCZDdZ?=
 =?utf-8?B?OTU1VFl6VkExa0xHQTF6RnNZNEtHVXYrKzJwL2hjdDlya1puWnNCZkIrRzFE?=
 =?utf-8?B?MkNLdjF0QlhOS2p0VUUyL2VvWmtjU1gyQmQ5YjNvanlwVGVhZmhtNmFtZUM1?=
 =?utf-8?B?ck1COWptRTRialVFL0xRNjZ0L1FXWjE0UUpic3FzSUwrY1dBNVg2dVlvQ0hj?=
 =?utf-8?B?czRvUkk3UmtOOU94Yk8vMWx4UmtKRW1kTTgyVTVKS0pKN29JbXJzQkMwOW1n?=
 =?utf-8?B?VmpTVGIyM0VLVXp3SVZwc0Y2REtrM2pSOXRvQjU2dGZYN2NyNitwM3BVcGVY?=
 =?utf-8?B?ckNvSWNKSlg5cHYxSm9QbjFIcEh5SmNJVzBta0k3dEx4emJ5NnhrMGlBRDBF?=
 =?utf-8?B?TU5HdDZzai9KeVVINnlBbmQzQWo1SVQ2WkhVN1lFUG5UTzhwUjVJSHRKZEYw?=
 =?utf-8?B?TnRvUUxuQm85TStEb2RkZ0VwdEdRcjNVTjgzWHA2WGJWZnlqSmNnOG9mSjMy?=
 =?utf-8?B?cWZrYVd4dUVIN2RBc2RuK2xuQnZuMVRZWk5tbTU2c2hyMTRKVlNxcWk1VEFG?=
 =?utf-8?B?a2oyTzdlMC9TbHNOZDlFQXVzNWxUUzUxRVBJMHkvZVRkSS9ZaFgrbHRBaDQr?=
 =?utf-8?B?SHlnNy9UYk1WZ0J3a3hBc0lSaExNYm5JSkU3N0hMbmVhdlgzWDNKUUFXOFBD?=
 =?utf-8?B?bGlaM3h2ZFNzV3ZCVTc4S1RBT3ZLTUtDam5oNG9VUUVqeEdxRDAvQTlMVTEz?=
 =?utf-8?B?Qll2bU5EYXdFQzNVcFJUTzlIVGYxMVE3VW5XRk9tNVdRbXZpaktsNTd1RzIw?=
 =?utf-8?B?NE0rOXRDcHBVK3hwTWRWbVJmREorZFM2OWNRVHlGMUFYQ2Ywd2l4V2ovQWVy?=
 =?utf-8?B?K0xxWktUOUxKTkIzamtESy9pWTBjRUI2U0RwdHRqalpKaHhLcDhBZVA1cjRT?=
 =?utf-8?B?T3RIOUdEaC90ZDZsTDJSLzI5Tlc5VnppL1NzNzkwczdKemhtOWoxWFIxa2RT?=
 =?utf-8?B?aUNGc0IySGpXSDVWUTJ3UXh5NFNBRGU3eS9nVzFiSVYrdG03Z05hYmxrY2Mw?=
 =?utf-8?B?YjRSa0ZKSVZ6Vm9hak1Oc3J1WlhFbW5IYmJTbG5yUWdJbTYxV1hZTHY4Y0xw?=
 =?utf-8?B?UlYrZjA5Uyt1N21IRmJyNExiS2pLdUc0Z0hXTWV5Uk1DSkpJclFyMGVIS0Zn?=
 =?utf-8?B?eXRqbkFOZ0VQYlhGQmhQSmdPWkZoYnFPbSt2OVlIdEwvZWdNZ0d0a1BwT3dK?=
 =?utf-8?B?OWhJQzVaVlpDZ1hOa2l2QmRNSjJkbXFRZTVFbzNXNVBlQ256WVlGT0MyY3l2?=
 =?utf-8?Q?QwM87b6MkFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VThZYitMeDhveXA2cmJ2bTRlTkR0TEpVSjJJVi9QTm9pa3g1VjJNaDFQRmNI?=
 =?utf-8?B?d1hveUYrY0RzOWlnc3VnSXgwL0dTTXd3Tm5kanZqRjZXZHlOVitHdnhwVjNY?=
 =?utf-8?B?TitmZmtUMWdMRVc5WGxZZUt4VVdveWRUcUlIV3NuRVJ2TkhVbXJhaHROT1lo?=
 =?utf-8?B?STUvQ2lkQ05rZEZpOXBQMU9aa1o0M1R3MGpFOGFyY0UyQmxwTFpUMzZhRUpI?=
 =?utf-8?B?N1JRUDFINW1PS2tTdHVzajB3TFhHeUlZQk1lL3hIWGNUYng1SlBGSUFPSHZD?=
 =?utf-8?B?eGFJNEZmbUdySDFKRDNyZmJ5T1UyamlCYVJrWmlzTm9WYjVCVGJsWHpsbVY4?=
 =?utf-8?B?Q1kyODVTR1gzcXc5VklpUm0vaGk3WGc1aXBsMzZiSWJyc1h4RjkrMFVMZzY4?=
 =?utf-8?B?UDhtN2JMU1c3V2lOQzdWZEsxVzFxSDhhSEd3bFdRQWRyYkhVOCtTU0xkeXFO?=
 =?utf-8?B?aWZLQjJtdUNGZ21Mc1ZqMjJVYmdUbEs3ZEdPVkN1S1FnNVJRdG1UZTdxWk01?=
 =?utf-8?B?MHJsc1JiRENMMGxLWjR0WXlneVFrUDh0SGFvQ1daSE5GZ1orOHFqNVBST2pY?=
 =?utf-8?B?S3FMdE11TTV1ZmNocFVMRVJOMGNJZGRVNjlMRlVqYzdYbzVwazd4VHBpYitH?=
 =?utf-8?B?RlpDSHFNR3BtVG9DSnN2NVJjbmhiekNhUjJhNUNpeTE2UEdsd1hYdUdlRnRW?=
 =?utf-8?B?TnpaYkpuY3R0MSt1QUVaQ0VtVW1tL000MnVubHFuODdDWWhoMEpuSG1rMUFx?=
 =?utf-8?B?bHRSS0ZVWWg3bzkyaENNSHZDVXMzRDQyY1NPVEt2eXBwNnRNUk5CQ2p6ZXdl?=
 =?utf-8?B?SnFxTkFyTWVBSlpvUVFwSGJUeTZoTjE1OEVsVTlYd1VWSStEME1TM1UxQ0dv?=
 =?utf-8?B?bTRZSlhwQlN1TldIVXJKZTVEc2NnelVocGpIM3h0djAwRFhTNDV0dkxtTDZo?=
 =?utf-8?B?K21xNEV1NHdOVTRpVW4vRG5pUGt0NWpTazBxYURTYkJBQWswVlFQUng1M2w4?=
 =?utf-8?B?WUNYR1M5SkZMSjhZRDM4R3o2bUg5S2JYMWw3Y3BoUDRyMEd4RDRJcXhWcUZF?=
 =?utf-8?B?M3krZDFGWHZWdE1RbndZZ0Q3eFhDRmR2c0lVQXlkQzBqSlFNVkVHYkFndm5K?=
 =?utf-8?B?RmlrckQzWHdydmU3Y2hTZnd3eUNCbVdzbnZ2Sm03RVcvREswYU1WelRrSHE3?=
 =?utf-8?B?RnZPT3U5WW1hMnZKQ1M4cUJ0MmpacGpINXE4Wkt3Z1VMTFU2Q2VaN2h5Yi93?=
 =?utf-8?B?Z2Q0My9LUUtYZDcybThtU2ErclZoRExHUFJ1K2pkRkxGejB3a2xBenZCZHlw?=
 =?utf-8?B?MHMxTFRPekJ4WXJuNUNlcVo1S2NxMTA1MGRxQ0hBZ2ZCYWpHU3JsejVBSEt1?=
 =?utf-8?B?UjVpQUsxMDFaZWFLL3h1R0g0ais5Mk8rSFRFOWlnTjNtTkdmSWx0cVZWak1Y?=
 =?utf-8?B?M1NYMzhlRE1BTVZubEJONDN2WENaMHI3MVR3V3VaMmxXTlptUHJ1ekIvMWt6?=
 =?utf-8?B?NEdmMTZKT1hJUjBKN1Z5dXYrd3hIaFgzUkIzelNHQXNZRHExWkQ1OG5oVktz?=
 =?utf-8?B?QlRvS3h2T01oUFU0KytpS3A3b0QydCt2aWptbTE4SkRVSVhzRUYwWVB0ZFBR?=
 =?utf-8?B?cExyYktBVm1kR1EzS05pdXd0WElGTnYvMkdlNnE4dzBLMkRqNXpsTnZNNXpM?=
 =?utf-8?B?bitlZlV6Zmp5Y3h5dW9UWkxiV1lOMWN6SmlKSVZzeUMza2VVK1BUeEtabWI4?=
 =?utf-8?B?N29ZdGIyRElsaHRUR1E2cE9COExHVlFlWVhabFlXenVNYU5GZ1ZRak1sK1VK?=
 =?utf-8?B?djl2MTk3RHdNdmhYN1kyRk1ML0V2blIvMHhaZGVmVFBiT01QWmQvMkl5VUIv?=
 =?utf-8?B?UmZkaS9hU0Y4VW12ekdyQitVQm5obUkyVkxIL1hzeFVCdTdTRlBsZEltekVi?=
 =?utf-8?B?UW04d01iQ3NCUmE3NVczSDJlRUFsaEJNV2pIODRnVjZoWDVVSlBWaU9lSCtT?=
 =?utf-8?B?ekZoZVFFLzhZMlJYaU9BS0ZNcnhGbXVaSXJpVlM0MUJzVnQrOVNaNHg2c3dm?=
 =?utf-8?B?WkFuMHR2MkoyY0R2bTBPbXFTb05LTWVjb0c5MXhmbkwvRzF0dEJuNDV3M2M0?=
 =?utf-8?Q?Hu5PW/sa/FwpTYmotkmWBb/ZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3282b5-1668-4f18-b264-08dd7bec6d72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:09:33.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltIuxYROhIXjafhBf82DfHphHDTpCDL6RTPiYAefyTYtkAYcc4jfcY5tF7te7aZgu7m8Hq2XKaxK2x1Qp73TZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

Hi Allison,


I forgot to fix the problem you reported in v12.


I rebuild everything patch by patch in each new version ... but your 
comments on the cover letter, which I agree it is the right place to 
complain, correlates with none, and I just missed it.


Apologies. I'll fix it in v14 ...


On 4/14/25 22:21, Alison Schofield wrote:
> On Mon, Apr 14, 2025 at 04:13:14PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>
> Not able to make the cxl test module.
>
> test/mem.c: In function ‘cxl_mock_mem_probe’:
> linux/include/linux/stddef.h:8:14: warning: passing argument 3 of ‘cxl_memdev_state_create’ makes integer from pointer without a cast [-Wint-conversion]
>      8 | #define NULL ((void *)0)
>        |              ^~~~~~~~~~~
>        |              |
>        |              void *
> test/mem.c:1720:58: note: in expansion of macro ‘NULL’
>   1720 |         mds = cxl_memdev_state_create(dev, pdev->id + 1, NULL);
>        |                                                          ^~~~
> In file included from test/mem.c:14:
> linux/drivers/cxl/cxlmem.h:742:54: note: expected ‘u16’ {aka ‘short unsigned int’} but argument is of type ‘void *’
>    742 |                                                  u16 dvsec);
>        |                                                  ~~~~^~~~~
> test/mem.c:1721:15: error: too few arguments to function ‘cxl_memdev_state_create’
>   1721 |         mds = cxl_memdev_state_create(dev);
>        |               ^~~~~~~~~~~~~~~~~~~~~~~
> linux/drivers/cxl/cxlmem.h:741:26: note: declared here
>    741 | struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>        |                          ^~~~~~~~~~~~~~~~~~~~~~~
>
>
> snip

