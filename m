Return-Path: <netdev+bounces-190229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD20AB5C7E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE4F1B448C7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269322BF98D;
	Tue, 13 May 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dnPB0AjA";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dnPB0AjA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8122BF976;
	Tue, 13 May 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.111
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161674; cv=fail; b=r09KeUzDyMUaS6/HM4v64YN/6j97CS9Ble2pEczwNmO/RTUburzZ1Bn05zwrqSYuswolrHtIVZBmSeRzhd3V5EDfdhjjaTZSwRILwRUTCToTl9zD7IBxljzQn2KcjE5DcZhSejWZeou/nKZ5uRREe8bZ1DVr1Zj8aCzmCNPQOoY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161674; c=relaxed/simple;
	bh=sTrPNls172pbbVywU7arw7zcivyREJqpCCFpYYh8qLg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPK2y+/nCl8lx/eEW39NrkM+SZmuD9cIQtgBunzTU6avXib6vGGkJnx11WV3cfjnQNRnm8bDOJe6nLpES7EPQNBE+mjdZLY0w2RN50WlZJER29lNyz1ehZrg9gC3tmuouCUBUb4A0WACno912b0pdzttZ8n22FnqVwKsosK2Qcw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=dnPB0AjA; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=dnPB0AjA; arc=fail smtp.client-ip=40.107.22.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=el3Dupvz8vgU+RRgLuEROEVlq4vPbqtgZ370u7zBGO8dSiPCwRyHEeLbs4HkQqDW2RA0yrbZVjm1xUt9ksfN+J1bC8/gftFCKQpVQqT2nL4jGhthXfRCbZuRRcTz0aPB25oXKFv4/cAo/uAkFwb0axkDPScf95hyd47WI9CNplEn1o1BRuKNLk1HZjXLYZBtWCffXQQJqIUx5bQhQtiLvWQJU0gimyvr84SonzyKmc/9rWdbiJhN+M2iTtlWfe0xk64m6GKo5jTE6JnGe0WfE7e5vToL7QIP+CgeulSJ+EjSzyyJE+F4JUcTl9/zuJJHLJ1qh80hdrq6wEo5TpOM2g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TbktYI0pxnc2XsJTiVx6NtpuzJIOqT8TxoN9dDvCaY=;
 b=WAmIyBqUdOK9KwRo9YyggJERzy4CXSwJ/QToOf3lPAEEdjxbfBxiC0tGY8d0XdyBiUmjXSbnFLsmZ/GXFK3TyRU+VV4VKGDqN7lmVGs4wKr50tA1qx2TodS+rjoe9P7WH8nZhFuSGN7GHxzoHBvXRyngyqD/21FhrbOZP8CnF+zwIlzFokJb7tDxpZyNCWEpE1Bw3ZeQEH//dBU0E+hyUcqkucRYZ79SxC/BcDG/GljWyS9mcVzAf1C2m4Wrhcq8nUIFf/TBfkqZYvHrkOjrEgHyoKnmS5ma/r6dJRcqDNaIQqhGQRg+T4CKKfMyfwbdFrZ53fL5x6hXgBAMsOkg2Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TbktYI0pxnc2XsJTiVx6NtpuzJIOqT8TxoN9dDvCaY=;
 b=dnPB0AjAY3scBd8aEWKmHCe36Wp5LLctJcQyFPwPm9AvJW/69ulSNibhF6NMOG5BE3k2zCT5yl9guCdtaLSGcRoBVR4PPOQfUJjS7ha92woZbPrtxLR6zvIdrWw54MJqvf5ikL+G8KYGIz2WiqUR9z0kBJmwFCt/I8wfbRNBm+jSy3Jmu8kF5Yg72os1TXil0i/4W0+g4SFJ0WUdtnC6krLO2BVlpYzgq20nEOvYd+2vvy+2Zzyi8d9gbWZOyNgku3to9O99RG1SLsOnqTGfWRTnoHAdGHYjWsfsqNDKmHqwjolDqkjJxQFA6blf/BbTrNZd56vYfnmdladXNlt6lQ==
