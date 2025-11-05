Return-Path: <netdev+bounces-235745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCECC34799
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874143BE100
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A452BE7AD;
	Wed,  5 Nov 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8ioOi3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D20298CC0
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331354; cv=none; b=g5GrK8GlBYFr9U89KSDoTADCEZW1uwYZxT686eF5T7gfHfQp7uyR/pdADw5V7Vy2LcWKQKhndzFouWNS8VkHrRj4NFgSzU6FU0GFwqlhBFkR/bZE4YVZFoXw+QKH2Wp91fCEx/XbZ+P89POWAQReZOn7gL7N7GXCk9Lc1l2tlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331354; c=relaxed/simple;
	bh=wUCGItQKE20v7a7adYJXXuL56czfGygUF+OP53mwBps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiyW0kS7vBN/fzxppcLYE0U9iSFLuAAb7GkOQ4kcQ5xIwdsSXVQ9Cghsd1BJHMOS1jt8T9DXJxomRaNHi1xQF9qlPu8FCFR2h2u74nbzXWXnziNw5s0uQuM2nye82zt25ViCRuEJkkgHJZ7f/QVFzIPzedSj3dKZjq/VplMbsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8ioOi3N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-294df925292so59233005ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762331351; x=1762936151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4W0uR8NNRhm0M1hGWXQbe/H3m+XwYKxf0S21cSDUIU=;
        b=k8ioOi3N/XXuW28EoagJ+/mDfq8ikm19lhmIcd/4EJA60NfEfTY0xBZXzvmYMoOLZw
         qYVuEDSibWzi18Wz1ijmJY0UPfRfgGvXdcKrTV+mbPGARPqWnlYu4+3v9GzSdpmnjpFo
         tVv0WH3zPiTvnoTU+E2+O8g54q+M9kMR4C9to1UdoJtjmVkkf+j/IRBOGQH8u4ygCc+O
         rNIUIewQuy+1opYxULnO7e4vVRaGEuthp7R53KgYwNsScfh1DdOH8FR0PC+8/BqVuXZY
         DoRZIN4cOFW1NMXvlcjAc4vaUQ+yZa+9p1o8+OfUyXEv6XwVCRj69ZcsR8ShjWEJ3Ipv
         g0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331351; x=1762936151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4W0uR8NNRhm0M1hGWXQbe/H3m+XwYKxf0S21cSDUIU=;
        b=Sqi9wwvA5fMnrb2TxDq0QxIg2VXLox88AvkdeaXt2m7H3uKmhaPRyMpcdQqWU/cFBq
         ckwDeuxVUF2uhHQRL7ZMpW2iOd/D4G2BqwLJ8GR067kAG0MARkK658knc6P2yHT2xlCV
         B3MSCtTpDRnh3kqu2iJFaxmD5jsxnTVK+pENu3GqTT4iPWbe+v2Qn1ZNKUGDY6SSwbgl
         7e2OFnlRryNWnhqnb6b0H4wPNdKCE4wpO38yXTkBt+QtNo4A9FovhUn1E6FI3FQYy3NR
         8+tJ/kboKFPSVtjoQqaInMjkeeutJhZY2vH0yy4xEArmnYnfuWDIjq9GsMx4rz/B3Yy2
         iOaw==
X-Gm-Message-State: AOJu0YzOeoqHuwWQc1YU9thG+lsnItM4BURhdoliMn2UcmxnIbO9vkBA
	Z823cM0quLt59s4yzP1p5NTP2CuzeT5Ssk2g4kh7ESOR4xWBJLjj5bjwP5s/tCG39DE=
X-Gm-Gg: ASbGncvImepbCYBtgnGd7uRzfovMYbnH1MTZJkZ3JTg3rcOFJyx1gO8rk1PAWq569Qd
	yC7MpLec1WxhkwZxqgVkdqwUvH09uQWOQ7lor09T7Xn3Qf+ojXoRXnPp4XXzDJtWiPh8DUNuFt+
	XxSjqN4F/UjGfUZwWkP6jFgFyEhPL3sdbtmKB6tnyHw8NE9dnJXHoVgLbdCrCp5BgjV4D35mlXc
	Imy3KgmNldfN/eF7prEzUNwQibY6U561nD3IktsOo6d26IvyOdMxMHFFFr2BZjnPsq4LnfNR2EG
	rC2zTNVyMH/g6MuB3yis0icILOoEV8+cGgRWO5HvepVaZ9czqxxNSBkOo7uH3+6Eu/RU2vjsX3Z
	WSNq+60ixWefMx12RfaM2adCB18EF00AkqT4OBI5ms068EhMaRRoDeL2pIVLJqqcDy9PZRsO8Ar
	RSKy7e
X-Google-Smtp-Source: AGHT+IGKVs8OPKhplUGuhYXomKxm5scKfDuq53OXXaVb7oNvM4Si/xz5YPcH4YmJxhpmYBWU4ey8Kw==
X-Received: by 2002:a17:903:46c6:b0:262:2ae8:2517 with SMTP id d9443c01a7336-2962ad07969mr35675705ad.5.1762331351226;
        Wed, 05 Nov 2025 00:29:11 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a0c9sm52171705ad.55.2025.11.05.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:29:10 -0800 (PST)
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
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Date: Wed,  5 Nov 2025 08:28:41 +0000
Message-ID: <20251105082841.165212-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105082841.165212-1-liuhangbin@gmail.com>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
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
 tools/net/ynl/Makefile                  |   3 +-
 tools/net/ynl/tests/Makefile            |  24 ++
 tools/net/ynl/tests/config              |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh     | 290 ++++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh | 195 ++++++++++++++++
 5 files changed, 517 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 211df5a93ad9..89a9cd0a1306 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -12,7 +12,7 @@ endif
 libdir  ?= $(prefix)/$(libdir_relative)
 includedir ?= $(prefix)/include
 
-SUBDIRS = lib generated samples
+SUBDIRS = lib generated samples tests
 
 all: $(SUBDIRS) libynl.a
 
@@ -48,5 +48,6 @@ install: libynl.a lib/*.h
 	@echo -e "\tINSTALL pyynl"
 	@pip install --prefix=$(DESTDIR)$(prefix) .
 	@make -C generated install
+	@make -C tests install
 
 .PHONY: all clean distclean install $(SUBDIRS)
diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
new file mode 100644
index 000000000000..10bca7fe54c5
--- /dev/null
+++ b/tools/net/ynl/tests/Makefile
@@ -0,0 +1,24 @@
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
+.PHONY: all install clean
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
index 000000000000..53e66f7aeeb4
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_cli.sh
@@ -0,0 +1,290 @@
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
+	if ! modprobe netdevsim &>/dev/null; then
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
index 000000000000..ca60b8adc126
--- /dev/null
+++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
@@ -0,0 +1,195 @@
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
+	if ! modprobe netdevsim &>/dev/null; then
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


