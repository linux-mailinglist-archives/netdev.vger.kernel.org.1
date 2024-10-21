Return-Path: <netdev+bounces-137589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBE9A715D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DAA2811C0
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1931F4FA0;
	Mon, 21 Oct 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KRKQw0NE"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D51EF95D;
	Mon, 21 Oct 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532987; cv=none; b=NveKRmIzSwpC1NViul4mC8n2t6xwkXzOmdEqRkuamYUqYfqAsLlHTlOQqGSPGpACO0mm41OHA6srv7A8ZAoy7WtA+nhUpejQ9+gsxQQM5hP3Hgg7BVp/lVJ84kXprtiPmqOQEImbip2BJ/MFZORUbYyyPwP0T3p1CrgaWsBx1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532987; c=relaxed/simple;
	bh=cIOY9k3U+XtnmCFrMCuzDQOHn58IDa4qbSpk9USMOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZrEmg7F+ygQU3+BipImp+5yWcTqYa1WA+lwhRMx/RC6/qA351txKUYcj2CyYaf+1PvhwA8K6D6YkGM79fI+gcKaTjM3Muw1RT3J9Nrgb7UiJMN/82bEjJczA6Qc1bR04zfQOPcm0WdkcU/TKnmqlBkx0+4qy9joZqdRD8FQRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KRKQw0NE; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B723BC0000E3;
	Mon, 21 Oct 2024 10:49:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B723BC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729532978;
	bh=cIOY9k3U+XtnmCFrMCuzDQOHn58IDa4qbSpk9USMOBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRKQw0NEVKXnIRjdSsNcuQFQySKocuq90JDYB3Puk3NQvP4JoPjJ1O/TLMQ3QYsT/
	 ndBEnHJy5VVmq+wkh/ngvVLv/FXKmgbJ9gBgYtvsdQ9y/ihwH3e0SJJhJflCl6bH71
	 kubHAzG0GlPROBPyg5YsMH0LLFazpe4vbA4IMEXk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 57A7218041CAD2;
	Mon, 21 Oct 2024 10:49:38 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:)
Subject: [PATCH net-next v2 2/2] net: systemport: Move IO macros to header file
Date: Mon, 21 Oct 2024 10:49:35 -0700
Message-ID: <20241021174935.57658-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021174935.57658-1-florian.fainelli@broadcom.com>
References: <20241021174935.57658-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the BCM_SYSPORT_IO_MACRO() definition and its use to bcmsysport.h
where it is more appropriate and where static inline helpers are
acceptable. While at it, make sure that the macro 'offset' argument does
not trigger a checkpatch warning due to possible argument re-use.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 22 ---------------------
 drivers/net/ethernet/broadcom/bcmsysport.h | 23 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 9e42b5db721e..caff6e87a488 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -27,28 +27,6 @@
 
 #include "bcmsysport.h"
 
-/* I/O accessors register helpers */
-#define BCM_SYSPORT_IO_MACRO(name, offset) \
-static inline u32 name##_readl(struct bcm_sysport_priv *priv, u32 off)	\
-{									\
-	u32 reg = readl_relaxed(priv->base + offset + off);		\
-	return reg;							\
-}									\
-static inline void name##_writel(struct bcm_sysport_priv *priv,		\
-				  u32 val, u32 off)			\
-{									\
-	writel_relaxed(val, priv->base + offset + off);			\
-}									\
-
-BCM_SYSPORT_IO_MACRO(intrl2_0, SYS_PORT_INTRL2_0_OFFSET);
-BCM_SYSPORT_IO_MACRO(intrl2_1, SYS_PORT_INTRL2_1_OFFSET);
-BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
-BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
-BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
-BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
-BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
-BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
-
 /* On SYSTEMPORT Lite, any register after RDMA_STATUS has the exact
  * same layout, except it has been moved by 4 bytes up, *sigh*
  */
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index 335cf6631db5..a34296f989f1 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -773,4 +773,27 @@ struct bcm_sysport_priv {
 	struct bcm_sysport_tx_ring *ring_map[DSA_MAX_PORTS * 8];
 
 };
+
+/* I/O accessors register helpers */
+#define BCM_SYSPORT_IO_MACRO(name, offset) \
+static inline u32 name##_readl(struct bcm_sysport_priv *priv, u32 off)	\
+{									\
+	u32 reg = readl_relaxed(priv->base + (offset) + off);		\
+	return reg;							\
+}									\
+static inline void name##_writel(struct bcm_sysport_priv *priv,		\
+				  u32 val, u32 off)			\
+{									\
+	writel_relaxed(val, priv->base + (offset) + off);		\
+}									\
+
+BCM_SYSPORT_IO_MACRO(intrl2_0, SYS_PORT_INTRL2_0_OFFSET);
+BCM_SYSPORT_IO_MACRO(intrl2_1, SYS_PORT_INTRL2_1_OFFSET);
+BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
+BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
+BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
+BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
+BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
+BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
+
 #endif /* __BCM_SYSPORT_H */
-- 
2.43.0


