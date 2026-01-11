Return-Path: <netdev+bounces-248782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F48D0E7B2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBF8300DA73
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0332F762;
	Sun, 11 Jan 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O3C8fi2c"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CB22D7A5;
	Sun, 11 Jan 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124463; cv=fail; b=NSr7bsDrrhzaOKpTRHseC98e9J8hHOT6Tor/cB25yDSbTjINK9MUpYOD78Oaz3EAcymS8PQTvlj38v+G1acaD0hCp8PcSCQK288M+LHzUibPIyfxuC2kK2JzORD669GLYsxqso6IfwJZHpQuLGi7CkT4i5lTKAbJDOsWi48npt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124463; c=relaxed/simple;
	bh=v45Lk1KgB3oTVbUnA0k4kTE3jsacmATmhzw3juwDLlw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rqKuC+CwrQDYX7nD2SJNCkdj2aYhupDix0v/I4pVqtLRMdlK41oGW137tnuVjFqK+oJvNT8WTyXtEuPM7BKtwVRlQMc4jkslyzuyh4yh6YpFK1A+3lHCYX4iuvyFxLE3qS3ici0PGvI4clUE2zXffH5lNRh+W0K+q0aabOUlUNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O3C8fi2c; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p16TNwAwyZFxhPwL3G/cNhuNUH+NSIK8mvmpfPnhwax1081/ZIFgcpsXRveGC/JC8nevhPD3py1tf1NvBVWPoGhzSl4cTYsLvYyQtTq6LR7j8zCrqmlJwmxlD27Kcib7TRZHuCxd6BBmfehYkBOIQRdNRc1ulNxc83msuzPJYWAEIP8M5ckZSjBxKcfgBSsNNDl7ZzRDkVlur4j2C1EwJQH/XFnTI8GxrfcPRCsVx+xJFHeLJZUD4kgTMuEjPfN67HpVu2FnnnrQzw0yWo32dUw0NXAf4I0qvMtD8OjZNHwhjCG4+Jop32oykmAx/VHgyC+1Vvj68nupLgJ4WwcvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4o9gSkgOunKMDJFb9r3wwQ2CvKMxPMmnff10MVG+mA=;
 b=TLPUsaOQxigSbvNM5a1rsVF6uLboNC/f/NlClkha0xQowjEb0mMMUgLsxi6x8/WTXxBsM22qWH1nuXDayDfKia2UC+ec+it45PpY4Bw2GWGwuAczN+TDVvZSOSmJYCUy+iWwmncKpmsfFnXsAf05YArXHbXIzeNk8sLKJG69dvy1J66HZ1j5+/BoD/Lre8v45OlFcxqhz6YRZTaXbKiEyBSOTndDWVA8b/+DHUNF9Bw43qhUG4j26gQEuC/CKkg3Fmcx+Lmsk5tk/i/vZDYAS89XZibLb1GBnq1XY7vyd3fvMdqQ2CdGu/90RD1Us6jXBIf7BA9f3n9q1DX/cCxuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4o9gSkgOunKMDJFb9r3wwQ2CvKMxPMmnff10MVG+mA=;
 b=O3C8fi2cIxd4waZ9v8bgBF2cB7yUedg0i++tunghp5Gtlk2grlTFOdEKVYKasNhGeXxcUtvK98pzg28frLgYYcEcA9fJfbBt0yXFijMgRPWxAcdOa2Hg02PpNAoKKSJrRRVHFL07QQDOCf7aTh1Y+M4B6gGqhuh043+oOrTwYLM6C/86CuQ//BZGDm8mZkww0QpN2IjuXSRRPByhpJF23X6qafJhdBwASzfj/7tjwXpd1VSj/p/hSVovGMMzdnJlywBWLd2bVp8MCmoakD50wcTRDAF6Fii8fAlKNwCBb/m1FG37RY1MBHX7uCCsApHAqUT5EmRcDIRYjy+vAwxNwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:40:57 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:40:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 00/10] PHY polarity inversion via generic device tree properties
