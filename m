Return-Path: <netdev+bounces-67835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63C845163
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CC1B24875
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C348EED1;
	Thu,  1 Feb 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY9uEuiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEF83CD5
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769018; cv=none; b=QMMgHKPLEH6xYefE7dkU4yd0Bvjld0kZUPbNtTX6Da79bt/6cVjxykZ4PlDCxckidK3bZWRgUwesJaE53xqFxrymZPsDVDUu0An2mDyo3zy/PHUIUocqdkMPEBipNig5YpxGLk0/7h96c+zKAc5p98BFsEYu+tFjzampVt7miDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769018; c=relaxed/simple;
	bh=M74eNgV16JtgWx9aB7DcyItDIPTDR+gWkpKSQxRd9Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y22mvqG3Dd/1mIgaxih/KBynyu0LoBydAlddOJTDuXA+hjEoNy2ftjd1UhuKu+PobWvmzWc8BpW8ClgOuaO6Q2qNZ0isGjSUgjQEMTWcFOZF3jqAikAxwBVamTUm9v7GSt5Tg+nn9zx6vgqYPbmezV3rY+lCxVLZqD6A8uHS/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY9uEuiw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so423108a91.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769015; x=1707373815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej4ohfH3ilat5qexDhlEeW0/MFPNuEhuHNlBwUEMkl4=;
        b=kY9uEuiwupRKvN/kdZ2jjtZq376DpkFDGKEF1LPJIP01DQl4Cy9uSaDS0SlpNN5E7H
         U6Y1cxsHGhF4KvqaKeBLAy4HLdACARprUjGcLhpWCU9h5+/iJKIzRbVOb+0J0hm7FiaF
         No7QcTVzsbm5ensgMkvhfcCAA3kCqW3f0y5rr03ffn6EJkYG8pE8wZEdBW3QZNNFo10o
         X3xdG9fZAKYO5COXSvvx/DC0Y7DOXZzHSsSVarawxyAwI3EZX7MVRfcwrMANxQ1YfdS1
         Z9whgFqQGSsMJ70VrBYW9ckWjatX/Z/sJnW/3e6nqU8F5tMzzjyDzVh0nhlHB2jsfwBP
         Skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769015; x=1707373815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej4ohfH3ilat5qexDhlEeW0/MFPNuEhuHNlBwUEMkl4=;
        b=QFMR4N7M4PjiodG0e0zUR0cXMoht+oVxMZ9sevMzhlwYqMAJ0Gfi1B+nio6vFZQWzI
         wcFj0CpxC/0m5JjlqKXtI715pJDGV3bOOKNrdzfuqWzRw+jrW+6yEaBWFwKlbvrPVUuw
         cnym8LeXfQMC0HREq1r1mA1ZBWQoGwNjST3oBgnHVrVwHh9V8SW23i/rBDH2DGPW4xWQ
         17LyhFXtrDl1UDEwqKSlTifHu/19GcvMlfZ8IKOiLb8Jn55zKmczIA6WV9I5CvxMYXTY
         pV1P2qcoowoNxrN5qm/tM3THUZK8db7MHm+Kja3y4jv3BRG67muIDUGqldyV6ONeM9j4
         tD5g==
X-Gm-Message-State: AOJu0Yx9ier0l6OU6vrWVs6NyiCcKaQMEN4ZI+6UFU4/fQyWzWMg/ZSK
	J+KJKyCEBkxJaJPG4LJt0qx4C4ScdBJhmFcbCUSpC1pyODjRwd4yFpuGkA8DoerXyHtN
X-Google-Smtp-Source: AGHT+IEvQUjc30ptGFEoJ7RWP2nU5qS3B/ZsF74gvz6UhTdikCIpYXKBDgxQ6syIoyarSHkAD7az2Q==
X-Received: by 2002:a17:90b:f88:b0:295:c87f:6f51 with SMTP id ft8-20020a17090b0f8800b00295c87f6f51mr1247973pjb.26.1706769014942;
        Wed, 31 Jan 2024 22:30:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUr1GUPop459yagO+MWzNnM+ZQfsjsLw6YA1TqhmQRAclJ7xE11uW9y5qC6iBkVUB8TdDhEuTUYcMvSDLoEad5rUeSoxEK1hwiskGxNB2lMnojaYcxoGQ0KUpBVqnTkgG2pFslO5VGdmtr8GQ+UZa0hQ67sqU11oK9iyiJBFBjn/PB0YQ0XyPeSTge4RMDKmyn3NqhfSi3P/z5bSvO1TnXz+9T4i3GNkH7bszY3VJHR0DNo76twrU5vE9VXZTbsv30OqQ==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm12-20020a17090b3c4c00b0029618dbe87dsm515895pjb.3.2024.01.31.22.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:30:14 -0800 (PST)
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
Subject: [PATCHv2 net-next 4/4] selftests: bonding: use slowwait instead of hard code sleep
Date: Thu,  1 Feb 2024 14:29:54 +0800
Message-ID: <20240201062954.421145-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201062954.421145-1-liuhangbin@gmail.com>
References: <20240201062954.421145-1-liuhangbin@gmail.com>
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
index 89af402fabbe..b7b60e767daa 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-lladdr-target.sh
@@ -17,6 +17,11 @@
 #  +----------------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/net_forwarding_lib.sh
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
index a509ef949dcf..ed2317eea5d3 100644
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
index 2a268b17b61f..43447be54b10 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -96,13 +96,12 @@ lag_setup2x2()
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
@@ -148,7 +147,7 @@ test_bond_recovery()
 	create_bond $@
 
 	# verify connectivity
-	ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 >/dev/null 2>&1
+	slowwait 2 ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 -W 0.1 &> /dev/null
 	check_err $? "No connectivity"
 
 	# force the links of the bond down
@@ -158,7 +157,7 @@ test_bond_recovery()
 	ip netns exec ${SWITCH} ip link set eth1 down
 
 	# re-verify connectivity
-	ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 >/dev/null 2>&1
+	slowwait 2 ip netns exec ${CLIENT} ping ${SWITCHIP} -c 2 -W 0.1 &> /dev/null
 
 	local rc=$?
 	check_err $rc "Bond failed to recover"
-- 
2.43.0


