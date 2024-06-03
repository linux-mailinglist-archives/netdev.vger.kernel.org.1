Return-Path: <netdev+bounces-100263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C878D8546
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1628C766
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA512F5BB;
	Mon,  3 Jun 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="XhHPjegL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECD12F596;
	Mon,  3 Jun 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425538; cv=fail; b=oxDEap2ysZ7xp9sHRsjwY9WAamyhGoFCZK9qs8xui/YlebZsTOu9u7M2v/pUfHoqAbhKpMrEjVW0YDVwQcsD2gMpufsk89SrLN4X9LbEuStkIx9c1xGdIjx705qzRtVZRC/QrVk4VbxzJaYsAaqEwsxGC/5C23LIRQt1k6tt2BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425538; c=relaxed/simple;
	bh=Cl/cqVYMy6z6/hBB6c/2mdHl5bdeSNkMhl1sdTx2fdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JGuCj86r379PQFZ9zGC2m6mfhYqOh96weYyphdiNxGskPLICFszrsvYXx4MPUWq1e3Hm3lJULIqOZSGEiwvsp6KXm33HScTKhFisRa3VGPB5SE5LmdbnppS4ERAdDsemQz1HsF1GsFNAejuqPA+80oaUXYIhEo7b5ljAKzL+Krw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=XhHPjegL; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOQHW9Oyw70ePVLLaJukdTf6wPVccj0YITKu+zG9gwyPkH9a5z/28np9eprsDdWCnpQowuIeVIuXNgF/5VZIaWqVBggA1W0B9cmaU23bBIrGQTKPPjHDRc8WcBH4XDuIQiFRRgo8KIrKmIXqoZOqn2laPspEhc4k3SQsTdd1t4qeUBI3Qdx8Ze1ifWttB+iTk3mFsbgCUwA+dXs28Gml+U2qUSGpqG+PHVfGJWfUCuQ853pxWilKxyhqZW0FAzPadCd0dlBTkbJw+3KSLIOi/QkiGi7h2OEQrpahmsVWsgPx/Amb9kS1FOVDgy6YYwNDANbAIzwLD+3sHfpECmKl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i/XkeFDEtPKI3qhluPcRQuvBD/YTSFUubs64E+zfe4=;
 b=iKaKuOUrcc8jV7xT3H9SOn0eZrUmK64ah/4be8AH8aKnHZx8q4wEtHEIKaH3FbHqMqjhm5zKusshigSXOxGJXg1luWW3+dVdmRIqDIBPaqt4ugflmwBiqfwaf7kQ2JMl+l7ctnAjd6zH8LmLZ+oCUM2CkUlNBStxAEFfdTCRIZ8tzU+a48+G3QY10bu/PNq1KU8CxJOiSxPAXmPcMA6tWYHkqe+PA0DaoKRtNtbYC5V3c9e7yR6ay35DQYSnotRoT+mctoQ73BMhFpAccjhsYjp8MlJ+7rU6O5aCUtXBa6YvbH7nslsZKRSu9zNH8zizzCs6NbvZXPTZBxi+fThQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i/XkeFDEtPKI3qhluPcRQuvBD/YTSFUubs64E+zfe4=;
 b=XhHPjegLRc2tplg0xw0oUZ4JIuAS0YNlyG+9glW4gnm5zSVDXo+VF+fVm90efUJP8FgAv7BbdfdBOEJs7ATHVjbVv469BT2k1kaf3No1n+JQ0OhbvPobVL6IYNxxBkZxK9vlPfQC7wNCkWVb9AAEwKVrn5r67ZMP3pO6GR4BEqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 14:38:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 14:38:48 +0000
Message-ID: <9bbcd934-1d47-4e98-9e02-9ed18242bf1e@prevas.dk>
Date: Mon, 3 Jun 2024 16:38:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] net: ethernet: stmmac: add management of
 stm32mp13 for stm32
