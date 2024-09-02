Return-Path: <netdev+bounces-124076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BF967E20
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911F281B58
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA629CE5;
	Mon,  2 Sep 2024 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z4fn8YZD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A31388;
	Mon,  2 Sep 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247524; cv=fail; b=hoQaKGNLhyqEDrfv1rcZjYd0L7Tqnj8s9h7aZx3+QBB6BWNWXdcJvB7Wca+qcu+3U+oao6dNxrJdEUHwbTBtgcF145tQVrZpT1Ru9KCRbztb8Ao1Pox7MqCYLCcVX2glg2lY8OH8U79Id28hj/QynK5cjGo5Ho7wvv8KAR4j3e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247524; c=relaxed/simple;
	bh=Dg6WKNyN4orf8GQZHeRsIa1pxIGjRz4MV12Jmf4m0v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6A/DhJlBTLBLnCOGEYwfiHulZMMuGNJshu84uRe5kMKB5sup9TskFdFJId8AyF/+dDX/0XTz7gTa3ripkLB3/gUbVx30/wvujSeBAI3Pw7mm/3T9aTIwF34Pn24Y8lM6a+Nw0IpOdu5Cf8pCKwdvOKyDHt6GTTZrolER3lRPUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z4fn8YZD; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKVgYx2mHtCkn88p8yC9QTsUcYF2u8kzf8OCD9ZCGyYpNZ6kaU7ZuxKhZ7j51zjgDgAeKCSknhh69fsLGO1A9qkU53v8ZAbT3/rWbomF/HbgDO7gfRXDs8xgI1magzVlvVrQGDD+jqojnth/EfU0d9qL+OY2TPBjj765rbl0ndTsbZAGVAO86AypOx+5JwQaSKhv1/0GS2rWjjyQowC4BJk7GsRk/xqVssZRgvnWEip8OxORA3cfVOzmwpHxItEjQvTiUl1gAEasFsfcjPJYOaqewxJ76IbvH4rZ3mCMJAiTdcliRoKWfoKizbBzbfgXD/FLzWM1vJ+Qkq8JM9+0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg6WKNyN4orf8GQZHeRsIa1pxIGjRz4MV12Jmf4m0v4=;
 b=uKADzxd1pTKHdcJbaBl3epa0+vGC+UUBsFLZLOWGJ4w+rfkoBlTctoNhLa7UCm3NdoldEHCC0NKEYYuoH8eb69XlZB5RcX8z1k/etN4xg5Rw3irB7B2zgUJGy7pNesxQvUtWsDUvStYHKthy4CqsPbg5n8npeRk3fBhKF7Qj/0lYKpIG5s1sduolmiFmlv17HKZA8JmchhkwYGoBjlfKYgfBZ/1VfneBhHA8VmGKcKSZQ7l07KtdxTWyft93IBADUeQcQW+hMmr7sA6U9HHgs1inxytqsnAoD3XvUg/5VM9Se5UxHauLIGOzi87gaat4AF0hGd96Mrn4p8RCaIWDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg6WKNyN4orf8GQZHeRsIa1pxIGjRz4MV12Jmf4m0v4=;
 b=Z4fn8YZDwPnJBnBwJZb7AmWpQkZYSVwkP1YDfhmSDu1TeqiuI3rmXJTYQjIz3dtpuhuIC7En8i98E/6D9TbUPBGjl3Q0zBtKvZ/upO4oGxVLKqE/puvzdyva1t9ms7+wYA851iHjLnUF0f1CcRh9CeuA0dX1zff4+WbsmW9oz/ot+e/akGli5Yv76W1zt6HM6K5hRbrFng8qkDkRy7flv5nnWYNY+AL184p66QyM7T0IZ789L+DMynBfAYFBWgfxq9UQGvYffAhlOscw8f67+cohtGshOYJfwwFnxsHsm2XKrh/eCawG6iQ0d/2OqkB2yaMWHoJorjjd2v7M3wMYwA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 03:25:18 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 03:25:18 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<Tristram.Ha@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: microchip: clean up ksz8_reg
 definition macros
Thread-Topic: [PATCH net-next v2 2/3] net: dsa: microchip: clean up ksz8_reg
 definition macros
Thread-Index: AQHa+ubKemV1HtRNFUqvLWYl30wHSLJD2lUA
Date: Mon, 2 Sep 2024 03:25:18 +0000
Message-ID: <c623e37af06499873dbf3d0e368ea8a269fa672e.camel@microchip.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
	 <20240830141250.30425-3-vtpieter@gmail.com>
