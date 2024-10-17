Return-Path: <netdev+bounces-136393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F029A1955
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7991C2121D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9621C36AF5;
	Thu, 17 Oct 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjQmJNCR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904217580;
	Thu, 17 Oct 2024 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135996; cv=fail; b=gsyChgtxWRWVUgCYXllIlI+CTnpjMm/aBZhcTy+XaB5BXbOjnM+mRUfl0KFnyo85p3DFeDJcEiDtLyThTY6njAmrpF1HYJX6GPTg1VMv2OC/wAVZkswGYz0UXsOC/dPRhnn3Ole5zp/GKZgxau7k/vTRZraMsbHhMCMVLn+2cRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135996; c=relaxed/simple;
	bh=hwbhqHO5EkASTUawmlirEPjTcShDcUaUYpcnxMwQBjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gsjEFezo0TX9+qGnSsEJBSjy7khNTZHBTKRPqsCcjCM/MkhlqqHOKf3gKWp1SwNucR5C9h91Qc2wHuaXqWghzZWwsGS51GtSU1Vqt6TWSC1MSUR52F5PDFGMdRUA5/S23YetGdtb5dGO5xPqP5AiAdB81O2mo86Vpik+Bm1DueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HjQmJNCR; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Pdjy/uNzB0lXVy8qaTXTbwBfWqhaEld83MdLQcN9esJ3v29WM0uq///9KqeXETRkQ1d6hrGBC+FdAwZ4P/NUVYDI2+ZO23z7OcQhV6LD0nOeklpaxdmED3o+wUt5BiPMpNiFJKnnEe14cPV4g/EsnAILhToUw8GFDhJ8HAI93+7p1CVDX4QZp9Yi9lGUFcEracgVG3dF8eVM7I7dqgMiLrCFnZ7gWBWmuEMqZ1l0T2wJepqM+ajFEvItCkmAcWfVPZUUCHV/rWuvZH620ntN0oJmrUtgDf8CuMQfMFbZJkiAPoZ3q12exePPYitthvnxlqNAo6jdGuOyVi+U6Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwbhqHO5EkASTUawmlirEPjTcShDcUaUYpcnxMwQBjw=;
 b=agu9aHlEOy+lZ18857GZybwUgISCLRdEIAv4qlhTdv66LmwYHPnkhlGIha4GOCyz8nY+1hXIBtj9VsDc7V0MjCq+/BBmo19DFDJcTtqVNRDzS9bLmnZpOEO+7vj5TyFFzctw33kCsKp1JHzTDTqhGNSAT6kArFaeUtVFEfZS2daY3Y3A4RLY4BzG0IRsqAXM5OWE0KobWg5K+37xiy7f6e/MNZFJ/e3Kyg0qpt/ovqX+xqd0gkSaHWKnfDiGNbWqIhriWYRMbNCKEkqWrIcrCecj+SrnP08u187gMOGOnDF8U3Jka8m1sCuafwH9kPQM73AnWGjqw+DXAdm7gAprLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwbhqHO5EkASTUawmlirEPjTcShDcUaUYpcnxMwQBjw=;
 b=HjQmJNCRFbWTixjFjO6SY1fInauAtipcUpj7ZYayIKQRhWO6qISqsLAoFs9jf9WdOMDl+QfQQGcDtVQCeeosVGAMRAJg6gO8J36ViGlepjSJ9VFTxpqcRS5xgJIdtUMBZPlyB6XzNAdSccgotgaIRB5FH+mLyy5Hopp5dybtECp/U5Wiizaly/0iR3IhP5Ax+I225DO90YKRPjTDHal46oHJUKzrTTlu+E9fItpDcOd7ejQOFVPO2Ar2akXX1Y90VpJPJw9r6qt0/pp0sNeZWNJsXbGRj81LykqS+3eabXgewBxd4KkEzh2fqjr1TUNnJUbQnAthxJ5xFV/mq0hHdQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:33:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:33:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor out
 VLAN handling into separate function fec_enet_rx_vlan()
