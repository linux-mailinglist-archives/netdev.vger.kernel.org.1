Return-Path: <netdev+bounces-287529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADtXHehYBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:56:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C66531B6D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E55B73067B37
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC33F9F5F;
	Wed, 13 May 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtTRXgl/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3F38E12D
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669731; cv=none; b=RbfWP3dYdI60nAbPxbvau3hx2LPqoM5vQ/kSvzGxDNTnrPoHZQ/wz+8eb9cAt0PYWQYliKqFNbLyeaAzaQ+X3LZploYpdYvcfqij8SFRfa4VSUJX4PLDkMGpH2RAyggUpEub/vfw6qrDNyyPZVv9RVtogF3hRqapdnmuY71avZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669731; c=relaxed/simple;
	bh=YA5UU2YSAnQA9KkDU6jqelbAtkQ7lGYZd7PD181mQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGpUTlAML7pGgOQU+QlZXEtBPhusCGXcyl8/wFkyHbcDUxNO2HdmEaGp4CfrRnSG78eCIrQrM+/PwuyBVgqyEWKlmaaNBlebONViYbhvgi6D6sRO4KAeQNtWCb8U8ONSJGuUJ/YZ9EgE/Ao+1amvx2177PdA5MkmLGregMCuIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtTRXgl/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so54694995e9.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778669727; x=1779274527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2AOBzixiAXR/+aY96dXmQgGRW6wwxs7njCxroHdogs=;
        b=RtTRXgl/u5DPhHYTIcbG3iqU3vdW6VI2Jk2jwyz1wV2ADiMciY11Mv/2XDj5BgOnE2
         7m+t22XXcHH2loo6lg53+sBRtp8oNBWHcU2aSuqsrt/pQtRsL1QZiBoFWe3skhTLsVq/
         ZhXIf5hgUlP8BvI4gfVWGfPguUdn7CUCD8AlMYZDJa6kYGfFMfbIVMW1aVWd8JQPUPMO
         6+GB4I13XKvL0uMqDRNP7glqKoHn7plYie7ahNkEbA6dcSsnXdyPEpRb4IWA1zCiYNEn
         OkE3QBkOqSHEuB+tSV8Vuz+O7sUSNnUjsT+O6k3CiS1krUn4m04rvKVPbubHj7OyFgS8
         51Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669727; x=1779274527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2AOBzixiAXR/+aY96dXmQgGRW6wwxs7njCxroHdogs=;
        b=BwwKd2r/qUFXCEtBc5GIWIPf9CYa7326TCGZg0X9gh7LFtrKuSxFScFcMQ7EJSxEgJ
         LJMnfP0qJ0W+ngso1KZIzKxOfnhDRxelt23+6zwvMnnjr13XAeT/p5uFD69jn+wRlkUj
         frVN4FGGpOv6JWkpQPH68saIqVU29OgwjKcay4zUzvy57wPkxnMdD8C+PZW/xpdRz6BJ
         rF9yOIcDpYY/NXRh8Z43K3ckAV2ZwMbycOERl1MYEbGAKhXSmd9jawCTHJC0OKj+Onqc
         M5WEgcFsPGGDIVvyEn0hkRhj9rw+dCmEhXasFfWQVxQR/KOthtadxzW6/vrYAPHZW0IA
         JAUg==
X-Gm-Message-State: AOJu0Yyx4ZmuwRl3UmNusA4sjmTtNclJI6Xp8214VVcpAkjs1Sy/NZmB
	9AoT2XQB1nYwaWkveKF4zqgZ3bnTYNC0fJU7Tg8VHiC7d894GXGZdzmKl8BK0BlxI2U=
