Return-Path: <netdev+bounces-45136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8E7DB008
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490FD1F21D46
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5215487;
	Sun, 29 Oct 2023 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ0pA88a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B214F94
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20942C433CB;
	Sun, 29 Oct 2023 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620540;
	bh=F+KDT330zA7lLtN8EcxqS8DGK9XLFLIFJHi7Hdj9Vl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJ0pA88a7RX74BXfWubo5PKp5h2t1NjQmMIYjzlRrJ4xP9ZBg43pfWeoJFoMm+ffe
	 ynQ7g68j5AM0pa1kD+DpeND404c9xfGq+hnKjj3I3DDCY54pBuESKLAZI/nT8/RSyN
	 HN/Om4g1NUQYPehU+LH1oTTmjBStIOR5S//9cbXACQ00H9QHpareeA4EsnbKf8HNLb
	 NiRv7+dY+uYt0LoW2G7uTfsZBOpzcXyJQkOADyy6I0vwfKiw76zxKzHKHDjKh3RWLW
	 9vbTZ/OBNt8Fzpj3HnxTR5rqf1Wjk5vMAYu3dRxQbXUtqtBQ8usLc20h3Jq4Hpr3zl
	 20jkn7+/3EnCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Ke <make_ruc2021@163.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/11] net: ipv4: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 19:01:54 -0400
Message-ID: <20231029230213.793581-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230213.793581-1-sashal@kernel.org>
References: <20231029230213.793581-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit 513f61e2193350c7a345da98559b80f61aec4fa6 ]

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d5e860573ecd4..79fa2d7852efa 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -547,7 +547,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
-- 
2.42.0


