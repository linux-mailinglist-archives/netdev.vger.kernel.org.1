Return-Path: <netdev+bounces-296125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xr8JMz5nJGoN6AEAu9opvQ
	(envelope-from <netdev+bounces-296125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB9364E063
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:30:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296125-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296125-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E4D0300861F
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247333B27E7;
	Sat,  6 Jun 2026 18:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20749F507
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:21:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770069; cv=none; b=d3AU+bdyZVo9TYEnvLWbjIRUktFHk+dU7ickO+CHcBZWiVZSx0wymLrM5855sqcfgXj2eB7+JSx3D7zRWPlENCq/ly/OOFc2WgqEj0kzH1PfLe68owN4q7SMdcR4IVViU14f8H809vBgtejdGvXPDgye9sT8C3xAbo8XUM4mdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770069; c=relaxed/simple;
	bh=nq0yqfi6qj8jVojGJYBVIoKVkd6fLKeJ0uLcrbe2ngU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6yx5VMGnWpAcWyw/Nbgw/ST/7Og4kYzv/D6KChb+OYiVdSwV3izAmXRORANib8ZhcblDn6o6hssl38EU5rSOJydTBM3uyXPUCWgBsnry9PBopXx36YM1QFhK1SAGlydbhFCwGxCk6gc3L7ywEgt8U9ttddLJwIwINMGuUN6LRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGF029679;
	Sat, 6 Jun 2026 11:20:52 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 05/10] cxgb4: Add T7 indirect regs and update library
Date: Sat,  6 Jun 2026 23:52:15 -0400
Message-Id: <20260607035220.528439-6-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.04 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296125-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BB9364E063
X-Spam: Yes

Add the T7 indirect register tables and update the cudbg core
collection library to handle T7 diagnostic dumps.

Introduce a per-chip indirect register tracking framework across
cudbg_indir_reg.h and cudbg_indir_reg_t7.h. This adds static address
mapping tables for nine distinct T7 subsystem spaces—including CIM_CTL,
PM_RX/TX, TP_PIO, and MA_LOCAL_DEBUG.

