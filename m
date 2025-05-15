Return-Path: <netdev+bounces-190770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0FAB8A94
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87313A606D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E086211A15;
	Thu, 15 May 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="FPfTlcFB"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022107.outbound.protection.outlook.com [40.107.149.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8942A82;
	Thu, 15 May 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322449; cv=fail; b=gVDT16xbmqiMNPcrX3i/GEKT4WpR9cEouL7NpwS7WWyJqKTYftEklFec+ha/jpK6zBITwcqQthA2b1p5RUKx+/9qyRtit8vgdt7XT2Do3f8UHt1genNYsVpiu2/Azx+gMNfUcYxL3bv1DvbEahcV+pK13pJOtmznHTWOrpS5Phc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322449; c=relaxed/simple;
	bh=ZLY2Jx2fRm5w8hcM9Y47Qi+QAJoCfIclDdOQa4mW8yc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGt58yDQX1aO9YYh3Hmpz7H1QEvXmDLePJdTddQ2jQjoqScyBAaPoJ+/PMlCLBOM3/aciOd5QbkTN4Db20TZg6vtHZGNL1DT5sxRnkc5tKleHTY81bqsfhu+fwOTwDEP/LYkaRm8F+Qk8Jns20ApitIiW77ObKBjViU2h8gWC5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=FPfTlcFB; arc=fail smtp.client-ip=40.107.149.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRPf8rMAm5g1nVQ/+exsjPWzaL78l4EkOJCO5aZuJw6NtnoDiSz0sazp73GhHwc+ZtGqS+XYy7E90B3JKHA8eNYR8BQJTkIhNTNE5SwSM2D8wK4b8V4Hud6OVvyrP/BS0DMbts/XpCuZzRjtk5ymovQyv4rJjpMD1XfwlcLmJnXZmKSCK3M+vAfVZw2KxRTQPSZ9Wba/PkA8ox7L45h3/iVWavZQ6SLgtDB34rc0RohpfL9OQKXc9E/WIxvVVw4EMD/Tl/oMNDE3hyP5ywK+e7rGa1+bIoRCBJ6IU1Qy+sqw3P+lDXLM+/xYTfILcKXyeWypREaoSLFOSvLU4By63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLY2Jx2fRm5w8hcM9Y47Qi+QAJoCfIclDdOQa4mW8yc=;
 b=rAcy4eGMd9N0+tNhQ/D6m1iddBNYu3CPfSUZujjzOQesIhyBW9vkLlz1oXmlBtHLzd3B59MwCbmRr9elGQl7q1qbpL/imiTg9DXQPV+WjfOplSQfQvkdQlZoaHXN3JwONxYQiQTW0b9JrfS6Hf8nveRMC0/HGQ2A766jME+/u08sfeDcdi1WwxqQVs1/tdpdaknoKw02HmMgeWmcyEDn2mE5bqQDVXPGGtHc18U0MU7f5ygUDtR4xX2ulOKs/5EUf1/KuuEALShe//F/OqhmoC2CXvJCBPzogq2B5mwo4/eLivD128uTGUomfMaN97qlkDXO7TwZSV58rHgtHav4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLY2Jx2fRm5w8hcM9Y47Qi+QAJoCfIclDdOQa4mW8yc=;
 b=FPfTlcFB+RwdsM+s2IRz5hlhlnSL4QwMAMrrEjw2RQlwhhuqx6kWuEUjbEWwgFLeo4Gu6K/0JIsRJgWR6UR8aPahAtx2ccZFU6peG8syXOjOoN8mf/4Ce/ChcK7O8wfr9A636oEJ++R3Th9Q+2JLCSFjfauoLmCZiwZUKdiEG/Y=
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:30::7) by
 FRYP281MB2238.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:41::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Thu, 15 May 2025 15:20:41 +0000
Received: from FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51]) by FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c74c:31e4:c86a:ca51%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:20:40 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add
 bindings for Si3474 PSE controller
Thread-Topic: [EXTERNAL]Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add
 bindings for Si3474 PSE controller
Thread-Index: AQHbw4oFfHf+/UEwE0Wb9+/ZQZtlJLPQObOAgAOZDgA=
Date: Thu, 15 May 2025 15:20:40 +0000
Message-ID: <dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <259ad93b-9cc2-4b5d-8323-b427417af747@adtran.com>
 <f8eb7131-5a5d-47ec-8f3b-d30cdb1364b5@kernel.org>
