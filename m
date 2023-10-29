Return-Path: <netdev+bounces-45135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C777DB007
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E571EB20C40
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BD14275;
	Sun, 29 Oct 2023 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7YJLjSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBC15AC0
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE8C43140;
	Sun, 29 Oct 2023 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620538;
	bh=+VKJaBCBR/JhCoz892Wzq0BO8RG0rKGVNKUJBUsRMgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7YJLjSONCxPPHxxGYFlmsspOcl3pKTQy4FgoRct0DieXxxPeIKqgMBLFaFHwyyT4
	 0mmscH43qq3issXXNjKqGo7Uf+h+Sg2O8aY1HdJbcPGCOio9B9B3q7/5dz+NYvLv50
	 El6vh8NaWftjayt0jS3xn6pIX/24zGpAsVU15RX0jhEHfR4q5Hr32gZjCtGnRhetoI
	 M2Qg0hS1dHlGaOI5b8ytXakN9LV4ncZf1y+H/9tzG/EQ2n0A81ib2z5KsJmTUEmQr3
	 bRlmZyj5O+iJnLMqIutHdVfsUx7aL7Qko6jIDEP4VP4LASPjVCgrc3LSiY+TE3pSA2
	 rGpQ+MsIZd8Xw==
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
Subject: [PATCH AUTOSEL 4.14 02/11] net: ipv6: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 19:01:53 -0400
Message-ID: <20231029230213.793581-2-sashal@kernel.org>
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

[ Upstream commit dad4e491e30b20f4dc615c9da65d2142d703b5c2 ]

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/esp6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e19624245e167..25c12d0ccd284 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -499,7 +499,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


