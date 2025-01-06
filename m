Return-Path: <netdev+bounces-155572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77AA02F94
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CA61651CB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357A1DFD8D;
	Mon,  6 Jan 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="pVwtF1Hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528615C158
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187212; cv=none; b=cAP0kuGQ3zS1rB4WVd5cNtQSDv4kD+uJrEHW6WJPhvTMd39fZMKWquO8Mpv7bFPjlBPum7stOaY6bI4/S4EFUdZDZLC253TVicOYETBvCTDNYPMF7qUWHO8zdqSmswrZh/xxexgPq1junEOWdLh33Atx1shWl//Z7tI4/s6Oeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187212; c=relaxed/simple;
	bh=50IbLQQCl7PPABt81NPtDjkAfg3Wuw+EAdZsJkzO7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFBg5ZzMp+qVN+2sAzheSLAbbid9l/QudzhM/guTSNBdvP2vASQSKRp817EyW5mBaXkVy+CD4JunP8PgM3/CD0kmWRvBE+YjWCcrM6vx8Utf8bl5eZ5JteMNq/cQn5XJ+lEry3GcMRAqm2+9vQLcth2j8+QDFQ9ufeZ/eutdb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=pVwtF1Hu; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=di8AfNuy3UcVaZIzetLx5yLqvGuYQmDRlmX1DqBPQ0k=; t=1736187211; x=1737051211; 
	b=pVwtF1HuQGWbhp0/bKFEmfJ20zh0SFK6rGIn07HvS7jobS62JoI181qZuyEFRI4HLMPD3EDjNr0
	fCoUjhJIC0TV/LxbMVASDsnpIwKAZppTaGklTrnMaxUab55UeiXZiBRnvx29eygpu2R0RscrBvoQL
	RsQSlq4W0LF++yzTOmiVwJGf0m/uGbk2h9K+GClpt9rCc8KTHQD9MvGawsV6YV2qBJYG69/zbJxXd
	kCRN7mXkTajamGxBx1K5Nq2QXt81A7z6cWe9+ICbtiOKz9CVK2eAA53R5p9lO2B900ag1Bk+jo45n
	vornWH8v99ruL9yULYcmxJrz6o7J3dES2LHw==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:59627 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tUrbW-0003Bs-1X; Mon, 06 Jan 2025 10:13:30 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v5 12/12] net: homa: create Makefile and Kconfig
Date: Mon,  6 Jan 2025 10:12:18 -0800
Message-ID: <20250106181219.1075-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250106181219.1075-1-ouster@cs.stanford.edu>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: a8fa315618741e04a90c2df3bc1ba398

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/Kconfig       |  1 +
 net/Makefile      |  1 +
 net/homa/Kconfig  | 19 +++++++++++++++++++
 net/homa/Makefile | 14 ++++++++++++++
 4 files changed, 35 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

diff --git a/net/Kconfig b/net/Kconfig
index a629f92dc86b..ca8551c1a226 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -244,6 +244,7 @@ endif
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
+source "net/homa/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 65bb8c72a35e..18fa3c323187 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -44,6 +44,7 @@ obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_HOMA)              += homa/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
diff --git a/net/homa/Kconfig b/net/homa/Kconfig
new file mode 100644
index 000000000000..3e623906612f
--- /dev/null
+++ b/net/homa/Kconfig
@@ -0,0 +1,19 @@
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
+	  messages operating at high network utilization. For more information
+	  see the homa(7) man page or checkout the Homa Wiki at
+	  https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
+
+	  If unsure, say N.
diff --git a/net/homa/Makefile b/net/homa/Makefile
new file mode 100644
index 000000000000..3eb192a6ffa6
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Makefile for the Linux implementation of the Homa transport protocol.
+
+obj-$(CONFIG_HOMA) := homa.o
+homa-y:=        homa_incoming.o \
+		homa_outgoing.o \
+		homa_peer.o \
+		homa_pool.o \
+		homa_plumbing.o \
+		homa_rpc.o \
+		homa_sock.o \
+		homa_timer.o \
+		homa_utils.o
-- 
2.34.1


