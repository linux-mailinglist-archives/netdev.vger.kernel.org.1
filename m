Return-Path: <netdev+bounces-188233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70986AABACB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A911706B9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22828DEF8;
	Tue,  6 May 2025 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EW4LtqnM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1422215078;
	Tue,  6 May 2025 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509499; cv=fail; b=kwztBJStlf8mgoB+KjlKl0nnEUWjMY/djZa4F5kWRkm33BPq7h2+/DaANUwDWql6+caajWqyyh/GsIbTTlriS/l7t2w4npgi3iWdWM1mMReDrw7fdbv+S/HVFKb4Hqfbhue6QUFMsY/Uavp8MGmFV6NaZAyV5kOoR3RcRgyz6qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509499; c=relaxed/simple;
	bh=ckTuxLNrIM4lFtmTqyWAEjdJG+nLX9stkTAfXjB2Gtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLS4KcYfcHrs5dBgRM2XRf+F25pX9Eppy01hvhtyjsvQNa+pG5KUHAsyIaEK1zkkdnk2zZompZfNooP/fYvZPfwgw674pt3g5S//bpE+/xjI1TPHyjAg5O9HnL68aov9gbLWbr0h21SIqwXi8kIY0wPN6CNLZq70k0TuPOk8/Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EW4LtqnM; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIbKEZNGOCNE9IFzJHAb1ugzqXbe1jXYvvmjcvb54w7HkAuTeEMgJOOlZPQl+XyX89Qfz6QqF2mq/MGHFP5shpNmARwcHNL4KSN07VHZm5lA9wYXL62qwRysRn6o2XBu9vOienPa3jEppVpck1+JWAx+O/1SjTzg1wDdNfqn3kmxX0OYgSW431kp/eB1BUjdvzhrpXEp50Y+1Lx+uzkRycauua3bz2cIRvFYKQIiVa+hEiBxV7jILTvq+LNM/rJ6kQCN23WeJ8nIywh4CVWpO/yclo4zep7vzGi0XDuFDt8cDej0vvGHypmxZJt4ToM8zMzvTiW/Yt6ZTZbVfmGfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckTuxLNrIM4lFtmTqyWAEjdJG+nLX9stkTAfXjB2Gtc=;
 b=K0Rk2sLjytyMmhPE4m9pcoPUTcs3pSmAcSP3fKXbRCa9LSgFYqSw+ybP+PwlduS5fUxuy6xceLIfQ9m8JyxKS0dyP8RvQCvTEaukjLnAUeTicH0TTflAeKbxIYcyS8hOwrTl1nNldsw1nE+BttjwnEN7VancC8q6lSmBUcoc/1ESrsTfpR4ACdiV3L+Z4ibhkv/u/kGZDE5EVu4ZRmlqoz+diSIqoJlndR1Ya7KYRpqD1o5leIwZrNmQsWPByZNwRn87u1xgYkeSTuZK1YUzyT08cr6bZvQyvTBvUSqJfDa2yAupoQ0qGPfU0tc0mkI6mDRhAGvO78enGjM9fi/1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckTuxLNrIM4lFtmTqyWAEjdJG+nLX9stkTAfXjB2Gtc=;
 b=EW4LtqnMRpMmxYnE7ozR9P0WKFX4QVSrj820PMa7fxAtBhuEE2La08MUnC6+iohlZP1umo87cSM7Ao2zeKRmNY9MqktfA+uYMQaOj5jjL7n5p4a4avQkzXeChij0EOTpUE0w+LjtKPYIsJYsCYiA3VbY5lX6MlIUzy51nOjlFoHH2aT0RBwwxx3uySuHrVINT/sIbC/vQXCAomXjov9JRwjeLdG5KoLHmeavDviliKk1QefllklWszEzbk6j5FUz28+69UWMboHxITzJnJA7YuMo/2yMGeIJUJF9aCiJJ6qD6B8LGPNJQz624f3hsExAjzeUcgUQ8NjDkNrdwNQ11w==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 6 May
 2025 05:31:31 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 05:31:30 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to
 separate detection and MAC configuration
Thread-Topic: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to
 separate detection and MAC configuration