In-Reply-To: <f8eb7131-5a5d-47ec-8f3b-d30cdb1364b5@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2217:EE_|FRYP281MB2238:EE_
x-ms-office365-filtering-correlation-id: f26b055b-4d96-484a-d443-08dd93c40da1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDRnQ0k4emxDL253NHAzWVkvZjMxa1dTLy9oMkRSNTZqYUZNUFUrWjR2L0tO?=
 =?utf-8?B?cmc5Rm56akFhRHRzdWhUYVdZRWtpeXkraUZvT0xnZ2tHeUdKazBqbC9oSFNs?=
 =?utf-8?B?Z0JrRWNQRUp6TjZkSm84N1g3N1hBS1RLa3JQclczemxvNDZZcGxralFqL0VH?=
 =?utf-8?B?KzZRb05jbnRvN08rOEVsb1lQQjlVeUpKTDVWRld2NDNRdXVIQmtwU2tpekht?=
 =?utf-8?B?Y0QvTCs2N1hCYXo4bDlNSkN1S0hqRXBRQit3Y0h3dXZ6aWNVcy9nSE9ma2hJ?=
 =?utf-8?B?STVqdjNPT20zSWlIUlU4RHIzNjBCSlM2SURsWU9WWEdlVFFOMVJENVFML1ZK?=
 =?utf-8?B?WXdCd1cvRGEyd0lLcksyTUFZSTBuUmZNVTdDeklpeUFkTVlLWVdkcWdYZUJ1?=
 =?utf-8?B?Q1JUamNvMkNySEx2bzluK244OTkxd1I1QkpQOEhVMXhhZk1YejM1Q0ZhdUtE?=
 =?utf-8?B?N2p0aHNVVVBLam9XWm5iS0oySURBdVEreVhMZ3dUZGJZcDJEUXJmL3BHaDlX?=
 =?utf-8?B?UlEzOEdsVllZYStNREV4a3RXcUNHY1V4Mi82cjlFdm1VZGRYOWVvMmtRLzJm?=
 =?utf-8?B?WWVNUWNCRTVRVko1ZmpKK0c3OVhNbk1sWUYzZkRwYUNFNnIrSGlKemJNNmUv?=
 =?utf-8?B?cGhLdXNoUGErSHY3cUwvaHR2TVZSNTFlMnJoOW9FbjM0dWJ5dlZCL1UwcWlJ?=
 =?utf-8?B?bkdZbm5kZ3k2OGxUUjhDb2dTQllsaWpmWWpxYTZmQXpXZnYyQ2NZQUxyMHd6?=
 =?utf-8?B?ei9CeFIxYllYTWlBL0VSNkR0MzJHZlp5ck9JOTBVL2VhRjVlVG1Rd1ZKTkh0?=
 =?utf-8?B?bkhUZmw3NUJWeTgyVTd2N25YTVliRmlHMDdYY2VZMzBrNjl5R2FiUW9JVUlu?=
 =?utf-8?B?VkZVSVo3c0pLV2dVQU1ZakxVaUpuU2t0RGo1OUVNeGxZNG9EL2tlM09qZlNr?=
 =?utf-8?B?UEF1WU9KSE9TQTcxZkVpSndOa2Q3NDR3UEFlVmVNYXFoMmdJSi9ENXErVXly?=
 =?utf-8?B?WWQzcUlqMWpLZG81aTBudyt4NTJ5UEVUOTNZSDFEL09sT1R0ZXZlSElGTmJp?=
 =?utf-8?B?SE9QUHNzSmdpSjVXUjVMVGVBaUJEdDBnWUY5M3UxR0dJckRVRUpTQ2lHQlpi?=
 =?utf-8?B?Zno5VGJKY3VXcVFuZTJId2V3cFJUUWZOY3BYZmRuV29QODJYSFdQYVJEZC83?=
 =?utf-8?B?dlpVZWRVNFJRKzVESDJWMWRVOWYzV280aURIUWdVSWZROThIMHBNM3VkQWlG?=
 =?utf-8?B?d1FmRWt3aGwzSnBjMGdFU2dRVTNMOWJSUUhlbXVycnZFM2VWNlg3eXoyNmNZ?=
 =?utf-8?B?YUJGYW8yd2tWN0tCbTZUckhvR3owMnJmSG44ZkZmRG1VcEsyRHNmcUY5dC8y?=
 =?utf-8?B?Ylhmc1JEZWtzYmVpMmlINDVQWW5DbFdvRnJUbUZnN2dBRmI3Z3Y5MXBwcHVY?=
 =?utf-8?B?ckxHRWFvZTNmeHBNK2ZtOHpNTDNVSTlBbVBERVd0WEM1SGg2dStydTNtWW1R?=
 =?utf-8?B?UjFVOGlmUURxWng5ZWx5RFZpcjdNaVJsQnBzeTd0aDJLcXU0U29oVzBwdkxn?=
 =?utf-8?B?VFAyN1NjWXJ5cTNCdWlPTEI3Y2VGVUZ2SGRSR3NsczhYTWJ1YWN3ZDFxU0Zu?=
 =?utf-8?B?b3FuY2szaTFLNzU0UWRTUlc0aUlHY3o0ck1ya2FzeEdYT0psRUt2c3pnNGhr?=
 =?utf-8?B?SGNzS1MrakpETUlhendWYjZMWWdBckZXbzF3SjN0SDMvQnYwa1dxN3cwOEU5?=
 =?utf-8?B?aTJoaEtEQ0NNMWR2eHEvOFdGL2lxc25jeXdxRTFFeFdkK1ppS0RwVSt4UHcv?=
 =?utf-8?B?U1NaT3VqbEpOWEszS2tyMXBIeXZLYmZ4Nmp4RXpZSCs4aUZDbzNSbjVtOTRW?=
 =?utf-8?B?czlvSUwxZ0NsT1FOV2hRNGVSejA2V1grSmNvZXBtMkp2RUY2dzJmb28zU05C?=
 =?utf-8?B?Y1BwNFNYc0gzOFVJSWhSa0MvbHBJbEd5emtsVDhMeEpKUXhUdFVBajBScE5N?=
 =?utf-8?Q?2Z+RLgOlJBr5oYFI9jWKsgTmYuiyeA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVNsck0xYTFONXk0NVA4UkhBUVV4Vjl4YXZRTFhrbkN2T05BYkh5b3lwMlVF?=
 =?utf-8?B?ZXlQdGtHaHkydi95RVRxSlg3QWxvbHpNaGVkTm8zRXVtOHFNMWhiTmx2NEZz?=
 =?utf-8?B?L3dBOXlFOFlsdmJadmM1T1Roa2lqZVkwRGRzM09NaldiT1pHWUV1M2pJWUlS?=
 =?utf-8?B?M1QxRnZpYXlzT2dVK0E2S2JJZkw4WldVejBzcE9neDFtRGg2SGNvdzFQTXYw?=
 =?utf-8?B?TnhBNjYxNGo3bTlsUnR6NGcrelQ3Qk9qS29iRCtlanI2Q2ZGOEF4UmppVms2?=
 =?utf-8?B?SkMwcisveWVRVi9pa0dhMFd4OWJQcnRkTkFQZFltRkhGbWNBRkc4aE5DTER1?=
 =?utf-8?B?S09rK09ZNFZTb2tFdkQ0SnpHdGpYNTNqMG1vMEYzOTFWYyt3aHFTbzFpNWU3?=
 =?utf-8?B?M2YwekhpNXY5WURSNjdkZFZpT0lFYzhCY1ZudStaU0g1QUYrdE1aT0N1SllR?=
 =?utf-8?B?dW5wTHp4c0JzTG5yQU0rZzZPcTBCUDluZVNZajl5eC9UTDJ1anBOVHkySjh6?=
 =?utf-8?B?UHpJTkxlWUlkMjRGcXo2VUNZR0Y3M1hWMGpyaEhLMW9xOWxVcjhzOStCSTdM?=
 =?utf-8?B?YnJZSTRBZ0UxZ0hTZnVoWHdNZDV0YmpYeXc5RUpsOHZPS2YvbjlqVERzWmhL?=
 =?utf-8?B?eExldTdzWjRoNnhEYStVYWk3b01EWnZQTm81MCtNM1NOUmJ0WDlHWmJaaVQx?=
 =?utf-8?B?MjlqaklrOEE2SkEveEVNWUNwSlNXUGdFSEIyZndrM0MwMHR4M0Z4WjZqSFV2?=
 =?utf-8?B?QTAyZFA2WmNKbGNqTUR6MEZkbUtFUDNKQSs2Tk04Zk4xY043bWQ2NlZBbldV?=
 =?utf-8?B?N2JjTTc5MklITzNOd0s1ODFOdXhhTmU0MXlrR0NlUEYydldYRk84eTA2eFo3?=
 =?utf-8?B?ZnRrUlA1WlcvSis4bllWankyS1p6T3lkbFM2N25aNkQyYnpSMCtpK2FreUts?=
 =?utf-8?B?TURSMEZHam5aWC9SaVpBY0FpaXJheFVrSkRVTUkrTXhwK0NQMzVSbExtVmkr?=
 =?utf-8?B?ekIxdlM5NE1kSWdjYnIyMitZVVN5dzJYaUI0UWU0WW0ySDdGRHRzc2VHS0tv?=
 =?utf-8?B?cFFPSjN0WmRQclVUbklkaFVhS3g5cTRMK1RIWFk1cVVvck5pWmpFNmdKaVdR?=
 =?utf-8?B?azNWSW5jZGJvNW5YdGRWc2xlU3lSWmgzdnlreEtoR3MrSjZYdUFCMWJpeTFw?=
 =?utf-8?B?MitCUUpSSkNzN1NDMmJPa2h1L1JpSjhDaHllS3hrczhaaU53UVpRQkJTU2dI?=
 =?utf-8?B?eEk1M3g2MmRMcDFOT3hMRk1US1djdU1BTjZnL1RxSEEwQWJpUjFhcmZ2bW9Z?=
 =?utf-8?B?cGRkMzZwL0djaGhXcTFPY05BL3VHRjluZ0NrZEJ3eThwNDBwR1NFRUt2Z2Vx?=
 =?utf-8?B?MWJEMWU1TzBxMVdGaEFjMlJWZkxQTkJkQWlyVGJ3b08wN3ZGdXlBOVhiLzh6?=
 =?utf-8?B?UDJrUEdxa016cDJnR3k5QXhlOGRXVWcvb1RxZDJCSmdCMUFuTiswZ1RtVkZ0?=
 =?utf-8?B?QTJaQURmSUwraUJ2c3IrNlA5OS9OL0t5MGZzZVQrR3loUkQ5eVJBdjdHcUFR?=
 =?utf-8?B?RHU1dWxXWUszeWl1azJkR21SdTVMWUZkbnI0Q0ZLaTN5VExMbkNDdGRTMFFj?=
 =?utf-8?B?TS9kVG5oRnRHV044RCt6TFp1YTRhdVM1ZkdMeXVEMHY5ZjhKV2NWOFpUeGhY?=
 =?utf-8?B?VW9KNEY4T1F1Zi9SdXhIOFBwdjc0b2twT0tiaW1QVHZMSGF5eXVpcVcrYWJM?=
 =?utf-8?B?TDgwZmp5MTRuRDN1KzFZQmh5djQxREc5QkQxaVFqb3k2aWhWaUNybVFydHVR?=
 =?utf-8?B?c3E2d2hIdzQzT2g1aHFmR2NWTVFDZnBYdWhMZmtqQVVMdEw0RmRjODdwMjhD?=
 =?utf-8?B?MU9FYXBLTHhxb1FGTjFybFRGdU5rcllRR293Z1ZtZHZCbTFVV1owR2s2aytF?=
 =?utf-8?B?ZnhLOE5lcTd1VUtJelErSEVMVTI1Tk9pekJrekptZm1iQlBtWjFvL2l3UnVw?=
 =?utf-8?B?dHJuWXFvSDVOb1pQVWhDalQ1aGhneTByZnQ0M29na29pQ21yV3k3VzdQeUY4?=
 =?utf-8?B?bnBET01JSGpMOGNVMWVLSHBYVjVkbFdwWkcxdXlERE5rU2xmQlRuelpaTFk1?=
 =?utf-8?Q?jYgvvFJmWOqu//NRr8OcDi2/6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80DA6FFB74200B49A5633FB522079819@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2217.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f26b055b-4d96-484a-d443-08dd93c40da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 15:20:40.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzDC8h51QL8wKEsnpeb+dPoS4tdo82/71WSqPrWCcWjNmiWgz/X9uAYmQkEmIv4VL7nw1qszHEmXHtdFCBYw/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2238

