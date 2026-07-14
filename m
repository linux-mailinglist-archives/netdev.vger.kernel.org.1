Return-Path: <netdev+bounces-307473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +NmDB6k3VmqF1gAAu9opvQ
	(envelope-from <netdev+bounces-307473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:20:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E2755035
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:20:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FRDamuvg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C60323018882
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055A30BB8D;
	Tue, 14 Jul 2026 13:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCD310651
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:19:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035198; cv=none; b=mvBbHzH0UV5UOgWdphu7NHCuhNRGBlRFWwIlT8Fdf/5r/j6TCRi271TMHIWX6ziEsjlSt46BG57079j5lmN/wX3+KJgnTaMQF5eNH8KWIHpTFnKXOLhUKfwJBLP+8uJaEAOU0Q/ldcq7JNA8SvVBYPskPJHMcESo4+PUEXoDMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035198; c=relaxed/simple;
	bh=yFU6tVT/yFzLBuEg0rvre2hfLwrV7PyfOCpFeGeK4ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8BJOlFfYNEb7DKUP52I52doFZ6wQ8GCgwvKgGA3CNeiXFSDHcuXuO5+0N1P8TqpPKW9TUrdFh+HwWQ/8K01Ir0QP2av+lcBc7ewZHVWwbtyJOuP2uR4J9q2hgkrA3i/0Fhz4Sdra3D7JgDpC1u0HVMnH/NbE0QGUMitjeltRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRDamuvg; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2615760a91.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035195; x=1784639995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WNvlJknX3V6hG5xwMburTptRLxJL73QN/VwaqdH3Aoo=;
        b=FRDamuvgiXr0ybC/Qi97rKxMAbtkMA2gWhwQcfqpnP1cpc3QVoNMBLteRNG9JF+ioe
         6PeXvkmGzH5VZWYhKWf398R3o2yeXfa/lUSjnhEkv8o/0fWIOtvLvJEmBI2caK0g2JFl
         pI7D63PzKfCuYWpA9B+pFmZj+/ZT29Dlad22NTo/Xq152CFSULEk2SPS/YY1lnDF6EgW
         GGpTumRmZL+plJOe8dEbIAGhawVV0tQFHdZQxuDr4jWJMMfkvM/K5FbRfGq1g+XaOrti
         xeDR4MNxlQK1hcsXROixDXevOJ8zauxY/DwH43aLqfG/VjLRBqJGxx6cBdKQID8FhnFl
         F3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035195; x=1784639995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WNvlJknX3V6hG5xwMburTptRLxJL73QN/VwaqdH3Aoo=;
        b=Xlo7vcfgEjNsNq4FqIYDTLd/mFKd0jAoUZjErwcc3mNe0tNV+QUnO6mzqYUoUHTiE3
         Ze54FHS9oh92iGL0hu4DCA4b16IaKaEVWm7rU6aB3EKoEAYD7EneA63Sq2K9Wvb7vM5+
         X3CBiIj9OhMhksxtGmtbz2zoY2BZBH0NDh8D4mN2e1pc70MStv4ucYcv6Ri5FLAiWvMb
         6kSZrELaxo56Rgs15r6WWx+82cxzyrD4ZuqdvwE7Up+FLgrE9ll/9qUZPm85or8PTjUS
         Tsd9E2Jq87ff/IPfVOW7dSU8Q1mavvy0yu4DwEQ+m65Dvv1S5JimxH2LgCAi7fo+pwzi
         VWxw==
X-Gm-Message-State: AOJu0YyhWPidbLX1DWmPHOn/XLvgeH8IAYYBMShmztDyzNbqdQ7ZnFSC
	7l29maqerkJDdZAQ1gcELZS6jnksRr4ZR2iq+hRTnmRnCPAiFnNG+gu2l8giQawN
X-Gm-Gg: AfdE7cmU4YOg4UB2GvSKN5uuZWx81aKRxbiDnboKlOGWU8wmdcfZNc0SIDNtwA7s+BL
	cNUCvDz+AtJtONtVefqcu7ft0nWjY6/ceGxfkJ0OhEU7qWM4ahcQRwk8TnJmdAk/T9O/VNF74Sp
	AcWMq+YTXE25JKq9TasdbVfMZN/32mIeg+ndRtxibKRy5y9bQhW/fBT2Xjv9ecjd2dvdMBi1nJ4
	ALax7b0V6qZeCalmsavfOrSjn8dm3CBCqy7qUx6Bpk+4fD++bMTR4JbdOoFIbUIDCwM6mHTUlRr
	ROKRq/lHyi6cAtc7RYQRYQ5D2w0VnzWkEoYfJivTJ3JMasHCT0w+CmWs5U4/rSLTVu3JMLeeOM1
	4ciHywkspjwbAMfGcCw2jCysT6cUKHJTTz36SBwjIdyyEsq1VuPf6+GhUgfEwDsRukUXciy/40r
	7A1n6PvXd1toFrewNVZDn/7wIY
X-Received: by 2002:a17:90b:3e8d:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38dc782279bmr11459375a91.2.1784035195311;
        Tue, 14 Jul 2026 06:19:55 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf92bfsm116881975ad.28.2026.07.14.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:19:54 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Breno Leitao <leitao@debian.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Tue, 14 Jul 2026 22:19:39 +0900
Message-ID: <20260714131939.1255974-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,est.tech,debian.org,lists.sourceforge.net,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tung.quang.nguyen@est.tech,m:leitao@debian.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:4ncienth@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,est.tech:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB8E2755035

When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
returns non-zero), its error path frees the sk with sk_free() but leaves
sock->sk pointing at the freed object:

	if (tipc_sk_insert(tsk)) {
		sk_free(sk);
		pr_warn("Socket create failed; port number exhausted\n");
		return -EINVAL;
	}

