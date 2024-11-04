Return-Path: <netdev+bounces-141458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093209BB01A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3911C221E4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C751ADFF1;
	Mon,  4 Nov 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="KrvN6GIp"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE928198A0E;
	Mon,  4 Nov 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713509; cv=fail; b=YnRqKkNjrlbaBIEGl+w8NOD/H04ny/ubQnt4a0MMNLsgKkl0ZKtr520TStVsmjinlQzB/tI67pbR/gbZIM8eMWIw1smGnY9Aj/k3bph8YmBzl//EfXNfJRxq74vj2YDPEnh1YoQJjPrSaFOWGGpbm0cFQGUxqsGchIS8j2h1kJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713509; c=relaxed/simple;
	bh=+nh5PU4nK8TL8ihazpxAUadQ68TPHGnSnTcykg5Yvn8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dL2QpX4l3emHOfZ7NnEJwLC2n4W7gCKH5LtWkUG1yCOWs7P24H1xVocZz8ySErQJDZsaoLpl17RGU1OM7+HU1NWb/sBSMWsSVTU2vmwizQGvB8Snkvk57uRBpLR7maBi5GF4JFr+kE3oxWGvRFtPVURmzjgHfvv6jemPIw3VqKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=KrvN6GIp; arc=fail smtp.client-ip=40.107.255.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP0BqFyJfD3hEo0W4bgV8qtZ7yDTqfGa5/p+Aa642PQET7c+gI/12rsfb0zhRS7VWOS3ilXeFQm80cgDWM2+SZq0eZfFjg8oFcYGNUT8+Yhq4bJBVVUKb61nJyldYyYOnyPjCrP2PF+5PfHa1xBYmpXAtNHcQRbQG7YIGTq361JhQJVKlFbrmjl6gacF1ZwZxHydjv8UEtIAlK0049VxAhDXkJm1HQ0ktJT5G/UdVesXJdmr+0OVSGYfBdkoVURa1bVkGEKa08XjUto4ZCqrL93VW/YQKeLt4NnWWw4x6w0MF4rWQQxtHEvqg1VZkflBCiDP4Ro/QYG5SlYfwvnCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x8WbTWZicQ7znriEfViEdrXAvoFejolOMzYSLA+irU=;
 b=PBMYKHTvSCCrYgb51OHnW8Z2zwh89bKiq1yyqIj+ixePSIwnrtAJ7VV1j0qpUPryy05hsCUiNWwTr+JEXSmoUUgeyzJtsY8woygHIQkeoacgYhojjs5x9o4hUzp1aDlTtU/3F8NdD3a8oCvsrgAvVtXysJQ7avFGQBHHIdFi+7TX0QxPMC+chzjsOttEttFvfq+hHpgPQpAlDA9iW1TX81HvuCg1Ot8E0lOmHNqt31ytoLOnTcSnxGJ8gVHIWF92PdIL5SqtwmtZs2a9WsGGA3HeaeHZXO2IRb1nujKsN+PT85c8jsZw/fGpvtCBExUw5Wr8zeL8e7FKUEjqmVeIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x8WbTWZicQ7znriEfViEdrXAvoFejolOMzYSLA+irU=;
 b=KrvN6GIpH6MKv65N+QDUBy7R05ZGJ5OfMJZWkXoG403Kx2dP1oOe68xooEGp2K01L4MCbCAlN9TkL7P5P1nIrjDcZ0ElKyZLYreU5sIUYo25DItMVk7maoILa31dJH0sRGVsjKemAu3U+FxT1zxqfpyzFyBt4xiS30hp9yVbkuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by KL1PR02MB6454.apcprd02.prod.outlook.com (2603:1096:820:cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.35; Mon, 4 Nov
 2024 09:44:56 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%5]) with mapi id 15.20.8114.020; Mon, 4 Nov 2024
 09:44:56 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 0/3] net: wwan: t7xx: Add t7xx debug ports
