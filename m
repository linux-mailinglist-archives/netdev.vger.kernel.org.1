Return-Path: <netdev+bounces-183590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E122A91199
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 04:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767443A7571
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC714375D;
	Thu, 17 Apr 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="hbp8IqwA"
X-Original-To: netdev@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EFA320F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856274; cv=fail; b=JTbVo7qKiXZVT9PZRbFPq5olwaiPuyMVo9JhGud607PEJxWPhsGyt/irHyB5MfOGFD9uXlFVutHRQF9r3A2WowvyC/VjC/nJTO6E/YMnekzhnkqYwN05L6+iK1lpHODwMX8o+WF46N1nEtIFmZbeS3nEuiS6z2e2CXm9zjl4JIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856274; c=relaxed/simple;
	bh=dwCUPiDao61ym1+COoOHOIPp8HnZGxhIIc+RKopGfgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sr1zUTxAZNoJlPI4Ct1d9BJI3iHZ4alDVS8Q4nL9MnGQZPZI5qD8t/tbQe8SUbfj5M3Cx2XlKUbGHHo3EKwxOn3dLqJ5Fz7O+73TXNURpQ5qOMmDXutwe4bodIjch8wjbMr0G7HKCKcVy2mpvrFpPrGELRSG/rWHsSb1dFJDVGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=hbp8IqwA; arc=fail smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 53H1J9Hc2586459; Thu, 17 Apr 2025 10:19:10 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1744852676;x=1746062276;bh=dwCUPiDao61ym1+COoOHOIPp8HnZGxhIIc+RKop
	GfgY=;b=hbp8IqwA50N1ZbTsUXrPPYlWPeuibYBehrfKZgBgvifI0XP3L3a41N9o7z27EVdUIlTM4
	oshBT6FZ8x7MoE4txMK+GPy6oDen7qGJxMBi1YLpXDIgtyERnGrbTDmv1GSW4AVWsKt8+iHim3o4w
	1FUmFs9lE8xNWn6RXXMbmo0tAxAHifU0zpfHvWrIHiAM9bCa5juqCGspj52QBCCVByuRN5ueRtE+m
	Ee5llffQBvfcoUIDBdyhnOofaa4ixG18tNkg2rz+i4zo0XR/Af9/BwIQdheD0OY19Fxt3NDMQhFii
	/7Ts7g2wzpgSt4QCBfDlgmWWPFcJ+Crm5gRsFVXOmw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 53H1HsAJ2507673; Thu, 17 Apr 2025 10:17:54 +0900
X-Iguazu-Qid: 2yAbRDIdvIhIqg6g1h
X-Iguazu-QSIG: v=2; s=0; t=1744852674; q=2yAbRDIdvIhIqg6g1h; m=YMywuPc/5unv3ws8ypv00bzC8j23gFr4umxhz/md4hQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 53H1Hp1m2470639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 10:17:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2mlmzWRRKKWLVUEDJWmvQAffCo12mfsZVm+563XG4G5T0ZqureLoYx8ntjQKIkR786eG7wmNEZO9+Hsnm5DN5AVqrBX7MsJJ3z0VXdVgwb6TmAMnbSaOYYxG/VyE2nFXMIWDRhHp2DstLyXMHFdxuqTA8uhPCtG/mWgEp0sqsBe3GpqN9S+U0++3geKrB04FNd+iZlzk3wkytbHmKcREN6PtH7QcUWxofkIcJw1y6O5BuMIBLkTd0p8/3QxNy1yhTY6pUiuDdvIFvGxm2JEyj0BxDBE9b4PgDjsvhQ88Gwhd+I8mnJKZCt8XHIkWfJZnWDqrTEMX5wJWPffwNqx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwCUPiDao61ym1+COoOHOIPp8HnZGxhIIc+RKopGfgY=;
 b=f+GO2nFLry6lLJ9RgfFd4CGjuFq2cnHsLKIZm3RSHm7UM4tmSSthre5LjtDeY/zDXWFb8IZKI7naLYetxZjhYttYlLrMWIEal4pLDtMZISPXPtvyf+s9f3WzZScuQa9yLOQbdvhQZJ+PDmIzJDFUNyD3YxvwsVplgjekmULNXvl4jr5KQwbh1Tp3kwgJjl65OAQe25N/O09/0p59T8wOg5bFlYJkVvYdKte/faEhHJm8HQzaiKnMrGyRdd59vP+gj5YQpHD3pDbuXiIuXxsVSUieVTKS927rG49hwOUQ5Wi6BzazT1dSQAwnp8yX1D81vceEANQVBHBiPI62XH2C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <rmk+kernel@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: RE: [PATCH net-next v2] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
