Return-Path: <netdev+bounces-206502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09ABB034C4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25FB1898229
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77AD1DF24F;
	Mon, 14 Jul 2025 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmwOtGhd"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F721448E3;
	Mon, 14 Jul 2025 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462450; cv=fail; b=S87mA4Wa8bvzcoXozoSM6vbhL+c7SINl/wCxpCl7sZLS0Xg8hTFiMhq/nAg1h9HTPaNQxjNZ0wlrIYdsOMCbfxx2Vb7HLh7Eyy/IMTvQHuF5Tbq1yi9w1Dse1XO/3j/81a6HXWEAY63QT2N9Ry/MVzuElZHYlXbWKQY9I2894bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462450; c=relaxed/simple;
	bh=ATOVU54D21C0K26EMSYZwQrLXXDQVKCgGecIU3Cfs0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6TGhnPKWCcJbqEU8disUHPOYmxrWVPxvp5S/aHvjSfpf9mFd5WIrigpeYRT5zWfp1RFZ6YYURkpBIVI1KcaZXV+vgHFQuiwczS88JuqkePVTuOYs9U3/rCFDZzgtR3YbGneRoY5HF2SU7z6rFjeL8CVPS5mSohz1JVDCP/wsBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TmwOtGhd; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTcaGfhbY1QccyRcT7ID8SP1i5Bst8kH6cHfh7RUhOsmG/s0D3D8sF+ZyPZ/j5pGA+VgIh6tZnh865LE9IYSPQbULf3ipFTcoq83ZbfhYWAM1QSP7REKVtHaerRaOLEF6KGzjvLNM6+EFbpFbt7wgaLIvKdizAkTqj2FKJNxdG+CKX9ajzeoLWOMvZy69fW6ZJ5rSa0oOoMPZz9hAquQ5qcuhpQ7aDGF174wUcLpUArshVDalqrSslimAHEqkVJRWrLbExW9VbKGg51Ej1m1BA85TLCU77t3aTOpkdMnO/CKnPFEVGqp4/kvGEpEdY3HQCjpumD+omP2cj1Mue2Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATOVU54D21C0K26EMSYZwQrLXXDQVKCgGecIU3Cfs0w=;
 b=tExyscguAFPajwCNmwSUfVwH9yaV9434r5bVpdy4l6TrgFuFHzhJAvx3JpbmS/zXo6K2khmHIb+YTSmsIwqjB04LHmNHsS0pOofU+nhDX2PBhomb3pJxZVbEz9OEg1kQkgVD6N88izWJZu7SYWswUQZUIG3x2n0+mZ16e8Iy70g01VgvcdKuwzSSF7GtDzcZd/VfLSiXTzKp6khXgG3kqFI4WjhRodP8EXkGe35VT6bJupOzi3dNYYzz+qSxFQJ+pTuQYDYzplpbeCMzwvcNccsvx0EOHOmOHpXCqgzIv2Vc8VYdmDM18Lwv8Z8zC+gg7ICUBI5oW42C94AKywNbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATOVU54D21C0K26EMSYZwQrLXXDQVKCgGecIU3Cfs0w=;
 b=TmwOtGhdFkrqE3mt85bsuHAnsJJ6Zzupaj5S/ictb4ODTz5QaEVN03f10JvJJ9KDdSdyMd3Kdex9ntbjRslPBBssGG/rMcY4GFpBe9LoyH5yTGXdnCSS0lGR8+L8CoLc6O2QGRcYYu9O3R2irZqWwuKewDWx+o1LNZJ6wTqL6dmiaSM2MkbV+Btz32MOsNPT3zvFv6EX27hzuMLgfwk2TCwAYJiCEO4j7b8/QdNd5Cjli0Q8dyAMRRKva6SQJ5bYenkb0ntZ2cgsuKazic3g7emEcZsVPNtndDDt1FwQiMTAoNvnxe/BzNMiClkGeN3DpNyMqi7PcEqs4MXP8KdgnQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8068.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 03:07:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 03:07:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vadim Fedorenko <vfedorenko@novek.ru>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 08/12] net: enetc: save the parsed information of
 PTP packet to skb->cb
Thread-Topic: [PATCH net-next 08/12] net: enetc: save the parsed information
 of PTP packet to skb->cb
