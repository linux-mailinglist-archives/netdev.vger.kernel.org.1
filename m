Return-Path: <netdev+bounces-248787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D0D0E7C1
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C4A030060E5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E1330666;
	Sun, 11 Jan 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MF+CXMm9"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBD330D36;
	Sun, 11 Jan 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124486; cv=fail; b=KWy+8/IkT7/jBV0glykx/jGX/38fbJpq5V3VAhPZ8q6UNbgUOdiSmhOyPccIzHpL+3MuM7w+OpjA1X+gFlkEpl4UFGBkgnk+a0oyIrFPauDOL7Gj5hWYCMjXqa6lqkdQ0w+zTrAX4+dPNGtY/5GTk4uKCC4wMZuamaklLz+Nz4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124486; c=relaxed/simple;
	bh=qtXOqC26qlqUba+ahmtVMqnOKLVh5DNM0qXuVSkFq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PY9C75oQ7pKuDXFzzx83q0R8/JcxqZYaXWq6lmZIAq54uG5Vtkkioddmb/6POauMmdHXgNP0FTkW3+O+kJyAv7WIwSk05RCq6J83G9OcCWgHUbLhI1vU3OnE0PUXmA1XWf8IWF+CV5goOE4JcWs+St4Mass3Hkv7iUswOTLhJQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MF+CXMm9; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N22Mz8gppKtpmz4UoyhncTd4GFW4o6sr4G7+lW1hzwNHda6JOBeWjVvN7WO5Rub8Ns31DVHrSN7s2Xz8TqfhhcqMlgW/8jhAy9EBmat32YavqPK8BYmZN+AwYUYDBxF/i+bC3Vv6qzbWytaawicgxx0Dif0ugnvy0rhKWA16ccGszva8bX/u+UkXIqjey9zVxePp5hchmG1fIQtAaOC5qVwDhnHFLF/sBm6IJO3oiIzuaJVSr3N7iaYuGgybJlZ8VQ6+rwmD5tyyaOC9V+WCJkiQ93VDV/e4NGgcPvNaFv72HtXJgAPH2R0KqZXxn1RXs55JlSwdFpP75b6F3Ybwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uWcCvNYQmX8OMkeL0mA5UdJQnaa0f+GYAgH39rv+7o=;
 b=d4u7gJY+wQneqqDiReky/LJpC7aiyAWIg3AxE9oWTyuNaCiVx/w1fFBZGU/mQ3YWO8xR2AUXV883tggYPafi08tBODQyc0vyJ8xiorBY0N3YpvavhAeIhNTb1Bj9Y//LsbgIhlvNWj5FVdW+30FOqcQEu0HaBM7d/g3tew068esvJjoekoHNDh4Ajuhi9inN2cNQt0+3T1/EvqTnxFr++EZI9/QbfkwD1yMOVhzf/8owFRI1jWzVSYpSyRuZe9P2tSOLPMPCQgAB5QDw6tYO/Z7JPJ7uoK5f/czirlreo6S1rBICpa0A8tHyGno7QM6ZRTGsPvf3FPL7XyS+IucTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uWcCvNYQmX8OMkeL0mA5UdJQnaa0f+GYAgH39rv+7o=;
 b=MF+CXMm9bsRuPnrWvgGfAiQ8wUZXCiuM0DqVh6T8Ag9ccEq+x5vyiC7+NHC+jWqSoT/74XYcpkvDgVdj2HDNUVsqs73noVmgETVf5NOS4RXh2s0QLYu+Wfko0SqNoOFGE2b+wIGhrOOqW14MN2KCoCFR2J7brghIpX5rF3EbN8yVoo8UB2d0iHEuvPqQQN+KeWHS6QmiK35uhxfx5Qg9ZxdMzWC0M7hmL2XHPAeZvLvZqEhvg/ZzxVPLVVce2Q/bkIr5EwlX1IqyHxP2uyHe4+0yI25lh3ZgEk4c/HtM254GwOeGxQxRIXoXDt2/yh+q+UM0fXKs4HxeYlZ9fTZS8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
