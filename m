Return-Path: <netdev+bounces-212216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E51B1EAF7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B19AA283A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1E288C1E;
	Fri,  8 Aug 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndrl9x0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D7288C05;
	Fri,  8 Aug 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664852; cv=none; b=PZopDChxsh3kIQa9y63XZQddxSyzy9R/nyB2fS5qu7Fi70XOEwL6HQ58shpuA8N35v1tfJ4vZhJUeXyQ7iYo+ibpQBufc35iDwKjcYxvNaq2yML/T65lZikJkzRGzVW1mw+11qpICZhfJhPIdSIiArn5hy9eS+vjdhVIyqiNYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664852; c=relaxed/simple;
	bh=3TejFr6fgu4eduM337yPWWO2YW+sKNeDkWHAfmFlhUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH4lVigHJHngg7yT/PaMjcfkjnRFXCIDRO4nWKyq7pW6NADLvXzk6QLuKgZ6emTTKdcG2FLktFM4KTZJIaelOyYaAoZqUjc9eR2j2uzizhrpYdM4UySt6JDASWvw2b6vUIE+ZrfpzqfykQfqhghzgJk3BieGMi2GG+lSmTcH49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndrl9x0u; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1264929f8f.0;
        Fri, 08 Aug 2025 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664849; x=1755269649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e17MfRSU7AvEK9eP7fQNYNtShDJqFvLZAH8mOJdLhMg=;
        b=ndrl9x0uwgSU4oLnV+9eTmjuT3iCa6gJ2bGvyS1QS3IMLhsP0zT2YQx58iUTutF0ds
         JZnLC2jfUauNotfr4kX3v8XHtRA34SpdSm+KB71u1FvFEUZehTafskiVpfQNcCzBXILQ
         f/lBMl4DcsB3vIuDkPAUMBjJYePcKyJrlYozkOav/J40heD35G1eC8Pcqb8BcJV7z+sP
         TMjRVsQ0H3fOyB1Mi8cN9WttMDTUdOeFmSWMnWn6nuJUlKUZfpzdSyR2h03QHTWo3DOt
         Xvyoqs5LR+JfZidRph2FTS4mJdzLcIox0rEk+w6Cf25tnWEwIviyzo7zhIAw91+HopEq
         8c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664849; x=1755269649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e17MfRSU7AvEK9eP7fQNYNtShDJqFvLZAH8mOJdLhMg=;
        b=tSYjcwzb8CtA9+HdrTL8nqorYOtbtkEcr+kfVXQOzWlhLsQAjGaYf1pgXGkyWHdfNs
         8uks+2t5HO2ZkJZEEf4nom/Nz/5Y3h4AD7YLdFLPblUZjA1cEW1TZDdwOTTzIrZ0Zn+7
         mkBWFiYRmvf343xbvMCcPOxqRm0qTSOpPzlhmuAd2VFmcNKn/55kSAKNtRLhqkbFWd7e
         Rqu9GvI4Up+beYoCZIQ3kCqEMZ1O/FPoyS2KER7CH7+FLfjrPE1Y6qtGy9dCiCmsF0+k
         2V5X8ubfv2xWmYXRZEXGF2iR976wvLx0pWJiU34kmFlpvEsWNdIK+usuM46RBx49Alfh
         xDAg==
X-Forwarded-Encrypted: i=1; AJvYcCU7B74ADMKuc/zqn4MkHBQSm4t2wWE2bGT57GPZyRI1+qWwT3Q/nwIlhkKF0ZN9gJixvhu2JRWOCGAytrQ=@vger.kernel.org, AJvYcCXEEo66OnWZ/PHF68pbZg109MltN+U/XlseNpHBgmfbFriNa7dpUbiw3uRo1glM+exO6eFVxjfR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjyap2mCryVUgMTnrrwo6RJkWiem27nFmwGTZGcEKJTxIYproy
	buEjsqsxxv49pP0WLld58Xly4HKz5X8cIhKsz4fQMfxuAbQ7i2KKrt8x
X-Gm-Gg: ASbGncuNqu62dKpT2As4KE9zkQvUe+M/32lvFDq8RO+e+oDITWfpDzTZ8zyv8h3i8+G
	FquMJDT0mLvRbqC/+n3oHIU0Uw13zrqWDiiVEbx+6VSg285UjmyhtajyOjnqY87Zfp4p51DW0ti
	Szn4SoFqhNp4YBaXaysTZnGSrwesr6Yw0bX3eaJ3USpS3FBoWdrtVNcdIWb5fFsRwK+Xs/gH4hx
	vAK7sSSMmc8Jz1u09+nd2CX/kqFGMeB3fziB2f96iNRH5y7XWUfPTk30iAI/hGaeh3+ovbB6bpy
	Buy0jPvfAB7eQGQKXfGYQxsJLxLczEpgWj6JGIF1nDE9lxZp2RmrWhqs6G9Y2B5+cFyZ9qSCm0L
	wTa7b5g==
X-Google-Smtp-Source: AGHT+IHZxy6R98pg1IqpIhpqpWuDWTth58NrfVIKWZTrzIigVHN2ehT07sx2HrRN8PQk7IIcrH2p+Q==
X-Received: by 2002:a05:6000:240d:b0:3b7:9c28:f856 with SMTP id ffacd0b85a97d-3b900b51379mr2603642f8f.48.1754664848875;
        Fri, 08 Aug 2025 07:54:08 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:54:07 -0700 (PDT)
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
Subject: [RFC v2 23/24] net: validate driver supports passed qcfg params
Date: Fri,  8 Aug 2025 15:54:46 +0100
Message-ID: <4be7520c9f3f411d851d1959d1b9eedb16ce78c3.1754657711.git.asml.silence@gmail.com>
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

When we pass a qcfg to a driver, make sure it supports the set
parameters by checking it against ->supported_ring_params.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/dev.h             |  3 +++
 net/core/netdev_config.c   | 26 ++++++++++++++++++++++++++
 net/core/netdev_rx_queue.c |  8 +++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index a33d8a507bed..9e43da3856d7 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -103,6 +103,9 @@ int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack);
 void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
 				    unsigned int rxq);
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				  struct netdev_queue_config *qcfg,
+				  struct netlink_ext_ack *extack);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 2c9b06f94e01..ffe997893cd1 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/netdevice.h>
+#include <linux/ethtool.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 
@@ -136,6 +137,31 @@ void netdev_queue_config(struct net_device *dev, int rxq,
 }
 EXPORT_SYMBOL(netdev_queue_config);
 
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				  struct netdev_queue_config *qcfg,
+				  struct netlink_ext_ack *extack)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	int err;
+
+	if (WARN_ON_ONCE(!qops))
+		return -EINVAL;
+
+	if (!(qops->supported_ring_params & ETHTOOL_RING_USE_RX_BUF_LEN) &&
+	    qcfg->rx_buf_len &&
+	    qcfg->rx_buf_len != dev->cfg_pending->rx_buf_len) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+
+	if (qops->ndo_queue_cfg_validate) {
+		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, qcfg, extack);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack)
 {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 39834b196e95..d583a9ead9c4 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -37,11 +37,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg);
 
-	if (qops->ndo_queue_cfg_validate) {
-		err = qops->ndo_queue_cfg_validate(dev, rxq_idx, &qcfg, extack);
-		if (err)
-			goto err_free_old_mem;
-	}
+	err = netdev_queue_config_validate(dev, rxq_idx, &qcfg, extack);
+	if (err)
+		goto err_free_old_mem;
 
 	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
-- 
2.49.0


