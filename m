Return-Path: <netdev+bounces-246491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D85CED250
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB44300957C
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856712E22B5;
	Thu,  1 Jan 2026 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="q5jlencx";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="q5jlencx"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021136.outbound.protection.outlook.com [52.101.65.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DC238C08;
	Thu,  1 Jan 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.136
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283564; cv=fail; b=VWCJ2CwRE8XaSyJH5XHO1JQawDI58eSixjxNd15DqNsoBPrYzTJLp9PzsLb9rMBn6GWcupaXvFQGQnClgG80D9cyVLrV0nYUUySAMMc+rWHh3K6FcTrhNHgdDchMCkuyJ0zUWepLJ6iLNSrCQ5nA1uUaMW4Y8jetkGmcvpCNJ20=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283564; c=relaxed/simple;
	bh=iGU/s+0kUnx+0HOAGhrDrhJsSTh7Q+8YicsxxOkdtzc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=e8Oah+k9+WP5QB0P+/D7MYcmTFQyQ0ifw8h3uaXXnsMFxY0nMAF54iMwiAHZQPtBKXzbfA/9lMszUpao++1X7lGhk55yv32f7tdCyuIFN7S9gQxTFmQr+6+Q02ThCSliTAhm0Mx5t2fEyvBKY4qW55qQnZOD3aNY/Fg6L946itQ=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=q5jlencx; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=q5jlencx; arc=fail smtp.client-ip=52.101.65.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=o7cC11GMRCIy6YTUwP9AgIJQW6xXh74ewgDbTanVqHEDhQQkhV2JZ0ef8EtdXtaNrBFvxdFUXHMLQrxs3ew5BM88AVH5dNpxTMVfDeoAGvGi2Mk5LWvpICWjk8M9saNFQSS6Cs5Hli1vSvN/kVuHVVwwDp11FIahEbwDMQHjx/YFTf468HD5IvcDBgxbZEuywNmyeOamT0IbQ4Z6tek9vC05qPnLQyxxL6JShMJVSrnewjkOnU757tRqbaLMpHNNHiUtHNwN36rt268SNYJ88C5wUvazZ3i2OcjmcmRtmpjU17NCRDSnaeIg6txAA/TCsJw271RO/BHfQ3Z83CUvwQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBQQLtUA9i11LPe8csYtVD8VFIc80r7XpJJ4XsuVQoY=;
 b=cDyZHxCsJm8n/VkpWZeMn/OIqbPdGLVvnJKeKGmwXPbL5mrKlkclYahSlSmODzcbb9p+7ortKhiGqm6NouPOdH9tx2syZWPk6Z6n6HQ7yCvNSoFEFsrr2d500geCoFd5cjnjUFmYARregMoQZ48AA8g9H1XK5IY9muV1XRe+rUScwICkP1tTtQyNeAbCZqelhqOxFbokYRljkGTRVy7ub3LvFcnqecD1UErTRo+v7AtvZUbzBV17byvPNGiI6ca1Sb51eKsQNIwtre0dIVQbBtJQe4iSvEtlbzNPl2bVTZVhnbAfoW4mGV46e5p3ALeczbQpzVuZ/1kg6mtMTl1Haw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBQQLtUA9i11LPe8csYtVD8VFIc80r7XpJJ4XsuVQoY=;
 b=q5jlencxlxLbJT0qeHPp/+kc2TyqAeDPuUhbQLiu09p5dE9BIlO1O2namHTxJvE/hCo7FAU6aqRXJyvIq5Ay1RVrrf+kxTQqbWLaVzRutjCIcEwjWwMcnd2chlXaIlLShHFEwHAMQYrGTx31nfmfI22nPNYUkVTmuEaBIhafMN0=
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by VI0PR04MB10781.eurprd04.prod.outlook.com (2603:10a6:800:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:55 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::a7) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 1
 Jan 2026 16:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Thu, 1 Jan 2026 16:05:55 +0000
Received: from emails-39759-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-24.eu-west-1.compute.internal [10.20.5.24])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 52CAC809E9;
	Thu,  1 Jan 2026 16:05:55 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1767283555; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=ZBQQLtUA9i11LPe8csYtVD8VFIc80r7XpJJ4XsuVQoY=;
 b=I9jTUTR6d32+wf+aGOgHfrww5lg7N5WsA9Vm6eG3k0bKIb8yzyUehsfz8vGIC2P9MWfor
 2t+T1tSBhqUR26GkFicWMG0UzMLL/WGS1Hr5hgmPiqJOq9BnjhRAKRn9S2ELVaZ+k3FRJ38
 NK3+yCMQwUlg07odhaSIBq2wc6b55kI=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1767283555;
 b=VB1N1DMU6DuAo8uSg4/kulVPWneMTQkmH93VlB8bDtqOYUwDghxxXfHTco01/R0/z+qyi
 tHE4GD+Vn0+GSpyKyRBwcURluWpGA7vYhnVekMCDrMlcmZgqweUUdu6WXEew5IBydplLTFv
 OjwKJDf83bWkMMaBsRs8HowaTfnQyjE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVi5HygNO/2sscgAK0mNw78FVUxG62cBcxnxjGlY9HI0sgdcLjrh9wpn7LIk4bQAMd+98dNN6OfcAEln8RnAXp1bUGR9wGgDDuWra3qw4BbHn5tpAq2LR+uqhv+2OaFdu39MXz5pODWP7Eany9j6agHMarI+FM32KteXC5VrQeMwbBroLm3XUPb3MtJO5eeteZKJ64JmoRP9FFAE0Gki+bXpTv1IFFzHwBKGaJ29Q8iChdnfTYxoGADuqRcXG68vhROYAWuTBEraSt0CmWJ1fFQ7pQKjY1uUFKhF1+akivcYMCZoC+565jOoB7sYIgc1Oxrw2NqwsJx9LgAFxnPvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBQQLtUA9i11LPe8csYtVD8VFIc80r7XpJJ4XsuVQoY=;
 b=hVjM7N/SeJnRzuBJT9Qlk6S/zO8x7jRSfyekoYcG5Exd6/bxtSf3G87cKhr6P6HSKTzS/RXkFLDs+1/Q9bd6+aY7uZZdZ1paLwT5NikOGFXAddo4HdHKPuVqBt/0/+WYeEbx/8mYZgZvKz38u6aSTv8BIY3Sp9Oydc0k7Is8V65Df1baNH0APotZTGo8V21vSbgb8cyBcrurxrxpExdBSG+ceB4HHD7Rx6lq+BTM8ZUMB0kyDsab90LC2SUd7WW+qH6Qb9Lr/GkOUzmKeBfHQ4HTScgRXajaQFkWgVna+jxSbGHLpZE5tOA8jTy0Xtnfag/XO8WNd7MBb79p6Ta7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBQQLtUA9i11LPe8csYtVD8VFIc80r7XpJJ4XsuVQoY=;
 b=q5jlencxlxLbJT0qeHPp/+kc2TyqAeDPuUhbQLiu09p5dE9BIlO1O2namHTxJvE/hCo7FAU6aqRXJyvIq5Ay1RVrrf+kxTQqbWLaVzRutjCIcEwjWwMcnd2chlXaIlLShHFEwHAMQYrGTx31nfmfI22nPNYUkVTmuEaBIhafMN0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:05:46 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9456.013; Thu, 1 Jan 2026
 16:05:46 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH RFC net-next v2 0/2] net: phy: marvell: 88e1111: define
 gigabit features
