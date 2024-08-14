Return-Path: <netdev+bounces-118508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B1951D16
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927892818E5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A22D1B32D3;
	Wed, 14 Aug 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="M+ml8MpU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AA1B1402;
	Wed, 14 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645799; cv=fail; b=VlELMRXyjMumr4rlvNsePsdgSeIQJNsA5kYblRcjKIRnd5ZDnC3CSbNnKPl4DPVslNn6bBk3PScrB+/yyRhFoUodwvlmGhFrJZugjp4snIpksrmT6cOuOjj15SIqaIMePu8xzk/CWFh8gL58aSz3p9AQihqdYLAYIAC6EGC01Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645799; c=relaxed/simple;
	bh=0G820mK5PkCGTZULSRocV1shQgre+hk2fRIkj95C1OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euZ4wmORvSneF/T6CAo1vMmxAbLQp9nbnz8f+7DAsn5KS4TNQfpuUYuJQHFV9yn3V1mVxkNUrHUwsLFv1eKWbO+e+Ccssiv2U4bGiqYRBr7XUkfar72JI99QLPE3tpRn0xCrTGhhEUAFnycHklym/aWWTFHBs1LbND4CB/7BcfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=M+ml8MpU; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdBoNmh/p5dN3b8FQ+JSeD+TtJHQHrYRvWUWleJGVav6+cejw8ARpbhel9z4ixJj6BuIGl1FpUMGPx/jL+fhwyxX6/RnItYdbimRftbB5Ac6Qz9+VdMRG4MhAwrsAg2POa9TuydF5vpy9YskKHk2kn2c2wpJJrBo7htqfsegZRG/HBEmfZt0477moJ3WK5NcQZAwPC41NaDv9jrmFydWSIC6AKDxiMlunAOsrAWzFq0dN7jECyKxtCbuWwIw9Cs94YdOccXrr3qjrICCW4faTJ2iF2SFA86wMzxb0jTeiEhN7RiHhIl2h8hPhwIg/Uvx7lTA7wzFKjpSK0BvJXgINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G820mK5PkCGTZULSRocV1shQgre+hk2fRIkj95C1OY=;
 b=uy9MAvWlpA3NTwM0cGcIT2osoTzALEBCMrkcko9i6ZVYhjH/J3Cnxg3qEE2OeaAY/9JIUvTCiOUswt6Pjg8K71SDM1OZTBCJX1b9MOYj3TYB2n2tHszyT1e+ujd0GeuFtvsH5z+aoXhg6pzMtUFs9h0DFSksR+kpbJojerj6Hkt773WPngf217rUnSk0JbpABVbxO82PEL/V3sniZqrUF0gjT8RCA4HAEQrjTZ90MDMjrLIDykqqR+5msowQBoB5gYwgRd5X/DXnIYO97ijKqIvdkAhSUvNEjZ5fv1W6bYcXwVDiNdTUJq6L6Kwdqo3+VvaxJfdd9EPiU/EmS36Oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G820mK5PkCGTZULSRocV1shQgre+hk2fRIkj95C1OY=;
 b=M+ml8MpUH9rwAmedPIRQ8KZnM9uQJBnXR3RYWasbNCYTjS/myEOj2xga2w2FR3KwufPAC4yCJZHm2agtsHlcy6awhPhMuDIINbN3hUsG+KAl1YR55xLzDHT/qsPn2gQPVBDqrhI8fHVc2bus4Kcx8CAM9J2xCj9xnuBv2DHFw0ri28dIhBq6DJtvSKNdVq8Ox7Q1qUkpViWgpJpjiA7C4upyxuJU8wjuCvwTBiBaz4riaoD74mMxiBNMTx8MFl5vMM5U/l5fJ4sYixuZS3U+ZGoDQws0RKwagsyW+4aoCqICt8Li3zmX0t8q7JGzR7wiBmrDS84W8HMQtvszxGRPBg==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DB9PR07MB9150.eurprd07.prod.outlook.com (2603:10a6:10:3d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 14:29:53 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 14:29:52 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Herve Codina
	<herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?B?Tmljb2zDsiBWZXJvbmVzZQ==?= <nicveronese@gmail.com>, Simon Horman
	<horms@kernel.org>, "mwojtas@chromium.org" <mwojtas@chromium.org>, Nathan
 Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 04/14] net: sfp: Add helper to return the SFP
 bus name
