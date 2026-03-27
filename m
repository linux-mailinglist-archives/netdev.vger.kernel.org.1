Return-Path: <netdev+bounces-272341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEBdH0fxxWkkEgUAu9opvQ
	(envelope-from <netdev+bounces-272341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:53:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A333E934
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7481C3018D6B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FAA2D063A;
	Fri, 27 Mar 2026 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGYbQK2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA42BE035
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579334; cv=none; b=JChkUQpyVOShlyRB8GfWlZQCKnQSguFwuf6AL948wGIYr1Kbu+/CF1az9yBws+chV2xWmWMtrB+odQpxz1DAHe/FIcHw0Z3QVbEHYmzZ1HKs6/R2KGsk9D+y3kI1S4HTAhcn56j2bmsS84HKTxATuUsusigar5puKMi5pZjBmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579334; c=relaxed/simple;
	bh=xsj4Cs5IAwt7Pnl9ANDZ4ALej1e0ezWMGEcNvxQZ11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cU0gOYLLRiASZOaCHFdHXYxMJzhqHmLkNxdJQLSA/ac5mhjcpSWTsFAdT/nlrg0miSpP92XwOQSO2XSRanz9PRw9h+1DPTu0uhG/VUzTqI+2hGng6aSGdUjqKMOylvWc52ufu3pMiS3vNydDT/QU1OAX7jZzqovKlqdNiAVSGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGYbQK2z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b982d56dac4so258658866b.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579331; x=1775184131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vf9WbBMwCT487nD1xvHoA4rs1KXwmIjjzAnpLhCamsQ=;
        b=lGYbQK2zUuV2kPP/7f/W8hZi9IrgDAXNS2p+3Kxr8JJrd8PKnWlJDPlW02cJzTTG46
         BUhV/uEnWT/KVJpUorv0FbiLUaYaMW0w2XrZRuN2HO0ijCLilRqPAv497yEv3RasX4PK
         2k8zPJg9ggBaorUW/QDWDzO47/9Nl4mIRwMtbBEMXWh6/ngAlcq/vffZYh7zZBCITgr6
         ePLB64vBzL+GFsvwir+qSrjImAqDn7mmgroYo5phOhiQlHFhd6SwV5MNp77iTwWJvAUa
         67Zw4bA7ioZ22i7RWgbL0xv6AWOoF1iS83fvxPzDGShhH4HMnAq3OMrgZ0gwayXClLTH
         7KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579331; x=1775184131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf9WbBMwCT487nD1xvHoA4rs1KXwmIjjzAnpLhCamsQ=;
        b=TzPEmO+qGWAb1Tf2GTYjD9c+K9hGK2mj5tLh9YNsNDCe9ThJCffHKQaWfvHA4fm58h
         BkKMY0jJg0GIkkVOE87ICjttY9X7TvD44rZxAXL0SehdcDcjt6FAta4FMLc77RJn1aY4
         4VxRqtoDWjkSox5S+0XUwLwWpIZ3cVp6Iv/FwE+5DvXiXR6hh7AleQk9wfOfkZyCNKNb
         mEpuy8JBRg7QoWDgLuiGPMho2LLy/ESuU1iid1z1gMFIyGaf6CQV1HJwEuw9piYJYqSx
         rZZnkxoaqLcCgWxQYOq3VAxNPAdLreFQSLxYCgUTS2k+SWuNnI2yFIDbmeRPOJph1Tad
         Efxg==
X-Forwarded-Encrypted: i=1; AJvYcCU7DZU976sLrlBTV0sPEDYkg78feiPCt1qrm+4zpHcqfQ4ZU6o59QOkR8fCNUdF0qzmkFPT6Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfCWmgYMrjJ+ooLq3fPIOamRg/aiGzK7Pseq9HtqrX0GX+ZR4
	u/dhaUY/optxcZcsSJSKRuaMMTJOtwSedd87E0Hn/104DF8WKtXel1IO
X-Gm-Gg: ATEYQzz/ODASkU9FgjEs4ju4c7iW0JNoUxGI4GdzlH4g9sfQ2pEqRx7vUzntVGgJht7
	KUyvPc0P1sN136b4QDQ4aDCv7A/KU2FkKHoWy5UM5nC6Eu8OlpBWzdkPTG+1Ai+xnj8C/hbxW15
	Bxmne6fTLW1paQSa5BztMwiX1zGpXzewugDe/jxFM4mjXZKugu3/xMVeNPHQpFI8kWGiQySKG3z
	XybAaNVmDouYGZlE0f+OS1kz2YTRpTig9JPq378DLGMezE7uWMm2cVuHri9VD2e+oADiWebSmC4
	DrVPHTCCgbjom0gqyXmJQBt7jpFeqafMKMhnSByUSnShNahOKHPlza22bf5LIwN0/NiMxmS1nvh
	8a559i9vZDE3Q7M3hPKDG2jme4KnAURlaeRvv/DrFHK17wBFa4f9686dbdlmArS9ODaK94TOKyQ
	q2+zs=
X-Received: by 2002:a17:907:9621:b0:b98:13a:c92e with SMTP id a640c23a62f3a-b9b502b5aa6mr43788566b.2.1774579330829;
        Thu, 26 Mar 2026 19:42:10 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:270f::3e4:18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203ef450sm196663466b.47.2026.03.26.19.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:42:09 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Machata <petrm@nvidia.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH net-next v5] selftests: net: add tests for PPP
Date: Fri, 27 Mar 2026 10:41:46 +0800
Message-ID: <20260327024202.111655-1-dqfext@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-272341-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enneenne.com:email,pppoe.so:url,ppp_async.sh:url,pppoe.sh:url]
X-Rspamd-Queue-Id: 040A333E934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ping and iperf3 tests for ppp_async.c and pppoe.c.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v5: suppress SC2329 warning (cleanup called indirectly via trap)
 https://lore.kernel.org/netdev/20260326021642.29170-1-dqfext@gmail.com/

 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/net/ppp/Makefile      | 15 +++++++
 tools/testing/selftests/net/ppp/config        |  9 ++++
 tools/testing/selftests/net/ppp/ppp_async.sh  | 44 +++++++++++++++++++
 tools/testing/selftests/net/ppp/ppp_common.sh | 44 +++++++++++++++++++
 .../selftests/net/ppp/pppoe-server-options    |  2 +
 tools/testing/selftests/net/ppp/pppoe.sh      | 41 +++++++++++++++++
 8 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/net/ppp/Makefile
 create mode 100644 tools/testing/selftests/net/ppp/config
 create mode 100755 tools/testing/selftests/net/ppp/ppp_async.sh
 create mode 100644 tools/testing/selftests/net/ppp/ppp_common.sh
 create mode 100644 tools/testing/selftests/net/ppp/pppoe-server-options
 create mode 100755 tools/testing/selftests/net/ppp/pppoe.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..b922e154b9e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21080,6 +21080,7 @@ PPP PROTOCOL DRIVERS AND COMPRESSORS
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
index 000000000000..7ef98fe9d486
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/ppp_async.sh
@@ -0,0 +1,44 @@
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
+	# shellcheck disable=SC2329
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
+exit "$EXIT_STATUS"
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
index 000000000000..a93bb7d4ee8f
--- /dev/null
+++ b/tools/testing/selftests/net/ppp/pppoe.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ppp_common.sh
+
+VETH_SERVER="veth-server"
+VETH_CLIENT="veth-client"
+
+cleanup() {
+	# shellcheck disable=SC2329
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
+exit "$EXIT_STATUS"
-- 
2.43.0


