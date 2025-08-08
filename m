Return-Path: <netdev+bounces-212215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D4B1EAF4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EC8562BAC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407E28312D;
	Fri,  8 Aug 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSqXM9Iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D9288502;
	Fri,  8 Aug 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664851; cv=none; b=YVsljY82TdLesjrkOUrtOXcqaJCTlyJRm9TQydrkEXDICjJNjeaUQP1N5KznE8TDhAszc6N1jWZwAql03KIz2UZFhZh1oOhcW1yuwZL2KilimROeI/ekDnvqoF0qcfK33swTjpsiAf8J/xd/lNhDTjkehqMemPB72lthaQZeda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664851; c=relaxed/simple;
	bh=DMKxvdjwIe3cobVTLaT5Z0+chPl74jnjEtX3oIXMFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPDv8eJPKQqHLFrRExZS8GFURBkJYGkv5+iA8qqgyNudvDuUfPM9cpYAEglY2gGB49Phj2qwCj62Kc+FVbh6CyXizOwnG5II0oj0Z9QlW1zLfCYZ8Uk3+2jXnr2nu+ws8y4ParVKeb/+aPdc7aWCx+w1lSmeq8ZNfQrIWsbVfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSqXM9Iz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455b00339c8so14564945e9.3;
        Fri, 08 Aug 2025 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664848; x=1755269648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqiVDIiPia/7gaiv57e1tZCg4guYFsjP0/H/rlRCi8w=;
        b=SSqXM9IzGJboK99zGIn/Qj4NssddUYs71X/SXn4WQ9kOAtgIzynAgTKq10cH4/fRFu
         YdgvETZn5jvMu4e0UJRvSs5xoAz/UMi9f47uw1EJsJSuU1A62kIa+HB8LyrSsO8L+BIN
         8QDxGKIk+Eh917B3CdAhB4Q+GBhfqJvxQVDalafkXrOdhyNtlZEy+zZfYpCiXrJb/C8g
         t6qoSP6KzmKddFpg7ChZzBhV4ygKalKblpIrhjKZL8TUaGhn7BrynCpECtJ9E40v4PRT
         4QBN7z4TobFuTIPXRMDpTXt71Jd2YEsOy3u9pVzD6w85r+5Arzj8GA1xuAKDXWV3/hED
         y2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664848; x=1755269648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqiVDIiPia/7gaiv57e1tZCg4guYFsjP0/H/rlRCi8w=;
        b=fOxo1x+X55UhVF1FTm3pnRyOz2ZGeUDkoXCsG9T0RdBn/PbFTJS8U6aayAvpr/cboT
         ZihcbSGxUayjRNn6qvblNaGb23mxiajRq5yKUfEFtEGm5cvNhqG5syo91FSkFVHU44Y0
         G06g0HVWkNWdbI1h3tmw1qEYomSCT8Rb+Ghx8bupH+yY5tOXL8wL6mG96T8q2aOJ3Vcp
         F0MVtRBhzU2b6B7Y3TitixN8YAUFzhL8ER0I5KqtY7t29+nbruIK9v878nE7K7bgqXib
         VIw7A140t5Yzag1mL03sIH19aXmGd8plAGiAdg9GL7IaE/1Sf03oICgvcVPE0/x0RcFZ
         xLgA==
X-Forwarded-Encrypted: i=1; AJvYcCUF7JGMm3MoxNOFmzZMvd4ofN5MXfbhG4mWIQlnzGd3ucHDw/fpXe3DQXHC/10sUH6hO6pa/Gx6@vger.kernel.org, AJvYcCWeqbcg4v/5u1aNy0dlgjdv2ds462HOJ1vYhnmwdWzt2depzJDpT+a3VII/w26xo4R8YPU0FKY2cqVsSow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UepDtdQJm5ClzsMT1h1E2ZcDtfUxS7+NOq0V1YBDFeV0v81w
	7VhLLcLKGu6lJR6YgXQU3XCu6BVu6pZDQhTn5lFLooZL5JRfgHOfI+9HPEbJCA==
