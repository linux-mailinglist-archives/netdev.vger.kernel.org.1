Return-Path: <netdev+bounces-137954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDB9AB3D8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCAC1C21998
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA51A264C;
	Tue, 22 Oct 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8LFsSCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4601A4F2B;
	Tue, 22 Oct 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614310; cv=none; b=MQEhf0U7ud6afK0K8zNGkmGNDKWSL0vP9FoELs6qsdPls66NrYR0hCywKfrwOXv/+caU0NzGC58c6XoifrDJ0+pxAn90xIgopeUrRc8jj6IyxcgqfPMyUDQFbg5WugS0gDuXNt9CgwN7ryrQSiC4OI/41ipAI4v8T+uLv+P/uA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614310; c=relaxed/simple;
	bh=sQCtlCATXqz81JNEmuLIhiRGCe+8jLrO8vl3W1Y8Im8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opWFoxagAxokIjo6QckTWHktalC44g0py1OvwqOVIAwdXXF6DgrKFoHKF6cXFreHV7gmEoagA6mlses9Z1ticSQOasTCuUl+8GZDk63r2Vh+93cwoKZKYKhBriRGuV9FuWLAQfYV0bifXeQkTchbhUeAnxFJcQil/Af/E2rP3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8LFsSCz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdbe608b3so48166835ad.1;
        Tue, 22 Oct 2024 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614309; x=1730219109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOwBPPS/0whvsnaM8DpV5hy0fk/olDaACqNimxXbEC0=;
        b=e8LFsSCzJCLq0nhPZceyC8+zaAyp+mJ0WkZXmXhZUYwRF2uRHt5ONX0RYrgEmq/LNr
         xhJXZjUIoBylFAIKH5rBAfMPplpsM2iUOB2HuYx9YGgsThjz6Cb+YvGfPKZuEdZWFMFZ
         rx1vrSmmTmWw3FgZnPYS8l76cUaz1jU6QDOeSmZZhx02eQI1gB5+cCxtt2/tbfeQa4xR
         P7wxSrbSL5j6fsyxAvHGCVCBa6WyP3kMrLab0bZmWv1nW4bnvD5hOJC8EJ/XZd2Hi7AO
         9n5M6vsujhPHMG1/b4w4IMmW5mlrS1Qa298Hx7NIHk+LGn49EYg+mHb9gWAxsw6G7t7g
         sC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614309; x=1730219109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOwBPPS/0whvsnaM8DpV5hy0fk/olDaACqNimxXbEC0=;
        b=j9eYn8BEpFeewdQRoTlWgT/LQO8SqD2q56FVkSV2KbrUF6OMQ9zPhV/enmRxsXnP04
         awVYNwrliVZyOdC8HvTcdWK3CG0Upfap9NTgHEQZSv0cfp+BQpqb7cDbb2vFRIbD+A0W
         aqF/HjzziJMO3GCldnJAkEAqfUap4WFVQdNkrhMe2RIFSj0xGpI5qHDT6ghX3WnzIFr6
         0NQEk4FtwPayAPZ5+m8A44uPwb4G0oAmn5DpFsfszMbkgEvQ618QUKlkDz8IpJ/qewqd
         bkkCI69sZrgdKYd7taHCbhhUKnhYH9sK0cJ0q2Vzd5Hx46n6amx4uOX9qigm5i6uuOOz
         O8/g==
X-Forwarded-Encrypted: i=1; AJvYcCUFzJ84Kbp2xDauyZgq5ZmuCnmS72QtgskS8bfu/OGUH5qCjRwiYlQ1AotMpC4O28VW/IgeYiErlBo=@vger.kernel.org, AJvYcCX5KCZVaSYzTBlwvbi2bzIUmut2P/aJeWP+tnm5o5x3eViGgYxeveUB/e0somlzHMla0ixEpudt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10yYNJeODvhdUdhhjadR7oBJ34kXP7x97+eoZfA6fbHmLs84I
	mX+06qteiYGopXVL1luDuDXDNjQIMaeZCOSE6ewO9vVIi8fF5R+j
X-Google-Smtp-Source: AGHT+IHrBAiVKLRS4KoGLn29jcrvDCaH9tiNczdvEyGDQ3f2xMrWzjPHwmEcYRughboUp25HfOMSnw==
X-Received: by 2002:a17:903:2341:b0:20c:950f:f45d with SMTP id d9443c01a7336-20e94b643d5mr48889235ad.61.1729614308602;
        Tue, 22 Oct 2024 09:25:08 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:25:07 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v4 6/8] net: ethtool: add ring parameter filtering
Date: Tue, 22 Oct 2024 16:23:57 +0000
Message-Id: <20241022162359.2713094-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022162359.2713094-1-ap420073@gmail.com>
References: <20241022162359.2713094-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
header-data-split-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Add netdev_devmem_enabled() helper.
 - Add Test tag from Stanislav.

v3:
 - Patch added

 include/net/netdev_rx_queue.h | 14 ++++++++++++++
 net/ethtool/common.h          |  1 +
 net/ethtool/rings.c           | 13 +++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 596836abf7bf..7fbb64ce8d89 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -55,6 +55,20 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
+static inline bool netdev_devmem_enabled(struct net_device *dev)
+{
+	struct netdev_rx_queue *queue;
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		queue = __netif_get_rx_queue(dev, i);
+		if (queue->mp_params.mp_priv)
+			return true;
+	}
+
+	return false;
+}
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 
 #endif
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 4a2de3ce7354..5b8e5847ba3c 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -5,6 +5,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
+#include <net/netdev_rx_queue.h>
 
 #define ETHTOOL_DEV_FEATURE_WORDS	DIV_ROUND_UP(NETDEV_FEATURE_COUNT, 32)
 
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index e1fd82a91014..ca313c301081 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -258,6 +258,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -ERANGE;
 	}
 
+	if (netdev_devmem_enabled(dev)) {
+		if (kernel_ringparam.tcp_data_split !=
+		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+			NL_SET_ERR_MSG(info->extack,
+				       "tcp-data-split should be enabled while devmem is running");
+			return -EINVAL;
+		} else if (kernel_ringparam.hds_thresh) {
+			NL_SET_ERR_MSG(info->extack,
+				       "header-data-split-thresh should be zero while devmem is running");
+			return -EINVAL;
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


