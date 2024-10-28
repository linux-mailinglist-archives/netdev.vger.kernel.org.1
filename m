Return-Path: <netdev+bounces-139467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6279B2B7C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E46B1C21A52
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7A1DACA7;
	Mon, 28 Oct 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U2VI+ngr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA51DA31F;
	Mon, 28 Oct 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107394; cv=fail; b=sRNFFMTkkSFcmjf5FSoBjGHTB+n0xW4fFCOaqAutVwCVmNDPxcaUtvroCgitre2st1JKz0sZBZ16i4+IjWrbeWhNLj46s66SUDGBgqPDU5jaQHMcCloM6vQU8oItrhiF1svpWtQAHsNmSq7qhtsmwEl2GN/0HMRbmrkaoNmAHjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107394; c=relaxed/simple;
	bh=H0a5Kzu/F3YzA3KvGOV9Tg/4KtTKsvqz4mCu1P6wD14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/7vuvdc6/1xooAIG+0svU/Ico2PvBk12iv5oquk8NccFPOaCU1yCsoGM0dUinFb37nVqiTk30Sx/KDPu++3sLcFOljSxD9OLhx+IiVIgRnXPrAScRnZ9fFYucvJxpIt/bPuS4fxcigUaCFh0IvABDTjPtJnn1cc0Zlzvr6aX9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U2VI+ngr; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2FjPEqObUTKk8/BPM4bxiWG2QQlZRq6sgpBr3TlifEpF138Yv4HWq1NlAyCHkgw85Iw22Gee9NHSmujv87ri+9aVvUoM9vio7thqVIEt/dM8aPxzq3zh1NaeFIzVOlKXvj+NaMUqiSrnajHj2kpgPtxNpzFzT4g1dbeHUJBY/kBJ6Ne4NkjQrGrml6jLiI/MtBwrfQWO4DyRVfXT51zqbzSd7lwY7ySqLfAJroa1ZamBjh/V0nz1+QI48+JKh0pzrv6sXrZfCKkhE7zNuu9oja4KbO4M8Oc194xidQ0GWP4980PrhMeLIwTnozId0lQ5taD30BYc13V8OcWlgaUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0a5Kzu/F3YzA3KvGOV9Tg/4KtTKsvqz4mCu1P6wD14=;
 b=G8KABBPboQQAle02+Oa4m7YSNrpCdxvaTQ/NrjzJ/+w3ruOCmmbxwx1eLQHci9jYF4OxZS9pSmFsYSJvOmCvfvY3+grQpaPZ2iHo783ZraB4uBt/7SJM0IdG2hpRYspVUvDwS1nppkh3vZs5pe9JtJKt0VWp/oszqKB8vOd3BaCjBBEIbvIqcLSNBfv/NaV3zWTQJgf/GFNyjEKCnpgkD2EGDLpoxwTz7rrvZ9KncPhNitxwReFPC4Bt742btSI1fh3J5L5YeysRCgpax/2y5p1A2eFpnV55oGE6M9YMYi4AiTzXg8HtrZijHsaIdPsCy12NqLUl91zI51SrkO4H7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0a5Kzu/F3YzA3KvGOV9Tg/4KtTKsvqz4mCu1P6wD14=;
 b=U2VI+ngrdBjtKtGXw9mr5LinyWDjSlpXoUelkG+qTh12K+bTxvVfgSg6PPutOs2z6eIRsdwgPr2hWMvdKnQveQyHT+VS3rtWk1geQ8lmrAgTx//5Pea95lxO9efJ7pjmk1auSbAo4uuzpQ2CN/83JXeAMBSDgzwlBoYA59JmIPU9rBdaqRjUFwUeJB3X5qDD6pY6tOyAT5hG2O+U3henojGmhNKU5k9isTVwIPnMiwLWsuqUeElSoVszzIYdEZcbyZNwuik62uQoenGT4EGHfRCXe55Fy+t43mUYskOE4HFI12qk96mnPUgVWE43GlSROhbkxSTDlXoCT+cFWC1taQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:23:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 09:23:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: set MAC address to the VF net_device
Thread-Topic: [PATCH net] net: enetc: set MAC address to the VF net_device
Thread-Index: AQHbKRjmayLn+6Bs0U2f/7uwJvmk77Kb4l4Q
Date: Mon, 28 Oct 2024 09:23:08 +0000
Message-ID:
 <PAXPR04MB85100950621F48B6D4520114884A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241028085242.710250-1-wei.fang@nxp.com>
