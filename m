Return-Path: <netdev+bounces-238574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B270CC5B3CC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 04:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5074E61C7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92126B77D;
	Fri, 14 Nov 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Y5gCrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51C2522A7
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092048; cv=none; b=RhSy7rCqWbkr2FZDwHqA8h7P0d1PEa2dL7kKm6YcIxWFG8YfPy5vjtX3BvTA4MVX9LC+qSvT0g4u1JLS2VnDCMYaPaybC2q8nIJyXpcTlkSFnQe3jzaCFN+TpitAhNu5sDA135Ju5/OAgmb6PS68/h3ZxUl6R/6zK9iRdPRVWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092048; c=relaxed/simple;
	bh=AnuqjTG7lLiJ1Bj1d3JSSd1FzUhLNB4NkMY4T8xmkxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPiH5AJUKaSXGXDpeipkkJspxCWX6HIQHYuOch7U6LatpZ56oo6CZVTfVe2yaou3edtgwokKopaEEc0cPIXXuhCRtopgCh81rNAbEVab2ZIRYhvNW7597kZK9MZc0YNGCah/sk+aGmM+kzR0sBVQ2SPqYpD79UMVh5ZRuFNGyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2Y5gCrw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1162569b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763092045; x=1763696845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHF0vsI1or3EwPBkBUJs+p8GqfeYNka2E3iCS/ZRQVU=;
        b=D2Y5gCrwhGZ/VxBBhf8PvbEt0nqCSpUPgzvN28uHthcqtzz8cv2NiVnpdzNfkJCcj2
         vqM57/qctyGUfdl+XygksRjaIE3UhmbCv05zrmxJCX5ZjwPKwzmhXbi/7sM2pRtm/TYs
         CcpKpidi8rP8OM3xnperkVLrFtAKCW1tp7bNERetIWJU4VF2VP9+iDPd5M4xYHWBWEMr
         P8MdSZjH6cQKnEuagFk7rbbgoCqJ8GGL5BHRb2N6s4+VIe9y19WCxJzcEt4YLU2En57k
         pIhNhDabfDFQG03vqd6FeFheWNum4RyC3vdIKRl/wE7Mgvxq6Io67ckaqkOPr5fckrCr
         6bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763092045; x=1763696845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHF0vsI1or3EwPBkBUJs+p8GqfeYNka2E3iCS/ZRQVU=;
        b=JZZuZZ/DgW/Pe2BrPNYZmraelXrDVW+NNtVoyeQTGUW3XdtHiYNQmvmpphGO+ldqf9
         z9o6a986posyBECBlGq5CDJNj7gpYGz5SRcrsX0FbMEqkqw+DU7FkFwBSYAbrDRevQkc
         tljmPPa183HV3rD+v7eY8j46sqdS73zDiDkiJqQP0S9MLcXQKFPkWI1AE2hThVtT2ewW
         Qzye6p9TBs0lce3CcmpEmBbGKseuBeZusptlafGNsd9zKOMXBUFYBOg5ok2+/FQUV1EG
         GGKXf3tZVxz/AwaQ2+bbgCv0R2ML6pCg07EgBQRHUy+mscGsDSnbKZQr6V1Hepu8mXtW
         cMxA==
X-Gm-Message-State: AOJu0YxH7SY0dG1MYVPAj5lPfZV2Gu2STheea8QOG6uZGPx5IOBvDnDf
	3SumEUhYVlNN1O2O4PjdT5oI0jXGhaJAxu+JQubYHaV92KD+j7SKUdqGgSvs+4E1Qlo=