Thread-Topic: [PATCH net-next v17 04/14] net: sfp: Add helper to return the
 SFP bus name
Thread-Index: AQHa0cmObeM/BMqdwEizuuLg8g9MRLInCUWA
Date: Wed, 14 Aug 2024 14:29:52 +0000
Message-ID: <5dfbc90d-8af7-4f41-aa5e-eb43e6dcc7b4@cs-soprasteria.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-5-maxime.chevallier@bootlin.com>
In-Reply-To: <20240709063039.2909536-5-maxime.chevallier@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DB9PR07MB9150:EE_
x-ms-office365-filtering-correlation-id: 6df10e00-7fcc-493b-8620-08dcbc6d8fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm8za2xFTnlyUjg5QzR1MlRleVc2QWxXdFBiK252NCtFZ2FLT3piZW8xdVNW?=
 =?utf-8?B?REpXZFUwRVoyMUpYVHR0WWVTeXNZWWJFWnFDUWZIelZqcXpDNnRmV29PMk9l?=
 =?utf-8?B?c2dJWGtGM2s2bHZ5ems3N1BQQlliT3o2WE42b1RyeFBFT09YQmdpYWNHWUEv?=
 =?utf-8?B?cTJWQ1FJTnc2bUljNWlVY1l3MGRNbVR0ckI2UG9lT3pHTHN1N21tL2VPRm1u?=
 =?utf-8?B?ZzM0SDFHalNvQkZiV09kVk9tM2lmRkZYc0Jna0hRVGJOZXlQekU0UnVuNDFI?=
 =?utf-8?B?T0V6d251VFBTcVF1Vmh0SGg2UXJkVU84MnBrZVBIalRzb0VjRE9LSFpDN0VT?=
 =?utf-8?B?cXRDSk5RWjJManF4RTk3cE4xKy9EMXFuSUlvekY3MWRUa1RoUzdKT2pCc2ZV?=
 =?utf-8?B?U21yM1dxTWh1STFyUXIxd3JSM1pFbm1Kcm1jVzlBWXk0V21pRFJHMnl5eVNy?=
 =?utf-8?B?Q0Z2MktEcEJHZU8yZFJlMldKKytDMytJaEM4cUx5eUJtV0JqZlBQa2dUUVJG?=
 =?utf-8?B?Q3o4dWUwQVd6N1o3bXdabmZxY1l4RXVweUd5Tk1wUWdNeDNBV3BlQVd3MXZh?=
 =?utf-8?B?TmFqTEFrYS9ybDBMUUtxSjl4Qi9kdG40M0JJQWNsZFJhd3ZwR1NXS3dwVzRi?=
 =?utf-8?B?aVRCS3NKcEFEQWZzMmxBZHZxOUhTZmJudlM3TUtnVUhoQmhqVmhta21qM0hp?=
 =?utf-8?B?K2tRczNpZzBDNWZxa1RhYVQvaHFraGZDUmxMNlNFelFsSk5EWlZWS21iL3Zp?=
 =?utf-8?B?ZkRWZldQbmJHNDJ4TWRZQnpQZXJBT2dOT1l2NUpTak5idzk4cEhLYm44b2NH?=
 =?utf-8?B?N1hkdEVzMnRKSllCTENTNjBaSGl1dUJuRE5uOU1kKzhJTGx0Um9zampaQzU1?=
 =?utf-8?B?MXZNREk3TUZHcmtmaE8vREh2K1V6bFZ0bTlhdXJFRVNkMzVwSW5oSmJtRlIr?=
 =?utf-8?B?MEg2UXJEMlpJYU9ieGRmRndsR0NwdE5INXlCZlh0ZlNNVXZmR052MXdKS3RB?=
 =?utf-8?B?LzZTNkliQ1Q4VWEzTHY5SmZ1YzN1SXB6dHJCQkVRM1kzMGk5eCszNkJjTFlY?=
 =?utf-8?B?QnlnQ0ZPSGVJd1J6a2xDYTlxUC9NbGVxTUlxeXJnNkR3VHU3STgrNS9qYWht?=
 =?utf-8?B?cmJ2Z01TYlg5cElzQ2lrT1NjeXdOV3YzYnVRNE0wMTVPRmU0MytKVHdqL3kx?=
 =?utf-8?B?cjd3dmFiSnJxdVM0VVZRemZVYWRibVdXNE5tUWpDOExYNmJTejVqK3I3enFI?=
 =?utf-8?B?ZEo3OVE2SWVvb2VDZnV5a0o0N3h0Z0F4cXBJeG5Db1NwS1NUNkI1SjJDNlN5?=
 =?utf-8?B?NXkrQU5KNTNjbzVUVnZCSjBWRnFTNU1sNFZkQm50S1RYV2dLVXc3aEU3VVFl?=
 =?utf-8?B?Mzc1YmdaVm9SQjMxMUpscHBJTE1sVFJtdisxa0tydDdCdjkrMW91OHVBb21z?=
 =?utf-8?B?bVYvRjZvekUveE83dDZBQnFLV3o1M05qVmNYSXQxV3lMUFFCckluam9CbkhU?=
 =?utf-8?B?RVRYVmNQQTM3RDIrOUt1L3NWbGdtWFBCcTE0Smp4amZpM3czbld2dk1XbzY1?=
 =?utf-8?B?VlBOV0xiT29qREFaaUNOR1ZQMXNTYWYxQkwvWWVEbEFwMmZaTklKT2dKcC9z?=
 =?utf-8?B?dEhJQThkOE9mUFBVeExBejIvSFBHTW9zUkNZOXB4K1duMnlLUndKTHFDUWQw?=
 =?utf-8?B?c3A1dFZOUXhxNTJpTCtBMUczdEZ0bi94dXllNXBtd3ZaU2FNTHVoV3ZFN0hS?=
 =?utf-8?B?T1JWK1hPcnQ0RmdNWDkrMEprU1BNSTFJc3ZvWGF6SE9iQi9xZTRPVEJTalo0?=
 =?utf-8?B?TUZaMFJ6Q01zMTJLNzE4TVAxMWU4bFJ6T1hJd05RZXJkODJPcUhTdzR0NFox?=
 =?utf-8?B?Wkh6elptNFU1UTZOWmZPQVpQZlZwSHNoMHAzdUJKNnBUQVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVh2all5Y2p4MStMZnRxRlRINW9sOXJSMm9PVm83N01nS0c2UXdSN3pkdU45?=
 =?utf-8?B?UUVlbnJUcjRtSDMxUUJEV2lRMTcrQ0RJd05ramNJNW90TThrWS82SzBGNEFJ?=
 =?utf-8?B?S3RTaXlWY1ZQSDkzVzdCaWRLNndob0oyS1JGWmFrcldhSDEyQmJSOHVidFdn?=
 =?utf-8?B?ZlFPVFhkQllXck45WXdqcnNVZW15UzFSbkdGT0FxUkx6cEVCcm1kSXk2MVhp?=
 =?utf-8?B?UXBLMjNvMDh5VWZ6R0VOOFErWEdiK0g3S0ZuVmQ5R1Yrc01XVFNYN1RWdWQr?=
 =?utf-8?B?RGlnQ1l0NFNGYmpybHFSNVp2YmFBZHBTQXA2QjZCMUVTdjRDWk1seHNzSmZY?=
 =?utf-8?B?U2ZQMFpDMENtWXdHZzRZSlRTRHY5OUZ3STNlOTZ2MnArdUxXajQxMGtIcUFo?=
 =?utf-8?B?MUZrWktUSndPMittK0xERmp3TmZXV1BLeDZ0ay92ejNEb0N6WUdyWngyQ0lE?=
 =?utf-8?B?cDVTaWN5SzZwYy9XdHVhVTl3UEt3TmxCRUYwbk1NL29kcDJLeW51N08wZHFM?=
 =?utf-8?B?QlNzdHJsZnlueTl1dzVCQkJDd3BPekJiOHdkRGpYK3Ntd3B0aDVKeDR6YXFS?=
 =?utf-8?B?c0JyZTY5WVpNKzVzL3hsZ3hxSTZzeFlya2p4di9HemxvdkR1TmwwZjFWNWpR?=
 =?utf-8?B?a09obkZpUTBJZGMrcGxWSExDaDNjOU5iZG1xb2UrcWJVQWdqMW5yVGRYRFZk?=
 =?utf-8?B?bVBpMUNESG5KL2ZCaVFDZUJPWDlHT0gweDlTb0lJTnpsV2xEZ0xUYytlLzJG?=
 =?utf-8?B?OEpWdXVRb0VZSWpjS1poWC8vK0JBUnBBakhkbzFEQ285NHNJaTNWaTJJL3p2?=
 =?utf-8?B?emFvbXczU1o0UGwxMDR3cVB0YXcyUHJpNktQYTVEQWplNFpzOFpaWFoyVXdU?=
 =?utf-8?B?UmRZSmM0WWVpWGkyV0JXZ3psRm9JV2ZGSTdDOTVxczlPL01IbkVLMUlOOThi?=
 =?utf-8?B?S2VIdEJYcCs1dWd5SEV1bHJoRzhJTWZFdlVVTHVXNVJ6SStxZTRpZnVKQ0NY?=
 =?utf-8?B?bTc3SnJtSnlTSlR4VVZsMjd3bFYyWUJCWGNlS1VEb3o2K1E0QkdPRVZGcDBH?=
 =?utf-8?B?Qis3bGlEN0FEc2ozdG5jMXRUWTdQSzNLcEdTWE1kZW9sN1hHTkVvS3F3VDBl?=
 =?utf-8?B?YWhPWkZFWmFidWpaUUhQMC9nNVF5c2FjeDdmUWNZdUdZQkhZM0RlOCtTSTJF?=
 =?utf-8?B?QXVOK1hJdmJPQjkzdFZCM1liNWVueDBrbVptTFhOb1p0TUpWWGo5TXowOW8w?=
 =?utf-8?B?cjVNUHk1TGgyTDNiUkQrUnNrNVhsN2MyQUsrUkt6TFdXaDBKcTJkMHpCSWs1?=
 =?utf-8?B?Wis4Z0VqY1QvSUxqRUhlVTlVb2VvN2FXL0xoclNMUm93YmdjN0xoMmRBeVFR?=
 =?utf-8?B?MDlWd2hnTFFqY282MGp5M0NGeHJRTC9Qb0Q0MUNCY2ZYVWJ4MEJqSVVkVlQy?=
 =?utf-8?B?bWNDcUhWQ2JxNlJYOTNZZXdMNnN5S290M2NRZWY5a3RYZnhwRCtGUlBiQzcw?=
 =?utf-8?B?dG1hUjZwKzdZYkFrSC8zL3ZUSDEzZVI2eFoybHFRYkwxM094b1pJdUo4WXdV?=
 =?utf-8?B?RW9vOU9rcElIUkFnZEFJb2ZGdjZoN0o1WVpFYm5iK0xBb0g1WldyYThIM2c1?=
 =?utf-8?B?QkVHUDNqZTNFTUZwa3B6alA1K09zV1d3djEzS0Q3UHd3dkNtcml5aFByOHJw?=
 =?utf-8?B?Tkwzb21RT29NM2lXOFlYSzkvMXRCdW5VY3hKeUxLRFVqN1NFVEVra2ZhMzhP?=
 =?utf-8?B?SnRSWDN4WWRRSENjQUxROFRtc1BoZEtqWVZOS0w5cG42R2NuZUpCVG0yclY4?=
 =?utf-8?B?dlhiKzRQb3dKanlGRkV2MndtSFY5ZzZ0bFNCdlB0SFZ2cWgyVnpBR0RGa1Rl?=
 =?utf-8?B?MVljaVl5WlZ1M1VIazBoL2VrQWM4VjBlTFZ1d0w3eUlQaitwL2NiL3Y1a2Vv?=
 =?utf-8?B?clo5blcwTmEvS0x0aEd5K3pVVnMwcnNuVlJXZk85aWUySnZvV3Q3SzdWRHNs?=
 =?utf-8?B?OUpibGlRUTAxcityZWM3aUJUNEVJdlJHTFYyelJURkFZSDVVOVkrQ2JtV1RF?=
 =?utf-8?B?S2pPWW5ZU2NUODNGK3RxYVEyZHhHNjJWZEM5WGZ4TGFlY2U1VSsxM2FNQmgv?=
 =?utf-8?B?ZkM0bGJGencwbEJpbWVJcWJxQndnSnY1TEpmbSs1MHNYQUh4UWlUU29YdS9l?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7512DFAD94B0F04299D8262F69C126B9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df10e00-7fcc-493b-8620-08dcbc6d8fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 14:29:52.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktteN6wxRI9Yg1pbHfA2krPKuoCbK6+RJWhIGm8t/bdiZayAwU2y+ku0n5SI314VqQwLsKsBI6eRsBPDJkdVpoDVspWhLP099xbCMl1brGWXN2azmpeU+3AYA7VAwFeF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9150
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB9PR07MB9150.eurprd07.prod.outlook.com

