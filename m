Return-Path: <netdev+bounces-169495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEFA4436F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96672421FA5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780C26D5A3;
	Tue, 25 Feb 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKJkp7v0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658321ABDA
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494616; cv=none; b=nSOaRDwaTxkQc9xTy/3la8qnBvLRU4pR45tthnxS64VYfEq0K7oDBugTTzQoW0Yd4NV05IM/wdkLj+l6ut9HEzFlVLgAjEOL+Vy/QdzRZElDWT9iilAbRSbs3F0vI/bbGPakY6EjgaFM405Bmo6stm1h7YjvYhZBlxDriUxMV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494616; c=relaxed/simple;
	bh=LzgkKS6KmBbcGVC528fJgg/P2nRZchQO0xaazTt14OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLCtxOKcI6L1GVZkH2DdMT4C5e7ia/VLiD8WI0QD3BRdoU14/5hG3eQFq3fAs5PfzJwLQ9Gb8wBxI2z1KJ6fbLEdXh2vmnXVJnvM5/iiANfEqinpdk9KM2liaF1Z5Q/vp269vcb3P3+jo4NNsoLsqssrlT20+pzzaBBJbtL1RoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKJkp7v0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740494613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cceaRQJSm4je2ACp31+/NzmhK/B4hcPymHnBIpjr/fY=;
	b=bKJkp7v0JuV3RHmDO8JbWGoPOs+QOaObP3MKCORP0zPsUIyJuN8LmSADcEa4s/JEPfz4zp
	3Lf6U/8gloocdso9/bmxpI5CL+z+LlU5/kTjX3iopVCvn++HBhe92SKaExIKT/dyU22p6C
	sCGiZLcZtVV67z2JAphq3R8tdQTSN/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Ks5GK-cHNi2UjBIHk98zww-1; Tue, 25 Feb 2025 09:43:30 -0500
X-MC-Unique: Ks5GK-cHNi2UjBIHk98zww-1
X-Mimecast-MFC-AGG-ID: Ks5GK-cHNi2UjBIHk98zww_1740494609
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso29199325e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494609; x=1741099409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cceaRQJSm4je2ACp31+/NzmhK/B4hcPymHnBIpjr/fY=;
        b=obrWuYXnlFO/8Kpfwq54Ck4fCec2+up1USmACsUApOLpP7YVOBZXd9ecWnA9jj7HTc
         bYm8/mLWqnai1XymrR6euXu6sP0dgN79KgxsJR/Yy2S+B+wKN5xzNVAyuULoQdk4njVo
         MghQxNhX8USGp2VJWTlTGYRASoUBT8aBj08Eq5+53UmIa5ofrtFj9KJarg7VCAXqRAR3
         Wjq0GdqUp/mHYj10K5PcNDI3O/YSjDWd+ncbFIaYX9d4xekjEMl85PS/5ePB+RymvZjn
         A9KyQvWJQdvvg8fCfYXI6KN6VWIVHU4qarBPiAzTrqctUG3qjCzHhwkOoFcPnjfZPzrU
         QgVw==
X-Gm-Message-State: AOJu0Yzaa0a8NQgzqhpWy4lh0PIE/4dKMkhF019cuoWZNmZFmdw3yK7f
	OImgbGvCxzpo/pzgW7Iq7RelJR/i+pskR2bSqMVKBiOau7+nRihZISHrqSpkZ2tfSr8cAspDAsR
	v/HOXfZOgZbVeO69088bO+nnnaIOu5PtptcM78q82F723T1jOqF4Y7Q==
X-Gm-Gg: ASbGncsJX2Q17VZnBxEZNj+tR96PQL67RBput+UNRqKPbnpzFIjgDaXj/PQM/5r+/tE
	VrDk5mm3B9YsXEWRDejfHAgQNmG9MDUwVKYYyYWV/mdZMbiGPHAxGVabM6HdAdr1M4QysZCUP6D
	wq1wh9HBZlAd05Z+y2a/rEVZdqMIjxtJjdpjfeL94Fx+0vdRJUZdD6Eqe+URW1Vhcxrd0qnOoFH
	SQ2Sxx9IzrR2S9nH8WOUc6cqEBcMa/BQxFQ3S4MZcb+rlaW0nRUswcRvyXz1cmaPjqYv56kGh+V
	i40=
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-43ab0f27170mr25644775e9.1.1740494609297;
        Tue, 25 Feb 2025 06:43:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLXfd/7fQF0ROlQ48EjcJMELoh35ZsmEodOIe8QqqR4XWSYrLbaiNUUy9jv/VXehoOj0V/VA==
X-Received: by 2002:a05:600c:5493:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-43ab0f27170mr25644565e9.1.1740494608863;
        Tue, 25 Feb 2025 06:43:28 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b036754asm145175455e9.30.2025.02.25.06.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:43:28 -0800 (PST)
Date: Tue, 25 Feb 2025 15:43:25 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net v3 2/2] selftests: Add IPv6 link-local address generation
 tests for GRE devices.
Message-ID: <a05174174b9fa6a79a9c3ee32e7a5c506d8553aa.1740493813.git.gnault@redhat.com>
References: <cover.1740493813.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740493813.git.gnault@redhat.com>

GRE devices have their special code for IPv6 link-local address
generation that has been the source of several regressions in the past.

Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
IPv6 link-link local address in accordance with the
net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v3: No changes.
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


