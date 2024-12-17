Return-Path: <netdev+bounces-152589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7E9F4B46
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83991885FEC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252471F3D42;
	Tue, 17 Dec 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j7oAjur5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8B1F3D39;
	Tue, 17 Dec 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439948; cv=fail; b=uuGE0PqB1Fqu8Md4b5JGvw3X5gPxaYsADi2YnfzrNe1dGezGIR4PSALMrTm9zX2hVmuHHMbU7PTxip1DcTdnxQjFl55x4yQm2psHkKZVfIrEyasN1/Tnr/7BFeGIhwWCPd+qgPOJszHrm1wcHCVbKpwZ6PLADsSLTh194o0exkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439948; c=relaxed/simple;
	bh=3QhHevCL32sX+M+HZOwQwR5aG0Wjjf2OIoXgdEEFFRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qz/uQ8bh+RpbE/NycOYrY+LJEZKgdqr7eyvZVcWGtrB8kLuonqiVxly7u1Oju2VicSUlxOByOzus0/IiDGLcn8I41MHzChvncQHAXWmEa6pNH//a20FkIHFSkOEZaBTTzuiAMVRbRLmNPFtFXWQtvlnc31f5efT1Ue4RewYoFwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j7oAjur5; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzPN3gQAyVAApFRNRyPp6mqFwhg9qMrnQ4qJJmWnY8+bluumXWTvEwjlPT1LqBajDlJHWNlZMke12SpQyuWPYppATPJFRsXRmE4qNdJXdiDcytmu0cbo2Qd6Cc+ZjlpLflx+ik9I7lU/gAa5NaVs1pYuy8fiJY/eO/4MKVG5UyZLcDNiPdcLPJ7y/U5XkFAJUwZ6bcdnEsUF8qNGLquVsImZtX1+lSwXwS0KlzQaRUpsCW67mygMdFPl+wfu7+gO9CBaleE+IdOSdeLrKzf9D5WCaRc1vVE6KGyqfeL1UVkdwEQ5J0mwzqvjFpQ3KrXsx4FX02ExCd2E5IpeKVIWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QhHevCL32sX+M+HZOwQwR5aG0Wjjf2OIoXgdEEFFRo=;
 b=T+03osQ6heZxazBDaPP8rcu1JjyRoDnSO4w6uN7GqMHFSI2B+LtPF1TSAgP4YVgO0Bm7duwm268EZfvHqn4j3Gs/6HfFbyLrfZc28jEYgme0T/dMMU/1y3uTvEGTxDnAN8NqVzCH5fSIk4Aj5OhFfKsWDz/dnJcszLq0T1eja3PqeRXoGBxEdCWxlGa4Y51fw2qyE9GbYnntkDFAL9qDEJ3dHbOHttPhnl16V0oPldif1kZW90QBpTb/uaQ3N6oDZTLcrazhThrWGEblUFguMwQvY2Q+I36tzZcdUY6xPxtd6Q2G4GJMPz422co4kJ0QS6bkzwWSUGkhsOYc1ShUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QhHevCL32sX+M+HZOwQwR5aG0Wjjf2OIoXgdEEFFRo=;
 b=j7oAjur59P20RRokdKGyTjmf11QqAvNUcpuc3xdUHrsTsYLHZ2G4JNstKqQrYuz9RcVtL5N7Vshct7eAGlYmVU9jcUtveVp0yUtZ454jbJhWbOO7P1L3EJyhwtpfUnfvdppV7lL7eLihiXXpYBn1eySVYJNhg1t4h2oKlAedsBdRTbZYhsMjx6NAUThZryXjYkehMMrjlJLmXcs3B1ni/kBDm6loMS097wH4f3HYauTOA35T2CA4YU9w2ZQV+ZF4oOPMJ/qlZlPwLo6agjc9wT/9T1oTZ9IUGIBUfjBLaYmTqTMc2N9Z8a1rdYSndVdKoMknbJ3MPMP22uvl6HMWvQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 12:52:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 12:52:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Frank Li
	<frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@idosch.org" <idosch@idosch.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Index: AQHbTQds3cs7GTJJukOoxOijXKUPD7LqL64AgAA5kcA=