Thread-Index: AQHbvkeQLlq0s7i89km9ljrxl5kPpLPFEqAA
Date: Tue, 6 May 2025 05:31:30 +0000
Message-ID: <c1b45ed298748aafbe3557d637707820bc37e2d2.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-4-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|PH7PR11MB6650:EE_
x-ms-office365-filtering-correlation-id: f1414c32-f6db-4171-c612-08dd8c5f41a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzAzNVdtN3BaeVY0NXd2dHFkOUNWUTd2T2pIRm9kYVkxREdxMjBXRmc2UDJ2?=
 =?utf-8?B?MnFSSXEwNW1xQlFrR2c3U1RUdFFQeUVZc3BrVi84SHUxK1pqR1N3c3cxakdy?=
 =?utf-8?B?MzFQaGJFUnlIL3ZqYnQ4dTFmanlOdERHQ2x6SXVMV0FSR3ZJRFo0bkI3S3JI?=
 =?utf-8?B?RGlhdmlrMVk0R2UrZ21wMnd1YkI2blRqcDFPUndUT2JCRHVRV2ZMbVU4SXVu?=
 =?utf-8?B?OFg4YzFhM3ZNWlVqbmRUM0RybFMwV29zNHRRd28vVnhtTXpIeWl5bG11ZmVG?=
 =?utf-8?B?WGdnS3NzaU80cmRYd0QwanBwME1nSlZhWXE5YklsYUlhNDFTRHVtWmQ1eUJv?=
 =?utf-8?B?NEh1dXRRZDE5S0pEcjJtTi9GN1NGK05DOUZnUnRGT1hxR1JBamNUby9lWk1I?=
 =?utf-8?B?OFA5TWxYWFZrdnh2T0YrbUxza1NZS2ptRkNTN1JRd2ZPbUdpUitneDdyUDlv?=
 =?utf-8?B?MXVyYlIwM1BQUzRGSmdheG93UVdYTVRDcFBSTFlmUWVEclFIV1E1QTZCSFho?=
 =?utf-8?B?ei9GdHl1RUFjQkpLM212WUpjSEpnNDBvUDFLbmFLdTFLUzBnbEtpOUltc0p6?=
 =?utf-8?B?aHY4Y0NabFpIQmZsbnhqZFk1Z2N1NTNPSzhtcXNYREtHSXRueFYrTEVZTHFp?=
 =?utf-8?B?ZURSWG43UTUrWGQwdG1vOFhzbmFLdlFWeG1xNVRZTTM5cXVLWEZlcTJZMHNk?=
 =?utf-8?B?VW5xR0h0WTBUdFpyTk5zaC9TYllPZlZqckV5dGVYRDZ6VE55MWhiVm0vVmVS?=
 =?utf-8?B?VG1KcDVFakNFYkM3VGdOVlBGZGQ1TTEvNm9YRjFVc05TWXVvTGVMUklsRGlr?=
 =?utf-8?B?enZIOWFMMjdBQlFSeFVLVFFra1lpSU0wdVNxUTBZNENmSjRHZXNsd3dVRzRy?=
 =?utf-8?B?eXBIbjVVUDR2NjF5eU9TcFd5RlBiMHl3VXd4WVF6R3YyT0lKL0xRL3lJQ2Er?=
 =?utf-8?B?UHZzOVQ1ZGpuRDFvakQybisvbXllOE9kdzZJSjlVRHlrRE9xYTJ5NWdVd1oz?=
 =?utf-8?B?SnZydGxjV29tL3ZIeklrbnJUNi9XazlVdWtMVHRHUzVRK1g3T0xwUHp0Z1ZP?=
 =?utf-8?B?dVgvR3ptQUxudmR6cTN0UmwrQW5leWVkZVdMMVpqbEVhRDRTZ2FKUGQyR0pn?=
 =?utf-8?B?aVRDWnMzMEZwSzlxTkxJT1JSQzJwaUN2Sml2dEc0SVhVK2o3aTRHWjArLy81?=
 =?utf-8?B?VllBZ0srS3dMNGpXdjFkSm5SYktLNW1ta1VFak83S0lsN1BzWEQ3WXEwVk9o?=
 =?utf-8?B?RUpOd2NhWWd4SjUwNmpkeU1CT1pLOGlKSTZXUU1Za3Y3RXUvdXQ1ZmxGYVJL?=
 =?utf-8?B?VVlHSVczdnlDTDNvVlpZSUtsNjZlV0pHVVltbVh6Z1AvSVg0QjZZWDlCQ3Jr?=
 =?utf-8?B?TG5EMlIwMXpFc3ZGOExJZFJRY090TWp5TWJydXFaMXMwZkRNRnFEWlRQODJY?=
 =?utf-8?B?ZS9uN0RyeVJ6b3V2WWxiWnBIbUQxSi9WbWtJZlhHeS82dW15OVE5OHJWYnhT?=
 =?utf-8?B?aEFONUU2Q2o5MHB0eDRadG1mNk1HZkZMVmpaNGM4ZTJtNzJlSkhiN0Y2WVZ1?=
 =?utf-8?B?VjgrS3kzY2R5TUZuaGZuWUZwMSt1MHdWOFB5NHZueEIxbDNOTGNwT2JqZnhL?=
 =?utf-8?B?RUJkRTBZQ0pSNFQ3VVNzRGxBdGtEQlZrbFMvcG9ZM3V6Q3F1K2JKcnRBTjN2?=
 =?utf-8?B?RnA2T3BKeXhVanVRSnBrM1NuU3JwSXRlM2ZTUFRta1dGcy9wMjhkUjVsd1R3?=
 =?utf-8?B?VytoRHRzV1FrT2RFMUYrNU52VEJZbEV2bXBpTnU2b2NSbmhNd0FHek45NHBK?=
 =?utf-8?B?bDRuUUtCdnBHM05YSGFaTTBoSHhFVU92T3RmbXJFTGxmL1pLMkFOblZzQkdX?=
 =?utf-8?B?ZnpzcHpoclhPMHFFZEhyM3RuT0pBZnFGT2R1VVl5T05KZ1VMUG4xeXpOMHMz?=
 =?utf-8?B?ZWFobk51NFJYQzRBMS9YenJzUHljN1Nmc2RYeXhEMUpyWkhTaE9SYW52dlI3?=
 =?utf-8?Q?8CkLogkayMp7C15mPbCBqZWjovSZuw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGFOcDZFU20xdzB1UlFxNWd5a0hkRFRRZVA5NjFFdkViR1VkM2Fudmp5R2c3?=
 =?utf-8?B?UnA4OTRQSVAvYmtDbE9aeUtFcllVbHprLzNzZSs5dURTZ3NwcjhNRk5sWWZ1?=
 =?utf-8?B?VE5yK0syVjJyRDJ4U3pSWklvclJKdklsZ2N2Z1o2TEJhem5ZSWJudm56am9R?=
 =?utf-8?B?QjdURGl0Zlc3ZmN2TTgyNW1naEtjSEFSWml1WnF2VzludmdjTTRTdXJaV0sz?=
 =?utf-8?B?ZlkyRHJpRXAvUlNHd1FNNEJIa3Z0NlUvVCtva3Y3aE8vMFFWVE5Qa0tNbU9q?=
 =?utf-8?B?K2JKdHBON3dsQ0o4WHJEdWlKK2N4ZFZISndqZW41N1ZPTkcveXJFKzZ2K0ZG?=
 =?utf-8?B?cjRuWFhHdXExeEQrZTlOLzA1SXFoTlZoN3RLaytHRk5GN2xMOXQ3RnNJRnZQ?=
 =?utf-8?B?SmR0eHlQWXV6VGtTVmJlalBqRGNLTVEveDgwWXkrajh6NXdBZVMzUHQ2ZHlN?=
 =?utf-8?B?NVN3dXFSaVlsdEtRZHhzOTlFUXVGY3UzdkllZi94SGM1eU0xcDRjMVplTzhz?=
 =?utf-8?B?Vld0bGh0ZDlPSnhNcUlwUFJHelZjZ3J1eGRVWGgxRmxWZ1V6NjA3UWZKcmFQ?=
 =?utf-8?B?QmFDZUlUcWRndEdYd3NBSkJRR3dQbFlrd0Z0Wno1dm94OHZmMU5RK2g3M1ZI?=
 =?utf-8?B?T1RobjJJL1dGOThMaVpIWDVneXBzd0dMcmo3M3FlbVRwamNvWmwxUVgrUlht?=
 =?utf-8?B?OTZWcU8xSTcrR01SMXhLNyt0TnlHQ0hDS21ySjBONDBqbjNFUUpEeUROUjF5?=
 =?utf-8?B?Qi9qQ0xmalZodmRlSEV3KzRrN2JsM3NtNlRPVldhdERzdUtHNmxtS1dYNElt?=
 =?utf-8?B?ODUrOEVRTEZBbEd5clRkNGdGeElCM2pRSXZMREVSNUg4eXh5ZGpadkxVZFI0?=
 =?utf-8?B?RE54ajhENkt4ZnlnSkxsOHN3Vm93ZHVpWkZGVEZXc2VucDk5eUY1UTIwTG0r?=
 =?utf-8?B?ODA2M1laZGE3Y3JKcXE3NGZJeHhYdWdwRFE3SlpvamlNMzR6OFZRZUsrU2lt?=
 =?utf-8?B?SFdQc1gwKzh2SUFOcUlpVmZWQVJhMTc5QkRzRU93aHpaR2s3TmQ5OG5KT2p4?=
 =?utf-8?B?bk9nMmFibUNueGRyQkxDdWs0clZnN3RyaXY2YUZ0VFVaakhBTjVOSjd6TXcw?=
 =?utf-8?B?WTYxOW85bzcyeGJWQkZ4c0tSUVJlTTFnTkpHZ1VlNmxmU3Byek5ydDhFVGFD?=
 =?utf-8?B?WUV0KzdHaVppQVNWU0tCc1hhUWZ0OWRTZlpVbVFiVnpXZ0diTXcrYThMNjdO?=
 =?utf-8?B?dUQza0wwNUFYR0FOS0tON3VFYlViZGRoN3Jsanh4dFZXNG1hSTJUbVh6L3d3?=
 =?utf-8?B?d0ZWVG92dEMrY2dCOUVPRnBFQ2xnVE4xdzNwTGlsZjVUR2N6dmRyMk9vUjE5?=
 =?utf-8?B?a3dma0tNVVhEMjV1eVk3WjBzQldEWHhST2J6Y21aZGh4VEJ6TWROeFZwN2Uz?=
 =?utf-8?B?R0hHQ3U3dEp4ZSsvUHBsS0NoZXJFTXFjc21DakRUYWp5RFVrdVplY0V2Tm8x?=
 =?utf-8?B?MXRPRU8wR3dyeFpJc0M2TGRSNm5QTGl2c1NZeGsrVEVidEljdW9aN1hOMER2?=
 =?utf-8?B?Mm1yRGdBODRQaVFqSFBOL09KNXBzUDltNEFDR2NKREhONURld1Fwc3p6dFhP?=
 =?utf-8?B?Q3c3K2Vxa21CekZxanl1Q3VtQ3REMHZabGEzejdWUjJuTzZESzFZbVZWbmwr?=
 =?utf-8?B?TVJVZTZFeWpoM0FUZzZtU2lFTWVObjF6Y010THZvYytGc0J0cVJjQlloYklP?=
 =?utf-8?B?YlFEYm5sUTFtMzc4OHpIQStHQ3dJSFZLZGl5dTRidXM5QzQwYVFka3lFY2xh?=
 =?utf-8?B?MFcvOE0vR0V1cEFPMWxzK21zRDVuRnE1Tkx1LzBtQVdQSjZDcEZzM3FTVit5?=
 =?utf-8?B?N1Q2ejhabWR1NG1WTVhrazF3Q1U0VzVzaFJXR3ZtbFZFckh1NTUrcTZhQjJV?=
 =?utf-8?B?bTdWdWRhMHBXSzBqSStrQldFdzlZSVNGN2dBZURxcWFrWmN5YmRhNUI0aU55?=
 =?utf-8?B?a0x0c0J5YkdrL3ZjV21yR3dQc3RMWlQ2ZkdKWlZUZndqL3M0L1J3WkxRQU1M?=
 =?utf-8?B?ZjZ5N2NzdklGV2ppUEhVZm5JalcydE43VmlxTGdFT2Vod0RsQlVyWHhFbzdC?=
 =?utf-8?B?NUI0WUxaMFdtRlRsWFlTK0ZqSTRJTnFMR3lQVXpKNWJuZktWOHJsM2pKQnBV?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA78E6BDB1111B40B04F251FADFCCB02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1414c32-f6db-4171-c612-08dd8c5f41a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 05:31:30.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bml8XUC4UqL36csmvA2BTSDP9mJNLSBYDM7L+t+uQd2HFIupoZZX1eotN4F7J1mXwpgmtaiibvXAhARi/IrDWqbIosfoY6rOuWsx7kgmT6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650

