Return-Path: <netdev+bounces-143927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A39C4BF9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D44B29065
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28985206050;
	Tue, 12 Nov 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b92ViMn8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60510204F75;
	Tue, 12 Nov 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375065; cv=fail; b=DikyyQYSj47PZB0W7kGi8KxaGuvjWiiXUMJ9ntpBJLz0p/j1olmSiaI5C9Q43m8814PpN+yFri7+DzmGaqIPx7sE3TpiNnqGAMY/vXz+u6ZP+CrmfiHsnoBpdk/SGBfFwRk2wkahTkzeyAj5acZ6OLaiNFbpiMeoL9COL7DVyec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375065; c=relaxed/simple;
	bh=GZGE4WqX0esIDcr2fuNuyxPRnI2FaqArx2M7jm2yIYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qcvdGjG65qdBYqlvi9g1arNWKkW12mcHm1ZlAMiY/b8zDqSOQN71V1VKJC91M0pveydUeuFScOXU0STKBWMC4KI9gzeFu+pcOiyfro3dcInNd8+RxuO6AkkUxE9VuBRcTTX96qphaMsvmVNlfhgQShrnKqJ5eYR58j8mt9lSCso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b92ViMn8; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/AoBmNb3WnxaknIUa3/dZvPSO5fXGKf2KltvZkw85cmdrDAaauBYrN61MfZSoJh9dmYhldd+9Na+c/Y6F7AQ21AYrfkIRSZIDKVthREz1QnTjr0Ap251OiWui3ultbVF7M0ki2x/lJALXQiUQ75EnETyRArJgrOz4Y7c1zOWE7ZaSX+nk+noqD83VFkxxrJh3ZgQesRp/LGDVBZh30FpiVCU7xcJ4O+X0qa2gfBMmt/e7TApcoQCa3Vdfbz7bwpTA3sa0UpkuCBTetQoSFfuyHahFa3UIhi159GGN+4d9JeR4PUqfs8eKq1adPffi5VMEs9QZGDIiJiREq4PgSACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZGE4WqX0esIDcr2fuNuyxPRnI2FaqArx2M7jm2yIYo=;
 b=WldxB/Q5uI6bucN2hb5weZi87nX0PX6EejzukYa76h1eBcGRJkGfqVaCHdBWnK8h6oovPAZ/ZPN36GhqlQ0+SlzMLE6oBFcDMdDl1eovhbc2H+Lu66RotGyY8z9Dia2zh8yAaEvIGENmCT1ff6Kd89rNLwFLAy8fxSPuo0eZEGf/finPoNw/5yYRJMIThh8bIVPyvWDyHu3I9ab/PY4vq0/0f/gD/VAnosd8lF9NHjmkLrEkJ2FwzFz4VJQ2PnmjAKEBsHHAFuPGR8cQQBy97Rz6SHRnMyg69UU6ns8G7lCYu3l4BHB4/xN68amNUshxHe0mW4WUfYu7QHFpCHiE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZGE4WqX0esIDcr2fuNuyxPRnI2FaqArx2M7jm2yIYo=;
 b=b92ViMn8UO164x5/PPr4WI9nmyL70i+m6UB95Y9+vlOY4GY4po5LFJTDwt8b+Jd2ChEs67fQRSqTyYJ4yIQTgVkV83N3kAB3b76eLHgWL7hLhTl2x6/gIm1NqAGsEfIYnPEFjVtg989gm6IMWC7RXcZ7IVLQKTcVm6MXjKw+a9A4Y14IPJ6R2CA5y0GDJ7wbW0BC/wZIjdCWPYOrfoINcnClYJz+4Cnw8aIlhkooEIgPbfZSOguBbEgV9z2L88xL0YIK6HTM75nhE9dqpi+YbFJxMB0kie+78HuaBdtIAurE2cD6AD3uqC556NJgmypxAl1STAiw1cvlh2OSqFCleg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 01:30:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:30:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96Mok4WQFp4gEq5F3KBlp1btLKxrksAgAAekwCAAHPkgIAAmrDg
