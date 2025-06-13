Return-Path: <netdev+bounces-197347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0CAD832C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E6B17F60D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C87256C73;
	Fri, 13 Jun 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jF1FiEgF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36500248F6F;
	Fri, 13 Jun 2025 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795730; cv=fail; b=U6Bj127iZ05oyJrOSKAC2NPdm0fmE+qMp9LWVwZ6EP0EEzOhhU7rzLK4zoLfu+z3l784sUVhZ5Egml0IE9mPsK4t3YqXaExis3027bNuox8nGB4FYgFukYRuKT2aE+84BBamwYR6JryQAomCTi+jgOK0FqOb7TlcthHDv2kRTYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795730; c=relaxed/simple;
	bh=KwcOlu13QzeIR/TfG3H/3mSAf7f7EwT2akUgJl90R1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQGOFiZ3iqvpNs7V+QjXZX8ehgzNmX4a1lbRFW3Cy9Vhbf1EQMXZtna/TvsJWprptYR+ZfTjuHpYXhPG8fJc8AOaD2be5gCbbyokuMyUnlC02GOYJZ2Me1+G3bBjhyTk8CykYearovGbqkL5fZuSOcO9ImcM1BWCNWuRrL8xYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jF1FiEgF; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHZVIvr2fI9E4OvjH3ccKIYc2nKNUPHtOSaCj3CkpgpZjxlGtrdEBAvkGW6/VnIDeRe/KI83owpRZlv4Br5I9ULlicCIw0SeipmoNPSn/nlmL/hRlHj09kxktKHq4HSwBjaRvO+coLdl72KaUXtn2WNjww9+Oriv2YP5uYCLYPKfyyoi8E6PToRWH2EI/hXt+OsiyMWD232LU6VNXxkmWXkQa8WeBsK7AJy2TuYm0wvXzsNuANxo9Z5oUxmqxBe+7ZDiW3MSzIXj2b+z01Rjbwd3qDBGLxi+eavaFRtUgEwzyCgm7EcVoMIjTRxHL/cugQmOHz8BHzTt6fBp3oFf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwcOlu13QzeIR/TfG3H/3mSAf7f7EwT2akUgJl90R1Q=;
 b=EAwy+qY1kr3gbS5dvG5MwwAzDD7++z4e2sumHRmg9BecCV2zksXWnn9JdHOJpXNZqgEG4jZMMjrZsaKu+AKgIBEHrFDJG9iAJz+L6z6cXzmCEa3VwWfNPJQEIiTas/Zzd8kLuFMhlbGA6QBNnezAk6POT46ZXWtKwI7s20BuPvjbTifPRybs4rhldgvByAVOhUhIvfcFe29YQgvSL+b0DKd+0Bep8piK84fqYozwvFjA/jmsRwMG6jmcsoVwExjrxdBozcV2AE+iWdTXR9UtCb821rN52jJWKyisxspNH1g4ZZvZe/QVXbIw73D4roeYMbpmiwmrk6UlE22pKsiOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwcOlu13QzeIR/TfG3H/3mSAf7f7EwT2akUgJl90R1Q=;
 b=jF1FiEgFByBMzWCdrFrGU7oryB0W0A57DFSX78fP1CFm169+VOgcdxFpvwZ/yCM4VSXgAt9dSVjrXBYG1pMMqiXPiqVDU/HPSU/iyF+gIc3sxbGTnM/NBPFoLBudGtbZq7t6izjmRx5fXuculC0T1b5ynQMyDbCyPPI6PRdsfk9oXOvPVwoPiQ5AFSed2qiNB449ZaAs2oy2M6ihEkAESYZ4QjD80OaqY5g2+CDXRGjZe9BlhCoBwcM2tXBd9jt1Em/wUINX0D37LrmGTfCEupuoAUqhg0dIGp0TaGEWsksv9swSdyLItmADsNqvZL24u10h8v155BmJc634MY36Qg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 06:22:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 06:22:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next v2 06/10] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Thread-Topic: [PATCH net-next v2 06/10] net: fec: fec_enet_rx_queue(): use
 same signature as fec_enet_tx_queue()
