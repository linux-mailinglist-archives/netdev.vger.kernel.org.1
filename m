Return-Path: <netdev+bounces-237140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3DC45D04
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24F3F4F24D8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19530275B;
	Mon, 10 Nov 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlIIXtEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F3301710
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768863; cv=none; b=P0wwbuBdMSnLxDbSsQN2uUWMvH40rGB9Nr6XBcvOd13xOy+dEB8BX9A3RFnDgjlFeudJGknAzZYKXX8oB3cx5CzikAfDalYjrq0M6ilFgXEOONdwPHT9GMg8zJfybLAJsHetNeNKqGZmzccSno7fr2LS2qqk0s30q2RRoFtdgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768863; c=relaxed/simple;
	bh=mCQi8Rt3y3H+89psUzQKvPVfOB7J6ZXquDRvAuWmoqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrBCzuB5wCPKkO8cMTAwXs1F1Rrv3Rqxyso3GWDq7BX3tMyLQRsbvFsK01b3uzFlMuAQSgjtFtL3nhnZ514ZPaZDzgErycHbhW4YKnBxqtJq6WOae4nEUya0NXbuyJeQB7maRnf63JVqeBsZH6nygbeZh0voFn96fTimzbIn2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlIIXtEe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so1081077a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768860; x=1763373660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHT18jJa4hRTv9xV2ESahIGuiQTuPCvHqqMF2WMo/IQ=;
        b=nlIIXtEeRTQmzejSYFpat8ApO5KT/JU8yS/5Eg/XNk3/7pwP3SFZ8XzIR21voR4b00
         jMDSKvIAzqeNTfsBMC5iuVqJ16Qy0PlMr8f5cMHHMfz+ZVPTPJbYfH3SxpBuCVTKG2b2
         yNSID6t+H+WT1Y62mOrQsrNBYLLeW3PNXFdMBMZ6l2AMyeYc+EoG4H2sOhXmm365gJsu
         uUGEuniQKJJd9VNQX3IVKS7pW3I8Ub+FtbpJIqmIAznl58busAOzPIoMyZOEITaTEjYx
         lPlBfkrtdaxotRFKe7w848MBYiYGYHIj34cArtZMYqyPUlQroBqGz5AKnTHU4Xa9QcQI
         SBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768860; x=1763373660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHT18jJa4hRTv9xV2ESahIGuiQTuPCvHqqMF2WMo/IQ=;
        b=f7ycXxvU/43rdPlLsQo8XoSeGvC8gcafUG/z0NHX6WZ7t4HaURcazoC1fCcaOOO4DV
         6d+PaXgG4aF8RXDA8fUbxGqdiSCV48itcW5GdJj7irfBJiNkVvVYwj+/rfzVU8Jo/F2C
         6wjGfHYDRqTboNlN0HhzWyKMtVVYdCOaiiuetZXsF1YwCX8cXnNj9L1qekWafm65cMiC
         D0j1lSqsPk4+DlSkMhDVFB10kh2JUFrWE05tdNwawl9scrHhR4H7ykCI4zHZHzfX0Uiy
         vlojCSIdByhYVCscxGCxxCKwEO8/8yqOYxSEzNqyLYo+oN4gvShTlIXVPuJSuUgeB/Nt
         D0mg==
X-Gm-Message-State: AOJu0YzbR0NZNHhNJ4BFEtJKxs6xYkPSsBFFVjue69YWEQ1bQh7nBqxY
	uYy+WlX/A2fvFLlVcgEYPvTYF0QaKZecibFFmFbcw5MHRKLG7sZxZpsmrtVwsjBT
X-Gm-Gg: ASbGncuyIONZ6XZ2EuY2NGFBXN9g6deaXR+O3+bBqqP1MrEdS9oa1fh1KvHeiATCCI1
	TNFGXqXZiGvnbBuRvFISZNtLrkA/O2o8IUpe0EoBtpsvvbg4OU6JpxjdeJn+V5mm/WoxKTAUEz+
	eY4k5o3u3Uid3XSUmzfi6HzBaEPZjtPaonuWA8F8EIvc3RaDD55iM5l3NdcLO7GQFPzeL0ZnqWz
	ex53QIgEzq94IxyA4hEHgp8VWesh7r+zPWQboa8CQ42GOuAY9uJR9CgcM6C1RqHV4LidNmfJjs8
	6mKbiTautCRR1LrPoMfLQvbfhs95ZALnlp9DGvM6hw0EeIcSb2Qjv5Fo05wqFMnQIPJ3YAEO2H4
	TJ6jfxf2GPmjqC4IpDC07uFtq9K4iGwNqHhIZwx0cmg4/Utc7df3SomUyHsWxxjnRF4cXoBF4Pu
	4f5WvT
