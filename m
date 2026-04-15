Return-Path: <netdev+bounces-278731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QX7VEpNf32k0SQAAu9opvQ
	(envelope-from <netdev+bounces-278731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A2402E16
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB579301CE51
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4233A9E2;
	Wed, 15 Apr 2026 09:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3A1EB5E3;
	Wed, 15 Apr 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246157; cv=fail; b=WmMM0cukTjcuI0T9pIRlysE1sK2k2ll8NPIABrgTxmXAek9MyvNRht0DBfnuiVtmLGRDaUcpj8p95uNIPyEQgHmzgn8QUjs2cGR2jM/jraHopYJVYOOz4mR5KvRtmkxs0hYmXSU1j/+5PfSz5lB/HLCV6jhCdlUXNvfOn7HBE6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246157; c=relaxed/simple;
	bh=7teZr2ID/gEH6zkNmrhQGn3ykqv6MT75r9A3EV6f/Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ILlcr/lofkd7x+rxIPEum1Iw+2jOemZWD04sOqP2A0mQtSBirFc/nZf+VuS3U4Boy0ZimyakgjsIx9MWCuL2xPCndUjBUGSXPxCxCMmPvEUCTF1x1L+Gt/k6X+wMBbmwTQWb40Gd8jQUlFvqJLmD5D01cZVhD2CFhK+RXSqGszg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyqwHa0zm7rRTjxpndWeTXOmHdWXZON2pdJOdJ/oHHQLy4piRvp1ok/geFuKS4RkzRuF8bmBlRe6tAm1EqoZPjykHnIQRd4se0dPQ9obcelkAjHMDCNlsYDmy15Fglxac/4HhPBxQDwbOe/FmvhVKzWRq5V/UF1pzrfdCX0puE74xxOAjpOwwso21eO97oWJ0ZpPua7JQdYY10lYYRTd+9kXr9/GfH6sMiZOGSFe0g64r4EtiAjXw7AiyfZ8ZmjSVjYOWCK2OCX63S2GdfjwvkKVRELL+4sMXibFICaiXTFuze4pA/TWLeTI3WOiNKbpyEIoQ55NtQJr834m/Q/kiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u47rJJuamFlm8IdCq6WlcT3WzK0cy5q1YoAqAMdL1bQ=;
 b=fGSdaeONyYqobi/v2sdzZkcl5WUVos1FAebnsYyZwNwS4bbmzj+cCfpkfxNBGcaRdftJMG5/93f3cYJsRVfwwbhBG3NieHcYaViptsNNL171g4WVtJkKPezuqoKBFqtO6y/SZyofq987kseFnhdQmBTkabPxwlML44Tb+sOAfLF7GK7/Li1ew4rrPmJtCjGlV0EG6GjTqU+BxPwh6LVBgJQ3hyjhPuHq/U81BOC4wwPLPecwk0OL8vlW/lO+57TyCXcg4vfnFuv7O675LySU7XYd62UG2NocPf3hflZVfq5QgLSNY8YGWCxkGPOhgFykhUo4sNxtnDw0R5V78axwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0712.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Wed, 15 Apr
 2026 09:27:03 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Wed, 15 Apr 2026 09:27:03 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Wed, 15 Apr 2026 17:26:51 +0800
Message-Id: <20260415092654.64907-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0712:EE_
X-MS-Office365-Filtering-Correlation-Id: c025a0c2-f70e-45d9-ab59-08de9ad12708
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 Zutzjhx8D/N5+7BHdg2AEq5aV3ubbK0Oi55b0Jhqx0PZ/FXtIAJse488t/V1QVNVtx8szQ1ZkqD+5LC6jOwQU35CzOjOHP3nIfg143hsH79trwrwKYcG07tlneJZmAzIOvPIRpsEu5aNQLnRAavqlDE+YHZJlOlCFf/DkFqA3u5mCiHDCJLMFinL42spNP4ajqRpUPN28YIwreTiu36hHBxt2Jfhjg6Gogh6IjSAkUMCsn2cyQjiQgI5vWdTz/rmZe4xxekAEnhqyqeruywa47htnrwtNNOWXblX1dxsons7FTmfV2G13czzUAbzc9p5lqR8lZuob4i3WfKJL0shiKq8FUBCYJhPbJGUAITOkWMeg1I2WmLnnBzHP0AUYWJLYaMB+sozDWaxaf0keLhalPtFrEdiXtDgo42AHiiByqwskjq9I+tyjaUm1jRL/NjgCMS0SBaM6OomC5f9KEP3vTK/sSxQJKVPr7yVmJBvg4h2Vzsbl6KTd25L3ZixEYWSb3ZKsIZzDCD7qh26knNlg3oThuNa7NBgzgo7SAU8XalM80Yv9riB2JHA9kMe/y4tYEyrednSOhntx6RtHjTD+Q==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2+5AYtBNkiaftlV60UdBKDEfunGfVdEjnAL1eKZwQrO1823z7KEsLNqahTIM?=
 =?us-ascii?Q?RfvffpuAo7J0Vk+GcTQ7YhgF+YnkxrZivD681NoRtKKeMWtMuqj5MV6lMA8m?=
 =?us-ascii?Q?nN7BGy+CX4tLrkEvUkoKVsIBQDaNVYJfwvMtp1zdOFw8bDRFwiSJg3MupjPp?=
 =?us-ascii?Q?hxSLpyReGbdxkTrUOeMeyPg0DC4NKJpEl0TGgYV0/2j1LyX6cU4SZjEX0UdJ?=
 =?us-ascii?Q?g1x4coRrBNvo65spvmk9t+d49owF43pwrVFrr3dLUT2Vp2rY1tZ7xMDNBpK7?=
 =?us-ascii?Q?lNoSRWuqaLqWEOGxFfO1x1kqUHemGK2x/ZMPZO5UEq0NIj1UW2Dt+Xa3tnoR?=
 =?us-ascii?Q?DGHNqmdlWnFM+rtJG3qKfeY+yrbwnHJH3HSQYvbueYzeutTOVFwpZwIdvVoo?=
 =?us-ascii?Q?vDxIvulJ63FhikAz0Yos81z0uRgWNO34IptmD1X9VnU4o1UxmLBHdw1KTUW4?=
 =?us-ascii?Q?Em4NhJ/J2ojEP+1KL72LzbgQT0XfeIxCr6SjLTNW8quxQj5oUt6ixoXHcXz3?=
 =?us-ascii?Q?1LX6gEZDtRSW5EcUaXTe/2Od1WnW66CiOyAsf0ZlUZ045Rw9zA/UnD4cecXp?=
 =?us-ascii?Q?DMR9tvrNx964LqtGYiHEPqS7cJlrgXL/ubID9XnPvq6ESDEl59+Y1xOF0VP3?=
 =?us-ascii?Q?Xd1eNBnwOVS2i8NH0wu3a/tPPQ7nJp593MOyLE1S4fC5iQPMRxT/lwmJzhIm?=
 =?us-ascii?Q?UAu34WsUFo/CfYz7ZMp11/CxvEfSf63tl+UyNXC9MWI+dSOIwimZDt+4MLvS?=
 =?us-ascii?Q?XA7VjhyUOfAMemg9En1SMMm2Pzf8+DdCKVhBajgkFRaAXMNA2g+OsubjHF7B?=
 =?us-ascii?Q?uzShYWpR3q0vBky3oo3ofR2l51McqwemZeHvFseCfOIIgdXKtjGJcAPbcnXo?=
 =?us-ascii?Q?6jWACEz+Fq10LfSDiYKT2EyoEKn4ujoquRHmYWpKOrtchsmpkJpyn1dY5ILQ?=
 =?us-ascii?Q?v8PG26HXmdmA/Vks0es0NGFGRN26oiDXQlMPRxkai7PMTMtFD+34jpE0cvDF?=
 =?us-ascii?Q?H/R4zTU+6DNiqstqHk/kfqjc/1Nr18mpDzeTPniZY27FGevSTj6X3P7RwTOu?=
 =?us-ascii?Q?xLTISQs1FAvJe7ewFKLGhLtCzLRYWW5Iz4J/HVOm1B4YVLS/wII6dPlo5wTX?=
 =?us-ascii?Q?5OUZuR20Pc+GYgdO0XKfQsI0XkgMJgmes86A6U76uKYHH0Jn6HpUDfQbBO2/?=
 =?us-ascii?Q?Xq6iQ25YdQypC7mE6Tq4k16A/Z6GO0iQyltwXag5sfYAkkGqubBhqzrpBbDM?=
 =?us-ascii?Q?meOOyvicjWUBRhPqRTD75QBlIF5R9Y7DM1xUS9ayywgNg6+3ti7qoDRlG8U0?=
 =?us-ascii?Q?o3VZDCbBV2kynjXtOaD1SXYNf9lJfzWj36GJSsQbHxZqLhWaUGsR4zTOd6B+?=
 =?us-ascii?Q?dl2P411GeTgBjZddGjFXzRKzwm5evl2VloCLgei1bm7xNZmw52gJfHHr81Ca?=
 =?us-ascii?Q?OOVMF14R/AjVCQauA96VFB9Gssi4Z5dN6T2mppkeVN8PCzMaivynkV4iFcgp?=
 =?us-ascii?Q?zGi9qoyUeVNzRgvsrsjCXXkhpr9RhinenKkMWowSuTbxEW03wQixGk5apM1E?=
 =?us-ascii?Q?/ujEaOWPKM/Z2xauWdbHaaoEeZmXjhRVvzRq9yvtPrACh58yDRziISydRI5R?=
 =?us-ascii?Q?Hl/hLti2VuHIs2kogaoMJz4lKHldvVFBThnLw8RThr0Sb8ecBuoJb1hv6BOD?=
 =?us-ascii?Q?MXOz5bBFEma2XrmwlYg9O5vgkRrVvAPr9ynIHXWY8nwNbg+KmA4sTjtW+tiO?=
 =?us-ascii?Q?RyqVYHWJYpNpvZhyF3TOYP5Z9sCXIk4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c025a0c2-f70e-45d9-ab59-08de9ad12708
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:27:02.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZuTu2ngXl1cnYsOaGsWJACefT+CDGBFYsanQeKkn18xJCadCt+AYe3ucAV0u/YkmYJE3IFHm7I9S98wGbDnjQE5YrLl16h3hc2mhv1wRwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0712
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-278731-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB6A2402E16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is for Starfive JHB100 EVB board. JHB100  contain
1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
interface connect with YT8531s Ethernet PHY. RMII interface connect
with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
patch 3 is RMII is for RMII interface.

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

The patch base in V7.0-rc5

Minda Chen (3):
  net: phy: motorcomm: Add yt8531_set_ds() mdio_locked bool parameter
  net: motorcomm: phy: set drive strength in 8531s RGMII case
  net: phy: motorcomm: Add YT8522 100M RMII PHY support

 drivers/net/phy/motorcomm.c | 105 ++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 17 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.17.1