Date: Sun, 11 Jan 2026 11:39:34 +0200
Message-ID: <20260111093940.975359-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fde85e-347c-4de5-cacd-08de50f58ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0w5NVBQQytHNlZKckZSamE5eW96dmQ0SWEraGxZQ2s2UWEvZkxjU0p1aUV1?=
 =?utf-8?B?Zkd2Rnd1bmMwc285YW95bC94VCtxMTdFTzdSWWlLSjBhZ0U0MDhzcnlQZVQw?=
 =?utf-8?B?OTVKQTg4WTFHVWkvRFFCdDFPSGZ3UzFJcmNIdy9DQ3BEckM0NU4zbUFZUFA4?=
 =?utf-8?B?WkxPSkFpcGU4dEY1dGZoR1NkTS8vTFMrclVwWFd6U25XeFJiVVJkOWNkZTBK?=
 =?utf-8?B?VWxpc2lEUFBQOXlONUZZTXJCdng5cnlJTDkvaGp4b2xrYmNJZTBhcEZBSTN6?=
 =?utf-8?B?Z1hXK1g4dlBDcldwM25FVkxCUUJTdU8yUkxTTHkrck9xRmsyNEYzaGU5Ylg1?=
 =?utf-8?B?WVB6Qk9OQXRQMXdvellFUW9XT2pVUStZeTZwMk1Wc0RRN2pzZERuaGVyRzhk?=
 =?utf-8?B?ZHVEMU44WjMrMTZITDZzeWM5VFFacWt1bnpUZHc5VWJqTUlmU3pRNmxQajJY?=
 =?utf-8?B?aURCcTRnYWMrRHcrVzU1dGRTdTF0ZE94dWRLVFA4eEkvWFpEZ2tCNHRFcGpz?=
 =?utf-8?B?Vm9LY0hkcmUvZGMrMS80L05aYWJ0cEx6dlk5SE0ycFlpMVFGWEZ3VVBiVUJn?=
 =?utf-8?B?VlhwUE93bGs0SVJ0dWk2MkZoZnlaYjhUWXBqMmNwVHEwUjNIWjVVOUROdWR3?=
 =?utf-8?B?VXQyRlhPdjBHSGpVb3grT2U1QVQrUURENnpCWkRMbFBOVkVWKzU3Mk04MTFy?=
 =?utf-8?B?YVQ1Qm1rMkpBWFlXS1lFQWxyYURpWmFKcDBtVVJiYU0zcHpZdUZlSUgvUDJk?=
 =?utf-8?B?L2NiWDNSc0RtVG9zN2tpS3FUeEtaVXcxSmNiWHBuM2hxbi91cVN5K3ZRaElu?=
 =?utf-8?B?b3VKUEZQSEd5YjVvOCtOdUtjS1prSVM0Ris4dnpzMC8vNVBhUk1XTjBIbkQr?=
 =?utf-8?B?TDM4WUhyNVREUno3UUVNMGRoSVVadHlKdmUxVWdFT1kzK2JYMi9tMlk0Vnly?=
 =?utf-8?B?Y3psajAzQTArTmZEOGs1c2pnUFVWQUpQRGJvcjBPRjdsM0drcjBOT3BtbG5O?=
 =?utf-8?B?TXZGcVVnOHNJdGFiNWw3ZWQ3L1dGTDVLZ0ZodTNpcVM2MXdOQlI5WVJxUVRm?=
 =?utf-8?B?eEF3MUNLOVo2KzVBUTVabUhNc05oN2RiMmFWc1B3cXNLQS90c2E3YW9PZHRW?=
 =?utf-8?B?K1FnM2RVZDJ4K1BxcTY2VGxwSmRxS25WQkdDdDNYTFVnaElvbXdDd2c3U1RT?=
 =?utf-8?B?M05wcnJManhOdGlKT1NHaUJTUEFEU0FCUzlFNjU2RFNsS01ZL280RUIxNUFZ?=
 =?utf-8?B?ZFhJZ1NjMDR3bW9JdnhaejBrMndCL3MrVWxENkJVeFdNWkVYN0dFekpHbUdh?=
 =?utf-8?B?RlQ2YkI4UTRIWVJmOW05dDRmUlZmWlk4REJ4a0dCeWdTOUhsbTBTbTBHT24z?=
 =?utf-8?B?cmRTRStBck5BOXN2Z1R6cHdpT1kyN1BhenJhR0tTQjRGTGY2YVk4amhSczNF?=
 =?utf-8?B?Z24wby9XckFYY05hTXZLRDF3azRIWElwek5JMzZOVjd3Mjc1bHRDZWxHTjhq?=
 =?utf-8?B?K2VEb2RBK3ZiTjJLYlYwSjZMUjhZcWhIWU5RTGgvQTdwTGNQa0lYTTErVVFQ?=
 =?utf-8?B?bFJxVU9oSjVJa3lPS1BiRFZTdG9uaWtmZGlRcGZNYWMzbzFlNk9pWnYvdnRu?=
 =?utf-8?B?c3U2U2cxOGNOWFdCQllFK0I5Mko0dGNHbDArTCttSkY5bWhvU0lPQ2wzVVYr?=
 =?utf-8?B?R09vOUlocm9adXRqclQ3dVgxTTZiR1hhUjJ3SGgvL1U3S1hTM2o1eWtEeFo0?=
 =?utf-8?B?cEZmWWlpYlZpUFQyMU12QWZETTRjVnc3ck1say91anhPTDRPUHpoSnpmSVMz?=
 =?utf-8?B?dldqZTJsSFEvcEo1T3VybnBzanBOZDZRSzZLYTJHbWRZV0tFNjk5ZEVQSFVo?=
 =?utf-8?B?TGdYdWlHOUYwaGt1aGlmVzR2YWNUbCtYbkRsQmtiOHBuRWN1NXhmWlBacy9U?=
 =?utf-8?B?Y2VyM2ttak9BNjVvNmJaRkREMjJlV2FJQ040ODloWkxVUUNTNzh3dGF0STY3?=
 =?utf-8?B?TnZRaXBaRm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklCak13T0J0aVQwZU5xdGV1cU9hNjRQdExDRkNGWUhjSFZUTkIvVWgzUlJ0?=
 =?utf-8?B?WG9TaTkyb0M3VFlzSmZOZ2FBa1RjU2hjS2p3ZWVzMGNYc1pGY0NsazVqSFY3?=
 =?utf-8?B?WnkzWWIwRGZnRjI3OVowQXpzbW4zY3lOdzZLeldFRE1kNW1nTzcyVnd4RjNI?=
 =?utf-8?B?NWdpYTVrMnQxVFl0dlVJdTMyMk9vWVRPaXQwMXFjM3lmRWRYbFJRS3RKZldE?=
 =?utf-8?B?U3J1NFEwSitScmJQMk45Nm1OalZkUDdaejJvV1BtZ0ZHeFpuZklUUFE3UFRj?=
 =?utf-8?B?SGk3cUNJY0x1N012dVF4ZURKa1VOOVJjV2F6bTBhcmw2eCtHaTVXeVdwWlVY?=
 =?utf-8?B?TlBvL1hCMng3bVM1N0Z0c2U5WUFPWjBZR2Nnd1RsaE1CVC9sMkRYeHkzWVUx?=
 =?utf-8?B?dFBDU2c0WE9zVzEvM0RSUXU2dlNkSEE4ZVJNVDJiTDVRR29NYVhNcnprdVVO?=
 =?utf-8?B?eS9heDZxcWlGbW1BZms4WW5paDdIU3NmMSs3WCtCRXAzYWprR0VWZXErdFNj?=
 =?utf-8?B?YTd5Z0pxVWdMVHFBMEVIVFNnUkFmL3BVL0VHYmVMaDlEeThqL011d1dPTDh0?=
 =?utf-8?B?QXp4eExyOUFaQUlXcERFV1dVR3pWK3B4Q2JVV2NVS3Nmd3lvNTMxTWMvY20w?=
 =?utf-8?B?QmhvMFIzNFZuZ3YxTDVKaWpNT0hpQjhkSkcrRnFCTmloQ1RUWEJ5cTllclJH?=
 =?utf-8?B?cUgwb0hhZnI4ZFFTUTM1ZHpFZmVibGRiQkxFS1lOSitFMy96OUtYMDdGM2dG?=
 =?utf-8?B?ZE9qbEEvRzZXRVFjQWlUQXM5QmRyZ2diL211Z2pEUUpzMnhvb1ExaEpvSGU1?=
 =?utf-8?B?YWZueS9uL25hRCtzWFFRT2VVODRma3FoZ1pFZGVmMGpSSVpHdzNja09HbEI3?=
 =?utf-8?B?SmNKcWRmcmtsKzkzVkZLeGcyeEllR010ZVlQbk80SnVmZVpkNVdzR3htNVZr?=
 =?utf-8?B?SnJIbzI1V0tzeGVhNmhaaVJrUFRPZUx0cyt1Q0tyYzVReUtlN2tmcm1jMzFN?=
 =?utf-8?B?WDc1ODl2QzEwbUtCNHREUEE5Sk5HL0RHR0FYdUN4Vm51S0VLVHVIVkhpWXBt?=
 =?utf-8?B?NXg3aUlYSHdaOTBKZXhmSVBxZnZaWDYvTXBMSVhMcXB2aUVsQW91TjNVcXNY?=
 =?utf-8?B?WFBiVDNpK1IwSmhNRm81UkdNT0tBNHE5VVpXMDFpOTU3a28yczZ1VDg0Qk5G?=
 =?utf-8?B?K0xlRUJBRndJYjJua0ZMdHVROWhVaktDWnFxVGYvSHRxZkhkMkEzV3RSZm41?=
 =?utf-8?B?WkpXSmgyR3RwbDY1NkovWTlvcTMzVjIrdkprS3paaSt0b0dMNDMxdzl5V3dy?=
 =?utf-8?B?eHlWRDJDTVBFN3ZMOXVaM3ZBUWxTOGhkOXZHS3poZlN4eUJPZGNobmllTi82?=
 =?utf-8?B?Y0prL3lHNkNpYWx0c3BLVytCUHMybnUxOFdqZ05jWXo1Y0Ezcm9DSnJBSWpj?=
 =?utf-8?B?RWh5SGV5RXkvcVdrZUxyQXdkZXFaZzU2T253V1RmRi9JczF5T1VVZElyQms3?=
 =?utf-8?B?aU5uZXdYaHdMZTRKWGZEWThtZHh0MWozRmdYdThSNkJ2bnNqbWYzMzF2QWJy?=
 =?utf-8?B?K0ZYU2lvaDZQeFhMY3BrM2FLdDRkWVQzSktLajNzaDRqRXQrcG1qanZlV0lI?=
 =?utf-8?B?V1JxaytySmJ0UEpGcXlURG5McTVnMHMxSytQRnljZ3V3OEdOVE9kUTkrd3Fr?=
 =?utf-8?B?NEZ5TFhDM0pSbWthbEl6eDZndTU3cmYxcHp1OUJHMVByZm5hc1hib0J0eXFn?=
 =?utf-8?B?QSswaVY0VzMrMHA4V3ZGRG9GOWV6TllOTHJCTzV0WDBFODdqYS9mU1ZHUXBH?=
 =?utf-8?B?RVIwYm4xbktUbVM3alVENWMySTdDRTZIMFFjOU5NRER5bzFleGtaSDNpbWZL?=
 =?utf-8?B?Vlcrd2tSUDlWVytsRisvcGJ5NTd2VnpSVk9EUWVONTR5czhEK3RMNWVGVEh6?=
 =?utf-8?B?QmliSlY2a2dyclk0VTRaSjBSV0Zud3gyZmhpK2pZQWRhcWpKcUhnTGpKVE9R?=
 =?utf-8?B?QUJ0UjQ2MktpMnZkODg2Ny9nUGhzemdMYUpycmtiS1pmS0RIQjMxVXU0elZj?=
 =?utf-8?B?VFF2Z1RFM200by9jenhCSEtwOW1hanBmQ29DU0FjdEE2eVJQaE1DcTZPYUp3?=
 =?utf-8?B?d0Flait5S1NoVTBPU3ZCdkhkbUV1NnpYeTh0RU42eVJGbTYyQzU4bG9iTDZz?=
 =?utf-8?B?VGdMaGFYUjRHd3B5ZHl5L25OTE1WbjNYMklQbEljM3c1RmlaVnEwTkQ1UVRi?=
 =?utf-8?B?a0lML0g4T2V4U3ZBVlFocERlUDNTbm5nZVdPK0RQTmZldEZuaG9mcWJkTGhj?=
 =?utf-8?B?RHF5cmg3eGl1Umh2cW9LQjlxVmlXaWE2MkFpRzNXeXFhSDFFR0JtSkpjTlU0?=
 =?utf-8?Q?m+NN28gNAXlUNQ+OssFXRP8VDIpMeUJfQTNoX/F/HUyoP?=
