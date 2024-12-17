Return-Path: <netdev+bounces-152432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEF69F3EB2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A99A16BBCF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E12914;
	Tue, 17 Dec 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BS7orvFc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13C335C0
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394043; cv=none; b=cDKgrze87uVAPmAtMAlA1SLtcKIzqsRNJqFcjl84PnCd5pi0dcqVxplTS9aAfILfAH9FySfd3mV/vrWinwMJK6b+hZZImw3eO7P3hT/ldtdQe38xKH6oZnrY9jBe38O8J/pRsbbMsxetTDN8uTOMwrOwT98eVHzwoaf14R/X73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394043; c=relaxed/simple;
	bh=50IbLQQCl7PPABt81NPtDjkAfg3Wuw+EAdZsJkzO7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGBkxv6kbFJnbKXn89BPuLg9/o5k+pmTeqMpd+eBXTzURf9Z11PHmqxur/lZCMuYvi7wiGPa4zKrWEkx5xJ/gali/6g3nK16Y5S+Q8w0IdNTxaKsBe0wi8X1M2NXludEcqA2IYn+IejXDgmagXZwaJyH9En60vD8dysLvEEXnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BS7orvFc; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=di8AfNuy3UcVaZIzetLx5yLqvGuYQmDRlmX1DqBPQ0k=; t=1734394041; x=1735258041; 
	b=BS7orvFcCWHwulrpVxeysXRITAswT+WmpwoU29eQK7evtDKbo939mo46rdJa5sF4TCCA9T8KbQ7
	KN5AHnwtQR7As3r2bm/mzcAqvBZ5l6mY6v4dge7UqARhZwxQWzQs9EccJmNtrF4oaivv63SXC54b/
	02KsyYOvAzAFZZBg+Z9YVD9S6+qZ2nqMDfz+3LC66SvR0SGz2fPLDJqCp+wRAlClQ3hqUG1GC2G+u
	LUZED/F8K3SmeN0PHMc0MayZeS5FvzODeFajlzMt2iAsrC5/0SV+pVTwr8/zr5FdPXrYJ4e9zyHaz
	gxALvOPcQvh7KqP8q9MdXOqljSsK2IgKwZGg==;
Received: from ouster448.stanford.edu ([172.24.72.71]:53919 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tNL7Q-0002IN-Fs; Mon, 16 Dec 2024 16:07:21 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
Date: Mon, 16 Dec 2024 16:06:25 -0800
Message-ID: <20241217000626.2958-13-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241217000626.2958-1-ouster@cs.stanford.edu>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
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


