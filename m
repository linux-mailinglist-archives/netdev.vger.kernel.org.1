Return-Path: <netdev+bounces-155491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39601A027FA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A816114D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82023A6;
	Mon,  6 Jan 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ubIUvkev"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010001.outbound.protection.outlook.com [52.103.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C311DDA3C;
	Mon,  6 Jan 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173739; cv=fail; b=F3gm4ftdAd37Qo82/Jqbwr27Tt1ucCrnLD4YTwjTehq2ox4qUStEENkpdBVBGJRp5d6fgolE2oDM8Tr1VzQGuG4PkHZsBX+Ig5FJUhqoLLUu3zV/78y4zRe7OI5fo8ezTlwKAEWSeyiOsZ19p+N4jeuuUGpkSVa5UyAiiFwQwTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173739; c=relaxed/simple;
	bh=xpWYYSeS827bA5bX7ruzFDICArspEj09QqYEFBNcxxY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klOZ4AK8K+kgLrlCsKjRtxo7J8pvRSb+V0IdxCztE390RkrIKyoq8tMlwgc7UFyVXC2MVxFEr5re1neUNNL+nlZU6Xkn255LNPgeQVTjMmKz12p8kBiKCjJK9/TrgdKmjzMBiMldXt7K6yZ8/QRP1cZsqBYjxk3Mc7tJYIjmv+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ubIUvkev; arc=fail smtp.client-ip=52.103.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP2ZcrcD9Q2CtOJZsciJTDLdxiksZYAiRERvvw3OMrhBMs+bW5NviznKaIXgFm/6HFlJkT0fMo8BIh9hfIQCvmkJm016tdl70ZUHWU6UWKZwbiQdJzv56sAltk9phBy8A2ykPdSO3fP9/b0WZOQ/fFNn+J1yL1W+ocs8xqQ7Zd3dtz3k3qbQTljXk+o/iVe1x0SRdUQQl/EMGv4UwRODjFoCh8F2/+nWLc5gXhQ87GXDK5Jjf3yUYB6u+mQhZ7KYwRBq7Cdt1Vg4ovsUESs4d1FmKn+srDsc+G1IEPSWBm653f+TiM/pA4LVjsNSqMEfUrWn1bTMf2M8g60JKEYmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpWYYSeS827bA5bX7ruzFDICArspEj09QqYEFBNcxxY=;
 b=mRV6lMrVuZF8NmPhl+glJW5gdXL15SIB3YmGHZV33LN9pW7ABR5Ydke3d/u4a9oS5mIcIYYzfps+SsvPCBhSCoIfZOO3YulDXdznk4o2WYX8XxLiV4/GsthzKlxqiuVItsybvekDc8msDPHDHcul+jMIf8ioxfopMVCgUQbG+2wQ9pKkFbZe3mhWLpBibP3daxm9nDiVYC3eLAOe4uooE3ZLd640QLeQ+cda03N9KR8jDdeMmYde8JtenWwy8uPCsLCvmKHzRcnekNO1F/jBw73pDfDTN5Yw4E17A1Mo+kiqiBwKSzQsC/gd4hRbvwYaT1at5OvJp6fEOwEqznROGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpWYYSeS827bA5bX7ruzFDICArspEj09QqYEFBNcxxY=;
 b=ubIUvkevZn3aNrr8lHmvn4WIlrfU8j/Jl9kMajQ4Ugl+U+Us5FUI0OmHidJOUApQnXvtGUJ9TCEatGU9HuJ9JXkwo332RzNCIQdaZnDO/hyjGDx99yfaHPQokvqvrY+7iG2NCmdTCDJKjc4dkS73ZkbR3ER/K1hWn4/UtU0wIufhWVUTPy5gcz5lzZPos+r0qlmRBUWFWHth+dryFrBUP31CbBBDttnoY4Y0yqJBdqeWADF7QaoPQWWwsI2PVi00IXAx23lT0ey4iXk4OmLxoloxaRi/GuONkogHb+rPEJtNx7Ik7xbQo0J7tahaRJTpXXUon4MBu3EHlBgCRh0VTQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TY4PR01MB14738.jpnprd01.prod.outlook.com (2603:1096:405:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 14:28:51 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 14:28:51 +0000
Message-ID:
 <TYCPR01MB8437EC132CBC033368FC40A998102@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Mon, 6 Jan 2025 22:28:46 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Daniel Golle <daniel@makrotopia.org>,
 Joe Damato <jdamato@fastly.com>, sr@denx.de
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
To: Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240729183038.1959-2-eladwf@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qdadlHnaNWHLFeN8pNbop7ZB"
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <8444f1a1-57d3-4e44-a634-cdcf31ae86b9@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TY4PR01MB14738:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae0de1-757f-4e0c-412c-08dd2e5e70ac
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|8060799006|6092099012|5072599009|461199028|19110799003|13095399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2hiMTFmRVJXZ1hJL2IrZzhQd2ZMajBONHBBUXpoR0ZUVlFiREtKL3dnMWk4?=
 =?utf-8?B?ZlNuKy8zeWtuRGsyZ2VNckErdnZSa0kyN2NYR2FjWEhBa2w3RTRuemlBWjBh?=
 =?utf-8?B?N01JMjRsQU4yRElKQjhqWEhxSFllL0NCRXVMZVozS1REU1ZDOEJrMFpNSHRi?=
 =?utf-8?B?MEhPRk5WSGVmMWhySUg2Q0E1ZU03UHJEeEt1MnZLd0QxYStPWmRwUUJLdGk1?=
 =?utf-8?B?bUxNbzl6OVhxclFRMlF2ZlNFVTBFRXc4SHMvYVNKZDVjc3YyclZMZjNiazZx?=
 =?utf-8?B?SzE3Tk8xZUNzUkFBWUlvbGVOUXhzTWc5dE5OUmduMEtudWYwWU1OQllTOUpi?=
 =?utf-8?B?akFqbkYwMEx0UkpQVisvSTVjYnFJTFpoUlRrWnpFQ2lDcFRnZUhERFNqNUlK?=
 =?utf-8?B?dytONFhnWHNqdGZCY0lqSFhjYnJWbjVUUnlzT1Q0T2N2ZnBUZ29PWitIeFV0?=
 =?utf-8?B?eStrTnVycW9jb252ZEVaalN2dkF2N21vVGh5ZVFDUXFlaTFpdEF4WmVJWkM3?=
 =?utf-8?B?M1p5cUlPaVpZNFBuM1hJcGQ4WWQ4QTF5U2ZhbDlFOURSQk5DRVMrRnRnd08r?=
 =?utf-8?B?VmNWR1lMbFgraHU4MWVJVkx0UFVkUkVpQTRpYzJ4UWsvNmxQVjYrRHpQRmkx?=
 =?utf-8?B?dDdhWi9nSFcxaGtHT3FWTU5WK2R4d3Vub2RwTjVZSk9DUHlUQ3JycjlobVBp?=
 =?utf-8?B?US9yRXo5MGZwL01ieC9PR0xsVXlaTXgzRzA5bEZ5Y1RaQm9oY0VqTTRscUZz?=
 =?utf-8?B?QVZ4Z2NWRjQ0ZEJVRlhma2RoWlJUSk9UdXFvbXRZTXhHYlA1Ky9zdzdETEpt?=
 =?utf-8?B?T21UOVJBVUI3S2tlSVBDUVBaZ0RXNVluazNFM0paazYxck1jTDhLZFNmQlFS?=
 =?utf-8?B?b0NxbHAxRGV5bE1xUkNrbnk3aE1rOEp3TnJ3Y25Ucno5ZTFwTnVJK2FJUEta?=
 =?utf-8?B?b2RicmtmL2w5UDdqam5SY0gzbGVITnhkZ0xrbmNNOGtpU2JETHhWZndGblRk?=
 =?utf-8?B?QkZtUC9IZWpDRWJmM00xT3Rsa092cTlkazJ3Z2M1QXZEVHk4RlZudW12T0g0?=
 =?utf-8?B?eGt0akZ1Wk91ZjFCaDNsM1VDYlZtRVdNZWs5bGF6VVVRT2NxaG5vQ2lxSk9k?=
 =?utf-8?B?QjNSakdGa2hpaCtWTVZTMXRPaFpEUjgvTTE4NEgwZVJpSisyMWhOZnM1L2Yz?=
 =?utf-8?B?YTNJZnZDckR6czVYeG5WR092bm8rZFc5UHhyL0lGclhpMjlDcjRkZ2l1NTRD?=
 =?utf-8?B?cW1uKzdoZTJnNFZMOTE4OEpaOHpCU000VTlVYWJJNll5c3ZkQzd4TG85R0pT?=
 =?utf-8?B?c1JDbmd5M21kSllqV2tpbGRmNEoxaExNUGozYXJ5NUhub3N3MU9jeDlodjFH?=
 =?utf-8?B?TWZiNFJGYjA0c1poUG1aRVVEc0dOQzErWjNIRlNvdy9FK2xxZ0JCUnlwU2NM?=
 =?utf-8?B?NE5yQkxJeU5rZVRxTy9MVndMVHdEYlM4aWwzeW84WkMrTE9DYUJYQUd1UjVn?=
 =?utf-8?B?Q0dIVTVKVFRQa0RJRjA1dWcvYjdkZkpuWUJhU0l6b3dLdmhUOXVlamJpODhE?=
 =?utf-8?Q?PqaFeqRa310mNdeG57H8Jm3BQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpOUWs2MVREbllkRTlLUGdxcDFsZHVvM2JBL0o2Rjd3MWV4aDN6V25tN05X?=
 =?utf-8?B?L3hzZ2Vkb0RIOHRsU2h5QmxyOHc3NFlEOWdVNTkvdFNFUGZDdEpsMHg1SFU5?=
 =?utf-8?B?NHVUQkVPN1RSNjYrakVybGtLR0JReVRLSWVPd1ErUzFQeTBiTVRkQ1FPb29O?=
 =?utf-8?B?ZE1qQkFCRGhvUHFxU3c4QmlUcmNoL2dFcE9RNWZSbzRrWGdOSWU3clFyNmZl?=
 =?utf-8?B?eDdHZWNOODlWYnB5Y01xM2laU2piMDk5Ym9GYVpYYmJYM3FPTWlabTR2aC9h?=
 =?utf-8?B?NUZjK2t0VktiVDRXYTB6a1laOGRpYlpZL2t6NCtzUnBTOXpZNGVUN1RHTzZt?=
 =?utf-8?B?YTVJZjhvYmp0dEhHNjAyYTNxZjhJakpxdlM4WU1IcXNueXdTTU9mbTNNTnFw?=
 =?utf-8?B?eVdiNlZ6cHdQUUFaL2tzSGcyemUyZU9PZmJac2l1V0k5eEhEaUg2SSthWUVP?=
 =?utf-8?B?N0JFd1ZBZE9oL1ZTNlVweitQV21KelBKRUxNS20wTEI1aGIwcy9qTndTblh6?=
 =?utf-8?B?T3Y4UUp5MmYxMkU5NVFQa0FwNUdnK0Iyanp1N2loK2NNN0RQNjdOZVN4Y2RX?=
 =?utf-8?B?ZjNlUkNucEU0MEJ0Zi9tODNhUlc5MVB1aHVxaXdxSFprWGZXV0EzSUdIZUNa?=
 =?utf-8?B?WjZDcHA3Rkc3enJOSzRQdWZMOURYV25nMi9GWFBaZExVMUdGbGNHclZ3NkJn?=
 =?utf-8?B?MHAyZElPTTdIamJkVHJOWFpjSkFHdE1ZRjNCQzNuSWsvd2RKc0RhbkhvTXND?=
 =?utf-8?B?VWVWemJZdGR1QXFsQmdDYncrc0grM2ZqOHdvMWhad1h3U2NEZWJUT28wcmc3?=
 =?utf-8?B?Y1NZMTd4WHZhc01RMkhyaGNoQ3d2TWRWa09JUkN1cXM2ZmpMeXF6TDZHV2Zy?=
 =?utf-8?B?RHFTZkFKUTczWitqNWpsRnBJcXJUR3NrbmY2VHdQQkphaWhzYXE0eXQ3cTdD?=
 =?utf-8?B?eEowdWtZMFVKOEUwZXN0M1UxWVZCR053azY4S3Z0cmRKVHJVajZuYnJZcE5q?=
 =?utf-8?B?YWdGUmQ4bUpScEcrMHdBN2hNU3haUFkxQVprVmN2Y2FoVWNZTThIWk1GcGNG?=
 =?utf-8?B?S2tSMGlpUkkraldvV1ZzeE5EWmZZMmNhT2Iwdm1FQU9WUW9jL2lnUmdKRXh4?=
 =?utf-8?B?dy91Sy95SDRUWStoOGpTb1ZTVW1lZTJEeW9UMTdkTzRDUGo4K1lGSEhTdEdh?=
 =?utf-8?B?M2VaQnJQdG9naXp1Snd6MWFQMXlwM1hhM1JvTFFVR3hDM0xiV3Z2R1NwSFB6?=
 =?utf-8?B?bnJBSWVyRVlkMmNTTUMwbEs2bmkxdmFaUHUxMDI5bnRtaGNWMXR4RXhMUmdR?=
 =?utf-8?B?Zk5mUWxvQ28vcjkzRlN1eHlQc1pPRlo1SGt2cW1rTExsMkVRVzRVWWRZOEYv?=
 =?utf-8?B?aU81NmkvbHljSUlYYkNiM2hZdkNISFAwMHplQlNIcWRtNnF2TDhCcmZrVlhi?=
 =?utf-8?B?amdaY1VoSHhpWlppa1dXNGdBMnkvazB1VWpVNUhlVjUrRUhyU21sMHJQY0xS?=
 =?utf-8?B?dDFBM3ZpNCtpYkI4bytjOUNYMUdqSFdvRVNCaUtOQWtJUjdKYytvdXB6VXoy?=
 =?utf-8?B?WllwRThsTU1XdmM2UXBsWUdJeUwwT0Exb3FrV1FnNm1EZDBJbEpPMk5ES2Zu?=
 =?utf-8?B?VVdKY2tWWXBDNzlqbUl5QitsbHRKUDAyTVhOZFo3d2lqVC9UNXJRUjJ5NHBk?=
 =?utf-8?B?dXZVKy9XQzVFMlFvZ2Z5RWh4UDR6ZjJkWVZrUFdBeDFBUGQ5OVBhcFB6OTZu?=
 =?utf-8?Q?4DESC9w80PnAkkYAhk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae0de1-757f-4e0c-412c-08dd2e5e70ac
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 14:28:51.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14738

--------------qdadlHnaNWHLFeN8pNbop7ZB
Content-Type: multipart/mixed; boundary="------------T1EUld1B31zWAtIRFq0wOfrh";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: wiagn233@outlook.com, Daniel Golle <daniel@makrotopia.org>,
 Joe Damato <jdamato@fastly.com>, sr@denx.de
Message-ID: <8444f1a1-57d3-4e44-a634-cdcf31ae86b9@outlook.com>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
In-Reply-To: <20240729183038.1959-2-eladwf@gmail.com>

--------------T1EUld1B31zWAtIRFq0wOfrh
Content-Type: multipart/mixed; boundary="------------6FILCNDdDTwHcnvbT8By3N0F"

--------------6FILCNDdDTwHcnvbT8By3N0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNClNvcnJ5IHRvIGJvdGhlciwgYnV0IHdoYXQgaGFwcGVuZWQgdG8gdGhpcyBw
YXRjaD8gSXMgaXQgZ2l2ZW4gdXAgb3INCnNvbWV0aGluZz8NCg0KQmVzdCByZWdhcmRzLA0K
U2hlbmd5dQ0KDQrlnKggMjAyNC83LzMwIDI6MjksIEVsYWQgWWlmZWUg5YaZ6YGTOg0KPiBV
dGlsaXplIGtlcm5lbCBwcmVmZXRjaCBtZXRob2RzIGZvciBmYXN0ZXIgY2FjaGUgbGluZSBh
Y2Nlc3MuDQo+IFRoaXMgY2hhbmdlIGJvb3N0cyBkcml2ZXIgcGVyZm9ybWFuY2UsDQo+IGFs
bG93aW5nIHRoZSBDUFUgdG8gaGFuZGxlIGFib3V0IDUlIG1vcmUgcGFja2V0cy9zZWMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbGFkIFlpZmVlIDxlbGFkd2ZAZ21haWwuY29tPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gCS0gdXNlIG5ldF9wcmVmZXRjaHcgYXMgc3VnZ2Vz
dGVkIGJ5IEpvZSBEYW1hdG8NCj4gCS0gYWRkIChORVRfU0tCX1BBRCArIGV0aC0+aXBfYWxp
Z24pIG9mZnNldCB0byBwcmVmZXRjaGVkIGRhdGENCj4gCS0gdXNlIGV0aC0+aXBfYWxpZ24g
aW5zdGVhZCBvZiBORVRfSVBfQUxJR04gYXMgaXQgY291bGQgYmUgMCwNCj4gCWRlcGVuZGlu
ZyBvbiB0aGUgcGxhdGZvcm0NCj4gLS0tDQo+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVk
aWF0ZWsvbXRrX2V0aF9zb2MuYyB8IDggKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX2V0aF9zb2MuYyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMNCj4gaW5kZXggMTZjYTQyN2NmNGMz
Li40ZDAwNTJkYmUzZjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
ZGlhdGVrL210a19ldGhfc29jLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVk
aWF0ZWsvbXRrX2V0aF9zb2MuYw0KPiBAQCAtMTk2Myw2ICsxOTYzLDcgQEAgc3RhdGljIHUz
MiBtdGtfeGRwX3J1bihzdHJ1Y3QgbXRrX2V0aCAqZXRoLCBzdHJ1Y3QgbXRrX3J4X3Jpbmcg
KnJpbmcsDQo+ICAgCWlmICghcHJvZykNCj4gICAJCWdvdG8gb3V0Ow0KPiAgIA0KPiArCW5l
dF9wcmVmZXRjaHcoeGRwLT5kYXRhX2hhcmRfc3RhcnQpOw0KPiAgIAlhY3QgPSBicGZfcHJv
Z19ydW5feGRwKHByb2csIHhkcCk7DQo+ICAgCXN3aXRjaCAoYWN0KSB7DQo+ICAgCWNhc2Ug
WERQX1BBU1M6DQo+IEBAIC0yMDM4LDYgKzIwMzksNyBAQCBzdGF0aWMgaW50IG10a19wb2xs
X3J4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCwNCj4gICANCj4gICAJ
CWlkeCA9IE5FWFRfREVTUF9JRFgocmluZy0+Y2FsY19pZHgsIHJpbmctPmRtYV9zaXplKTsN
Cj4gICAJCXJ4ZCA9IHJpbmctPmRtYSArIGlkeCAqIGV0aC0+c29jLT5yeC5kZXNjX3NpemU7
DQo+ICsJCXByZWZldGNoKHJ4ZCk7DQo+ICAgCQlkYXRhID0gcmluZy0+ZGF0YVtpZHhdOw0K
PiAgIA0KPiAgIAkJaWYgKCFtdGtfcnhfZ2V0X2Rlc2MoZXRoLCAmdHJ4ZCwgcnhkKSkNCj4g
QEAgLTIxMDUsNiArMjEwNyw3IEBAIHN0YXRpYyBpbnQgbXRrX3BvbGxfcngoc3RydWN0IG5h
cGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0LA0KPiAgIAkJCWlmIChyZXQgIT0gWERQX1BB
U1MpDQo+ICAgCQkJCWdvdG8gc2tpcF9yeDsNCj4gICANCj4gKwkJCW5ldF9wcmVmZXRjaCh4
ZHAuZGF0YV9tZXRhKTsNCj4gICAJCQlza2IgPSBidWlsZF9za2IoZGF0YSwgUEFHRV9TSVpF
KTsNCj4gICAJCQlpZiAodW5saWtlbHkoIXNrYikpIHsNCj4gICAJCQkJcGFnZV9wb29sX3B1
dF9mdWxsX3BhZ2UocmluZy0+cGFnZV9wb29sLA0KPiBAQCAtMjExMyw2ICsyMTE2LDcgQEAg
c3RhdGljIGludCBtdGtfcG9sbF9yeChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBi
dWRnZXQsDQo+ICAgCQkJCWdvdG8gc2tpcF9yeDsNCj4gICAJCQl9DQo+ICAgDQo+ICsJCQlu
ZXRfcHJlZmV0Y2h3KHNrYi0+ZGF0YSk7DQo+ICAgCQkJc2tiX3Jlc2VydmUoc2tiLCB4ZHAu
ZGF0YSAtIHhkcC5kYXRhX2hhcmRfc3RhcnQpOw0KPiAgIAkJCXNrYl9wdXQoc2tiLCB4ZHAu
ZGF0YV9lbmQgLSB4ZHAuZGF0YSk7DQo+ICAgCQkJc2tiX21hcmtfZm9yX3JlY3ljbGUoc2ti
KTsNCj4gQEAgLTIxNDMsNiArMjE0Nyw3IEBAIHN0YXRpYyBpbnQgbXRrX3BvbGxfcngoc3Ry
dWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0LA0KPiAgIAkJCWRtYV91bm1hcF9z
aW5nbGUoZXRoLT5kbWFfZGV2LCAoKHU2NCl0cnhkLnJ4ZDEgfCBhZGRyNjQpLA0KPiAgIAkJ
CQkJIHJpbmctPmJ1Zl9zaXplLCBETUFfRlJPTV9ERVZJQ0UpOw0KPiAgIA0KPiArCQkJbmV0
X3ByZWZldGNoKGRhdGEgKyBORVRfU0tCX1BBRCArIGV0aC0+aXBfYWxpZ24pOw0KPiAgIAkJ
CXNrYiA9IGJ1aWxkX3NrYihkYXRhLCByaW5nLT5mcmFnX3NpemUpOw0KPiAgIAkJCWlmICh1
bmxpa2VseSghc2tiKSkgew0KPiAgIAkJCQluZXRkZXYtPnN0YXRzLnJ4X2Ryb3BwZWQrKzsN
Cj4gQEAgLTIxNTAsNyArMjE1NSw4IEBAIHN0YXRpYyBpbnQgbXRrX3BvbGxfcngoc3RydWN0
IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0LA0KPiAgIAkJCQlnb3RvIHNraXBfcng7
DQo+ICAgCQkJfQ0KPiAgIA0KPiAtCQkJc2tiX3Jlc2VydmUoc2tiLCBORVRfU0tCX1BBRCAr
IE5FVF9JUF9BTElHTik7DQo+ICsJCQluZXRfcHJlZmV0Y2h3KHNrYi0+ZGF0YSk7DQo+ICsJ
CQlza2JfcmVzZXJ2ZShza2IsIE5FVF9TS0JfUEFEICsgZXRoLT5pcF9hbGlnbik7DQo+ICAg
CQkJc2tiX3B1dChza2IsIHBrdGxlbik7DQo+ICAgCQl9DQo+ICAgDQoNCg==
--------------6FILCNDdDTwHcnvbT8By3N0F
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------6FILCNDdDTwHcnvbT8By3N0F--

--------------T1EUld1B31zWAtIRFq0wOfrh--

--------------qdadlHnaNWHLFeN8pNbop7ZB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmd76J4FAwAAAAAACgkQX75KBAfJsRlu
5Q/+Kc+jpzNWl5B8FBPeVxlgECU1qZFrNJPlLrUqnqgbWdbW9InZ8owbmVJAaMh/Z3tTy2zVfanY
X+BwzqeROvLtlt6XehgbRPzsuq9todjBtwmaWHwraMluvYEWm8EQ5+0RgfKFNTaPbhxtkpLaAX8S
1jivU+tcaoOQ95VbIrZaWGsBc0hUnQKTaPCH9zvkfrPupqmHMRnyo3D6hvbEUGEDmKgzgjUpbune
oDK5tYeRviO5M9r3ro53G4evm2GV7qV2D007g88g5yoUrhbNTn1+KpCl2P6KtMDuZojylz2KPxGK
iJGdiH7bOr0yvgDkXPsaGJOpj3s8Xbv5kGS5hpxJvnS9gdSxC3D4CO93/xRzQTzpvmv9zFA0pDKU
tjL8VT82h9ENr03NT2sWNWCnCDF2++C2ObeQjuiv12UUhg05GClDCl0pyltZ/XzUmvPLND6dQCK4
xlN1p/3/3qU35ba6s/WlgshjXPyUJHo2jw3JqbxoK9J3w9oIcSs8rhHb4p1vExb+LNNNfp8bsVc9
qpcqFrRn1qCNXhtnplUV2hIvOctkvS0Rq0+4QAJsUn2vh1WNwNEZUH1zXMCqLmB1sbalViNaB7ag
jVUWOY5EubnhuuDFezHGtvwe4CC6XSHx4izVG2+oqLolDQh9dn47NjSn0wRnDhHm9kOLNnR09PoC
fqs=
=+v+X
-----END PGP SIGNATURE-----

--------------qdadlHnaNWHLFeN8pNbop7ZB--

