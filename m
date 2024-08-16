Return-Path: <netdev+bounces-119103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F99540CD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA901C214B1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBD763EE;
	Fri, 16 Aug 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nnNrzwf5"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247A78B4E;
	Fri, 16 Aug 2024 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784505; cv=fail; b=k7N0oJKx06tOlbJP6bsPWn7TrwfA64URx9OXmdkbZ8JvvOK9SUhqVjk2ukxFPPWq91seQmDt9JiLoE4/Bva6iHbRhljHXXS8SqAn4LJOu62uJCiCjijf/Yn3ZGGSferlpY47qFKFh5tpB70zOrROeNjkLgskIlyDHNpPdq0H6Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784505; c=relaxed/simple;
	bh=ai63aOWGlLAA3PvRwDnjkPI4oPRfO43BBnjbtHVu+Hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nzwfxtI3fXJlzlXyBUQ1QAD7CpQtI8KL60CuFA0QnCd6M6YzObQ11JTGSh1SemQ5mBJR/5NbPkwXQQZllilZWFQlr71dlunIaAhS6UhHPjfTnIt1+vXDfr8VdT9mI0vizoFtgsY4zIV7auiezWiBSQYnV9FyFRkLHj4H5r63hZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nnNrzwf5; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INKFjwjJemx30ITgH4mJ8rc46DeYDJOJd7fWfikxAkvAxDoQhzx3jRSEg8LwBbdehBnSWrECXWChf2pzrvLcCeKh3J14g/7HlSyWun1tEwfMbbemu2GoiICjAavBwUBHcu01+bVW0rkWJZf5Y3CL10aqTqfnWmQX+91L0px8Mv6g6fPkD7pE07rngL9isQKky/5zVHQgRoBXNpPTXR6rdwSnNz/45mf5Piv51/vlUbnq1ExkKka3v/TFOx3JwSrNoQ+G+qt+j5dpfR8pO6TbCBnCgd/P1RnMzUIKlQQmX8eiwiBgS/VRrnrZZH24eERAEnwNLywxYVmhmrJxEqCa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai63aOWGlLAA3PvRwDnjkPI4oPRfO43BBnjbtHVu+Hk=;
 b=BexzeyDycw2RwkFKe9RliEzlDR4FPONQs5fCTDHi/NGxRhwCr28l8m9Oje8c2WjFJgx0krB8wvpCA6PyoQw8qH74mrye2+fceT5/AKouC8s1GVekBkaqGVLDITUvUBleFQsFrUzakYerlEY9HGFtIECvUXi6BuBS85nizcV7+Lx3lmLRHRmKZl0sHFQpo8rtzzBTHoF/6fSUZhrkxYSmH25cChxq6gxa5788x5rRZbOOOK86Dl3uiCOrjPv+ovKGGzVda6uf8LlNrB8H/sLf4eVTIx0A9xJcP3n+MIP4GW4Nv6U2janps37vYsHo1iVR+sb70GjZ53YD0c1Yb1aYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai63aOWGlLAA3PvRwDnjkPI4oPRfO43BBnjbtHVu+Hk=;
 b=nnNrzwf5zvpB28LMxHTXoWtccikHmnai57dhuyEWU95gmNSrVCE5/kei8ohfJ/Z360XqEXeHupF0wvxuPtT+JPCzcSdms+cDnfCR/f1qqbfjCloQPHcbCoTjTEC1RFk8q2cXeOvVqj9zhu9WT1NoKDq+f/2MpsVi3xh4sZMi1qYdHDQdhHvy4oDaq+7M6M54UAFyhNytHDmaK1sltl7r25tQKMVbKSpq6dY2DDL8jdyCQ1XwQwLBaoLAgPt9shfRaFFbw2jL5QgBQjxh/vmZbxxhpcJgDBw3ESB0EvbL0PWzNMgS/YznV6/14QXE+w/N5uJzIKy6WybTM25TuAeVCQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 05:01:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 05:01:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Topic: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Index:
 AQHa7tklv/4L4ggGKE+iM9Tw+y7ldLIoYlwAgAC0geCAABSogIAAAo/AgAAM1wCAABLEQA==
