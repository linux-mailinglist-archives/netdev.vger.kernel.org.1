Return-Path: <netdev+bounces-214774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13965B2B30B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91CA7B8EDE
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3F21CA03;
	Mon, 18 Aug 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="LdEADufB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E92264B1
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550607; cv=none; b=DDR3gNfc65WVYiyAHx/IGshYt5X9V4AesYGAIWa37aEVe9y+dZ27zoXEfkh7XHoXcMDN4VC6q6KSqBjhVNQYnhQL5W0crKxCCPu7xMQ57AIu7xFjs8ZRlNTn5s/B3M8aOLM5+fhDu4wdbj1ybZdi+kv18XyCs4fp0EITF7q15sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550607; c=relaxed/simple;
	bh=9T8NaKp5IgvrhWNBJJWW+UsmAN0pYRNbu6JuIUOuzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnX2qZsMOFY9BkNFBaIeySSJxqhou2KBp4PuLBiZ2LYKTwuLxh9rfpT/3MYQ0zypNDciAhd6OzdYd1YKeX20A3L00esFfA5IjVGqD6Y0bNZ+pQbYZ16NQ2N1QiaqRLy6BKk8yOucvK9RJeHSQc8m4fGuWmYJ+yWN2yxeUwIgnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=LdEADufB; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gFrsyWyv4B8J7Sfk6cTS2+pDSkqj6pzyXlkOqq/noIg=; t=1755550606; x=1756414606; 
	b=LdEADufBBT9e+TuxiC1Ht19SK7UvcbdTHMfcMPQ1G5GJnKFS1EFC9rmFkXmjJQ2//P3LRR9hXUK
	37VcPRhRk9IBRAb7IlooqV3gQnrQcxtmfa8X41BseH1+UGlwSiltHY8odToD4gQCsEZJYR99RY1y2
	Gx+QKZqpzcEYNTlpJoInhhwDyKNq+j4JZjGFpsj0KdMJig8iFBkoLe6ViSU+TOZgPhbZIaC05QYMS
	TB4pgxAqKEn7IRT5jc5P6Ig64Np7Hz82gqEvJO6Q1LY0UbNN0mD87NyFK7jcZQofM3nv/QJv9x570
	ajAAQdJqpI56WnThIO6qIwX1N4cX5dI+J4LA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:50368 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uo6uL-0001f9-19; Mon, 18 Aug 2025 13:56:45 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v15 15/15] net: homa: create Makefile and Kconfig
Date: Mon, 18 Aug 2025 13:55:50 -0700
Message-ID: <20250818205551.2082-16-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250818205551.2082-1-ouster@cs.stanford.edu>
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
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
index d5865cf19799..92972ff2a78d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -250,6 +250,7 @@ source "net/bridge/netfilter/Kconfig"
 endif # if NETFILTER
 
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
index 000000000000..16fec3fd52ba
--- /dev/null
+++ b/net/homa/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
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
index 000000000000..a7ebccd4b56c
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+
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


