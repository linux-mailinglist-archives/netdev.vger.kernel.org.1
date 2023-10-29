Return-Path: <netdev+bounces-45124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C847DAF75
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD5BB20D4B
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E114AB1;
	Sun, 29 Oct 2023 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM3Usshm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD214A86
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FD5C116C9;
	Sun, 29 Oct 2023 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620378;
	bh=xHeb9um9iaQhOx5M0DAoAvBFBPtVgsYZG1MFY91F2Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM3UsshmQCRrFG0OIwoadziwS2sbvaoHWjP3GESHCSYCrHoNpK7eDiMcXDvO6LD+v
	 89XrIPPBRc3vOF4MTumQ0D0ifHmT6pyn1io/NQ5RPG3LwuVfHBDv3MOFKDTIMjy/Ke
	 O3O266hrOVG4nKh8A/poOywe0tFpu56k5htICEa0pJneDRDbkxIHiOHLhPkvlBAtKZ
	 XMWmdH0bMwlV0daa0OTHeL53JnyCx6inME5eA/sre/Rwz6lyyqMRBpqB+ivb40ufdf
	 4NDnEgdF2em1g+1/xCYlL9pPX4xP20CaQRxdoba8nca3gacQ+qyzkxiHi+vSYm1DNe
	 04JoJagTzEC6w==
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
Subject: [PATCH AUTOSEL 5.15 15/28] net: ipv4: fix return value check in esp_remove_trailer
Date: Sun, 29 Oct 2023 18:58:50 -0400
Message-ID: <20231029225916.791798-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index 386e9875e5b80..ca0cd94eb22d1 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -739,7 +739,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
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


