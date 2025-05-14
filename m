Return-Path: <netdev+bounces-190570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D1AB7939
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBED7A444E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB82224892;
	Wed, 14 May 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="glk9J3Ne";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="YQNikG3u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB501B3956;
	Wed, 14 May 2025 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263183; cv=fail; b=IXJqqTrfiun49NSV4l5RS9IOt4okepP/fuVebU0bUH4kfYPo9FpVB9MUar79yACgSwhJnvDqCPkp/FiT7jqMYGPOk42w27hvjFpsBn4dJtqf2BAzaYXHd8DZiiqB+fjmJN/NuoDO6HrgqRJlkfiOTbrXTNAIAkdschvz1cqvK9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263183; c=relaxed/simple;
	bh=gS38eJhvafBV8BqprUUzI1XLqW+dCXtVzQTPg0iCIAM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QxJGmoeloZOovhGiozZ582flc/bB1NL5jC/RyGc3VWUKVRtqJhnuFw2jGI+4w4GVv1ZSlPKKLpoVDpBuPgIrdGB9r3eYDSGZy0yI+DZL4YFgXfoqWrtJkzidzkgyDMw5xpz5uDFG6QAQbtW7sV6C6wbxqOzeWUBhZ0B+SJotyXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=glk9J3Ne; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=YQNikG3u; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKvqNB007794;
	Wed, 14 May 2025 17:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=Anj5x1rKe8AKvLbOdo02CsFqJOjawnN0mNbgK7FMPZQ=; b=glk9J3Ne5/7I
	YGTXq95I3NbOGQKj8dXpgMpb9MyhAb9+MEBEpkkAU4Y8dJJTQ9r3PEUKMI66Yc8t
	IANDzngLQj4phz1czVHrTpjMfeuScX28FjkgCVG19Nn0kDKLPNFndZZ7auuMG+fu
	UgqtkD5mKHko/MmkOtq7f9A9Yzc06ZewzwXtW48BE7WSjIP5fJRGpp5rewJfRgYj
	2Us0nuPbGLZwn0TKdKlahgWc1RXpPvpO8ef7dK3rsDN0odbNgZL2tc6MfzrLdN3V
	5i3o6BE/qdO1qq7eTbNJj9idshlbMUn/r+n8gBh2Jb3W42DCloVifpGmg/lImtML
	y+Q3hnToNw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46mbchbdgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:52:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltA7ckuJDx85uoelD7C8G/eYlSJZ0mtiBhkTEj8IyGjVZME1cvXVaRlVq9wv9z+WJ4OXtauyjxgmmaXs/A2dbiCDNU50HNppD9kaDbAHhChvwqCz+eZwTaN3Z7MAiiC7ADC0sHCVFSogqLfFvjBct6OryvEwgCVYbfiPbVf71izHEGUuealKa9TtivRh8htPsPEfeHBnjcLYjuvkLClSx1ZpKO9xqrezIeGkuBj0WBrLmys1W4KgF91KcJ6blrmZQzac4vo2BG0UIo7B90KZj6B7u30hmIHpdJZVOmYIyqYyjh3d5D7hLFfkILfwBBCaGdA5X5mrODiGSYomKS1+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anj5x1rKe8AKvLbOdo02CsFqJOjawnN0mNbgK7FMPZQ=;
 b=BQ5zYFQxZSoqP8AhvaTMlY/0Vw4ajkRUaZFkmT1tYeGUbeLw45zQvI2C66aN7YuKhTHBNR9x61yZXRGLo/uE1t57fHAuHTQysBvgXOtbgbb3+fe0/poUnv+jqv5JKXEKLbdx64eS1+TlUZIWh8/GO0avkWuoAK0kOCLCvzpJhHZ0dyBBlXDE/SwV6NQBU7uAX3h1g77q0o9FRVPNtWg/wuVeseowXDfTFsiGuzAjHT1IF9yy25tc4u+Zn2er66IlDN9wpBNjA+C6ubAiwslkwDndsDCyNvGSskWVQeUSbbynEQzyX6bMkmUMUeAEIQjTl4FQg9kfEVCDoukBv99WBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anj5x1rKe8AKvLbOdo02CsFqJOjawnN0mNbgK7FMPZQ=;
 b=YQNikG3uttIFe5ft7EWArIO8GOqTmYDCArsCcRIiv0T2cW+70YvgUn6bB5GXZt9qWiknBASrsXhCIPA2UY3lGu5tXa4pxt1HQXliox7Ctcfcro7qzU11OA91LQ3fSWp+7DklpsjNKr3yUckokuTxF4QCJiB3F6H8CR/TL4uCA3I=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 22:52:30 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Wed, 14 May 2025
 22:52:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 May 2025 18:52:27 -0400
