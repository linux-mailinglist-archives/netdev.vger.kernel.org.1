Return-Path: <netdev+bounces-137953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764869AB3D6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C381C20FF1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154501B141D;
	Tue, 22 Oct 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMAyNY2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A691136345;
	Tue, 22 Oct 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614302; cv=none; b=iNGwbFRddEdsaRC3t+keijqfnCfAhW/PWzrdiFKk58tsdX0BTXLNf6BSeomAeidLrCgiqvwfd4NOxXjEXFQZpRcPzKihEEArdYnqWWrwqahObeS9gXzPm/KV7KLaJeL9GJ37agah9sDgzDFmksNI+2sepcb1AENv6i3Fa81UEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614302; c=relaxed/simple;
	bh=K7SuixB6Td6IPfBM3xqtDEm+YY7FsppOYwBMl4zeyPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9Zk2V76ZO0kNMPZRvIdrzcNBpH8DizVWfYCtB98ha85bAS9qNRgzPsRTeG4m7znoBVwQFaA958qOdi3qmei9qbgjVanuS+17Fj3O3NrSjUuDmc/8ZJ8vnC+32wEfWGYn1v9IpsR1+ASrL5p5y+zMod/nK9W6Dr2HwzoBjmbWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMAyNY2W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbb1cf324so51701035ad.0;
        Tue, 22 Oct 2024 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614300; x=1730219100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6B6qLaEz37RxKySIXA3GdJc2yXpIMxvmLdcDYXmM+E=;
        b=aMAyNY2WJll8SGs9rFS0lBrIjSI+7O/Txg+3kpmoAPencIW7jzJEAkKwhiQOq4yYQz
         9wrsZecwJwLRxYLixr6b0NTF/tDF3a68O8efa4BGIWZTLlE3LK/2NKixqJESa7nuISpB
         Mqft2nif+LkgrYLiaytseRZtKepZZt26GIjSHJuaza8GlI6zgosg0pdFVINFw5DzQHNH
         Wr61AA+5D0A8FedFZaH0VpQqERaJqvaVgGvUJD4mnT65IQj3nSWU4/yakw4RQhnJnY6u
         7cXsq8b4qxhlbcvB+YQ5L0n/p6XI5WvrcdaHw4bYHj2BfUt93sGrqqtc33k8hMd1lePq
         dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614300; x=1730219100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6B6qLaEz37RxKySIXA3GdJc2yXpIMxvmLdcDYXmM+E=;
        b=HeoOao7u2zl5gWwJtlxR0PeIP7DZ2+FtvDdRTJ7y0BkG46cWSzFkChJMvEKv/teCf9
         BwWFfEXSWqGssHWvJQqqDSiAaPLSrywi89Lop+06IiHWw0sO20Cfav4WnMEop7o54g3b
         ToyyCBckD2a6D7RL5zFTal5ioIY1yuPs2KbLoqhLDxfnNWAoaqleOlDfWhn6NzogjO0J
         /m/4InNxK/L7ENlFgLrMuLyMOTpd2YA6/z4nwzuG8eWdypF3PRVcoCW6AxW1WjX4cmhk
         eavzhHbZEGXYi9aWc6eXY4Ss3FC+V3idI6nbGL53cNy06i6unSXVlRuw6zF76xGWA8FB
         sMsg==
X-Forwarded-Encrypted: i=1; AJvYcCU/nggMnXZQMuxhorTXpZ1eMatZ1gXL8rClNdsb3ylo/ZTZztQwvk1G5yW09oAlp9TJqoXGgqurmOo=@vger.kernel.org, AJvYcCUXn7fUsPJCkq529x56VIi07tb5K8lYO5Lm8/3XhsWE/DnL88etKmGJL2YmvvYTLq8G+lT6nqYd@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLwHknTSZh5PKZrPXot8dKDWcFU6/fX97yEydJNdXxrGFTOyw
	04u+OTKa9Jw6I+CV/7DyNZI8wVMBf4yMXAn6MYrCkx/VlowUXLBk
X-Google-Smtp-Source: AGHT+IGlSI3igwuCqufO9cr87MQb6+l8BwBs9XyLC/TNIxYDUcWYKtiyghkAB0xCes9pH/vW7qVgQQ==
X-Received: by 2002:a17:903:41cb:b0:20c:d93c:440 with SMTP id d9443c01a7336-20e5a8a9c53mr231486415ad.35.1729614299885;
        Tue, 22 Oct 2024 09:24:59 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:59 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/8] net: devmem: add ring parameter filtering
Date: Tue, 22 Oct 2024 16:23:56 +0000
Message-Id: <20241022162359.2713094-6-ap420073@gmail.com>
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

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and
header-data-split-thresh value should be 0.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/core/devmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..3425e872e87a 100644
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
@@ -140,6 +144,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -ERANGE;
 	}
 
+	if (!dev->ethtool_ops->get_ringparam)
+		return -EOPNOTSUPP;
+
+	dev->ethtool_ops->get_ringparam(dev, &ringparam, &kernel_ringparam,
+					extack);
+	if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+	if (kernel_ringparam.hds_thresh) {
+		NL_SET_ERR_MSG(extack, "header-data-split-thresh is not zero");
+		return -EINVAL;
+	}
+
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-- 
2.34.1


