Return-Path: <netdev+bounces-223932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2495B7D841
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83622A2C94
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85047356906;
	Wed, 17 Sep 2025 09:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D200350D7C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103106; cv=none; b=e2JC9IKeUNLs1uK9PZh2fwHl/eqXoda97/mB8SyaXbYTqdtg3A2ShvEP2/RDepYcoUte3f13OnARndNShfJ34PDC9548wribmvLctsQ1XgfvOO5aOGi/NGerFXqG33ZfmnTHTd7x3pa22o7v//3ymEsdIWAtbBLkW28WZGse9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103106; c=relaxed/simple;
	bh=9BWXBrWWV7onXdD5Y7LlmKabKEBZvRMEMewGpwrLXjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSecoaKo1kIE+ZjNHWf2bUu30s+d0NWqnWgztAM0+0NqTTi7XmsDt00jap9wUUtbyoQt25MT2rFiz+qpSDjUhJ4FuRcMtCsvwNT/08Qlc0vKtQNLbPWn6GOPmE2JLIGxDz1LYkZ7xgUCP1AMbmQ6pNn0oMe9VREFTdbQioOyqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07e081d852so724163866b.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103102; x=1758707902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQE6LtSTYqQ+c2iAKiSALM65Z422xxQgQPusJ9V+cNk=;
        b=GZPe6NxuJcSpzC8r8TGs1poz+0aC+dZ8ANtHJdnxZSs/FLXwhapTqoDkAkdwBZqqb7
         +b1wZ9HlFP3v1UPUekswUMVriJfaYCss2V22fwFzUFz6F0T1A1pevz0FenYjpchp2I5H
         b7VV5o3xRstJq8zYUYxvmSW5U886Jeell7BvtYPmea/KH0F3FAw1sXfMHjfJ0KtizTdx
         ZPn9fLMZR94oBEL4tpaQv3sFbXi2wG5Lee1oLVeILDSR2n7t1PO7t5bczyW0KhBhmJh3
         t304c11FmLIUmMmgjrxRdim6ybbljsUXSryytQGe6/M6YMLPfu6rDq86CDc/S8z+o2Ql
         eiug==
X-Gm-Message-State: AOJu0YyTYVmByouodGYCe/WUAnIubwVp7j3D1NBMCZ4iLixtwiLB3aY3
	Lj2ne6G9RSMsSXP4aLW3eht3/uukNqPfM0q6m6QHwqBBRMsWOVgsOaM3
X-Gm-Gg: ASbGncuUlTMuWyUkJlfH4gM6aUrBq//xInu0jH4YPUYH3CAk5V1ljwJwAEKiK2iDCas
	NvNKx5CRITCoOYJBXdo7QqWG2oR/uD9p9jNlW0VLaLso1wzdVmiGhNE5pMAX4sO85l8sLXb9xbr
	rBmDpdlzJahfuTtURKSyUhr5FeWPIRjVkNSougx7P2ISxAf07VAKqrJV8Ex3wGtXjDXpnNetSEZ
	/c9z/iyyulY+lwyr/d6FalWEgroFPL0PqS1ntA9kvHHMTMSDljc1WALQ8e2BnCUyKGWmzvHMScM
	E9gbkk0qmq5s+x4xxgu9YR+dPz4//O/jFRi0YWJ8jNCTLyFKbqYJ41WYZFm4WyerUB3PfAMbaGQ
	zLqe8mOtuXwEbyDukjjOullvcTyEqCXUF
X-Google-Smtp-Source: AGHT+IFYZHeYkpuS99ezHy5849Hx5zCbaZ/mp70yB1SouYyTWZlfB9hmErX2+QC6IjE/8sv5ghVFfQ==
X-Received: by 2002:a17:907:c0d:b0:b03:d5ca:b16 with SMTP id a640c23a62f3a-b1bb1020d85mr195258966b.23.1758103102365;
        Wed, 17 Sep 2025 02:58:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1355607166b.83.2025.09.17.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:11 -0700
Subject: [PATCH net-next v4 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-4-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083; i=leitao@debian.org;
 h=from:subject:message-id; bh=9BWXBrWWV7onXdD5Y7LlmKabKEBZvRMEMewGpwrLXjI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2z5BhvbZTvHZ0JxV+ekm87PIk4x54Ip06t
 oUdH2g0FiqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bb6YEACF3NEx/MdQVixAhaypqlYSJjboYzQSEL7H4+Qi0P8kmF+eQyQQGRfn/z16qCkhVD5zCXX
 UszOzJgYxDwizcOHv6WY7QuCFuFHu7J8jwMzYnHtdby5zXqQEpKyAwRURED+aPwil2ia90IrCzO
 CGrpsr4Lae9gm8C20Yv+Ac9jHzFnRmRt6z/1fAbbvSJ55InJFCXOdGx8rcscp1McrHdTNIT3VQ0
 tjIO3YzbJOhXDPmUlnbj5asrMXzrciHA9M+H0RlbZbDiiYAUs4U1juz93nWQfQMwUGGoVBUZIjC
 Gm7b2gapXFugXHatG/8tcpXyeP+jTxON+sg/0YWFp7ZMYZT3+cq/wx5+6zTb7MphxmiWrBjEZNJ
 MdPec5lJ/es2MFtHVqYl2/0EeQOSZGs69AfZTv5keDG4yGYWaN2PzBNDsX+9iF40XsiyWkqs+0X
 1t/qSCT6nJxFke9yYBunf9vX1xC2hjsipmdJQLMCtC92QRz2Lbt7NcWNYcM7vLbxE29k9ttyItq
 t5pHNUqPIhdulXbMN+hQr2EKlPVFuBIxez1bbPseyj7Nv8/4AGprTMU6UnsfZyWA/YpSGYIDecE
 xpc5nLTB3N2J8NSdbwj0bFz4m3ptkd/fI6FuNqYjPWUXyl8XQjX06hncOqAwP0czWAQmNGcDF00
 dtJlcJ2RWCPUCVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Create ethtool_get_rx_ring_count() to use .get_rx_ring_count if
available, falling back to get_rxnfc() otherwise. It needs to be
non-static, given it will be called by other ethtool functions laters,
as those calling get_rxfh().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/common.c    | 20 ++++++++++++++++++++
 net/ethtool/common.h    |  2 ++
 net/ethtool/ioctl.c     |  8 +++-----
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d7d757e72554e..c869b7f8bce8b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4f58648a27ad6..10460ea3717ca 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -577,6 +577,26 @@ int __ethtool_get_link(struct net_device *dev)
 	return netif_running(dev) && dev->ethtool_ops->get_link(dev);
 }
 
+int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static int ethtool_get_rxnfc_rule_count(struct net_device *dev)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c4d084dde5bf4..1609cf4e53ebb 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -54,6 +54,8 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 			       struct kernel_ethtool_ringparam *kparam,
 			       struct netlink_ext_ack *extack);
 
+int ethtool_get_rx_ring_count(struct net_device *dev);
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 int ethtool_get_ts_info_by_phc(struct net_device *dev,
 			       struct kernel_ethtool_ts_info *info,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..8493ee200601e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,23 +1212,21 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxnfc info;
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
-		return -EOPNOTSUPP;
-
 	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
+	ret = ethtool_get_rx_ring_count(dev);
 	if (ret < 0)
 		return ret;
 
+	info.data = ret;
+
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 

-- 
2.47.3


