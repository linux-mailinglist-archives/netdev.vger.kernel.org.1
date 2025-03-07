Return-Path: <netdev+bounces-173080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07EA571B4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47DB173044
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96462512C9;
	Fri,  7 Mar 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE9hYglY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403E24FBE5
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375747; cv=none; b=IGgWR3S1JQiKtEEWsgAyKFxl2XxSvgqPGgJENI5RL0ZvACagrjhp8Vcs0NjatzfgZ94+dVPK2JvoLJWrRPMB4OCnCxMoZsi6nE4tWz83F3xQ4IdjeQnAE7qFdUSgcduKhhYVsdac21FqIEVNQs3Jv/BJa7AqGsG9EvL5zgdLCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375747; c=relaxed/simple;
	bh=13D2hJo7iXLqqWXGHsAs9+axNuf5gZKZjmpBgZWAi78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buUKg+q0kMIrSaGGHg4Z7QSi89eiyVuu6Z1fqiO6FCCtDNCZllNNFqd7d4AcPfRpaSwHJLMjJQSTop+AZdxeMUK9hFhUhy5sTBFMXi4jqeYsbxxG+j06MFKArBqS6vUZA/Yx40jF8ZHS+GOfh8hcxIifu1TPH1QufjK95HZKKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TE9hYglY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741375744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpgkAPZUuSMqdqAJEcgcMkMUPcF+wDY99pc5qQMugdA=;
	b=TE9hYglYqsyRHGGaB/xX6kl4LWaIb6UvxS9xkFHAqoCcWndWw2yZ/gudRP9ZJkznDFgbPa
	Ns1Szoxra4EQkYRaxi+0M6r1nLczlb2kqSxccnxJvHXqnT07E/AKdyFUuXgyRVz84fmPG7
	MbQ6AqjLEWJ3RnnwIx64Rk0dE1A3p/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-uyQ7EeXTNyepmIheHKx8iQ-1; Fri, 07 Mar 2025 14:29:03 -0500
X-MC-Unique: uyQ7EeXTNyepmIheHKx8iQ-1
X-Mimecast-MFC-AGG-ID: uyQ7EeXTNyepmIheHKx8iQ_1741375742
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39104223bb5so1068040f8f.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375742; x=1741980542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpgkAPZUuSMqdqAJEcgcMkMUPcF+wDY99pc5qQMugdA=;
        b=amFkwQL8kBafbubTP6RQU7vS2N3Km1++rCDQRgvhLyKnrX3hyVE0qCAetWKmiJF1Vw
         tBpdrB/pJ26mcqaBfkGLKLUKLYRGWV6ZdLmu9Qqf5eaoTq+TwXzo/pcCLQsae/8EGH7Z
         GOByaYiadhvrIX3wEIydjMyOKeBLBEmoZkBHTKhGHn2BF5hHG7BiTdxwe259GvTrT2KV
         4bEA5xxiHQR7nu3AUyWREKDAmxnWFmtp1y1Nb0fuRYhOOOe7IjJik5SUZi+LvsAgpZnR
         zOu44n5ycTQPEsEn2g4QrL1xxvqijrP/n6xTFO1cMfMsBNI2lD05azVtJ2xHEWk93LWM
         +jIA==
X-Gm-Message-State: AOJu0YzjZ1QEP2hIS+WuWO3H3yyX9tuvT0GkBPuD6ovzxfAAcLigYUDc
	ZJJFwg8Hen7u+5CsORz+mNil90RWJBv3sOAvuE/CmwwU+O+OVeM0KQ/UiOfxUmlArfrNm/tR0CO
	jHI55UpNVPw5N0EtBTX1+ABaTxVM+L5AvVzNC/4aCG7GQCuhmNCYstg==
X-Gm-Gg: ASbGncuMIq3R66PFVSIh6S3G3pIwun7YstZrROJI3o+WY9uAnzPAShZ3GKJeADI2A7W
	Rk7MYVbcuxEqEJC8AWz/wsi07um2lfgBlLqluXedzTjTByUATur9c2y1UNHoDAa/71EyKWUUHz9
	7c/opuORfnBTm4OPr4j7tRDyiVNCHqNdGUDRpNlNMRRxvOP6yn+2O5TnRFuJlgceQksINMhE2AS
	lp9mFemVXr41OIGqwuD+atRO/RpOYcrAYR7n/K/wm/W19vJNw3MrrW92qZ7sXvmFG5V5OpOwpmX
	e990OWWZOy6dyyolrEOlm7qgUjAYVWlPQsQIQWdI2ao3mgXWdH4PGd+AQgpve38igT8puWs=
X-Received: by 2002:a5d:5886:0:b0:391:28a5:21aa with SMTP id ffacd0b85a97d-39132da9b72mr2973990f8f.36.1741375741814;
        Fri, 07 Mar 2025 11:29:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPChXi26eR+s0RfuwbDbpujktAnokuJLrTVnQt1v1PjhjpUB2aE7PZzfNsTXwuFKhHeRnD/g==
X-Received: by 2002:a5d:5886:0:b0:391:28a5:21aa with SMTP id ffacd0b85a97d-39132da9b72mr2973979f8f.36.1741375741411;
        Fri, 07 Mar 2025 11:29:01 -0800 (PST)
Received: from debian (2a01cb058d23d6008552c00d9d2e4ba2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:8552:c00d:9d2e:4ba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm6415312f8f.60.2025.03.07.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:29:00 -0800 (PST)
Date: Fri, 7 Mar 2025 20:28:58 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net v4 2/2] selftests: Add IPv6 link-local address generation
 tests for GRE devices.
Message-ID: <2d6772af8e1da9016b2180ec3f8d9ee99f470c77.1741375285.git.gnault@redhat.com>
References: <cover.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741375285.git.gnault@redhat.com>

GRE devices have their special code for IPv6 link-local address
generation that has been the source of several regressions in the past.

Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
IPv6 link-link local address in accordance with the
net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v4: Use lib.sh (Paolo, Petr).
v3: No changes.
v2: Add selftest to Makefile.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)
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


