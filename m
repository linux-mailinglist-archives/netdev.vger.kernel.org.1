Return-Path: <netdev+bounces-110518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF192CC9E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651471F21A8B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA98526A;
	Wed, 10 Jul 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Sjhw1Bny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C38287E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599327; cv=none; b=lT3gkCdRIilSCxACeITrPt9e8if5K+cCEsKFTRuBRE8qxnuVN8k9WjNHB3ZjyAL7TZRr5ZenMgIy56JaYYPoAe/FBhmDFZ/YmYj+TtZDVQOGCQTC/NlHJpt0XytnhzpKjVZ6a9tzFOKzQGZ4l+Mz9i76hXZSUxqkm8rMBuImhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599327; c=relaxed/simple;
	bh=1JzfSMHUDYGHzQLy8AlMX+aaizG8MdTX6YEZHk00ckE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6Qv2XKXvQ/ByTyoyrFjDV6HqdfhY0tR2pvGI1OoC9olvMYTpKyxScawnKApuHsWw6wGUM0eKDiTmnrCehfpxVMRmqbjo/jKDVgYQoBhqYA4QImBnTGPa1uD8KkWh0TTNPk/cpiiWOjPEqaEySNUe1wHj5LAB5dSc9Twuj+Vd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Sjhw1Bny; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so868218a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720599324; x=1721204124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE5Dx4qup9WtpzmHI/wzoD5SSmj6JOH4d2YLtDw7nBQ=;
        b=Sjhw1BnyUMImW4M1a3Yfr71ZSECD1inSDYPZNDDwkLzUpEe5w2AJ97eFpQuEqKYBKn
         nId4YzyZcRPJe79pDHiR27hZA95NWU8DtKRQarT+JMCNqJ3PdDcFz8hdfwnGMqU9k3ls
         a8boC8J856pOfSpTxRyLsvqIv96uCVYabY27TKX5AiSoK+kEsLyHWZrOew4fK4A/PjY7
         xfY8cAAlT14+xlhrni2llIzoMAeDwk7CqhMt8cP33XCouHTNZou7HQoJ7Uz1cFLFF4Il
         E/cwflf1DcgGt+1d2tdBzAB4sMeQYF+YcUcNGh04CYIU6ftOudicqHEtmlbkwqtrolZp
         zASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599324; x=1721204124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE5Dx4qup9WtpzmHI/wzoD5SSmj6JOH4d2YLtDw7nBQ=;
        b=Wwy5LELYsqNUHrmQes5Uxcxxau6TjE83WFt9nGTOjCStu2g9+m4jARFvIR90tzCaot
         L2bkTTcKOiwbtd4u1mrpx3T6LqsN7p0Yug6dt2UzVO8zIRFJVS7fYgdqn/ZerZ1V+wqi
         P0pGWJs9iYVJAK6A0CTDBmRzbghkqKOOSn6YrwR0qXTl8fdsAnlMw3DJT2lbnCXL5twL
         13YGuNbAu2bV4GckcGuzmgiJhmEwF492W3W9AueGsKQBbFGRoFAJ0P/39hGcNaOWcR1w
         MJNHgwwIi63hKnmCB2BzKGZBC0Qp5kwNmlrUphtqgSI5yvznisy9vbWZLZK2FnruRgse
         e1ng==
X-Forwarded-Encrypted: i=1; AJvYcCUeXqMpBI7FXImqIutgltlX68ompzv9Icuo0yUrx0P8YsbsboQc0cRFqYD7qXKPdnYG1k+TPRfNqQUitl2bBiZshCkqwxCM
X-Gm-Message-State: AOJu0YwNVr28nOEKV/fryvDb22/JQyqyzFfws8KKOmr1p+/EXUQyeNll
	zvfIzD33ou2H+QuLYjwJhFtOdb1LMYqDaXJxdvUvwXJsXekKk/6+6YUnnCh68T7ZnBVeO1viEIB
	sV4/VPXiLVOwKhs1SpjJGid6dedUhS39T
X-Google-Smtp-Source: AGHT+IHN2DiWCkYusAIPa1JSTEHycI+A+8qxR4Dg716keCPFslHPmvd6aKnmLgt3kfBkd3wPijvKlR7UvqXd
X-Received: by 2002:a05:6402:696:b0:595:7779:1f7 with SMTP id 4fb4d7f45d1cf-5957779030cmr2730557a12.16.1720599324002;
        Wed, 10 Jul 2024 01:15:24 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-594bba54bebsm54406a12.3.2024.07.10.01.15.23;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 941C96047E;
	Wed, 10 Jul 2024 10:15:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sRSTz-00Fz75-9L; Wed, 10 Jul 2024 10:15:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v4 4/4] selftests: vrf_route_leaking: add local test
Date: Wed, 10 Jul 2024 10:14:30 +0200
Message-ID: <20240710081521.3809742-5-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
References: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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


