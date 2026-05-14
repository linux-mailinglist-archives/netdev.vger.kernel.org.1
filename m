Return-Path: <netdev+bounces-288106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLv7J89XBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C30547B65
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F633040456
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67638B12E;
	Thu, 14 May 2026 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EfT/VXpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC37253359
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800553; cv=none; b=dy5yY5G1bKzl/SPFT8q1Ud35HINHQIV09xrF4w8kEv6L87gM2l2TCLF3bG5K9oboEch4/aQh99GpOPCUTnpdSzwMIA4EenJGFt7DLYzSjn4scNtl/tyFHm/pVGSF5Fivg1eq3pIyjGBvmDtGVJkZap5YjinPD3yl43iZN6kvD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800553; c=relaxed/simple;
	bh=RbdS2AXtTV3ad53A3a4D/4WmdS5tNCOyFn83cTcVguk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/jOa6prHB8iNOU+m+BUUxv0beunckzlXs6sPFhvo1ZFFpgotsxmz0LDyB+NlaQxK/095H6J5Tqud5lIcLeRcpx5bHuDaHlaAf5NwyPecu/iltAJJVNFC8njBhKQbBoHMhqiwaXbSXzD2mkp2vz1KIBUvyHXC08eLq8dsnkOPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EfT/VXpH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso55240495e9.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800550; x=1779405350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efbJCkfo5/G/A6cDmu1L8I9jz3m7xkzojS9pJ4EkyWQ=;
        b=EfT/VXpHldoghutiqb50Th900DVFVh21T9vkMr3VyPtharJEPLAaXaGw/2/3DK69hQ
         LBGsNA3u/jJF3en+kF6PuWygf3DgLAJkYz7Ua67UEJMDwjf0bnZHDu0Q3/TFWYL1dxJv
         lyrnBOxyFZ/m1NHenCCBH0eOeOObObcepo5f13r9jWz3kI4eCCIWFruIoopY4dHrRAaz
         vee5s/3gerw33wMexNYga1aGwVVnVYzSVYxqOFtbbDxvcZGbcl/tx3w23lI6kXU8Wq8y
         0sJ82LNt6Y80G8lTOATFeUL3Y6euIwT6grkoonDRDMP/ThFwC6cqooX06e7hPbUKltZP
         Yvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800550; x=1779405350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efbJCkfo5/G/A6cDmu1L8I9jz3m7xkzojS9pJ4EkyWQ=;
        b=SwAhPqGaoEltIg809OMDE8Nw3WxudGo9bEQvAVAWQc3Pxkg1f7c0FDjjjdu4m09aTo
         ih/xU3SJ88QW3E4uEn6b2CFrodBt/pF8jhwqIKO3ZCwE9+w4v/o0Kwe1N63OvGFAPtXb
         +MQ/ifcRlcw9Z2zeEisevVdzna5Of1bAypDj+E7TLGwfZDXuFD5o/hskqEk5u9lc+RVC
         30curKLmkXhz7IMk8grV7qQmsc4uPxwyBc0PPw7XX3ozEZe7PEBVHXe6oTL8s1Lhd61I
         q44++zDtLuSLiC8ersSmHfJ0xasA7KE3RfyOyVItB5lz+GAzOvoICnIHwkiDS5kn8jl6
         wClQ==
X-Gm-Message-State: AOJu0Yw2tFXGbudMK1HF4B+BIgI31EExsgZB+4yYyXL1FEscDKFlhU6M
	GhEOgN8rS0/TVC+zXLFFOPBkil6w63YDG6rJFshRywFC8+WQEHk3e/S4QSWDq6HaUQgDm2jx4XX
	6sqN09/87hLafOy7EiYW8ZkDQAnfs9YbCgtbcii8OJ2DKmgYd4zqUtTLaFyrOVb1EdOo=
X-Gm-Gg: Acq92OEMrYNaDgek/k4FQDrvo736RD/KX/u2xhkJtM+TC5f4Okw6ZDShfMsh2lsnu5/
	VEk3FUEzu4jFvwDH0q9LHWLjr04JgG1R/f/2BO+HEdm8yUxjkZ0ivJARwxmNwr2iPCUEcpyEtfo
	n7wFA6y3TMFnVHciAKAMhsHnm2/iSXuC9qkWpPzF1usc7MNhs9v7RavYe6eJtpRKLMeW8Wjj00k
	i8eMCd5B/NVyR/CsxPIOarA3gM2CABaoRJjVggE5/ptbPtopMHgqigMgFZBe69JA5mTvebmo6Sf
	qoxtPt1u/ozbynmZK70R6YB/VpAfJFIPaQ1hgCTLGPtHKEcKuNFxYl8M2dNFiaoTlF8MhhGHfks
	yap7OnrJfzTYvPg6M6KEx6qNZtELo8N5eP5jPa3UybHXPAd3M35nArduqVyMN3/3cHD8yziDCmP
	PPxSvdlkHDruyFa9/vsesUMJeeg95iw0imI3Sc6RCpBQ4WUQ==
X-Received: by 2002:a05:600c:a417:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48fe65168a7mr14963735e9.25.1778800549818;
        Thu, 14 May 2026 16:15:49 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:49 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	David Carlier <devnexen@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/5] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
Date: Fri, 15 May 2026 01:15:41 +0200
Message-ID: <20260514231544.795993-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
References: <20260514231544.795993-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30C30547B65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,kernel.org,redhat.com,davemloft.net,google.com,lunn.ch,mandelbit.com,gmail.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288106-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

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
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
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