Date: Mon,  4 Nov 2024 17:44:33 +0800
Message-Id: <20241104094436.466861-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|KL1PR02MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: cabc73e7-e361-41e0-0ead-08dcfcb55753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAOhuXXVmpQQlMojUMhy90mjj+dU0QAp8O9xPx7SLr/c5XWwXw02boEsMDGD?=
 =?us-ascii?Q?dphvH8+rGheMgxMAPYUnd44Pd3W3CI1RF1/IhNTjF81tTP16hHaw++SrU//Q?=
 =?us-ascii?Q?7bGgD0H3nqmOGbVLP6J48ntC+1KhIUT9QIjyquaupcZJcCDDXcHRPOh0zS2u?=
 =?us-ascii?Q?Er9SAVKm6Rnr/M29PV+UCt2SPA3s4OLekcYcOZu3CjKScHxWUyESzv+E2lpG?=
 =?us-ascii?Q?EZ8a62bU9CIN9fmDQwq2AqrDTfK71n9HWK8O5aRRpT+jf2TB7EAx4JN7B5xo?=
 =?us-ascii?Q?RQeTkiADFITD5kdNX7rQ/oY163NLbft4oWV9t72ix+XP77GzLyyCN78acEPh?=
 =?us-ascii?Q?DqiNxnKfBbVWEEkwxNKkzHF2wyyjadr9devp/RTVOU8dKyIyIJu25ONfR9Kl?=
 =?us-ascii?Q?lcZLIg1UBKJjMUsgcEcTwCrrISe846Z+JVyWeRitSmS+hzDlOqh31rbfXx3G?=
 =?us-ascii?Q?3z2hPjR1Q6kgXcjetZ3Qr3kM7GWWKZ0z/XRTtAhon1c8LF1sGbwEMbr29E24?=
 =?us-ascii?Q?ufViHpQ3sqwtzRHMgJENiORWgAOpUEpd+Ys3zlwKScPG4p8GLEIWwq/yj4Fx?=
 =?us-ascii?Q?XTy7fQp2Mld57G6Sagl17E+9MfJk2cgM8UmKIVQO6pI3nnBqXCN3qc9DP8lP?=
 =?us-ascii?Q?phlBT6NlsZ47K/cwkVZeF/nbAYKB9fQzmyvEbzrjAeOPZIcTS/tIA7Q4oiSN?=
 =?us-ascii?Q?7KMgcyb4FDaQFnStnkkFonaNm/yZNocGrABrbG8RB3C27n2d4DqGEdpyPIuV?=
 =?us-ascii?Q?1w5YDK4oFvFGCjAWlvE8WDtQdESq2BmeZjZtHvoTQW4le6dYgqJR7fFoyyTa?=
 =?us-ascii?Q?CnemSIlbbSjiItEYF54yIGAz5GUtWTqemXq1ANaFWmbjtM4aSRXL/4kmTbzT?=
 =?us-ascii?Q?00oQ1w2BYZy1uU5p2gIrj1OgBcRg2UZWhC5j720VARLUITa3vpg7i1rHzyvR?=
 =?us-ascii?Q?IIxP7CyKr5NlktTV8upTVnH1TDSSApz1bB8YL//pfiLiofrys86du3XwgDpz?=
 =?us-ascii?Q?VLAaxqwrTmXxMxYwRP+r45i8DbTMlkvquqF0Kiii0Hk+5PrtNWF1Rt9eJEQG?=
 =?us-ascii?Q?F/SOzWXhiimG2/8M0vjcYGxu/GKJKVI5uKkkt6+PoR9AoAOvUn4fRVo2EsNX?=
 =?us-ascii?Q?8xDWrNWn+XFkH2SmbYM9hyQWyckTqiFH4WC1/AGUSUXZB9EI14mtG74oJ1D+?=
 =?us-ascii?Q?6WLXsgVFcCtvG8a6jhcPhB3HCGFF9JG9RHvsxKv98noarl19/j4aollVW6Fa?=
 =?us-ascii?Q?Z73S+yiLFngBPP1E3JkDz/tzNGCp1lH5IkkjCC6NkvA7zRiWP2IPgkDkKPx6?=
 =?us-ascii?Q?rXKHLd3SLAs4Ts883rPKtYwIrJyeKuHxk73Q5/G4pNp1tl8kwgZBL5zwTw6f?=
 =?us-ascii?Q?sPy3wEMludrrFWrqm8Bnzct7D40K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QhVMNdemABAHHKzWeNZ1wnYHfyUhKIiNJfnDGPdej2FrD28CaiP7IhsOxeY6?=
 =?us-ascii?Q?uUH8QFqDi9g7JCCu+C6k9oLabLlUlpDm4kvLZans1LZau4bcW/ZW3VcIP19C?=
 =?us-ascii?Q?ldZyN/PxOiiyF2lTSbHsnRylJV1WchKePog57uiNB+Kr9Tyb/NVotdeD0qzZ?=
 =?us-ascii?Q?XLWFQizBUe4cOhA7wNPP5SMv2VcGBjlon+t+O/jBLF7MYUpNwECl5z0IEM+t?=
 =?us-ascii?Q?jSX2hKYiLbfevvSi5PesbFCCg+AvTQ5s8IzaBH7iyYO8c5srYkmmxMJHLHZ2?=
 =?us-ascii?Q?CBkaF8lbnaaS6fM89+8xJ3aJBC1sNkOqkVRpRgbdmus/Z4TThd1BXl06scGZ?=
 =?us-ascii?Q?PAhFQq1jGqxr5/iydKjm+j+JM7/g7RBN2BuldqCsQnD4R22SMgrKzwg3xRQ+?=
 =?us-ascii?Q?sHXHnhSkOJ4S0eQHEMPgiR53NSKMzrse8erOCxruwA5LV3P0GubEaOBArQXC?=
 =?us-ascii?Q?YIr0JizmL0K1xopeov/wrI7d0zbGhi4ZkIHaGVBDbBlc7Z2ATF+QkW+EQqhj?=
 =?us-ascii?Q?+GOkQepyAcP/uDI45KZ5iixthX2Lpqipt27A8iinDQVc3bAV1iL1StIk4vu/?=
 =?us-ascii?Q?jvYqjSLhMnB6meuNqyKAU8SCoQS6c6d+i6k+Hchl7JLdi7o2qRDfIRH78Vco?=
 =?us-ascii?Q?4GXqvyAz/ehwmdHrUB6jBih2sOu2vOzKV6ITSBnjEXrn7qvPe4LWcZfc6Fos?=
 =?us-ascii?Q?b8v6dXfIOXdN5wtP4kKIdWBxRiGnbZy0n/Y9T1RCR/yvYQpZ16FLsXGD4nrl?=
 =?us-ascii?Q?pxyPXXQJGjY6ZHfeAcclbcuXmGiCpGAR88l3GExyVFXlV3EBNPuKikjL4UTE?=
 =?us-ascii?Q?hRSaT4V63zfg3MYey+rn+L5NrGV9Jziq5NckDI2iHIAkOBLSqMSKsOrJPnv+?=
 =?us-ascii?Q?u5Ujsnfba2g/ymgV3Ig4C8hcnfkbMmbBEtWmtvpt5BuUX8iV05jtd7p9v570?=
 =?us-ascii?Q?yk3bEdvv0Jte5z5VWd8mcPqPfvc3R73RQpE+2t6UzNkluWUtcxGDd66IlEDg?=
 =?us-ascii?Q?S+aHK47By62S9ZwXTvdw01bWmXUWYQ2tC7ZMm2yNTQikdDIgUoQn91Er/tiv?=
 =?us-ascii?Q?n+/ekGAyqy8jNMVg0sUbQUnSFFcE8EUmumnAVXD84flMN0ASEpK6NzRXu6Gj?=
 =?us-ascii?Q?blH5VfWeFdDQ6GzBYECcfPBQpTVeac16VQTapTlCi9fwBXGA63XQHoDwiRu1?=
 =?us-ascii?Q?Cxg9Pi2Pov/DZ3TsEuGNymUJUWNX74zthZb0UEPlaO3QcNsXAyMityRittbA?=
 =?us-ascii?Q?cjtJ64XbD7r1p69HytT1XSR+cIqHBhSPsBZkcBSte/WOtibraXpJLdPXR+Iz?=
 =?us-ascii?Q?kS/q0UA4WR8kT37oRVk0OgZqLgnv5xmNiqo7NlMoFKvB5wLtKKX6PoGVUt/m?=
 =?us-ascii?Q?48vKFSXvhDXWJouX/lwMfhLSC63PPJ2X1I4dIavbudg3/o4PMC5CPFdUR92X?=
 =?us-ascii?Q?xez1Zz85+8+J8mJsCTZXXid4ycqniCcgijZKD1J+KcJGank2IqoO5J5PzVKf?=
 =?us-ascii?Q?JmjwHj8MwszYc+ysh+84VA5/RYiYv1J+qMTcPIDKMUOhTgNwrzHtR3caKt5V?=
 =?us-ascii?Q?HuheyD0HOpIaxn4Jg3RZa9Ybb0X/Po13YhvBwq1PYX58GQp+vSwavgS4zC77?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabc73e7-e361-41e0-0ead-08dcfcb55753
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:44:56.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJl64IDhSrQDOEtlne00p33q4L6og1z6cIssOtERpI6B5lub77is7eogppt3qN4G2TFzoa68jxPKJB9V79kOdiFuyzIxH/hPpp5rLI7x2Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6454

Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
port and MTK MIPCi (Modem Information Process Center) port.

Application can use ADB (Android Debug Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.

Application can use MIPC (Modem Information Process Center) port
to debug antenna tuner or noise profiling through this MTK modem
diagnostic interface.

Jinjian Song (3):
  wwan: core: Add WWAN ADB and MIPC port type
  net: wwan: t7xx: Add debug ports
  net: wwan: t7xx: Unify documentation column width

 .../networking/device_drivers/wwan/t7xx.rst   | 64 ++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 58 +++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  1 +
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 51 +++++++++++++--
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 drivers/net/wwan/wwan_core.c                  |  8 +++
 include/linux/wwan.h                          |  4 ++
 10 files changed, 178 insertions(+), 21 deletions(-)

-- 
2.34.1


