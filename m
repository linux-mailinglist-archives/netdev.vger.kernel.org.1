Return-Path: <netdev+bounces-68901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41F5848C48
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E745C1C23189
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4B1427A;
	Sun,  4 Feb 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c48yWX+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF916423
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036717; cv=none; b=DItzAXUrqpicZLX/ZthTiyZAPizb3arnS5mt6wq8Liq8k7Qbr+chd4N5lX5PiQ5oPDW+MmRx87rttLSpyc+kQsqAgksglRjW04xw9DPIo2pcwWgNskVPIBy+WJsQtCoGnbkIur+J2PBxBdZQDE7lgS66W2lNvoJeOsuc5aiCXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036717; c=relaxed/simple;
	bh=desnL+jA/Zr0KABIxn8iFjcjyqDkqg+s1fSbN3LQKxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFp7WvjwSTYlrR0m5sRR5A2zz3/WWNsdCgP0+baKYsDxt843KV0ABtgxJiyDDvlt75bHPE0C1JTiIb2DyotJ1kEFbSkAgMaoD2DJegETSYaW7UwpS/3IRCWAUdCLJZcacVYQwDUkhKVeEkmMvjcW/4hgkUu5F8CbGrS+bPI1mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c48yWX+w; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddb1115e82so2045965b3a.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036714; x=1707641514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPKB/+68qoHi0zib82miR5yf7x2+T7pG1dARh5KvH2A=;
        b=c48yWX+wxsRDL6Vx25EKbGmB9UyMS3SwnWFAuEiscNXoXBniVxODVOAc4k1p1r/c6c
         xVIyqrMIbcoi0as2XYrVvKYbHboJNvKhsbPfl6oe0bYm/ztVL5ArSCg2lPdxjksdwYx1
         8qB4ukDtO9xaOycyizI1rn+ZdybsGBxxn2/u9kvUV4eCgjnKO/DHAgYIiyzl3/hR4F6v
         cxi8p0wfDmUBSIPd61rAAi0DLoLQU7Q3HrOIZh5GdcP0TMtQvZ6S0fEto+M0cyKduYzC
         Ku5Np1lIMm3hlYlfU7tc4P2cdTvkg+nJ9UjXPgwuLD7j5w8lMerYFEqsYELm6QrhIMhv
         slYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036714; x=1707641514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPKB/+68qoHi0zib82miR5yf7x2+T7pG1dARh5KvH2A=;
        b=TV1UTdmcSbGEHL/oJCrnSpm7hwFNdoS4frTYVv/XI2JXwQlSYU2QwNwvhWEd3kmtMx
         baZT9jW1GPxJNu4KTDZGSNjX1PyRV8nZNrNEyqwUsPUs4h2hVbgftK/LAz8p90a7GRrc
         k3sJX5M+uhC/sdBmSOOHz42nBmVaO3u2Q0S08AkzdtbAyX5izURbqHS7x35JrWhfhuw6
         k9NYuZnW+E/SnnYr9iLePb3xA/Vanp+06efamWcWVJWcWDitz0iQvDVKQoUi6LlUzlT2
         iP8t0fm5+NQjiLvE9l/c2yly6wktSjaoVe6PgarPjSdYVjd8jOibCvsc0GlpYLBuWX+x
         Z17A==
X-Gm-Message-State: AOJu0Yzty/UnU5CSY3zXQ8qlCRH91jeo6vCsyqeYsHKpLr+D12rRKv0y
	16eOssBoJUR0JLPTmmS2gHega25I1y71L4DGM6z6W0mSYoYuVuT3SeXdtKCbPvGErw==
X-Google-Smtp-Source: AGHT+IEpi+b7oMuN1SDtHtcPS1Hg8T8Y2suW6ZAIpSEdxdAqRiWNxuRYm/CSAV49F2ocwgjwPZzeaQ==
X-Received: by 2002:a05:6a00:9391:b0:6df:e463:5ff6 with SMTP id ka17-20020a056a00939100b006dfe4635ff6mr11865262pfb.30.1707036713818;
        Sun, 04 Feb 2024 00:51:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2+5KT/VWxIo4OUwVSg6/sfn3wkBEC0GjbYJ21LJQhUCgVSUAjx9qyoRNeMWAy4/dX+UeFPi2hs9KHhZPLWuRnqZIR06/V5ZP8iWurZfqmjMQUWgXpc68BTqsaFnMWUe7aXHmCJ/lrUed2eBviqcPQV+fMUWVKwOtXaBSmfKVPMuwfUKUlh8m2gWT5r8X1odinocuw88OPCdSA9VhGtIikP0wmU+Yr9L2xvZ0Q4TKGBMt04pqQG0uVlsU/0epO8Bd9fw==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4398228pfb.200.2024.02.04.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:51:53 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 4/4] selftests: bonding: use slowwait instead of hard code sleep
Date: Sun,  4 Feb 2024 16:51:28 +0800
Message-ID: <20240204085128.1512341-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204085128.1512341-1-liuhangbin@gmail.com>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use slowwait instead of hard code sleep for bonding tests.

