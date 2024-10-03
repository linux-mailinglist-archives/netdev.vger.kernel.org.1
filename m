Return-Path: <netdev+bounces-131678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5198F398
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559281F2175E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9131A7040;
	Thu,  3 Oct 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBy4Ub8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074101A4F3A;
	Thu,  3 Oct 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971643; cv=none; b=VhDSaOBqxuxpLdQdh2vREIzSODvXv26Kq8gtklj2aqFPPXgKVTdruEmleL6xaTWYVgJDNAje9lEJpVJGZYT/5sonB2cfX/5kcdu3SC9hyyQ9qr90i1hfVnhJ/Ial3U0MXa4JFPpzrJRuGy/NmmhNV1PRBbOF2RoBeQkoltxtxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971643; c=relaxed/simple;
	bh=fH0dchgKMq3fXQkGCCVLAyu8UF9Vd8KdI0rToMEDtzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mi5NyVktrID6J7pa2k6PHzsZ/tzI1nN1KUn6jE64ls9nn5/egVOdauGoMnZNBOB7XndewO6Rj+RskOj1T8SVgxmZ05ueUOZiJT/9jyywWG9/NKQ+bI/Iu+F9PdY8Avg0921PACSLdkPvwp+6BxbynYv2H31V9wAfQBtn4yd132s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBy4Ub8A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-208cf673b8dso11623125ad.3;
        Thu, 03 Oct 2024 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971641; x=1728576441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FctRudtrWsv/Ogj24COLxGVifRWLvWISYZk/oegPxYQ=;
        b=XBy4Ub8AMFYZ0nAUz9k7Q2iQ5+sF4VYwonEz2yqHNmaFrQB4GqriYa2kj437l9TQVA
         F5GepmFpwc4uDSkSbo5en/020JavRxGb+TWQwhygLqcoI4UtWVNjcJmXIfzmHvhKtcqL
         8owi4tbtzI6a/YcYW27VAVwWw/ksVGpLnDJXiIRlK0v5Trjtb7b75PK3xSLIp/Rxw8/A
         5Wu3tUW7PHxWQP9uy0BwrB5tg3ELk/xtU8OGYdH0EERO6A2LsgotmCNCnSPAuFJqp0wv
         QsDQbj999U4jmPU7+CXYs2/MSNitpZbXD8rEOxUAUk8k7KeQSd1MlQJwj1Mt8bZmchW7
         p+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971641; x=1728576441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FctRudtrWsv/Ogj24COLxGVifRWLvWISYZk/oegPxYQ=;
        b=KAknthu8McZkJVgIiN3kILhJe08pgEP0fHpqI+u3ybLvyBosJLtrKwXoZzw8/xDNYT
         yS6Nr4CTBCnkXxqJf/JKUUXlWGP+11FIyIb1I57j+bErIYuPx7w+a3iCTKZFQ7+34zfa
         JCUgHr8wAjEMnM0M5ujDiXrSPmNpS+yEiXTrsEPJXVDFmfl6RBBluoJFi2w2+f4g4BCa
         lFJmtB7hS1ZXCD0XDAgWlPSiYbCS4/hyPLJVTBVwM6oD7caxfZ90fdJz868N7E9bAPMK
         mPVtEDBTTrWMlG27aE0DPH5rUaI4bTxmxG5cCBfh4GGdZZaFRlHziwH5KPEMU5ooLjXr
         naXA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Jc6hL21UlIP6PakowOJhKN54NZHJEP5xwGp0aL/b5hQ7cwsXO3RSYOD62XvRaWig9PXAB/mB@vger.kernel.org, AJvYcCXjIklLjejbH6hexl5OMUppeucoPp2N108BK/poJwKSwhlv1UMCuSb/tcxgHVwaajziit37glxtnzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2kvMDfgv0FYOhbPlsa8Od5jNmzsmK6eZifV0ZQnDXL9kZ53M
	9/7CKtjYMRNNirwNZQnCz/uZIgpRKS7NR3vfbVUSokMEMaiIdHjo
X-Google-Smtp-Source: AGHT+IFe1RdKceRPkdoydM6HfGZtMob484p2+vuyVmOBY7Xvrz2gi0sZ74GT4bc8jGHdE5wpqb7cKg==
X-Received: by 2002:a17:902:f552:b0:20b:9822:66fa with SMTP id d9443c01a7336-20bc5a0b178mr117385425ad.16.1727971640145;
        Thu, 03 Oct 2024 09:07:20 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:07:19 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 6/7] net: ethtool: add ring parameter filtering
Date: Thu,  3 Oct 2024 16:06:19 +0000
Message-Id: <20241003160620.1521626-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
tcp-data-split-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Patch added

 net/ethtool/common.h |  1 +
 net/ethtool/rings.c  | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index d55d5201b085..beebd4db3e10 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -5,6 +5,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
+#include <net/netdev_rx_queue.h>
 
 #define ETHTOOL_DEV_FEATURE_WORDS	DIV_ROUND_UP(NETDEV_FEATURE_COUNT, 32)
 
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index c7824515857f..0afc6b29a229 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -216,7 +216,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false, thresh_mod = false;
 	struct nlattr **tb = info->attrs;
 	const struct nlattr *err_attr;
-	int ret;
+	struct netdev_rx_queue *rxq;
+	int ret, i;
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
 					&kernel_ringparam, info->extack);
@@ -263,6 +264,18 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
+	    kernel_ringparam.tcp_data_split_thresh) {
+		for (i = 0; i < dev->real_num_rx_queues; i++) {
+			rxq = __netif_get_rx_queue(dev, i);
+			if (rxq->mp_params.mp_priv) {
+				NL_SET_ERR_MSG(info->extack,
+					       "tcp-header-data-split is disabled or threshold is not zero");
+				return -EINVAL;
+			}
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


