Return-Path: <netdev+bounces-109258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FB92797A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797B61C21633
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14691B1209;
	Thu,  4 Jul 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Bx/kK4af"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020142.outbound.protection.outlook.com [52.101.69.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A81AE0A2;
	Thu,  4 Jul 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105432; cv=fail; b=dmr4epjX2t2YiJoMiVdSShP6c4BmmkCGJzsWANOtRLi7mWPARe4ItlgsE8eipNOSqv/Zgayyhv0PxW0Thec63yGNv2Wx/CWaLSld89G5tU2Y5P3a98uAdImUlKRG2WSg1qQCskLxKWoeQ/EBgW6JGxnGTV1wsvEj7PKxmiqpZPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105432; c=relaxed/simple;
	bh=I8c5Dmd/REgDEwT4s3aisaE/9M8JScc8cTBTcH1aYW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k5zL+pdQwhYwcbnucuCKXlc36QSjLLS21ZWhSaZyFnDpIsc/mOPDPdNC3a5H3wNIjSf79gfZMjH40MvgR6lmYc3BaG+qLZ5z6DL3gtsUM2azqL5B5sUcMNlyPC0PbtIdJL0vgML1pwqHlO9Tf7rplvWH/K9iOGxFrthgT9hXQyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Bx/kK4af; arc=fail smtp.client-ip=52.101.69.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciTZA5JBB6rXe7GoTRUt9XdRL9n3mUTmxmaKyvJVOlEdx1zAQowJ67MFCuAZHE33CxRpBytYlsoUHK7JKZlb4pdDrfP05OWGJqSBByxOkTPyp9WOAKIkj/dy5v9YOE1bfxMvQU9BNa3K77OqP9qO0KOFarPSkqVNDZpHSNQFDXG45Vw1lhaccJ/6CPlGc1xqZ41nH3gGbYwFJstHdo8as2qJ7ABZhxo8k2rL1E50SjiugqJUCvXMNeQrGditmVeQ4Bekn84kJcd7wlQO32Uasryj3WFSuUig/2Ssng0Q4xfCsHP9VRyQ992ILmd3cP6wVO6en3kGL2FNoZYx2KhO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=BSm/XNC14Xs/MuSySDRPfiXGK/EhMVwf3B2DGAZpDJtvlhz5oR6QNpTOIxnC1pzk7luTKNVVjWR76jG8hMMLGUo2Ma1l/q+Kknc4OOJc33CFTq/Bb1Tkj9AVodB7/b2N4EUjqQcg+EnTuKloM3OKGY+8qPErm3lwGSiN01qmlZ9EDPn7PP21iP5v+mxYqawY7jOzUj6IUzVF200eWlIxwFiOu7CnAs9e2Z97qAGOF51glbTSS0FnfHNCfWgKHsF6XoTsn+mml+urI9eocdC4PLnimFeSv0cqlxWi3+zJdhbv5w/0uQhLhXJAYjN6HeO4guhH+G78XAzvGcbCOGQc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=Bx/kK4afK9GGpsv5ehs6omuIKOfZgfKIXKKqgPZqbMC5TtJhpbIS4/KC/TTQRtjaKIzPSXZHzD29Ew7/Yzphdbzr7+qPrYXgggdkQ+oWXLlRwLBGWSPkrqXe33SQCigHYz5obqa8iOLmeaR9n/W3q0lARtVEIeYXIpdQlsIgqY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 15:03:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:03:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jul 2024 17:03:19 +0200
