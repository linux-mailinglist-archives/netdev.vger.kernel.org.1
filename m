Return-Path: <netdev+bounces-205453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF15AFEC06
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538081C251FF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D562E5B36;
	Wed,  9 Jul 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DutG9ma+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA82E5411
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071426; cv=none; b=aDGbNHLFUf9egxvcCTf0HSdWoEcMnoZ6sROl3BlyfRNkB718+MBL1xOGLFHEf1rkrsEt1KiOUZqGKzyHjLLybUlg8oOelDAA/x5ByOBm2nwpbLMccSKLAR9Yydwyel6G7db32Q/rgVozOFX3fvNdrLJIZfjx+hsIJbwpMr4rmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071426; c=relaxed/simple;
	bh=By0J8wWyf/hunfrBZN9RrQG/ja01k3CxLZiYw4mzMXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f87k5RCjGAf84KboyTP7Y1Rwle6Lk+slbIIsn7U2Kh9jJ8YLrY/FegtJAPuGb8m1eEZJHhuEN8+FKB6bbLxpYxqxFD7Vf6DCWBGlKF7kjS6ec5/h/y/iPpSZ4UpjjpWpna1PtVCaVQ10puUsaIu/z4/wAvqUkme4KJ8cIBWy58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DutG9ma+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCzmRH3P+ffprY+eIO0UzEM5A1r6pOhEIIy7wBgpNX8=;
	b=DutG9ma+R59cEStwAyxwLf6AJq8w3F7GuV1oQGqjtv1boXBoa2l3w8VK0GxRmnIe4ZxrqD
	B4cDLDiptw4DTj7zM+t+49YxmvVzrQMIKyqJQ/vDNRasBxeIFcGA0uKnZ9rH+0Ggozbb9o
	bv+bANn+9Q8/c3VXBBmKcyjYRlc5iUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-k7p3REK5PPqNMVMPmtbKyQ-1; Wed, 09 Jul 2025 10:30:23 -0400
X-MC-Unique: k7p3REK5PPqNMVMPmtbKyQ-1
X-Mimecast-MFC-AGG-ID: k7p3REK5PPqNMVMPmtbKyQ_1752071422
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso34295e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 07:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071422; x=1752676222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCzmRH3P+ffprY+eIO0UzEM5A1r6pOhEIIy7wBgpNX8=;
        b=Mh8fpiA8Db1pmSiV+iKE22CAor0e9GjEvEsIqS6+Nn2sbIOWgLEiD4UaVBbWRY0MGj
         +z0Wsbn/dP5ikQ7RARujmlGvDVIoOd5ANUCWMHGTakLSSGe+bnRw5cnB1aZ96qussbwk
         uEY4+HHpJNfYqFQz8nuj8rl02fWhZlKxAR99T7vEi2VlXFtFQYW/SPWd/Y0dQZBu3JTw
         yEZE/A8aESd5KdIbP3llbP+8Do+gEIzWo4J+gbrMs5qJrW8hh4a158kdf6mGT3wfQRlH
         riU1Y/DcACswIAZZ/nzTJLx5rwVGM8sBQEanu4wQK0x/UGltuFEfg35s+gD4pvy+/4sy
         TImg==
X-Gm-Message-State: AOJu0YxnuZ79g9r6nN+CvDy8WtlaChljKbmTEFZ5tXdJVZzIkbBHPlnR
	HsuMfg2EMSt6b1cWFufXEHDi9v2/9WxGd+wytmnCPEoPEpFRG+1T4wcpfJQfnmEEPeMCTVWLsBi
	SSw+zIkFr7nj4XlJ9b7ft5+96BUVi9eIj1OtlUWjZPq0Xq1tkm3wYo9qFhw==
X-Gm-Gg: ASbGncuC786Phoh2rMNNHHLZPTANIP5hTlMZFJGjnDpLqCSAHpXPXosVXzUY2CUiHcN
	yqh9eYgchWR0XvHyVx+A34yPOSdcbM8T1gXXHVn9rUlNJ31wBcWZKcMAEeSemE3bVTCCT6hUcYC
	C+rcazMb6Iojwju/FUs8MtG5zGSdTkVSLLQc6jmQdEs/4znNTY5RLHHYfENQmy5xs+f2A5rLlNp
	pdEZ1XDBfu5XIolB4266uLrWjh1KCu/qsidCDHS/feT1nQ3ZtZDCsam2ZI+WJJA/jNS6DUwdQHS
	E6oNzVgVkw==
X-Received: by 2002:a05:600c:8b0d:b0:454:b97a:486e with SMTP id 5b1f17b1804b1-454d5602748mr27399505e9.10.1752071421734;
        Wed, 09 Jul 2025 07:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCqqkMNXdv3YwaHIZdD4GhGE1vOFwEsTn/NpIpG6UsSCHXesxZe5mpIXtQkj6BhMWVcx98rA==
