Return-Path: <netdev+bounces-269299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJtvO4N4u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CA2C5D96
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52CD31682C1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D8318ED6;
	Thu, 19 Mar 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dly62wKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FB318EC4
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893677; cv=none; b=Oa6+ARZ+xsoAe8yxh+aUt5DP+hZifwjcuZCoNUp4akGiH3ctuYWujYE2kl+ACF2L6WzTE2KlQVehnbpjX5419nZh+gWYwbYOFOcXqdm25MMqvYn3mkB8Q4oC5rf/qjqjpr6emipxHvz333UtIfi3BWCyZgulXOfvOFsciGO3ojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893677; c=relaxed/simple;
	bh=wc2q3ZmV4aPxNsC7cOu0viGxAITG3NN8zq5svW7VZSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eInFxMzO2LbGS+s1NLKF/U7U/4Qo4Km0ZsSPix85s9YqXCRed8SFmfcHgkHrvc/sO/wdeH8KaZgcKzTMgclxTb8XDdBr/gDpFt4DfJur+ntaBdbyMU1SdF5ONWhTyovF6gHPUhCHyuTqMfYH+In2wZTseU3vxuNxFDMegSzWnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dly62wKt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso881750a91.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893676; x=1774498476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYhJ6UGpRdaDZumbBbBjAvvSw0wg9LU8WOw2D2RDn5Q=;
        b=Dly62wKtg5+6XH9K0wF4tJlEIDOMf/QhyTRUjFptmWRpw/KlWOM5sTN3A/zKWgVOp5
         TfmdLoEwbqYb1OWeNkqSC2lijibPtO230hxN76+nEPsDFsitRdcVt1N08ZGPMZV89QWQ
         2ef+gecfTr3kb+FRgQVbiq7k2KNZNJ1Xwm/9h0jae0wj36mLplx6yBwzQ5kENDohM9oS
         8eRvBm8/YRTjjgurDLsbfrYeGdcPqzCyH6IISR/ObaB1bdgg+UorxUuzFepPnMSygrIt
         5KtIKABaY6QcCblhMVwJAZ+PK/hnQauso53AJ3kZCFgcMo6zAUKLxQCssGcxNXkazUBj
         ybtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893676; x=1774498476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYhJ6UGpRdaDZumbBbBjAvvSw0wg9LU8WOw2D2RDn5Q=;
        b=DD4lBlHEgnwRxpRZnwT0RIItSgV6wA4gbY2Epb1FQpvTuN48rkely7xboFXO9AJytC
         Sg00zyHpcCTDAAL611cm9Bxgd1nBtztiCLBz5hpErbV0FRwqKrxvLJhr8pOX7eb9AZgd
         c/tWHu62roMOmoihN8WGoM34PSJRAjgHgpmmISZUjoNxaH0cOAIWdWqPlPEeIeb5WP5n
         L1PAJyqXDQ4V00sTHT7aVL+AXGQWIk8KAtc+amfUGvhGpxJq3TfLKl205LSoJZRvZ3ks
         V3XHjU22blMs7VPjLUqw8GyCooD0kkx2wq4yo6s62eb3L9bXiTjPY6PvRoNqwLyftEG0
         mI6w==
X-Forwarded-Encrypted: i=1; AJvYcCXewtEbKO6XenukW/T+3+gSZu87jkaTi7evEOZNlUMrEIHVmw5Q/zp7IlTWv6hSod1+suHcpfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBpiV1rbAAxhD2pUOHWYhgnZpBn+ZSRC9v2YJl0m7qghEYHsa
	iiXognUvvzGPmDnEXbzavmp3TMpAf6mxiwETPoQJt8nzCQhOtXaDtDG26AMc1U0UnDFv5mhP3/S
	Q9ZnB1Q==
X-Received: from pgia20.prod.google.com ([2002:a63:e414:0:b0:c73:7981:7915])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d85:b0:35b:a656:a60e
 with SMTP id 98e67ed59e1d1-35bb9eb48d9mr4823789a91.10.1773893675507; Wed, 18
 Mar 2026 21:14:35 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:13:52 +0000
In-Reply-To: <20260319041427.1528743-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319041427.1528743-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260319041427.1528743-4-kuniyu@google.com>
Subject: [PATCH v5 net 3/3] selftest: net: Add GC test for temporary routes
 with exceptions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269299-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.204];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 787CA2C5D96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Without the prior commit, IPv6 GC cannot track exceptions tied
to permanent routes if they were originally added as temporary
routes.

Let's add a test case for the issue.

  1. Add temporary routes
  2. Create exceptions for the temporary routes
  3. Promote the routes to permanent routes
  4. Check if GC can find and purge the exceptions

