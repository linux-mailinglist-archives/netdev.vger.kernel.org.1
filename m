Return-Path: <netdev+bounces-177553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44131A70880
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F727A20F3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D17C263F24;
	Tue, 25 Mar 2025 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yLdktNM8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C04823DE;
	Tue, 25 Mar 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925070; cv=fail; b=l658ZDcZY/VSS+FtayQW4Vp85wGSaHZNoJO7NjB8fIMCc1CC5098yRof6C0DFQKPXb8C+WZciZ5K8XJf5odgebIlTTyEf+LHxWnPChIG5yyTM3JYhnp3uLeBDEZxB1Mqj4gQpMj8UTqV7zPrtIja+rmsKpSoGhoF67Mt5aJD5Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925070; c=relaxed/simple;
	bh=d1fcUHGPK12+OiUt94JfHbo9bw+qD1ff+kR5MMNp11I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5QFU5rCzYYcoiw790GdKzGDKBtazrSVdaEZ21Z0JwKrq7JJ+R6a6Lm5g+kFmcyJKMyHDtFF8+mJ/9b7nK9SwcNZ5jWhBV79lmXqwmaNUPeCanCrKhoKdkGSWrlLnU3Xhvbju/wDUr5Z4eOu0DYTa1vYXDJ+tETeCmHy0NBsu2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yLdktNM8; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whCGsvEYa7UO8eUxdki0o+9NC/C2trZ1K1UzNQS8UchFM4w1ImIB7V+w7Qa4rZz6qL4LhAPEaxhv9ygsghO05TxcnEFOfYFBiFIXrN5ef17sxjCuL32HYitSRqMM+zu0+tQlP9ATnv4HL9OyXtpOuJDWo9+nKaATGArjnFPHnhDWBlj+DfXYGHeQp+a6pkRpT8WnJtv7cDlnZndAESjrM4/SG3kLwKoGMBmFCtn0yKiV1iEi9Z53NYmaDOyQ6TajcY7eCar8z48RN/ZVcPjBFS4GZF1py9M1GQ8JGfuBiCczcZzOht2iOZbtQLOQr8r1YRZG8cNjUJTa7ZKdH574aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1fcUHGPK12+OiUt94JfHbo9bw+qD1ff+kR5MMNp11I=;
 b=QUOnCZuLFRsZ+7WJH5rAXbnhtrQtYvianZyAm53W3Z2MOlE4+GygGqmVEnrUkXBVABh8saZBxsrPdwvJI5BBSTfgQZsrRKi6PZJSjbo7ZOuhlVITJ31pyCaqudAs3tv5wju/rE3ZkBmTTeRTHrGLNK+zHRTB1dP1FwognNIXHxpSebVH+Ni/g7YBcz9lQe8x3WINkoGiYOw62mdLx3TlpZCP65cVlc+J3znI0d3XFasKY2RtIETpIO9MQVoFv9mcGmWaZmHVGHVAmUGVx9v5A73Urc1v5ikSBz6LCVLTiTDWkOVm7kuzsztvE62aiNZBZDAADUagheWvTacjIfQBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1fcUHGPK12+OiUt94JfHbo9bw+qD1ff+kR5MMNp11I=;
 b=yLdktNM8KnVflkBsfMm6/DydgRfurTVh/sVqXIWF99XvRygV7aZtIfYyDHBs1E9ZaGuyi8SARoTv9e232RNnf8Grn/0pDOesi2Mjm0PCP5xKr46L6eO41Ptld0dFwuDOQFyJbeuvPixg3rjo9tjWQbUT7Xfm/4J7Pk6AyEuKb6/ExgULAlzklUnVOXJfkn4xqz83qKPlWddfYAI9EQM+CFbKDqJVmteBl3Mo5X8Cn7To/nRSiK6En/zIaxH/LOHxFR5Yh+6Ra6z4clY/QF9+H23PLfh2opv70VnVkvpT8VdOF+xTTkotffteZzFtDjbtV0KgFvzsJAncBCmz4HH6uA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:51:05 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 17:51:05 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Thangaraj.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 5/6] net: usb: lan78xx: Integrate EEE support
 with phylink LPI API
Thread-Topic: [PATCH net-next v5 5/6] net: usb: lan78xx: Integrate EEE support
 with phylink LPI API
