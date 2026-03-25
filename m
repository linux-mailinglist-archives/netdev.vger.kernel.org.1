Return-Path: <netdev+bounces-271343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAtVHic+w2nspQQAu9opvQ
	(envelope-from <netdev+bounces-271343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E831E619
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 02:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E9B13045AB6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3527218845;
	Wed, 25 Mar 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLt2Guxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56C272E61
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403063; cv=none; b=hYTG5q0y14bg70h/mrzbVAnb+LhZ11x9YURHcv+NW4Se+0eE25ZRQCUGHGspZIJlhXZ/ptfomGKdU+o6r3ubTIzfy/7EFUBl/Jm2NNGbWUWSjIbEqi76HTLzHwKdxsCULi4eoA4cT9mMRjTyHS/3+G8x7bYT1d0WnSQTkk+GdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403063; c=relaxed/simple;
	bh=576MJS9EDhNf7+XHS+Xt78KQm6PiKqmAjAB1dJ1OtlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhXHY3WFpBn0YO0E7EUB1sdF/TpV1TtsFCWWZ2GLlZeZ3dycVN6eJrHCO+ecs27QP0w0LRdpmuVVJ1beSHZVipujAzFuJQryvmisjHghfyV/4aQrchn15e2FouBCZFEgbOfacinZ5W/51Ge+56dLhFtgockjeT3vqPE+Vg5jbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLt2Guxm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so2818676a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774403060; x=1775007860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnFsogw3+Zpl0Is4+Zoa7M6DndwQbNQ16wLAr1kyBQQ=;
        b=cLt2GuxmvwrwSHxfpdB6hJjute09Lzh64bAROwoSzLgMNvvj/wygKzGNXex+peSNat
         DHRj/WEqwSEQJeBuwEfJk3E+gF6am835P0uWC+YbYigf25g0agTD+XuFQ3zJyi86QLCD
         ZZcpYQqBaGb6dAkN80jEgzOlkXT8PyA6SgnADWxZnBaW9i3cFZ7g49dTOxB0MDvpfirJ
         wJVZugLodNgmRhXAad0PT9T0XHk6no052MQsFfAKXzXKNlFlf12zFJ+YCp/KlPy2pZr3
         fHgvAQpr3VWDTru8VrRU5e5qhM7TwAVuiMFZLoJLXv2lWuJ9OZXstzTTW5/jBl5iDwbZ
         O+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403060; x=1775007860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnFsogw3+Zpl0Is4+Zoa7M6DndwQbNQ16wLAr1kyBQQ=;
        b=oFVaLXPSFLBCB0KZZKGRjPyigDqVIFDg0q9ujGjfF2mzglk6pdpz1Qer6T4FRCiDGm
         tppzvN9PwXoiU4enx4kNtGYN0No2GQT4dBr18puDdEK30LhKd7ZjJwwm4F+2kwKZQMIS
         bdr84+IQKkIF42/ck3A28ZB2pheyrQUsqp/Jr2cywCksOTIk5nvmUN+QMSqeFNUceHd0
         AkUtSTCjPQg+vGMMHKaCRdRrJUXJ4WXL2pGt6r8hDLzhLEHGo3X5uImymhZZUX74CHIk
         typO/6ENIFz5DL6XC2WVzFPuhvcKwcDqUYNtoAKzflsYYrchT2tJAuYKumog1TtjHYnM
         L9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWcD9s0CS1bNIGFJqUEk3fqyuHlRZlVjewRHeg7c2QinnyWOqpYTzYKypzKeZdPjS5V84b7mag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPd2NgEZjRrUlenR63GQvyO0HGlLOu4Ksa/YVZOptmoblriRf
	OIh2U4m0bncPJaN4vv+QuW/h628fk7aa7L6f9X2cwUpAy9xJUx+MLiyhfxgQilpxIX0=
X-Gm-Gg: ATEYQzzdwJ1l0YiXT8pVDxQM+7os/93khR1J+cpM5XGrKU1P1OJbQ/FRa+6Etkhsom7
	c7HAfvvmrcvfOwgU7eW42s9wM18KGgfuAR6YJWTg7Q7NLxxyrA3wL5JgH2HEQbcoQjxSDsU56AK
	GCuKD+ECkFh775HrkUg4Y5oVY91bb4cIKG6Tj3yRRNZDBV8n4DMMs3r3biX+shcNyQnHy2FPleF
	hYCS1gtIDSOfVoSowvpLKZZgYvthlc9i141OcpgifkQuZFBe9Yb49PFI5mpWrUMdcCxrTZ5NDhj
	ofBTJ2PUHtKbRZpPUF3wZuOasv878wpqHuthA8HbEwme7C++Z/jOF4FqgBz0UOkQRQMN7JVUpeo
	ETHsT4xMLYOT4VST6eC74jaHaKCCRmv0YVaB8XOPhnklwyL7yq364K2z9VmjuwMkLi1WS0aAYaD
	slD0LeI34R/3uZ
X-Received: by 2002:a17:906:f59c:b0:b98:8a4a:7d15 with SMTP id a640c23a62f3a-b9a3f1a70fdmr99510166b.19.1774403060215;
        Tue, 24 Mar 2026 18:44:20 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:270f::3e4:5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335ddfa1sm714031166b.32.2026.03.24.18.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 18:44:19 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH net-next v3] selftests: net: add tests for PPP
