Return-Path: <netdev+bounces-34173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18937A2725
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48A61C209D3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBF18E36;
	Fri, 15 Sep 2023 19:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB319BD3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA574C433C8;
	Fri, 15 Sep 2023 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694805881;
	bh=MwqHe4JvGzG4fmXR069X5g/4C9oJN5CAAugIujwOjR0=;
	h=Date:From:To:Cc:Subject:From;
	b=Yzd/ccnw/jpnhpn+bE/Ms49Rl7aD6/8TKdway2v9+BbVA2BAJHLITBjaVZf9X77d1
	 fU+KDmmLjj0MQ8T2Mjxo3bnrw4On0yYxWpN7lDPbcFBBg7OaZdmNbiEtNOEUXZw4VS
	 r2eAOmzguYLY4oInOGggWoYmLIBLqkhGHmzQfeheLjJobKWnKuv7zablUqmUb7/+rG
	 BkX7+nO5HB3LOTJOPxfK/wZpcti98WWvttp/qWrJ1sEWdA6UlumNi8MXGTS7zkM1Go
	 KhrefT0si+o14upI4rsCpe5yY63ovVia8VBZge93yijsrHO7EA0iZcK4VT9vkCb983
	 5WWKjHrnJeSkw==
Date: Fri, 15 Sep 2023 13:25:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
	Geoff Levand <geoff@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
Message-ID: <ZQSvsLmJrDsKtLCa@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/toshiba/spider_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 50d7eacfec58..87e67121477c 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2332,7 +2332,7 @@ spider_net_alloc_card(void)
 	struct spider_net_card *card;
 
 	netdev = alloc_etherdev(struct_size(card, darray,
-					    tx_descriptors + rx_descriptors));
+					    size_add(tx_descriptors, rx_descriptors)));
 	if (!netdev)
 		return NULL;
 
-- 
2.34.1