X-MS-Exchange-AntiSpam-MessageData-1: x+vO6QwUBLWRYnUoSZgbHlSqvTyaRWGrnGg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fde85e-347c-4de5-cacd-08de50f58ad5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:06.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05KX4wbxkScP0WZK6cseFXgN7Gm8uFz9p5ekm6uhamfO7TSno6blqAwTuE8/LVoG+JYtBVLtDRlOfpWG6PMMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Add helpers in the generic PHY folder which can be used using 'select
GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
enable GENERIC_PHY.

These helpers need to deal with the slight messiness of the fact that
the polarity properties are arrays per protocol, and with the fact that
there is no default value mandated by the standard properties, all
default values depend on driver and protocol (PHY_POL_NORMAL may be a
good default for SGMII, whereas PHY_POL_AUTO may be a good default for
PCIe).

Push the supported mask of polarities to these helpers, to simplify
drivers such that they don't need to validate what's in the device tree
(or other firmware description).

Add a KUnit test suite to make sure that the API produces the expected
results. The fact that we use fwnode structures means we can validate
with software nodes, and as opposed to the device_property API, we can
bypass the need to have a device structure.

Co-developed-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Note that on 32-bit systems I am expecting a sparse warning:
drivers/phy/phy-common-props-test.c:420:1: error: bad constant expression
drivers/phy/phy-common-props-test.c:421:1: error: bad constant expression
drivers/phy/phy-common-props-test.c:422:1: error: bad constant expression
caused by:
https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
AFAIU this is pending a fix in sparse 0.6.5, not available yet.

