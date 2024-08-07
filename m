Return-Path: <netdev+bounces-116318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58461949EB1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1576E28BA8B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A417ADEE;
	Wed,  7 Aug 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rAu00xY0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328E224DC;
	Wed,  7 Aug 2024 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002995; cv=fail; b=DV7NWEqANw7sib1Dth/1gI0yKDl2BE35IvcstlTxnpDCxl91Ma2WqQqOtOy4vKH2DmXabvLSdjRuBXzUqNndXMMk7wtfcUihFumiBvddbbBynXHfGxYpg9Qv9B5xruM3hHEiAPFZjgez0Gw6A194r6/GvGXLxBChyJHT5eCDxJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002995; c=relaxed/simple;
	bh=QyG3wSw8aB22/RPSip/fAiAZtWW4l5p9iNLwCJuc2ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9+J1jErgLzTfL+yzyqD2Z6PiozDvSIPQvMVaVp9mQiiMN07av9coKyb6jagIEsB9Uq2qCycu1LZJ6XuNF8L8MhNVQ8EBqrh+AzPGquNUanf4k22F9inpCTA5DM8K8ejBg9HGkfeRAFEufMizlMzFODsBMTIQwRNReABjlBXeMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rAu00xY0; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARcX1xoXerWaAJCuVRTlKvNUarEyiUnn1KHFKpEoxW+7AYttnqMH3p5SGo1wTRqi5RPI0mPAHpIdLs2lCQsbG1MRhe7624XiP+MU2UxiXlXhe+1tqm7bYBx0KPykbMh2slgqLfW4Gm4x3yfy8skoO9CmmYLuRTJQBUzz5CA1M6KJ85BqhYxUc5OqvgIfMk+s7HfPz6Jnm8Ud03psEtfqcLgDVF3rjHPogts9q+0pEaHY+Zw+GKm18H98MCAR5Ais46TJL0qXiR+gzlbHNIQU3Ghl44HwdRZnNUyD41UzRy1zNUVT229+Nk6AEMeXYJ16jXJImHNNab/SEVx2Uz0nJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyG3wSw8aB22/RPSip/fAiAZtWW4l5p9iNLwCJuc2ho=;
 b=MZx8IjCLMQGf7Isg+eNnlkPSipjVLIk/FCB/2J3N3k1Ld2c+4Vyx4IV556lzAqBzIP9qgiCrQMi2w9bW4StGrhzQUkdPuQpO0ewcYt7y7PITL+tClxbYU/xPUq1qQ1QM7UEMBmpzQ/9BgwhxePUH9YKSN85MuNYTy14IQcDHtn0kgFfdozyUEYMh0PJ8gRWn7Wc6OGiKvx29Fxh39BR60DEOSKjNJ7Yq6xWU6V4AmKVdYvxDZMIb4mJh0irIZBZ6U28ybObsBX8qd7DU59nTP1oK71FFI192NOCCj8ZWQCiKre8n0jw0SFNdIvgIGEi1JJicgnznV2QT9VsThqmxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyG3wSw8aB22/RPSip/fAiAZtWW4l5p9iNLwCJuc2ho=;
 b=rAu00xY0F9vovtoyiouyUx+2mkBjNd+9PwflmnVgfcIMFoOFlJaeH+zpvF16sLwCTW7SrF56ugHz59fpxt5ATbYVQtOYTHsFPuym/fW7w+sTpEI5kYaNCfFBgziuXYX1PY+Z0VRNVTr1uucj5MxoYqS0H5Zdsy4k3WVlcJU5L9sdRCss2rrQl0AUZ6Rr7PW9U1Ff6F3qL/laP3kpHa/BuPPHJIrc4A3DJk6SvxDthVco6oZZFPfpI8kTDZbcZ4Sz+1N7FOp/Y/548bHtJ9bIFThKqa+n43LGYoK05lkpq1v9O76F8TbKJoQ/hW2ZJ66Buhf820EylzDyZSha12WV6Q==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 03:56:29 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 03:56:29 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Topic: [PATCH net-next v3 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Index: AQHa6ASW0GLY1UlANECv4nHjyzRdSrIbLDeA
Date: Wed, 7 Aug 2024 03:56:28 +0000
Message-ID: <adf5cdde46c829519c07cfe466923ecac1033451.camel@microchip.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
	 <20240806132606.1438953-5-vtpieter@gmail.com>
In-Reply-To: <20240806132606.1438953-5-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: d311c7ad-84c6-4735-d56f-08dcb694eac7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmNvYmQrbDgvWnpVVENxUnZwMnUyc2RGRzB6eSt4bmZ6eGpvZW1jRUdDY1Z3?=
 =?utf-8?B?QWFRbVl2SjVuSmJGdVRpTTdha0Ftbk8wc3RoQWtzdnpIbkJsVjJwYzBOTXQw?=
 =?utf-8?B?b0pQY3N4QzIyY2VmSmV3NDBQdGdCRTdRUXB4MmI1SG5uSXVGQ0JRTHd3bjBW?=
 =?utf-8?B?QTVrOWJLQVFySUNyLzl1RlBqTXlrR2d3QWNGdGRPL3dNdGtZcVFQSTk5M3Fy?=
 =?utf-8?B?OWN5bUN4Tm5MT0EzcVBqSVMyZUhvbmkxODJJZlRQS3Fud0FoMnY5dzh5L21y?=
 =?utf-8?B?N1N3SmNaeWlqSE11cTZtdG4xK0NPU2N5Tm4xZmg4YVg3eEpiS0UxMENucG4v?=
 =?utf-8?B?QzBRM2dJVHUzOElVUEZvUVJ2RlBiZkVra2VRd0NTZ3BqZXV1SmtSNkduN1Vs?=
 =?utf-8?B?T1FWWGsyZkk4S1ZIRzgxZFVyTWxvQmtBMjBPbjNmRkE5RFZac0lLcWlkQXBT?=
 =?utf-8?B?V3dzUmdlT1FLaXFWREFaTklzei9VVEtUcnpwS0FmNVMrM0xicmxCWFlpQjhP?=
 =?utf-8?B?UzFFTmlsNkpFZ2M2TVVwRzB5VE1EWmQzSXBFZ2FrbVFPZEhjMFFIOEQwem5l?=
 =?utf-8?B?MHFLNGZLUHJUWjVaU3Y1YkFqY2lhRllnWkhRd1FuTVFOVEFmdFlXSUNFbDVC?=
 =?utf-8?B?RkFHUUV2ZWZYekt5MUpMNCsxcDRaZmNBeFZ3anFlaWx6azloVWRRSWV1U1B1?=
 =?utf-8?B?czZLSUxKNEVaMVc3RUJkYjlnMFVWQzZjQkdUb1MvZkVJQkVnOW9DRGQ4RlZM?=
 =?utf-8?B?WFZNY3djbTh6MUVGSENwMUU1Syt2ek1oYVJXK0pHYlcwNUxQcng0eDVxUXRx?=
 =?utf-8?B?MjRMMm55bEd0M2N0MDRrN0wvRnI2VzNoZkFhU2V5RTdLZUd5eVB6MENIS0R4?=
 =?utf-8?B?VWh0RklFbllxTnQ2ZjIzcXB3WUo0QjVnWlM3VzU2dkhoVmUraUwrb1pJNzll?=
 =?utf-8?B?UnJ3YUpiQkxGWG0xVUY2SmF3Rm1ZTFc2SDNmb2p0TUNOZThVT0VYbXFzeDV1?=
 =?utf-8?B?MkR6KzI2b3pqVzhkQ3U1TmFrTVVlNkIwVFI0YklCSzA4emFXWGljcDhoT2tB?=
 =?utf-8?B?Qi9ySENMb0FPTzh0UmduZlhwZ0l5REZtWGdvUDRncng2aXZHU1hKWWxaOE8x?=
 =?utf-8?B?dWFWZFRoaVpka2FtUGlSdmhCYzBDbWpnZDJ3cTRFZldzNUN6aU12UFBBSjh3?=
 =?utf-8?B?NXQ0RTlUbExMMWFTK256TUFzYXNNN3FGQmY5V2QyZi9OeG9pQ3dzUk42dFlM?=
 =?utf-8?B?d2VzS05oY3JvYWNWMzZtR1VrN0t4a2dyelJDUTN6Tmc0RXJ6ejVQSWRyaWlq?=
 =?utf-8?B?UTBLTHBzbmFyNU1yNWcxYWFTQVJEYmp4TzdDdFF1bE9xMU15RHpnZ2pOK3pY?=
 =?utf-8?B?YlhrbzFYTkc1WVkwVzVLYVQwSHVHRE1iR3p5RVhDTmJDTFU2VTZENEhhMFQ2?=
 =?utf-8?B?WkdycWdWWFBYckF0c3FVK3dEMWRjVUo0T1ZIVGt0VEVyZm8xNHYvSFhPaUpu?=
 =?utf-8?B?NUZmZVhraFJtVE5ONjN2N3UvYXVXY3dLMW85SXE3MHlaa3hTV3hMSkIzYm9u?=
 =?utf-8?B?ck5BMjQyWmordFZ1dlFKK1lvRnd1SzhYeFpma1lDbmFKU0JiYU11djIrYzlE?=
 =?utf-8?B?dTltYkJmUGtNS0RlQUprbitLbW5tVTFTbTREbnJrT1NZZmVpc0VVcWtJRzdu?=
 =?utf-8?B?a3RnaDBmWmxYbU1IeUZqd21JTUhOWDMwbzFhUFdhK3FOZ20vWWlzejlIdFI3?=
 =?utf-8?B?Wkg2SVZ4d0lkaWsvajgrdC9UQVZFd3gxWXBrUy93V0lSQy9SM0JRUmE0Tnpl?=
 =?utf-8?B?SHFZTFFFUzRwQzNlbXlJaUdjZ0NLTFp6YUlPYXR3bFJPTmNGRTB2TFpRN0FB?=
 =?utf-8?B?cDBWb0ovMHRacnJFdEs3WnpkVVFrc2R5UzZLM1pwV0hTeDVnSU9kZlFPT3Bi?=
 =?utf-8?Q?xCROk1P5WF0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dER6R012SGRmVjNacVFWM2lNSzNGRFdrdnVpYS9TaGF1eUZIalBFTzEraVNt?=
 =?utf-8?B?R0JQbStNeW1icEkyUkFCNjN4SzR0c2prdVkvM3R1U29qc3hIb0IrOGtTUnQx?=
 =?utf-8?B?aERlZ0ZHWVNEeEkvMlJSNU80RlBRWnJHdXN1NkRaRFR6SnU2a3pRcWlYRkly?=
 =?utf-8?B?TFFXWjNNSVpESC81d1lkRTNKSk05TXJjMk5rSklMTnYrRGVab2JhNUR6RFJB?=
 =?utf-8?B?alFGY3N0VmNNZlV2MDd0SWxGRFgvSXRBRkhHSjdjcHBLWDRxSUo4eTQwSHVw?=
 =?utf-8?B?L1I4STdYY0xKM1VRWVVKVkYvcEhWZmIrUXljR20vOGhaU2ZzcjVPcnFIdFlN?=
 =?utf-8?B?SFZHdmZOVDFSa1BmVGM3YWFVTCtXZ0JoYkFITTZMWmY1MmYxZlR4UWp1RU1F?=
 =?utf-8?B?MGxrdjYrNGx1aXcxb3craExEUjFBTkxHMm1oamE5cE1JKytBU2JqcFZDZ1Z1?=
 =?utf-8?B?T2JzQUt2c2VZaG9SWkVuY0tvVDhHMy9pY0hiSlR6R2NhQTR1ZE1HZlpPRDRI?=
 =?utf-8?B?cXNVYk5lL1B0RmdaczM4VnNMVG52ZkJwRXZmNjd5Mnl6OUhPanhQWlFodllm?=
 =?utf-8?B?SFloSnpCemVBbHB1anZtOWJCSGEzb2JqL29lQThYcXZPRzRjL1haNjJadG9U?=
 =?utf-8?B?OHpsQnhNalljb0lSUXhrK0xOY2JaL1B4cG1jVS9FTTlNK2E5MEN5Z3ovdFlr?=
 =?utf-8?B?Q2JNYWR5WWxDSG8rRktMVW5GRXJvbWFvK1p3SnkwdEJ6Ujhnc2xGMGc3VzBJ?=
 =?utf-8?B?akpHNEdjaXoyKzZWZlE3NENuRWJxT2taYmw4NjY1RDQ0Mkg2SGR3K1hEWkZF?=
 =?utf-8?B?K2t4R3pNQ1kzUzZNMlNIc0poOEExTXlFc0dsVlVpb2V1anhQSFlJQ0JHdE5q?=
 =?utf-8?B?WWNodE1jSklWS2tsUEtMK2ZqMy9Rb2xXVmF6Y3Bic0FSY01pQnZGbDcrNHBG?=
 =?utf-8?B?TVkyTzdwanQ1Ym1sUWF4VGM2TlgwN3FRZVZaS09tS2pqMkhaWjF4Tyt1blBW?=
 =?utf-8?B?QUx4VmhCeHdqN252emlBaFE0dGx6dTNUNXpHU1g0WWNacnRCY1UydEpQOStj?=
 =?utf-8?B?ZXE3bk1sUkZJRVRUU2w5NklzdmlidFpvUXZDN08yeVcwRFNLRTVhOG56Y2RH?=
 =?utf-8?B?U3ZKM3o3Tm5yZDF2RVBlR1ZXMG9YcTR5bFR1RHdMSXlKbGlXNGJWaWU4MFBh?=
 =?utf-8?B?UnJuWndJdTVoVDZyNEY0ZUZmZXppZDNQbzUwaXo2Rzg3cUMydHA0QlNZMjdr?=
 =?utf-8?B?VmF2VEQ0OXplMGNIZGh6aXUzbDhzT2h5YnB3bXMyalQvWDBYRHpjK1VGRm8z?=
 =?utf-8?B?Ujg5TWNKQVYxTEZwcEFzQWRHL1QvZi85aDdISEdXM3JuSmEzdnZubDZQTmZx?=
 =?utf-8?B?Z1MvSW5BWUoxdnVjZ01yb29zTHBscU80U1Z2N2NjbkxteER1dG1DUDc0amsy?=
 =?utf-8?B?WFZJYmR1TUE3UVk3SGVtNTVQVklZaE5xVjBudEl2cGxaVmhHM0hYdCtuZ1hU?=
 =?utf-8?B?ZnBCOWhtREVicERxZlkzVDhIUlNUaW9ydmpveGQrcEJsNlBVN1NCV1c5RlZj?=
 =?utf-8?B?UXRqMDNKVWhGN3hYckUwUGtEaVpROUlVaDdkS1RUclQ5Z2tVZGpUSTVGNk9F?=
 =?utf-8?B?UFlxUUR1VmlpZGk2SThYc0NNRUF0K3ZYUll0U0t6aUhNUVExc0t3Z2xNM0RW?=
 =?utf-8?B?QmVseTZoME00Rko5djZ4SEFzWEViUUNtR1RmM1VPY3dwUFJxa2NOaytZczRX?=
 =?utf-8?B?UlE0dEhzMEtNamVRY1BGdytXWmxYM3lZanY3VHk3ZkNvdnMwQkR0dWUwaEFy?=
 =?utf-8?B?RlZwbjROOUs4c1phNFdZK2duL295cHJBMmo3Rmp0d0dicVE4WlJvVDY5dlhX?=
 =?utf-8?B?ZEJOUTF6eEl4MnZLQXZuTkFGeHRxd00yTXNlVHV4T2xZaUwwRUw2OGE0NUtD?=
 =?utf-8?B?ZUJ4VXpoZG04T2hOTHE4VzVNcUZJQU9vM3g4c3cwS0JIS1lhd1ozaVEzazBv?=
 =?utf-8?B?K2pLNFN5SlFDVlFLSDRxUDlpdndER2dkemFmc0pqenpTK1RZYjZFQWNaUy9P?=
 =?utf-8?B?RGozN2RhTGpHQ3FPR1B5UWZpb0dZSE11SytDeFQyT0wzSGo5NEt3VVNURVRP?=
 =?utf-8?B?SmtvVitHNkNaZDlEV0ZRNVViVHlrUllFV1NyTS9JMHZqWlFGdFRRZFEwZ2tB?=
 =?utf-8?Q?LS524hN5M6gOoBPrFrxPrIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26AE539D7065984185542701BDFD6DF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d311c7ad-84c6-4735-d56f-08dcb694eac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 03:56:28.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLxwjEXdFscds60ZvFsHmSgzkJsAX1hocgFwbG1FEMIl0P69OKsbM3cN3rctvOB6bHLDCYwjnd+FAiyeGkR7eG0L7Dv9DvXXX5OeSG3GIJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809

SGkgUGlldGVyLA0KDQoNCj4gDQo+ICBzdGF0aWMgY29uc3QgdTMyIGtzejg3OTVfbWFza3NbXSA9
IHsNCj4gQEAgLTM3ODksNyArMzc5NSw3IEBAIHN0YXRpYyB2b2lkIGtzel9nZXRfd29sKHN0cnVj
dCBkc2Ffc3dpdGNoICpkcywNCj4gaW50IHBvcnQsDQo+ICAgICAgICAgdTggcG1lX2N0cmw7DQo+
ICAgICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikpDQo+
ICsgICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikgJiYgIWtzel9pc19rc3o4N3h4KGRldikpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgICAgIGlmICghZGV2LT53YWtldXBf
c291cmNlKQ0KPiBAQCAtMzg0Miw3ICszODQ4LDcgQEAgc3RhdGljIGludCBrc3pfc2V0X3dvbChz
dHJ1Y3QgZHNhX3N3aXRjaCAqZHMsDQo+IGludCBwb3J0LA0KPiAgICAgICAgIGlmICh3b2wtPndv
bG9wdHMgJiB+KFdBS0VfUEhZIHwgV0FLRV9NQUdJQykpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gDQo+IC0gICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikpDQo+ICsgICAg
ICAgaWYgKCFpc19rc3o5NDc3KGRldikgJiYgIWtzel9pc19rc3o4N3h4KGRldikpDQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+IA0KPiAgICAgICAgIGlmICghZGV2LT53
YWtldXBfc291cmNlKQ0KPiBAQCAtMzkwOCwxMiArMzkxNCwxMyBAQCBzdGF0aWMgdm9pZCBrc3pf
d29sX3ByZV9zaHV0ZG93bihzdHJ1Y3QNCj4ga3N6X2RldmljZSAqZGV2LCBib29sICp3b2xfZW5h
YmxlZCkNCj4gIHsNCj4gICAgICAgICBjb25zdCBzdHJ1Y3Qga3N6X2Rldl9vcHMgKm9wcyA9IGRl
di0+ZGV2X29wczsNCj4gICAgICAgICBjb25zdCB1MTYgKnJlZ3MgPSBkZXYtPmluZm8tPnJlZ3M7
DQo+ICsgICAgICAgdTggcG1lX3Bpbl9lbiA9IFBNRV9FTkFCTEU7DQo+ICAgICAgICAgc3RydWN0
IGRzYV9wb3J0ICpkcDsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gICAgICAgICAqd29sX2Vu
YWJsZWQgPSBmYWxzZTsNCj4gDQo+IC0gICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikpDQo+ICsg
ICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikgJiYgIWtzel9pc19rc3o4N3h4KGRldikpDQo+ICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgICAgIGlmICghZGV2LT53YWtldXBfc291
cmNlKQ0KPiBAQCAtMzkzNCw4ICszOTQxLDEzIEBAIHN0YXRpYyB2b2lkIGtzel93b2xfcHJlX3No
dXRkb3duKHN0cnVjdA0KPiBrc3pfZGV2aWNlICpkZXYsIGJvb2wgKndvbF9lbmFibGVkKQ0KPiAg
ICAgICAgIH0NCj4gDQo+ICAgICAgICAgLyogTm93IHdlIGFyZSBzYXZlIHRvIGVuYWJsZSBQTUUg
cGluLiAqLw0KPiAtICAgICAgIGlmICgqd29sX2VuYWJsZWQpDQo+IC0gICAgICAgICAgICAgICBv
cHMtPnBtZV93cml0ZTgoZGV2LCByZWdzW1JFR19TV19QTUVfQ1RSTF0sDQo+IFBNRV9FTkFCTEUp
Ow0KPiArICAgICAgIGlmICgqd29sX2VuYWJsZWQpIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChk
ZXYtPnBtZV9hY3RpdmVfaGlnaCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcG1lX3Bpbl9l
biB8PSBQTUVfUE9MQVJJVFk7DQo+ICsgICAgICAgICAgICAgICBvcHMtPnBtZV93cml0ZTgoZGV2
LCByZWdzW1JFR19TV19QTUVfQ1RSTF0sDQo+IHBtZV9waW5fZW4pOw0KPiArICAgICAgICAgICAg
ICAgaWYgKGtzel9pc19rc3o4N3h4KGRldikpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGtz
el93cml0ZTgoZGV2LCBLU1o4Nzk1X1JFR19JTlRfRU4sDQo+IEtTWjg3OTVfSU5UX1BNRV9NQVNL
KTsNCg0Kbml0cGljazogDQpEbyB3ZSBuZWVkIHRvIHJlbmFtZSByZWdpc3RlciBsaWtlIEtTWjg3
eHhfUkVHX0lOVF9FTiBzaW5jZSBpdCBpcw0KY29tbW9uIHRvIG90aGVyIHN3aXRjaGVzIGFzIHdl
bGw/DQoNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29t
bW9uLmgNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uaA0KPiBpbmRl
eCBjNjBjMjE4YWZhNjQuLmMwYjkzODI1NzI2ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3pfY29tbW9uLmgNCj4gQEAgLTE3NCw2ICsxNzQsNyBAQCBzdHJ1Y3Qga3N6X2Rldmlj
ZSB7DQo+ICAgICAgICAgYm9vbCBzeW5jbGtvXzEyNTsNCj4gICAgICAgICBib29sIHN5bmNsa29f
ZGlzYWJsZTsNCj4gICAgICAgICBib29sIHdha2V1cF9zb3VyY2U7DQo+ICsgICAgICAgYm9vbCBw
bWVfYWN0aXZlX2hpZ2g7DQo+IA0KPiAgICAgICAgIHN0cnVjdCB2bGFuX3RhYmxlICp2bGFuX2Nh
Y2hlOw0KPiANCj4gQEAgLTcxMiw2ICs3MTMsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfbGFu
OTM3eF90eF9waHkoc3RydWN0DQo+IGtzel9kZXZpY2UgKmRldiwgaW50IHBvcnQpDQo+ICAjZGVm
aW5lIFBNRV9FTkFCTEUgICAgICAgICAgICAgICAgICAgICBCSVQoMSkNCj4gICNkZWZpbmUgUE1F
X1BPTEFSSVRZICAgICAgICAgICAgICAgICAgIEJJVCgwKQ0KPiANCj4gKyNkZWZpbmUgS1NaODc5
NV9SRUdfSU5UX0VOICAgICAgICAgICAgIDB4N0QNCj4gKyNkZWZpbmUgS1NaODc5NV9JTlRfUE1F
X01BU0sgICAgICAgICAgIEJJVCg0KQ0KPiArDQo+IA0KPiAtLQ0KPiAyLjQzLjANCj4gDQo=

