Return-Path: <netdev+bounces-69139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A051C849B51
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CA1283559
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A4020DD5;
	Mon,  5 Feb 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSC9vVIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195020DC9
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138074; cv=none; b=uxMPO/mNiy1ohP3Q9xDd1He/NJXfyKDEiVtknLehBMCONCkK8hrDwc+gamky/f9lyV8bMZH3g3wcAe3Lmw0GaYWDd4A5sffXEUCKn7Dz3VdR8mh5GYszn6/Rr1mq/aBTjRBs5EOXvlyHLN7uWTQLkw96SySH7rsGGSamFDUqWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138074; c=relaxed/simple;
	bh=o5YNneojXPnW87CVFXi1KGJB75d0sDWlMEQyGyaKEmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY0MV/Yluwe5SlYwcJYbkBnIewtuJfcN5hJdDgvIMeqjIZO2KgbsRgOrY3qzC8EluXG0vZ2a/g5ZZRJpOmh+OWjdmAbl++a5CrMEYM5AMrwDeXuY6nZDtSnCO6fGimBJ6CjfYEEmUx4iqruX5xP+d5XzyzTDjqUrkJPsEI/XjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSC9vVIs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d73066880eso37842365ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138071; x=1707742871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BsYS0JII2wqPsBRvjpRVtvAleGVUHvck6gX20GtRuQ=;
        b=HSC9vVIsJQVIqWlZy3qdWIKfVsB0dTK+D9cNDAAfiWflVMwRpa2AvtjSMJv/RHsl2y
         jPZFEljaIvAysbJl4lTahbluOPONMbuTPFSlYT+nn0BXPDpHkdpdKwPGhAe9kSXVdHh8
         IFkxRGckYbWejD+5OdVpiT7kDLksKbJy0Pz8vziQdhWsJ1ULbfTjhb/iclPqlmaoLz+v
         Nev34ZQ0NHoIeHQHn63SoM2aMEnIux1kW0wkEkvMck66QjSRaeoygtFRpbJK5SVNZvbv
         BLtEVpplZVzcmUsQagRDIs/j6qRTfCyypb/5vUZvIp9mJ9aoPYAYLBGTUJJN9+7a9NrJ
         GHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138071; x=1707742871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BsYS0JII2wqPsBRvjpRVtvAleGVUHvck6gX20GtRuQ=;
        b=MA3lcr2n1mRnizQkzaD9TV42OQXYCxRucdHWTxa5UFCw/WOvtgYbyXUXZ4jeInXD0k
         bV6eSSukRqYtjYm9ht8L5snocRUj/PTcJjjm1Upd/s36FWxgLpw7Y6fqvrbzXP1T0qbB
         e0gI61dO1ET6uQ2O8JXAm4y8morKv8mTXFrrWdMnOo0vrY0w/IxJwcMavnBnLf+nYbsa
         u+3vUUu9rKMhshq4PdClKw2AB6pKIFadj6P+63uuAy6y4NJt7tVbMUa9aW/JC1MlsL37
         T/NEufgFTuY5PuT2vzMxPSetW41pG/VvC+5kO8MDh7xqpCp67lX1GSCFKi7PPSsWlXdx
         73Cg==
X-Gm-Message-State: AOJu0Yw+Pm++xWH4Gt4iL/jISySZdjHWWgZaTtc575Sikc8jnKXuQnpV
	sjetQLCUZfYoPl2MZfduPzGMX/Am+5C6AA9OLTGWQZlkVtZeIBLfg4lo5E3P2gOUVA==
X-Google-Smtp-Source: AGHT+IFqLHnNScxDLHFOG00Rz09mcSw4RqK1ZKZJgeigRncz+EK/UjH+x4M/aAfhw3YApDjZvmS6tA==
X-Received: by 2002:a17:903:2446:b0:1d9:8ac8:d784 with SMTP id l6-20020a170903244600b001d98ac8d784mr10201851pls.7.1707138071477;
        Mon, 05 Feb 2024 05:01:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWN6tgblzBqOKy7cH3wWhd57Wc/kdjRaOJOJZ+jzLAkwNO0ubgvx6rDaoIfvWxK9vwLxO3YbS2bzdTCNg5zn3SRjQcDxZAecm+Th1PAETz5u+B2TmoTc2Vf+aoE3aQulMX0Pv4iBHXTZJLXn9YuCrJrxLVwXLczcuzpi7PUFUcOy907VYR2b7NOYzwJZCvNHGjNj96HsaYnXfns+fGzUtxoNeQQVmVkdLFD0Q2m6LX4JLTvLuALFMDWmvbCqHuJqAQzaw==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm6252159plh.68.2024.02.05.05.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:10 -0800 (PST)
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
Subject: [PATCHv5 net-next 4/4] selftests: bonding: use slowwait instead of hard code sleep
Date: Mon,  5 Feb 2024 21:00:48 +0800
Message-ID: <20240205130048.282087-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205130048.282087-1-liuhangbin@gmail.com>
References: <20240205130048.282087-1-liuhangbin@gmail.com>
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
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +++---
 .../selftests/drivers/net/bonding/lag_lib.sh  |  7 +++----
 3 files changed, 24 insertions(+), 10 deletions(-)

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


