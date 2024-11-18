Return-Path: <netdev+bounces-145793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0019D0ECC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E32D2829A6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFE1946A8;
	Mon, 18 Nov 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LE9NfDmp"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020093.outbound.protection.outlook.com [52.101.128.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C121DFFB;
	Mon, 18 Nov 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926654; cv=fail; b=s9I6fL3RF1ZICgkxlX5JFrD6HaeWNzoEFJ1xi4f8yTpPTN/mikd8qD1qVAvgtHXE4WmPm4K6UOWONXN7RtuUCrWP/SJJlB+mRLS2D+90MyYJVdckZZqZji9zSxF0iDWOQB1zGK8ZcZ8m85laxyPfAsgjH1sU+IHU8AU0P1K1fys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926654; c=relaxed/simple;
	bh=1pgDS0BSJ+gIk02E17FXhFxeBv5qhykjdPTeRHUOKJM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AdzncmeT1oD/UurLbGxsxneoVYZosPiSw7LKP0YVLH2S5jabhK0zIm0oSPzjbm2EKwwQK5RygeTHIVjOw2Jam9i9aw4XPPoey9Q7YIJHFvh3HG0wiuTiPriNCFp/inFNGP7ow9bO30lG4uIB+Qz/hFYp/jXOBiTQAIzi44ZBOgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LE9NfDmp; arc=fail smtp.client-ip=52.101.128.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cURz17Y43ZldOZe/MKtJrlrX7F9jz3jpWOjf8hLy+0qffXWgAvDlRkgQIqLu84deT/2OedpFQcipR2K1j0oNx3+2Wd5TZpnDJSLl+wkqs5HaFEqpeGoGuo1y9mdb77t3qKr9ucrse41UGJ0IghPJjZoZdY9XrCJ2xHmvcbsyshX+c7RJouSNZ+7S3E9AtSDG935EOjZCUxR4m+kmtckY5R7tM8WYjy+znMHomWqGcko7mqbZejHOSUEsESPD9Lh7t/3tZwiwppvTyVAaAWIdzUTUIhYJUtuVKcffd+1kRZCOTKk41YBOOAoVI9tgjphENSXSKp0m1EdTeEXgaYKurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pgDS0BSJ+gIk02E17FXhFxeBv5qhykjdPTeRHUOKJM=;
 b=UKUrwGDHEj4Wcgm+S+T7Gc1IuZoOyGK54kS11fI6At6dAg7f+jhha9dFfcXvaAJrTBEXavDiG7l4MRLU0WYqYhn+nAOc9mOTsIwvxmaC/GxevRW8bM3ogcF0MupqceHLLNMuOLG3TkbStlUYie5WXfGPNGoUWT/qttukcubMrL4Ii/vJd/aFuhbxmvt7imFFIOHF0qC69cZ2nESb2MkJh4GLNB/MEhwsbesnj6nrIoHd+9BYI9LA5R/1ohg/I5xGnWCbrn1gCb21adlypl/eHrwRjiQi+u4jcG09J0soEHDqYEWaHR1SW5JwUlzBxgWGSNpEqfxxqoLPcEcKp49E0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pgDS0BSJ+gIk02E17FXhFxeBv5qhykjdPTeRHUOKJM=;
 b=LE9NfDmpgBxscFv6XqCJjGG+0CRG11QvsiWNAhDmsIHx3pfzpT1e8bvmJKXYI2EziRzOdw+l7DuzgGmt7nNRm4a6vbEXCjeGCah0vIiK4b6E5hawvu3TAZUHzeZC8eKe0orOy2zQGChkBcIJG3RPwi/2UHsqGHp95evNrebGP7f/GinEAxv2sisHFK9UyST8VFkBCIiGN5kQr/90mNiyEER4rT34mZKeTO5vx31ci75xIqi6svtBIiDU6uKLaY+aHnZdNuAx/yqevi8ty0ZKuiUfWN+StmgSsUjhbOUmPJ4TJXSkLrTycr8pUEI5svu+BuhuId9Z7kUYBen/rMYHWQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB7118.apcprd06.prod.outlook.com (2603:1096:405:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Mon, 18 Nov
 2024 10:44:06 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 10:44:06 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgdjIgMy83XSBuZXQ6IGZ0Z21hYzEwMDogQWRk?=
 =?utf-8?Q?_reset_toggling_for_Aspeed_SOCs?=
Thread-Topic: [net-next v2 3/7] net: ftgmac100: Add reset toggling for Aspeed
 SOCs
Thread-Index: AQHbOX9r9yI8DsQIiE+JZHcx3y+hz7K8zy0AgAALH1A=
Date: Mon, 18 Nov 2024 10:44:05 +0000
Message-ID:
 <SEYPR06MB51344C50BA08B5204102BDA29D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
	 <20241118060207.141048-4-jacky_chou@aspeedtech.com>
 <bcb86fdbdc7be8f96a451df2d8e479e123ad8924.camel@pengutronix.de>
In-Reply-To: <bcb86fdbdc7be8f96a451df2d8e479e123ad8924.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB7118:EE_
x-ms-office365-filtering-correlation-id: c54dafa5-2194-4ec5-b405-08dd07bdecd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0ZLZzY4NHBlZ0F0bmlqck52Q1JKUVlYTS9ac3FtMVpFenkydmRESjJZQnVH?=
 =?utf-8?B?K3NqcVM5VWkvcFhsMktKdytBcXM3WVFGUUZQeW5lTjFmT08xaUV0Q0R0cmhH?=
 =?utf-8?B?MGNYN0w4WnNGSlk1R25TNzlFR2JTd2t2M09icXY2eWlZQnM5bUxwQ0c3aEl1?=
 =?utf-8?B?bnJRUzBsK2tuOHY5WVVUZXJTTVBQQUJpRE03cWJ6SEVZd1B4cUdDSmtQdTcr?=
 =?utf-8?B?dnV1cXlSWWxFcUpFdUlyK3VveVlLeFB5TEU5T2piMTd3WDJrdmdUNmpZUXV5?=
 =?utf-8?B?NjN5dHJCYkhYTHhZTnBMRG5sTnFaNWRLQUxKUSszMURSNkgzRFplMUNUeXBK?=
 =?utf-8?B?dE40T0NSKzVVR3dveW5tLzVlVkVWWUVsSnNtUjhrazZNU0s2emJFTDU1eG9j?=
 =?utf-8?B?Ykh5aDR5Y2YrUGdNdnhMbHlyZG10SnJPZUZ2Z1VwZnJXeEZveDVmOGpRZFBi?=
 =?utf-8?B?cXEweXo2d1FrSzl1Z01KV2VENFRrMW44eUZQTnNVTDFTcjI1eWhwQlpiYThs?=
 =?utf-8?B?RWFvd3N4NlB6YXV6NndQblFMbjh0Yk8zZ1d0bDZrYVcyV0FLa2F0VW9LZnUv?=
 =?utf-8?B?aTRlaVZCOVhCRi8vVFN5SWlqelhuUnZRU29yNkNYTjg5YUVtZHJKbS9sRGx4?=
 =?utf-8?B?dEVoTGVaSHk4VTBhQkVZcG1PMktXVGVQYU14dkQvOEVBWDBRWkJuRFgwZVlu?=
 =?utf-8?B?N3Rpc3pudXA1eWd3NlFjd3RtKzV6anlEUFNpNFlWTWNERFVhdFBTWUtVSDlH?=
 =?utf-8?B?SkltM1ZxOVJPTXRZTVF0S2hvb1ZxYXhuaDREaUI1MEVSNWRJTGYzSUVsemdZ?=
 =?utf-8?B?ZU9KV2E2K0FOWGwyM3FtN2VJTVk0VytFY0x1K04vczZuZWhGaEJEMk85VHkw?=
 =?utf-8?B?M055aWxrQUxranN5bHJHV0FzNld1MDBaU3hoR0crT0IzeDlwbTBJaHdQNDI4?=
 =?utf-8?B?SUFjSzVpWTRpMGhONVYyVG4rMzBIdWFCbTB5T2NGWDZoOHE3UGEzeGNNS0or?=
 =?utf-8?B?NGsxSk5ONzJsdTNLdFkxRTloYzBZTWxMMitqdC80VHhPdXlMUGp6RlpZTXc4?=
 =?utf-8?B?V1oyNUZlcDBIWkZ4NkEwVDV3T0Evbzh0M3JEQkNXZzU4WHRVMnlIbW1VRlBX?=
 =?utf-8?B?Wndpd0ZoZGpENU1Qd3loZmFETGQ4ZE5Rejl5QXZkK0xiVHk3Nk13elFaWnRa?=
 =?utf-8?B?aVovYTRTWXQ0ektmOU0wMkZPRUZaajJyajZ5cE9HNlE4UHlaZ1RvYm94aGt2?=
 =?utf-8?B?akpnZkVlOW1LK0Y3WHNJaVhleFhmN2FRaXliUzJXTUVWdms0TlRVai9XWEh2?=
 =?utf-8?B?TDh1dTRpL1hFdy9vc1VocmhrMFRqTHgrUUc1cDViVE5qb2NFUitmMXZaMzE1?=
 =?utf-8?B?QW5QanNXc0dlOHVyTVc4VFVoY1JrRThWNVcxWXNyeVNHd3ZjTVlYV0dwbERl?=
 =?utf-8?B?ZU1PSGp3WmMwUUlkNExzcXlPSkJ0VlFWOGxkaTZoT29ZZXptWGgrTDhlT0RX?=
 =?utf-8?B?cER0T3pRZVN2Um8rRnVGMUgydzB0ckFTbkJwbG1QdlczM0wzcnY0NUsxSlFl?=
 =?utf-8?B?NDJRek5PTmFYMTk1clZ1WDc2eHhjK3FkMzdHZnJUTmE0YTBrVi9TNmNERXJs?=
 =?utf-8?B?dEZ3U25pbzROOHpCWTR4K0NReDBCRzliYWhIa2lKTDFJcXQ4N2xmRWxoaXJh?=
 =?utf-8?B?Y0dwVVl6T2l5OUJJZVQ4TGoyL2JaR3g4OSs5M1dETmpjKzF5dzEyWlgydHBq?=
 =?utf-8?B?UW5PYTNPbW1PdFJHaXZzM1FCbCtTdGlxNjdGMGZqeHNlRmtLWjZUWUw4Zy9t?=
 =?utf-8?B?UzNzdFE5SFJBN3RVa1MxeldUTTFSTG9VVW93ZXpRL3p6NU1BTTdSbXpnaDZs?=
 =?utf-8?Q?X+jSfKy3iUXcb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTBLVE45dmgrblVXbGRtMU8xazRwRTZkUUZ4UkxzUFg1NG5oNUJkL2lqWkFE?=
 =?utf-8?B?M2JRMGdRbEUzZjlEd0VFM1oydmNaSWRlZDRzbkpSaFVJQVlpRWl0TUN3UUlI?=
 =?utf-8?B?bjRLemZRbUpuNkFXSlFvN3lvUGZEMGlKUjJqK2hyQUNUZ2ZaUjBpdlhhZGhT?=
 =?utf-8?B?dVZ2c0ZNRmt4cXFxbE5MMDFjTmYybFM0c3BFNDUvdC9NU0FveWl6UlpqZjVo?=
 =?utf-8?B?QmdkVHp4VkZLSy9qUXZXV3VIZHJKamUxeTY1K3RSUGZ2bTZtb1VVMHNqMlB0?=
 =?utf-8?B?aWlYeFNSWnl2anJEcmJJSS80eEFMVEh0NHRsN250K2RiSTZEQkZaeW9qYSt2?=
 =?utf-8?B?Y0IxWXVrUlpYcEN0SnIzUEVRZlRnWEZoSWVaTjNWTitEc09Ob2hsdTJ1ZmhL?=
 =?utf-8?B?NTNCckQ1VnV5dlRoZnJzTUlxSjNHL29ZbmZRNDBUKzdoc2tFNWR6YkQydGx3?=
 =?utf-8?B?eDBLNGcybnhKMFVRamZHaHI3SEJtVnJMWGVwdmJ0VGh0SGN0VElaMjM4aTc2?=
 =?utf-8?B?dkNpOHZBdTJOQ0FtRzAzZmxXRnAyV1ozRHFZeTVidHFtVkl6NHFLdk1pT0l5?=
 =?utf-8?B?QUF4YVliU0pLM2hVZDVXKy9kT2JMTmZOR29saFhkY3pTK3BJSFpDTDhWckRi?=
 =?utf-8?B?dVlNQWtLRE0yc28rY2RPeERpRVlFMG5nOUttVnVTMjZpYVVXR000NjdUemZU?=
 =?utf-8?B?Z0x1ZnRLZTdxRlN1bnFDeXRBVWdobGd6aXRiU0UvdHhTU2NPS2gxMklrVDJm?=
 =?utf-8?B?U09EQ2s4a0ZiTkgvamJSQkRtVTRQQ1JCUGVUNldraVlXQU54SWRoL2Mrbmtu?=
 =?utf-8?B?QWxUVFdsU3ZINGJPRW1ZQW5kMEFMaVRQYUdZbTF1NThqSXlyN1ZTWGlEcHZV?=
 =?utf-8?B?bjQ0dTlDaGNucVpQbkIySGp5YW9YUjBSOEZzUkZtUDBOYVJ5MDVsY2hDK3RG?=
 =?utf-8?B?TlFqOEN0TnJGV2FoWXV5REhXb2FQZ0xtTVRvT2M0LzhZdWlYNUFVWkE5Uks2?=
 =?utf-8?B?bXluT0daRzVibE5kaDNaQVc3ZEtNOGsvVzJycmorVVU0TkgvTUExalB6Ujh4?=
 =?utf-8?B?RDdQb0pzN2l3Uk5zWm5tdHFyR1lEOHRiZTcySEhrRi83cDFSZXlIYkxKQk5j?=
 =?utf-8?B?Q1dyTzc0QXVFNkRKa1htTlpMRStRc1p4RE1OODNDVlV2UDJ1bk9qaEt3dFNS?=
 =?utf-8?B?bFJSd2QrMUhKUHdTV0ZtVGJqaDc1MlZLbVdwZTlnWUVsOU43UzJody83THRH?=
 =?utf-8?B?VnpVZHdLUGVXeVYrRVZuNjRheXBhcVlyUERId1JTdEVIYmR1ZTUyRSs1dHZ4?=
 =?utf-8?B?MkFpbTVVeUgzOXRveExmN3R6WVhLS3hjZTlwcHdBQTh5OGs4elVSbnhxQnNR?=
 =?utf-8?B?R1lxbW1qbE9yTEZadjBDZWt6K05JYW9qYkYwRy9acTIrRUNDc2NGYUIxQzBu?=
 =?utf-8?B?QWN1YlhoYTRhdHNWelo0bmVYeHcxOGVJT09PZVJPQjkveDNoNnZQZFI4ZzNE?=
 =?utf-8?B?bVF6RW9OMGt2RzJDRy9jV1cxdDhQRnYxR3Y4Z0pwRk52SDAvTnpkUVdObXRI?=
 =?utf-8?B?Q1djc2Fyeklyd2IyTDVYeGVkVzJ6SjloQWJxU3R4Z0F2d1paRC9pcFVKeEJF?=
 =?utf-8?B?YXM4UTZOcUp1ZFZjdmw1eUMzS2xROU04OW4wWExDTWRlanFtNlZHeTA1aVht?=
 =?utf-8?B?c1VFbHJVRnZ1WTFFUHJzTHFPN2c4cmcxTis1TVdpaWFCN2JyTS9ncjU2YytD?=
 =?utf-8?B?Q1lxNkpnQVFkUWNpQWQyZGQ0TTY3alo0WnIwOENXbHZPa1VUZWJNTnYrOHh2?=
 =?utf-8?B?NVN0RDlHdXZiVFNHTkVkZVBTd0tzSlI5RUs4ODlpV1hzM0RYM2V3S3hXZHVx?=
 =?utf-8?B?b2VEeUJsSzhWNTIyY3NlOE1ySFJXaktROUtidjFuQjMrZkhsVldvWWxDSUFt?=
 =?utf-8?B?WkxiN3VUTEVuZGd2MUd5ckhDV21uOFhZaHZOOEI2M0V6MFdEWEpoRld5OTk1?=
 =?utf-8?B?UkZDb01jMkpQK0ZDRHN5eVM2Z0paTU1DUGFzSWlOSkdwYkxETkJnZ3hGeitX?=
 =?utf-8?B?V2dPQUYzZExaajBCcnI0aHBRTENqRVVyZG1HeWtzOEJzY2gzdEtmZ0tUcDV0?=
 =?utf-8?B?WnBJTkExUEFoMlg2d3o1bmNMSG5JWEIzTzBacG83Y3ZaTGpGUlBiKytDazNy?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54dafa5-2194-4ec5-b405-08dd07bdecd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 10:44:05.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uq6ktabqTTscp76M0w0l3R3C7JnNjjdmcHQXi5D6HiBAEt6tX+3OQLhTAjVmn0tCZfI2ev7Lpi7FNs5TdXFe3NWq8Z5ahEEernTPHTsZLJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7118

SGkgUGhpbGlwcA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBUb2dnbGUgdGhl
IFNDVSByZXNldCBiZWZvcmUgaGFyZHdhcmUgaW5pdGlhbGl6YXRpb24uDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYWNreSBDaG91IDxqYWNreV9jaG91QGFzcGVlZHRlY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jIHwgMjEgKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdt
YWMxMDAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4g
PiBpbmRleCAxN2VjMzVlNzVhNjUuLmNhZTIzYjcxMmE2ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiA+IEBAIC05LDYgKzksNyBAQA0KPiA+
ICAjZGVmaW5lIHByX2ZtdChmbXQpCUtCVUlMRF9NT0ROQU1FICI6ICIgZm10DQo+ID4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9l
dGhlcmRldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZXRodG9vbC5oPg0KPiA+IEBAIC05
OCw2ICs5OSw3IEBAIHN0cnVjdCBmdGdtYWMxMDAgew0KPiA+ICAJc3RydWN0IHdvcmtfc3RydWN0
IHJlc2V0X3Rhc2s7DQo+ID4gIAlzdHJ1Y3QgbWlpX2J1cyAqbWlpX2J1czsNCj4gPiAgCXN0cnVj
dCBjbGsgKmNsazsNCj4gPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ID4NCj4gPiAg
CS8qIEFTVDI1MDAvQVNUMjYwMCBSTUlJIHJlZiBjbG9jayBnYXRlICovDQo+ID4gIAlzdHJ1Y3Qg
Y2xrICpyY2xrOw0KPiA+IEBAIC0xOTY5LDEwICsxOTcxLDI5IEBAIHN0YXRpYyBpbnQgZnRnbWFj
MTAwX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAl9DQo+ID4N
Cj4gPiAgCWlmIChwcml2LT5pc19hc3BlZWQpIHsNCj4gPiArCQlzdHJ1Y3QgcmVzZXRfY29udHJv
bCAqcnN0Ow0KPiA+ICsNCj4gPiAgCQllcnIgPSBmdGdtYWMxMDBfc2V0dXBfY2xrKHByaXYpOw0K
PiA+ICAJCWlmIChlcnIpDQo+ID4gIAkJCWdvdG8gZXJyX3BoeV9jb25uZWN0Ow0KPiA+DQo+ID4g
KwkJcnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbChwcml2LT5kZXYsIE5VTEwp
Ow0KPiANCj4gUGxlYXNlIHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1
c2l2ZSgpIGRpcmVjdGx5Lg0KDQpHb3QgaXQuDQoNClRoYW5rcywNCkphY2t5DQo=

