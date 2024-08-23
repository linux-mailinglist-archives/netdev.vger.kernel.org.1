Return-Path: <netdev+bounces-121205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDA95C2D1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D816E1C21239
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304991755C;
	Fri, 23 Aug 2024 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Go6yB2ct"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71C171BD;
	Fri, 23 Aug 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376669; cv=fail; b=ZISPVV5P9XKtLT6KYGfYAQ5W+Y9oR8a+iXj2W1dyCF2diKp+xH5JL6/S9/qfV0+mLynQiI4Q1yjvGFwjhWbXBBWg+FQ+SHelY+WD1L5kJh+otXFHvUm9MH9Yu9yvIkPY+Jxp6i+KI2guokk0IrE9qNU2TStmeOYgeMUApUVLcTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376669; c=relaxed/simple;
	bh=1rhlbOzOhs1MTlEMZgRhylkbDEvk2JSDZGKs8wK2ZnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzlMcV4v32J7owY0QyL9lD8n7Qm7AJwU4yjI5aXNU5wDWdyoP/c/TgJ68am9qfNVZ3uwgJpKaOD0d/lkID5B54xWM/P6UmxkOnugEZyyO4OhWazf7Zl4H1tbX+PqocFVKLwC/yw+7qnArOAEtrzeul9NPngZbDK4SiTQZ57MvM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Go6yB2ct; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s07BXTbYY65qKQv1zNY6/4C80lTKnwj0YFAreZc0Jqlm7/96bBEy7vx1DAawB1GVNBEyQYNHF0Lo88kqSKRkgs37p4myult5e5u89PkWU2hYPqDqMfz+JS0ObUPrTS4Pr65iaIERAvKWstJEUJCXp8558ZqW9lG9a0DuuCcVxh31oG4ATFLlqDfPt7tMczXr5Zy2DjsOy/IEKk79I/92IZQpAg8xB+ZqGWG/VbMZnC+/kBq2VocuLRqcKbgz70C4OUGj88dxWsp1bAWPxiayN/zDYjY9XbXe1GI0aL+l2Fxo8VsjnzIfC7ob8V0aDUiB7MphLwr1h3COqKgHERuLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rhlbOzOhs1MTlEMZgRhylkbDEvk2JSDZGKs8wK2ZnM=;
 b=KmYOdQA1pLG9ffQM4ZYgMJVDu4NOF30+RB5OfZvojS3CB8i3+GNBwNvISMS3I41/oPZaN03qCOu+ZqCYhUanJg9MEgOQ/FyeRd/Z7vR/tzLd36q59qaj84e9A0XuKG2y2EQE+TNTSCnwIricXrGI+9GEkRuY1mzK9EumC4Js4RJ0K1w6pz5zlVuipwKmtCmRYTfDzQdSXzNE2jg//qfNHwatur1OnmxG5BU0wsAW1OKcYgNGfc1WzbVfXQBiFJM1iYZ2wzI0cXJ6E658Ht0XXmqxeq69HgCB+U3agGRzD3VwhhxB1WT3DVWsMgtxTq6YWk1qUwTE1tqL5zwCJqyjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rhlbOzOhs1MTlEMZgRhylkbDEvk2JSDZGKs8wK2ZnM=;
 b=Go6yB2ctzckRHO8hBy5nTUwLG2dfSnrCDftJqlZa4Pslw0vhHTSzZ1+4/TBhBjmu3TxGsYm1f/QTaJvE5GbZi/IbOzcrCXuqtKZE4ryuAEm/oSk3IJ94sITPa8pCoEFjYm+Wy33ILzeC5Mu/fR23qndO8DEj+siJ7j5/vQiw60/AvbWvPTor306kfJt/8RvvXpaxj5OY/HgMacuCvAmbI6dEQjIuTY4qISm8n9fNdn95rNOycLKAQROgGab3ifDVVAGeJp90uNBJ0lHaj+THTWMzGIHjVV3iMmyp4/FUdQisaMUc4+6QB2m8JAXnrbbaLHsTHKBz74dMHiIK1q+2TQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 01:31:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 01:31:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Thread-Topic: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Thread-Index: AQHa9DXVYWkEv9kTy0yrZnxZHkT8jLIy90mAgAAJVVCAAHOVAIAAmEzg
