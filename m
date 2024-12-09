Return-Path: <netdev+bounces-150316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C379E9D97
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B4F18883CF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDC1C5CAC;
	Mon,  9 Dec 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="KbovIexr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183051C5CB1
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766764; cv=none; b=DZr6HKc2Z9lX6rwkY1l35lrT3FJTCLQ4XqKygLq6y/lYIIV5acqXTjhXa7kmRcihCnmg+3S/mOSDs/Z40neD/+1O3iIRIt2sJU3sy1+fuYfh0y1CVU9dhIlSf6rjWJS7yVQVujdU//QoxkcDOq4vU0zSbRZi3cpW3VU5cex6AKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766764; c=relaxed/simple;
	bh=IEr1j58BQsELXOtcRwnzJ/DWAf5GH/gmyZO+anq8fLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyWJ+UNtvqwiTIL61b7pKP9D0xj2CkDVRO+lkkHSg8uJ5VYIZOgyMx++XXqlDW08rPopn1tVJR8y2o22OKQqO6AD5O73yC+wyPii5tw4gkbQzeRaWd8brCUj/lhU5UDbr+AouJIOPD72YqUYrGKH6WVVylYkIbN5GE+Q9V22Z8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=KbovIexr; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PPZCUznNziiIHN15Jh46+plpLY4SAC52HnFvFPxrQLc=; t=1733766763; x=1734630763; 
	b=KbovIexr/sAPInH5cMF6QyJYTHO1veXL1UYlgP6hdj0saPCBFfIPIWp15xrXyHsm+IxKiPAsFMO
	PEV1uLkGyiZrPwyLfmzR48nAtpLtsclJwNTAfhl4uwQpaZ8OCILGmv7oyHjgkcI1jNaw9NBkFpc3H
	COucToQS38MIJKdH0MPYvmDQjtyV/ME8cjJWf2BuC5ft6t+xFLCw7nuypwie0MxLdXI6q0WaZ72qM
	SejHE3I9WiNIr95XSfn/3Wnr8jUKsDxSePwwQSQIKH4uyXyZJ6vbONN3sq5BZb+ndeNflqHokpsU8
	tWJeNVvrzuOkeTPUWj1UlMSZ9Weg+6syqXzQ==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:53595 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKhw1-0006KI-PS; Mon, 09 Dec 2024 09:52:42 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v3 12/12] net: homa: create Makefile and Kconfig
Date: Mon,  9 Dec 2024 09:51:30 -0800
Message-ID: <20241209175131.3839-14-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241209175131.3839-1-ouster@cs.stanford.edu>
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: f3ece08579cbcd970dc3d33c6519ba8c

Before this commit the Homa code is "inert": it won't be compiled
in kernel builds. This commit adds Homa's Makefile and Kconfig, and
also links Homa into net/Makefile and net/Kconfig, so that Homa
will be built during kernel builds if enabled (it is disabled by
default).

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 MAINTAINERS       |  7 +++++++
 net/Kconfig       |  1 +
 net/Makefile      |  1 +
 net/homa/Kconfig  | 19 +++++++++++++++++++
 net/homa/Makefile | 14 ++++++++++++++
 5 files changed, 42 insertions(+)
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