Date: Thu, 01 Jan 2026 18:05:37 +0200
Message-Id: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGbVmkC/32NwQrCMBAFf0X27EqS2ho9CYIf4FU8pOmmDdikJ
 GmplP67UfDqcR68mQUiBUsRTpsFAk02Wu8yiO0GdKdcS2ibzCCYqBhnHLWN2iNvMZoBh+6FhlQ
 aA0VUptwTk4yJA4f8HwIZO3/dd7hdL5/NUUJHc4JHBhN8j6kLpH6JkklR/ElMHDkWdSFZVcujE
 uIc/dM2GEa3076HdX0DXFezRNEAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josua Mayer <josua@solid-run.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB8286:EE_|DU2PEPF00028CFE:EE_|VI0PR04MB10781:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1cac86-9b03-40ef-11b1-08de494fa51e
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TVlmSGRuS21GamFWcTBVOUZKYUwwUm9nNm9zdHl1Nm9TNjBlUDFrT0pyZnNk?=
 =?utf-8?B?bUlnQ21XUGorL1RZVGg3NXpabWNkN2pEVisxMjJPam1RQWl6WkhzY1d2Ry9U?=
 =?utf-8?B?V0JWbXVnR2E0Y1V0SDJ3MUIybm51M1RrYUxEaFlWR1IvNGlQM3llTjRTN040?=
 =?utf-8?B?dGQrNVFvTkg4OVkyUkFuOE1xS3VsSFZQcjRTSG1iWEhxZHBpMG1ZM2lqSGV6?=
 =?utf-8?B?Y1luRlZxaUcyS2ZWdndzcExwcm5BZmhzY25Nc0lDMHJ3bTJRQ2NDZll1elR0?=
 =?utf-8?B?dlR3bERMTkYvSTU4VFM2LzBYR2wwaE5FVHMxbTJuWUFzdk83ejNZWmlxc0Ux?=
 =?utf-8?B?SkpVSHBkTytnN3hyVTF0VklNbUZTNjB4ZzFkcHFCVUpDSDBqMCtFK2hTZ0Rh?=
 =?utf-8?B?aWZVaTQ2T0twT3hVYWV6R2FjK0lZWm5KN0N0dHY2ZHZzVDhDU05qWHRQOVA0?=
 =?utf-8?B?Q01jU085eDhBZ0JObXpVVnZuQmlPRzdYOEc5Q0pCNTlRaTIrQzRYdzB5VjVv?=
 =?utf-8?B?aldleDM1S1ZrRUFqb3FnOWVEK0JKamNScHE4MnpLaHlLVmFxdG51OHlRL3E0?=
 =?utf-8?B?c281dTd6N2M0U082UXpTZEtIRWo0dlZmcHZicFRMa2J3MktraXBiamhoZTBk?=
 =?utf-8?B?S0lueUlCQUJsSTRlVUlnMVNQWHBLL2dzY1dSQ2pzTTNWV3FFZ09vK0pHZHpK?=
 =?utf-8?B?QVZ0cGpMUnJ1OHBQbktJT3o3Y1NBNWNFSnRBSTBsQi81Vml2ckNEbnVOeWI4?=
 =?utf-8?B?Wk81VFg2c2xQQWtnY2RodEdCeGxQaEt0RDR4WVJGczJTR0FKbStOdm5Qcm52?=
 =?utf-8?B?TUR6Z3FtVldrZ2lJN1dZdm9XUHdXaTRyOVBWUHVvbFV4a1p1aHNmY3JIMVVn?=
 =?utf-8?B?b0NXbFN5QnJYQTVheExGcEFzMFNzRzQ5YTdLc3RNRlkxT2FhRnc0UERZcFgv?=
 =?utf-8?B?OGk1Nm5Dd2c4YnBoSG9jN0o0T09RbTBiL0lGWTJQeHRTUnBqTFZWQStYNmsy?=
 =?utf-8?B?TlRVMGF4MjdHNDc0czRLUjk3WSs4QzNoZDV0RGNrZzlRRXFLMFoycFhKRjJj?=
 =?utf-8?B?WW9PT3hjSXEvZkpPZ3hpaDZycEdqNUJFZGpabjJ5MFdybi9vb1NOb3NrRWdt?=
 =?utf-8?B?bkMwZVF1OWJza3hza1FsRkJZRlJqT2dDOFNHQWJncFkrNGY1M2FFTzZ5bnhX?=
 =?utf-8?B?cmNPM1RRcHBJNWdaZUROQU5UYk16M2JCZktyZkpKM2RoY3JnOXp2K1BXUlph?=
 =?utf-8?B?NFA2V1dRV2EydzBTN1RoTklrWHBwbFNpVm42NFJkVXhoQzJwZTNaVGdkYjRS?=
 =?utf-8?B?dUxpYTQ1dXYyV0E0dHF2WTZDZU5iTHlsY2MzWTlIamZDUkNaVU42NHM5N0ww?=
 =?utf-8?B?d2NYc3YzejBXUWlaRk84cys2ZW9sczFJREtYSHZZKzgwSzQwS2c3NDN4eWRl?=
 =?utf-8?B?cHRXbkNrTS9BeE9CMkZpb0JjNFByeFd1ZXFmclBaWlk3MXhXd2ZnR1JmU2p1?=
 =?utf-8?B?Zm1xdm1PS3l6WmdKQUhKR29ITkJoOTZSUTIwMkpDYTlLMnhrWkxaaDVVQkhx?=
 =?utf-8?B?S2l6a0gzOXVBU3o0RnU5R2dHbFlvS3FVWEdSenJFYnF2cERSVjNOeThPcnNm?=
 =?utf-8?B?RGd3VnVzODh5czc4QmJnbkFTaGlTOXRIU0pxeS94RHJyS0c2R1g1STBRQ3hn?=
 =?utf-8?B?Y3o0UldMQk9icERaMENqVENuQVN4dnZvdlVWMFo4TWNmZjJnbVo2YlhiQzZ4?=
 =?utf-8?B?Mk1pb2NFT3h1VlFFWWlrdklOeHB1bXg2TkZLSzBXWFNxUys3VTIzV255NWxR?=
 =?utf-8?B?RXZ0bUsycTVZVlI5OWwvMVl4djBLOUVSVk81Q0diWU02bHlTYnNMeUd3Tmdj?=
 =?utf-8?B?aE0rOUFkYkxqb20wZmFVR1RncTg2S3pCYlRlRkkrZmxWNVBFaGJIZFV4V09m?=
 =?utf-8?B?VGVsM0pmVFJrOEQ4UzRiZ1NpRE5heGhmcmd0WDRYUEM4L0NZVC92OHBQelgx?=
 =?utf-8?B?ZVNPWG1BT0JicHB3YXJyT3ZjTTYxQVNFSlhMTHRlMkZKbVhUQktIWGZtdmg5?=
 =?utf-8?Q?qfmv6A?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ae0ad5136d0a4c0b8d8454dd1690a31a:solidrun,office365_emails,sent,inline:d76a6378bbacbe1cb435616c853d49de
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a7a93262-9326-4309-7058-08de494f9fcd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|7416014|376014|36860700013|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTNOaVRWUUlFblBTUWhzYXpMLzBVeDBvMzk5WC9wWGRiT053R25ZMkRjWjhJ?=
 =?utf-8?B?bk9rRkUya0k3UHNiSTJ1bmk3WGdpZHU5Y2dJQWs3N2FBc2ROc1Z3YVdobzJk?=
 =?utf-8?B?eUN6b09hSmdrUFlrY2loV3lBZmhBZnFXRUQxdEtkVDJYczl4R2FmRWpNNHRP?=
 =?utf-8?B?cEE3NVBzbUlSdE90UXlwdVNTK09XYk5hdzllaDVFOFVhakE4Sk9qYXVGTmVJ?=
 =?utf-8?B?b2dGM2xkQmprcU9TUlBzV0VTQVdoNjczeDEvcU5hTFVPQjQ2RkhzNHdwZHBI?=
 =?utf-8?B?anYyTWVRNWdQWWdrenBOekNNeUVjVU0zdm1BcWJZTzNYNTZoTzdxeFZKeC9x?=
 =?utf-8?B?Rnp0TEx1NGNJNVk2WWZIMjM0bExCL0V1bkFRdFJxeGhXVkh5UHRXV21mdXR6?=
 =?utf-8?B?ZmxEeUI5ZWdqVXVXMnl4YkRKd0Qyem9VYUFtV2RRY3gySUR3MEx2R2w5cmdZ?=
 =?utf-8?B?VWhJZ0NBUS94bkN2RUFxeTV6aHF0ZHRrOUZGa0dkUXNjRUlRT29icjA5aTBo?=
 =?utf-8?B?bmt5ZGxiRUZjTWM5dHpjeTlMRDcxSnB2VDkrNWV5UXdOcUFyOUhPajZTTEJs?=
 =?utf-8?B?Q05TbFBxQTUweXNhd1pDU2lXNG8wUmhMdTFpQndIRTZhUGFXOHdGOVgvUm51?=
 =?utf-8?B?dG5sRTdPeGp5OU1RcnZSY1dUeTZGVDBheUtZTnJlTS9FL0o5dEZoWjFmaHNw?=
 =?utf-8?B?cWp1VWlBYm9BaVlocUlkU1JpNG12VG9MME9CcmJTNGVmT2VQSENJcm52Unly?=
 =?utf-8?B?RDFTd0FJN0JZR3NVb2UyTXNzdklsWWVvbGZpUXBPbU91QmRMTlc5RVRJNGhX?=
 =?utf-8?B?cWpDTmNEaXM2a0RtUHg1OFJMc1N2RWhoTXY4NXI3aWtaeTYvRU52bUpYT1hh?=
 =?utf-8?B?SkYwd1JpYXR2Y0Z5cHl3bDFoelNtVFlhL3FFWk9KekpyaGVaZnBZYVlKZkRW?=
 =?utf-8?B?QWh4RWxGV2R6QmR2cHgvSEhTVHFCQ3ZLSjBoVURNbkpaU1JSRjl1WnZRdjR2?=
 =?utf-8?B?d2NjR2hYemt2eThwZFEzR0hiMDJadU9JSnZ2eWdoMk9Rc25RQk8vL1lvZUJL?=
 =?utf-8?B?ZFllWnlIQTRJR3ozTzRFb1dJTUhtN2hpdThTNktEQ1ViYXdxWWFSSXUvN1BU?=
 =?utf-8?B?bmNVOG55bHJBV1RmdTdvTUc1dVZnaVhmUkFtU0cxWStqcnZHOGRQMXBXVzhC?=
 =?utf-8?B?QjBRaHBFMm9hU3JWbUJ6UUtpZlhVWStmZ2JPN3QrTUZjeHNHYWNEeEJSYktL?=
 =?utf-8?B?SzRlVVdZaVRwT2VYM0FVQlRIK0VqcDU4cE1WOEt3c3pNY2ROVHRLTG5RZytY?=
 =?utf-8?B?cGZaNkErdTNhbFptMzNTSjdicWxiWDBVNTd1UDhXRFhNSWpWc3l2M2dGVU0r?=
 =?utf-8?B?ZEtSTng3STJrNDIyRUNLQlpLeXRHYUtsYm1YeC9pdWgrL2M1VnhPSlFSKzJl?=
 =?utf-8?B?YWhCdlNYTWVRWitScENadmlXQzdQZ252TW51dXRab1RHbUlqRHc3N0N4ajd2?=
 =?utf-8?B?Z1hPd3V0L2xkUEZIR0pPNGo3aStobFExNnJKR2xEeUZ1SWNORVhnRHE2TkFZ?=
 =?utf-8?B?RVNMaUo5ZEFpWklXN1VmRlpROGpQWW81dlE1QzU4MmtFTmRqY2J5RnpacGIy?=
 =?utf-8?B?azdLWlVxK0haejRTbnhFUXJndElRZFJ1MkVWODM2aHB4MWRValAxQ0ZlU2pv?=
 =?utf-8?B?VVh2b05Oc1NoNFRVOWp0d2tGV2R5NDd5Nng4VEphNDY5d2hqK09xQmRrL2V5?=
 =?utf-8?B?aTRURklyRzBINlpGeFdtUHZ0NE52QTUzb3QrTzRlNFFzWklTa2F2aFVSZ1ZX?=
 =?utf-8?B?aEZXdGM3UU1RekNMNWMvZVpLbld0SVdRWGRmUU9WSUZqeW10T2U5dXU4K2k0?=
 =?utf-8?B?R2d4NXgwMkdtdFMranpBNWdYZ0kxL1pmRWtveHNwTStXbFcrZG53UUh2S0Yw?=
 =?utf-8?B?bnkvVzduVHFyMWsyNVRqamwyNGp6cmhHL2RGTU5xZXZoMEN4aVBEZjRLRy9V?=
 =?utf-8?B?Qm5MZFR4bWVOWWhDaG5zekNNdEY4NnhmeDVOd0NEcHZYVWtTZUJZVlM2dkxw?=
 =?utf-8?B?U3RJaXJ6WnFPb2UzVTdJeERxTnRKSDJic2JnbkNLSHA5aVhPZUd6Q2UwWVI3?=
 =?utf-8?Q?3OpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(7416014)(376014)(36860700013)(35042699022)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:05:55.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1cac86-9b03-40ef-11b1-08de494fa51e
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10781

This series addresses issues a few SFP modules:

- Cisco GLC-T
- Cisco GLC-TE
- GigaLight GSS-SPO250-LRT
- FS SFP-25G23-BX20-I

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>

Changes in v2:
- added extra patch for 25G long-range modules (RFC)
- rebased on netdev/main (01/01/2026).
- corrected description that phylib populates the supported link modes
  for a netdev.
  (Reported-by: Russell King (Oracle) <linux@armlinux.org.uk)
- Picked up reviewed-tag from RMK.

---
Josua Mayer (2):
      net: phy: marvell: 88e1111: define gigabit features
      net: sfp: support 25G long-range modules (extended compliance code 0x3)

 drivers/net/phy/marvell.c | 2 +-
 drivers/net/phy/sfp-bus.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
change-id: 20260101-cisco-1g-sfp-phy-features-af54e0800271

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



