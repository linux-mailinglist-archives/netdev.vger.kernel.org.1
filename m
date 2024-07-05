Return-Path: <netdev+bounces-109526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1118928AF8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4107D1F24EEB
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9816C6BF;
	Fri,  5 Jul 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Gj6qX3if"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754316B386
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191188; cv=none; b=Ma3FsbpBYDx1cTm3y6taLWf2ntXgXMlQLH4xgifxcqETLSYI93JAYmHXPlVjKImCwfzRAqDHOGIsB7TewaYwo4yI/P8ac7BxHgKLliHXfezwIUoRiC/WI7bvVDay3JIUEOUUocpZrTd9eJJ6cHzRkxeCVAxYk3t/58t2Xc/djF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191188; c=relaxed/simple;
	bh=uwqjNUwUGD8gteHdinLEg/tWmncxkHI4qSyhvQZI4Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7JcrP8yHySe92o6qCPhU0IxnOPLZt071nYjU7Nb13s7NubwzDbHTUpstosGH6kwUg8EOzZDWFsFX7gQcep366GF6KKAvAXazFDm4gt775WGMRqCPnqYbL4dx3Xvi/Zvat8KaFZHgb2gL3rrdiX4ANME9k95IifbcqIhHvlkv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Gj6qX3if; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so662826e87.0
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720191184; x=1720795984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh/xrVxdryJoBZutF3XDro6l1fJuyxirwlBpLQ1IEHM=;
        b=Gj6qX3ifai+/fCDtKC5JaVcdmhlH4Gd5nUCQtwzULzTxQZ3Z3RNmEqd9Dl/xtjnodG
         YRxpb8zIUV5+Jokfio2g3LRMucgGCRkrk+oc52Ec6Pu99jX37EPSYe1rJTpraf/Cn9Zm
         hRezbQvBJsvYK/sP2LH3yNOjkKItoAwqCrlXk1AMYK/8/GJK5cYb1uFnKTod1VX3M40k
         xOEzcL4HfgKi8H9OffrwaO+5xATgdeztbSxNWUBo+tbdIAsy8janW881u2JntoqLAv90
         9uoaXN68rQzeAUMTRWSCIILKz7h7c5LuoU+P5IhONfJoyF5j0Y+tme6Ql0G77/TzUaTp
         tjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191184; x=1720795984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh/xrVxdryJoBZutF3XDro6l1fJuyxirwlBpLQ1IEHM=;
        b=GtV64whRRDo5kwKJ1Jm4gJomy1RhkNQC/+GdCt2dyPXOVWxuQ6mM2W2w4din6SfFZI
         LPl6WigGIFIAAlGQlBWpvJ2Tcvo4sPXEwZGLDpk3HMlSoibr4KaZdqWg8bTudfwoBEqH
         KK01tKBp2Zx9JU6LrRaPg3XBTzRnjNHHsx/dKzLRqfluK0f49bZUjRuMY+xKRMog8VI6
         SPMa4qmYOExnl1TmIuG3wCRdCWljGmVfkkB1YiWI6ZLZjixlKrl1vZLKpXGdXjRpQQO0
         wpgs2Q7Ygw7v/CaiNIKri4GfIwsLAklNMOU4h2KDPPyuwunmNUM6cF5aj8e8o0sYaabB
         Im6w==
X-Forwarded-Encrypted: i=1; AJvYcCVAy2yDlCKMQfH/UguQXUK/xrrsQHXfV2ijovtR2gQiqJgdNIsxhh4cOnPtBdLOhPD82Hym936xmqMLufgtnP6vc3fE9Jbw
X-Gm-Message-State: AOJu0Ywk/rs5UvXQax1O3bWrJNeu4ELAfe/i0gR16Xe/NLzK0cHEmRYK
	8w/F23Idutv5saD2l/5nl8PP0/D1O3fI8y3xWEXF3rVQX48CpBVBib74J8dDmv38dFjhHzToD43
	VE/cpn+IjDg6z4poK72np1Vx1G5wdttSs
X-Google-Smtp-Source: AGHT+IFn92F+bdZ8VjiVzlanUSEzraIlCgnASI61XLBCGqvvZNuZYBqQduVmmNu8xNmEySqWEs+UlUQG0fWc
X-Received: by 2002:a2e:9689:0:b0:2ee:44f7:cc74 with SMTP id 38308e7fff4ca-2ee8ed66d3cmr33435161fa.6.1720191184492;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-2ee5160e2c4sm2963631fa.21.2024.07.05.07.53.04;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id DB1B26047E;
	Fri,  5 Jul 2024 16:53:03 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sPkJ5-007Cqp-Ip; Fri, 05 Jul 2024 16:53:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net v2 4/4] selftests: vrf_route_leaking: add local ping test
Date: Fri,  5 Jul 2024 16:52:15 +0200
Message-ID: <20240705145302.1717632-5-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check that the source address selected by the kernel is
routable when a leaking route is used.
The symmetric topology is enough for this test.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 .../selftests/net/vrf_route_leaking.sh        | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 2da32f4c479b..1fd8ceb0711c 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -533,6 +533,30 @@ ipv6_ping_frag_asym()
 	ipv6_ping_frag asym
 }
 
+ipv4_ping_local()
+{
+	log_section "IPv4 (sym route): VRF ICMP local error route lookup ping"
+
+	setup_sym
+
+	check_connectivity || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ping -c1 -w1 ${H2_N2_IP}
+	log_test $? 0 "VRF ICMP local IPv4"
+}
+
+ipv6_ping_local()
+{
+	log_section "IPv6 (sym route): VRF ICMP local error route lookup ping"
+
+	setup_sym
+
+	check_connectivity6 || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ${ping6} -c1 -w1 ${H2_N2_IP6}
+	log_test $? 0 "VRF ICMP local IPv6"
+}
+
 ################################################################################
 # usage
 
@@ -555,8 +579,8 @@ EOF
 # Some systems don't have a ping6 binary anymore
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
-TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_ttl_asym ipv4_traceroute_asym"
-TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_ttl_asym ipv6_traceroute_asym"
+TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_local ipv4_ping_ttl_asym ipv4_traceroute_asym"
+TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_local ipv6_ping_ttl_asym ipv6_traceroute_asym"
 
 ret=0
 nsuccess=0
@@ -594,12 +618,14 @@ do
 	ipv4_traceroute|traceroute)      ipv4_traceroute;;&
 	ipv4_traceroute_asym|traceroute) ipv4_traceroute_asym;;&
 	ipv4_ping_frag|ping)             ipv4_ping_frag;;&
+	ipv4_ping_local|ping)            ipv4_ping_local;;&
 
 	ipv6_ping_ttl|ping)              ipv6_ping_ttl;;&
 	ipv6_ping_ttl_asym|ping)         ipv6_ping_ttl_asym;;&
 	ipv6_traceroute|traceroute)      ipv6_traceroute;;&
 	ipv6_traceroute_asym|traceroute) ipv6_traceroute_asym;;&
 	ipv6_ping_frag|ping)             ipv6_ping_frag;;&
+	ipv6_ping_local|ping)            ipv6_ping_local;;&
 
 	# setup namespaces and config, but do not run any tests
 	setup_sym|setup)                 setup_sym; exit 0;;
-- 
2.43.1