v2->v3:
- rename GENERIC_PHY_COMMON_PROPS to just PHY_COMMON_PROPS (more
  representative).
- fix case where querying PHY polarity returned error for fwnode with
  missing property, rather than default value, as reported by Bjorn
  Mork.
- add tests for the above condition
- add credits to Bjorn Mork for signaling the above.
v1->v2:
- add KUnit test suite
- replace joint maintainership model with linux-phy being the only tree.
- split the combined return code (if negative, error, if positive, valid
  return value) into a single "error or zero" return code and an
  unsigned int pointer argument to the returned polarity
- add __must_check to ensure that callers are forced to test for errors
- add a reusable fwnode_get_u32_prop_for_name() helper for further
  property parsing
- remove support for looking up polarity of a NULL PHY mode
- introduce phy_get_manual_rx_polarity() and
  phy_get_manual_tx_polarity() helpers to reduce boilerplate in simple
  drivers
- bug fix: a polarity defined as a single value rather than an array was
  not validated against the supported mask
- bug fix: the default polarity was not validated against the supported
  mask
- bug fix: wrong error message if the polarity value is unsupported

 MAINTAINERS                          |  10 +
 drivers/phy/Kconfig                  |  22 ++
 drivers/phy/Makefile                 |   2 +
 drivers/phy/phy-common-props-test.c  | 422 +++++++++++++++++++++++++++
 drivers/phy/phy-common-props.c       | 209 +++++++++++++
 include/linux/phy/phy-common-props.h |  32 ++
 6 files changed, 697 insertions(+)
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6737aad729d6..aa82c3f6a89f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20519,6 +20519,16 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/devices/phram.c
 
