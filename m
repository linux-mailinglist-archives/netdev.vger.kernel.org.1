Return-Path: <netdev+bounces-33060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C979C9DB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA83281705
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50E1774B;
	Tue, 12 Sep 2023 08:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15786E54B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B33C433C8;
	Tue, 12 Sep 2023 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694507197;
	bh=w6mkmT4o+VVd0a/iR68vRz/nzAF+BMxy6VTKdAws6b0=;
	h=From:To:Cc:Subject:Date:From;
	b=pQIxE33Fl4/7Aw26ULpRgTvEJQIKWqhWfeIoMUR5adsYKTa7b905cbqB00qKteXAz
	 42KDgskDJFywD+y6HftX2xPPG/F7ktXmxPj+/XRynZ65k2c5XZkBeNOlLkSNRb2MGu
	 ESpdE+E3+zxpVgUXb4+tfJAk6QtWssTu101wOVJys5mGzigLV2byPK4W2bIoxXPLvI
	 Gu/1d6sGMU/EN3TnJ2aucco4oj4Tggcado+mLTgAiBJTk6oFFOIXCpSxYQqgEJk4YE
	 gGKkqE6mxb0w7TbXVEiERwqUWbEHMvaUJVyRAWvGD4PBVyT/3GEfEY9mTrhWCQRC+W
	 lPDQUbHi9XAAg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: do not assume offload callbacks are always set
Date: Tue, 12 Sep 2023 10:26:07 +0200
Message-ID: <cedc0a98fb419f3d520a38271628e5d35a01be97.1694507095.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if wlan.offload_enable and wlan.offload_disable callbacks are set
in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
on them.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 94376aa2b34c..d8cd59f44401 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1718,6 +1718,9 @@ int mtk_wed_flow_add(int index)
 	if (!hw || !hw->wed_dev)
 		return -ENODEV;
 
+	if (!hw->wed_dev->wlan.offload_enable)
+		return 0;
+
 	if (hw->num_flows) {
 		hw->num_flows++;
 		return 0;
@@ -1747,6 +1750,9 @@ void mtk_wed_flow_remove(int index)
 	if (!hw)
 		return;
 
+	if (!hw->wed_dev->wlan.offload_disable)
+		return;
+
 	if (--hw->num_flows)
 		return;
 
-- 
2.41.0


