Return-Path: <netdev+bounces-243520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645BCA2F02
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30F4130328D0
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCEA339B3C;
	Thu,  4 Dec 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i8avh/5/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC48339B32;
	Thu,  4 Dec 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839464; cv=fail; b=nI/Toa6K4APYYh1iC+qu74RK180R4zDkvH/ruKgnh4ONe6IaOoC3xahkdGamWFTW5RdZsS2Y7mmqJF+PzBOC/OKDsZ774V+mOXe5cpQx/Gr/+Bi0p5viRbuoWa1wP0tciaLOpHy+IhMwWQTUNBgdVJgvaV2qB+ozTQ/XiBIIFRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839464; c=relaxed/simple;
	bh=YVhQ7450NA4NEtTl/gzB7BZ8BxnBgeK1MjYZkLmFtsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4W+m/CT7xiwsQPwqXneng3gQ1JnGLRibOg/UpBDvSuCuG5aGuMIKhuawkC0JXR4WI9V9DG5ONWgPJG/IbjJtpPDfwzishSHVy+AOqvCz6mALiX6oz+/oxU4OFPhAgdPtpMwpGcjNmfb1e4JrEKvwKvpx2HQmpxqmOiQ3vJhNfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i8avh/5/; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBJVgfsJGYYp7q/GpEd6R5jgaUJwnGcwFEVbbJ/S+HBUI3miJ/U6JBfqKZ4xKHdqcQSppDpE0ZDsV9DBjo/WjpWyzMVLK83JhEXRBAiZ0ZyH4rHamwXPA4vGqeX26yFrOorZAD/jteVJtYJomFQ7KXItf6bPYc+xkEUxACFG47gV9MGxETc5UQtSIgM8QOvV6+mbJigy/r+rly2r1iFfnVg//tsInSlR3ExRIKghxGiXjy9KN+woBg9ItAAxraXnu0E72H5MiIwoXZWOCybkXJPRYyfDEnx+wsP12X9v4InW6SOzSRIlPICwh4VuQBpvVA/fOG7UnHYNpbdR9Fq8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVhQ7450NA4NEtTl/gzB7BZ8BxnBgeK1MjYZkLmFtsM=;
 b=mELIZmXWDmmNoKO28+gIH2uUCwyepLM1J58/GXrN9yOmGpdisNoMkAHzqKlgQvJVDqFzrJhJXiRMD+ebffKYO9HbFQcCDpz29lub7/zhi/xKir5njXFap6fCCDqW20rv0peNf5pLg/pzE/HSzwVIsrbHr1vKakUDXbGtOERklUsuCFXZxGEKg/cEcLob695kFdxbhY8im2GfW20zYvbuWE+UdkazIFdtW/qcvthPESNi8olai5zcQxiP1idw3QdEvJ7NRqvRcsuo0MCBCjL9GvMQSw3LiOvdjivsFa9EgInWOP6nB1EAQ5ApeIJlDF/76jyl1dCH4qj7c2QBHibudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVhQ7450NA4NEtTl/gzB7BZ8BxnBgeK1MjYZkLmFtsM=;
 b=i8avh/5/MsN6CpZJqtA56bS3tJcAtAv3NazRLZIiB4NEcqDIPTJ9SkIBlwXUwTzX8RVv7I7V55VuDtzPCddFUmpSvlGUsLvLvP4+DDFg4/7szfoRN5xGPzrk/bZo3H4hacsnj7werp1ZNhxwBVP/25f6tf5+k9dFsDJiH+3kvhJ4D+DrKy3EuZPFYy3cy+5+XUqN+XcQia8yiPTMkT0eYcOPqeRaSgxjTHd0kPk1lRUJZUSYL93AKBQS228WLNCnwbOndJHjmgyoaChX5CY2ptUqa1O0p8enE7G49Z9D9PDFk+g4YjOvNOHl3HgzUc77nHaigpSQPMcUqTbnhz/oFg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU7PR04MB11236.eurprd04.prod.outlook.com (2603:10a6:10:5b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 09:10:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 09:10:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: ERR007885 Workaround for XDP TX path
Thread-Topic: [PATCH net] net: fec: ERR007885 Workaround for XDP TX path
Thread-Index: AQHcYBLfl2R9Iipv/0Sq7gOUyMIngbURNuSAgAADz1A=
Date: Thu, 4 Dec 2025 09:10:53 +0000
Message-ID:
 <PAXPR04MB8510A9A2B763664AEB720A7588A6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251128025915.2486943-1-wei.fang@nxp.com>
 <cfc92b7c-b376-4de0-83a7-f7080c6f24d9@redhat.com>
In-Reply-To: <cfc92b7c-b376-4de0-83a7-f7080c6f24d9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU7PR04MB11236:EE_
x-ms-office365-filtering-correlation-id: c1bad869-1d25-49fc-a9d3-08de33150700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2FVdnV1V256WU1UMzZhSDRMWjhSSGtHT1ZEMUQxVDRMZTNkcUIvMnNtblRv?=
 =?utf-8?B?c0ZMTVh1dXU0cVdweEpwb2kzT0RiekZCTFh6WkpKVGp4ZW9BdnYrKzFlbUcz?=
 =?utf-8?B?YmlsbER5cXlyTE1USGdsM1NYcjRLNitrU1JKT2JPMjFxMEFyc09jUHZPWjdK?=
 =?utf-8?B?a1QxM09DVGM4SzhMNXRQdlZQeTdIZnVnT29IK1Iyd0E4bWhXREI1S0Q5MzdU?=
 =?utf-8?B?ZVUyMGkvaCsvVFh3TTdSdXA3RGhkcThEKzlvRmp5TGpWSURRdFdONlI3bWRV?=
 =?utf-8?B?eDNXNzVNMzl5OGxwTEpoZXgrZHJLTm14T1Zwdi9DbkxFMlZsNjdNZ084V0g5?=
 =?utf-8?B?cjBDTllGelRqUHFwTitkZUZtakhSUlhDUnNqQ3NESEZoRGRuL0dSTVBrbmk3?=
 =?utf-8?B?c01jaGZtRllSYU5hejJ6VnNNRWd2Vm04UDgwRC9qQkdHQ3lKL2lrSkw4UkFN?=
 =?utf-8?B?Vk1Bc2ZReCtnc1NLdnVZei9PSFdrOG1BMFkwZGZTcnVxYnBMWS9ZWi9uTllw?=
 =?utf-8?B?ZHhSN0hzZmlUcEtEY3F6QmxHSzdHRlN2UTR1aUFOU3hiN2Rob0dEbnBMYVZi?=
 =?utf-8?B?T011WXg5ajVpanlzWkt0Q1p1WWxkNnRsZGh2SVZYUERmaGF4Ny96NEF2UWFx?=
 =?utf-8?B?czFOKzlYVVBKck82ZGs0UnBiQkFmQ3B3ZVlCek1BenBrWlprZmtkYzQ5NHpB?=
 =?utf-8?B?ekgwRFFtaEkyc3dyb1IzWWdkcHBnSmFnbXVNTlZhYXFBWVA1KzdWeDlzdHJo?=
 =?utf-8?B?UFlsbWVJQkc2cWNNUDcyVW1pRUpmaVFRcEJpeU1zUGtEcEJsVDBKTTFQZE5E?=
 =?utf-8?B?dWNQQ1lPMHNPNDhhbExzblB6eFFSLzdZTE1ZdmFkSGNrMHdndzhvdGRQV1h0?=
 =?utf-8?B?NTFmejdsOXNoMm81aUczTTNIRDN3OWM1MG5XTGY4NHBHSnBjbHh2MVRwemlp?=
 =?utf-8?B?SUI4dFRUdVNHTDdjaDRLNVBISllyMXdmcXFDTWc5ODlBTFV3ZVRyU1hYYUdm?=
 =?utf-8?B?ZTN2U1R4WGUxaVFHN2VZTU9UeGcxYmczQXZrNy90K1JXNUVPSGd0U1VXU2dN?=
 =?utf-8?B?K0VyTlgxdk54SnNJc0dkUGEyZ3M0ejIwanFQRUVaNk9KUXVKUkVERG5xNktJ?=
 =?utf-8?B?VGovNzhrM1ZUZ2Y4djZaREp3ODlzSmRnUlU5dCtxeGYzUVNGZkFqNS9vTTMv?=
 =?utf-8?B?ajh5ODNabnlRVXhlQlpURExqVnB3MitxRERobzNSTEpTTnVPTDZiRDRER3g2?=
 =?utf-8?B?Y0Y2WnpVMk9CdE1yU0N5ck9kbXV5STNJVW9sSWZidjJpNGxRSkxTYnRCWWli?=
 =?utf-8?B?UXMyaEM3YnR2Uk81Z214c2ptNEMzUHhGMGlxV3NDc3IrMTRaL1RBUG1VdXpO?=
 =?utf-8?B?L0xhVENqLzFNWndaN1lsbXhKdWNUbzhuQTJLUGNBRUhWd1E4UlRaZnMyNk96?=
 =?utf-8?B?MmNPcUZuVjQ2L0UrRnM5VHZUdnJnYXBjY3ExZ0RZYVJXakU2aUc0S3FsZ1FW?=
 =?utf-8?B?cFpiVTREWEh3YkR1MlBMOXpuSDZiRDBVK2pLdURVcDlRUFk2ZVlBQ092QkJE?=
 =?utf-8?B?ajc4M29TZU5UNmNkYW5IejFLYlBWSU1ZL3lzbDVMWHpPUG0wc05DMENLeWVY?=
 =?utf-8?B?K0h4K25COGU0TXZDWThHS3FYQzVpbGt0dUhZQ1hpREpMYkFUdy9LNlBTQytJ?=
 =?utf-8?B?aGRDSnlKTDRUc254ZmI2SjRWQlVhTzkvRW9VNEkzMVBDS01aeW5La05kT1ZB?=
 =?utf-8?B?WCtnL3U3RXRsdXZQNzF5MGFqTDhFRllEWmp3ckFCS3dLYjVpNk1TK1YvRUNk?=
 =?utf-8?B?bGRJUld3UVgwU01jSGR0NitFOG1IOGJzT3FscWJvYjZZbVBrZWdsSWc5SjRo?=
 =?utf-8?B?cFc3N0RqUU1ieEV2K0xLSzNza3F0VzlnT1R4d2NRMXBESjVMcnRkcFJyemNJ?=
 =?utf-8?B?Rk5zS2U2eVh1ck4rNkZUSXBFL0FId2JwZklPVTFoQm93SVpCQXd4aWZqOXFn?=
 =?utf-8?B?K3FGM3N0MXlJRlBKckJnODVtV0RZd2VsTDdUT28zRlZyQTR3TWlnQWVMUEVU?=
 =?utf-8?Q?Gig97X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVRvRkJIN21PTFFoNEc4elJsTzJ4Ry9YRHZUUEhqZytWOTdvSjU0STB6UGpP?=
 =?utf-8?B?RjkvMThHNWs0OU9BZURnSzlGYlE4VnhObDEvczNBcG5WUUdpTnAyK3FsVDEx?=
 =?utf-8?B?Wlc2MEgwNU9ma2FPYVZQWEJZdFV4dkVCNDl0cll4Y2JKb1NXUTF4dS9ZaHlU?=
 =?utf-8?B?cnRzVlJoRURRNVdjZ3Q3NGVidUcwQTdpWnUvODZRbmUwVnpMaUljK2MzbHFm?=
 =?utf-8?B?ZjRPZ0tsRFN5VzExU05odjYycGpveG10RzJBcVBCV3FzMkdIUUZOTlh5VGVs?=
 =?utf-8?B?OGtBZlpwRUNEYjgvK3ROQlBGUzVTWjJ6MW5Ub0twc1p6a0ZSVG02R25VRUI4?=
 =?utf-8?B?QktPdVRWNEl4R1VuUUY4c2cva01tWWVmcUc2OXoxR3Via3orVzF2Z2hrNWtz?=
 =?utf-8?B?MXN1RnNSajgrczg1cHBsYVRoUkEycVNueWJXc1Y3UXJGYmQzOVovYXFDSGps?=
 =?utf-8?B?c1ltay9yYloxeFQ1KzdrdmxsV0daTTRxNGFzWlFxSzJHNm9MT1JES2xqVThm?=
 =?utf-8?B?aTdxeDdackZiRy82N29sZEVicXhSYVIvNklreEJOMmtORTcwd1hJU2ZYSkw1?=
 =?utf-8?B?WC9GRWN6blowcEhaNTdNcnRadFJVRkgzSGhrZklGR29kVEw1TnJhejBZU1dx?=
 =?utf-8?B?Nlg3UVJrTUhWQ1JCNGo0cmp1Y3NzTmlkNjI2V1hHMWRxa0Y2ejNOTlhydHVX?=
 =?utf-8?B?VkJkNFovMUJEejZZYzNTWWVNRURoNGZsanNpTmpWVGpBdjdqMmZIdHdmZHov?=
 =?utf-8?B?Wml4ZUIzQlh3a01ROGNQc01IR08vT3hrYTM3em5VRnJjdGJOK0ZqR1dYaFAx?=
 =?utf-8?B?Y0pmbEk2b21kcmUxTlpzSDF0TG1Gb0JXRENZOEZGbzRpeE5ONXYxMjlmY0Q1?=
 =?utf-8?B?OVhQaDRMbjNkK1IvTWZQbThSZnlMLy9LSUxaOXZTc0U4NG5CdUxWUnJKbWow?=
 =?utf-8?B?eXJUZkV6N252cEk1cWh5Q3c1SzVFdks5NEovcjVGR1UzRWgxMnFVN0R0WDk1?=
 =?utf-8?B?YVFOckF0R3J3b2VhRk02L2NWWXFQQ042Skx4dTgxcWtwbHBqOG42Z1RncXBa?=
 =?utf-8?B?a0Y1eW5MUnM3TVVad2lncVEzejJZMGZYTlk3SHFDQW05dVdLOFdVUkJrL0ZX?=
 =?utf-8?B?bHhCQTdsak5wWjU1VTgydDd6aHR6eHFqaHltaTVEOUorY3ZtWU9pajNYU09r?=
 =?utf-8?B?SHJwQUNqWEt5VUZuL21sazFjeXBOb1RmdVZJUURYNmo0RGQyN3haM243N3lh?=
 =?utf-8?B?aFc0c21aYnBJWUFWclVodVh3L0p2bzhxRyt1cXRmZzZVMmRJeWxIZFJ2bXFk?=
 =?utf-8?B?REdOR3YwRFVRV2R3dFp3ekFtanA3N3FHSjFoVlM0WGNZTi84MWdlVWlZbHBD?=
 =?utf-8?B?YUZxSU5PYnBTZlVtT1FIM25xcjFqT2VwZmV0Y2J4YmFTLzZvcDluNWltUUxu?=
 =?utf-8?B?ekg4REhFQ2RVRm9vdUdKTXRTeEgzVUM0WW52ZmtoM1pzUEQ2N2VaSStrRkIv?=
 =?utf-8?B?K0llZFdXdTJ4UDVSK1VpZVlPS2FjQWtVY0kzMGZGaGdwVElJSktxOEd5d2ZV?=
 =?utf-8?B?bEJETCtIbStXKzZwZDZsVytudzZXVnVaejNJMDd1S3JvbFQyTXNoTUJiVzNj?=
 =?utf-8?B?QTBuUHdpYmhJUjM2RE1PY1ZiUG5lY2NYMkNVL21iaWtUa1hiZStGeUhYa0JJ?=
 =?utf-8?B?ZXJRRU03SVdnUDhuaVNBS3RaTFJRK3lRNU9OKzhacGpONHZOSGx2eHNOdTVV?=
 =?utf-8?B?TXJjdk10Z21QLzBUNUc4OU40UThrWnZEdU4vSEdaUDdPZHc2RUI1Uno4bEFw?=
 =?utf-8?B?RDBYVGs4bUtYSmpwNEY1Z1ZKakJPdXFvOERlZitDR1d2L2hnaTVWZUlkTkJH?=
 =?utf-8?B?bEpDNDh3QnpFRkRqTVdCSy83dExSdklPSHlKUk9ZblhlMWpDcnRCc0R4RnJr?=
 =?utf-8?B?MWgwUWkvWkRLVGlFNktlR0ZHT3FLRmRkTzAvOWJNVEJORmNvMFFiUjRFU1c3?=
 =?utf-8?B?Qm1pZHFUQnNiUmI4U0xwYm1zem94Z0o1KzZhM1FTeXVja1hqRGk3S3ZtQmhI?=
 =?utf-8?B?ZFpBZmR4cE13dWJMYTVDT0l3eDlDZnVnS3RacUVJSThtVDlpMTVJMm1ZOGZr?=
 =?utf-8?Q?wXqI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bad869-1d25-49fc-a9d3-08de33150700
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 09:10:53.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlIXcUrOn+auSDj5E8CPTbgIz1ljMC89tZThfzq4cLBDyFalDzncyKE+lRKXqONg6maXurSiXEks9EDWfMDZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11236

PiBPbiAxMS8yOC8yNSAzOjU5IEFNLCBXZWkgRmFuZyB3cm90ZToNCj4gPiBUaGUgRVJSMDA3ODg1
IHdpbGwgbGVhZCB0byBhIFREQVIgcmFjZSBjb25kaXRpb24gZm9yIG11dGxpUSB3aGVuIHRoZQ0K
PiA+IGRyaXZlciBzZXRzIFREQVIgYW5kIHRoZSBVRE1BIGNsZWFycyBUREFSIHNpbXVsdGFuZW91
c2x5IG9yIGluIGEgc21hbGwNCj4gPiB3aW5kb3cgKDItNCBjeWNsZXMpLiBBbmQgaXQgd2lsbCBj
YXVzZSB0aGUgdWRtYV90eCBhbmQgdWRtYV90eF9hcmJpdGVyDQo+ID4gc3RhdGUgbWFjaGluZXMg
dG8gaGFuZy4gVGhlcmVmb3JlLCB0aGUgY29tbWl0IDUzYmIyMGQxZmFiYSAoIm5ldDogZmVjOg0K
PiA+IGFkZCB2YXJpYWJsZSByZWdfZGVzY19hY3RpdmUgdG8gc3BlZWQgdGhpbmdzIHVwIikgYW5k
IHRoZSBjb21taXQNCj4gPiBhMTc5YWFkMTJiYWQgKCJuZXQ6IGZlYzogRVJSMDA3ODg1IFdvcmth
cm91bmQgZm9yIGNvbnZlbnRpb25hbCBUWCIpIGhhdmUNCj4gPiBhZGRlZCB0aGUgd29ya2Fyb3Vu
ZCB0byBmaXggdGhlIHBvdGVudGlhbCBpc3N1ZSBmb3IgdGhlIGNvbnZlbnRpb25hbCBUWA0KPiA+
IHBhdGguIFNpbWlsYXJseSwgdGhlIFhEUCBUWCBwYXRoIHNob3VsZCBhbHNvIGhhdmUgdGhlIHBv
dGVudGlhbCBoYW5nDQo+ID4gaXNzdWUsIHNvIGFkZCB0aGUgd29ya2Fyb3VuZCBmb3IgWERQIFRY
IHBhdGguDQo+ID4NCj4gPiBGaXhlczogNmQ2YjM5ZjE4MGI4ICgibmV0OiBmZWM6IGFkZCBpbml0
aWFsIFhEUCBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Zl
Y19tYWluLmMgfCA3ICsrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMNCj4gPiBpbmRleCAzMjIyMzU5YWMxNWIuLmUyYjc1ZDE5NzBhZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4g
QEAgLTM5NDgsNyArMzk0OCwxMiBAQCBzdGF0aWMgaW50IGZlY19lbmV0X3R4cV94bWl0X2ZyYW1l
KHN0cnVjdA0KPiBmZWNfZW5ldF9wcml2YXRlICpmZXAsDQo+ID4gIAl0eHEtPmJkLmN1ciA9IGJk
cDsNCj4gPg0KPiA+ICAJLyogVHJpZ2dlciB0cmFuc21pc3Npb24gc3RhcnQgKi8NCj4gPiAtCXdy
aXRlbCgwLCB0eHEtPmJkLnJlZ19kZXNjX2FjdGl2ZSk7DQo+ID4gKwlpZiAoIShmZXAtPnF1aXJr
cyAmIEZFQ19RVUlSS19FUlIwMDc4ODUpIHx8DQo+ID4gKwkgICAgIXJlYWRsKHR4cS0+YmQucmVn
X2Rlc2NfYWN0aXZlKSB8fA0KPiA+ICsJICAgICFyZWFkbCh0eHEtPmJkLnJlZ19kZXNjX2FjdGl2
ZSkgfHwNCj4gPiArCSAgICAhcmVhZGwodHhxLT5iZC5yZWdfZGVzY19hY3RpdmUpIHx8DQo+ID4g
KwkgICAgIXJlYWRsKHR4cS0+YmQucmVnX2Rlc2NfYWN0aXZlKSkNCj4gPiArCQl3cml0ZWwoMCwg
dHhxLT5iZC5yZWdfZGVzY19hY3RpdmUpOw0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0K
PiANCj4gTEdUTSENCj4gDQo+IFNpZGUgbm90ZSBmb3IgYSBuZXQtbmV4dCBmb2xsb3ctdXA6IHBs
ZWFzZSBjb25zaWRlciBtb3ZpbmcgdGhpcyBsb2dpYyBpbg0KPiBhIHJldXNhYmxlIGhlbHBlciwg
c2luY2UgeW91IGFscmVhZHkgaGF2ZSBhIGZldyBwb3RlbnRpYWxzIGNhbGwgc2l0ZXMuDQo+IA0K
DQpZZXMsIEkgaGF2ZSBhbHJlYWR5IHBsYW5uZWQgdG8gYWRkIGEgaGVscGVyIGFmdGVyIHRoaXMg
cGF0Y2ggaXMgbWVyZ2VkDQppbnRvIG5ldC1uZXh0IHRyZWUuIDopDQoNCj4gL1ANCg0K

