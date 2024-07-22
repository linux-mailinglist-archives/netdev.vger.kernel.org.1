Return-Path: <netdev+bounces-112386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA031938C94
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E49F1F255DE
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196D16D9AC;
	Mon, 22 Jul 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nLb4vg7M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2416D333;
	Mon, 22 Jul 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641548; cv=fail; b=KnJcCWDfthsHwm4TlBrhSlnMXedGI83J3A6gAy7JLMM38l7ZBpdNrJorP7REsNMZPud9FPoMeJAP9DLAyfS/Eatzx3+B4juyfYmFTVwzKhXZXnW9zSHfsp3WPw2O5Jh4vdOmEvqFSv3PH8+UrJPsnJwadvG/j8L0bftrtBvIidM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641548; c=relaxed/simple;
	bh=IMOpYzQ9NKETfA7FlUX8gBGdeIkDZWqyXn3SY5qS/7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exuFGOiM8Y1AnWOzRMhjLt34uvy9WbBUymG0xF55vzVhoGRQY6rqY15tR81uiY9sU9YF1Xe6hb7ag+kO+6yC0/XF1OyR21Azq6oQNFzUPb449+/RSeAfr5D59W3Q9UWrfpBIsjTFvyj37uc2fxi4+5pfM71I3IWibWsiV7+gFvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nLb4vg7M; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q504V76WtMNMtkfys/VD6lV16TetNE8U1//b+b/tI1re2bK32/aAp75Ih27Y1KxLZCTHxiAhUndWhaHSh3oBPB83sNQDcrqEwS+JvoUuKt4pZV5S3MJRV/xrpqO/4t9INMstTL29J3pVftdoogo/4cKzZpwlVvleghyPmyPtb8Cm7Be+CiI0pvT54Z6Vk/ZSOuD3VvwpN3kUycGThNnG6zG6fQLJI/EEfGNrI8e1eNQO3dlCO8aFetmCflcTqPtt26B0uslnsFTSK1rS/Tp3Un7aEF0gNY2C6fA2FrkO2RE9Na66PVvr7DekhhR9jp4pn0mQGg93eyYXJIuXqYGX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMOpYzQ9NKETfA7FlUX8gBGdeIkDZWqyXn3SY5qS/7g=;
 b=SRs+z2nyAxEExoEcjt95JfCVUabAzRFFTfKMZY6ZnWWsmMZ/WZEaNES4ElYxrWGiR90+n1P74S9Y6GCvTVTaku0tOiYqPEyT8ykpsaRfRuZAraKap7uAsR1g2trmmKnMk9Eqvv7q1y+qpp/LEi00CDZxqlhY2HcmcqXbUiDJmWcTPfW4rFeelHm/pchULeVhUNayVttUUDMwsBhvmMNM3bWFEASsFiTZ51koQpotTgMq+mLhThQ9OPqTbt/S6HzdLWhDPuDxWO5eGkhHoWvk9YxFEkCWui3sJCyke+53Xny+9oDYt47CdjifJUpuJ0jMYZB044IqgSCKmzNf3yXKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMOpYzQ9NKETfA7FlUX8gBGdeIkDZWqyXn3SY5qS/7g=;
 b=nLb4vg7MvMBTd4JeqMHEQo0uSDfTeWbVGy32erR4AHsiUKipZyaWxlV6wU3yLbjiRwPisEuMc16BtZzoCwXOCMLmhsOFjT63UsHHBDHezZQxIKBlUtSVNik0zdMUpzS3bzp8uoBWrlj6yi9onLCXPzf7uz6iUuz0Vp7Wt/R4pmPL1Xw0EgY55fqrnqL6Gmd8CZpYByrgY11FpSeiSI6BlyZ//9VPvl5acWBFqfI5F7kuYF8bPBcmLR1LP+cguEm2v8fULqoh0SMvcELDqjokTnqwvloU6dRtgUKk418lMhkzM8nzrzB8/z3P2Zk784HEKQ4n8exXZEb+f7yzLqySLA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 09:45:43 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:45:43 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "lulu@redhat.com" <lulu@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, Parav Pandit
	<parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
Thread-Topic: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
Thread-Index: AQHa29N1IZXRnvKue0eGMqAcqUN4HLICX4AAgAAgrgA=
Date: Mon, 22 Jul 2024 09:45:43 +0000
Message-ID: <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
References: <20240722010625.1016854-1-lulu@redhat.com>
	 <20240722010625.1016854-4-lulu@redhat.com>
	 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
