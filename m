Return-Path: <netdev+bounces-208642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E0B0C7CD
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DDF3ADB86
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E102DCC03;
	Mon, 21 Jul 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KSCiQqNh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49128D840;
	Mon, 21 Jul 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112347; cv=fail; b=P5K3mBJk5iue35dpJwJ/Si1zE0cp2KPQTroT3Ok8+TxQ+uX7P1eZl4xryIBjgZvaAd2ByHcKMXEjoWwBC8eUTWD3gSiaz7wNu75n7THHB4Ay5jn6iTZ7+pzpQ5kOVKFWUDjlOh9KkdWryiu4HBh2fPkD2D83dwGpb+iqwGjyb+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112347; c=relaxed/simple;
	bh=nk0Zs4ag4/C2imRv/wFpr5JfzVZbId9+XlofyPInTHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7p+q9gV8RJ4FmNoHT7hKG3ha1HO+mgETnamtQzY2F0wdCi3Gd9oa3U/MbM5UKYh13aeSR2IX2eQn3eUd+nIkH5T7giwdRdnaaqlIrVMdB96DG43xr4XZxZVDD3FYWRVzA+qtfnax9YnPzb5Y4Us5EkVx6/NPD1PZznJUfmYB00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KSCiQqNh; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4RQde8Ek2gNgm+UHA3M2RCRnHGuZud6xIvE/awDA1w06k+VaPHfcT7/pMNPUfbNHG8hLda/JiXCgILu0J3NAMHPkT7z+t9dRN0roWBrleL7FmeB7Cy7wM5jOj60uYQhp6040I5sGncO6tyybv2rp8pUt4sjsetzUHVCX7rc8IKNsEqpnF021xQVoos2866w+KOH48w1q60ZwJ8Lnwybjv+No1IkZBvHxO/Erm2eEt/M7sFUmzvijPN1fAktI6gT+YyZYZkbwp2MiJ7L80LTnCpXIQiQ0blZ8mjs/caERIWzGQnYWQrx2ADi6YS4XsTPJSvo9NUK5BkugCPXbLGY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk0Zs4ag4/C2imRv/wFpr5JfzVZbId9+XlofyPInTHA=;
 b=C2WPrqbmrHSvVVHMPWR+O+7h0ZQFZpwNJ9CoR+ZKt2qYwfjhntKTKR2qZ0FRFkNXU2xRjOgiJro6ISo4WVaLTeKWlvcXzBBZXOOscmlOtrlTG1bfWDiCIb2W++eMi1KF2cu4AlR0gPaspbeeMezShZvtzDdNXpjMwmZx3PO4n2L6UvkYxMy97YyRgx3ptOjBCH+Z3Oa4AUk25dodxjqk/a3MhmPKrtE7vL/CH5ynqKB3HRgsKcPwZD+8Mv8YWWt1/0JEH9L8bErLoj3tB2ZVWWOje+HeT5rZhZYwbquFs6vXdgvaGSMW8CoUvp3fn/VIv3HIp+IfyEufyManFuK93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk0Zs4ag4/C2imRv/wFpr5JfzVZbId9+XlofyPInTHA=;
 b=KSCiQqNhoqEQtZuV0FmDG0hMW7pRB+BQS1U6ljUrce2yaMwIapqQCl+BlsavH+yIWGdx/jbCsME5T+hPTf5XBFWGdXufEqWxpx9VC5ipdcs/ZXuZzl7HsS3GLQbpb2BcBxcJVPhfMcwD1/gytR5YVvXgyDmClK0K9RcirO/HM6voV7ZR6yd4mMpmrD28abwi4aSQcX/OZPBRw2j3kp3MxKRxgf9Nnt/Hze2zpUEk7WXL5ofEkkgz58X49SYdWLXLaKI1u91gEFMYIQKNmEJBAjTYfzQk9TsdlwpwHg+Z1A+aLAAuOxXfz3J32A7kk23z6EipJ90C3XDWe1tLFaWpBQ==
