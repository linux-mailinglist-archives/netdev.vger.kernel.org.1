Return-Path: <netdev+bounces-176294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62904A69AD1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1117ABB94
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFC2147F8;
	Wed, 19 Mar 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbBu8e8W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFD20B1FD
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419614; cv=none; b=K6TAVc8HQRuX7j2k+dCzAWG4jsAQM7RkhJz4ZMtN8EB3BY1Bmd9cZJkno0GVmWcxqGNzpccpgNqjToVUrkwaGkzNuwbeC0oK2G8rT2Ge2wsqmwh6zfX13lZVDUfYEoma4CE3W7Mnf4Dhm1zFWuo8iv5NN8UvemkBIkS4ngsWpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419614; c=relaxed/simple;
	bh=qHiGItA4jJJpLxQapxxN9+1X3pQ2KzKzBzQIbMAS+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0nOLybvEUVyr5/5Chghc/U+BF63u1d2YArNSss6tb3ZkZL5siulRPcITIc4V7WK8pW+epG/Zc3ei1RV9vhhSZeaq8fqUZKcI87gYOwufCTXKPNTzCljlbifV8X7BPXq8VPNHcQQ/wrKkEuYTbnqPp6KZU3EogkxaaioJAeqfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbBu8e8W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flM4lCoB5BEZTfFAClneaSbe4oiK9kDGcN7N6LtxjYI=;
	b=cbBu8e8WkFFWywZfleHzZ81n/2DrGtVmxIFXTbYRsYx7A8roA1lxid4a0/UJvxh8Okx+fR
	aqvz3HToYhrxBW1J4b9l1pj/ia620VGx8JZ5bpHt4Dec+uAlKVM9YeIAkAxvxKA9rPWo9G
	luA5DjHly/sZ46PCMsHTLLZKiRyDpeo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-zaY5qeUWP_e5N9P9b_bFuA-1; Wed, 19 Mar 2025 17:26:49 -0400
X-MC-Unique: zaY5qeUWP_e5N9P9b_bFuA-1
X-Mimecast-MFC-AGG-ID: zaY5qeUWP_e5N9P9b_bFuA_1742419608
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913b2d355fso24719f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419608; x=1743024408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flM4lCoB5BEZTfFAClneaSbe4oiK9kDGcN7N6LtxjYI=;
        b=wRaY+Ao5uXw4YP9MWG+AFdjzntSH/MjLu5Bwg+4sz/rEGt4BTiX8KiUpycGIyL0i8y
         k7od2sYKev4kAo1VJbacvo83ZbykIC7vSSzepu4N565eYepNbVpTAa5QRH4CzMNoyycV
         BJnwSj8IyzymoOSfwm5VVJBuMqF6Ms2hITW7fWCQe4YrV+IhMa6roHjiD2nf+qiXF1Ex
         py6TwXER4sucus8B9iEes6Q/Diazhg37Mmmy1AE0ERWaH3r55WzQ3WKJds5J4ipoEMYE
         azkYuk26ol9cT6TGEd5P+KdX0VmZKjyp1BrWrETvtvakCqJ3IpYiK7MKjdM38LUZrL2s
         HoAA==
X-Gm-Message-State: AOJu0YzPBXB+SUI3iryO0mV1yabpbQAtX62yikoY6poBueP4B45jVI3P
	3EIbAGUR4sBJ4MU2wCur22zmTaDB5weiPVHUg9R/tIG/QT5Q6sEUC8MB3RPyOkZ2tUdFRRrggSf
	G7dHKviYrrfEfTu+krb/MUoqTjbTMuIpshmQJ3VGjwEdkACLel/MZ2g==
