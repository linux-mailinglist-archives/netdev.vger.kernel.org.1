Return-Path: <netdev+bounces-209856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFAB1111A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562677BD4F0
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD02ECD30;
	Thu, 24 Jul 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="amm12Y4V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531F2EE61A
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382519; cv=none; b=St67/XphndSg++BFZYjTCuuwH1rqJfO5x3oblA5xRsVwOi+uMK4eB15Sw72KcfrlZ6DOV//0G3dp2ZKgv1NIIXgqX+AQzVa/ufuD5cfcioL4Cskcc6kN9/CpcINl8E9sS84h8nlVGcEILKmuhKEFsGoTStTQZyaLFwz4o0og4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382519; c=relaxed/simple;
	bh=WfQo6VWW97Dd9tbJRF8NIjPGOh4v/l76zixni158weE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXHFFy1kxEQpFoTUZuUIjAzHTp83y7Or+XQ8hdB6S6cbh31Y4tvJoDbNgu9CCcpfWD7KH8tgRO94UoZumlubns1N/qvHDfw1862gwJH4Hl/2mimwwYnqgQLLdLvkzN/vRe4WLRYPme8k8UdVzE3iyDzpBBspV9PHqJ9eibKPkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=amm12Y4V; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hIxLajEFFO+kE/xI6d38sn/tW/Rlk/k00h8fWzbhVBA=; t=1753382518; x=1754246518; 
	b=amm12Y4VdPQd8ehK9EIH45ActmL5qzpE2Lqonqs6iyFgGDvJhpUId6Z8CM/P0KTCLkD8gvlE4jz
	/k6W0vBCGG7jyRJszA0y81d3Se8luPsIIctSaSU+tmemKKwqgXx5r+6IvQm1uKOb0yPjqgLDXkyAV
	U24n+ahZQu48jfmLd500nbAzPipkrzA+H2MZ8+K3kKM3TvclN4QK0Uuj0sb7+39IFN4aaA74IVkkd
	Q12ILVp3GLPZ63ekEXcugz7NSGLtp/PEVl4aU90Cz3DhNMzBTZ7XfTcdsP3rhyMSeQ5vvald1ut0E
	TimLGNAEnK4kMLqQOS06YWk0Bd73E7pxWe2A==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:55641 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uf0t9-0006eP-JS; Thu, 24 Jul 2025 11:41:56 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v12 15/15] net: homa: create Makefile and Kconfig
Date: Thu, 24 Jul 2025 11:40:48 -0700
Message-ID: <20250724184050.3130-16-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250724184050.3130-1-ouster@cs.stanford.edu>
References: <20250724184050.3130-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 50c535147b6e7155177bcd7d65214eb3

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/Kconfig       |  1 +
 net/Makefile      |  1 +
 net/homa/Kconfig  | 21 +++++++++++++++++++++
 net/homa/Makefile | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

diff --git a/net/Kconfig b/net/Kconfig
index ebc80a98fc91..cb89196c63ff 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -250,6 +250,7 @@ source "net/bridge/netfilter/Kconfig"
 endif
 
 source "net/sctp/Kconfig"
+source "net/homa/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index aac960c41db6..71f740e0dc34 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -43,6 +43,7 @@ ifneq ($(CONFIG_VLAN_8021Q),)
 obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_HOMA)		+= homa/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
diff --git a/net/homa/Kconfig b/net/homa/Kconfig
new file mode 100644
index 000000000000..8ce5fbf08258
--- /dev/null
+++ b/net/homa/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Homa transport protocol
+#
+
+menuconfig HOMA
+	tristate "The Homa transport protocol"
+	depends on INET
+	depends on IPV6
+
+	help
+	  Homa is a network transport protocol for communication within
+	  a datacenter. It provides significantly lower latency than TCP,
+	  particularly for workloads containing a mixture of large and small
+	  messages operating at high network utilization. At present, Homa
+	  has been only partially upstreamed; this version provides bare-bones
+	  functionality but is not performant. For more information see the
+	  homa(7) man page or checkout the Homa Wiki at
+	  https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
+
+	  If unsure, say N.
diff --git a/net/homa/Makefile b/net/homa/Makefile
new file mode 100644
index 000000000000..ed894ebab176
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Makefile for the Linux implementation of the Homa transport protocol.
+
+obj-$(CONFIG_HOMA) := homa.o
+homa-y:=        homa_incoming.o \
+		homa_interest.o \
+		homa_outgoing.o \
+		homa_pacer.o \
+		homa_peer.o \
+		homa_plumbing.o \
+		homa_pool.o \
+		homa_rpc.o \
+		homa_sock.o \
+		homa_timer.o \
+		homa_utils.o
-- 
2.43.0


