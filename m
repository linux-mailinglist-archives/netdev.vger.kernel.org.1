Return-Path: <netdev+bounces-190227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140BAB5C3A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38E8166E17
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C422BF3FE;
	Tue, 13 May 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ifE+CXV4";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ifE+CXV4"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020104.outbound.protection.outlook.com [52.101.69.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B01E8328;
	Tue, 13 May 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160741; cv=fail; b=f2Glxu8uyalRl/zSU+XEdDhVcEc2v1F08Q286PZjZMQMoErEuPMwcCs+cTwiea/Z7qKRYeJo8SgSwzKn9u0r+Ya88ps/bGlOSubBoSkk9n8qv7geiOKai4PyccHqZy+TfHt9wSBKUKYKYRRsbzvr6Ume1gielGDy9MaWKSdkFj4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160741; c=relaxed/simple;
	bh=KuQ5E3eVq1UWPSmDHWGZZMjz5jftlQPhOrcVUdyo+Do=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TxKPt/8Tx7A6VBkF4EFg+mb3F0ekTW6ekliYedGM6LCHKKAvxQZZmfoNWTvRVD1j0tKw5QgFNjx+ZxwyVDwTlmP0WsvisppvllJygU3UXsU9lX48CRnlQReSyXWATgjWDBgfKYMUimOPMQ/N5ZC0zzI2ZItU6y60L7iYzG+Y8Bc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ifE+CXV4; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=ifE+CXV4; arc=fail smtp.client-ip=52.101.69.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MpWobcYLTMfVipbtIgYnxzWpOWDDX61Yv2zyGIAtScEor2+/s+W6Ar+erl6JwRRerbP/VTO4jaVk1SFeiM4ZdzPAQk88ZNj8g7b+E7ZS6nWCck8KuahR+dBNaP6vOouzJTJBkHYPPuELRhnVonO5sCbaYxQqKcDd8KTrGr6fSJ+WUS/niGZQo/yIaemC1/WrEyexEl9coyYZJG+vqVqgsz20kn8gW/z/ydx8MO9khWLx9RNTpSgskQAvOg106W4KheEkAmmRTaUFrf8+/pZIxyPCiC5eTWrVFuZ/UTh1QeVwfGVGBeTJLgYejxFyoRYBxG16C2eD8owwKTCt9I9bbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+qQ9O5ym1wAc5h6RbmV7d35GQOnYJP8Zj6JiTJClI4=;
 b=KtGygJI3qsy77lySc0J8lMxrg0sOG0XfB/t6vmKASBYYbexbnDWMWQ6CmTUDbeVlMj5QGggi5W5yMC05nkcaCaYPdxbMmFmosgd+gK/oWoElAa1Vw8EFmXXC8PxkaFMR5AMwRuZIss/ba5JOMu8v2OTz64J4wvdb0chrtjxD8hzlt6WHfMqs/2gY0l8gBlf5KaTOYmtl+hoDCGflDlqGJ/0m5JSMU0QncSOqcrQtOH6GLNhuMCAhT8jB/2xS5d3gKgsjd8Sgt10CAXsXcDM/fLEHUd4FfiE/j4v+NC5GmkCwJWyFSKsmj8mebu02tTLH0Y7Z29LGYUCLKisIoIairA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qQ9O5ym1wAc5h6RbmV7d35GQOnYJP8Zj6JiTJClI4=;
 b=ifE+CXV4Gftw5/uGyXQ1wSBGEWC9klMnqrV7VJbS2aHnL8YsOVwSi+1r5pnGupvRKXB0nvAVNig2L72iZTSL417q2fuG50Ct1XxDtJQTLnJut1Gp7/hZTKFQNGsXa6DFPU8jyNudHytMnAbNrJsveRBD6hXbbtwy8v+18Z/B9k1ZeoOHbJsgfdvzBYXfzYNQhrXxc+rjwWf0LeJWNqx2kuvhKAl+4uioY6iL8fIo/fxZfo4px0ecQCyPbwh9d+6QAbiA+yXtfjVJf0pfpC+2I1s/IsuXwNdGmLnxNFVZhhrcU2b5a7tVwgqP86jzxJkCPopH2cnJJy9l8Ambm3r3uA==
Received: from VI1P190CA0051.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1bb::10)
 by PAWPR03MB9057.eurprd03.prod.outlook.com (2603:10a6:102:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 13 May
 2025 18:25:34 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:800:1bb:cafe::ec) by VI1P190CA0051.outlook.office365.com
 (2603:10a6:800:1bb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Tue,
 13 May 2025 18:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.1 via
 Frontend Transport; Tue, 13 May 2025 18:25:33 +0000
Received: from outmta (unknown [192.168.82.138])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id A74D820080F88;
	Tue, 13 May 2025 18:25:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown [40.93.81.77])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 1DFEB2008006F;
	Tue, 13 May 2025 18:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PG1h/Ux8KV9SwoFqPtqBgaYOIeDu5DAWR8ljptjaf6S8tbcZqvHbZAS92WpP+KNqkDRgEI5nyz7zPnZheYc0e2uCETDBoiVDRVMNTdanz6V6QcrFvdL3VKN1yPq8Vsg6BPucqX/3OKXFL0wCfyGsrqH8+UKe+qOLCQIcEew1QW40e5pvpncbrPxcV0DI/Tk2NLz/Ass8zqaZPwBAOtkJJ5BIHw3kZFyLczDW/1BXE7oYQR2zwUiUUEyYCNCgsPGvFvBfBwxR07xXZxgnasxF0btNBLowicYXD/c3KYtDACGcySi41/ii9s1UzsC4EgS0qCkQD8K/benOdELc/Aan/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+qQ9O5ym1wAc5h6RbmV7d35GQOnYJP8Zj6JiTJClI4=;
 b=nfvFMHSMLB+EW0BY1U13PNA5zGk0kE15Cap5bRjUT44HotvyKYS/fZdP+ZAltCiVuOIRuf+fW4olF7vPVgr5Zml3dJDthrag5rmJsMUDxonwyieUZilo8vWIFRJAyx99yQ72BPhM86mTm98rwxn7LEyTE9z818BOK+ta+3RBKy2X+f6j/X6l4/IrQpqnVVQlNZFRAy6vTgL7ebPdk7xOTF6JCP2i0Sp+uIWIJBT42uEVVuwiZkfwf3W2eERR+jkO5gvAmdqRzLhaAYeTsNNb6AW/PSPFH1QP2rRm2t6c1ccZVHKFUgfdCxj2XuyOK/vmeW51GtS/A/uZyyK3jCgZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+qQ9O5ym1wAc5h6RbmV7d35GQOnYJP8Zj6JiTJClI4=;
 b=ifE+CXV4Gftw5/uGyXQ1wSBGEWC9klMnqrV7VJbS2aHnL8YsOVwSi+1r5pnGupvRKXB0nvAVNig2L72iZTSL417q2fuG50Ct1XxDtJQTLnJut1Gp7/hZTKFQNGsXa6DFPU8jyNudHytMnAbNrJsveRBD6hXbbtwy8v+18Z/B9k1ZeoOHbJsgfdvzBYXfzYNQhrXxc+rjwWf0LeJWNqx2kuvhKAl+4uioY6iL8fIo/fxZfo4px0ecQCyPbwh9d+6QAbiA+yXtfjVJf0pfpC+2I1s/IsuXwNdGmLnxNFVZhhrcU2b5a7tVwgqP86jzxJkCPopH2cnJJy9l8Ambm3r3uA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PAXPR03MB7763.eurprd03.prod.outlook.com (2603:10a6:102:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 18:25:30 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:25:30 +0000
Message-ID: <500bf7f4-23aa-4dfb-acf1-d00626793f2b@seco.com>
Date: Tue, 13 May 2025 14:25:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 09/11] dt-bindings: net: pcs: Document support
 for Airoha Ethernet PCS
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
 <20250511201250.3789083-10-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250511201250.3789083-10-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|PAXPR03MB7763:EE_|AM4PEPF00025F95:EE_|PAWPR03MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 25db6e2b-5cba-46e7-6478-08dd924b8cca
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UkdjK2J6SzlKSk5iTEpoQ2lqM0J3WmxFWHphYi9GcE96S3JabjRYdDZPYnYx?=
 =?utf-8?B?cHowMmhxcUw0OUVFeWJVWHVaNXFBQ0MwS2phVDRRSitEdHF1L3lWdW9ITmpT?=
 =?utf-8?B?VTluOVd1bDI5WllUcTk0SGJGR253dFJ6Mmx4QTVsSHg5SDVwWmVjSHdjOElI?=
 =?utf-8?B?OTB5UkRtWTUxQkliUzlpRWZXRTcyMTBBREZWcVF5aHpaYlcrandEN1NEb2Za?=
 =?utf-8?B?Wk92QWVNaU1sM1lmUFlBenRXWThwMjlwQ3MzelJGMHQwY1JjRlNvNW55TDJP?=
 =?utf-8?B?NWFnUkV0MGQxZzhSWmo5aUdBZExoRkUzOGZkZEN6VWZUQW5tQVdKUGdKWTZU?=
 =?utf-8?B?Y0FudjdGQVd2aDBONklUVXZ4K3Q3U3FCUmg2NTBuYWZ5Ym11MHNmYnVLQVp1?=
 =?utf-8?B?MHlhR255SzBiN3d6QlRIM092Q3BoZW9VUzZUSzVlbmd3YldqRDNPWTF5c2lJ?=
 =?utf-8?B?SjVHRGxBUlUvTUdLRVBabzlBcTZsOHAyQURkN2RUWmVEY0lQOFQ0dUt1MWph?=
 =?utf-8?B?OXFrU2ZtK2NSa1Z4R2RkRjJzemIwbWs4WG4yUkVqcFR4WkJkTnlPQUZmTFlL?=
 =?utf-8?B?QXkvMjNZUkdKeVlqelV0c0FPa0FzL2dvMWRRSEcyV0NIbmRXWnpyemVDcEZE?=
 =?utf-8?B?ZGZRVG5ITW91U1BOaE1XZG8xQXdKMWo3RERBK3MvWTh1cTRQV29WbVhqQzgv?=
 =?utf-8?B?WTh4S2lodjVWNTNyR043c0RHYXRSMkhWSjNlcUViRWVVTjZ5bElhdHVXTFNv?=
 =?utf-8?B?RENrR0lYNDVQRE4rdHJnS1ZOaEVQZ1Z2TTZnVldod1kySjhVMTBPUGY4Yk53?=
 =?utf-8?B?RGthM0ZnMUVwMkZQT2lkWTBjT3lHUFpJVmtWa2lLZGlBU2FxRTQ2QUdZVkZZ?=
 =?utf-8?B?bll2Vkp0NHp1MHVXWnpuRm1XZU40b1I0VXVnK2plSVdjK1JRM0lHZXU1a3JU?=
 =?utf-8?B?Ukg3bnZtNUJrS3lRVEMzWWJldDlrYlpCbDE4ZUhxbytITy9aa2ZTd3QzZmh5?=
 =?utf-8?B?MmovZFBmajVQNUcvVlphOVV2ckxsRXBhUXNDUXhCQ0pLMmhmdE4ySTBqMWI3?=
 =?utf-8?B?OHAzMDltWTltR2dHS2xnc3RHMEhLZWZiRGwvbjZuckg3cHkvczMvK0JkcWZu?=
 =?utf-8?B?ZGREbjloWG1NUjg5eFk2VHZzcUJmLzJka0IwRXl5d3NSZzFDZkxhMkJHTXZO?=
 =?utf-8?B?SlVqei9zay9WOFVDeFFqL0laQU55NEM2b2pHUERVUEtOcnRkNk9nSnowaE13?=
 =?utf-8?B?QUxhMjUxSGI5M09WcnBFZGJXMllTVDg2Y3Z3NWFtTUVBSFMzWXlRck92czhs?=
 =?utf-8?B?ZXUyQ1h4T2czZ0tmY3BFYTZUSDBvNnhxNE94UlUwVFIyZHptaC9iMjZKb1ZB?=
 =?utf-8?B?ZjZQUU5UM1FHeGdadzVWZHVZODVWbWxaU2o5cmNIYkNuWHExOUJtOGNWVXJY?=
 =?utf-8?B?MVh1M20vbmRCa3VybHBSMHdEcmhYbXNaejRnNk5iVDJKVmMvSmVWN1E2MVNz?=
 =?utf-8?B?TkJIZ3E4K3ZJWGZkajVzTDFLMTFXRVQ4Wkdrc0dRUk5majZScEtoN29iV3lo?=
 =?utf-8?B?WmUyMGRYR21xeU1Uem4ybldIZDIreGxxZ003ekRCSVprSW9EYjdZSHpybW5p?=
 =?utf-8?B?dWVnVzNNclJyRzB2Sjh3ZFZaNWNiM3J5WU02OExhRFFtbkFocnhPNGZTc1Zi?=
 =?utf-8?B?MGVJWlhvNWIvbDJLeVBoSHY4dFQzOHdkaFdWNDVKbHZ5WnoyMElxN3lYZVho?=
 =?utf-8?B?bnlXOEVUSC91dk4zMUhqRVNHYlc4VjdwTlJIMWtoYmpxRUtjVmZlYytJRE91?=
 =?utf-8?B?bkgrWCtNYnJDNnNoRWZsUkkvdllKSFhHSUhLVnFha1kxanNWZ1hmc2VOU2F0?=
 =?utf-8?B?cDFOVHY4dFZiVTJIUEVVRXVlZ1YrTUxYNVpoMmJYN21PT3c9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7763
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f205bce-bcb9-4dbb-8649-08dd924b8a6d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|35042699022|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckx5MXJ5R3Vqck5xdjdKSE5zWDZDeUN4aEJxaTRGakxWOUN5UzVMdlRxbGc3?=
 =?utf-8?B?R1FZZHhNZ285U041YzdCS0NOSlptZ0RKUCtNRUc0VlgxeHpCMlV6K0hkM3lO?=
 =?utf-8?B?ZUZJbkJPcmhKMlM0WnBXZGV2TnBHNnJ5ZDQxeVVwVXlrM2pWTzAvSjAzSjRu?=
 =?utf-8?B?N2F0OGFqTHVKdWE5a01FclpjK3pOSVdDeGZzbW96bVZaWWxFNGpVdGFFekJk?=
 =?utf-8?B?K2hMN3N3SFdTVkRtZTV5dk9INGxrYndib2NTQ2ZaQ1k5MGptbHVDU2hlek54?=
 =?utf-8?B?eFFPU25DUU0yamRCV25NUmF2WUxxMENRVTdyOXV2aXhxcnhuano3V0EwL0Vu?=
 =?utf-8?B?aUxqZkNBZFdMa3o4MTYva0JFbExEU3B5MnI0RUtIUGZTQjlDbnRvb0tNYVNy?=
 =?utf-8?B?b25yNkhUTXJZZlN6MlQwU1VMOFdUcm55Si9TV1IxS2dEMzV1YlpJUEhFcUgx?=
 =?utf-8?B?d2JxbmovNXlneDJGSnJtdzF5amtPZHlMTnNYS01XaUFYdEkrcEtZSjRGQmtu?=
 =?utf-8?B?Q2ViN1pKZ0ZrSThzKzJwQzBDQlM3dENPc1BwcDA2MnZJU3JRazZ0WVRaNG80?=
 =?utf-8?B?dE1uYXNMOGdIR2hFeCtYOU5mbk1jL2NuYy9XZlhkVjA5TGQyK05PeEI5V2Zr?=
 =?utf-8?B?RENUK1B2TEgzckF6TkFYeG1oVHdyVDFVeEJlTlROMTR2Unp3ODAwOWtJUFli?=
 =?utf-8?B?WmZXMTRVSms1bGNVQ1lMaEE3Vnh5YTdoWUU0cjN1SWxoL01qUktZa2dhT05K?=
 =?utf-8?B?Z3ZUKzJnUlhKdWdKZTZFNjBVUUV1NFF5T01wUUdrN0F3SXl6Ri8zYnNFOW9X?=
 =?utf-8?B?dGpydkNlUGswRGlCQURyaE8wRGRGTitrRXg1YVNLRjJyeE9iWW1KclBLRTh1?=
 =?utf-8?B?aVpoanplTkdYc2tlVk4rVHNmVDZRVm5vSkFLMjdRQmdRYVI2OUhjSWh5d1Vn?=
 =?utf-8?B?d1l0WC9KdTJ5dC9nYlN4bThVVGsxYVh6Q0VOVWNvc3JxU0owVTlSMVllcDNL?=
 =?utf-8?B?T1Q4cWgrWUl4QmJrUXl0Rk1WaHNrbTVsN3FyNU9IYmg1YUNaVlZnMCtPSTdT?=
 =?utf-8?B?S2YxRElxYWtOQWNOYXNFbklTeWVDZ05yT2lSMDBhbWZhWFV6OUJYY2JUYmRi?=
 =?utf-8?B?VjVQZER0QXM0aTFwOFNoQTE0N1Y3U2tyazJDTmI4RVdMeUZ3aVl4RGVMb0sz?=
 =?utf-8?B?Wkc5bDJIR3ZMc1ZaNnNPMk1ld1QxYk91ckROVzAxRlJDZnFBT2N0MW45YUFu?=
 =?utf-8?B?ejI4aWhEa3d6V3Y1enEvTkc1QlRMc0xWYXpuQmV6M0lBeE54eUt5aDJMaERI?=
 =?utf-8?B?RER3ejg4U28xa0txakUzZ3dWTzZycHcvSU5pdnpKZFkwandSSWRLUHN0anNO?=
 =?utf-8?B?bU1lZjZwdFZadHVBL0pKUS9LUTUrbnBaMm1QRlUxRDA4bnpyaFh6RnpZN01n?=
 =?utf-8?B?MElDeGZKTVVvQ21DWld1K1N6M3NXbHV3UUlyWlFQV3hveTdLSGtENnR1QVBp?=
 =?utf-8?B?U3VxNFhFdG94WEhxMkpUOXpGUGk4RStLRkQ0NGIwbUlHVEpWbFJOdjZ2aUEw?=
 =?utf-8?B?cnJhNDdzWERIdkZHU3NqYm8wQi9EazMwT3IvdlpQQU1abGYwY1hQSzY1RXpI?=
 =?utf-8?B?UUJnVW04amtoSWxZUjYwbjdqMnlkRDYrVCtLYk1wRUQrZmlLbERESGlsSkFl?=
 =?utf-8?B?NGZxZHkyR0tCL1ZPWGN2VWxlWWoyNjV5UUFpUzAydHNkeG1ROXM4TVVDSE8r?=
 =?utf-8?B?SzJiNjBpYXNGMU9zVUZjbURUYzNVS01NdGVHYWpwRHFWMWlFaThscWVrMnl3?=
 =?utf-8?B?dS9MWXV2MFJ1OXRlQnVSUUZIbHRzSVdHeUVwZnNJa3dBMWNhNUNKVHg0NkdW?=
 =?utf-8?B?c1hydUNBaTM0dlo5M3hXQ3FKaUpaVFMrMzRORDYyeUtET08rZWYvZWIrNVFO?=
 =?utf-8?B?c2dVY2hDa2JEYkNyN285VzVXcHRoK0VhT1UvaVFKR0tkcWs5U0lKNjh6NzRS?=
 =?utf-8?Q?6MEykBdhZdrWkmiLJy3G7WUXq/A6RI=3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(35042699022)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:25:33.8308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25db6e2b-5cba-46e7-6478-08dd924b8cca
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9057