T24gNS8xMy8yNSAxMDoyNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTMvMDUv
MjAyNSAwMDowNSwgUGlvdHIgS3ViaWsgd3JvdGU6DQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+
PiArICAtIFBpb3RyIEt1YmlrIDxwaW90ci5rdWJpa0BhZHRyYW4uY29tPg0KPj4gKw0KPj4gK2Fs
bE9mOg0KPj4gKyAgLSAkcmVmOiBwc2UtY29udHJvbGxlci55YW1sIw0KPj4gKw0KPj4gK3Byb3Bl
cnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gc2t5
d29ya3Msc2kzNDc0DQo+PiArDQo+PiArICByZWctbmFtZXM6DQo+PiArICAgIGl0ZW1zOg0KPj4g
KyAgICAgIC0gY29uc3Q6IG1haW4NCj4+ICsgICAgICAtIGNvbnN0OiBzbGF2ZQ0KPiANCj4gcy9z
bGF2ZS9zZWNvbmRhcnkvIChvciB3aGF0ZXZlciBpcyB0aGVyZSBpbiByZWNvbW1lbmRlZCBuYW1l
cyBpbiBjb2RpbmcNCj4gc3R5bGUpDQo+IA0KDQpXZWxsIEkgd2FzIHRoaW5raW5nIGFib3V0IGl0
IGFuZCBkZWNpZGVkIHRvIHVzZSAnc2xhdmUnIGZvciBhdCBsZWFzdCB0d28gcmVhc29uczoNCi0g
c2kzNDc0IGRhdGFzaGVldCBjYWxscyB0aGUgc2Vjb25kIHBhcnQgb2YgSUMgKHdlIGNvbmZpZ3Vy
ZSBpdCBoZXJlKSB0aGlzIHdheQ0KLSBkZXNjcmlwdGlvbiBvZiBpMmNfbmV3X2FuY2lsbGFyeV9k
ZXZpY2UoKSBjYWxscyB0aGlzIGRldmljZSBleHBsaWNpdGx5IHNsYXZlIG11bHRpcGxlIHRpbWVz
DQoNCj4+ICsNCj4+ICsgIHJlZzoNCj4gDQo+IEZpcnN0IHJlZywgdGhlbiByZWctbmFtZXMuIFBs
ZWFzZSBmb2xsb3cgb3RoZXIgYmluZGluZ3MvZXhhbXBsZXMuDQo+IA0KPj4gKyAgICBtYXhJdGVt
czogMg0KPj4gKw0KPj4gKyAgY2hhbm5lbHM6DQo+PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgU2kz
NDc0IGlzIGEgc2luZ2xlLWNoaXAgUG9FIFBTRSBjb250cm9sbGVyIG1hbmFnaW5nDQo+PiArICAg
ICAgOCBwaHlzaWNhbCBwb3dlciBkZWxpdmVyeSBjaGFubmVscy4gSW50ZXJuYWxseSwgaXQncyBz
dHJ1Y3R1cmVkDQo+PiArICAgICAgaW50byB0d28gbG9naWNhbCAiUXVhZHMiLg0KPj4gKyAgICAg
IFF1YWQgMCBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxzICgncG9ydHMnIGluIGRhdGFzaGVldCkg
MCwgMSwgMiwgMw0KPj4gKyAgICAgIFF1YWQgMSBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxzICgn
cG9ydHMnIGluIGRhdGFzaGVldCkgNCwgNSwgNiwgNy4NCj4+ICsgICAgICBUaGlzIHBhcmFtZXRl
ciBkZXNjcmliZXMgdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSBsb2dpY2FsIGFuZA0KPj4g
KyAgICAgIHRoZSBwaHlzaWNhbCBwb3dlciBjaGFubmVscy4NCj4gDQo+IEhvdyBleGFjdGx5IHRo
aXMgbWFwcyBoZXJlIGxvZ2ljYWwgYW5kIHBoeXNpY2FsIGNoYW5uZWxzPyBZb3UganVzdA0KPiBs
aXN0ZWQgY2hhbm5lbHMgb25lIGFmdGVyIGFub3RoZXIuLi4NCg0KeWVzLCBoZXJlIGluIHRoaXMg
ZXhhbXBsZSBpdCBpcyAxIHRvIDEgc2ltcGxlIG1hcHBpbmcsIGJ1dCBpbiBhIHJlYWwgd29ybGQs
DQpkZXBlbmRpbmcgb24gaHcgY29ubmVjdGlvbnMsIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkgdGhh
dCANCmUuZy4gInBzZV9waTAiIHdpbGwgdXNlICI8JnBoeXMwXzQ+LCA8JnBoeXMwXzU+IiBwYWly
c2V0IGZvciBsYW4gcG9ydCAzLg0KDQo+IA0KPj4gKw0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+
ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArICAgIHByb3BlcnRp
ZXM6DQo+PiArICAgICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4+ICsgICAgICAgIGNvbnN0OiAxDQo+
PiArDQo+PiArICAgICAgIiNzaXplLWNlbGxzIjoNCj4+ICsgICAgICAgIGNvbnN0OiAwDQo+PiAr
DQo+PiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4gKyAgICAgICdeY2hhbm5lbEBbMC03XSQn
Og0KPj4gKyAgICAgICAgdHlwZTogb2JqZWN0DQo+PiArICAgICAgICBhZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4+ICsNCj4+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICAg
IHJlZzoNCj4+ICsgICAgICAgICAgICBtYXhJdGVtczogMQ0KPj4gKw0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpUaGFua3MNCi9QaW90cg0K