Date: Sun, 11 Jan 2026 11:39:29 +0200
Message-ID: <20260111093940.975359-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da201d9-9f15-40e0-e43f-08de50f585ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1dQdm1aNnFXUGcrUlg5Qmx3anQ3OWdpM1pYRkppSlRmWTBxRW1pdEp2RVRC?=
 =?utf-8?B?d0JxajRySng0dHMzL2lVMmZOeDQzaFFLSHQyWmpkL3F5Q1JMR0hsU2hvZkp0?=
 =?utf-8?B?bkZWUjRSL205RjRlejlHRXp3cmpwekJPVUEwcERmd1lPbUZuemdIejZBa1dw?=
 =?utf-8?B?WGJLL3FlSkxoMzY1cmFJb25LQUdKOG1acFh1Mm5aWWRIV1FhVkk2cGZVQmpQ?=
 =?utf-8?B?ZVRoYUF1blE1Z3I3NW8rV1EvK2h5YTF1SHpmbmNOYmxiRldMN0VrSTBGeUVJ?=
 =?utf-8?B?V2RhR2dxcVBzMEZWMXpFRDR5WlpIR1VBVStQUytzZkpEVXdLaDJsSXZSQWhy?=
 =?utf-8?B?cFJSb0d0cHp2RUQzSEwxdkYvait5aGNTMDE2STFsR1lES2I0S1IrbG1PUnlD?=
 =?utf-8?B?QW9sd28wSG9ybUxPbFo5Vm5VbGdYczBoM2t2bUdpZk8wZGF3bEpWbitxbDd2?=
 =?utf-8?B?VWpKbCt5TWE1TGUyUkplOVdCVmpyWHpUbi9rdDRHM09MZUMwcG1OWGUxNGlI?=
 =?utf-8?B?RGwyQ1g0L3UyRTRXUmk5Zmp4T3ZwczRFdGhLRTNtanV4N2QxOS9WajlSOEtQ?=
 =?utf-8?B?QjNpK3g4TUFpYlgwSlJ0NkFhQmI0STh1Y0QydnlXZlk1dm9TTjhBQmkvMUIw?=
 =?utf-8?B?REN5QlBUblhNNXVlYjFRTEpkcG1YMzhkZ0RvMkZSOTVyOTcxZHZhVHF2WGI2?=
 =?utf-8?B?ZVdWU3VDNzU4V2tTRlRmY2tUSitKLy9icjdBemw3Z0EwSk9BQVlBemRpWXFE?=
 =?utf-8?B?Y2QrdnhPekZVUHNLc0h1dzBHc0tPcmhRMmJvSFpydzQ2eEFyZW1ZVTUvY2Vk?=
 =?utf-8?B?UHJoTTBRMWNUNUhEWHBSYmlvaEpFSHhDRm01UlRsOTFaK1lNU0ZUTEhRSzYx?=
 =?utf-8?B?OHBnMTZ3enNlNXlTSmVMOTUxNUl3WFE5M3BsQW1acjFZcng1Qnh2RFRDMlpM?=
 =?utf-8?B?aVJ4MkZZclFiYklGc0MrWEErd0ZudjVHOGR2UDZ3amVJTHI2ZWFnZ3FtM2c1?=
 =?utf-8?B?WUlQUnRwb2g4aU5QdDNXcDlGKzgraGwzS3VPL3R0T1JSQ09kdDdPOVRLQzdD?=
 =?utf-8?B?c3hmZXQrNExLZTFIQjAxZGMwSFlmM0RBRlpLU0RjSWFkalI4VGhFM09Ld1Zz?=
 =?utf-8?B?U1hLd3VKMVFSOTJ2TkJtZFJBQWl4WEpjSTBKK0crN1hadzlvNTNPcVJ0a3pT?=
 =?utf-8?B?RVAwMVhtSFlwMTI5dkZGRDdaVlUyTUF3dnpQZVpKcS9NWk00SzJHVUhqRGR1?=
 =?utf-8?B?Wk1jd0VINGtvbFdrczkxTFpLQmxMZkxOc1lhR3dhVVJHZmcycDdTNDFqeDZU?=
 =?utf-8?B?Z25yS1dmYnV0SlN3T3JoK2s3Z3YwdUNPcS9raDBWTGRObjM4Rnk4SGQ4M01r?=
 =?utf-8?B?LzdPYk9xSzQ5RVViM2lZelFMbmFNSDdJaW9ydktGOGdYcHkyK1FwRVZMSjly?=
 =?utf-8?B?cHkvSm44dk4rSU00U1BLbUUvUjZhc0ZpbzgwUmxPOTJyL09FVS9UaDNhdUR3?=
 =?utf-8?B?V2NyUXlJYkVYOTltLzVObjRkNUtqR2lTaDBQcENoZmF4WnBlaDJHOVgvdnVo?=
 =?utf-8?B?R0VDZFcwVHlmeStubHY3c2VyT3kzVkxGLytNKy9CcnZYaGtoZkd1MktiWWJr?=
 =?utf-8?B?OVRqWDFVbkVPY08rSWdncUlZdjVKckN6QXo3R3ZiMXJwU0V5MXlnZjdHYWZ3?=
 =?utf-8?B?Vi9wcWtvalB6bUFsL2IxNnRPdFBDRldZTEZXY1hTV1BNbXJveEpFbUg1ODU2?=
 =?utf-8?B?a1dhOUc5eHNOUlhLY3hXT1JDczd4Q0xqVFZFS3dDcjFlSVNEY0JGaEltUHNO?=
 =?utf-8?B?U3U5c0tQM2tyN3I5L1h4aXZ2QkVEaTRiYm9pcUpIYlVhclVGSVZyRUtySGpa?=
 =?utf-8?B?NG9XVWZENXptakJYbDBIdjlMSWNOMkxubWpINWdVUmFZdTlVbnZ2U3dOWmZn?=
 =?utf-8?B?Z3FWWEg0VWlWajY3OE1BV0VwTlovdGVqd09mT1Z2YVlvVVVjSUdKajNwK0hq?=
 =?utf-8?B?V3IwUURGcFhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tlp0cEFjWE5ZVlJhZ2FyMEdHWVJNZHByckd4emZ4VXFGUHJtMzRvOFhPTkFG?=
 =?utf-8?B?UDcrUFpUaTczV1l3NWk2WU5BQVhwSmdRM0Fpbys2d3RIUEtRQmVnWGQxeE9U?=
 =?utf-8?B?QTRzM3I5aFZhSWhrSmdlK25QUXZHWEtJMHh1Y2U1UWdSMmE0amJxMm53S2FO?=
 =?utf-8?B?dFlnSmxSUktyN0tJWlBlRjJHdytzZFprMzVsa0Nzdy9yLzJ3RG9kRmhmbGFY?=
 =?utf-8?B?Q1BQNFNyeFBkSUl0VjJLd096Um45MjlvMHM5MDB3bTdsZzJieHV4VWdHVENX?=
 =?utf-8?B?R3FMNG4rUUNCOGVmUm9Ob1pObHYrdzV6Zm5MMzFwQkJHWjF4R0w3aldDb3Nk?=
 =?utf-8?B?aXJnVHZ5QVNIbGxrall4MEl1UWJqNE1UZk5WeWZIQUlwVEVSU3RUY2ZWK2o1?=
 =?utf-8?B?aG9lY0s5TEJtaGRmN0JhZ0tTcVdqSGowMWdHN3RyQ3RPZ1FXcTg1ZkZqODlv?=
 =?utf-8?B?bzJLVngrN2VKeVN6L1NNdkZqeEkzTzhwbVdDWkhmdXhuOUpLVDRWZ2lRWkNI?=
 =?utf-8?B?eTBxamRKWnlPWG44WEtZNTlZcmVlSUY4dWFsWHZNR3k4cHlQdXc0Q3NTaGZq?=
 =?utf-8?B?NXFWckxZTysybUlvRmtHdTZ2RVZBdGthdllURFJZRkZaUmtVUWhBMzRicGw3?=
 =?utf-8?B?ZFlEUjRTYk9jbkpqSDZsR2RGTXhodkFCb0NCY3czOWI0eWZLai9rUWswMWFp?=
 =?utf-8?B?YlR3dnBST1lnTjcvZVVSYTNjb3hXTlhWbXFuSXUyVDNrTHJZSkpBRU54clhw?=
 =?utf-8?B?a1VQNDc4cTduWVZJTTZ0WCtoblNub003TDJHVlc1NHpRU2txUHBMUzdqTzY1?=
 =?utf-8?B?WGhOaHBKbTVTM3dxY0cyMmVHdmgwSGRiWVJxbDR5clhHRUZNRVhlaG1BbVln?=
 =?utf-8?B?Z0FPdXVnN2RCR25OaUhhT2pXZ2V2SmZyUStHUVVXbVlMSzUyK29HTU1BUkJj?=
 =?utf-8?B?cWxSVHNFQ3hORHBQWmFiN2VmQ2k0UVZIaTg2ZEtrR1lGWEZGK0FXNHhiaUt3?=
 =?utf-8?B?K1BlM21rNUxJUTJ0WjlRZ2N3VHZTWlVSa0JYbTNMejhZV2hVcEZWdUNJOC9I?=
 =?utf-8?B?Zkl5ZDkwTzd6QkNqbmxLZVJUb1JGODhSVkUwa2l0MzVSNTQyamJwdXBlWGRH?=
 =?utf-8?B?Mnh6K2lKUUd0b3ZtRFEvb2IzVm1qK0Fudm1TMmV0K0NFdnVRUVdOY2poMStF?=
 =?utf-8?B?ZjU2OUpOZGJNaHJIWlBMUDFBa0NJc3daUzNpeTgwTHBkR3lkbkZ0emxqWGZY?=
 =?utf-8?B?VW0vOS9BMUM5ZWk1QkJnMThQOXBySHZraVgzYWU2MWdXc29vZkR3MHl2VU5X?=
 =?utf-8?B?ZGZGZTQzOGY5MjNRVExqa1B4NEpMblRRZ1RtT2NraXU2a3BYc0xSbUd1MUhZ?=
 =?utf-8?B?dmhZYlJ4S3VIQ3NKNXM5d2I2ZHljVW9mcnBFUkl4QjRhT05jWmhIdWZpeXRU?=
 =?utf-8?B?YndXWFlPSU5sRHVRcGdhSG51eURqcmw3MDhrekdaS1p5ZDJOYkNVOU1JYjRu?=
 =?utf-8?B?V2ZyTDEwYmppVzMxNTBGN1dMbHZjSVdkK25obHM2VlFHdDZmY1ZYS1NGODl0?=
 =?utf-8?B?bFYya2NlNUhrWllxT0F1d3U4QXNOaWVKMkJaVkNNZk94TEJjaEZkdFZwblp3?=
 =?utf-8?B?ZEQ4T0dLNllTczJXQlRVUUZScmEvRlJ1aFFkTXQzdC9FYk1odnBIMXdkdjZx?=
 =?utf-8?B?QmswZ2VueDhGUXBRNUsrL1lMNlp0SVNKWmVvZzFjNDZrZ09PQVcyUGV2dms2?=
 =?utf-8?B?Zk5ROUNzL2tFVktVWVlqY2c4L0ZHN01JcWlqY0NSSnRacGlrTWdQVFVZektz?=
 =?utf-8?B?M0NONGtHK21OemMxWklOVk1LbkpGZXh2RDVKL1VxY25TT083MXg1TGYwa0VK?=
 =?utf-8?B?VjFNekRNT09oRGRLL0VBY2FyOHo2dm9YbVlLZFRBWjEra3pVSFR3aDVTbVEr?=
 =?utf-8?B?ZnZjckx4VEdzOUFJZjlHTzdmRUxqc2FjVXd4b3pMNkpqelBCcVFJSjJvRWlt?=
 =?utf-8?B?T0dpWlp4aDY1ZFlsWjB0Z2FiTDlpM0pFcEVXTVd6K3VYaEcyMGFzV1RRYUJs?=
 =?utf-8?B?OVdrQVNtOThnVkdUNnVvb2FJSVJFMnlGN2hPK1ZBMXNyQno1VlBsdXUraHhs?=
 =?utf-8?B?T2NMckhkZ1hnMDBPakpYRHM3dEk3OXdNNHVJZXhxdEc5MnZUTWM3UkkrdXY5?=
 =?utf-8?B?QmkrYXJER1ZkODY3RVczSnU5S0phL1k1bFBkWkpUQ25TbDRDTGZqQ2ZKNWty?=
 =?utf-8?B?VHRtbXBFNWk5TE5Obkw4Ynh2eGI0eE1ob2tRNXMyL2JqVXlPOVp3VVNxc05v?=
 =?utf-8?B?QXAwQy93OWwzcHR1aDJwd2dQK21ZU2xpN2JtdjhOcjlyTUZKTDlHSGJSYnZE?=
 =?utf-8?Q?7emNKRhlDeKB797/LD+Yl9g1tpUJOJ2giJOFCVNELYjT4?=
