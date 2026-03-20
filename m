Return-Path: <netdev+bounces-269814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM29HHz2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A12D6951
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC382302F723
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF1935C1BF;
	Fri, 20 Mar 2026 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSBdsQsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203835B63B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991407; cv=none; b=PGgP7BGCPvIZX5qx+5twEx0Pi+lMk8IiRqEkMj9aKtZVDEt6KAtA/cJeEWgKlXp0T4mBT9xoXo/vYM+iwWXuQBVBlYH+LkkyXKoDtZWk3pytLIPPzPc8z9w/J8rl8fnkCvS15j6b6bhgj0pPLS1K0uDdecONy2wnimYLhFZxa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991407; c=relaxed/simple;
	bh=n8W2sCDJGtWVL7hPPm5dAEJStdgPbrhMQccr3Zrl9gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhjEulTCRHAqNkP/QBdCRIJ7yExPM6S/5C7G01wlRAvyGnE8dkukED7l4raC5ZnS6UCgjF6qJEABm39MvwFzD4V3E/B9pSSR31oK+szAk85yMYAcdOyS600rPi1hfaGGB7pEUcZe89Qb2rL6Auc7fWw2XSGmgqv8l9sShcYBDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSBdsQsN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso4448578a91.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773991405; x=1774596205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8KKfQsI1QT/KA90y/YGP4xbssJ8+P0cuImpCWBs1IY=;
        b=kSBdsQsNJMJCa6QRMZEJX6FxA/y5Ts/MAv7aDbzV4yWtRQqHamnL+Pj9atNPExt4ag
         +xlm00LFUnnmdeoqwpk5chajDkI3zF3A/0Gmpt+58YGFk9a3/TB59MG7kR51c9hv439f
         7o159qVk/w+zUIp9Dja22Hjn8GyHl6OK/KAAI/IXt7vFZWOJ4RjTL1KcmHcP6djH46pc
         z80wcFcPuV9CAYQ0k1p3vuE1Z869ardOu+itpl2Q2laGu167rbjn4y9RwHhAIGzsJytk
         IUan0kiaM013D1J6HRsOrBe2m50k77MW+O7HrmCLeIftP2/II1lQriyiNVw4xwJ2FL98
         vM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991405; x=1774596205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8KKfQsI1QT/KA90y/YGP4xbssJ8+P0cuImpCWBs1IY=;
        b=K+rNKbjJYVZjTSGgLPo4rcrylcAvI4Qsw0/vJEPJmKrKld+w+lFHkpzET4dFWigUmY
         LUnx9v+wP8m8q4ciw2Q2g1DlvgQYPBXoIf7YxmO8TKYrHYrcnN+ib2GHhCP2l2c7ini9
         zuQLL7wOgFzsg/1opGwLdfEAY99GZyjtPyeNvFWx2jStodfH20kaTvKfoWBCMn2bjSK6
         3QjgAzQ63n7aSOEZ5OtUuQ6gRCoJylt1NSDkgmwpmtpXONPWvJ0UMXAjfxbihWFaWzeu
         FPpyTkQyVbAvxgnyKH+gK6dmCDiz7zM3b7pT/XHjLCEF98BwwRRuX9QzGArVqO4YlMsH
         fJNg==
X-Forwarded-Encrypted: i=1; AJvYcCVoZqVGpkOCc4LWLbiE9W+20XKrl4mqj62JlddQWsUHyl/8jHYCow8qmC12tic4HabTObDMBYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLna7tIQtAktyLFQrFDVhqnYA2HwEDx8kqirjwFSM+9rzvD9R
	j+PKqGKQPGttIhUtXmYVM4nYZeZMKWQ4IGLlV+ytQt0giPLV6mqzPxuUp+In4ixKaV/7y05sqXa
	wuLvYtg==
X-Received: from pga26.prod.google.com ([2002:a05:6a02:4f9a:b0:c6e:28c3:dd5c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa7:b0:398:bbd6:80b9
 with SMTP id adf61e73a8af0-39bcea5a1f4mr1841394637.23.1773991405110; Fri, 20
 Mar 2026 00:23:25 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:23:01 +0000
In-Reply-To: <20260320072317.2561779-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320072317.2561779-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320072317.2561779-4-kuniyu@google.com>
Subject: [PATCH v6 net 3/3] selftest: net: Add GC test for temporary routes
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.767];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 120A12D6951
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
2.53.0.959.g497ff81fa9-goog


