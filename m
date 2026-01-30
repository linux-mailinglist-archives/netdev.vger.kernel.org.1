Return-Path: <netdev+bounces-255159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JM/C/i7fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:11:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C93DBBB77F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 150353013EE0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A9322B8F;
	Fri, 30 Jan 2026 14:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC0321457
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782249; cv=none; b=QbMB6ekZG7I+3zG01mpTUjzXtRHBjOt41LVRLvntXZaTXlQH7yyVmB+Xx6OFc+kCWncsRNcJGuBD5GK3ggym00kuX2VIUmhzOaiNe4BcnC+qZzhVx53IZNLcKJxFenA9ri24cBb13iwNDbkri4MnRi6C2cy0W/SIPwYIUHiuZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782249; c=relaxed/simple;
	bh=1YPPUWQxs5uySAkIkFuVYtnkZqL6uv7puXvg1S0nnsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLuSto4tX4M8RYp21m6JP0bP3cJLI41zFOABdF0qcJ6yzL1t1o64eoQMx+SKYzVKCAQ5fTZ0BoenJHaTiT5FAwnUVmMG6HO8iu33KxfsGBgC8G77IbO87nFIXHKYZ6M6uPKouOxPreZzvLLXfapWzCeHJ6jaeSzpY2n2Yp4dIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD0720070B;
	Fri, 30 Jan 2026 15:10:41 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 81DED2006CD;
	Fri, 30 Jan 2026 15:10:41 +0100 (CET)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EEEE20263;
	Fri, 30 Jan 2026 15:10:40 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 4/4] net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4
Date: Fri, 30 Jan 2026 16:10:35 +0200
Message-Id: <20260130141035.272471-5-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130141035.272471-1-claudiu.manoil@nxp.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255159-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: C93DBBB77F
X-Rspamd-Action: no action

It is not recommended to access the 32‑bit registers of this hardware IP
using lower‑width accessors (i.e. 16‑bit), and the only exception to
this rule was introduced in the initial ENETC v1 driver for the PMAR1
register, which holds the lower 16 bits of the primary MAC address of
an SI. Meanwhile, this exception has been replicated in the v4 driver
code as well.

Since LS1028 (the only SoC with ENETC v1) is not affected by this issue,
the current patch converts the 16‑bit reads from PMAR1 starting with
ENETC v4.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c    |  2 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index c0859d200a2c..5850540634b0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -73,7 +73,7 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	u16 lower;
 
 	upper = __raw_readl(hw->port + ENETC4_PSIPMAR0(si));
-	lower = __raw_readw(hw->port + ENETC4_PSIPMAR1(si));
+	lower = __raw_readl(hw->port + ENETC4_PSIPMAR1(si));
 
 	put_unaligned_le32(upper, addr);
 	put_unaligned_le16(lower, addr + 4);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7b882b8921fe..662e4fbafb74 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -708,13 +708,24 @@ struct enetc_cmd_rfse {
 #define ENETC_RFSE_EN	BIT(15)
 #define ENETC_RFSE_MODE_BD	2
 
+static inline void enetc_get_primary_mac_addr(struct enetc_hw *hw, u8 *addr)
+{
+	u32 upper;
+	u16 lower;
+
+	upper = __raw_readl(hw->reg + ENETC_SIPMAR0);
+	lower = __raw_readl(hw->reg + ENETC_SIPMAR1);
+
+	put_unaligned_le32(upper, addr);
+	put_unaligned_le16(lower, addr + 4);
+}
+
 static inline void enetc_load_primary_mac_addr(struct enetc_hw *hw,
 					       struct net_device *ndev)
 {
-	u8 addr[ETH_ALEN] __aligned(4);
+	u8 addr[ETH_ALEN];
 
-	*(u32 *)addr = __raw_readl(hw->reg + ENETC_SIPMAR0);
-	*(u16 *)(addr + 4) = __raw_readw(hw->reg + ENETC_SIPMAR1);
+	enetc_get_primary_mac_addr(hw, addr);
 	eth_hw_addr_set(ndev, addr);
 }
 
-- 
2.34.1


