Return-Path: <netdev+bounces-125171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924996C2A8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33612817DB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF891DFE0B;
	Wed,  4 Sep 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="dbcXF9m3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2096.outbound.protection.outlook.com [40.107.21.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537A1DEFEA;
	Wed,  4 Sep 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464462; cv=fail; b=F5Ekj2e0+BFv16NtshXmPz1VkbT4L8khIxZtdML5KWDYzVmj7UzIkBq9LR/mlnC4TIe6ztCrybcRB57vOUFZivPNGHzWpO5liYfjjDd98uc2Xwb2UgsrIyWvPvBGt7rvId3PbSlX8Vqej+TRG5PfNj/mOVxFuBU8dWsSlWEjTcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464462; c=relaxed/simple;
	bh=Z3i7TDnwJve81J7ASp6DSvJcPTG5pCIuAL3z6VQjBH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iprKkYSNkM7IY6QEthqlHFRYetsgSc7KEm2T7pPjQz6YgBzH3Pa2/T/R0GqOMaYdKFbwhudo9mtS/ofINNLw7iema9zIwv2gQL5nmkkcC6qdF8g50chYzSCW7hJektceZPC+YrX811kvAfzAWrBApyWSlssuuEPk64mGNVM/VPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=dbcXF9m3; arc=fail smtp.client-ip=40.107.21.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg1WUD5CaqR5NzCVLfZS370Ws17RX5yOOr5HoDiy3YcEVpG/w5yEfT6g5g014pG/RaJiMLHXHgcpINd5FYLDJTwDo3SJ+Lbye6d2poOpZJFdOJASmZNfrt6uHOrGqlyG7VdHZDR7kFuN8ROVOeqN+ASPcdm+hQMbNoDljUySpd4nDRgVYcclfzHS3iVgBSnkOFvxd2ap+ye9dfMEZPELhZS7L/83LkIQLiQGdIiwCkIHtDu14fUkP+MB1rrWyuWJJQNBDT5/ImaxT4PtKWM0Uk0+PkWUgjKfvVx1OyzMJ4u4SU/DU0Bz/JsKOO37fXYkybyAbLeH3oEs1bX/UfDJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3i7TDnwJve81J7ASp6DSvJcPTG5pCIuAL3z6VQjBH4=;
 b=hlJSYJbgegoF6OoUgFKgCI50YDt0uvafGop/u8hlYScyByH1iMf2Hr+pUfbqnMmklQNh6pqGCY/AHk37BfsWCmyqinp3qpPaUp27TTkPftgbE9TKpu2lhcczcjI2BWHsk8Cnd6Szw5BpIkyueR6fnXRvyVpkJbNswHtlXazXxtvpWeRGcQ+FVzE+daz1MZPoPCWwKJc8t9a+fumJp7G/pMRaocg4JauykYHw5gHAec1pOSEgXBR7mOtgMdCu6Y2G8+3imqt/5rBvOFPz6E6RJ/aZTAWH3GGCGm7eG5C0OkU6JmuoLbsVeklZL5/Ehm33aSKZb0Waro5EdkVs7ctIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3i7TDnwJve81J7ASp6DSvJcPTG5pCIuAL3z6VQjBH4=;
 b=dbcXF9m3tRYfF9qb8ksqNrP6t5dQpj7vqv/vV7/ClDdkZjkryLzdWrAeLdsV0yXJrZ+UImguVATZH4IzvgHMfsGAGAth5L45igWa/oKKbX8isrFGTzSYE06dplL3eTc1fxAX2VLfg1syEmi6c3aWtLfvZO6057xN1+joGrgdCCA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS8PR03MB7415.eurprd03.prod.outlook.com (2603:10a6:20b:2ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 4 Sep
 2024 15:40:57 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:40:56 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"nico@fluxnic.net" <nico@fluxnic.net>, "leitao@debian.org"
	<leitao@debian.org>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "thorsten.blum@toblux.com"
	<thorsten.blum@toblux.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: realtek: rtl8365mb: Make use of
 irq_get_trigger_type()
Thread-Topic: [PATCH net-next v2 1/3] net: dsa: realtek: rtl8365mb: Make use
 of irq_get_trigger_type()
Thread-Index: AQHa/tyZejjjMWtuSUyWPRg0Irb5ObJHw/AA
Date: Wed, 4 Sep 2024 15:40:56 +0000
Message-ID: <guos3naz2r7ur5pxjbyvqkulg6e3a7xzlst374g4guv4qg2r2h@2ctrjlbw75v6>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
 <20240904151018.71967-2-vassilisamir@gmail.com>
In-Reply-To: <20240904151018.71967-2-vassilisamir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS8PR03MB7415:EE_
x-ms-office365-filtering-correlation-id: f4eea697-cb03-4a15-763c-08dcccf7f7f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THZoZTkrajNDV0s0a0lhMWIwRFZtNkNoYVZPdWVZRHNaanpSbVVyMk8xVTJU?=
 =?utf-8?B?eFlVWHBUN0NGZEk4b21zdys5UExWTkdzbVhkY1NFZDRKVzUyeGdBdzF3TDFU?=
 =?utf-8?B?TldJbWRtV2N3bDEwTkplTFJncW9PanhiVHZOeFN2SVlBeXVGbk55SEZTVjNH?=
 =?utf-8?B?bmwxMnJCb3ZmTStrR0pDWmNwTUlyZnJGOEF2a1NIUzN4bzBrRXJ0NGNKVXF5?=
 =?utf-8?B?Nk9JZDJuWWZleW1lbXNwa29IREg3Mm1QWVdRdEs1ZC9wQUJRa2ZqQzJFU1ZQ?=
 =?utf-8?B?c1pRME1LTENsTnI3ZzlTQ1dKblMzWVp5MU1rbHdUTy9KWCtYa0ZWaHVvUHRt?=
 =?utf-8?B?dFhuZ0NZSWVzekRRNDczYWNaQTBoTjlETGtvNEdEUW9JMlYyQnAwMVdWTk50?=
 =?utf-8?B?V3YzSzZUVW5VYm1vbTZSWk1aeWJBcTBSb3N5VERTVUYvaHhORW9oSC80Q2I1?=
 =?utf-8?B?TnNFa1dDMVRRdEVPR0dIdC9oNGRjcm1ZQTJpcTVIUi93bHFJcDNxaVJyVXZN?=
 =?utf-8?B?Z2RlczZaU3hqb2w4bW41REFCc0VHajFNSmZsWVNpR0xLMms3T3ZicFBnSC9S?=
 =?utf-8?B?WHRWRkNyUG95VnRJWXdncFE0OVFzOUFpQkV4NEpFb1dqOEoxWlJDa0s5ZlR0?=
 =?utf-8?B?bVJka0E5ckFnU3ZWQTFZczdVSU5GVkptSFhnWjR1KzZ1Z0FkekNQWkQ3YUFt?=
 =?utf-8?B?V0pxeG92TEFXTlNOSUdPMmZuaHFwdGpVTTRTakhCR3JoZ0FEZEZJa3JHUm55?=
 =?utf-8?B?bk52dFhFY2lyeFpQUFVYd3RieXk4akprUjV6SktsWWd1bGZ2bTlaZnFRdjNZ?=
 =?utf-8?B?UGJnZUMvL0tOaXFMRUswcVpBYlVhMmlWdUxhMDRqQTJoSzZ2Z013QTNQenpG?=
 =?utf-8?B?aGZIQUlOODlyQTFtR09Uc2ptK21hemJBdVlZeGs4ekhxUVVkc2g4T3lyUlNp?=
 =?utf-8?B?MWxVS0lFQTFxTW1LaXVpZlgwWWdVZ3BjRkl6OVd5WjUwS1hCY1F6M0I0NUhu?=
 =?utf-8?B?TC9nMUlYclJCK3c1emphcHJrREpERm5WZ0RwQ05pRlUwejBCaUlFQUlVQm9E?=
 =?utf-8?B?alpRQ2tjenBpNW43YTJBWGxBclA0aTdRN1JTamxKNUJQOVlnQVJpTFo1M01Q?=
 =?utf-8?B?RXdmTXNJZ21zeUVHTnZiY1NxNFQwWHUxdzdsME04enM4b2ZiVzhwaWppMG5K?=
 =?utf-8?B?UEJoUDl1VjFJU3JpazFtT2hSa3lvV2ZVU1pLQXZTQU1PWCtveWZnaDFKVGpw?=
 =?utf-8?B?c0F6S2JJclZiVVFJQW45VlUvSDFnREpxd09OalNQMlIyRjJ4OWlMU0pVNEJz?=
 =?utf-8?B?NU1vSEtOMnVzTVROeEhmRnB5cVZGWnZLajhxemtLcFFqMk5kbmUyWEF4aU9T?=
 =?utf-8?B?UEJGMnNMVGNlV2dxQ0M4RStMR21yUHpUbDZPcTFpYnBjWkNSQ3FQem5sM2VJ?=
 =?utf-8?B?NjFRa1h4QmRwcmd0TnQyVERmdmpOcDhnTkFZVmVEYU91WmdZcW8yYUR1Tm5Q?=
 =?utf-8?B?ZGFTaDExK3ordndyWmZ6RiticzZ2a1lGdkVVNC9xOVJkZ3BWNjRTbkxZdFFC?=
 =?utf-8?B?Mld3Tnh0aDhyK0pmeDEyMU04cDJTaEc1Tk5FcU05d0xEcjQ3VmF5RHNFMW04?=
 =?utf-8?B?ejdEOGJZUWRsVXZMdlFha1pFSkdvSHNaSStzV2gxMlZBejBOSGRIUzMxM1A3?=
 =?utf-8?B?a21EamxFKzZOODN1VnViaEM1NTZGOWVlQTl4bGc0aWJwUW9YQTAwblE4NjND?=
 =?utf-8?B?aUd1UVFhNDFJVWtjV3NQZ3oyN1NIRFc5M0ZzZVVTN0M4NEIwQytaRmJzOXVq?=
 =?utf-8?B?d3pjc0ZKbGZsZVA0Yk1ZUTM5SEdYOTBObnYxU3lRUnNlc3kvU0R0NzBkamJT?=
 =?utf-8?B?RFM2Z1FWWWE0Rm5VS3pibFMvOXMvS2xpZVRvVmVuSUFQNGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0tMM3JRRVJWZTNzUDRxYkpNTW9SRlZxaExvTmlUNzRyR1RIOFVBUDVLVUNY?=
 =?utf-8?B?UEF5b3dJZDNydmw1Mi80a2l0WHI5VzBJVkl6cE5NZDYwVHdMcy8wVHZHQ0dF?=
 =?utf-8?B?NHhHKzNKeVlmV05nbmNzVndRZDJLUVJNd20vRGFQNVhqb04zR3VISmlpWmI3?=
 =?utf-8?B?Z2o0b0J4b0lndDlEcVQ3M3lmeGVlYlU4UGpnNzdxaXJZcHZKb0kxNnBha1N2?=
 =?utf-8?B?M3NOQkQydXl4YmdWQ1VaaVRhSnBZTW91Z25mNyt1L21uZVVTNnptWnNMV0Qr?=
 =?utf-8?B?OFQ0SU5UQ20yOHlaT3FHd3V0MlFWQUVTc3BCQ2VFbll4dFE1V21La1FjcDJM?=
 =?utf-8?B?dzA1QkFER2RVMkpQdFJtYnd4Mmx4cWRaRHFkMnQzTGJtQWhWS2tuaTZYK0dL?=
 =?utf-8?B?Mm1oZ2N6SDVjQjRVNE1tVjBBdGU3bXFuWS9jRmJ0RHJPNjVXQU4vVkZiV0Z4?=
 =?utf-8?B?QWllM2wydHppejdqRHg3S1NFdkVsazBvWmdlaUpiQ01VY0hTc0gvUUVtRUx5?=
 =?utf-8?B?U3plTlJhTWkwV3pkcWZjQXJXZVJoaThBWDZ6YWNIekVMVElBWEQ1K0hUSlNu?=
 =?utf-8?B?UVNTZGJtUlhpSjUwb0c4WFFpVGN3aDRiUnQ4NThnbUFYMTFHUStBQXRnbDF4?=
 =?utf-8?B?cmN0SU5ESVpxb2ZLc3VjNlhTcjN3U3Fha3RGTkFEajNSUWEwYmZWMUZKK1pI?=
 =?utf-8?B?WWw5K2ovTjh3UTRtNWYzMktyTzlNd3dJWUJMS2t3VDBuN0pqeVdEUURTY2JR?=
 =?utf-8?B?Y25Xb09aQlk4VmIzZGY5SjFDRnVXWnVRUWxySXAzRHY5T3pwYk5Kc0ZvbStT?=
 =?utf-8?B?S3Mrdjl3RU93Yzdxang5c0dJV2s0Q1hCYSs0ZFVzb1pJM3FmTjVpQmxERStM?=
 =?utf-8?B?N3pCVVMzbmZ4WGNPd3lmUTFCbjFDYldIR2Z0SFZqcHZOUDVYSkNPbGRUM2dr?=
 =?utf-8?B?MTRTWlhLZUNsQ0hKandqdkUvTXEyNlRqbUxUUzdOdkVjTnpiTC9xTFdxRkE5?=
 =?utf-8?B?UzRpaWNyTDlaa3BFT2xGbEQvQXhFeVVaQU15aUVoOXVseFBKUllUY2RuZmpm?=
 =?utf-8?B?YlFCMTBwS2IrYkxXZ05XRExWcFlTQ3ZZRGpzaWZLYjZsc2xDODdVTjFLd2g3?=
 =?utf-8?B?ek9wbUNST2pyeUpXWThiYTE5RGx4VVZhWXhHOTlMQUlaWUxGM1BaTDBNVXJ0?=
 =?utf-8?B?NjlpalI1dUVBYi85T2JleHF1VGV0UXAramJJYloxV0FPQ2dSQ0xlWUxJeGQx?=
 =?utf-8?B?VW9kdCtSdEdNZnJyUUo1bzIxVGZJalVDanRpN1VUdGV2MWdnTjR3bzY4OWVn?=
 =?utf-8?B?aHUzTk91aHZKSUFuZTFvTmxLbnlvNkVQdDdURmNhNDA2UEF4L2U2bVBUeG1x?=
 =?utf-8?B?Z21HU2Rhc2R2ZFhleFlWR3kzdkNmL2JDNCt3akZ2NzluTXhWVkxWTHJ6QW9q?=
 =?utf-8?B?UlFxTlRaR3hJMWlTajY3ZSt6c1V4Q054Qjk5Wmp6OE85eXVUaUozZG82VUtQ?=
 =?utf-8?B?YkNiSTZsM3pkcml6QWoxSUtLVnkzUjBYb2hheVdaRVg0YWdhaDJtOWx4K0d0?=
 =?utf-8?B?aDdMUUgwSGhuNkJhS0o4ZHRZVjlFQUhpNEU1UjRXZXUxSndiQmZnTXBwUGxU?=
 =?utf-8?B?T25SK1BUajI3TUFJTzluMFRKd1FWTzgxTWpDOXNSRGZ6VXNxcXJxaklxZE1n?=
 =?utf-8?B?eWs3T0ljc3J0YzcyYjlOSTZlNVE5SG1hMWpiL3U3K3hBblVPK2lQNzk0WWFz?=
 =?utf-8?B?RE9hNW52bXZpbU9BMHQzUis3cTBuRWVNbkV4SDdFYTMwKzZIUjdHRXZEcWl5?=
 =?utf-8?B?ZHdwdFhEUEpUczJaazQxNGRjUUcwVVQ5TTdFWklwYlFTY0hhSzJ0YkNLS2lo?=
 =?utf-8?B?Y3pHdVA1b1g3emtXUkgvVGhxcW1aaVFHcUN4SFJaSlZXNnV1OFIzYlAwQWFH?=
 =?utf-8?B?cnhjclcrUCsrQ21DV2RrS2F6OENpWlZGcWZUZVhrNGk2elZHTlVNSi9aNGdn?=
 =?utf-8?B?UHZFeFJmcTNWa2NCUTQ3M0FnNHdNbCtwWUlpVUVrZFUyWDNEV3ZURHFhdXJ3?=
 =?utf-8?B?TkxTYkkrNzlReWhxamdjTEtiL2p5VE1jSEtRMFdUTU5xS0wrRGJjbU0zYkMw?=
 =?utf-8?B?dVRlQ1dhdkp6SkduL3JralhzZUFpVC9seS9RakhNbWV5aTNrVlVHSVl0MnZa?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3DDD3219503047BC87A9F9AAEBC81A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4eea697-cb03-4a15-763c-08dcccf7f7f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 15:40:56.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDKAsBC7KETjPnKS38PPKPDntPbTFULZDfC8JVx9OPq4wiXCF/E7w8p1urO5KlSNi8pz6rZANLTn6xs8P1jC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7415

T24gV2VkLCBTZXAgMDQsIDIwMjQgYXQgMDU6MTA6MTZQTSBHTVQsIFZhc2lsZWlvcyBBbW9pcmlk
aXMgd3JvdGU6DQo+IENvbnZlcnQgaXJxZF9nZXRfdHJpZ2dlcl90eXBlKGlycV9nZXRfaXJxX2Rh
dGEoaXJxKSkgY2FzZXMgdG8gdGhlIG1vcmUNCj4gc2ltcGxlIGlycV9nZXRfdHJpZ2dlcl90eXBl
KGlycSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQW1vaXJpZGlzIDx2YXNzaWxp
c2FtaXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgz
NjVtYi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCkxvb2tzIGxpa2UgeW91IG1pc3NlZCBteSByZXZpZXcgaGVyZSwgeW91IGNhbiBh
ZGQgaXQgOikNCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNl
bi5kaz4=

