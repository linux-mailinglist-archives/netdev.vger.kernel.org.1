Return-Path: <netdev+bounces-206521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CDB0354C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F177A9D14
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14415208961;
	Mon, 14 Jul 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="DKg2M2NZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905271F7580
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468352; cv=none; b=Kz6T1thr/944rrV5A1iQs6wU2aYjeGUIkvvimpwt6SyKor+Pz+ECsuGfOJaYeT+Wq3p8EIcX9vG8zCp8bH+wi3Ziq+5mcu3PQxsSFLS4jPPcwo62ywh8rY5bwbda87MLD5zNoYhGeBZ9mGyMar47Ig9RJxMrERzZ6hJTzptw7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468352; c=relaxed/simple;
	bh=WfQo6VWW97Dd9tbJRF8NIjPGOh4v/l76zixni158weE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQqb03PLezIquSYlXlhHv3s5XV4IWRndkFmmHNtQx3qqRt293YV2qnKrct8Ox0PB1nB6sekULWoue0m4ST5OdNu3Se2l0xGtj+pWXIemdaWvVazMEeY7L7YAGGn5UPk8mgmgxtmNbDszubfF9bBWm6owG5A+AKg2PRHmuPJAaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=DKg2M2NZ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hIxLajEFFO+kE/xI6d38sn/tW/Rlk/k00h8fWzbhVBA=; t=1752468350; x=1753332350; 
	b=DKg2M2NZreHCr1Mlwluj1lY7qFZ/dEVjSp6oRgayTg4ZP/ZaUuKtZLQs6pF0uLLJe185JiEj6W9
	5aN9Ku9UxI3LjHqJSC00RmoUD2Y9ZTmIPHEouvmEkGWHsHGGY0MprV/LKpQPnIIbVPB70H4fjv2ln
	aNnDutXLyMeJz33N0iyHtgKtYgyBM0zL5HoJBW+t+vpAsinngAOK1r56QSOJHsWJd3la1Vn4Ws7Z4
	4JB8bP8ORd3mNoQny2+m0RzR5ZkMMqqUAuMDbnCW3X9A2nH91qW/a1T0Oroz4vXaaBbHwf5t/89g8
	4aRWwGVWCgly4vEQQuvJ/uzXtqSLoxbEm1Rg==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:63266 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ubB4X-00080i-E8; Sun, 13 Jul 2025 21:45:50 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 15/15] net: homa: create Makefile and Kconfig
Date: Sun, 13 Jul 2025 21:44:47 -0700
Message-ID: <20250714044448.254-16-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250714044448.254-1-ouster@cs.stanford.edu>
References: <20250714044448.254-1-ouster@cs.stanford.edu>
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


