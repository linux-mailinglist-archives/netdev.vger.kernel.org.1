Return-Path: <netdev+bounces-212909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899CB22799
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D13188D1EF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C728151C;
	Tue, 12 Aug 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDMQeRiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD3280A4B;
	Tue, 12 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003170; cv=none; b=I4RYmdKTb9o/Ov/HJlppQCLtvu/1Pvzo7xn7Io+7mRK1sON0Xn3F5fkUvecPViPslklEjkg/0D0RsvJeIOhF4uZtM3gU2IaT3Qy8zame2nNrRWqJfHO1C/aAE6uv7mJd+0i6MiFeVtoSExcc9nC8mh0MMegZtWOngnoIZ1wqBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003170; c=relaxed/simple;
	bh=n4ELKnV7jIl0+1lW2DQi8lUwFMi+5+dywheFxhIobFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8Km7k++y0L1y35OkW1IqzqQSkpkf650yQwVHfb+GHMzssRpGuwp3XsoKJAUrNUmtZH9m1RrFq25V7JYwrxS/tpTZMF12G1aCbnBbKvXTes7jePuf4Y+WojXb4R2mAYNmA7WPN0JpykVKGC3OS1k6t9GrvMX1Vtns8220Z2bDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDMQeRiF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b914a9c77dso305488f8f.2;
        Tue, 12 Aug 2025 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003166; x=1755607966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJOro309rX4Wa3welMZVLgwK6SeC0RoTfCmmnfx70t8=;
        b=KDMQeRiFqM3vyBPoFmQgQW8OSjYzNs4XfpZUcavjY/CWnyEnuIBjWOUo+KcRovjjKE
         HWqSQouBHYCu59a1y8CN5QCHGSPbakiw/XsAGMb0tRQRk9hO4DWc67P6o/ccKiYdDHf4
         Aor/RE0C4qwZgJgKhWIZyYeOogSeLC0LBH8oA1+KNz3OAnS85gW6T1BI7J4Llh1kwD9+
         ZPf8rIZmCfXg1Ej4xL+EvwZk2nanfHyuRhBWvjoXVwE+3utenQklK+LxmspQsnWTSgSi
         ieS1NvgwnpDFf3tdos3Z64aGlfQQ3ZdmdRAOpZdGRp++bq8aYVW/jcP6vEsfpNFJoV0o
         19Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003166; x=1755607966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJOro309rX4Wa3welMZVLgwK6SeC0RoTfCmmnfx70t8=;
        b=qcI5B7MkNRAwoGW8V30DTdVf+GqJA1lZ/XrFyu0/5kbSnC4LUsBmwvWH10LwPOXAV7
         lzHQtmrq068U9HCLVQA8PJ4dy48fUTPS7tiF8Nwi+oVqGgYmTzwNss9r/MtmTDI9Jrli
         nvOuTssnyMaRv4MWTbyyT+njVNa7eBFXjJ0hSaEmk/SoiyissuT0asO4vXH2afU1ipFm
         yoPo4hgpqrrZzrXKZlEry6BwBA5UF2dM2/0L6dXYWzwuBL5eKF8eQijz7oSi+KLu+BQ8
         64WTRE8o7GuI7zbRHbWjs9y9XjFXIm7AHuXQyuZpuDu13fj/vyw8U1tzHTdk1jM7atky
         fpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIy9ciwAGg9ThjanpTA4Q5xAk1JWe8iMT3XtJnq/zsbIabavyCX3Yv43HPE1PEXRhvA08CRm46+qZBdVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJQB/z9VTAurHHiZut+LYYnXVlkoO4reGOJVYC0OQ4i2RlN2M
	+n60dSbJbBZtYHJN4RyuNDWJbW4PQRPJk4w6WyX0kuxzhnJk7vnx9cm42NLZ5s1bc+SJDg==
X-Gm-Gg: ASbGnct/N0//1+w3f3pyLQb0xRty9/FPRJziXFnubhY9V7BiM+XfqexZvfRt+p1tP4F
	H5RSgS3wRhkocQhYEq/G29uynAVnXmQyQpi5GIqGDo9wBk4c4aLaPNVpMeSe3/Qc1OlWg60OMOi
	n06tPs81gN5XEyZSJEUstxwcKx6IkiFsJZRaDmWB5OFcABvw1Bne15WctHPc7l9JOiNpd4PZD3J
	Oqngk/kWoiO3XfNBWcQAWD9U5iRe+S2z1tTh3ge1j9qnTXjeE9mgB9aN/GbsLWVx90IduQLvLto
	cbwQgZ2LLDw78oa3g8PO0KpLR+qR1U5aYJi/58ICpevAcqoEbO7bl0xnSt0kfBNhIjrSibAFvM+
	9gqo09BtqWVNQlDr4yxGbtWOjFC3tVeCEVIg+EA4XV71h
