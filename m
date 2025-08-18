Return-Path: <netdev+bounces-214749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C0B2B26F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9224F1BA2719
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672626B767;
	Mon, 18 Aug 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="fGrGfFl8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5B27586C
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548984; cv=none; b=MWYjLtiOrxJhC5TQQ0Er7MxzX7kbaAQrHdDYK+NgVWAtBtQwspFr42kVSAzcBcPESD+2hRJnHlrAlUfqXOu1IHn0lD4srWKhPR362juArD2Mu7KvBapOooyhf+Sh/0NRVK+32IpI1lkoJeZcwJmVu0kNXlgZXbyZyGytEftWCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548984; c=relaxed/simple;
	bh=b29aufcig9djGIKilVPFhDSFCWTvCWtilU3wIBeDhfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkGYsHzYNFv+0kcGGpNuW+0W5fcJbu/0uYJy5tqLfRnmrKvcpBppNvsow8aliNyGS37Q/Zg5ezhN0qd/3lYgaScHBnQshEqMiTHzFPVx+bCYklbuOzEnWE7EwJ674zLLSpS91RX4sO9NzS0K9UdJ084f8DKSxB2ijw19hJBwrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=fGrGfFl8; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I6gXXvyGq0hJM6SzSBjQA1s1enZWtqFoCRHy4d/V+TQ=; t=1755548983; x=1756412983; 
	b=fGrGfFl8fpvSIg4xOxHmObxCjSOJpykWrEkmuXn9d62DXOUf7JbCT0cvBLFTUWc73dGXlDCM9Kj
	IhEABJWS0mBmCHiNsO1bdBsDhgR9hmrEFFYA7F47Dtahilme3AlsO4CxodUVFskvhvIyZFcEkxQBc
	JTRGYU+6gj7C2TQQX8W6dS+chPvCvnY4g/Afx0226ewTfxBvNBxyTzK3d/kDs4TiqYgNE4yCwVPom
	EQu/EJW9GNPcZzAuPW/fRJdSr8XPzRQVAeLd5VJEr30RcSsr7Ch8kQDdBpsop+pFeFqHH6hkRyZvs
	/0y5EY7Ei0Bj5lIxJ23mKOd9RvvV/3YCi7nQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:51143 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uo6U9-0008EW-Jm; Mon, 18 Aug 2025 13:29:42 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <"ouster@cs.stanford.edouster"@node0.ouster-266167.homa-pg0.utah.cloudlab.usu>,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v14 15/15] net: homa: create Makefile and Kconfig
Date: Mon, 18 Aug 2025 13:27:54 -0700
Message-ID: <20250818202756.1881-16-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250818202756.1881-1-ouster@cs.stanford.edu>
References: <20250818202756.1881-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: b6c1f4b091abe5b5a29b37e1ccaa2d85

From: John Ousterhout <ouster@cs.stanford.edouster@node0.ouster-266167.homa-pg0.utah.cloudlab.usu>

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


