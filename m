Return-Path: <netdev+bounces-223424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F231EB591B6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1D832431E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C46295DBD;
	Tue, 16 Sep 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/eP6qo6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717C284693
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013404; cv=fail; b=eUjof3uZW03HeHyLki7vPgVazv5pEd0U+AFypIleVARiu0YHGLv9j9QN8Bc9KYCDFKVraQkqqGKoP9EI9ACIhk9CmRN/MlgvvPjC7bC+80ToOCMO40kqJpYRfk7/9ENH7kkzsuqkoVDobOueTAk3IQyGB+YYRoZBPY6t1J8eibw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013404; c=relaxed/simple;
	bh=efQNvu4dr/+IfhVF1qSW81OCij4QwDbbinpYdqG2bu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aA6Bm1WINbhq3sbzkfJslbxzVe+ZhvbTOQrBIAP8m3pEV5AxnRIzENKv7UZOxmBDAbNclZPBXAahAUOyIxWnSRf0l9ugpEtM+GyL3wVbIenTCEAxBiFqtk+YOR6/FZ0f/Mx5grr2x61Bg/rG9Gie1HAnCGajyeZ/GHWqRD1kdlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U/eP6qo6; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPXhdVgF5/jRXoOybAfrXRAsVbEaBNOe097CqRpUU8408xw2X0La43kiLIufy5L3x70KfuQJrYu+KgvLT8V0k9DU8nORnad0S3eRUoJyXNRLPdji//Y+xfUeXmxnKiMBEcvIxiE90lvh1FeIVLHAv3KA3y7YmUa9inx3e9d0hxa8hQDVjcYJspCFqlmMBi45hiBr4xbsjy7u6KbWnG6K3gH0Oo2tt06MjVSwi+P0NHjp3zD7C7JGofUNQsbkLU70cv57uznSbqWCBduqneTwjqg56QfkoZ+uGed9Ldz0fzb/AfbaKyZZheZ671NaTIXy3tLMeydiJxEGIR1xKed09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efQNvu4dr/+IfhVF1qSW81OCij4QwDbbinpYdqG2bu4=;
 b=YAsQxsGeQD3Uj1eOac1CQNnqu5Eb6fFYyOCVL7cvp4Fle3m4pzmF3Z1wTUtcKd1YBj9dlCgyxePz4A1oAGfbaBt/5FaLYIyxjDV6asmWtl/OdzdDiReIWMNPVv2griFFWmHyaE7/oPjthc3odNcCDy9bLQLHNpw7ITF0Lo6v7x06dr8D571/Ie1jmyzYgh02bMtMdgnJ7eCVhrm6yEETGdavvUnmnn9ZdleJB6qLCg+Swy4TEJl76NnI2wOmXjGUQAbbGM8ewzpXHTOC7w1e0AyTzelT6xJhVffb3tLMUiE881rEwEWlLqOIfZCsg8Uw39CAIFFRhIq8ULzAPmH9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efQNvu4dr/+IfhVF1qSW81OCij4QwDbbinpYdqG2bu4=;
 b=U/eP6qo6iPPQkQ1UwPAHh2DGzxpJm42tJHsw/eji+y7F6zBpkBC9ndYDndUYCjItSle3AVv6c5sP9SfJwMDi1Xb0mrBdiEZO6uCrqHv/+QanG7di6ql5Oz2tAjdckRCAR+p3eaazaDowImc3n14MJW1Nqu1wQvwA5QMziqCO2ZGiFMdADxbgXg4tn0VQ+5GGiwetBQhl2eccfapvOSe0B1voDU5xtyUEMpNHnf5335uB+eqbKiYHQdKcmmkndqRv4uAP9FM/DhsF6PAh2r78NsSa7dSUNONyAiRc8joydy43xLtD+5XZuogEn4t/pHd4aufnq+rt3+JWfLoAFOU6BQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 16 Sep
 2025 09:03:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 09:03:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Richard
 Cochran <richardcochran@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nick Shi
	<nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>, Sven Schnelle
	<svens@linux.ibm.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Thread-Topic: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Thread-Index: AQHcJk7xq9I5RhhGh0aUdPR3eTjQvLSVfaTA
