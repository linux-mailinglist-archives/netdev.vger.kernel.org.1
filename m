Return-Path: <netdev+bounces-127166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59416974717
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2881C25929
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263AEEC8;
	Wed, 11 Sep 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajo+zDL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5394C69
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012924; cv=none; b=rozqldeZTMyLym7mEUbBqdCD8Nb5AW8SPWllq8/a/wVKvvIHpt+ehnchiWMEFx46eOU4iwr88yWey75eio2m1KEWzCdfbq4bLZzkiamUey/CF51mOBUG2GXNoLDbDytM/pDHmr+AZ1dWsrOxZ0CGUsVbNz2xbiE2pCFb4NsHBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012924; c=relaxed/simple;
	bh=34z2oY1F5kmcVI47ji1cJmQ7WM2rDfCLbYj1QLpBdFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFXuoDxecXpXkFJiLmtXZKd3aVvxAigbd20VElEqkfkA9A2cN4y6kPZXBk0uhDMjUY7/B3iXLoXMjXuTiWOJCnuYSwStfUvOJTannvUf3PoxpYZ8kVBVhHhrsl/rRTiUG+4KNae+XLD0oHGQ/PyMTZwzh1eGc/tYCnQvr2TZzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajo+zDL+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a4df9dc885so32448885a.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726012921; x=1726617721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzpKA1PBiXbAbhZXcTqtrI+nSOEZ60qWH4YBFezmWf8=;
        b=ajo+zDL+fRiOrUOe+rVlChNhvUkxoKpvG6Mbp/nHjSUJnOoxUQPtnMTK6036XpxryO
         jdur83MCsmBSjNSG/A5ao/M4t65hwsCrb8+fFMUBLqiCM9pAJymBpPzF1J3qn1TmCzVL
         II1VtTfdTdIQSmKuqx5CvgDwntn8pSVaAPqp0qVvlWHc8PGcwBWKM00FsB6mQExMLMa2
         c8AQguBfI9jtVY6jbx2AEdEBIPdDalELOSM5oGmgF/lKSBVcgqcsuaL3wFjkaU5gw9SE
         MIECZTdNIWSx9ZrOuUAkURvP7HQHsUbVj0X88zcFGJ9bglPYp6YQG9QSJTrEs1K9p0VR
         Jc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012921; x=1726617721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzpKA1PBiXbAbhZXcTqtrI+nSOEZ60qWH4YBFezmWf8=;
        b=AOwl5iEOekCNde0XD9qOMGvF+jeOUllwvr+gd5QD251NofDZvqTK5tXN7I+Mko41ZH
         WGC3GEl2Gs+cEc7berEQIuv/tgXYnfQUyBe+Q1ASLi273qIm5GLMnsIIgVsYXZ/0eQaS
         xAyHnWR45thgB6HqHU9i8huT0CAbEz02oDit+oCH6R5MRgHteWFY8Xu+3gut0uGILNcf
         9JU50GUOfC5ZWqcAvdo8btXqTYhjDxPsRoX+GFfyNOv/HhqKJj6jxd6dgIhqiVDpmfYZ
         2GDp8feQMn/zVEHZw8URX2NvnfSXjHZcpuA319+rYrp3z9ErvKqEAiYB9aW+P+d5DekN
         dNdA==
X-Gm-Message-State: AOJu0Yw1ZzJc8s1pRZpPLOSpVBmjDzzPvoPiRMKwYa1pY+4uADYF2DZQ
	tuOSayCZS0l1251BIH5J+0NbG7mlTLaxKatofNRFrVRelGTI72EDV2cggg==
X-Google-Smtp-Source: AGHT+IEZKFo6DMuV4lRKQ+3aB224x0x9GRM6AwPSyTpnSCbR+74dO4vAb65cGQbaMIwZNDtFI/gXRQ==
X-Received: by 2002:a05:620a:2801:b0:7a9:b798:5e29 with SMTP id af79cd13be357-7a9bf993cedmr906407085a.30.1726012920381;
        Tue, 10 Sep 2024 17:02:00 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1d652sm354705785a.123.2024.09.10.17.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:01:59 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/3] selftests/net: packetdrill: import tcp/slow_start
Date: Tue, 10 Sep 2024 19:59:59 -0400
Message-ID: <20240911000154.929317-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
References: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Same import process as previous tests.

