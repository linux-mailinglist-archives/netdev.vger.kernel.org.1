Return-Path: <netdev+bounces-242803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B18C95005
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6ED11344A07
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332B283121;
	Sun, 30 Nov 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WA6YfNl5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C127FB1C
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508667; cv=fail; b=L6IDsow9ppBLucVLdU8Cbppfghoq/ltz5II0Lj8uEVNEYcQTfIxSusWMbD4LSFcPDbpkx0d5cwUvo+3dLvHMWwpl7E7494EjnU3nQXAATCHNZRaFOjD3TwIi9t7c21w+oJAB663O/iAerT1wgV+NLCK+gv7me8mG0gRbEHv/ASY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508667; c=relaxed/simple;
	bh=kB4wf5nEA9J4AgFA5hxyfpsFisuHtiqDw78Xgfvqn8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtBhI6jM4XyvdMRL/h7ygE7OlED/3iIUI0+7rhBqbmxN3//OO7H3gThuutVRdv8o0VJUx+SFD8LtFHyE1hRS1Wl4rbr1xYgpyTFS5XmtjsRCgTsIIW6rIReGsqy77gd4jSMEYNChlKRk15noXLfvoz/pKI3R/me6czabtri7f18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WA6YfNl5; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGCvMVfP08yzQDqOSjk1dDojM/n8THWeDSUeOOQOZGNc30gMmDZHa82a/7ctJOsWGpDB8jNraAP7E/aVvHualSl9dqEjO3BxqXvb4utYHsV3sttR2CMpF8gTGgzUg5423bnOVq34lCiwOt1ykzljz1VRapJI2eYPaUWuouJCPVsy2QkXHeBKeLNxapX5koN/FmuFidAuczWPJ/5IntWfGI1+PgtqTc3Q+2o4Twi4wE6D7eXstvoqV8qrPP7uDPiXI404XliR3iwm1OI7eCRsAe1bUCh1TySsD+MkF4XvdGFGKfc1EUvGfCdNHrDx27H8IFJRJf6Vr/Qoz7nNtt3R5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czplnunBU3LohCS1q+Jb6ixSa/7nHjEA7XIzIuYxJZA=;
 b=yzkiRhZ4rQ/RUZq9uf+1b01wFEoZIY9qghn3xV1ul8QOKdjuCNJfB65gTnkm1FE+yTSPyG9lyxV9NT9+tjm1/CLwAs7hQNUVRr2/5CS93wXsgjBXU7mmsykYr/JtqVFri2WVyY1gWwJwsJ1UapciT2/XkH8O1rcFWQcJDTuLpeSIQoxOEmY//EDF6RePlFz3NiHFvRpJMlJXjR2Y3aYxWcFttxGbnVhMyOTtmo3frWj7PDFDdKRcBdsoruj0RKq8IYm+9JEe13Ydvg/At7bnQ9xi9AiCJQEP+JpntRshdu0IodAuUrZ0R18oKf9ngJEKWJh8hovZYm6+KpmrE6AWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czplnunBU3LohCS1q+Jb6ixSa/7nHjEA7XIzIuYxJZA=;
 b=WA6YfNl5sN8kx1ApBU/HP+ZgcmVL/YPPsPR0jyvvB5ZZV12d4XLt+nYPQ7kyYycAyeAkS6MvziSOFHR1PUdQMOGtsCTREh1jrGf1yRBvaO5ZhD2uFPgGpzm3kO7JCz6aSI5D0cyq7qXYYgzSb6LhRrO6Pvx7+z3UKCYjH7/P1IDvGKbkliPEOiqeFL4zbBwddeXBPZy8Wswk+9AKJGxB1fYUpEX53wuVOBNkNcSt2RqOQ3HJIw7Vw76oemkP4A+r+A5osg35TIQJdPts4QjkNqxOHM/CfT9U72k/SOBFax9MMV1OAUAKXpeg6/KX8HKkWerT2AXUNYhwreWcISj1JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH net-next 08/15] net: dsa: realtek: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:50 +0200
