Return-Path: <netdev+bounces-19303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F775A3B9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81993281BF7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35C801;
	Thu, 20 Jul 2023 01:04:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DF39B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1D7C433C8;
	Thu, 20 Jul 2023 01:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815055;
	bh=7Pn4RbWGTh8C6+3obYSDdXV94MS/4cvNgw0YXr9XTWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHkOM7bQa9xtjHvjHWVtG8BrGLhBEQTV3yebUnTAQ+cYNvFBF1+x71XI4imFDcNsd
	 7Wi9P1bsuQh/oh3mSgflqb7ZpXjTNqcgtCq6iDfogZOlrTLVez419E7OnurbY/W7A7
	 9ro3tCooj5BcUSLJCdVqnd/qBu+o3HOCIHtzVsXHpZO8+WjrwF/3sBis4fKsgoZ7o+
	 c74KIsSNp+ma+70ybdLhntVhwmw4HONSNQFKQNgkoEW6P3b8gV2mvUiBy1SGIuVbqn
	 Lu3GBp043XwFLFgXnbyJ85o4uRv3COb3le/9cNczJjEL/jnwuslln6QYG6NFQFOIGi
	 f7CpRnCI4pIAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	gerhard@engleder-embedded.com
Subject: [PATCH net-next 1/4] eth: tsnep: let page recycling happen with skbs
Date: Wed, 19 Jul 2023 18:04:06 -0700
Message-ID: <20230720010409.1967072-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
References: <20230720010409.1967072-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsnep builds an skb with napi_build_skb() and then calls
page_pool_release_page() for the page in which that skb's
head sits. Use recycling instead, recycling of heads works
just fine.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: gerhard@engleder-embedded.com
---
 drivers/net/ethernet/engleder/tsnep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 84751bb303a6..079f9f6ae21a 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1333,7 +1333,7 @@ static void tsnep_rx_page(struct tsnep_rx *rx, struct napi_struct *napi,
 
 	skb = tsnep_build_skb(rx, page, length);
 	if (skb) {
-		page_pool_release_page(rx->page_pool, page);
+		skb_mark_for_recycle(skb);
 
 		rx->packets++;
 		rx->bytes += length;
-- 
2.41.0


