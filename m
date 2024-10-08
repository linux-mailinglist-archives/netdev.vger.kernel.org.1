Return-Path: <netdev+bounces-132986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38B9940B2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD380B2573F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3C206E86;
	Tue,  8 Oct 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P6AVOoyf"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A161DE8AE;
	Tue,  8 Oct 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372365; cv=fail; b=O4f+UFDRGH2TjXOaENDlv9vXhGxgfQbTXdq/v6Z1zLV2BS1OsKSw1kcY+gEjI9pLj7F3GG1FXfQqi2zMIRakdLu5j0Twy+oph0L9IDYqQkkuPbbioxPDyg+IGGdiAOBuPyBmCTcIK0ZiZEKa9B6M1cJCqWuw1WE+NLbBfCQrh4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372365; c=relaxed/simple;
	bh=tICp2GXmkdiVkCSbTjLFCwXstegasUr0LX3w7RgmyJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlFXPD92GaF+8Zid7W9vZDWxFqz2Kyt2tADvYCJrRworda8TR5afGUZFU5qvXyT0s2Nba8YUD5dF5AcCx3cOADvHm5ro329Ik1qzokfii5u9+lZW5P8msDOO8UgCioKUiCVjnPpax2Sf/mEMLuJEv2U3GXpXH50arMGChyTrxeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P6AVOoyf; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnutv6biwnIXgZ8LzD1B4xxCmPHru7VWEwB5D8/zp1RG/ByAnpcgJJ0Uu9J4f1ztjiPSoObrqw+6X8TCdwbkUbRmts4wJ/6llv/DDYXzkc8OuodEwUdWIqgRdmFqXupR1XQBphDTp6fbB4cmMDLMQWR7ufQZSUc1E28kYtCzBF4YPvUxDMHCYYQ8mNbCWsI91cBp08i+Rbw2zs2TnWK4VKcQ2gU0JChk4uY7NybNSptAR0WDvZFfv+eSvZuEUk9Tq5GE8RpgAzn38fiS4lSNUWqHgGaapkIbiYuYJX/F9UV9wNM5zykQ/KVj9D5KjOoqXQPNxCbMCBFj/UeC+HX+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tICp2GXmkdiVkCSbTjLFCwXstegasUr0LX3w7RgmyJ4=;
 b=voFbKlp3SjrrAV20ldpJmuSEOo6qJ4l26LbAx0RcXv+efiKXRQcm8KEaeRMkFBW/YA2I4xE0DJ/w49+EKYkKE438p/eQxw2d4ryK9hYaWV0k3be/FwCxxb4KQvBWDJ64P1jE8XHI8FXSmgmZFjF11AC53TlK7vHCyNv8Bz3BEAwEHUAwAPG8mm8afqjzRtusMo9iosbUepOkottvfSlzvl5KLYnKQtLmQAVE9n7DRY1l90TxpIouIXY7MuFXqNAx8xdiRjaNkMCvlLIx8Vl0fg3daK8PaKIzGQC3oiB53dl9SVJkHjxx0CqNJiJR1A1ABnWrkklUoaP0/UiG9qWZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tICp2GXmkdiVkCSbTjLFCwXstegasUr0LX3w7RgmyJ4=;
 b=P6AVOoyfsvZKcEuSnZGTZqVNECv4KUPMGlSkVoK9s1Tl16/67dJokany0RC0h3dZ+Sm0+55B50PD4vBHy7A9niqukXphBAtpZzzsCe9ROvAx2MiB4decjkUp3dsZ6is2UNxutruO7NlmqB8MrIeoejriiDWM0jFoyQcDaSA8biC2qFwfCC6Q8nYIfKkKdqt0XPA/otCema2jsgxsf6QQJlOn2GO9z7UThwBHH+i422UGWakvOs689k1+pu5XSDMXW539NShUzW1roe9laTdCbrJoMai6uNNgqzlDOd2QbPorZqic4/nCjpxunQp/cTyAuX3c0btIZvg8P2zkqGf62Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9577.eurprd04.prod.outlook.com (2603:10a6:10:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 07:25:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 07:25:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 0/2] make PHY output RMII reference clock
