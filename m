Return-Path: <netdev+bounces-115957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE49489A5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60330280C6F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BEE1BCA07;
	Tue,  6 Aug 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Vl7S9TIE"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336E15B147;
	Tue,  6 Aug 2024 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927318; cv=fail; b=UIati57hKfVVbzD7g9YikXyCpAQFaoHZQGpiuOc73dTIKwEn4nYh5F16EY1+5i8d6zOBYVQu8Bs5IfxeAsEIrQVfqYwdnUVdhmz09TiKQ89yq0G/1cr0giTofgZeK5HvRokBxctrfhw/HzQmtEftuEcCZPsqoZ3VqGHzYfyfnHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927318; c=relaxed/simple;
	bh=Mnt4MH4Ittrp53KanCdlKNMv29J3ve6dOs2i/joMYIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDXyvPQJBVCQOCGaf0OWITYN6S5s56ONQ1MPQndGkW96R5xVzQeHXmCwHW7l1DH6OdE2QEXoQvp+YUZY9iL5WhDANCDzdVjyvdRLy+h8hKwkM+dy3nQIhsh6XStLPlFkEVYG0g+3GFtOvVRYDYvZSktt6LTfrGCrIf1dNiNMVcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Vl7S9TIE; arc=fail smtp.client-ip=40.107.255.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dx6abgSrBjo+E3sbchVPd0V16xDQVVJTsn0wR+p7VPJq3Bycxb+haSJBSSekyARETQ8QWml3pD+pdAqIirXvQW5EjIwYfW+TmfOk242V1lwZCZwPbXcaC7k6qKuZZijesCwoIZyu4qWCiZe0Cyw2IATMwlwSsdtRR8Z9mnjDxBemf8fdRjxGAs+Td6I/BARI076fNhL3kiwst2U8NAyhthySRx1J3faDx3dcTZyx0rlgsXz4/rfx952Kq35EciIdwzTyBbCnwH1lk2VnjW7mXbn/uOxEQ1scr+6dZO4CK105+K+VLkD10do3WanUFpHhdXmRG32itvtJaB54Vf5KEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+R8DXaFbHRzdGnsVtFjGPgjQg+sbOlnaa1Tn9INjSw=;
 b=bzQ6z+mZ9VMYTBmuCQU1szwj6jDPSUK+Vdeb1Dko63X/lMg5pHJP7q9Gm3mLiYt3R5BDpfeRE4Gw6THeNCGNh8b1wxTxJKO/aii1OjdcX3jEucjx3D04DjLWc/OCkXJLp6cdD0HAV5K0yWzBzxL+p5WaxBfgvP5AWwVu9JPE7CCaTJtJhV4Q9zON4whoMDvsB9XEHJ+Ms/zdHNYBp717ARWZY/urz53Ie9BRmiJFd+6O45pLldSmAnJqirMyMmWgBWS8Jx80y1AQ1tffPYTlvbzL4EpeoKCaa6GpEJLQ0gP0cPSSYtHmyxnOL9hCFeGfEuAUNjjlVDYo5GO8FNf2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+R8DXaFbHRzdGnsVtFjGPgjQg+sbOlnaa1Tn9INjSw=;
 b=Vl7S9TIEo3jhWwdILAOAyhkRjJ2g8PhfpXff0qF/LEYQyOZGmsy0U+7mzEBdrUb0MAm8r72oXj801NWfpjpdzhUdb53WpHKAbrpSzlQjNnqiC2gycFZH4OVSEmrrMOxRlU7dLl2P+vayBJnEUvdBvtCItin4nrWxbvbA3evu+7uS13myGrjuiXLl/p8X2nxh79LeEigmF0AkExiccNjZ8xoM4+iO9sX7nDu51ti4Af2RCGwsfnn1z0gYn0Sg2s2WPhePYATBRwnbdaQff1CB/hT1ykJnzyWhUCXtV2YPWy+5EgnIx21cPpEtRDUDWi7sglGS/WVM6NYEx/xsXjiopg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
 by TYZPR03MB6471.apcprd03.prod.outlook.com (2603:1096:400:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:55:13 +0000
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749]) by SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:55:12 +0000
Message-ID: <2b044530-8f68-43fa-9545-d52506b869a9@amlogic.com>
Date: Tue, 6 Aug 2024 14:54:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
 <20240802-btaml-v3-1-d8110bf9963f@amlogic.com>
 <cf67c1b3-82cf-408a-a51d-9a09d057dc70@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <cf67c1b3-82cf-408a-a51d-9a09d057dc70@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:15::20) To SEZPR03MB7472.apcprd03.prod.outlook.com
 (2603:1096:101:12b::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7472:EE_|TYZPR03MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b87532-2895-483e-e559-08dcb5e4b81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUZRakFDbTcvYkI1ZFc1bVU1MzArMG5pd0xLVklXU01JT1hhOHpvSFFWRmNz?=
 =?utf-8?B?TzBaemxVMFVQcko2TWhBVVdINkxiMVBBdTY3RHNDN1p1TndtaXFKK3UxZTFO?=
 =?utf-8?B?SkxMWEFQRElISWNkS0dTaEJPVlZFc3g3QmtHaUU3a3lYNDVzcXhaa3N4UUVE?=
 =?utf-8?B?R2Urd1V5R0sxNE5pLzYzYnIxZWtuT1ozRVloazBLSTNUMzJBY3lvb0Q3QUNa?=
 =?utf-8?B?T1RsenhQM3Q1QkxtZGh1clgvZit1OXN6b0ZyWnNvSE9YMHg3QnBYd2w4bG44?=
 =?utf-8?B?UjArQjBjT2p1U1pNc0VJdjR1aVYzWFJCM0h3L1g5NUxDaVVzTzg1TDNqZ2tB?=
 =?utf-8?B?djNlSmxTRHdJTTd3b0xLdDF3WHc5L1J6cWtQUHhVcW55TDVmME5qZ09jN0hH?=
 =?utf-8?B?TTNWWUFYeWJES3BaaElGN2E5QTc3czVBc01VUU9CTldBS1dNNXk3Ui85cHNx?=
 =?utf-8?B?TVJ6eUo5TW1lQmFFK1l2WGRZbmRtdnRKbFlNMG51VjNHOWQxUUFJOHIwcWQr?=
 =?utf-8?B?YS9vUE5HQVh2YytpLzJQSm1jOUd4aWliRkFIWk1WTnl4UldKSjNUQ3lGRTFv?=
 =?utf-8?B?MXhkV3dwaEJNMlVCb1Nhcmtoa3hPRzdCL0Fnd0ZkOU1qam9qaEpJaCs4dUVv?=
 =?utf-8?B?QmFEQVlhcmo3by9WeGNLMW1vYjJocVozWWRMT090UEpnWVBJa1piNnJURjEz?=
 =?utf-8?B?ejlKRTV0S1ZzOXZkSFpsUlFtd2FWUnM4eHBVRFRxaEVUc3NET01lZTNxc2R3?=
 =?utf-8?B?aWVKK28yOXlUWE12NHhyTTBYQjlKZzlWd2luODJZcHh4UTRJSzkzYVRmSE5o?=
 =?utf-8?B?R1FVVGJ4R1I1cTZuTkVHS3BXa2NSa1FzUGJVQ0hubmlqREwwTkZqRG5NQWhH?=
 =?utf-8?B?aWhza2htYVJnTm9ldXdrSXI5UkRTb3BMNHhRVTBXaHM2aTdTZE9nRVBGckZ6?=
 =?utf-8?B?R2FTOENVMktxNGE4ZWhvQkllS1ZxK1l1NEc0WXIwemhONEFwbnBPZG5vc2pP?=
 =?utf-8?B?UlRvL3hSWnp0MnJEZWdlUmRHczlhRkVqVmtnSXBQcGhnZ2NTOU1mMWpsbEZ5?=
 =?utf-8?B?QVBEKzNWdkhXK1dFbTJWZnZudXcrQzlOenMxSnZLYWxRMktyMy9QSXczbi9F?=
 =?utf-8?B?WVdQRlhzUDVLMmhHamhjMzMwaHFvN3N6V096WGkzT1p3a00wSWFTRStKM2JN?=
 =?utf-8?B?VitGaWlycW8zRTJwR2I0ZDZ0eXBiV3B2aFk0R2EzREJjd2dqS1crazJHYUFz?=
 =?utf-8?B?bVZsNHFvMGRacG51N2lISW5hWWR1ajk5Z01xdmtyUkkwTGUybjJtTUxSaHhp?=
 =?utf-8?B?WFFYaVVEQmR5UFFoQXVZcE9VelVLNE5Rc0dGSXlJQmlaZkFqNHM3YUdIc0x0?=
 =?utf-8?B?Mm53VHhTdnVHQVNTSHpQejVpNW1nWEJVaHRXT2RVV0NTZUNVWFNGcjRKVEpw?=
 =?utf-8?B?MU5rR1l2UCs5ZENwZEc2Qi9OMnNBTHdFWVgwTHR3N1pXUmNVUUs3Rm8xbUdz?=
 =?utf-8?B?cXJaNGxDYkg5TVExV0phV1JITWNwYkltb2srWmZaTDlnUVdkVFhjWXU5ZXls?=
 =?utf-8?B?UWExYTU2T0t5VjJjYXlldXVFVERobHBzaC9JeEdVb0ZDSVdWTVZJYmVZSTQr?=
 =?utf-8?B?WTdKa0RDeFY1eTgrU1JZMEJVMVlhU25jbVJpUnc2d3dhTXRwZUtXUk5mYjhQ?=
 =?utf-8?B?WmJEcUswL0dtV0JwcjVyd2NOdUNtMzZkTnEyQVpxQ3dXQzNYaDdQMEZPTUFZ?=
 =?utf-8?B?L2Ewb3dreERId005TUpMNXJBTlh3QWJrTXlkLzEzUUVwZGF5U0JDUzJCdVVI?=
 =?utf-8?B?NGhhdXRIY0dvYXl1Rk5vajFsTHhiZEJyK0VMZHBJSm5PUDZaN1JHNFdTNEh1?=
 =?utf-8?Q?vu7nUZb9qzf9v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7472.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZyNHFHM0d2QTE0TldzOFFibkJyR0ZKV2NnZ3RaQjB1MUxrZHdTRnU0Mm4z?=
 =?utf-8?B?SmJoMzRkNzMzNjROaGdmWDF3ZExUVGhWcFR0bGxTbHk5dGNJbzNJc1ljc0VJ?=
 =?utf-8?B?V3lwNmJqS2NndmhpRjd6aDQyNTJrQlFGenNmaDh1cE0zeTkwb29xVmQvaFJT?=
 =?utf-8?B?dWE1QUZKb2V6bzZiLy9nRXNja1c3V2FOWUJjVFJXR3EyYmdGckFtQWk0cEU5?=
 =?utf-8?B?RHRvZllaSHJTeHdISjRJcDFUVUFzNkN3TGJnTjhjSzhmZDdFbmNjc3NxZFNN?=
 =?utf-8?B?ejdxbm0wMUkyeXVlZElzZ3VtT3BVY25LdnVpQjcrdmdIb1UrRFBkVWZwMVln?=
 =?utf-8?B?Z0tqbmNRY3VNNzJHTCtZQWt5TFJSZkU4K3MzUWxGZVNSVHl6b2Y5SUpGT3E0?=
 =?utf-8?B?bUhXbWxMbjVSMW1TUkJwREMxa3dCcHZCZm5TOW1yQWMvM09aR2U5NHNZQjdT?=
 =?utf-8?B?WDFINjdzZnQ1Y0pDRndWdVR1QmtkRXc1RUlYTEpobllwSnFaRjZaUTlUdnpT?=
 =?utf-8?B?WmNrV1FzT3NuZ2pMbTRDQ3N3WFNFdXdRcjlUbE80TmprcTZ1a0xicStWaFVw?=
 =?utf-8?B?U2I1TXdIeEFtZTUrUy9STm1zSHdUKytjbzBnQTd0cFd6Ti91SzVQb2lUTTZI?=
 =?utf-8?B?bDlGRlFCRHhmMFYxQWE3bGhFaFJjMU9aNHNhWll3YkdzaTFZZ0tqQ3VmK0Z0?=
 =?utf-8?B?UTZrOUlacDlNWEQ5Tk90RHN4amhRQXJpUEtzRnl1aU4xVVQyQlphNHdsa1hN?=
 =?utf-8?B?Sk9rZ3lWMWZ2QWRBTTYrb0l0d3oyTlNYQ3NHckh3ZTdxcjVvZ2hpMnZESC9H?=
 =?utf-8?B?T1FtWXdBeGdBd21MQllyekl4bWVUb0xaWWo2Nmc3VHF1SnZ1MkpHdm1NSXpP?=
 =?utf-8?B?SnlRalFJb1BQcUFFRlR5Szd6bjA0V25GZWJGSld5RkN0eU52QXZlb2IwbldT?=
 =?utf-8?B?eldvTFBHQWZnQVF4VEh0TDlUZ2pFMlZHanFMQTl6NG1PWFRvYUFpV294Zzlj?=
 =?utf-8?B?d2Q0cVdEbithcjE1OHo0VjBXSGNzdy9BTlVLSkZTaUdNQXVrbXBEa3dwcDVZ?=
 =?utf-8?B?cGZrQXk2azlKRU5NMmFFb0pwL1kzWGh2OXVuVjlBVXFMbFozMktHeENmRlhE?=
 =?utf-8?B?anFWeUVrT1V4dG1lZlYvZVVEY1JUY0ZmeXV5RHRjYjVUUW1zRlNEd003dnJQ?=
 =?utf-8?B?aXQvYlhxczlRME5DRXVqakJjKzkwM2lYOUFxNTZ1RkZEN2tIaTlWVlc0bksx?=
 =?utf-8?B?TTRVY3dYcU1JUVB4Vll4TWxsN3JId0hoUGF2YzE1WVVsczdzaHhLb2J5ZWEx?=
 =?utf-8?B?TU1CM1RIVGlWbDZzK2pEVDRtYldKN2ZVTHVkZStyVTYrMkNlVFowdi9DdDlE?=
 =?utf-8?B?UUppejI1b2tCazJ0TzZnUCsvUkFwZm5HUVQ3Wmt3Q0xmQWlEa0gyR0NvWjVj?=
 =?utf-8?B?cUJsOXc3QVhDSm1KQkhWcUVFd3NReVBGeHhndDhSVkMzb0RqZlhReFR6QXVt?=
 =?utf-8?B?RlBsd0NNays3bnRkUUl0aGlyTExTcVl4aVRiSkRmNVYydzB2bUJaQitSUmp6?=
 =?utf-8?B?TXFLaWRCMTY0ZVhDMDloYVFYRkhKUENoMkZZbWtkSW9TNVpGbnFBM2xyMnVt?=
 =?utf-8?B?ZDdKcjdjcEVuVDNwSFRnTGhCOVJBSU5vRXluMU51RGhZclJkb241MXZvM090?=
 =?utf-8?B?N21WQVhvRXMwTDc1eHFZWlBUL0tqNUZFLy9Pd0xUaWZHZ29CTzU2RlhEd3or?=
 =?utf-8?B?bHVLdndNZjh6S1JJODRQN0JQTFhucDlScUt4dzV1ZVVuOSt1K2tkZHdxWjE0?=
 =?utf-8?B?Q3JIb25QM2lZa3h4S00xY3FwWDlzaVhPcUw2eTc0YXBEOG82R3RuRzNJRTVl?=
 =?utf-8?B?MGZiYm5Ed01GVDZlMjd5a1RWdEV5OHgvZTIybHR0SnJaazQwKzY0VXhQS1lT?=
 =?utf-8?B?ZEhwYWV4Z1Z1cXNCSkpzMEVHWGhBK3ZCZlRJQUNWUUs5Z1c5eDJhSGZjNnkv?=
 =?utf-8?B?MmllV1JabjlLWThlVU5pVWR1Ri9yanZWQzB5TFVYcW9uWlk3eXRjVi8wbVlJ?=
 =?utf-8?B?d2ZNNDFvWEpCWklLczFCaFNHTjZJMG5iQTRPY1JSVVRaMnV6OUYxMVo4Mndh?=
 =?utf-8?Q?EHAQgPz5CISazDebVNLAfuQCD?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b87532-2895-483e-e559-08dcb5e4b81e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7472.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:55:12.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omYw4iFiglOaNZAckg6m2JRw3uGNRbEb5i/6Zgk1TuBifuX7bRuXYKQDaLOYknW1m+B0uo6GM+SNxqjBgBWSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6471


On 2024/8/6 1:27, Krzysztof Kozlowski wrote:
> On 02/08/2024 11:39, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add binding document for Amlogic Bluetooth chipsets attached over UART.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>
>> +  firmware-name:
>> +    maxItems: 1
>> +    description: specify the path of firmware bin to load
>> +
>> +required:
>> +  - compatible
>> +  - enable-gpios
>> +  - vddio-supply
>> +  - clocks
>> +  - firmware-name
> Keep the same order as listed in properties section. With this fixed:
Okay, I will do.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