X-MS-Exchange-AntiSpam-MessageData-1: Vic+OLpZC89HgoWNGPuXerrEmU78a7Qi21M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da201d9-9f15-40e0-e43f-08de50f585ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:40:57.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xNlt26nxGSU+ZoB0jo8ve9QK7nRbbEDtWTWxHgfX8j4IYlCSI5kX700KJb9L9gr7aJMogoBcWFQGQqETHcPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Introduce "rx-polarity" and "tx-polarity" device tree properties.
Convert two existing networking use cases - the EN8811H Ethernet PHY and
the Mediatek LynxI PCS.

Requested merge strategy:
Patches 1-5 through linux-phy
linux-phy provides stable branch or tag to netdev
patches 6-10 through netdev

v2 at:
https://lore.kernel.org/netdev/20260103210403.438687-1-vladimir.oltean@nxp.com/
Changes since v2:
- fix bug with existing fwnode which is missing polarity properties.
  This is supposed to return the default value, not an error. (thanks to
  Bjørn Mork).
- fix inconsistency between PHY_COMMON_PROPS and GENERIC_PHY_COMMON_PROPS
  Kconfig options by using PHY_COMMON_PROPS everywhere (thanks to Bjørn
  Mork).

v1 at:
https://lore.kernel.org/netdev/20251122193341.332324-1-vladimir.oltean@nxp.com/
Changes since v1:
- API changes: split error code from returned value; introduce two new
  helpers for simple driver cases