+PHY COMMON PROPERTIES
+M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/netdevbpf/list/
+F:	Documentation/devicetree/bindings/phy/phy-common-props.yaml
+F:	drivers/phy/phy-common-props-test.c
+F:	drivers/phy/phy-common-props.c
+F:	include/linux/phy/phy-common-props.h
+
 PICOLCD HID DRIVER
 M:	Bruno Prémont <bonbons@linux-vserver.org>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0a..62153a3924b9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -5,6 +5,28 @@
 
 menu "PHY Subsystem"
 
+config PHY_COMMON_PROPS
+	bool
+	help
+	  This parses properties common between generic PHYs and Ethernet PHYs.
+
+	  Select this from consumer drivers to gain access to helpers for
+	  parsing properties from the
+	  Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
+
+config PHY_COMMON_PROPS_TEST
+	tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
+	select PHY_COMMON_PROPS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the PHY common property API.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  When in doubt, say N.
+
 config GENERIC_PHY
 	bool "PHY Core"
 	help
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494..30b150d68de7 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the phy drivers.
 #
 
+obj-$(CONFIG_PHY_COMMON_PROPS)		+= phy-common-props.o
+obj-$(CONFIG_PHY_COMMON_PROPS_TEST)	+= phy-common-props-test.o
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
 obj-$(CONFIG_PHY_CAN_TRANSCEIVER)	+= phy-can-transceiver.o