Thread-Index: AQHb26TmS4ixqtqwGkaBxsUlo/eoybQAn2Og
Date: Fri, 13 Jun 2025 06:22:05 +0000
Message-ID:
 <PAXPR04MB8510FAF576E0A6ACD01D09128877A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-6-ae7c36df185e@pengutronix.de>
In-Reply-To: <20250612-fec-cleanups-v2-6-ae7c36df185e@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7388:EE_
x-ms-office365-filtering-correlation-id: 4ba37be4-9875-4091-4c7f-08ddaa429e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlhaT2tTUExGSkJsaFd6VktGU2d0L1AwWGNoek42UlB4STIwcDArcWJXRzd5?=
 =?utf-8?B?VUpLQjd5SW0yc1ZZa1VFbDRaSFpUek9YVURGRkVla0l1WGhWZHl0c1U3VU1p?=
 =?utf-8?B?UEFzRkQvODBkSmI5ajFkZ0k2WCtrb2JsUnFqK3ZLNkpPOVl0VHN4S0Z3WXV2?=
 =?utf-8?B?K2dMbTBkNVdGY2VwWnpsbmU4bFRvdVcrMkdIR2t6ZzlMTUY0T1RKY3k4VS9l?=
 =?utf-8?B?UUVaNmhEN1k2RTI5eHZ5R1hMMG9Ia3VyTElVWFBONzJ5YXlNWWZnNG9jdXgv?=
 =?utf-8?B?dUpSVHZLUjNqTkZsOFR2ZU9GY3hrYWNlOWVRN2N3SWJKRmI2OE9WeGVmTlNy?=
 =?utf-8?B?Z2xvenpLbStxNkJxVGtLbGJ0L2t3VE9pZ1pzUGRickM1Y2ViVmp2SmtnS3BK?=
 =?utf-8?B?STdlMnMwcE93bnBmUUhoZ05xU3RBYlkyT1RGdGxMNWlkTXVReHdpY2tsM053?=
 =?utf-8?B?L2dFQlhpQzVtQkVDNVZ4R3dBR1BiZGZjUXpucHpKZTNPZHhGVkJGMlV1QlBX?=
 =?utf-8?B?aGQ3b1NobU1UT01aOFBIdFl1dlZGdU9Xdk9PODNOMVdzQmZDUDJTZ3pqNk5i?=
 =?utf-8?B?QVZuRzdtQlp3NTZoejR5V29SWUJ6THhENk9sekF4N1ZSTEkvYVZyUERhTHFB?=
 =?utf-8?B?YTZPR1A4QjZhY0lPZGliVGRYK056WXhrZ2VPNjcxeUdTUzlBZ3Z6OGVPUHlM?=
 =?utf-8?B?TDR5YnBZNjI3dTl0T05WMlVMMkJia3JTOVloWHV3TVY4eksrSGxyaVJNcHlu?=
 =?utf-8?B?eCtKam5tR3ZiU0JzdDM4ZkY2eWNwNmJtNERuKzlZMUc4a3VSYWJqN01FNVNP?=
 =?utf-8?B?ZjdQa09hU3ZXZnJBOWJhVnpsU3IxZVNrMFZoUU5wK3BkbXJyQTRTTklsSE1l?=
 =?utf-8?B?V1A3Z2FsZjNCZjE4Skpqdmo5SjloRmFtaERnYXlheHJHNUZEUWV1NTBvMmJo?=
 =?utf-8?B?alMvQ3JzQXdsQ3UyMTVjK2V6ai9nVGpQemR6c2VPaTJnTVpuMnU4WWdzSWZr?=
 =?utf-8?B?cWFkSVNRUXgrRERiRlhhQ0dQSDg5dlRITWYreG5MWWtsWUxPcERwWXA5a2h4?=
 =?utf-8?B?c2t3elk4VWI5ZDQ2UHRrc2dnWU42TmRNeW51OUJNZ0xpMm1mdWt6aW1BV0ZQ?=
 =?utf-8?B?OEFWdkwwZnQ5TXViaGNIZmZzV2xWUDhJVHBndk1IdWRGMTRPdUhFSWlPSzdE?=
 =?utf-8?B?NmxVemhXam5tVTkxbEhlY2VLTzFVVlp2S0FDakJQbUV1YkZaRTVUbnFEMHFk?=
 =?utf-8?B?b0hoWENvQWo2SHpRbHJlaXJpRnpxZTZDcHFFTXlVWG8zSXh6Z1NycGtoQkdQ?=
 =?utf-8?B?Z1liWlJuNGxuMC9ZMk9tQ3FqZk9PNTZGTlM0MmJTczJVMmN5ZUQ1SkRLWk54?=
 =?utf-8?B?cTZRbGF6UXJrR0pxWFBCUzBxdk1QVWVaekN6aWlrT1lKY1NHTWJ2WC9pck50?=
 =?utf-8?B?RkQ1QlhVMXFpbzUxakJWYXRYRGdLL1JJQ2Z4ZnVNcmZwcTBScC83RUkwMFQ5?=
 =?utf-8?B?emVVYVptbE1NV21NNk05UTNZaTRjNDlDT1hISExIekh3S1h1dzNtc2xmbDQy?=
 =?utf-8?B?QitycHZtUW5mbWRHSWcxampPU1FxMEd4L0dtWjB1bi9hQjJFQlA1dU9ucGlJ?=
 =?utf-8?B?MTd0enM0empRTHRadVNUOW9xSVZDUCtiQTV0YWdJT1ZBWDRyZHptQ2srQnBq?=
 =?utf-8?B?eEpZcWNwUjVpcmRPVDhtam9hSjZucnVhWDR1bVhELytlT0ZRSmZsNWp4MnR0?=
 =?utf-8?B?YytZQndPeGFJaWFMODc3ZE9RbmR5b3hoZFdCMDFDd1duZkZwM0M4Z2xjR3hI?=
 =?utf-8?B?Ky9yOHk3ZCs0b2Q3dmN1T0o4NGlUTEJDMlZtVVU1T1B3OWtEN3BkbUg1empJ?=
 =?utf-8?B?bktpc21vMU53YjNNdHpGdE9IWE5kcmVqMVJValdXUUxzWU1XNWo3bDUwM3RV?=
 =?utf-8?B?OHRuQ09OQVJpRldkVkNyclFNc2dmVHhGUFdyTGEvbVVhL1dvaVc0N3ZTbVZB?=
 =?utf-8?Q?SgSSWL0J7izesf2j8n/P+IjJFdWi1U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTdvVUhMSXF0dlFHSGIvT1lQemFoMW5HNzZzU2pMa0R3M2xhV0NRQ1dZaU1K?=
 =?utf-8?B?ZC9VTUkwNUUwTFEveFZvQXdYVTM3MFB0NnlmM2V3R1B1VExBY3F1MDdLOTJ6?=
 =?utf-8?B?QkFoT3lkbDFCZDJibk0vWUpXdUJaU3NpOEFnSVhRNlM0Z0ozRUU4QldEcWN4?=
 =?utf-8?B?a2E0TXo5cHJWNms5b2twR1cxc1BwMFRmRjJtSGtmNHl4Skt1bDgrcGVONzF6?=
 =?utf-8?B?NDZMbThZcjYvSzVwb3lhTEg1M1VhMmtzTzZzRlYzandIRCtrZ3h3M29VeVZa?=
 =?utf-8?B?cjFVcXlFVGFiWWFoUHNJLy90UWFJaTVLci9QNFZMYWZESFdkKzh4K2xTTmpW?=
 =?utf-8?B?cHFTbWRNcTE3OGNYcEdwSHhNb000dGwyZndTYi80bTgvcSs3cndTQUd1Slhu?=
 =?utf-8?B?OXBHZjNsaWJnc0cxTERVcndaQjRuOVg4WE5DRU84ZzNMdDQ3Tzk2OTVxZE9Q?=
 =?utf-8?B?VzdEa0hkYXZlM2xONTRHb3U5OHhPSWtiZ1NvanJRUjJGVjF3bXJlOWJkN3U3?=
 =?utf-8?B?S3VrUWxTLzc5NHlvZWJiNjJUZVIvV1ZOc2l4emtlN0FMZFlHUHN0R1lDQ2R2?=
 =?utf-8?B?NllIUEZuY2VHM04rY1pRNEd1YktaZDdnblZ2T1FUN0Z3Yk0xWkVrRkpLcW1N?=
 =?utf-8?B?ODl0RmJIa1FhdThXejJkR1dLSlVSTm9HM3ZDcHNLNUwvYUlHV3krdzJNR2w2?=
 =?utf-8?B?akdrSXpST2VRMXJ6Wm9wSXozRGFkOURPZ2F0M3YxUWNuVWNBdmFreXpBL2lJ?=
 =?utf-8?B?WWQ5cE1lTnBuMWU2ZnJzc3ZSNWd0K05EWGdXS2ZPU1AxOS9MTy9qSGdsRFl3?=
 =?utf-8?B?alZNZ2FMYVdYam1yanNQb0FpdlZYVC9wenJtMy9RaUlCa05RQWlsRW91ODBQ?=
 =?utf-8?B?NnlTTXdjU2hDQ1MxeXFkV2tuc3dvS0pDcEszb0Z1NDhmWXRucTRkbHV6S0Nh?=
 =?utf-8?B?aWRscGZKVmN3MFQ3ZWpvS2g2YmNYTTBXZStubHpnR2ozMWozSDJLQXpXWkdp?=
 =?utf-8?B?VUNnYmRjeVRDR2RkZDhDYWtzcldIZ2V3YWhNSlp3SDFUYy80MnZvKzU5WWlL?=
 =?utf-8?B?dFFQYS9yVWZESTZHR1VqQ0k2YVhxWkY2U0FHakNaODFldzlhZkNUdkpFU3JJ?=
 =?utf-8?B?NWU1ZS92NCtYelNQaXNWbUo4b2pTRmNKb052anpVUVZpMDRHS3hKa1RRSGZH?=
 =?utf-8?B?T1BqbmJWbEJGRFAyakttbWJDMDVPd2ZSbUdzUE1HVkU5NEc3Y3lnM0R5dEtL?=
 =?utf-8?B?ZElvekIyZkpjTW8wby9mRmRGV3crQUFHY0M0cnBPb0wwOHRjdzczVjFCMDBo?=
 =?utf-8?B?Uk55T3F0SzBHc3VEU1JkVGFISEt6REdSSURYV1BVSTFRcm1obE9HQktLZ2JZ?=
 =?utf-8?B?NVlKNmxhRnlKVUd1L1A3UittNldGS0t1dlJ2VzRBMEJpNHpBWUVaa3NFWEVi?=
 =?utf-8?B?V1RtWC9ZQTJzdkhBQmVVdjY0UlJrUVF4M2NsdUNieFFGWXJPQko2QzVlQ0RD?=
 =?utf-8?B?OEJhT3p3REFpSldReEg0UFRRWTdHNCt6L2tKOVFPRk9idE9wZWRFaEFSdFYr?=
 =?utf-8?B?d014Ymc5SGd1MlhGV3paVGdaK2YvTDl0cVFBOHZvbW5SV1hqQTg0ZlFRQUta?=
 =?utf-8?B?ODRkUEFkdE5oWXdYRGZ1LzEyZ3RYMXUyY3VFYytsTVpVNW9GckpWL1lSNHBm?=
 =?utf-8?B?a3prN3JjaWxSLzlSZDFaTGdzWVZQVC9XV2ZRa3FqNTUyZ2JlcEV1NHNSTGk1?=
 =?utf-8?B?NDhMK1dlMUdtQmxUUHpIU2JKaEUrcjMyK0g1akVGMnJ5c01waGVCNTQvVU8v?=
 =?utf-8?B?UFYxQng5aG9ybmxndGpLdzBwdFc3ekdVYm4wSE1QZExOZzliR1doMDhIZE9r?=
 =?utf-8?B?cWViZDNUTWpOeU9oY0o4ZVh1emswQ080OFhLdjc2bzI5Rmo3KzduMUZtUVl3?=
 =?utf-8?B?UFpsTjNLVGFONE4yZ3dYTXRxd2YzRDJzUnYvSndtUnM2TU5ZT2FkRHJZdWxx?=
 =?utf-8?B?djJ2UVEzak5Ybk5qMGMyYjNyOS94bXVzeDFYYWpJTlgzZ1o1UUNQbUFWb2hz?=
 =?utf-8?B?RXAyTEZjMmlSdUJ1YlNSblcvei9uQi94L2dsYzRMUzU3aWU1TzZWeGlWbW5j?=
 =?utf-8?Q?6aTk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba37be4-9875-4091-4c7f-08ddaa429e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 06:22:05.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VacEVYv955ebZb8SaU7xFTpLVrRaav3xOlqhVAcGPCCwmNVOkk2/K+YgVhGVZt0jvow0g42MhNmPgE056/o+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

