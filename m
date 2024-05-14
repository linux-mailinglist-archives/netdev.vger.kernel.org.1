Return-Path: <netdev+bounces-96304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5148C4E72
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54721F227D8
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40122EF3;
	Tue, 14 May 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vnM7OYNI"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FCF208CE;
	Tue, 14 May 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678005; cv=none; b=VWp1bXUkRFUgW8lY7N/HJVbJ+CYICho3L8wbV4oYireD/Ht29wjGD4MGZza/1BWDUCCKebUhnf57xZ0SMeZ+5csdyOcZRnXardX2WdH2QrjA30x+OuKKhahbx9BkkkloNMOk25fcRx3opSYS8HGmMjcV3OlcsQDLoO6SlXn8nSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678005; c=relaxed/simple;
	bh=thgfflq3vyytkFirvfAMIlSAofGiCK0BkXWApSixBZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgROkwx6G4QCp4Df0EteGFP1u18Bzbu4FGAnbLQWd0sJmfmDKTwZPBp9e2A0h68D9hiMoh7CrziUaiskgDW8oRQAMzs6OHzjwviN2FlKH1EKC2/nf4If6kl2OyIpcdiyNxIrM8Um/6WnRXWfbKZuq+CSwcUGWBeomn7vg3ZEJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vnM7OYNI; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4F05288291;
	Tue, 14 May 2024 11:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715678000;
	bh=uo2Z30cLQBXU/idKopCpSV4pE9+tgaq/9xcBaJbOqgU=;
	h=From:To:Cc:Subject:Date:From;
	b=vnM7OYNI4t24ZKK3i1Wi4E//MRMGxO+cJ96r1Tn8YiCRRIGYrAMMMVdDIg4xsuFry
	 zMhPzOJ4c8JEYmt1e7ITm4aaOc8OiGBhDCUlJ4D8itYVJ9iVTybZDBReO3akVAnlth
	 vo2cEUqb82PTN2rg+NG7nWIxeOYYhakM9jvQNAdc/we/iXkWg+ejaH5HWIEnPeJJqJ
	 4VeG8FcACxDfDWAOBKXw8iFqH5p97Y48Ooi6UeOYHoh8/HC5CqXn0PSW+HparRbI7+
	 OchEa6iDmZILT+htaaHBJdan9qjvLa6vIDtFmqiD3k1GTddzSuhJB1ZYAGuxHyFlyi
	 TWL2ltvdj3sQQ==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] net: hsr: Setup and delete proxy prune timer only when RedBox is enabled
Date: Tue, 14 May 2024 11:13:06 +0200
Message-Id: <20240514091306.229444-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The timer for removing entries in the ProxyNodeTable shall be only active
when the HSR driver works as RedBox (HSR-SAN).

Moreover, the obsolete del_timer_sync() is replaced with
timer_delete_sync().

This patch improves fix from commit 3c668cef61ad
("net: hsr: init prune_proxy_timer sooner") as the prune node
timer shall be setup only when HSR RedBox is supported in the node.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_device.c  | 2 +-
 net/hsr/hsr_netlink.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e6904288d40d..d234e4134a9d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -589,7 +589,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
-	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
 
 	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
 	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
@@ -629,6 +628,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 
 		hsr->redbox = true;
 		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
+		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
 		mod_timer(&hsr->prune_proxy_timer,
 			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
 	}
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 898f18c6da53..c1bd1e6eb955 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -129,8 +129,9 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 	struct hsr_priv *hsr = netdev_priv(dev);
 
 	del_timer_sync(&hsr->prune_timer);
-	del_timer_sync(&hsr->prune_proxy_timer);
 	del_timer_sync(&hsr->announce_timer);
+	if (hsr->redbox)
+		timer_delete_sync(&hsr->prune_proxy_timer);
 
 	hsr_debugfs_term(hsr);
 	hsr_del_ports(hsr);
-- 
2.20.1


