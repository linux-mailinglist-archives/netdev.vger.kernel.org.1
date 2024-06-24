Return-Path: <netdev+bounces-106113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F31914DFD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0082D1C20CF3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2313E020;
	Mon, 24 Jun 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QM4UQ6AX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03B1311A1
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234547; cv=none; b=hFwRv6DdBXMfwxPoph4y5OB6mLk5etKob4dBtAO3RlOESQtptN7WYQPquZawH7ljtOuNyvsDblHMo3vAw/z+btUqTm2KhECWRGzDNfC6UFGicFLaDo++s4qUUhfN4zZ0dze2fiOJJu5MpmkffDehpwTDbd5fS/DikH6h3Tsvpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234547; c=relaxed/simple;
	bh=ROy4rBahQuH5xS/NgtUr6jAzTu27fBBfNGjSZa3LzcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qqq8nUyKjHfGkGGo2dfX1tL6MGYSbZB5Wq112BjE1/Q9OOhzjf2MRdaMzvjModENC0hFOG2hIuoFrKs02+QGXD/tjn5dZIqyGr+Y+3SHmGxEKSLGNBw0ztx3IcroL3bNiFJojelw9EuHBEFwfyrFBTP66Mmg//Pky6NnfyIWFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=QM4UQ6AX; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so540824266b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcwVCNb8foBMgIyCQSZ7Wl8+7ZspHNbrlVaSM6zBPxI=;
        b=QM4UQ6AX4iCMH/MjqD7HxXZogOle4E6JgDwRmxKXJTFrydrIb3dFsPnkgFjuiiiER+
         G1MP19omfhgqyhvFKQbzKrd8O2XQpOiBflk4TpMq/+4hW3BiyuiQr4eKxEOwyqsxclKO
         LivJLK4qSocruGtj2jhMWy2WsfctXAyxnpZR8HXObLOu0qWBtX8byTXxeKyX9QCRr8ac
         l5+NFbcrZC7g5elcaTVefqanezg1eUFcLDmwq83igjrU+OLFfwdOvfudCpMwvhElEysU
         9BCm+O/T2jKtngw/cWxUda4AVGkCciks22yNMfthzTln4sY5t1cqHaSJrZQZZVltTw5Y
         sI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcwVCNb8foBMgIyCQSZ7Wl8+7ZspHNbrlVaSM6zBPxI=;
        b=J5uOUsbMarU9GSQ4X3HpPXKPQaR8eO7IowbPrVVY02NvSRMKiH3vjpeKDOdUSBW1iX
         P2nb+OiApa2Uk7etHzSGQAHUgsHLInbOLdWGr7U0pqhf9/kVI7D/MUhM5vTHWYGFUUa8
         /8Z/WQhozHgr/db626pRoSSxfYTIV5qT8hx6dxvetzMZcG3o2OarL9yDSayczGynUk9b
         jiXthUgIPF9i3m9UpaeYYBa6qJ3Z5yGFzt1ixCvzpkmOXTrYPGymD87hqS+cMhzThecT
         yPx58AfvwEFJre7Y9ZHN8P+GQqp96uOtuyDVdb8SWFE9gmXeCDG92/h+JWcI3Bo9o6Qb
         3CgA==
X-Forwarded-Encrypted: i=1; AJvYcCW5BzOuypg1WccW29do1Oo9bGaPfR46aDbBNczr2SLciQbkxms887b8TVPbn/VJ7Y6ZLdRWBEoL/id9wcP5bNByu761Z1Lz
X-Gm-Message-State: AOJu0Yy2uIduMG7zIexkAeFNuF3cVpyI5m9syWked4Tf74VxXaIg9cjw
	55vRHbD1iuTiUJzistxDK2nmA/toC4CRlX0Vbibgmp7PBhSkn4HSdgK7sczRLClOLABQUzvtLYS
	Fh6KrKz8h/87S68SwNKuifBSZBuLDOf4U
X-Google-Smtp-Source: AGHT+IFpQwRzyR34qMJRZmkVTN7mdUYx2kE9+rJvMvL8VAQneQX3EF3OdDGnaXjQyvJ8hCCPeYZpRQ2b4BOs
X-Received: by 2002:a17:907:c70c:b0:a6f:4f2c:1939 with SMTP id a640c23a62f3a-a7245c84ecfmr296000466b.1.1719234542672;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a6fcf56031fsm12005066b.188.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 5AE0A60533;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRO-00406G-1t; Mon, 24 Jun 2024 15:09:02 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net 4/4] selftests: vrf_route_leaking: add local ping test
Date: Mon, 24 Jun 2024 15:07:56 +0200
Message-ID: <20240624130859.953608-5-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is to check that the source address selected by the kernel is
routable when a leaking route is used.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 .../selftests/net/vrf_route_leaking.sh        | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index 2da32f4c479b..6c59e0bbbde3 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -533,6 +533,38 @@ ipv6_ping_frag_asym()
 	ipv6_ping_frag asym
 }
 
+ipv4_ping_local()
+{
+	local ttype="$1"
+
+	[ "x$ttype" = "x" ] && ttype="$DEFAULT_TTYPE"
+
+	log_section "IPv4 ($ttype route): VRF ICMP local error route lookup ping"
+
+	setup_"$ttype"
+
+	check_connectivity || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ping -c1 -w1 ${H2_N2_IP}
+	log_test $? 0 "VRF ICMP local IPv4"
+}
+
+ipv6_ping_local()
+{
+	local ttype="$1"
+
+	[ "x$ttype" = "x" ] && ttype="$DEFAULT_TTYPE"
+
+	log_section "IPv6 ($ttype route): VRF ICMP local error route lookup ping"
+
+	setup_"$ttype"
+
+	check_connectivity6 || return
+
+	run_cmd ip netns exec $r1 ip vrf exec blue ${ping6} -c1 -w1 ${H2_N2_IP6}
+	log_test $? 0 "VRF ICMP local IPv6"
+}
+
 ################################################################################
 # usage
 
@@ -555,8 +587,8 @@ EOF
 # Some systems don't have a ping6 binary anymore
 command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
-TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_ttl_asym ipv4_traceroute_asym"
-TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_ttl_asym ipv6_traceroute_asym"
+TESTS_IPV4="ipv4_ping_ttl ipv4_traceroute ipv4_ping_frag ipv4_ping_local ipv4_ping_ttl_asym ipv4_traceroute_asym"
+TESTS_IPV6="ipv6_ping_ttl ipv6_traceroute ipv6_ping_local ipv6_ping_ttl_asym ipv6_traceroute_asym"
 
 ret=0
 nsuccess=0
@@ -594,12 +626,14 @@ do
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