Date: Fri, 23 Aug 2024 01:31:02 +0000
Message-ID:
 <PAXPR04MB85109CB5538707701F52246E88882@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240822013721.203161-1-wei.fang@nxp.com>
 <20240822013721.203161-3-wei.fang@nxp.com>
 <20240822-headed-sworn-877211c3931f@spud>
 <PAXPR04MB85107F19C846ABDB74849086888F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240822-passerby-cupcake-a8d43f391820@spud>
In-Reply-To: <20240822-passerby-cupcake-a8d43f391820@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10991:EE_
x-ms-office365-filtering-correlation-id: 4c065af1-7506-4a4f-185a-08dcc3134026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHlEL1o4eWMyQ1pBNEplOTFLNGdmL0VKU3VNRHlLMUFENnJEd3kvOFUrQXhp?=
 =?utf-8?B?NWJaWG9EMzZrQ21mM3NjUUJ4YVFvSHJNQkZHSHJYK01vRk0zWmlTV2VuSWhC?=
 =?utf-8?B?ZHduRXEvS1J5R1lidnI0azlnbW9hc1UwaWw4c3pYUXBWemxCUGdLcE93MVNu?=
 =?utf-8?B?akcrMUlQOFFRV0ZmYWh5S0dnY1dxZUplMnBPYjNWbzBVTERiQVR1NlZSSS9T?=
 =?utf-8?B?QU16bWQ1NTJ0SVFoTTA3eEYxWEZFLzBSMmhXQUcxRHZjWlBCbk04dzgvN002?=
 =?utf-8?B?dGg5Zjh3VC9kZ3d3VzExMmtyejFENXdIQStPeU9Xcm43aXp5K25iT2ZpZ0hn?=
 =?utf-8?B?U3BvSkhnS01jWk9rd1ByY3hJTFZaQ0poRmZMMUlnRnJPL3U5UHgxeStramgr?=
 =?utf-8?B?OFZsa2MvVDlZN0VFSnphRDVGS3RPdHRFY250c0QzOXdsTFF4cVlFbTQrQTZZ?=
 =?utf-8?B?eDNIRWcvYTJzQ05RNmc0dDF2R09qSEJwQnhISTBVcUZKcDgzckJrYTFNdXJK?=
 =?utf-8?B?VWdlQ0FySk5QWWloaHplSXBkVWVEQkZhK3NYMmJVckx0YW9udTc3cmVIa2Jl?=
 =?utf-8?B?SG0yZXZiUFdNSEt3OXpVYlo5aTMzYjJOZWlEWXhxdTZ6YXRneEhvdnlBd3M1?=
 =?utf-8?B?QzJUeGJWWmtHL09vbHMyRytLT1NsZ2JpSmp0RUF3RjFnY1NVc3FsTUtGSUZN?=
 =?utf-8?B?NHhYWWtGSHdkVFhQT29MOEFPRXNuRjVRQkd5SG5aZTVzeUJ4N2RKV3hOb25s?=
 =?utf-8?B?b3pnMkovdjB0eXErdmJSanE2clJhUmlNUllna08vNHc4U0V4eEF5ZlIvU2FY?=
 =?utf-8?B?OW9sOXBQaFpXOU1SZmlEd0wxZmVXQ3RmQzNyV1VBKzRONEJvSXNNaERzL2Y4?=
 =?utf-8?B?UmszRVUxUzhnNWQ1dXRxeC96alpRLy8rM0ozdFNQTk5KYWNiZWQ1VmpHQ292?=
 =?utf-8?B?T1A2cDhqR0ptcUNWc2pyaUFTbFl6UmdIaCtUWUZvaU9IYk9TYmZ2NGF2Nm9n?=
 =?utf-8?B?UGxEZTBzeDBwd3VmSlBxVUg5eko5ZnE4RmkxYzVRRllZRTZnS3JwL3lDVUtC?=
 =?utf-8?B?RDdzMEQ5a1plSzBHN3ZuQUFlMVNTMUdIUkNDc2luZElWZG1pUWpBVFV6ampn?=
 =?utf-8?B?UkwyZGNBRm9MOE16VS9yeTRWWmNoMUt6Q0I1MUFxaW9wSEN0QW5XanRna3Ba?=
 =?utf-8?B?SEdQdmh0VUhPWGtDUnpPbENtYm00RmR4dThTSmRrRElScmhtMGhBUnhJUVpV?=
 =?utf-8?B?bm9vRmpOZDJwd0ZWMjB1WGFzNDNYcjh5ZEo0SHh6VGxwOVFyRFhhd1hodnNN?=
 =?utf-8?B?bStJclM4TXB1MzhOU2lBVGd0VE83TW5nWWVMdk5PUy94UFZGRVIyTzdsTFpr?=
 =?utf-8?B?R1Y0MXI4Z2FnQkRDbkNBWkFvdXJGZ0VkcFpCV2lGRklzMkJ0aXdhOUxkRjRM?=
 =?utf-8?B?NmhTNit2VXRDTWplZm1WaGxmMU5YcStnRVFnZVNRQmpLYWpaTnJCQ29xODMx?=
 =?utf-8?B?OUpDTis2RGNIV2JUU0Y1K1BRUHVWNEtGVVkvaWd4eWk2L20zVTNDcUMzd1JU?=
 =?utf-8?B?QTVIaSt5V0N4bVRGK3laR2taVWJMcWI4R1lDOXZRUlNxMkVQTExGQUZvV1Rn?=
 =?utf-8?B?YVpjNS9COGZOMDNGOFRGSGdGREh1eHIybEZoOHpPV1o2Q3pBRTh4MFgyUXhB?=
 =?utf-8?B?K3BJMzVkbmlYK1dyNGNXbVl5Z0FBQ0xuOXhmRldYdnl6U2NFSkdnYVhSRktr?=
 =?utf-8?B?Q1hXUnhsa012M1NCUTNORFdlQy9wWnBqWTJUeFhGZ1BnVm1mWVA4c2ZYWnpy?=
 =?utf-8?B?SHpxc2pPVGJQR1d5VC9oNXMxYkRLNm9kTXo3bmdVdmRsUWxtcEp6UlE5SVRk?=
 =?utf-8?B?N2JwYnNGdHd3UldMQ0dRdEZoYnljd1JtN01idnVyajRxWHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnBuWTVZSW8wSi9STUJGOUlmVFhEZFR1cDc5Zmt0OUNpWm95b2NSQStHRnNa?=
 =?utf-8?B?N1JxU3dLSnpIeHdhWHkySTYzYWhudUVVb251RlNHam1vUXRvUW9iOEo2UEFa?=
 =?utf-8?B?cVRXTE5lclpQMVU3Q1M5eERIaTE1Z3JUWlZKOVhzQUR4SGZhOHVPNnJTejll?=
 =?utf-8?B?anFNWW9Eby9HMzBYYlBDcnlsYlErZVJtbVJNQnFEY1psSFlHWFZaRkZCZ25W?=
 =?utf-8?B?UUhOYStMNlR2a01ibVJGMjlJcHdWdkIwbEowRjhYdHFZNzdBMloyOS8xZ2RE?=
 =?utf-8?B?WVpHMW9yM3lFWVdkS3JYcDE0N2VKSG5NUURkbFdoRURzWCs0Q3JodU5WNmNm?=
 =?utf-8?B?eUFFRFh1OSt5ZDNOZjBGamJqRWRObWZzZmo3UXRHWExSa0NWREZia2g1T1JW?=
 =?utf-8?B?SEVUUEtWUExoSkdMRGQ2aWt5alJCb01LNXJOTHFxT0E0QlR5TGZFSGhaWUZx?=
 =?utf-8?B?K1prQSs5YWh5Sml0bkdXZFNOSGc5VHRubkQ2U2NFMTFmTDJXSFJWK0pQYVJQ?=
 =?utf-8?B?RFNLVE4vZ1pqU1gwbFg5eXJYUm1ScEVWM1V4QWVraTZlK3gxTTkvUTFUL0li?=
 =?utf-8?B?TDUrWGR4eU5VdUlKcGFTcmFvc2pGWnNTa3pDTVd4cmh3cU5Zbmx5Y2VwY21u?=
 =?utf-8?B?eVpzQkw5UTdxWmFWMXlmbWZybWdHOUkxQ3o2S1pGSVJiWnNmQldvaExiWmJO?=
 =?utf-8?B?ZklCSk02SWVDb3Bpb1p5dUVLcGdaVlNnMjRzNEtTSlNzcWdNY2k3M1h0akI0?=
 =?utf-8?B?QTJ3OTUxZTVkY2hsQ3BCWVZ3TVFBS1dXSzdmRmpUNjErcDQ4emlFY3YwR0Q5?=
 =?utf-8?B?K1FWc2c5S3FqYVVsSjRRSDR2NVNBcHp0aS9OQkZGd1RwVzFDZjRLN0g3ejJC?=
 =?utf-8?B?SWZ0YndQWHVNYkRFTUdZQjFXMEJVQ2t6S3Vkams0QU9naUk2OXZUbEdBU1cr?=
 =?utf-8?B?OHNTZ2NZVWZpQ1V1NG0rcGdxS3VtVXEyMUdOVkRrNWhHYktsMGFNODMyVjhm?=
 =?utf-8?B?VDlSNnNVakFtQWl0OUdkYXpxbUlrL1paSTNWUm5aYWVBRDRYUEpGYXBPWEVr?=
 =?utf-8?B?TElhVkpYcXRKeldWRTR0WmpBSFY4cWtBWjFHNWpEMVM5K0dFQ3RNNndLRTY2?=
 =?utf-8?B?a0EvZkxUeG14Uk9sV2F5cElmcW0wQlprN21oTTJWQ01yNjQ2UWFzeUREbHRB?=
 =?utf-8?B?SldROGFHeW9FSEJCaGpkU0pEWlpzZ3gzaXFvRUxOTmhTeHFQWWlyUzU4WExj?=
 =?utf-8?B?dnhRNjYxdkNPS0dXYXZuVEVLOGpzYWtuMTlIRlUzcWhHb3FYNEllNk1COS82?=
 =?utf-8?B?aTJDSGM5d055TnU5SitTN3k5c0V4R1VhbjBKajlrcnR3bFdIanAzaERJVzVm?=
 =?utf-8?B?QXF4WDg0bktNaWZwZWVFc3o2Vit0SUtSeFlMVWpiY1RSK3prc3VQK0RoN3BE?=
 =?utf-8?B?aFErRHg1dFdOWG5VQnRwV1FYQU9kZ2Y1V2FYNi8rM3hUVGc1b2FZR3RPaXpt?=
 =?utf-8?B?VWYxaEhqZFpscm1JU1BacEV3dGVycTRzc1d1WGg1REVjNmJxREtxRW4zTVAw?=
 =?utf-8?B?MWhBSTdxQUZzZ0ZJNHUzZFpTQ1pzMWVRRy9WUDV2NzZVZ0tCNTFRV0ZXTmpN?=
 =?utf-8?B?dkM0VjRITDM4eUcrVUlXbGN5ODdxQ1ZNRnlxc2JZVTNNNTBWS3pvdG1ZVHBo?=
 =?utf-8?B?WVVUaVpEcFpHTmVlalV2QjJvQXpCRmJqMVQyUjhLNlNMSndLSUUxbGFXeUla?=
 =?utf-8?B?Um9CZnBacXArMTlhRmdYQkJxTkdJZmkxWGwyUjZqSGFzWSswYTJIUDlYeFgw?=
 =?utf-8?B?OWsrU3k0OHlMdkRhYTlIRjZ2TmUxRjEvYUFvUnNYWTFUdUhWY05HbG1RVFp1?=
 =?utf-8?B?RzNKV1J2cFFWdjM3S2xSeDVoMlg0cnkxajVzMk9LSHVZcUZIRzFWQXp3aElI?=
 =?utf-8?B?MnZWdkRmazhXaWlhdmZScFFGWVZ6MWdpK1prYlVYbjFOVEVrdlAxS2g4WDJ6?=
 =?utf-8?B?dTRSL0lIZTIyL3l5bEpLRGZlR2FiV3E1MGtJbFQ4MjRGd09mWWhPZ2ZTSC9o?=
 =?utf-8?B?cWFXTWkvclprNUxrR0o1RkwxTFg1RzFqM0RhSUZoOUFMSE9pTTZTSmk2TUFS?=
 =?utf-8?Q?C7Z4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c065af1-7506-4a4f-185a-08dcc3134026
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 01:31:02.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHjG5SDBFeY7osNEeH1n72RuXW7Mwp8Fn4gqdyTSGsJGFPc9wxcOFvXqJ/JnWUeaZQ27w//7HJrfVM+jvEb6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ45pyIMjPml6UgMDoxNA0KPiBUbzogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpl
dEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsg
YW5kcmV3QGx1bm4uY2g7IGYuZmFpbmVsbGlAZ21haWwuY29tOw0KPiBoa2FsbHdlaXQxQGdtYWls
LmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpDQo+IDxhbmRy
ZWkuYm90aWxhQG9zcy5ueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzNdIG5ldDogcGh5OiB0amExMXh4OiByZXBs
YWNlDQo+ICJueHAscm1paS1yZWZjbGstaW4iIHdpdGggIm54cCxwaHktb3V0cHV0LXJlZmNsayIN
Cj4gDQo+IE9uIFRodSwgQXVnIDIyLCAyMDI0IGF0IDA5OjM3OjExQU0gKzAwMDAsIFdlaSBGYW5n
IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IENv
bm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjTlubQ45pyIMjLm
l6UgMTY6NDcNCj4gPiA+IFRvOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiA+IENj
OiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7DQo+ID4gPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtl
cm5lbC5vcmc7DQo+ID4gPiBjb25vcitkdEBrZXJuZWwub3JnOyBhbmRyZXdAbHVubi5jaDsgZi5m
YWluZWxsaUBnbWFpbC5jb207DQo+ID4gPiBoa2FsbHdlaXQxQGdtYWlsLmNvbTsgbGludXhAYXJt
bGludXgub3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpDQo+ID4gPiA8YW5kcmVpLmJvdGlsYUBv
c3MubnhwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzNdIG5ldDogcGh5OiB0amExMXh4OiByZXBsYWNl
DQo+ID4gPiAibnhwLHJtaWktcmVmY2xrLWluIiB3aXRoICJueHAscGh5LW91dHB1dC1yZWZjbGsi
DQo+ID4gPg0KPiA+ID4gT24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMDk6Mzc6MjBBTSArMDgwMCwg
V2VpIEZhbmcgd3JvdGU6DQo+ID4gPiA+IEFzIHRoZSBuZXcgcHJvcGVydHkgIm54cCxwaHktb3V0
cHV0LXJlZmNsayIgaXMgYWRkZWQgdG8gaW5zdGVhZCBvZg0KPiA+ID4gPiB0aGUgIm54cCxybWlp
LXJlZmNsay1pbiIgcHJvcGVydHksIHNvIHJlcGxhY2UgdGhlICJueHAscm1paS1yZWZjbGstaW4i
DQo+ID4gPiA+IHByb3BlcnR5IHVzZWQgaW4gdGhlIGRyaXZlciB3aXRoIHRoZSAibnhwLHJldmVy
c2UtbW9kZSIgcHJvcGVydHkNCj4gPiA+ID4gYW5kIG1ha2Ugc2xpZ2h0IG1vZGlmaWNhdGlvbnMu
DQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBleHBsYWluIHdoYXQgbWFrZXMgdGhpcyBiYWNrd2FyZHMg
Y29tcGF0aWJsZSBwbGVhc2U/DQo+ID4gPg0KPiA+IEl0IGRvZXMgbm90IGJhY2t3YXJkIGNvbXBh
dGlibGUsIHRoZSByZWxhdGVkIFBIWSBub2RlcyBpbiBEVFMgYWxzbw0KPiA+IG5lZWQgdG8gYmUg
dXBkYXRlZC4gSSBoYXZlIG5vdCBzZWVuICJueHAscm1paS1yZWZjbGstaW4iIHVzZWQgaW4gdGhl
DQo+ID4gdXBzdHJlYW0uDQo+IA0KPiBTaW5jZSB5b3UgaGF2ZSBzd2l0Y2hlZCB0aGUgcG9sYXJp
dHksIGRldmljZXN0cmVlcyB0aGF0IGNvbnRhaW4NCj4gIm54cCxybWlpLXJlZmNsay1pbiIgd291
bGQgYWN0dWFsbHkgbm90IG5lZWQgYW4gdXBkYXRlIHRvIHByZXNlcnZlDQo+IGZ1bmN0aW9uYWxp
dHkuIEhvd2V2ZXIuLi4NCj4gDQo+ID4gRm9yIG5vZGVzIHRoYXQgZG8gbm90IHVzZSAiIG54cCxy
bWlpLXJlZmNsay1pbiIsIHRoZXkgbmVlZCB0byBiZQ0KPiA+IHVwZGF0ZWQsIGJ1dCB1bmZvcnR1
bmF0ZWx5IEkgY2Fubm90IGNvbmZpcm0gd2hpY2ggRFRTIHVzZSBUSkExMVhYIFBIWSwNCj4gPiBh
bmQgdGhlcmUgbWF5IGJlIG5vIHJlbGV2YW50IG5vZGVzIGluIHVwc3RyZWFtIERUUy4NCj4gDQo+
IC4uLmFzIHlvdSBzYXkgaGVyZSwgYWxsIHRqYTExeHggcGh5IG5vZGVzIHRoYXQgZG8gbm90IGhh
dmUgdGhlIHByb3BlcnR5IHdvdWxkDQo+IG5lZWQgdG8gYmUgdXBkYXRlZCB0byByZXRhaW4gZnVu
Y3Rpb25hbGl0eS4gR2l2ZW4geW91IGNhbid0IGV2ZW4gZGV0ZXJtaW5lDQo+IHdoaWNoIGRldmlj
ZXRyZWVzIHdvdWxkIG5lZWQgdG8gYmUgdXBkYXRlZCwgSSdtIGdvaW5nIHRvIGhhdmUgdG8gTkFL
IHRoaXMNCj4gY2hhbmdlIGFzIGFuIHVubmVjZXNzYXJ5IEFCSSBicmVhay4NCj4gDQoNCk9rYXks
IHRoYXQgbWFrZSBzZW5zZSwgIm54cCxybWlpLXJlZmNsay1pbiIgd2FzIGFkZGVkIG9ubHkgZm9y
IFRKQTExMDAgYW5kDQpUSkExMTAxLCBhbHRob3VnaCBpdCBkb2VzIG5vdCBzZWVtIHRvIGJlIGEg
c3VpdGFibGUgcHJvcGVydHkgbm93LCBpdCBjYW5ub3QNCmJlIGNoYW5nZWQgYXQgcHJlc2VudC4g
OigNClNpbmNlIFRKQTExMDMvVEpBMTEwNC9USkExMTIwL1RKQTExMjEgdXNlIGRpZmZlcmVudCBk
cml2ZXIgdGhhbiBUSkExMTAwDQphbmQgVEpBMTEwMSwgd2hpY2ggaXMgbnhwLWM0LXRqYTExeHgu
IEkgdGhpbmsgaXQncyBmaW5lIHRvIGFkZCAiIG54cCxwaHktb3V0cHV0LXJlZmNsayAiDQpmb3Ig
dGhlc2UgUEhZcywgc28gSSB3aWxsIHJlbW92ZSB0aGlzIHBhdGNoIGZyb20gdGhlIHBhdGNoIHNl
dC4NCg==

