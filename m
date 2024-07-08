Return-Path: <netdev+bounces-109973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490392A8D6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB511F221FA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491B14A08D;
	Mon,  8 Jul 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="eMH5OqHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22167144D00
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462559; cv=none; b=H9iz/EQ+eSU5iCuYKxOTwPJ59kb7Km/UMNbmHG1pN90RKVOAJu1hfLduIDU451vx/GIkEWyDnay5mxq9V5Z0vszoVV++x9Zcxx+CL46f5ex2EjgpUiN2TbUcsfUbp1yzNbWZiv+CkPNtfat/GA3Cwo3R1qncX8qUY5DiORT3rM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462559; c=relaxed/simple;
	bh=ZLlc5dosUXBwxv5EvKjhTs6jf047vphz4uaP3nIUfSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/s8k9Ed66l9Asq4rAVlyzJJuNUSe6/BnhrhnhqTCsbMssp/PXwxDZLDkXPZRJ7LB4j/VqMbD9ISgt/UPHH5pWcm7BMsAzgbBCh7Nza8R0208mJ9if1jDv7XRuyiSkFl1CD0AAlc1ltfoafo5Q8ycNaltIx+1ss9wNm9iqDIu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=eMH5OqHf; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so26036535e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462556; x=1721067356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG/y4J/BblaYD793saZe0Fjc8VN24m2nt2FOXMt7dsg=;
        b=eMH5OqHfUzIJKoeOWaztUc2wzOuCb272IICOvsha50ROn1B688X1gb1Unsz8kbnzub
         QN0Z12XvAAnSKeaK+qp27aU/3db4pP29x88HWX7GsbMDzXkeJXbzVa+fa6capeuePosH
         Yl4+l855nfePWM/ig2TT8p70wTF+WWtO390+nbzdjyWwTfLWqhOFPInvYBFHF8THdu12
         X0pgM3YhetqMu0MGPhz/MWTaXIkZ+uVz3CCGmznDW6lHrSbS4ZyoVvmhA2/CEdMqc80w
         w6nn8FTCxh7omUZZLsSMR9yuM5G1qICQVDilSF770Mt6UdjRfpYaaAqX1hgi7rSHhp/7
         a2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462556; x=1721067356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG/y4J/BblaYD793saZe0Fjc8VN24m2nt2FOXMt7dsg=;
        b=Hj8bEm+SSrkqRtYwlZnG2lnczSXNmrKASODqpOv7oIPHZfzADCNV1fL+bO8iTEd3Sw
         fr9asF/C0tAU7SLTFjJqau1TxNgIUHenoHAoO5XbvmSEA8EmUKmMcutGJfnIqXlXCZ+0
         UDAR2Gupzc7xkNpRs24CfDUT4DqY3G1/jpER+iD3Ek6RBgb6cgLmdyJ2Bf6AOshOY80K
         Nd8cYzmDgMAAlVUF7glyigPAZ8HkIYnELik2G7YGrdQx8nWJtq7OC8KCwEb15OEKWqYV
         0mUoLvJ/Pwre4CkadWiwswKsC1kldd5JLyudaPzrVQVJwRUKTZDfE4htVeo5NzvpqAKI
         ThJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWk8oXkXmwUFzcHLWmba+4B96CpQG0aopcLZpG+kC+ycb+UfayRqmzL1y7c8OxnjYmRW5I9Ca63vfJr8BUA1UmBOmC9ZpN
X-Gm-Message-State: AOJu0YykzpyLXyZkfAa3kRdIGacnVFqM+gsEC9SJcRnDT2KBnKUIt3cd
	At3GjrONXUR1MCfVKSsXOa7qtMnXqfd6D+e9n4TJQb47QyBX174A1XtoBnuQR2S++5fn5u3kEH1
	SY5iynjRjTMDUjHzub2C3+J1fs0C/IglR
X-Google-Smtp-Source: AGHT+IEzMVRnNhdxX1pKuysa0tGwumrv1w6J7vPbp4c7PXcsUC7fN01zGTEVX295pd7qRCieqO9+jKnkxE5k
X-Received: by 2002:a05:600c:4487:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-42672305c06mr71505e9.13.1720462556477;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4264a1f2283sm4360295e9.23.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 2D9246047E;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP96-Qk; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v3 4/4] selftests: vrf_route_leaking: add local test
Date: Mon,  8 Jul 2024 20:15:10 +0200
Message-ID: <20240708181554.4134673-5-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check that the source address selected by the kernel is
routable when a leaking route is used. ICMP, TCP and UDP connections are
tested.
The symmetric topology is enough for this test.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 .../selftests/net/vrf_route_leaking.sh        | 93 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 2da32f4c479b..152171fb1fc8 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -59,6 +59,7 @@
 # while it is forwarded between different vrfs.
 
 source lib.sh
