Return-Path: <netdev+bounces-125339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AC96CC2F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDA21F27BEA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158746B5;
	Thu,  5 Sep 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nEaunHai"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D862C133;
	Thu,  5 Sep 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499411; cv=fail; b=NViM9qvgtSyE4P7FH2FzbbprOxF9T/e4i5kZk48RhNCCGFEEqrqIOviKCy4krztM2k2dQGPpsc6RY1KIf3FpYxoCH8IJm/dPsnoKoAUspPBRLNv5IM7Ij/N4XRyRVIs9CtwnrEo0I8Ma6LjUYMrUWhOUYgyPW2LrQUqpF/ZVPLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499411; c=relaxed/simple;
	bh=ym+TLbcO1YlBZjZmQMAxIU4+N8Y7xdAv9j/uqn9ma9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NiZPWE7REXF6qhwHNAsXiuEsmrYBkDtXlqsh1xFvhBzr49dtwN5sYIMOgc7FS4ApvrMQP6BKohSJIfROBChmB/KwU9PoFAboiho5ZlLXncPomgdWlsuxQnJgJOiOAZ5mczy0D42nRvyYHN3Vgli1dbPMDOBRW+8cwUwFZUydR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nEaunHai; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKQPprFhNiARaHiroEiHca1vdN9WCH2dbYw+JkCZbQvzZQd6vL2HAdVKcgjiA7NRHq+i0iuaiC+18MMpKZquKuLHaF0g7aEknIAOT3tll9GJptESXs1bK1mKoSt1fGDRtF64Qge6oA92OtW0wtwMauqCtmw6PfK1RDamVhDBxbei+u3swhsP/p++Jp47G83GYsaIVXvCA2GgLYt/KgYLwTgCmJrVy3Gq7P15lIo4zarnjy/KLpA23vjdJyHqicKwNcbzX4+VMnQuU99HxTxe5wjWcI+Gp+ZCbGkNtf6kDbX+dhGEkHxerySqt4GYB4uBpnnQ0BgczKxOYEBUSt/igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym+TLbcO1YlBZjZmQMAxIU4+N8Y7xdAv9j/uqn9ma9w=;
 b=pbMF2+gjbOY/d5EXHoiu1ZcW6zJF2qR3/mix7JHJzPbpxsHpmczr0qDnuk9H/P4JncSUsyr4NNsTnkADybLcEMlLzdBrhrvL23CceCCPJhhTE35fM0lLvWrilBJec1qg+TaHbkQ7iF2Jg4SNO2cFcbJ0kEV0BdgNTUvxge9/cDQNiogH0NvQOD5I1cT3LF4UY+AWXZMHWE9XIBJxKorbjEbTuMVdKdRJBltf41WKniDRoUv7Y5yHAVP1xtMPFJdpIPjw7+GvxH5Z0AIRoOIaSk6YiWxoONCI0w5HapEnKWMUZ9DE/YA5NHcVmOyV91KSLoIkcdT1JbKAeWu/aGTZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym+TLbcO1YlBZjZmQMAxIU4+N8Y7xdAv9j/uqn9ma9w=;
 b=nEaunHaizjJxsc4fe5mes0YFbUgVvu7IrWuY6h0STnmojhTceNzavE/2HenqbzTmgSx8zZAthfGINSYFpxTU6dXyFNWxR5I+AAwk2h0m1kzriRpDTeNbr/hX/h6IZzwiJtrou8PNonDuqhpngqv8SKIYys1G53sA6s2wzvx2MNXXR5/VBJ2AvSaNcaZ4wsY2Uqt4hClaVta7RA1B78d5FE7DeVf/GtNln6dkpsSn3Q0KpjHp5oMfoqJ0gUjiZq4itkyp7bABZnKVRcSUDgvIeckUmDiIEt2Gh6YQzNt8OAyrVJT9zXKm3rCpcN1QmxundUqDic1Og7jSc5R3P7kBkA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:23:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:23:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Topic: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Index: AQHa/QQeMkPALeROtkyb2f+TdmVf0rJHu3MAgACuL5A=
Date: Thu, 5 Sep 2024 01:23:25 +0000
Message-ID:
 <PAXPR04MB8510486C8235C4ECA036AF5C889D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240902063352.400251-1-wei.fang@nxp.com>
 <20240904145720.GA2552590-robh@kernel.org>
