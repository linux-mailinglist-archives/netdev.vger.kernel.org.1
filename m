Return-Path: <netdev+bounces-133677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C6996AAE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5140C1F21819
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3B192B70;
	Wed,  9 Oct 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="msaEct9U"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA14A0A;
	Wed,  9 Oct 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477922; cv=fail; b=HGcfct6lIPmcyw+JaULOOHRzBz8gk2VC9klOL5Jo+uYX/ouBEJhDDh5jsGSXHp3mIAn3IaO1KN3dKACL8DWKmGhXIsg1dJAisjt+mtRpW0xErwkJEEwTpBN0/4BvlNgfpU2VW5w4kuDHl8FNFSf6W1oTb4i3fW1VCW5XtUVWTO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477922; c=relaxed/simple;
	bh=IR8MugVcHlY06HhBpX0vu3f16fwFBatiSK58cJxveNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZoIdXmBFWEnahXFbDVLFEI/Ics55svi7YIPTLfNGo/Drqc6mTbuh2JXQfwJpy/oOGO2xWkLU/cWaDWJTsC1x1XCLPyySFRpBvmjnmvyX80j6D110n20CdNtQAVzNMcDGMmRv/wFsHxT7OCUx9NQEFkV+y6W8nwd73hYiotP4rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=msaEct9U; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBcWM46SDBxwa6+b5lSCAAliadPvl0RL+4oOcBHzfW5yOnAf07SxCe5Au06jbEtfnkfYnzP38hdDPVuwHkdi4Kh5x0bJM/e4FqZE4M1Px0wzEg8mNpmvnwL+RO0q9ctz35/v/EBfTv6rPUu/OdCEPzQYYbnzYhQlP0aWizOz7qTZKSBR2DQlSl7WNe6ZURbBU5OoveSy3ypxl3Ygc4JuKMRY4swIIGkigZsWFhHMZlvRdeECuWGoB2bjSCpZJ+rv/GG8Lp/mgE9DHHe7d53IzVOUCBk2bW8/rch2otFnD2I7mjGgAyN2uuIYM7rP/rtDP5PAwW2R/VqnM2vd7iISfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR8MugVcHlY06HhBpX0vu3f16fwFBatiSK58cJxveNI=;
 b=SQE7j3TW+0UJ7HlzfoMzfJHMR8lwkEWJy1GQ6aX/rxO1wjAjW9Pp5KZtbMsM3hSdLeSQdrfT/JrVwBLtm/xZsVudJ1qO/D8C3iPaH6Bq17JfzPt+NCTLAbquidhkOuIIggHWaHUAK3tyGAeOtgKFqsey59fFGU9DUYr04qO9QtoVHwalxMhKnwvtGw0n/KCp6307kTF7pa3NGsIW9ISZ6guwtGhwK7QQJdNiQhZVAMBTCf5Jnof20B1lLb7SVm5IppiOdgSyRy2UCwWlweY+A0V5UOo2MjPaIg0g0TJCozvdvHXNRo8FYScMZZvTSZZn4DKBpOtMk1i2Zrc/0YaEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR8MugVcHlY06HhBpX0vu3f16fwFBatiSK58cJxveNI=;
 b=msaEct9U6R0AyoBBJtuHTb6b1h76AVs6VfkjP//D5MA1ZWIY6e0r3QXA6YVkq50zFds/KQBPMHV9M8oTuQfKBFHI5OvD0hk5aqzEkXdMynlxTfw1bBknwgAistK+98r4c+dX2IGkPNe40dYfr/FhPZu0J1oCR1wTh6zuojQJu68QOmikS6WjbjbnyyWRngNml4gITHm6vVpT9jZDo95vOcLbbQqMm4nypcoaK8gUMAB6BzRRczpQjzrw98JsIUL3G1kSUmYpU8pho0JVmo/SismBDIP1CgA2974Jj5uf8rPFdZW30tFvnryJj4E/1GKAU0VgOxCR3sDJLeL3XZghsQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 9 Oct
 2024 12:45:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 12:45:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Thread-Topic: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Thread-Index: AQHbGVMASQ54m6Ejx0iPYlWB6m6NiLJ+UkAAgAAM6YA=
Date: Wed, 9 Oct 2024 12:45:15 +0000
Message-ID:
 <PAXPR04MB85109AFC1F4EFADD88AAAA88887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-3-wei.fang@nxp.com>
 <20241009115744.GK99782@kernel.org>
