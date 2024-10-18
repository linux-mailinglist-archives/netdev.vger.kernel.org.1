Return-Path: <netdev+bounces-136853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6AE9A3422
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EC3B20D44
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BAE17279E;
	Fri, 18 Oct 2024 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4ojSMh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D77152E12
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228873; cv=none; b=tgxTnYoSPiV7zoabJWjSd+vl4syouEqwhEIcEMA9WDkb5rn/txxKTdc3UbGT5HxfCKPDzlFoU8tAgLcOacjQR9NPceE01zzEV766eH7txHLnm6X6wrIEJBozMWJ9TYmUHqIIbJsQPnjuCuDcDK3nGidPOUKkgehguBV5NC7l3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228873; c=relaxed/simple;
	bh=J/f1uA2chu/qI4cVVXLm4mJDhaT+EZ5fucnUD/1Ig7k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yk+PkdWEds9oS1u5cAaNwbnfhLJw9J0iyGRoMe/y2IBCrOZkbGMjC/b8NdLVoQABEqwnDdbLSbE8DLTYUqggWG5Br868SXqXqcumeFCf6H/4lgoZBN0mCqZazC/86RpJ5Xxic52p1893GzRWts9dz/3H7hNHpHfZ+1gxqbLyTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4ojSMh0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so29416957b3.1
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729228871; x=1729833671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fPkDC3Enb0xgXPmzj9uS+PkCITtpS9EpYmFVpWq2P1M=;
        b=b4ojSMh0dY9Cy7Af236ga8sVjzNJ8VEXUCNHqlrKRX6FgNxTqho8SWBTLUGVSBRGMi
         H4GMcgd+WYj2bW/UHA4UBMWMAfhBWL7AL6LslDNtDXAUcBS20QrgDM3+xL+ptGMVbvbj
         osjVgY3yhjMlNYPkZxM+RNv6v3bSguUVY50EJAMmSyIxsGNl5UWuURrnLHXOsL7v2k2t
         Q/w0ZrQOU5SHB3U8kQjFxo+S9+bIHVeaZRR/uu6IYD+oB4igu4LRbB5whXI150AZF8lf
         vOhN6gGZEwDNA4sdR2+lljgDsLPzV8C7Fd3eCwWb9oeFUl6k7qxplK/jS/Jqm5YO+RXT
         XPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729228871; x=1729833671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPkDC3Enb0xgXPmzj9uS+PkCITtpS9EpYmFVpWq2P1M=;
        b=aQVv8l+khJJF496CLQxRFZS+fICWdmSo/UmZBu+peZCcn6vq7MM/+10FFBrYHWSMxE
         cmRfLIAcy5GgXflOEelPEOWaEM9E7Qe7khMrkHWW/TOc1JKxywgI7vqw8avhSBd4JEG3
         2nfhaoITg9LWV3JjlJnAmbRdAG03hDbzxhx6dJ/yM1rLRVnwyVQTXL8IVPkqL79ln853
         A4BlhoqKks2C4JV9ncZqj6aopgK+vkm5DiunozCLjZ+V6aX8AmYSg2tMFFgbdHV0DAsQ
         xGzkem7WWFbnVKfiAclPAXaZkdO5IkDDCxgOG+oCVMtuQrtf0ka38njBCjSTQ3EDvOfU
         p+Ng==
X-Gm-Message-State: AOJu0Yxng9o7yVU9r2yIrfheNjvE7M5YeEC140N49AM7iWV2VSyySD7l
	CfnDyw3pg/SBj9qWifVYSG/ICeiquiUazCY3uQVZkXpeVRa3ZfZD6Xmt3qdczxjCZFTlrI+xRZJ
	vkmZTsh6fXA==
X-Google-Smtp-Source: AGHT+IHqa4dNMponANTnODtZDu6EGlVgMaADr6YyeTSWEYoTzDFn7N/DC0yxHtkGV+gl+GyODKSD8KrWHo7qqw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:9e0c:0:b0:e28:e6a1:fc53 with SMTP id
 3f1490d57ef6-e2bb1308c20mr1377276.5.1729228870501; Thu, 17 Oct 2024 22:21:10
 -0700 (PDT)
Date: Fri, 18 Oct 2024 05:21:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018052108.2610827-1-edumazet@google.com>
Subject: [PATCH net-next] netpoll: remove ndo_netpoll_setup() second argument
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

