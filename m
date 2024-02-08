Return-Path: <netdev+bounces-70391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749C84EB36
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F23D2864C6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4C50267;
	Thu,  8 Feb 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd0+yROL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFD5025F
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430049; cv=none; b=sAxmmIsHWkxjBce1kjuDuZLjWdO8+Cmpslp6zev+6lKk8NwD3YdisFOYJmIyyeoIf9jBP9Po/oLiWbqQ18I3lAnsVp7ukQRINigdDmfWk17iColQm+lyk8xD1263MEH+qsvTiJI1s0q45O8ITxs7GxmipusWXtCUdo/yS00tYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430049; c=relaxed/simple;
	bh=6KvdwKAYUNOEx0dLHn/5abYIybKewuWQicN3vsA3JhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMIyYPBzrgmdbdztGvKzsRbAXzBWzDb/Sgz9CkSrdqrsvn2KxL4YNQn0OvY92+oXu0mWEJp/g35lwg3H4X7VDTyCA0NF3hpbbLv6dwrjDS6htCLifRDULAL7CpX36swd+Z5f/govt8lGhGjHpV+gW+7giOz3u2amWwK+d6o6yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd0+yROL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60491b1fdeaso4425577b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430046; x=1708034846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1hbKUlbtkGTDmfJjhu1WKYZnsnwJfdOfPThlA7N/jg=;
        b=Bd0+yROLR/Gpmk52QutLe2zi8GmtHc6Vzumuiwnv2vhtJWJq0PIXg1hZ8g3qRACg7F
         GYJqcAbWYo5rHlzAYt6wODsDF/a/nx+EhnKFScMDL9fuQ14IrRLuvyQAPZDHuCB5mLFU
         9lzXv1kfFeJWpO4+tDnAKfYx7NW1XGGD4oW2fLH4n2hV2wLYl1LqJg4yU/CbtId9Nb7k
         svh1UVYSRz/Y7ltm3J27SfQhM5rYORqz9CWWuBDkqYAv6v+Jyx+r6kErvjHtEkQsf9Jx
         JKiQ1dolbooXr/8eFRgvwT9OCGV8/k+ga8DLJgOFNxz75NIK/ZrcXhc/vDB68WnsHz02
         Ux9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430046; x=1708034846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1hbKUlbtkGTDmfJjhu1WKYZnsnwJfdOfPThlA7N/jg=;
        b=n6RqGhBLYRDKwbh2/wPd3cpxeT12rJaLEe+mDARaI1wX+zqKre2snRVVXJ8UmN0kdf
         c9AXVFCK8v8hkxwVeNE4qug7H+SO9ZgnzLadzg2exm87E8VG1drBxKirM7gQSf1gUDHD
         3Y66+dcv1Pr30f04dAIp/hfKCEsHmAx3SUXTAiijiLD0cORuNa2ceprGNq7EeH1BwNyT
         gS7DKoLti34it+GFJNqghDjm4YLDSeg+ESB5iNg1+5k4HxP69py7R7CZkFJ77oXXdISE
         KLJXFSD86k+HPVdGqtlyGmzzkVfRybHPbtyUOW8wh2jjEdtRwv41wbIiv7dTWpQpKun+
         v+aQ==
X-Gm-Message-State: AOJu0YzeNv6PEpeCVFcUYiAUWK4auAtV29y+PUpJ0u8J09pPevy9GVFt
	CkbJjOzfk2SQot9hprSCL9kXtB8PSl/OSLlFIdntTtUtQ3LA8rBk63J20xQct58=
X-Google-Smtp-Source: AGHT+IEl1xMhf3p0reD05U3MRSpLpwhWAkWT3uGyTCKRDd20pcqxB1/Cx8T/TM0IsrhVsIboObEnjQ==
X-Received: by 2002:a81:dd09:0:b0:5eb:3851:2bba with SMTP id e9-20020a81dd09000000b005eb38512bbamr704311ywn.41.1707430045957;
        Thu, 08 Feb 2024 14:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWeO5NiQT5zgb+w5nEcfr5AP7xrKGcRniYBcH6Z3us82LUAuRk7HDLgXgA4wGZmoNAhHnHtVFUp8nqoT9r+2tVJd8H4xl8sN3ribOOvFjJ8dBM43VNRasRRgvzMvSYto20ZsPSM6bImEjKO47wwZKVPB2AUXlU/okqmCCch8ebQ4getATrDmq5Grom2ALfLV9seOd9pAirV370rXeiR6paJvvUtc0nFRZhMZBIOKAqDHf6DG46O2DyqGXj/ZnFkWyNNLMOICxXAa2ewDGMP9PuUdE1ji2MI0SSkYfbTIYpCD/zyzu6lJ0ViiSwYHW0vv2OAkzRARIcNWsj4bX0a/dO390lTGFGuceFWA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:25 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v6 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Thu,  8 Feb 2024 14:06:53 -0800
