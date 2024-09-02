Return-Path: <netdev+bounces-124101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E579680B9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D880F1C21A31
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4A1714AC;
	Mon,  2 Sep 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zXV/B7U6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9A14900E;
	Mon,  2 Sep 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262502; cv=fail; b=UOWGQgN73/ua70c6V+19Ot7vR7ehVGVymnUB6w2D9QoqKer1ny/xFNwToGcnfXUdTcJVAJqjR4RQqSZhXQOqjzFWh4x0muNMOrJ3VcUb3AFyjyLBNiobZmcrYUOFbxbHltf/2S1w6cHyK1x2BAUA/wD6ZUnWiD4ptuuimqK9ir8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262502; c=relaxed/simple;
	bh=5nyPT9IT+XzPbvursygOyIOK1oatv5LEHI1d9rSuacQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fm8J2ySZHV7FWfvmhGAWoWnxf5JsuKDZyZ70aqAdLMMNqt/wnkRwgJNG1rP7L2HA+RMfXYntvh9Ssu7EFIT8EUkHmUWFdDh/zPsv5ZuSSpjSzfo+fcix1gRGnOuzb3jswotFY6K1M2iApFlnWw5JVJXKpkpD78akOMbf50H1hBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zXV/B7U6; arc=fail smtp.client-ip=40.107.104.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VICcU4wEExZXluAhAvKaHLPFDCwHFZEa/scHe0ywNvjK3BD+MDJXrXzaGYM+RGp//+WiSZDVvqVunW1/5ofoa3N5MqeFjRMkuF28oH4VGN8WdXKe3NCMhgjU0Qhi+pCNfm6qO2uXxnI9fcptFhe/esrTzhUqUm3Lj9Hlhw4ufLXU6PugWxBHqnF8A8Ya5lVYLSVz9iRtGuIep4fDRKJPBUPkeVZ85q28ZjW8D69omDzQjUVzo21ZY83UtDcLI3tNDrXV8b/2vvmEJmziLsV+l3un1T0UtoBuzSbVkwRdxbGC0qhyTHFDF2YI7tFZz3K3xJBlabPBxGHRvhOrAc39vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvZIZqaV/VlOoGzZxQAm0s96ErouO5a3aIJ/MXCBiwE=;
 b=spj2W6QOFvF3Nlhn1///p904kSkhoZxA9q/6m3K9boqM8KtdBQgoVlH8eHokmitRlknqzz0asUV/dNlem7WDlyBwa+dGFKWA0aPFk/r2bYHj5Uxyfn4JvDcRS6OrTn/sPJOjXh5U/s3/xEB7fb9/RlwryqR5+hsni9qI5FPZ0pHaKnH+W6ZjzT0ZklP72JaKRetQa5lUc60tET7Jp5qI1wyaGPlFXOYL4xT2TdhrGDpddSBirYqDxZ+wDxhriDtOZojFBeWATxns8ufX8YX+XJZ4Nb9rqKosP3c/i0cAJyBPbTbU3zkD89IXGJjWZYRTn4vcFj71m4oDqJI7qbEgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvZIZqaV/VlOoGzZxQAm0s96ErouO5a3aIJ/MXCBiwE=;
 b=zXV/B7U6ixRTVtkN6oHbL1Ym2/60ajlkQWlxuyrwndIFs52ShLgdyY1iicFZby086P/HQ119Y6sExsV9CG9x1RI3DTOJUpit/BfzTfvRrRQmxVr31U188cveEPRiA8MBwMPyNV1662OH2vmjnIX+TZWaVYYFtVYLI8SWYEbmDTf01J+Ml7nzgLb24Ywhb4yksp9Eo4M8OJQtJdP54pu/y11u6n54UlQx37gwjeEs6k45PrCWUJb6V0LKI5ooZs6ErJ+90ZwGrS311UzlArYuj1/XB/pQgcCamraIjdSdrzPnSBpWWswUQzHZjQ3Jx6b9JulgDGgzUEBnbkBCFsYWGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:535::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:34:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 07:34:56 +0000