npinfo is not used in any of the ndo_netpoll_setup() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 drivers/net/macvlan.c           | 2 +-
 drivers/net/team/team_core.c    | 3 +--
 include/linux/netdevice.h       | 3 +--
 net/8021q/vlan_dev.c            | 2 +-
 net/bridge/br_device.c          | 2 +-
 net/core/netpoll.c              | 2 +-
 net/dsa/user.c                  | 3 +--
 8 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1bffd8e9a958fb1b0e7f965c6fea5bc844f9c07..3928287f58653bf9737653af94e57cb903daf429 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1476,7 +1476,7 @@ static void bond_netpoll_cleanup(struct net_device *bond_dev)
 			slave_disable_netpoll(slave);
 }
 
-static int bond_netpoll_setup(struct net_device *dev, struct netpoll_info *ni)
+static int bond_netpoll_setup(struct net_device *dev)
 {
 	struct bonding *bond = netdev_priv(dev);
 	struct list_head *iter;
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index cf18e66de142c9a19b8b169c26a62137118e3e41..edbd5afcec4129e09f771c96b423d2eac030bb82 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1117,7 +1117,7 @@ static void macvlan_dev_poll_controller(struct net_device *dev)
 	return;
 }
 
-static int macvlan_dev_netpoll_setup(struct net_device *dev, struct netpoll_info *npinfo)
+static int macvlan_dev_netpoll_setup(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct net_device *real_dev = vlan->lowerdev;
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 18191d5a8bd4d37000fcbae27ab6bb26802762a3..a1b27b69f010533d4bbd4d7f1e314d2582eb8133 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1946,8 +1946,7 @@ static void team_netpoll_cleanup(struct net_device *dev)
 	mutex_unlock(&team->lock);
 }
 
-static int team_netpoll_setup(struct net_device *dev,
-			      struct netpoll_info *npifo)
+static int team_netpoll_setup(struct net_device *dev)
 {
 	struct team *team = netdev_priv(dev);
 	struct team_port *port;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655ef8e3e9349e78768788ae50ed41e7..86a0b7eb9461433822996d3f6374cca8ec5a85b9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1425,8 +1425,7 @@ struct net_device_ops {
 						        __be16 proto, u16 vid);
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void                    (*ndo_poll_controller)(struct net_device *dev);
-	int			(*ndo_netpoll_setup)(struct net_device *dev,
-						     struct netpoll_info *info);
+	int			(*ndo_netpoll_setup)(struct net_device *dev);
 	void			(*ndo_netpoll_cleanup)(struct net_device *dev);
 #endif
 	int			(*ndo_set_vf_mac)(struct net_device *dev,
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 458040e8a0e0be007012fd25499405e89799de00..91d134961357c4737e6d53f801a2f5ffa778a002 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -725,7 +725,7 @@ static void vlan_dev_poll_controller(struct net_device *dev)
 	return;
 }
 
-static int vlan_dev_netpoll_setup(struct net_device *dev, struct netpoll_info *npinfo)
+static int vlan_dev_netpoll_setup(struct net_device *dev)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct net_device *real_dev = vlan->real_dev;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 26b79feb385d2daea3bf9c63772a566cdd621476..0ab4613aa07ad61784806e20d18836307bc33feb 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -328,7 +328,7 @@ int br_netpoll_enable(struct net_bridge_port *p)
 	return __br_netpoll_enable(p);
 }
 
-static int br_netpoll_setup(struct net_device *dev, struct netpoll_info *ni)
+static int br_netpoll_setup(struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index aa49b92e9194babab17b2e039daf092a524c5b88..94b7f07a952fff3358cc609fb29de33ae8ae8626 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -641,7 +641,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
-			err = ops->ndo_netpoll_setup(ndev, npinfo);
+			err = ops->ndo_netpoll_setup(ndev);
 			if (err)
 				goto free_npinfo;
 		}
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 64f660d2334b77fa97e7d6d586a021d63ac5f6e2..91a1fa5f8ab0ef386059a81914dd27242c209b5b 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1308,8 +1308,7 @@ static int dsa_user_set_pauseparam(struct net_device *dev,
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int dsa_user_netpoll_setup(struct net_device *dev,
-				  struct netpoll_info *ni)
+static int dsa_user_netpoll_setup(struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_user_priv *p = netdev_priv(dev);
-- 
2.47.0.rc1.288.g06298d1525-goog


