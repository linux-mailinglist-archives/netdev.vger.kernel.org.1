Return-Path: <netdev+bounces-45129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517BB7DAFEC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F8281254
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76412E6C;
	Sun, 29 Oct 2023 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjTET/eK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCD15AC0
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E6EC433BF;
	Sun, 29 Oct 2023 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620464;
	bh=G+x1b/71Vpy6RjjeRi6tweidqNxWP69rwQCKh25RYg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjTET/eKOdchQ9y39RFwDcdhqcv/Lqx7EZGo6FgKsvXpvkgwmm8nigtCMxYuan01f
	 AHvNFAxU6u/bUmSNbAFgKbhOKoIAs+r/XXEzPCjIdlVlclNGqQwukWyQKDHjGRdfob
	 jiloxpbEAM1jIAISgjjFnyBMzjeN08ValbXAriPzizfbw/xxlTUllHEYiRxqmO9k06
	 ZaQyIuhxMYwcFb76L1QrgJAu7E0skt+eb4z7D+6VuF7DI0kQqaUT8Wh3HtU6fQzJpc
	 FQjzLFqwMK6zsWtTASoDaJzyOm/BmCdABp2+rp/K5rVb3DoSAcZttywodXqeuCFt+k
	 Yxoeul7alJBmg==
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
Subject: [PATCH AUTOSEL 5.4 03/13] net: ipv6: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 19:00:36 -0400
Message-ID: <20231029230057.792930-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230057.792930-1-sashal@kernel.org>
References: <20231029230057.792930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index b64791d3b0f81..a1cdb43e72167 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -506,7 +506,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


