Return-Path: <netdev+bounces-153553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988079F8A46
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479891892FCB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998C3BB48;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CALjRRDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C735948
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663169; cv=none; b=MthtexBEOpE8NYJ2q0FI0aP8j9WGx4riyokNuzr8Ie8HwczQbJJGzsxp1pefuMKYZl3CjsYvXokqVO56C7NN5aH8+7aayJAdMmw/y0XFm16zWp8MO06LXPuGxJdBTF/BEUl49JDyTp2+Rvl5Ua0zcd7ZUTcEgLfLng72vuFy8es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663169; c=relaxed/simple;
	bh=sNy69BjylagPR4TUSI8UBi3bBWpGhClRcB8EIGNtyUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjxX014TUyXsdX1Eh4yfjlJ0SGP+bsZj9jf4Omo3dbqnUbQQa3TIGBwwPr2T/bWAXQLhe+pLaCN0W6Tz1PkNf81csfZ4w7a9zTn0uHKgIE9ghDUV1CTBGdFELyAZ0d9iq2jj10w/ZlTI8lfVKJwfA1S6X8kdRLievJTepsx/LvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CALjRRDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F79C4CEDE;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663169;
	bh=sNy69BjylagPR4TUSI8UBi3bBWpGhClRcB8EIGNtyUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CALjRRDX8bWEI5t6Y+RNN5tdkPcZl1W8v/xnRHZoFm1BBW5GsRDDmCOKHT6t9FOqu
	 jr4+RLxW/of+ZLmcPGWWfUjoTeQfsnODuzzOPVxjZYeO4VqbUXHme9KjLNXw/1S9Y6
	 tLULkyeCdv+A9eWlwdYguJ3LrAjjVloO1EU9seQQp+Ryenc4QZj4w3wsamvwOYwRIS
	 nTkszeDERp5vjDPqmYX9lQOoNEGKGHkXqxG0UyQWlM9uLEVHDwm5YHpdOdk3gtNcIb
	 uTWv2/W3orgdoxKRCtzhnikUa4+r1vQ2YEHqAHmQ2XW9z//PFxk3BV51ARYyVWW06D
	 R/BWxW4rYz4nA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/10] eth: fbnic: don't reset the secondary RSS indir table
Date: Thu, 19 Dec 2024 18:52:34 -0800
Message-ID: <20241220025241.1522781-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secondary RSS indirection table is for additional contexts.
It can / should be initialized when such context is created.
Since we don't support creating RSS contexts, yet, this change
has no user visible effect.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 908c098cd59e..b99c890ac43f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -13,10 +13,8 @@ void fbnic_reset_indir_tbl(struct fbnic_net *fbn)
 	unsigned int num_rx = fbn->num_rx_queues;
 	unsigned int i;
 
-	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++) {
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
 		fbn->indir_tbl[0][i] = ethtool_rxfh_indir_default(i, num_rx);
-		fbn->indir_tbl[1][i] = ethtool_rxfh_indir_default(i, num_rx);
-	}
 }
 
 void fbnic_rss_key_fill(u32 *buffer)
-- 
2.47.1


