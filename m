Return-Path: <netdev+bounces-214714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE40B2AFEE
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FCF2A8742
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8932C31F;
	Mon, 18 Aug 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkn5ybC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC972E22BF;
	Mon, 18 Aug 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540248; cv=none; b=mRduGjHhUYYegWIalUFsha7jb28beZixipxB0OqogZvdiSE0U++KpiTo/IBdxVBxJfwHyrGzsMyjEpoDUNOMy8164Amj3hywuHRZAPxnc0tbtAzq7GSuK51sVqhvNfDVwchXj38i4Fe0RoXJvn8fFyJ+VGghG0LkahZQ1T3LlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540248; c=relaxed/simple;
	bh=Xp4CQi1oRWwYMH5i+mF7dz/szvq22cKIqd3crJYwonU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIrzdxew7Ccq7BZx6HqPnzkg/VwubZuSWUExGHZrCDHPJRUZbKpcHa4IrpJ8eE4snKULj/FFwE56xaIuoWttH3iS6eN4N6iv1SIgMDlaQyqvSMSLSPDUGuQYoMTkM9+9cxmaLXdBDHrUypHF7lICEHsg4Lv0wQM+7CLYQWEpn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkn5ybC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED2DC4CEF1;
	Mon, 18 Aug 2025 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540247;
	bh=Xp4CQi1oRWwYMH5i+mF7dz/szvq22cKIqd3crJYwonU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkn5ybC9UDbyACYdSpNvRWXbAtBXwutWhD79E1Z65QmOZ5awuywoYvBwKq8kDUM3w
	 YbMZaNWtSEpTAuvt1LeEVPE4BFTOAdIwAujdeitiREUZiAiW2920rECdWJd/K6J9Rs
	 ZdjuKW3+N8K3EhPGF5dk/KcGPA7LwgmYKrBOCnNsZj1cVTrrrCBupIGL2qPCO8rAsk
	 7KE9MuDnDNkm93NniXMJhHv45tGcDx92G9Pnr8UAxbbYSLSoRd7eLQCYKIbNkLN5dI
	 1kXwI4M63cHOF0syO3s6ahR13HtH5te+H/1yVZGynoOGjLTd5CKDDvaty3n0Sen8Tj
	 0OkqXOXg+UYmQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] net: Introduce skb_copy_datagram_from_iter_full()
Date: Mon, 18 Aug 2025 19:03:54 +0100
Message-Id: <20250818180355.29275-2-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818180355.29275-1-will@kernel.org>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a similar manner to copy_from_iter()/copy_from_iter_full(), introduce
skb_copy_datagram_from_iter_full() which reverts the iterator to its
initial state when returning an error.

A subsequent fix for a vsock regression will make use of this new
function.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/skbuff.h |  2 ++
 net/core/datagram.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14b923ddb6df..fa633657e4c0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4172,6 +4172,8 @@ int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len, u32 *crcp);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 94cc4705e91d..f474b9b120f9 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -618,6 +618,20 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_datagram_from_iter);
 
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len)
+{
+	struct iov_iter_state state;
+	int ret;
+
+	iov_iter_save_state(from, &state);
+	ret = skb_copy_datagram_from_iter(skb, offset, from, len);
+	if (ret)
+		iov_iter_restore(from, &state);
+	return ret;
+}
+EXPORT_SYMBOL(skb_copy_datagram_from_iter_full);
+
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length)
 {
-- 
2.51.0.rc1.167.g924127e9c0-goog


