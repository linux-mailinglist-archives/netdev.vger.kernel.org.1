Return-Path: <netdev+bounces-195912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41637AD2AD4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084451712F0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467E645;
	Tue, 10 Jun 2025 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPs4KfbR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C317555
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514385; cv=none; b=aHplvQTPr/QRB/tFFZAw11rn3AWNUHwLgssdpvsHjh0MzIphC/1JlXG2BcE/xw73GcDxEZ/gr1Gl8En5BXGNXL6d62Ta8otmXei4N/hup6eMQ+G4MdGLYu45R2tqXPQfUi2J4JusZ8x8rpCMXdT4A+G2A3P/dSZHGv7H0O8fjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514385; c=relaxed/simple;
	bh=PxK7xrnS3JWmjtI+TTMMB8xnV+QeNR+NSdfJgIIr1wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/VldLvm2ni8uqcfg2Wg6vv2T5HXZWFIxHK4zXqfasf12zeIiogd/WbNROfisltLeYQYZ8OYBYm06GxNuqufLL7mLtJbzzBa0wuctOQlCP8uLqiBj9UNkvEz1WtMJ98g1ryowEIO6TXBSVkuzn52p5hBkEdliwOtxlArmJplsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPs4KfbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBF1C4CEED;
	Tue, 10 Jun 2025 00:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749514384;
	bh=PxK7xrnS3JWmjtI+TTMMB8xnV+QeNR+NSdfJgIIr1wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPs4KfbRblXvCx+tbSgh8CAUTuszG4a/lQiHBSNgDIOuEOoEQdg0tlZ6gBx9+YFlR
	 nzZsdORoBuNw0QPi4nLsWlAR3Rgo7HfuZaGRSW4UlcHHk5fCpGtDPhiCObl9TlUxuM
	 tHapwFBnxgngYfu11vHYwT6EMO3CNNbrLasAJ/WhRAhD7zRYNgYTGfOTHYjGZIzzbS
	 Sfd22UFiggF00gzc6U+k/T1Wl7a3STfyHtTB5bfYvj3GQ+ifEoDffQOmMmVNVIqUdt
	 Zfqpc1HDJfyvkvVqOIB2B9kDAqyf+F8g+LT48BZBcW+NUARxqp9PibFY5pf9dhz/lr
	 ON2Ftj8d8pDEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	maze@google.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 2/2] selftests: net: add test case for NAT46 looping back dst
Date: Mon,  9 Jun 2025 17:12:45 -0700
Message-ID: <20250610001245.1981782-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610001245.1981782-1-kuba@kernel.org>
References: <20250610001245.1981782-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple test for crash involving multicast loopback and stale dst.
Reuse exising NAT46 program.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile   |  1 +
 tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100755 tools/testing/selftests/net/nat6to4.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ea84b88bcb30..ab996bd22a5f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -27,6 +27,7 @@ TEST_PROGS += amt.sh
 TEST_PROGS += unicast_extensions.sh
 TEST_PROGS += udpgro_fwd.sh
 TEST_PROGS += udpgro_frglist.sh
+TEST_PROGS += nat6to4.sh
 TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
diff --git a/tools/testing/selftests/net/nat6to4.sh b/tools/testing/selftests/net/nat6to4.sh
new file mode 100755
index 000000000000..0ee859b622a4
--- /dev/null
+++ b/tools/testing/selftests/net/nat6to4.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+NS="ns-peer-$(mktemp -u XXXXXX)"
+
+ip netns add "${NS}"
+ip -netns "${NS}" link set lo up
+ip -netns "${NS}" route add default via 127.0.0.2 dev lo
+
+tc -n "${NS}" qdisc add dev lo ingress
+tc -n "${NS}" filter add dev lo ingress prio 4 protocol ip \
+   bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-action
+
+ip netns exec "${NS}" \
+   bash -c 'echo 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789abc | socat - UDP4-DATAGRAM:224.1.0.1:6666,ip-multicast-loop=1'
-- 
2.49.0