X-Gm-Gg: ASbGncuMJNMnkfflXDEc7tcouGWf8q57xr3MEmDQz1opkwFA8ejIBinq6dnTb2CtzFo
	TupmNEL72diDjfF1g3SCdcISy8lAwBHoWz0kpy4JjGumkRtVLwZRpl3v5kg+HrYioLr0rGbXQLo
	EcdihCLT7GGz6MKaRD6aClU3i9gBFBq2oBcqpGbHMNxEFgH34wACdvsHpAcWXngP5E3vklrLzE0
	NY+XjTPAD4uOAPA9MrE38viwuFrZhV/XgvsRqMjNVzfH5p/ahFUjx+9eRk3HBNH41fqffzxS65O
	4jsLiKU9uUHf3goP5DVtuighK+uWY6AqqJOJ7qq8rsC98c3ZEMqTnvZMMn5wP81xvV71ctY=
X-Received: by 2002:a05:6000:400b:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39973b0474cmr2952010f8f.49.1742419607983;
        Wed, 19 Mar 2025 14:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy85jayw5mlTfFJS5kUhVenUizLZWkzmy3znXQrf4tjQJwlDbnM8NRM/Ou2NIwNRKNMAP+WQ==
X-Received: by 2002:a05:6000:400b:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39973b0474cmr2951999f8f.49.1742419607484;
        Wed, 19 Mar 2025 14:26:47 -0700 (PDT)
Received: from debian (2a01cb058d23d600155a5103ba09f99c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:155a:5103:ba09:f99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df402esm21613612f8f.1.2025.03.19.14.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:26:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:26:45 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net 1/2] Revert "selftests: Add IPv6 link-local address
 generation tests for GRE devices."
Message-ID: <259a9e98f7f1be7ce02b53d0b4afb7c18a8ff747.1742418408.git.gnault@redhat.com>
References: <cover.1742418408.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742418408.git.gnault@redhat.com>

This reverts commit 6f50175ccad4278ed3a9394c00b797b75441bd6e.

Commit 183185a18ff9 ("gre: Fix IPv6 link-local address generation.") is
going to be reverted. So let's revert the corresponding kselftest
first.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/Makefile          |   1 -
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ------------------
 2 files changed, 178 deletions(-)
 delete mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5916f3b81c39..73ee88d6b043 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -31,7 +31,6 @@ TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
