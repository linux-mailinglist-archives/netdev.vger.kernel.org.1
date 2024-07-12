Return-Path: <netdev+bounces-111054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22392F970
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AF42843DF
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD215D5D8;
	Fri, 12 Jul 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="p4oz08pI"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E73D512;
	Fri, 12 Jul 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782871; cv=fail; b=AibDxtE+NWX93tTiYgKhulKX+am864m7ifii6aDMOEwzNOnS36DILVklalMWPD2lLPKieFfQAoHjT4xkJ9ncwY2BYFXQ/ETFpRwDu6kp2rPQI3HZH/1i7WajKFQcNUQ4uXW69jWEN2hN1dUzTj6D4qrzQlpmZuaSjJwfzgrYFJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782871; c=relaxed/simple;
	bh=HxDc4h54mW+o2EtXbXSYLa44u3wgTvEPo4mGVPdXSN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dCDU9SFg8qTKsIa8bNbL5Bm6n7MvVTSM3Z0R/M657D1SC01U6CyOoCTUngDhSP77TTmT3jFvk4qoFANNn0HFxLwGz2ia7vKg6BsDcTRxdgTukmJ2Fd4kBuB064/7TA9EhoZr9TZW7ixT3O1qOvnLXA4A0nehJ9rKe6ysj3YGi70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=p4oz08pI; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZzUz5ceCA8a1fhj8QCJtJU6qQll4NmAEC+QrqYZ1xsN1RzkmmSe9NDSnV7CBIMWFm3AJoabQ9kDeBbENVzhWrcGmun0+kvIuR/+uZ/9T8WxABPSI+Y2T4/39VO5ZuxC+a7EctYbvrDtXZFAQBoDABoej0Meo6OajyMlwVXomjynbvl6uVzRdEHw3ocmSPlD+2KkgnKkxpEKlNNTMSzP8DHi+aaFfbe17QBouIHbT4TsLZL0Wf8i2uMKzEav+IS1reqxTqY1dl1lpLJzuUcDLUVYtPsuAE1Bn0ffVPbKMJgrMWUYOaLLhbzZprXBUYvWjdM9GCeW2tHqs6MgdpTs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTl8aIA+tp//BrUX7fM9Th//vUWlCclcRDVfE00hbuk=;
 b=IUmyK0cPfoQg+bpXmml4497hFIPiIgQ7I3rtEHkl4Cx4n//nS7c2a5Y/D2UzFJB1rg3RUI20wVq99wlOZbffmFHN5QP/YaDG/reumJE5IaM+ekL18i7g1KqHMGmN6i/K7Vg+ENbE637H9/ePzUzlfP+Me4YTlDuZiJlQ+mhheOGnioEuroVROj5dcOI3s8pORk3GmnfFpkwqsNJRWzl7Wlusk6OvYpR2RUbIUhd17yfUHC2S0i+rjYgsG8laf1ggiH9DZYkAZIejLNTsbOU5neI2g92/v7+EPRde9zXpgeTg3WMQ7gZgCpedxD1QmQg2IN80OWAtvCW4ekfLqkxF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTl8aIA+tp//BrUX7fM9Th//vUWlCclcRDVfE00hbuk=;
 b=p4oz08pIx1LifzmVpp/am6frbeoju8vCG4OEeHbkBow142CAbuz0FLHGiBhNzHNJMjme4fzRzSiHv89zFCOWJnGhCA39TyLY5C+Uvy+EzfBSQAZlQ2xhYsARyTQxgVouDTILSLiKAJdTAGKC9VFGDOc7pjkLUje1/6CAZdfsTsoLbQKSCHweq3e1TimDU4R+3wGGsyyF2QW0DRZolxmTsr/eVz+QiFzAVvQH218HpH1Vv4BOJFqxhr0yNztaOisGQXlpA3uwj3cGjGiz1ub5BXjKhq5jIcENJRHSyM1vDdJriC4hpqhQWdduitf0A5lyzsoUbq32hBTKQsH+/vvTRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB8282.apcprd03.prod.outlook.com (2603:1096:405:21::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 11:14:24 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 11:14:24 +0000
Message-ID: <338eb673-0716-407d-99de-ec1ba6502d01@amlogic.com>
Date: Fri, 12 Jul 2024 19:13:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: defconfig: Enable hci_uart for Amlogic
 Bluetooth
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
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-3-7f1538f98cef@amlogic.com>
 <98f3e5d2-f0bc-46b8-8560-e732dcbe8532@kernel.org>
 <5b59045f-feba-443d-b90e-5b070e14e154@amlogic.com>
 <e5f639a5-d16e-4213-a369-8f9b2988ecd4@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <e5f639a5-d16e-4213-a369-8f9b2988ecd4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9febb003-9879-4c5e-979f-08dca263c98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akcvRVJmNkNFZUJDTE9hM25jNTVCYUJGMUhmSVAyY0VVRzdicE5Bd1R1ZGc0?=
 =?utf-8?B?aWVCcWt6NFRJaVlSRFFnUU5yeFozNjBIcWpRZFQvUURJSEkwVHo0TnhOd0pY?=
 =?utf-8?B?ZXdOeWJ2QStMKzVmTFZUUVoyRC8yZDR3anJmQjFEamgxTG9BcW80ZWVsck1L?=
 =?utf-8?B?WEhDeU5zSVJHNVdxNlNjQ3AvN3ZxUncrc0hhdy9XU2ozdFVTdndlYXAwQWdY?=
 =?utf-8?B?ZU53RzFxYXRzdEgrb3JMWnMvNmV1VE5pb01UYUhwVkYvV2xHWjkxM0FOajRV?=
 =?utf-8?B?azlTVVlYUHhwd0R6S1RhMXB6UzEvdlFVSFhyZ0p3V2pCZTZxWFdFR29QeEtZ?=
 =?utf-8?B?dzlRUktmS3JobmRVWGhSKzlOSGV2MjNvSmpBYkU0RTlteVRPYndHWTdHWkpZ?=
 =?utf-8?B?cGdINm1mMkpNVkZEZXVZeEIrWU5rRDdGWVllSkNaS0tSdFZuUXg5TVdlcUtr?=
 =?utf-8?B?T1diZjh2SUJKZ0hLU0dEQWlETmRRdnh2NTlVeWpya3Y1TGY3VFhwLzR3WjVQ?=
 =?utf-8?B?d3AvWlRxVnNERzV3QVJRdDluTHF3UGRjRHhnWnRhS0FVYVYxZ1NXWW1KREdj?=
 =?utf-8?B?REhsNjlsbWxvRkF6Q2JQNDJYR0M0anI1ZjFxSTI4OEo5TmtQS3l6M1FkeEJC?=
 =?utf-8?B?RFhwSnE3dm9vdDlTbWJiVnhOL0dReWcvS25ZNnBkN1l0WUdsN3VuMitJWHJn?=
 =?utf-8?B?STFwMjUzakdMVExzUnR5ZDI4dDJFQXliK3BCZytLcFljbEZ1SGttUWpEMEg3?=
 =?utf-8?B?K3U4UDRVZXRSRUJUNCswOWdpR3VvVkdKR0IxSVJhVDVVejdMUlFCT2FSMjVz?=
 =?utf-8?B?UEdFZzJ2alU3b0hFcTE5RXh0a1JKd2grS2N2cG9odmhDaDZsczJMa0RGK1FJ?=
 =?utf-8?B?bzlNdHpXbW1CV0ZIdGlWNVcyZzRYVnVPclNUUjlIQ1g2eWhvYUhoMjBqNkFL?=
 =?utf-8?B?b2JrYUVLQzh1ck1aaFVYL3IwMnFOQ0orZUFTZFJmWFdZb21HSW93b3NPZVJ3?=
 =?utf-8?B?My9Ob3hBRnZlS1NHRTU1L2tzT0szbnJkUlNudGs3d1ZQaFBlOVhtanRMNURD?=
 =?utf-8?B?OUt4VWkxOUNWRXpWR29HOXk4bEFRTDBxU2s1djI4ODYraTdwQzlSNTk3V1dB?=
 =?utf-8?B?Wk93SnZGT0VPeTEva3dGdldQTm5HdmdIdWhKaC8wTXdYY0RMRDcrbzV0Rlp6?=
 =?utf-8?B?UFd5TXNsc3R6NFhYL29UazBnV3NrSTUzUEZCd3VJcEtjNU5tc1V4MzBZU3ds?=
 =?utf-8?B?a1hxanpGcHp5TThuR0xBOXpVeFV4RHFldGxtNm1nY0Ixc3pKbjJLOXFWc1hC?=
 =?utf-8?B?V2hwVGlVVHdLRHBiN3YyVCtlTEMvZ2xMMTA5WC85Sk8rdzFNNlRGaXRiT2Q3?=
 =?utf-8?B?aERFZUVneGxYL3JzNmQ1eTJ1a1dHMENZUUFjeUhhMVEvSjRpVzRZblA4bHBI?=
 =?utf-8?B?NDA2VzREbngyNytDR2lSZzJRYmZFbTZiaFlpZHdxc3dKWUhyUjdFaitUQ3VJ?=
 =?utf-8?B?M3F1UWgxQWZVcmFhZXExU1FrNnQvSUdJbzBpd1VYMVhpU1htZ1BLcWdUcW53?=
 =?utf-8?B?bFJmUk1xWm5Sak1DODdCRDdVa2VDOWszMVYyNEc4L3hLa0lzQ0JMcjUwTzJZ?=
 =?utf-8?B?V3VzQitqZ1VZcUtwdjlMUXZ2bU9Bakd3L3NmSkw5ODNkeFlMNnh6NVlPWXds?=
 =?utf-8?B?RDJOUFkzMVZURmNDaXBtdWUyWXNlOHIyL1g0dzhEQkczdkdOMXRsVlhtZU50?=
 =?utf-8?B?TzhDN09URVBpOFdGem9pNS9PeTZxd3BGVVp1NUg5ZmFCeklZbFhGL3R3L3dn?=
 =?utf-8?B?cXpsQ01pRDRURERSVngxWERiNWhsbEY3TVFicTlQUjVsNkRaQ0ZEcE1UL3F2?=
 =?utf-8?Q?MAmzTvu1SC+QS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkUzYnB0TU9JcTIzVVE0K0ZQMlB1N1psVUdBNUI5WTRtRGNYOUxTUTVxbFlW?=
 =?utf-8?B?YmJOREovdkppTVZ0c3Z1d0tFN29EZDFGMWVWVHdFUVpaSWhad2RHd1FKTjAw?=
 =?utf-8?B?Z053NkVRcFFrN0RnaVZHbURTRDJqZVNXUDQ1M2g5TDJwbXFrV3Y4TGdNd1RY?=
 =?utf-8?B?UGhtS1U5TVlNQVB0NXVMNWw4RDRxYzNpOFZ5cExhRkhUMXJNc3BCeUw5akNw?=
 =?utf-8?B?eVdPbnRHUENnTmdQNVhoQS9UeFhzUSt6MmxuUEJkbEVrOWJsN09oOWcwSC90?=
 =?utf-8?B?c1VDZy82azIxR0pKR2FlVWtOQjU4OXJMWU1WOE9kb04yajhiRlFrYmFITEk1?=
 =?utf-8?B?MkJ1U2pqWWNqUUFuaG50bndBYUhRckxOMHAwbUNIdm9Zem1XOGFsNUFmdE5q?=
 =?utf-8?B?Q0xLY2hkd2lkUGdEdmdEeVJXNWNxY3EyRm5MRWljbEl3SGhTa0JlVE1lL1My?=
 =?utf-8?B?TExjWEVJa3VkODdnUXEyaW5MS0lvUHVLWDZCbzF5ejRWTmtGZndQU1lXZDdX?=
 =?utf-8?B?emRYOUJPVHRoUis2UzI5ZHljcFpRa3lYSzEwU2xZMEV2MGVMYjBCdkE0TDZV?=
 =?utf-8?B?UDh4NVpsOUpLTWlmOE43VzdPTEdGQUg5RVQ4Y2RiOSt4Sk1KNmZGY1Iralgy?=
 =?utf-8?B?a1prcWlpS0U2d0NuUFpFS0tEOGwwMGxBck1KL0pxbURqWjJRZERabmxDbmZs?=
 =?utf-8?B?dzFjYmFFMkd2ajk3dHVFSkZYSnJwamZxbllpalEyYzVnSm1ONmVWRm11cVhG?=
 =?utf-8?B?MC9Ycm5QRlgwYkZpUW16RHNZODdsT3UxcTVBS3Z5bUJ2NElhcmdHTlorcEtO?=
 =?utf-8?B?cWFoT3VBRHltVjRCWGVYV09UMm9ra3NkRzRHTmFIbVFYRmlyWDdTRG9JV3JL?=
 =?utf-8?B?M3RPV0hDUnpJWC9QZnlRR3NhNU1Pd2ppb1h3VXhUN3dVck81ZG5YazQ5SEU0?=
 =?utf-8?B?aFBtZjhOUHJLdkRlTGNBR1FGbkROVFdQcGtYNndzY281bS9mZ2VjNWtQdjhE?=
 =?utf-8?B?WWhhQW1la2huVmR1aXI4UnJOM2duUmZyU2kvOWdBd01nQzhkaStkMVlZWUZy?=
 =?utf-8?B?TmU0Q2lPV3FzZWFTWWR3OCtqa2ZxWjA2d2xCdGtOS01RVGZSanBLOS85YVVZ?=
 =?utf-8?B?cm5zVHhzMno5N3BTWitvVEpuWE1ZSlhtYXd2NC9wSXNCNDhNYXZiVVF2WFpo?=
 =?utf-8?B?S2xPdGE2QW5EM3J5TDM5YlU0ZmpxdS9WVEZXV01oYisxM0hKK1lOZmxQdW9h?=
 =?utf-8?B?RDhTQXhOQkhHSDgrKyt5WmsvTktsU3REdXBEbXliSXBQOXk3Y2IwY0dwTFNC?=
 =?utf-8?B?YzdqREVVSEZibTA5bm5vbzRTQXYzd2hUQjhJbTVRbC9NeEFXMzFMTmxFSTNi?=
 =?utf-8?B?Rm9wejBURkEyVW52TEFXSmI4VytSQzdUb0pqR0xMZmtqSytSK1ZaKzhsWldR?=
 =?utf-8?B?UlVxZWo3aG1tZ0xCRmY2azZSV2p2TjkwNGpOaTgwTGFoYmREeUV5c3lWelRP?=
 =?utf-8?B?am1wQUhadFpPNFlxYytDTVVxZFIyMUNTUXZLRmNCelVtSGsrb2ZoTzhmWVVy?=
 =?utf-8?B?M2hHRTlZbEgwaHFOUmhEeW10d1JYazBFazc3RXJuTXYzdmgrbU1LeG11cFM3?=
 =?utf-8?B?MVhSQ1E1Mm9KN0t6OTJuK2dzTnl1MzRmSVczRXRlM3AyY1BncFdxaFlTV0g2?=
 =?utf-8?B?S01LRVkzODEwa0NUc1NDQ211Z3U1VWNVSE1kY1lraDRDZFcxWGdOOUhRaFYr?=
 =?utf-8?B?UlhVYXd1RW5hc1JHQVM2NHFFNjVsbG5QN0NhTU9OdTVEQzZlenNMYlppSlZi?=
 =?utf-8?B?UnQ3UDJOMzVGaTMycmJmaklnenBOa1cxQ2tBNHVGMTRrTVlHcTZjWXJndHdM?=
 =?utf-8?B?QXNBallzeGtjSXpuOFpBUzB0M09KcE16NjhlZVBGZzJKdW9xaElHdHV1YkhT?=
 =?utf-8?B?dE1lQm56Y1I5c2hZb2lVUXFYQzhiR1VqRkpyZXhJK2c5NHNCL0d1MmNrM2Fz?=
 =?utf-8?B?OUZpNWh1OTZFRkJCUlB0T09sVlh0aTJ5OXVZd1pEeUZlSkhwNE40THVMN1dp?=
 =?utf-8?B?K1hSSlZENTZoTXE0LzZVKzFJS2IxM3hHazQvQ1hFVDZIVjUzc3pEZmtnQ3Mz?=
 =?utf-8?Q?2EtS8ZooeazhLSViSrEVO8lIr?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9febb003-9879-4c5e-979f-08dca263c98f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 11:14:24.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu9rvbwpD2RHFHTFvHUcgTcJtYLzF0VWSseHPPhZEZHcRqI2PzL1wGCrTdj9XY17ozWBSZeaI6vc7EircLTIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8282

Hi,

On 2024/7/11 20:19, Krzysztof Kozlowski wrote:
> On 11/07/2024 13:40, Yang Li wrote:
>>       arm64: defconfig: enable Amlogic bluetooth relevant drivers as modules
>>
>>       CONFIG_BT_HCIUART_AML is the Bluetooth driver that enables support
>> for Amlogic chips, including W155S2, W265S1, W265P1, and W265S2.
> This still does not answer why we would like to have it in defconfig,
> e.g. which mainline board uses it or benefits from it.

Well, I understand.

I plan to submit this patch after the mainline board is ready for 
contributions.

Thanks！

>
> Best regards,
> Krzysztof
>

