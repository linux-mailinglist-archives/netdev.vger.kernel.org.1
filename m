Return-Path: <netdev+bounces-201915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E7AEB66E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963237A5971
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B321770A;
	Fri, 27 Jun 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="DbV1BW7V"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023142.outbound.protection.outlook.com [52.101.127.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABC214801;
	Fri, 27 Jun 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023915; cv=fail; b=tCcvargOEqvZ3/FrN2NRfJMBf6MTsTYUdsaz8BT2SMOM8pOLIQHhbumui6PY5g5rpOFQVQmjKXJ103JHBwdsC0qD8ENbJg1fgoue0kxTEAjXt6g6aRGezurZ84ZlBDoZXS/EF25T74hZFDDBgcCdlmfR3VcRZk9Ilcsd0iHB4nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023915; c=relaxed/simple;
	bh=PJ7ywejz3S0zGapqRuDhZhsN0SfDCN7L6qCHMAL47Fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TplG/1+Y2KKvkfHxmahdLy27Qc/wBlB6Q/ZAcy4Yy53dh+QJ0/Tuu0HELUJUmAJ4FR9qD4sonUZgnJslUNhS56JEPfLpsO2X9Ke4OPVxifxYTQFsSVX4kJgN5JySgMradDwpqtZNrOAunFuBQGMAGhiy1cFMv3lIQxpHq2wf0sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=DbV1BW7V; arc=fail smtp.client-ip=52.101.127.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiJKJ5QRSAsLOJOjhv8nTXDdVvRWWFCAzyy0PhrjwCbi/ul3A0C2222589q555JPNSp81/BhBC8EgPbylV91b7hVzuiJ0twrn7MWVbNUWRS1s0pBQhSA7OA/mJ48w1GnzciyNPzJk9Crhdwca1CDUcnMsE6XrnFoxCBYnc+RG10a4vi4FaCTg6XHFPL46mPqk6Gr53e2yGibNPCgYcung9oEFBX2aVW9/tBieWBzHCfcCE13K1hJKHANETa14DPTeaBkVQ/5JMDorS8Ho5E62DCiPd2L3JmVTJImT4vtQYcMYMaDiwrIyWb9fFnEqtFgwTfNj/qIeRLlrcru5affjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t9Yw8w+/iqeLkv70HVOGQbNMqHQEkuReeFKS4fstQ8=;
 b=MXSKPmTC6RqzhC4DFca7UdSUKGs8NLT9mYpmz3ayMjl1zcLWFt7PqC4FJS/0rmTGIbAnnCK8JzR4OG4ilhYy44+jkxcZj39GCUCMNiKqOx3g/iYqTdz1TRnRxDDvSw2aNWfJcfYYHy2qpwrz6qHaLtnOtRM4PNlHIEWFqmgQqsFe1YIhiy0+keHufWMkYi1cfhsRK0EXQcSkuoz9U++XXxH5YfHsV+e+3+jQJ105/fvo3AkgazZgnZbCRZCCUaEWUfFuWEPbsvfOxFV8Svi+tRWvBlewTA6oMecMerL4/WJ65NDdGbRiV0fRlYIwLUb0HMCujIDuA2R04X73N+U38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t9Yw8w+/iqeLkv70HVOGQbNMqHQEkuReeFKS4fstQ8=;
 b=DbV1BW7VRjWBttSwqVgdLMBgwziy/iRustA/zPqqglbMT2V3InO2pQb7Hz3rX4N5SrwhzRGYlcuC14LtuajOh4swsGAUzZW4uR07dQVnfKh9kjrqTVJXB3RBVX06Y2RedFn31fQgalz3UlMj3yF++OjiObMHmrp2RErWIhlFmfvAFWgSS7VP6+raTm/+K1+yO8vbrSkClhlOUy9JXW/i/ofc0Z7kI/6hJVZeOHANRowcw0UXt7Eqd7mWkAmAEYTDcg8Xt2znTAald7RhfYbxe/czbjz/GTkjB8IyvYAp83Jba2bKQyMr/iXdzgUnQ/9c+C6mMKauFiR+HC+8t98Liw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 11:31:50 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8835.023; Fri, 27 Jun 2025
 11:31:49 +0000
Message-ID: <312a1cc3-bf55-443e-baad-fd35fede40c8@amlogic.com>
Date: Fri, 27 Jun 2025 19:31:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
 <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi>
 <1842c694-045e-4014-9521-e95718f32037@amlogic.com>
 <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJYeYdggm7WEoz4iPM5UAp3F-BOTrL2yTcTfSrgSnQ2ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e3d37d-b679-4cb8-8a13-08ddb56e348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTB0R2lsdzYvS0xKSkVvVzBybThRQTZkLzhCNWxUejF6NldXOTZsWnNsem45?=
 =?utf-8?B?OXFsbkxWUTBBK2h0MndXYzRtS1FTT0tGNy9sY1hvRzdVQmxXZzBIRXZXZ1R0?=
 =?utf-8?B?RHhCeklQN0UyZGFtQS9lS2dsZUUvM2gxNG5oTzlYOG9pbElzYVEyWnhiczBG?=
 =?utf-8?B?cEw3ZkkzL1d1bWFYeGRCdFRCVkxXU0FIeVN2enFYRHg2RjhJcnVNdGY3ZEp5?=
 =?utf-8?B?RldlVCtEMlVlenlGMlpjbjZVTkE0VkhPTHhrTDNyNkJpaEQzakZ3bE8vN3VG?=
 =?utf-8?B?VjBqWW43ZVZRMmxvQlpMTzYrbU9WcGMycGdTMkxteDlGNUlrZTNkcElsUnMv?=
 =?utf-8?B?OWhBUWZZa0FSNllwZUloakJvRlpRa1JPY3JSRmc0OTFuZDhGTEEvT0xQelVp?=
 =?utf-8?B?T0dzMzFNSlQ5K2N4TlhiQ2FKbk0wY0lJOU5kN0J5MGxtV0oxU0xVUkFNc2dt?=
 =?utf-8?B?YVpxWDZMZStoSWswdDJFUGovL1E0b2VQUTZyaC9meFNaM0pXc0ZZNEU2TXJv?=
 =?utf-8?B?MGJWRXQ2ZHc0RFFNVG43N0NUNC9zK0tMT1d4NlhVTUhqdUo0cUN4V0xIU0Q4?=
 =?utf-8?B?NzJ1Zk8yN0NHOUdVZ1FBSkI1YlNZRktzRDFqRW9SUEhVdzg4eTV0cFNBdEo4?=
 =?utf-8?B?YStzMUhzT2R2b2gxNENGQ3BMUEw5LzlGQ0JiTWlONWJTZDVMV0VBMkVXQ1VF?=
 =?utf-8?B?THdjMnByYXBMRW1MUWVTSytDTGhUVFFYRlN1alVsU2pEMnlKb3g0TExSVzY5?=
 =?utf-8?B?L09oSEw3b0JyZVFGWFR5eUlxNmE4OTNvbFR4ZkRFSS90VlJaWHhoL2ZTb01p?=
 =?utf-8?B?d0dSalNyem4wNHNLWnNNckMzNEZZcjVDVmZxbm9JaXAyTWl3ZDJNUUlXczVp?=
 =?utf-8?B?bnYrZm5XaVlZV1NIRVd5WjcwNXV4MEI5WlkvYmw1alo1YWhUMGFveDQvbHZO?=
 =?utf-8?B?QkZjSTBnaVhJejRJN25LWTVML2pwdlE5ZFQvV0p0YzhMWTJZM1ZwRHQ3di8v?=
 =?utf-8?B?NVpTbW5WclJEblFuUVVaN3NSNlhneUxjSWQvVnJKS3R6ekVTdlZVMEphWjN1?=
 =?utf-8?B?Y0pRc3RsRFN3QTBLU2tNakpWTlBEMUUvSE16UGhvaHlad294N0FVM2lRaCs3?=
 =?utf-8?B?a0JzbGZ4VkpidU52YVVvdWlwWnVEdWNDVGk4N1h3cEsyZG8remZoajhPK2Rj?=
 =?utf-8?B?QjJCMUpmdGw5Nk9RcGRqNForalI4TVhXeGxmS2VhR2lidDdIejdkYlFHSkZP?=
 =?utf-8?B?b2NmZVNQWWFkTWZFeGNDQ3FpaFNNb3h6MFZ5ZWkzK25ZNFczL0RydzlrTGVs?=
 =?utf-8?B?cUJGQkE4eDQwdnd0VzRsRkZ3UUdXVVcrT2dxZWRrdkMwSTNzc293RzdmY3ll?=
 =?utf-8?B?OEIrUzRVZ0hCdDBaVGFrSXd2T25pa09KVW8zaGdiaGE4ZVdIc3BiQzlJeGJ6?=
 =?utf-8?B?L1V2a051eHFld0tIcCtBclpQMmVMUkh6dnlNbHVUazVmVTg3bm1ZbXJ4VEha?=
 =?utf-8?B?RFpTQ0tvMkpnekpmSXJKbHdlcVp5QUJ4d1djOHFDZFErUyszeFhxdWlKQ2h3?=
 =?utf-8?B?S243QTdDZU5sc3l4b1RWTGt6QmNrTGNacmhYU3BLcjluSDN6ZkdUYjFDTlQx?=
 =?utf-8?B?UlIyK0FsL1Y0TUVrdEFLZkRZSnFJTlUzRllBT2JXZHlWYlFFeXVsNWxTaW1Y?=
 =?utf-8?B?VDVSc01HVCt4UTYxaWdMSUxxZzloTkJnWThKVy9XTzZGRzU4WTZTR3V4a3Zv?=
 =?utf-8?B?U1M0Wmk3YXBLMjIwTWZFS0M2VnI3T2d2MVZiclR0VVJnYjZGMmZWREh3YVZO?=
 =?utf-8?B?V1VYUFBBOHFLam1HdjNqWXNjTUxDbExWc1lqdTNnRTYwSDR5SDZKWmNkT2Y2?=
 =?utf-8?B?NVhoUjVwUnBYcFR4azNlMm5Wd1B3KzBFTDRxSFhsRW81V09Ud1RyK2w0QUly?=
 =?utf-8?Q?xAC04erskSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhieW8xOTh3L1g4enFXR3M1MFMzelpmTjc0ei9GcmRsOVQ1WU40Y3M1NmFv?=
 =?utf-8?B?TlI3QSthc2JCbFB3VkFDTHRPZzVQWmhOUkxaMksyaGlwampuc3RaT29IOHk1?=
 =?utf-8?B?TTVTc3FlRk1hTW1FazFrOFYwVC9naFU5ckpMdHRYUlBxMlRqN0VhTHhFd0FP?=
 =?utf-8?B?V3gzVjBJWlc5T1BCMzB0QjVTc0pxUXNNOExybHdyN0NTZzJyVXE4bnBOWXhG?=
 =?utf-8?B?ZmRPVm4wOURoTFhxaWtNandlMDhoQUdwMkRlSEVKaENiVXlJeWRoWTBKUk1W?=
 =?utf-8?B?UnpwVWZNWTZHS0hiVXdoY0xUdkJxZXp4RDd3WlhrdkhYSVJaZEJvVnd3VnRV?=
 =?utf-8?B?Ty9lR2F3WHdNa1RCWC9IaGFPd21lbDA2T3VQMktMenhxSXJOWkdDdWMvMTl4?=
 =?utf-8?B?b3NWb1J3Q2JoZWFRQlRrSm5FRWpuZmVHaE14eWZHakdyOUZHeHRnbGEyL29U?=
 =?utf-8?B?YnpZZkl3NExuUlB4YkVFb1Z0NG9iRVY4Y1c4V1FYamVUOE1hZnVBUENkaHFJ?=
 =?utf-8?B?L0V3ekJHT0kwQ2ZaYVM4Q3UrOFlmeEIydUVTS092blNaMGp2SzIrMHl6N29y?=
 =?utf-8?B?RlZuRzNUQno1c3V1TTdxR0FKcUVhd0tIVFVSc1NndGhxSVNFQ1B5Z0dJczBC?=
 =?utf-8?B?aXFsMEppMFVscWp1ckxsc1RLam1YZjFDK050dXJYYzh2NUFJNU5ONFVPSWJY?=
 =?utf-8?B?WW82cGtvVFNaSmp0Tm5vdlN1aFlKYTY0Tkh0cndydzRVeFBFVUFqNGZ2a01K?=
 =?utf-8?B?Y3B1T3dKMFYyMnlKYXp6LytqVmljYlNRTFpEeEUrR2x1UTdDamVGSUNXTFhZ?=
 =?utf-8?B?a3pialFJSmRhWGlhYmNhVG9Xczk5cHZNSU9jcjg4bTBmYU13QnhDQjFKVlNO?=
 =?utf-8?B?eVlaeG5Cb1U0cDFJU2hTQkJMODhKcVloZVc1Rkx0ZVBrajFWeU9lcmsxaXVT?=
 =?utf-8?B?RSs0ckhWeHIzT0lkS0VaMldIOXpCdFRFVnBOSHM2LzFOMVpHaHYxejVPb3FZ?=
 =?utf-8?B?L1VGRnZqWllmcUdzTDF3dEdHbzI2TWF0UC9GY3RRS1AyaEgvaFhCWmVQeUpI?=
 =?utf-8?B?N2FmYzhnSytwWCtSNXYvbmdwdjl1dEhGZk5hWTJOMHVQa1orZzhpM2txUno2?=
 =?utf-8?B?V25JS3JWV0Jhb1Q1Y0p4M3R3OGlVRUhjNzhjSEdlV3dKVVNDcC9OcVRxMVBm?=
 =?utf-8?B?VTkrcDAyeGYvNGNvNnpwVk11UHFzZHIxL2pqOVRkWHk2MzdHR2I0LzV5bXVW?=
 =?utf-8?B?WW15TUVVS1phN0tGVHZYTTZLeTdTY2dqczB5WFo3SGxnWUE0b2xVMDhRaWxK?=
 =?utf-8?B?V3ZlV3ZhQkcwL0x4ZXlEMENqQlVlb1c0am9VMmN4WjExWWFaTnNBZ3hlRGQ3?=
 =?utf-8?B?c1lLT2FoQ0IxUm1FRGxzRWlTTXBHRnVDbWtwUi9qdzlyZmNCYUZLeFk5VjBx?=
 =?utf-8?B?R1BTYThRZGRndFU4SG9WNGpRd2gvR0ZNSS85YUgxZVllb0hXN21BQmVTSXZ2?=
 =?utf-8?B?cWx0cGxBTmRTbEFzMnNwMGtkNmltRlZSTXVIbVNTdHhCbjREMS9XOGcrbXpH?=
 =?utf-8?B?T2ZPRDRiUFl0QkxpVkc3MkZiY3ErV09SMzZTUXJkM1h3bjNBT0QyWnNJVS9S?=
 =?utf-8?B?L2tMb1RjZmN6cGtNVitHL3VjMFZUTWlFMSs5NmFVdTZ2QmZMVWx6NjJ3WEkv?=
 =?utf-8?B?NVdHRno4Vi9XYkExQjUvcittWUxwUHF0MGJzeUhtTVFjeXdtM0JiTllFN1Rn?=
 =?utf-8?B?RlArclNQN3paTHByRDFDSFprSjNtQWZvV3FjVEVuUWowcHMyM1AzLzlxVDZ5?=
 =?utf-8?B?elpoSHRrYkphaEM3USs3ZkV4blN0ZzVhYTdWM1ZNV2xhMkU1ZlUycGJhOHJj?=
 =?utf-8?B?TVJvNzk2US9UVmlrdzBza21qbTd6aUtvVEV3aFBmZ2laWWV4ZXRsMlo1YlRq?=
 =?utf-8?B?RWlZcGZFMU1wa1M0N3NlbHpUZEJQTFJGTlBFdmc4TmxWeVpJeWxpME9GQ21Y?=
 =?utf-8?B?R0ZDbzNmUCtHVWp3TEVXK2t4VDFrZmZLNitPRFBXR1NNT1JIZ2RRckZGRlFu?=
 =?utf-8?B?d0Z0OHgxODFqZjJic0RodjZta0xZQXYxUU5FL205YlY3WWcyUHhPdDZUakt3?=
 =?utf-8?Q?O07MUSj4Kd4QYZOkIVcV/74Cx?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e3d37d-b679-4cb8-8a13-08ddb56e348d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:31:49.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du/NdFD7yHLy1SZFtYhAot5jXIyMd/aVD3tRXfd+HkoQ1skZZ4pk48bUNK+lWcHEfI0KimFY8s475ImEtYimRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Thu, Jun 26, 2025 at 1:54 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Pauli,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>>>> event (subevent 0x1E). Currently, this event is not handled, causing
>>>> the BIS stream to remain active in BlueZ and preventing recovery.
>>>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>> Changes in v2:
>>>> - Matching the BIG handle is required when looking up a BIG connection.
>>>> - Use ev->reason to determine the cause of disconnection.
>>>> - Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
>>>> - Delete the big connection
>>>> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
>>>> ---
>>>>    include/net/bluetooth/hci.h |  6 ++++++
>>>>    net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>> index 82cbd54443ac..48389a64accb 100644
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>>>         __le16  bis[];
>>>>    } __packed;
>>>>
>>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>>>> +struct hci_evt_le_big_sync_lost {
>>>> +     __u8    handle;
>>>> +     __u8    reason;
>>>> +} __packed;
>>>> +
>>>>    #define HCI_EVT_LE_BIG_INFO_ADV_REPORT       0x22
>>>>    struct hci_evt_le_big_info_adv_report {
>>>>         __le16  sync_handle;
>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>> index 66052d6aaa1d..d0b9c8dca891 100644
>>>> --- a/net/bluetooth/hci_event.c
>>>> +++ b/net/bluetooth/hci_event.c
>>>> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>>>         hci_dev_unlock(hdev);
>>>>    }
>>>>
>>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>>>> +                                         struct sk_buff *skb)
>>>> +{
>>>> +     struct hci_evt_le_big_sync_lost *ev = data;
>>>> +     struct hci_conn *bis, *conn;
>>>> +
>>>> +     bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>>>> +
>>>> +     hci_dev_lock(hdev);
>>>> +
>>>> +     list_for_each_entry(bis, &hdev->conn_hash.list, list) {
>>> This should check bis->type == BIS_LINK too.
>> Will do.
>>>> +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &&
>>>> +                 (bis->iso_qos.bcast.big == ev->handle)) {
>>>> +                     hci_disconn_cfm(bis, ev->reason);
>>>> +                     hci_conn_del(bis);
>>>> +
>>>> +                     /* Delete the big connection */
>>>> +                     conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
>>>> +                     if (conn)
>>>> +                             hci_conn_del(conn);
>>> Problems:
>>>
>>> - use after free
>>>
>>> - hci_conn_del() cannot be used inside list_for_each_entry()
>>>     of the connection list
>>>
>>> - also list_for_each_entry_safe() allows deleting only the iteration
>>>     cursor, so some restructuring above is needed
>> Following your suggestion, I updated the hci_le_big_sync_lost_evt function.
>>
>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>> +                                           struct sk_buff *skb)
>> +{
>> +       struct hci_evt_le_big_sync_lost *ev = data;
>> +       struct hci_conn *bis, *conn, *n;
>> +
>> +       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
>> +
>> +       hci_dev_lock(hdev);
>> +
>> +       /* Delete the pa sync connection */
>> +       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
>> +       if (bis) {
>> +               conn = hci_conn_hash_lookup_pa_sync_handle(hdev,
>> bis->sync_handle);
>> +               if (conn)
>> +                       hci_conn_del(conn);
>> +       }
>> +
>> +       /* Delete each bis connection */
>> +       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
>> +               if (bis->type == BIS_LINK &&
>> +                   bis->iso_qos.bcast.big == ev->handle &&
>> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
>> +                       hci_disconn_cfm(bis, ev->reason);
>> +                       hci_conn_del(bis);
>> +               }
>> +       }
> Id follow the logic in hci_le_create_big_complete_evt, so you do something like:
>
>      while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
>                                BT_CONNECTED)))...
>
> That way we don't operate on the list cursor, that said we may need to
> add the role as parameter to hci_conn_hash_lookup_big_state, because
> the BIG id domain is role specific so we can have clashes if there are
> Broadcast Sources using the same BIG id the above would return them as
> well and even if we check for the role inside the while loop will keep
> returning it forever.

