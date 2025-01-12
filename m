Return-Path: <netdev+bounces-157527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93256A0A975
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB10166C27
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2081B412C;
	Sun, 12 Jan 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Y9v+OTbt"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAF224D7;
	Sun, 12 Jan 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687611; cv=none; b=KikH0jeEdUXptIsrcC4rvDomWmATnuzEN93837bXzjGP32qWeg5Vb7uJECX4ZYebSyHZfYE30ohYy1BS2SCPoOsdUKR9NC4MVhDWAb8arI1S5RaLYRfVQcbebJOCWkQEssqkpH+NvSdkXvs4Rbg2UDM9rYtdY1XQh/1zh7JN5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687611; c=relaxed/simple;
	bh=DC4WgAfei5Sc4tuX/HQoXJDS5RVZGmDtHFXokff9FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4fgeuEfTj5l2UCY9EZszIEDKlMSeddtk7MGP2sTmcJTWYrH47bvNyN1FyL9s5uo1kOWxs4B5xv4fg1fGsT9jWmF5vqB8oaprnQX2ZY9lOiG+2zzQYWKH3b/P0647seu7awZTMLxvPDFt78wAU2zSOyR0R9fVlPMg4iUyd9xjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Y9v+OTbt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=WYcJqo++ZjMA3tjtoJzxBlObLLUp6of3RrHdqjkdtpQ=; b=Y9v+OTbt5x6cO/YH
	JTZtMo/ifTWcMd3d8HQR4RxEJah7g1J2R5DKqkOffBY8x+lY9tvKN9oR//AmN/0sRzaMRsKazLTQy
	m01qtcQkbThNQBjZH0ARHg4bgIXYlC7LLMIOXm9HneuM2zw1t2aGvblGrK19DdbOMMvt42MmoxqEk
	A15f0MUwJO3oBLg31OuWsjqvKAEM9O7B8g2hPdpY2i99jDZCEpgsr8NwbtXshFbh2Lv49ByO0WiaB
	xWPmKVprBEkbgWVgD/waMJ2KwpX96765uxCmomHfMKYZP1Hd8NulQgFFuquORUaNprCi4iL7QexMI
	V+wHKzSPHxceEAtPgA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tWxmJ-009iy0-1G;
	Sun, 12 Jan 2025 13:13:19 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] socket: Remove unused kernel_sendmsg_locked
Date: Sun, 12 Jan 2025 13:13:18 +0000
Message-ID: <20250112131318.63753-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of kernel_sendmsg_locked() was removed in 2023 by
commit dc97391e6610 ("sock: Remove ->sendpage*() in favour of
sendmsg(MSG_SPLICE_PAGES)")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/net.h |  2 --
 net/socket.c        | 28 ----------------------------
 2 files changed, 30 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index b75bc534c1b3..0ff950eecc6b 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -343,8 +343,6 @@ static inline bool sendpages_ok(struct page *page, size_t len, size_t offset)
 
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len);
-int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-			  struct kvec *vec, size_t num, size_t len);
 int kernel_recvmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len, int flags);
 
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..430b38ed0cb9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -774,34 +774,6 @@ int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 EXPORT_SYMBOL(kernel_sendmsg);
 
-/**
- *	kernel_sendmsg_locked - send a message through @sock (kernel-space)
- *	@sk: sock
- *	@msg: message header
- *	@vec: output s/g array
- *	@num: output s/g array length
- *	@size: total message data size
- *
- *	Builds the message data with @vec and sends it through @sock.
- *	Returns the number of bytes sent, or an error code.
- *	Caller must hold @sk.
- */
-
-int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-			  struct kvec *vec, size_t num, size_t size)
-{
-	struct socket *sock = sk->sk_socket;
-	const struct proto_ops *ops = READ_ONCE(sock->ops);
-
-	if (!ops->sendmsg_locked)
-		return sock_no_sendmsg_locked(sk, msg, size);
-
-	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
-
-	return ops->sendmsg_locked(sk, msg, msg_data_left(msg));
-}
-EXPORT_SYMBOL(kernel_sendmsg_locked);
-
 static bool skb_is_err_queue(const struct sk_buff *skb)
 {
 	/* pkt_type of skbs enqueued on the error queue are set to
-- 
2.47.1


