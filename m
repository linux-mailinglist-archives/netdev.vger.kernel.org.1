Return-Path: <netdev+bounces-135805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED099F3FA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F6D2833EE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E71FAEE0;
	Tue, 15 Oct 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KZGiYEgu"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A31F9EA0;
	Tue, 15 Oct 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013109; cv=none; b=qPZRqrjSpNgSPTvO1JSlSunzDnaULS1pOxXVgy559qw919DeRXZqX83mn8D3rxGJ7u9z+RsxsqC+030NampkpCFV7/jMS37Xer4qWxLEvhMaAdAVwYjFiCiqgo2Wnrd3/+LtuB9uHna7LrsmJwLehKmN5xbtQ0SUuCcWskIOQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013109; c=relaxed/simple;
	bh=pJIPxPB0Lqvg735/haHaauMMh0lLMS0VVIN9wDpD9mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhGgHM+KknaN2QrkhoI8nG7Tp2koL5wCNFN3RhkiHwMMBCGFJmUD/t2+lWUaOSBl2qFsJBV6vKu0je0FEmOVO3QuyXhx2AOdoTjvv0KVEcHxpl+2xAl+pjPE6YFDu+QkQcPJgZRAuefDTVF+gmsUqDNsGvc6N7yb5HJjaNNUGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KZGiYEgu; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 05E41C0003EE;
	Tue, 15 Oct 2024 10:25:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 05E41C0003EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729013101;
	bh=pJIPxPB0Lqvg735/haHaauMMh0lLMS0VVIN9wDpD9mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZGiYEguDA85G1SY5UKjcU59EA3jilNhB34Kyqer+pm2CdyrMuqNw4jQxjuQ2sXMR
	 zxWkZvDQJhT5aUhf1tx1jul6mUR3CZhz62mnO3inPpohjGIs2Jy6E11xKdXujGiKXn
	 cGpHfDYubcWJUYWBWFY3K0zXyL36GWdCJoBKrsFM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 99AA518041CAD2;
	Tue, 15 Oct 2024 10:25:00 -0700 (PDT)
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
Subject: [PATCH 2/2] net: systemport: Move IO macros to header file
Date: Tue, 15 Oct 2024 10:24:58 -0700
Message-ID: <20241015172458.673241-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015172458.673241-1-florian.fainelli@broadcom.com>
References: <20241015172458.673241-1-florian.fainelli@broadcom.com>
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
 drivers/net/ethernet/broadcom/bcmsysport.c | 23 ---------------------
 drivers/net/ethernet/broadcom/bcmsysport.h | 24 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 05c83cb3871c..fe641a4effb2 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -27,29 +27,6 @@
 
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
-BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
-BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
-
 /* On SYSTEMPORT Lite, any register after RDMA_STATUS has the exact
  * same layout, except it has been moved by 4 bytes up, *sigh*
  */
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index 335cf6631db5..2977e70806fc 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -773,4 +773,28 @@ struct bcm_sysport_priv {
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
+BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
+BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
+
 #endif /* __BCM_SYSPORT_H */
-- 
2.43.0


