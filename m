Return-Path: <netdev+bounces-152794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985F9F5CCB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47231658C4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000312AEED;
	Wed, 18 Dec 2024 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9ZCbw2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9117C6E6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488717; cv=none; b=vCtFKX0TU5/ItzUNWuEj+FYrnDfQgUJMRiZk/wYVkv//LEWHXqMWOipjArfNMuTqECuvlBGj0kRyL6csGTDm8ZA2/iCIip3Csq4JPdHj55op7A0Yw5RNNDo8Dt7n99yNeMkBYKZgYsZCgE9iY7ysgik20l9UvP+2CNFhB4JsXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488717; c=relaxed/simple;
	bh=qtbM+6F2WP6jE5aDSwvN90eG9nTdL1OXMn2dS9lpoPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGCpmZZY4nMau+aTtP+zCdodr2TqT/hXXxkjwzQb5E2VbC/s4yb/H+ykcIYWaA0IvgaAD2B81ZQD+LVe3W4/VlTyjQuSxtwxCPXV1bTTUjZqJU9UwXXAhQdGhpreKhgpm3Qgt8xV/qqcP4X+dhwvkGxfVOfzDQvtbdbcdAKQ27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9ZCbw2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A2CC4CED6;
	Wed, 18 Dec 2024 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734488715;
	bh=qtbM+6F2WP6jE5aDSwvN90eG9nTdL1OXMn2dS9lpoPM=;
	h=From:To:Cc:Subject:Date:From;
	b=m9ZCbw2sYFU1IwVn53JITMWUsaCfl0RNPFGsXViAIKN6mRoUSydRfpzucnes6CZn4
	 Nr98RdpNDKH4EY6yot1is0ko/OxZJ7DyvHNWIQgBmxPs0PVre+wduoCKt6tJs+PxhA
	 0KNCqXGCasMKXg86RQWnswlrh+mQAY5khDe9WAxCb0fJclAwlrXCyA+1iAnoXNs/gj
	 7prCt2ssh3XF1gcBvnZr89+oQNB61kbEt8Cr+Jp2RhwphdB/lCiblrzl/BKt5gbz6+
	 8Tl/Aj4X8fswnF9EUxfVkiOCakxDlHFJRtk6b5bBzck3O9+vpubmvafj9irCxoSsd2
	 87dZYXycea3JQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com,
	jdamato@fastly.com,
	almasrymina@google.com,
	sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: [PATCH net] netdev-genl: avoid empty messages in queue dump
Date: Tue, 17 Dec 2024 18:25:08 -0800
Message-ID: <20241218022508.815344-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty netlink responses from do() are not correct (as opposed to
dump() where not dumping anything is perfectly fine).
We should return an error if the target object does not exist,
in this case if the netdev is down it has no queues.

Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
Reported-by: syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: sridhar.samudrala@intel.com
CC: amritha.nambiar@intel.com
---
 net/core/netdev-genl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9527dd46e4dc..b4becd4065d9 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -430,10 +430,10 @@ static int
 netdev_nl_queue_fill(struct sk_buff *rsp, struct net_device *netdev, u32 q_idx,
 		     u32 q_type, const struct genl_info *info)
 {
-	int err = 0;
+	int err;
 
 	if (!(netdev->flags & IFF_UP))
-		return err;
+		return -ENOENT;
 
 	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
 	if (err)
-- 
2.47.1