Date: Wed, 25 Mar 2026 09:43:54 +0800
Message-ID: <20260325014411.3596-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-271343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pppoe.so:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pppoe.sh:url,enneenne.com:email,ppp_async.sh:url]
X-Rspamd-Queue-Id: D93E831E619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ping and iperf3 tests for ppp_async.c and pppoe.c.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v3:
 - run on virtme-ng and fix dependencies
 - delete tmp files at cleanup
 - add log_test
 https://lore.kernel.org/linux-ppp/20260321154616.2754-1-dqfext@gmail.com/

 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/net/ppp/Makefile      | 15 +++++++
 tools/testing/selftests/net/ppp/config        |  9 ++++
 tools/testing/selftests/net/ppp/ppp_async.sh  | 43 ++++++++++++++++++
 tools/testing/selftests/net/ppp/ppp_common.sh | 44 +++++++++++++++++++
 .../selftests/net/ppp/pppoe-server-options    |  2 +
 tools/testing/selftests/net/ppp/pppoe.sh      | 40 +++++++++++++++++
 8 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/net/ppp/Makefile
 create mode 100644 tools/testing/selftests/net/ppp/config
 create mode 100755 tools/testing/selftests/net/ppp/ppp_async.sh
 create mode 100644 tools/testing/selftests/net/ppp/ppp_common.sh
 create mode 100644 tools/testing/selftests/net/ppp/pppoe-server-options
 create mode 100755 tools/testing/selftests/net/ppp/pppoe.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index a09bf30a057d..d553437d5ac1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21078,6 +21078,7 @@ PPP PROTOCOL DRIVERS AND COMPRESSORS
 L:	linux-ppp@vger.kernel.org
 S:	Orphan
 F:	drivers/net/ppp/ppp_*
+F:	tools/testing/selftests/net/ppp/
 
 PPS SUPPORT
 M:	Rodolfo Giometti <giometti@enneenne.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca..65f84e8a0cf0 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -78,6 +78,7 @@ TARGETS += net/netfilter
 TARGETS += net/openvswitch
 TARGETS += net/ovpn
 TARGETS += net/packetdrill
+TARGETS += net/ppp
 TARGETS += net/rds
 TARGETS += net/tcp_ao
 TARGETS += nolibc
