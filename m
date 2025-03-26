Return-Path: <netdev+bounces-177838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DEA72045
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADABD174AAD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885E1F55FB;
	Wed, 26 Mar 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="soqioAh9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE219D88B
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022633; cv=fail; b=nYMoiPzX1LgK78QAk0TwCNfEGMsZoQ4IgIfBYDcW5RTlrr4cTZB+uO+CiCw0P7haGuXttFXTd00XOenQuPyzZIAR7LWPT7oM6q+IbPi0dCD6IcSkSLd3EV0LzYX2ZGh4/qGwCxc6Mtpb/dl5Xz4sXLsf/+gtF2fUYy/fSHu9OpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022633; c=relaxed/simple;
	bh=TEm9a1zEDszXbzkZIEZUkQwQ0XnwP4kMb1bMdOaQ6pQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnWpoCU3i8wzAvHjp6BWYuBkzeL8m8b5QRkulBofoX23rpsrchyun1eX5X2jZYvjmiKgXmESO0uwthk2d28fStGvUlpVZs87+iY3rlaZNJRm0krKkbvKdOKCLi/tvmfQhk13AgKchRNQm37AL+qYwLph2t3yeg5gyNyCqIX53us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=soqioAh9; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XncfWEHaBU8Pc4X4zSesLbQT3RrQGZhOJMU28gTAgc4OOKHXVfWT6DgGXaKntSg1KXZTNND3yl80TSSipcSi1J2aQcnOD1Dy6RgxYV5RqiGFKiNIcBNBmT+2t+3c2dM7u+Utfgt5zGs+JwRlncKOHP07f0L1eUbSfxifwf+BA+e71YYB7NkHXW1znU/4eGcJmCWNBUUCvg8BCs94z7ZnvkUlL8TVk2yQsaiR+nsDnAL8oSshbaYM/et8wFPOjUXh0fhcoblXjVxqc0jKfuW6AzdXiGJA6WQMJAgicd9zvpKQQBvOsT1SGT5aeyPDIOGpTVlCF3kGf86xpZf96Bg9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEm9a1zEDszXbzkZIEZUkQwQ0XnwP4kMb1bMdOaQ6pQ=;
 b=DIGqmVFDzGAcux9QI8EfJNKXuTpXMGWponRDxK51dzezhr4vSc2tRmWC2T+gKkWRUzjwWFkN9ONMGEkTvfGPRf2iEl8gPFSGKE3FlBd28xJolYYEgmzXNOfCseqNsTWntLSyWqsXipqxGeHP4qMYVoKXOOZHVDBtzNG0QN+30m6nHusTSVMU19p3JQmMXbtdHObLtT7MPXvftOKYa4ODWXWpdtZ8ncjDAcI5CG32uVn5PGq1bNFRu8SmPby/4KvLiT0fqqPfVF9S0AlZLRtrAgTGNsx1/t8+jpX59k5H6YZsJ0/yQptOT6mcyYxGFqCkLdcboOcGgsu6IR1EuhT7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEm9a1zEDszXbzkZIEZUkQwQ0XnwP4kMb1bMdOaQ6pQ=;
 b=soqioAh9L0pN5G6Ys85d7dP4FTrb8r4NsRIeZGCVaTYsi9M+OCdVTJSzTjNv7myb/asnke5wV2XcwV70Na1Jz88BFv4fpSmsWEE9AKswFVqkLW0tvhOAUMP1RM2kX9DMCbZSVuCtnUHWIlrWJb77H0nmJJfnMvqiDXinlavTtGroV8lk6xlQLrPJg8AGZymAlDXzRzSejQzO4CPy9dG3Ksq0ZZni7dlHXRWjq+iUgIrAL1BrNoHzhFcKDC1bPCwIy2PkjYhcsQDAt6f4M+YaSOt4so6ubVYfeH/A9dVz/ypnkiT7xw0wmw06LpBm1WMmFYIeelYV88OQ1H85mauTNQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 20:57:09 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 20:57:09 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Topic: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Index: AQHbnc04GLropLE/UEietC5IV/U+Q7OFhLuAgAAF24CAAAOvAIAAJRWAgAA0UIA=