Update cudbg_lib.c, cudbg_lib.h, and cxgb4_cudbg.c to process these new
hardware targets during debugging routines:
 - Integrate the scratch buffer subsystem into the CIM IBQ, OBQ, and
   QCFG collectors to cleanly generate versioned structures.
 - Expand queue ID routing configurations via versioned checks to handle
   T7's additional pathways, enabling 16 new debug entities tracking
   internal TP and IPC data paths.
 - Update indirect dump engines (TP, PM, MA, HMA, and uP) to read from
   the new structural register dispatch tables.
 - Widen memory offsets to u64, update window access tracking, and scale
   the TCAM engine to accommodate the T7 3-TCAM hardware layout.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../ethernet/chelsio/cxgb4/cudbg_indir_reg.h  |   43 +
 .../chelsio/cxgb4/cudbg_indir_reg_t7.h        | 1113 +++++++++++++++++
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    |  902 +++++++++++--
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.h    |   50 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   16 +
 5 files changed, 2029 insertions(+), 95 deletions(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
new file mode 100644
index 000000000000..a33e003c78d5
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ */
+
+#ifndef __CUDBG_INDIR_REG_H__
+#define __CUDBG_INDIR_REG_H__
+
+enum cudbg_indir_type {
+	CUDBG_INDIR_TYPE_CIM_CTL,
+	CUDBG_INDIR_TYPE_PM_RX_DBG_CTRL,
+	CUDBG_INDIR_TYPE_PM_TX_DBG_CTRL,
+	CUDBG_INDIR_TYPE_TP_MIB_INDEX,
+	CUDBG_INDIR_TYPE_TP_PIO_ADDR,
+	CUDBG_INDIR_TYPE_TP_TM_PIO_ADDR,
+	CUDBG_INDIR_TYPE_UP,
+	CUDBG_INDIR_TYPE_HMAT6_LOCAL_DEBUG_CFG,
+	CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_CFG,
+	CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_PERF_CFG,
+	CUDBG_INDIR_TYPE_MAX, /* New members need to be added at end */
+};
+
+struct cudbg_indir_reg {
+	u32 addr;
+};
+
+struct cudbg_indir_type_entry {
+	struct cudbg_indir_reg *reg_arr;
+	u32 nentries;
+};
+
+#include "cudbg_indir_reg_t7.h"
+
+static inline struct cudbg_indir_type_entry *
+cudbg_get_indir_reg_info(u32 chip_ver, enum cudbg_indir_type type)
+{
+	if (chip_ver >= CHELSIO_T7)
+		return &t7_indir_type_arr[type];
+
+	return NULL;
+}
+
+#endif /* __CUDBG_INDIR_REG_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h
new file mode 100644
index 000000000000..a246009ffb8d
--- /dev/null
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h
@@ -0,0 +1,1113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2026 Chelsio Communications.  All rights reserved.
+ */
+
+#ifndef __CUDBG_INDIR_REG_T7_H__
+#define __CUDBG_INDIR_REG_T7_H__
+
+static struct cudbg_indir_reg t7_cim_ctl[82] = {
+	{ .addr = 0x2000 },
+	{ .addr = 0x2040 },
+	{ .addr = 0x2044 },
+	{ .addr = 0x2050 },
+	{ .addr = 0x2054 },
+	{ .addr = 0x2060 },
+	{ .addr = 0x2064 },
+	{ .addr = 0x2068 },
+	{ .addr = 0x206c },
+	{ .addr = 0x2094 },
+	{ .addr = 0x2098 },
+	{ .addr = 0x209c },
+	{ .addr = 0x20a0 },
+	{ .addr = 0x20a4 },
+	{ .addr = 0x20a8 },
+	{ .addr = 0x20ac },
+	{ .addr = 0x20b0 },
+	{ .addr = 0x20b4 },
+	{ .addr = 0x20b8 },
+	{ .addr = 0x20bc },
+	{ .addr = 0x20c0 },
+	{ .addr = 0x20c4 },
+	{ .addr = 0x20c8 },
+	{ .addr = 0x20cc },
+	{ .addr = 0x20d0 },
+	{ .addr = 0x20e0 },
+	{ .addr = 0x20e4 },
+	{ .addr = 0x20e8 },
+	{ .addr = 0x20ec },
+	{ .addr = 0x20f0 },
+	{ .addr = 0x20f4 },
+	{ .addr = 0x20f8 },
+	{ .addr = 0x20fc },
+	{ .addr = 0x2500 },
+	{ .addr = 0x2504 },
+	{ .addr = 0x2508 },
+	{ .addr = 0x250c },
+	{ .addr = 0x2510 },
+	{ .addr = 0x2514 },
+	{ .addr = 0x2518 },
+	{ .addr = 0x251c },
+	{ .addr = 0x2520 },
+	{ .addr = 0x2524 },
+	{ .addr = 0x2528 },
+	{ .addr = 0x252c },
+	{ .addr = 0x2530 },
+	{ .addr = 0x2534 },
+	{ .addr = 0x2538 },
+	{ .addr = 0x253c },
+	{ .addr = 0x2540 },
+	{ .addr = 0x2600 },
+	{ .addr = 0x2604 },
+	{ .addr = 0x2608 },
+	{ .addr = 0x260c },
+	{ .addr = 0x2610 },
+	{ .addr = 0x2614 },
+	{ .addr = 0x2618 },
+	{ .addr = 0x261c },
+	{ .addr = 0x2620 },
+	{ .addr = 0x2624 },
+	{ .addr = 0x2628 },
+	{ .addr = 0x262c },
+	{ .addr = 0x2630 },
+	{ .addr = 0x2634 },
+	{ .addr = 0x2638 },
+	{ .addr = 0x263c },
+	{ .addr = 0x2640 },
+	{ .addr = 0x26fc },
+	{ .addr = 0x2700 },
+	{ .addr = 0x2704 },
+	{ .addr = 0x2708 },
+	{ .addr = 0x270c },
+	{ .addr = 0x2710 },
+	{ .addr = 0x2714 },
+	{ .addr = 0x2718 },
+	{ .addr = 0x271c },
+	{ .addr = 0x2720 },
+	{ .addr = 0x2724 },
+	{ .addr = 0x2728 },
+	{ .addr = 0x2780 },
+	{ .addr = 0x2784 },
+	{ .addr = 0x2788 },
+};
+
+static struct cudbg_indir_reg t7_hmat6_local_debug_cfg[32] = {
+	{ .addr = 0xa000 },
+	{ .addr = 0xa001 },
+	{ .addr = 0xa002 },
+	{ .addr = 0xa003 },
+	{ .addr = 0xa004 },
+	{ .addr = 0xa005 },
+	{ .addr = 0xa006 },
+	{ .addr = 0xa007 },
+	{ .addr = 0xa008 },
+	{ .addr = 0xa009 },
+	{ .addr = 0xa00a },
+	{ .addr = 0xa00b },
+	{ .addr = 0xa00c },
+	{ .addr = 0xa00d },
+	{ .addr = 0xa00e },
+	{ .addr = 0xa00f },
+	{ .addr = 0xa010 },
+	{ .addr = 0xa011 },
+	{ .addr = 0xa012 },
+	{ .addr = 0xa013 },
+	{ .addr = 0xa014 },
+	{ .addr = 0xa015 },
+	{ .addr = 0xa016 },
+	{ .addr = 0xa017 },
+	{ .addr = 0xa018 },
+	{ .addr = 0xa019 },
+	{ .addr = 0xa01a },
+	{ .addr = 0xa01b },
+	{ .addr = 0xa01c },
+	{ .addr = 0xa01d },
+	{ .addr = 0xa01e },
+	{ .addr = 0xa01f },
+};
+
+static struct cudbg_indir_reg t7_ma_local_debug_cfg[238] = {
+	{ .addr = 0xa000 },
+	{ .addr = 0xa001 },
+	{ .addr = 0xa002 },
+	{ .addr = 0xa003 },
+	{ .addr = 0xa004 },
+	{ .addr = 0xa005 },
+	{ .addr = 0xa006 },
+	{ .addr = 0xa007 },
+	{ .addr = 0xa008 },
+	{ .addr = 0xa009 },
+	{ .addr = 0xa00a },
+	{ .addr = 0xa00b },
+	{ .addr = 0xa00c },
+	{ .addr = 0xa00d },
+	{ .addr = 0xa00e },
+	{ .addr = 0xa00f },
+	{ .addr = 0xa010 },
+	{ .addr = 0xa011 },
+	{ .addr = 0xa012 },
+	{ .addr = 0xa013 },
+	{ .addr = 0xa014 },
+	{ .addr = 0xa015 },
+	{ .addr = 0xa016 },
+	{ .addr = 0xa400 },
+	{ .addr = 0xa401 },
+	{ .addr = 0xa402 },
+	{ .addr = 0xa403 },
+	{ .addr = 0xa404 },
+	{ .addr = 0xa405 },
+	{ .addr = 0xa406 },
+	{ .addr = 0xa407 },
+	{ .addr = 0xa408 },
+	{ .addr = 0xa409 },
+	{ .addr = 0xa40a },
+	{ .addr = 0xa40b },
+	{ .addr = 0xa40c },
+	{ .addr = 0xa40d },
+	{ .addr = 0xa40e },
+	{ .addr = 0xa40f },
+	{ .addr = 0xa410 },
+	{ .addr = 0xa412 },
+	{ .addr = 0xa413 },
+	{ .addr = 0xa414 },
+	{ .addr = 0xa415 },
+	{ .addr = 0xa416 },
+	{ .addr = 0xa417 },
+	{ .addr = 0xa418 },
+	{ .addr = 0xa419 },
+	{ .addr = 0xa41a },
+	{ .addr = 0xa41b },
+	{ .addr = 0xa41c },
+	{ .addr = 0xa41d },
+	{ .addr = 0xa41e },
+	{ .addr = 0xa800 },
+	{ .addr = 0xa801 },
+	{ .addr = 0xa802 },
+	{ .addr = 0xa803 },
+	{ .addr = 0xa804 },
+	{ .addr = 0xa805 },
+	{ .addr = 0xa806 },
+	{ .addr = 0xa807 },
+	{ .addr = 0xa808 },
+	{ .addr = 0xa809 },
+	{ .addr = 0xa80a },
+	{ .addr = 0xa80b },
+	{ .addr = 0xa80c },
+	{ .addr = 0xa80d },
+	{ .addr = 0xa80e },
+	{ .addr = 0xa80f },
+	{ .addr = 0xa810 },
+	{ .addr = 0xa811 },
+	{ .addr = 0xa812 },
+	{ .addr = 0xa813 },
+	{ .addr = 0xac00 },
+	{ .addr = 0xac01 },
+	{ .addr = 0xac02 },
+	{ .addr = 0xac03 },
+	{ .addr = 0xac04 },
+	{ .addr = 0xac05 },
+	{ .addr = 0xac06 },
+	{ .addr = 0xac07 },
+	{ .addr = 0xac08 },
+	{ .addr = 0xac09 },
+	{ .addr = 0xac0a },
+	{ .addr = 0xac0b },
+	{ .addr = 0xac0c },
+	{ .addr = 0xac0d },
+	{ .addr = 0xac0e },
+	{ .addr = 0xac0f },
+	{ .addr = 0xac10 },
+	{ .addr = 0xac11 },
+	{ .addr = 0xac12 },
+	{ .addr = 0xac13 },
+	{ .addr = 0xac14 },
+	{ .addr = 0xac15 },
+	{ .addr = 0xac16 },
+	{ .addr = 0xac17 },
+	{ .addr = 0xac18 },
+	{ .addr = 0xac19 },
+	{ .addr = 0xb000 },
+	{ .addr = 0xb001 },
+	{ .addr = 0xb002 },
+	{ .addr = 0xb003 },
+	{ .addr = 0xb004 },
+	{ .addr = 0xb005 },
+	{ .addr = 0xb006 },
+	{ .addr = 0xb007 },
+	{ .addr = 0xb008 },
+	{ .addr = 0xb009 },
+	{ .addr = 0xb00a },
+	{ .addr = 0xb00b },
+	{ .addr = 0xb00c },
+	{ .addr = 0xb00d },
+	{ .addr = 0xb00e },
+	{ .addr = 0xb00f },
+	{ .addr = 0xb010 },
+	{ .addr = 0xb011 },
+	{ .addr = 0xb012 },
+	{ .addr = 0xb013 },
+	{ .addr = 0xb014 },
+	{ .addr = 0xb015 },
+	{ .addr = 0xb016 },
+	{ .addr = 0xb017 },
+	{ .addr = 0xb018 },
+	{ .addr = 0xb019 },
+	{ .addr = 0xb400 },
+	{ .addr = 0xb401 },
+	{ .addr = 0xb402 },
+	{ .addr = 0xb403 },
+	{ .addr = 0xb404 },
+	{ .addr = 0xb405 },
+	{ .addr = 0xb406 },
+	{ .addr = 0xb407 },
+	{ .addr = 0xb408 },
+	{ .addr = 0xb409 },
+	{ .addr = 0xb40a },
+	{ .addr = 0xb40b },
+	{ .addr = 0xb40c },
+	{ .addr = 0xb40d },
+	{ .addr = 0xb40e },
+	{ .addr = 0xb40f },
+	{ .addr = 0xb410 },
+	{ .addr = 0xb411 },
+	{ .addr = 0xb412 },
+	{ .addr = 0xb413 },
+	{ .addr = 0xb414 },
+	{ .addr = 0xb415 },
+	{ .addr = 0xb416 },
+	{ .addr = 0xb417 },
+	{ .addr = 0xb418 },
+	{ .addr = 0xb419 },
+	{ .addr = 0xe400 },
+	{ .addr = 0xe420 },
+	{ .addr = 0xe440 },
+	{ .addr = 0xe460 },
+	{ .addr = 0xe480 },
+	{ .addr = 0xe4a0 },
+	{ .addr = 0xe4c0 },
+	{ .addr = 0xe4e0 },
+	{ .addr = 0xe500 },
+	{ .addr = 0xe520 },
+	{ .addr = 0xe540 },
+	{ .addr = 0xe560 },
+	{ .addr = 0xe580 },
+	{ .addr = 0xe5a0 },
+	{ .addr = 0xe5c0 },
+	{ .addr = 0xe5e0 },
+	{ .addr = 0xe600 },
+	{ .addr = 0xe640 },
+	{ .addr = 0xe660 },
+	{ .addr = 0xe680 },
+	{ .addr = 0xe6a0 },
+	{ .addr = 0xe6c0 },
+	{ .addr = 0xe6e0 },
+	{ .addr = 0xe700 },
+	{ .addr = 0xe720 },
+	{ .addr = 0xe740 },
+	{ .addr = 0xe760 },
+	{ .addr = 0xe780 },
+	{ .addr = 0xe7a0 },
+	{ .addr = 0xe7c0 },
+	{ .addr = 0xe800 },
+	{ .addr = 0xe820 },
+	{ .addr = 0xe840 },
+	{ .addr = 0xe860 },
+	{ .addr = 0xe880 },
+	{ .addr = 0xe8a0 },
+	{ .addr = 0xe8c0 },
+	{ .addr = 0xe8e0 },
+	{ .addr = 0xe900 },
+	{ .addr = 0xe920 },
+	{ .addr = 0xe940 },
+	{ .addr = 0xe960 },
+	{ .addr = 0xe980 },
+	{ .addr = 0xe9a0 },
+	{ .addr = 0xe9c0 },
+	{ .addr = 0xe9e0 },
+	{ .addr = 0xec00 },
+	{ .addr = 0xec20 },
+	{ .addr = 0xec40 },
+	{ .addr = 0xec60 },
+	{ .addr = 0xec80 },
+	{ .addr = 0xeca0 },
+	{ .addr = 0xecc0 },
+	{ .addr = 0xece0 },
+	{ .addr = 0xed00 },
+	{ .addr = 0xed20 },
+	{ .addr = 0xed40 },
+	{ .addr = 0xed60 },
+	{ .addr = 0xed80 },
+	{ .addr = 0xeda0 },
+	{ .addr = 0xedc0 },
+	{ .addr = 0xede0 },
+	{ .addr = 0xee00 },
+	{ .addr = 0xee20 },
+	{ .addr = 0xee40 },
+	{ .addr = 0xee60 },
+	{ .addr = 0xee80 },
+	{ .addr = 0xeea0 },
+	{ .addr = 0xeec0 },
+	{ .addr = 0xeee0 },
+	{ .addr = 0xef00 },
+	{ .addr = 0xef20 },
+	{ .addr = 0xf000 },
+	{ .addr = 0xf020 },
+	{ .addr = 0xf040 },
+	{ .addr = 0xf100 },
+	{ .addr = 0xf101 },
+	{ .addr = 0xf102 },
+	{ .addr = 0xf103 },
+	{ .addr = 0xf104 },
+	{ .addr = 0xf105 },
+	{ .addr = 0xf106 },
+	{ .addr = 0xf107 },
+	{ .addr = 0xf108 },
+	{ .addr = 0xf120 },
+	{ .addr = 0xf140 },
+	{ .addr = 0xf160 },
+};
+
+static struct cudbg_indir_reg t7_ma_local_debug_perf_cfg[4] = {
+	{ .addr = 0xa000 },
+	{ .addr = 0xa1e0 },
+	{ .addr = 0xe000 },
+	{ .addr = 0xe1e0 },
+};
+
+static struct cudbg_indir_reg t7_pm_rx_dbg_ctrl[57] = {
+	{ .addr = 0x10013 },
+	{ .addr = 0x10014 },
+	{ .addr = 0x10015 },
+	{ .addr = 0x10016 },
+	{ .addr = 0x10019 },
+	{ .addr = 0x1001a },
+	{ .addr = 0x1001b },
+	{ .addr = 0x1001c },
+	{ .addr = 0x1001d },
+	{ .addr = 0x10020 },
+	{ .addr = 0x10021 },
+	{ .addr = 0x10022 },
+	{ .addr = 0x10023 },
+	{ .addr = 0x10024 },
+	{ .addr = 0x10025 },
+	{ .addr = 0x10026 },
+	{ .addr = 0x10027 },
+	{ .addr = 0x10028 },
+	{ .addr = 0x10029 },
+	{ .addr = 0x1002a },
+	{ .addr = 0x1002b },
+	{ .addr = 0x1002c },
+	{ .addr = 0x1002d },
+	{ .addr = 0x1002e },
+	{ .addr = 0x1002f },
+	{ .addr = 0x10030 },
+	{ .addr = 0x10031 },
+	{ .addr = 0x10032 },
+	{ .addr = 0x10033 },
+	{ .addr = 0x10034 },
+	{ .addr = 0x10035 },
+	{ .addr = 0x10036 },
+	{ .addr = 0x10037 },
+	{ .addr = 0x10038 },
+	{ .addr = 0x10039 },
+	{ .addr = 0x1003a },
+	{ .addr = 0x1003b },
+	{ .addr = 0x1003c },
+	{ .addr = 0x1003d },
+	{ .addr = 0x1003e },
+	{ .addr = 0x10049 },
+	{ .addr = 0x10060 },
+	{ .addr = 0x10061 },
+	{ .addr = 0x10062 },
+	{ .addr = 0x10063 },
+	{ .addr = 0x10070 },
+	{ .addr = 0x10071 },
+	{ .addr = 0x10072 },
+	{ .addr = 0x10073 },
+	{ .addr = 0x10074 },
+	{ .addr = 0x10075 },
+	{ .addr = 0x10076 },
+	{ .addr = 0x10077 },
+	{ .addr = 0x10078 },
+	{ .addr = 0x10080 },
+	{ .addr = 0x10081 },
+	{ .addr = 0x10082 },
+};
+
+static struct cudbg_indir_reg t7_pm_tx_dbg_ctrl[38] = {
+	{ .addr = 0x10000 },
+	{ .addr = 0x10001 },
+	{ .addr = 0x10002 },
+	{ .addr = 0x10003 },
+	{ .addr = 0x10004 },
+	{ .addr = 0x10005 },
+	{ .addr = 0x10006 },
+	{ .addr = 0x10007 },
+	{ .addr = 0x10008 },
+	{ .addr = 0x10009 },
+	{ .addr = 0x1000a },
+	{ .addr = 0x1000b },
+	{ .addr = 0x1000c },
+	{ .addr = 0x1000d },
+	{ .addr = 0x1000e },
+	{ .addr = 0x1000f },
+	{ .addr = 0x10010 },
+	{ .addr = 0x10011 },
+	{ .addr = 0x10012 },
+	{ .addr = 0x10013 },
+	{ .addr = 0x10014 },
+	{ .addr = 0x10015 },
+	{ .addr = 0x10016 },
+	{ .addr = 0x10017 },
+	{ .addr = 0x10018 },
+	{ .addr = 0x10019 },
+	{ .addr = 0x1001a },
+	{ .addr = 0x1001b },
+	{ .addr = 0x1001c },
+	{ .addr = 0x1001d },
+	{ .addr = 0x1001e },
+	{ .addr = 0x1001f },
+	{ .addr = 0x10020 },
+	{ .addr = 0x10021 },
+	{ .addr = 0x10022 },
+	{ .addr = 0x10023 },
+	{ .addr = 0x10024 },
+	{ .addr = 0x10025 },
+};
+
+static struct cudbg_indir_reg t7_tp_mib_index[130] = {
+	{ .addr = 0x0 },
+	{ .addr = 0x1 },
+	{ .addr = 0x2 },
+	{ .addr = 0x3 },
+	{ .addr = 0x4 },
+	{ .addr = 0x5 },
+	{ .addr = 0x6 },
+	{ .addr = 0x7 },
+	{ .addr = 0x8 },
+	{ .addr = 0x9 },
+	{ .addr = 0xa },
+	{ .addr = 0xb },
+	{ .addr = 0xc },
+	{ .addr = 0x10 },
+	{ .addr = 0x11 },
+	{ .addr = 0x12 },
+	{ .addr = 0x13 },
+	{ .addr = 0x14 },
+	{ .addr = 0x15 },
+	{ .addr = 0x18 },
+	{ .addr = 0x19 },
+	{ .addr = 0x1a },
+	{ .addr = 0x1b },
+	{ .addr = 0x1c },
+	{ .addr = 0x1d },
+	{ .addr = 0x1e },
+	{ .addr = 0x1f },
+	{ .addr = 0x20 },
+	{ .addr = 0x21 },
+	{ .addr = 0x22 },
+	{ .addr = 0x23 },
+	{ .addr = 0x24 },
+	{ .addr = 0x25 },
+	{ .addr = 0x26 },
+	{ .addr = 0x27 },
+	{ .addr = 0x28 },
+	{ .addr = 0x29 },
+	{ .addr = 0x2a },
+	{ .addr = 0x2b },
+	{ .addr = 0x2c },
+	{ .addr = 0x30 },
+	{ .addr = 0x31 },
+	{ .addr = 0x32 },
+	{ .addr = 0x33 },
+	{ .addr = 0x34 },
+	{ .addr = 0x35 },
+	{ .addr = 0x36 },
+	{ .addr = 0x37 },
+	{ .addr = 0x38 },
+	{ .addr = 0x39 },
+	{ .addr = 0x3a },
+	{ .addr = 0x3b },
+	{ .addr = 0x3c },
+	{ .addr = 0x3d },
+	{ .addr = 0x3e },
+	{ .addr = 0x3f },
+	{ .addr = 0x40 },
+	{ .addr = 0x41 },
+	{ .addr = 0x42 },
+	{ .addr = 0x43 },
+	{ .addr = 0x44 },
+	{ .addr = 0x45 },
+	{ .addr = 0x46 },
+	{ .addr = 0x47 },
+	{ .addr = 0x48 },
+	{ .addr = 0x49 },
+	{ .addr = 0x4a },
+	{ .addr = 0x4b },
+	{ .addr = 0x4c },
+	{ .addr = 0x4d },
+	{ .addr = 0x4e },
+	{ .addr = 0x4f },
+	{ .addr = 0x50 },
+	{ .addr = 0x51 },
+	{ .addr = 0x52 },
+	{ .addr = 0x53 },
+	{ .addr = 0x54 },
+	{ .addr = 0x55 },
+	{ .addr = 0x56 },
+	{ .addr = 0x57 },
+	{ .addr = 0x58 },
+	{ .addr = 0x59 },
+	{ .addr = 0x5a },
+	{ .addr = 0x5b },
+	{ .addr = 0x5c },
+	{ .addr = 0x5d },
+	{ .addr = 0x5e },
+	{ .addr = 0x5f },
+	{ .addr = 0x60 },
+	{ .addr = 0x61 },
+	{ .addr = 0x62 },
+	{ .addr = 0x63 },
+	{ .addr = 0x64 },
+	{ .addr = 0x65 },
+	{ .addr = 0x68 },
+	{ .addr = 0x69 },
+	{ .addr = 0x6a },
+	{ .addr = 0x6b },
+	{ .addr = 0x6c },
+	{ .addr = 0x6d },
+	{ .addr = 0x6e },
+	{ .addr = 0x6f },
+	{ .addr = 0x70 },
+	{ .addr = 0x71 },
+	{ .addr = 0x72 },
+	{ .addr = 0x73 },
+	{ .addr = 0x80 },
+	{ .addr = 0x81 },
+	{ .addr = 0x82 },
+	{ .addr = 0x83 },
+	{ .addr = 0x84 },
+	{ .addr = 0x85 },
+	{ .addr = 0x86 },
+	{ .addr = 0x87 },
+	{ .addr = 0x88 },
+	{ .addr = 0x89 },
+	{ .addr = 0x8a },
+	{ .addr = 0x8b },
+	{ .addr = 0x90 },
+	{ .addr = 0x91 },
+	{ .addr = 0x92 },
+	{ .addr = 0x93 },
+	{ .addr = 0x94 },
+	{ .addr = 0x95 },
+	{ .addr = 0x96 },
+	{ .addr = 0x97 },
+	{ .addr = 0x98 },
+	{ .addr = 0x99 },
+	{ .addr = 0x9a },
+	{ .addr = 0x9b },
+};
+
+static struct cudbg_indir_reg t7_tp_pio_addr[191] = {
+	{ .addr = 0x1c },
+	{ .addr = 0x1d },
+	{ .addr = 0x1e },
+	{ .addr = 0x1f },
+	{ .addr = 0x20 },
+	{ .addr = 0x21 },
+	{ .addr = 0x22 },
+	{ .addr = 0x23 },
+	{ .addr = 0x24 },
+	{ .addr = 0x25 },
+	{ .addr = 0x26 },
+	{ .addr = 0x27 },
+	{ .addr = 0x28 },
+	{ .addr = 0x29 },
+	{ .addr = 0x2a },
+	{ .addr = 0x2b },
+	{ .addr = 0x2c },
+	{ .addr = 0x2d },
+	{ .addr = 0x2e },
+	{ .addr = 0x2f },
+	{ .addr = 0x30 },
+	{ .addr = 0x31 },
+	{ .addr = 0x32 },
+	{ .addr = 0x33 },
+	{ .addr = 0x34 },
+	{ .addr = 0x35 },
+	{ .addr = 0x36 },
+	{ .addr = 0x37 },
+	{ .addr = 0x38 },
+	{ .addr = 0x39 },
+	{ .addr = 0x3a },
+	{ .addr = 0x3b },
+	{ .addr = 0x40 },
+	{ .addr = 0x41 },
+	{ .addr = 0x42 },
+	{ .addr = 0x43 },
+	{ .addr = 0x44 },
+	{ .addr = 0x45 },
+	{ .addr = 0x46 },
+	{ .addr = 0x47 },
+	{ .addr = 0x48 },
+	{ .addr = 0x49 },
+	{ .addr = 0x50 },
+	{ .addr = 0x51 },
+	{ .addr = 0x52 },
+	{ .addr = 0x53 },
+	{ .addr = 0x54 },
+	{ .addr = 0x55 },
+	{ .addr = 0x56 },
+	{ .addr = 0x57 },
+	{ .addr = 0x58 },
+	{ .addr = 0x59 },
+	{ .addr = 0x60 },
+	{ .addr = 0x61 },
+	{ .addr = 0x62 },
+	{ .addr = 0x63 },
+	{ .addr = 0x64 },
+	{ .addr = 0x65 },
+	{ .addr = 0x66 },
+	{ .addr = 0x67 },
+	{ .addr = 0x68 },
+	{ .addr = 0x69 },
+	{ .addr = 0x6a },
+	{ .addr = 0x6b },
+	{ .addr = 0x6c },
+	{ .addr = 0x6d },
+	{ .addr = 0x6f },
+	{ .addr = 0x70 },
+	{ .addr = 0x71 },
+	{ .addr = 0x72 },
+	{ .addr = 0x73 },
+	{ .addr = 0x74 },
+	{ .addr = 0x75 },
+	{ .addr = 0x80 },
+	{ .addr = 0x81 },
+	{ .addr = 0x82 },
+	{ .addr = 0x83 },
+	{ .addr = 0x84 },
+	{ .addr = 0x85 },
+	{ .addr = 0x86 },
+	{ .addr = 0x87 },
+	{ .addr = 0x88 },
+	{ .addr = 0x89 },
+	{ .addr = 0x8a },
+	{ .addr = 0x8b },
+	{ .addr = 0x8c },
+	{ .addr = 0x8d },
+	{ .addr = 0x8e },
+	{ .addr = 0x8f },
+	{ .addr = 0x90 },
+	{ .addr = 0x91 },
+	{ .addr = 0x92 },
+	{ .addr = 0x93 },
+	{ .addr = 0x94 },
+	{ .addr = 0x95 },
+	{ .addr = 0x96 },
+	{ .addr = 0x97 },
+	{ .addr = 0x98 },
+	{ .addr = 0x99 },
+	{ .addr = 0x130 },
+	{ .addr = 0x131 },
+	{ .addr = 0x132 },
+	{ .addr = 0x133 },
+	{ .addr = 0x134 },
+	{ .addr = 0x135 },
+	{ .addr = 0x136 },
+	{ .addr = 0x137 },
+	{ .addr = 0x138 },
+	{ .addr = 0x139 },
+	{ .addr = 0x13a },
+	{ .addr = 0x13b },
+	{ .addr = 0x13c },
+	{ .addr = 0x13d },
+	{ .addr = 0x13e },
+	{ .addr = 0x13f },
+	{ .addr = 0x140 },
+	{ .addr = 0x141 },
+	{ .addr = 0x145 },
+	{ .addr = 0x146 },
+	{ .addr = 0x147 },
+	{ .addr = 0x148 },
+	{ .addr = 0x149 },
+	{ .addr = 0x14a },
+	{ .addr = 0x14b },
+	{ .addr = 0x14c },
+	{ .addr = 0x14d },
+	{ .addr = 0x14e },
+	{ .addr = 0x14f },
+	{ .addr = 0x150 },
+	{ .addr = 0x151 },
+	{ .addr = 0x152 },
+	{ .addr = 0x153 },
+	{ .addr = 0x154 },
+	{ .addr = 0x155 },
+	{ .addr = 0x156 },
+	{ .addr = 0x157 },
+	{ .addr = 0x158 },
+	{ .addr = 0x159 },
+	{ .addr = 0x15a },
+	{ .addr = 0x15b },
+	{ .addr = 0x160 },
+	{ .addr = 0x161 },
+	{ .addr = 0x162 },
+	{ .addr = 0x164 },
+	{ .addr = 0x165 },
+	{ .addr = 0x166 },
+	{ .addr = 0x168 },
+	{ .addr = 0x169 },
+	{ .addr = 0x230 },
+	{ .addr = 0x231 },
+	{ .addr = 0x232 },
+	{ .addr = 0x233 },
+	{ .addr = 0x234 },
+	{ .addr = 0x235 },
+	{ .addr = 0x236 },
+	{ .addr = 0x237 },
+	{ .addr = 0x238 },
+	{ .addr = 0x239 },
+	{ .addr = 0x23a },
+	{ .addr = 0x23b },
+	{ .addr = 0x23c },
+	{ .addr = 0x23d },
+	{ .addr = 0x23e },
+	{ .addr = 0x23f },
+	{ .addr = 0x240 },
+	{ .addr = 0x241 },
+	{ .addr = 0x242 },
+	{ .addr = 0x243 },
+	{ .addr = 0x244 },
+	{ .addr = 0x245 },
+	{ .addr = 0x246 },
+	{ .addr = 0x247 },
+	{ .addr = 0x248 },
+	{ .addr = 0x24a },
+	{ .addr = 0x24b },
+	{ .addr = 0x24c },
+	{ .addr = 0x24d },
+	{ .addr = 0x24e },
+	{ .addr = 0x24f },
+	{ .addr = 0x250 },
+	{ .addr = 0x251 },
+	{ .addr = 0x252 },
+	{ .addr = 0x253 },
+	{ .addr = 0x254 },
+	{ .addr = 0x255 },
+	{ .addr = 0x256 },
+	{ .addr = 0x257 },
+	{ .addr = 0x258 },
+	{ .addr = 0x259 },
+	{ .addr = 0x260 },
+	{ .addr = 0x8c0 },
+};
+
+static struct cudbg_indir_reg t7_tp_tm_pio_addr[14] = {
+	{ .addr = 0x0 },
+	{ .addr = 0x1 },
+	{ .addr = 0x2 },
+	{ .addr = 0x3 },
+	{ .addr = 0x4 },
+	{ .addr = 0x5 },
+	{ .addr = 0x6 },
+	{ .addr = 0x7 },
+	{ .addr = 0x8 },
+	{ .addr = 0x9 },
+	{ .addr = 0xa },
+	{ .addr = 0xb },
+	{ .addr = 0xc },
+	{ .addr = 0xd },
+};
+
+static struct cudbg_indir_reg t7_up[245] = {
+	{ .addr = 0x0 },
+	{ .addr = 0x4 },
+	{ .addr = 0x8 },
+	{ .addr = 0xc },
+	{ .addr = 0x10 },
+	{ .addr = 0x80 },
+	{ .addr = 0x84 },
+	{ .addr = 0x88 },
+	{ .addr = 0x8c },
+	{ .addr = 0x90 },
+	{ .addr = 0xc0 },
+	{ .addr = 0xc4 },
+	{ .addr = 0xc8 },
+	{ .addr = 0xcc },
+	{ .addr = 0xd0 },
+	{ .addr = 0xd4 },
+	{ .addr = 0x100 },
+	{ .addr = 0x104 },
+	{ .addr = 0x108 },
+	{ .addr = 0x10c },
+	{ .addr = 0x110 },
+	{ .addr = 0x114 },
+	{ .addr = 0x118 },
+	{ .addr = 0x11c },
+	{ .addr = 0x120 },
+	{ .addr = 0x130 },
+	{ .addr = 0x140 },
+	{ .addr = 0x144 },
+	{ .addr = 0x14c },
+	{ .addr = 0x200 },
+	{ .addr = 0x204 },
+	{ .addr = 0x208 },
+	{ .addr = 0x20c },
+	{ .addr = 0x210 },
+	{ .addr = 0x214 },
+	{ .addr = 0x218 },
+	{ .addr = 0x21c },
+	{ .addr = 0x220 },
+	{ .addr = 0x224 },
+	{ .addr = 0x228 },
+	{ .addr = 0x22c },
+	{ .addr = 0x230 },
+	{ .addr = 0x234 },
+	{ .addr = 0x238 },
+	{ .addr = 0x23c },
+	{ .addr = 0x240 },
+	{ .addr = 0x244 },
+	{ .addr = 0x250 },
+	{ .addr = 0x254 },
+	{ .addr = 0x260 },
+	{ .addr = 0x264 },
+	{ .addr = 0x270 },
+	{ .addr = 0x274 },
+	{ .addr = 0x400 },
+	{ .addr = 0x404 },
+	{ .addr = 0x408 },
+	{ .addr = 0x40c },
+	{ .addr = 0x410 },
+	{ .addr = 0x414 },
+	{ .addr = 0x418 },
+	{ .addr = 0x41c },
+	{ .addr = 0x420 },
+	{ .addr = 0x424 },
+	{ .addr = 0x428 },
+	{ .addr = 0x42c },
+	{ .addr = 0x430 },
+	{ .addr = 0x434 },
+	{ .addr = 0x438 },
+	{ .addr = 0x43c },
+	{ .addr = 0x440 },
+	{ .addr = 0x444 },
+	{ .addr = 0x448 },
+	{ .addr = 0x44c },
+	{ .addr = 0x450 },
+	{ .addr = 0x454 },
+	{ .addr = 0x458 },
+	{ .addr = 0x45c },
+	{ .addr = 0x460 },
+	{ .addr = 0x464 },
+	{ .addr = 0x468 },
+	{ .addr = 0x46c },
+	{ .addr = 0x470 },
+	{ .addr = 0x474 },
+	{ .addr = 0x478 },
+	{ .addr = 0x47c },
+	{ .addr = 0x480 },
+	{ .addr = 0x484 },
+	{ .addr = 0x488 },
+	{ .addr = 0x48c },
+	{ .addr = 0x490 },
+	{ .addr = 0x494 },
+	{ .addr = 0x498 },
+	{ .addr = 0x49c },
+	{ .addr = 0x4a0 },
+	{ .addr = 0x4a4 },
+	{ .addr = 0x4a8 },
+	{ .addr = 0x4ac },
+	{ .addr = 0x4b0 },
+	{ .addr = 0x4b4 },
+	{ .addr = 0x4b8 },
+	{ .addr = 0x4bc },
+	{ .addr = 0x4c0 },
+	{ .addr = 0x4c4 },
+	{ .addr = 0x4c8 },
+	{ .addr = 0x4cc },
+	{ .addr = 0x4d0 },
+	{ .addr = 0x4d4 },
+	{ .addr = 0x4d8 },
+	{ .addr = 0x4dc },
+	{ .addr = 0x4e0 },
+	{ .addr = 0x4e4 },
+	{ .addr = 0x4e8 },
+	{ .addr = 0x4ec },
+	{ .addr = 0x4f0 },
+	{ .addr = 0x4f4 },
+	{ .addr = 0x4f8 },
+	{ .addr = 0x4fc },
+	{ .addr = 0x500 },
+	{ .addr = 0x504 },
+	{ .addr = 0x510 },
+	{ .addr = 0x514 },
+	{ .addr = 0x520 },
+	{ .addr = 0x524 },
+	{ .addr = 0x530 },
+	{ .addr = 0x534 },
+	{ .addr = 0x540 },
+	{ .addr = 0x544 },
+	{ .addr = 0x550 },
+	{ .addr = 0x554 },
+	{ .addr = 0x560 },
+	{ .addr = 0x564 },
+	{ .addr = 0x570 },
+	{ .addr = 0x574 },
+	{ .addr = 0x580 },
+	{ .addr = 0x584 },
+	{ .addr = 0x590 },
+	{ .addr = 0x594 },
+	{ .addr = 0x5a0 },
+	{ .addr = 0x5a4 },
+	{ .addr = 0x5b0 },
+	{ .addr = 0x5b4 },
+	{ .addr = 0x5c0 },
+	{ .addr = 0x5c4 },
+	{ .addr = 0x5d0 },
+	{ .addr = 0x5d4 },
+	{ .addr = 0x5e0 },
+	{ .addr = 0x5e4 },
+	{ .addr = 0x5f0 },
+	{ .addr = 0x5f4 },
+	{ .addr = 0x600 },
+	{ .addr = 0x604 },
+	{ .addr = 0x608 },
+	{ .addr = 0x60c },
+	{ .addr = 0x610 },
+	{ .addr = 0x614 },
+	{ .addr = 0x618 },
+	{ .addr = 0x61c },
+	{ .addr = 0x620 },
+	{ .addr = 0x624 },
+	{ .addr = 0x628 },
+	{ .addr = 0x62c },
+	{ .addr = 0x630 },
+	{ .addr = 0x634 },
+	{ .addr = 0x638 },
+	{ .addr = 0x63c },
+	{ .addr = 0x640 },
+	{ .addr = 0x644 },
+	{ .addr = 0x648 },
+	{ .addr = 0x64c },
+	{ .addr = 0x650 },
+	{ .addr = 0x654 },
+	{ .addr = 0x658 },
+	{ .addr = 0x65c },
+	{ .addr = 0x660 },
+	{ .addr = 0x664 },
+	{ .addr = 0x668 },
+	{ .addr = 0x66c },
+	{ .addr = 0x670 },
+	{ .addr = 0x674 },
+	{ .addr = 0x678 },
+	{ .addr = 0x67c },
+	{ .addr = 0x680 },
+	{ .addr = 0x684 },
+	{ .addr = 0x688 },
+	{ .addr = 0x68c },
+	{ .addr = 0x690 },
+	{ .addr = 0x694 },
+	{ .addr = 0x698 },
+	{ .addr = 0x69c },
+	{ .addr = 0x6a0 },
+	{ .addr = 0x6a4 },
+	{ .addr = 0x6a8 },
+	{ .addr = 0x6ac },
+	{ .addr = 0x6b0 },
+	{ .addr = 0x6b4 },
+	{ .addr = 0x6b8 },
+	{ .addr = 0x6bc },
+	{ .addr = 0x6c0 },
+	{ .addr = 0x6c4 },
+	{ .addr = 0x6c8 },
+	{ .addr = 0x6cc },
+	{ .addr = 0x6d0 },
+	{ .addr = 0x6d4 },
+	{ .addr = 0x6d8 },
+	{ .addr = 0x6dc },
+	{ .addr = 0x6e0 },
+	{ .addr = 0x6e4 },
+	{ .addr = 0x6e8 },
+	{ .addr = 0x6ec },
+	{ .addr = 0x6f0 },
+	{ .addr = 0x6f4 },
+	{ .addr = 0x6f8 },
+	{ .addr = 0x6fc },
+	{ .addr = 0x700 },
+	{ .addr = 0x704 },
+	{ .addr = 0x710 },
+	{ .addr = 0x714 },
+	{ .addr = 0x720 },
+	{ .addr = 0x724 },
+	{ .addr = 0x730 },
+	{ .addr = 0x734 },
+	{ .addr = 0x740 },
+	{ .addr = 0x744 },
+	{ .addr = 0x750 },
+	{ .addr = 0x754 },
+	{ .addr = 0x760 },
+	{ .addr = 0x764 },
+	{ .addr = 0x770 },
+	{ .addr = 0x774 },
+	{ .addr = 0x780 },
+	{ .addr = 0x784 },
+	{ .addr = 0x790 },
+	{ .addr = 0x794 },
+	{ .addr = 0x7a0 },
+	{ .addr = 0x7a4 },
+	{ .addr = 0x7b0 },
+	{ .addr = 0x7b4 },
+	{ .addr = 0x7c0 },
+	{ .addr = 0x7c4 },
+	{ .addr = 0x7d0 },
+	{ .addr = 0x7d4 },
+	{ .addr = 0x7e0 },
+	{ .addr = 0x7e4 },
+	{ .addr = 0x7f0 },
+	{ .addr = 0x7f4 },
+};
+
+static struct cudbg_indir_type_entry t7_indir_type_arr[CUDBG_INDIR_TYPE_MAX] = {
+	[CUDBG_INDIR_TYPE_CIM_CTL] = {
+		.reg_arr = t7_cim_ctl,
+		.nentries = ARRAY_SIZE(t7_cim_ctl),
+	},
+	[CUDBG_INDIR_TYPE_HMAT6_LOCAL_DEBUG_CFG] = {
+		.reg_arr = t7_hmat6_local_debug_cfg,
+		.nentries = ARRAY_SIZE(t7_hmat6_local_debug_cfg),
+	},
+	[CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_CFG] = {
+		.reg_arr = t7_ma_local_debug_cfg,
+		.nentries = ARRAY_SIZE(t7_ma_local_debug_cfg),
+	},
+	[CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_PERF_CFG] = {
+		.reg_arr = t7_ma_local_debug_perf_cfg,
+		.nentries = ARRAY_SIZE(t7_ma_local_debug_perf_cfg),
+	},
+	[CUDBG_INDIR_TYPE_PM_RX_DBG_CTRL] = {
+		.reg_arr = t7_pm_rx_dbg_ctrl,
+		.nentries = ARRAY_SIZE(t7_pm_rx_dbg_ctrl),
+	},
+	[CUDBG_INDIR_TYPE_PM_TX_DBG_CTRL] = {
+		.reg_arr = t7_pm_tx_dbg_ctrl,
+		.nentries = ARRAY_SIZE(t7_pm_tx_dbg_ctrl),
+	},
+	[CUDBG_INDIR_TYPE_TP_MIB_INDEX] = {
+		.reg_arr = t7_tp_mib_index,
+		.nentries = ARRAY_SIZE(t7_tp_mib_index),
+	},
+	[CUDBG_INDIR_TYPE_TP_PIO_ADDR] = {
+		.reg_arr = t7_tp_pio_addr,
+		.nentries = ARRAY_SIZE(t7_tp_pio_addr),
+	},
+	[CUDBG_INDIR_TYPE_TP_TM_PIO_ADDR] = {
+		.reg_arr = t7_tp_tm_pio_addr,
+		.nentries = ARRAY_SIZE(t7_tp_tm_pio_addr),
+	},
+	[CUDBG_INDIR_TYPE_UP] = {
+		.reg_arr = t7_up,
+		.nentries = ARRAY_SIZE(t7_up),
+	},
+};
+
+#endif /* __CUDBG_INDIR_REG_T7_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 557c591a6ce3..a55e0a09a25e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -15,6 +15,7 @@
 #include "cudbg_lib.h"
 #include "cudbg_zlib.h"
 #include "cxgb4_tc_mqprio.h"
+#include "cudbg_indir_reg.h"
 
 static const u32 t6_tp_pio_array[][IREG_NUM_ELEM] = {
 	{0x7e40, 0x7e44, 0x020, 28}, /* t6_tp_pio_regs_20_to_3b */
@@ -198,7 +199,7 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		}
 		break;
 	case CUDBG_DEV_LOG:
-		len = adap->params.devlog.size;
+		len = adap->params.devlog[0].size;
 		break;
 	case CUDBG_CIM_LA:
 		if (is_t6(adap->params.chip)) {
@@ -214,7 +215,7 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		len = 2 * CIM_MALA_SIZE * 5 * sizeof(u32);
 		break;
 	case CUDBG_CIM_QCFG:
-		len = sizeof(struct cudbg_cim_qcfg);
+		len = sizeof(struct cim_qcfg_rev1);
 		break;
 	case CUDBG_CIM_IBQ_TP0:
 	case CUDBG_CIM_IBQ_TP1:
@@ -350,7 +351,9 @@ u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 		len = sizeof(u32) * CUDBG_NUM_PCIE_CONFIG_REGS;
 		break;
 	case CUDBG_DUMP_CONTEXT:
-		len = cudbg_dump_context_size(adap);
+		len = cudbg_dump_context_size(adap, (CHELSIO_CHIP_VERSION(adap->params.chip) >=
+						    CHELSIO_T7) ? SGE_CTXT_SIZE_T7 :
+								  SGE_CTXT_SIZE);
 		break;
 	case CUDBG_MPS_TCAM:
 		len = sizeof(struct cudbg_mps_tcam) *
@@ -822,7 +825,7 @@ int cudbg_collect_reg_dump(struct cudbg_init *pdbg_init,
 
 	if (is_t4(padap->params.chip))
 		buf_size = T4_REGMAP_SIZE;
-	else if (is_t5(padap->params.chip) || is_t6(padap->params.chip))
+	else
 		buf_size = T5_REGMAP_SIZE;
 
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, buf_size, &temp_buff);
@@ -839,15 +842,20 @@ int cudbg_collect_fw_devlog(struct cudbg_init *pdbg_init,
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	struct devlog_params *dparams;
+	u8 coreid = 0;
 	int rc = 0;
 
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+	dparams = &padap->params.devlog[coreid];
 	rc = t4_init_devlog_params(padap);
 	if (rc < 0) {
 		cudbg_err->sys_err = rc;
 		return rc;
 	}
 
-	dparams = &padap->params.devlog;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, dparams->size, &temp_buff);
 	if (rc)
 		return rc;
@@ -875,39 +883,52 @@ int cudbg_collect_cim_la(struct cudbg_init *pdbg_init,
 			 struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
+	struct struct_cim_la_rev1 *cim_la_buff;
 	struct cudbg_buffer temp_buff = { 0 };
+	u8 ncol, coreid = 0;
 	int size, rc;
 	u32 cfg = 0;
+	u16 nrow;
 
-	if (is_t6(padap->params.chip)) {
-		size = padap->params.cim_la_size / 10 + 1;
-		size *= 10 * sizeof(u32);
-	} else {
-		size = padap->params.cim_la_size / 8;
-		size *= 8 * sizeof(u32);
-	}
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T6)
+		ncol = 10;
+	else
+		ncol = 8;
 
-	size += sizeof(cfg);
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+	nrow = padap->params.cim_la_size / ncol;
+	size = sizeof(*cim_la_buff) + padap->params.cim_la_size * sizeof(u32);
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	rc = t4_cim_read(padap, UP_UP_DBG_LA_CFG_A, 1, &cfg);
+	cim_la_buff = (void *)temp_buff.data;
+	cim_la_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_la_buff->ver_hdr.revision = CUDBG_CIM_LA_REV;
+	cim_la_buff->ver_hdr.size = sizeof(*cim_la_buff) -
+		sizeof(struct cudbg_ver_hdr);
+
+	rc = t4_cim_read_core(padap, 1, coreid, UP_UP_DBG_LA_CFG_A, 1, &cfg);
 	if (rc) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
 
-	memcpy((char *)temp_buff.data, &cfg, sizeof(cfg));
-	rc = t4_cim_read_la(padap,
-			    (u32 *)((char *)temp_buff.data + sizeof(cfg)),
-			    NULL);
+	rc = t4_cim_read_la_core(padap, coreid, cim_la_buff->data, NULL);
 	if (rc < 0) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
+
+	cim_la_buff->coreid = coreid;
+	cim_la_buff->config = cfg;
+	cim_la_buff->ncol = ncol;
+	cim_la_buff->nrow = nrow;
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
@@ -931,41 +952,160 @@ int cudbg_collect_cim_ma_la(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void cudbg_cim_qcfg_copy(struct cim_qcfg_rev1_data *data, u8 num_cim_ibq,
+				u8 num_cim_obq, u16 *base, u16 *size,
+				u16 *thres, u32 *stat, u32 *obq_wr)
+{
+	u8 i = 0;
+
+	while (i < num_cim_ibq) {
+		data->qtype = CUDBG_ENTITY_CIM_QCFG_QTYPE_IBQ;
+		data->qid = i;
+		data->base = *base;
+		data->size = *size;
+		data->thres = *thres;
+		memcpy(data->stat, stat, sizeof(data->stat));
+
+		stat += ARRAY_SIZE(data->stat);
+		thres++;
+		size++;
+		base++;
+		data++;
+		i++;
+	}
+
+	while (i < num_cim_ibq + num_cim_obq) {
+		data->qtype = CUDBG_ENTITY_CIM_QCFG_QTYPE_OBQ;
+		data->qid = i - num_cim_ibq;
+		data->base = *base;
+		data->size = *size;
+		memcpy(data->stat, stat, sizeof(data->stat));
+		memcpy(data->obq_wr, obq_wr, sizeof(data->obq_wr));
+
+		obq_wr += ARRAY_SIZE(data->obq_wr);
+		stat += ARRAY_SIZE(data->stat);
+		size++;
+		base++;
+		data++;
+		i++;
+	}
+}
+
+static int cudbg_collect_cim_qcfg_t5(struct cudbg_init *pdbg_init,
+				     struct cim_qcfg_rev1_data *data,
+				     u8 num_cim_ibq, u8 num_cim_obq)
+{
+	u32 stat[4 * (CIM_NUM_IBQ + CIM_NUM_OBQ_T5)];
+	struct adapter *padap = pdbg_init->adap;
+	u16 base[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
+	u16 size[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
+	u32 obq_wr[2 * CIM_NUM_OBQ_T5];
+	u16 thres[CIM_NUM_IBQ];
+	int ret;
+
+	ret = t4_cim_read(padap, UP_IBQ_0_SHADOW_RDADDR_A,
+			  4 * (num_cim_ibq + num_cim_obq), stat);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_cim_read(padap, UP_OBQ_0_SHADOW_REALADDR_A, 2 * num_cim_obq,
+			  obq_wr);
+	if (ret < 0)
+		return ret;
+
+	t4_read_cimq_cfg(padap, base, size, thres);
+
+	cudbg_cim_qcfg_copy(data, num_cim_ibq, num_cim_obq, base, size, thres,
+			    stat, obq_wr);
+	return 0;
+}
+
+static int cudbg_collect_cim_qcfg_t7(struct cudbg_init *pdbg_init, u8 coreid,
+				     struct cim_qcfg_rev1_data *data,
+				     u8 num_cim_ibq, u8 num_cim_obq)
+{
+	u32 stat[4 * (CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7)];
+	u16 base[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	u16 size[CIM_NUM_IBQ_T7 + CIM_NUM_OBQ_T7];
+	struct adapter *padap = pdbg_init->adap;
+	u32 obq_wr[2 * CIM_NUM_OBQ_T7];
+	u16 thres[CIM_NUM_IBQ_T7];
+	u32 addr;
+	int ret;
+	u8 i;
+
+	ret = t4_cim_read_core(padap, 1, coreid, T7_UP_IBQ_0_SHADOW_RDADDR_A,
+			       4 * num_cim_ibq, stat);
+	if (ret < 0)
+		return ret;
+
+	ret = t4_cim_read_core(padap, 1, coreid, T7_UP_OBQ_0_SHADOW_RDADDR_A,
+			       4 * num_cim_obq, &stat[4 * num_cim_ibq]);
+	if (ret < 0)
+		return ret;
+
+	addr = T7_UP_OBQ_0_SHADOW_REALADDR_A;
+	for (i = 0; i < num_cim_obq * 2; i++, addr += 8) {
+		ret = t4_cim_read_core(padap, 1, coreid, addr, 1, &obq_wr[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	t4_read_cimq_cfg_core(padap, coreid, base, size, thres);
+
+	cudbg_cim_qcfg_copy(data, num_cim_ibq, num_cim_obq, base, size, thres,
+			    stat, obq_wr);
+	return 0;
+}
+
 int cudbg_collect_cim_qcfg(struct cudbg_init *pdbg_init,
 			   struct cudbg_buffer *dbg_buff,
 			   struct cudbg_error *cudbg_err)
 {
+	struct cim_qcfg_rev1 *cim_qcfg_buff;
+	u8 num_cim_ibq, num_cim_obq, coreid = 0;
 	struct adapter *padap = pdbg_init->adap;
+	struct cim_qcfg_rev1_data *data;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct cudbg_cim_qcfg *cim_qcfg_data;
+	u32 size;
 	int rc;
 
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(struct cudbg_cim_qcfg),
-			    &temp_buff);
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+	num_cim_ibq = t4_cim_num_ibq(padap);
+	num_cim_obq = t4_cim_num_obq(padap);
+	size = sizeof(*cim_qcfg_buff) +
+		((num_cim_ibq + num_cim_obq) * sizeof(*data));
+
+	rc = get_scratch_buff(dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	cim_qcfg_data = (struct cudbg_cim_qcfg *)temp_buff.data;
-	cim_qcfg_data->chip = padap->params.chip;
-	rc = t4_cim_read(padap, UP_IBQ_0_RDADDR_A,
-			 ARRAY_SIZE(cim_qcfg_data->stat), cim_qcfg_data->stat);
-	if (rc) {
-		cudbg_err->sys_err = rc;
-		cudbg_put_buff(pdbg_init, &temp_buff);
-		return rc;
-	}
+	cim_qcfg_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_qcfg_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_qcfg_buff->ver_hdr.revision = CUDBG_CIM_QCFG_REV;
+	cim_qcfg_buff->ver_hdr.size = sizeof(*cim_qcfg_buff) -
+		sizeof(struct cudbg_ver_hdr);
 
-	rc = t4_cim_read(padap, UP_OBQ_0_REALADDR_A,
-			 ARRAY_SIZE(cim_qcfg_data->obq_wr),
-			 cim_qcfg_data->obq_wr);
+	cim_qcfg_buff->num_cim_ibq = num_cim_ibq;
+	cim_qcfg_buff->num_cim_obq = num_cim_obq;
+	cim_qcfg_buff->coreid = coreid;
+	data = cim_qcfg_buff->data;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		rc = cudbg_collect_cim_qcfg_t7(pdbg_init, coreid, data,
+					       num_cim_ibq, num_cim_obq);
+	else
+		rc = cudbg_collect_cim_qcfg_t5(pdbg_init, data, num_cim_ibq,
+					       num_cim_obq);
 	if (rc) {
 		cudbg_err->sys_err = rc;
 		cudbg_put_buff(pdbg_init, &temp_buff);
 		return rc;
 	}
 
-	t4_read_cimq_cfg(padap, cim_qcfg_data->base, cim_qcfg_data->size,
-			 cim_qcfg_data->thres);
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
@@ -973,20 +1113,38 @@ static int cudbg_read_cim_ibq(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err, int qid)
 {
+	struct cim_ibq_rev1 *cim_ibq_buff;
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	int no_of_read_words, rc = 0;
+	u8 coreid = 0;
 	u32 qsize;
 
+	if (qid >= t4_cim_num_ibq(padap))
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
 	/* collect CIM IBQ */
 	qsize = CIM_IBQ_SIZE * 4 * sizeof(u32);
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, qsize, &temp_buff);
+	rc = get_scratch_buff(dbg_buff, sizeof(*cim_ibq_buff) + qsize,
+			      &temp_buff);
 	if (rc)
 		return rc;
+	cim_ibq_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_ibq_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_ibq_buff->ver_hdr.revision = CUDBG_CIM_IBQ_REV;
+	cim_ibq_buff->ver_hdr.size = sizeof(*cim_ibq_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	cim_ibq_buff->qid = qid;
+	cim_ibq_buff->coreid = coreid;
 
 	/* t4_read_cim_ibq will return no. of read words or error */
-	no_of_read_words = t4_read_cim_ibq(padap, qid,
-					   (u32 *)temp_buff.data, qsize);
+	no_of_read_words = t4_read_cim_ibq_core(padap, coreid, qid,
+						cim_ibq_buff->data, qsize);
+
 	/* no_of_read_words is less than or equal to 0 means error */
 	if (no_of_read_words <= 0) {
 		if (!no_of_read_words)
@@ -1014,10 +1172,39 @@ int cudbg_collect_cim_ibq_tp1(struct cudbg_init *pdbg_init,
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 1);
 }
 
+int cudbg_collect_cim_ibq_tp2(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err)
+{
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) <= CHELSIO_T6)
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 2);
+}
+
+int cudbg_collect_cim_ibq_tp3(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err)
+{
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) <= CHELSIO_T6)
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 3);
+}
+
 int cudbg_collect_cim_ibq_ulp(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 4);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 2);
 }
 
@@ -1025,6 +1212,11 @@ int cudbg_collect_cim_ibq_sge0(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 5);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 3);
 }
 
@@ -1032,6 +1224,11 @@ int cudbg_collect_cim_ibq_sge1(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 6);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 4);
 }
 
