Return-Path: <netdev+bounces-239805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74820C6C7CA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 77E622CD7C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0021D3CC;
	Wed, 19 Nov 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exZE97+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14316288C24
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521078; cv=none; b=Ik2hB/F+MFLrh59KJSheOvvGLUGrTKPU6aSZElMENXTKAy+bzgpx81ZYaJgX1YK1F0ZEtT3EjaMcA5JHDfT+RskWw/dGz2NPnU6lEQJKM8NHalKx/bE9y9bxHb39NnMapJ04ZFZiUFq7KOO+RN/H0Z7+R3vn7xP82WMB8iwSPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521078; c=relaxed/simple;
	bh=R66wqwPToI0jl4HoRviYfQqu2zgI1SYRsSTbf+IIU1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXOMqO+Q3b5wk1ZsrDpAssGFO2wp1hV6IdQxOtXNOcQbC8GuPksqVOQmAVmWfdki0+g59OM/2/Ad2ZCtroAERCGdgPU1zcC6RcCFO17k7cGQEejMvLHEKkQtMGdp+9XWWJMw8exwiypFTUzfuAc26bS1p8qYyoVesPtm9SoTYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exZE97+o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2955623e6faso57276635ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763521075; x=1764125875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azMN/zG6EQFEJExTeSNW6ZCmGjVR1DXUOK19mT6eJ2c=;
        b=exZE97+o1IBZU+6l5YQc1cqicsZO1Xkbb9T79hHn+vIIwHUzPghgbdVe/hO+iZU17D
         1V63z/AdzH53LbG4YjZTy3RYnKUDZCcBkZ7jcNagzcanpQEi62m/WEAbkYCzw1nQ6fQR
         dKdyEj6/c5g92yx6P3OGm8jAISBdibg/zZ0CrPZm+Gfwb0U3RY+n65j5g31kRqJyk/lQ
         1soOZ5Lp2l34zpI1fRPpJFyGrgX7T9q2+XVW9MZjBvhA+H7V7BbLy5+ljuHMHM1ByIXb
         4v/l33n4PZGvNFWEpZd6pNPUo8/oV3zTlhloikJeq9RFCUbrxxCBzImnYyzTvKzZFxsn
         SDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763521075; x=1764125875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azMN/zG6EQFEJExTeSNW6ZCmGjVR1DXUOK19mT6eJ2c=;
        b=NhuA/pwGtyjOyjRpbADeOiUG7OfMXWNpurjblYE4yL7JEfpNMQG/i4P5KlD8thMnLP
         Dwwn6gbNr7lRuXwz/aMoUmUuLz6l7HcRleE6V4QBtdB5xO/XzSmXAiQl7lMKck1P040l
         hsIs71ruNEba54KitPJJ/Mvh4RVyM+4wrannBR9azzMqTWNw6iUyE5ovxq8ks3kiQotl
         p1rpGWwRzBOKGDJPg3teqkd8W0JfWzA9/+J78cSBDGsdExummRrC1rCGFHeYyNC+b311
         nwpTxumck6lv6PGZZ0DVbLjc1KRcR2pKuOy1svXE1UQTPdrJwK1jTs4+FpTBByVSioNO
         a3LA==
X-Gm-Message-State: AOJu0YxP8nkVeg86f5ovDly8pyvYdzoEoLWW3BZFwhlDup2TASAHix4j
	HTWzMM6cviAyrxx6H0PHfyJRcZ3V0RO2V64vrm5XEpbMVhgAbcMQD2WUDjucU2BL
