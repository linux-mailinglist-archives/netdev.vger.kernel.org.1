Return-Path: <netdev+bounces-161481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E65A21C8A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591F218834E7
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D71B425C;
	Wed, 29 Jan 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUmBx7cy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C0198A1A
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151632; cv=fail; b=B5BuwEMyKQE5sZfgCq0bxG3FQ1fwrD8oApjoLi74EEECSywBATsRNBjYrlIXBNfwHInD8tUfjgkYHpPevGkKj9ywvl4u3nfwIJs0yyekNmGXWCc/Fj5pAXYwS/kR/rgra3z3jDVd1Nvw2kIdJEu35BVvkjOWufCL1tGJTyl8KPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151632; c=relaxed/simple;
	bh=08uOCks4Z+bBdi5WeVqIPGNo2ri8RRgnZ1d5+yaPVZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7bDFbR53mc3WKZHNw+amO0UWl24ImEX3ZjVd19aOVZY8HxYqe88JZvoCgh4hHCz5JS8ZT5irD4TZA032WnIt/h3midstwwBpa1+Ev7Ntik1ukOM2xk7drHpPoYaVk6Dg5jl+VoQGl8RwcptlZBRAq22xcRbYf/khbR0/B76LWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUmBx7cy; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTEC3hhe6RjzDFC0jONQU6pOgTyjbzmnvPgc3oFERRfoSve1SAMsg+pym/q7P8xlu2YIzILGqvEWmixR7pcUEtdk0gNisItLGjYV5jjFl0VhCcwBRbzSFSuhUjeloXZS/H/0D5jT/KvfQ/X7E96orR8RRypUt1Vqqzi7UbB5PVIi1NSm+qHvJ9XAH6jH4833Wm1dp0JV55Amv5KV33zArEvgiHadQwMiVIH6UDnsohptzVrfTBmqFQieMm4NLZvGcJ3F9VlDKpa5xhnaPkBe/KYC17zrtorNu7oiGnHks7FWvNq1OnyCP0khz1Ch9RZrumgHeBWPcoAAKzkuR8pODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08uOCks4Z+bBdi5WeVqIPGNo2ri8RRgnZ1d5+yaPVZc=;
 b=XsHBudgHMT6gnSu4U9LmuoXqWCplIOv0cG49/zvmcGfoabLtAXhAcXDgtv/WVKaOSOPm+TiouZLktnYtHKLHIfzMV6nCEV9aZ9daLnHS18MDAF16f6r2P4OOYwFFohU5RjUj/ClN97DaVM6EMzae67mcYES+5W6iSqgJMDtIvgLLYpSb+cIUnNe6WCCwBSZ8yYcnMJeUuC13owddLFlQzQeKdeegCqcY4/5AEf9itMG2jfA2AnPpXqcsgzGpFYFhsfBvraytZJdzF1f5ZmONyQUMwYW6gdKURmhvSPzq4MLK+vgUhZOQcRlZhHvjqKIw3ADYAGTAIh+BzaCWuM08/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08uOCks4Z+bBdi5WeVqIPGNo2ri8RRgnZ1d5+yaPVZc=;
 b=TUmBx7cyNWO593WQNYYsRJp4e8CcNdi9ULQmOv6KDO1yzSPY32F+50XbbvIzaFHAZcnPUGBX9Uh+GDHSWvt4CVCMWMyvGmvULNz9W7B7ZFUyK57bwCi3eHCFwM0o7pXZSWON+XxFcoEUXNbv58jOGiozGI4m3WzvP+uXJKHnnp8ViDnfGBw2L+fp0idX+JF29u/vUvVqB2OKYks2LuMqSjX5WNNx5oxDnvDdIJOiRN7kd15tRua7rgVXZ4tKBOUxDIkenA4vxyPLjQNsj715ZGiIputMQD+P1HOB+0HvKggUhXfHGaA/ugBa9qH/vlLYGpBhFJphhHGgtPsctxXmdg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 11:53:46 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:53:45 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbb+l5fdqqldfRAUu+2iXPDyW3KrMrEMQAgAEdyvCAAJVigIAA4I8AgAAEiGA=