-TEST_PROGS += gre_ipv6_lladdr.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
deleted file mode 100755
index 5b34f6e1f831..000000000000
--- a/tools/testing/selftests/net/gre_ipv6_lladdr.sh
+++ /dev/null
@@ -1,177 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-source ./lib.sh
-
-PAUSE_ON_FAIL="no"
-
-# The trap function handler
-#
-exit_cleanup_all()
-{
-	cleanup_all_ns
-
-	exit "${EXIT_STATUS}"
-}
-
-# Add fake IPv4 and IPv6 networks on the loopback device, to be used as
-# underlay by future GRE devices.
-#
-setup_basenet()
-{
-	ip -netns "${NS0}" link set dev lo up
-	ip -netns "${NS0}" address add dev lo 192.0.2.10/24
-	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
-}
-
-# Check if network device has an IPv6 link-local address assigned.
-#
-# Parameters:
-#
-#   * $1: The network device to test
-#   * $2: An extra regular expression that should be matched (to verify the
-#         presence of extra attributes)
-#   * $3: The expected return code from grep (to allow checking the absence of
-#         a link-local address)
-#   * $4: The user visible name for the scenario being tested
-#
-check_ipv6_ll_addr()
-{
-	local DEV="$1"
-	local EXTRA_MATCH="$2"
-	local XRET="$3"
-	local MSG="$4"
-
-	RET=0
-	set +e
-	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
-	check_err_fail "${XRET}" $? ""
-	log_test "${MSG}"
-	set -e
-}
-
-# Create a GRE device and verify that it gets an IPv6 link-local address as
-# expected.
-#
-# Parameters:
-#
-#   * $1: The device type (gre, ip6gre, gretap or ip6gretap)
-#   * $2: The local underlay IP address (can be an IPv4, an IPv6 or "any")
-#   * $3: The remote underlay IP address (can be an IPv4, an IPv6 or "any")
-#   * $4: The IPv6 interface identifier generation mode to use for the GRE
-#         device (eui64, none, stable-privacy or random).
-#
-test_gre_device()
-{
-	local GRE_TYPE="$1"
-	local LOCAL_IP="$2"
-	local REMOTE_IP="$3"
-	local MODE="$4"
-	local ADDR_GEN_MODE
-	local MATCH_REGEXP
-	local MSG
-
-	ip link add netns "${NS0}" name gretest type "${GRE_TYPE}" local "${LOCAL_IP}" remote "${REMOTE_IP}"
-
-	case "${MODE}" in
-	    "eui64")
-		ADDR_GEN_MODE=0
-		MATCH_REGEXP=""
-		MSG="${GRE_TYPE}, mode: 0 (EUI64), ${LOCAL_IP} -> ${REMOTE_IP}"
-		XRET=0
-		;;
-	    "none")
-		ADDR_GEN_MODE=1
-		MATCH_REGEXP=""
-		MSG="${GRE_TYPE}, mode: 1 (none), ${LOCAL_IP} -> ${REMOTE_IP}"
-		XRET=1 # No link-local address should be generated
-		;;
-	    "stable-privacy")
-		ADDR_GEN_MODE=2
-		MATCH_REGEXP="stable-privacy"
-		MSG="${GRE_TYPE}, mode: 2 (stable privacy), ${LOCAL_IP} -> ${REMOTE_IP}"
-		XRET=0
-		# Initialise stable_secret (required for stable-privacy mode)
-		ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.stable_secret="2001:db8::abcd"
-		;;
-	    "random")
-		ADDR_GEN_MODE=3
-		MATCH_REGEXP="stable-privacy"
-		MSG="${GRE_TYPE}, mode: 3 (random), ${LOCAL_IP} -> ${REMOTE_IP}"
-		XRET=0
-		;;
-	esac
-
-	# Check that IPv6 link-local address is generated when device goes up
-	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
-	ip -netns "${NS0}" link set dev gretest up
-	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "config: ${MSG}"
-
-	# Now disable link-local address generation
-	ip -netns "${NS0}" link set dev gretest down
-	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode=1
-	ip -netns "${NS0}" link set dev gretest up
-
-	# Check that link-local address generation works when re-enabled while
-	# the device is already up
-	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
-	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "update: ${MSG}"
-
-	ip -netns "${NS0}" link del dev gretest
-}
-
-test_gre4()
-{
-	local GRE_TYPE
-	local MODE
-
-	for GRE_TYPE in "gre" "gretap"; do
-		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
-
-		for MODE in "eui64" "none" "stable-privacy" "random"; do
-			test_gre_device "${GRE_TYPE}" 192.0.2.10 192.0.2.11 "${MODE}"
-			test_gre_device "${GRE_TYPE}" any 192.0.2.11 "${MODE}"
-			test_gre_device "${GRE_TYPE}" 192.0.2.10 any "${MODE}"
-		done
-	done
-}
-
-test_gre6()
-{
-	local GRE_TYPE
-	local MODE
-
-	for GRE_TYPE in "ip6gre" "ip6gretap"; do
-		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
-
-		for MODE in "eui64" "none" "stable-privacy" "random"; do
-			test_gre_device "${GRE_TYPE}" 2001:db8::10 2001:db8::11 "${MODE}"
-			test_gre_device "${GRE_TYPE}" any 2001:db8::11 "${MODE}"
-			test_gre_device "${GRE_TYPE}" 2001:db8::10 any "${MODE}"
-		done
-	done
-}
-
-usage()
-{
-	echo "Usage: $0 [-p]"
-	exit 1
-}
-
-while getopts :p o
-do
-	case $o in
-		p) PAUSE_ON_FAIL="yes";;
-		*) usage;;
-	esac
-done
-
-setup_ns NS0
-
-set -e
-trap exit_cleanup_all EXIT
-
-setup_basenet
-
-test_gre4
-test_gre6
-- 
2.39.2