Devicetree binding patches should come first in a series.

On 5/11/25 16:12, Christian Marangi wrote:
> Document support for Airoha Ethernet PCS for AN7581 SoC.
> 
> Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
> the various Serdes port supporting different Media Independent Interface
> (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
> 
> This follow the new PCS provider with the use of #pcs-cells property.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> new file mode 100644
> index 000000000000..8bcf7757c728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha Ethernet PCS and Serdes
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for

The Airoha AN7581 SoC exposes multiple Physical Coding Sublayers (PCSs) for

> +  the various Serdes port supporting different Media Independent Interface

ports, Interfaces

> +  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

10GBase-R

> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,an7581-pcs-eth
> +      - airoha,an7581-pcs-pon

What's the difference between these? There's no mention of PON above.

> +  reg:
> +    items:
> +      - description: XFI MAC reg
> +      - description: HSGMII AN reg
> +      - description: HSGMII PCS reg
> +      - description: MULTI SGMII reg
> +      - description: USXGMII reg
> +      - description: HSGMII rate adaption reg
> +      - description: XFI Analog register
> +      - description: XFI PMA (Physical Medium Attachment) register
> +
> +  reg-names:
> +    items:
> +      - const: xfi_mac
> +      - const: hsgmii_an
> +      - const: hsgmii_pcs
> +      - const: multi_sgmii
> +      - const: usxgmii
> +      - const: hsgmii_rate_adp
> +      - const: xfi_ana
> +      - const: xfi_pma
> +
> +  resets:
> +    items:
> +      - description: MAC reset
> +      - description: PHY reset
> +
> +  reset-names:
> +    items:
> +      - const: mac
> +      - const: phy
> +
> +  "#pcs-cells":
> +    const: 0

From what I can tell you only have one PCS. So this is unnecessary.

--Sean

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +  - "#pcs-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/airoha,en7581-reset.h>
> +
> +    pcs@1fa08000 {
> +        compatible = "airoha,an7581-pcs-pon";
> +        reg = <0x1fa08000 0x1000>,
> +              <0x1fa80000 0x60>,
> +              <0x1fa80a00 0x164>,
> +              <0x1fa84000 0x450>,
> +              <0x1fa85900 0x338>,
> +              <0x1fa86000 0x300>,
> +              <0x1fa8a000 0x1000>,
> +              <0x1fa8b000 0x1000>;
> +        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
> +                    "multi_sgmii", "usxgmii",
> +                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
> +
> +        resets = <&scuclk EN7581_XPON_MAC_RST>,
> +                 <&scuclk EN7581_XPON_PHY_RST>;
> +        reset-names = "mac", "phy";
> +
> +        #pcs-cells = <0>;
> +    };
> +
> +    pcs@1fa09000 {
> +        compatible = "airoha,an7581-pcs-eth";
> +        reg = <0x1fa09000 0x1000>,
> +              <0x1fa70000 0x60>,
> +              <0x1fa70a00 0x164>,
> +              <0x1fa74000 0x450>,
> +              <0x1fa75900 0x338>,
> +              <0x1fa76000 0x300>,
> +              <0x1fa7a000 0x1000>,
> +              <0x1fa7b000 0x1000>;
> +        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
> +                    "multi_sgmii", "usxgmii",
> +                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
> +
> +        resets = <&scuclk EN7581_XSI_MAC_RST>,
> +                 <&scuclk EN7581_XSI_PHY_RST>;
> +        reset-names = "mac", "phy";
> +
> +        #pcs-cells = <0>;
> +    };

