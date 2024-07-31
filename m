Return-Path: <netdev+bounces-114407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ABA9426C2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B35B2250D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFC167DB7;
	Wed, 31 Jul 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SNmh5Sjb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0C166315
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407399; cv=fail; b=Ijofy0jq3DlKkN24bRSQqSNQ+QkKGmsEUHev4/XVqyHBysFHldNQb6umAqG8Sq0PJvLeTGKcWvBnW3yo4rttzE/tHw67U1Q2Fta/vR5t297MVu0dtHdtyTk2MTF3qGI2IhERNm2CpzrXcKVue8Q7S9b4fMY/7MyjKvZUY8hDLxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407399; c=relaxed/simple;
	bh=K52fZ2vKzR/Nku8O8XMvy/CS5Ao0GcYtDPNoWrX6RRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLIPM1mmb6Hc8BCkMc7edLel4cjq4Z5v7TJ+4xdZ57zHBUxgHKumONNfw2aaA8t9Pi8eBQL4XyAkPD9SvcutDs8pcQXA52u9GFySsJ+zUxaCa7QABvLieU/FFvonDCenjhQEvnlLy5GwJC0JDSbGKvOOaxwdgvItJJw6LqH1UwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SNmh5Sjb; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k368UL1gPQlXfa7GI1gbF0SfWuHshcCRT4wXLN6GGQ4xnU4enIBxnjlLkwghyG/csA9CAp6CH/LJNNlqvoQP2drjvCCXx1Y9iplNJ9bfiTajiSL6SKigjP/eaOxBGX5aiZRRubQc8eq3WJungzSiSuRCa7j7fC/Rmo4CCh0hvpGQqvXhXVdt4c8PcBXRmogIgq0JkPejFm//qL4dFrFQQuvr8WlaMsafTzGApELBSMi5G8oJLRvytIdq4DgEZbszZrA8ag+HuyVnsoIO9tNtZzvlOLvmkmQ8OWQKW2pFOXgi1zTgoIniHcHJJOO9+L4su90UeLbqkUCGXAOeA27zDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K52fZ2vKzR/Nku8O8XMvy/CS5Ao0GcYtDPNoWrX6RRk=;
 b=N/LVx7F2VLqvXZsnqzWIA7uomEfyVDiah8Rw2tfFvOYVNJ22AeMKRV1BkXjWu3PTV+TzA13YsvD42a033qzmiLgL8cbz1zvEGVMbRwRL2mA/HIuFJ/kvMsdhyZscJ6kEuuA49O/b1x2n92E0rlixtiBXZktvETRF3JPSgrNlXEiUZ6rHC1YMXG3pl6ZxjSrUDG9euSHjPJ/wdG32PYKBITkSX1avdOSN1aFC9iVXcm/xON0/x0LLS0I54y7VSTeLg8rJmF1MSb3LHUtXMtQ1eL2ClC8347QHgF9FAZS+kOe6avOJ02QN6iZogjs/R0Kkugr222GPBkDtNMjoLe9/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K52fZ2vKzR/Nku8O8XMvy/CS5Ao0GcYtDPNoWrX6RRk=;
 b=SNmh5SjbAS9YgVuCv6+BIc4BmorE3HYFO/EwIFc0kAkbz1PHphDcCQBkeIckyojmvhT5qQWDZMsliBPKrKr8E0M6/azYtpK075EJbxmq9Mp8GUevzfVDfcEh+5Ta3P6/M5BAaQ02xyyNE3oq7xTkpXw7tzFzNtaWIJ0LXyiOong+KUnnuwiNWKfogOE+dCmKaVgXYocCtgX7QBQKwTlnTMHykVJottFg8cCSK3FavDAiZ8bkyGSiC73MnUjZgjnpHoPzhLm0Z9MhaVQubv5UvEcxSZ9xyJELM0E9/s8YWRMkzvQHG0gt/PjX/cACTgrJ6vplI2yM5PT/sKmhH2E2yw==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:29:52 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%4]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 06:29:52 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"andy@greyhouse.net" <andy@greyhouse.net>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Leon Romanovsky <leonro@nvidia.com>, Gal Pressman <gal@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 4/4] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Topic: [PATCH net 4/4] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Index: AQHa4bVCDOptNlWnPEuONCEnX20S3bIPI6gAgAE/A4A=
