Return-Path: <netdev+bounces-285657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAf0J2h6/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:53:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DC4F2227
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DB143038A6A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D637FF49;
	Fri,  8 May 2026 05:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADD37996C;
	Fri,  8 May 2026 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218753; cv=fail; b=YgWeDNuYq51mNDpRAhQ+jiiuzqaUhbur0mUOsXgF00qxWd6Tqaj/s72z+jUvZS7Uo9ZQ/veopCFtmr1dolGXGh0d60VqvpFMtmNLWoS+7ilSsODGeHbZxuhOb+9nd9/I6CHCC/KR5d9e52Q4cKkjIEBFeD4CWS3Bfm0V4gNQnN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218753; c=relaxed/simple;
	bh=Lz8/OXggjAxegZ01OOBHT7eXE1ccR9/HVnPitlOgrWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbhdQn2UTS6ZIkvtGO63RpuWbuGnUxZptuRRKjghTO0VUJMUOcXxZOz16GmAeT1omlV5pX4Yq5+XRRMdqyG4T6nv7wWCHMCgzCCx6x2NYM5qzf08Uv0DZKDipgMMesImatiPiH2bwU+lWrDFYmdcUqxbEK+RldCh8N+qsqOkiV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcL7Bs9eOYefNHQtYzGZJ0jjziYPiKv7bklAC/C46KE+wC6woN43D+Xq4fJcL0j94NvQzBDCRnf0vCuztNRwXAB3a1g75xG1LZGjrL0fnJgqtJO63+dCHYer11Qy5s/qvWKKcPdwxp7RVRHf48yNpgNiR8aqpYGeffDOwLIM+t3Nsq7jNO24crNEEDH98QXcf9zkx3/Rfe6uiiIua+5GKr1Qx/Zu6BZtacA6PUQWSrg/7T24LAD32yQ2sOu3hc4DWh037LksWwP45PZY25LxwcdHYueO3nlv2ax9fsuGplCVpcwOAGjzWZ7dClWfKN7UHv74bBXY0uG8ZX2us1qP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoTb3IZeWbwhXr9g18+PsLvVlXvaB/UwBAZFZAHvzIk=;
 b=YHa6tHqhCslJ2XNTZvO6+py4oDW9lFCwNvUofOtJ0zM6Y2LmeZbWf13X7O1FydaSXBKj0RN4lNMrUJHO6ZWRpLgLfoiWxXmkoeAqkpMlhduLXPXVXTeAUpvGuUfuyBHPhfzu99ShtIZuKqKtI8GnvbgVzhwVxWJcZz8yPzgu+ALO5HQKdn0d2R41UMEY9FdlnOdKyv/18qAc7Cio6o8XSKXFFD6p6eKwD9hkYl5bNJSe7Bu9m4RAxsBNUSB++keWN2dhTkQz56iwjgl3BQqxFHf8GFlkmANgSFYPRsngR6B9SGhDOFwpwjK3zMuoGnvrKplTP8DyzcYkFlJoGkppoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 05:37:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:37:04 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 13/22] clk: starfive: Expand the storage of clock parent index