Received: from DM3PPF67FA1A8F8.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f28) by DM4PR11MB5279.namprd11.prod.outlook.com
 (2603:10b6:5:38a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 15:39:02 +0000
Received: from DM3PPF67FA1A8F8.namprd11.prod.outlook.com
 ([fe80::d637:ae6f:b9ae:1893]) by DM3PPF67FA1A8F8.namprd11.prod.outlook.com
 ([fe80::d637:ae6f:b9ae:1893%2]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 15:39:02 +0000
From: <Ryan.Wanner@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
Thread-Topic: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
Thread-Index: AQHb9N2ZRK1y4aNm2Ey7p6ZMKqp/erQ3vJIAgAUE3IA=
Date: Mon, 21 Jul 2025 15:39:02 +0000
Message-ID: <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
 <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
 <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
In-Reply-To: <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF67FA1A8F8:EE_|DM4PR11MB5279:EE_
x-ms-office365-filtering-correlation-id: b48bfd9d-bd6c-44ea-d5ab-08ddc86cb7dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czFVcGlmaWt2TjF4cEFmWXVONSs5YmhKeDRuc0ZWZ1I4ME5LZk1zQTI2Z1l3?=
 =?utf-8?B?NXNyYmVhN3VvZUh6OHFZZm50NXBETTcwR3p0T0ppTVhEQTBEUDNNdk4vVS9M?=
 =?utf-8?B?TzJqdkxQRGtNcC9YMW5wcDY0UXFLZHphbzlyZlIwekwwTDBZLy9meCs5NC9t?=
 =?utf-8?B?Q2FDNmRpS3oyNXlMYW5TTnJMVExPTzFYTnRDN1FBdHJBT3ZUWm5ldXZGVTFS?=
 =?utf-8?B?NUpIbG1xZmJMQmE3Z1M2L3hRZnorNi9BRWl2aXkxT2VIWE15ZjQwenJhTnI3?=
 =?utf-8?B?OGQ1d3ZlbC95bnd1M1hPbVNpSmFCT1Q1b0FWSVhkRlIvUzJwbDJoWFVHM1Jm?=
 =?utf-8?B?ZkxyUitpMjk5TGgxcUNQWGpmckZNZ3IyY3NLcEFKYlBzV2ZRVXg0amJJS05C?=
 =?utf-8?B?VEN3VnpKZEx1dkJYeklVU0hpWnVYVFptQjhWL1NqN3hZUmdicUhWK1VuTG1Z?=
 =?utf-8?B?YlRiQnN3QkJsYXFYRi9ra2N3VGMwTEhOU3FleFRQUjJVK1Q3T2k1Y2JnQW0v?=
 =?utf-8?B?QmN3MnlDY1MrNnZzR2FFbkVnd3Z4VW1HV0ltTlowM3l3ZjYvRWRZQ1gxOHFs?=
 =?utf-8?B?RXN6OWtZQ2RqMWRqRjBQRGQ2TWZlc0NsZG41MDJidUtVSDE3QlhsaUNYUVlJ?=
 =?utf-8?B?ZjQ2eldXVmQyNTFYZFU0YXF5a0wxc2E5OU5Rc3JYNzNjQTJzVWtxNTFlZHJH?=
 =?utf-8?B?cDJCVHd6NjBTeVdBeVJobnVna21hYmtJSWQ1cnZJS2tvSGt1dzZBekZmbTgy?=
 =?utf-8?B?RXVkUTg1YXJsOFp3aXZsZ1ZvQXN2MjB0NlgwVjlsTk8zaUtZdGlZOEZaZ3Zl?=
 =?utf-8?B?TTM1dmxLUnRnNDZtRW8xMXRkbWVIaDdGckxXNkg0cDB5S1U1WEZXb0ROS3Zy?=
 =?utf-8?B?QWRpQUFzNGk2b3JIRDlDYmpGNFVaWlNjMTlBLzJiRUQ2UDdDZmpVblJSeTI2?=
 =?utf-8?B?ZW9IWEZqUXFFTGlpTjY4SDFaQ29PWk8zcjdReE5peGtDekRnNXpqc0RsYjFW?=
 =?utf-8?B?NGNhUURJT1lWdndGTnJxT3lZNnQ2aGJqMkp2dENCV1NneU5JVExtYVA0VFlT?=
 =?utf-8?B?YisrMWJXa2dQL3hyU0psVnNpdndXK0Y5L2VUL1dqd2FNd1oxR3d1WksvZjR1?=
 =?utf-8?B?OEpGTUxrcHh4UUkzd01aZHNXR0JMbEhvNU9maGNJc0NFNCtpUm1uSzYwOUJa?=
 =?utf-8?B?ck41R3hPTnBjbU0vUEdwbnR4RXZ5VUQ0eWZZNVJVdG1kRk1iaGRtdVQyZ3BU?=
 =?utf-8?B?dVBvcDhKZFpjT24zdXJtWi9VV2pVaU5oaVFuSWY0YmtuMnFPUFhxWlA4ZXVK?=
 =?utf-8?B?d1cwd1lQL3A2OGhMb0QzMnh6d20yR1o3dGZNSEROMm12cFUyamIrUHRQWWRL?=
 =?utf-8?B?enBXT1hjZ0thQm5KNWV4alNMMUFhMmYvcVBaaVZoc1U3bCtwQ0swTGF6eGxF?=
 =?utf-8?B?ZTVQYWVraFZrek9TaWxjaHpUbnF1TEZxY25ySmNOMUxCQmJjV0VXWGJLOFZm?=
 =?utf-8?B?dWdsT3VuQWE0M3AzeG1aQVB3TGx6UWFpdkh6ZDNMa3RSeHdTNXJiTHFzSXo2?=
 =?utf-8?B?MDQrVG5KZkllbWtGR2ZON1Z5UUxGVVh6bENTVHhOUkNQRS81TDdrbWhjNFBM?=
 =?utf-8?B?MHlYV3hGaEF1WE1CQXZQU3ZaZzZuVUlGZ1dCTzFZVFFKUTRjRUE2Z2c5bitV?=
 =?utf-8?B?RzY4alFVVFdpam1rWjhYYlhUTUpUOTN5TFBURUJBOXRzUS8xSHhydmxMNTRC?=
 =?utf-8?B?aDhycUdyQ1oyNVhENUtoYUxYWXdOcXRxdzMwUm1pQTlFTEVIM1F5OGNLbnB2?=
 =?utf-8?B?TGlHZE5pc1pGY0JNMUVXMHhhT2JhalNnUm4vUm1EeDlhbmY2MzRMN3YweThC?=
 =?utf-8?B?UGJWdkMrekczN3cxZzRTNXdubG5FWWx4T2NPWFdJR3ptMzVXTTUwLzdEYUxv?=
 =?utf-8?B?ZFZpQURGZFBXMHlDajVzUUlOTjNVTEpodWduUGVEQmdwYU5sRG9GVHZqK3BR?=
 =?utf-8?Q?nJmGkuodtji0tsPriHFOuKKM3Uq7jQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF67FA1A8F8.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ny9tVVVXUUpVNDZBNEtjYTVNckVOb3J4TzdQZ2l2bmhXZ2Vsd1grZHNaK3c4?=
 =?utf-8?B?Tm5vbkpEWkJic2RMZGFsekpsMjZaQW4waU1kK0FUTlBMeG02VmhZRXNvcG5F?=
 =?utf-8?B?Y2FzWmtmYWRzVzcvcnJtQ0RsOU9SNTVRZWxlV3g4VHZUMWI1WTB5c080cVRv?=
 =?utf-8?B?Sm9nUFluUW0vd2pNenByVEk0aXpqblJReTRiLzl5REdQNDdpby9vamlzbm9w?=
 =?utf-8?B?Qm1MYVpEenJ1YWs2UXB1V09lNGJpY1d2UnZiclJua3NYaDlUSDZYQTZYWTYv?=
 =?utf-8?B?ZnM4VWhic1AwWTlycWtQRWlKQ1ZzelN2c3pITWNlclZCL05JQ2x6cC9rVXI1?=
 =?utf-8?B?K2FXY2g5SkJuNEdla1dNRVFRZVE2TzMvZTFIbmh0c2ZxdTZhTDlRWlJRd3BR?=
 =?utf-8?B?enRVZTBhVHAzcFREa1c1SmZsSGRVaEhiUmpKY3ptUnFMelFGcU9kN25TU0Fx?=
 =?utf-8?B?M1VnVVE1MmVGSkhwQzlnS0dVMVBaWlhYcGxDTElzdCtJMTNRUFMrdEZjMjJK?=
 =?utf-8?B?cnppa0YvV2NUSnBsa1RuV0tBa2ZaL2lLVE10ME53eTJKS0paN2RBR29UODhl?=
 =?utf-8?B?NC9kZVI5ZjJhRnZGSzAyVGNjYWZDaDFNM2Fwc1dqR0RrclRCMnh5RUE1YmZj?=
 =?utf-8?B?UkZQTnBIdE9kbEZ3V0tUbVhnWEsxNGVEMXhSb2FESkxCcTR1TWpzMUN6aGI3?=
 =?utf-8?B?aFBJQzNtUVdWMUtqT2dDVEdISmF5OUx4eUZhY2IzcGJjemJIQVpJbWtBbjBY?=
 =?utf-8?B?cnR2OWo0emFha3FZU3pIcWFiNVpjcGxHb21nanlYTUJlWU54TDZTMDhFaDQr?=
 =?utf-8?B?bTZRcnVCUXlOa2xURXMzZEpXK3B0MzZibU5iVStvMTM1dlVWOGdOc0tWUnEw?=
 =?utf-8?B?bEZKemI3QnNhVUVGMjBDa3hacnNoaHArb1BXZmxxMEQ2RmZYUklOaExHUFpP?=
 =?utf-8?B?cVRSa1BTRmRmWFA2QU0zQ28zWE9LbDR0SVYzK3cvWHFXcjV5dUJFTXlLMlNT?=
 =?utf-8?B?OXFLWUtkTEcxOTA5OElycmFkQkRzc0FEUUt6Q1FOd3VDRFlKWlAxbi9xS2Ra?=
 =?utf-8?B?dVI2VzJuc1Fib2hkanFPckI1dFIxcWlaZFZEN1NSVVo5SzRxdDRvWTVMcXhH?=
 =?utf-8?B?aUpqME1GVWFtZGFYcVMxNlAySlRxSGV5eVMrOTJwMFAwcmZQVjg1dGRrM045?=
 =?utf-8?B?UjNYSVo4eEg3WURGVVVScnhINGJmdzlnTXFOMzd1MVM1OUNnSWhLZTVTM1R6?=
 =?utf-8?B?NlN0KzI4eVMxSDhoSkZQZHBFbHkwTGZTTXFqOVFBV05QbFFscXM0QmxXNkFC?=
 =?utf-8?B?b2hTaXBDS1dsNVN2QXlYdDc0T3ZVWG1aamo3alJocEY5b04wTmFrTklaSVBi?=
 =?utf-8?B?ek9VaHZ0MHFRQUlLNCs1Yk94UCtwMWp2SXJCc2U2YnNNQmlCZFNYT0tYQktL?=
 =?utf-8?B?cEU1QzVpQWFnRUdVSWtlUC9NWVkrTDE4K2pqTDh3VFZTd3hYWlZSOGliQ1g4?=
 =?utf-8?B?a3E3K3FRSFNNV2NDUFFncUw4MFYralA0ckZacUxsblJCWUI5RUp4RzBTNXlu?=
 =?utf-8?B?YUliSnhtOWdDVDBJVllUd0hvL1hLTzIxZEdGMmhDRGRiTWpMdHhXM0g4cVdP?=
 =?utf-8?B?UmZ1YVUwOUo3MFVUTER0MHNUY1RwQ0NSdHlnV3F5SmhZNk5kNkJ1ZjFkZXN4?=
 =?utf-8?B?dHcyeWY1NkU5RmtROE82OUQ2cHRqWjBSdGdra2Q3aDA4Uk1EMFNRV0dBdjI4?=
 =?utf-8?B?RWh1YjBLQ3NBMzdHKy8zdnNBbzhlb2t1Yld6ait2S0dSTkVaRjdydm9RYm1W?=
 =?utf-8?B?Wm4xckNlQmNHTlAwbjRoQjFIS0x0Qk5WYzEvWU5SOWVaek5XVmJ6cUl6V01z?=
 =?utf-8?B?aTRYcG1zdzYzU2tRMWM3c3pHMzNiOEo4eEthZjQ4cWJNSHo0dG9hREJWZEFY?=
 =?utf-8?B?Znp0c3FZUU9JYXgxNFM4SXpMWGVhSjJNNWRmeVA3NXgzR3BWYUZLZlRkVkky?=
 =?utf-8?B?YlFFVHJEeVB6S2tBQTE5MmNpbUNuZmJsS2lJYWwzRXU2RXhETnV6b2lKUm1X?=
 =?utf-8?B?MUFoMERzL3FqRWJNQ3kzNWdNaStDaDJOOVFYQXkzdUpwZkRabEQrY0NPVnl1?=
 =?utf-8?Q?RFZ/N/0a2CGqchzgwn81X59Af?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE317407986F6D4DAD5335F41A4EEE49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF67FA1A8F8.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48bfd9d-bd6c-44ea-d5ab-08ddc86cb7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 15:39:02.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbJhsysm9gLg3EC+jPRVeJG0G3Kd0XCBrHXSCDOAwirUcZPdXsBS10bB4s6eP0Wrl9WMuAnz249aFntXJuN9SmSiTS7vznivxPIppqa9ncA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279

T24gNy8xOC8yNSAwNDowMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksIFJ5YW4sDQo+IA0KPiBPbiAxNC4wNy4yMDI1
IDE5OjM3LCBSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogUnlhbiBX
YW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gUmVtb3ZlIFVTQVJJT19D
TEtFTiBmbGFnIHNpbmNlIHRoaXMgaXMgbm93IGEgZGV2aWNlIHRyZWUgYXJndW1lbnQgYW5kDQo+
IA0KPiBzL1VTQVJJT19DTEtFTi9VU1JJT19IQVNfQ0xLRU4gaGVyZSBhbmQgaW4gdGl0bGUgYXMg
d2VsbC4NCj4gDQo+PiBub3QgZml4ZWQgdG8gdGhlIFNvQy4NCj4+DQo+PiBUaGlzIHdpbGwgaW5z
dGVhZCBiZSBzZWxlY3RlZCBieSB0aGUgImNkbnMscmVmY2xrLWV4dCINCj4+IGRldmljZSB0cmVl
IHByb3BlcnR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gV2FubmVyIDxSeWFuLldhbm5l
ckBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5j
ZS9tYWNiX21haW4uYyB8IDMgKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jYWRlbmNlL21hY2JfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNi
X21haW4uYw0KPj4gaW5kZXggNTE2NjcyNjNjMDFkLi5jZDU0ZTQwNjU2OTAgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+PiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+PiBAQCAtNTExMyw4ICs1
MTEzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtYWNiX2NvbmZpZyBzYW1hN2c1X2dlbV9jb25m
aWcgPSB7DQo+Pg0KPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWFjYl9jb25maWcgc2FtYTdnNV9l
bWFjX2NvbmZpZyA9IHsNCj4+ICAgICAgIC5jYXBzID0gTUFDQl9DQVBTX1VTUklPX0RFRkFVTFRf
SVNfTUlJX0dNSUkgfA0KPj4gLSAgICAgICAgICAgICBNQUNCX0NBUFNfVVNSSU9fSEFTX0NMS0VO
IHwgTUFDQl9DQVBTX01JSU9OUkdNSUkgfA0KPiANCj4gV2lsbCBvbGQgRFRCcyBzdGlsbCB3b3Jr
IHdpdGggbmV3IGtlcm5lbHMgd2l0aCB0aGlzIGNoYW5nZT8NCg0KVGhhdCB3YXMgbXkgYXNzdW1w
dGlvbiwgYnV0IGl0IHNlZW1zIGl0IHdvdWxkIGJlIHNhZmVyIHRvIGtlZXAgdGhpcw0KcHJvcGVy
dHkgZm9yIHRoaXMgSVAgYW5kIGltcGxlbWVudCB0aGlzIGR0IGZsYWcgcHJvcGVydHkgb24gSVBz
IHRoYXQgZG8NCm5vdCBhbHJlYWR5IGhhdmUgIE1BQ0JfQ0FQU19VU1JJT19IQVNfQ0xLRU4gcHJv
cGVydHkuDQoNClJ5YW4NCj4gDQo+IFRoYW5rIHlvdSwNCj4gQ2xhdWRpdQ0KPiANCj4+IC0gICAg
ICAgICAgICAgTUFDQl9DQVBTX0dFTV9IQVNfUFRQLA0KPj4gKyAgICAgICAgICAgICBNQUNCX0NB
UFNfTUlJT05SR01JSSB8IE1BQ0JfQ0FQU19HRU1fSEFTX1BUUCwNCj4+ICAgICAgIC5kbWFfYnVy
c3RfbGVuZ3RoID0gMTYsDQo+PiAgICAgICAuY2xrX2luaXQgPSBtYWNiX2Nsa19pbml0LA0KPj4g
ICAgICAgLmluaXQgPSBtYWNiX2luaXQsDQo+IA0KDQo=

