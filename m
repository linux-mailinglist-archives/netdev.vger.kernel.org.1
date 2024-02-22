Return-Path: <netdev+bounces-74090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31E85FE6A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FDD28664C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52416153BD9;
	Thu, 22 Feb 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9wrb2Pd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1E153BCD
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620535; cv=none; b=icyU64xWRLplreCN+XViUnNYli1YCaMZUM77IxmRtyotwH+MOm9BrNDhFGATsM7l7FfT5qPze3Pqw64o8VPlFmQvLqRyohag7yNlp/36hklmHh3yrPcfLdnFwlWuSnzn9adzFkILh8ppaaQkhXmdsLqlXfOHLo88cr0Tnw2AiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620535; c=relaxed/simple;
	bh=qEHU1qqEGfKoUEGibkh/8r83/8b+c3TRpaulL4SaD4Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M9Joqn6iNszzSsdQmBWMl1cOVKAHURVmoYMMvAKF1Bz7s1pD0Hbvcs/IgFGo1WqnqW+3CKXLSLEjHO/LB7uFVIdZAX0zQTm5QNPvkyCr8Au48yF/c7Vlh3S8AUn5XeFHy/4JbHcyFfceFmc6igDch+AQRF2gQJaANBaUulPuZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9wrb2Pd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so8187808276.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708620532; x=1709225332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jjmt/uWfTqCrgVm0rw4fYoLRkbJfvVKqFNy3ri9+0so=;
        b=P9wrb2PdNKt9IUOKN9grBR2QDJrbXj0qhi4mOPm/9odID/WYuWHAX0uuCjcbCeswgx
         qyUht6ovEdMzEC680mzZq39xKbscM4zON2xq02HhxJQN+a7C86dSSkneXO+iiPqU9Qmr
         oT5F88M30DNCSKQLsP0YjOf3o8rE45E3XnGktWFkgCIRyErTmcW5zGiffbnpL3ppZ1cy
         7vNF8dIZ28hTx0hLAFbMHgqT2xMfGOrkme4DqOQ71L7EPrJ52+SpmOCCu/aWyM4Xbql6
         XXOSgvB7ie3yWAah6DZ9joAB3xVeQyHW1cVF1YqJ1vwSaVquMl4X/fN5IIpVipnZxPSr
         9Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620532; x=1709225332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjmt/uWfTqCrgVm0rw4fYoLRkbJfvVKqFNy3ri9+0so=;
        b=GHeF2IbCyeohXxQ1PrtBcYH0BjgQB2WAuiun9tBVPSuiSW3S1WhEoiHpRHOKjXy87f
         HeK3exfL46aE7w9+TfOyM2ZgxJR9dAm6o4S8h5XOotRXklK7STpuPQLPX2TJYRwR4brU
         QeLZGGddT0VICptBTECyV1FNcgW8PYA5Lv/c43pt0+YSDOK+HCeMeeNxWYi4TPuEgf8b
         uVtTUZwP8CSaBoQkLiIi016cUg7uT7G0rWGgSa2dg0li7bAZGOCvhokx8iqRQELM/F+Y
         4Z6NAWmdifk2kxjmr+plyBc9mqCN/VLixTt1gTeYcMKa59Xi4XtMuaYY9x/Cx+WjUY3m
         rQvg==
X-Gm-Message-State: AOJu0Yx9SRV3Ry0WLFEsgOkZI/8bAACe0jhnO8BOcxm9YeGIXrYBWXTp
	rPdzojpZrYjZWkkux3xJez/y0Lup1kjO2evEB6yw70flaFoWU54eOlgquEdb078Z5GwGU+Wse3K
	cQmRS6R+/Gg==
X-Google-Smtp-Source: AGHT+IFO6z6f3zSbKlB0fzAEKgSw4IXUof4ZJbd5PsXekIoVnUiShYQFKaPyvN12G5o3/yZL43nWS9U+NqPjjA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6ac4:0:b0:dc6:b982:cfa2 with SMTP id
 f187-20020a256ac4000000b00dc6b982cfa2mr98914ybc.8.1708620532537; Thu, 22 Feb
 2024 08:48:52 -0800 (PST)
