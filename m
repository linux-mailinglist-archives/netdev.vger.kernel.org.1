Return-Path: <netdev+bounces-128506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B194979ECA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9382821DC
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22D482C1;
	Mon, 16 Sep 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGUnWtRZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11831CF83;
	Mon, 16 Sep 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480434; cv=fail; b=eTiwpy+zf/9/hP0We/cRyC3vh8aZqDyYGvyzZOcZ89bw5cXxQd2YE295f5VC15AFGDtH77KALCmZZOVmeHTCyDxCQ7lC3QArE+JdNP4x8Y+PZVIvkDsJxLs9KfX9PwaDGDdbFghn9OaeGB/FIh4FJ2ZBueMw0GuFK5bsQbwMSbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480434; c=relaxed/simple;
	bh=z9ehZ62zAMiO9QnC+S3Zb9JgPWrTIY5Qy33+JhWKZK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1jFArtfMmGeRLEVDQHNU4NsUiEgR7XNebvBA7+EBGm/nUF7GswSrEdvRTVLEkjerRlpPFOX2ZToUeFazG3OOC2GF8BqvNp89tSJhehCJaFvclwXlBu5uu+1hq5J6PthuEvfUOC12TdbL9UXRdgY+1CaBN3haFFv0RanpaXDlsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGUnWtRZ; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjdM5M/EqLUp0nBxxP+o6ZY9qBSxFEvy4H3BMZNuYTK40o6pdCBKqUwhWn4LvRai0HiW0veuIWWMfwgPvOgV2KO1WpPtDZ5rBQdtaaPqcidW0/+FpgsK3F6R55BGwb2F+zwLDIlgR0qEs4r1q4zws9C6mCGG2yH8BBOiNZRJNc8djucxOMYdytGXwRsesVXHrdX2ZI6pZHbc0SYHFAaPWxXZDZX5NR6mNAAa0YwyBNlLgq8H3wY5zcyNCORYzcjwLn2GmcMX4HAlz8NaikSnPwc9JxAAOYnVspaqF11Ha+dcrUcIEmqn5VdXo5mejApDZDd1yAv2q1R/EyvDzhpccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=017zD92cFVrcXNKFhkszuR1DS23D/RKr22tZzmxGvLs=;
 b=C92/L+tgrqUJcDfQVqXTjVNFmVQ28fQbNm5ZyZL/SfDttrX1cqtH71j3S8ixJksQPofdcF6Cc5Shroy3Kn7UyNGH6ZoDKUK+iHTqBmnsmfvS2eTyjrc3GhPRNpTMr1yYyYU3IIJqRzcV/FYYw4fwSq7C0MHre63eiMcsSzPYdWS/xFXWplNLCEmdCSsetfKHaF2n3BTHN9GDGfxk39qLdaM6EXP2olDpeQUgrWxJN1oJwhGgY46unhMXTpplY720kwahxDIEfEP8LJkZ5Ibacf8KOltE9CNr5j6MciygvOdSyCVWwgbpDPufr/hiaI2esAThSnUZ1ON6xOkUt42jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=017zD92cFVrcXNKFhkszuR1DS23D/RKr22tZzmxGvLs=;
 b=NGUnWtRZ0lbHdl15RN7wG7CS2hO70EYYG43zwzPZ5pS9lQ5XxQTUcXl4R2xKAfACoisYpClQl3AhbsDQDFWRFpkRobiPTGAhtURNFMZkAJd0/iCiDiTgOSnbM1ASkG9dDZQtvOLkCs7X5yXceRWJ9yeLE0QGJh8ndvpqOJjUTtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 09:53:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:53:50 +0000
