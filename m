Return-Path: <netdev+bounces-150554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A899E9EAA05
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BB1280575
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA217BB2E;
	Tue, 10 Dec 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E31XszqS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B94C81;
	Tue, 10 Dec 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816967; cv=fail; b=lc7LQLghbuwGVu0/7u3OF/AWoPI0aLxPV5p9/5wacjRA05101k3ACdGdymGhn/0smLzWyi8Z9d18NmhzFiQ10JTo6ReUAjcrxqxmycIQ7BXrhSoxu+DorxaP+sLDVAwi+rkwm47N0Nat+kuLF4Bcc0pvDcxAwKDZDjdQYr2MD1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816967; c=relaxed/simple;
	bh=Abv3Q/mEO0p4kgy3TJADAz8M/mZ8TuRcTWVVL38DmW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KS0ve6KtMtWx77mzjv7t6tCvxRJLDn31tzroe2lAetmFlKSVeZ1WXER9QdHOcABU5cnz15wGWQi1AhA7j5VX/l67E8YTmvwuG4iQcKNFcIcS6Xjv1xYb+Fm6Wcu9WgHreWh8QvLiXnJNT4WPKvXAXOPQfHkx+0JeYkQlt9l87p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E31XszqS; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a55Kua38V3qHFJiTKJ4H0n22jbqW+EmpKM6KJQI6Bl1JE1CZlqVEySMDq3re9byd6B2vA/nxIxWGZr0CY6KQX+uNytZsOM4esnEcgLU5+N5m96g0E3Hlpm89RFoyVVjhtA6JCj01s7kkv9sX53CuamF9iTOmUOUrRFSTLhNELt0UJcVEwZZw3+qlxzisBXv/AdcLIV/X0zy9qkfkesCN12AH39r5tVSgdY1OgSPM3oSOobhIjnMqNbLDpqle7ibDxaBz5TaK07A/onWqmnTIO3/bKNlybhEcaj2JxbCOEnJFjs6fgKyeQ5XUPEnLyNuoaPyp4QIsqCsbb2BI3Grn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abv3Q/mEO0p4kgy3TJADAz8M/mZ8TuRcTWVVL38DmW8=;
 b=xhQ/TehPmiRNhzzyCYFvK869yMCRl93n2igGK5FltyGtAW72Xu7YG8bxc1HVR20aoHT5SWV5znUmfaB1ok2zlxwV7ufrw6ctoQgQw3rz0JdxXPWYratD7tmgqgO5hjbKkntpHumEHclhHOZg/r7auVt6Q5AJp0eZIrCQrC5gaQVGWsosPRixXaUpod9c0ZlHaIScmDF5oC0HPfNRsXeEWv4toGmm9KyPjnccWrC0ndjKMx/mvHlyNm4DeSlb1DoDtmToliUNng0moQxYpEBZ30eEcK7L54YvdYR79B2SyIPDmm3apY8gAyF9h19l6nB85SN/wT6DzygFGUbPvYFWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abv3Q/mEO0p4kgy3TJADAz8M/mZ8TuRcTWVVL38DmW8=;
 b=E31XszqS1mt0KdoUIS4MdUEOHoc0+MJN48SPL2yPoV7I5EXn5Ami8DbvRVwpB61r7A5bTnJevraJFLah7QdLoj3a6B8uBZPhYmsVpfNz9iBq3WUoki9b7Q1uIA8pFGj8NFiq48Zul0AF2dbvujLhT1ft/Hiy4ETo2YmupxkuwkSc1ut6QqLMboADjtl6P8NDim2/qxZ/OeOcxPCHkMhcwyyt41c3yqJ0ClJdX5IIMFFZRL/fXjp6mU/PmIMpQEqx1Mjp25nqsvN/xFw/wKpHzuhHWi3O0quDWM1K828dulxa1JmmFysQHl7xOSJdDOjhpeqV1Ot8ituq4djiIXxCCQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 07:49:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 07:49:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Ido Schimmel <idosch@idosch.org>, "tom@herbertland.com"
	<tom@herbertland.com>