X-Gm-Gg: ASbGnct/JcNJsl4W7uzIow7VWFG9fqiQlZFlwsErjUk86P0LUcUUkGDMW/3FeM9psUu
	6BUeNYHsh+KajF2o7Iqe9xNTWb8UXktUiiyawoIE2Dcc+Wf7ejk7d5f+2zUgc6DdICU9FKxcW+n
	FL2QA+9Hd7K5ecMAngEz7fXop1Vy6N2WdtiGWlrB6kruAwkyBYHQ97WczrpXZWctqj7+a3S7h/u
	UxAWAWM+aMAi4NsSmHx+jHrr+XL3YA2iv4xJlLkS6tK64TlW7H03pjgGy9SdTtPmnDemsehYzub
	q6FGNqoscnd3A4/8yD74U06bM6YViSaZjpT2zYfmv+TdIwL48gACC8ed8l1nbuAbSxYtaRdzXdw
	MT8T/dg==
X-Google-Smtp-Source: AGHT+IGaXUCKUSl8JShwML/5ctUsQL1Q/kXOcaUKLmgvM9xY8JG/k0S/K0kYec6m9lcH+dYUiWCT0A==
X-Received: by 2002:a05:600c:1d09:b0:456:18f3:b951 with SMTP id 5b1f17b1804b1-459f4f52793mr36230325e9.15.1754664847477;
        Fri, 08 Aug 2025 07:54:07 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:54:06 -0700 (PDT)
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
Subject: [RFC v2 22/24] net: let pp memory provider to specify rx buf len
Date: Fri,  8 Aug 2025 15:54:45 +0100
Message-ID: <51c7abd5bbe6af2bc3b4084ffb05568a282bfe30.1754657711.git.asml.silence@gmail.com>
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

Allow memory providers to configure rx queues with a specific receive
buffer length. Pass it in sturct pp_memory_provider_params, which is
copied into the queue, and make __netdev_queue_config() to check if it's
present and apply to the configuration. This way the configured length
will persist across queue restarts, and will be automatically removed
once a memory provider is detached.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/page_pool/types.h |  1 +
 net/core/netdev_config.c      | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 431b593de709..e86bb471f1fc 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -161,6 +161,7 @@ struct memory_provider_ops;
 struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	u32 rx_buf_len;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index c5ae39e76f40..2c9b06f94e01 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 
 #include "dev.h"
 
@@ -77,7 +78,7 @@ void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
 	}
 }
 
-void __netdev_queue_config(struct net_device *dev, int rxq,
+void __netdev_queue_config(struct net_device *dev, int rxq_idx,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
 	const struct netdev_config *cfg;
@@ -88,18 +89,24 @@ void __netdev_queue_config(struct net_device *dev, int rxq,
 
 	/* Get defaults from the driver, in case user config not set */
 	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
-		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq_idx, qcfg);
 
 	/* Set config based on device-level settings */
 	if (cfg->rx_buf_len)
 		qcfg->rx_buf_len = cfg->rx_buf_len;
 
 	/* Set config dedicated to this queue */
-	if (rxq >= 0) {
-		const struct netdev_queue_config *user_cfg = &cfg->qcfg[rxq];
+	if (rxq_idx >= 0) {
+		const struct netdev_queue_config *user_cfg;
+		struct netdev_rx_queue *rxq;
 
+		user_cfg = &cfg->qcfg[rxq_idx];
 		if (user_cfg->rx_buf_len)
 			qcfg->rx_buf_len = user_cfg->rx_buf_len;
+
+		rxq = __netif_get_rx_queue(dev, rxq_idx);
+		if (rxq->mp_params.mp_ops && rxq->mp_params.rx_buf_len)
+			qcfg->rx_buf_len = rxq->mp_params.rx_buf_len;
 	}
 }
 
-- 
2.49.0


