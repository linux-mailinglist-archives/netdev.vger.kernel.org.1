Return-Path: <netdev+bounces-160449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA4A19C28
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A567A4219
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48C17993;
	Thu, 23 Jan 2025 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gzAMhgdf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DA35953;
	Thu, 23 Jan 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595446; cv=fail; b=lAkYkN34DmwBSRxwiVrrpWjkWveTduyus+TjMw68EEX/3ueTah97in4jd20a8AKR070vCYuatrR3TDtdYQbaNtTQ5HECDurKQ9dDJlXf4vWs4ITuo83234d+Qe+myBJhKV5b7lBVh6tCKeWZhWD+FxjlJzOaWpiTvnTEopky68k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595446; c=relaxed/simple;
	bh=tjefL+Ks4c6pY0X/gXT1uy31iiiw/vR7Awt31sXeUJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ix/3xOxHW9/qHzHT1K1epie+KuAkKmnpBO7ynlYuiO2VGUAeUJE/UDZSeeYeaqdIMRzcWaRyf2s9xb7rAzOufgXXwyREScgrjkMplNKh0SYOQPoo9oAjPMO0c4S1L9v70zAPOc3U1EoHsmtenUjHJDvUE+oAO3AxX63phnHCeoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gzAMhgdf; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhzQxj5cotlZXymOd9WUCfShmFlTbpzeFYyJ/WadHhedh7nFXwuqtgXtfTnyxwiJSugL2lLFmYdCtvWQ8xKzqRLvpleJubqKE2gge+kG1TNsvsmYieaiTu13+VRjG3PAmn309JmEfD/aE0ol1vunhRWT4WUqf2NmfrTvFu8q2DfE6uPROQR7GluJGWbTDRBsNweqy0QCTZ6GlApaI0NqFGN/EFGEN/XWPjn3Ou8b1kggXM6p0twUIPz4iLKjZbsxoksnhXipgirdhKrBc2IPFI1Fpcj0+/DVpy/Et5nFt4rJoy5TGAcSG17e/4LZep+tyQVWvB9rHyr8Wm4xkhkXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjefL+Ks4c6pY0X/gXT1uy31iiiw/vR7Awt31sXeUJk=;
 b=lJY8i4ny/G2dI/6OpBdTBvkmGpbEAvJUD7E9Y/Q1DHAMNhhQvieXHQR1v/PhaVsc91JbypnobgfUiOT9fVTj+msDPZ/Ix7z8wVYzOqPHYW+orkDN5VFj33iTBK/mpDrRgDv4FtzXjca5lYiyqA6+HZ1C3KcLqNMNccMyOi9SZPR0ztWIeIl1ff9ElwADRo+Oji4DAp6hHsHMWQxxIPoThq/iW9RN4Eb6IhJvr+TbT3HmQourrClV7d7DlKEiDStlrmP9RTLQbyK0tAcU2mEGV1YRfzoT5PHVmEbwzsicE94TbdpFv9qbFmThFByLBH46g96Yj0BOF849V6KwlNvuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjefL+Ks4c6pY0X/gXT1uy31iiiw/vR7Awt31sXeUJk=;
 b=gzAMhgdfhJHHBhJV4AEkzlwHBDe9IuoS6HN8WHlmWowmFcI3PJJ5H71yw5mrtU1wLAUsHv7APJJLqITTRqkIfIbuJuMzOrZc0uXO2yZXOUIqdcfVCPdY1hM0ozQa5+i8OaU/l6Go5pGFbO+XPsdWeyjxd3J1rcwdp9+pKiQKbbyj0KWnzU7SSNXLD37OYVxaLgrnXQ4d9mtzf5Z4hC1RVpHKcJVKo75kOyljjps4Hyvv6wiHS0HziHCcAlv6i1cDa/gwvThDRRYFn68bJ27Phx3TC7AyV9rjCHb9A0MX+v16ErBvp6QChIGaMOjboOqN91UJWkAwiYsP/6EwR6y+ew==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8224.eurprd04.prod.outlook.com (2603:10a6:102:1cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 01:24:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 01:24:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Laurent Badel
	<laurentbadel@eaton.com>, Jakub Kicinski <kuba@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: Refactor MAC reset to function
Thread-Topic: [PATCH] net: fec: Refactor MAC reset to function
Thread-Index: AQHbbOyAPeJKCDzkMkG+Ch2hg+HlArMjjw/Q
Date: Thu, 23 Jan 2025 01:24:01 +0000
Message-ID:
 <PAXPR04MB851066EBEE8ADBFEBB1407BB88E02@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250122163935.213313-2-csokas.bence@prolan.hu>
In-Reply-To: <20250122163935.213313-2-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8224:EE_
x-ms-office365-filtering-correlation-id: 98b91aa6-b224-429f-4ae9-08dd3b4c9e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?azROZGloSTAzeURSMDYxNFZrdW9Ua2VIT2RhSFVOZHhpdHI1UktTZmxHbFpu?=
 =?utf-8?B?VnkrK2I2NDFYVHBvb1MzTTAxSjFGMERwcXluSUpHOUFMbmpRbGpwdlBVNXNj?=
 =?utf-8?B?MjlVa01vMlF2dUdlYnVZUjR3cGpCMzJyeGZwaUU1cGd3UkdYeEg1VUhtSVBt?=
 =?utf-8?B?am5TNDhzWWw4NnJyRmtHZktIemtOdisxdE5ZUXJQRk95S28ySkR1WGZuempl?=
 =?utf-8?B?d1BUS2xac1Nodjl6VlVlS2lGOERPU1NocGx6KzdidUJBT3VDVXFjcFN5MGxK?=
 =?utf-8?B?VE9DT2NhS2UvNThFRG5NQlBCczEyT1Z2bXNSQ3VMSjJTWXArWjZmcWpHTUlE?=
 =?utf-8?B?LzlZd1NlYVZiY2dvRzdwNm9uek44eDZFQyt0RzNKbUI4L1dFUUdRQkZmdUpm?=
 =?utf-8?B?bE1DNDBKK1VOVXBweEZVbE56R0VoK0VMVy9lanNnTS90ZDZzejcrV1ZuOW9u?=
 =?utf-8?B?dzBMZ2NYK0h2dE9Ga295NmVjSWxyTUp3ZVA1cEhGVUtYWjEwZXN3SElUNXJa?=
 =?utf-8?B?U3VhQUZlNUg0VnN0UFZiYTE1UlhSMFdZK1ZoTldMUlladUlYR1JadGVWMjVw?=
 =?utf-8?B?NUN6cVhZWS9sMVdZbDJRQWR0dUxobTgvbTlKVlRnQndsMlVJNk9OV1BHbkxE?=
 =?utf-8?B?Vyt0bVA2eEtTSy96anEzSldJUFlqSkJCNzdsck1BdFRsMFNGSU5VOW9UblZS?=
 =?utf-8?B?L3JiVVRybTVUQmZteXV6ZXlzeFg3YSt3VGJzbmU0clhXM0llcGFGWWw1SFg2?=
 =?utf-8?B?YUhXWVNTcEpaYjVaM2FUSDJ6azFyOGFpb2V0a1ZPRDNaOTRnems0RzhCNWpJ?=
 =?utf-8?B?akFHZzcvYXI2VVVrczBCWXpyNDdyNktXUXRLVEFtYVNYdHRkYlF6MHpKSFVv?=
 =?utf-8?B?a3RMWFlaOVRqdElvZjJSWTZZU0E5L2cxM3JqU0pQOWlDQlVUKzF3a2hsTk5Z?=
 =?utf-8?B?cG1abmxwY1dQSzJQeE5GRWoyaXluL245YngyMG1mM1VJcG9NMGk4azlnZUJU?=
 =?utf-8?B?QkxNRkJpU3lSRDh0RCtwT2JxVFBZNDRqS3ZHeU9uR014bzZGcWRnWFk0RE1v?=
 =?utf-8?B?RnVGNUVVTmRiakFTdVRUaytieTJyTkdvQkxITC9PbUlvZGtUNENFdUQzUjhJ?=
 =?utf-8?B?MlF1aGlxOE1tRUlWYzljdTVlalRscnd6NkpYZFdGZHZPOXA1aVRVWnVQcGV3?=
 =?utf-8?B?eC95cy9TanhTWHdUbXJ3czB1cFJCbW5EZTFCR1AxOVowd3ZBVy9qMERQNTRZ?=
 =?utf-8?B?VVJmR0ZvS2F3KzlQZzZrRUg4Vms3bHJWcC9GNmo5UDI0MzJMenZmcElUWkEx?=
 =?utf-8?B?MTBmbVZBaGQwZzVjcFdCTklVZ3dxbFBxR1lBZmQwMVNuSG13MTBPOFhKMzdx?=
 =?utf-8?B?YUdwRzkxQnZTT3VLRkE4UkhENExjNkorMHlQWWk0RGZaVHI0aW9iVDBybmkv?=
 =?utf-8?B?UXoyQWJMY3FESG1GK2w0a1FJZjFKN1YvNzh3bG9aSkE2akJmeWJqYUtUamRn?=
 =?utf-8?B?OE1DVUhLbUJoWDRhRmpReUJRb1JZc2V5TjIyUk45VjVvd3VpcXQzZGVZUXh1?=
 =?utf-8?B?WHRHeFpMaEYzTEtPUytVY1hua0dmeHFhSFlJRjhqNVo2UUlBaFNpVUtqd2ZN?=
 =?utf-8?B?SSsxVmhUa1g5SWVEWEFqakQ1WlVJampzTWhtQTR4SjQ4eFRaamkxSzdzNENs?=
 =?utf-8?B?WStxNkYzNmwyWkxYaGpybSt2endjcVZXT1ExREJ0RDI0cWlKMXNXd1pwRCth?=
 =?utf-8?B?MTZwVXpaY0YyOEh2QlkzN0VHSUExMHZkdjZIVGRWR3cvZXVLOU4xRmlSL3pq?=
 =?utf-8?B?cm51NFZIV3UwaE1vWTRuc2J0TDBWRGlIOFhzT2djNGwzaVBCTTlrcWFXRlhL?=
 =?utf-8?B?UDFHempvT2xaNk9QdlNNanl2dkxTSENjelhpN1JiVEZ0T1FXd0ZBT1JCaFBN?=
 =?utf-8?Q?ID8dmG4/oVLPOUTCjHxw/FjAJryhD0CS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDJrT0xFNTlyWkFZZmk0clhweG12YndQcmJuenN3dGtJT2pWdmh2QmNud2FX?=
 =?utf-8?B?bG1DSEhhcS84Ni9WcWJ3TStwK241ZFdpSnNqeEVOYW5NQjJLYTAxbldDbG5R?=
 =?utf-8?B?alZKNnpNSGRheW9BbDhuVTFxUHVJT3B4dWgxYVVUanBPWDVCSWlCQ0ZNc241?=
 =?utf-8?B?ODlJTzhaMFF3S2UyR04wdGhZMEM1Q3FYV2pCN01OMlRYa3cyY2VycVBsMlli?=
 =?utf-8?B?SC9KQVNsc0ZxbGc4UVo4eTE1K3JERFNwelZkQXdkQjYvUDRrcitmVGwxNGc1?=
 =?utf-8?B?RkEzWGVVT1ltRzJBbHhMZVFORWxzZVlDV1kwV2E0eDNxd3djaU9EZlNXVWFR?=
 =?utf-8?B?eUQ2dGVoMkovL3QyZHlGVDJSdk9sR2FzeWwxdXk2dWtaNy9jNkY4M0R5eW00?=
 =?utf-8?B?MkZIRWxlOUhtM1kvVUdmYUZTdDJVTnByb2lpSkZwRFgrQjFEbDE0bE5NOFZD?=
 =?utf-8?B?TDJwbWxvaWZoSUZwY2t2WVpMRXpBaG9iWmJPT1ljY3JJc25WK0V1QWppVWhw?=
 =?utf-8?B?dGxXcWp0eFQ4My9EY1o4d0VOVmFoZFVOQUZqZzlKbUV5Y0VpaWhMTTNGaWNR?=
 =?utf-8?B?ZXRIUW5UdmhCTnZxakJsOXdRbTM0WXBycFU5RklvT21IN2tqSUxmcDhvT3JC?=
 =?utf-8?B?R0JoUitPZGd4cjJkSlF2Z2JFOXFrdVFIc3B5WHJ3bXgxQ2QvUkRLd2xQcE5M?=
 =?utf-8?B?UVBzMzNscXFSeURKZk9vMWpJcEF0a000MGlNWHVXalduM0ExY2V4dzZBdllP?=
 =?utf-8?B?bjluU1QreXlqUFNURkJzS0VVemRWQ3Q2NGVYZXJrSGZpOHF2T3pIVEpienNO?=
 =?utf-8?B?TTNmSks3UmUzMjRkN1NVcld4RzdITFZhcElra0VXKzdNdTg3LzMrMW1Rbzg4?=
 =?utf-8?B?NmQwQ0taalRRUUJpb1dCQ2RTcVVJeDBTRnV2Z0haZGZ3eERNbG5EU3hMN2NR?=
 =?utf-8?B?UDlOOGVtOVNCWVk5MHRlajkwTjV0ZTBxNm1aSjluN05FSXphdlRwL0g1Tjlw?=
 =?utf-8?B?QzVmMzJXcXhseThNTS9pNXpVaVlHMEdGK3pOdXZEWXQ4Z0hZMkRUdC9mbzQv?=
 =?utf-8?B?eEdUU2E1Vnh2Wm90QXVnV095bW5lYm1hQ3l4M2VmNi81NENYaC9FM3c4eThJ?=
 =?utf-8?B?WVhqc3FEMVI5VDdZQi9hdFZ1Mi9nR051UWgrZWlrTGpsUUNLZ2RaQkUzbGVa?=
 =?utf-8?B?Y3N0Q3dVNjBxT1EvclQzTFdJOWd6SDNFdkV4SjBFZEpoQlNIYXA4NVlXUnBm?=
 =?utf-8?B?aWF0ejJDeGdMdzZPZ2V0MlJJcTVRekRYSi9sQUE0bTcranRDdFE2SDJhaTR5?=
 =?utf-8?B?bWsrSkJFaVVKYi80UnQ2NUpma3ZuSHpxL2dhdmJLVTBGWng4enZ6RUpMTlpG?=
 =?utf-8?B?UnpINVR5eG96dUdYVHVtMml4dFZ0RWpWZWhYeXBnSWNPOTdpVjN6RzNkeGdu?=
 =?utf-8?B?ZEQ2SGRLMjVnMndFaTYyczV3MUQzak50NzhHeG4zMjhXdlpnUFBqdU5lZW55?=
 =?utf-8?B?SDFySVFXb05zTWdydHhCblN5Nzhsc2pMNVVrVlZkUThqL0t2RkJLeUpKS2JJ?=
 =?utf-8?B?blhoNW0rNGlDZUpLY0ZnWFJDMGhBNjBRWmJGcFRtdVBaTDNEYVpDODBHWEJK?=
 =?utf-8?B?Qis0N0VBa25qZTZ0MmRhUFVSVkVPUCtta05UWFZlOFNwUWRCZk00RklaVHVD?=
 =?utf-8?B?ZCs3YXZWQ05aRDhWVUl1MkNqSjlXeldtdjNiN2dMZnhUWVJjaGNqSVRMZDRJ?=
 =?utf-8?B?NmV5bGVwZXRERVgzTmExOVM3cFdQSXlyc0toM2E1L3hVcm1RaEJXNzNvbXg4?=
 =?utf-8?B?U2Yxa3RSZFpYWnY4ZGxERk5RODlkeG42M2RYYno0RWJDNWhiRDhUYXBZNW53?=
 =?utf-8?B?SUYwK0wyTHRQdk5DOUNaazhDVVB5MmFlaUNrb2JkRldQam14WGNGdUxYcEI3?=
 =?utf-8?B?NVp6YklsTkFjbGRjMEZvVHR5TGVPa0dOUFVWem9neGd3U1IvT3JYTCtQKzZP?=
 =?utf-8?B?ai9FZjdTNjBPMnlyMG9XWTM3SDR6VWxSSWowYmF4U1piOWR2V2h2MUtMWTlR?=
 =?utf-8?B?YnMvVUJoOW9uTFN5OEQrYzllb0MrZEJoL1U0Z0plN0czamdOdHF4RzlESk16?=
 =?utf-8?Q?jBnI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b91aa6-b224-429f-4ae9-08dd3b4c9e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 01:24:01.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmGS0F/h0xD0CZrjG/qpaqoaTDCuc1Lt0PcjwqVVfkNqVYX+femDx9VAxgoeTx8XKpJToVEv4QoaiYJAYGDwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8224

PiBUaGUgY29yZSBpcyByZXNldCBib3RoIGluIGBmZWNfcmVzdGFydCgpYCAoY2FsbGVkIG9uIGxp
bmstdXApIGFuZA0KPiBgZmVjX3N0b3AoKWAgKGdvaW5nIHRvIHNsZWVwLCBkcml2ZXIgcmVtb3Zl
IGV0Yy4pLiBUaGVzZSB0d28gZnVuY3Rpb25zDQo+IGhhZCB0aGVpciBzZXBhcmF0ZSBpbXBsZW1l
bnRhdGlvbnMsIHdoaWNoIHdhcyBhdCBmaXJzdCBvbmx5IGEgcmVnaXN0ZXINCj4gd3JpdGUgYW5k
IGEgYHVkZWxheSgpYCAoYW5kIHRoZSBhY2NvbXBhbnlpbmcgYmxvY2sgY29tbWVudCkuIEhvd2V2
ZXIsDQo+IHNpbmNlIHRoZW4gd2UgZ290IHNvZnQtcmVzZXQgKE1BQyBkaXNhYmxlKSBhbmQgV2Fr
ZS1vbi1MQU4gc3VwcG9ydCwgd2hpY2gNCj4gbWVhbnQgdGhhdCB0aGVzZSBpbXBsZW1lbnRhdGlv
bnMgZGl2ZXJnZWQsIG9mdGVuIGNhdXNpbmcgYnVncy4gRm9yDQo+IGluc3RhbmNlLCBhcyBvZiBu
b3csIGBmZWNfc3RvcCgpYCBkb2VzIG5vdCBjaGVjayBmb3INCj4gYEZFQ19RVUlSS19OT19IQVJE
X1JFU0VUYCwgYW5kIGBmZWNfcmVzdGFydCgpYCBtaXNzZWQgdGhlIHJlZmFjdG9yIGluDQo+IGNv
bW1pdCBmZjA0OTg4NjY3MWMgKCJuZXQ6IGZlYzogUmVmYWN0b3I6ICNkZWZpbmUgbWFnaWMgY29u
c3RhbnRzIikNCj4gcmVuYW1pbmcgdGhlICJtYWdpYyIgY29uc3RhbnQgYDFgIHRvIGBGRUNfRUNS
X1JFU0VUYC4NCj4gDQo+IFRvIGVsaW1pbmF0ZSB0aGlzIGJ1Zy1zb3VyY2UsIHJlZmFjdG9yIGlt
cGxlbWVudGF0aW9uIHRvIGEgY29tbW9uIGZ1bmN0aW9uLg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1p
Y2hhbCBTd2lhdGtvd3NraSA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbT4NCj4g
Rml4ZXM6IGM3MzBhYjQyM2JmYSAoIm5ldDogZmVjOiBGaXggdGVtcG9yYXJ5IFJNSUkgY2xvY2sg
cmVzZXQgb24gbGluayB1cCIpDQo+IFNpZ25lZC1vZmYtYnk6IENzw7Nrw6FzLCBCZW5jZSA8Y3Nv
a2FzLmJlbmNlQHByb2xhbi5odT4NCj4gLS0tDQoNCllvdSBzZWVtIHRvIGhhdmUgbWlzc2VkIEFu
ZHJldydzIGNvbW1lbnQgaW4gdGhlIHYxLiBJZiB0aGlzIHBhdGNoIGlzIGp1c3QNCmEgcmVmYWN0
b3IsIHRoZW4gdGhlIEZpeGVzIHRhZyBzaG91bGQgYmUgcmVtb3ZlZCwgYW5kIHRoZSB0YXJnZXQg
dHJlZSBzaG91bGQNCmJlIG5ldC1uZXh0LiBJZiBub3QsIHBsZWFzZSBkZXNjcmliZSB0aGUgYnVn
IGluIG1vcmUgZGV0YWlsIGluIHRoZSBjb21taXQNCm1lc3NhZ2UuDQoNCj4gDQo+IE5vdGVzOg0K
PiAgICAgUmVjb21tZW5kZWQgb3B0aW9ucyBmb3IgdGhpcyBwYXRjaDoNCj4gICAgIGAtLWNvbG9y
LW1vdmVkIC0tY29sb3ItbW92ZWQtd3M9YWxsb3ctaW5kZW50YXRpb24tY2hhbmdlYA0KPiAgICAg
Q2hhbmdlcyBpbiB2MjoNCj4gICAgICogY29sbGVjdCBNaWNoYWwncyB0YWcNCj4gICAgICogcmVm
b3JtYXQgbWVzc2FnZSB0byA3NSBjb2xzDQo+ICAgICAqIGZpeCBtaXNzaW5nIGB1MzIgdmFsYA0K
PiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgNTIgKysr
KysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfbWFpbi5jDQo+IGluZGV4IDY4NzI1NTA2YTA5NS4uNTIwZmU2MzhlYTAwIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMTA2NCw2
ICsxMDY0LDI5IEBAIHN0YXRpYyB2b2lkIGZlY19lbmV0X2VuYWJsZV9yaW5nKHN0cnVjdCBuZXRf
ZGV2aWNlDQo+ICpuZGV2KQ0KPiAgCX0NCj4gIH0NCj4gDQo+ICsvKiBXaGFjayBhIHJlc2V0LiAg
V2Ugc2hvdWxkIHdhaXQgZm9yIHRoaXMuDQo+ICsgKiBGb3IgaS5NWDZTWCBTT0MsIGVuZXQgdXNl
IEFYSSBidXMsIHdlIHVzZSBkaXNhYmxlIE1BQw0KPiArICogaW5zdGVhZCBvZiByZXNldCBNQUMg
aXRzZWxmLg0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBmZWNfY3RybF9yZXNldChzdHJ1Y3QgZmVj
X2VuZXRfcHJpdmF0ZSAqZmVwLCBib29sIHdvbCkNCj4gK3sNCj4gKwl1MzIgdmFsOw0KPiArDQo+
ICsJaWYgKCF3b2wgfHwgIShmZXAtPndvbF9mbGFnICYgRkVDX1dPTF9GTEFHX1NMRUVQX09OKSkg
ew0KPiArCQlpZiAoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfSEFTX01VTFRJX1FVRVVFUyB8fA0K
PiArCQkgICAgKChmZXAtPnF1aXJrcyAmIEZFQ19RVUlSS19OT19IQVJEX1JFU0VUKSAmJiBmZXAt
PmxpbmspKSB7DQo+ICsJCQl3cml0ZWwoMCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gKwkJ
fSBlbHNlIHsNCj4gKwkJCXdyaXRlbChGRUNfRUNSX1JFU0VULCBmZXAtPmh3cCArIEZFQ19FQ05U
UkwpOw0KPiArCQkJdWRlbGF5KDEwKTsNCj4gKwkJfQ0KPiArCX0gZWxzZSB7DQo+ICsJCXZhbCA9
IHJlYWRsKGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+ICsJCXZhbCB8PSAoRkVDX0VDUl9NQUdJ
Q0VOIHwgRkVDX0VDUl9TTEVFUCk7DQo+ICsJCXdyaXRlbCh2YWwsIGZlcC0+aHdwICsgRkVDX0VD
TlRSTCk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogVGhpcyBmdW5jdGlvbiBpcyBj
YWxsZWQgdG8gc3RhcnQgb3IgcmVzdGFydCB0aGUgRkVDIGR1cmluZyBhIGxpbmsNCj4gICAqIGNo
YW5nZSwgdHJhbnNtaXQgdGltZW91dCwgb3IgdG8gcmVjb25maWd1cmUgdGhlIEZFQy4gIFRoZSBu
ZXR3b3JrDQo+IEBAIC0xMDgwLDE3ICsxMTAzLDcgQEAgZmVjX3Jlc3RhcnQoc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpDQo+ICAJaWYgKGZlcC0+YnVmZGVzY19leCkNCj4gIAkJZmVjX3B0cF9zYXZl
X3N0YXRlKGZlcCk7DQo+IA0KPiAtCS8qIFdoYWNrIGEgcmVzZXQuICBXZSBzaG91bGQgd2FpdCBm
b3IgdGhpcy4NCj4gLQkgKiBGb3IgaS5NWDZTWCBTT0MsIGVuZXQgdXNlIEFYSSBidXMsIHdlIHVz
ZSBkaXNhYmxlIE1BQw0KPiAtCSAqIGluc3RlYWQgb2YgcmVzZXQgTUFDIGl0c2VsZi4NCj4gLQkg
Ki8NCj4gLQlpZiAoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfSEFTX01VTFRJX1FVRVVFUyB8fA0K
PiAtCSAgICAoKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX05PX0hBUkRfUkVTRVQpICYmIGZlcC0+
bGluaykpIHsNCj4gLQkJd3JpdGVsKDAsIGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+IC0JfSBl
bHNlIHsNCj4gLQkJd3JpdGVsKDEsIGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+IC0JCXVkZWxh
eSgxMCk7DQo+IC0JfQ0KPiArCWZlY19jdHJsX3Jlc2V0KGZlcCwgZmFsc2UpOw0KPiANCj4gIAkv
Kg0KPiAgCSAqIGVuZXQtbWFjIHJlc2V0IHdpbGwgcmVzZXQgbWFjIGFkZHJlc3MgcmVnaXN0ZXJz
IHRvbywNCj4gQEAgLTEzNDQsMjIgKzEzNTcsNyBAQCBmZWNfc3RvcChzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmRldikNCj4gIAlpZiAoZmVwLT5idWZkZXNjX2V4KQ0KPiAgCQlmZWNfcHRwX3NhdmVfc3Rh
dGUoZmVwKTsNCj4gDQo+IC0JLyogV2hhY2sgYSByZXNldC4gIFdlIHNob3VsZCB3YWl0IGZvciB0
aGlzLg0KPiAtCSAqIEZvciBpLk1YNlNYIFNPQywgZW5ldCB1c2UgQVhJIGJ1cywgd2UgdXNlIGRp
c2FibGUgTUFDDQo+IC0JICogaW5zdGVhZCBvZiByZXNldCBNQUMgaXRzZWxmLg0KPiAtCSAqLw0K
PiAtCWlmICghKGZlcC0+d29sX2ZsYWcgJiBGRUNfV09MX0ZMQUdfU0xFRVBfT04pKSB7DQo+IC0J
CWlmIChmZXAtPnF1aXJrcyAmIEZFQ19RVUlSS19IQVNfTVVMVElfUVVFVUVTKSB7DQo+IC0JCQl3
cml0ZWwoMCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gLQkJfSBlbHNlIHsNCj4gLQkJCXdy
aXRlbChGRUNfRUNSX1JFU0VULCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAtCQkJdWRlbGF5
KDEwKTsNCj4gLQkJfQ0KPiAtCX0gZWxzZSB7DQo+IC0JCXZhbCA9IHJlYWRsKGZlcC0+aHdwICsg
RkVDX0VDTlRSTCk7DQo+IC0JCXZhbCB8PSAoRkVDX0VDUl9NQUdJQ0VOIHwgRkVDX0VDUl9TTEVF
UCk7DQo+IC0JCXdyaXRlbCh2YWwsIGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+IC0JfQ0KPiAr
CWZlY19jdHJsX3Jlc2V0KGZlcCwgdHJ1ZSk7DQo+ICAJd3JpdGVsKGZlcC0+cGh5X3NwZWVkLCBm
ZXAtPmh3cCArIEZFQ19NSUlfU1BFRUQpOw0KPiAgCXdyaXRlbChGRUNfREVGQVVMVF9JTUFTSywg
ZmVwLT5od3AgKyBGRUNfSU1BU0spOw0KPiANCj4gLS0NCj4gMi40OC4xDQo+IA0KDQo=