To: Marek Vasut <marex@denx.de>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-8-christophe.roullier@foss.st.com>
 <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
 <a992ecc9-bbb7-41af-9a0a-ff63a55d1652@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <a992ecc9-bbb7-41af-9a0a-ff63a55d1652@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1a1e7f-1f38-4200-e112-08dc83dae12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHk4UkQwZDJFeUxySzRZUUxMMnFpVnRTNHJxcEhQRXphQkdQUm1wTVNCdGV6?=
 =?utf-8?B?MDJhUEt1eGo1WE5LR3JyWk40OE5SSVM2ZkpVM0xtTzZJK3ZEemc5S3hVUlk3?=
 =?utf-8?B?OWtZcEhBMTB5Z3pNeHAzeGJIaEhqbVY5eHkyS0FGOEF6d1dRZU5TNVpIeXFY?=
 =?utf-8?B?NlBzN0FXb2xRaWZ6d2loWEcrVm5YNFBTUEN1TWdqWHJqblJSaDJSUjlOM0pU?=
 =?utf-8?B?L2JTL2Z3OWNSUzVVam5JNGVuREVCL2h2OTEwaWxMZmkrbGlvWW5sbDJRbkxX?=
 =?utf-8?B?dGw4Z2U0ZGNRdURRanpZd1BLTHBnTFpDNlJocVJPWFBLVTA1MGwyaWQrOWFs?=
 =?utf-8?B?cnRua0VWeTkrWG9wamE1Q3pHa0h6cDdKUXlUa09TdkloUUplK2NXVWp1R1V6?=
 =?utf-8?B?UjFRVzlyOE5SUDJqcTk4R1g2dnpBYXVDK3RWQTEyeVJmTUEzcklud1hiZFVu?=
 =?utf-8?B?VFR0Tk8vcG4yWVVrYnI2SVdLOHNUTUFSOUxFY01HRlgra052MXJiODE3UHhL?=
 =?utf-8?B?UHJDNlFTT1Y3UzhvUzFCakExem5wNTkwRFUwbWQ2REtoeHd0aTBkenI3dGNM?=
 =?utf-8?B?UCtRaUU3amdyNnhYdFdyUWh0UU9JWmEyMXZ5d29YbU56MmlsYS9zaTF3MzZs?=
 =?utf-8?B?ZytERnpJVmdTMUwxYmx1QnZiNGNEZlVPUkJXakVXeGFNU2J6SkRNa3ZhQnFN?=
 =?utf-8?B?VTQzdEp0bThuQXdpYWtoeVp6ZEJBalFLS3NvUU1lM1NvRnFmNEV2UU1YTWVW?=
 =?utf-8?B?Mk9mY3dscENCcXVMKy9uRDhqNHg3TEl4d0VUeGxHQUZ6ZGNXRXdjcHh6aWdV?=
 =?utf-8?B?SnJLY05aRXhxWFQvZk5GQWtjNWxaN2JTRi94RkRkT255WnppT0tqMnpLM0tR?=
 =?utf-8?B?aUgySEdTL0pScHlHV3BLQVJHRTRwUURRWjZzYjR0RnY1Z1B5bW0xYld5QURa?=
 =?utf-8?B?ZGpYYzd2TjZDK0lodnJEYjhqTGdtMDcvVmdyRXozUUZ1eTl3aUdMd2grSU5w?=
 =?utf-8?B?QldLb1R6SkJmaDRua1VBdTFmMTQ4TUN4ZlNUR1R4dTRNZU9LSFJxbUphS1BB?=
 =?utf-8?B?aDN6TCtZUTJGNEVFODhhNmJ0emhOcDhBbHZzSGVDZ0krZWpTamFhZFVZRTRI?=
 =?utf-8?B?M1pNWUJZV01RYkxZMmRQSXJIakc1ckxweGh0eVVDaWVyMWR5VHFLbEtRdzdp?=
 =?utf-8?B?ckR6K3Ayb0JmZ3hEdnc2OU9oS2o5bmtkWWtUcVVmYjBUYVFLMkVKQ3A1KzJu?=
 =?utf-8?B?MUJHT2htZG1iVnJUeVJ2R2ZXS2RJcVJORUVBWGJyTyt2Sm5MSGVYME1YWjNY?=
 =?utf-8?B?Z1dRQ3dadkNZM1U5T1N4Z0ViNDhLY0xua0dYalk1VnlwcWRlaTlrMEVVWjRu?=
 =?utf-8?B?UUZUbGU1RlJqZlhXOC9NOHg3SGRieVE4SDlBQUFoampITytZU3ZnWldTK0s4?=
 =?utf-8?B?Wit6R1lvbW8xUjNTZS9MbStoWS9JU2x5cStZbjRUL2EvMStSVEg3RTlqd3JG?=
 =?utf-8?B?clF1blhUQ3pIMDF2WWNjbjdMdDNEVE81bnVTR1JGWnA3WFpzbDFjeFpRRk5L?=
 =?utf-8?B?VUZkTmdENjlpckZ1RUlGbWZKMUVHZmdpcVQ1aCtpaEtnbFhLVjFVNHd1QXhx?=
 =?utf-8?B?Uk5CL0tpcGlSRFNneG1hWWJQNCt6Z3RUMWpnZ09NckEzeWkrV203SnhJK1B0?=
 =?utf-8?B?UGlpczR4Y2VZSTR6Y0tZMXNUK0ZUYnU2d21ueW1JNUlLOXZEUTVoVUdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29wOHF3dGkyRGQ4L3dlYXZINzhXSTROdzc3MkZGaUhCWGJjcFRWS0NEbkoy?=
 =?utf-8?B?TXFUVVk4aEpzN2k3K3dGWXpPL1NoRStqRWkxQ0txY3B4cDNudnd4VllRSVhz?=
 =?utf-8?B?VmZNNmJibGpZbTNtQTVhSUVQV04vQXRZSUNhNEY4NytzMEdTZHRacXR4ZVNz?=
 =?utf-8?B?c0pGK1NJUUU0b1ZoUjZQalhwSnVrVWVjV1F0aVhIY3VJL204MWt3TW1Vem1X?=
 =?utf-8?B?bnFNZWxGMHVQOVJNQUluN0hmZFlHZDF3NGdPRVV4QTE1QmpGa0YvcjdiTnVs?=
 =?utf-8?B?U1RFdnozSm5Od2VydlhvNDB4ZUgvZW9ZeU1JZitueFhQU0RUNTFkNW5aVlNO?=
 =?utf-8?B?QkJVTnBtaVA1OFNSYVNKTmtKYWNBZGM3VFlkUG5MdFlzbkVndkVTdEk1TlJu?=
 =?utf-8?B?cmYzcmFDOFJYK1RjZHdhSnZ5UlQ1dmJzZkVyVXN3Qys1Z3puYlhhNXlKTjRw?=
 =?utf-8?B?SjdSNzRCTzlKNnRZZWd0c0ZDZGpWWjBTTmdiTkdaazRDNi9xZU5PWkhmY3RZ?=
 =?utf-8?B?a0VyRWpWZ2ZHajRGRkR2cEw0OGFpRkgzTWJKVVVJWi9ETFZwaCtRMGx2ZTlm?=
 =?utf-8?B?WGNTajlVcU1LQzdJUzFxbnVLeW96WVJ2MEFoUWVpc3RCcy9lQTkwKzRxQnpV?=
 =?utf-8?B?VGVxcUc4and1dG9oK3Z5R09MSlFWSGQvTWhKWW4zOHVlcFFoSVd0TzZyM0Q2?=
 =?utf-8?B?RzIwMG5ucnN1V2ZBS2lWeFhHaDdMVVFUUTNzdVZpV0NQOXU4S2VIcnVNcXVR?=
 =?utf-8?B?MjRibUFCZXZ3M0ZyZjl1K1NDZGxxQ1ZPd252Qkc3NTFtRnZ0SzkxeS9vOWky?=
 =?utf-8?B?M0UwWDNSOHI1L2VJQWZQUWt0Z3UzUDg5dXh5dDJGd2FadHdSNDFURUxuWG1K?=
 =?utf-8?B?aGlrVysxQ3ZOMXNLcmJ1LzlvSzVZQXIxNE1TR3NvNk9Td3QzVzZiTXZNeHhn?=
 =?utf-8?B?dW5HU0RaajYyM3k4Z3ExNTZZdVcxTSttYjNqSWFteW5UR2NOVVE2NmxoRGlS?=
 =?utf-8?B?VVhpd3hteldNWUdNR2xVM05rTCtsMjdlbjdaTDdhS3c2RCtDbThETnNrdlRp?=
 =?utf-8?B?aW9VenF2YlFoaXFIS212QTFvSklpenhUUm40YVdJTEZvaC9RRlZhVDRRWm44?=
 =?utf-8?B?TTV5QlZzUklxZnhnYU1NdDZObUJlc0N1Yyt0Yk01NWlHVytJbFB6YWxpQVMz?=
 =?utf-8?B?S0ZKbVhtV0dIZ2lrK1gwZFFkODBGSFRzbmorZ3FuNU9xMnJjbXlJRlZXNzRu?=
 =?utf-8?B?b3N0bG5qYU15VXBNSk1aTFpUNjQvZy9xOU5NVmhVeXZCd3VFY3BzNFBWUlNJ?=
 =?utf-8?B?UkNnZWllTDgrbGU2T0s5ZHJtUldhZzFrNS9WWkN2VGk4cWRZWUVBZGVOa2dP?=
 =?utf-8?B?cjBYNERrU3Z5Uk11bHpvenFHRWc4dkloREo1eUlUMHhLRFhPVS9oVTNNMG1J?=
 =?utf-8?B?NnNpcDJacjJrbnNlZVZlK1M4ME52a21vNW1JNXpDeVZPTGJNSnFSRWFoQkEx?=
 =?utf-8?B?Y3hSMHVoQTdOOERwRkpiT1RURGlXdFljQ3BBdExtRVUzaExPaUpUcm9yTmdJ?=
 =?utf-8?B?ZzZVbVFKOTFaMWo2dVRZY1hQay95VHdadnJQa0FUTDN5blVtbTZyVC8wcVg2?=
 =?utf-8?B?dVIxNmg5NUdYbnNidkt3aWdmNUN2SmkyaUM3NXdzRkJaaDQzaUM0WmtzMkFK?=
 =?utf-8?B?RUlqdFdJQWxyUmF3ZmRxbnhkdmRPTVZEZ1VCVkNuUUtFblVmczU1b08vY2pI?=
 =?utf-8?B?MUo4b2dOcGltbkhEeGRqZTV1U3o2K3Zic1VUOUNVV3IzbkdxUzVZL0xGNjJI?=
 =?utf-8?B?aU90WCtSa0Z0TjlhdlFVZmdFTHQ4Mm1UWEdPNmtSUitDdFM4ZG0yT3ppaXF5?=
 =?utf-8?B?RUtJSkZVemNFWVhVWEtpV0JGZXg4REpUSTZxaVlhNDZrckM1dmpFa2NpeWpq?=
 =?utf-8?B?WlNmT0g5YUo4OWoyVmVzVlZXUU9lRmVuNnBkMUlaNVE2Q2pvYnc4d0Facjlu?=
 =?utf-8?B?QTROQS9qRy9pTDBEd290Z3QyVlh4eTdwMDJwT0ZFZHBjRm9abGtvTFdlLzIr?=
 =?utf-8?B?R0xYcTNKOTI2UDB4Qi9hU0k4V1Y3WjAzYTMyRkc5VEdLalc3TUZ2SEN4NElt?=
 =?utf-8?B?RWJmRlk3emFoK3hlazdyUjJyL1g1L2NKcGFNK2ZpMm0rK0JCS3FBUitaUVFq?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1a1e7f-1f38-4200-e112-08dc83dae12c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:38:48.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0w08XV4FVrU8WBcqYbf73hivMFABUWNlEAajwYcYftR5/KOZzi3V/4bXFPtM68LCunR+TLF9qfoEM/SCIXeXZlAhIdGUn3H2TNbpDNlLAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520

On 03/06/2024 15.01, Marek Vasut wrote:
> On 6/3/24 1:30 PM, Rasmus Villemoes wrote:

>> Also, please include a base-id in the cover letter so one knows what it
>> applies to.
> 
> Just out of curiosity, I know one can generate cover letter from branch
> description with git branch --edit-description and git format-patch
> --cover-from-description= , but is there something to automatically fill
> in the merge base (I assume that's what you want) ?

https://git-scm.com/docs/git-format-patch#_base_tree_information

Seems to have been in git since v2.9 (2016ish).

Rasmus


