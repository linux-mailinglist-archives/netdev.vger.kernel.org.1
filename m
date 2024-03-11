Return-Path: <netdev+bounces-79221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E88878545
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6738AB22610
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44265F578;
	Mon, 11 Mar 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqB0lnKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA874F88B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174001; cv=none; b=CHhT7aBngVeTfBGjQo6umlGs55ME2E3sGClDlxDr0lx1wcN6GdtWu3dPK8Ce0DqrpUpFuyuOGdiAg9SyXzFC6yZ+FTNM1UpPa7UubD6HTO+dsisTVOjHYiw1TXOOV8E9KCj2G5rUNW9AGoogybynQ1JFWUMEVwKWOxEjvE8qY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174001; c=relaxed/simple;
	bh=4sNiGmRr/FWozNykTt3wYkVKn1em/9kXrGmgXsRM6xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDh8UUmYiTjj9FbSROjMG1wZZnveEKTx19uVRhe4QrlyzdckZ2NnFypGMOoo5obO4cXu2E7+4hdlmquTzLA0stVDCSqPrUTny7wP9k3/w/dGE65Ja3MGlh4uMmeYqB3t4zYjuPorxXVh5bNBjBF5VUEtsK5HVzGFo3nE76CL2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqB0lnKC; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f571be9ddso39243836d6.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173985; x=1710778785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsP0SXHeYcp6oNLtvF5Dj7hiP+Mi96lTcKgQuolzKiI=;
        b=gqB0lnKCKcWUQlQa7epMMAbaEPW5/J+u4b5GYoMIiqHDEMp/zJiaD1SSo803CGygRk
         NUzivOaPees2WK7zRW7tRYjTYXh8z0YSxz8GBLl4gKlQ4TPBZUxOb3b1LNOz83YDw2No
         02/8Xo8NKxH5zJpjgKf8J/sK5Gk4UDkG63RiBuntr4wz6F+/9MoiIhu/b/fjs4KPOgaA
         V2AqB40Wq9/Mg2RofQ3kqIA1fBZ+Qz/XPJwGXiSaRMO8Dl7/5Cp+I4sizcJ5Jotu7AHf
         b+C2SMBWiF2BRr0SLxBHeE7Un0XpvHK/n1/a3Xybun1i7lyUtwJ/bTGgJQj+m8DBQu1Z
         qqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173985; x=1710778785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsP0SXHeYcp6oNLtvF5Dj7hiP+Mi96lTcKgQuolzKiI=;
        b=TGkA3wwGLpXdYj7tWBTmmlUlTYl6AQ7Bp1/f5B7T68PLQhwhMGY9HdBfohdberV6b8
         RJOjZewtzdukY+pJ1xxDUMy2vsJwhqTltFB6aXDPjPqur43BtbLZe/0U5txick4H0v38
         BwOtFV4+c/aycHh3EcA/DQAhjnx/BZwVYD59BwATqUzVpTSbt58fGASS5DifyfGk4p8M
         2AnugnwdbOhQ+kGs/WV2RsMChdVH7rqk3+GH9sFpcdtP0+QzflGN9/5y+EV2ZAC8sS80
         Q3rlfZrtNh0GQigjZPovN0B+uCV4AVKWpKkOuvZ7uyOVDbXRLharu87IjgtkVhsQF7xu
         NtJQ==
X-Gm-Message-State: AOJu0YwaXhLDYOQBoAMr6xZfB/PVLQ9Qa0MasA8JUJ/uRp0LJF/eR+RD
	OvGhjvnfcl5fa3HcIuKFXoEmOB92+N5G0PlVtMDjUiF+Yxnwnh2JWTqKLprrPTA=
X-Google-Smtp-Source: AGHT+IG7zxlzb2hZ27fXboi62fVzn9VTK40V4MLQ7hLEmf+Hsgm4xU9+2bBOp4/hlhDtuVQfVvKNvg==
X-Received: by 2002:a05:6214:ce:b0:690:9a8a:8558 with SMTP id f14-20020a05621400ce00b006909a8a8558mr5802749qvs.18.1710173983704;
        Mon, 11 Mar 2024 09:19:43 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:42 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>
Subject: [RFC PATCH net-next 3/5] net: implement QUIC protocol code in net/quic directory
Date: Mon, 11 Mar 2024 12:10:25 -0400
Message-ID: <35e64a15d428674cb01cef17968931db21fc4213.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the initial implementation of the QUIC protocol code.
The new net/quic directory contains the necessary source files to
handle QUIC functionality within the networking subsystem:

  - protocol.c: module init/exit and family_ops for inet and inet6.
  - socket.c: definition of functions within the 'quic_prot' struct.
  - connection.c: management of source and dest connection IDs.
  - stream.c: bidi/unidirectional stream handling and management.
  - cong.c: RTT measurement and congestion control mechanisms.
  - timer.c: definition of essential timers including RTX/PROBE/IDLE/ACK.
  - packet.c: creation and processing of various of short/long packets.
  - frame.c: creation and processing of diverse types of frames.
  - crypto.c: key derivation/update and header/payload de/encryption.
  - pnmap.c: packet number namespaces and SACK range handling.
  - input.c: socket lookup and stream/event frames enqueuing to userspace.
  - output.c: frames enqueuing for send/resend as well as acknowledgment.
  - path.c: src/dst path management including UDP tunnels and PLPMTUD.
  - unit_test.c: tests for the APIs defined in some of the above files.
  - sample_test.c: a sample showcasing the usage from the kernel space.

It introduces fundamental support for the following RFCs:

  RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
  RFC9001 - Using TLS to Secure QUIC
  RFC9002 - QUIC Loss Detection and Congestion Control
  RFC9221 - An Unreliable Datagram Extension to QUIC
  RFC9287 - Greasing the QUIC Bit
  RFC9368 - Compatible Version Negotiation for QUIC
  RFC9369 - QUIC Version 2

The QUIC module is currently labeled as "EXPERIMENTAL".

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
---
 net/quic/Kconfig       |   34 +
 net/quic/Makefile      |   20 +
 net/quic/cong.c        |  229 +++++
 net/quic/cong.h        |   84 ++
 net/quic/connection.c  |  172 ++++
 net/quic/connection.h  |  117 +++
 net/quic/crypto.c      |  979 +++++++++++++++++++++
 net/quic/crypto.h      |  140 +++
 net/quic/frame.c       | 1803 +++++++++++++++++++++++++++++++++++++++
 net/quic/frame.h       |  162 ++++
 net/quic/hashtable.h   |  125 +++
 net/quic/input.c       |  693 +++++++++++++++
 net/quic/input.h       |  169 ++++
 net/quic/number.h      |  174 ++++
 net/quic/output.c      |  638 ++++++++++++++
 net/quic/output.h      |  194 +++++
 net/quic/packet.c      | 1179 ++++++++++++++++++++++++++
 net/quic/packet.h      |   99 +++
 net/quic/path.c        |  434 ++++++++++
 net/quic/path.h        |  131 +++
 net/quic/pnmap.c       |  217 +++++
 net/quic/pnmap.h       |  134 +++
 net/quic/protocol.c    |  711 ++++++++++++++++
 net/quic/protocol.h    |   56 ++
 net/quic/sample_test.c |  339 ++++++++
 net/quic/socket.c      | 1823 ++++++++++++++++++++++++++++++++++++++++
 net/quic/socket.h      |  293 +++++++
 net/quic/stream.c      |  248 ++++++
 net/quic/stream.h      |  147 ++++
 net/quic/timer.c       |  241 ++++++
 net/quic/timer.h       |   29 +
 net/quic/unit_test.c   | 1024 ++++++++++++++++++++++
 32 files changed, 12838 insertions(+)
 create mode 100644 net/quic/Kconfig
 create mode 100644 net/quic/Makefile
 create mode 100644 net/quic/cong.c
 create mode 100644 net/quic/cong.h
 create mode 100644 net/quic/connection.c
 create mode 100644 net/quic/connection.h
 create mode 100644 net/quic/crypto.c
 create mode 100644 net/quic/crypto.h
 create mode 100644 net/quic/frame.c
 create mode 100644 net/quic/frame.h
 create mode 100644 net/quic/hashtable.h
 create mode 100644 net/quic/input.c
 create mode 100644 net/quic/input.h
 create mode 100644 net/quic/number.h
 create mode 100644 net/quic/output.c
 create mode 100644 net/quic/output.h
 create mode 100644 net/quic/packet.c
 create mode 100644 net/quic/packet.h
 create mode 100644 net/quic/path.c
 create mode 100644 net/quic/path.h
 create mode 100644 net/quic/pnmap.c
 create mode 100644 net/quic/pnmap.h
 create mode 100644 net/quic/protocol.c
 create mode 100644 net/quic/protocol.h
 create mode 100644 net/quic/sample_test.c
 create mode 100644 net/quic/socket.c
 create mode 100644 net/quic/socket.h
 create mode 100644 net/quic/stream.c
 create mode 100644 net/quic/stream.h
 create mode 100644 net/quic/timer.c
 create mode 100644 net/quic/timer.h
 create mode 100644 net/quic/unit_test.c

diff --git a/net/quic/Kconfig b/net/quic/Kconfig
new file mode 100644
index 000000000000..076c6e4380df
--- /dev/null
+++ b/net/quic/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# QUIC configuration
+#
+
+menuconfig IP_QUIC
+	tristate "QUIC: A UDP-Based Multiplexed and Secure Transport (Experimental)"
+	depends on INET
+	depends on IPV6
+	select NET_UDP_TUNNEL
+	help
+	  QUIC: A UDP-Based Multiplexed and Secure Transport
+
+	  From rfc9000 <https://www.rfc-editor.org/rfc/rfc9000.html>.
+
+	  QUIC provides applications with flow-controlled streams for structured
+	  communication, low-latency connection establishment, and network path
+	  migration.  QUIC includes security measures that ensure
+	  confidentiality, integrity, and availability in a range of deployment
+	  circumstances.  Accompanying documents describe the integration of
+	  TLS for key negotiation, loss detection, and an exemplary congestion
+	  control algorithm.
+
+	  To compile this protocol support as a module, choose M here: the
+	  module will be called quic. Debug messages are handled by the
+	  kernel's dynamic debugging framework.
+
+	  If in doubt, say N.
+
+if IP_QUIC
+config IP_QUIC_TEST
+	depends on NET_HANDSHAKE || KUNIT
+	def_tristate m
+endif
diff --git a/net/quic/Makefile b/net/quic/Makefile
new file mode 100644
index 000000000000..78f00fc8d837
--- /dev/null
+++ b/net/quic/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for QUIC support code.
+#
+
+obj-$(CONFIG_IP_QUIC) += quic.o
+
+quic-y := protocol.o socket.o connection.o stream.o path.o \
+	  packet.o frame.o input.o output.o crypto.o pnmap.o \
+	  timer.o cong.o
+
+ifdef CONFIG_KUNIT
+	obj-$(CONFIG_IP_QUIC_TEST) += quic_unit_test.o
+	quic_unit_test-y := unit_test.o
+endif
+
+ifdef CONFIG_NET_HANDSHAKE
+	obj-$(CONFIG_IP_QUIC_TEST) += quic_sample_test.o
+	quic_sample_test-y := sample_test.o
+endif
diff --git a/net/quic/cong.c b/net/quic/cong.c
new file mode 100644
index 000000000000..3c01dc3e285f
--- /dev/null
+++ b/net/quic/cong.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <uapi/linux/quic.h>
+#include "cong.h"
+
+static void quic_reno_cwnd_update_after_timeout(struct quic_cong *cong, s64 number,
+						u32 transmit_ts, s64 last_number)
+{
+	u32 time_threshold;
+
+	if (number + 3 <= cong->max_acked_number) { /* packet loss check */
+		time_threshold = 9 * max(cong->smoothed_rtt, cong->latest_rtt) / 8;
+		time_threshold = max(time_threshold, 1000U);
+		if (jiffies_to_usecs(jiffies) - transmit_ts <= time_threshold)
+			return;
+
+		/* persistent congestion check */
+		time_threshold = cong->smoothed_rtt + max(4 * cong->rttvar, 1000U);
+		time_threshold = (time_threshold + cong->max_ack_delay) * 3;
+		if (jiffies_to_usecs(jiffies) - cong->max_acked_transmit_ts > time_threshold) {
+			pr_debug("[QUIC] %s permanent congestion, cwnd: %u threshold: %u\n",
+				 __func__, cong->window, cong->threshold);
+			cong->window = cong->mss * 2;
+			cong->state = QUIC_CONG_SLOW_START;
+		}
+	}
+
+	switch (cong->state) {
+	case QUIC_CONG_SLOW_START:
+		cong->prior_window = cong->window;
+		cong->prior_threshold = cong->threshold;
+		pr_debug("[QUIC] %s slow_start -> recovery, cwnd: %u threshold: %u\n",
+			 __func__, cong->window, cong->threshold);
+		break;
+	case QUIC_CONG_RECOVERY_PERIOD:
+		return;
+	case QUIC_CONG_CONGESTION_AVOIDANCE:
+		pr_debug("[QUIC] %s cong_avoid -> recovery, cwnd: %u threshold: %u\n",
+			 __func__, cong->window, cong->threshold);
+		break;
+	default:
+		pr_warn_once("[QUIC] %s wrong congestion state: %d", __func__, cong->state);
+		return;
+	}
+
+	cong->last_sent_number = last_number;
+	cong->state = QUIC_CONG_RECOVERY_PERIOD;
+	cong->threshold = max(cong->window >> 1U, cong->mss * 2);
+	cong->window = cong->threshold;
+}
+
+static void quic_reno_cwnd_update_after_sack(struct quic_cong *cong, s64 acked_number,
+					     u32 transmit_ts, u32 acked_bytes, u32 inflight)
+{
+	switch (cong->state) {
+	case QUIC_CONG_SLOW_START:
+		cong->window = min_t(u32, cong->window + acked_bytes, cong->max_window);
+		if (cong->window > cong->threshold) {
+			cong->prior_window = cong->window;
+			cong->prior_threshold = cong->threshold;
+			cong->state = QUIC_CONG_CONGESTION_AVOIDANCE;
+			pr_debug("[QUIC] %s slow_start -> cong_avoid, cwnd: %u threshold: %u\n",
+				 __func__, cong->window, cong->threshold);
+		}
+		break;
+	case QUIC_CONG_RECOVERY_PERIOD:
+		if (!inflight) {
+			cong->state = QUIC_CONG_SLOW_START;
+			if (cong->threshold < cong->prior_threshold)
+				cong->threshold = cong->prior_threshold;
+			cong->window = max(cong->window, cong->prior_window);
+			pr_debug("[QUIC] %s recovery -> slow_start, cwnd: %u threshold: %u\n",
+				 __func__, cong->window, cong->threshold);
+		} else if (cong->last_sent_number < acked_number) {
+			cong->state = QUIC_CONG_CONGESTION_AVOIDANCE;
+			pr_debug("[QUIC] %s recovery -> cong_avoid, cwnd: %u threshold: %u\n",
+				 __func__, cong->window, cong->threshold);
+		}
+		break;
+	case QUIC_CONG_CONGESTION_AVOIDANCE:
+		if (!inflight) {
+			cong->state = QUIC_CONG_SLOW_START;
+			if (cong->threshold < cong->prior_threshold)
+				cong->threshold = cong->prior_threshold;
+			cong->window = max(cong->window, cong->prior_window);
+			pr_debug("[QUIC] %s cong_avoid -> slow_start, cwnd: %u threshold: %u\n",
+				 __func__, cong->window, cong->threshold);
+		} else {
+			cong->window += cong->mss * acked_bytes / cong->window;
+		}
+		break;
+	default:
+		pr_warn_once("[QUIC] %s wrong congestion state: %d", __func__, cong->state);
+		return;
+	}
+
+	if (acked_number > cong->max_acked_number) {
+		cong->max_acked_number = acked_number;
+		cong->max_acked_transmit_ts = transmit_ts;
+	}
+}
+
+static void quic_reno_cwnd_update_after_ecn(struct quic_cong *cong)
+{
+	switch (cong->state) {
+	case QUIC_CONG_SLOW_START:
+		cong->prior_window = cong->window;
+		cong->prior_threshold = cong->threshold;
+		pr_debug("[QUIC] %s slow_start -> recovery, cwnd: %u threshold: %u\n",
+			 __func__, cong->window, cong->threshold);
+		break;
+	case QUIC_CONG_RECOVERY_PERIOD:
+		return;
+	case QUIC_CONG_CONGESTION_AVOIDANCE:
+		pr_debug("[QUIC] %s cong_avoid -> recovery, cwnd: %u threshold: %u\n",
+			 __func__, cong->window, cong->threshold);
+		break;
+	default:
+		pr_warn_once("[QUIC] %s wrong congestion state: %d", __func__, cong->state);
+		return;
+	}
+
+	cong->state = QUIC_CONG_RECOVERY_PERIOD;
+	cong->threshold = max(cong->window >> 1U, cong->mss * 2);
+	cong->window = cong->threshold;
+}
+
+static struct quic_cong_ops quic_congs[] = {
+	{ /* QUIC_CONG_ALG_RENO */
+		.quic_cwnd_update_after_sack = quic_reno_cwnd_update_after_sack,
+		.quic_cwnd_update_after_timeout = quic_reno_cwnd_update_after_timeout,
+		.quic_cwnd_update_after_ecn = quic_reno_cwnd_update_after_ecn,
+	},
+};
+
+void quic_cong_cwnd_update_after_timeout(struct quic_cong *cong, s64 number, u32 transmit_ts,
+					 s64 last_number)
+{
+	cong->ops->quic_cwnd_update_after_timeout(cong, number, transmit_ts,
+						  last_number);
+}
+EXPORT_SYMBOL_GPL(quic_cong_cwnd_update_after_timeout);
+
+void quic_cong_cwnd_update_after_sack(struct quic_cong *cong, s64 acked_number, u32 transmit_ts,
+				      u32 acked_bytes, u32 inflight)
+{
+	cong->ops->quic_cwnd_update_after_sack(cong, acked_number, transmit_ts,
+					       acked_bytes, inflight);
+}
+EXPORT_SYMBOL_GPL(quic_cong_cwnd_update_after_sack);
+
+void quic_cong_cwnd_update_after_ecn(struct quic_cong *cong)
+{
+	cong->ops->quic_cwnd_update_after_ecn(cong);
+}
+EXPORT_SYMBOL_GPL(quic_cong_cwnd_update_after_ecn);
+
+static void quic_cong_rto_update(struct quic_cong *cong)
+{
+	u32 rto;
+
+	rto = cong->smoothed_rtt + cong->rttvar;
+
+	if (rto < QUIC_RTO_MIN)
+		rto = QUIC_RTO_MIN;
+	else if (rto > QUIC_RTO_MAX)
+		rto = QUIC_RTO_MAX;
+
+	pr_debug("[QUIC] update rto %u\n", rto);
+	cong->rto = rto;
+}
+
+void quic_cong_set_param(struct quic_cong *cong, struct quic_transport_param *p)
+{
+	u8 alg = QUIC_CONG_ALG_RENO;
+
+	if (p->congestion_control_alg < QUIC_CONG_ALG_MAX)
+		alg = p->congestion_control_alg;
+
+	cong->max_window = p->max_data;
+	cong->max_ack_delay = p->max_ack_delay;
+	cong->ack_delay_exponent = p->ack_delay_exponent;
+	cong->latest_rtt = p->initial_smoothed_rtt;
+	cong->smoothed_rtt = cong->latest_rtt;
+	cong->rttvar = cong->smoothed_rtt / 2;
+	quic_cong_rto_update(cong);
+
+	cong->state = QUIC_CONG_SLOW_START;
+	cong->threshold = U32_MAX;
+	cong->ops = &quic_congs[alg];
+}
+EXPORT_SYMBOL_GPL(quic_cong_set_param);
+
+/* Estimating the Round-Trip Time */
+void quic_cong_rtt_update(struct quic_cong *cong, u32 transmit_ts, u32 ack_delay)
+{
+	u32 adjusted_rtt, rttvar_sample;
+
+	ack_delay = ack_delay * BIT(cong->ack_delay_exponent);
+	ack_delay = min(ack_delay, cong->max_ack_delay);
+
+	cong->latest_rtt = jiffies_to_usecs(jiffies) - transmit_ts;
+
+	if (!cong->min_rtt)
+		cong->min_rtt = cong->latest_rtt;
+
+	if (cong->min_rtt > cong->latest_rtt)
+		cong->min_rtt = cong->latest_rtt;
+
+	adjusted_rtt = cong->latest_rtt;
+	if (cong->latest_rtt >= cong->min_rtt + ack_delay)
+		adjusted_rtt = cong->latest_rtt - ack_delay;
+
+	cong->smoothed_rtt = (cong->smoothed_rtt * 7 + adjusted_rtt) / 8;
+	rttvar_sample = abs(cong->smoothed_rtt - adjusted_rtt);
+	cong->rttvar = (cong->rttvar * 3 + rttvar_sample) / 4;
+	quic_cong_rto_update(cong);
+}
+EXPORT_SYMBOL_GPL(quic_cong_rtt_update);
diff --git a/net/quic/cong.h b/net/quic/cong.h
new file mode 100644
index 000000000000..68f805f44cb7
--- /dev/null
+++ b/net/quic/cong.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_RTT_INIT		333000
+#define QUIC_RTO_MIN		100000
+#define QUIC_RTO_MAX		6000000
+
+enum quic_cong_state {
+	QUIC_CONG_SLOW_START,
+	QUIC_CONG_RECOVERY_PERIOD,
+	QUIC_CONG_CONGESTION_AVOIDANCE,
+};
+
+struct quic_cong {
+	u32 rto;
+	u32 rttvar;
+	u32 min_rtt;
+	u32 latest_rtt;
+	u32 smoothed_rtt;
+
+	s64 last_sent_number;
+	s64 max_acked_number;
+	u32 max_acked_transmit_ts;
+	u32 ack_delay_exponent;
+	u32 max_ack_delay;
+
+	u32 mss;
+	u32 window;
+	u32 max_window;
+	u32 prior_window;
+	u32 threshold;
+	u32 prior_threshold;
+
+	u8 state;
+	struct quic_cong_ops *ops;
+};
+
+struct quic_cong_ops {
+	void (*quic_cwnd_update_after_timeout)(struct quic_cong *cong, s64 number,
+					       u32 transmit_ts, s64 last_sent_number);
+	void (*quic_cwnd_update_after_sack)(struct quic_cong *cong, s64 acked_number,
+					    u32 transmit_ts, u32 acked_bytes, u32 inflight);
+	void (*quic_cwnd_update_after_ecn)(struct quic_cong *cong);
+};
+
+static inline void quic_cong_set_window(struct quic_cong *cong, u32 window)
+{
+	cong->window = window;
+}
+
+static inline void quic_cong_set_mss(struct quic_cong *cong, u32 mss)
+{
+	cong->mss = mss;
+}
+
+static inline u32 quic_cong_window(struct quic_cong *cong)
+{
+	return cong->window;
+}
+
+static inline u32 quic_cong_rto(struct quic_cong *cong)
+{
+	return cong->rto;
+}
+
+static inline u32 quic_cong_latest_rtt(struct quic_cong *cong)
+{
+	return cong->latest_rtt;
+}
+
+void quic_cong_set_param(struct quic_cong *cong, struct quic_transport_param *p);
+void quic_cong_rtt_update(struct quic_cong *cong, u32 transmit_ts, u32 ack_delay);
+void quic_cong_cwnd_update_after_timeout(struct quic_cong *cong, s64 number,
+					 u32 transmit_ts, s64 last_sent_number);
+void quic_cong_cwnd_update_after_sack(struct quic_cong *cong, s64 acked_number,
+				      u32 transmit_ts, u32 acked_bytes, u32 inflight);
+void quic_cong_cwnd_update_after_ecn(struct quic_cong *cong);
diff --git a/net/quic/connection.c b/net/quic/connection.c
new file mode 100644
index 000000000000..ab7fca7619dc
--- /dev/null
+++ b/net/quic/connection.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "uapi/linux/quic.h"
+#include <linux/jhash.h>
+#include <net/netns/hash.h>
+#include <net/sock.h>
+#include "hashtable.h"
+#include "connection.h"
+
+struct quic_connection_id *quic_connection_id_lookup(struct net *net, u8 *scid, u32 len)
+{
+	struct quic_hash_head *head = quic_source_connection_id_head(net, scid);
+	struct quic_source_connection_id *tmp, *s_conn_id = NULL;
+
+	spin_lock(&head->lock);
+	hlist_for_each_entry(tmp, &head->head, node) {
+		if (net == sock_net(tmp->sk) && tmp->common.id.len <= len &&
+		    !memcmp(scid, &tmp->common.id.data, tmp->common.id.len)) {
+			s_conn_id = tmp;
+			break;
+		}
+	}
+
+	spin_unlock(&head->lock);
+	return &s_conn_id->common.id;
+}
+
+bool quic_connection_id_token_exists(struct quic_connection_id_set *id_set, u8 *token)
+{
+	struct quic_common_connection_id *common;
+	struct quic_dest_connection_id *dcid;
+
+	dcid = (struct quic_dest_connection_id *)id_set->active;
+	if (!memcmp(dcid->token, token, 16)) /* fast path */
+		return true;
+
+	list_for_each_entry(common, &id_set->head, list) {
+		dcid = (struct quic_dest_connection_id *)common;
+		if (common == id_set->active)
+			continue;
+		if (!memcmp(dcid->token, token, 16))
+			return true;
+	}
+	return false;
+}
+
+static void quic_source_connection_id_free_rcu(struct rcu_head *head)
+{
+	struct quic_source_connection_id *s_conn_id =
+		container_of(head, struct quic_source_connection_id, rcu);
+
+	kfree(s_conn_id);
+}
+
+static void quic_source_connection_id_free(struct quic_source_connection_id *s_conn_id)
+{
+	u8 *data = s_conn_id->common.id.data;
+	struct quic_hash_head *head;
+
+	if (!hlist_unhashed(&s_conn_id->node)) {
+		head = quic_source_connection_id_head(sock_net(s_conn_id->sk), data);
+		spin_lock(&head->lock);
+		hlist_del_init(&s_conn_id->node);
+		spin_unlock(&head->lock);
+	}
+
+	call_rcu(&s_conn_id->rcu, quic_source_connection_id_free_rcu);
+}
+
+static void quic_connection_id_del(struct quic_common_connection_id *common)
+{
+	list_del(&common->list);
+	if (!common->hashed) {
+		kfree(common);
+		return;
+	}
+	quic_source_connection_id_free((struct quic_source_connection_id *)common);
+}
+
+int quic_connection_id_add(struct quic_connection_id_set *id_set,
+			   struct quic_connection_id *conn_id, u32 number, void *data)
+{
+	struct quic_common_connection_id *common, *last;
+	struct quic_source_connection_id *s_conn_id;
+	struct quic_dest_connection_id *d_conn_id;
+	struct quic_hash_head *head;
+	struct list_head *list;
+
+	if (conn_id->len > 20)
+		return -EINVAL;
+	common = kzalloc(id_set->entry_size, GFP_ATOMIC);
+	if (!common)
+		return -ENOMEM;
+	common->id = *conn_id;
+	common->number = number;
+
+	list = &id_set->head;
+	if (!list_empty(list)) {
+		last = list_last_entry(list, struct quic_common_connection_id, list);
+		if (common->number != last->number + 1) {
+			kfree(common);
+			return -EINVAL;
+		}
+	}
+	list_add_tail(&common->list, list);
+	if (!id_set->active)
+		id_set->active = common;
+	id_set->count++;
+
+	if (id_set->entry_size == sizeof(struct quic_dest_connection_id)) {
+		if (data) {
+			d_conn_id = (struct quic_dest_connection_id *)common;
+			memcpy(d_conn_id->token, data, 16);
+		}
+		return 0;
+	}
+
+	common->hashed = 1;
+	s_conn_id = (struct quic_source_connection_id *)common;
+	s_conn_id->sk = data;
+	head = quic_source_connection_id_head(sock_net(data), common->id.data);
+	spin_lock(&head->lock);
+	hlist_add_head(&s_conn_id->node, &head->head);
+	spin_unlock(&head->lock);
+	return 0;
+}
+
+void quic_connection_id_remove(struct quic_connection_id_set *id_set, u32 number)
+{
+	struct quic_common_connection_id *common, *tmp;
+	struct list_head *list;
+
+	list = &id_set->head;
+	list_for_each_entry_safe(common, tmp, list, list)
+		if (common->number <= number)
+			quic_connection_id_del(common);
+
+	id_set->active = list_first_entry(list, struct quic_common_connection_id, list);
+}
+
+void quic_connection_id_set_init(struct quic_connection_id_set *id_set, bool source)
+{
+	id_set->entry_size = source ? sizeof(struct quic_source_connection_id)
+				    : sizeof(struct quic_dest_connection_id);
+	INIT_LIST_HEAD(&id_set->head);
+}
+
+void quic_connection_id_set_free(struct quic_connection_id_set *id_set)
+{
+	struct quic_common_connection_id *common, *tmp;
+
+	list_for_each_entry_safe(common, tmp, &id_set->head, list)
+		quic_connection_id_del(common);
+	id_set->active = NULL;
+}
+
+void quic_connection_id_set_param(struct quic_connection_id_set *id_set,
+				  struct quic_transport_param *p)
+{
+	id_set->max_count = p->active_connection_id_limit;
+	id_set->disable_active_migration = p->disable_active_migration;
+}
diff --git a/net/quic/connection.h b/net/quic/connection.h
new file mode 100644
index 000000000000..d25955fd7dd8
--- /dev/null
+++ b/net/quic/connection.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+struct quic_connection_id {
+	u8 len;
+	u8 data[20];
+};
+
+struct quic_common_connection_id {
+	struct quic_connection_id id;
+	struct list_head list;
+	u32 number;
+	u8 hashed;
+};
+
+struct quic_source_connection_id {
+	struct quic_common_connection_id common;
+	struct hlist_node node;
+	struct rcu_head rcu;
+	struct sock *sk;
+};
+
+struct quic_dest_connection_id {
+	struct quic_common_connection_id common;
+	u8 token[16];
+};
+
+struct quic_connection_id_set {
+	struct quic_common_connection_id *active;
+	struct list_head head;
+	u32 entry_size;
+	u32 max_count;
+	u32 count;
+	u8 disable_active_migration;
+	u8 pending;
+};
+
+static inline u32 quic_connection_id_last_number(struct quic_connection_id_set *id_set)
+{
+	struct quic_common_connection_id *common;
+
+	common = list_last_entry(&id_set->head, struct quic_common_connection_id, list);
+	return common->number;
+}
+
+static inline u32 quic_connection_id_first_number(struct quic_connection_id_set *id_set)
+{
+	struct quic_common_connection_id *common;
+
+	common = list_first_entry(&id_set->head, struct quic_common_connection_id, list);
+	return common->number;
+}
+
+static inline void quic_connection_id_generate(struct quic_connection_id *conn_id, int conn_id_len)
+{
+	get_random_bytes(conn_id->data, conn_id_len);
+	conn_id->len = conn_id_len;
+}
+
+static inline void quic_connection_id_update(struct quic_connection_id *conn_id, u8 *data, u32 len)
+{
+	memcpy(conn_id->data, data, len);
+	conn_id->len = len;
+}
+
+static inline u8 quic_connection_id_disable_active_migration(struct quic_connection_id_set *id_set)
+{
+	return id_set->disable_active_migration;
+}
+
+static inline u32 quic_connection_id_max_count(struct quic_connection_id_set *id_set)
+{
+	return id_set->max_count;
+}
+
+static inline
+struct quic_connection_id *quic_connection_id_active(struct quic_connection_id_set *id_set)
+{
+	return &id_set->active->id;
+}
+
+static inline u32 quic_connection_id_number(struct quic_connection_id *conn_id)
+{
+	return ((struct quic_common_connection_id *)conn_id)->number;
+}
+
+static inline struct sock *quic_connection_id_sk(struct quic_connection_id *conn_id)
+{
+	return ((struct quic_source_connection_id *)conn_id)->sk;
+}
+
+static inline void quic_connection_id_set_token(struct quic_connection_id *conn_id, u8 *token)
+{
+	memcpy(((struct quic_dest_connection_id *)conn_id)->token, token, 16);
+}
+
+static inline int quic_connection_id_cmp(struct quic_connection_id *a, struct quic_connection_id *b)
+{
+	return a->len != b->len || memcmp(a->data, b->data, a->len);
+}
+
+struct quic_connection_id *quic_connection_id_lookup(struct net *net, u8 *scid, u32 len);
+bool quic_connection_id_token_exists(struct quic_connection_id_set *id_set, u8 *token);
+int quic_connection_id_add(struct quic_connection_id_set *id_set,
+			   struct quic_connection_id *conn_id, u32 number, void *data);
+void quic_connection_id_remove(struct quic_connection_id_set *id_set, u32 number);
+void quic_connection_id_set_init(struct quic_connection_id_set *id_set, bool source);
+void quic_connection_id_set_free(struct quic_connection_id_set *id_set);
+void quic_connection_id_set_param(struct quic_connection_id_set *id_set,
+				  struct quic_transport_param *p);
diff --git a/net/quic/crypto.c b/net/quic/crypto.c
new file mode 100644
index 000000000000..f240d6a74e7f
--- /dev/null
+++ b/net/quic/crypto.c
@@ -0,0 +1,979 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <uapi/linux/quic.h>
+#include <crypto/skcipher.h>
+#include <net/netns/hash.h>
+#include <net/udp_tunnel.h>
+#include <linux/skbuff.h>
+#include <linux/jhash.h>
+#include <crypto/aead.h>
+#include <crypto/hash.h>
+#include "connection.h"
+#include "hashtable.h"
+#include <net/tls.h>
+#include "protocol.h"
+#include "crypto.h"
+#include "number.h"
+#include "stream.h"
+#include "frame.h"
+
+struct tls_vec {
+	u8 *data;
+	u32  len;
+};
+
+static struct tls_vec *tls_vec(struct tls_vec *vec, u8 *data, u32 len)
+{
+	vec->data = data;
+	vec->len  = len;
+	return vec;
+}
+
+static int tls_crypto_hkdf_extract(struct crypto_shash *tfm, struct tls_vec *srt,
+				   struct tls_vec *hash, struct tls_vec *key)
+{
+	int err;
+
+	err = crypto_shash_setkey(tfm, srt->data, srt->len);
+	if (err)
+		return err;
+
+	return crypto_shash_tfm_digest(tfm, hash->data, hash->len, key->data);
+}
+
+static int tls_crypto_hkdf_expand(struct crypto_shash *tfm, struct tls_vec *srt,
+				  struct tls_vec *label, struct tls_vec *hash, struct tls_vec *key)
+{
+	u8 cnt = 1, info[256], *p = info, *prev = NULL;
+	u8 LABEL[] = "tls13 ", tmp[48];
+	SHASH_DESC_ON_STACK(desc, tfm);
+	int err, i, infolen;
+
+	*p++ = (u8)(key->len / 256);
+	*p++ = (u8)(key->len % 256);
+	*p++ = (u8)(sizeof(LABEL) - 1 + label->len);
+	memcpy(p, LABEL, sizeof(LABEL) - 1);
+	p += sizeof(LABEL) - 1;
+	memcpy(p, label->data, label->len);
+	p += label->len;
+	if (hash) {
+		*p++ = hash->len;
+		memcpy(p, hash->data, hash->len);
+		p += hash->len;
+	} else {
+		*p++ = 0;
+	}
+	infolen = (int)(p - info);
+
+	desc->tfm = tfm;
+	err = crypto_shash_setkey(tfm, srt->data, srt->len);
+	if (err)
+		return err;
+	for (i = 0; i < key->len; i += srt->len) {
+		err = crypto_shash_init(desc);
+		if (err)
+			goto out;
+		if (prev) {
+			err = crypto_shash_update(desc, prev, srt->len);
+			if (err)
+				goto out;
+		}
+		err = crypto_shash_update(desc, info, infolen);
+		if (err)
+			goto out;
+		BUILD_BUG_ON(sizeof(cnt) != 1);
+		if (key->len - i < srt->len) {
+			err = crypto_shash_finup(desc, &cnt, 1, tmp);
+			if (err)
+				goto out;
+			memcpy(&key->data[i], tmp, key->len - i);
+			memzero_explicit(tmp, sizeof(tmp));
+		} else {
+			err = crypto_shash_finup(desc, &cnt, 1, &key->data[i]);
+			if (err)
+				goto out;
+		}
+		cnt++;
+		prev = &key->data[i];
+	}
+out:
+	shash_desc_zero(desc);
+	return err;
+}
+
+#define KEY_LABEL_V1		"quic key"
+#define IV_LABEL_V1		"quic iv"
+#define HP_KEY_LABEL_V1		"quic hp"
+
+#define KEY_LABEL_V2		"quicv2 key"
+#define IV_LABEL_V2		"quicv2 iv"
+#define HP_KEY_LABEL_V2		"quicv2 hp"
+
+static int quic_crypto_keys_derive(struct crypto_shash *tfm, struct tls_vec *s, struct tls_vec *k,
+				   struct tls_vec *i, struct tls_vec *hp_k, u32 version)
+{
+	struct tls_vec hp_k_l = {HP_KEY_LABEL_V1, 7}, k_l = {KEY_LABEL_V1, 8};
+	struct tls_vec i_l = {IV_LABEL_V1, 7};
+	struct tls_vec z = {NULL, 0};
+	int err;
+
+	if (version == QUIC_VERSION_V2) {
+		tls_vec(&hp_k_l, HP_KEY_LABEL_V2, 9);
+		tls_vec(&k_l, KEY_LABEL_V2, 10);
+		tls_vec(&i_l, IV_LABEL_V2, 9);
+	}
+
+	err = tls_crypto_hkdf_expand(tfm, s, &k_l, &z, k);
+	if (err)
+		return err;
+	err = tls_crypto_hkdf_expand(tfm, s, &i_l, &z, i);
+	if (err)
+		return err;
+	/* Don't change hp key for key update */
+	if (!hp_k)
+		return 0;
+
+	return tls_crypto_hkdf_expand(tfm, s, &hp_k_l, &z, hp_k);
+}
+
+static int quic_crypto_tx_keys_derive_and_install(struct quic_crypto *crypto)
+{
+	struct tls_vec srt = {NULL, 0}, k, iv, hp_k = {}, *hp = NULL;
+	int err, phase = crypto->key_phase;
+	u32 keylen, ivlen = QUIC_IV_LEN;
+	u8 tx_key[32], tx_hp_key[32];
+
+	keylen = crypto->cipher->keylen;
+	tls_vec(&srt, crypto->tx_secret, crypto->cipher->secretlen);
+	tls_vec(&k, tx_key, keylen);
+	tls_vec(&iv, crypto->tx_iv[phase], ivlen);
+	if (!crypto->key_pending)
+		hp = tls_vec(&hp_k, tx_hp_key, keylen);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(crypto->tx_tfm[phase], QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(crypto->tx_tfm[phase], tx_key, keylen);
+	if (err)
+		return err;
+	if (hp) {
+		err = crypto_skcipher_setkey(crypto->tx_hp_tfm, tx_hp_key, keylen);
+		if (err)
+			return err;
+	}
+	pr_debug("[QUIC] tx keys: %16phN, %12phN, %16phN\n", k.data, iv.data, hp_k.data);
+	return 0;
+}
+
+static int quic_crypto_rx_keys_derive_and_install(struct quic_crypto *crypto)
+{
+	struct tls_vec srt = {NULL, 0}, k, iv, hp_k = {}, *hp = NULL;
+	int err, phase = crypto->key_phase;
+	u32 keylen, ivlen = QUIC_IV_LEN;
+	u8 rx_key[32], rx_hp_key[32];
+
+	keylen = crypto->cipher->keylen;
+	tls_vec(&srt, crypto->rx_secret, crypto->cipher->secretlen);
+	tls_vec(&k, rx_key, keylen);
+	tls_vec(&iv, crypto->rx_iv[phase], ivlen);
+	if (!crypto->key_pending)
+		hp = tls_vec(&hp_k, rx_hp_key, keylen);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(crypto->rx_tfm[phase], QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(crypto->rx_tfm[phase], rx_key, keylen);
+	if (err)
+		return err;
+	if (hp) {
+		err = crypto_skcipher_setkey(crypto->rx_hp_tfm, rx_hp_key, keylen);
+		if (err)
+			return err;
+	}
+	pr_debug("[QUIC] rx keys: %16phN, %12phN, %16phN\n", k.data, iv.data, hp_k.data);
+	return 0;
+}
+
+static void *quic_crypto_skcipher_mem_alloc(struct crypto_skcipher *tfm, u32 mask_size,
+					    u8 **iv, struct skcipher_request **req)
+{
+	unsigned int iv_size, req_size;
+	unsigned int len;
+	u8 *mem;
+
+	iv_size = crypto_skcipher_ivsize(tfm);
+	req_size = sizeof(**req) + crypto_skcipher_reqsize(tfm);
+
+	len = mask_size;
+	len += iv_size;
+	len += crypto_skcipher_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+	len += req_size;
+
+	mem = kzalloc(len, GFP_ATOMIC);
+	if (!mem)
+		return NULL;
+
+	*iv = (u8 *)PTR_ALIGN(mem + mask_size, crypto_skcipher_alignmask(tfm) + 1);
+	*req = (struct skcipher_request *)PTR_ALIGN(*iv + iv_size,
+			crypto_tfm_ctx_alignment());
+
+	return (void *)mem;
+}
+
+static int quic_crypto_header_encrypt(struct crypto_skcipher *tfm, struct sk_buff *skb,
+				      struct quic_packet_info *pki, bool chacha)
+{
+	struct skcipher_request *req;
+	struct scatterlist sg;
+	u8 *mask, *iv, *p;
+	int err, i;
+
+	mask = quic_crypto_skcipher_mem_alloc(tfm, 16, &iv, &req);
+	if (!mask)
+		return -ENOMEM;
+
+	memcpy((chacha ? iv : mask), skb->data + pki->number_offset + 4, 16);
+	sg_init_one(&sg, mask, 16);
+	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_crypt(req, &sg, &sg, 16, iv);
+	err = crypto_skcipher_encrypt(req);
+	if (err)
+		goto err;
+
+	p = skb->data;
+	*p = (u8)(*p ^ (mask[0] & (((*p & 0x80) == 0x80) ? 0x0f : 0x1f)));
+	p = skb->data + pki->number_offset;
+	for (i = 1; i <= pki->number_len; i++)
+		*p++ ^= mask[i];
+err:
+	kfree(mask);
+	return err;
+}
+
+static void *quic_crypto_aead_mem_alloc(struct crypto_aead *tfm, u32 ctx_size,
+					u8 **iv, struct aead_request **req,
+					struct scatterlist **sg, int nsg)
+{
+	unsigned int iv_size, req_size;
+	unsigned int len;
+	u8 *mem;
+
+	iv_size = crypto_aead_ivsize(tfm);
+	req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
+
+	len = ctx_size;
+	len += iv_size;
+	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+	len += req_size;
+	len = ALIGN(len, __alignof__(struct scatterlist));
+	len += nsg * sizeof(**sg);
+
+	mem = kzalloc(len, GFP_ATOMIC);
+	if (!mem)
+		return NULL;
+
+	*iv = (u8 *)PTR_ALIGN(mem + ctx_size, crypto_aead_alignmask(tfm) + 1);
+	*req = (struct aead_request *)PTR_ALIGN(*iv + iv_size,
+			crypto_tfm_ctx_alignment());
+	*sg = (struct scatterlist *)PTR_ALIGN((u8 *)*req + req_size,
+			__alignof__(struct scatterlist));
+
+	return (void *)mem;
+}
+
+static void quic_crypto_destruct_skb(struct sk_buff *skb)
+{
+	kfree(skb_shinfo(skb)->destructor_arg);
+	sock_efree(skb);
+}
+
+static int quic_crypto_payload_encrypt(struct crypto_aead *tfm, struct sk_buff *skb,
+				       struct quic_packet_info *pki, u8 *tx_iv, bool ccm)
+{
+	struct quichdr *hdr = quic_hdr(skb);
+	u8 *iv, i, nonce[QUIC_IV_LEN];
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	int nsg, err, hlen, len;
+	struct scatterlist *sg;
+	void *ctx;
+	__be64 n;
+
+	len = skb->len;
+	nsg = skb_cow_data(skb, QUIC_TAG_LEN, &trailer);
+	if (nsg < 0)
+		return nsg;
+	pskb_put(skb, trailer, QUIC_TAG_LEN);
+	hdr->key = pki->key_phase;
+
+	ctx = quic_crypto_aead_mem_alloc(tfm, 0, &iv, &req, &sg, nsg);
+	if (!ctx)
+		return -ENOMEM;
+
+	sg_init_table(sg, nsg);
+	err = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (err < 0)
+		goto err;
+
+	hlen = pki->number_offset + pki->number_len;
+	memcpy(nonce, tx_iv, QUIC_IV_LEN);
+	n = cpu_to_be64(pki->number);
+	for (i = 0; i < 8; i++)
+		nonce[QUIC_IV_LEN - 8 + i] ^= ((u8 *)&n)[i];
+
+	iv[0] = TLS_AES_CCM_IV_B0_BYTE;
+	memcpy(&iv[ccm], nonce, QUIC_IV_LEN);
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_ad(req, hlen);
+	aead_request_set_crypt(req, sg, sg, len - hlen, iv);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG, pki->crypto_done, skb);
+
+	err = crypto_aead_encrypt(req);
+	if (err == -EINPROGRESS) {
+		skb->destructor = quic_crypto_destruct_skb;
+		skb_shinfo(skb)->destructor_arg = ctx;
+		return err;
+	}
+
+err:
+	kfree(ctx);
+	return err;
+}
+
+static int quic_crypto_payload_decrypt(struct crypto_aead *tfm, struct sk_buff *skb,
+				       struct quic_packet_info *pki, u8 *rx_iv, bool ccm)
+{
+	u8 *iv, i, nonce[QUIC_IV_LEN];
+	struct aead_request *req;
+	struct sk_buff *trailer;
+	int nsg, hlen, len, err;
+	struct scatterlist *sg;
+	void *ctx;
+	__be64 n;
+
+	len = pki->length + pki->number_offset;
+	hlen = pki->number_offset + pki->number_len;
+	if (len - hlen < QUIC_TAG_LEN)
+		return -EINVAL;
+	nsg = skb_cow_data(skb, 0, &trailer);
+	if (nsg < 0)
+		return nsg;
+	ctx = quic_crypto_aead_mem_alloc(tfm, 0, &iv, &req, &sg, nsg);
+	if (!ctx)
+		return -ENOMEM;
+
+	sg_init_table(sg, nsg);
+	err = skb_to_sgvec(skb, sg, 0, len);
+	if (err < 0)
+		goto err;
+
+	memcpy(nonce, rx_iv, QUIC_IV_LEN);
+	n = cpu_to_be64(pki->number);
+	for (i = 0; i < 8; i++)
+		nonce[QUIC_IV_LEN - 8 + i] ^= ((u8 *)&n)[i];
+
+	iv[0] = TLS_AES_CCM_IV_B0_BYTE;
+	memcpy(&iv[ccm], nonce, QUIC_IV_LEN);
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_ad(req, hlen);
+	aead_request_set_crypt(req, sg, sg, len - hlen, iv);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG, pki->crypto_done, skb);
+
+	err = crypto_aead_decrypt(req);
+	if (err == -EINPROGRESS) {
+		skb->destructor = quic_crypto_destruct_skb;
+		skb_shinfo(skb)->destructor_arg = ctx;
+		return err;
+	}
+err:
+	kfree(ctx);
+	return err;
+}
+
+static int quic_crypto_header_decrypt(struct crypto_skcipher *tfm, struct sk_buff *skb,
+				      struct quic_packet_info *pki, bool chacha)
+{
+	struct quichdr *hdr = quic_hdr(skb);
+	struct skcipher_request *req;
+	struct scatterlist sg;
+	u8 *mask, *iv, *p;
+	int err, i;
+
+	mask = quic_crypto_skcipher_mem_alloc(tfm, 16, &iv, &req);
+	if (!mask)
+		return -ENOMEM;
+
+	if (pki->length + pki->number_offset < pki->number_offset + 4 + 16) {
+		err = -EINVAL;
+		goto err;
+	}
+	p = (u8 *)hdr + pki->number_offset;
+	memcpy((chacha ? iv : mask), p + 4, 16);
+	sg_init_one(&sg, mask, 16);
+	skcipher_request_set_tfm(req, tfm);
+	skcipher_request_set_crypt(req, &sg, &sg, 16, iv);
+	err = crypto_skcipher_encrypt(req);
+	if (err)
+		goto err;
+
+	p = (u8 *)hdr;
+	*p = (u8)(*p ^ (mask[0] & (((*p & 0x80) == 0x80) ? 0x0f : 0x1f)));
+	pki->number_len = (*p & 0x03) + 1;
+	if (pki->length + pki->number_offset < pki->number_offset + pki->number_len) {
+		err = -EINVAL;
+		goto err;
+	}
+	p += pki->number_offset;
+	for (i = 0; i < pki->number_len; ++i)
+		*(p + i) = *((u8 *)hdr + pki->number_offset + i) ^ mask[i + 1];
+
+	pki->number = quic_get_int(&p, pki->number_len);
+	pki->number = quic_get_num(pki->number_max, pki->number, pki->number_len);
+	pki->key_phase = hdr->key;
+
+err:
+	kfree(mask);
+	return err;
+}
+
+#define QUIC_CIPHER_MIN TLS_CIPHER_AES_GCM_128
+#define QUIC_CIPHER_MAX TLS_CIPHER_CHACHA20_POLY1305
+
+#define TLS_CIPHER_AES_GCM_128_SECRET_SIZE		32
+#define TLS_CIPHER_AES_GCM_256_SECRET_SIZE		48
+#define TLS_CIPHER_AES_CCM_128_SECRET_SIZE		32
+#define TLS_CIPHER_CHACHA20_POLY1305_SECRET_SIZE	32
+
+#define CIPHER_DESC(type, aead_name, skc_name, sha_name)[type - QUIC_CIPHER_MIN] = { \
+	.secretlen = type ## _SECRET_SIZE, \
+	.keylen = type ## _KEY_SIZE, \
+	.aead = aead_name, \
+	.skc = skc_name, \
+	.shash = sha_name, \
+}
+
+static struct quic_cipher ciphers[QUIC_CIPHER_MAX + 1 - QUIC_CIPHER_MIN] = {
+	CIPHER_DESC(TLS_CIPHER_AES_GCM_128, "gcm(aes)", "ecb(aes)", "hmac(sha256)"),
+	CIPHER_DESC(TLS_CIPHER_AES_GCM_256, "gcm(aes)", "ecb(aes)", "hmac(sha384)"),
+	CIPHER_DESC(TLS_CIPHER_AES_CCM_128, "ccm(aes)", "ecb(aes)", "hmac(sha256)"),
+	CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305,
+		    "rfc7539(chacha20,poly1305)", "chacha20", "hmac(sha256)"),
+};
+
+static bool quic_crypto_is_cipher_ccm(struct quic_crypto *crypto)
+{
+	return crypto->cipher_type == TLS_CIPHER_AES_CCM_128;
+}
+
+static bool quic_crypto_is_cipher_chacha(struct quic_crypto *crypto)
+{
+	return crypto->cipher_type == TLS_CIPHER_CHACHA20_POLY1305;
+}
+
+int quic_crypto_encrypt(struct quic_crypto *crypto, struct sk_buff *skb,
+			struct quic_packet_info *pki)
+{
+	int err, phase = crypto->key_phase;
+	u8 *iv, cha, ccm;
+
+	pki->key_phase = phase;
+	iv = crypto->tx_iv[phase];
+	if (pki->resume)
+		goto out;
+
+	if (crypto->key_pending && !crypto->key_update_send_ts)
+		crypto->key_update_send_ts = jiffies_to_usecs(jiffies);
+
+	ccm = quic_crypto_is_cipher_ccm(crypto);
+	err = quic_crypto_payload_encrypt(crypto->tx_tfm[phase], skb, pki, iv, ccm);
+	if (err)
+		return err;
+out:
+	cha = quic_crypto_is_cipher_chacha(crypto);
+	return quic_crypto_header_encrypt(crypto->tx_hp_tfm, skb, pki, cha);
+}
+EXPORT_SYMBOL_GPL(quic_crypto_encrypt);
+
+int quic_crypto_decrypt(struct quic_crypto *crypto, struct sk_buff *skb,
+			struct quic_packet_info *pki)
+{
+	int err = 0, phase;
+	u8 *iv, cha, ccm;
+
+	if (pki->resume)
+		goto out;
+
+	cha = quic_crypto_is_cipher_chacha(crypto);
+	err = quic_crypto_header_decrypt(crypto->rx_hp_tfm, skb, pki, cha);
+	if (err) {
+		pr_warn("[QUIC] hd decrypt err %d\n", err);
+		return err;
+	}
+
+	if (pki->key_phase != crypto->key_phase && !crypto->key_pending) {
+		err = quic_crypto_key_update(crypto);
+		if (err) {
+			pki->errcode = QUIC_TRANSPORT_ERROR_KEY_UPDATE;
+			return err;
+		}
+	}
+
+	phase = pki->key_phase;
+	iv = crypto->rx_iv[phase];
+	ccm = quic_crypto_is_cipher_ccm(crypto);
+	err = quic_crypto_payload_decrypt(crypto->rx_tfm[phase], skb, pki, iv, ccm);
+	if (err)
+		return err;
+
+out:
+	/* An endpoint MUST retain old keys until it has successfully unprotected a
+	 * packet sent using the new keys. An endpoint SHOULD retain old keys for
+	 * some time after unprotecting a packet sent using the new keys.
+	 */
+	if (pki->key_phase == crypto->key_phase &&
+	    crypto->key_pending && crypto->key_update_send_ts &&
+	    jiffies_to_usecs(jiffies) - crypto->key_update_send_ts >= crypto->key_update_ts)
+		pki->key_update = 1;
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_decrypt);
+
+int quic_crypto_set_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt,
+			   u32 version, u8 flag)
+{
+	int err, secretlen, keylen;
+	struct quic_cipher *cipher;
+	void *tfm;
+
+	if (!crypto->cipher) {
+		crypto->version = version;
+		if (srt->type < QUIC_CIPHER_MIN || srt->type > QUIC_CIPHER_MAX)
+			return -EINVAL;
+
+		cipher = &ciphers[srt->type - QUIC_CIPHER_MIN];
+		tfm = crypto_alloc_shash(cipher->shash, 0, 0);
+		if (IS_ERR(tfm))
+			return PTR_ERR(tfm);
+		crypto->secret_tfm = tfm;
+
+		tfm = crypto_alloc_aead(cipher->aead, 0, CRYPTO_ALG_ASYNC);
+		if (IS_ERR(tfm)) {
+			err = PTR_ERR(tfm);
+			goto err;
+		}
+		crypto->tag_tfm = tfm;
+		crypto->cipher = cipher;
+		crypto->cipher_type = srt->type;
+	}
+
+	cipher = crypto->cipher;
+	secretlen = cipher->secretlen;
+	keylen = cipher->keylen;
+	if (!srt->send) {
+		memcpy(crypto->rx_secret, srt->secret, secretlen);
+		tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+		if (IS_ERR(tfm)) {
+			err = PTR_ERR(tfm);
+			goto err;
+		}
+		crypto->rx_tfm[0] = tfm;
+		tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+		if (IS_ERR(tfm)) {
+			err = PTR_ERR(tfm);
+			goto err;
+		}
+		crypto->rx_tfm[1] = tfm;
+		tfm = crypto_alloc_sync_skcipher(cipher->skc, 0, 0);
+		if (IS_ERR(tfm)) {
+			err = PTR_ERR(tfm);
+			goto err;
+		}
+		crypto->rx_hp_tfm = tfm;
+
+		err = quic_crypto_rx_keys_derive_and_install(crypto);
+		if (err)
+			goto err;
+		crypto->recv_ready = 1;
+		return 0;
+	}
+
+	memcpy(crypto->tx_secret, srt->secret, secretlen);
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_tfm[0] = tfm;
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_tfm[1] = tfm;
+	tfm = crypto_alloc_sync_skcipher(cipher->skc, 0, 0);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_hp_tfm = tfm;
+	err = quic_crypto_tx_keys_derive_and_install(crypto);
+	if (err)
+		goto err;
+	crypto->send_ready = 1;
+	return 0;
+err:
+	quic_crypto_destroy(crypto);
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_set_secret);
+
+int quic_crypto_get_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt)
+{
+	u8 *secret;
+
+	if (!crypto->cipher)
+		return -EINVAL;
+	srt->type = crypto->cipher_type;
+	secret = srt->send ? crypto->tx_secret : crypto->rx_secret;
+	memcpy(srt->secret, secret, crypto->cipher->secretlen);
+	return 0;
+}
+
+#define LABEL_V1	"quic ku"
+#define LABEL_V2	"quicv2 ku"
+
+int quic_crypto_key_update(struct quic_crypto *crypto)
+{
+	u8 tx_secret[QUIC_SECRET_LEN], rx_secret[QUIC_SECRET_LEN];
+	struct tls_vec l = {LABEL_V1, 7}, z = {NULL, 0}, k, srt;
+	int err, secret_len;
+
+	if (crypto->key_pending || !crypto->recv_ready)
+		return -EINVAL;
+
+	secret_len = crypto->cipher->secretlen;
+	if (crypto->version == QUIC_VERSION_V2)
+		tls_vec(&l, LABEL_V2, 9);
+
+	crypto->key_pending = 1;
+	memcpy(tx_secret, crypto->tx_secret, secret_len);
+	memcpy(rx_secret, crypto->rx_secret, secret_len);
+	crypto->key_phase = !crypto->key_phase;
+
+	tls_vec(&srt, tx_secret, secret_len);
+	tls_vec(&k, crypto->tx_secret, secret_len);
+	err = tls_crypto_hkdf_expand(crypto->secret_tfm, &srt, &l, &z, &k);
+	if (err)
+		goto err;
+	err = quic_crypto_tx_keys_derive_and_install(crypto);
+	if (err)
+		goto err;
+
+	tls_vec(&srt, rx_secret, secret_len);
+	tls_vec(&k, crypto->rx_secret, secret_len);
+	err = tls_crypto_hkdf_expand(crypto->secret_tfm, &srt, &l, &z, &k);
+	if (err)
+		goto err;
+	err = quic_crypto_rx_keys_derive_and_install(crypto);
+	if (err)
+		goto err;
+	return 0;
+err:
+	crypto->key_pending = 0;
+	memcpy(crypto->tx_secret, tx_secret, secret_len);
+	memcpy(crypto->rx_secret, rx_secret, secret_len);
+	crypto->key_phase = !crypto->key_phase;
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_key_update);
+
+void quic_crypto_set_key_update_ts(struct quic_crypto *crypto, u32 key_update_ts)
+{
+	crypto->key_update_ts = key_update_ts;
+}
+
+void quic_crypto_destroy(struct quic_crypto *crypto)
+{
+	crypto_free_aead(crypto->tag_tfm);
+	crypto_free_aead(crypto->rx_tfm[0]);
+	crypto_free_aead(crypto->rx_tfm[1]);
+	crypto_free_aead(crypto->tx_tfm[0]);
+	crypto_free_aead(crypto->tx_tfm[1]);
+	crypto_free_shash(crypto->secret_tfm);
+	crypto_free_skcipher(crypto->rx_hp_tfm);
+	crypto_free_skcipher(crypto->tx_hp_tfm);
+
+	memset(crypto, 0, sizeof(*crypto));
+}
+EXPORT_SYMBOL_GPL(quic_crypto_destroy);
+
+#define QUIC_INITIAL_SALT_V1    \
+	"\x38\x76\x2c\xf7\xf5\x59\x34\xb3\x4d\x17\x9a\xe6\xa4\xc8\x0c\xad\xcc\xbb\x7f\x0a"
+#define QUIC_INITIAL_SALT_V2    \
+	"\x0d\xed\xe3\xde\xf7\x00\xa6\xdb\x81\x93\x81\xbe\x6e\x26\x9d\xcb\xf9\xbd\x2e\xd9"
+
+int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struct quic_connection_id *conn_id,
+				     u32 version, u8 flag, bool is_serv)
+{
+	struct tls_vec salt, s, k, l, dcid, z = {NULL, 0};
+	struct quic_crypto_secret srt = {};
+	struct crypto_shash *tfm;
+	char *tl, *rl, *sal;
+	u8 secret[32];
+	int err;
+
+	tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+	if (is_serv) {
+		rl = "client in";
+		tl = "server in";
+	} else {
+		tl = "client in";
+		rl = "server in";
+	}
+	crypto->version = version;
+	sal = QUIC_INITIAL_SALT_V1;
+	if (version == QUIC_VERSION_V2)
+		sal = QUIC_INITIAL_SALT_V2;
+	tls_vec(&salt, sal, 20);
+	tls_vec(&dcid, conn_id->data, conn_id->len);
+	tls_vec(&s, secret, 32);
+	err = tls_crypto_hkdf_extract(tfm, &salt, &dcid, &s);
+	if (err)
+		goto out;
+
+	tls_vec(&l, tl, 9);
+	tls_vec(&k, srt.secret, 32);
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	srt.send = 1;
+	err = tls_crypto_hkdf_expand(tfm, &s, &l, &z, &k);
+	if (err)
+		goto out;
+	err = quic_crypto_set_secret(crypto, &srt, version, flag);
+	if (err)
+		goto out;
+
+	tls_vec(&l, rl, 9);
+	tls_vec(&k, srt.secret, 32);
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	srt.send = 0;
+	err = tls_crypto_hkdf_expand(tfm, &s, &l, &z, &k);
+	if (err)
+		goto out;
+	err = quic_crypto_set_secret(crypto, &srt, version, flag);
+out:
+	crypto_free_shash(tfm);
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_initial_keys_install);
+
+#define QUIC_RETRY_KEY_V1 "\xbe\x0c\x69\x0b\x9f\x66\x57\x5a\x1d\x76\x6b\x54\xe3\x68\xc8\x4e"
+#define QUIC_RETRY_KEY_V2 "\x8f\xb4\xb0\x1b\x56\xac\x48\xe2\x60\xfb\xcb\xce\xad\x7c\xcc\x92"
+
+#define QUIC_RETRY_NONCE_V1 "\x46\x15\x99\xd3\x5d\x63\x2b\xf2\x23\x98\x25\xbb"
+#define QUIC_RETRY_NONCE_V2 "\xd8\x69\x69\xbc\x2d\x7c\x6d\x99\x90\xef\xb0\x4a"
+
+int quic_crypto_get_retry_tag(struct quic_crypto *crypto, struct sk_buff *skb,
+			      struct quic_connection_id *odcid, u32 version, u8 *tag)
+{
+	struct crypto_aead *tfm = crypto->tag_tfm;
+	u8 *pseudo_retry, *p, *iv, *key;
+	struct aead_request *req;
+	struct scatterlist *sg;
+	int err, plen;
+
+	err = crypto_aead_setauthsize(tfm, QUIC_TAG_LEN);
+	if (err)
+		return err;
+	key = QUIC_RETRY_KEY_V1;
+	if (version == QUIC_VERSION_V2)
+		key = QUIC_RETRY_KEY_V2;
+	err = crypto_aead_setkey(tfm, key, 16);
+	if (err)
+		return err;
+
+	pseudo_retry = quic_crypto_aead_mem_alloc(tfm, 128, &iv, &req, &sg, 1);
+	if (!pseudo_retry)
+		return -ENOMEM;
+
+	p = pseudo_retry;
+	p = quic_put_int(p, odcid->len, 1);
+	p = quic_put_data(p, odcid->data, odcid->len);
+	p = quic_put_data(p, skb->data, skb->len - 16);
+	plen = p - pseudo_retry;
+	sg_init_one(sg, pseudo_retry, plen + 16);
+
+	memcpy(iv, QUIC_RETRY_NONCE_V1, 12);
+	if (version == QUIC_VERSION_V2)
+		memcpy(iv, QUIC_RETRY_NONCE_V2, 12);
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_ad(req, plen);
+	aead_request_set_crypt(req, sg, sg, 0, iv);
+	err = crypto_aead_encrypt(req);
+
+	memcpy(tag, pseudo_retry + plen, 16);
+	kfree(pseudo_retry);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_get_retry_tag);
+
+int quic_crypto_generate_token(struct quic_crypto *crypto, void *addr, u32 addrlen,
+			       struct quic_connection_id *conn_id, u8 *token, u32 *tokenlen)
+{
+	u8 key[16], iv[12], *retry_token, *tx_iv, *p;
+	struct crypto_aead *tfm = crypto->tag_tfm;
+	struct tls_vec srt = {NULL, 0}, k, i;
+	u32 ts = jiffies_to_usecs(jiffies);
+	struct aead_request *req;
+	struct scatterlist *sg;
+	int err, len;
+
+	tls_vec(&srt, random_data, 32);
+	tls_vec(&k, key, 16);
+	tls_vec(&i, iv, 12);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &i, NULL, QUIC_VERSION_V1);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(tfm, QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(tfm, key, 16);
+	if (err)
+		return err;
+	token++;
+	len = addrlen + sizeof(ts) + conn_id->len + QUIC_TAG_LEN;
+	retry_token = quic_crypto_aead_mem_alloc(tfm, len, &tx_iv, &req, &sg, 1);
+	if (!retry_token)
+		return -ENOMEM;
+
+	p = retry_token;
+	p = quic_put_data(p, addr, addrlen);
+	p = quic_put_int(p, ts, sizeof(ts));
+	p = quic_put_data(p, conn_id->data, conn_id->len);
+	sg_init_one(sg, retry_token, len);
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_ad(req, addrlen);
+	aead_request_set_crypt(req, sg, sg, len - addrlen - QUIC_TAG_LEN, iv);
+	err = crypto_aead_encrypt(req);
+
+	memcpy(token, retry_token, len);
+	*tokenlen = len + 1;
+	kfree(retry_token);
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_generate_token);
+
+int quic_crypto_verify_token(struct quic_crypto *crypto, void *addr, u32 addrlen,
+			     struct quic_connection_id *conn_id, u8 *token, u32 len)
+{
+	u8 key[16], iv[12], *retry_token, *rx_iv, *p, retry = *token;
+	struct crypto_aead *tfm = crypto->tag_tfm;
+	u32 ts = jiffies_to_usecs(jiffies), t;
+	struct tls_vec srt = {NULL, 0}, k, i;
+	struct aead_request *req;
+	struct scatterlist *sg;
+	u32 timeout = 3000000;
+	int err;
+
+	tls_vec(&srt, random_data, 32);
+	tls_vec(&k, key, 16);
+	tls_vec(&i, iv, 12);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &i, NULL, QUIC_VERSION_V1);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(tfm, QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(tfm, key, 16);
+	if (err)
+		return err;
+	len--;
+	token++;
+	retry_token = quic_crypto_aead_mem_alloc(tfm, len, &rx_iv, &req, &sg, 1);
+	if (!retry_token)
+		return -ENOMEM;
+
+	memcpy(retry_token, token, len);
+	sg_init_one(sg, retry_token, len);
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_ad(req, addrlen);
+	aead_request_set_crypt(req, sg, sg, len - addrlen, iv);
+	err = crypto_aead_decrypt(req);
+	if (err)
+		goto out;
+
+	err = -EINVAL;
+	p = retry_token;
+	if (memcmp(p, addr, addrlen))
+		goto out;
+	p += addrlen;
+	len -= addrlen;
+	if (!retry)
+		timeout = 36000000;
+	t = quic_get_int(&p, sizeof(t));
+	len -= sizeof(t);
+	if (t + timeout < ts)
+		goto out;
+	len -= QUIC_TAG_LEN;
+	if (len > 20)
+		goto out;
+
+	if (retry)
+		quic_connection_id_update(conn_id, p, len);
+	err = 0;
+out:
+	kfree(retry_token);
+	return err;
+}
+EXPORT_SYMBOL_GPL(quic_crypto_verify_token);
+
+static int quic_crypto_generate_key(struct quic_crypto *crypto, void *data, u32 len,
+				    char *label, u8 *token, u32 key_len)
+{
+	struct crypto_shash *tfm = crypto->secret_tfm;
+	struct tls_vec salt, s, l, k, z = {NULL, 0};
+	u8 secret[32];
+	int err;
+
+	tls_vec(&salt, data, len);
+	tls_vec(&k, random_data, 32);
+	tls_vec(&s, secret, 32);
+	err = tls_crypto_hkdf_extract(tfm, &salt, &k, &s);
+	if (err)
+		return err;
+
+	tls_vec(&l, label, strlen(label));
+	tls_vec(&k, token, key_len);
+	return tls_crypto_hkdf_expand(tfm, &s, &l, &z, &k);
+}
+
+int quic_crypto_generate_stateless_reset_token(struct quic_crypto *crypto, void *data,
+					       u32 len, u8 *key, u32 key_len)
+{
+	return quic_crypto_generate_key(crypto, data, len, "stateless_reset", key, key_len);
+}
+EXPORT_SYMBOL_GPL(quic_crypto_generate_stateless_reset_token);
+
+int quic_crypto_generate_session_ticket_key(struct quic_crypto *crypto, void *data,
+					    u32 len, u8 *key, u32 key_len)
+{
+	return quic_crypto_generate_key(crypto, data, len, "session_ticket", key, key_len);
+}
+EXPORT_SYMBOL_GPL(quic_crypto_generate_session_ticket_key);
diff --git a/net/quic/crypto.h b/net/quic/crypto.h
new file mode 100644
index 000000000000..42324e99e1e5
--- /dev/null
+++ b/net/quic/crypto.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <linux/crypto.h>
+
+struct quic_packet_info {
+	s64 number;
+	s64 number_max;
+	u32 number_len;
+	u32 number_offset;
+	u64 length;
+	u32 errcode;
+	u8 frame;
+	u8 key_phase:1;
+	u8 key_update:1;
+	u8 ack_eliciting:1;
+	u8 ack_immediate:1;
+	u8 non_probing:1;
+	u8 resume:1;
+	void *crypto_done;
+};
+
+#define QUIC_TAG_LEN	16
+#define QUIC_IV_LEN	12
+#define QUIC_SECRET_LEN	48
+
+struct quic_cipher {
+	u32 secretlen;
+	u32 keylen;
+	char *aead;
+	char *skc;
+	char *shash;
+};
+
+struct quic_crypto {
+	struct crypto_skcipher *tx_hp_tfm;
+	struct crypto_skcipher *rx_hp_tfm;
+	struct crypto_shash *secret_tfm;
+	struct crypto_aead *tx_tfm[2];
+	struct crypto_aead *rx_tfm[2];
+	struct crypto_aead *tag_tfm;
+	struct quic_cipher *cipher;
+	u32 cipher_type;
+
+	u8 tx_secret[QUIC_SECRET_LEN];
+	u8 rx_secret[QUIC_SECRET_LEN];
+	u8 tx_iv[2][QUIC_IV_LEN];
+	u8 rx_iv[2][QUIC_IV_LEN];
+
+	u32 key_update_send_ts;
+	u32 key_update_ts;
+	u64 send_offset;
+	u64 recv_offset;
+	u32 version;
+
+	u8 key_phase:1;
+	u8 key_pending:1;
+	u8 send_ready:1;
+	u8 recv_ready:1;
+};
+
+static inline u32 quic_crypto_cipher_type(struct quic_crypto *crypto)
+{
+	return crypto->cipher_type;
+}
+
+static inline void quic_crypto_set_cipher_type(struct quic_crypto *crypto, u32 type)
+{
+	crypto->cipher_type = type;
+}
+
+static inline u64 quic_crypto_recv_offset(struct quic_crypto *crypto)
+{
+	return crypto->recv_offset;
+}
+
+static inline void quic_crypto_increase_recv_offset(struct quic_crypto *crypto, u64 offset)
+{
+	crypto->recv_offset += offset;
+}
+
+static inline u64 quic_crypto_send_offset(struct quic_crypto *crypto)
+{
+	return crypto->send_offset;
+}
+
+static inline void quic_crypto_increase_send_offset(struct quic_crypto *crypto, u64 offset)
+{
+	crypto->send_offset += offset;
+}
+
+static inline u8 quic_crypto_recv_ready(struct quic_crypto *crypto)
+{
+	return crypto->recv_ready;
+}
+
+static inline u8 quic_crypto_send_ready(struct quic_crypto *crypto)
+{
+	return crypto->send_ready;
+}
+
+static inline void quic_crypto_set_key_pending(struct quic_crypto *crypto, u8 pending)
+{
+	crypto->key_pending = pending;
+}
+
+static inline void quic_crypto_set_key_update_send_ts(struct quic_crypto *crypto, u32 send_ts)
+{
+	crypto->key_update_send_ts = send_ts;
+}
+
+int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struct quic_connection_id *conn_id,
+				     u32 version, u8 flag, bool is_serv);
+int quic_crypto_encrypt(struct quic_crypto *crypto, struct sk_buff *skb,
+			struct quic_packet_info *pki);
+int quic_crypto_decrypt(struct quic_crypto *crypto, struct sk_buff *skb,
+			struct quic_packet_info *pki);
+int quic_crypto_set_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt,
+			   u32 version, u8 flag);
+int quic_crypto_get_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt);
+void quic_crypto_destroy(struct quic_crypto *crypto);
+int quic_crypto_key_update(struct quic_crypto *crypto);
+void quic_crypto_set_key_update_ts(struct quic_crypto *crypto, u32 key_update_ts);
+int quic_crypto_get_retry_tag(struct quic_crypto *crypto, struct sk_buff *skb,
+			      struct quic_connection_id *odcid, u32 version, u8 *tag);
+int quic_crypto_generate_session_ticket_key(struct quic_crypto *crypto, void *data,
+					    u32 len, u8 *key, u32 key_len);
+int quic_crypto_generate_stateless_reset_token(struct quic_crypto *crypto, void *data,
+					       u32 len, u8 *key, u32 key_len);
+int quic_crypto_verify_token(struct quic_crypto *crypto, void *addr, u32 addrlen,
+			     struct quic_connection_id *conn_id, u8 *token, u32 len);
+int quic_crypto_generate_token(struct quic_crypto *crypto, void *addr, u32 addrlen,
+			       struct quic_connection_id *conn_id, u8 *token, u32 *tokenlen);
diff --git a/net/quic/frame.c b/net/quic/frame.c
new file mode 100644
index 000000000000..e4a11ccf65f5
--- /dev/null
+++ b/net/quic/frame.c
@@ -0,0 +1,1803 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include "number.h"
+#include "frame.h"
+#include <linux/nospec.h>
+
+/* ACK Frame {
+ *  Type (i) = 0x02..0x03,
+ *  Largest Acknowledged (i),
+ *  ACK Delay (i),
+ *  ACK Range Count (i),
+ *  First ACK Range (i),
+ *  ACK Range (..) ...,
+ *  [ECN Counts (..)],
+ * }
+ */
+
+static struct sk_buff *quic_frame_ack_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_gap_ack_block gabs[QUIC_PN_MAX_GABS];
+	struct quic_outqueue *outq = quic_outq(sk);
+	u64 largest, smallest, range, *ecn_count;
+	u32 frame_len, num_gabs, pn_ts;
+	u8 *p, level = *((u8 *)data);
+	struct quic_pnmap *map;
+	struct sk_buff *skb;
+	int i;
+
+	map = quic_pnmap(sk, level);
+	type += quic_pnmap_has_ecn_count(map);
+	num_gabs = quic_pnmap_num_gabs(map, gabs);
+	frame_len = sizeof(type) + sizeof(u32) * 7;
+	frame_len += sizeof(struct quic_gap_ack_block) * num_gabs;
+
+	largest = quic_pnmap_max_pn_seen(map);
+	pn_ts = quic_pnmap_max_pn_ts(map);
+	smallest = quic_pnmap_min_pn_seen(map);
+	if (num_gabs)
+		smallest = quic_pnmap_base_pn(map) + gabs[num_gabs - 1].end;
+	range = largest - smallest;
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	pn_ts = jiffies_to_usecs(jiffies) - pn_ts;
+	pn_ts = pn_ts / BIT(quic_outq_ack_delay_exponent(outq));
+	p = quic_put_var(skb->data, type);
+	p = quic_put_var(p, largest); /* Largest Acknowledged */
+	p = quic_put_var(p, pn_ts); /* ACK Delay */
+	p = quic_put_var(p, num_gabs); /* ACK Count */
+	p = quic_put_var(p, range); /* First ACK Range */
+
+	if (num_gabs) {
+		for (i = num_gabs - 1; i > 0; i--) {
+			p = quic_put_var(p, gabs[i].end - gabs[i].start); /* Gap */
+			/* ACK Range Length */
+			p = quic_put_var(p, gabs[i].start - gabs[i - 1].end - 2);
+		}
+		p = quic_put_var(p, gabs[0].end - gabs[0].start); /* Gap */
+		range = gabs[0].start - 1;
+		if (map->cum_ack_point == -1)
+			range -= map->min_pn_seen;
+		p = quic_put_var(p, range); /* ACK Range Length */
+	}
+	if (type == QUIC_FRAME_ACK_ECN) {
+		ecn_count = quic_pnmap_ecn_count(map);
+		p = quic_put_var(p, ecn_count[1]); /* ECT0 Count */
+		p = quic_put_var(p, ecn_count[0]); /* ECT1 Count */
+		p = quic_put_var(p, ecn_count[2]); /* ECN-CE Count */
+	}
+	frame_len = (u32)(p - skb->data);
+	skb_put(skb, frame_len);
+	QUIC_SND_CB(skb)->level = level;
+	QUIC_SND_CB(skb)->frame_type = type;
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_ping_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	u16 *probe_size = data;
+	struct sk_buff *skb;
+	u32 frame_len = 1;
+
+	quic_packet_config(sk, 0, 0);
+	frame_len = *probe_size - quic_packet_overhead(packet);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	quic_put_var(skb->data, type);
+	skb_put(skb, 1);
+	skb_put_zero(skb, frame_len - 1);
+	QUIC_SND_CB(skb)->padding = 1;
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_padding_create(struct sock *sk, void *data, u8 type)
+{
+	u32 *frame_len = data;
+	struct sk_buff *skb;
+
+	skb = alloc_skb(*frame_len + 1, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_zero(skb, *frame_len + 1);
+	quic_put_var(skb->data, type);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_new_token_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	union quic_addr *da = quic_path_addr(quic_dst(sk), 0);
+	struct sk_buff *skb;
+	u8 token[72], *p;
+	u32 tokenlen;
+
+	p = token;
+	p = quic_put_int(p, 0, 1); /* regular token */
+	if (quic_crypto_generate_token(crypto, da, quic_addr_len(sk),
+				       quic_connection_id_active(id_set), token, &tokenlen))
+		return NULL;
+
+	skb = alloc_skb(tokenlen + 4, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	p = quic_put_var(skb->data, type);
+	p = quic_put_var(p, tokenlen);
+	p = quic_put_data(p, token, tokenlen);
+	skb_put(skb, (u32)(p - skb->data));
+
+	return skb;
+}
+
+/* STREAM Frame {
+ *  Type (i) = 0x08..0x0f,
+ *  Stream ID (i),
+ *  [Offset (i)],
+ *  [Length (i)],
+ *  Stream Data (..),
+ * }
+ */
+
+static struct sk_buff *quic_frame_stream_create(struct sock *sk, void *data, u8 type)
+{
+	u32 msg_len, hlen = 1, frame_len, max_frame_len;
+	struct quic_msginfo *info = data;
+	struct quic_snd_cb *snd_cb;
+	struct quic_stream *stream;
+	struct sk_buff *skb;
+	u8 *p;
+
+	max_frame_len = quic_packet_max_payload(quic_packet(sk));
+	stream = info->stream;
+	hlen += quic_var_len(stream->id);
+	if (stream->send.offset) {
+		type |= QUIC_STREAM_BIT_OFF;
+		hlen += quic_var_len(stream->send.offset);
+	}
+
+	type |= QUIC_STREAM_BIT_LEN;
+	hlen += quic_var_len(max_frame_len);
+
+	msg_len = iov_iter_count(info->msg);
+	if (msg_len <= max_frame_len - hlen) {
+		if (info->flag & QUIC_STREAM_FLAG_FIN)
+			type |= QUIC_STREAM_BIT_FIN;
+	} else {
+		msg_len = max_frame_len - hlen;
+	}
+
+	skb = alloc_skb(msg_len + hlen, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	p = quic_put_var(skb->data, type);
+	p = quic_put_var(p, stream->id);
+	if (type & QUIC_STREAM_BIT_OFF)
+		p = quic_put_var(p, stream->send.offset);
+	p = quic_put_var(p, msg_len);
+	frame_len = (u32)(p - skb->data);
+
+	if (!copy_from_iter_full(p, msg_len, info->msg)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+	frame_len += msg_len;
+	skb_put(skb, frame_len);
+	snd_cb = QUIC_SND_CB(skb);
+	snd_cb->data_bytes = msg_len;
+	snd_cb->stream = stream;
+	snd_cb->frame_type = type;
+
+	stream->send.offset += msg_len;
+	return skb;
+}
+
+static struct sk_buff *quic_frame_handshake_done_create(struct sock *sk, void *data, u8 type)
+{
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_crypto_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_msginfo *info = data;
+	u32 msg_len, hlen, max_frame_len;
+	struct quic_crypto *crypto;
+	struct sk_buff *skb;
+	u64 offset;
+	u8 *p;
+
+	quic_packet_config(sk, info->level, 0);
+	max_frame_len = quic_packet_max_payload(quic_packet(sk));
+	crypto = quic_crypto(sk, info->level);
+	msg_len = iov_iter_count(info->msg);
+
+	if (!info->level) {
+		if (msg_len > max_frame_len)
+			return NULL;
+		skb = alloc_skb(msg_len + 8, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+		p = quic_put_var(skb->data, type);
+		p = quic_put_var(p, 0);
+		p = quic_put_var(p, msg_len);
+		if (!copy_from_iter_full(p, msg_len, info->msg)) {
+			kfree_skb(skb);
+			return NULL;
+		}
+		p += msg_len;
+		skb_put(skb, (u32)(p - skb->data));
+
+		return skb;
+	}
+
+	if (msg_len > max_frame_len)
+		msg_len = max_frame_len;
+	offset = quic_crypto_send_offset(crypto);
+	hlen = 1 + quic_var_len(msg_len) + quic_var_len(offset);
+	skb = alloc_skb(msg_len + hlen, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	p = quic_put_var(skb->data, type);
+	p = quic_put_var(p, offset);
+	p = quic_put_var(p, msg_len);
+	if (!copy_from_iter_full(p, msg_len, info->msg)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+	skb_put(skb, msg_len + hlen);
+	quic_crypto_increase_send_offset(crypto, msg_len);
+	QUIC_SND_CB(skb)->level = info->level;
+	return skb;
+}
+
+static struct sk_buff *quic_frame_retire_connection_id_create(struct sock *sk, void *data, u8 type)
+{
+	struct sk_buff *skb;
+	u64 *number = data;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, *number);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	quic_connection_id_remove(quic_dest(sk), *number);
+	return skb;
+}
+
+static struct sk_buff *quic_frame_new_connection_id_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_connection_id scid = {};
+	u8 *p, frame[100], token[16];
+	u64 *prior = data, seqno;
+	struct sk_buff *skb;
+	u32 frame_len;
+	int err;
+
+	seqno = quic_connection_id_last_number(quic_source(sk)) + 1;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, seqno);
+	p = quic_put_var(p, *prior);
+	p = quic_put_var(p, 16);
+	quic_connection_id_generate(&scid, 16);
+	p = quic_put_data(p, scid.data, scid.len);
+	if (quic_crypto_generate_stateless_reset_token(crypto, scid.data, scid.len, token, 16))
+		return NULL;
+	p = quic_put_data(p, token, 16);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	err = quic_connection_id_add(quic_source(sk), &scid, seqno, sk);
+	if (err) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_path_response_create(struct sock *sk, void *data, u8 type)
+{
+	u8 *p, frame[10], *entropy = data;
+	struct sk_buff *skb;
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_data(p, entropy, 8);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_path_challenge_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_path_addr *path = data;
+	struct sk_buff *skb;
+	u32 frame_len;
+	u8 *p;
+
+	quic_packet_config(sk, 0, 0);
+	frame_len = 1184 - quic_packet_overhead(packet);
+	get_random_bytes(quic_path_entropy(path), 8);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	p = quic_put_var(skb->data, type);
+	p = quic_put_data(p, quic_path_entropy(path), 8);
+	skb_put(skb, 1 + 8);
+	skb_put_zero(skb, frame_len - 1);
+	QUIC_SND_CB(skb)->padding = 1;
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_reset_stream_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_errinfo *info = data;
+	struct quic_stream *stream;
+	struct sk_buff *skb;
+	u8 *p, frame[20];
+	u32 frame_len;
+
+	stream = quic_stream_find(streams, info->stream_id);
+	WARN_ON(!stream);
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, info->stream_id);
+	p = quic_put_var(p, info->errcode);
+	p = quic_put_var(p, stream->send.offset);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+	stream->send.errcode = info->errcode;
+	QUIC_SND_CB(skb)->stream = stream;
+
+	if (quic_stream_send_active(streams) == stream->id)
+		quic_stream_set_send_active(streams, -1);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_stop_sending_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_errinfo *info = data;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, info->stream_id);
+	p = quic_put_var(p, info->errcode);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_max_data_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_inqueue *inq = data;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, quic_inq_max_bytes(inq));
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_max_stream_data_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_stream *stream = data;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, stream->id);
+	p = quic_put_var(p, stream->recv.max_bytes);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_max_streams_uni_create(struct sock *sk, void *data, u8 type)
+{
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u64 *max = data;
+	int frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, *max);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_max_streams_bidi_create(struct sock *sk, void *data, u8 type)
+{
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u64 *max = data;
+	int frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, *max);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_connection_close_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	u32 frame_len, phrase_len = 0;
+	u8 *p, frame[100], *phrase;
+	struct sk_buff *skb;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, quic_outq_close_errcode(outq));
+
+	if (type == QUIC_FRAME_CONNECTION_CLOSE)
+		p = quic_put_var(p, quic_outq_close_frame(outq));
+
+	phrase = quic_outq_close_phrase(outq);
+	if (phrase)
+		phrase_len = strlen(phrase) + 1;
+	p = quic_put_var(p, phrase_len);
+	p = quic_put_data(p, phrase, phrase_len);
+
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_data_blocked_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_outqueue *outq = data;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, quic_outq_max_bytes(outq));
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_stream_data_blocked_create(struct sock *sk, void *data, u8 type)
+{
+	struct quic_stream *stream = data;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+	u32 frame_len;
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, stream->id);
+	p = quic_put_var(p, stream->send.max_bytes);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+	QUIC_SND_CB(skb)->stream = stream;
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_streams_blocked_uni_create(struct sock *sk, void *data, u8 type)
+{
+	u32 *max = data, frame_len;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, (*max >> 2) + 1);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static struct sk_buff *quic_frame_streams_blocked_bidi_create(struct sock *sk, void *data, u8 type)
+{
+	u32 *max = data, frame_len;
+	struct sk_buff *skb;
+	u8 *p, frame[10];
+
+	p = quic_put_var(frame, type);
+	p = quic_put_var(p, (*max >> 2) + 1);
+	frame_len = (u32)(p - frame);
+
+	skb = alloc_skb(frame_len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_put_data(skb, frame, frame_len);
+
+	return skb;
+}
+
+static int quic_frame_crypto_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff *nskb;
+	u64 offset, length;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	int err;
+
+	if (!quic_get_var(&p, &len, &offset))
+		return -EINVAL;
+	if (!quic_get_var(&p, &len, &length) || length > len)
+		return -EINVAL;
+
+	if (!rcv_cb->level) {
+		if (!quic_inq_receive_session_ticket(inq))
+			goto out;
+		quic_inq_set_receive_session_ticket(inq, 0);
+	}
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+	skb_pull(nskb, p - skb->data);
+	skb_trim(nskb, length);
+	QUIC_RCV_CB(nskb)->offset = offset;
+
+	err = quic_inq_handshake_tail(sk, nskb);
+	if (err) {
+		rcv_cb->errcode = QUIC_RCV_CB(nskb)->errcode;
+		kfree_skb(nskb);
+		return err;
+	}
+out:
+	len -= length;
+	return skb->len - len;
+}
+
+static int quic_frame_stream_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_inqueue *inq = quic_inq(sk);
+	u64 stream_id, payload_len, offset = 0;
+	struct quic_stream *stream;
+	struct sk_buff *nskb;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	int err;
+
+	if (quic_inq_receive_session_ticket(inq))
+		return -EINVAL;
+	if (!quic_get_var(&p, &len, &stream_id))
+		return -EINVAL;
+	if (type & QUIC_STREAM_BIT_OFF) {
+		if (!quic_get_var(&p, &len, &offset))
+			return -EINVAL;
+	}
+
+	payload_len = len;
+	if (type & QUIC_STREAM_BIT_LEN) {
+		if (!quic_get_var(&p, &len, &payload_len) || payload_len > len)
+			return -EINVAL;
+	}
+
+	stream = quic_stream_recv_get(streams, stream_id, quic_is_serv(sk));
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		if (err == -EAGAIN)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_LIMIT;
+		else if (err != -ENOMEM)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_STATE;
+		return err;
+	}
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+	skb_pull(nskb, skb->len - len);
+	skb_trim(nskb, payload_len);
+
+	rcv_cb = QUIC_RCV_CB(nskb);
+	rcv_cb->stream = stream;
+	rcv_cb->stream_fin = (type & QUIC_STREAM_BIT_FIN);
+	rcv_cb->offset = offset;
+
+	err = quic_inq_reasm_tail(sk, nskb);
+	if (err) {
+		QUIC_RCV_CB(skb)->errcode = rcv_cb->errcode;
+		kfree_skb(nskb);
+		return err;
+	}
+
+	len -= payload_len;
+	return skb->len - len;
+}
+
+static int quic_frame_ack_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	u64 largest, smallest, range, delay, count, gap, i, ecn_count[3];
+	u8 *p = skb->data, level = QUIC_RCV_CB(skb)->level;
+	struct quic_pnmap *map = quic_pnmap(sk, level);
+	struct quic_cong *cong = quic_cong(sk);
+	u32 len = skb->len;
+
+	if (!quic_get_var(&p, &len, &largest) ||
+	    !quic_get_var(&p, &len, &delay) ||
+	    !quic_get_var(&p, &len, &count) || count > QUIC_PN_MAX_GABS ||
+	    !quic_get_var(&p, &len, &range))
+		return -EINVAL;
+
+	if (largest >= quic_pnmap_next_number(map)) {
+		QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+
+	smallest = largest - range;
+	quic_outq_retransmit_check(sk, level, largest, smallest, largest, delay);
+
+	for (i = 0; i < count; i++) {
+		if (!quic_get_var(&p, &len, &gap) ||
+		    !quic_get_var(&p, &len, &range))
+			return -EINVAL;
+		largest = smallest - gap - 2;
+		smallest = largest - range;
+		quic_outq_retransmit_check(sk, level, largest, smallest, 0, 0);
+	}
+
+	if (type == QUIC_FRAME_ACK_ECN) {
+		if (!quic_get_var(&p, &len, &ecn_count[1]) ||
+		    !quic_get_var(&p, &len, &ecn_count[0]) ||
+		    !quic_get_var(&p, &len, &ecn_count[2]))
+			return -EINVAL;
+		if (quic_pnmap_set_ecn_count(map, ecn_count)) {
+			quic_cong_cwnd_update_after_ecn(cong);
+			quic_outq_set_window(quic_outq(sk), quic_cong_window(cong));
+		}
+	}
+
+	return skb->len - len;
+}
+
+static int quic_frame_new_connection_id_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	u64 seqno, prior, length, first, last;
+	struct quic_connection_id dcid;
+	u8 *p = skb->data, *token;
+	struct sk_buff *fskb;
+	u32 len = skb->len;
+	int err;
+
+	if (!quic_get_var(&p, &len, &seqno) ||
+	    !quic_get_var(&p, &len, &prior) ||
+	    !quic_get_var(&p, &len, &length) ||
+	    !length || length > 20 || length + 16 > len)
+		return -EINVAL;
+
+	memcpy(dcid.data, p, length);
+	dcid.len = length;
+	token = p + length;
+
+	last = quic_connection_id_last_number(id_set);
+	if (seqno < last + 1) /* already exists */
+		goto out;
+
+	if (seqno > last + 1 || prior > seqno)
+		return -EINVAL;
+
+	first = quic_connection_id_first_number(id_set);
+	if (prior < first)
+		prior = first;
+	if (seqno - prior + 1 > quic_connection_id_max_count(id_set)) {
+		QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_CONNECTION_ID_LIMIT;
+		return -EINVAL;
+	}
+
+	err = quic_connection_id_add(id_set, &dcid, seqno, token);
+	if (err)
+		return err;
+
+	for (; first < prior; first++) {
+		fskb = quic_frame_create(sk, QUIC_FRAME_RETIRE_CONNECTION_ID, &first);
+		if (!fskb)
+			return -ENOMEM;
+		QUIC_SND_CB(fskb)->path_alt = QUIC_RCV_CB(skb)->path_alt;
+		quic_outq_ctrl_tail(sk, fskb, true);
+	}
+
+out:
+	len -= (length + 16);
+	return skb->len - len;
+}
+
+static int quic_frame_retire_connection_id_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	u32 len = skb->len, last, first;
+	struct sk_buff *fskb;
+	u8 *p = skb->data;
+	u64 seqno;
+
+	if (!quic_get_var(&p, &len, &seqno))
+		return -EINVAL;
+	first = quic_connection_id_first_number(id_set);
+	if (seqno < first) /* dup */
+		goto out;
+	last  = quic_connection_id_last_number(id_set);
+	if (seqno != first || seqno == last) {
+		QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+
+	quic_connection_id_remove(id_set, seqno);
+	if (last - seqno >= quic_connection_id_max_count(id_set))
+		goto out;
+	seqno++;
+	fskb = quic_frame_create(sk, QUIC_FRAME_NEW_CONNECTION_ID, &seqno);
+	if (!fskb)
+		return -ENOMEM;
+	QUIC_SND_CB(fskb)->path_alt = QUIC_RCV_CB(skb)->path_alt;
+	quic_outq_ctrl_tail(sk, fskb, true);
+out:
+	return skb->len - len;
+}
+
+static int quic_frame_new_token_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_data *token = quic_token(sk);
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	u64 length;
+
+	if (quic_is_serv(sk)) {
+		QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+
+	if (!quic_get_var(&p, &len, &length) || length > len)
+		return -EINVAL;
+
+	if (quic_data_dup(token, p, length))
+		return -ENOMEM;
+
+	if (quic_inq_event_recv(sk, QUIC_EVENT_NEW_TOKEN, token))
+		return -ENOMEM;
+
+	len -= length;
+	return skb->len - len;
+}
+
+static int quic_frame_handshake_done_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	if (quic_is_serv(sk)) {
+		QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+	/* some implementations don't send ACKs to handshake packets, so ACK them manually */
+	quic_outq_retransmit_check(sk, QUIC_CRYPTO_INITIAL, QUIC_PN_MAP_MAX_PN, 0, 0, 0);
+	quic_outq_retransmit_check(sk, QUIC_CRYPTO_HANDSHAKE, QUIC_PN_MAP_MAX_PN, 0, 0, 0);
+	return 0; /* no content */
+}
+
+static int quic_frame_padding_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	return skb->len;
+}
+
+static int quic_frame_ping_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	return 0; /* no content */
+}
+
+static int quic_frame_path_challenge_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct sk_buff *fskb;
+	u32 len = skb->len;
+	u8 entropy[8];
+
+	if (len < 8)
+		return -EINVAL;
+	memcpy(entropy, skb->data, 8);
+	fskb = quic_frame_create(sk, QUIC_FRAME_PATH_RESPONSE, entropy);
+	if (!fskb)
+		return -ENOMEM;
+	QUIC_SND_CB(fskb)->path_alt = QUIC_RCV_CB(skb)->path_alt;
+	quic_outq_ctrl_tail(sk, fskb, true);
+
+	len -= 8;
+	return skb->len - len;
+}
+
+static int quic_frame_reset_stream_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_stream_update update = {};
+	u64 stream_id, errcode, finalsz;
+	struct quic_stream *stream;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	int err;
+
+	if (!quic_get_var(&p, &len, &stream_id) ||
+	    !quic_get_var(&p, &len, &errcode) ||
+	    !quic_get_var(&p, &len, &finalsz))
+		return -EINVAL;
+
+	stream = quic_stream_recv_get(streams, stream_id, quic_is_serv(sk));
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		if (err == -EAGAIN)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_LIMIT;
+		else if (err != -ENOMEM)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_STATE;
+		return err;
+	}
+
+	if (finalsz < stream->recv.highest ||
+	    (stream->recv.finalsz && stream->recv.finalsz != finalsz)) {
+		rcv_cb->errcode = QUIC_TRANSPORT_ERROR_FINAL_SIZE;
+		return -EINVAL;
+	}
+
+	update.id = stream_id;
+	update.state = QUIC_STREAM_RECV_STATE_RESET_RECVD;
+	update.errcode = errcode;
+	update.finalsz = finalsz;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update))
+		return -ENOMEM;
+	stream->recv.state = update.state;
+	stream->recv.finalsz = update.finalsz;
+	quic_inq_stream_purge(sk, stream);
+	return skb->len - len;
+}
+
+static int quic_frame_stop_sending_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_stream_update update = {};
+	struct quic_stream *stream;
+	struct quic_errinfo info;
+	u64 stream_id, errcode;
+	struct sk_buff *fskb;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	int err;
+
+	if (!quic_get_var(&p, &len, &stream_id) ||
+	    !quic_get_var(&p, &len, &errcode))
+		return -EINVAL;
+
+	stream = quic_stream_send_get(streams, stream_id, 0, quic_is_serv(sk));
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		if (err == -EAGAIN)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_LIMIT;
+		else if (err != -ENOMEM)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_STATE;
+		return err;
+	}
+
+	info.stream_id = stream_id;
+	info.errcode = errcode;
+	fskb = quic_frame_create(sk, QUIC_FRAME_RESET_STREAM, &info);
+	if (!fskb)
+		return -ENOMEM;
+
+	update.id = stream_id;
+	update.state = QUIC_STREAM_SEND_STATE_RESET_SENT;
+	update.errcode = errcode;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update)) {
+		kfree_skb(fskb);
+		return -ENOMEM;
+	}
+	stream->send.state = update.state;
+	quic_outq_stream_purge(sk, stream);
+	quic_outq_ctrl_tail(sk, fskb, true);
+	return skb->len - len;
+}
+
+static int quic_frame_max_data_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	u64 max_bytes;
+
+	if (!quic_get_var(&p, &len, &max_bytes))
+		return -EINVAL;
+
+	if (max_bytes >= quic_outq_max_bytes(outq))
+		quic_outq_set_max_bytes(outq, max_bytes);
+
+	return skb->len - len;
+}
+
+static int quic_frame_max_stream_data_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_stream *stream;
+	u64 max_bytes, stream_id;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	int err;
+
+	if (!quic_get_var(&p, &len, &stream_id) ||
+	    !quic_get_var(&p, &len, &max_bytes))
+		return -EINVAL;
+
+	stream = quic_stream_send_get(streams, stream_id, 0, quic_is_serv(sk));
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		if (err == -EAGAIN)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_LIMIT;
+		else if (err != -ENOMEM)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_STATE;
+		return err;
+	}
+
+	if (max_bytes >= stream->send.max_bytes)
+		stream->send.max_bytes = max_bytes;
+
+	return skb->len - len;
+}
+
+static int quic_frame_max_streams_uni_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	u32 len = skb->len;
+	u64 max, stream_id;
+	u8 *p = skb->data;
+
+	if (!quic_get_var(&p, &len, &max))
+		return -EINVAL;
+
+	if (max < quic_stream_send_max_uni(streams))
+		goto out;
+
+	stream_id = ((max - 1) << 2) | QUIC_STREAM_TYPE_UNI_MASK;
+	if (quic_is_serv(sk))
+		stream_id |= QUIC_STREAM_TYPE_SERVER_MASK;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_MAX_STREAM, &stream_id))
+		return -ENOMEM;
+	quic_stream_set_send_max_uni(streams, max);
+	quic_stream_set_send_uni(streams, max);
+	sk->sk_write_space(sk);
+out:
+	return skb->len - len;
+}
+
+static int quic_frame_max_streams_bidi_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	u32 len = skb->len;
+	u64 max, stream_id;
+	u8 *p = skb->data;
+
+	if (!quic_get_var(&p, &len, &max))
+		return -EINVAL;
+
+	if (max < quic_stream_send_max_bidi(streams))
+		goto out;
+
+	stream_id = ((max - 1) << 2);
+	if (quic_is_serv(sk))
+		stream_id |= QUIC_STREAM_TYPE_SERVER_MASK;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_MAX_STREAM, &stream_id))
+		return -ENOMEM;
+	quic_stream_set_send_max_bidi(streams, max);
+	quic_stream_set_send_bidi(streams, max);
+	sk->sk_write_space(sk);
+out:
+	return skb->len - len;
+}
+
+static int quic_frame_connection_close_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_connection_close *close;
+	u64 err_code, phrase_len, ftype = 0;
+	u8 *p = skb->data, frame[100] = {};
+	u32 len = skb->len;
+
+	if (!quic_get_var(&p, &len, &err_code))
+		return -EINVAL;
+	if (type == QUIC_FRAME_CONNECTION_CLOSE && !quic_get_var(&p, &len, &ftype))
+		return -EINVAL;
+	if (type == QUIC_FRAME_CONNECTION_CLOSE_APP && rcv_cb->level != QUIC_CRYPTO_APP) {
+		rcv_cb->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+
+	if (!quic_get_var(&p, &len, &phrase_len) || phrase_len > len)
+		return -EINVAL;
+
+	close = (void *)frame;
+	if (phrase_len) {
+		if ((phrase_len > 80 || *(p + phrase_len - 1) != 0))
+			return -EINVAL;
+		strscpy(close->phrase, p, phrase_len);
+	}
+	close->errcode = err_code;
+	close->frame = ftype;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_CLOSE, close))
+		return -ENOMEM;
+	quic_set_state(sk, QUIC_SS_CLOSED);
+
+	len -= phrase_len;
+	return skb->len - len;
+}
+
+static int quic_frame_data_blocked_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	u64 max_bytes, recv_max_bytes;
+	u32 window, len = skb->len;
+	struct sk_buff *fskb;
+	u8 *p = skb->data;
+
+	if (!quic_get_var(&p, &len, &max_bytes))
+		return -EINVAL;
+	recv_max_bytes = quic_inq_max_bytes(inq);
+
+	window = quic_inq_window(inq);
+	if (sk_under_memory_pressure(sk))
+		window >>= 1;
+
+	quic_inq_set_max_bytes(inq, quic_inq_bytes(inq) + window);
+	fskb = quic_frame_create(sk, QUIC_FRAME_MAX_DATA, inq);
+	if (!fskb) {
+		quic_inq_set_max_bytes(inq, recv_max_bytes);
+		return -ENOMEM;
+	}
+	quic_outq_ctrl_tail(sk, fskb, true);
+	return skb->len - len;
+}
+
+static int quic_frame_stream_data_blocked_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	u64 stream_id, max_bytes, recv_max_bytes;
+	struct quic_stream *stream;
+	u32 window, len = skb->len;
+	struct sk_buff *fskb;
+	u8 *p = skb->data;
+	int err;
+
+	if (!quic_get_var(&p, &len, &stream_id) ||
+	    !quic_get_var(&p, &len, &max_bytes))
+		return -EINVAL;
+
+	stream = quic_stream_recv_get(streams, stream_id, quic_is_serv(sk));
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		if (err == -EAGAIN)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_LIMIT;
+		else if (err != -ENOMEM)
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_STREAM_STATE;
+		return err;
+	}
+
+	window = stream->recv.window;
+	if (sk_under_memory_pressure(sk))
+		window >>= 1;
+
+	recv_max_bytes = stream->recv.max_bytes;
+	stream->recv.max_bytes = stream->recv.bytes + window;
+	fskb = quic_frame_create(sk, QUIC_FRAME_MAX_STREAM_DATA, stream);
+	if (!fskb) {
+		stream->recv.max_bytes = recv_max_bytes;
+		return -ENOMEM;
+	}
+	quic_outq_ctrl_tail(sk, fskb, true);
+	return skb->len - len;
+}
+
+static int quic_frame_streams_blocked_uni_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct sk_buff *fskb;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	u64 max;
+
+	if (!quic_get_var(&p, &len, &max))
+		return -EINVAL;
+	if (max < quic_stream_recv_max_uni(streams))
+		goto out;
+	fskb = quic_frame_create(sk, QUIC_FRAME_MAX_STREAMS_UNI, &max);
+	if (!fskb)
+		return -ENOMEM;
+	quic_outq_ctrl_tail(sk, fskb, true);
+	quic_stream_set_recv_max_uni(streams, max);
+out:
+	return skb->len - len;
+}
+
+static int quic_frame_streams_blocked_bidi_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct sk_buff *fskb;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	u64 max;
+
+	if (!quic_get_var(&p, &len, &max))
+		return -EINVAL;
+	if (max < quic_stream_recv_max_bidi(streams))
+		goto out;
+	fskb = quic_frame_create(sk, QUIC_FRAME_MAX_STREAMS_BIDI, &max);
+	if (!fskb)
+		return -ENOMEM;
+	quic_outq_ctrl_tail(sk, fskb, true);
+	quic_stream_set_recv_max_bidi(streams, max);
+out:
+	return skb->len - len;
+}
+
+static int quic_frame_path_response_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_path_addr *path;
+	u32 len = skb->len;
+	u8 entropy[8];
+
+	if (len < 8)
+		return -EINVAL;
+	memcpy(entropy, skb->data, 8);
+
+	path = quic_src(sk); /* source address validation */
+	if (!memcmp(quic_path_entropy(path), entropy, 8) && quic_path_sent_cnt(path))
+		quic_outq_validate_path(sk, skb, path);
+
+	path = quic_dst(sk); /* dest address validation */
+	if (!memcmp(quic_path_entropy(path), entropy, 8) && quic_path_sent_cnt(path))
+		quic_outq_validate_path(sk, skb, path);
+
+	len -= 8;
+	return skb->len - len;
+}
+
+static struct sk_buff *quic_frame_invalid_create(struct sock *sk, void *data, u8 type)
+{
+	return NULL;
+}
+
+static struct sk_buff *quic_frame_datagram_create(struct sock *sk, void *data, u8 type)
+{
+	u32 msg_len, hlen = 1, frame_len, max_frame_len;
+	struct iov_iter *msg = data;
+	struct sk_buff *skb;
+	u8 *p;
+
+	max_frame_len = quic_packet_max_payload_dgram(quic_packet(sk));
+	hlen += quic_var_len(max_frame_len);
+
+	msg_len = iov_iter_count(msg);
+	if (msg_len > max_frame_len - hlen)
+		msg_len = max_frame_len - hlen;
+
+	skb = alloc_skb(msg_len + hlen, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	p = quic_put_var(skb->data, type);
+	p = quic_put_var(p, msg_len);
+	frame_len = (u32)(p - skb->data);
+
+	if (!copy_from_iter_full(p, msg_len, msg)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	QUIC_SND_CB(skb)->data_bytes = msg_len;
+	frame_len += msg_len;
+	skb_put(skb, frame_len);
+	return skb;
+}
+
+static int quic_frame_invalid_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	QUIC_RCV_CB(skb)->errcode = QUIC_TRANSPORT_ERROR_FRAME_ENCODING;
+	return -EPROTONOSUPPORT;
+}
+
+static int quic_frame_datagram_process(struct sock *sk, struct sk_buff *skb, u8 type)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff *nskb;
+	u32 len = skb->len;
+	u8 *p = skb->data;
+	u64 payload_len;
+	int err;
+
+	if (quic_inq_receive_session_ticket(inq))
+		return -EINVAL;
+
+	if (!quic_inq_max_dgram(inq))
+		return -EINVAL;
+
+	payload_len = skb->len;
+	if (type == QUIC_FRAME_DATAGRAM_LEN) {
+		if (!quic_get_var(&p, &len, &payload_len) || payload_len > len)
+			return -EINVAL;
+	}
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+	skb_pull(nskb, skb->len - len);
+	skb_trim(nskb, payload_len);
+
+	err = quic_inq_dgram_tail(sk, nskb);
+	if (err) {
+		kfree_skb(nskb);
+		return err;
+	}
+
+	len -= payload_len;
+	return skb->len - len;
+}
+
+#define quic_frame_create_and_process(type) \
+	{quic_frame_##type##_create, quic_frame_##type##_process}
+
+static struct quic_frame_ops quic_frame_ops[QUIC_FRAME_MAX + 1] = {
+	quic_frame_create_and_process(padding), /* 0x00 */
+	quic_frame_create_and_process(ping),
+	quic_frame_create_and_process(ack),
+	quic_frame_create_and_process(ack), /* ack_ecn */
+	quic_frame_create_and_process(reset_stream),
+	quic_frame_create_and_process(stop_sending),
+	quic_frame_create_and_process(crypto),
+	quic_frame_create_and_process(new_token),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(stream),
+	quic_frame_create_and_process(max_data), /* 0x10 */
+	quic_frame_create_and_process(max_stream_data),
+	quic_frame_create_and_process(max_streams_bidi),
+	quic_frame_create_and_process(max_streams_uni),
+	quic_frame_create_and_process(data_blocked),
+	quic_frame_create_and_process(stream_data_blocked),
+	quic_frame_create_and_process(streams_blocked_bidi),
+	quic_frame_create_and_process(streams_blocked_uni),
+	quic_frame_create_and_process(new_connection_id),
+	quic_frame_create_and_process(retire_connection_id),
+	quic_frame_create_and_process(path_challenge),
+	quic_frame_create_and_process(path_response),
+	quic_frame_create_and_process(connection_close),
+	quic_frame_create_and_process(connection_close),
+	quic_frame_create_and_process(handshake_done),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid), /* 0x20 */
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(invalid),
+	quic_frame_create_and_process(datagram), /* 0x30 */
+	quic_frame_create_and_process(datagram),
+};
+
+int quic_frame_process(struct sock *sk, struct sk_buff *skb, struct quic_packet_info *pki)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	u8 type, level = rcv_cb->level;
+	int ret, len = pki->length;
+
+	if (!len) {
+		pki->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		return -EINVAL;
+	}
+
+	while (len > 0) {
+		type = *(u8 *)(skb->data);
+		skb_pull(skb, 1);
+		len--;
+
+		if (type > QUIC_FRAME_MAX) {
+			pr_err_once("[QUIC] %s unsupported frame %x\n", __func__, type);
+			pki->errcode = QUIC_TRANSPORT_ERROR_FRAME_ENCODING;
+			return -EPROTONOSUPPORT;
+		} else if (quic_frame_level_check(level, type)) {
+			pki->errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+			return -EINVAL;
+		} else if (!type) { /* skip padding */
+			skb_pull(skb, len);
+			return 0;
+		}
+		pr_debug("[QUIC] %s type: %x level: %d\n", __func__, type, level);
+		ret = quic_frame_ops[type].frame_process(sk, skb, type);
+		if (ret < 0) {
+			pr_warn("[QUIC] %s type: %x level: %d err: %d\n", __func__,
+				type, level, ret);
+			pki->errcode = rcv_cb->errcode;
+			pki->frame = type;
+			return ret;
+		}
+		if (quic_frame_ack_eliciting(type)) {
+			pki->ack_eliciting = 1;
+			if (quic_frame_ack_immediate(type))
+				pki->ack_immediate = 1;
+		}
+		if (quic_frame_non_probing(type))
+			pki->non_probing = 1;
+
+		skb_pull(skb, ret);
+		len -= ret;
+	}
+	return 0;
+}
+
+struct sk_buff *quic_frame_create(struct sock *sk, u8 type, void *data)
+{
+	struct quic_snd_cb *snd_cb;
+	struct sk_buff *skb;
+
+	if (type > QUIC_FRAME_MAX)
+		return NULL;
+	skb = quic_frame_ops[type].frame_create(sk, data, type);
+	if (!skb) {
+		pr_err("[QUIC] frame create failed %x\n", type);
+		return NULL;
+	}
+	pr_debug("[QUIC] %s type: %u len: %u\n", __func__, type, skb->len);
+	snd_cb = QUIC_SND_CB(skb);
+	if (!snd_cb->frame_type)
+		snd_cb->frame_type = type;
+	return skb;
+}
+
+static int quic_get_conn_id(struct quic_connection_id *conn_id, u8 **pp, u32 *plen)
+{
+	u64 valuelen;
+
+	if (!quic_get_var(pp, plen, &valuelen))
+		return -1;
+
+	if (*plen < valuelen || valuelen > 20)
+		return -1;
+
+	memcpy(conn_id->data, *pp, valuelen);
+	conn_id->len = valuelen;
+
+	*pp += valuelen;
+	*plen -= valuelen;
+	return 0;
+}
+
+static int quic_get_param(u64 *pdest, u8 **pp, u32 *plen)
+{
+	u64 valuelen;
+
+	if (!quic_get_var(pp, plen, &valuelen))
+		return -1;
+
+	if (*plen < valuelen)
+		return -1;
+
+	if (!quic_get_var(pp, plen, pdest))
+		return -1;
+	return 0;
+}
+
+static int quic_get_version_info(u32 *versions, u8 *count, u8 **pp, u32 *plen)
+{
+	u64 valuelen;
+	u8 i;
+
+	if (!quic_get_var(pp, plen, &valuelen))
+		return -1;
+
+	if (*plen < valuelen || valuelen > 64)
+		return -1;
+
+	*count = valuelen / 4;
+	for (i = 0; i < *count; i++)
+		versions[i] = quic_get_int(pp, 4);
+
+	*plen -= valuelen;
+	return 0;
+}
+
+int quic_frame_set_transport_params_ext(struct sock *sk, struct quic_transport_param *params,
+					u8 *data, u32 len)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_id *active, conn_id;
+	u8 *p = data, count = 0;
+	u64 type, valuelen;
+	u32 versions[16];
+
+	params->max_udp_payload_size = 65527;
+	params->ack_delay_exponent = 3;
+	params->max_ack_delay = 25000;
+	params->active_connection_id_limit = 2;
+	active = quic_connection_id_active(id_set);
+
+	while (len > 0) {
+		if (!quic_get_var(&p, &len, &type))
+			return -1;
+
+		switch (type) {
+		case QUIC_TRANSPORT_PARAM_ORIGINAL_DESTINATION_CONNECTION_ID:
+			if (quic_is_serv(sk))
+				return -1;
+			if (quic_get_conn_id(&conn_id, &p, &len))
+				return -1;
+			if (quic_connection_id_cmp(quic_outq_orig_dcid(outq), &conn_id))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_RETRY_SOURCE_CONNECTION_ID:
+			if (quic_is_serv(sk))
+				return -1;
+			if (quic_get_conn_id(&conn_id, &p, &len))
+				return -1;
+			if (quic_connection_id_cmp(quic_outq_retry_dcid(outq), &conn_id))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_SOURCE_CONNECTION_ID:
+			if (quic_get_conn_id(&conn_id, &p, &len))
+				return -1;
+			if (quic_connection_id_cmp(active, &conn_id))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_LOCAL:
+			if (quic_get_param(&params->max_stream_data_bidi_local, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_REMOTE:
+			if (quic_get_param(&params->max_stream_data_bidi_remote, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_UNI:
+			if (quic_get_param(&params->max_stream_data_uni, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_DATA:
+			if (quic_get_param(&params->max_data, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_BIDI:
+			if (quic_get_param(&params->max_streams_bidi, &p, &len))
+				return -1;
+			if (params->max_streams_bidi > QUIC_MAX_STREAMS)
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_UNI:
+			if (quic_get_param(&params->max_streams_uni, &p, &len))
+				return -1;
+			if (params->max_streams_uni > QUIC_MAX_STREAMS)
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_MAX_IDLE_TIMEOUT:
+			if (quic_get_param(&params->max_idle_timeout, &p, &len))
+				return -1;
+			params->max_idle_timeout *= 1000;
+			break;
+		case QUIC_TRANSPORT_PARAM_MAX_UDP_PAYLOAD_SIZE:
+			if (quic_get_param(&params->max_udp_payload_size, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_ACK_DELAY_EXPONENT:
+			if (quic_get_param(&params->ack_delay_exponent, &p, &len))
+				return -1;
+			if (params->ack_delay_exponent > 20)
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_DISABLE_ACTIVE_MIGRATION:
+			if (!quic_get_var(&p, &len, &valuelen))
+				return -1;
+			if (valuelen)
+				return -1;
+			params->disable_active_migration = 1;
+			break;
+		case QUIC_TRANSPORT_PARAM_DISABLE_1RTT_ENCRYPTION:
+			if (!quic_get_var(&p, &len, &valuelen))
+				return -1;
+			if (!quic_is_serv(sk) && valuelen)
+				return -1;
+			params->disable_1rtt_encryption = 1;
+			len -= valuelen;
+			p += valuelen;
+			break;
+		case QUIC_TRANSPORT_PARAM_GREASE_QUIC_BIT:
+			if (!quic_get_var(&p, &len, &valuelen))
+				return -1;
+			if (valuelen)
+				return -1;
+			params->grease_quic_bit = 1;
+			break;
+		case QUIC_TRANSPORT_PARAM_MAX_ACK_DELAY:
+			if (quic_get_param(&params->max_ack_delay, &p, &len))
+				return -1;
+			if (params->max_ack_delay >= 16384)
+				return -1;
+			params->max_ack_delay *= 1000;
+			break;
+		case QUIC_TRANSPORT_PARAM_ACTIVE_CONNECTION_ID_LIMIT:
+			if (quic_get_param(&params->active_connection_id_limit, &p, &len) ||
+			    params->active_connection_id_limit < 2)
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_MAX_DATAGRAM_FRAME_SIZE:
+			if (quic_get_param(&params->max_datagram_frame_size, &p, &len))
+				return -1;
+			break;
+		case QUIC_TRANSPORT_PARAM_STATELESS_RESET_TOKEN:
+			if (quic_is_serv(sk))
+				return -1;
+			if (!quic_get_var(&p, &len, &valuelen) || len < valuelen ||
+			    valuelen != 16)
+				return -1;
+			quic_connection_id_set_token(active, p);
+			params->stateless_reset = 1;
+			len -= valuelen;
+			p += valuelen;
+			break;
+		case QUIC_TRANSPORT_PARAM_VERSION_INFORMATION:
+			if (quic_get_version_info(versions, &count, &p, &len))
+				return -1;
+			if (!count || quic_select_version(sk, versions, count))
+				return -1;
+			break;
+		default:
+			/* Ignore unknown parameter */
+			if (!quic_get_var(&p, &len, &valuelen))
+				return -1;
+			if (len < valuelen)
+				return -1;
+			len -= valuelen;
+			p += valuelen;
+			break;
+		}
+	}
+	return 0;
+}
+
+static u8 *quic_put_conn_id(u8 *p, enum quic_transport_param_id id,
+			    struct quic_connection_id *conn_id)
+{
+	p = quic_put_var(p, id);
+	p = quic_put_var(p, conn_id->len);
+	p = quic_put_data(p, conn_id->data, conn_id->len);
+	return p;
+}
+
+static u8 *quic_put_param(u8 *p, enum quic_transport_param_id id, u64 value)
+{
+	p = quic_put_var(p, id);
+	p = quic_put_var(p, quic_var_len(value));
+	return quic_put_var(p, value);
+}
+
+static u8 *quic_put_version_info(u8 *p, enum quic_transport_param_id id, u32 version)
+{
+	u32 *versions, i, len = 0;
+
+	versions = quic_compatible_versions(version);
+	if (!versions)
+		return p;
+
+	for (i = 0; versions[i]; i++)
+		len += 4;
+	p = quic_put_var(p, id);
+	p = quic_put_var(p, len);
+
+	for (i = 0; versions[i]; i++)
+		p = quic_put_int(p, versions[i], 4);
+
+	return p;
+}
+
+int quic_frame_get_transport_params_ext(struct sock *sk, struct quic_transport_param *params,
+					u8 *data, u32 *len)
+{
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_id *scid;
+	struct quic_crypto *crypto;
+	u8 *p = data, token[16];
+
+	scid = quic_connection_id_active(id_set);
+	if (quic_is_serv(sk)) {
+		p = quic_put_conn_id(p, QUIC_TRANSPORT_PARAM_ORIGINAL_DESTINATION_CONNECTION_ID,
+				     quic_outq_orig_dcid(outq));
+		if (params->stateless_reset) {
+			p = quic_put_var(p, QUIC_TRANSPORT_PARAM_STATELESS_RESET_TOKEN);
+			p = quic_put_var(p, 16);
+			crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+			if (quic_crypto_generate_stateless_reset_token(crypto, scid->data,
+								       scid->len, token, 16))
+				return -1;
+			p = quic_put_data(p, token, 16);
+		}
+		if (quic_outq_retry(outq)) {
+			p = quic_put_conn_id(p, QUIC_TRANSPORT_PARAM_RETRY_SOURCE_CONNECTION_ID,
+					     quic_outq_retry_dcid(outq));
+		}
+	}
+	p = quic_put_conn_id(p, QUIC_TRANSPORT_PARAM_INITIAL_SOURCE_CONNECTION_ID, scid);
+	if (params->max_stream_data_bidi_local) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_LOCAL,
+				   params->max_stream_data_bidi_local);
+	}
+	if (params->max_stream_data_bidi_remote) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_REMOTE,
+				   params->max_stream_data_bidi_remote);
+	}
+	if (params->max_stream_data_uni) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_UNI,
+				   params->max_stream_data_uni);
+	}
+	if (params->max_data) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_DATA,
+				   params->max_data);
+	}
+	if (params->max_streams_bidi) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_BIDI,
+				   params->max_streams_bidi);
+	}
+	if (params->max_streams_uni) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_UNI,
+				   params->max_streams_uni);
+	}
+	if (params->max_udp_payload_size != 65527) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_MAX_UDP_PAYLOAD_SIZE,
+				   params->max_udp_payload_size);
+	}
+	if (params->ack_delay_exponent != 3) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_ACK_DELAY_EXPONENT,
+				   params->ack_delay_exponent);
+	}
+	if (params->disable_active_migration) {
+		p = quic_put_var(p, QUIC_TRANSPORT_PARAM_DISABLE_ACTIVE_MIGRATION);
+		p = quic_put_var(p, 0);
+	}
+	if (params->disable_1rtt_encryption) {
+		p = quic_put_var(p, QUIC_TRANSPORT_PARAM_DISABLE_1RTT_ENCRYPTION);
+		p = quic_put_var(p, 0);
+	}
+	if (!params->disable_compatible_version) {
+		p = quic_put_version_info(p, QUIC_TRANSPORT_PARAM_VERSION_INFORMATION,
+					  quic_inq_version(quic_inq(sk)));
+	}
+	if (params->grease_quic_bit) {
+		p = quic_put_var(p, QUIC_TRANSPORT_PARAM_GREASE_QUIC_BIT);
+		p = quic_put_var(p, 0);
+	}
+	if (params->max_ack_delay != 25000) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_MAX_ACK_DELAY,
+				   params->max_ack_delay / 1000);
+	}
+	if (params->max_idle_timeout) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_MAX_IDLE_TIMEOUT,
+				   params->max_idle_timeout / 1000);
+	}
+	if (params->active_connection_id_limit && params->active_connection_id_limit != 2) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_ACTIVE_CONNECTION_ID_LIMIT,
+				   params->active_connection_id_limit);
+	}
+	if (params->max_datagram_frame_size) {
+		p = quic_put_param(p, QUIC_TRANSPORT_PARAM_MAX_DATAGRAM_FRAME_SIZE,
+				   params->max_datagram_frame_size);
+	}
+	*len = p - data;
+	return 0;
+}
diff --git a/net/quic/frame.h b/net/quic/frame.h
new file mode 100644
index 000000000000..3dbe36c9e822
--- /dev/null
+++ b/net/quic/frame.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+enum {
+	QUIC_FRAME_PADDING = 0x00,
+	QUIC_FRAME_PING = 0x01,
+	QUIC_FRAME_ACK = 0x02,
+	QUIC_FRAME_ACK_ECN = 0x03,
+	QUIC_FRAME_RESET_STREAM = 0x04,
+	QUIC_FRAME_STOP_SENDING = 0x05,
+	QUIC_FRAME_CRYPTO = 0x06,
+	QUIC_FRAME_NEW_TOKEN = 0x07,
+	QUIC_FRAME_STREAM = 0x08,
+	QUIC_FRAME_MAX_DATA = 0x10,
+	QUIC_FRAME_MAX_STREAM_DATA = 0x11,
+	QUIC_FRAME_MAX_STREAMS_BIDI = 0x12,
+	QUIC_FRAME_MAX_STREAMS_UNI = 0x13,
+	QUIC_FRAME_DATA_BLOCKED = 0x14,
+	QUIC_FRAME_STREAM_DATA_BLOCKED = 0x15,
+	QUIC_FRAME_STREAMS_BLOCKED_BIDI = 0x16,
+	QUIC_FRAME_STREAMS_BLOCKED_UNI = 0x17,
+	QUIC_FRAME_NEW_CONNECTION_ID = 0x18,
+	QUIC_FRAME_RETIRE_CONNECTION_ID = 0x19,
+	QUIC_FRAME_PATH_CHALLENGE = 0x1a,
+	QUIC_FRAME_PATH_RESPONSE = 0x1b,
+	QUIC_FRAME_CONNECTION_CLOSE = 0x1c,
+	QUIC_FRAME_CONNECTION_CLOSE_APP = 0x1d,
+	QUIC_FRAME_HANDSHAKE_DONE = 0x1e,
+	QUIC_FRAME_DATAGRAM = 0x30, /* RFC 9221 */
+	QUIC_FRAME_DATAGRAM_LEN = 0x31,
+	QUIC_FRAME_MAX = QUIC_FRAME_DATAGRAM_LEN,
+};
+
+enum quic_transport_error {
+	QUIC_TRANSPORT_ERROR_NONE,
+	QUIC_TRANSPORT_ERROR_INTERNAL,
+	QUIC_TRANSPORT_ERROR_CONNECTION_REFUSED,
+	QUIC_TRANSPORT_ERROR_FLOW_CONTROL,
+	QUIC_TRANSPORT_ERROR_STREAM_LIMIT,
+	QUIC_TRANSPORT_ERROR_STREAM_STATE,
+	QUIC_TRANSPORT_ERROR_FINAL_SIZE,
+	QUIC_TRANSPORT_ERROR_FRAME_ENCODING,
+	QUIC_TRANSPORT_ERROR_TRANSPORT_PARAM,
+	QUIC_TRANSPORT_ERROR_CONNECTION_ID_LIMIT,
+	QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION,
+	QUIC_TRANSPORT_ERROR_INVALID_TOKEN,
+	QUIC_TRANSPORT_ERROR_APPLICATION,
+	QUIC_TRANSPORT_ERROR_CRYPTO_BUF_EXCEEDED,
+	QUIC_TRANSPORT_ERROR_KEY_UPDATE,
+	QUIC_TRANSPORT_ERROR_AEAD_LIMIT_REACHED,
+	QUIC_TRANSPORT_ERROR_NO_VIABLE_PATH,
+
+	/* The cryptographic handshake failed. A range of 256 values is reserved
+	 * for carrying error codes specific to the cryptographic handshake that
+	 * is used. Codes for errors occurring when TLS is used for the
+	 * cryptographic handshake are described in Section 4.8 of [QUIC-TLS].
+	 */
+	QUIC_TRANSPORT_ERROR_CRYPTO,
+};
+
+enum quic_transport_param_id {
+	QUIC_TRANSPORT_PARAM_ORIGINAL_DESTINATION_CONNECTION_ID = 0x0000,
+	QUIC_TRANSPORT_PARAM_MAX_IDLE_TIMEOUT = 0x0001,
+	QUIC_TRANSPORT_PARAM_STATELESS_RESET_TOKEN = 0x0002,
+	QUIC_TRANSPORT_PARAM_MAX_UDP_PAYLOAD_SIZE = 0x0003,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_DATA = 0x0004,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_LOCAL = 0x0005,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_BIDI_REMOTE = 0x0006,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAM_DATA_UNI = 0x0007,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_BIDI = 0x0008,
+	QUIC_TRANSPORT_PARAM_INITIAL_MAX_STREAMS_UNI = 0x0009,
+	QUIC_TRANSPORT_PARAM_ACK_DELAY_EXPONENT = 0x000a,
+	QUIC_TRANSPORT_PARAM_MAX_ACK_DELAY = 0x000b,
+	QUIC_TRANSPORT_PARAM_DISABLE_ACTIVE_MIGRATION = 0x000c,
+	QUIC_TRANSPORT_PARAM_PREFERRED_ADDRESS = 0x000d,
+	QUIC_TRANSPORT_PARAM_ACTIVE_CONNECTION_ID_LIMIT = 0x000e,
+	QUIC_TRANSPORT_PARAM_INITIAL_SOURCE_CONNECTION_ID = 0x000f,
+	QUIC_TRANSPORT_PARAM_RETRY_SOURCE_CONNECTION_ID = 0x0010,
+	QUIC_TRANSPORT_PARAM_MAX_DATAGRAM_FRAME_SIZE = 0x0020,
+	QUIC_TRANSPORT_PARAM_GREASE_QUIC_BIT = 0x2ab2,
+	QUIC_TRANSPORT_PARAM_VERSION_INFORMATION = 0x11,
+	QUIC_TRANSPORT_PARAM_DISABLE_1RTT_ENCRYPTION = 0xbaad,
+};
+
+struct quic_msginfo {
+	struct quic_stream *stream;
+	struct iov_iter *msg;
+	u8 level;
+	u32 flag;
+};
+
+struct quic_frame_ops {
+	struct sk_buff *(*frame_create)(struct sock *sk, void *data, u8 type);
+	int (*frame_process)(struct sock *sk, struct sk_buff *skb, u8 type);
+};
+
+static inline bool quic_frame_ack_eliciting(u8 type)
+{
+	return type != QUIC_FRAME_ACK && type != QUIC_FRAME_ACK_ECN &&
+	       type != QUIC_FRAME_PADDING && type != QUIC_FRAME_PATH_RESPONSE &&
+	       type != QUIC_FRAME_CONNECTION_CLOSE && type != QUIC_FRAME_CONNECTION_CLOSE_APP;
+}
+
+static inline bool quic_frame_retransmittable(u8 type)
+{
+	return quic_frame_ack_eliciting(type) &&
+	       type != QUIC_FRAME_PING && type != QUIC_FRAME_PATH_CHALLENGE;
+}
+
+static inline bool quic_frame_ack_immediate(u8 type)
+{
+	return (type < QUIC_FRAME_STREAM || type >= QUIC_FRAME_MAX_DATA) ||
+	       (type & QUIC_STREAM_BIT_FIN);
+}
+
+static inline bool quic_frame_non_probing(u8 type)
+{
+	return type != QUIC_FRAME_NEW_CONNECTION_ID && type != QUIC_FRAME_PADDING &&
+	       type != QUIC_FRAME_PATH_RESPONSE && type != QUIC_FRAME_PATH_CHALLENGE;
+}
+
+static inline bool quic_frame_is_dgram(u8 type)
+{
+	return type == QUIC_FRAME_DATAGRAM || type == QUIC_FRAME_DATAGRAM_LEN;
+}
+
+static inline int quic_frame_level_check(u8 level, u8 type)
+{
+	if (level == QUIC_CRYPTO_APP)
+		return 0;
+
+	if (level == QUIC_CRYPTO_EARLY &&
+	    (type == QUIC_FRAME_ACK || type == QUIC_FRAME_ACK_ECN ||
+	     type == QUIC_FRAME_CRYPTO || type == QUIC_FRAME_HANDSHAKE_DONE ||
+	     type == QUIC_FRAME_NEW_TOKEN || type == QUIC_FRAME_PATH_RESPONSE ||
+	     type == QUIC_FRAME_RETIRE_CONNECTION_ID))
+		return 1;
+
+	if (type != QUIC_FRAME_ACK && type != QUIC_FRAME_ACK_ECN &&
+	    type != QUIC_FRAME_PADDING && type != QUIC_FRAME_PING &&
+	    type != QUIC_FRAME_CRYPTO && type != QUIC_FRAME_CONNECTION_CLOSE)
+		return 1;
+	return 0;
+}
+
+struct sk_buff *quic_frame_create(struct sock *sk, u8 type, void *data);
+int quic_frame_process(struct sock *sk, struct sk_buff *skb, struct quic_packet_info *pki);
+int quic_frame_new_connection_id_ack(struct sock *sk, struct sk_buff *skb);
+int quic_frame_set_transport_params_ext(struct sock *sk, struct quic_transport_param *params,
+					u8 *data, u32 len);
+int quic_frame_get_transport_params_ext(struct sock *sk, struct quic_transport_param *params,
+					u8 *data, u32 *len);
+int quic_frame_handshake_process(struct sock *sk, struct sk_buff *skb,
+				 struct quic_packet_info *pki);
+struct sk_buff *quic_frame_handshake_create(struct sock *sk, u8 type, void *data);
diff --git a/net/quic/hashtable.h b/net/quic/hashtable.h
new file mode 100644
index 000000000000..567d36d9e74b
--- /dev/null
+++ b/net/quic/hashtable.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+struct quichdr {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 pnl:2,
+	     key:1,
+	     reserved:2,
+	     spin:1,
+	     fixed:1,
+	     form:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8 form:1,
+	     fixed:1,
+	     spin:1,
+	     reserved:2,
+	     key:1,
+	     pnl:2;
+#endif
+};
+
+static inline struct quichdr *quic_hdr(struct sk_buff *skb)
+{
+	return (struct quichdr *)skb_transport_header(skb);
+}
+
+struct quichshdr {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8 pnl:2,
+	     reserved:2,
+	     type:2,
+	     fixed:1,
+	     form:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8 form:1,
+	     fixed:1,
+	     type:2,
+	     reserved:2,
+	     pnl:2;
+#endif
+};
+
+static inline struct quichshdr *quic_hshdr(struct sk_buff *skb)
+{
+	return (struct quichshdr *)skb_transport_header(skb);
+}
+
+union quic_addr {
+	struct sockaddr_in6 v6;
+	struct sockaddr_in v4;
+	struct sockaddr sa;
+};
+
+static inline union quic_addr *quic_addr(const void *addr)
+{
+	return (union quic_addr *)addr;
+}
+
+struct quic_hash_head {
+	spinlock_t		lock; /* protect the 'head' member access */
+	struct hlist_head	head;
+};
+
+struct quic_hash_table {
+	struct quic_hash_head *hash;
+	int size;
+};
+
+enum  {
+	QUIC_HT_UDP_SOCK,
+	QUIC_HT_LISTEN_SOCK,
+	QUIC_HT_CONNECTION_ID,
+	QUIC_HT_BIND_PORT,
+	QUIC_HT_MAX_TABLES,
+};
+
+static inline __u32 quic_ahash(const struct net *net, const union quic_addr *a)
+{
+	__u32 addr = (a->sa.sa_family == AF_INET6) ? jhash(&a->v6.sin6_addr, 16, 0)
+						   : (__force __u32)a->v4.sin_addr.s_addr;
+
+	return  jhash_3words(addr, (__force __u32)a->v4.sin_port, net_hash_mix(net), 0);
+}
+
+extern struct quic_hash_table quic_hash_tables[QUIC_HT_MAX_TABLES];
+
+static inline struct quic_hash_head *quic_listen_sock_head(struct net *net, union quic_addr *a)
+{
+	struct quic_hash_table *ht = &quic_hash_tables[QUIC_HT_LISTEN_SOCK];
+
+	return &ht->hash[quic_ahash(net, a) & (ht->size - 1)];
+}
+
+static inline struct quic_hash_head *quic_bind_port_head(struct net *net, u16 port)
+{
+	struct quic_hash_table *ht = &quic_hash_tables[QUIC_HT_BIND_PORT];
+
+	return &ht->hash[port & (ht->size - 1)];
+}
+
+static inline struct quic_hash_head *quic_source_connection_id_head(struct net *net, u8 *scid)
+{
+	struct quic_hash_table *ht = &quic_hash_tables[QUIC_HT_CONNECTION_ID];
+
+	return &ht->hash[jhash(scid, 4, 0) & (ht->size - 1)];
+}
+
+static inline struct quic_hash_head *quic_udp_sock_head(struct net *net, union quic_addr *addr)
+{
+	struct quic_hash_table *ht = &quic_hash_tables[QUIC_HT_UDP_SOCK];
+
+	return &ht->hash[quic_ahash(net, addr) & (ht->size - 1)];
+}
+
+static inline struct quic_hash_head *quic_stream_head(struct quic_hash_table *ht, u64 stream_id)
+{
+	return &ht->hash[stream_id & (ht->size - 1)];
+}
diff --git a/net/quic/input.c b/net/quic/input.c
new file mode 100644
index 000000000000..fffd85067692
--- /dev/null
+++ b/net/quic/input.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include "number.h"
+#include "frame.h"
+
+static void quic_inq_rfree(struct sk_buff *skb)
+{
+	atomic_sub(skb->len, &skb->sk->sk_rmem_alloc);
+	sk_mem_uncharge(skb->sk, skb->len);
+}
+
+void quic_inq_set_owner_r(struct sk_buff *skb, struct sock *sk)
+{
+	skb_orphan(skb);
+	skb->sk = sk;
+	atomic_add(skb->len, &sk->sk_rmem_alloc);
+	sk_mem_charge(sk, skb->len);
+	skb->destructor = quic_inq_rfree;
+}
+
+static int quic_new_sock_do_rcv(struct sock *sk, struct sk_buff *skb,
+				union quic_addr *da, union quic_addr *sa)
+{
+	struct sock *nsk;
+	int ret = 0;
+
+	local_bh_disable();
+	nsk = quic_sock_lookup(skb, da, sa);
+	if (nsk == sk)
+		goto out;
+	/* the request sock was just accepted */
+	bh_lock_sock(nsk);
+	if (sock_owned_by_user(nsk)) {
+		if (sk_add_backlog(nsk, skb, READ_ONCE(nsk->sk_rcvbuf)))
+			kfree_skb(skb);
+	} else {
+		sk->sk_backlog_rcv(nsk, skb);
+	}
+	bh_unlock_sock(nsk);
+	ret = 1;
+out:
+	local_bh_enable();
+	return ret;
+}
+
+static int quic_get_connid_and_token(struct sk_buff *skb, struct quic_connection_id *dcid,
+				     struct quic_connection_id *scid, struct quic_data *token)
+{
+	u8 *p = (u8 *)quic_hshdr(skb) + 1;
+	int len = skb->len;
+
+	if (len-- < 1)
+		return -EINVAL;
+	p += 4;
+	dcid->len = quic_get_int(&p, 1);
+	if (dcid->len > len)
+		return -EINVAL;
+	memcpy(dcid->data, p, dcid->len);
+	len -= dcid->len;
+	if (len-- < 1)
+		return -EINVAL;
+	p += dcid->len;
+	scid->len = quic_get_int(&p, 1);
+	if (scid->len > len)
+		return -EINVAL;
+	memcpy(scid->data, p, scid->len);
+	len -= scid->len;
+	p += scid->len;
+	if (len-- < 1)
+		return -EINVAL;
+	token->len = quic_get_int(&p, 1);
+	if (token->len > len)
+		return -EINVAL;
+	if (token->len)
+		token->data = p;
+	return 0;
+}
+
+static int quic_do_listen_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	u8 *p = (u8 *)quic_hshdr(skb) + 1, type;
+	struct quic_request_sock req = {};
+	struct quic_crypto *crypto;
+	int err = -EINVAL, errcode;
+	struct quic_data token;
+
+	quic_get_msg_addr(sk, &req.sa, skb, 0);
+	quic_get_msg_addr(sk, &req.da, skb, 1);
+	if (quic_request_sock_exists(sk, &req.sa, &req.da))
+		goto out;
+
+	if (QUIC_RCV_CB(skb)->backlog &&
+	    quic_new_sock_do_rcv(sk, skb, &req.sa, &req.da))
+		return 0;
+
+	if (!quic_hshdr(skb)->form) { /* stateless reset always by listen sock */
+		if (skb->len < 17)
+			goto err;
+
+		req.dcid.len = 16;
+		memcpy(req.dcid.data, (u8 *)quic_hdr(skb) + 1, 16);
+		consume_skb(skb);
+		return quic_packet_stateless_reset_transmit(sk, &req);
+	}
+
+	if (quic_get_connid_and_token(skb, &req.dcid, &req.scid, &token))
+		goto err;
+
+	req.version = quic_get_int(&p, 4);
+	if (!quic_compatible_versions(req.version)) {
+		consume_skb(skb);
+		/* version negotication */
+		return quic_packet_version_transmit(sk, &req);
+	}
+
+	type = quic_version_get_type(req.version, quic_hshdr(skb)->type);
+	if (type != QUIC_PACKET_INITIAL) { /* stateless reset for handshake */
+		consume_skb(skb);
+		return quic_packet_stateless_reset_transmit(sk, &req);
+	}
+
+	quic_connection_id_update(&req.orig_dcid, req.dcid.data, req.dcid.len);
+	if (quic_inq_validate_peer_address(inq)) {
+		if (!token.len) {
+			consume_skb(skb);
+			return quic_packet_retry_transmit(sk, &req);
+		}
+		crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+		err = quic_crypto_verify_token(crypto, &req.da, quic_addr_len(sk),
+					       &req.orig_dcid, token.data, token.len);
+		if (err) {
+			consume_skb(skb);
+			errcode = QUIC_TRANSPORT_ERROR_INVALID_TOKEN;
+			return quic_packet_refuse_close_transmit(sk, &req, errcode);
+		}
+		req.retry = *(u8 *)token.data;
+	}
+
+	err = quic_request_sock_enqueue(sk, &req);
+	if (err) {
+		consume_skb(skb);
+		errcode = QUIC_TRANSPORT_ERROR_CONNECTION_REFUSED;
+		return quic_packet_refuse_close_transmit(sk, &req, errcode);
+	}
+out:
+	if (atomic_read(&sk->sk_rmem_alloc) + skb->len > sk->sk_rcvbuf) {
+		err = -ENOBUFS;
+		goto err;
+	}
+
+	quic_inq_set_owner_r(skb, sk); /* handle it later when accepting the sock */
+	__skb_queue_tail(&quic_inq(sk)->backlog_list, skb);
+	sk->sk_data_ready(sk);
+	return 0;
+err:
+	kfree_skb(skb);
+	return err;
+}
+
+int quic_do_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	if (quic_is_listen(sk))
+		return quic_do_listen_rcv(sk, skb);
+
+	if (quic_is_closed(sk)) {
+		kfree_skb(skb);
+		return 0;
+	}
+	return quic_packet_process(sk, skb, 0);
+}
+
+int quic_rcv(struct sk_buff *skb)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_addr_family_ops *af_ops;
+	struct quic_connection_id *conn_id;
+	union quic_addr daddr, saddr;
+	struct sock *sk = NULL;
+	int err = -EINVAL;
+	u8 *dcid;
+
+	skb_pull(skb, skb_transport_offset(skb));
+	af_ops = quic_af_ops_get(ip_hdr(skb)->version == 4 ? AF_INET : AF_INET6);
+
+	if (skb->len < sizeof(struct quichdr))
+		goto err;
+
+	if (!quic_hdr(skb)->form) { /* search scid hashtable for post-handshake packets */
+		dcid = (u8 *)quic_hdr(skb) + 1;
+		conn_id = quic_connection_id_lookup(dev_net(skb->dev), dcid, skb->len - 1);
+		if (conn_id) {
+			rcv_cb->number_offset = conn_id->len + sizeof(struct quichdr);
+			sk = quic_connection_id_sk(conn_id);
+		}
+	}
+	if (!sk) {
+		af_ops->get_msg_addr(&daddr, skb, 0);
+		af_ops->get_msg_addr(&saddr, skb, 1);
+		sk = quic_sock_lookup(skb, &daddr, &saddr);
+		if (!sk)
+			goto err;
+	}
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		rcv_cb->backlog = 1;
+		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+			bh_unlock_sock(sk);
+			goto err;
+		}
+	} else {
+		sk->sk_backlog_rcv(sk, skb); /* quic_do_rcv */
+	}
+	bh_unlock_sock(sk);
+	return 0;
+
+err:
+	kfree_skb(skb);
+	return err;
+}
+
+void quic_rcv_err_icmp(struct sock *sk)
+{
+	u8 taglen = quic_packet_taglen(quic_packet(sk));
+	struct quic_path_addr *path = quic_dst(sk);
+	u32 pathmtu, info;
+	bool reset_timer;
+
+	info = quic_path_mtu_info(path);
+	if (!quic_inq(sk)->probe_timeout) {
+		quic_packet_mss_update(sk, info - quic_encap_len(sk));
+		return;
+	}
+	info = info - quic_encap_len(sk) - taglen;
+	pathmtu = quic_path_pl_toobig(path, info, &reset_timer);
+	if (reset_timer) {
+		quic_timer_setup(sk, QUIC_TIMER_PROBE, quic_inq(sk)->probe_timeout);
+		quic_timer_reset(sk, QUIC_TIMER_PROBE);
+	}
+	if (pathmtu)
+		quic_packet_mss_update(sk, pathmtu + taglen);
+}
+
+int quic_rcv_err(struct sk_buff *skb)
+{
+	struct quic_addr_family_ops *af_ops;
+	union quic_addr daddr, saddr;
+	struct quic_path_addr *path;
+	struct sock *sk = NULL;
+	int ret = 0;
+	u32 info;
+
+	af_ops = quic_af_ops_get(ip_hdr(skb)->version == 4 ? AF_INET : AF_INET6);
+
+	af_ops->get_msg_addr(&saddr, skb, 0);
+	af_ops->get_msg_addr(&daddr, skb, 1);
+	sk = quic_sock_lookup(skb, &daddr, &saddr);
+	if (!sk)
+		return -ENOENT;
+
+	bh_lock_sock(sk);
+	if (quic_is_listen(sk))
+		goto out;
+
+	if (quic_get_mtu_info(sk, skb, &info))
+		goto out;
+
+	ret = 1; /* processed with common mtud */
+	path = quic_dst(sk);
+	quic_path_set_mtu_info(path, info);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_MTU_REDUCED_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+	quic_rcv_err_icmp(sk);
+out:
+	bh_unlock_sock(sk);
+	return ret;
+}
+
+static void quic_inq_recv_tail(struct sock *sk, struct quic_stream *stream, struct sk_buff *skb)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_stream_update update = {};
+	u64 overlap;
+
+	overlap = stream->recv.offset - rcv_cb->offset;
+	if (overlap) {
+		skb_orphan(skb);
+		skb_pull(skb, overlap);
+		quic_inq_set_owner_r(skb, sk);
+		rcv_cb->offset += overlap;
+	}
+
+	if (rcv_cb->stream_fin) {
+		update.id = stream->id;
+		update.state = QUIC_STREAM_RECV_STATE_RECVD;
+		update.errcode = rcv_cb->offset + skb->len;
+		quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update);
+		stream->recv.state = update.state;
+	}
+	stream->recv.offset += skb->len;
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	sk->sk_data_ready(sk);
+}
+
+int quic_inq_flow_control(struct sock *sk, struct quic_stream *stream, int len)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff *nskb = NULL;
+	u32 window;
+
+	if (!len)
+		return 0;
+
+	stream->recv.bytes += len;
+	inq->bytes += len;
+
+	/* recv flow control */
+	if (inq->max_bytes - inq->bytes < inq->window / 2) {
+		window = inq->window;
+		if (sk_under_memory_pressure(sk))
+			window >>= 1;
+		inq->max_bytes = inq->bytes + window;
+		nskb = quic_frame_create(sk, QUIC_FRAME_MAX_DATA, inq);
+		if (nskb)
+			quic_outq_ctrl_tail(sk, nskb, true);
+	}
+
+	if (stream->recv.max_bytes - stream->recv.bytes < stream->recv.window / 2) {
+		window = stream->recv.window;
+		if (sk_under_memory_pressure(sk))
+			window >>= 1;
+		stream->recv.max_bytes = stream->recv.bytes + window;
+		nskb = quic_frame_create(sk, QUIC_FRAME_MAX_STREAM_DATA, stream);
+		if (nskb)
+			quic_outq_ctrl_tail(sk, nskb, true);
+	}
+
+	if (!nskb)
+		return 0;
+
+	quic_outq_flush(sk);
+	return 1;
+}
+
+int quic_inq_reasm_tail(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	u64 offset = rcv_cb->offset, off, highest = 0;
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_stream_update update = {};
+	u64 stream_id = rcv_cb->stream->id;
+	struct quic_stream *stream;
+	struct sk_buff_head *head;
+	struct sk_buff *tmp;
+
+	stream = rcv_cb->stream;
+	if (stream->recv.offset >= offset + skb->len) { /* dup */
+		kfree_skb(skb);
+		return 0;
+	}
+
+	if (atomic_read(&sk->sk_rmem_alloc) + skb->len > sk->sk_rcvbuf ||
+	    !sk_rmem_schedule(sk, skb, skb->len))
+		return -ENOBUFS;
+
+	quic_inq_set_owner_r(skb, sk);
+	off = offset + skb->len;
+	if (off > stream->recv.highest) {
+		highest = off - stream->recv.highest;
+		if (inq->highest + highest > inq->max_bytes ||
+		    stream->recv.highest + highest > stream->recv.max_bytes) {
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_FLOW_CONTROL;
+			return -ENOBUFS;
+		}
+		if (stream->recv.finalsz && off > stream->recv.finalsz) {
+			rcv_cb->errcode = QUIC_TRANSPORT_ERROR_FINAL_SIZE;
+			return -EINVAL;
+		}
+	}
+	if (!stream->recv.highest && !rcv_cb->stream_fin) {
+		update.id = stream->id;
+		update.state = QUIC_STREAM_RECV_STATE_RECV;
+		if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update))
+			return -ENOMEM;
+	}
+	head = &inq->reassemble_list;
+	if (stream->recv.offset < offset) {
+		skb_queue_walk(head, tmp) {
+			rcv_cb = QUIC_RCV_CB(tmp);
+			if (rcv_cb->stream->id < stream_id)
+				continue;
+			if (rcv_cb->stream->id > stream_id)
+				break;
+			if (rcv_cb->offset > offset)
+				break;
+			if (rcv_cb->offset + tmp->len >= offset + skb->len) { /* dup */
+				kfree_skb(skb);
+				return 0;
+			}
+		}
+		rcv_cb = QUIC_RCV_CB(skb);
+		if (rcv_cb->stream_fin) {
+			if (off < stream->recv.highest ||
+			    (stream->recv.finalsz && stream->recv.finalsz != off)) {
+				rcv_cb->errcode = QUIC_TRANSPORT_ERROR_FINAL_SIZE;
+				return -EINVAL;
+			}
+			update.id = stream->id;
+			update.state = QUIC_STREAM_RECV_STATE_SIZE_KNOWN;
+			update.finalsz = off;
+			if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update))
+				return -ENOMEM;
+			stream->recv.state = update.state;
+			stream->recv.finalsz = update.finalsz;
+		}
+		__skb_queue_before(head, tmp, skb);
+		stream->recv.frags++;
+		inq->highest += highest;
+		stream->recv.highest += highest;
+		return 0;
+	}
+
+	/* fast path: stream->recv.offset == offset */
+	inq->highest += highest;
+	stream->recv.highest += highest;
+	quic_inq_recv_tail(sk, stream, skb);
+	if (!stream->recv.frags)
+		return 0;
+
+	skb_queue_walk_safe(head, skb, tmp) {
+		rcv_cb = QUIC_RCV_CB(skb);
+		if (rcv_cb->stream->id < stream_id)
+			continue;
+		if (rcv_cb->stream->id > stream_id)
+			break;
+		if (rcv_cb->offset > stream->recv.offset)
+			break;
+		__skb_unlink(skb, head);
+		stream->recv.frags--;
+		if (rcv_cb->offset + skb->len <= stream->recv.offset) { /* dup */
+			kfree_skb(skb);
+			continue;
+		}
+		quic_inq_recv_tail(sk, stream, skb);
+	}
+	return 0;
+}
+
+void quic_inq_stream_purge(struct sock *sk, struct quic_stream *stream)
+{
+	struct sk_buff_head *head = &quic_inq(sk)->reassemble_list;
+	struct sk_buff *skb, *tmp;
+
+	skb_queue_walk_safe(head, skb, tmp) {
+		if (QUIC_RCV_CB(skb)->stream != stream)
+			continue;
+		__skb_unlink(skb, head);
+		kfree_skb(skb);
+	}
+}
+
+int quic_inq_handshake_tail(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	u64 offset = rcv_cb->offset, crypto_offset;
+	struct quic_crypto *crypto;
+	struct sk_buff_head *head;
+	u8 level = rcv_cb->level;
+	struct sk_buff *tmp;
+
+	crypto = quic_crypto(sk, level);
+	crypto_offset = quic_crypto_recv_offset(crypto);
+	pr_debug("[QUIC] %s recv_offset: %llu offset: %llu level: %u\n", __func__,
+		 crypto_offset, offset, level);
+	if (offset < crypto_offset) { /* dup */
+		kfree_skb(skb);
+		return 0;
+	}
+	if (atomic_read(&sk->sk_rmem_alloc) + skb->len > sk->sk_rcvbuf) {
+		rcv_cb->errcode = QUIC_TRANSPORT_ERROR_CRYPTO_BUF_EXCEEDED;
+		return -ENOBUFS;
+	}
+	quic_inq_set_owner_r(skb, sk);
+	head = &quic_inq(sk)->handshake_list;
+	if (offset > crypto_offset) {
+		skb_queue_walk(head, tmp) {
+			rcv_cb = QUIC_RCV_CB(tmp);
+			if (rcv_cb->level < level)
+				continue;
+			if (rcv_cb->level > level)
+				break;
+			if (rcv_cb->offset > offset)
+				break;
+			if (rcv_cb->offset == offset) { /* dup */
+				kfree_skb(skb);
+				return 0;
+			}
+		}
+		__skb_queue_before(head, tmp, skb);
+		return 0;
+	}
+
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	sk->sk_data_ready(sk);
+	quic_crypto_increase_recv_offset(crypto, skb->len);
+
+	skb_queue_walk_safe(head, skb, tmp) {
+		rcv_cb = QUIC_RCV_CB(skb);
+		if (rcv_cb->level < level)
+			continue;
+		if (rcv_cb->level > level)
+			break;
+		if (rcv_cb->offset > crypto_offset)
+			break;
+		__skb_unlink(skb, head);
+		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		sk->sk_data_ready(sk);
+		quic_crypto_increase_recv_offset(crypto, skb->len);
+	}
+	return 0;
+}
+
+void quic_inq_set_param(struct sock *sk, struct quic_transport_param *p)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+
+	inq->max_datagram_frame_size = p->max_datagram_frame_size;
+	inq->max_udp_payload_size = p->max_udp_payload_size;
+	inq->max_ack_delay = p->max_ack_delay;
+	inq->ack_delay_exponent = p->ack_delay_exponent;
+	inq->max_idle_timeout = p->max_idle_timeout;
+	inq->grease_quic_bit = p->grease_quic_bit;
+	inq->window = p->max_data;
+
+	inq->max_bytes = p->max_data;
+	if (sk->sk_rcvbuf < p->max_data * 2)
+		sk->sk_rcvbuf = p->max_data * 2;
+
+	inq->probe_timeout = p->plpmtud_probe_timeout;
+	inq->version = p->version;
+	inq->validate_peer_address = p->validate_peer_address;
+	inq->receive_session_ticket = p->receive_session_ticket;
+	inq->disable_1rtt_encryption = p->disable_1rtt_encryption;
+	quic_timer_setup(sk, QUIC_TIMER_PROBE, inq->probe_timeout);
+}
+
+int quic_inq_event_recv(struct sock *sk, u8 event, void *args)
+{
+	struct quic_stream *stream = NULL;
+	struct quic_rcv_cb *rcv_cb;
+	struct sk_buff *skb, *last;
+	int args_len = 0;
+
+	if (!event || event > QUIC_EVENT_MAX)
+		return -EINVAL;
+
+	if (!(quic_inq(sk)->events & (1 << event)))
+		return 0;
+
+	switch (event) {
+	case QUIC_EVENT_STREAM_UPDATE:
+		stream = quic_stream_find(quic_streams(sk),
+					  ((struct quic_stream_update *)args)->id);
+		if (!stream)
+			return -EINVAL;
+		args_len = sizeof(struct quic_stream_update);
+		break;
+	case QUIC_EVENT_STREAM_MAX_STREAM:
+		args_len = sizeof(u64);
+		break;
+	case QUIC_EVENT_NEW_TOKEN:
+		args_len = ((struct quic_data *)args)->len;
+		args = ((struct quic_data *)args)->data;
+		break;
+	case QUIC_EVENT_CONNECTION_CLOSE:
+		args_len = strlen(((struct quic_connection_close *)args)->phrase) +
+			   1 + sizeof(struct quic_connection_close);
+		break;
+	case QUIC_EVENT_KEY_UPDATE:
+		args_len = sizeof(u8);
+		break;
+	case QUIC_EVENT_CONNECTION_MIGRATION:
+		args_len = sizeof(u8);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	skb = alloc_skb(1 + args_len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	skb_put_data(skb, &event, 1);
+	skb_put_data(skb, args, args_len);
+
+	rcv_cb = QUIC_RCV_CB(skb);
+	rcv_cb->event = event;
+	rcv_cb->stream = stream;
+
+	/* always put event ahead of data */
+	last = quic_inq(sk)->last_event ?: (struct sk_buff *)&sk->sk_receive_queue;
+	__skb_queue_after(&sk->sk_receive_queue, last, skb);
+	quic_inq(sk)->last_event = skb;
+	sk->sk_data_ready(sk);
+	return 0;
+}
+
+int quic_inq_dgram_tail(struct sock *sk, struct sk_buff *skb)
+{
+	if (atomic_read(&sk->sk_rmem_alloc) + skb->len > sk->sk_rcvbuf ||
+	    !sk_rmem_schedule(sk, skb, skb->len))
+		return -ENOBUFS;
+
+	quic_inq_set_owner_r(skb, sk);
+	QUIC_RCV_CB(skb)->dgram = 1;
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	sk->sk_data_ready(sk);
+	return 0;
+}
+
+static void quic_inq_decrypted_work(struct work_struct *work)
+{
+	struct quic_sock *qs = container_of(work, struct quic_sock, inq.work);
+	struct sock *sk = &qs->inet.sk;
+	struct sk_buff_head *head;
+	struct sk_buff *skb;
+
+	lock_sock(sk);
+	head = &quic_inq(sk)->decrypted_list;
+	if (sock_flag(sk, SOCK_DEAD)) {
+		skb_queue_purge(head);
+		goto out;
+	}
+
+	skb = skb_dequeue(head);
+	while (skb) {
+		quic_packet_process(sk, skb, 1);
+		skb = skb_dequeue(head);
+	}
+out:
+	release_sock(sk);
+	sock_put(sk);
+}
+
+void quic_inq_decrypted_tail(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+
+	sock_hold(sk);
+	skb_queue_tail(&inq->decrypted_list, skb);
+
+	if (!schedule_work(&inq->work))
+		sock_put(sk);
+}
+
+void quic_inq_backlog_tail(struct sock *sk, struct sk_buff *skb)
+{
+	__skb_queue_tail(&quic_inq(sk)->backlog_list, skb);
+}
+
+void quic_inq_init(struct sock *sk)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+
+	skb_queue_head_init(&inq->reassemble_list);
+	skb_queue_head_init(&inq->decrypted_list);
+	skb_queue_head_init(&inq->handshake_list);
+	skb_queue_head_init(&inq->backlog_list);
+	INIT_WORK(&inq->work, quic_inq_decrypted_work);
+}
+
+void quic_inq_free(struct sock *sk)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+
+	__skb_queue_purge(&sk->sk_receive_queue);
+	__skb_queue_purge(&inq->reassemble_list);
+	__skb_queue_purge(&inq->handshake_list);
+	__skb_queue_purge(&inq->backlog_list);
+}
diff --git a/net/quic/input.h b/net/quic/input.h
new file mode 100644
index 000000000000..ecced736eea1
--- /dev/null
+++ b/net/quic/input.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+struct quic_inqueue {
+	struct sk_buff_head reassemble_list;
+	struct sk_buff_head handshake_list;
+	struct sk_buff_head decrypted_list;
+	struct sk_buff_head backlog_list;
+	struct sk_buff *last_event;
+	struct work_struct work;
+	u64 max_bytes;
+	u64 window;
+	u64 bytes;
+	u64 highest;
+
+	u32 max_datagram_frame_size;
+	u32 max_udp_payload_size;
+	u32 ack_delay_exponent;
+	u32 max_idle_timeout;
+	u32 max_ack_delay;
+	u32 events;
+	u32 probe_timeout;
+	u32 version;
+	u8 grease_quic_bit:1;
+	u8 validate_peer_address:1;
+	u8 receive_session_ticket:1;
+	u8 disable_1rtt_encryption:1;
+};
+
+struct quic_rcv_cb {
+	struct quic_stream *stream;
+	u64 offset; /* stream or crypto offset */
+	u32 errcode;
+	u16 read_offset;
+	u16 udph_offset;
+	u8 number_offset;
+	u8 event;
+	u8 level;
+	u8 dgram:1;
+	u8 backlog:1;
+	u8 stream_fin:1;
+	u8 path_alt:2;
+};
+
+#define QUIC_RCV_CB(__skb)	((struct quic_rcv_cb *)&((__skb)->cb[0]))
+
+static inline u32 quic_inq_max_idle_timeout(struct quic_inqueue *inq)
+{
+	return inq->max_idle_timeout;
+}
+
+static inline u32 quic_inq_max_ack_delay(struct quic_inqueue *inq)
+{
+	return inq->max_ack_delay;
+}
+
+static inline u32 quic_inq_max_dgram(struct quic_inqueue *inq)
+{
+	return inq->max_datagram_frame_size;
+}
+
+static inline u32 quic_inq_window(struct quic_inqueue *inq)
+{
+	return inq->window;
+}
+
+static inline u64 quic_inq_bytes(struct quic_inqueue *inq)
+{
+	return inq->bytes;
+}
+
+static inline u64 quic_inq_max_bytes(struct quic_inqueue *inq)
+{
+	return inq->max_bytes;
+}
+
+static inline void quic_inq_set_max_bytes(struct quic_inqueue *inq, u64 bytes)
+{
+	inq->max_bytes = bytes;
+}
+
+static inline u32 quic_inq_probe_timeout(struct quic_inqueue *inq)
+{
+	return inq->probe_timeout;
+}
+
+static inline u8 quic_inq_grease_quic_bit(struct quic_inqueue *inq)
+{
+	return inq->grease_quic_bit;
+}
+
+static inline struct sk_buff *quic_inq_last_event(struct quic_inqueue *inq)
+{
+	return inq->last_event;
+}
+
+static inline void quic_inq_set_last_event(struct quic_inqueue *inq, struct sk_buff *skb)
+{
+	inq->last_event = skb;
+}
+
+static inline u32 quic_inq_events(struct quic_inqueue *inq)
+{
+	return inq->events;
+}
+
+static inline void quic_inq_set_events(struct quic_inqueue *inq, u32 events)
+{
+	inq->events = events;
+}
+
+static inline u32 quic_inq_version(struct quic_inqueue *inq)
+{
+	return inq->version;
+}
+
+static inline void quic_inq_set_version(struct quic_inqueue *inq, u32 version)
+{
+	inq->version = version;
+}
+
+static inline u8 quic_inq_receive_session_ticket(struct quic_inqueue *inq)
+{
+	return inq->receive_session_ticket;
+}
+
+static inline void quic_inq_set_receive_session_ticket(struct quic_inqueue *inq, u8 rcv)
+{
+	inq->receive_session_ticket = rcv;
+}
+
+static inline u8 quic_inq_validate_peer_address(struct quic_inqueue *inq)
+{
+	return inq->validate_peer_address;
+}
+
+static inline struct sk_buff_head *quic_inq_backlog_list(struct quic_inqueue *inq)
+{
+	return &inq->backlog_list;
+}
+
+static inline u8 quic_inq_disable_1rtt_encryption(struct quic_inqueue *inq)
+{
+	return inq->disable_1rtt_encryption;
+}
+
+int quic_do_rcv(struct sock *sk, struct sk_buff *skb);
+int quic_rcv(struct sk_buff *skb);
+int quic_rcv_err(struct sk_buff *skb);
+void quic_rcv_err_icmp(struct sock *sk);
+int quic_inq_reasm_tail(struct sock *sk, struct sk_buff *skb);
+int quic_inq_dgram_tail(struct sock *sk, struct sk_buff *skb);
+int quic_inq_flow_control(struct sock *sk, struct quic_stream *stream, int len);
+void quic_inq_stream_purge(struct sock *sk, struct quic_stream *stream);
+void quic_inq_set_param(struct sock *sk, struct quic_transport_param *p);
+void quic_inq_set_owner_r(struct sk_buff *skb, struct sock *sk);
+int quic_inq_event_recv(struct sock *sk, u8 event, void *args);
+int quic_inq_handshake_tail(struct sock *sk, struct sk_buff *skb);
+void quic_inq_init(struct sock *sk);
+void quic_inq_free(struct sock *sk);
+void quic_inq_decrypted_tail(struct sock *sk, struct sk_buff *skb);
+void quic_inq_backlog_tail(struct sock *sk, struct sk_buff *skb);
diff --git a/net/quic/number.h b/net/quic/number.h
new file mode 100644
index 000000000000..4ceec7188b45
--- /dev/null
+++ b/net/quic/number.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+union quic_num {
+	u8	u8;
+	u16	u16;
+	u32	u32;
+	u64	u64;
+	u8	n[8];
+	__be16	be16;
+	__be32	be32;
+	__be64	be64;
+};
+
+static inline u32 quic_var_len(u64 n)
+{
+	if (n < 64)
+		return 1;
+	if (n < 16384)
+		return 2;
+	if (n < 1073741824)
+		return 4;
+	return 8;
+}
+
+static inline u8 quic_get_var(u8 **pp, u32 *plen, u64 *val)
+{
+	union quic_num n;
+	u8 *p = *pp, len;
+	u64 v = 0;
+
+	if (!*plen)
+		return 0;
+
+	len = (u8)(1u << (*p >> 6));
+	if (*plen < len)
+		return 0;
+
+	switch (len) {
+	case 1:
+		v = *p;
+		break;
+	case 2:
+		memcpy(&n.be16, p, 2);
+		n.n[0] &= 0x3f;
+		v = ntohs(n.be16);
+		break;
+	case 4:
+		memcpy(&n.be32, p, 4);
+		n.n[0] &= 0x3f;
+		v = ntohl(n.be32);
+		break;
+	case 8:
+		memcpy(&n.be64, p, 8);
+		n.n[0] &= 0x3f;
+		v = be64_to_cpu(n.be64);
+		break;
+	}
+
+	*plen -= len;
+	*pp = p + len;
+	*val = v;
+	return len;
+}
+
+static inline u32 quic_get_int(u8 **pp, u32 len)
+{
+	union quic_num n;
+	u8 *p = *pp;
+	u32 v = 0;
+
+	n.be32 = 0;
+	switch (len) {
+	case 1:
+		v = *p;
+		break;
+	case 2:
+		memcpy(&n.be16, p, 2);
+		v = ntohs(n.be16);
+		break;
+	case 3:
+		memcpy(((u8 *)&n.be32) + 1, p, 3);
+		v = ntohl(n.be32);
+		break;
+	case 4:
+		memcpy(&n.be32, p, 4);
+		v = ntohl(n.be32);
+		break;
+	}
+	*pp = p + len;
+	return v;
+}
+
+static inline u8 *quic_put_var(u8 *p, u64 num)
+{
+	union quic_num n;
+
+	n.u64 = num;
+	if (num < 64) {
+		*p++ = n.u8;
+		return p;
+	}
+	if (num < 16384) {
+		n.be16 = htons(n.u16);
+		memcpy(p, &n.be16, 2);
+		*p |= 0x40;
+		return p + 2;
+	}
+	if (num < 1073741824) {
+		n.be32 = htonl(n.u32);
+		memcpy(p, &n.be32, 4);
+		*p |= 0x80;
+		return p + 4;
+	}
+	n.be64 = cpu_to_be64(n.u64);
+	memcpy(p, &n.be64, 8);
+	*p |= 0xc0;
+	return p + 8;
+}
+
+static inline u8 *quic_put_int(u8 *p, u64 num, u8 len)
+{
+	union quic_num n;
+
+	n.u64 = num;
+
+	switch (len) {
+	case 1:
+		*p++ = n.u8;
+		return p;
+	case 2:
+		n.be16 = htons(n.u16);
+		memcpy(p, &n.be16, 2);
+		return p + 2;
+	case 4:
+		n.be32 = htonl(n.u32);
+		memcpy(p, &n.be32, 4);
+		return p + 4;
+	default:
+		return NULL;
+	}
+}
+
+static inline u8 *quic_put_data(u8 *p, u8 *data, u32 len)
+{
+	if (!len)
+		return p;
+
+	memcpy(p, data, len);
+	return p + len;
+}
+
+static inline s64 quic_get_num(s64 max_pkt_num, s64 pkt_num, u32 n)
+{
+	s64 expected = max_pkt_num + 1;
+	s64 win = (s64)1 << (n * 8);
+	s64 hwin = win / 2;
+	s64 mask = win - 1;
+	s64 cand;
+
+	cand = (expected & ~mask) | pkt_num;
+	if (cand <= expected - hwin)
+		return cand + win;
+	if (cand > expected + hwin && cand >= win)
+		return cand - win;
+	return cand;
+}
diff --git a/net/quic/output.c b/net/quic/output.c
new file mode 100644
index 000000000000..36f97428da15
--- /dev/null
+++ b/net/quic/output.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include "frame.h"
+
+#define QUIC_RTX_MAX	15
+
+static void quic_outq_transmit_ctrl(struct sock *sk)
+{
+	struct sk_buff_head *head = &quic_outq(sk)->control_list;
+	struct quic_snd_cb *snd_cb;
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(head);
+	if (!skb)
+		return;
+	snd_cb = QUIC_SND_CB(skb);
+	quic_packet_config(sk, snd_cb->level, snd_cb->path_alt);
+	while (skb) {
+		snd_cb = QUIC_SND_CB(skb);
+		if (!quic_packet_tail(sk, skb, 0)) {
+			quic_packet_build(sk);
+			quic_packet_config(sk, snd_cb->level, snd_cb->path_alt);
+			WARN_ON_ONCE(!quic_packet_tail(sk, skb, 0));
+		}
+		skb = __skb_dequeue(head);
+	}
+}
+
+static int quic_outq_transmit_dgram(struct sock *sk)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct sk_buff_head *head;
+	u8 level = outq->level;
+	struct sk_buff *skb;
+
+	head = &outq->datagram_list;
+	skb = __skb_dequeue(head);
+	if (!skb)
+		return 0;
+	quic_packet_config(sk, level, 0);
+	while (skb) {
+		if (outq->inflight + skb->len > outq->window) {
+			__skb_queue_head(head, skb);
+			return 1;
+		}
+		outq->inflight += QUIC_SND_CB(skb)->data_bytes;
+		if (!quic_packet_tail(sk, skb, 1)) {
+			quic_packet_build(sk);
+			quic_packet_config(sk, level, 0);
+			WARN_ON_ONCE(!quic_packet_tail(sk, skb, 1));
+		}
+		skb = __skb_dequeue(head);
+	}
+	return 0;
+}
+
+static int quic_outq_flow_control(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	u32 len = QUIC_SND_CB(skb)->data_bytes;
+	struct sk_buff *nskb = NULL;
+	struct quic_stream *stream;
+	u8 requeue = 0;
+
+	/* congestion control */
+	if (outq->inflight + len > outq->window)
+		requeue = 1;
+
+	/* send flow control */
+	stream = QUIC_SND_CB(skb)->stream;
+	if (stream->send.bytes + len > stream->send.max_bytes) {
+		if (!stream->send.data_blocked) {
+			nskb = quic_frame_create(sk, QUIC_FRAME_STREAM_DATA_BLOCKED, stream);
+			if (nskb)
+				quic_outq_ctrl_tail(sk, nskb, true);
+			stream->send.data_blocked = 1;
+		}
+		requeue = 1;
+	}
+	if (outq->bytes + len > outq->max_bytes) {
+		if (!outq->data_blocked) {
+			nskb = quic_frame_create(sk, QUIC_FRAME_DATA_BLOCKED, outq);
+			if (nskb)
+				quic_outq_ctrl_tail(sk, nskb, true);
+			outq->data_blocked = 1;
+		}
+		requeue = 1;
+	}
+
+	if (nskb)
+		quic_outq_transmit_ctrl(sk);
+
+	if (requeue) {
+		__skb_queue_head(&sk->sk_write_queue, skb);
+		return 1;
+	}
+
+	outq->bytes += len;
+	outq->inflight += len;
+	stream->send.frags++;
+	stream->send.bytes += len;
+	return 0;
+}
+
+static void quic_outq_transmit_data(struct sock *sk)
+{
+	struct sk_buff_head *head = &sk->sk_write_queue;
+	u8 level = quic_outq(sk)->level;
+	struct quic_crypto *crypto;
+	struct sk_buff *skb;
+
+	crypto = quic_crypto(sk, level);
+	if (!quic_crypto_send_ready(crypto))
+		return;
+
+	skb = __skb_dequeue(head);
+	if (!skb)
+		return;
+	quic_packet_config(sk, level, 0);
+	while (skb) {
+		if (!level && quic_outq_flow_control(sk, skb))
+			break;
+		if (!quic_packet_tail(sk, skb, 0)) {
+			quic_packet_build(sk);
+			quic_packet_config(sk, level, 0);
+			WARN_ON_ONCE(!quic_packet_tail(sk, skb, 0));
+		}
+		skb = __skb_dequeue(head);
+	}
+}
+
+void quic_outq_flush(struct sock *sk)
+{
+	quic_outq_transmit_ctrl(sk);
+
+	if (!quic_outq_transmit_dgram(sk))
+		quic_outq_transmit_data(sk);
+
+	if (!quic_packet_empty(quic_packet(sk)))
+		quic_packet_build(sk);
+
+	quic_packet_flush(sk);
+}
+
+static void quic_outq_wfree(struct sk_buff *skb)
+{
+	int len = QUIC_SND_CB(skb)->data_bytes;
+	struct sock *sk = skb->sk;
+
+	WARN_ON(refcount_sub_and_test(len, &sk->sk_wmem_alloc));
+	sk_wmem_queued_add(sk, -len);
+	sk_mem_uncharge(sk, len);
+
+	if (sk_stream_wspace(sk) > 0)
+		sk->sk_write_space(sk);
+}
+
+static void quic_outq_set_owner_w(struct sk_buff *skb, struct sock *sk)
+{
+	int len = QUIC_SND_CB(skb)->data_bytes;
+
+	refcount_add(len, &sk->sk_wmem_alloc);
+	sk_wmem_queued_add(sk, len);
+	sk_mem_charge(sk, len);
+
+	skb->sk = sk;
+	skb->destructor = quic_outq_wfree;
+}
+
+void quic_outq_data_tail(struct sock *sk, struct sk_buff *skb, bool cork)
+{
+	struct quic_stream *stream = QUIC_SND_CB(skb)->stream;
+	struct quic_stream_table *streams = quic_streams(sk);
+
+	if (stream->send.state == QUIC_STREAM_SEND_STATE_READY)
+		stream->send.state = QUIC_STREAM_SEND_STATE_SEND;
+
+	if (QUIC_SND_CB(skb)->frame_type & QUIC_STREAM_BIT_FIN &&
+	    stream->send.state == QUIC_STREAM_SEND_STATE_SEND) {
+		if (quic_stream_send_active(streams) == stream->id)
+			quic_stream_set_send_active(streams, -1);
+		stream->send.state = QUIC_STREAM_SEND_STATE_SENT;
+	}
+
+	quic_outq_set_owner_w(skb, sk);
+	__skb_queue_tail(&sk->sk_write_queue, skb);
+	if (!cork)
+		quic_outq_flush(sk);
+}
+
+void quic_outq_dgram_tail(struct sock *sk, struct sk_buff *skb, bool cork)
+{
+	quic_outq_set_owner_w(skb, sk);
+	__skb_queue_tail(&quic_outq(sk)->datagram_list, skb);
+	if (!cork)
+		quic_outq_flush(sk);
+}
+
+void quic_outq_ctrl_tail(struct sock *sk, struct sk_buff *skb, bool cork)
+{
+	struct sk_buff_head *head = &quic_outq(sk)->control_list;
+	struct sk_buff *pos;
+
+	if (QUIC_SND_CB(skb)->level) { /* prioritize handshake frames */
+		skb_queue_walk(head, pos) {
+			if (!QUIC_SND_CB(pos)->level) {
+				__skb_queue_before(head, pos, skb);
+				goto out;
+			}
+		}
+	}
+	__skb_queue_tail(head, skb);
+out:
+	if (!cork)
+		quic_outq_flush(sk);
+}
+
+void quic_outq_rtx_tail(struct sock *sk, struct sk_buff *skb)
+{
+	struct sk_buff_head *head = &quic_outq(sk)->retransmit_list;
+	struct sk_buff *pos;
+
+	if (QUIC_SND_CB(skb)->level) { /* prioritize handshake frames */
+		skb_queue_walk(head, pos) {
+			if (!QUIC_SND_CB(pos)->level) {
+				__skb_queue_before(head, pos, skb);
+				return;
+			}
+		}
+	}
+	__skb_queue_tail(head, skb);
+}
+
+void quic_outq_transmit_probe(struct sock *sk)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)quic_dst(sk);
+	struct quic_pnmap *pnmap = quic_pnmap(sk, QUIC_CRYPTO_APP);
+	u8 taglen = quic_packet_taglen(quic_packet(sk));
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff *skb;
+	u32 pathmtu;
+	s64 number;
+
+	if (!quic_is_established(sk))
+		return;
+
+	skb = quic_frame_create(sk, QUIC_FRAME_PING, &d->pl.probe_size);
+	if (skb) {
+		number = quic_pnmap_next_number(pnmap);
+		quic_outq_ctrl_tail(sk, skb, false);
+
+		pathmtu = quic_path_pl_send(quic_dst(sk), number);
+		if (pathmtu)
+			quic_packet_mss_update(sk, pathmtu + taglen);
+	}
+
+	quic_timer_setup(sk, QUIC_TIMER_PROBE, quic_inq_probe_timeout(inq));
+	quic_timer_reset(sk, QUIC_TIMER_PROBE);
+}
+
+void quic_outq_transmit_close(struct sock *sk, u8 frame, u32 errcode, u8 level)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_close close = {};
+	struct sk_buff *skb;
+
+	if (!errcode)
+		return;
+
+	close.errcode = errcode;
+	close.frame = frame;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_CLOSE, &close))
+		return;
+
+	quic_outq_set_close_errcode(outq, errcode);
+	quic_outq_set_close_frame(outq, frame);
+
+	skb = quic_frame_create(sk, QUIC_FRAME_CONNECTION_CLOSE, NULL);
+	if (skb) {
+		QUIC_SND_CB(skb)->level = level;
+		quic_outq_ctrl_tail(sk, skb, false);
+	}
+	quic_set_state(sk, QUIC_SS_CLOSED);
+}
+
+void quic_outq_transmit_app_close(struct sock *sk)
+{
+	u32 errcode = QUIC_TRANSPORT_ERROR_APPLICATION;
+	u8 type = QUIC_FRAME_CONNECTION_CLOSE, level;
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct sk_buff *skb;
+
+	if (quic_is_established(sk)) {
+		level = QUIC_CRYPTO_APP;
+		type = QUIC_FRAME_CONNECTION_CLOSE_APP;
+	} else if (quic_is_establishing(sk)) {
+		level = QUIC_CRYPTO_INITIAL;
+		quic_outq_set_close_errcode(outq, errcode);
+	} else {
+		return;
+	}
+
+	/* send close frame only when it's NOT idle timeout or closed by peer */
+	skb = quic_frame_create(sk, type, NULL);
+	if (skb) {
+		QUIC_SND_CB(skb)->level = level;
+		quic_outq_ctrl_tail(sk, skb, false);
+	}
+}
+
+void quic_outq_retransmit_check(struct sock *sk, u8 level, s64 largest, s64 smallest,
+				s64 ack_largest, u32 ack_delay)
+{
+	u32 pathmtu, acked_bytes = 0, transmit_ts = 0, rto, taglen;
+	struct quic_path_addr *path = quic_dst(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_cong *cong = quic_cong(sk);
+	struct sk_buff *skb, *tmp, *first;
+	struct quic_stream_update update;
+	struct quic_stream *stream;
+	struct quic_snd_cb *snd_cb;
+	bool raise_timer, complete;
+	struct sk_buff_head *head;
+	s64 acked_number = 0;
+
+	pr_debug("[QUIC] %s largest: %llu, smallest: %llu\n", __func__, largest, smallest);
+	if (quic_path_pl_confirm(path, largest, smallest)) {
+		pathmtu = quic_path_pl_recv(path, &raise_timer, &complete);
+		if (pathmtu) {
+			taglen = quic_packet_taglen(quic_packet(sk));
+			quic_packet_mss_update(sk, pathmtu + taglen);
+		}
+		if (!complete)
+			quic_outq_transmit_probe(sk);
+		if (raise_timer) { /* reuse probe timer as raise timer */
+			quic_timer_setup(sk, QUIC_TIMER_PROBE, quic_inq_probe_timeout(inq) * 30);
+			quic_timer_reset(sk, QUIC_TIMER_PROBE);
+		}
+	}
+
+	head = &outq->retransmit_list;
+	first = skb_peek(head);
+	skb_queue_reverse_walk_safe(head, skb, tmp) {
+		snd_cb = QUIC_SND_CB(skb);
+		if (level != snd_cb->level)
+			continue;
+		if (snd_cb->packet_number > largest)
+			continue;
+		if (snd_cb->packet_number < smallest)
+			break;
+		if (!snd_cb->rtx_count && snd_cb->packet_number == ack_largest) {
+			quic_cong_rtt_update(cong, snd_cb->transmit_ts, ack_delay);
+			rto = quic_cong_rto(cong);
+			quic_pnmap_set_max_record_ts(quic_pnmap(sk, QUIC_CRYPTO_APP), rto * 2);
+			quic_crypto_set_key_update_ts(quic_crypto(sk, QUIC_CRYPTO_APP), rto * 2);
+			quic_timer_setup(sk, QUIC_TIMER_RTX, rto);
+			quic_timer_setup(sk, QUIC_TIMER_PATH, rto * 3);
+		}
+		if (!acked_number) {
+			acked_number = snd_cb->packet_number;
+			transmit_ts = snd_cb->transmit_ts;
+		}
+
+		if (snd_cb->ecn)
+			quic_set_sk_ecn(sk, INET_ECN_ECT_0);
+
+		stream = snd_cb->stream;
+		if (snd_cb->data_bytes) {
+			outq->inflight -= snd_cb->data_bytes;
+			acked_bytes += snd_cb->data_bytes;
+			if (!stream)
+				goto unlink;
+			stream->send.frags--;
+			if (stream->send.frags || stream->send.state != QUIC_STREAM_SEND_STATE_SENT)
+				goto unlink;
+			update.id = stream->id;
+			update.state = QUIC_STREAM_SEND_STATE_RECVD;
+			if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update)) {
+				stream->send.frags++;
+				outq->inflight += snd_cb->data_bytes;
+				acked_bytes -= snd_cb->data_bytes;
+				continue;
+			}
+			stream->send.state = update.state;
+		} else if (snd_cb->frame_type == QUIC_FRAME_RESET_STREAM) {
+			update.id = stream->id;
+			update.state = QUIC_STREAM_SEND_STATE_RESET_RECVD;
+			update.errcode = stream->send.errcode;
+			if (quic_inq_event_recv(sk, QUIC_EVENT_STREAM_UPDATE, &update))
+				continue;
+			stream->send.state = update.state;
+		} else if (snd_cb->frame_type == QUIC_FRAME_STREAM_DATA_BLOCKED) {
+			stream->send.data_blocked = 0;
+		} else if (snd_cb->frame_type == QUIC_FRAME_DATA_BLOCKED) {
+			outq->data_blocked = 0;
+		}
+unlink:
+		if (outq->retransmit_skb == skb)
+			outq->retransmit_skb = NULL;
+		__skb_unlink(skb, head);
+		kfree_skb(skb);
+	}
+
+	if (skb_queue_empty(head))
+		quic_timer_stop(sk, QUIC_TIMER_RTX);
+	else if (first && first != skb_peek(head))
+		quic_timer_reset(sk, QUIC_TIMER_RTX);
+
+	if (!acked_bytes)
+		return;
+	quic_cong_cwnd_update_after_sack(cong, acked_number, transmit_ts,
+					 acked_bytes, outq->inflight);
+	quic_outq_set_window(outq, quic_cong_window(cong));
+}
+
+void quic_outq_retransmit(struct sock *sk)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_cong *cong = quic_cong(sk);
+	struct quic_snd_cb *snd_cb;
+	struct sk_buff_head *head;
+	struct sk_buff *skb;
+	s64 number, last;
+	u32 transmit_ts;
+
+	head = &outq->retransmit_list;
+	if (outq->rtx_count >= QUIC_RTX_MAX) {
+		pr_warn("[QUIC] %s timeout!\n", __func__);
+		sk->sk_err = -ETIMEDOUT;
+		quic_set_state(sk, QUIC_SS_CLOSED);
+		return;
+	}
+	last = quic_pnmap_next_number(quic_pnmap(sk, QUIC_CRYPTO_APP)) - 1;
+
+next:
+	skb = outq->retransmit_skb ?: skb_peek(head);
+	if (!skb)
+		return quic_outq_flush(sk);
+	__skb_unlink(skb, head);
+
+	snd_cb = QUIC_SND_CB(skb);
+	transmit_ts = snd_cb->transmit_ts;
+	number = snd_cb->packet_number;
+	if (quic_frame_is_dgram(snd_cb->frame_type)) { /* no need to retransmit dgram frame */
+		outq->inflight -= snd_cb->data_bytes;
+		kfree_skb(skb);
+		quic_cong_cwnd_update_after_timeout(cong, number, transmit_ts, last);
+		quic_outq_set_window(outq, quic_cong_window(cong));
+		goto next;
+	}
+
+	quic_packet_config(sk, (snd_cb->level ?: outq->level), snd_cb->path_alt);
+	quic_packet_tail(sk, skb, 0);
+	quic_packet_build(sk);
+	quic_packet_flush(sk);
+
+	outq->retransmit_skb = skb;
+	outq->rtx_count++;
+
+	snd_cb->rtx_count++;
+	if (snd_cb->rtx_count >= QUIC_RTX_MAX)
+		pr_warn("[QUIC] %s packet %llu timeout\n", __func__, number);
+	quic_timer_start(sk, QUIC_TIMER_RTX);
+	if (snd_cb->data_bytes) {
+		quic_cong_cwnd_update_after_timeout(cong, number, transmit_ts, last);
+		quic_outq_set_window(outq, quic_cong_window(cong));
+	}
+}
+
+void quic_outq_stream_purge(struct sock *sk, struct quic_stream *stream)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct sk_buff *skb, *tmp;
+	struct sk_buff_head *head;
+
+	head = &outq->retransmit_list;
+	skb_queue_walk_safe(head, skb, tmp) {
+		if (QUIC_SND_CB(skb)->stream != stream)
+			continue;
+		if (outq->retransmit_skb == skb)
+			outq->retransmit_skb = NULL;
+		__skb_unlink(skb, head);
+		kfree_skb(skb);
+	}
+
+	head = &sk->sk_write_queue;
+	skb_queue_walk_safe(head, skb, tmp) {
+		if (QUIC_SND_CB(skb)->stream != stream)
+			continue;
+		__skb_unlink(skb, head);
+		kfree_skb(skb);
+	}
+}
+
+void quic_outq_validate_path(struct sock *sk, struct sk_buff *skb, struct quic_path_addr *path)
+{
+	u8 local = quic_path_udp_bind(path), path_alt = QUIC_PATH_ALT_DST;
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct sk_buff_head *head;
+	struct sk_buff *fskb;
+
+	if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_MIGRATION, &local))
+		return;
+
+	if (local) {
+		quic_path_swap_active(path);
+		path_alt = QUIC_PATH_ALT_SRC;
+	}
+	quic_path_addr_free(sk, path, 1);
+	quic_set_sk_addr(sk, quic_path_addr(path, 0), local);
+	quic_path_set_sent_cnt(path, 0);
+	quic_timer_stop(sk, QUIC_TIMER_PATH);
+
+	head = &outq->control_list;
+	skb_queue_walk(head, fskb)
+		QUIC_SND_CB(fskb)->path_alt &= ~path_alt;
+
+	head = &outq->retransmit_list;
+	skb_queue_walk(head, fskb)
+		QUIC_SND_CB(fskb)->path_alt &= ~path_alt;
+
+	QUIC_RCV_CB(skb)->path_alt &= ~path_alt;
+	quic_packet_set_ecn_probes(quic_packet(sk), 0);
+}
+
+void quic_outq_set_param(struct sock *sk, struct quic_transport_param *p)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	u32 remote_ito, min_ito = 0, local_ito;
+	u8 local_crypto;
+
+	outq->max_datagram_frame_size = p->max_datagram_frame_size;
+	outq->max_udp_payload_size = p->max_udp_payload_size;
+	outq->ack_delay_exponent = p->ack_delay_exponent;
+	outq->max_idle_timeout = p->max_idle_timeout;
+	outq->max_ack_delay = p->max_ack_delay;
+	outq->grease_quic_bit = p->grease_quic_bit;
+	outq->disable_1rtt_encryption = p->disable_1rtt_encryption;
+	quic_timer_setup(sk, QUIC_TIMER_ACK, outq->max_ack_delay);
+
+	outq->max_bytes = p->max_data;
+	if (sk->sk_sndbuf > 2 * p->max_data)
+		sk->sk_sndbuf = 2 * p->max_data;
+
+	/* If neither the local endpoint nor the remote endpoint specified a
+	 * max_idle_timeout, we don't set one. Effectively, this means that
+	 * there is no idle timer.
+	 */
+	local_ito = quic_inq_max_idle_timeout(inq);
+	remote_ito = outq->max_idle_timeout;
+	if (local_ito && !remote_ito)
+		min_ito = local_ito;
+	else if (!local_ito && remote_ito)
+		min_ito = remote_ito;
+	else if (local_ito && remote_ito)
+		min_ito = min(local_ito, remote_ito);
+
+	local_crypto = quic_inq_disable_1rtt_encryption(inq);
+	if (local_crypto && outq->disable_1rtt_encryption)
+		quic_packet_set_taglen(quic_packet(sk), 0);
+
+	quic_timer_setup(sk, QUIC_TIMER_IDLE, min_ito);
+}
+
+static void quic_outq_encrypted_work(struct work_struct *work)
+{
+	struct quic_sock *qs = container_of(work, struct quic_sock, outq.work);
+	struct sock *sk = &qs->inet.sk;
+	struct sk_buff_head *head;
+	struct sk_buff *skb;
+
+	lock_sock(sk);
+	head = &quic_outq(sk)->encrypted_list;
+	if (sock_flag(sk, SOCK_DEAD)) {
+		skb_queue_purge(head);
+		goto out;
+	}
+
+	skb = skb_dequeue(head);
+	while (skb) {
+		struct quic_snd_cb *snd_cb = QUIC_SND_CB(skb);
+
+		quic_packet_config(sk, snd_cb->level, snd_cb->path_alt);
+		/* the skb here is ready to send */
+		quic_packet_xmit(sk, skb, 1);
+		skb = skb_dequeue(head);
+	}
+	quic_packet_flush(sk);
+out:
+	release_sock(sk);
+	sock_put(sk);
+}
+
+void quic_outq_init(struct sock *sk)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+
+	skb_queue_head_init(&outq->control_list);
+	skb_queue_head_init(&outq->datagram_list);
+	skb_queue_head_init(&outq->encrypted_list);
+	skb_queue_head_init(&outq->retransmit_list);
+	INIT_WORK(&outq->work, quic_outq_encrypted_work);
+}
+
+void quic_outq_free(struct sock *sk)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+
+	__skb_queue_purge(&sk->sk_write_queue);
+	__skb_queue_purge(&outq->retransmit_list);
+	__skb_queue_purge(&outq->datagram_list);
+	__skb_queue_purge(&outq->control_list);
+	kfree(outq->close_phrase);
+}
+
+void quic_outq_encrypted_tail(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+
+	sock_hold(sk);
+	skb_queue_tail(&outq->encrypted_list, skb);
+
+	if (!schedule_work(&outq->work))
+		sock_put(sk);
+}
diff --git a/net/quic/output.h b/net/quic/output.h
new file mode 100644
index 000000000000..495685162b25
--- /dev/null
+++ b/net/quic/output.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+struct quic_outqueue {
+	struct quic_connection_id retry_dcid;
+	struct quic_connection_id orig_dcid;
+	struct sk_buff_head retransmit_list;
+	struct sk_buff_head encrypted_list;
+	struct sk_buff_head datagram_list;
+	struct sk_buff_head control_list;
+	struct sk_buff *retransmit_skb;
+	struct work_struct work;
+	u64 max_bytes;
+	u64 inflight;
+	u64 window;
+	u64 bytes;
+
+	u32 max_datagram_frame_size;
+	u32 max_udp_payload_size;
+	u32 ack_delay_exponent;
+	u32 max_idle_timeout;
+	u32 max_ack_delay;
+	u8 grease_quic_bit:1;
+	u8 disable_1rtt_encryption:1;
+	/* Use for 0-RTT/1-RTT DATA (re)transmit,
+	 * as QUIC_SND_CB(skb)->level is always QUIC_CRYPTO_APP.
+	 * Set this level to QUIC_CRYPTO_EARLY or QUIC_CRYPTO_APP
+	 * when the corresponding crypto is ready for send.
+	 */
+	u8 level;
+
+	u32 close_errcode;
+	u8 *close_phrase;
+	u8 close_frame;
+	u8 rtx_count;
+	u8 data_blocked:1;
+	u8 serv:1;
+	u8 retry:1;
+};
+
+struct quic_snd_cb {
+	struct quic_stream *stream;
+	struct sk_buff *last;
+	s64 packet_number;
+	u32 transmit_ts;
+	u16 data_bytes;
+	u8 number_offset;
+	u8 level;
+	u8 rtx_count;
+	u8 frame_type;
+	u8 path_alt:2; /* bit 1: src, bit 2: dst */
+	u8 padding:1;
+	u8 ecn:2;
+};
+
+#define QUIC_SND_CB(__skb)      ((struct quic_snd_cb *)&((__skb)->cb[0]))
+
+static inline void quic_outq_reset(struct quic_outqueue *outq)
+{
+	outq->rtx_count = 0;
+}
+
+static inline void quic_outq_set_window(struct quic_outqueue *outq, u32 window)
+{
+	outq->window = window;
+}
+
+static inline u32 quic_outq_ack_delay_exponent(struct quic_outqueue *outq)
+{
+	return outq->ack_delay_exponent;
+}
+
+static inline u32 quic_outq_max_udp(struct quic_outqueue *outq)
+{
+	return outq->max_udp_payload_size;
+}
+
+static inline u64 quic_outq_max_bytes(struct quic_outqueue *outq)
+{
+	return outq->max_bytes;
+}
+
+static inline void quic_outq_set_max_bytes(struct quic_outqueue *outq, u64 bytes)
+{
+	outq->max_bytes = bytes;
+}
+
+static inline u32 quic_outq_close_errcode(struct quic_outqueue *outq)
+{
+	return outq->close_errcode;
+}
+
+static inline void quic_outq_set_close_errcode(struct quic_outqueue *outq, u32 errcode)
+{
+	outq->close_errcode = errcode;
+}
+
+static inline u8 quic_outq_close_frame(struct quic_outqueue *outq)
+{
+	return outq->close_frame;
+}
+
+static inline void quic_outq_set_close_frame(struct quic_outqueue *outq, u8 type)
+{
+	outq->close_frame = type;
+}
+
+static inline u8 *quic_outq_close_phrase(struct quic_outqueue *outq)
+{
+	return outq->close_phrase;
+}
+
+static inline void quic_outq_set_close_phrase(struct quic_outqueue *outq, u8 *phrase)
+{
+	outq->close_phrase = phrase;
+}
+
+static inline u8 quic_outq_retry(struct quic_outqueue *outq)
+{
+	return outq->retry;
+}
+
+static inline void quic_outq_set_retry(struct quic_outqueue *outq, u8 retry)
+{
+	outq->retry = retry;
+}
+
+static inline u32 quic_outq_max_dgram(struct quic_outqueue *outq)
+{
+	return outq->max_datagram_frame_size;
+}
+
+static inline u8 quic_outq_grease_quic_bit(struct quic_outqueue *outq)
+{
+	return outq->grease_quic_bit;
+}
+
+static inline struct quic_connection_id *quic_outq_orig_dcid(struct quic_outqueue *outq)
+{
+	return &outq->orig_dcid;
+}
+
+static inline void quic_outq_set_orig_dcid(struct quic_outqueue *outq,
+					   struct quic_connection_id *dcid)
+{
+	outq->orig_dcid = *dcid;
+}
+
+static inline struct quic_connection_id *quic_outq_retry_dcid(struct quic_outqueue *outq)
+{
+	return &outq->retry_dcid;
+}
+
+static inline void quic_outq_set_retry_dcid(struct quic_outqueue *outq,
+					    struct quic_connection_id *dcid)
+{
+	outq->retry_dcid = *dcid;
+}
+
+static inline void quic_outq_set_serv(struct quic_outqueue *outq)
+{
+	outq->serv = 1;
+}
+
+static inline void quic_outq_set_level(struct quic_outqueue *outq, u8 level)
+{
+	outq->level = level;
+}
+
+void quic_outq_dgram_tail(struct sock *sk, struct sk_buff *skb, bool cork);
+void quic_outq_data_tail(struct sock *sk, struct sk_buff *skb, bool cork);
+void quic_outq_ctrl_tail(struct sock *sk, struct sk_buff *skb, bool cork);
+void quic_outq_rtx_tail(struct sock *sk, struct sk_buff *skb);
+void quic_outq_flush(struct sock *sk);
+void quic_outq_retransmit(struct sock *sk);
+void quic_outq_retransmit_check(struct sock *sk, u8 level, s64 largest,
+				s64 smallest, s64 ack_largest, u32 ack_delay);
+void quic_outq_validate_path(struct sock *sk, struct sk_buff *skb,
+			     struct quic_path_addr *path);
+void quic_outq_stream_purge(struct sock *sk, struct quic_stream *stream);
+void quic_outq_set_param(struct sock *sk, struct quic_transport_param *p);
+void quic_outq_transmit_close(struct sock *sk, u8 frame, u32 errcode, u8 level);
+void quic_outq_transmit_app_close(struct sock *sk);
+void quic_outq_transmit_probe(struct sock *sk);
+void quic_outq_init(struct sock *sk);
+void quic_outq_free(struct sock *sk);
+void quic_outq_encrypted_tail(struct sock *sk, struct sk_buff *skb);
diff --git a/net/quic/packet.c b/net/quic/packet.c
new file mode 100644
index 000000000000..a74cf07ed6a4
--- /dev/null
+++ b/net/quic/packet.c
@@ -0,0 +1,1179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <net/gro.h>
+#include "socket.h"
+#include "number.h"
+#include "frame.h"
+#include <linux/version.h>
+
+static int quic_packet_stateless_reset_process(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_connection_close close = {};
+	u8 *token;
+
+	if (skb->len < 22)
+		return -EINVAL;
+
+	token = skb->data + skb->len - 16;
+	if (!quic_connection_id_token_exists(id_set, token))
+		return -EINVAL; /* not a stateless reset and the caller will free skb */
+
+	close.errcode = QUIC_TRANSPORT_ERROR_CRYPTO;
+	if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_CLOSE, &close))
+		return -ENOMEM;
+	quic_set_state(sk, QUIC_SS_CLOSED);
+	consume_skb(skb);
+	pr_debug("%s: peer reset\n", __func__);
+	return 0;
+}
+
+static int quic_packet_handshake_retry_process(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_connection_id dcid, scid = {}, *active;
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	u32 len = skb->len, dlen, slen, version;
+	u8 *p = skb->data, tag[16];
+
+	p++;
+	len--;
+	p += 4;
+	len -= 4;
+	/* DCID */
+	if (len-- < 1)
+		goto err;
+	dlen = quic_get_int(&p, 1);
+	if (len < dlen || dlen > 20)
+		goto err;
+	dcid.len = dlen;
+	memcpy(dcid.data, p, dlen);
+	len -= dlen;
+	p += dlen;
+	/* SCID */
+	if (len-- < 1)
+		goto err;
+	slen = quic_get_int(&p, 1);
+	if (len < slen || slen > 20)
+		goto err;
+	scid.len = slen;
+	memcpy(scid.data, p, slen);
+	len -= slen;
+	p += slen;
+	if (len < 16)
+		goto err;
+	version = quic_inq_version(inq);
+	if (quic_crypto_get_retry_tag(crypto, skb, quic_outq_orig_dcid(outq), version, tag) ||
+	    memcmp(tag, p + len - 16, 16))
+		goto err;
+	if (quic_data_dup(quic_token(sk), p, len - 16))
+		goto err;
+
+	quic_crypto_destroy(crypto);
+	if (quic_crypto_initial_keys_install(crypto, &scid, version, 0, 0))
+		goto err;
+	active = quic_connection_id_active(id_set);
+	quic_connection_id_update(active, scid.data, scid.len);
+	quic_outq_set_retry(outq, 1);
+	quic_outq_set_retry_dcid(outq, active);
+	quic_outq_retransmit(sk);
+
+	consume_skb(skb);
+	return 0;
+err:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int quic_packet_handshake_version_process(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_connection_id dcid, scid;
+	u32 len = skb->len, dlen, slen;
+	u32 version, best = 0;
+	u8 *p = skb->data;
+
+	p++;
+	len--;
+	p += 4;
+	len -= 4;
+	/* DCID */
+	if (len-- < 1)
+		goto err;
+	dlen = quic_get_int(&p, 1);
+	if (len < dlen || dlen > 20)
+		goto err;
+	dcid.len = dlen;
+	memcpy(dcid.data, p, dlen);
+	len -= dlen;
+	p += dlen;
+	/* SCID */
+	if (len-- < 1)
+		goto err;
+	slen = quic_get_int(&p, 1);
+	if (len < slen || slen > 20)
+		goto err;
+	scid.len = slen;
+	memcpy(scid.data, p, slen);
+	len -= slen;
+	p += slen;
+	if (len < 4)
+		goto err;
+
+	while (len >= 4) {
+		version = quic_get_int(&p, 4);
+		len -= 4;
+		if (quic_compatible_versions(version) && best < version)
+			best = version;
+	}
+	if (best) {
+		quic_inq_set_version(inq, best);
+		quic_crypto_destroy(crypto);
+		if (quic_crypto_initial_keys_install(crypto, &scid, best, 0, 0))
+			goto err;
+		quic_outq_retransmit(sk);
+	}
+
+	consume_skb(skb);
+	return 0;
+err:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static void quic_packet_decrypt_done(void *data, int err)
+{
+	struct sk_buff *skb = data;
+
+	if (err) {
+		kfree_skb(skb);
+		pr_warn_once("%s: err %d\n", __func__, err);
+		return;
+	}
+
+	quic_inq_decrypted_tail(skb->sk, skb);
+}
+
+static int quic_packet_handshake_process(struct sock *sk, struct sk_buff *skb, u8 resume)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_connection_id *active;
+	struct quic_packet_info pki = {};
+	u8 *p, level = 0, *scid, type;
+	struct quic_crypto *crypto;
+	struct quichshdr *hshdr;
+	struct sk_buff *fskb;
+	u64 dlen, slen, tlen;
+	u32 version, len;
+	int err = -EINVAL;
+
+	while (skb->len > 0) {
+		hshdr = quic_hshdr(skb);
+		if (!hshdr->form) /* handle it later when setting 1RTT key */
+			return quic_packet_process(sk, skb, 0);
+		p = (u8 *)hshdr;
+		len = skb->len;
+		if (len < 5)
+			goto err;
+		/* VERSION */
+		p++;
+		len--;
+		version = quic_get_int(&p, 4);
+		if (!version)
+			return quic_packet_handshake_version_process(sk, skb);
+		else if (version != quic_inq_version(inq))
+			goto err;
+		len -= 4;
+		type = quic_version_get_type(version, hshdr->type);
+		switch (type) {
+		case QUIC_PACKET_INITIAL:
+			level = QUIC_CRYPTO_INITIAL;
+			break;
+		case QUIC_PACKET_HANDSHAKE:
+			level = QUIC_CRYPTO_HANDSHAKE;
+			crypto = quic_crypto(sk, level);
+			if (!quic_crypto_recv_ready(crypto)) {
+				quic_inq_backlog_tail(sk, skb);
+				return 0;
+			}
+			break;
+		case QUIC_PACKET_0RTT:
+			level = QUIC_CRYPTO_EARLY;
+			crypto = quic_crypto(sk, QUIC_CRYPTO_APP);
+			if (!quic_crypto_recv_ready(crypto)) {
+				quic_inq_backlog_tail(sk, skb);
+				return 0;
+			}
+			break;
+		case QUIC_PACKET_RETRY:
+			return quic_packet_handshake_retry_process(sk, skb);
+		default:
+			goto err;
+		}
+		/* DCID */
+		if (len-- < 1)
+			goto err;
+		dlen = quic_get_int(&p, 1);
+		if (len < dlen || dlen > 20)
+			goto err;
+		len -= dlen;
+		p += dlen;
+		/* SCID */
+		if (len-- < 1)
+			goto err;
+		slen = quic_get_int(&p, 1);
+		if (len < slen || slen > 20)
+			goto err;
+		len -= slen;
+		scid = p;
+		p += slen;
+		if (level == QUIC_CRYPTO_INITIAL) {
+			/* TOKEN */
+			if (!quic_get_var(&p, &len, &tlen) || len < tlen)
+				goto err;
+			if (!quic_is_serv(sk) && tlen) {
+				pki.errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+				goto err;
+			}
+			p += tlen;
+			len -= tlen;
+		}
+		/* LENGTH */
+		if (!quic_get_var(&p, &len, &pki.length) || pki.length > len)
+			goto err;
+		pki.number_offset = p - (u8 *)hshdr;
+		if (resume) {
+			p = (u8 *)hshdr + pki.number_offset;
+			pki.number_len = hshdr->pnl + 1;
+			pki.number = quic_get_int(&p, pki.number_len);
+			pki.number = quic_get_num(pki.number_max, pki.number, pki.number_len);
+			goto skip;
+		}
+		pki.crypto_done = quic_packet_decrypt_done;
+		pki.resume = resume;
+		err = quic_crypto_decrypt(quic_crypto(sk, level), skb, &pki);
+		if (err) {
+			if (err == -EINPROGRESS)
+				return err;
+			goto err;
+		}
+
+skip:
+		if (hshdr->reserved) {
+			pki.errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+			goto err;
+		}
+
+		pr_debug("[QUIC] %s serv: %d number: %llu level: %d len: %d\n", __func__,
+			 quic_is_serv(sk), pki.number, level, skb->len);
+
+		if (level == QUIC_CRYPTO_EARLY)
+			level = QUIC_CRYPTO_APP; /* pnmap level */
+		err = quic_pnmap_check(quic_pnmap(sk, level), pki.number);
+		if (err) {
+			err = -EINVAL;
+			goto err;
+		}
+
+		skb_pull(skb, pki.number_offset + pki.number_len);
+		pki.length -= pki.number_len;
+		pki.length -= packet->taglen[1];
+		QUIC_RCV_CB(skb)->level = level;
+		err = quic_frame_process(sk, skb, &pki);
+		if (err)
+			goto err;
+		err = quic_pnmap_mark(quic_pnmap(sk, level), pki.number);
+		if (err)
+			goto err;
+		skb_pull(skb, packet->taglen[1]);
+		if (pki.ack_eliciting) {
+			if (!quic_is_serv(sk) && level == QUIC_CRYPTO_INITIAL) {
+				active = quic_connection_id_active(id_set);
+				quic_connection_id_update(active, scid, slen);
+			}
+			fskb = quic_frame_create(sk, QUIC_FRAME_ACK, &level);
+			if (fskb) {
+				/* flush it out in ack timer in case that no handshake packets
+				 * from user space come to bundle it.
+				 */
+				quic_outq_ctrl_tail(sk, fskb, true);
+				quic_timer_start(sk, QUIC_TIMER_ACK);
+			}
+		}
+		resume = 0;
+		skb_reset_transport_header(skb);
+	}
+	consume_skb(skb);
+	quic_outq_reset(quic_outq(sk));
+	return 0;
+err:
+	pr_warn("[QUIC] %s serv: %d number: %llu level: %d err: %d\n", __func__,
+		quic_is_serv(sk), pki.number, level, err);
+	quic_outq_transmit_close(sk, pki.frame, pki.errcode, level);
+	kfree_skb(skb);
+	return err;
+}
+
+int quic_packet_process(struct sock *sk, struct sk_buff *skb, u8 resume)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_APP);
+	struct quic_pnmap *pnmap = quic_pnmap(sk, QUIC_CRYPTO_APP);
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	struct quic_rcv_cb *rcv_cb = QUIC_RCV_CB(skb);
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quichdr *hdr = quic_hdr(skb);
+	struct quic_packet_info pki = {};
+	u8 *p, key_phase, level = 0;
+	union quic_addr addr;
+	struct sk_buff *fskb;
+	int err = -EINVAL;
+
+	WARN_ON(!skb_set_owner_sk_safe(skb, sk));
+
+	if (hdr->form)
+		return quic_packet_handshake_process(sk, skb, resume);
+
+	if (!hdr->fixed && !quic_inq_grease_quic_bit(inq))
+		goto err;
+
+	if (!quic_crypto_recv_ready(crypto)) {
+		quic_inq_backlog_tail(sk, skb);
+		return 0;
+	}
+
+	pki.number_offset = quic_connection_id_active(id_set)->len + sizeof(*hdr);
+	if (rcv_cb->number_offset)
+		pki.number_offset = rcv_cb->number_offset;
+
+	pki.length = skb->len - pki.number_offset;
+	pki.number_max = quic_pnmap_max_pn_seen(pnmap);
+	if (resume || !packet->taglen[0]) {
+		p = (u8 *)hdr + pki.number_offset;
+		pki.number_len = hdr->pnl + 1;
+		pki.number = quic_get_int(&p, pki.number_len);
+		pki.number = quic_get_num(pki.number_max, pki.number, pki.number_len);
+		pki.key_phase = hdr->key;
+		goto skip;
+	}
+	pki.crypto_done = quic_packet_decrypt_done;
+	pki.resume = resume;
+	err = quic_crypto_decrypt(crypto, skb, &pki);
+	if (err) {
+		if (err == -EINPROGRESS)
+			return err;
+		if (!quic_packet_stateless_reset_process(sk, skb))
+			return 0;
+		goto err;
+	}
+
+skip:
+	if (hdr->reserved) {
+		pki.errcode = QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION;
+		goto err;
+	}
+
+	pr_debug("[QUIC] %s serv: %d number: %llu len: %d\n", __func__,
+		 quic_is_serv(sk), pki.number, skb->len);
+
+	err = quic_pnmap_check(pnmap, pki.number);
+	if (err) {
+		pki.errcode = QUIC_TRANSPORT_ERROR_INTERNAL;
+		err = -EINVAL;
+		goto err;
+	}
+
+	/* Set path_alt so that the replies will choose the correct path */
+	quic_get_msg_addr(sk, &addr, skb, 0);
+	if (!quic_path_cmp(quic_src(sk), 1, &addr))
+		rcv_cb->path_alt |= QUIC_PATH_ALT_SRC;
+
+	quic_get_msg_addr(sk, &addr, skb, 1);
+	if (quic_path_cmp(quic_dst(sk), 0, &addr)) {
+		quic_path_addr_set(quic_dst(sk), &addr, 1);
+		rcv_cb->path_alt |= QUIC_PATH_ALT_DST;
+	}
+
+	skb_pull(skb, pki.number_offset + pki.number_len);
+	pki.length -= pki.number_len;
+	pki.length -= packet->taglen[0];
+	rcv_cb->level = 0;
+	err = quic_frame_process(sk, skb, &pki);
+	if (err)
+		goto err;
+	err = quic_pnmap_mark(pnmap, pki.number);
+	if (err)
+		goto err;
+	skb_pull(skb, packet->taglen[0]);
+	quic_pnmap_increase_ecn_count(pnmap, quic_get_msg_ecn(sk, skb));
+
+	/* connection migration check: an endpoint only changes the address to which
+	 * it sends packets in response to the highest-numbered non-probing packet.
+	 */
+	id_set = quic_dest(sk);
+	if (!quic_connection_id_disable_active_migration(id_set) && pki.non_probing &&
+	    pki.number == quic_pnmap_max_pn_seen(pnmap) && (rcv_cb->path_alt & QUIC_PATH_ALT_DST))
+		quic_sock_change_daddr(sk, &addr, quic_addr_len(sk));
+
+	if (pki.key_update) {
+		key_phase = pki.key_phase;
+		if (!quic_inq_event_recv(sk, QUIC_EVENT_KEY_UPDATE, &key_phase)) {
+			quic_crypto_set_key_pending(crypto, 0);
+			quic_crypto_set_key_update_send_ts(crypto, 0);
+		}
+	}
+
+	if (!pki.ack_eliciting)
+		goto out;
+
+	if (!pki.ack_immediate && !quic_pnmap_has_gap(pnmap)) {
+		quic_timer_start(sk, QUIC_TIMER_ACK);
+		goto out;
+	}
+	fskb = quic_frame_create(sk, QUIC_FRAME_ACK, &level);
+	if (fskb) {
+		QUIC_SND_CB(fskb)->path_alt = rcv_cb->path_alt;
+		quic_outq_ctrl_tail(sk, fskb, true);
+		quic_timer_stop(sk, QUIC_TIMER_ACK);
+	}
+
+out:
+	consume_skb(skb);
+
+	/* Since a packet was successfully processed, we can reset the idle
+	 * timer.
+	 */
+	quic_timer_reset(sk, QUIC_TIMER_IDLE);
+	quic_outq_reset(quic_outq(sk));
+	if (quic_is_established(sk))
+		quic_outq_flush(sk);
+	return 0;
+err:
+	pr_warn("[QUIC] %s serv: %d number: %llu len: %d err: %d\n", __func__,
+		quic_is_serv(sk), pki.number, skb->len, err);
+	quic_outq_transmit_close(sk, pki.frame, pki.errcode, level);
+	kfree_skb(skb);
+	return err;
+}
+
+/* Initial Packet {
+ *   Header Form (1) = 1,
+ *   Fixed Bit (1) = 1,
+ *   Long Packet Type (2) = 0,
+ *   Reserved Bits (2),
+ *   Packet Number Length (2),
+ *   Version (32),
+ *   Destination Connection ID Length (8),
+ *   Destination Connection ID (0..160),
+ *   Source Connection ID Length (8),
+ *   Source Connection ID (0..160),
+ *   Token Length (i),
+ *   Token (..),
+ *   Length (i),
+ *   Packet Number (8..32),
+ *   Packet Payload (8..),
+ * }
+ *
+ * Handshake Packet {
+ *   Header Form (1) = 1,
+ *   Fixed Bit (1) = 1,
+ *   Long Packet Type (2) = 2,
+ *   Reserved Bits (2),
+ *   Packet Number Length (2),
+ *   Version (32),
+ *   Destination Connection ID Length (8),
+ *   Destination Connection ID (0..160),
+ *   Source Connection ID Length (8),
+ *   Source Connection ID (0..160),
+ *   Length (i),
+ *   Packet Number (8..32),
+ *   Packet Payload (8..),
+ * }
+ */
+
+static struct sk_buff *quic_packet_handshake_create(struct sock *sk)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_connection_id_set *id_set;
+	u8 *p, type, level = packet->level;
+	struct quic_connection_id *active;
+	int len, hlen, plen = 0, tlen = 0;
+	struct quic_snd_cb *snd_cb;
+	struct sk_buff *fskb, *skb;
+	struct sk_buff_head *head;
+	struct quic_pnmap *pnmap;
+	u32 number_len, version;
+	struct quichshdr *hdr;
+	s64 number;
+
+	type = QUIC_PACKET_INITIAL;
+	len = packet->len;
+	if (level == QUIC_CRYPTO_INITIAL && !quic_is_serv(sk) &&
+	    len - packet->overhead > 128 && len < 1184) {
+		len = 1184;
+		plen = len - packet->len;
+	}
+	hlen = quic_encap_len(sk) + MAX_HEADER;
+	skb = alloc_skb(hlen + len + packet->taglen[1], GFP_ATOMIC);
+	if (!skb) {
+		__skb_queue_purge(&packet->frame_list);
+		return NULL;
+	}
+	skb->ignore_df = packet->ipfragok;
+	skb_reserve(skb, hlen + len);
+
+	if (level == QUIC_CRYPTO_HANDSHAKE) {
+		type = QUIC_PACKET_HANDSHAKE;
+	} else if (level == QUIC_CRYPTO_EARLY) {
+		type = QUIC_PACKET_0RTT;
+		level = QUIC_CRYPTO_APP; /* pnmap level */
+	}
+	pnmap = quic_pnmap(sk, level);
+	number = quic_pnmap_increase_next_number(pnmap);
+	number_len = 4; /* make it fixed for easy coding */
+	version = quic_inq_version(inq);
+	hdr = skb_push(skb, len);
+	hdr->form = 1;
+	hdr->fixed = !quic_outq_grease_quic_bit(outq);
+	hdr->type = quic_version_put_type(version, type);
+	hdr->reserved = 0;
+	hdr->pnl = 0x3;
+	skb_reset_transport_header(skb);
+
+	p = (u8 *)hdr + 1;
+	p = quic_put_int(p, version, 4);
+
+	id_set = quic_dest(sk);
+	active = quic_connection_id_active(id_set);
+	p = quic_put_int(p, active->len, 1);
+	p = quic_put_data(p, active->data, active->len);
+
+	id_set = quic_source(sk);
+	active = quic_connection_id_active(id_set);
+	p = quic_put_int(p, active->len, 1);
+	p = quic_put_data(p, active->data, active->len);
+
+	if (level == QUIC_CRYPTO_INITIAL) {
+		if (!quic_is_serv(sk))
+			tlen = quic_token(sk)->len;
+		p = quic_put_var(p, tlen);
+		p = quic_put_data(p, quic_token(sk)->data, tlen);
+	}
+
+	snd_cb = QUIC_SND_CB(skb);
+	snd_cb->number_offset = p + 4 - skb->data;
+	snd_cb->packet_number = number;
+	snd_cb->level = packet->level;
+	snd_cb->path_alt = packet->path_alt;
+
+	p = quic_put_int(p, (len - snd_cb->number_offset) + 16, 4);
+	*(p - 4) |= 0x80;
+	p = quic_put_int(p, number, number_len);
+
+	head = &packet->frame_list;
+	fskb =  __skb_dequeue(head);
+	while (fskb) {
+		snd_cb = QUIC_SND_CB(fskb);
+		p = quic_put_data(p, fskb->data, fskb->len);
+		pr_debug("[QUIC] %s number: %llu type: %u packet_len: %u frame_len: %u level: %u\n",
+			 __func__, number, snd_cb->frame_type, skb->len, fskb->len,
+			 packet->level);
+		if (!quic_frame_retransmittable(snd_cb->frame_type)) {
+			consume_skb(fskb);
+			fskb =  __skb_dequeue(head);
+			continue;
+		}
+		quic_outq_rtx_tail(sk, fskb);
+		snd_cb->packet_number = number;
+		snd_cb->transmit_ts = jiffies_to_usecs(jiffies);
+		fskb =  __skb_dequeue(head);
+	}
+	if (plen)
+		memset(p, 0, plen);
+
+	quic_timer_stop(sk, QUIC_TIMER_ACK);
+	return skb;
+}
+
+static int quic_packet_number_check(struct sock *sk)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_pnmap *pnmap;
+
+	pnmap = quic_pnmap(sk, packet->level);
+	if (quic_pnmap_next_number(pnmap) + 1 <= QUIC_PN_MAP_MAX_PN)
+		return 0;
+
+	__skb_queue_purge(&packet->frame_list);
+	if (!quic_is_closed(sk)) {
+		struct quic_connection_close *close;
+		u8 frame[10] = {};
+
+		close = (void *)frame;
+		close->errcode = 0;
+		if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_CLOSE, close))
+			return -ENOMEM;
+		quic_set_state(sk, QUIC_SS_CLOSED);
+	}
+	return -EPIPE;
+}
+
+/* 0-RTT Packet {
+ *   Header Form (1) = 1,
+ *   Fixed Bit (1) = 1,
+ *   Long Packet Type (2) = 1,
+ *   Reserved Bits (2),
+ *   Packet Number Length (2),
+ *   Version (32),
+ *   Destination Connection ID Length (8),
+ *   Destination Connection ID (0..160),
+ *   Source Connection ID Length (8),
+ *   Source Connection ID (0..160),
+ *   Length (i),
+ *   Packet Number (8..32),
+ *   Packet Payload (8..),
+ * }
+ */
+
+static struct sk_buff *quic_packet_create(struct sock *sk)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_id *active;
+	struct quic_packet *packet;
+	struct sk_buff *fskb, *skb;
+	struct quic_snd_cb *snd_cb;
+	struct sk_buff_head *head;
+	struct quic_pnmap *pnmap;
+	struct quichdr *hdr;
+	u32 number_len;
+	u8 *p, ecn = 0;
+	int len, hlen;
+	s64 number;
+
+	packet = quic_packet(sk);
+	if (packet->level)
+		return quic_packet_handshake_create(sk);
+	pnmap = quic_pnmap(sk, packet->level);
+	number = quic_pnmap_increase_next_number(pnmap);
+	number_len = 4; /* make it fixed for easy coding */
+	len = packet->len;
+	hlen = quic_encap_len(sk) + MAX_HEADER;
+	skb = alloc_skb(hlen + len + packet->taglen[0], GFP_ATOMIC);
+	if (!skb) {
+		__skb_queue_purge(&packet->frame_list);
+		return NULL;
+	}
+	skb->ignore_df = packet->ipfragok;
+	skb_reserve(skb, hlen + len);
+
+	hdr = skb_push(skb, len);
+	hdr->form = 0;
+	hdr->fixed = !quic_outq_grease_quic_bit(outq);
+	hdr->spin = 0;
+	hdr->reserved = 0;
+	hdr->pnl = 0x3;
+	skb_reset_transport_header(skb);
+
+	p = (u8 *)hdr + 1;
+	active = quic_connection_id_active(id_set);
+	p = quic_put_data(p, active->data, active->len);
+
+	snd_cb = QUIC_SND_CB(skb);
+	snd_cb->number_offset = active->len + sizeof(struct quichdr);
+	snd_cb->packet_number = number;
+	snd_cb->level = packet->level;
+	snd_cb->path_alt = packet->path_alt;
+
+	p = quic_put_int(p, number, number_len);
+
+	head = &packet->frame_list;
+	fskb =  __skb_dequeue(head);
+	while (fskb) {
+		snd_cb = QUIC_SND_CB(fskb);
+		p = quic_put_data(p, fskb->data, fskb->len);
+		pr_debug("[QUIC] %s number: %llu type: %u packet_len: %u frame_len: %u\n", __func__,
+			 number, snd_cb->frame_type, skb->len, fskb->len);
+		if (!quic_frame_retransmittable(snd_cb->frame_type)) {
+			consume_skb(fskb);
+			fskb =  __skb_dequeue(head);
+			continue;
+		}
+		if (!ecn && packet->ecn_probes < 3) {
+			packet->ecn_probes++;
+			ecn = INET_ECN_ECT_0;
+		}
+		quic_outq_rtx_tail(sk, fskb);
+		snd_cb->packet_number = number;
+		snd_cb->transmit_ts = jiffies_to_usecs(jiffies);
+		snd_cb->ecn = ecn;
+		QUIC_SND_CB(skb)->ecn = ecn;
+		fskb =  __skb_dequeue(head);
+	}
+
+	return skb;
+}
+
+void quic_packet_mss_update(struct sock *sk, int mss)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	int max_udp, mss_dgram;
+
+	max_udp = quic_outq_max_udp(quic_outq(sk));
+	if (max_udp && mss > max_udp)
+		mss = max_udp;
+	packet->mss[0] = mss;
+	quic_cong_set_mss(quic_cong(sk), packet->mss[0] - packet->taglen[0]);
+
+	mss_dgram = quic_outq_max_dgram(quic_outq(sk));
+	if (!mss_dgram)
+		return;
+	if (mss_dgram > mss)
+		mss_dgram = mss;
+	packet->mss[1] = mss_dgram;
+}
+
+int quic_packet_route(struct sock *sk)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	int err, mss;
+
+	packet->sa = quic_path_addr(quic_src(sk), packet->path_alt & QUIC_PATH_ALT_SRC);
+	packet->da = quic_path_addr(quic_dst(sk), packet->path_alt & QUIC_PATH_ALT_DST);
+	err = quic_flow_route(sk, packet->da, packet->sa);
+	if (err)
+		return err;
+
+	mss = dst_mtu(__sk_dst_get(sk)) - quic_encap_len(sk);
+	quic_packet_mss_update(sk, mss);
+
+	quic_path_pl_reset(quic_dst(sk));
+	quic_timer_setup(sk, QUIC_TIMER_PROBE, quic_inq_probe_timeout(inq));
+	quic_timer_reset(sk, QUIC_TIMER_PROBE);
+	return 0;
+}
+
+void quic_packet_config(struct sock *sk, u8 level, u8 path_alt)
+{
+	struct quic_connection_id_set *id_set = quic_dest(sk);
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	int hlen = sizeof(struct quichdr);
+
+	if (!quic_packet_empty(packet)) {
+		if (level == packet->level && path_alt == packet->path_alt)
+			return;
+		quic_packet_build(sk);
+	}
+	packet->ipfragok = 0;
+	packet->padding = 0;
+	hlen += 4; /* packet number */
+	hlen += quic_connection_id_active(id_set)->len;
+	if (level) {
+		hlen += 1;
+		id_set = quic_source(sk);
+		hlen += 1 + quic_connection_id_active(id_set)->len;
+		if (level == QUIC_CRYPTO_INITIAL)
+			hlen += 1 + quic_token(sk)->len;
+		hlen += 4; /* version */
+		hlen += 4; /* length number */
+		packet->ipfragok = !!quic_inq_probe_timeout(inq);
+	}
+	packet->len = hlen;
+	packet->overhead = hlen;
+	packet->level = level;
+	packet->path_alt = path_alt;
+
+	quic_packet_route(sk);
+}
+
+static void quic_packet_encrypt_done(void *data, int err)
+{
+	struct sk_buff *skb = data;
+
+	if (err) {
+		kfree_skb(skb);
+		pr_warn_once("%s: err %d\n", __func__, err);
+		return;
+	}
+
+	quic_outq_encrypted_tail(skb->sk, skb);
+}
+
+static int quic_packet_bundle(struct sock *sk, struct sk_buff *skb)
+{
+	struct quic_packet *packet = quic_packet(sk);
+	struct sk_buff *p;
+
+	if (!packet->head) {
+		packet->head = skb;
+		QUIC_SND_CB(packet->head)->last = skb;
+		goto out;
+	}
+
+	if (packet->head->len + skb->len >= packet->mss[0]) {
+		quic_lower_xmit(sk, packet->head, packet->da, packet->sa);
+		packet->count++;
+		packet->head = skb;
+		QUIC_SND_CB(packet->head)->last = skb;
+		goto out;
+	}
+	p = packet->head;
+	if (QUIC_SND_CB(p)->last == p)
+		skb_shinfo(p)->frag_list = skb;
+	else
+		QUIC_SND_CB(p)->last->next = skb;
+	p->data_len += skb->len;
+	p->truesize += skb->truesize;
+	p->len += skb->len;
+	QUIC_SND_CB(p)->last = skb;
+	QUIC_SND_CB(p)->ecn |= QUIC_SND_CB(skb)->ecn;
+
+out:
+	return !QUIC_SND_CB(skb)->level;
+}
+
+int quic_packet_xmit(struct sock *sk, struct sk_buff *skb, u8 resume)
+{
+	struct quic_snd_cb *snd_cb = QUIC_SND_CB(skb);
+	struct quic_packet *packet = quic_packet(sk);
+	struct quic_packet_info pki = {};
+	int err;
+
+	WARN_ON(!skb_set_owner_sk_safe(skb, sk));
+
+	if (!quic_hdr(skb)->form && !packet->taglen[0])
+		goto skip;
+
+	pki.number_len = 4;
+	pki.number_offset = snd_cb->number_offset;
+	pki.number = snd_cb->packet_number;
+	pki.crypto_done = quic_packet_encrypt_done;
+	pki.resume = resume;
+
+	err = quic_crypto_encrypt(quic_crypto(sk, packet->level), skb, &pki);
+	if (err) {
+		if (err != -EINPROGRESS)
+			kfree_skb(skb);
+		return err;
+	}
+
+skip:
+	if (quic_packet_bundle(sk, skb)) {
+		quic_lower_xmit(sk, packet->head, packet->da, packet->sa);
+		packet->count++;
+		packet->head = NULL;
+	}
+	return 0;
+}
+
+void quic_packet_build(struct sock *sk)
+{
+	struct sk_buff *skb;
+	int err;
+
+	err = quic_packet_number_check(sk);
+	if (err)
+		goto err;
+
+	skb = quic_packet_create(sk);
+	if (!skb) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	err = quic_packet_xmit(sk, skb, 0);
+	if (err && err != -EINPROGRESS)
+		goto err;
+	return;
+err:
+	pr_warn("[QUIC] %s %d\n", __func__, err);
+}
+
+void quic_packet_flush(struct sock *sk)
+{
+	struct quic_packet *packet = quic_packet(sk);
+
+	if (packet->head) {
+		packet->count++;
+		quic_lower_xmit(sk, packet->head, packet->da, packet->sa);
+		packet->head = NULL;
+	}
+	if (packet->count) {
+		quic_timer_start(sk, QUIC_TIMER_RTX);
+		packet->count = 0;
+	}
+}
+
+int quic_packet_tail(struct sock *sk, struct sk_buff *skb, u8 dgram)
+{
+	struct quic_snd_cb *snd_cb = QUIC_SND_CB(skb);
+	struct quic_packet *packet = quic_packet(sk);
+	u8 taglen;
+
+	if (snd_cb->level != (packet->level % QUIC_CRYPTO_EARLY) ||
+	    snd_cb->path_alt != packet->path_alt || packet->padding)
+		return 0;
+
+	taglen = packet->taglen[!!packet->level];
+	if (packet->len + skb->len > packet->mss[dgram] - taglen) {
+		if (packet->len != packet->overhead)
+			return 0;
+		if (snd_cb->frame_type != QUIC_FRAME_PING)
+			packet->ipfragok = 1;
+	}
+	if (snd_cb->padding)
+		packet->padding = snd_cb->padding;
+	packet->len += skb->len;
+	__skb_queue_tail(&packet->frame_list, skb);
+	return skb->len;
+}
+
+/* Retry Packet {
+ *   Header Form (1) = 1,
+ *   Fixed Bit (1) = 1,
+ *   Long Packet Type (2) = 3,
+ *   Unused (4),
+ *   Version (32),
+ *   Destination Connection ID Length (8),
+ *   Destination Connection ID (0..160),
+ *   Source Connection ID Length (8),
+ *   Source Connection ID (0..160),
+ *   Retry Token (..),
+ *   Retry Integrity Tag (128),
+ * }
+ */
+
+static struct sk_buff *quic_packet_retry_create(struct sock *sk, struct quic_request_sock *req)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_connection_id dcid;
+	u8 *p, token[72], tag[16];
+	int len, hlen, tokenlen;
+	struct quichshdr *hdr;
+	struct sk_buff *skb;
+
+	p = token;
+	p = quic_put_int(p, 1, 1); /* retry token */
+	if (quic_crypto_generate_token(crypto, &req->da, quic_addr_len(sk),
+				       &req->dcid, token, &tokenlen))
+		return NULL;
+
+	quic_connection_id_generate(&dcid, 18); /* new dcid for retry */
+	len = 1 + 4 + 1 + req->scid.len + 1 + dcid.len + tokenlen + 16;
+	hlen = quic_encap_len(sk) + MAX_HEADER;
+	skb = alloc_skb(hlen + len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, hlen + len);
+
+	hdr = skb_push(skb, len);
+	hdr->form = 1;
+	hdr->fixed = !quic_outq_grease_quic_bit(outq);
+	hdr->type = quic_version_put_type(req->version, QUIC_PACKET_RETRY);
+	hdr->reserved = 0;
+	hdr->pnl = 0;
+	skb_reset_transport_header(skb);
+
+	p = (u8 *)hdr + 1;
+	p = quic_put_int(p, quic_inq_version(inq), 4);
+	p = quic_put_int(p, req->scid.len, 1);
+	p = quic_put_data(p, req->scid.data, req->scid.len);
+	p = quic_put_int(p, dcid.len, 1);
+	p = quic_put_data(p, dcid.data, dcid.len);
+	p = quic_put_data(p, token, tokenlen);
+	if (quic_crypto_get_retry_tag(crypto, skb, &req->dcid, req->version, tag)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+	p = quic_put_data(p, tag, 16);
+
+	return skb;
+}
+
+int quic_packet_retry_transmit(struct sock *sk, struct quic_request_sock *req)
+{
+	struct sk_buff *skb;
+
+	__sk_dst_reset(sk);
+	if (quic_flow_route(sk, &req->da, &req->sa))
+		return -EINVAL;
+	skb = quic_packet_retry_create(sk, req);
+	if (!skb)
+		return -ENOMEM;
+	quic_lower_xmit(sk, skb, &req->da, &req->sa);
+	return 0;
+}
+
+/* Version Negotiation Packet {
+ *   Header Form (1) = 1,
+ *   Unused (7),
+ *   Version (32) = 0,
+ *   Destination Connection ID Length (8),
+ *   Destination Connection ID (0..2040),
+ *   Source Connection ID Length (8),
+ *   Source Connection ID (0..2040),
+ *   Supported Version (32) ...,
+ * }
+ */
+
+static struct sk_buff *quic_packet_version_create(struct sock *sk, struct quic_request_sock *req)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quichshdr *hdr;
+	struct sk_buff *skb;
+	int len, hlen;
+	u8 *p;
+
+	len = 1 + 4 + 1 + req->scid.len + 1 + req->dcid.len + 4 * 2;
+	hlen = quic_encap_len(sk) + MAX_HEADER;
+	skb = alloc_skb(hlen + len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, hlen + len);
+
+	hdr = skb_push(skb, len);
+	hdr->form = 1;
+	hdr->fixed = !quic_outq_grease_quic_bit(outq);
+	hdr->type = 0;
+	hdr->reserved = 0;
+	hdr->pnl = 0;
+	skb_reset_transport_header(skb);
+
+	p = (u8 *)hdr + 1;
+	p = quic_put_int(p, 0, 4);
+	p = quic_put_int(p, req->scid.len, 1);
+	p = quic_put_data(p, req->scid.data, req->scid.len);
+	p = quic_put_int(p, req->dcid.len, 1);
+	p = quic_put_data(p, req->dcid.data, req->dcid.len);
+	p = quic_put_int(p, QUIC_VERSION_V1, 4);
+	p = quic_put_int(p, QUIC_VERSION_V2, 4);
+
+	return skb;
+}
+
+int quic_packet_version_transmit(struct sock *sk, struct quic_request_sock *req)
+{
+	struct sk_buff *skb;
+
+	__sk_dst_reset(sk);
+	if (quic_flow_route(sk, &req->da, &req->sa))
+		return -EINVAL;
+	skb = quic_packet_version_create(sk, req);
+	if (!skb)
+		return -ENOMEM;
+	quic_lower_xmit(sk, skb, &req->da, &req->sa);
+	return 0;
+}
+
+/* Stateless Reset {
+ *   Fixed Bits (2) = 1,
+ *   Unpredictable Bits (38..),
+ *   Stateless Reset Token (128),
+ * }
+ */
+
+static struct sk_buff *quic_packet_stateless_reset_create(struct sock *sk,
+							  struct quic_request_sock *req)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct sk_buff *skb;
+	u8 *p, token[16];
+	int len, hlen;
+
+	if (quic_crypto_generate_stateless_reset_token(crypto, req->dcid.data,
+						       req->dcid.len, token, 16))
+		return NULL;
+
+	len = 64;
+	hlen = quic_encap_len(sk) + MAX_HEADER;
+	skb = alloc_skb(hlen + len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, hlen + len);
+
+	p = skb_push(skb, len);
+	get_random_bytes(p, len);
+
+	skb_reset_transport_header(skb);
+	quic_hdr(skb)->form = 0;
+	quic_hdr(skb)->fixed = 1;
+
+	p += (len - 16);
+	p = quic_put_data(p, token, 16);
+
+	return skb;
+}
+
+int quic_packet_stateless_reset_transmit(struct sock *sk, struct quic_request_sock *req)
+{
+	struct sk_buff *skb;
+
+	__sk_dst_reset(sk);
+	if (quic_flow_route(sk, &req->da, &req->sa))
+		return -EINVAL;
+	skb = quic_packet_stateless_reset_create(sk, req);
+	if (!skb)
+		return -ENOMEM;
+	quic_lower_xmit(sk, skb, &req->da, &req->sa);
+	return 0;
+}
+
+int quic_packet_refuse_close_transmit(struct sock *sk, struct quic_request_sock *req, u32 errcode)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_connection_id_set *source = quic_source(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_id *active;
+	u8 flag = CRYPTO_ALG_ASYNC;
+	struct sk_buff *skb;
+	int err;
+
+	active = quic_connection_id_active(source);
+	quic_connection_id_update(active, req->dcid.data, req->dcid.len);
+	quic_path_addr_set(quic_src(sk), &req->sa, 1);
+	quic_path_addr_set(quic_dst(sk), &req->da, 1);
+
+	quic_crypto_destroy(crypto);
+	err = quic_crypto_initial_keys_install(crypto, active, req->version, flag, 1);
+	if (err)
+		return err;
+
+	quic_outq_set_close_errcode(outq, errcode);
+	skb = quic_frame_create(sk, QUIC_FRAME_CONNECTION_CLOSE, NULL);
+	if (skb) {
+		QUIC_SND_CB(skb)->level = QUIC_CRYPTO_INITIAL;
+		QUIC_SND_CB(skb)->path_alt = (QUIC_PATH_ALT_SRC | QUIC_PATH_ALT_DST);
+		quic_outq_ctrl_tail(sk, skb, false);
+	}
+	return 0;
+}
+
+void quic_packet_init(struct sock *sk)
+{
+	struct quic_packet *packet = quic_packet(sk);
+
+	skb_queue_head_init(&packet->frame_list);
+	packet->taglen[0] = QUIC_TAG_LEN;
+	packet->taglen[1] = QUIC_TAG_LEN;
+}
diff --git a/net/quic/packet.h b/net/quic/packet.h
new file mode 100644
index 000000000000..7c892319af17
--- /dev/null
+++ b/net/quic/packet.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+struct quic_packet {
+	struct sk_buff_head frame_list;
+	struct sk_buff *head;
+	union quic_addr *da;
+	union quic_addr *sa;
+	u32 overhead;
+	u32 len;
+
+	u32 mss[2];
+
+	u8  ecn_probes;
+	u8  ipfragok:1;
+	u8  path_alt:2;
+	u8  padding:1;
+	u8  taglen[2];
+	u8  count;
+	u8  level;
+};
+
+#define QUIC_PACKET_INITIAL_V1		0
+#define QUIC_PACKET_0RTT_V1		1
+#define QUIC_PACKET_HANDSHAKE_V1	2
+#define QUIC_PACKET_RETRY_V1		3
+
+#define QUIC_PACKET_INITIAL_V2		1
+#define QUIC_PACKET_0RTT_V2		2
+#define QUIC_PACKET_HANDSHAKE_V2	3
+#define QUIC_PACKET_RETRY_V2		0
+
+#define QUIC_PACKET_INITIAL		QUIC_PACKET_INITIAL_V1
+#define QUIC_PACKET_0RTT		QUIC_PACKET_0RTT_V1
+#define QUIC_PACKET_HANDSHAKE		QUIC_PACKET_HANDSHAKE_V1
+#define QUIC_PACKET_RETRY		QUIC_PACKET_RETRY_V1
+
+struct quic_request_sock;
+
+static inline u32 quic_packet_taglen(struct quic_packet *packet)
+{
+	return packet->taglen[0];
+}
+
+static inline u32 quic_packet_mss(struct quic_packet *packet)
+{
+	return packet->mss[0] - packet->taglen[!!packet->level];
+}
+
+static inline u32 quic_packet_overhead(struct quic_packet *packet)
+{
+	return packet->overhead;
+}
+
+static inline u32 quic_packet_max_payload(struct quic_packet *packet)
+{
+	return packet->mss[0] - packet->overhead - packet->taglen[!!packet->level];
+}
+
+static inline u32 quic_packet_max_payload_dgram(struct quic_packet *packet)
+{
+	return packet->mss[1] - packet->overhead - packet->taglen[!!packet->level];
+}
+
+static inline bool quic_packet_empty(struct quic_packet *packet)
+{
+	return skb_queue_empty(&packet->frame_list);
+}
+
+static inline void quic_packet_set_taglen(struct quic_packet *packet, u8 taglen)
+{
+	packet->taglen[0] = taglen;
+}
+
+static inline void quic_packet_set_ecn_probes(struct quic_packet *packet, u8 probes)
+{
+	packet->ecn_probes = probes;
+}
+
+void quic_packet_config(struct sock *sk, u8 level, u8 path_alt);
+void quic_packet_build(struct sock *sk);
+int quic_packet_route(struct sock *sk);
+int quic_packet_process(struct sock *sk, struct sk_buff *skb, u8 resume);
+int quic_packet_tail(struct sock *sk, struct sk_buff *skb, u8 dgram);
+void quic_packet_flush(struct sock *sk);
+int quic_packet_retry_transmit(struct sock *sk, struct quic_request_sock *req);
+int quic_packet_version_transmit(struct sock *sk, struct quic_request_sock *req);
+int quic_packet_stateless_reset_transmit(struct sock *sk, struct quic_request_sock *req);
+int quic_packet_refuse_close_transmit(struct sock *sk, struct quic_request_sock *req, u32 errcode);
+void quic_packet_mss_update(struct sock *sk, int mss);
+int quic_packet_xmit(struct sock *sk, struct sk_buff *skb, u8 resume);
+void quic_packet_init(struct sock *sk);
diff --git a/net/quic/path.c b/net/quic/path.c
new file mode 100644
index 000000000000..70dde221f118
--- /dev/null
+++ b/net/quic/path.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <net/udp_tunnel.h>
+
+#include <linux/version.h>
+
+#include "uapi/linux/quic.h"
+#include "hashtable.h"
+#include "protocol.h"
+#include "stream.h"
+#include "input.h"
+#include "path.h"
+
+static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	if (skb_linearize(skb))
+		return 0;
+
+	memset(skb->cb, 0, sizeof(skb->cb));
+	QUIC_RCV_CB(skb)->udph_offset = skb->transport_header;
+	skb_set_transport_header(skb, sizeof(struct udphdr));
+	quic_rcv(skb);
+	return 0;
+}
+
+static int quic_udp_err(struct sock *sk, struct sk_buff *skb)
+{
+	int ret;
+
+	skb->transport_header += sizeof(struct udphdr);
+	ret = quic_rcv_err(skb);
+	skb->transport_header -= sizeof(struct udphdr);
+
+	return ret;
+}
+
+static void quic_udp_sock_destroy(struct work_struct *work)
+{
+	struct quic_udp_sock *us = container_of(work, struct quic_udp_sock, work);
+	struct quic_hash_head *head;
+
+	head = quic_udp_sock_head(sock_net(us->sk), &us->addr);
+
+	spin_lock(&head->lock);
+	__hlist_del(&us->node);
+	spin_unlock(&head->lock);
+
+	udp_tunnel_sock_release(us->sk->sk_socket);
+	kfree(us);
+}
+
+static struct quic_udp_sock *quic_udp_sock_create(struct sock *sk, union quic_addr *a)
+{
+	struct udp_tunnel_sock_cfg tuncfg = {NULL};
+	struct udp_port_cfg udp_conf = {0};
+	struct net *net = sock_net(sk);
+	struct quic_hash_head *head;
+	struct quic_udp_sock *us;
+	struct socket *sock;
+
+	us = kzalloc(sizeof(*us), GFP_ATOMIC);
+	if (!us)
+		return NULL;
+
+	quic_udp_conf_init(sk, &udp_conf, a);
+	if (udp_sock_create(net, &udp_conf, &sock)) {
+		pr_err("[QUIC] Failed to create UDP sock for QUIC\n");
+		kfree(us);
+		return NULL;
+	}
+
+	tuncfg.encap_type = 1;
+	tuncfg.encap_rcv = quic_udp_rcv;
+	tuncfg.encap_err_lookup = quic_udp_err;
+	setup_udp_tunnel_sock(net, sock, &tuncfg);
+
+	refcount_set(&us->refcnt, 1);
+	us->sk = sock->sk;
+	memcpy(&us->addr, a, sizeof(*a));
+
+	head = quic_udp_sock_head(net, a);
+	spin_lock(&head->lock);
+	hlist_add_head(&us->node, &head->head);
+	spin_unlock(&head->lock);
+	INIT_WORK(&us->work, quic_udp_sock_destroy);
+
+	return us;
+}
+
+static struct quic_udp_sock *quic_udp_sock_lookup(struct sock *sk, union quic_addr *a)
+{
+	struct quic_udp_sock *tmp, *us = NULL;
+	struct net *net = sock_net(sk);
+	struct quic_hash_head *head;
+	union quic_addr sa = {};
+
+	head = quic_udp_sock_head(net, a);
+	spin_lock(&head->lock);
+	hlist_for_each_entry(tmp, &head->head, node) {
+		if (net == sock_net(tmp->sk) &&
+		    !memcmp(&tmp->addr, a, quic_addr_len(sk))) {
+			us = quic_udp_sock_get(tmp);
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+	if (us)
+		return us;
+
+	/* Search for socket binding to the same port with 0.0.0.0 or :: address */
+	sa.v4.sin_family = a->v4.sin_family;
+	sa.v4.sin_port = a->v4.sin_port;
+	head = quic_udp_sock_head(net, &sa);
+	spin_lock(&head->lock);
+	hlist_for_each_entry(tmp, &head->head, node) {
+		if (net == sock_net(tmp->sk) &&
+		    !memcmp(&tmp->addr, &sa, quic_addr_len(sk))) {
+			us = quic_udp_sock_get(tmp);
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+
+	if (!us)
+		us = quic_udp_sock_create(sk, a);
+	return us;
+}
+
+struct quic_udp_sock *quic_udp_sock_get(struct quic_udp_sock *us)
+{
+	if (us)
+		refcount_inc(&us->refcnt);
+	return us;
+}
+
+void quic_udp_sock_put(struct quic_udp_sock *us)
+{
+	if (us && refcount_dec_and_test(&us->refcnt))
+		queue_work(quic_wq, &us->work);
+}
+
+int quic_path_set_udp_sock(struct sock *sk, struct quic_path_addr *path, bool alt)
+{
+	struct quic_path_src *src = (struct quic_path_src *)path;
+	struct quic_udp_sock *usk;
+
+	usk = quic_udp_sock_lookup(sk, quic_path_addr(path, alt));
+	if (!usk)
+		return -EINVAL;
+
+	quic_udp_sock_put(src->udp_sk[src->a.active ^ alt]);
+	src->udp_sk[src->a.active ^ alt] = usk;
+	return 0;
+}
+
+void quic_bind_port_put(struct sock *sk, struct quic_bind_port *pp)
+{
+	struct net *net = sock_net(sk);
+	struct quic_hash_head *head;
+
+	if (hlist_unhashed(&pp->node))
+		return;
+
+	head = quic_bind_port_head(net, pp->port);
+	spin_lock(&head->lock);
+	hlist_del_init(&pp->node);
+	spin_unlock(&head->lock);
+}
+
+int quic_path_set_bind_port(struct sock *sk, struct quic_path_addr *path, bool alt)
+{
+	struct quic_bind_port *port = quic_path_port(path, alt);
+	union quic_addr *addr = quic_path_addr(path, alt);
+	struct net *net = sock_net(sk);
+	struct quic_hash_head *head;
+	struct quic_bind_port *pp;
+	int low, high, remaining;
+	unsigned int rover;
+
+	quic_bind_port_put(sk, port);
+
+	rover = ntohs(addr->v4.sin_port);
+	if (rover) {
+		head = quic_bind_port_head(net, rover);
+		spin_lock_bh(&head->lock);
+		port->net = net;
+		port->port = rover;
+		hlist_add_head(&port->node, &head->head);
+		spin_unlock_bh(&head->lock);
+		return 0;
+	}
+
+	inet_get_local_port_range(net, &low, &high);
+	remaining = (high - low) + 1;
+	rover = (u32)(((u64)get_random_u32() * remaining) >> 32) + low;
+	do {
+		rover++;
+		if (rover < low || rover > high)
+			rover = low;
+		if (inet_is_local_reserved_port(net, rover))
+			continue;
+		head = quic_bind_port_head(net, rover);
+		spin_lock_bh(&head->lock);
+		hlist_for_each_entry(pp, &head->head, node)
+			if (pp->port == rover && net_eq(net, pp->net))
+				goto next;
+		addr->v4.sin_port = htons(rover);
+		port->net = net;
+		port->port = rover;
+		hlist_add_head(&port->node, &head->head);
+		spin_unlock_bh(&head->lock);
+		return 0;
+next:
+		spin_unlock_bh(&head->lock);
+		cond_resched();
+	} while (--remaining > 0);
+
+	return -EADDRINUSE;
+}
+
+void quic_path_addr_free(struct sock *sk, struct quic_path_addr *path, bool alt)
+{
+	struct quic_path_src *src;
+
+	if (!path->udp_bind)
+		goto out;
+
+	src = (struct quic_path_src *)path;
+	quic_udp_sock_put(src->udp_sk[path->active ^ alt]);
+	src->udp_sk[path->active ^ alt] = NULL;
+	quic_bind_port_put(sk, &src->port[path->active ^ alt]);
+out:
+	memset(&path->addr[path->active ^ alt], 0, path->addr_len);
+}
+
+void quic_path_free(struct sock *sk, struct quic_path_addr *path)
+{
+	quic_path_addr_free(sk, path, 0);
+	quic_path_addr_free(sk, path, 1);
+}
+
+enum quic_plpmtud_state {
+	QUIC_PL_DISABLED,
+	QUIC_PL_BASE,
+	QUIC_PL_SEARCH,
+	QUIC_PL_COMPLETE,
+	QUIC_PL_ERROR,
+};
+
+#define QUIC_BASE_PLPMTU        1200
+#define QUIC_MAX_PLPMTU         9000
+#define QUIC_MIN_PLPMTU         512
+
+#define QUIC_MAX_PROBES         3
+
+#define QUIC_PL_BIG_STEP        32
+#define QUIC_PL_MIN_STEP        4
+
+int quic_path_pl_send(struct quic_path_addr *a, s64 number)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)a;
+	int pathmtu = 0;
+
+	d->pl.number = number;
+	if (d->pl.probe_count < QUIC_MAX_PROBES)
+		goto out;
+
+	d->pl.probe_count = 0;
+	if (d->pl.state == QUIC_PL_BASE) {
+		if (d->pl.probe_size == QUIC_BASE_PLPMTU) { /* BASE_PLPMTU Confirmation Failed */
+			d->pl.state = QUIC_PL_ERROR; /* Base -> Error */
+
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+		}
+	} else if (d->pl.state == QUIC_PL_SEARCH) {
+		if (d->pl.pmtu == d->pl.probe_size) { /* Black Hole Detected */
+			d->pl.state = QUIC_PL_BASE;  /* Search -> Base */
+			d->pl.probe_size = QUIC_BASE_PLPMTU;
+			d->pl.probe_high = 0;
+
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+		} else { /* Normal probe failure. */
+			d->pl.probe_high = d->pl.probe_size;
+			d->pl.probe_size = d->pl.pmtu;
+		}
+	} else if (d->pl.state == QUIC_PL_COMPLETE) {
+		if (d->pl.pmtu == d->pl.probe_size) { /* Black Hole Detected */
+			d->pl.state = QUIC_PL_BASE;  /* Search Complete -> Base */
+			d->pl.probe_size = QUIC_BASE_PLPMTU;
+
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+		}
+	}
+
+out:
+	pr_debug("%s: PLPMTUD: dst: %p, state: %d, pmtu: %d, size: %d, high: %d\n",
+		 __func__, d, d->pl.state, d->pl.pmtu, d->pl.probe_size, d->pl.probe_high);
+	d->pl.probe_count++;
+	return pathmtu;
+}
+
+int quic_path_pl_recv(struct quic_path_addr *a, bool *raise_timer, bool *complete)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)a;
+	int pathmtu = 0;
+
+	pr_debug("%s: PLPMTUD: dst: %p, state: %d, pmtu: %d, size: %d, high: %d\n",
+		 __func__, d, d->pl.state, d->pl.pmtu, d->pl.probe_size, d->pl.probe_high);
+
+	*raise_timer = false;
+	d->pl.number = 0;
+	d->pl.pmtu = d->pl.probe_size;
+	d->pl.probe_count = 0;
+	if (d->pl.state == QUIC_PL_BASE) {
+		d->pl.state = QUIC_PL_SEARCH; /* Base -> Search */
+		d->pl.probe_size += QUIC_PL_BIG_STEP;
+	} else if (d->pl.state == QUIC_PL_ERROR) {
+		d->pl.state = QUIC_PL_SEARCH; /* Error -> Search */
+
+		d->pl.pmtu = d->pl.probe_size;
+		d->pathmtu = d->pl.pmtu;
+		pathmtu = d->pathmtu;
+		d->pl.probe_size += QUIC_PL_BIG_STEP;
+	} else if (d->pl.state == QUIC_PL_SEARCH) {
+		if (!d->pl.probe_high) {
+			if (d->pl.probe_size < QUIC_MAX_PLPMTU) {
+				d->pl.probe_size = min(d->pl.probe_size + QUIC_PL_BIG_STEP,
+						       QUIC_MAX_PLPMTU);
+				*complete = false;
+				return pathmtu;
+			}
+			d->pl.probe_high = QUIC_MAX_PLPMTU;
+		}
+		d->pl.probe_size += QUIC_PL_MIN_STEP;
+		if (d->pl.probe_size >= d->pl.probe_high) {
+			d->pl.probe_high = 0;
+			d->pl.state = QUIC_PL_COMPLETE; /* Search -> Search Complete */
+
+			d->pl.probe_size = d->pl.pmtu;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+			*raise_timer = true;
+		}
+	} else if (d->pl.state == QUIC_PL_COMPLETE) {
+		/* Raise probe_size again after 30 * interval in Search Complete */
+		d->pl.state = QUIC_PL_SEARCH; /* Search Complete -> Search */
+		d->pl.probe_size = min(d->pl.probe_size + QUIC_PL_MIN_STEP, QUIC_MAX_PLPMTU);
+	}
+
+	*complete = (d->pl.state == QUIC_PL_COMPLETE);
+	return pathmtu;
+}
+
+int quic_path_pl_toobig(struct quic_path_addr *a, u32 pmtu, bool *reset_timer)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)a;
+	int pathmtu = 0;
+
+	pr_debug("%s: PLPMTUD: dst: %p, state: %d, pmtu: %d, size: %d, ptb: %d\n",
+		 __func__, d, d->pl.state, d->pl.pmtu, d->pl.probe_size, pmtu);
+
+	*reset_timer = false;
+	if (pmtu < QUIC_MIN_PLPMTU || pmtu >= d->pl.probe_size)
+		return pathmtu;
+
+	if (d->pl.state == QUIC_PL_BASE) {
+		if (pmtu >= QUIC_MIN_PLPMTU && pmtu < QUIC_BASE_PLPMTU) {
+			d->pl.state = QUIC_PL_ERROR; /* Base -> Error */
+
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+		}
+	} else if (d->pl.state == QUIC_PL_SEARCH) {
+		if (pmtu >= QUIC_BASE_PLPMTU && pmtu < d->pl.pmtu) {
+			d->pl.state = QUIC_PL_BASE;  /* Search -> Base */
+			d->pl.probe_size = QUIC_BASE_PLPMTU;
+			d->pl.probe_count = 0;
+
+			d->pl.probe_high = 0;
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+		} else if (pmtu > d->pl.pmtu && pmtu < d->pl.probe_size) {
+			d->pl.probe_size = pmtu;
+			d->pl.probe_count = 0;
+		}
+	} else if (d->pl.state == QUIC_PL_COMPLETE) {
+		if (pmtu >= QUIC_BASE_PLPMTU && pmtu < d->pl.pmtu) {
+			d->pl.state = QUIC_PL_BASE;  /* Complete -> Base */
+			d->pl.probe_size = QUIC_BASE_PLPMTU;
+			d->pl.probe_count = 0;
+
+			d->pl.probe_high = 0;
+			d->pl.pmtu = QUIC_BASE_PLPMTU;
+			d->pathmtu = d->pl.pmtu;
+			pathmtu = d->pathmtu;
+			*reset_timer = true;
+		}
+	}
+	return pathmtu;
+}
+
+void quic_path_pl_reset(struct quic_path_addr *a)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)a;
+
+	d->pl.state = QUIC_PL_BASE;
+	d->pl.pmtu = QUIC_BASE_PLPMTU;
+	d->pl.probe_size = QUIC_BASE_PLPMTU;
+}
+
+bool quic_path_pl_confirm(struct quic_path_addr *a, s64 largest, s64 smallest)
+{
+	struct quic_path_dst *d = (struct quic_path_dst *)a;
+
+	return d->pl.number && d->pl.number >= smallest && d->pl.number <= largest;
+}
diff --git a/net/quic/path.h b/net/quic/path.h
new file mode 100644
index 000000000000..a8e97bb12cd0
--- /dev/null
+++ b/net/quic/path.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_PATH_ALT_SRC	0x1
+#define QUIC_PATH_ALT_DST	0x2
+
+struct quic_bind_port {
+	unsigned short		port;
+	struct hlist_node	node;
+	struct net		*net;
+	u8			serv:1;
+	u8			retry:1;
+};
+
+struct quic_udp_sock {
+	struct work_struct work;
+	struct hlist_node node;
+	union quic_addr addr;
+	refcount_t refcnt;
+	struct sock *sk;
+};
+
+struct quic_path_addr {
+	union quic_addr addr[2];
+	u8 addr_len;
+	u8 sent_cnt;
+	u8 active:1;
+	u8 udp_bind:1;
+	u8 entropy[8];
+};
+
+struct quic_path_src {
+	struct quic_path_addr a;
+	struct quic_bind_port port[2];
+	struct quic_udp_sock *udp_sk[2];
+};
+
+struct quic_path_dst {
+	struct quic_path_addr a;
+	u32 mtu_info;
+	u32 pathmtu;
+	struct {
+		u64 number;
+		u16 pmtu;
+		u16 probe_size;
+		u16 probe_high;
+		u8 probe_count;
+		u8 state;
+	} pl; /* plpmtud related */
+};
+
+static inline void quic_path_addr_set(struct quic_path_addr *a, union quic_addr *addr, bool alt)
+{
+	memcpy(&a->addr[a->active ^ alt], addr, a->addr_len);
+}
+
+static inline union quic_addr *quic_path_addr(struct quic_path_addr *a, bool alt)
+{
+	return &a->addr[a->active ^ alt];
+}
+
+static inline struct quic_bind_port *quic_path_port(struct quic_path_addr *a, bool alt)
+{
+	return &((struct quic_path_src *)a)->port[a->active ^ alt];
+}
+
+static inline void quic_path_addr_init(struct quic_path_addr *a, u8 addr_len, u8 udp_bind)
+{
+	a->addr_len = addr_len;
+	a->udp_bind = udp_bind;
+}
+
+static inline int quic_path_cmp(struct quic_path_addr *a, bool alt, union quic_addr *addr)
+{
+	return memcmp(addr, quic_path_addr(a, alt), a->addr_len);
+}
+
+static inline u32 quic_path_mtu_info(struct quic_path_addr *a)
+{
+	return ((struct quic_path_dst *)a)->mtu_info;
+}
+
+static inline void quic_path_set_mtu_info(struct quic_path_addr *a, u32 mtu_info)
+{
+	((struct quic_path_dst *)a)->mtu_info = mtu_info;
+}
+
+static inline u8 quic_path_sent_cnt(struct quic_path_addr *a)
+{
+	return a->sent_cnt;
+}
+
+static inline void quic_path_set_sent_cnt(struct quic_path_addr *a, u8 cnt)
+{
+	a->sent_cnt = cnt;
+}
+
+static inline void quic_path_swap_active(struct quic_path_addr *a)
+{
+	a->active = !a->active;
+}
+
+static inline u8 *quic_path_entropy(struct quic_path_addr *a)
+{
+	return a->entropy;
+}
+
+static inline u8 quic_path_udp_bind(struct quic_path_addr *a)
+{
+	return a->udp_bind;
+}
+
+void quic_udp_sock_put(struct quic_udp_sock *us);
+struct quic_udp_sock *quic_udp_sock_get(struct quic_udp_sock *us);
+int quic_path_set_udp_sock(struct sock *sk, struct quic_path_addr *a, bool alt);
+void quic_bind_port_put(struct sock *sk, struct quic_bind_port *pp);
+int quic_path_set_bind_port(struct sock *sk, struct quic_path_addr *a, bool alt);
+void quic_path_free(struct sock *sk, struct quic_path_addr *a);
+void quic_path_addr_free(struct sock *sk, struct quic_path_addr *path, bool alt);
+int quic_path_pl_send(struct quic_path_addr *a, s64 number);
+int quic_path_pl_recv(struct quic_path_addr *a, bool *raise_timer, bool *complete);
+int quic_path_pl_toobig(struct quic_path_addr *a, u32 pmtu, bool *reset_timer);
+void quic_path_pl_reset(struct quic_path_addr *a);
+bool quic_path_pl_confirm(struct quic_path_addr *a, s64 largest, s64 smallest);
diff --git a/net/quic/pnmap.c b/net/quic/pnmap.c
new file mode 100644
index 000000000000..e4c1fcfb7552
--- /dev/null
+++ b/net/quic/pnmap.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/bitmap.h>
+#include "pnmap.h"
+
+#define QUIC_PN_MAP_INITIAL BITS_PER_LONG
+#define QUIC_PN_MAP_INCREMENT QUIC_PN_MAP_INITIAL
+#define QUIC_PN_MAP_SIZE 1024
+
+static int quic_pnmap_grow(struct quic_pnmap *map, u16 size);
+static void quic_pnmap_update(struct quic_pnmap *map, s64 pn);
+
+int quic_pnmap_init(struct quic_pnmap *map)
+{
+	u16 len = QUIC_PN_MAP_INITIAL;
+
+	if (!map->pn_map) {
+		map->pn_map = kzalloc(len >> 3, GFP_KERNEL);
+		if (!map->pn_map)
+			return -ENOMEM;
+
+		map->len = len;
+	} else {
+		bitmap_zero(map->pn_map, map->len);
+	}
+
+	map->next_number = QUIC_PN_MAP_BASE_PN;
+
+	map->base_pn = QUIC_PN_MAP_BASE_PN;
+	map->cum_ack_point = map->base_pn - 1;
+	map->min_pn_seen = map->base_pn + QUIC_PN_MAP_SIZE;
+	map->max_pn_seen = map->base_pn - 1;
+	map->last_max_pn_seen = map->base_pn - 1;
+
+	map->max_pn_ts = jiffies_to_usecs(jiffies);
+	map->last_max_pn_ts = map->max_pn_ts;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(quic_pnmap_init);
+
+void quic_pnmap_free(struct quic_pnmap *map)
+{
+	map->len = 0;
+	kfree(map->pn_map);
+}
+EXPORT_SYMBOL_GPL(quic_pnmap_free);
+
+int quic_pnmap_check(const struct quic_pnmap *map, s64 pn)
+{
+	u16 gap;
+
+	if (pn < map->base_pn)
+		return 1;
+
+	if (pn >= map->base_pn + QUIC_PN_MAP_SIZE)
+		return -1;
+
+	WARN_ON_ONCE(pn > QUIC_PN_MAP_MAX_PN);
+	gap = pn - map->base_pn;
+
+	return gap < map->len && test_bit(gap, map->pn_map);
+}
+EXPORT_SYMBOL_GPL(quic_pnmap_check);
+
+int quic_pnmap_mark(struct quic_pnmap *map, s64 pn)
+{
+	u16 gap, zero_bit;
+
+	if (pn < map->base_pn)
+		return 0;
+
+	gap = pn - map->base_pn;
+
+	if (gap >= map->len && !quic_pnmap_grow(map, gap + 1))
+		return -ENOMEM;
+
+	if (map->max_pn_seen < pn) {
+		map->max_pn_seen = pn;
+		map->max_pn_ts = jiffies_to_usecs(jiffies);
+	}
+
+	if (pn < map->min_pn_seen) { /* only in the 1st period */
+		map->min_pn_seen = pn;
+		map->last_max_pn_seen = pn;
+	}
+
+	if (map->cum_ack_point + 1 != pn) {
+		set_bit(gap, map->pn_map);
+		goto out;
+	}
+
+	map->cum_ack_point++;
+	if (!quic_pnmap_has_gap(map) && !gap) {
+		map->base_pn++;
+		goto out;
+	}
+
+	set_bit(gap, map->pn_map);
+	zero_bit = find_first_zero_bit(map->pn_map, map->max_pn_seen - map->base_pn + 1);
+	map->base_pn += zero_bit;
+	map->cum_ack_point = map->base_pn - 1;
+	bitmap_shift_right(map->pn_map, map->pn_map, zero_bit, map->len);
+out:
+	quic_pnmap_update(map, pn);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(quic_pnmap_mark);
+
+struct quic_pnmap_iter {
+	s64 start;
+};
+
+static int quic_pnmap_next_gap_ack(const struct quic_pnmap *map, struct quic_pnmap_iter *iter,
+				   u16 *start, u16 *end)
+{
+	u16 start_ = 0, end_ = 0, offset;
+
+	offset = iter->start - map->base_pn;
+
+	start_ = find_next_zero_bit(map->pn_map, map->len, offset);
+	if (map->max_pn_seen <= map->base_pn + start_)
+		return 0;
+
+	end_ = find_next_bit(map->pn_map, map->len, start_);
+	if (map->max_pn_seen <= map->base_pn + end_ - 1)
+		return 0;
+
+	*start = start_ + 1;
+	*end = end_;
+	iter->start = map->base_pn + *end;
+	return 1;
+}
+
+static void quic_pnmap_update(struct quic_pnmap *map, s64 pn)
+{
+	u32 current_ts = jiffies_to_usecs(jiffies);
+	u16 zero_bit, offset;
+
+	if (current_ts - map->last_max_pn_ts < map->max_record_ts &&
+	    map->max_pn_seen <= map->last_max_pn_seen + QUIC_PN_MAP_SIZE / 2 &&
+	    map->max_pn_seen <= map->base_pn + QUIC_PN_MAP_SIZE * 3 / 4)
+		return;
+
+	if (map->last_max_pn_seen + 1 <= map->base_pn)
+		goto out;
+
+	offset = map->last_max_pn_seen + 1 - map->base_pn;
+	zero_bit = find_next_zero_bit(map->pn_map, map->len, offset);
+	map->base_pn += zero_bit;
+	map->cum_ack_point = map->base_pn - 1;
+	bitmap_shift_right(map->pn_map, map->pn_map, zero_bit, map->len);
+
+out:
+	map->min_pn_seen = map->last_max_pn_seen;
+	map->last_max_pn_ts = current_ts;
+	map->last_max_pn_seen = map->max_pn_seen;
+}
+
+static int quic_pnmap_grow(struct quic_pnmap *map, u16 size)
+{
+	unsigned long *new;
+	unsigned long inc;
+	u16  len;
+
+	if (size > QUIC_PN_MAP_SIZE)
+		return 0;
+
+	inc = ALIGN((size - map->len), BITS_PER_LONG) + QUIC_PN_MAP_INCREMENT;
+	len = min_t(u16, map->len + inc, QUIC_PN_MAP_SIZE);
+
+	new = kzalloc(len >> 3, GFP_ATOMIC);
+	if (!new)
+		return 0;
+
+	bitmap_copy(new, map->pn_map, map->max_pn_seen - map->base_pn + 1);
+	kfree(map->pn_map);
+	map->pn_map = new;
+	map->len = len;
+
+	return 1;
+}
+
+u16 quic_pnmap_num_gabs(struct quic_pnmap *map, struct quic_gap_ack_block *gabs)
+{
+	struct quic_pnmap_iter iter;
+	u16 start, end, ngaps = 0;
+
+	if (!quic_pnmap_has_gap(map))
+		return 0;
+
+	iter.start = map->cum_ack_point + 1;
+	if (!iter.start)
+		iter.start = map->min_pn_seen + 1;
+
+	while (quic_pnmap_next_gap_ack(map, &iter, &start, &end)) {
+		gabs[ngaps].start = start;
+		gabs[ngaps].end = end;
+		ngaps++;
+		if (ngaps >= QUIC_PN_MAX_GABS)
+			break;
+	}
+	return ngaps;
+}
+EXPORT_SYMBOL_GPL(quic_pnmap_num_gabs);
diff --git a/net/quic/pnmap.h b/net/quic/pnmap.h
new file mode 100644
index 000000000000..a3e6ef1bb606
--- /dev/null
+++ b/net/quic/pnmap.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_PN_MAX_GABS	128
+#define QUIC_PN_MAP_BASE_PN	0
+#define QUIC_PN_MAP_MAX_PN	((1ULL << 62) - 1)
+
+#define QUIC_PN_MAP_INITIAL BITS_PER_LONG
+#define QUIC_PN_MAP_INCREMENT QUIC_PN_MAP_INITIAL
+#define QUIC_PN_MAP_SIZE 1024
+
+/* pn_map:
+ * cum_ack_point --v
+ * min_pn_seen -->  |----------------------|---------------------|...
+ *        base_pn --^   last_max_pn_seen --^       max_pn_seen --^
+ *
+ * move forward:
+ *   min_pn_seen = last_max_pn_seen;
+ *   base_pn = first_zero_bit from last_max_pn_seen + 1;
+ *   cum_ack_point = base_pn - 1;
+ *   last_max_pn_seen = max_pn_seen;
+ * when:
+ *   'max_pn_ts - last_max_pn_ts >= max_record_ts' or
+ *   'max_pn_seen - last_max_pn_seen > QUIC_PN_MAP_SIZE / 2' or
+ *   'max_pn_seen - base_pn > QUIC_PN_MAP_SIZE * 3 / 4'
+ * gaps search:
+ *    from cum_ack_point/min_pn_seen to max_pn_seen
+ */
+struct quic_pnmap {
+	unsigned long *pn_map;
+	s64 next_number; /* next packet number to send */
+	u64 ecn_count[2][3]; /* ECT_1, ECT_0, CE count of local and peer */
+	u16 len;
+
+	s64 base_pn;
+	s64 min_pn_seen;
+
+	s64 max_pn_seen;
+	u32 max_pn_ts;
+
+	u32 max_record_ts;
+	s64 cum_ack_point;
+
+	u32 last_max_pn_ts;
+	s64 last_max_pn_seen;
+};
+
+struct quic_gap_ack_block {
+	u16 start;
+	u16 end;
+};
+
+static inline void quic_pnmap_set_max_record_ts(struct quic_pnmap *map, u32 max_record_ts)
+{
+	map->max_record_ts = max_record_ts;
+}
+
+static inline s64 quic_pnmap_min_pn_seen(const struct quic_pnmap *map)
+{
+	return map->min_pn_seen;
+}
+
+static inline s64 quic_pnmap_max_pn_seen(const struct quic_pnmap *map)
+{
+	return map->max_pn_seen;
+}
+
+static inline s64 quic_pnmap_next_number(const struct quic_pnmap *map)
+{
+	return map->next_number;
+}
+
+static inline s64 quic_pnmap_increase_next_number(struct quic_pnmap *map)
+{
+	return map->next_number++;
+}
+
+static inline s64 quic_pnmap_base_pn(const struct quic_pnmap *map)
+{
+	return map->base_pn;
+}
+
+static inline u32 quic_pnmap_max_pn_ts(const struct quic_pnmap *map)
+{
+	return map->max_pn_ts;
+}
+
+static inline bool quic_pnmap_has_gap(const struct quic_pnmap *map)
+{
+	return map->cum_ack_point != map->max_pn_seen;
+}
+
+static inline void quic_pnmap_increase_ecn_count(struct quic_pnmap *map, u8 ecn)
+{
+	if (!ecn)
+		return;
+	map->ecn_count[0][ecn - 1]++;
+}
+
+static inline int quic_pnmap_set_ecn_count(struct quic_pnmap *map, u64 *ecn_count)
+{
+	if (map->ecn_count[1][0] < ecn_count[0])
+		map->ecn_count[1][0] = ecn_count[0];
+	if (map->ecn_count[1][1] < ecn_count[1])
+		map->ecn_count[1][1] = ecn_count[1];
+	if (map->ecn_count[1][2] < ecn_count[2]) {
+		map->ecn_count[1][2] = ecn_count[2];
+		return 1;
+	}
+	return 0;
+}
+
+static inline u64 *quic_pnmap_ecn_count(struct quic_pnmap *map)
+{
+	return map->ecn_count[0];
+}
+
+static inline bool quic_pnmap_has_ecn_count(struct quic_pnmap *map)
+{
+	return map->ecn_count[0][0] || map->ecn_count[0][1] || map->ecn_count[0][2];
+}
+
+int quic_pnmap_init(struct quic_pnmap *map);
+int quic_pnmap_check(const struct quic_pnmap *map, s64 pn);
+int quic_pnmap_mark(struct quic_pnmap *map, s64 pn);
+void quic_pnmap_free(struct quic_pnmap *map);
+u16 quic_pnmap_num_gabs(struct quic_pnmap *map, struct quic_gap_ack_block *gabs);
diff --git a/net/quic/protocol.c b/net/quic/protocol.c
new file mode 100644
index 000000000000..392009ea4534
--- /dev/null
+++ b/net/quic/protocol.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include <net/inet_common.h>
+#include <net/protocol.h>
+#include <linux/icmp.h>
+#include <net/tls.h>
+
+struct quic_hash_table quic_hash_tables[QUIC_HT_MAX_TABLES] __read_mostly;
+struct percpu_counter quic_sockets_allocated;
+struct workqueue_struct *quic_wq;
+u8 random_data[32];
+
+long sysctl_quic_mem[3];
+int sysctl_quic_rmem[3];
+int sysctl_quic_wmem[3];
+
+static int quic_v6_flow_route(struct sock *sk, union quic_addr *da, union quic_addr *sa)
+{
+	struct dst_entry *dst;
+	struct flowi6 *fl6;
+	struct flowi _fl;
+
+	if (__sk_dst_check(sk, inet6_sk(sk)->dst_cookie))
+		return 1;
+
+	fl6 = &_fl.u.ip6;
+	memset(&_fl, 0x0, sizeof(_fl));
+	fl6->saddr = sa->v6.sin6_addr;
+	fl6->fl6_sport = sa->v6.sin6_port;
+	fl6->daddr = da->v6.sin6_addr;
+	fl6->fl6_dport = da->v6.sin6_port;
+
+	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, NULL);
+	if (IS_ERR(dst))
+		return PTR_ERR(dst);
+
+	if (!sa->v6.sin6_family) {
+		sa->v6.sin6_family = AF_INET6;
+		sa->v6.sin6_addr = fl6->saddr;
+	}
+	ip6_dst_store(sk, dst, NULL, NULL);
+	return 0;
+}
+
+static int quic_v4_flow_route(struct sock *sk, union quic_addr *da, union quic_addr *sa)
+{
+	struct flowi4 *fl4;
+	struct rtable *rt;
+	struct flowi _fl;
+
+	if (__sk_dst_check(sk, 0))
+		return 1;
+
+	fl4 = &_fl.u.ip4;
+	memset(&_fl, 0x00, sizeof(_fl));
+	fl4->saddr = sa->v4.sin_addr.s_addr;
+	fl4->fl4_sport = sa->v4.sin_port;
+	fl4->daddr = da->v4.sin_addr.s_addr;
+	fl4->fl4_dport = da->v4.sin_port;
+
+	rt = ip_route_output_key(sock_net(sk), fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+
+	if (!sa->v4.sin_family) {
+		sa->v4.sin_family = AF_INET;
+		sa->v4.sin_addr.s_addr = fl4->saddr;
+	}
+	sk_setup_caps(sk, &rt->dst);
+	return 0;
+}
+
+static void quic_v4_lower_xmit(struct sock *sk, struct sk_buff *skb, union quic_addr *da,
+			       union quic_addr *sa)
+{
+	u8 tos = (inet_sk(sk)->tos | QUIC_SND_CB(skb)->ecn);
+	struct dst_entry *dst;
+	__be16 df = 0;
+
+	pr_debug("[QUIC] %s: skb: %p len: %d | path: %pI4:%d -> %pI4:%d\n", __func__, skb, skb->len,
+		 &sa->v4.sin_addr.s_addr, ntohs(sa->v4.sin_port),
+		 &da->v4.sin_addr.s_addr, ntohs(da->v4.sin_port));
+
+	dst = sk_dst_get(sk);
+	if (!dst) {
+		kfree_skb(skb);
+		return;
+	}
+	if (ip_dont_fragment(sk, dst) && !skb->ignore_df)
+		df = htons(IP_DF);
+
+	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, sa->v4.sin_addr.s_addr,
+			    da->v4.sin_addr.s_addr, tos, ip4_dst_hoplimit(dst), df,
+			    sa->v4.sin_port, da->v4.sin_port, false, false);
+}
+
+static void quic_v6_lower_xmit(struct sock *sk, struct sk_buff *skb, union quic_addr *da,
+			       union quic_addr *sa)
+{
+	u8 tclass = (inet6_sk(sk)->tclass | QUIC_SND_CB(skb)->ecn);
+	struct dst_entry *dst = sk_dst_get(sk);
+
+	if (!dst) {
+		kfree_skb(skb);
+		return;
+	}
+	pr_debug("[QUIC] %s: skb: %p len: %d | path: %pI6:%d -> %pI6:%d\n", __func__, skb, skb->len,
+		 &sa->v6.sin6_addr, ntohs(sa->v6.sin6_port),
+		 &da->v6.sin6_addr, ntohs(da->v6.sin6_port));
+
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &sa->v6.sin6_addr, &da->v6.sin6_addr,
+			     tclass, ip6_dst_hoplimit(dst), 0,
+			     sa->v6.sin6_port, da->v6.sin6_port, false);
+}
+
+static void quic_v4_udp_conf_init(struct udp_port_cfg *udp_conf, union quic_addr *a)
+{
+	udp_conf->family = AF_INET;
+	udp_conf->local_ip.s_addr = a->v4.sin_addr.s_addr;
+	udp_conf->local_udp_port = a->v4.sin_port;
+	udp_conf->use_udp6_rx_checksums = true;
+}
+
+static void quic_v6_udp_conf_init(struct udp_port_cfg *udp_conf, union quic_addr *a)
+{
+	udp_conf->family = AF_INET6;
+	udp_conf->local_ip6 = a->v6.sin6_addr;
+	udp_conf->local_udp_port = a->v6.sin6_port;
+	udp_conf->use_udp6_rx_checksums = true;
+}
+
+static void quic_v4_get_msg_addr(union quic_addr *a, struct sk_buff *skb, bool src)
+{
+	struct udphdr *uh = (struct udphdr *)(skb->head + QUIC_RCV_CB(skb)->udph_offset);
+	struct sockaddr_in *sa = &a->v4;
+
+	a->v4.sin_family = AF_INET;
+	if (src) {
+		sa->sin_port = uh->source;
+		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		memset(sa->sin_zero, 0, sizeof(sa->sin_zero));
+		return;
+	}
+
+	sa->sin_port = uh->dest;
+	sa->sin_addr.s_addr = ip_hdr(skb)->daddr;
+	memset(sa->sin_zero, 0, sizeof(sa->sin_zero));
+}
+
+static void quic_v6_get_msg_addr(union quic_addr *a, struct sk_buff *skb, bool src)
+{
+	struct udphdr *uh = (struct udphdr *)(skb->head + QUIC_RCV_CB(skb)->udph_offset);
+	struct sockaddr_in6 *sa = &a->v6;
+
+	a->v6.sin6_family = AF_INET6;
+	a->v6.sin6_flowinfo = 0;
+	a->v6.sin6_scope_id = ((struct inet6_skb_parm *)skb->cb)->iif;
+	if (src) {
+		sa->sin6_port = uh->source;
+		sa->sin6_addr = ipv6_hdr(skb)->saddr;
+		return;
+	}
+
+	sa->sin6_port = uh->dest;
+	sa->sin6_addr = ipv6_hdr(skb)->daddr;
+}
+
+static int quic_v4_get_sk_addr(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	return inet_getname(sock, uaddr, peer);
+}
+
+static int quic_v6_get_sk_addr(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	return inet6_getname(sock, uaddr, peer);
+}
+
+static void quic_v4_set_sk_addr(struct sock *sk, union quic_addr *a, bool src)
+{
+	if (src) {
+		inet_sk(sk)->inet_sport = a->v4.sin_port;
+		inet_sk(sk)->inet_saddr = a->v4.sin_addr.s_addr;
+	} else {
+		inet_sk(sk)->inet_dport = a->v4.sin_port;
+		inet_sk(sk)->inet_daddr = a->v4.sin_addr.s_addr;
+	}
+}
+
+static void quic_v6_set_sk_addr(struct sock *sk, union quic_addr *a, bool src)
+{
+	if (src) {
+		inet_sk(sk)->inet_sport = a->v6.sin6_port;
+		sk->sk_v6_rcv_saddr = a->v6.sin6_addr;
+	} else {
+		inet_sk(sk)->inet_dport = a->v6.sin6_port;
+		sk->sk_v6_daddr = a->v6.sin6_addr;
+	}
+}
+
+static int quic_v4_get_mtu_info(struct sk_buff *skb, u32 *info)
+{
+	struct icmphdr *hdr;
+
+	hdr = (struct icmphdr *)(skb_network_header(skb) - sizeof(struct icmphdr));
+	if (hdr->type == ICMP_DEST_UNREACH && hdr->code == ICMP_FRAG_NEEDED) {
+		*info = ntohs(hdr->un.frag.mtu);
+		return 0;
+	}
+
+	/* can't be handled without outer iphdr known, leave it to udp_err */
+	return 1;
+}
+
+static int quic_v6_get_mtu_info(struct sk_buff *skb, u32 *info)
+{
+	struct icmp6hdr *hdr;
+
+	hdr = (struct icmp6hdr *)(skb_network_header(skb) - sizeof(struct icmp6hdr));
+	if (hdr->icmp6_type == ICMPV6_PKT_TOOBIG) {
+		*info = ntohl(hdr->icmp6_mtu);
+		return 0;
+	}
+
+	/* can't be handled without outer ip6hdr known, leave it to udpv6_err */
+	return 1;
+}
+
+static int quic_v4_get_msg_ecn(struct sk_buff *skb)
+{
+	return (ip_hdr(skb)->tos & INET_ECN_MASK);
+}
+
+static int quic_v6_get_msg_ecn(struct sk_buff *skb)
+{
+	return (ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK);
+}
+
+static void quic_v4_set_sk_ecn(struct sock *sk, u8 ecn)
+{
+	inet_sk(sk)->tos = ((inet_sk(sk)->tos & ~INET_ECN_MASK) | ecn);
+}
+
+static void quic_v6_set_sk_ecn(struct sock *sk, u8 ecn)
+{
+	inet6_sk(sk)->tclass = ((inet6_sk(sk)->tclass & ~INET_ECN_MASK) | ecn);
+}
+
+static struct quic_addr_family_ops quic_af_inet = {
+	.sa_family		= AF_INET,
+	.addr_len		= sizeof(struct sockaddr_in),
+	.iph_len		= sizeof(struct iphdr),
+	.udp_conf_init		= quic_v4_udp_conf_init,
+	.flow_route		= quic_v4_flow_route,
+	.lower_xmit		= quic_v4_lower_xmit,
+	.get_msg_addr		= quic_v4_get_msg_addr,
+	.set_sk_addr		= quic_v4_set_sk_addr,
+	.get_sk_addr		= quic_v4_get_sk_addr,
+	.get_mtu_info		= quic_v4_get_mtu_info,
+	.set_sk_ecn		= quic_v4_set_sk_ecn,
+	.get_msg_ecn		= quic_v4_get_msg_ecn,
+	.setsockopt		= ip_setsockopt,
+	.getsockopt		= ip_getsockopt,
+};
+
+static struct quic_addr_family_ops quic_af_inet6 = {
+	.sa_family		= AF_INET6,
+	.addr_len		= sizeof(struct sockaddr_in6),
+	.iph_len		= sizeof(struct ipv6hdr),
+	.udp_conf_init		= quic_v6_udp_conf_init,
+	.flow_route		= quic_v6_flow_route,
+	.lower_xmit		= quic_v6_lower_xmit,
+	.get_msg_addr		= quic_v6_get_msg_addr,
+	.set_sk_addr		= quic_v6_set_sk_addr,
+	.get_sk_addr		= quic_v6_get_sk_addr,
+	.get_mtu_info		= quic_v6_get_mtu_info,
+	.set_sk_ecn		= quic_v6_set_sk_ecn,
+	.get_msg_ecn		= quic_v6_get_msg_ecn,
+	.setsockopt		= ipv6_setsockopt,
+	.getsockopt		= ipv6_getsockopt,
+};
+
+struct quic_addr_family_ops *quic_af_ops_get(sa_family_t family)
+{
+	switch (family) {
+	case AF_INET:
+		return &quic_af_inet;
+	case AF_INET6:
+		return &quic_af_inet6;
+	default:
+		return NULL;
+	}
+}
+
+static int quic_inet_connect(struct socket *sock, struct sockaddr *addr, int addr_len, int flags)
+{
+	struct sock *sk = sock->sk;
+	const struct proto *prot;
+
+	if (addr_len < sizeof(addr->sa_family))
+		return -EINVAL;
+
+	prot = READ_ONCE(sk->sk_prot);
+
+	return prot->connect(sk, addr, addr_len);
+}
+
+static int quic_inet_listen(struct socket *sock, int backlog)
+{
+	struct quic_connection_id_set *source, *dest;
+	struct quic_connection_id conn_id, *active;
+	struct quic_crypto *crypto;
+	struct quic_outqueue *outq;
+	struct sock *sk = sock->sk;
+	struct quic_inqueue *inq;
+	int err = 0, flag;
+
+	lock_sock(sk);
+
+	crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	source = quic_source(sk);
+	dest = quic_dest(sk);
+
+	sk->sk_max_ack_backlog = backlog;
+	if (!backlog)
+		goto free;
+
+	if (!hlist_unhashed(&quic_sk(sk)->inet.sk.sk_node))
+		goto out;
+	quic_connection_id_generate(&conn_id, 18);
+	err = quic_connection_id_add(dest, &conn_id, 0, NULL);
+	if (err)
+		goto free;
+	quic_connection_id_generate(&conn_id, 16);
+	err = quic_connection_id_add(source, &conn_id, 0, sk);
+	if (err)
+		goto free;
+	err = sk->sk_prot->hash(sk);
+	if (err)
+		goto free;
+	active = quic_connection_id_active(dest);
+	flag = CRYPTO_ALG_ASYNC;
+	outq = quic_outq(sk);
+	quic_outq_set_serv(outq);
+
+	inq = quic_inq(sk);
+	err = quic_crypto_initial_keys_install(crypto, active, quic_inq_version(inq), flag, 1);
+	if (err)
+		goto free;
+	quic_set_state(sk, QUIC_SS_LISTENING);
+out:
+	release_sock(sk);
+	return err;
+free:
+	sk->sk_prot->unhash(sk);
+	quic_crypto_destroy(crypto);
+	quic_connection_id_set_free(dest);
+	quic_connection_id_set_free(source);
+	quic_set_state(sk, QUIC_SS_CLOSED);
+	goto out;
+}
+
+static int quic_inet_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	return quic_af_ops(sock->sk)->get_sk_addr(sock, uaddr, peer);
+}
+
+int quic_encap_len(struct sock *sk)
+{
+	return sizeof(struct udphdr) + quic_af_ops(sk)->iph_len;
+}
+
+int quic_addr_len(struct sock *sk)
+{
+	return quic_af_ops(sk)->addr_len;
+}
+
+int quic_addr_family(struct sock *sk)
+{
+	return quic_af_ops(sk)->sa_family;
+}
+
+void quic_set_sk_addr(struct sock *sk, union quic_addr *a, bool src)
+{
+	return quic_af_ops(sk)->set_sk_addr(sk, a, src);
+}
+
+void quic_get_sk_addr(struct socket *sock, struct sockaddr *a, bool peer)
+{
+	quic_af_ops(sock->sk)->get_sk_addr(sock, a, peer);
+}
+
+void quic_get_msg_addr(struct sock *sk, union quic_addr *addr, struct sk_buff *skb, bool src)
+{
+	quic_af_ops(sk)->get_msg_addr(addr, skb, src);
+}
+
+int quic_get_mtu_info(struct sock *sk, struct sk_buff *skb, u32 *info)
+{
+	return quic_af_ops(sk)->get_mtu_info(skb, info);
+}
+
+void quic_udp_conf_init(struct sock *sk, struct udp_port_cfg *udp_conf, union quic_addr *a)
+{
+	quic_af_ops(sk)->udp_conf_init(udp_conf, a);
+}
+
+void quic_lower_xmit(struct sock *sk, struct sk_buff *skb, union quic_addr *da,
+		     union quic_addr *sa)
+{
+	quic_af_ops(sk)->lower_xmit(sk, skb, da, sa);
+}
+
+int quic_flow_route(struct sock *sk, union quic_addr *da, union quic_addr *sa)
+{
+	return quic_af_ops(sk)->flow_route(sk, da, sa);
+}
+
+int quic_get_msg_ecn(struct sock *sk, struct sk_buff *skb)
+{
+	return quic_af_ops(sk)->get_msg_ecn(skb);
+}
+
+void quic_set_sk_ecn(struct sock *sk, u8 ecn)
+{
+	quic_af_ops(sk)->set_sk_ecn(sk, ecn);
+}
+
+static struct ctl_table quic_table[] = {
+	{
+		.procname	= "quic_mem",
+		.data		= &sysctl_quic_mem,
+		.maxlen		= sizeof(sysctl_quic_mem),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax
+	},
+	{
+		.procname	= "quic_rmem",
+		.data		= &sysctl_quic_rmem,
+		.maxlen		= sizeof(sysctl_quic_rmem),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "quic_wmem",
+		.data		= &sysctl_quic_wmem,
+		.maxlen		= sizeof(sysctl_quic_wmem),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+
+	{ /* sentinel */ }
+};
+
+static const struct proto_ops quic_proto_ops = {
+	.family		   = PF_INET,
+	.owner		   = THIS_MODULE,
+	.release	   = inet_release,
+	.bind		   = inet_bind,
+	.connect	   = quic_inet_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = inet_accept,
+	.getname	   = quic_inet_getname,
+	.poll		   = datagram_poll,
+	.ioctl		   = inet_ioctl,
+	.gettstamp	   = sock_gettstamp,
+	.listen		   = quic_inet_listen,
+	.shutdown	   = inet_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+};
+
+static struct inet_protosw quic_stream_protosw = {
+	.type       = SOCK_STREAM,
+	.protocol   = IPPROTO_QUIC,
+	.prot       = &quic_prot,
+	.ops        = &quic_proto_ops,
+};
+
+static struct inet_protosw quic_seqpacket_protosw = {
+	.type       = SOCK_DGRAM,
+	.protocol   = IPPROTO_QUIC,
+	.prot       = &quic_prot,
+	.ops        = &quic_proto_ops,
+};
+
+static const struct proto_ops quicv6_proto_ops = {
+	.family		   = PF_INET6,
+	.owner		   = THIS_MODULE,
+	.release	   = inet6_release,
+	.bind		   = inet6_bind,
+	.connect	   = quic_inet_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = inet_accept,
+	.getname	   = quic_inet_getname,
+	.poll		   = datagram_poll,
+	.ioctl		   = inet6_ioctl,
+	.gettstamp	   = sock_gettstamp,
+	.listen		   = quic_inet_listen,
+	.shutdown	   = inet_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+};
+
+static struct inet_protosw quicv6_stream_protosw = {
+	.type       = SOCK_STREAM,
+	.protocol   = IPPROTO_QUIC,
+	.prot       = &quicv6_prot,
+	.ops        = &quicv6_proto_ops,
+};
+
+static struct inet_protosw quicv6_seqpacket_protosw = {
+	.type       = SOCK_DGRAM,
+	.protocol   = IPPROTO_QUIC,
+	.prot       = &quicv6_prot,
+	.ops        = &quicv6_proto_ops,
+};
+
+static int quic_protosw_init(void)
+{
+	int err;
+
+	err = proto_register(&quic_prot, 1);
+	if (err)
+		return err;
+
+	err = proto_register(&quicv6_prot, 1);
+	if (err) {
+		proto_unregister(&quic_prot);
+		return err;
+	}
+
+	inet_register_protosw(&quic_stream_protosw);
+	inet_register_protosw(&quic_seqpacket_protosw);
+	inet6_register_protosw(&quicv6_stream_protosw);
+	inet6_register_protosw(&quicv6_seqpacket_protosw);
+
+	return 0;
+}
+
+static void quic_protosw_exit(void)
+{
+	inet_unregister_protosw(&quic_seqpacket_protosw);
+	inet_unregister_protosw(&quic_stream_protosw);
+	proto_unregister(&quic_prot);
+
+	inet6_unregister_protosw(&quicv6_seqpacket_protosw);
+	inet6_unregister_protosw(&quicv6_stream_protosw);
+	proto_unregister(&quicv6_prot);
+}
+
+static int __net_init quic_net_init(struct net *net)
+{
+	return 0;
+}
+
+static void __net_exit quic_net_exit(struct net *net)
+{
+	;
+}
+
+static struct pernet_operations quic_net_ops = {
+	.init = quic_net_init,
+	.exit = quic_net_exit,
+};
+
+static void quic_hash_tables_destroy(void)
+{
+	struct quic_hash_table *ht;
+	int table;
+
+	for (table = 0; table < QUIC_HT_MAX_TABLES; table++) {
+		ht = &quic_hash_tables[table];
+		ht->size = 64;
+		kfree(ht->hash);
+	}
+}
+
+static int quic_hash_tables_init(void)
+{
+	struct quic_hash_head *head;
+	struct quic_hash_table *ht;
+	int table, i;
+
+	for (table = 0; table < QUIC_HT_MAX_TABLES; table++) {
+		ht = &quic_hash_tables[table];
+		ht->size = 64;
+		head = kmalloc_array(ht->size, sizeof(*head), GFP_KERNEL);
+		if (!head) {
+			quic_hash_tables_destroy();
+			return -ENOMEM;
+		}
+		for (i = 0; i < ht->size; i++) {
+			spin_lock_init(&head[i].lock);
+			INIT_HLIST_HEAD(&head[i].head);
+		}
+		ht->hash = head;
+	}
+
+	return 0;
+}
+
+static struct ctl_table_header *quic_sysctl_header;
+
+static void quic_sysctl_register(void)
+{
+	unsigned long limit;
+	int max_share;
+
+	limit = nr_free_buffer_pages() / 8;
+	limit = max(limit, 128UL);
+	sysctl_quic_mem[0] = limit / 4 * 3;
+	sysctl_quic_mem[1] = limit;
+	sysctl_quic_mem[2] = sysctl_quic_mem[0] * 2;
+
+	limit = (sysctl_quic_mem[1]) << (PAGE_SHIFT - 7);
+	max_share = min(4UL * 1024 * 1024, limit);
+
+	sysctl_quic_rmem[0] = PAGE_SIZE;
+	sysctl_quic_rmem[1] = 1500 * SKB_TRUESIZE(1);
+	sysctl_quic_rmem[2] = max(sysctl_quic_rmem[1], max_share);
+
+	sysctl_quic_wmem[0] = PAGE_SIZE;
+	sysctl_quic_wmem[1] = 16 * 1024;
+	sysctl_quic_wmem[2] = max(64 * 1024, max_share);
+
+	quic_sysctl_header = register_net_sysctl(&init_net, "net/quic", quic_table);
+}
+
+static void quic_sysctl_unregister(void)
+{
+	unregister_net_sysctl_table(quic_sysctl_header);
+}
+
+static __init int quic_init(void)
+{
+	int err = -ENOMEM;
+
+	if (quic_hash_tables_init())
+		goto err;
+
+	quic_wq = create_workqueue("quic_workqueue");
+	if (!quic_wq)
+		goto err_wq;
+
+	err = percpu_counter_init(&quic_sockets_allocated, 0, GFP_KERNEL);
+	if (err)
+		goto err_percpu_counter;
+
+	err = quic_protosw_init();
+	if (err)
+		goto err_protosw;
+
+	err = register_pernet_subsys(&quic_net_ops);
+	if (err)
+		goto err_def_ops;
+
+	quic_sysctl_register();
+
+	get_random_bytes(random_data, 32);
+	pr_info("[QUIC] init\n");
+	return 0;
+
+err_def_ops:
+	quic_protosw_exit();
+err_protosw:
+	percpu_counter_destroy(&quic_sockets_allocated);
+err_percpu_counter:
+	destroy_workqueue(quic_wq);
+err_wq:
+	quic_hash_tables_destroy();
+err:
+	pr_err("[QUIC] init error\n");
+	return err;
+}
+
+static __exit void quic_exit(void)
+{
+	quic_sysctl_unregister();
+	unregister_pernet_subsys(&quic_net_ops);
+	quic_protosw_exit();
+	percpu_counter_destroy(&quic_sockets_allocated);
+	destroy_workqueue(quic_wq);
+	quic_hash_tables_destroy();
+	pr_info("[QUIC] exit\n");
+}
+
+module_init(quic_init);
+module_exit(quic_exit);
+
+MODULE_ALIAS("net-pf-" __stringify(PF_INET) "-proto-261");
+MODULE_ALIAS("net-pf-" __stringify(PF_INET6) "-proto-261");
+MODULE_AUTHOR("Xin Long <lucien.xin@gmail.com>");
+MODULE_DESCRIPTION("Support for the QUIC protocol (RFC9000)");
+MODULE_LICENSE("GPL");
diff --git a/net/quic/protocol.h b/net/quic/protocol.h
new file mode 100644
index 000000000000..79ba05854a42
--- /dev/null
+++ b/net/quic/protocol.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+extern struct percpu_counter quic_sockets_allocated;
+extern struct workqueue_struct *quic_wq;
+extern u8 random_data[32];
+
+extern long sysctl_quic_mem[3];
+extern int sysctl_quic_rmem[3];
+extern int sysctl_quic_wmem[3];
+
+struct quic_addr_family_ops {
+	sa_family_t sa_family;
+	int	addr_len;
+	int	iph_len;
+
+	void	(*udp_conf_init)(struct udp_port_cfg *udp_config, union quic_addr *addr);
+	int	(*flow_route)(struct sock *sk, union quic_addr *da, union quic_addr *sa);
+	void	(*lower_xmit)(struct sock *sk, struct sk_buff *skb, union quic_addr *da,
+			      union quic_addr *sa);
+
+	void	(*get_msg_addr)(union quic_addr *addr, struct sk_buff *skb, bool src);
+	void	(*set_sk_addr)(struct sock *sk, union quic_addr *addr, bool src);
+	int	(*get_sk_addr)(struct socket *sock, struct sockaddr *addr, int peer);
+	int	(*get_mtu_info)(struct sk_buff *skb, u32 *info);
+
+	void	(*set_sk_ecn)(struct sock *sk, u8 ecn);
+	int	(*get_msg_ecn)(struct sk_buff *skb);
+
+	int	(*setsockopt)(struct sock *sk, int level, int optname, sockptr_t optval,
+			      unsigned int optlen);
+	int	(*getsockopt)(struct sock *sk, int level, int optname, char __user *optval,
+			      int __user *optlen);
+};
+
+int quic_encap_len(struct sock *sk);
+int quic_addr_len(struct sock *sk);
+int quic_addr_family(struct sock *sk);
+int quic_get_mtu_info(struct sock *sk, struct sk_buff *skb, u32 *info);
+int quic_get_msg_ecn(struct sock *sk, struct sk_buff *skb);
+void quic_set_sk_ecn(struct sock *sk, u8 ecn);
+void quic_set_sk_addr(struct sock *sk, union quic_addr *a, bool src);
+void quic_get_sk_addr(struct socket *sock, struct sockaddr *a, bool peer);
+void quic_get_msg_addr(struct sock *sk, union quic_addr *addr, struct sk_buff *skb, bool src);
+void quic_udp_conf_init(struct sock *sk, struct udp_port_cfg *udp_conf, union quic_addr *a);
+void quic_lower_xmit(struct sock *sk, struct sk_buff *skb, union quic_addr *da,
+		     union quic_addr *sa);
+int quic_flow_route(struct sock *sk, union quic_addr *da, union quic_addr *sa);
+struct quic_addr_family_ops *quic_af_ops_get(sa_family_t family);
diff --git a/net/quic/sample_test.c b/net/quic/sample_test.c
new file mode 100644
index 000000000000..21e68e1e2cd0
--- /dev/null
+++ b/net/quic/sample_test.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is kernel test of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <uapi/linux/quic.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/inet.h>
+#include <linux/net.h>
+#include <linux/delay.h>
+#include <linux/completion.h>
+#include <net/handshake.h>
+#include <net/sock.h>
+
+#define ROLE_LEN	10
+#define IP_LEN		20
+#define ALPN_LEN	20
+
+static char role[ROLE_LEN] = "client";
+static char ip[IP_LEN] = "127.0.0.1";
+static int port = 1234;
+static char alpn[ALPN_LEN] = "sample";
+
+#define SND_MSG_LEN	4096
+#define RCV_MSG_LEN	(4096 * 16)
+#define TOT_LEN		(1 * 1024 * 1024 * 1024)
+
+static char	snd_msg[SND_MSG_LEN];
+static char	rcv_msg[RCV_MSG_LEN];
+
+static int quic_test_recvmsg(struct socket *sock, void *msg, int len, u64 *sid, int *flag)
+{
+	char incmsg[CMSG_SPACE(sizeof(struct quic_stream_info))];
+	struct quic_stream_info *rinfo = CMSG_DATA(incmsg);
+	struct msghdr inmsg;
+	struct kvec iov;
+	int error;
+
+	iov.iov_base = msg;
+	iov.iov_len = len;
+
+	memset(&inmsg, 0, sizeof(inmsg));
+	inmsg.msg_control = incmsg;
+	inmsg.msg_controllen = sizeof(incmsg);
+
+	error = kernel_recvmsg(sock, &inmsg, &iov, 1, len, 0);
+	if (error < 0)
+		return error;
+
+	if (!sid)
+		return error;
+
+	*sid = rinfo->stream_id;
+	*flag = rinfo->stream_flag;
+	return error;
+}
+
+static int quic_test_sendmsg(struct socket *sock, const void *msg, int len, u64 sid, int flag)
+{
+	char outcmsg[CMSG_SPACE(sizeof(struct quic_stream_info))];
+	struct quic_stream_info *sinfo;
+	struct msghdr outmsg;
+	struct cmsghdr *cmsg;
+	struct kvec iov;
+
+	iov.iov_base = (void *)msg;
+	iov.iov_len = len;
+
+	memset(&outmsg, 0, sizeof(outmsg));
+	outmsg.msg_control = outcmsg;
+	outmsg.msg_controllen = sizeof(outcmsg);
+
+	cmsg = CMSG_FIRSTHDR(&outmsg);
+	cmsg->cmsg_level = IPPROTO_QUIC;
+	cmsg->cmsg_type = 0;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct quic_stream_info));
+
+	outmsg.msg_controllen = cmsg->cmsg_len;
+	sinfo = (struct quic_stream_info *)CMSG_DATA(cmsg);
+	memset(sinfo, 0, sizeof(struct quic_stream_info));
+	sinfo->stream_id = sid;
+	sinfo->stream_flag = flag;
+
+	return kernel_sendmsg(sock, &outmsg, &iov, 1, len);
+}
+
+struct quic_test_priv {
+	struct completion sk_handshake_done;
+	struct file *filp;
+	int status;
+};
+
+static void quic_test_handshake_done(void *data, int status, key_serial_t peerid)
+{
+	struct quic_test_priv *priv = data;
+
+	priv->status = status;
+	complete_all(&priv->sk_handshake_done);
+}
+
+static int quic_test_client_handshake(struct socket *sock, struct quic_test_priv *priv)
+{
+	struct tls_handshake_args args = {};
+	int err;
+
+	err = sock_common_setsockopt(sock, SOL_QUIC, QUIC_SOCKOPT_ALPN,
+				     KERNEL_SOCKPTR(alpn), strlen(alpn) + 1);
+	if (err)
+		return err;
+
+	init_completion(&priv->sk_handshake_done);
+
+	args.ta_sock = sock;
+	args.ta_done = quic_test_handshake_done;
+	args.ta_data = priv;
+	args.ta_peername = "server.test";
+	args.ta_timeout_ms = 3000;
+	err = tls_client_hello_x509(&args, GFP_KERNEL);
+	if (err)
+		return err;
+	err = wait_for_completion_interruptible_timeout(&priv->sk_handshake_done, 5 * HZ);
+	if (err <= 0) {
+		tls_handshake_cancel(sock->sk);
+		return -EINVAL;
+	}
+	return priv->status;
+}
+
+static int quic_test_server_handshake(struct socket *sock, struct quic_test_priv *priv)
+{
+	struct tls_handshake_args args = {};
+	int err;
+
+	err = sock_common_setsockopt(sock, SOL_QUIC, QUIC_SOCKOPT_ALPN,
+				     KERNEL_SOCKPTR(alpn), strlen(alpn) + 1);
+	if (err)
+		return err;
+
+	init_completion(&priv->sk_handshake_done);
+
+	args.ta_sock = sock;
+	args.ta_done = quic_test_handshake_done;
+	args.ta_data = priv;
+	args.ta_timeout_ms = 3000;
+	err = tls_server_hello_x509(&args, GFP_KERNEL);
+	if (err)
+		return err;
+	err = wait_for_completion_interruptible_timeout(&priv->sk_handshake_done, 5 * HZ);
+	if (err <= 0) {
+		tls_handshake_cancel(sock->sk);
+		return -EINVAL;
+	}
+	return priv->status;
+}
+
+static int quic_test_do_client(void)
+{
+	struct quic_test_priv priv = {};
+	struct sockaddr_in ra = {};
+	u64 len = 0, sid = 0, rate;
+	struct socket *sock;
+	int err, flag = 0;
+	u32 start, end;
+
+	err = __sock_create(&init_net, PF_INET, SOCK_DGRAM, IPPROTO_QUIC, &sock, 1);
+	if (err < 0)
+		return err;
+	priv.filp = sock_alloc_file(sock, 0, NULL);
+	if (IS_ERR(priv.filp))
+		return PTR_ERR(priv.filp);
+
+	ra.sin_family = AF_INET;
+	ra.sin_port = htons((u16)port);
+	if (!in4_pton(ip, strlen(ip), (u8 *)&ra.sin_addr.s_addr, -1, NULL))
+		goto free;
+	err = kernel_connect(sock, (struct sockaddr *)&ra, sizeof(ra), 0);
+	if (err < 0)
+		goto free;
+
+	err = quic_test_client_handshake(sock, &priv);
+	if (err < 0)
+		goto free;
+
+	start = jiffies_to_msecs(jiffies);
+	flag = QUIC_STREAM_FLAG_NEW; /* open stream when send first msg */
+	err = quic_test_sendmsg(sock, snd_msg, SND_MSG_LEN, sid, flag);
+	if (err < 0) {
+		pr_info("send %d\n", err);
+		goto free;
+	}
+	len += err;
+	flag = 0;
+	while (1) {
+		err = quic_test_sendmsg(sock, snd_msg, SND_MSG_LEN, sid, flag);
+		if (err < 0) {
+			pr_info("send %d\n", err);
+			goto free;
+		}
+		len += err;
+		if (!(len % (SND_MSG_LEN * 1024)))
+			pr_info("  send len: %lld, stream_id: %lld, flag: %d.\n", len, sid, flag);
+		if (len > TOT_LEN - SND_MSG_LEN)
+			break;
+	}
+	flag = QUIC_STREAM_FLAG_FIN; /* close stream when send last msg */
+	err = quic_test_sendmsg(sock, snd_msg, SND_MSG_LEN, sid, flag);
+	if (err < 0) {
+		pr_info("send %d\n", err);
+		goto free;
+	}
+	pr_info("SEND DONE: tot_len: %lld, stream_id: %lld, flag: %d.\n", len, sid, flag);
+
+	memset(rcv_msg, 0, sizeof(rcv_msg));
+	err = quic_test_recvmsg(sock, rcv_msg, RCV_MSG_LEN, &sid, &flag);
+	if (err < 0) {
+		pr_info("recv error %d\n", err);
+		goto free;
+	}
+	end = jiffies_to_msecs(jiffies);
+	start = (end - start);
+	rate = ((u64)TOT_LEN * 8 * 1000) / 1024 / 1024 / start;
+	pr_info("ALL RECVD: %llu Mbits/sec\n", rate);
+	err = 0;
+free:
+	fput(priv.filp);
+	return err;
+}
+
+static int quic_test_do_server(void)
+{
+	struct quic_test_priv priv = {};
+	struct socket *sock, *newsock;
+	struct sockaddr_in la = {};
+	u64 len = 0, sid = 0;
+	int err, flag = 0;
+
+	err = __sock_create(&init_net, PF_INET, SOCK_DGRAM, IPPROTO_QUIC, &sock, 1);
+	if (err < 0)
+		return err;
+
+	la.sin_family = AF_INET;
+	la.sin_port = htons((u16)port);
+	if (!in4_pton(ip, strlen(ip), (u8 *)&la.sin_addr.s_addr, -1, NULL))
+		goto free;
+	err = kernel_bind(sock, (struct sockaddr *)&la, sizeof(la));
+	if (err < 0)
+		goto free;
+
+	err = kernel_listen(sock, 1);
+	if (err < 0)
+		goto free;
+	err = kernel_accept(sock, &newsock, 0);
+	if (err < 0)
+		goto free;
+
+	/* attach a file for user space to operate */
+	priv.filp = sock_alloc_file(newsock, 0, NULL);
+	if (IS_ERR(priv.filp)) {
+		err = PTR_ERR(priv.filp);
+		goto free;
+	}
+
+	/* do handshake with net/handshake APIs */
+	err = quic_test_server_handshake(newsock, &priv);
+	if (err < 0)
+		goto free_flip;
+
+	pr_info("HANDSHAKE DONE\n");
+
+	while (1) {
+		err = quic_test_recvmsg(newsock, &rcv_msg, sizeof(rcv_msg), &sid, &flag);
+		if (err < 0) {
+			pr_info("recv error %d\n", err);
+			goto free_flip;
+		}
+		len += err;
+		usleep_range(20, 40);
+		if (flag & QUIC_STREAM_FLAG_FIN)
+			break;
+		pr_info("  recv len: %lld, stream_id: %lld, flag: %d.\n", len, sid, flag);
+	}
+
+	pr_info("RECV DONE: tot_len %lld, stream_id: %lld, flag: %d.\n", len, sid, flag);
+
+	flag = QUIC_STREAM_FLAG_FIN;
+	strscpy(snd_msg, "recv done", sizeof(snd_msg));
+	err = quic_test_sendmsg(newsock, snd_msg, strlen(snd_msg), sid, flag);
+	if (err < 0) {
+		pr_info("send %d\n", err);
+		goto free_flip;
+	}
+	msleep(100);
+	err = 0;
+free_flip:
+	fput(priv.filp);
+free:
+	sock_release(sock);
+	return err;
+}
+
+static int quic_test_init(void)
+{
+	pr_info("[QUIC_TEST] Quic Test Start\n");
+	if (!strcmp(role, "client"))
+		return quic_test_do_client();
+	if (!strcmp(role, "server"))
+		return quic_test_do_server();
+	return -EINVAL;
+}
+
+static void quic_test_exit(void)
+{
+	pr_info("[QUIC_TEST] Quic Test Exit\n");
+}
+
+module_init(quic_test_init);
+module_exit(quic_test_exit);
+
+module_param_string(role, role, ROLE_LEN, 0644);
+module_param_string(alpn, alpn, ALPN_LEN, 0644);
+module_param_string(ip, ip, IP_LEN, 0644);
+module_param_named(port, port, int, 0644);
+
+MODULE_PARM_DESC(role, "client or server");
+MODULE_PARM_DESC(ip, "server address");
+MODULE_PARM_DESC(port, "server port");
+MODULE_PARM_DESC(alpn, "alpn name");
+
+MODULE_AUTHOR("Xin Long <lucien.xin@gmail.com>");
+MODULE_DESCRIPTION("Test For Support for the QUIC protocol (RFC9000)");
+MODULE_LICENSE("GPL");
diff --git a/net/quic/socket.c b/net/quic/socket.c
new file mode 100644
index 000000000000..fb50fe50c2b2
--- /dev/null
+++ b/net/quic/socket.c
@@ -0,0 +1,1823 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include "frame.h"
+#include <net/inet_common.h>
+#include <linux/version.h>
+
+static DEFINE_PER_CPU(int, quic_memory_per_cpu_fw_alloc);
+static unsigned long quic_memory_pressure;
+static atomic_long_t quic_memory_allocated;
+
+static void quic_enter_memory_pressure(struct sock *sk)
+{
+	WRITE_ONCE(quic_memory_pressure, 1);
+}
+
+#define QUIC_VERSION_NUM	2
+
+static u32 quic_versions[QUIC_VERSION_NUM][2] = {
+	/* version,	compatible versions */
+	{ QUIC_VERSION_V1,	0 },
+	{ QUIC_VERSION_V2,	0 },
+};
+
+u32 *quic_compatible_versions(u32 version)
+{
+	u8 i;
+
+	for (i = 0; i < QUIC_VERSION_NUM; i++)
+		if (version == quic_versions[i][0])
+			return quic_versions[i];
+	return NULL;
+}
+
+int quic_select_version(struct sock *sk, u32 *versions, u8 count)
+{
+	u32 best = 0;
+	u8 i, j;
+
+	for (i = 0; i < count; i++) {
+		for (j = 0; j < QUIC_VERSION_NUM; j++) {
+			if (versions[i] == quic_versions[j][0] && best < versions[i]) {
+				best = versions[i];
+				break;
+			}
+		}
+	}
+	if (!best)
+		return -1;
+
+	quic_inq_set_version(quic_inq(sk), best);
+	return 0;
+}
+
+bool quic_request_sock_exists(struct sock *sk, union quic_addr *sa, union quic_addr *da)
+{
+	struct quic_request_sock *req;
+
+	list_for_each_entry(req, quic_reqs(sk), list) {
+		if (!memcmp(&req->sa, sa, quic_addr_len(sk)) &&
+		    !memcmp(&req->da, da, quic_addr_len(sk)))
+			return true;
+	}
+	return false;
+}
+
+int quic_request_sock_enqueue(struct sock *sk, struct quic_request_sock *nreq)
+{
+	struct quic_request_sock *req;
+
+	if (sk_acceptq_is_full(sk))
+		return -ENOMEM;
+
+	req = kzalloc(sizeof(*req), GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+
+	*req = *nreq;
+	list_add_tail(&req->list, quic_reqs(sk));
+	sk_acceptq_added(sk);
+	return 0;
+}
+
+struct quic_request_sock *quic_request_sock_dequeue(struct sock *sk)
+{
+	struct quic_request_sock *req;
+
+	req = list_first_entry(quic_reqs(sk), struct quic_request_sock, list);
+
+	list_del_init(&req->list);
+	sk_acceptq_removed(sk);
+	return req;
+}
+
+struct sock *quic_sock_lookup(struct sk_buff *skb, union quic_addr *sa, union quic_addr *da)
+{
+	struct net *net = dev_net(skb->dev);
+	struct sock *sk, *nsk = NULL;
+	struct quic_hash_head *head;
+	union quic_addr a = {};
+
+	head = quic_listen_sock_head(net, sa);
+	spin_lock(&head->lock);
+	sk_for_each(sk,  &head->head) {
+		if (net != sock_net(sk))
+			continue;
+		if (quic_path_cmp(quic_src(sk), 0, sa))
+			continue;
+		if (quic_is_listen(sk)) {
+			nsk = sk;
+			continue;
+		}
+		if (!quic_path_cmp(quic_dst(sk), 0, da)) {
+			nsk = sk;
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+	if (nsk)
+		return nsk;
+
+	/* Search for socket binding to the same port with 0.0.0.0 or :: address */
+	a.v4.sin_family = sa->v4.sin_family;
+	a.v4.sin_port = sa->v4.sin_port;
+	sa = &a;
+	head = quic_listen_sock_head(net, sa);
+	spin_lock(&head->lock);
+	sk_for_each(sk,  &head->head) {
+		if (net != sock_net(sk))
+			continue;
+		if (quic_path_cmp(quic_src(sk), 0, sa))
+			continue;
+		if (quic_is_listen(sk)) {
+			nsk = sk;
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+	return nsk;
+}
+
+static void quic_write_space(struct sock *sk)
+{
+	struct socket_wq *wq;
+
+	rcu_read_lock();
+	wq = rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+	rcu_read_unlock();
+}
+
+static void quic_transport_param_init(struct sock *sk)
+{
+	struct quic_transport_param *param = quic_local(sk);
+
+	param->max_udp_payload_size = 65527;
+	param->ack_delay_exponent = 3;
+	param->max_ack_delay = 25000;
+	param->active_connection_id_limit = 7;
+	param->max_idle_timeout = 30000000;
+	param->max_data = sk->sk_rcvbuf / 2;
+	param->max_stream_data_bidi_local = sk->sk_rcvbuf / 4;
+	param->max_stream_data_bidi_remote = sk->sk_rcvbuf / 4;
+	param->max_stream_data_uni = sk->sk_rcvbuf / 4;
+	param->max_streams_bidi = 100;
+	param->max_streams_uni = 100;
+	param->initial_smoothed_rtt = 333000;
+	param->version = QUIC_VERSION_V1;
+
+	quic_inq_set_param(sk, param);
+	quic_cong_set_param(quic_cong(sk), param);
+	quic_connection_id_set_param(quic_dest(sk), param);
+	quic_stream_set_param(quic_streams(sk), param, NULL);
+}
+
+static int quic_init_sock(struct sock *sk)
+{
+	u8 len, i;
+
+	quic_set_af_ops(sk, quic_af_ops_get(sk->sk_family));
+	quic_connection_id_set_init(quic_source(sk), 1);
+	quic_connection_id_set_init(quic_dest(sk), 0);
+
+	len = quic_addr_len(sk);
+	quic_path_addr_init(quic_src(sk), len, 1);
+	quic_path_addr_init(quic_dst(sk), len, 0);
+
+	quic_transport_param_init(sk);
+
+	quic_outq_init(sk);
+	quic_inq_init(sk);
+	quic_packet_init(sk);
+	quic_timer_init(sk);
+
+	sk->sk_destruct = inet_sock_destruct;
+	sk->sk_write_space = quic_write_space;
+	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
+
+	for (i = 0; i < QUIC_CRYPTO_MAX; i++) {
+		if (quic_pnmap_init(quic_pnmap(sk, i)))
+			return -ENOMEM;
+	}
+	if (quic_stream_init(quic_streams(sk)))
+		return -ENOMEM;
+	INIT_LIST_HEAD(quic_reqs(sk));
+
+	local_bh_disable();
+	sk_sockets_allocated_inc(sk);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+	local_bh_enable();
+
+	return 0;
+}
+
+static void quic_destroy_sock(struct sock *sk)
+{
+	u8 i;
+
+	for (i = 0; i < QUIC_CRYPTO_MAX; i++) {
+		quic_pnmap_free(quic_pnmap(sk, i));
+		quic_crypto_destroy(quic_crypto(sk, i));
+	}
+
+	quic_timer_free(sk);
+	quic_stream_free(quic_streams(sk));
+
+	kfree(quic_token(sk)->data);
+	kfree(quic_ticket(sk)->data);
+	kfree(quic_alpn(sk)->data);
+
+	local_bh_disable();
+	sk_sockets_allocated_dec(sk);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	local_bh_enable();
+}
+
+static int quic_bind(struct sock *sk, struct sockaddr *addr, int addr_len)
+{
+	struct quic_path_addr *path = quic_src(sk);
+	union quic_addr *a;
+	int err = 0;
+
+	lock_sock(sk);
+
+	a = quic_path_addr(path, 0);
+	if (a->v4.sin_port || addr_len < quic_addr_len(sk) ||
+	    addr->sa_family != sk->sk_family || !quic_addr(addr)->v4.sin_port) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	quic_path_addr_set(path, quic_addr(addr), 0);
+	err = quic_path_set_bind_port(sk, path, 0);
+	if (err) {
+		quic_path_addr_free(sk, path, 0);
+		goto out;
+	}
+	err = quic_path_set_udp_sock(sk, path, 0);
+	if (err) {
+		quic_path_addr_free(sk, path, 0);
+		goto out;
+	}
+	quic_set_sk_addr(sk, a, true);
+
+out:
+	release_sock(sk);
+	return err;
+}
+
+static int quic_connect(struct sock *sk, struct sockaddr *addr, int addr_len)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_connection_id_set *source = quic_source(sk);
+	struct quic_connection_id_set *dest = quic_dest(sk);
+	struct quic_path_addr *path = quic_src(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_id conn_id, *active;
+	struct quic_inqueue *inq = quic_inq(sk);
+	union quic_addr *sa;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	if (!quic_is_closed(sk) || addr_len < quic_addr_len(sk))
+		goto out;
+
+	quic_path_addr_set(quic_dst(sk), quic_addr(addr), 0);
+	err = quic_packet_route(sk);
+	if (err < 0)
+		goto out;
+	quic_set_sk_addr(sk, quic_addr(addr), false);
+	sa = quic_path_addr(path, 0);
+	if (!sa->v4.sin_port) { /* auto bind */
+		err = quic_path_set_bind_port(sk, path, 0);
+		if (err) {
+			quic_path_addr_free(sk, path, 0);
+			goto out;
+		}
+		err = quic_path_set_udp_sock(sk, path, 0);
+		if (err) {
+			quic_path_addr_free(sk, path, 0);
+			goto out;
+		}
+		quic_set_sk_addr(sk, sa, true);
+	}
+
+	quic_connection_id_generate(&conn_id, 18);
+	err = quic_connection_id_add(dest, &conn_id, 0, NULL);
+	if (err)
+		goto out;
+	quic_outq_set_orig_dcid(outq, &conn_id);
+	quic_connection_id_generate(&conn_id, 16);
+	err = quic_connection_id_add(source, &conn_id, 0, sk);
+	if (err)
+		goto free;
+	err = sk->sk_prot->hash(sk);
+	if (err)
+		goto free;
+	active = quic_connection_id_active(dest);
+	err = quic_crypto_initial_keys_install(crypto, active, quic_inq_version(inq), 0, 0);
+	if (err)
+		goto free;
+
+	quic_set_state(sk, QUIC_SS_ESTABLISHING);
+out:
+	release_sock(sk);
+	return err;
+free:
+	quic_connection_id_set_free(dest);
+	quic_connection_id_set_free(source);
+	sk->sk_prot->unhash(sk);
+	goto out;
+}
+
+static int quic_hash(struct sock *sk)
+{
+	union quic_addr *saddr, *daddr;
+	struct quic_hash_head *head;
+	struct sock *nsk;
+	int err = 0;
+
+	saddr = quic_path_addr(quic_src(sk), 0);
+	daddr = quic_path_addr(quic_dst(sk), 0);
+	head = quic_listen_sock_head(sock_net(sk), saddr);
+	spin_lock(&head->lock);
+
+	sk_for_each(nsk,  &head->head) {
+		if (sock_net(sk) == sock_net(nsk) &&
+		    !quic_path_cmp(quic_src(nsk), 0, saddr) &&
+		    !quic_path_cmp(quic_dst(nsk), 0, daddr)) {
+			err = -EADDRINUSE;
+			goto out;
+		}
+	}
+
+	__sk_add_node(sk, &head->head);
+out:
+	spin_unlock(&head->lock);
+	return err;
+}
+
+static void quic_unhash(struct sock *sk)
+{
+	struct quic_hash_head *head;
+	union quic_addr *addr;
+
+	if (sk_unhashed(sk))
+		return;
+
+	addr = quic_path_addr(quic_src(sk), 0);
+	head = quic_listen_sock_head(sock_net(sk), addr);
+	spin_lock(&head->lock);
+	__sk_del_node_init(sk);
+	spin_unlock(&head->lock);
+}
+
+static int quic_msghdr_parse(struct sock *sk, struct msghdr *msg, struct quic_handshake_info *hinfo,
+			     struct quic_stream_info *sinfo, bool *has_hinfo)
+{
+	struct quic_handshake_info *i = NULL;
+	struct quic_stream_info *s = NULL;
+	struct quic_stream_table *streams;
+	struct cmsghdr *cmsg;
+	u64 active;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			return -EINVAL;
+
+		if (cmsg->cmsg_level != IPPROTO_QUIC)
+			continue;
+
+		switch (cmsg->cmsg_type) {
+		case QUIC_HANDSHAKE_INFO:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(*i)))
+				return -EINVAL;
+			i = CMSG_DATA(cmsg);
+			hinfo->crypto_level = i->crypto_level;
+			*has_hinfo = true;
+			break;
+		case QUIC_STREAM_INFO:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(*s)))
+				return -EINVAL;
+			s = CMSG_DATA(cmsg);
+			sinfo->stream_id = s->stream_id;
+			sinfo->stream_flag = s->stream_flag;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	if (i)
+		return 0;
+
+	if (!s) { /* stream info is not set, try to use msg_flags*/
+		if (msg->msg_flags & MSG_SYN)
+			sinfo->stream_flag |= QUIC_STREAM_FLAG_NEW;
+		if (msg->msg_flags & MSG_FIN)
+			sinfo->stream_flag |= QUIC_STREAM_FLAG_FIN;
+		if (msg->msg_flags & MSG_STREAM_UNI)
+			sinfo->stream_flag |= QUIC_STREAM_FLAG_UNI;
+		if (msg->msg_flags & MSG_DONTWAIT)
+			sinfo->stream_flag |= QUIC_STREAM_FLAG_ASYNC;
+		if (msg->msg_flags & MSG_DATAGRAM)
+			sinfo->stream_flag |= QUIC_STREAM_FLAG_DATAGRAM;
+		sinfo->stream_id = -1;
+	}
+
+	if (sinfo->stream_id != -1)
+		return 0;
+
+	streams = quic_streams(sk);
+	active = quic_stream_send_active(streams);
+	if (active != -1) {
+		sinfo->stream_id = active;
+		return 0;
+	}
+	sinfo->stream_id = (quic_stream_send_bidi(streams) << 2);
+	if (sinfo->stream_flag & QUIC_STREAM_FLAG_UNI) {
+		sinfo->stream_id = (quic_stream_send_uni(streams) << 2);
+		sinfo->stream_id |= QUIC_STREAM_TYPE_UNI_MASK;
+	}
+	sinfo->stream_id |= quic_is_serv(sk);
+	return 0;
+}
+
+static int quic_wait_for_send(struct sock *sk, u64 stream_id, long timeo, u32 msg_len)
+{
+	for (;;) {
+		int err = 0, exit = 1;
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait_exclusive(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
+		if (!timeo) {
+			err = -EAGAIN;
+			goto out;
+		}
+		if (sk->sk_err) {
+			err = sk->sk_err;
+			pr_warn("wait sndbuf sk_err %d\n", err);
+			goto out;
+		}
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			goto out;
+		}
+		if (quic_is_closed(sk)) {
+			err = -EPIPE;
+			pr_warn("wait sndbuf closed %d\n", err);
+			goto out;
+		}
+
+		if (stream_id) {
+			if (!quic_stream_id_send_exceeds(quic_streams(sk), stream_id))
+				goto out;
+		} else {
+			if ((int)msg_len <= sk_stream_wspace(sk) &&
+			    sk_wmem_schedule(sk, msg_len))
+				goto out;
+		}
+
+		exit = 0;
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+out:
+		finish_wait(sk_sleep(sk), &wait);
+		if (exit)
+			return err;
+	}
+}
+
+static struct quic_stream *quic_sock_send_stream(struct sock *sk, struct quic_stream_info *sinfo)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_APP);
+	struct quic_stream_table *streams = quic_streams(sk);
+	u8 type = QUIC_FRAME_STREAMS_BLOCKED_BIDI;
+	struct quic_stream *stream;
+	struct sk_buff *skb;
+	long timeo;
+	int err;
+
+	stream = quic_stream_send_get(streams, sinfo->stream_id,
+				      sinfo->stream_flag, quic_is_serv(sk));
+	if (!IS_ERR(stream)) {
+		if (stream->send.state >= QUIC_STREAM_SEND_STATE_SENT)
+			return ERR_PTR(-EINVAL);
+		return stream;
+	} else if (PTR_ERR(stream) != -EAGAIN) {
+		return stream;
+	}
+
+	/* 0rtt data should return err if stream is not found */
+	if (!quic_crypto_send_ready(crypto))
+		return ERR_PTR(-EINVAL);
+
+	if (sinfo->stream_id & QUIC_STREAM_TYPE_UNI_MASK)
+		type = QUIC_FRAME_STREAMS_BLOCKED_UNI;
+
+	skb = quic_frame_create(sk, type, &sinfo->stream_id);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+	quic_outq_ctrl_tail(sk, skb, false);
+
+	timeo = sock_sndtimeo(sk, sinfo->stream_flag & QUIC_STREAM_FLAG_ASYNC);
+	err = quic_wait_for_send(sk, sinfo->stream_id, timeo, 0);
+	if (err)
+		return ERR_PTR(err);
+
+	return quic_stream_send_get(streams, sinfo->stream_id,
+				    sinfo->stream_flag, quic_is_serv(sk));
+}
+
+static int quic_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
+{
+	struct quic_handshake_info hinfo = {};
+	struct quic_stream_info sinfo = {};
+	struct quic_msginfo msginfo;
+	struct quic_crypto *crypto;
+	struct quic_stream *stream;
+	bool has_hinfo = false;
+	struct sk_buff *skb;
+	int err = 0;
+	long timeo;
+
+	lock_sock(sk);
+	err = quic_msghdr_parse(sk, msg, &hinfo, &sinfo, &has_hinfo);
+	if (err)
+		goto err;
+
+	if (has_hinfo) {
+		if (hinfo.crypto_level >= QUIC_CRYPTO_MAX) {
+			err = -EINVAL;
+			goto err;
+		}
+		crypto = quic_crypto(sk, hinfo.crypto_level);
+		if (!quic_crypto_send_ready(crypto)) {
+			err = -EINVAL;
+			goto err;
+		}
+		msginfo.level = hinfo.crypto_level;
+		msginfo.msg = &msg->msg_iter;
+		while (iov_iter_count(&msg->msg_iter) > 0) {
+			skb = quic_frame_create(sk, QUIC_FRAME_CRYPTO, &msginfo);
+			if (!skb)
+				goto out;
+			quic_outq_ctrl_tail(sk, skb, true);
+		}
+		goto out;
+	}
+
+	if (sinfo.stream_flag & QUIC_STREAM_FLAG_DATAGRAM) {
+		if (!quic_outq_max_dgram(quic_outq(sk))) {
+			err = -EINVAL;
+			goto err;
+		}
+		if (sk_stream_wspace(sk) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
+			timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+			err = quic_wait_for_send(sk, 0, timeo, msg_len);
+			if (err)
+				goto err;
+		}
+		while (iov_iter_count(&msg->msg_iter) > 0) {
+			skb = quic_frame_create(sk, QUIC_FRAME_DATAGRAM_LEN, &msg->msg_iter);
+			if (!skb)
+				goto out;
+			quic_outq_dgram_tail(sk, skb, true);
+		}
+		goto out;
+	}
+
+	stream = quic_sock_send_stream(sk, &sinfo);
+	if (IS_ERR(stream)) {
+		err = PTR_ERR(stream);
+		goto err;
+	}
+
+	if (sk_stream_wspace(sk) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
+		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+		err = quic_wait_for_send(sk, 0, timeo, msg_len);
+		if (err)
+			goto err;
+	}
+
+	msginfo.stream = stream;
+	msginfo.msg = &msg->msg_iter;
+	msginfo.flag = sinfo.stream_flag;
+
+	while (iov_iter_count(msginfo.msg) > 0) {
+		skb = quic_frame_create(sk, QUIC_FRAME_STREAM, &msginfo);
+		if (!skb)
+			goto out;
+		quic_outq_data_tail(sk, skb, true);
+	}
+out:
+	err = msg_len - iov_iter_count(&msg->msg_iter);
+	if (!(msg->msg_flags & MSG_MORE) && err)
+		quic_outq_flush(sk);
+err:
+	release_sock(sk);
+	return err;
+}
+
+static int quic_wait_for_packet(struct sock *sk, long timeo)
+{
+	for (;;) {
+		int err = 0, exit = 1;
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait_exclusive(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
+
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			goto out;
+
+		err = sk->sk_err;
+		if (err) {
+			pr_warn("wait rcv pkt sk_err %d\n", err);
+			goto out;
+		}
+
+		err = -ENOTCONN;
+		if (quic_is_closed(sk))
+			goto out;
+
+		err = -EAGAIN;
+		if (!timeo)
+			goto out;
+
+		err = sock_intr_errno(timeo);
+		if (signal_pending(current))
+			goto out;
+
+		exit = 0;
+		release_sock(sk);
+		timeo = schedule_timeout(timeo);
+		lock_sock(sk);
+out:
+		finish_wait(sk_sleep(sk), &wait);
+		if (exit)
+			return err;
+	}
+}
+
+static int quic_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
+			int *addr_len)
+{
+	int nonblock = flags & MSG_DONTWAIT;
+	struct quic_handshake_info hinfo = {};
+	int err, copy, copied = 0, freed = 0;
+	struct quic_stream_info sinfo = {};
+	int fin, off, event, dgram, level;
+	struct quic_rcv_cb *rcv_cb;
+	struct quic_stream *stream;
+	struct quic_inqueue *inq;
+	struct sk_buff *skb;
+	long timeo;
+
+	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, nonblock);
+	err = quic_wait_for_packet(sk, timeo);
+	if (err)
+		goto out;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	rcv_cb = QUIC_RCV_CB(skb);
+	stream = rcv_cb->stream;
+	do {
+		off = rcv_cb->read_offset;
+		copy = min_t(int, skb->len - off, len - copied);
+		err = skb_copy_datagram_msg(skb, off, msg, copy);
+		if (err) {
+			if (!copied)
+				goto out;
+			break;
+		}
+		copied += copy;
+		fin = rcv_cb->stream_fin;
+		event = rcv_cb->event;
+		dgram = rcv_cb->dgram;
+		level = rcv_cb->level;
+		if (event) {
+			msg->msg_flags |= MSG_NOTIFICATION;
+			sinfo.stream_flag |= QUIC_STREAM_FLAG_NOTIFICATION;
+		} else if (dgram) {
+			msg->msg_flags |= MSG_DATAGRAM;
+			sinfo.stream_flag |= QUIC_STREAM_FLAG_DATAGRAM;
+		} else if (!stream) {
+			hinfo.crypto_level = level;
+			put_cmsg(msg, IPPROTO_QUIC, QUIC_HANDSHAKE_INFO, sizeof(hinfo), &hinfo);
+		}
+		if (flags & MSG_PEEK)
+			break;
+		if (copy != skb->len - off) {
+			rcv_cb->read_offset += copy;
+			break;
+		}
+		if (event) {
+			inq = quic_inq(sk);
+			if (skb == quic_inq_last_event(inq))
+				quic_inq_set_last_event(inq, NULL); /* no more event on list */
+			if (event == QUIC_EVENT_STREAM_UPDATE &&
+			    stream->recv.state == QUIC_STREAM_RECV_STATE_RESET_RECVD)
+				stream->recv.state = QUIC_STREAM_RECV_STATE_RESET_READ;
+			msg->msg_flags |= MSG_EOR;
+			sinfo.stream_flag |= QUIC_STREAM_FLAG_FIN;
+			kfree_skb(__skb_dequeue(&sk->sk_receive_queue));
+			break;
+		} else if (dgram) {
+			msg->msg_flags |= MSG_EOR;
+			sinfo.stream_flag |= QUIC_STREAM_FLAG_FIN;
+			kfree_skb(__skb_dequeue(&sk->sk_receive_queue));
+			break;
+		} else if (!stream) {
+			kfree_skb(__skb_dequeue(&sk->sk_receive_queue));
+			break;
+		}
+		freed += skb->len;
+		kfree_skb(__skb_dequeue(&sk->sk_receive_queue));
+		if (fin) {
+			stream->recv.state = QUIC_STREAM_RECV_STATE_READ;
+			msg->msg_flags |= MSG_EOR;
+			sinfo.stream_flag |= QUIC_STREAM_FLAG_FIN;
+			break;
+		}
+
+		skb = skb_peek(&sk->sk_receive_queue);
+		if (!skb)
+			break;
+		rcv_cb = QUIC_RCV_CB(skb);
+		if (rcv_cb->event || rcv_cb->dgram ||
+		    !rcv_cb->stream || rcv_cb->stream->id != stream->id)
+			break;
+	} while (copied < len);
+
+	if (!event && stream) {
+		sinfo.stream_id = stream->id;
+		quic_inq_flow_control(sk, stream, freed);
+	}
+	if (event || stream)
+		put_cmsg(msg, IPPROTO_QUIC, QUIC_STREAM_INFO, sizeof(sinfo), &sinfo);
+	err = copied;
+out:
+	release_sock(sk);
+	return err;
+}
+
+static int quic_wait_for_accept(struct sock *sk, long timeo)
+{
+	DEFINE_WAIT(wait);
+	int err = 0;
+
+	for (;;) {
+		prepare_to_wait_exclusive(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
+		if (list_empty(quic_reqs(sk))) {
+			release_sock(sk);
+			timeo = schedule_timeout(timeo);
+			lock_sock(sk);
+		}
+
+		if (!quic_is_listen(sk)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (!list_empty(quic_reqs(sk))) {
+			err = 0;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+
+		if (!timeo) {
+			err = -EAGAIN;
+			break;
+		}
+	}
+
+	finish_wait(sk_sleep(sk), &wait);
+	return err;
+}
+
+#define quic_set_param_if_not_zero(param_name) \
+	do { \
+		if (p->param_name) \
+			param->param_name = p->param_name; \
+	} while (0)
+
+static int quic_sock_set_transport_param(struct sock *sk, struct quic_transport_param *p, u32 len)
+{
+	struct quic_transport_param *param = quic_local(sk);
+
+	if (len < sizeof(*param) || quic_is_established(sk))
+		return -EINVAL;
+
+	if (p->remote)
+		param = quic_remote(sk);
+
+	quic_set_param_if_not_zero(max_udp_payload_size);
+	quic_set_param_if_not_zero(ack_delay_exponent);
+	quic_set_param_if_not_zero(max_ack_delay);
+	quic_set_param_if_not_zero(active_connection_id_limit);
+	quic_set_param_if_not_zero(max_idle_timeout);
+	quic_set_param_if_not_zero(max_datagram_frame_size);
+	quic_set_param_if_not_zero(max_data);
+	quic_set_param_if_not_zero(max_stream_data_bidi_local);
+	quic_set_param_if_not_zero(max_stream_data_bidi_remote);
+	quic_set_param_if_not_zero(max_stream_data_uni);
+	quic_set_param_if_not_zero(max_streams_bidi);
+	quic_set_param_if_not_zero(max_streams_uni);
+	quic_set_param_if_not_zero(initial_smoothed_rtt);
+	quic_set_param_if_not_zero(disable_active_migration);
+	quic_set_param_if_not_zero(disable_1rtt_encryption);
+	quic_set_param_if_not_zero(plpmtud_probe_timeout);
+	quic_set_param_if_not_zero(validate_peer_address);
+	quic_set_param_if_not_zero(grease_quic_bit);
+	quic_set_param_if_not_zero(stateless_reset);
+	quic_set_param_if_not_zero(receive_session_ticket);
+	quic_set_param_if_not_zero(certificate_request);
+	quic_set_param_if_not_zero(payload_cipher_type);
+	quic_set_param_if_not_zero(version);
+
+	if (p->remote) {
+		param->remote = 1;
+		quic_outq_set_param(sk, param);
+		quic_connection_id_set_param(quic_source(sk), param);
+		quic_stream_set_param(quic_streams(sk), NULL, param);
+		return 0;
+	}
+
+	quic_inq_set_param(sk, param);
+	quic_cong_set_param(quic_cong(sk), param);
+	quic_connection_id_set_param(quic_dest(sk), param);
+	quic_stream_set_param(quic_streams(sk), param, NULL);
+	return 0;
+}
+
+static int quic_copy_sock(struct sock *nsk, struct sock *sk, struct quic_request_sock *req)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_APP);
+	struct quic_transport_param *param = quic_local(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff *skb, *tmp;
+	union quic_addr sa, da;
+	u32 events, type;
+
+	if (quic_data_dup(quic_alpn(nsk), quic_alpn(sk)->data, quic_alpn(sk)->len))
+		return -ENOMEM;
+
+	nsk->sk_type = sk->sk_type;
+	nsk->sk_flags = sk->sk_flags;
+	nsk->sk_family = sk->sk_family;
+	nsk->sk_protocol = IPPROTO_QUIC;
+	nsk->sk_backlog_rcv = sk->sk_prot->backlog_rcv;
+
+	nsk->sk_sndbuf = sk->sk_sndbuf;
+	nsk->sk_rcvbuf = sk->sk_rcvbuf;
+	nsk->sk_rcvtimeo = sk->sk_rcvtimeo;
+	nsk->sk_sndtimeo = sk->sk_sndtimeo;
+
+	inet_sk(nsk)->pmtudisc = inet_sk(sk)->pmtudisc;
+
+	skb_queue_walk_safe(quic_inq_backlog_list(inq), skb, tmp) {
+		quic_get_msg_addr(sk, &da, skb, 0);
+		quic_get_msg_addr(sk, &sa, skb, 1);
+
+		if (!memcmp(&req->sa, &da, quic_addr_len(sk)) &&
+		    !memcmp(&req->da, &sa, quic_addr_len(sk))) {
+			__skb_unlink(skb, quic_inq_backlog_list(inq));
+			quic_inq_backlog_tail(nsk, skb);
+		}
+	}
+
+	if (nsk->sk_family == AF_INET6)
+		inet_sk(nsk)->pinet6 = &((struct quic6_sock *)nsk)->inet6;
+
+	quic_sock_set_transport_param(nsk, param, sizeof(*param));
+	events = quic_inq_events(inq);
+	inq = quic_inq(nsk);
+	quic_inq_set_events(inq, events);
+
+	type = quic_crypto_cipher_type(crypto);
+	crypto = quic_crypto(nsk, QUIC_CRYPTO_APP);
+	quic_crypto_set_cipher_type(crypto, type);
+
+	return 0;
+}
+
+static int quic_accept_sock_init(struct sock *sk, struct quic_request_sock *req)
+{
+	struct quic_crypto *crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_connection_id conn_id;
+	struct sk_buff_head tmpq;
+	struct sk_buff *skb;
+	int err;
+
+	lock_sock(sk);
+	quic_path_addr_set(quic_dst(sk), &req->da, 0);
+	err = quic_packet_route(sk);
+	if (err < 0)
+		goto out;
+	quic_set_sk_addr(sk, quic_addr(&req->da.sa), false);
+
+	quic_connection_id_generate(&conn_id, 16);
+	err = quic_connection_id_add(quic_source(sk), &conn_id, 0, sk);
+	if (err)
+		goto out;
+	quic_inq_set_version(inq, req->version);
+	err = quic_connection_id_add(quic_dest(sk), &req->scid, 0, NULL);
+	if (err)
+		goto out;
+	err = quic_crypto_initial_keys_install(crypto, &req->dcid, req->version, 0, 1);
+	if (err)
+		goto out;
+
+	quic_outq_set_serv(outq);
+	quic_outq_set_orig_dcid(outq, &req->orig_dcid);
+	if (req->retry) {
+		quic_outq_set_retry(outq, 1);
+		quic_outq_set_retry_dcid(outq, &req->dcid);
+	}
+	quic_set_state(sk, QUIC_SS_ESTABLISHING);
+	err = sk->sk_prot->hash(sk);
+
+	__skb_queue_head_init(&tmpq);
+	skb_queue_splice_init(quic_inq_backlog_list(inq), &tmpq);
+	skb = __skb_dequeue(&tmpq);
+	while (skb) {
+		quic_packet_process(sk, skb, 0);
+		skb = __skb_dequeue(&tmpq);
+	}
+
+out:
+	release_sock(sk);
+	return err;
+}
+
+static struct sock *quic_accept(struct sock *sk, int flags, int *errp, bool kern)
+{
+	struct quic_request_sock *req = NULL;
+	struct sock *nsk = NULL;
+	int err = -EINVAL;
+	long timeo;
+
+	lock_sock(sk);
+
+	if (!quic_is_listen(sk))
+		goto out;
+
+	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
+	err = quic_wait_for_accept(sk, timeo);
+	if (err)
+		goto out;
+	req = quic_request_sock_dequeue(sk);
+
+	nsk = sk_alloc(sock_net(sk), quic_addr_family(sk), GFP_KERNEL, sk->sk_prot, kern);
+	if (!nsk) {
+		err = -ENOMEM;
+		goto out;
+	}
+	sock_init_data(NULL, nsk);
+	err = nsk->sk_prot->init(nsk);
+	if (err)
+		goto free;
+
+	err = quic_copy_sock(nsk, sk, req);
+	if (err)
+		goto free;
+	err = nsk->sk_prot->bind(nsk, &req->sa.sa, quic_addr_len(nsk));
+	if (err)
+		goto free;
+
+	err = quic_accept_sock_init(nsk, req);
+	if (err)
+		goto free;
+out:
+	release_sock(sk);
+	*errp = err;
+	kfree(req);
+	return nsk;
+free:
+	nsk->sk_prot->close(nsk, 0);
+	nsk = NULL;
+	goto out;
+}
+
+static void quic_close(struct sock *sk, long timeout)
+{
+	lock_sock(sk);
+
+	quic_outq_transmit_app_close(sk);
+
+	quic_set_state(sk, QUIC_SS_CLOSED);
+
+	quic_outq_free(sk);
+	quic_inq_free(sk);
+
+	quic_path_free(sk, quic_src(sk));
+	quic_path_free(sk, quic_dst(sk));
+
+	quic_connection_id_set_free(quic_source(sk));
+	quic_connection_id_set_free(quic_dest(sk));
+
+	release_sock(sk);
+	sk_common_release(sk);
+}
+
+int quic_sock_change_daddr(struct sock *sk, union quic_addr *addr, u32 len)
+{
+	struct quic_path_addr *path = quic_dst(sk);
+	u8 cnt = quic_path_sent_cnt(path);
+	struct sk_buff *skb;
+
+	if (cnt)
+		return -EINVAL;
+
+	quic_set_sk_ecn(sk, 0); /* clear ecn during path migration */
+	quic_path_swap_active(path);
+	quic_path_addr_set(path, addr, 0);
+
+	skb = quic_frame_create(sk, QUIC_FRAME_PATH_CHALLENGE, path);
+	if (skb)
+		quic_outq_ctrl_tail(sk, skb, false);
+
+	quic_path_set_sent_cnt(path, cnt + 1);
+	quic_timer_reset(sk, QUIC_TIMER_PATH);
+	return 0;
+}
+
+int quic_sock_change_saddr(struct sock *sk, union quic_addr *addr, u32 len)
+{
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	struct quic_path_addr *path = quic_src(sk);
+	u8 cnt = quic_path_sent_cnt(path);
+	struct sk_buff *skb;
+	u64 number;
+	int err;
+
+	if (cnt || !quic_is_established(sk))
+		return -EINVAL;
+
+	if (quic_connection_id_disable_active_migration(id_set))
+		return -EINVAL;
+
+	if (len != quic_addr_len(sk) ||
+	    quic_addr_family(sk) != addr->sa.sa_family)
+		return -EINVAL;
+
+	quic_path_addr_set(path, addr, 1);
+	err = quic_path_set_bind_port(sk, path, 1);
+	if (err)
+		goto err;
+	err = quic_path_set_udp_sock(sk, path, 1);
+	if (err)
+		goto err;
+
+	number = quic_connection_id_first_number(quic_source(sk)) + 1;
+	skb = quic_frame_create(sk, QUIC_FRAME_NEW_CONNECTION_ID, &number);
+	if (!skb) {
+		err = -ENOMEM;
+		goto err;
+	}
+	QUIC_SND_CB(skb)->path_alt = QUIC_PATH_ALT_SRC;
+	quic_outq_ctrl_tail(sk, skb, true);
+
+	quic_set_sk_ecn(sk, 0); /* clear ecn during path migration */
+	skb = quic_frame_create(sk, QUIC_FRAME_PATH_CHALLENGE, path);
+	if (skb) {
+		QUIC_SND_CB(skb)->path_alt = QUIC_PATH_ALT_SRC;
+		quic_outq_ctrl_tail(sk, skb, false);
+	}
+
+	quic_path_set_sent_cnt(path, cnt + 1);
+	quic_timer_reset(sk, QUIC_TIMER_PATH);
+	return 0;
+err:
+	quic_path_addr_free(sk, path, 1);
+	return err;
+}
+
+static int quic_sock_set_token(struct sock *sk, void *data, u32 len)
+{
+	struct sk_buff *skb;
+
+	if (quic_is_serv(sk)) {
+		skb = quic_frame_create(sk, QUIC_FRAME_NEW_TOKEN, NULL);
+		if (!skb)
+			return -ENOMEM;
+		quic_outq_ctrl_tail(sk, skb, false);
+		return 0;
+	}
+
+	if (!len || len > 120)
+		return -EINVAL;
+
+	return quic_data_dup(quic_token(sk), data, len);
+}
+
+static int quic_sock_set_session_ticket(struct sock *sk, u8 *data, u32 len)
+{
+	if (!len || len > 4096)
+		return -EINVAL;
+
+	return quic_data_dup(quic_ticket(sk), data, len);
+}
+
+static int quic_sock_set_transport_params_ext(struct sock *sk, u8 *p, u32 len)
+{
+	struct quic_transport_param *param = quic_remote(sk);
+	u32 errcode;
+
+	if (!quic_is_establishing(sk))
+		return -EINVAL;
+
+	if (quic_frame_set_transport_params_ext(sk, param, p, len)) {
+		errcode = QUIC_TRANSPORT_ERROR_TRANSPORT_PARAM;
+		quic_outq_transmit_close(sk, 0, errcode, QUIC_CRYPTO_INITIAL);
+		return -EINVAL;
+	}
+
+	param->remote = 1;
+	quic_outq_set_param(sk, param);
+	quic_connection_id_set_param(quic_source(sk), param);
+	quic_stream_set_param(quic_streams(sk), NULL, param);
+	return 0;
+}
+
+static int quic_sock_set_crypto_secret(struct sock *sk, struct quic_crypto_secret *secret, u32 len)
+{
+	struct quic_connection_id_set *id_set = quic_source(sk);
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct sk_buff_head tmpq, list;
+	struct sk_buff *skb;
+	int err, seqno;
+	u64 prior = 1;
+	u32 window;
+
+	if (len != sizeof(*secret) || !quic_is_establishing(sk))
+		return -EINVAL;
+
+	err = quic_crypto_set_secret(quic_crypto(sk, secret->level), secret,
+				     quic_inq_version(inq), 0);
+	if (err)
+		return err;
+
+	__skb_queue_head_init(&list);
+	if (!secret->send) { /* recv key is ready */
+		if (!secret->level && quic_is_serv(sk)) {
+			skb = quic_frame_create(sk, QUIC_FRAME_NEW_TOKEN, NULL);
+			if (!skb) {
+				__skb_queue_purge(&list);
+				return -ENOMEM;
+			}
+			__skb_queue_tail(&list, skb);
+			skb = quic_frame_create(sk, QUIC_FRAME_HANDSHAKE_DONE, NULL);
+			if (!skb) {
+				__skb_queue_purge(&list);
+				return -ENOMEM;
+			}
+			__skb_queue_tail(&list, skb);
+		}
+		__skb_queue_head_init(&tmpq);
+		skb_queue_splice_init(quic_inq_backlog_list(inq), &tmpq);
+		skb = __skb_dequeue(&tmpq);
+		while (skb) {
+			quic_packet_process(sk, skb, 0);
+			skb = __skb_dequeue(&tmpq);
+		}
+		if (secret->level)
+			return 0;
+		/* app recv key is ready */
+		if (quic_is_serv(sk)) {
+			/* some implementations don't send ACKs to handshake packets
+			 * so ACK them manually.
+			 */
+			quic_outq_retransmit_check(sk, QUIC_CRYPTO_INITIAL,
+						   QUIC_PN_MAP_MAX_PN, 0, 0, 0);
+			quic_outq_retransmit_check(sk, QUIC_CRYPTO_HANDSHAKE,
+						   QUIC_PN_MAP_MAX_PN, 0, 0, 0);
+			skb = __skb_dequeue(&list);
+			while (skb) {
+				quic_outq_ctrl_tail(sk, skb, true);
+				skb = __skb_dequeue(&list);
+			}
+			quic_outq_flush(sk);
+		}
+		quic_set_state(sk, QUIC_SS_ESTABLISHED);
+		quic_timer_reset(sk, QUIC_TIMER_PROBE);
+		return 0;
+	}
+
+	/* send key is ready */
+	if (secret->level) {
+		/* 0rtt send key is ready */
+		if (secret->level == QUIC_CRYPTO_EARLY)
+			quic_outq_set_level(outq, QUIC_CRYPTO_EARLY);
+		return 0;
+	}
+
+	/* app send key is ready */
+	quic_outq_set_level(outq, QUIC_CRYPTO_APP);
+	for (seqno = 1; seqno <= quic_connection_id_max_count(id_set); seqno++) {
+		skb = quic_frame_create(sk, QUIC_FRAME_NEW_CONNECTION_ID, &prior);
+		if (!skb) {
+			while (seqno)
+				quic_connection_id_remove(quic_source(sk), seqno--);
+			__skb_queue_purge(&list);
+			return -ENOMEM;
+		}
+		__skb_queue_tail(&list, skb);
+	}
+	skb = __skb_dequeue(&list);
+	while (skb) {
+		quic_outq_ctrl_tail(sk, skb, true);
+		skb = __skb_dequeue(&list);
+	}
+	window = min_t(u32, quic_packet_mss(quic_packet(sk)) * 10, 14720);
+	quic_outq_set_window(quic_outq(sk), window);
+	quic_cong_set_window(quic_cong(sk), window);
+	return 0;
+}
+
+static int quic_sock_retire_connection_id(struct sock *sk, struct quic_connection_id_info *info,
+					  u8 len)
+{
+	struct sk_buff *skb;
+	u64 number, first;
+
+	if (len < sizeof(*info) || !quic_is_established(sk))
+		return -EINVAL;
+
+	if (info->source) {
+		number = info->source;
+		if (number > quic_connection_id_last_number(quic_source(sk)) ||
+		    number <= quic_connection_id_first_number(quic_source(sk)))
+			return -EINVAL;
+		skb = quic_frame_create(sk, QUIC_FRAME_NEW_CONNECTION_ID, &number);
+		if (!skb)
+			return -ENOMEM;
+		quic_outq_ctrl_tail(sk, skb, false);
+		return 0;
+	}
+
+	number = info->dest;
+	first = quic_connection_id_first_number(quic_dest(sk));
+	if (number > quic_connection_id_last_number(quic_dest(sk)) || number <= first)
+		return -EINVAL;
+
+	for (; first < number; first++) {
+		skb = quic_frame_create(sk, QUIC_FRAME_RETIRE_CONNECTION_ID, &first);
+		if (!skb)
+			return -ENOMEM;
+		quic_outq_ctrl_tail(sk, skb, first != number - 1);
+	}
+	return 0;
+}
+
+static int quic_sock_set_alpn(struct sock *sk, char *data, u32 len)
+{
+	if (!len || len > 20)
+		return -EINVAL;
+
+	return quic_data_dup(quic_alpn(sk), data, len);
+}
+
+static int quic_sock_stream_reset(struct sock *sk, struct quic_errinfo *info, u32 len)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_stream *stream;
+	struct sk_buff *skb;
+
+	if (len != sizeof(*info) || !quic_is_established(sk))
+		return -EINVAL;
+
+	stream = quic_stream_send_get(streams, info->stream_id, 0, quic_is_serv(sk));
+	if (IS_ERR(stream))
+		return PTR_ERR(stream);
+
+	if (stream->send.state > QUIC_STREAM_SEND_STATE_SENT)
+		return -EINVAL;
+
+	skb = quic_frame_create(sk, QUIC_FRAME_RESET_STREAM, info);
+	if (!skb)
+		return -ENOMEM;
+
+	stream->send.state = QUIC_STREAM_SEND_STATE_RESET_SENT;
+	quic_outq_stream_purge(sk, stream);
+	quic_outq_ctrl_tail(sk, skb, false);
+	return 0;
+}
+
+static int quic_sock_stream_stop_sending(struct sock *sk, struct quic_errinfo *info, u32 len)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_stream *stream;
+	struct sk_buff *skb;
+
+	if (len != sizeof(*info) || !quic_is_established(sk))
+		return -EINVAL;
+
+	stream = quic_stream_recv_get(streams, info->stream_id, quic_is_serv(sk));
+	if (IS_ERR(stream))
+		return PTR_ERR(stream);
+
+	skb = quic_frame_create(sk, QUIC_FRAME_STOP_SENDING, info);
+	if (!skb)
+		return -ENOMEM;
+
+	quic_outq_ctrl_tail(sk, skb, false);
+	return 0;
+}
+
+static int quic_sock_set_event(struct sock *sk, struct quic_event_option *event, u32 len)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	u32 events;
+
+	if (len != sizeof(*event))
+		return -EINVAL;
+	if (!event->type || event->type > QUIC_EVENT_MAX)
+		return -EINVAL;
+
+	events = quic_inq_events(inq);
+	if (event->on) {
+		quic_inq_set_events(inq, events | (1 << (event->type)));
+		return 0;
+	}
+	quic_inq_set_events(inq, events & ~(1 << event->type));
+	return 0;
+}
+
+static int quic_sock_set_connection_close(struct sock *sk, struct quic_connection_close *close,
+					  u32 len)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	u8 *data;
+
+	if (len < sizeof(*close))
+		return -EINVAL;
+
+	len -= sizeof(*close);
+	if (len > 80 || close->phrase[len - 1])
+		return -EINVAL;
+	data = kmemdup(close->phrase, len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	quic_outq_set_close_phrase(outq, data);
+	quic_outq_set_close_errcode(outq, close->errcode);
+	return 0;
+}
+
+static int quic_setsockopt(struct sock *sk, int level, int optname,
+			   sockptr_t optval, unsigned int optlen)
+{
+	void *kopt = NULL;
+	int retval = 0;
+
+	if (level != SOL_QUIC)
+		return quic_af_ops(sk)->setsockopt(sk, level, optname, optval, optlen);
+
+	if (optlen > 0) {
+		kopt = memdup_sockptr(optval, optlen);
+		if (IS_ERR(kopt))
+			return PTR_ERR(kopt);
+	}
+
+	lock_sock(sk);
+	switch (optname) {
+	case QUIC_SOCKOPT_EVENT:
+		retval = quic_sock_set_event(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_STREAM_RESET:
+		retval = quic_sock_stream_reset(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_STREAM_STOP_SENDING:
+		retval = quic_sock_stream_stop_sending(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_CONNECTION_CLOSE:
+		retval = quic_sock_set_connection_close(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_CONNECTION_MIGRATION:
+		retval = quic_sock_change_saddr(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_KEY_UPDATE:
+		retval = quic_crypto_key_update(quic_crypto(sk, QUIC_CRYPTO_APP));
+		break;
+	case QUIC_SOCKOPT_RETIRE_CONNECTION_ID:
+		retval = quic_sock_retire_connection_id(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_ALPN:
+		retval = quic_sock_set_alpn(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_TOKEN:
+		retval = quic_sock_set_token(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_SESSION_TICKET:
+		retval = quic_sock_set_session_ticket(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_TRANSPORT_PARAM:
+		retval = quic_sock_set_transport_param(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_TRANSPORT_PARAM_EXT:
+		retval = quic_sock_set_transport_params_ext(sk, kopt, optlen);
+		break;
+	case QUIC_SOCKOPT_CRYPTO_SECRET:
+		retval = quic_sock_set_crypto_secret(sk, kopt, optlen);
+		break;
+	default:
+		retval = -ENOPROTOOPT;
+		break;
+	}
+	release_sock(sk);
+	kfree(kopt);
+	return retval;
+}
+
+static int quic_sock_get_token(struct sock *sk, int len, char __user *optval, int __user *optlen)
+{
+	struct quic_data *token = quic_token(sk);
+
+	if (quic_is_serv(sk) || len < token->len)
+		return -EINVAL;
+	if (put_user(token->len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, token->data, token->len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_get_session_ticket(struct sock *sk, int len,
+					char __user *optval, int __user *optlen)
+{
+	struct quic_crypto *crypto;
+	u32 ticket_len, addr_len;
+	union quic_addr *da;
+	u8 *ticket, key[64];
+
+	if (quic_is_serv(sk)) { /* get ticket_key for server */
+		crypto = quic_crypto(sk, QUIC_CRYPTO_INITIAL);
+		da = quic_path_addr(quic_dst(sk), 0);
+		addr_len = quic_addr_len(sk);
+		if (quic_crypto_generate_session_ticket_key(crypto, da, addr_len, key, 64))
+			return -EINVAL;
+		ticket = key;
+		ticket_len = 64;
+		goto out;
+	}
+
+	ticket_len = quic_ticket(sk)->len;
+	ticket = quic_ticket(sk)->data;
+out:
+	if (len < ticket_len)
+		return -EINVAL;
+	if (put_user(ticket_len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, ticket, ticket_len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_get_transport_param(struct sock *sk, int len,
+					 char __user *optval, int __user *optlen)
+{
+	struct quic_transport_param param, *p = quic_local(sk);
+
+	if (len < sizeof(param))
+		return -EINVAL;
+
+	len = sizeof(param);
+	if (copy_from_user(&param, optval, len))
+		return -EFAULT;
+
+	if (param.remote)
+		p = quic_remote(sk);
+
+	if (len < sizeof(*p))
+		return -EINVAL;
+	len = sizeof(*p);
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, p, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_get_transport_params_ext(struct sock *sk, int len,
+					      char __user *optval, int __user *optlen)
+{
+	struct quic_transport_param *param = quic_local(sk);
+	u8 data[256];
+	u32 datalen;
+
+	if (quic_frame_get_transport_params_ext(sk, param, data, &datalen))
+		return -EINVAL;
+	if (len < datalen)
+		return -EINVAL;
+	len = datalen;
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, data, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_get_crypto_secret(struct sock *sk, int len,
+				       char __user *optval, int __user *optlen)
+{
+	struct quic_crypto_secret secret = {};
+
+	if (len < sizeof(secret))
+		return -EINVAL;
+	len = sizeof(secret);
+	if (copy_from_user(&secret, optval, len))
+		return -EFAULT;
+
+	if (quic_crypto_get_secret(quic_crypto(sk, secret.level), &secret))
+		return -EINVAL;
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &secret, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_get_active_connection_id(struct sock *sk, int len,
+					      char __user *optval, int __user *optlen)
+{
+	struct quic_connection_id_set *id_set;
+	struct quic_connection_id_info info;
+	struct quic_connection_id *active;
+
+	if (len < sizeof(info) || !quic_is_established(sk))
+		return -EINVAL;
+
+	len = sizeof(info);
+	id_set = quic_source(sk);
+	active = quic_connection_id_active(id_set);
+	info.source = quic_connection_id_number(active);
+
+	id_set = quic_dest(sk);
+	active = quic_connection_id_active(id_set);
+	info.dest = quic_connection_id_number(active);
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &info, len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int quic_sock_get_alpn(struct sock *sk, int len, char __user *optval, int __user *optlen)
+{
+	struct quic_data *alpn = quic_alpn(sk);
+
+	if (len < alpn->len)
+		return -EINVAL;
+	if (put_user(alpn->len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, alpn->data, alpn->len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_sock_stream_open(struct sock *sk, int len, char __user *optval, int __user *optlen)
+{
+	struct quic_stream_table *streams = quic_streams(sk);
+	struct quic_stream_info sinfo;
+	struct quic_stream *stream;
+
+	if (len < sizeof(sinfo))
+		return -EINVAL;
+
+	len = sizeof(sinfo);
+	if (copy_from_user(&sinfo, optval, len))
+		return -EFAULT;
+
+	if (sinfo.stream_id == -1) {
+		sinfo.stream_id = (quic_stream_send_bidi(streams) << 2);
+		if (sinfo.stream_flag & QUIC_STREAM_FLAG_UNI) {
+			sinfo.stream_id = (quic_stream_send_uni(streams) << 2);
+			sinfo.stream_id |= QUIC_STREAM_TYPE_UNI_MASK;
+		}
+		sinfo.stream_id |= quic_is_serv(sk);
+	}
+
+	sinfo.stream_flag |= QUIC_STREAM_FLAG_NEW;
+	if (put_user(len, optlen) || copy_to_user(optval, &sinfo, len))
+		return -EFAULT;
+
+	stream = quic_sock_send_stream(sk, &sinfo);
+	if (IS_ERR(stream))
+		return PTR_ERR(stream);
+
+	return 0;
+}
+
+static int quic_sock_get_event(struct sock *sk, int len, char __user *optval, int __user *optlen)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_event_option event;
+
+	if (len < sizeof(event))
+		return -EINVAL;
+
+	len = sizeof(event);
+	if (copy_from_user(&event, optval, len))
+		return -EFAULT;
+
+	if (!event.type || event.type > QUIC_EVENT_MAX)
+		return -EINVAL;
+
+	event.on = quic_inq_events(inq) & (1 << event.type);
+	if (put_user(len, optlen) || copy_to_user(optval, &event, len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int quic_sock_get_connection_close(struct sock *sk, int len, char __user *optval,
+					  int __user *optlen)
+{
+	struct quic_outqueue *outq = quic_outq(sk);
+	struct quic_connection_close *close;
+	u8 phrase_len = 0, frame[100] = {};
+	u8 *phrase;
+
+	phrase = quic_outq_close_phrase(outq);
+	if (phrase)
+		phrase_len = strlen(phrase) + 1;
+	if (len < sizeof(close) + phrase_len)
+		return -EINVAL;
+
+	len = sizeof(close) + phrase_len;
+	close = (void *)frame;
+	close->errcode = quic_outq_close_errcode(outq);
+	close->frame = quic_outq_close_frame(outq);
+
+	if (phrase_len)
+		strscpy(close->phrase, phrase, phrase_len);
+
+	if (put_user(len, optlen) || copy_to_user(optval, close, len))
+		return -EFAULT;
+	return 0;
+}
+
+static int quic_getsockopt(struct sock *sk, int level, int optname,
+			   char __user *optval, int __user *optlen)
+{
+	int retval = 0;
+	int len;
+
+	if (level != SOL_QUIC)
+		return quic_af_ops(sk)->getsockopt(sk, level, optname, optval, optlen);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < 0)
+		return -EINVAL;
+
+	lock_sock(sk);
+	switch (optname) {
+	case QUIC_SOCKOPT_EVENT:
+		retval = quic_sock_get_event(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_STREAM_OPEN:
+		retval = quic_sock_stream_open(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_CONNECTION_CLOSE:
+		retval = quic_sock_get_connection_close(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_ACTIVE_CONNECTION_ID:
+		retval = quic_sock_get_active_connection_id(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_ALPN:
+		retval = quic_sock_get_alpn(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_TOKEN:
+		retval = quic_sock_get_token(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_SESSION_TICKET:
+		retval = quic_sock_get_session_ticket(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_TRANSPORT_PARAM:
+		retval = quic_sock_get_transport_param(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_TRANSPORT_PARAM_EXT:
+		retval = quic_sock_get_transport_params_ext(sk, len, optval, optlen);
+		break;
+	case QUIC_SOCKOPT_CRYPTO_SECRET:
+		retval = quic_sock_get_crypto_secret(sk, len, optval, optlen);
+		break;
+	default:
+		retval = -ENOPROTOOPT;
+		break;
+	}
+	release_sock(sk);
+	return retval;
+}
+
+static void quic_release_cb(struct sock *sk)
+{
+	if (test_bit(QUIC_MTU_REDUCED_DEFERRED, &sk->sk_tsq_flags)) {
+		quic_rcv_err_icmp(sk);
+		clear_bit(QUIC_MTU_REDUCED_DEFERRED, &sk->sk_tsq_flags);
+		__sock_put(sk);
+	}
+}
+
+static int quic_disconnect(struct sock *sk, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static void quic_shutdown(struct sock *sk, int how)
+{
+	if (!(how & SEND_SHUTDOWN))
+		goto out;
+
+	quic_outq_transmit_app_close(sk);
+out:
+	quic_set_state(sk, QUIC_SS_CLOSED);
+}
+
+struct proto quic_prot = {
+	.name		=  "QUIC",
+	.owner		=  THIS_MODULE,
+	.init		=  quic_init_sock,
+	.destroy	=  quic_destroy_sock,
+	.shutdown	=  quic_shutdown,
+	.setsockopt	=  quic_setsockopt,
+	.getsockopt	=  quic_getsockopt,
+	.connect	=  quic_connect,
+	.bind		=  quic_bind,
+	.close		=  quic_close,
+	.disconnect	=  quic_disconnect,
+	.sendmsg	=  quic_sendmsg,
+	.recvmsg	=  quic_recvmsg,
+	.accept		=  quic_accept,
+	.hash		=  quic_hash,
+	.unhash		=  quic_unhash,
+	.backlog_rcv	=  quic_do_rcv,
+	.release_cb	=  quic_release_cb,
+	.no_autobind	=  true,
+	.obj_size	=  sizeof(struct quic_sock),
+	.sysctl_mem		=  sysctl_quic_mem,
+	.sysctl_rmem		=  sysctl_quic_rmem,
+	.sysctl_wmem		=  sysctl_quic_wmem,
+	.memory_pressure	=  &quic_memory_pressure,
+	.enter_memory_pressure	=  quic_enter_memory_pressure,
+	.memory_allocated	=  &quic_memory_allocated,
+	.per_cpu_fw_alloc	=  &quic_memory_per_cpu_fw_alloc,
+	.sockets_allocated	=  &quic_sockets_allocated,
+};
+
+struct proto quicv6_prot = {
+	.name		=  "QUICv6",
+	.owner		=  THIS_MODULE,
+	.init		=  quic_init_sock,
+	.destroy	=  quic_destroy_sock,
+	.shutdown	=  quic_shutdown,
+	.setsockopt	=  quic_setsockopt,
+	.getsockopt	=  quic_getsockopt,
+	.connect	=  quic_connect,
+	.bind		=  quic_bind,
+	.close		=  quic_close,
+	.disconnect	=  quic_disconnect,
+	.sendmsg	=  quic_sendmsg,
+	.recvmsg	=  quic_recvmsg,
+	.accept		=  quic_accept,
+	.hash		=  quic_hash,
+	.unhash		=  quic_unhash,
+	.backlog_rcv	=  quic_do_rcv,
+	.release_cb	=  quic_release_cb,
+	.no_autobind	=  true,
+	.obj_size	= sizeof(struct quic6_sock),
+	.ipv6_pinfo_offset	= offsetof(struct quic6_sock, inet6),
+	.sysctl_mem		=  sysctl_quic_mem,
+	.sysctl_rmem		=  sysctl_quic_rmem,
+	.sysctl_wmem		=  sysctl_quic_wmem,
+	.memory_pressure	=  &quic_memory_pressure,
+	.enter_memory_pressure	=  quic_enter_memory_pressure,
+	.memory_allocated	=  &quic_memory_allocated,
+	.per_cpu_fw_alloc	=  &quic_memory_per_cpu_fw_alloc,
+	.sockets_allocated	=  &quic_sockets_allocated,
+};
diff --git a/net/quic/socket.h b/net/quic/socket.h
new file mode 100644
index 000000000000..dea5ff844fd8
--- /dev/null
+++ b/net/quic/socket.h
@@ -0,0 +1,293 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#ifndef __net_quic_h__
+#define __net_quic_h__
+
+#include <uapi/linux/quic.h>
+#include <net/udp_tunnel.h>
+#include "connection.h"
+#include "hashtable.h"
+#include "protocol.h"
+#include "crypto.h"
+#include "stream.h"
+#include "pnmap.h"
+#include "packet.h"
+#include "path.h"
+#include "output.h"
+#include "input.h"
+#include "timer.h"
+#include "cong.h"
+
+extern struct proto quic_prot;
+extern struct proto quicv6_prot;
+
+extern struct proto quic_handshake_prot;
+extern struct proto quicv6_handshake_prot;
+
+enum quic_state {
+	QUIC_SS_CLOSED		= TCP_CLOSE,
+	QUIC_SS_LISTENING	= TCP_LISTEN,
+	QUIC_SS_ESTABLISHING	= TCP_SYN_RECV,
+	QUIC_SS_ESTABLISHED	= TCP_ESTABLISHED,
+};
+
+struct quic_data {
+	u32 len;
+	void *data;
+};
+
+struct quic_request_sock {
+	struct list_head		list;
+	union quic_addr			da;
+	union quic_addr			sa;
+	struct quic_connection_id	dcid;
+	struct quic_connection_id	scid;
+	struct quic_connection_id	orig_dcid;
+	u8				retry;
+	u32				version;
+};
+
+enum quic_tsq_enum {
+	QUIC_MTU_REDUCED_DEFERRED,
+};
+
+struct quic_sock {
+	struct inet_sock		inet;
+	struct list_head		reqs;
+	struct quic_path_src		src;
+	struct quic_path_dst		dst;
+	struct quic_addr_family_ops	*af_ops; /* inet4 or inet6 */
+
+	struct quic_connection_id_set	source;
+	struct quic_connection_id_set	dest;
+	struct quic_stream_table	streams;
+	struct quic_cong		cong;
+	struct quic_crypto		crypto[QUIC_CRYPTO_MAX];
+	struct quic_pnmap		pn_map[QUIC_CRYPTO_MAX];
+
+	struct quic_transport_param	local;
+	struct quic_transport_param	remote;
+	struct quic_data		token;
+	struct quic_data		ticket;
+	struct quic_data		alpn;
+
+	struct quic_outqueue		outq;
+	struct quic_inqueue		inq;
+	struct quic_packet		packet;
+	struct quic_timer		timers[QUIC_TIMER_MAX];
+};
+
+struct quic6_sock {
+	struct quic_sock	quic;
+	struct ipv6_pinfo	inet6;
+};
+
+static inline struct quic_sock *quic_sk(const struct sock *sk)
+{
+	return (struct quic_sock *)sk;
+}
+
+static inline void quic_set_af_ops(struct sock *sk, struct quic_addr_family_ops *af_ops)
+{
+	quic_sk(sk)->af_ops = af_ops;
+}
+
+static inline struct quic_addr_family_ops *quic_af_ops(const struct sock *sk)
+{
+	return quic_sk(sk)->af_ops;
+}
+
+static inline struct quic_path_addr *quic_src(const struct sock *sk)
+{
+	return &quic_sk(sk)->src.a;
+}
+
+static inline struct quic_path_addr *quic_dst(const struct sock *sk)
+{
+	return &quic_sk(sk)->dst.a;
+}
+
+static inline struct quic_packet *quic_packet(const struct sock *sk)
+{
+	return &quic_sk(sk)->packet;
+}
+
+static inline struct quic_outqueue *quic_outq(const struct sock *sk)
+{
+	return &quic_sk(sk)->outq;
+}
+
+static inline struct quic_inqueue *quic_inq(const struct sock *sk)
+{
+	return &quic_sk(sk)->inq;
+}
+
+static inline struct quic_cong *quic_cong(const struct sock *sk)
+{
+	return &quic_sk(sk)->cong;
+}
+
+static inline struct quic_crypto *quic_crypto(const struct sock *sk, u8 level)
+{
+	return &quic_sk(sk)->crypto[level];
+}
+
+static inline struct quic_pnmap *quic_pnmap(const struct sock *sk, u8 level)
+{
+	return &quic_sk(sk)->pn_map[level];
+}
+
+static inline struct quic_stream_table *quic_streams(const struct sock *sk)
+{
+	return &quic_sk(sk)->streams;
+}
+
+static inline struct quic_timer *quic_timer(const struct sock *sk, u8 type)
+{
+	return &quic_sk(sk)->timers[type];
+}
+
+static inline struct list_head *quic_reqs(const struct sock *sk)
+{
+	return &quic_sk(sk)->reqs;
+}
+
+static inline struct quic_data *quic_token(const struct sock *sk)
+{
+	return &quic_sk(sk)->token;
+}
+
+static inline struct quic_data *quic_ticket(const struct sock *sk)
+{
+	return &quic_sk(sk)->ticket;
+}
+
+static inline struct quic_data *quic_alpn(const struct sock *sk)
+{
+	return &quic_sk(sk)->alpn;
+}
+
+static inline struct quic_connection_id_set *quic_source(const struct sock *sk)
+{
+	return &quic_sk(sk)->source;
+}
+
+static inline struct quic_connection_id_set *quic_dest(const struct sock *sk)
+{
+	return &quic_sk(sk)->dest;
+}
+
+static inline struct quic_transport_param *quic_local(const struct sock *sk)
+{
+	return &quic_sk(sk)->local;
+}
+
+static inline struct quic_transport_param *quic_remote(const struct sock *sk)
+{
+	return &quic_sk(sk)->remote;
+}
+
+static inline bool quic_is_serv(const struct sock *sk)
+{
+	return quic_outq(sk)->serv;
+}
+
+static inline bool quic_is_establishing(struct sock *sk)
+{
+	return sk->sk_state == QUIC_SS_ESTABLISHING;
+}
+
+static inline bool quic_is_established(struct sock *sk)
+{
+	return sk->sk_state == QUIC_SS_ESTABLISHED;
+}
+
+static inline bool quic_is_listen(struct sock *sk)
+{
+	return sk->sk_state == QUIC_SS_LISTENING;
+}
+
+static inline bool quic_is_closed(struct sock *sk)
+{
+	return sk->sk_state == QUIC_SS_CLOSED;
+}
+
+static inline void quic_set_state(struct sock *sk, int state)
+{
+	inet_sk_set_state(sk, state);
+	sk->sk_state_change(sk);
+}
+
+static inline u8 quic_version_get_type(u32 version, u8 type)
+{
+	if (version == QUIC_VERSION_V1)
+		return type;
+
+	switch (type) {
+	case QUIC_PACKET_INITIAL_V2:
+		return QUIC_PACKET_INITIAL;
+	case QUIC_PACKET_0RTT_V2:
+		return QUIC_PACKET_0RTT;
+	case QUIC_PACKET_HANDSHAKE_V2:
+		return QUIC_PACKET_HANDSHAKE;
+	case QUIC_PACKET_RETRY_V2:
+		return QUIC_PACKET_RETRY;
+	default:
+		return -1;
+	}
+	return -1;
+}
+
+static inline u8 quic_version_put_type(u32 version, u8 type)
+{
+	if (version == QUIC_VERSION_V1)
+		return type;
+
+	switch (type) {
+	case QUIC_PACKET_INITIAL:
+		return QUIC_PACKET_INITIAL_V2;
+	case QUIC_PACKET_0RTT:
+		return QUIC_PACKET_0RTT_V2;
+	case QUIC_PACKET_HANDSHAKE:
+		return QUIC_PACKET_HANDSHAKE_V2;
+	case QUIC_PACKET_RETRY:
+		return QUIC_PACKET_RETRY_V2;
+	default:
+		return -1;
+	}
+	return -1;
+}
+
+static inline int quic_data_dup(struct quic_data *to, u8 *data, u32 len)
+{
+	if (!len)
+		return 0;
+
+	data = kmemdup(data, len, GFP_ATOMIC);
+	if (!data)
+		return -ENOMEM;
+
+	kfree(to->data);
+	to->data = data;
+	to->len = len;
+	return 0;
+}
+
+int quic_sock_change_saddr(struct sock *sk, union quic_addr *addr, u32 len);
+int quic_sock_change_daddr(struct sock *sk, union quic_addr *addr, u32 len);
+bool quic_request_sock_exists(struct sock *sk, union quic_addr *sa, union quic_addr *da);
+struct sock *quic_sock_lookup(struct sk_buff *skb, union quic_addr *sa, union quic_addr *da);
+struct quic_request_sock *quic_request_sock_dequeue(struct sock *sk);
+int quic_request_sock_enqueue(struct sock *sk, struct quic_request_sock *req);
+int quic_select_version(struct sock *sk, u32 *versions, u8 count);
+u32 *quic_compatible_versions(u32 version);
+
+#endif /* __net_quic_h__ */
diff --git a/net/quic/stream.c b/net/quic/stream.c
new file mode 100644
index 000000000000..3dd5a8dc62e6
--- /dev/null
+++ b/net/quic/stream.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "uapi/linux/quic.h"
+#include <linux/jhash.h>
+#include <net/netns/hash.h>
+#include <net/sock.h>
+#include "connection.h"
+#include "hashtable.h"
+#include "stream.h"
+#include "crypto.h"
+#include "frame.h"
+
+#define QUIC_STREAM_TYPE_CLIENT_BI	0x00
+#define QUIC_STREAM_TYPE_SERVER_BI	0x01
+#define QUIC_STREAM_TYPE_CLIENT_UNI	0x02
+#define QUIC_STREAM_TYPE_SERVER_UNI	0x03
+
+struct quic_stream *quic_stream_find(struct quic_stream_table *streams, u64 stream_id)
+{
+	struct quic_hash_head *head = quic_stream_head(&streams->ht, stream_id);
+	struct quic_stream *stream;
+
+	hlist_for_each_entry(stream, &head->head, node) {
+		if (stream->id == stream_id)
+			break;
+	}
+	return stream;
+}
+
+static struct quic_stream *quic_stream_add(struct quic_stream_table *streams, u64 stream_id,
+					   u8 is_serv)
+{
+	struct quic_hash_head *head;
+	struct quic_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
+	if (!stream)
+		return NULL;
+	stream->id = stream_id;
+	if (stream_id & QUIC_STREAM_TYPE_UNI_MASK) {
+		stream->send.window = streams->send.max_stream_data_uni;
+		stream->recv.window = streams->recv.max_stream_data_uni;
+		stream->send.max_bytes = stream->send.window;
+		stream->recv.max_bytes = stream->recv.window;
+		if (streams->send.streams_uni <= (stream_id >> 2))
+			streams->send.streams_uni = (stream_id >> 2) + 1;
+		goto out;
+	}
+
+	if (streams->send.streams_bidi <= (stream_id >> 2))
+		streams->send.streams_bidi = (stream_id >> 2) + 1;
+	if (is_serv ^ !(stream_id & QUIC_STREAM_TYPE_SERVER_MASK)) {
+		stream->send.window = streams->send.max_stream_data_bidi_remote;
+		stream->recv.window = streams->recv.max_stream_data_bidi_local;
+	} else {
+		stream->send.window = streams->send.max_stream_data_bidi_local;
+		stream->recv.window = streams->recv.max_stream_data_bidi_remote;
+	}
+	stream->send.max_bytes = stream->send.window;
+	stream->recv.max_bytes = stream->recv.window;
+out:
+	head = quic_stream_head(&streams->ht, stream_id);
+	hlist_add_head(&stream->node, &head->head);
+	return stream;
+}
+
+int quic_stream_init(struct quic_stream_table *streams)
+{
+	struct quic_hash_table *ht = &streams->ht;
+	struct quic_hash_head *head;
+	int i, size = 16;
+
+	head = kmalloc_array(size, sizeof(*head), GFP_KERNEL);
+	if (!head)
+		return -ENOMEM;
+	for (i = 0; i < size; i++) {
+		spin_lock_init(&head[i].lock);
+		INIT_HLIST_HEAD(&head[i].head);
+	}
+	ht->size = size;
+	ht->hash = head;
+	return 0;
+}
+
+void quic_stream_free(struct quic_stream_table *streams)
+{
+	struct quic_hash_table *ht = &streams->ht;
+	struct quic_hash_head *head;
+	struct quic_stream *stream;
+	struct hlist_node *tmp;
+	int i;
+
+	for (i = 0; i < ht->size; i++) {
+		head = &ht->hash[i];
+		hlist_for_each_entry_safe(stream, tmp, &head->head, node) {
+			hlist_del_init(&stream->node);
+			kfree(stream);
+		}
+	}
+	kfree(ht->hash);
+}
+
+void quic_stream_set_param(struct quic_stream_table *streams, struct quic_transport_param *local,
+			   struct quic_transport_param *remote)
+{
+	if (remote) {
+		streams->send.max_stream_data_bidi_local = remote->max_stream_data_bidi_local;
+		streams->send.max_stream_data_bidi_remote = remote->max_stream_data_bidi_remote;
+		streams->send.max_stream_data_uni = remote->max_stream_data_uni;
+		streams->send.max_streams_bidi = remote->max_streams_bidi;
+		streams->send.max_streams_uni = remote->max_streams_uni;
+		streams->send.stream_active = -1;
+	}
+
+	if (local) {
+		streams->recv.max_stream_data_bidi_local = local->max_stream_data_bidi_local;
+		streams->recv.max_stream_data_bidi_remote = local->max_stream_data_bidi_remote;
+		streams->recv.max_stream_data_uni = local->max_stream_data_uni;
+		streams->recv.max_streams_bidi = local->max_streams_bidi;
+		streams->recv.max_streams_uni = local->max_streams_uni;
+	}
+}
+
+static bool quic_stream_id_is_send(u64 stream_id, bool is_serv)
+{
+	u8 type = (stream_id & QUIC_STREAM_TYPE_MASK);
+
+	if (is_serv) {
+		if (type == QUIC_STREAM_TYPE_CLIENT_UNI)
+			return false;
+	} else if (type == QUIC_STREAM_TYPE_SERVER_UNI) {
+		return false;
+	}
+	return true;
+}
+
+static bool quic_stream_id_is_recv(u64 stream_id, bool is_serv)
+{
+	u8 type = (stream_id & QUIC_STREAM_TYPE_MASK);
+
+	if (is_serv) {
+		if (type == QUIC_STREAM_TYPE_SERVER_UNI)
+			return false;
+	} else if (type == QUIC_STREAM_TYPE_CLIENT_UNI) {
+		return false;
+	}
+	return true;
+}
+
+bool quic_stream_id_send_exceeds(struct quic_stream_table *streams, u64 stream_id)
+{
+	if (stream_id & QUIC_STREAM_TYPE_UNI_MASK) {
+		if ((stream_id >> 2) >= streams->send.max_streams_uni)
+			return true;
+	} else {
+		if ((stream_id >> 2) >= streams->send.max_streams_bidi)
+			return true;
+	}
+	return false;
+}
+
+static bool quic_stream_id_recv_exceeds(struct quic_stream_table *streams, u64 stream_id)
+{
+	if (stream_id & QUIC_STREAM_TYPE_UNI_MASK) {
+		if ((stream_id >> 2) >= streams->recv.max_streams_uni)
+			return true;
+	} else {
+		if ((stream_id >> 2) >= streams->recv.max_streams_bidi)
+			return true;
+	}
+	return false;
+}
+
+static bool quic_stream_id_send_allowed(u64 stream_id, bool is_serv)
+{
+	u8 type = (stream_id & QUIC_STREAM_TYPE_MASK);
+
+	if (is_serv) {
+		if (type == QUIC_STREAM_TYPE_CLIENT_BI)
+			return false;
+	} else {
+		if (type == QUIC_STREAM_TYPE_SERVER_BI)
+			return false;
+	}
+	return true;
+}
+
+struct quic_stream *quic_stream_send_get(struct quic_stream_table *streams, u64 stream_id,
+					 u32 flag, bool is_serv)
+{
+	struct quic_stream *stream;
+
+	if (!quic_stream_id_is_send(stream_id, is_serv))
+		return ERR_PTR(-EINVAL);
+
+	stream = quic_stream_find(streams, stream_id);
+	if (stream) {
+		if (flag & QUIC_STREAM_FLAG_NEW)
+			return ERR_PTR(-EINVAL);
+		return stream;
+	}
+
+	if (!(flag & QUIC_STREAM_FLAG_NEW))
+		return ERR_PTR(-EINVAL);
+
+	if (!quic_stream_id_send_allowed(stream_id, is_serv))
+		return ERR_PTR(-EINVAL);
+
+	if (quic_stream_id_send_exceeds(streams, stream_id))
+		return ERR_PTR(-EAGAIN);
+
+	stream = quic_stream_add(streams, stream_id, is_serv);
+	if (!stream)
+		return ERR_PTR(-ENOMEM);
+	streams->send.stream_active = stream_id;
+	return stream;
+}
+
+struct quic_stream *quic_stream_recv_get(struct quic_stream_table *streams, u64 stream_id,
+					 bool is_serv)
+{
+	struct quic_stream *stream;
+
+	if (!quic_stream_id_is_recv(stream_id, is_serv))
+		return ERR_PTR(-EINVAL);
+
+	stream = quic_stream_find(streams, stream_id);
+	if (stream)
+		return stream;
+
+	if (quic_stream_id_recv_exceeds(streams, stream_id))
+		return ERR_PTR(-EAGAIN);
+
+	stream = quic_stream_add(streams, stream_id, is_serv);
+	if (!stream)
+		return ERR_PTR(-ENOMEM);
+	return stream;
+}
diff --git a/net/quic/stream.h b/net/quic/stream.h
new file mode 100644
index 000000000000..18355cf00497
--- /dev/null
+++ b/net/quic/stream.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_STREAM_BIT_FIN	0x01
+#define QUIC_STREAM_BIT_LEN	0x02
+#define QUIC_STREAM_BIT_OFF	0x04
+#define QUIC_STREAM_BIT_MASK	0x08
+
+#define QUIC_MAX_STREAMS	BIT_ULL(60)
+
+struct quic_stream {
+	struct hlist_node node;
+	u64 id;
+	struct {
+		u64 max_bytes;
+		u64 window; /* congestion control in stream level? not now */
+		u64 bytes;
+		u64 offset;
+
+		u32 errcode;
+		u32 frags;
+		u8 state;
+
+		u8 data_blocked;
+	} send;
+	struct {
+		u64 max_bytes;
+		u64 window;
+		u64 bytes;
+		u64 offset;
+		u64 highest;
+		u64 finalsz;
+
+		u32 frags;
+		u8 state;
+	} recv;
+};
+
+struct quic_stream_table {
+	struct quic_hash_table ht;
+
+	struct {
+		u64 max_stream_data_bidi_local;
+		u64 max_stream_data_bidi_remote;
+		u64 max_stream_data_uni;
+		u64 max_streams_bidi;
+		u64 max_streams_uni;
+		u64 streams_bidi;
+		u64 streams_uni;
+		u64 stream_active;
+	} send;
+	struct {
+		u64 max_stream_data_bidi_local;
+		u64 max_stream_data_bidi_remote;
+		u64 max_stream_data_uni;
+		u64 max_streams_bidi;
+		u64 max_streams_uni;
+	} recv;
+};
+
+static inline u64 quic_stream_send_active(struct quic_stream_table *streams)
+{
+	return streams->send.stream_active;
+}
+
+static inline void quic_stream_set_send_active(struct quic_stream_table *streams, u64 active)
+{
+	streams->send.stream_active = active;
+}
+
+static inline u64 quic_stream_send_max_bidi(struct quic_stream_table *streams)
+{
+	return streams->send.max_streams_bidi;
+}
+
+static inline void quic_stream_set_send_max_bidi(struct quic_stream_table *streams, u64 max)
+{
+	streams->send.max_streams_bidi = max;
+}
+
+static inline u64 quic_stream_send_max_uni(struct quic_stream_table *streams)
+{
+	return streams->send.max_streams_uni;
+}
+
+static inline void quic_stream_set_send_max_uni(struct quic_stream_table *streams, u64 max)
+{
+	streams->send.max_streams_uni = max;
+}
+
+static inline u64 quic_stream_send_bidi(struct quic_stream_table *streams)
+{
+	return streams->send.streams_bidi;
+}
+
+static inline void quic_stream_set_send_bidi(struct quic_stream_table *streams, u64 bidi)
+{
+	streams->send.streams_bidi = bidi;
+}
+
+static inline u64 quic_stream_send_uni(struct quic_stream_table *streams)
+{
+	return streams->send.streams_uni;
+}
+
+static inline void quic_stream_set_send_uni(struct quic_stream_table *streams, u64 uni)
+{
+	streams->send.streams_uni = uni;
+}
+
+static inline u64 quic_stream_recv_max_uni(struct quic_stream_table *streams)
+{
+	return streams->recv.max_streams_uni;
+}
+
+static inline void quic_stream_set_recv_max_uni(struct quic_stream_table *streams, u64 max)
+{
+	streams->recv.max_streams_uni = max;
+}
+
+static inline u64 quic_stream_recv_max_bidi(struct quic_stream_table *streams)
+{
+	return streams->recv.max_streams_bidi;
+}
+
+static inline void quic_stream_set_recv_max_bidi(struct quic_stream_table *streams, u64 max)
+{
+	streams->recv.max_streams_bidi = max;
+}
+
+int quic_stream_init(struct quic_stream_table *streams);
+void quic_stream_free(struct quic_stream_table *streams);
+void quic_stream_set_param(struct quic_stream_table *streams, struct quic_transport_param *local,
+			   struct quic_transport_param *remote);
+struct quic_stream *quic_stream_send_get(struct quic_stream_table *streams, u64 stream_id,
+					 u32 flag, bool is_serv);
+struct quic_stream *quic_stream_recv_get(struct quic_stream_table *streams, u64 stream_id,
+					 bool is_serv);
+struct quic_stream *quic_stream_find(struct quic_stream_table *streams, u64 stream_id);
+bool quic_stream_id_send_exceeds(struct quic_stream_table *streams, u64 stream_id);
diff --git a/net/quic/timer.c b/net/quic/timer.c
new file mode 100644
index 000000000000..a9a08f241252
--- /dev/null
+++ b/net/quic/timer.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+#include "frame.h"
+
+static void quic_timer_delay_ack_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = from_timer(qs, t, timers[QUIC_TIMER_ACK].timer);
+	struct sock *sk = &qs->inet.sk;
+	u8 level = QUIC_CRYPTO_APP;
+	struct sk_buff *skb;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!mod_timer(&quic_timer(sk, QUIC_TIMER_ACK)->timer, jiffies + (HZ / 20)))
+			sock_hold(sk);
+		goto out;
+	}
+
+	if (quic_is_closed(sk))
+		goto out;
+
+	if (quic_is_establishing(sk)) { /* try to flush ACKs to Handshake packets */
+		quic_outq_flush(sk);
+		goto out;
+	}
+
+	skb = quic_frame_create(sk, QUIC_FRAME_ACK, &level);
+	if (skb)
+		quic_outq_ctrl_tail(sk, skb, false);
+
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+static void quic_timer_rtx_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = from_timer(qs, t, timers[QUIC_TIMER_RTX].timer);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!mod_timer(&quic_timer(sk, QUIC_TIMER_RTX)->timer, jiffies + (HZ / 20)))
+			sock_hold(sk);
+		goto out;
+	}
+
+	if (quic_is_closed(sk))
+		goto out;
+
+	quic_outq_retransmit(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+static void quic_timer_idle_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = from_timer(qs, t, timers[QUIC_TIMER_IDLE].timer);
+	struct quic_connection_close *close;
+	struct sock *sk = &qs->inet.sk;
+	u8 frame[100] = {};
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!mod_timer(&quic_timer(sk, QUIC_TIMER_IDLE)->timer, jiffies + (HZ / 20)))
+			sock_hold(sk);
+		goto out;
+	}
+
+	/* Notify userspace, which is most likely waiting for a packet on the
+	 * rcv queue.
+	 */
+	close = (void *)frame;
+	close->errcode = 0;	/* Not an error, only a timer runout. */
+	if (quic_inq_event_recv(sk, QUIC_EVENT_CONNECTION_CLOSE, close)) {
+		quic_timer_reset(sk, QUIC_TIMER_IDLE);
+		goto out;
+	}
+	quic_set_state(sk, QUIC_SS_CLOSED);
+
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+	pr_debug("[QUIC] IDLE TIMEOUT\n");
+}
+
+static void quic_timer_probe_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = from_timer(qs, t, timers[QUIC_TIMER_PROBE].timer);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!mod_timer(&quic_timer(sk, QUIC_TIMER_PROBE)->timer, jiffies + (HZ / 20)))
+			sock_hold(sk);
+		goto out;
+	}
+
+	if (quic_is_closed(sk))
+		goto out;
+
+	quic_outq_transmit_probe(sk);
+
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+static void quic_timer_path_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = from_timer(qs, t, timers[QUIC_TIMER_PATH].timer);
+	struct sock *sk = &qs->inet.sk;
+	struct quic_path_addr *path;
+	struct quic_packet *packet;
+	struct sk_buff *skb;
+	u8 cnt;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!mod_timer(&quic_timer(sk, QUIC_TIMER_PATH)->timer, jiffies + (HZ / 20)))
+			sock_hold(sk);
+		goto out;
+	}
+
+	if (quic_is_closed(sk))
+		goto out;
+
+	packet = quic_packet(sk);
+	path = quic_src(sk);
+	cnt = quic_path_sent_cnt(path);
+	if (cnt) {
+		if (cnt >= 5) {
+			quic_path_set_sent_cnt(path, 0);
+			quic_packet_set_ecn_probes(packet, 0);
+			goto out;
+		}
+		skb = quic_frame_create(sk, QUIC_FRAME_PATH_CHALLENGE, path);
+		if (skb)
+			quic_outq_ctrl_tail(sk, skb, false);
+		quic_path_set_sent_cnt(path, cnt + 1);
+		quic_timer_reset(sk, QUIC_TIMER_PATH);
+	}
+
+	path = quic_dst(sk);
+	cnt = quic_path_sent_cnt(path);
+	if (cnt) {
+		if (cnt >= 5) {
+			quic_path_set_sent_cnt(path, 0);
+			quic_path_swap_active(path);
+			quic_packet_set_ecn_probes(packet, 0);
+			goto out;
+		}
+		skb = quic_frame_create(sk, QUIC_FRAME_PATH_CHALLENGE, path);
+		if (skb)
+			quic_outq_ctrl_tail(sk, skb, false);
+		quic_path_set_sent_cnt(path, cnt + 1);
+		quic_timer_reset(sk, QUIC_TIMER_PATH);
+	}
+
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void quic_timer_reset(struct sock *sk, u8 type)
+{
+	struct quic_timer *t = quic_timer(sk, type);
+
+	if (t->timeout && !mod_timer(&t->timer, jiffies + t->timeout))
+		sock_hold(sk);
+}
+
+void quic_timer_start(struct sock *sk, u8 type)
+{
+	struct quic_timer *t = quic_timer(sk, type);
+
+	if (t->timeout && !timer_pending(&t->timer)) {
+		if (!mod_timer(&t->timer, jiffies + t->timeout))
+			sock_hold(sk);
+	}
+}
+
+void quic_timer_stop(struct sock *sk, u8 type)
+{
+	if (del_timer(&quic_timer(sk, type)->timer))
+		sock_put(sk);
+}
+
+void quic_timer_setup(struct sock *sk, u8 type, u32 timeout)
+{
+	quic_timer(sk, type)->timeout = usecs_to_jiffies(timeout);
+}
+
+void quic_timer_init(struct sock *sk)
+{
+	struct quic_inqueue *inq = quic_inq(sk);
+	struct quic_cong *cong = quic_cong(sk);
+	struct quic_timer *t;
+
+	t = quic_timer(sk, QUIC_TIMER_RTX);
+	timer_setup(&t->timer, quic_timer_rtx_timeout, 0);
+	quic_timer_setup(sk, QUIC_TIMER_RTX, quic_cong_latest_rtt(cong));
+
+	t = quic_timer(sk, QUIC_TIMER_ACK);
+	timer_setup(&t->timer, quic_timer_delay_ack_timeout, 0);
+	quic_timer_setup(sk, QUIC_TIMER_ACK, quic_inq_max_ack_delay(inq));
+
+	/* Initialize the idle timer's handler. The timeout value isn't known
+	 * until the socket context is set.
+	 */
+	t = quic_timer(sk, QUIC_TIMER_IDLE);
+	timer_setup(&t->timer, quic_timer_idle_timeout, 0);
+	quic_timer_setup(sk, QUIC_TIMER_IDLE, quic_inq_max_idle_timeout(inq));
+
+	t = quic_timer(sk, QUIC_TIMER_PROBE);
+	timer_setup(&t->timer, quic_timer_probe_timeout, 0);
+	quic_timer_setup(sk, QUIC_TIMER_PROBE, quic_inq_probe_timeout(inq));
+
+	t = quic_timer(sk, QUIC_TIMER_PATH);
+	timer_setup(&t->timer, quic_timer_path_timeout, 0);
+	quic_timer_setup(sk, QUIC_TIMER_PATH, quic_cong_latest_rtt(cong) * 3);
+}
+
+void quic_timer_free(struct sock *sk)
+{
+	quic_timer_stop(sk, QUIC_TIMER_RTX);
+	quic_timer_stop(sk, QUIC_TIMER_ACK);
+	quic_timer_stop(sk, QUIC_TIMER_IDLE);
+	quic_timer_stop(sk, QUIC_TIMER_PROBE);
+	quic_timer_stop(sk, QUIC_TIMER_PATH);
+}
diff --git a/net/quic/timer.h b/net/quic/timer.h
new file mode 100644
index 000000000000..8846f21d44fe
--- /dev/null
+++ b/net/quic/timer.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_TIMER_RTX		0
+#define QUIC_TIMER_ACK		1
+#define QUIC_TIMER_IDLE		2
+#define QUIC_TIMER_PROBE	3
+#define QUIC_TIMER_PATH		4
+
+#define QUIC_TIMER_MAX		5
+
+struct quic_timer {
+	struct timer_list timer;
+	unsigned long timeout;
+};
+
+void quic_timer_setup(struct sock *sk, u8 type, u32 timeout);
+void quic_timer_reset(struct sock *sk, u8 type);
+void quic_timer_start(struct sock *sk, u8 type);
+void quic_timer_stop(struct sock *sk, u8 type);
+void quic_timer_init(struct sock *sk);
+void quic_timer_free(struct sock *sk);
diff --git a/net/quic/unit_test.c b/net/quic/unit_test.c
new file mode 100644
index 000000000000..dc91cfaea3c0
--- /dev/null
+++ b/net/quic/unit_test.c
@@ -0,0 +1,1024 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is kernel test of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <uapi/linux/quic.h>
+#include <uapi/linux/tls.h>
+#include <linux/version.h>
+#include <linux/skbuff.h>
+#include <linux/delay.h>
+#include <kunit/test.h>
+#include <net/sock.h>
+#include "connection.h"
+#include "crypto.h"
+#include "pnmap.h"
+#include "cong.h"
+
+static void quic_pnmap_test1(struct kunit *test)
+{
+	struct quic_gap_ack_block gabs[QUIC_PN_MAX_GABS];
+	struct quic_pnmap _map = {}, *map = &_map;
+	int i;
+
+	KUNIT_ASSERT_EQ(test, 0, quic_pnmap_init(map));
+	quic_pnmap_set_max_record_ts(map, 30000);
+
+	KUNIT_EXPECT_EQ(test, map->base_pn, QUIC_PN_MAP_BASE_PN);
+	KUNIT_EXPECT_EQ(test, map->min_pn_seen, map->base_pn + QUIC_PN_MAP_SIZE);
+	KUNIT_EXPECT_EQ(test, map->len, QUIC_PN_MAP_INITIAL);
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, -1));
+	KUNIT_EXPECT_EQ(test, -ENOMEM, quic_pnmap_mark(map, QUIC_PN_MAP_SIZE + 1));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 0));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 1));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 2));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 3));
+	KUNIT_EXPECT_EQ(test, 4, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 3, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 0, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 3, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 4));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 6));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 9));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 13));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 18));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 24));
+	KUNIT_EXPECT_EQ(test, 5, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 4, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 0, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 24, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 5, quic_pnmap_num_gabs(map, gabs));
+	KUNIT_EXPECT_EQ(test, 6, gabs[0].start + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 6, gabs[0].end + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 8, gabs[1].start + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 9, gabs[1].end + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 11, gabs[2].start + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 13, gabs[2].end + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 15, gabs[3].start + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, gabs[3].end + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 20, gabs[4].start + map->base_pn);
+	KUNIT_EXPECT_EQ(test, 24, gabs[4].end + map->base_pn);
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 7));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 8));
+	KUNIT_EXPECT_EQ(test, 5, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 4, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 4, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 5));
+	KUNIT_EXPECT_EQ(test, 10, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 9, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 3, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 15));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 16));
+	KUNIT_EXPECT_EQ(test, 10, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 9, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 4, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 14));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 17));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 10));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 11));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 12));
+	KUNIT_EXPECT_EQ(test, 19, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 128));
+	KUNIT_EXPECT_EQ(test, 19, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 0, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 128, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 128 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 2, quic_pnmap_num_gabs(map, gabs));
+
+	/* ! map->max_pn_seen <= map->last_max_pn_seen + QUIC_PN_MAP_SIZE / 2 */
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 610));
+	KUNIT_EXPECT_EQ(test, 19, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 0, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 610, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 610, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 640 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 3, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 611));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 612));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 650));
+	KUNIT_EXPECT_EQ(test, 19, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 650, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 610, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 640 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 4, quic_pnmap_num_gabs(map, gabs));
+
+	/* ! map->max_pn_seen <= map->base_pn + QUIC_PN_MAP_SIZE * 3 / 4 */
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 810));
+	KUNIT_EXPECT_EQ(test, 613, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 612, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 810, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 810, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 832 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 2, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 825));
+	KUNIT_EXPECT_EQ(test, 613, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 612, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 825, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 810, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 832 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 3, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 824));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 823));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 812));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 811));
+	KUNIT_EXPECT_EQ(test, 613, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 612, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 825, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 810, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 832 + QUIC_PN_MAP_INITIAL, map->len);
+	KUNIT_EXPECT_EQ(test, 3, quic_pnmap_num_gabs(map, gabs));
+
+	for (i = 1; i <= 128; i++)
+		KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 256 * i));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, QUIC_PN_MAP_SIZE + 1));
+	KUNIT_EXPECT_EQ(test, -ENOMEM, quic_pnmap_mark(map, map->base_pn + QUIC_PN_MAP_SIZE + 1));
+
+	quic_pnmap_free(map);
+	KUNIT_EXPECT_EQ(test, map->len, 0);
+}
+
+static void quic_pnmap_test2(struct kunit *test)
+{
+	struct quic_gap_ack_block gabs[QUIC_PN_MAX_GABS];
+	struct quic_pnmap _map = {}, *map = &_map;
+
+	KUNIT_ASSERT_EQ(test, 0, quic_pnmap_init(map));
+	quic_pnmap_set_max_record_ts(map, 30000);
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 3));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 4));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 6));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 2));
+	KUNIT_EXPECT_EQ(test, 0, map->base_pn);
+	KUNIT_EXPECT_EQ(test, -1, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 2, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 2, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 6, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_num_gabs(map, gabs));
+
+	msleep(50);
+	/* ! current_ts - map->last_max_pn_ts < map->max_record_ts */
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 5));
+	KUNIT_EXPECT_EQ(test, 7, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 2, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 6, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 6, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 6, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 8));
+	KUNIT_EXPECT_EQ(test, 7, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 2, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 6, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 6, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 8, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 7));
+	KUNIT_EXPECT_EQ(test, 9, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 2, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 8, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 6, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 8, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 11));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 10));
+	KUNIT_EXPECT_EQ(test, 9, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 2, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 8, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 6, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 11, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_num_gabs(map, gabs));
+
+	msleep(50);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 18));
+	KUNIT_EXPECT_EQ(test, 9, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 6, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 8, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 18, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 2, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 9));
+	KUNIT_EXPECT_EQ(test, 12, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 6, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 11, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 18, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_num_gabs(map, gabs));
+
+	msleep(50);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 17));
+	KUNIT_EXPECT_EQ(test, 19, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 18, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 18, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 19));
+	KUNIT_EXPECT_EQ(test, 20, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 19, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 19, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 25));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 26));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 30));
+	KUNIT_EXPECT_EQ(test, 20, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 19, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 30, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 2, quic_pnmap_num_gabs(map, gabs));
+
+	msleep(50);
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_mark(map, 29));
+	KUNIT_EXPECT_EQ(test, 20, map->base_pn);
+	KUNIT_EXPECT_EQ(test, 19, map->cum_ack_point);
+	KUNIT_EXPECT_EQ(test, 30, map->max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 18, map->min_pn_seen);
+	KUNIT_EXPECT_EQ(test, 30, map->last_max_pn_seen);
+	KUNIT_EXPECT_EQ(test, 2, quic_pnmap_num_gabs(map, gabs));
+
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_check(map, 29));
+	KUNIT_EXPECT_EQ(test, 1, quic_pnmap_check(map, 19));
+	KUNIT_EXPECT_EQ(test, 0, quic_pnmap_check(map, 35));
+	KUNIT_EXPECT_EQ(test, -1, quic_pnmap_check(map, map->base_pn + QUIC_PN_MAP_SIZE));
+
+	quic_pnmap_free(map);
+	KUNIT_EXPECT_EQ(test, map->len, 0);
+}
+
+static u8 secret[48] = {
+	0x55, 0xe7, 0x18, 0x93, 0x73, 0x08, 0x09, 0xf6, 0xbf, 0xa1, 0xab, 0x66, 0xe8, 0xfc, 0x02,
+	0xde, 0x17, 0xfa, 0xbe, 0xc5, 0x4a, 0xe7, 0xe4, 0xb8, 0x25, 0x48, 0xff, 0xe9, 0xd6, 0x7d,
+	0x8e, 0x0e};
+
+static u8 data[296] = {
+	0x03, 0x65, 0x85, 0x3b, 0xf1, 0xe4, 0xf4, 0x22, 0x8d, 0x45, 0x48, 0xcb, 0xb8, 0x2e, 0x7e,
+	0x05, 0x09, 0x00, 0x00, 0x00, 0x00, 0x18, 0x01, 0x01, 0x10, 0xad, 0x35, 0x67, 0x29, 0xe2,
+	0xa6, 0x99, 0x99, 0x17, 0xf4, 0xe5, 0xdc, 0x10, 0xbf, 0x4c, 0xee, 0xd5, 0x75, 0xa0, 0x77,
+	0xd0, 0x1d, 0x49, 0x78, 0x5d, 0xaa, 0xa9, 0x74, 0x70, 0x72, 0x19, 0x91, 0x18, 0x02, 0x01,
+	0x10, 0x3c, 0xdc, 0x40, 0x33, 0xe6, 0xe9, 0x35, 0xa6, 0xa9, 0x80, 0xb6, 0xe9, 0x39, 0x84,
+	0xea, 0xb7, 0xe9, 0xc2, 0x86, 0xfb, 0x84, 0x34, 0x0a, 0x26, 0x69, 0xa5, 0x9f, 0xbb, 0x02,
+	0x7c, 0xd2, 0xd4, 0x18, 0x03, 0x01, 0x10, 0x14, 0x6a, 0xa5, 0x7e, 0x82, 0x8d, 0xc0, 0xb3,
+	0x5e, 0x23, 0x1a, 0x4d, 0xd1, 0x68, 0xbf, 0x29, 0x62, 0x01, 0xda, 0x70, 0xad, 0x88, 0x8c,
+	0x7c, 0x70, 0xb1, 0xb5, 0xdf, 0xce, 0x66, 0x00, 0xfe, 0x18, 0x04, 0x01, 0x10, 0x25, 0x83,
+	0x2f, 0x08, 0x97, 0x1a, 0x99, 0xe8, 0x68, 0xad, 0x4a, 0x2c, 0xbb, 0xc9, 0x27, 0x94, 0xd4,
+	0x5d, 0x2e, 0xe6, 0xe5, 0x50, 0x47, 0xa7, 0x72, 0x6f, 0x44, 0x49, 0x9b, 0x87, 0x21, 0xec,
+	0x18, 0x05, 0x01, 0x10, 0xcf, 0xb4, 0x62, 0xdd, 0x34, 0xb7, 0x6b, 0x92, 0xd8, 0x2d, 0x6c,
+	0xd6, 0x17, 0x75, 0xdc, 0x33, 0x8c, 0x49, 0xf3, 0xd5, 0xc0, 0xf2, 0x8e, 0xc4, 0xb6, 0x97,
+	0x99, 0xe3, 0x3c, 0x97, 0x7e, 0xa5, 0x18, 0x06, 0x01, 0x10, 0x29, 0xc6, 0x70, 0x43, 0xbe,
+	0x94, 0x18, 0x8e, 0x22, 0xf7, 0xe1, 0x02, 0xc6, 0x71, 0xc9, 0xc5, 0xb1, 0x69, 0x14, 0xb5,
+	0x62, 0x59, 0x13, 0xe5, 0xff, 0xcd, 0xc7, 0xfc, 0xfc, 0x8e, 0x46, 0x1d, 0x18, 0x07, 0x01,
+	0x10, 0x38, 0x67, 0x2b, 0x1a, 0xeb, 0x2f, 0x79, 0xdc, 0x3b, 0xc0, 0x70, 0x60, 0x21, 0xce,
+	0x35, 0x80, 0x42, 0x52, 0x4d, 0x28, 0x1f, 0x25, 0xaa, 0x59, 0x57, 0x64, 0xc3, 0xec, 0xa1,
+	0xe3, 0x3c, 0x4a, 0x19, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00};
+
+static u8 encrypted_data[296] = {
+	0x03, 0x65, 0x85, 0x3b, 0xf1, 0xe4, 0xf4, 0x22, 0x8d, 0x45, 0x48, 0xcb, 0xb8, 0x2e, 0x7e,
+	0x05, 0x09, 0x26, 0x0c, 0xae, 0xc2, 0x36, 0x54, 0xd1, 0xe4, 0x34, 0xdf, 0x42, 0xf7, 0xe6,
+	0x66, 0xc5, 0x4b, 0x80, 0x04, 0x3f, 0x77, 0x9e, 0x26, 0xdb, 0x5a, 0x5c, 0xd9, 0x48, 0xc7,
+	0x21, 0xb1, 0x01, 0xaf, 0xa4, 0x4f, 0x4d, 0x46, 0xc8, 0xb6, 0x8b, 0xde, 0xdb, 0x3b, 0x23,
+	0xee, 0x0c, 0x8b, 0x57, 0xba, 0x5a, 0x5a, 0x5e, 0xa8, 0xac, 0x12, 0x48, 0x16, 0x81, 0x12,
+	0xfb, 0xa1, 0x76, 0x1a, 0x41, 0x89, 0x46, 0xb1, 0xe3, 0xa7, 0x7b, 0x38, 0x0c, 0x75, 0x4d,
+	0x49, 0xc7, 0x77, 0x13, 0x40, 0x18, 0xf0, 0x24, 0xb9, 0x4c, 0xe4, 0xff, 0xea, 0x9c, 0xb4,
+	0xfe, 0x46, 0xcf, 0xe0, 0x2e, 0x15, 0xb5, 0xe9, 0x9b, 0xe7, 0x42, 0x3b, 0x3b, 0xdf, 0x55,
+	0xd2, 0x1e, 0xa0, 0x00, 0xdb, 0xb9, 0x1b, 0x77, 0xb7, 0x06, 0x31, 0xc8, 0x67, 0xd8, 0x61,
+	0x45, 0xcc, 0x1a, 0x3f, 0x01, 0xf8, 0xd8, 0x06, 0xd2, 0xcb, 0x76, 0xf5, 0xd2, 0x9d, 0x2c,
+	0x79, 0xd5, 0x7d, 0xe6, 0x06, 0x98, 0x8c, 0x17, 0xe5, 0xc5, 0x11, 0xec, 0x39, 0x68, 0x32,
+	0x8b, 0x66, 0x25, 0xd4, 0xf3, 0xb2, 0x4b, 0x88, 0xdf, 0x82, 0x9f, 0x17, 0x87, 0xb3, 0x44,
+	0xdf, 0x9c, 0x1a, 0xd0, 0x13, 0x3a, 0xfc, 0xa9, 0x39, 0xe6, 0xa0, 0xf3, 0x82, 0x78, 0x26,
+	0x3e, 0x79, 0xe3, 0xfa, 0x5c, 0x43, 0x55, 0xa0, 0x5b, 0x24, 0x4c, 0x63, 0x43, 0x80, 0x69,
+	0x5e, 0x0c, 0x38, 0xcf, 0x82, 0x13, 0xb5, 0xbc, 0xaa, 0x40, 0x1d, 0x4d, 0x33, 0x1a, 0xfd,
+	0x91, 0x6f, 0x4f, 0xc0, 0x71, 0x1d, 0xa1, 0x55, 0xf0, 0xa5, 0x64, 0x68, 0x08, 0x43, 0xda,
+	0xa6, 0xd2, 0x23, 0xad, 0x41, 0xf5, 0xd9, 0xa8, 0x81, 0x1d, 0xd7, 0x92, 0xa5, 0xb4, 0x08,
+	0x64, 0x96, 0x23, 0xac, 0xe3, 0xbf, 0x7d, 0x1c, 0x8f, 0x9f, 0x47, 0xc7, 0x71, 0xc2, 0x48,
+	0x28, 0x5c, 0x47, 0x74, 0x8c, 0xbb, 0x8c, 0xde, 0xc3, 0xcd, 0x0e, 0x62, 0x9f, 0xbe, 0x9d,
+	0xb5, 0x61, 0xfb, 0x2f, 0x72, 0x92, 0x62, 0x74, 0x2a, 0xda, 0x12};
+
+static struct quic_crypto crypto;
+
+static void quic_encrypt_done(void *data, int err)
+{
+	struct quic_packet_info pki = {};
+	struct sk_buff *skb = data;
+
+	WARN_ON(!skb_set_owner_sk_safe(skb, skb->sk));
+
+	pki.number_len = 4;
+	pki.number = 0;
+	pki.number_offset = 17;
+	pki.crypto_done = quic_encrypt_done;
+	pki.resume = 1;
+	quic_crypto_encrypt(&crypto, skb, &pki);
+}
+
+static void quic_decrypt_done(void *data, int err)
+{
+	struct quic_packet_info pki = {};
+	struct sk_buff *skb = data;
+
+	WARN_ON(!skb_set_owner_sk_safe(skb, skb->sk));
+
+	pki.number_len = 4;
+	pki.number = 0;
+	pki.number_offset = 17;
+	pki.crypto_done = quic_decrypt_done;
+	pki.resume = 1;
+	quic_crypto_decrypt(&crypto, skb, &pki);
+}
+
+static void quic_crypto_test1(struct kunit *test)
+{
+	struct quic_connection_id conn_id, tmpid = {};
+	struct quic_crypto_secret srt = {};
+	struct sockaddr_in addr = {};
+	struct sk_buff *skb;
+	int ret, tokenlen;
+	u8 token[72];
+
+	srt.send = 1;
+	memcpy(srt.secret, secret, 48);
+
+	srt.type = 100;
+	ret = quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	srt.type = 0;
+	ret = quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	ret = quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	srt.send = 0;
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	ret = quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = quic_crypto_key_update(&crypto);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	quic_connection_id_generate(&conn_id, 18);
+	quic_crypto_destroy(&crypto);
+	ret = quic_crypto_initial_keys_install(&crypto, &conn_id, QUIC_VERSION_V1, 0, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	quic_crypto_destroy(&crypto);
+	ret = quic_crypto_initial_keys_install(&crypto, &conn_id, QUIC_VERSION_V2, 0, 1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = quic_crypto_generate_stateless_reset_token(&crypto, conn_id.data,
+							 conn_id.len, token, 16);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = quic_crypto_generate_session_ticket_key(&crypto, conn_id.data,
+						      conn_id.len, token, 16);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	addr.sin_port = htons(1234);
+	token[0] = 1;
+	ret = quic_crypto_generate_token(&crypto, &addr, sizeof(addr),
+					 &conn_id, token, &tokenlen);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, tokenlen, 1 + sizeof(addr) + 4 + conn_id.len + QUIC_TAG_LEN);
+
+	ret = quic_crypto_verify_token(&crypto, &addr, sizeof(addr), &tmpid, token, tokenlen);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, tmpid.len, conn_id.len);
+	KUNIT_EXPECT_MEMEQ(test, tmpid.data, conn_id.data, tmpid.len);
+
+	skb = alloc_skb(296, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+	skb_put_data(skb, data, 280);
+
+	ret = quic_crypto_get_retry_tag(&crypto, skb, &conn_id, QUIC_VERSION_V1, token);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	kfree_skb(skb);
+out:
+	quic_crypto_destroy(&crypto);
+}
+
+static void quic_crypto_test2(struct kunit *test)
+{
+	struct quic_crypto_secret srt = {};
+	struct quic_packet_info pki = {};
+	struct socket *sock;
+	struct sk_buff *skb;
+	int err;
+
+	err = __sock_create(&init_net, PF_INET, SOCK_DGRAM, IPPROTO_QUIC, &sock, 1);
+	if (err)
+		return;
+
+	srt.send = 1;
+	srt.level = 0;
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	memcpy(srt.secret, secret, 48);
+	if (quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0))
+		return;
+
+	skb = alloc_skb(296, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+	WARN_ON(!skb_set_owner_sk_safe(skb, sock->sk));
+	skb_reset_transport_header(skb);
+
+	skb_put_data(skb, data, 280);
+	pki.number_len = 4;
+	pki.number = 0;
+	pki.number_offset = 17;
+	pki.crypto_done = quic_encrypt_done;
+	pki.resume = 0;
+	err = quic_crypto_encrypt(&crypto, skb, &pki);
+	if (err) {
+		if (err != -EINPROGRESS)
+			goto out;
+		msleep(50);
+	}
+
+	KUNIT_EXPECT_MEMEQ(test, encrypted_data, skb->data, skb->len);
+	quic_crypto_destroy(&crypto);
+
+	srt.send = 0;
+	srt.level = 0;
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	memcpy(srt.secret, secret, 48);
+	if (quic_crypto_set_secret(&crypto, &srt, QUIC_VERSION_V1, 0))
+		goto out;
+
+	WARN_ON(!skb_set_owner_sk_safe(skb, sock->sk));
+	pki.number_len = 4; /* unknown yet */
+	pki.number = 0; /* unknown yet */
+	pki.number_offset = 17;
+	pki.crypto_done = quic_decrypt_done;
+	pki.resume = 0;
+	pki.length = skb->len - pki.number_offset;
+	err = quic_crypto_decrypt(&crypto, skb, &pki);
+	if (err) {
+		if (err != -EINPROGRESS)
+			goto out;
+		msleep(50);
+	}
+
+	KUNIT_EXPECT_MEMEQ(test, data, skb->data, 280);
+
+out:
+	kfree_skb(skb);
+	quic_crypto_destroy(&crypto);
+	sock_release(sock);
+}
+
+static void quic_cong_test1(struct kunit *test)
+{
+	struct quic_transport_param p = {};
+	u32 transmit_ts, ack_delay;
+	struct quic_cong cong = {};
+
+	p.max_ack_delay = 25000;
+	p.ack_delay_exponent = 3;
+	p.initial_smoothed_rtt = 333000;
+	quic_cong_set_param(&cong, &p);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 166500);
+	KUNIT_EXPECT_EQ(test, cong.rto, 499500);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	/* (smoothed_rtt * 7 + adjusted_rtt) / 8 */
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 295125);
+	/* (rttvar * 3 + rttvar_sample) / 4 */
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 191156);
+	/* smoothed_rtt + rttvar */
+	KUNIT_EXPECT_EQ(test, cong.rto, 486281);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 261984);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 201363);
+	KUNIT_EXPECT_EQ(test, cong.rto, 463347);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 232986);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 201768);
+	KUNIT_EXPECT_EQ(test, cong.rto, 434754);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000;
+	ack_delay = 250;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 204237);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 201635);
+	KUNIT_EXPECT_EQ(test, cong.rto, 405872);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000;
+	ack_delay = 250;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 179082);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 195246);
+	KUNIT_EXPECT_EQ(test, cong.rto, 374328);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300;
+	ack_delay = 25;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 300);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 300);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 156734);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 185543);
+	KUNIT_EXPECT_EQ(test, cong.rto, 342277);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30;
+	ack_delay = 2;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 137146);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 173436);
+	KUNIT_EXPECT_EQ(test, cong.rto, 310582);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 120003);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 160077);
+	KUNIT_EXPECT_EQ(test, cong.rto, 280080);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 1;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 1);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 1);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 105002);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 146308);
+	KUNIT_EXPECT_EQ(test, cong.rto, 251310);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 0;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 91876);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 132700);
+	KUNIT_EXPECT_EQ(test, cong.rto, 224576);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 80391);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 119622);
+	KUNIT_EXPECT_EQ(test, cong.rto, 200013);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300;
+	ack_delay = 25;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 300);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 70354);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 107280);
+	KUNIT_EXPECT_EQ(test, cong.rto, 177634);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300;
+	ack_delay = 25;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 300);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 61572);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 95828);
+	KUNIT_EXPECT_EQ(test, cong.rto, 157400);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000;
+	ack_delay = 250;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 3);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 54000);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 85121);
+	KUNIT_EXPECT_EQ(test, cong.rto, 139121);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 0;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 47250);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 75653);
+	KUNIT_EXPECT_EQ(test, cong.rto, 122903);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 0;
+	ack_delay = 0;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 0);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 41343);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 67075);
+	KUNIT_EXPECT_EQ(test, cong.rto, 108418);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 39925);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 52787);
+	KUNIT_EXPECT_EQ(test, cong.rto, 100000);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 30000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 38684);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 41761);
+	KUNIT_EXPECT_EQ(test, cong.rto, 100000);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 406348);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 674733);
+	KUNIT_EXPECT_EQ(test, cong.rto, 1081081);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 728054);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 1069036);
+	KUNIT_EXPECT_EQ(test, cong.rto, 1797090);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 3000000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 3000000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 1009547);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 1294390);
+	KUNIT_EXPECT_EQ(test, cong.rto, 2303937);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 6000000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 6000000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 1630853);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 2058079);
+	KUNIT_EXPECT_EQ(test, cong.rto, 3688932);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 10000000;
+	ack_delay = 2500;
+	quic_cong_rtt_update(&cong, transmit_ts, ack_delay);
+	KUNIT_EXPECT_EQ(test, cong.latest_rtt, 10000000);
+	KUNIT_EXPECT_EQ(test, cong.min_rtt, 30000);
+	KUNIT_EXPECT_EQ(test, cong.smoothed_rtt, 2674496);
+	KUNIT_EXPECT_EQ(test, cong.rttvar, 3369935);
+	KUNIT_EXPECT_EQ(test, cong.rto, 6000000);
+}
+
+static void quic_cong_test2(struct kunit *test)
+{
+	u32 transmit_ts, acked_number, acked_bytes, inflight;
+	struct quic_transport_param p = {};
+	struct quic_cong cong = {};
+	u32 number, last_number;
+
+	p.max_data = 106496;
+	p.max_ack_delay = 25000;
+	p.ack_delay_exponent = 3;
+	p.initial_smoothed_rtt = 333000;
+	quic_cong_set_mss(&cong, 1400);
+	quic_cong_set_param(&cong, &p);
+	quic_cong_set_window(&cong, 14720);
+	KUNIT_EXPECT_EQ(test, cong.mss, 1400);
+	KUNIT_EXPECT_EQ(test, cong.window, 14720);
+	KUNIT_EXPECT_EQ(test, cong.max_window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_SLOW_START);
+	KUNIT_EXPECT_EQ(test, cong.threshold, U32_MAX);
+
+	/* slow_start:  cwnd increases by acked_bytes after SACK */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 3;
+	acked_bytes = 1400;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.window, 16120);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_transmit_ts, transmit_ts);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 4;
+	acked_bytes = 7000;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.window, 23120);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_transmit_ts, transmit_ts);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 5;
+	acked_bytes = 14000;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.window, 37120);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_transmit_ts, transmit_ts);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 6;
+	acked_bytes = 28000;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.window, 65120);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_transmit_ts, transmit_ts);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 8;
+	acked_bytes = 56000;
+	inflight = 1400;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_transmit_ts, transmit_ts);
+
+	/* slow_start -> recovery: go to recovery after one timeout */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	number = 7;
+	last_number = 8;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, last_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* recovery: no cwnd update after more timeout */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	number = 7;
+	last_number = 8;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, last_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* recovery -> slow_start: go back to slow_start after SACK */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 7;
+	acked_bytes = 1400;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_SLOW_START);
+	KUNIT_EXPECT_EQ(test, cong.threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.window, 106496);
+
+	/* slow_start -> recovery: go to recovery after one timeout */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	number = 9;
+	last_number = 9;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, last_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* recovery -> cong_avoid: go to cong_avoid after SACK if there's inflight */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 11;
+	acked_bytes = 1400;
+	inflight = 2800;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, 11);
+
+	/* cong_avoid: cwnd increase by 'mss * acked_bytes / cwnd' after SACK if there's inflight */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 12;
+	acked_bytes = 1400;
+	inflight = 2800;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.window, 53284);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 13;
+	acked_bytes = 1400;
+	inflight = 2800;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.window, 53320);
+
+	/* cong_avoid: no update if the rtx was not a long time ago */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	number = 9;
+	last_number = 13;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, 9);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+
+	/* cong_avoid -> recovery: go back to recovery after one timeout after enough time */
+	transmit_ts = jiffies_to_usecs(jiffies) - 500000;
+	number = 9;
+	last_number = 13;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, last_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 26660);
+	KUNIT_EXPECT_EQ(test, cong.window, 26660);
+
+	/* recovery: no update after SACK if there's inflight and acked_number < last_sent_number */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 9;
+	acked_bytes = 1400;
+	inflight = 1400;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.window, 26660);
+
+	/* recovery -> cong_avoid: go to cong_avoid after SACK if there's inflight */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 14;
+	acked_bytes = 1400;
+	inflight = 1400;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.window, 26660);
+
+	/* cong_avoid -> slow_start: got back to slow_start after SACK if there is no inflight */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 10;
+	acked_bytes = 1400;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_SLOW_START);
+	KUNIT_EXPECT_EQ(test, cong.threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.window, 106496);
+
+	/* slow_start -> recovery: go to recovery after ECN */
+	quic_cong_cwnd_update_after_ecn(&cong);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 106496);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* recovery: no update after ECN */
+	quic_cong_cwnd_update_after_ecn(&cong);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* recovery -> cong_avoid: go to cong_avoid after SACK if there's inflight */
+	transmit_ts = jiffies_to_usecs(jiffies) - 4000000;
+	acked_number = 18;
+	acked_bytes = 1400;
+	inflight = 4200;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.max_acked_number, acked_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.window, 53248);
+
+	/* any (recovery) -> slow_start -> recovery: persistent congestion after one timeout */
+	transmit_ts = jiffies_to_usecs(jiffies) - 500000;
+	number = 15;
+	last_number = 18;
+	quic_cong_cwnd_update_after_timeout(&cong, number, transmit_ts, last_number);
+	KUNIT_EXPECT_EQ(test, cong.last_sent_number, last_number);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 2800);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 2800);
+	KUNIT_EXPECT_EQ(test, cong.window, 2800);
+
+	/* recovery: no update after SACK if there's inflight and acked_number < last_sent_number */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 15;
+	acked_bytes = 1400;
+	inflight = 2800;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.window, 2800);
+
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 16;
+	acked_bytes = 1400;
+	inflight = 1400;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.window, 2800);
+
+	/* recovery -> slow_start: go back to slow_start after SACK */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 17;
+	acked_bytes = 1400;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_SLOW_START);
+	KUNIT_EXPECT_EQ(test, cong.window, 2800);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+
+	/* slow_start: cwnd increases by acked_bytes after SACK */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 19;
+	acked_bytes = 44800;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_SLOW_START);
+	KUNIT_EXPECT_EQ(test, cong.window, 47600);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+
+	/* slow_start -> cong_void: go to cong_void after SACK if cwnd > threshold */
+	transmit_ts = jiffies_to_usecs(jiffies) - 300000;
+	acked_number = 20;
+	acked_bytes = 11200;
+	inflight = 0;
+	quic_cong_cwnd_update_after_sack(&cong, acked_number, transmit_ts, acked_bytes, inflight);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_CONGESTION_AVOIDANCE);
+	KUNIT_EXPECT_EQ(test, cong.window, 58800);
+	KUNIT_EXPECT_EQ(test, cong.prior_window, 58800);
+	KUNIT_EXPECT_EQ(test, cong.threshold, 53248);
+	KUNIT_EXPECT_EQ(test, cong.prior_threshold, 53248);
+
+	/* cong_void -> recovery: go back to recovery after ECN */
+	quic_cong_cwnd_update_after_ecn(&cong);
+	KUNIT_EXPECT_EQ(test, cong.state, QUIC_CONG_RECOVERY_PERIOD);
+	KUNIT_EXPECT_EQ(test, cong.window, 29400);
+}
+
+static struct kunit_case quic_test_cases[] = {
+	KUNIT_CASE(quic_pnmap_test1),
+	KUNIT_CASE(quic_pnmap_test2),
+	KUNIT_CASE(quic_crypto_test1),
+	KUNIT_CASE(quic_crypto_test2),
+	KUNIT_CASE(quic_cong_test1),
+	KUNIT_CASE(quic_cong_test2),
+	{}
+};
+
+static struct kunit_suite quic_test_suite = {
+	.name = "quic",
+	.test_cases = quic_test_cases,
+};
+
+kunit_test_suite(quic_test_suite);
+
+MODULE_DESCRIPTION("Test QUIC Kernel API functions");
+MODULE_LICENSE("GPL");
-- 
2.43.0