Date: Thu, 22 Feb 2024 16:48:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222164851.2534749-1-edumazet@google.com>
Subject: [PATCH net] dpll: rely on rcu for netdev_dpll_pin()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"

This fixes a possible UAF in if_nlmsg_size(),
which can run without RTNL.

Add rcu protection to "struct dpll_pin"

Note: This looks possible to no longer acquire RTNL in
netdev_dpll_pin_assign().

Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/dpll/dpll_core.c  |  2 +-
 drivers/dpll/dpll_core.h  |  2 ++
 include/linux/dpll.h      | 11 +++++++++++
 include/linux/netdevice.h | 11 +----------
 net/core/dev.c            |  2 +-
 net/core/rtnetlink.c      |  2 ++
 6 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 5152bd1b0daf599869195e81805fbb2709dbe6b4..4c2bb27c99fe4e517b0d92c4ae3db83a679c7d11 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -564,7 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->parent_refs);
 		xa_erase(&dpll_pin_xa, pin->id);
 		dpll_pin_prop_free(&pin->prop);
-		kfree(pin);
+		kfree_rcu(pin, rcu);
 	}
 	mutex_unlock(&dpll_lock);
 }
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 717f715015c742238d5585fddc5cd267fbb0db9f..2b6d8ef1cdf36cff24328e497c49d667659dd0e6 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -47,6 +47,7 @@ struct dpll_device {
  * @prop:		pin properties copied from the registerer
  * @rclk_dev_name:	holds name of device when pin can recover clock from it
  * @refcount:		refcount
+ * @rcu:		rcu_head for kfree_rcu()
  **/
 struct dpll_pin {
 	u32 id;
@@ -57,6 +58,7 @@ struct dpll_pin {
 	struct xarray parent_refs;
 	struct dpll_pin_properties prop;
 	refcount_t refcount;
+	struct rcu_head rcu;
 };
 
 /**
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 9cf896ea1d4122f3bc7094e46a5af81b999937dc..4ec2fe9caf5a3f284afd0cfe4fc7c2bf42cbbc60 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -10,6 +10,8 @@
 #include <uapi/linux/dpll.h>
 #include <linux/device.h>
 #include <linux/netlink.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct dpll_device;
 struct dpll_pin;
@@ -167,4 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
+static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_DPLL)
+	return rcu_dereference_rtnl(dev->dpll_pin);
+#else
+	return NULL;
+#endif
+}
+
 #endif
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ef7bfbb9849733fa7f1f097ba53a36a68cc3384b..a9c973b92294bb110cf3cd336485972127b01b58 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2469,7 +2469,7 @@ struct net_device {
 	struct devlink_port	*devlink_port;
 
 #if IS_ENABLED(CONFIG_DPLL)
-	struct dpll_pin		*dpll_pin;
+	struct dpll_pin	__rcu	*dpll_pin;
 #endif
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 	/** @page_pools: page pools created for this netdevice */
@@ -4035,15 +4035,6 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
 void netdev_dpll_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
 void netdev_dpll_pin_clear(struct net_device *dev);
 
-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
-{
-#if IS_ENABLED(CONFIG_DPLL)
-	return dev->dpll_pin;
-#else
-	return NULL;
-#endif
-}
-
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);
diff --git a/net/core/dev.c b/net/core/dev.c
index 73a0219730075e666c4f11f668a50dbf9f9afa97..0230391c78f71e22d3c0e925ff8d3d792aa54a32 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9078,7 +9078,7 @@ static void netdev_dpll_pin_assign(struct net_device *dev, struct dpll_pin *dpll
 {
 #if IS_ENABLED(CONFIG_DPLL)
 	rtnl_lock();
-	dev->dpll_pin = dpll_pin;
+	rcu_assign_pointer(dev->dpll_pin, dpll_pin);
 	rtnl_unlock();
 #endif
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9c4f427f3a5057b52ec05405e8b15b8ca2246b4b..6239aa62a29cb8752a53e3f75a48a1e2fdd3b0ec 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1057,7 +1057,9 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 {
 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
 
+	rcu_read_lock();
 	size += dpll_msg_pin_handle_size(netdev_dpll_pin(dev));
+	rcu_read_unlock();
 
 	return size;
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


