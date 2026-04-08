Return-Path: <netdev+bounces-276370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHhWM1Ib1mluBAgAu9opvQ
	(envelope-from <netdev+bounces-276370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2043B99F0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19682300B53D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53DC38E124;
	Wed,  8 Apr 2026 08:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C833F370;
	Wed,  8 Apr 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638779; cv=fail; b=sfYwl32lmS/iGavENJz8kTf1rpeCKUbchd8HPboNk0hpg+bZbM5aH5vRUF+Tf8xZM54jg1vxwRW1c9HV4HfCl2TfuXYkBVV7jvK6B1AzJH2ie0P0em7vsE8QRJe0Hwfq4bXNcUhA7etxYhjH0bSM+jyCN/A0UnohQDBfVw6Tp3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638779; c=relaxed/simple;
	bh=PPsWgKmOaPYL5bXj37ENzruWd7kcnsEZKJfciS51Wrc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bw8yY5uSIYOXfucKk/hM3t5xtb3c2QDSGL5WfsacXp/FlOvrBXWONNG1V0jZOF9DNBTSBOMGKj0LH3w0YRkE1tMwd/QSsYw62j7XhQ+GmkojpPfmd4ma3BLxtV4f0jgH/j47ESR4WLaROWvzha51oLDHz5bJAyrD6KxeQDcKZRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGzxnPytRuYJ0jFYc9mDq7zOaoGSq99J1usptsuSWtOOMyHrOVMOOYV3GoforLIoi+eXtTPzQ3RhcbGmMwTfDpfd4yq/6Af28rZNBjILAbVYLi9JpjrV0Jr1aFv64nGdXz1sNQeR5jMYP9buzhGAdj6Zw153dKHtWSh8xgMFtVR9GPhAZsjS9552eRVk2bX0oOOOnlleBBYPp61vMWUZFFuTezHWhq45761EvEU3fqi9KwIDO560dtmXgEKftnVUMl+THGF8QKI6bmeafI6E1k+0i9zS9OxEe+aaMYeo4UwNAO0I7YORLcW0bxNOyBCkg1SauQIw8a5weF9rFSifdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zmfhaPUQaV/qKhRRuNmokCPlmlEmTkPnSqktZOlVzo=;
 b=FVpjRMnjKcKZemMDr8a8TFfPj65QEMh6FLtHXs3BdHnZhCGlzA3bd6wppyrLkAr3HgRfQSBMbL6RiPn0fW0QZ6JLuLLlQtcqhc2B4VTfJNZkrtZZ9zSJpvGOTt5NOY1WRqIgXz7M6i6Xwa+8lspHRZE5q0O2ff6K+EAUBLMpA6nb/TZzEUJJwJounwwJDEQtDi3Ij3UaTdblDQY+kyMEleJIrzksH3t7McQxb8/R6goHtb1aigxBZix5pzsWJbwsPGMXcN/P76IgqRR6zECED/vtvu66pvsDS5GXP8TJ+oag8uNr3dQsxo7GxwC4jEm0qAd2dScQ8P/fBy9SGip1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:25 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:25 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 0/5] Add StarFive JHB100 soc SGMII GMAC support
