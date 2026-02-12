Return-Path: <netdev+bounces-258509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN2oNGNAjmlTBQEAu9opvQ
	(envelope-from <netdev+bounces-258509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36E1311E0
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B38301DF7D
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624332BF52;
	Thu, 12 Feb 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y3lrGK1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6213D8B1
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930269; cv=none; b=YEkaoDGekpM8YwJudTwj49kqkLpxnpUbERTaL81UgPSGHWmZlpXgjwq1QdvkJxnMJRwY0f3x3ALnzNkhyasdtjMJcJeNSocJf+A0N2JcmFRVRTAkFngZzQ38kvkjvgr7DehY++OAj7bpK7vihIohgEcKib+fCUDsXGhxRA7CEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930269; c=relaxed/simple;
	bh=oYMM7nBImDrMg+atfkQAxFmvnVim8mU59dHbxVsofEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr9LIjOdUVfeofK7umR9XKvVSeDjkgT0NgGaQq+4MaVkoQ2+CV3SHbaivU4rpBH6e7uOEluiMkCbCzIXUjLwQW8hY+4ddFTJAhzbBo5V2fTTOfhCfGCtFhyBZQpIDQN/YGS5iR3MEFyKJjn7IouRqPZLwrDh5wYF2eKRrhjSdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y3lrGK1C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso1971215e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770930266; x=1771535066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7j+TS0xMuw/k5Z0G0O0Fwj36f2HVgaqmoNvYyfmhYU=;
        b=Y3lrGK1CfXtszefv+9JWcFiIXtd71DX/PSnU2+tBE6rt8yLoZYOZzU9HT4YtgdqDTG
         J81RSF3dvZ3b/rPQ3fqXQRymPVN+iugK1FNUVmCwYsOEd28iB2spOfVnFlEMmuUZdTtK
         MjNlWtyzO8RACqqQNO4y2sgns7woeNwJFzCse3WCtigEydNKloWvK0UL6bDcINrswg7H
         Nxg/YsszkDGdIAoaAETNoY4OxdzJKfkoxe7mwI905X8OC7QjhVM55FVpHkGePDCl4JxF
         1Jw1FDiymANkE5J6APZG3Ui4QRmrnUsUx3QY0pFwTCm4b9adU7/h0rsLLbza+yjKbPqd
         9kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930266; x=1771535066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7j+TS0xMuw/k5Z0G0O0Fwj36f2HVgaqmoNvYyfmhYU=;
        b=FFqNxGBPO2FDM0uFTYgTWYwRswApfcO4rUbpVJ2DYdcBZHNVcie7l8T889vy2lygyI
         gFSMbrynEKA4e6Ptk77phYsT5t4K46weC0WcZRbac/KBcEy2YOHjgVI70ja8f5b8KOmz
         3Y68hcg6Bfdw1WZANatSpBayvpgjHDl5Tex/iOw66zDwcKhiTPSBrvwuUCbHegGc0/D9
         mT0mKqyL3tIQNH0jkCIO1qulgBPFSuQFExSaSVWdg/licjnG8dUdeIw7GYFEdTzZt39M
         E+PqWNOeIoa9ENkasPUuMgd/dub6dLiMN9vNyvim3gXY12QZQbRMpFtXDKuPshoht6XD
         46uQ==
X-Gm-Message-State: AOJu0YyTkt21aR0fx+boYtVxMd1uHV0QuS0Hw7GOx0o2Hwupev9MFVFa
	mDTpWemhXnDoISb41wdsiRIvddcnLyU1T1rDJCBxK3Xs3v98pREV+bRdu1jOj69Yn7jViOnM9oZ
	7ebLdduRsyX6sNwIR7sYyRzRRPNZbQJ/sbxxwc2hXLZX4v3Y5Xa50ojSIHsqT/3io
X-Gm-Gg: AZuq6aIrm/bd9EfL6lQ4aM5buyo15EroTYkNY4lsErFgK0bfWyAgcuJfkhjGIEnV5Gk
	ze/70IURQyVeXtqb2P0XaUY3ylba5OLgDx951FOlxZxRB9qoWyfKfcW2tL4EgpaNgwIkqamvN9m
	plBG9stwrj5eHGw9gbHJh+JnAajKU96KTdoHveEWL/Ps35XtZkfgr2Ik2JXTSfzJdTKcDjGEiow
	vNVI/6eKmy/VXTCXHeGfcISJ/+doRvN3jpNo3dgDTylb6MkQE92xjLZ20wxaysmFHsczOOIq/h+
	kuKdOEYlutJCeHmF/VtdVZ08AhP97/1URaXF9U7QZAiPw1HOkK4Ecft1opsg6TKUcN5S3rCVYyN
	S1H156rRD0ZHhiHsiAkXaF8n+6sKHKkyC7v4n1e2ryBP5mAalJT7iJnOWxgvz+hJg6FHuKPS4WT
	JI9p1evq3IgjwJdpPbUUf6nq2Ak0GQZ8iu9D1h
X-Received: by 2002:a05:600c:5295:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48370e18640mr8287325e9.5.1770930265665;
        Thu, 12 Feb 2026 13:04:25 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483719b8e71sm5170925e9.2.2026.02.12.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:04:24 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/3] ovpn: set sk_user_data before overriding callbacks
