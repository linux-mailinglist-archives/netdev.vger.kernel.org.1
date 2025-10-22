Return-Path: <netdev+bounces-231653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAABFC0C8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA7623481
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F53557F1;
	Wed, 22 Oct 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qTvuHLd/"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2F35505B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137751; cv=fail; b=QvwhGjKIsJiB0Gh5oLOR50XCAFmDEcSsPdAfXD54VodkLQXSbbdIcPDoyGXnoewjjZcrhKxkKk2LwOKiPGVIGCi7UmiP5iomaJnHdOsrjsFY1v4e9ZoxuY6PLwzF6SKNPsljHOO8NfZm043ZcaX2ZqROxAHSue1TcUFRfgBX8QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137751; c=relaxed/simple;
	bh=EjsviTQLgZwTh32pnohK+ydSXNSitVBJN9j7yH00veQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOQRo6jgQ1U5EHsoucIelU0Uu98gf9tEoBInLMcg67leTok1vwfH+pq2TRotaO22lb7+7Vch+YS1MaPmuwpD54DB51kDL8ffXUb/Nlwg5QkaXqawUNq5bd9huXi1pFxdK2aV1UT9tu/za0+VMkEa6OHuD5B3zn2olMDdlxpVQwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qTvuHLd/; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6cjEsUpMAsS9slm+GPrTWj1jogFT1gwwQjK6tyjXxeINvEWE2MXV7Sjdad4NLp41MoIE38KwOCchpHfw/F8AJhdQHnZ4cWKO1BN3LpZGPZkmKMae6A+2MCSRKr93JAk0t3eh3hlaJvPPmWdzYbFN+uRVUsUssqFh1Hatwhx2LsMr5Gz7CGz8615kVWwwYdZ1Xqb+MQSOsXBXJONKCg2JgUNln+Xo+qphtgTwTnVxKnC8siYXQvECe2deom+6vJzAwjQJLRlPnGAfk4xP+ufoDaeMo9klySf8fc/oT/27MMBBINnJ935/uUkFy+QqDM8ZpdYOeVE02jcxfD4FkHmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjsviTQLgZwTh32pnohK+ydSXNSitVBJN9j7yH00veQ=;
 b=p6gX5y33V23837UqaJ68I/66eV9NSnBFJHDyR6FC3W/bOKTIiPTGyJo0czt8BMD5SL7Ncn7DaSpNNSwLGdfvYqwzPsA2e4r/O4czd6tFFhthmPHStfdmVSFvmZ3NihACfaG+RzGjSzD7UvIFpYi/RoDgG1+xS08GEuONMvoc3YzXU99MoQDofWIs2Wtd8P7+DBOr9n+LIC/ddzI43aDeGjihrh0KRUn5/ysLN1W/ukrrQLAJTsdCgYThQPPG4KEdRdyRSSKUd39w+OBi8hpSB7BM34D3+Exj2wcgD+nPafhNlQR38bc4c/f5xw6LcQOxN74waPxXG+z1vRnOB7qcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjsviTQLgZwTh32pnohK+ydSXNSitVBJN9j7yH00veQ=;
 b=qTvuHLd/bSfKsGpDPjtNPd7fsU6T18QDt2JrM3YVpQBN915hVCAQDV3+l2JKRPS6TB0fva6/GB7W62G9m8TEG3OlfF2RGBxCa2tu0/gkJj/BlgM2jT49uQTN/gkjxmmwasfkul+vo6x5hdIOH2jONKhPcDQEkqqI5QnhD+2KQgB7rKjShdcizav3R+zTcgo59Sq1FzDEjrxHhWeLF2+D6gAn9q13RIgBilqtCf3vQnuVihcdAOWJZpkVYkUlFnEkeeTjnPSDLBs6HbG4pIBW+eLDmEGJE5KYIO/cHF6MT6rmxtZxWakYcEVJILwGj+4xRuLHbYnge7Hv5ONBMGG1ww==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:55:46 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%4]) with mapi id 15.20.9228.011; Wed, 22 Oct 2025
 12:55:45 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Johannes Eigner <johannes.eigner@a-eberle.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: RE: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Thread-Topic: [PATCH ethtool 1/2] sfpid: Fix JSON output of SFP diagnostics
Thread-Index: AQHcQpM6k8QP9qsOPUa6Js0Mso0gV7TOHzew
Date: Wed, 22 Oct 2025 12:55:45 +0000
Message-ID:
 <DM6PR12MB451638CD4E7B3DC33F16E58AD8F3A@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-1-01d61b1973f6@a-eberle.de>
