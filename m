Return-Path: <netdev+bounces-45112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A77DAEF8
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C47FB20BF9
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5312E67;
	Sun, 29 Oct 2023 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKdsOjfZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE12E51
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1766CC433C9;
	Sun, 29 Oct 2023 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620112;
	bh=cfI29PQJSiYahbkvtclk8BjJZ5sHHb1RQDEd7GQkkuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKdsOjfZYpUlvlsdpKo9utpvZt2kSOfdGUqQAsGvT37obDoPN8IyTAGrS0Au/4S9m
	 euwxuLWQ4SV+SKkNiXmBtBH6BbYI5tQzIu+bGDTI1GIIM6YUuJ+1mF96oGMEVHIV+t
	 vuxkdHq/5T+Y30K49Rgi9AemjESMconnM5zk4pD0Vqwqk0BKP6LOhbYuFeODyZSDiM
	 KavfT240wOaS94Q/+SdjQ64TFyS07Z8nVF+XAyd2h8fxPCFvQQtmReWM4JAsSplz0d
	 8cQc2dOlbjr29Yxf3dzFeZv9YCIblSFrQPspqf2MzEvQfBgCIAmQWX2UXb0X3j50/2
	 BdsPQG4KVss/w==
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
Subject: [PATCH AUTOSEL 6.5 20/52] net: ipv6: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 18:53:07 -0400
Message-ID: <20231029225441.789781-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
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
index fddd0cbdede15..e023d29e919c1 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -770,7 +770,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