Date: Wed, 26 Mar 2025 20:57:08 +0000
Message-ID: <e7cbdbf24019ba5deac18ccf5eea770d4c641455.camel@nvidia.com>
References: <20250325213056.332902-1-sdf@fomichev.me>
	 <20250325213056.332902-3-sdf@fomichev.me>
	 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
	 <Z-QcD5BXD5mY3BA_@mini-arch>
	 <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
	 <Z-Q-QYvFvQG2usfv@mini-arch>
In-Reply-To: <Z-Q-QYvFvQG2usfv@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SJ5PPF1C7838BF6:EE_
x-ms-office365-filtering-correlation-id: 51221e1d-ad63-4d97-6713-08dd6ca8c5ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b24vM3pMZ1RyQzFUUmlacVd5WjZOU3MxQ2xJQ1pmSldVU1V2VkNJTzFZZzFo?=
 =?utf-8?B?TDZNTmRjS05rVmFXYWdpN1JFMXNnM1pPQSt0K3g2TGJlZDNVbzJSS1J4d2l6?=
 =?utf-8?B?YTljRVRTK1dqT0Z3bWNDeWNNM21ydzA4V2xOUTlBMi8wbmdqa3FUbnNHMXZq?=
 =?utf-8?B?V21DcUtZQ3RuQ2ZsZHZ0YjlJbGc2T09tRlo0SHcvQ0o3Wlo3Sm5VRHdOaWhp?=
 =?utf-8?B?SkY5TkZFQ0dmM1VscUlibGtvNU84RzJMcHhlL0FmcG5PbGRpSnBGNGZGdDlm?=
 =?utf-8?B?eTlraUZwK0pUWmIzMnB0WkVEWWdWYk84OVNjc3g5TEFqL0JqeXNwdUFDaExk?=
 =?utf-8?B?WCtQbXhkNkh1N2ZVZWRiY29PK3A3SVJUMmh2SGhZcytHNUxQbklEM1JQbmx5?=
 =?utf-8?B?aUZ1ZUo2YTRFZ28vWTVtOVVYT1lkWldpd012SldYOGpVZERQL2FTK2FoT1o4?=
 =?utf-8?B?T0dRN1JmcFAyUXZrZWZMcFRaZ2FHUlJyZVo0bDVQK0UyZFhvOGJ6S2hseFps?=
 =?utf-8?B?K3J2TzljeU4zMWhiV2t0a1pBaXRxUERlVTVIazlRS2xFbk1VY1VpOEtmODJi?=
 =?utf-8?B?MG5ydlZ4Ry93eUIrWGRNZmpjQU5QWG5UYzg1cDJRSWRxZ2RrckhzZ1NzTXpu?=
 =?utf-8?B?SmhQeU00WVRaNzdBTTZNelliaUtLUnFTc0JZeVZJTTBZVVNGaUhsUUFaODd0?=
 =?utf-8?B?QjR0VGtFc1ZlZlBHN2Y5V3EwZlBqVTArK1I0aE5QNjJTR1FxRDljWld0dHFS?=
 =?utf-8?B?TzJCWXZST0NJVWJBRDJ3cTQxQkpKWjgxOWlHcU9UNUNPWDYwbTVNQmxCa1lu?=
 =?utf-8?B?ZE1ybk5wc1hjcHBQbDFKQkZiNWFqWXV0ckVqZDVMRlFIMy9wUC80eDZpNE1n?=
 =?utf-8?B?ZGpNWWZ1eVY3enRhM2V5RVhRbGc4ZXJzbk03VFp0NzBvL1hXSFJPeHVpNTU4?=
 =?utf-8?B?UDIrQ2Q3aEVHcDQrS0VyWEEvTTh6ZDh2WjdnOGZqQURWOEZkeSs1alpkTnFv?=
 =?utf-8?B?Q2x0Y1F3S2U3UTFoNWJHeFdOZ3o5ZWcxLzcwSWk5eGlhZ1c0Q1A3a1BhR3pz?=
 =?utf-8?B?Lzgvb1dXN0IyTkZGL0JDYnI0dlZTOVFkVE9GR0c5cVFnd1Rpd0NEQUdWamI3?=
 =?utf-8?B?RjVldlBObzNwZytGWEtuTDZJMW9OeVhmdUZJV2lXK3pESmxSR1FEc2dpcHVm?=
 =?utf-8?B?Mk4wVDNjZzBHRk5YM3VzTEptbi9CSUluUU9XNlk2WGMxaEdydlNzR1BtcnZi?=
 =?utf-8?B?ZUNqc1k0TlFKNWcvK1hiRDNLakpKakpWWk5LN2hHYmM3RE1XOGhMU2lFbTFx?=
 =?utf-8?B?L21aa1UvTTlLMWh4a2FMRWhHUHNtNzFNZGpTTVBhSythMCt0RjN3UGlvcGVU?=
 =?utf-8?B?ZkNraGdVd1BMNk9PYWlheGlUektiN2hWSkIrd1RjNzVpWFlEUWZWMXRjZkpm?=
 =?utf-8?B?VlNuZUdxYTM5TVZVZllXZklrMEZqVzE2WGJSRkppUVFSelZhbjZwSGZpNlc1?=
 =?utf-8?B?Uk1QVFhSTWdjaVIzSWlqVm95TWtsYjhwbm1iZzBWUnZGZ0JqWjIvVjh2c3o0?=
 =?utf-8?B?NFUzMTNNV0FCcnFkY3dXbmhLQzZ3Znh4eE9DdFhrdFFaRlROSlRUVVMvblNn?=
 =?utf-8?B?Uk9NajVxakFIbHhmWHg4VzRuL2EwblJZZllnZFpzUW4zZitidy9JaDBsTCtD?=
 =?utf-8?B?QTZ2M29qbGlaeDB4WTdXMjdNY2RRTHd1V3pIdG5HajRWUFc2Ry92alNjNS90?=
 =?utf-8?B?dERhVHdMUkZWTnNBbDRZZHVkenpqSm44cHkvVEZJU3k4MVVVQzJ5QkJlbUYx?=
 =?utf-8?B?MGZQZEpsRVMzc1M1V2Z1bjh4YUl3UG51K2VxNlNUUGlmdVErV3hsZU1qUTFV?=
 =?utf-8?B?SnBhSEhTWUhkN2lUeGNNbmx2TTNyT1BLVU5Ed3ZnaXpkWFovTldtR1dBTHl4?=
 =?utf-8?Q?e+vpSWFtFuWSzOeMVbozLu3JTHla6bAB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnZLbFRPbnpZTjZEcFVhVWR2UVQyaUw5QzZZc3hNTkJKby9sWHZ3UWE3akhq?=
 =?utf-8?B?TXU5ZHVLTHN5aDEwUFhuOXo4azk4RkJobUxjQjNvMnc5NG1oVlNiTDNwUEhq?=
 =?utf-8?B?dys2N3pOZzdZazRjS2ZXbUcwSlA1c0Q1Qi9pMDlKdHJ2dHJOY0xaWk01bHBY?=
 =?utf-8?B?UWlnUFk5QS9xWCsyNk43RHVDVHZUcThXOEw0azc4bFdiUXU0M3FLY3VFalNC?=
 =?utf-8?B?TmxQYXdWZnJVNFVCYXBpUHM3M1JsUW53U1VsQU5wUHg2V0MvL0hBY2FjNGxX?=
 =?utf-8?B?OFl0WnI1aUlXbXFxMVdDT3c1MTEyZERNSFFNZkJBT2pCM0cxdFpXODBTWnhZ?=
 =?utf-8?B?N21KempObVNoY1p1NkRBZ25Ld0U1MHVUeTZvbkFBTy8vUzY4UnRNbEpPNnNI?=
 =?utf-8?B?U3JrN3VNZmplOXNjMTcrNnBvNlpURmFqV3ljN09MVkNOVlE4YlNEOTQ4RGNB?=
 =?utf-8?B?ZjVUYzljZk91RDhZR05wako0alRPMXl3RCtpdVlCaThWWGU0TEliS040bnND?=
 =?utf-8?B?YkRjZTlxS00rVU5jem9sS1dhREVaQlcwWVBBR2tIaXdmRzQ3akZqY09zN2VW?=
 =?utf-8?B?MUV5S3hobmxJUVNtbFQzVmhCM1BwK0lGWmk3NXZaYW5KTEt5THl3UTRpL1RM?=
 =?utf-8?B?VkhBUGNtSDJYSVczNW9va2RvdFJIakkxa3A0WWpKVFJGNURjTHgvZ2V1elFF?=
 =?utf-8?B?T05XbXJvem1SWENSYlQvbFJ5REdtV2o1MUlYcVh0cnRNQkpic1ppNlpKWWZx?=
 =?utf-8?B?SlZkZFQ2ZExqaEVUS1dYU1RsazJVbzFSYlVLVjRMYTJhZFRuRTFUUC80L0Vz?=
 =?utf-8?B?VzE2Vk84ZjhEcE85Rmc1Q3M5TCs1N2hHMW9iSUZqYmM1aWwyK21LMzRYeXJK?=
 =?utf-8?B?aEVvZjNJRVBtWDJKQmtPcGR6Z0Q0dUthM0k0eWs2Sk1lWnRRVFB4d2RKY2Fm?=
 =?utf-8?B?YjIzYnFvV2d5YU5lOWdCR1d1T3ZicHZMVVROM2MvNUJhaG01a2lqL1VjdTBp?=
 =?utf-8?B?azZhZ3VSZklUSTdnQkJwUG45bitkRkpVelJyYWtUSnVBWDlUL21TZjBibU1O?=
 =?utf-8?B?TEpyQWEvekcyQmsvZHo0K1grSjVkaStER0s1OWF2WWdWRnVLbEJhR0ZRRTBy?=
 =?utf-8?B?ZE8zQlYvQWNpVElLOEZjWWMvWlFmWEtJaGtnVCtxNjF0S05GSzVRWUljMWxo?=
 =?utf-8?B?YlAva2VKbDZFMStxR2E2ZVpaVlQzZ2F6TTZWSlhYbCtZRGR5UmJlVTJnaGpM?=
 =?utf-8?B?dnJtTnV0Y2p5QW8wbXowc2pNOFRGUHVDYlpnM0dkTkR1cjh6NVB0UW5HWGhT?=
 =?utf-8?B?aEt6TzgrWlpJTllJMzFuN25OaTRCUko4QXduUjBuLy9OSFpPM25JN3RoVkZ3?=
 =?utf-8?B?RWlUN2RDZFA5K1JmVTl4N2JVT1FxaitmZUpkL3BFa2QxakJlT0dTR0N2d3dm?=
 =?utf-8?B?ZHVLUExwK0p6RmdqOEwyOU13TDFpR3JxeTFMTFNGcytmSEdwSzk5elF1ZG1O?=
 =?utf-8?B?U29JNmhidElOSUxFUHFBdnZhUWNndXB5YWQ1TWtWOER6UHZTWmprSWVQWno4?=
 =?utf-8?B?Vm5ROE13cUMzOEZaTzVhMnBKMHZxWTY4Wm5oTWRmYThIcXFtZjNXc0JJRG83?=
 =?utf-8?B?OEFaUGM2cDg1N1Zmcm5kemprRnB1VlhHcE9EdGVRaHpYYmJBRGYvRlhiMXdT?=
 =?utf-8?B?Qy9XRWNCdllsSHlHZmUzaElpNWw3SVRCV0ttT0hRbTZaWm9FZnFQQmsvajhM?=
 =?utf-8?B?VGYzWHJEaGtzZldOaitMRm9IS2dDYUx2OUx6V1lXa3RpUWVONUl4dkZOd240?=
 =?utf-8?B?TnkvV1NJbHFWb25WbytPcWVPb2NMK28rM3RKRC95S3JqS1pYUXdQcitWZ0JP?=
 =?utf-8?B?UzE2bFJkZEk4MDVBQ2N6c251WTZ5VlNBOFFFK09aTE5jYTFiQmo4QXk3SFNk?=
 =?utf-8?B?ekhuZ3NQV1NnR0VaQ2l6MEZiUmVHdEhYWHN2azI1UVBPUlVnVjR0SmhVcDdH?=
 =?utf-8?B?Vy84Z0R6ZFdGR3h5ZlI2L0hONGc4QWdyRXRmSlozMG5YN0N3cDdOVlFSK0FB?=
 =?utf-8?B?cXlDaEplSHdiY3puTnlvOWtYRUd3Y1cwMkVuS1Q3US8rV2c2SkdaOWZCZVUw?=
 =?utf-8?Q?Ih8GNLeLu+2/rh30HZRY0ys9O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C7D411F3CE2B4EB3441E94EDA9942E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51221e1d-ad63-4d97-6713-08dd6ca8c5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 20:57:08.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J5Xw6JMG08RER/hWkgNByD/MJL2DtWM97W75sIhYLVDPnIONG1+W169z6Af99ZanyB+rT0JgJvrLDsUuBJFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDEwOjQ5IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDAzLzI2LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI1LTAz
