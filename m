Return-Path: <netdev+bounces-288755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAMgLlflCWo6twQAu9opvQ
	(envelope-from <netdev+bounces-288755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A960756230C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A97983004048
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6663B995F;
	Sun, 17 May 2026 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzVrkJT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978819DF6A
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779033421; cv=none; b=fBUstz1ax/jFXfutS//L49TJLFGgtyxdoQ/USW1VyF+JhxGRhwBucXlfRATmDmCz+cE/JA/r9YT6lvFlqGBaGVGRGMnVEETCKcqK+jwRXtIQS5MmG1aG0EyF+pAfLYiRL7i3Ff57ZdZy1xaPwpbIE+5LElcG6QitMof8+PgghZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779033421; c=relaxed/simple;
	bh=15mWIMAHjv4cgViWKIAWOSSow/WUs8mL4EFX0Z3XoNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRJ5p75lQAJgNr1C/OKLP5bj6eA+e6e8Ps6vReniC4JROl7OSLRvQ5sROZLZvt2nuYErZPABmdZ+LwtP0sArLecBSs59lO6Jh0oqHbwcTSzoctK62qQgWF1lgHkX3X7x1XCi5SbjAoSRdbEhklicoLkjmthmvYMixN/iQ61UsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzVrkJT5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90caad2e944so172546085a.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779033417; x=1779638217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CSBACOO5uZiUL3Bifh+26rI7UtfDamwviXzCgkFmj0=;
        b=MzVrkJT5tSQMBAfNL/W7XlswDCVgW/qfWWjCrMkH+Ek5WTGt+KyrNdydI+LzcCoA85
         j/A9BF+E1RRNtFZY6NcyizFcGjfBA/9dDSU4JPwRfVuFp+aodvCiTCWG0n76vrs2sYOk
         POk6culATJyL6Cb32io0GxKbXYqtjoYdK0ewMppmcrAwZuxTGoMP7bPwPq+ilChyLrQ5
         71CeLsf5nihx9SKIjDIybWz4ujIzoH4eExbbvXO5QhkXjKll1qHfMr7xDQJ9oiC4bEIm
         UuyQnGDKB7R8v6CKHEs+cEz+RkCY/pAz50jl3TLXuSZ/Kl8FJT2H8PSS3vMUv0njlMH0
         Fhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779033417; x=1779638217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CSBACOO5uZiUL3Bifh+26rI7UtfDamwviXzCgkFmj0=;
        b=BLMBPVX6Bnsno4hXLZ9BAvbjZvVi/bgN1a0Wf19BiIycuC1B1effplkE0L9HDIlii6
         XlOXAy2tVQDUKIFs5kLuznIF95NvYuj4c441YW44rXkkm1vNmWaZNrP+nHhdP0+m2Hlc
         T0k/LLN89OlBSaUgp0/+OrilFd7IKbqUca/Uy4C3ZQEMtytotl5Ek76F6h8PTFtFfuMz
         5ytzO26pwfT5s7EwptDmpuim61mjVeHr7+1MVWp7jkLBw7Wy8soTsvIPiaUUCVMK4gZy
         cZ2p8CGsX0sDE05FedhHzIZLSTK4HP+VgSILcvPUGOh/elD1xAOjpJQoRLiL6mpMo72k
         cSpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tsMf3+gnu+pEDajwzmTGZ8YlsaYw3v8woXxjYak59IGve1cbydPBGn2UhfXiqS4wdIHGWmvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbpEjacD8wel58M1WTDXjSOAcUuLdnOnfVBTH9302c8271oWd
	0b+Tw4AN2bExEBNZb14T4WBJqU6z7vliP0FFsL9VUBsT8oi6TD1MD5EcU+LzslHe
X-Gm-Gg: Acq92OG95f/NmSdq5tbZpDKpUeIG9bESfDYwW/JSEkbwrTwO+RuZJRzCkTU25msXn/X
	wN1MN3IusW73yvSPdmHMOvaJC6j0GAajU/6WX9ZR8etzaPPWkKxVVf7fZ77eGHPAn0IjQP38h83
	SGqoaLKffqiOiSNlYImjbO/W0WCvIU/v5f3IhitnFit1OTsQNyfIkrFp88OdBO8joPPl8VQsnsC
	RmzFbyyDgFW/Cb2YJ9JhD37ZXOv6sgHxo6PhzscBlFwUX7Pm+7RrMeuhwaSls4/J0aMGdLzi/SD
	cAB1G+2WdO45WXnhaoTMESKXQwJXxWl8rBPqzPAaQljB1dX4+pirFEBR/YYxiuq7p88MtVT2DRx
	7d8WZEEgRuIl9qxjKcCppO+szKc0ofGCHPD9RZRPc5MrYf2LJOZspQi+veJLJUSET5/zF8hr66K
	mTRW/fNcxpmnfMPe4r15huxlEXxAdyB9l3eoS1uJ1TjW4UZcyOEgGVxJWKZhlkuGK44zum16q33
	fweOG+5gBmfs+KnspAKSZQA7sz/HZQbMCslIrLR70I=
X-Received: by 2002:a05:620a:179f:b0:90f:786c:895a with SMTP id af79cd13be357-911ce71c487mr1796840285a.32.1779033416927;
        Sun, 17 May 2026 08:56:56 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm1202618085a.5.2026.05.17.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:56:56 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ovpn: refuse TCP socket layering with an active ULP
Date: Sun, 17 May 2026 11:56:45 -0400
Message-ID: <20260517155645.3882533-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A960756230C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288755-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ovpn's TCP transport replaces sk_prot, sk_data_ready, sk_write_space
and sk_socket->ops by direct field writes when a peer is attached, and
restores them by direct field writes when the peer is detached. That
layering scheme is not compatible with a TCP ULP (e.g. kTLS) being
installed on the same socket: ULP setup also captures the current
sk_prot as its lower layer and replaces sk_prot with its own. The two
schemes are not aware of each other and can be combined in either
order on the same fd.

In the order "ovpn attach, then setsockopt(TCP_ULP=tls), then
OVPN_CMD_PEER_DEL, then close", ovpn_tcp_socket_detach() restores the
saved pre-ovpn sk_prot directly. That overwrites the ULP-installed
sk_prot with the base TCP proto, so the ULP's close hook
(tls_sk_proto_close() in the kTLS case) is never invoked when
userspace closes the fd. The ULP's TX delayed work is never cancelled
and still carries the raw struct sock *, the per-ULP context is never
freed, and TlsCurrTxSw / TlsCurrRxSw are not decremented. After the
TCP socket is freed by the normal RCU path, the still-scheduled TX
delayed work fires and dereferences the freed sock:

  BUG: KASAN: slab-use-after-free in tx_work_handler+0x3a/0x146
  Workqueue: events tx_work_handler
  Read of size 8 at addr ... by task kworker/...
  Allocated by task ...:
    sk_alloc
    inet_create
    __sock_create
  Freed by task 0:
    __sk_destruct
    rcu_core

The same trigger run as a loop also produces an unbounded leak of the
per-iteration ULP context: TlsCurrTxSw and TlsCurrRxSw grow
monotonically and SUnreclaim grows in proportion, because
tls_sk_proto_close() is the only path that frees them and it is
skipped.

Fix this in three related places, all in ovpn, since ovpn is the
layer that bypasses the in-tree ULP close contract by restoring
sk_prot directly:

  - ovpn_tcp_socket_attach(): if the socket already carries a TCP ULP
    (inet_csk_has_ulp() true), return -EBUSY. ovpn does not own the
    sk_prot it would be saving, and would silently displace the ULP's
    callback chain.

  - ovpn_tcp_socket_detach(): if a ULP was layered on top of ovpn
    between attach and detach, do NOT restore the saved sk_prot /
    sk_data_ready / sk_write_space / sk_socket->ops. The ULP recorded
    ovpn_tcp_prot as its lower layer; the correct contract on detach
    is to leave the ULP's callbacks in place so that close() reaches
    the ULP's close hook and the ULP's own teardown path can run.

  - ovpn_tcp_close(): after detach has cleared sk_user_data, close
    dispatches that still land on ovpn_tcp_prot (the ULP close hook
    chains via the captured ctx->sk_proto, which equals
    &ovpn_tcp_prot; the detach-vs-close race window can also leave
    sk_prot pointing at ovpn_tcp_prot momentarily) used to early-
    return without invoking the base TCP close, leaving the TCP
    socket to be freed without a graceful FIN handshake. Chain to
    tcp_prot.close / tcpv6_prot.close in that case so the TCP layer
    still completes its normal shutdown.

OVPN_CMD_PEER_NEW and OVPN_CMD_PEER_DEL are gated by
GENL_ADMIN_PERM, and the ovpn netdev itself is created via
rtnetlink RTM_NEWLINK which also requires CAP_NET_ADMIN; both
gates resolve to CAP_NET_ADMIN in init_user_ns.  A uid 65534
process in a new user+net namespace cannot reach this code path.
The trigger therefore requires an attacker with init-ns
CAP_NET_ADMIN (host network-management service, privileged
container, or rootful container deliberately granted host
CAP_NET_ADMIN).

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/ovpn/tcp.c | 57 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be55..469f968010b74 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <net/hotdata.h>
 #include <net/inet_common.h>
+#include <net/inet_connection_sock.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
 #include <net/transp_v6.h>
@@ -210,14 +211,29 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
 	struct ovpn_peer *peer = ovpn_sock->peer;
 	struct sock *sk = ovpn_sock->sk;
+	bool has_ulp;
 
 	strp_stop(&peer->tcp.strp);
 	skb_queue_purge(&peer->tcp.user_queue);
 
-	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
-	sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
-	sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
-	sk->sk_prot = peer->tcp.sk_cb.prot;
+	/* If a TCP ULP (e.g. kTLS) was installed on top of our protocol
+	 * callbacks after ovpn_tcp_socket_attach(), the ULP recorded
+	 * ovpn_tcp_prot as its lower layer and replaced sk_prot with its
+	 * own. Directly restoring the pre-attach sk_prot here would
+	 * overwrite the ULP's sk_prot with the base TCP proto, bypassing
+	 * the ULP close path entirely on subsequent close() (which would
+	 * leak the ULP context and leave any deferred ULP work pointing
+	 * at the freed sock). Leave the callbacks alone in that case;
+	 * the ULP's close path is responsible for both its own teardown
+	 * and for chaining into the saved lower-layer close.
+	 */
+	has_ulp = inet_csk_has_ulp(sk);
+	if (!has_ulp) {
+		/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+		sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+		sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+		sk->sk_prot = peer->tcp.sk_cb.prot;
+	}
 
 	/* tcp_close() may race this function and could set
 	 * sk->sk_socket to NULL. It does so by invoking
@@ -228,7 +244,7 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 	 * sk_socket to disappear under our feet
 	 */
 	write_lock_bh(&sk->sk_callback_lock);
-	if (sk->sk_socket)
+	if (sk->sk_socket && !has_ulp)
 		sk->sk_socket->ops = peer->tcp.sk_cb.ops;
 	write_unlock_bh(&sk->sk_callback_lock);
 
@@ -518,6 +534,17 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 	/* make sure no pre-existing encapsulation handler exists */
 	if (ovpn_sock->sk->sk_user_data)
 		return -EBUSY;
+
+	/* refuse to layer on top of an already-attached TCP ULP (e.g.
+	 * kTLS). ovpn replaces sk_prot/sk_data_ready/sk_write_space by
+	 * direct field writes; layering it under an existing ULP would
+	 * confuse the ULP's saved-proto chain. The inverse case (a ULP
+	 * layered on top of ovpn after attach) is handled in
+	 * ovpn_tcp_socket_detach().
+	 */
+	if (inet_csk_has_ulp(ovpn_sock->sk))
+		return -EBUSY;
+
 	rcu_assign_sk_user_data(ovpn_sock->sk, ovpn_sock);
 
 	/* only a fully connected socket is expected. Connection should be
@@ -583,6 +610,26 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 	sock = rcu_dereference_sk_user_data(sk);
 	if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
 		rcu_read_unlock();
+		/* No (or no-longer-attached) ovpn state on this socket.
+		 * That happens when ovpn_tcp_socket_detach() already ran
+		 * and cleared sk_user_data, but the caller chain still
+		 * dispatches ->close() on ovpn_tcp_prot. The two cases
+		 * that exhibit this are:
+		 *   - a TCP ULP layered on top of ovpn whose close hook
+		 *     chains via the captured ctx->sk_proto (which is
+		 *     &ovpn_tcp_prot) after detach has run;
+		 *   - the close-vs-detach race window where sk_user_data
+		 *     has been cleared but sk_prot has not yet been
+		 *     restored.
+		 * In both cases the TCP layer still owes the peer a
+		 * graceful close, so chain to the base TCP close.
+		 */
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			tcpv6_prot.close(sk, timeout);
+		else
+#endif
+			tcp_prot.close(sk, timeout);
 		return;
 	}
 	peer = sock->peer;

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


