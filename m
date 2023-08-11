Return-Path: <netdev+bounces-26717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F8778A64
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71747281FCC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2663C3;
	Fri, 11 Aug 2023 09:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738963FE1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:53:29 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173A2723
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:53:26 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56c87f89178so1438281eaf.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691747605; x=1692352405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6xxnkVwZ7mHNxtqbRTjUc90UCyPzLY4stro5qQasOM=;
        b=Hm52Uz6azHqPfqgw/nrSZxyVJksDkCFaUxOmHBuz88VsfODlX/H5Vou8QbZTFt7HAc
         YEmqtjLQF0ELFUQdSBKN21IFNCO6p15bppvn2cCNOMI0jmajkn2zDmNRXZDcL4zPi4ls
         yYkhonwkwzorpo/BrOgtrv/cGSZMnWKuKRCjVG3V5TRi5qIAlw/1ahiT2Z5b2W4QFVZx
         B4BRqW02AAxP+GNQ9kicRrG2V11Dxmuecckcu4lF+Zea76IZzkewGpOU/ctSGSIANSsD
         bdi+rb65Ye+gi8UMaw+bmrjh0z3trdVzlirztcJoosaD23gGjUK50KhP3D0Lu2jne9Nr
         polg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747605; x=1692352405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6xxnkVwZ7mHNxtqbRTjUc90UCyPzLY4stro5qQasOM=;
        b=Ko0225yNlM9sidVidx7tzFrqlKFZ08Qu8iYeu3D9L5FBIe+NRFq5JeyAbVwklh/Mf0
         hCOGfOf78LD0sbNfbsXBKvYl/tKuk6GcBrgOCrA7aM+9TExQ0yZrWHHP6iaN8SBacS/l
         8OeZqa12aQzSeSiLF7gkouz0i9yT1rciDB+a9PDAZlgb5gomGyGzLGPE+470gE8vpasQ
         y4KwazAFv5hMVbZ/bLHrQEUnPNEBaRbCU45TaVlr0Mit7VSXgpGfmKRRNzmTGzRtXcbx
         A4qQZQPeGG6/6x5o1kG1NqCkHR4Zw6smpyixWWN5OcOm47i6cwRsVR7Bsid/Ji7ji31v
         DChg==
X-Gm-Message-State: AOJu0YzBdZfkmmhz8NvDuQmA96VYm5vB+oce7rvZoA4u45yg26QsiFld
	mtzpK3J0czo3MCB5ealf5vVRm/0IWevD/Q==
X-Google-Smtp-Source: AGHT+IFE6d5cswrVGMPjmhjyYB1Wa/2QPSSU22rZY/v2Zjm37XBE/do0CeajZQ1jxWn9i9lD4KR7/Q==
X-Received: by 2002:a05:6808:159b:b0:3a7:5ae:100f with SMTP id t27-20020a056808159b00b003a705ae100fmr1832613oiw.43.1691747604940;
        Fri, 11 Aug 2023 02:53:24 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k17-20020a637b51000000b005639da5a8e2sm2966108pgn.2.2023.08.11.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:53:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Thomas Haller <thaller@redhat.com>
Subject: [PATCHv5 net-next] ipv6: do not match device when remove source route
Date: Fri, 11 Aug 2023 17:53:08 +0800
Message-Id: <20230811095308.242489-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an IPv6 address on an interface and cleaning up the
related preferred source entries, it is important to ensure that all
routes associated with the deleted address are properly cleared. The
current implementation of rt6_remove_prefsrc() only checks the preferred
source addresses bound to the current device. However, there may be
routes that are bound to other devices but still utilize the same
preferred source address.

To address this issue, it is necessary to also delete entries that are
bound to other interfaces but share the same source address with the
current device. Failure to delete these entries would leave routes that
are bound to the deleted address unclear. Here is an example reproducer
(I have omitted unrelated routes):

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 1:2:3:4::5/64 dev dummy1
+ ip route add 7:7:7:0::1 dev dummy1 src 1:2:3:4::5
+ ip route add 7:7:7:0::2 dev dummy2 src 1:2:3:4::5
+ ip -6 route show
1:2:3:4::/64 dev dummy1 proto kernel metric 256 pref medium
7:7:7::1 dev dummy1 src 1:2:3:4::5 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 src 1:2:3:4::5 metric 1024 pref medium

