Return-Path: <netdev+bounces-183375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFBEA9087A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92AB19E04B2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B52135A6;
	Wed, 16 Apr 2025 16:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495E211706
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820091; cv=none; b=H7QHnqa2xGsNGUOSZTpgiD6C1JSFmloZrMGD4UM/pE50r0tnEUhbRDF0j060cIP3XnaZU89rTWV3HvCVN09EieUkmP4ZQ5dvdaLy4EoshufWSPUbGIp7XJONjfV8oL0uR2ET5AOYV+t7BBoxHrDNBxcW52BXwlGVsvhLwgFPRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820091; c=relaxed/simple;
	bh=fNwmiRH0XeANoL4dIy3nW032Ca/tIxxGRC/mGgAzepg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPwOyo4I256rjKvrozbriDvigJ3juBkqYl7bOi4H8BAQAh8FX7iDIjJFKq9nIDELo7ORkbk0YwczIv/+7THmVmuQ2OnUSdm7OyEX8oZNhmSM4/zcKxZfIdKS2Kc+/UA1F6MX9u9i6uCUMk9WZe9oI2Ef3uQQESqK3Pi9HE3vDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-0002G1-D7; Wed, 16 Apr 2025 18:14:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-000c9G-0O;
	Wed, 16 Apr 2025 18:14:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-00CGQS-0B;
	Wed, 16 Apr 2025 18:14:41 +0200
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
Subject: [PATCH net-next v1 2/4] net: selftest: prepare for detailed error handling in net_test_get_skb()
Date: Wed, 16 Apr 2025 18:14:37 +0200
Message-Id: <20250416161439.2922994-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416161439.2922994-1-o.rempel@pengutronix.de>
References: <20250416161439.2922994-1-o.rempel@pengutronix.de>
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
---
 net/core/selftests.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 3c3e2b2a22c9..34e751d885d7 100644
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


