Return-Path: <netdev+bounces-178459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C855A77184
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375B9188E0C3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77921E08D;
	Mon, 31 Mar 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="B3XRSBgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DF21C168
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464842; cv=none; b=XIA6teUxtO/ygkvcJuv+sK2MrbQOCPxC77+SSJZp8JBMx7KU353ur6glk8SrnzHkGLkFXtumAQjRPs9Qp0fx51DUZLTkk8PwmaA1AvNBnSBjf/vnsbikxHG6dGH7AQqtLKZl+f2vhlTQdnbHEvV+I9//FKNWzSSb5hEW7Y2iCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464842; c=relaxed/simple;
	bh=Z+ud/85iP+UMsBhx+ywUbALKwEcKeSSDD6BaPuMwPFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0cb4LLe/Ufde9lDzOMrHVqvRdTk6kSMth/ad57WLwGBzXrIJ0KugVQroq5UlLuL7imlSAgOK1nkTDpcc+2AEP0iVTpEMmtN7fR+Tj9hEdraiOwzB6j1mJs/TBYmRyedC0BQCleNpGfADovgzMhmaXo+V6vWQRcWU+1/mDsrs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=B3XRSBgI; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8EmR3lofZX+ZAws+n3rGXwL377TutUuyQKZMpkiQptg=; t=1743464841; x=1744328841; 
	b=B3XRSBgIR7Pu6B89j4hA37oCN00oVQI1DOscL684kTyNMkOcLQE/q3ndukjqPAYZ87F/dSeztLz
	k7C6ILKcG17FAc7hOqsmx1fE/OrFlzY6WS2/8iruK40JNpstMf+3bmUR6/t4JN5hG7cCzl0aw9Equ
	VjRSgEImng8o0/fZTys7yxC7rLSl61X0DyaYekQUgZnok7Am7k+zv5IvR1ODUHOyORp6zB9SdFxIm
	04KsXISFjNEYdjOiPVaXL1uka9xGh90k1iI3QGOsg9+9kaNaJEVNaFJFA2ulIDhTTqEgitt2ejPCJ
	VQOQOETD3gs5fx0linWkbFWMOqSFW1fqGTWQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqe-000219-05; Mon, 31 Mar 2025 16:47:20 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 14/14] net: homa: create Makefile and Kconfig
Date: Mon, 31 Mar 2025 16:45:47 -0700
Message-ID: <20250331234548.62070-15-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250331234548.62070-1-ouster@cs.stanford.edu>
References: <20250331234548.62070-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: c870281afef8b7f1344e56ea5df5212b

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
 net/homa/Makefile | 15 +++++++++++++++
 4 files changed, 36 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

diff --git a/net/Kconfig b/net/Kconfig
index c3fca69a7c83..d6df0595d1d5 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -247,6 +247,7 @@ endif
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
+source "net/homa/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 60ed5190eda8..516b17d0bc6f 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -44,6 +44,7 @@ obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_DCCP)		+= dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_HOMA)		+= homa/
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
index 000000000000..2b3c3aff2058
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-2-Clause
+#
+# Makefile for the Linux implementation of the Homa transport protocol.
+
+obj-$(CONFIG_HOMA) := homa.o
+homa-y:=        homa_incoming.o \
+		homa_interest.o \
+		homa_outgoing.o \
+		homa_peer.o \
+		homa_plumbing.o \
+		homa_pool.o \
+		homa_rpc.o \
+		homa_sock.o \
+		homa_timer.o \
+		homa_utils.o
-- 
2.34.1


