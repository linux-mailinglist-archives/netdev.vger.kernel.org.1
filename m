Return-Path: <netdev+bounces-94386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A08BF4F8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9BE281FA9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF213FF2;
	Wed,  8 May 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BB5k/NwP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D811C94;
	Wed,  8 May 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715138957; cv=fail; b=oP3+vhL5zV16oPYNVMyiSeO2P6eCLlyJIGYvtY/M/YDlfJsteMltU+pAaKNoAFPtC3F490zI0HjGHf2F6Vg20GdaZRF35DxtMoMuFOnuyKqMnG9PT5mgVTUvm7DRpWQ83jodTVD5EfxsqoMWF+6PakQQqmG3H54KLLINSJprtzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715138957; c=relaxed/simple;
	bh=Gb78T0GgPCedf7evXeP5hy8ERpNLlYhKPLQbbeNF+84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SVX6/T9zdJ2/UV9BBdYcZDZEVrk25Sp2m9zMjf0N3Vm4E5gS7cwU9s8anzO4k1IIn1+KaFqd6c1MkHBL6O2+TYksQcHlBIAwVp3D7l57GJFMCKB3fPYyZhVP8f5yTrmGdFJNg2mnuOA3ytzMEl0OMwcjV3kDiO9K8BhVOgvEaxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BB5k/NwP; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmOfbvNRJWcs+nAPqZt6jQXf7RPxhKpDMrm6ZbYqJvBR7a30+xYHWrT6aCKVuk7H+hy3hS7S8me6gnjcjsoJi5FGdHF//VRHGFpPiCrobIC0jjXqKKcBNUXOKwAtq0nzkyAHvFt+HcJcPrRfZq7ub+rQXoawntcyZ9wUDCViGfIZASUZc5urrzh6IqJy+Pd/bf7G6lBWCBzqXV44gj/GvCrQdMi5pyMHrGxk8e5W/pdac9KagXGrYA9IASvZjrbinenWHebbuu92+3nWzH5cj79wrBVd7TmQ8cSdDkaZ6C4jdMhMA7lxFyJO9jl05lNrZZx9IodrHAxLs2sImhUAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb78T0GgPCedf7evXeP5hy8ERpNLlYhKPLQbbeNF+84=;
 b=bj61C6Msonf/pvz5WieP7JyjTC5S8bvxI1x3sPnPCv6+60vVPdSpD+Q88NslnjRzTeaoTiG/eKZppoR7qifvkaQ0tu/qkw5+sq3w1nesq6qu3YdGeNjYddwcZ0+Tv9vEe2ELQhVhO1DMvnPbEuc0zHpARmK32rFbtfGkJ0vZ1WiljBKqV/hsrmtEqwZxKT2mNM0UydOvP+8gpxWxMayIZS6DsHIMVk0dNt3wpRR5WLvQgiDtofvid2p/EfFnjN9Vf649aSow11W4itdJWnhPewugXl8XoVUrEYaLjoocztV1fPCE3G+YlM2q6pC4BNQTbMj0n+UIWJjGhGJQSVAW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb78T0GgPCedf7evXeP5hy8ERpNLlYhKPLQbbeNF+84=;
 b=BB5k/NwPQ2xCrmM3Tn5EJzyixo8ntLLQXBhppHGJyn1yrjYNcZayL6Ijl5RfLsVbNkWzwNqxF9fOK6hRmYjthO1L4KeollNA1icWay1juHTQB77k1E9PFgHO5xZGCNTuYETWjvY8sIOgYeB5wQqQqrQS8z0KWyd8iwj0a9Rj1Yg=
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 03:29:10 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 03:29:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Thread-Topic: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Thread-Index: AQHaoF87FjdcCM/rFkC270r3dj6/NrGLzUgAgADWUFA=
Date: Wed, 8 May 2024 03:29:10 +0000
Message-ID:
 <AM0PR0402MB38910DB23A6DABF1C074EF1D88E52@AM0PR0402MB3891.eurprd04.prod.outlook.com>