PiBUaGVyZSBhcmUgdGhlIGZ1bmN0aW9ucyBmZWNfZW5ldF9yeF9xdWV1ZSgpIGFuZCBmZWNfZW5l
dF90eF9xdWV1ZSgpLCBvbmUgZm9yDQo+IGhhbmRsaW5nIHRoZSBSWCBxdWV1ZSB0aGUgb3RoZXIg
b25lIGhhbmRsZXMgdGhlIFRYIHF1ZXVlLg0KPiANCj4gSG93ZXZlciB0aGV5IGRvbid0IGhhdmUg
dGhlIHNhbWUgc2lnbmF0dXJlLiBBbGlnbiBmZWNfZW5ldF9yeF9xdWV1ZSgpIGFyZ3VtZW50DQo+
IG9yZGVyIHdpdGggZmVjX2VuZXRfdHhfcXVldWUoKSB0byBtYWtlIGNvZGUgbW9yZSByZWFkYWJs
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9u
aXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWlu
LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4u
Yw0KPiBpbmRleCAyMTg5MWJhYTJmYzUuLjZiNDU2MzcyZGU5YSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTE3MTMsNyArMTcxMyw3IEBA
IGZlY19lbmV0X3J1bl94ZHAoc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCwgc3RydWN0DQo+
IGJwZl9wcm9nICpwcm9nLA0KPiAgICogZWZmZWN0aXZlbHkgdG9zc2luZyB0aGUgcGFja2V0Lg0K
PiAgICovDQo+ICBzdGF0aWMgaW50DQo+IC1mZWNfZW5ldF9yeF9xdWV1ZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqbmRldiwgaW50IGJ1ZGdldCwgdTE2IHF1ZXVlX2lkKQ0KPiArZmVjX2VuZXRfcnhfcXVl
dWUoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHUxNiBxdWV1ZV9pZCwgaW50IGJ1ZGdldCkNCj4g
IHsNCj4gIAlzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0gbmV0ZGV2X3ByaXYobmRldik7
DQo+ICAJc3RydWN0IGZlY19lbmV0X3ByaXZfcnhfcSAqcnhxOw0KPiBAQCAtMTk0MCw3ICsxOTQw
LDcgQEAgc3RhdGljIGludCBmZWNfZW5ldF9yeChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgaW50
DQo+IGJ1ZGdldCkNCj4gDQo+ICAJLyogTWFrZSBzdXJlIHRoYXQgQVZCIHF1ZXVlcyBhcmUgcHJv
Y2Vzc2VkIGZpcnN0LiAqLw0KPiAgCWZvciAoaSA9IGZlcC0+bnVtX3J4X3F1ZXVlcyAtIDE7IGkg
Pj0gMDsgaS0tKQ0KPiAtCQlkb25lICs9IGZlY19lbmV0X3J4X3F1ZXVlKG5kZXYsIGJ1ZGdldCAt
IGRvbmUsIGkpOw0KPiArCQlkb25lICs9IGZlY19lbmV0X3J4X3F1ZXVlKG5kZXYsIGksIGJ1ZGdl
dCAtIGRvbmUpOw0KPiANCj4gIAlyZXR1cm4gZG9uZTsNCj4gIH0NCj4gDQoNClJldmlld2VkLWJ5
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0K