In-Reply-To: <20251021-fix-module-info-json-v1-1-01d61b1973f6@a-eberle.de>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7524:EE_
x-ms-office365-filtering-correlation-id: 9a2a37ba-5d76-4ece-3fd4-08de116a510e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGhBdkVJWVBiMEU5SDJuQWMrSklXM1gyUDQ4QnFVditKd091eEFuSzBJOHhK?=
 =?utf-8?B?VksyTHZyR0NRWXdyS0tZMExTSXV3U3Jsc2lRTUdGcncvbS9mUkJCdXFrZlBF?=
 =?utf-8?B?eDQreXBzOE5HcUpOQlBmOHpXSVY5VEtHWkx5OWxiNEJnMkJRNTZ4MGJiTDg2?=
 =?utf-8?B?cXRtSWR0WlVjclJJbW55Vk5pTlpscndrU0RjeDhJdE5JMjFvTjZUbWxOa1R0?=
 =?utf-8?B?bXg4Zlp2RzNqblpuSzlmcEVBOWNWck05bjJoSmVDU1lQdEU0YVdPYVd0c0lR?=
 =?utf-8?B?MURQa1l3Ujk0M0VOYXlGd2poejlETVZkQndLL3RzTUh1enh5dUhUcVVaUUF3?=
 =?utf-8?B?VTBJYUxpenl6SExjd0MyNEdoMklOY2tIQlBhMHpvVzFkbXdjb2U2S1BpcE55?=
 =?utf-8?B?WDZ1TGx6azk0UGZzdzlrKzNRMnlncDBZYTc1cU5uV0RQWis5UldHSHFBVUh0?=
 =?utf-8?B?RnlpV0RNTXVJTXlwbHBjbTBtL05aamNpOHhJdTVTaFNLMjhWVGx6L2Q1V1JV?=
 =?utf-8?B?eGVwTDE2VjdhMjNIbDVhb2NLbE1mb0VFTnNTRVFGT1g1Y3lIYXVUWi9NZlNt?=
 =?utf-8?B?VjFTQXdqcnRIcE1JVVVvUUtPRHI3c0o5d3dxUmh5eTlpQTA1SldWZS9BbjI1?=
 =?utf-8?B?NUh6YTNnQ014UFUxMmJzN0NRUk54bSt0NS9DME05R1ZJUUhQVnhpc3kxQmFi?=
 =?utf-8?B?ak0wVStzeHlPUlI2YU4yQVQwMEV3ZG0relJiNHVwcHBtTXJUL1RHUTJUQ2tj?=
 =?utf-8?B?RzZaL0hweW1YcStwZmVVOXpUZkc0dktwSXhqSFMxTURtc0J0SHZMSGF4T1RF?=
 =?utf-8?B?UGM0c2pzNTNpV0pkYktOMmhxMUl0VGdoZEdnNmVOa2orbnA2eDIzM1gya3Jr?=
 =?utf-8?B?SkZrZkt3dy9EV1VJVW1EYU1nR3FPMjZ1Mm5ka1ErWWwrTS93RDV0VTBtckFH?=
 =?utf-8?B?azNVSm5uWE5BZmhSeGVHVnNFaERmQTltZnoyU0ZDT1VuOWxEUWV5UE1tZnkr?=
 =?utf-8?B?UkxmbWVjb0JhemhoTW1sWHdkVUlmM3NSVVpOMFd5VnBXZ1RrZk15RCt4NkV4?=
 =?utf-8?B?TjNuWUZ4ays1T2Y4UDRiRkhYQmpyZy9jQnZkTzFRSmxDdFkzQTFlbTVhVDFM?=
 =?utf-8?B?VjNBR3JWMlMwa3dXZ1c1THhRRWxqTytoZnFsTllWMzhTaGdTck02SExZVytz?=
 =?utf-8?B?R0FNYVNlMVVNWHBreVo2OHprMUVIaUVObzFzSzNiZmloZTBsZkhiN25IL09w?=
 =?utf-8?B?VEVkeSt2RkZxVEQzQjBHcUdiLys4SDhxQmlIL0xLMGVMRFZWR0M3NjExQ3kz?=
 =?utf-8?B?RkZkbkRQcit6dHZLcmI3S1h0K3JOd0RXSzJ1blpET1BiUzRCay9FU3NqWHpB?=
 =?utf-8?B?blpWM3FlNjZOS2xidHFjWm16ZXFCYXhEckJqcjUyZGF4SDMya3R6VGRVQTRV?=
 =?utf-8?B?d1pNa3hSRTVsZDJOU08xaWtzT2Rzd2pDOERESkRDOU4ybjZNZGMyY0pQV05p?=
 =?utf-8?B?K3FyV2pmbVkzb3hQMlRRaURITC9HSzRlS1hVdzlOTGU3Z2hVUG5TWm92cmsr?=
 =?utf-8?B?LzRHNHg5bkMrNEttUUVxL3p4MEdyUkFtVXFHQnFCa21lazFCVE92dkZKbjI3?=
 =?utf-8?B?d2FwUlhNOUlTUmx5cHZseklta3NkRW9sZG1BekxaRGN0Uzk4K3JyT3RSME9k?=
 =?utf-8?B?RHUzdmtNOHBCMDZSZXNyclpQOGxCdXEzbkw0UE9kZWlOTlNkSG8rMEhtNGk4?=
 =?utf-8?B?cGU0cFVqNkNUT0xWSTBBUk9ncHpVVmZTY3FnU1gxYVoyM1RVUHBSbUpqM0Fo?=
 =?utf-8?B?QmxjZ1VGcmVPcmJ1cGk5S2Njd25oYi8xREFxYUU4aldzZHNXTGdnREpkY2RE?=
 =?utf-8?B?QkJGbk5aejlhc3BJSFlqN3RDNFE2Z29TMHNnRmc3ZStqbVc5OTR5cnR3YlJk?=
 =?utf-8?B?c01helFuK1VWZEk3YVJWRDRzdEpWSzMzWVoyTDJnZDR2YnBvUk9Ebnc1UkZ3?=
 =?utf-8?B?QWxoM0xpeFl1OEpadUVJaUtxMGpEd3J0dkFIWS9BY0FOM2dUczYyNlREQUt6?=
 =?utf-8?Q?kFKU2I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRRNDhkL3A1VUMycEFtS3JzaWZ5MlFlTXlidGxvRUVRVkoyY1JRUjVsekZL?=
 =?utf-8?B?VlRxbEs5Z3hNbFBCWWFoa2VYSUp3RS9GbXpKd0VtY0NMdXpuNk1CeHMxbVJh?=
 =?utf-8?B?ZWc5N3IwOWpPeEZrYytiSG1vTnZrWlZsbEgzdVJzWEJaTlNqQXdwVUFKSVpF?=
 =?utf-8?B?ZEZvSHUyMzhWWVJoQUZVWHRaaDltSlJCbkp4eWpMV09iK0ppRjdJL2ZPWVI1?=
 =?utf-8?B?RXBhVDhTaW5mdW03RFVXS3FVRHMweGJrZ3hKNTRDSk41bDV2MXNkWVExYWQ5?=
 =?utf-8?B?bFpwaC9RbXIyQkk3Y0p2eEtML05JbW8rL0RwWkRyYnFrTnNPUkNRRTY4Z25E?=
 =?utf-8?B?Q2FsUVErZ0JxY1UzNmZEMW5VZFI5MHdvdGhqcHpydERyZDQ4NTk2OUpRUmRl?=
 =?utf-8?B?Qm5zWU1PNktidmYxbUdvdFVORnI5dXQrQndtUFk1VmdTRlgwelVtbGVyZ1gy?=
 =?utf-8?B?bTJ5dU42ZHU3Y2R4UUlFL0liSy9tSnd1N0tLSGd2R1NnZGhRa3JNVXVyQkll?=
 =?utf-8?B?eDJyZ215K09GOGg2Z004a3E4WXBuZWRkbC9PZEcxTnF5d2pvR1RXdDJ3ekRr?=
 =?utf-8?B?eXArUGRTc0lJODFGZk9hVnlBYkRtOXZKUTJZTzdIOTkzc1E4ZzdiSi9aMDhj?=
 =?utf-8?B?Ymt5MnJSWnZKc0g5YmZ0R3dzWmw4ODVBb2U4SjIyMTNQdFR0RWZVVDk4dHhN?=
 =?utf-8?B?NmNYTEpCV2tJQVFkYTNnZUlsdGYrMlJRb0xlbmJWdXR6eXZUSkhiSjY2WTkr?=
 =?utf-8?B?RytGa2ljb2FSbm1ERnFFeUYxcnpCZmlCUDA0dzZjR25BRnVwOSt4R3lHLzIw?=
 =?utf-8?B?djRmQXVQMG9Nd0oyNE11OUx6Z1dUVDBjb1lRak50SWc4Y2ZVZGxrdHI3NGxB?=
 =?utf-8?B?dkZkeWM5bWZGd09nVng5MGRmbnJhV1BrQ1E3RUZJV2hqZjFNMnRod3RUVUtx?=
 =?utf-8?B?V3pDay93dlJqQ3F5TDU5cVlRUkFvbkVCZ0hGMXdJWjFrRnAwd3d6a2EraFV5?=
 =?utf-8?B?dVBkbnMyQnFFbGFVWmN0UGNidjVlaGc2dGpXeTc0WFMzVHlIWUtUT3Q5Z3I0?=
 =?utf-8?B?RTFrN2tGOFpDYnlXYXkvL1JCbWV5bDUyMnBNYzN5Nm9wbVFxbTJ2c3F2VXpW?=
 =?utf-8?B?MS9LRTVXaG5RQ1RvQ0xnVHZTcllTYlVJNUxLejV3OC9jbmk0Q084cmpETjRr?=
 =?utf-8?B?YTI1cjFtVEN5YWp4SDczTlBwK255QWRIdENpYk9ZVWhsTTJtcW9INXRQU0VR?=
 =?utf-8?B?eS85ZVlkTmFIdldId0RJOXhFS3FJRjBOZWRwYTRFYlNma1ZUb3AvZXM3dkFq?=
 =?utf-8?B?OGhHWU1Kb0hkVzFaUkxGWkg3bXN3OHVKN21raHQyTXB5cXV0elN2OHJkZUJu?=
 =?utf-8?B?bEpzV3BUVGdGall0ODBzckkrNFN5T1lKQ0x4TDJFVFgzYTc1eis2UW9UZDNm?=
 =?utf-8?B?SktVaTI1NjFGNjFabUppenY4a3dyTCtPOFV6UElCUjNMUzVaRnZlYXJIdUNR?=
 =?utf-8?B?L2JJcnlPR1FqL1JQcWhGcFZKWWdPY3cxUnBYWkM4Z2Fuc1ZmMTJoRkIrOUNz?=
 =?utf-8?B?ekROMW9LMEJaQ0tjTDBySGorVzkvNkg1cVpLanRHU1pXaTdtbTJ5VElyYlVr?=
 =?utf-8?B?ZGcyaW9zZ0EwSE9lRDdiaitpWDluMGVMd0tBWTFVSVk1SlpOZ2ozcGVlZ1FK?=
 =?utf-8?B?RkJCc0FocGlnWW1lSDVZa1UxRTJGakNkd2E0Zmd5emE5bFEwRzM0OUwzTi91?=
 =?utf-8?B?MVpIMUJGV2MxQlROQ09VZ0hud3BBRTZDTWhualJUcCtXRm9meklSaXhrU1FT?=
 =?utf-8?B?Ni9jTFFGUTdQaExpL1BWWUpaQmNkcHp1d04vNlhNYUJrVzQ0MHdUMzVaYjNv?=
 =?utf-8?B?UWdIKzlDeWozcFd0TEw3U0FkcGlLOGdqV0ZNVFhFNHJLMlBkNWNzWC95eGxr?=
 =?utf-8?B?RHlOWlJTdGZWWjJ2alhGODFoVmhnS3FoaFNVWk9Nb2ZZOWg1UlNuend4Z0Iv?=
 =?utf-8?B?bStNSmdwdjU3RnR1U0ZOd0FJZTBNQVN1NGwvNVlDS2ZFZCtBTkRwTGlnMTZL?=
 =?utf-8?B?aGVQVmFUTGs4Ynh1N24zL0YrajJ4c1Q2K3cvdWFCanNuOXJPYVk0RU9GNGgv?=
 =?utf-8?Q?toN9MZ8GFRanpNtWdaKmspUmo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2a37ba-5d76-4ece-3fd4-08de116a510e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 12:55:45.7200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOK3AiVdQcI57D4k/NsDbSFVpkyF5EqruXPEEbq0GOVIBLr5iZl3BhFoFjiTCvzIoqS1EPGMEE7wOq0ImDSzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBFaWduZXIgPGpv
aGFubmVzLmVpZ25lckBhLWViZXJsZS5kZT4NCj4gU2VudDogVHVlc2RheSwgMjEgT2N0b2JlciAy
MDI1IDE3OjAwDQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWNoYWwgS3Vi
ZWNlayA8bWt1YmVjZWtAc3VzZS5jej47IERhbmllbGxlIFJhdHNvbg0KPiA8ZGFuaWVsbGVyQG52
aWRpYS5jb20+OyBTdGVwaGFuIFd1cm0gPHN0ZXBoYW4ud3VybUBhLWViZXJsZS5kZT47DQo+IEpv
aGFubmVzIEVpZ25lciA8am9oYW5uZXMuZWlnbmVyQGEtZWJlcmxlLmRlPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggZXRodG9vbCAxLzJdIHNmcGlkOiBGaXggSlNPTiBvdXRwdXQgb2YgU0ZQIGRpYWdub3N0
aWNzDQo+IA0KPiBDbG9zZSBhbmQgZGVsZXRlIEpTT04gb2JqZWN0IG9ubHkgYWZ0ZXIgb3V0cHV0
IG9mIFNGUCBkaWFnbm9zdGljcyBzbw0KPiB0aGF0IGl0IGlzIGFsc28gSlNPTiBmb3JtYXR0ZWQu
IElmIHRoZSBKU09OIG9iamVjdCBpcyBkZWxldGVkIHRvbyBlYXJseSwNCj4gc29tZSBvZiB0aGUg
b3V0cHV0IHdpbGwgbm90IGJlIEpTT04gZm9ybWF0dGVkLCByZXN1bHRpbmcgaW4gbWl4ZWQgb3V0
cHV0DQo+IGZvcm1hdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBFaWduZXIgPGpv
aGFubmVzLmVpZ25lckBhLWViZXJsZS5kZT4NCg0KSGkgSm9oYW5uZXMsDQoNClBsZWFzZSBhZGQg
YSBmaXhlcyB0YWcuDQoNCj4gLS0tDQo+ICBzZnBpZC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3NmcGlkLmMgYi9zZnBpZC5jDQo+IGluZGV4IDYyYWNiNGYuLjUyMTZjZTMgMTAwNjQ0DQo+IC0t
LSBhL3NmcGlkLmMNCj4gKysrIGIvc2ZwaWQuYw0KPiBAQCAtNTIwLDggKzUyMCw2IEBAIGludCBz
ZmY4MDc5X3Nob3dfYWxsX25sKHN0cnVjdCBjbWRfY29udGV4dCAqY3R4KQ0KPiAgCW5ld19qc29u
X29iaihjdHgtPmpzb24pOw0KPiAgCW9wZW5fanNvbl9vYmplY3QoTlVMTCk7DQo+ICAJc2ZmODA3
OV9zaG93X2FsbF9jb21tb24oYnVmKTsNCj4gLQljbG9zZV9qc29uX29iamVjdCgpOw0KPiAtCWRl
bGV0ZV9qc29uX29iaigpOw0KPiANCj4gIAkvKiBGaW5pc2ggaWYgQTJoIHBhZ2UgaXMgbm90IHBy
ZXNlbnQgKi8NCj4gIAlpZiAoIShidWZbOTJdICYgKDEgPDwgNikpKQ0KPiBAQCAtNTM3LDYgKzUz
NSw4IEBAIGludCBzZmY4MDc5X3Nob3dfYWxsX25sKHN0cnVjdCBjbWRfY29udGV4dCAqY3R4KQ0K
PiANCj4gIAlzZmY4NDcyX3Nob3dfYWxsKGJ1Zik7DQo+ICBvdXQ6DQo+ICsJY2xvc2VfanNvbl9v
YmplY3QoKTsNCj4gKwlkZWxldGVfanNvbl9vYmooKTsNCg0KSWYgc2ZmODA3OV9nZXRfZWVwcm9t
X3BhZ2UoKSBmYWlscywgdGhlbiBjbG9zZV9qc29uX29iamVjdCgpIGFuZCBkZWxldGVfanNvbl9v
YmplY3QoKSBsaW5lcyB3aWxsIGJlIGNhbGxlZCBhbHRob3VnaCB0aGUgb2JqZWN0IHdhcyBuZXZl
ciBvcGVuZWQuDQpJIHRoaW5rIHRob3NlIGxpbmVzIHNob3VsZCBiZSBhZnRlciB0aGUgc2ZmODQ3
Ml9zaG93X2FsbCgpLCBidXQgb3V0c2lkZSB0aGUgb3V0IGxhYmVsLg0KDQo+ICAJZnJlZShidWYp
Ow0KPiANCj4gIAlyZXR1cm4gcmV0Ow0KPiANCj4gLS0NCj4gMi40My4wDQoNCg==