@@ -1039,9 +1236,63 @@ int cudbg_collect_cim_ibq_ncsi(struct cudbg_init *pdbg_init,
 			       struct cudbg_buffer *dbg_buff,
 			       struct cudbg_error *cudbg_err)
 {
+	struct adapter *padap = pdbg_init->adap;
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 7);
+
 	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 5);
 }
 
+int cudbg_collect_cim_ibq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 9);
+}
+
+int cudbg_collect_cim_ibq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 10);
+}
+
+int cudbg_collect_cim_ibq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 11);
+}
+
+int cudbg_collect_cim_ibq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 12);
+}
+
+int cudbg_collect_cim_ibq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 13);
+}
+
+int cudbg_collect_cim_ibq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 14);
+}
+
+int cudbg_collect_cim_ibq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_ibq(pdbg_init, dbg_buff, cudbg_err, 15);
+}
+
 u32 cudbg_cim_obq_size(struct adapter *padap, int qid)
 {
 	u32 value;
@@ -1057,20 +1308,38 @@ static int cudbg_read_cim_obq(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err, int qid)
 {
+	struct cim_obq_rev1 *cim_obq_buff;
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
 	int no_of_read_words, rc = 0;
+	u8 coreid = 0;
 	u32 qsize;
 
+	if (qid >= t4_cim_num_obq(padap))
+		return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+	if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+			CUDBG_UP_COREID_PARAM)
+		coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
 	/* collect CIM OBQ */
-	qsize =  cudbg_cim_obq_size(padap, qid);
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, qsize, &temp_buff);
+	qsize = cudbg_cim_obq_size(padap, qid);
+	rc = get_scratch_buff(dbg_buff, sizeof(*cim_obq_buff) + qsize,
+			      &temp_buff);
 	if (rc)
 		return rc;