Message-Id: <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
        "Rob
 Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Silicon Labs Kernel Team"
 <linux-devel@silabs.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Johan
 Hovold" <johan@kernel.org>,
        "Alex Elder" <elder@kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <greybus-dev@lists.linaro.org>
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
From: =?utf-8?q?Damien_Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.20.1
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
In-Reply-To: <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
X-ClientProxiedBy: YT4PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::16) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 663e57d3-eb44-422a-f467-08dd933a0158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlFDbXF4andleGRYWEVsL1J1TXVocUVHTEpxTUZsMitmMVI5YTJhS0lvc09D?=
 =?utf-8?B?WTVLNFpIYzZsdkRkbHJycjd2ak9GZjZtWXVzcWE5L1dGR3d2cmtHS2IyMjll?=
 =?utf-8?B?Z25TY0VPVzg1dHJ3MkpGRE0xRFAyNDVucnd1V0ovWngwcTcrMjkxQk50WW5T?=
 =?utf-8?B?cmpud2FRRGVSRzR1eThYWFNhTXlSV0MxZTVtZEl0Q2FMMkFXaEw5Q1MvcGNv?=
 =?utf-8?B?MHJCMkxjdlRmNWZGTXpBUEE0Z2wvNDNHeDZtR2p2QnRmTk42dWxwRmlTTVNl?=
 =?utf-8?B?Yjdjc1NIRzR1UnN1aWdvcFZMVUVlalIvNFI3VFowTDdBeFNsTUtUb0Z5Y3hx?=
 =?utf-8?B?aTVtODBjakhXUVZQRlcyenpQYUMzQll1ZHpyZDNGdUczQUc2Njl2STFNMjYv?=
 =?utf-8?B?emJvSVdwQ1lzVEFtUkx6V3dMeDZSc1B2T2lac1Nqamp6VFFyQ1h5cTdCR3pO?=
 =?utf-8?B?dDl6RGFjWHM1SG5ITlByeERldWpxMEMzRGRmWjFoSXFGNVNQeWkvOVdkTTBL?=
 =?utf-8?B?bERLU1pmUFNIYm5iclBtVFgrSFpjVCtSUUw4Qjl1WG9hT1FvTmZqTlUwa1BH?=
 =?utf-8?B?ZGN4SURCTTNQTjVhekNRbWpSUUk5d21mNkxOOHprVG1GVEJacytGaEFiWG5p?=
 =?utf-8?B?ZDArbXorNngrYmVha284a3FsMm1ZYkVLeVAyQkxzcjE2b3Z0clU2YUszemx3?=
 =?utf-8?B?eFB0K1NjKzQzUXkvSER6SFYyR3FoZ0NTYVdvWWxla2RvNmllbzdKMzBSZnQ2?=
 =?utf-8?B?eTNmZVlMcTNrV3prNEUzbTkzdkdOVnVKdC84UkNjZWFkdGgwUmkxNUVlclgx?=
 =?utf-8?B?QWtwVUNyQy84ekVwUDVjVFhoeC90aUlPYjgrUCtKY2ZDYVQxTUpxODd1bmtT?=
 =?utf-8?B?c0F6RktQVWsrVkpHWEFaMkh6RDZWaHgzS0w3L3ZZS2o0UTcxZ2pFNk04WjRr?=
 =?utf-8?B?T3FMVVBlUFM3aFdrRzQxdEFENnprS2Q1bFM2UGY1ZE9CYTFTN08xMDRSdGRK?=
 =?utf-8?B?NzkvLzA2RVVhSXBTOXp4QjdyY001d3NFRDZhNzRZbUh3b2tsWFVqTzNpYnJq?=
 =?utf-8?B?TVRwWFRQSGtYd000bVhKNzZ4cEp1Q3JBQVAyYXljR29aelBncjl5UU4wYTJE?=
 =?utf-8?B?aDNuOUlnSFdBUUgvV21KYUk2K2R3ZUxqcHZhcXhPUkNYcllPVmVISmcycDRh?=
 =?utf-8?B?bzlyZTN4QmhmOVA2TzF3T3p1eHR2c1hCMUUzMGd5NUdiNzdCNG9xOEl4VzNa?=
 =?utf-8?B?Nmp2WGhBdVBUVjMzc0tZWWZ0WWNXcDM1MXd3S1lWQlpobmtYWkVoNFg3S2hi?=
 =?utf-8?B?Q0RnZ0tJcm9jaTV1cEp2UWxtcWt6UDNXOU5PTW00bmhTaEY0L1gvbytmOTZJ?=
 =?utf-8?B?b0RpZ0pKczNGLzlaSGw2TC9hV0FUS0ZLSEhHY1NSUEpNUGUya203dUhRaHNZ?=
 =?utf-8?B?TklHSDlnT0VFQUcvRnJVZ2czRkVRN29xNWhIL1NWbUtvZ1h6NTZYWTBrSHUz?=
 =?utf-8?B?Y0VwaVByb2ZDMDNmUnRxU1Nub1Uzdk1zcmdZNGNwNGF0elBkSzYxMTB2U042?=
 =?utf-8?B?ZE8zVTZkOElnakZHQk8veUZFVEdkRWwyMThzYllQd0FDZVI4U1RWZVRUQmpI?=
 =?utf-8?B?ZXZyRGh0UFl1aXp6TUF1UlNXQzYzdzcwQTFTMVk2V3VOQnArTzhTWThTU3Fu?=
 =?utf-8?B?aVZBT0pNdkdFa0dmdUZXWXdiN1FoVkJiNkRQc2xYN2xoUEVUR1liaHprYW1H?=
 =?utf-8?B?ZmhVVlE0RisxSlU1aW90VThhLzBXNFR1emcrbEcwRVlUaDJqVnpmWjFyWnNP?=
 =?utf-8?Q?7kRZftkXYiE6Y0wlwBqGDA7/wUGbPe/Y/wWEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QllXN1N6NVZzc28wQ2JUTlJKaW1QMThjNXdGenkzMjM3TWkyc3JlV1NPdUdB?=
 =?utf-8?B?eHhCYlBDVnhkcUxMSmI2NUlvSStEUHpZOUZKMUhYazJwdFVuQ0xWcHRHUEZP?=
 =?utf-8?B?Qmp6UmgzOXN5eU1hU0RvVnB0UFgwMk9TT2ZUWWJhU25KZ0R1UVV4MHJPYUh2?=
 =?utf-8?B?bnNGSTRpKzlyMEtMcXdTT1BFRDJlV210ZXMvT0lmTTNtREpCQzJhZmYxL2la?=
 =?utf-8?B?VVhsTWl3Z1VqNWc1bDFXVzgzT3RveXY5K0dWL0gzNVNaQmZncHNYdjlxbnhy?=
 =?utf-8?B?Wjk2UnNkVm1wNzlXZjFqZzZmVGVpRGxac1VYUVpoTUlBL1B3eVBKejBjVEFM?=
 =?utf-8?B?UGoraXBqVFp4V3J0M2NOZkpWS29LMWdXSzhvNVJFclhnbEdRYzZOU0syUnBl?=
 =?utf-8?B?dUN1MWV2RWptWkR5TGh4QlVTRGhhdVlLcnZBU3NnM2FQL0tpYS9OVkNaKzBx?=
 =?utf-8?B?Qk5FZEV6QTdCTW9zUEtyWnNMekI5S2x4cE9MWHVPMWZVMFVOQ0hNd3huWmFw?=
 =?utf-8?B?ODVUN0txQ2xUS050K1cyc1JoZVo5MDVWOXlUNmZ6aDN4dmRnakllKzZSWVRq?=
 =?utf-8?B?aUxZa09UTkd6TGx6WkFPWHF3S3BiVzhDblNranAwc1JwWElXS1h5OVlHZzIy?=
 =?utf-8?B?dnh2TGhza3lWdlVqQ3YxdGh3R3J5WnpWTTNFbVFFQnZWZE9tcHFsWjRBMGV2?=
 =?utf-8?B?ZjZnOW1pTHhXQUtKVHVGSXdvczQwcURqRjcrNWM2UFRhUElrSHRSZGZKMmc1?=
 =?utf-8?B?OGh4VFRTZFJUVDBkc1Z4ZHBubDdyajBURUZ5S1prcXUwNkVOeGVHRmlnWGJ6?=
 =?utf-8?B?NE9RMm1XQVJuWXp2dWNCNzIxSS9vV2ZZZU9oNmJ0TXpRdzIrTTR3MTcxWENW?=
 =?utf-8?B?T1lLbzA5RWk5eUl3eS92Q2tPRFJsQXF3NklJYXV2RzFzcVMwVCtzRkNKQWIv?=
 =?utf-8?B?UVl5UnFFZS9MSU1WcXVxenNxWm84SSsvTWlUb2FNYkxrS0c4dzA1bVlTQ1g4?=
 =?utf-8?B?WGZMSlc5eU4wWHVmdFRqNlBpRWZScHcwVXY0NURoemEyTzYyS25lcHRkblFG?=
 =?utf-8?B?alIzcWhzMnROVWFqdU1KUjJUUmVHcy8yOGV0N0gybjByRjNTL1o5T0hZV2hP?=
 =?utf-8?B?WGxhWmJEK2lNVzUvcVNmYVpLVnFpMmlWb0t2dnBmM0o0ZlFyWVV5cW9qQzhz?=
 =?utf-8?B?ZXdMeU1ma2U5TmlrdU40YWZRVTQwa0w1REo4VlNpQUhlNmxaQ1RiZzlYQ3pk?=
 =?utf-8?B?TG12aUtqSk4rdWQyTUxBaHM4OXVDeVNTOURZaWVlaFZsdzVMbk4rSlgvMnNo?=
 =?utf-8?B?SC8xK0xYcVAxS2xBUUY5TGc5eUNOcEZnUnZLcXRvTFZ1MWJ4MnFxc2s2dHlP?=
 =?utf-8?B?dkdYZUxrT0J6N2RoREZ0MnFWRXRweGVhYWw4ZlVsbWVZYko0VlRQbFdCQkUr?=
 =?utf-8?B?azduczJIUHF5MWUvdDdMdWFidWR2bm5oSlJpOWJ5cHlZd0s3RlZFbWRGZFB3?=
 =?utf-8?B?UHBwSG8xa0cyYUI4aGMyQTl4VnY3ckd5M0ZKOEl6NGJHZXFPQ2FaVGdWbGl1?=
 =?utf-8?B?bHpvRkF5VTBQcVpybjZjK1NtY2dXUm5iOVdqK0RPUEowQlJSVjV1cWlTVUJ4?=
 =?utf-8?B?WUhXS0pJR2dacDM1M3N1ei91UlRVMkpGcjV1TE1PdFNJeG5LbkJvd25xVXN0?=
 =?utf-8?B?c0RJcXBCQ0JTMXFXTUFsVm9rSDhrcW5HcEpKZWdqQlNvbDhnVDNRRURVWnk5?=
 =?utf-8?B?QlZsbjNZbHMwTXdwOTVtVU5sTXMwUUZnRm5RUjlleC8zU3doQzF3aU5Ccks3?=
 =?utf-8?B?WDEwaGdaTS85NkhISWp6ZGZqWkdiRTJYQ3ppY0d3VEU2b1hxNTg2OVNUc1Vo?=
 =?utf-8?B?TDVlSDdoOTd0eUQ4UGpnRG10b1JCdklUTUtDNHdud3dzRlhUcEdOUXFrTHZH?=
 =?utf-8?B?WTlwZUxpR21GTy8rT1lQRXp6L0Q2WElxNHNjWWdWWjlBclg1dXlkS3pJRzc3?=
 =?utf-8?B?K2U1bzNNRlJDQUJnNXJ3bTcwWGRiOW9UbVhUK2pSL01wNDkxSmx1RUhKVXNH?=
 =?utf-8?B?VjZjQU02cU9iL2FreWt6ek9MczJ6RFBrdVMzUnczUFk1VFMxVkh4NHBZTjha?=
 =?utf-8?Q?s9druGhhJSD9fvqfYflK3JiH5?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663e57d3-eb44-422a-f467-08dd933a0158
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 22:52:29.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7172PnRCd9hQ0EVtxlQSm8SVl4K4sY9Gwh38/97BIDPFtKxhELQVVSGFc0RLt+IL3sMagepoxjT80n9Wpm/dRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-Authority-Analysis: v=2.4 cv=F/NXdrhN c=1 sm=1 tr=0 ts=68251eb1 cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2Fbpa9VpAAAA:8 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=he6HX9ZFAAAA:8 a=yDwlCua-91CjlK4RLRkA:9 a=QEXdDO2ut3YA:10 a=AsRvB5IyE59LPD4syVNT:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=eoD0SFdJP40gRqS9aQkZ:22
X-Proofpoint-ORIG-GUID: Rl4bIL7Lz3PMcve-_cXbg8WORq1ECv5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDIxMiBTYWx0ZWRfXyHzhVFbkT63m +RX5VpcUDHlNXX6lgpadyijmbeIFQNBuS64eS02DuUFU2dvlwT7iSLI+fV5Rpo7ftcX7oni5sWo KO1Syhz979YWfeqUB6jT8r0ugOx6PMkb9f4+HPzyGVjYIpk92g5IWVD5Oziw1eYoKa7cIZnVxEk
 2SxWIKNP48vM/DHX/BzvIq40IBW4yNMX+Hu4CUWk0DAinDlj/RTN8oYJviq9G/c2clmoj9wjEzi ERVD+Khm/yzz0I+WF4xOhOD4LniEidFVhAuKU+4+COfrrRC7Nz4hBatBmPXQP5qJgMUW6qx6qll FKaTarzWX+u7cpTgropzCZHjC6A6h2oihvsi6NnBFFJvMzGmGd/cYsxEmtG21oHwquagTqZEql/
 6ZVplCBwV6TUG0+Rb9NMPxta5f4huyfxSGqkikWBtuBJn6u4p6Q0CbmcjXWzhxuOzoC1BR4+
