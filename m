Return-Path: <netdev+bounces-220202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA5B44B96
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BBB7AEFFA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A621767A;
	Fri,  5 Sep 2025 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJHHUUnp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FB14E2F2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038980; cv=none; b=k7uQEHTX6jNzn5/bg/3xuySTVmXgA7vB8B+MI85wPjsLkd+tmTSv1LThs5GWZmfg9Zh4kY5vC5+CNrXF3CMLLmUil4incoQ5AwHhyzXMlWfhCUKGzr+d0vRJEatJpmKXLrMrIVIdVbP8NPLegu6jDzxGW6brWx0mUs8gCClF4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038980; c=relaxed/simple;
	bh=sTJSZTGmoQv9sIlk+O2zIN5HT7zJGMfeHRaOAn569CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sp2y5H5RYNz9YIPdkVUfNka7amlVVFERnnHUWriMLr6O7bOJK7BX4PuHThAZWMIEsi8IX3XHoBdQhGQGiQy+1oy5jatZzDCKK4WvFzahvm94zreXsBosuJJMd6OiDp3ovcA5PqkTyVQsQKC9NfUAR2b7tO5qEKIPU5XMAfvW3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJHHUUnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E3C4CEF0;
	Fri,  5 Sep 2025 02:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038980;
	bh=sTJSZTGmoQv9sIlk+O2zIN5HT7zJGMfeHRaOAn569CE=;
	h=From:To:Cc:Subject:Date:From;
	b=BJHHUUnpc8fP/XYvXPV2DL4m7VacBD8mXC5O/lIjgUggsl2rekeurvOrTsQD6+7Jz
	 nO+P54ACaEYf37Tgl2L45jpEchv0wde713LTBzr6LY8QM6/jDMJYRZh3dvzNlzSzyX
	 CXUwM91049Rnutqq5IC0rRvgvTxG+BJMWJvOxaN316aBxCosVF+i5XOGlrW3JgCuOO
	 f9mLEBHHpCdGMcSoTA0KE5hJ/kdKx2zipNeT4PR6Jesnc9QYquGNPvivkj7xAwRTfY
	 Vikhmcri2BkISCx5Yi95JoXVDjM55I3Pe4tXBKaV+f6UrvKASauFsHuKL6AswWOPzR
	 E/jJohLpqnF0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] eth: fbnic: support persistent NAPI config
Date: Thu,  4 Sep 2025 19:22:54 -0700
Message-ID: <20250905022254.2635707-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No shenanigans in this driver, AFAIU, pass the vector index to NAPI
registration.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 493f7f4df013..ac555e045e34 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1621,7 +1621,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	/* Tie napi to netdev */
 	fbn->napi[fbnic_napi_idx(nv)] = nv;
-	netif_napi_add_locked(fbn->netdev, &nv->napi, fbnic_poll);
+	netif_napi_add_config_locked(fbn->netdev, &nv->napi, fbnic_poll,
+				     fbnic_napi_idx(nv));
 
 	/* Record IRQ to NAPI struct */
 	netif_napi_set_irq_locked(&nv->napi,
-- 
2.51.0


