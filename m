Return-Path: <netdev+bounces-20071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284175D860
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DD01C217BD
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EC39A;
	Sat, 22 Jul 2023 00:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A27F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:40:19 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C9D4220
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:52 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-579e5d54e68so28987497b3.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986361; x=1690591161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iigt2nFj5o7xOC+L0+ItN7dri4O6spB/48NyOZ2+MmQ=;
        b=IjTAms1ZhzDjCHkZ/oxyMou7fFoJUDZGK0cXxeifcajHxfbhgEp14Tt1d0xhhKhQ94
         sBEbE9BhALoyQmQW1JVOHKXySfAyFdHZn29uEsYrWNxGHEibGqK6HjNzz5TaXUD5hJmZ
         Zcf4kmlahwM/MyLiDN1iTb/M1djyYUjIa8xnbOzzUP6D2kwkbS69i328MldkLCX3rY93
         bwl7NEYAR37KJTHnynNFozFg8HDQ/Gs3s0rsP5BGIdqA00XvHSpN7oWCEesjylHgcDz3
         WKRRwKGgScnqBhyPV7Oykd0MUPCl9zZiiePDGfdsGkZD7UdD+5eUDXMf+iimVShfYxsz
         TAQA==
X-Gm-Message-State: ABy/qLb2COsOy4eDCIUae+kdZceEy/wm0G6UK01RSMgSiO60T7y+6ip/
	O/1O7ghw3WsW4l5OAY4lYkQ=
X-Google-Smtp-Source: APBJJlHNTJ1+BWGmY1XtULB68bxuCm2U71lUW2AAtq3RZutmfcR1IER5fyxmKQ7CInOF3lUlKxuF6g==
X-Received: by 2002:a0d:d5cd:0:b0:56d:805:1507 with SMTP id x196-20020a0dd5cd000000b0056d08051507mr1479861ywd.16.1689986361472;
        Fri, 21 Jul 2023 17:39:21 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a927:bf54:acf2:ee0a])
        by smtp.gmail.com with ESMTPSA id q2-20020a0dce02000000b005707d7686ddsm1265937ywd.76.2023.07.21.17.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:39:21 -0700 (PDT)
From: kuifeng@meta.com
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: thinker.li@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net-next v4 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Fri, 21 Jul 2023 17:38:39 -0700
Message-Id: <20230722003839.897682-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722003839.897682-1-kuifeng@meta.com>
References: <20230722003839.897682-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Add 10 IPv6 routes with expiration time.  Wait for a few seconds
to make sure they are removed correctly.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/testing/selftests/net/fib_tests.sh | 90 +++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..4c92fb3c3844 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,13 +9,16 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
+       ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
+       ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
+       ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
 PAUSE=no
-IP="ip -netns ns1"
-NS_EXEC="ip netns exec ns1"
+IP="$(which ip) -netns ns1"
+NS_EXEC="$(which ip) netns exec ns1"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
@@ -747,6 +750,86 @@ fib_notify_test()
 	cleanup &> /dev/null
 }
 
+fib6_gc_test()
+{
+	setup
+
+	echo
+	echo "Fib6 garbage collection test"
+	set -e
+
+	# Check expiration of routes every 3 seconds (GC)
+	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
+
+	$IP link add dummy_10 type dummy
+	$IP link set dev dummy_10 up
+	$IP -6 address add 2001:10::1/64 dev dummy_10
+
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+
+	# Temporary routes
+	for i in $(seq 1 1000); do
+	    # Expire route after 4 seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires 4
+	done
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 1000 ]; then
+		echo "FAIL: expected 1000 routes with expires, got $N_EXP"
+		ret=1
+	else
+	    sleep 5
+	    REALTM_P=$($NS_EXEC strace -T sysctl \
+		       -wq net.ipv6.route.flush=1 2>&1 | \
+		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
+	    N_EXP_s5=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_s5 -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	# Permanent routes
+	for i in $(seq 1 5000); do
+	    $IP -6 route add 2001:30::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	# Temporary routes
+	for i in $(seq 1 1000); do
+	    # Expire route after 4 seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires 4
+	done
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 1000 ]; then
+	    echo
+	    "FAIL: expected 1000 routes with expires, got $N_EXP (5000 permanent routes)"
+		ret=1
+	else
+	    sleep 5
+	    REALTM_T=$($NS_EXEC strace -T sysctl \
+		       -wq net.ipv6.route.flush=1 2>&1 | \
+		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
+	    N_EXP_s5=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_s5 -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires, got $N_EXP_s5 (5000 permanent routes)"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	set +e
+
+	log_test $ret 0 "ipv6 route garbage collection (${REALTM_P}s, ${REALTM_T}s)"
+
+	cleanup &> /dev/null
+}
+
 fib_suppress_test()
 {
 	echo
@@ -2217,6 +2300,7 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


