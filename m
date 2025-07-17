Return-Path: <netdev+bounces-207822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B23B08A76
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7027A6C0D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8528FFE6;
	Thu, 17 Jul 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxj4T1YQ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3271C84DF;
	Thu, 17 Jul 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747999; cv=fail; b=gXEDLtv6i8s93GaDHPuPHJYqN/QdvwjEhl2BMtwU7uEE664Rp2M2ZkoLfnvB+lgDpyOoaevWbAjOSfkUX+YNoFdl6boaatcLYDE13sjs9EizNjaZ4DjkcgVviTi/cmtRFOEdF1WzC9+1GyFHtXJfKLNmyf+HLzqVcafTYkMxels=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747999; c=relaxed/simple;
	bh=nvnwmT7xpIO0hWgG+MB0sEZxoKUHGN+W16x5I7LI5ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m2tyLb9sSQCflA5eUzBzvkD6sIZl/UhU1JEKovUjUA0rgLQUxMMBXw74U6PkiDLWuPLhAJ5NJ43UwT+hPLvolJN0E4FiiitBzVRV/F3yM+jhIr8DRTyUVOPOipVUFIqtf/aNEaqIOkgQjUraQKRaU9BvVpQv+bvTZD55qCNFFD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gxj4T1YQ; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiPO6ZCacscAtlXwnZqsJrHfED8P3tlwqGWYEhM0dPobyKJhTQYirewFUifqw/Z3C+NFSF40YtUzFa0HuVyiBYS0Pr/1NX0nbOubueU1H5Rk4LtXNoVat4E599ZYcL/fPOZffWFXSbCtnXo/MUmRCPNaQz8sKvXgDMSMgExuYRc/KaSf+KQ23KKwLe8qS+diGrcKoWhafEl+VhQV9ZA4Fwe8kiPqTyWkE+cEzbuPqX9qW+nImOcdKdNqxPMguPbSK6kPivIOig82zDVeoc3ie7UpSWDZcq44BJpZEs1Mdo5adFeknS2LIJ8VpTWNoLBTyv05jTVnXi+bgdGH4hvhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvnwmT7xpIO0hWgG+MB0sEZxoKUHGN+W16x5I7LI5ww=;
 b=tXKodB4fHYzo6gBGsH7uQ5utJr+Ix6lT3DDmmxRxne+7E1QsOGydsdi3dlkys6s84VnFx36hD/+aqkgTiSgkbv/8KxMV7ft/Fi965wjv6CwaerUZ83WgfzKCq+vQ4pHl5YdVkHbCquSZiXEt6SrykoDWA+ZDzWdRKL0/etD4rC6spyJovf+Yr5ysKKjiFRJkM8fejOsfkOn6Vuzo45eS2clSxygdYAbA69nd9nxJVAmbL4/v46ac2voFdAdEJoU4+NP0mvSS7nd0H9UJAaxj7Zdfg9Ny95Ins9vwe+HLA6WjkYL+jj/neBIxElpJJ0BnEETUeZJV/59W4Q82p7cG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvnwmT7xpIO0hWgG+MB0sEZxoKUHGN+W16x5I7LI5ww=;
 b=gxj4T1YQvwTuLbqJUNdZofZ7xDW5dDJhY6Z5eN71YS2fnfeGAGLOt+tlBU7cQMuJPh9XcgEE14hX4GrHOml0BgidO7XMCaUSbj4G+9A8RcN6+vnbTws4W32G787ZLDf5LlbdQUB0pA0zA9uTkxTrFrBhx8LYlsI7pHIG5qRPdfnbQG9xdLccljeRC2az+JxPMGvv9SFqimF7U4NgBuUILcvTuOOTJ1B09bXGF9pdS8G2SPlqsD5sxCiKIckMKZXkDxA64j+YigopiI6rWbSveU6wBoece6cWkuhKVUeuN1Kj4rWvjVVQpUU296vYCQkwL65YJKPE4m1J0foMB0XhWQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 10:26:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 10:26:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Topic: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Index:
 AQHb9iZmm/EQyWHMi0uUtvbMzlnJDrQ18GUAgAAJ0BCAAA9ogIAAAdxwgAANNACAAAF4IA==
Date: Thu, 17 Jul 2025 10:26:28 +0000
Message-ID:
 <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