DQoNCkxlIDA5LzA3LzIwMjQgw6AgMDg6MzAsIE1heGltZSBDaGV2YWxsaWVyIGEgw6ljcml0wqA6
DQo+IEtub3dpbmcgdGhlIGJ1cyBuYW1lIGlzIGhlbHBmdWwgd2hlbiB3ZSB3YW50IHRvIGV4cG9z
ZSB0aGUgbGluayB0b3BvbG9neQ0KPiB0byB1c2Vyc3BhY2UsIGFkZCBhIGhlbHBlciB0byByZXR1
cm4gdGhlIFNGUCBidXMgbmFtZS4NCj4gDQo+IFRoaXMgY2FsbCB3aWxsIGFsd2F5cyBiZSBtYWRl
IHdoaWxlIGhvbGRpbmcgdGhlIFJUTkwgd2hpY2ggZW5zdXJlcw0KPiB0aGF0IHRoZSBTRlAgZHJp
dmVyIHdvbid0IHVuYmluZCBmcm9tIHRoZSBkZXZpY2UuIFRoZSByZXR1cm5lZCBwb2ludGVyDQo+
IHRvIHRoZSBidXMgbmFtZSB3aWxsIG9ubHkgYmUgdXNlZCB3aGlsZSBSVE5MIGlzIGhlbGQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgQ2hldmFsbGllciA8bWF4aW1lLmNoZXZhbGxpZXJA
Ym9vdGxpbi5jb20+DQo+IFN1Z2dlc3RlZC1ieTogIlJ1c3NlbGwgS2luZyAoT3JhY2xlKSIgPGxp
bnV4QGFybWxpbnV4Lm9yZy51az4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NClRlc3RlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8
Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L3Bo
eS9zZnAtYnVzLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51
eC9zZnAuaCAgICAgICB8ICA2ICsrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9zZnAtYnVzLmMgYi9k
cml2ZXJzL25ldC9waHkvc2ZwLWJ1cy5jDQo+IGluZGV4IDU2OTUzZTY2YmI3Yi4uZjEzYzAwYjVi
NDQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvc2ZwLWJ1cy5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3BoeS9zZnAtYnVzLmMNCj4gQEAgLTcyMiw2ICs3MjIsMjggQEAgdm9pZCBzZnBf
YnVzX2RlbF91cHN0cmVhbShzdHJ1Y3Qgc2ZwX2J1cyAqYnVzKQ0KPiAgIH0NCj4gICBFWFBPUlRf
U1lNQk9MX0dQTChzZnBfYnVzX2RlbF91cHN0cmVhbSk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIHNm
cF9nZXRfbmFtZSgpIC0gR2V0IHRoZSBTRlAgZGV2aWNlIG5hbWUNCj4gKyAqIEBidXM6IGEgcG9p
bnRlciB0byB0aGUgJnN0cnVjdCBzZnBfYnVzIHN0cnVjdHVyZSBmb3IgdGhlIHNmcCBtb2R1bGUN
Cj4gKyAqDQo+ICsgKiBHZXRzIHRoZSBTRlAgZGV2aWNlJ3MgbmFtZSwgaWYgQGJ1cyBoYXMgYSBy
ZWdpc3RlcmVkIHNvY2tldC4gQ2FsbGVycyBtdXN0DQo+ICsgKiBob2xkIFJUTkwsIGFuZCB0aGUg
cmV0dXJuZWQgbmFtZSBpcyBvbmx5IHZhbGlkIHVudGlsIFJUTkwgaXMgcmVsZWFzZWQuDQo+ICsg
Kg0KPiArICogUmV0dXJuczoNCj4gKyAqCS0gVGhlIG5hbWUgb2YgdGhlIFNGUCBkZXZpY2UgcmVn
aXN0ZXJlZCB3aXRoIHNmcF9yZWdpc3Rlcl9zb2NrZXQoKQ0KPiArICoJLSAlTlVMTCBpZiBubyBk
ZXZpY2Ugd2FzIHJlZ2lzdGVyZWQgb24gQGJ1cw0KPiArICovDQo+ICtjb25zdCBjaGFyICpzZnBf
Z2V0X25hbWUoc3RydWN0IHNmcF9idXMgKmJ1cykNCj4gK3sNCj4gKwlBU1NFUlRfUlROTCgpOw0K
PiArDQo+ICsJaWYgKGJ1cy0+c2ZwX2RldikNCj4gKwkJcmV0dXJuIGRldl9uYW1lKGJ1cy0+c2Zw
X2Rldik7DQo+ICsNCj4gKwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BM
KHNmcF9nZXRfbmFtZSk7DQo+ICsNCj4gICAvKiBTb2NrZXQgZHJpdmVyIGVudHJ5IHBvaW50cyAq
Lw0KPiAgIGludCBzZnBfYWRkX3BoeShzdHJ1Y3Qgc2ZwX2J1cyAqYnVzLCBzdHJ1Y3QgcGh5X2Rl
dmljZSAqcGh5ZGV2KQ0KPiAgIHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2ZwLmgg
Yi9pbmNsdWRlL2xpbnV4L3NmcC5oDQo+IGluZGV4IDU0YWJiNGQyMmIyZS4uNjBjNjVjZWE3NGY2
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NmcC5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvc2ZwLmgNCj4gQEAgLTU3Niw2ICs1NzYsNyBAQCBzdHJ1Y3Qgc2ZwX2J1cyAqc2ZwX2J1c19m
aW5kX2Z3bm9kZShjb25zdCBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2RlKTsNCj4gICBpbnQg
c2ZwX2J1c19hZGRfdXBzdHJlYW0oc3RydWN0IHNmcF9idXMgKmJ1cywgdm9pZCAqdXBzdHJlYW0s
DQo+ICAgCQkJIGNvbnN0IHN0cnVjdCBzZnBfdXBzdHJlYW1fb3BzICpvcHMpOw0KPiAgIHZvaWQg
c2ZwX2J1c19kZWxfdXBzdHJlYW0oc3RydWN0IHNmcF9idXMgKmJ1cyk7DQo+ICtjb25zdCBjaGFy
ICpzZnBfZ2V0X25hbWUoc3RydWN0IHNmcF9idXMgKmJ1cyk7DQo+ICAgI2Vsc2UNCj4gICBzdGF0
aWMgaW5saW5lIGludCBzZnBfcGFyc2VfcG9ydChzdHJ1Y3Qgc2ZwX2J1cyAqYnVzLA0KPiAgIAkJ
CQkgY29uc3Qgc3RydWN0IHNmcF9lZXByb21faWQgKmlkLA0KPiBAQCAtNjU0LDYgKzY1NSwxMSBA
QCBzdGF0aWMgaW5saW5lIGludCBzZnBfYnVzX2FkZF91cHN0cmVhbShzdHJ1Y3Qgc2ZwX2J1cyAq
YnVzLCB2b2lkICp1cHN0cmVhbSwNCj4gICBzdGF0aWMgaW5saW5lIHZvaWQgc2ZwX2J1c19kZWxf
dXBzdHJlYW0oc3RydWN0IHNmcF9idXMgKmJ1cykNCj4gICB7DQo+ICAgfQ0KPiArDQo+ICtzdGF0
aWMgaW5saW5lIGNvbnN0IGNoYXIgKnNmcF9nZXRfbmFtZShzdHJ1Y3Qgc2ZwX2J1cyAqYnVzKQ0K
PiArew0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiAgICNlbmRpZg0KPiAgIA0KPiAgICNlbmRp
Zg0K