Date: Tue, 12 Nov 2024 01:30:57 +0000
Message-ID:
 <PAXPR04MB85102BB0EC0EB736AEECA29B88592@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB88493050E61FC7F1EB18973596582@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB88493050E61FC7F1EB18973596582@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB9524:EE_
x-ms-office365-filtering-correlation-id: 7fa8bde1-0e0f-446c-572c-08dd02b9a86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGt6V3FSUFdqbm5EZEc2dHQvVGx4SVd0czV1bnM1VGwyTEhSdFJ4bTUyaEVi?=
 =?utf-8?B?dXZYc2dhN1orSCthQlN0c2FHQmVzMkpRZFNjb1ZnS0t0THlYalZJMXpIOVls?=
 =?utf-8?B?ZHlXZGdsQnZ4VjVZYzU5bFVQTFdEUm5VOWdrZkVyWEF0cEZvSHFHSFZJMGVm?=
 =?utf-8?B?MWp6UXlSU1BQTUJwZWV5c1RORGZtMm4vby9JanJwemZ1bE9uN3ZlOUZQajYv?=
 =?utf-8?B?SU10dXdYSlZyelBZTXBlMTgrZ2l3ZkNEZjBHVE9TbmZQZitqbVVQNGRnck9M?=
 =?utf-8?B?NWdMQW1xR1VzNUtHSmF5U3l1NTVrd0ExZVJRZ1o3UlRDSnFYNFdXN2lSOW43?=
 =?utf-8?B?SEtsb1V2T2pSNytuMmg2b20reTJZV0luM3dpa1p2OTBhMHh2eWU2WnZnTUVH?=
 =?utf-8?B?L3h5ODg0MDNRdEdQVnh6N1FwOU1raE1TT1RUajhRQ1FyNFVCREpTQ0w2RUM1?=
 =?utf-8?B?U0xVVHNVYytBTUlVcW05Zy9Odm51bG9tM3k0SjlZNFVxNWEvVXdtUURhZG5F?=
 =?utf-8?B?di9iY0lYdzhhd3pMK1JuNEY2YzFVekg3bVloZFpJK3prUDVvZmRpci9yNmwv?=
 =?utf-8?B?Ymp4S09XTVJNVm8zUHZiVVJPWUdvMHNLOUNaM3M3QnVZdkcxRmlSYVJkaGVD?=
 =?utf-8?B?bkUwakU4ZEIrVFdqdVZtWFRZTUw2aGdacUplVk9sR1NIUWxOdUJLYnh4L1Fp?=
 =?utf-8?B?M1AyVVdhVzhFVDlCY25PYkVSem1mZmJoeVVhalNxUXF5RUNpQTR3UnhjckIv?=
 =?utf-8?B?d3Q4SCs1KzluY2xaL0VYYkROZlgzTnRmT1hvTk9adkZZNENuRGwwZ2YzTUZB?=
 =?utf-8?B?UWtmU1V1dHJMc0dIMnZEaC92MncyWTB1dkM3anRFTU1LUHNlSDFXUnpIdFNq?=
 =?utf-8?B?clAzdisyaVBMTE9wdGY5MVBtK0JlMjBSS2dyYXZqdGFXdFRrRWdRdzZJYXAz?=
 =?utf-8?B?WmNYMjEzNXBlN0RDRzAwLzFHVE9nUDhJczQwNURGekYxVzZjSHIwLzNXN1Bn?=
 =?utf-8?B?OHU5cTMvalY5WStuM1k0Zm03NEJIeEdIc1RUZWFKeDNlQ3RXSkFBTXBLbGN0?=
 =?utf-8?B?M0Z2allrWENzL1JqQTUzZlVkQ1BwTWJUOGpsVVBrRXZhWXltTlNlbVVCRXlC?=
 =?utf-8?B?SzdEamRvcUk1MzloaG9NL3ovK2JVTWxFbitHOUJLVzlBa0JPcFpwcy9lV3FF?=
 =?utf-8?B?Y05Pc0o5NmRQeXlzSHBIV0I0RHhkUWtoU05zdDZJN2lOL1V1K0FUakdKS0xk?=
 =?utf-8?B?YUpqMUJkRUtwcGxRVG8zZVlwdzhIZkd1bkY4cy9USzQxN2JTUVk2OTNtQnZQ?=
 =?utf-8?B?cjlkQlBHWWswWW4waEVodDBnMXoyQlpQVG5OcGg1bHMwaEN1NlFFWlNoRVRl?=
 =?utf-8?B?SlBMUmdXdWFNWkxXY0FKSkptUmtwckN3TDI0cFJ5a1hlN0EzVUo2MWhMQlNu?=
 =?utf-8?B?SElZOTJ3aXRKallxb21SNmJza1ZlSG5WTkdBdklUdU91YkxObzJ3eTJDZUpT?=
 =?utf-8?B?eUJrR2hVQ1c3NVZiQTBrdVkwMVB0MlZwWEpQMllQK0NsWlYyV3NtT3ZybTYx?=
 =?utf-8?B?dzdZMUdwOUxhWGI4TXdxN09tSnphQnZ2RXRhd2ZtOVUyZFgra3NGZmdCSU8r?=
 =?utf-8?B?VHI4Mk94U0RNbzlDM3BEUkV6dUVoZmtHdTQ1MUFVRDhLSWhsRm9lbmNYSWsv?=
 =?utf-8?B?VWNwN2Y0YXJkS0k5THloWXM0N3U4ZEJ6UVhhTW9KNCszY0VOeVJLMmVDTXEv?=
 =?utf-8?B?bGE1L0NaYzVpRVFJZ205NTZEV2pPUmZTMFpzZEVyYXJwSTVlTHIzVTdUYXVv?=
 =?utf-8?Q?oHxa3u6RZHdm6n2SPCIWsjuJbNTlgovuragGU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkRxcUx6WXRFK0hKcU5MRnNGcTlMM0hVWTgrTlBBSUxPLzV0b3pEd1NtMlVK?=
 =?utf-8?B?TDVEY1Nhd3FNTDZXR2FuaDlHN1VSWkN0dGpnTnFiOERqYWRiRlhUNWhEaHBI?=
 =?utf-8?B?dzNXdFZJVlpsWStvZ1N4YU1HMmNjK2EzYk9PVlB5eWNOTVZmNktzRU5xRHRQ?=
 =?utf-8?B?clMvZWorTlZPTE1DZ3Z5VEx1TUV3c0FwdU82QnJDcG5VeEQzcHRkSDBoVllo?=
 =?utf-8?B?V21OVmc3OEttT0NCQjVubmkvcWo1K1VIcnB1UzBsRkZBaTFZYllRSEJmNWp2?=
 =?utf-8?B?cm04U0lxbi81QXZZMVdVTEJMMVNReEFOUGpiWVVTRTlocnVkY09ZMnFUOXhk?=
 =?utf-8?B?eHBjcGRQdUdrbGxyUEJTc2xpNCtqSmtvWHZvUDUzM0RqNEpYQTZSeDVGK3Zv?=
 =?utf-8?B?TktiN1U5TTF6WU5EOVd4VDNvN2NDWEJGeElGaDYzVGZYa1hBWml5bUxEVTAy?=
 =?utf-8?B?eUV5SmZaaHdLYXN6WWlBcUVWV2NONmZVeHJBdnlaanNSUDlPK1VvbWZWclAw?=
 =?utf-8?B?bTJiVFRBais2akloaFR1bHI4K3c4YjlGdlVFbHhIakFMNkNLZktma2lNZU90?=
 =?utf-8?B?WWtiZnErZHVEVWlEY2VBUzUrYWlyYVBERnhwdkIrRVZBRVl0dWJsRCtGamNB?=
 =?utf-8?B?QVBOMStwMlNyOU56Z1QvNmtTaHowZGhaNVR2QU5GbERCejJzYU9rbnE2S05G?=
 =?utf-8?B?K1BsTGxWTEdzTDdZWE5aR1Z3Mm92OStTZTJDOWJBNFA2NEVZdlNlKzFmNnNl?=
 =?utf-8?B?N1JRNXRhZnd4QiszOVRNQ1pMVXNPaWNkZ2I2aFBhalJQOGJBU0piTEszMUtH?=
 =?utf-8?B?QlN5OFdEN0Nwc1FDS0ZPYkNhWVRqcWhrZURHSlh0MXYxOUJVbVZ5NEhaUE9l?=
 =?utf-8?B?V0htYUpndExqVWgySzhHRXo0Y09sbC9kdTNpZ3dPeUI2dm44SVF3SnNpbmV3?=
 =?utf-8?B?MUFuMXJnOG54eTVpdjVvc3Q2Sk5pOGZ2aU9mcWM0M2RLaS9xZUovYVJ1OUt5?=
 =?utf-8?B?QjUyYXUyYlc3SGtqQWQ2T1JFZng4dVg4d29iMUZ0RytvQnB1Vkx5MWxSZTBj?=
 =?utf-8?B?WUlyaEpmSHQwMkV0NTV6SUZCbXM1K0duRXNjS09KZDJCTVdDdjhjZFhkSXdx?=
 =?utf-8?B?cXNldS9WRndDZER4Qzg0b1I2RjA5TDhrU2VoVHNxc1h0QTkzS0lWV29nQlJu?=
 =?utf-8?B?UGpYOWVObElFc1d6WTJQVjNjaDc0TDF6WUdLNkhRQTh0QlJENzlWbXZZc0lm?=
 =?utf-8?B?dXhFK29hMVpzQm94QjlaMDdwRUtpVHFJVmhObUpMR0JLK3NkaExVZjkvaG1Z?=
 =?utf-8?B?clVzZkFYVHY2RHdCWlVZaiszd2tWWmMxMG0wTk9XZ3NGSTc0STVqREt1REo5?=
 =?utf-8?B?ZXRHWXVGd3A3a3dnVHlkdmpwZy83SWZhcVBOYWcwRmlZSEhUeGhYdjhrYTV5?=
 =?utf-8?B?ODN0NUt5Vm50dDB1emtSdGpKRnFmRUsrSUV3b2VtK2ZiN2pNRnV0ZEhQc0k2?=
 =?utf-8?B?SGRhc1lFOE1qc1AyLzk0YkRQL0NiUXhnZlhONXJOdCtjUm1pOTFXa3lwN1dZ?=
 =?utf-8?B?Y2o5blpLd3ZiWEFJbUduUE1KTzFOdnNBbW12dUdFYmxoZjY1Sld6ck1zNkZB?=
 =?utf-8?B?dzFncjZMWHpxTTVUSS9WdzYya3RiNzJLdWJqeGVXUkkxdXhrdFZSeE1NbUI2?=
 =?utf-8?B?RU8zbVo5UlYyWU12dkRwbTZ6dVAyeHlLVUtpUkJrWkQzQjJPR0M0VmxtZlJI?=
 =?utf-8?B?OGJWeUxLZlBpd2NXUStWM1NpaXhLWVZjcWNvYmYxMmNOZDJCUG9iRlp6d2Ix?=
 =?utf-8?B?VjRtc2xVdHpMMG1Ta0ppTjFqRG94b0h5YzZ3bGQ4QkNBSzRpOU0vWnhCdU9C?=
 =?utf-8?B?VStJOG9vcDBIeSs2L0VHNWJnSGtVMGp3eUwydTFzRWRDWmI1VVBEM1hGMVFV?=
 =?utf-8?B?RFFKWVZyRmRJVmg2UWd1anNTeUE2bmh3SjFIOEVlRUlCRDdpVVg5WXJ5SVQ1?=
 =?utf-8?B?c2tvRElYYkU2Qk9XOXFEVjROL0c2aXJrUUFXRFd4ZEhxdEREUGM5V2tRbTdX?=
 =?utf-8?B?bUtaSXpwbXUvZjFoY2ZKTnN3YTllT0xtK05lTlVYSktVdzJFdEZBNnBmS2Vl?=
 =?utf-8?Q?G1Uk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8bde1-0e0f-446c-572c-08dd02b9a86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:30:57.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sitxEJOFJa+Ncn9jI16XDYtXDKKgVZiikmjtpAGS5aLE1rySM7KeSrsCLzuUw+JPB03FjUsvBprV0apuMvoZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1ZGl1IE1hbm9pbCA8Y2xh