In-Reply-To: <20240904145720.GA2552590-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7526:EE_
x-ms-office365-filtering-correlation-id: 29c9db97-b773-4749-6131-08dccd49573e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TGljT0cxZ3k1dGdmc3dtU3ZlNTMyZGI4cE9rNnRPUVRLaEtsZWRYWVpVY3pY?=
 =?gb2312?B?NUZwS1dXYzdzNFJBcW8ySGZFU0JRcENGMEpRTHRENUZwVmJWU1c3N1l5N0JQ?=
 =?gb2312?B?RG9CcFg5NnpnRzcrL2R6Zk50TVdvM0RUMnpLQTFXZEJNcDQxMFFINWpBaHA0?=
 =?gb2312?B?SzNEVWVVN3pqZ3g3Tm5saGdqZ0FKL3M4ZVVINENVY3pLSG1LSWZMRXVUSlR2?=
 =?gb2312?B?b2ZkM1prV0N2bkZDSVRaRWRxckRqbTVqVi9ISjdnbDdieDVSWlJKRFArT1c4?=
 =?gb2312?B?ZWc0WEcwOU9uK3UyeFE4NzJQUDAyYnViM2RJT3BudU9zY2Z1RllpYWlDZGlB?=
 =?gb2312?B?NTljQXQzSHBqQ3JpSHZOZVFWK1hOSCtDMGUwakhRanhscEp5YmhCZncxajZl?=
 =?gb2312?B?RXl3Y2d3K090RHJzY0plQ2padnNaV3BqYkV1RlNLWUZxOWhlOWM2OGVUYTlO?=
 =?gb2312?B?NGdCemFVaTdPNmFScXNKSytLWWczd3RQUFM5WjNHdHNvb0ZkOFIzSUpob0J6?=
 =?gb2312?B?anIvTlpreHJFYzI4RXpzNEZkNDZGWmZlcU9MUzVvcGJZeXVhTjZwS09ad0JR?=
 =?gb2312?B?VnRpcmRWWmZDSFg5OURuZWl0aXBFN2gxNnJVUXZFY1V6KzM4a3NPdjJyaEd6?=
 =?gb2312?B?YnBkT3dwSmlKOU1WWWgyZjJqUElFNG9lZ2JSaXNBVHAvRUxiY1NGWUJjYU1r?=
 =?gb2312?B?c0xTRzQ5N1UxeFNwMkYvOVpFUWZ3a01qQ0FoNkFlRkZ1Z3ZMdUxTcDZTdXpC?=
 =?gb2312?B?NEhpT3AwOFZSajVNSlVTYy9JVEJTa3Y2T2xJZTdxbVlPZEpENjdmb0IwVVZo?=
 =?gb2312?B?aDNzSThrZTNlczBYdlIzTThaSjNpRlB2djhUSzFiRmhxbUZvckZNK3FmWFpG?=
 =?gb2312?B?M0NUUEJ1WUVMYWpVNDBLN2JmUGJZb2RKWXpTdW0vZWxkZFl6QkF5YmJQY2Na?=
 =?gb2312?B?bVc2ZEVCRlc5MmVHendmY3FEY0hjV0NYSGxXK25FMUx5Nk1uTG12bmdsWEVl?=
 =?gb2312?B?ZGR6SXdEWDBpUjcrSkxSQUJ3VGh6dUkzZVJOYlhLdkRtWDdBTk9NdHJIQUQy?=
 =?gb2312?B?emxibDlyUmtaY0dnWW5vVG9Qd0NBU3dmRWtOdFRkRENuVlRhQnhkY29pMWhW?=
 =?gb2312?B?WDhzMmlJQlR4WlR3b3lTWGtPTlZnMU4wa0psVVIraDF4MEMvZGlFVFBibDFS?=
 =?gb2312?B?SjVrU1djM2JBU0R1cnZ0R1RXcDMxcnloTjhCR1o1TGtUMWxsMENqY0QzK2h0?=
 =?gb2312?B?YU9ZcTJWVHJEb1VBRlBscmRYQUpvWG1Ya2xiRzRDUlJaR3JqaXd0WFFacU5u?=
 =?gb2312?B?RzF0L3pIbXRiU0tXTkxoTUNUK01FdWxCSnJxTytKcnBkQTNVQlVCRytCUm1V?=
 =?gb2312?B?N2tsTjlXY1dqcVJUTU9HV1BrSkZ6UEZkUVYwNFF3eTNValBWb2hBMGJGN2tJ?=
 =?gb2312?B?WHlLaWVjNGhNcDhURzNwcHBiVGZvcE90YzhQRWh5a3BkTm5mTUpXWWxHWmYy?=
 =?gb2312?B?bjJzemJOL09IY0k5dUNQR2JuV1VWbGxmUTB5VTVPWDBZczRmMStCWWROVlZO?=
 =?gb2312?B?NkJiK3RGYldjVjZ4aEFMQndQandFUDdzZnRHaHg0ZW9kSEtXRkZYRGYrN0h6?=
 =?gb2312?B?TGp1VWxxcWwveG4weEJOcjBIdjlBb3FMR3FmQVhsMkRmNWFnbTZGVWRDdi9r?=
 =?gb2312?B?cW54RkVFY2V6RkRiVzU1TGpOT3JLd0ZQd0h0cUYxZGlXNUlPdUptVmpEK0RV?=
 =?gb2312?B?dG9rYzQwS05Gakcra1FoaW9Ud0FocDJXM3Ira0NBRHJ4dVJmdkp5cEdPZ3U4?=
 =?gb2312?B?STh6Qm9LbG9COGF0MVRpa0ZJckpuaWJxV0NSWHFYUVRNMzhEN0UvVVMyQ0JX?=
 =?gb2312?B?cTRZRVBJMEZCNmxDbkptYzZ1cG1FOGJVRi95WHFtalVTRHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VUpwUkVVaCtRaVJJeVkwdlBiVkVWQ2ttajJ0Zm1GYmZCbG5rdVZKMnptckdh?=
 =?gb2312?B?YjFPZW9VZ1VNTW8rcHZGaUVMT2VGZGNmNURQT0VTdUdLbTE5QVM0MHhpclhY?=
 =?gb2312?B?L2k1SXRNWFNHVVN3TG5TMXlUOTF2U20xRUdEcGMycXJoNlZGYk5hZ1E2M0Jn?=
 =?gb2312?B?Y3JsanErVjBJaGdIVmNsOWEwUjJLeEVBemI1YUZ5VmRkT0FBTXFoajFBeVdz?=
 =?gb2312?B?OURCMmtLNTZCbFcvYll0UjBIZkhGQ3ZDdXRxN2ZmazROdUhTS08xcU9CbTZo?=
 =?gb2312?B?Qmo3VGwybnNtSkRjMWp2R0ppUndwUThLSmVlZTd4WmVPcUVLQTV1K281dnpk?=
 =?gb2312?B?bXc4SjA5c2xTcHFTbEZoM3lqekJLemNBQm41cmxsQzB2ak0vTytXTHU1R2Vi?=
 =?gb2312?B?dWw4clVFS3FnMjVaQjAxNTJtbVpJSGIyVmlKQlRCZUJMNlJsWHRWRnc2Y2Vk?=
 =?gb2312?B?dkxhYit3WkdxQlNwNnFLT0owS1BybTYrUmpGaWtWM0Z3bGE1VHRpN1pvSXkw?=
 =?gb2312?B?bWVCVzNtcnI0OGo2OXNWSlk1WDBIS1B4VnBEL0pQQ0V1NXV2aWQ2Z3lrcEZX?=
 =?gb2312?B?U0dsMDFpak9qclpzUU9nZyt6WVJiU3BLakRia0NsT1YzNnBMYWN6VjdnUGtC?=
 =?gb2312?B?QXMrMEk1SUJvbkxBZ203eVcvRGJMcHVHMGlwV0pvb0xncWtvNUs0cXNxNTk2?=
 =?gb2312?B?ZmRBc05RRVhaeWxBZGxqN2NhZUhwRVRIMFZQeElwa1d4emp6bVpoWTRmT1Ju?=
 =?gb2312?B?VWtqQ2ppSTFBdVpmM0NSeGlQSTIwKzNlVGZ3bjlPTTBFYnZqcXVJMGl0dnYv?=
 =?gb2312?B?eTA3aDlLQUVVQmRuQ213ekNwN2V3T3RXRnUrbEZyaDRyaW5XQnJiUXBlK3VS?=
 =?gb2312?B?NGlIaXd2QnVZV3J6UkRtNHF5MER5KzhtMlNjTFdOekRSZU4ycHFueDU4MUpR?=
 =?gb2312?B?MHZnUHFpT0toTE5pdHptdzdwaG05NzFWQTZvL0hpdkluczNpbWRXK211dXNt?=
 =?gb2312?B?MlBlMVh4VFRzbHhRNjFuNjZoeTFDcCttR3dyYWlVUFZOVEZOWGIzRjE1clJE?=
 =?gb2312?B?VERTMSthZWdQa00zVmpFaTNpNVZITU9YZDhlU1JmQzZWWVdyRkduNEkxTWhm?=
 =?gb2312?B?Zi94d0ZEN2xnNHZjVGwwMGlwSmhqS0xRSjIwcnFYampQQnNkUk50cnVWalZ5?=
 =?gb2312?B?REdyZFAycVFyYitEZjdFcmxSbjdyL2lFTmR0K1hNdWVqWTRiWEZSK24zNldR?=
 =?gb2312?B?cDJ2cjhjcVFqZ0xwUzA3b3ovNGRpVzZLTW1nMCtOVXVBaDUvVnN6ZzRZQVRU?=
 =?gb2312?B?Q0l6S3BzRFJweE4vaUJQeENZVUVaNlZ2QmFaR1JPRml6b2doZEdROURYaE1T?=
 =?gb2312?B?STZzMmNoOGlpenpUcitJZEV5d2l6TFU2WVRVaVJ4TmlqUVAwclpxUnBJSzdh?=
 =?gb2312?B?SlkxbVdGYUlacUlGS1FqOWtyLzAxa2c5MUhVQTdqZTQwdTV3ZnpkM3gxamI5?=
 =?gb2312?B?OE1ZZnh2cC9qTEg3MFh2VDlLSXlCZStLK2dZYXFzRUozV1RSbjJwQ20wWmJC?=
 =?gb2312?B?V0VJTlUrR05iczRzd2lNOGxiWmhWcmM0SVVIczFITkkwbGY1N0xUQTljQi9t?=
 =?gb2312?B?Yy93QzZSczJ6QlJlS1YvbVlobDhBSVJnN3FSVURrVkRmL040Z2Z5ZzN4WWpT?=
 =?gb2312?B?OWtkb3VwTEJGK0xxS0JOV0pJT21ITVVRaS96eXVrUkdmemxmbk5xTXdaUHNx?=
 =?gb2312?B?d3p5ckZmUlhFcitPU1VPNjFKQ0toN0lQRjVWVFp2NEs0VGU1ekFZMDdOQ3lO?=
 =?gb2312?B?OG5iL0VMK0VKcCs1TlhGV3k3am9ZeXo1MEVYempaeXFFZFcyemFOUFJXOVhO?=
 =?gb2312?B?NzRKV0FSS2tiakROcUxMZnhZZndGcnQxVjllbVpUNmFCN1ZkbnpjT0RRTDdR?=
 =?gb2312?B?ejQ2OVd6MVZueW9rNWFhb1JUVXhpZjNyZTBYdFNlV05lNzFoZ2t1eld0dkpa?=
 =?gb2312?B?MEZkcmRjNlFZL2R0VU8rZ0hZODZWa2lDSUIrYlRySEtHQk8yaTdseTZJeGtz?=
 =?gb2312?B?RnlXQkdhMUZQVHFNNHFwRFdDUU1ldVpISjAvV3JZKzZEZTFDZDRWdzZDakpp?=
 =?gb2312?Q?ZEx4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c9db97-b773-4749-6131-08dccd49573e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:23:25.9528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gz3Y3e+EeJfUoSDnpwmQxE/Oin9v1OB6TwR9bfgE7/koqofrLIaNIFvAjToa0EGX98JNlH1hN23piQH3wlxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOo51MI0yNUgMjI6NTcNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhh
dC5jb207IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgYW5kcmV3
QGx1bm4uY2g7IGYuZmFpbmVsbGlAZ21haWwuY29tOw0KPiBoa2FsbHdlaXQxQGdtYWlsLmNvbTsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBuZXRdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IGZpeCB0aGUgYnJv
a2VuIGJpbmRpbmcNCj4gDQo+IE9uIE1vbiwgU2VwIDAyLCAyMDI0IGF0IDAyOjMzOjUyUE0gKzA4
MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IEFzIFJvYiBwb2ludGVkIGluIGFub3RoZXIgbWFpbCB0
aHJlYWQgWzFdLCB0aGUgYmluZGluZyBvZiB0amExMXh4IFBIWQ0KPiA+IGlzIGNvbXBsZXRlbHkg
YnJva2VuLCB0aGUgc2NoZW1hIGNhbm5vdCBjYXRjaCB0aGUgZXJyb3IgaW4gdGhlIERUUy4gQQ0K
PiA+IGNvbXBhdGlhYmxlIHN0cmluZyBtdXN0IGJlIG5lZWRlZCBpZiB3ZSB3YW50IHRvIGFkZCBh
IGN1c3RvbSBwcm9wZXR5Lg0KPiA+IFNvIGV4dHJhY3Qga25vd24gUEhZIElEcyBmcm9tIHRoZSB0
amExMXh4IFBIWSBkcml2ZXJzIGFuZCBjb252ZXJ0IHRoZW0NCj4gPiBpbnRvIHN1cHBvcnRlZCBj
b21wYXRpYmxlIHN0cmluZyBsaXN0IHRvIGZpeCB0aGUgYnJva2VuIGJpbmRpbmcgaXNzdWUuDQo+
ID4NCj4gPiBbMV06DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KPiA+IC5rZXJuZWwub3JnJTJGbmV0ZGV2
JTJGMzEwNThmNDktYmFjNS00OWE5LWE0MjItYzQzYjEyMWJmMDQ5JTQwa2VybmVsDQo+IC5vDQo+
ID4NCj4gcmclMkZUJTJGJmRhdGE9MDUlN0MwMiU3Q3dlaS5mYW5nJTQwbnhwLmNvbSU3QzU2MTY0
MDcyODgwMzRhZWU5DQo+IGNmNTA4ZGMNCj4gPg0KPiBjY2YxZTFjOCU3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg2MTA1ODY0DQo+IDY0MzU2NA0KPiA+DQo+
IDc1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUwNCj4gQ0pCVGlJDQo+ID4NCj4gNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MwJTdD
JTdDJTdDJnNkYXRhPVR4dVlud0JIeERLSWRBNXF4ZHMNCj4gOHNiNGZ6eWkNCj4gPiBUazgwY3F5
TTRYMG1rNVBZJTNEJnJlc2VydmVkPTANCj4gPg0KPiA+IEZpeGVzOiA1MmIyZmU0NTM1YWQgKCJk
dC1iaW5kaW5nczogbmV0OiB0amExMXh4OiBhZGQgbnhwLHJlZmNsa19pbg0KPiA+IHByb3BlcnR5
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254cCx0amExMXh4LnlhbWwgIHwg
NTANCj4gPiArKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNl
cnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254cCx0amExMXh4LnlhbWwNCj4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLHRqYTExeHgueWFtbA0KPiA+
IGluZGV4IDg1YmZhNDVmNTEyMi4uYzJhMTgzNTg2M2UxIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLHRqYTExeHgueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLHRqYTExeHgueWFt
bA0KPiA+IEBAIC0xNCw4ICsxNCw0MSBAQCBtYWludGFpbmVyczoNCj4gPiAgZGVzY3JpcHRpb246
DQo+ID4gICAgQmluZGluZ3MgZm9yIE5YUCBUSkExMXh4IGF1dG9tb3RpdmUgUEhZcw0KPiA+DQo+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4g
KyAgICAgIC0gZXRoZXJuZXQtcGh5LWlkMDE4MC5kYzQwDQo+ID4gKyAgICAgIC0gZXRoZXJuZXQt
cGh5LWlkMDE4MC5kZDAwDQo+ID4gKyAgICAgIC0gZXRoZXJuZXQtcGh5LWlkMDE4MC5kYzgwDQo+
ID4gKyAgICAgIC0gZXRoZXJuZXQtcGh5LWlkMDAxYi5iMDEwDQo+ID4gKyAgICAgIC0gZXRoZXJu
ZXQtcGh5LWlkMDAxYi5iMDMxDQo+ID4gKw0KPiA+ICBhbGxPZjoNCj4gPiAgICAtICRyZWY6IGV0
aGVybmV0LXBoeS55YW1sIw0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+
ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsg
ICAgICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gZXRoZXJuZXQtcGh5LWlkMDE4
MC5kYzQwDQo+ID4gKyAgICAgICAgICAgICAgLSBldGhlcm5ldC1waHktaWQwMTgwLmRkMDANCj4g
PiArICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgbnhwLHJt
aWktcmVmY2xrLWluOg0KPiA+ICsgICAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsgICAgICAg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgICAgVGhlIFJFRl9DTEsgaXMgcHJvdmlk
ZWQgZm9yIGJvdGggdHJhbnNtaXR0ZWQgYW5kIHJlY2VpdmVkDQo+IGRhdGENCj4gPiArICAgICAg
ICAgICAgaW4gUk1JSSBtb2RlLiBUaGlzIGNsb2NrIHNpZ25hbCBpcyBwcm92aWRlZCBieSB0aGUg
UEhZIGFuZCBpcw0KPiA+ICsgICAgICAgICAgICB0eXBpY2FsbHkgZGVyaXZlZCBmcm9tIGFuIGV4
dGVybmFsIDI1TUh6IGNyeXN0YWwuDQo+IEFsdGVybmF0aXZlbHksDQo+ID4gKyAgICAgICAgICAg
IGEgNTBNSHogY2xvY2sgc2lnbmFsIGdlbmVyYXRlZCBieSBhbiBleHRlcm5hbCBvc2NpbGxhdG9y
IGNhbg0KPiBiZQ0KPiA+ICsgICAgICAgICAgICBjb25uZWN0ZWQgdG8gcGluIFJFRl9DTEsuIEEg
dGhpcmQgb3B0aW9uIGlzIHRvIGNvbm5lY3QgYQ0KPiAyNU1Ieg0KPiA+ICsgICAgICAgICAgICBj
bG9jayB0byBwaW4gQ0xLX0lOX09VVC4gU28sIHRoZSBSRUZfQ0xLIHNob3VsZCBiZQ0KPiBjb25m
aWd1cmVkDQo+ID4gKyAgICAgICAgICAgIGFzIGlucHV0IG9yIG91dHB1dCBhY2NvcmRpbmcgdG8g
dGhlIGFjdHVhbCBjaXJjdWl0IGNvbm5lY3Rpb24uDQo+ID4gKyAgICAgICAgICAgIElmIHByZXNl
bnQsIGluZGljYXRlcyB0aGF0IHRoZSBSRUZfQ0xLIHdpbGwgYmUgY29uZmlndXJlZCBhcw0KPiA+
ICsgICAgICAgICAgICBpbnRlcmZhY2UgcmVmZXJlbmNlIGNsb2NrIGlucHV0IHdoZW4gUk1JSSBt
b2RlIGVuYWJsZWQuDQo+ID4gKyAgICAgICAgICAgIElmIG5vdCBwcmVzZW50LCB0aGUgUkVGX0NM
SyB3aWxsIGJlIGNvbmZpZ3VyZWQgYXMgaW50ZXJmYWNlDQo+ID4gKyAgICAgICAgICAgIHJlZmVy
ZW5jZSBjbG9jayBvdXRwdXQgd2hlbiBSTUlJIG1vZGUgZW5hYmxlZC4NCj4gPiArICAgICAgICAg
ICAgT25seSBzdXBwb3J0ZWQgb24gVEpBMTEwMCBhbmQgVEpBMTEwMS4NCj4gPg0KPiA+ICBwYXR0
ZXJuUHJvcGVydGllczoNCj4gPiAgICAiXmV0aGVybmV0LXBoeUBbMC05YS1mXSskIjoNCj4gPiBA
QCAtMzIsMjIgKzY1LDYgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgZGVzY3Jp
cHRpb246DQo+ID4gICAgICAgICAgICBUaGUgSUQgbnVtYmVyIGZvciB0aGUgY2hpbGQgUEhZLiBT
aG91bGQgYmUgKzEgb2YgcGFyZW50IFBIWS4NCj4gPg0KPiA+IC0gICAgICBueHAscm1paS1yZWZj
bGstaW46DQo+ID4gLSAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+IC0gICAgICAgIGRlc2NyaXB0
aW9uOiB8DQo+ID4gLSAgICAgICAgICBUaGUgUkVGX0NMSyBpcyBwcm92aWRlZCBmb3IgYm90aCB0
cmFuc21pdHRlZCBhbmQgcmVjZWl2ZWQgZGF0YQ0KPiA+IC0gICAgICAgICAgaW4gUk1JSSBtb2Rl
LiBUaGlzIGNsb2NrIHNpZ25hbCBpcyBwcm92aWRlZCBieSB0aGUgUEhZIGFuZCBpcw0KPiA+IC0g
ICAgICAgICAgdHlwaWNhbGx5IGRlcml2ZWQgZnJvbSBhbiBleHRlcm5hbCAyNU1IeiBjcnlzdGFs
LiBBbHRlcm5hdGl2ZWx5LA0KPiA+IC0gICAgICAgICAgYSA1ME1IeiBjbG9jayBzaWduYWwgZ2Vu
ZXJhdGVkIGJ5IGFuIGV4dGVybmFsIG9zY2lsbGF0b3IgY2FuIGJlDQo+ID4gLSAgICAgICAgICBj
b25uZWN0ZWQgdG8gcGluIFJFRl9DTEsuIEEgdGhpcmQgb3B0aW9uIGlzIHRvIGNvbm5lY3QgYSAy
NU1Ieg0KPiA+IC0gICAgICAgICAgY2xvY2sgdG8gcGluIENMS19JTl9PVVQuIFNvLCB0aGUgUkVG
X0NMSyBzaG91bGQgYmUgY29uZmlndXJlZA0KPiA+IC0gICAgICAgICAgYXMgaW5wdXQgb3Igb3V0
cHV0IGFjY29yZGluZyB0byB0aGUgYWN0dWFsIGNpcmN1aXQgY29ubmVjdGlvbi4NCj4gPiAtICAg
ICAgICAgIElmIHByZXNlbnQsIGluZGljYXRlcyB0aGF0IHRoZSBSRUZfQ0xLIHdpbGwgYmUgY29u
ZmlndXJlZCBhcw0KPiA+IC0gICAgICAgICAgaW50ZXJmYWNlIHJlZmVyZW5jZSBjbG9jayBpbnB1
dCB3aGVuIFJNSUkgbW9kZSBlbmFibGVkLg0KPiA+IC0gICAgICAgICAgSWYgbm90IHByZXNlbnQs
IHRoZSBSRUZfQ0xLIHdpbGwgYmUgY29uZmlndXJlZCBhcyBpbnRlcmZhY2UNCj4gPiAtICAgICAg
ICAgIHJlZmVyZW5jZSBjbG9jayBvdXRwdXQgd2hlbiBSTUlJIG1vZGUgZW5hYmxlZC4NCj4gPiAt
ICAgICAgICAgIE9ubHkgc3VwcG9ydGVkIG9uIFRKQTExMDAgYW5kIFRKQTExMDEuDQo+ID4gLQ0K
PiA+ICAgICAgcmVxdWlyZWQ6DQo+ID4gICAgICAgIC0gcmVnDQo+ID4NCj4gPiBAQCAtNjAsNiAr
NzcsNyBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPg0K
PiA+ICAgICAgICAgIHRqYTExMDFfcGh5MDogZXRoZXJuZXQtcGh5QDQgew0KPiA+ICsgICAgICAg
ICAgICBjb21wYXRpYmxlID0gImV0aGVybmV0LXBoeS1pZDAxODAuZGM0MCI7DQo+ID4gICAgICAg
ICAgICAgIHJlZyA9IDwweDQ+Ow0KPiA+ICAgICAgICAgICAgICBueHAscm1paS1yZWZjbGstaW47
DQo+IA0KPiBBcmUgY2hpbGQgcGh5IGRldmljZXMgb3B0aW9uYWw/IEVpdGhlciB3YXksIHdvdWxk
IGJlIGdvb2QgdG8gc2hvdyBhIGNoaWxkIGRldmljZS4NCj4gSU9XLCBtYWtlIGV4YW1wbGVzIGFz
IGNvbXBsZXRlIGFzIHBvc3NpYmxlIHNob3dpbmcgb3B0aW9uYWwNCj4gcHJvcGVydGllcy9ub2Rl
cy4NCj4gDQpUaGUgIm54cCxybWlpLXJlZmNsay1pbiIgcHJvcGVydHkgaXMgb25seSBhcHBsaWNh
YmxlIHRvIFRKQTExMDAvVEpBMTEwMSBQSFlzLCB3aGljaA0KZG8gbm90IGhhdmUgYSBjaGlsZCBw
aHkgZGV2aWNlLg0KDQo=

