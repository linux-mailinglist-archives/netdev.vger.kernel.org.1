Return-Path: <netdev+bounces-144351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7339C6C5C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889BE1F2317E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACEE1FB8B3;
	Wed, 13 Nov 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dhdagg5W"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A41FB8A1;
	Wed, 13 Nov 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492394; cv=fail; b=e/0sXlxLJvapDzmrDyMey+YLPJohfcCkGYPIPc0HqAQoWIJf4djogTQkuNoPUqVY748p2CYpgqCRDRSUL5Dx6utppBF2O11bx4mICXA+GYqXRy1CsHMumWf1LgfmNgnrT5gkQFO6h72/cFEKKCSeFTF27YHafn29+o00HKxS6k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492394; c=relaxed/simple;
	bh=K30CEBcsKRJyQSP+/UIEY65VmDEeiD/X8mMVu4cS1SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1Zi0fl3q56TAvcjVOtJrR/5KROyI4msB9ySQj26URoNRoNu6O6qA9cMZd/Crl1NQN5cY0WmKTqYFAg/djgNvziuTwVWjQ4Lvz+ElMHIDdyYSWhKnst8FiV2qRpqC34IV4V2b6Aqlopm3nra46kinpyH8lrVKVoBs07pOWibn3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dhdagg5W; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFZX0wjYDursFseatXZb0ton5xiJV6V5nDOOYN143+3rgcCKtMAFEy0sj+tnPY9Rlwjwj/gH/Zs+JRAlTOnVNX4gKsPjLjb6A52ryIL7+iEg2SI6U9ubQvklPVjQJCsrvIiaGaRjFiquq+MvuJzjWGwgOtSSgLXuxt5bNrJBIv1ao5qWq6Ao0Gq90MT1J9bc4f3nxIef2XxiQ9moVuo2xn84O+5p/FKJ9jd1zNIL6lt82WrfuR0lsUFWrO8KE5pL5WJ7ZleYclJ4AZmai0Xk+D88/KC1TVVwutvfMFQ4JoWqcvI9AuOMfiPskG7Oujc1lxTWKxn3iXC2TrFeF42kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K30CEBcsKRJyQSP+/UIEY65VmDEeiD/X8mMVu4cS1SU=;
 b=Kd+pu/+2G2yxLGrxMHtBuPxQ5dbC8No6zrR0ycLYtlkmGL4fvLx/kX3puDfQjMk0aZg1Ow7brJB3dDWv5yN+feVCOc5dcR6ZvB68MXVlkaQDRjadp2Cq4cgNYe27fFgWaq5IgfzHhNQVEOxczqIspmMB8IWHdeTktqI80iAn+RQUJIu1zoxQSjD81qRfcr2suiu3RuJy95JRTj79NYw7RddNgEDd395CcqMTsr+mFlKOKQncjnByDTPFOyY7jVorOIRHurINbpmhRtHJXesHNjdBdbM9dlMo3pxED+b8rldoPF/ybtO8bz/WYZYkv8d+a4/7BPjFgJLNnBhBFOrrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K30CEBcsKRJyQSP+/UIEY65VmDEeiD/X8mMVu4cS1SU=;
 b=Dhdagg5WHoxh3uRshih1uC663i5oTP5Vqk1GK2X27C/DqfzUyIxeU3eejYeOKjVjRKrAvfzq6InMYrWXvUVZfFWy9G66gRScjtUCWwrYOay3WE+qoeZAbbB0dWAErWE+V/ArC1oBwhPApD9Ht7jrsVRGMOGQUEQd4PXH9xk2g8tiNRGRfOxOL29opZLc6wVEcssoBrbk8fafnpdAwvuMKXJSR45TlHMAhTDKoilvKnKtSWGQAwmsoA+CQqzbhwIODqK/XHyEcqsbPOm8lb1xQUT9ph3TRgYKYBl9LMkUUM8Tt1Cmt51ENHI1BZ+Got2bfF0je8FA3vNPKsCp727T6g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10226.eurprd04.prod.outlook.com (2603:10a6:102:464::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 10:06:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 10:06:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>
Subject: RE: [PATCH net] samples: pktgen: correct dev to DEV
Thread-Topic: [PATCH net] samples: pktgen: correct dev to DEV
Thread-Index: AQHbNLGo+6nx23Xq0UK0KJD/aNwAGbK09+WAgAAEDlA=
Date: Wed, 13 Nov 2024 10:06:28 +0000
Message-ID:
 <PAXPR04MB8510E9AF9E925D93C851E8A8885A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241112030347.1849335-1-wei.fang@nxp.com>
 <0cde0236-c539-487d-a212-b660331d3683@kernel.org>
In-Reply-To: <0cde0236-c539-487d-a212-b660331d3683@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10226:EE_
x-ms-office365-filtering-correlation-id: d83a9052-8036-4f82-89f1-08dd03cad7af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGFxOTJGL0Rsa29kdXlUeWVJaWJuSWRrRTVWcE1rL3c2eUtNb0YwRkFzZHFM?=
 =?utf-8?B?aTNKU0NFUElVcTdTRUlTeVB4RDlYOW4zSUlPeTMyc29pdktpb2NjNmVnSnFa?=
 =?utf-8?B?b2NpS1pUQ3hpakpoNS9UWWZvbERMbUUxMFkxeFA0KzgvWlJ6N1JhL0wvU2xN?=
 =?utf-8?B?Z25teXhTNk4vWEtZVW50U011ZkRNYkhYdDlLZ2tibGJQUmpkV21ZaGRoL1NR?=
 =?utf-8?B?YkhmaEJJVWZYcFZkVzhxN25vSG1VMUZIdlFLUnNCSzhSSnY1blRNTE1kZml0?=
 =?utf-8?B?TVZsT2doY1NVb3NFWDB5QTBzVzhxTzkvVWVKblYwcklnUlBxSWcyTHZjcWZa?=
 =?utf-8?B?UVlOMDBpRUQ0Wll2NWRLUTlYdHdsQm5MZlNLMXpxU0VRM054SkxZcnBLOXM1?=
 =?utf-8?B?M3paWHFXVHJJVmJxajlHbjFxS3hwOWRkNWtqRlhOL0U2NkUzMFB4dTBXZ0Nk?=
 =?utf-8?B?YS9Kb3ZxUkFnK2VNZXh2WmFrc2NOdkFDWjJQT2hwS0ZSYU5OM1dlODljaU43?=
 =?utf-8?B?T0NVODFXaFkyZDRheDExS25PLzk1N3EyMkVHeUw0cU9HV2lHTjR4QVQrOVQ2?=
 =?utf-8?B?QXBod3NHc0xYaGxEUlFMSG5qSVVjenBMdnFWOFV5U1N6YmxORGZuNElyM3dV?=
 =?utf-8?B?NkEwdVNOZUZYTFBTY2xuVVEyV2lqaUpyd2tlQTV1bXJtUUtTbHpFYWtXQms3?=
 =?utf-8?B?K3E4ZlZLaWhoRVRCbHVZcS9TY0Y5T29aMDdXdTVJUGtZbmZGZTB3bzlrdFR5?=
 =?utf-8?B?cU83MnM5VFVJcE1HYWJDenNyS0ZNb1BYeU0zWjNNdXovME5oTktPdW5MVEl5?=
 =?utf-8?B?Z1FsaFZRYytGOHRkRnM5WWdMa2tob0MzeDVqc041bHg2cjlYRHhycW5lY2lC?=
 =?utf-8?B?ZXg0dk9veXM0M3JudWh5L3pOTHEycStmYWdwQkY5Qjl6SjR0OUFlSTh3M2tm?=
 =?utf-8?B?ZTY0d1U3UUFaTVNZYkludlVOM1dTbUpBRlBvSFdjS2RJY3RZV3BiamRaUHBa?=
 =?utf-8?B?dUV3M2w3N2wzNlVPK0lSTUtqZ2FVN0g5U3dIMTQzV3QrTjd3cnZiUGYwOXR6?=
 =?utf-8?B?dm1SL3pucnk3ODJ1OXdUaTlWbVVTL3FyNU00N3RYOUtFSzVVczhMYlRva1lR?=
 =?utf-8?B?QkJ0amMvL2tjTXRUdXpCU1Nud2s1SnNLNk9GNVZrRFZpa2Nxbm03Z2dKUHcz?=
 =?utf-8?B?bnM3bjRWZnRGRGFxUG5yakQ2RGloLzJieWs1dEk2MU1sVjVGYUV1a29KUGJq?=
 =?utf-8?B?KzFtYmttN1JkS1c5MkFUcmh3UFRPTUFjck8vZ2NxeTU5RExFOFJweEsxV1Y2?=
 =?utf-8?B?VnZ1MSt1d1h1QWd3ZFZ2dEE2VzlyeDlzUVNudzIvRDNjb2Q5MVN3ckZwWmxI?=
 =?utf-8?B?TW1menl4NTQ1TDJLQk1Vb3NEZzdIV1hwYSttZlZpQWt4c2hORnIrYWNNd0hx?=
 =?utf-8?B?R0J6VEdxZzBoM1QyalhFMk1xZTZ3REFrNWdPanNva3kyblBHVWNETFEvY1RV?=
 =?utf-8?B?MG1ldEF1MFFtcjBQRFZvT3ZaK1MrQVovbGI5Q3lVeFI4MFNBUjk3VEVrWU5x?=
 =?utf-8?B?bFc5WDJ4NDhsRm9uUDM4ZTNIRDIvZ3ZLQXhSdjBKZ1F6UU5YdzdlMUE4WXNN?=
 =?utf-8?B?M2tDNDhVNC8xek1tbmhuUEdmYXlZbVZBbG53SU1FTDJrSXlMSGE1dWMyeUFl?=
 =?utf-8?B?MzZRYmlodGpBUFM1VzhoalpHYW1RTDNuVDBHcVdURjlUbDA0b2hzRjF1a3o4?=
 =?utf-8?B?cDh6a1NUL2w0WjJIV1p6bmE4WXBhdTRyVTI0RUpIWEE3TVVZRVFBL1ZWaTYv?=
 =?utf-8?Q?EHOAGDzyYKvNUDMOOxzH1Jn8QZcIX9uK+1WTA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEdVRXFwVjFOTWZCQTFKRWFUQTdWc0FrcTVUUlpESmErSlppN25QUE9hWVhY?=
 =?utf-8?B?Q215TUlXeWtSRWpiYXVDSytZR3dzbE93dTk4L0YrYUNhM0hIVTV5azZjWWtm?=
 =?utf-8?B?em9oTnhnQVJEU0FGT0x0SklaK3BjYnIvOURXRm95VVhtKzNlWnhyaEEvcjcx?=
 =?utf-8?B?Q3NTUUhMc2FQSXhzME50N2U5VTRWbHJKaVlaYjhCc1BUTGI1WUF1L2tnQ0Rk?=
 =?utf-8?B?SEsxa3puUW02SzRjYmZzSWhMRzFla0lVdyswc2IrWlUrSXBwblNIektZMnZx?=
 =?utf-8?B?NlByQkp1YXQyY2Yydi9kbjNBQllaKzBzcFNzSFJiOTBYWjIrUmFyc1dTait3?=
 =?utf-8?B?STVTSG4zaW45VTVLYzh6NlNtQUhEeXRURGFxR2hhb3VleHNVMXdZT2pBU3d5?=
 =?utf-8?B?bmhSSWV6TzErWDNINUVablpaelp5RGNxYzE5dHk3SEZhQVU0ZWNUZlhlQjJ3?=
 =?utf-8?B?cFg1UzFHdnRFa3RVSXdvV2d4VFNET2p5TUNiNWRMajd5cVRSdURabWh5cjc3?=
 =?utf-8?B?VElHTmMwYnlMMFY5N1ppbXVMdWFpaUFMQlRiWit1MXdpNU4yR0dZczd3MGw3?=
 =?utf-8?B?TXV1dHRQamZDTzJRSGRxSmIzTHl0OGdtK2xEeS9KclJuSFVSdEVnNWN4RTlO?=
 =?utf-8?B?LzFMdTB5RFFWcG5nYTF6UmZMWEVaRWFKVHI3d1lWV1UwM1JZTFNRU1lXeWFV?=
 =?utf-8?B?N2gySTZ6ZzErL0VwQzZuSGVrMDNJL2xFbVNNK2VrUC8xelJrL1F3SEpGeGpT?=
 =?utf-8?B?OHZRbm1mK014MUtJZHRxM0xPSk9hUTF3VXhJRC9WM1hUQ1NYY3NDdEgycWFq?=
 =?utf-8?B?ZUV5dXZpV3NMWlhXSjBBRis4T2VmL21QU1B5bkpBSjB1K0MwU1RNY3hONzl1?=
 =?utf-8?B?UGpNMDg0Uyt0VjJTZmczNXNudzlKdFVGZlRMNmlXSkU0VnhwNkNpRWtWWFdE?=
 =?utf-8?B?ZEJYNWFBZ29lb3VjK1ZJbUNRMFRvZlpEeTczMC92Uzl2TDNSY1FqN0l0K0FX?=
 =?utf-8?B?Uk9XVWhSMUVEbGpNU0dHem5tcWQ5eFJOV2RodTlLYjQ1cEJVT1pNdnZkbGVj?=
 =?utf-8?B?TzJWN2hXRHJWOFM4U1E4eUdCbWtBLzVWRndWYjZoN0hhYVhHb0hxS2JIVHBL?=
 =?utf-8?B?Wm9tRVg0N1oxWUpYVkg1Tm9qNkMyZTJXWEF5dXNSUjdGdHBsZUQwM01NQThU?=
 =?utf-8?B?MXJpSENzb0taRW9SNHFhM0JrM0RYRUlpN1ZFblpsUzAxTWEwN3R5eTdlczAy?=
 =?utf-8?B?Qm9FeXcrNFJQdC9JeWx1blZqdlRacFRLYndiNkoxa05RYm80NzNkT1dHTWl1?=
 =?utf-8?B?TzhxZUFJUHBpRlNzNXhJdlp1N2dDMUpoeDNIS3NoTXptWHlwcW9ZM2pmOExU?=
 =?utf-8?B?S1JuM2lhRjlpdStZeDNvNEZqTFVKL2tOOFR6V21uZE91Rnd5d1pwUWMzZ2tD?=
 =?utf-8?B?alozSWEwY0JvSzFlUmZSdDdBUEk1Ni84VDF3U1Y2eXVaUlV0RWN4TTZDTkpr?=
 =?utf-8?B?ZVlOejVRMWFsOUMyNERFZG1sd1ByYytkcUlqdkVLTEVDVUJiWUtOSklXSFJt?=
 =?utf-8?B?dVVra2VleTNseGFiQmdRVVd5UGtiaHp6b3BRazhLaTUvU3BMUjhqc3gvQUMr?=
 =?utf-8?B?bmdiaEdlRldISjR0eExCeGpoOW1QbHpaRmkzNVVGNVhpN3BnWDJCdVptYndi?=
 =?utf-8?B?L1ZUOHZDZnNmUS85MnhEM3IxdVd5NTJCaHRZQ0NmMW03TmxJNVBkNklCeW11?=
 =?utf-8?B?eWt4eVMxZWZMbFRDZ2dieWtLVk9rU0wzMlc1TmcyM2hYMHdTL2hVZnNJVlFv?=
 =?utf-8?B?V1J1NkJlNll4azRZNUJWVGY5TmFFWGllM0VjeENSLysyK0NtNE1iNGJVYWth?=
 =?utf-8?B?czJzWUE5azBnc3NDN013dFp4azMrbGplZWRlRk0zR1Vkb0JoYXRzK0dnMzBn?=
 =?utf-8?B?eU9yWW9KSC85d21QYVdmVFQ5U1lkNFlQOE9Za1hwSmZHOHpEdFFrcGk3MmIw?=
 =?utf-8?B?N20zRWp0VW5Iemo2Mzlubld0WWNLMjFCdTQ0bHlJQ3ZDTkRXNVNjZm96bk0w?=
 =?utf-8?B?ZlFnbzNZL0UxQ1h3bXc3MnhHbHpLMVAzNGpJTTQwUkRnc3pWVDZKb1JzTVJH?=
 =?utf-8?Q?ObaI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a9052-8036-4f82-89f1-08dd03cad7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:06:29.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hvGLBaT6BOtS2WR5kPobCD1hx0cUJlNyve+rS+s8BKetwMv+ZR9u2nBFXw3LAIjVXRMWeNdXOXzXBCa2iuymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10226

PiBPbiAxMi8xMS8yMDI0IDA0LjAzLCBXZWkgRmFuZyB3cm90ZToNCj4gPiBJbiB0aGUgcGt0Z2Vu
X3NhbXBsZTAxX3NpbXBsZS5zaCBzY3JpcHQsIHRoZSBkZXZpY2UgdmFyaWFibGUgaXMNCj4gPiB1
cHBlcmNhc2UgJ0RFVicgaW5zdGVhZCBvZiBsb3dlcmNhc2UgJ2RldicuIEJlY2F1c2Ugb2YgdGhp
cyB0eXBvLCB0aGUNCj4gPiBzY3JpcHQgY2Fubm90IGVuYWJsZSBVRFAgdHggY2hlY2tzdW0uDQo+
ID4NCj4gPiBGaXhlczogNDYwYTlhYTIzZGU2ICgic2FtcGxlczogcGt0Z2VuOiBhZGQgVURQIHR4
IGNoZWNrc3VtIHN1cHBvcnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFu
Z0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgc2FtcGxlcy9wa3RnZW4vcGt0Z2VuX3NhbXBsZTAx
X3NpbXBsZS5zaCB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NhbXBsZXMvcGt0Z2VuL3BrdGdl
bl9zYW1wbGUwMV9zaW1wbGUuc2gNCj4gPiBiL3NhbXBsZXMvcGt0Z2VuL3BrdGdlbl9zYW1wbGUw
MV9zaW1wbGUuc2gNCj4gPiBpbmRleCBjZGI5ZjQ5N2Y4N2QuLjY2Y2I3MDc0NzllNiAxMDA3NTUN
Cj4gPiAtLS0gYS9zYW1wbGVzL3BrdGdlbi9wa3RnZW5fc2FtcGxlMDFfc2ltcGxlLnNoDQo+ID4g
KysrIGIvc2FtcGxlcy9wa3RnZW4vcGt0Z2VuX3NhbXBsZTAxX3NpbXBsZS5zaA0KPiANCj4gV2h5
IGFyZSB5b3Ugb25seSBmaXhpbmcgb25lIHNjcmlwdD8NCj4gDQoNCk90aGVyIHNjcmlwdHMgYXJl
IGNvcnJlY3QsIGJlY2F1c2UgdGhleSBhcmUgYWxsIG11bHRpLXRocmVhZGVkLCAiZGV2IiBpcw0K
ZGVmaW5lZCBmb3IgZWFjaCB0aHJlYWQgbGlrZSBiZWxvdy4NCg0KZGV2PSR7REVWfUAke3RocmVh
ZH0NCg0KDQo+IFRoZSBmaXhlcyBjb21taXQgNDYwYTlhYTIzZGU2IGNoYW5nZXMgbWFueSBmaWxl
cywgaW50cm9kdWNpbmcgdGhpcyBidWcuDQo+IA0KPiA+IEBAIC03Niw3ICs3Niw3IEBAIGlmIFsg
LW4gIiREU1RfUE9SVCIgXTsgdGhlbg0KPiA+ICAgICAgIHBnX3NldCAkREVWICJ1ZHBfZHN0X21h
eCAkVURQX0RTVF9NQVgiDQo+ID4gICBmaQ0KPiA+DQo+ID4gLVsgISAteiAiJFVEUF9DU1VNIiBd
ICYmIHBnX3NldCAkZGV2ICJmbGFnIFVEUENTVU0iDQo+ID4gK1sgISAteiAiJFVEUF9DU1VNIiBd
ICYmIHBnX3NldCAkREVWICJmbGFnIFVEUENTVU0iDQo+ID4NCj4gDQo+IFRoaXMgZml4IGxvb2tz
IGNvcnJlY3QsIGJ1dCB3ZSBhbHNvIG5lZWQgdG8gZml4IG90aGVyIHNjcmlwdHMNCj4gDQo+ID4g
ICAjIFNldHVwIHJhbmRvbSBVRFAgcG9ydCBzcmMgcmFuZ2UNCj4gPiAgIHBnX3NldCAkREVWICJm
bGFnIFVEUFNSQ19STkQiDQo+IA0KPiANCj4gJCBnaXQgd2hhdGNoYW5nZWQgLTEgNDYwYTlhYTIz
ZGU2IHwgZ3JlcCAnTSAgICAgc2FtcGxlcyd8IGF3ayAtRk0NCj4gJ3twcmludCAkMn0nDQo+IAlz
YW1wbGVzL3BrdGdlbi9wYXJhbWV0ZXJzLnNoDQo+IAlzYW1wbGVzL3BrdGdlbi9wa3RnZW5fc2Ft
cGxlMDFfc2ltcGxlLnNoDQo+IAlzYW1wbGVzL3BrdGdlbi9wa3RnZW5fc2FtcGxlMDJfbXVsdGlx
dWV1ZS5zaA0KPiAJc2FtcGxlcy9wa3RnZW4vcGt0Z2VuX3NhbXBsZTAzX2J1cnN0X3NpbmdsZV9m
bG93LnNoDQo+IAlzYW1wbGVzL3BrdGdlbi9wa3RnZW5fc2FtcGxlMDRfbWFueV9mbG93cy5zaA0K
PiAJc2FtcGxlcy9wa3RnZW4vcGt0Z2VuX3NhbXBsZTA1X2Zsb3dfcGVyX3RocmVhZC5zaA0KPiAJ
c2FtcGxlcy9wa3RnZW4vcGt0Z2VuX3NhbXBsZTA2X251bWFfYXdhcmVkX3F1ZXVlX2lycV9hZmZp
bml0eS5zaA0KPiANCj4gVGhhbmtzIGZvciBzcG90dGluZyB0aGlzLCBidXQgcGxlYXNlIGFsc28g
Zml4IHRoZSBvdGhlciBzY3JpcHRzIDotKQ0KPiANCj4gLS1KZXNwZXINCg==

