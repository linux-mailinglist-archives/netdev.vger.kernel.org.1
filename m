Return-Path: <netdev+bounces-144335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E09C6A1A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 08:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C65D284E56
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283B187FFE;
	Wed, 13 Nov 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvKQKmO1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B517D341;
	Wed, 13 Nov 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483733; cv=fail; b=qxx+HZ828WaQPla+RVw5Jq0mKCR9ruDMZ8biS/ssl+yDTL9ioWJFaUxznDsYBEM2CNBGhTp9C0ducShSg+9IwVUag8zpejLt5imwliJdez08A+xu7o2CwrG25EhpkPfI505UVSViqnTOCsDK1eeK7maemWaLwIATkgd9RbLTHoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483733; c=relaxed/simple;
	bh=ZTkTq5S7n2D2zfEn6xUYko3Q18vAeDVoucUlDxjD5O8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIEDFl6mSwRlqh5lszEyvsZm21yD9lBylOzQY5epVbEUC6tNMqWAoXyELd4jZ079cyRqu/MvVfAY2rC3IbF8BQJ1Bodn/ibu8d+PrEtvmyoSwYQQUTvMTGtot3uQN8zWIxQoAPqFMK2M85OmOxjpDQ+tl7qeHhxpM5mmY7UP/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvKQKmO1; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnOpapIVWQAwjX2ooyXhYmJUaU90Qig5y5PjHeZNqsyWlMxlINi3ZfsGd2xIsmG+SZ3ffrxZ3NVc/dMMm6FSHuGnKVqabB0ALN3vN6JHyBqW9aMi4HxIQDYoWjKInKJo6SD2y1U3+532JYYd2dLcaCrCfnOLYTapCy5V/S/J5TO65bWifKH9msHlNGzH9TSVem+a2z4DozTtOKTgQSjy4UQHYso0VMh/yL60C1E6gL61p63rR9Im+A78dLUB8xUL9f0Z9+uXn1DcQOKJouF2uvAA0ydab3MOhDhxGmK3AGXL5QS+wvvOg90ergY3P3u/PWEzwmNZ1K58C/8ZF7q+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTkTq5S7n2D2zfEn6xUYko3Q18vAeDVoucUlDxjD5O8=;
 b=gAOwzzdlZn/selx4id71pQT7nhMjZuI2QKXRaifA8OF1Qg4uiVkgXfT+u0atXvhMrmG0sFeR46XLzAPusZ8z6I+zsLp0QGbDrn4SbFnu17w1+ASHKDu6NrvMglpSXcMXs0L6gMfpdIqthbAKbEe0ewyUSWEvGn0cVQAyMzCoVpmTXO4MDqoBckCL1U5PrmJJySIJmJ+37JT4FQirHu3HUQGf3uCBm7N3dvFPlRtR9tzkTsUOErAKhIvekaRFbxJEVE130/EvuQx1AZ7LP4mIIYmb49EzVlWplTWmweNGKkgd6K/oL0SHzCgbFwK6cMIe40YFLmF7I8xykrppffCjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTkTq5S7n2D2zfEn6xUYko3Q18vAeDVoucUlDxjD5O8=;
 b=hvKQKmO174QmhCWXVGkOXmo/CLJPZcNGe+5olNK2OvWQaj3JTAAjETp1a6Ql1Cxrgd5es7JyCDv+/YMnmKtH8BRjz45xOY/oJ7wCkMiMYpd87UxGj64w0OkONSz/sHS00xStkBckXrR5owH8qYUCx+6y4YdLwxDMvfZ08P2x+h8/w8HOj8zXa3XbH4QM+bcTjo1fqR5L/qe3cEsnh/R00gMgGXF8tfDmjXEthGGxPBAryeg9K4Wsl5A8xGae0PgycbCHkF9GLBGr5/ghydRoxAxKhun2lSdedXYaikOTHVKyLotsNXKssLoNiiCmb7OTZq/9J5ce275e3ysXRO59MA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB11061.eurprd04.prod.outlook.com (2603:10a6:150:20d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 07:42:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 07:42:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net-next] net: enetc: clean up before returning in probe()