Message-ID: <220cc75a-3de5-f6ed-fb6b-ba894579ed12@amd.com>
Date: Mon, 16 Sep 2024 10:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
 <20240912115747.000023c3.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240912115747.000023c3.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4e0642-6e05-40c8-db5b-08dcd635759b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZpVEl6WENJc0hEUitvMm1CcG5LejE0K3BUZUMrbjBtVlZpWEhTZDlRUVMv?=
 =?utf-8?B?UXZJNjFGaERYOC80SkpoZ0NMUTQ2S2pWTWFYRC9PREZJdHZoOUtWay9ySFp0?=
 =?utf-8?B?SStYUVFuZUhWVnpxRVJtSXhaaWpZZDllNzlwVVNoL09VYXJLajZBMDNTbWw3?=
 =?utf-8?B?YldabUNONUhjK1p6RVVvb0dWdHdsMFRQRFlkRGdGSkMwNUtkQ0VOWm1peVY5?=
 =?utf-8?B?aEU0YnNjc3BodHNEUnp3N3F3d2RjYmtHM1kzbEhOWmdBZERPdFJiWWZpSTNM?=
 =?utf-8?B?MU1oVStBcXVwL1Q4ZWFjdmJYalhoVHZCZDZVWWxad3NZVmxtUW5sTjlKUWkz?=
 =?utf-8?B?N0hNaVd4TU8wY2xhM255M1ErN3RsVzVJNTZGZXVtWSs4T2Yzc24vYzF1MWoy?=
 =?utf-8?B?azV0czlyYlZhTkw4VmhVWkxBVUV1Z1ZuSVhSWUxsaDlLNTVia3AzRjlRVTAv?=
 =?utf-8?B?REpveSsvbm8vSmJmKzFpbTM1Njhsb1Z3UmFzaDZIU0J4L0ljQU9ta1pmWTc1?=
 =?utf-8?B?ZUhxYzZpb01aVEVjVzB6NDhvbm54Nk94VUptMTkyQ1FoY1RUZTQyNENSL0s4?=
 =?utf-8?B?eGhiNnhjSmFZMXptZjNrQzd3WG1hQmIrQjJEeDIrcEppa2oyaEdsbk1UWis5?=
 =?utf-8?B?MmtPdXMyUDBTMDVtYzhrYTBWRWw1MXQ4QmV3V1dOcEk2WXF1c2FSM0U1MzB6?=
 =?utf-8?B?djZCQ2NXejRUN3VYOFVaUm1TQTMvQnltMDQzVnE1N29vODJnMEhPM3Vsd0JD?=
 =?utf-8?B?Rm5MU3ZWRXJuV2JUUXlYNWRsWG5XUjZQdXRmeUdRNXVEOEZWdTRtUDJ0aWJx?=
 =?utf-8?B?T0h1YjlPZnNIdkxsL0FsL3RmcUprUW1LcDN4bWRLd1dxZVJ2TmF1K2MxWTVF?=
 =?utf-8?B?MzFxc1V1ZkVlSitZMmZ0dVV4ZEJzVkR4SkxLdEdYbFhWMitIejJrQUxpd2o2?=
 =?utf-8?B?c29jVFYrbWthSUg0YmVNTEtqckVVaVRkWWVMbjg4NzVvNGw5RzhvRERIZ0Zw?=
 =?utf-8?B?Y3hDUlgxcUZ0Ky9xOTk2UXRjYnRSbFY1eE9POHhsVEgwNHFuMXpFVTN6d2tv?=
 =?utf-8?B?Q0E3bVYwNHdueTMxWW5lK1lLWW5yaDYrMFVZazU1TDNyQnFLZWpDc1BuWHpp?=
 =?utf-8?B?WmVyWjFVcnM2L25IWHREdGhacVl0M3l2T1hublVvZ3EyR3Z4b0ZZVkFHdEdy?=
 =?utf-8?B?a3ZxaGJBNlpFVGxmWGtWc3MwN05SdEx4TG9UT2lyT3Q1UndCTTdoc3ltQXND?=
 =?utf-8?B?QUVSc04xUlhodTZLK3FvWmVNcUpMVk1WV2xJNml6UjhxL21pK211a3FBQWVz?=
 =?utf-8?B?QlVGKzNDcXhlajQzQjZaUTdqdWVsNUErY2FwYUZRaUo3V1prMUxNNURmQUVS?=
 =?utf-8?B?M3pKZ1BYY1kzT0pDcmZSMVZWazlyaktIbjVGclJxUzJSRnB0OUtsR3UrWTdn?=
 =?utf-8?B?MHh0MURBQ3dqajh0N0daNnlxcVlZV2dTZEtLRURncmJiMmdCeVpuSkE3K1JF?=
 =?utf-8?B?T1RlUElNVE50Mkg4Ui83OXpGT012QkhQTmJ1MksxbEhqK0l4akFwdngzN1Zv?=
 =?utf-8?B?ZE9HN0FjOEhSTk4zbHZYZEdYUmVFSDFZTURpa3ZTWnY2Qy9paERob0gydUlo?=
 =?utf-8?B?QkgwampNbXVkMERrR2JrUWZzb2xYdEdGWE9xZHlsanJwSld5UnN4RTcvTUlo?=
 =?utf-8?B?SkJidDhMR1ZBTkRReGYwbDJMZHRhZ1dISzRTbnBITWROWXV4bks3VURrV3k3?=
 =?utf-8?B?SlBncWVnTitva0RlNU0vNy96bG1QVkVITVRrRGVtTlg0dGxEQUI2MFR2S2xq?=
 =?utf-8?B?cllwcjA2eitKcjJ0aW5IZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDd1WWt2Z2U1UlJ0NWw4LzB0QVc1TnkwZVRVM2lkcmdMR1grcmxmMS8ydkJj?=
 =?utf-8?B?S3llRzdDNW5NbnI3WFB0cnQ5RDlaVWRkNkRWRE1zVERUb1BkK1Y2dm5WMHky?=
 =?utf-8?B?MXg2c1EzK2krektmODB5YkVHeWZmdVhxRWR2R0ZhUkJBdFBlamJpVlprZjVH?=
 =?utf-8?B?S1B5d3REQUZkNXRYY3ZwTUIwMWRHYngxb25udXFHMGpwTnFGNW9DYTdjd3lC?=
 =?utf-8?B?NmpadEJ0MkpiMmxRWFZETlNXT0Y4NjkveVJ6ZUE5cTBMaXRJeS9WUDFuNWla?=
 =?utf-8?B?OVBDZFBhQ1lXL2RVeHBTczRva0NMd3d2R1NkM1VMNGo5MjN5MGhjMlR3cHBI?=
 =?utf-8?B?aGlubldCZzB0b3Jkdm41a0pDUmlHRGVTVnJaODd0VXZpbFE4OFVNMWNOc0I2?=
 =?utf-8?B?aUQzSEJWcDB6dTNia1cxalRsMzhKVHp2SzgrUXlqeDhyMlZra1NGU3lHTlMz?=
 =?utf-8?B?ajRVcHpkUGc3MG9KWDdLRlpSUG10LzhlUm1KT2t0NUU3ZUtZdFluYVYwRlRK?=
 =?utf-8?B?ajVnVktaZGJ2Rm1ScUxzTGZML1BLb0Y2U3RZNFpKL0RGOXJoYThab3F2WmN2?=
 =?utf-8?B?UkQ3aTc5b0FyV05TTkJwNmIvNHU3YXRtK3gzQjZtT0FGdnVRZTU3ajBZSXJI?=
 =?utf-8?B?c0lHYVNrME9kT09KemJJbm9kRnFtRlVzUm1TeFhxcWZPdjdRRWpPNDEzL2Jt?=
 =?utf-8?B?MStBMjBENXJrR01HTWVrT3NqWHMvczBvdG5Rak1ONWJDY1VkUVN2cTgvSjZ5?=
 =?utf-8?B?T1dsaGNDVElCeVFkV1Y0OTVHZ2xBWGVnZnYyc0RqTW9VMHpFeEFmU0YvVkRI?=
 =?utf-8?B?bEpjV01vSWV1RFhaTW1uWHh4YVM3a2xadEF4YmpNcmQrUkI1TGpPMzZwSDd4?=
 =?utf-8?B?UndObzlSb2l6TUZjdVI4V0FzSU5wUllUQStHS3lQKzdHeHNQZU43WFhmSHlS?=
 =?utf-8?B?M0cxczVYeE1VSXNpRFFSR0JsYjlBamJXWk81b0M1dkFwMFlwUytGRWhhVUpQ?=
 =?utf-8?B?OG1UK0E4amVxS2VNL2oxSEdqcUFrd2FlOG5XOEtqUXdSZGZFeGd2NmRvMnho?=
 =?utf-8?B?Zk0ralhEb0ZIZnhIaTNmNEthZUpwYklVQnB4RlB6ZEVvRTc2U25PUFBBSkdl?=
 =?utf-8?B?SHZiTEg1QTB6a09QN1VDZkppQnpBdjVIUlJObUhSYkRxZSt3SkhFVzczUmwz?=
 =?utf-8?B?QUVmWlgvOXpNK3dyT2c1ZU5qUEdLZXBZUTRSOXZyYkltUmI3WFk3S3MxTmxR?=
 =?utf-8?B?TFNUZGZ5NEM4dWVZdTQ3NVVrR2lrQktaMm1IME9ra2R4T05kblFROVRWZlN4?=
 =?utf-8?B?c3NsTEJjUmNNQW5HN0pxd3hRNERGQjhlU2ZoRDVWVS9jYk1ZRmo2cGE3bWNP?=
 =?utf-8?B?eFZ1bUllWTFMc3VjeS8wdkxPYnVJZEx3QzFPdmFqb0lWdkJ3NTRtOFcwOWli?=
 =?utf-8?B?Y09wcDVmbWxNczVxS2l2QlR6bFhqWGhyT3NTRlE4N2NWam5FdmJ6MGNrVXRp?=
 =?utf-8?B?amgyQXFoaHp3dENvclQxZHRRKzREL1ZRQTA5UXYreTR1TkJEcG9UNmVCdHBX?=
 =?utf-8?B?VTRYakp6YzJpUEhld0dYOWxFSmhhVDhPSmhMNkxGK1ZKM1Uxa0tVQ1l1RTJ6?=
 =?utf-8?B?SERrRk1hdEFNbE81Ly9WMTFWTG9rQ0EzRkdyeFNwSk80bWFsTWxXTk5QWXhM?=
 =?utf-8?B?Q1JrSWxGWTd1a0Q5WkUwNUZucEMrWURDMlc3dGdDcFR3YlZKYWUycS9WdGY3?=
 =?utf-8?B?ZnovSGNwVmEybHYwd1IweDMvTHJiT3Q1NU9EVEJsejIwRHB0THhmejd6UzQv?=
 =?utf-8?B?djg0ZEY2ZThVU0gwMENSVjBzNG5MYmJTS0x3Tk1RU1VNRXh5c2tsc0MwYUZ5?=
 =?utf-8?B?U3NlQldKN1l3L0loM25OMWZhaDdwOExOUHcyc3pYd1czS1o3SnFUQXpaN0Jy?=
 =?utf-8?B?OVBNVjg1Mm4yOXlyellzN0I5TW1LWjJBZmhoeGF0bGhkcXpnbHBMSVJxbFA1?=
 =?utf-8?B?SHhiZlVyRGo2ajNVQnNvQXF0TGZuWkRHMGNRVEZHTWNsa2JPN0dNT24zTTJv?=
 =?utf-8?B?blpVcXVGMll1UkNqZW1zMGdOdHNvcklYeHFlTlk1UzFMQjhkaVdsWkowV2lv?=
 =?utf-8?Q?ugmHKdOSkVSD45DDUdWpj0Bj1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4e0642-6e05-40c8-db5b-08dcd635759b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:53:50.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQOTjvqdq5aX7h327BqnTYJdo1uSUmHPNJKPcOEg84oSm5qzIGvYZo9bioo/1fg9pkcYOeE70AH/k3WpE3LZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193


>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
>> +
> Use SZ_256M in include/linux/sizes.h
>
>

I'll do.

Thanks!