X-Gm-Gg: ASbGnct1xKE+UUJMtUVs1oXxeLDwVS/rQpgCsAKJyS2ZtCNLenL5SkFpAlZvsBZX6Eh
	2E4tcVy7hWyk4rw2G+I5ncS1okbTv54rvzxrV7W6MVEHreTZb/BFBwA7vTRe5U+jBHma3mUk/d2
	zQuht1Qc2h3PilckbN7Wigkp1W9eeH2pGQo4uO+kenvKGmqbQBHL8gV8BtdLSZhX+2yfToTlXwW
	KwtqJmFpsqZrF7gVeyPkeVYkjagpuDJ4yIrnt1ONISad23NNTBeuG3w/8ame2jUer1nQamXcwLw
	aha+wd6mOh8jrPX9FvqmjGFLyDiOjOyw5TTP/ErXMtQvV6VMAJgHZyBsCtw+Xf8NEp8vmnEfJjK
	8tcwZ2DPWoTgd+yr+qON2V+R2oP+8TXtGnnwlyZ7334EQ2RL5butSJIgoz0PbbZY1eUidH9cMSJ
	MDTCjot66MyzuYQLA=
X-Google-Smtp-Source: AGHT+IFO//MOpSwafbf+h7eZH12LAIJ5phVMVuXzDfPtJXqcyI9mIJp+lFgm0xqilBpj1SX3wCs2FA==
X-Received: by 2002:a17:903:1a2f:b0:27c:56af:88ea with SMTP id d9443c01a7336-2986a76bce4mr191769535ad.60.1763521074968;
        Tue, 18 Nov 2025 18:57:54 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm185374175ad.21.2025.11.18.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:57:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next] tools: ynl: add YNL test framework
Date: Wed, 19 Nov 2025 02:57:42 +0000
Message-ID: <20251119025742.11611-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
ethtool functionality. The framework includes:

1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
   operations
2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
   feature gettings

The current YNL syntax is a bit obscure, and end users may not always know
how to use it. This test framework provides usage examples and also serves
as a regression test to catch potential breakages caused by future changes.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v6: rebase to latest net-next. update the shellcheck comment.
v5: add a comment about why disable shellcheck (Matthieu Baerts)
    move ktap_set_plan after setup (Matthieu Baerts)
    Use TESTS_NO to track the test number (Matthieu Baerts)
    Link: https://lore.kernel.org/netdev/20251117024457.3034-1-liuhangbin@gmail.com
v4: Use KTAP helper to report the test result (Matthieu Baerts)
    iterate through $(TESTS) instead of being hard coded (Donald Hunter)
    Link: https://lore.kernel.org/netdev/20251114034651.22741-1-liuhangbin@gmail.com
v3: add `make run_tests` to run all the tests at a time (Jakub Kicinski)
    use ipv4-or-v6 display hint for dual-stack fields (Jakub Kicinski)
    check sysfs in case of netdevsim buildin (Sabrina Dubroca)
    Link: https://lore.kernel.org/netdev/20251110100000.3837-1-liuhangbin@gmail.com
v2: move test from selftest to ynl folder (Jakub Kicinski)
    Link: https://lore.kernel.org/netdev/20251105082841.165212-1-liuhangbin@gmail.com
v1: Link: https://lore.kernel.org/netdev/20251029082245.128675-1-liuhangbin@gmail.com

---
 tools/net/ynl/Makefile                  |   8 +-
 tools/net/ynl/tests/Makefile            |  32 +++
 tools/net/ynl/tests/config              |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh     | 327 ++++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh | 222 ++++++++++++++++
 5 files changed, 593 insertions(+), 2 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 31ed20c0f3f8..a40591e513b7 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -12,7 +12,7 @@ endif
 libdir  ?= $(prefix)/$(libdir_relative)
 includedir ?= $(prefix)/include
 
-SUBDIRS = lib generated samples ynltool
+SUBDIRS = lib generated samples ynltool tests
 
 all: $(SUBDIRS) libynl.a
 