In-Reply-To:
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: 85785188-b038-400e-573d-08dcaa330de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUdaWnk5eTN3bVdEdEtPTkd6QnhIeGJlc2dSY3lkOFQ4WThNeXJjMXZjNXRZ?=
 =?utf-8?B?NHA4K0E2cEpyemd5eXg4TS9jcG9CMHhsQ0ZTTVN3TE9TOTdYcWh2ZkFhREkx?=
 =?utf-8?B?RHk2ZTh5WXBoS3dRcjNtaEZqdzQ4bGxsZjg1QndIZEJOc3lvUXliTm04clM2?=
 =?utf-8?B?MVF0TTlWOEVISTFnME9WMVpIQWxZNTkwSUllZk9Zc1IvSEI0cUZRTHdzeUxw?=
 =?utf-8?B?aGg4VWdvbTJic1ZORUc4R3poK2loekYwMDBNWTVHYUxQR0tRS1hJZXo2K25i?=
 =?utf-8?B?V3FJdXYzWnlYNnYxdFg3M0dxUStuTW42akZIb2tOWFV1dEpYbzVKeGkxVUZi?=
 =?utf-8?B?aGozeWpjTkk2V0xhVWhqZ1dSZ1preldlaGVNbUtGa3lIb3Z3eXZSYzFWd2Q5?=
 =?utf-8?B?R0dRNXI3TzlOQVd5TDdtTUNqclhxK1NJVXdUbHl6VlZpNHJtOTNhSUExOEhO?=
 =?utf-8?B?OHV2aEhTbUVPaDZKNFJiQVFCbi9qK3pFUWhDVUJwc3psdnJxbElPN0tzWmM4?=
 =?utf-8?B?NTZKaDFhQkFIUTlxd0hVRVpYQ3dFOXVxYy91TkRvWHIrUEUwbmsxRzFnZ255?=
 =?utf-8?B?VlBNT2ZBQWdBNFgyamlaOVpGNUFaSHNTVExoMUduYVRQLzVQTWhTTnpZNHZH?=
 =?utf-8?B?R3ExV2I2U3Nsb3MvbUI1K3F0MGw1R2FUbWdETnd0TzlHdExqNW5KL2xRNXQx?=
 =?utf-8?B?bVJHdUJzeDZFMkt0U2RRTE9PRGlXeU5aRVZ4RDBrcjAvV2ZRVkc2ZXNjb25a?=
 =?utf-8?B?VDR5bGY3NDJjYkJBb09IazRiMFVWY01qVWZvc2ttTWlCbkxRTmo4bC9YOEVi?=
 =?utf-8?B?VG01dGtPN1pOb2ZPaGhuSThWUy9BTURobHloTGJ3bVJBUkxGcnJxZmtld1pO?=
 =?utf-8?B?cTJ1NUFXQmcwVnU4N2RqRS9xSC9pUGt3cDh2ci8yL2lFVW05bzJWN3RkL1BU?=
 =?utf-8?B?UGUxM2dpSWtmSHRILzJLTmhJb1ZXL3VtSGlRSHlSbzN3QmJzV3JMaXdrVmhL?=
 =?utf-8?B?ZmlhZ0ZKYWZjdGtMUkhlR3hBL3JaSXhPZzFWREJ6aUdEVXZ6dHprWXVKRE85?=
 =?utf-8?B?SkMxdHdrM1J1bHN4bjNDWldldTlyOHlnS0FndENNRDljZisyMHNaMnBFK1lP?=
 =?utf-8?B?aWNOVEJkakNFRkhvcUZCVHVES3p5TW4wNkZSblBjMldPME9QbmsrL0c0Vzgy?=
 =?utf-8?B?RFZKM0lpLzFFVnVOYjdsWU9pQXJKamdVRW05RWhzUThUMkNqdkhsM3NpZThR?=
 =?utf-8?B?TEwxU1g0dEhESlhWR2djSG9HUnYyNUUzZ3E4TStlQ1NvNmZnNmtxRmpLQnJS?=
 =?utf-8?B?S1pxQmhubzlNejc5OUVJZEg4eVY1VXhxK3VzdWM1RGRCQ2x2YXlic3RwVThO?=
 =?utf-8?B?SXhDVmw2TWI1WHpsSy9IWlErY256Rkp1V1poOWtOb0RWcGdhS3NhNUhvbC9x?=
 =?utf-8?B?RTFLaG1VYUl3RUhpMFhZaWlPekJpclpuSjYvUkg3aXRFKzNkU3ZlZU0yeDZi?=
 =?utf-8?B?aW81WmpyVjBxV0h4NUo0ekRlWEhoNng1RGhMdHNmTlBRQU5IRHRjSnY3eHFS?=
 =?utf-8?B?NU1YUHhvbDBmYWI4MHBtVGpwemRUeGlkd0pBNjhRNGI3end3MFU5dUdUVXJh?=
 =?utf-8?B?c1FOTE0wQ2ZyNzIyY05GbFVCaDdOY1dYNU5UZ2l3clA3ektISVVsc1lMZ0JC?=
 =?utf-8?B?dWhXN2gwQVpOdjA5YnFoclU1eGdlUkd6UVJsd05BL2p0cE8yZDJ6ODhzdzRL?=
 =?utf-8?B?ZlNTaUxuT0MzS3hyWUp5MERTSXRQOC9YNGlydWVEUElmRncwbkFVWXY4ZWEw?=
 =?utf-8?B?dlRIaEtyUTRXdldWK09ud1NBQWQ5cHN4ZXZ0a0p4VGwyZzAvQXptZEYxWlhm?=
 =?utf-8?B?Yk4wTVowVTR5dWdmU0l0RUphNDBpRmlvMWhXaEdTZmdSdVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3JDNlRadGs3bHVqSHlOWWdzTExnOTV5UEdCRm44K2E1Zy9ENjYrbWZiYjA1?=
 =?utf-8?B?VURzOWsyUWpEVklRVk5GbUoybzB4MnlCZW1JL3lvUGZDL2NsTGVQVmorYnpS?=
 =?utf-8?B?WmZOaWhCc1NWUnJ1SGs2bDFiNjV5V2w0SHIwbFEyRUpJTFdNVllkaUJMOHM3?=
 =?utf-8?B?d2I2eVpVU1AyMVMyVlFSWGhDY0lRb1ZXOWsvdGhzSi9RdFVZRTcvV0ZvUFQz?=
 =?utf-8?B?N05Kajk2dktFRmlqeHdweUEzSngrd3I5MUlteEs5OUF3S1hncG5mQzNCNUQ2?=
 =?utf-8?B?eEFodnhpZEplamVJZmsrSTZqQTk2UGJRNlpPSmt4eHBTZU9pMU1sODkwM0dr?=
 =?utf-8?B?cXpOYVViR1FNY0I5T0xsTXNtMmpWUEVGemd6d1RobjlWUTcrbXNCZE80VDhm?=
 =?utf-8?B?bWVMc2llaXZ6VmpIU3I2ZUlwK0Fkcm01b1NOWCswK0dHSGovRGlLMVJtQ2dh?=
 =?utf-8?B?enJvSTYrRnY5QlV1Qk9oR09ZMnRRUis5cFFjSUpKRFpRaXdXOEU0SXhvaURU?=
 =?utf-8?B?RWtOclFsMDdBaUpUNHdQUEY5d210NllMMitvR3RRV0pXRFNTUHRvWlR0YzRK?=
 =?utf-8?B?cnNjVkw3UXhVamZmLytHR2lCS0tSYXNWcDE5M0ZWRWdLU3ljcEVESDVEUU9k?=
 =?utf-8?B?Q1AwUU1RTzR0THlUWXgwZ0FBWHZTeEpjb0FWeEU4bzRUY3p5UEJIcWlsaG9r?=
 =?utf-8?B?Tkw1Z3V4d3ZYL2Jrb0xWVzVObHdpUkJaclJqU3QySGxjMDNPMTRTdUNXazN4?=
 =?utf-8?B?bjQ4WmpjdFdYaVY4MW8wR3JHdldQbjBsUTdkVUZ3b1hFMVZ0YmFpK09XaDdZ?=
 =?utf-8?B?OG9sdW1YbHVBRG0zdDNJeURMcklDUTNYMHIyL2gxYTQ1RENrcW15SHI1TXhi?=
 =?utf-8?B?eFFmZzh3SUtjQVJQZ1JjSDBzc3hoeW1yVGZaNUlNNjAxb1NOK1c4bktiY0FT?=
 =?utf-8?B?RUg2WjVJa2ZabWxuQ25TRWlxZHduQmJ5WXlZVDhHcHhDL2tYekhkUTNvY1Vs?=
 =?utf-8?B?SWY4TEFVa1IxYUdUZm1DRnZUVk9ibWhSZ0crNmViVmhyQ3RuNC82RzY5UVor?=
 =?utf-8?B?VllscXN0SzVxeW1lZXZyK0xGaTh1Tkx5anhKQnJVa2ZEdUxuSnZsd1JWWHZx?=
 =?utf-8?B?cFpyazc1YVJzZ0llVnY3U05SRGtzai9IVkV4cnhURzRETGNCRys4SndTLzI5?=
 =?utf-8?B?VVljaUd5WUdmVWp0Z1JXemRFczRTQnVmRXFvOUhQdHFKeWZBcS9MVXo0WDh3?=
 =?utf-8?B?L3o5SURDMFZBd2JKS01TMDY4TVhrZEU0VkpJQW1DUW05WFA3aXIrUTNwMGEy?=
 =?utf-8?B?SStvSEVwMHBHc0NKYjAvRzRQZjRkRWswUGM3Y0wzN2NPT1VTaFVOZkR5L25P?=
 =?utf-8?B?TmlxSWVhdG9NVi9BNHB5Q2Qwc1VVZjhOMUpKSE5mQ3lQQkNETnF4Rm5oN1FP?=
 =?utf-8?B?MStEcU5pQXpPbkFNRGZkOEdGbzhkV2dTNzBxT1FPd2dXS2kzem5VQjFleUJj?=
 =?utf-8?B?MzRkdXpGRGtHY0UzRnJTUEU1V2lOalUwZy9FZzZEeFZYeEFjNEFjbDJRdU9R?=
 =?utf-8?B?S3preFNKSFc4ZWZMc0VMbWNGcVVZYUFXaHozWmVRck5GaWNmc2tFY0JRWkI5?=
 =?utf-8?B?UERCV0ZxVW5wS3MrR1kxb1YwNDlEYWJvTmZlZlBPNWhROTBzVlBNc3k4Uy9q?=
 =?utf-8?B?YTE2cmVNaTdVWjRLTHYwWXVKd1FMUmpVRU5qTndILzAzbXh4M3RxM1F4Q3B1?=
 =?utf-8?B?WEo3ZFU5UG1uRGZnUDBNQWVCQjVHdFBObE5DL2VoN3hPMWlYM2ROUnNYZjJ1?=
 =?utf-8?B?QjhqYWZod3VYQ3NURVFVK0ZDT21XWE1yTTBBTVJQY1dRMlBJVTI5cXdJOFVs?=
 =?utf-8?B?Y1h1alZlY3RJQSswNWQ1dUdKRThHTDdxMDNjUGx4TVB5RHI5UldiMHdEd3Nl?=
 =?utf-8?B?YkM4UUk2YlZZbm12ODlzaGFZQ1dpZE1qL1BDeFY0b0l2NzBzanBQbkxyN28r?=
 =?utf-8?B?RmJxd0pUZTAvWEdoNXNXSDBwd2FMQklBUTJMMEs5ajdGWjZoU0o5VW1KRzFs?=
 =?utf-8?B?SVZLZkdGODdzNDgwSjMveERRRTVEdU9EL0o5UGRETHVMcXJQQlZlUWZUZWhV?=
 =?utf-8?B?bm1mSUE1c0UzZzg3RlFLM1RaMThuTWJaR2Y4YnNhL3NtMUtDbnh1d095TUJ2?=
 =?utf-8?Q?qevcAoKUpM76xxOKtfjXVRpodwqxiYcLJH8254XPzhQ0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B24079E86ECD542A1A576C81267D604@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85785188-b038-400e-573d-08dcaa330de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 09:45:43.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGQxaXU1kx1dpod5/uZZ0/NzAlPIIYdXBcg589t+zX5EvW0oOUvc+PiR6Ql5PFBXwGHnHsPQrzdkMzil8DNl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