diff --git a/drivers/phy/phy-common-props-test.c b/drivers/phy/phy-common-props-test.c
new file mode 100644
index 000000000000..e937ec8a4126
--- /dev/null
+++ b/drivers/phy/phy-common-props-test.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-common-props-test.c  --  Unit tests for PHY common properties API
+ *
+ * Copyright 2025-2026 NXP
+ */
+#include <kunit/test.h>
+#include <linux/property.h>
+#include <linux/phy/phy-common-props.h>
+#include <dt-bindings/phy/phy.h>
+
+/* Test: rx-polarity property is missing */
+static void phy_test_rx_polarity_is_missing(struct kunit *test)
+{
+	static const struct property_entry entries[] = {
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity has more values than rx-polarity-names */
+static void phy_test_rx_polarity_more_values_than_names(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity has 1 value and rx-polarity-names does not exist */
+static void phy_test_rx_polarity_single_value_no_names(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_INVERT };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity-names has more values than rx-polarity */
+static void phy_test_rx_polarity_more_names_than_values(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: rx-polarity and rx-polarity-names have same length, find the name */
+static void phy_test_rx_polarity_find_by_name(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_AUTO };
+	static const char * const rx_pol_names[] = { "sgmii", "2500base-x", "usb-ss" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	ret = phy_get_manual_rx_polarity(node, "2500base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	ret = phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
+				  PHY_POL_AUTO, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_AUTO);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, no "default" - error */
+static void phy_test_rx_polarity_name_not_found_no_default(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, but "default" exists */
+static void phy_test_rx_polarity_name_not_found_with_default(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const rx_pol_names[] = { "2500base-x", "default" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: polarity found but value is unsupported */
+static void phy_test_rx_polarity_unsupported_value(struct kunit *test)
+{
+	static const u32 rx_pol[] = { PHY_POL_AUTO };
+	static const char * const rx_pol_names[] = { "sgmii" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("rx-polarity", rx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("rx-polarity-names", rx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity property is missing */
+static void phy_test_tx_polarity_is_missing(struct kunit *test)
+{
+	static const struct property_entry entries[] = {
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity has more values than tx-polarity-names */
+static void phy_test_tx_polarity_more_values_than_names(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity has 1 value and tx-polarity-names does not exist */
+static void phy_test_tx_polarity_single_value_no_names(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_INVERT };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity-names has more values than tx-polarity */
+static void phy_test_tx_polarity_more_names_than_values(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: tx-polarity and tx-polarity-names have same length, find the name */
+static void phy_test_tx_polarity_find_by_name(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT, PHY_POL_NORMAL };
+	static const char * const tx_pol_names[] = { "sgmii", "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	ret = phy_get_manual_tx_polarity(node, "1000base-x", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, no "default" - error */
+static void phy_test_tx_polarity_name_not_found_no_default(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "2500base-x", "1000base-x" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: same length, name not found, but "default" exists */
+static void phy_test_tx_polarity_name_not_found_with_default(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_NORMAL, PHY_POL_INVERT };
+	static const char * const tx_pol_names[] = { "2500base-x", "default" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val, PHY_POL_INVERT);
+
+	fwnode_remove_software_node(node);
+}
+
+/* Test: polarity found but value is unsupported (AUTO for TX) */
+static void phy_test_tx_polarity_unsupported_value(struct kunit *test)
+{
+	static const u32 tx_pol[] = { PHY_POL_AUTO };
+	static const char * const tx_pol_names[] = { "sgmii" };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U32_ARRAY("tx-polarity", tx_pol),
+		PROPERTY_ENTRY_STRING_ARRAY("tx-polarity-names", tx_pol_names),
+		{}
+	};
+	struct fwnode_handle *node;
+	unsigned int val;
+	int ret;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
+
+	fwnode_remove_software_node(node);
+}
+
+static struct kunit_case phy_common_props_test_cases[] = {
+	KUNIT_CASE(phy_test_rx_polarity_is_missing),
+	KUNIT_CASE(phy_test_rx_polarity_more_values_than_names),
+	KUNIT_CASE(phy_test_rx_polarity_single_value_no_names),
+	KUNIT_CASE(phy_test_rx_polarity_more_names_than_values),
+	KUNIT_CASE(phy_test_rx_polarity_find_by_name),
+	KUNIT_CASE(phy_test_rx_polarity_name_not_found_no_default),
+	KUNIT_CASE(phy_test_rx_polarity_name_not_found_with_default),
+	KUNIT_CASE(phy_test_rx_polarity_unsupported_value),
+	KUNIT_CASE(phy_test_tx_polarity_is_missing),
+	KUNIT_CASE(phy_test_tx_polarity_more_values_than_names),
+	KUNIT_CASE(phy_test_tx_polarity_single_value_no_names),
+	KUNIT_CASE(phy_test_tx_polarity_more_names_than_values),
+	KUNIT_CASE(phy_test_tx_polarity_find_by_name),
+	KUNIT_CASE(phy_test_tx_polarity_name_not_found_no_default),
+	KUNIT_CASE(phy_test_tx_polarity_name_not_found_with_default),
+	KUNIT_CASE(phy_test_tx_polarity_unsupported_value),
+	{}
+};
+
+static struct kunit_suite phy_common_props_test_suite = {
+	.name = "phy-common-props",
+	.test_cases = phy_common_props_test_cases,
+};
+
+kunit_test_suite(phy_common_props_test_suite);
+
+MODULE_DESCRIPTION("Test module for PHY common properties API");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
new file mode 100644
index 000000000000..3e814bcbea86
--- /dev/null
+++ b/drivers/phy/phy-common-props.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * phy-common-props.c  --  Common PHY properties
+ *
+ * Copyright 2025-2026 NXP
+ */
+#include <linux/export.h>
+#include <linux/fwnode.h>
+#include <linux/phy/phy-common-props.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+/**
+ * fwnode_get_u32_prop_for_name - Find u32 property by name, or default value
+ * @fwnode: Pointer to firmware node, or NULL to use @default_val
+ * @name: Property name used as lookup key in @names_title (must not be NULL)
+ * @props_title: Name of u32 array property holding values
+ * @names_title: Name of string array property holding lookup keys
+ * @default_val: Default value if @fwnode is NULL or @props_title is empty
+ * @val: Pointer to store the returned value
+ *
+ * This function retrieves a u32 value from @props_title based on a name lookup
+ * in @names_title. The value stored in @val is determined as follows:
+ *
+ * - If @fwnode is NULL or @props_title is empty: @default_val is used
+ * - If @props_title has exactly one element and @names_title is empty:
+ *   that element is used
+ * - Otherwise: @val is set to the element at the same index where @name is
+ *   found in @names_title.
+ * - If @name is not found, the function looks for a "default" entry in
+ *   @names_title and uses the corresponding value from @props_title
+ *
+ * When both @props_title and @names_title are present, they must have the
+ * same number of elements (except when @props_title has exactly one element).
+ *
+ * Return: zero on success, negative error on failure.
+ */
+static int fwnode_get_u32_prop_for_name(struct fwnode_handle *fwnode,
+					const char *name,
+					const char *props_title,
+					const char *names_title,
+					unsigned int default_val,
+					unsigned int *val)
+{
+	int err, n_props, n_names, idx;
+	u32 *props;
+
+	if (!name) {
+		pr_err("Lookup key inside \"%s\" is mandatory\n", names_title);
+		return -EINVAL;
+	}
+
+	n_props = fwnode_property_count_u32(fwnode, props_title);
+	if (n_props <= 0) {
+		/* fwnode is NULL, or is missing requested property */
+		*val = default_val;
+		return 0;
+	}
+
+	n_names = fwnode_property_string_array_count(fwnode, names_title);
+	if (n_names >= 0 && n_props != n_names) {
+		pr_err("%pfw mismatch between \"%s\" and \"%s\" property count (%d vs %d)\n",
+		       fwnode, props_title, names_title, n_props, n_names);
+		return -EINVAL;
+	}
+
+	idx = fwnode_property_match_string(fwnode, names_title, name);
+	if (idx < 0)
+		idx = fwnode_property_match_string(fwnode, names_title, "default");
+	/*
+	 * If the mode name is missing, it can only mean the specified property
+	 * is the default one for all modes, so reject any other property count
+	 * than 1.
+	 */
+	if (idx < 0 && n_props != 1) {
+		pr_err("%pfw \"%s \" property has %d elements, but cannot find \"%s\" in \"%s\" and there is no default value\n",
+		       fwnode, props_title, n_props, name, names_title);
+		return -EINVAL;
+	}
+
+	if (n_props == 1) {
+		err = fwnode_property_read_u32(fwnode, props_title, val);
+		if (err)
+			return err;
+
+		return 0;
+	}
+
+	/* We implicitly know idx >= 0 here */
+	props = kcalloc(n_props, sizeof(*props), GFP_KERNEL);
+	if (!props)
+		return -ENOMEM;
+
+	err = fwnode_property_read_u32_array(fwnode, props_title, props, n_props);
+	if (err >= 0)
+		*val = props[idx];
+
+	kfree(props);
+
+	return err;
+}
+
+static int phy_get_polarity_for_mode(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     const char *polarity_prop,
+				     const char *names_prop,
+				     unsigned int *val)
+{
+	int err;
+
+	err = fwnode_get_u32_prop_for_name(fwnode, mode_name, polarity_prop,
+					   names_prop, default_val, val);
+	if (err)
+		return err;
+
+	if (!(supported & BIT(*val))) {
+		pr_err("%d is not a supported value for %pfw '%s' element '%s'\n",
+		       *val, fwnode, polarity_prop, mode_name);
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+/**
+ * phy_get_rx_polarity - Get RX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_rx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "rx-polarity",
+					 "rx-polarity-names", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_rx_polarity);
+
+/**
+ * phy_get_tx_polarity - Get TX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL and PHY_POL_INVERT
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_tx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name, unsigned int supported,
+				     unsigned int default_val, unsigned int *val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "tx-polarity",
+					 "tx-polarity-names", val);
+}
+EXPORT_SYMBOL_GPL(phy_get_tx_polarity);
+
+/**
+ * phy_get_manual_rx_polarity - Get manual RX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs which do not support protocols with automatic RX polarity
+ * detection and correction.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_manual_rx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val)
+{
+	return phy_get_rx_polarity(fwnode, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
+EXPORT_SYMBOL_GPL(phy_get_manual_rx_polarity);
+
+/**
+ * phy_get_manual_tx_polarity - Get manual TX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs without any custom default value for the TX polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int __must_check phy_get_manual_tx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val)
+{
+	return phy_get_tx_polarity(fwnode, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
+EXPORT_SYMBOL_GPL(phy_get_manual_tx_polarity);
diff --git a/include/linux/phy/phy-common-props.h b/include/linux/phy/phy-common-props.h
new file mode 100644
index 000000000000..680e13de4558
--- /dev/null
+++ b/include/linux/phy/phy-common-props.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-common-props.h -- Common properties for generic PHYs
+ *
+ * Copyright 2025 NXP
+ */
+
+#ifndef __PHY_COMMON_PROPS_H
+#define __PHY_COMMON_PROPS_H
+
+#include <dt-bindings/phy/phy.h>
+
+struct fwnode_handle;
+
+int __must_check phy_get_rx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val);
+int __must_check phy_get_tx_polarity(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     unsigned int *val);
+int __must_check phy_get_manual_rx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val);
+int __must_check phy_get_manual_tx_polarity(struct fwnode_handle *fwnode,
+					    const char *mode_name,
+					    unsigned int *val);
+
+#endif /* __PHY_COMMON_PROPS_H */
-- 
2.43.0