+	cim_obq_buff = (void *)((u8 *)temp_buff.data + temp_buff.offset);
+	cim_obq_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	cim_obq_buff->ver_hdr.revision = CUDBG_CIM_OBQ_REV;
+	cim_obq_buff->ver_hdr.size = sizeof(*cim_obq_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	cim_obq_buff->qid = qid;
+	cim_obq_buff->coreid = coreid;
 
 	/* t4_read_cim_obq will return no. of read words or error */
-	no_of_read_words = t4_read_cim_obq(padap, qid,
-					   (u32 *)temp_buff.data, qsize);
+	no_of_read_words = t4_read_cim_obq_core(padap, coreid, qid,
+						(u32 *)temp_buff.data, qsize);
+
 	/* no_of_read_words is less than or equal to 0 means error */
 	if (no_of_read_words <= 0) {
 		if (!no_of_read_words)
@@ -1140,6 +1409,55 @@ int cudbg_collect_obq_sge_rx_q1(struct cudbg_init *pdbg_init,
 	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 7);
 }
 
+int cudbg_collect_cim_obq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 9);
+}
+
+int cudbg_collect_cim_obq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 10);
+}
+
+int cudbg_collect_cim_obq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 11);
+}
+
+int cudbg_collect_cim_obq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 12);
+}
+
+int cudbg_collect_cim_obq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 13);
+}
+
+int cudbg_collect_cim_obq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 14);
+}
+
+int cudbg_collect_cim_obq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err)
+{
+	return cudbg_read_cim_obq(pdbg_init, dbg_buff, cudbg_err, 15);
+}
+
 static int cudbg_meminfo_get_mem_index(struct adapter *padap,
 				       struct cudbg_meminfo *mem_info,
 				       u8 mem_type, u8 *idx)
