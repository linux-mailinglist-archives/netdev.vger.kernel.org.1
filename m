Return-Path: <netdev+bounces-153627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73869F8E0B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2E169E76
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA319F11F;
	Fri, 20 Dec 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iTTDDYYm"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34E4A08;
	Fri, 20 Dec 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683869; cv=none; b=MYI9W//1N9fh1n8HN5yxwujB/t7RiKkloqYazbFsuUcz6ljjw8whDNaikmXfSKobYWOi/Ag40ABTnbuJojx7AY148H/jG1pr6IFbUhHmAhZbgzrVLA7xgTWPPYwC7HzrHOJzO6oYG+w2a99VqJQy7crqWgsQg5KdxRfc+Gvxq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683869; c=relaxed/simple;
	bh=GfW1eOLXnvcnEypM6xHp1oyMoi/lUm9NRGnOj2W3PqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mxgss5HGdf1nvVJ/0aaXobOVm7jXscn7MC64isGbQbvV1FV7uN1lvTP325PfrsAlHTzZaCUT1ARsTx605fKwc4Tn/WpMKZWzc0rOsbNLhi2SCGt3mK9IaZ+51xoexahJARQpxAc64GyAOB1W0rjQAAZIDJzz4voM6rcrzWdD000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iTTDDYYm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C04FD20003;
	Fri, 20 Dec 2024 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734683864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rbExN5sNOVOtlrv1pS4xS47539TPF/VviR6QnbVjniw=;
	b=iTTDDYYmjQTv/YQ/QT/B1Pgyz0KawLVQgjTSMbJedz92hrNNUJvcMoWpFm96l+UVoZxnT9
	uK+jyRoTKTuFK64TSAmyXWpDDiF6CCcFbXEWn3jce50KlSV1fHb9vk0FoJcZbjKbi8TkPz
	4/z8JTn/XWiyfYiInS7npsOYcDcYVA9tTR32AqoyElfck3rcR/BOFkfGn4jskPDEhrn9hS
	hHqru3qCBLrokBQV6PYC4jh0tjfGObJR9QBgjJ9vS/GFGa8WJAxNLAZ9iDc5DUFRIppmMs
	OEJPAdIlWpJ77b7MQG+V0YF1uPsQ7L4CZMmKA9kOkIIyvh+aVO4snHj++x+0nA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com,
	thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] net: ethtool: Fix suspicious rcu_dereference usage
Date: Fri, 20 Dec 2024 09:37:40 +0100
Message-Id: <20241220083741.175329-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

The __ethtool_get_ts_info function can be called with or without the
rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
triggers a warning due to the lack of lock context.

Add an rcu_read_lock() to ensure the lock is acquired and to maintain
synchronization.

Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@google.com/
Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

I did not manage to reproduce the issue even with the c repro file from
syzbot. The c repro run well on my board. Maybe I missed CONFIG being
enabled other than PROVE_LOCKING and PROVE_RCU.
I assume this will fix it only by looking at the code.

Changes in v2:
- Add rcu_read_lock()
---
 net/ethtool/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 02f941f667dd..2607aea1fbfb 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -870,7 +870,8 @@ int __ethtool_get_ts_info(struct net_device *dev,
 {
 	struct hwtstamp_provider *hwprov;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	rcu_read_lock();
+	hwprov = rcu_dereference(dev->hwprov);
 	/* No provider specified, use default behavior */
 	if (!hwprov) {
 		const struct ethtool_ops *ops = dev->ethtool_ops;
@@ -887,9 +888,11 @@ int __ethtool_get_ts_info(struct net_device *dev,
 		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
 					 SOF_TIMESTAMPING_SOFTWARE;
 
+		rcu_read_unlock();
 		return err;
 	}
 
+	rcu_read_unlock();
 	return ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
 }
 
-- 
2.34.1