In-Reply-To: <20241028085242.710250-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB7197:EE_
x-ms-office365-filtering-correlation-id: b3dea13d-6333-46e8-31e8-08dcf73222b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dXR5ejlZY0xJTjJlSjZ6WEZxMm9oSU9VR0lkeHIwY25QTUY0WGxMNmltbHh0?=
 =?gb2312?B?MHdnN0tzRllNQ1Q1L0paaVQ3VWlZUXdSSnY2MzNZa3hNNHNSdStZcnVRaEQ5?=
 =?gb2312?B?Sjg1bGZ2Nk1TQmNFNGZvNmlXNjF1TjNsbWZHakF1bExvK1pYVXBSeENPWEJq?=
 =?gb2312?B?L1Y3NE9QRU5nRVZRQUVBS1hYaVVvT1UvejZNeVRXV081YW95eE0vSWdiQUdv?=
 =?gb2312?B?TFJPbStLbEhkc0xYSmpHcVNGbFJBWFRjc29KVFA0UGhEeHJoODBKYm9LelpD?=
 =?gb2312?B?ZHVVOFZveDk1TXdtUGl6TFNQTmo4Z0txbFFuL3RtQ0VoS2s4UFhOZFlwYXBU?=
 =?gb2312?B?MHJEaVVFTng1LytZdHFLKzFBMmgrUXk1ZkxmVmZOLzZGTFZlK05UMDdLVVh0?=
 =?gb2312?B?SFQvejl6b1JBTUFVbTZROHNodEdxdWZVR0pyNHZyYnJ3K1ZMNWpkYng2YzBs?=
 =?gb2312?B?NWU1eUpZQlQyWjhsOU9LelBWSEpjdUZEdVQ1NDhEYjFYbjl4WnF4anhRODI3?=
 =?gb2312?B?cnBUQnRnQ3JVczFuNWxES2ErSDdBSnNMdXRmN2RzYXY1cjBla3dxc0MySTZ6?=
 =?gb2312?B?b0Q3eTFRc0RtYXZSSmFvT0ZHQzFTSEtBbVBFSWRYUlg0NGg5YXQxTmVlbmZh?=
 =?gb2312?B?TjVZYy9nb3FwY0FyaVJuOXhoQk9HeUl0Q2N1MEFneXRWME1HMGRPclhsWnRq?=
 =?gb2312?B?eXl1VGN0SGorYS9vK0wxaEl6TlA0MWxlVjZack9ubmVNMVFWNDlPVjM2bnhh?=
 =?gb2312?B?OUhWbjVJTG1XNlcySU42bENnV0ZqM0FjaGt6R3IwWEpYazQ5TklzTUorU1Va?=
 =?gb2312?B?Y3FoR3drUFJkc2hBMHc3dDM4citwYmU1cUJsNkZIcE14N1pINzNSMGRJYTl4?=
 =?gb2312?B?UG40Wm9Rakd1MUlHdGFXYTJhZkg4V3B1RjltRkVMaXI4SnJoY2RJVVBLbU04?=
 =?gb2312?B?cGVKU3NoQmxjM0o3aTkrK2NrYmFZWnNFcFZXUUQ1d0k0dDNDMUwyL2pDRUcv?=
 =?gb2312?B?Ykp0ZHM4UFhuNmkzVFovNFZ3c2hhTWtoWlA4cmFwd1FIRjh4MUZGeklUYmJF?=
 =?gb2312?B?NEtiZ2JoSEZuR2RxMEdBK05ZMlZIdzJLb2p6K1puZlVnUXgwcmp5SFpRa2tS?=
 =?gb2312?B?elRuWkFCYk5kOWFIWWlETmFRVjkrTXNUdGlEcFdjbW03VDBuZW1tVzRsbDZS?=
 =?gb2312?B?czNGL010MDNvT1BaanJGK2VrdkpsSDFBTFpQNnlva1N0OUhwRGZXcjBOL1ZS?=
 =?gb2312?B?SHo0bGVVbEVQVXlSNFkzVmRySHAxVWQ5SjVKQ3g2aHR3M3FtN1BjMnlqRVdi?=
 =?gb2312?B?WE9qNHpXbisxcTR5cmhDVzdVbFVUQklaaFN6WVdreDlxSVkrRU1QMU5KN0tj?=
 =?gb2312?B?dm5nUzVSSWhsVk1uaG1TMURxTXFjRjFPald3YUw0anFPbGdLbVg4dEdZMjYz?=
 =?gb2312?B?dHB0TEx2VUFVcHlVMmxaTnVjZzBQV2FncUZwQW85YWNmSWZUVURraTNWTnlM?=
 =?gb2312?B?bXJEaGJHbTlydXgwcXhxa2lEaHlPNVdqNmd4aStFT3lLbDgreXlQb2JTbTNj?=
 =?gb2312?B?UU9SdzdWUkYwVXdNK1NOZlRXK2NHVURvdFFuMkE3Zmtxc0hKK2gzY1FSY2hM?=
 =?gb2312?B?SXU1NlQ5OXdtdWZBS3RNTzg2OGFXWmszTWFZYklkTDRFOXR2K0ptNXRYZkd2?=
 =?gb2312?B?clpzUFhNVEc5bnRTbXE0MWhPWFhGRXZnTzhIU05PalZDNkNoMFhaNTAzMzBv?=
 =?gb2312?B?dzZNQXlJOVZaOVU5ZEdiV0RmVDN2eHcybnFYbzRIT2JMdXQ1UzlwNVk3MEw5?=
 =?gb2312?Q?vhBnkKfU5bKRH5ec9CXlWkLS6oPuHaSVAJVOc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OXR2elpLdHI3am54dkRBaEsyUjM3Q1E2azZLMzQ1MVZtaERzdW85a1lKajBn?=
 =?gb2312?B?clh1a3RvakJhQ1dRNmwwWUhhZlhZZXhkR3Vtc1QrcUN5L1NhZEJLTjgzK1pP?=
 =?gb2312?B?MDJCZTdQWFN1cWJLVDJoOXFZa0RvQlRkSHF0S1Vndk1MZWJicWQvajdPWTRS?=
 =?gb2312?B?SVBWV0ZjdVAyaXV1REZ4ZHBadlpaVTVhYVcrVUNiOEJEb2U4MUN1OWlYN1Nj?=
 =?gb2312?B?Z1FKckdCTGxDYVpacU1GeFVLMXZKYVE4a0J0MmRiS3RKayt4MDdSRGZ6aEdh?=
 =?gb2312?B?K1JKUEZzcTcrQncwWXV1ZjZxQklVSGZXaTg1dXRFVUkyL0FyRjd6MG55RmFL?=
 =?gb2312?B?b0hnbUd0WC9sbVhCOTE4RkhYV0lEZ09oM0Z5MCtBMjVoWHI2RitIbmhESmZT?=
 =?gb2312?B?d3BEZXFPdDJjSTN6a2JpVGZUaGF5WkV1VHg5NUNJZHhkWjh2Z3NjZ1BLSi9W?=
 =?gb2312?B?Q2xOOEF3emVxeThmSnkvbXFKM1FGUmI1U3lHaHU1V1oyWmpxRkpPeDZ2NExi?=
 =?gb2312?B?c0dPK0NnaCtsYW5BVERvb0h5aE1mSDZqQ1QrOUNCWmNwai9Gdzh2OEU4d0Jz?=
 =?gb2312?B?czFza0tadDIyWUxvSWVRTXgwbHJkM1VjVFl5eTRZVXRvQ3FySGdzRlZvRklJ?=
 =?gb2312?B?djRmajVVSkZFTHc2NlBJQ1QwWUc0R21VRlJsZWQySjl2dUdDbXVpRzFVaWZY?=
 =?gb2312?B?QnQwWnRnTlIvRnAwbFFNb0FPQnhYakZQcVNkanR2dVh0MGZJRjlUOWRYbU1I?=
 =?gb2312?B?cHBpM1MvQUlLT3Z4ZTZQQ0F1d1N1OUlBR3hYNnhoUjRkWXk3bDdwaGY3VFEv?=
 =?gb2312?B?Y1RaZFV4OHFuMzYrZDZsUU1jWmhrSExlSDkrYlJCTHQ3V1prK2x6UHpMNTBO?=
 =?gb2312?B?akl6aWRnMjNkMjMvamVSSENHUGNKSnZBSVVpSSs0OWdDb1hRVlp5SXFxbGZD?=
 =?gb2312?B?WXJUdkFJUThodDZPZGI0OXpjajBmRWRaWkpZQldVS2NBMmk4bEpsSnZIRTRC?=
 =?gb2312?B?djlMTHV4SW1jcU45N3ZHM1pCcEUrWitlNXBDWEg3L3dUZGUxanRVc29FOVZK?=
 =?gb2312?B?cDVBaFlPNlphaWhNeGd5aFprVEQ0VDJidnN0SWZpdUxPUGZDSTdIUWw1YnNF?=
 =?gb2312?B?RnRPUnU4ZjBaV2lRaE9tcXZ0TjI5OTNtNGlpc0s0ZEdZVmtVdjRUVmZVenl3?=
 =?gb2312?B?NmpkMWI1QzBFSHRXQnZsdk4rRmtsTEJWSFBXNVhRZjl0bzBUakNCcmxQZEZL?=
 =?gb2312?B?Mk9mMWRKeXZraFFTWnFhY1V2cjNncjhpR2NnRXJyNXROaUlHQzJhTVoxQjhq?=
 =?gb2312?B?UG1PS0FjM3p3UTNXU09oN0FRd01yNFhNRDU5RXFjTHp0OEtPZU9Zc1BVZGh5?=
 =?gb2312?B?WlFMQXRhbkVJa3piYnN4UU10cENMNG5YUTdmUi91ZExjSERidVJnb01Jb0Jh?=
 =?gb2312?B?QWpyV3BxQTZ5QndqSGduUDVxQ1J0Z1djbWhJNEhxQ3ZoTGIwM05NSE5qN0FC?=
 =?gb2312?B?cTU4bU1JcUlvRXZVcVNiV25hdlFoMkxRT2ZuTnBnYVBQRCtSNXFhdXFuUi9D?=
 =?gb2312?B?b3VMTzl3TFBEbjg3WEs1SFR1QkVtVkUzbEZJTElHU2FtU1p1RFZKWEp3Vklo?=
 =?gb2312?B?ZEp5eG5jcFZCQkdybHkxNUJJQ3Z4MnZaNWZIdmZlN0R1NUdEc3d6TWFQVWg3?=
 =?gb2312?B?RThZLzNia3NCeVcrcnBWS1JVdzM2NE0yZ1crL2daTzBadmZoTkN0ZUFjSzMy?=
 =?gb2312?B?TThGV1BzcFBXWmFlY0FhUmZJTkROeFpRSHZJUDkrUFIzSkNrZEN5UklZYThY?=
 =?gb2312?B?V3ZLSlpRcVg2RElDYUcxK2xQMExSNEZHSVpsaS9vWmxvRlVXblFMMkdwcmha?=
 =?gb2312?B?UWZ3ZFlPK2hFcG9GYjJzWHlkQ3lRM09LT0drUnB1Z2VyUnp0YkhOYWdTWThQ?=
 =?gb2312?B?TFpySXMwNzYySmlHYVhMWiszcFc1QjBZTkprUE1wbk5aVXg0RGxZMm5YSEZH?=
 =?gb2312?B?NzNBUXFSV2U4d3lLMC9IZEgyeGNLakl3QzFZbmhHL2krTEs3ZmI5bzVtbmhI?=
 =?gb2312?B?UmVUblFIaDFTWlBMTnJJRnY2WTgzVGtGUnVoc0hqa21qM0ljbWNadnY3b0N6?=
 =?gb2312?Q?jMGk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dea13d-6333-46e8-31e8-08dcf73222b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 09:23:08.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GtGykhrOcT9GtRvQPByFOAsTx6zBQN1nkBp0qFq126O5a6X+/CWQQsJBE5sxlFKk9fn1p/CyeyrM0uQQQcwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOoxMNTCMjjI1SAxNzowOA0KPiBUbzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgYW5kcmV3