T24gTW9uLCAyMDI0LTA3LTIyIGF0IDE1OjQ4ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBP
biBNb24sIEp1bCAyMiwgMjAyNCBhdCA5OjA24oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIHRoZSBmdW5jdGlvbiB0byBzdXBwb3J0IHNldHRpbmcg
dGhlIE1BQyBhZGRyZXNzLg0KPiA+IEZvciB2ZHBhL21seDUsIHRoZSBmdW5jdGlvbiB3aWxsIHVz
ZSBtbHg1X21wZnNfYWRkX21hYw0KPiA+IHRvIHNldCB0aGUgbWFjIGFkZHJlc3MNCj4gPiANCj4g
PiBUZXN0ZWQgaW4gQ29ubmVjdFgtNiBEeCBkZXZpY2UNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYw0KPiA+IGluZGV4IGVjZmMxNjE1MWQ2MS4uNDE1YjUyN2E5YzcyIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+IEBAIC0zNzg1LDEwICszNzg1
LDM1IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRfZGV2
ICp2X21kZXYsIHN0cnVjdCB2ZHBhX2RldmljZSAqDQo+ID4gICAgICAgICBkZXN0cm95X3dvcmtx
dWV1ZSh3cSk7DQo+ID4gICAgICAgICBtZ3RkZXYtPm5kZXYgPSBOVUxMOw0KPiA+ICB9DQo+ID4g
K3N0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9hdHRyKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21k
ZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNl
ICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHZk
cGFfZGV2X3NldF9jb25maWcgKmFkZF9jb25maWcpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0
ICpuZGV2Ow0KPiA+ICsgICAgICAgc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXY7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZpZzsNCj4gPiArICAgICAgIHN0cnVj
dCBtbHg1X2NvcmVfZGV2ICpwZm1kZXY7DQpSZXZlcnNlIHhtYXMgdHJlZT8NCg0KPiA+ICsgICAg
ICAgaW50IGVyciA9IC1FT1BOT1RTVVBQOw0KPiA+ICsNCj4gPiArICAgICAgIG12ZGV2ID0gdG9f
bXZkZXYoZGV2KTsNCj4gPiArICAgICAgIG5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7
DQo+ID4gKyAgICAgICBtZGV2ID0gbXZkZXYtPm1kZXY7DQo+ID4gKyAgICAgICBjb25maWcgPSAm
bmRldi0+Y29uZmlnOw0KPiA+ICsNCllvdSBzdGlsbCBuZWVkIHRvIHRha2UgdGhlIG5kZXYtPnJl
c2xvY2suDQoNCj4gPiArICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgKDEgPDwgVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBmbWRldiA9
IHBjaV9nZXRfZHJ2ZGF0YShwY2lfcGh5c2ZuKG1kZXYtPnBkZXYpKTsNCj4gPiArICAgICAgICAg
ICAgICAgZXJyID0gbWx4NV9tcGZzX2FkZF9tYWMocGZtZGV2LCBjb25maWctPm1hYyk7DQo+ID4g
KyAgICAgICAgICAgICAgIGlmICghZXJyKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG1l
bWNweShjb25maWctPm1hYywgYWRkX2NvbmZpZy0+bmV0Lm1hYywgRVRIX0FMRU4pOw0KV2hhdCBp
cyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3VyIHdoZW4gdGhlIGRldmljZSBpcyBpbiB1c2U/DQoNCj4g
PiArICAgICAgIH0NCj4gPiArICAgICAgIHJldHVybiBlcnI7DQo+IA0KPiBTaW1pbGFyIHRvIG5l
dCBzaW11bGF0b3IsIGhvdyBjb3VsZCBiZSBzZXJpYWxpemUgdGhlIG1vZGlmaWNhdGlvbiB0bw0K
PiBtYWMgYWRkcmVzczoNCj4gDQo+IDEpIGZyb20gdmRwYSB0b29sDQo+IDIpIHZpYSBjb250cm9s
IHZpcnRxdWV1ZQ0KPiANCj4gVGhhbmtzDQo+IA0KPiA+ICt9DQo+ID4gDQo+ID4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdmRwYV9tZ210ZGV2X29wcyBtZGV2X29wcyA9IHsNCj4gPiAgICAgICAgIC5k
ZXZfYWRkID0gbWx4NV92ZHBhX2Rldl9hZGQsDQo+ID4gICAgICAgICAuZGV2X2RlbCA9IG1seDVf
dmRwYV9kZXZfZGVsLA0KPiA+ICsgICAgICAgLmRldl9zZXRfYXR0ciA9IG1seDVfdmRwYV9zZXRf
YXR0ciwNCj4gPiAgfTsNCj4gPiANCj4gPiAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lk
IGlkX3RhYmxlW10gPSB7DQo+ID4gLS0NCj4gPiAyLjQ1LjANCj4gPiANCj4gDQpUaGFua3MsDQpE
cmFnb3MNCg==

