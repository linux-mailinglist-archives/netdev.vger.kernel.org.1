Return-Path: <netdev+bounces-121116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B795BC18
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B5C2820AC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509031CDA2C;
	Thu, 22 Aug 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZW1jnJ6r"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0A1CF287;
	Thu, 22 Aug 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344734; cv=none; b=U/P5hIePndV7bbFvclv2DKg5N1UsaPeTjA8UigyHXWUvqY5jI1R7K3xrlB2JCbD9D7WcSP5TKjJYFpLdAzpvA9ePEUohOSO6X4s3RoyAJUtuwLewkHtc6YZ7DBfGyo6jq2HpH5n1cRQnTwZsufftQAzdFEA+7l2z6VdlC86/wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344734; c=relaxed/simple;
	bh=M14R375QucS+IBUnV5ku1m4jnX0b7ZPqJhizNnKKXVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukGJGZltnaux2mGypxHi5PPacs0zInOXy6+QC1STnFm/GsEvzlaDi7swVIJlrraCip5tvZBkhn7vmivIpQ1wDlMAOLtbiPL+5mq56fN5txAAkuOXdErDvukNok1tQqAaB1r62/GKEu/mTfEpTEcquQPlDYMRdsIaYzZMkJzSuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZW1jnJ6r; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NFtZvGsAyv/YxzkKeDVq6yT4CLs75C5CQ5a49MlD5W8=; b=ZW1jnJ6rcxiIc5n0TXxv0qoiJr
	PXbq/c3sf9wBLqVHETUJdOtUo4QpTkic3Omsf28VjuH3q6+rS6p0YII9+AMsmt30uILai55xKGWM3
	QkuzFgt/XZQDTrHcW1Ue8fAuj4edMgMVn39iG1AgtZYHRDO8Jy01PT3YzD3k1P7EBvsQ=;
Received: from p4ff13de3.dip0.t-ipconnect.de ([79.241.61.227] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shApZ-002bns-0B;
	Thu, 22 Aug 2024 18:38:37 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: bridge: fix switchdev host mdb entry updates
Date: Thu, 22 Aug 2024 18:38:35 +0200
Message-ID: <20240822163836.67061-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a mdb entry is removed, the bridge switchdev code can issue a
switchdev_port_obj_del call for a port that was not offloaded.

This leads to an imbalance in switchdev_port_obj_add/del calls, since
br_switchdev_mdb_replay has not been called for the port before.

This can lead to potential multicast forwarding issues and messages such as:
mt7915e 0000:01:00.0 wl1-ap0: Failed to del Host Multicast Database entry
	(object id=3) with error: -ENOENT (-2).

Fix this issue by checking the port offload status when iterating over
lower devs.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/bridge/br_switchdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..3490c3968638 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -568,10 +568,18 @@ static void br_switchdev_host_mdb(struct net_device *dev,
 				  struct net_bridge_mdb_entry *mp, int type)
 {
 	struct net_device *lower_dev;
+	struct net_bridge_port *port;
 	struct list_head *iter;
 
-	netdev_for_each_lower_dev(dev, lower_dev, iter)
+	rcu_read_lock();
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		port = br_port_get_rcu(lower_dev);
+		if (!port || !port->offload_count)
+			continue;
+
 		br_switchdev_host_mdb_one(dev, lower_dev, mp, type);
+	}
+	rcu_read_unlock();
 }
 
 static int
-- 
2.46.0