Thread-Topic: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor out
 VLAN handling into separate function fec_enet_rx_vlan()
Thread-Index: AQHbIBW1Ln+Q++z0lkqDR7nmqTk8k7KKSeZw
Date: Thu, 17 Oct 2024 03:33:09 +0000
Message-ID:
 <PAXPR04MB85104DCA7DED14565615E4A588472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7586:EE_
x-ms-office365-filtering-correlation-id: fc9bba04-916d-41aa-9c85-08dcee5c6bf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnF2VGd4dHVDTWhQYU1qZVNpSFhCRmJCQlVuYk9haExXdWRRa1VJekFaRUNC?=
 =?utf-8?B?THptei9JNVAzWmpsWnJUZHQ2dTZxVUNVMEdsOUl0TFZ6elhzU3RSTDI1Vndl?=
 =?utf-8?B?UGt5MHh1eklmWW5zejAzSmFjNGJTVTBMMEdiamJ6eEtmWkVRanV4OU9md1BR?=
 =?utf-8?B?ZUxMYVIzbXdiaDRGOHFrNkd2NEQ0U3Q3N1FGZXVOZENZNXBxdXZIaUpGTld1?=
 =?utf-8?B?cnVKcEpMVTlZZ21Wemhqd1JRZjg3ZTR3WjYzT3gvbE8wTENpeS9ma29qOTF0?=
 =?utf-8?B?aDZFS0RFNit4SkxPaEhTcytvUkcvdEhzUkwrdHRHZFV3SjhCQ056eWFPS1FS?=
 =?utf-8?B?NEUxbGVaY0Zxc2JoRXREeE1SSGs5VGd0VXJ6ZGpGMkdORGVVR05VL1FLalFo?=
 =?utf-8?B?eHFoTDFXU1VaRSt0ZGFNNksrV1pJZDI2dnpRVWY5M3BUK2tUZVhiQUUzLzR3?=
 =?utf-8?B?SmVHbWgvSk5CR3NFZUhLVm42cGhpUDlGM3NCWGJaOWxpZ2FmSjZkWmZhTVp3?=
 =?utf-8?B?ckFodUpUaEp2SGR3MTdSRGFBY1JWS09wVHhNb1V1cHg1R1lBblRBMXZmWG1Q?=
 =?utf-8?B?V2NnRGxHMlFkYkE3YkhYVWVENk1lR01zOXVlSWRRWG1CZlNZSGFaYTVlWTRr?=
 =?utf-8?B?ZmJQOXBaTFdqaGJRbHYyNDQ4T3Z2YzFNZzAyZVdqV04wZXFsUDl2dUFRcjNw?=
 =?utf-8?B?OGdVakJCTnBBeCtZZmFNRTBFL2VpWE9FWVE3VEdsVHN0RFhuc3NEbktqT0sx?=
 =?utf-8?B?WENIb3Q2WFdkTXF5ODhNbVJCOEs5cU5DRFlhOCtjU3RxU1NmQWszK1l4aGkz?=
 =?utf-8?B?UDBaNENXekxxRnhZdjBUc2JDN1htS0wxdDBEUjFnOVRSbXVMbS9VeEgzWjFJ?=
 =?utf-8?B?b1FUT0NQV0N4dWZLUmJuVkQ0TENIUHp4eW5yNGUza2liODNpZ0hBL1hvaDJz?=
 =?utf-8?B?WHRwb0krMS9oQ1d6WkRuekxicnR4UllmeGxybUNMeEFQeWQ0Ukw4b2dzRlVN?=
 =?utf-8?B?WmxSMGUvRnRjQzhLNnMzNmdpRDNpaFhuRUEyZ3pVUnltVVQ2T0RaVEpON0xJ?=
 =?utf-8?B?RGVRMTZCUDRGamJ2NVJhTjRBM3A0dVkraEdqTk9HTWNFZXprTnRuMkZ4ZmxM?=
 =?utf-8?B?S095cDk4ZWhEVEY5NHIwcllFb3poUWg3bnpxdTFncVk4WGdqaktzdG55Yk9Z?=
 =?utf-8?B?N2REUnA1Q21GQ1hncU52NzM4SU02MEI3RkJvNTh1T0JpWm9IWHU0MThEZ0x0?=
 =?utf-8?B?WU1zWEJmenJIK0hSQnVKNzJMaUFWYnlIOTFSVG9uMHBHdS84UzZveEFJOUJU?=
 =?utf-8?B?WFNkZmJ1Kzh0SmdoK2JBVHU3c1haM056QWMzSG03Q2JmeGNuc1BmRThicUkx?=
 =?utf-8?B?Q3BRVjN6b3EyUmFWTlJYY2E0emIxRG1WZzN4WXc5VDNDS0RrVlBLS2xWVy9n?=
 =?utf-8?B?UUJuVnhFQTVJUElZSnRMM3FUKzFsd21OWmpQbGJoNWNsd052Tk5uWG1ORjBn?=
 =?utf-8?B?ZTY3M1A1QmZiaEdpaVNuenFUVmpiZTVjU2VnMlFZRXFRb0ZURGZRNDFaMmN5?=
 =?utf-8?B?RWY0aXRHZGcxNldvUE5hdCtNVm4weUhiT1hpTVo4SFZPNnR5NDk2bFJvUFFr?=
 =?utf-8?B?MkNaeE84S2ZBM3NpU0J0NTlsNWZORHBUOEtUaCtVb25GQUc4NlBGMUJCeWhS?=
 =?utf-8?B?WHVTdjB1SlFJY2tPRFNOcHdtVVZNY3k4azZCRUlXVnFjOEozaFZPWHE3MVJX?=
 =?utf-8?B?YTAxOC85VzdRd21qSlVCS28xaFV1dm8zZjgwcHpEQ1hzaUJBU29vTjNjSnpu?=
 =?utf-8?Q?leVl2ruK96QktwGbSEk4afex5PFUJZE4wrr8w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0xtV3NJZjd2a3B4RVFMTzk0c0VWS1B2c1ZPcmZqNmpwY3M0RktPV1dqdmZC?=
 =?utf-8?B?b01tVmluNVhSS0huM0plZTcvWFp1YlplRzRpd29ZNEIzdnlLYmNncjRLanFo?=
 =?utf-8?B?QVN0MzBBbXIwdEdDN0ZGeFRUZm1ZWUZma291Sy9IYXJDZlByMWFOa1d6WlpI?=
 =?utf-8?B?OEtaRlhZMU1YeVdjSlBVWmE5dWdsRExjZzlrOHNRemhubzVBWTFTV2EwYUtn?=
 =?utf-8?B?UUV0dHR0QnprbmRFNnZMc2RiLzM2TGo1U0N5eVpCR1hsUjJtSzJCTmMrcy9Z?=
 =?utf-8?B?aEpXSmYxcVUwOWd2Rnc1Tzg5eTl3STk0V2FtOHRCVVp0dHZ6Wk1KajhMQ2NT?=
 =?utf-8?B?WktINUtLK1QrSEw1OWQ5Z3RxLzVMcVpocHBaTWFzWVJaRGNYUjBiQjltYXlM?=
 =?utf-8?B?M0hYcitBZWlLRU9jYnYxSGJlRi8wN2MrZ0s4cHd6azdKUjBsMGNaazZUVE9o?=
 =?utf-8?B?UEVrV3V1RENzN2lxbENzRDZ3eExyQ2Y2S2haNlFZbllDOWFjNU5xMkRDbjdZ?=
 =?utf-8?B?VGNrZHh1aDBJRXFGT3c4RG5oWmlqRldPOXNTeDZSRExzSDhPc2s0SDFTanpo?=
 =?utf-8?B?QU1VSFhvT2xOK1BVOFN6b3dsNFhtOHltRS83MXpwbUZmOENGbUZCR1ZkaDhp?=
 =?utf-8?B?dDBvcDZ4RURlNFNBQ281enlvWlRiWnJlZ1ZVZjVRTVMvVk9ubENaNUZwZVdJ?=
 =?utf-8?B?QnB4VUZXOEdwUHRxS2VGaXMrVWNNNEpZcUowRlBDeWlLbU1uZTd3N1NqSkJZ?=
 =?utf-8?B?Nno5RHYvMW4vcGRLTnF0NjMrMXJabFRpSm5CVmRTb3Y4dGI1WlVva2NUdGMv?=
 =?utf-8?B?Z2tJSGFBSVNCWStYZmY0cU1iK0kxdlYrZEhyKytVYnpwWmtYcVh2NThucDlF?=
 =?utf-8?B?WUtaU1hBQUQvMkNWUWhBbTcyV2d4emRsR1RVWFdvOXRUNy81S1JXNXdhMEpT?=
 =?utf-8?B?UVhFZEdmVUgvYVNIMHN2WU1BVk9EZjZKWXFFeVdzZTc5TFNrQ0N5ZVlTZmRm?=
 =?utf-8?B?bktOZHNGd0pjc2ROeGpqZ2xXREF2cjdFdzJZN2hVcU5mSjExQnRoVHJUUDBP?=
 =?utf-8?B?OUxSd1ZOeDBCMHJSZjQ5eW41bCs1WHZZT3lzTTJKMEgzRFFtclRrYmdtZ2x5?=
 =?utf-8?B?Vm8vdzN5RlZ6T3NiZEVFa0YvVy9BK0F2bXkrNHJIQ1BLM0R3ZlZISzlNM1JL?=
 =?utf-8?B?dzZOaUVueGF3TG5DSnJrSWlCQ3Y4U2xaRHJJSnAyODA1dkwrZVhENEsvRENp?=
 =?utf-8?B?TGdMMksvMUpDejdpcm84OXY4ZkQyVzE4djhJZHBoalVLV05GcTA4UFhXZlo4?=
 =?utf-8?B?d1VkZFNoeE02enU0YUVFTFZCN0tsRm5DdHZzRE9BNzVKSW9oVDNkNy81YmdP?=
 =?utf-8?B?VFdFSDRHdkRrTFd4Z3ZtYm5qSkFiQVB1SW5JeTlzTkJremNPZUx3Uk9rVWNi?=
 =?utf-8?B?VkdnYTUxWVQzTXVEZ0pMeHB4NTFoc25FRFVDb25qN29DQzBtbzQ4SHRqbjFx?=
 =?utf-8?B?YzJtUGdqYWR4YkF6dDh2M1I2U0llRnlVKzk4YmV4ajJrT3JtcnFDQUFKaUFw?=
 =?utf-8?B?R0FQQlA5dEZMTkpMV3dQdVlnZmRrQkNObGgwL1ZlbGVzaWJlMXNLZWhCOGpY?=
 =?utf-8?B?UGNkOVJGaGxsTWdsbGFnWFFUUW9QeGJrUnZDQVN3L0d2ZVJHbmdmd1kyZVRp?=
 =?utf-8?B?d0ozMGhtV1MvdkU5ZGlOMVk3cHJyR1lCZE5ReG44bEg2ckV2TVhFNzVzcjcz?=
 =?utf-8?B?ZDNRYkY0NVJrN0dNejl3Yks5cU9SZ2FPTmV5d2dpSktleUliczVEVm9LRm5I?=
 =?utf-8?B?a1ZFT0hxRkhUYWV3UGQ5c0FDWWd1SmZUR3ZvSTI1R0lkSk0veVM0alMvMkZr?=
 =?utf-8?B?UXhjcDdiNHNLUjB2V3dka0lGN1cvekluSGYxam4yUFd2eG01N2MxcVRSVjY5?=
 =?utf-8?B?dlUxUGR0Y2JQUm9EamJxck1xb2RybkNYRWE1MFlCcEVIVlNRQnE4Yk1ucjdk?=
 =?utf-8?B?a3dmRC9EcHgwNC9jME1FN0R5TDZ1M1RIM0FlcUFtTVJKQ3ZDMjlBMEV5S2Mz?=
 =?utf-8?B?bWxXdWVvbzZoVUpKRUZBRkt6WVNZemRrYXkvdWNsODlnL1JKeVRQVWFwMDdr?=
 =?utf-8?Q?WgNY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9bba04-916d-41aa-9c85-08dcee5c6bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:33:09.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+ktXMCguxy0XkextUeSr6inTNYsyFZWEJzHN3DetYTMIrLrqHQqMJXPloVA5DfT7OxE7aaPMrJsFODrw8AJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAxMy8xM10gbmV0OiBmZWM6IGZlY19lbmV0X3J4X3F1ZXVlKCk6
