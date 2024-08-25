Return-Path: <netdev+bounces-121743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3C95E4E7
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 21:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F2A1C21AF2
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC515574C;
	Sun, 25 Aug 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="n0RGQfbv";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="n0RGQfbv"
X-Original-To: netdev@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021089.outbound.protection.outlook.com [40.107.167.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DB28366;
	Sun, 25 Aug 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613540; cv=fail; b=aUernMhuGuInZc4hBPM9xQIvgakajsNsAWBYcFAQxtpfUqWbUtzt2ONn9s8l57J2oAg7Z52xTwVLpUXSUMNjI6BrQq4vxtQAxb/0ZY9aJcdrX501WKALUXPcV3zNDxyWLS+aHM9uXgWgXX5p7MxjQcMHapDAuL9fIVpQaq/7LWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613540; c=relaxed/simple;
	bh=nR81B13WKA4dyFubJO8AEA08OH4WGkYAFn+UjDXGr3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3/faoMSNWJdqA+tAm5cIn5J0DWkEtkYydQ+sHgFbAZG3zWrRdDUv2/PetdcY6iJJR8Mepz+vQnYDTFKTo8zB6x5DJZXr69CduCQvvx0baL68oWyelvINyKf3SL0rJUope59BV4lzjPQLDIkSoVIkJf0vcOLzYdfkZQmnVK3d6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=n0RGQfbv; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=n0RGQfbv; arc=fail smtp.client-ip=40.107.167.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcqiofpGYbfZFwxt2uJ6aBz8KrjPgD9U41qSW3w5TRiI3kMYvWdlGkMjvD0YUqVtgqENPfGxfSKLStFEn2HXKyonsdLKmSOXTvlb4zbTYJWcmDYksgBOpTMsp4PBAy9Cx+NSZOGmqRZM3yBbKMc2XSUP87moQRozZvoagkjAYPJgm85F5Uwfqg1testqTuAjKRXM1apTSO3YkHP4mGtiEeMPs+EFnbhJIywO8gc2gZ0BkvddWpb4OJQJBGLsKN8JkI8/DMORmL+JvPzrb3JIvkmeobySxmhW63DqiDOM10nMNTo04jgshypmAfkgYc0DftewFB96IBggpHosuJclIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpRastar5/DVT5HUcdZph18jJsCONJPbGH/mdbFnMkg=;
 b=F520gHxoJtPyCRucaJu1ih6W8M12Gae1nlxgHxuQ6i8u2m6a9Ssfoa5hloPs/0RyJs7FmF6rT4otK63LG5wG9XwhKmayT3c1BxX50vIl84IfP/krAleDQMmQWJb1St8YVTvXQXnCb+J0HfcCxU4kBF3h3KrdFi2euYeYz1h95gwlxbVb8Oo488aKljI0mWry2o/uERb8GsVOaJ6TFIQebaIwXHO5z0S9p6o9iSIo4PBwyx5Dv4ztJsRZ6Y/f2X48W0Iq+lEEMuLoXCdH43HlGTy7WHw2gDFbXR7AEM+kHNtOWMLq9oLBlLy2/LhakGQYbS0gzuLFFJqMme6e7KeNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=davemloft.net smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpRastar5/DVT5HUcdZph18jJsCONJPbGH/mdbFnMkg=;
 b=n0RGQfbv6LflNMYDQYKUTZbrOnzL2AdnUPuvccwXORX8JjuJ+CAswxPMRi9s+wuoEb4HTFnG5GyDGyDIkBR9umLUDwh7p94EiFnye5xkkewYyGC6uF8GPLE9+aPKlmxnZRSzEa+y0do08MJdAsVgbuen4ti7b0q/tIlhk1/YKCE=
Received: from DU2P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::11)
 by GV0P278MB1746.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 19:18:53 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::e0) by DU2P250CA0006.outlook.office365.com
 (2603:10a6:10:231::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Sun, 25 Aug 2024 19:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Sun, 25 Aug 2024 19:18:52 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTP id 0B3BE82264;
	Sun, 25 Aug 2024 21:18:52 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011027.outbound.protection.outlook.com [40.93.85.27])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 9958682206;
	Sun, 25 Aug 2024 21:18:50 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=n0RGQfbv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpRastar5/DVT5HUcdZph18jJsCONJPbGH/mdbFnMkg=;
 b=n0RGQfbv6LflNMYDQYKUTZbrOnzL2AdnUPuvccwXORX8JjuJ+CAswxPMRi9s+wuoEb4HTFnG5GyDGyDIkBR9umLUDwh7p94EiFnye5xkkewYyGC6uF8GPLE9+aPKlmxnZRSzEa+y0do08MJdAsVgbuen4ti7b0q/tIlhk1/YKCE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR0P278MB1314.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 19:18:48 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 19:18:48 +0000