Also add CONFIG_NET_SCH_FQ to config, as one test uses that.

Same test process as previous tests. Both with and without debug mode.
Recording the steps once:

make mrproper
vng --build \
        --config tools/testing/selftests/net/packetdrill/config \
        --config kernel/configs/debug.config
vng -v --run . --user root --cpus 4 -- \
	make -C tools/testing/selftests TARGETS=net/packetdrill run_tests

Link: https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/net/packetdrill/config  |  1 +
 ...tcp_slow_start_slow-start-ack-per-1pkt.pkt | 56 +++++++++++++++++
 ...tart_slow-start-ack-per-2pkt-send-5pkt.pkt | 33 ++++++++++
 ...tart_slow-start-ack-per-2pkt-send-6pkt.pkt | 34 ++++++++++
 ...tcp_slow_start_slow-start-ack-per-2pkt.pkt | 42 +++++++++++++
 ...tcp_slow_start_slow-start-ack-per-4pkt.pkt | 35 +++++++++++
 .../tcp_slow_start_slow-start-after-idle.pkt  | 39 ++++++++++++
 ...slow_start_slow-start-after-win-update.pkt | 50 +++++++++++++++
 ...t_slow-start-app-limited-9-packets-out.pkt | 38 +++++++++++
 .../tcp_slow_start_slow-start-app-limited.pkt | 36 +++++++++++
 ..._slow_start_slow-start-fq-ack-per-2pkt.pkt | 63 +++++++++++++++++++
 11 files changed, 427 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt

diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index a7877819081f5..0237ed98f3c0d 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -3,6 +3,7 @@ CONFIG_HZ_1000=y
 CONFIG_HZ=1000
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
+CONFIG_NET_SCH_FQ=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TCP_CONG_CUBIC=y
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
new file mode 100644
index 0000000000000..795c476d222d9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when not application-limited, so that
+// the cwnd continues to grow.
+// In this variant, the receiver ACKs every packet.
+
+// Set up config. To keep things simple, disable the
+// mechanism that defers sending in order to send bigger TSO packets.
+`./defaults.sh
+sysctl -q net.ipv4.tcp_tso_win_divisor=100`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 30000) = 30000
+   +0 > P. 1:10001(10000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
++.105 < . 1:1(0) ack 1001 win 257
+   +0 > P. 10001:12001(2000) ack 1
+
+   +0 < . 1:1(0) ack 2001 win 257
+   +0 > P. 12001:14001(2000) ack 1
+
++.005 < . 1:1(0) ack 3001 win 257
+   +0 > P. 14001:16001(2000) ack 1
+
+   +0 < . 1:1(0) ack 4001 win 257
+   +0 > P. 16001:18001(2000) ack 1
+
++.005 < . 1:1(0) ack 5001 win 257
+   +0 > P. 18001:20001(2000) ack 1
+
+   +0 < . 1:1(0) ack 6001 win 257
+   +0 > P. 20001:22001(2000) ack 1
+
++.005 < . 1:1(0) ack 7001 win 257
+   +0 > P. 22001:24001(2000) ack 1
+
+   +0 < . 1:1(0) ack 8001 win 257
+   +0 > P. 24001:26001(2000) ack 1
+
++.005 < . 1:1(0) ack 9001 win 257
+   +0 > P. 26001:28001(2000) ack 1
+
+   +0 < . 1:1(0) ack 10001 win 257
+   +0 > P. 28001:30001(2000) ack 1
+
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
new file mode 100644
index 0000000000000..9212ae1fd0f2f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when an outstanding flight of packets is
+// less than the current cwnd, and not big enough to bump up cwnd.
+//
+// In this variant, the receiver ACKs every other packet,
+// approximating standard delayed ACKs.
+
+// Set up config.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Only send 5 packets.
+   +0 write(4, ..., 5000) = 5000
+   +0 > P. 1:5001(5000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 2001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 10, 'cwnd=%d' % tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 4001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 10, 'cwnd=%d' % tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 5001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 10, 'cwnd=%d' % tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
new file mode 100644
index 0000000000000..416c901ddf518
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when an outstanding flight of packets is
+// less than the current cwnd, but still big enough that in slow
+// start we want to increase our cwnd a little.
+//
+// In this variant, the receiver ACKs every other packet,
+// approximating standard delayed ACKs.
+
+// Set up config.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Only send 6 packets.
+   +0 write(4, ..., 6000) = 6000
+   +0 > P. 1:6001(6000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 2001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 12, 'cwnd=%d' % tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 4001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 12, 'cwnd=%d' % tcpi_snd_cwnd }%
+
+   +0 < . 1:1(0) ack 6001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 12, 'cwnd=%d' % tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
new file mode 100644
index 0000000000000..a894b7d4559c1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when not application-limited, so that
+// the cwnd continues to grow.
+// In this variant, the receiver ACKs every other packet,
+// approximating standard delayed ACKs.
+
+// Set up config. To keep things simple, disable the
+// mechanism that defers sending in order to send bigger TSO packets.
+`./defaults.sh
+sysctl -q net.ipv4.tcp_tso_win_divisor=100`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 30000) = 30000
+   +0 > P. 1:10001(10000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
++.105 < . 1:1(0) ack 2001 win 257
+   +0 > P. 10001:14001(4000) ack 1
+
++.005 < . 1:1(0) ack 4001 win 257
+   +0 > P. 14001:18001(4000) ack 1
+
++.005 < . 1:1(0) ack 6001 win 257
+   +0 > P. 18001:22001(4000) ack 1
+
++.005 < . 1:1(0) ack 8001 win 257
+   +0 > P. 22001:26001(4000) ack 1
+
++.005 < . 1:1(0) ack 10001 win 257
+   +0 > P. 26001:30001(4000) ack 1
+
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
new file mode 100644
index 0000000000000..065fae9e9abd7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when not application-limited, so that
+// the cwnd continues to grow.
+// In this variant, the receiver sends one ACK per 4 packets.
+
+// Set up config. To keep things simple, disable the
+// mechanism that defers sending in order to send bigger TSO packets.
+`./defaults.sh
+sysctl -q net.ipv4.tcp_tso_win_divisor=100`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 30000) = 30000
+   +0 > P. 1:10001(10000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+ +.11 < . 1:1(0) ack 4001 win 257
+   +0 > P. 10001:18001(8000) ack 1
+
+ +.01 < . 1:1(0) ack 8001 win 257
+   +0 > P. 18001:26001(8000) ack 1
+
++.005 < . 1:1(0) ack 10001 win 257
+   +0 > P. 26001:30001(4000) ack 1
+
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
new file mode 100644
index 0000000000000..11b213be11384
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start after idle
+// This test expects tso size to be at least initial cwnd * mss
+
+`./defaults.sh
+./set_sysctls.py /proc/sys/net/ipv4/tcp_slow_start_after_idle=1 \
+		 /proc/sys/net/ipv4/tcp_min_tso_segs=10`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 511
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 26000) = 26000
+   +0 > P. 1:5001(5000) ack 1
+   +0 > P. 5001:10001(5000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+  +.1 < . 1:1(0) ack 10001 win 511
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
+   +0 > P. 10001:20001(10000) ack 1
+   +0 > P. 20001:26001(6000) ack 1
+
+  +.1 < . 1:1(0) ack 26001 win 511
+   +0 %{ assert tcpi_snd_cwnd == 36, tcpi_snd_cwnd }%
+
+   +2 write(4, ..., 20000) = 20000
+// If slow start after idle works properly, we should send 5 MSS here (cwnd/2)
+   +0 > P. 26001:31001(5000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+// Reset sysctls
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
new file mode 100644
index 0000000000000..577ed8c8852cd
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start after window update
+// This test expects tso size to be at least initial cwnd * mss
+
+`./defaults.sh
+./set_sysctls.py /proc/sys/net/ipv4/tcp_slow_start_after_idle=1 \
+		 /proc/sys/net/ipv4/tcp_min_tso_segs=10`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 511
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 26000) = 26000
+   +0 > P. 1:5001(5000) ack 1
+   +0 > P. 5001:10001(5000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
+  +.1 < . 1:1(0) ack 10001 win 511
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
+   +0 > P. 10001:20001(10000) ack 1
+   +0 > P. 20001:26001(6000) ack 1
+
+  +.1 < . 1:1(0) ack 26001 win 0
+   +0 %{ assert tcpi_snd_cwnd == 36, tcpi_snd_cwnd }%
+
+   +0 write(4, ..., 20000) = 20000
+// 1st win0 probe
++.3~+.310 > . 26000:26000(0) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 36, tcpi_snd_cwnd }%
+
+// 2nd win0 probe
++.6~+.620 > . 26000:26000(0) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 36, tcpi_snd_cwnd }%
+
+// 3rd win0 probe
++1.2~+1.240 > . 26000:26000(0) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 36, tcpi_snd_cwnd }%
+
+  +.9 < . 1:1(0) ack 26001 win 511
+   +0 > P. 26001:31001(5000) ack 1
+
+// Reset sysctls
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
new file mode 100644
index 0000000000000..869f32c35a2ab
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when application-limited: in this case,
+// with IW10, if we don't fully use our cwnd but instead
+// send just 9 packets, then cwnd should grow to twice that
+// value, or 18 packets.
+
+// Set up config.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 9000) = 9000
+   +0 > P. 1:9001(9000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
++.105 < . 1:1(0) ack 2001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 12, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 4001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 14, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 6001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 16, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 8001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 18, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 9001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 18, tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
new file mode 100644
index 0000000000000..0f77b7955db6e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when application-limited: in this case,
+// with IW10, if we send exactly 10 packets then cwnd should grow to 20.
+
+// Set up config.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
++.105 < . 1:1(0) ack 2001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 12, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 4001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 14, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 6001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 16, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 8001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 18, tcpi_snd_cwnd }%
+
++.005 < . 1:1(0) ack 10001 win 257
+   +0 %{ assert tcpi_snd_cwnd == 20, tcpi_snd_cwnd }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
new file mode 100644
index 0000000000000..7e9c83d617c25
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test of slow start when not application-limited, so that
+// the cwnd continues to grow, even if TSQ triggers.
+// In this variant, the receiver ACKs every other packet,
+// approximating standard delayed ACKs.
+
+// Note we use FQ/pacing to check if TCP Small Queues is not hurting
+
+`./defaults.sh
+tc qdisc replace dev tun0 root fq
+sysctl -q net/ipv4/tcp_pacing_ss_ratio=200
+sysctl -e -q net.ipv4.tcp_min_tso_segs=2`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 500
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_SNDBUF, [200000], 4) = 0
+
+   +0 write(4, ..., 40000) = 40000
+// This might change if we cook the initial packet with 10 MSS.
+   +0 > P. 1:2921(2920) ack 1
+   +0 > P. 2921:5841(2920) ack 1
+   +0 > P. 5841:8761(2920) ack 1
+   +0 > P. 8761:11681(2920) ack 1
+   +0 > P. 11681:14601(2920) ack 1
+   +0 %{ assert tcpi_snd_cwnd == 10, tcpi_snd_cwnd }%
+
++.105 < . 1:1(0) ack 2921 win 500
+   +0 %{ assert tcpi_snd_cwnd == 12, tcpi_snd_cwnd }%
+
+// Note: after this commit : "net_sched: sch_fq: account for schedule/timers drifts"
+// FQ notices that this packet missed the 'time to send next packet' computed
+// when prior packet (11681:14601(2920)) was sent.
+// So FQ will allow following packet to be sent a bit earlier (quantum/2)
+// (FQ commit allows an application/cwnd limited flow to get at most quantum/2 extra credit)
+   +0 > P. 14601:17521(2920) ack 1
+
++.003 < . 1:1(0) ack 5841 win 500
+   +0 %{ assert tcpi_snd_cwnd == 14, tcpi_snd_cwnd }%
+
++.001 > P. 17521:20441(2920) ack 1
+
++.001 < . 1:1(0) ack 8761 win 500
+   +0 %{ assert tcpi_snd_cwnd == 16, tcpi_snd_cwnd }%
+
+// remaining packets are delivered at a constant rate.
++.007 > P. 20441:23361(2920) ack 1
+
++.002 < . 1:1(0) ack 11681 win 500
+   +0 %{ assert tcpi_snd_cwnd == 18, tcpi_snd_cwnd }%
++.001 < . 1:1(0) ack 14601 win 500
+
++.004 > P. 23361:26281(2920) ack 1
+
++.007 > P. 26281:29201(2920) ack 1
+
+   +0 %{ assert tcpi_snd_cwnd == 20, 'cwnd=%d' % tcpi_snd_cwnd }%
-- 
2.46.0.598.g6f2099f65c-goog


