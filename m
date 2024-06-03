Return-Path: <netdev+bounces-100287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A708D866C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E4DB22EA1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988213211A;
	Mon,  3 Jun 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sYPW2IJr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B613698E;
	Mon,  3 Jun 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429665; cv=none; b=VRP7f1ZYh4KQpu6+g8uFdDmNZ84RdImGOdD8S9ZRqH2/B2n8sRipprvAlYk1glLE+NlQNB1ZjiCcNElEDvyRgzjVwb2HeTIpQsQ9Q794M9EPZ3Z1V9Z5dEuh6rT5Vtw2Rwl5w5C13UzooKo8T3vmIYJghpGq48OkVt2wtNpAEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429665; c=relaxed/simple;
	bh=qAEyJNGqXVtDQaOJ17IZNcP9BgYizJmujcQn0b+gcgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKGga4aqZyNyPnXcfyn1K3vqhak4sUtUtC6inaCu56W6zbqh8CsGc/U3t5FUNWXwzPVEl0Ix4rIrp5croBRSmCwpo6ouqsd73yg/wyPUg25IDXn9Dnz2GdYBCpEq4Qlr8XYYaKo6CbcIRmtt7tLTiTR0afaNX8o13MNLF735PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sYPW2IJr; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717429655; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/D4h/bMUp+InVUcUlroTGJDw83XIXlFPibLngvL1H+I=;
	b=sYPW2IJrE31I01XIsPyasTq96hjn9QaFKG4B2oId5aAp8XrPKHMfUI03eojmgQ0uVn5yPhP/nGVSuUCWL3IaOJg6g+J33UvAqVZ8k5Tevgi5xxxpcwn76DcpWqOL9UiJKDnFQmkaGbYngLuyenHvoYoPa9OfXaCtpQilmd5bJo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W7oKL63_1717429653;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7oKL63_1717429653)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 23:47:34 +0800
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
	justinstitt@google.com,
	donald.hunter@gmail.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next v14 4/5] dim: add new interfaces for initialization and getting results
Date: Mon,  3 Jun 2024 23:47:26 +0800
Message-Id: <20240603154727.31998-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240603154727.31998-1-hengqi@linux.alibaba.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
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
index e0f39bd85432..1b581ff25a15 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -256,6 +256,54 @@ int net_dim_init_irq_moder(struct net_device *dev, u8 profile_flags,
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
index 0cd41277c7a3..d7e7028e9b19 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -165,6 +165,74 @@ void net_dim_free_irq_moder(struct net_device *dev)
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
+	res.cq_period_mode = dim->mode;
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
+	res.cq_period_mode = dim->mode;
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