I updated the patch according to your suggestion; however, during testing, it resulted in a system panic.

hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
  
         list_for_each_entry_rcu(c, &h->list, list) {
                 if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
+                       c->role != HCI_ROLE_SLAVE ||
                     c->state != state)
                         continue;

+static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
+                                           struct sk_buff *skb)
+{
+       struct hci_evt_le_big_sync_lost *ev = data;
+       struct hci_conn *bis, *conn;
+
+       bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
+
+       hci_dev_lock(hdev);
+
+       /* Delete the pa sync connection */
+       bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
+       if (bis) {
+               conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
+               if (conn)
+                       hci_conn_del(conn);
+       }
+
+       /* Delete each bis connection */
+       while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
+                                                       BT_CONNECTED))) {
+               clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+               hci_disconn_cfm(bis, ev->reason);
+               hci_conn_del(bis);
+       }
+
+       hci_dev_unlock(hdev);
+}

However, during testing, I encountered some issues:

1. The current BIS connections all have the state BT_OPEN (2).

[  131.813237][1 T1967  d.] list conn 00000000fd2e0fb2, handle 0x0010, 
state 1 #LE link
[  131.813439][1 T1967  d.] list conn 00000000553bfedc, handle 0x0f01, 
state 2  #PA link
[  131.814301][1 T1967  d.] list conn 0000000074213ccb, handle 0x0100, 
state 2 #bis1 link
[  131.815167][1 T1967  d.] list conn 00000000ee6adb18, handle 0x0101, 
state 2 #bis2 link

