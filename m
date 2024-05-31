Return-Path: <netdev+bounces-99734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F88D6262
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38FFB215AA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2C15886E;
	Fri, 31 May 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pZMRzwHE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8E15886A;
	Fri, 31 May 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160850; cv=fail; b=p466moGo7T/dyH2PbozrCu5qCMi6f1gcM0tcNrjMM6h4rt4uWQ5IHDAZtq253q5Xb+o7UXi2oKM5ZkUoEW4pikHEAmBj7FPtlp/i/pvLH+ROVgxCK7dogmMAzne121a3fd3gAY3VUM8G2povvG3bRH+9SwsN38Bp/gOnBscObQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160850; c=relaxed/simple;
	bh=D5ut+iS/KlyfUqSo7yUfudl+sQX2x9wGmWH1ExQa4qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CV+7Fk2xd+Z4e/NakVJ1fM34qq9hf0efYAG3JSp2IOpT70wlth94m24MQSXp7sZZ5lPVZdbpgUOct/zRvOmS/rUcRK6OEwQozY+juci4WLOS3ZNYtnTysF3b/U/CDuO0yMSUYnSJEuCB9cehWDp1qAX7e/5hMTz4yel0gXf5J34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pZMRzwHE; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V5Cq2E026661;
	Fri, 31 May 2024 06:07:06 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yewt3bbg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 06:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glx5jk9HjmngI+jG1CX5HPa5AZciiT3pOhj2VaEEJ2vHc8wcaSobAzFZopRGrkjhCJu9Chnmjx5khhqgOwJDSoe1851orfqXt/9vNBElvwcikrtIyk1czVicogWAISZ0OrHLb2jzPc537RnkD+TP9soAsZKN1rvZQ7TGuhNbyzJdueWtjDHrfP4NzMhBJYbf7l20frsiLr4n751Gui57I3EzR+LCEC1/eMMNSHVM3yjDeycW4bPey5ZZrjrs8ph0UQl6vi02eSqwZYBbIuRh2cdcFZBUTWcmJarxr32OezhIlLPLjEyAorbHPOAtKxxkNyazllxRAKKUrLyzPm6U1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlglHcRacfucXJ+JcP8S1NZ9KH8AkZSjTqK6ErZMXyk=;
 b=RMsAWZpqj1Ct/hhz8CWJDB/lQwuCQP38QxI4N16jYtZycsVnv5s/fMrc6wtw/pTP+5SCp5XNM495NPzluuSLKGb415cnAgqkNU8GwVfpLPffhIYV8AmL8gN/6NA59eyuGUtBdN3aSIiQEz+SQxaw2NRS9qH69CffKM6dUq4Y742pT4uN7Z8aTWnfYUFoRSBrE9qiPxoSWEysW9kzRKfhKWvTUiEP56NevgetwFR97VWSgbMLZeAEOPFOJFsi7WhA2Jrs/ovtdsFQVPqTELs0CKieoRqzQ4x0AMWVgYDvriaLRyy658Du82W8XaRdqmJtAo+5L5jCiR7hNBkPDx9epA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlglHcRacfucXJ+JcP8S1NZ9KH8AkZSjTqK6ErZMXyk=;
 b=pZMRzwHEevXKw8CtkRHtaUa8730xkTvcrNdPP+rqTl4FGR5FMqPPXYMHawyGePm5ZU03V5bFfzry7mS/1E7syQUG/0GOn/UhnmJETqMKLQnZ+DFj+MknnNB4dlxXCm7k/D1S0wOrHjYP9gRGbx+AsSTsmVT0phXT+bn/R9LClvk=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by PH7PR18MB5058.namprd18.prod.outlook.com (2603:10b6:510:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 13:07:02 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 13:07:02 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Breno Leitao <leitao@debian.org>, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "open list:OPENVSWITCH" <dev@openvswitch.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next 2/2] openvswitch: Remove generic
 .ndo_get_stats64