Date: Wed, 31 Jul 2024 06:29:51 +0000
Message-ID: <e6ca706217ae4d5b89098ee700df12e42e879821.camel@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
	 <20240729124406.1824592-5-tariqt@nvidia.com>
	 <169992e9-7f5c-4d4e-bf7a-15c64084d9b9@redhat.com>
In-Reply-To: <169992e9-7f5c-4d4e-bf7a-15c64084d9b9@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: 91ed1fd2-e63f-4bfc-476f-08dcb12a2f54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TndwaHhXL1lnVDBsNG5RT2NUcE5PelZMbXEwT0RjM3R2THhLZDZZK0hleGUx?=
 =?utf-8?B?Q3VsMmRjVi9BNE0ydTZwT0lRT2JmcngvdXljL0xKYWluVHJMSC9Ock9kdzNV?=
 =?utf-8?B?bFl5bVZZVy8rL1BDS3l3UVhFZ1VkVGdYSkVEeG05eTRiMXIxRjVOSXZDTWZw?=
 =?utf-8?B?c0FrQXYzcDR0S2hkZHdNSHBQY3FWMHBTV3A3TjNUb1dkOVhUbTlHMGZ0OEZj?=
 =?utf-8?B?bHFBaUJTNDlLc3ROcXg1VHc3cTRVL1FPeHVla2tWY0JsOWpobmxlSTBlTkRx?=
 =?utf-8?B?T0pTaFZidit4dkp6Mi9SZ2g3MFUxVEhuK3dEbGR2YU13NDlEVVZSTUJ2c2Jq?=
 =?utf-8?B?aVBORHNtSjRxN2dDSDJZUUhnelV5RCsrUVkxRS9OSzFlMXJVRzh1MW01UmZO?=
 =?utf-8?B?bmwvREJKcUd0OFIxMUJNS09PZ1EwRGgxTnY0QUtaajdjT2FoNXo4c3I0Smh0?=
 =?utf-8?B?UkhjQ3pCTjZHdkpXaU9vcmJ0aVJFY0g2aDhBdXBXYjhMUndDNXpmOEhEbmQv?=
 =?utf-8?B?SUR2Y3dsS3ZwRTdJR2QzU0Y0ckhmNnQyUkkxMnRVaGtjUUZrMEthMWtPM3RK?=
 =?utf-8?B?dWQvT3VDMkxDenh3UnhLU2VwOFZscUxQTWIwZ09sKzlWeVNybGY2bTBGVnNG?=
 =?utf-8?B?Tk1PN1JxcFh4TUxkWFJUem5xWnNYTzZWUi8wQlhDOG5Md1k0TEJ4ZmhJU2NV?=
 =?utf-8?B?dTh6bU13N0xVRThQNmpNdlo2cjR4cDhlTFQ3N0J4N0dWZFFaZE1jUkhGSUdo?=
 =?utf-8?B?UHA3bEJieXlhc2NEL3ZuYThDNlFJalNrcU5wUHhMT0FiaWhLYW53ZnhBYmRy?=
 =?utf-8?B?L09abVVZL0VCS2VrVkZ6aERpb01hNi9XZ1hsK01kd2hpdTZtT1NSbzVqNDVn?=
 =?utf-8?B?QjFyN2JycFRRRjkrblF0eElpRGNDSXVZMnVMeUthYm9ZcW4wNjlpUGpvVXp6?=
 =?utf-8?B?SDcvZVVtWGRXQzAzbHNiMkNwK0JHTVRLc21rWGpyT1UxVmFBV3Voei9HQUhG?=
 =?utf-8?B?b1RxMi9xRk5EcWZRQWMvUHd5c2JFQnRNbHVzd0sxNWpyb0dDWFRvakJRK2F2?=
 =?utf-8?B?TmYvVHRHanNqRFhmZVRSQlhWbThIVlE2R1diQkh5c0pJVm1ISEt6WXVGdmJx?=
 =?utf-8?B?V2ptd0FxSHJUNUZ0UkZUdFRxUkl3MllPTTZWQkF6R1Fqc0xVY09rNmp1Mzdm?=
 =?utf-8?B?YkdXYitDSGl6UDVzOWlrZjlMWEhzamhwTmxSNCt1ckFwYXVDaVg2TDEzcE1Z?=
 =?utf-8?B?cGt5NE1MclZyQWxhc1lDbWZmQ05pcFZVb21tMmdHcGhlS2oxRkRNeFNxUFVz?=
 =?utf-8?B?d1B1NVhYUzN0YUxnNUNRaU1xZmZXRVhZV3pDTGZmVlF4S1FaSzZTQ3VaTVdT?=
 =?utf-8?B?VjBnVzhoVElQTEdXSVpPYjd4Tk95bVJ5QjdRZWRYWjFSVVZtQmNCOEFlTWtM?=
 =?utf-8?B?eWlrcUcxdGVZLzNTdzROd0xyNEFnczFmRmc3czg3U1NKWUVITXVkOEZtVjlC?=
 =?utf-8?B?SGluNVprM29IMlg1RWpPTHZpNnA5YUpKODI0TEFwSkp2cTdSMjVmVDAvckdT?=
 =?utf-8?B?SUJ2ZCtoTlZScnFGMTA5YTFIclp0d1AwMmkxYXZFbVFSbWkrVkdEaHRGcE9G?=
 =?utf-8?B?MENDdkRKZ2RkQUlsOXNtU3RqUEZVR2QxVFlDU1dCKy9ybEUvZVRid09NRjNa?=
 =?utf-8?B?RnRzTW5lSnVqcmVJSlVZUDdvWENRcEJYalUzWWsraGNvQmNMeCtrNXJlTkxs?=
 =?utf-8?B?UFNieGdtbEdnNzBISEp1WDRDeU9IUVBwb2tic3R3VTJTTVVDNzNsckVudTAv?=
 =?utf-8?B?N0dPM0NCU1V1RXFONFE1S3czODZXcUczemxJU3RNV0VJdTV5U1dJU3RZclBv?=
 =?utf-8?B?SU8xczBleHZqT0FlOUQzVzFnanV5dW1rdkM4ZHE3Z0FEL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFJtN1VxNzR3VVlMaXNWTGZJY09MNnVtU2o1bm0rbDRWczV4ZTA5dm9vRk5a?=
 =?utf-8?B?WUU4aC9wMHNEYW9ENTFSeFdXTXptejlQQ3pvNStITmJVeHk0SWptMVkxSHZk?=
 =?utf-8?B?Q1QvUGtiaysyN1ZETncvcmtCd0NIdkRBYzNKMTU0K3RIOVV3cEM3NkxGVkZT?=
 =?utf-8?B?MDFRVmY1RHRoYWNLcmFEbTBkS1pFL2tML3l1RzkyTFBaNmp4SHZCelZSS3I2?=
 =?utf-8?B?M2ptMWpBZzg5TGFWNUxadGJ6ZkVjK0FoMjREQnk3OFFJZmRQZmF1dUJOUTgz?=
 =?utf-8?B?ckQ4WFFXT0RYVFh0M3J4Uk9iOXNOWGplTXVnNWtxYktsMDdNUGw1YjViMG1I?=
 =?utf-8?B?QWRHaDRzd3hhUzVLelFYeC9LcnlZdmltRG1qQWRKdW1JYS96dG1TWEtWcnVw?=
 =?utf-8?B?L3dJWERMelRaQTc1TDB3SFJpNll6WUVqWVZFaXRISlBYZjRlVTJoaEdJOUlH?=
 =?utf-8?B?T2t6T1RJd3JqTkNQYUlEdmRzcS80Q1dHZ1c1UWVBOVhmNTBpV3BpU2hua0d5?=
 =?utf-8?B?dHlsWWpsU0hWWXJNWjZFQkVyVlhsZit6ZFpSRFBFVVdzRUxSOVNPTDA3T3FR?=
 =?utf-8?B?VmVVbnY3bmRvVGFsaE9scDQzbVhVM05PeXNadUprcWtpd0xZWXpSZnRCYnBl?=
 =?utf-8?B?eDVkanU2RjBIMmVxRW5KWWw2Qk5Mbkd3UUxKNGRKWHE2Sm9wTXZwVWdtTFV3?=
 =?utf-8?B?MmY1QS9JUmJtMzFNUEsxZU5nS1ZqQWdHVnQwbWx5MGs3RnB1c2V0TlljY01j?=
 =?utf-8?B?clN2d0FpOE83UlVoVXdVSmFKTTJxSlg0WGtqNXhUL1REOE9TRnpjK3FLM0I4?=
 =?utf-8?B?cm5idnhOWHVGa1k5ek1NYUF6bEwvcnhwZlRhWHBJODZMeDRmS2tTNm9va29B?=
 =?utf-8?B?MnhVV2NXYWJHY012TWlXd2VHaGMyRlYycG93QXhTcUtRMVg1NzlVejhCNnRT?=
 =?utf-8?B?Sk8xRFhIVmlUZjJKLysraVdKSFhtTzJzbEsrTUQ1azhieVUyeGllZk5Iek5Y?=
 =?utf-8?B?L0tqa1ZIWW9pQjBLYjRYcXRjaXd4ekN3V2RuL3dLdjBUNXZDWWZXMGhQTGRF?=
 =?utf-8?B?RzlmYzlzeXM1MDAvUXhDR1pPZjB2Ymg2K3J1MEtTQkRnSW5MRlhWaUF0WHR4?=
 =?utf-8?B?bHNOOGFCckpSaHpaVVFzWkN3ZGZsNXQvbWFvc3lkaGdBamdVRlFsc2hvenl3?=
 =?utf-8?B?dUpzTWtvTXkwSVZ3VW5pM05WL0JFbDRGWE5OUDc5RFB4Y2RnT0tVK29pNWNv?=
 =?utf-8?B?WFJzNWRiRG5nR2kyM0FMamFrMkZReWJOR2xhSVpST0ZzeFRkU2pNVkFpWHd6?=
 =?utf-8?B?NWk2R2xKYTFBc1plR2d4UVNwbTFnWk1ESG1ZdG1oWmZaQjRkU2ZJS0Qyakxv?=
 =?utf-8?B?N1lJOXBzZDVHRVFEUUhCL3F6dGtvZloxWkNLdUZ0M0ltTnJHdEZmWjA4UllZ?=
 =?utf-8?B?NjQwSmlDYmplNXkvVnJGTXcvQndONEdvdUNIelYwTlhyS1BDb0FpU2JjUHcw?=
 =?utf-8?B?UkFyUEZKeEhUeXhaMHltMEpDSXhXUjJpWTFRTDFkMmRXajZnT2JQMGxXS0Zz?=
 =?utf-8?B?UzhibEQwT3plTm5GRzAyTXRHTmZjd1ZIVmUweDFjZmY0RHFpNG9FSkhhOWxK?=
 =?utf-8?B?b2V1N0RTTG85RS8zRjJOR1ZyKzhhckVSOWVpV2JLQ1lIQWxtSmVHRWs1NUl3?=
 =?utf-8?B?c1RaWkFRZUkzMS9XVzk1c0VWT2xMS3lsaTBsSDZZNFJpOXVYOHZuTzRIaVdH?=
 =?utf-8?B?ZWpLc2ovL1YrS3VoK2J1NWpqeFgxNHcxdFVQV2dXcUJiVjJreXpJZVhpMGx6?=
 =?utf-8?B?b1V5ODN5ZUZzbnk1UnBPRk9EOHkvbkorVU5JeVYyM0tIbXBnYkNxYkltYTEx?=
 =?utf-8?B?NWpjbk9WV3plTWxHNlYyQWNZTkZrNE5RVlF2TTRveHk0ckFTa0RvdDRSN1Ix?=
 =?utf-8?B?c3lMNFAxa1lzVEpHUjl5Y3JxVlFnYUpmc3Y0aGlxNElKaDVsRUtIN3Q3VFFz?=
 =?utf-8?B?SCtMY0w4OXh6UlBSQ244WmRhZDF0Qkx1Nk9mcjUvb0ZBOC9VNnh2NVE2VzlH?=
 =?utf-8?B?TDVKTzlzbkpwcTZBVyt6Vzc2d0ttb3ZpN2dNZXk3T3ZydDVWazVXekJNaCsv?=
 =?utf-8?Q?lHZKspw8Wqb/4HNevKvZPuePC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0322116997D44B4CA7104DEA05AB69B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ed1fd2-e63f-4bfc-476f-08dcb12a2f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 06:29:52.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDKdr2/UyWfNU4SEmMkZWPkdI63h9VIUSqyWYJpT5Mfr577/uoZHVncgjIc9JG+Dh7ovGzUW+X4ZTcVvfxXjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

