Return-Path: <netdev+bounces-191952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A699ABE05E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7213A8A2551
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79927BF8E;
	Tue, 20 May 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPrnBUlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3E26B085;
	Tue, 20 May 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757546; cv=none; b=UkuwkYm0A5uO/kK11Wf+uOgHmA0LN+F2fq9eB6GbOXYFkLokSa3UyDC3I+7LocIcFX2/aCZFdZpPsdBU2mzsQwIKIBWtgwJfZMMqwfmy2Zu0VuzpRxi7QfDHBZxQLF+aaZje+T1rKAJUX/i43FQl2obvVWTZ0SV1G2LZdNqW0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757546; c=relaxed/simple;
	bh=H0wdVOSbUkt1lm7oK4U/1cODmEgFmaDK31ojwjNSrDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QHNeZ7jSFxQZVykWsgRWo6D8utBV6q330K6NNAIHKZJXRwR+cybgefqmiRJNsrfsG7+Dyi3C+wuFnnNWwYeebunAxDyG2oxG3JM+8dDo/0UrDRnoHQv4GR4a2jpbrA9t6/kp6MiI0GrTJiIKjBIWDrYJyvhk7N9rWePS+T9xexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPrnBUlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07871C4CEE9;
	Tue, 20 May 2025 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757545;
	bh=H0wdVOSbUkt1lm7oK4U/1cODmEgFmaDK31ojwjNSrDc=;
	h=From:To:Cc:Subject:Date:From;
	b=uPrnBUlS6G38zQL9J1d0mEtD3d6wnS3FaUkDi741pR6lEo71M/GmN7s7zJoU3Z5+P
	 kJiVqXDfbIQvZujeqZnfreCz9rrIj/0emBGveYgh7ZS2NfC5aKBMJKXoEtkBTQEuKB
	 k0CF4InZYB/lEpqQRHZ0nKUjYsK6oYR8bxGorwFXY1ZhqF6DGVBmZEuz8ZzRN1/AEl
	 Wx2L1bu/zXPySD8gNI1GSg0/xWaqj0Fj6SXhJOGLLv0l/njfI4mD9LEfMNkQiP/1VS
	 o0tkt12LtgzbtZaVZ/qA0E1mMJOFt3H4tyCohfB/ATK9JTxKXM2xVXFfawM4HA1Hga
	 EOoxt/4atys7A==
From: Arnd Bergmann <arnd@kernel.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: enetc: fix NTMP build dependency
Date: Tue, 20 May 2025 18:12:09 +0200
Message-Id: <20250520161218.3581272-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When the new library driver is in a loadable module, but the enetc
core driver is built-in, the kernel fails to link:

aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in function `enetc4_teardown_cbdr':
enetc_cbdr.c:(.text+0x70): undefined reference to `ntmp_free_cbdr'
aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in function `enetc4_get_rss_table':
enetc_cbdr.c:(.text+0x98): undefined reference to `ntmp_rsst_query_entry'
aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in function `enetc4_set_rss_table':
enetc_cbdr.c:(.text+0xb8): undefined reference to `ntmp_rsst_update_entry'
aarch64-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_cbdr.o: in function `enetc4_setup_cbdr':
enetc_cbdr.c:(.text+0x438): undefined reference to `ntmp_init_cbdr'

Move the ntmp code into the core module itself to avoid this link error.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  | 2 +-
 drivers/net/ethernet/freescale/enetc/Makefile | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index e917132d3714..90aa6f6dfd63 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -16,7 +16,7 @@ config NXP_ENETC_PF_COMMON
 	  If compiled as module (M), the module name is nxp-enetc-pf-common.
 
 config NXP_NETC_LIB
-	tristate
+	bool
 	help
 	  This module provides common functionalities for both ENETC and NETC
 	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index f1c5ad45fd76..0af59f97b7e7 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -6,8 +6,7 @@ fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
 nxp-enetc-pf-common-y := enetc_pf_common.o
 
-obj-$(CONFIG_NXP_NETC_LIB) += nxp-netc-lib.o
-nxp-netc-lib-y := ntmp.o
+fsl-enetc-core-$(CONFIG_NXP_NETC_LIB) += ntmp.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
 fsl-enetc-y := enetc_pf.o
-- 
2.39.5


