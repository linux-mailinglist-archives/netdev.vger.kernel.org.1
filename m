Return-Path: <netdev+bounces-67875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C558F845297
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A989B240C3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBA15A499;
	Thu,  1 Feb 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy90SB+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729A15A4A0
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775637; cv=none; b=u1TH5iIw3GKYzDqAogjHy6Zc9+f9FHtNIhWxWrGMi4CD10e2PS8OtmJB+EcA5cDu4kjpgUJBSSo10BDTmhovTTeAAg8JSMarcggAZf4lZsM/JBAL18rJoi8Wz4rJl66shpIoGN8gl3Fj00prwsq95JGGbze0JJiQ//qAGHszkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775637; c=relaxed/simple;
	bh=eISr1nSYpLUgO7TGB1jTeA78zrVUXIYlnFhUksdAN78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gm+/UpcJKyZTViI1iDgtTzIb85Q/317Y8zWeN6N1bti79Mnm/wNRpiABWEfrzXV7QAtJcGbIZnBZvuDAponYYvu2IjABS9eMk/lg47l418cE2gqrxf42rSrCnruZq5NDOG3bJ4DTuDzp2tg4k4Wep8V1CJiTTBJwFn+GITvEcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy90SB+e; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60406da718aso7006487b3.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775634; x=1707380434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtwHtCS36bNnk1CUbV/iOwOunx5AKCLAnCCDe8pyxjA=;
        b=gy90SB+eImH3ok/FWqzZXtwAZCdEhgE/D1l229XgZXEcrtXHENSm8Wiz9Xy6v7agqU
         GAEOrmQvPwC/Tmv9giRjbz+aLaUh1HC1vyAe4Bro4jltf7hnrkCBEpKWfN38u336y0tT
         0Ajssggeqm3iUYnnrTkLeiklbDbQu+sSqy7JVJEiEH6+K1Egf7ZSbH+uxLPTSEz6O1gm
         kTgZEj9jGwvxn0ANSGc2fEklUC0puUWR348SJEBjQSI+PBE9BDSjt2h2rXP99Hzz+Q9n
         T0H3RQt4AYqmKcdwYUu4NfEJ1fpkayUMvfLQ75y4j2ITltaTUM8gT8yZPlHkLrRnmOrw
         2P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775634; x=1707380434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtwHtCS36bNnk1CUbV/iOwOunx5AKCLAnCCDe8pyxjA=;
        b=qe+3C8vmGXfvzzA4rA8mE2vZSTMjTgrMpiE+0jm97Ug/CY4XmGSizHh+iwq7Hj7AKM
         FchiUw7EK5sNAaXv2sRdZjU8ivTKOtwq9nHkrm8XQ3q8XIUD7BAY8LJCkaaXmuCJT7nZ
         Fxf8cFKqRuuzo/XAK5yko72/aEQgL9HKrMvJ3k1RjgcnXNkp7gnAhR/N31oOjB2qTJhn
         k0O0W1iy3T2m/ndrtF6OGgDLL+CSBNM66DxPVkrB5xVe5gYtAjhbgZUxH4Ss3YgOmbVZ
         1C0Tbo98NOTjgVEAbuFfqORwBeyXmL8/NGadF/8iaADrV93ks9nT8qQdv6WmGs08LK6v
         fU/A==
X-Gm-Message-State: AOJu0YyVA7MW1xtqXgfG7VzJzlFhw/UXAIU7vsJl5P9GXuDJG2VXtYWj
	LNrZJZryNjuIjutwyTk04zV4MV7OKko3eP9Y9xQo67iUOryrpCbbQbCd9Y5qoBM=
X-Google-Smtp-Source: AGHT+IFAuoF8mfrhzhQ/gACBtsOQR1n0C0e6JUhS9+Byck0VQQo+B5VojS7ZCzN+hFLOJ9nHdXG5eg==
X-Received: by 2002:a0d:ea52:0:b0:5e2:2bfc:c6dd with SMTP id t79-20020a0dea52000000b005e22bfcc6ddmr3933164ywe.23.1706775633967;
        Thu, 01 Feb 2024 00:20:33 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b616:d09e:9171:5ef4])
        by smtp.gmail.com with ESMTPSA id w186-20020a0dd4c3000000b006041ca620f4sm209090ywd.81.2024.02.01.00.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:20:33 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Thu,  1 Feb 2024 00:20:24 -0800
Message-Id: <20240201082024.1018011-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201082024.1018011-1-thinker.li@gmail.com>
References: <20240201082024.1018011-1-thinker.li@gmail.com>
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
 tools/testing/selftests/net/fib_tests.sh | 161 ++++++++++++++++++++---
 1 file changed, 146 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index b3ecccbbfcd2..38e786aad678 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -743,6 +743,16 @@ fib_notify_test()
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
 fib6_gc_test()
 {
 	setup
@@ -751,7 +761,7 @@ fib6_gc_test()
 	echo "Fib6 garbage collection test"
 	set -e
 
-	EXPIRE=3
+	EXPIRE=5
 
 	# Check expiration of routes every $EXPIRE seconds (GC)
 	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=$EXPIRE
@@ -763,44 +773,165 @@ fib6_gc_test()
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
+	sleep $(($EXPIRE * 2 + 1))
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
 	    ret=1
 	else
 	    ret=0
 	fi
 
+	log_test $ret 0 "ipv6 route garbage collection"
+
+	reset_dummy_10
+
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
+	sleep $(($EXPIRE * 2 + 1))
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
 	    ret=1
 	else
 	    ret=0
 	fi
 
-	set +e
+	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
 
-	log_test $ret 0 "ipv6 route garbage collection"
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
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 5 ]; then
+	    log_test 1 0 "expected 5 routes with expires, got $N_EXP"
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
+	    ret=1
+	else
+	    ret=0
+	fi
+
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
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 0 ]; then
+	    log_test 1 0 "expected 0 routes with expires, got $N_EXP"
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+
+	N_PERM=$($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
+	if [ $N_PERM -ne 5 ]; then
+	    echo "FAIL: expected 5 permanent routes, got $N_PERM"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
+
+	# ra6 is required for the next test. (ipv6toolkit)
+	if [ ! -x "$(command -v ra6)" ]; then
+	    echo "SKIP: ra6 not found."
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	# Delete dummy_10 and remove all routes
+	$IP link del dev dummy_10
+
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
+	N_EXP=$($IP -6 route list|grep expires|wc -l)
+	if [ $N_EXP -ne 1 ]; then
+	    # systemd may mess up the test.  Make sure that
+	    # systemd-networkd.service and systemd-networkd.socket are
+	    # stopped.
+	    log_test 1 0 "expected 1 routes with expires, got $N_EXP"
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 1))
+
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	log_test $ret 0 "ipv6 route garbage collection (RA message)"
+
+	set +e
 
 	cleanup &> /dev/null
 }
-- 
2.34.1


