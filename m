Return-Path: <netdev+bounces-134002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBA997A7C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2845C281681
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F43A1BF;
	Thu, 10 Oct 2024 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R0LyR497"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A41773D;
	Thu, 10 Oct 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526633; cv=fail; b=YlLo4T5hbi9qDJzXHxW5+751kEFiJQLlZwtK4qpjoz6yADAQVhlfshbyxd8707JAgQk8SVl3Q3aa7KExW1fJNfmTwhLJsGlcYVZO7Uqa/BmU/8vHsk4pXoIwVy/ciIsOrESH6JPAh2F+ai/hLg0x7hBq3Jq+Lmr1Bel1YdL2e84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526633; c=relaxed/simple;
	bh=gyOIG9IebxzMUP0Vmb7LDgJvb55alJTjiKqQmhh1xE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrN6Rd1ukxxNWcPhqdriKCjBhkausVTDDP0p0pEoysn1dfpxWweFga3e3JW19LxNLId2XYwx7hs/ZynYh6S+u50Sk5jrZo9pJFhDRH6pA3bUUt/IKLLdP/T3euxkaMbkHp3B+JfZUXXTcCyxoTpSk0nD1G000QeRCAf2WGn1qbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R0LyR497; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAyxxUiPZ7uoS1y9OXdhoWCD1SMYT4HxHiDPo2t7XjG7SRJre3LatGvWzs/kd0sxycUytojh5pcKkAFICaC2D0HoFlOZAw1hVrgf85jA3aDwfPdyGCyS0P9l3sCOD7p35bbYNMAdxyhWA9mrXj0VtLYMTrt4Hep6TkTIv/Y5Id5mi5oKkk5PKKnsI3jlWVv0NgVsO85q5ia8Y+eybQl8k8AsEG87U3aGuV4+Vq3l7aM81OG7yXRwysK3ENTBli+e70ZZ4YvCyZMlnhUMAmCxadkHzRfxaOILXYBm72FZqSQ+dODDXoRLI2FgeXQBgwh5NaANYbI/6ESuiJ3wyyH/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyOIG9IebxzMUP0Vmb7LDgJvb55alJTjiKqQmhh1xE0=;
 b=vTz4cMK9VCEU/He6W2zbznlsuAgiyJdDlYDEGTgRRUaoq37ad0xANNuqvPe6uG90YjOZO9umZuyVoiTbCKfSTY5rSiOWuT9/WIylENv8cbL3X0siDuk0HNxhrWQRwDjUk7aAAhEqUE9voonpdiwckd06+eAw+ToO/oPkCLkg/orlab3qfpVciERWh3bt+a3cwxkajhITsa5A+JN8POtwkREUrkze3iwP5ELQoJ1njSEFK7bHXYXDsUIxlvfsp1f1q46FYpjLuCFAK/Gxo5JfOJpY1etu0MvCoU9YbBk3NxCchTep+G71RYbs8S5yQspQf/zsMjfxvOuh7122Da3y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyOIG9IebxzMUP0Vmb7LDgJvb55alJTjiKqQmhh1xE0=;
 b=R0LyR497Y5k/PM4Ju8RxJCs8rmWOoO76JfhVg9PEIoP3CZQ835ZvGmLlDezyQMXAblYP+QtuitIoA9BLBZIFHGJ+xgaGasxZ5gece6cbPbsYWD5yk3CPB7iFusjGB2emaCbQ2bTnCDIKZTWYRZbFhWVcTp3WlQ2LVgTO8z2c9KIdtAy0NsGiyV8SPU3sLwuGPYxF+/3ICZBVsGC8iDsVQ7OOqOHkAPMOLFP7zB8sAxrgjscMQGhKvpJs7selOGr3LpX74Sz648yuLIlhS2XGO8MZ+sMZVnJUfzFuJgVuFbbHRRgQs2TvJJmY8Qx11n5gfxjD8XnaaEX4miYDuBGZEg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 02:17:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 02:17:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,rmii-refclk-out" property