@@ -49,5 +49,9 @@ install: libynl.a lib/*.h
 	@echo -e "\tINSTALL pyynl"
 	@pip install --prefix=$(DESTDIR)$(prefix) .
 	@make -C generated install
+	@make -C tests install
 
-.PHONY: all clean distclean install $(SUBDIRS)
+run_tests:
+	@$(MAKE) -C tests run_tests
+
+.PHONY: all clean distclean install run_tests $(SUBDIRS)
diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
new file mode 100644
index 000000000000..38161217e249
--- /dev/null
+++ b/tools/net/ynl/tests/Makefile
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for YNL tests
+
+TESTS := \
+	test_ynl_cli.sh \
+	test_ynl_ethtool.sh \
+# end of TESTS
+
+all: $(TESTS)
+
+run_tests:
+	@for test in $(TESTS); do \
+		./$$test; \
+	done
+
+install: $(TESTS)
+	@mkdir -p $(DESTDIR)/usr/bin
+	@mkdir -p $(DESTDIR)/usr/share/kselftest
+	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(DESTDIR)/usr/share/kselftest/
+	@for test in $(TESTS); do \
+		name=$$(basename $$test .sh); \
+		sed -e 's|^ynl=.*|ynl="ynl"|' \
+		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
+		    -e 's|KSELFTEST_KTAP_HELPERS=.*|KSELFTEST_KTAP_HELPERS="/usr/share/kselftest/ktap_helpers.sh"|' \
+		    $$test > $(DESTDIR)/usr/bin/$$name; \
+		chmod +x $(DESTDIR)/usr/bin/$$name; \
+	done
+
+clean:
+	@# Nothing to clean
+
+.PHONY: all install clean run_tests
diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
new file mode 100644
index 000000000000..339f1309c03f
--- /dev/null
+++ b/tools/net/ynl/tests/config
@@ -0,0 +1,6 @@
+CONFIG_DUMMY=m
+CONFIG_INET_DIAG=y
+CONFIG_IPV6=y
+CONFIG_NET_NS=y
+CONFIG_NETDEVSIM=m
+CONFIG_VETH=m
diff --git a/tools/net/ynl/tests/test_ynl_cli.sh b/tools/net/ynl/tests/test_ynl_cli.sh
new file mode 100755
index 000000000000..7c0722a08117
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_cli.sh
@@ -0,0 +1,327 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL CLI functionality
+
+# Load KTAP test helpers
+KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
+# shellcheck source=../../../testing/selftests/kselftest/ktap_helpers.sh
+source "$KSELFTEST_KTAP_HELPERS"
+
+# Default ynl path for direct execution, can be overridden by make install
+ynl="../pyynl/cli.py"
+
+readonly NSIM_ID="1338"
+readonly NSIM_DEV_NAME="nsim${NSIM_ID}"
+readonly VETH_A="veth_a"
+readonly VETH_B="veth_b"
+
+testns="ynl-$(mktemp -u XXXXXX)"
+TESTS_NO=0
+
+# Test listing available families
+cli_list_families()
+{
+	if $ynl --list-families &>/dev/null; then
+		ktap_test_pass "YNL CLI list families"
+	else
+		ktap_test_fail "YNL CLI list families"
+	fi
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test netdev family operations (dev-get, queue-get)
+cli_netdev_ops()
+{
+	local dev_output
+	local ifindex
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+
+	dev_output=$(ip netns exec "$testns" $ynl --family netdev \
+		--do dev-get --json "{\"ifindex\": $ifindex}" 2>/dev/null)
+
+	if ! echo "$dev_output" | grep -q "ifindex"; then
+		ktap_test_fail "YNL CLI netdev operations (netdev dev-get output missing ifindex)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl --family netdev \
+		--dump queue-get --json "{\"ifindex\": $ifindex}" &>/dev/null; then
+		ktap_test_fail "YNL CLI netdev operations (failed to get netdev queue info)"
+		return
+	fi
+
+	ktap_test_pass "YNL CLI netdev operations"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test ethtool family operations (rings-get, linkinfo-get)
+cli_ethtool_ops()
+{
+	local rings_output
+	local linkinfo_output
+
+	rings_output=$(ip netns exec "$testns" $ynl --family ethtool \
+		--do rings-get --json "{\"header\": {\"dev-name\": \"$NSIM_DEV_NAME\"}}" 2>/dev/null)
+
+	if ! echo "$rings_output" | grep -q "header"; then
+		ktap_test_fail "YNL CLI ethtool operations (ethtool rings-get output missing header)"
+		return
+	fi
+
+	linkinfo_output=$(ip netns exec "$testns" $ynl --family ethtool \
+		--do linkinfo-get --json "{\"header\": {\"dev-name\": \"$VETH_A\"}}" 2>/dev/null)
+
+	if ! echo "$linkinfo_output" | grep -q "header"; then
+		ktap_test_fail "YNL CLI ethtool operations (ethtool linkinfo-get output missing header)"
+		return
+	fi
+
+	ktap_test_pass "YNL CLI ethtool operations"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test rt-route family operations
+cli_rt_route_ops()
+{
+	local ifindex
+
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-route"; then
+		ktap_test_skip "YNL CLI rt-route operations (rt-route family not available)"
+		return
+	fi
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+
+	# Add route: 192.0.2.0/24 dev $dev scope link
+	if ! ip netns exec "$testns" $ynl --family rt-route --do newroute --create \
+		--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null; then
+		ktap_test_fail "YNL CLI rt-route operations (failed to add route)"
+		return
+	fi
+
+	local route_output
+	route_output=$(ip netns exec "$testns" $ynl --family rt-route --dump getroute 2>/dev/null)
+	if echo "$route_output" | grep -q "192.0.2.0"; then
+		ktap_test_pass "YNL CLI rt-route operations"
+	else
+		ktap_test_fail "YNL CLI rt-route operations (failed to verify route)"
+	fi
+
+	ip netns exec "$testns" $ynl --family rt-route --do delroute \
+		--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test rt-addr family operations
+cli_rt_addr_ops()
+{
+	local ifindex
+
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-addr"; then
+		ktap_test_skip "YNL CLI rt-addr operations (rt-addr family not available)"
+		return
+	fi
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+
+	if ! ip netns exec "$testns" $ynl --family rt-addr --do newaddr \
+		--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null; then
+		ktap_test_fail "YNL CLI rt-addr operations (failed to add address)"
+		return
+	fi
+
+	local addr_output
+	addr_output=$(ip netns exec "$testns" $ynl --family rt-addr --dump getaddr 2>/dev/null)
+	if echo "$addr_output" | grep -q "192.0.2.100"; then
+		ktap_test_pass "YNL CLI rt-addr operations"
+	else
+		ktap_test_fail "YNL CLI rt-addr operations (failed to verify address)"
+	fi
+
+	ip netns exec "$testns" $ynl --family rt-addr --do deladdr \
+		--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test rt-link family operations
+cli_rt_link_ops()
+{
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-link"; then
+		ktap_test_skip "YNL CLI rt-link operations (rt-link family not available)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl --family rt-link --do newlink --create \
+		--json "{\"ifname\": \"dummy0\", \"linkinfo\": {\"kind\": \"dummy\"}}" &>/dev/null; then
+		ktap_test_fail "YNL CLI rt-link operations (failed to add link)"
+		return
+	fi
+
+	local link_output
+	link_output=$(ip netns exec "$testns" $ynl --family rt-link --dump getlink 2>/dev/null)
+	if echo "$link_output" | grep -q "$NSIM_DEV_NAME" && echo "$link_output" | grep -q "dummy0"; then
+		ktap_test_pass "YNL CLI rt-link operations"
+	else
+		ktap_test_fail "YNL CLI rt-link operations (failed to verify link)"
+	fi
+
+	ip netns exec "$testns" $ynl --family rt-link --do dellink \
+		--json "{\"ifname\": \"dummy0\"}" &>/dev/null
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test rt-neigh family operations
+cli_rt_neigh_ops()
+{
+	local ifindex
+
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-neigh"; then
+		ktap_test_skip "YNL CLI rt-neigh operations (rt-neigh family not available)"
+		return
+	fi
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+
+	# Add neighbor: 192.0.2.1 dev nsim1338 lladdr 11:22:33:44:55:66 PERMANENT
+	if ! ip netns exec "$testns" $ynl --family rt-neigh --do newneigh --create \
+		--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2, \"ndm-state\": 128}" &>/dev/null; then
+		ktap_test_fail "YNL CLI rt-neigh operations (failed to add neighbor)"
+	fi
+
+	local neigh_output
+	neigh_output=$(ip netns exec "$testns" $ynl --family rt-neigh --dump getneigh 2>/dev/null)
+	if echo "$neigh_output" | grep -q "192.0.2.1"; then
+		ktap_test_pass "YNL CLI rt-neigh operations"
+	else
+		ktap_test_fail "YNL CLI rt-neigh operations (failed to verify neighbor)"
+	fi
+
+	ip netns exec "$testns" $ynl --family rt-neigh --do delneigh \
+		--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2}" &>/dev/null
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test rt-rule family operations
+cli_rt_rule_ops()
+{
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-rule"; then
+		ktap_test_skip "YNL CLI rt-rule operations (rt-rule family not available)"
+		return
+	fi
+
+	# Add rule: from 192.0.2.0/24 lookup 100 none
+	if ! ip netns exec "$testns" $ynl --family rt-rule --do newrule \
+		--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null; then
+		ktap_test_fail "YNL CLI rt-rule operations (failed to add rule)"
+		return
+	fi
+
+	local rule_output
+	rule_output=$(ip netns exec "$testns" $ynl --family rt-rule --dump getrule 2>/dev/null)
+	if echo "$rule_output" | grep -q "192.0.2.0"; then
+		ktap_test_pass "YNL CLI rt-rule operations"
+	else
+		ktap_test_fail "YNL CLI rt-rule operations (failed to verify rule)"
+	fi
+
+	ip netns exec "$testns" $ynl --family rt-rule --do delrule \
+		--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+# Test nlctrl family operations
+cli_nlctrl_ops()
+{
+	local family_output
+
+	if ! family_output=$($ynl --family nlctrl \
+		--do getfamily --json "{\"family-name\": \"netdev\"}" 2>/dev/null); then
+		ktap_test_fail "YNL CLI nlctrl getfamily (failed to get nlctrl family info)"
+		return
+	fi
+
+	if ! echo "$family_output" | grep -q "family-name"; then
+		ktap_test_fail "YNL CLI nlctrl getfamily (nlctrl getfamily output missing family-name)"
+		return
+	fi
+
+	if ! echo "$family_output" | grep -q "family-id"; then
+		ktap_test_fail "YNL CLI nlctrl getfamily (nlctrl getfamily output missing family-id)"
+		return
+	fi
+
+	ktap_test_pass "YNL CLI nlctrl getfamily"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+setup()
+{
+	modprobe netdevsim &> /dev/null
+	if ! [ -f /sys/bus/netdevsim/new_device ]; then
+		ktap_skip_all "netdevsim module not available"
+		exit "$KSFT_SKIP"
+	fi
+
+	if ! ip netns add "$testns" 2>/dev/null; then
+		ktap_skip_all "failed to create test namespace"
+		exit "$KSFT_SKIP"
+	fi
+
+	echo "$NSIM_ID 1" | ip netns exec "$testns" tee /sys/bus/netdevsim/new_device >/dev/null 2>&1 || {
+		ktap_skip_all "failed to create netdevsim device"
+		exit "$KSFT_SKIP"
+	}
+
+	local dev
+	dev=$(ip netns exec "$testns" ls /sys/bus/netdevsim/devices/netdevsim$NSIM_ID/net 2>/dev/null | head -1)
+	if [[ -z "$dev" ]]; then
+		ktap_skip_all "failed to find netdevsim device"
+		exit "$KSFT_SKIP"
+	fi
+
+	ip -netns "$testns" link set dev "$dev" name "$NSIM_DEV_NAME" 2>/dev/null || {
+		ktap_skip_all "failed to rename netdevsim device"
+		exit "$KSFT_SKIP"
+	}
+
+	ip -netns "$testns" link set dev "$NSIM_DEV_NAME" up 2>/dev/null
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B" 2>/dev/null; then
+		ktap_skip_all "failed to create veth pair"
+		exit "$KSFT_SKIP"
+	fi
+
+	ip -n "$testns" link set "$VETH_A" up 2>/dev/null
+	ip -n "$testns" link set "$VETH_B" up 2>/dev/null
+}
+
+cleanup()
+{
+	ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
+	ip netns del "$testns" 2>/dev/null || true
+}
+
+# Check if ynl command is available
+if ! command -v $ynl &>/dev/null && [[ ! -x $ynl ]]; then
+	ktap_skip_all "ynl command not found: $ynl"
+	exit "$KSFT_SKIP"
+fi
+
+trap cleanup EXIT
+
+ktap_print_header
+setup
+ktap_set_plan "${TESTS_NO}"
+
+cli_list_families
+cli_netdev_ops
+cli_ethtool_ops
+cli_rt_route_ops
+cli_rt_addr_ops
+cli_rt_link_ops
+cli_rt_neigh_ops
+cli_rt_rule_ops
+cli_nlctrl_ops
+
+ktap_finished
diff --git a/tools/net/ynl/tests/test_ynl_ethtool.sh b/tools/net/ynl/tests/test_ynl_ethtool.sh
new file mode 100755
index 000000000000..b826269017f4
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
@@ -0,0 +1,222 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL ethtool functionality
+
+# Load KTAP test helpers
+KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
+# shellcheck source=../../../testing/selftests/kselftest/ktap_helpers.sh
+source "$KSELFTEST_KTAP_HELPERS"
+
+# Default ynl-ethtool path for direct execution, can be overridden by make install
+ynl_ethtool="../pyynl/ethtool.py"
+
+readonly NSIM_ID="1337"
+readonly NSIM_DEV_NAME="nsim${NSIM_ID}"
+readonly VETH_A="veth_a"
+readonly VETH_B="veth_b"
+
+testns="ynl-ethtool-$(mktemp -u XXXXXX)"
+TESTS_NO=0
+
+# Uses veth device as netdevsim doesn't support basic ethtool device info
+ethtool_device_info()
+{
+	local info_output
+
+	info_output=$(ip netns exec "$testns" $ynl_ethtool "$VETH_A" 2>/dev/null)
+
+	if ! echo "$info_output" | grep -q "Settings for"; then
+		ktap_test_fail "YNL ethtool device info (device info output missing expected content)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool device info"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_statistics()
+{
+	local stats_output
+
+	stats_output=$(ip netns exec "$testns" $ynl_ethtool --statistics "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$stats_output" | grep -q -E "(NIC statistics|packets|bytes)"; then
+		ktap_test_fail "YNL ethtool statistics (statistics output missing expected content)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool statistics"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_ring_params()
+{
+	local ring_output
+
+	ring_output=$(ip netns exec "$testns" $ynl_ethtool --show-ring "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$ring_output" | grep -q -E "(Ring parameters|RX|TX)"; then
+		ktap_test_fail "YNL ethtool ring parameters (ring parameters output missing expected content)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-ring "$NSIM_DEV_NAME" rx 64 2>/dev/null; then
+		ktap_test_fail "YNL ethtool ring parameters (set-ring command failed unexpectedly)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool ring parameters (show/set)"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_coalesce_params()
+{
+	if ! ip netns exec "$testns" $ynl_ethtool --show-coalesce "$NSIM_DEV_NAME" &>/dev/null; then
+		ktap_test_fail "YNL ethtool coalesce parameters (failed to get coalesce parameters)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-coalesce "$NSIM_DEV_NAME" rx-usecs 50 2>/dev/null; then
+		ktap_test_fail "YNL ethtool coalesce parameters (set-coalesce command failed unexpectedly)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool coalesce parameters (show/set)"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_pause_params()
+{
+	if ! ip netns exec "$testns" $ynl_ethtool --show-pause "$NSIM_DEV_NAME" &>/dev/null; then
+		ktap_test_fail "YNL ethtool pause parameters (failed to get pause parameters)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-pause "$NSIM_DEV_NAME" tx 1 rx 1 2>/dev/null; then
+		ktap_test_fail "YNL ethtool pause parameters (set-pause command failed unexpectedly)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool pause parameters (show/set)"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_features_info()
+{
+	local features_output
+
+	features_output=$(ip netns exec "$testns" $ynl_ethtool --show-features "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$features_output" | grep -q -E "(Features|offload)"; then
+		ktap_test_fail "YNL ethtool features info (features output missing expected content)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool features info (show/set)"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_channels_info()
+{
+	local channels_output
+
+	channels_output=$(ip netns exec "$testns" $ynl_ethtool --show-channels "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$channels_output" | grep -q -E "(Channel|Combined|RX|TX)"; then
+		ktap_test_fail "YNL ethtool channels info (channels output missing expected content)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-channels "$NSIM_DEV_NAME" combined-count 1 2>/dev/null; then
+		ktap_test_fail "YNL ethtool channels info (set-channels command failed unexpectedly)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool channels info (show/set)"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+ethtool_time_stamping()
+{
+	local ts_output
+
+	ts_output=$(ip netns exec "$testns" $ynl_ethtool --show-time-stamping "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$ts_output" | grep -q -E "(Time stamping|timestamping|SOF_TIMESTAMPING)"; then
+		ktap_test_fail "YNL ethtool time stamping (time stamping output missing expected content)"
+		return
+	fi
+
+	ktap_test_pass "YNL ethtool time stamping"
+}
+TESTS_NO=$((TESTS_NO + 1))
+
+setup()
+{
+	modprobe netdevsim &> /dev/null
+	if ! [ -f /sys/bus/netdevsim/new_device ]; then
+		ktap_skip_all "netdevsim module not available"
+		exit "$KSFT_SKIP"
+	fi
+
+	if ! ip netns add "$testns" 2>/dev/null; then
+		ktap_skip_all "failed to create test namespace"
+		exit "$KSFT_SKIP"
+	fi
+
+	echo "$NSIM_ID 1" | ip netns exec "$testns" tee /sys/bus/netdevsim/new_device >/dev/null 2>&1 || {
+		ktap_skip_all "failed to create netdevsim device"
+		exit "$KSFT_SKIP"
+	}
+
+	local dev
+	dev=$(ip netns exec "$testns" ls /sys/bus/netdevsim/devices/netdevsim$NSIM_ID/net 2>/dev/null | head -1)
+	if [[ -z "$dev" ]]; then
+		ktap_skip_all "failed to find netdevsim device"
+		exit "$KSFT_SKIP"
+	fi
+
+	ip -netns "$testns" link set dev "$dev" name "$NSIM_DEV_NAME" 2>/dev/null || {
+		ktap_skip_all "failed to rename netdevsim device"
+		exit "$KSFT_SKIP"
+	}
+
+	ip -netns "$testns" link set dev "$NSIM_DEV_NAME" up 2>/dev/null
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B" 2>/dev/null; then
+		ktap_skip_all "failed to create veth pair"
+		exit "$KSFT_SKIP"
+	fi
+
+	ip -n "$testns" link set "$VETH_A" up 2>/dev/null
+	ip -n "$testns" link set "$VETH_B" up 2>/dev/null
+}
+
+cleanup()
+{
+	ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
+	ip netns del "$testns" 2>/dev/null || true
+}
+
+# Check if ynl-ethtool command is available
+if ! command -v $ynl_ethtool &>/dev/null && [[ ! -x $ynl_ethtool ]]; then
+	ktap_skip_all "ynl-ethtool command not found: $ynl_ethtool"
+	exit "$KSFT_SKIP"
+fi
+
+trap cleanup EXIT
+
+ktap_print_header
+setup
+ktap_set_plan "${TESTS_NO}"
+
+ethtool_device_info
+ethtool_statistics
+ethtool_ring_params
+ethtool_coalesce_params
+ethtool_pause_params
+ethtool_features_info
+ethtool_channels_info
+ethtool_time_stamping
+
+ktap_finished
-- 
2.50.1