Message-ID: <c7e618bd-c33e-4042-b769-392546cb9297@siemens.com>
Date: Mon, 2 Sep 2024 09:34:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
 Sai Krishna <saikrishnag@marvell.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Roger Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240822122652.1071801-1-danishanwar@ti.com>
 <20240822122652.1071801-3-danishanwar@ti.com>
 <8cfcb7f7-1779-463a-9e77-e0e09234a35f@siemens.com>
 <e2333f3c-7481-446a-8293-6afac14a34a0@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e2333f3c-7481-446a-8293-6afac14a34a0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 66341fda-df15-4f8c-957c-08dccb21be1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTNpMlVpNGNJMGxiclZWYVpTMVhKc3UranEvNmE4ci96RmNVcHJKMHFYMHkx?=
 =?utf-8?B?eWlmZ1dyMzkwSTdGck5GMTVrbzBjc0h5b0N0YzRVSEhZeVcyQnVVM2J6NXpE?=
 =?utf-8?B?N3htOGFCdXZQdVU3SzhRVEo3Z1BHS05CWWQ3WXJ1Tmt0ZjRGU1REZ2FldXQr?=
 =?utf-8?B?ajlvSktCK0pNSXBrd0Y3bU5UZVNlQ1NGZ3JhUmpTZ2ZYSVdNK1g1bUoycDNL?=
 =?utf-8?B?UStNbklxRTY2SW4yUmZLRjlDc1NUNXNIWGR1amZrU3BjemgxRitLd0ZMK0JY?=
 =?utf-8?B?QXBnbmUybFBUcmdwU3BSRk1qRElsQk9wczgwU253MnJEUzFUU2o4SlFNQ2xB?=
 =?utf-8?B?dVF2VFAyMFZCM0Z6WnZxOFFnYVo1YUJtdVMxSCt0RkswMjJjNzM0QU5nTzkr?=
 =?utf-8?B?VXBIMkxrTGpLTGNGbVgvMnhyWXVOaGVkaGhhZFFhY3hQaW1UWktyMXF6NUV1?=
 =?utf-8?B?Q09JYzJjUndIdTA1Y1BuUmVocE5YSlFlU2xMdjFITEk4UHVwZnBqc3Rzelli?=
 =?utf-8?B?UGpZakpEd1orakJIYVhRM3FkZ1ZZT3VtREV3YzdyMjd2cHBxMSs5ZC9PZ1dq?=
 =?utf-8?B?by83K1FLSVA5QzJXcEJBaUNtdEtheXhmOGFyNm1yTXZoQUZsMHduSHJvS3JK?=
 =?utf-8?B?WHBxblpiK1l1YjBISFZEK1ozdi9ya2RGeUsvNVRYb1g0UmJ1ck9Jd0E3SE4v?=
 =?utf-8?B?RDBxN2YvaXJHR3NPZnRLTTVuaFZQeFFaQWc0T2oxQlNxRGk4TWgyVE9xVkVL?=
 =?utf-8?B?bEJLdlAxOHNOUWJScU1VbGcycS81K1JVNjZteW9tZWIrVkpkZmJKREJtWWJN?=
 =?utf-8?B?bGFTQitqQ3VDNkdJVGRUUW9BUWlsU3cvYWc3elI4aUdtVWhiS0UvcGJRUkpK?=
 =?utf-8?B?NGdNVm9qZzB3cmJyYVZGSDhFckQ0dXkrdXhWTUI5TnhEOW1weDhLcmI0Ujla?=
 =?utf-8?B?bTFHeU5aZWJQcWR2UmtRL1hiMUZGUk1rT1hYVnF3ZW1JcjhOQmIxdW9URDdk?=
 =?utf-8?B?WEpQZVROa1ppNGlwOXh2OUFtN3JWUWdNV2V1UHgyQk01aW9EWVlUN0ZjRWxN?=
 =?utf-8?B?YXdXMUd6ZnBWUlZjWFMvaWZLNjcxLysrMlc4OWxwdXNKRnAzd1k5OWJMQitK?=
 =?utf-8?B?UGp1QUhGMk1PYTdrbHR5TDlXT1NWbWFlVE5sQzR1bFNac3ZjS1k1UXowc0E3?=
 =?utf-8?B?RUNRNDdMTUlmTExOVzV2dzBGSm9uREVBR0RDQnc0M0pXdFNKdE9KNlNPNjZx?=
 =?utf-8?B?KzY2bVlJY2tKblBSS2tFNVRkMXpBdUdNb3JUenBjaUtQZytVSGx5WGhrd0pr?=
 =?utf-8?B?cGkrZFVLY093QWU1RjFlb2VQbjZOMzZPdlMrczlpcVZ3UkdBV1BORWdjRHM4?=
 =?utf-8?B?eG5KRFJwczRUcWV1TjhhQkFFQlQ2cXZkZ2JHR3Z6bVFrRmZLUDJGUlczSkps?=
 =?utf-8?B?amdoaHB6aVdHRzFHR0I2Q3dvOWh4QmFkN2lvOUpYblR4QnBQdzBwa2RldlhI?=
 =?utf-8?B?a2IzUlZ5RW1oN0F6N2NEZi9qQ0EydXg2dURQTWx5blI3STROS1V6RnBMb204?=
 =?utf-8?B?SW5jUXE2OEZRZjQ5U21MSWpCQ3o1UVJhaUpralRJSEhqQmpNSHBLYWJsZGtS?=
 =?utf-8?B?ZU1uZkJqNVBkS01uTnFLSEVubENReitRdlFMNzNORWYvTC81QjFoR2E1NkVL?=
 =?utf-8?B?dHJ4UDUrRmFnZWJVU0pQcGw2eHNybU9tNDBhYjJGd2JnbzlqWjczQTZWaFhk?=
 =?utf-8?B?STgzbTA4cGJwVTVJcVRzaFZNblBWaXZnYzJXeG9GblRpZTZ3WUtpbkIyTHFP?=
 =?utf-8?B?MXJKbUYra1grOFpjUUwvclh4eTNUMG5oeWFjdDVaUG5yRzFvbXV2a1l1dzFK?=
 =?utf-8?B?eDVheVo3Y2VlTzRVdUhFWlB6UWo4VlhORXdkL0RqQXRwOUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHQzdUhVY3RQZ2J0eTJVRExhTkJNNFcwRGNFSE9mSVB5V2RHdjkySlNNNTJR?=
 =?utf-8?B?aHA4Y0hRelJxdG1IMEF5L0ZUb08zRnE2ZGYyZnkyeFN3SWxHL2ozRm1lVExl?=
 =?utf-8?B?T3kvdTFzZjlmTUxGMktNZklLd3JyNEJGOUgycUswQWl0K1NtL09MeEJ1UitW?=
 =?utf-8?B?SmJhQ0FpWm9OZE9JSU5tUnQ0cVlvZWlQTDIyUDU2Z1ZFOU52cXc4NW1VdVM1?=
 =?utf-8?B?dnRZNFRtb3Y2Y2J4STFvUSszVS94aWdvRXFBTUY2WWJFRk1RMkd5bUYrd0ll?=
 =?utf-8?B?bHFIcHJ5cGVYVjh0eXMzRWtidTlSb21LY1Y4bUkxaHNKZ2QxNmtpL25TVHcr?=
 =?utf-8?B?bVhSbFZ2U0hlaVNHUzNITTRkN2xYN1BVaUZaSUgxREJIdzdBUTc4djBncmpK?=
 =?utf-8?B?b0dpYXBJcS9Bc2pneWJxdkx1eWNGalZrclp2NTVkOE15SDBKc0ttaW51QWhB?=
 =?utf-8?B?bGtsVkdzUWplL08ydTRXNU45RmI1VEROUGRsY0xCeGwwdVdlbW9URzYwRCtj?=
 =?utf-8?B?WGpLQVBKeXYxNHhxT0llMVZIY0llcEVsakdaSGVQcW1BbFVwSWlTNVpya2E5?=
 =?utf-8?B?NThnTUNuT1ZHbUpPZ3hXYUhiUEw5UnRIUFdIOCtOc1RzelB6Yk53RnJERFN3?=
 =?utf-8?B?cjJSeExKM0RWVlpZd3psbjBsdTRKSXY2a3cwVkNqaDJXaGUwSG1seWVmVXVy?=
 =?utf-8?B?RUgvOGdtWlJXb2NyNytrcWUzKzE5bGJOcjl3N0trbVJSZ3VPWXpNWEQ2Vkp6?=
 =?utf-8?B?MlZNNllhWHMzcE5qdnlhN2ptdkJZM3MzNlBwTjRKOU54NkJiLzdtR1lvdlVm?=
 =?utf-8?B?ME14emo1M09TdGc5MUVpVVd2TnNFcFZZY0NEckpxbWVMeDhLNUxnMk1FTWJk?=
 =?utf-8?B?TUFJQmtoLzNSL24vMExXakx3T1BZdTcra2xiL05aRFc0ZGhVcWJuRTJaWU9E?=
 =?utf-8?B?Q3JBejJYOURpQ0pUU0dNcjd2eFhxM3J4MzBRQnRnN3pwRG45TWp4VWJSMlNG?=
 =?utf-8?B?bk1aNXoxZldiR2pZTjFXM1lWK0VjdEc1NWxiSnpOeDBQSzRGVUVYbDA0M3R6?=
 =?utf-8?B?TUUvYjJsUHUzUkZsWURUbVFYcThDektPNnVGbzc1SWVmdnJJVnFBMlVsczBR?=
 =?utf-8?B?S3pxYUFPNHoxcHFCTzVwL0ptd0toY3UrL0tnRUFqc1FMK1QzbURZeXdZa2ps?=
 =?utf-8?B?cGlHaVNkM0YzQnNOK0FmQjZSVlVyNlluVzJiRG4zZTRVYjhPeVgvK3picVFa?=
 =?utf-8?B?SXJna0tDSG1DTzNYMVY5WnA2N085T1YycnVXbFVOeVlIczhZczJ3QTBSbEtU?=
 =?utf-8?B?d3lxMWpMMDRRVWNrWFZXNDIwOW1zcEp3NmtFRVJOVmQyQ3p5T0ovR3NZeUp0?=
 =?utf-8?B?TVJLRXJiLzNQVGExbWZ2eC9DUGpiZWRwZlV2WXZiSHNaWmt6L3JmRjJuckFl?=
 =?utf-8?B?clhUNlBWSFBGK0c2bzNWNFErbzhwU3hxYnArWmJWN0RjMm1LQlhKMkkwdjA3?=
 =?utf-8?B?WDc4Wm4vSnZIUnE3ZXRRRjRpRXN4Y1E4bkNZNjIvZGZwMTFJOXNrQmdOUU1N?=
 =?utf-8?B?Ri96OVF5YWJzSzg5L1Vsc1Q0MG1jT2paRDFxR3V5a1pNMkZVVVd2czlaSjdl?=
 =?utf-8?B?Qk9sdjJFSzBaMmN3U3dhc3Q1cHJNMFBCdHV4UC93MmxwK2M4OGFYT1BvQndV?=
 =?utf-8?B?UkRUUVFibzdoZ1hnUkNVRmFIT2ZWL0JIR29TMnFSM2FzSXdpdm02dWtJSGhU?=
 =?utf-8?B?VkJuSjRhcXA3ZWc5eDNUWitaOTFyb2dHUUZrRlNkR2lwUXZrNmNIcUQ5b0Yz?=
 =?utf-8?B?MDRTcmdGVVBzNHFOZFQ4bUhiUy9rT1ltYjF3ZXU2VHFUWlAwZnBXTlpqaXZH?=
 =?utf-8?B?cnViaVhOb0ZCTGUzUzZ4NXpIUm9JZkxYcXl0U1krbE1UeXExSTVlaFlMaVZj?=
 =?utf-8?B?YjVBRDQ1ckorTklNWG1QNWZVUG5WcGc3N2FyNlB2WFJBcEJZRkcxdWhZbmN1?=
 =?utf-8?B?U2xEaDlDbTZsdmdWWm0rUW14Wk9YMzQrMWg5WjU3TFFyc3FjUUlOL0N4QjlU?=
 =?utf-8?B?MmUrbVNxamRFdkNudjdyWmV1OEREVFkvYUpUalI0bUlZc25kdE9DZ2gzVkFO?=
 =?utf-8?Q?94AOnjBvW/Oz+q0lwKqSEzw/Q?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66341fda-df15-4f8c-957c-08dccb21be1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:56.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pygld/WgnZdLg51OrYApngodwpFxldJBo8423oRi40vRwC1yyV2IhUkleX+iJyzvPHtBD8mLK1olldfwcTIBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6054

