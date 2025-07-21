Return-Path: <netdev+bounces-208520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B835B0BF01
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41597A1446
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF812820AB;
	Mon, 21 Jul 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j1oFO+qN"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E7221267;
	Mon, 21 Jul 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086854; cv=fail; b=P6S5m+uPF84+/hihOS1P4Fu0ijHrMKtzL1j80pD5/kG/ccKPzcq00depU81JfVYpl5cmXAq0MXyJx23X8fXjqrytDghzEo/zZG94wlFTwaTzxsT2iXWDSCUzVOAKtGi1Xrku+7Yvxb/GxdgFEwuyJ4ndhPCWNV2+5EdjXbiPZzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086854; c=relaxed/simple;
	bh=G4NzZJ+wqLeHBg7vskrn9xvU1HhTwZzq2UsClBMiPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlplNl0vq9ATUAEEeREtKJPMsxOe/HeV6u+TYhihfImp2YtpfmaDWW68WQx9jL6qCYjrBcbhN5YvhJqMqKrWY+Yx0GAH+qlRCaTz/vDCuadKqBJwLylF7xJSpMnEMg3Zd34fOWY2/0dk6Wufaj/fLGutYDFowrLJIBtkmdy/PWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j1oFO+qN; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9d/VNJMk3YNTLo3FzqI8vHfWYUjkCazv+fkt/2Plsi4Tk4p55jIeTOeEzDlrOIxWYwHavQuhLfJj/dphcxI1ZOstAdYdpFKeHQqVpM57yrk9YgYIzd54s9c+099cAD1vbRN+bGkcEi47ebKu3f2SumTVpvc2/ZmFfD1O80ri5WfvAdlfH/iTiKCwOKwf1HupR0uc+yx5oYgtsv6eBI1iaPrKxCnWdpKbARs2MRIvtz8fmByDL7a0Rv06n/Ak+jBXEJhyhzdnN26+d5tcj/ivVA+kCKCrkE02mqgd4cbYqnJ8sMvkTgXJOOlhZ8TS+UaISy/z59S0pQ4CSmi0BhJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P72AX2xUo3bdRBLk0+O28sQIlygGM83FUumUYsm+jI=;
 b=gYyH+6IfKSn+cj7THZpZwXLIr6UKzSzm1jOLnelM2mWXdkICDabBbOqsk8kAkriveYeWvTpojwQYWvmpGbCPPixq8HJKul0RCs/6u+e5zxoSTOWlmvEXiIw1n2ECoyUvlf7FfS/xm8R8NEXLlTash5Y0NhG7xJVhy1dKvHhnE7om8HukL0KOJ70giuSi+QaXIKGVKdTqb4F6ZrQFHJVthnYZzbyndWYFkxSwwHDIWcHknm9y7gNOcFgCYoe15EMKUMYiaXkEZB3rluv6/6Ty8dDuJFnOBpryjs2iP6/mZWOy7HurQxBlygp0eH+gvZRlYVpaIk6zVR3fHqiGcM+36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P72AX2xUo3bdRBLk0+O28sQIlygGM83FUumUYsm+jI=;
 b=j1oFO+qNSFi3+bNzH6hlzMIVJM3E4z8P+ATAqP/mt6tL9chO00HS7Ypg6WmM80Ma9Nm9jDHfeyHS12VbSiH/ZWwKruDXBjCVvyArj02DYSej5NFZ/qPojIJPA3QsIdWj6qWoiaS/0TnYn9rQuyp7iJsN+F0dgYZ6ebq4gj5/rw83zo1MrJGSKTeN25omen7x+wxYuHyXJYzs2F2th9/n0KEx3t5K4g3IgwyrDUR+Ucrqob+fDs09uojx9zWzxHcoc1pFBDHLVvQuTwSLFgjcT3BOm+lXP2ZShslrJPgVvG94t8TWFomyZ+xaH6QbpgR+3QiQFSJTtxoRX7nQ0atW4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:34:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 08:34:09 +0000
