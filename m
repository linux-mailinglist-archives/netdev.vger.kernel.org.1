Return-Path: <netdev+bounces-235426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B302C305CB
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9098F18C01FE
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB431354A;
	Tue,  4 Nov 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ft5CWK8N"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022117.outbound.protection.outlook.com [40.107.75.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B8313537;
	Tue,  4 Nov 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250103; cv=fail; b=i+xR4wx01mnXvXlznF1yubXpxQxibAlCKjcukIrYdCcrPAfbjqkJFW9RRZOC0I2AzDMeloWjm4JIlAZ36lwPsVLzAa+KJr0rtGgcg16GU8jARm/czSQbyzOyFehTJ4SQXO5+MJ3N7eC1JwZNrVga0WCsRZAEhclzNWT5/bYOcys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250103; c=relaxed/simple;
	bh=nte4oznBv85KJLkGimJh4CXRd5OtMnfUP9+zd8nXfsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXbvk9kn+NnwYkZkrHJ3lNCVtVFD0BHohd+Xsk12k7MS26D3DFHbicJhj8awGp01fcTaUjA+8bhRVmwj4cSL/i/xMZ0zNYfSzSEpgd5zCAxDfcAX0g59d9bjEHY0Mt2ooqZRRwXBeKoYp7XTFIOoPvRAYTzE+lUC0P/vcBxcz9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ft5CWK8N; arc=fail smtp.client-ip=40.107.75.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZDSlEZTa1DHKnJx9PbzjCb6g2CVCPCI6w0IV3Sgf3E/fxCMgSptoNP+yWcziXjkRIXZGS2xchbH++cJjlbOwd8agrJmTj/Rqjp+Y7EomII2WT7hxampe4s43SbA9OKs8pIlcR5TRmxweXUSth1Iuv4FZtusk6JBEcE2PLXkgk5+ZDBRG50Oy2zuMyO5Ebn6IZ9kIPtdxJvm7wseQt37jCJ5fkfjRmLcC1rYLT6YOeiz/qAnbwLNbenvMGztscBrvus2w0aA02+AawnUd2vjt9ya205e8CE18ArsVpOstDP8VFEt5bXRnYRL6INmTyv8+9i66+ko3YkG3+fc9GSfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nte4oznBv85KJLkGimJh4CXRd5OtMnfUP9+zd8nXfsQ=;
 b=duGG+M54dhLOmK6lA/8He1a9Fdv9jjoNPcuTlxD7cdZEQr+KCWV6oDx8Jl4+XQh/ZlBeJ95ReY6HyfxXYVSU/v9iqaoDjmxyYUvriLPKpRcbVpRHUHd9ISPQI9bPXPfuA0B1UmY0UUpJZeoABZCtMtYVrWFQEgG5pOeAuJqh3OsQFg/Ad8+gLjkw/Icad/Kauja9jchtgDghXDXNMLa7z2J5M/LLy2l8hGIWzi4KJYIMEh5sbDVjCH5zCoqLpYsWePTqH9z2Dg3hJffUoCgLWOIFEqya0S2UyXQVvHMhl4ka6t7v4zjkCzFQJWMf44ndpdr1K6+6EaB9CztdN6t0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nte4oznBv85KJLkGimJh4CXRd5OtMnfUP9+zd8nXfsQ=;
 b=ft5CWK8NL0q4uVMycx7nLO7ovez1833UEQ1iM+Ixs2hYoBueJV/zTlP5zJRMLEZZ01vIc+ClYwqDuEC7JPJZzD3Uz693hj0axZMnVvne75m7F9nrdEB27sZ4tqXrAU242BOmpnGXaUse0ClDjUlZVkZ9XaJsTME5B1f3N7oN1nPGiuFz4O1vAaiY6eii6borSz0WssDIO8P4B4ztSyVbIdNFsqLae7VacKP6lU4xaS4M8ktqJN+fOQL6s1nXPJDVH5BNqWyERa72a8SpoLmG5G2osAIvS/yx26EEMvy2fQkwnE6z7xUvpHpLckIQFOXVtGDoNovqdSadN7DEiUCsuQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SE1PPF00709BB50.apcprd06.prod.outlook.com (2603:1096:108:1::404) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:54:57 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 09:54:57 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Topic: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Index: AQHcTJUB+TmCwKSgIEaeQsrh+oaRd7TiLi+AgAAZOmA=