IGZhY3RvciBvdXQNCj4gVkxBTiBoYW5kbGluZyBpbnRvIHNlcGFyYXRlIGZ1bmN0aW9uIGZlY19l
bmV0X3J4X3ZsYW4oKQ0KPiANCj4gSW4gb3JkZXIgdG8gY2xlYW4gdXAgb2YgdGhlIFZMQU4gaGFu
ZGxpbmcsIGZhY3RvciBvdXQgdGhlIFZMQU4NCj4gaGFuZGxpbmcgaW50byBzZXBhcmF0ZSBmdW5j
dGlvbiBmZWNfZW5ldF9yeF92bGFuKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWlu
ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgMzINCj4gKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gaW5kZXgNCj4gZDk0MTVjN2MxNmNlYTNmYzNkOTFlMTk4YzIxYWY5ZmU5ZTIxNzQ3ZS4uZTE0
MDAwYmE4NTU4NmI5Y2Q3MzE1MWUNCj4gNjI5MjRjM2I0NTk3YmI1ODAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0xNjcyLDYgKzE2NzIs
MjIgQEAgZmVjX2VuZXRfcnVuX3hkcChzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwLA0KPiBz
dHJ1Y3QgYnBmX3Byb2cgKnByb2csDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0
aWMgdm9pZCBmZWNfZW5ldF9yeF92bGFuKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiKQ0KPiArew0KPiArCXN0cnVjdCB2bGFuX2V0aGhkciAqdmxhbl9oZWFkZXIg
PSBza2Jfdmxhbl9ldGhfaGRyKHNrYik7DQoNCldoeSBub3QgbW92ZSB2bGFuX2hlYWRlciBpbnRv
IHRoZSBpZiBzdGF0ZW1lbnQ/DQoNCj4gKw0KPiArCWlmIChuZGV2LT5mZWF0dXJlcyAmIE5FVElG
X0ZfSFdfVkxBTl9DVEFHX1JYKSB7DQo+ICsJCS8qIFB1c2ggYW5kIHJlbW92ZSB0aGUgdmxhbiB0
YWcgKi8NCj4gKwkJdTE2IHZsYW5fdGFnID0gbnRvaHModmxhbl9oZWFkZXItPmhfdmxhbl9UQ0kp
Ow0KPiArDQo+ICsJCW1lbW1vdmUoc2tiLT5kYXRhICsgVkxBTl9ITEVOLCBza2ItPmRhdGEsIEVU
SF9BTEVOICogMik7DQo+ICsJCXNrYl9wdWxsKHNrYiwgVkxBTl9ITEVOKTsNCj4gKwkJX192bGFu
X2h3YWNjZWxfcHV0X3RhZyhza2IsDQo+ICsJCQkJICAgICAgIGh0b25zKEVUSF9QXzgwMjFRKSwN
Cj4gKwkJCQkgICAgICAgdmxhbl90YWcpOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgLyogRHVyaW5n
IGEgcmVjZWl2ZSwgdGhlIGJkX3J4LmN1ciBwb2ludHMgdG8gdGhlIGN1cnJlbnQgaW5jb21pbmcg
YnVmZmVyLg0KPiAgICogV2hlbiB3ZSB1cGRhdGUgdGhyb3VnaCB0aGUgcmluZywgaWYgdGhlIG5l
eHQgaW5jb21pbmcgYnVmZmVyIGhhcw0KPiAgICogbm90IGJlZW4gZ2l2ZW4gdG8gdGhlIHN5c3Rl
bSwgd2UganVzdCBzZXQgdGhlIGVtcHR5IGluZGljYXRvciwNCj4gQEAgLTE4MTIsMTkgKzE4Mjgs
OSBAQCBmZWNfZW5ldF9yeF9xdWV1ZShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgdTE2DQo+IHF1
ZXVlX2lkLCBpbnQgYnVkZ2V0KQ0KPiAgCQkJZWJkcCA9IChzdHJ1Y3QgYnVmZGVzY19leCAqKWJk
cDsNCj4gDQo+ICAJCS8qIElmIHRoaXMgaXMgYSBWTEFOIHBhY2tldCByZW1vdmUgdGhlIFZMQU4g
VGFnICovDQo+IC0JCWlmICgobmRldi0+ZmVhdHVyZXMgJiBORVRJRl9GX0hXX1ZMQU5fQ1RBR19S
WCkgJiYNCj4gLQkJICAgIGZlcC0+YnVmZGVzY19leCAmJg0KPiAtCQkgICAgKGViZHAtPmNiZF9l
c2MgJiBjcHVfdG9fZmVjMzIoQkRfRU5FVF9SWF9WTEFOKSkpIHsNCj4gLQkJCS8qIFB1c2ggYW5k
IHJlbW92ZSB0aGUgdmxhbiB0YWcgKi8NCj4gLQkJCXN0cnVjdCB2bGFuX2V0aGhkciAqdmxhbl9o
ZWFkZXIgPSBza2Jfdmxhbl9ldGhfaGRyKHNrYik7DQo+IC0JCQl1MTYgdmxhbl90YWcgPSBudG9o
cyh2bGFuX2hlYWRlci0+aF92bGFuX1RDSSk7DQo+IC0NCj4gLQkJCW1lbW1vdmUoc2tiLT5kYXRh
ICsgVkxBTl9ITEVOLCBza2ItPmRhdGEsIEVUSF9BTEVOICogMik7DQo+IC0JCQlza2JfcHVsbChz
a2IsIFZMQU5fSExFTik7DQo+IC0JCQlfX3ZsYW5faHdhY2NlbF9wdXRfdGFnKHNrYiwNCj4gLQkJ
CQkJICAgICAgIGh0b25zKEVUSF9QXzgwMjFRKSwNCj4gLQkJCQkJICAgICAgIHZsYW5fdGFnKTsN
Cj4gLQkJfQ0KPiArCQlpZiAoZmVwLT5idWZkZXNjX2V4ICYmDQo+ICsJCSAgICAoZWJkcC0+Y2Jk
X2VzYyAmIGNwdV90b19mZWMzMihCRF9FTkVUX1JYX1ZMQU4pKSkNCj4gKwkJCWZlY19lbmV0X3J4
X3ZsYW4obmRldiwgc2tiKTsNCj4gDQo+ICAJCXNrYi0+cHJvdG9jb2wgPSBldGhfdHlwZV90cmFu
cyhza2IsIG5kZXYpOw0KPiANCj4gDQo+IC0tDQo+IDIuNDUuMg0KPiANCg0K

