Return-Path: <netdev+bounces-205977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCFB01014
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D565C3A42
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF24382;
	Fri, 11 Jul 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtseUfnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38215376
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192690; cv=none; b=Ued5qWhQFlK7HOk3CCeBXudgLm/gMzVzA8N2/3ZJDufJkf019wUgHT8d2YePjRL6LfwH0JOYBzEdgb3SA3FIIaMxJjNCOWieQ1G9ny+TfuCdItIfDYWklXC8OZKoL25Ew44x/opIsVGJWWIi3KuiBgxfuFBhI8NiZlOg8i7DRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192690; c=relaxed/simple;
	bh=ryjwrgI3uHa0nczx1fxEUIPbLXts+xCcD5FjplanMfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KD83+RnXmJp13oDdNpbeLl8vjr5zbAYKODlARvC7rhYLNa7b3P2eRnNAO/FCNT+ftAy7oGnY49+OKM8Wr4Al93l6J+ZEuZS5zHFeofZPVwdpF4QwMfFyUbGJGbYaSRMAv+V+XdQyVWhPj8pDjEKoDEhWlePbjUaKqT8cHwITMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtseUfnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49069C4CEE3;
	Fri, 11 Jul 2025 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752192689;
	bh=ryjwrgI3uHa0nczx1fxEUIPbLXts+xCcD5FjplanMfw=;
	h=From:To:Cc:Subject:Date:From;
	b=QtseUfnd6pu+EGbRBx5Il7M4g93zIYHEQ5yY0WRMNTUGITEAjG/E3AluKZyDrbPZu
	 YcmLzfyFYGfGifJwMpxLr4fxVkhPiYc5ugsBf3JW4bz1p1nugq/cfZcD++10GyCE8t
	 u/8syqb6vKv1VX1HHeMFgPKUF2gVjcV7JjohsuUpsJ+VbdK+0c0veWNBkZitvkCWWt
	 il1DRGwwO2mp+ukjZFRhLJMsu8QUI3B+FpC+yj50qidewx2DzjzUt9JWu/NjXbJ9Kv
	 mkT2YoPOBcle+nt2MleT7GNDsURwxpj0oO5FMZjgLxdtAu99y1A1HG/3KmXolOJQpK
	 f4TkinJqcY/Sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	kuniyu@google.com
Subject: [PATCH net] netlink: make sure we allow at least one dump skb
Date: Thu, 10 Jul 2025 17:11:21 -0700
Message-ID: <20250711001121.3649033-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under Fixes tightened up the memory accounting for Netlink
sockets. Looks like the accounting is too strict for some existing
use cases, Marek reported issues with nl80211 / WiFi iw CLI.

To reduce number of iterations Netlink dumps try to allocate
messages based on the size of the buffer passed to previous
recvmsg() calls. If user space uses a larger buffer in recvmsg()
than sk_rcvbuf we will allocate an skb we won't be able to queue.

Make sure we always allow at least one skb to be queued.
Same workaround is already present in netlink_attachskb().
Alternative would be to cap the allocation size to
  rcvbuf - rmem_alloc
but as I said, the workaround is already present in other places.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/9794af18-4905-46c6-b12c-365ea2f05858@samsung.com
Fixes: ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kuniyu@google.com
---
 net/netlink/af_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 79fbaf7333ce..aeb05d99e016 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2258,11 +2258,11 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
-	unsigned int rmem;
 	int alloc_size;
 
 	if (!lock_taken)
@@ -2294,8 +2294,9 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
-	if (rmem >= READ_ONCE(sk->sk_rcvbuf)) {
+	if (rmem != skb->truesize && rmem >= rcvbuf) {
 		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 		goto errout_skb;
 	}
-- 
2.50.0


