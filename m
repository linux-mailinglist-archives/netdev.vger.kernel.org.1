Return-Path: <netdev+bounces-117629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73E94EA34
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CC61C21426
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492CF16DEB1;
	Mon, 12 Aug 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="MugnCe1m"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022078.outbound.protection.outlook.com [52.101.66.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125E16D4DE
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455977; cv=fail; b=Q7WJL61gKLcLdCNCO7NpbAwXz7813sT68hxP6H2yyWERA+OlDxO38Xkjq1uSwc6fY8tD34zFfaPXefYznbmpH7PlgrvuMowTV12JQNSLQQTgSFVuiIGYf0Syka80JuiYPzRaGZJAgh1+US497ioh7JLGh2T/NSjQjOQXNROzKyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455977; c=relaxed/simple;
	bh=9cqRzOJjcaeubQVY8WC2FxhSak94q60odmdQxt7Ea2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quWunLKQcs6wzRYu3n2VaB5rAdukGFxogWUmFQFT8ZjSrBZhc62YPtcKUSRotkBLlFUNlAN7ngRkOnM6nTip9TlJ8tvgH9LowpRnw/zSJ4jE8fH7ygH/qkZmebtTfm6sseUEYAbG9IUQpcnLHquawJjsQ8So+rSOJFe4bJrzepA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=MugnCe1m; arc=fail smtp.client-ip=52.101.66.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5Nw1ZiFC20UQ/36lKMaMnqfcbfslXT3lJVzpLbuWCjDsmpsAvlA54xE2xOnxeHqX2bcA2dVIUTkUbgMvrgGjKNXRw6pj/33fAYrPo5hZdppqeaq8+411wd+vdc7BitMy1P1OXd4ySLWoAIn4Pg6bR12RzUUVVAvzwyO8nre+y7IA8LMDprgrYmycVpaXtwjdOu0PBUbvw1SlGlXSD+vLBDcFynrkL+GaN6QH2H1Yk9bEro8R+GXgFwFl5lH3FKdek6zd2CmyUSv4TAuZ+UexGLAj7zt/20j/DdeafyvIXuTGxXFkjEJTLwmfdSJrDySqmO4DA2qoKRda2jEafGSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cqRzOJjcaeubQVY8WC2FxhSak94q60odmdQxt7Ea2A=;
 b=oS0yjxw4ido5bqK2EtG4U5qlIAW23Gv0hUZ6S9kINs8gWkLx/Ui7YTr8AJ/W53sf0J0L0kP9smGD7VHk9jSdi0KbgrW8aT42n3IQq4i/rcACHWqXCAhpKtkZQ2Ap1XU9fDgJ7ofdiC3w2ebMUO9XN1/aFkXfNhgJNiuqFswmvY93cIDex4juYfgvz2Si6YXRPZtPqk/SUA3PCeRmH7ear+6c/ExOqa4t7cI9BDqO9OPk8aqJpWhCvRPqp0tq+DYkIT72J7AsNMAkJQbrRJIU/djU6dPRNCHoOY13zhV83utq/x2sr4earkht3Rq2rkMOCJj2MpIRxmGXVnU5zrH3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cqRzOJjcaeubQVY8WC2FxhSak94q60odmdQxt7Ea2A=;
 b=MugnCe1mgRxRruC6Kf2mJEDMP4EtoTz/VqB6CL/y3CSXs6Znm6lPm+LbL50y2CB0JURxfXmhuCvRAcBg6K8Pj/ww5vEFAJv8zQlam28dx/76M4wclFOUD/oq6XmmXmn6/wf0yFS0nhphP5l3t2WExY3LEx/r6u/XTZNJw/JajME=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by GVXPR03MB10851.eurprd03.prod.outlook.com
 (2603:10a6:150:21b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:46:09 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:46:08 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "dsahern@gmail.com" <dsahern@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 0/2] iproute2: ss: clarify build warnings when building
 with libbpf 0.5.0
Thread-Topic: [PATCH 0/2] iproute2: ss: clarify build warnings when building
 with libbpf 0.5.0
Thread-Index: AQHa7D5IPDa/He0aDk+3TqXXSu+JZ7IisyAAgACtS4A=
Date: Mon, 12 Aug 2024 09:46:08 +0000
Message-ID: <d225ab70f7c7c07905c72ecad1c0f3b94a7b5a10.camel@esd.eu>
References: <20240811223135.1173783-1-stefan.maetje@esd.eu>
	 <20240811162552.75adee22@hermes.local>
In-Reply-To: <20240811162552.75adee22@hermes.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|GVXPR03MB10851:EE_
x-ms-office365-filtering-correlation-id: 0b25e021-2a42-4667-9c92-08dcbab397d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTM1YWQ0U21mVVdoRnZDQlNXbGV1emNqekJHY2JEU2svR1Bpc3g0QXBIbDFJ?=
 =?utf-8?B?VmhQSXdyK25xOXpxTjF5YkhPMG9oMDcvVmxHVTdWRTUvU05HUnByazdHbW1O?=
 =?utf-8?B?MS9aRmhaWThHUi9ueCtkTjhqSDFVVGdHUWNXSEY2ODZ2Kyt6Q2VvNS93SEE0?=
 =?utf-8?B?SlUzZGV0TUU1VldGNzdvMHhaSVM3QzM0djhqY3dhbG1HVVN5bnV2Q0hsMmo5?=
 =?utf-8?B?VWZtQ1Y3elZXMk5zU1RrbVNZMTlrYXVlOXo3dXdKd1ZaTHpuTXl2RFpjOEww?=
 =?utf-8?B?L0FaNE9XU0FOZVFhM29rTFozbTh0RkJlbnJldkRQS2dzQ0M3MVZQODl3dDRC?=
 =?utf-8?B?VW44SGhQQVp4K3hTRjNySUJVelB3ZjMycno2VVhuTE5CaVA1eHA2RGRFalB3?=
 =?utf-8?B?My9aRXlNNTJWb1hZZWh3SSswYlFkTEZtVThsVUZXdFNkWTE3bERZZ2UyNTFV?=
 =?utf-8?B?akJEUTNaZXd3dytrYzJIVG1Gb1dGcHJRSzdxVEpaMHhRK1VlS1l3UUFKKzVu?=
 =?utf-8?B?aUNZNUkzSjU3T0xxQzJZaWlCcXc2dWJwSGFMZVlBS1ZFd1dtRnZJVXpzVmxw?=
 =?utf-8?B?ek9RMmlPT2xvc0VsQjJLQ29TWXIraU9abTVLU04yOFVlcnpCcXpOYzlLSGIy?=
 =?utf-8?B?VmFWOUp1WDRBVTlESHVhUVczL3diejNyMm5EakVuK2lHUVdLc25kNXo1TjdM?=
 =?utf-8?B?T3FqcWtxNFU2TEFnQkRBUTA4ZEdXc2MxMFV3ZFRwYklyalRQb2JManJLWXZK?=
 =?utf-8?B?SVl2SS84dUpHZG11TXkxMnR5UklVbnM0bW41VEFhelBMdkc0ZnBKVmpmbVlU?=
 =?utf-8?B?LytMQmpiSFhWcGhQS2NGWlo3RnptTVZpZDR1T1BCcVdnNVRVUUxSVDdpWllw?=
 =?utf-8?B?Szk3NExwUWZWZk9zelY4RkQvbTNwVWFzRTlRd3BQVG51QTFkK2VWRUwyOE9i?=
 =?utf-8?B?aCsvWXdSUGVQeHFjWE82bXNWZlpYbnRzdUZQYmNSVks3QTZsQytoenJodytK?=
 =?utf-8?B?N29PK3RFQTJ2aWtjSjNrWFZ2UDg4UGxFWmxyS1JpTEY1VStGd1gvV3gyeTY3?=
 =?utf-8?B?VGc1ZnhGaFJKTTZIT2hMQXpGRVhrR2E4c1k4SzgycFFUNEtZVEtQVE1hbThh?=
 =?utf-8?B?NUh4VHlIazNpeEVTT3VLTVNUTnZ0WHEyYyt1V1c0TTFob3R3bjRUcDZlWXdK?=
 =?utf-8?B?V01sY2VxaVozVVRSQmd3Ri9UV0xrSEtkQTRONzRlMWdiaG4vT1VYUktvbjhl?=
 =?utf-8?B?RUFwNnRYcnliV2tZTCtBTGd1eDRyUnN2RnRrZ3ZEU1ZUN1hRL2NERk0rSVk0?=
 =?utf-8?B?NHk0OVJvTnNjb05GZ1hscWhrblZraXV1d3RqL1FoamIwVkFCK1hNeCt4VzlZ?=
 =?utf-8?B?QXl2YXhNbndUYkZMdFNFeVgvZGxCaVJvRzBFNVJIL0J1ZVJkQVhwK0VlcCt1?=
 =?utf-8?B?UXQzUEZFNEpqbHIwK1g0NjNSR0d6bFVNdS9kUjVaTmU2c2kwVmNyN2kvSmZP?=
 =?utf-8?B?bmdGUTBYRExLOFY2aW9zd2RKSXVmblJIdU40WlAzcFR2ckNXNU1ldDlGMnVz?=
 =?utf-8?B?TDgrVllzemZaand2ZFF1Y0VPRlJVTVhhOThDSms4QTMzbmY2SG9PemRlZHFh?=
 =?utf-8?B?UlVuTmVTTTExRFc1MGx5VWlSTG81eGhiOHg0VVMydXhXeWZmU1BmWlJnOTFq?=
 =?utf-8?B?amxzMUh0am1rSXFpK1U4a0tVOWZvc001LzNab3hJOVhlaFBGQWxZTVNWMkNa?=
 =?utf-8?B?eitPUUFhTHRkejYwUG5iL00rVktkalVLTWdlbHhDTVBvbnBvSlJQd0JtWFZ5?=
 =?utf-8?B?aFZEMWl3WFZMMkdKZUVXQ2xkZ055TU5ydlVVNHJReDBnc2RMNnpqbE1NcEV6?=
 =?utf-8?B?RUZaREhRaU1aVDU2czVmVExTaEZmbVJaeEg2bFU0VThGK2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW5DbkRuS01vWjdLeXJCR3l0cEo2bVFCTmF2MHNDL1lZcjBUWUV5Rzg3aVl1?=
 =?utf-8?B?VkwwNmhLd3o1aWwwMzJrcTZoUGpQVHMwaDZ1VUp2RDN4Z3U3RTRtNlBzRkJC?=
 =?utf-8?B?Zms1Yi8wcExMSmNMMHo4T2Z4ejFzZXZrQkNTUTY4Z3FYRC9Pc0V1eVBCZSt2?=
 =?utf-8?B?Z3BqeXB4c3loY0k5WVpwcVVtb205Q0hQOEI5SnJJOXJLYVltbHMrKzkvM3lj?=
 =?utf-8?B?ZCt1b0pXSXJ5VDdvN05aWUxsd0t0cFd1ZmNBc3hXQzk1UHpiVytwQWpwbEg5?=
 =?utf-8?B?WkozbWF5ZmxnRHFsbE4yWUNVUXh3UE9aQ0dXOVpGUFZuQlZ2ZTNiRHZ5MXZY?=
 =?utf-8?B?aGRsb1VpZXlQR2hxYXZOZS9KRnp3RWx2VVNqZ2tDOFJJTVZTcTVmYXhEeEtl?=
 =?utf-8?B?QUFhZHZjbm1SNGdlMmY1YzBGeFliMEFXZHFWaGJPV0pRbVJxOHhhMXppUExk?=
 =?utf-8?B?M2ttSW03QmRMVnRIWEIyY2hkWDRYYllXK3dpYjRTUFY4QWdwL0p6TFk3MGc4?=
 =?utf-8?B?b0xBcUYxNHUwY2lJd1doQm02Qyt0TWtENzk1R2RqVjhERHNBRFZXQUh3UEhG?=
 =?utf-8?B?TFdsTnlzSDdLeHdTZHl0TlM1dnZPbGJSamNoWGVDcElKUTE0RjRFTEhka1RH?=
 =?utf-8?B?dlVOY1NWMVVVMTRBVld0UjR0MTZ1VXRjNmtkc0cyT3RTUjhYKzNPRTNqeUFu?=
 =?utf-8?B?dVZBbEhMZmVsWVB6YmVRNHk0eDkyU1M4SkRVTGJqd3JrN09udjZuOVhtaXZw?=
 =?utf-8?B?YTVBYUZpN2U2N25vN0ZUbmptTXF0T0ZpdERsSldCbXZLckozb0JqVkRVYjJ1?=
 =?utf-8?B?S3p1TnVOaVlOa2tVaWgyemRUbUsxU2N4dWcrVDZaM0ZIMzZPR1h6Zk5kQ3dk?=
 =?utf-8?B?UFp2NXJObmlqQnZJbngyUVZrM0c3eWtLeUpSdlg5MzErQ2h1dnUrUGxUR0lp?=
 =?utf-8?B?WU9xWVc2WE16RU1xdS9ncDFjMzJBeUxuc0pGbFFNb1crVjBwNlp1OUV0V0xB?=
 =?utf-8?B?ME9RVjdiRUVYRTZtclV0aVYreldxcXlncjFiK1VLVlJDLzlaU1BxeVhiV0U5?=
 =?utf-8?B?UTR6VGJVUGJSQnJzZUJWbFdUZ2NtV0pUTnRLSS90SG9nT1c3OFlGS2F3WWhx?=
 =?utf-8?B?T2F5Rm01Unk0YlJQZ01YVlBkbUxlcE1jbTRyb3B1V1FJWlRTVWlCcFJrUjQv?=
 =?utf-8?B?N2hKbDZDazBpNTd1NjJjS1VNVnJUME8zV1RzcFJ2RmxScU1qaVd6WFJJaWgw?=
 =?utf-8?B?QXJlK3RWYzYwWG0yNkI3cTgxWms3TUwrUVZoalRSeTI5V0ZjQmk3WFRmSXZZ?=
 =?utf-8?B?dG50RVpkMS9VTWkwRkxzY0trRU1CMzBrS3NCNGZ4aXN5ZnBvazNwaXpUVUhy?=
 =?utf-8?B?NkQwUzNyMEJPMkR1cHp3MlhLYzRpa0U5R0NISzlCMDhyM1V6UVNaVDVEeDVi?=
 =?utf-8?B?RDQwUW1XWTlKek5tVWd1TjVscTdMWkF3dll6Y1ZBTEpnaE0wek1SRjAwT2l5?=
 =?utf-8?B?RjdIVU1pQk5pNER3Vjc4a0c5UjZ4WWlibFRIU1ZYR0NmSTNwWjN0UHdja0pN?=
 =?utf-8?B?R3NCbE5XK2dvY0tXZXNsK2VaZ2tSbmRjSnBnc1k0UE14OEg1Y2hmRVRjZXFm?=
 =?utf-8?B?ZndLS25LWU82VVdoK1JZbkd1emRPSEMvczhWOVV5elIwMnFsdHZnSVhEeWxs?=
 =?utf-8?B?aVZITmJncjkwK0RRREhMN2MwNFQ0c08xR05Udnk0S1pDM1VuNllQalF6N1BT?=
 =?utf-8?B?Zjd3RjA1N1FmK01aK2JVZi9XNEFNTkZpaVdLUTkxS0hRb3d2aDZRamlaMkJ0?=
 =?utf-8?B?NGNmUldsVzVUbmcxbk1ZbnlOQ0d2aUozNDBVVy9TZ0htTzF3WDExQ3RLVDNm?=
 =?utf-8?B?WDFMRzRFWDdaN0JsSzNNamxydzlIZmNXM2pyM0JPV1cvMHIrMVh4bGREM0Fu?=
 =?utf-8?B?NkUvMXpITFUxeStnS2VFR3NWRHBSNTdtMVpMVHJEZnk0YjVkcWIrbGY3Zkx0?=
 =?utf-8?B?SHZseGFETkFydWQzTU81bkF3MGQ3NFVZSmVaK2EwQWJvRkpoVWs2VCs3QVlz?=
 =?utf-8?B?ZnpRb1UzMDI1b2xQZUcrSzNPK1ltbjVoaGFJWFlaNHNseGlGM2JhUndxWkpO?=
 =?utf-8?B?NHBzYmxDMFc5RkpHVzZMaXhBa2cxUmdvL21MLy9ZaEx5VU9NMXNmQXVhTnR4?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2D09B639BACC948B2C3C9FD8A90BA5B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10517.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b25e021-2a42-4667-9c92-08dcbab397d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 09:46:08.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UGzeTk+QhzZ6CaaVxKJLOevuwfYwr9pAGA13gPbxJQdRUB364WECr8Cu1yCToJlGLQE8E7xjljOG1oCZePCJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10851

QW0gU29ubnRhZywgZGVtIDExLjA4LjIwMjQgdW0gMTY6MjUgLTA3MDAgc2NocmllYiBTdGVwaGVu
IEhlbW1pbmdlcjoNCj4gT24gTW9uLCAxMiBBdWcgMjAyNCAwMDozMTozMyArMDIwMA0KPiBTdGVm
YW4gTcOkdGplIDxzdGVmYW4ubWFldGplQGVzZC5ldT4gd3JvdGU6DQo+IA0KPiA+IEhpLA0KPiA+
IHdoZW4gYnVpbGRpbmcgY3VycmVudCBpcHJvdXRlMiBzb3VyY2Ugb24gVWJ1bnR1IDIyLjA0IHdp
dGggbGliYnBmMA0KPiA+IDAuNS4wIGluc3RhbGxlZCwgSSBzdHVtYmxlZCBvdmVyIHRoZSB3YXJu
aW5nICJsaWJicGYgdmVyc2lvbiAwLjUgb3IgDQo+ID4gbGF0ZXIgaXMgcmVxdWlyZWQsIC4uLiIu
IFRoaXMgcHJvbXB0ZWQgbWUgdG8gbG9vayBjbG9zZXIgaGF2aW5nIHRoZQ0KPiA+IHZlcnNpb24g
MC41LjAgaW5zdGFsbGVkIHdoaWNoIHNob3VsZCBzdXBwcmVzcyB0aGlzIHdhcm5pbmcuDQo+ID4g
VGhlIHdhcm5pbmcgbHVyZWQgbWUgaW50byB0aGUgaW1wcmVzc2lvbiB0aGF0IGJ1aWxkaW5nIHdp
dGhvdXQNCj4gPiB3YXJuaW5nIHNob3VsZCBiZSBwb3NzaWJsZSB1c2luZyBsaWJicGYgMC41LjAu
DQo+IA0KPiBXaHkgaXMgdXNpbmcgbmV3IGlwcm91dGUyIG9uIDIgeWVhciBvbGQgZGlzdHJvIGdv
aW5nIHRvIGFkZA0KPiBhbnl0aGluZyBoZXJlPyBFc3BlY2lhbGx5IHdoZW4gQlBGIGhhcyB1bmRl
ciBnb25lIGJyZWFraW5nIEFQSSBjaGFuZ2VzDQo+IG92ZXIgdGhlIHJlY2VudCBwYXN0Lg0KDQpJ
J20gc29ycnkgSSBkaWRuJ3QgbWFrZSBteSBpbnRlbnRpb25zIGNsZWFyLiBVYnVudHUgMjIuMDQg
aXMgYSBMVFMgdmVyc2lvbg0KYW5kIHdpbGwgdGhlcmVmb3JlIG5vdCBnbyBhd2F5IHNvb24uIEFu
ZCBpdHMgdW5mb3J0dW5hdGUgdGhhdCB0aGF5IHBhY2thZ2VkDQp0aGlzIG9sZCBsaWJicGYgdmVy
c2lvbi4NCg0KVGhlIGFpbSBvZiBteSBwYXRjaGVzIHdhcyB0byBicmluZyB0aGUgZmFjdCB0byB5
b3VyIGF0dGVudGlvbiB0aGF0IHRoZSANCnNvdXJjZSBpbXBsaWNpdGVseSBwcm9taXNlcyB0byB3
b3JrIHdpdGggdGhhdCB2ZXJzaW9uIChieSBpc3N1ZWluZyB0aGUgDQp3YXJuaW5nICJsaWJicGYg
dmVyc2lvbiAwLjUgb3IgbGF0ZXIgaXMgcmVxdWlyZWQiKSB3aGljaCBpcyB3cm9uZy4NCg0KSSBv
bmx5IHdhbnRlZCB0byBzYXZlIG90aGVyIHBlb3BsZSdzIHRpbWUgd2hvIGFsc28gbWF5IHRyeSB0
byBmaWd1cmUgb3V0DQp3aHkgdGhlIHdhcm5pbmcgaXMgaXNzdWVkIGV2ZW4gb24gYSAwLjUuMCB2
ZXJzaW9uIHRoYXQgZnVsZmlsbHMgdGhlDQphbm5vdW5jZWQgbWluaW11bSB2ZXJzaW9uIHJlcXVp
cmVtZW50Lg0KDQoNCj4gPiBJIGZvdW5kIG91dCB0aGF0IHRoaXMgd2FybmluZyBjYW1lIGZyb20g
c3MuYyB3aGVyZSBhIGNvbmRpdGlvbmFsDQo+ID4gY29tcGlsZSBwYXRoIGRlcGVuZHMgb24gTElC
QlBGX01BSk9SX1ZFUlNJT04gYW5kIExJQkJQRl9NSU5PUl9WRVJTSU9OLg0KPiA+IE5ld2VyIGxp
YmJwZiB2ZXJzaW9ucyBkZWZpbmUgdGhlc2UgaW4gbGliYnBmX3ZlcnNpb24uaCBidXQgdGhlIGxp
YnJhcnkNCj4gPiB2ZXJzaW9uIDAuNS4wIGFuZCBlYXJsaWVyIG9uIFVidW50dSBhbmQgRGViaWFu
IGRvbid0IHBhY2thZ2UgdGhpcyBoZWFkZXIuDQo+ID4gVGhlIHZlcnNpb24gMC43LjAgb24gRGVi
aWFuIHBhY2thZ2VzIHRoZSBoZWFkZXIgbGliYnBmX3ZlcnNpb24uaC4NCj4gPiANCj4gPiBUaGVy
ZWZvcmUgdGhlc2UgZGVmaW5lcyB3ZXJlIHVuZGVmaW5lZCBkdXJpbmcgdGhlIGJ1aWxkIGFuZCBw
cm9tcHRlZA0KPiA+IHRoZSBvdXRwdXQgb2YgdGhlIHdhcm5pbmcgbWVzc2FnZS4gSSBkZXJpdmVk
IHRoZXNlIHZlcnNpb24gZGVmaW5lcw0KPiA+IGZyb20gdGhlIGxpYnJhcnkgdmVyc2lvbiBpbiB0
aGUgY29uZmlndXJlIHNjcmlwdCBhbmQgcHJvdmlkZWQgdGhlbQ0KPiA+IHZpYSBDRkxBR1MuIFRo
aXMgaXMgdGhlIGZpcnN0IHBhdGNoLg0KPiA+IA0KPiA+IE5vdyBidWlsZGluZyBzcy5jIGFnYWlu
c3QgdGhlIGxpYmJwZiAwLjUuMCB3aXRoIEVOQUJMRV9CUEZfU0tTVE9SQUdFX1NVUFBPUlQNCj4g
PiBlbmFibGVkLCB0cmlnZ2VyZWQgY29tcGlsYXRpb24gZXJyb3JzLiBUaGUgZnVuY3Rpb24gYnRm
X2R1bXBfX25ldyBpcw0KPiA+IHVzZWQgdGhlcmUgd2l0aCBhIGNhbGxpbmcgY29udmVudGlvbiB0
aGF0IHdhcyBpbnRyb2R1Y2VkIHdpdGggbGliYnBmDQo+ID4gdmVyc2lvbiAwLjYuMC4gVGhlcmVm
b3JlIEVOQUJMRV9CUEZfU0tTVE9SQUdFX1NVUFBPUlQgc2hhbGwgb25seSBiZQ0KPiA+IGVuYWJs
ZWQgZm9yIGxpYmJwZiB2ZXJzaW9ucyA+PSAwLjYuMC4NCj4gDQo+IE1pZ2h0IGJlIGJldHRlciBq
dXN0IHRvIGRyb3Agc3VwcG9ydCBmb3Igb2xkIGxpYmJwZiBhbmQgYWxzbw0KPiB0aGUgbGVnYWN5
IG1vZGUuIEhhdmluZyBtdWx0aXBsZSB2ZXJzaW9ucyBtZWFucyB0aGVyZSBpcyBtb3JlIGNvZGUN
Cj4gdGhhdCBkb2Vzbid0IGdldCBjb3ZlcmVkIGJ5IHRlc3RzLg0KDQpJbmNyZWFzaW5nIHRoZSBt
aW5pbXVtIHJlcXVpcmVkIHZlcnNpb24gdG8gMC43LjAgd291bGQgYmUgZmluZSBmb3IgbWUuIFRo
ZW4NCnRoZSBjb25maWd1cmUgc2NyaXB0IHBhdGNoIGNhbiBiZSBkcm9wcGVkIGFuZCB0aGUgc2Vj
b25kIHBhdGNoIG9ubHkgbmVlZHMNCnRvIGhhdmUgdGhlIG1pbmltdW0gTElCQlBGX01JTk9SX1ZF
UlNJT04gbGltaXQgaW5jcmVhc2VkIHRvIDcuDQoNCkkgcHJvdmlkZWQgdGhlIGNvbmZpZ3VyZSBz
Y3JpcHQgcGF0Y2ggb25seSBmb3IgdGhlIGNhc2UgdGhhdCBzb21lYm9keSB3YW50ZWQNCnRvIGNv
bmZpZ3VyZSB0aGUgYnVpbGQgYmFzZWQgb24gdGhlIGV4YWN0IHZlcnNpb24gd2hpY2ggdGhlIEFQ
SSBjaGFuZ2VkIA0KYW5kIEkgaGFkIHRoZSBwYXRjaCBhbHJlYWR5IGluIHBsYWNlIGFueXdheS4N
Cg0KPiBBbHNvLCBjb25maWd1cmUgc2hlbGwgc2NyaXB0IGlzIGdldHRpbmcgdG8gYmUgc28gbWVz
c3ksIGl0IGlzIHRpbWUgZm9yIGEgcmVkby4NCj4gTWF5YmUgZ2l2ZSB1cCBvbiBtYWtlIGFuZCBn
byB0byBtZXNvbj8NCg0KDQo=

