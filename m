Return-Path: <netdev+bounces-170339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C291A48441
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6234F3AAB5B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F71A5BBC;
	Thu, 27 Feb 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CfYLgrmB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE7270ED8;
	Thu, 27 Feb 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672085; cv=fail; b=GRkAMfIZFjUYkNd1MeFt6DqwQHmyRJgAVJo4gEPAzkahamX83pdjFyKZjtWcAFtS1J6tcaLhoTbvREBiaDYrnGsA0dzjgJgWPi/MF+j4/DPOvEEh7JTnUj8JRzzbOJajzmzBmZDvs2tjgryeWIO8Zl7LEDyaTrUAWNrXtOz+2f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672085; c=relaxed/simple;
	bh=mBffXABRRScye/9DES6Hq3gfWUVcBnFe7YPxNeGeSIg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qFsg7GLI4ue+QUZv+kFr1VM5q86YbLvcJBxO7U9as+nESyaPU90kc5wnIe6McS3C+RIro5/BbTBmPBnM5eYoJbZdjjJymSI7gHkP3lu4hADMg6YDiMinZDHgB1Gff/k646K45iPhYQoEzL3UiqZNf0RkYKSveITkqGDuskZ7r0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CfYLgrmB; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPioWPSbQ5C3TEC+JdwVcx4OmfYcbHrImycvGBpDd/frSO+CSPkDY9pRItk3EXf/G9ivYUMD1TvvHVmGIF6yIVgw6V5iqn75F/6T5mfnaW/LiCDN72QywOx1ScaS6+ab6JLDAgRv6G66Q9lA/LoFQAX6c9ZYTVUZAmACfsXofBWZHuWxGCJOQyoTVjBGiSHlW6tC+6ebd385n4SyveU+wMBNjfee0/pqqMsQn/FALK++nFEcjiHme+HCdvdo7OVqA8DuVaA7YOvOOIeMXC91crXFMiJG8D3PWbHh45oxsr+7uP5stYAT5/e9rMQjdUAQ0WLUXTcRHhAe2eHy1PiOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkvBtsKjLT7TkY6qeFB9NcMiqcT2Do5KVPU8IZvAoxI=;
 b=AyeECSzX3rGdyVlLGmv38CSg8+W/l62pEM013TbNtuBiZuuk98uoGnW1/99dImdhZxIKgibdyUO7D/5FQbEazrCc4JzMBgTIvlMbYYWwNWVoDLbWQfQKD55kfCyiGYfBBMW0Dx5Za2Du6IRQErfcXRSpRPTD+r82lyI4haMBenLJrs0ttI8j7W7+U9K7X+dmmkwWGhnu9aawl0KawaxKxBAR2v99dKS/0FDGVCfi8VOtKaGI8RpsNPE+DKWY5xdK8xoqzcAbEs4ibP5KMUOr7zgG/Mg2ZOhXD0KAeiRk21XpkSAKB5+ZUMNWo09xrdsAe+PPoe0ZvMKkZbk7k1XOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkvBtsKjLT7TkY6qeFB9NcMiqcT2Do5KVPU8IZvAoxI=;
 b=CfYLgrmBnos2SOnYHiwvNwbovxJD9W/EIQPlJ0bGCldWu3IztOub1xucpHxYFSDBndP7HVwKpBzofkatqU+Xy4aOtKeD/TwMTBCDJgbhyCDbQfKrvKxGJA/3QV3IvzR8DT1DfIwqrWs+0SCImRQ4KJErgyl5TmvZBDwPzZ680HfrdDDoQOtvqYjTkR6lveMVjP+4PsdmXW3waDppKDL3EP1Z8hmdSsoIrPBeQfJoEvUHA/z8Nr35QX9AA6K9r5n+eM+nsQxeozruXuJo2Q7kydnObW4GUU3sIycDaR7I1rk6XNDGXA2cbjacoGCQCYsgKvaeX3sBrFKI8mfbLMajWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 16:01:20 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:01:20 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 0/3] net: phy: nxp-c45-tja11xx: add support for TJA1121 and errata
