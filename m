Return-Path: <netdev+bounces-285162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HQzLeA4/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3532B4E3D28
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050FB301F79E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B1347FEE;
	Thu,  7 May 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ID5LN+a1"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F458346E7D;
	Thu,  7 May 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137291; cv=fail; b=O0SNemGnopc0kAac492/NBlze2MSPC+dR4gk6A2UcDSRhnM7QFj408dNvqcfB1mdi592O7t5YhtRJqQ+M7Vo+kDnroK6aaZjs3ws+uUufIfdJXNTthK3c5VJAdLUnqtN/T2IeY2RHl2JsevpCIWKna+krN0U4TIF9Bmi8A1SwQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137291; c=relaxed/simple;
	bh=XrcV/2BfbipIgfXCHLqu3JKB+jpoCcRkUiUAmps6LYA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IuTdsR5fzWMMZHiYn8qLXDc3SGPhECYq/Jw81FAsO2nnN0CPm8aYKOOgMHZ5ozC7CuGcIVs081klX+87QGq3Zq87DQ8/UrEx/4+sbAf8+dsw/LsJyDBLCguoDuiM9B/lZUW2Qr6Tv3aRJlG3ywYQzsOxQn68UjcG9OWxl7qlXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ID5LN+a1; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkv4ox/eFDZTWmNsmi7k0A6MB0Gk/MLF8uWv+SxNQ2rNAvQCf4NMeO5Pw0tJKsfgNjvK3epvtRxfs83vd0cNqQ7iCGbcweyWTdIwQHdt7/mBauYBe/mIEqJfP9qDaJMBjE6Q4TwGqcjr/ahw3Jw5ePDAk4z07hkDpObCthNdA2NfKBxrpCOm9Jswu1+UQ/kOi4KcAgCU709sEpyf7524CxSzYt2r0yWlooliSvdgMNZ+5rIDbgsjIM5JXz8/cHXFNbiYsE/WqedaOC0NFvzMGQES5t0xAmTzw8ll/IZMC1MSJtOa1tYafw6EKCLjR2x8gjVJXxsdJvPQG8Pcdl2EoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMt4UyhGidILEWKMvsU06pZsvqd/Lvjhy/BWdZJlnkI=;
 b=kOTKIhyR8gQL3HjQneNzbCG+o+SZT8Jq/fM1+pDFRfMKzPlf7ifLYo1jCBunoHjn0V0y7yFbj6pkMjROvyuoFUymByWyGcce8CZKraNGBbidg9+S6RDgSilMejlYwU5PbQDqfZ3Hj/Wi42QWIKFhj2AVrAyzSfGerM6EW9yhH7amPMSuKc5o/ONsjPxNzlrgC0QDFiWReVGOoeStSaXKGnz7dfhDyS+PFB9qZiWOOTXlCh/R4HZnPdwR76kvGPPXkz4n9q5ULuBIRidLl69Wa9R2O4CzPBap3VaQxHMwJLlc9cn+gB5OKAiffDavcY+1mX0OeUUzlvd8ngRgsy9e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMt4UyhGidILEWKMvsU06pZsvqd/Lvjhy/BWdZJlnkI=;
 b=ID5LN+a1KdcROwlJ29tpXkGTdX924Hg2fM1gJZsdVVTyUfYX9buA4A0yDQe6emgXLRW6O1+vrhJJ1TJrUxlntQVNlykhhFQAPare9yVkwt6ULSyXJb69983uc9zE1OLmXxKj1rrkgmDO69XBEOL2LFL7ibafChIP15fN41ioJMmowHaHoE6MQ5O6vVtdPVJaXQ16wFs8My+/2FxoDIL0d2O+zjxJX0dnSSzTsRIM2Bg9dOvYVZfI4cPxsQmlFN/oQ54fpnPY+/lYaAarL2DlWAq81f/IDGPxsmu6ukkHAbFa8gKr9/BPp1cw3a3gKjRl4GkChJIpKIvbVsnd/bODKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN6PR03MB7670.namprd03.prod.outlook.com (2603:10b6:208:4f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 07:01:26 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 07:01:26 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Thu,  7 May 2026 00:01:25 -0700
Message-ID: <20260507070125.11886-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN6PR03MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 9388d1c7-7564-4d9c-65dd-08deac0674e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|55112099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	izDHk2x++AktMbOBmzm8yU5K3ZaItM4CqMWZrawhZxBrlxx5TOT7uBfeYpAJwmQzn2obJZW7zjcX9m1ITPs3MZ5zT3kl8rGPTo1RHEoZS49mMvuy7JfyAiPmZtc6gJRTH9STk+ezL64gpovyzy8zn4JzwOBXeKIzE79N4FYV91NhBTuWLrPIsybqi1KlgiHQMNxUr87QHf+x1AqzBR/HAnR304XEISEwXIoXRbfZOuH+Ov5t4k+goNiU9PgwUh9AvggL3QNMCZdfaG6T5YxQDPfhRH9Iy6qLD8wY/eR3FNdUOw73N4rQRxr45FX4LfZF3gMXmz8/p4UMqAJSZLBSRpkpJxIWnnvw7f57FgH11mY9xdLVHgplcLaKpDrmqoBaXxpd0Hym2x+h4ofgBZl+b7QUN+/DokJcYfJ/3QrftgpLjk73CZnp8gpGx71GhQ6bkIXVCRzLqwV9Qsj188+wKTcjD9uh94UxjJuWS3EKVr0oTCzKcCrtn7mPTuRDGGZ9s3XxYpMLJudjN+CDgvQ7sCzj97MonH6C9dAZiNkRzla4zDvJF/uo/1GeAy1xIuIaR/hYh2cpltNHg9a9m91XzIhYSdHOn1YoZnC0PMrUkSxl0uu599WitIyL3KuAQ8aqTDeb0x2ajbj4iZ9zKbZUURCQKH4rE2+bhvxPWrHmU8DiZgJPINWmh4pLdjMBdFFq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(55112099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AW2hk0fnL8K7lmgN+LgtE8FA9Un6bCgzwAW4++fhtDJewdY9a3WS7OZVKvai?=
 =?us-ascii?Q?eB3hyJR/2DjKnUly9uuTTDCbCpWds3Ngs8T03/iGMKsn9ZrbdRpY0NU6xvwz?=
 =?us-ascii?Q?Gmzl9tEELFYd2wRVMiM3TVe8G2ae5TB60jwt9ghneIVJCGxy+VtbhUc4zhez?=
 =?us-ascii?Q?NoFL9CMIkfyjOezuOPjhJ5zfgt+9TEh830tvjE1CHQFExinXMNjuLveyGogV?=
 =?us-ascii?Q?klI3nrlUCaZXAYv8cwcrz+V+iFueM84p1+V368h7PZNmN//rzR7zVA74NhQ0?=
 =?us-ascii?Q?M97aBaHijKBxNf3PFxNJEPrR4+VSMyzypZKaj64zed+jpYtrsCH4rq4x6rL3?=
 =?us-ascii?Q?6+TnNLwuHLGn/AwxPtNwdu4lElCh+Ulo1WEtIV2ouruUJBQGRIJHpK4c8MQA?=
 =?us-ascii?Q?zfSW0yzwbG3kRqUA8KHJNRFF9T4lBgZYQAQ1UECl7WsjD4i9PcaWlhp+7xXZ?=
 =?us-ascii?Q?9v+tHWH/qWpqxThwvtIVRWuatTlOhd61D+ilfgUkPYQQ/vq1IqKWK/AQHzu7?=
 =?us-ascii?Q?bvdH2z433/Ri95oC+HAZGkae892Kg6ObGjJ3RaRqnpNs7nHws6mnZ8/nJgnE?=
 =?us-ascii?Q?4XS6uqcklxM+myjZ4npFhHNRZiBvr/RcTXYPxPhOtpJ7KE/nPLb+/SBVdNHQ?=
 =?us-ascii?Q?C5QUHQD8sCG78eJsiAy5Vu/JDD6RfAZPdC8kYCq+KdnLsBW8pHs+BNJWseJN?=
 =?us-ascii?Q?Go//YarwkLNZIAwNWIdff8bAxGPmGKyDWg/GhNJtRAjwv2p4K6TevC6eVl48?=
 =?us-ascii?Q?xaZXEa6aRYlubWXrCflvnCo/Pr5CXFj1sgeVBS0EMTAAoUbMbfYz9LTPdrnJ?=
 =?us-ascii?Q?w8Z0QM+HEMSZjtY9nQcqQtDHOu+/Ik+hfWmJwOFCivmg5M5lbuv9SxnCTYxu?=
 =?us-ascii?Q?+r17QfSYix3GsR0M+nKRJMcHMlHZ4Pi/IZIsm7fYOImJjtTh17Aus7KH8qD4?=
 =?us-ascii?Q?bpOjN93QTvTCVEJpazGMlnmPtZQGbuJ67GdmvEUb8VXS91TiqT5XhpvS9xYV?=
 =?us-ascii?Q?PHmYFnma+CYGKgTBlq4K8M9jYQxbC/Fz4yBkzQoCuCN/t6qTpmUy4K6Hrrba?=
 =?us-ascii?Q?oue6E2RSFdenFH9w5joaD0HXJh+2gjsWu7v7bTnl1zWD2GwBjFrfdDnCFVo4?=
 =?us-ascii?Q?B17+AeJgbGLBXSCqy4oxn39LwfFIyJk0QpFXh4u6ATFo5i1Vo35M5iRhvniC?=
 =?us-ascii?Q?j4GcIHEB50/++1LbCkJvhA9ssKLNn41OpYWpCLA+pLICx2J5K5hE+M5nY9Ne?=
 =?us-ascii?Q?bgfvrBw+hG3CrTtlw2rz0UaBHY4uGabkkjd4zxiKB+Wys1WB6CavJXg9r3U8?=
 =?us-ascii?Q?7tlCp4oXccA5BFvBW1UWUuJX018y//CgaoG6gj0QnNBKs06LDXRLi6MKnui/?=
 =?us-ascii?Q?bqXtsg92inTl4CI5A5EcciFzbozk6Uk6gvqFoeAIdp7H5SImuuCbpMYn5P6x?=
 =?us-ascii?Q?HLv83hucrEC9R1zD/qpofCx5876+I072c0A/A504ErNp5ElSXjuK3PllqxBL?=
 =?us-ascii?Q?sqSQiso0S2zi8SleERt6XZLadzNso19SpFfUIEFprO01fxqTQx+2zEIUBvM0?=
 =?us-ascii?Q?1wKgKF82I416DQRvHiVIZAdeJS/Z0zjpBSQBksPG9PC9FCV280WHm+CfYVQ7?=
 =?us-ascii?Q?66VysIdQBxf+G3/T46FTyyMogxRHTQKvm2B0AfOZjP4ggcosU3rFSuXGLtZU?=
 =?us-ascii?Q?AoNghUXdE50OROH1GhTIlOHV6YmiahM/CL24vnB+5V/iwXUAKaVHJKEK5gDI?=
 =?us-ascii?Q?7iOd4cQYwEF7TBfOWzd1n68lasuRynYieypIs25xJVv1gSXpZRcNgq8X3qA6?=
X-MS-Exchange-AntiSpam-MessageData-1: J5YCQLP5RLweHA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9388d1c7-7564-4d9c-65dd-08deac0674e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:01:26.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xf5gDsyWGm/dAoKutPld0tvzUqyOYzDFfhlUJwd6Q9Zjg3c6MExmHHSdvvJkgzt+1KDvLY36gLwtkATwxFqzy5t2ZxycBxrbdF9CtXeds9+IP+qZ+jXbPLt4gk3pcyykxvta3f8olifSIo8wC38zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7670
X-Rspamd-Queue-Id: 3532B4E3D28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285162-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

commit 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for
multi-MSI") introduced INTM=1 interrupt mode for platforms using MSI.

Apply a similar approach to enable per-channel interrupts using shared
peripheral interrupt (SPI), so that only per-channel TX and RX
interrupts (TI/RI) are handled by the TX/RX ISR without invoking the
common interrupt ISR.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
- Rebased and reposted on the net-next tree.

Changes in v2:
- Rename macros to use XGMAC_ prefix to match dwxgmac2.h convention.
- Drop DMA_MODE_INTM_SHIFT and use FIELD_PREP() instead.
- Wire up multi_irq_en via STMMAC_FLAG_MULTI_IRQ_EN in stmmac_main.c
  so the feature is reachable by platform drivers.
- Drop unused plat_stmmacenet_data fields (ext_snapshot_num,
  int_snapshot_en, ext_snapshot_en, multi_msi_en, multi_irq_en)
  which duplicate existing flags bits.
- Remove misleading commit message paragraph about ISR decoupling
  (dwxgmac2_dma_interrupt() already handles TI/RI independently of NIS).

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 9 +++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 2 ++
 include/linux/stmmac.h                             | 2 ++
 4 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..544541e0e2a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
+#define XGMAC_DMA_MODE_INTM_MODE1	0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..59fe488933d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
@@ -31,6 +32,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->multi_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~XGMAC_DMA_MODE_INTM_MASK;
+		value |= FIELD_PREP(XGMAC_DMA_MODE_INTM_MASK,
+				    XGMAC_DMA_MODE_INTM_MODE1);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..531f9d7bf2b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7836,6 +7836,8 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->dev->base_addr = (unsigned long)res->addr;
 	priv->plat->dma_cfg->multi_msi_en =
 		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
+	priv->plat->dma_cfg->multi_irq_en =
+		(priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..cdb983e49856 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -122,6 +122,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	/* multi_msi_en: stmmac core internal */
 	bool multi_msi_en;
+	bool multi_irq_en;
 	/* atds: stmmac core internal */
 	bool atds;
 };
@@ -211,6 +212,7 @@ enum dwmac_core_type {
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(14)
 #define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD	BIT(15)
 #define STMMAC_FLAG_SERDES_SUPPORTS_2500M	BIT(16)
+#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(17)
 
 struct mac_device_info;
 
-- 
2.43.7