Message-Id: <20251130131657.65080-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5a6e05-4020-48f7-d792-08de3012d414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djRUVXdKUWlNWHZsS2JacXAwTDhTcnVZR1UvTlJyN1Vob2Zvdm43K1hGUkdD?=
 =?utf-8?B?TDBJUDNTNG40MjdEVkp2TkRMWk82ZHlPSFB5SlBnckViREk3b1pDMkVLVEQ3?=
 =?utf-8?B?TkpJdzFZd1kxa3dxbEI5S0RZcnlRRnRTUXlDdWhZbUUrZC9pVXpIa2ZjcEd6?=
 =?utf-8?B?L1N2SGd1WThlWWVSaEw5RERYUUhUT2RvRTB6R04rWXJGNVZlQzYvR25ocnM4?=
 =?utf-8?B?d2pPdzcxcFFScTcxeDNNaGZqSzU5eTBYL2dtUW1vWmNZUXZXYzRMeVYxREVz?=
 =?utf-8?B?a2RUVUNZekdMUFVQUXp2VkFUb2d2L3NNMG9BU2hvMTZ1QUxMUi9VQlNsb1d0?=
 =?utf-8?B?cC9NMXVIbTR1ZXFLb1hIUzEzamRReWw5bXM3eEY5dEdNSHBrOTR4eC90VVlU?=
 =?utf-8?B?UFFiZFFDYWY1ZjErOCtvaHNJZ0cwSHlNTXJFcmJCYXo2Ui90bXpZT3NPNGxV?=
 =?utf-8?B?VXo5dHZtM2NyY3kxRUZjQ1UwM2NibHN3RmpVa3h5YlpRL2g4MlZUVXJmanZk?=
 =?utf-8?B?SFlpL1VJQ0pNU3FwYStMU2w3MlVFL3N3RkcxRHJONXVoUHNFa1lmMXk3UGxO?=
 =?utf-8?B?U1BVV1pja3phRVVnNytuSitwTWNuY1NId3pacGFBNG05cThGOHJQVkhGbENG?=
 =?utf-8?B?cVR5TFA0aURCUG95SlN5Wk1LWndtejVCNnRqYmFoZXJ4T0w3OWhneXVGZnlS?=
 =?utf-8?B?aW0yUlNnSGU3U3NUK3ZkVVcxUTNQVlRzUFRaYnpUamxGdzc2VUEvVnRmRy91?=
 =?utf-8?B?VFlhdTRacUR3VWFRcHU1TlNKaitwbVg5K0hhT01aZCtWa0ZtRFlPZVlmc1pT?=
 =?utf-8?B?NktFYTJabjM1VmxrczlpV0pxU0o2QWZMeEpEK0duNm9qWUFjYmVWWENSSDBu?=
 =?utf-8?B?b2tpbWFRNitTWmZxTEdsOXB4RThNNnZWb1RwUXpveklJM1hFdDVZS2d3M3Bj?=
 =?utf-8?B?QkQyczcvLzZsTUdJaFQyVkEwK1RaZlN4WVVZT1EwRFlhZkZLYXphUTRlVTFD?=
 =?utf-8?B?WWdsb0wvNUxOWS9pTExCZTB3RUJKdEdyMHE1WlRlZTRhTjJvVm10WVhlcnZ6?=
 =?utf-8?B?Z2VjZjh2V28remRoUkViYmY3cE4wdG1oTHI2UmtEaEQzRHhxU3RDOXg0RytR?=
 =?utf-8?B?UEV2MEZObC9KMXg4SjVPVjRsSHQzbWg5RTVXb0diWnJYQWlRTi83WElmRU5o?=
 =?utf-8?B?aTA5U2NQWGtqdUR4cDl5Y2EyQWdaWi8vMWEvNys3UFkyL2x0MGFwaXdTK1pR?=
 =?utf-8?B?UWROaWwvNzJHd2RPdDRtRjdwRmJtL3EzZUtFL1JxTmpKU1ZjZ0taQ2d5bTZh?=
 =?utf-8?B?UmpnR3dwU09uZUhIZUgyWnNXOTUwTXdOS2JLem5ockpzTTc2YStkcE5IbHpy?=
 =?utf-8?B?Ym5aWllNNmJVOE5wbitHTVJBQzFua0JYRVpaZ05MYXQ3dVB4UGc0cnA2WUV1?=
 =?utf-8?B?WU5MdU5FYmZwc2pwQkZBeVkxcVg4eU4vUXlkUEVTNWlPWUhBU0pPRUw2N0wz?=
 =?utf-8?B?NWl4K0hDSTRMajdmTURTU2xEdFBLUmVzVUZNUnYxemRiT0lneDBRUlR2VmV5?=
 =?utf-8?B?U1kzRUlWRXMzL1BZRXl5K3E5TnRIWmFOQnV5KzJGK21HbjZiU1RPa0hMcUJ5?=
 =?utf-8?B?RHEwY2krdnBGei9Ma0NidmpxYVVmc1RpdXViVnpwOWJnNCtWSHBmazFsMkp4?=
 =?utf-8?B?aEFlcFAyZkNRTy92UHdjL2NZRU1RcHllYmdIKy95eVBQUUNVVU9Sc1M2Qkd5?=
 =?utf-8?B?dmJ4Ry9VWDBmY1FGcmlaenJaTTliVHpIRjRvNDhIZkFPbFdlWmFlL2F5aDlK?=
 =?utf-8?B?YTNteDlqL3ZvNEt0am1XdVJ6cVRPUmg3ZDN5dXRMcnIwb2hKeDRaK3NFcGkv?=
 =?utf-8?B?S3VTVHJ0VThTWVBHZnZMMHZ2dURTUmpvZkpGNWdnTTkrUm5hRE5mZjJuNkNX?=
 =?utf-8?B?VUtDQ3hpNS90UDlRMGtiOW9wNVMwRjZNOFNmVXNEekU4R3dNR2ZsWmZWenAv?=
 =?utf-8?B?VStWZjJnK0hydjVtZkpRZzBsU2VBUk5pSzQvdng1bWVRcDJPK2pjUjJzNXVr?=
 =?utf-8?Q?hhqkXa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dRT2xzZjFQWm1aOXNXbFdmcTJySEYzV1k0S0ZVQXNuL0Y1RnZtS205NGsr?=
 =?utf-8?B?eUF5SzNhb2dzQXRVMHVOVjJIbEJDMlhEd0VpcmxjWXd3T1QvdFJLanBNZkpQ?=
 =?utf-8?B?ZkcwbVhzTk1jZGJuSDh4YnFaVzByaEg2eGpGN1Zxa0dKTCthUEFidXkwa3lE?=
 =?utf-8?B?TjJ6d040akF5WWRHZ2lRMUozVDRlbTF4YjZPdElIbnprc1U2R0hsdU9QSU5x?=
 =?utf-8?B?bXBSM0V3S1RDc3pRSlJGc2lUWmhXVkQ4bmozSVVSTTVlcXFZVSs5ejE5WnhS?=
 =?utf-8?B?MktnbCtrUkN0MS9OOVlmNlBaZE80MWJtOU5vdGo3dUNPNElVNHprMGU4Tm5Y?=
 =?utf-8?B?RzdRU1NReTFvTHYrRWxUb0YvOXF3YXNwWDdLNVdWWEF2QU1GOElObmFsaEpJ?=
 =?utf-8?B?NnQxZWxQMzFPTTQzS1cvWUEvdFl5a2gxaDUvNGZUNGYwbkVWdDJiQm1pSnN3?=
 =?utf-8?B?aHBrVlpOeUlkdWJaVkZuTXVicklJTnhGSlFnc0pDc2JaZzFpNkxMMFUxSWg1?=
 =?utf-8?B?L3JWR1JqeGZzdGtCSTBNS2pUbHdGcnVraWlBeFdXVENOYWhobVVkeFZ3UDRv?=
 =?utf-8?B?dGhuUVV1WXNvQkNVOSs2M1FhYnhHbzJIczNBa0xFMFpqdytWODVRNXNGRlNF?=
 =?utf-8?B?d1RaQ3g0bWZ1TVJNSkpvd1BKKzk5Y1Q3ZzI0aGVUaVNXUGoycHVnUWZyaERB?=
 =?utf-8?B?RUx3VFBWU1hkRFRMMGF2bGRNeDl0ait0ekdiSUg0czJIOHc5bVZKSEJqVTlG?=
 =?utf-8?B?blVzS1ZjY1pkaWREeFM4MVE4eThWcXBSZmJyVzJCTXhtMzllVzU4UWRTOUNq?=
 =?utf-8?B?OTBzNXNOWGFYeFlTcThVcWFnWmdmTFplbm9jNUk1bU5BK2hIZFBNYSszQ1Nm?=
 =?utf-8?B?SXEvMGQwd29DTEZVUFNCOEkrTlhJRW1hVkpLNGFrV1c1L0U1a3ZrZzZndCt5?=
 =?utf-8?B?eHp5UzE1OTd6RWtkbEVxV2VQOVQwUkZhc1dRY0QvaC9ZMkpZZ0hLWjI3Zk52?=
 =?utf-8?B?SDRnOHg0c1lLbHhDd1ZhL0pBenRuODV0V2wxOXBoUmltQkptRzI5eFdhalIr?=
 =?utf-8?B?WC9pc1ZTcmsrYVdHVnZidFR1NG1tZXB4ZE52Zko1MVFOaE92bzNTQ2FKY09T?=
 =?utf-8?B?cnhJR1R4SzlzdjZmSmhBa1hxb284YVdUb215NWwyeWFKZ1JjOEFOdUpGc1d6?=
 =?utf-8?B?TkRTRFJjdkVtNUpPZ2dwRFJGN05qRGJTaWpyeVRLMFlhTXZ3Wm1QeHhMMXov?=
 =?utf-8?B?YkE2c3VRdFN1c29PUHJIZEM2Q24yY1hoRVJ5ekpSQTRNaE1hRDUvbEFYcGZp?=
 =?utf-8?B?QndMd1lwZGVhSmx1T0grNWxjUnFUbzJWVmhYd1BCMnkzd0psRWtxaFBIZVZk?=
 =?utf-8?B?NFJ6MzBURkZ3dm1maUZaRWZaWFpUVTQ5TEd4b3ZFem9WQUNmekRIQXNKQmhR?=
 =?utf-8?B?ZE5rM3BHU1FBcnU3WG5BaktnU1BGYUIycnYzRlcwWGtKNlE3T01ZU2pNTFJp?=
 =?utf-8?B?Umt5ODZRQzd2R285cGI2dHdTYklaS0RHb29xK2dwSDR6dkcvTU5hWm81dTd3?=
 =?utf-8?B?aDd6cUxsZEladzdLcVZxZytTWVB4MTVqNkRBelFnTGNrNEpWelluRkdCWmh2?=
 =?utf-8?B?R3FOMHY1ZFFHY2x3cnorUkZBVlhTRmg3KzU4MUl2eDd1NEtTR0h0cVJ5Y28v?=
 =?utf-8?B?NFdpUGZHYTl0T0VoektRMTFpcXBDVUpPNjV1TlNDQURoWXU5VmFTeGZqYktK?=
 =?utf-8?B?ZEJta0MxdDJsNG9RVUhFdFRyUjZ1ZDlRUUxHUlFXOWNWeTRJblVWcDU5TFQ2?=
 =?utf-8?B?Nm9YaHJLMUxKU08rdEs4TVJ0Rms1dnp3a2x0VUg2QVNJU1pVVUpDQmtaOTRE?=
 =?utf-8?B?VHpTYzZmMW1KMDJpME12QVR5bEs1NllsR244SzcwTmozZDE4Yy80UlVLeXBp?=
 =?utf-8?B?ZFZCeFFNSVZmV2JrcFBYb2ZFZkVyQjVPV2swcVZUNGg1aXBNZW42RXcyMFFh?=
 =?utf-8?B?T016aU0xQXM3amZ3M0MzdTZPZy9rdWdWV0RhVmZsak1ZTWNZMDZZL1hnYWx5?=
 =?utf-8?B?Nm0xamJ4cXJlVVZ6NFBDOFUzVE1qL3RWaEJhblN4cWI0dmZPcUEwdCthbzYx?=
 =?utf-8?B?Vzd0cU5zdU1ySFJhbXEvNCtpYWVkbU9UR0w2cW44VmJtaVgwRXNKWGNuRCtW?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5a6e05-4020-48f7-d792-08de3012d414
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:36.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb36BE2RF4G0Y53WD+KjvWgFRPLRw1GxrnRkixq7qPT8qUezrLFvtSC+q58X7aTELiORK08/LQNEkeo3Sqc3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

