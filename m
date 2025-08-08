Return-Path: <netdev+bounces-212207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A8B1EAE1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3859C5A2E8A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8972868AD;
	Fri,  8 Aug 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OubdOrn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C771286421;
	Fri,  8 Aug 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664836; cv=none; b=GbDPwGunY+GBewGxgHyqiFwRyvtWUca0C8HDl64Y6wohhNJx4tlhQUTrBW03KN0khDIdkQl0mmqkg4UUGUTz9LotwKI8LAbqV63HuxyLPUt8lrrJhrvxB40SLXjy0bCpkfwCZyfhXjvrhKaXEeV/W0qZtOaCJXULnfXXAt/5+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664836; c=relaxed/simple;
	bh=+LpLnpVjrDeTmD270kLDO6EOtuHUGTpk7i/fA9+a4Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6VeoxGVDPc3pG3bdgXZd+AD/73AwpRrssJTcjEMbAMvKBjWCO/r682A4SyC8UqPgx+zvX8XbgUDc1EhalAVgREWNKljTSz8eptxd1iz7pO+7MGL3zOrlxD+us4RX/1fpLZsnBiSve3In+b2WN8zgsExrH/PjewWz8i/XgY3jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OubdOrn1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso14094675e9.3;
        Fri, 08 Aug 2025 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664832; x=1755269632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT91pM79wAksHs/nHAf2EUUF510yylJAoTX0kDkhkqs=;
        b=OubdOrn1uOopdrmXLJmXDibmO5eK05LCnwgz4XcnmHEIYeo4iZGnOqbcso2vmmmjSh
         4HTjEMGrO3PKxCLGija1J0RTrmDwmSpevPsd2Z1iANre7fugdJc9kWO7QECNtcWkHs3o
         PZdh8FePseC9tdd9vIDEK7cYtZYFcjy8y1pRIytFuTftBNeeSfa474nky3dZh9Zk0/w5
         SYkcRWbNpZkk+w2Gj2eTddOurav36T+5Y/w3VAThqYMY5aKWoU4dIaGzxHO8Odrq5fMS
         sOwxQ0PA2fOYcLuvYdmFJ3yfZbTZkjyL/UHTm8cWk4sXef1codo4WljaMQLIEM/dDk/l
         YlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664832; x=1755269632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT91pM79wAksHs/nHAf2EUUF510yylJAoTX0kDkhkqs=;
        b=X9yVdsUWFBgmayr4l2G9T9jvr1KYMjx3YHz7WJTz/9O5tJlJR2hAqQFMY/3hiY5+0D
         H8AmK/jpnGtWrR9+NkHxN2TLQXQQIJ0ff7q1zVU4tua6+HOz3QlI7NysSi2flsj90fdj
         Jhhjv9EiDfM112hbcsoniduQ1+LllZCioKQHwlwdjiIqLwXv76Q12MZTnMQk5wl2fqne
         1tpjwP8pr9M7i3xeucNAr57A9VJzDFIWgrtdIJqGwqZfBJ26C346+9l/xpwcGvHscVCx
         zNX4Jm/90xuldFX0dGVIBJ4/t5k8HCMjJS0I4+x40E3Uz6Q/GHglga+sjZZpmzAQ1Kdi
         HEiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3+Gapn4RBAgykVw5BydHI44n+UQSgUpMY//IdcBkNlJqEAtYYyCbmqSFxsdVjr+CSs/Gel1VQ@vger.kernel.org, AJvYcCXVcFu4mkSmw+ZlXg+9tkUkNxv1BEJS3wqhlCCTROjKPqOjzAcUkMRRHkFH9PPwtPEhiTLy618XCePbIW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgXoUkuMwwaFVE4pedtNCrP2OmkdiIIauphfkYGLV/OUnleul
	NlAxZOvFQF67mBaszY0RGSRz9qn+dDmLuMLQ4CX+cW8wI7QdJk8xAql4
X-Gm-Gg: ASbGnctRBTiCP2cNbOajmaTIqRiHqmxC+I4KhDt9FKvtMnTUMREXCfJddzVrye9k+zs
	Pzes4tXEdlCrIZGgBBOtqSnEIPFDuBoh2Gu0apVxCk4PvaQLblMcASN7SKIdfnh1Ip2afOkIVBi
	T/uE3Ey9lFhwigD7LWxbMIDV/vH3MJdCyT4uDmA+RkJPZPev0akVygzWfFIlZR9tduj71oELpmm
	YVEDQxU4UjfIH8+ItuVudQIxNECDGS1XFa+mb7PXDmZA0UuX12ToPi7TCgjnac5/Lm0q3Lv2MfZ
	3JQLiUTwQd8pAK074VruWWprqEEbvP5Tex0pSOW+J0YYpjmQiNS9F/Jq+N9+G8M7mQM5PjjyuxB
	RZ4h/XQ==