T24gVHVlLCAyMDI0LTA3LTMwIGF0IDEzOjI4ICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
DQo+IA0KPiBPbiA3LzI5LzI0IDE0OjQ0LCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+ID4gRnJvbTog
SmlhbmJvIExpdSA8amlhbmJvbEBudmlkaWEuY29tPg0KPiA+IA0KPiA+IEluIHRoZSBjaXRlZCBj
b21taXQsIGJvbmQtPmlwc2VjX2xvY2sgaXMgYWRkZWQgdG8gcHJvdGVjdA0KPiA+IGlwc2VjX2xp
c3QsDQo+ID4gaGVuY2UgeGRvX2Rldl9zdGF0ZV9hZGQgYW5kIHhkb19kZXZfc3RhdGVfZGVsZXRl
IGFyZSBjYWxsZWQgaW5zaWRlDQo+ID4gdGhpcyBsb2NrLiBBcyBpcHNlY19sb2NrIGlzIHNwaW4g
bG9jayBhbmQgc3VjaCB4ZnJtZGV2IG9wcyBtYXkNCj4gPiBzbGVlcCwNCj4gDQo+IG1pbm9yIG5p
dDogbWlzc2luZyAnYScgaGVyZSBeXg0KDQpPSywgdGhhbmtzLg0KDQo+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9i
b25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gaW5kZXggNzYzZDgwN2JlMzExLi5iY2VkMjk4MTM0Nzgg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gPiBAQCAtNDM5LDM4ICs0Mzks
MzMgQEAgc3RhdGljIGludCBib25kX2lwc2VjX2FkZF9zYShzdHJ1Y3QNCj4gPiB4ZnJtX3N0YXRl
ICp4cywNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfbG9jaygpOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqBib25kID0gbmV0ZGV2X3ByaXYoYm9uZF9kZXYpOw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqBzbGF2ZSA9IHJjdV9kZXJlZmVyZW5jZShib25kLT5jdXJyX2FjdGl2ZV9zbGF2ZSk7DQo+IA0K
PiBJcyBldmVuIHRoaXMgY2FsbGVyIGFsd2F5cyB1bmRlciBSVE5MIGxvY2s/IGlmIHNvIGl0IHdv
dWxkIGJlIGJldHRlciANCj4gcmVwbGFjZcKgIHJjdV9kZXJlZmVyZW5jZSgpIHdpdGggcnRubF9k
ZXJlZmVyZW5jZSgpIGFuZCBkcm9wIHRoZSByY3UgDQo+IGxvY2ssIHNvIGl0J3MgY2xlYXIgdGhh
dCByZWFsX2RldiBjYW4ndCBnbyBhd2F5IGhlcmUuDQo+IA0KPiBTaW1pbGFyIHF1ZXN0aW9uIGZv
ciBib25kX2lwc2VjX2RlbGV0ZV9zYSwgYmVsb3cuDQo+IA0KDQpObywgSSBkb24ndCB0aGluayB0
aGV5IGFyZSBjYWxsZWQgdW5kZXIgUlROTCBsb2NrLg0KDQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYg
KCFzbGF2ZSkgew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91
bmxvY2soKTsNCj4gPiArwqDCoMKgwqDCoMKgwqByZWFsX2RldiA9IHNsYXZlID8gc2xhdmUtPmRl
diA6IE5VTEw7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKCFyZWFsX2RldikNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRU5PREVWOw0KPiA+IC3CoMKgwqDCoMKgwqDCoH0NCj4gPiDCoCANCj4g
PiAtwqDCoMKgwqDCoMKgwqByZWFsX2RldiA9IHNsYXZlLT5kZXY7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoGlmICghcmVhbF9kZXYtPnhmcm1kZXZfb3BzIHx8DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAhcmVhbF9kZXYtPnhmcm1kZXZfb3BzLT54ZG9fZGV2X3N0YXRlX2FkZCB8fA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0aWZfaXNfYm9uZF9tYXN0ZXIocmVhbF9kZXYpKSB7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBOTF9TRVRfRVJSX01TR19NT0QoZXh0
YWNrLCAiU2xhdmUgZG9lcyBub3Qgc3VwcG9ydA0KPiA+IGlwc2VjIG9mZmxvYWQiKTsNCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgfQ0KPiA+IMKgIA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpcHNlYyA9IGttYWxsb2Mo
c2l6ZW9mKCppcHNlYyksIEdGUF9BVE9NSUMpOw0KPiANCj4gSSBndWVzcyBhdCB0aGlzIHBvaW50
IHlvdSBjYW4gdXNlIEdGUF9LRVJORUwgaGVyZS4NCj4gDQoNCkdvb2QgcG9pbnQsIHRoYW5rcy4N
Cg0KPiBbLi4uXQ0KPiA+IEBAIC00ODIsMzQgKzQ3Nyw0NCBAQCBzdGF0aWMgdm9pZCBib25kX2lw
c2VjX2FkZF9zYV9hbGwoc3RydWN0DQo+ID4gYm9uZGluZyAqYm9uZCkNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHNsYXZlICpzbGF2ZTsNCj4gPiDCoCANCj4gPiDCoMKgwqDCoMKgwqDCoMKg
cmN1X3JlYWRfbG9jaygpOw0KPiA+IC3CoMKgwqDCoMKgwqDCoHNsYXZlID0gcmN1X2RlcmVmZXJl
bmNlKGJvbmQtPmN1cnJfYWN0aXZlX3NsYXZlKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXNs
YXZlKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gPiAr
wqDCoMKgwqDCoMKgwqBzbGF2ZSA9IHJ0bmxfZGVyZWZlcmVuY2UoYm9uZC0+Y3Vycl9hY3RpdmVf
c2xhdmUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJlYWxfZGV2ID0gc2xhdmUgPyBzbGF2ZS0+ZGV2
IDogTlVMTDsNCj4gPiArwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91bmxvY2soKTsNCj4gDQo+IFlv
dSBjYW4gZHJvcCB0aGUgcmN1IHJlYWQgbG9jay91bmxvY2sgaGVyZS4NCg0KWWVzLCBJIHdpbGwg
ZHJvcCByY3UgcmVhZCBsb2NrL3VubG9jayBmb3IgdGhlc2UgNCBmdW5jdGlvbnMuDQoNCj4gDQo+
IFsuLi5dDQo+ID4gQEAgLTU2OSwxNCArNTc0LDEzIEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNf
ZGVsX3NhX2FsbChzdHJ1Y3QNCj4gPiBib25kaW5nICpib25kKQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3Qgc2xhdmUgKnNsYXZlOw0KPiA+IMKgIA0KPiA+IMKgwqDCoMKgwqDCoMKgwqByY3Vf
cmVhZF9sb2NrKCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgc2xhdmUgPSByY3VfZGVyZWZlcmVuY2Uo
Ym9uZC0+Y3Vycl9hY3RpdmVfc2xhdmUpOw0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmICghc2xhdmUp
IHsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgc2xhdmUgPSBydG5sX2RlcmVmZXJlbmNlKGJvbmQtPmN1cnJf
YWN0aXZlX3NsYXZlKTsNCj4gPiArwqDCoMKgwqDCoMKgwqByZWFsX2RldiA9IHNsYXZlID8gc2xh
dmUtPmRldiA6IE5VTEw7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7DQo+
IA0KPiBTYW1lIGhlcmUuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KPiANCg0K