Received: from DB9PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:10:1da::8)
 by AS4PR03MB8674.eurprd03.prod.outlook.com (2603:10a6:20b:58a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 18:41:08 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::41) by DB9PR05CA0003.outlook.office365.com
 (2603:10a6:10:1da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.27 via Frontend Transport; Tue,
 13 May 2025 18:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via
 Frontend Transport; Tue, 13 May 2025 18:41:07 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 1523A20080268;
	Tue, 13 May 2025 18:41:07 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.107])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 844D820080076;
	Tue, 13 May 2025 18:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKbBlWJHvF5f59DtDhbRr8sukAOHIRQLtv98eqkzL3LzYtzmHMYLC2W0uGKLYXtBM61DnmCpGT15pU4wABWRYdvxMbW31xIp/L1K1SwPbXOe7gNRwH9hcSmr7zHUP+1Hy5fdz2o4T1LCpf+s+0lwlPrYSBwwDcImsTWitdlAEeczMsmrF6SGEG8trw8A5xhCkYmw5MaN9JI6yG9cTGUMbJmN2NLSYf5G9/TasWOLtWCazfjM0kj8dU5T83yY4J1ZpWI77QtPYVhMjgzrkqUxhP5l8KSbhlsKq0o3Y/pago6DbhTzrX0CsgDm9fqDLJ/bnOyMJIqsiNlYtEj83goi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TbktYI0pxnc2XsJTiVx6NtpuzJIOqT8TxoN9dDvCaY=;
 b=Q7itAr3ZCmvJdRyatV1y+S9F9EBLyBz8j5bpHmlTEuCXLQFA/96ZKRkpe278fjq66l9hLKTsKTACUazyybn7uDDbQIe5AfhzstdpqpplaTTKkTqPT5JhelpcSzb0J4N27Q1/GgVJKZ1YhNru21uUubVYOJU+l3WixXyBdB/aICYG7cnorP7nmeRe9hPWZO2KiKVHZKadA1ZfXq3U7FCNuK1l9hpLjVKFF5Exi49j1R7D4cVP+fgtHjmUyIeTJ2dV1VWd4gas4AQNMt7pl3isrnAYrgpUxNJ565bqrq5I44l7Zn1gqwTbW49k2Vk63VyFVxEtMPGfsy5FGAdFiaEhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TbktYI0pxnc2XsJTiVx6NtpuzJIOqT8TxoN9dDvCaY=;
 b=dnPB0AjAY3scBd8aEWKmHCe36Wp5LLctJcQyFPwPm9AvJW/69ulSNibhF6NMOG5BE3k2zCT5yl9guCdtaLSGcRoBVR4PPOQfUJjS7ha92woZbPrtxLR6zvIdrWw54MJqvf5ikL+G8KYGIz2WiqUR9z0kBJmwFCt/I8wfbRNBm+jSy3Jmu8kF5Yg72os1TXil0i/4W0+g4SFJ0WUdtnC6krLO2BVlpYzgq20nEOvYd+2vvy+2Zzyi8d9gbWZOyNgku3to9O99RG1SLsOnqTGfWRTnoHAdGHYjWsfsqNDKmHqwjolDqkjJxQFA6blf/BbTrNZd56vYfnmdladXNlt6lQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PA4PR03MB7038.eurprd03.prod.outlook.com (2603:10a6:102:e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:41:03 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:41:03 +0000
Message-ID: <5fb7afec-c216-4912-bb7f-a2bd86dcfcad@seco.com>
Date: Tue, 13 May 2025 14:40:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 05/11] net: pcs: implement Firmware node
 support for PCS driver
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250511201250.3789083-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:610:50::31) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|PA4PR03MB7038:EE_|DU6PEPF0000A7DE:EE_|AS4PR03MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe49918-1345-4a72-4238-08dd924db945
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WTFYWjE1VnkwWERlREpENHZxMWhQYWcxdW1ZRmRsd2YzUGJYeTMyTnltanMx?=
 =?utf-8?B?ekNMTVhyREczK0FHdDMrQlZZSkR4TWRpRUY1N2NVSjUrSEFQcWJVNzNja2xp?=
 =?utf-8?B?bFFibEJYRCtPWXRxcU1kK3lRVVpJNFAyVjVOby9HUitNS2xpRjFFdGgyZHA0?=
 =?utf-8?B?L0kvWk9JZ1diMmNMV1BEdGJ6OFd5R2pDZmlIUDF2UXpoa0VIZGxNRnVIOC9u?=
 =?utf-8?B?VW5vMllGajFTZGNuNGtwaE1KSkxwc1hyT3l6T3Rra3kwMzNrRWZ5ZDljSWt6?=
 =?utf-8?B?VmkzRzhvQVNTRE9SUE9tdUJKVndlSzBaYm1WakpSNm91TWJHU0czbUlNNTBH?=
 =?utf-8?B?Y3lQa3grNTd1MFBWN2ZlMTVMMG03WldJTGNZRTFHQUs2Y0Q2YzR5QTlndXZh?=
 =?utf-8?B?RmM2Rll0b1hJdytlVVo1RXF0c0FaTWYzN3lMZHpweTdwZW1YVWVPaXN0YjZX?=
 =?utf-8?B?b1VZeWpsdFJoMlZrVUtzbGh4RTVuUFF6cWd4UUF3YU9oa3pxRUFrYkRwY0E2?=
 =?utf-8?B?bE1EQk10OG53MFdxZHFDNzVlQnE3ZnowQ0cwV3o0VTRBWHJWbU83d1JqSjVV?=
 =?utf-8?B?RklvMGFBUVN0UWIvNjFaa000cHlCZDJkZ3AwREoxSU1VMzVjUDl4U2F6cGEx?=
 =?utf-8?B?Nm1qbGRDakVuN1I3ODJLWDhQRzdpbUU5MmRzTjRGU0Zld1ZvZjBnblhPdVN3?=
 =?utf-8?B?ZWFuOFFMUlRFUm5sU0tHbVBNamlWcmtPWFpQVHpnM0pWNGV3KzVGWXU3MWRT?=
 =?utf-8?B?dzVFN21ZTktDTHYyUVg4YWQ1WXViTjkyUzl0cUt3SXVOMmZOL1BNS1VLNGtT?=
 =?utf-8?B?S3N4VmNXbkVhTzRscy9lb2ZwbWFWeUV5WVpPVm1yZ0xMOUlBOGtMUW01SE1k?=
 =?utf-8?B?MDZ2TkUzZ2NSZXRYemxkZ0FlK291WXBxNzR3dWlMR1hKYy82cDNLajdrUTlt?=
 =?utf-8?B?REEvNUxidUlxTitURTFjNDBMZWVYWjJXM01CcURMQnBUdTVRK1c4ZndDaDhE?=
 =?utf-8?B?cm5DZytuWEJxSEFCTnVibHZpWmwwcEkvVG12Z25UTnhJQm5tOCtUNWV2RVNB?=
 =?utf-8?B?UVhYYWFWY0x6WHJpU05kTWoyMm1mSCt0RzRQNXg1cjlIZEpZN0kzSzdSczI5?=
 =?utf-8?B?SzhiQzV0SUxjRGNYdUM5TEFIcTd6M1d4US9JWStKQkRUYVAxRHIvRzlPVjFl?=
 =?utf-8?B?QlZiME83c0MvOU1DQU9IcCtLeTdHa2Nvb1NJRUVPbGNlcEoxcUt6bDUwUzdS?=
 =?utf-8?B?U3E0NHhpQlFSWXdVV05uVDdZdW1nS0tyZzhUMTdkQ1dTSy9ranczSVRmYnNi?=
 =?utf-8?B?NHMzakU0cVAwUlpJMFBKTFRxeXhwSGNvbmV5Unl3cDVqOUpWeFNuczNNbDg5?=
 =?utf-8?B?bnk1cldoVHN4NmpBQkV5S0tvczQ5TUZNZXlLZHE5SzE3TlYraGZCSy8remR0?=
 =?utf-8?B?Q3gydm5SSjI5clVtUWZWbm8yUWdZTDhUM3JYbDcxdHdpSVBkOVVKWFVIbnNJ?=
 =?utf-8?B?dHVvZW1kWnNWNkpScC9TVGczb1FUbGVNTHNOaG90ZUxETklQNGJTSVdlK1Jk?=
 =?utf-8?B?RmdBUkwwemFLREptaFp4WTBmNllXNmRwQVU1UFAwWk1GOWpsL09mQkx6V09G?=
 =?utf-8?B?Z2Q3emlucGQ2bXRQUjhER3RCckpmOEFhNzl0Q2YvQjMvUmQwdmZzYy80Q2RW?=
 =?utf-8?B?ZHk2aHFvNkZSc1V5WkIyYno1c3lRVmZqZ1poclVpb2VyRkMrVi9zT2FZUUw1?=
 =?utf-8?B?VnhsOTdlbnIwVFdDcG9nbkFNRWh1SWlSQ0twVUxWazJya2lHY2wwMndvME9h?=
 =?utf-8?B?SHl5ODJnbUw5aU5YY3gybU4vYmhJbGNPQmp1alFxUE9QTlhheDhKcUZmYmtQ?=
 =?utf-8?B?RUIzTnFEdDdvVW5sOVNtVGl2dXpoVUVibTJjVXBkd0YwVlovYll0TnBJWEFh?=
 =?utf-8?B?QmliSWV2UWltaE5yRTFIRWF3dlBWQ2pwRytjdUNmaHZXNzlJQjFwR0dEUVZp?=
 =?utf-8?B?dmhBVDB6RVdRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7038
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef1a70bc-6e5a-4f47-4899-08dd924db6e8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|376014|35042699022|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnRLc2xnSWFJMzhPQzhjSWt3dUN2eVllS1BTejViU204akxsYURzSlEzV2dn?=
 =?utf-8?B?UXZETjVKZUpldEFpSC9HQVB4NDB1NjZvWGZLOVBDWTkybnY0NStsdUFhMDQr?=
 =?utf-8?B?QVg1L2NaeHBUbGJ1aXdqOWRzbjVPcHRNT0M0OWdOaWdXL0NCYk53VkJWUlQ5?=
 =?utf-8?B?S1pIeW41SHovdHVhSXBuY3hsYWJTemoxdS9nSHk4dFByWDVaMFcyeDRDRWN5?=
 =?utf-8?B?Ry80NU1CbloyUU9qVVlxMUJxdDczQy9JM2YxR2FlUkJ2dGp3WW11ZlBOckhP?=
 =?utf-8?B?RDg0SVpDeTY0bnhlYlRYdTBuTDBZNVlSbTlmbXhFaGpULzN1Q0g0L2dIYzF4?=
 =?utf-8?B?R3g5V1ordjZDTkRxRndMZ015MU1MeHpKakZqU0JJR1FkZWVTVVNYRGZocUxo?=
 =?utf-8?B?aEkwY1lUL0FDU3FnTlVLZm13M1lXSEtuRFErQnlRWUZ5YVBZSG9tNWpTeHhL?=
 =?utf-8?B?QkxQdVNOQnBuaXh0SXFCRmx5Um4xOHE0c1FlSWlDME4yTTRuTUppWHoxSURO?=
 =?utf-8?B?Y29ncWlKbGN5dVJlSlhjUUJXZCtQcXZ3Ujd4YUs4MTBFK3dCaDZXVzc0TXc2?=
 =?utf-8?B?eWZCNWNKVTVPS0JwTjE3OFhCS2R1YWVjQU5sa1lOQkZ6UGM0OWNXblI0MXV1?=
 =?utf-8?B?YXFLS3kzTkY3RTZNMEhCVGs3emNuL3lwUUlJa0pOVUJQRXI2ZnFmb3JzazBw?=
 =?utf-8?B?SGkvWUhYTHRpZTE0ZGlrdy8vVTV2Tk4rcHIvZklKT0JWdzRpaFV0Q1Bmajh4?=
 =?utf-8?B?L1BoRmdQYTFTOFc0ZitnbU1WR3oycDR1NDBrNUVsSkdrQmlobkJSRTZ4Q0Fr?=
 =?utf-8?B?LzBpQWdKcFlXc1ViMUFGT0JkdEdnYjd3RFJ4b1ltRWJJMGtzME9WcGdTVHpl?=
 =?utf-8?B?dkErWEc5cDlVVDFYWVFWTWt3eDlLbnZuQ3pEZklGU1libDJOTUJEbWdNK3pR?=
 =?utf-8?B?dzNVYkNBQm9SVVNsSk52MGdraHdWMmwvNnJkUHJKV0o5b0xUZDBkRVFCQStK?=
 =?utf-8?B?OWFTQ2NOZFVZWi9xRFdBaUNadmsvUmxSaEIrQWhrY3lZZEpSQ245ZGpPeXlR?=
 =?utf-8?B?dWQ0Y0xwQ3ZVQUtQZlJmdHVTNW45Q1pnak50TzhUZTUwelVKNStXaHZnSklO?=
 =?utf-8?B?SEpQazR4Tmsybml0bjRBZHdTMGlyNUhQQmxkTWZIMUhwcDZieVlWVUplakph?=
 =?utf-8?B?MWtxMWRQL3FDQ2dJOURvWXZIVWRMQU8wMWZwU0dMRFhFUzdXVGg5ODJhdk42?=
 =?utf-8?B?c3lOOFFWdUduQkt0UVoyWlFnRzRKd05LOHRYaFo5OWpVeDRRdTlhcG4vSllI?=
 =?utf-8?B?aXFNSk5PcCt5QmR3YVNrQVlPUzlOWVlSb0NrNitKRWhrRnJUUVlaNkgyRTFU?=
 =?utf-8?B?VlJsSXR0blBFT0o0WnhDeFFPd21Hc0k3RkZ5K1I5Ukd6VkZPT2JEY0RpVk9V?=
 =?utf-8?B?UThYZmVMSXVJUkVDbW9EZTZCanFXTVQydnRhZ3NBVnpZSldVSnhkakdvcExY?=
 =?utf-8?B?OUQrNnFUYkhrRkVjZXBRdTFHMlkzeVl3WDFhV1c4Mlo2bU1ScUpxQlZ5cDJx?=
 =?utf-8?B?TmRSTU1sKzdXV3hKSFAwNmdsL0ExSXRheTh1Qzl6b2Mrejc5anAwRDJsdmM0?=
 =?utf-8?B?RUhUV3h4YkNwemxocmhlWlo1QlhueE1BQXNVL0NtU2kySThUWjZua2FDTFVv?=
 =?utf-8?B?NE8xN2xZMzJqSzBQVjdBZ1pYaVZGdlFoOXVzSW0xWGUxTU5lV0J2ckRxZUJl?=
 =?utf-8?B?YnlxZ25BZG8vemllM1d3VjZlRERVYVpKVzBGMGQ0Nnc4bTBwY0Q5VStPTU4x?=
 =?utf-8?B?c3VqQTJZb1VOdFRqQklrKzdRV21mSjU0alNObTR2ZHRJZWVWak10NXJUVkgx?=
 =?utf-8?B?eWlDRGNjOXFabWl2a3prcUE3TVNTQnNVa1BHSVpBVWFmRGtWL1IxeWRkNGs0?=
 =?utf-8?B?OHF4OVdKd1g3YVBsM2VSLzI1TWx6M3ZTNDM2LzRUdXNxT3VrNjlnNzJQQlc4?=
 =?utf-8?B?YVNVUit0Qmt2Ykk0ZGdaUDNYTmRhRm00ekhOc1c5aENqZjFGc2ZsYTFKMW5q?=
 =?utf-8?B?ampkaVR3NTV2RkJNSjNxQ0hjU1ZSbUFmSEZiZz09?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(376014)(35042699022)(82310400026)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:41:07.4048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe49918-1345-4a72-4238-08dd924db945
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8674

