Return-Path: <netdev+bounces-231786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0CBFD6BF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CC33B17EF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A2C272E6E;
	Wed, 22 Oct 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYUGm4n9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080802459E5;
	Wed, 22 Oct 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151848; cv=fail; b=JfVN78K5DepNuiF8jRoQsSBb0R6GewtsS/4nlL/fmc2fAvCrsUYLoSedPGIvuJov/WaxTUTahDVTvZ/I7MVAcqdVtcVKdSzh4vNUe9Q/wY965x5h4HzVnE29tprHCd2h+sXMumVb409RdyasAvsfjNOFZ7IH0RjbUjr4kHdu7OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151848; c=relaxed/simple;
	bh=kmUWIgmTqR0KggI6jTvveHrJdthrkisPtQ3smY/reeQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IOYAumPvBYyMrJSS8rZO23mLdwbVshJcjjvzlzkoZ4dHO7HgYnlmuSfFvt7XQ4ydsAtjUj++FRp66vjqWQ8nUZQbZ6+BipK+8BY9arUxWdlHfF+0s5bIXZemkEBkd/rKOQrf74Dm+qNH8JIipZ9WSuQGwW+Qbtw/3F/f/CWA1k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYUGm4n9; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUlggxoiUzOrXFWB2+dT8Qpor1croRDma6H0I8UAGxHMvV5EyV/jvZYX4Rzc9dadGQL/tPiveydth3BzUTtW86u9Ogl434Hr7KKK4+azBMsB6Mg617hVklvVoCbv+dIz6jllyBH87ZahCrywl3YnpkuFwH053QtfvB6HNY5AcicHgY56aHFqW2Jt7jCgsFtBd9a+52KRjs+D5ktzzNmaTmqNjgNHhes2WszS+jms86Jkpeu8r22PzWOj9t7BR1RPPAQn325LPXnnNaq+rd4kjqqa1/8VzCjAZaNvY7DdfTTcg2n+o55ewpETdEr797EwkZto4Wefg0ldV2XH7niQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W7fOn07yUloVQHRvViI3m412J6irJiaTOGeBs0DqIY=;
 b=V5rYw7KnVxltUjYvEnGpABvKbleTTlPtk1HOTzb06/i6Fq46dJ+J4EkF5/msl61BdYLfNN4Ny2Hlo4hZYQotyruFlm6jU3+KbfHbcHX6t3JnhS9sVR1rU7me4EybEoBWaOSsJCe4ahHh4f4kHcSiJ8Do5ocJ/Q9WyFF3P772St0a7XdOjNi1Yno8H+LTKYeSXut4c6+dM4V6pYp70zNPkgG5+ggNQ+PvG/9Hb8Z6wKvIDhTtBtqazmphMPk7SXYlkhpHg23Ek92oEEsAhkUaNWb3EUs870qofArcKm5s5+sqbt8ApOK4kQPnCxUrOSYIBa8tb3YP1phOGsK9vExzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W7fOn07yUloVQHRvViI3m412J6irJiaTOGeBs0DqIY=;
 b=BYUGm4n9fll/YkZ1hCm++M8fRpaWleTLK3J2xzHk58vv0k5bA+Mc9nMkhcCqIAhwfSZ+KeLuugKxllAiO9O/wneYxvlFjPjWp/7yvXz+pApU8e/ZHlAaibe67dyAQSP4ihLPE6tsJ8vemS4xL7etaHJyBb53kTkhy/V4Yo56C3oNRNfwHrIVRZ7E2Rfro1WZgWLGMzTICWTvdrAe5Hu5k7w8jxKkESu35CW31NSJkAdGZwKsbyxPNoQ+DqxQnyaWY1EhPTK8IhQ6rT+8KsrO81fn2i1ZNG8sbjiPAjTcwW7d9r5vviYoeI89xpWBz1B/8qShKs08ZNKQxNYuP1scGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:21 -0400