- Add KUnit tests
- Bug fixes in core code and in drivers
- Defer XPCS patches for later (*)
- Convert Mediatek LynxI PCS
- Logical change: rx-polarity and tx-polarity refer to the currently
  described block, and not necessarily to device pins
- Apply Rob's feedback
- Drop the "joint maintainership" idea.

(*) To simplify the generic XPCS driver, I've decided to make
"tx-polarity" default to <PHY_POL_NORMAL>, rather than <PHY_POL_NORMAL>
OR <PHY_POL_INVERT> for SJA1105. But in order to avoid breakage, it
creates a hard dependency on this patch set being merged *first*:
https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/
so that the SJA1105 driver can provide an XPCS fwnode with the right
polarity specified. All patches in context can be seen at:
https://github.com/vladimiroltean/linux/tree/phy-polarity-inversion

Original cover letter:

Polarity inversion (described in patch 4/10) is a feature with at least
4 potential new users waiting for a generic description:
- Horatiu Vultur with the lan966x SerDes
- Daniel Golle with the MaxLinear GSW1xx switches
- Bjørn Mork with the AN8811HB Ethernet PHY
- Me with a custom SJA1105 board, switch which uses the DesignWare XPCS

I became interested in exploring the problem space because I was averse
to the idea of adding vendor-specific device tree properties to describe
a common need.

