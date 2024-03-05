Return-Path: <netdev+bounces-77629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B68726BD
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1D61C21B74
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB218E06;
	Tue,  5 Mar 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpiLTBFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B417BCF
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663996; cv=none; b=gDvtO+F6e5tpTcMyVz9020rwAJueT1+To5we1CvvjqtEvZkZiz2TDKol+wFi3pugfO3zaOyEdbtVwFLVGeOqJ87+2ZlcDbdC63G2tcdaxWGxwhmpsOLas1tOE4HrPgTvWvApPzV/aEZvVI0YYIGRTUh1WDhh6xUWE6EtydtXT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663996; c=relaxed/simple;
	bh=oNPwJ7B49cOOT8gfaAwF00TOG1yqQ3/GTGWbmOL7WPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rN18MtaCTBlPwJTormlR4kPez2ScMbyzNRS4JcKUhg+4XpABTKubNwmNuvyuEWJpNL1evLTOcww08Ix8qLj/1aoyQz+gnL3MZWv/RGYpg2pv0uYnb4ywVfDrAESHEi7WqPd36bqNVWxRbmfP25LJ8udGGsjZRKTAp3sB2ll/d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpiLTBFu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608cf2e08f9so66060757b3.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709663993; x=1710268793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FB1Ht7rZ77KaXk6HfWO8Wn8mwvhEbiM7yLHzUTTku5w=;
        b=UpiLTBFuInkk9ZcrE3SK4tN8R4syiZCbfKtL9V/XH0sLJL0CzbdESjIJ5W+02cRuHp
         x3f3cq8B9nBTYCoXAJ3iWhoejinBV1GTGfQtNwm3cdxsaf6KzmwSnSfwRlKhGCpBZe0E
         /BO1vxueRDtuOwOBMrxI92Y6EIHNvxiR5Dq8nh49BWYJ7y1ihP0mJ7GnPes43oalXBWs
         3ltAogJdxUsQghPuGbg0hoLw6XZz55W4MYsG2lqdaCCZF5k0TnZyAA8fDEPZ6lUhZbhM
         F/s/oeLz9jxh+Ffko7oW0buB/a2tOFh8wuEBdoQKqb204pxU+tsa8PPy69kpSa4+Tkme
         f+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663993; x=1710268793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB1Ht7rZ77KaXk6HfWO8Wn8mwvhEbiM7yLHzUTTku5w=;
        b=f0BtC7lN8XUC0TdalqtIdmbaKnV+h9xTj5Fh06ffgichWo0QOhbBerlOcmxfmpiIj4
         wClBBOUBJ7ybkrhe33T+pNBpshgzwlj4bWMw35GW7dXo6c74dmggKBKPBtE1CUzuGYeM
         yVR4W02s45S+H2PwRX055c8B2kevuRybX6308Tuwqy+dpxgJUaYRV3ngE3UdXk0vUo4F
         /hBPsB/ttQz4edu1Y1rN2/lRZ2CybeeGv0hnz+0nKFQ+lORIbpI+mZxfYiJnQllvhM5X
         KqvqiJly6nvCXTsy/RXlgpCEPRcV07T/9o3+HykKAIPlk/x6scl2KVhP2vsqmyskY1/B
         rTXQ==
X-Gm-Message-State: AOJu0Yxdh9c6CbIjkTgoVWcyQ+NZz/uof4SXzsassqvE9raikpjiuvO1
	AcFQtWVQFiFyH0Wg3cjG9K5zb8nrbtJyiJgbcMqevVjBtFGwLuk6/T8K01Xa
X-Google-Smtp-Source: AGHT+IHTqO3zCJHjSuurtQ+ffJ9AW8unnU7+4vjJkOMRygjqKK8kIPlLINhyFd0VeWemHOqNawjm1w==
X-Received: by 2002:a0d:ea06:0:b0:607:d9fb:5144 with SMTP id t6-20020a0dea06000000b00607d9fb5144mr12404839ywe.13.1709663992895;
        Tue, 05 Mar 2024 10:39:52 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ab40:ede:556:f2a7])
        by smtp.gmail.com with ESMTPSA id ft10-20020a05690c360a00b00608b3bacb09sm3235214ywb.46.2024.03.05.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:39:52 -0800 (PST)
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
Subject: [PATCH net-next v3] selftests/net: fix waiting time for ipv6_gc test in fib_tests.sh.
Date: Tue,  5 Mar 2024 10:39:49 -0800
Message-Id: <20240305183949.258473-1-thinker.li@gmail.com>
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

Changes from v2:

 - GC_WAIT_TIME to replace $(($EXPIRE * 2 + 2))

v2: https://lore.kernel.org/all/20240305013734.872968-1-thinker.li@gmail.com/
---
 tools/testing/selftests/net/fib_tests.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 3ec1050e47a2..73895711cdf4 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -789,6 +789,7 @@ fib6_gc_test()
 	set -e
 
 	EXPIRE=5
+	GC_WAIT_TIME=$((EXPIRE * 2 + 2))
 
 	# Check expiration of routes every $EXPIRE seconds (GC)
 	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=$EXPIRE
@@ -805,7 +806,7 @@ fib6_gc_test()
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2 + 1))
+	sleep $GC_WAIT_TIME
 	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection"
@@ -823,7 +824,8 @@ fib6_gc_test()
 	    $IP -6 route add 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	sleep $(($EXPIRE * 2 + 1))
+	# Wait for GC
+	sleep $GC_WAIT_TIME
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
 
@@ -840,10 +842,8 @@ fib6_gc_test()
 	    $IP -6 route replace 2001:20::$i \
 		via 2001:10::2 dev dummy_10 expires $EXPIRE
 	done
-	check_rt_num_clean 5 $($IP -6 route list |grep expires|wc -l) || return
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	sleep $GC_WAIT_TIME
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
 
@@ -863,8 +863,7 @@ fib6_gc_test()
 	check_rt_num_clean 0 $($IP -6 route list |grep expires|wc -l) || return
 
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-
+	sleep $GC_WAIT_TIME
 	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
 
@@ -901,9 +900,7 @@ fib6_gc_test()
 	check_rt_num_clean 1 $($IP -6 route list|grep expires|wc -l) || return
 
 	# Wait for GC
-	sleep $(($EXPIRE * 2 + 1))
-
-	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	sleep $GC_WAIT_TIME
 	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (RA message)"
 
-- 
2.34.1