Message-ID: <1411a2ff-538e-40c2-86ef-7b6c628b478b@cern.ch>
Date: Sun, 25 Aug 2024 21:18:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
To: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Content-Language: en-US
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
In-Reply-To: <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0759:EE_|ZR0P278MB1314:EE_|DB1PEPF000509FC:EE_|GV0P278MB1746:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa6b6c0-9503-4f45-8cb7-08dcc53ac17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eVJJdVlwUTJHZGtFMktWdVJscWxVSFN2c284OGVaRC9EajdUd3grRkRCcWNz?=
 =?utf-8?B?YjRIRzYxK2tBOEpjcWprZmVZR0ZHbWhqcFZjT3haa1lEVjk1Zlhzd1RWVUpu?=
 =?utf-8?B?NVRGV01wdWVaNkJkYkdBb2hnWnh6d2dUNDArZFRwT20rNkduSytyQ096Yi8z?=
 =?utf-8?B?ZHZTSUl4SnU5TG4zam1zT3dnamZZdkhSV3JjSFg2SVk2RXBycEFiUTFQYklX?=
 =?utf-8?B?cVdjd2VhQ1dBSXBBRU9DQnNVdmtiWUV1bEw2MHNndWVWVmtnTlRscFdoWXBD?=
 =?utf-8?B?RHRGNWpxdHpTc2VPZDRkSW5SVXpheE1ZNk9JcEJhMFdNT3dIek9KTVRvdU5I?=
 =?utf-8?B?VHhMZ1ROenBSNWtGRkdaU1VaYzM4WjFoYXRTaElzS3JzMURTU2x0Q2NabjZY?=
 =?utf-8?B?K0hJUnR3NG9aUCtuNlhFUEs4b0c4anJhaTZWcFNRSGtjZzZZaEtYUnY1aFJO?=
 =?utf-8?B?dE5HWjlKUUhGaVBreVluQkk5YnRHM3RBazdSNlgrVlErRExCOC9TVlVUVHJ0?=
 =?utf-8?B?NWp3L1A1UEVXQjBGMmZnMlBrWTQ4N0YwanE1a2xIUUpjQnQ1RkEyazZlbnRx?=
 =?utf-8?B?cjQ1NUtDa2I5cm9keHE2OU9rb1pVMlhGVGhwTThVR2Y2MjhMK240RWNaVk9C?=
 =?utf-8?B?WklETmYyYm00MXMyTm90K1VrS0lMdFVDOHVvekxONXl3TXJCUnJiOGRJV2lt?=
 =?utf-8?B?SzNPTmZuaWRhQW04ZzliZkFYQzNDZHRGVm00N3Z5bmhzQUxYQ3lVSDFoMnpz?=
 =?utf-8?B?eCtyam1PaGp1S3FtZ3dLMDhXcUVObUppc01OZUcyQmhEU0hMVHRDRHE0STcv?=
 =?utf-8?B?ZlRjeVQ1c3JUanFTTVpabmNpQkk1RGFGZ3o4VlpCSmMvYWdlSGFyb1dVU2Uv?=
 =?utf-8?B?VjVyaG4zZWhlTXRRRUNZUHRKTEl1T3dLQmtWZ2syRUJWQ2ZTRVpFNkZjWlU2?=
 =?utf-8?B?SE5MUkZIMjNLMW43dmpDZkx1VVBWSG9tcmZ6d0lZV3V3R1lOZzN1QkFkcEhQ?=
 =?utf-8?B?UXZJY0psajRvVlVGbXVYRlk1aHh4RDBmbGdrVk1iTnV0MzRDMmVwSXZRRDRy?=
 =?utf-8?B?T1d0b1FPSWw5SFR3MG5yMzdOZlRhRTFmSlN3N25JQnZOdlJPY0Q3bm5aVFBz?=
 =?utf-8?B?Y3YxT24vdUthK010TmRJSThvQ0pCUys2bkdFR3lEbXpHQytkZFhtYmNUdXZj?=
 =?utf-8?B?MmhNdVU1VjR6cXcvT1h4SFpMUEhQZUtrQkVEM1ZUVnFQUnBLZWcxVXliN1gv?=
 =?utf-8?B?WEhkVmlBVit3bElkUjBtMVc1cVFWRVFNY3orQlA4K2VZbVZaKzJHU2Jjb3hy?=
 =?utf-8?B?bFJCK05Tb0p3M3NWQW9ia3RCTS8rYXpIRnhoSDhkbFdqNzJ0bjNZaHRBTDFP?=
 =?utf-8?B?dUcwenU4MCtWeEtNMkVkRC9GR1hrcTFQeHZ5SnpleUlLZEI5VkZ3M3p5T1Jz?=
 =?utf-8?B?OHhkNS9XQnpITFlLT0ZLZ0tmQTluSUVDU2E1bnU4dWlEWmRnd3VMWDRrY0t4?=
 =?utf-8?B?OWYyVjFPRUxqTWlHSTZERVVuVEhKNVpwM1FsVXJubXRZODVSOXlRWE1oTmMw?=
 =?utf-8?B?Ry9nRXVNQUgxS0ljNnk3b2VFME13eWMrQW1jTittTjY4MEVNempyaHlJN0JL?=
 =?utf-8?B?Y2NJOG9oekc2YTFVV0xGTUJkN0pLZzFLR2FYajBLallzYkcvYWFPZWpaYk5O?=
 =?utf-8?B?bnA2QmNsMXd0N2JhRTE3WFZsWUhsL0lURHlxNW5NKzNtVzVxbWR3bCs3OW9L?=
 =?utf-8?B?V2ttYmwwSHQ1cjllT1N0YW9PVndWTnNSM1FQbGJJZ3ZSS3JlVEdqTC8zWDVM?=
 =?utf-8?B?SFlRSURyVlVWajBSalE1Zz09?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1314
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6197fe81-66be-4f57-000d-08dcc53abf4b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek1sQXlWSzdDdzhCT3dNcmVjbHVpZUFRRWtYc2IwQlQ2VnAvT0pONEwvcDBq?=
 =?utf-8?B?RU9Kc0UyU3dtQWNWTklPaVBER0tPVmFmTEFndENtdEFUQ0F6SUcyRnppUXc5?=
 =?utf-8?B?ZnB5bE41QVVDK0dNRVZHUzU5T0ZETnFWeEEvZkViUVFOODMwZWhYOW5tY0xM?=
 =?utf-8?B?Vm5QSHNwVjVvVDhVMW1zM1lBRWE3VndYVFRHMWIvZkZaT0pHTUU0SHY5UlhG?=
 =?utf-8?B?Yjd3SndZNWlNSlpHNzRxV1lXYjhKem1kYldoVW1Mc2szOG1yYTJrMEM0U2Ir?=
 =?utf-8?B?M2htTFFteW1CQVRiUS81eHJLYVRZS2FwampObGZFVjBEWElqVi9Na1FqUmxx?=
 =?utf-8?B?UnVxcHFwd3Q1ZTF1dXJIckcxa05jb1NhSWpQNHoyWnRTcjZXZW9pdmtHVzcw?=
 =?utf-8?B?c2dQTWRFeHdRZVFtVTZZT0x4Qlpjd3o3SG1vK0ZKbWhjeDY3cUJQZTc2YTVi?=
 =?utf-8?B?SDlXVXpvVkRtaWNkUUVpUEkydzcyQWU2NVVwTm1zdnRlRXF5a0REQlZGUzJu?=
 =?utf-8?B?L2Y0YkhWeVEySTE5V3lqbkhjU2pQblRSSWN3YkRYN080dklyck52M01EZ08w?=
 =?utf-8?B?THNhOG80N0puS0Z4NDkxT0lva01XZjZOWU9lQ3dXK29lVUJLMUFITTE3L2tE?=
 =?utf-8?B?c0RxeHpxd21iTkhnZkZ1MTdUeG45dnl3UzF4a3NkZ04wb3duRktldHByV0ZC?=
 =?utf-8?B?ZS9ULzQ2TWtaZmxoOXRrLy9JdERFdENmamFSbFlPcXp6aHQ4MndnRHpvTUI2?=
 =?utf-8?B?TDBONEh3dHdtMURaL0c4b2lwWXNkU2dKTXUrcW42V05kbndxZjFXeStuV2lX?=
 =?utf-8?B?L1VrV1ltNlYzZGdqWkpDM1EybmNRNjAxNjVneWxtMWpNNUNic2RqMS9VS3c5?=
 =?utf-8?B?VXdKYVorMkFBcjZVSlM4OWtIYjJrR0s3cld0RWNJSE9xMGllb2ZZTFV1d3BN?=
 =?utf-8?B?NGhOQiszNkJJbTNESzJYUmRpTm5vUHhienZXVnVPOU5Mc3dpZ2FOaS9qVDU1?=
 =?utf-8?B?ZEtVK0R6VHBGbGJXYTQxeS83UDR2TVNtVHhHNkVDZXBTcVNhb0ozYThudzcr?=
 =?utf-8?B?SGlJOHJSS2hCaURtZUlSUUZjSWMwTDNKdCtPdTRKKzJUdElZMGg4SVlEMUE1?=
 =?utf-8?B?R2g5SnJ3bVQvdXhueUgwa0pzSzZkSHdFS2pRUmNUZE5EeURyQ1R2ZzNUdXRZ?=
 =?utf-8?B?aVZ5THZOSkUySVZScVZJdnNRU1lBSlZJY3VadWc3a0xldFc4NFBxM0VGR3Nv?=
 =?utf-8?B?K0NsVHE0ZS9NbUlWcXFaNHRDRG5rV1lzUCtYOUVEZmFTeWZpL2ErV1lUQ2Rl?=
 =?utf-8?B?ZHY2TTdDWXBoRFUrWXYyRnFKK005aEVkZmF6eDU5VUJxS1JxUG90TjVaYnIr?=
 =?utf-8?B?ajVFWmRRb0dKZFh2TmdDVzFSVEFEVVcwRmZhR3psZ2NId3hvUk54OE1SWmQ3?=
 =?utf-8?B?NTNRcGd3YUpGZUZPd0ZyL1IwbWNxY2JCSzhDMmV4Mnp3bWpEQVlnN3hDUUZY?=
 =?utf-8?B?TjFVU1lEbWg0ZlBaU3hCUTdBTjJWVFdvMFN5cG92bnIyNFYzK2ZsS2xyZnB4?=
 =?utf-8?B?elhMMmw3bEhNTHZEVXVoUDA5aGNnRnVNVTZVSXBJWGlpbFEvbURYTGkyUXNQ?=
 =?utf-8?B?MWpqZ05rd0lZTjIreUFFNDBVNGdySXlFQ3dSMFVyMlZoZXVYbzlTTlphcG90?=
 =?utf-8?B?ZDhqWGN2eDd4eUpVRmt2c0U4Kzd1NHlkRS9wckZpY1hFYlVlM3ltVy9hK24v?=
 =?utf-8?B?L3p5cFJVVlFoKzFzQXJmOURhS3dVQlkzRTBDckJSZ0NSSlBYcnh2b2VORnNs?=
 =?utf-8?B?OFBkYjdpaVpKcjNpNEYwdEhpZlZ2R0RBWFJTbkdJOE91b0Y4bjNqVjA5UUdG?=
 =?utf-8?B?TldpWEMvUExvVzg1ZkF3Ymo0ZTJ4NjJpV0dlRlBaanZxQmVZQlFuTFpid1Vu?=
 =?utf-8?Q?jyX99gro516JrJ78gOd7FWqcwRKRVVTB?=
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 19:18:52.3458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa6b6c0-9503-4f45-8cb7-08dcc53ac17c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1746

On 8/24/24 01:07, Tristram.Ha@microchip.com wrote:
> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
> shares some registers and functions in those switches already
> implemented in the KSZ DSA driver.
>
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Thanks to me the naming is somehow coherent now. I've quickly tested it 
with the KSZ8794 I have available to check for possible regressions and 
there's none I could see. So *not* tested with a KSZ8895/64; I don't 
know if that merits the tested-by tag but feel free to add it if you like:

Tested-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Cheers, Pieter


