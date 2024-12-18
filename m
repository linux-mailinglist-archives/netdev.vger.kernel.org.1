Return-Path: <netdev+bounces-153006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD419F690C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63434171FA7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209A1C5CA8;
	Wed, 18 Dec 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5w3YLXr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072C1B424F;
	Wed, 18 Dec 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533264; cv=none; b=p9fy21BJ11gx9Io6t+S62L6cR5n5UYkm4Nc6eOzvjiCA4zovFaLt4elskzkMRJW51lyPO8TLtbdncLxL8PRuxFLEx38wemm/H+MP9o3z+cqQNNtLrPHpzg1+qIF57pJooW1okTW60wwUpXg+8qw6VAXO3CdTE+weW2AHTgDIV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533264; c=relaxed/simple;
	bh=4KGVBkIWRaTQHDZJ5D/V9ALbjqrOWO3X+FCc3ryqTzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahedhQCXQRoxyrazjwDjOVxqEluIfn965tDHb8+R6Jh2zZWDhUNAgZxWfa3XgFlOlZq1iKSJZOLK+pC+QJBEgXZgS4llhw9ZSJowTSDhOHDIAx1AZs/LFuYMXMtmOTj0wjCvQHJ8WKrCEdfN7aGw9d6xmHjJRZWqfYoHwQtr328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5w3YLXr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ed193c9eso5729823b3a.1;
        Wed, 18 Dec 2024 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533262; x=1735138062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub+N7PT2tMSkMSRd6T83pMsYqZ9p0Qa3rI1yYhkjFyw=;
        b=C5w3YLXrIvccE/8kdowaB2Uc45Y6YUaKsHnSqgFMdHYBbeMSDqINCVYeTxoGp2mZwb
         ttXiqIa8ehVAMVVsJCCf0EYycFrE2zCK86zNBoy1P9qwQYopZgKCB07D625EDTzMHxnt
         2xk06TbSYZb9B0pqbj3qpvYT/6wtVTqfbx7RW2kitWZ+Gf0EZw1gEnO17WjAUsxcPuG7
         xw/HkN+qzmnLrXbgVisMwN7+2sg2fHPKHhGNMYfBVPbYIexKjnBSB1QCDn8J/BpA2Xzg
         BZ6PNogTOW/ZqSlrWWYiqZAra4/23O+1NpqjocPwU2iDCITgDeRUFW8cWlpPXpMNMfP5
         ZK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533262; x=1735138062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub+N7PT2tMSkMSRd6T83pMsYqZ9p0Qa3rI1yYhkjFyw=;
        b=JPLb6J3oc0Kt/Q5AZnuxXyjlOFMlIWctsIQ7ZsFmBztIcKiOfnd/e8abNjoU/s7bbR
         nXX3W0ZM3RYZ3Co6XbY0aPuBd/tg6s8Zj5JE9c+hAm31CvvVsu2+FPhkpK1fPIdLj5aF
         bHZ10rYGO58tH2L3Khm95L+22LG13z6o4NV7TQySY1/zmshEVtamhsK7z9gzsashH2zj
         zgvBidzoICy3ABir5Ajy4YoJVSfeELVrwE5VgKf+eSPJfAToCQhjC1b+fBJ9B0WotFNQ
         qqvMK24yoj4hpiHM+kTwAk0snn4b6T5nOXIzaojl7LeL7OrZqd5+hh0e+od88ZXwtwsY
         xBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUOEc/Kn94WGhw3pfdas3o8N8IBrKoWWyiU7k55H01/CpXCnDNx+Cn4gIFQzrZN/kfbOZ+JhUC+1ew=@vger.kernel.org, AJvYcCWy+1sghtxi1RjeCkgTO0ohGt2yqFmcJpyieDvfZyDnT2GPwqc66gk6IUNtxea25fRThObl+YiI@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbcXErE+HWwEl34aR7ylrSKC7cfTG1JO6iakb3ETJG+Z4rVAr
	hlZHQ23LjxWayhweGbWHxGwy+AmUqh9uGEftzDfghNmBNtERJTH2
X-Gm-Gg: ASbGncuJ0R4sS2OMd2K7oEDkAqWPv0fx9jpPt5e6ry+o039XhfU7dXGF6JTlgi8VWzv
	NUUk/4ZRDoUks0aHIcewdLOpkl9+hwSpG15pLmAQXmDiY5JMtNJzphdLUEKECipp0smqvWZrhsk
	VQUaDjlzjAZq6sHI4LyH0r048FWSqIhITBTYkYhOjWs0CBP7JcfUX1aAfKen8bo8zSVpxLqCuVg
	+5DiwQa3FatbhP3d4NI5fOl2LWLEb1HSA1LujiRFFhalQ==
X-Google-Smtp-Source: AGHT+IG93HkJwM5dTZdC0kSuopm9Ai516tdFxpFnjpj9D2ML0ohkTRBi9Nagwv/xn2SFvoH+eFoR0g==
X-Received: by 2002:a05:6a20:840f:b0:1e1:a693:d623 with SMTP id adf61e73a8af0-1e5b4824bb1mr4998885637.25.1734533260887;
        Wed, 18 Dec 2024 06:47:40 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:40 -0800 (PST)
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
Subject: [PATCH net-next v6 6/9] net: devmem: add ring parameter filtering
Date: Wed, 18 Dec 2024 14:45:27 +0000
Message-Id: <20241218144530.2963326-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and hds-thresh
value should be 0.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v6:
 - No changes.

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/core/devmem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..a29333af3ebd 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
 {
+	struct kernel_ethtool_ringparam kernel_ringparam = {};
+	struct ethtool_ringparam ringparam = {};
 	struct netdev_rx_queue *rxq;
 	u32 xa_idx;
 	int err;
@@ -140,6 +144,21 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
+	if (dev->ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+
+	if (!dev->ethtool_ops->get_ringparam)
+		return -EOPNOTSUPP;
+
+	dev->ethtool_ops->get_ringparam(dev, &ringparam, &kernel_ringparam,
+					extack);
+	if (kernel_ringparam.hds_thresh) {
+		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
+		return -EINVAL;
+	}
+
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-- 
2.34.1