Date: Wed, 29 Jan 2025 11:53:45 +0000
Message-ID:
 <DM6PR12MB451645B05269BB66BC829291D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128141339.40ba2ae2@kernel.org>
 <5efb4e9a-6520-4a36-a946-caa545e68f15@nvidia.com>
In-Reply-To: <5efb4e9a-6520-4a36-a946-caa545e68f15@nvidia.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH0PR12MB8100:EE_
x-ms-office365-filtering-correlation-id: f192e2e9-83ea-430a-f946-08dd405b95df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTcrSGE4dWlKQ1NBS2dndCtHTFgxRVU1SmM1UnVCNVJSK0pnaUgrYVdoUGJT?=
 =?utf-8?B?WDlITkRlK3VVcWMyK2hPRlJsMnVaSU5FZStXVU91RndJVi92Rmh1TEl5L2xu?=
 =?utf-8?B?RFRONDFSSVlWOFcxOUZqRHpPVHAyMUZIR1hKRGpxb3dwdUVUS0hmT1J5bmZC?=
 =?utf-8?B?ZnBhZ0RJaWVFRnBzdUNzMGdwN0RrcE96cmhxWjMxUkd5TjE2K1BUenMrNWk5?=
 =?utf-8?B?RVNxVVN1aW9HM3dQK1NSeTRIMnUxS2dEUGRPaVN0SktTOEdoY29pWTh1RVE2?=
 =?utf-8?B?bCtRWkZoYTUzYldXWWd1RTV5akFOdFRMUjdUbktEN25tNW1yemFFK1FZTEFS?=
 =?utf-8?B?Z2xOeVJ0SmtOY0ZMNWlvTXRKdjVjZUw0RVBRSk5jSjBaTExGbG84WXNjcWhP?=
 =?utf-8?B?WTAxUUt5KzB3SFl4VC90M2pKRklNa3p6SzI2bVozVHlXK1NaU2ZBZW52TlRr?=
 =?utf-8?B?dXFrUlk3T1lvQmpzZU1zSW9VOUN1Wlg0eCtIM2FrcU1ia2FwNXdDT2hEbHVB?=
 =?utf-8?B?RzlYMzNRN2ZnYnBCZVdYWERxWlpaaUpiK2w0YUtRU1pibkdCMzRhVmZ1SHll?=
 =?utf-8?B?NUhBMCt1YU1pRlU4V00wWjZkM3dzcHdhNEx1aDd6NEpIZmJoS0JxWktYcnRy?=
 =?utf-8?B?dWJpRnRzOUk5d0htYllUNVRMMlF3OSsxTTRHcy8vc0hEVmJER3VTTnRaVDB0?=
 =?utf-8?B?d2ZoTXA3LzB6STg4NHdBcHRjT3NicndsL3ZlUS9ra1g3aTZhNkxjQ3Aya1di?=
 =?utf-8?B?N1V6SlBxNVQycmo2OGdFUHFmemh3cHkybFhYK2xHTGQ3QVFRNDYvK2RBbVpo?=
 =?utf-8?B?Z21vTkhac2d0ZXRDUW8wZUNQNnZ0OW9rNThJaUFSc1ozQ1hWUzMxUklZbWll?=
 =?utf-8?B?eFY1R1NrNDhJYmtMRmhYVXArc3g2U2hTTXorQjg1ak94aDJhTUk1VDJzRWpH?=
 =?utf-8?B?VitXOGVSWmJ2Mjh3aDdObUZIOE9kZmUvSDdQUWV5Tjd2OHNwLzdVU1lCVS8z?=
 =?utf-8?B?TWszd0xTVS9JbVlnMllubWdZOU95eXFITkVqV1lJTVFMUm51QS9nZ24rNmtM?=
 =?utf-8?B?OGZpV1hGK1dNdnBmVThqeXJadTJvcllLUFc5bUFDRTFzQUNVRjRhV0hFQjVq?=
 =?utf-8?B?ZGpMclh5ZWQvRDhLemc0eldSL2RSTWNaWnRtVG1yQmZTUmVPV2JsTEsweFV1?=
 =?utf-8?B?QUtkeHhLWWFsbWQ3T3JlRmhwZ2tvUmEyRFdraDUyWlVhR0hwV3NmYm4wWS85?=
 =?utf-8?B?MnQ5bjhHdnpvalJjeFRjQVlZcFN6Q3pLVElhaGVreTlvUE1EOGJzZ1Bic3FH?=
 =?utf-8?B?Mk9FLzJwWVNkSEFJblROTnpjRjdTR1pid252TDBNdVdldTBOWVNoUzNDMUZR?=
 =?utf-8?B?OEtnZWwyOVhOSXJqemlZeEk1K2xrdDNmeEp1Qm81OWtDNWJaMTVPSGlzakFS?=
 =?utf-8?B?YU1PZ0Jybm5zeEU0R1Fudmg3SHh3MmUrQmZkbWtTRGpZNlNLd3Z4Z3g1S29M?=
 =?utf-8?B?cmNmaHdpNFNtSFJvTVN0T2lIOE9pTTNhMldyS2t2Z0ZIU0d4SlJSWG8zcVA3?=
 =?utf-8?B?WEFtWHFHU1g3Q2thUzhQczZMQnl3b1hnYm9DUVZ0Y2IrUGo3aHljS29mV3NC?=
 =?utf-8?B?aVlSdlYzMTJRUXJnRzVweFMvR0drQi9kTm52R2dDM0NTallzR3JLYno5ODRi?=
 =?utf-8?B?d3VYUkMyQWNaUTdmb0FKcWV1cU5udi9DbVJpVVJ6eVhKNzh5eUdQV2toVEs0?=
 =?utf-8?B?bVphZGpxcjFaVUpldTVaM3hXYnQxWVJCUGJocXN3L2hmVi9aTWJFUFM0azVP?=
 =?utf-8?B?MDhyVUFhc0lWdnBWR0RlWjhDb3pvb1B5UnZnRDYzZFRYa1dNV1Z5blRNeXF1?=
 =?utf-8?B?UUlJRzR1eXhxUE5ibEJWUGozd3ZJN3JEZGhncDdnSTVsM29UVUEwOXJyUTFW?=
 =?utf-8?Q?xpCCiwxBzHyCKFwbO/q4KZ6urJZXeqdr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEIxWnZNWE9NeDhqMVh0VitHUktUcUhJbUJEd24rTHUyZ1ZiWUZ2UjlQYWxH?=
 =?utf-8?B?c0pNblU0UnN1T2pyL05KOUpXQnRrN1p6WHFIRUhJdzM2S29OOHpiVDcxQ2Nx?=
 =?utf-8?B?R2NUcGppRUkxV0htNXFNWnFvelI5L1R0cDlVSExBdHBrc1pBelQ1TlByZU5M?=
 =?utf-8?B?elBWN2RxVStkK09wQkNMS1AxTVZuTWU4TjVQVmdDM0hISUk1MlRPVnVyd3M3?=
 =?utf-8?B?eWdkSm1nNUNXTkJHY0xRNkFBMXpRRnFvRVdMYUdUWVFrMWh2clY3elFnLzE1?=
 =?utf-8?B?a2xnMyttbFVlemhpNGxacFBrOUcxRE1FR3ZObXhCSUdHZ3VYeGdpK05kc00z?=
 =?utf-8?B?T2psa08vQW1FaGpFUGp6NFpRejIrQ204R05mcEYvZUN4d3E2R0Ryd3Y3V1dJ?=
 =?utf-8?B?RGZ3KzZ2SW0rQ01PMDdXaGFyZHBsVGQ5S3NPUXVnWko5ZVlobXJiV293c0Y1?=
 =?utf-8?B?elZ1akNDUE1XVURsL3JOM1J1VXUwUDJ0SnVQR2x6RkU4c0dKcnkzU0JnTC9j?=
 =?utf-8?B?V2tuWS9BNGJqNUxoWVdnQU0zZFAwYllsaElDRThnNXpxR29GbGZ6dDVkVURi?=
 =?utf-8?B?THdLZ0xvaWxQNm9adG5namZEUVYwOS9wUGN0amsyWnBjUDRFSXBEeHUzM2JB?=
 =?utf-8?B?WTZSTUNnQVh4SURUZzd0NmQrdFdXSWgvdGZhWExFUkxPVjNwNkwvbDhXQ1Z5?=
 =?utf-8?B?aCt2dFlCTy92M3Q2ME1SWmZaS1haTEdxZWhuam50d1hsQzBnYnBjM0p6VWV2?=
 =?utf-8?B?cWJGQ25ZWmcyMWRUYkcvR1ZLV1pwalBhSHlMajdsZWFyWXBxOE5uRkUydnk2?=
 =?utf-8?B?amlFYm5QWHJyRGpFSDZvTkpMdmo3WGZXUVVhcms2UHU3T1YzTkdKaHB4aUxN?=
 =?utf-8?B?NUZBMlJLY29CYUUzU0xjZVh5Ulc5eEsvRkx0RjNWN2IxQjdWWDlMRm1RQWFF?=
 =?utf-8?B?NU0xU3dpbmFmcHU1VUd4dUV3VHZMa1ZyMHRBR2ZoR0lvOEZNU1Q4L0ZQcHdi?=
 =?utf-8?B?VEhLci9ROHExcHpZUXdQT2NCRDFIWnFxcTJNRVJLUnRJQWMrcDIyV1FCNkpF?=
 =?utf-8?B?bDZnYXJsS3dNVUFCd2tBNnZiaDN6TmZjNGxkQlloa0V1ZEJSeWlyRENNdlVq?=
 =?utf-8?B?eCtTKzJ4R21jQ1NlV2ZsZjdreXJGVUpsNHpSM2E0eTVMM0ZRdDdSbHRLOGsy?=
 =?utf-8?B?bWkzSXl3S09MNzZSS2F3ZTV2M3BRc2puS003bmd2L1UwaitDbHdzV0lmMnMr?=
 =?utf-8?B?SS8wZE9FY3VwaWlYQU9ma0pWWWhUaFZON0JvUVIrblNVRG0xMWt6bWliTmpa?=
 =?utf-8?B?bFp5bWVLaW0rRTdpUitZZENaNzRid3NOSk9IQk9LWDg5K1JRVVlvTlNxNnUz?=
 =?utf-8?B?amlXRUJKRDBGSzdPQzdlSjY5dkUzV2ZQUG1YMEVTTCtSZi8ycnRualgwYkVL?=
 =?utf-8?B?aWtVTjFsUVErZER1cGZHT05kMXhiSi92L09ZMVFYd0JNWGlZRDc4QmRRL1ha?=
 =?utf-8?B?UHB4OFhKalBRZWNRNDFubnBYS0xPZGs3OHhCRDRuU0hON3AveEZDNDFuSlBx?=
 =?utf-8?B?TmxjM3Jyby9RQUQ4ZFhpV2ZWbmxvblFZdHFrYVR0Q3ZOeCtGY0QrTEhHRlpF?=
 =?utf-8?B?d2d4SUMrNnRHeHNKRFUyN0tZbEQxSU84K211djJQamhHMXBFZjlTeEo3dTEy?=
 =?utf-8?B?U2svZExGNTRmTWIyeVp5Q245cUNWanRxNDNSN0lEREc1d1hhejk0bmNCcW52?=
 =?utf-8?B?VC9RcU9oT3JUVU5tTVNEUTJXM0FpckFlWjJucEoyUTJITW96anB1NkdaVWZZ?=
 =?utf-8?B?OVJMK0l3ZEpIeGEyVzZQM2hXVGFFRFFFMkcyd0ZOSHRJYjFEM2l1ZmIwSlUr?=
 =?utf-8?B?SU01V1VSQW56Vzc5WlgrcEpES09IZkw4bUJvQmZCaVB3UlcvMWhrdmJvTjBu?=
 =?utf-8?B?c2RHOTN0NmExN2FjOWVTUVpiUDI4ZjhmcUNKZnV3UnYza2pYNlQ4MTlnRytS?=
 =?utf-8?B?TUhFMWxSbUxLU3NZemFWazFkQkcyV2lJWDZGeHhFdDFpVFp2V2pHZUJoVnVK?=
 =?utf-8?B?Sy84Z0JieVJtc0FHdWs1MThWVUhRbGt1N25QVXpNWUlrRDlMakI3V3A4M3pS?=
 =?utf-8?Q?9Cf1eOmgXQHDwBfVsC7Ulq4ff?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f192e2e9-83ea-430a-f946-08dd405b95df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 11:53:45.7144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ej/Gt19hfmIccLqaLffFyWY1nzfT5D5EOWfOJmKSLNFHlW/1QJM9Lk0BnSvo58kAd7nvfgadwuVY58Lqsh4r3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbEBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IDI5IEphbnVhcnkgMjAyNSAxMzozNw0KPiBUbzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz47IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBta3ViZWNla0BzdXNlLmN6OyBtYXR0QHRyYXZlcnNlLmNvbS5h
