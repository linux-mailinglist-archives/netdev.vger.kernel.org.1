Return-Path: <netdev+bounces-306475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9h0EM6q8UGpl4QIAu9opvQ
	(envelope-from <netdev+bounces-306475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A847391CC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=miN75Dqg;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306475-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306475-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99706304400E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94B3D7D8E;
	Fri, 10 Jul 2026 09:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4963D6CB7
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674248; cv=none; b=dy+fmZkWnjR5rPz7GN7RAqmdxkNPrL64k8lDu9syXuGehOtGlWfccIBsm5Ro9JeAHxLBloPRvsXlUqn1FVpeZljTGWvrsGhAxYp6ITfhRtWtRi9P5IOkWKrPN5SMBKg6iXtrpQyOBI/GGrqNzzbwZkEncVQITGGGWcRTWt1Y58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674248; c=relaxed/simple;
	bh=ZxoO5bLO86VerqL2LaDVODvD3178yyntzkiK74hLqCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwTW/3faxbrW7bTMUaXBOlVHXwEQWiF1QNHc4zGyroJOTgdSPvZcsqHbhBzw7Y7OwoT+Jd2c049AgX6H9RSqe8do6TMudxT5kyKCL5YsHY2Ce59bYliwHKjeHxk58uLsZ3r+YyN+A3rsl+ANPi6k4s2BItz+MyT1D2Oy4IHiOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=miN75Dqg; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 88834207FB;
	Fri, 10 Jul 2026 11:04:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjrBfmwQMwjg; Fri, 10 Jul 2026 11:04:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D0563205E5;
	Fri, 10 Jul 2026 11:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D0563205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674242;
	bh=0QD/6WCiCN717ue0mC3vVCMXl9Iaw2Gd/T5ziaTYVxg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=miN75DqgMoLIkKjPo5z0il2YjAv5qL/Nr5xGQ+8iWO/coqNGH60kh2EMYeOYZaKdY
	 1af8syo27NFXUV/g54U1naF6nZi8BAV/pGzasmK4v5IuMX+nhuKfs2FYzh3B47KgGt
	 m2KQtr62uaXBmEy8dUfVpPtVtRNIjAoqL36BGzgHJPiaYH3J8ekmYUI6FEwpPqN4Xz
	 QO+E8pA+v5jQ7lAI9S5r9JqxQ6kAAwXUxFmvIaA9ZsjFejRNo/MC5R688QZ1vHZPNp
	 nXJpXAypJ4aq5iR6EhD2c1bbbdZOZ80zK/WnEz54urh1wWPXjU6JEc5vo2HQH28ZUC
	 dkGTIb/hw3NrA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:02 +0200
Received: (nullmailer pid 343845 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/10] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
Date: Fri, 10 Jul 2026 11:03:17 +0200
Message-ID: <20260710090349.343389-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306475-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8A847391CC

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>

xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
rcu_dereference_protected(), stores NULL and dst_release()s the old dst.
That is only safe if no other thread modifies sk_dst_cache concurrently.

For a connected UDP socket that does not hold: the transmit fast path
(udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache locklessly
with an atomic xchg(). A per-socket policy change racing a send can make
both sides observe the same old dst and each dst_release() it, dropping
the socket's single reference twice and freeing the xfrm_dst bundle while
it is still referenced:

  BUG: KASAN: slab-use-after-free in dst_release
  Write of size 4 at addr ffff88801897b6c0 by task exploit/155
  Call Trace:
   ...
   dst_release (... ./include/linux/rcuref.h:109)
   xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:2256 net/xfrm/xfrm_state.c:3053)
   do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
   do_sock_setsockopt (net/socket.c:2368)
   __sys_setsockopt (net/socket.c:2393)
   __x64_sys_setsockopt (net/socket.c:2396)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Reachable by an unprivileged user via a user+network namespace.

Use the atomic sk_dst_reset() so the cache is cleared and released with a
single xchg(): whichever side wins releases the dst once, the other sees
NULL and does nothing. Behaviour is otherwise unchanged.

Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket policy.")
Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c58cd024e3c6..08ba6805ddb3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3010,7 +3010,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (sockptr_is_null(optval) && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		return 0;
 	}
 
@@ -3050,7 +3050,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		err = 0;
 	}
 
-- 
2.43.0


