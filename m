Return-Path: <netdev+bounces-148143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0329E0887
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00FD16D70E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDF13A265;
	Mon,  2 Dec 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="VG/n0a8P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE77DA7F
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155000; cv=none; b=OyMJJIZ1unnReLJJEeSEjoijzsHSGhjosHwsoHSLjQme+YNi4SN/F0L+rbHb1ZdKAtaXowv48u0Ape8KuWhQLUjKcGpBO/8UU4U8fi8nfvnLkkiYk3wGSuT6GIYcTFZ4aNAu0vtcfoRrRAV95qoDuVizBVSkZb49devpkhpyjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155000; c=relaxed/simple;
	bh=9BQOfzo4GrMl6FGpkZB3TGr+y5udJ5latSV0ZYYpa4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlgQK1gwkSFYiIEwRB1dFI0NvnfkAejX3Id9qsX8OBin2KxOGCSyXdKSIZ/Uicrh0wrngVlnFQwCenqxejkqbrPljidE/2fXxLomIlHZTb2vL9a34OPczoXYkYx6kYOZhfCxc9T7qrQcQQDgp92Jqg9yF/Rc9lOXjxZbBWa+SxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=VG/n0a8P; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Y27gn0sLqz9wD9;
	Mon,  2 Dec 2024 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1733154997; bh=9BQOfzo4GrMl6FGpkZB3TGr+y5udJ5latSV0ZYYpa4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=VG/n0a8PBgqRxvLFfxJkjMTFpBVvFCgxiePARLShxmh8YmwfewFoW0uOjGrZAu80/
	 VFx3F14bOgkXZUpiHEFLUZ7p5in/ktQwYuw61M7e0aYjXeyjD6kqJCPb97NjebnZe7
	 mC0FLr/FuxdzbQNuk9hnRr0YEvISxOir99p4pSPo=
X-Riseup-User-ID: 71C4487E0CBE93497DDEB137838B8134B9AE9A16B2131A1269D49275E014458D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Y27gl2172zFvTC;
	Mon,  2 Dec 2024 15:56:35 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH net] Revert "udp: avoid calling sock_def_readable() if possible"
Date: Mon,  2 Dec 2024 15:56:08 +0000
Message-ID: <20241202155620.1719-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 612b1c0dec5bc7367f90fc508448b8d0d7c05414. On a
scenario with multiple threads blocking on a recvfrom(), we need to call
sock_def_readable() on every __udp_enqueue_schedule_skb() otherwise the
threads won't be woken up as __skb_wait_for_more_packets() is using
prepare_to_wait_exclusive().

Link: https://bugzilla.redhat.com/2308477
Fixes: 612b1c0dec5b ("udp: avoid calling sock_def_readable() if possible")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 net/ipv4/udp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6a01905d379f..e8953e88efef 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1674,7 +1674,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 	int rmem, err = -ENOMEM;
 	spinlock_t *busy = NULL;
-	bool becomes_readable;
 	int size, rcvbuf;
 
 	/* Immediately drop when the receive queue is full.
@@ -1715,19 +1714,12 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	sock_skb_set_dropcount(sk, skb);
 
-	becomes_readable = skb_queue_empty(list);
 	__skb_queue_tail(list, skb);
 	spin_unlock(&list->lock);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (becomes_readable ||
-		    sk->sk_data_ready != sock_def_readable ||
-		    READ_ONCE(sk->sk_peek_off) >= 0)
-			INDIRECT_CALL_1(sk->sk_data_ready,
-					sock_def_readable, sk);
-		else
-			sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
-	}
+	if (!sock_flag(sk, SOCK_DEAD))
+		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+
 	busylock_release(busy);
 	return 0;
 
-- 
2.47.1


