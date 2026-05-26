Return-Path: <netdev+bounces-291666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJrfLmuAFWqtWAcAu9opvQ
	(envelope-from <netdev+bounces-291666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:13:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C647E5D4BBB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CD7B3008CB6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE63DEAC0;
	Tue, 26 May 2026 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ep73X48C"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DF1AB6F1;
	Tue, 26 May 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794021; cv=fail; b=Gi54Wae76vg7S5mtkCJAKavvcxuUl60olVaXjFegOLJ9MD08ye5709w3TCYGS5gszSAFrbiZO7Cg22RmBrhwk8Aj9gxOV/46sjdAsUy7aTFr4SyL2wbiWsX5/HSuh4OvcCEL49Tl4i8FctzlXgd1pJyYAJ9c3R2LT5eWv7BHs28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794021; c=relaxed/simple;
	bh=RPD2/ylGlrNw0A9kJ9QeB/g4kBBNj0qHywrhq0WbdG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X38bfj2tSEqkLwboCrGIsY0BlyDFZl7RCkQIfEQXZwVAmy1PgvjF6qujt/Flcx23l97KD5Y0j1NZ8l59ZbjuSXoCZeY+EFWv+Uulir4PKlEy15pVt2SHdROaZRjUx6j4L174FfaAXzwGtnL2CcC5bU0sMC3SAFKGWLkQyEg+eQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ep73X48C; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUTC7eJDZxFDqeD0nNumqZVoXm59yrcll5AtqB8RIuUYdNaSuU6/cmnHrS0YWjxHQITKE+k/yfKizxEV5WIsLUwpsqAgsbtuaf96+EtpUGWFSAiSkOWEEFSYS+Gu+56RqZNWWoeK7/9HJmLfDP1r56VzABV3/gQwf592jRuv2nYf7a94aLctWv44IrL4bFrGWx8DN2GqaImK33zLR8csG7mFtq0MVC0gPFLGbUG+k6CadzrB+L8FzXTEJ5rbe3vewhoNc4EC0Y7eg02x4GG9j3wBLC2VK36hJpDJRe/toPmFFkqpmUUaogAUtkT9Jq0eLa4nbhiT6OrYRYwvnAi9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPD2/ylGlrNw0A9kJ9QeB/g4kBBNj0qHywrhq0WbdG8=;
 b=DeBzrA0AsJvaE3dnwqs/6ihwCl0u2NeduwNgwcX31AmzBm4pmf+h/JCPSmAZxtDkLqLk/l10La0Br8IFiLfaFHPZvP8QEFSMXPKkKmcwB/389uuMXofmEOR4amHuR3U9cXMn7slwt9tks4EdViuDmqzmDwy4Ay85GdRUgNr7CEJ+UrRVc2Qgh8+w2pWYutQZwl6ch1U8O4K2W60aaZ37HgLKz01JGg2V0QYUqtgBuMEB6XdQLEdHWSMY9xKgff3GU6i+qfJohgQhDNYT3oBb9Jl/dIuQFilxrIovv6l1b6e/UUKJSKuG3sBZmrZAusjRnZNfhsw34/eetCSJ99dMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPD2/ylGlrNw0A9kJ9QeB/g4kBBNj0qHywrhq0WbdG8=;
 b=ep73X48C5cJ90/IGRYj1WDXVkTS8gmQPAlwz/+fWpP/OA0kG6nhGfGNlKDhI3NR8tlZvM2q7U479gIqAQeIZtkNvfXHxEleEMTjxRu2Tpba9ZFAMaV/r39mhW1EddO8pXNCf8nWy4EBQ+I90jivLIhx4Jk4RDXsEJ8fNmzPQJlfDpRLvpCxQ/0zvTk/9Tm4aO9G5VEegL4WjHG29PMYxNXIHRi9CHyvZwz4KQ/ql2IipyKIFepW5GKX/f7Y6g0qdkHisWbb4y/I2yD64xTu6KQZcC44It+5ScgMmfHLkqiIaLvsKerKqcfS+BpdqQHX4rlU7E/pqLZsWVC60zAZc2w==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB10078.eurprd04.prod.outlook.com (2603:10a6:150:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:13:36 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 11:13:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: fix pinctrl default state restore order on
 resume
Thread-Topic: [PATCH] net: fec: fix pinctrl default state restore order on
 resume
Thread-Index: AQHc7OXNiXnM/jHRsUaYRjVIq5KJIrYgJx8Q
Date: Tue, 26 May 2026 11:13:36 +0000
Message-ID:
 <DBBPR04MB75005E39026EE1475CCC526C880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References:
 <20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com>
In-Reply-To:
 <20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|GV1PR04MB10078:EE_
x-ms-office365-filtering-correlation-id: a07f5575-39c8-4fbb-3de1-08debb17d4e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021|6133799003|11063799006;
x-microsoft-antispam-message-info:
 neZxlk8VhiiqaBwmBrzs6tFhXNYxQOJgTlS4bu8JXY0w0ZvYHi6EAXsWF2tetpPtt5lc7vIzDbrbV/p14zdkl26Iai0AMEfIFwFjtNQECMPM6B8qwyDvuPg37G8XRAR/OGY7zLrIKHMgADeb52vGQyCllqkqAKjG8Qoshykp4S/Ex7DLdgnCGtYkflmpOurE5idp6UUNn54syt2cqEnQaKFeZSBDB++tsQfU/+eIVJdng21JMiJirwhwi/80mQbCpCjTb+FPzeXQieTHoGsbzKAq7uoIMWbMZT/BTfVCHbKBU9zX+k09j2xkDuCfusG7mU2qHClkKc+n2i5dFStOw+ROBQWpvS9YMeJNndrsGfpIIyPyNFFElAKfxBMlz7NHbYTq3A3YRmo73RLCyxDqYvCzpA0MJpTmvBDu/1bwe+1x7PseVG2tb5+h5QDlgNJh7sN1xwaFrGCXFU3JKhAjchnTADSyMcmFZlRk3Jk8N4v9eTIhbS7yiRt/YuRMSQGX+HZpG1FugnXYFmsFHH+N+KWfL3I/YbBrjHe/Jadb3K+STV/HgPvOiQ7xax43mLlrJL91/kar3V2xBx9IEOVDX/Xvfh2dhfw1tmfIStrJ8bURzhlSluUYFsGc5tNKo8iASDNLaBQvG8QT3VRXZKzWdmcMKUdLM6KqzSclnOWil/l8LbdkHViBrVxXUKjVTdfxj1Q9PtxAuSehgN8e7xsjzTd1hWzsQzoJGRgENm7mwRfVe1A7+7vPB/3A6+dGXJJM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2QyOHBwMXlSbFF6WWhNZm1TTXZ3ZVAvVFcvUzEvYzE2Y1cycW5qaWVLUnpR?=
 =?utf-8?B?UWtJTExKSDdOWVl1RWdtSDNSbzdzWS82L2JhWVZmQWdtUzJkMlJ2V0tXb3pH?=
 =?utf-8?B?NjllRnlTU0ZkT1R3RkRwUmdaazNVMnhjZHRYR2dRSWJwL1dVSVMzcTdEVFNF?=
 =?utf-8?B?UXRaRE9MNWV2aEp5aVl6c0tDWHAzZ0VidHU3c1NyM1ZPeW5vaGRBMjQxRm9n?=
 =?utf-8?B?bVI0S0F2R2pOTm1Xb05DTW9iR3Nldlg4UzdLcUM1MmNpMzdTRWt5Tnk3Mk94?=
 =?utf-8?B?WVBrV0NiVE10ZnE1NjVtRFp0YWxiVEdTdGowZmFjWVhFQnJaWUxWUTcyLzNs?=
 =?utf-8?B?YXBYODhzVktjSmZ1QkVQNGhONmc2QmFmOFVDVEdwbjQ3bUtjZE45WTJsVlJ4?=
 =?utf-8?B?cU44SHlNbHVMUzJCT25aelNUclFGbjBXc21ZbUR5c25paXRtNW96Z1ExZTYz?=
 =?utf-8?B?ZmVXTDR1aGQ4UHREbFdpUWRRMDVJN2lYZTN3bE1DeWdBNVdGeFplZkkwc2Vv?=
 =?utf-8?B?eEcvMWNwMDR4ODB0eWUzeVI4T29tWll6UFEySWp2dEE4dVhhK2NEM0xINTgw?=
 =?utf-8?B?WEMrekNjUktpV0tua2JHSk9BNGJ0anRMUENHblRVSURSUmI3bFVxMUFSZzlV?=
 =?utf-8?B?Uk96UVR5VTNiYkcyMUdZS0NIZDJlbFZ5U2dWZzdLUnNoV0krV05DbldsTm9J?=
 =?utf-8?B?NFdRaCtzek1EZE82T1FWSWc1aFQ0dy9LeWNoSnR3TUo0N0VoeUF1V1JIMXph?=
 =?utf-8?B?SmJoME1iNUtvTEgxZml0NTBPNGlpeEN1VXZVellDVTFHdHR3TG1GSEFGQnBq?=
 =?utf-8?B?SGlNdXNKV1JOL3ZTN3ZMOE5ZSWRDb2xSekVyQkdDN0xXR2J0VjFnWFJEcndo?=
 =?utf-8?B?dHVoUDB4Zkh0Nng2dUtXTlpaTW9pTFlHMmwwTmhwVWdjQ1BhbjlxUFY2K1hs?=
 =?utf-8?B?MDR3OXdEWEFDeFpHMHVHTDl2TDdGSDYvQVdZR1BuSWtybWNzeXJqTldXUThE?=
 =?utf-8?B?R1FvRE4wcm9DOGo0ejN5YWI3UXM1YXBleUxYSStST2x4ZElEbUkrWUhhcGxW?=
 =?utf-8?B?ekRlZElXV0FoLy80UzhWTk9OeC9vZ2g2dzVZOUt2WVE2cXY4ajU1cGhxZlBL?=
 =?utf-8?B?MGE1S3pNemRPSWhqN2VOeW9yeUd2MDlEbnlXR2N5VHdVTW9ES2JrQmhYR2E3?=
 =?utf-8?B?M1Rxbzc1UTQwUXIyaTh1ZHNFcVYvK1ZkR0tNK0NmazZjNFJlNGVRT1F2MThV?=
 =?utf-8?B?M3FwWGJiRDNUa1phZVJUakR6MVM4TkZGQSt0cFdTK280cE5VZXVOMFV5NWds?=
 =?utf-8?B?VGZWV1NKYnY1VFV4b2tTQ2E1VlU5blphN1dpZlNhOGtzSHhZcUhBUXpNNld2?=
 =?utf-8?B?S1ZlUzN0bUUyMjUvZnA3VWRMeWJmNUE5a0d1blhXVnBVa3kxWllrd2Rnb08z?=
 =?utf-8?B?ZldCaWFnZ1pYc1FaR3lXaW4yNERlclpxWVF6cUs5YmxuU3o5bDIwbVp1bE9n?=
 =?utf-8?B?YThXaWNFQjlJQVdZVUppMW41Vi9oM2F3c25OdGZ4enBtYWRhUXpJMEhXbXVD?=
 =?utf-8?B?Z2ZieWN6cTB6TExVMkY0cVhSOUI2QzRxWjVxVnJEK1dyVWk1TklCd2xoV2Qw?=
 =?utf-8?B?UXlib0cwL2lFcGtCZERzYUJQeGV4NEN1QTFiT0JZQXhHSGFmY004dlhGd1FR?=
 =?utf-8?B?eWZ4ZndtOWd0VU55WmhOTk1IZWhlYkk4ZWEzc1Z3UHFoZkowYWFQZ2hSZGFG?=
 =?utf-8?B?Z1ZqSFN3eGVSc0tIU2o3azlBcTB3RkVHVm1FWEIrSDhoM3JnMGxPWjE2T3gx?=
 =?utf-8?B?R2xIUXZTT3RZbW5tc1lUWUxGRWFKRkxvOUNaa3BTaWU5dHA0Q1ZaYWFmTlZ4?=
 =?utf-8?B?N2V3RTFaKzhpQ3ZzS2dOUitycnNubVVwNkswUXViMFlBcG9INzIxTkgrend6?=
 =?utf-8?B?Z1ZvY1FkdG1qYk1TSUFKbVk5cE5MVFFOUjNFdy9RZFlZQWZrVlZYcWVjNG5m?=
 =?utf-8?B?VUoxblFwbC9zdmhmT3F5ME1FK1FlelhiTkcrTWxsZTMvY2VPNkVkdlM5Ymdj?=
 =?utf-8?B?djFUVTV2bmhTNk9ZTHBJR3Y0Q0taV2FJZHBFK3pnSjIxQUp3NEFGcmZQS1do?=
 =?utf-8?B?MkZzWUJ0bzA4ZUxPMjdEcmY4bGxXdkc0aWwvTG9kWEt2U1lOQmplTFM0VXpq?=
 =?utf-8?B?UTFRUDFldm0wREYrMWlWUk9wMTF0YitRdzV4dUY3SlZTaTRGbVp3RUszY0Rw?=
 =?utf-8?B?TWhyUUdFaDRCTnpzTTR6bm94cHUzVElVYUtVMWRIQnVSNkFNWWt1aTV2NWxP?=
 =?utf-8?Q?UHJe8J6kKQ7Mr5nOiA?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07f5575-39c8-4fbb-3de1-08debb17d4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 11:13:36.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqF1UTjqlnaAC42Sp/qR8JfbCkcCIr7TaIe0fEK7ND+e4VihWYKWTBUsjnoRP6Yr73jBz/pgnbN13tJInRG2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10078
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.036];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C647E5D4BBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBJbiBmZWNfcmVzdW1lKCksIGZlY19lbmV0X2Nsa19lbmFibGUoKSBpcyBjYWxsZWQgYmVmb3Jl
DQo+IHBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoKSBpbiB0aGUgbm9uLVdvTCBwYXRo
LCBpbnZlcnRpbmcgdGhlDQo+IG9yZGVyaW5nIHVzZWQgaW4gZmVjX3N1c3BlbmQoKSB3aGljaCBj
b3JyZWN0bHkgc3dpdGNoZXMgdG8gdGhlIHNsZWVwDQo+IHBpbmN0cmwgc3RhdGUgYmVmb3JlIGRp
c2FibGluZyBjbG9ja3MuDQo+IA0KPiBGb3IgUEhZcyB3aXRoIHRoZSBQSFlfUlNUX0FGVEVSX0NM
S19FTiBmbGFnIChlLmcuIFRJIERQODM4NDggb3INCj4gU01TQyBMQU44N3h4KSwgZmVjX2VuZXRf
Y2xrX2VuYWJsZSgpIHRyaWdnZXJzIGEgaGFyZHdhcmUgcmVzZXQgcHVsc2UNCj4gdmlhIHRoZSBw
aHktcmVzZXQgR1BJTy4gV2l0aCB0aGUgR1BJTyBwaW4gc3RpbGwgaW4gc2xlZXAgcGluY3RybCBz
dGF0ZQ0KPiBhdCB0aGF0IHBvaW50LCB0aGUgR1BJTyB3cml0ZSBoYXMgbm8gcGh5c2ljYWwgZWZm
ZWN0IGFuZCB0aGUgUEhZIG5ldmVyDQo+IHJlY2VpdmVzIHRoZSByZXF1aXJlZCByZXNldCBhZnRl
ciBjbG9jayBlbmFibGUsIGxlYWRpbmcgdG8gdW5yZWxpYWJsZQ0KPiBsaW5rIGVzdGFibGlzaG1l
bnQgYWZ0ZXIgc3lzdGVtIHJlc3VtZS4NCj4gDQo+IEZpeCBieSByZXN0b3JpbmcgdGhlIGRlZmF1
bHQgcGluY3RybCBzdGF0ZSBiZWZvcmUgZW5hYmxpbmcgY2xvY2tzIGluIHRoZQ0KPiBub24tV29M
IHJlc3VtZSBwYXRoLCBtYWtpbmcgcmVzdW1lIHRoZSBwcm9wZXIgbWlycm9yIG9mIHN1c3BlbmQu
DQo+IA0KPiBGaXhlczogZGU0MGVkMzFiM2M1ICgibmV0OiBmZWM6IGFkZCBXYWtlLW9uLUxBTiBz
dXBwb3J0IikNCj4gDQpOaXQ6IGEgYmxhbmsgbGluZSBoZXJlLCBwbGVhc2UgcmVtb3ZlIGl0DQoN
Cj4gU2lnbmVkLW9mZi1ieTogVGFwaW8gUmVpam9uZW4gPHRhcGlvLnJlaWpvbmVuQHZhaXNhbGEu
Y29tPg0KDQo=