dTsNCj4gZGFuaWVsLnphaGthQGdtYWlsLmNvbTsgQW1pdCBDb2hlbiA8YW1jb2hlbkBudmlkaWEu
Y29tPjsgTkJVLW1seHN3DQo+IDxOQlUtbWx4c3dAZXhjaGFuZ2UubnZpZGlhLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBldGh0b29sLW5leHQgMDkvMTRdIHFzZnA6IEFkZCBKU09OIG91dHB1
dCBoYW5kbGluZyB0byAtLQ0KPiBtb2R1bGUtaW5mbyBpbiBTRkY4NjM2IG1vZHVsZXMNCj4gDQo+
IE9uIDI5LzAxLzIwMjUgMDoxMywgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+ID4gT24gVHVlLCAy
OCBKYW4gMjAyNSAxMzoyMzo0MiArMDAwMCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4+PiBP
biBTdW4sIDI2IEphbiAyMDI1IDEzOjU2OjMwICswMjAwIERhbmllbGxlIFJhdHNvbiB3cm90ZToN
Cj4gPj4+PiArCQlvcGVuX2pzb25fb2JqZWN0KCJleHRlbmRlZF9pZGVudGlmaWVyIik7DQo+ID4+
Pj4gKwkJcHJpbnRfaW50KFBSSU5UX0pTT04sICJ2YWx1ZSIsICIweCUwMngiLA0KPiA+Pj4+ICsJ
CQkgIG1hcC0+cGFnZV8wMGhbU0ZGODYzNl9FWFRfSURfT0ZGU0VUXSk7DQo+ID4+Pg0KPiA+Pj4g
SG0sIHdoeSBoZXggaGVyZT8NCj4gPj4+IFByaW9yaXR5IGZvciBKU09OIG91dHB1dCBpcyB0byBt
YWtlIGl0IGVhc3kgdG8gaGFuZGxlIGluIGNvZGUsDQo+ID4+PiByYXRoZXIgdGhhbiBlYXN5IHRv
IHJlYWQuIEhleCBzdHJpbmdzIG5lZWQgZXh0cmEgbWFudWFsIGRlY29kaW5nLCBubz8NCj4gPj4N
Cj4gPj4gSSBrZXB0IHRoZSBzYW1lIGNvbnZlbnRpb24gYXMgaW4gdGhlIHJlZ3VsYXIgb3V0cHV0
Lg0KPiA+PiBBbmQgYXMgYWdyZWVkIGluIERhbmllbCdzIGRlc2lnbiB0aG9zZSBoZXggZmllbGRz
IHJlbWFpbiBoZXggZmllbGRzDQo+ID4+IGFuZCBhcmUgZm9sbG93ZWQgYnkgYSBkZXNjcmlwdGlv
biBmaWVsZC4NCj4gPj4NCj4gPj4gRG8geW91IHRoaW5rIG90aGVyd2lzZT8NCj4gPg0KPiA+IEkg
aGF2ZSBhIHdlYWsgcHJlZmVyZW5jZSB0byBuZXZlciB1c2UgaGV4IHN0cmluZ3MuDQo+ID4gSSBo
YXZlIHJlZ3JldHRlZCB1c2luZyBoZXggc3RyaW5ncyBpbiBKU09OIG11bHRpcGxlIHRpbWVzIGJ1
dCBoYXZlbid0DQo+ID4gcmVncmV0dGVkIHVzaW5nIHBsYWluIGludGVnZXJzLCB5ZXQuDQo+ID4N
Cj4gDQo+ICsxLCBqcSB3b24ndCBiZSBhYmxlIHRvIHBhcnNlIHN1Y2gganNvbi4NCg0KIE9rLg0K