Subject: [PATCH v7 1/5] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-cn9130-som-v7-1-eea606ba5faa@solid-run.com>
References: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
In-Reply-To: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: e674f3e5-0e9f-4972-139f-08dc9c3a801d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUgxUjM0RDFMTHVDSXFVQWVMUzBiNkJTZFFkWERtUC84aEJ5V3ZDV2ZRb0dn?=
 =?utf-8?B?bWFsOHdINUNVNXpNdEhsa3hPOUVwOElhU3R1djRZaytZQ0RtMEsyR1JZd1dT?=
 =?utf-8?B?eExSYU0yVGlnNlpiVHArTlNCYTZteVlNMVJEUDIxNForSW1mMXVKVjJTWVND?=
 =?utf-8?B?MlRZWkU2dzVUN2tyMUw3WXFod1JrUGZ6enlOR1lMdTNLbWRWNGtmRFcvem9q?=
 =?utf-8?B?N05jTTJVMnJHUk10cU1TUVN6cGdKbjJPek5QVmZZazBOOFNzc0xjWUdRc0Rw?=
 =?utf-8?B?MzQ4L0k3V1NuRGdyd0hwNXJhRUxFSnZ2UUgrS2lXbXJEQTdjOGMrRXNjYnFj?=
 =?utf-8?B?NFBkalhsUnpXV2JRWTVUalZxWW1HeUkxNGdYT2FEcGRWdDN0c0ltTlRFTWda?=
 =?utf-8?B?T1lZNmtYeG9tQ3doVDZxNndadkJWMUhGWjVjSWJNOWw4U1k5ZmdQNEp5Qitw?=
 =?utf-8?B?ZDF6RWROeFlUMnk5UmtoRGNMTXhTVGN5SHpXNXpuVXNQY3F1Qks0SG1qWDlt?=
 =?utf-8?B?WGpUZkl4MkdMU3NHMHNsdlh1QStGWVUxWDhQNUFoU1ZETTVVTUQ2ZHU2TW9q?=
 =?utf-8?B?SjRMcXlnU1p1NWs3dU9wUkNZS0hFNUtXdWRiUjU2QUJGR0trQ2Niczcrem9Y?=
 =?utf-8?B?MVVjOS96dHdaMm4vdlNLZC9zd3FSTGM5VVJ2Z2JWb2I3RjVMeEEzRXU1S2pt?=
 =?utf-8?B?T3dqS0hXZnh2WGhNQVJCSTR1VmtOOWowRFhJaHNQYk9vOGlBTHNLM2l5YmV1?=
 =?utf-8?B?V0RnWHpCa2tCbDI5QnIvZmJiUDU0akljRFQwQTkyQ0d1OHJwL0U1bjdDUE1H?=
 =?utf-8?B?ZzNsUXlhYWkrYWpxL0d3QXFrcUF5eHIxVXVlN1R3dGoyeWFQWVNVUXNmS1hQ?=
 =?utf-8?B?SEJuWW9TMVRHMUJZMEV3eURPYnYyQU5qMEZaTzljbUVUczZheXV2aE4rVnRP?=
 =?utf-8?B?b1MvQ1pNVUZrZEl5RkZLb0pxaFdNU053WkMzYWZrVDFwUFBaZWtyQUZETmdq?=
 =?utf-8?B?WUxJaVRhTHJIN2VNbUtlVVoyZmFoOHhQTVZYZlpGYjBnM1BLVVVaeElSQUk4?=
 =?utf-8?B?VlVGR1cxc0RCekdINXZBMlAvamFybERsSVdJdmo2aTZVWW5LNEZvS2l2SXIy?=
 =?utf-8?B?OEgwRUphRTAwMGNLM2hEQjN6b0NCdEtxWTAvNW83SG1JaVdFQ1lHYU44T1hn?=
 =?utf-8?B?TW1icVJ1Ump6eW1ieEkwVnhQTnpxblQyRFY2bmFsNHBubTBaL0tVUDNjRWlT?=
 =?utf-8?B?TURYVkZaMjV3bW9nWVdFQlZ0UzBWdmN6eHFyQ1FrTm1RMTcyRXIrYWFwTlhz?=
 =?utf-8?B?eTBxVENlcHJuRnN0YlR1YmcxVTdBUFdXSEp1V3RoRjJhOFJvV0JReHU4UGJl?=
 =?utf-8?B?OUNzK0xIUUJYREp3YmpaWEhMcWZqNmJwU3ZEMHBqcEplejJLT0l6ZFA3N3Jz?=
 =?utf-8?B?RU1rd2ZnK3JRTnk0YW5GZkRQRENlR1dFSDlLU3ZXRisrbzFSRzBRTVRHek9N?=
 =?utf-8?B?MStGb1lUMFk4ZlRscjNGc3hvdXpveWlPNW4vMUpvY2lhV0lDam9MM1R3bW9n?=
 =?utf-8?B?dURGYXU3UDE5QUZMb00rRDlKMTlHS3V4R3JUdmpmZHpBLzd1Vkt0ekZxOFhu?=
 =?utf-8?B?VTVrNFhmRk5JNlFIU2k1cmVvaThiRW42V29uTXFpT1IxYVQxUit4RithVlBl?=
 =?utf-8?B?bHc4WWttTDNQbjN2dXBONUZNZ1ZmVkg2bDJodC9lWm5IWnZMWklnakVNMFNB?=
 =?utf-8?B?V2JmQldpT0xYZHhpZWVhVWJpS2VDcWlFT1dnVFMrR0ZkaVJVZ3o0ekVOa3lq?=
 =?utf-8?B?SzFQbjVnTFNkUURNbjhhMjltdVdvTmtQZVp1blcxSjJHQSs0dElrcitDdGJw?=
 =?utf-8?B?OHdjbnJiaElGRGo3ZFhOOGNsQldWWXFjczVPcHRVTncxVnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWdSVXh2elJBZjEyVlY4bGR6WHk4WTE3dlBTU2Q0Nkc0ck1MS09qT2twWEcv?=
 =?utf-8?B?V0hVSmVDUlBCZEpzU0toRlBONTZBY3h0bUR4SDYyYk5rZWxRWVdxMi9rZkNT?=
 =?utf-8?B?Szg1WjVySXhpL2hZZXFNR1k4MVpXWGYzQk05cnQvbHFzcGlMYVNBcEgzZlJL?=
 =?utf-8?B?WDJ0a254RWxtN2tFOFdlaDVlVnFoT3c4SSs4OW1HQnIxdjNXRW5ybmZ3YUNa?=
 =?utf-8?B?NVhYTE1mSHVZaEN2WUM4VUVERFpDOVYzV0krV2UzN1A5a1ZLY3haVE1WZU1w?=
 =?utf-8?B?d0gvTmFIa3dBKzRjNVVPcW9NdE93VmQvZnJSY1lWZmgrOXRPdnJQamM5Nmhz?=
 =?utf-8?B?SXZ3dmtJcFBqN3ZEa3FkN2ZKV1B2QlY2L2Yxa3dNcm81dUVuSG9RSlQvVjBm?=
 =?utf-8?B?R0ZZTnIwdG5HamNLaWFFY2U1by9BYmxrMEROYm9KbHhJVVlRQXVuRmwyZ0Ry?=
 =?utf-8?B?MTdXcktaZ2pUYk5NWnZPT3VJc0JvRlFiSW5VVE5XTGdsK2p1dW1pUzVueTJv?=
 =?utf-8?B?QmxJY0tZZjVxVEV2T3cwYktMdTUzNFZBSGd0dkdlb3NWdnpvZytEMkNQSU9l?=
 =?utf-8?B?OWN6UjljMFJWSHc4Q3craVFuZm0rS3JUODhIYkNNZXdKaXJEVmxSdU90Nmxk?=
 =?utf-8?B?Sm81aHdraktKNWR6WXA0NWxNZXk0QnJkYjI1UFI5NEJYR051eDFON3RaWW9i?=
 =?utf-8?B?SjA0TnFtOXpzcXlIeEdkNWZ1eVJCTmZMTThseWR0SjNudXNSazNoRzhXUDdK?=
 =?utf-8?B?VEIyUkhWcGdSclBRS2MxU2ZvWTN4YmU3bWhZd2VweHdsdGFVdDBxRThaMnBR?=
 =?utf-8?B?V2JIWDBtOTZtWWtvMFVRVkg4MGNYWDhmYkFSRVVQU0xZemxPelpDNGtldmpT?=
 =?utf-8?B?MjJiVFZxWW1zLzdxYzZOaThGQkhmMWljb1dxallabkJXbld0aDBIY2I2dDJo?=
 =?utf-8?B?NTlOWWlrV2pGMzVrZ3MyRDFtWDdLRDladHFaVE4rclN3bGh3S3o3UXdLWmlr?=
 =?utf-8?B?OGlyU2JvOHR1b2dWYWJVT041eWJPbjV3T3JNUU9zN2RYRGxyQnI0d3pOc2lp?=
 =?utf-8?B?WjRsV21QdHFaZzM4Q080aVBQZm1hak1td1YrUTc1cWFlZjBMV3c0eGpoM3Fp?=
 =?utf-8?B?OU5zRWl5a2RtTjFsd0N2VWVLcTFPZmtHWlI5N3lvblJUek13YnZTRmhwRXd6?=
 =?utf-8?B?dkdKbHZUSUszTDkxU2ZBUDBJbWY1OEdZT01mbzU3Y21qS0VYZk1QamdxNHhs?=
 =?utf-8?B?U2Q0YTI0VE1lQ3hTWGFXZzRKWnd0N1NRU2N6Qm1sKzlaMFluMTRTSVMrY25X?=
 =?utf-8?B?R2FPSWVGbkVHY1ZyaEN5ZUFhVTU4Z1g2eFNoTzNBbU9CcmZ3V0FFbUoyMkxI?=
 =?utf-8?B?VkNPdTN5RDNEdnp2VHpUczlZK05GaVVXNEFxNElOS2todU0rWEp1SFpvVmJ4?=
 =?utf-8?B?ZE0wZm91bHdUb1BNNGZWbmNweWNwRDlVdTFLTkhiaUtSZ2VRcVRzRVltdG1u?=
 =?utf-8?B?UXNQbWM0VnY4U09rc0lQblBzVzhJTllNMzlndXpOWGU4NUJoQk9VSDVjVUdo?=
 =?utf-8?B?T1FsTlJmc1VLY3Z0U0JNNGs1TTFjWmhwVUNtS1hWQU4wSEtZVVdERHltOTZ0?=
 =?utf-8?B?NzRzdnRXa3pmc25mWVBRQXNMNnUrbTVYR0hCRVZXZkZxaFdhbFZ6S3pocWNp?=
 =?utf-8?B?UjdYdzczV2xhdXZzZlRzQkRiaFhncEM3ME1WSG80NlVzMnZwYmYxaVBOODFT?=
 =?utf-8?B?U2cwN050UUptOVNuMHljeVBtUU1HZVlEZmxVSGdIbEF6S3hjbFF1K2F1SUdj?=
 =?utf-8?B?RTAza2MydEdQV3RJeEx0RTRYR2FyZDl3QUFWenlIQzRzaUVoT1RpbEhxa3FK?=
 =?utf-8?B?UEkxQk1CUVhOcnpxTjNkL21qcXhXenNXM2FOOFk2akVaYzlDVVRiZi9DcE9V?=
 =?utf-8?B?VmJueVRhNUEwYzlxYUFxT3ZHNnlXem02ZVFPanJiQis5dnEwTjNwV2JFWGNt?=
 =?utf-8?B?MlZwRzVZcTZOamw2Vnhxdmt6VjJzdFQ5Qm15d0ZidHE3RVFqcUc3eDJlL2Zo?=
 =?utf-8?B?L3ZOajVJK3BNSjdocUdoYmRpQ0NCUzJnb3hVUldkcWl2M1p4TDlHZGtHM3py?=
 =?utf-8?Q?lv1HASPo3rxmc75t+GQ1gytf1?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e674f3e5-0e9f-4972-139f-08dc9c3a801d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:03:45.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Dni+6er4n5a4+qqQ3wy3ahbj5e5AzFrHWqAbgLq97Lud1+pjaBO/jjzszcTDwcJObfB73BmFpYsUksdcLyi4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


