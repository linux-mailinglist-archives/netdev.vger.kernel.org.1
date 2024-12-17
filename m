Return-Path: <netdev+bounces-152609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF09F4D0B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4A3188C504
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED331F4295;
	Tue, 17 Dec 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WwvvAUBc"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15151F4E2B;
	Tue, 17 Dec 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444236; cv=none; b=m2/LyhfkgOmCqnkkjutTw7Q/ZUA+QwcSziAhng1YEgDdY9Ak5G1WPORPLAflpXdmylWsLKefnu3C57ABFJXDx3Jrobm2HA3/e5ru9jiU5WgTP0ytcK5VYCA830mGwcPZmvxetoQp6fBbTiShx4+uAaQzKrOxjlBmAicV+RN/aPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444236; c=relaxed/simple;
	bh=IZ87MXf6daM39OJOvtkU4bFAOeXqXB/cKPQNg3D0Slc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WiLZVdXvnna1lzVnXzK0EsOFfxP63diNCX8IvqRC2PyENCWVNRUxZ/ww3aO363aPAQhea4K2F42TWWdHJmnMH6ZALMam5JxcmwRUzufTNXN8Q3NK/JlxOjUqOxNg1DaJLYbmR8gpHKlHYuIM/d8ZQQk+TE8m9qfddKasE036IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WwvvAUBc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0307A60004;
	Tue, 17 Dec 2024 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734444232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xD0QRvUCqjIzwzLi77XIt0XsdOy9GhhnXiquLrEuHAk=;
	b=WwvvAUBcxWPBHhjIiv5ySM0R6hyHWM8z2NGsHmszsGgzttWcoQ07nIDUYpGlNoPkG2FHPb
	aRKpl3qrg0cwHFRVuQtlFhpygJ8fzyJotq27p9jSY1on5928iXm3wqpxgOQaox5iDV368D
	bM+EzuZjxCLBt97qcDHzwU+dixtQQDxvVSCMXHmb+2/KPeQ6Ftf7pVNqRnDbRxl2XzQvcQ
	O181NErLcCz/hpUgC8vfttqRiCeFnfGK+Y/H7Caq2wUBEbI0n4MkO+M9ppoBuW6jxijYOZ
	6PsnBImQHWACfwfpPoDQvVx0mG6AuY2rO/bLIyLxhn3kd4TsfinfaQ4MoSvzYw==
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
Subject: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference usage
Date: Tue, 17 Dec 2024 15:03:23 +0100
Message-Id: <20241217140323.782346-1-kory.maincent@bootlin.com>
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
triggers a warning due to improper lock context.

Replace rtnl_dereference() with rcu_dereference_rtnl() to safely
dereference the RCU pointer in both scenarios, ensuring proper handling
regardless of the rtnl lock state.

Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@google.com/
Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 02f941f667dd..ec6f2e2caaf9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -870,7 +870,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
 {
 	struct hwtstamp_provider *hwprov;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = rcu_dereference_rtnl(dev->hwprov);
 	/* No provider specified, use default behavior */
 	if (!hwprov) {
 		const struct ethtool_ops *ops = dev->ethtool_ops;
-- 
2.34.1


