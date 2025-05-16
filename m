Return-Path: <netdev+bounces-191049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A0AB9E78
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DFD16475D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111EB18FDBD;
	Fri, 16 May 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XtXRnzWg"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468916F8E9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405076; cv=none; b=SrjfKCuQa9sajZIw5OHFLEN+gFvdxPxjbMqn98Q08G4vq2U2CwSyDFWvvkG8u53mFR7Qjo1liML26V6AtiuGF9QH9gwWGdnSg4m50IDbvgCpBX7u3wXc5fUrMR0odhCkNZwdEcH72pfZGLKMyEcjRr3lIQ5zmbz5arz5UvRzzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405076; c=relaxed/simple;
	bh=di7VcqmsOR/ksmcCT55gbdF3amMK+ETAgYq2FlW2QA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQVpARiskbDHmZFP5PVEOjfy4650hKc7qCC9as03CZWcmU1qqWLTblLvB3vC8EwWv1ZB+LNCMXITJnAyPWvFQGQnh1CaLm+hiyYqJzoGYD9w2ncBR/Jov7ZlQuoUrCXM6ztNclH9cngnqTCz7bqeYOPou6X19xXqO9NDeURKnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XtXRnzWg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747405060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2WuqP8hVhA8NoR8vkcRmgIaGt57MUyF4WZKw8XNlY3A=;
	b=XtXRnzWg1XOU15tFoqBgtCFbrOgBRiT7vGUxMP8epA3uZ4lF0it8pMe1uNaV+HyNBzFFrn
	sGv4+MERAu4wsBhIr4sEv6MvLdRkj7lshSJoDgWgxbrajRIK8lbexfkw6+wwTag7erT9E1
	qFouPCUZPmw/ouaJeyusQBLxSkzKA0A=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6] bpf, sockmap: avoid using sk_socket after free when sending
Date: Fri, 16 May 2025 22:17:12 +0800
Message-ID: <20250516141713.291150-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The sk->sk_socket is not locked or referenced in backlog thread, and
during the call to skb_send_sock(), there is a race condition with
the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
will be affected.

Race conditions:
'''
CPU0                               CPU1

backlog::skb_send_sock
  sendmsg_unlocked
    sock_sendmsg
      sock_sendmsg_nosec
                                   close(fd):
                                     ...
                                     ops->release() -> sock_map_close()
                                     sk_socket->ops = NULL
                                     free(socket)
      sock->ops->sendmsg
            ^
            panic here
'''

The ref of psock become 0 after sock_map_close() executed.
'''
void sock_map_close()
{
    ...
    if (likely(psock)) {
    ...
    // !! here we remove psock and the ref of psock become 0
    sock_map_remove_links(sk, psock)
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        goto no_psock; <=== Control jumps here via goto
        ...
        cancel_delayed_work_sync(&psock->work); <=== not executed
        sk_psock_put(sk, psock);
        ...
}
'''

Based on the fact that we already wait for the workqueue to finish in
sock_map_close() if psock is held, we simply increase the psock
reference count to avoid race conditions.

With this patch, if the backlog thread is running, sock_map_close() will
wait for the backlog thread to complete and cancel all pending work.

If no backlog running, any pending work that hasn't started by then will
fail when invoked by sk_psock_get(), as the psock reference count have
been zeroed, and sk_psock_drop() will cancel all jobs via
cancel_delayed_work_sync().

In summary, we require synchronization to coordinate the backlog thread
and close() thread.

The panic I catched:
'''
Workqueue: events sk_psock_backlog
RIP: 0010:sock_sendmsg+0x21d/0x440
RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
...
Call Trace:
 <TASK>
 ? die_addr+0x40/0xa0
 ? exc_general_protection+0x14c/0x230
 ? asm_exc_general_protection+0x26/0x30
 ? sock_sendmsg+0x21d/0x440
 ? sock_sendmsg+0x3e0/0x440
 ? __pfx_sock_sendmsg+0x10/0x10
 __skb_send_sock+0x543/0xb70
 sk_psock_backlog+0x247/0xb80
...
'''

Reported-by: Michal Luczaj <mhal@rbox.co>
Fixes: 4b4647add7d3 ("sock_map: avoid race between sock_map_close and sk_psock_put")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
V5 -> V6: Use correct "Fixes" tag.
V4 -> V5:
This patch is extracted from my previous v4 patchset that contained
multiple fixes, and it remains unchanged. Since this fix is relatively
simple and easy to review, we want to separate it from other fixes to
avoid any potential interference.
---
 net/core/skmsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..34c51eb1a14f 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* Increment the psock refcnt to synchronize with close(fd) path in
+	 * sock_map_close(), ensuring we wait for backlog thread completion
+	 * before sk_socket freed. If refcnt increment fails, it indicates
+	 * sock_map_close() completed with sk_socket potentially already freed.
+	 */
+	if (!sk_psock_get(psock->sk))
+		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
@@ -708,6 +715,7 @@ static void sk_psock_backlog(struct work_struct *work)
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
+	sk_psock_put(psock->sk, psock);
 }
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
-- 
2.47.1


