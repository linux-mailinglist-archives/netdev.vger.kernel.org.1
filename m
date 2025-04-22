Return-Path: <netdev+bounces-184637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74EA96A4A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C96400916
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94F280A35;
	Tue, 22 Apr 2025 12:39:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91627D780
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325560; cv=none; b=J89Rg+AAgjJhDcGRMi9dyFUA6+RA37FtHnYoL/YSXmWdWscmbyuhLENCSmJtZdlAH3SzmT6Piv56k8IWNH9pehDzyd0der74dwyBiYBxeQDatDQvF38ky1EyyI+xGrMiFdIZZ3oQFwxTXBtlZK+M6E8DSKyskDfK5xo6veMpWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325560; c=relaxed/simple;
	bh=1k8DD7DU6StfRskpYGO/JVOEw0YmLwAKC4vCqPkq0s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s62Wpjwo7Vihxx5zkeujdinz9LuXdv73uBta2kP93CZ5h6I1MWo9XoHLc7M8QfmzcxcTVW03wBNW/bQwPWBZPbmvN6W/yag5e3ydna4fSu1eAfjEF9MsN/6Y9H3/ESFjrpipFmpSS+jVtz/1Nva35S6oZhalVJtaQaOi+Z7mBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Cu0-0001wJ-Kp; Tue, 22 Apr 2025 14:39:04 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Ctz-001YQk-1O;
	Tue, 22 Apr 2025 14:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Ctz-008TQK-1A;
	Tue, 22 Apr 2025 14:39:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v2 2/4] net: selftests: prepare for detailed error handling in net_test_get_skb()
Date: Tue, 22 Apr 2025 14:39:00 +0200
Message-Id: <20250422123902.2019685-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422123902.2019685-1-o.rempel@pengutronix.de>
References: <20250422123902.2019685-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Replace NULL return with ERR_PTR(-ENOMEM) in net_test_get_skb() and
update the caller to use IS_ERR/PTR_ERR.

This prepares the code for follow-up changes that will return more
specific error codes from net_test_get_skb().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/selftests.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 9146e33db25a..3f82a5d14cd4 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -74,7 +74,7 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 
 	skb = netdev_alloc_skb(ndev, size);
 	if (!skb)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	prefetchw(skb->data);
 
@@ -267,8 +267,8 @@ static int __net_test_loopback(struct net_device *ndev,
 	dev_add_pack(&tpriv->pt);
 
 	skb = net_test_get_skb(ndev, attr);
-	if (!skb) {
-		ret = -ENOMEM;
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
 		goto cleanup;
 	}
 
-- 
2.39.5


