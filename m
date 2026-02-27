Return-Path: <netdev+bounces-261720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACYDNqUWoWkUqQQAu9opvQ
	(envelope-from <netdev+bounces-261720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0C1B2726
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14D973080C38
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C733D6F6;
	Fri, 27 Feb 2026 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ras7j6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752F33D6F8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164771; cv=none; b=qSn4H9bDYeWCN1iqVMx+U18JHwylQ4lkNepHs7X5XODvStPQTFKhk5Gw+4khfcJ3NwcYEyy7BW5YfTHG0Uq/AB7KMA0wt7GKkKuduYrOEBVxXyqzhqhQMUVjoU+PXN/WvrdojkeKlk7bb0LBBiMi2T8R66/4crVSldkZUZOHINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164771; c=relaxed/simple;
	bh=AOlUQIQwRM3TfQVWpY8IO+Oimy0yKwkaz63Brgmpmk0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T+MCvW3JEvoz+JohbpeRjvIUJ5fKYd7pub1dqP+F2YEnz8Gpvi1YtvAzseJgCYw6VKbLtwse8V41y7Y4uI7+ImA5D5+Yhiaa/WmEYe99cnq4EjRX9Ap/CzDzPKffFz+Fv8sfPWHf4FTavPtmx9+/kEzEi15CVlsPl6vcMYhTpME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ras7j6w; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e18b8fe1eso1637885a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772164769; x=1772769569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jMr9OVkiEqDw4Lp9EzktAf71Dg6nani4781m7h3dn/8=;
        b=3ras7j6w9778Xxr8zEGUwr5qnSBaYvEzvqev2lNHSyErm2CwF04Vwqalka4+MO+n9F
         cwVaMAleLMGnEmeO7x479zKtFMHfgS/5750V4aguXzILZADTJHcPY/tOiIwXQ1Yb22dx
         XmpT44R2w5Swa3bdYAEzUfKkJjLnNof9EBOCzYt6kau0tjtrcwzyPgBLxT29ij6cdvO2
         sN1qKfDO5WFns6pSx+qHNFxFnDr4D1qUD87qSRVCPihvLzL/vaV3+5Cp/DESkb3UYtio
         zXV24hlhK4NvU097jDccAk6IaQWFPTK9vEb5PyI/6bplGD2VSVFj/aUzNQIwhF5Dx2MJ
         oS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164769; x=1772769569;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMr9OVkiEqDw4Lp9EzktAf71Dg6nani4781m7h3dn/8=;
        b=BaVkIbtsypFSKgtRatsjfc6LJooGVZocFNXU4ljr5PIba5E2SUbURLM0eA7Cra7lIn
         bFUp9SgGSxZNw2IZ0tNwD1XEcIF6lNTYTpGbYsCH8cB9w+JEqczxZMjKTjQzFbh3wWkU
         FuCMin/7+6+asvoicHVRyB9sFKy+C7Peqp2ax006fVR7D/TbfAA+O/gE1nfyKvY62dgV
         +sPoGthuoj1T+WCe0Ly95SRdapngRhLX/mZa/TYsIfCBQyk30KWNssXflsUj9NCYkZBu
         XBtHfhDh64VrykxMNtxOjFjaQRnhA0CTV+s8LFIrHzV2wvqsxD2seloSlJI9BOfOaugs
         I8gg==
X-Forwarded-Encrypted: i=1; AJvYcCXJu1sWQqbRjoMDEi9QZue8PMgNTl730Ah3CHm4ZoQPbUdZ3+vVeRPmS61WIY/pn9tzdt3MAvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1NnV463VSreUqRCCJWBSYjoKh6KHNUHUCYBvqzDzZ4apQbiZ
	8wlbjuxTa8qXJq3uG3D7bAShtX6LnpMGbHfd4RnKhW9FfdDSDFqv17JFdR+7UvuYUnAhbxMifTz
	bxSujpw==
X-Received: from pgbfp5.prod.google.com ([2002:a05:6a02:2ce5:b0:c0e:c1b4:51a5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d8e:b0:35e:5055:1ec
 with SMTP id adf61e73a8af0-395c472a18dmr1455185637.17.1772164769058; Thu, 26
 Feb 2026 19:59:29 -0800 (PST)
Date: Fri, 27 Feb 2026 03:55:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227035547.3321327-1-kuniyu@google.com>
Subject: [PATCH v2 net] udp: Unhash auto-bound connected sk from 4-tuple hash
 table when disconnected.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Philo Lu <lulie@linux.alibaba.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261720-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C0C1B2726
X-Rspamd-Action: no action

Let's say we bind() an UDP socket to the wildcard address with a
non-zero port, connect() it to an address, and disconnect it from
the address.

bind() sets SOCK_BINDPORT_LOCK on sk->sk_userlocks (but not
SOCK_BINDADDR_LOCK), and connect() calls udp_lib_hash4() to put
the socket into the 4-tuple hash table.

Then, __udp_disconnect() calls sk->sk_prot->rehash(sk).

It computes a new hash based on the wildcard address and moves
the socket to a new slot in the 4-tuple hash table, leaving a
garbage in the chain that no packet hits.

Let's remove such a socket from 4-tuple hash table when disconnected.

Note that udp_sk(sk)->udp_portaddr_hash needs to be udpated after
udp_hash4_dec(hslot2) in udp_unhash4().

Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Moved udp_portaddr_hash update later
v1: https://lore.kernel.org/netdev/20260225002709.156882-1-kuniyu@google.com/
---
 net/ipv4/udp.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 014fdfdd331b..b60fad393e18 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2287,7 +2287,6 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 				     udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		nhslot2 = udp_hashslot2(udptable, newhash);
-		udp_sk(sk)->udp_portaddr_hash = newhash;
 
 		if (hslot2 != nhslot2 ||
 		    rcu_access_pointer(sk->sk_reuseport_cb)) {
@@ -2321,19 +2320,25 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 		if (udp_hashed4(sk)) {
 			spin_lock_bh(&hslot->lock);
 
-			udp_rehash4(udptable, sk, newhash4);
-			if (hslot2 != nhslot2) {
-				spin_lock(&hslot2->lock);
-				udp_hash4_dec(hslot2);
-				spin_unlock(&hslot2->lock);
-
-				spin_lock(&nhslot2->lock);
-				udp_hash4_inc(nhslot2);
-				spin_unlock(&nhslot2->lock);
+			if (inet_rcv_saddr_any(sk)) {
+				udp_unhash4(udptable, sk);
+			} else {
+				udp_rehash4(udptable, sk, newhash4);
+				if (hslot2 != nhslot2) {
+					spin_lock(&hslot2->lock);
+					udp_hash4_dec(hslot2);
+					spin_unlock(&hslot2->lock);
+
+					spin_lock(&nhslot2->lock);
+					udp_hash4_inc(nhslot2);
+					spin_unlock(&nhslot2->lock);
+				}
 			}
 
 			spin_unlock_bh(&hslot->lock);
 		}
+
+		udp_sk(sk)->udp_portaddr_hash = newhash;
 	}
 }
 EXPORT_IPV6_MOD(udp_lib_rehash);
-- 
2.53.0.473.g4a7958ca14-goog


