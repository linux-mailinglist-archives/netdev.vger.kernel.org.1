Return-Path: <netdev+bounces-146111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114ED9D1F6F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A34B2222C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1439114A4E1;
	Tue, 19 Nov 2024 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3RtMhFt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9D13B287;
	Tue, 19 Nov 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991791; cv=fail; b=DhS253/wOOcIOdSueuLJabXRPJsZfRPs4EP9cvJ/sIU5zIDGHZ5pDn/dvokN+rLOVi8/7Nz4Nc3gGuF+EjKGZaMECJL6iS7qA2XZ7qVhKGlYzkfcSRr6UzxEQmgMY7yY15pDMOQlHpg24KGh8lEbQSHa/7EOU6ILf0oJW3NeFVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991791; c=relaxed/simple;
	bh=tzz7SLam9qDsuU0969KZi0UcDdTszELMUsWAFDsbkCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KR2RaZLjOfhp7qY0qB0pBn6+FhzjwLFYLEylpNf63jl0kDXNi8pBKN2+hOpHpbHOK5d59+e0G7ZQswlnWzNhDLrSYD9QoHgXh/98BD4Sd6+Oy6XZz44IVIbh0embh9nlf9J5bKen592o4++vd8BdXngJ889noFwx8FlnAyTGpL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3RtMhFt; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6sIpb/WFRmX9Q1VveTVLKLYTG6eyzHplJd5ksWK6iOHECTW/T/nIDdZXDhu4udBa0WDxr3aqbBJi5R7CktxtQBBIE/m+zgla/bxCCxc3AAcnJGEzoP3wWRmuT4kPNo4tjkB2ReaWqO4I5MjcPw2AUB83oud+UEZqPAVTsP2qXqKvbf+EYy09aCSBD1kL1BPCxzRTCg45oNaod0I5fGLbPIzZD78MP+QqUdePlkmG5wMVWms6w64+RrRg7qYwb9pB9IbCnPqEO1UHFf3LsAP87WfjN8LwVklXCNMshTiG24ZmHtAL3mVNHOCPA60jEyeYP6ml/5S9+g7efhOeErSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzz7SLam9qDsuU0969KZi0UcDdTszELMUsWAFDsbkCI=;
 b=G1TqhCDnXmrwHB3NvWnVdN40bcEqbwJtotp7JvZsKbMCqvmyHp9ttN//tXu9BRT7yGeNZZCmO/b9HT+GAiUl+ONSjnyALKSMM2/GlswBuD8FahHNAwSFBSMh4rcSs6yKMLltQD1QbQ2rG6Enrg+8UZgQu4WHpvGwQEsVK4r61bWCcvv7UA8JApPOeei9LVvNVEOC9A68CkecQ3gI69sI1TDxWYZdyELrgoOLnI+5Yj6qcO+jRw49RxmJSu8CXRmcZj+SpCoUZwdzBNNN+x0IX8Bh9bngrkQ74eQHF4rSbufD5ExXRVEM2pQ3wiACswkFp6RVfgRSWi2doQ0VPcsfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzz7SLam9qDsuU0969KZi0UcDdTszELMUsWAFDsbkCI=;
 b=T3RtMhFtkAduecN6EslOQX2/neZvYakOVgfkf+ryeXanNcpjAgYrXqTZFILh8cPuXvoV+qqrtVEDG2E/A8gv3wFxf4DsYq/nASD4PmvT24EdxFotRmPi7aMxTz5Ncpn1+OzeZbYpLW3jF9aKabC/f1QdseTCJX2duG4etNVKaPNSKuxuXDreQCKwfwtXvX/5vEwHzKA3S3qG83zxICoBCtOpbbqu+g0U5lGh/vxSGfgzjTBJIbWI/NmMDNpVrrS9zLdcjeWn88lyKNab9fSO3UJKynmsEHuVHdk3/zp8EBdh7ihGRyYTpwknBaixyk00ZnVooXFSmpiLrnW0EZkvWQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8291.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 04:49:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 04:49:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v5 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Index: AQHbOYI/MCBBTftJV0e/RsBaTIB5eLK99jQAgAATasA=
Date: Tue, 19 Nov 2024 04:49:45 +0000
Message-ID:
 <PAXPR04MB8510BB4821C5813BA502297888202@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
	<20241118060630.1956134-5-wei.fang@nxp.com>
 <20241118193918.0a29dae1@kernel.org>
