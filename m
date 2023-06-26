Return-Path: <netdev+bounces-14104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD673EDC3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292F6280FBE
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588A15AE9;
	Mon, 26 Jun 2023 21:51:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA817AA5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8A3C433C8;
	Mon, 26 Jun 2023 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816285;
	bh=XzLyUG9IOF2FmNlCE9hkjcb5E8FRkyeQNTklQWGEU1M=;
	h=From:To:Cc:Subject:Date:From;
	b=s/AUWLYOAiMrgmsqvG8LnDlSGJhQ7fS/dwA5Lc4amNzZlybqZ0UyeBdYLimV/ec8/
	 vYlktqadt829irRfAzaun2NuuYhaZT2xyoLmXtKw8iXwWsYoWB0w+fjOoIISFRlCFL
	 kh7YW3We3PG4CJrNsyV4eTWU3F6USWuIf3oqlh+4G+Kv9co85vHCrfH8Afzw7Pq0Vs
	 WLMTwu5hvXYaBcYyQGCixYKzZLseWnHT8uBICUm1l0YsBWc7l6puZl6fMH2xsHQYVr
	 Uib9NXqw7gXAJ5rk+2jwPjWlr8ApZZN27PsolQrQUPquEB716mqXmiXe6y0vYuWv/V
	 1tftnYUGCNIDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Mastykin <dmastykin@astralinux.ru>,
	Paul Moore <paul@paul-moore.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/5] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date: Mon, 26 Jun 2023 17:51:20 -0400
Message-Id: <20230626215124.179666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.287
Content-Transfer-Encoding: 8bit

From: Dmitry Mastykin <dmastykin@astralinux.ru>

[ Upstream commit b403643d154d15176b060b82f7fc605210033edd ]

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 15fe2120b3109..14c3d640f94b9 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -871,7 +871,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.39.2