X-Google-Smtp-Source: AGHT+IFsfh9SnqDXF5mx0UrEvC37Yt1SFnVidPfKQaZi2cJcpOWB3TEAemVzKZF3sUw26TBTN/rwhg==
X-Received: by 2002:a17:90a:da8b:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-3436cba9413mr9910564a91.26.1762768859904;
        Mon, 10 Nov 2025 02:00:59 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm10374405a91.13.2025.11.10.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:00:59 -0800 (PST)
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
Subject: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Date: Mon, 10 Nov 2025 10:00:00 +0000
Message-ID: <20251110100000.3837-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110100000.3837-1-liuhangbin@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
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
 tools/net/ynl/tests/Makefile            |  38 ++++
 tools/net/ynl/tests/config              |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh     | 291 ++++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh | 196 ++++++++++++++++
 5 files changed, 537 insertions(+), 2 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 211df5a93ad9..8a328972564a 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -12,7 +12,7 @@ endif
 libdir  ?= $(prefix)/$(libdir_relative)
 includedir ?= $(prefix)/include
 
-SUBDIRS = lib generated samples
+SUBDIRS = lib generated samples tests
 
 all: $(SUBDIRS) libynl.a
 
@@ -48,5 +48,9 @@ install: libynl.a lib/*.h
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
index 000000000000..4d527f9c3de9
--- /dev/null
+++ b/tools/net/ynl/tests/Makefile
@@ -0,0 +1,38 @@
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
+	@echo "Running YNL tests..."
+	@failed=0; \
+	echo "Running test_ynl_cli.sh..."; \
+	./test_ynl_cli.sh || failed=$$(($$failed + 1)); \
+	echo "Running test_ynl_ethtool.sh..."; \
+	./test_ynl_ethtool.sh || failed=$$(($$failed + 1)); \
+	if [ $$failed -eq 0 ]; then \
+		echo "All tests passed!"; \
+	else \
+		echo "$$failed test(s) failed!"; \
+		exit 1; \
+	fi
+
+install: $(TESTS)
+	@mkdir -p $(DESTDIR)/usr/bin
+	@for test in $(TESTS); do \
+		name=$$(basename $$test .sh); \
+		sed -e 's|^ynl=.*|ynl="ynl"|' \
+		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
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
index 000000000000..5cc0624ffaad
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_cli.sh
@@ -0,0 +1,291 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL CLI functionality
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
+		echo "PASS: YNL CLI list families"
+	else
+		echo "FAIL: YNL CLI list families"
+	fi
+}
+
+# Test netdev family operations (dev-get, queue-get)
+cli_netdev_ops() {
+	local dev_output
+	local ifindex
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+	if [[ -z "$ifindex" ]]; then
+		echo "FAIL: YNL CLI netdev operations (failed to get ifindex)"
+		return
+	fi
+
+	dev_output=$(ip netns exec "$testns" $ynl --family netdev \
+		--do dev-get --json "{\"ifindex\": $ifindex}" 2>/dev/null)
+
+	if ! echo "$dev_output" | grep -q "ifindex"; then
+		echo "FAIL: YNL CLI netdev operations (netdev dev-get output missing ifindex)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl --family netdev \
+		--dump queue-get --json "{\"ifindex\": $ifindex}" &>/dev/null; then
+		echo "FAIL: YNL CLI netdev operations (failed to get netdev queue info)"
+		return
+	fi
+
+	echo "PASS: YNL CLI netdev operations"
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
+		echo "FAIL: YNL CLI ethtool operations (ethtool rings-get output missing header)"
+		return
+	fi
+
+	linkinfo_output=$(ip netns exec "$testns" $ynl --family ethtool \
+		--do linkinfo-get --json "{\"header\": {\"dev-name\": \"$VETH_A\"}}" 2>/dev/null)
+
+	if ! echo "$linkinfo_output" | grep -q "header"; then
+		echo "FAIL: YNL CLI ethtool operations (ethtool linkinfo-get output missing header)"
+		return
+	fi
+
+	echo "PASS: YNL CLI ethtool operations"
+}
+
+# Test rt-* family operations (route, addr, link, neigh, rule)
+cli_rt_ops() {
+	local ifindex
+
+	if ! $ynl --list-families 2>/dev/null | grep -q "rt-"; then
+		echo "SKIP: YNL CLI rt-* operations (no rt-* families available)"
+		return
+	fi
+
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
+	if [[ -z "$ifindex" ]]; then
+		echo "FAIL: YNL CLI rt-* operations (failed to get ifindex)"
+		return
+	fi
+
+
+	# Test rt-route family
+	if $ynl --list-families 2>/dev/null | grep -q "rt-route"; then
+		# Add route: 192.0.2.0/24 dev $dev scope link
+		if ip netns exec "$testns" $ynl --family rt-route --do newroute --create \
+			--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null; then
+
+			local route_output
+			route_output=$(ip netns exec "$testns" $ynl --family rt-route --dump getroute 2>/dev/null)
+			if echo "$route_output" | grep -q "192.0.2.0"; then
+				echo "PASS: YNL CLI rt-route operations"
+			else
+				echo "FAIL: YNL CLI rt-route operations (failed to verify route)"
+			fi
+
+			ip netns exec "$testns" $ynl --family rt-route --do delroute \
+				--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null
+		else
+			echo "FAIL: YNL CLI rt-route operations (failed to add route)"
+		fi
+	else
+		echo "SKIP: YNL CLI rt-route operations (rt-route family not available)"
+	fi
+
+	# Test rt-addr family
+	if $ynl --list-families 2>/dev/null | grep -q "rt-addr"; then
+		if ip netns exec "$testns" $ynl --family rt-addr --do newaddr \
+			--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null; then
+
+			local addr_output
+			addr_output=$(ip netns exec "$testns" $ynl --family rt-addr --dump getaddr 2>/dev/null)
+			if echo "$addr_output" | grep -q "192.0.2.100"; then
+				echo "PASS: YNL CLI rt-addr operations"
+			else
+				echo "FAIL: YNL CLI rt-addr operations (failed to verify address)"
+			fi
+
+			ip netns exec "$testns" $ynl --family rt-addr --do deladdr \
+				--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null
+		else
+			echo "FAIL: YNL CLI rt-addr operations (failed to add address)"
+		fi
+	else
+		echo "SKIP: YNL CLI rt-addr operations (rt-addr family not available)"
+	fi
+
+	# Test rt-link family
+	if $ynl --list-families 2>/dev/null | grep -q "rt-link"; then
+		if ip netns exec "$testns" $ynl --family rt-link --do newlink --create \
+			--json "{\"ifname\": \"dummy0\", \"linkinfo\": {\"kind\": \"dummy\"}}" &>/dev/null; then
+
+			local link_output
+			link_output=$(ip netns exec "$testns" $ynl --family rt-link --dump getlink 2>/dev/null)
+			if echo "$link_output" | grep -q "$NSIM_DEV_NAME" && echo "$link_output" | grep -q "dummy0"; then
+				echo "PASS: YNL CLI rt-link operations"
+			else
+				echo "FAIL: YNL CLI rt-link operations (failed to verify link)"
+			fi
+
+			ip netns exec "$testns" $ynl --family rt-link --do dellink \
+				--json "{\"ifname\": \"dummy0\"}" &>/dev/null
+		else
+			echo "FAIL: YNL CLI rt-link operations (failed to add link)"
+		fi
+	else
+		echo "SKIP: YNL CLI rt-link operations (rt-link family not available)"
+	fi
+
+	# Test rt-neigh family
+	if $ynl --list-families 2>/dev/null | grep -q "rt-neigh"; then
+		# Add neighbor: 192.0.2.1 dev nsim1338 lladdr 11:22:33:44:55:66 PERMANENT
+		if ip netns exec "$testns" $ynl --family rt-neigh --do newneigh --create \
+			--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2, \"ndm-state\": 128}" &>/dev/null; then
+
+			local neigh_output
+			neigh_output=$(ip netns exec "$testns" $ynl --family rt-neigh --dump getneigh 2>/dev/null)
+			if echo "$neigh_output" | grep -q "192.0.2.1"; then
+				echo "PASS: YNL CLI rt-neigh operations"
+			else
+				echo "FAIL: YNL CLI rt-neigh operations (failed to verify neighbor)"
+			fi
+
+			ip netns exec "$testns" $ynl --family rt-neigh --do delneigh \
+				--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2}" &>/dev/null
+		else
+			echo "FAIL: YNL CLI rt-neigh operations (failed to add neighbor)"
+		fi
+	else
+		echo "SKIP: YNL CLI rt-neigh operations (rt-neigh family not available)"
+	fi
+
+	# Test rt-rule family
+	if $ynl --list-families 2>/dev/null | grep -q "rt-rule"; then
+		# Add rule: from 192.0.2.0/24 lookup 100 none
+		if ip netns exec "$testns" $ynl --family rt-rule --do newrule \
+			--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null; then
+
+			local rule_output
+			rule_output=$(ip netns exec "$testns" $ynl --family rt-rule --dump getrule 2>/dev/null)
+			if echo "$rule_output" | grep -q "192.0.2.0"; then
+				echo "PASS: YNL CLI rt-rule operations"
+			else
+				echo "FAIL: YNL CLI rt-rule operations (failed to verify rule)"
+			fi
+
+			ip netns exec "$testns" $ynl --family rt-rule --do delrule \
+				--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null
+		else
+			echo "FAIL: YNL CLI rt-rule operations (failed to add rule)"
+		fi
+	else
+		echo "SKIP: YNL CLI rt-rule operations (rt-rule family not available)"
+	fi
+
+}
+
+# Test nlctrl family operations
+cli_nlctrl_ops() {
+	local family_output
+
+	if ! family_output=$($ynl --family nlctrl \
+		--do getfamily --json "{\"family-name\": \"netdev\"}" 2>/dev/null); then
+		echo "FAIL: YNL CLI nlctrl getfamily (failed to get nlctrl family info)"
+		return
+	fi
+
+	if ! echo "$family_output" | grep -q "family-name"; then
+		echo "FAIL: YNL CLI nlctrl getfamily (nlctrl getfamily output missing family-name)"
+		return
+	fi
+
+	if ! echo "$family_output" | grep -q "family-id"; then
+		echo "FAIL: YNL CLI nlctrl getfamily (nlctrl getfamily output missing family-id)"
+		return
+	fi
+
+	echo "PASS: YNL CLI nlctrl getfamily"
+}
+
+setup() {
+	modprobe netdevsim &> /dev/null
+	if ! [ -f /sys/bus/netdevsim/new_device ]; then
+		echo "SKIP: all YNL CLI tests (netdevsim module not available)"
+		exit 0
+	fi
+
+	if ! ip netns add "$testns" 2>/dev/null; then
+		echo "SKIP: all YNL CLI tests (failed to create test namespace)"
+		exit 0
+	fi
+
+	echo "$NSIM_ID 1" | ip netns exec "$testns" tee /sys/bus/netdevsim/new_device >/dev/null 2>&1 || {
+		echo "SKIP: all YNL CLI tests (failed to create netdevsim device)"
+		exit 0
+	}
+
+	local dev
+	dev=$(ip netns exec "$testns" ls /sys/bus/netdevsim/devices/netdevsim$NSIM_ID/net 2>/dev/null | head -1)
+	if [[ -z "$dev" ]]; then
+		echo "SKIP: all YNL CLI tests (failed to find netdevsim device)"
+		exit 0
+	fi
+
+	ip -netns "$testns" link set dev "$dev" name "$NSIM_DEV_NAME" 2>/dev/null || {
+		echo "SKIP: all YNL CLI tests (failed to rename netdevsim device)"
+		exit 0
+	}
+
+	ip -netns "$testns" link set dev "$NSIM_DEV_NAME" up 2>/dev/null
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B" 2>/dev/null; then
+		echo "SKIP: all YNL CLI tests (failed to create veth pair)"
+		exit 0
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
+	echo "SKIP: all YNL CLI tests (ynl command not found: $ynl)"
+	exit 0
+fi
+
+trap cleanup EXIT
+setup
+
+# Run all tests
+cli_list_families
+cli_netdev_ops
+cli_ethtool_ops
+cli_rt_ops
+cli_nlctrl_ops
diff --git a/tools/net/ynl/tests/test_ynl_ethtool.sh b/tools/net/ynl/tests/test_ynl_ethtool.sh
new file mode 100755
index 000000000000..1d1e06ff0dd0
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
@@ -0,0 +1,196 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL ethtool functionality
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
+		echo "FAIL: YNL ethtool device info (device info output missing expected content)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool device info"
+}
+
+ethtool_statistics() {
+	local stats_output
+
+	stats_output=$(ip netns exec "$testns" $ynl_ethtool --statistics "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$stats_output" | grep -q -E "(NIC statistics|packets|bytes)"; then
+		echo "FAIL: YNL ethtool statistics (statistics output missing expected content)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool statistics"
+}
+
+ethtool_ring_params() {
+	local ring_output
+
+	ring_output=$(ip netns exec "$testns" $ynl_ethtool --show-ring "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$ring_output" | grep -q -E "(Ring parameters|RX|TX)"; then
+		echo "FAIL: YNL ethtool ring parameters (ring parameters output missing expected content)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-ring "$NSIM_DEV_NAME" rx 64 2>/dev/null; then
+		echo "FAIL: YNL ethtool ring parameters (set-ring command failed unexpectedly)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool ring parameters (show/set)"
+}
+
+ethtool_coalesce_params() {
+	if ! ip netns exec "$testns" $ynl_ethtool --show-coalesce "$NSIM_DEV_NAME" &>/dev/null; then
+		echo "FAIL: YNL ethtool coalesce parameters (failed to get coalesce parameters)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-coalesce "$NSIM_DEV_NAME" rx-usecs 50 2>/dev/null; then
+		echo "FAIL: YNL ethtool coalesce parameters (set-coalesce command failed unexpectedly)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool coalesce parameters (show/set)"
+}
+
+ethtool_pause_params() {
+	if ! ip netns exec "$testns" $ynl_ethtool --show-pause "$NSIM_DEV_NAME" &>/dev/null; then
+		echo "FAIL: YNL ethtool pause parameters (failed to get pause parameters)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-pause "$NSIM_DEV_NAME" tx 1 rx 1 2>/dev/null; then
+		echo "FAIL: YNL ethtool pause parameters (set-pause command failed unexpectedly)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool pause parameters (show/set)"
+}
+
+ethtool_features_info() {
+	local features_output
+
+	features_output=$(ip netns exec "$testns" $ynl_ethtool --show-features "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$features_output" | grep -q -E "(Features|offload)"; then
+		echo "FAIL: YNL ethtool features info (features output missing expected content)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool features info (show/set)"
+}
+
+ethtool_channels_info() {
+	local channels_output
+
+	channels_output=$(ip netns exec "$testns" $ynl_ethtool --show-channels "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$channels_output" | grep -q -E "(Channel|Combined|RX|TX)"; then
+		echo "FAIL: YNL ethtool channels info (channels output missing expected content)"
+		return
+	fi
+
+	if ! ip netns exec "$testns" $ynl_ethtool --set-channels "$NSIM_DEV_NAME" combined-count 1 2>/dev/null; then
+		echo "FAIL: YNL ethtool channels info (set-channels command failed unexpectedly)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool channels info (show/set)"
+}
+
+ethtool_time_stamping() {
+	local ts_output
+
+	ts_output=$(ip netns exec "$testns" $ynl_ethtool --show-time-stamping "$NSIM_DEV_NAME" 2>/dev/null)
+
+	if ! echo "$ts_output" | grep -q -E "(Time stamping|timestamping|SOF_TIMESTAMPING)"; then
+		echo "FAIL: YNL ethtool time stamping (time stamping output missing expected content)"
+		return
+	fi
+
+	echo "PASS: YNL ethtool time stamping"
+}
+
+setup() {
+	modprobe netdevsim &> /dev/null
+	if ! [ -f /sys/bus/netdevsim/new_device ]; then
+		echo "SKIP: all YNL ethtool tests (netdevsim module not available)"
+		exit 0
+	fi
+
+	if ! ip netns add "$testns" 2>/dev/null; then
+		echo "SKIP: all YNL ethtool tests (failed to create test namespace)"
+		exit 0
+	fi
+
+	echo "$NSIM_ID 1" | ip netns exec "$testns" tee /sys/bus/netdevsim/new_device >/dev/null 2>&1 || {
+		echo "SKIP: all YNL ethtool tests (failed to create netdevsim device)"
+		exit 0
+	}
+
+	local dev
+	dev=$(ip netns exec "$testns" ls /sys/bus/netdevsim/devices/netdevsim$NSIM_ID/net 2>/dev/null | head -1)
+	if [[ -z "$dev" ]]; then
+		echo "SKIP: all YNL ethtool tests (failed to find netdevsim device)"
+		exit 0
+	fi
+
+	ip -netns "$testns" link set dev "$dev" name "$NSIM_DEV_NAME" 2>/dev/null || {
+		echo "SKIP: all YNL ethtool tests (failed to rename netdevsim device)"
+		exit 0
+	}
+
+	ip -netns "$testns" link set dev "$NSIM_DEV_NAME" up 2>/dev/null
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B" 2>/dev/null; then
+		echo "SKIP: all YNL ethtool tests (failed to create veth pair)"
+		exit 0
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
+	echo "SKIP: all YNL ethtool tests (ynl-ethtool command not found: $ynl_ethtool)"
+	exit 0
+fi
+
+trap cleanup EXIT
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
-- 
2.50.1


