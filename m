Return-Path: <netdev+bounces-136362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301ED9A180B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39A81F22C8F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611121CAA4;
	Thu, 17 Oct 2024 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vp6oNu2m"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C7225A8;
	Thu, 17 Oct 2024 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129784; cv=fail; b=mjzBT/xKzWA/KpwAjsGvUFd8vYdkjTvCLVrCC2R1NYc36xL/qR+ztJlCs/zZxvTN5VFE9xMJMPfhTBT7quIjeuyY5HE1PpiCtDbWhe6ruYWv0lLPfbyseHNzga2eh0FxDgGRkg1tEg4p1DStMnSiRIw2fSBJnvcY/iT6T237Lg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129784; c=relaxed/simple;
	bh=5Om6IK7SYSgIcbHjPwL10/l3QknhAavyXuJk/FLeH4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oeskic3lA1snn+N+INYZCTl97e3nAu1OiXYx0j96ue4syDQEkYJlsoD/CCMBdkskmoY4pI4lIxUrUffO2QkadPNX0sZx/ZjZClav4kJgoZC1XXLOV876ceJ2bVYs5nf5reihj4B6s8hDL/Pdhq1tbqaO5gu6Dc0ZszWzXdNeJVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vp6oNu2m; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQl7xQKDkHKpBzL/p8vs68L5Z/1Z2BVD37MEWvI+K5U6x0AtPjpum3OTpIMxVJ+nwXW+CY5W+I9UT37UfbOC8ZU7VFAcF5HxLaKlgZ63b4wnx6cyIPQjVzBbpEEBoKzb3iGfrjzACp7WJcz0kylp4bTTDOtBUz/Wf2XeKEsniGvmCmqzbNmR07HHaC6v0fKO0T7FBm5s8cGNBfJ11SALh/ICNE871wY2oV2CIXQkjhfea/ECc1rsz/nz3C4PF8z2A+eTFsJ0Zk9BLKNscXrT0E0iyDSO+pBHHQF48zRRb1CaAY4z+QaR1ow1Cdf9VOdpruYnD/xiiByN7InwYucutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Om6IK7SYSgIcbHjPwL10/l3QknhAavyXuJk/FLeH4M=;
 b=cWxCQdS2opekTxyQ8mJrGWBrtUCgEIDVl/mQOYT7uIkIdzlojOM33Z1zYLLugc2G9S94WeXSr1kDHEV3jBfxFE8Gh7+TtB7NRX322X6cpcWwPgBDCsbEmpO0/yQKCD8r5Jgf/ZZkpSzxmOpAkonfN8AIye7Hzp8xcoxKg4KLlbqKQUcU3p61q6gZo3yViBYh437MZ3PROVyhk6xdsWxK7We2yP+3x2nXPE0e9GnJBPhtqZw3YUgEACrHvhlvoiIWFRAYkOODdgO8tQ6KnkvD3ZJfztfH9hJdDyPg1aih6KfjUbGFxvyXBpS0VlxkF4ORBPNdCbflFfozru8tRtgk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Om6IK7SYSgIcbHjPwL10/l3QknhAavyXuJk/FLeH4M=;
 b=Vp6oNu2mkD7RrkEY2S4PxNjiBOqCFNHoUkFAUEsQHruVJ0ZWA9/Dx9g+0PnX8SuUws/hHNmy3W5CYa8SEUbLRUvHlOxthw025Hr2sy3AiYzkX5gClDCIN/A4SuN9eO9YALwggtxY0jJBZxAnP73h/Wam4P7yrntkRjQp5ZAfEl3nH+N/sIFQx3SjOKAUHPXp0mvLX5hZvMvDOxrliPzXBC2cYZ/4Fpw/CgVkItyzdrCLsJrjKVFe5eq48hHVwplNug+IeJmb/8IP+vWSWV8Lb6MBscgFS9w9CmEQkMNqzKRANcClFclb3hAxxyjP/+6Ic80kipQx5HGThwFKPnKXjA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 01:49:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 01:49:37 +0000
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
Subject: RE: [PATCH net-next 06/13] net: fec: fec_restart(): make use of
 FEC_ECR_RESET
Thread-Topic: [PATCH net-next 06/13] net: fec: fec_restart(): make use of
 FEC_ECR_RESET
Thread-Index: AQHbIBW0zDu23QOfN0GcoXvQn37yl7KKLUlA
Date: Thu, 17 Oct 2024 01:49:37 +0000
Message-ID:
 <PAXPR04MB85102560A879C8F6A057B1B388472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8346:EE_