Date: Wed,  8 Apr 2026 16:44:11 +0800
Message-Id: <20260408084416.29753-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 6290ad3d-0906-4fd3-ee11-08de954b097c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 dA73NIAC9Nv35JIPb4lJFxaWCZaRO8EwXNAjW1ZkVNZ4S6RJnDvBB5XjGy3zlgj+NXn0X2/XCDOpkgHt+9YhDE1crbhjlUUIraTjdFiRqBGa+h/B7ZtUQliRC5AnjNUTBelNTfjbfMpzJJ1YCgTBsmEUihstpTVjqjE146Ols4mqCjFBG7tpTsy0G56JdRNKyr1uwuwlflzJUv7gOXReZNIfBVXt55uhcvnQyFsQXvWHXOqSDuIqJ9/NOwk+NBULdEvtecosfMnI+vHnUtozsDwG7bOCIRawIyunSv3t9b1QMtUi/khpkDwtiy39qD3/TH/pN9MHzak7xsza9MlNsoRJQqtj2yb9fuSURjLI8VvEDbIUQ0BDEQKI5Pg7vVSPhNFd7Y74MbfPtVk2i8kteIQcy2EZLuGczf412IiotoZnwhHr7OSKO4fUjO7cuaFYiservpwSDIsejrWwCdO6QGmSN98sU5zfFEZEHgkjvqvXAnSNBy68iqOXswP25qtQjmDB0KRig7hMOFSPhs+O9H4/8v5oOqq8bm8dA3JQgTS0MJI20d18bY1r20b/VvwAuEu6YSwr9iZ0OEIcjmzLCacISSSY9RLIfneAx9HKs9I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ols59tiqmvVYwlZcgtyj72cvk5OxEoR2c3TVKLi5XVAge1tKWIwilIIrOfGw?=
 =?us-ascii?Q?RV3zfhSd0WYHpg9yOwZSNO+Fj1pZ8IZyflHut0nm+MIFmCQrmFSryN/5zLfd?=
 =?us-ascii?Q?diSevayRuU15IS0xWdL6y3tX5yX4iQ3olGWHZTg1mYXGqHKX8o3ruztPm7pU?=
 =?us-ascii?Q?8kx+6UsY20hYuXmQaLVEOPS55mTl4ltF7QZ3UN54v3JRsJiDMPk6Z+tMQKti?=
 =?us-ascii?Q?VnZ4225WFBXchfRSOFRXiV0h7AV1crWHUmfCxvGSpUWDnRL/KbSf1uoollJJ?=
 =?us-ascii?Q?JvHU/79O1oZcnlVsq7uUzx48bNueB3EAKvHfEx6SST0MxEoNLoW3IwqTjnQg?=
 =?us-ascii?Q?RHhyVtBZgW2dfIzPWB7obTPVk0oVRurJadnk0Z0wlqJuqttFOa6xpqkq3Voe?=
 =?us-ascii?Q?PiGz3LeRCk3sYFHq0uAp52FIIlazdTdNhRRlUna6eovlNK5IiL6PSeXY7qH6?=
 =?us-ascii?Q?HioBYIf+PsjUrvUH00ZaxLvvEF8bp8jwlHhsAfyQQEfNmdkDHD6+hJNHZyea?=
 =?us-ascii?Q?aZdnMAHm7mI8H87I9YAytbBfyy7jWwXCL6B8bD/bSEoZDj1klTm8KjJf4K9+?=
 =?us-ascii?Q?dSu8T6mogzsl/xTzR+QbN87l0OAkHNa9v/t3QUpWHS5W7tPQoFN43PAeUzoU?=
 =?us-ascii?Q?5kJCBETVe4Pf6mWljbc6GuNe7k99XcEU2f9Hf8/VshyY5iuMGEsTNu8sSYGb?=
 =?us-ascii?Q?/kBJRa6PwWh3HJJKTpnMZVZ+d8jH5VTcjNmejhObsr8iZuSrP3JLlPeKekes?=
 =?us-ascii?Q?42k+4sTxSyVLiT6M0xJDcsc6GCwEZA+H04CxHRSKD5lEhpr7NUR+72BhUgP1?=
 =?us-ascii?Q?7VFPBqmQEDeZdhvX74m6Gc6Fdu5yj/kvZqZlGrRan3ym9hHE/HrgAgZKyWxM?=
 =?us-ascii?Q?8csx+Ykw9ScuydPb2Ib7RhfgYKUnmdcyi8SDLSCkD0tHKUTnssr4Ae/tPMpx?=
 =?us-ascii?Q?ws3fGfzzVtQr70zzNoQrJwInRCaFbVE7CFcLFpKzezYxaed3Dh+Rg1BoVMOL?=
 =?us-ascii?Q?ZTLu7BecMKPA1imNthi4pXazynnGrdAHABRkG+9vBcHSasKR6ItVmieDweAk?=
 =?us-ascii?Q?edjrl5/xi4Gxw7OTjlVgp1mIITxxFzdY3PmWViM3cFHl9MfDiC5EqLithbW9?=
 =?us-ascii?Q?3nIBRLnXRb1o1uKiZnzZceL59xbr8eUmPMAocBNT8f3r4PVHGEP+ciFr12N9?=
 =?us-ascii?Q?YKN6tm963aYik4wIrg7jrhyDNsFCcECCPBOpAKav+h+LUWorY65Mw3YpP3kh?=
 =?us-ascii?Q?1r87CKUEVRys9KrmFgXilYvyLci+pUq6c2fGetaWHmdGcXWpcs15wwm3igp5?=
 =?us-ascii?Q?SYEn4GD91+VUpws1rh8J0GqgFyBdNIFVicllFuATagLVB1JUR4l+eNeeprGV?=
 =?us-ascii?Q?YE5PG4RTLXBwSr67vkt4dYJEBvkvcFrmVnf94w8Ma10/jkOWxenwzWSklTyK?=
 =?us-ascii?Q?Aq3vTS5BG4LuXM4TioN/Zr9tOfcpEjeQK6StfhjqK0TAy+RTnQfp6OalMpUF?=
 =?us-ascii?Q?RycmM3EMjFzTREq4tRE9rlR1ctXCi+0Ka2Blw9VmU/6CmmRvIpdg4bhAwdm5?=
 =?us-ascii?Q?40UAUxeVubXvoTLubI+jt/8EWkMHvtVIqEpR3EoDJPMpyJfqJpW96bhpYTBW?=
 =?us-ascii?Q?A6ZNXZ8aktvPiqE0ZPA139VZTxLBYy6NVm/MXEU3nQ+RFq4m4rh8oc5aZpwV?=
 =?us-ascii?Q?/XIhF17VWPFDLjTaLCn+/JCRPKWRvkUvYZR/yK1rY/HQCD+3vNKycotNSZGb?=
 =?us-ascii?Q?8qbat5XsuIBOvIMB86VOb9y4/cSCJ9E=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6290ad3d-0906-4fd3-ee11-08de954b097c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:24.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gtb4gtvKDHV9uMgb6jpzZHu1/Au+WBvHOHmJOCAjme+MrxqPyJMOhBmPzb+JVzI18Tz39kqs3qT05Ob/ecjq/C0si97oNpW6Az2qFNp83w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276370-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.819];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,starfivetech.com:mid]
X-Rspamd-Queue-Id: CD2043B99F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

JHB100 GMAC still using designware GMAC core like JH7100 and JH7110,
and contains 2 SGMII interfaces, 1 RGMII/RMII interface, 1 RMII
interface. In JH7100/JH7110 dwmac-starfive.c have supported RGMII/RMII
interface. So require to add SGMII support to dwmac-starfive.c for JHB100.

SGMII serdes PHY has been intergrated in JHB100 and do not have driver
setting.

In JHB100 EVB board, SGMII connect with motorcomm YT8531s external PHY
and support RJ45 ethernet port.

The patch base in 7.0-rc5

Minda Chen (5):
  dt-bindings: net: starfive,jh7110-dwmac: Remove JH8100
  dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 support
  dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 sgmii rx clk
  net: stmmac: starfive: Add JHB100 SGMII interface
  net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag

 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 89 +++++++++++++------
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 38 +++++++-
 3 files changed, 98 insertions(+), 30 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.17.1


