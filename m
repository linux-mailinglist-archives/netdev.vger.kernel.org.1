Return-Path: <netdev+bounces-152801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCA9F5CF5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C491C165C6A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2374C08;
	Wed, 18 Dec 2024 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWFC6afv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6141F5E6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489842; cv=none; b=BPsphGIAX3TdPXr/MTKsd6UMVqV+GYG36A4G5n9qNQmfIoXXWwtqN+F02xwEB40KorLJTKPUUCKL9zk5qYYcvyzy9x7DsbGy7JGd/U5FOh8q1FN84WgD/5GRftPtc3gZBxaTUWsKp6LrANASPhtpbwV0WvjBfFLK5/oD82UZVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489842; c=relaxed/simple;
	bh=NJ3hj45/QI1VNjqAO8DnG6Uk8QvKiKB3c+2b0rXMtuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+uPTXspYu2FbIesFS3v4A8Rzurpdrg3fhhKXtjOyLjX8Q4cD3PSv+/D93NmKBpehY/FArMFkBQkq7RQM2XqxjdiDbomSeqLwP1wY4fptgU38UccT0Z3LwcFd+QPWF/Z4Tq9mtqNdhPpTuh+ug++XdXKo0U6ZtUsGWRBHqEIwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWFC6afv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752A6C4CED3;
	Wed, 18 Dec 2024 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734489842;
	bh=NJ3hj45/QI1VNjqAO8DnG6Uk8QvKiKB3c+2b0rXMtuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pWFC6afvatDVwMBpjzsygV7GiDY5+BziMthKB0HxKWBlcyKb5s1wOrynDVNo2DB4W
	 VpMLR6fUi2xS8927ZmZFybXRwdgM3HT2dXTiqJy2/hvJ2ekDUmcPS/hWy9vNFQ/3Ny
	 hAp13lBszGacDnl+NTgYW5L5q4h9olCmMaNT4KotJDqUmZzyOOSFHk1cKH34DmySJY
	 /0gllJt2BebhXldJSDwG6V/+XDZV8WepajnyY9VpUPhKVjWJaY8KICHzFV52IQIZ8j
	 rIlGNyE3ywYJwRAsGQHKcVZ7D+1kQrksDOUgguvaR2Ys0BO5lXyLlxTJJBsAnqvfji
	 f1G54o8xRW65w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: netlink: catch attempts to send empty messages
Date: Tue, 17 Dec 2024 18:44:00 -0800
Message-ID: <20241218024400.824355-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot can figure out a way to redirect a netlink message to a tap.
Sending empty skbs to devices is not valid and we end up hitting
a skb_assert_len() in __dev_queue_xmit().

Make catching these mistakes easier, assert the skb size directly
in netlink core.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f4e7b5e4bb59..85311226183a 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1287,6 +1287,7 @@ static struct sk_buff *netlink_trim(struct sk_buff *skb, gfp_t allocation)
 {
 	int delta;
 
+	skb_assert_len(skb);
 	WARN_ON(skb->sk != NULL);
 	delta = skb->end - skb->tail;
 	if (is_vmalloc_addr(skb->head) || delta * 2 < skb->truesize)
-- 
2.47.1


