Return-Path: <netdev+bounces-102957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1E9059C3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE72E1C211E6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E7181BB3;
	Wed, 12 Jun 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="O4E1VsED"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4F170835;
	Wed, 12 Jun 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212842; cv=fail; b=oL5J8CYBHqUoTIQxvlBRhFCbOlXiKbn5LsnsDWl7ONOPa3S0NjYSEmoUhudBvPC4x09tL3CHHRxuE+/eMVqLWN48g5LVPvne2fsinA5Kgza0G1J55Y4DTH2Es4gCNwbzqX9TQ4ksP4nIJ5KpCNVe7DVIbktNHsdBWn5AKaQB62A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212842; c=relaxed/simple;
	bh=0zHNL8G9+1Wg+1R3a3hh3KfYu0xMWiz4pczuwYsHJss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8LQH682iJcxORZ/MA3KORpQpfUm/18Mk8pG/+f/3wKU0HKCtlaVH6l456WoQ9t0vz0MSj+QrVnkOq5TWvya9/w86pz8T+GS/oq613ORoNPHv6TJx98zmKEbeomU2uieDoLimsX4A24ZVIKYGRng/CNDoNQqdlPbyTFMZUKH6yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=O4E1VsED; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CH32VU016569;
	Wed, 12 Jun 2024 10:20:18 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx2m59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF4WMqL+c6MF9VSGkucu0wdkApSsOWnbuSpDoTtNq7EmxUpKNCBM7c75gQvR4ickZZE6L0MTT6PGzVdcJk62W3QaurH30p9T+NEcXY/eOX7KA+Rp4Z5tl3NOdfhSozW42hjP5kllejrp8gchfKDNtGQfwrTzAoD8DTYgzns2qTxq9Ahy67uqEf0ehRn8dzCa4zBvxAYKq8AWuZ/SGhUjKEEBaSDxf5K0NU5ntYHOQwnTDbY141PVcIN9aC+TC3N0FLFW0pHEz0XXI4yN/3eDZZ+DIFow1N+IP9xeitZ+DhQYQTSwSQDFdkzExLB6Svo5ayP2JjJ4Ltx2M03nm8ypkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zHNL8G9+1Wg+1R3a3hh3KfYu0xMWiz4pczuwYsHJss=;
 b=j4JaFZtqusbbgmaQ+OKRVDPLol8nk95/vsZw7sQaPAaUhPoZk4Z2B/VDMNU7rgWQMJxnnIGtK0LdchZZY7V5vd4hiwJnyVeoUoZZcP2VIx6dnsBU5HSGFwEysjuazLAevjT/aseeiR7CFdZxD58vketdGapTw4RL+ctr11fSUREIu4ciUDZqGyrSXqVgW6aaOcKDTGgtZ+YhhwgZFGHbTcqKfa/02tftFR+3Wanw3tUbBiCCuyVT77JWNc9ZDKkR89PJH6E0F88SoWZzNHG1GH+T1mPlOzIikO/Am30vHrmWToiB9xfWxHk9pMQauasR2Pqxj7vvxD0UGeeXaT2mHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zHNL8G9+1Wg+1R3a3hh3KfYu0xMWiz4pczuwYsHJss=;
 b=O4E1VsEDXSGuG/bxBYLsY0gXdsnk/4muowS3uGFuTPV5Rhj5R4gtulm/2hDWpC405rnGITioEv+IDlFugHXopLKj87Hs637VSIb+iDfx73dTAoPBWm/bmIZwRFcQ3ojSL9TStGVvMkI7ERXzkAopoMWP+d8AuSgjLiptrQnQZmo=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by IA1PR18MB5492.namprd18.prod.outlook.com (2603:10b6:208:44f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 17:20:13 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 17:20:12 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Huai-Yuan Liu <qq810974084@gmail.com>,
        "jes@trained-monkey.org"
	<jes@trained-monkey.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-hippi@sunsite.dk" <linux-hippi@sunsite.dk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: RE: [PATCH] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
Thread-Topic: [PATCH] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
Thread-Index: AQHavOzIt3V/K0ewCkme5/aMEUgvUA==
Date: Wed, 12 Jun 2024 17:20:11 +0000
Message-ID: 
 <BY3PR18MB47377555195613DF6731B9DEC6C02@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240612093153.297167-1-qq810974084@gmail.com>
In-Reply-To: <20240612093153.297167-1-qq810974084@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|IA1PR18MB5492:EE_
x-ms-office365-filtering-correlation-id: a103b9e1-d5a8-4a35-86ed-08dc8b03eac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?IGBmEtrP6+XHplNM3qYpREl0++GSGnx8EyIUSt5x/oAClelhu4kjd8fZl59y?=
 =?us-ascii?Q?TQHAy5shCZC7zaafj5hlsvJnv4lo3mD72BWcp69cwdbTr/vdsA91xSoz2vob?=
 =?us-ascii?Q?4Mu8Ep5W8LooPtePfQ/vRDyfsPDkt+bc4yxz5gQ0pNa6evFrqaO2OIwfz3x7?=
 =?us-ascii?Q?jcUonsWOv4/sesuUAXIHD82z+OGjmITLcfP7x115ApNXQmrDP2O3SAUfz5Zk?=
 =?us-ascii?Q?T47rbJew3jLUKQxeGOeQtvu9/kzQ8zdUxyy2dAyliMU+LqlC1Qumx6d4TNiT?=
 =?us-ascii?Q?uDLx76cQceZAxWd8do8NrKepa2KY9ZYbeMi47iO7fNhCl7rcbcTpHdk7F8I0?=
 =?us-ascii?Q?2MRNetQHH5/UQ3cYS6c5fEgGukFYqStbu4iebK/QQSDz0e9L3KJ92wQz7/MN?=
 =?us-ascii?Q?/+3NdzDbu+QHpNR7/Mhg7cK6Z4TVMbNSCDbcUsyEGTSg6hTUd9NR117pl5zM?=
 =?us-ascii?Q?brJfeMqsQML8q4LmsXDI9U0c4EVdi4eeyx716BCd1N2KK6RT499fJdxm2YxC?=
 =?us-ascii?Q?E8bXPpqHi+6VXlApY8QJ0sz4CJHeSIDkJEdEWIpbacgvRbQ3VtlfFp7R22RI?=
 =?us-ascii?Q?6iXzj1dj6OHTXH1V2Jr6I85QjrAQ64bVb3zErAgZg1wVmGQmNR+ctIohhqlG?=
 =?us-ascii?Q?rJ+EUp33P1O6EztwX6sD7TF8zorpOHg+6HL1WYz2ddxSWyFwq9byt9RiW+Qu?=
 =?us-ascii?Q?nvA9w4E+GO+h1aCJ9FWWNmcKno+ue6SUXkm2RhIdLuU+VQ8oQcUuvXBPJTne?=
 =?us-ascii?Q?8m0EB19Bw/ajQ6SVRdHesG4p6TB5xjQllRQzhUupYZx46RQE7vjMyIAJBann?=
 =?us-ascii?Q?cKDODX5w2Q2h4hKuBsSvuX4vGfCfMszE9wg4I8ApuCFb81D2W133VGbUs/VN?=
 =?us-ascii?Q?xA1/wLQfPfm6bz2MVm5y/MzcKq+kUajfhqvrJtPauJprER/Vo4k8m0xaS/2X?=
 =?us-ascii?Q?zlUopDVblFguAjvDnp5wDVrRxTO/HvtW6XKQQqJFItQ7+hHi7VEFLMBWWbrb?=
 =?us-ascii?Q?s9UvMWjgl4DJy5buAvwmXtAAW38T2TrHONiHPmcLMmHwrHTrh8NFztwYMrUT?=
 =?us-ascii?Q?VXpKX7+XakoLut8v90f9LvF1o6LXdtRo2LCojROLemUtIcHOHW08HvRJ0AKC?=
 =?us-ascii?Q?AeUNRk4/9EFAoMcpJpkpBG6lVSQbTf2t60gqz9xBarqa3mcdrl1LMaotHp13?=
 =?us-ascii?Q?a089WSU1QKnwAId5jd92neNOFUvAFdstyJ6N0Kj6bD+B2/qF6ufUSGtz8I9e?=
 =?us-ascii?Q?LUiZP4ktiskg0pIey0ORIVFUty0D278RG7KS8y06V9pHn+ljSloQBA9j5WCR?=
 =?us-ascii?Q?crre+gXqykifZtQB93f1sbq99ULueXrCQ7wnbApnJB4ADwUshNG4sIM8KpsL?=
 =?us-ascii?Q?tHPH6wM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/esUYw2Cpa2lE8GWkVxN1KrQBvB99iseAwSZdcea6RM0R4SPzh/ImfjI5Agz?=
 =?us-ascii?Q?cv4JBeJuPTFuX1lOeNVsiBcjdDMO5aKsEN5uDFiGN6RrB6GU4/wt1CNxK8ei?=
 =?us-ascii?Q?SuMwLfgmqxRoN4ksCScEh6x/RWJTv6SVCKGCo0E4RuYUJbNOIJVios+U7HXN?=
 =?us-ascii?Q?1WMtKL1tg2llyTmM2UGZiGn8TM6U9vKPBnx4aetH9VLvD3i0xuCm3XFKME2N?=
 =?us-ascii?Q?pmvFo48x3lQ6JW2G043A/C+DLQ9wL7A0MMkK9mDrlLMKKBxTgDCEjCcb0ZlS?=
 =?us-ascii?Q?Ju9uQ7u9nnWdPAt5SzdUAIOADAl37QdGVhqnxXdxlxEyjkYKTHURraPBy9Ef?=
 =?us-ascii?Q?xlKXQM/I1nB0y75uNEHYYYDAaUdkaCjsNX8mCGK0DCGbdcPF/AZJdnBm5hKB?=
 =?us-ascii?Q?HHVUBzxHxqNah9kY2cawbeeRIlcs+S8XaPRAPgmk8gE4tJMAbZRTAVXBYo1Z?=
 =?us-ascii?Q?KnA9s58GFH19CMpDW0q66VAu88y3uWfToO/zOGctQQOhql4ZsUKe/Rtx7pyH?=
 =?us-ascii?Q?vodnwFn4j5W67zkr8jITV/wTYJDf98lZMhDJ8uSsG1P+ggMzglhAMCGkgNER?=
 =?us-ascii?Q?rVmEt+l5gPay8epvmFe2MHlXgMJn9HzK/v2aQ6M2P1GU9DkID9TZO7Zp89IM?=
 =?us-ascii?Q?uRQLAyw3cDmg1WHDHFlz++RtgB45ECrYrJK1tlsDNj+cnGs3ZheN3j/KyhsW?=
 =?us-ascii?Q?o+hp8px3vHSf+bmsrc/OZjqCxCaZN8tK1XevYeDskNZEyPpOJi5GHu3QwEWX?=
 =?us-ascii?Q?HlIf85REmmY5FkhUB86XOd6ulLnVjp2xzGPOmSiLmCo4Z240Q42wuRjPHZ9p?=
 =?us-ascii?Q?suZMuDjeQdzylYN11V31VkWpPWpCZLfADZbdMjOOc289k+mYzuFSdyPdFOqD?=
 =?us-ascii?Q?rUUAm8ygRbzbjHSaCDwaS2nBBNJ98tedEwhPPJN2ZriQMmidUVoOsl2AN3A+?=
 =?us-ascii?Q?J++5Dzk/fZZud81uYvdK1RCXUW8MvyhAJAvTWpPJB/bxUXsIPKTEsDR8lgoh?=
 =?us-ascii?Q?Y5E2wJuyOpOsCzsrAZ425tT4STa6O/7PTl8ZlpEh8b5EOe08fBf1br3A75MF?=
 =?us-ascii?Q?UdyhAsXaPcS95Z/XPkUMZB0bm6SO2MACUEe5ULJot09aDgdVOCfLo+M0ODNQ?=
 =?us-ascii?Q?KHtBqG7Pq2/Gz98Yp8KFTfh4zb2L551yghevVCjPpRGmjb1M5acUMY6/oaPV?=
 =?us-ascii?Q?5rHtbB2VFgkij3JXVx0+l7nU2mP8a0YjmKSomT+ex739aKjDLpUsNUI/c3Ms?=
 =?us-ascii?Q?kTNlHGa7Cd48WCFt7Fjfq+SVFC4BVCwo8jtOkfbs4cdYL5a0ElXFj6ClR5hC?=
 =?us-ascii?Q?W4gtEfZt4cEHoB2Ubs3GebbC/BeGBgHoE+VpQ3Fpe+hv447ZYcVVp1dO6oLx?=
 =?us-ascii?Q?G/NFem+lvBiOgRPCClFuUVDUwqNxyv3s2//HP7652ZWIsoFT+YhfPwzfacWz?=
 =?us-ascii?Q?/9v0GyDHpjwUjROEoSSadNUqROEHkMo+5uv3xM29WqAPyg+aYUfou+UGDEl2?=
 =?us-ascii?Q?ur2KbYMqJPWXa5KILkExY74GMRronS8r4M6FYR2xh0zHJWXU93LYCI/j17ko?=
 =?us-ascii?Q?3bcuhuUqgdDuoPhzn3mbbOTvn0K86sobsqynzMje?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a103b9e1-d5a8-4a35-86ed-08dc8b03eac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 17:20:11.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVD60SYc2HR7gfkmbPRGvYpsm28jGTxTZK/Vj3Mjh6uohEzkdYeYjTKYRnbtB2zKJxM/+i1Wwnkr902yUsbrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5492
X-Proofpoint-GUID: qY84-WlLZCKrqFvJ3ZpuxylwYNCO3-kS
X-Proofpoint-ORIG-GUID: qY84-WlLZCKrqFvJ3ZpuxylwYNCO3-kS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01



>-----Original Message-----
>From: Huai-Yuan Liu <qq810974084@gmail.com>
>Sent: Wednesday, June 12, 2024 3:02 PM
>To: jes@trained-monkey.org; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com
>Cc: linux-hippi@sunsite.dk; netdev@vger.kernel.org; linux-kernel@vger.kern=
el.org;
>baijiaju1990@gmail.com; Huai-Yuan Liu <qq810974084@gmail.com>
>Subject: [EXTERNAL] [PATCH] hippi: fix possible buffer overflow caused by =
bad DMA
>value in rr_start_xmit()
>
>The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is assigne=
d to txctrl,
>so txctrl->pi can be modified at any time by malicious hardware. Becausetx=
ctrl->pi is
>assigned to index, buffer overflow may occur when the code
>
>The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is assigne=
d to txctrl,
>so txctrl->pi can be modified at any time by malicious hardware. Becausetx=
ctrl->pi is
>assigned to index, buffer overflow may occur when the code "rrpriv-
>>tx_skbuff[index]" is executed.
>
>To address this issue, the index should be checked.
>
>Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")
>Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
>---

LGTM
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>