Thread-Topic: [EXTERNAL] [PATCH net-next 2/2] openvswitch: Remove generic
 .ndo_get_stats64
Thread-Index: AQHas0wBf9yoYda2AkybQGVh8GPWCbGxT9+g
Date: Fri, 31 May 2024 13:07:02 +0000
Message-ID: 
 <CO1PR18MB4666072D5694E38AABDB8CEEA1FC2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240531111552.3209198-1-leitao@debian.org>
 <20240531111552.3209198-2-leitao@debian.org>
In-Reply-To: <20240531111552.3209198-2-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|PH7PR18MB5058:EE_
x-ms-office365-filtering-correlation-id: fa408da5-112d-4a3f-e950-08dc81729009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Ndei4a4N2ShAtJWiVHCcQcatLA819/ew2MhtDbJ8ldBppZCvPHOD3kR8NppD?=
 =?us-ascii?Q?o9cpgqQCNqDscmX8rOvOuhVgoc2b+lhMM5gSMFxDPGIpczgEDBnIcTZHsHGp?=
 =?us-ascii?Q?e0OOb0xAMBSYA/UVxOonIFhDk62Cg4Q/2K3+uzhRMlXAmC5OD6bxViUl3mOn?=
 =?us-ascii?Q?zzepL7WwmlhNOCfmazpz6Dj5fDU8yl8pBXlQ8x7/Fkzo/daVvyJwjrcgymWc?=
 =?us-ascii?Q?hvQ8/mKBnEdkFKYjwWlW0jMkPoAZAdJzHijbDJ7dJkam5c+FIPniDhPZvbyt?=
 =?us-ascii?Q?SiCz4Q9bL2jl2A6kUcMGrp+g3NIA+FHAhf+o1pSRDxdmTRXPeI+9deknZSUv?=
 =?us-ascii?Q?IRMtNjjgu7JN6QnUUXmkVrAGN6+tzHkHYXSqTHv/5O/CfAt8y16NMM8dFoH8?=
 =?us-ascii?Q?ppEA9AgYchYr6Sb2wMwQR7w7Vt5/bSQRX/uRvHsjUAYgo7f30zf9YLm8+1k4?=
 =?us-ascii?Q?rY47Xw+DC73j+KmJUbkXrsxZ/Ojp5h5bgaHiV5jNoV8jzxTpbF5xl0OzmbdT?=
 =?us-ascii?Q?bBkCket0yQYj/h76xPINk3ncD8iej3tay5KRE8Q0kZLLk/kvGdwsU3yEebY6?=
 =?us-ascii?Q?pFfS58tZGlxXL8DId9x+VtD9AzLWjsJwHcWPIS3r5+nVyvm/+n8hlxhzhi3i?=
 =?us-ascii?Q?8+JW6CheZBUQRKPzhwt1XADLHhZYMdp5kc4NtyTGy7uB9/KfZkmJa4GExnv+?=
 =?us-ascii?Q?tPr2OlTNty83/3I+kNaJm2iFMMMBSRNS2EwCOx0HZUlPDyPM138r9QcfHvSi?=
 =?us-ascii?Q?W4jFdDvrmOuSAFPS8bip0NCH/fmgzQoGd1xb8QLd4fIFUY9e099d3rguXcn7?=
 =?us-ascii?Q?ktaQEPjG1ZKDRmb/xjpGw6DE2xpZybJcnMl+a3W4iiOe93H/WfBr92l/1jW3?=
 =?us-ascii?Q?5bC0H+9wDlCQsKDKP75abpm/MKRZeEs+O91wW4WefsjEZ3J/lSLcJuiUT2w6?=
 =?us-ascii?Q?xfzsXJpQ9w7fVIkQ3RtwHv57V0ZiHI755mKV98eSyQmkIEvKjLtFPtcWu/5w?=
 =?us-ascii?Q?ARgw6cOedja/S7HX/T2WxE2G1c6t/n+DhfMPDY93hwEaOaHBBendtwdN2PVB?=
 =?us-ascii?Q?89Zituwvo440oRhsPt1+EX69xq0Vg8zLqRE3GHK8WRlr7/OJB+n5B9i3B+/o?=
 =?us-ascii?Q?NhxwW4AZssgl3BZia/qestEDkcr1MFEn7OTtDVBBWGrEoIpTGgqdSZvsVtP+?=
 =?us-ascii?Q?xGZfrfuPBQzWNt4aDy9F5WbLOl+WQ4iH09vyYCE8d3gHjClIXxmH8YjaCHvW?=
 =?us-ascii?Q?7q3eOuAI+bt2LaOJwvCYnUc5+oPOglnBZnbx7tYEHm0GLxitM85IVd4sUHze?=
 =?us-ascii?Q?Pe1mVdPLrw2BRfsuTA1fl5DQ92SuGR2RIK6zrPatHEie/w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?rqzuq0UMVrZMdqknogzp1730HTGrQ44yMQpWUZqwxQ6eB9uT1XLihR8pYoYM?=
 =?us-ascii?Q?v+Av0Gwuz1I096Rp37anXGM5crMvg5dc2FjNQnuFJmMvOtqVTTkVOVmamC5P?=
 =?us-ascii?Q?cRBy2oHEw9yzGxZoFVUD+qFmq9Yubc0rtsihgNUz6meTtTQQbNySqIv+Rfrd?=
 =?us-ascii?Q?/1vd+bsM0/72KNpS2YrL41hCMSAhFhNOl3T+84/x+QzFAN0zIB4dc/n3aw9i?=
 =?us-ascii?Q?s/9y7+vk/fOwNfCio39iVz3cv7B1Okp++eBu/FsSD5mffNseFuDdnLEjIsGL?=
 =?us-ascii?Q?W97lr5jR6O3rjdbe5z3rrokUUs6HZAexOnqvhBeMfsky9IoGK+6Q6dJc9MmD?=
 =?us-ascii?Q?pzP1ZCR9iHQbhaTEqXQcjebdAhcTcBAsqGPkLkhr8FJNKo2YhyC6v09KEQV6?=
 =?us-ascii?Q?dHBgZc1dY8bKgtbOiCL4i5q+3nn/Rn2BBrxnC9UtOtmpDzfReyoTHw9Ob5u3?=
 =?us-ascii?Q?skilO1U5sXrE6yDMo6nCrWfN1/6ukjpoZ5rpIA3NASd8pqtEuxgOx+g7eiKJ?=
 =?us-ascii?Q?TdlORMK1bjkhZMyPJcpevESYO8Ec2DydkigBqOqbkR4dbuTpDnbrWmNzTOJn?=
 =?us-ascii?Q?lxML86IJfCjTghp4PCo2vKDgHaSkmYqlmv5bFz0IUxdl6ls517+SYg5Ve/iU?=
 =?us-ascii?Q?6e2zwfFVOHxHF+I5r8Hf5NKVnpLW6o40XShFgHV1qzFaZSDIFeJ708qDX2Dh?=
 =?us-ascii?Q?NJ0K6oZyxfJFUzjiOwE3pK3WslFfadLvVPVfr3sycesTj2g/+T0T/I8E6Akg?=
 =?us-ascii?Q?17cHwZ91DDZsiFVZUct7Nk8i/dhOXe/KpAnSwKjg5Bz4N/D3dqShzcJZ9X8f?=
 =?us-ascii?Q?8oxd5aM5EvvWbrLZz7yhVgiG523AevIzgkYKgSmNaFBb5qBZCYOgj8/dqbPZ?=
 =?us-ascii?Q?/Nuw/5zRajhepuxlo6vu0jcxaEqQbjz941Dasfc1rmabquvs6hen927tYnkH?=
 =?us-ascii?Q?hOmG3l2MSM/vP4x5WKiQGhywkjr7y3t7DuVDpT2fbsElCtjWy5MZA18K7EM4?=
 =?us-ascii?Q?YGEqUKPUwUXjN2b98U2dGVHwOLHo63Q63cspf8lCwmtqDFvj+WRrPnvm/H/2?=
 =?us-ascii?Q?LuG6fs7LIPbd7LFv8fFxDygJy8TedEkqH0hM7B+hmUEn1UIOgRrDGIPADBOY?=
 =?us-ascii?Q?1F21f9QiNVN2zg5oIAf2hopg0D1gDoxP75N3Mi2ZTbRcngW7BVHms8kSn2NA?=
 =?us-ascii?Q?qnNWfLLva45O1eLsMXEIDmF9jyBcZ/tk0Q6veMoZj3sVlJGislRzaQANawzm?=
 =?us-ascii?Q?h4/ftAh6cLJyTBAdj7A/fciB2nwh64vivWT1M0sxOz55Q0Rwbm0gjFSa4BD6?=
 =?us-ascii?Q?sD3/bBxx57g6uEyuGL5JnLQHGFFN8Q1sO+FOIsIdZJ4WgaW6FWXpAEbvoNd7?=
 =?us-ascii?Q?8vjUmgGli2Q699YfXkAcSweXuUsZ+Z3Lh+8VJi2OKm6J+/d+SnC5qynwlBdy?=
 =?us-ascii?Q?eoLWOTj88I5FOfSx+XuEvOTuQbBJxLz7LhLfrH4mYNhCxFSrbml40hCB5Amh?=
 =?us-ascii?Q?s/hl6o6AJZ+fTqGM3jcpcgN8iud2OUF47RylwAVd5Fr3gG97PfW9y4mfyeUB?=
 =?us-ascii?Q?sVzL5kDvTBCDWvd37BQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa408da5-112d-4a3f-e950-08dc81729009
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 13:07:02.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fm0wElUbR2seXLslfTdzt0tzdjM0dpwFDmLVTjedsc/4e+dYPmbFdlp/hfbAKok6gTisBnuOiHnhZtTfBYuBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5058
X-Proofpoint-ORIG-GUID: wQqBc5tpdH8YKW6UKr7cyNXKe585HIm1
X-Proofpoint-GUID: wQqBc5tpdH8YKW6UKr7cyNXKe585HIm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01

