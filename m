Return-Path: <netdev+bounces-114288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B120942091
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A35D1F250E5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC918CBE4;
	Tue, 30 Jul 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMMbCpPm"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F18CBE2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367580; cv=fail; b=meqB+aEE4SJ+RnfDogy7Dyv+KVFWFaXjYxryXUSdo5YMvivRWTPEAUbn3Tv9Q6Ka54pewZc8PxHw5DV1wiEmP3Ax8/juF3E4fGm8EQnEXFL70Toj1ENeexdsJm2O7qqfmzNBLOYGUPNtz4RirH1J8y23UhkUptNCkDJykFC2zz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367580; c=relaxed/simple;
	bh=dNLU59pfYpAq1LPvtw45hGAZci4QS54huBo2gUMgWqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gOcLKIUe+FNseHLQHdFCgJSWWVY6NYgyCNcota+BgPCLsuFL7cyp8H7Xya1Vonzx8GwTf54GqFNPePfQX6tr2vNFIDiNTb3jNVE7K7J8kEEl+8YONR1/xwZ0IJAWWMK+BDuvy9BoaBZCpH6knISfVlIVHZBKiZUT53yNVFaPIOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMMbCpPm; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVFH5bM5CXeAw0+slNV4azw6fbOSdSUdndyPVjLIBw4eAvb1hH1GIxE0DYaaprvkvFsBrTF9czPWmqZpq0d7Im+J8pT6VE6f91c/rAFtsSqLWPg5o49ELvG6eAgU9dKRS6iwDrykEk8IwkCTvMcVTVZMS5hqsKDdBI7hC2RBjg6KJu421cuTI6F3a5rOEPuRGNb/3W1YmjtXtS0YMxeG6sAg1jHAmD/Fg4tXvEPc9tzzWBVZXgZi2ShBntZ06cc/FHDoUHrhoUg9+X8IVmRvZqcr3g+uhxpO/9fegbqGzos0XCgcw7ypyEOP5wYeSxUK4J8Hd83kxwTG3HTaFsVJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNLU59pfYpAq1LPvtw45hGAZci4QS54huBo2gUMgWqY=;
 b=aJwu7xp78nuLKr9y3y64+rRKimIemj2LgWbG+PfcU7+QJG2E3HE7nnmIo49Z0kH/L9/eFxxOiUjT/bd+WCnm6rou7Vy038tZfaZI8o0aml3RUHgPerMDKT4db8NrHTvL7QrZljMuiLifzwjbtpV3+KbuTGuzbXTUUaL2Hc5BbS+HfGPN6VkVUMP+YOJdE0t/1GWyDDA890v2hB0faQiCM4zV0VG4B4HHrDOmsjS79vV6FBWUhU2TqC0qE4SHXls5aDIg0ymGxF1OT9dYhZFNIz63M8a7qUA+DTp9BEZ1DJTiCy4CilZiDwHhc4H2MR1MbwWwukZ/12dbUbYz1th8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNLU59pfYpAq1LPvtw45hGAZci4QS54huBo2gUMgWqY=;
 b=KMMbCpPm6rhpnpGqmN+LSpwnFE3bQ94AxA9j3NhmvVrKMsLd0YjIe/iiMh0/ZzpXwUHImNn5+dQ5h3zC+CQwBkhp0twN2ovc4PQ9yNQeb1gLQ1JdCGztR4yYpcQ0zb1mNkMCXfjbhL+7LKWbAn+gSR4kUSQltDRP3hiPWLXwMkF+++C6dD19jqIr+bpZvKNLRq7NsKS1rTqgS5q6Ud4ca+Ke2uKP+aPkjlYfHp45lL7MQTKVpYSavGNRe6wbwPT1BuB6eUWGqajs1xv4qKMEi30+NAWYoI8S1C1l5RnrYfNF+mSJt44iZ0y1oGSKjRJd28gh8yZszeY73M4m/p9f0A==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Tue, 30 Jul
 2024 19:26:14 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 19:26:14 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Joe Damato <jdamato@fastly.com>, Wei
 Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next resent] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Thread-Topic: [PATCH v2 net-next resent] net: fec: Enable SOC specific
 rx-usecs coalescence default setting
