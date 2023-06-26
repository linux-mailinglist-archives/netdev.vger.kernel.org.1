Return-Path: <netdev+bounces-14098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB073ED88
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCD51C20A17
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304715ADD;
	Mon, 26 Jun 2023 21:51:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECF171A0
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FB4C433C8;
	Mon, 26 Jun 2023 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816269;
	bh=pHx28e+t/THsLVmMcAyCtSXYbf++yJVnrB+rJRRiExk=;
	h=From:To:Cc:Subject:Date:From;
	b=p7nXdoL9YPle0EihfnFaIgVK5IMdrlP88DBz0ACj9UvrQQJxwVrNx88i1CmTdQC/A
	 gwEICeYIeSE7RIi5zl+KDttr3Tq2UL83L+3FZpbt2AzB0aff6cBeSDROMtmkFstfsP
	 U0uZtBN8f5l/cqN7aApdS4e0keKL8CM1Rt1KGmmkhTPB/8jgc3/MHf/obRe+GyfNqJ
	 gLJEZzPkwcktl/uCrIxnodQRmzHafzCmxIcvxIZCI3EbpZxVsv7uzgDn7B1QeiFrrN
	 VD5KRmYjQ6v6/ik991BG9RJqj+dSpKIo7WNGdt96MqSiw++R0+iz5OKNkR/A5CajUL
	 NE0V6GKRWVv1A==
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
Date: Mon, 26 Jun 2023 17:51:01 -0400
Message-Id: <20230626215108.179483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
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
2.39.2