x-ms-office365-filtering-correlation-id: 5ac783b8-3f74-4357-d1d1-08dcee4df51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1p2U2FjeGp1Q0hnNEZRZ3JLNjJvYktRWTB2OGllZXdVM1g2em8rR0hJVlV0?=
 =?utf-8?B?WWFJNmg0Njd3QlVmMHArTWFMSGdZZ3FDK0U1emQyZ3BoS2d1UjkwZkNFcGpD?=
 =?utf-8?B?M204UVhIRmtSWkI4dkFmM0tEOHFTYkdUOHRCRFdmUW85SzZwdEhBVUNoaStt?=
 =?utf-8?B?ZWN6ZGwvdFY1eEw1RHI4UHU0aEFub1JEcWhpZW1sbVg4V0taelVUam1ScDBz?=
 =?utf-8?B?SUhPQjFDemtibThnbUZuODd3S3FrVTBLL2ZpdGxuVjZoSXllT05jeHZnUEhm?=
 =?utf-8?B?L2RhcDd1amliTHBURkdDZXNKaHBQaGtNbkM3cWJlWU5uVkRYZ0RlS21oTDFB?=
 =?utf-8?B?VkhFZzl0NDBZd1llaGtrSGxIWGNtNzJJZEl5QzdZNkhSR0p4cGJhU25sNE5y?=
 =?utf-8?B?TjRhRlpodkpPeXNvM3k2T0E4Z1NBY2hZV2pIVjFNaVg0aHFlZU9jSDBPVmF2?=
 =?utf-8?B?bWFaaXV5OEZ6WDVnRXdlMWhBTGZKUk9kdDlOTGVnZ3hsMk9tSXU3Y1EwRU9I?=
 =?utf-8?B?dEJZQWdFRzQ5OEdlR1RSa21LbHR0bHFTSGJDWnFJNzZZc0JmNTlkMFRCdFhp?=
 =?utf-8?B?Nm10Nkx0OENMbXVhVEQrYVFWcGNZakpnU1ZXYVZMWXIxYXlIdldXZEFmL2hQ?=
 =?utf-8?B?MkNLOTZlZFBTa2F5MkpMd1I2eVVKQ1R4ZHhZMnEwVUV2UitPRHQ3WlpteXZG?=
 =?utf-8?B?ZmxHVlBZeGZ4c3UyT3hxTG16MzNLSkVOU2JiQjl4UXI1bmxuUkREdlpYUzZC?=
 =?utf-8?B?RytyaHBqQTZkYlhwUWhTVXpiQmVHTzkzOXY0SWpsSVpxSWM4enlPRjZCY09Q?=
 =?utf-8?B?WEt6MEpsMy82cU1hUG9vVDlFOFRHQmc3MVhUQjI4NklyQnZvbmZ6SU5DSFZ0?=
 =?utf-8?B?NlM3ZXVJc29zOWNHMEtTRlhhVDRLNUx4akRGanlYN0RXMjV1a0tLS0VuZGMw?=
 =?utf-8?B?TVBHRnJHWjlQK3g5WUlMRzkwN1hOT1ZpcDY3T2JLWVpwWWJFZVZnNVhDUm10?=
 =?utf-8?B?MUEzM2JoMmpnc0JxS3M5S2dpSjlSTVNBNk5LVHNDRngrWjh1a3o4ellsWGdH?=
 =?utf-8?B?bWJZbk9ORXhiNnU3VTFiNlpXRklKdEU5SFZ0Sm11Vi83Snk5YUE5U0dEL3Ur?=
 =?utf-8?B?a2ZDS2pXbEwyODcwYU9qZVNPeWY1Qkg2WkR6QWw0RlJCTUYvYW5SeWdVNzlC?=
 =?utf-8?B?enlvRFhJcG8yU1Q2WFJsbFdRNlNiL1R6OFlZMnJWSTZJYjZVdi90NUVlY1ds?=
 =?utf-8?B?QlIvc2FKeG9wM3VjdnorQmpzWXhvSTlrcjNwSElPUGxjVVJ6a2ZvaEdydzFN?=
 =?utf-8?B?L3lzR0orZVlmODJvbmFMVWJNUnM2MmMrVEhZblFXYkVMNHF4K3FmOEdURGdP?=
 =?utf-8?B?dFI5NGJtdnB3c0pVc0U0dDVQQmVMbTh5Q1NaVlZyNjFBK3BnK3o5Q0M2SGFa?=
 =?utf-8?B?VEYxMXFicEFlellrdG9kaWgxQzdtSDZDOTdTRzh6b3BhZjB1ZnpuSVYyQkpz?=
 =?utf-8?B?eFNzekw2QXh3UFVzYzdOM2FBZHd6ZlM1YjUydzUwRWNLcWNFM2xTQXM5dmJq?=
 =?utf-8?B?anVoTmlsbmdDN2VHaDltWkFLNzFMQlcrWmYySitpZEhOY1NGV0dUaEdYVzlQ?=
 =?utf-8?B?NEV5QlI1WmpKZGE1SzVsTTdrc3A2WlRkVE4wbXpwdXB0aTQrM1k2YXlHRU5H?=
 =?utf-8?B?QVQyejJ2OXMvcXloNUVnUitLU0RjUzNMS1MzOTUvUEFtRVBaSnp0ZmowdmY2?=
 =?utf-8?B?RG1abEFBT0JWUDdUM1Z4ZGxYTWkwS0VVVSsyOEdxZ2JCMFoza1l1U0FYVm1v?=
 =?utf-8?Q?BcnXfrJdluniwKV16qdiuQXETx6cPzxJIum04=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHQwcnEyRFZTeXc3OWJlQTl0ZXYyOERuQmh3elYzODNWNGNTNGVYVVdISUV1?=
 =?utf-8?B?QzFKb0pRVUpRekVmR0NkcUt1UnMyU25sRWd4eWgwZlV2NU1meVpnSkxubm1C?=
 =?utf-8?B?VzZkSVowVGhDNzRwTWxQS24vYk9NSFA5VUdSVFJIbjlQTldBYng1cnF2Q0NN?=
 =?utf-8?B?TTBZMExVZGhReXVpL3RDT2J5WjBaNzVnbUE0ZTM4THJCZEErc1JkRGtaR05G?=
 =?utf-8?B?OVpVMmg2QWl6eWVlMzM3U2tQaS9mS2dLcWFESXlHaHZYeGx4QTU2bndJbFhn?=
 =?utf-8?B?NHI1WkFiSU9uTko2QWVuQ2Z6ZDJZWTZ4K2tPYTJDMEo3RWFrL0Y2ckIxRmlj?=
 =?utf-8?B?ZzByTFdka01jbnJSUE1lekowWGRaNUY3TnJITXpOOEx2WWlMQWpzSjdTY1pk?=
 =?utf-8?B?Nk9qSmVaS0NqMEM2MXJ3MjJidytsem5mb0ErVjk5UldRYW8yZGV6R2N1SHVB?=
 =?utf-8?B?dTBJcndvS2xUcExLVFoxQ1FpVlR5YUxCZlFRbnVwemwvb1RHZHZuSmtKZXpJ?=
 =?utf-8?B?T2xQSHhjMVhaa0I3RFR4Qlc2SzdHeXNjTFNrNHhKa25NUmVkMFYyK2tIUGhm?=
 =?utf-8?B?NmdWR09GZEdoOGJWVnhWdkVNL0hFMUFsU2hTNzlncnZTcUZlUmZpeWxzakh2?=
 =?utf-8?B?UkQ4ZkY1UThYaDhKaXlhQWZRQWw0SnY5a05mRUZiMUg4OWI2NitBMFZoWCtB?=
 =?utf-8?B?azBOdVd0WWw5VUEyYVdGalJHY2xSR2prY3BzcURPdUI2RkNWVTcwZjZZYkdY?=
 =?utf-8?B?c1czQkFCLys3clBWakhYRGx5TTROMU5DYmZiOW00WDdoQ2lGUWhKTVNQaFE4?=
 =?utf-8?B?ckdaK3pxdU96OTk1SkhOaEMzVFFoTDlud3g3bzdKZ3ByQ2c4dUJoR01BRm5C?=
 =?utf-8?B?c1o4eGljSW1GVWVSMTQzQkMvL25VSy9oT2pERytTM0lrVk9VQ05ES3RDVUZz?=
 =?utf-8?B?aEVQRVdseVdkYldqa2MzUXgvU2JiR0wxNDBzeW9nWG9ySDVZVUwyS3BMdUor?=
 =?utf-8?B?Ym5zaUx6clc4NitEVzNBUU5BNjRQSjlWb1V4d3kvY25XOXpsalRhQzNseVhj?=
 =?utf-8?B?TzdsQytXc0JhVExyS0J1bDR1MjBKMXRDU0FtOE5RdXZRdjIrOEZLYVZkVkJj?=
 =?utf-8?B?QlhwQThyOGJ6MXFGby9SK1hUWWhhWE5hejRmVTd0NE9Dc1NqNHFwMHV6NTNk?=
 =?utf-8?B?UTJuY2wwemtMR2NIaC9MVzc5RnV6RkNwcitLNEluVmZObVBWNUUrUjYycC9v?=
 =?utf-8?B?T1ZRVk1PZlh3bjNkL09jTGdXUDQ2Rm56NzVOZUQzc1dMR1R6RzNLWUIrMWJJ?=
 =?utf-8?B?ZDBXWnVXOTRPdUR0SDVKUG9iNVBJVWFPSWc3em1PZERLQ3h5TUFwa2NaeWwz?=
 =?utf-8?B?amVnZmFMNHVWckVLanI3MjNDWlJocE94RGE5clhGSC9nSzJ6ckRmV3I4SDQx?=
 =?utf-8?B?cmxIaWtEMnE3N09pWmRaSldudDZoUE94Uk04V0xrenh0dTdOeGI0K3NtNUoz?=
 =?utf-8?B?RzRlNUZCSVVyL1Y4UFl2RVhyTFJnUjcrdyt5QXptKzNsSUk5U2x2MGhRVGwz?=
 =?utf-8?B?c0dKYzZnYWZOcXRkelkrYTVtVnpuY1hSRmJWWUJ2aDRCQ2VHNmV1eW5qSDVs?=
 =?utf-8?B?NG9jaFoyVmdjNEhObUpSTE5OWmVNREcveStGbWlqTWxPSm1QOStGaVBTTEVG?=
 =?utf-8?B?OTcwVU9CQ2lJcmFGOENaMzFBbnV5ZTJoR0RZSE5zM0JNbDBaMXVQdk42dlRG?=
 =?utf-8?B?bXNwaHlScnBkSS9IWTlvR2dxTW5IYzNSR2lhNG5RdXU5dld1aVEzTmNTOGJp?=
 =?utf-8?B?R21qWFY3ajhLZFk2N2NNOGRZQm4zNDc3VGNILzZXZ0xpTnFxb3EwcjBGRmlO?=
 =?utf-8?B?QVBCajkzNGRDYThmZmVTaU5nZUtKaW40U3JoMU9MUjNDOHhJdFFQVkdSaXF2?=
 =?utf-8?B?K3ZlcWgzZUczZ1B5MjZQNzNXN2xhMDhNRmVzN3JOb0FMdkJoV29MQVBaN2FK?=
 =?utf-8?B?eGFtdzROSCtOcGxOODN1a2RncnBIalE1THA5c2hMeWR2Q3Nja1ppaW9uZGxk?=
 =?utf-8?B?UzIwZzVGa01LL2lmZS9FazdGM3c0Z0pRTm9RYkVLeFFEUTRBL0FxNXVvTVNU?=
 =?utf-8?Q?FTg4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac783b8-3f74-4357-d1d1-08dcee4df51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:49:37.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kon1XC0Rn8xb759//JvFNrSqh1RKuH5sQ4IHHQSTDQBj3YiL9olHD7EZH8EcNIsCk+fty2Nh77jnFC0AoJEIxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

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
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwNi8xM10gbmV0OiBmZWM6IGZlY19yZXN0YXJ0KCk6IG1ha2Ug
dXNlIG9mDQo+IEZFQ19FQ1JfUkVTRVQNCj4gDQo+IFJlcGxhY2UgdGhlIG1hZ2ljIG51bWJlciAi
MSIgYnkgdGhlIGFscmVhZHkgZXhpc3RpbmcgZGVmaW5lDQo+IEZFQ19FQ1JfUkVTRVQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRleA0K
PiAyZWU3ZTQ3NjViYTMxNjNmYjBkMTU4ZTYwYjUzNGIxNzFkYTI2YzIyLi5kOTQ4ZWQ5ODEwMDI3
ZDVmYWJlNTIxDQo+IGRjM2FmMmNmNTA1ZGFjZDEzZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTEwODksNyArMTA4OSw3IEBAIGZlY19y
ZXN0YXJ0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPiAgCSAgICAoKGZlcC0+cXVpcmtzICYg
RkVDX1FVSVJLX05PX0hBUkRfUkVTRVQpICYmIGZlcC0+bGluaykpIHsNCj4gIAkJd3JpdGVsKDAs
IGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJd3JpdGVsKDEsIGZl
cC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+ICsJCXdyaXRlbChGRUNfRUNSX1JFU0VULCBmZXAtPmh3
cCArIEZFQ19FQ05UUkwpOw0KPiAgCQl1ZGVsYXkoMTApOw0KPiAgCX0NCj4gDQo+IA0KPiAtLQ0K
PiAyLjQ1LjINCj4gDQoNClRoYW5rcy4NCg0KUmV2aWV3ZWQtYnk6IFdlaSBGYW5nIDx3ZWkuZmFu
Z0BueHAuY29tPg0KDQo=

