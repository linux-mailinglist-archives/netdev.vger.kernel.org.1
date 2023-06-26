Return-Path: <netdev+bounces-14095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509D73ED62
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247FE280ACA
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD4168BE;
	Mon, 26 Jun 2023 21:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088815AD0
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E1AC433C0;
	Mon, 26 Jun 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816259;
	bh=7za3I3AAMC1MXB+6NLirqnu2IknXMW6JjTr9xOxreP4=;
	h=From:To:Cc:Subject:Date:From;
	b=BziKvZsfNbTp+wum7UJbic5vE9wr0raNiUN7MNgp7UnY26qZ/zapLqsaExrYNY8Af
	 1Q3QbP8rYECuKygSR0KrBJJyqhOSDWCDCplxRRpP6YUjqbqNiYIEuKMMQ+7mvdphlV
	 pAvBsc4DMgi3ItgnbNzwxCBQ6RjELvQK1U0rLEVrbR39BOwu0s2pMkvfZ5NWU9lb7h
	 UtG42Vqokba2HEjIY3+qTOPp/Z2Xuy/FGR2MuCBVanOaSrOtyXWdLO85X4E3NklmsT
	 m3q5iJ3mye0JBvhWqB/VWoYSMsvJ5+QY3VK+Dvo81Yh9DaPCNQMOaXFUM323coWlw0
	 lrH45RDb8dCWg==
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
Subject: [PATCH AUTOSEL 5.15 1/9] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date: Mon, 26 Jun 2023 17:50:49 -0400
Message-Id: <20230626215057.179363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
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
index 54c0830039470..27511c90a26f4 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -857,7 +857,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.39.2