Message-Id: <20240208220653.374773-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Add tests of changing permanent routes to temporary routes and the reversed
case to make sure GC working correctly in these cases.  Add tests for the
temporary routes from RA.

The existing device will be deleted between tests to remove all routes
associated with it, so that the earlier tests don't mess up the later ones.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 151 +++++++++++++++++++----
 1 file changed, 129 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index b3ecccbbfcd2..3ec1050e47a2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -743,6 +743,43 @@ fib_notify_test()
 	cleanup &> /dev/null
 }
 
+# Create a new dummy_10 to remove all associated routes.
+reset_dummy_10()
+{
+	$IP link del dev dummy_10
+
+	$IP link add dummy_10 type dummy
+	$IP link set dev dummy_10 up
+	$IP -6 address add 2001:10::1/64 dev dummy_10
+}
+
+check_rt_num()
+{
+    local expected=$1
+    local num=$2
+
+    if [ $num -ne $expected ]; then
+	echo "FAIL: Expected $expected routes, got $num"
+	ret=1
+    else
+	ret=0
+    fi
+}
+
+check_rt_num_clean()
+{
+    local expected=$1
+    local num=$2
+
+    if [ $num -ne $expected ]; then
+	log_test 1 0 "expected $expected routes, got $num"
+	set +e
+	cleanup &> /dev/null
+	return 1
+    fi
+    return 0
+}
+
 fib6_gc_test()
 {
 	setup
@@ -751,7 +788,7 @@ fib6_gc_test()
 	echo "Fib6 garbage collection test"
 	set -e
 
-	EXPIRE=3
+	EXPIRE=5
 
 	# Check expiration of routes every $EXPIRE seconds (GC)
 	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=$EXPIRE
@@ -763,44 +800,114 @@ fib6_gc_test()
 	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
 
 	# Temporary routes
-	for i in $(seq 1 1000); do
+	for i in $(seq 1 5); do
 	    # Expire route after $EXPIRE seconds
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2))
-	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
-	if [ $N_EXP_SLEEP -ne 0 ]; then
-	    echo "FAIL: expected 0 routes with expires, got $N_EXP_SLEEP"
-	    ret=1
-	else
-	    ret=0
-	fi
+	sleep $(($EXPIRE * 2 + 1))
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection"
+
+	reset_dummy_10
 
 	# Permanent routes
-	for i in $(seq 1 5000); do
+	for i in $(seq 1 5); do
 	    $IP -6 route add 2001:30::$i \
 		via 2001:10::2 dev dummy_10
 	done
 	# Temporary routes
-	for i in $(seq 1 1000); do
+	for i in $(seq 1 5); do
 	    # Expire route after $EXPIRE seconds
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2))
-	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
-	if [ $N_EXP_SLEEP -ne 0 ]; then
-	    echo "FAIL: expected 0 routes with expires," \
-		 "got $N_EXP_SLEEP (5000 permanent routes)"
-	    ret=1
-	else
-	    ret=0
+	sleep $(($EXPIRE * 2 + 1))
+	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
+
+	reset_dummy_10
+
+	# Permanent routes
+	for i in $(seq 1 5); do
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	# Replace with temporary routes
+	for i in $(seq 1 5); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route replace 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	check_rt_num_clean 5 $($IP -6 route list |grep expires|wc -l) || return
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
+
+	reset_dummy_10
+
+	# Temporary routes
+	for i in $(seq 1 5); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	# Replace with permanent routes
+	for i in $(seq 1 5); do
+	    $IP -6 route replace 2001:20::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	check_rt_num_clean 0 $($IP -6 route list |grep expires|wc -l) || return
+
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+
+	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
+
+	# ra6 is required for the next test. (ipv6toolkit)
+	if [ ! -x "$(command -v ra6)" ]; then
+	    echo "SKIP: ra6 not found."
+	    set +e
+	    cleanup &> /dev/null
+	    return
 	fi
 
-	set +e
+	# Delete dummy_10 and remove all routes
+	$IP link del dev dummy_10
 
-	log_test $ret 0 "ipv6 route garbage collection"
+	# Create a pair of veth devices to send a RA message from one
+	# device to another.
+	$IP link add veth1 type veth peer name veth2
+	$IP link set dev veth1 up
+	$IP link set dev veth2 up
+	$IP -6 address add 2001:10::1/64 dev veth1 nodad
+	$IP -6 address add 2001:10::2/64 dev veth2 nodad
+
+	# Make veth1 ready to receive RA messages.
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra=2
+
+	# Send a RA message with a route from veth2 to veth1.
+	$NS_EXEC ra6 -i veth2 -d 2001:10::1 -t $EXPIRE
+
+	# Wait for the RA message.
+	sleep 1
+
+	# systemd may mess up the test.  You syould make sure that
+	# systemd-networkd.service and systemd-networkd.socket are stopped.
+	check_rt_num_clean 1 $($IP -6 route list|grep expires|wc -l) || return
+
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (RA message)"
+
+	set +e
 
 	cleanup &> /dev/null
 }
-- 
2.34.1