K25ldGRldkBsdW5uLmNoOyBDbGF1ZGl1IE1hbm9pbA0KPiA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNv
bT47IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogZW5ldGM6IHNldCBNQUMg
YWRkcmVzcyB0byB0aGUgVkYgbmV0X2RldmljZQ0KPiANCj4gVGhlIE1BQyBhZGRyZXNzIG9mIFZG
IGNhbiBiZSBjb25maWd1cmVkIHRocm91Z2ggdGhlIG1haWxib3ggbWVjaGFuaXNtIG9mDQo+IEVO
RVRDLCBidXQgdGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGZvcmdvdCB0byBzZXQgdGhlIE1B
QyBhZGRyZXNzIGluDQo+IG5ldF9kZXZpY2UsIHJlc3VsdGluZyBpbiB0aGUgU01BQyBvZiB0aGUg
c2VudCBmcmFtZXMgc3RpbGwgYmVpbmcgdGhlIG9sZA0KPiBNQUMgYWRkcmVzcy4gU2luY2UgdGhl
IE1BQyBhZGRyZXNzIGluIHRoZSBoYXJkd2FyZSBoYXMgYmVlbiBjaGFuZ2VkLCBSeA0KPiBjYW5u
b3QgcmVjZWl2ZSBmcmFtZXMgd2l0aCB0aGUgRE1BQyBhZGRyZXNzIGFzIHRoZSBuZXcgTUFDIGFk
ZHJlc3MuIFRoZQ0KPiBtb3N0IG9idmlvdXMgcGhlbm9tZW5vbiBpcyB0aGF0IGFmdGVyIGNoYW5n
aW5nIHRoZSBNQUMgYWRkcmVzcywgd2UgY2FuDQo+IHNlZSB0aGF0IHRoZSBNQUMgYWRkcmVzcyBv
ZiBlbm8wdmYwIGhhcyBub3QgY2hhbmdlZCB0aHJvdWdoIHRoZSAiaWZjb25maWcNCj4gZW5vMHZm
MCIgY29tbWFuZGFuZCB0aGUgSVAgYWRkcmVzcyBjYW5ub3QgYmUgb2J0YWluZWQgLg0KCQkgICAg
ICAgIF5eXl4NClNvcnJ5LCB0aGVyZSBpcyBtaXNzaW5nIGEgc3BhY2UuIEknbGwgZml4IGl0IGlu
IHYyLg0KDQo+IA0KPiByb290QGxzMTAyOGFyZGI6fiMgaWZjb25maWcgZW5vMHZmMCBkb3duDQo+
IHJvb3RAbHMxMDI4YXJkYjp+IyBpZmNvbmZpZyBlbm8wdmYwIGh3IGV0aGVyIDAwOjA0OjlmOjNh
OjRkOjU2IHVwDQo+IHJvb3RAbHMxMDI4YXJkYjp+IyBpZmNvbmZpZyBlbm8wdmYwDQo+IGVubzB2
ZjA6IGZsYWdzPTQxNjM8VVAsQlJPQURDQVNULFJVTk5JTkcsTVVMVElDQVNUPiAgbXR1IDE1MDAN
Cj4gICAgICAgICBldGhlciA2NjozNjoyYzozYjo4Nzo3NiAgdHhxdWV1ZWxlbiAxMDAwICAoRXRo
ZXJuZXQpDQo+ICAgICAgICAgUlggcGFja2V0cyA3OTQgIGJ5dGVzIDY5MjM5ICg2OS4yIEtCKQ0K
PiAgICAgICAgIFJYIGVycm9ycyAwICBkcm9wcGVkIDAgIG92ZXJydW5zIDAgIGZyYW1lIDANCj4g
ICAgICAgICBUWCBwYWNrZXRzIDExICBieXRlcyAyMjI2ICgyLjIgS0IpDQo+ICAgICAgICAgVFgg
ZXJyb3JzIDAgIGRyb3BwZWQgMCBvdmVycnVucyAwICBjYXJyaWVyIDAgIGNvbGxpc2lvbnMgMA0K
PiANCj4gRml4ZXM6IGJlYjc0YWM4NzhjOCAoImVuZXRjOiBBZGQgdmYgdG8gcGYgbWVzc2FnaW5n
IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfdmYu
YyB8IDkgKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2VuZXRjL2VuZXRjX3ZmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGNfdmYuYw0KPiBpbmRleCBkZmNhYWMzMDJlMjQuLmIxNWRiNzA3NjllNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3Zm
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3Zm
LmMNCj4gQEAgLTc4LDExICs3OCwxOCBAQCBzdGF0aWMgaW50IGVuZXRjX3ZmX3NldF9tYWNfYWRk
cihzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqbmRldiwgdm9pZCAqYWRkcikNCj4gIHsNCj4gIAlzdHJ1
Y3QgZW5ldGNfbmRldl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ICAJc3RydWN0
IHNvY2thZGRyICpzYWRkciA9IGFkZHI7DQo+ICsJaW50IGVycjsNCj4gDQo+ICAJaWYgKCFpc192
YWxpZF9ldGhlcl9hZGRyKHNhZGRyLT5zYV9kYXRhKSkNCj4gIAkJcmV0dXJuIC1FQUREUk5PVEFW
QUlMOw0KPiANCj4gLQlyZXR1cm4gZW5ldGNfbXNnX3ZzaV9zZXRfcHJpbWFyeV9tYWNfYWRkcihw
cml2LCBzYWRkcik7DQo+ICsJZXJyID0gZW5ldGNfbXNnX3ZzaV9zZXRfcHJpbWFyeV9tYWNfYWRk
cihwcml2LCBzYWRkcik7DQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiAr
CWV0aF9od19hZGRyX3NldChuZGV2LCBzYWRkci0+c2FfZGF0YSk7DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IGVuZXRjX3ZmX3NldF9mZWF0dXJlcyhzdHJ1Y3Qg
bmV0X2RldmljZSAqbmRldiwNCj4gLS0NCj4gMi4zNC4xDQoNCg==

