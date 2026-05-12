Return-Path: <netdev+bounces-286939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHbPLbeqAmqkvQEAu9opvQ
	(envelope-from <netdev+bounces-286939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A695198C1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 519913013D40
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B1316190;
	Tue, 12 May 2026 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf1vjOfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD530B50D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559650; cv=none; b=oOv1mCMx3x4fXVJXkNqz0gKjxxGIGZdjWUn0TgxVBfGFYYZ9snwC2AfyQWLfg+q74J4PdvMMu9h8UZrCRyYi4k03Eq13jffuZ0uO4Q6i75q7EgA90uyYkru21z+zN66EHDppyMMV5gg+3m/hbMK1CT5USRFjZk931k/f5Y5+Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559650; c=relaxed/simple;
	bh=WHiesOwbbaRykJfdtVDyeKoOa5KVbxP/VHmih9skOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAkFfp6f+yrLxBO1xfTXo2yhBFxVftZQMM9Cju4oj8MTONlguUd0xBgViHqxAWSBxXuT270Ycb0hATjjh6DgiyTsr/b3p4aWb5iFuQf3f7G9LQ+a3NHLUELMmJBHBbhCF2V1F0vYdwp3BqN8MBzSV5Bw4DU0T5v5GFdCmKLPsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf1vjOfv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so53197105e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778559646; x=1779164446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rA8ducxret8G6zv/e1/Fv9YIi0bNAE6NW5UJ1HwACA=;
        b=mf1vjOfvfPJpLd9NIG+vH5GU+xB0x19CJirg6mbPMQyTThRrVHXR4xr2UBkgCPKJWT
         ZgUL+ymWa4bUj3lptEDaB5csr8uplgc2YGBJlyvTL9Gm43LXXveygFhW0+b4aWj2/OVG
         dwI81UmD8Nl0GblPtXPZmFaHjeYnr9I6w6ducXJlh2wN7P2AIp65xlUDE82Bnc1Yh3go
         UTMVfOX7IRgp6jBl8qKMWhXhxH+Zb8ZLYJ8u9yuozZG6ZbKDWPj3PAu4bhZELvuyqNF7
         BOSf/zz7o/RBgbDfr/vkVx9gGVzOkiBDjI46XdouSfaSbG6ixO/KVsZFSgwJ0lGQa/7b
         tLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778559646; x=1779164446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rA8ducxret8G6zv/e1/Fv9YIi0bNAE6NW5UJ1HwACA=;
        b=hAhZBOwZ5I1HqdHl5eW23h3zyJGZS+MjqYDcNUG2psdUCj4j0fzV6SAlMPx/rMfNAm
         eSvHULfs2CAg95ZkQ6py/LNMz1JcECfwZqLv8KgQuyjiEMGaarDMnwdV0nk+olf6n5R/
         i3O9uUUNxlEBXl0ojnuYJmmDiYAVcnZHkdJOQCnRb+/7y7aFxpjF/d5XIijAgn9QFEJY
         ahgus4giq5gtFn/G5/g4lqCmhrKVXgWgjDycA2/fYcFLjTFzD2uFzey1t6701/ZBQ4Y6
         G6P6itO6J27mPI6zzHG9I/uoFJEticHaB/JYG78wW83Ow2A7ZMWUrnfl7ddL/QJLnLAt
         vwBg==
X-Gm-Message-State: AOJu0YyyR/v/VTIKnELpb8CsaLCW6SQcZ4xYqnDIUrEZEe5MBXGfRUvE
	PwtyGApmnRa+5YW074PjffVgm5PcUVWTF14A6wcT40g+iUG0ebopHk7Rf+z91Znax9bbtQ==
X-Gm-Gg: Acq92OF26qzkx8Gi3yEVYENdlRRBmV5k5cT/qqUbxEqluV1fK4lybS+sJnZ44ZMsmAZ
	8qo3hdRabV4TBlQRQnyYjppKeOtqeHqDP/88ZrEcEhmUgbdD5OA7K6gapKWmk2gADsrimbGfpDv
	/NJkF9cHiRMqNdAkTna1ByQG5gplhbJ6OhkDgTuLeQJFmlfJ62MTk4Y+fnANnjX0SChjgEqckoP
	X35OTC/QmEtHiirITQ3l3fUfFIzdLagFRQmp4dTrYdTTZo63JFwRiB0RaGj9pGYtsb6vo55C27q
	sx7Ch3AXoQwK3D/NRyOJuXLYdpdIMfY7SS+4M+0+qXiTOe9KhRMj5dtrmaCCkZaxw5CScZPlez2
	As4ANFmDHrg1yBelKNXdZopyF425W1hztbjL3qCQeJWI248wPk6Rv+mYVmX2mif6V8VG0Zqhz7W
	oo+2H13bqRqS5BZWTn015gGh6eCng5D3LYDolqyvvsl/pdjseGZsT2DP0uWgHwvYsmA1+LUZRz7
	CgoXIF5/08=
X-Received: by 2002:a05:600c:8207:b0:48e:82cc:4d4c with SMTP id 5b1f17b1804b1-48e8fe7cfa1mr15556645e9.23.1778559645692;
        Mon, 11 May 2026 21:20:45 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908d2c77sm16802215e9.12.2026.05.11.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:20:44 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
Date: Tue, 12 May 2026 05:19:12 +0100
Message-ID: <20260512042036.19870-2-devnexen@gmail.com>
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
X-Rspamd-Queue-Id: 05A695198C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,openvpn.net,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286939-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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

Use the already-loaded peer local, which is held by the
ovpn_peer_hold() taken under RCU and is the correct argument anyway.
The remaining lines in the function already use peer; switching this
call makes the function consistent and removes the dangling sock
dereference.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ovpn/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..ed4782de141a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -588,7 +588,7 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 	peer = sock->peer;
 	rcu_read_unlock();
 
-	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
 	peer->tcp.sk_cb.prot->close(sk, timeout);
 	ovpn_peer_put(peer);
 }
-- 
2.53.0


