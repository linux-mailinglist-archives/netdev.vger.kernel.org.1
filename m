Return-Path: <netdev+bounces-195612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C99AD1736
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0A188ACC7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF72459FD;
	Mon,  9 Jun 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tWyQrXWg"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8319F464
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437974; cv=none; b=SmEyDGRqXRx/l1+JSHutKpgZyyz3RwKL2rG0/Z6xriKdMt6BbiYH2p0LLKHjsHEUTRIdBHGiFH+X29dmXRX5yzfMbgP2OT4Zf/JbOp8rrKJEKLigVXi4v7FKBOxEOouCBrptqRNZl3HBe2kuRbanJAoIqPWI098evpHcR6E67n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437974; c=relaxed/simple;
	bh=UQElxAqGxBmUymstBZ/Dk/1nzyfCRHDk4FZj9475Mnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu5mOxIC3PEp7zKUUJhnOOhYtAASorV95TzslQLTl5/Tsth/JV4J0gYXh+hAfrocaeCE7FkR5y6p5UhSSrBvCbyOmdmjriNSFAJVlvXwtRQTt4o4M/hZkt18k7Ii/ysbKGFTJopYSG9MjHA9OWxslqrEE1jZNYuSkP0a6EiuMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tWyQrXWg; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749437960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K0E0j2BlPBhEZVL7ok/0anTaOlpOqXA2NyI5PTiVfMY=;
	b=tWyQrXWguA+ancsJD83ufgUvjOSaZJM8GQUgWmiCpxfkAPoFtrldct233g2dm09zrZEWqr
	dTNiLK6Hqupx/HlzQhgZvBbgoe2MQE3DSHV0Jf4aGbJ13/0POOQD7Rn/4GT76imbEQWGvr
	IC6o3BtFXr5ZDS6pz2xprufyGVjLKvo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, sockmap: Fix psock incorrectly pointing to sk
Date: Mon,  9 Jun 2025 10:59:08 +0800
Message-ID: <20250609025908.79331-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We observed an issue from the latest selftest: sockmap_redir where
sk_psock(psock->sk) != psock in the backlog. The root cause is the special
behavior in sockmap_redir - it frequently performs map_update() and
map_delete() on the same socket. During map_update(), we create a new
psock and during map_delete(), we eventually free the psock via rcu_work
in sk_psock_drop(). However, pending workqueues might still exist and not
be processed yet. If users immediately perform another map_update(), a new
psock will be allocated for the same sk, resulting in two psocks pointing
to the same sk.

When the pending workqueue is later triggered, it uses the old psock to
access sk for I/O operations, which is incorrect.

Timing Diagram:

cpu0                        cpu1

map_update(sk):
    sk->psock = psock1
    psock1->sk = sk
map_delete(sk):
   rcu_work_free(psock1)

map_update(sk):
    sk->psock = psock2
    psock2->sk = sk
                            workqueue:
                                wakeup with psock1, but the sk of psock1
                                doesn't belong to psock1
rcu_handler:
    clean psock1
    free(psock1)

Previously, we used reference counting to address the concurrency issue
between backlog and sock_map_close(). This logic remains necessary as it
prevents the sk from being freed while processing the backlog. But this
patch prevents pending backlogs from using a psock after it has been
stopped.

Note: We cannot call cancel_delayed_work_sync() in map_delete() since this
might be invoked in BPF context by BPF helper, and the function may sleep.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
V1->V2: Use existing flag instead of adding new one.
https://lore.kernel.org/bpf/20250605142448.3llri3w7wbclfxwc@gmail.com/

Thanks to Michal Luczaj for providing the sockmap_redir test case, which
indeed covers almost all sockmap forwarding paths.
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 34c51eb1a14f..83c78379932e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* If sk is quickly removed from the map and then added back, the old
+	 * psock should not be scheduled, because there are now two psocks
+	 * pointing to the same sk.
+	 */
+	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+		return;
+
 	/* Increment the psock refcnt to synchronize with close(fd) path in
 	 * sock_map_close(), ensuring we wait for backlog thread completion
 	 * before sk_socket freed. If refcnt increment fails, it indicates
-- 
2.47.1


