Return-Path: <netdev+bounces-139681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D69B3CE8
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8181F1F22F7B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B71F427A;
	Mon, 28 Oct 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="UY6630/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222C1EBA14
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151388; cv=none; b=gViMPZvh8++qeMnqFvyTyZKDE/lKxPnE+6DK9t+3R6nVREyBMRufaic5Z8mYw3AJEaIsYJP1aa/rV0Y3Ux7ZJsvWRmkqwDrt6Iald/121HfycBkPLVJAtvJD1+xk5lfHuEXY7gxuhjtpbQWC1kJd5tj1dDQX2wjYDBtVAepfiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151388; c=relaxed/simple;
	bh=3FoIrL1BYiboyneRffpsHNS19haySGrc5oudXrSMnTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbr7Oo7U2fKfbpMLYQJwgmP7piPMR/2A/CTjW8YnfT4i1JKiGjnihUilAk/06DyhoKsy0dEVS2oO4vp4J6FCQA7bktbIUBcSr9YGmev/KWHrHfjh9NbaSnoo8pHoOFder4TYRHUhvr9JuQM4TX1mx52OJhfjdD9Qd/VuE+QB0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=UY6630/y; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=81hCTWFa1xsaHq5MhPO4AD1lFB4/xda8wfjd7lC8EH4=; t=1730151386; x=1731015386; 
	b=UY6630/yrd7lUtP3e2jtUMQPjwnIcb47WQWPvXVmKg0VgLaM+CwIkjOQA/2qMZTNbVyC8kMZ16p
	09GXQAlcA4JgcQo8jVuz7oBv1/Zj5Tb+1jQXRJOPfrnq8VKDH9VyjUnol+KinGqorLOF1lBo4ScVH
	QhygpOYbJVO3PYBXdaWj+uJtBkHb1wWvwhG3Om7vMFwZ5Kte61Ygo2RD8OMD/AfGC8tvBToBnkTbk
	h67CEKdWT3/jriKguK+CJq1IKcx4h37zyRWzaTA9w9O+pom1wYFHlttrqzwG+uddfgw052M52z/z/
	WQOK7dhMK5l+APKPV6TBNzV10o5rYF+Do7MA==;
Received: from ouster2016.stanford.edu ([172.24.72.71]:54106 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t5XPU-0005xj-TN; Mon, 28 Oct 2024 14:36:25 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
Date: Mon, 28 Oct 2024 14:35:39 -0700
Message-ID: <20241028213541.1529-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241028213541.1529-1-ouster@cs.stanford.edu>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: f3ece08579cbcd970dc3d33c6519ba8c

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

This commit also adds an entry in the MAINTAINERS file.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 MAINTAINERS       |  7 +++++++
 net/Kconfig       |  1 +
 net/Makefile      |  1 +
 net/homa/Kconfig  | 17 +++++++++++++++++
 net/homa/Makefile | 14 ++++++++++++++
 5 files changed, 40 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 1389704c7d8d..935d1e995018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
+F:	include/uapi/linux/homa.h
+F:	net/homa/
+
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
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
index 000000000000..bb98e96d8f66
--- /dev/null
+++ b/net/homa/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Homa transport protocol
+#
+
+menuconfig HOMA
+	tristate "The Homa transport protocol"
+
+	help
+	Homa is a network transport protocol for communication within
+	a datacenter. It provides significantly lower latency than TCP,
+	particularly for workloads containing a mixture of large and small
+	messages operating at high network utilization. For more information
+	see the homa(7) man page or checkout the Homa Wiki at
+	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
+
+	If unsure, say N.
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


