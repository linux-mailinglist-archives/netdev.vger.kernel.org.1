Return-Path: <netdev+bounces-168426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA78A3F02F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71345861064
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F1204087;
	Fri, 21 Feb 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAMlyV0h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F931FAC46
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129861; cv=none; b=lwsRHKpvJaDbDSgB5HLhdqliIDP0y/7eeaTr8XiiJb1yfZ2KunOdeaBQ+V+5Czrp8L5X9xfnM/VBI/j35PBUHZUAPgvCVC8HxE5H+gjII82Tihek5JjnjExl8dpwm87p2Sy9fJq/ZklX1Rs1X9T9BEvm6q/M2n11g4Q7xpGai6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129861; c=relaxed/simple;
	bh=dC5tE7ag9gaxET1RhZIhWjH9+upcBjfxktyxOGFZ4xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9sLM+kRoCk/hIi1HY26iL62izPS0tyIayWcygBe+BSqOSTxC+0xffY8l1poUXfbwlaFvUzekQ5Xc3mgupQgUhAi7W+G+HtV7vfPonVqbi1JDVxHCmtlUagv6knV4fQmtSKFHMRU74PHxKzFbw+dMj5sm7EQZnh7gOBXu6FMJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAMlyV0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740129859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kifSX+031tKwuktoajViO9/mvxv4MOw+Oe1xNioyW+U=;
	b=gAMlyV0hNpY/DM8H5VUIVEH5iOsSgXVUU/XMm3DileDQREDyFgqBCJ581RGrCH1JlHYXWy
	LUw/UYFyUsoPXYp7ruZPP0nEt7VH6Dm0K0Icg0t64bUuCSzbLvta+PxQGWa4YwQ21aiRoW
	ylmHkeN4QJyQ+oUODm3IjG9yVXW58aU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-xqjipo2iMWa6Kps5Qtj_gw-1; Fri, 21 Feb 2025 04:24:17 -0500
X-MC-Unique: xqjipo2iMWa6Kps5Qtj_gw-1
X-Mimecast-MFC-AGG-ID: xqjipo2iMWa6Kps5Qtj_gw_1740129856
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e873962so9383455e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129856; x=1740734656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kifSX+031tKwuktoajViO9/mvxv4MOw+Oe1xNioyW+U=;
        b=LW3fzWSp0rNk0wyQimJYMttLvTI/ZYu11ajbdJoC0e41PzPrMRB8D6MobaEFALLdMO
         jEc8o8tVzFFZ33S779k7LyWxryrtGr8f64Ls3rHJxj+9bkRNEMfl5HBOUDC+DMkTGbgx
         fk/kb5vljMZgUKcJ4b36LeIrxHGaSwMDm0zwPzRTCLlZToqqkSIQMd8eO91hS7iNAy/A
         buE6TiMVu4BKCoVvKjww4/5KSxj/GgA0i8oJ3Lf0+Zed3DPXD/cjROTMuKkPXlfp65Hp
         FdwDVMj1TDFFiPGIFiIK0pyHlmecIXuAmXDpUhLXA0zT0NRdmkxnU9I2nJ8sA9cBmBgW
         9cvw==
X-Gm-Message-State: AOJu0Yy2bkSglKt02oBuAHZb3WgWx1BfkHWjUaKblhlk2SdmvBDyS1rb
	m9Yqm0JsOSBM1yYGuTtJNox1kSHTuGeX6XxqCkK+lqyzkVvgMFs27twT/6WOUxYIFQ/pvIaOU3W
	/6HTtouwpgfqS+q21EvmExtdYHvk5KPHHn5iZeghknHYghwbd1IyRVg==
X-Gm-Gg: ASbGncuGOH2zuGr9nn2P+Qx75EsXoy0VnFcwKYrdQQMc8HTxnx7kw+uYuNDsbZD+n4v
	SKTlvpTopKw0nbivjLuJgA4ieodTIjPwD1kLhDe60F9MH0k6oRhVVE1eZsWZwCAIfvsxz9bnR+h
	o2WTnFYK2Xj4Se4MGo4FlRGLcfdi/ndsvF66N7OdU6HUyq1dwB0HlyVqHvyd4UGX+YHy1aUijBs
	euKLol/A06P2icpD1y3bfrxcsSB+eBjToiV2XJsM4bKoRBGOvb9XABZTjMbqiRM5+jvWaxyuxCp
	lkU=