Thread-Topic: [PATCH net-next v2] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
Thread-Index: AQHbrrQxDnM36Ii4QUiCj03/ert8l7Om7PnA
Date: Thu, 17 Apr 2025 01:17:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481870F0BA0040379A1453EE92BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <E1u4zJ0-000xEX-TZ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4zJ0-000xEX-TZ@rmk-PC.armlinux.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9755:EE_
x-ms-office365-filtering-correlation-id: 48f16df4-13d5-4270-4c52-08dd7d4da7f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QlZzdGJQSEZUSmE0bDUvOFluMlVvTEgvVEZQU1YvdG9CQThMWlVhNEtwdUhw?=
 =?utf-8?B?emdoM1FZSkdFalpHaDhGQjQ4dVRmMHNRYWt1d0NVS0xtQW84dlhGbVhNWVhy?=
 =?utf-8?B?eVFTNTdrdS8yV1Jub3hXeFExT0VzQVZLeDZ5UHB3L3U1dXkvYTdmUFhyc1JT?=
 =?utf-8?B?RDRHT3dMR3hET0Y2MlVkT1pBTFN3Um1OU0IxRS9yUnBCdHMvOVBLUVJIbE1J?=
 =?utf-8?B?VHhoL0xHcG0ycDByb3NSeENiR0xGdjlwY0JSQmprTWkzb2dMZ3owR1N2V05w?=
 =?utf-8?B?anA2V0hDVmNhOHpRNUZCT043Vjc2TWdGV2tzS0dZdy9veUNvcUVzYjYvWjNp?=
 =?utf-8?B?N3VlWmJ5RVd5dTBiV2RodjFkZGhuempDQ2MzazNDRUNZNEZtR0JKMmgwREh6?=
 =?utf-8?B?dnZUejdzWCtxZDNTcmZNdCtQdzdBZUREdGlsb2wxbEcvTkJ2L3JaSDZIOW93?=
 =?utf-8?B?Z1JkZUdidzNlZ0F1RktHU1hndkMzQWduS0xjMnBWcmxvZDJ5NUZrS1RQU3pI?=
 =?utf-8?B?b2poNEh3RTM1VTREQ2xJVStEdTE0SURhMS90ak16M21Fc05LMlpkSEFUNGN4?=
 =?utf-8?B?MnhQN29aN2xseUpOZG1zcFhmQVhmV09aOFZuSEtyblRNWloyOFY1cHNiTGpu?=
 =?utf-8?B?dlN6VzNKNDIzUmJKL2NVUDlNRDJzcTdON2taeVE4TTQyRk5zTDBibllScmh0?=
 =?utf-8?B?eXorSmNJYk1ydjk1c25vTVA5bWs1MkxBWm9mbGo3ZUNPM3NxbW1hR3Zmc1hv?=
 =?utf-8?B?QVVwL29yN3JjaFpBTzV5QWhrSlN0RlZYbFJWTFRuL1BjcVkyVURNWEhyMW1X?=
 =?utf-8?B?VDhyNEFnRUc3NndkK2RqSHpWSGhqdWsrZnhIWnozY2hNVitTTmhBeVZDOFg5?=
 =?utf-8?B?Z0YxRHBIc1MrQ2JxQnpRbmcwbVIvVTQzblhKVDc0WVBCeU5Xc2xNLzVqQlkw?=
 =?utf-8?B?QzVkbGh3cURXYnRsN1doeGREN3ZaZzlJcktMRURrRVlIcnRVZm8xTmVIWDNM?=
 =?utf-8?B?L2pmNHJuZU1HKzdmUGVEMEFZSkJ3ckpXNVVTbEowdnhVOXJlTVQ3aUR6cXhI?=
 =?utf-8?B?VDVlYndpS3RuYURycDJDRC9Bcmc2dkx0bnNZbGgxck1GNjJpcGJXZjVuRmR5?=
 =?utf-8?B?bVZTQW5uSlBUdDNJNlJ6dldGQXkrU3hUUjJSVERQWUdJRHdxSVNMdzcyZEp2?=
 =?utf-8?B?dmlELzVnc1BGUmQrOGdGUkhiSTZiUFBMTzl6SldvQUFBdGQ1b25HL2pwZ25F?=
 =?utf-8?B?TmllZ051QUQ0WFVhZWhMcENSQTFCcW1DLzQ5ZHZ4em5UNmVMVUN1bitlVGYv?=
 =?utf-8?B?N1lubVJjL3MybmpaVjliWlVzek1wRTJsVFkzU0tSNjlEYjF1RStadnZqbFhJ?=
 =?utf-8?B?TDJ5STM5dFhYbElBMUlielpmWmVZd0FxRWZDNlAzRUlTYUVRNlJqWmRaN0xP?=
 =?utf-8?B?N3dQR2liNnlaQ0lkS2hjZ1N4OW0yM0dnN0FGeHJmNmV1Tmd4aWR5b3hrT1J4?=
 =?utf-8?B?a0gwcUpVb3g1a3pPVUdoUmoybW4xVTY1S1dLUWQyYVFNNG9QNzdoTTFSaDFz?=
 =?utf-8?B?Y2NyLzlIa3pLdUhtUDUrVm9XQmd5VGpkT1JLMUhDTWtUYUhrOWJRaHY0VHRX?=
 =?utf-8?B?MjZMUGE4Q0RSc29laGlRZTRpTUhUbzhlVC9melVXRUZSOEVNS2cyRHBTdG5K?=
 =?utf-8?B?MzlRQVhIVnJzTXo5OWx4Q2IwWUN5d2lRQzQ0YzBac0ozQlVIUUowM1BQY2xo?=
 =?utf-8?B?Y2ZSMENVa1pPUWZNMStGY3BYTVM5czdWRnZpZGwrbnJxNGJ4bzZnYmJtQXdh?=
 =?utf-8?B?TUdIS0lEYld6K2tiRGlGdmZMMEhKSVBGYmEvd0pJRHQxMUJYRnRwZnozS0Q0?=
 =?utf-8?B?ZGgvNk9XK0dreCtOYTRNN0czTEQ0RDdpd3NIaWJ6eWFDU0VjLzRuZElSZWd4?=
 =?utf-8?B?dnRCTlhXMG5oMzRzRitJZTh2QnV4UEpDcllkcUxDajIzcy85QmtvSnpXYXhY?=
 =?utf-8?B?VFZpZlhLSjdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVRud2l6VWNjWXF4cFhQUk5jWEU4dlpLSVFKL3RWMzliYWZJWi9RUXhqQ1NH?=
 =?utf-8?B?dDY5MDByUlBlMlpxN0toT2c0bU8zRHE2K1cwOFNQMHY3QzZ4dmRkUVFWZlJI?=
 =?utf-8?B?bkZQVmkxdVJyVEhFY0dxdFk5cjdnZkx0SUpxdmZFMXVXc3VndzJ3V1EvVDZi?=
 =?utf-8?B?RzZPdHVycnUwd0k1RWpiQ2tldEtCWTduWkJURldNYk1ZLzBZUUFEMlF0dlpU?=
 =?utf-8?B?a1ZNUDZqNytWVzNoUjRJcXJvK2trS0RrdlNUUTVPZGpoK1dqK3ZaV1hKaVJG?=
 =?utf-8?B?OWc5U3VaZWRqQzEzcVFOWjRGeVVJY1Jqa1Q5ZDNlYTFsZkZwcWgvV1NMWVJE?=
 =?utf-8?B?eDdIWXJBcHJFZ2dESDBTOVpnV3BraTJUQzBLZzdVWWJFSHRySW9RTWpGeERO?=
 =?utf-8?B?a2U4amx2VWZBd0dRRzFOWGM4K0gyZEhKWjN2b2VpbnVzc2Z3WHdWeElVaHQ3?=
 =?utf-8?B?aysyVk9wa2tCMFZaYUNodzVYY3pqUVZWL21wQUZxL2laNFpCcVZaTm5IYWw3?=
 =?utf-8?B?VzQ4WndqRVV6bGF6bWpZaWlVc3QwZWRwM3lITEZIZDRKT1QyUVkwZ1R1Y2Ja?=
 =?utf-8?B?WWZaTGx1NHVyNkZodndERjVVQ04zNEwrRkp3bE9KTFRWV3hVVkVVZ1dubDhP?=
 =?utf-8?B?QzhVWVFHcDRBbml3UDV0WVl0VUxQUkhHL2wrWXJGT2YxQnZXT1ZjTTB5WmNq?=
 =?utf-8?B?YlhGNVdKbXY0MWMzbi92MGsvb2pIRjN5TU1mRHhrZjFxcFhsWDhmYlR3UzJv?=
 =?utf-8?B?UEY1UDcyUTdDL2FLejRXUnUwb2N4R2FHbWFDMGkvb001eENxaGgzRzRiT0JG?=
 =?utf-8?B?R0JxTHBZNm16bTVNTmdIeW42bHZ5T3k5N2RuQ1UvT0t5YSs1SnlBYXdyRktK?=
 =?utf-8?B?N3ZZT1o5eS9ZYlVJVlB5alU2OWpzMkM5T05IZjJOaFQxZ3NhNW1CaVFpZmNN?=
 =?utf-8?B?eS9mQUxQTWUzZEZrbmdpZk5EbmlRRWVHYTF3TUhpN2VHclc5ODhMVCtScEpX?=
 =?utf-8?B?NWRrSm1ZRnVmTlRyNVdadVhqWjQvUWM1N21Xc25WbXZwMHJheU1Zd0J0ZHV0?=
 =?utf-8?B?TkZxUmQ5T0IxaE01MVdLTXVrUkhoTC8rMEt1T09GSjZFeXI2RERFL3VEbFlU?=
 =?utf-8?B?bm9VZFU0U2g4bTBZakltT0dEWUczUFlHekg3Y3I1WHpEUGsyRVdNTUFNY2lx?=
 =?utf-8?B?VEY0RmdJQlhZdG4rbG1SU2FsdHc3eWlhUklLZHlpY0VpNUhSVWJHbHl1YzZI?=
 =?utf-8?B?dUFJK1gydWcxeXRrL08zNWVDRnpBQUNLMml4bzNXTXJjWTlZczJlL3pEaXhR?=
 =?utf-8?B?ejl1ZGJ0VnBsVC8yNDVFNzk4bVBNbWY3eFM0TE84eHZRemJ3KzJob3Qwcm9R?=
 =?utf-8?B?bzN1dmhkaDNZK3FwajMyUERuZ1dJTUxhQ1BTUDVYRmdkTUZjWE02K214RnVx?=
 =?utf-8?B?Tk90NFN5MUFPSFJxQWNueHZhTUtobm1XRmZkZDhMQzFDYVQvUWlTajRwNXpE?=
 =?utf-8?B?b0hXRFlOK3piWVM2a3Z5S0NTaEs1VmJZUVZ6YnNZSmNiZ2ZSNHBqOEorQWd5?=
 =?utf-8?B?VEs3TUNCOFVsN0VwTEZ3Ukl6bHgrbFcvcGNnN1RhTitsalYzS25SZFlCNkw4?=
 =?utf-8?B?WVJxUVc2eHpUb1ROcXRic1R3bkpqR0M0SERRS2VZNzFOQ04zdVg0SEU3cXRS?=
 =?utf-8?B?eThrUnRIMTZ6eE1iU2tGc2tURmpOYnNrWkJxQmpxc2FUSnFBTTZYWE5yYmhP?=
 =?utf-8?B?cE4zeG8wdFdERC8xbEU5ZlBSVnNXWFNMZFFDTWRLejBhV2RWbzZ3enNNN3pG?=
 =?utf-8?B?TkVQZCtaMW40a0p3Vk04UHF5cU5CeWtTZmRXSURkVTFoK3lWZ1hzUDh0Qllm?=
 =?utf-8?B?S1oreVNjWXFQZjJ1NnhhU21VR3B3N2l3bGRsNFFLSldtOUh1MEJ2UU50L0VR?=
 =?utf-8?B?Z2I1eWIyUlJRVkQyOG42aytlWjRodWxhUG5tUkhhcWE4VUFlQ1pFR2RHQmoz?=
 =?utf-8?B?c1dDNDdVaXVER1A2NkR4S2xwUW9GUjE4aE5mT2lNbEZPczNMY3Z6WWZhUVJi?=
 =?utf-8?B?eWh5UkJJb1RzY3NOSFdCUXlUcFVTMnViQ1Azc1RaNFo1bzRZWlZ2Y1NqTVNQ?=
 =?utf-8?B?RWpnQVcxZHlCTFlVMDdjUURlbExzQXNwb2xsdmx4S010L0NudEhvMlkwb0dX?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f16df4-13d5-4270-4c52-08dd7d4da7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 01:17:43.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNH4jIBo1mAn1QjciiRSAlcBSC/Sw+rTvM+wxDU+hadAYmc0NxHgG/3aVfafBAOEI8doN6h0lfeF7UfYFIXYHcOWXjnuxkgFRurSGAwhfQ2GmW036fBdRBTI6bF5CEt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9755

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bh
cm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2Vu
dDogV2VkbmVzZGF5LCBBcHJpbCAxNiwgMjAyNSA2OjQ0IFBNDQo+IFRvOiBBbmRyZXcgTHVubiA8
YW5kcmV3QGx1bm4uY2g+OyBIZWluZXIgS2FsbHdlaXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29t
Pg0KPiBDYzogQWxleGFuZHJlIFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47
IEFuZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5j
b20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3Jt
cmVwbHkuY29tOyBNYXhpbWUgQ29xdWVsaW4NCj4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpd2FtYXRzdQ0KPiBub2J1aGlybyjlsqnmnb4g5L+h
5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggbmV0LW5leHQgdjJdIG5ldDogc3RtbWFjOiB2aXNjb250aTogY29udmVydCB0bw0K
PiBzZXRfY2xrX3R4X3JhdGUoKSBtZXRob2QNCj4gDQo+IENvbnZlcnQgdmlzY29udGkgdG8gdXNl
IHRoZSBzZXRfY2xrX3R4X3JhdGUoKSBtZXRob2QuIEJ5IGRvaW5nIHNvLCB0aGUgR01BQw0KPiBj
b250cm9sIHJlZ2lzdGVyIHdpbGwgYWxyZWFkeSBoYXZlIGJlZW4gdXBkYXRlZCAodW5saWtlIHdp
dGggdGhlDQo+IGZpeF9tYWNfc3BlZWQoKSBtZXRob2QpIHNvIHRoaXMgY29kZSBjYW4gYmUgcmVt
b3ZlZCB3aGlsZSBwb3J0aW5nIHRvIHRoZQ0KPiBzZXRfY2xrX3R4X3JhdGUoKSBtZXRob2QuDQo+
IA0KPiBUaGVyZSBpcyBhbHNvIG5vIG5lZWQgZm9yIHRoZSBzcGlubG9jaywgYW5kIGhhcyBuZXZl
ciBiZWVuIC0gbmVpdGhlcg0KPiBmaXhfbWFjX3NwZWVkKCkgbm9yIHNldF9jbGtfdHhfcmF0ZSgp
IGNhbiBiZSBjYWxsZWQgYnkgbW9yZSB0aGFuIG9uZSB0aHJlYWQgYXQNCj4gYSB0aW1lLCBzbyB0
aGUgbG9jayBkb2VzIG5vdGhpbmcgdXNlZnVsLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIChPcmFj
bGUpIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gLS0tDQo+IHYyOiBhZGQgQW5kcmV3
J3Mgci1iIChoZSBkb2Vzbid0IG1pbmQgaXQgYmVpbmcgcHJlc2VydmVkIGZvciBzaW1wbGUgZml4
ZXMpIGZpeA0KPiBidWlsZCBlcnJvcnMuDQo+IA0KPiAgLi4uL2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL2R3bWFjLXZpc2NvbnRpLmMgIHwgMjMgKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQoNCkFja2VkLWJ5OiBO
b2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