In function setup_prepare(), the client_create() will be called after
server_create(). So I think there is no need to sleep in server_create()
and remove it.

For lab_lib.sh, remove bonding module may affect other running bonding tests.
And some test env may buildin bond which can't be removed. The bonding
link should be removed by lag_reset_network() or netns delete.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond-lladdr-target.sh | 21 ++++++++++++++++---
 .../drivers/net/bonding/bond_macvlan.sh       |  5 ++---
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +++---
 .../selftests/drivers/net/bonding/lag_lib.sh  |  7 +++----
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh b/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh
index 89af402fabbe..78d3e0fe6604 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh
@@ -17,6 +17,11 @@
 #  +----------------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
 sw="sw-$(mktemp -u XXXXXX)"
 host="ns-$(mktemp -u XXXXXX)"
 
@@ -26,6 +31,16 @@ cleanup()
 	ip netns del $host
 }
 
+wait_lladdr_dad()
+{
+	$@ | grep fe80 | grep -qv tentative
+}
+
+wait_bond_up()
+{
+	$@ | grep -q 'state UP'
+}
+
 trap cleanup 0 1 2
 
 ip netns add $sw
@@ -37,8 +52,8 @@ ip -n $host link add veth1 type veth peer name veth1 netns $sw
 ip -n $sw link add br0 type bridge
 ip -n $sw link set br0 up
 sw_lladdr=$(ip -n $sw addr show br0 | awk '/fe80/{print $2}' | cut -d'/' -f1)
-# sleep some time to make sure bridge lladdr pass DAD
-sleep 2
+# wait some time to make sure bridge lladdr pass DAD
+slowwait 2 wait_lladdr_dad ip -n $sw addr show br0
 
 ip -n $host link add bond0 type bond mode 1 ns_ip6_target ${sw_lladdr} \
 	arp_validate 3 arp_interval 1000
@@ -53,7 +68,7 @@ ip -n $sw link set veth1 master br0
 ip -n $sw link set veth0 up
 ip -n $sw link set veth1 up
 
-sleep 5
+slowwait 5 wait_bond_up ip -n $host link show bond0
 
 rc=0
 if ip -n $host link show bond0 | grep -q LOWER_UP; then
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
index b609fb6231f4..77969824a3bf 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
@@ -58,7 +58,7 @@ macvlan_over_bond()
 	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
 	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
 
-	sleep 2
+	slowwait 5 ip netns exec ${c_ns} ping6 ${m2_ip6} -c 1 -W 0.1 &> /dev/null
 
 	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
 	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
@@ -69,8 +69,7 @@ macvlan_over_bond()
 	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
 	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
 
-
-	sleep 5
+	slowwait 5 ip netns exec ${m2_ns} ping6 ${c_ip6} -c 1 -W 0.1 &> /dev/null
 
 	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
 	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index 0eb7edfb584c..195ef83cfbf1 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -73,7 +73,6 @@ server_create()
 	ip -n ${s_ns} link set bond0 up
 	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
 	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
-	sleep 2
 }
 
 # Reset bond with new mode and options
@@ -96,7 +95,8 @@ bond_reset()
 	ip -n ${s_ns} link set bond0 up
 	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
 	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
-	sleep 2
+	# Wait for IPv6 address ready as it needs DAD
+	slowwait 2 ip netns exec ${s_ns} ping6 ${c_ip6} -c 1 -W 0.1 &> /dev/null
 }
 
 server_destroy()
@@ -150,7 +150,7 @@ bond_check_connection()
 {
 	local msg=${1:-"check connection"}
 
-	sleep 2
+	slowwait 2 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
 	ip netns exec ${s_ns} ping ${c_ip4} -c5 -i 0.1 &>/dev/null
 	check_err $? "${msg}: ping failed"
 	ip netns exec ${s_ns} ping6 ${c_ip6} -c5 -i 0.1 &>/dev/null
diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index dbdd736a41d3..bf9bcd1b5ec0 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -107,13 +107,12 @@ lag_setup2x2()
 	NAMESPACES="${namespaces}"
 }
 
-# cleanup all lag related namespaces and remove the bonding module
+# cleanup all lag related namespaces
 lag_cleanup()
 {
 	for n in ${NAMESPACES}; do
 		ip netns delete ${n} >/dev/null 2>&1 || true
 	done
-	modprobe -r bonding
 }
 
 SWITCH="lag_node1"
@@ -159,7 +158,7 @@ test_bond_recovery()
 	create_bond $@
 
 	# verify connectivity
-	ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 >/dev/null 2>&1
+	slowwait 2 ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 -W 0.1 &> /dev/null
 	check_err $? "No connectivity"
 
 	# force the links of the bond down
@@ -169,7 +168,7 @@ test_bond_recovery()
 	ip netns exec ${SWITCH} ip link set eth1 down
 
 	# re-verify connectivity
-	ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 >/dev/null 2>&1
+	slowwait 2 ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 -W 0.1 &> /dev/null
 
 	local rc=$?
 	check_err $rc "Bond failed to recover"
-- 
2.43.0