X-Gm-Gg: ASbGncviSLbZ9Zdv4tD0m82BOBw2nrDWvm2AiWapakmoJk4EWYikGeWXhBTTABmUzYY
	cSDOUj4nu4GlpxpsAaJ2d/R53IIGhIl2LkvtLRUdDfTE7p7Sw48INGS1TqRL1c1+YUPwdWsfMJQ
	iPp5qnEgP+eBRhs4o+IzrkXBVenfhkk+kgbLUiz6jJUPhXmopNgUfCEE3JI6ivwVeneZTCNCwi1
	rlFa6Ct8nyRzpd3P94aN2ZW8P9Dl4FgxNF/yAPCafumA6sFgKDltpaVXB7RDNunWI5gUwFQ9w/R
	5myqLNzCZfGUYqJ8YhAVrASjQPMYM5SuMi8YlXYslBaOjPFcJg5EqqnaljfnuFeAflosTWZHurC
	nRP3tdO9sXJ9Pmsimcn32nOT1xFoOobLo/X4lWDkwf+xW+AcIAM+7rJutjTdXyjQIjy8OCSHJCP
	CKb1bV
X-Google-Smtp-Source: AGHT+IFOTMCB3ox6XA66Vmo0l51vyDC8w1A0+06HL3TGbRY9Z8fGGFse4rpJXXECiyGsWWclCDfELQ==
X-Received: by 2002:a05:6a00:3e1b:b0:7b8:87e1:a648 with SMTP id d2e1a72fcca58-7ba39bbfdcdmr1734250b3a.3.1763092045028;
        Thu, 13 Nov 2025 19:47:25 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826273sm3669756b3a.52.2025.11.13.19.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:47:24 -0800 (PST)
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
Subject: [PATCHv4 net-next 3/3] tools: ynl: add YNL test framework
Date: Fri, 14 Nov 2025 03:46:51 +0000
Message-ID: <20251114034651.22741-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114034651.22741-1-liuhangbin@gmail.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/Makefile                  |   8 +-
 tools/net/ynl/tests/Makefile            |  32 +++
 tools/net/ynl/tests/config              |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh     | 309 ++++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh | 206 ++++++++++++++++
 5 files changed, 559 insertions(+), 2 deletions(-)
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
index 000000000000..f40eecbb9701
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_cli.sh
@@ -0,0 +1,309 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL CLI functionality
+
+# Load KTAP test helpers
+KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
+# shellcheck disable=SC1090
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
+
+# Test listing available families
+cli_list_families() {
+	if $ynl --list-families &>/dev/null; then
+		ktap_test_pass "YNL CLI list families"
+	else
+		ktap_test_fail "YNL CLI list families"
+	fi
+}
+
+# Test netdev family operations (dev-get, queue-get)
+cli_netdev_ops() {
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
+
+# Test ethtool family operations (rings-get, linkinfo-get)
+cli_ethtool_ops() {
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
+
+# Test rt-route family operations
+cli_rt_route_ops() {
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
+
+# Test rt-addr family operations
+cli_rt_addr_ops() {
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
+
+# Test rt-link family operations
+cli_rt_link_ops() {
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
+
+# Test rt-neigh family operations
+cli_rt_neigh_ops() {
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
+
+# Test rt-rule family operations
+cli_rt_rule_ops() {
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
+
+# Test nlctrl family operations
+cli_nlctrl_ops() {
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
+
+setup() {
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
+cleanup() {
+	if [[ -n "$testns" ]]; then
+		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
+		ip netns del "$testns" 2>/dev/null || true
+	fi
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
+ktap_set_plan 9
+setup
+
+# Run all tests
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
index 000000000000..01cb9d87f7fa
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
@@ -0,0 +1,206 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL ethtool functionality
+
+# Load KTAP test helpers
+KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests/kselftest/ktap_helpers.sh"
+# shellcheck disable=SC1090
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
+
+# Uses veth device as netdevsim doesn't support basic ethtool device info
+ethtool_device_info() {
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
+
+ethtool_statistics() {
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
+
+ethtool_ring_params() {
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
+
+ethtool_coalesce_params() {
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
+
+ethtool_pause_params() {
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
+
+ethtool_features_info() {
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
+
+ethtool_channels_info() {
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
+
+ethtool_time_stamping() {
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
+
+setup() {
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
+cleanup() {
+	if [[ -n "$testns" ]]; then
+		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
+		ip netns del "$testns" 2>/dev/null || true
+	fi
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
+ktap_set_plan 8
+setup
+
+# Run all tests
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