X-Google-Smtp-Source: AGHT+IHKatVcDToB3k+GJrPMFIYkMdnSCvCpUZsSQ51BQ24b1EkDZe6yzHMBZeifo1SX+Lmy/DDKAA==
X-Received: by 2002:a05:600c:3589:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-459f4f0f380mr31736385e9.19.1754664832366;
        Fri, 08 Aug 2025 07:53:52 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:51 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 14/24] net: add queue config validation callback
Date: Fri,  8 Aug 2025 15:54:37 +0100
Message-ID: <c510e806e06718ff46b452bd6438df4641c22ada.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

I imagine (tm) that as the number of per-queue configuration
options grows some of them may conflict for certain drivers.
While the drivers can obviously do all the validation locally
doing so is fairly inconvenient as the config is fed to drivers
piecemeal via different ops (for different params and NIC-wide
vs per-queue).

Add a centralized callback for validating the queue config
in queue ops. The callback gets invoked before each queue restart
and when ring params are modified.

For NIC-wide changes the callback gets invoked for each active
(or active to-be) queue, and additionally with a negative queue
index for NIC-wide defaults. The NIC-wide check is needed in
case all queues have an override active when NIC-wide setting
is changed to an unsupported one. Alternatively we could check
the settings when new queues are enabled (in the channel API),
but accepting invalid config is a bad idea. Users may expect
that resetting a queue override will always work.

The "trick" of passing a negative index is a bit ugly, we may
want to revisit if it causes confusion and bugs. Existing drivers
don't care about the index so it "just works".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 12 ++++++++++++
 net/core/dev.h              |  2 ++
 net/core/netdev_config.c    | 20 ++++++++++++++++++++
 net/core/netdev_rx_queue.c  |  6 ++++++
 net/ethtool/rings.c         |  5 +++++
 5 files changed, 45 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index b850cff71d12..d0cc475ec51e 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -147,6 +147,14 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *			defaults. Queue config structs are passed to this
  *			helper before the user-requested settings are applied.
  *
+ * @ndo_queue_cfg_validate: (Optional) Check if queue config is supported.
+ *			Called when configuration affecting a queue may be
+ *			changing, either due to NIC-wide config, or config
+ *			scoped to the queue at a specified index.
+ *			When NIC-wide config is changed the callback will
+ *			be invoked for all queues, and in addition to that
+ *			with a negative queue index for the base settings.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -167,6 +175,10 @@ struct netdev_queue_mgmt_ops {
 	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
 					  int idx,
 					  struct netdev_queue_config *qcfg);
+	int	(*ndo_queue_cfg_validate)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg,
+					  struct netlink_ext_ack *extack);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
 				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
diff --git a/net/core/dev.h b/net/core/dev.h
index 5fdcf97149f9..f51b66403466 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -99,6 +99,8 @@ void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index bad2d53522f0..fc700b77e4eb 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int rxq,
 	__netdev_queue_config(dev, rxq, qcfg, true);
 }
 EXPORT_SYMBOL(netdev_queue_config);
+
+int netdev_queue_config_revalidate(struct net_device *dev,
+				   struct netlink_ext_ack *extack)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
+	int i, err;
+
+	if (!qops || !qops->ndo_queue_cfg_validate)
+		return 0;
+
+	for (i = -1; i < (int)dev->real_num_rx_queues; i++) {
+		netdev_queue_config(dev, i, &qcfg);
+		err = qops->ndo_queue_cfg_validate(dev, i, &qcfg, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 420b956a40e4..39834b196e95 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -37,6 +37,12 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg);
 
+	if (qops->ndo_queue_cfg_validate) {
+		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, &qcfg, extack);
+		if (err)
+			goto err_free_old_mem;
+	}
+
 	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 6a74e7e4064e..7884d10c090f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -4,6 +4,7 @@
 
 #include "netlink.h"
 #include "common.h"
+#include "../core/dev.h"
 
 struct rings_req_info {
 	struct ethnl_req_info		base;
@@ -307,6 +308,10 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
+	ret = netdev_queue_config_revalidate(dev, info->extack);
+	if (ret)
+		return ret;
+
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
 	return ret < 0 ? ret : 1;
-- 
2.49.0