Date: Mon, 21 Jul 2025 17:44:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] net: fec: fec_probe(): Populate netdev of_node
Message-ID: <20250721094435.GE4844@nxa18884-linux.ap.freescale.net>
References: <20250717090037.4097520-1-primoz.fiser@norik.com>
 <20250717090037.4097520-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717090037.4097520-2-primoz.fiser@norik.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: cef9694b-70f5-417f-76b7-08ddc8315c85
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3TvQhEV2JcOo5TY/Tq4Vww+q+WfxaS5HMTj3E/zWVa/DGx9+A7bIylZw+o+O?=
 =?us-ascii?Q?n2D581F/Nv/GBqzRVzmmvUAQLIWGYCcluS2jo1SczuLoLU0cPme3UZufKK2W?=
 =?us-ascii?Q?7IJNsOkROkxZcbWVDvi1CnlAQj/0Kd5c9Y3oGynFxgm8zQh5KuqrkyJipKtB?=
 =?us-ascii?Q?+aCXeHDPlZoiFsbW8TbM/6ZotwMiJFk0yFAP63uJz4xVwF8Et/l9H/IK9PHK?=
 =?us-ascii?Q?63gr6wDPJ67Rc3jsc5knty9lLwRqyHeSljG6gaq8ZrzXiBJkq6Jm2orJ44ci?=
 =?us-ascii?Q?Rzoe7fDznyrzwE2xnyHVbO2cdlSQEZbB5EtVzT3u8Fl2kMs3TvfC+WwQvIik?=
 =?us-ascii?Q?InwDG0aMjAUpKrdVBccgJVsKDRY0GUK2W5pWtciyqdnGvQjPqTrBp+0wDivX?=
 =?us-ascii?Q?oNMjDMaRjqzug9YrxSjVIOoDHtRRJyG8FH7iAFDZx0pBuO/MD0zV24CCw/K9?=
 =?us-ascii?Q?e8YdAhA90y5BfQIxjpwvIGGBTvwYyevHEzwYYlFCKpsmCtGDnJ0xBRSnZ9zV?=
 =?us-ascii?Q?j3jR9To8mMpdraT62FPy8Kl7gpaHPOVFPDH+UznuS8fMkw4iZ6yMkblunyas?=
 =?us-ascii?Q?ndocJF3ob+OsxSzbf9d053zNfa/m7LXCprKmsZZfq3IYHHrKWLeuxXQUch2Z?=
 =?us-ascii?Q?s/6Jn3URjJfxVuvJ7N/rvkwJcA2mv4n8+5UGla5n39ZNvCq6PdmPDudzmAD7?=
 =?us-ascii?Q?O6KFIK4mPmfLK2c5MJq+ZE9dAgz/fgMORODyshEXEBrvGFIHzIiXX5wqKQVf?=
 =?us-ascii?Q?3so4bUYAUafBYy2NS/crNATW05UAHZo1QmH+IV/4JX0X5cNO95TVLaf2N7TL?=
 =?us-ascii?Q?9F84WzDcR5XNeONAGcU/ovXIsEBu8R78PF8I5wkn52WMRCAAGePkLpJ+rXwK?=
 =?us-ascii?Q?HCV8qXZsEuHp7WCEQjOdGyJfSayyuEanLFgoi6GxNf9DoH1tza8fAHpIBvTq?=
 =?us-ascii?Q?NjZ7RysaTcz3W0Kz9zHD9r6iMEIrO2z3SU5jmKDMcgXYPxvQaCny8JFJmPMW?=
 =?us-ascii?Q?MEo4N2Pj+CT0ymniM82OwsnL7lnaIPzLQI2Vb6EbY88vM9uKyCCfgWd1MK5P?=
 =?us-ascii?Q?k90WGPTdfIxL2QT1OUdYwWsxXDKrs5NyhOczBiib+I39nNQC/nhxbH4yNCA/?=
 =?us-ascii?Q?E5z4APRIFQj0S+YmcmHwfoWhmCP5tss/+1syW/4PqxCGI6g/7u6PPnPaXYDP?=
 =?us-ascii?Q?WdHXhCAk4FrUlzB5hYbdxma18Tq3XrKyJ+peDhMtacN3U29ZBdzSbUy5ySgb?=
 =?us-ascii?Q?pIZgopGpQUCZ7LtWhfiMaORSGEx2IOkPnNiZpjfrlj0wYXUPjGXikxiiIBIX?=
 =?us-ascii?Q?t818SOw2VqIwmYQ41a0EctUINYtwVPNARdrhNprBe5+j4e7LthkZ5YrkN5HI?=
 =?us-ascii?Q?vTYIsonjQ0D1hkarhJnUIvVRkq0f1XwRJD3c3b4PuIC28qtzesps2wRnmCdh?=
 =?us-ascii?Q?e5+Dy0ySPu7cgojlDjOO89XEhOrXOQ71Vw8s8C5CWJmsp0aJUnVT3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYytAiy/I2sCcRNAQbJwG4M4DwgigmomJ1BwxpVjEumPeCZqU4QxizrBdtB+?=
 =?us-ascii?Q?dW28LTmqmUTSePqqic0Zzf13gYa6qOd1JLw7NTl7iXG6QSMsHH9TutZ3wv2D?=
 =?us-ascii?Q?fh1zgEV3/qOp6ocbt5crahWEstLpkWi0h/b5zd2Ypbbfa2lKRJlBBeI4XnJN?=
 =?us-ascii?Q?j33RRHRBScpo51egp02OQxFVkyEw2QgJoEZ+byfstKssSDaaD7rJTGO+PPdT?=
 =?us-ascii?Q?tjX2fCQAP4ov3LL9rGLeM/YpTU6VAC/frMVwYYbamh0d5QmC35u2r2k1OyBo?=
 =?us-ascii?Q?2nTXSsPPrmC4Nol/l0KaHIpsgc71JwpUF3gO19bxDRMEuJ5YoQ/zVwNRZsFa?=
 =?us-ascii?Q?05gEnRfNjsit/SoFRolzuDeVSoo8LSB+r6ijY1ipcUezcV1G7nnmJntVuFWh?=
 =?us-ascii?Q?4VAxQaUSxMV1mqbukOlZF9KE4SzI+EoWQgI9EUCFvH5TZ+gShfKZ7aQ0lTof?=
 =?us-ascii?Q?FYtWAm+vVglYR6T9XXl22938U1VBD3z2ifN7agbuyuO2Y7qliyYosqRrwp2g?=
 =?us-ascii?Q?bzKJTFIeeR2XYRjDAVl/PEpS7FsQiODswb1EZcdWzNGOmQpfc1O+ZQxeix/P?=
 =?us-ascii?Q?4MG92vG1SssEoT4hdEzmrKjzm5n3NGkQr/jKsE/ba56eirE9HnL5hsBhZdZ8?=
 =?us-ascii?Q?g8dEp0X6wSZbRuWGbv/med1bb6hth7WwA6QSL5K9a97ZgueeXhKYeQOIRNLv?=
 =?us-ascii?Q?TEgwr1uIBIKnLTIQ0XsQXYmM3Qlmp0ltvCwLG59/Y8ytcC0NmLUrcS71/EuU?=
 =?us-ascii?Q?YiHUetLDI0kFkIQK9c5fz6zz3gU+NwDUBOY4N2jq+1yoC7yhQA7uaK3MXyJp?=
 =?us-ascii?Q?JlU/q5aFlTDCCRyp508zmZbIp6SAEPNN76Rx73r1w7Fz73JR24u7swJcU4zk?=
 =?us-ascii?Q?Z4i2w+WgqphRGmfeAAeFDLiGaNy9F0syFeZXMbEhro9wqjJjgID49XZD8XlA?=
 =?us-ascii?Q?JS91F8SvRZ9s9Zw9pdx/7tfMgvdF/wD3ZSCNbs4HHvwUsAh8CL5AUvpgQTXQ?=
 =?us-ascii?Q?7DiK+0v869S6eWleXLOsDBwHyEa5lNVnAl4oLPIZuG/7+eq/WUbQzsqY35Rt?=
 =?us-ascii?Q?19G/sfil8umL9UmrLh6X0+BIW8Qkj7qHXBjQndsQW+XZnEq14kwsoPUzBKz0?=
 =?us-ascii?Q?uYtICUbsqfNUb9Y5v9WVMmzIXdCbeXshu03facIhKrOH925pNOvoVgeffjDq?=
 =?us-ascii?Q?m3OJc21pfZAOJ2hAd1jZ3Vwlrda0SIS6FXsh7SveJkDKu2WxOTEH5QvrNXsX?=
 =?us-ascii?Q?X7cwfqkIXYBRH3r1SXMlFU8iOjtlaVBdKTwRidKRu+7/a67k8JvG8RLvHmo7?=
 =?us-ascii?Q?5oWrJ5nwXLrQ0GTm5R4sGAZ7AONBMauSIVWsIlBvT/9kWgDjEKI+VE0xr9NJ?=
 =?us-ascii?Q?PVqntr6hQK8pjGlilLgvKY8B+2AhzybFIfhWjVjmVAzXRTsMFpviQRgGOaBe?=
 =?us-ascii?Q?a+Ye0Ov3wTWXyNPYidlAbc1o1AH8y+rkCD0EEXDPXR2JHGHFcXMYok2UFfp2?=
 =?us-ascii?Q?L12mfQxsxPARpIQcDjPHdFXqpdfoKVt9Gpr4JbPRREtdRKB/FtRqzN8IX3iY?=
 =?us-ascii?Q?QFCsOur3c2Y9uiZHsS50I69eYigMo6rLSEDHbcQ7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef9694b-70f5-417f-76b7-08ddc8315c85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:34:08.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWaGtNDd1HdQGphMzdI69tYHikm6CHMdpEFRVlGcC8Q8s6dye3JHpouXqBb7JF/Mj+iZ+f2O0rBX4FOIlsA4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925

On Thu, Jul 17, 2025 at 11:00:36AM +0200, Primoz Fiser wrote:
>Populate netdev of_node with pdev of_node so that the network device
>inherits the device tree node information from the platform device and
>its of_node is available in sysfs.
>
>Without this, udev is unable to expose the OF_* properties (OF_NAME,
>OF_FULLNAME, OF_COMPATIBLE, OF_ALIAS, etc.) for the network interface.
>These properties are commonly used by udev rules and other userspace
>tools for device identification and configuration.
>
>Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>---
> drivers/net/ethernet/freescale/fec_main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
>index 63dac4272045..5142fed08cba 100644
>--- a/drivers/net/ethernet/freescale/fec_main.c
>+++ b/drivers/net/ethernet/freescale/fec_main.c
>@@ -4359,6 +4359,7 @@ fec_probe(struct platform_device *pdev)
> 		return -ENOMEM;
> 
> 	SET_NETDEV_DEV(ndev, &pdev->dev);
>+	ndev->dev.of_node = pdev->dev.of_node;

You may need to use device_set_of_node_from_dev.

Regards,
Peng

> 
> 	/* setup board info structure */
> 	fep = netdev_priv(ndev);
>-- 
>2.34.1
>