In-Reply-To: <20241009115744.GK99782@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9199:EE_
x-ms-office365-filtering-correlation-id: 6f870c6b-86bf-4243-0615-08dce8603906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?M2preUFXK093WDB3bnlYd1VNaDRQMWpCRTIxcUFMK2xYSkR6Z0Z1MW1rc2Nw?=
 =?gb2312?B?a1MydEs2dGdqT2lmbzJ1ak1QK0M2UlFueWxUQjJmVU1mV3ZEN0ZFQlkzNUVp?=
 =?gb2312?B?MklxdGkreEJVOEpSZDYramdSay9nRzJmcDl2UkRIcHMrQ2JBZXpwZzI4QUpD?=
 =?gb2312?B?c1BlRldSU1NjRWdjQWdqYlF5NksrK3NuWUt6a2tITlhjeG04cUZGOWF5c3o4?=
 =?gb2312?B?MGt6MGMyYkxLRWZPRlRRa2RhRDQrUEd5eENLMTdaaGUyYk9vMUhqS3ZoNEV3?=
 =?gb2312?B?MGpSNUFjeUZTMUxZdllHbWVLZkxXN2MrRWZnY1QrellJRVdmZWg2ZmdCOVBm?=
 =?gb2312?B?ZzRYNktUaFI1akdzS01aZWo4aU9GZGJIWitUSHY3V2ZpSEQrT2dGL1hIS29U?=
 =?gb2312?B?TThLMWYvVVBVcjNlRTc4cXBLZjZyQWloY1d3VkdFVFBLUTZSbitPVmlzNWlD?=
 =?gb2312?B?b3hnYUxhMTFXNGp0ekJKQkk3akdEWUFSVktERnFxSEM1KzdIZDAxcFEyd0pJ?=
 =?gb2312?B?NHpCSUlqSmRScWQxUEFHMi9CeVhtVmpxL1l2TU5Sd1BkbkU4Uy91SXRLKyta?=
 =?gb2312?B?bENHd3FqNU5RczlrNmo5ZUZZQ3ROS2JnS3VLeHk4MDNCVWE1MUcvdk92dlpa?=
 =?gb2312?B?L2hQYW5yUTFkcTRhS3JIeDkwdkFzYTZkMEVpU1NzQ1kvNEh3WDJCbGJIY1pW?=
 =?gb2312?B?cGR4NnVGMjV6cGlVcERiRVRQWTlOTUU0a3hwSDZjalRSSWwzYU5ZRXdEMjUz?=
 =?gb2312?B?NERZaEhZRmM5QkNLV1VKMUhLeHErdVVWU041SlhCL1hrZGdzcVBrVGdodExz?=
 =?gb2312?B?a2owUElNbS8xOUpTR2xSY1Brb1g1bW5lYVlrbkp5Qy9hbkwyNUQzQTRSbEF5?=
 =?gb2312?B?VUtFc2twL2xSRGxHRkpHY2lUQWN3TFV1c1g0WWFnSys2RTh0ZnVsNGIxTGVT?=
 =?gb2312?B?MTZuVlhtcXk5QkJWdGhTRTdmNXh6cEcrVjl3MWtUeW0vaURiaGRGSytIUndX?=
 =?gb2312?B?QkVxNUNQdzRkdDBBbmxRMlBSYjYrbTUxb2pEek5pMnBXRWpkZVg4MUNKYWRU?=
 =?gb2312?B?RnZkeloybGdHdEJLd25xU2l1R3hsczJVODNUMkZPa0VaZlV2K0EydzFSbCtL?=
 =?gb2312?B?ZDRRQm9aZC8xS1U4bGdhZG4rdFJKbWJKYTF0bEVMY2hsdTMvKzdJdVBGRTJ2?=
 =?gb2312?B?WWd2MkRML2kvTmZ3ZGs5M3JGZitCN2tSUUtuNmRWODdvempZSys3MzJZVGFH?=
 =?gb2312?B?c1VqSUIvVGJGTFFyNFlnR3diVElXL1RUaCs1TzBTVUVtdDE3akx2VmRYcDN3?=
 =?gb2312?B?SnN5MVhaODdQaElGWElyS3kzQktDektpMDZMRGdmNURCN2ROQ1FFWUxKWjNh?=
 =?gb2312?B?eEpQOFJKYS8vYThoSVVNbWU1TUFsQU1LT0JhRWdXU2p6NjJaZnNQSDdWSFJI?=
 =?gb2312?B?dEs2QitIanJoLytQQmI5ekVkQTFTZ3BMYS85UkMzZEQrdXVsaHpKUkxJNG9I?=
 =?gb2312?B?UW9QYnRHbkZSdkRZT0ZVL0wzOFBmVmcrSkV2aWJDaUhadU1tMlQ3SXdYRHgy?=
 =?gb2312?B?a2hDdWxjZmRObDl6dnE0RFQ0aGYyOHRBSW4rV1QxU0RMQzNxVG9Sb3ppaGFZ?=
 =?gb2312?B?c2dzN2l3ODlDZklwYlpjVHBySUhEd2huUkZoR1hpVjZrTGt4eGlTTU5ieWZH?=
 =?gb2312?B?Y25OUStBTEMvYlpjbVA5emMzNVBhVVBlVWh3dDRhbTBrbFppU3RBNFY1TzFT?=
 =?gb2312?B?SUYwaTM2aURRaUtVQlNmSzJ3STdvM0R2MjJ1K2svMTFxN1NXU3FHOWdjUkNL?=
 =?gb2312?B?cHhwOFJ3V3B3dFBxSFJ2UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SE5BMlVDNCtVamtYcnpUbm5jSUQ3YnFHalZtMHFFa3Z6QUZHclorSmtwYkox?=
 =?gb2312?B?TzJacC9GbDl3ZkVLOWE4V0hhWHp2V204Uy9EMVh1UnhXcjB5NG5mTVJQNGNv?=
 =?gb2312?B?K0wyOHBYYUdXTDZIK3A4dEhVRzRUWnRpVDZFdWhvZ1orYVpQaWxiUng2Nk1S?=
 =?gb2312?B?TmdOeDc5SmIxQnIzRXE2SGNTRGtvbWtSUHVoTGV6aFpVeDd5eXkzVW1lUTRM?=
 =?gb2312?B?aU9nekEzQmZWaWRMSXlDMXVmck1aSU5iVXVjVlBadkV5YmN4MGtrUUNTclpr?=
 =?gb2312?B?b0Q0U2tySHZGTG0vYVlGMmNqNWR4QWpKWm82M2p4NGhkWnNkVW44SWZuQTY0?=
 =?gb2312?B?Nko4cWxYc3hTV2JhaFVQdDJEYnhLck9mV3NoMFBFNEZWVXBVRmplOU1rNnln?=
 =?gb2312?B?MzBwemY1bE50M2dYeEgrYlp6RGY2dlpzNzVldTVCU0x4aUxkS1BVQmJOV2kw?=
 =?gb2312?B?elhNeExMeGVQMG81dDlBMnNxYjM2eERnUnIvKzZGVjJJU1NCc1FNUnF1TmRL?=
 =?gb2312?B?Ri80Ly95N3dzZkdLNm5YVnRyRUdyNGFicFgvcjZ6MmwwOHYvandKVU9wN0hx?=
 =?gb2312?B?TlZZL0hkMXNSRHh3b3Z2Ni9TZmJwSXdyV3BzYzRMcmMyUDc1djhENEsvVmty?=
 =?gb2312?B?OURvbEpqSldxWWdMUHY2d2dRUldmc3FRSnVNeUNhUktmVEtzeUplbGJVa1FV?=
 =?gb2312?B?RGVySFhlYk1vZnZjVTJvUnhXZ2dWYlJ5SnFONTg1dDBQaittaU5jVlFaTVhF?=
 =?gb2312?B?dEhvaWlsdXpmTEc0bFNjblc4OUR6RlZVZWVmTGZ5cHhrOThEd3R0ZjhOQWlr?=
 =?gb2312?B?STg1VHlNS2RrQTViUGN3Nnk2S1loTjkvby9LckxheUE2K3BoeEhMeS9jeTVl?=
 =?gb2312?B?NG5JbXhROFVzNUhGSldiSitGZGsvdFlYbndtWHJRTnZRRzg1RGgrN3VpNnZY?=
 =?gb2312?B?UnNVVHpXN3M0eGhCemNSc2gwSnJkcmVSdGJiaGVyZHZUWGNYY2ZzTkI3RSsy?=
 =?gb2312?B?bWMzTmppRlpIbUNBOEczNWxHaGQzR3cvRldBeGFmL1cvelloNnJzdldmcmt2?=
 =?gb2312?B?Qnk3NlNyNnNwNDdWWmtweWw1dkVRVEViQVpiNEoyeGpEMmxmRWRBaE5tRjRw?=
 =?gb2312?B?Z1grM2RkOXJKUnVWNnV0emxDL0F2YVkxSWJFNEJ5bmhzdWUyT01nc09TZVAy?=
 =?gb2312?B?ZjZ6OG9sMmgrNUhWRlVrdEdPTURKaXdzY3JwR0NzbVJqQmZCYlp0NnN4WERE?=
 =?gb2312?B?TXpiN3FOWlBHMW50N2FmQ3NjY1BHV2c1M1dZbi9vRXlyeDBYYUI5NHI0d2Ey?=
 =?gb2312?B?MzdjVjZEcUVPRDh1RDAwWExKamhNRXdXSEpTOHpJVTZFeEdYOXRYNGl1bEFo?=
 =?gb2312?B?d3hjd2NsYU92aXRxbnN1UUlRVU9wamtsYUhiTmpBMDh6N0pBdENMRGZwQ0Rm?=
 =?gb2312?B?eXJNWG8wZnM0REhMT1R6OVQzZVp0ZWFGSDNOWXkyZWdjd3U2NVJyUXFxYS8v?=
 =?gb2312?B?MFZTcDgvYTNXeUE5UE9IOXcxY1puVDZibzlvakREMzVuajNMRVRac213dEZU?=
 =?gb2312?B?Z3F2MkJsLzBuUlprUUJZOHpWaFB2NUpVOHM1dnF5NGt1TGhpRi9aQXNVbkty?=
 =?gb2312?B?UkdSN3pKNWxTbE96SDRmSzYzT3VvSUY0bTVFUm1PQkd4NG1uZjFraERhZGFz?=
 =?gb2312?B?UTArU1dEVkRGaGhCcXJldm54STBRSzI2NzRoQ1Vnbjk2SUY4eTRTOWJjOVlt?=
 =?gb2312?B?Y3BCR3pJT2hWTDhsRFJCVFgxU0ZzbE5BbzRVdnlYZVdZMVFjTVJHTTdjSXgr?=
 =?gb2312?B?TFh6L2E0aVl2eGZTVUZSMEtpcGRNK3c2QzIrQ0F1cnFCOTBvOWRnZzZ4WFVx?=
 =?gb2312?B?N2dKdTdDdnA2VWhaTmovbSsvaEFNd1B5U3IzNWJlYmlsc3BRRGtEUzhZSXZV?=
 =?gb2312?B?T244VHhOSkc3TVc1MVlMNGZWN1FGdVY4Wk9wUlRmUTkvNDU2Nm1lWldYR2cr?=
 =?gb2312?B?eTNPZ1VxeWwzWUhZSkJybitWZUFqUjVnNUg1bHpZMVY1VXZYakdOK2QrQ1lF?=
 =?gb2312?B?RmMzRE5weGdjRGlTMzhxazFCcjJubDdWcW1adlYzNTVhejNJcTc4U0dlSFdQ?=
 =?gb2312?Q?jAco=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f870c6b-86bf-4243-0615-08dce8603906
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 12:45:15.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbPyVk35G+DLb4wDMancME1Jkb5iGOmfOK1wjlDXWxdH4GhRQdxQAMfo0YFy74B24DZ4X5q13NE0ziLdtPjSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEw1MI5yNUgMTk6NTgNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGFu
ZHJld0BsdW5uLmNoOyBmLmZhaW5lbGxpQGdtYWlsLmNvbTsNCj4gaGthbGx3ZWl0MUBnbWFpbC5j
b207IEFuZHJlaSBCb3RpbGEgKE9TUykgPGFuZHJlaS5ib3RpbGFAb3NzLm54cC5jb20+Ow0KPiBs
aW51eEBhcm1saW51eC5vcmcudWs7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMi8yXSBuZXQ6
IHBoeTogYzQ1LXRqYTExeHg6IGFkZCBzdXBwb3J0IGZvcg0KPiBvdXRwdXRpbmcgUk1JSSByZWZl
cmVuY2UgY2xvY2sNCj4gDQo+IE9uIFR1ZSwgT2N0IDA4LCAyMDI0IGF0IDAzOjA3OjA4UE0gKzA4
MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IEZvciBUSkExMXh4IFBIWXMsIHRoZXkgaGF2ZSB0aGUg
Y2FwYWJpbGl0eSB0byBvdXRwdXQgNTBNSHogcmVmZXJlbmNlDQo+ID4gY2xvY2sgb24gUkVGX0NM
SyBwaW4gaW4gUk1JSSBtb2RlLCB3aGljaCBpcyBjYWxsZWQgInJldlJNSUkiIG1vZGUgaW4NCj4g
PiB0aGUgUEhZIGRhdGEgc2hlZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gDQo+IEhpLA0KPiANCj4gQXMgaXQgbG9va3MgbGlrZSB0aGVy
ZSB3aWxsIGJlIGEgdjMgYW55d2F5LA0KPiBwbGVhc2UgY29uc2lkZXIgY29ycmVjdGluZyB0aGUg
c3BlbGxpbmcgb2Ygb3V0cHV0dGluZyBpbiB0aGUgc3ViamVjdC4NCj4gDQo+IFRoYW5rcyENCg0K
VGhhbmtzIGZvciBwb2ludGluZyB0aGlzIHR5cG8sIEkgd2lsbCBjb3JyZWN0IGl0IGluIG5leHQg
dmVyc2lvbi4NCg==

