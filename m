Return-Path: <netdev+bounces-258513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNOSNtlGjmmyBQEAu9opvQ
	(envelope-from <netdev+bounces-258513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:32:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4C13141C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99033051CA1
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1912CDBE;
	Thu, 12 Feb 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="H5FTGRbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5C17C220
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931923; cv=none; b=q4f9tdTjJ7ulPd57fPOu52VXvBnGlJnPqkiKX5+nqSq23n347hxSn45OeFb6IQ7xHICnTv5dJ3b2vkW6sMHqnkLpZBHjVcdWZ4fuY9/negjGNMhob8nMWsV4f9ZFOE52oMGTY+wyLZq4TJIE0T0DTV0mglLz8WkofUe6sANCXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931923; c=relaxed/simple;
	bh=RCYk6MptPSVSA2dvwwUsHDlC7gI+91U3ymkMdGPpItA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pbhr+1QhltCZnwbGbmfUh7Kn6hVHkiDn8e8mYUHFsVcyOJ+CY8zwzfVoSe2DavfZBaykyRt849ckJoi23eiZBieJFy2l6KhOm2EAEPcP2qSnORI5eJ8ArazRixcjd76nM2zE7c3u5gydiPnCcV7q9wEPAtZ95bjsZcgvr+wweLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=H5FTGRbR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee07570deso2843245e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770931919; x=1771536719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgDtqyY1qfTbUBNz5n/n1uvOKIUZOq/uLtp1r5KlFPs=;
        b=H5FTGRbRGbjNovHGVN0DqtvE4/vq+hcPpXtsjr6cONqDbvJ3l4g3f/6GNqDvqwtWPB
         POFPG1PgpjM7/bBwUERaktdmbQX+cUZCLpey/X4taDTfoUO8dkNV4+L9j7HER1oOLXtQ
         WdUaRM2n3uAQpe6lEyS6fmpsdkJxPSJX+uYxW6ptWO7UOMIJMtIodv31EJMvhZ+99QGn
         asZq648J7Xc2M6ehRkw+rgJbFWPcmio6iJ/xHwucjAaR3S3yK2WabzFamcYfstTpuQac
         0hc9prAEtUi1H34j+8vX4c9xhNiHNDjP91eX9Z29BejvqQ9DFaQIa1TaHtPnHpUPBMAS
         rlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931919; x=1771536719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgDtqyY1qfTbUBNz5n/n1uvOKIUZOq/uLtp1r5KlFPs=;
        b=NtxxwnOH8uFTlY1lfJlE413R9ldthOJ/RDP/+X4TwI0LRgA08i0fdAPJr+YQlqLBnJ
         ZaNmIe7zBd/ii+XaydvCnRjJA6hYEHlcuc+UaAaFpQwreQ8xcZHoxQKminvNnw4A4mhl
         dpQrxSEql/2imnuCOTIdhO1pZUvEjs1v9qf5DlVdgwpJPM4T4Rbkj4ztl6o2q1SZYh5j
         c2s8glqzd57FKhWKqKvv9Mm5RTrWUTKnN9bjDso25sPcKj8zLahuO9VBxx8XJN8fZSPP
         Mg5YxY+ht6x7G0ldCma1d5rAMFD2iD+GFLCno00csY/vkvXeJ1rBbMWbh9MsqtNgRJnP
         fJPw==
X-Gm-Message-State: AOJu0YxkES7qoRCWoYhBmuQ1tFxLzkmcuTkuo7+6WIICi0Xbn4f0QVg9
	81TOgTmt5wqzBSqR89hxnCFsQK89jWKuTA7MAubVE9j3r+qprkTyPW97IXuU0HERTB0tjoNaRIn
	4zgOhnOu4XJL8ZhSqZ6P8oDyIxMG3WKBmcWnM8yXQygK4zUOxCg4RZJ/VF02isogv
X-Gm-Gg: AZuq6aIgFZO8rjHxLGZefpF8hO27JVQZ4bnrpAmGJTfXeZBHgAatuirhy0m3dQlCblf
	jesklBUXji24dHfjqFwRrQCs0QEbbHmO36srI1NB0w2YwT0zi4/xyB2Iy4aW0GNZTD9c5/DPxwp
	IvrWdCdZSdC0Os+m4J7ZyIDmOn3AwDCwO53t4qVE71Xy1Tqe3+icSD1FlQIzrz792CYs2HZcrNQ
	MRmTZ2EdvOIvOzi6Lp6neA4sTIHDeMfTXIH1/9Z0HqN8CWgzPHV4lGix7mRaO3scNsYBLh3z0i5
	04k9sfZ7CNDNf8T5BHS2zLK81A+qpK3z4Sb8n+JqabL1xXV63NkkQHBu2MtsxPJNFM6IvsB9n9h
	chpFbuisM1Dj6asIAhXsXAjZKhARm37gFJA53Ez0HVS/cuMYVdUCZMoW7MQ8rRGgihxLFkNy83/
	Dm4i8v+bffWQjGDLI6ba1rC8S150T60Qx7ZzHZrs7y6uXZe1c=
X-Received: by 2002:a05:600c:8b21:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-48371036b8fmr8749035e9.17.1770931919455;
        Thu, 12 Feb 2026 13:31:59 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac87sm769398f8f.3.2026.02.12.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:31:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net] ovpn: tcp - don't deref NULL sk_socket member after tcp_close()
Date: Thu, 12 Feb 2026 22:31:19 +0100
Message-ID: <20260212213130.11497-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33D4C13141C
X-Rspamd-Action: no action

When deleting a peer in case of keepalive expiration, the peer is
removed from the OpenVPN hashtable and is temporary inserted in a
"release list" for further processing.

This happens in:
ovpn_peer_keepalive_work()
  unlock_ovpn(release_list)

This processing includes detaching from the socket being used to
talk to this peer, by restoring its original proto and socket
ops/callbacks.

In case of TCP it may happen that, while the peer is sitting in
the release list, userspace decides to close the socket.
This will result in a concurrent execution of:

tcp_close(sk)
  __tcp_close(sk)
    sock_orphan(sk)
      sk_set_socket(sk, NULL)

The last function call will set sk->sk_socket to NULL.

When the releasing routine is resumed, ovpn_tcp_socket_detach()
will attempt to dereference sk->sk_socket to restore its original
ops member. This operation will crash due to sk->sk_socket being NULL.

Fix this race condition by testing-and-accessing
sk->sk_socket atomically under sk->sk_callback_lock.

Link: https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan/
Link: https://github.com/OpenVPN/ovpn-net-next/issues/29
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/tcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index f0b4e07ba924..ec2bbc28c196 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -199,7 +199,19 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 	sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
 	sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
 	sk->sk_prot = peer->tcp.sk_cb.prot;
-	sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+
+	/* tcp_close() may race this function and could set
+	 * sk->sk_socket to NULL. It does so by invoking
+	 * sock_orphan(), which holds sk_callback_lock before
+	 * doing the assignment.
+	 *
+	 * For this reason we acquire the same lock to avoid
+	 * sk_socket to disappear under our feet
+	 */
+	write_lock_bh(&sk->sk_callback_lock);
+	if (sk->sk_socket)
+		sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+	write_unlock_bh(&sk->sk_callback_lock);
 
 	rcu_assign_sk_user_data(sk, NULL);
 }
-- 
2.52.0