References: <20240507090520.284821-1-wei.fang@nxp.com>
 <e1fa1aa5-4a40-43c5-a6ab-780667254fe9@lunn.ch>
In-Reply-To: <e1fa1aa5-4a40-43c5-a6ab-780667254fe9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3891:EE_|VI1PR04MB7119:EE_
x-ms-office365-filtering-correlation-id: 093512d1-5426-494e-40e7-08dc6f0f0686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?S3dVSkUzOUREeUc0MVVVUWhnQUNqd2tOQVFpU0loeWF2d1owNHVwa0pCaFZz?=
 =?gb2312?B?VEZMUXIyUWJBek5sVnhFUHFsMlo4SUdqZnI0ZldaaGlRSXY0VU4xN0ZaQ1RL?=
 =?gb2312?B?V1Z3ZUNxQmxaYktOa29SOUk2S2JyV3AybGVGWXlIVkZIQzg3QUdXWjRzSi9W?=
 =?gb2312?B?UXVZOU5tNng1cGI0eDdsTnBVS3VVOStvZnB0SjNtb3RjTm9xU2dKNCtQd1RO?=
 =?gb2312?B?aVF0WC90Y2ZrdmRySm96RjZrSlNOTHRnNjVxeW1SVWtSNUM0ajloVTU0eC9N?=
 =?gb2312?B?NXlZeUk2UmdrMG9UbFA2OUtaRm13MFRVL3F4RTQ0U1BPdnlQYmpCWmNUbTF3?=
 =?gb2312?B?c3BHODFjTzNVTWVwQmlGUlFJbVluZ1BMdlJZZTI5Mmg4YkQvK0Y4N1Z4ay9E?=
 =?gb2312?B?OWUvMzl4MXdsTkdPbjh5Q2lDYkFOdkxITGUzSi9NTEl5bFlXWFRsdWdTUlpF?=
 =?gb2312?B?VjFMb3lWdExLc1BrM0hoVURDUUtsdE93VnRzR2d4K1FodzN6cXF0Z1JIZUpk?=
 =?gb2312?B?L2NEeUJUSWgwclhySkhtZHJtTTVLOHNFNXlxV3JPRGhZUnlMdFZGcE93R0FH?=
 =?gb2312?B?d3J2cjlOM2ZQTVdUbzBDQXA5dWE0Z3I3akEycDAzQ3JjdnZRRFFNVWVBZndZ?=
 =?gb2312?B?TU5KN0RVaXdleFRKRzMrcXEzMVI4V0pTdnduZHVETVBOOHQxbjZ6eFMvdDhN?=
 =?gb2312?B?cG45TjRVTXAwRVl4TytSZWRzckV6dWkvM3N0UFRoN0JJZE1uOXNPZHVjdEpy?=
 =?gb2312?B?OXRjeW1RN2RiSkp3eGM1SktaNUphME1Xb0ptSnV2OXc3QW5lN01wOXMxWHIz?=
 =?gb2312?B?dlg2Smc0WWUwUnlSVWdxSDl0dGhlcGc4dUN2SzYyNGVEVStrRUxCZVA1czZN?=
 =?gb2312?B?dVhHMUcyTGY4RERpUXFGcDd4eDJpdWxveXV6UmtuVzgrVG5qOFR1cXErb3Jj?=
 =?gb2312?B?UHhBRGkzQXBrZmJTYlZmcnd6bCthWVNJc2g2RE1hYXk3SFUzYXNRNGVpdHk5?=
 =?gb2312?B?bzZodktKS0RLVG1WOWJobUNCUWNvNXRWVXJGeWlpZ2hBNWVsQmtpR0J0MEs0?=
 =?gb2312?B?Q0VyZ0pwR2twaFJFV3pDNERPekVnd1VPV24yMkVsQi9jbDBOL1lyNk8rU0cw?=
 =?gb2312?B?UjFiNTJKWFZaMDdUWnh6MkFnYk5jNEkxbUJLTGZLaUV6R05CKy9lYVREeGds?=
 =?gb2312?B?NGJrSDNva3loYjRCVUhGMUFhZjNCRkgrYmQrTS9zQzg4UUc5cXplVW90Nysx?=
 =?gb2312?B?c29Ha2QyTkVIc2RrYTljNEtFRjJ2UER2VCt6Y0RNejluUFBHTUJGNTZQNTZx?=
 =?gb2312?B?VFEzUElnVG1TS2w2ekk1S2hVQXRRcWk2TjRXcnZBeWVOcXRBVjFkU2RnaHhM?=
 =?gb2312?B?aGZub2JCS0d6dXg3blByL1pOa1VzMENQa0RxN0g3OVZTN0ZOMXVpaEp3UCtw?=
 =?gb2312?B?dFpta05VVVVvTnZhZjNRL214WlZ4V2kzelpWT1NDMnVzU3VYSzEzU3JVazJF?=
 =?gb2312?B?cVdtdnFpZ0FySFVoRFUwamFEUjg1NmhaR3FDNWJuTjNWR1A1Z3gyQTVJaWVr?=
 =?gb2312?B?OHFrYnBvay8zYWlCNG81QU1EWnNpMHplTmFSUUwvNi9RNHVXWEdtdTgrSlhn?=
 =?gb2312?B?eUx4dXNid3dEa3NlSlB0Qk5aRkludkJ1YWdGbHY0Tmx0ZVpha3BSamVYOXZ3?=
 =?gb2312?B?Y3VqM21MU0hXb0ZBbnp2ckZ5TWkrN3BZMXdrM0N2V3ZWRnVoWEVMZkJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RjQzbUx3MFgva1QrK2dhZlB1M1RhTE1pV0ZPL1ZsRlp1OTBaWUl1WnBSeDBX?=
 =?gb2312?B?TWRJT2dVSWtZY2VsY0RXU0dEZDBCOEtpTnROZjdPMVRpcjMwMk9vb2ZVaEZE?=
 =?gb2312?B?OEp3VCtvRlFLL1hHZHJqcWJpSUx6OUxXaG95SWxhU1VxNit3dlg5VnlEVzdU?=
 =?gb2312?B?dkxWOW0rMyt6M1VWRVhuRHhoeGI0cTFZSEVnNUwyQWJJbUVYMURVK0gzWUtq?=
 =?gb2312?B?MkJDWjdkR1FySzZaTDZjbEE3aEFvU2VBaHpjUTk2VzF1T1R5ckdaVGM4bDJj?=
 =?gb2312?B?Wm4rTDdwazRSdUhwRlV4eCsvbWwyOHNWbk9RMUFpRFZ5eDdmVFhOTEZYbFpI?=
 =?gb2312?B?ckhhKytCWk1YdmYzUzJQMitsdE5DdHZvSkZ6UnlaZHZoR1lMVXFEUUJEaERw?=
 =?gb2312?B?anZBVDcyMEJBRW5rMGlCRVR4cTVLV3pPUzh6eWZ6MjJMUEN4VzMzLzVvUXJh?=
 =?gb2312?B?eE9pejN2NURCY0xzSk0wc296WTRzUEdxVHYvWElNNGYrc2RCQU90cmFEQ2Zx?=
 =?gb2312?B?dmhDWFFnNUVNZURvL2luZjdmNFgwYytHc0hPU0xyQXp2aTFYV01iUHBHSWll?=
 =?gb2312?B?YTBtc0ZHSlhiTEFPVGh5ZFNQN08xbDlQbVZUdmR6NDlPTUk0cGtrZE1LeEhw?=
 =?gb2312?B?ZWRScEpiejRWMUhqKzVPaW1ZeTJmekN5b0paNnN4emVkM0Q0RHVNdysxMGhW?=
 =?gb2312?B?WjNrZUxiTUpEbmtscUszazhsdFJZZ01vUy9qNXBUQkhZVURLbkZxUDRhYTI3?=
 =?gb2312?B?YnVBcG1JVmVjdUttZkNqRVAwZXdwa1FYWS9MV1M1UzRLdHZqUmNsVmx4VG5H?=
 =?gb2312?B?MnNJYlVkUkMvaDhZUUR6WDc5RDFnUVJDcU5rcmRVMEZSaHpGTHFlMjk2bFVu?=
 =?gb2312?B?OGl0RXNZTlB3M3NHZnl6Rk5ibDNSdXcwd0NDditZS2VpaFJOOGlYVUhiTzFR?=
 =?gb2312?B?S1BRSFhwaHhkOUh3MVBDU2pyNzF2dTc0V1NRMUgwRFo2dExiZGJRRUJneHhm?=
 =?gb2312?B?T1FhWHBYbnVnS1dLM3ZXS21SMy95bkVPNzVFcWtLQjk1cEIwQ1l5WEs0QUh6?=
 =?gb2312?B?dGVIUTh2Uk4zZ2xZNkFrcEpUS0FHSFVvbmxSdWdLK2pRV2t4ZVhXY1RmRFJ6?=
 =?gb2312?B?TEdKaDUreFFGaTdyN0s2d0UvQnFLZi9TVngzZVN6RzAwQUFMdy9qQXM1MUhF?=
 =?gb2312?B?K1ErQUlnRWhiUXpuajRyRkhpNFdyQTVUWUozSSs2MHJkZDNDcWVEeFdSVGtz?=
 =?gb2312?B?U3Z5Um9xQmtJY0lvTkI3dnp4aTE4YmxZYlg4b1JNVzJHOVVJNVdFaEhkUXpw?=
 =?gb2312?B?RTNYYUxYeUQwb0h1TG11UmM5MU9SWXIyQWFxZEFFMEJ3eUtUZHF3WVp5aUQ5?=
 =?gb2312?B?OWY5Q2tDdmo2bHpYczBPaUh1YWkzMFFZYUdqYmJtcGVjYmFOS01vSVZXQldQ?=
 =?gb2312?B?TXptbTFwT2h4Z0FxZ2dhcmExb3JiVGxGZU9PTnlqZ3RQZ2EraWo2OXpYTmlq?=
 =?gb2312?B?TjNFalhrT2pGNWtISUROUEFzTDMxVnJNM1E5bm44Q3VhV3hUUGJNTzdNQ3Bi?=
 =?gb2312?B?eFl0Rk5iSFhEU1k4SThPNHRPYWJ6SklZd05YKzlQQi9iLzZhek1Mb0FxK1BC?=
 =?gb2312?B?T00yWEx0OVhxRFZJTUpabmE3dGx4UW9QNlpTV2V1OGxnUGpZWnorSG9Zekdq?=
 =?gb2312?B?d3lLZTNvbXBLMVR6a3pVanhSQkVMODUrZzVrYm9pbVpBVFJlWkFWT2loTFVO?=
 =?gb2312?B?bjc1bkdUeEl1L0hlejBNbkxGUFVyamFjWHQ2OC92RTV4cFpMeXpEQ3ZRZ0tp?=
 =?gb2312?B?cmNuN0hNQzAwY0MxRjNVYmxLdTYycmVxTm9nMEdEamNYUDBIOURyZWxQWURZ?=
 =?gb2312?B?bW9wKzg0VlpReEZTMHAvWEV2bHpGYXQ3eE9qN0tvZ0JwbiticEt5ZUVYY213?=
 =?gb2312?B?RzU3MlVnVUx1MEpsOEtFRkRzU3VrUWxCekFvSlNtbmJGbzhXc2wzWTBVTXA4?=
 =?gb2312?B?T3N1L2tiNjJKMThoaElxZkl3U0NsK3NubjlsMTllL1BQY1pjQ3dhcWlSYk9F?=
 =?gb2312?B?YzBuMWpYZUZUSkxOdDMyTTVwell0dm9tOW5aSm5uVFhjSURqWm1uejFwMVhC?=
 =?gb2312?Q?VQQI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093512d1-5426-494e-40e7-08dc6f0f0686
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 03:29:10.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUyTn+rJqkS8ScdHqq4f677ZmyrfHo1Rfl3oLLGg0Vz01Ajwpsj+o69HfazajFwlCOyxa6bITMUtt3krIDEcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jXUwjfI1SAyMjowMQ0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBTaGVud2VpIFdh
bmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0Bu
eHAuY29tPjsgcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZmVjOiBDb252ZXJ0IGZlYyBkcml2
ZXIgdG8gdXNlIGxvY2sgZ3VhcmRzDQo+IA0KPiBPbiBUdWUsIE1heSAwNywgMjAyNCBhdCAwNTow
NToyMFBNICswODAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiBVc2UgZ3VhcmQoKSBhbmQgc2NvcGVk
X2d1YXJkKCkgZGVmaW5lZCBpbiBsaW51eC9jbGVhbnVwLmggdG8gYXV0b21hdGUNCj4gPiBsb2Nr
IGxpZmV0aW1lIGNvbnRyb2wgaW4gZmVjIGRyaXZlci4NCj4gDQo+IFlvdSBhcmUgcHJvYmFibHkg
dGhlIGZpcnN0IHRvIHVzZSB0aGVzZSBpbiBuZXRkZXYuIE9yIG9uZSBvZiB0aGUgdmVyeQ0KPiBl
YXJseSBhZG9wdGVycy4gQXMgc3VjaCwgeW91IHNob3VsZCBleHBsYWluIGluIGEgYml0IG1vcmUg
ZGV0YWlsIHdoeQ0KPiB0aGVzZSBjaGFuZ2VzIGFyZSBzYWZlLg0KPg0KT2theSwgSSBjYW4gYWRk
IG1vcmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQo+ID4gLQlzcGluX2xvY2tfaXJxc2F2ZSgm
ZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+ID4gLQlucyA9IHRpbWVjb3VudGVyX2N5YzJ0aW1l
KCZmZXAtPnRjLCB0cyk7DQo+ID4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZmZXAtPnRtcmVn
X2xvY2ssIGZsYWdzKTsNCj4gPiArCXNjb3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmZmVw
LT50bXJlZ19sb2NrKSB7DQo+ID4gKwkJbnMgPSB0aW1lY291bnRlcl9jeWMydGltZSgmZmVwLT50
YywgdHMpOw0KPiA+ICsJfQ0KPiANCj4gVGhpcyBsb29rcyBmaW5lLg0KPiANCj4gPiAtCQkJbXV0
ZXhfbG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsNCj4gPiAtCQkJcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGZlcC0+Y2xrX3B0cCk7DQo+ID4gLQkJCWlmIChyZXQpIHsNCj4gPiAtCQkJCW11dGV4
X3VubG9jaygmZmVwLT5wdHBfY2xrX211dGV4KTsNCj4gPiAtCQkJCWdvdG8gZmFpbGVkX2Nsa19w
dHA7DQo+ID4gLQkJCX0gZWxzZSB7DQo+ID4gLQkJCQlmZXAtPnB0cF9jbGtfb24gPSB0cnVlOw0K
PiA+ICsJCQlzY29wZWRfZ3VhcmQobXV0ZXgsICZmZXAtPnB0cF9jbGtfbXV0ZXgpIHsNCj4gPiAr
CQkJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShmZXAtPmNsa19wdHApOw0KPiA+ICsJCQkJaWYg
KHJldCkNCj4gPiArCQkJCQlnb3RvIGZhaWxlZF9jbGtfcHRwOw0KPiA+ICsJCQkJZWxzZQ0KPiA+
ICsJCQkJCWZlcC0+cHRwX2Nsa19vbiA9IHRydWU7DQo+ID4gIAkJCX0NCj4gDQo+IEFzIEVyaWMg
cG9pbnRlZCBvdXQsIGl0IGlzIG5vdCBvYnZpb3VzIHdoYXQgdGhlIHNlbWFudGljcyBhcmUNCj4g
aGVyZS4gWW91IGFyZSBsZWF2aW5nIHRoZSBzY29wZSwgc28gaSBob3BlIGl0IGRvZXMgbm90IG1h
dHRlciBpdCBpcyBhDQo+IGdvdG8geW91IGFyZSB1c2luZyB0byBsZWF2ZSB0aGUgc2NvcGUuIEJ1
dCBhIHF1aWNrIHNlYXJjaCBkaWQgbm90IGZpbmQNCj4gYW55dGhpbmcgdG8gY29uZmlybSB0aGlz
LiBTbyBpIHdvdWxkIGxpa2UgdG8gc2VlIHNvbWUganVzdGlmaWNhdGlvbiBpbg0KPiB0aGUgY29t
bWl0IG1lc3NhZ2UgdGhpcyBpcyBzYWZlLg0KPg0KQWNjb3JkaW5nIHRvIHRoZSBleHBsYW5hdGlv
biBvZiB0aGUgY2xlYW51cCBhdHRyaWJ1dGUgb2YgZ2NjIFsxXSBhbmQgY2xhbmcgWzJdLA0KdGhl
IGNsZWFudXAgYXR0cmlidXRlIHJ1bnMgYSBmdW5jdGlvbiB3aGVuIHRoZSB2YXJpYWJsZSBnb2Vz
IG91dCBvZiBzY29wZS4gU28NCnRoZSBsb2NrIHdpbGwgYmUgZnJlZWQgd2hlbiBsZWF2aW5nIHRo
ZSBzY29wZS4NCkluIGFkZGl0aW9uLCBJIGhhdmUgc2VlbiBjYXNlcyBvZiB1c2luZyBnb3RvIHN0
YXRlbWVudHMgaW4gc2NvcGVfZ3VhcmQoKSBpbg0KdGhlIGdwaW9saWIgZHJpdmVyIFszXS4NCg0K
WzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvQ29tbW9uLVZhcmlhYmxlLUF0
dHJpYnV0ZXMuaHRtbCNpbmRleC1jbGVhbnVwLXZhcmlhYmxlLWF0dHJpYnV0ZQ0KWzJdIGh0dHBz
Oi8vY2xhbmcubGx2bS5vcmcvZG9jcy9BdHRyaWJ1dGVSZWZlcmVuY2UuaHRtbCNjbGVhbnVwDQpb
M10gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuOS1yYzcvc291cmNlL2RyaXZl
cnMvZ3Bpby9ncGlvbGliLmMjTDkzMA0KDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+IEBAIC05OSwxOCArOTksMTcgQEANCj4gPiAgICovDQo+
ID4gIHN0YXRpYyBpbnQgZmVjX3B0cF9lbmFibGVfcHBzKHN0cnVjdCBmZWNfZW5ldF9wcml2YXRl
ICpmZXAsIHVpbnQgZW5hYmxlKQ0KPiA+ICB7DQo+ID4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+ICAJdTMyIHZhbCwgdGVtcHZhbDsNCj4gPiAgCXN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPiA+
ICAJdTY0IG5zOw0KPiA+DQo+ID4gLQlpZiAoZmVwLT5wcHNfZW5hYmxlID09IGVuYWJsZSkNCj4g
PiAtCQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gIAlmZXAtPnBwc19jaGFubmVsID0gREVGQVVMVF9Q
UFNfQ0hBTk5FTDsNCj4gPiAgCWZlcC0+cmVsb2FkX3BlcmlvZCA9IFBQU19PVVBVVF9SRUxPQURf
UEVSSU9EOw0KPiA+DQo+ID4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmZmVwLT50bXJlZ19sb2NrLCBm
bGFncyk7DQo+ID4gKwlndWFyZChzcGlubG9ja19pcnFzYXZlKSgmZmVwLT50bXJlZ19sb2NrKTsN
Cj4gPiArDQo+ID4gKwlpZiAoZmVwLT5wcHNfZW5hYmxlID09IGVuYWJsZSkNCj4gPiArCQlyZXR1
cm4gMDsNCj4gDQo+IFRoaXMgaXMgbm90IG9idmlvdXNseSBjb3JyZWN0LiBXaHkgaGFzIHRoaXMg
Y29uZGl0aW9uIG1vdmVkPw0KPiANCkFzIHlvdSBzZWUsIHRoZSBhc3NpZ25tZW50IG9mICcgcHBz
X2VuYWJsZSAnIGlzIHByb3RlY3RlZCBieSB0aGUgJ3RtcmVnX2xvY2snLA0KQnV0IHRoZSByZWFk
IG9wZXJhdGlvbiBvZiAncHBzX2VuYWJsZScgd2FzIG5vdCBwcm90ZWN0ZWQgYnkgdGhlIGxvY2ss
IHNvIHRoZQ0KQ292ZXJpdHkgdG9vbCB3aWxsIGNvbXBsYWluIGEgTE9DSyBFVkFTSU9OIHdhcm5p
bmcgd2hpY2ggbWF5IGNhdXNlIGRhdGENCnJhY2UgdG8gb2NjdXIgd2hlbiBydW5uaW5nIGluIGEg
bXVsdGl0aHJlYWRlZCBlbnZpcm9ubWVudC4gT2YgY291cnNlLCB0aGlzDQpkYXRhIHJhY2UgaXNz
dWUgaXMgYWxtb3N0IGltcG9zc2libGUsIHNvIEkgbW9kaWZpZWQgaXQgYnkgdGhlIHdheS4gQmVj
YXVzZSBJIGRvbid0DQpyZWFsbHkgd2FudCB0byBmaXggaXQgdGhyb3VnaCBhbm90aGVyIHBhdGNo
LCB1bmxlc3MgeW91IGluc2lzdCBvbiBkb2luZyBzby4NCg0KPiBJIGFsc28gcGVyc29uYWxseSBk
b24ndCBsaWtlIGd1YXJkKCkuIHNjb3BlZF9ndWFyZCgpIHt9IGlzIG11Y2ggZWFzaWVyDQo+IHRv
IHVuZGVyc3RhbmQuDQo+IA0KSWYgdGhlIHNjb3BlIG9mIHRoZSBsb2NrIGlzIGZyb20gdGhlIHRp
bWUgaXQgaXMgYWNxdWlyZWQgdW50aWwgdGhlIGZ1bmN0aW9uIHJldHVybnMsDQpJIHRoaW5rIGd1
YXJkKCkgaXMgc2ltcGxlci4gT2YgY291cnNlLCB5b3UgbWF5IHRoaW5rIHNjb3BlX2d1YXJkKCkg
aXMgbW9yZSByZWFzb25hYmxlDQpiYXNlZCBvbiBvdGhlciBjb25zaWRlcmF0aW9ucy4NCg0KPiBJ
biBvcmRlciB0byBnZXQgbXkgUmV2aWV3ZWQtYnk6IHlvdSBuZWVkIHRvIGRyb3AgYWxsIHRoZSBw
bGFpbiBndWFyZCgpDQo+IGNhbGxzLiBJJ20gYWxzbyBub3Qgc3VyZSBhcyBhIGNvbW11bml0eSB3
ZSB3YW50IHRvIHNlZSBjaGFuZ2VzIGxpa2UNCj4gdGhpcy4NCj4gDQpXaHkgSSBkbyB0aGlzIGlz
IGJlY2F1c2UgSSBzZWUgbW9yZSBhbmQgbW9yZSBkcml2ZXJzIGNvbnZlcnRpbmcgdG8gdXNpbmcN
ClNjb3BlLWJhc2VkIHJlc291cmNlIG1hbmFnZW1lbnQgbWVjaGFuaXNtcyB0byBtYW5hZ2UgcmVz
b3VyY2VzLA0Kbm90IGp1c3QgbG9ja3MsIGJ1dCBtZW1vcnkgYW5kIHNvbWUgb3RoZXIgcmVzb3Vy
Y2VzLiBJIHRoaW5rIHRoZSBjb21tdW5pdHkNCnNob3VsZCBhY3RpdmVseSBlbWJyYWNlIHRoaXMg
bmV3IG1lY2hhbmlzbS4NCg==