On 5/11/25 16:12, Christian Marangi wrote:
> Implement the foundation of Firmware node support for PCS driver.
> 
> To support this, implement a simple Provider API where a PCS driver can
> expose multiple PCS with an xlate .get function.
> 
> PCS driver will have to call fwnode_pcs_add_provider() and pass the
> firmware node pointer and a xlate function to return the correct PCS for
> the passed #pcs-cells.
> 
> This will register the PCS in a global list of providers so that
> consumer can access it.
> 
> The consumer will then use fwnode_pcs_get() to get the actual PCS by
> passing the firmware node pointer and the index for #pcs-cells.
> 
> For a simple implementation where #pcs-cells is 0 and the PCS driver
> expose a single PCS, the xlate function fwnode_pcs_simple_get() is
> provided.
> 
> For an advanced implementation a custom xlate function is required.

There is no use case for this. All PCSs have a fwnode per PCS. Removing
support for pcs cells will simplify the lookup code as well as the
registration code and API.

> One removal the PCS driver should first delete itself from the provider
> list using fwnode_pcs_del_provider() and then call phylink_release_pcs()
> on every PCS the driver provides.

And things like this can be done automatically.

> A generic function fwnode_phylink_pcs_parse() is provided for MAC driver
> that will declare PCS in DT (or ACPI).
> This function will parse "pcs-handle" property and fill the passed array
> with the parsed PCS in availabel_pcs up to the passed num_pcs value.
> It's also possible to pass NULL as array to only parse the PCS and
> update the num_pcs value with the count of scanned PCS.