This is harmless for plain socket(): the syscall layer clears sock->ops
before releasing, so tipc_release() is never called. It is not harmless
on the accept() path. tipc_accept() creates the pre-allocated child
socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
fput()s the new file, so __sock_release() -> tipc_release() runs
lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
sk_lock spinlock.

tipc_release() already guards this exact "failed accept() releases a
pre-allocated child" case with "if (sk == NULL) return 0;", but the
guard is bypassed because tipc_sk_create() left sock->sk non-NULL
(dangling) rather than NULL.

Clear sock->sk on the failed-insert path so the existing tipc_release()
NULL check fires and the use-after-free is avoided.

The tipc_sk_insert() failure is reached when the per-netns socket
rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
returns -E2BIG.

  BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
  Write of size 8 at addr ffff8880047cdc38 by task init/1
   lock_sock_nested (net/core/sock.c:3839)
   tipc_release (net/tipc/socket.c:638)
   __sock_release (net/socket.c:710)
   sock_close (net/socket.c:1501)
   __fput (fs/file_table.c:512)
  Allocated by task 1:
   sk_alloc (net/core/sock.c:2308)
   tipc_sk_create (net/tipc/socket.c:487)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)
  Freed by task 1:
   __sk_destruct (net/core/sock.c:2391)
   tipc_sk_create (net/tipc/socket.c:504)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)

Fixes: 00aff3590fc0 ("net: tipc: fix possible refcount leak in tipc_sk_create()")
Cc: stable@vger.kernel.org
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v3: correct the Fixes: tag to 00aff3590fc0 ("net: tipc: fix possible
    refcount leak in tipc_sk_create()") -- that commit added the sk_free()
    on the insert-failure path; before it the path leaked sk rather than
    freeing it, so the use-after-free only exists since then (v5.19+).
    Thanks Breno. Collect Reviewed-by from Tung and Breno. No code change.
v2: https://lore.kernel.org/netdev/20260713082342.3803379-1-4ncienth@gmail.com/
v1: https://lore.kernel.org/netdev/20260710014440.2055584-1-4ncienth@gmail.com/

 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..55e695748332 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
-- 
2.54.0