Thread-Topic: [PATCH v2 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,rmii-refclk-out" property
Thread-Index: AQHbGVL9Vw8Dd0oXxUexyHZ73gIgYLJ+iKKAgAC5lFA=
Date: Thu, 10 Oct 2024 02:17:06 +0000
Message-ID:
 <PAXPR04MB8510D9D187403624C8DF3AA388782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-2-wei.fang@nxp.com>
 <20241009151223.GA522364-robh@kernel.org>
In-Reply-To: <20241009151223.GA522364-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8529:EE_
x-ms-office365-filtering-correlation-id: 2a14b028-3e4e-45b8-12e7-08dce8d1a34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NTVGeEtQZGF0aWpTR2lsTkdoN09WUU9TMER0bkN3YmJ6aHE3QmRuc1dTOHVa?=
 =?gb2312?B?M0VhU2FmSG15bm41R29ydWk1R29lb1hLY0FUelJYRE0vM1BvdmlUaEJ2T2ZU?=
 =?gb2312?B?SjU1RVlWc25oRnpvSXc5Wm4rQzBKUTdxeU5UUGlNRGlDaFIwa2p0QXRlSzRy?=
 =?gb2312?B?THgwcVJZT1ZyOVM3OXE4NjM4M1JIWEFrWENDTHhKV3dibWh6SGpJWU54QlFn?=
 =?gb2312?B?eDVYZ2R4OFE5dmFaTUkzZDYyWTBBVWJiVzRGUVZGR0NzZ1FlN1RodFdhbDFt?=
 =?gb2312?B?L2dNYjRySlVxdi9DY2hsZlBScWVJTU9XNFRyeTdGdjVpMzlBWkRFTDRsLzlC?=
 =?gb2312?B?SForb1Z6QkdBNjFzOFlJSGJkeUxNbE9vRmdFVHNKUkpoOFhDNGxta2xieDN3?=
 =?gb2312?B?TFdUNVk5TjFUc05zRkpvaGUyMWRrUUZteHYxQUdqZnVadFIxQlliZE5Bd1hC?=
 =?gb2312?B?TjI2ckxoL2tVVEF5eTFjZUZLOFVOVFVGYkJtV1NTUE8zaG00VDJyc3FYSkRL?=
 =?gb2312?B?OXJFTFIvc0IvUVpUV2RkVXRubTNXVEZhNmF4WDFzbDh4QXc5MXhvV0poRk1v?=
 =?gb2312?B?WnhtcjFDWHB4NUR2RVkzQjRJT1hwUjNVMCs1Nm11bW5xWml6cEc4Rk9taHFI?=
 =?gb2312?B?Z2phZzFlOHhuaFBQbDI2RlZPcFl0bW9iUzExU1d2S3lpa25vQ3ZxeUR1V0tp?=
 =?gb2312?B?dzMxTENDL3J3Vk9DWExIUTExeEx3TlRia3pVc2hzNGFvQ2MxczZZNTNrZjBP?=
 =?gb2312?B?Y0JYTGJ1cUwzdWZHOFdWZjdtYlN6MDNwSXQ4M2dZSG83NXVvVzlBQmNJOFQ4?=
 =?gb2312?B?b0pvSlMvVmgzNHBYZlVQLzFlQWE0enNLdkYzbzNEWkxBN1pxZU5qMVlJaHBz?=
 =?gb2312?B?UmdqbGp3SXMxM05xeCtQTzNjU0lqYnozWGFtbnI3QXdmM2Rja042NkhjMisr?=
 =?gb2312?B?ZytxbTNrOVIzRkdXcjFoOCtBS1EyOHBXeHhLUnl5cHh3SUJhS1ppalhIYkVm?=
 =?gb2312?B?alVHRDdoRXNkSGRTTnovdWszem81Y2ozZlFXWXR4a25PaGFva3NwVnB1ZXZn?=
 =?gb2312?B?VjVpSEYza05pdWE0Q3RnclBGWjRuV2dWSTlJSzExdkhEdWJjM09Ca2RIMjE4?=
 =?gb2312?B?NTNsSkRFYktWd0FodVFPcUhsd1NmTlM5U3lIYjVlV01PV2lUWmtRODkrNjlY?=
 =?gb2312?B?a3dvTGxrc01aOTV4V2VwUlIrRnpzZFE0ck4zL0xpQnV4bzhaMnIwODEyYVN2?=
 =?gb2312?B?MVlYVWprSmdudU9XbWVmY0VWQ1NrTUFhWHJCdkJoeENlR3FuRVB6Qit4Vkx4?=
 =?gb2312?B?bkNYMFdBNy9JUTFuOHRTVjZnS3VjaGxiQitGOTRHWjFoKzZrbEZYTEs0WlY0?=
 =?gb2312?B?NXVvZUp4NFF4L2twUGRaRXB1cE9nUVU5QzhCZG9pdFBVRlZCSDI2UlQzZnAw?=
 =?gb2312?B?akw2dnVEemg1WGtYb2RndTBRNVlzTVg2L09sbGF3MWlFajVHcHRaUC93REZz?=
 =?gb2312?B?cXhFS2FFVjB3ZWk2T3laV1RWQkRLRGFWRHlUQ2hCbDNaQmZKT05lY0xDNEsy?=
 =?gb2312?B?czRPa1hOeU5tbW0xbTZ0elpkTnhUR3RtZytLSWM0TGg3Sy9rNDE1NTVLdHpX?=
 =?gb2312?B?Q2NZRHV4dEZMd2FUQTJMM01LU2pLNklmTk9NMDVzMHVPYk5kYkJETmc0QjVH?=
 =?gb2312?B?SGhpaEZMTGZER2N4aFFsOSs3TTIxT01IRmIxZXNCMElGbGtaTTVwejJaVjNK?=
 =?gb2312?B?Y2hpUzhrWVVmSzk1Yk55dnZRbVltS1BIaHJMUWxGNUw1d2J3N24vazNzQzVh?=
 =?gb2312?B?UUgwTW1WYmdvTi94TzR2QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OUZ3MFFtQU9FcUo2NTBMQjRkZ2ZvSk9GOWEwZG1YQVBEZ1Erb1RsN2ZrQnh4?=
 =?gb2312?B?djRXUy9oczNyV21xWFh6bmRGZmN6b2k4ZlFzYXFwMGM0RWJqeU9CQmFqbGE3?=
 =?gb2312?B?cWx1Qy83YU1aRElnRENCejBXdXBaVUdISVUwREVncjduQ2dyM2d0QWRXeFRR?=
 =?gb2312?B?SXdmcURNYTljdXlNOUw4NUNwTHN1Rldwa3ZoN2V4amZvMVh1Uy9lMnNnVGhG?=
 =?gb2312?B?VE5hemJJWnlCN2RmQ1RTaHY0RUF1eXZ5WXJvVEs4K0ZTTGZKYkNzb2FrUDBp?=
 =?gb2312?B?MzBaU25BdnpBMnFURE1TcUw4SlBHODNqZW9kWXQvVE5DTVp2c2dSL3YvbWw1?=
 =?gb2312?B?OHdSV2NJZ1BvbUVwYjMvYTZUTGk4cVBmWm1IdTJlUG5DSkhYU2s0MXZ2bTF4?=
 =?gb2312?B?c0RDNi9tcjA0bEdSeExoRXRldVFqTlM2cVptTm1nMjBGVDM3S2VnQVBEVW5h?=
 =?gb2312?B?dXdDYnNyK3ZQNTVIcU95K05jNFBmR3FTWW9xVFR5d1ZQTzJkQWZZcm1LRlhp?=
 =?gb2312?B?M0FwVktmdlgvS0REZUtYU1lWdVk5dE9ZMkVaWlBaRUFpUWF3V2xJcFpEWWVv?=
 =?gb2312?B?bkZmM2U4cTlJdnZTVkc1RnlYYUhtOVlHNzVIbmRvTDVKbzNBUUdpOHhuT2RC?=
 =?gb2312?B?MjVheVI5bVdBeTdjNzJiTEZtRU1hb2gxZlIwWlpZV3hnQTRxdCsveUlLMXYx?=
 =?gb2312?B?bUxMbUpERUJ3ZjllSEFZRTVieXE2akMrbXJ0bXNCbmY2R2xjS2d5TzhzMTAy?=
 =?gb2312?B?bFhzU1JqWWJyR1ZIN0R5NW5GNFdPZDVrN0pEMkNsV05MQWpFU0ZzUkFQOTdK?=
 =?gb2312?B?cngxOG9wUHY1OTE3S0RGSk9pdnhCWlZxME42S2pBeHlXNi81RFFwTjRUTzF2?=
 =?gb2312?B?R1B0U0ZCUGl1bzZYWFRzZXYrS1Bqb1VhVHd0R0s2R282b2FYSHQ0ZHNlbktw?=
 =?gb2312?B?R3FMU2JzU2RkclloR0RJVHNPWFRMWjdNbkN6bmIyWDNGRnNicGowVGdtRDFr?=
 =?gb2312?B?TTc5bE1PS0VlenFXS2U3T056Z1Z6K3JOamFiZklqdEpMV1FlWjJIUTNuM01r?=
 =?gb2312?B?T2NjMFA4SkZCR0R2VzBnbFArU2hhaDZ6azBYVXo0N3FEZjRWQS9sRUpqWkZ6?=
 =?gb2312?B?RWNmMStCYjV1NTlqOXNDcTRKSHArWklscTR3MGFMNWJDcERZeTFYVk0yMlZq?=
 =?gb2312?B?ODRjeDZUeS9UNktsNnRDQWRZa0lBUDU0cTI4MmFHRW9TVlhZaUlTL29DVFVm?=
 =?gb2312?B?ZHF3Vkx2V2FPNitmSGxLMWgwZVNheTBWN2NVQjI2Y3VUVElaNVEra2xsR3VY?=
 =?gb2312?B?U1dSdHltTElSY085Z0l2VTJqTW0yaDI2ZmVaNnM3M3JqUlhGOEovZ1dsNE9L?=
 =?gb2312?B?QThtd2lyL1FZMGFDclNJbEVnRXVCRjVCdXlIR25tVnIxYmlVREM5WUV4S1Jm?=
 =?gb2312?B?LzFPQ1V6OHlqb0ROcTVrOVVCYlZaOVh0NklvRHR2b3ZsaUNmUTFmVWxwWFBN?=
 =?gb2312?B?Wm9yYnM0bis5cGRRWGl6SXEyd05CZnpNdFphaGdoY3pwa3Eyd1Rhdzl6SUxI?=
 =?gb2312?B?MGpGQmRpRDhpeVpvekhyMVhZZURGU0VRS0gxRHBKVEk1aGs1VWlJeWNvZ21v?=
 =?gb2312?B?dHk0cmVsMDdlTDVveGRMamNaOVBNZXNYaURRK1dGREplWE1jd0Frd2hPWHpO?=
 =?gb2312?B?SUFzbXhEYklwcXNtVUlTMVM1aXNJRzBQYmh2OTFMYkxtMEtIcS9oR2h0Kzlp?=
 =?gb2312?B?anJlbFNwcFU3RTd0Nk1oSWpGbkhXYjFWd29LQ1BZd0JZYXgxQ2cvUGFacm5D?=
 =?gb2312?B?WjQ1dkZvODlsZXNNdHQyQlIyYUxKMUVWQ0h6eWFrNjI2K3RNcjBiRVlINHc3?=
 =?gb2312?B?U0V4ZDBybSthNHpEbkpQL3llUmlWNXRxM2M1M2pwVnVKVEZvYjRDWWVGQzZk?=
 =?gb2312?B?QnN0eEFKWm5yWEU2bHh0RGMwdnlROWRJMEphekRVejd5VjUxNXM2UkFDVnJs?=
 =?gb2312?B?Y0p5Q01TdUdDZDlVUy93S3VnbzQ3bkpONmF1VmwrRG8zZVd4clRLV3Y2QWpZ?=
 =?gb2312?B?bzdOQ2JDKzJWN3RpK0FTWkM1Zkk1Z1FJZ01lY2hrRUwveGlBZUwvT0MzNGY2?=
 =?gb2312?Q?h9F8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a14b028-3e4e-45b8-12e7-08dce8d1a34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 02:17:06.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuO7vuPimd+6SGFIiXK1LQMsT+/djckDb2afce/CPru4Cu0SQu1/cibyM7Tl3UnJh4rJibxHXtJXVJ4V0dgNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMNTCOcjVIDIzOjEyDQo+IFRvOiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGtyemsrZHRA
a2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYW5kcmV3QGx1bm4uY2g7IGYuZmFp
bmVsbGlAZ21haWwuY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsgQW5kcmVpIEJvdGlsYQ0KPiAo
T1NTKSA8YW5kcmVpLmJvdGlsYUBvc3MubnhwLmNvbT47IGxpbnV4QGFybWxpbnV4Lm9yZy51azsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAxLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTEx
eHg6IGFkZA0KPiAibnhwLHJtaWktcmVmY2xrLW91dCIgcHJvcGVydHkNCj4gDQo+IE9uIFR1ZSwg
T2N0IDA4LCAyMDI0IGF0IDAzOjA3OjA3UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFBl
ciB0aGUgUk1JSSBzcGVjaWZpY2F0aW9uLCB0aGUgUkVGX0NMSyBpcyBzb3VyY2VkIGZyb20gTUFD
IHRvIFBIWSBvcg0KPiA+IGZyb20gYW4gZXh0ZXJuYWwgc291cmNlLiBCdXQgZm9yIFRKQTExeHgg
UEhZcywgdGhleSBzdXBwb3J0IHRvIG91dHB1dA0KPiA+IGEgNTBNSHogUk1JSSByZWZlcmVuY2Ug
Y2xvY2sgb24gUkVGX0NMSyBwaW4uIFByZXZpb3VzbHkgdGhlDQo+ID4gIm54cCxybWlpLXJlZmNs
ay1pbiIgd2FzIGFkZGVkIHRvIGluZGljYXRlIHRoYXQgaW4gUk1JSSBtb2RlLCBpZiB0aGlzDQo+
ID4gcHJvcGVydHkgaXMgcHJlc2VudCwgUkVGX0NMSyBpcyBpbnB1dCB0byB0aGUgUEhZLCBvdGhl
cndpc2UgaXQgaXMNCj4gPiBvdXRwdXQuIFRoaXMgc2VlbXMgaW5hcHByb3ByaWF0ZSBub3cuIEJl
Y2F1c2UgYWNjb3JkaW5nIHRvIHRoZSBSTUlJDQo+ID4gc3BlY2lmaWNhdGlvbiwgdGhlIFJFRl9D
TEsgaXMgb3JpZ2luYWxseSBpbnB1dCwgc28gdGhlcmUgaXMgbm8gbmVlZCB0bw0KPiA+IGFkZCBh
biBhZGRpdGlvbmFsICJueHAscm1paS1yZWZjbGstaW4iIHByb3BlcnR5IHRvIGRlY2xhcmUgdGhh
dA0KPiA+IFJFRl9DTEsgaXMgaW5wdXQuDQo+ID4NCj4gPiBVbmZvcnR1bmF0ZWx5LCBiZWNhdXNl
IHRoZSAibnhwLHJtaWktcmVmY2xrLWluIiBwcm9wZXJ0eSBoYXMgYmVlbg0KPiA+IGFkZGVkIGZv
ciBhIHdoaWxlLCBhbmQgd2UgY2Fubm90IGNvbmZpcm0gd2hpY2ggRFRTIHVzZSB0aGUgVEpBMTEw
MCBhbmQNCj4gPiBUSkExMTAxIFBIWXMsIGNoYW5naW5nIGl0IHRvIHN3aXRjaCBwb2xhcml0eSB3
aWxsIGNhdXNlIGFuIEFCSSBicmVhay4NCj4gPiBCdXQgZm9ydHVuYXRlbHksIHRoaXMgcHJvcGVy
dHkgaXMgb25seSB2YWxpZCBmb3IgVEpBMTEwMCBhbmQgVEpBMTEwMS4NCj4gPiBGb3IgVEpBMTEw
My9USkExMTA0L1RKQTExMjAvVEpBMTEyMSBQSFlzLCB0aGlzIHByb3BlcnR5IGlzIGludmFsaWQN
Cj4gPiBiZWNhdXNlIHRoZXkgdXNlIHRoZSBueHAtYzQ1LXRqYTExeHggZHJpdmVyLCB3aGljaCBp
cyBhIGRpZmZlcmVudA0KPiA+IGRyaXZlciBmcm9tIFRKQTExMDAvVEpBMTEwMS4gVGhlcmVmb3Jl
LCBmb3IgUEhZcyB1c2luZyBueHAtYzQ1LXRqYTExeHgNCj4gPiBkcml2ZXIsIGFkZCAibnhwLHJt
aWktcmVmY2xrLW91dCIgcHJvcGVydHkgdG8gc3VwcG9ydCBvdXRwdXR0aW5nIFJNSUkNCj4gPiBy
ZWZlcmVuY2UgY2xvY2sgb24gUkVGX0NMSyBwaW4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBWMiBjaGFuZ2VzOg0KPiA+
IDEuIENoYW5nZSB0aGUgcHJvcGVydHkgbmFtZSBmcm9tICJueHAscmV2ZXJzZS1tb2RlIiB0bw0K
PiA+ICJueHAscGh5LW91dHB1dC1yZWZjbGsiLg0KPiA+IDIuIFNpbXBsaWZ5IHRoZSBkZXNjcmlw
dGlvbiBvZiB0aGUgcHJvcGVydHkuDQo+ID4gMy4gTW9kaWZ5IHRoZSBzdWJqZWN0IGFuZCBjb21t
aXQgbWVzc2FnZS4NCj4gPiBWMyBjaGFuZ2VzOg0KPiA+IDEuIEtlZXAgdGhlICJueHAscm1paS1y
ZWZjbGstaW4iIHByb3BlcnR5IGZvciBUSkExMTAwIGFuZCBUSkExMTAxLg0KPiA+IDIuIFJlcGhy
YXNlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgc3ViamVjdC4NCj4gPiBWMyBjaGFuZ2VzOg0KPiA+
IDEuIENoYW5nZSB0aGUgcHJvcGVydHkgbmFtZSBmcm9tICJueHAscGh5LW91dHB1dC1yZWZjbGsi
IHRvDQo+ID4gIm54cCxybWlpLXJlZmNsay1vdXQiLCB3aGljaCBtZWFucyB0aGUgb3Bwb3NpdGUg
b2YgIm54cCxybWlpLXJlZmNsay1pbiIuDQo+ID4gMi4gUmVmYWN0b3IgdGhlIHBhdGNoIGFmdGVy
IGZpeGluZyB0aGUgb3JpZ2luYWwgaXNzdWUgd2l0aCB0aGlzIFlBTUwuDQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ueHAsdGphMTF4eC55YW1sICAgfCAxOCArKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L254cCx0amExMXh4LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvbnhwLHRqYTExeHgueWFtbA0KPiA+IGluZGV4IGE3NTRhNjFhZGMyZC4uMWU2ODhjN2E0
OTdkIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvbnhwLHRqYTExeHgueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvbnhwLHRqYTExeHgueWFtbA0KPiA+IEBAIC02Miw2ICs2MiwyNCBAQCBhbGxP
ZjoNCj4gPiAgICAgICAgICAgICAgcmVmZXJlbmNlIGNsb2NrIG91dHB1dCB3aGVuIFJNSUkgbW9k
ZSBlbmFibGVkLg0KPiA+ICAgICAgICAgICAgICBPbmx5IHN1cHBvcnRlZCBvbiBUSkExMTAwIGFu
ZCBUSkExMTAxLg0KPiA+DQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4g
PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gKyAg
ICAgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBldGhlcm5ldC1waHktaWQwMDFi
LmIwMTANCj4gPiArICAgICAgICAgICAgICAtIGV0aGVybmV0LXBoeS1pZDAwMWIuYjAxMw0KPiA+
ICsgICAgICAgICAgICAgIC0gZXRoZXJuZXQtcGh5LWlkMDAxYi5iMDMwDQo+ID4gKyAgICAgICAg
ICAgICAgLSBldGhlcm5ldC1waHktaWQwMDFiLmIwMzENCj4gPiArDQo+ID4gKyAgICB0aGVuOg0K
PiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIG54cCxybWlpLXJlZmNsay1vdXQ6
DQo+ID4gKyAgICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gKyAgICAgICAgICBkZXNjcmlwdGlv
bjogfA0KPiANCj4gRG9uJ3QgbmVlZCAnfCcgaWYgbm8gZm9ybWF0dGluZy4NCj4gDQo+ID4gKyAg
ICAgICAgICAgIEVuYWJsZSA1ME1IeiBSTUlJIHJlZmVyZW5jZSBjbG9jayBvdXRwdXQgb24gUkVG
X0NMSyBwaW4uDQo+IFRoaXMNCj4gPiArICAgICAgICAgICAgcHJvcGVydHkgaXMgb25seSBhcHBs
aWNhYmxlIHRvIG54cC1jNDUtdGphMTF4eCBkcml2ZXIuDQo+IA0KPiBSZXdvcmQgdGhpcyB0byBu
b3QgYmUgYWJvdXQgc29tZSBkcml2ZXIuDQoNClRoYW5rcywgSSB3aWxsIHJlZmluZSBpdA0KPiAN
Cj4gPiArDQo+ID4gIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICAgICJeZXRoZXJuZXQtcGh5QFsw
LTlhLWZdKyQiOg0KPiA+ICAgICAgdHlwZTogb2JqZWN0DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4g
Pg0K

