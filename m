Return-Path: <netdev+bounces-69267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512784A8C0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8BFB20ACB
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007E5A0F9;
	Mon,  5 Feb 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyU4C3Wq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB559B7F
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169248; cv=none; b=Flja4c4bCFTd2AghW7YA77Q6QcrqtT72DAIKfyo/IvKMvayegpkTgUWbmAQWjYbmv8jBZrl9tE5vPEEyaGfWv92jEU4XMpjW4ktMhW5V5HADTYr6M2AncYxUDD+QvjGLTNxgY3vCTdX4Dyl7v1jHWjMVWqS2S/3oR7KX+uoweVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169248; c=relaxed/simple;
	bh=28VAMkMgt1fDUM57a10aCWM/chIBrpsz0JcYGF0u1Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6MDjBZwYipX6JX5DtZK1Os+0nE6Fss8Tp/aEhTyOjT2tFI6mdpO8kfEoq6OMF8GOsF+j9Rz8csD9CTmpfmglgqGWc9QO9z0ng1wlzpP3wvAQSu4OvKO7xJR3HKttg5Jxl9IzXQj0PbTjBHDFGBHGV4bV94rj2NTZQjCLsnoEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyU4C3Wq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6af9a988eso4144857276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169245; x=1707774045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JxYGlYSVEP4MNYrTgK6GK+yeDj8pqTGFUi/P8FkNBk=;
        b=GyU4C3Wq3Tt7NiqlBnA6ZSWG8bYTGkgZQzPPY5In8GmriwKdhA3Gd86rNlVpWhXBNs
         N7aWWiqdbxmO20zgJHjoCOQ1mq1c3BGIr0jlr6ZJnv9h3YTrTTlBFgNEWI2zJjOboAOw
         je9yyzrtRshmShc8dOnez/t/tK2n0rH6tRGhJ6x1SK/5pWiSZVtNq89CsH+FfSoW42HS
         1sNz1tQV/J2ZW8HvcFWqzH76Atv9dxZ8h+pa96yctg3J7R27Dr5QyFrntyjyUDpLgFUF
         xp1FlxXrvpKjQkw2jz2QMTKjzE/vz4ZDFr1t9t5vPO1CEWPApYQeTf/9Ol8SdkHcs1F6
         IQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169245; x=1707774045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JxYGlYSVEP4MNYrTgK6GK+yeDj8pqTGFUi/P8FkNBk=;
        b=eXHqFGHHWymlWSQIoiSuI6cC/86LqVyjLJ5BzLP9DpSj4fdCoFFnZgUhe0dEr5BRJh
         1cifzlv9mCoCS1rSilN1t7H9vTJdPRmSGC09btsXN75MoXHBptyopz/ZIdK2kTnHZ1y+
         lYvrAhIOq2S8AGXUcf+WR7XOQr/6yswylEHiNH5eJ1yBEhGB1KxXDck601Roy/qq290z
         GhataKav/9+Q+qoBFJNhAIIAJecF94gSPJEHfXA5RIk+k3QhzgmDs2mzsO8FWTpb6HDA
         f+tRPsng+el7uCkJ8lpGf0iRycXymWKmHKYXm/1jIJvww5J9ZJlyB0PQF5ByXzWn1Zlc
         siyw==
X-Gm-Message-State: AOJu0Yz3UUPPrbTr2tOoTwAWXlpxn2qwe0bkpbeAXQwfk6HW+E3mEA8d
	dkQCfCrAKlD5XgJxeL57gvK1mw47V2HLfmAXiiuxUFrv4UhhjCcZXCc4D6I9
X-Google-Smtp-Source: AGHT+IFqOYijhFKpdsM/4/RbWTH2yNqjut8r3GrFWpB149WPEnorRSky/I8/gZF/WrttoLYwJAmgfg==
X-Received: by 2002:a05:6902:2407:b0:dc2:5573:42df with SMTP id dr7-20020a056902240700b00dc2557342dfmr296542ybb.25.1707169245646;
        Mon, 05 Feb 2024 13:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQGyHNhpOErg7U3F93MN/ylZfhZwJgD/a36UkHZ3o+HJzJ6/Cm5B0a92+8uLVdPCUyTdZIm3efKdRw2k+yAIjPZz81jnIdrhBxgj+OJBtZWA9xbf/IuT2jiuy9A1KfVHIMJOql7MpaykODgqYclAu1CgnrpFjFAi4Z7KMiH3Ckibwl2e1fs1Z9tq02lXczYFt+G5Ln34hb7K3FvIUlQEwxi2dAeMXtLUjMe5LrDL0y46mUWyx0tX618ynHfK40ijXRNSB+ten/poRVcVkfJrO7GM1wDvJFfLLRBKv+viSnnWTA7QdzS1dv2+6JHoA19YlrDE528kHPodIJDHC6WLZGyWElWiwpK2UjQA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id d7-20020a258247000000b00dbf23ca7d82sm160936ybn.63.2024.02.05.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:40:45 -0800 (PST)
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
Subject: [PATCH net-next v4 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Mon,  5 Feb 2024 13:40:33 -0800
Message-Id: <20240205214033.937814-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205214033.937814-1-thinker.li@gmail.com>
References: <20240205214033.937814-1-thinker.li@gmail.com>
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
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 148 +++++++++++++++++++----
 1 file changed, 126 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index b3ecccbbfcd2..b983462e2819 100755
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
@@ -763,44 +800,111 @@ fib6_gc_test()
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
+	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (RA message)"
+
+	set +e
 
 	cleanup &> /dev/null
 }
-- 
2.34.1


