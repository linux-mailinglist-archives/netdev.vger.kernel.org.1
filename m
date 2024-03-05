Return-Path: <netdev+bounces-77288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CF871261
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63E4B22083
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 01:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074517C69;
	Tue,  5 Mar 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxY5PNoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A317BCC
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602677; cv=none; b=n7MhhymjzoLTJUWzs+4ESPpvNxE/v7WhQIdvYZR5XCH3ZNPjxEr1PNcseIhRwPmCCjxerhD6ck/YCXFwe2OyJv1SPpMm4ib3MnhpmVn+0CcI42obA0H7J3izvWzFsuRM8fh5AZXJSbKpCqhlO8t5Pst42yCl9SaAZudOEntfDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602677; c=relaxed/simple;
	bh=tve/UA/aPdAGdI2SbXDC4GaEKgRQuBVdVWuPCMoEFwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BuuF1dDCcqIOfsBH/4VJNifxIf6egVAENRM3VQ/+gr2md5birAH3AOrg9cZh5z6hnU6mBGarIeljK905TYn2dzagCtjZR9kkVJygC9k8nRWhMTQSgf3HEtpT4uK1VU4AhC4AggeiGJr/+yRrZnfiDDkgqiA6cJ6k60ewsg4PQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxY5PNoY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60925d20af0so52555697b3.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 17:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709602674; x=1710207474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf4zej+2XDA5vPROwa8DjOMpdSRq61VJX7YuzTTCsKI=;
        b=JxY5PNoYO0kKj+sg+xjjBT61jYSp8ZRAyp1aS0c6qdphOeNRh3e43I1leDxlHS5UZr
         65avNJQtg//WYcb4k8QAYQVPesYuU/P5q1+5nLWrGNYiv2yitS6ANjdjMTqSlFMTDDuV
         WCFMSdhh+1CGRJz+wkmFznJFOnVTH+FB9R7SgNF5BwNdqtF0IatCdq83R41kkOE8RE0y
         ZUtZP0aX/KaVYRI8Ya63aUKPlbZocDysngWy5rKflKGcCVhc/kQ5tLSlW77qz+LdxlpO
         TfHDP55KcRi2UNUnV616wyQvdulECYH93F62NU2wz2XJ5Ktt9sVl1b7hMqH9KxVql9G2
         JkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709602674; x=1710207474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf4zej+2XDA5vPROwa8DjOMpdSRq61VJX7YuzTTCsKI=;
        b=UL58fuhVm/FRgHyNalLaTPY5cEOx6yvilufUumH7u6Zb2D2Z0DN+aHSxUnOOJze6sU
         kgzaJwfYfklRPEqUVUgeT9CuNs33+S3E0iBm0YwSfTAwbHrR7IM1dlX0LrSjdWup1bcw
         v2M2ZQPnVHl03vgX1YRXUeStayjoCoF1GbtTfEVORX3Vj9mCzJa1JsVDI2qRDl/Sccd0
         GTFxOYT5xko3wihxI8h7a4KBeEIJligIjN286QvZVMwsU9dIzZnWZZA7CuiLHU4+UhXV
         lphs7nnkAPdYrJ3I9hwol94NiseNmi9n77PCVwg+J3A1OJdfQa3mD6Ru6UKQiOUgD4XG
         mGvw==
X-Gm-Message-State: AOJu0YzZsyUeYnStV+stBFieK3D0PNBZJKS5lEEBVJms7lfkCNmjHS5l
	OINfInqfelVPo8jJ927a7e9NzPVnJeg2Ld8GPxLHE5SJp4Igkev1Qv90QNZZ
X-Google-Smtp-Source: AGHT+IH+KJLjsFccSQtbfI+NiJYSJkIjk0/uR8g6voRKa+bEoIbLOlD3hMsI+rrNddbwEKYf4x8GJw==
X-Received: by 2002:a05:6902:2513:b0:dc7:8c3a:4e42 with SMTP id dt19-20020a056902251300b00dc78c3a4e42mr9936894ybb.30.1709602674509;
        Mon, 04 Mar 2024 17:37:54 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2491:3867:404c:f267])
        by smtp.gmail.com with ESMTPSA id g1-20020a259341000000b00dc6a0898efasm2392702ybo.15.2024.03.04.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 17:37:54 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v2] selftests/net: fix waiting time for ipv6_gc test in fib_tests.sh.
Date: Mon,  4 Mar 2024 17:37:34 -0800
Message-Id: <20240305013734.872968-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_gc fails occasionally. According to the study, fib6_run_gc() using
jiffies_round() to round the GC interval could increase the waiting time up
to 750ms (3/4 seconds). The timer has a granularity of 512ms at the range
4s to 32s. That means a route with an expiration time E seconds can wait
for more than E * 2 + 1 seconds if the GC interval is also E seconds.