Thread-Index: AQHbmKvwaH9a9CMNgUalGGi9YaD7L7OEKsMA
Date: Tue, 25 Mar 2025 17:51:05 +0000
Message-ID: <7e362f545ac58f35a88f29a3ca36009f7c97090b.camel@microchip.com>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
	 <20250319084952.419051-6-o.rempel@pengutronix.de>
In-Reply-To: <20250319084952.419051-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SN7PR11MB7137:EE_
x-ms-office365-filtering-correlation-id: 78779008-37c0-4256-2434-08dd6bc59dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWFKTEpqaUJwcHk2TGZiNlVZbzFOTFdIZlRaMlVOYzZNeG5KQUR4QUtzTVBJ?=
 =?utf-8?B?UzRJQW5iUmtSL1VHSzliNjFvdytYL0NEWDczc1BGM1BPc0pPU0RqNkkxWmdN?=
 =?utf-8?B?UVBFd053Z0swVk01d0k2WFlOcW41dmxiKzFoVmlwZGVoZGgvbXpFL1UwdHdJ?=
 =?utf-8?B?M3h6c3l1WllaUStsMXNyV1lRVmxZMHg4VGVSdjRETmdVeVBvSlRCVm4xSmtl?=
 =?utf-8?B?SXZWWFlPS1gwZXBjWkNHWC8xM01INHI0Y3B3a05WeWducVpRMVRwRWtHeElO?=
 =?utf-8?B?VzlaOVdPSkFCUHp4dDNaVnA2c3B3czN2dmx0MW9NYlpXSFVDeG1BcmU1QTk4?=
 =?utf-8?B?Mml2S0xVU2FMTWFoMXU1dWcvSWR0ejhCSjFGTktPaDRCOVJFdjRJK04rY002?=
 =?utf-8?B?N1RidDMxVUVzWkRQakpoSHRIM0JjV3J3UmhqUkFNMnNjRVZRbktwdmpic1JZ?=
 =?utf-8?B?RHVaSnEvbVlGRldrZUs2ME1KZHVEd1M4M0FablRGWjcrRDV6ZnRpeVVLUTA4?=
 =?utf-8?B?TUdrRW84eU5rSFV0MFQvazNQeCs3bWtPeDhqM0k5NlZ5M2VMdTJDU2h1WTNT?=
 =?utf-8?B?VVI1dEhDVytha0dJVGRrelNoNVQvMkNOTU15YjRNalB2dnB5NEtDVnE2V2xm?=
 =?utf-8?B?M0krd3FqZE1tMEJISm5Wb0h0S3FFTnNmTXZMRjdwUm90ajU3eDRvWHZxQWp2?=
 =?utf-8?B?T3hGcXhzYWs5enIzaWVoYjRhYTdkZUNMMDlPTXQxT3RmbVJSN3Q1S2hGczE0?=
 =?utf-8?B?T1huSzVGSElCSG5qN0JQSXNLN3RjYWw0S2hOZjIwVEM5QzNvRm9Fc2RUcjAr?=
 =?utf-8?B?R0ZISXBvMkhXOXlTYUdVc2w5enlNczhBYTF4MzV2RmZvRlkyY05NcHlGVUdG?=
 =?utf-8?B?YjhTQzZseU9RbCtTaW41bzczem9xaDNSNDcxQ2J6YnF1bytrQkFSU1RjeEEx?=
 =?utf-8?B?SWU1QkM2NFFudUtaeVVHdk0xZm9aUmRlZS9LdzJrYndQOURkYi9JcTJFSE9y?=
 =?utf-8?B?cHVsaTMzMkNUVEtyaDJLSmZSUEk4b0VQNmE3b1BBZzQ5ODBaNDdvR1FKZW1G?=
 =?utf-8?B?Yno5WkFSa2JiMUtWbWY4UzdlMVhPNmxDTDJRV0dpM2Q5aDB4M1M3TGlWVVNq?=
 =?utf-8?B?UWlTbTFUdkdETDR6MnhvOEEzYVA3akdyTXdveEREL1dXdXpxU0Q4eS9NcStp?=
 =?utf-8?B?cW9Pbjd6VXdGK28xVUgzOW1YcHFWZVk0UFVrc0x6cGFyeC9UaHFaR2R0SEh6?=
 =?utf-8?B?UFU3UnRYWFM3SlZzMGNYNEtheVg0c3ZaSGpsSjBJOWFpVUo1aVpSU0tyL0JR?=
 =?utf-8?B?UGNhck81N3l5b1p3bjRYK00zTE43am1KTXJ6QjdpOW5lWFBoZmtMT3YzdUl4?=
 =?utf-8?B?T0MrTldpL0F3OEpHZXRSdGFxSkhXQzl3dXI3aDNxYnZ2NHA5QjBpSEdqWmIw?=
 =?utf-8?B?YnRQVlpvbjFZNzZ6NGo2bFRPMnFvaExUUDJHU0NyTnBQVUMvb25YZHpoK25n?=
 =?utf-8?B?aGxTMUU4NU1BWnFRTENmNkUzZUE4aGcraXM5SVE0UkJCMEYwYnlzMEVxVlI5?=
 =?utf-8?B?ZUxmay94b283S3J4WWgwa3ZmVWUyLzMrdkN3RjBBbWxXaGxJZ21QaUpKN2hD?=
 =?utf-8?B?UjByU3BoZGx6cUxwYitDc05LSmxzbUh4dzE5RlhXam5CMVU3SlRwY1BEenZu?=
 =?utf-8?B?VVZCWlpvK1d3QTFIcWVUSjVzNXprOEtjcHNrQVRmdlZxa3FsVkNyTmlDazNo?=
 =?utf-8?B?UmF4OElBcGxwYWlXK0txSjNIQlZmY2FPcXI4bVNvOFNJdnlWamIvTURoUVNW?=
 =?utf-8?B?a1FFTVZyb1ZPM2NuWVdtcW8zTzdLZmVvNXB0RGNwZ0ZOU1F0dWovUDRiS3Bk?=
 =?utf-8?B?Z3p4RjA3U3J6NE1jUXdJTHUvVUl3S2pjM0V0eTgxWVZPS3dZUzFKVHVGSmdZ?=
 =?utf-8?Q?MxY8rSmCOjozHEhr1zH9g5fxfKfiyiUt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTlCT3VrQm1yV2pHWVpNZWxhVlJOOEFtb1Zva3hPK0dTQis1OTVSbkFISlZq?=
 =?utf-8?B?aFBnNlBJdExDeVA3UkdHRFJjaGdUNFJPdVhjY25XRDVNUkRocHE4L0lRZnZu?=
 =?utf-8?B?ZldjSDNwaTk2UzhOeWFrQkc1TGlFQnBrQUtLekwxTG9DMWRHSGRIZUkvbjI1?=
 =?utf-8?B?TTVySEIwK3Niam44dGpPbTN4bTBPWHJWUC94Y09PdGNRS0lXbVVzTFNRSk94?=
 =?utf-8?B?TEUrbUVzMWNPWlh5ZGZXellTWmtQcXhqU3ZheTUzaFl1ZndaOHBEamFNcTIv?=
 =?utf-8?B?c0RDWjBZclNIbmVMWUk3K2RkT2s2d2NYUHVrOWdMUlVWc0NVTjBEcWdFV1Ez?=
 =?utf-8?B?VkFKZElPQW5EcVF1NW9SQUFEQURpZkcxYU9pUGlUdU8vbnB3b0FtNHhaQXNn?=
 =?utf-8?B?OE1haVIxWEplaCtjUjlOK3BWYTZ5aktTaGNWb0xJbWZEWmtlZXhOVkZRMTBL?=
 =?utf-8?B?ZTREZ09zc2Q4cFJPWDBKYWhPQmQzczgvanAxVWV4TXpBQ1NQOUE3czVPeU93?=
 =?utf-8?B?d21MWC9WUmJlWEwrZVVzTStWM1JpOE5mUVhnTHBDZEJrZ1FkV21yTHR6SE80?=
 =?utf-8?B?OE5XOVJNdkI5VlhLNEJQOWE2NkVkQXg2QzVoRytzTFBkSW1STlJxRzRaeFRQ?=
 =?utf-8?B?Y2d0RWY2cW1WVU5IOVRKQVVqZnIyOE4zSi9UNFlnQXBhNEtvWVo1WjFOMzRh?=
 =?utf-8?B?MWR1OFBUMGNkYWRwVWJSZDFicEZNQ0d6enZFQ1ZSMFpIeTVvR3pnSDE1QUpO?=
 =?utf-8?B?ekEyMVljTUNKb2d0QWQ2cFU3R1gxUitJTDc0VjFaNy91ZWV1V2U5TnpubjRO?=
 =?utf-8?B?RHRrTkU3VExZM3pNR1hqOGJYVXVHb1h5Zy9wVXJadjRDY0JaYm9nSnhIYXVH?=
 =?utf-8?B?TzRQMWZ2TGY4SFcxY01LZm1JTG9CUmU2cXlpU1dNNWZBVUJrVU4vN1Rvc2hu?=
 =?utf-8?B?N0l0Ykh6UU9ITUxIaUk2R3FMOHJhNFhJNUExUGd1NXFvN0t1bU8yQWtyTlMy?=
 =?utf-8?B?SmlRV21HdkNjbXV0Q3pGeDBBMVZNV0MrdWpEck4yOUJYbm5Za1g2VmkwbDBU?=
 =?utf-8?B?TExpSDFUYlNyRW5YRkJTNXlhUWE0K0hTbkNPTng3NzY1WDdyU2FQakpyOHlh?=
 =?utf-8?B?ZVAzWlFyNWRMbXNJSXd0bEl2RXViTG4renF1ZHprMmVWaTJDZkJIdm0wTlRG?=
 =?utf-8?B?b1V5S08yT1VOMGFkMEVKcG95UWdXTTZRSVFtMFhqM2pPdHNoQ1NvbTQ5ekVX?=
 =?utf-8?B?MDdLN3lXS1U2bHEzQWVSbHNOUWhRUXE0WHdWOW1EWHdhY1RMWC9wM080d1pH?=
 =?utf-8?B?dytzalQxU1RLZGNjL2ZuRHFKRXBYT3ExZ2NQNXVKV2hiQ0c3YjUxcVNzS0Vw?=
 =?utf-8?B?OFl1QkUwUDMrMlVldEdnOFJDaXU4ZWl0S25HMFZsNjhtTVNvN1VhcjNoQytY?=
 =?utf-8?B?d09Tb2FjYm40S2ZheUp0MnQyUXBLU2U0NDE4Vjg4Uk9FLzlhQThEU0d5ZENi?=
 =?utf-8?B?QkRldkk3blZFSTBnTFlsZTN2emVPVmlMWmt2cmtlYkdOa3NjNTJBQ3Z1ZllK?=
 =?utf-8?B?bndYR0hFYngrK2tSZXFBRXFQRWJOb0RrbmNmb0U3cFhiR0pDMmpQV2REUHh0?=
 =?utf-8?B?elMrbnJ2VlZrbVpiYWRISFNZYVpFTlk1STdreVZBM0hoNDQwU1NvQjNJY2NZ?=
 =?utf-8?B?Ukh1dGZySFJOZ1B0OGhoQUd0UlpKTEVrS3RUWllNRk5XMmxXdE9DeG5xeVM4?=
 =?utf-8?B?MXA2dDY3dlZyUGppdHprMzBNMFVUSjFMSlMzR2FTM3JCK28rZ0pBN0Fjb2lN?=
 =?utf-8?B?TjliMUFzckpaNE0rTnNZUEhSVzRETlBUZ2t3WWFOSVhzS0NhWDQ3VGFxa2tC?=
 =?utf-8?B?RGx0dHp1YlJCN09pQTg0TnRDNmo5TUpDQUx6bkFNUFZobWZhSlB1KzJRU1lm?=
 =?utf-8?B?L2I3ZFVkR2V3QlBMUEFreThoY2tiWFN2ZmhMWDRVWGEyeTh3cCtVbXhNaGx3?=
 =?utf-8?B?V21oMHh4TGpXazBpNlArREdMWFZWdEwxeksyTXFkdWxhcjJ4M2tocWtYZ0lt?=
 =?utf-8?B?RFJSRHBTa3F2QkZJZUx6bzVYQ2pDTkR2eU5ZellBb1lBR2k0ZGdwUjNBc0Vp?=
 =?utf-8?B?cmlwK2YzM29MMVdQNWh6MXAzaTAzREZJMGxTRVZwazVaU1pTblprdWFxaFhY?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9535D0873AAD84EAD5A02E480F373AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78779008-37c0-4256-2434-08dd6bc59dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 17:51:05.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EX2pyoylz2kdPh/VvFtz+r7JYafSTxQLFophFRG2EhcS1HqrI6kBLkvaGsnyOLH5SwWq8rF+wqRD9usl22EFB8RI27goO4ViEpwM3Y9K2UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137

