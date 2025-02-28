Return-Path: <netdev+bounces-170783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D239CA49DDF
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415053BE81D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717D27424A;
	Fri, 28 Feb 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rkDqA8Hj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A47272933;
	Fri, 28 Feb 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757432; cv=fail; b=dyp30l7ZpWS+zzZ5yolv+LTlETnOa7wP1Ca89+gDPjHwf6PWy/5bDA2qKGIAyFM735FLk59F+2DhjoqBf8Es01F1g3bhbUmMLmRWq9cu71dvmYaojYhuRpAGQbrx5IJBj3wTjrbLXsrZn0Qss+GOrshNlWikSrstrYtLOcn4Mv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757432; c=relaxed/simple;
	bh=DmBEzLDoHwWOeaF7EQihGUHLWJLqvG2PecepCW+rVPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYLrOmLMrxHLxQDt2wFM7h082lzXISD3PcF9J59DOVN0Hh/pH/3q5DHB6ofnrnKDZsrCLx+5UEWFrKFYr+DePl9gLPwXALAcKhQFzMantfS3GjYlj2Am0ztLv8RcCBV5AQ9yyHDdF+khM2+gJIoVbu270fyF+f2kN4p2TrQsLLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rkDqA8Hj; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQYgjosLzAQq90bnhxuQKJYlJtvDYbWeN2wR+l9aw82wSTSpJs8qjZai9EwgYl6jj9ls69fNrl/l9JoFvzFurjoYkTow/Xuvvi2gEiQv2EJmoCzbk0VCNm2Ze3JQaKnGs+a4QlFYY4D4cJneslx/ryOp04x1I56Bdo8c97wnlfP9vKVIVgoYVtxjeBqNmR2CxDiWIba1ddWRV0sDmArJ0kNxMmsFFPAJjaazeqJbJ3nEz3Qz8h1YOqL/lhYOTJ6NGejGALp5FvOyJ1vLPbVhcCEX12uXhpR1IKNdE2uyWuECmeRI7tL2GzsNRATpK5bf4pYTlX/jyQMD0+0WD/wuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No2IRQPYeOv5OYWNtn1+SUTCZrRlVo1kZm5YKrj0Xfc=;
 b=sTvuy9uEeaSeqUoiKjXDpLPrMpTbRpmjOjHBf+DfpVAT7eH+UTbxE8vy3hN2PGE8oxSgBZqMzcyJTV3MnFZWX0GdeTOAoNMfKy24ZnAfHNjhoBREHZzGGLtHGyOdmGu9UuVe+OQT4kd0dpu2Ij/VLM01qKzEI78MY++9B7TaeTejIpnSndSlLEODgpghUTP2Hyh0wOD6efhQ+PlAjsEJl8x2AFQbTj4XEBLQrywwEMBqhHK9GnxYsG5M19bl9O15SkYDklkHSUO6/+vLJf0FHPCgS4l5FEEMMG6yI/L13DwXu1iHEAzuBoQKg6H6KOAW4gy4UyiJFy3Rv+KRTpoXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No2IRQPYeOv5OYWNtn1+SUTCZrRlVo1kZm5YKrj0Xfc=;
 b=rkDqA8Hjhxy5jXJQD0px/Jr9foViSGIMkwDHYeU5mrMhSLiNMlZ/C0u4z0TelckCR07okCGnqY69asS2kXhJBKg5bzuAMfppHuCYNbBDJmYYIqIGj6crEmcvIwWuqrRCXvS2rOGsz9YBwBsi4e5wWXbQeBIFPYqFfgTBjyRCOK9t1hYlPhoOYxcL32Z2gooDtfNidOo/Ejq9zjfFrEjdW4WmHNSi6tgx+tulExbt56d9O+blyzSt3mfIf40DzCB9ZjX+WqxiCs302bt3lminHfHVF27BkfmT7YV7R2m89ewBTFEKx57IMQfYOLabBpxJbdaT7KEcAYnEIwnMr/muRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:43:47 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 15:43:47 +0000
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
Subject: [PATCH net-next v2 1/2] net: phy: nxp-c45-tja11xx: add match_phy_device to TJA1103/TJA1104
Date: Fri, 28 Feb 2025 17:43:19 +0200
Message-ID: <20250228154320.2979000-2-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
References: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: 749d443f-3754-4de8-32be-08dd580eb0c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1JzazZnMmwrenowc0x6NFRWMDVzbmZhdnBXY1h2b1Z4SHpLQkgvL012cnlR?=
 =?utf-8?B?c2RadUtndGQxMHNJbmx1ejlrSEd0d25WRi9hZk1IbnRHUXlHRDNTOTByUVc2?=
 =?utf-8?B?elYyeVA5b0xCUHRaM2lZKzdvNzFmNk5DZG5BK0lHN2laK3lvYlIrTUN6U3l5?=
 =?utf-8?B?MXFHK3A5ZXI2Y2NmRVZKWDFabHIzWDlFeUNGZkk2em9TNUlRNGR0cmQ4azBr?=
 =?utf-8?B?SjBPejRQTXFTUFlOWEhrWjdmczNub3BjNFRKSVE3dThtdHZKSC80RU92WnVI?=
 =?utf-8?B?U0VqeWNBMkszSlpwaTdqNEhkc2tzUFpPT3NNTnFiQ2M2aUdyaXVXVWdJMmlJ?=
 =?utf-8?B?Z0Zya0I4QWduZmFKYW9aY2p1UFI2NU9WVVJjNlcvZDlhb3Q4S3lVUTFySW9W?=
 =?utf-8?B?dzQvblNoeXhVZ0FGZFZFd25xM2hTUXJwbTRLb1IwVEdYRWZZZGpPMlh5N0Zk?=
 =?utf-8?B?bDZld3JyRW5pbWN0TzNhL2l1L3MzdytWekVWR1I2TmpodHJJYzIxc3NMcmRl?=
 =?utf-8?B?SEZmM1NvcjNlZG9rRmdPNDhKWXRXYnpBb2tXQk9XaW9lMHgzL24xR0R1RGJz?=
 =?utf-8?B?Q3hLSE9hTG9CRWV3czJzaHZ2cmpGSyt5QjVWbDFQWjYxN3lMY3ZwR0Rwd3Bq?=
 =?utf-8?B?S0k2Ty9ZdjFjb3p1SHM1R3A0MUxMQ0hnM2g3V21YWHRyMlNqTXlGcVlDLzNy?=
 =?utf-8?B?clRET3BFb1hUOElOU3o1ditXbUVsak5UalV0MDlhVUtqUVFoTU8rYXZjRkl6?=
 =?utf-8?B?ZllzZVlic1Q4YnZZUEcvQnhPR0VSR0NxNVEzU1FFK2dVSTkzaDdTdHNIblBI?=
 =?utf-8?B?dzZodXlWd1UrQ0RyV0NPYkxmZmxZeVdSdTB2d3ZzWnppcm9pbmxWN2U1ZThJ?=
 =?utf-8?B?bU1wRDhHZXE4OGF1OXpIVnhmaDFlSUFpTnRRcXNBMWRHdlg5MTFaaFh2bHJF?=
 =?utf-8?B?ZjZJK0FNZXovZDE5dnY2bHNnMjFTZk1oZ0hxQ0VkbXJidFYvMWtpMG9mWVNX?=
 =?utf-8?B?V0Rpa3RGV2hCU01IQ3NoUW5yQldOaXFIc0xVQWxlZmtXaGtXODRjMXM0Rzha?=
 =?utf-8?B?eDNRMElXRmxZOXRxQWt0MnVUWFlGcjFvNENJZFNZN2VkbkltOVk4c092TGFv?=
 =?utf-8?B?QVBLSmxZb1FZRllpUXlqWWRNV3pHbThUWFRUcndvZzd4MlZ6SzZyeWZFOEtS?=
 =?utf-8?B?STdHS2wrcnNqT2RLeXBQMzdxRkdURlJmaDJrZUFxMHVLZVdnQmtDMFM4K0ZH?=
 =?utf-8?B?bUJLb09Md2hJZ0c3Y0hVNnZQWjYrcm9TL0hTVnZ4YytDWTFGbDNkbS95TkVJ?=
 =?utf-8?B?QkZBUnkvVVp6MlAxbkdGa3gzM1hyVzdXdEF1L0hEWDIyTXJ3MmhSUFl4V2lx?=
 =?utf-8?B?ZDV6bEU5UmRzTWxJeGcwcUlIOC9vYldZZkZIWmVMcU80ZXBjZkJSYytTTFdB?=
 =?utf-8?B?ZmkweTBTV0VONStIOXhnT3U0elZKZG5LRURQcmdtV0kzU2NyYmNrQXhsakpa?=
 =?utf-8?B?ZjZ6K2lVb3hHdEdEYlhUcWpicUxGSDE1b1l4Y0ZqenBGekRXRkFJTGc4bHBD?=
 =?utf-8?B?K1JsNXlTWE5zNVh4SUY2NTJ5T0JDTnNnblBIME1kZ1BoOThpYjFlcHZiOUls?=
 =?utf-8?B?M1BUdytJcllyNHJTUzBuUmJTN0NXUmExV1Z3ekU1SEE2QmYwRHBEUEVZMXgz?=
 =?utf-8?B?cFJ4QWFuNHNpb0JYbTVmdlZremYwNVpTazM0N1VHOUpQaGtSVXVuK1BsNS9h?=
 =?utf-8?B?aVBUWGJMOTRKdlJqcVdLenZveG1TTWZIVXRyNnJGTmlCajh0QXlZTUhVc1BZ?=
 =?utf-8?B?WnVEVmR6RE1zbzJ4V3F2aWdrTkZFL0JuaVR6aUpHQnRpTnRTclF2emNMcG84?=
 =?utf-8?Q?ujTJCjYKOeT1/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW1pakh2OXU0YU4vQTRjUHd0d2E0THFoa0N0elVzYXRiRVNJbHA5VUNCMHJq?=
 =?utf-8?B?Mm5iQWZDWlZKbUV2bVpUTUpIWm5LNFRyaFc2MlkxRE5ublZtdzJYaFo0YTRR?=
 =?utf-8?B?TlM1MXdlMDlpZXBSdW84UUNmcFVEY0o1VXhTa3A1YU0rbHlHVk9oTW1UUm9y?=
 =?utf-8?B?ampYUy9yNGtSaTZkcVp3M09SSGt2NWZvK3l3RW00SVVaTTZZa0hlVVlmMmc1?=
 =?utf-8?B?NXRxM3Vmbnlrekd4dllzOHdHVElnbm0zcU16UHh5ZFlHYjVVNnZEY0J6RFYr?=
 =?utf-8?B?dFZIZDRPUFluMEd4WnZaSEx3cy9GME5ONzQ1Q2hzVXBrYjcwR01vTXlNL3ha?=
 =?utf-8?B?RGdTbHprRzFFbVRPR2RWZ2d6ZjZmdjVTK1Y5RjlycjA1V0FSclRPb3FnVkxL?=
 =?utf-8?B?TWw3SWJvcjZkN3o3bitqeGxPbThGd0dydm8xWVNsQXJ1Sy9qbFhKeWFzK21k?=
 =?utf-8?B?aTlVQUFWWnFpeHJGQkVDdkdQNjEyT0JNK1M0R05pdmhadWdSVjNFUUFZTnlu?=
 =?utf-8?B?OUE0VTBFZjRiRDRVQ21mOHRMdkRzcUZudGo5dEUrTlhKM3RWbFVqUTRmNUxF?=
 =?utf-8?B?T0NwR0NBd3pwQ2Q1VzFEVk9EOFhEOC9rKzdYcFhZUzREZitZVEZQL1NCT3pX?=
 =?utf-8?B?R0dIR3hxQ1RoclJJY3kzZE5QNnNxek9RYkEvdWU0cG81cEtYQjFOMkpmSFJu?=
 =?utf-8?B?a1hPQjZ5d1BwSzF1ZC9HY2hnNTlEaEpWL2RjZVlOSnl2dElDWmp2MzUvZWNH?=
 =?utf-8?B?ZHIvQXkyRWFiZGdDanZaSVlOOXIxcExEOENBc1F5V08wNE5NbmwzS0V5WmtO?=
 =?utf-8?B?czlrSjZxeVl3NTFlVlYyQy8xTVM3amJNeXBCWlZ6ZmNaRFAraWw1R3M0OS9W?=
 =?utf-8?B?dEFlWUFYR3ltUjJCM1kycnNHMlA0T1NSSE9HRHhqc0NweWZNV2pPVjRTQzBH?=
 =?utf-8?B?OGYzNVdrS2p2ME44RjJSMlpuVVVIczFIeU9ldUYrVi80TEpGRWxLV013eEJB?=
 =?utf-8?B?OVh6dkNNTUZzejVzRkdGVnpOSWpUbXB6ZmZaNUs4Wjg0dDZzRS9lWE1YQ1Uz?=
 =?utf-8?B?YjBEL0J0amJlTHJDWTE5L0NyZm9HUkM1TCtreGVFdUExM1lXUTNUdUI1dFlW?=
 =?utf-8?B?b2UvSS80SkRmTHdxK2VoZUFvbnNXSjBncVRHQktwdlNvS3lPSW1XdUpoeml5?=
 =?utf-8?B?a2Jvd2lMSlJWQjc2NFNaZkhqNzdaWDRka3pFcER0dU1vTjJMZVp4ampyNTBs?=
 =?utf-8?B?N3hrRmYzbXNzcnhaMmJVbUZGTVltSlRic3lhcmpvM3VzNERYZVJjcW82c1BS?=
 =?utf-8?B?NWJsaTluUzh4Ty9EVVNiSGV2dTFWd0ZQNDlWbjR4Vjd0M1czbjAxNG4wK0tD?=
 =?utf-8?B?U05heDRISzJRaWMwMVc1SDFCYkZqaEsvZ1d0MTBWU0V4Y1hzSjU3dVJDUC9k?=
 =?utf-8?B?NlRhRmVwQndlVm4vZHlKMWVvMzV5M1JsYnU1b0t0bFNReHpvTGpHMGFPeWJG?=
 =?utf-8?B?MGE1d08rcWcrREZZYlVNME1wN211K1M5U3JGS09nMzNlUDZvRTNiYU5ZMGFZ?=
 =?utf-8?B?K3loV01JTC9tN3VDNGgrVlZmSDFuSVBOemU0YkkxWXNBd0VINHlQQXB5SXR1?=
 =?utf-8?B?a3FsZVZ1Uk92S1ExRU1YbkhrK0pOMDF1bHdhUUw2QjR5OS9ETTFla21iVmhJ?=
 =?utf-8?B?Vmw3RllJSFcxSTllSDI5dzI3V3h4VmJZeS9kYUwrd1QrUnFnTGF1bE5Md1pO?=
 =?utf-8?B?QUZiTno4RXNtbEM1S3AyNEd3WXp3SHc3RXI1MGlzWkJhWnpqaGlZY05MZDcy?=
 =?utf-8?B?eitBcGN5Y2R4QVlOclJiSkpSUTlTdjhQSGp2SVBaWmlQSFNVcStqSVNPMFg2?=
 =?utf-8?B?TTZxVWJubHAzRmJ2cFphc0YxR05hakZyY1VzRmR4a3BmUXNUZVljYmFnaEhw?=
 =?utf-8?B?a05Qd01TTUh4SmtFci9uOHFJV3lyQnZLb2xOM09ubmNPd2VMRE5XeC9kNUZz?=
 =?utf-8?B?OXk5SFlUQTRFaUlqVU9SdC9menRwZFdGR280U1JkcVBtaTc5S2FnK2JYNk5V?=
 =?utf-8?B?UXZpMGZHVmlUZ3ZWbGtMbjlBZStLcnRGbXZyeEhVMmViaVRxVm5nUXNjQjU0?=
 =?utf-8?Q?l5Wa0dFW1rJck6O/kSYDL/XAE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749d443f-3754-4de8-32be-08dd580eb0c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:43:47.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eYwSEimZvgnuIKyVkEab1x5UNvmPsSr26DdPyfBce66ZnKALFvGpBAyB4tD+WTV9KDoV+HaUybH7DqhkEj3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