All known Realtek protocols: "rtl4a", "rtl8_4" and "rtl8_4t" use
dsa_xmit_port_mask(), so they are compatible with accelerating TX packet
duplication for HSR rings.

Enable that feature by setting the port_hsr_join() and port_hsr_leave()
operations to the simple helpers provided by DSA.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 ++
 drivers/net/dsa/realtek/rtl8366rb.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 964a56ee16cc..c575e164368c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2134,6 +2134,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_stats64 = rtl8365mb_get_stats64,
 	.port_change_mtu = rtl8365mb_port_change_mtu,
 	.port_max_mtu = rtl8365mb_port_max_mtu,
+	.port_hsr_join = dsa_port_simple_hsr_join,
+	.port_hsr_leave = dsa_port_simple_hsr_leave,
 };
 
 static const struct realtek_ops rtl8365mb_ops = {
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 8bdb52b5fdcb..d96ae72b0a5c 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1815,6 +1815,8 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.port_fast_age = rtl8366rb_port_fast_age,
 	.port_change_mtu = rtl8366rb_change_mtu,
 	.port_max_mtu = rtl8366rb_max_mtu,
+	.port_hsr_join = dsa_port_simple_hsr_join,
+	.port_hsr_leave = dsa_port_simple_hsr_leave,
 };
 
 static const struct realtek_ops rtl8366rb_ops = {
-- 
2.34.1