Thread-Topic: [PATCH v2 net-next 0/2] make PHY output RMII reference clock
Thread-Index: AQHbGVL6nJ4E1WHcRkSZDR1a91kfhrJ8c58Q
Date: Tue, 8 Oct 2024 07:25:59 +0000
Message-ID:
 <PAXPR04MB85106EE705637048AA0B3377887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
In-Reply-To: <20241008070708.1985805-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9577:EE_
x-ms-office365-filtering-correlation-id: aa5cfe9a-b9bd-4616-3499-08dce76a74f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?WlRMd2JuQmhPNC8xdDE1bVNiRnZWUFFvbDFZOWxaRk5nOCttMmFWR0NuUnhM?=
 =?gb2312?B?QXc1aW5xOTNxdXhrRHhSdkYyMXVYREdyY0FWNFZaejJJRjlYSEN5aGRlaWcx?=
 =?gb2312?B?Wm12UnUzYndlM3lvSTlldVhkWnlTOXhlN3FtaHM1dHJFRmNFeGIxcTRsaHBl?=
 =?gb2312?B?RDdZc25XNkRLVkh2L1ViM1dIY0NjVzZpMWJsVkVhbVlya2xEQjh0YVNGVmkx?=
 =?gb2312?B?VFBCREx2WXE4UXBLa2RlMTM2cjdVK1RJM0JwblFpZzdGYU9jdjdTdVJ6TEhK?=
 =?gb2312?B?VENnTnRJeHVzR09xZXg4S0pXZDlQMzlFRXY1dzM4RzFDd1ZwcmJtWHB0U29H?=
 =?gb2312?B?enBSd0tRcXZCUmNhQ2h0UlFSamdDd29sYkxZUDRIVjNXM1Jkc2ZCVytBSWh5?=
 =?gb2312?B?WjdtZWN2ZkNJc2lJanZDd1FUbmVaOVpTYXRaeTVjdGhQZDFxejdsMDJwZXZP?=
 =?gb2312?B?ZGxNNDVzNllIc1FSNzVKbXdSdjh5Mlp2Zm9qUkJiTGhOQzFOQ24xYS9PSkRi?=
 =?gb2312?B?a0dFZ3ZJdHk5akgvcDNRY1RLckQ4VWFhaUlIT0g2cFhFOWh0UXdLTDM1M0g3?=
 =?gb2312?B?WUxzZGNqMmtQZ1BKcUlGOFFpdEhGNTRYZDRBN1g4UzFyNWNLcFd5bVNwank5?=
 =?gb2312?B?UmRUa3hTd1IzNjlQcmFmcVRBM0RVb2w3MUhKcDduTndiWHBESktIaGRtTWxm?=
 =?gb2312?B?OWlVTy9ZWUdibGd3SnptRnhEREVRaHZPVEdUR3dWak5NcG9PWkFPOEdkZVZJ?=
 =?gb2312?B?cUVjRm1DODhUZVJrMFNsR2RVRm82UlFUL0JTMnlkNmY1dmF2d2hYREhNTzBO?=
 =?gb2312?B?bWFFamxHUHFiUldWVGVEQmc4N3BxNzQ0bVErMmI3WUQ4aEZMbGJGdHRYa3dW?=
 =?gb2312?B?WC9QUzZ6SzVSRmRSaisrTVhVUklMTVVmd2pjb1FybVdFbHQzazdMdzB1THRY?=
 =?gb2312?B?SjdLUlVWTlZlNkRpY1VzZy85ZkpmQmRJaDU0aC9kN2VmRkJLL0N0bFJob2x3?=
 =?gb2312?B?YjNnekF1ZDQxaW92ell2VGxJUDk3ekUvbmNxanhKb09YdXJicUcrazBDR1BD?=
 =?gb2312?B?bkRrYklzS0E2cis1dlYyZ1ROd3I5N1BIOGNwQkozSEpLbTEwcjMyaEZJZDRD?=
 =?gb2312?B?TDhKL1ZMTU94ODZKbkRMUDRMa0FuV1BwTUFuS0EzRVA3dG1XMmloYXNxWGRo?=
 =?gb2312?B?MW5WU1RvZ2sydkhYR28rc3FtRkg1cTBjaFNGVkdWWUpFMVJYYzFGZWo3cVFL?=
 =?gb2312?B?YnV2YTAwQU5mU3NGazNVTnBDMENaNEhUNXZ3d0RsNFdmZVN1dkMxN3Z6dUhm?=
 =?gb2312?B?ZjQ4OEg2d05EZUhHV3FvaGJpL0kwbUVrbTljZXc3bjNENTR4OVU0RTBKMzA1?=
 =?gb2312?B?cFZYakw4SERWU3FySzJ0R1JyVkZGeFFWaTNNQndPVEZZSGJGOGl2V3lOMjVU?=
 =?gb2312?B?cVlrc0doZk4vYjBBdGZrSWFucnRzL2NRNTVZS0MzbG00ZGpUQXZ4amcrWE54?=
 =?gb2312?B?SEs2R3J4YWdWdjkxSEE2b2RkbmFtWE5NdURpeDVPUEVGZE1lQVl5R2hBbUNt?=
 =?gb2312?B?bGZHSGFpUitqQVNHd2o2eCs0Wmxsck4rZGNNdUpwa080T3I2bjdDSExuMTAz?=
 =?gb2312?B?UWZDSldNekYySldDZ3B2cWpESklVcysrUzQ0Yks5cW5sSW9qYWVQTzc5c1VP?=
 =?gb2312?B?Y3Z0WGpJZkg2akcydlJFTEtnaVVUZ2h1VXMzMVh0Zkt1MWJMLytONlBKZjNU?=
 =?gb2312?B?bG9QKy83WXAxeXAvak1RaDh0NkgzN2QreVE2L213OEVqVVZEOXlnL284QzhF?=
 =?gb2312?Q?NiFDYMCYeo+kbnsVrnHKuj7ytwwyVEGWDJqjI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L3pORElzTTBFcXBCVDNXeDNtRXNZTzZNckV5bUx5SW5weHB3U0NWd21HS29Y?=
 =?gb2312?B?NmlGTTR3YXZQRWhjWk9hMUhvY0RvYzZKS2ZMajZiRDZYeGZnajZKMU1tckdh?=
 =?gb2312?B?SVd0eHdZQ09FL2dvYysvUERMQWpnc1hUdC9LbzdIZVFER0tvSUp4QVVRdW5I?=
 =?gb2312?B?eU1YdnFsQi9aSGNpSXRxb1FRQ05PVS9mWjA0d3ErZEhwUTd0RFlybWtMWlFG?=
 =?gb2312?B?ZjZVSUpsR3VqS3ZLOWpYYlg5ZjN4MUN0T3cxUlN5dlNrdkwyN2hlcnI1NE1K?=
 =?gb2312?B?S21wQjdLNTdRSGNWUXQvQndqbFpTZElmMWY2ZDIrL2ViS1BtdHVnTzE4aEk4?=
 =?gb2312?B?WTFnQWNJNlp3QWVzZ29vUTRTR0hyZk9oTFBwVTBubmlMdmhFdmJpSFI5cU41?=
 =?gb2312?B?SHZjdm1sdjVWV0hpeGt6SG5tUmMvckg3RUNyc2ttVUo5NG5jMVRHb1FTclU0?=
 =?gb2312?B?QThkR2JXS1IwNFVtNHhBTU5NVGE2MHd1NnF4WUpVYU1sYmlldnBXQTAzK3l2?=
 =?gb2312?B?VzAwcXRGeVViT0VWY2xxSDl3dVUwcjdrYkxTd2dLeEkwYXphbVRONGhoNXBK?=
 =?gb2312?B?MW4vd3pUcXNPRDFHd1A0b2NzdzJpTVNRc3NDYW80Rm9semdiejJiWnpra0h5?=
 =?gb2312?B?QmZLcWFsSS9KcStGZm1QbTk1OFRRbW5mVW4wTEV5QVg0Slg2d1ZDU3YxZlFR?=
 =?gb2312?B?Ynlpa281S1B2SlN5VWdTZGtleEh2ZHludU80MXlDa1UyczRSN3Y2SFRjRFI2?=
 =?gb2312?B?a1ZLNEpzUXJGcGNLL00vZHczaDUxWUgwQlMvWkZPdWxIOTB0cDdVQjk1M2Vp?=
 =?gb2312?B?bklnSVhRbFZIelo4bjVDeXFWZTZTSUVhcElMNlovNk9vS1hyUTB2VHBUYkF2?=
 =?gb2312?B?ODJrQVF4dk5LWmI5UFlFUlZXUkhkS2p6dDdvaFk2U3JnQ1hxR3ZKTWU4S3FU?=
 =?gb2312?B?Z0ZNUXNXYVVVc3lRR29SdHpkMGJlQ1U2c1FBclZWSUVxdjRud3FHLzNkc3Zl?=
 =?gb2312?B?SW9UeE1CVmRXblVCSDMwVDVMTm1Wa1o0d1d1QW13aGc4OXExQjlBTGo5Y1Va?=
 =?gb2312?B?cFhINDZaNEsrejI2Y2IxUkUyQTdrMkxDa3hiQmg5MWFJaTh2czQ1WUxndGxO?=
 =?gb2312?B?cFVCWUJWeTJYdnNzdjlFS3pOamE1ZWVHQk1oK2UyRU9ITUpNUWJhNUxpRFV5?=
 =?gb2312?B?R1g4a3JSc1ZhSFJ3dFBlbEhCYy84NVFpaUlIOXkxdmpMcFdWNkRzSG5jNzlE?=
 =?gb2312?B?cmFYajJ6SFdKSERPWHpqYXU3TExUNkJ1Q2FnZVFTMVY0U1BrYmc3Z09TQ0lo?=
 =?gb2312?B?MlVxQUhBTFdXcmNWTVdoTVFTQk5WMVhwUXRzMGJpTHduT1NzeHZYTHFIbHd4?=
 =?gb2312?B?TlkvaVI0MkQxOEhEc0RqTWo1RDJmdWgybEY3WHJEdk1WeDloTFVPWndPM2xO?=
 =?gb2312?B?Y25jcFpOZ3dYSTdjcndGa0pyUzBITTNrNFVmekZ6dWZzWEdBZjRMNkY2aGtZ?=
 =?gb2312?B?WkNkdzQ2N0RIaFRmNnhkZXM0RXdaT1FuT0JjMmgzS2NlK0VNaWtIMEQxWml2?=
 =?gb2312?B?eGZlc1hCaHJHQVlyajI2dWo3NFdJd0dlQzR3ZFJCdGljR1hueHl1Qm1tbGdG?=
 =?gb2312?B?RFJreDJ5b2JHT3hDNGdMQUdVSmhMTDBkTThnaGNWVEFYUXZmYzk1NE9JYTQz?=
 =?gb2312?B?Nyt6MlhvWXBuUi82bmJ5ZWg4MnM1bXJ0NFoxbmMzSW0zUzBHR0VVbFVFMzUz?=
 =?gb2312?B?cWdGMmZOOTFvRDJteHVVWjZtOGpLSWgrNFVyVCs5VnpaVzN3Sm5BYXRrZytV?=
 =?gb2312?B?cXlWWGErTXUzU3pFL1BkSS9oaU9ZOFdhVzR3ZnhrOVhFb2dySFBCUXNEY0Ry?=
 =?gb2312?B?YXFaQXluME9iM3hXWjczYkM3Z1VTaFRzRk9zYVAyUUlSTDdMM1Q2Yitrb1Vi?=
 =?gb2312?B?ZW1WSU4yOUlNOERJSHpxU0ZGZnRtaTdxajVWN3FNYVhDOHlNb2pQN0JzOXkr?=
 =?gb2312?B?TkhNczJxbTZHTXVIVDhaejZESTMvSnc2R3Z2NUxYM2c2dWYrOGhKM3BpcGhh?=
 =?gb2312?B?dmtEVktyWEw0R1hhRjRLY1lZUDczRVpsbmdTSC83Q05FU0sxNlhmQXBObEhw?=
 =?gb2312?Q?BAV4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5cfe9a-b9bd-4616-3499-08dce76a74f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 07:25:59.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5RTTQbd+plDkLTKuqBSpUYNj4krVjTK1PJHiuAvPg2wsu1DNKQL69x17UvQFtsWTREVKZFYKGUch/mntcuUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9577

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOoxMNTCOMjVIDE1OjI0DQo+IFRvOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBn
b29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtl
cm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgYW5k
cmV3QGx1bm4uY2g7IGYuZmFpbmVsbGlAZ21haWwuY29tOw0KPiBoa2FsbHdlaXQxQGdtYWlsLmNv
bTsgQW5kcmVpIEJvdGlsYSAoT1NTKSA8YW5kcmVpLmJvdGlsYUBvc3MubnhwLmNvbT47DQo+IGxp
bnV4QGFybWxpbnV4Lm9yZy51aw0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGlt
eEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogW1BBVENIIHYyIG5ldC1uZXh0IDAvMl0gbWFr
ZSBQSFkgb3V0cHV0IFJNSUkgcmVmZXJlbmNlIGNsb2NrDQo+IA0KPiBUaGUgVEpBMTF4eCBQSFlz
IGhhdmUgdGhlIGNhcGFiaWxpdHkgdG8gcHJvdmlkZSA1ME1IeiByZWZlcmVuY2UgY2xvY2sNCj4g
aW4gUk1JSSBtb2RlIGFuZCBvdXRwdXQgb24gUkVGX0NMSyBwaW4uIFRoZXJlZm9yZSwgYWRkIHRo
ZSBuZXcgcHJvcGVydHkNCj4gIm54cCxybWlpLXJlZmNsay1vdXRwdXQiIHRvIHN1cHBvcnQgdGhp
cyBmZWF0dXJlLiBUaGlzIHByb3BlcnR5IGlzIG9ubHkNCj4gYXZhaWxhYmxlIGZvciBQSFlzIHdo
aWNoIHVzZSBueHAtYzQ1LXRqYTExeHggZHJpdmVyLCBzdWNoIGFzIFRKQTExMDMsDQo+IFRKQTEx
MDQsIFRKQTExMjAgYW5kIFRKQTExMjEuDQo+IA0KPiAtLS0NCj4gdjIgTGluazoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQwODIzLWplcnNleS1jb25kdWNpdmUtNzA4NjNk
ZDZmZDI3QHNwdQ0KPiBkL1QvDQo+IHYzIExpbmw6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2lteC8yMDI0MDgyNjA1MjcwMC4yMzI0NTMtMS13ZWkuZmFuZ0BueHAuY29tLw0KPiAtLS0NCj4g
DQo+IFdlaSBGYW5nICgyKToNCj4gICBkdC1iaW5kaW5nczogbmV0OiB0amExMXh4OiBhZGQgIm54
cCxybWlpLXJlZmNsay1vdXQiIHByb3BlcnR5DQo+ICAgbmV0OiBwaHk6IGM0NS10amExMXh4OiBh
ZGQgc3VwcG9ydCBmb3Igb3V0cHV0aW5nIFJNSUkgcmVmZXJlbmNlIGNsb2NrDQo+IA0KPiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254cCx0amExMXh4LnlhbWwgIHwgMTggKysrKysrKysr
KysrDQo+ICBkcml2ZXJzL25ldC9waHkvbnhwLWM0NS10amExMXh4LmMgICAgICAgICAgICAgfCAy
OSArKysrKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL25ldC9waHkvbnhwLWM0NS10amExMXh4
LmggICAgICAgICAgICAgfCAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjM0LjENCg0KU29ycnkgZm9yIHRoZSB3
cm9uZyAidjIiIGRlc2NyaXB0b3IgaW4gdGhlIHRpbGUsIGl0IHNob3VsZCBiZSAidjQiLiA6KA0K