This set contains an implementation of a generic feature that should
cater to all known needs that were identified during my documentation
phase.

Apart from what is converted here, we also have the following, which I
did not touch:
- "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
  for such a large detour to convert it to dtschema.
- "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
  .txt schema but are not implemented in any driver. My verdict would be
  "delete the properties" but again, I would prefer not introducing such
  dependency to this series.

Vladimir Oltean (10):
  dt-bindings: phy: rename transmit-amplitude.yaml to
    phy-common-props.yaml
  dt-bindings: phy-common-props: create a reusable "protocol-names"
    definition
  dt-bindings: phy-common-props: ensure protocol-names are unique
  dt-bindings: phy-common-props: RX and TX lane polarity inversion
  phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
  dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
  net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
  net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"

 .../bindings/net/airoha,en8811h.yaml          |  11 +-
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   |   7 +-
 .../bindings/phy/phy-common-props.yaml        | 157 +++++++
 .../bindings/phy/transmit-amplitude.yaml      | 103 -----
 MAINTAINERS                                   |  10 +
 drivers/net/dsa/mt7530-mdio.c                 |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  19 +-
 drivers/net/pcs/Kconfig                       |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               |  63 ++-
 drivers/net/phy/Kconfig                       |   1 +
 drivers/net/phy/air_en8811h.c                 |  53 ++-
 drivers/phy/Kconfig                           |  22 +
 drivers/phy/Makefile                          |   2 +
 drivers/phy/phy-common-props-test.c           | 422 ++++++++++++++++++
 drivers/phy/phy-common-props.c                | 209 +++++++++
 include/dt-bindings/phy/phy.h                 |   4 +
 include/linux/pcs/pcs-mtk-lynxi.h             |   5 +-
 include/linux/phy/phy-common-props.h          |  32 ++
 18 files changed, 979 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

-- 
2.43.0