In-Reply-To: <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7910:EE_
x-ms-office365-filtering-correlation-id: b6c6fe07-6dba-4caa-bcbe-08ddc51c6461
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmdpcUF4NUE2bWMwRTlRUmVZVi9nVXZCcU1xeURVSlFTZDVuY051U0xuaHVw?=
 =?utf-8?B?dGpYak5GalFsM2JPVy9VVVhnTE5acG52UWJGUlc3b2labGVLTEtoZ3lkWHFZ?=
 =?utf-8?B?OUo3OStZQzZmTlkwV1V1VTI4a1pHbm5DS0pIaVY0VDhOMitJVkgwZWhmSXJU?=
 =?utf-8?B?NGZ5ZkJLVS8yZFNvbTlrTFhsNk9NKzFOQ3dXeHN4NXEzdzF6UXBkT0VSV1VI?=
 =?utf-8?B?ZFRDVnBJRE5VWlg5dTd0aGY3M2lwTVRYVlpnQXNwRytxb1NmRVQvU3NxWlJw?=
 =?utf-8?B?ZzcwSGJzQTIrWjdCUmRrTDRGbnozWld1T0JXU1Uyci81STIvWXoxNEFCYXhR?=
 =?utf-8?B?RHdJWjJTS05jOE9qMmYxTVNvWGNtRUJaeWVQdEtwQlQ1OHhJZ0hiOGtYTG8z?=
 =?utf-8?B?K1pzRks1MitHemdKRkVEcmVoaG52SVBmOGhPMXlWOWpyazRXTDRrajh3RU1p?=
 =?utf-8?B?RWlscEpvalQwd3gxcUhub0lqUzdjaGVMYkJEK0NkUXAvY2d5elhzTXRBUEhs?=
 =?utf-8?B?YUJwY09BYjVqTjNQbTdWeUYyWmV4d0hGOFBMZFNJdUtIcDBMTnk0TmdSNVVW?=
 =?utf-8?B?dUorT0lXeFlkN2tCd2IwZHVQYTY1dGRhWXlZVlMyTGFBR2tDbWJDZ3FsNjhG?=
 =?utf-8?B?d3RyTXlRRWE1cjM5aXo2dWJRQkdiMEFKYk5INkUzRlhWcTdzWkhRdUlhWlhT?=
 =?utf-8?B?ZndhcnZpM00vNjZvNzBxU2YxUys3OW9DeERlTi84Z2l3Z1JWeFh5WUtKMmxq?=
 =?utf-8?B?TDNqdTE0SXVaYW1CTnp2ZXhKWmZRV1dLRlhXRkJRemlIOFNZeGEyVlJocm54?=
 =?utf-8?B?ZFBSb09DSVd5WE16RWF5RkEyaEhLcmdCVEl2b2RpYTZTSk41WWlxdnBUNDBP?=
 =?utf-8?B?YTk3MWw0R0JBYy96M1d4WFFZTTNPNmo1Q05DSHUxZFB5RUZiRklqaUdtR0Zk?=
 =?utf-8?B?OEIvcTRXcGd3Sk81bG9FR0g1bXc5WlhKOTl6U1VVeVVhZkVCTHpGTkw2MHdX?=
 =?utf-8?B?WTQvR0gxb2RUQXpCZ3FYMG5FOWRJcGd5YWxSeC8zQjRwTlpsY3RjWDY2L1pR?=
 =?utf-8?B?Smt5bnpsNC8rVXVHYlhTL1NLcldyVE5JYURXNVZYc2ZkRWRVZUNqUk1pVGdO?=
 =?utf-8?B?aElvZFVUVG9pLzVRRjFla3VsWS92SFdmYk16ZDFsY0hwbVJEc2hpSHJsOEVa?=
 =?utf-8?B?Y29TY2xBREdacC9ZOGZ2anlqTjdPaWszdzFrL29LaEJPQzBKTmtpR1JrTEZi?=
 =?utf-8?B?NTRYaHpBbzRKaFQvQVpBK1Vpd09EYXl0QVdDSWhTcXE3OWQ5UUFwa0xnOVdl?=
 =?utf-8?B?YytmZmFnOGUwTHJVdHBzTHA5Y2ZUdDBhaldPdWlnV1lpWGlKNDV0ZlhNQ04v?=
 =?utf-8?B?c2d6VHBBanVsdSttWnR2aktJOWVWRk9kSWo2UGNzc211bXU0U0VmdHpPNW1I?=
 =?utf-8?B?SVo0SnJpRDQ4a3I3N1BHRUt3S0RpVWZQT3duZElNMHYyK2MyWmR0YW9KeFp1?=
 =?utf-8?B?WjB4MTh6bFNqZlhxOVdTT1hSRit6QlFRaTF5UDRObHFLMFd3cUtWdFlhbGVy?=
 =?utf-8?B?REV6NE1ZTmtvWWlFTVUxOWdjMkZmTEMrWndEOFU3S2g4bUdwNVpqUDJ2VWlz?=
 =?utf-8?B?UGszcTEveWlVSmpqckhIL0VUc3d4azFrWkFQN2paMUZBMEp5clpIZG13bktE?=
 =?utf-8?B?dm5aa3ROWmN3R2dyNGlOajNXN3IyYVNDczBSRFRZZ2hKcUcvYXJSQTlFTlZm?=
 =?utf-8?B?MFRCdTQwZHZkZ1UzaDRLNnBCbnVZRjkzRFJEU0R1UFRLaFRmbGpLYXFkUnkx?=
 =?utf-8?B?UWlXVUVUOUtWZ2hUeDdHdVF6bTZuNnJXc2VGNTFhWHVrSS9vS1M2bTZRNXNq?=
 =?utf-8?B?MEFualR0Q3FsNmpGdnZTckJaUVEvb2I0TkZmZVpuSEFrRnhRMlBoZDVteG55?=
 =?utf-8?B?VWlaOVhRTUgxd0VvY0FBMHprbUNwZUJEWmdXa3kyUG9WOUlweGdWL3hPSFk4?=
 =?utf-8?B?NWRxdHhzNjRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Njh6elU1b0ZHN0locFZUZ1Y3eXAyc2E0TndEekllMTRpUDluNlUweTV0bzNk?=
 =?utf-8?B?Ly96bDIwbW03cDNKRXdmWGJrcEpFZXBINURzREV4RTZGSGhpMEpsQnVJaEpm?=
 =?utf-8?B?ZWlmYUc4UjAzMERDbUxXTU1uOUc4eXRNMFVneG15SGZYNFd3Sm0wcWNjeWc1?=
 =?utf-8?B?cTdHUnRQNWU5N0o3aFZxNHRvRFB6Uy9wcVpKRWw0emhLbm1FMXJCWHdLZkhY?=
 =?utf-8?B?NUJPcVJxR2lUUEx6K3hobTgzMXRRS1p4V1ArUU81WW1hbjg3VENEOXdJRG5U?=
 =?utf-8?B?WkVGWmlOWGRWV3FacHJ2MElTdjBTK3YwWVc2OXVKZXdwcHJ2bW1nQ3ArakY2?=
 =?utf-8?B?NUpDNUY1R3hlOTl2NHN2RE05N0hpTlFjUFhOWTg4RUFsV21iN1JxK0JVLytY?=
 =?utf-8?B?a1FBKzJGMW10WnNWWnJBWDB5TEoxOHJLSnR2c1BpMnVONkpqZ1BYV1ZnYkxh?=
 =?utf-8?B?TDdkL2FiNXBXMnZQZ01HVExSMWpTWnI2aDZSdjFsUGREb2ZnanE3ZkNTQUJF?=
 =?utf-8?B?MkY4ZGRpRzBkSUxjeEdhL0xqVVhDb2s0ci9mN2JxNDVCVkFPSUZldmFud2dv?=
 =?utf-8?B?Tjk4MHhZaVlRREY1L0FQRlY0SWFMTENXZzdTMVJLUVJla2RMWWJqbk5ONW9Z?=
 =?utf-8?B?cjkwdTN4UW80b2puMFlLYno5dW9WQmE5N0Z3c29lUVpLMEQzaTVxcUhYRmpG?=
 =?utf-8?B?NjRCYUxOUGRmbUN2NDROWlpQVWQ3L0hiWWRrb3FlbWlpWnBPQm5sQWlFNWVw?=
 =?utf-8?B?YU1WMFl5d3dESGtqYmc4bDhQL3lhRndHU3F6Nk82MWpNTDVQS3hURUErdUE5?=
 =?utf-8?B?dDRhSXk2M1JYclBWOWRVMGpPMW1icWtOOWxxeFFlTWFqNndhVnh6VldMUzdH?=
 =?utf-8?B?d3czQ2lneUMrYmV6N25VQVRTSy9wUEpOTGRJbDlTbnBINEc1Yms4T3R6NnBu?=
 =?utf-8?B?Ulc3eUVOQ1hIVEhndGlYV3V0QlNTZStsOHFEVDdhdzlRaTBxM0F6SHdTVzlz?=
 =?utf-8?B?c29kcWtVcElKZGg5ajNuVGJYWVhFN1h4ZmZsYjgvdDkwVEJlUEFmdThjaUYx?=
 =?utf-8?B?ZTdFaW15VzN6ZjQ1NDdJSkZsdVMzeTlodXRZanJVeU1IYi9tYTlPMFZMNTFT?=
 =?utf-8?B?M3dnMCtacnNMblBnTjE2NDVCeFpCaFE3Q3BqQmdseDB6NjdNNXIvS0Q2bHBr?=
 =?utf-8?B?dEwxWDM5UjdDNzNaa1pnQkQ2b0c0TEFVMWlhY2VPT2dzTXV0YS9ndWRCb2Uw?=
 =?utf-8?B?NEl5d0R1dnpDbWlQSloxOGpINzlsYm96RzRlWFJXRVhXTmViRnhZZ1VTRldG?=
 =?utf-8?B?UWFVb1ErRzNUb3JZYzNXd1ZZZFlQSks0R1hjdU1UQkJKenYzNEdETlR6Nzhx?=
 =?utf-8?B?SnF0a2drajYvZ1ZmSURzU0IzUmk5R2t5dTNMR2Q5b3A3TFhGem9jcnFKV3pF?=
 =?utf-8?B?K1llNlZsdjdCdWFWbi9iRDJZT3FPTXY3RHFOdy95cTFCSDhLcUU5U1NvS2Nm?=
 =?utf-8?B?REtvQ1dBa0ovR3hRaU5iRm1vQXVQMGgrQklab2lOWHo2VWtXY3N0ZVlOZHJu?=
 =?utf-8?B?VGg1VXRwWTFpYmhNekxyU1U1SHF0SE1vbGhwRE1BbTR1UDgzcm5wRElocmVv?=
 =?utf-8?B?eFNIOENmNXR1eTM5RWE5Y0JPZERraGtmRzJPeXQ1eERCeGNmNmZnSWZwalRI?=
 =?utf-8?B?WVJtMWhmUjhWdU0yN2Y1WjBDbGVDTW00TXQzQjdSelE2WDZ6U0IvYXRuV09N?=
 =?utf-8?B?NXQ3OFBwdTZNVXYrWnJWSU5WTHhvWVJOMnNmSjBuaVpIbEJKTlpUWFY5OVY4?=
 =?utf-8?B?cFVxVFhvUFczUFh6ekdjRmtNNUhkODhjS01ZeE9MUXZYSm9mSDRhYWE4KzdV?=
 =?utf-8?B?U1J5anVqZHhQRFVTRVRpdWtuZ0RBdmpmYkJuenE1elBKaWYrRE1zUW9yQTEx?=
 =?utf-8?B?MG4ySDVEMnFyWmFqaUx1ZmFUY044YlVBTzhtRzVBTi84M0xXdU4wenhTRW82?=
 =?utf-8?B?ODdoOEZSZFF4Qm9jRk5hc3RJQzJFNnFqeVMwbTV0RmdDbWkzUnJaU25BcTBq?=
 =?utf-8?B?WGJpRWUzSHh4aE5FVDVpNDIxajE5Q25iMWhub1BiWkRha3V1WW9IZ2dmRnN2?=
 =?utf-8?Q?9rb4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c6fe07-6dba-4caa-bcbe-08ddc51c6461
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 10:26:28.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bf+YDrX3XFFdGYlOwBd0h6XwXQQrrV8XJucF9xvueofGiPPBHX1ace1KGLArtnlsrC8/fwdqQEXPLWatj4V5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910

