Return-Path: <netdev+bounces-190224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A79AB5C20
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143553B7675
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF7200112;
	Tue, 13 May 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="NPJ3hJ2h";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="NPJ3hJ2h"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022099.outbound.protection.outlook.com [52.101.71.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2728DB7C;
	Tue, 13 May 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.99
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160229; cv=fail; b=ElDjyWUaJwN1Y5Xlae+4kBzFbKV60qBB3wHxDaWHEScc/c8dYhAEVmxqCXYnWbgPNloCxIOufeVlPMr9h8pgv6xU2jXboYm2bFbkbDHpA1hRWckQda4qq5mvN8HCIcDXhuFqF4VF0siITAFV31ohS10NCPdtgwWTD29d7hytDhE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160229; c=relaxed/simple;
	bh=PN0I+s4a3Oca2Y8dF8+9NM9ctCef67KGAQttlEXuVjY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7sfhyQlURH/BBc+CIquILc3vJoqfgSzE2Tj1MK8Dzgg5TR59Jq6zHsnO97/wJW62TCoucbZTkuQ2DFMYMkBaXbxZODCvMiDbapX3QXiH9MyRmoKui48u9fI7IQZgxj0sNwn2I3ojw1rIplOe/vjDZL45qEu4Zu2jt6cQH0AkD4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=NPJ3hJ2h; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=NPJ3hJ2h; arc=fail smtp.client-ip=52.101.71.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QCPxixRqyPtQsy87fNe23WIdp0tbtZZ0CEVHjCFiu8mw7B4BbSmdxXFQrDtITjwH9pWMqQnU1Qt59L9BQacDtjvnvnIhXnjQlHLPKpr2UeY91S8NT35smyRA2Lu8nNz/0m0ZjdOfIADuYDZvhppNuSgodYKY+V7aBqy7NfXEYD83NNMqPUC5Y4xBMuYRxAYyEi8w8w2xdPK2ceam84p5Z+xFqgd1rJ7Z8aB9+NWUa5/S9mbqS6udpqtyHyZo1Jis12efSm2Ua2cbEXgmsKOcM2UBpleMN67+u67k3V9qqSY7rLZ1cEoTzKb8XJ1MjKVEDNCoiksdhGarCtkPBFMcwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xOUP80MmzYxdt6nvpSX9RFdQV6/AW8DY36snDMgTGA=;
 b=ywDPbLqhHahmG2fRSQFbOoGgrclbi0/VxCQJqHk2JVDyTMuyFb+cX6ddJ3Vyrcu2+0xCWp2rclQmcUwjeJxUVeJ4653Yloos7KtJK7zk6em2WsoyZ+Wmj0DncNElihw//PUn/RnT84IPIFxjeujjY6VNFRBJ5DHjsvsbq29JoNXFaiCSBeURCyxF5R9MYG5lV4NCnRfBY0ZVK6oD6dOhkb1NsA6+zI2OBH4HvP4hk9ICt3NJxu6x26DBSlp/tDNOmVoClLsQc3eSHGq+lXvqshbEoaE/AD10rGmjlgsEeh0k80/LqslZOMQ3SVBmy2CM9RFD7qEwpY/aT/2PKAH1qg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xOUP80MmzYxdt6nvpSX9RFdQV6/AW8DY36snDMgTGA=;
 b=NPJ3hJ2hHs4i0Mp2z70Eyi5/axuHMkVy5jgj+SJp8TngGEM5v92Gkx9tcBzJK0nUvGKzzspnHk1pkg21iwkJ9rcTMWxC9vZs1edo53+FSkFltaXZWfS/DZ3CLmzxyDDZA8Zlst7QH0zQ+GVNzWIKMWxlKQgRyUulKoVSWZGWAvISkw181zufUwVodNrCufXn/JIDAGcCSsv+bVI/GUGIs7/dvHagIC13RlgfG4/KaUbMbQJW0ImseWr7Xsns4oX2tTp2DrHH6GEw3UNC2g4IPMxkE/++NBZpgaHsDftREP4NnSiGV0q8RGcdNLcKl84/BaNfTw3VjMxoMXJ0UNeyhA==
Received: from DU7PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::21) by DBBPR03MB6796.eurprd03.prod.outlook.com
 (2603:10a6:10:207::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:17:01 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::c9) by DU7PR01CA0043.outlook.office365.com
 (2603:10a6:10:50e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Tue,
 13 May 2025 18:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 13 May 2025 18:17:00 +0000
Received: from outmta (unknown [192.168.82.134])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 2CED42008008D;
	Tue, 13 May 2025 18:17:00 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown [104.47.11.44])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 7D1212008006E;
	Tue, 13 May 2025 18:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1riGgMHNR/AsDxjpMIiMnEaBJkvJXsQPkowNBSbb5ehRZxKt30Sg7uFyyM5tODcUxDhPZCkSShqHBQGvEu6I5vq9HKqr2Hx4tOXGYZHqrYYKilJmePPBxXTt7S1yi514LkTa3fAmQ08Jjw0iFk1bvEt6y5RT3s7KHwRrzVpK3K0x/5ddiXX2mgV4XSdgq+3CoP5a80Q+5Civp2mJPAKF6/IfSQw8/3dB1byZeaO7vELmAfxGdgFGK+jFKD/ezsSGpY80laS+/VlcoZYWlHgcAl2f5vG657dh31zwQT7DJDhVKrkNBCP7D0gag8MlUxDK3FojIYVJDtzWDfofnswDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xOUP80MmzYxdt6nvpSX9RFdQV6/AW8DY36snDMgTGA=;
 b=JBtONQPHnIFRQfFAT8B2YzBl1pXNyEIyJ9mjBIAlHknpXvRh31lo7oqtqTiNyn+rBWvVt0PGNuCncYbuY4wMyZhajzvfWL++Ri+ucm+eZkd2qefoZOG47aRs/bgi292SzMtcar8t3Umz3io6lWfZSIc/I0XbglohveY9cBlrl4+X2mSiizfJn5xvd1l/kkNYbVCE7q8FUeIcoeg9btzry0kQMYb0UW3A6HVhHR+mXbYpCHXqnrrRKQWXPjHlKKCVaOZLZ/Av1iolZH0hYZ5qG4JuTv1I72Y3yLbHWAyr76iYBjJueYcIkkdPhbT86ijajErxp5h2WfPlqKyZ0HlfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xOUP80MmzYxdt6nvpSX9RFdQV6/AW8DY36snDMgTGA=;
 b=NPJ3hJ2hHs4i0Mp2z70Eyi5/axuHMkVy5jgj+SJp8TngGEM5v92Gkx9tcBzJK0nUvGKzzspnHk1pkg21iwkJ9rcTMWxC9vZs1edo53+FSkFltaXZWfS/DZ3CLmzxyDDZA8Zlst7QH0zQ+GVNzWIKMWxlKQgRyUulKoVSWZGWAvISkw181zufUwVodNrCufXn/JIDAGcCSsv+bVI/GUGIs7/dvHagIC13RlgfG4/KaUbMbQJW0ImseWr7Xsns4oX2tTp2DrHH6GEw3UNC2g4IPMxkE/++NBZpgaHsDftREP4NnSiGV0q8RGcdNLcKl84/BaNfTw3VjMxoMXJ0UNeyhA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM0PR03MB6305.eurprd03.prod.outlook.com (2603:10a6:20b:157::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 18:16:50 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:16:50 +0000
Message-ID: <50c9606b-e671-4c87-a126-6709c9364f47@seco.com>
Date: Tue, 13 May 2025 14:16:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 07/11] dt-bindings: net: ethernet-controller:
 permit to define multiple PCS
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
 <20250511201250.3789083-8-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250511201250.3789083-8-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:59::17) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|AM0PR03MB6305:EE_|DB1PEPF00039231:EE_|DBBPR03MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: a65c27a7-5fbc-442c-c014-08dd924a5ada
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZnBPaFZUV1J4TG4yQllKTk5JeWl1K3k1ODI3TlJqcWRjSHpKcU9jNEhYcjhM?=
 =?utf-8?B?Vi84MGFTbisvQjB1enQ0N1pKaVRyQkg2dFBiZ2FXTlNOTGt5SFRnSlEyU0k1?=
 =?utf-8?B?RHBHZkpNUXdKMEZvNFVlcEx0V0tnUWkvYmFETnhaU2RwcVZuYkNmcVJ3Ym1p?=
 =?utf-8?B?NThFK2F6bjBpR2JmenFCaWJvZ0ZEYzZwMHBSYjg0bjJPSGd4alo0Zm9PSVUw?=
 =?utf-8?B?RUhhN1F0SG9La0RBYjFQL24xU2c4by83YXB6dlJFNXRKT1dVK1hzbksvRDZa?=
 =?utf-8?B?TjdoYlVicS9BcUZYb216TFVieGNnUWkydit1RFFFa1A3NVJmSVhSMHBkT2th?=
 =?utf-8?B?VEdSaGtyMWZnNlRQMnJmU0x1RjVaNWJCRjdBRXJJUFluVGlzQ0I4N0VWK1Z0?=
 =?utf-8?B?RGQ4ZkNWZkNMSUp4eUhOVk5yL2QwdFh5aGowa0cwVFVzVHNISUdoUUh4UWRw?=
 =?utf-8?B?VFF3d0k0dUNBdmJ3SUlyRk1oQ0VBME5NR2JQR1VVZ2lTM2lhYWo4eEZ2cTVU?=
 =?utf-8?B?elJQVFd3Nkd4SWR0NVRkZzljZzduMnVyQ1RhQThIQStzV1pzaEppaFlocm9W?=
 =?utf-8?B?YlpMc3Z5SEw3bExod3ZDa1o3UVAzbktGTDJaK1JSTUFrcEFUaVdBdWl1R2Zl?=
 =?utf-8?B?Sm9nS2xhKzBNSG1uVURKSkFkWkdqNVBaQjlrTVljSGtaNWhhUVo5R2RYanRi?=
 =?utf-8?B?ZEF1QmRZdFUvN3JxWFpKQitRaEswQlk3MU9RdnBCY05Fa2FNMVdzU3YvN0Rn?=
 =?utf-8?B?MkdQT2JJNHYyWDVNVTArcEZWZ2pndzU3WDJTS2hPMEh4MnQzTzJ2cmxCUWFQ?=
 =?utf-8?B?a1VxejZZVnBUbDZKZTdlb21vS28vMno5b2NBcnZ4NDJQQzlNdnB1OFBOQW5k?=
 =?utf-8?B?K0tha3lPZURicVM4clh1R0FtVWh5WEszNmRySEF2UmtuL2tLM2lXcUhkeXRm?=
 =?utf-8?B?czVxcXNDNkVlYTArT05oM0hWVWVuNEhTbWVZUVovWDdpbGIxbHk2M0xoa3dw?=
 =?utf-8?B?SFdPNG1hQnNoSmVia0JHa3Y0ajBOd0QrRVpsa1JrVXM0RzlyNFN4VzJuQ3pp?=
 =?utf-8?B?aW91S05DcnBHTEliQXQwWFJpVktzb2h0YzVnMkd1bnVtU0I3cDdQWEVrMVRF?=
 =?utf-8?B?QWMxY2FUMmRYMitXN25URlZ1NDZ5V0tabnRaSnZtaVpreEhNd05abWJSbXhE?=
 =?utf-8?B?bE5iT2F2VWxQL3Z4aFlGMlRZUVZQYzNTYURpdjBUNkhCbzhXNEJhZ0tzSVNF?=
 =?utf-8?B?b1NBQ0tjbXJqdXNHSGhpdUYyNXo5TktiVUJoNWR5U1ZXaXQyUnQwRUJkMm9x?=
 =?utf-8?B?djQ2RXB1U3ozYzZwb0hGeFlBK2d2VFRIV1dUMVFDS0JKa1M2QXU0aHo0QjdQ?=
 =?utf-8?B?ZjZwd21DSWZxVFJzWmk0ckxKUnVsRm5NMDBiQWZzZnNrOGg2N3I0WWxMYVhq?=
 =?utf-8?B?N0JwY0VkQkQvdU5CVUVqeXdVL3Y0RWVvZWNXQm5kV1gwL1d3K0Z2cElwSWxK?=
 =?utf-8?B?dnFHYzBmVkN2TEJYdjRmSnA5RzlSbFdMSE9NZHpzczU1djEvbFdGaXJ2Nm8r?=
 =?utf-8?B?SjlFZ3NqWUMyMVVhUHA3bzl3Z2lZSE5haWZqcWQ5L3p0WjAwOGZ3M0tFcnJn?=
 =?utf-8?B?MjQ4OEVDMklIWGhnZkxNOTEzV3dxQzhST3ZpTjZLaERndjNMb0hLdWxyYTVJ?=
 =?utf-8?B?a0w5d1M2RUV6ak1MbzRtRlJEYkJaTVBGb0N4cDhmRWt3ZGJQZFRSTWtGMFA2?=
 =?utf-8?B?T0hrT2JSVmFlZHRlZGsxNXMva1BhYWhwYXQ2ZGVzNFRkTVZ2VjhxRmZRZ1dU?=
 =?utf-8?B?bmliL2I5Ym5hMDNsM1JxOXFTSjNXcDhsMzdWejE2TTMxQTQ2WERUM05wMC9w?=
 =?utf-8?B?bFB4dG1NQk40Z0s2bDVYcFp0S2Ztb3BQZXl1WnhPOGxWNmh1UDZxUEdaZ1Zj?=
 =?utf-8?B?TmdGZCtzMnBGSjczYzJDS24yNjl2aldWaHhFVVFYU0ErQlVtNitGN2JXL1Qy?=
 =?utf-8?B?Smc4TktqK2dnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6305
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f698e245-8677-47d1-2104-08dd924a54ad
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|14060799003|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1ZvMllaSEEzYkZLd0gyU2hHRzFPd1V6Q2hVSmg1SU54a1Yrd0FONnZZTmM5?=
 =?utf-8?B?eEJVWVI1Sm5qSDQ2WC94bWtCTzB0SzBmdUpSSmo1Yzl4Q2xaQ0NGYXBuWDFa?=
 =?utf-8?B?Q0VWcmZOQ3J6N2tZbXFiNW9FdGlLRldZRmJOWUdyZ2swL2JIZ3Rhc05JSVl2?=
 =?utf-8?B?Nit1MWRrS3RqWmt1VWtmeHdyUXRxVkk2QW9WdXJwNkxmNkpzSXJvVkNnbE1q?=
 =?utf-8?B?TGRxT1ZFTE9Dc3JueXJQUW9EdDBta085VnNuaHhNaCtyN0NSblFVQWRseVpv?=
 =?utf-8?B?SFZ3SHk0V3hnWUdxODM0K1R6Z1d6bEpvOWtlWHBHaFJid3N1S3lFZHZ6YmZN?=
 =?utf-8?B?UVdUN0JZZjFEcjdCT1RlV1ZMTVhlRTZ4ZFBlMldSSGV2MTlrSE44R3lVMFlY?=
 =?utf-8?B?dmwxeWdPc0tOMFdqbUlwNExOcWpWdGNsT2kvVXBFaDhYWkQvcFJmN1NzS1hC?=
 =?utf-8?B?K3c0WHE5SzFhQnczSFhCWmZCWjhXMHhaYTIxWVhNbHg3RGp4b3FyYS9HZjE2?=
 =?utf-8?B?elcvUkJwNTQyejZWYUZoLzVhSkVxaHhSNXRBN3ZGeDVhbHU1VWM4dXN6Z0N2?=
 =?utf-8?B?SDZaRnJkRmE3SWxSY3lLTVk4b2wrVG9YdHRIRHo0S2FXTklqUHprSDJMSDZ3?=
 =?utf-8?B?WDN6L05BWDNhNFNoQ01xOWZCYlRzRjU5cFVDK0VyR2NNQkVkMnhmN1o4RlQz?=
 =?utf-8?B?RU5oaFZSNjUvem9KQVA4TWowY2E0WSsweWVPTTFJYmhCZFVJVkJMV1N5TjVK?=
 =?utf-8?B?RllkTFJ3VkJ0ckFXbFZpNE52TUZ0LzBOSDluaCtkQ0EvSkNqeDQvdUNTSFN3?=
 =?utf-8?B?SGNFSkh4R1dXaU1HM1lWTUxjN3AzcHRxa0xNbkErY3FOa3VLVitQVW1EVEJk?=
 =?utf-8?B?WUNTZXRTYmtOUng5YzM0V3VFSzhXZWVIWjJJTWZwNDV5SVRzZm01ZHBLSG15?=
 =?utf-8?B?ZG1ENElPd2hYYkdzTjQ3b3RwVzB2OHJCRHl5Z3AxYk5XdnFHUVV1NEdrWjhI?=
 =?utf-8?B?ckVSUUlma0xZZWxLWHpKclFKMkhVcHRhTkFZc053U21ndll0ekNRQlVVZUNC?=
 =?utf-8?B?Ylc3TDg3a0VsZWFQODRuSGROYmpaa1dyWDJja1pGM2tEaXhNcUFsUEczaFZ0?=
 =?utf-8?B?ajVDZng1S1duWHJXSzVIcWZ2YXpKcWZVN1BTM0hESWw0clpRUGloZTdrMEF4?=
 =?utf-8?B?TWJtVXgwdWtuMlBqV2c4WXJ6R3NuOVRmRjZQQmZjKy80V1RBdk5PWEM5MndJ?=
 =?utf-8?B?RnBHcUJPc2NqQzBSM1R6T1hzSVNzdjJvOGkrL0FXK24xMFQ1RlhKdmdFc1ls?=
 =?utf-8?B?STFvRmgyUTZYYlByYWNDcmxzWlBOeTVHcDB0TGt5MnJpU1JoNURTSTF2Z3ZP?=
 =?utf-8?B?YkpLbWx5cXFIMG03c2UwemphbXhsUzJ5bHlhcUxpN2g0S0JMZzJLQnZ4NERF?=
 =?utf-8?B?OUoreXpqTUVUcndBNUJRaDB3TzB1NGNyWjlZcUR3Mzh2MTMzRTVCTmNrc3ZC?=
 =?utf-8?B?YU9va3JnNU9EYmRtUWcvQytNOVRWQlZXR0VDa1JHb3ZSeVFielVWcGkybWFB?=
 =?utf-8?B?NGNtbnM1cThrZ2JmVjFXaGRSdi9rNC9GRzFpWGtDdDlWWFJ4bVlFMG0xbnZq?=
 =?utf-8?B?QjcyR0ErVHpxTjJVK0dZaFhWS1BMbXpJeWhmN0NYV2xsL1hFWTV6L2E2ZDRW?=
 =?utf-8?B?alBzL0tVMTF6bVBKSEJjSElRWlN4bHpTRmk1NEZrQzMvVW5aam0yUFVyeWdy?=
 =?utf-8?B?ckx5SWhPV29TVjVlaWkyKytTcHd5UnRYUVEzRUZpc0ZnZHBYYTA3S2VZNE1r?=
 =?utf-8?B?RjNzYm1GR1l6aFF5QUtUdmQxR2VHOEw1SXkyK0VCc2Vmblp2R1RwaVVFdG9F?=
 =?utf-8?B?bnQ1MklEdC84U1ZBeE54QWg0eEpzbXNFdW5FNExaaG9zV0ZFQkhOSTN1L3F0?=
 =?utf-8?B?eGNtcHNkbmFIcVJmT2g2aWlBWjV3eDlyaXBFNDFnbEI5ZDJEUFNENGpiM0NM?=
 =?utf-8?B?My9aVkhQMzdONkxPbXRidlhNT1lKdUtCM2VrUVFMQzZxc2lkYXlvWEU2d3Zv?=
 =?utf-8?B?Skh1RmxibGpvaEdtR3EvZXcydkR3Z3hYaEZSdz09?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:17:00.5268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65c27a7-5fbc-442c-c014-08dd924a5ada
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6796

On 5/11/25 16:12, Christian Marangi wrote:
> Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
> can be defined for an ethrnet-controller node to support various PHY
> interface mode type.
> 
> It's very common for SoCs to have a 2 or more dedicated PCS for Base-X
> (for example SGMII, 1000base-x, 2500base-x, ...) and Base-R (for example
> USXGMII,10base-r, ...) with the MAC selecting one of the other based on
> the attached PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 7cbf11bbe99c..60605b34d242 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -84,8 +84,6 @@ properties:
>  
>    pcs-handle:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      maxItems: 1
>      description:
>        Specifies a reference to a node representing a PCS PHY device on a MDIO
>        bus to link with an external PHY (phy-handle) if exists.

This just specifies the default. Bindings for individual macs can
override this. See fsl,fman-dtsec.yaml for an example.

--Sean