When is this useful?

> Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/pcs/Kconfig          |   6 +
>  drivers/net/pcs/Makefile         |   1 +
>  drivers/net/pcs/pcs.c            | 201 +++++++++++++++++++++++++++++++
>  include/linux/pcs/pcs-provider.h |  41 +++++++
>  include/linux/pcs/pcs.h          |  56 +++++++++
>  5 files changed, 305 insertions(+)
>  create mode 100644 drivers/net/pcs/pcs.c
>  create mode 100644 include/linux/pcs/pcs-provider.h
>  create mode 100644 include/linux/pcs/pcs.h
> 
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index f6aa437473de..0d54bea1f663 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -5,6 +5,12 @@
>  
>  menu "PCS device drivers"
>  
> +config FWNODE_PCS
> +	tristate
> +	depends on (ACPI || OF)
> +	help
> +		Firmware node PCS accessors
> +
>  config PCS_XPCS
>  	tristate "Synopsys DesignWare Ethernet XPCS"
>  	select PHYLINK
> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 4f7920618b90..3005cdd89ab7 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Linux PCS drivers
>  
> +obj-$(CONFIG_FWNODE_PCS)	+= pcs.o
>  pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
>  				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
>  
> diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
> new file mode 100644
> index 000000000000..26d07a2edfce
> --- /dev/null
> +++ b/drivers/net/pcs/pcs.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/phylink.h>
> +#include <linux/pcs/pcs.h>
> +#include <linux/pcs/pcs-provider.h>
> +
> +MODULE_DESCRIPTION("PCS library");
> +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> +MODULE_LICENSE("GPL");
> +
> +struct fwnode_pcs_provider {
> +	struct list_head link;
> +
> +	struct fwnode_handle *fwnode;
> +	struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
> +				   void *data);
> +
> +	void *data;
> +};
> +
> +static LIST_HEAD(fwnode_pcs_providers);
> +static DEFINE_MUTEX(fwnode_pcs_mutex);
> +
> +struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
> +					  void *data)
> +{
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_pcs_simple_get);
> +
> +int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
> +			    struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
> +						       void *data),
> +			    void *data)
> +{
> +	struct fwnode_pcs_provider *pp;
> +
> +	if (!fwnode)
> +		return 0;
> +
> +	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
> +	if (!pp)
> +		return -ENOMEM;
> +
> +	pp->fwnode = fwnode_handle_get(fwnode);
> +	pp->data = data;
> +	pp->get = get;
> +
> +	mutex_lock(&fwnode_pcs_mutex);
> +	list_add(&pp->link, &fwnode_pcs_providers);
> +	mutex_unlock(&fwnode_pcs_mutex);
> +	pr_debug("Added pcs provider from %pfwf\n", fwnode);
> +
> +	fwnode_dev_initialized(fwnode, true);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_pcs_add_provider);
> +
> +void fwnode_pcs_del_provider(struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_pcs_provider *pp;
> +
> +	if (!fwnode)
> +		return;
> +
> +	mutex_lock(&fwnode_pcs_mutex);
> +	list_for_each_entry(pp, &fwnode_pcs_providers, link) {
> +		if (pp->fwnode == fwnode) {
> +			list_del(&pp->link);
> +			fwnode_dev_initialized(pp->fwnode, false);
> +			fwnode_handle_put(pp->fwnode);
> +			kfree(pp);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&fwnode_pcs_mutex);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_pcs_del_provider);
> +
> +static int fwnode_parse_pcsspec(const struct fwnode_handle *fwnode, int index,
> +				const char *name,
> +				struct fwnode_reference_args *out_args)
> +{
> +	int ret;
> +
> +	if (!fwnode)
> +		return -ENOENT;
> +
> +	if (name)
> +		index = fwnode_property_match_string(fwnode, "pcs-names",
> +						     name);
> +
> +	ret = fwnode_property_get_reference_args(fwnode, "pcs-handle",
> +						 "#pcs-cells",
> +						 -1, index, out_args);
> +	if (ret || (name && index < 0))
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct phylink_pcs *
> +fwnode_pcs_get_from_pcsspec(struct fwnode_reference_args *pcsspec)
> +{
> +	struct fwnode_pcs_provider *provider;
> +	struct phylink_pcs *pcs = ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!pcsspec)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&fwnode_pcs_mutex);
> +	list_for_each_entry(provider, &fwnode_pcs_providers, link) {
> +		if (provider->fwnode == pcsspec->fwnode) {
> +			pcs = provider->get(pcsspec, provider->data);
> +			if (!IS_ERR(pcs))
> +				break;
> +		}
> +	}
> +	mutex_unlock(&fwnode_pcs_mutex);
> +
> +	return pcs;
> +}
> +
> +static struct phylink_pcs *__fwnode_pcs_get(struct fwnode_handle *fwnode,
> +					    int index, const char *con_id)

