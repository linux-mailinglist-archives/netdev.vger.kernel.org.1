Return-Path: <netdev+bounces-68281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2568465F2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D238A1F25024
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B51B66D;
	Fri,  2 Feb 2024 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6pxuRMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF15C8EA
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841500; cv=none; b=KKpiWtLLlv7ZT33tO6QDOcun/V1s3L8Rb2/tW6k2GsP/JcuVplY8rtY2Wr8JqiR/1uLJkoJxJcxmemUk+hAWhCC3o5LWprU09xXjdS/K3aUoUSkzQTk5q+5vAnfdna8N5hKDM+7IesYODXy1yUn8OSqpdH23MENvHlNTqXquNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841500; c=relaxed/simple;
	bh=zJdidQYa9AADNngsqGQ0JLKnlpMwCBGS7dyutvjzjvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3GyrIS4HrUa9psnau4xCVTyuEr7TsefQI5DF7DQ2+GH56pIlfNxgf1buCpk5EZhjjHW0XnbdNEfiEIiEhhE86kwDBmUMyY3cHJTETWSqqpd7lQV0m1bcsl0+NaESa2Nj5+YMvgi3MKs9G9OVohsaZJpn5eXc4MFfdU9qhpzayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6pxuRMZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1443854a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841497; x=1707446297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROyTVP+CZ1AMHXlRGWi4pRwAXiD8TK9McQ610tQyilc=;
        b=S6pxuRMZ5IDX4rAo0Ilffdql228PwCI9Ns/q80M/TiiI9n8yRoUN7VcWw/TJ+xzOz9
         2nkuOBnUpzn+bgchoFNVhatBgvTWwQ+aL6tX6+8ogYiYf4OMXd8oYx0kzFzCNHZESeuy
         EKhp7sHJlHnqEfaVxZNl7TtXNaomMAr1CAK9FkyY4PLYBVwFwSXvAY9ifriZ2PLKnv+f
         nunPS6a3nugEgTqAakq1dzkLpBKhbfi60ODlt8/enqQU81cleNh3Jtrlk0P2efA5OxsJ
         khO1UXcSMif+HV0x/rnhAqlVsIBLQ/vqlf/HbfwIpy5ilC8KGFe5c9wEQMol5hQTuTzt
         6hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841497; x=1707446297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROyTVP+CZ1AMHXlRGWi4pRwAXiD8TK9McQ610tQyilc=;
        b=wu0KYFi8wjsCcxLfZRqnodA5gfQ66fXsXrJzIXT1Nxbl0nvRXuA2ifTNwtRTMDAtt5
         QbLovLdNv0sTXxLpx6/d89n6TciH5w5bnkyJAS8uIgLSMdNPf9f+3ANNozc8eSFLoDEW
         +/rjbRVG5Pm1NULHK9tQSG72P4NdsrDlGt3+6iz9wh3OF4EdOULI7GyNUZe0YfQ7JjCl
         d0MG5QetcaHglCVPWQb5hHa1sDY+w850LDS2/4AmHtGCadu0kGhVC9J+zksuISopla0j
         GPLIDu97f6kIMsArFXNYqshFEGXpfnAEdoGLvD6V4qvc+Anu6FPuea++PoD1vODKhu5F
         mhRg==
X-Gm-Message-State: AOJu0Yw6Uv+Uc0eNOtzC7WQJdfVbLsKO2/Q0AOrNcdjXmBGi6UzpUoga
	P8eLJTDcFKr+6ZiF9/VFr8nk893RRK+/zPJt2uTwY7QxZI+sO8A878ky6tBVy7hgU0Qs
X-Google-Smtp-Source: AGHT+IHkQftHAKYoArCyRZg2tukcE6eb0938Dqw9g8iKnvd0U8lpvp9PIzrCGcMebzk5AuEDUS5T4g==
X-Received: by 2002:a05:6a21:629:b0:19c:1881:b4fa with SMTP id ll41-20020a056a21062900b0019c1881b4famr641835pzb.33.1706841497492;
        Thu, 01 Feb 2024 18:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLD8LCviu/8y9F6jMb2hhVA2ZquDwZTo8ZPx9oM7vyccxnqzmTrZwgwgmY8omnebUKqyrh9WXnc6JJFEdfv+VPaBVjKR1uRmPrgOjbO7snLZ6p50x9cOKciUOWLaRkNmdXRHKtOZXaCMHhij8+pR13oWpVKzWSscQi0ddCc1lcvXjpiK/dOxPfT1rxSGuM+A165eWL5kLn+WzuYD0kUt4r9Sq+dCHG2w+5R880iGcdxaW9Z1ZKb3UuZWi0AbeXO382xg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001d944b3c5f1sm493256plb.178.2024.02.01.18.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:38:16 -0800 (PST)
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
Subject: [PATCHv3 net-next 4/4] selftests: bonding: use slowwait instead of hard code sleep
Date: Fri,  2 Feb 2024 10:37:54 +0800
Message-ID: <20240202023754.932930-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202023754.932930-1-liuhangbin@gmail.com>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
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
index b609fb6231f4..acd3ebed3e20 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
@@ -58,7 +58,7 @@ macvlan_over_bond()
 	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
 	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
 
-	sleep 2
+	slowwait 2 ip netns exec ${c_ns} ping ${s_ip4} -c 1 -W 0.1 &> /dev/null
 
 	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
 	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
@@ -69,8 +69,7 @@ macvlan_over_bond()
 	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
 	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
 
-
-	sleep 5
+	slowwait 5 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
 
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


