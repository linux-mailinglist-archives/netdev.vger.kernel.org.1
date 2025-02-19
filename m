Return-Path: <netdev+bounces-167790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE6A3C50B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD332170186
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164A1FE474;
	Wed, 19 Feb 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK/NBkxt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4331DE4C6
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982618; cv=none; b=nzRQCUjRGdVgaPQAy5QrwHH8CqO/J2pRtybWtxmM9f8nuS9OxC6KkXpMU0Lk14KF/pBkS7SgW6Bg1ielX0LFiXEEJg5XABe0lYg+T4lI89pMvhGPyoBz3mNsIyrAW+jVLItX4lTl6yj+ygXR50iIqjuaNXzFuuAPefjkwalwumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982618; c=relaxed/simple;
	bh=5Ac2v9OQcmfvDvh1RuQjBQtgdPdsCYnxRwY/0R3OXdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJMcW6ghXj2smeuCaEmVprQcqLHyR7XdPMvjJC4fk7+wvh1PM2lJEgQYgPWrav93YS/BYFnfdP7yC2pPyo0B3g4au5GBaCtsGwhnaOWvhBWnTPrXshd1P8rOZu7JpJNN11rIvu53XlxD8TWNvbx0pauyAiHNuB2csFWh7WDpfSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK/NBkxt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUiWWXt3+znZGvjRwtiQ/K/hYgHuwh2Io8+IwfpHVqA=;
	b=UK/NBkxtMtBAHFAIqbEeznNdalYew99vOZIfLHnFq0GsWGuMey4epszqKXcD8Hz3Gy72+7
	npnnloPvEjZZ34cmrBmLuwhDzKyDZBigJb8rP0wpXEHh+TEWMeAqfMI/AR25JsnLhaiYXg
	MFEsE8uGRkerHgdhdIhiQNUzbIpT++s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-wmgqRqNJORirtgfzYXOhVg-1; Wed, 19 Feb 2025 11:30:14 -0500
X-MC-Unique: wmgqRqNJORirtgfzYXOhVg-1
X-Mimecast-MFC-AGG-ID: wmgqRqNJORirtgfzYXOhVg_1739982613
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4e3e9c70so500916f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 08:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982613; x=1740587413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUiWWXt3+znZGvjRwtiQ/K/hYgHuwh2Io8+IwfpHVqA=;
        b=JjGRAU8dYamrlY8/jKRj149/S/4RDeb9Ju83iIPoIE1xpFzVpgZnWJTt3TTu+oewb9
         3AK6Gas2AC6HzDyxvbNt+FvF+oZqL9MO6sLTaSfCP5Yof/IA1EAq2GLKF2iByVunHqvx
         iSV97U58u39dEGyqZNOtAZEG7n7EP0bHoq2xwD+K9kpHWiCTaqpTMklJP63D/3TGPaF2
         An8/Uhay8nCMmY6NgeAD2fv10Iexnt7r+vuGbwm2Yl4WL5ANk+FH5eMr2eSh8HRrZY0P
         ovOPBDi9c4RV+FZbUk4zMi2KwjMoK8UTnJZ1oFxyOU9+Xz6xXesnTeoFarXd9enewF4R
         SFbQ==
X-Gm-Message-State: AOJu0YxOfzvsO7VrEAJQlnG0CME7KfSYm8w8/bK5AP//st9wTdZzcPsH
	QGIursK2u99N9l0z8FatXq1L4tzlaGXkAOLmhjI0K0Ml3t0TTvP+/JOsnPSSs+fRbDJMFYUweKM
	W+pXWFDwZQDvJt3RppMjRie3HRQTNFz9ifVLmSNc1huve20USXnc8fA==
X-Gm-Gg: ASbGncs2NdtOPXnqaGKDBD0tM71W2JU/Sd2iRoqJouh8/EOw3vQ7bEIJB7lP2EGostR
	9PcTfJt5RXkBGKNDQDALUiblmMCUKFAM0IUynasV3DL8IZ/eIzZfV94u5wtqKUb3DGid1U3ILxC
	UuUptv7zrzPByVojXhDKiRaZ7/ff95Sblvj0oMo0RK5LAFlnpF3HjPoJEGFfW6wFeH3cpE55qnw
	f01SZvvI5efyyfk2hzRSjPQGqGrJM7wX4g8MUXiZvJac5O5R9UMEcF47TNbTEual7Is
X-Received: by 2002:a05:6000:4023:b0:38e:dcd1:3366 with SMTP id ffacd0b85a97d-38f57d7910amr4298609f8f.20.1739982612849;
        Wed, 19 Feb 2025 08:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2fAEy1hwhTCDxjPUlqMfTzNZu5opS6k4vovlX/Ex/skP3287jMeTSJZ/q4sNUEk4nXzDWZw==
X-Received: by 2002:a05:6000:4023:b0:38e:dcd1:3366 with SMTP id ffacd0b85a97d-38f57d7910amr4298563f8f.20.1739982612242;
        Wed, 19 Feb 2025 08:30:12 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm18390159f8f.33.2025.02.19.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:30:11 -0800 (PST)
Date: Wed, 19 Feb 2025 17:30:09 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net 2/2] selftests: Add IPv6 link-local address generation
 tests for GRE devices.
Message-ID: <d257c7ac320aa41ac5ff867f3bed5b5a6d1ca875.1739981312.git.gnault@redhat.com>
References: <cover.1739981312.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739981312.git.gnault@redhat.com>

GRE devices have their special code for IPv6 link-local address
generation that has been the source of several regressions in the past.

Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
IPv6 link-link local address in accordance with the
net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

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