LTI2IGF0IDA4OjIzIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6DQo+ID4gPiBAQCAt
MjAyOCw3ICsyMDI4LDcgQEAgaW50IHVucmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVyKHN0cnVj
dA0KPiA+ID4gbm90aWZpZXJfYmxvY2sgKm5iKQ0KPiA+ID4gwqANCj4gPiA+IMKgCWZvcl9lYWNo
X25ldChuZXQpIHsNCj4gPiA+IMKgCQlfX3J0bmxfbmV0X2xvY2sobmV0KTsNCj4gPiA+IC0JCWNh
bGxfbmV0ZGV2aWNlX3VucmVnaXN0ZXJfbmV0X25vdGlmaWVycyhuYiwgbmV0LA0KPiA+ID4gdHJ1
ZSk7DQo+ID4gPiArCQljYWxsX25ldGRldmljZV91bnJlZ2lzdGVyX25ldF9ub3RpZmllcnMobmIs
IG5ldCwNCj4gPiA+IE5VTEwpOw0KPiA+ID4gwqAJCV9fcnRubF9uZXRfdW5sb2NrKG5ldCk7DQo+
ID4gPiDCoAl9DQo+ID4gDQo+ID4gSSB0ZXN0ZWQuIFRoZSBkZWFkbG9jayBpcyBiYWNrIG5vdywg
YmVjYXVzZSBkZXYgIT0gTlVMTCBhbmQgaWYgdGhlDQo+ID4gbG9jaw0KPiA+IGlzIGhlbGQgKGxp
a2UgaW4gdGhlIGJlbG93IHN0YWNrKSwgdGhlIG11dGV4X2xvY2sgd2lsbCBiZSBhdHRlbXB0ZWQN
Cj4gPiBhZ2FpbjoNCj4gDQo+IEkgdGhpbmsgSSdtIG1pc3Npbmcgc29tZXRoaW5nLiBJbiB0aGlz
IGNhc2UgSSdtIG5vdCBzdXJlIHdoeSB0aGUNCj4gb3JpZ2luYWwNCj4gImZpeCIgd29ya2VkLg0K
DQpJIHdhcyBtaXNpbnRlcnByZXRpbmcgdGhlIHVucmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVy
LCBpdCdzIG5vdA0KcmVhY2hlZCBmcm9tIG5ldGlmX2NoYW5nZV9uZXRfbmFtZXNwYWNlLiBTb3Jy
eSBmb3IgdGhlIGNvbmZ1c2lvbi4NCg0KSXQgc2VlbXMgdGhpcyBpcyBub3QgYSBkZWFkbG9jayBi
eSByZWVudHJhbmNlLCBqdXN0IGxvY2tkZXAgc2VlaW5nIGENCipwb3RlbnRpYWwqIGRlYWRsb2Nr
IGJlY2F1c2UgdGhlIHR3byBsb2NrcyBoYXZlIHRoZSBzYW1lIGxvY2sgY2xhc3MuDQpBbmQgdGhl
b3JldGljYWxseSwgeW91IGNhbiBkZWFkbG9jayBpZiB0d28gY29uY3VycmVudA0KbmV0aWZfY2hh
bmdlX25ldF9uYW1lc3BhY2Ugb24gdHdvIGRpZmZlcmVudCBkZXZpY2VzIGF0dGVtcHQgdG8gbG9j
aw0KdGhpbmdzIGluIHRoZSB3cm9uZyBvcmRlci4gQWgsIHRoZSBqb3lzIG9mIGdyYW51bGFyIGxv
Y2tpbmcuLi4NCg0KQW0gSSBtaXNzaW5nIHNvbWUgbG9ja2luZyBhbm5vdGF0aW9uIHBhdGNoPyBB
IHF1aWNrIHNlYXJjaCBpbiBuZXQtbmV4dA0KdHVybmVkIG91dCBub3RoaW5nLg0KDQo+IFlvdSwg
cHJlc3VtYWJseSwgdXNlIG1seDU/IEFuZCB5b3UganVzdCBtb3ZlIHRoaXMgc2luZ2xlIGRldmlj
ZSBpbnRvDQo+IGEgbmV3IG5ldG5zPyBPciB0aGVyZSBpcyBhIGNvdXBsZSBvZiBvdGhlciBtbHg1
IGRldmljZXMgc3RpbGwgaGFuZ2luZw0KPiBpbg0KPiB0aGUgcm9vdCBuZXRucz8NCj4gDQo+IEkn
bGwgdHJ5IHRvIHRha2UgYSBsb29rIG1vcmUgYXQgcmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVy
X25ldCB1bmRlcg0KPiBtbHg1Li4NCg0KSSBzZWUgdGhlcmUgYXJlIHR3byBtbHg1LWV4Y2x1c2l2
ZSBmdW5jdGlvbnMsDQpyZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXJfbmV0IGFuZA0KcmVnaXN0
ZXJfbmV0ZGV2aWNlX25vdGlmaWVyX2Rldl9uZXQsIHdoaWNoIEknbSBub3QgeWV0IHRvbyBjbGVh
ciBob3cNCmFyZSB1c2VkLCBidXQgdGhvc2UgZG9uJ3QgY29tZSBpbnRvIHBsYXkgaGVyZS4NCg0K
Rm9yIG1vcmUgY29udGV4dDogSSdtIGFkZGluZyBzdXBwb3J0IGZvciB0aGUgbmV3IGxvY2tpbmcg
YmVoYXZpb3IgaW4NCm1seDUsIGFuZCBydW5uaW5nIG11bHRpcGxlIHRlc3RzIHdoaWNoIGFkZCBW
RnMgJiByZXByZXNlbnRvcnMgYW5kIHBsYXkNCndpdGggbmV0ZGV2cyAmIG5ldCBuYW1lc3BhY2Vz
IGluIGdlbmVyYWwuDQoNCkNvc21pbi4NCg0K