CC: Simon Horman <horms@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Topic: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Index:
 AQHbRg+5C4mdptfiA06bM4c11AC4ErLY9OWAgAAMdbCAACfMAIAAAliggANZW4CAAp3McA==
Date: Tue, 10 Dec 2024 07:49:18 +0000
Message-ID:
 <PAXPR04MB85101F4E12086B8E0A471580883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com> <20241206092329.GH2581@kernel.org>
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123030.GM2581@kernel.org>
 <PAXPR04MB85107FD857F1AB33BBE4F70988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Z1W_kSMUp3lsLPr_@shredder>
In-Reply-To: <Z1W_kSMUp3lsLPr_@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9254:EE_
x-ms-office365-filtering-correlation-id: 7f8b2df3-8307-44a2-a223-08dd18ef271c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cDEzSkw5bmFvOUc5QzhXKzBlUmVIa2JmWVB4TmtjTEVRbnJEalVMRVl5TXd3?=
 =?gb2312?B?M00wU1JRWThKMGk3c29yL00yR25kaStmT3MzYXVET3ovS25VMFF6bkxtSEU2?=
 =?gb2312?B?a2xqYlM3RW1ZVmQrek9ZajVsR0hzYzUwYUlXZ3NMSE4zeTFPMVg4QkR6dGxN?=
 =?gb2312?B?ZHM0UnJXNzRpR3ROZ2tnajN0T2tRZGZSVnZvYVRLd282cUlMRVhIeG5ERnVp?=
 =?gb2312?B?K2RZK2ZFUXZORG8ycWlyM0l2bmFRVVVxL3h2aVp5T0Uwd1U5M2pPMWM3dWZa?=
 =?gb2312?B?SlNoWDlxTm43ZmozSjJnckhZVDlkK2tPOGwvNldFWDhCZ1NNYWtrV0hWOFVn?=
 =?gb2312?B?STc2Q2dDQjl1MGhMbU5EUFRWL2N6THN0QmdZb3hYdWpsZ24rR1JpNnNjNVg0?=
 =?gb2312?B?OHBvZENvcFo3VEwydnQ4amQ1Zm9QT2pDRk0rbFhlZGJmeHRJVStrajhhdGlt?=
 =?gb2312?B?a3V4MXVKNXl0TFo5RGNlZWFkT0dyM1hiUEJWVzBQS01mRGhEOTk0aGpmZTdD?=
 =?gb2312?B?aXRMSjRubEFrdlh4RHpLRWNXbUNKMXlmR0luQVRtQmwxamx3c1B6ZWpzbGU1?=
 =?gb2312?B?T3JKQThmRGlhM0lIVzVGRXF2b3hNVncrVHNaYW1PRUV4Q3Y1cmF2RkhQSzAy?=
 =?gb2312?B?QjE3ekZ4R0NtNGZwNDd3T0YrdWcveUpLUG1VLzk3VDBiMEtnSE5BMDNmVy9l?=
 =?gb2312?B?VW11RmVyODZiMmNRSlNkem5wVzMyZS9qREk3L01ZNlJxOE9wKzg5TTM3WWJE?=
 =?gb2312?B?czhxc0NIaHhGK2RwbFNHV1krL2RmZnlncUdUZk0yb1RtU3QvZ1lEcitSQXRk?=
 =?gb2312?B?dCs5TWZEbHVqdVJFaldHVjREZW5Lci83RTFPcGo4QmVNUjUwMDZtWHRLZnM1?=
 =?gb2312?B?UzJzTTJEaWh0RU9XVG5IeGMwVUVXRjQyREtFWUhVM3RIMExEV1MwemYrYUhx?=
 =?gb2312?B?RTBkdCtHUkhyaXNUSkNoSzIxTG1VS3ZCVG9WKytwa1pZNGFUaVJtRHA4NFFp?=
 =?gb2312?B?dXRnWnNqQXU5VzV6aktFc2ZnZkJWcVFWWW40YTI4WGtYd1NreSs0cTZWZUxY?=
 =?gb2312?B?eTJ2L1JsRXFXMWZ2amRROFZIQzlQUjJTQlhJUkdBUXBZK0dscWJJVUVjOU9H?=
 =?gb2312?B?RmQ1TzFzTjJJRnJiaGFtK29XQkQ2Skg0QzJ2dUVaSk0vU1FUeWxFUFZUSEcy?=
 =?gb2312?B?Q0pIaDh4UHNaVVNaTW5QcmpqWnFjdVdWWVlGRWViR1Vha2paRG5pTlhlY094?=
 =?gb2312?B?WUNLM2xQcW9CczJ6eW1vaFFROHV1NWtnRC9LeGhxQ1FWMmVTc3ZwSk9EWGpK?=
 =?gb2312?B?ZUppZHRlRHl5cEpDZ21tcStyUFJEQnJNemkvK05FeDVIbXlQR1pra29Xamw0?=
 =?gb2312?B?emdsa2NWWUU3Nm9FSTRGRFh6TjVHUGFwNWlVR3NWODBTMWM5ZytqdTRyYU1p?=
 =?gb2312?B?NjlxM2JDRE43VFpUUEVmUWhueFo5Vlc3Z1ozdGJuRlgzY2VXTTlLdThlMVBN?=
 =?gb2312?B?d1NmSTl4N3FxWDlQdTJ3MEdCcWx4ajNHQXVtTmxLemRBRGNnMzI1VnFvNXZq?=
 =?gb2312?B?bXBQSExmeWMrV3RxN3dVOHhDREh3RFpMdHI4TkUxYUhvL1VnR0lSdi9qbXNV?=
 =?gb2312?B?MUxTL3RkZEM2YzAveUdnWW45RFM1UWZOT0NOemVqRTViMHFXZFVVTGJWc3Vi?=
 =?gb2312?B?SGIwSnVPN2pzY2VNMDVXYTdCVFN0c056T2g5WklQYjNzRXV0M3hCbS9nYUw4?=
 =?gb2312?B?QlVkN3c4ejFMRWlpd2tDcXR0ZkpkY3RmQTF0Z3J0eUZMeHpqb254NlVYWEFs?=
 =?gb2312?B?YW9mQStMZ3FoSVVleUxraVlDVTAyOTNTbEErcnJPNW9NUW5aT2ZuWVdyQjRl?=
 =?gb2312?B?NjIxUnE5b2gzeHRrVkhuVkxkemVCVW8vSnl4Y21mRWR1ZkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TDUxZ0N5azFpQ0JhazA0VnhBQjcxRmY3MElITFo4VXlqUjEyQjVFMjVpcGRm?=
 =?gb2312?B?SVowNXRlVy9hcmdXaGFraTkzbW1xaXpEYmVzbzFVd2xKSzloZjBvbGtpcWky?=
 =?gb2312?B?ZUxLcTBrV2VWK2J0ay9zM1Y5MzBHNzc5N0t4VjNGUUFGUnJTdFA5SXNqcWNH?=
 =?gb2312?B?SUQzU3NYbXNSOWJwbDlycnVBNWFOQ29hemxWL0Q2aEdkdW5pM2pnVHUyVGRn?=
 =?gb2312?B?RGNlL05uT1RVZ3BFZzF1ZlJNOCtCOENjWUltb0JNNk93eWhBdzZhMUg2eGJi?=
 =?gb2312?B?elJmQUJJWFJwSHNTakFzOFI4Rnp4K2JHc3djWUpkU29Kclp4ZmdUYjlEbXNu?=
 =?gb2312?B?ckJ2QmlrMXJUK1hxOEp5K2MzcnJjbHdDNnBuZWVqRXF4YWxraHhXckp3TWRZ?=
 =?gb2312?B?eUQ1d2pmelRJdU9mejFZM3J2Y2hLUGV1OE1VbU9PVnZndjhnWFlrVWVQRnY5?=
 =?gb2312?B?VE1tRWRLeHphVFh5QkhEQ3VzWmlkejIwSWkzWmt2cDRUQ29CUHFtaC9RNm5p?=
 =?gb2312?B?d0JETXRCaVZBTjJOQXpFN2NNeE5pVEJTMW80cFNzTG9FVGEyVnZ0MG4zV0Ir?=
 =?gb2312?B?Z01kM1k4ZUFUaEtRYS9DYUVsQnN6c2JGd1l3VnpHNjl0R3AvQjFoV0x1TVJq?=
 =?gb2312?B?MEJxdGdIV3VvUDB6SUNla1d0a25QN21yS29VS0cvT3B4UElySmVkblEwd3Az?=
 =?gb2312?B?QkEzR2lBaVdmOGZpcXpNWGVpeXNDbmYyYTB3TGltejlCVW94NVJSSjhiSWtH?=
 =?gb2312?B?SVl2L1E2QytGTFBhY0RSRUVsQ3NqamxPM2w4eXFyM3l3WFlXOCtrZFdKTHBz?=
 =?gb2312?B?TWw5dGttZFYreUhUVmptdDNhUWdIZ3FEM1Z0YWVrQmM3eG03VDZSa3pwbDlz?=
 =?gb2312?B?YndhWGhFVFdBUUFVaHRXMFFZSTI4cUhTOTV0Vk9DMy9SVEZLRUJkelJiTEVQ?=
 =?gb2312?B?NjhMVUp6Y1B4R0JLUmFGdkxuZmdaZXVBSVdTTnV0ZWhpeGZwUzJ4YlZGd1E1?=
 =?gb2312?B?aU1WclFkS2JjVm8zVGNDbHJWL3I5NWlhMldCUEgyQzdvamdGcmdMdmlxZW4w?=
 =?gb2312?B?WUMvdHdraVJpMmhmWG8zWFh5em1zVTlDWUoxc1pta3FhN3pBUG9yT00ySjI3?=
 =?gb2312?B?eTEwbEFMZFJ3Z3lvK3pJOTM5T29abnVsUW9HVmtvUmRuSVFJRnpvQitFK2Yv?=
 =?gb2312?B?QzdJUmdxWnlUZDQyYWU2VVoxa25aNzBTb0ZMR0ZzVTN4MnhRK1gxYjMwSFMv?=
 =?gb2312?B?Z2lXSEtwQ0VmOVNXa2hndHI2d3VRUnFrUlZmUnFHckppR1U1VWhHYXhnZ0o1?=
 =?gb2312?B?ZytMeFlsOVpxRTFTbzdjVWQyUytiTU1DMnhhMWhRSHNUaUlMN1c4S291Nmk2?=
 =?gb2312?B?Q1BNNW9obFllN3NsZEdsdTFlQlpxS0dqaEJ3TlpSanFIZVZ2RW90VlRtRTlE?=
 =?gb2312?B?N2FCNm9lbDIzbWdIdXZoYVU3YXdtQkU0Q0I5dkFPWFZkd1ZqTVVFOTBMNXk2?=
 =?gb2312?B?d0R2M1JBU1p6LzdmUkc0Q00zbVA5VytyU1lYWXZXcVY3QVFtR2E4ZEJKWXlt?=
 =?gb2312?B?UnJCMlhkai9MbitMRWZCdXdjTjNycHVXRVl4R2pmS2lFSGFCajV1MWIxVk9s?=
 =?gb2312?B?Z2lOZmpNZWRPZm1aMStrZnJKRngzNnl1SlhZbHN2MVpWZlFOQzVYWS9lM3dz?=
 =?gb2312?B?YXloMnZqTDJMNUVIRW0xQ2xSc2pVWkpXdEZ5UmxESGF0QUpiblBVcnhOZWxG?=
 =?gb2312?B?UmlJejdIaHhRc0lheXdMWDgyT1BSZW0wOFlIaUV4anZPU0ZmaFlUSGdKMmM5?=
 =?gb2312?B?Vm1Xd1lVdVZ5YkYzaDZVaDUvZzVoa0xGTkIyL2xBZ0oxbXQwMVExYjNlaWF3?=
 =?gb2312?B?cHYwN3B1andRRExiNW1vMG5Xb3JUMmt1cnNSaXpZcW5VU0pSTkFaMUVJeU9P?=
 =?gb2312?B?SDJDOUFCTmdoQm5nSmFKMXhOWldtWk4yREVSbGMrWkVuY09DN0NCRzBnamtl?=
 =?gb2312?B?N1BJL2VIbVJDanZGdGlrejVZQ2NQeTQyWmJoWmo1VlowWC8rd1ZxUTFCUXlK?=
 =?gb2312?B?U2ZaRGc0TnZ4dUhWQXlNYUpWeEJ5TFZ5b1RpczE1eCt4STYzY2ZPcytJZnA0?=
 =?gb2312?Q?sH5g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b2df3-8307-44a2-a223-08dd18ef271c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:49:18.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +l5iw7Nmi2dOr+G3g5EHXefLdBjq5h7U2GUUNI59mLx1Z/JOPnq4IGrnEdEJFxvLuvIhdRQ2p7gQGiQH/gtSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9254

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZG8gU2NoaW1tZWwgPGlkb3Nj
aEBpZG9zY2gub3JnPg0KPiBTZW50OiAyMDI0xOoxMtTCOMjVIDIzOjQ3DQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT47IHRvbUBoZXJiZXJ0bGFuZC5jb20NCj4gQ2M6IFNpbW9uIEhv
cm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IENsYXVkaXUgTWFub2lsDQo+IDxjbGF1ZGl1Lm1hbm9p
bEBueHAuY29tPjsgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENs
YXJrDQo+IFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5j
aDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJu
ZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgUkVTRU5EIG5l
dC1uZXh0IDEvNV0gbmV0OiBlbmV0YzogYWRkIFJ4IGNoZWNrc3VtDQo+IG9mZmxvYWQgZm9yIGku
TVg5NSBFTkVUQw0KPiANCj4gT24gRnJpLCBEZWMgMDYsIDIwMjQgYXQgMTI6NDU6MDJQTSArMDAw
MCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogMjAy
NMTqMTLUwjbI1SAyMDozMQ0KPiA+ID4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiA+ID4gQ2M6IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgVmxhZGlt
aXIgT2x0ZWFuDQo+ID4gPiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGFyayBXYW5nIDx4
aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiA+ID4gYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZl
bUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiA+ID4ga3ViYUBrZXJuZWwu
b3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiA+
ID4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
aW14QGxpc3RzLmxpbnV4LmRldg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiBSRVNFTkQg
bmV0LW5leHQgMS81XSBuZXQ6IGVuZXRjOiBhZGQgUnggY2hlY2tzdW0NCj4gPiA+IG9mZmxvYWQg
Zm9yIGkuTVg5NSBFTkVUQw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgRGVjIDA2LCAyMDI0IGF0IDEw
OjMzOjE1QU0gKzAwMDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwu
b3JnPg0KPiA+ID4gPiA+IFNlbnQ6IDIwMjTE6jEy1MI2yNUgMTc6MjMNCj4gPiA+ID4gPiBUbzog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiA+ID4gQ2M6IENsYXVkaXUgTWFub2ls
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgVmxhZGltaXIgT2x0ZWFuDQo+ID4gPiA+ID4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gPiA+ID4gPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
DQo+IGVkdW1hemV0QGdvb2dsZS5jb207DQo+ID4gPiA+ID4ga3ViYUBrZXJuZWwub3JnOyBwYWJl
bmlAcmVkaGF0LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiA+ID4gPiA+IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlt
eEBsaXN0cy5saW51eC5kZXYNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IFJFU0VO
RCBuZXQtbmV4dCAxLzVdIG5ldDogZW5ldGM6IGFkZCBSeA0KPiBjaGVja3N1bQ0KPiA+ID4gPiA+
IG9mZmxvYWQgZm9yIGkuTVg5NSBFTkVUQw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBE
ZWMgMDQsIDIwMjQgYXQgMDE6Mjk6MjhQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gPiA+
ID4gPiBFTkVUQyByZXYgNC4xIHN1cHBvcnRzIFRDUCBhbmQgVURQIGNoZWNrc3VtIG9mZmxvYWQg
Zm9yIHJlY2VpdmUsIHRoZQ0KPiBiaXQNCj4gPiA+ID4gPiA+IDEwOCBvZiB0aGUgUnggQkQgd2ls
bCBiZSBzZXQgaWYgdGhlIFRDUC9VRFAgY2hlY2tzdW0gaXMgY29ycmVjdC4gU2luY2UNCj4gPiA+
ID4gPiA+IHRoaXMgY2FwYWJpbGl0eSBpcyBub3QgZGVmaW5lZCBpbiByZWdpc3RlciwgdGhlIHJ4
X2NzdW0gYml0IGlzIGFkZGVkIHRvDQo+ID4gPiA+ID4gPiBzdHJ1Y3QgZW5ldGNfZHJ2ZGF0YSB0
byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSBkZXZpY2Ugc3VwcG9ydHMgUngNCj4gPiA+IGNoZWNrc3Vt
DQo+ID4gPiA+ID4gPiBvZmZsb2FkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+ID4gPiA+ID4gUmV2aWV3ZWQt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6
IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiB2Mjogbm8gY2hhbmdlcw0KPiA+ID4gPiA+ID4gdjM6IG5vIGNoYW5nZXMN
Cj4gPiA+ID4gPiA+IHY0OiBubyBjaGFuZ2VzDQo+ID4gPiA+ID4gPiB2NTogbm8gY2hhbmdlcw0K
PiA+ID4gPiA+ID4gdjY6IG5vIGNoYW5nZXMNCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jICAgICAgIHwgMTQN
Cj4gPiA+ICsrKysrKysrKystLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmggICAgICAgfCAgMiArKw0KPiA+ID4gPiA+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19ody5oICAgIHwgIDIgKysNCj4g
PiA+ID4gPiA+ICAuLi4vbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZl9jb21t
b24uYyB8ICAzICsrKw0KPiA+ID4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiA+ID4g
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gPiA+
ID4gPiBpbmRleCAzNTYzNGM1MTZlMjYuLjMxMzdiNmVlNjJkMyAxMDA2NDQNCj4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4g
PiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMu
Yw0KPiA+ID4gPiA+ID4gQEAgLTEwMTEsMTAgKzEwMTEsMTUgQEAgc3RhdGljIHZvaWQgZW5ldGNf
Z2V0X29mZmxvYWRzKHN0cnVjdA0KPiA+ID4gZW5ldGNfYmRyDQo+ID4gPiA+ID4gKnJ4X3Jpbmcs
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIAkvKiBUT0RPOiBoYXNoaW5nICovDQo+ID4gPiA+
ID4gPiAgCWlmIChyeF9yaW5nLT5uZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfUlhDU1VNKSB7DQo+
ID4gPiA+ID4gPiAtCQl1MTYgaW5ldF9jc3VtID0gbGUxNl90b19jcHUocnhiZC0+ci5pbmV0X2Nz
dW0pOw0KPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4gLQkJc2tiLT5jc3VtID0gY3N1bV91bmZv
bGQoKF9fZm9yY2UNCj4gPiA+IF9fc3VtMTYpfmh0b25zKGluZXRfY3N1bSkpOw0KPiA+ID4gPiA+
ID4gLQkJc2tiLT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9DT01QTEVURTsNCj4gPiA+ID4gPiA+ICsJ
CWlmIChwcml2LT5hY3RpdmVfb2ZmbG9hZHMgJiBFTkVUQ19GX1JYQ1NVTSAmJg0KPiA+ID4gPiA+
ID4gKwkJICAgIGxlMTZfdG9fY3B1KHJ4YmQtPnIuZmxhZ3MpICYNCj4gPiA+IEVORVRDX1JYQkRf
RkxBR19MNF9DU1VNX09LKQ0KPiA+ID4gPiA+IHsNCj4gPiA+ID4gPiA+ICsJCQlza2ItPmlwX3N1
bW1lZCA9IENIRUNLU1VNX1VOTkVDRVNTQVJZOw0KPiA+ID4gPiA+ID4gKwkJfSBlbHNlIHsNCj4g
PiA+ID4gPiA+ICsJCQl1MTYgaW5ldF9jc3VtID0gbGUxNl90b19jcHUocnhiZC0+ci5pbmV0X2Nz
dW0pOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwkJCXNrYi0+Y3N1bSA9IGNzdW1fdW5m
b2xkKChfX2ZvcmNlDQo+ID4gPiBfX3N1bTE2KX5odG9ucyhpbmV0X2NzdW0pKTsNCj4gPiA+ID4g
PiA+ICsJCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX0NPTVBMRVRFOw0KPiA+ID4gPiA+ID4g
KwkJfQ0KPiA+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIaSBXZWksDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBJIGFtIHdvbmRlcmluZyBhYm91dCB0aGUgcmVsYXRpb25zaGlwIGJl
dHdlZW4gdGhlIGFib3ZlIGFuZA0KPiA+ID4gPiA+IGhhcmR3YXJlIHN1cHBvcnQgZm9yIENIRUNL
U1VNX0NPTVBMRVRFLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUHJpb3IgdG8gdGhpcyBwYXRjaCBD
SEVDS1NVTV9DT01QTEVURSB3YXMgYWx3YXlzIHVzZWQsIHdoaWNoIHNlZW1zDQo+ID4gPiA+ID4g
ZGVzaXJhYmxlLiBCdXQgd2l0aCB0aGlzIHBhdGNoLCBDSEVDS1NVTV9VTk5FQ0VTU0FSWSBpcyBj
b25kaXRpb25hbGx5DQo+ID4gPiB1c2VkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSWYgdGhvc2Ug
Y2FzZXMgZG9uJ3Qgd29yayB3aXRoIENIRUNLU1VNX0NPTVBMRVRFIHRoZW4gaXMgdGhpcyBhDQo+
ID4gPiBidWctZml4Pw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT3IsIGFsdGVybmF0aXZlbHksIGlm
IHRob3NlIGNhc2VzIGRvIHdvcmsgd2l0aCBDSEVDS1NVTV9DT01QTEVURSwNCj4gdGhlbg0KPiA+
ID4gPiA+IEknbSB1bnN1cmUgd2h5IHRoaXMgY2hhbmdlIGlzIG5lY2Vzc2FyeSBvciBkZXNpcmFi
bGUuIEl0J3MgbXkNCj4gdW5kZXJzdGFuZGluZw0KPiA+ID4gPiA+IHRoYXQgZnJvbSB0aGUgS2Vy
bmVsJ3MgcGVyc3BlY3RpdmUgQ0hFQ0tTVU1fQ09NUExFVEUgaXMgcHJlZmVyYWJsZQ0KPiB0bw0K
PiA+ID4gPiA+IENIRUNLU1VNX1VOTkVDRVNTQVJZLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLi4u
DQo+ID4gPiA+DQo+ID4gPiA+IFJ4IGNoZWNrc3VtIG9mZmxvYWQgaXMgYSBuZXcgZmVhdHVyZSBv
ZiBFTkVUQyB2NC4gV2Ugd291bGQgbGlrZSB0byBleHBsb2l0DQo+ID4gPiB0aGlzDQo+ID4gPiA+
IGNhcGFiaWxpdHkgb2YgdGhlIGhhcmR3YXJlIHRvIHNhdmUgQ1BVIGN5Y2xlcyBpbiBjYWxjdWxh
dGluZyBhbmQgdmVyaWZ5aW5nDQo+ID4gPiBjaGVja3N1bS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4g
PiBVbmRlcnN0b29kLCBidXQgQ0hFQ0tTVU1fVU5ORUNFU1NBUlkgaXMgdXN1YWxseSB0aGUgcHJl
ZmVycmVkIG9wdGlvbg0KPiBhcw0KPiA+ID4gaXQNCj4gPiA+IGlzIG1vcmUgZmxleGlibGUsIGUu
Zy4gYWxsb3dpbmcgbG93LWNvc3QgY2FsY3VsYXRpb24gb2YgaW5uZXIgY2hlY2tzdW1zDQo+ID4g
PiBpbiB0aGUgcHJlc2VuY2Ugb2YgZW5jYXBzdWxhdGlvbi4NCj4gPg0KPiA+IEkgdGhpbmsgeW91
IG1lYW4gJ0NIRUNLU1VNX0NPTVBMRVRFJyBpcyB0aGUgcHJlZmVycmVkIG9wdGlvbi4gQnV0IHRo
ZXJlIGlzDQo+IG5vDQo+ID4gc3Ryb25nIHJlYXNvbiBhZ2FpbnN0IHVzaW5nIENIRUNLU1VNX1VO
TkVDRVNTQVJZLiBTbyBJIGhvcGUgdG8ga2VlcCB0aGlzDQo+IHBhdGNoLg0KPiANCj4gSSB3YXMg
YWxzbyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IENIRUNLU1VNX0NPTVBMRVRFIGlzIG1vcmUg
ZGVzaXJhYmxlDQo+IHRoYW4gQ0hFQ0tTVU1fVU5ORUNFU1NBUlkuIE1heWJlIFRvbSBjYW4gaGVs
cC4NCg0KRnJvbSB0aGUga2VybmVsIGRvYyBbMV0gaXQgc2hvdWxkIGJlIG5lY2Vzc2FyeSB0byB1
c2UgQ0hFQ0tTVU1fQ09NUExFVEUgaW4NCmVuZXRjIGRyaXZlciwgYmVjYXVzZSBFTkVUQ3Y0IG9u
bHkgc3VwcG9ydHMgVURQL1RDUCBjaGVja3N1bSBvZmZsb2FkLiBTbyBJIHdpbGwNCmRyb3AgdGhp
cyBwYXRjaCBmcm9tIHRoZSBwYXRjaCBzZXQuIHRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vZG9jcy5r
ZXJuZWwub3JnL25ldHdvcmtpbmcvc2tidWZmLmh0bWwjOn46dGV4dD1FdmVuJTIwaWYlMjBkZXZp
Y2UlMjBzdXBwb3J0cyUyMG9ubHklMjBzb21lJTIwcHJvdG9jb2xzJTJDJTIwYnV0JTIwaXMlMjBh
YmxlJTIwdG8lMjBwcm9kdWNlJTIwc2tiJTJEJTNFY3N1bSUyQyUyMGl0JTIwTVVTVCUyMHVzZSUy
MENIRUNLU1VNX0NPTVBMRVRFJTJDJTIwbm90JTIwQ0hFQ0tTVU1fVU5ORUNFU1NBUlkuDQo=

