Return-Path: <netdev+bounces-67440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2480F8436EF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6005FB23537
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1F51C27;
	Wed, 31 Jan 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c936dJdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F44F8A8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683254; cv=none; b=B3l+B4kQGneffrACsXbpBGBvsR/KEqBCZFcq35fMQF1XGIrIRhpmx8ssGXUColBWquNb3kv2oDMV129XaqE3VLtqJEfn9jV2G7oDlxgcdj0RZ0z1mULXUbV0uSVHP85jiXdeqSNQts3hcclXAvzbq95MKG0sXFy8z2C91m97SuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683254; c=relaxed/simple;
	bh=Ip3ont9EKGXbKqI4w+atvsRqqkJ8oRnmkodbu6cwvjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=henMU0p0eDIjquuSbWwJ/Z3Sklk8pKTj0+/kDg16Un3blLw2bqvK13n6ng8Lxb0xSt2jYwSjR1V0I85LBwfCQ4+Ue33qEzQgqy3IAlutux8FV1BkYSt2Xa+w85MlFr3C/1vJyIUGNXl4C267/VUC4kIyiMtHytqw7lyvcK6xzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c936dJdS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so104338276.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 22:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683251; x=1707288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho0Ox6SO1ixDdJOhOQI40PynCxm/m/ILX7aiBBia5rQ=;
        b=c936dJdS+klt0g7Gfqk/Mppy7C2yc9+MUuG+HEpZgCtbA7AxXE7PCak1Qh6QKPXDT8
         5BhTZN/oSAGMAr2aasFtofZmiCYj1MRwZO1hpYSCEiqLZ8lmhYkCA4llMd0wgUrbB7/1
         kPjgShdOn+F5AMnkrncIzh8yntMXnHN5RzIQ6gQWbR1MgFEAjoNx5OVAd769Zt0KKSSF
         utLy5LNS7RmGDLbYDbOt9Mf2pvQqsPEk/eS+SYHgC5iXgLRAb5hJv8DfxI2nXJ8auQpp
         poWaFBh+N+on1cVG6DR8qDZTOfe/vSumfrxUiTOQLMu6YTdrse5qUh9IOQhqeoG5AGmp
         1g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683251; x=1707288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ho0Ox6SO1ixDdJOhOQI40PynCxm/m/ILX7aiBBia5rQ=;
        b=TmMzA+W5txANupwRD6AqSWDWc6wz60eQPZYN/3uGJ8TMRpRxLVv7rv5C1kRCqvZJcs
         RaHIBGiawqKudXGu+KXRzFCLdEzQco3xcZLdcq/RlizT9P8I64Lew2Ynf+zOdBn2gxNe
         hRNWUNKFaKNw7kCOxNiYqU3vJOiBvQ4SaYKm3qXF4wUgu/u75ScbHPK4l2J5yzfC5EXF
         icRyxCxzievtnfaTy4VAr5OAJCsGvmj3dnvK190/mcDTMExLBcX6RaYt89QgXX+gkwSa
         G4Jvkq4ioPFgO8pr74RGy/1g2rIwJ9KrafIUujpQnX4Hwl7HHPnngWBeHIgXaxaH2JGq
         yTmQ==
X-Gm-Message-State: AOJu0Yy10JDb+28V+tRG4Y5sA7QOd3IK7wXb8ay/TAMBKfYB9T8ZWaZa
	NS1lWIU61UcUEQERzxgKgQFuMyYiNXO0BSavsgIXhg+gKmSgH3pp/Gf2wEghLd4=
X-Google-Smtp-Source: AGHT+IH+3CxGJXsDfO7gX8PlgCIhLIlIelEX0vPevI89GfHGOFpXbJh9/dSAztyQdqKtWxlxRgNOug==
X-Received: by 2002:a25:2fc1:0:b0:dc6:54c5:2862 with SMTP id v184-20020a252fc1000000b00dc654c52862mr780064ybv.3.1706683251556;
        Tue, 30 Jan 2024 22:40:51 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7a8:850:239d:3ddc])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc228b22cd5sm3345683ybm.41.2024.01.30.22.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:40:51 -0800 (PST)
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
Subject: [PATCH net-next 5/5] selftests/net: Adding test cases of replacing routes and route advertisements.
Date: Tue, 30 Jan 2024 22:40:41 -0800
Message-Id: <20240131064041.3445212-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131064041.3445212-1-thinker.li@gmail.com>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
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
 tools/testing/selftests/net/fib_tests.sh | 159 +++++++++++++++++++++--
 1 file changed, 148 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index b3ecccbbfcd2..f69b55304ebb 100755
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
@@ -768,15 +778,19 @@ fib6_gc_test()
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
 	for i in $(seq 1 5000); do
 	    $IP -6 route add 2001:30::$i \
@@ -788,19 +802,142 @@ fib6_gc_test()
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
+	for i in $(seq 1 100); do
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	# Replace with temporary routes
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route replace 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 100 ]; then
+	    log_test 1 0 "expected 100 routes with expires, got $N_EXP"
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
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	# Replace with permanent routes
+	for i in $(seq 1 100); do
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
+	if [ $N_PERM -ne 100 ]; then
+	    echo "FAIL: expected 100 permanent routes, got $N_PERM"
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
+	# Without stopping these two services, systemd may mess up the test
+	# by intercepting the RA message and adding routes.
+	if [ -x "$(command -v systemctl)" ]; then
+	    systemctl stop systemd-networkd.socket
+	    systemctl stop systemd-networkd.service
+	fi
+	# Make veth1 ready to receive RA messages.
+	$NS_EXEC sysctl -w net.ipv6.conf.veth1.accept_ra=2 &> /dev/null
+	$NS_EXEC sysctl -w net.ipv6.conf.veth1.accept_ra_rt_info_max_plen=127 &> /dev/null
+
+	# Send a RA message with a route from veth2 to veth1.
+	$NS_EXEC ra6 -i veth2 -d 2001:10::1 -R "2003:10::/64#1#$EXPIRE" -t $EXPIRE
+
+	# Wait for the RA message.
+	sleep 1
+
+	# There are 2 routes with expires. One is a default route and the
+	# other is the route to 2003:10::/64.
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 2 ]; then
+	    log_test 1 0 "expected 2 routes with expires, got $N_EXP"
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