2. hci_conn_hash_lookup_big_state() fails to find the corresponding BIS 
connection even when the state is set to OPEN.

Therefore, I’m considering reverting to the original patch, but adding a 
role check as an additional condition.
What do you think?

+       /* Delete each bis connection */
+       list_for_each_entry_safe(bis, n, &hdev->conn_hash.list, list) {
+               if (bis->type == BIS_LINK &&
+                   bis->role == HCI_ROLE_SLAVE &&
+                   bis->iso_qos.bcast.big == ev->handle &&
+                   test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags)) {
+                       hci_disconn_cfm(bis, ev->reason);
+                       hci_conn_del(bis);
+               }
+       }

>
>> +
>> +       hci_dev_unlock(hdev);
>> +}
>>
>>>> +             }
>>>> +     }
>>>> +
>>>> +     hci_dev_unlock(hdev);
>>>> +}
>>>> +
>>>>    static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
>>>>                                            struct sk_buff *skb)
>>>>    {
>>>> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
>>>>                      hci_le_big_sync_established_evt,
>>>>                      sizeof(struct hci_evt_le_big_sync_estabilished),
>>>>                      HCI_MAX_EVENT_SIZE),
>>>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>>>> +                  hci_le_big_sync_lost_evt,
>>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>>>> +                  HCI_MAX_EVENT_SIZE),
>>>>         /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>>>         HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>>>                      hci_le_big_info_adv_report_evt,
>>>>
>>>> ---
>>>> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
>>>> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>>>>
>>>> Best regards,
>>> --
>>> Pauli Virtanen
>
>
> --
> Luiz Augusto von Dentz