Date: Thu,  7 May 2026 22:36:23 -0700
Message-Id: <20260508053632.818548-14-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: e094c72b-3e83-4603-5fd6-08deacc3d5f5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|56012099003|38350700014|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eH5Bq3Sf5Ye6OuU+ovM/hTvleaeS/UBau+wde8EBkAl0552cmB9zGUYp9MAfpFtmRiiB9oA0Qx1cWXBAHpkdndUwzCRhD++Z4YJ6fEFT27qkUYCbZAWPApYbCae4/nMux+laGY0FyJ3aFTdyVdR/mDDtDJj6IrQYiJaVHZRfvKTTdkruG2VRpfNLQoAb/TxplJuTQKEGv4/BblClXxII//AI2NrzsAbJ3W0gCBzpO1UZVaZW8mqPwCijQvU4SPcGOC1HTD7g6JReDFDLsfBB+7HFHPoLKjnufS+y7UN9bKPp3saSwHG+zZIuNUncdhqVXOrj4/OjWyEe0GzEvFCrM1VSOO6T/Hj/Zvvr+8Q5pjK5owwW9PzdW+hFRKBN+l9W+HUU1ijBLJ3tc5LEOTq+a0uClpdqVORkcMa5RIBSSzWg1FNMUCDHe7m3E4pHEExvbDXaF2wS4+/o8aqSXT/afmbWsesvdRWZ7qxNTgcjm/f8DpXahHECMYuvtdDIndkASyIm3qa9xM+pssgL2q/w/mK5tM0n5LqH/2J9ZF51twZZna3w6OEh2s8TnLQxpTQT5tEjWSTEtIdtQAXFc64juw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(56012099003)(38350700014)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWbo+S7dcJFhBsvsEjv04bN6cSJhnhoLnBaQ9fVMtz3rLYfwEU44PHrXu6Ej?=
 =?us-ascii?Q?KNd6P7pIcYHqhzKY1lvdm8ttlrw0WmSusfR1nnlnmXzN0j/UlIFnJJzzqIzl?=
 =?us-ascii?Q?MTAYcKBpX5plQz8UPX0heu3Gg7zihSZt9qc2Mey0BboGgWmvo4gqjwZ2AIrW?=
 =?us-ascii?Q?qzodgz8HzUxAptuxd+jAxay9KY2pUvJQ5I1TtSPxo9wA3FaU7PKhEit0fPYj?=
 =?us-ascii?Q?u1tpTjEkYvPeGgztivHohPYnTctXzLWd4dL/F8yXtVkdXDUZOivZRsx/71LB?=
 =?us-ascii?Q?5riFYU4WjCv+S1aiin1uKc/qU9Pmj1QWv/eyWoeKx0HeCAdBgbZzfhHz5ZGG?=
 =?us-ascii?Q?c5VmPrbddCrFPBlxILGAMf8jKuEJJV4ZVntl7I6Z0MughGjiXQuWoficIid9?=
 =?us-ascii?Q?fRT1VtIykEb+pJcnzyt80kwiSQ3UWqZ8lP4obMUZ1zlEvBPTXP8rANajj/ga?=
 =?us-ascii?Q?jbJC0CMWO6sR3XhGz1gfbTYoq0muM1E6YKQFA9KxoKKkJgo31Wpb7IhiEcJ6?=
 =?us-ascii?Q?U5blkIZw8b6EQlA+IDjGJflf55h+eXalQZc+8CA692RwFGCXgCRSIU1ecBta?=
 =?us-ascii?Q?a71gWMifhsbeylv8qdotZEPmUkOoshczHMZXp61VbbLfZsw2jc0M7E5aLHJr?=
 =?us-ascii?Q?clmzuzuCBXuy42VZuVE3ZUrmbsHbvHJBcsfr99PVSjXOA8sz2FpZsrEMcn8r?=
 =?us-ascii?Q?G3SyNYFukeQyJFuzFkof6weNFXx9hXGhRyxShrsdBiJTgZN/kkAPrG06Tatt?=
 =?us-ascii?Q?TeCDnp8OA8ZqKWQAAOlClcjCFuTsJFlV5YkwkV3R+UIMlr5vs2jm2ca4O7Df?=
 =?us-ascii?Q?+m321HhY+T/3JrNkHknr6ey/cj8zm2qI26pAmg1GESYEsr+cdZXoPNnyINTn?=
 =?us-ascii?Q?xqSe69wEHD/IrHLlMyiZjofGWZ/ViGcZdOwbVWEDFKFpMMlWxMzc2ohuDB7T?=
 =?us-ascii?Q?q+oLD8YO0lfVqCH3JP4SuNQRxAAtXhHdQjjSZRv9uKcJHy/oMiZBcK4Axe8y?=
 =?us-ascii?Q?UgxVWNiIcA25VLVc9YGPf1MqMIJzJuyck3BJIc9Lxpxu23XBcP6fXb2fxpza?=
 =?us-ascii?Q?f0PsRjmGHeA+pZ7oSjNvimi0D0lnMcuYeasvajCNZFyzbmAqXSx6IzHD4Lc5?=
 =?us-ascii?Q?sel69rYkA8I/wTI2ln9/tIFHVfzO9KUDyw/jz79oVUdaYu0hTW/Vx3Xt6vey?=
 =?us-ascii?Q?fuG0j1bjl2noRDaRJLqRlaCF9OxJfTup9s/+Ee7RimA6Yh1oNI1svsECsEOB?=
 =?us-ascii?Q?VDBAap9ZdOI8EhfIyNerZLOZ9F/H9w1Q5mhucy6z3EY6VZJaaZnwrH9J3w9H?=
 =?us-ascii?Q?FNWWsIfY9mTrfZXCpFIDZ7DOwO9LM+otuwg61inevh+ac+l0lkCSp5Pt6B0+?=
 =?us-ascii?Q?uRHj/glhEWXYcVKbg9gOKNlZx9wk6HJu67XPBUfaffSXoVQyFIsDjNJY/1Ex?=
 =?us-ascii?Q?0W5BOMXk7DQQxJOClkoN5jX7IS5idGHeg0Sz2Kyg9wDsOBXdwTk5DIRhr1mM?=
 =?us-ascii?Q?0E6XHlkXb/yrE9/OiuBHbJNKlctzpRWt1+Qmyf7H8wAcvwS2F9TzSS84T2aT?=
 =?us-ascii?Q?dwMLWeaYwU1vCECdRvINNBBkBNCzhMZQura7c9FdQQ7Mc+9MKbCEUMAyETK+?=
 =?us-ascii?Q?MZsw6OmUrVnSg0m0c7+298ATlN/KbSIDOTvmV4EJxnW19/pBiq6+RNO57MAL?=
 =?us-ascii?Q?G+PsJWqYXu+Wc/m5Bxntymkiru9G4ImGM9LunXtSJ5qhHmuQ7fxMla40jUq7?=
 =?us-ascii?Q?YR3d6bsoJ44RqtCIA75JDwIWMXsVME6Sugh5heJbbTqQg0l+FAk1?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e094c72b-3e83-4603-5fd6-08deacc3d5f5
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:37:04.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViGsuc4dsTnqbRgH03J3osg7hVbZjHstWyX9+lKqFT0EGxcBFaWm2t6PQhXnq0vrAdzSvIs8lztYMKwmyCmAOIZsoWkgsJN+zGT2Vbq4EmvGQn6mTdRLUdoxBZYZ10eT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267
X-Rspamd-Queue-Id: 4B2DC4F2227
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285657-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.679];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Action: no action

Expand the storage of clock parent index for per0 domain, which parent
index over 255. So change u8 to u16.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-common.h b/drivers/clk/starfive/clk-starfive-common.h
index 05352dbb6b87..51afa7405c6b 100644
--- a/drivers/clk/starfive/clk-starfive-common.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -27,7 +27,7 @@ struct starfive_clk_data {
 	const char *name;
 	unsigned long flags;
 	u32 max;
-	u8 parents[4];
+	u16 parents[4];
 };
 
 #define STARFIVE_GATE(_idx, _name, _flags, _parent)				\
-- 
2.25.1