X-Gm-Gg: Acq92OE5zQi4TxvvJ24dj6sP0K9NVj43LryUmSASWw9YeB1wbA14NG5XT9DprQDyKZl
	ANjkt//Jtqwt4p/IkiVhEeEj+yxXacsVhaOYfpcEDZRcm2kbCfkaAAEjoz7zdFkgEfM3/J/qIHh
	P3JpWzlrdGe6IK+lEH7byQuJpPR+5ZA3J5dhH8oQRPKTVrA66VCV+bvHjlHIxEZwCugCOqGA5YH
	yrJZoQ+Xhsjv+e7cR59whP1rb2c/6pUeMqauywNDnbHRnT7MhMd8wdbcvF+uay4pg4aRokQO6q9
	OTEBoeug4Xd2bwP5o/G2acd+d9xosF4EMRtAuF+bAgxO+4JMoLxq3jlk/qGdBKd3kdhytBHbGO3
	CBcG94rtC4SF4JBuRrzig46wlveNLPXQ30ISpR4mYAhNRrxcJ8htrGJsU6IsnDvuOQLh6KBIkXM
	zjALYOmP3udWFZYufq/dYhk8l2DBd3hJ0v7KSAK8kRtilt302WKcbCAQv2V4AtdSW/bPusl3Mw5
	EXsQrDvqJo=
X-Received: by 2002:a05:600c:a087:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48fc9a02812mr38929805e9.4.1778669727511;
        Wed, 13 May 2026 03:55:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm46688195e9.23.2026.05.13.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:55:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
Date: Wed, 13 May 2026 11:55:20 +0100
Message-ID: <20260513105521.21629-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512042036.19870-1-devnexen@gmail.com>
References: <20260512042036.19870-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4C66531B6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,openvpn.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287529-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Action: no action

ovpn_tcp_close() loads the ovpn_socket via rcu_dereference_sk_user_data()
under rcu_read_lock(), takes a reference on sock->peer, caches the peer
pointer in a local, and drops the read lock. It then passes sock->peer
(rather than the cached local) to ovpn_peer_del(), re-dereferencing the
ovpn_socket after the RCU read section has ended.

Unlike ovpn_tcp_sendmsg(), which uses the same "load under RCU, use
after unlock" pattern but is protected by lock_sock() held across the
function, ovpn_tcp_close() runs without the socket lock: inet_release()
invokes sk_prot->close() without taking lock_sock first.

ovpn_socket_release() can therefore complete its kref_put -> detach ->
synchronize_rcu -> kfree(sock) sequence concurrently, in the window
after ovpn_tcp_close() drops rcu_read_lock() but before it dereferences
sock->peer. The synchronize_rcu() in ovpn_socket_release() protects
readers that use the dereferenced pointer inside the RCU read section,
not those that escape the pointer to a local and use it afterwards.

A reproducer follows the pattern of commit 94560267d6c4 ("ovpn: tcp -
don't deref NULL sk_socket member after tcp_close()"): trigger a peer
removal (keepalive expiration or netlink OVPN_CMD_DEL_PEER) at the same
moment userspace closes the TCP fd. That commit fixed the detach-side
of the same race window; this one fixes the close-side at a different
victim.

Tighten the entry block to read sock->peer exactly once into the cached
peer local, and route all subsequent uses (the hold check, the
ovpn_peer_del() call, and the prot->close() invocation) through that
local. sock->peer is only ever written once in ovpn_socket_new() under
lock_sock(), before rcu_assign_sk_user_data() publishes the ovpn_socket,
and is never reassigned afterwards - but the previous multi-read pattern
made that invariant implicit rather than explicit. The same multi-read
shape exists in ovpn_tcp_recvmsg(), ovpn_tcp_sendmsg(),
ovpn_tcp_data_ready() and ovpn_tcp_write_space(); those will be cleaned
up via a dedicated helper in a follow-up net-next series.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v2:
- Tighten the entry block to read sock->peer exactly once into the
  cached peer local; route the hold check, ovpn_peer_del() call and
  prot->close() invocation through that local (Eric Dumazet)
- Add Reviewed-by from Sabrina Dubroca
- The same multi-read sock->peer pattern in ovpn_tcp_recvmsg(),
  ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
  will be handled by a dedicated helper in a follow-up net-next series
  (Sabrina Dubroca, Antonio Quartulli)

 drivers/net/ovpn/tcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..82809b016f0a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -581,14 +581,19 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
-	if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
+	if (!sock) {
 		rcu_read_unlock();
 		return;
 	}
+
 	peer = sock->peer;
+	if (!peer || !ovpn_peer_hold(peer)) {
+		rcu_read_unlock();
+		return;
+	}
 	rcu_read_unlock();
 
-	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
 	peer->tcp.sk_cb.prot->close(sk, timeout);
 	ovpn_peer_put(peer);
 }
-- 
2.53.0


