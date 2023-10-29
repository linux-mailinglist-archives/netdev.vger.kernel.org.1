Return-Path: <netdev+bounces-45133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC307DB000
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAAD2814A2
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180014F94;
	Sun, 29 Oct 2023 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXgsihZ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478F14F92
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D1C116B3;
	Sun, 29 Oct 2023 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620502;
	bh=goJV26ZqxKaajKxsSQOmOGfB5nf8mr6roUJx9ktXH+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXgsihZ9ORuZ+Uz7cUxvVw7R1VFg7Uv48wMoNF1YoejN1tHq7S/Lk2x7f1/nMGs09
	 kVqhtmYsHMsMZtc63VCk60Zz6yfGdUVtB+cOdc/oWC7i2vX6K9UN0PFMjqeBg/IiSq
	 JiOhmSpN/xkjpMQxmLkkc0JT+cQ/fX4bgf/H0eZL31JE1PodGFxpax6evZZkqlZvWg
	 ithqhmBBB6EgKtBkVGNLBKRVkqkTxbT3EjDj/DayJMPnGtZwkFflcEUl0YYV3u3L6r
	 WpqdkLqBU/KS8gWjWbuZGAN9YCELZsnULY1d2+lL0RgdrI2MEdu+yc1Ibvq7EbCCGz
	 fTOYt/248NnWQ==
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
Subject: [PATCH AUTOSEL 4.19 03/12] net: ipv4: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 19:01:16 -0400
Message-ID: <20231029230135.793281-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230135.793281-1-sashal@kernel.org>
References: <20231029230135.793281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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
index 203569500b914..24cd5c9c78392 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -565,7 +565,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