SGkgT2xla3NqLg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCk9uIE1vbiwgMjAyNS0wNS0wNSBh
dCAxMDo0MyArMDIwMCwgT2xla3NpaiBSZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU3BsaXQgb3V0IFBIWSBkZXRlY3Rpb24gaW50byBs
YW43OHh4X2dldF9waHkoKSBhbmQgTUFDLXNpZGUgc2V0dXANCj4gaW50bw0KPiBsYW43OHh4X21h
Y19wcmVwYXJlX2Zvcl9waHkoKSwgbWFraW5nIHRoZSBtYWluIGxhbjc4eHhfcGh5X2luaXQoKQ0K
PiBjbGVhbmVyDQo+IGFuZCBlYXNpZXIgdG8gZm9sbG93Lg0KPiANCj4gVGhpcyBpbXByb3ZlcyBz
ZXBhcmF0aW9uIG9mIGNvbmNlcm5zIGFuZCBwcmVwYXJlcyB0aGUgY29kZSBmb3IgYQ0KPiBmdXR1
cmUNCj4gdHJhbnNpdGlvbiB0byBwaHlsaW5rLiBGaXhlZCBQSFkgcmVnaXN0cmF0aW9uIGFuZCBp
bnRlcmZhY2Ugc2VsZWN0aW9uDQo+IGFyZSBub3cgaGFuZGxlZCBpbiBsYW43OHh4X2dldF9waHko
KSwgd2hpbGUgTUFDLXNpZGUgZGVsYXkNCj4gY29uZmlndXJhdGlvbg0KPiBpcyBkb25lIGluIGxh
bjc4eHhfbWFjX3ByZXBhcmVfZm9yX3BoeSgpLg0KPiANCj4gVGhlIGZpeGVkIFBIWSBmYWxsYmFj
ayBpcyBwcmVzZXJ2ZWQgZm9yIHNldHVwcyBsaWtlIEVWQi1LU1o5ODk3LTEsDQo+IHdoZXJlIExB
Tjc4MDEgY29ubmVjdHMgZGlyZWN0bHkgdG8gYSBLU1ogc3dpdGNoIHdpdGhvdXQgYSBzdGFuZGFy
ZA0KPiBQSFkNCj4gb3IgZGV2aWNlIHRyZWUgc3VwcG9ydC4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlcyBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxv
LnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgdjY6DQo+IC0gdGhpcyBw
YXRjaCBpcyBhZGRlZCBpbiB2Ng0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMg
fCAxNzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAtLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMgYi9kcml2ZXJzL25ldC91c2IvbGFu
Nzh4eC5jDQo+IGluZGV4IDljMDY1ODIyN2JkZS4uN2YxZWNjNDE1ZDUzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3VzYi9sYW43
OHh4LmMNCj4gQEAgLTI1MDgsNTMgKzI1MDgsMTQ1IEBAIHN0YXRpYyB2b2lkIGxhbjc4eHhfcmVt
b3ZlX2lycV9kb21haW4oc3RydWN0DQo+IGxhbjc4eHhfbmV0ICpkZXYpDQo+ICAgICAgICAgZGV2
LT5kb21haW5fZGF0YS5pcnFkb21haW4gPSBOVUxMOw0KPiAgfQ0KPiANCj4gDQo+ICBzdGF0aWMg
aW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYpDQo+IEBAIC0yNTY0
LDMxICsyNjU2LDEzIEBAIHN0YXRpYyBpbnQgbGFuNzh4eF9waHlfaW5pdChzdHJ1Y3QNCj4gbGFu
Nzh4eF9uZXQgKmRldikNCj4gICAgICAgICB1MzIgbWlpX2FkdjsNCj4gICAgICAgICBzdHJ1Y3Qg
cGh5X2RldmljZSAqcGh5ZGV2Ow0KPiANCj4gLSAgICAgICBzd2l0Y2ggKGRldi0+Y2hpcGlkKSB7
DQo+IC0gICAgICAgY2FzZSBJRF9SRVZfQ0hJUF9JRF83ODAxXzoNCj4gLSAgICAgICAgICAgICAg
IHBoeWRldiA9IGxhbjc4MDFfcGh5X2luaXQoZGV2KTsNCj4gLSAgICAgICAgICAgICAgIGlmIChJ
U19FUlIocGh5ZGV2KSkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZXJyKGRl
di0+bmV0LCAibGFuNzgwMTogZmFpbGVkIHRvIGluaXQNCj4gUEhZOiAlcGVcbiIsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGh5ZGV2KTsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIocGh5ZGV2KTsNCj4gLSAgICAgICAgICAgICAgIH0NCj4g
LSAgICAgICAgICAgICAgIGJyZWFrOw0KPiAtDQo+IC0gICAgICAgY2FzZSBJRF9SRVZfQ0hJUF9J
RF83ODAwXzoNCj4gLSAgICAgICBjYXNlIElEX1JFVl9DSElQX0lEXzc4NTBfOg0KPiAtICAgICAg
ICAgICAgICAgcGh5ZGV2ID0gcGh5X2ZpbmRfZmlyc3QoZGV2LT5tZGlvYnVzKTsNCj4gLSAgICAg
ICAgICAgICAgIGlmICghcGh5ZGV2KSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG5ldGRl
dl9lcnIoZGV2LT5uZXQsICJubyBQSFkgZm91bmRcbiIpOw0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RFVjsNCj4gLSAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAgICAg
ICAgIHBoeWRldi0+aXNfaW50ZXJuYWwgPSB0cnVlOw0KPiAtICAgICAgICAgICAgICAgZGV2LT5p
bnRlcmZhY2UgPSBQSFlfSU5URVJGQUNFX01PREVfR01JSTsNCj4gLSAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICAgIHBoeWRldiA9IGxhbjc4eHhfZ2V0X3BoeShkZXYpOw0KPiArICAgICAg
IGlmIChJU19FUlIocGh5ZGV2KSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHBo
eWRldik7DQo+IA0KPiAtICAgICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgICAgICAgICBuZXRkZXZf
ZXJyKGRldi0+bmV0LCAiVW5rbm93biBDSElQIElEIGZvdW5kXG4iKTsNCj4gLSAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICByZXQgPSBsYW43OHh4
X21hY19wcmVwYXJlX2Zvcl9waHkoZGV2KTsNCj4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAg
ICAgICAgICAgICAgIGdvdG8gZnJlZV9waHk7DQo+IA0KPiAgICAgICAgIC8qIGlmIHBoeWlycSBp
cyBub3Qgc2V0LCB1c2UgcG9sbGluZyBtb2RlIGluIHBoeWxpYiAqLw0KPiAgICAgICAgIGlmIChk
ZXYtPmRvbWFpbl9kYXRhLnBoeWlycSA+IDApDQo+IEBAIC0yNjYyLDYgKzI3MzYsMTQgQEAgc3Rh
dGljIGludCBsYW43OHh4X3BoeV9pbml0KHN0cnVjdCBsYW43OHh4X25ldA0KPiAqZGV2KQ0KPiAg
ICAgICAgIGRldi0+ZmNfYXV0b25lZyA9IHBoeWRldi0+YXV0b25lZzsNCj4gDQo+ICAgICAgICAg
cmV0dXJuIDA7DQo+ICsNCj4gK2ZyZWVfcGh5Og0KPiArICAgICAgIGlmIChwaHlfaXNfcHNldWRv
X2ZpeGVkX2xpbmsocGh5ZGV2KSkgew0KPiArICAgICAgICAgICAgICAgZml4ZWRfcGh5X3VucmVn
aXN0ZXIocGh5ZGV2KTsNCj4gKyAgICAgICAgICAgICAgIHBoeV9kZXZpY2VfZnJlZShwaHlkZXYp
Ow0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQoNCkNvdWxk
IHNlZSBhcyBwZXIgaW1wbGVtZW50YXRpb24sIHRoaXMgY2FzZSBtaWdodCBoaXQgb24gbm9ybWFs
IHBoeQ0Kb3RoZXIgdGhhbiBmaXhlZC1waHkgdG9vLiBTaG91bGQgd2Ugbm90IGFkZCBhbnkgY2xl
YW51cCBmb3IgcGh5ZGV2DQpoZXJlPw0KDQpUaGFua3MsDQpUaGFuZ2FyYWogU2FteW5hdGhhbg0K
PiANCj4gIHN0YXRpYyBpbnQgbGFuNzh4eF9zZXRfcnhfbWF4X2ZyYW1lX2xlbmd0aChzdHJ1Y3Qg
bGFuNzh4eF9uZXQgKmRldiwNCj4gaW50IHNpemUpDQo+IC0tDQo+IDIuMzkuNQ0KPiANCg==