X-Received: by 2002:a05:600c:8b0d:b0:454:b97a:486e with SMTP id 5b1f17b1804b1-454d5602748mr27399125e9.10.1752071421223;
        Wed, 09 Jul 2025 07:30:21 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225b5cdsm15689964f8f.85.2025.07.09.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:30:20 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:30:17 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Aiden Yang <ling@moedove.com>, Gary Guo <gary@kernel.org>
Subject: [PATCH net 2/2] selftests: Add IPv6 multicast route generation tests
 for GRE devices.
Message-ID: <65a89583bde3bf866a1922c2e5158e4d72c520e2.1752070620.git.gnault@redhat.com>
References: <cover.1752070620.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752070620.git.gnault@redhat.com>

The previous patch fixes a bug that prevented the creation of the
default IPv6 multicast route (ff00::/8) for some GRE devices. Now let's
extend the GRE IPv6 selftests to cover this case.

Also, rename check_ipv6_ll_addr() to check_ipv6_device_config() and
adapt comments and script output to take into account the fact that
we're not limitted to link-local address generation.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
index 5b34f6e1f831..48eb999a3120 100755
--- a/tools/testing/selftests/net/gre_ipv6_lladdr.sh
+++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
@@ -24,7 +24,10 @@ setup_basenet()
 	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
 }
 
-# Check if network device has an IPv6 link-local address assigned.
+# Check the IPv6 configuration of a network device.
+#
+# We currently check the generation of the link-local IPv6 address and the
+# creation of the ff00::/8 multicast route.
 #
 # Parameters:
 #
@@ -35,7 +38,7 @@ setup_basenet()
 #         a link-local address)
 #   * $4: The user visible name for the scenario being tested
 #
-check_ipv6_ll_addr()
+check_ipv6_device_config()
 {
 	local DEV="$1"
 	local EXTRA_MATCH="$2"
@@ -45,7 +48,11 @@ check_ipv6_ll_addr()
 	RET=0
 	set +e
 	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
-	check_err_fail "${XRET}" $? ""
+	check_err_fail "${XRET}" $? "IPv6 link-local address generation"
+
+	ip -netns "${NS0}" -6 route show table local type multicast ff00::/8 proto kernel | grep -q "${DEV}"
+	check_err_fail 0 $? "IPv6 multicast route creation"
+
 	log_test "${MSG}"
 	set -e
 }
@@ -102,20 +109,20 @@ test_gre_device()
 		;;
 	esac
 
-	# Check that IPv6 link-local address is generated when device goes up
+	# Check the IPv6 device configuration when it goes up
 	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
 	ip -netns "${NS0}" link set dev gretest up
-	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "config: ${MSG}"
+	check_ipv6_device_config gretest "${MATCH_REGEXP}" "${XRET}" "config: ${MSG}"
 
 	# Now disable link-local address generation
 	ip -netns "${NS0}" link set dev gretest down
 	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode=1
 	ip -netns "${NS0}" link set dev gretest up
 
-	# Check that link-local address generation works when re-enabled while
-	# the device is already up
+	# Check the IPv6 device configuration when link-local address
+	# generation is re-enabled while the device is already up
 	ip netns exec "${NS0}" sysctl -qw net.ipv6.conf.gretest.addr_gen_mode="${ADDR_GEN_MODE}"
-	check_ipv6_ll_addr gretest "${MATCH_REGEXP}" "${XRET}" "update: ${MSG}"
+	check_ipv6_device_config gretest "${MATCH_REGEXP}" "${XRET}" "update: ${MSG}"
 
 	ip -netns "${NS0}" link del dev gretest
 }
@@ -126,7 +133,7 @@ test_gre4()
 	local MODE
 
 	for GRE_TYPE in "gre" "gretap"; do
-		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
+		printf "\n####\nTesting IPv6 configuration of ${GRE_TYPE} devices\n####\n\n"
 
 		for MODE in "eui64" "none" "stable-privacy" "random"; do
 			test_gre_device "${GRE_TYPE}" 192.0.2.10 192.0.2.11 "${MODE}"
@@ -142,7 +149,7 @@ test_gre6()
 	local MODE
 
 	for GRE_TYPE in "ip6gre" "ip6gretap"; do
-		printf "\n####\nTesting IPv6 link-local address generation on ${GRE_TYPE} devices\n####\n\n"
+		printf "\n####\nTesting IPv6 configuration of ${GRE_TYPE} devices\n####\n\n"
 
 		for MODE in "eui64" "none" "stable-privacy" "random"; do
 			test_gre_device "${GRE_TYPE}" 2001:db8::10 2001:db8::11 "${MODE}"
-- 
2.39.2