Date: Thu, 12 Feb 2026 22:03:27 +0100
Message-ID: <20260212210340.11260-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212210340.11260-1-antonio@openvpn.net>
References: <20260212210340.11260-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim,openvpn.net:email]
X-Rspamd-Queue-Id: 7C36E1311E0
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

During initialization, we override socket callbacks and set sk_user_data
to an ovpn_socket instance. Currently, these two operations are
decoupled: callbacks are overridden before sk_user_data is set. While
existing callbacks perform safety checks for NULL or non-ovpn
sk_user_data, this condition causes a "half-formed" state where valid
packets arriving during attachment trigger error logs (e.g., "invoked on
non ovpn socket").

Set sk_user_data before overriding the callbacks so that it can be
accessed safely from them. Since we already check that the socket has no
sk_user_data before setting it, this remains safe even if an interrupt
accesses the socket after sk_user_data is set but before the callbacks
are overridden.

This also requires initializing all protocol-specific fields (such as
tcp_tx_work and peer links) before calling ovpn_socket_attach, ensuring
the ovpn_socket is fully formed before it becomes visible to any
callback.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.c | 39 +++++++++++++++++++++------------------
 drivers/net/ovpn/tcp.c    |  9 +++++++--
 drivers/net/ovpn/udp.c    |  1 +
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 9750871ab65c..448cee3b3f9f 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -200,6 +200,22 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	ovpn_sock->sk = sk;
 	kref_init(&ovpn_sock->refcount);
 
+	/* TCP sockets are per-peer, therefore they are linked to their unique
+	 * peer
+	 */
+	if (sk->sk_protocol == IPPROTO_TCP) {
+		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
+		ovpn_sock->peer = peer;
+		ovpn_peer_hold(peer);
+	} else if (sk->sk_protocol == IPPROTO_UDP) {
+		/* in UDP we only link the ovpn instance since the socket is
+		 * shared among multiple peers
+		 */
+		ovpn_sock->ovpn = peer->ovpn;
+		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
+			    GFP_KERNEL);
+	}
+
 	/* the newly created ovpn_socket is holding reference to sk,
 	 * therefore we increase its refcounter.
 	 *
@@ -212,29 +228,16 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
 	ret = ovpn_socket_attach(ovpn_sock, sock, peer);
 	if (ret < 0) {
+		if (sk->sk_protocol == IPPROTO_TCP)
+			ovpn_peer_put(peer);
+		else if (sk->sk_protocol == IPPROTO_UDP)
+			netdev_put(peer->ovpn->dev, &ovpn_sock->dev_tracker);
+
 		sock_put(sk);
 		kfree(ovpn_sock);
 		ovpn_sock = ERR_PTR(ret);
-		goto sock_release;
-	}
-
-	/* TCP sockets are per-peer, therefore they are linked to their unique
-	 * peer
-	 */
-	if (sk->sk_protocol == IPPROTO_TCP) {
-		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
-		ovpn_sock->peer = peer;
-		ovpn_peer_hold(peer);
-	} else if (sk->sk_protocol == IPPROTO_UDP) {
-		/* in UDP we only link the ovpn instance since the socket is
-		 * shared among multiple peers
-		 */
-		ovpn_sock->ovpn = peer->ovpn;
-		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
-			    GFP_KERNEL);
 	}
 
-	rcu_assign_sk_user_data(sk, ovpn_sock);
 sock_release:
 	release_sock(sk);
 	return ovpn_sock;
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 0d7f30360d87..f0b4e07ba924 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -487,6 +487,7 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 	/* make sure no pre-existing encapsulation handler exists */
 	if (ovpn_sock->sk->sk_user_data)
 		return -EBUSY;
+	rcu_assign_sk_user_data(ovpn_sock->sk, ovpn_sock);
 
 	/* only a fully connected socket is expected. Connection should be
 	 * handled in userspace
@@ -495,13 +496,14 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
 				    netdev_name(peer->ovpn->dev),
 				    ovpn_sock->sk->sk_state);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	ret = strp_init(&peer->tcp.strp, ovpn_sock->sk, &cb);
 	if (ret < 0) {
 		DEBUG_NET_WARN_ON_ONCE(1);
-		return ret;
+		goto err;
 	}
 
 	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
@@ -536,6 +538,9 @@ int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
 	strp_check_rcv(&peer->tcp.strp);
 
 	return 0;
+err:
+	rcu_assign_sk_user_data(ovpn_sock->sk, NULL);
+	return ret;
 }
 
 static void ovpn_tcp_close(struct sock *sk, long timeout)
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..272b535ecaad 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -386,6 +386,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn)
 {
 	struct udp_tunnel_sock_cfg cfg = {
+		.sk_user_data = ovpn_sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
-- 
2.52.0