In-Reply-To: <20240830141250.30425-3-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SJ0PR11MB5919:EE_
x-ms-office365-filtering-correlation-id: 6ad484c5-08b0-41c5-823d-08dccafede6d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WG1GWXozcDNjWVVKdWd5SWM5TVkvL0NDUk9Hcm45cEMxdmtFR1hqYkxFK2lD?=
 =?utf-8?B?a2lMZm5MZ1VGaC9YSjIrTHEyV25NOEV5TWtveUJrNEdMMHJvazU2Zmsweng5?=
 =?utf-8?B?NzF6ZGFJcWVLTkl2SHJqa0tPOEc0dklYaXBobTJrSk13cmdIOXJVWDEvRmdW?=
 =?utf-8?B?QUdJRFpXTXJkWVIrU01PQ2lqQk14dmRYbTB5UWR4ZGNCVEFiMFl2NUZtaDZj?=
 =?utf-8?B?NTMxYnIvYU4xZlR4ak9xUTBPWFZaYXF3Ky9xaGJmcFdFSmtOTUdUN2laRUh5?=
 =?utf-8?B?T2R2U0cxekMxVnE3c1E0QmV4ZWw4L2RzajhyQjhWVXJDN0hIMFdpeVFZU0lI?=
 =?utf-8?B?TmZ5Mlp1UFRtS041a0pvazlxRjZkZ09DRUNlbXRNeDltU0x2dFpEQmVmaWlH?=
 =?utf-8?B?YlAxY0ZyRk84SVhUcXlDRTRwamxBbGxya3VWbDJMOS80QU5RYmxkUW1XV2pP?=
 =?utf-8?B?WmN1T0FoUnd2eE5YdEI5SWczMzJqeGZXVmZzRXVubWFmSDdrZDZlSWdPN0k3?=
 =?utf-8?B?aWord29MekluN2RjVGNPaEZLcTlLdVpFSWNTeG8vSjlMMGRDMnM3bTF6SVpw?=
 =?utf-8?B?R2RxYUl1ejFZLzN5WjFJNnJvYTAyLyt3WjdSUk1SVnVGNmJZNHBlRk9XNGsx?=
 =?utf-8?B?aWVWYzlRKzYrSXkwaEY3VUd5MUdrNlJJNHdiZllmN01TQnBya2NsTjNjRkhL?=
 =?utf-8?B?eVJvd3p4eE1ZNTB3N2JPR0ZyeWRJaXIxMlJ5Zmw5UjhrVkcrUHlCZWhDeW9X?=
 =?utf-8?B?VkdvTGdYcFhkRU5yU0M4VU9MNGpWUUFnWmkzaFlYUG5BdlpqUzdoMzhLZzY1?=
 =?utf-8?B?Y2o5U3h6OXhuY3Q2b3U4UTFRcmJCL1V4Sk1xNzY0YXJTbUhlV2NFYlBtVmgw?=
 =?utf-8?B?RUZRQXEvUG9JRmRQQ2UydkUwZU9GcVBicHFpVzdCaUhDVG04MDRrQmRuc2dH?=
 =?utf-8?B?andkdGg3dGpkY1A0U2dWNDBMZ1p3ZU1jUzV1RGltcllvMnZDQVNlNW9McXZK?=
 =?utf-8?B?czNNVExqVWExWE9mVWswOWV3eHlWN0pKQXdJWCt1WGI0N1QvZnFmSG5JRk1G?=
 =?utf-8?B?OWR4c0g3ZTZpUlI3V1dnT3RyWHZYT1M1aEwyKzRYbnZwQUw3T1NnSlE1VmdH?=
 =?utf-8?B?cGhSVzlEVzRSaE16VnNEL0pDdlpZcW1pcUYxN2pxUElidW5LTFc4a1FnY2Yz?=
 =?utf-8?B?YmZIaE12S2EvUXNlblYwWkIvdEdmVWxCMUlSTGF1ZGhIZHFPbjdIbzkxbjNv?=
 =?utf-8?B?Y3VJbkRLWlBsZVp4dlViNi9mSW1QNUNBdDN4VXNnRHB3dDI1dmp3bDdneWYy?=
 =?utf-8?B?RTBJNGJnYWR2QWNzUGkrc1lGS2pUN1pkcUVpc0tNRFIrQit2Y2x5WGZwTTU0?=
 =?utf-8?B?RnVEQmFNeVl5UG4zcDBiZE5WZ0crZUVaSlp3NkZ0dTdSbENHZzRKUmhiVzNv?=
 =?utf-8?B?TTREVFltcVh3MEtobDl4TGQyWkM3N0N2S2cyM3JHdUY5cHBncFVGUjFINE4z?=
 =?utf-8?B?eTdsWll4KzM1ZndKTXc1NFJENTlJeDg2bE9OcXV3WFk4MnNzbHFSelBCQ1pD?=
 =?utf-8?B?VDJkVVBiRWpZT3hhc2pXUUJvd0ZXS0pjOFVGOHp3V1NRWXlLYUorcytBdU5J?=
 =?utf-8?B?UzBZQVFLT1pMQzJocVdBaDZPcW5ablA5U0FZMmt6QStOendIR0Y3N0JrYjV1?=
 =?utf-8?B?aTZxcnFnYitWUkxNZkx5U3lmeDNiR3NvZWdEUU5YTENtdmlFNHJlYk1pUkFm?=
 =?utf-8?B?NkxJWFdJZU9mVCtEcWljcCswV2FTRS9FUS9GdkRYaVBMbEg5V0QvTkc3eGRk?=
 =?utf-8?B?MHN2d1RpRm5ST0QrNjZXODUrSmFPVXVJNDVvMWl1Y0RLUitFNVRweHI0QzZy?=
 =?utf-8?B?WDc1dWVNZ1AzcU1YbmFZQjZqOW4zSVU5a1c0Qk0rTmdNUW9ZdC9kUGFxaE1a?=
 =?utf-8?Q?tlCtiAz4+DY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGFGeDNKU3ZIRjlESzg5U3ZHUWdTSU9LMW10Y1dkOVR4bGJFZklzYUU1bkFv?=
 =?utf-8?B?QWFYL0l2clBGNEFxSjlZTmNydlM2OTVlTUpkbld6VGFDQmlraG1UZGRERVBj?=
 =?utf-8?B?bm9CelB0d1BqZjhPd0ovRVpQallDSWsxcXhDK3hHWFEzYmxaM3k4NmhidXlV?=
 =?utf-8?B?QkFWK2piamNnYnRhRmFZSGxiT0dadkNkQmE2UDIzRUl2K0JMUXZ3L1pTaFQ3?=
 =?utf-8?B?a0VSaEdNM1M2T2FCMEY1OWZOOWxRR1FFd2ZYc3Z2WEpGcUFUY1dIVE1rTXpO?=
 =?utf-8?B?MWovTllQOEdDSmJ1SVRXTzErdmhnQ0lRYWxWMHFaRXRlUnhNQnNqYzVIcDEw?=
 =?utf-8?B?dVV6U3N4dSsxM3NQUE5pV25HNEVsRFU1V0k2SXlNUXBFVUZDVlg5SzZIMnA0?=
 =?utf-8?B?Y0tRWGRTNHpoMnQyVjl6VmdhN3BuQ1Jua1hxWVA0N245aU9zeitWRDNxSmVE?=
 =?utf-8?B?QnlLQ3NmSy9pVHlidnhrQVh5NXJFMDY2dGhUMk95LytPQVBGcVhZSGVFaHI4?=
 =?utf-8?B?cWp3TWl1K1RvWEIwZ1FHUFF5eFZodWs2NjJmMFcrbzgySnI5NkVCUmJjbVlB?=
 =?utf-8?B?UTdFR1JFc0hPSjJ6d2VoR1FYRkdvRzllQzdwSjh6THY2MWpKMjZ0WXlnZlBZ?=
 =?utf-8?B?alVSTXlRaERQZU5DbHNiNmZiVGJ6eFhab2MxZ0JSWjRFdnVnMy9rV1VsQi83?=
 =?utf-8?B?WnZlL3dlT25pbXBaNENxRjZoS3hkVE52M2Q0OGdpVG5LcitaT1NqT1FJMFJi?=
 =?utf-8?B?dCtISG5ZNkhnaGgwYmNzS0wrNm5LMFpNb3gvUmhDTjVGRzNWSXNPUVd4UlV2?=
 =?utf-8?B?dkdGUjVvSTVqR241Z21kOE1jbFNjVHk0ZThWQTdvR1FQeTAwdVB0ZUdvSHl0?=
 =?utf-8?B?bDB5anYwbmQzcldQM3d5MHd3V3VkbU9kRlFGUVRreGliTXNUc1BBVlNoQ1lS?=
 =?utf-8?B?QkdpYXhqWmhsNy8yMHYyaitoQnNnQ1ZPTDVMcHZzSmFBcWk3Qk96T2Q3L0h3?=
 =?utf-8?B?Z3JGdytVUm5lQmUrZ1dWMyttajhlZkZ3amNKczFIZ0ZkVW1KZ05lRVp3SGI5?=
 =?utf-8?B?WnpNYmRLT3pBN1hMVTBSN1FwVjZiLzJ6QkVsRzJITDlRclYxelZlOTJRYUlk?=
 =?utf-8?B?cEtlTEZ3L3VubndBT25Rb3B6MEhmN0duZW5NWHFta2tiWFN3RTFMS1ViSDFh?=
 =?utf-8?B?WXkwenRYajdObnRHYlZpZlI3dlZBTkcwR3F0NWFxTmZCMk0xbk0vYnRpZ0NB?=
 =?utf-8?B?Yy9UM2RkM2svemIrRHhnNXdhZlEzemRPdzJvWTZNUFdVVXozZkVScU1JdkRP?=
 =?utf-8?B?SittSks2Q1lVMC9XNUkrT1NoMGdiYzJpKzZ1VlQxS2lqbFpIWGpFQXFzc1gx?=
 =?utf-8?B?KzFMSDZCTEhVZFlURVJObmx5Uzh6Rkt1eFRIWkpDOGxtMG1EZmhaQ3IrTFRY?=
 =?utf-8?B?aTRDV1lOWnRFbUN6MEF4UVZ3SjEwMjA5RjUzTkVYYzNWTm9CQSt2R1UvK3JP?=
 =?utf-8?B?WXhEVm5vR2NsU0pqdXlLdjFhWktPQSt4eThKNVhZWHpIeHp0M1hGZWNBeW1m?=
 =?utf-8?B?eHZHb1VwOFphZUFsSTQzMjFPV3UzQmRwM0NWYVN6Ty96TjBndVZkY1lHL1BG?=
 =?utf-8?B?K2NxRHVJS2RMLy9jMjI2WGF2OFMrVzRNVEhTaXA5QjV0QmV5QzlLV0ROWS9N?=
 =?utf-8?B?UnBmTitHV3FPYkw4MlFSUVI0RDk1SjdWWk0yMTRycDZwdXFEUUZ4cTNra1hm?=
 =?utf-8?B?ZDRuQTI5WFN4SnFzOUNzMGduR2owcCtUeHlxejVoOEx4MDRLV1hRYVdlWWtu?=
 =?utf-8?B?Qi8ra3ZyajEyYzYxakY3QURtSWR6R1Q3SloranJocVZrb0VwTGN0eVNyWWcy?=
 =?utf-8?B?NnpYdmdXVVozQmlyVmplMmRmT3o5NXZqMEl6RGltcUxMZnNWYTQ5Z2VYZCtt?=
 =?utf-8?B?YUtjekd5Uzg2RlhFQyt1UStMbEc2aWVrcFNkb0tHZ1I5NU1VZGEvSVdCQXdN?=
 =?utf-8?B?STI2MU5JTnFDbHdYVS9TMmRNc0pFME9SbWRUdk9ORlZYaWFNNVU1UFNyYVFX?=
 =?utf-8?B?RlJKTjVEd29pWTVEOGxmM3IrVm9iR2F1d2ptZi81YTVVZWtiSDl4bkxOUzB6?=
 =?utf-8?B?TlU4VmR4ZVIvQzBOa0wyaG5KYU90QzJneDFXUmtGRkdmaVJIbFlmb2wydE01?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC998268BE5F7743AC7E80BCA8C6EE7D@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad484c5-08b0-41c5-823d-08dccafede6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:25:18.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZW29lMDQy566KNh7+IWahWhIoVvzPOnEjLq0e/I+JGpHtE8huFNhKT/nj5mwdv33A3SGo0c+ScTwm+yrXZgTgtt5zRPP/QkUWeyovccdvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5919

T24gRnJpLCAyMDI0LTA4LTMwIGF0IDE2OjEyICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IFJl
bW92ZSBtYWNyb3MgdGhhdCBhcmUgYWxyZWFkeSBkZWZpbmVkIGF0IG1vcmUgYXBwcm9wcmlhdGUg
cGxhY2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIu
dmFuLnRyYXBwZW5AY2Vybi5jaD4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFt
YWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

