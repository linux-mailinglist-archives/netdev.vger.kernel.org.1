Return-Path: <netdev+bounces-115494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79849946A80
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89EF1C209BF
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1161509A0;
	Sat,  3 Aug 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OegF3oDw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F214F9F1
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700550; cv=none; b=Ob4a9vrYLLq9ka/GWv/ZGGFgqaYQqkI+85iNHpEw8b6hpIYGkdNIfZhjORV5DcWSry//L/7WGDjkYjMN2hMKqlZshMkP8gsB51qlxArnEe54AJE/Bjfy2Nl3xNXnbw+IYydYbSmBIenxJKKtGuMuI6ByJi7OBk3Ecz2MKi0pd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700550; c=relaxed/simple;
	bh=u3EQ9Hj7ZpnXiYJks0rhhPCwobubc2eRs6Hz77ELYH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTq3HRtjcNwDJUeEKxmKDd3RwNMDOQLqgv71bD10Od07Qew9+Q7E5/tSPgvwBhPriylr/hjBSG9LRzvjYHyL74HdRldiudA48/j4KFdBSCHYOzfXeStt6bs8BDnE7W9X3V1i3QwhggM6uCiX9uS1cENiBs9dzQ9FlBvfTgujtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OegF3oDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181EDC4AF0A;
	Sat,  3 Aug 2024 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722700549;
	bh=u3EQ9Hj7ZpnXiYJks0rhhPCwobubc2eRs6Hz77ELYH4=;
	h=From:To:Cc:Subject:Date:From;
	b=OegF3oDwUVP7XT3NxlL4UZEkAs0U5hh1f3SZ8NmenH38ekuzrkAycs+uq0TPHc6nT
	 P8pUo/E4xdWyH3lMV7gnKCsBL4iwjlcObPE8+nOHFZTQIGGny7A8175MQYSxRb2lNW
	 bJ0hOifz2wRJ45FqUhxK+b4692iUxTQ54qKIOOm82W6mDCudxtrk0hTx6Ig9N7p9a9
	 OIrehwUx1vk8386PKpfR0pneV5HLDkoCHTeQpOoPiIGbFLHMCslWIFDKR4cYxoo8qU
	 ZyN5yIozgn0dJf7GnO/tc5snrIhsU7Ir4xl71AQIngiaY/cXyN0dznXjYFERd95Goq
	 /Yj7p67ijxXEA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmai.com
Subject: [PATCH net-next] net: airoha: honor reset return value in airoha_hw_init()
Date: Sat,  3 Aug 2024 17:50:50 +0200
Message-ID: <f49dc04a87653e0155f4fab3e3eb584785c8ad6a.1722699555.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take into account return value from reset_control_bulk_assert and
reset_control_bulk_deassert routines in airoha_hw_init().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index db4267225fa4..1fb46db0c1e9 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2071,13 +2071,21 @@ static int airoha_hw_init(struct platform_device *pdev,
 	int err, i;
 
 	/* disable xsi */
-	reset_control_bulk_assert(ARRAY_SIZE(eth->xsi_rsts), eth->xsi_rsts);
+	err = reset_control_bulk_assert(ARRAY_SIZE(eth->xsi_rsts),
+					eth->xsi_rsts);
+	if (err)
+		return err;
+
+	err = reset_control_bulk_assert(ARRAY_SIZE(eth->rsts), eth->rsts);
+	if (err)
+		return err;
 
-	reset_control_bulk_assert(ARRAY_SIZE(eth->rsts), eth->rsts);
-	msleep(20);
-	reset_control_bulk_deassert(ARRAY_SIZE(eth->rsts), eth->rsts);
 	msleep(20);
+	err = reset_control_bulk_deassert(ARRAY_SIZE(eth->rsts), eth->rsts);
+	if (err)
+		return err;
 
+	msleep(20);
 	err = airoha_fe_init(eth);
 	if (err)
 		return err;
-- 
2.45.2


