Return-Path: <netdev+bounces-229722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75965BE044A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B46188851B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73830275A;
	Wed, 15 Oct 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="kMcyonfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E4288515
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554327; cv=none; b=Hkxxq0r0TuXM8k7wYyrdFDYsjRRNE9fYNCxnnDJXLmwyogIpnUnXqaHkkuizbjxAsNrYDfs91uF4pFDKC/VAleMPOg3JwXtCYrfgCjldy7ahh+kbpd2++qwi6W1NmvHREjgfHrZx7fDaLyxHfyw1G86ZxbBBdIRM8zLPA3ziQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554327; c=relaxed/simple;
	bh=vElVafqo6UQ230JRKmzI+ghwzcwwOc5RPnJTdWfEm5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8XC0c4UGtk4ngumjXizKLaHzeP5qjehWJTKn1WtovMKP6GbU9V7FC0Y3totlcNsk2zbbBsxqSPyJDzhEEJWLObMBqrreaSUULObNC+99dW9GMof8pX+Avs5orIY+JXRLPfjZF3+epkbWsabM7VIQS2Jk8Z0Dl0f6BC0PMAAUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=kMcyonfO; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KB8uFKJbe6AIyjS5uheiTqA3Zney6qVeaNw9UF85VzU=; t=1760554326; x=1761418326; 
	b=kMcyonfOjfesS9++5rYzVofgJgvLZhra8Ct9BbSyDyR9EbqV/HDdga1DN+kFSuOnod5HNvwQ1Jy
	vjC3hhoL0e41YA1yNNl+MDxBIKhp7b0IYh4uhreFcR8v5+HXTRsHeUZ7KZx1AgZmYwF2f62UURAqM
	6/p+PgpWhgPfep7c/TNMjfGuKlA2JQL5ak+j4oIQLnbhz7jB1SeU4o7wRLT870NwpkipbmmZcKqHr
	rdHlQK1ePq+WtnU7Gb4FAFA0Zvv3/bqg69k0fBH5Dpuq/rEDVcuVPIrgLl+ptOleWHCu0IEivA7SN
	IzvHP5Kh89dme619F9Bxs7m9GX+/7sw+V69A==;
Received: from ouster448.stanford.edu ([172.24.72.71]:50623 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1v96bU-00063x-Tp; Wed, 15 Oct 2025 11:52:05 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v16 14/14] net: homa: create Makefile and Kconfig
Date: Wed, 15 Oct 2025 11:51:01 -0700
Message-ID: <20251015185102.2444-15-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251015185102.2444-1-ouster@cs.stanford.edu>
References: <20251015185102.2444-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 1423d2bdf1536ba32d3e1b7a7c800682

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/Kconfig  | 21 +++++++++++++++++++++
 net/homa/Makefile | 11 +++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile

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
index 000000000000..57f051d44c6b
--- /dev/null
+++ b/net/homa/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_HOMA) := homa.o
+homa-y:=        homa_incoming.o \
+                homa_interest.o \
+                homa_outgoing.o \
+                homa_peer.o \
+		homa_plumbing.o \
+                homa_pool.o \
+		homa_rpc.o \
+		homa_sock.o \
+		homa_timer.o \
+		homa_utils.o
-- 
2.43.0