Date: Tue, 16 Sep 2025 09:03:17 +0000
Message-ID:
 <PAXPR04MB851098C0A69B74DD232071B68814A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8193:EE_
x-ms-office365-filtering-correlation-id: 749a8c88-8350-4c17-d6b7-08ddf4ffe032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm1nM0UrMmhRMW95OHEyczJUdERRZEplTU1lQ24yaFpPa3doZmg0b01wU2V2?=
 =?utf-8?B?RnBQWHlQcThESGJSQU4rekVVb3ZnQ094N2piamppRjNacm9zNFhpZFA1SGMy?=
 =?utf-8?B?MHBRSUhQdm41US9IVFZrTW5GaUd5UkE4aXdlMUliTWwyU0UzbU40QjB0aUNR?=
 =?utf-8?B?V2d5UTM3d1NKRDd2WFpMT1h4Q0NVTGVwUzBicStHVXlxdDFLUy83NFd4TkYz?=
 =?utf-8?B?bkR2aUQ0b2JhZmhra0hlMlhVTkhyUTdPRUoyQ3VwMGVrNTRrd1RsdXNpdWNa?=
 =?utf-8?B?UEdrN2UwSURFYXlHdjZ2K3dRTG9POU9RR1NCNG9tRk9rV0lnazRDM2VyWVVZ?=
 =?utf-8?B?dHhrOGZ2dkZQbW9wUng0TksvRVlTd0tneVhRNmJ1bEFOdm1xY3BWbTlveDlm?=
 =?utf-8?B?WWNkbEhZRXhRVFFNOTRFd2g4WFlud2pqTmlsa3ZVTndPOGM0ejN5UVpyQkI1?=
 =?utf-8?B?ZkRGeXdSelBkbEp6a0R3V1BKT21PNlhOUGY5dVQ5VWVTcEcvdDBnb1RjYm1p?=
 =?utf-8?B?VGxKOGJzb2NGNlFmOFIzYzNEdlU1eit5NTdCbHRkR1NTQXVkTmtwaEpPMUN6?=
 =?utf-8?B?N1drbWVLWkNnVkxYWWlkVU51eGpoMjg0SGdCZlJsSURZNndxei9teGZTcjRU?=
 =?utf-8?B?cXlDbTdWd3V6NmNuSUs1ZWNWeTFwMUdPRnExYWF6Y2tqZjJGNkc0ekx5OTkw?=
 =?utf-8?B?QmExa3dJdDF2UjJPSmlJVVUwV2UxUmorWjhucWhkdjVRU1NVcmc5UTNWTE9u?=
 =?utf-8?B?cVc5eHZQZ21HNmZ6dHJnclh6WmIzVnhZaEg0RFhPYStSbnNEWUp2ZVo4QXZo?=
 =?utf-8?B?NlI2VDVnZks2YmZ2UVplN0VWdEVlQjRBMys4WlBKMGdoeVdQUlRNQ1FyUnFl?=
 =?utf-8?B?dnN4RmxnU1NEdW95TTFlbkY2VXcyQlp2MERuclhLV1lPcmtyRkZtM01iQU5Q?=
 =?utf-8?B?bXBINm03WUdoZXc0OURPSVNmN2FyRHgreFBrTCtyNnNFUzNzQkwxSlpPclB4?=
 =?utf-8?B?TUlhQ3dMcDFVaFdWOXU5U1ZCZzVWNHd3K0dCNkR3ZDZhMGVqVWU3OHArRXFm?=
 =?utf-8?B?SGZIOW5TTTdDc3lOYUNTSlhVZkgyRksrSXlGZHIvc21ZaVVkT3dFMzRhbWM5?=
 =?utf-8?B?Q3l1RE1xR3FtbG5BYmFQdlRHdGdIUll4QVdoY2dibml4Mm1tMVNyS0R5bHJQ?=
 =?utf-8?B?cm5iN1NJYVA4c2VqL0RZRys3cHFSTmZZZExXNjlQMExYSmVrSEk2bFRlUzBD?=
 =?utf-8?B?S0pQT3hOQW5pUGRTVVEvaUxxRjdDYmFpZlRRMTdOMEJ5czRqUnZ3V2dJV1NI?=
 =?utf-8?B?Nlk2LzU4SU5ITVVRaWxDdkROUFRaNGo3cFREbnVyUGppMGpjSjRuK3d4cmlp?=
 =?utf-8?B?OGRZNGZIalg1NnhZcjJVVzRJMXppYS9SbWlxTWFoZXhyVVdBdzV4b2plRUh1?=
 =?utf-8?B?b0JmVWVBM2d0dEZua1l6SjBQK0VSY3dlempPK1FTTDMyNmpsTGtiMXhFbU9z?=
 =?utf-8?B?aUc1NmczRk90dEdlRXE2L1FzdTVBVXZkL012d1MrWUpKcWYyYkxWZWFwWjM0?=
 =?utf-8?B?UUVLaEdDdXBUMWdYZFEyN2FzaGt2dklYODVRajJYZTkxM2JSV0gxV3dwSTc5?=
 =?utf-8?B?MnZqSm1RVG1jcS96VFFPVlJkUEtJS2FwWUZFdlhINEFzQ0x4NDdGbEVpM0RN?=
 =?utf-8?B?dXU0ZE1pamUyOTRTZ28zZTluTUQzZkh6V1lyWlBtQVpJVDNCemN6RVF1TkhZ?=
 =?utf-8?B?U2tKTUtCS0hHSHlySW8yNFhRTW1WOUNBc2NYa3pDQWFHQTRmNzFxREVyY1U1?=
 =?utf-8?B?WlVXVGkxdUc0NGs2eVY2SU5lOGZBUU9kd0VEWFV3SGZTME1VZktkUWViWnFy?=
 =?utf-8?B?K1JTVjNudWRiQ0lQSGluVWNMS1BwdTBwRGNoN0N0UVZ5Wlh1NUFTYmxib2c2?=
 =?utf-8?B?dGdZVHF1eUplOEJrT1MzS1VFT3ROdG5vSTRMT3FzdzNaWDBleWxEakZmYmFQ?=
 =?utf-8?B?Uml4RGpFcUhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVJJd0FZelc2LzhOdkt5aFNvcHVvZGhmRGMyd0d1T0hvUWtOWVhRdlhrT0ZH?=
 =?utf-8?B?NVVXTGhERTRwaDZkNkZOKzZYdzIvYURFWHM4cEVScnFKbFpaSzh0WjBmV21Y?=
 =?utf-8?B?YnJDcXkrN283U2JrZ2lMY2d5RUN5R20vUzYzRjBmbjVkL1ZwNWRFOE1DbTNu?=
 =?utf-8?B?dUFWSmlrZkRHZnVMU25LRGFLZXBYM2xVcnhzbTlyZjUyZEludFRXdHRzczdn?=
 =?utf-8?B?RnpGcmM0MElhd2h5WmhhYnJSZ0xFbnZZdXdnUkgyS1lEY21GMU1YRGFGekp2?=
 =?utf-8?B?Rk9RdmpCTVhTOEZneEJ4b2tYaFVFWXYxQjAvYVoyaXh0clIrOHFjK2JWNnhK?=
 =?utf-8?B?bDZ0K0NoSXdDbFRMeEE5azZDelhpdG9JVDMzYzdVNGxYRFBVSEdhRnJyTVA1?=
 =?utf-8?B?UnFraDB1S2htRlI1THRLQyt2QTB2YkdRODRiWUw3OXpKS3hMNEJrOTY5bUJI?=
 =?utf-8?B?T2wwdVBOS3c5L0p4alh5d1F1ZUh4Tk5WTWZNWjVSMm1seXliSm5McTdhYkFZ?=
 =?utf-8?B?SXFIUlZBTGJyZVRyZzNQTEhuWkNGdzFSSHZUWlJNMmJ4d3RUcmQzWkFjREpZ?=
 =?utf-8?B?a2hjaldGclRFaU5CUFE3SmVqeGRnTjN1aXBDdjFNZEZhNzV2WE9BcEwrV200?=
 =?utf-8?B?UTd2RWd3dldwNHhDTnhNbXMxSWlLdi9iZlVtQ1A5Y2pIZzQwcTZrTFlWemhX?=
 =?utf-8?B?VVE4ZVZpZGZxV3JlaWNUNzJOemkyejhPeXJ0WWhVM1NqTndMZnQxd2tXbWZO?=
 =?utf-8?B?YUZoZi9ZSVoxTWt1Z0ZJWGlYRk1DdVE1Qm1URmpidnNodE0vUlNZdlJ6cU5p?=
 =?utf-8?B?bGhDTldrK3ozNk42bW10clYxWGtmQlMxTlFEN1hNL0xFYTl6UWFOY0dlRU9V?=
 =?utf-8?B?UlBJdDExT0xWSCtBd244UDZWczRnVVQraDB1czlUNGNWdzk2SDJMTFEyZHZa?=
 =?utf-8?B?OTJtTG5sZ29KTXJKNXJ4R1NTem5td3NaZ3l5ZjBCdGt3Y1dlWWVWZ0NiYVNP?=
 =?utf-8?B?UHV0eXAwWXBHdTdPUlRqSm1sZDVGdWIra0Zpa3lscGpRR2xRZjlCWGNWVkNO?=
 =?utf-8?B?UzBxMTRhaVNEc2lMYkZLcGw0YUpqSUVaY04yWk9CUEFtRk9pMkRzMXQ0aGl5?=
 =?utf-8?B?bjdlcENYNnBEZ1BMTTg1L05DcUt1Q3p4K2djYld6ZnVjY3p5QXpSczRIalU2?=
 =?utf-8?B?VVpTZ2c4ak5OZmpyVjczQWtUeHlsQXBMS1RvUnIwT3REUVNndU9vOWJuOXFi?=
 =?utf-8?B?SWJFZ0RjamdYNmhBOTM0NVdBWXJNbDluaGh1MThYZlRGUkNYN2grSXBXQ3VG?=
 =?utf-8?B?WTlLMEZwc1JMcmo3QnNma2JZMHprUTUrRDlUS25FYUFPWmRwRGxrNHFOaEpk?=
 =?utf-8?B?RkZJcHZxZEtVQi96WHJrY2lYS2Uya0owelFzUFViWE1LMHpOT05SK3dBaG8r?=
 =?utf-8?B?RWRRSXk1VlduVklyMUE2dE9CVkMvN2FNOUdhWitvK0lScWxzdWxLNXJoNXdx?=
 =?utf-8?B?Uko3NjhldUszaUk0UkpJQUVmMzJmL0lUd3g3czREVjM2aXlTcHljUTBOdDAx?=
 =?utf-8?B?dVg4V0cveXd1RFZHREdRKzRmTGQ1VlZmSjh5SG5KcUxSalRNaktKOTNpZFda?=
 =?utf-8?B?S0pCQnhQRlNiamNEVU1tV1NURm14Z3BZQUlRSnh2R01BOHcwMHcwWHBTSkRL?=
 =?utf-8?B?dCs2SzY5dUhraWltZE8vZDhhUVBtODhHSHA1WldNTTBGMENlWkdaZ0JDUS9t?=
 =?utf-8?B?Mi9nb1J4ZFcveE1reXBQWjZoOS8xbit2NW1TNnVWalNieGVjQm80dGN2T3BL?=
 =?utf-8?B?T0FndG1XQWRtSmdGRHJ3cjgwQk4vN1JITnVOYTRxN2FWRWFHMEhpaE02cWRO?=
 =?utf-8?B?bDlBQWpRVjBhUGVuZ1U1UTRuQVVTUE1taXVUM004WmFvY0FMdXZISjNYQ1pQ?=
 =?utf-8?B?Q2xWMXVmRTRPQlZWM2lUOExmVU1aTU9mQjZycFlXazVUNmNWMHQzVElwMnlC?=
 =?utf-8?B?VjdLV2dJSWc0VDBFV1czUlloZ2kzRHo2SGx1cE9pa0IyYW5MV3pjRDBKOXRk?=
 =?utf-8?B?QWVYWlNKdDRJUGZncjJPdXRHYVFhKzZGcHFIVlN1Sitmak1ydWVNbXY2Kzlr?=
 =?utf-8?Q?E7hA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 749a8c88-8350-4c17-d6b7-08ddf4ffe032
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 09:03:17.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yld9AZJOzbARNLyhjEu+MxOscb2wsYN43bqINf+dAHt7WuUW+pFY/6aoSK473MPeAYLmLL9xAptbEhoVSRF0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193