dWRpdS5tYW5vaWxAbnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyIMTLml6UgMDoxMQ0KPiBU
bzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0K
PiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhcmsgV2FuZw0K
PiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBk
YXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gU3ViamVj
dDogUkU6IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzVdIG5ldDogZW5ldGM6IGFkZCBUeCBjaGVja3N1
bSBvZmZsb2FkIGZvcg0KPiBpLk1YOTUgRU5FVEMNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDExOjI2IEFNDQo+IFsuLi5dDQo+ID4gU3ViamVj
dDogUkU6IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzVdIG5ldDogZW5ldGM6IGFkZCBUeCBjaGVja3N1
bSBvZmZsb2FkIGZvcg0KPiA+IGkuTVg5NSBFTkVUQw0KPiA+DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gPiA+IEBAIC0x
NDMsNiArMTQzLDI3IEBAIHN0YXRpYyBpbnQgZW5ldGNfcHRwX3BhcnNlKHN0cnVjdCBza19idWZm
ICpza2IsDQo+ID4gPiA+IHU4ICp1ZHAsDQo+ID4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiA+ICB9
DQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgYm9vbCBlbmV0Y190eF9jc3VtX29mZmxvYWRfY2hl
Y2soc3RydWN0IHNrX2J1ZmYgKnNrYikgew0KPiA+ID4gPiArCWlmIChpcF9oZHIoc2tiKS0+dmVy
c2lvbiA9PSA0KQ0KPiA+ID4NCj4gPiA+IEkgd291bGQgYXZvaWQgdXNpbmcgaXBfaGRyKCksIG9y
IGFueSBmb3JtIG9mIHRvdWNoaW5nIHBhY2tlZCBkYXRhIGFuZA0KPiA+ID4gdHJ5IGV4dHJhY3Qg
dGhpcyBraW5kIG9mIGluZm8gZGlyZWN0bHkgZnJvbSB0aGUgc2tiIG1ldGFkYXRhIGluc3RlYWQs
DQo+ID4gPiBzZWUgYWxzbyBjb21tZW50IGJlbG93Lg0KPiA+ID4NCj4gPiA+IGkuZS4sIHdoeSBu
b3Q6DQo+ID4gPiBpZiAoc2tiLT5wcm90b2NvbCA9PSBodG9ucyhFVEhfUF9JUFY2KSkgLi4gIGV0
Yy4gPw0KPiA+DQo+ID4gc2tiLT5wcm90b2NvbCBtYXkgYmUgVkxBTiBwcm90b2NvbCwgc3VjaCBh
cyBFVEhfUF84MDIxUSwNCj4gRVRIX1BfODAyMUFELg0KPiA+IElmIHNvLCBpdCBpcyBpbXBvc3Np
YmxlIHRvIGRldGVybWluZSB3aGV0aGVyIGl0IGlzIGFuIElQdjQgb3IgSVB2NiBmcmFtZXMNCj4g
dGhyb3VnaA0KPiA+IHByb3RvY29sLg0KPiA+DQo+IA0KPiB2bGFuX2dldF9wcm90b2NvbCgpIHRo
ZW4/DQo+IEkgc2VlIHlvdSdyZSB1c2luZyB0aGlzIGhlbHBlciBpbiB0aGUgTFNPIHBhdGNoLCBz
byBsZXQncyBiZSBjb25zaXN0ZW50IHRoZW4uIDopDQo+IEkgc3RpbGwgdGhpbmsgaXQncyBiZXR0
ZXIgdGhhbiB0aGUgaXBfaGRyKHNrYikgYXBwcm9hY2guDQoNClllcywgdmxhbl9nZXRfcHJvdG9j
b2woKSBjYW4gYWxzbyBoZWxwIHVzIGdldCB0aGUgSVAgdmVyc2lvbiwgc28gbGV0J3MgYmUNCmNv
bnNpc3RlbnQuIFRoYW5rcy4NCg0K

