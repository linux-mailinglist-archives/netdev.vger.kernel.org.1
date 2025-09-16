Return-Path: <netdev+bounces-223390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D428B58FE2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D611B2210A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75559284686;
	Tue, 16 Sep 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaIe7kk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACC1F419A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009704; cv=none; b=CO9L4v3bHfkxSmo6O86oRGmsIaGb9LzkqRsklILQl3j283FgvRL37SUVgErVG5f1eleGWueX94e/rl6G4nFsEAcF1n/d5ulDadtw/YA83elEgT6Y30KYI4aJQIQVdnERDWJRoCLx7HT0GT4KjWWmhntvJ2BGAdDPeMnlb/aFIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009704; c=relaxed/simple;
	bh=jIPbYM76Be7XCwta1HhO/1JlpW706y9cF1GllizOnTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJLS0kVgqDCSZLNwQNsKACW403HNs0neBByYZsgZjNyelNerwhewV01/pgETpv9Wc0MxIhjylVaIxrkCpKo1MA+Z/iYA7Nb7iv7DrscJ5xXH3RklmLgCc5Zi0M/z/JAJLLjSUrAv0cgETEnnl6aB0uHrKEzJERPgDA4NpmJSDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaIe7kk6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e11a1401bso2438739a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009702; x=1758614502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bYlsgdaKwvtuqZohQ4tCMqBlo1y5YM99SKTPt0q12M=;
        b=BaIe7kk60jV45Kvi03wcyS72eIXDwSxC1jRjOAGIh43iZJw/cwH72+/yGZOUYBLJkj
         RTdCzvI09medg0vRXGpKI1iaOO9cP2V0hKiNFoLUBQOfQKHGAmQxD6CrLPZ11ONRxHg6
         gE3x+T6V/YcYjQ/1LUgB+5ZQMuhwYvFBz2f/mHC6rfDb87hizRysL/fsg1ihlj+Juy2H
         pYr/LBlQxhDbdtl9hB2IOKviSJ0LeKCtVgt2PxkFO1btgtxP8Jnw6aaic79rPOgtj9jC
         59CC5ITjkvoNJsMFe7atEljHfTNI45+kL4wkzBjOYtJtVcuMk4iLwd6KRovcyf+s8KWl
         1S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009702; x=1758614502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bYlsgdaKwvtuqZohQ4tCMqBlo1y5YM99SKTPt0q12M=;
        b=p2P9lqEdoQSN6M0ih0eGyyBAUI+U+JaTfIcWprn1lxvoQe9av4FacEJqLz2cXgDwz5
         S+cvAd1PLoYuGIr20dcX1VvvlGYB1vk8VJItTsnbCzUmixVNOCnkMGaWbV29MHqMhoP6
         Jn3UCSvt1OyI8PLTKgu6xRZFes+VHbhmieKUcdi75qClQvVEMjtI2yUY0q4GvSVDyHci
         mCV/stafyfTMeHJhOZchVZeKF8G0SN1n2xWeMm5Rey8Xg38GZDOCH+DXt+EvZSgns5v0
         TnfUeieUrpiQVXscPpse7nXCBg6Md9hI06nwfh4Xm0pMYpwSwY9+6rh/7Bb9k+yrnMI+
         OWYg==
X-Gm-Message-State: AOJu0YwY1C197oyNPBz3GkL4c8eBwb2aqFCfN3Xs/sbzLIlSapOYl/LP
	4GTtaplSzRNcmUxooZyb92lmc+bxzbMnBGzJxqTkwsO/hwm2Cu5KkkyknPBcfDPMDDE=
