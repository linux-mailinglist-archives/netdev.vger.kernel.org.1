Return-Path: <netdev+bounces-74380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D152861185
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910C51C22BDC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A25B1EB;
	Fri, 23 Feb 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAVtM4bc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20E6FBF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691532; cv=none; b=mrP6CzFRthmXyeerfhKcLMi4fpAlaBc2O5BZ5KfGEiGNq1OiAeyIzBsNljI+Lja+q/H7VKOm/xP5WsoKda3kLdB/9SMEMNvEXMoH/gz+GyaqfExJuPrSV4yvGRBt9lOFYSQYjLJhBifm5rIlSla4ZZeL/fRWc9nMs/6CrHKQHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691532; c=relaxed/simple;
	bh=BmPkAgcGYidb9h03/2pSiQjFl+JccF3SVJ/KXK/Iu6Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SHvZ738SHzPcKJX8N2FJLMCuL3xRZPz4M44tGJJeN18+dA0+UT7ImVVCsKo6D7R2fD3WzuIZcMTv76yNAz1U7wg8ETeqJuzDe6p18LvCiu4EQgTU0NO2guRX6WcdD5F9IqBjAhNVrXQfdpt9CDQZ/W+oQSxHbKIeMZOjq1rl/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAVtM4bc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso1194729276.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708691530; x=1709296330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3d7xfZQNGxh/3EsUEhYRQV3d5Hncp2VN9WONQlGyYHs=;
        b=UAVtM4bcLNXZ9umsDwHYiqdIdBrpxvZsv2RzqxFnrEHIm7n5lLVGpVB2UTDsV/O/xl
         r1F8SaG8/TqiNrxn8oAiHru3Ypgf4nTpUuftJ0Wz4cazA9GUCmFGOBSJHa589rW4At15
         Xy5mvNuS01AyxQQqbBDVedEX20/JLWfmSK1r2pPgzk2wtVE8M3aNArwmLWwsSo9nJudt
         8xOHPWRbumKIbo+oeHTihvX41yk9Mq4eampHx/tLk0Pzr4VGWSyuN0rTgQT5vaHQqxoX
         Uqbs/6Ii3QjHoLMqIxcQw1CEtJdDEJtaoi/S2Sw2OE9DgulnvWpgNC9JK/CyT+JwX81X
         XMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691530; x=1709296330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3d7xfZQNGxh/3EsUEhYRQV3d5Hncp2VN9WONQlGyYHs=;
        b=QxiV/qpwFpBUi5ej7U9e3x4tFhrhtrsyhnwXlrcvDqAPfFLdz5JPDW6XakCZ/ZNERD
         h6TFfychAoGf3pDtUKMOWY6HhwMjCiGyEfMlOeKZMW3cNJIljg8cN8jBw5hHUWEgxWSr
         GV0s6JTZBEN33XUpfc5m1G2l28bX75n+4Rh7HytfN2fAZCiZg3ixTmzN/a86UJYhpYCu
         ueMfKphNsB4KgNCKQgYbITq0WB9QtHq5Focn2gX5PJR18PejR/40IJuoIcgU/Mdq2plq
         XPeizPvgu47Pd/qZ/XLuUSXAUGDXSX2HQk56CpmlzjfQXeKqEQVDwLBao0OauBQ7u9kX
         SsJg==
X-Gm-Message-State: AOJu0Ywn99sL3jLEXN/e/Z1hQl7q1GIUpr7R3/ZNddGQBIKRh+7Z5N4b
	s2AQW0nHtlkcWBdeyvrzg8BKsQc3jzdNNvIkir6QJ++vvJDP/pd5UFdxLGete6vXyHiZRec6x16
	Qas9/hro7/g==
X-Google-Smtp-Source: AGHT+IGSfcOmRMow2B9jv5uw/Jhf2nwxK2qU0zmT2HpwN82E0PAd26dQChCijF5nHi0cGgOJK2I5NAddzTdAmg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2413:b0:dc6:db9b:7a6d with SMTP
 id dr19-20020a056902241300b00dc6db9b7a6dmr61231ybb.13.1708691530177; Fri, 23
 Feb 2024 04:32:10 -0800 (PST)
Date: Fri, 23 Feb 2024 12:32:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240223123208.3543319-1-edumazet@google.com>
Subject: [PATCH v2 net] dpll: rely on rcu for netdev_dpll_pin()
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

Move netdev_dpll_pin() from netdevice.h to dpll.h to
decrease name pollution.

Note: This looks possible to no longer acquire RTNL in
netdev_dpll_pin_assign() later in net-next.

v2: do not force rcu_read_lock() in rtnl_dpll_pin_size() (Jiri Pirko)

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
 5 files changed, 16 insertions(+), 12 deletions(-)

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
-- 
2.44.0.rc1.240.g4c46232300-goog