Thread-Index: AQHa4rZXs5TqSZFnFEeZv7fuTzdmnA==
Date: Tue, 30 Jul 2024 19:26:14 +0000
Message-ID:
 <PAXPR04MB91853145F64799D130F3A7BB89B02@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240729193527.376077-1-shenwei.wang@nxp.com>
 <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
 <CAOMZO5A7BcFpMFQ_4wtQ5s8cVpUhCKMXScKkYvhq9gkrCQ3uEQ@mail.gmail.com>
In-Reply-To:
 <CAOMZO5A7BcFpMFQ_4wtQ5s8cVpUhCKMXScKkYvhq9gkrCQ3uEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB8765:EE_
x-ms-office365-filtering-correlation-id: 6a0aea3e-89d1-4eb8-2330-08dcb0cd7a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTd0U3V2RFc5U20zRU1wUmZob0JEcG04MDE4dDk1cVpxQ25jaEVpY3d6QzYx?=
 =?utf-8?B?SXJINHpWZUpqWHVjM2RIbXNaaTlsK2ZZWE9qS01tWG04dldHMy8xU1ZpU25L?=
 =?utf-8?B?UC9qU0JveDQ5cUhmTnVtVmE4RFQwbkhiS1JodFllb2ZOekRSdGZCVGtLUjZX?=
 =?utf-8?B?M0dQNGxOZzd2Z2UyWElOVktrclZ4S25MNlZWZGJEWWs1MUJRMWxrSENCK0FQ?=
 =?utf-8?B?NUdQQ2Q0YzhKTXp5NTRUc2ZiVGtnOEhBeVpsUll3bFJ5Lytla2R0SmRTSFhF?=
 =?utf-8?B?RE1hdnhhUVRWSjVPZE9rY05tMkozOUdwNUkxditUVFhNUDVkbUpJK1BHWjg3?=
 =?utf-8?B?Vkx1bTA3TEZrS1FsNkRHZE93UjRyZjZQSWppWW1pY0ppZVREalBuK3RoTFlk?=
 =?utf-8?B?QWExSjdHWUtBaWsxUlVidy9ZWkxjODdBUVgyVkR0YzJWSC91UmZhSEJBU25q?=
 =?utf-8?B?ZUwrcW81Z3A2YVc2NDRMV3BoeHVyT256cnJXVDRlayt6a3hxeEtwaEhaaCtx?=
 =?utf-8?B?MWdQa1B6c016RDlodTh3SDF4T21zbnBFaDBjNlRseFZEdDhZbWN5SWNqdGlP?=
 =?utf-8?B?K3Y2RllJV3A0S0V3R0VWS0lCSk93bFZjbGJYcWsyeUlWTFdJdld4aWdxdkxE?=
 =?utf-8?B?Si9PZkRPM0t4WU1kWlRJY1F3ZjUwcXMwWk5mVU9tdjU2VXpJRGYxOS84d3ZB?=
 =?utf-8?B?aFZLbFpNcjdnbUhEUFBTSEJhZnRxdFNqZnhJQURVSWFkbC9TTmtmVFpVRFI2?=
 =?utf-8?B?VHZVSys3UmVlbXptVzJRTFZYWE00L2pDRzJuMEVNaE1TSDdxRFF5Y0lhU3cv?=
 =?utf-8?B?OVB3Q1lQckQyUDQzcmhXNVpHc0QvaVFTbS9OdWFmUXZrU3RWODA2VVNOblVK?=
 =?utf-8?B?R0c2R0hraFkyVEpLY0dwNE1jOGxOWGVDK1U0VjkzYzc4TmduVmlCd1dPZ0wz?=
 =?utf-8?B?Mk1VMzhUNVQxenBuN3p2bGFueUkxYXQ0cHpxV0QxNTdFUmFvSUFBNWo3WW9x?=
 =?utf-8?B?eFlpTFBFVi9ObnBzaHFybVBVUEdCRzFjL3lVNU5YdWhneE9lMmlzZnFVaFo3?=
 =?utf-8?B?eFAreEZmYmkwaUdkSk0vMjZzVmJScVo2M0NGWjNCS2RtQlZKL3JBTlVieTla?=
 =?utf-8?B?U3k2RDVBMzN4SXlOYzBFMkpRS0lraUpZZVBQUGJja3hRT3kraG5XbUtCMGxr?=
 =?utf-8?B?OEpzZTg3d0lick52VE9RN0l5ejZRREU5TUtKUi9tSWl1aDFKZlMrcGx5MEt0?=
 =?utf-8?B?SGVnSG8vc1FJYkR0amt0L0h3VkRTQU5tL1pZNU9rNGFqekIyVW5OWlpHY3Nv?=
 =?utf-8?B?TUpuYlVVV284MURnejQxRkNVUUN6d3JmQWZ5eDhMaXUwMXBaWlBWU2V0NmZ5?=
 =?utf-8?B?NzZNM29TdUozZURsUnlyZ1ZWS3JnQW9ON2tRRFRQcjFrTyt3aHA0dEtBVUlx?=
 =?utf-8?B?ZTFJYkwwS2lBc0lFVzlHOEF1YkRDU1hkUVNncExqQndyUUpveGZjNTd1R3Fk?=
 =?utf-8?B?bWxrb2hUeEpjdHBHMVhYREpSY1JaeEVIM2M3WUU0Q2VMcVVad2pWZzJGTi84?=
 =?utf-8?B?aU5MMFlMTm1veG5mNXpBYm9tTTRac2tOYVZ1eGJkeFE2M3N3c00vSy9DVXda?=
 =?utf-8?B?NmFuNldObDc1VlI4SjlsRC8xWHFpTVEvcXB1Y3liTHR2T2JEWkpnWVJCbXR0?=
 =?utf-8?B?QU56ZkIzMEIyS3AwYllDSEFFSDZuQy9JaC9iTXNuNE5GSDBJa0lVV2h6YWdm?=
 =?utf-8?B?bDN3WmhTNjI3UkVLTmY1bFFKa20xK0hRY2Ixa1dNcTBySGJkTENnamx6VGV1?=
 =?utf-8?B?VUh0Qkg3eGg2TmRnY2RyQmFzS3drWlBjTUhSRHZxekx6aXhQRW9Md0M0aE04?=
 =?utf-8?B?WGsrRDlaeUYyS0dnNTJISHl3SWg5OHBLZ0Evd0lLV1BMdWN3K3haWEtzaldx?=
 =?utf-8?Q?Hv7elSvnYUU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzNmbDZONjVhRGNCS3E3emJCRWlFaGxvTExOSzhFS0tnLy9lcWNhTGprMytL?=
 =?utf-8?B?Zi80ekxBNXRsTURWS0t3L01ZWmhoWHBWcDMrRUJQU3ZMRmZGalRGcHlDbndK?=
 =?utf-8?B?akdSanJ6a1FEK2ZxSExSbHpWSUtDTkpXNmM4NEovQUFrUDhmbEhTZEhIT1Zl?=
 =?utf-8?B?cFdHdk40bmF3Uy82V2hkNHBKNGZYMUNKQ3BvOXR4NjRTVXRTdUFoYktidXBB?=
 =?utf-8?B?WTJQWHkxVEZ1WkxKeEp4SW45eUlpU2VQbjNEYi8weWRhMlFoNUFsTmNQUzJH?=
 =?utf-8?B?U3FQeWUzcElDZlcxZWs3c0YzdWRXbVJHeDJEWXNWdmpSRE5NaUhLNmhGYm1v?=
 =?utf-8?B?RlNETlFQMmxXM2F4aWhxUmp3dk1Qb1JxY3RDUFAyTmZOVms3em5DNDRXeWpJ?=
 =?utf-8?B?QVMzWHBTMU5IMHIvRDIrLzExTEpJNGtPTDlROVVXeGYwNzRqOTJKNThzS1pm?=
 =?utf-8?B?Zkg3ZXpIVDQwdlNPUnE1bWEydGhSeldDOUtQM2VKZGFlYXN6UjhaenlnZDJ5?=
 =?utf-8?B?R2Y0SWhwN2JiMkl1Z2hjQzBmZmdRRVBBVEptVllwS3AvcnZTYStmYk9nYmtK?=
 =?utf-8?B?NHN1Q0FzcGI3L0gxQzFJaGJaczhyL2xUdTdyOENqNjRyRGhHdGpMY2ZyUjBt?=
 =?utf-8?B?bVhCZkVVcklxbnJQaUtaSi9hY0JxTi9ONzRhRlpYbnZtRmU0VXhGbTl5Z0Iz?=
 =?utf-8?B?ZzJUTG5nQ2Zta3NCWGdyY1g4c3BzemM5aXVSRzlaTnpaeGcxMFlVVk93Zjkv?=
 =?utf-8?B?RXF6cC93SVdMVG1RRDBmNjB0bVJIZWoyN2JXeDNLTEFHcTB2UEVnUnpQdUo4?=
 =?utf-8?B?MlBrb0p5bXpyVHgvSDZIMFdGNWp5Z0hGTTgvUkNLejBLZllVRzhrWmRVQ04z?=
 =?utf-8?B?Q0g4U01lVW9ZSSs3RDFsSmNYcWpKcDFYbnhBU3B6b25SVEYwRVZZRmtBV203?=
 =?utf-8?B?eUJEVFBmaENKMExKbkZQVldoQVU5ZzhYOFovbmFtd3ArZm8yYThJMkxZd2tp?=
 =?utf-8?B?NjRQbUZjOVhJYkVEKzFWSjk0aXBPOHJyK3Rlajl2TVRmVHRjREFFclpvcys5?=
 =?utf-8?B?UFZXYkRqaW5UN0dtYXQraXArOFdVR1ZjSE1ESkp3UGtRWHhCc01GSjlRbEpN?=
 =?utf-8?B?TEl6YkxzWG1oY1F2dWt1SEF3Z1JhalBTUUdkaFFVVDYrbGdlcjFrTVQ2ODNX?=
 =?utf-8?B?dlFtK2VWOGUwSWxQN3hwMzdKTmpWREZVTmo0VkpnU1VUZUZhd0dYU0ZucmY1?=
 =?utf-8?B?cDFIbEJraExXRmV4Z0FFTVNXUkhyWmNtYlJLQ0dTVTk2cGVDL2NRN2ZheitC?=
 =?utf-8?B?ajNTVHk5M2F4dmcwNFNrVkdOMkYyUWJ4ajdmVXM5WmZWN3p3WkRNMHBPMFdJ?=
 =?utf-8?B?VHlHSEdzQXZOS2VMR2k5N1kybHZUUEZPb1J0VUVMRFVZdzQ5T3NBU2xVWEpC?=
 =?utf-8?B?OWFsdnJGYkZ3R0JvaFVKdmtoWmpUd284cnFIR0NwVVZiSVJzSXdIdE9Xa1Ez?=
 =?utf-8?B?UFliRjMvZGxJbjBYdEtyL28zYmtYNFdBTkxpdmovVWc2bVJIL1ZIYkxodHpo?=
 =?utf-8?B?QTNJZHJKSGljVDV5SW1Pejh0NEpuRXNVNy9YQml2RWdyWWp2QzQvMThVMlhQ?=
 =?utf-8?B?YWJYdE0xaHNpY040N04yN3JZZmxGQWFGWU9VYjUxZVdCS0ZmVmJDZmd1czVr?=
 =?utf-8?B?WEdNZVpsNm8rc3hzQm9pazNmT2EzQ1JPanVzTVBETXlPRzArazhrakJBMHM4?=
 =?utf-8?B?ZWFlWXdpRkZMZC9Za0YvTk9DZWEvZHg1RTBvOStOU1ZFT3k5SEY0Rmk2RE1N?=
 =?utf-8?B?Z3dhdnM4S0tVYWQveVhkaW4xeVVWOVd5V095clI3bERDUXFBMm03SXNsRFAz?=
 =?utf-8?B?U1gzZmVsbWs5OFpKQ0MzZ2wzYiszSjI1VnpUYzc4NVEyZjQycmRRZHlBMlBq?=
 =?utf-8?B?YnF1RXRqV2hoQmRjUG4yUytxemxHVk9USHZZN2J6a1FGSmprV2ZQTHZxTUJB?=
 =?utf-8?B?bkFqK01yQ1VqVGd2QVQweHU3NExlQ0dFUkNzVXNEaVV4VENickV3ckFjaEFZ?=
 =?utf-8?B?ZStZaGJwcGxkcDFqdk94ZXpWVnVYUHFyYkM0aDBTNWJTNkY2NjdqR01xdzN5?=
 =?utf-8?Q?8Ta8GKxRylFs/wUo0Lkv/j1oo?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0aea3e-89d1-4eb8-2330-08dcb0cd7a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 19:26:14.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acFaR2icBs8SIaU0qxjwAuX71k+M7knPnJiIMPFg0rZMWNAaGMfMFbhkEPVDkML5KEVwat3jtP7EpgmCCz47fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDI0IDk6MjUg
