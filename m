Return-Path: <netdev+bounces-199852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C0AE211A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEBD3AD4F2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741A2E172A;
	Fri, 20 Jun 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuQpjHDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2A18E20
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441210; cv=none; b=DFipwY0MTn3X24Vs8mRBlv9mzsAPguFm30nxf383CGLYWhBRDIMTNekKp127WUKbWX/XVEQ41baLDvoUHCfpf7YHxuksvmoH1ygKWg7ZhPHr9B5jFM9ET8/caC6chzZ5sx021LRZSoWswr3yfjjfUrgsZcvoxTYlPPI6443rPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441210; c=relaxed/simple;
	bh=apuRfjAILr3UwRllizgGINwziCXHgCWc0UiOkhP0TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAXsqyGvX82fniAmjs5NJy/to2TgzNB+ybhDIR8v7csaCJks30qWxUiEKAFIAXowcW2NUHAoSTdnBbX5uOARRRDUWGJCZureeOaYU+6bpC+bLZjNM3UJfRH0D9sv9ZlKlTJPSyQHKcd+3/nou5l1jWNJRHVN2gksUC0p5+nb+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuQpjHDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3EBC4CEE3;
	Fri, 20 Jun 2025 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750441210;
	bh=apuRfjAILr3UwRllizgGINwziCXHgCWc0UiOkhP0TCE=;
	h=From:To:Cc:Subject:Date:From;
	b=tuQpjHDcYsknouV9/pIpJcsVHwRF5q5AwhdSXKDL1Mjqo5pmMH0UYuV0ILb239f3I
	 zj+NS3eR8l8oJbf/GRVL0+ZwUaJZngVrFCQKVH0LmfZ3fZAOOA+ROkdErcMZb6GV0j
	 Fev1s2SYu2pb7cPRBYRFZH7K/a0/5fYSYU2mgrYJGELbjn4elGxKuz/GbH4nMvG5Ot
	 p6F0ysa3ggNgbtxsDFxyICW4ZkgV4c3BeJTsqec2L3BwMaNM0amhMBY9YHcaZpQI1X
	 3X5DDb3fW8RppMpzBjm6VONKyxJR84tTjRfjPflGK1yyajEBrIM0xj3YbtzLxnkJAX
	 t36Rs0xfVmFYA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	leitao@debian.org,
	joe@dama.to
Subject: [PATCH net-next] netdevsim: fix UaF when counting Tx stats
Date: Fri, 20 Jun 2025 10:40:07 -0700
Message-ID: <20250620174007.2188470-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb may be freed as soon as we put it on the rx queue.
Use the len variable like the code did prior to the conversion.

Fixes: f9e2511d80c2 ("netdevsim: migrate to dstats stats collection")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
CC: joe@dama.to
---
 drivers/net/netdevsim/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 7f2809be5d48..e36d3e846c2d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -93,7 +93,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
-	dev_dstats_tx_add(dev, skb->len);
+	dev_dstats_tx_add(dev, len);
 	return NETDEV_TX_OK;
 
 out_drop_free:
-- 
2.49.0


