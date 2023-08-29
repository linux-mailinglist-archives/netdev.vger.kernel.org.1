Return-Path: <netdev+bounces-31266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA878C605
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F791C2033E
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A01774D;
	Tue, 29 Aug 2023 13:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE017AC2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A54C433C9;
	Tue, 29 Aug 2023 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693316019;
	bh=+lDlZIwh9YO+GWW5KUibHH5CjJc9m+CI/kUqVP0XdAM=;
	h=From:To:Cc:Subject:Date:From;
	b=fnjlvntQNAyKCxisJZLZPnat7PoUWpFzyetmOXJ3hO3KkbYqpGyCCyHBYWc/sAcle
	 0X0sb6gpz+px1+wAz0ooc4nqexAQ2/3Q88tDk9gEgKcwiojIu6oSk7Xo9rVWjTHumC
	 unH0/3Z6aH72A+GHajqiKSmcduvgg86/7inlSZ/b1lTdFjHEyuhYb/FP71hON5JA/E
	 Eqn+BkaOduQhKeeKYVpt17wTZVjWuxkokO3NFQVzJOIa/6EXFDeOxyMGHsa2AtfeRa
	 SiEila65LT36fUevnfPgw3YtKvjuSBrLFCf/b6sHqeR9jppBUrsZwtC6Kiz8G+W/ug
	 J4RRy7unv0lCQ==
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
Subject: [PATCH AUTOSEL 5.10 1/7] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date: Tue, 29 Aug 2023 09:33:30 -0400
Message-Id: <20230829133336.520573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.192
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
index 91b35b7c80d82..96059c99b915e 100644
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
2.40.1


