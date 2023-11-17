Return-Path: <netdev+bounces-48741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F277EF658
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D412812B2
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCFD537;
	Fri, 17 Nov 2023 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5XcwCnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA94314F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 16:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B380C433C8;
	Fri, 17 Nov 2023 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700239185;
	bh=+JrmKj3mBKSiC/k/Qe2Mzlg1mFGKhEnoV+aFAXa9hqA=;
	h=From:To:Cc:Subject:Date:From;
	b=c5XcwCnXEdDMdJeSehfgv1oU9+7vZb0AJtrzZ/uQ3G5PXj68UHxbSCyFvUAbe0tfT
	 afAlYzOS38cFD0crs6UlDue3C+pIgVYyRGLR3ESgnWrbbrgmGSNwHnLdL5vYcjeqet
	 jT6SRZ7zU3FilJmLJTtTy2DVNBZnEAhzjpQjmQ7J1pK4WV8J3JVt6+rnN68um2ilLx
	 eW6X4DkzLOhCdAzDe7+0EIFX5BhV7OS08V4DN1fYx7w3yMh7iLn8+P1g3DCsY3EccG
	 XtGlk7okjytQYjFWOY9YI0LYsRqJxi1j9F70reNE32qpaBJnYAp+oBaDuu8BNm38G7
	 WNZUi64S1afhA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: rely on __dev_alloc_page in mtk_wed_tx_buffer_alloc
Date: Fri, 17 Nov 2023 17:39:22 +0100
Message-ID: <a7c859060069205e383a4917205cb265f41083f5.1700239075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code and use __dev_alloc_page() instead of __dev_alloc_pages()
with order 0 in mtk_wed_tx_buffer_alloc routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 9a6744c0d458..2ac35543fcfb 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -670,7 +670,7 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 		void *buf;
 		int s;
 
-		page = __dev_alloc_pages(GFP_KERNEL, 0);
+		page = __dev_alloc_page(GFP_KERNEL);
 		if (!page)
 			return -ENOMEM;
 
-- 
2.42.0