Thread-Index: AQHb8jPtRFcrashaT0ueCXlvkQ3KZLQuUjcAgAKhXxA=
Date: Mon, 14 Jul 2025 03:07:25 +0000
Message-ID:
 <PAXPR04MB85101AA274D7B11B3E31EC078854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-9-wei.fang@nxp.com>
 <40a32a8b-11d4-48fb-b626-66239a4797a5@novek.ru>
In-Reply-To: <40a32a8b-11d4-48fb-b626-66239a4797a5@novek.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8068:EE_
x-ms-office365-filtering-correlation-id: 3090459e-c6bb-4e75-d810-08ddc2838f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDFEVDNtVjdTWGs3YUl5SWNJNDBaSlRqMlAwTE5WWVJNKysrcTVxYXRUYXFG?=
 =?utf-8?B?dTZXVXdya3ZBbEFJRGxHSkVjQnMxVE5pM0N4WFlUMUlZOU1zMWlPWVdnWSt0?=
 =?utf-8?B?R1JlbUN3MlQvNzhwVzRkb25jcTRET1hjZzZ3VWtwSFFCU0R2MGhQTzdrV0xP?=
 =?utf-8?B?LzNIZ285Q3BJak1neC8yUVgzMEdxRzB4OW1hK3RoaUNBaEJtWWlKZm1RRWk0?=
 =?utf-8?B?dk5tczd0amF1bWRzVVhLTDZmamsvWk43WnFCQXJaRzg1T1ROOE0wYWZpeksw?=
 =?utf-8?B?Y092MDluR3MwS2crVW1wMUdJalRkRXNzRGNXaW91VUZTdUJHbGNOejVaSXkz?=
 =?utf-8?B?bWU5RnNicUtYc1EzU3puR0ZkY0hkdjc4KytleE1tV0tmajZFYW5Xd1R1WU5o?=
 =?utf-8?B?blRIUUp2ZlpsZmZGYUNMb0d4clovWjdYWEJJQTJZaDRVdGE2SFdwRC9zRmhX?=
 =?utf-8?B?bUN2TEVSZmU1TzhXUExnL21TUHVxUnZMSVIxUnorVE1tSWYrWFE3L2N2WVow?=
 =?utf-8?B?djVGbEs5SytNNVV2RTI2ZEhjM3UxV1Z4UzdLWDBqUDRuR2txQlBwL3BQN1lK?=
 =?utf-8?B?dmN5NUNLUGtFdFRGRXpXZW9zT3RhaEx5dWloUDZ2Wlo0V3VEMHc5V3VpZXBZ?=
 =?utf-8?B?MGtSV0k1bCtXbkNOKzU4am1RNHFEbzlIaVhxUFJCeURsNzk4eTRtY0RmdURE?=
 =?utf-8?B?UFBJa2VQclJUd1hTY2VxY0VaeGRHWTlUcG9iM2thT3FKeXdtdzVsSjFTTHpa?=
 =?utf-8?B?UFdPWWJMOWxuMUtaUEZCZ2JIVGVwU3pia3RnNVdWM2NzUkpnb0p4RzQ3YWg5?=
 =?utf-8?B?MFdoYk15VGVhR2wzQmZTQWNuRkhaNXZVdGZsQ0RzVnNYeHVOV00vZE9Oa0hS?=
 =?utf-8?B?dXBFSlVoaWhxbUZwR0hQVElCZ1NwWTJJQ0E2Z2E1Q3ZTd2drOG8zNjZ0VSt4?=
 =?utf-8?B?clMyaGF3bFJNS1JJWklqOHJ0UEo3ZHhCRHZiaGtLRGh5dzhIRU9taFA0S0Fy?=
 =?utf-8?B?ZUZXQWhqbXdUSXVxaXhHTGZoTFpVek5hSEtKNSs1LzE1MzJhMWt0VisydUdM?=
 =?utf-8?B?T3ZPTk51MDZ4WncwNW16WGxabXBzbERoa3NZcEdHRnpyRFlIL1kvZVlheXJF?=
 =?utf-8?B?cXZDVWVWVkw4YWxzbzU3WnpGb2lOY1gyMnhQdlloVHpsa00yYzhRbmlOeUpZ?=
 =?utf-8?B?U2lqRXFwd1Q1Y2hpMGtnWWVHVWkvbVJDZzJhajlZcnJSNnBMbGpNWjN5M3hD?=
 =?utf-8?B?UC9XeDRnblQ1QzlUT2sxTFNpY2h1SGFTQUFCWXBRQ0lCaE94NXYxUTNXT1VR?=
 =?utf-8?B?MHVhQ3hpSTJXUEcrN2QvdDNER0d5Uk1LS1cxK0lkWFR5YlE2Mzhtd2lVUFdw?=
 =?utf-8?B?ZFJ6QkRNOFRFL2MwalorRTRTK2h0aU9TanJPalpFSWZ5V21vK05IWkE0cHhO?=
 =?utf-8?B?cC9nR0VPbHczUTFqRmkxekdlamo1VmhoM2hwbUY5eTdXN2hwWWlPWWdKS1lt?=
 =?utf-8?B?SlpmaEhGblY0T1dPT0hDcjlKWVR1ckNVY2kyMFRZVnNYbHFsd0F6N2IwMmtV?=
 =?utf-8?B?cWtvZ1J5ZjN2UzltdzMxTHUrY3ZrY204ZC9nY1hrUDN6R29vWUI5aUg4TXl3?=
 =?utf-8?B?RlpPOExVRmZsYndGN0FUeUVkcE9ReWJiY2hYb3MvMXpwcGNTUURXRXVCUzVs?=
 =?utf-8?B?TGk3bnN0aXhzZUdLOUh0RWlCMTV4VDkrWFZQdjJRaGFYWFl2NXlzQmJvOWdH?=
 =?utf-8?B?S3Rkc0lJcHYydFRBdXhVaVJsdmE1UUZIOVFmNWlHNUVvWFpMUC9mZFRCTmQ4?=
 =?utf-8?B?VDV2NnJ6SjhBU2xxL1FvemUxNGdpQXZiRC9UMmdDRzZBdlRKNzYxUnhXaFBC?=
 =?utf-8?B?bWlFaDhYVGVOTzJJcGVzVG9GNzBHYktVV3hOOFNGNzZycUNqNkpQRXpqZ1Jn?=
 =?utf-8?B?ZzhsaHN6Si9hWVlLZGFIUURGUDZNSHJyeFZqOHgrbWVMbzdabkRMMGdFTkdP?=
 =?utf-8?B?U1RaNDA3T1ZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUphV2IzSXhtbkZ5VEhvdU1SMFZobEJwQWN6dWxXNWwwTmYwV0F2NytEOHZF?=
 =?utf-8?B?K2xpVDZEZ1VmK3NGdGE0eC8yMk8rOGNhdXhQT25oR0tyNkhhblg3ZlFUNmJi?=
 =?utf-8?B?MXZWMlR2UmpteWpTOWxJTldGcWdGakg3SUY4S0hsMU1FeGVMOEVTMFZJOXdo?=
 =?utf-8?B?cjRaZ1VMTzFkcy8yWlFLUnJPc1N3dUR6ZHdvazhJMy81cndRRldROXNrYkJL?=
 =?utf-8?B?cExFS1QvSEI3SmZ4Y2h5Z3gzRWREeEVPYi9TNzN3N3pjV2Vhd0JQbXdDSmpZ?=
 =?utf-8?B?VXFmZlB1enV2aC9RVVNLQlAzZXZCaHY4WStkRjE2dHJXd2Y4RXhvRi9CVmRk?=
 =?utf-8?B?Ry9qNVZjVFF2ODAvMkxUK2tKZCtYQy9EeWYzRUpjNHVCd2t1Sm9zbVJhV3Nr?=
 =?utf-8?B?TFM2MXNYQVNZK3hmMmdhTTd0S3phL1hrS09vTkhHMzh0TXlNWEs1bFRDbHlp?=
 =?utf-8?B?cmQzdlY3UC9FZUR0cnA1c281ZFNoY2l2L0xYN3VyWmJvazljN2dIUVNlSk5D?=
 =?utf-8?B?TEI3aGFBRXduR1RvdlA5RkxvbDRNMHhBajRHSWtSWDdQMEkxQ0lZNFRDT3Zv?=
 =?utf-8?B?MS8weTR5R3RtaVAyT21tZ2phSU5FRGcrajMvb0RmMkNRMTFmVXhqNm9nWW1G?=
 =?utf-8?B?MFdwL1dGQlZNWTJ5Mjlaci9NNHZQaHhtcVZGZnRtSVFlL0llb0tQSFlQdzJi?=
 =?utf-8?B?Y2VVOFlZMGdIRXVvMERydmZMRTB5a0c5dnE2VG54aGNlS1FXeVlKblB0amdJ?=
 =?utf-8?B?Y1o5WEJJME9kRGlPTlpJbzV4SU1uMm53STUyY0pmblVmTkxzdkY5cEtYMGl0?=
 =?utf-8?B?UERCZlRrMllzLzhyVW0zOFhDNldpTmhlT2QzNUs1K3JkMlQ0SndwcHY3RmdI?=
 =?utf-8?B?MGNvRGRJZm9sdWdHcDlScC9RVUNtOE1PR09FTWZBbHl2K2ExSStsalhKY2du?=
 =?utf-8?B?VVM0clU0T3F0V2cwMmVVdVFmQlRscEhNWFlhRHRNR1pwQUIwQ2NmSW5Kd1hG?=
 =?utf-8?B?NUZEb2c1MHdCQzd3aHo4T0xpM3dUZzcxWkx0UU9UcWNIRTFQemE5SU8zVzBv?=
 =?utf-8?B?RENoVDRzTnNKcVprTDlqQjlqSE1DYkpuM3JudUFQWkxUQ2Zhbm9xNGt0Nng0?=
 =?utf-8?B?NjhDSmJKWkhZYUQ1d3I5aFhKRVFERWxxUjF2OVordFlmTnVHRXg5SmI1cUpN?=
 =?utf-8?B?R3VtNGhUR3Q2ZTF5WUNqNnFEa0U5S0NyNEMyYVlYa1puaHBXMFBYNW5xQ2VL?=
 =?utf-8?B?OVRkZlNNTWs5clRya2VHZmI4Z01UbmtROXpnSDg0My85ZTBCMm10ODNWQ3Js?=
 =?utf-8?B?VE1FVVBScGloeDA1NTBSalZGek83dThZcDlkTlVYSitGVzV4OGdxNXV1RVlh?=
 =?utf-8?B?UWRPcFB6Zk5qbHAyNE9ETExLcnFGU3Z2NzNHei9FT0IwUUt4NTl2RVdyTERl?=
 =?utf-8?B?cTFBUlhuMGR4bDlabWM2Y3R0Q3JmNGgraTNreHpFRmtPY2MxM05mR3Mxa1JK?=
 =?utf-8?B?V1cyWmM5cklwaC8wRXJRcmdvbjRxSytlQWVCZ28yb09kNTA2V1ZwbkY2NG13?=
 =?utf-8?B?K3ByR1lxNm84Q0Z3Z0N5YkJwM1ZKVW1aLy9lVFRNZjlkR25TTXR3eTJoRlZ6?=
 =?utf-8?B?TzlENHAxSFE0Wk1xL2syL2ZMeGJ6L2xXcE5XQmpkOVovN2xrMUtMQ3Fqa2Rz?=
 =?utf-8?B?aGRjRVBXV2JYQXVpMFRnOTNMOUMwWFlkaUJUTTBwUEp6ZkI0RmIyL2F2WHBT?=
 =?utf-8?B?b0dEand4bFhmTnptRGt3Z2FjSWVRelJERC9VUGxTZWlMM2dDUUFWUngzVm9S?=
 =?utf-8?B?TmxEbjdtWVl1WVNuNlFncVE0MFR4NllMQ29zYkhTRWRFMzRBOGNxN2pKaDVq?=
 =?utf-8?B?amptODBJNXVHS1VHVUR2Q2ErYXhQSFNFSVc5M0xjejZ4WDAwcUpweUtEV3NR?=
 =?utf-8?B?UzlDTjk0UEhPR0MrclpWMHJzWkJ2RmpkbnZ0c2krTHZwVG9TdU9kb1NaNU9C?=
 =?utf-8?B?SmNGYlpGUWtrWWl4ZjA2QTFkMmZ1c1hVOTRLMXNiMlFZeFE4ZEQ4Mm9mNUxy?=
 =?utf-8?B?a2RxNGFaRnAzTkdHL3VuMDNtYkpOaWk0NUdtcVN5T21zRkJtNU9WWUxJcFcw?=
 =?utf-8?Q?42Hs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3090459e-c6bb-4e75-d810-08ddc2838f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 03:07:25.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QI6mtvHS60D9MRUPqQkioWeIwONLZeIZpeWqoslQZNHfYMVmvBdyNv+Ljgbks7b4WscJPrWSkWvGzRqTf29vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8068

