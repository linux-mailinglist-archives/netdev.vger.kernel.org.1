Return-Path: <netdev+bounces-67921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4FF84560A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE9DB21039
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22615D5A0;
	Thu,  1 Feb 2024 11:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5115CD52
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785827; cv=none; b=kYlhkZOv+YrTcRWh/0LpDz16Y5DArUK8BcxTtyszxwVhjkgiV2oxNEY8aPhGrAjtJXzFG3lGSdF6W3xEsosprOxtI5oih+GOKQpYEWv4ik+eQa8BV9xy+QIy9j7OP2qfG5TGQF0AgFoWVzosyIhYju+tS+B59CAnemXd/LLYPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785827; c=relaxed/simple;
	bh=34fKo13Xj1sg55oH6sHEl4b/gmBSQLWbKtJdKGrZl8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH8R0sqJj5qiWPRTzWz+6akWKonZ6My3JAcTZ/utD01OvqzCltwayMcjbm13oI6TSrxONDbSGUcTWiOGZQ1kv9m4brBAcMmbRsRtlnxAZuyfjxz+e6FpvK7fhMWu+89Rxua6SSgPLw0mYk3W5HXCgKdhfMozfQSNggz2FFxSSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59712C7d8D89318FB9d63b559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E868FFA9A3;
	Thu,  1 Feb 2024 12:01:16 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] batman-adv: mcast: fix memory leak on deleting a batman-adv interface
Date: Thu,  1 Feb 2024 12:01:10 +0100
Message-Id: <20240201110110.29129-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110110.29129-1-sw@simonwunderlich.de>
References: <20240201110110.29129-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

The batman-adv multicast tracker TVLV handler is registered for the
new batman-adv multicast packet type upon creating a batman-adv interface,
but not unregistered again upon the interface's deletion, leading to a
memory leak.

Fix this memory leak by calling the according TVLV handler unregister
routine for the multicast tracker TVLV upon batman-adv interface
deletion.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Reported-and-tested-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000beadc4060f0cbc23@google.com/
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index b4f8b4af1722..14088c4ff2f6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2175,6 +2175,7 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->mcast.work);
 
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
 	/* safely calling outside of worker, as worker was canceled above */
-- 
2.39.2