X-Proofpoint-GUID: Rl4bIL7Lz3PMcve-_cXbg8WORq1ECv5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140212

On Tue May 13, 2025 at 5:53 PM EDT, Andrew Lunn wrote:
> On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Ri=C3=A9gel wrote:
>> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
>> > On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Ri=C3=A9gel wrote:
>> >> Hi,
>> >>
>> >>
>> >> This patchset brings initial support for Silicon Labs CPC protocol,
>> >> standing for Co-Processor Communication. This protocol is used by the
>> >> EFR32 Series [1]. These devices offer a variety for radio protocols,
>> >> such as Bluetooth, Z-Wave, Zigbee [2].
>> >
>> > Before we get too deep into the details of the patches, please could
>> > you do a compare/contrast to Greybus.
>>
>> Thank you for the prompt feedback on the RFC. We took a look at Greybus
>> in the past and it didn't seem to fit our needs. One of the main use
>> case that drove the development of CPC was to support WiFi (in
>> coexistence with other radio stacks) over SDIO, and get the maximum
>> throughput possible. We concluded that to achieve this we would need
>> packet aggregation, as sending one frame at a time over SDIO is
>> wasteful, and managing Radio Co-Processor available buffers, as sending
>> frames that the RCP is not able to process would degrade performance.
>>
>> Greybus don't seem to offer these capabilities. It seems to be more
>> geared towards implementing RPC, where the host would send a command,
>> and then wait for the device to execute it and to respond. For Greybus'
>> protocols that implement some "streaming" features like audio or video
>> capture, the data streams go to an I2S or CSI interface, but it doesn't
>> seem to go through a CPort. So it seems to act as a backbone to connect
>> CPorts together, but high-throughput transfers happen on other types of
>> links. CPC is more about moving data over a physical link, guaranteeing
>> ordered delivery and avoiding unnecessary transmissions if remote
>> doesn't have the resources, it's much lower level than Greybus.
>
> As is said, i don't know Greybus too well. I hope its Maintainers can
> comment on this.
>
>> > Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. But
>> > the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
>> > has support for these, although the code is current in staging. But
>> > for staging code, it is actually pretty good.
>>
>> I agree with you that the EFR32 is a general purpose SoC and exposing
>> all available peripherals would be great, but most customers buy it as
>> an RCP module with one or more radio stacks enabled, and that's the
>> situation we're trying to address. Maybe I introduced a framework with
>> custom bus, drivers and endpoints where it was unnecessary, the goal is
>> not to be super generic but only to support coexistence of our radio
>> stacks.
>
> This leads to my next problem.
>
> https://www.nordicsemi.com/-/media/Software-and-other-downloads/Product-B=
riefs/nRF5340-SoC-PB.pdf
> Nordic Semiconductor has what appears to be a similar device.
>
> https://www.microchip.com/en-us/products/wireless-connectivity/bluetooth-=
low-energy/microcontrollers
> Microchip has a similar device as well.
>
> https://www.ti.com/product/CC2674R10
> TI has a similar device.
>
> And maybe there are others?
>
> Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a TI
> CPC, and an ACME CPC?
>
> How do we end up with one implementation?
>
> Maybe Greybus does not currently support your streaming use case too
> well, but it is at least vendor neutral. Can it be extended for
> streaming?