diff --git a/tools/testing/selftests/net/ppp/Makefile b/tools/testing/selftests/net/ppp/Makefile
new file mode 100644
index 000000000000..b39b0abadde6
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir = ../../../../..
+
+TEST_PROGS := \
+	ppp_async.sh \
+	pppoe.sh \
+# end of TEST_PROGS
+
+TEST_FILES := \
+	ppp_common.sh \
+	pppoe-server-options \
+# end of TEST_FILES
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/ppp/config b/tools/testing/selftests/net/ppp/config
new file mode 100644
index 000000000000..b45d25c5b970
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/config
@@ -0,0 +1,9 @@
+CONFIG_IPV6=y
+CONFIG_PACKET=y
+CONFIG_PPP=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPPOE=m
+CONFIG_PPPOE_HASH_BITS_4=y
+CONFIG_VETH=y
diff --git a/tools/testing/selftests/net/ppp/ppp_async.sh b/tools/testing/selftests/net/ppp/ppp_async.sh
new file mode 100755
index 000000000000..2238f1b8d1db
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/ppp_async.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ppp_common.sh
+
+# Temporary files for PTY symlinks
+TTY_DIR=$(mktemp -d /tmp/ppp.XXXXXX)
+TTY_SERVER="$TTY_DIR"/server
+TTY_CLIENT="$TTY_DIR"/client
+
+cleanup() {
+	cleanup_all_ns
+	[ -n "$SOCAT_PID" ] && kill_process "$SOCAT_PID"
+	rm -fr "$TTY_DIR"
+}
+
+trap cleanup EXIT
+
+require_command socat
+ppp_common_init
+modprobe -q ppp_async
+
+# Create the virtual serial device
+socat -d PTY,link="$TTY_SERVER",rawer PTY,link="$TTY_CLIENT",rawer &
+SOCAT_PID=$!
+
+# Wait for symlinks to be created
+slowwait 5 [ -L "$TTY_SERVER" ]
+
+# Start the PPP Server
+ip netns exec "$NS_SERVER" pppd "$TTY_SERVER" 115200 \
+	"$IP_SERVER":"$IP_CLIENT" \
+	local noauth nodefaultroute debug
+
+# Start the PPP Client
+ip netns exec "$NS_CLIENT" pppd "$TTY_CLIENT" 115200 \
+	local noauth updetach nodefaultroute debug
+
+ppp_test_connectivity
+
+log_test "PPP async"
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/ppp/ppp_common.sh b/tools/testing/selftests/net/ppp/ppp_common.sh
new file mode 100644
index 000000000000..c72218813f95
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/ppp_common.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2153
+
+source ../lib.sh
+
+IP_SERVER="192.168.200.1"
+IP_CLIENT="192.168.200.2"
+
+ppp_common_init() {
+	# Package requirements
+	require_command pppd
+	require_command iperf3
+
+	# Check for root privileges
+	if [ "$(id -u)" -ne 0 ];then
+		echo "SKIP: Need root privileges"
+		exit $ksft_skip
+	fi
+
+	# Namespaces
+	setup_ns NS_SERVER NS_CLIENT
+}
+
+ppp_check_addr() {
+	dev=$1
+	addr=$2
+	ns=$3
+	ip -netns "$ns" -4 addr show dev "$dev" 2>/dev/null | grep -q "$addr"
+	return $?
+}
+
+ppp_test_connectivity() {
+	slowwait 10 ppp_check_addr "ppp0" "$IP_CLIENT" "$NS_CLIENT"
+
+	ip netns exec "$NS_CLIENT" ping -c 3 "$IP_SERVER"
+	check_err $?
+
+	ip netns exec "$NS_SERVER" iperf3 -s -1 -D
+	wait_local_port_listen "$NS_SERVER" 5201 tcp
+
+	ip netns exec "$NS_CLIENT" iperf3 -c "$IP_SERVER" -Z -t 2
+	check_err $?
+}
diff --git a/tools/testing/selftests/net/ppp/pppoe-server-options b/tools/testing/selftests/net/ppp/pppoe-server-options
new file mode 100644
index 000000000000..66c8c9d319e9
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/pppoe-server-options
@@ -0,0 +1,2 @@
+noauth
+noipdefault
diff --git a/tools/testing/selftests/net/ppp/pppoe.sh b/tools/testing/selftests/net/ppp/pppoe.sh
new file mode 100755
index 000000000000..c6a96ac44a31
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/pppoe.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ppp_common.sh
+
+VETH_SERVER="veth-server"
+VETH_CLIENT="veth-client"
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+require_command pppoe-server
+ppp_common_init
+modprobe -q pppoe
+
+# Create the veth pair
+ip link add "$VETH_SERVER" type veth peer name "$VETH_CLIENT"
+ip link set "$VETH_SERVER" netns "$NS_SERVER"
+ip link set "$VETH_CLIENT" netns "$NS_CLIENT"
+ip -netns "$NS_SERVER" link set "$VETH_SERVER" up
+ip -netns "$NS_CLIENT" link set "$VETH_CLIENT" up
+
+# Start the PPP Server
+ip netns exec "$NS_SERVER" pppoe-server -I "$VETH_SERVER" \
+	-L "$IP_SERVER" -R "$IP_CLIENT" -N 1 -q "$(command -v pppd)" \
+	-k -O "$(pwd)/pppoe-server-options"
+
+# Start the PPP Client
+ip netns exec "$NS_CLIENT" pppd \
+	local debug updetach noipdefault noauth nodefaultroute \
+	plugin pppoe.so nic-"$VETH_CLIENT"
+
+ppp_test_connectivity
+
+log_test "PPPoE"
+
+exit $EXIT_STATUS
-- 
2.43.0