@@ -1231,7 +1549,7 @@ static int cudbg_get_mem_region(struct adapter *padap,
  */
 static int cudbg_get_mem_relative(struct adapter *padap,
 				  struct cudbg_meminfo *meminfo,
-				  u8 mem_type, u32 *out_base, u32 *out_end)
+				  u8 mem_type, u64 *out_base, u64 *out_end)
 {
 	u8 mc_idx;
 	int rc;
@@ -1316,7 +1634,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 	/* Set up initial PCI-E Memory Window to cover the start of our
 	 * transfer.
 	 */
-	t4_memory_update_win(adap, win, pos | win_pf);
+	t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 
 	/* Transfer data from the adapter */
 	while (len > 0) {
@@ -1331,7 +1649,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 		if (offset == mem_aperture) {
 			pos += mem_aperture;
 			offset = 0;
-			t4_memory_update_win(adap, win, pos | win_pf);
+			t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 		}
 	}
 
@@ -1349,7 +1667,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 		if (offset == mem_aperture) {
 			pos += mem_aperture;
 			offset = 0;
-			t4_memory_update_win(adap, win, pos | win_pf);
+			t4_pcie_mem_access_offset_write(adap, pos, win, win_pf);
 		}
 	}
 
@@ -1653,6 +1971,33 @@ int cudbg_collect_hw_sched(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void *cudbg_collect_indir_reg_init(struct cudbg_indir_reg_entity *e,
+					  u16 rev, u32 indir_reg,
+					  u32 indir_data, u32 nentries)
+{
+	struct cudbg_ver_hdr *ver_hdr = &e->ver_hdr;
+
+	ver_hdr->signature = CUDBG_ENTITY_SIGNATURE;
+	ver_hdr->revision = rev;
+	ver_hdr->size = sizeof(*e) - sizeof(*ver_hdr);
+
+	e->indir_reg = indir_reg;
+	e->indir_data = indir_data;
+	e->nentries = nentries;
+	return e;
+}
+
+static void *cudbg_collect_indir_reg_init_next(struct cudbg_indir_reg_entity *e,
+					       u16 rev, u32 indir_reg,
+					       u32 indir_data, u32 nentries)
+{
+	struct cudbg_indir_reg_entity *n;
+
+	n = (void *)((u8 *)e + (sizeof(*e) + sizeof(e->data[0]) * e->nentries));
+	return cudbg_collect_indir_reg_init(n, rev, indir_reg, indir_data,
+					    nentries);
+}
+
 int cudbg_collect_tp_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
@@ -1663,6 +2008,77 @@ int cudbg_collect_tp_indirect(struct cudbg_init *pdbg_init,
 	int i, rc, n = 0;
 	u32 size;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path — new indir reg framework */
+		struct cudbg_indir_reg_entity *tp_tm_entity, *tp_pio_entity;
+		struct cudbg_indir_reg_entity *tp_mib_entity;
+		const struct cudbg_indir_type_entry *tp_tm_arr;
+		const struct cudbg_indir_type_entry *tp_pio_arr;
+		const struct cudbg_indir_type_entry *tp_mib_arr;
+		struct cudbg_indir_reg_data *reg_data;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		tp_tm_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_TM_PIO_ADDR);
+		tp_pio_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_PIO_ADDR);
+		tp_mib_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_TP_MIB_INDEX);
+
+		if (!tp_tm_arr || !tp_pio_arr || !tp_mib_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(*tp_tm_entity) + sizeof(*tp_pio_entity) +
+			sizeof(*tp_mib_entity) + sizeof(*reg_data) *
+			(tp_tm_arr->nentries + tp_pio_arr->nentries +
+			 tp_mib_arr->nentries);
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		tp_tm_entity = cudbg_collect_indir_reg_init((void *)temp_buff.data,
+							    CUDBG_TP_INDIR_REG_REV,
+							    TP_TM_PIO_ADDR_A,
+							    TP_TM_PIO_DATA_A,
+							    tp_tm_arr->nentries);
+
+		tp_pio_entity = cudbg_collect_indir_reg_init_next(tp_tm_entity,
+								  CUDBG_TP_INDIR_REG_REV,
+								  TP_PIO_ADDR_A,
+								  TP_PIO_DATA_A,
+								  tp_pio_arr->nentries);
+
+		tp_mib_entity = cudbg_collect_indir_reg_init_next(tp_pio_entity,
+								  CUDBG_TP_INDIR_REG_REV,
+								  TP_MIB_INDEX_A,
+								  TP_MIB_DATA_A,
+								  tp_mib_arr->nentries);
+
+		reg_data = tp_tm_entity->data;
+		for (i = 0; i < tp_tm_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_tm_arr->reg_arr[i].addr;
+			t4_tp_tm_pio_read(pdbg_init->adap, &reg_data->data, 1,
+					  reg_data->offset, true);
+		}
+
+		reg_data = tp_pio_entity->data;
+		for (i = 0; i < tp_pio_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_pio_arr->reg_arr[i].addr;
+			t4_tp_pio_read(pdbg_init->adap, &reg_data->data, 1,
+				       reg_data->offset, true);
+		}
+
+		reg_data = tp_mib_entity->data;
+		for (i = 0; i < tp_mib_entity->nentries; i++, reg_data++) {
+			reg_data->offset = tp_mib_arr->reg_arr[i].addr;
+			t4_tp_mib_read(pdbg_init->adap, &reg_data->data, 1,
+				       reg_data->offset, true);
+		}
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+				dbg_buff);
+	}
+
+	/* T5/T6 path */
 	if (is_t5(padap->params.chip))
 		n = sizeof(t5_tp_pio_array) +
 		    sizeof(t5_tp_tm_pio_array) +