Hi,

>-----Original Message-----
>From: Breno Leitao <leitao@debian.org>
>Sent: Friday, May 31, 2024 4:46 PM
>To: Pravin B Shelar <pshelar@ovn.org>; David S. Miller <davem@davemloft.ne=
t>;
>Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paol=
o
>Abeni <pabeni@redhat.com>
>Cc: netdev@vger.kernel.org; horms@kernel.org; open list:OPENVSWITCH
><dev@openvswitch.org>; open list <linux-kernel@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH net-next 2/2] openvswitch: Remove generic
>.ndo_get_stats64
>
>Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
>configured") moved the callback to dev_get_tstats64() to net core, so,
>unless the driver is doing some custom stats collection, it does not
>need to set .ndo_get_stats64.
>
>Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
>doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
>function pointer.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

>---
> net/openvswitch/vport-internal_dev.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-
>internal_dev.c
>index 7daba6ac6912..4b33133cbdff 100644
>--- a/net/openvswitch/vport-internal_dev.c
>+++ b/net/openvswitch/vport-internal_dev.c
>@@ -85,7 +85,6 @@ static const struct net_device_ops internal_dev_netdev_o=
ps
>=3D {
> 	.ndo_stop =3D internal_dev_stop,
> 	.ndo_start_xmit =3D internal_dev_xmit,
> 	.ndo_set_mac_address =3D eth_mac_addr,
>-	.ndo_get_stats64 =3D dev_get_tstats64,
> };
>
> static struct rtnl_link_ops internal_dev_link_ops __read_mostly =3D {
>--
>2.43.0
>


