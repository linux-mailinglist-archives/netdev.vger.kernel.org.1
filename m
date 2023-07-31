Return-Path: <netdev+bounces-22902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DDA769F0A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C96B281558
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2481D2EE;
	Mon, 31 Jul 2023 17:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119019BB2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 17:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55807C433C8;
	Mon, 31 Jul 2023 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690823522;
	bh=BLrmPpdR4m+SM761OvA9jo6yXuOO0YGcJ3ce9wlZ/cc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ry2dA3FRtJCxO42kwWtDlRJ0v5LAfWYq5Iw4c2xRGwFs3mA4CBeQjifcWEyLRb74M
	 P6gximCZiGhfr9v6Ru2em2ag+Kg59Iw3OlSOoiRDQxuujHOLTQcqFqpUkMDX+aAyJM
	 eSe+0A9lsTE9tlJfbWYlFn1mCzfpghJuZ4rjHcgfGeAcNr78LrCpV5xjahLRspZH5a
	 bH45CcCVK13aAur3hfe/y9/GUUh1E2ssZn0kK2/OpD5dHzHsWn4jg9fRbgkOpVXH83
	 LUS5PlVyBXpv5pVBzkil8Z0rFgEhlpDiv4U17jVIYXbQ2c4h+qGFwtysePFtU87JXO
	 lRD+BZTICbQNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	leon@kernel.org
Subject: [PATCH net-next v2] net: make sure we never create ifindex = 0
Date: Mon, 31 Jul 2023 10:11:58 -0700
Message-ID: <20230731171159.988962-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of allocating from 1 use proper xa_init flag,
to protect ourselves from IDs wrapping back to 0.

Fixes: 759ab1edb56c ("net: store netdevs in an xarray")
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Link: https://lore.kernel.org/all/20230728162350.2a6d4979@hermes.local/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leon@kernel.org
---
 net/core/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b58674774a57..10e5a036c706 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11271,8 +11271,7 @@ static int __net_init netdev_init(struct net *net)
 	if (net->dev_index_head == NULL)
 		goto err_idx;
 
-	net->ifindex = 1;
-	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC);
+	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC1);
 
 	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
 
-- 
2.41.0