Date: Fri, 16 Aug 2024 05:01:39 +0000
Message-ID:
 <PAXPR04MB851069B2ABDBBBC4C235336E88812@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <dba3139c-8224-4515-9147-6ba97c36909d@lunn.ch>
 <PAXPR04MB8510FBC63D4C924B13F26BD988812@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
In-Reply-To: <718ad27e-ae17-4cb6-bb86-51d00a1b72df@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9764:EE_
x-ms-office365-filtering-correlation-id: 01a7545b-9d5e-4551-cae2-08dcbdb08386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eXVxeThkVEFoemFsbkJLeGFPc1NvNTN1MkhEYzh6dnJDZHRsRVZWa3A0ZU02?=
 =?gb2312?B?S25YYWg1OTI4eGpsU2RmbU9iUWNaRWZSRmxkZWNLOVdITzBWWW5icyt6RjFm?=
 =?gb2312?B?c096MUxUTHZRNUQrS3RQQUZtTW9NeVVjK1RwMjJ6QXNBQkNtK0swOHh1MHd5?=
 =?gb2312?B?U1JBNVZVcjZpRkMyR21hbThFNHgvZnhVUS9EQjNrQnRxZUh6SE1uekF5RGI5?=
 =?gb2312?B?VDNHc2NQVTlESmx5SHNqNWl3V2VLakRNU3Y4cVpvc3BLMkoxMWFNWDJWYXBw?=
 =?gb2312?B?R29oWmhhNkJVZERKMVRreWZiYmVETW9nLzBjZlQzbGR0L3AxNlBPQk16VDdo?=
 =?gb2312?B?Qm5BT05scVZrS0VnV2lpeVdHajV2UkpUZ0h0WVptS0VSZXRSVlBuazFGTTIw?=
 =?gb2312?B?bWxxUkxYVGc1UUxRSmltMkkyV0h1eWpjSk9YZGxzdlNlSitLc3ZtdWQyKzZn?=
 =?gb2312?B?NURTSXVsUHdTT0tmd1V2YWpOditUSXgvaklUYXBEYUg2ejFFSU1jM3VQSytI?=
 =?gb2312?B?OHRFdTlrWm5KdElvbFMweG55L3B3OUM0TDhrUUpycUk0S2dQNVNkSXFTUE9o?=
 =?gb2312?B?T0Y4cEJPRzJ0b0orQ3MwZjlWTlFQOVJuaG03UzZNcVJnNE0xc0REVm9CdlJZ?=
 =?gb2312?B?UlRZQmUyZnVRbWkvMnFKWkwvZFEwR29VOW90aUN6ZStCa0pkSndOWDVCcFNW?=
 =?gb2312?B?RDlJSXhkeHpFNHpzeG5KcWc0VTFFRkVENkZXTDJjOGF2eFljZDVORkplOGVR?=
 =?gb2312?B?bWJFcnNqY3hwaVZTcjl3a2RkZ2diNm1GRmkyYi95SWVvSXMvNDkrSWwxVW91?=
 =?gb2312?B?aVl2bk9IZmF0ZkQwZXBKd1pPWG1Gb21TaWlyT0dMZERZbkYrOGVVZFZ6V1RO?=
 =?gb2312?B?TDR2N29WQzJFTDZZZ243WU5lR29kQmFKME84WVZVZWpXMHNEL2Izd3BrdnNC?=
 =?gb2312?B?UGdXelBQbHR0eWR6eWlGUjFjbC9qK2Vzdml6T0VZRHpsd1M5U3JXaitWamhH?=
 =?gb2312?B?ZmVrWDVVaHI5bkZ2YTlTR3A0R1djTFN6R2h0dXZSQTc2SVE1SFZ2d2tPbVlU?=
 =?gb2312?B?NEI4aVJCV2lBQlViMUVBNGZxcmZldTI2T0xIR0s2NkNCYUxQZ1NqNkI3U2lZ?=
 =?gb2312?B?YVIxMldBamxNeDFCNTZzWTl6WEJraUYwMXBBcU01cmxBN1Y5Z0NRNnQzMldR?=
 =?gb2312?B?bmE4VElYNm9jRnErVkVJWU1KRnBwQ0FwcTR3RWdqUWp4bTFzTXQ1dWJVMmZ2?=
 =?gb2312?B?Ymh1WHhBbnV0dHUveGs5c2JzeXRkZ0M4Y0wwRnNlZ2wwV05pdHNZa1pOTkdJ?=
 =?gb2312?B?UFJxcHFieThzRnY0enU4bGlBWFBveTgycEJjMy9pVjNFTEQvcE9HcUw1VXQy?=
 =?gb2312?B?eUhCUTB2Z3ovWUhWKzVoWGVSZHpBV3I1a09hSzkvL0JTWWFMVlkzZnQvQUJT?=
 =?gb2312?B?VDBSRGpMWmtqZzY4RFdQV3JVV2Y2ZllzTGFCbU1rN2U5UC9Rc3JFY1ljcDB3?=
 =?gb2312?B?VkdaLzhkNmdGWVhCSGVjRmN4OVg1MkNMeUIrbzZTejlWQTRzN2hydXZBN1k1?=
 =?gb2312?B?eHdOak9tTVMvRHhPYllJenU5UGE4aVNZSnN5RUpjYVA4RnUxZ2tpaVp4b0o5?=
 =?gb2312?B?Rzc2VnF2SURKdUsxUjZlMkh4MnV0aW56VVZpSFNMZE4yazA0K1R4TVdScldD?=
 =?gb2312?B?a1VXZTkyR2pTUkVqZ3JCOGQweEVnUTZxS2VVSzV5L2R2SkFYcjI3cGxwU0tZ?=
 =?gb2312?B?b2IrdzBEVDR3WHVwOElMbDVKcks3MWNDWTZueWY3KzFoSERlOHNteUNtYjFZ?=
 =?gb2312?B?VzBIRkp6TnFGWTJDdVAwWUdFR1ludXdFRDgrVXJITmFmdTdDZDEzRGZXN2ZO?=
 =?gb2312?B?N3A2MHlPYVVWMTZYc010cFg3OUlxU2RaWFVmaXVKdzJyaGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M2lwM2JFWVdPaVdyb1grcmJ5MnNaRjBUNGh6cWg5ZHA4czZ0Qm50OUZkTzZJ?=
 =?gb2312?B?cFExR1FrN0VmVFBlMUhtejIwSm0yQk5HUyswSEFlaEtDMjBzaWdvUXZjazYz?=
 =?gb2312?B?VDJ6VTBhczlKbzlFeS9iYXl6U1RZeE44Zm1uVzE1a0FzYStQNHFhQXh5NjAr?=
 =?gb2312?B?eHRPcjBRYS9yYXRxOWs5MW5QUDlpeFdyMXNIVEVYd2lhQnhkRFNsSXdXMnRZ?=
 =?gb2312?B?dlF5clZ6SWo2eVdsVHJjMWRFVVdYS0dyUTBhMWp3ZWV0ZVFmQzIrWGpFNHM0?=
 =?gb2312?B?aCs3anV5SG1oRjJlY0lJNGdOMXA5YU4zSGFnZlo5c3FzZVA1Y1RFdENuTklx?=
 =?gb2312?B?ZXhycE1mczVONjNTUHJuVVFEd2pPVCtkQ0xUblVhVHNkQnBzWHByMXdYNU56?=
 =?gb2312?B?OGpwTTJXbGw0NjRidzRwTDBPOTlsUnVtM2xsNFVLYjUxVW9BRlNsejlvTEk2?=
 =?gb2312?B?TFNqczZhS2k0MEgvaUJRWllTWFpMdFFCMElNY0pxazlDSnIrUHRqd2lSa1pU?=
 =?gb2312?B?Z0RMVHJRWVdZUGkrUXFwMWFPbFFZY25RNXY5c0x3d2FQWUZySUkwYUladDBZ?=
 =?gb2312?B?cjVZeEpMTFhwdm5DZFBDVE0rK1Fqd1Jqb0hqR1JFQ2hJTHNRbktVeVd0OTFw?=
 =?gb2312?B?NXFyN2N1MDdnK3kydUpGclBMUU9uZVM5ZGsyVlZJdENVZHVSdG1HdmdycERt?=
 =?gb2312?B?L0xwSjNMSmR0NkRpZVFEdGpHdnVrYUwveXd2Q2lmM3RnWVJ0SkNmbE1aYkVF?=
 =?gb2312?B?blZvNGVSSy9HWlY5S2lCUzZ0MmxUbFpFLzJUcmx0eGx2b1NNUmRBSXlGYVdP?=
 =?gb2312?B?S0ZWTWxUVE1HaDFmQXhBWXMvMU1oRmZDeERRK1lsdUFFN3NzMDZPVDNjS25M?=
 =?gb2312?B?VDIwQWlGTkxQRTZCZ3Byc3N6aU9lSy9SZTlQbEJPdzRvMHFCVi9NajBPMjVk?=
 =?gb2312?B?MmxBekt1dXArT01hNHd6U0RYWG9mdUFtamRocVYwdURrWVhLcmxuL3grNmZN?=
 =?gb2312?B?ZFZEWW50aTVydDRjazRKdEk5SXZhaVdNQ3NaZmVXMFQ4VmhJbitoTHRMby85?=
 =?gb2312?B?Y1Ntei96MTFMSkxYc05xZDRLZVBYZloySEh0dndleFpheG9OajJTRTNtSVQ5?=
 =?gb2312?B?SXhzc1A2bVZHcWZ0T21jMU9QZ1FXeFJCUHRubUU1eGRSKzdKSUc0eko4OUJk?=
 =?gb2312?B?Nmt0R1pNT0d3ZStJSCt0K0JEY3ZKTDJKYTNNVGlRS1N5ZjFCNG55Sm5saVlM?=
 =?gb2312?B?K1NUbkN3S1ZyUzd5L3Yxc1h4NWR5Z3N2ZW5OcDlqUEFoczlxY1I2dlF0dUN1?=
 =?gb2312?B?ZUZsaFN0K2hVWlZ0cXh4OC9jU09yYnpJYjB2R3ZYTFhCc2QrakJKWktEQllm?=
 =?gb2312?B?TUs2VVY5RVRIM3RpUkl2b2RtYUFiMGdUUFN6UkQxK1ZLblFiUFZzbTVzY2c0?=
 =?gb2312?B?bWtGRGFENjZ3Y2RFVnVWWVVlSjYwR3YwYloyaDhmcmQxaXJHaHFkQndSK2xT?=
 =?gb2312?B?YXJadnNEZk9MVnBjNFZNdHJUbUJSK05QRGUxeFNURWFydlVlYTBlZmZ0NDYy?=
 =?gb2312?B?RXBMYnBZVkVWYmRQcGdkZG9FTU80Y1Y1bytRaWJvNjJ3YVRjd0h5NHlTK2tG?=
 =?gb2312?B?WlVqeTh0QmtTcDBNNnhBMVlQTUtYdXR5bHFMU3pOdmhwMnhSdUxwekNGOFNE?=
 =?gb2312?B?cERlWXRUMzFpdmg4dTdFb2VZRW5JU0VMcnRRdld1WVZDNnNGeWx5eHdjN0JS?=
 =?gb2312?B?bUdGUm5iT2F3anBjR3RBRGp5aWN1MGxYd05yTU9SbmRxL1NrQ010OWcvaWQx?=
 =?gb2312?B?bGtWL2drYytad2F1dkYxK0s3UERqNUNxK1RzdEZYQXdrNjdRamsxRU5RT0lC?=
 =?gb2312?B?YXh3bllIVktwQjQyeVRSc3Naa3pVclVMa25yV1JuNXJZR0FyQk5uU3NiUlBW?=
 =?gb2312?B?V3JDSE9JZE9FNzNTN2NiSlpNaDR1QzVKNHg5LzF6bzNHckNOc25nTjRNK3VO?=
 =?gb2312?B?SzhJSlhxMFFkTXppOTljUzAvL0J4WmZLL2hORi9HNllwU2FaUzgydytoRnB2?=
 =?gb2312?B?ZWlsRE04TDI5N1lrWEsrQnF2MnY0RW5hMlhOc2pIOWJOZ3JhK0NzbUlhR09M?=
 =?gb2312?Q?+S+c=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a7545b-9d5e-4551-cae2-08dcbdb08386
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 05:01:39.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ox2vY5BlBjbd5ErMM3Zp10kdACgEkDygQz12Qhps0hssEnFxpPhYHeyaCBBE+Q3Y+KRqAPtvtqAsr1nYHHcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjE2yNUgMTE6MjgNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGYuZmFp
bmVsbGlAZ21haWwuY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgu
b3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpIDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxLzNdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IHVzZSByZXZlcnNlLW1vZGUNCj4g
dG8gaW5zdGVhZCBvZiBybWlpLXJlZmNsay1pbg0KPiANCj4gPiBCYXNlZCBvbiB0aGUgVEpBIGRh
dGEgc2hlZXQsIGxpa2UgVEpBMTEwMy9USkExMTA0LCBpZiB0aGUgcmV2ZXJzZSBtb2RlDQo+ID4g
aXMgc2V0LiBJZiBYTUlJX01PREUgaXMgc2V0IHRvIE1JSSwgdGhlIGRldmljZSBvcGVyYXRlcyBp
biByZXZNSUkgbW9kZQ0KPiA+IChUWENMSyBhbmQgUlhDTEsgYXJlIGlucHV0KS4gSWYgWE1JSV9N
T0RFIGlzIHNldCB0byBSTUlJLCB0aGUgZGV2aWNlDQo+ID4gb3BlcmF0ZXMgaW4gcmV2Uk1JSSBt
b2RlIChSRUZfQ0xLIGlzIG91dHB1dCkuIFNvIGl0J3MganVzdCB0aGF0IHRoZSBpbnB1dA0KPiA+
IGFuZCBvdXRwdXQgZGlyZWN0aW9ucyBvZiB4eF9DTEsgYXJlIHJldmVyc2VkLg0KPiA+IHdlIGRv
bid0IG5lZWQgdG8gdGVsbCB0aGUgTUFDIHRvIHBsYXkgdGhlIHJvbGUgb2YgdGhlIFBIWSwgaW4g
b3VyIGNhc2UsIHdlDQo+ID4ganVzdCBuZWVkIHRoZSBQSFkgdG8gcHJvdmlkZSB0aGUgcmVmZXJl
bmNlIGNsb2NrIGluIFJNSUkgbW9kZS4NCj4gDQo+IElmIHRoaXMgaXMgcHVyZWx5IGFib3V0IHBy
b3ZpZGluZyBhIHJlZmVyZW5jZSBjbG9jaywgbm9ybWFsbHkgMjVNaHosDQo+IHRoZXJlIGFyZSBh
IGZldyBQSFkgZHJpdmVycyB3aGljaCBzdXBwb3J0IHRoaXMuIEZpbmQgb25lIGFuZCBjb3B5DQo+
IGl0LiBUaGVyZSBpcyBubyBuZWVkIHRvIGludmVudCBzb21ldGhpbmcgbmV3Lg0KPiANCg0KU29y
cnksIEkgZGlkbid0IGZpbmQgdGhlIGNvcnJlY3QgUEhZIGRyaXZlciwgY291bGQgeW91IHBvaW50
IG1lIHRvIHdoaWNoIFBIWQ0KZHJpdmVyIHRoYXQgSSBjYW4gcmVmZXIgdG8/DQpUaGUgUEhZIGRy
aXZlcnMgSSBzZWFyY2hlZCBmb3IgdXNpbmcgdGhlICJjbGsiIGtleXdvcmQgYWxsIHNlZW0gdG8g
c2V0IHRoZQ0KY2xvY2sgdmlhIGEgdmVuZG9yIGRlZmluZWQgcHJvcGVydHkuIFN1Y2ggYXMsDQpy
ZWFsdGVrOiAicmVhbHRlayxjbGtvdXQtZGlzYWJsZSINCmRwODM4NjcgYW5kIGRwODM4Njk6ICJ0
aSxjbGstb3V0cHV0LXNlbCIgYW5kICJ0aSxzZ21paS1yZWYtY2xvY2stb3V0cHV0LWVuYWJsZSIN
Cm1vdG9yY29tbTogIiBtb3RvcmNvbW0sdHgtY2xrLTEwMDAtaW52ZXJ0ZWQiDQptaWNyZWw6ICJy
bWlpLXJlZiINCg0K