Ido notified that there is a commit 5a56a0b3a45d ("net: Don't delete
routes in different VRFs") to not affect the route in different VRFs.
To fix all these issues. We will:
1. Remove the !rt-nh checking to clear the IPv6 routes that are using a
   nexthop object. This would be consistent with IPv4.
2. Remove the rt dev checking and add an table id checking to not remove
   the route in different VRFs.
3. Add a check to make sure not remove the src route if the address still
   exists on other device(in same VRF).

After fix:
+ ip addr del 1:2:3:4::5/64 dev dummy1
+ ip -6 route show
7:7:7::1 dev dummy1 metric 1024 pref medium
7:7:7::2 dev dummy2 metric 1024 pref medium

An ipv6_del_addr test is added in fib_tests.sh. Here is the result.

IPv6 delete address route tests
    Regular FIB info
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Identical FIB info with different table ID
    TEST: Prefsrc removed from VRF when source address deleted          [ OK ]
    TEST: Prefsrc in default VRF not removed                            [ OK ]
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    TEST: Prefsrc in VRF is not removed by address delete               [ OK ]
    Table ID 0
    TEST: Prefsrc removed in default VRF when source address deleted    [ OK ]
    Identical address on different devices
    TEST: Prefsrc not removed when src address exists on other device   [ OK ]

Reported-by: Thomas Haller <thaller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2170513
Fixes: c3968a857a6b ("ipv6: RTA_PREFSRC support for ipv6 route source address selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v5: Move the addr check back to fib6_remove_prefsrc.
v4: check if the prefsrc address still exists on other device
v3: remove rt nh checking. update the ipv6_del_addr test descriptions
v2: checking table id and update fib_test.sh
---
 net/ipv6/route.c                         |   9 +-
 tools/testing/selftests/net/fib_tests.sh | 117 ++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..0f981cc5bed1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4590,11 +4590,12 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
 	struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
 	struct net *net = ((struct arg_dev_net_ip *)arg)->net;
 	struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
+	u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
 
-	if (!rt->nh &&
-	    ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
-	    rt != net->ipv6.fib6_null_entry &&
-	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
+	if (rt != net->ipv6.fib6_null_entry &&
+	    rt->fib6_table->tb6_id == tb6_id &&
+	    ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr) &&
+	    !ipv6_chk_addr(net, addr, rt->fib6_nh->fib_nh_dev, 0)) {
 		spin_lock_bh(&rt6_exception_lock);
 		/* remove prefsrc entry */
 		rt->fib6_prefsrc.plen = 0;
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..0b5c99d80d56 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1796,6 +1796,8 @@ ipv4_del_addr_test()
 	$IP li set dummy1 up
 	$IP li add dummy2 type dummy
 	$IP li set dummy2 up
+	$IP li add dummy3 type dummy
+	$IP li set dummy3 up
 	$IP li add red type vrf table 1111
 	$IP li set red up
 	$IP ro add vrf red unreachable default
@@ -1808,11 +1810,13 @@ ipv4_del_addr_test()
 	$IP addr add dev dummy2 172.16.104.1/24
 	$IP addr add dev dummy2 172.16.104.11/24
 	$IP addr add dev dummy2 172.16.104.12/24
+	$IP addr add dev dummy3 172.16.104.1/24
 	$IP route add 172.16.105.0/24 via 172.16.104.2 src 172.16.104.11
 	$IP route add 172.16.106.0/24 dev lo src 172.16.104.12
 	$IP route add table 0 172.16.107.0/24 via 172.16.104.2 src 172.16.104.13
 	$IP route add vrf red 172.16.105.0/24 via 172.16.104.2 src 172.16.104.11
 	$IP route add vrf red 172.16.106.0/24 dev lo src 172.16.104.12
+	$IP route add 172.16.108.0/24 via 172.16.104.2 src 172.16.104.1
 	set +e
 
 	# removing address from device in vrf should only remove route from vrf table
@@ -1864,11 +1868,121 @@ ipv4_del_addr_test()
 	$IP ro ls | grep -q 172.16.107.0/24
 	log_test $? 1 "Route removed in default VRF when source address deleted"
 
+	# removing address from one device while other device still has this
+	# address should not remove the source route
+	echo "    Identical address on different device"
+	$IP addr del dev dummy3 172.16.104.1/24
+	$IP ro ls | grep -q 172.16.108.0/24
+	log_test $? 0 "Route not removed when source address exists on other device"
+
 	$IP li del dummy1
 	$IP li del dummy2
+	$IP li del dummy3
 	cleanup
 }
 
+ipv6_del_addr_test()
+{
+	echo
+	echo "IPv6 delete address route tests"
+
+	setup
+
+	set -e
+	$IP li add dummy1 up type dummy
+	$IP li add dummy2 up type dummy
+	$IP li add dummy3 up type dummy
+	$IP li add red type vrf table 1111
+	$IP li set red up
+	$IP ro add vrf red unreachable default
+	$IP li set dummy2 vrf red
+
+	$IP addr add dev dummy1 2001:db8:104::1/64
+	$IP addr add dev dummy1 2001:db8:104::11/64
+	$IP addr add dev dummy1 2001:db8:104::12/64
+	$IP addr add dev dummy1 2001:db8:104::13/64
+	$IP addr add dev dummy2 2001:db8:104::1/64
+	$IP addr add dev dummy2 2001:db8:104::11/64
+	$IP addr add dev dummy2 2001:db8:104::12/64
+	$IP addr add dev dummy3 2001:db8:104::1/64
+	$IP route add 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	$IP route add table 0 2001:db8:107::/64 via 2001:db8:104::2 src 2001:db8:104::13
+	$IP route add vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+	$IP route add vrf red 2001:db8:106::/64 dev lo src 2001:db8:104::12
+	$IP route add 2001:db8:108::/64 via 2001:db8:104::2 src 2001:db8:104::1
+	set +e
+
+	# removing address from device in vrf should only remove it as a
+	# preferred source address from routes in vrf table
+	echo "    Regular FIB info"
+
+	$IP addr del dev dummy2 2001:db8:104::11/64
+	# Checking if the source address exists instead of the dest subnet
+	# as IPv6 only removes the preferred source address, not whole route.
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::11"
+	log_test $? 1 "Prefsrc removed from VRF when source address deleted"
+
+	$IP -6 ro ls | grep -q " src 2001:db8:104::11"
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::11/64
+	$IP route replace vrf red 2001:db8:105::/64 via 2001:db8:104::2 src 2001:db8:104::11
+
+	$IP addr del dev dummy1 2001:db8:104::11/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::11"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::11"
+	log_test $? 0 "Prefsrc in VRF is not removed by address delete"
+
+	# removing address from device in vrf should only remove preferred
+	# source address from vrf table even when the associated fib info
+	# only differs in table ID
+	echo "    Identical FIB info with different table ID"
+
+	# IPv6 works different with IPv4 when the nexthop device is in a
+	# different VRF.
+	$IP addr del dev dummy2 2001:db8:104::12/64
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::12"
+	log_test $? 0 "Prefsrc not removed from VRF when nexthop dev in other VRF"
+
+	$IP -6 ro ls | grep -q "src 2001:db8:104::12"
+	log_test $? 0 "Prefsrc in default VRF not removed"
+
+	$IP addr add dev dummy2 2001:db8:104::12/64
+	$IP addr del dev dummy1 2001:db8:104::12/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::12"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::12"
+	log_test $? 0 "Prefsrc in VRF is not removed by address delete"
+
+	$IP addr del dev dummy2 2001:db8:104::12/64
+	$IP -6 ro ls vrf red | grep -q "src 2001:db8:104::12"
+	log_test $? 1 "Prefsrc in VRF is removed by address delete"
+
+	# removing address from device in default vrf should remove preferred
+	# source address from the default vrf even when route was inserted
+	# with a table ID of 0.
+	echo "    Table ID 0"
+
+	$IP addr del dev dummy1 2001:db8:104::13/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::13"
+	log_test $? 1 "Prefsrc removed in default VRF when source address deleted"
+
+	# removing address from one device while other device still has this
+	# address should not remove the source route
+	echo "    Identical address on different devices"
+	$IP addr del dev dummy3 2001:db8:104::1/64
+	$IP -6 ro ls | grep -q "src 2001:db8:104::1 "
+	log_test $? 0 "Prefsrc not removed when src address exists on other device"
+
+	$IP li del dummy1
+	$IP li del dummy2
+	$IP li del dummy3
+	cleanup
+}
 
 ipv4_route_v6_gw_test()
 {
@@ -2211,6 +2325,7 @@ do
 	ipv6_addr_metric)		ipv6_addr_metric_test;;
 	ipv4_addr_metric)		ipv4_addr_metric_test;;
 	ipv4_del_addr)			ipv4_del_addr_test;;
+	ipv6_del_addr)			ipv6_del_addr_test;;
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
-- 
2.38.1