@@ -2061,6 +2477,37 @@ int cudbg_collect_pcie_indirect(struct cudbg_init *pdbg_init,
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
 
+static void cudbg_collect_indir_reg(struct adapter *padap,
+				    struct cudbg_indir_reg_entity *e,
+				    const struct cudbg_indir_type_entry *arr,
+				    u16 rev, u32 indir_reg, u32 indir_data)
+{
+	struct cudbg_indir_reg_entity *entity;
+	struct cudbg_indir_reg_data *reg_data;
+	u32 i;
+
+	entity = cudbg_collect_indir_reg_init(e, rev, indir_reg, indir_data,
+					      arr->nentries);
+	reg_data = entity->data;
+	for (i = 0; i < entity->nentries; i++, reg_data++) {
+		reg_data->offset = arr->reg_arr[i].addr;
+		t4_read_indirect(padap, entity->indir_reg, entity->indir_data,
+				 &reg_data->data, 1, reg_data->offset);
+	}
+}
+
+static void
+cudbg_collect_indir_reg_next(struct adapter *padap,
+			     struct cudbg_indir_reg_entity *e,
+			     const struct cudbg_indir_type_entry *arr, u16 rev,
+			     u32 indir_reg, u32 indir_data)
+{
+	struct cudbg_indir_reg_entity *n;
+
+	n = (void *)((u8 *)e + (sizeof(*e) + sizeof(e->data[0]) * e->nentries));
+	cudbg_collect_indir_reg(padap, n, arr, rev, indir_reg, indir_data);
+}
+
 int cudbg_collect_pm_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_buffer *dbg_buff,
 			      struct cudbg_error *cudbg_err)
