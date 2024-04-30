Return-Path: <netdev+bounces-92563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BA8B7EA0
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE57282F66
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D831A181B82;
	Tue, 30 Apr 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OtQCalJg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD364180A7B;
	Tue, 30 Apr 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498309; cv=none; b=UtC152UpA8fDgD7Im8urXCFosjloKNhkqe8MgJFDfDirImBI16AqpBgjJn36zGmJ4C7whY9IssoBJS9iItVwiDufcC0zzniYSF7QNJcKZedYnY/dDhoMzQSxWnyDyqfRyMQjTYZzZRG1oKwgy62VkAgNwUHQowXGdbM6bKo/vkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498309; c=relaxed/simple;
	bh=zPyiRflC7jeV8k7zXb17x/2J2jvufKjQoB06LYDHYHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxhscbkpdieUU9Wn+cKgGDZH4fN/YTRD1rvBMk1NSo0q4Ry8lacXSvOuAzWw57nnhTgrnng0K0MkSMuCkj3KlP61GW9IsA+SKFY5NPu8u34LG5AijFM65QjmWFWBcA3A2FaNAtdHvyPGhpDeyYdO8tMNmaxwkg1I+7hOHjXEf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OtQCalJg; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714498304; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QGJWLz932bMU5U6HblGzngnP6tYUfKQ227fWSoLYVsI=;
	b=OtQCalJgpEi3vpoF+thmNP8HhQBlgmJoplQRhKkxXhKd0xi2aqsuJIzrwPDU8+4ejZ7XKOyOGk89mXh5keQN/h9NZH9ybzD138FA2G+PB6IReGR4zGxwP2Xn5P+qnTk8uxITeA9qubYjWA78HCmWBk1LUa90HcGQzjb+I6Saeqc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5ci8gh_1714498301;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ci8gh_1714498301)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 01:31:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	justinstitt@google.com
Subject: [PATCH net-next v11 3/4] dim: add new interfaces for initialization and getting results
Date: Wed,  1 May 2024 01:31:35 +0800
Message-Id: <20240430173136.15807-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240430173136.15807-1-hengqi@linux.alibaba.com>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIM-related mode and work have been collected in one same place,
so new interfaces are added to provide convenience.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 include/linux/dim.h | 48 ++++++++++++++++++++++++++++++++
 lib/dim/net_dim.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 4b1630f4672b..e8e24667ea23 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -260,6 +260,54 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
  */
 void net_dim_free_irq_moder(struct net_device *dev);
 
+/**
+ * net_dim_setting - initialize DIM's cq mode and schedule worker
+ * @dev: target network device
+ * @dim: DIM context
+ * @is_tx: true indicates the tx direction, false indicates the rx direction
+ */
+void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx);
+
+/**
+ * net_dim_work_cancel - synchronously cancel dim's worker
+ * @dim: DIM context
+ */
+void net_dim_work_cancel(struct dim *dim);
+
+/**
+ * net_dim_get_rx_irq_moder - get DIM rx results based on profile_ix
+ * @dev: target network device
+ * @dim: DIM context
+ *
+ * Return: DIM irq moderation
+ */
+struct dim_cq_moder
+net_dim_get_rx_irq_moder(struct net_device *dev, struct dim *dim);
+
+/**
+ * net_dim_get_tx_irq_moder - get DIM tx results based on profile_ix
+ * @dev: target network device
+ * @dim: DIM context
+ *
+ * Return: DIM irq moderation
+ */
+struct dim_cq_moder
+net_dim_get_tx_irq_moder(struct net_device *dev, struct dim *dim);
+
+/**
+ * net_dim_set_rx_mode - set DIM rx cq mode
+ * @dev: target network device
+ * @rx_mode: target rx cq mode
+ */
+void net_dim_set_rx_mode(struct net_device *dev, u8 rx_mode);
+
+/**
+ * net_dim_set_tx_mode - set DIM tx cq mode
+ * @dev: target network device
+ * @tx_mode: target tx cq mode
+ */
+void net_dim_set_tx_mode(struct net_device *dev, u8 tx_mode);
+
 /**
  *	dim_on_top - check if current state is a good place to stop (top location)
  *	@dim: DIM context
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index b3e01619f929..bc74ef36855d 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -166,6 +166,74 @@ void net_dim_free_irq_moder(struct net_device *dev)
 }
 EXPORT_SYMBOL(net_dim_free_irq_moder);
 
+void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx)
+{
+	struct dim_irq_moder *irq_moder = dev->irq_moder;
+
+	if (!irq_moder)
+		return;
+
+	if (is_tx) {
+		INIT_WORK(&dim->work, irq_moder->tx_dim_work);
+		dim->mode = READ_ONCE(irq_moder->dim_tx_mode);
+		return;
+	}
+
+	INIT_WORK(&dim->work, irq_moder->rx_dim_work);
+	dim->mode = READ_ONCE(irq_moder->dim_rx_mode);
+}
+EXPORT_SYMBOL(net_dim_setting);
+
+void net_dim_work_cancel(struct dim *dim)
+{
+	cancel_work_sync(&dim->work);
+}
+EXPORT_SYMBOL(net_dim_work_cancel);
+
+struct dim_cq_moder net_dim_get_rx_irq_moder(struct net_device *dev,
+					     struct dim *dim)
+{
+	struct dim_cq_moder res, *profile;
+
+	rcu_read_lock();
+	profile = rcu_dereference(dev->irq_moder->rx_profile);
+	res = profile[dim->profile_ix];
+	rcu_read_unlock();
+
+	dim->mode = READ_ONCE(dev->irq_moder->dim_rx_mode);
+
+	return res;
+}
+EXPORT_SYMBOL(net_dim_get_rx_irq_moder);
+
+struct dim_cq_moder net_dim_get_tx_irq_moder(struct net_device *dev,
+					     struct dim *dim)
+{
+	struct dim_cq_moder res, *profile;
+
+	rcu_read_lock();
+	profile = rcu_dereference(dev->irq_moder->tx_profile);
+	res = profile[dim->profile_ix];
+	rcu_read_unlock();
+
+	dim->mode = READ_ONCE(dev->irq_moder->dim_tx_mode);
+
+	return res;
+}
+EXPORT_SYMBOL(net_dim_get_tx_irq_moder);
+
+void net_dim_set_rx_mode(struct net_device *dev, u8 rx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_rx_mode, rx_mode);
+}
+EXPORT_SYMBOL(net_dim_set_rx_mode);
+
+void net_dim_set_tx_mode(struct net_device *dev, u8 tx_mode)
+{
+	WRITE_ONCE(dev->irq_moder->dim_tx_mode, tx_mode);
+}
+EXPORT_SYMBOL(net_dim_set_tx_mode);
+
 static int net_dim_step(struct dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
-- 
2.32.0.3.g01195cf9f


