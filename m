Return-Path: <netdev+bounces-186679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252EAAA04C4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2A78428EA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12AF28D83D;
	Tue, 29 Apr 2025 07:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03527A931
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912476; cv=none; b=I9plbRu8oxU3hwv+dgZ0YBGwloXJD4OH2QHR9K3JJBkpgsJtdxF+MFZGTXFxRHPjRUTE0hZxEYvKsJnH4d4tRtBQZpVeFEc8Yuu5k5O+s2AsvYfnRgl0AB1lz9PSwg6hLSTGnf2cBpZ9XVOX5v3PdN4RF2upp26z2AwiY3633iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912476; c=relaxed/simple;
	bh=1k8DD7DU6StfRskpYGO/JVOEw0YmLwAKC4vCqPkq0s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZAULKpnL6yi5lDTH7gg70LFkdUUN36+1Zqkpqw1ZBv19GdfqxTC16kEOfGXEs2qSyxszg3Sl4x995HbH0X4j9Kyno83+2Vo4wu0cq+Va68SP2mz89FMymLr8rKHOQVLmpYPcD7YmmGhTz1aI3k6K64CSEsapKCtLRbInFyZkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faT-0006KP-Sj; Tue, 29 Apr 2025 09:41:05 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-000E3D-1W;
	Tue, 29 Apr 2025 09:41:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-00CY6o-1J;
	Tue, 29 Apr 2025 09:41:04 +0200
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
Subject: [PATCH net-next v3 2/4] net: selftests: prepare for detailed error handling in net_test_get_skb()
Date: Tue, 29 Apr 2025 09:41:01 +0200
Message-Id: <20250429074103.2991006-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429074103.2991006-1-o.rempel@pengutronix.de>
References: <20250429074103.2991006-1-o.rempel@pengutronix.de>
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