I get the sentiment that we don't want every single vendor to push their
own protocols that are ever so slightly different. To be honest, I don't
know if Greybus can be extended for that use case, or if it's something
they are interested in supporting. I've subscribed to greybus-dev so
hopefully my email will get through this time (previous one is pending
approval).

Unfortunately, we're deep down the CPC road, especially on the firmware
side. Blame on me for not sending the RFC sooner and getting feedback
earlier, but if we have to massively change our course of action we need
some degree of confidence that this is a viable alternative for
achieving high-throughput for WiFi over SDIO. I would really value any
input from the Greybus folks on this.

> And maybe a dumb question... How do transfers get out of order over
> SPI and SDIO? If you look at the Open Alliance TC6 specification for
> Ethernet over SPI, it does not have any issues with ordering.

Sorry I wasn't very clear about that. Of course packets are sent in
order but several packets can be sent at once before being acknowledged
and we might detect CRC errors on one of these packets. CPC takes care
of only delivering valid packets, and packets that come after the one
with CRC error won't be delivered to upper layer until the faulty one is
retransmitted.

I took a look at the specification you mentioned and they completely
delegate that to upper layers:

    When transmit or receive frame bit errors are detected on the SPI,
    the retry of frames is performed by higher protocol layers that are
    beyond the scope of this specification. [1]

Our goal was to be agnostic of stacks on top of CPC and reliably
transmit frames. To give a bit of context, CPC was originally derived
from HDLC, which features detecting sequence gaps and retransmission. On
top of that, we've now added the mechanism I mentioned in previous
emails that throttle the host when the RCP is not ready to receive and
process frames on an endpoint.

[1] https://opensig.org/wp-content/uploads/2023/12/OPEN_Alliance_10BASET1x_=
MAC-PHY_Serial_Interface_V1.1.pdf (Section 7.3.1)

