Return-Path: <netdev+bounces-155917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E82A04596
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7403A2D45
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7731F6694;
	Tue,  7 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE3PFc30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E161F3D35
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266135; cv=none; b=o82gj4WNEBI27BWqdevb3MF/IgiMsZM3IIsZg9+pstQYErIQCL94ndZS6lkEHqBbTv8rL5TZwTQFqfcT/0zcBZIpnNQbl1hhxFucDpR5CqYjWZ3QmpqzSRvsOYvvR1fovB8sg/JU6M2iegyKRm96cYKK6NWpFQzxhHe0A/ATmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266135; c=relaxed/simple;
	bh=TCftcPjxxAmMcqKD4/EjMiLIed1/mQMcaL+/BN4p3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkELemkW2TJO8Xzk53G9RKuHIAZzHGwOWgwx/V13DysUpnxqOG31b3mFNp+0cFL27N18vVurMCxCGFxt5sOYdEGrf+ZqkCXWHEww4LosHYed8z9ZwhuOqkCu+c8t/fBLtzZB04K/r1KpmBfcbIb0JynYhuAWjRyzPm0VK3CVpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE3PFc30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADDAC4CED6;
	Tue,  7 Jan 2025 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266135;
	bh=TCftcPjxxAmMcqKD4/EjMiLIed1/mQMcaL+/BN4p3z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE3PFc30c72G38/3sj2I8KMlDKpuUgxctQJA0vSsZbzIXw0Nqs0oXPiwLCpzIPmpR
	 V69bHV/aabhIZBOaNlaOwnUvXoxaptW0SYliOPffVUnnSMrFBtAKqSkuFgj0i6Gw2v
	 bSzBdzktubjNTinAzG1W2yYJZ7wtHNoOnaP1uuiEfYP4MOKsCj2s9JD5vG9a8R24gg
	 vbj7uB4BlwZO4zJi3yzugiJVRTV9MSOPI0R1WkbtcPSF50Dq9Q10MwDZC452XtlESo
	 2vBV3lEEtSKt3gAPC2j4p+zh5xEiDSbSV7QDFjiTcVDJDzEvKg5DiItJnUbypBWUNe
	 9Ay1Acuxczf1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/8] netdevsim: support NAPI config
Date: Tue,  7 Jan 2025 08:08:41 -0800
Message-ID: <20250107160846.2223263-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link the NAPI instances to their configs. This will be needed to test
that NAPI config doesn't break list ordering.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e068a9761c09..a4aacd372cdd 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -390,7 +390,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = &ns->rq[i];
 
-		netif_napi_add(dev, &rq->napi, nsim_poll);
+		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
-- 
2.47.1