Date: Tue, 17 Dec 2024 12:52:21 +0000
Message-ID:
 <PAXPR04MB8510C7788E6979D1D04A18B588042@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
 <118bbd72-b1fb-4da2-b1bd-5a66ecfe7322@redhat.com>
In-Reply-To: <118bbd72-b1fb-4da2-b1bd-5a66ecfe7322@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7266:EE_
x-ms-office365-filtering-correlation-id: 708ca026-7e98-471f-9684-08dd1e99a5dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHphNGsrMXB6R2JFT0JHQVM5MkxZYUt6cEFvMHRjSG4ybEpTLzh5UjZSd2M0?=
 =?utf-8?B?czJwVGM0ekZGT0owQkx0WTZobTlFNEt1elZweFQ5L0lCMDA4SnRwaDhRRENX?=
 =?utf-8?B?R2cxcWRNZzZ6bnZkRmJ3RjVocUt3bzhMbVRUSE1BdjRvdDRidjFRdDdpZk9B?=
 =?utf-8?B?dGRCYnROVDYzaVM1Z1dCa3o5dU9oQktoM2dTR3F2Qm5PNDFBN2FKSkNnU3Q0?=
 =?utf-8?B?cSsxL3JKYVFheThOVGd1MUZuTTBoc2hiVkMzNGcvNnZKZ0VBUk5TY3k0SXVU?=
 =?utf-8?B?K3lza3p1cjVjSnMwcjBId0hGNjFKbFZ5WlRHOURNZysyRE1HN3BiMjdJN1Vw?=
 =?utf-8?B?NmZ6cVljMjJoczNoWThORmU4bnFjMWs2Y25qSUdWdWgwb21BKzhkc2lMMWkv?=
 =?utf-8?B?L2h6dEE2MGovUzk3Q2dZQ3pEZHFoeEw5VDVMd01HSW1hQVpXUDUrSXR4SXZy?=
 =?utf-8?B?ZE0ra0F5L09FWGp5MzR6ellGWkRCYTV3U3JZVXJRL2xvblBxK083cU1WSGJo?=
 =?utf-8?B?azgvbUZwak5kY2l3b3NCV1lWYk9yWEJ1ZXU5cU5ocVBKamVKc3lTNG5TazRD?=
 =?utf-8?B?c1FCVDJxYytobmJEbVFVRG9HTFVCTnhNY0RFN0dFazNDRHNJYzVOekwyQUlO?=
 =?utf-8?B?Q1NURC9iOGg4SysyRnBER1N6QmdBMjhpR3d5RXlUYUtoajZHbjQ3ak0rRVBE?=
 =?utf-8?B?OTJWM1NrZVpmUGZDaUZDaTZlQ3NWVy9Fc0wwWDlJSlBEVlgyUGVZYUVzUmFX?=
 =?utf-8?B?MWdWUlkzVllHUWd5a0I5MkJvMVVqaFdZVWhBSlFXT29tbCtEVEVwU1F3dlFN?=
 =?utf-8?B?czFqVU9mNHR0TUI1ZDJ1cVpOSURoWGp2b1BXWklaV3VMZzZKZlo4RmNXWXR4?=
 =?utf-8?B?R1ptOVM1cDdvbUc5NXB0eGlNYkhhZkxYY1RUd25keFRsMkJNTVd3SnFPZUNG?=
 =?utf-8?B?YUtmTEk2SzlwcHN1SzlxWE16Z004MGpSQWdpeVFoVlpORHZmU29wZUZEOTNY?=
 =?utf-8?B?NnlReVpwTnBadnRJUTZaWHRrcmo5emIya29yUFpOZmJnMlFBQXk5eHE0NzUv?=
 =?utf-8?B?YzBUWHQrL09jNFhCYzJRZDNyQlJOVEM2dk1NbUxZb3pZeU5uRWlmSnlwQ01L?=
 =?utf-8?B?WDRLUG5DcFJPeDNZcWg5eE94bVFTZ1lBNU1QaGtRQ000QWRWWEkxUURVcjlu?=
 =?utf-8?B?SVBvakRuYW1NOGorZy9lbzlOalNPNzM4T0VLb0tKRDM5aE1PdTJxT3pvekpu?=
 =?utf-8?B?NU5kNytuZzYwSCt2dm5TeXFsUWxsQkY1Tk9YbE5ndVd5SlhBMUgrSWlUbXlL?=
 =?utf-8?B?cGhWTUV1L1NWUkVGeFlUSmtGQ3psdUhodFNyZmI3OFdPUTNPYXo1emFxYXRD?=
 =?utf-8?B?blVRMTk1RlZzWGt4VEMxZEFzQ2ZHRjNwUGZFMUZLaTZsMlFJVVk0c0YvdUtK?=
 =?utf-8?B?dWFOUEFOazhLbFFVNWs4M2xZT21TYnpIZW1kZUYwYm5jZGJySzl1MzJVQkVz?=
 =?utf-8?B?TGlQRnhTUGZtZEVRWkV2UFhzaDFRRC94VlExL2NPZG9TVnowRmh4N3VBVnpI?=
 =?utf-8?B?ZGNMdVRVMW1zeW9jZ2FJMlVOakVHSzNWTks5dDRzN3NoQ3JyQjB0eWl0eWox?=
 =?utf-8?B?b2JCc093R1VIUTZ3QU4yOTJxSVVhaUhuVTNJRnBhN1dZeWxxRHV0VXJEbzVG?=
 =?utf-8?B?alVQY3ZqVllRWGRnV2wxSG9ySnFHb2RPenVsNEFIMmN0TEs0dlJody9tczYy?=
 =?utf-8?B?L0taMkRabVVlTjRuZGg3TENDR0VzL0VoV3c3L0ZPUW9BdkVzY1JXbWpuSHFW?=
 =?utf-8?B?Z0NZcWhYc2lvUytvcHVTV25waHB6N3RNNXBsaU5sZEk4NnJTSDJieXNwU3V6?=
 =?utf-8?B?QkVGTWlWQ282cFNuekszWEF1b1hJaUFyMVdWZmdYTFp1UDZRMzZ5eUZSVm9E?=
 =?utf-8?B?WDNqVE1yNWl4Q3VOU29UUUhGUjlKa3hqUzJLNU81SmhtU1dPaDNHSFc5WGZK?=
 =?utf-8?B?SmV0VW94dXpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2twd1F4QmU2Y3BtVmNMd3I4cGFuazRYeHV5VHNnWVBZMDRZUEF5OUZPaWRp?=
 =?utf-8?B?cmFraWFSV3pHSVl0SFVsWnFFNXFzd29OQ0U4WmZ6ejlBWU5tWFpXZTdPb2c5?=
 =?utf-8?B?Qm1ITG1aZmw2K2l0bURyTjJxaU8wc3BSaVZUSGVGU29oY2JOQTJIM3h2bEFR?=
 =?utf-8?B?L0o0Q3I3WU4xdXZrWlpkVUVlVkp3Y1BpVlhjK0JVNytFamZjYVptN2ovdXZD?=
 =?utf-8?B?c1FSaU90VnVPdTEvc2k0dlIxR3Q3c0VlRmx1Y2h0NEhTdGErSUV1dTRCdjUx?=
 =?utf-8?B?TWFYQU9ScFJ3VVJUTUxtWlg0eTIxdFNzZVVmVTFlSnhJL2Fsck1JVkJ0YjlW?=
 =?utf-8?B?VEVOR2hOcVdwWkRISEpTVFVCaCt1UDhGd0pNRnJ0aUhOeW5nRUh4QUUvQy9s?=
 =?utf-8?B?WllEMTJtS1l0NzJkZzJmYVNNcG5LVjlWWllCYUtTbmZxWGRNdlhRc1dMWmZE?=
 =?utf-8?B?WE9Pck5scDcwNDFSYmo0bmsrb3Jja0VjQmhZWXl0YlpJQ0d5UEJaVDRkdkZy?=
 =?utf-8?B?ODZBdTBvZGsxTHZ0WndSbkZLT0dGS1lrbHZ0SmR3S2MxeUFUMGkxdzA5aTda?=
 =?utf-8?B?Qzd5UDBaN0dmWG5JMWgxcm5RWkFxb0Nid2xlN3Y2MG1abldWRHFWMnl0YkEx?=
 =?utf-8?B?UHIvdUZlamJyTU1tVktQSXlYMEJodzdNMVlyandJeXV1WG5NVmhCb3hnRGVI?=
 =?utf-8?B?QjNUdkVyWkw2NFdlZ3NMUUozaWpzSlNkbGlZd2tjV0QxWHE5SE1wLzhTNysx?=
 =?utf-8?B?OGZTR0FUV2JoVTRXNVdocEIvTTJ3K245bUNVZnhDL0w0aXk3QXJNSDNFbXg0?=
 =?utf-8?B?Y0dDSk1PUldya3ZSRzZQZkpJOWN6T0ZEeFd1S2IrZStCVys1MnJEcDFMRFhK?=
 =?utf-8?B?S2NVNitmTHZ2c053ZUkxWDY1QTdkNWt6bUpNR0tYVXpCRFU2OSs1Y0dESzBq?=
 =?utf-8?B?T2xYeU1xTiszdWs4WTFtRXY0UmczNWx1ZDNvRjdCd2xuTUlwSDBHZUw1Mnl2?=
 =?utf-8?B?VWNIZXIwcitCaGwwbmVSZ2daZDNUTGkwL01JcE5ma2Z2ci9YVE55Z1VDUjRM?=
 =?utf-8?B?WW9hYUsyZlcvWTBqeFU3Zkw2VlQ1Q2owa08zZ1FSK3FtVlk5c0JsMDdXS255?=
 =?utf-8?B?dnhseE42NThxN3grT3MrTmg4UEpTbjNvdGh0bm1DWWFQaTFMckhTKzBMdnJB?=
 =?utf-8?B?WE5MMG9rRDk2dzlmUU5IS0p5d2RQZ0xKb0t0bHk3QUJYYmFXWGlHNGFJd0Vx?=
 =?utf-8?B?d3h5YXdCaFh0SElHUUlHTkVhd3YzSTlGeXhEY0lNb1NNUk9paDRFVmYwd3ZH?=
 =?utf-8?B?OE1EZzh3OHZxWUF4bmNaU245anpscjVHaFZGVUs2M1Z4Zy82alBqQUtTMERH?=
 =?utf-8?B?RExHV3VIZGpQVVF6Ym50VU5sRmtOTlUwamtuUmtIdDJmTVNKQ1V5VFY2TTh2?=
 =?utf-8?B?cXJLbmFCUklFU0ZnS1BaVXp5anFSbU5uSGxpYnE1SlF2ajhCWGh2SGlQZWZK?=
 =?utf-8?B?aVRLcmNXMFJYdm1OUkFnT0svS2g1aEpvcHV6TmlHWEVEdUI2a1pma0tsSHM5?=
 =?utf-8?B?bkZoRFZoWlNNV1JOdnZXOGFEeHFJRkxka2orai9FMmRXVHJSbVJ4Unh6STB5?=
 =?utf-8?B?Q0kvWHJBUGRYRDJYMnZlTnAxZGdwVlptZ2lSZFZURU0xakJ3cHRLSUlQR1Iz?=
 =?utf-8?B?U1RDTjJWMHRVb3lOVWVvdFZTeDNKQ1ZYbm5MbFV2K1lKNVRkRm1BWWJTc1Zs?=
 =?utf-8?B?d3Nva3RWRHFlZmlDUlNQTHFpZ1BrOGZqNW1wZFdMQ1FYSExCOWMzMStvOFY3?=
 =?utf-8?B?ZVhmeUhkRGpXQVFuanVWZEdRK3lNdWhrU0F6NzFOczlhSFgzY2NHVnh6dlN3?=
 =?utf-8?B?SVVtU2tVaDBMMlJzMWRJWURCa2V4MDZPbUN3OUdBb1RSUE5qL0ZveHZTNStH?=
 =?utf-8?B?T0I3MFdCOFdzcWxTQTBMVmMyckhSVTZBcndFSWxSY1pNcWJRZDFXTVorUjVK?=
 =?utf-8?B?UGVxaEhnL0dwNlNUdDNHbjUrOVp3ZmZwVXlGQnlQdDlaNjlqRUkxY3hCYXpB?=
 =?utf-8?B?Q3lDa201TXdHb2ZzSjZadzZyUnFGWGYxdlZoQkYycHdYa1d2RHFhN2g1elQw?=
 =?utf-8?Q?AJoM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ca026-7e98-471f-9684-08dd1e99a5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 12:52:21.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYKvCXo41XvSowA1M1ETxAY/0q3tELYaCEi58/HNYxj/KiJOi1p99eYmKynLh2XkR2Ita82WqeoXv3X5/4RDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMuaciDE35pelIDE3OjIwDQo+IFRvOiBXZWkg
RmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IENsYXVkaXUgTWFub2lsDQo+IDxjbGF1ZGl1Lm1hbm9p
bEBueHAuY29tPjsgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47DQo+
IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5j
aDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJu
ZWwub3JnOyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7
IGlkb3NjaEBpZG9zY2gub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjggbmV0LW5leHQgMy80XSBuZXQ6IGVuZXRjOiBhZGQgTFNPIHN1cHBvcnQgZm9y
IGkuTVg5NQ0KPiBFTkVUQyBQRg0KPiANCj4gT24gMTIvMTMvMjQgMDM6MTcsIFdlaSBGYW5nIHdy
b3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
Yy5jDQo+ID4gaW5kZXggMDljYTQyMjNmZjlkLi40MWEzNzk4Yzc1NjQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IEBAIC01
MzMsNiArNTMzLDIyNCBAQCBzdGF0aWMgdm9pZCBlbmV0Y190c29fY29tcGxldGVfY3N1bShzdHJ1
Y3QNCj4gZW5ldGNfYmRyICp0eF9yaW5nLCBzdHJ1Y3QgdHNvX3QgKnRzbw0KPiA+ICAJfQ0KPiA+
ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSBpbnQgZW5ldGNfbHNvX2NvdW50X2Rlc2NzKGNv
bnN0IHN0cnVjdCBza19idWZmICpza2IpDQo+IA0KPiBQbGVhc2UsIGRvbid0IHVzZSBpbmxpbmUg
aW4gYyBmaWxlcw0KPiANCj4gPiArew0KPiA+ICsJLyogNCBCRHM6IDEgQkQgZm9yIExTTyBoZWFk
ZXIgKyAxIEJEIGZvciBleHRlbmRlZCBCRCArIDEgQkQNCj4gPiArCSAqIGZvciBsaW5lYXIgYXJl
YSBkYXRhIGJ1dCBub3QgaW5jbHVkZSBMU08gaGVhZGVyLCBuYW1lbHkNCj4gPiArCSAqIHNrYl9o
ZWFkbGVuKHNrYikgLSBsc29faGRyX2xlbi4gQW5kIDEgQkQgZm9yIGdhcC4NCj4gPiArCSAqLw0K
PiA+ICsJcmV0dXJuIHNrYl9zaGluZm8oc2tiKS0+bnJfZnJhZ3MgKyA0Ow0KPiA+ICt9DQo+ID4g
K3N0YXRpYyBpbnQgZW5ldGNfbHNvX2h3X29mZmxvYWQoc3RydWN0IGVuZXRjX2JkciAqdHhfcmlu
Zywgc3RydWN0IHNrX2J1ZmYNCj4gKnNrYikNCj4gPiArew0KPiA+ICsJc3RydWN0IGVuZXRjX3R4
X3N3YmQgKnR4X3N3YmQ7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfbHNvX3QgbHNvID0gezB9Ow0KPiA+
ICsJaW50IGVyciwgaSwgY291bnQgPSAwOw0KPiA+ICsNCj4gPiArCS8qIEluaXRpYWxpemUgdGhl
IExTTyBoYW5kbGVyICovDQo+ID4gKwllbmV0Y19sc29fc3RhcnQoc2tiLCAmbHNvKTsNCj4gPiAr
CWkgPSB0eF9yaW5nLT5uZXh0X3RvX3VzZTsNCj4gPiArDQo+ID4gKwllbmV0Y19sc29fbWFwX2hk
cih0eF9yaW5nLCBza2IsICZpLCAmbHNvKTsNCj4gPiArCS8qIEZpcnN0IEJEIGFuZCBhbiBleHRl
bmQgQkQgKi8NCj4gPiArCWNvdW50ICs9IDI7DQo+ID4gKw0KPiA+ICsJZXJyID0gZW5ldGNfbHNv
X21hcF9kYXRhKHR4X3JpbmcsIHNrYiwgJmksICZsc28sICZjb3VudCk7DQo+ID4gKwlpZiAoZXJy
KQ0KPiA+ICsJCWdvdG8gZG1hX2VycjsNCj4gPiArDQo+ID4gKwkvKiBHbyB0byB0aGUgbmV4dCBC
RCAqLw0KPiA+ICsJZW5ldGNfYmRyX2lkeF9pbmModHhfcmluZywgJmkpOw0KPiA+ICsJdHhfcmlu
Zy0+bmV4dF90b191c2UgPSBpOw0KPiA+ICsJZW5ldGNfdXBkYXRlX3R4X3JpbmdfdGFpbCh0eF9y
aW5nKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gY291bnQ7DQo+ID4gKw0KPiA+ICtkbWFfZXJyOg0K
PiA+ICsJZG8gew0KPiA+ICsJCXR4X3N3YmQgPSAmdHhfcmluZy0+dHhfc3diZFtpXTsNCj4gPiAr
CQllbmV0Y19mcmVlX3R4X2ZyYW1lKHR4X3JpbmcsIHR4X3N3YmQpOw0KPiA+ICsJCWlmIChpID09
IDApDQo+ID4gKwkJCWkgPSB0eF9yaW5nLT5iZF9jb3VudDsNCj4gPiArCQlpLS07DQo+ID4gKwl9
IHdoaWxlIChjb3VudC0tKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4g
SSdtIHNvcnJ5IGZvciBub3QgY2F0Y2hpbmcgdGhlIGlzc3VlIGVhcmx5LCBidXQgYXBwYXJlbnRs
eSB0aGVyZSBpcyBhbg0KPiBvZmYtYnktb25lIGluIHRoZSBhYm92ZSBsb29wOiBpZiAnY291bnQn
IGJkcyBoYXZlIGJlZW4gdXNlZCwgaXQgd2lsbA0KPiBhdHRlbXB0IHRvIGZyZWUgJ2NvdW50ICsg
MScgb2YgdGhlbS4NCj4gDQo+IFRoZSBtaW5pbWFsIGZpeCBzaG91bGQgYmUgdXNpbmc6DQo+IA0K
PiAJfSB3aGlsZSAoLS1jb3VudCk7DQo+IA0KPiAvUA0KDQpUaGFua3MgZm9yIHJlbWluZGVyLCBJ
IHdpbGwgZml4IGl0LiA6KQ0K