Date: Thu, 27 Feb 2025 18:00:53 +0200
Message-ID: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e98fb4d-e5d4-479e-fd01-08dd5747f944
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y24yOFUyTjB4QytwYUZEUWlJUHpTOFMzYjBNUlhxblV5Z1NOeFdCcjZoVXJp?=
 =?utf-8?B?YzR6SDgyMkJUc0swbzdFSGs0VGw1SjFpckc5QlE3TXBvR2xSZnNvdDRFWXVU?=
 =?utf-8?B?dzhJdzlhTEFwR2xGR25RMi9heVlQc1FYV3hRNTBuNk9iNlF6VkZ4QzZKSFV4?=
 =?utf-8?B?RUhWTi9xa2hLQ1M5Z0svaElkOWE0ZkpoeGNmT3Rzbjg3WVBZWHdsbVRHUVJ3?=
 =?utf-8?B?RU9xMXUwRUtHaGxDUzFyMzJiOVhIK1dKc2dDQmRwY3FrUU9VWEMwVmFrbVNZ?=
 =?utf-8?B?SzZVa1kzc3psWlh3SmJ5aFV4Wmp5bnpVTnNvM0RLQmFjV2JvRDM1OEJ1ZkVs?=
 =?utf-8?B?dEJ5T1NOOUpiZmgxWTlxRHROSGlBQWVOSFQ2eUc5aEp6Vy9Ia0p2L1EwaUZn?=
 =?utf-8?B?NzBkbzl5V2s5VklPSUV2WTdPenhFdGRtM20yTE5sVFBjRHhNVmZRcHRlNEdL?=
 =?utf-8?B?d3lpN0xWYWpzbzZuOCsyOU9DcXdOaHYrcWFaajEvb004a3NKVmhqSHl0N0RP?=
 =?utf-8?B?ZHpyWGpYMytNT0JnYUtCSHZPc3Z1M1RtWVlTZDc4QUM4MEZyN3g3REpRQytt?=
 =?utf-8?B?eTJ6YStYUXZIUUJ1TFRiUUU0dFMrMzVMYzAzME1EeHh6UHFGMHFaTEFEeml6?=
 =?utf-8?B?MUM4OXcybEo3TzN6R2M1NzhZUDlOell0b3RjdVNUWDEvRDA4OHZKT3NhM1U4?=
 =?utf-8?B?Rm5hRVBWMmtXRlpGdVQ3RFZ3ZFBkS09oSXFIV1VVUDRtZU1zWkRtNThEbGJw?=
 =?utf-8?B?UDJqRWpUYWxzNC84WmxlTXR3ZFVueHlKdVUyK3Vtd2RiTjlEbVcvejRwc2Mw?=
 =?utf-8?B?MXVUcEpDWERURnpwdkVYY0ViMm0xbmRqNEV2c1JOUmxEb0EvZUJTWUcvR0tt?=
 =?utf-8?B?WjBuVUFGY2tPZmlnZ0dhM1dyQkN3R0dSb2pkYTNmMjFpSUhVc1Q1WXZ1QktH?=
 =?utf-8?B?ZnZzL0xkMnR4THorU1lJYld2cVdnZVM5QW1XYnNwRHJtaDcyemtCUGkrbjZV?=
 =?utf-8?B?WlU2VkZIVTZ1RFU1WS9Ta2J5cHN5bEh3QVBvMmp3VWlONFJWOUJ6SXF3SVF1?=
 =?utf-8?B?MnRSVTFRUFFhR2hVOEdYUXpTM1dzMG80dHlaVW0zdGlhblNBNk5QOHVjbVdO?=
 =?utf-8?B?VWdERk1iOTh6YjhzZEV5UThSck9BZlhlSTdoOWo1Vm1XTWZES2NHdk1OcWdl?=
 =?utf-8?B?VkNtNlZ2NnAzeGxqRlhVcUVaQVBrUkV4WVozdEtVZ2tuSGY3bkhkTVJmWm52?=
 =?utf-8?B?dGUrTENDQ1VFSXlQRktDaDJEdWpOcTZsbE5FTzkra1h5Qmc1YXpVaS9HbEFl?=
 =?utf-8?B?dVBjRUg2RFVNcDhuZzBTUWs1ZUtvRno4NDdub3YrbmZUY2hYMzN3dUFpVmx1?=
 =?utf-8?B?ZE1LQ0tXVE9xYlV5U2E1aFU1bW5qRVUrR09LZUIyZTRady9HT1dYSlR2QTlx?=
 =?utf-8?B?N1V1bVo5QmwxbHFySUU0UFhCcFIydHA2TGdSS1hIdFRvMFJmTWFvMlFIOEVC?=
 =?utf-8?B?UEJLOGJwMHFGbjVoemladHNOcEk3QXdTZys5NEU2akM0eGplNm9yRzhxRUY3?=
 =?utf-8?B?TFlDZXZPV1hiV24zTFFGZnFlQzB2a0daSEl5aHNtc1RDaVQveVdhMXNwc0Q4?=
 =?utf-8?B?MEhxRXJuai9hSlh2aDkyTEdULzlZdE1kdHlJNzZKeVRzVTBBWTZVSUZ0dnYz?=
 =?utf-8?B?Y3JjMjVWWk9sTWsybFhsNUNYeGZOU2dpRExBb2plbGVmMXdITFYvaEcrTWlR?=
 =?utf-8?B?a3lId0oyMU9ZTVZGYUlyekRQZHhMbGs2TUdrVkxrRWNNbGtaZXdPY0dOcVRx?=
 =?utf-8?B?MGg1eXYrT1BNelBCb3dJVGU0M0gvbFBmTHNzVnBYRlIrV3hrZ3hyWXcwUVNO?=
 =?utf-8?Q?fBfdCMJm1ck9L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUozNmExYUZGSHB3d3RaNk5ORzQ0NE56SGFwS3c0U25mUDdwQi9HeHNNV2d4?=
 =?utf-8?B?eGU4MHZLZzVHbTNqaWpDNVlQR3l2TzRQdW9WVEs0Nk5hWTZNVEJaM2ZEZ05o?=
 =?utf-8?B?c2tkUzNiUzhmMmdoNzl3dU1DSEpxbWxjRERjYVRDaUx1ZmN2WTVhTU40anlw?=
 =?utf-8?B?aUFvZjRPeVJ3OTVVQ29GT3puT1lRRU1aVk41N1JWc1FzNUxJQ2VieEl3dmpJ?=
 =?utf-8?B?eFZnQ2VnK3FpSTB3Tm9GYytPWk95ZVpPWVNuaGRxbnYxcUhXNWtZSHFBdWdi?=
 =?utf-8?B?U005ME1GOWxFRkttZnFHYVIyTXBLNkZwejdhT3g2SnRGdWxrVDQzcDN4VE52?=
 =?utf-8?B?OHB4a2ZtNjZhTUEvdHlicmFLRjJudkM2cW9MQ1Nkc1dTUVB5VGk5ZmxMcm82?=
 =?utf-8?B?V1NJRGV4N2JWa2VQN094TW54RGpIaEgva3pZZFY4eFp3ZUhTZStNRFJYUVlU?=
 =?utf-8?B?aFpORTFBYnVwVFBxOFpuU2xvdldGanRIZWdmUklyT0UxRDR6cHI0UUhON1di?=
 =?utf-8?B?RG9tbm16UlYyVEJlNFZ3dFJxdFRabno5V3EwU3lmVG5LdG5Wa3hFTk91NS85?=
 =?utf-8?B?dmFLei9vWS9ieHdsVFBXckFMNkRBalNLNDMwWmpNclFCZ0pySkVwQ3lyT2ll?=
 =?utf-8?B?Q0RYdUQwUm5VZkVzSm9DV1p0dDlDK21TVzROcUZhNEdZaHpsQWQ0WFJnMDRE?=
 =?utf-8?B?ZUJLdmFycGNuUWRDRDl5T0ozaWNwVFE4UnpOaEhqZUd6Q2k1TlprU2ZNS0JO?=
 =?utf-8?B?VThUUUQ4RnlpbnlCcngyL1R3L05HSW5PUDZKZ2RkVGlTWkQ3TkdUU1FPejdV?=
 =?utf-8?B?Z0paZXdiSi9qY3hqWXFDTERiSTJrTnBTOWZSdkROVWNXaTBpZWRjdjFTcnpo?=
 =?utf-8?B?SlpjdkYvTFZwMmdiWDI0bmJRK2xYakkvaEdQNFZDOXJ2OXN3TXRiSjlXR3ZH?=
 =?utf-8?B?cGgrb3p5VE00MHZqeFpIWU5Gb3lUME9JWGVoc3hNeE01d2NlVWwwQU9oN1hu?=
 =?utf-8?B?Z0c1WHlLdlFnbk5vYXJwcEhlc0NyVHBod2M3am1wTnJ5bURjRkRjbVpVczNW?=
 =?utf-8?B?YUFrVjNXSVhybmZiL0RWY1BETnZrL2pScWFVYklPQkNSbjM2VmFrNVVtVTlK?=
 =?utf-8?B?RVNqT2lMV0xCMU83RTFtUGpvbG1oR0J0NHJOYXdzMFFxTXU1SjBGNGpIMVcx?=
 =?utf-8?B?Q0dQNDZtZGg5VHBmaFVMSUtEeE5JV0lEY3ZsbVNzNHpYOE96T3dLcnVlcU0z?=
 =?utf-8?B?TVVEM1JLOUNGZTNTWWJaUE1reE81MXh3Sis1c2d3Z2VWUUJXT2RiN3huZjFM?=
 =?utf-8?B?ZGtNRmFYVWFPMEFQRThuejVvc0xuRHRXb1JLRDhNbmdDUldRNHNmNDRXanZt?=
 =?utf-8?B?bnJ4c0JjYkE5S29WOVRBbHFVY05sNjUrM1ZWbDd2SWsxZHh2dy9DdFE5NzYz?=
 =?utf-8?B?NllucTRmakp0NnlkMGZaN1hkbDl6SENXcERoSjQydlc1S2hPV3JyM21Dd3Bx?=
 =?utf-8?B?UndjYy9YREpDZFI5MjdGbmQ3V3FxeEJZZGRnV2thdUFNZmJJdEpoNXk3M1Vj?=
 =?utf-8?B?TDlvTjZTWUlsMkkxQnpNUkw3WXhyZ3NJcEg1VEM1U3lXYktONnROSjFIUFlJ?=
 =?utf-8?B?SHJLa1lhYVlmR1FHV2JvTjhxYUFVNVdReHFLenFRN054UlBObFR0NVpIWTRI?=
 =?utf-8?B?ZWozQUtXM2lHVlFsTHlBU09WczhOWHg2QjAyTWFJeU5MVVA0T0pIZ0h0dVVt?=
 =?utf-8?B?MXNZSG5jZ3Y4NzZ4Qk9Eb3hpb2dYOEJtOHJyUEhjT2F2ZmpFTy9qMXVjeUky?=
 =?utf-8?B?b3pwMjdXQmFPWmw5MnFHeDZGTHluZXJGdUVsRnFITlFmcElSQXhpc2RyTnNL?=
 =?utf-8?B?OHE1VXBtLzc1YlFxcGpOUDVXamthUGQzbEU5MkRXcXgrQmR3enpjU25tNUNz?=
 =?utf-8?B?MHFBejgwZm5rUHJidWdUdTcwbmwxTFhWLzA2d3BYQ0xWTUNBR1N6TEVWV1pC?=
 =?utf-8?B?Ty9FeVBoNTM4bWZmVWM3b25RMmlYUGVLMDFBbHdkcE80OWZPcVZ2bjg0MnNI?=
 =?utf-8?B?eHFxSGlyL2dudDM5M21nYkplOWMyOERzc3VQWUMxQlFHMUwvT2FpWXpxWDhD?=
 =?utf-8?Q?TIhoR2iElx/gdeRr29uuxhl9R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e98fb4d-e5d4-479e-fd01-08dd5747f944
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:01:20.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vZwwtKdQ2S/xWyR3Ylz5R4uhxzenaGrVbpmrYRUcukInjGj7vj8UBUjhruYOC92oxNPoaApWtd2xKbiUQYO8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266

This patch series adds support for TJA1121 and two errata for latest
silicon version of TJA1120 and TJA1121.
Support for TJA1121 consists of naming changes since TJA1121 is based
on TJA1120 hardware with additional MACsec IP.

Andrei Botila (3):
  net: phy: nxp-c45-tja11xx: add support for TJA1121
  net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
  net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

 drivers/net/phy/Kconfig           |  2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 76 +++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.48.1