PiA+IEBAIC0yMjUsMTMgKzIyNSwxMiBAQCBzdGF0aWMgaW50IGVuZXRjX21hcF90eF9idWZmcyhz
dHJ1Y3QgZW5ldGNfYmRyDQo+ICp0eF9yaW5nLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAg
ew0KPiA+ICAgCWJvb2wgZG9fdmxhbiwgZG9fb25lc3RlcF90c3RhbXAgPSBmYWxzZSwgZG9fdHdv
c3RlcF90c3RhbXAgPSBmYWxzZTsNCj4gPiAgIAlzdHJ1Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2
ID0gbmV0ZGV2X3ByaXYodHhfcmluZy0+bmRldik7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfc2tiX2Ni
ICplbmV0Y19jYiA9IEVORVRDX1NLQl9DQihza2IpOw0KPiA+ICAgCXN0cnVjdCBlbmV0Y19odyAq
aHcgPSAmcHJpdi0+c2ktPmh3Ow0KPiA+ICAgCXN0cnVjdCBlbmV0Y190eF9zd2JkICp0eF9zd2Jk
Ow0KPiA+ICAgCWludCBsZW4gPSBza2JfaGVhZGxlbihza2IpOw0KPiA+ICAgCXVuaW9uIGVuZXRj
X3R4X2JkIHRlbXBfYmQ7DQo+ID4gLQl1OCBtc2d0eXBlLCB0d29zdGVwLCB1ZHA7DQo+ID4gICAJ
dW5pb24gZW5ldGNfdHhfYmQgKnR4YmQ7DQo+ID4gLQl1MTYgb2Zmc2V0MSwgb2Zmc2V0MjsNCj4g
PiAgIAlpbnQgaSwgY291bnQgPSAwOw0KPiA+ICAgCXNrYl9mcmFnX3QgKmZyYWc7DQo+ID4gICAJ
dW5zaWduZWQgaW50IGY7DQo+ID4gQEAgLTI4MCwxNiArMjc5LDEwIEBAIHN0YXRpYyBpbnQgZW5l
dGNfbWFwX3R4X2J1ZmZzKHN0cnVjdCBlbmV0Y19iZHINCj4gKnR4X3JpbmcsIHN0cnVjdCBza19i
dWZmICpza2IpDQo+ID4gICAJY291bnQrKzsNCj4gPg0KPiA+ICAgCWRvX3ZsYW4gPSBza2Jfdmxh
bl90YWdfcHJlc2VudChza2IpOw0KPiA+IC0JaWYgKHNrYi0+Y2JbMF0gJiBFTkVUQ19GX1RYX09O
RVNURVBfU1lOQ19UU1RBTVApIHsNCj4gPiAtCQlpZiAoZW5ldGNfcHRwX3BhcnNlKHNrYiwgJnVk
cCwgJm1zZ3R5cGUsICZ0d29zdGVwLCAmb2Zmc2V0MSwNCj4gPiAtCQkJCSAgICAmb2Zmc2V0Mikg
fHwNCj4gPiAtCQkgICAgbXNndHlwZSAhPSBQVFBfTVNHVFlQRV9TWU5DIHx8IHR3b3N0ZXApDQo+
ID4gLQkJCVdBUk5fT05DRSgxLCAiQmFkIHBhY2tldCBmb3Igb25lLXN0ZXAgdGltZXN0YW1waW5n
XG4iKTsNCj4gPiAtCQllbHNlDQo+ID4gLQkJCWRvX29uZXN0ZXBfdHN0YW1wID0gdHJ1ZTsNCj4g
PiAtCX0gZWxzZSBpZiAoc2tiLT5jYlswXSAmIEVORVRDX0ZfVFhfVFNUQU1QKSB7DQo+ID4gKwlp
ZiAoZW5ldGNfY2ItPmZsYWcgJiBFTkVUQ19GX1RYX09ORVNURVBfU1lOQ19UU1RBTVApDQo+ID4g
KwkJZG9fb25lc3RlcF90c3RhbXAgPSB0cnVlOw0KPiA+ICsJZWxzZSBpZiAoZW5ldGNfY2ItPmZs
YWcgJiBFTkVUQ19GX1RYX1RTVEFNUCkNCj4gPiAgIAkJZG9fdHdvc3RlcF90c3RhbXAgPSB0cnVl
Ow0KPiA+IC0JfQ0KPiA+DQo+ID4gICAJdHhfc3diZC0+ZG9fdHdvc3RlcF90c3RhbXAgPSBkb190
d29zdGVwX3RzdGFtcDsNCj4gPiAgIAl0eF9zd2JkLT5xYnZfZW4gPSAhIShwcml2LT5hY3RpdmVf
b2ZmbG9hZHMgJiBFTkVUQ19GX1FCVik7IEBADQo+ID4gLTMzMyw2ICszMjYsOCBAQCBzdGF0aWMg
aW50IGVuZXRjX21hcF90eF9idWZmcyhzdHJ1Y3QgZW5ldGNfYmRyICp0eF9yaW5nLA0KPiBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAgCQl9DQo+ID4NCj4gPiAgIAkJaWYgKGRvX29uZXN0ZXBf
dHN0YW1wKSB7DQo+ID4gKwkJCXUxNiB0c3RhbXBfb2ZmID0gZW5ldGNfY2ItPm9yaWdpbl90c3Rh
bXBfb2ZmOw0KPiA+ICsJCQl1MTYgY29ycl9vZmYgPSBlbmV0Y19jYi0+Y29ycmVjdGlvbl9vZmY7
DQo+ID4gICAJCQlfX2JlMzIgbmV3X3NlY19sLCBuZXdfbnNlYzsNCj4gPiAgIAkJCXUzMiBsbywg
aGksIG5zZWMsIHZhbDsNCj4gPiAgIAkJCV9fYmUxNiBuZXdfc2VjX2g7DQo+ID4gQEAgLTM2Miwz
MiArMzU3LDMyIEBAIHN0YXRpYyBpbnQgZW5ldGNfbWFwX3R4X2J1ZmZzKHN0cnVjdCBlbmV0Y19i
ZHINCj4gKnR4X3JpbmcsIHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gICAJCQluZXdfc2VjX2gg
PSBodG9ucygoc2VjID4+IDMyKSAmIDB4ZmZmZik7DQo+ID4gICAJCQluZXdfc2VjX2wgPSBodG9u
bChzZWMgJiAweGZmZmZmZmZmKTsNCj4gPiAgIAkJCW5ld19uc2VjID0gaHRvbmwobnNlYyk7DQo+
ID4gLQkJCWlmICh1ZHApIHsNCj4gPiArCQkJaWYgKGVuZXRjX2NiLT51ZHApIHsNCj4gPiAgIAkJ
CQlzdHJ1Y3QgdWRwaGRyICp1aCA9IHVkcF9oZHIoc2tiKTsNCj4gPiAgIAkJCQlfX2JlMzIgb2xk
X3NlY19sLCBvbGRfbnNlYzsNCj4gPiAgIAkJCQlfX2JlMTYgb2xkX3NlY19oOw0KPiA+DQo+ID4g
LQkJCQlvbGRfc2VjX2ggPSAqKF9fYmUxNiAqKShkYXRhICsgb2Zmc2V0Mik7DQo+ID4gKwkJCQlv
bGRfc2VjX2ggPSAqKF9fYmUxNiAqKShkYXRhICsgdHN0YW1wX29mZik7DQo+ID4gICAJCQkJaW5l
dF9wcm90b19jc3VtX3JlcGxhY2UyKCZ1aC0+Y2hlY2ssIHNrYiwgb2xkX3NlY19oLA0KPiA+ICAg
CQkJCQkJCSBuZXdfc2VjX2gsIGZhbHNlKTsNCj4gPg0KPiA+IC0JCQkJb2xkX3NlY19sID0gKihf
X2JlMzIgKikoZGF0YSArIG9mZnNldDIgKyAyKTsNCj4gPiArCQkJCW9sZF9zZWNfbCA9ICooX19i
ZTMyICopKGRhdGEgKyB0c3RhbXBfb2ZmICsgMik7DQo+ID4gICAJCQkJaW5ldF9wcm90b19jc3Vt
X3JlcGxhY2U0KCZ1aC0+Y2hlY2ssIHNrYiwgb2xkX3NlY19sLA0KPiA+ICAgCQkJCQkJCSBuZXdf
c2VjX2wsIGZhbHNlKTsNCj4gPg0KPiA+IC0JCQkJb2xkX25zZWMgPSAqKF9fYmUzMiAqKShkYXRh
ICsgb2Zmc2V0MiArIDYpOw0KPiA+ICsJCQkJb2xkX25zZWMgPSAqKF9fYmUzMiAqKShkYXRhICsg
dHN0YW1wX29mZiArIDYpOw0KPiA+ICAgCQkJCWluZXRfcHJvdG9fY3N1bV9yZXBsYWNlNCgmdWgt
PmNoZWNrLCBza2IsIG9sZF9uc2VjLA0KPiA+ICAgCQkJCQkJCSBuZXdfbnNlYywgZmFsc2UpOw0K
PiA+ICAgCQkJfQ0KPiA+DQo+ID4gLQkJCSooX19iZTE2ICopKGRhdGEgKyBvZmZzZXQyKSA9IG5l
d19zZWNfaDsNCj4gPiAtCQkJKihfX2JlMzIgKikoZGF0YSArIG9mZnNldDIgKyAyKSA9IG5ld19z
ZWNfbDsNCj4gPiAtCQkJKihfX2JlMzIgKikoZGF0YSArIG9mZnNldDIgKyA2KSA9IG5ld19uc2Vj
Ow0KPiA+ICsJCQkqKF9fYmUxNiAqKShkYXRhICsgdHN0YW1wX29mZikgPSBuZXdfc2VjX2g7DQo+
ID4gKysJCQkqKF9fYmUzMiAqKShkYXRhICsgdHN0YW1wX29mZiArIDIpID0gbmV3X3NlY19sOw0K
PiA+ICsrCQkJKihfX2JlMzIgKikoZGF0YSArIHRzdGFtcF9vZmYgKyA2KSA9IG5ld19uc2VjOw0K
PiANCj4gVGhpcyBsb29rcyBsaWtlIG1lcmdlIGNvbmZsaWN0IGFydGlmYWN0Li4uDQoNCk5vLCBJ
IGhhdmUgY2hhbmdlZCB0aGUgdmFyaWFibGUgbmFtZXMgKHNlZSBiZWxvdykgLCB3aGljaCBhcmUg
bW9yZSBlYXNpZXIgdG8NCnVuZGVyc3RhbmQgd2hhdCB0aGUgdmFyaWFibGVzIG1lYW4uIEkgc2hv
dWxkIGFkZCBhIGRlc2NyaXB0aW9uIHRvIHRoZSBjb21taXQNCm1lc3NhZ2UgdG8gc3RhdGUgdGhp
cyBjaGFuZ2UuDQoNCi0JdTE2IG9mZnNldDEsIG9mZnNldDI7DQorCQkJdTE2IHRzdGFtcF9vZmYg
PSBlbmV0Y19jYi0+b3JpZ2luX3RzdGFtcF9vZmY7DQorCQkJdTE2IGNvcnJfb2ZmID0gZW5ldGNf
Y2ItPmNvcnJlY3Rpb25fb2ZmOw0KDQo+IA0KPiA+DQo+ID4gICAJCQkvKiBDb25maWd1cmUgc2lu
Z2xlLXN0ZXAgcmVnaXN0ZXIgKi8NCj4gPiAgIAkJCXZhbCA9IEVORVRDX1BNMF9TSU5HTEVfU1RF
UF9FTjsNCj4gPiAtCQkJdmFsIHw9IEVORVRDX1NFVF9TSU5HTEVfU1RFUF9PRkZTRVQob2Zmc2V0
MSk7DQo+ID4gLQkJCWlmICh1ZHApDQo+ID4gKwkJCXZhbCB8PSBFTkVUQ19TRVRfU0lOR0xFX1NU
RVBfT0ZGU0VUKGNvcnJfb2ZmKTsNCj4gPiArCQkJaWYgKGVuZXRjX2NiLT51ZHApDQo+ID4gICAJ
CQkJdmFsIHw9IEVORVRDX1BNMF9TSU5HTEVfU1RFUF9DSDsNCj4gPg0KPiA+ICAgCQkJZW5ldGNf
cG9ydF9tYWNfd3IocHJpdi0+c2ksIEVORVRDX1BNMF9TSU5HTEVfU1RFUCwgQEANCg0K