X-Received: by 2002:a05:600c:45c6:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-439ae225a44mr18925455e9.31.1740129855740;
        Fri, 21 Feb 2025 01:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyQ4tqbJw1dzcfjYSv6AayXk/oJzgWrRboon7xzCcbaFVb9NhIjmbKpGDUR+e8Pq/+JfZpcg==
X-Received: by 2002:a05:600c:45c6:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-439ae225a44mr18924035e9.31.1740129853695;
        Fri, 21 Feb 2025 01:24:13 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f5b38sm11391315e9.24.2025.02.21.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:24:13 -0800 (PST)
Date: Fri, 21 Feb 2025 10:24:10 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net v2 2/2] selftests: Add IPv6 link-local address generation
 tests for GRE devices.
Message-ID: <5c40747f9c67a54f8ceba9478924a75755c42b07.1740129498.git.gnault@redhat.com>
References: <cover.1740129498.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740129498.git.gnault@redhat.com>

GRE devices have their special code for IPv6 link-local address
generation that has been the source of several regressions in the past.

Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
IPv6 link-link local address in accordance with the
net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Add selftest to Makefile.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 227 ++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..5916f3b81c39 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
+TEST_PROGS += gre_ipv6_lladdr.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
new file mode 100755
index 000000000000..85e40b6df55e
--- /dev/null
+++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
@@ -0,0 +1,227 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ERR=4 # Return 4 by default, which is the SKIP code for kselftest
+PAUSE_ON_FAIL="no"
+
+readonly NS0=$(mktemp -u ns0-XXXXXXXX)
+
+# Exit the script after having removed the network namespaces it created
+#
+# Parameters:
+#
+#   * The list of network namespaces to delete before exiting.
+#
+exit_cleanup()
+{
+	for ns in "$@"; do
+		ip netns delete "${ns}" 2>/dev/null || true
+	done
+
+	if [ "${ERR}" -eq 4 ]; then
+		echo "Error: Setting up the testing environment failed." >&2
+	fi
+
+	exit "${ERR}"
+}
+
+# Create the network namespaces used by the script (NS0)
+#
+create_namespaces()
+{
+	ip netns add "${NS0}" || exit_cleanup
+}
+
+# The trap function handler
+#
+exit_cleanup_all()
+{
+	exit_cleanup "${NS0}"
+}
+
+# Add fake IPv4 and IPv6 networks on the loopback device, to be used as
+# underlay by future GRE devices.
+#
+setup_basenet()
+{
+	ip -netns "${NS0}" link set dev lo up
+	ip -netns "${NS0}" address add dev lo 192.0.2.10/24
+	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
+}
+
+# Check if network device has an IPv6 link-local address assigned.
+#
+# Parameters:
+#
+#   * $1: The network device to test
+#   * $2: An extra regular expression that should be matched (to verify the
+#         presence of extra attributes)
+#   * $3: The expected return code from grep (to allow checking the abscence of
+#         a link-local address)
+#   * $4: The user visible name for the scenario being tested
+#
+check_ipv6_ll_addr()
+{
+	local DEV="$1"
+	local EXTRA_MATCH="$2"
+	local XRET="$3"
+	local MSG="$4"
+	local RET
+
+	printf "%-75s  " "${MSG}"
+
+	set +e
+	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
+	RET=$?
+	set -e
+
+	if [ "${RET}" -eq "${XRET}" ]; then
+		printf "[ OK ]\n"
+	else
+		ERR=1
+		printf "[FAIL]\n"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			printf "\nHit enter to continue, 'q' to quit\n"
+			read -r a
+			if [ "$a" = "q" ]; then
+				exit 1
+			fi
+		fi
+	fi
+}
+
+
+# Create a GRE device and verify that it gets an IPv6 link-local address as
+# expected.
+#
+# Parameters:
+#
+#   * $1: The device type (gre, ip6gre, gretap or ip6gretap)
+#   * $2: The local underlay IP address (can be an IPv4, an IPv6 or "any")
+#   * $3: The remote underlay IP address (can be an IPv4, an IPv6 or "any")
+#   * $4: The IPv6 interface identifier generation mode to use for the GRE
+#         device (eui64, none, stable-privacy or random).
+#
+test_gre_device()
+{
+	local GRE_TYPE="$1"
+	local LOCAL_IP="$2"
+	local REMOTE_IP="$3"
+	local MODE="$4"
+	local ADDR_GEN_MODE
+	local MATCH_REGEXP
+	local MSG
+
+	ip link add netns "${NS0}" name gretest type "${GRE_TYPE}" local "${LOCAL_IP}" remote "${REMOTE_IP}"
+
+	case "${MODE}" in
+	    "eui64")
+		ADDR_GEN_MODE=0
+		MATCH_REGEXP=""
+		MSG="${GRE_TYPE}, mode: 0 (EUI64), ${LOCAL_IP} -> ${REMOTE_IP}"
+		XRET=0
+		;;
+	    "none")
+		ADDR_GEN_MODE=1
+		MATCH_REGEXP=""
+		MSG="${GRE_TYPE}, mode: 1 (none), ${LOCAL_IP} -> ${REMOTE_IP}"
+		XRET=1 # No link-local address should be generated
+		;;
+	    "stable-privacy")
+		ADDR_GEN_MODE=2
+		MATCH_REGEXP="stable-privacy"
+		MSG="${GRE_TYPE}, mode: 2 (stable privacy), ${LOCAL_IP} -> ${REMOTE_IP}"
+		XRET=0
+		# Initialise stable_secret (required for stable-privacy mode)
+		ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.stable_secret="2001:db8::abcd"
+		;;
+	    "random")
+		ADDR_GEN_MODE=3
+		MATCH_REGEXP="stable-privacy"
+		MSG="${GRE_TYPE}, mode: 3 (random), ${LOCAL_IP} -> ${REMOTE_IP}"
+		XRET=0
+		;;
+	esac
+
+	# Check that IPv6 link-local address is generated when device goes up
+	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
+	ip -netns "${NS0}" link set dev gretest up
+	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "config: ${MSG}"
+
+	# Now disable link-local address generation
+	ip -netns "${NS0}" link set dev gretest down
+	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode=1
+	ip -netns "${NS0}" link set dev gretest up
+
+	# Check that link-local address generation works when re-enabled while
+	# the device is already up
+	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
+	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "update: ${MSG}"
+
+	ip -netns "${NS0}" link del dev gretest
+}
+
+test_gre4()
+{
+	local GRE_TYPE
+	local MODE
+
+	for GRE_TYPE in "gre" "gretap"; do
+		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
+
+		for MODE in "eui64" "none" "stable-privacy" "random"; do
+			test_gre_device "${GRE_TYPE}" 192.0.2.10 192.0.2.11 "${MODE}"
+			test_gre_device "${GRE_TYPE}" any 192.0.2.11 "${MODE}"
+			test_gre_device "${GRE_TYPE}" 192.0.2.10 any "${MODE}"
+		done
+	done
+}
+
+test_gre6()
+{
+	local GRE_TYPE
+	local MODE
+
+	for GRE_TYPE in "ip6gre" "ip6gretap"; do
+		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
+
+		for MODE in "eui64" "none" "stable-privacy" "random"; do
+			test_gre_device "${GRE_TYPE}" 2001:db8::10 2001:db8::11 "${MODE}"
+			test_gre_device "${GRE_TYPE}" any 2001:db8::11 "${MODE}"
+			test_gre_device "${GRE_TYPE}" 2001:db8::10 any "${MODE}"
+		done
+	done
+}
+
+usage()
+{
+	echo "Usage: $0 [-p]"
+	exit 1
+}
+
+while getopts :p o
+do
+	case $o in
+		p) PAUSE_ON_FAIL="yes";;
+		*) usage;;
+	esac
+done
+
+# Create namespaces before setting up the exit trap.
+# Otherwise, exit_cleanup_all() could delete namespaces that were not created
+# by this script.
+create_namespaces
+
+set -e
+trap exit_cleanup_all EXIT
+
+setup_basenet
+
+test_gre4
+test_gre6
+
+if [ "${ERR}" -eq 1 ]; then
+	echo "Some tests failed." >&2
+else
+	ERR=0
+fi
-- 
2.39.2


