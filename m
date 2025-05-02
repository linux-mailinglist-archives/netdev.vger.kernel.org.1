Return-Path: <netdev+bounces-187542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63FCAA7C8F
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FE43AC031
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAD215795;
	Fri,  2 May 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXmom/Qv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0C215184
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746226687; cv=none; b=C8K7PW2srfamopb8VBhZrl6wBBuDyxUJr4DaP3mqOKBzqORamanDhEcTFMxC4JOgZZPUjRwho4MtOWBrEMBhwoVYRTq2DMFrgpbPM39jWf/tjuZ2o4Z+1Rhm4j2qMDevmkCQ2NqDs2K4XTv2K9a0bhn92QWEm2yMz1EqUAAJnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746226687; c=relaxed/simple;
	bh=ESgAKMEH9R0K8lnYbhQMNrN8Glff6IYJo6o++ri9a/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH5MZUS9TOWC8J6oQZR1QecARpCA0DbnZIZdjPyWCYRqB+hj0zruYfdcfQMMP5x55XXKmolm48HIGQFm17B3arDFkxB0yOm1QDHvsoarXlGBNJhmVA0mD6kx4p70OBSxq8m5CZ9GLvNOhQ1dp8Ci7/Zj4AE65+L/hA1PpfIJ4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXmom/Qv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746226684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bg/YlgJV9TB0DMnBXZx0vwb8i+nKPztkpkdwuoTSaf0=;
	b=cXmom/QvtfcKoniXps+iMYMErtL/TvrvcjTO58RLPT8JDWK1/Dx+Wh/jLSK3y4raYNMfu3
	ATyJ7cTiULpvghcvrvFmPwp/a57UX3lA06I82ihww2s2dro8WWY2rI6ehoc2O7phOfW649
	o5J4f9JH3IiXB6zbBb6E1/L44KFYoqo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-e7WDypb1NYOP2Qi9MkFVJw-1; Fri, 02 May 2025 18:58:03 -0400
X-MC-Unique: e7WDypb1NYOP2Qi9MkFVJw-1
X-Mimecast-MFC-AGG-ID: e7WDypb1NYOP2Qi9MkFVJw_1746226682
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf446681cso13886825e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 15:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746226682; x=1746831482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg/YlgJV9TB0DMnBXZx0vwb8i+nKPztkpkdwuoTSaf0=;
        b=BLFFb7LojkXvNycUUoKzI0ObUttICGItJrF2VYmccOp9eEh7q1Wu3pfYctpVCLelSa
         e3M2+sxTTDR76fjzaKbzcCz1dX6cAmYnusWb3D/Io2JXxI8W07mq6gCSj31pBt4avTXd
         wNDcUUR7nzWRWJfsM2GOe7eRO3zgLcoGbw+j9oGkljVO6AActx7ZilJsxJeTW1QwRyeA
         Sl9zhF8OjIEZDapum7VlPnIYLEw+6TLowa4rpx1LEx7yGxtprOzL3QxBb30po7Y4WrKJ
         29Jn6LiPkVwrmjN3evM/+WEItMgxLQw9nwqY3FiM+343CCT1lJLuozCy+42zRHcpaGlo
         8grA==
X-Gm-Message-State: AOJu0YyRCN00eZ2p2rl0V2Q7g145exmRSQW1zMq/oc6Ed85XlEBF2Hao
	9n4Bc9YtnaavKV+J7bzz2fMr6deTOiBcc2tGVFpNvWJBPoO0vdmM5GimlvG6JHOdbAaNjuslOeA
	cbi1xU0ro601pSEnCzwxqsEvBte5NE3xWDSkaDvu3ow9omWU4cMx6YA==
X-Gm-Gg: ASbGncvfGlx8IhVdoW1+Fa8k8VqPdg/G5eEAyY1NB6fVG5GBXBCSdzwxM6s0c30ilHk
	ivaJshu+5ll+jQMo1q9txK53USGR+V2qZW8aexcx+oXW2zJU1Cio9EhiGWpnpZrLzwa/jDVHUYU
	TqAUSKkyiYfQLLhYa5j61eLyiIdJqi4KiRco00L592O3RyzVeteSDuMtkhJahlFqwYMy5l9oVWO
	Flp3zx2xta1TOssQwxG+YPfaD3rjMb5QZZMbgEdYx7Q2qOcz30dv70/FKXk98ti8o6rUgDG/Kn/
	wHXgOauM8ukWD1TgKxwcb+unqgThMW+jrERUjiVgBXeM1DuBaf6vY0r1xdmlZVUDnQ==
X-Received: by 2002:a5d:47c7:0:b0:3a0:8495:cb75 with SMTP id ffacd0b85a97d-3a099ad277dmr3638235f8f.9.1746226682178;
        Fri, 02 May 2025 15:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7xKKg4XYNPg8i1XYkBjGkOhS0GZM8/MvxcJdfZPetalOvUPvqbu/Di2lqBJvwDmi5DQvgsA==
X-Received: by 2002:a5d:47c7:0:b0:3a0:8495:cb75 with SMTP id ffacd0b85a97d-3a099ad277dmr3638224f8f.9.1746226681724;
        Fri, 02 May 2025 15:58:01 -0700 (PDT)
Received: from debian (2a01cb058918ce003eb206d926357af7.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:3eb2:6d9:2635:7af7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a55sm3211025f8f.45.2025.05.02.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:58:01 -0700 (PDT)
Date: Sat, 3 May 2025 00:57:59 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net 2/2] selftests: Add IPv6 link-local address generation
 tests for GRE devices.
Message-ID: <2c3a5733cb3a6e3119504361a9b9f89fda570a2d.1746225214.git.gnault@redhat.com>
References: <cover.1746225213.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746225213.git.gnault@redhat.com>

GRE devices have their special code for IPv6 link-local address
generation that has been the source of several regressions in the past.

Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
IPv6 link-link local address in accordance with the
net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Note:
  This patch was originally applied as commit 6f50175ccad4 ("selftests:
  Add IPv6 link-local address generation tests for GRE devices.").
  However, it was then reverted by commit 355d940f4d5a ("Revert "selftests:
  Add IPv6 link-local address generation tests for GRE devices."")
  because the commit it depended on was going to be reverted. Now that
  the situation is resolved, we can add this selftest again (no changes
  since original patch, appart from context update in
  tools/testing/selftests/net/Makefile).
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 124078b56fa4..70a38f485d4d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
+TEST_PROGS += gre_ipv6_lladdr.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += test_so_rcv.sh
diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
new file mode 100755
index 000000000000..5b34f6e1f831
--- /dev/null
+++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
@@ -0,0 +1,177 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./lib.sh
+
+PAUSE_ON_FAIL="no"
+
+# The trap function handler
+#
+exit_cleanup_all()
+{
+	cleanup_all_ns
+
+	exit "${EXIT_STATUS}"
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
+#   * $3: The expected return code from grep (to allow checking the absence of
+#         a link-local address)
+#   * $4: The user visible name for the scenario being tested
+#
+check_ipv6_ll_addr()
+{
+	local DEV="$1"
+	local EXTRA_MATCH="$2"
+	local XRET="$3"
+	local MSG="$4"
+
+	RET=0
+	set +e
+	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
+	check_err_fail "${XRET}" $? ""
+	log_test "${MSG}"
+	set -e
+}
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
+setup_ns NS0
+
+set -e
+trap exit_cleanup_all EXIT
+
+setup_basenet
+
+test_gre4
+test_gre6
-- 
2.39.2