PiBPbiAxNy8wNy8yMDI1IDExOjQ5LCBXZWkgRmFuZyB3cm90ZToNCj4gPj4+DQo+ID4+PiBJIGRv
IG5vdCB0aGluayBpdCBpcyB0aW1lc3RhbXBlci4gRWFjaCBFTkVUQyBoYXMgdGhlIGFiaWxpdHkg
dG8gcmVjb3JkDQo+ID4+PiB0aGUgc2VuZGluZy9yZWNlaXZpbmcgdGltZXN0YW1wIG9mIHRoZSBw
YWNrZXRzIG9uIHRoZSBUeC9SeCBCRCwgYnV0DQo+ID4+PiB0aGUgdGltZXN0YW1wIGNvbWVzIGZy
b20gdGhlIFRpbWVyLiBGb3IgcGxhdGZvcm1zIGhhdmUgbXVsdGlwbGUgVGltZXINCj4gPj4NCj4g
Pj4gSXNuJ3QgdGhpcyBleGFjdGx5IHdoYXQgdGltZXN0YW1wZXIgaXMgc3VwcG9zZWQgdG8gZG8/
DQo+ID4+DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBkZWZpbml0aW9uLCB0aW1lc3RhbXBlciByZXF1
aXJlcyB0d28gcGFyYW1ldGVycywgb25lIGlzDQo+ID4gdGhlIG5vZGUgcmVmZXJlbmNlIGFuZCB0
aGUgb3RoZXIgaXMgdGhlIHBvcnQsIGFuZCB0aGUgdGltZXN0YW1wZXIgaXMgYWRkZWQNCj4gPiB0
byB0aGUgUEhZIG5vZGUsIGFuZCBpcyB1c2VkIGJ5IHRoZSBnZXJuZXJpYyBtZGlvIGRyaXZlci4g
VGhlIFBUUCBkcml2ZXINCj4gDQo+IA0KPiBXZSBkbyBub3Qgc3BlYWsgYWJvdXQgZHJpdmVycy4N
Cj4gDQo+ID4gcHJvdmlkZXMgdGhlIGludGVyZmFjZXMgb2YgbWlpX3RpbWVzdGFtcGluZ19jdHJs
LiBTbyB0aGlzIHByb3BlcnR5IGlzIHRvDQo+ID4gcHJvdmlkZSBQVFAgc3VwcG9ydCBmb3IgUEhZ
IGRldmljZXMuDQo+ID4NCj4gPg0KPiA+IHRpbWVzdGFtcGVyOglwcm92aWRlcyBjb250cm9sIG5v
ZGUgcmVmZXJlbmNlIGFuZA0KPiA+IAkJCXRoZSBwb3J0IGNoYW5uZWwgd2l0aGluIHRoZSBJUCBj
b3JlDQo+ID4NCj4gPiBUaGUgInRpbWVzdGFtcGVyIiBwcm9wZXJ0eSBsaXZlcyBpbiBhIHBoeSBu
b2RlIGFuZCBsaW5rcyBhIHRpbWUNCj4gPiBzdGFtcGluZyBjaGFubmVsIGZyb20gdGhlIGNvbnRy
b2xsZXIgZGV2aWNlIHRvIHRoYXQgcGh5J3MgTUlJIGJ1cy4NCj4gPg0KPiA+IEJ1dCBmb3IgTkVU
Qywgd2Ugb25seSBuZWVkIHRoZSBub2RlIHBhcmFtZXRlciwgYW5kIHRoaXMgcHJvcGVydHkgaXMN
Cj4gPiBhZGRlZCB0byB0aGUgTUFDIG5vZGUuDQo+IA0KPiBJIHRoaW5rIHdlIGRvIG5vdCB1bmRl
cnN0YW5kIGVhY2ggb3RoZXIuIEkgYXNrIGlmIHRoaXMgaXMgdGhlDQo+IHRpbWVzdGFtcGVyIGFu
ZCB5b3UgZXhwbGFpbiBhYm91dCBhcmd1bWVudHMgb2YgdGhlIHBoYW5kbGUuIFRoZQ0KPiBhcmd1
bWVudHMgYXJlIG5vdCByZWxldmFudC4NCj4gDQo+IFdoYXQgaXMgdGhpcyBwdXJwb3NlL3JvbGUv
ZnVuY3Rpb24gb2YgdGhlIHRpbWVyIGRldmljZT8NCg0KVGhlIHRpbWVyIGRldmljZSBwcm92aWRl
cyBQSEMgd2l0aCBuYW5vc2Vjb25kIHJlc29sdXRpb24sIHNvIHRoZQ0KcHRwX25ldGMgZHJpdmVy
IHByb3ZpZGVzIGludGVyZmFjZXMgdG8gYWRqdXN0IHRoZSBQSEMsIGFuZCB0aGlzIFBIQw0KaXMg
dXNlZCBieSB0aGUgRU5FVEMgZGV2aWNlLCBzbyB0aGF0IHRoZSBFTkVDVCBjYW4gY2FwdHVyZSB0
aGUNCnRpbWVzdGFtcCBvZiB0aGUgcGFja2V0cy4NCg0KPiANCj4gV2hhdCBpcyB0aGUgcHVycG9z
ZSBvZiB0aGlzIG5ldyBwcm9wZXJ0eSBpbiB0aGUgYmluZGluZyBoZXJlPw0KPiANCg0KVGhpcyBw
cm9wZXJ0eSBpcyB0byBhbGxvdyB0aGUgRU5FVEMgdG8gZmluZCB0aGUgdGltZXIgZGV2aWNlIHRo
YXQgaXMNCnBoeXNpY2FsbHkgYm91bmQgdG8gaXQuIHNvIHRoYXQgRU5FVEMgY2FuIHBlcmZvcm0g
UFRQIHN5bmNocm9uaXphdGlvbg0Kd2l0aCBvdGhlciBuZXR3b3JrIGRldmljZXMuDQoNCg==