+PATH=$PWD:$PWD/tools/testing/selftests/net:$PATH
 VERBOSE=0
 PAUSE_ON_FAIL=no
 DEFAULT_TTYPE=sym
@@ -533,6 +534,86 @@ ipv6_ping_frag_asym()
 	ipv6_ping_frag asym
 }
 
+ipv4_ping_local()
+{
+	log_section "IPv4 (sym route): VRF ICMP local error route lookup ping"
+
+	setup_sym
+
+	check_connectivity || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ping -c1 -w1 ${H2_N2_IP}
+	log_test $? 0 "VRF ICMP local IPv4"
+}
+
+ipv4_tcp_local()
+{
+	log_section "IPv4 (sym route): VRF tcp local connection"
+
+	setup_sym
+
+	check_connectivity || return
+
+	run_cmd nettest -s -O "$h2" -l ${H2_N2_IP} -I eth0 -3 eth0 &
+	sleep 1
+	run_cmd nettest -N "$r1" -d blue -r ${H2_N2_IP}
+	log_test $? 0 "VRF tcp local connection IPv4"
+}
+
+ipv4_udp_local()
+{
+	log_section "IPv4 (sym route): VRF udp local connection"
+
+	setup_sym
+
+	check_connectivity || return
+
+	run_cmd nettest -s -D -O "$h2" -l ${H2_N2_IP} -I eth0 -3 eth0 &
+	sleep 1
+	run_cmd nettest -D -N "$r1" -d blue -r ${H2_N2_IP}
+	log_test $? 0 "VRF udp local connection IPv4"
+}
+
+ipv6_ping_local()
+{
+	log_section "IPv6 (sym route): VRF ICMP local error route lookup ping"
+
+	setup_sym
+
+	check_connectivity6 || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ${ping6} -c1 -w1 ${H2_N2_IP6}
+	log_test $? 0 "VRF ICMP local IPv6"
+}
+
+ipv6_tcp_local()
+{
+	log_section "IPv6 (sym route): VRF tcp local connection"
+
+	setup_sym
+
+	check_connectivity6 || return
+
+	run_cmd nettest -s -6 -O "$h2" -l ${H2_N2_IP6} -I eth0 -3 eth0 &
+	sleep 1
+	run_cmd nettest -6 -N "$r1" -d blue -r ${H2_N2_IP6}
+	log_test $? 0 "VRF tcp local connection IPv6"
+}
+
+ipv6_udp_local()
+{
+	log_section "IPv6 (sym route): VRF udp local connection"
+
+	setup_sym
+
+	check_connectivity6 || return
+
+	run_cmd nettest -s -6 -D -O "$h2" -l ${H2_N2_IP6} -I eth0 -3 eth0 &
+	sleep 1
+	run_cmd nettest -6 -D -N "$r1" -d blue -r ${H2_N2_IP6}
+	log_test $? 0 "VRF udp local connection IPv6"
+}
+
 ################################################################################
 # usage
 
@@ -555,8 +636,10 @@ EOF
 # Some systems don't have a ping6 binary anymore
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
-TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_ttl_asym ipv4_traceroute_asym"
-TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_ttl_asym ipv6_traceroute_asym"
+TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_local ipv4_tcp_local
+ipv4_udp_local ipv4_ping_ttl_asym ipv4_traceroute_asym"
+TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_local ipv6_tcp_local ipv6_udp_local
+ipv6_ping_ttl_asym ipv6_traceroute_asym"
 
 ret=0
 nsuccess=0
@@ -594,12 +677,18 @@ do
 	ipv4_traceroute|traceroute)      ipv4_traceroute;;&
 	ipv4_traceroute_asym|traceroute) ipv4_traceroute_asym;;&
 	ipv4_ping_frag|ping)             ipv4_ping_frag;;&
+	ipv4_ping_local|ping)            ipv4_ping_local;;&
+	ipv4_tcp_local)                  ipv4_tcp_local;;&
+	ipv4_udp_local)                  ipv4_udp_local;;&
 
 	ipv6_ping_ttl|ping)              ipv6_ping_ttl;;&
 	ipv6_ping_ttl_asym|ping)         ipv6_ping_ttl_asym;;&
 	ipv6_traceroute|traceroute)      ipv6_traceroute;;&
 	ipv6_traceroute_asym|traceroute) ipv6_traceroute_asym;;&
 	ipv6_ping_frag|ping)             ipv6_ping_frag;;&
+	ipv6_ping_local|ping)            ipv6_ping_local;;&
+	ipv6_tcp_local)                  ipv6_tcp_local;;&
+	ipv6_udp_local)                  ipv6_udp_local;;&
 
 	# setup namespaces and config, but do not run any tests
 	setup_sym|setup)                 setup_sym; exit 0;;
-- 
2.43.1