Add .match_phy_device for the existing TJAs to differentiate between
TJA1103 and TJA1104.
TJA1103 and TJA1104 share the same PHY_ID but TJA1104 has MACsec
capabilities while TJA1103 doesn't.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 54 +++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 34231b5b9175..4013a17c205a 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* NXP C45 PHY driver
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2025 NXP
  * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
  */
 
@@ -19,6 +19,8 @@
 
 #include "nxp-c45-tja11xx.h"
 
+#define PHY_ID_MASK			GENMASK(31, 4)
+/* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
@@ -1888,6 +1890,30 @@ static void tja1120_nmi_handler(struct phy_device *phydev,
 	}
 }
 
+static int nxp_c45_macsec_ability(struct phy_device *phydev)
+{
+	bool macsec_ability;
+	int phy_abilities;
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+
+	return macsec_ability;
+}
+
+static int tja1103_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
+	       !nxp_c45_macsec_ability(phydev);
+}
+
+static int tja1104_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
+	       nxp_c45_macsec_ability(phydev);
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -1958,7 +1984,6 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 
 static struct phy_driver nxp_c45_driver[] = {
 	{
-		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -1980,6 +2005,31 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1103_match_phy_device,
+	},
+	{
+		.name			= "NXP C45 TJA1104",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1103_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= tja1103_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1104_match_phy_device,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
-- 
2.48.1