Many existing drivers have to support non-standard PCS handle names
(e.g. pcsphy-handle, phy-handle, etc.). Support for this is important
for converting those drivers to use this system.

--Sean

> +{
> +	struct fwnode_reference_args pcsspec;
> +	struct phylink_pcs *pcs;
> +	int ret;
> +
> +	ret = fwnode_parse_pcsspec(fwnode, index, con_id, &pcsspec);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pcs = fwnode_pcs_get_from_pcsspec(&pcsspec);
> +	fwnode_handle_put(pcsspec.fwnode);
> +
> +	return pcs;
> +}
> +
> +struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode, int index)
> +{
> +	return __fwnode_pcs_get(fwnode, index, NULL);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_pcs_get);
> +
> +static int fwnode_phylink_pcs_count(struct fwnode_handle *fwnode,
> +				    unsigned int *num_pcs)
> +{
> +	struct fwnode_reference_args out_args;
> +	int index = 0;
> +	int ret;
> +
> +	while (true) {
> +		ret = fwnode_property_get_reference_args(fwnode, "pcs-handle",
> +							 "#pcs-cells",
> +							 -1, index, &out_args);
> +		/* We expect to reach an -ENOENT error while counting */
> +		if (ret)
> +			break;
> +
> +		fwnode_handle_put(out_args.fwnode);
> +		index++;
> +	}
> +
> +	/* Update num_pcs with parsed PCS */
> +	*num_pcs = index;
> +
> +	/* Return error if we didn't found any PCS */
> +	return index > 0 ? 0 : -ENOENT;
> +}
> +
> +int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
> +			     struct phylink_pcs **available_pcs,
> +			     unsigned int *num_pcs)
> +{
> +	int i;
> +
> +	if (!fwnode_property_present(fwnode, "pcs-handle"))
> +		return -ENODEV;
> +
> +	/* With available_pcs NULL, only count the PCS */
> +	if (!available_pcs)
> +		return fwnode_phylink_pcs_count(fwnode, num_pcs);
> +
> +	for (i = 0; i < *num_pcs; i++) {
> +		struct phylink_pcs *pcs;
> +
> +		pcs = fwnode_pcs_get(fwnode, i);
> +		if (IS_ERR(pcs))
> +			return PTR_ERR(pcs);
> +
> +		available_pcs[i] = pcs;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_phylink_pcs_parse);
> diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
> new file mode 100644
> index 000000000000..ae51c108147e
> --- /dev/null
> +++ b/include/linux/pcs/pcs-provider.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __LINUX_PCS_PROVIDER_H
> +#define __LINUX_PCS_PROVIDER_H
> +
> +/**
> + * fwnode_pcs_simple_get - Simple xlate function to retrieve PCS
> + * @pcsspec: reference arguments
> + * @data: Context data (assumed assigned to the single PCS)
> + *
> + * Returns: the PCS pointed by data.
> + */
> +struct phylink_pcs *fwnode_pcs_simple_get(struct fwnode_reference_args *pcsspec,
> +					  void *data);
> +
> +/**
> + * fwnode_pcs_add_provider - Registers a new PCS provider
> + * @fwnode: Firmware node
> + * @get: xlate function to retrieve the PCS
> + * @data: Context data
> + *
> + * Register and add a new PCS to the global providers list
> + * for the firmware node. A function to get the PCS from
> + * firmware node with the use fwnode reference arguments.
> + * To the get function is also passed the interface type
> + * requested for the PHY. PCS driver will use the passed
> + * interface to understand if the PCS can support it or not.
> + *
> + * Returns: 0 on success or -ENOMEM on allocation failure.
> + */
> +int fwnode_pcs_add_provider(struct fwnode_handle *fwnode,
> +			    struct phylink_pcs *(*get)(struct fwnode_reference_args *pcsspec,
> +						       void *data),
> +			    void *data);
> +
> +/**
> + * fwnode_pcs_del_provider - Removes a PCS provider
> + * @fwnode: Firmware node
> + */
> +void fwnode_pcs_del_provider(struct fwnode_handle *fwnode);
> +
> +#endif /* __LINUX_PCS_PROVIDER_H */
> diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
> new file mode 100644
> index 000000000000..33244e3a442b
> --- /dev/null
> +++ b/include/linux/pcs/pcs.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __LINUX_PCS_H
> +#define __LINUX_PCS_H
> +
> +#include <linux/phylink.h>
> +
> +#if IS_ENABLED(CONFIG_FWNODE_PCS)
> +/**
> + * fwnode_pcs_get - Retrieves a PCS from a firmware node
> + * @fwnode: firmware node
> + * @index: index fwnode PCS handle in firmware node
> + *
> + * Get a PCS from the firmware node at index.
> + *
> + * Returns: a pointer to the phylink_pcs or a negative
> + * error pointer. Can return -EPROBE_DEFER if the PCS is not
> + * present in global providers list (either due to driver
> + * still needs to be probed or it failed to probe/removed)
> + */
> +struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
> +				   int index);
> +
> +/**
> + * fwnode_phylink_pcs_parse - generic PCS parse for fwnode PCS provider
> + * @fwnode: firmware node
> + * @available_pcs: pointer to preallocated array of PCS
> + * @num_pcs: where to store count of parsed PCS
> + *
> + * Generic helper function to fill available_pcs array with PCS parsed
> + * from a "pcs-handle" fwnode property defined in firmware node up to
> + * passed num_pcs.
> + *
> + * If available_pcs is NULL, num_pcs is updated with the count of the
> + * parsed PCS.
> + *
> + * Returns: 0 or a negative error.
> + */
> +int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
> +			     struct phylink_pcs **available_pcs,
> +			     unsigned int *num_pcs);
> +#else
> +static inline struct phylink_pcs *fwnode_pcs_get(struct fwnode_handle *fwnode,
> +						 int index)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
> +
> +static inline int fwnode_phylink_pcs_parse(struct fwnode_handle *fwnode,
> +					   struct phylink_pcs **available_pcs,
> +					   unsigned int *num_pcs)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#endif /* __LINUX_PCS_H */