Subject: [PATCH 1/8] arm64: dts: imx8dxl: Correct pcie-ep interrupt number
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-1-8159dfdef8c5@nxp.com>
References: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
In-Reply-To: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=812;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kmUWIgmTqR0KggI6jTvveHrJdthrkisPtQ3smY/reeQ=;
 b=XltKdTxt5Rzvr76vKU4lucYZ+03Gt9fw3k6ts4KGlMKk/clZ0g354XjaTQd12ekBRvaYiDYIa
 b6R2Rl02cPqCScOWyfl7/Vs8ECViLosw6ac8HHfNRLr7p9waeKGHccS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fb6028-6cca-40a4-400a-08de118b22ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmNGYk9kRFBEbng4a0xZV0tGOXdVdHRsSHhES1FIWkxZSEplelZWSmVmcG01?=
 =?utf-8?B?MnBCTWo2aEdzZm5CcUNHOWpkZmtCOHJKdVgvRjRWZFpIVEVsMGRybTNoUkRS?=
 =?utf-8?B?Nk1UUTV4NUdHUjMwRnduLzkrVStWQm55a3Z3aVBqeEQ0aEx1bndaZHRpR1pQ?=
 =?utf-8?B?ZXN3ZUhBbys4a2lWS2NSVTNxSks4VEt4ZmdVRCtDRDhINll5UStXZ1pva3lW?=
 =?utf-8?B?Tng1VEVWZlRnNWVDL0Naakp4TTRrOGlGV0Nob3NXODh6eURFc3B6Z2gvcWtv?=
 =?utf-8?B?THZzQ0x4cSsxTHRwakd6aDhSaE5KUFI2YndlQkUrMk1la0hZYURYeVZsWU1w?=
 =?utf-8?B?ckdYdm5Fc2lpN3V4MzZBYVlGS04xWTd0cTZpdGd1akdIQnhvMDlOMTdyUHkz?=
 =?utf-8?B?UWxQRkthbWRYa2duano1Z0V0cm1ISFpGRlJPc1JBQnhGeTZPMENqWjVZS05P?=
 =?utf-8?B?aHNYL3NLNmZ0YTFnUkpmekNzZG11LzVmL2FzWUozWnNON1FRRWdBUjRPZWZP?=
 =?utf-8?B?R29sdWpiUnZzVXJRVVc5VndVVU1CbzRpbkJDSnlxVGFiVm9IV2E0Nzh4NXFL?=
 =?utf-8?B?QmlvdTRVMHFEUytqQzVHcGZnQ1dBRlFvZ1RVcjJJdm5jQVliRXJwcUNQamQ3?=
 =?utf-8?B?OEs4cys3NmFuaDZzSXMvUFlPVEhCRXI1N3JGSXVxeEE1KzJURGc3WC8rSmpC?=
 =?utf-8?B?eUkwOUVRaUprTHppbDRRT2ZEbDhjTjR0QlhPSEVhd2hYdUp0VzRpT2VUbDh3?=
 =?utf-8?B?UFRMcFRCM3BoTGxJdHN5RGorVXZmc0dwSUc4Rld3WmR1bHlYTm9oeWNtbkJT?=
 =?utf-8?B?K2h2YU9COElhUHdTV1dEWjZvT0x2K3hKWXRqQi9NL294YXIrVmM0UWxFMnFy?=
 =?utf-8?B?d2lMbFJreEdUM2tya01wM1N0dXhnbUhXNG14Y0pWelFnZkJpeExiTlhweWM4?=
 =?utf-8?B?Y3lMcFlIRkVMd3JtN3dsdHpGYXU0UVNJSlRVNkhhOGJBNWdUMEpLSjNaWlMx?=
 =?utf-8?B?VERHT0NuYi9rRVpCdkNUS2RaaDhSdGk5NmxxWlhrK2Vad2E3TmFMamJwUkZP?=
 =?utf-8?B?YmNtc1ErT0Y4eWFuV0t0Z2NCT2JPczRGbjkzdlNCNWZ2UVZnQ1V0MVJvSVlp?=
 =?utf-8?B?aXBLRVUveUF0V2RsbG5sK3MzVHRjcFUyRDYva1o2c05HZ0FvV0NQUVNsOHBG?=
 =?utf-8?B?a1VubE4wRFB3aHNvQXFkVElVN3M1OVBFQTVNL29ZdDhNWnZPcGhvVk16WDgy?=
 =?utf-8?B?SWNVRmZiVSs4L2tubnNXMmtLWlM3VGVUelUxQXhTdHAyUTg5NVRiaFM5Q2ln?=
 =?utf-8?B?ZnFwSEZDTjB2d2tPNVE2ZXIySGM3Vkk3MDh0Nmxlc3pjejMrb1BTTi82S05l?=
 =?utf-8?B?NEtLUDZkUUpDMjVodFM3V3ZJU0pYVTJnRWxYSWlVMnBxb3hXNW5oRHU5b3hZ?=
 =?utf-8?B?U2pXTzJrQ3NwMnVtQzh6UHZUTHpQNldWUGRkWFpCRXVpTnlZS25rWlFkYVlm?=
 =?utf-8?B?bE9FbTlZcXZmM2FrUGhMWnhJcDArYmZGNCtGcTNJRllkZHR2MkhYMHdBZGNy?=
 =?utf-8?B?d2NFNjN1eWdmWldXSVRjbmtjZDNsSHpaS2V0VVdaYzdaZHEwWWlRbUUvUzI2?=
 =?utf-8?B?UXZGVnFMa3FZREcrYi9ScjBCNVNQejdBdDVtUlpUb0RCRW1xM3N4WUI1RjZa?=
 =?utf-8?B?OUY5T0ZpVUFSZkpHUmJJcVNYejRpankxSmhWREx4bU1CY1hFWlJhS3ZkbDhk?=
 =?utf-8?B?akRXSkNRODhxTEF5NjBJZDZBaXQyUG5LK240Q2dDdllSUlhQK0g0VEpxZjQ4?=
 =?utf-8?B?bElOYkEvSW1tWjdFd05RYk4wZkwzNDBLZkhleXIvQjVXbkpSbEJCemRma1Z0?=
 =?utf-8?B?RUlFbXQyVmVTTG5XeE16a0NMWGgrbmFJb3lhVVlNekdzbk5ldVUzbi9BNXEz?=
 =?utf-8?B?elN3SEx1eVB6aFJDWCsrT0krZTM3RHMwVUpDSWczZXN1MUpaVXBuWEpxTXJO?=
 =?utf-8?B?KzYxZUdsOFBOcnNmQXBsN3o1bWZCQUJzVFRiMjJZc28wdENWeEtBUXZOWkZC?=
 =?utf-8?Q?xchnmA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0MyTUpTYzlXcUVJMnBrUSt1UWpLUEhQcnBYOEtaWG5FdlBzK0VYRzQ3ZVdP?=
 =?utf-8?B?WnZSM05jNWhiZjR6M2FVL1BuK0RyMEd2Z2V1SkxTUVUzUURFdit6aEZFNnI2?=
 =?utf-8?B?QXRYRzkyZVRwUFNGczEwd2VnNWV3aUhmZGx6NFdLS1E0eEpyL2RaMEpKZks3?=
 =?utf-8?B?Zk1sazhuRTA5aVRzREJpQ2dsMmFobEtwT3ZsRk5qckx3bzVXRzlXZUVra0tZ?=
 =?utf-8?B?YUE3T1dJbmNDL3NWcllrbHNwWUtsRkhiYTRWR0xtYjJ6clQ3VDZqN1lBa1Fr?=
 =?utf-8?B?VDNuMC9vSmM3SzJLd2tHZWZrSUJ2bHZxc1g3ZjRoUExnMVpkdldISVJEalhN?=
 =?utf-8?B?OTk5YVB6SkxsQTJpMEdiRTdYUXQ1aWIySEgzOUQ4N3hRQlV6RDdyaDRDQXhk?=
 =?utf-8?B?c0ZDejRIZk9tY0FEQTBSajIzWkNXM2YycGNOcGEwVlR1T2pVMHFxcGE4c0ha?=
 =?utf-8?B?Szc0SDRmQVJXWERBTHV6Ym92NHJsNGFoN0p5bTlycm05Rlk5VURYK05OQmps?=
 =?utf-8?B?NGZMemppZ01ZaUNiUzVBRlV5MzlMN1pIYU9tRHo4ejhlZFRvRnY0UjhZcFhE?=
 =?utf-8?B?S0FRVXRRcFlwRk5GQXNOZnZndlFiRmVldHhGU1A5N3A4RVlxSkxLVk56aVZE?=
 =?utf-8?B?eVZBN0hTbkhYWFR6ZU9SQ3Uxb004Vy9td2R1aHlkNHZFZjBYSUdmaFVCc3lx?=
 =?utf-8?B?M0pOa2Y4c1dPZTlyTkhwQ3U4Z29BYktSdEJhSEkxd0Q4RG5EZ1BCdEw2NFVN?=
 =?utf-8?B?OG9EK0dDKzhLZDg3cmVXWHFSWXFaV3hTK1o5Z2tjVlArellVc0R2Y0NNSmFZ?=
 =?utf-8?B?blNwSlFwc3VNSVhHREN6M2JVcXBZbVVzUWk2K2U2T25BYk9KRmVOZVBDSjFG?=
 =?utf-8?B?RU5QUUkrZUxLNUZFTnpjYmdIWkRkVDVIeWZlQkFLdHFraFNoZnozenRrNXBz?=
 =?utf-8?B?dEp0a0pSRUx5RXh4aEx6TU9zVHVVUXpWUUFWWjV3OWU2MEVsbElGS2FkdEFk?=
 =?utf-8?B?eEVGSitFbEJQZmhtZnhSTFFlbmJSZWI0Vmg2aFFnOER5aEhBZWxoYUFTdm1N?=
 =?utf-8?B?dVU4eDhGeFdER2lDSXVxa082dkxZOVduOWY4Qm5FUzVZYmpCTTQ2aXdxTUky?=
 =?utf-8?B?YWlWWFRHTHo3M3dQbEpBTUMrRjltZnBkTUo5cVNGYnVpUWdaekFEd3psYjF3?=
 =?utf-8?B?dUJqT0NtZjJnQXhmT3BudTRtMTM1VDZUYXkxVWxQYy9lMjlKZlpoV0N3bTJQ?=
 =?utf-8?B?ZFJ1RFJHNHQ2TGZCTFBDWjJlWDVnMjl1SnBVYklvNkg5eFI4VDZkSXMweW5Y?=
 =?utf-8?B?cHBjUmkxcGxPR1VMTTkrM1E4TzkzV2p6allZTXowcmFWKzRHMHZpaUxrVWR6?=
 =?utf-8?B?cVhPKzY0eXNySWFDSFM5NEVZWThHTFZ6OUd5ZVB5TWoybEV1QnM4WTJSdTFT?=
 =?utf-8?B?V2x6UndCc0svZytHbndwcnpsMWNMVmszWnVSenplQzV1QWVNWHVYajFMZm9i?=
 =?utf-8?B?Ti9WeTNMZzZRZU1EajNXZVhBZzBTbUxxbHBGZmY0YnhnV0R0SDFJUlZoeEVW?=
 =?utf-8?B?dTcrTGx0d1R2R0x0S1VHSEtoL2dTTGd2dGNzaFp4R1dIb3YyY1djbHIzUnRO?=
 =?utf-8?B?aXVWRmpBckpsTlRJRitkcHp6RXhRWXRGcXBZcU1ldzZQaVRaRFpVbFlHYm11?=
 =?utf-8?B?TXFMbk1HMVBjbWNHclhSbXg4a3kyKzhtbzlaa1BFRGdOclRvOS9yQ0ZjZlNk?=
 =?utf-8?B?T1BqK3VPSXNQQ0hjZk5uVUt5QVZnaVloTHcybHJJbGlqYVEyQzlpV1Uvb29V?=
 =?utf-8?B?bHZmUlpFMXQrL0RiTjBnTEpNdlkwV0swRFRPRldFQ3I0YkwyUGI1Y3FZVTNO?=
 =?utf-8?B?NVJ2SUJGZ3FFczFBempETkZabHM1VGRtbXgrZXhGSTQzN0E0OUp5U0JDYWJ5?=
 =?utf-8?B?QXFaVGt3MDU1VlIrdkFFZy8zZFNyQXVZRlg5SFZGcWl2WTZyNnAwVGdhb2NL?=
 =?utf-8?B?TWovUkczbTREZHFQUFVkWnkzWVgyZDMxYm1rZUd5bHA1SjNVb1h3Y3ZuVXZT?=
 =?utf-8?B?Y2ZqSWRmbFd5MUJIVlAvUTdjOEJKVkVxaGpWQWFSOUZCSXd3SG9MeHdKRVpT?=
 =?utf-8?Q?Z7dOqbRI8jo5CJq6Trxb+a/9S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fb6028-6cca-40a4-400a-08de118b22ad
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:41.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soCVL6jn2JCVYjCjCZpZiBeyz2aP+p56LMK9ivw+24EwGBBXyTC05+KLGfZbobDPZmq0/GeyRj9hxUToiU2itA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Correct i.MX8DXL's pcie-ep interrupt number.

Fixes: d03743c5659a9 ("arm64: dts: imx8q: add PCIe EP for i.MX8QM and i.MX8QXP")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
index ec466e4d7df5467803243404795a9a6a1da890b2..5c0d09c5c08627f9978f0f69dcc84f6b2b917d62 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
@@ -54,3 +54,8 @@ pcie0_ep: pcie-ep@5f010000 {
 		interrupt-names = "dma";
 	};
 };
+
+&pcieb_ep {
+	interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "dma";
+};

-- 
2.34.1


