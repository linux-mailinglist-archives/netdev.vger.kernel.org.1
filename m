Return-Path: <netdev+bounces-172473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DAA54E41
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477D18969EE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE41898F8;
	Thu,  6 Mar 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2vMeqoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8436188A3A
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272716; cv=none; b=F8bwPGiaiKMuuLtNtdPxGR6PCvKMu7mG0dVDzIdpAqqUIKkHtUyEcg8F9n15nfvo8CEUk1md5HvifgH1z+4x1PKpo3LIpDGlXoE+Lp92XGl9YD3r0hH6AS6cx9mzBSWJYHRjb3/Jn224nIeib5APCXDZ9k+YTrlkkHl8J5vrVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272716; c=relaxed/simple;
	bh=pZD5+FKf489Ek4xyFEA0QP+4zWBIgSXx0xB0YLy6RZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgBNVvoFIow7ZpgoERTJY8P9Hqibjv3OPD6J4t9XKp+5b08cOr5GX3Crbmvmgt5VZEe7PvQiXBw+wdlCPuYx800S6mwjmPINylNll9N1fRLRQPhdqFfoX4kKLJx2p2D98zPS4J/bFAYjhMYv4EyLzmNC9Uqf0InUfLQpmrPmQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2vMeqoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B04C4CEEA;
	Thu,  6 Mar 2025 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272715;
	bh=pZD5+FKf489Ek4xyFEA0QP+4zWBIgSXx0xB0YLy6RZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2vMeqoebbMw7uEtl2mfO6lbmKWN1xQI4FqPSiimnJlNuGjLRr1Dn4bGXSAwF7Yb1
	 AAZoLsySHZttxgxF2aYTH5ua/ebIJgyghTik7CGMsdNvMhfj98rzOOX8uFWrgNGmc8
	 Fq6Oz3IFHZv37XZSM7uWg1OO1n3Lc2+RvwCaCAwLwJtfTmv6phaP7jhi0w64ySbbJz
	 /IZbTSU6/d2UNeQUT7sYLvff2qoJuGtaAtmRvmW730JV1nX782bvapxwtb8QrrU8/x
	 69U8xHaZLG1mMZKQAZkQbMh7MKIoAqL9wmxozUrhnVhrG0hcbbx8QGvGPU0K1WhxFx
	 bBsCKFdFgfu/A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] eth: fbnic: link NAPIs to page pools
Date: Thu,  6 Mar 2025 06:51:48 -0800
Message-ID: <20250306145150.1757263-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306145150.1757263-1-kuba@kernel.org>
References: <20250306145150.1757263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lifetime of page pools is tied to NAPI instances,
and they are destroyed before NAPI is deleted.
It's safe to link them up.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index aba4c65974ee..2d2d41c6891b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1316,7 +1316,9 @@ static int fbnic_alloc_nv_page_pool(struct fbnic_net *fbn,
 		.dev = nv->dev,
 		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = 0,
-		.max_len = PAGE_SIZE
+		.max_len = PAGE_SIZE,
+		.napi	= &nv->napi,
+		.netdev	= fbn->netdev,
 	};
 	struct page_pool *pp;
 
-- 
2.48.1