SGkgT2xla3NpaiwNCg0KT24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjQ5ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBSZWZhY3RvciBFbmVyZ3ktRWZmaWNpZW50IEV0aGVybmV0IChFRUUpIHN1cHBvcnQgaW4g
dGhlIExBTjc4eHgNCj4gZHJpdmVyIHRvDQo+IGZ1bGx5IGludGVncmF0ZSB3aXRoIHRoZSBwaHls
aW5rIExvdyBQb3dlciBJZGxlIChMUEkpIEFQSS4gVGhpcw0KPiBpbmNsdWRlczoNCj4gDQo+IC0g
UmVwbGFjaW5nIGRpcmVjdCBjYWxscyB0byBgcGh5X2V0aHRvb2xfZ2V0X2VlZWAgYW5kDQo+IGBw
aHlfZXRodG9vbF9zZXRfZWVlYA0KPiAgIHdpdGggYHBoeWxpbmtfZXRodG9vbF9nZXRfZWVlYCBh
bmQgYHBoeWxpbmtfZXRodG9vbF9zZXRfZWVlYC4NCj4gLSBJbXBsZW1lbnRpbmcgYC5tYWNfZW5h
YmxlX3R4X2xwaWAgYW5kIGAubWFjX2Rpc2FibGVfdHhfbHBpYCB0bw0KPiBjb250cm9sDQo+ICAg
TFBJIHRyYW5zaXRpb25zIHZpYSBwaHlsaW5rLg0KPiAtIENvbmZpZ3VyaW5nIGBscGlfdGltZXJf
ZGVmYXVsdGAgdG8gYWxpZ24gd2l0aCByZWNvbW1lbmRlZCB2YWx1ZXMNCj4gZnJvbQ0KPiAgIExB
Tjc4MDAgZG9jdW1lbnRhdGlvbi4NCj4gLSBlbnN1cmUgRUVFIGlzIGRpc2FibGVkIG9uIGNvbnRy
b2xsZXIgcmVzZXQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBl
bEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgdjU6DQo+IC0gcmVtb3ZlIHJlZHVu
ZGFudCBlcnJvciBwcmludHMNCj4gY2hhbmdlcyB2MjoNCj4gLSB1c2UgbGF0ZXN0IFBIWWxpbmsg
VFhfTFBJIEFQSQ0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMgfCAxMTEgKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNjcgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYyBiL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMNCj4g
aW5kZXggOWZmOGU3ODUwZTFlLi4wNzRhYzRkMWNiY2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L3VzYi9sYW43OHh4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYw0KPiAN
Cj4gK3N0YXRpYyBpbnQgbGFuNzh4eF9tYWNfZWVlX2VuYWJsZShzdHJ1Y3QgbGFuNzh4eF9uZXQg
KmRldiwgYm9vbA0KPiBlbmFibGUpDQo+ICt7DQo+ICsgICAgICAgdTMyIG1hY19jciA9IDA7DQo+
ICsNCj4gKyAgICAgICBpZiAoZW5hYmxlKQ0KPiArICAgICAgICAgICAgICAgbWFjX2NyIHw9IE1B
Q19DUl9FRUVfRU5fOw0KPiArDQo+ICsgICAgICAgLyogbWFrZSBzdXJlIFRYRU4gYW5kIFJYRU4g
YXJlIGRpc2FibGVkIGJlZm9yZSByZWNvbmZpZ3VyaW5nDQo+IE1BQyAqLw0KPiArICAgICAgIHJl
dHVybiBsYW43OHh4X3VwZGF0ZV9yZWcoZGV2LCBNQUNfQ1IsIE1BQ19DUl9FRUVfRU5fLA0KPiBt
YWNfY3IpOw0KDQpJcyBpdCBwb3NzaWJsZSB0byBhZGQgYSBjaGVjayB0byBtYWtlIHN1cmUgVFhF
TiBhbmQgUlhFTiBhcmUgZGlzYWJsZWQNCmJlZm9yZSB1cGRhdGluZyB0aGUgTUFDLiBJcyBpdCB0
YWtlbiBjYXJlIGJ5IHBoeWxpbmsgaXRzZWxmPw0KDQo+IC0tDQo+IDIuMzkuNQ0KPiANCg==