On 02.09.24 09:28, Anwar, Md Danish wrote:
> 
> 
> On 9/2/2024 12:52 PM, Jan Kiszka wrote:
>> On 22.08.24 14:26, MD Danish Anwar wrote:
>>> Add support for dumping PA stats registers via ethtool.
>>> Firmware maintained stats are stored at PA Stats registers.
>>> Also modify emac_get_strings() API to use ethtool_puts().
>>>
>>> This commit also maintains consistency between miig_stats and pa_stats by
>>> - renaming the array icssg_all_stats to icssg_all_miig_stats
>>> - renaming the structure icssg_stats to icssg_miig_stats
>>> - renaming ICSSG_STATS() to ICSSG_MIIG_STATS()
>>> - changing order of stats related data structures and arrays so that data
>>>   structures of a certain stats type is clubbed together.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  19 ++-
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +-
>>>  drivers/net/ethernet/ti/icssg/icssg_stats.c   |  31 +++-
>>>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 158 +++++++++++-------
>>>  5 files changed, 140 insertions(+), 83 deletions(-)
>>>
>>
>> ...
>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> index 53a3e44b99a2..f623a0f603fc 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> @@ -1182,6 +1182,12 @@ static int prueth_probe(struct platform_device *pdev)
>>>  		return -ENODEV;
>>>  	}
>>>  
>>> +	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
>>> +	if (IS_ERR(prueth->pa_stats)) {
>>> +		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
>>> +		return -ENODEV;
>>
>> I was just beaten for potentially not being backward compatible, but
>> this is definitely not working with existing DTs, just ran into it.
>>
> 
> Jan, I had posted the DT patch needed for this [1]. But the DT patch
> goes to different tree and it was dependent on binding patch of this
> series. My intention was once the binding is in, I will post the DT
> patch in the next window. Till then ICSSG driver will break here but
> once DT gets merged it will be alright. If that's not the best solution,
> I can post DT here, but it will need to get merged via net-next.
> 
> [1] https://lore.kernel.org/all/20240729113226.2905928-4-danishanwar@ti.com/
> 

Why not respect in the driver that the dtbinding says this property is
only optional?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