In-Reply-To: <20241118193918.0a29dae1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8291:EE_
x-ms-office365-filtering-correlation-id: 365b9cbb-4e2a-4cc4-d773-08dd08559720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QUhLRHY5bVFLZ0hjbzZTSGxjZXdaOU9uOERZdEVZVnVHeEthMDQzVmhEMXhi?=
 =?gb2312?B?cnl1aGVjb3M4d04wc1BESnlFaHZsaXNTRGhTTUFEUmlZOVlDeUVEYm9oWWty?=
 =?gb2312?B?SkcwalZla210UGxkTmU0UiswQ0E4MEFNQWk3aXgvMjJCSGRtQWk5aERwZHJV?=
 =?gb2312?B?ZGZUTE9MZTg5VVlKQloxNGpZdjloVURiN0xIQ09vTWhpSmlzSHN6K3FWZjRH?=
 =?gb2312?B?MHJydzVsZE4zeUZaMnBXa1VSZjNIN0xLY0lFWlh3QlBwK0dUVSt5L1ZSbCs1?=
 =?gb2312?B?UFU3Uk5NV3JIdkRUeTN4Mk9DWE9BTWJzK3Q3bE85QW5Bd0d2cmd1anRkSzdE?=
 =?gb2312?B?TnFHN21vdWFxWmRlckw3TjJlOE50RENkSXcydjNkVHdXMkV1TWo4ZURDNkVL?=
 =?gb2312?B?V2FwWU9DWUlhZ1g3bnVpd2NBR1h3T3BYV3daRCtlWXFFL3QvOUZoaTVHaWtk?=
 =?gb2312?B?cTVuSjU3dG1lR2lOaFBzaXdYcTFqcDlJaXd6TGhtelYyeUpxNUlOVUo1bThj?=
 =?gb2312?B?QVI3NXU2NnN5QU9qK2RyVE03eXFTTnVNSWQyVEtjQkRsM2U3MGxsRUNYUWFp?=
 =?gb2312?B?MU9MbVhZUVVzYXZrYWVWWHBhZmN6WmtJQ1VDc00vcUVLTEZBQlhHMXdjRzRs?=
 =?gb2312?B?QmVGUStTZi9uVk0yN096QVZRR0xoclFUOS9LTE40VEVTVllNZVNnY1F6WUEy?=
 =?gb2312?B?eEZ1MlBwR1RYaEVhUDlROU5oZ1lHdTk2U1lod1ozdG9BN09GVW00MWRFNVZj?=
 =?gb2312?B?c05QYXBoK001MjN4LzdEU0tKOEMyQU50cFNYSTNFZUtlQktDRnpvUC9lMGVU?=
 =?gb2312?B?MHRsNDFXaGxjb0pzTFRDV1VKcW1ZcjBIa1RBL005UGM0TVlncUZLdzJCZVd4?=
 =?gb2312?B?WGpDMTVIejU2OE9HVVBTamZwMW91VWpHN1hXQzE0eW0veWJ6eVBjVGI3R1RV?=
 =?gb2312?B?M0liUWlieW1Zd0cvdHp1V3ZSUm5OZlNXakk4UHNDOUw0bUVQR295cHBocGh6?=
 =?gb2312?B?YmFJNldQYXVXQTBoaXJBNVFIdVFrc2JXT2szVFVqa1c1T2dFY3JYNkdabDVr?=
 =?gb2312?B?V2MvdWorRTBsS1N2WURRaDNEUGFrbUdpbUdlOGo1Unp5SmVZNDk0YThWR0Yx?=
 =?gb2312?B?Y1VOSjRRdWpldkdjS3NJOHJDakozaDBtb3JRdlo1RGdiNkhqd2JGbkdTZzdU?=
 =?gb2312?B?UUk4STFTNUJNNGw0UXFFSkhYWTBmT3psZGg5dXlyREdra1N0b3VWeDFXWW16?=
 =?gb2312?B?VWdMeDBtMjh0Mk9TbmtoTFRkdHFvdTcreCtVV2lVSXJJSjBpVzYzY0JISnZ5?=
 =?gb2312?B?dFpINGJHcXc2ZnF4RXBBM0k3MU5DZ1NFVElYTFdtUUxpMmdsdjAyTEl4MGxJ?=
 =?gb2312?B?M2VZR042cHJpaWV5QVNkRG5sRGhvZTg3WnFzUFRETzV0T1ZvdzUxRHJ1MndL?=
 =?gb2312?B?OXFkeXhqT1hmZGdzeFRJdkRubWEyV0ZtdDFZTmw3ck1TTVFZb3RWclUyN3VI?=
 =?gb2312?B?d0dVRk5jcGhIeEUwRUhOMm9GbVI0aWtSb3ZsZ21Lem84a3BTK1kydkl1Q0d6?=
 =?gb2312?B?VWtYS1RnaThUbGt6ZUtkWE5KSU5wMXlNRTRJcVNjZU9mZThVMzhvYkxMUTB4?=
 =?gb2312?B?NFBCVnpjNGFBKzI5aTY2UTVKYWczT2V0VEZlUUUvVHdqUmVLVmZrU2t3cG1L?=
 =?gb2312?B?MGRxOXBrUU9PT1dTbnpSWkN5Vlh1Y01JYUR4SllXZHM4WmRzRUh1TVNKOFRQ?=
 =?gb2312?B?V1NSL01MOXBWR1lhem9BSnNnRXNHeTJNOVh1QnpzWFBKOGNlRk51MVFVNSt3?=
 =?gb2312?Q?azgrDCEe7mA8+UKU3efYzsmtaAVXh2z8UNIjg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K1Z6Q3Y4S2tQS1g5dko0MUhlblhONE9RbkN1QnJtM0RpalU0U3AwNTNGYzNW?=
 =?gb2312?B?UlBwcWRWSDh3dVdzZ1dha1pieG5wWk5oeDNYWFlQQ1N3UGFqbURJZjlpQzdt?=
 =?gb2312?B?M1lYanh0MmJFdTVpNkpLVmwxMjFieHRnYzhhTktpcTJSdUdsNDIxZ3NnY3Nm?=
 =?gb2312?B?VWkxMEJNaHhNaFByeTR4RWhaSU42OFdvVGI2cjlVNmJ2ZWc1VWQvb0lwSTFy?=
 =?gb2312?B?WWh2NTVhM0NySER5SHAyK3B1bUlVNml6LzJNNk9Ra0IvSDZORkhwWElyb1Fz?=
 =?gb2312?B?cUNEUTd5Y2NDRVBQNlRldTVFUUVsMkZqcWViOUIxT1NjT3FSTG1DQmlKMHg1?=
 =?gb2312?B?eWxwUG5NcC82ZWU4YkZkemJ5ME4wNWF0TzBGWkdMN3ZnTFJXQlk4cHpveXlp?=
 =?gb2312?B?QkpzOGc3ZkUwU29wK2tNZDRGZUplVlRsSDlBdGZVVk1mT3dGek8yUkh3ZUVC?=
 =?gb2312?B?V1YwSHpHZEg2bXBuYUoyMWl4Q053YUJVUG5rd1J2NWYzQ21EY3htc0ViZ1dV?=
 =?gb2312?B?ZXd3djJtSXZUVTFLM1ZhYlkzMktydVJpUTZnTDUvdUx1b1RxRDA2MEhlN2pR?=
 =?gb2312?B?aWtNNElicDhzcUNNOEVBUVJKSnFFQ1psYzNCS2p1M3ZDaDhGM1ZldDMrVjB6?=
 =?gb2312?B?cXRGSmlZTFd5ZmptWStZVmV5aytIRFdXNTlyczVkTGpadCtFMFhmZklwaFR3?=
 =?gb2312?B?dE5FMzg1b0dCWWUwL2Y3S0lUMzZ1ODZlcEtmR2g0ZllLeDFKK2tvaDY5TUh6?=
 =?gb2312?B?RG1md29JME5KVGl3Vy9Zc3hYK0MxK1lOYU1WbUxvT0d2U2xENjEwNm9BR0s0?=
 =?gb2312?B?VllCOG43b2Q0c2R3TzVSOWZveXFBOUw3ZWloOW9uOWZSb0JCbEJhVDlTaU9q?=
 =?gb2312?B?TlA3cm1vREplbnVmbm4rcStLUVg1cTErZ0lJdGd6Y0FlajEvV21ZN3ZLaysv?=
 =?gb2312?B?TGFRWktNS3NGQkR2S3BGcmhWcDJzeWE4WDEyYnl2WUlTV2MxUHZzaFVaVnNa?=
 =?gb2312?B?MENKTDVEeDFranJNRGtsUkNlaGxYMUZTRzlXb3YxeVR3emFQWkJmOEpxY0hs?=
 =?gb2312?B?M2NuV0N1ZGpRT2FRQkU0dEpyM1JBbWlYTWF4UU1vSXZUMWNOSlBJYUI0ajUz?=
 =?gb2312?B?Q3RUby9wK0VmQWs1TWJ1RTVsM1F0TkUyTXkzaDBqbkIra0xQdUdzZVExSzN3?=
 =?gb2312?B?eTJscEdnd0NjNElLMWlEcmFFZTNtTmhmNkd3eEFqeDRFSVAzU2dVOTZjTk8y?=
 =?gb2312?B?aHgxNytBVkdaMEpsZSszMFJjeDVEQTdMTmtpZGRxeWVKVENwQWthR3FvVWIv?=
 =?gb2312?B?bEtKaEd3cVVHQy9ONnlKOTFjWHFXKytocW1YV1R1UTc4UWpWYys3UG1wQUFn?=
 =?gb2312?B?VS9VTHFmWjFveHBiOGhGZGNxNXhoVStjL2pzTmVqWHV6TG9oTk56NDRyTnBR?=
 =?gb2312?B?STd0eEZxUUowRzl2cjg3QTZmalZBTFFmcVExK2F3WG0zbSs5djNNOFNBWHAv?=
 =?gb2312?B?bHU1QXdBU1FibEZhL3lIaFJ5WmJPeFlMRnN0dGhrR3htV000d2JCNE1CR1Zk?=
 =?gb2312?B?NkxTRmtwWHRnQndNUWNyRS84M1dlbThvcW5zRWk2VFE1M0N4NHZvN3lEajFu?=
 =?gb2312?B?d2VNM1ZKYm1Jb25KU1ppQitwODBSai82dThqNUZjM0w1Q1lSODh0VGxMR3R5?=
 =?gb2312?B?dXg2OC9XV0ZML0NrYnE0bGg4b1FqalpOT3VxZVMxQVhUcFhmd2diZng0R0ZU?=
 =?gb2312?B?MlJtRUxBOVk4amNLVEtFc0VyTFQ1VGdUUWNTUGpnV1JFMGY5UmFmMXkrOG83?=
 =?gb2312?B?c1JqZVlvU2pXcXR2dXhXd2NMeDR4YjV5RVZvVWhpeVQ5OEYrZmJicEpMdXg0?=
 =?gb2312?B?WmxLaFNZdmpyV1VOMnBOYVRsL0JhNlE3ZEpDNkRDWmFqNUQwSDRjcFVYSy90?=
 =?gb2312?B?ZGpBK3ZyaXlZd1BOZE8ydG5HVzJYUWJRNnlPbXk5NG0wVjFmekdZaXczaHdn?=
 =?gb2312?B?b2tCRk5HNG1iRjVBUmVyME5SSmN4WTVrYm9XYkxlWXhkMlBHNXlOWEM0K3B0?=
 =?gb2312?B?MUFmOVVCVHYvVXNXeTNCdGlsS2swUkRNeHZENHdaK05aL1ZaYWd3Y3RQdHho?=
 =?gb2312?Q?pnBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 365b9cbb-4e2a-4cc4-d773-08dd08559720
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 04:49:45.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpYinBK2Ic9ia5cBSFfrvhvkFb48L95OOmZwqfPP+gR8pwOJh97UJ8AIF68Xi5ut1VzpVwqh7ZDKtpnQtFhQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8291

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMdTCMTnI1SAxMTozOQ0KPiBUbzogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5v
aWxAbnhwLmNvbT47IFZsYWRpbWlyIE9sdGVhbg0KPiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+
OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiBhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IHBhYmVu
aUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSBuZXQtbmV4dCA0LzVdIG5ldDogZW5ldGM6
IGFkZCBMU08gc3VwcG9ydCBmb3IgaS5NWDk1DQo+IEVORVRDIFBGDQo+IA0KPiBPbiBNb24sIDE4
IE5vdiAyMDI0IDE0OjA2OjI5ICswODAwIFdlaSBGYW5nIHdyb3RlOg0KPiA+ICsJCWlmICh1bmxp
a2VseShkbWFfbWFwcGluZ19lcnJvcih0eF9yaW5nLT5kZXYsIGRtYSkpKSB7DQo+ID4gKwkJCW5l
dGRldl9lcnIodHhfcmluZy0+bmRldiwgIkRNQSBtYXAgZXJyb3JcbiIpOw0KPiANCj4gUHJldHR5
IHN1cmUgSSBhc2tlZCB0byByZW1vdmUgYWxsIHByaW50cyBvbiB0aGUgZGF0YXBhdGggOigNCg0K
T2gsIG15IGJhZCwgSSdsbCByZW1vdmUgdGhlbSBhbGwuDQoNCj4gLS0NCj4gcHctYm90OiBjcg0K

