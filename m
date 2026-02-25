Return-Path: <netdev+bounces-260688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UuiKAPFBnmlsUQQAu9opvQ
	(envelope-from <netdev+bounces-260688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072818E611
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BED43029257
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F113D51E;
	Wed, 25 Feb 2026 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFYuCuk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1F2248B9
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979241; cv=none; b=fHmw39DC7u7uA+ohr9jxZshaqi7EUJPLMnXB16FdyiXbhr80hTCwhVuG/3n1vPZkflDTDdKW397b99aMkBc5ECU6O7EWO3tsXSy77a6JZluOmJu2y9zV4d18yrMhqCKQDEy/hQVMuTTAOCt1JuhHcE76f3okE61aMVJ/YIE4Hls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979241; c=relaxed/simple;
	bh=yUjgGCXypjVaqKsPFMnQOEvR8jza87vhKcQRAaEN68o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BFFEr/9blq9mUV7MShJOU11ICq3FBGQxxZErxIC+aj7H8HlHDjn+pg7DwpFqWfvK2siTPev9wqYaBrhrL9CekVoNzj1ErcJ2m+NXFktRR/TY9GBIZxWLsWV+oQzbclaA6fp9evwgE5TxVA8bZ11ZGCoOopXtZtbM5axal1wv+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFYuCuk+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a943e214daso375310285ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771979237; x=1772584037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rMppqfYtaPEAuHbTGzBYHmmoOP/37UfjTQ36I4vyww=;
        b=VFYuCuk+WvfJ128K2RxYzMTfU31pSSi5VQRDZC0CY5bQAXQi2Dy6/trVuKS5yIDqo9
         x6B93ClYVDu9X5ED5pDzgeAlpM7YWBcwEg06wBPseJBE0Xn7DVgsymYI7HzI118NS6DJ
         /E+IDIMe0NiRu+cu/tIha9+6dg9QPf3zcseCcwMD3E9tCRCjRSMjHAxLL5pCct0n56/f
         KLCKaC6bPMkpt7oI7iS+SojB+uOjwitUDh3Op95mexD2is8NYrikdozdQzcs6sPCkiIj
         jlkcwg27JQYJ/NY6PxpEsRWywNivrhtsZ5pQxTvht7QcIxarf7Dvxwg/MfTSnvwNb0R9
         tJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771979237; x=1772584037;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rMppqfYtaPEAuHbTGzBYHmmoOP/37UfjTQ36I4vyww=;
        b=mqpw/YG0wO0TlO7P54h2rOujSBT3b7hnxZYNgvW2ixU+xdRQBe5xHRq5jQCPO0Q8TF
         CFww/OdkyJVVf/6pTR8EEIyfZo8rd5A9421cDfbSneleGiAt2lVMAIrLUfBWDNCMFNUr
         QTF4Qw3RQKyZ8Ligk6o5OgAjk5Eehnh/AMqLA6bNkVngWCQg6twL4i3iXVjD8M2Idd9P
         hTqFsCIkpwieuIpCkLRtYVDoqX1cyvxFMm7YY0d12F5PTI2ojcA4VFeCnIgijDveQtZ0
         HpxUGD+tZjJXuvA90IZetH7xBnsEorPEeqGtsOQVII1JXxYSoKreZlQjlDaLmjT49b1h
         822g==
X-Forwarded-Encrypted: i=1; AJvYcCWzyZ4V52wh7fR/4x1dXhbKERH1HHd1yInrA7Y8QkxCh32U8fElZ6yKHizVp90Dtve1JvMVAlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1iShfvybVpNhTo80Yxx+L0cVspmanfeYJgq+oPoNaK8rOaGW
	YQkz7AOsOItH7j0/dIxKQLvwH8OOKD2C4UC/xtybM/75NgNS4NTdt+8MO04XLw8Lo6l5rinV5B1
	4tyTAeA==
X-Received: from pldq4.prod.google.com ([2002:a17:902:c9c4:b0:2aa:ed18:fbb1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c4c:b0:2a1:3cd9:a734
 with SMTP id d9443c01a7336-2ad7452bbcfmr139332215ad.43.1771979236737; Tue, 24
 Feb 2026 16:27:16 -0800 (PST)
Date: Wed, 25 Feb 2026 00:26:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225002709.156882-1-kuniyu@google.com>
Subject: [PATCH v1 net] udp: Unhash auto-bound connected sk from 4-tuple hash
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260688-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5072818E611
X-Rspamd-Action: no action

Let's say we bind() an UDP socket to the wildcard address with a
non-zero port, connect() it to an address, and disconnect it from
the address.

bind() sets SOCK_BINDPORT_LOCK on sk->sk_userlocks (but not
SOCK_BINDADDR_LOCK), and connect() calls udp_lib_hash4() to put
the socket into the 4-tuple hash table.

Then, __udp_disconnect() clears the source address and calls
sk->sk_prot->rehash(sk).

It computes a new hash based on the wildcard address and moves
the socket to a new slot in the 4-tuple hash table, leaving a
garbage in the chain that no packet hits.

Let's remove such a socket from 4-tuple hash table when disconnected.

Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/udp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..3388e4ab9056 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2321,15 +2321,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
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
-- 
2.53.0.414.gf7e9f6c205-goog


