Return-Path: <netdev+bounces-68340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB61846AA6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B17288432
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C818AF6;
	Fri,  2 Feb 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJiB/8/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1E18C28
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862144; cv=none; b=jG93Pwnuu1QeVfgpTjp/UJnpo4BGMiGZ5LwyJtE/LT0NDVudb2TeeSn97dp7CSUvmk3peSQHS5KgLDLjVh6/KZIdW3BiHZGSBjTMgV4Q3aLaYaUJackcq551CpX5kz4widDv5lfCEbnmYZQLSHjGEBYWqVEHIX1iHbb18frUhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862144; c=relaxed/simple;
	bh=hy9/837D+U/NR3by+SuuECFfeZE+jvlKmxEG6tSiODc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQypvr8wEMv9zfRdebW2dB2pnsY9LocjvDqfGyeh3t25/eBbn8OA2M94N8r7zfeZUbhB8LtVUg/sveKVnJqHMtjFW2QzU/w65Unz48fahoUJhDUvJ+mPw2ivEtGfYpOrQ3PEeH7nF+Dkv8QJ9zbYBrnVri3GM0NjaHHwsWG3FvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJiB/8/C; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60410da20a2so18387947b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706862141; x=1707466941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2wswQuZVEFnxNi/Z83JJqKEZkSlXTqxdCZ2walan4Y=;
        b=YJiB/8/Cw3O73qNwL8Md1tiJOQrEWQ6RCuAVCBFlqOnq0ZG3JXaQGJte2WOc7kiQJn
         msXO3FdxDw+Whr58wNZTzNw/wNImYBwmgUMTf7raooqKqcGBVU2X7dkFKiVEgPZNBUwP
         3gO4yOjKIw2RrA7oz0ILq1bCOeOMsglGQmzNfFJfa/o9HbVbbOa7eh+hlFGiJ35867Qi
         8I4zA0n7x29KWMulfJ0BAzVkz7/eAIxPKEng42RljV6WNqjCBsI9plbBRTw5dDllR33x
         jCyOwQMJkkT/Koayra8KnE61Xmkif3F1wSxQkpyp/j6hxhNLGoee71H+b2tIjvGTSTyO
         7DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862141; x=1707466941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2wswQuZVEFnxNi/Z83JJqKEZkSlXTqxdCZ2walan4Y=;
        b=FRdNijfneSD4VOdi7lEfPsjaMu55i80z3aL4iiIsrCJa2N5SxLjq0+cdypxnuPhow/
         rb93HE/kACdqtchaRh+yYBvi2rMtlWBp8ajzn/k5FfzFBn3wqyQiNjxMmnkwBxYbrkLZ
         Jj8dSUGtwATz3/I5lBjD/YFz+34OiG+ytYXP+HH7p4ZRVrYFdJZSkaIWktgV3eKcxA/I
         VmDdBbUAumDHV2nsaJcQoCTNQ5RRPh55X6zZn+75VtfwR5AYXfWdNZmzg61aI+gknxX+
         IXgnAjE3y3rUwONXqPDFIMaqCMSLm6Ve+9p5Nx3aE0TlN1d/8ZQvUzbSkKmm7rD+wuP5
         SxRA==
X-Gm-Message-State: AOJu0Yxjqn8lcn4INL1YUSh677FFhHOYBlGtac/mS5cWSLfhzJTiMVMZ
	OnlXmPmiaAIqsrXuFyDH0mNX86O3q98o5a/23bZQOad0gX/v5nzZK/BgNV2anqA=
X-Google-Smtp-Source: AGHT+IGp7SxnscYllJaGgNYF1EEODcnC1C7MktIcMxahB3SxkOs4aZZjJpiyxtO5vF3V+3lO8PfapQ==
X-Received: by 2002:a81:ac20:0:b0:5ff:7a74:412e with SMTP id k32-20020a81ac20000000b005ff7a74412emr8035091ywh.38.1706862141349;
        Fri, 02 Feb 2024 00:22:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcmj8VYLqHnI4VhRTNYTqK/XQJMlYrFEJ/cmAMcJrfL/3B7kCnkEQ0tN6zG760WtmeWQrxIMCde3O+ivTFwvNlmQlb2u0QzMCSB9WtPNBRgIKQJUXUYp6TAXTwML4SRJ53DH2LCZVJ7Jrnbs9w4/mpX8gLzhY8VHZr3druk/AV0zZDeQwg3xXxuG+OSQggXZCdIppRjQGsq2Pv100GQ0CLVhKB+OCmir4n7R5PothvaT0Dr6ohda8iPvBAeshJ16+SchSftefHCBEbdDFHNWHeLnsi25DOHgH6rT5tMvo6H8/yI8IADsnv81nIFaGgrKbHqooY8BAylzCagfbElhNS5CnrqiofC5Ty/w==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1486:7aa6:39a6:4840])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b0060022aff36dsm299679ywg.107.2024.02.02.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:22:21 -0800 (PST)
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
Subject: [PATCH net-next v3 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Fri,  2 Feb 2024 00:22:00 -0800
Message-Id: <20240202082200.227031-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202082200.227031-1-thinker.li@gmail.com>
References: <20240202082200.227031-1-thinker.li@gmail.com>
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


