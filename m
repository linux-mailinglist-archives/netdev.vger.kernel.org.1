Return-Path: <netdev+bounces-280349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDi1KG2K6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2B4439B4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD453059CF7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656703C060B;
	Wed, 22 Apr 2026 08:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748563BF685;
	Wed, 22 Apr 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846804; cv=fail; b=COJSyyBJ9hFbtdndHToV/5ckN4C0a343bCqsm3oSfQ0yPXWjtX7z9rj7qU9zz2h0zK4z1dz2S2RP4yt5Xi7UkPeJ8phpUcbC++3pXSscaX++mfnY2CJzQznRUtL64haOeJeYx7nDdspXIo6yRXmnNeMkpXl9JjPq2uetLt+CWQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846804; c=relaxed/simple;
	bh=9lI7o5MGFZJ8J8e1lE2qpukZv16n+ZxeUlPF62crf68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Eua+jSznByFSqxtyKYvkMVYHs0v42NiBXJ5V1hJXjHf33DzWKvbfKY1H6cN0Vumb5SQ1MbuDvmyvbd0iAPaUrQmm9J5U8hmbBqbpPwYQGfuoT7X60+bkfTqtBpzqEtfOstR6Vb+pzFJiYz0tD5wLityGYtSQnB6VrUhTPjfVsLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MztOlqRjRO9XehhuIFgrVH6KMevR7Qbg1fMAKqWir3DuiPQFUIAOXXQj1XS9pw4X7jy2NLmgwJCvxPTgzCvpb1XCw8t5JsorsSxgJ3KZtqTLLg/e1MpMq8klZ+0mWfT1B5ayKE0HyWt5W/itlqrsZdNPtbdlMKd7fzqmJa+hZD5+y36wxQfM3VZZY8bM3JXeZHIV3DWqhK62onhyBcqarofwE1N3HRYIf0LCKYzhZPxh31Y3QWUTt+SR33HGBIn9l34Kll0SW/um2A+X9JMnt+6ovoxVv+ttLRZTlvTONZZpLn8ZF9fU0r4qGAHFBWIMiVunuo36FKXz3m/ddrJBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMrtloXn4ft/mF0crdIIxZZ4tjlhw8Oy7ZR8ZphrgGE=;
 b=aV7I1RIk4/DtTW1AhlvaiPLPhGFfPfsrKznbZb/lHwJ3Yc1FPWP7C1nfNU0mQpiFp1//TkKSDNnHo5yR+49EIBbIrEfP0E5hCIabtwg91yluMx0fF2g5nHbZ9d4rVjrsN3tdhzDR57MvbFcmDtsG8tJK6rHwLEcT5FOrxKrd6Gba3C67Ok+QtHWM7r+pwM/kjjBPQjLvBmvDM4GchUHM/KZl5i8/I5vB+eFCspffsWkmXq6ATl6Pdacqm8ePfvd2uvRyIIleaoaMwzcGh0D7VYDMjKu24BF4898GQwJ/TBsq1n90bAivrg6Tu+J90dJhbbDyCHZ8H3s2dHkC6x8F3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18) by SH0PR01MB0554.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 22 Apr
 2026 08:33:04 +0000
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 ([fe80::8f25:1579:34a0:8569]) by
 SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn ([fe80::8f25:1579:34a0:8569%5])
 with mapi id 15.20.9769.046; Wed, 22 Apr 2026 08:33:04 +0000
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
Subject: [net-next v2 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Wed, 22 Apr 2026 16:32:52 +0800
Message-Id: <20260422083255.29692-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::18) To SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0858:EE_|SH0PR01MB0554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7731946a-3f1c-4577-0c43-08dea049c5b9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Q7UIEd8yKBHdEhdb/T7imzmP3rxleprMb6oOl/fLg/4qUv3FwLOMuZlaPP0PKdco9tezdqS/WVZ2yjTHwzDYlLjTO1sjRnShK5MHyYQsOIVSrlj0gCR/7oyVWAcNNuMfwEJFCayd5Nu51ov/ZvRP2qYTdRyBTolSGrYl+llE5OO+Nt3V/C1UhDz68n5E/s1TrD4lKb0i/eVXrC43ljNlyp8LzIby/6RPZCwmksBJaim+BZYpH1Sk8vhtcOnXbVBikA1/kTUPKCJlTuF+fF4pcSloCP0EGWP0Jz6FuVYf62k1zP9GqoESetS/BliTH4KNEELODao6T6ygX8BEHi08tNNfGGXriju7yaYlev2q9++16QXcC+f15hbYzZ8cxVZFNmOXUdFFB9Ztw4VAOavTDCmR0Wpfhs97ozShSfbpnFery0rrlFC/cCbOrpjXHPO3dO17EyHT7dMWbKl8QtKVfra+ibITyR3T+TSo95Aie1DUZWrtznIk6PTnYxDG5ahLMDZ0sVpEfL0SWZO5hs+8ARkyK9xFV38hFGssBj6z74FOwOMxVSurTaAfx9AkJdHGG4S0t72QV+F3aqZ3cNEDPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MyyPuvfzB9ANonaiGWA3pjZwOKx5slgFAB63KXzMrfS5zPkc5JnkAHw6OeXC?=
 =?us-ascii?Q?0f55HN/iRCvRO27vlzeDmyQI5e+AWP8R3HgI/nUdw+urEZQy5flpCeDdp4M5?=
 =?us-ascii?Q?eSpi4F8lEiS+YFreJYxUB8qDKRZH5MNv1TjRaKfT6yyicLhpSdPdCbsT7S/j?=
 =?us-ascii?Q?ASoEsz4j3eWDAkz1MSnDyUQlNgCQefc0/tME1WIMHOXhlTGI4XyKy7bsof5w?=
 =?us-ascii?Q?lH0G0PwF1tNv1wqOQnjBSb9CQvkfUqvG1xKCtPhUq7Xb64rA1BdE4w4Da7WT?=
 =?us-ascii?Q?JJQfuKHNNsPloMwz0XPuWHvW2TERpLX2fZ5rzVQELooorxONeEO5gxr2d6/V?=
 =?us-ascii?Q?XViVMGOnCByWalymjCuG5M7VLIX4zq7NTMPYODrzWHDk/4xRHVUyRzzrJhSE?=
 =?us-ascii?Q?UXWjKT/sKbwzJmcMknh/lzCcbqssHbLSTHyAbPG5sLT8gmlq2yF3Obdwr8Ff?=
 =?us-ascii?Q?79D0Jj4ETJ+wXgwQrO9J/4mh3yHUShY/U3VvnZNDHsWnQA9RAuPrzp9yKEDE?=
 =?us-ascii?Q?fciJ1PqKc9ZXhbzWWO6TSiu6m8t4F3yljjTCkQ0YIV2NGaHhu/Y3GmE0+s49?=
 =?us-ascii?Q?rXCv6ZrYJQPL0FOyXj90gjUpS33797FaQ8GMkp0T5swNHdTGYqCH9FSzD7+x?=
 =?us-ascii?Q?q+QJOPGtmSRYclK3UT+bAc6Dg/DHVpWxB5Fx6A2nGBQ//WEWczR6Lao1UdSJ?=
 =?us-ascii?Q?FlhJ4bcp/lCKdTWYfx9roAhvXcUFM3M12OmSPR9z8kdFN743dMSJcKZiPiBi?=
 =?us-ascii?Q?/fPTto5JGpXkCRS9zFVqg8JBu7nJ3Ee7o2E4G3wHA3LK9hP3ihXpd9O18iVP?=
 =?us-ascii?Q?mnMRE1GNsHpd2N3vk9fVOh+f30aAAyTWAi961++WAUZzKNlmlK30mdOsNlYZ?=
 =?us-ascii?Q?nU5WaDumr55FOBSA/9JOprvQ+etfe9uRFJJrBd0NK5mKi+Qpv7ogIUvFkIVn?=
 =?us-ascii?Q?hIS5WzOCQ/14kBZ90zETYLhLpUoNwjc7YzqsAuHVUK4WeywnlT/pvbPmIQf2?=
 =?us-ascii?Q?RY99+XhycvDcoqUdMmRSslqPszREyqQC5ADeUV3fvxeqYmElp8ee7Pp7gozo?=
 =?us-ascii?Q?KJ0QAXEElRYqXR7IZD6mZqVk5hPIpoQdRZ7sK1CaVZ7d7Iki+evk4u6LZg4o?=
 =?us-ascii?Q?ICB1ODfmphXsdLoHWhV5+nvQenjWnazYPsm0sYK02kj4LL0U0u9VVwKPpBN7?=
 =?us-ascii?Q?IN+vqe+Hp6Sjir/RxL8hiCGXwpqkrmOnlqL8rqC5WuvPdIzDLB08go3XXYlH?=
 =?us-ascii?Q?g03ZIr8ijQVGd5WzlCGpKxd8ntAdVNXRvqmnM/bmZh4S1MtlGK122MstUMy9?=
 =?us-ascii?Q?dpCTOk3VeZkcw7LerI02Jy0dqkHnDknVFQFIYNRlY3rQzg72+BGiW0ChWPcA?=
 =?us-ascii?Q?DdbI103nhITlP3PdA3p61o08Vm2w4YAq7IK7Gdo39i7uydzSCCqom6GMtAps?=
 =?us-ascii?Q?Z1O2QitQf8vN80oSUEB9t4oWFT+ndg15xmZjTj5mnnSgavDg4D+XQT/1h7im?=
 =?us-ascii?Q?XXwQr1Ju2tK9uHN7yxscO7HtGMzirxE5jlddkrKaSt7Jd8Tm0auYTelQNsSv?=
 =?us-ascii?Q?gDUvBe10nicGJcc9EgRgmRYrhTz7jXRQNjtLd2R7g93zL6kld534uTr3LRdb?=
 =?us-ascii?Q?cakeLsEIBqNXxPYgUtyWD+qPvjGBmnxGbqNqSytBJjFTjx624fumAEHMwvEV?=
 =?us-ascii?Q?HUwNLsLkgoZvkWlPM9T3A+LzMT02BtRUOocr0OfcI4Ac3ejyUsJ1ycGaqVLJ?=
 =?us-ascii?Q?7DAeKA1+Us0zl1dKEBJ6mIOrQjP9DFA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7731946a-3f1c-4577-0c43-08dea049c5b9
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:33:04.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybZkXr2XAg24tpDaXjm/fYlNq/ZCTGbVUpewjuySEoPg115vAIlHVnAz/xvBJfdyBTieioNsWdh0YYZembIf+xthco7xzlRYvqJRWcJXnT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0554
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-280349-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:mid]
X-Rspamd-Queue-Id: ECD2B4439B4
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

The change list:
v2:
1. patch1 move mdio lock out from  yt8531_set_ds().
2. patch2 changed to phy_interface_is_rgmii().

Minda Chen (3):
  net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
  net: motorcomm: phy: set drive strength in 8531s RGMII case
  net: phy: motorcomm: Add YT8522 100M RMII PHY support

 drivers/net/phy/motorcomm.c | 77 ++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.17.1