QU0NCj4gVG86IEpvZSBEYW1hdG8gPGpkYW1hdG9AZmFzdGx5LmNvbT47IFNoZW53ZWkgV2FuZw0K
PiA8c2hlbndlaS53YW5nQG54cC5jb20+OyBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IERh
dmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1
bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBDbGFyayBXYW5nDQo+IDx4aWFvbmluZy53
YW5nQG54cC5jb20+OyBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBkbC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gQ2M6IEFuZHJldyBMdW5u
IDxhbmRyZXdAbHVubi5jaD4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiBuZXQtbmV4
dCByZXNlbnRdIG5ldDogZmVjOiBFbmFibGUgU09DIHNwZWNpZmljIHJ4LQ0KPiB1c2VjcyBjb2Fs
ZXNjZW5jZSBkZWZhdWx0IHNldHRpbmcNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJu
YWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVu
aW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcg
dGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gVHVlLCBKdWwg
MzAsIDIwMjQgYXQgNzoxN+KAr0FNIEpvZSBEYW1hdG8gPGpkYW1hdG9AZmFzdGx5LmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IEknbSBub3Qgc3VyZSB0aGlzIHNob3J0IHBhcmFncmFwaCBhZGRyZXNzZXMg
QW5kcmV3J3MgY29tbWVudDoNCj4gPg0KPiA+ICAgSGF2ZSB5b3UgYmVuY2htYXJrZWQgQ1BVIHVz
YWdlIHdpdGggdGhpcyBwYXRjaCwgZm9yIGEgcmFuZ2Ugb2YgdHJhZmZpYw0KPiA+ICAgYmFuZHdp
ZHRocyBhbmQgYnVyc3QgcGF0dGVybnMuIEhvdyBkb2VzIGl0IGRpZmZlcj8NCj4gPg0KPiA+IE1h
eWJlIHlvdSBjb3VsZCBwcm92aWRlIG1vcmUgZGV0YWlscyBvZiB0aGUgaXBlcmYgdGVzdHMgeW91
IHJhbj8gSXQNCj4gPiBzZWVtcyBvZGQgdGhhdCBDUFUgdXNhZ2UgaXMgdW5jaGFuZ2VkLg0KPiA+
DQo+ID4gSWYgdGhlIHN5c3RlbSBpcyBtb3JlIHJlYWN0aXZlIChkdWUgdG8gbG93ZXIgY29hbGVz
Y2Ugc2V0dGluZ3MgYW5kDQo+ID4gSVJRcyBmaXJpbmcgbW9yZSBvZnRlbiksIHlvdSdkIGV4cGVj
dCBDUFUgdXNhZ2UgdG8gaW5jcmVhc2UsIHdvdWxkbid0DQo+ID4geW91Pw0KPiANCj4gW0FkZGVk
IEFuZHJldyBvbiBDY10NCj4gDQo+IFNoZW53ZWksDQo+IA0KPiBJZiBzb21lb25lIGNvbW1lbnRz
IG9uIGEgcHJldmlvdXMgdmVyc2lvbiBvZiB0aGUgcGF0aCwgaXQgaXMgZ29vZCBwcmFjdGljZSB0
bw0KPiBjb3B5IHRoZSBwZXJzb24gb24gc3Vic2VxdWVudCB2ZXJzaW9ucy4NCg0KSGkgRmFiaW8s
DQoNClRoYW5rIHlvdSEgDQpJIHdhc24ndCBhd2FyZSB0aGF0IGhlIGlzbid0IGluY2x1ZGVkIGlu
IHRoZSBtYWludGFpbmVyIGxpc3QgZ2VuZXJhdGVkIGJ5IGdldF9tYWludGFpbmVyLnBsLg0KDQpU
aGFua3MsDQpTaGVud2VpDQo=