@@ -2071,6 +2518,46 @@ int cudbg_collect_pm_indirect(struct cudbg_init *pdbg_init,
 	int i, rc, n;
 	u32 size;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path — new indir reg framework */
+		const struct cudbg_indir_type_entry *pm_rx_arr, *pm_tx_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		pm_rx_arr = cudbg_get_indir_reg_info(chip_ver,
+						     CUDBG_INDIR_TYPE_PM_RX_DBG_CTRL);
+		pm_tx_arr = cudbg_get_indir_reg_info(chip_ver,
+						     CUDBG_INDIR_TYPE_PM_TX_DBG_CTRL);
+
+		if (!pm_rx_arr || !pm_tx_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) *
+			pm_rx_arr->nentries;
+		size += sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) *
+			pm_tx_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					pm_rx_arr, CUDBG_PM_INDIR_REG_REV,
+					PM_RX_DBG_CTRL_A,
+					PM_RX_DBG_CTRL_A + 4);
+
+		cudbg_collect_indir_reg_next(padap, (void *)temp_buff.data,
+					     pm_tx_arr, CUDBG_PM_INDIR_REG_REV,
+					     PM_TX_DBG_CTRL_A,
+					     PM_TX_DBG_CTRL_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T5/T6 path */
 	n = sizeof(t5_pm_rx_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n * 2;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
@@ -2255,7 +2742,7 @@ static int cudbg_sge_ctxt_check_valid(u32 *buf, int type)
 	return buf[index] & (1U << bit);
 }
 
-static int cudbg_get_ctxt_region_info(struct adapter *padap,
+static int cudbg_get_ctxt_region_info(struct adapter *padap, u8 sge_ctxt_size,
 				      struct cudbg_region_info *ctx_info,
 				      u8 *mem_type)
 {
@@ -2303,7 +2790,7 @@ static int cudbg_get_ctxt_region_info(struct adapter *padap,
 	/* Get number of data freelist queues */
 	flq = HDRSTARTFLQ_G(value);
 	ctx_info[CTXT_FLM].exist = true;
-	ctx_info[CTXT_FLM].end = (CUDBG_MAX_FL_QIDS >> flq) * SGE_CTXT_SIZE;
+	ctx_info[CTXT_FLM].end = (CUDBG_MAX_FL_QIDS >> flq) * sge_ctxt_size;
 
 	/* The number of CONM contexts are same as number of freelist
 	 * queues.
@@ -2314,7 +2801,7 @@ static int cudbg_get_ctxt_region_info(struct adapter *padap,
 	return 0;
 }
 
-int cudbg_dump_context_size(struct adapter *padap)
+int cudbg_dump_context_size(struct adapter *padap, u8 sge_ctxt_size)
 {
 	struct cudbg_region_info region_info[CTXT_CNM + 1] = { {0} };
 	u8 mem_type[CTXT_INGRESS + 1] = { 0 };
@@ -2322,7 +2809,7 @@ int cudbg_dump_context_size(struct adapter *padap)
 	int rc;
 
 	/* Get max valid qid for each type of queue */
-	rc = cudbg_get_ctxt_region_info(padap, region_info, mem_type);
+	rc = cudbg_get_ctxt_region_info(padap, sge_ctxt_size, region_info, mem_type);
 	if (rc)
 		return rc;
 
@@ -2330,14 +2817,14 @@ int cudbg_dump_context_size(struct adapter *padap)
 		if (!region_info[i].exist) {
 			if (i == CTXT_EGRESS || i == CTXT_INGRESS)
 				size += CUDBG_LOWMEM_MAX_CTXT_QIDS *
-					SGE_CTXT_SIZE;
+					sge_ctxt_size;
 			continue;
 		}
 
 		size += (region_info[i].end - region_info[i].start + 1) /
-			SGE_CTXT_SIZE;
+			sge_ctxt_size;
 	}
-	return size * sizeof(struct cudbg_ch_cntxt);
+	return size * sizeof(struct struct_sge_ctxt_rev1_data);
 }
 
 static void cudbg_read_sge_ctxt(struct cudbg_init *pdbg_init, u32 cid,
@@ -2359,13 +2846,14 @@ static void cudbg_read_sge_ctxt(struct cudbg_init *pdbg_init, u32 cid,
 		t4_sge_ctxt_rd_bd(padap, cid, ctype, data);
 }
 
-static void cudbg_get_sge_ctxt_fw(struct cudbg_init *pdbg_init, u32 max_qid,
-				  u8 ctxt_type,
-				  struct cudbg_ch_cntxt **out_buff)
+static u32 cudbg_get_sge_ctxt_fw(struct cudbg_init *pdbg_init, u8 sge_ctxt_size,
+				 u32 max_qid, u8 ctxt_type,
+				 struct struct_sge_ctxt_rev1 *ctxt_buff,
+				 struct struct_sge_ctxt_rev1_data **out_buff)
 {
-	struct cudbg_ch_cntxt *buff = *out_buff;
+	struct struct_sge_ctxt_rev1_data *buff = *out_buff;
+	u32 j, total_size = 0;
 	int rc;
-	u32 j;
 
 	for (j = 0; j < max_qid; j++) {
 		cudbg_read_sge_ctxt(pdbg_init, j, ctxt_type, buff->data);
@@ -2373,18 +2861,25 @@ static void cudbg_get_sge_ctxt_fw(struct cudbg_init *pdbg_init, u32 max_qid,
 		if (!rc)
 			continue;
 
-		buff->cntxt_type = ctxt_type;
-		buff->cntxt_id = j;
+		buff->ctxt_type = ctxt_type;
+		buff->ctxt_id = j;
+		buff->size = sge_ctxt_size;
+		total_size += sizeof(*buff);
+		ctxt_buff->nentries++;
 		buff++;
 		if (ctxt_type == CTXT_FLM) {
 			cudbg_read_sge_ctxt(pdbg_init, j, CTXT_CNM, buff->data);
-			buff->cntxt_type = CTXT_CNM;
-			buff->cntxt_id = j;
+			buff->ctxt_type = CTXT_CNM;
+			buff->ctxt_id = j;
+			buff->size = sge_ctxt_size;
+			total_size += sizeof(*buff);
+			ctxt_buff->nentries++;
 			buff++;
 		}
 	}
 
 	*out_buff = buff;
+	return total_size;
 }
 
 int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
@@ -2393,27 +2888,40 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 {
 	struct cudbg_region_info region_info[CTXT_CNM + 1] = { {0} };
 	struct adapter *padap = pdbg_init->adap;
-	u32 j, size, max_ctx_size, max_ctx_qid;
+	struct struct_sge_ctxt_rev1 *ctxt_buff;
+	struct struct_sge_ctxt_rev1_data *buff;
+	u32 j, size, max_ctx_size, max_ctx_qid, total_size = 0;
 	u8 mem_type[CTXT_INGRESS + 1] = { 0 };
 	struct cudbg_buffer temp_buff = { 0 };
-	struct cudbg_ch_cntxt *buff;
+	u8 i, k, sge_ctxt_size;
 	u8 *ctx_buf;
-	u8 i, k;
 	int rc;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7)
+		sge_ctxt_size = SGE_CTXT_SIZE_T7;
+	else
+		sge_ctxt_size = SGE_CTXT_SIZE;
+
 	/* Get max valid qid for each type of queue */
-	rc = cudbg_get_ctxt_region_info(padap, region_info, mem_type);
+	rc = cudbg_get_ctxt_region_info(padap, sge_ctxt_size, region_info, mem_type);
 	if (rc)
 		return rc;
 
-	rc = cudbg_dump_context_size(padap);
+	rc = cudbg_dump_context_size(padap, sge_ctxt_size);
 	if (rc <= 0)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
 	size = rc;
-	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+	rc = get_scratch_buff(dbg_buff, size + sizeof(*ctxt_buff), &temp_buff);
 	if (rc)
 		return rc;
+	ctxt_buff = (void *)temp_buff.data;
+	ctxt_buff->ver_hdr.signature = CUDBG_ENTITY_SIGNATURE;
+	ctxt_buff->ver_hdr.revision = CUDBG_SGE_CTXT_REV;
+	ctxt_buff->ver_hdr.size = sizeof(*ctxt_buff) -
+		sizeof(struct cudbg_ver_hdr);
+	ctxt_buff->nentries = 0;
+	total_size = sizeof(*ctxt_buff);
 
 	/* Get buffer with enough space to read the biggest context
 	 * region in memory.
@@ -2429,7 +2937,7 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 		return -ENOMEM;
 	}
 
-	buff = (struct cudbg_ch_cntxt *)temp_buff.data;
+	buff = (void *)ctxt_buff->data;
 
 	/* Collect EGRESS and INGRESS context data.
 	 * In case of failures, fallback to collecting via FW or
@@ -2438,13 +2946,13 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 	for (i = CTXT_EGRESS; i <= CTXT_INGRESS; i++) {
 		if (!region_info[i].exist) {
 			max_ctx_qid = CUDBG_LOWMEM_MAX_CTXT_QIDS;
-			cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, i,
-					      &buff);
+			cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, i,
+					      ctxt_buff, &buff);
 			continue;
 		}
 
 		max_ctx_size = region_info[i].end - region_info[i].start + 1;
-		max_ctx_qid = max_ctx_size / SGE_CTXT_SIZE;
+		max_ctx_qid = max_ctx_size / sge_ctxt_size;
 
 		/* If firmware is not attached/alive, use backdoor register
 		 * access to collect dump.
@@ -2459,8 +2967,8 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 
 		if (rc || !is_fw_attached(pdbg_init)) {
 			max_ctx_qid = CUDBG_LOWMEM_MAX_CTXT_QIDS;
-			cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, i,
-					      &buff);
+			cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, i,
+					      ctxt_buff, &buff);
 			continue;
 		}
 
@@ -2468,21 +2976,24 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 			__be64 *dst_off;
 			u64 *src_off;
 
-			src_off = (u64 *)(ctx_buf + j * SGE_CTXT_SIZE);
+			src_off = (u64 *)(ctx_buf + j * sge_ctxt_size);
 			dst_off = (__be64 *)buff->data;
 
 			/* The data is stored in 64-bit cpu order.  Convert it
 			 * to big endian before parsing.
 			 */
-			for (k = 0; k < SGE_CTXT_SIZE / sizeof(u64); k++)
+			for (k = 0; k < sge_ctxt_size / sizeof(u64); k++)
 				dst_off[k] = cpu_to_be64(src_off[k]);
 
 			rc = cudbg_sge_ctxt_check_valid(buff->data, i);
 			if (!rc)
 				continue;
 
-			buff->cntxt_type = i;
-			buff->cntxt_id = j;
+			buff->ctxt_type = i;
+			buff->ctxt_id = j;
+			buff->size = sge_ctxt_size;
+			total_size += sizeof(*buff);
+			ctxt_buff->nentries++;
 			buff++;
 		}
 	}
@@ -2492,11 +3003,11 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 	/* Collect FREELIST and CONGESTION MANAGER contexts */
 	max_ctx_size = region_info[CTXT_FLM].end -
 		       region_info[CTXT_FLM].start + 1;
-	max_ctx_qid = max_ctx_size / SGE_CTXT_SIZE;
+	max_ctx_qid = max_ctx_size / sge_ctxt_size;
 	/* Since FLM and CONM are 1-to-1 mapped, the below function
 	 * will fetch both FLM and CONM contexts.
 	 */
-	cudbg_get_sge_ctxt_fw(pdbg_init, max_ctx_qid, CTXT_FLM, &buff);
+	cudbg_get_sge_ctxt_fw(pdbg_init, sge_ctxt_size, max_ctx_qid, CTXT_FLM, ctxt_buff, &buff);
 
 	return cudbg_write_and_release_buff(pdbg_init, &temp_buff, dbg_buff);
 }
@@ -2544,7 +3055,72 @@ static int cudbg_collect_tcam_index(struct cudbg_init *pdbg_init,
 	u32 ctl, data2;
 	int rc = 0;
 
-	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T6) {
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* CtlReqID   - 1: use Host Driver Requester ID
+		 * CtlCmdType - 0: Read, 1: Write
+		 * CtlXYBitSel- 0: Y bit, 1: X bit
+		 ####### for T6 ######
+		 * CtlTcamSel     -   26:25    Control bit. 0: TCAM0, 1: TCAM1.
+		 * CtlTcamIndex   -   24:17    Control bits. Index of TCAM location to be accessed.
+
+		 ####### for T7B ######
+		 * CtlTcamSel     -   27:26    Control bit. 0: TCAM0, 1: TCAM1, 2: TCAM2.
+		 * CtlTcamIndex   -   25:17    Control bits. Index of TCAM location to be accessed.
+		 */
+
+		/* Read tcamy */
+		ctl = (CTLREQID_V(1) | CTLCMDTYPE_V(0) | CTLXYBITSEL_V(0));
+		if (idx < 512)
+			ctl |= T7_1_CTLTCAMINDEX_V(idx) | T7_CTLTCAMSEL_V(0);
+		else if (idx < 1024)
+			ctl |= T7_1_CTLTCAMINDEX_V(idx - 512) |
+				T7_CTLTCAMSEL_V(1);
+		else /* idx 1024 to 1535 */
+			ctl |= T7_1_CTLTCAMINDEX_V(idx - 1024) |
+				T7_CTLTCAMSEL_V(2);
+
+		t4_write_reg(padap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+		val = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+		tcamy = DMACH_G(val) << 32;
+		tcamy |= t4_read_reg(padap, MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+		data2 = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+		tcam->lookup_type = DATALKPTYPE_G(data2);
+
+		/* 0 - Outer header, 1 - Inner header
+		 * [71:48] bit locations are overloaded for
+		 * outer vs. inner lookup types.
+		 */
+		if (tcam->lookup_type &&
+		    tcam->lookup_type != DATALKPTYPE_M) {
+			/* Inner header VNI */
+			tcam->vniy =
+				(((data2 & DATAVIDH2_F) | (DATAVIDH1_G(data2)))
+				 << 16) |
+				VIDL_G(val);
+			tcam->dip_hit = data2 & DATADIPHIT_F;
+		} else {
+			tcam->vlan_vld = data2 & DATAVIDH2_F;
+			tcam->ivlan = VIDL_G(val);
+		}
+
+		tcam->port_num = DATAPORTNUM_G(data2);
+
+		/* Read tcamx. Change the control param */
+		ctl |= CTLXYBITSEL_V(1);
+		t4_write_reg(padap, MPS_CLS_TCAM_DATA2_CTL_A, ctl);
+		val = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA1_REQ_ID1_A);
+		tcamx = DMACH_G(val) << 32;
+		tcamx |= t4_read_reg(padap, MPS_CLS_TCAM0_RDATA0_REQ_ID1_A);
+		data2 = t4_read_reg(padap, MPS_CLS_TCAM0_RDATA2_REQ_ID1_A);
+		if (tcam->lookup_type &&
+		    tcam->lookup_type != DATALKPTYPE_M) {
+			/* Inner header VNI mask */
+			tcam->vnix =
+				(((data2 & DATAVIDH2_F) | (DATAVIDH1_G(data2)))
+				 << 16) |
+				VIDL_G(val);
+		}
+	} else if (CHELSIO_CHIP_VERSION(padap->params.chip) > CHELSIO_T5) {
 		/* CtlReqID   - 1: use Host Driver Requester ID
 		 * CtlCmdType - 0: Read, 1: Write
 		 * CtlTcamSel - 0: TCAM0, 1: TCAM1
@@ -2602,13 +3178,24 @@ static int cudbg_collect_tcam_index(struct cudbg_init *pdbg_init,
 	if (tcamx & tcamy)
 		return rc;
 
-	tcam->cls_lo = t4_read_reg(padap, MPS_CLS_SRAM_L(idx));
-	tcam->cls_hi = t4_read_reg(padap, MPS_CLS_SRAM_H(idx));
+	/* t7b changes MPS_T5_CLS_SRAM_H_A to indirect register */
+	if (is_t7(padap->params.chip)) {
+		u32 tmp_ctl = 0;
 
-	if (is_t5(padap->params.chip))
-		tcam->repli = (tcam->cls_lo & REPLICATE_F);
-	else if (is_t6(padap->params.chip))
+		tmp_ctl |= SRAMWRN_V(0) |
+			SRAMINDEX_V(idx & SRAMINDEX_M);
+		t4_write_reg(padap, MPS_T5_CLS_SRAM_H_A, tmp_ctl);
+		tcam->cls_lo = t4_read_reg(padap, MPS_T5_CLS_SRAM_L_A);
+		tcam->cls_hi = t4_read_reg(padap, MPS_T5_CLS_SRAM_H_A);
+	} else {
+		tcam->cls_lo = t4_read_reg(padap, MPS_CLS_SRAM_L(idx));
+		tcam->cls_hi = t4_read_reg(padap, MPS_CLS_SRAM_H(idx));
+	}
+
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) > CHELSIO_T5)
 		tcam->repli = (tcam->cls_lo & T6_REPLICATE_F);
+	else
+		tcam->repli = (tcam->cls_lo & REPLICATE_F);
 
 	if (tcam->repli) {
 		struct fw_ldst_cmd ldst_cmd;
@@ -2966,20 +3553,62 @@ int cudbg_collect_ma_indirect(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct ireg_buf *ma_indr;
-	int i, rc, n;
-	u32 size, j;
+	int i, j, rc, n;
+	u32 size;
 
 	if (CHELSIO_CHIP_VERSION(padap->params.chip) < CHELSIO_T6)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path — new indir reg framework */
+		const struct cudbg_indir_type_entry *ma_arr, *ma_perf_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		ma_arr = cudbg_get_indir_reg_info(chip_ver,
+						  CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_CFG);
+		ma_perf_arr = cudbg_get_indir_reg_info(chip_ver,
+						       CUDBG_INDIR_TYPE_MA_LOCAL_DEBUG_PERF_CFG);
+
+		if (!ma_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+			sizeof(struct cudbg_indir_reg_data) * ma_arr->nentries;
+
+		if (ma_perf_arr)
+			size += sizeof(struct cudbg_indir_reg_entity) +
+				sizeof(struct cudbg_indir_reg_data) *
+				ma_perf_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					ma_arr, CUDBG_MA_INDIR_REG_REV,
+					MA_LOCAL_DEBUG_CFG_A,
+					MA_LOCAL_DEBUG_CFG_A + 4);
+
+		if (ma_perf_arr)
+			cudbg_collect_indir_reg_next(padap, (void *)temp_buff.data, ma_perf_arr,
+						     CUDBG_MA_INDIR_REG_REV,
+						     MA_LOCAL_DEBUG_PERF_CFG_A,
+						     MA_LOCAL_DEBUG_PERF_CFG_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T6 path */
 	n = sizeof(t6_ma_ireg_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n * 2;
+
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	ma_indr = (struct ireg_buf *)temp_buff.data;
+	struct ireg_buf *ma_indr = (struct ireg_buf *)temp_buff.data;
 	for (i = 0; i < n; i++) {
 		struct ireg_field *ma_fli = &ma_indr->tp_pio;
 		u32 *buff = ma_indr->outbuf;
@@ -3094,9 +3723,67 @@ int cudbg_collect_up_cim_indirect(struct cudbg_init *pdbg_init,
 	else if (is_t6(padap->params.chip))
 		n = sizeof(t6_up_cim_reg_array) /
 		    ((IREG_NUM_ELEM + 1) * sizeof(u32));
-	else
+	else if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path — new indir reg framework */
+		const struct cudbg_indir_type_entry *cim_arr, *up_arr;
+		struct cudbg_indir_reg_entity *cim_entity, *up_entity;
+		struct cudbg_indir_reg_data *reg_data;
+		u8 coreid = 0, groupid = 0;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		cim_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_CIM_CTL);
+		up_arr = cudbg_get_indir_reg_info(chip_ver, CUDBG_INDIR_TYPE_UP);
+
+		if (!cim_arr || !up_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		if (pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].param_type ==
+				CUDBG_UP_COREID_PARAM)
+			coreid = pdbg_init->dbg_params[CUDBG_UP_COREID_PARAM].u.coreid;
+
+		size = sizeof(*cim_entity) + sizeof(*up_entity) +
+		       sizeof(*reg_data) * (cim_arr->nentries + up_arr->nentries);
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cim_entity = cudbg_collect_indir_reg_init((void *)temp_buff.data,
+							  CUDBG_UP_CIM_INDIR_REG_REV,
+							  CIM_HOST_ACC_CTRL_A,
+							  CIM_HOST_ACC_DATA_A,
+							  cim_arr->nentries);
+
+		up_entity = cudbg_collect_indir_reg_init_next(cim_entity,
+							      CUDBG_UP_CIM_INDIR_REG_REV,
+							      CIM_HOST_ACC_CTRL_A,
+							      CIM_HOST_ACC_DATA_A,
+							      up_arr->nentries);
+
+		reg_data = cim_entity->data;
+		for (i = 0; i < cim_entity->nentries; i++, reg_data++) {
+			reg_data->offset = cim_arr->reg_arr[i].addr;
+			t4_cim_read_core(padap, groupid, coreid,
+					 reg_data->offset, 1, &reg_data->data);
+		}
+
+		groupid = 1; /* T7 UP uses groupid 1 */
+
+		reg_data = up_entity->data;
+		for (i = 0; i < up_entity->nentries; i++, reg_data++) {
+			reg_data->offset = up_arr->reg_arr[i].addr;
+			t4_cim_read_core(padap, groupid, coreid,
+					 reg_data->offset, 1, &reg_data->data);
+		}
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	} else {
 		return CUDBG_STATUS_NOT_IMPLEMENTED;
+	}
 
+	/* T5/T6 path */
 	size = sizeof(struct ireg_buf) * n;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
@@ -3275,20 +3962,47 @@ int cudbg_collect_hma_indirect(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_buffer temp_buff = { 0 };
-	struct ireg_buf *hma_indr;
 	int i, rc, n;
 	u32 size;
 
 	if (CHELSIO_CHIP_VERSION(padap->params.chip) < CHELSIO_T6)
 		return CUDBG_STATUS_ENTITY_NOT_FOUND;
 
+	if (CHELSIO_CHIP_VERSION(padap->params.chip) >= CHELSIO_T7) {
+		/* T7 path — new indir reg framework */
+		const struct cudbg_indir_type_entry *hma_arr;
+		u32 chip_ver;
+
+		chip_ver = CHELSIO_CHIP_VERSION(padap->params.chip);
+		hma_arr = cudbg_get_indir_reg_info(chip_ver,
+						   CUDBG_INDIR_TYPE_HMAT6_LOCAL_DEBUG_CFG);
+		if (!hma_arr)
+			return CUDBG_STATUS_ENTITY_NOT_FOUND;
+
+		size = sizeof(struct cudbg_indir_reg_entity) +
+		       sizeof(struct cudbg_indir_reg_data) * hma_arr->nentries;
+
+		rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
+		if (rc)
+			return rc;
+
+		cudbg_collect_indir_reg(padap, (void *)temp_buff.data,
+					hma_arr, CUDBG_HMA_INDIR_REG_REV,
+					HMA_LOCAL_DEBUG_CFG_A,
+					HMA_LOCAL_DEBUG_CFG_A + 4);
+
+		return cudbg_write_and_release_buff(pdbg_init, &temp_buff,
+						    dbg_buff);
+	}
+
+	/* T6 path */
 	n = sizeof(t6_hma_ireg_array) / (IREG_NUM_ELEM * sizeof(u32));
 	size = sizeof(struct ireg_buf) * n;
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, size, &temp_buff);
 	if (rc)
 		return rc;
 
-	hma_indr = (struct ireg_buf *)temp_buff.data;
+	struct ireg_buf *hma_indr = (struct ireg_buf *)temp_buff.data;
 	for (i = 0; i < n; i++) {
 		struct ireg_field *hma_fli = &hma_indr->tp_pio;
 		u32 *buff = hma_indr->outbuf;
@@ -3581,7 +4295,7 @@ int cudbg_collect_flash(struct cudbg_init *pdbg_init,
 	u32 addr, i;
 	int rc;
 
-	addr = FLASH_EXP_ROM_START;
+	addr = FLASH_LOC_EXP_ROM;
 
 	for (i = 0; i < count; i += SF_PAGE_SIZE) {
 		n = min_t(u32, count - i, SF_PAGE_SIZE);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
index d6d6cd298930..debc9fa630ee 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h
@@ -165,13 +165,61 @@ int cudbg_collect_qdesc(struct cudbg_init *pdbg_init,
 int cudbg_collect_flash(struct cudbg_init *pdbg_init,
 			struct cudbg_buffer *dbg_buff,
 			struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_tp2(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_tp3(struct cudbg_init *pdbg_init,
+			      struct cudbg_buffer *dbg_buff,
+			      struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_ibq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc1(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc2(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc3(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc4(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc5(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc6(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
+int cudbg_collect_cim_obq_ipc7(struct cudbg_init *pdbg_init,
+			       struct cudbg_buffer *dbg_buff,
+			       struct cudbg_error *cudbg_err);
 
 u32 cudbg_get_entity_length(struct adapter *adap, u32 entity);
 struct cudbg_entity_hdr *cudbg_get_entity_hdr(void *outbuf, int i);
 void cudbg_align_debug_buffer(struct cudbg_buffer *dbg_buff,
 			      struct cudbg_entity_hdr *entity_hdr);
 u32 cudbg_cim_obq_size(struct adapter *padap, int qid);
-int cudbg_dump_context_size(struct adapter *padap);
+int cudbg_dump_context_size(struct adapter *padap, u8 sge_ctxt_size);
 
 int cudbg_fill_meminfo(struct adapter *padap,
 		       struct cudbg_meminfo *meminfo_buff);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
index dd66b244466d..08597b9e99cf 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -64,6 +64,22 @@ static const struct cxgb4_collect_entity cxgb4_collect_hw_dump[] = {
 	{ CUDBG_UP_CIM_INDIRECT, cudbg_collect_up_cim_indirect },
 	{ CUDBG_PBT_TABLE, cudbg_collect_pbt_tables },
 	{ CUDBG_HMA_INDIRECT, cudbg_collect_hma_indirect },
+	{ CUDBG_CIM_IBQ_TP2, cudbg_collect_cim_ibq_tp2 },
+	{ CUDBG_CIM_IBQ_TP3, cudbg_collect_cim_ibq_tp3 },
+	{ CUDBG_CIM_IBQ_IPC1, cudbg_collect_cim_ibq_ipc1 },
+	{ CUDBG_CIM_IBQ_IPC2, cudbg_collect_cim_ibq_ipc2 },
+	{ CUDBG_CIM_IBQ_IPC3, cudbg_collect_cim_ibq_ipc3 },
+	{ CUDBG_CIM_IBQ_IPC4, cudbg_collect_cim_ibq_ipc4 },
+	{ CUDBG_CIM_IBQ_IPC5, cudbg_collect_cim_ibq_ipc5 },
+	{ CUDBG_CIM_IBQ_IPC6, cudbg_collect_cim_ibq_ipc6 },
+	{ CUDBG_CIM_IBQ_IPC7, cudbg_collect_cim_ibq_ipc7 },
+	{ CUDBG_CIM_OBQ_IPC1, cudbg_collect_cim_obq_ipc1 },
+	{ CUDBG_CIM_OBQ_IPC2, cudbg_collect_cim_obq_ipc2 },
+	{ CUDBG_CIM_OBQ_IPC3, cudbg_collect_cim_obq_ipc3 },
+	{ CUDBG_CIM_OBQ_IPC4, cudbg_collect_cim_obq_ipc4 },
+	{ CUDBG_CIM_OBQ_IPC5, cudbg_collect_cim_obq_ipc5 },
+	{ CUDBG_CIM_OBQ_IPC6, cudbg_collect_cim_obq_ipc6 },
+	{ CUDBG_CIM_OBQ_IPC7, cudbg_collect_cim_obq_ipc7 },
 };
 
 static const struct cxgb4_collect_entity cxgb4_collect_flash_dump[] = {
-- 
2.39.1