Date: Tue, 4 Nov 2025 09:54:56 +0000
Message-ID:
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
In-Reply-To: <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SE1PPF00709BB50:EE_
x-ms-office365-filtering-correlation-id: a5039f26-d0e6-4fb9-1682-08de1b88361e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTVmRmtadzFpVkNXbS9ycER4cURzMFhzTXVOb3FiTzJFbUlrTGdmckJJT1JD?=
 =?utf-8?B?ak1ndXF6andEZkNFTEU2eGdlbmlMM2JoeXlaR0RmdGlFdXVXV1JramVoWEov?=
 =?utf-8?B?USs1QXprSVN2L1g5Q3daalVDR3RYWnFCc09qWWdrY05VN3dFTmU0S3ZBTmRZ?=
 =?utf-8?B?VW91TVpFVVp3UndDOHJRSkRXR1ZUTTAyc2xNeXFjN1NNL0tIOUhwRGloMUpv?=
 =?utf-8?B?TjNEZ21XSkp6dCs2SGp4eEY0dXZiblQyRFgvVEtFUnVhMHdkNkZlZ01OWGM5?=
 =?utf-8?B?WXNiQUtRYS9PclZqWE1ORUJNUitjZC9IYlRUNG1RYytLQi8vazhOdzRIMFZO?=
 =?utf-8?B?OWt5V1QxRUhNR3JROEdhQW1TcWtJclNUczNDdmlZelFaYVg1cW81cnFpUnBW?=
 =?utf-8?B?dnZoR0JpSXVaSVBqeTlMWlc5TTNJR01UYVBQajJqMzhvNzIxZkU2V3hOUG9u?=
 =?utf-8?B?emFyMUJxNnR4c3psR0svaFdqMUVoUk9QaDUwRXArWEhjU3FoMFBLcFhleitQ?=
 =?utf-8?B?Z2RxcGtGclZ5c05YaXQrNmdJdm1STlBrcmlzczR1aUkydlJhemlGaXF0OCtE?=
 =?utf-8?B?UHVoWFdiZ0FOUGxHRm9FNFFkZ3pKTlU0OHJNcWdTVEJ1RGJRSlBxaXZUdWx2?=
 =?utf-8?B?RHZtRlpvZkk4alR3TVl2TE5lYWxFS3RVbUViRUc2Z2hiUjFkS1Y5TW9yMnk4?=
 =?utf-8?B?ek42cWVUVTZsQ3EzaDMvR0NWSmIvYzl4M0dxaUlKTlBpWDd5K3Uzb1p5ajJU?=
 =?utf-8?B?QkVERjRmazFrQVRjM2ZpT1BSL3hqVFV0T3R6L0wzYzVFOHZyd0k1Q0huOE55?=
 =?utf-8?B?NDFuUGtZRWJDUFdSRU14eU9IN0JacDNyNXg1TGpBemFuYnJUOUxBWlBkQ0tC?=
 =?utf-8?B?R0RaQmR0WFUraXlRS3JzbWZHNFExUEtWdnZ5ZExKZDlmSTNTbFlyendsQnBu?=
 =?utf-8?B?dkdwckszYVRRVmZxa3U4d0ZiRTBEZEhWTUZtQ2dFU3hSVnNoTHRrbDU0TDZr?=
 =?utf-8?B?TE56SVJBQk9YNzVJWTZjMWRLcGxPWWFOOG1vTTBZY0lYeElqV29FTldPREk5?=
 =?utf-8?B?MzJUSDhyZzB6Mi9jTk5CTm5qSWRuM0hvYm1JcW14ZnBHalozZkIrNWJhb0M4?=
 =?utf-8?B?aWhhNGl1bmdhVjltYjlVbERBcFpIS2F6cENEYXRlU3ROMU5Vc2lmcHU3V2JQ?=
 =?utf-8?B?dXpMeTZIMDR3K08ybHFqUVZIcDcyL0h1V2c1RlUrS1BpUlFrTmJjYTJpQWoy?=
 =?utf-8?B?U0ZiaHJhUEF0WW1seHBSSm92S2p5azQyUTlKYitJMURPZS9rditDNVgzeXJk?=
 =?utf-8?B?d2FpSmhhTXhBRGF3NC9XT2xyQWVRbFdQNVZQV25yeXAwYUVUa1ZsUmZ3Qjg2?=
 =?utf-8?B?Vng3d2ZxaDBVTGFKcjdscGRKcEdESkYyR0JzRWoxZkhwbDc3YzJWQThLeFY3?=
 =?utf-8?B?RytIYlNRaDI1aDQ5VVVlNHlqemNRdm5Ic1M1dXdPR3JiM0g5T1FjT293RW0z?=
 =?utf-8?B?SDlaOEc2NzU5YUsvdkJ2d2ZBSW43cFdHL3pqVzB2djJlbkRETGZocVBDcU04?=
 =?utf-8?B?SWtSc1MrSFZXcS8rN3hWem9ZWENaTWJNd29acE5OQnVFeGVYMHVtSTBOU0pZ?=
 =?utf-8?B?bnc5bG4xM0RxNWVqVGJjV2pYaGl0clY0cHhLNjFuSnpNN3NjVFNqcmpqSmIy?=
 =?utf-8?B?ZXRCRlNsT2Y1Qmt5aGppZlNDcFF5N2M4UDdNWmZKRERxN3VOZUpqSWJvVjk1?=
 =?utf-8?B?VDR5RmRqYWZ5WmhLWTJrM21uZWhXTkhzUEZIK2ZPcnU0RzVTbVRJR3JheW44?=
 =?utf-8?B?RkFxWnFtaTgrN0cwNmprSjlOdEUvQkdlekp5ZlE1TGpIM25CbERFVzhaZDJt?=
 =?utf-8?B?SUNHUFUvREwzT1Yxc1dkbCtLQUZOVldFeVF5WEFJR1JFcHBOUEQ3TC9NZWly?=
 =?utf-8?B?VVNiSGhSNUFSZlpYd3hYcE9ma0JHRTJzdmZpUWM5Vy92bWNHYm52UWxVeWpo?=
 =?utf-8?B?K2V2anZuS3IvQW9obDVIakxycm00Ti9IMnRzbytDWHBwS3p5bUh6YWZJQm5N?=
 =?utf-8?Q?rDdqCm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vjd4R2lKdUFhTkdYN0cvMFhudHozWE5zY3p4amZQTEt3c2dPdmRLVm8zcGgx?=
 =?utf-8?B?QmFNbXBUZjh4OWZGWWpkMi9lZnU1ZWVYRThscVUycDFMeXp6VVlNVXp3dWJL?=
 =?utf-8?B?K0RWZm81eFhRc2xjb1hhS2NaR3hOaURmWnIwY0lKTzAyc2J5TTNIYkxHZDh3?=
 =?utf-8?B?KzF4SkRKaEpFSjlEZFFlamNObWw4dmdkVGRWMW9UUDFGTFR6a2dKVGtlVkxZ?=
 =?utf-8?B?b08zVUsvNzhmSEpIbjNIQ1NoRGREc1FVQjdpSjFubzZNQmZRb3FwcXI4S3RK?=
 =?utf-8?B?TG5rTU8wdTV5NEhOZzFWNGpyVWJkYjh6Umg1SVAwTWJ5RGNTMzk5TWRFZjl4?=
 =?utf-8?B?K2VWLzQxdithaGo5SVZjQ0xoYkVUekgxdVdtNjNzaDN3UENNY2hRalY5dy9r?=
 =?utf-8?B?RUN1d3N4Z215VTlqRFVzWDFRc0lVWnREV0MxUmZjZzArTXJTRjA4RmgyWDNR?=
 =?utf-8?B?Z3J4VU9XZmV1MHJ5S1ZZUGNDRUJ5RGVkZjNEZXZ5RkFZSW1TSUNiWXZCeVd2?=
 =?utf-8?B?a2NEdkdaMHRQM2Z6UEtDanRGd2FWZXMzL0t0WG5CL3pOcjZtdW5NL3gyd2l5?=
 =?utf-8?B?NjhlcUpCMGorQmwxRG45cHZ3RlJraUc2Mis4eW9ZZm5QNGtkcUNNZ3pnUUxv?=
 =?utf-8?B?WVVkMnhvWDN6Tko5SjBySGdwSHo1amw5UFdSdDErYVAvdGNYbC90RUlYMEEr?=
 =?utf-8?B?SnZVdXBLYVV3R2dEcHFETE5JOXNCeVFUeFlhZXRwQk5QSHl5OW9mQ3NVd2ll?=
 =?utf-8?B?MG9vSXFoVUtORTNWUjRIbThsN1hsKzRxblFhclluMmlHeU9TVWQvaUlnRDcx?=
 =?utf-8?B?VFFmV0xnWFBzOVFTTGdBSkYrTVFvMEwvK1NlQ2xVVmhaTkFqOXU5dDFRK1dn?=
 =?utf-8?B?WmpGSUhaM3RRSDFCU3llZ3NUQmpmamFPNUJnQkRqa3lCazJWV0JnM0dxV3Zp?=
 =?utf-8?B?TmxMc2pFM0dvd1dCT05hRzdYUmNySThMa3V0K2t3QVo5QWNjci9vVWZLRWVP?=
 =?utf-8?B?ZG00eGQzS0RlYW0zV3BTSldDUnVqQmR2a3RHNERaMXY0SEZHSTlDNDM5K1lk?=
 =?utf-8?B?TXAwQ2tBSmhOYnhRSGowZUxwZjZlaTR6aGRhdGpYZ1RYQkNMOVBqbGlUamZO?=
 =?utf-8?B?Tnh3LzVmYklHem40ZVVoRU04Mm12S0xlbDVoRmpINzFmdGE0c0JmNTRGd2Vp?=
 =?utf-8?B?K3owNTFDbGQ5VnNhYUFLV21mdWxGN0lzQ20wVCt2aVR6QVcrSXppNjFpdmlT?=
 =?utf-8?B?RXlWV1U5RHVWVGY2SE1mTzRndlY2R1NTTWZNZUc4a0FNTUZuREd2YnFPcDg5?=
 =?utf-8?B?S1N0ZENSbnRTeDlwbDlCN3U3N3M3RHoxMGtFWXZhN0krQ1VXbzBTSFdBb2Vr?=
 =?utf-8?B?VnZTWlBBMWNaS2hBTHBFOThYN0l4RUpZeXp5eTN1dmxLVUxJUjNmcGV0enpz?=
 =?utf-8?B?ZVpmZlA1OHJVVHFGa0E5THhyemVWWXdhaTJmOUI0TEZ4WWpoNXZPdTdtUEpn?=
 =?utf-8?B?eFJkVGdnTSszVmsyd2l0bnBMMUh3Lzd2V0FXb0V2YlJabnVIVEpmYlZSUjZp?=
 =?utf-8?B?NmpXMWpMd0ZETURqMmwrRS91bTVKWk52Q0ZoNGRBVndwemVaK2VFZkZCRGFP?=
 =?utf-8?B?ZFV4dnhyekhLaURyTjgzZkJsWWRITGVOWklxanpRQStMRitSKzRsZmM2WWI2?=
 =?utf-8?B?Y29XRG4xTXIrOWQ1RzJRM1hQY1lObVRYR2JhcEZpMU5NQ3ZJUDNwY0p5cmpX?=
 =?utf-8?B?UGNrZkNpQnBLbmRPSHR4UmdQeUZ5a3pweFR0YTlXSDBUWnJITjdTUmFtSkZV?=
 =?utf-8?B?T1hjOGEwUThWaTRLRWV1YWJhY3VTQTAzQnN0UDJvcjZBNlloeGNwM2dPNmxU?=
 =?utf-8?B?elB5c2NrQzRuK0NEdXZuZHpjQVhWRVVaYXpSOE4yUU1NU3N5V1pqeTZuK2Rk?=
 =?utf-8?B?ZnNudmRFU2lJL2dNWFpvdEpXTS9HTXNsQUgwZkVySXNxVHFDdFYrYlRLYi9n?=
 =?utf-8?B?R29uUDVJZ0JwL1MyYTU0K3ErendiQWpJSUtxUkpFRWw5d3pRd0k4eFRrQzFL?=
 =?utf-8?B?Qmx1RmV0Z0xKZUlFT09DK3MyYTcvVDJybVBKcGw3dlhMQ3UzcUlrSEJhcU03?=
 =?utf-8?B?MEV4dStNdURBNzRoT0RUK2o5eWsvOUIxbU5uV2xuN3dQNzhFUmx5NmNKcVpJ?=
 =?utf-8?B?UkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5039f26-d0e6-4fb9-1682-08de1b88361e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:54:56.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jh6v8qROKSQKyggvfzx2q4lp5KoOZ+D6b/5QfhlC/GCCnO39Ml5lm5bCUDehLUXX2TvAs4JturRVym3iefW6pmUC0Je0oNzdf5b2ngZlvlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF00709BB50