PiB0aGUgb3JkZXJpbmcgb2YgcHRwX2Nsb2NrX3VucmVnaXN0ZXIoKSBpcyBub3QgaWRlYWwsIGFz
IHRoZSBjaGFyZGV2DQogXg0KTml0OiBVcHBlcmNhc2UsICd0JyAtPiAnVCcNCg0KPiArdm9pZCBw
dHBfZGlzYWJsZV9hbGxfcGlucyhzdHJ1Y3QgcHRwX2Nsb2NrICpwdHApDQo+ICt7DQo+ICsJc3Ry
dWN0IHB0cF9jbG9ja19pbmZvICppbmZvID0gcHRwLT5pbmZvOw0KPiArCXVuc2lnbmVkIGludCBp
Ow0KPiArDQo+ICsJbXV0ZXhfbG9jaygmcHRwLT5waW5jZmdfbXV4KTsNCg0KQ3VycmVudGx5IHB0
cF9jaGFyZGV2LmMgaGFzIGJlZW4gY29udmVydGVkIHRvIHVzZSB0aGUgYXV0by1jbGVhbnVwDQpB
UEkgKHNjb3BlZF9jb25kX2d1YXJkKCkpLCBzbyBzY29wZWRfZ3VhcmQoKSBjYW4gYmUgdXNlZCBo
ZXJlLg0KDQo+ICsJZm9yIChpID0gMDsgaSA8IGluZm8tPm5fcGluczsgaSsrKQ0KPiArCQlpZiAo
aW5mby0+cGluX2NvbmZpZ1tpXS5mdW5jICE9IFBUUF9QRl9OT05FKQ0KDQpJdCBzZWVtcyB1bm5l
Y2Vzc2FyeSB0byBjaGVjayB0aGlzLCBzaW5jZSBwdHBfZGlzYWJsZV9waW5mdW5jKCkgZG9lcw0K
bm90aGluZyBmb3IgUFRQX1BGX05PTkUsIGJ1dCBvZiBjb3Vyc2UgdGhlIGNoZWNrIGNhbiBhdm9p
ZCBtZWFuaW5nbGVzcw0KZnVuY3Rpb24gY2FsbHMuIEl0IGlzIHVwIHRvIHlvdSB0byBrZWVwIGl0
IG9yIG5vdC4NCg0KPiArCQkJcHRwX2Rpc2FibGVfcGluZnVuYyhpbmZvLCBpbmZvLT5waW5fY29u
ZmlnW2ldLmZ1bmMsDQo+ICsJCQkJCSAgICBpbmZvLT5waW5fY29uZmlnW2ldLmNoYW4pOw0KPiAr
CW11dGV4X3VubG9jaygmcHRwLT5waW5jZmdfbXV4KTsNCg0K

