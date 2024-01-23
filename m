Return-Path: <netdev+bounces-65201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E688399D7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C51B1F25C95
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286282D67;
	Tue, 23 Jan 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dr1AMS9S";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dr1AMS9S"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2241.outbound.protection.outlook.com [52.100.174.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C65C8EA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.174.241
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039196; cv=fail; b=gEuFXzYL7yB7jngZ+Vh/PyLU8KSKnKxpjONCGxqD8r1lQ5EkRveIliszv9PydjVkHjZ1VZsRsQrcFmqP1z80csdYNcuz6y5RWhYyuOWdLMHKYHbdZHCFoxxMLT++51MuxGESD+8k6BHW5FAsg9iGpeJ5+k7Gdyc9t5vQCzwISM0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039196; c=relaxed/simple;
	bh=BieAvVCvIYDSWXlduGRHuyAc6a4DmCF8wQMe9dQh92o=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C9fppeeUf2ZtnmPW20A/KNehOhwhdE5tB/D2zjSPgQzVjTHmLrDH5rSX+C7BiAE3p0PnlnCSAYWZUN5ar6AboYDruRd/Iq+TaesW5PAW9Iy6lCAYaKfX0H6kAKIMuHH9tgcrMnKIg6CNvQU6RbM06yLNsRp3Wz/MoEFcYcOwNGs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=dr1AMS9S; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=dr1AMS9S; arc=fail smtp.client-ip=52.100.174.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OU4Zh8FOk2vURTTZJHjFePI+uT8Nv8enUbbUKzzL0dl6BX/ugqbq0EyyyXlSzuxJgHnE9BM3Do4E11MsicaoIfdDmU7BqIBJrGo63leKrzZimBBKsmnxNURjS4zUHc7lWq6VyVLCV6jBmZt3oaMxeqRxEviN7xM/fK2KmcJK5qa+mDo5ArBZ+G4LDf2oF9cWVgq98WAHe2HKyMuhsGuvn6/yH4arnF7Z82eKBQhWOJPrZaVPit9UnMpb4luK+Vxy5pHQh1yY4fLO3m40ptZlBiddJn/fe1eIwGOsCg0X2TfeLoGp4rY3EzfjEoMBjpi54ld23x58WDTGI2p1o1bHiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BieAvVCvIYDSWXlduGRHuyAc6a4DmCF8wQMe9dQh92o=;
 b=fBV1V0l3b5gHhlwFzdoutUZd7wUCHJyIKqel4dkBrpzAg454a6DJgikCrp5SOmyvupyNX4VvDZbsYxl8yP5iCGoAXvWCFrsCoUaw35WMpuneC/+4at/vT71sbTxBatmxJyw1i1iY6BXIgt03hjUk1lpXyuShZGcSkhNFTsVOoA6YAhF2J5ecf9DZtyTvxXsh8Yc7DCW7jtqy19F1NinKNrB77ZsOYAofFeqgPKc8JpufI3dwuBSbols1DfbmOf5c2ln1VTAKIrdvRt9M/+03JicSW4/45B5DDFExbPHbSKDFoJHzV4Ec8fgbL/LK1fvpHBEoTvBbsOIdzsqfPUqdag==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=arinc9.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BieAvVCvIYDSWXlduGRHuyAc6a4DmCF8wQMe9dQh92o=;
 b=dr1AMS9SXEA9RN9T01c1HjGyaNsUqgChQiVBSErnIOBzfWrqTcmZNlOlbwZ0jVF6erG3YGOCMJ1XGeP2VpcbAzwqKWJdi3f5N9foZqzQFWoE1exu4sIyXq7uxo2QzQGBJfPXz0QSN/qSoVZ1Y4lz0q7WOrNXsIA/QXeGxjsmfBVcDbyJwOnXQroK/Qe66CQX+eh5a15MtznBUTCyEQCahw9CCUoFf51phqSzhmdpZUlAXh9Jnxn/kp1RnB0cj/VLynjyXIczjTSboge8FLmRcmaF/f1iI5Cro2BsjO0xSj8DT9CqyQ6nwqrvNrLnp2iXD7ADJ/KC3NZOZOPXGrVO7Q==
Received: from AS9PR06CA0694.eurprd06.prod.outlook.com (2603:10a6:20b:49f::7)
 by GV1PR03MB10329.eurprd03.prod.outlook.com (2603:10a6:150:15f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 19:46:27 +0000
Received: from AM6EUR05FT068.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:49f:cafe::5c) by AS9PR06CA0694.outlook.office365.com
 (2603:10a6:20b:49f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36 via Frontend
 Transport; Tue, 23 Jan 2024 19:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM6EUR05FT068.mail.protection.outlook.com (10.233.240.222) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.21 via Frontend Transport; Tue, 23 Jan 2024 19:46:26 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 7800720083980;
	Tue, 23 Jan 2024 19:46:26 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (unknown [104.47.0.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id B74852008006F;
	Tue, 23 Jan 2024 19:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLudlQ0cE5jsF/M9hNWIrlXgX317u5fvdZbXDEB9kl16BMd0JdkbGqENSWZ961745XfNfVhEdX94fy/IVKLjeo0FoPUosGpcCxbwRu9ijdosr6Ct884w3UDnf+efR+2M40TDPx7HtoAWj3wxPAHCpZVVcBn4L8B4EvCR03Q0c4IFlQXvyY5il27XLROmXFtO+RDX7dVlKE5Eu9VUHSb7vvRaqiFzTzjfx8l8POSstJFfoerflg3pGy+cwLnhZ2QIrRzl+lCdypQTYzBWj1lS9iX9ay9cbGUVaZSFYW2m9nZYbsYyZYxbZOf/zt1s25SK1cM4YjwMUkh5XgzEsTQQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BieAvVCvIYDSWXlduGRHuyAc6a4DmCF8wQMe9dQh92o=;
 b=A8wMr4ajkZe+JxkaGke4KFzj1NyjN5OYoO7tunQyJMEWC2IVmGPeWH4WHj/FQJFPChxcHCR/lSRm0MEiFQ6jr7gXlPbj6gIg180+BhWqHH/UilnuFXAnMOEFcBRfCqkAPxWolGcHWDlMLF526Q2C2e47QKBaI2FZclllPbQ25Sc+jjpl90kt1EbVaXzNlgbPWrUTXcUuqL6zDIr04NSlB9LgSngzmB2tKnsLCV1hxEMvFpVGvWNjk3jjzC33smhlEhl4zcSdVGEyMEPbaM/5m95HSIlL/qNZQfS/6fE5skiM+8HpsDZoytG00j1xtAibRzEw6CeOEQE+E02ZudyP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BieAvVCvIYDSWXlduGRHuyAc6a4DmCF8wQMe9dQh92o=;
 b=dr1AMS9SXEA9RN9T01c1HjGyaNsUqgChQiVBSErnIOBzfWrqTcmZNlOlbwZ0jVF6erG3YGOCMJ1XGeP2VpcbAzwqKWJdi3f5N9foZqzQFWoE1exu4sIyXq7uxo2QzQGBJfPXz0QSN/qSoVZ1Y4lz0q7WOrNXsIA/QXeGxjsmfBVcDbyJwOnXQroK/Qe66CQX+eh5a15MtznBUTCyEQCahw9CCUoFf51phqSzhmdpZUlAXh9Jnxn/kp1RnB0cj/VLynjyXIczjTSboge8FLmRcmaF/f1iI5Cro2BsjO0xSj8DT9CqyQ6nwqrvNrLnp2iXD7ADJ/KC3NZOZOPXGrVO7Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB7349.eurprd03.prod.outlook.com (2603:10a6:20b:2b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 19:46:21 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 19:46:20 +0000
Message-ID: <75773076-39a2-49dd-9eb2-15a10955a60d@seco.com>
Date: Tue, 23 Jan 2024 14:46:15 -0500
User-Agent: Mozilla Thunderbird
To: rmk+kernel@armlinux.org.uk
Cc: Landen.Chao@mediatek.com, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, andrew@lunn.ch,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 claudiu.manoil@nxp.com, daniel@makrotopia.org, davem@davemloft.net,
 dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
 hkallweit1@gmail.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
 sean.wang@mediatek.com
References: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
Subject: Re: [PATCH RFC net-next 03/14] net: phylink: add support for PCS link
 change notifications
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS8PR03MB7349:EE_|AM6EUR05FT068:EE_|GV1PR03MB10329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2c3bec-109e-42b5-5dcd-08dc1c4bfca9
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 zQns9ivw3ahEr0FmE3GS9VZMbMgijvDcxYwftoL5GgXgfTloPrMxYDhWOn+/pw0FKOT7OrcU/6J2eJxO/cEmG/aVVAE9WOrBYGMXQmZv4YXvrKgCVaRuCAmPQLugIxoZMb3gmJTJZqNeTKAF0xXaUpTEwoSlg8FMFOL1wu7jwYqCTCYj7vE5dMv1XkKWr89tMHEnNis7qAe0HLTKzSEUUheePMbHkjeiG6kjPvnm4zG2fJ/SBoIAQy1EJ4CEH1/6tir0epgpJMxgkjDBeDYkGX2NPNr9PpeVPFETs1t6+4zHSnmsxi/iasGQW7iAEN7nS0+0IHgTFTJe9owKwensonlIfjw4czPmKtkeA8uTKsQFFIW4ZdgXjfl3m31vmGYpa51Kk/KiceW8EHLJSzA5m08gWwm0DOkSmog9saEP0CZsaC+SoPcUW73SlXssrHqpNtlOR9N5pgYQQGWnSHfy16Ju2aOfz1LzZtGdSYAT2GFG5AnUr9O06F6mYa7zREJBaN1XONme+BJl0dXgb3tXdPFF/HjPle4ZvQI68SzkcsXIXz+JPduUh81rKrr9S9LmFzuJWt2Gq5DR3cr+5BQZLrHYzhYM4UElLNkhPyunFBV/K+9vr98pwOdbBbmoYtPFpW284c6sAlyLh3ScVIKOvZCQnf66pVXhtGLIUrOyTH0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(66476007)(31686004)(478600001)(6666004)(2616005)(66556008)(66946007)(316002)(5660300002)(6486002)(26005)(52116002)(6506007)(966005)(83380400001)(4326008)(41320700001)(44832011)(2906002)(36756003)(86362001)(31696002)(38100700002)(41300700001)(15650500001)(8936002)(8676002)(558084003)(38350700005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7349
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM6EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6bd38a55-64e4-4733-5b1e-08dc1c4bf8c7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1z7vnXsj4PMujxKrZALTXyvkMUycxLDT1cDmmnqxW5GyZVqpE+iygBPvVdNuKVBOaom5DeuQMH9QT6cECnMnhY/0wLfsF+Ekl+SSXupPh5wGvnENFx6xMc01Dyz8zwP0QdETt0bn3vzjkdvZ3Pa/rNddq5NrrS2pYPmBdJYEFHoAebiZTMITVJssFFnXAhdDYwLjUIariBnjl20B2Egl+RoSylZYYcQQpYstvqyMSeFW4E42iAYMSFJTqHm9KKnWK2arxUhUqCEvve2jqNNtS4TTWXjQsK5V01nO9QhVQy+AmbHdanbzw9wAL1+iFFiGaVORpVDNNjDZgE3H5FUryFa6m/Lf2mrxUtnd7m4zPtRZO/50yB4nZbNk0dKFv0a5fFGyfHHw1MB7X4eAnWaEjT0Ik1Phl9+sMwhT4K0j7a5vXalP2g39jeB3kWx8nvQhHC3hMXQnecZP082hRgEYtMliCwB9C94kP1YTMwX/isbU1saeQnUNJ+2oi5Isxhq6/B6CKUJLmHMQ6pPFwqdYvGibJHY/RnsFAg9hC/x2OmD3Ar47CbXWQMOcCC5e8rOF5MbhseESjaJ3YIJilEtAjn/DlwSav9luWX4IS2ZaVAb0jZjKDcfYutmRkDWQI9Za5FF2tuHiwEoG78JrsoRN/LQZMtOW60GfH9JkZOgn3VLM5K6YwllyP1RWizUyV26AygIF1ST0lqp92/uBB7gbwSBqNmaTvcJbHWxi17EGDTuRMLeR/cWttGtG5S53bOqLcYPpiTWYXyHV9hvu4MbUFNvwKVQzanecjmWKWrsg6ucTsnVRuqikS/WhcQNXF8tt
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(5400799018)(40470700004)(36840700001)(46966006)(336012)(6506007)(6666004)(26005)(558084003)(2616005)(6512007)(47076005)(83380400001)(5660300002)(15650500001)(2906002)(478600001)(34070700002)(7416002)(44832011)(41300700001)(6486002)(8936002)(8676002)(4326008)(70206006)(316002)(70586007)(966005)(86362001)(31696002)(7636003)(82740400003)(356005)(36756003)(7596003)(36860700001)(40480700001)(31686004)(40460700003)(43740500002)(12100799054);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:46:26.6382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2c3bec-109e-42b5-5dcd-08dc1c4bfca9
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10329

Hi Russell,

Does there need to be any locking when calling phylink_pcs_change? I
noticed that you call it from threaded IRQ context in [1]. Can that race
with phylink_major_config?

--Sean

[1] https://lore.kernel.org/all/E1qJruX-00Gkk8-RY@rmk-PC.armlinux.org.uk/