SGkgS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IENyZWF0ZSB0
aGUgbmV3IGNvbXBhdGlibGVzIHRvIGlkZW50aWZ5IEFTVDI2MDAgTUFDMC8xIGFuZCBNQUMzLzQu
DQo+ID4gQWRkIGNvbmRpdGlvbmFsIHNjaGVtYSBjb25zdHJhaW50cyBmb3IgQXNwZWVkIEFTVDI2
MDAgTUFDIGNvbnRyb2xsZXJzOg0KPiA+IC0gRm9yICJhc3BlZWQsYXN0MjYwMC1tYWMwMSIsIHJl
cXVpcmUgcngvdHgtaW50ZXJuYWwtZGVsYXktcHMgcHJvcGVydGllcw0KPiA+ICAgd2l0aCA0NXBz
IHN0ZXAuDQo+ID4gLSBGb3IgImFzcGVlZCxhc3QyNjAwLW1hYzIzIiwgcmVxdWlyZSByeC90eC1p
bnRlcm5hbC1kZWxheS1wcyBwcm9wZXJ0aWVzDQo+ID4gICB3aXRoIDI1MHBzIHN0ZXAuDQo+IA0K
PiBUaGF0IGRpZmZlcmVuY2UgZG9lcyBub3QganVzdGlmeSBkaWZmZXJlbnQgY29tcGF0aWJsZXMu
IEJhc2ljYWxseSB5b3Ugc2FpZCB0aGV5DQo+IGhhdmUgc2FtZSBwcm9ncmFtbWluZyBtb2RlbCwg
anVzdCBkaWZmZXJlbnQgaGFyZHdhcmUgY2hhcmFjdGVyaXN0aWNzLCBzbw0KPiBzYW1lIGNvbXBh
dGlibGUuDQo+IA0KDQpUaGlzIGNoYW5nZSB3YXMgb3JpZ2luYWxseSBiYXNlZCBvbiBmZWVkYmFj
ayBmcm9tIGEgcHJldmlvdXMgcmV2aWV3IGRpc2N1c3Npb24uDQpBdCB0aGF0IHRpbWUsIGFub3Ro
ZXIgcmV2aWV3ZXIgc3VnZ2VzdGVkIGludHJvZHVjaW5nIHNlcGFyYXRlIGNvbXBhdGlibGVzIGZv
ciANCk1BQzAvMSBhbmQgTUFDMi8zIG9uIEFTVDI2MDAsIHNpbmNlIHRoZSBkZWxheSBjaGFyYWN0
ZXJpc3RpY3MgZGlmZmVyIGFuZCB0aGV5IA0KbWlnaHQgbm90IGJlIGZ1bGx5IGNvbXBhdGlibGUu
DQoNClRoYW5rcywNCkphY2t5DQoNCg==