E * 2 + 2 seconds should be enough for waiting for removing routes.

Also remove a check immediately after replacing 5 routes since it is very
likely to remove some of routes before completing the last route with a
slow environment.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

---

I made the follow change to simulate the case that a route misses the first
GC, and the waiting time of the next GC is rounded up by round_jiffies())
adding 750ms extra waiting time.

    diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
    index 6540d877d369..88479daa6ff7 100644
    --- a/net/ipv6/ip6_fib.c
    +++ b/net/ipv6/ip6_fib.c
    @@ -1487,8 +1487,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
     			list_add(&rt->nh_list, &rt->nh->f6i_list);
     		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));

    -		if (rt->fib6_flags & RTF_EXPIRES)
    +		if (rt->fib6_flags & RTF_EXPIRES) {
    +			printk(KERN_CRIT "fib6_add expires\n");
     			fib6_add_gc_list(rt);
    +		}

     		fib6_start_gc(info->nl_net, rt);
     	}
    @@ -2296,6 +2298,7 @@ static void fib6_flush_trees(struct net *net)
     static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
     {
     	unsigned long now = jiffies;
    +	static int expire_cnt = 0;

     	/*
     	 *	check addrconf expiration here.
    @@ -2303,8 +2306,9 @@ static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
     	 */

     	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
    -		if (time_after(now, rt->expires)) {
    +		if (time_after(now, rt->expires) && expire_cnt++) {
     			pr_debug("expiring %p\n", rt);
    +			printk(KERN_CRIT "fib6_age expiring\n");
     			return -1;
     		}
     		gc_args->more++;
    @@ -2376,8 +2380,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)

     	if (gc_args.more)
     		mod_timer(&net->ipv6.ip6_fib_timer,
    -			  round_jiffies(now
    -					+ net->ipv6.sysctl.ip6_rt_gc_interval));
    +			  now + net->ipv6.sysctl.ip6_rt_gc_interval + HZ * 3 / 4);
     	else
     		del_timer(&net->ipv6.ip6_fib_timer);
     	spin_unlock_bh(&net->ipv6.fib6_gc_lock);

The following is the test case.

    fib6_gc_test()
    {
    	setup

    	echo
    	echo "Fib6 garbage collection test"
    	set -e

    	EXPIRE=5

    	# Check expiration of routes every $EXPIRE seconds (GC)
    	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=$EXPIRE

    	$IP link add dummy_10 type dummy
    	$IP link set dev dummy_10 up
    	$IP -6 address add 2001:10::1/64 dev dummy_10

    	$NS_EXEC sysctl -wq net.ipv6.route.flush=1

    	# Temporary routes
    	$IP -6 route add 2001:20::1 \
    		via 2001:10::2 dev dummy_10 expires $EXPIRE

    	sleep $(($EXPIRE * 4 + 1))
    	set +e

    	cleanup &> /dev/null
    }

According to what I found from the kernel messages, the route waited
11.258s before being removed. It is longer than $EXPIRE * 2 + 1 seconds
where EXPIRE=5.

    [    8.674004] fib6_add expires
    [   19.932557] fib6_age expiring

Waiting for EXPIRE * 2 + 2 seconds should be enough for non-debug build.
---
 tools/testing/selftests/net/fib_tests.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 3ec1050e47a2..52c5c8730879 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -805,7 +805,7 @@ fib6_gc_test()
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2 + 1))
+	sleep $(($EXPIRE * 2 + 2))
 	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection"
@@ -823,7 +823,8 @@ fib6_gc_test()
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2 + 1))
+	# Wait for GC
+	sleep $(($EXPIRE * 2 + 2))
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
 
@@ -840,10 +841,8 @@ fib6_gc_test()
 	    $IP -6 route replace 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	check_rt_num_clean 5 $($IP -6 route list |grep expires|wc -l) || return
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	sleep $(($EXPIRE * 2 + 2))
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
 
@@ -863,8 +862,7 @@ fib6_gc_test()
 	check_rt_num_clean 0 $($IP -6 route list |grep expires|wc -l) || return
 
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-
+	sleep $(($EXPIRE * 2 + 2))
 	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
 
@@ -901,9 +899,7 @@ fib6_gc_test()
 	check_rt_num_clean 1 $($IP -6 route list|grep expires|wc -l) || return
 
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-
-	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	sleep $(($EXPIRE * 2 + 2))
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (RA message)"
 
-- 
2.34.1


