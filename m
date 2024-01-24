Return-Path: <netdev+bounces-65409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE083A629
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A07B2C1F8
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF886182AB;
	Wed, 24 Jan 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYLs3LyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAE18659
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090316; cv=none; b=XIWzeQTPtEXonc66aT0b3HRqQtJPb8emr+F9v2+tS28zJj2fdVhKNFHEHrOT/b/xx7BK+WuO4MlORrT11eSBIwxjdIaj4QpL0dlVunv4/wO+1pY5JE4BdBa80IX+UN0JwIrMq0qkbsVADNmNdHoLU/1YBgcGSQ/khD73j3Nx4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090316; c=relaxed/simple;
	bh=gHm6X99Q4B3nIRHJA1QAVgapALGsTiaa/2TWhMjMSD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8mgVK61EH+IzicCFjZ8ToE+2dYDSo1ZjL7zWDRG/092SYXJmQphYoQNpn1GPsWEt6wj1flzxE7Iq7IFMK9R1gT5Y+XWwcA0BDZTNFKZKG7g2dkqKWnPHUde7PdLnReM/YXq28O1bnU+t3kWOv7yYgHs/Xuo5kVNtKOXTVqDufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYLs3LyU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290b1e19101so1970066a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090314; x=1706695114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zNjiZbzDtGZyFdOlANCjflLDW/2o4I4JIwv1yGiJjA=;
        b=IYLs3LyUcN7I0HZjy1etJ3QTLsdvFDCZgvS6QiE5CccafP8ISiyYVrkKHs9+aaTuO+
         Pqlg/xuFXm93GABmS3iWd0Mylm/JKRuysGiKxAlxwxaIdtxxiWpIMDjtGPgcCob6rpSO
         jtNVSMslowzcQOW6tfaR3SHnCg+Cc8WwvIEMf9HLEoK6t2+hsyv34CRGtiWhLIYVzM9I
         kKnXY/FtClaIDrGN/MdPjlbskRqsysgfeToKtrYE1sVpVBUwCoA4P6kg45vnsqNY9SqX
         5dHUFtkxdLGpan2imdNtPc/TyBXODdLm6e0uZfHHL0jSuDLuiMasSFa1MRsnNID5RMmZ
         OXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090314; x=1706695114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zNjiZbzDtGZyFdOlANCjflLDW/2o4I4JIwv1yGiJjA=;
        b=DNkI+RQaZG1WzSG/0VT59UyEHrWXNBjFdPWnpYv455IYLiU535XekeSHoMru9i2RQ0
         iGyiPsRPT8fpi2fPaxRB3v4rm0GstVsLAeNkHBQVTKBw7RRcrszfDOaIQExogdoAYJle
         AOi0XIVP/0nljvm37ITsTIBss0F0i3bTnmmes3m1Gf/IhF/rrVuNBXm6TGWiIVzKbYvD
         rE3nXyEBq8lED3C8MiSKSRYpKHpqChBHSyLuJxjhXY3MY1+hy7OO993qnjLkyWmHvOAN
         Or1iRZtfPfRhybo4RK8rAfBxULVP71evCO3Hhko7MTAPSsVk4c55LYHw+EL2R0S01t44
         mTRg==
X-Gm-Message-State: AOJu0Yz9E3wbuAmcDW47R8ZyYKEbrhmeuO0Z5g+D+UxevMTGWR/TkHlq
	lLYOvysAguuQSOqqeWeCfMPd/F75n8QE1+IitKRjacLqJ7iHMoMonkO+5Vgo6/nUUWnv
X-Google-Smtp-Source: AGHT+IEHbGflzygDQdvv6Ip52Ff5hUCBmSJbYiPX0i8DYeNRx8HhNE7tQJ3DRPy5U1vOHWrOa+qPMQ==
X-Received: by 2002:a17:90a:b10f:b0:28e:850e:7e87 with SMTP id z15-20020a17090ab10f00b0028e850e7e87mr1268952pjq.41.1706090313749;
        Wed, 24 Jan 2024 01:58:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm13055367pjb.37.2024.01.24.01.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:58:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 4/4] selftests: bonding: use busy/slowwait instead of hard code sleep
Date: Wed, 24 Jan 2024 17:58:14 +0800
Message-ID: <20240124095814.1882509-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124095814.1882509-1-liuhangbin@gmail.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use busywait or slowwait instead of hard code sleep. When using busywait
to check the link connection, I will set ping timeout to 0.1, which
could make busywait not too busy.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond-lladdr-target.sh | 21 ++++++++++++++++---
 .../drivers/net/bonding/bond_macvlan.sh       |  5 ++---
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +++---
 3 files changed, 23 insertions(+), 9 deletions(-)

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
index b609fb6231f4..4fddb28a0715 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
@@ -58,7 +58,7 @@ macvlan_over_bond()
 	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
 	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
 
-	sleep 2
+	busywait 2000 ip netns exec ${c_ns} ping ${s_ip4} -c 1 -W 0.1 &> /dev/null
 
 	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
 	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
@@ -69,8 +69,7 @@ macvlan_over_bond()
 	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
 	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
 
-
-	sleep 5
+	busywait 5000 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
 
 	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
 	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index a509ef949dcf..7c3f15bc6a9b 100644
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
+	busywait 5000 ip netns exec ${s_ns} ping ${c_ip6} -c 1 -W 0.1 &> /dev/null
 }
 
 server_destroy()
@@ -150,7 +150,7 @@ bond_check_connection()
 {
 	local msg=${1:-"check connection"}
 
-	sleep 2
+	busywait 2000 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
 	ip netns exec ${s_ns} ping ${c_ip4} -c5 -i 0.1 &>/dev/null
 	check_err $? "${msg}: ping failed"
 	ip netns exec ${s_ns} ping6 ${c_ip6} -c5 -i 0.1 &>/dev/null
-- 
2.43.0


