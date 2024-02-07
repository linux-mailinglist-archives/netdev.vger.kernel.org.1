Return-Path: <netdev+bounces-69967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90D84D240
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64512288037
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7C86148;
	Wed,  7 Feb 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8x5/tX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC186144
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334190; cv=none; b=cWjSesnP7//A1fLEZj+zlemx236FJs7uK0hfe2+13cGKfzW09y1MaYvTSmxAYV7EDW0CVgtE5l5NYJIztBgyWFKVeXxeDm5Qk6dtKy6alk4VrOp9ZMlRyZfUbMzSCOBFDbeXBM9wRlJLycUfCwRYBzO8ux0OAYW+N/zfz7g8DyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334190; c=relaxed/simple;
	bh=Oo69ndk8HkyqvgtuNjqa8Z0aqTz0qVbZJ0jdM562xPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tojK4OAQbU8w2kuEraCPG7katbl5WzJoSJTnxZLp4LXsbm0mNeiWWTpF++5rL6Efr2qRPlgObUQnw09T6Y+xykg+FF1ZrPa3tdptEQYTQZAaIuqf/3TPyH3FYmzkNmBLeEs4xRZSw2ZssnKkjy3t/JjucQ6n1pe8/wMvGbuDdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8x5/tX7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6049ffb9cedso4286027b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334188; x=1707938988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSDzR+nEa82TMDtmmBQXA+zB3wxN5j0beDo3dnb/TA=;
        b=E8x5/tX7Yy9KpF9Nyw9ckPhM1L83FR4s9lGOP+O1ssTL9jmWfRTfxzWaTJwqRzaGi+
         4KH5feOhFyVuCyD7Aos5A0O0bsDhbE8vDlxLFY9i9CqxuTUeqoBxKSFsDZASz5UgkoMv
         CXp2imbJYFcHPxCiZXNclfQAhHau2BzYMZYV2ThkAspUWgdYMOOUW1Bf9eKct+bGLASE
         eW11zwA2eYg4pdfLoqMI0hQaWAtf2f99oJ4AFwRc+jzjDcWJV7saagFB2dwvl/dTj12O
         VCIjQwtRefjJKGDZkfpVCoYiRfx9Il7T3SUs8xcgIBk8SZ1fcslSVNjC8nSnPBxYA6Pe
         7bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334188; x=1707938988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUSDzR+nEa82TMDtmmBQXA+zB3wxN5j0beDo3dnb/TA=;
        b=g7/TbCO3Ez5w+HkKhmwOgXXURpnciu8qHbk2CVBy3oSloepApcGJciU6QtX5RBAbXl
         gmAM9SE/iWdca7FpkTzDtjmvfweEIMLUBa2HCvX6dAS0AeBQyxUERJkDT6KgrzTPYYxW
         AjPCwzxiPnMEyniubiz2o7quNAh5sTDUTYvTs0F932+BZl6X3rf3x8ADx87rfZlrhYqL
         Qvke0sc8e/AB07jiel6XwyMPkIBzCgvEDXuDKXSu2wRBoT+d3cskB6FF9sU0uZbF5bAw
         TGj6WwiFlDfd9ntWXU8vPw0Urj8qJ7L/YxEGBxUFpbcabyC9yrTXBjkAhEJVxZb6ZGYj
         oQQA==
X-Gm-Message-State: AOJu0YyTzcLX1y51+9cPRuqMrJ3aW6Ra/8MXf/vtZD+9XjUbPBG9QMRz
	qyn262O9RsEMJelH5fBSqmT/YJHtt/SDVYqHYweeaQkYte0q6Cmyvw2XeTfR
X-Google-Smtp-Source: AGHT+IFE/JFpJ2qNWxR5qzXbuaWHH6SqJ1N5Ech5H+Pf8rZw5DPHCqsxGT4Vz9HaPG7HZiDNtZlNEw==
X-Received: by 2002:a0d:e28d:0:b0:5ff:d3f3:6f4d with SMTP id l135-20020a0de28d000000b005ffd3f36f4dmr5826577ywe.42.1707334187678;
        Wed, 07 Feb 2024 11:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeWE4rtP64W/7NBE9+f4s+XeRKmiEfjOfbOi5MfB9L6LELm7qoufHjFhsDUzrxLuNkrN2F79cq4a9YMn/cDsFgjVxkUKXjqyhQ1jk5TmQ0HldVpe56sVlPBbZp/JnTOnSIB9IecPW9BgfrD1VBjTAEILOrl2scl5H/Rf2ut2kVlAFxlOdHv7KI2yDnm3qHjPF8KWRwjqviGvt81DtI+/E3cLqgBBWuqo3MO4e3Gapuc6YoXBbO8HKH9/aNuarKL3S8edyl1tBKK+2fj2NcMtuN0mX8bXbck4dRw/3o4GtYC62NekjwFz75ca34gnQ+FjIUJA6zz2YwHP3p2ufGP/yW+40LADZQ+tarWA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id cn33-20020a05690c0d2100b006040cbbe952sm380088ywb.89.2024.02.07.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:29:47 -0800 (PST)
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
Subject: [PATCH net-next v5 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Wed,  7 Feb 2024 11:29:33 -0800
Message-Id: <20240207192933.441744-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207192933.441744-1-thinker.li@gmail.com>
References: <20240207192933.441744-1-thinker.li@gmail.com>
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