A few notes:

  + At step 4, unlike other test cases, we cannot wait for
    $GC_WAIT_TIME.  While the exceptions are always iterable via
    netlink (since it traverses the entire fib tree instead of
    tb6_gc_hlist), rt6_nh_dump_exceptions() skips expired entries.

    If we waited for the expiration time, we would be unable to
    distinguish whether the exceptions were truly purged by GC or
    just hidden due to being expired.

  + For the same reason, at step 2, we use ICMPv6 redirect message
    instead of Packet Too Big message.  This is because MTU exceptions
    always have RTF_EXPIRES, and rt6_age_examine_exception() does not
    respect the period specified by net.ipv6.route.flush=1.

  + We add a neighbour entry for the redirect target with NTF_ROUTER.
    Without this, the exceptions would be removed at step 3 when the
    fib6_may_remove_gc_list() is called.

Without the fix, the exceptions remain even after GC is triggered
by sysctl -wq net.ipv6.route.flush=1.

  FAIL: Expected 0 routes, got 5
      TEST: ipv6 route garbage collection (promote to permanent routes)   [FAIL]

With the fix, GC purges the exceptions properly.

      TEST: ipv6 route garbage collection (promote to permanent routes)   [ OK ]

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/fib_tests.sh | 61 ++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c5694cc4ddd2..829f72c8ee07 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -868,6 +868,64 @@ fib6_gc_test()
 	check_rt_num 5 $($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
 	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
 
+	# Delete dummy_10 and remove all routes
+	$IP link del dev dummy_10
+
+	# rd6 is required for the next test. (ipv6toolkit)
+	if [ ! -x "$(command -v rd6)" ]; then
+	    echo "SKIP: rd6 not found."
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	setup_ns ns2
+	$IP link add veth1 type veth peer veth2 netns $ns2
+	$IP link set veth1 up
+	ip -netns $ns2 link set veth2 up
+	$IP addr add fe80:dead::1/64 dev veth1
+	ip -netns $ns2 addr add fe80:dead::2/64 dev veth2
+
+	# Add NTF_ROUTER neighbour to prevent rt6_age_examine_exception()
+	# from removing not-yet-expired exceptions.
+	ip -netns $ns2 link set veth2 address 00:11:22:33:44:55
+	$IP neigh add fe80:dead::3 lladdr 00:11:22:33:44:55 dev veth1 router
+
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_redirects=1
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.forwarding=0
+
+	# Temporary routes
+	for i in $(seq 1 5); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:10::$i \
+		via fe80:dead::2 dev veth1 expires $EXPIRE
+
+	    ip netns exec $ns2 rd6 -i veth2 \
+		-s fe80:dead::2 -d fe80:dead::1 \
+		-r 2001:10::$i -t fe80:dead::3 -p ICMP6
+	done
+
+	check_rt_num 5 $($IP -6 route list | grep expires | grep 2001:10:: | wc -l)
+
+	# Promote to permanent routes by "prepend" (w/o NLM_F_EXCL and NLM_F_REPLACE)
+	for i in $(seq 1 5); do
+	    # -EEXIST, but the temporary route becomes the permanent route.
+	    $IP -6 route append 2001:10::$i \
+		via fe80:dead::2 dev veth1 2>/dev/null || true
+	done
+
+	check_rt_num 5 $($IP -6 route list | grep -v expires | grep 2001:10:: | wc -l)
+	check_rt_num 5 $($IP -6 route list cache | grep 2001:10:: | wc -l)
+
+	# Trigger GC instead of waiting $GC_WAIT_TIME.
+	# rt6_nh_dump_exceptions() just skips expired exceptions.
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+	check_rt_num 0 $($IP -6 route list cache | grep 2001:10:: | wc -l)
+	log_test $ret 0 "ipv6 route garbage collection (promote to permanent routes)"
+
+	$IP neigh del fe80:dead::3 lladdr 00:11:22:33:44:55 dev veth1 router
+	$IP link del veth1
+
 	# ra6 is required for the next test. (ipv6toolkit)
 	if [ ! -x "$(command -v ra6)" ]; then
 	    echo "SKIP: ra6 not found."
@@ -876,9 +934,6 @@ fib6_gc_test()
 	    return
 	fi
 
-	# Delete dummy_10 and remove all routes
-	$IP link del dev dummy_10
-
 	# Create a pair of veth devices to send a RA message from one
 	# device to another.
 	$IP link add veth1 type veth peer name veth2
-- 
2.53.0.851.ga537e3e6e9-goog