Thread-Topic: [PATCH net-next] net: enetc: clean up before returning in
 probe()
Thread-Index: AQHbNZ4Rnq3JheIw2kmp/UiJgGz70bK001Ng
Date: Wed, 13 Nov 2024 07:42:06 +0000
Message-ID:
 <PAXPR04MB851005FFBC916885F13F1A89885A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
In-Reply-To: <93888efa-c838-4682-a7e5-e6bf318e844e@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB11061:EE_
x-ms-office365-filtering-correlation-id: 26c6fafb-eda2-40d9-ece2-08dd03b6ac86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Nk5hdE1SY2U2S0kvdVdER1Q0L3VDckhTaFJBbFVmVWV0bUhwT2xrTytkeDlN?=
 =?gb2312?B?R2ovajZBWWdQSkREMGhnUGZGK3lOOGJaNkdkRmUrZWRPYWQvbDlHcHR0SUJu?=
 =?gb2312?B?OGZsaDZ1YkFhWnNlWExtT1Z4RGQ3c09uL3YxU3E3ZkoxUEg1UC9RNUpsK3VQ?=
 =?gb2312?B?R25NYVBxOTZaeGlmRGVoQVZtYnJaRm9tWXVxVlV3dnM3UmtXc2ZvclBmZWtX?=
 =?gb2312?B?cEh6YTJrTVdoRXRBdnNkNmhoZWFRYnh5SjJXdXF5c3JBRWRqQllqQ2gxQnJG?=
 =?gb2312?B?ZFM4VGpZbE4rNVBRL3ZqR09CR0MwSmFPUXM5eXRIUjJQWU5nM082dHd6YWdL?=
 =?gb2312?B?b3JqYUJpYWxJaUwyMytURk9lVDhiZDdhN1FFd1N4NVNUR2tZamgwSEZlY3p5?=
 =?gb2312?B?WWVFMzhua0RaWkozamlQaUZjWUowcDNmRlYrdnY5NDZtazZQMVkzSGRGazJl?=
 =?gb2312?B?dGl6TGluaUczejFWUHNRR2UzdW1OZStOT1VzdnVuSkY1bDNsdGs1Rko3YzJy?=
 =?gb2312?B?aXg4SGJmbG1wSUU3YXR5bUd1cyswdUZMS2NpSnZ0M25KUmRGSmhLSTF3VVMw?=
 =?gb2312?B?ZmpsVzNSWGcxWVc3R0gyc3ZKNXFtbmx5dFZLRnIyUDFQa3dBbmIzWnUyRHFx?=
 =?gb2312?B?RXFCN0pISnRoWVlscjQzVG5CSmEzRmM4WCtmL0NpU2phTTMyc0lMeVNhUEt4?=
 =?gb2312?B?QXJHcnAwT3RMODd4Z3dSd2Q0WDlZc004Z2RkY0FXNjNxeUl3VENaRkFYcEVU?=
 =?gb2312?B?cWhUaEd5U2pRN0xnRmZsa2xkUjhaN3VmcUVPaGJ5WjlNd1pWRHByOXk1OUpK?=
 =?gb2312?B?ZlV3MkxPVkkyRC9VWjdYRzFOWEJEVXExRFMxclllNzdOc3lMTCt3OU9aTzJo?=
 =?gb2312?B?bElsUDhjMW1NMTcrWEJ4WGZiL2padXVVNnozcmRoWUNrOWo0Q3BFNkYzM1JD?=
 =?gb2312?B?TkR1MjJveEQ3Y0pRQlRCRm9SN1h6NGE3ZE10aVpYYmRGV3F2K2JNZ2NLbVBV?=
 =?gb2312?B?Ui9Gd3BDVHE0TE00QmdlaFdiUWc0UlJ3TC95YTJIRmdVRURrZ1EwR2pDQURw?=
 =?gb2312?B?UUFwZlNCbnZLOVlDUG9lYi82RXNZUE4xOEhUai92M1Q0UDRpV2FQMzRwZ0t1?=
 =?gb2312?B?K2QvN0J6ckNHQ1hIdkpKVm5uOEN6aDh6ODZyMHZNUjJTRHB5WjB4S2xnWGlv?=
 =?gb2312?B?SEZRWDN6SG0yVFU3WnlQOXo5TGMyNzlVSXhGdG5LRDd4V2JwdEhYQ2dLUm1l?=
 =?gb2312?B?Z2hhM3N5UGhoRzJPWmxuUit4YVVEaEMyT1dwSmI1cDJ6WnNNb2tyellFQW5w?=
 =?gb2312?B?bUorQ1pMNXN2VEhENUFRSXIyMFpJTHQ0R3UrdXBTYklkSHFSS3ppOEFnTE5P?=
 =?gb2312?B?b01tNEZ4OUhLNGd4UmFCSlNkVHZoS0NwRUVYTGIreUNXY2RQN3NGTzRINTMw?=
 =?gb2312?B?NEtZZFNoQjFicTZiOXNWNzRlOUJpeVBVdTNyMVRDZWdlam51NUtXeHBwaVBt?=
 =?gb2312?B?NWpIdjE3ZE4xQWJyVm81WkFuOWRhSVFscTZwdDg2OURBcnhTVWJBS0xNc29x?=
 =?gb2312?B?d0hQZHVRRFd4eHNNc0d2QXBCTnFra3J0a21zMGhQMmVQL2FFT3RSRUxUSDJI?=
 =?gb2312?B?Y0FDYWorQ3NmTlRteEx6WTBxQ2llR0JRdndBTnNtbGVrL3N4MmhmdFhMVXZz?=
 =?gb2312?B?ZWF1N0ZsZE81V1NOK3FraWhNSms4dUREUHE5aU5ja2NRZG9GTnJkb1BRUCtw?=
 =?gb2312?B?RFVaUXZmNjFmOWtVVHhNay9IWlltMXdiYlllaXNQdWFCdWtsamhQWkxhZ3dv?=
 =?gb2312?Q?GRbemEA2hRUwuzD84ZWaA53NPQ8Oz2D5G+NUU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q2VDcU1nNDlFV1dPS2xtR25DTkYzaENBaUVOaEdHa21BVno5bk14LzM1TSt2?=
 =?gb2312?B?KzlDVDJtdWFIS0lpL3RhcVZzVGZBa1RGY1FaQmFBOEVFOUpXRThJLzVkWXp4?=
 =?gb2312?B?b25YZUtMd25hWGNxNG9FRWNKNms5RENURWs1TkRnTzEvZmJnY3JsTUpra24y?=
 =?gb2312?B?M2xrQk5uZC9ycVpFYlJTRnFyRTlDR3RpRSt0em1XTy81NjNYWU93MVJ4Y0pz?=
 =?gb2312?B?aTh3VW95ZkVhZyttRHVIKzcwbHBaTlFjeldQNFNaMzZqb2ZXSVZoT2NmSDZP?=
 =?gb2312?B?OVJJQnVuUzdIODMxR1JZM0pVVEYxKzQrOVgzK1Z6Q1JPRXFEN2s4R0R5RDFQ?=
 =?gb2312?B?MHUxWjcvV3RkYjdZYm5hRmVhcnFjVm9va3hCMitieTFjQURZMUFGU1Mraytk?=
 =?gb2312?B?Q1ZhbkNRb0plU0VVVHloSHZCRjcra0NKd1ZPYmNNMEFZU1FXV2gySDVvSjNt?=
 =?gb2312?B?WEJyRHZpbjhWcVhpWkM0bnZCOVozVy9mdHhUTXYzMEx1RXo4Qlh6TTMyenc5?=
 =?gb2312?B?UURpZEhhT0cvTTFkSDlUa0U0V3liZHh5SlFNNU9Bakh0M3pNWldKSlJER0pG?=
 =?gb2312?B?a1Jua084Zi82MWw2RGNISEowNkVnUTlEaTZUeXZqMklFek9aazhON1lFMmxB?=
 =?gb2312?B?bWpJSy9nTmhXcmRPNGVDem1yM1NPc1pkeGlEdHZBTzFlRXU2RThuN3hCSE4w?=
 =?gb2312?B?cjBpVi9qbllHa0w3MWtmY0p0WWJJdjVXZktIRjJzTDNVamorODY0WkFpYzVp?=
 =?gb2312?B?L2wyM0tsY2prWURnYWtxb0p1bHlRQm9jOVMzU2JlelpjOE1pc3lKMTlUTXFu?=
 =?gb2312?B?TFRoM2VMdE1Dc1BXcWxQK0NqbnNEWWt4R29FNk1wUWpacit2NUFDVUU1WGpQ?=
 =?gb2312?B?MzhVVTV4T2laWnl1MnRTSElwczhDd3Y1S1BIR2cxZjh2RGFBb3NLcExhZ3ZP?=
 =?gb2312?B?ZU5BdkNYSUJJZ0Q2Szlra2VYdXZGZ0pJN1QzMzY2UGV1MVR4VVRvRHd0aThC?=
 =?gb2312?B?M1ZBZkxoZkVwenRscUFKTkExTmp1R3ZTM0pDWE1JT0FBR1FEY2RGcFZLYWR3?=
 =?gb2312?B?WUpuTHp1akVPT3AyK3NSOEZDdHRtMzlscERaNU5tYng1SFhDZUhZdU12eUxL?=
 =?gb2312?B?cDBMbGpUSUhEMzd1dXV1UEJNWFpWT2o3Y2t4YXA2UEpzN3FzaUdxVThhV2JS?=
 =?gb2312?B?Mk8rYy9RRmt1cVVWY3lmMEVCN2hjeTFXbmh1QW1UVk5kM1VWanlxczhYOE0v?=
 =?gb2312?B?MXZuMklUM0lqSFRRYWFCVTFwdHJRQWpvTm1JVThJMmUwekMxV0V1d3ZPKzlR?=
 =?gb2312?B?NjdDdS9EQzFQUDljODRvdVB1bDZqdFA4Z2JPTGxxMGtSc25BWUZqa05RQWZB?=
 =?gb2312?B?S0hHV3BPelorYVNEdFNETWZxSHR0MHk1a0txMnhLWkFzRTA2RkozR2dDcWNU?=
 =?gb2312?B?YzN1TUY2ZER5Nk1nZzJHbHZWRGFXeFBPSGlETDhjTXlaS3BnRjVadHpBN1h2?=
 =?gb2312?B?R21OSXpyQVpYSGlFL3A0OThnVitvMnRMSUF4MmFoMzE0MU1IQWE2SVdEY1E3?=
 =?gb2312?B?M2J6R0xFdmZTK0lGekc2TzZlVTkvSFg5S0U1VWx3aEpwWkk0ZXdidGpIUVBx?=
 =?gb2312?B?TnIxNlE5UFAyMm90UnM5a3NzZ244VmR6Q2JrcXlvRW1mcVFMazRSZ29obE90?=
 =?gb2312?B?RENmejFQdlBHRWFNZzJUYy9JNEh6eUlMdi9laER2bXI2UjUvSk1vSnZGWFBI?=
 =?gb2312?B?Y21hWjVhcElsZGUzamNMYjdNRjFyNE9sTDEyK2NxdTZSYXZOQmFEVEIzai9y?=
 =?gb2312?B?b3JzbG1INmNWVEJQRlNxaFZWaFhSZjFWNHU5WlRWV1FBajhHSWxBV3NmMlRS?=
 =?gb2312?B?QWxTYk9nSVh1UzlLNm43MjBDVk41eG4vbmxaS1QzTkFRRC9aZ20wMFhqeU9V?=
 =?gb2312?B?WVR3amZJVytvNWowQTJNYjlhQ3ZXRlprb1VSb2YyKzBYUlFNWDZQNFFFL0Vi?=
 =?gb2312?B?MmhQeDdtQ25tY3JFcThnNHhCa3REV2VLS2VneE1vWE1QUnFNWCtZWmc1Yk9O?=
 =?gb2312?B?L3RmdFkrL25vaTYwZzhOUnhJRStOdTB2VXdjZzFMMDZqMmxlWTNrZHlYMVll?=
 =?gb2312?Q?cRUc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c6fafb-eda2-40d9-ece2-08dd03b6ac86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 07:42:06.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5hNsE4aGkkI8md3XnbjXMjqwJIhL4HtfTp7SyExX04Xur+42oSu2l/MEtNn+McNuof3pxOMtfFTPH9qj7xtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11061

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEx1MIxM8jVIDE1OjMxDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IENsYXVkaXUgTWFub2lsIDxjbGF1
ZGl1Lm1hbm9pbEBueHAuY29tPjsgVmxhZGltaXIgT2x0ZWFuDQo+IDx2bGFkaW1pci5vbHRlYW5A
bnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IEFuZHJldw0KPiBM
dW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBpbXhAbGlzdHMubGludXguZGV2Ow0K
PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQt
bmV4dF0gbmV0OiBlbmV0YzogY2xlYW4gdXAgYmVmb3JlIHJldHVybmluZyBpbiBwcm9iZSgpDQo+
IA0KPiBXZSByZWNlbnRseSBhZGRlZCB0aGlzIGVycm9yICBwYXRoLiAgV2UgbmVlZCB0byBjYWxs
IGVuZXRjX3BjaV9yZW1vdmUoKQ0KPiBiZWZvcmUgcmV0dXJuaW5nLiAgSXQgY2xlYW5zIHVwIHRo
ZSByZXNvdXJjZXMgZnJvbSBlbmV0Y19wY2lfcHJvYmUoKS4NCj4gDQo+IEZpeGVzOiA5OTEwMGQw
ZDk5MjIgKCJuZXQ6IGVuZXRjOiBhZGQgcHJlbGltaW5hcnkgc3VwcG9ydCBmb3IgaS5NWDk1IEVO
RVRDDQo+IFBGIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRl
ckBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9l
bmV0Yy9lbmV0Y192Zi5jIHwgOCArKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfdmYuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y192Zi5jDQo+IGluZGV4IGQxOGMxMWU0MDZmYy4uYTVm
OGNlNTc2YjZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGNfdmYuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGNfdmYuYw0KPiBAQCAtMTc0LDkgKzE3NCwxMSBAQCBzdGF0aWMgaW50IGVuZXRj
X3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiAgCXNpID0gcGNpX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiAgCXNpLT5yZXZpc2lvbiA9IEVORVRDX1JFVl8xXzA7DQo+ICAJZXJyID0gZW5l
dGNfZ2V0X2RyaXZlcl9kYXRhKHNpKTsNCj4gLQlpZiAoZXJyKQ0KPiAtCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZSgmcGRldi0+ZGV2LCBlcnIsDQo+IC0JCQkJICAgICAiQ291bGQgbm90IGdldCBWRiBk
cml2ZXIgZGF0YVxuIik7DQo+ICsJaWYgKGVycikgew0KPiArCQlkZXZfZXJyX3Byb2JlKCZwZGV2
LT5kZXYsIGVyciwNCj4gKwkJCSAgICAgICJDb3VsZCBub3QgZ2V0IFZGIGRyaXZlciBkYXRhXG4i
KTsNCj4gKwkJZ290byBlcnJfYWxsb2NfbmV0ZGV2Ow0KPiArCX0NCj4gDQo+ICAJZW5ldGNfZ2V0
X3NpX2NhcHMoc2kpOw0KPiANCj4gLS0NCj4gMi40NS4yDQoNClRoYW5rcyBmb3IgZml4aW5nIHRo
aXMgZXJyb3IgcGF0aC4NCg0KUmV2aWV3ZWQtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29t
Pg0KDQo=