X-Google-Smtp-Source: AGHT+IEpMThsR4gQcuq+tmcVaiTlHtydYrEaD+CU65Sm6QGeVCAZrsNuyv7VrWgE+icZuWwdzAxbgQ==
X-Received: by 2002:a05:6000:18a8:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3b900b2d56cmr12107268f8f.16.1755003166238;
        Tue, 12 Aug 2025 05:52:46 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b914e70596sm1106392f8f.61.2025.08.12.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:45 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 5/5] selftests/net: add vxlan localbind selftest
Date: Tue, 12 Aug 2025 14:51:55 +0200
Message-Id: <20250812125155.3808-6-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test to make sure the localbind netlink option works
in VXLAN interfaces.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/test_vxlan_localbind.sh     | 306 ++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_localbind.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..9305601f4eba 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_PROGS += test_vxlan_localbind.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/test_vxlan_localbind.sh b/tools/testing/selftests/net/test_vxlan_localbind.sh
new file mode 100755
index 000000000000..60b97a578c74
--- /dev/null
+++ b/tools/testing/selftests/net/test_vxlan_localbind.sh
@@ -0,0 +1,306 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test is for checking the VXLAN localbind option.
+#
+# It simulates two hypervisors running a VM each using four network namespaces:
+# two for the HVs, two for the VMs.
+# A small VXLAN tunnel is made between the two hypervisors to have the two vms
+# in the same virtual L2, connected through two separate subnets:
+#
+# +-------------------+                                    +-------------------+
+# |                   |                                    |                   |
+# |    vm-1 netns     |                                    |    vm-2 netns     |
+# |                   |                                    |                   |
+# |  +-------------+  |                                    |  +-------------+  |
+# |  |   veth-hv   |  |                                    |  |   veth-hv   |  |
+# |  | 10.0.0.1/24 |  |                                    |  | 10.0.0.2/24 |  |
+# |  +-------------+  |                                    |  +-------------+  |
+# |        .          |                                    |         .         |
+# +-------------------+                                    +-------------------+
+#          .                                                         .
+#          .                                                         .
+#          .                                                         .
+# +-----------------------------------+   +------------------------------------+
+# |        .                          |   |                          .         |
+# |  +----------+                     |   |                     +----------+   |
+# |  | veth-tap |                     |   |                     | veth-tap |   |
+# |  +----+-----+                     |   |                     +----+-----+   |
+# |       |                           |   |                          |         |
+# |    +--+--+                        |   |                       +--+--+      |
+# |    | br0 |                        |   |                       | br0 |      |
+# |    +--+--+                        |   |                       +--+--+      |
+# |       |                           |   |                          |         |
+# |   +---+----+  +--------+--------+ |   | +--------+--------+  +---+----+    |
+# |   | vxlan0 |..|      veth0      |.|...|.|      veth0      |..| vxlan0 |    |
+# |   +--------+  | 172.16.1.1/24   | |   | | 172.16.1.2/24   |  +--------+    |
+# |               | 172.16.2.1/24   | |   | | 172.16.2.2/24   |                |
+# |               +-----------------+ |   | +-----------------+                |
+# |                                   |   |                                    |
+# |             hv-1 netns            |   |           hv-2 netns               |
+# |                                   |   |                                    |
+# +-----------------------------------+   +------------------------------------+
+#
+# This tests the connectivity between vm-1 and vm-2 using different subnet and
+# localbind configurations.
+
+source lib.sh
+ret=0
+
+TESTS="
+    same_subnet
+    same_subnet_localbind
+    different_subnets
+    different_subnets_localbind
+"
+
+VERBOSE=0
+PAUSE_ON_FAIL=no
+PAUSE=no
+
+################################################################################
+# Utilities
+
+which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ ${rc} -eq ${expected} ]; then
+		printf "TEST: %-60s  [ OK ]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "$VERBOSE" = "1" ]; then
+			echo "    rc=$rc, expected $expected"
+		fi
+
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read a
+		[ "$a" = "q" ] && exit 1
+	fi
+
+	[ "$VERBOSE" = "1" ] && echo
+}
+
+run_cmd()
+{
+	local cmd="$1"
+	local out
+	local stderr="2>/dev/null"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "COMMAND: $cmd\n"
+		stderr=
+	fi
+
+	out=$(eval $cmd $stderr)
+	rc=$?
+	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
+		echo "    $out"
+	fi
+
+	return $rc
+}
+
+check_hv_connectivity() {
+    slowwait 5 ip netns exec $hv_1 ping -c 1 -W 1 172.16.1.2 &>/dev/null
+    slowwait 5 ip netns exec $hv_1 ping -c 1 -W 1 172.16.2.2 &>/dev/null
+
+	return $?
+}
+
+check_vm_connectivity() {
+    if [ $2 -eq 1 ]; then
+        prefix="! "
+    else
+        prefix=""
+    fi
+
+	slowwait 5 run_cmd "${prefix}ip netns exec $vm_1 ping -c 1 -W 1 10.0.0.2"
+	log_test $? 0 "VM connectivity over $1"
+}
+
+################################################################################
+# Setup
+
+setup-hv-networking() {
+    id=$1
+    local=$2
+    remote=$3
+    flags=$4
+
+    [ $id -eq 1 ] && peer=2 || peer=1
+
+    ip link set veth-hv-$id netns ${hv[$id]}
+    ip -netns ${hv[$id]} link set veth-hv-$id name veth0
+    ip -netns ${hv[$id]} link set veth0 up
+
+    ip -netns ${hv[$id]} addr add 172.16.1.$id/24 dev veth0
+    ip -netns ${hv[$id]} addr add 172.16.2.$id/24 dev veth0
+
+    ip -netns ${hv[$id]} link add br0 type bridge
+    ip -netns ${hv[$id]} link set br0 up
+
+    ip -netns ${hv[$id]} link add vxlan0 type vxlan id 10 local 172.16.$local.$id remote 172.16.$remote.$peer $flags dev veth0 dstport 4789
+    ip -netns ${hv[$id]} link set vxlan0 master br0
+    ip -netns ${hv[$id]} link set vxlan0 up
+
+    bridge -netns ${hv[$id]} fdb append 00:00:00:00:00:00 dev vxlan0 dst 172.16.$remote.$peer self permanent
+}
+
+setup-vm() {
+    id=$1
+
+    ip link add veth-tap type veth peer name veth-hv
+
+    ip link set veth-tap netns ${hv[$id]}
+    ip -netns ${hv[$id]} link set veth-tap master br0
+    ip -netns ${hv[$id]} link set veth-tap up
+
+    ip link set veth-hv address 02:1d:8d:dd:0c:6$id
+
+    ip link set veth-hv netns ${vm[$id]}
+    ip -netns ${vm[$id]} addr add 10.0.0.$id/24 dev veth-hv
+    ip -netns ${vm[$id]} link set veth-hv up
+}
+
+setup()
+{
+    setup_ns hv_1 hv_2 vm_1 vm_2
+    hv[1]=$hv_1
+    hv[2]=$hv_2
+    vm[1]=$vm_1
+    vm[2]=$vm_2
+
+    # Setup "Hypervisors" simulated with netns
+    ip link add veth-hv-1 type veth peer name veth-hv-2
+    setup-hv-networking 1 1 2 $2
+    setup-hv-networking 2 $1 1 $2
+    setup-vm 1
+    setup-vm 2
+}
+
+cleanup() {
+    ip link del veth-hv-1 2>/dev/null || true
+    ip link del veth-tap 2>/dev/null || true
+
+    cleanup_ns $hv_1 $hv_2 $vm_1 $vm_2
+}
+
+################################################################################
+# Tests
+
+same_subnet()
+{
+	setup 2 "nolocalbind"
+    check_hv_connectivity
+    check_vm_connectivity "same subnet (nolocalbind)" 0
+}
+
+same_subnet_localbind()
+{
+	setup 2 "localbind"
+    check_hv_connectivity
+    check_vm_connectivity "same subnet (localbind)" 0
+}
+
+different_subnets()
+{
+	setup 1 "nolocalbind"
+    check_hv_connectivity
+    check_vm_connectivity "different subnets (nolocalbind)" 0
+}
+
+different_subnets_localbind()
+{
+	setup 1 "localbind"
+    check_hv_connectivity
+    check_vm_connectivity "different subnets (localbind)" 1
+}
+
+################################################################################
+# Usage
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+        -t <test>   Test(s) to run (default: all)
+                    (options: $TESTS)
+        -p          Pause on fail
+        -P          Pause after each test before cleanup
+        -v          Verbose mode (show commands and output)
+EOF
+}
+
+################################################################################
+# Main
+
+trap cleanup EXIT
+
+while getopts ":t:pPvh" opt; do
+	case $opt in
+		t) TESTS=$OPTARG ;;
+		p) PAUSE_ON_FAIL=yes;;
+		P) PAUSE=yes;;
+		v) VERBOSE=$(($VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+# Make sure we don't pause twice.
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit $ksft_skip;
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+if [ ! -x "$(command -v bridge)" ]; then
+	echo "SKIP: Could not run test without bridge tool"
+	exit $ksft_skip
+fi
+
+ip link help vxlan 2>&1 | grep -q "localbind"
+if [ $? -ne 0 ]; then
+	echo "SKIP: iproute2 ip too old, missing VXLAN localbind support"
+	exit $ksft_skip
+fi
+
+cleanup
+
+for t in $TESTS
+do
+	$t; cleanup;
+done
+
+if [ "$TESTS" != "none" ]; then
+	printf "\nTests passed: %3d\n" ${nsuccess}
+	printf "Tests failed: %3d\n"   ${nfail}
+fi
+
+exit $ret
+
-- 
2.36.1