X-Gm-Gg: ASbGncvww9Ggz/qxKTJYaSxYZGM1PV3YRH1JnKCXNFHNZM4OvTENWMIloZpli+PB6Xt
	LO06Hjm9RDBZTZ2pFUSTOG5R0b5/L3FLvn/WfRXx7qdeSDby4CZmQT2B+XDyLFF8mGz2QYFZKBX
	fvWKSN/Vyh8MGXxvpP27ux8/yXRfzQapuTqGpIgndquzzdyJHUa+tJiHg0OYtrV2PC4Qq+rPeNC
	rsB9lGLpZUcVYvCzbvCER2uOOsyA/3+s8goCxlTcYwDBycRMzG92u8NzAfRrrDjASYQY4wZ9ssW
	f/zIxmml+aH60pJn6YMvVHWmVwDu0CsqoA8GMcHcIeWS5DnJog5jO66QqTXMgUhVWfhK2w//elb
	b2e5XS5xsTRnyD03uwFpMemxGQarJn6ue5ad3CLvREg==
X-Google-Smtp-Source: AGHT+IGQdxmLttPJVBzfukIDHLiPWYei+u2V5fgA5lDCOfzMO8K0xig3Y0J1i8KVOTyDY8RGeSlAOw==
X-Received: by 2002:a17:90b:1802:b0:32e:38f5:e860 with SMTP id 98e67ed59e1d1-32e38f5ea82mr11048666a91.15.1758009701879;
        Tue, 16 Sep 2025 01:01:41 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37bf1c19sm6826371a91.22.2025.09.16.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:01:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 2/2] selftests: bonding: add vlan over bond testing
Date: Tue, 16 Sep 2025 08:01:27 +0000
Message-ID: <20250916080127.430626-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250916080127.430626-1-liuhangbin@gmail.com>
References: <20250916080127.430626-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a vlan over bond testing to make sure arp/ns target works.
Also change all the configs to mudules.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: rebase to latest net
v3: do not switch all configs to module (Jakub Kicinski)
    redirect slowwait_for_counter output to /dev/null
v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)
---
 .../drivers/net/bonding/bond_options.sh       | 58 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 2 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index e3f3cc803b56..187b478d0ddf 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -8,6 +8,7 @@ ALL_TESTS="
 	arp_validate
 	num_grat_arp
 	fail_over_mac
+	vlan_over_bond
 "
 
 lib_dir=$(dirname "$0")
@@ -508,7 +509,64 @@ fail_over_mac()
 	log_test "fail_over_mac 2" "failover: backup slave mac inherit"
 	check_first_slave_random_mac
 	log_test "fail_over_mac 2" "first slave mac random"
+}
+
+vlan_over_bond_arp()
+{
+	local mode="$1"
+	RET=0
+
+	bond_reset "mode $mode arp_interval 100 arp_ip_target 192.0.3.10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 101 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+	log_test "vlan over bond arp" "$mode"
+}
+
+vlan_over_bond_ns()
+{
+	local mode="$1"
+	RET=0
+
+	if skip_ns; then
+		log_test_skip "vlan_over_bond ns" "$mode"
+		return 0
+	fi
 
+	bond_reset "mode $mode arp_interval 100 ns_ip6_target 2001:db8::3:10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 102 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+	log_test "vlan over bond ns" "$mode"
+}
+
+vlan_over_bond()
+{
+	# add vlan 3 for client
+	ip -n "${c_ns}" link add eth0.3 link eth0 type vlan id 3
+	ip -n "${c_ns}" link set eth0.3 up
+	ip -n "${c_ns}" addr add 192.0.3.10/24 dev eth0.3
+	ip -n "${c_ns}" addr add 2001:db8::3:10/64 dev eth0.3
+
+	# Add tc rule to check the vlan pkts
+	tc -n "${c_ns}" qdisc add dev eth0.3 clsact
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol arp \
+		handle 101 flower skip_hw arp_op request \
+		arp_sip 192.0.3.1 arp_tip 192.0.3.10 action pass
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol ipv6 \
+		handle 102 flower skip_hw ip_proto icmpv6 \
+		type 135 src_ip 2001:db8::3:1 action pass
+
+	vlan_over_bond_arp "active-backup"
+	vlan_over_bond_ns "active-backup"
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 4d16a69ffc65..832fa1caeb66 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -10,3 +10,4 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_VLAN_8021Q=m
-- 
2.50.1


