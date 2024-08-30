Return-Path: <netdev+bounces-123546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E29654DD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26422281C60
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDD4D112;
	Fri, 30 Aug 2024 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fVUtPsRo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D144690
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982553; cv=fail; b=Y3w9IhkgcC3MUqJNZcpmEja8guBTXYzHaHITFnE41QS8Mv+/AKhW9xXKPJKVBPq0Docpu2QX5CUvP18jXI3hMQh3l89nRTN/0shTN85RVIZTYx/uulBiVemZ+3gEbu5b6HOOLxkTSqIjjMse6CJ3hvgeApkuNnicThBDlbqC+pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982553; c=relaxed/simple;
	bh=DHT+kkCXWvYTvNvUAsb4IXOp2zqJlCgyTgAB3ffheBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arrelUiUx2dWUlPW+RJ2h0vwRSrbGyQYiPEVeMELj+pU0qjvbt4jAc5EjUnqUbQ6k6n05TRW96/XIxaj2KEuiu11kXueE3Uuo3gYnrnTgIDc9ZMQC+ak1VhaxLar1nKnXm4rE8mWdd3FiqmqZpP54uL+kta/+8zeSa79m+JBFEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fVUtPsRo; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZNx5VGWIBPg8IIPYyioQJysjiuU/1XjCyee0EEKALRC/9Z6kR8G12iuk7QvSah8eRDyE9NggerzbJo6/yh9zVx/1fua22VNEpMgIzAcQ2e5pn2BJJ40e280MZHNKbOqgRKgguwMY7QZu3et2AXUbhrWFqTs/oEhQAs5G426odPzWAAYrHvXwmgzldhgkIDGJS9bBTBdrHTOD52irHvjNi7k2oUecmy+67/Lf3BxKcZgDU9pxFtO1nnB752Ef2GTym3YgNDgOWL39BS8UH7HMD723wKtaS5GEEU4HXnwNGK+cQm2FzrCaGxCSfB6W/fhwTGvUfCfhdmIb5hPSBCO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY2wo+iVd7X2YfLbQnLYsJPNyfgbmp0J8L7G48WNGrc=;
 b=asJq5Nqi6pqiFlpJN6lZs1j3VISS94A5E4e8K/XHjp4G1HYt82sSPkPUWteJXakbo27gAy6gj9X7vALolRTeVcH9OWzSf0bm3o1JQRYA0LgrcmsU+6h1+nP9YxGUF9zhJXIGjVghEotdPoUstzdHl1/yDpvLmXNqggpUzDwPKriCRVcKKKYIEkskPdoPHTdhq/pd5jpIwGeGO+a1wD4pxebcv9x+nxd2XltLBmLPqQdb3Vzu3U45BHSrB7tRm+SEhSOO94uS1ahxtP5k8xYvrO39sPY05vBa0C+3BrALv8XJLW0qsvIekN4+49cfGRqmxPspvoYTBmej4UKCwgzH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY2wo+iVd7X2YfLbQnLYsJPNyfgbmp0J8L7G48WNGrc=;
 b=fVUtPsRou8NuG2FCsc/op5QjLrMsl+YNfu7H6QJiYZBFyzo6XdQDxYc4SIxWd+FYxGT/rRwKUj5qVIn/W6mnNcSnSHhFnB0a+aRcqeI0YnhD0sxr6cLIC2gNEuG0enTgkUonb6y6og+2EJXXynpNPc7pmJPPvTNSrMKGpSminJuMPvKBMQEsAYSnMby6TA4XmJaENrqujfQp9iASKMcMhF/OxcfFtV78B3WNTEskcdcq0/hYMp/hFSdPDJmk40iWhduW3aw9a6iRBR6KXNGPZI2cffmPKUB3pneRZ/WYGmiyrITHMHyX7gX5mh2qZdfNtPJvWoBCfKDRS7VWYyFWrA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10588.eurprd04.prod.outlook.com (2603:10a6:150:21a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 01:49:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 01:49:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jay Vosburgh
	<jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Dimitris
 Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Ido
 Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ragnatech.se>, Edward
 Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>, Imre
 Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: RE: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
Thread-Topic: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Thread-Index: AQHa+iHm2od5qPvDs0+3x7m8IiY89LI/B8Jg
Date: Fri, 30 Aug 2024 01:49:04 +0000
Message-ID:
 <PAXPR04MB85108AB7A96BC3786B65283388972@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
In-Reply-To: <20240829144253.122215-3-gal@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10588:EE_
x-ms-office365-filtering-correlation-id: 1b4b8cfe-ef0c-4e5b-1e3a-08dcc895ee22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3I2gR6qlcE6fHu4AOlfoJOFfBDqgvn0EJ8mGnrgft1rOTgCHssQ7TKVo1E?=
 =?iso-8859-1?Q?I2SPtzZxIHzH/7fp4t0TSOuYHa2Rf4UVxwnMwdU943yrrJAbohhAjUJwVg?=
 =?iso-8859-1?Q?slwb+5LkQOFtqhDCrEOk3/mVCXgOs1MKqV9pJ0ZcD7mV/W4IxS14cyyYCK?=
 =?iso-8859-1?Q?sIQom9ex6aIQAfod07bhZ2Irz8obP4L078HnoQLxfyyzZwFNwLBert9ozh?=
 =?iso-8859-1?Q?7pDtf7rE1m6KAOUBagIe1H7+1omhxJnisPu14XWFaz6kkvAioLuTJ/dV8X?=
 =?iso-8859-1?Q?uN/p3JAotbHDi6VSRQdI6l4pMO6ZZ6wmUUPeBv6GqRS6bzDcERIFIa66sf?=
 =?iso-8859-1?Q?UoryGCWNPtLVrrvYexRzpffPjzQr1uPulnH0JA/w4D0UfSCOMJT8i5VEuE?=
 =?iso-8859-1?Q?216zb/eq7hlp5fs7H15YxfrKyHn6LzRS+3np6R+HfRxOWMxrK2Wi9sxqFL?=
 =?iso-8859-1?Q?pIu9YQLXoHLLpd7vFLU2eouCqxUIVIfQEZcB3+yvdPjVR5qDL5/UNT8raw?=
 =?iso-8859-1?Q?EMnfwryZJ74bCxnma6P2ut05A8Q73Gr5rPMZi+w0QhmG4qfRWnh0NfntK3?=
 =?iso-8859-1?Q?qfp2eMLrWNQ404RM0sbsbcvzxsB2bN5IQOmvxqqkiSyaO5vYE0eD46LIO3?=
 =?iso-8859-1?Q?+csHtSv0qhWZMsWhc1vUI0QZaGSPvKSfZTigZql3KkZvELvz6lgsAAA9Bh?=
 =?iso-8859-1?Q?OEfMTtqtLY0ciyQnX5nQ9+7mZT3+jHBI5wI7q20T78Fgco6HLfe2QBBO6W?=
 =?iso-8859-1?Q?q1xkcCPN499t9y3uhdYwn3VzAmgfUpidqobtIH+Q02K7W+wAYx9EbnmCgb?=
 =?iso-8859-1?Q?wE2wCxu3268FuLSZ6CGm1QGFHrsq3U5ogkqnEdT/vPA9c8K87maQSwBCn8?=
 =?iso-8859-1?Q?sIag10FDlok9FsY3dekYqeM9S42vF8dtF7y66txTnfpDQ12efGjVcbbhsG?=
 =?iso-8859-1?Q?m8w6ge4hcwbYZLey/5XHFzGzYFGKKxnqeFa/I2o3adIiLuYg2yLhsBdHLy?=
 =?iso-8859-1?Q?GO+2AuTg8Ufiswdk4ajumx1mIseGrvGrBhrsCjjl4FrMyxGytZelcmxyfL?=
 =?iso-8859-1?Q?gosnBIMlD+I4fdxh4yccIGgt0qLz3+uvVxGwep9TowEv6PUbWoNwhffupB?=
 =?iso-8859-1?Q?YHCskGPsXIddv6BCF3AKi2Md9UGW0Ip2wvgUCYkjyI8PEM0hBTNkGLCD53?=
 =?iso-8859-1?Q?YkWYX5501oMdXMtea1yozJSjaORE+6EDCJOHmozIR6ViNTkgjzhusb+hLN?=
 =?iso-8859-1?Q?doz/7Un4DVkqlNfiDpCrEvjZQPWw8qhqPhbObsVGwZ4qsBkAq6pW+Y5liB?=
 =?iso-8859-1?Q?rmwholkEScjYMRrH/SU7nenZ1rQ1prxwuf7GeaX4Kwl0c2RwfVhv2Jet8/?=
 =?iso-8859-1?Q?n35tEcFUjph2Fepxh9ET2YsH2G/RAtXJrm/0kiWclcjB2fBt8f4WayGJyb?=
 =?iso-8859-1?Q?9R4+y1n9JFltaLgmZEb501AhvnkFDo+kzI5jww=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SjkSlquIrf34zdpY+dpSRVQ2NhF1MGx8kPN7VWKoDSiL0pGkB90dZujR5n?=
 =?iso-8859-1?Q?OZztBdQ5pTRjz5j7AB4eMeUzlkciCGXdircWlpjQT3KWA1juAVxyUpVgQk?=
 =?iso-8859-1?Q?IGZ4bJxUUhHF4N1KKdreCrAo9iAvMABcsQSx2Bb+s/WBnJyZ9VtIlEwpgn?=
 =?iso-8859-1?Q?E4jlixlKNv9bqAIH1PDc4Z0ALurDNQ9S0G/Q2FyMYrno4LuHqWnw7AFe+v?=
 =?iso-8859-1?Q?aqh4ALqOLh2uOhanQGi0H09VvH5jAR7RuvJFc61i/bB3KbHPKDme2ttEmm?=
 =?iso-8859-1?Q?ot1LRNhqysN09/n+psd0vh6fGkeSGl9cMnG/XTs5rWrrWVNmMbR8Gx2UUQ?=
 =?iso-8859-1?Q?g3M0fwEsnPNSp73epdmx7VZD+lqaoUYhgoN8QFeypiQPsCDkhDQdnTYQnr?=
 =?iso-8859-1?Q?FkMsP+EBGIpiyVwmqL2hRkh5u7bAtBzG3TBHoyRWvU7d4BepDyvQDtTiKW?=
 =?iso-8859-1?Q?mwrdWOzgvz/U1Q6CkDjSWsEEnmLd2vN5GGixEJ8Ct/CkYaf99R5UgSiNdy?=
 =?iso-8859-1?Q?ratNZPHetdmNfESeCzblluDKvkYsEBbOKao92sXv31GUsdJpOH5cuFl15m?=
 =?iso-8859-1?Q?UP1T8j3E1DkLoIDjkGutwrnCGl4nKtArIvCsMOJZsxyRpB3BJRAuMKp4Wo?=
 =?iso-8859-1?Q?bh0t3JpR+PqBSBdWYpTkntKiumSf8CLcw75pVjzDE3gFqrL4fQRkx4GG54?=
 =?iso-8859-1?Q?w2Ars05STVSCqPKfsvNSRTqkGaDYO7C/4Y7A0VWKjUWP9mniDbf3yHEjbR?=
 =?iso-8859-1?Q?HqV3CtzJeEs7vue9End2MEKzxZtfcxfkr2cN2IHA/SMjT+ReCt+jFyDC7z?=
 =?iso-8859-1?Q?EbYun6QNuwgHFNkdBXdNcriEEq5a7kMFCDADeGNDHd05HkrWcxfz/EO4Ry?=
 =?iso-8859-1?Q?lZIHzB4nezAfzAVQzmPnNgCGslr72mCpu16EZh7lk4RZu6wbE4R/+WRNAI?=
 =?iso-8859-1?Q?RfLIhD94ki9ziotTqyh38RxbMXewvAEh3KpprY+yyvergi3vYrbNjMQVfe?=
 =?iso-8859-1?Q?WXrvQDYX5ADOxpL7ksldrwpGEQ9H+bWmoOEfg5b4x6hz8IgeLSKFSqbRVK?=
 =?iso-8859-1?Q?xoiU2JtRHhjx0zpUoRJFLZ8r2g4oRn6w3HZkNCq4OKH7S8vHpsikQ7IgaA?=
 =?iso-8859-1?Q?ZCBSG/fkIoIZkxG4Pvf8uAD9LgjZP26Y/VndyUL+24wpKYWW/Zn50xqjyS?=
 =?iso-8859-1?Q?8vHKZrJH+OnSwRd1+luLtpLODna0Ej9WmEaMU1UWEgs1Jd78tqAk4qTJKZ?=
 =?iso-8859-1?Q?8JmRsgJeKLoWRwDbbdQ09Z9Tj9TKg4NL0QWpWHxnyAc9Ul8FUC3dIBI+vC?=
 =?iso-8859-1?Q?AoT/NvmMgzGpOfBrxTtLF/jFi32caWEw+WigUtldskIjvjr5QXzj3oqGZ4?=
 =?iso-8859-1?Q?Geyz5iH1Dpzm5RSw5bjuAl0RJWJ+J5c62J6bqoJVhCPs6UK9ZjRd36yKa3?=
 =?iso-8859-1?Q?yDjej3eNJvJLY/NjERNyHAWUprJXQT7JZKMscyQOtf71ihTYmBdQWvQk2b?=
 =?iso-8859-1?Q?lifK+19lfXz02ePTqHPb3xR108ow+cwVSMOLNGS/hu86vd1NmZtlhjimdb?=
 =?iso-8859-1?Q?gtuAMxDp/4HhoUNPlYJLOLPrPgVZeTd/Tpq/oSt6Hv/Mrxz6a209ECwxjQ?=
 =?iso-8859-1?Q?gVZrfl06ebFW0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4b8cfe-ef0c-4e5b-1e3a-08dcc895ee22
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 01:49:05.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rifGs1KE0l1YABQR/OaPRlJlDue7Y9nJg12o+PgN0W0qlx7X0+QT5+P4y7zZyY2L4Nn6FHPGiOw6elZddVkhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10588

>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 10 ++--------
>  drivers/net/ethernet/freescale/fec_main.c     |  4 ----

Many thanks.
For drivers/net/ethernet/freescale/fec and enetc.
Reviewed-by: Wei Fang <wei.fang@nxp.com>

