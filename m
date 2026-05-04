Return-Path: <netdev+bounces-284074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFGfF7Mj+WkN6AIAu9opvQ
	(envelope-from <netdev+bounces-284074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8A4C499B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510C9302C901
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3138B13C;
	Mon,  4 May 2026 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXU9fvoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73533DEF2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935216; cv=none; b=dB5n1iHTP84/BQqIiHYKWj9eZN7Ybf1AYBbAeVtzL+mMBEUCAthAcrtwAADNLIJ4tKMfbcWXSGr5xjbeBMXhTrpPrKLwNePnmMGcPjlQj2QeAST4Xujgzz8UCOhFTsUflblEI4L/puJJDul0HaSvnETAxk36FYSVmIEQ6hActKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935216; c=relaxed/simple;
	bh=pYvaq7ZliZGzYDM9nmq1ecUE4RuiHzo3v/3K+ujqiJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3Y6REb1QKPEOe0vQwOpCsdIs418tRlr00zK6raOM8aLv9Q0USMRRUzqu6OpTxcqRt6jzUmYnyv7Bp/FG/06CU5OJEHzfuaC49HBIMgtsqDJfj/cA3ly+XwtIgAJa5YbE3l5VASgiStSh4nYZ068w5bV+eQBPpBSLujsuyL5VWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXU9fvoZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso4889622e87.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935213; x=1778540013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obLynA1g/Vor38zUm8BBqox7C0/PwIPb9CBYtkkBXHc=;
        b=YXU9fvoZvAmHWd2z7QGMPv9txfB2vNxHKhSxPZnU+Zt4YgOcGNm7Q9LUzwXncGS3jf
         C18FKw0Pt6NfhMJy6LTAYaXu7X2wj0Ktzoh0U4ZD3By4ssQTCja06RsY0MjdjwYLAIsk
         QYjgKh8tlOK9XDcNdqQFr+O503O/CcB2L3me4ZwNBAR/0JXYmQORR4t8zNK7NSiIQRdK
         ygxDLp/2+q8tLFouv1BYB3FXzh57JduVFY4esaLSpi+aJMu7fel34In+Upr2b7cdT4OK
         xQ+w3xVUVZWaEFTpA7igfw9gknqw+kVrxV5QOfvlLwnqcNaCr2K+10KSwa//TESZy9fl
         Hzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935213; x=1778540013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obLynA1g/Vor38zUm8BBqox7C0/PwIPb9CBYtkkBXHc=;
        b=ghYG54ex0ACZAZeSbA0u7MBOyzQTzNJBOWDFKod4y0sZU1PjGRBNYdq1Dnb+Nu0ET+
         w0iBn/JIQjRGJo7p7cwpC/gdQ9KocH9279u8189IuEyXd7o2tvLUmeoiMYsmOoJNry7V
         QbKsBGLc0WFnV63kfXsXpj+4N+/P5qMedhboJaKcGmmuMrjEEwb7vW4AGASE2ElxaTV2
         +JIwTSJq/I0ACQ779G+9s4f0HW3/hYmEypyjwrwUKPZGF6HhYLCzbURMuQhybX9a6hDx
         1E2i0CJ8zWLdFiTvXE0Rjo5BmZdbQFjbWcGbr6bDOM0knPZF3rOgbVXU3zsxzZKezV+7
         2nBQ==
X-Gm-Message-State: AOJu0Yx2AYZ7+atGMmqg4NT/fDnxOHdLg3DlgOKYh3jENGHdPWv/F/KX
	rEXB5MOUYziwbvMJnbyKigZfpvCjAntIp0QMvxA6FGB67Bo9PjcGI61Pw/0pNCoefTU=
X-Gm-Gg: AeBDiesdhEEtJjFnudeuE2Z7hwjTVT/Z14SQfG+Rt3fnorLLK74fPbPjJpuOryTZ2nL
	XnUAq65bL5fjz+mw1+NiS3DFe/H/q3Htu3GTRAlKwYeXjYIer+CnhQHNtOxZ70SsKqkA+uPlDVk
	ZEFFi+u+aDL83fFmu1pAHZTID8BTMgarKtrgUdRQdJTsvgK1kdTLojLlEjB+fWlC9ePNsmPpZHO
	mJUzd6gLqAfxT7PRUc9zRGO0qvPTJ5VxljWls/hz4z7yU/r9QIIesvFL5JCHdtUIxUG90SSLG3+
	lBQPZElUrUa5edSK9mNaqI0HUvVrfFn0keZ32H8CKWFQgiUJy/eQ0CN3MMrFFlikflwkwlnmGOR
	7IpEkxQnLB3tCREZfqvkfde2451TDzA2Retkq+ODNmfL+TgqtOPfNEiWP9LGEmPhP6xYt9i/9IQ
	lwYbWMLlXn7ANyQt1dQaQv68LWJwu8RXi6PjwR3s+/iGbNdC3wAZWKyj20/BYB80RLgsQ5M850H
	YUcGU6oWWaTnrTNEe8O7ZFd
X-Received: by 2002:a05:6512:2251:b0:5a8:7247:ad38 with SMTP id 2adb3069b0e04-5a87247b429mr1605800e87.15.1777935213303;
        Mon, 04 May 2026 15:53:33 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([46.246.34.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3939b43a795sm15774901fa.35.2026.05.04.15.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:53:32 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v3 2/2] selftests: net: add FOU multicast encapsulation resubmit test
Date: Tue,  5 May 2026 01:53:10 +0300
Message-ID: <359656b63ae13fb151956c1f1c70614f49b949b4.1777934869.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777934869.git.littlesmilingcloud@gmail.com>
References: <ad_dal164gVmImWl@dau-home-pc> <cover.1777934869.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAB8A4C499B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-284074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url,fou_mcast_encap.sh:url]

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.

The test creates two network namespaces connected by a veth pair with
a FOU/GRETAP tunnel using a multicast remote address (239.0.0.1).
Ping is sent through the tunnel and received packets are counted on
the receiver's tunnel interface.

A static neighbor entry is configured on the sender because ARP
replies from the receiver cannot traverse the unidirectional multicast
tunnel back to the sender.

The early demux optimization (net.ipv4.ip_early_demux) is disabled on
the receiver to force packets through __udp4_lib_mcast_deliver(),
which is the code path being tested.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..9b2a573e4af2 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -38,6 +38,7 @@ TEST_PROGS := \
 	fib_rule_tests.sh \
 	fib_tests.sh \
 	fin_ack_lat.sh \
+	fou_mcast_encap.sh \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
new file mode 100755
index 000000000000..8db9633f4c28
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that UDP encapsulation (FOU) correctly handles packet resubmit
+# when packets are delivered via the multicast UDP delivery path.
+#
+# When a FOU-encapsulated packet arrives with a multicast destination IP,
+# __udp4_lib_mcast_deliver() must resubmit it to the inner protocol
+# handler (e.g., GRE) rather than consuming it. This test verifies that
+# by creating a FOU/GRETAP tunnel with a multicast remote address and
+# sending ping through it.
+#
+# The early demux optimization can mask this issue by routing packets via
+# the unicast path (udp_unicast_rcv_skb), so we disable it to force
+# packets through __udp4_lib_mcast_deliver().
+
+source lib.sh
+
+NSENDER=""
+NRECV=""
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup() {
+	setup_ns NSENDER NRECV
+
+	ip link add veth_s type veth peer name veth_r
+	ip link set veth_s netns "$NSENDER"
+	ip link set veth_r netns "$NRECV"
+
+	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s
+	ip -n "$NSENDER" link set veth_s up
+
+	ip -n "$NRECV" addr add 10.0.0.2/24 dev veth_r
+	ip -n "$NRECV" link set veth_r up
+
+	# Disable early demux to force multicast delivery path
+	ip netns exec "$NRECV" sysctl -wq net.ipv4.ip_early_demux=0
+
+	# Join multicast group on receiver
+	ip -n "$NRECV" addr add 239.0.0.1/32 dev veth_r autojoin
+
+	# Multicast routes
+	ip -n "$NRECV" route add 239.0.0.0/8 dev veth_r
+	ip -n "$NSENDER" route add 239.0.0.0/8 dev veth_s
+
+	# Sender: GRETAP with FOU encap (no FOU listener needed on TX side)
+	ip -n "$NSENDER" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.1 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NSENDER" link set eoudp0 up
+	ip -n "$NSENDER" addr add 192.168.99.1/24 dev eoudp0
+
+	# Receiver: FOU listener + GRETAP
+	ip netns exec "$NRECV" ip fou add port 4797 ipproto 47
+	ip -n "$NRECV" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.2 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NRECV" link set eoudp0 up
+	ip -n "$NRECV" addr add 192.168.99.2/24 dev eoudp0
+
+	# Static neigh entry on sender: ARP replies cannot traverse the
+	# multicast tunnel back, so pre-populate the neighbor cache.
+	local recv_mac
+	recv_mac=$(ip -n "$NRECV" link show eoudp0 | awk '/ether/{print $2}')
+	ip -n "$NSENDER" neigh add 192.168.99.2 lladdr "$recv_mac" dev eoudp0
+}
+
+get_rx_packets() {
+	ip -n "$NRECV" -s link show eoudp0 | awk '/RX:/{getline; print $2}'
+}
+
+test_fou_mcast_encap() {
+	local count=100
+	local rx_before
+	local rx_after
+	local rx_delta
+
+	# Warmup: let any initial broadcast/ARP traffic settle
+	ip netns exec "$NSENDER" ping -c 1 -W 1 192.168.99.2 >/dev/null 2>&1
+	sleep 1
+
+	rx_before=$(get_rx_packets)
+	ip netns exec "$NSENDER" ping -c $count -W 1 192.168.99.2 >/dev/null 2>&1
+	sleep 1
+	rx_after=$(get_rx_packets)
+
+	rx_delta=$((rx_after - rx_before))
+
+	if [ "$rx_delta" -ge "$count" ]; then
+		echo "PASS: received $rx_delta/$count packets via multicast FOU/GRETAP"
+		return "$ksft_pass"
+	elif [ "$rx_delta" -gt 0 ]; then
+		echo "FAIL: only $rx_delta/$count packets received (partial delivery)"
+		return "$ksft_fail"
+	else
+		echo "FAIL: 0/$count packets received (multicast encap resubmit broken)"
+		return "$ksft_fail"
+	fi
+}
+
+echo "TEST: FOU/GRETAP multicast encapsulation resubmit"
+
+setup
+test_fou_mcast_encap
+exit $?
-- 
2.47.3


