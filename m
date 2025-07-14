Return-Path: <netdev+bounces-206501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095EB034AD
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46853B3B93
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA61A5BA3;
	Mon, 14 Jul 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fs0/VQu4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399A63CB;
	Mon, 14 Jul 2025 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461870; cv=fail; b=gSQ7qdhBlU2dOB9eGRPC3ZHTIuTJN7drD7yU4Q3C2nezO5Wtw2+rMf6ZKWcvrVck2p9g0XwUacrv4BmxTIPYbB7t0ZoAKPRmDhfpWlDnAkVV9tQjdjcKXlpDP8Pw+O3X0xxN/7bJDl86fBT72tIURDJzNn6hFfbr0zZauhlf5Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461870; c=relaxed/simple;
	bh=ZW8P6eKNel4IvUUItsXlB/yyVt6PdQQV3kjucCHyz/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hikfg7XN5Rx95speU10/Sh2An3I3/iJuTHKoGh0cAfGgRzaLSc+rUFyijMDwzJDUe+/BtzhH7tlUHshS+yupNLF3Imif5VD+h7KM7ZUGs8ZSYvZNzfCLwmOb8K+cApmnkJ/aUnpSq1p7JBKRqz50Ihq82xRHP2KUuPF2RSu9YEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fs0/VQu4; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwiTNa450PDSQH+z3n1HHHenYCH2fXC7O3G+Bkhsrtw3BkQuY46kClnrhVtHU9M0c/TbBF/c0si9vqFuCCpZZnf6/7CXtSeX9O9kj9CMnMTR5paf/8QxstmvGR7/fmGMAo5ULmrNDDQlr5cVpx91u2IYger9WXam185Y6R/ih5/Kap1KuiH1/wx9R+eOAXcNjZ2Asq/K1+NIgoMX/3pIKB0NpDt1PMOrwB9sIHzySfkcncdIysrX09oP0Q1F8CqVgBFEY0PgUx8PGuRMOzjF4tsF1EnlCxG3CQjcJwRmF4Q820wd1qqDVSPEdexEbo7+SjPXDw6G5wSBRp+5zkMAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW8P6eKNel4IvUUItsXlB/yyVt6PdQQV3kjucCHyz/g=;
 b=TVXjHXO0hJvItiNwuMcgK0ZHXZWafiUHsPjE+VxAzLGHQEVgiWaDSGiLH9WxqZUMx2ffu/jGBZ5Wzu3hqRV32ff4RwF9qhjrqhbcdeNEy1ZkpNrLHMTQsuqdzUGhYB0Mljbjox1B6bUmxjJ6dKozlT/X4OPfrW+QZ5naBWM+10DG2Sh1/iwaG/tYR7BXVanp/HUSwf3DWE6g/JylaApOyc2wAxNfIQi2X46yzUbctnr9ioEG+Xo7LrwzQkQ5jXP/4SEIQRAi3YTlpsd93oDckb87ffDHy76dAsDPuy9iSYvASvYbOhu5CCUi+wLYSFhHD0TdndkkyzIhQOYUVMKk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW8P6eKNel4IvUUItsXlB/yyVt6PdQQV3kjucCHyz/g=;
 b=fs0/VQu4PSFx+r/fiYS9v4ARv/8mUARxl60jJFrQCN0Cn8/C40nHnion8Q5rM694NXEdEsHBgfwVxdrU0QiES0jezCPZ0eaU6Pa7CNZFz3utoXOw7J3qLE6SC+A/8GESF/dFk7cbxmEzvcdHTn6WfuncPn2h/RgtGxd8kuMKYeMxBnWtF5hCnfDpmUJMlwDXdi3nBAprgTIzAeq7j1tGNVZRjq22yg8LTAKXx0YR/9CIE7fjDJjvNh/K+TcFbXkFLLT1dXoxwJ36glAWLx7I7gAY18x+CJC08D53ebuAGhcTvFhctAwHZpWIoxOnuXpkyJDr3YhODUWObMj4UEORvQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8298.eurprd04.prod.outlook.com (2603:10a6:10:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 02:57:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:57:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vadim Fedorenko <vfedorenko@novek.ru>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Topic: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Index: AQHb8jPan87Rdn8VMEKOXtXyIvr3+bQuTxKAgAKcLJA=
Date: Mon, 14 Jul 2025 02:57:45 +0000
Message-ID:
 <PAXPR04MB85103C39930C9F8DC9453DCA8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-3-wei.fang@nxp.com>
 <ace4e226-4ed7-49fe-8a2b-ee80baa2647e@novek.ru>
In-Reply-To: <ace4e226-4ed7-49fe-8a2b-ee80baa2647e@novek.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8298:EE_
x-ms-office365-filtering-correlation-id: 9814a78e-4142-4fc7-43c7-08ddc282356a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjhrM2FFd1Q5VjUxOXovN1I4djlJNWhDRnpBb0hzSWVaSHdnOWVBSGM5cCts?=
 =?utf-8?B?ZDlwQkU1bE1VVTJrKzQ2VW5hRStpSC8xSmg2Mk8xemlMbjgxWXVZT3pkNGV6?=
 =?utf-8?B?Q0FrTGFlMUpvUE9OejAyNVRYT2RqTlJSQVJSU3JKNkNzZzVTMHg4dlJJOEta?=
 =?utf-8?B?VytGWHhPK1ppWktmTWw0bTl5LzNSbDNIQTBTZ3U5c1BGcGRNTlYvZlFuQnZN?=
 =?utf-8?B?SThleDhxdEJZT2tocVEwbGprQ1FJcG8rUFBVRlZLQkNqb1pNWVRhck1VMFBT?=
 =?utf-8?B?cTBJcEo2Z28rTmlNdFowOGp0R3dwNUo4K0xwWWlsUU9Wa0Ira1FDQ0hyZ0Jp?=
 =?utf-8?B?blpHY3hybFRwNlFyaVhXdmJYcnk2WlNUVGptRmNwcDdranJLUmRQYkF6R3pR?=
 =?utf-8?B?bEw0VVZNVVlrb2grMGVwQWh6S1cveVYvWkNHMENOdTFaZzMzMXJOWEFzTyto?=
 =?utf-8?B?N1hEZVlnd0JjL0t5Q0pRQWFNN0UrYlhZNXNSS1dvRWo4U2Vqdk5EZE5YSlM2?=
 =?utf-8?B?SWVXMVIyZllUcUJkd0VISlgrSG1ubWljK2NwVUJ1cTZLUDZiQkhyM2JjTkdW?=
 =?utf-8?B?TkNDSEgzdUx0amtFRndmZ1ZOR0ZwUGYvWlBXTjBsWm9wQitHSlhkdU9IQm5v?=
 =?utf-8?B?bk5Nd3hjL2JtbnJVWi9USGgyRXZ2M0Zla1JPTmFsNWhPRnRqZC9tc1paVTBQ?=
 =?utf-8?B?OTI2dE9RUGR3NEJYUW91K041ZTB1am5LTFRqZzFJT2RFUnNKa0xRSTB0QkJu?=
 =?utf-8?B?aWhUckVvN01pSzYwSEpnVUxLNVhSOThyTi9raXRMWXBGUDVKaTVxK0piaHUw?=
 =?utf-8?B?NG1DakxOTmZqN1A1dHBacEVXQkpQWUFLUWlDZk1kL2ZjRUxjdHlsS0xFN3Nm?=
 =?utf-8?B?UVV6eTQ4QUl4YTU3UXl4VEozT05CR0RqMFh3ODluemQ5NzNmVFBCOEc1ODA4?=
 =?utf-8?B?eHNEZkhkSlBuK0FvaG5jTXF2cENVVDI4QW1QMWlQM1llM2NCb1ozUXpDdFRH?=
 =?utf-8?B?N3RyNlFJM0Y3ZkkzdTZ4ZjBYcXRtdG00aUxXenRTTFhhdFlnckJNVUdjWFMy?=
 =?utf-8?B?d0hHT2c3TkxGSUNkTmdVRUk3TEpKdkp3UlUwWmk5NWNUaFNWL3Y0WFhqZmVR?=
 =?utf-8?B?MVlkcEJMNmwyRHFnWmpMajRpQWF5bk51Z2JLUHNyT0s4dFBDS0FwRjlTQkJB?=
 =?utf-8?B?ZlFxVGJXTXUrWnFCT250am1DeEZBNjFyOUI2YURjQy9xRGhKUHVGdjQ0M3Vj?=
 =?utf-8?B?L0lxL1ZrOG1rSG0xbm1QNGI1VXlsWVpvN3Nzc2E4TUpPTk1DNnFHd2xCUHdl?=
 =?utf-8?B?UVpneGxRSHVFTUJKSjNIR1VCWEE5MWVyRXNjRW9ZVm9qQ3Bhc0s2OFBHWHpp?=
 =?utf-8?B?T0tVdmVqOTlIS2RRRFpWMlBMelU5SjJMbHh6ZkJQRUJIclFjdkEzRHp5K0tI?=
 =?utf-8?B?SUpuelVFQ2N1U0dZU2tpWlpPTUlSVkV0QVhpMEd6MUFlcXNzSys4TzE2cjdR?=
 =?utf-8?B?cUNVdHozODB0aHF5eFdvT0kwMVVRRjBlc1NHZGE1Q09oT1Q1SXVGaXFWZ3J5?=
 =?utf-8?B?emt1d0NzOXBEYmtBMWdiMjlLZE1OdVBBVUNTREt3RjhBMFU2ckJYWTdOM1Jk?=
 =?utf-8?B?NUhCay8ybUxzNmgxaExYdGxBRWlsM1AzaTgzTjJIK012RmJ3ejFHbGlIaTFz?=
 =?utf-8?B?WWdMWis0Y2d6b1NUV3EzR2pmcElHUzdpOHFJN21Qa2dGbWFaT3VSZTloZTBE?=
 =?utf-8?B?U3plT0Fsanl1bmpRZ0tlQWwrRVAxTjlwdlZMaUJtcEkzUlJLU3AxM2FLWVBv?=
 =?utf-8?B?RHRBNjlNM2VheGpnSDdVZXVJTmhaK0tZdzlOdCtPZFU1Wm1sY1N1QjF2eXdi?=
 =?utf-8?B?bFNCSVV5YkE2QWhNZWxFZnhTQmNuVG5uWVcvc1YvU1lHbFJPemdjSmV3bk1n?=
 =?utf-8?B?OFBvcGpKcmZ0ZUwrQXpCTkcvbmovQVFJQUR4ZHc2MHlnOGQwbk9yanFwOHJh?=
 =?utf-8?B?d2ppbTQ4SzRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk1kQ3pGb3c5ckZRWURzcGFGandocTVwYXMzNXoxWjNrMVJrQ25Rb1BlS1dy?=
 =?utf-8?B?NThxNnNmN1RsRmlYUFRDV295aHFOS3JsRXdpaFJEb0I1OURKSDVDc0MzRFho?=
 =?utf-8?B?OWxYRFFIY2UxR0w1RnJQaGJ4Y2x4aEMxN0xGQVB5SmxTbGN3cjVkTWZiVTBB?=
 =?utf-8?B?Q0NDOUZsbEQvU0VNVElLMU1WY2lsRThuMXJhNFRxNlUyMmordE92L041ZGNp?=
 =?utf-8?B?MWFvM0xNN3JVN2xJZHBzS1A5MFZtbFZUUUFuYnhyVmdHUi91eEpmaUJZZmVX?=
 =?utf-8?B?S28relYzWDZoSVBSQ3pabW9FSUhPQk5aTUdDTHdpcWs2dzd1dzJSNHpVWFlU?=
 =?utf-8?B?Vjk4N1V1VmVRUE1JMnRpMTVsNU9YNG9EM0FGOGM0ckx6TnlFcFE1Ujg1eC85?=
 =?utf-8?B?WVBaWS9OOGFRN0dSNWpKT2NLOGRMQ3lsYTlnYnM0U3N2WnQwT2xyU2xISk1h?=
 =?utf-8?B?aEYxWFJHNWJ4UkN2MTZrN0xDVldmSFNxS1NUSmlIZjFlbzdtWXZMMy9mbFhV?=
 =?utf-8?B?b0ZPOE11Zm5VNVdFWklLNTdTQWFEVS9GM3UxTmhGQ0Nmc3JzdUI2KzhteXZ2?=
 =?utf-8?B?THI0aDlZOG96TmFjcGFvTjZhRnVnUHJ4b0hUa2txbXF5QysyU1YwUC84Vm9p?=
 =?utf-8?B?TFhQZmhwZExUZnNKdGFHYmhUUVN4ZXFMYU5tc0srdDZucnV2QkZod05nYmJI?=
 =?utf-8?B?MnFxdkRWWlBKeTVlYUM2d2JncTBOanpJUkxpa09WKzZ2V1JjN0FYZTRnZ3Ba?=
 =?utf-8?B?K3NmbnNVT0svTkQwTHYwc0ZqM1FuWFFOTmp6ZnlpZ2J1ZG5mYlVXS3p6Vm1i?=
 =?utf-8?B?WVY2Z3RBVVR0bDVRa2NwRWZpaUQ3KzVVTHQ4SHFQa3NLUlV6cEhDOFVYN1N2?=
 =?utf-8?B?Q0NHdUJnVFQ4VWhOdm1GejJSTEl4dW1hRGQ1T0VaQmZUSjdGRTRYdm9tQnph?=
 =?utf-8?B?eUkybzZCY29mL3lvRWlyUVhwNVlGeXZabU1NS0Q0eHprVGlPN1FKRUR3VXBu?=
 =?utf-8?B?bHNxZEpBQ09nNmR0TnlWUnZ1d1dmcG9GcU5hNkdKZys5UEFZV0ZxeWJyek16?=
 =?utf-8?B?TGY3N2xBY01xcjBCZ056dUdqb1piNlFGbCtoZ09KUEo4UFAxUzJScXFZanh4?=
 =?utf-8?B?MS9Eb3pieUVOL2RBd29pb0VVYjRDVzlzSGREZy9KR3ZSMjV0SnFiKzY2R3ZO?=
 =?utf-8?B?STc4YzRMaHZJNnJhWklSOGZoMFZtWHE3bHArM1FtaW5SWk83a2o5M3FyaWlq?=
 =?utf-8?B?T0I3aFh2MW9aNmw0dmJwdXU2QVpuS3NRQURkL2U3KytWOGROOFlMWmd3L2Ja?=
 =?utf-8?B?RW5sYTA3R25vVnpLWU9GcGlmVjZ5cktKazVIUngxcGcxU2RwQmhXOGFBOHJV?=
 =?utf-8?B?SXZGQ3h3WCtZbDlLbHZidEx4MmNpYWJTcU5nR1dPZCt3b1ZpdVdiTmp5RW5Z?=
 =?utf-8?B?cTV6SFNLWTdXMS9GSGc3elIyRDZnT3ZBQklwTEdrbjNkaU1BaSs0RFpIcVVO?=
 =?utf-8?B?TzhCaGw2d2RpSmdSU2tYd0NCbWx0VUdqUnpoUkxiTHRrNmFEVXJOckFVSzFa?=
 =?utf-8?B?ZlhSM21rSVQzdEtHcEFDdnR0bXJnU3dIdXNmbmZZWlk2KzhmS1lKMDAvMUV0?=
 =?utf-8?B?bmdQczZZT3IvazE4RGc4dmM0cEJlUWlzN2dESkxqWEYzNEdabit3MWhwa0xk?=
 =?utf-8?B?TE4zMDRCd0k1aEpNRFM5K3YyUzBIU09jYkZEbW9IL25jazlhVFFlcDY0KzBo?=
 =?utf-8?B?R2dZT2tvTGRLUkNwendna0ozUmRkRUJDUlk1OW5BTXFYZjQveGNuNXBWdkM2?=
 =?utf-8?B?eXdvQThVN0dDWWRiamtEd0taejlPN1k3dW9hTE1uN0M0MlRSMENGRk9PdWZ5?=
 =?utf-8?B?cXZSZk5qSGFOWWtrTDI2R3RuRVN0ZHJ2U1Q5YmtyS2lzenoxQjUxWktmRXRN?=
 =?utf-8?B?ZGhiWGNXVnZXbEhHL3VHYklyY1pMK3hUTytpRVl4RDhmNHBSTEtvYlp2bjdI?=
 =?utf-8?B?aStzTFlCaktOT01WUGNOZ3Z1MjY3dzVHQk96T3QrRTFUMXhNeDZibFZEQlNB?=
 =?utf-8?B?QkJNelVSdHRMT2plNWtNNFNab2JNOTRHaGcwdGhsVXVwcnRxamtsSlB6SDZ6?=
 =?utf-8?Q?DM7w=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9814a78e-4142-4fc7-43c7-08ddc282356a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:57:45.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eFG/1FqtwBOOm34P9WPwTGMMERPbFVM4zEF/C/eAQlSKbrBmOt/GJK8vGDwIjT98ZNm+7+G0PBZIC0Hv+2dgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8298

PiA+ICtzdGF0aWMgdm9pZCBuZXRjX3RpbWVyX29mZnNldF93cml0ZShzdHJ1Y3QgbmV0Y190aW1l
ciAqcHJpdiwgdTY0IG9mZnNldCkNCj4gPiArew0KPiA+ICsJdTMyIHRtcl9vZmZfaCA9IHVwcGVy
XzMyX2JpdHMob2Zmc2V0KTsNCj4gPiArCXUzMiB0bXJfb2ZmX2wgPSBsb3dlcl8zMl9iaXRzKG9m
ZnNldCk7DQo+ID4gKw0KPiA+ICsJbmV0Y190aW1lcl93cihwcml2LCBORVRDX1RNUl9PRkZfTCwg
dG1yX29mZl9sKTsNCj4gPiArCW5ldGNfdGltZXJfd3IocHJpdiwgTkVUQ19UTVJfT0ZGX0gsIHRt
cl9vZmZfaCk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB1NjQgbmV0Y190aW1lcl9jdXJf
dGltZV9yZWFkKHN0cnVjdCBuZXRjX3RpbWVyICpwcml2KQ0KPiA+ICt7DQo+ID4gKwl1MzIgdGlt
ZV9oLCB0aW1lX2w7DQo+ID4gKwl1NjQgbnM7DQo+ID4gKw0KPiA+ICsJdGltZV9sID0gbmV0Y190
aW1lcl9yZChwcml2LCBORVRDX1RNUl9DVVJfVElNRV9MKTsNCj4gPiArCXRpbWVfaCA9IG5ldGNf
dGltZXJfcmQocHJpdiwgTkVUQ19UTVJfQ1VSX1RJTUVfSCk7DQo+ID4gKwlucyA9ICh1NjQpdGlt
ZV9oIDw8IDMyIHwgdGltZV9sOw0KPiANCj4gSSBhc3N1bWUgdGhhdCB0aGUgaGlnaCBwYXJ0IGlz
IGxhdGNoZWQgYWZ0ZXIgcmVhZGluZyBsb3cgcGFydCwgYnV0IHdvdWxkIGxpa2UNCj4geW91IGNv
bmZpcm0gaXQgYW5kIHB1dCBhIGNvbW1lbnQgYXMgeW91IGRpZCBmb3IgY291bnRlciByZWFkLg0K
PiANCg0KWWVzLCBmb3IgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHdlIHNob3VsZCByZWFk
cyBmcm9tIHRoZSBUTVJfQ05UX0wNCnJlZ2lzdGVyIGNvcHkgdGhlIGVudGlyZSA2NC1iaXQgY2xv
Y2sgdGltZSBpbnRvIHRoZSBUTVJfQ05UX0gvTCBzaGFkb3cNCnJlZ2lzdGVycy4gSSB3aWxsIGFk
ZCBhIGNvbW1lbnQgaGVyZSwgdGhhbmtzLg0KDQo+ID4gKw0KPiA+ICsJcmV0dXJuIG5zOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBuZXRjX3RpbWVyX2FsYXJtX3dyaXRlKHN0cnVj
dCBuZXRjX3RpbWVyICpwcml2LA0KPiA+ICsJCQkJICAgdTY0IGFsYXJtLCBpbnQgaW5kZXgpDQo+
ID4gK3sNCj4gPiArCXUzMiBhbGFybV9oID0gdXBwZXJfMzJfYml0cyhhbGFybSk7DQo+ID4gKwl1
MzIgYWxhcm1fbCA9IGxvd2VyXzMyX2JpdHMoYWxhcm0pOw0KPiA+ICsNCj4gPiArCW5ldGNfdGlt
ZXJfd3IocHJpdiwgTkVUQ19UTVJfQUxBUk1fTChpbmRleCksIGFsYXJtX2wpOw0KPiA+ICsJbmV0
Y190aW1lcl93cihwcml2LCBORVRDX1RNUl9BTEFSTV9IKGluZGV4KSwgYWxhcm1faCk7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIG5ldGNfdGltZXJfYWRqdXN0X3BlcmlvZChzdHJ1
Y3QgbmV0Y190aW1lciAqcHJpdiwgdTY0IHBlcmlvZCkNCj4gPiArew0KPiA+ICsJdTMyIGZyYWN0
aW9uYWxfcGVyaW9kID0gbG93ZXJfMzJfYml0cyhwZXJpb2QpOw0KPiA+ICsJdTMyIGludGVncmFs
X3BlcmlvZCA9IHVwcGVyXzMyX2JpdHMocGVyaW9kKTsNCj4gPiArCXUzMiB0bXJfY3RybCwgb2xk
X3Rtcl9jdHJsOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArDQo+ID4gKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmcHJpdi0+bG9jaywgZmxhZ3MpOw0KPiA+ICsNCj4gPiArCW9sZF90bXJf
Y3RybCA9IG5ldGNfdGltZXJfcmQocHJpdiwgTkVUQ19UTVJfQ1RSTCk7DQo+ID4gKwl0bXJfY3Ry
bCA9IHUzMl9yZXBsYWNlX2JpdHMob2xkX3Rtcl9jdHJsLCBpbnRlZ3JhbF9wZXJpb2QsDQo+ID4g
KwkJCQkgICAgVE1SX0NUUkxfVENMS19QRVJJT0QpOw0KPiA+ICsJaWYgKHRtcl9jdHJsICE9IG9s
ZF90bXJfY3RybCkNCj4gPiArCQluZXRjX3RpbWVyX3dyKHByaXYsIE5FVENfVE1SX0NUUkwsIHRt
cl9jdHJsKTsNCj4gPiArDQo+ID4gKwluZXRjX3RpbWVyX3dyKHByaXYsIE5FVENfVE1SX0FERCwg
ZnJhY3Rpb25hbF9wZXJpb2QpOw0KPiA+ICsNCj4gPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnByaXYtPmxvY2ssIGZsYWdzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBuZXRj
X3RpbWVyX2FkamZpbmUoc3RydWN0IHB0cF9jbG9ja19pbmZvICpwdHAsIGxvbmcgc2NhbGVkX3Bw
bSkNCj4gPiArew0KPiA+ICsJc3RydWN0IG5ldGNfdGltZXIgKnByaXYgPSBwdHBfdG9fbmV0Y190
aW1lcihwdHApOw0KPiA+ICsJdTY0IG5ld19wZXJpb2Q7DQo+ID4gKw0KPiA+ICsJaWYgKCFzY2Fs
ZWRfcHBtKQ0KPiA+ICsJCXJldHVybiAwOw0KPiANCj4gd2h5IGRvIHlvdSBpZ25vcmUgdmFsdWUg
b2YgMCBoZXJlPyB0aGUgYWRqdXN0bWVudCB3aWxsIG5vdCBoYXBwZW4gaWYgZm9yIHNvbWUNCj4g
cmVhc29ucyB0aGUgb2Zmc2V0IHdpbGwgYmUgYWxpZ25lZCBhZnRlciBwcmV2aW91cyBhZGp1c3Rt
ZW50LiBBbmQgdGhlcmUgd2lsbCBiZQ0KPiBpbmNvbnNpc3RlbmN5IGJldHdlZW4gaGFyZHdhcmUg
dmFsdWUgYW5kIHRoZSBsYXN0IHN0b3JlZCB2YWx1ZSBpbiBzb2Z0d2FyZS4NCj4gDQoNCllvdSdy
ZSByaWdodCwgSSB3YXNuJ3QgYXdhcmUgb2YgdGhhdCwgdGhhbmsgeW91Lg0KDQo+ID4gKw0KPiA+
ICsJbmV3X3BlcmlvZCA9IGFkanVzdF9ieV9zY2FsZWRfcHBtKHByaXYtPnBlcmlvZCwgc2NhbGVk
X3BwbSk7DQo+ID4gKwluZXRjX3RpbWVyX2FkanVzdF9wZXJpb2QocHJpdiwgbmV3X3BlcmlvZCk7
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK2ludCBuZXRjX3Rp
bWVyX2dldF9waGNfaW5kZXgoc3RydWN0IHBjaV9kZXYgKnRpbWVyX3BkZXYpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBuZXRjX3RpbWVyICpwcml2Ow0KPiA+ICsNCj4gPiArCWlmICghdGltZXJfcGRl
dikNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gDQo+IEknbSBub3Qgc3VyZSwgYnV0IGxvb2tz
IGxpa2UgdGhpcyBzaG91bGQgbmV2ZXIgaGFwcGVuLiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4N
Cj4gd2hhdCBhcmUgcHJvdGVjdGluZyBmcm9tPyBJZiBpdCdzIGp1c3Qgc2FmZXR5LCB0aGVuIGl0
J3MgYmV0dGVyIHRvIHJlbW92ZSB0aGUNCj4gY2hlY2sgYW5kIGxldCB0aGUga2VybmVsIGNyYXNo
IHRvIGZpZ3VyZSBvdXQgd3JvbmcgdXNhZ2UuDQoNClRoaXMgZnVuY3Rpb24gaXMgZXhwb3J0ZWQg
Zm9yIGVuZXRjIGRyaXZlciB0byB1c2UsIGFuZCB0aGUgZW5ldGMgc3VwcG9ydHMgU1ItSU9WLA0K
aWYgdGhlIFZGIGRyaXZlciBhbmQgVGltZXIgZHJpdmVyIHJ1biBpbiB0aGUgc2FtZSBPUywgYWN0
dWFsbHksIHRoZSBWRiBkcml2ZXIgY2FuDQphbHNvIHN1cHBvcnQgUFRQIHN5bmNocm9uaXphdGlv
bi4gQnV0IGlmIHRoZSBWRiBkcml2ZXIgcnVucyBpbiBhIGd1ZXN0IE9TLCB0aGVuIHRoZQ0KVkYg
ZHJpdmVyIGNhbm5vdCBnZXQgdGhlIFBDSWUgZGV2aWNlIG9mIFRpbWVyLCBzbyB0aGUgcG9pbnRl
ciB3aWxsIGJlIE5VTEwuIFRoaXMgaXMNCm9uZSBvZiB0aGUgdXNlIGNhc2VzLCB0aGVyZSBhcmUg
b3RoZXIgdXNlIGNhc2VzIHRoYXQgVGltZXIgaXMgbm90IGF2YWlsYWJsZSwgc28gd2UNCnB1dCB0
aGlzIGNoZWNrIGluc2lkZSB0aGlzIGZ1bmN0aW9uLg0KDQo+ID4gKw0KPiA+ICsJcHJpdiA9IHBj
aV9nZXRfZHJ2ZGF0YSh0aW1lcl9wZGV2KTsNCj4gPiArCWlmICghcHJpdikNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcHJpdi0+cGhjX2luZGV4Ow0KPiA+ICt9
DQoNCg==

