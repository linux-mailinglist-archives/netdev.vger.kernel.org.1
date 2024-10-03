Return-Path: <netdev+bounces-131677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188498F396
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B421F223D2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC01A4F30;
	Thu,  3 Oct 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfZMf15I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B11A7040;
	Thu,  3 Oct 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971635; cv=none; b=nkgMF8uSJ/fOiefcqlvnqQ08MPfuVfoWFNTSQ+nYITId+CvAPrlXzDN52+/Cm09zAP9PkzByGb9t9EczrlKoyuY76t3PD/KpUtqf1e/OgIH7GPn/jQcB4LyqhTvp57jt/cvwEJPyWlW9f6CuW978qfk49x1Zgqs1+ZcuJIrK5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971635; c=relaxed/simple;
	bh=GUxAVAdWls6nGx92bT6aTgRzlCPXr8vGEGOFwsQv93k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd07S95CaTsTWV9dHuziY7Jk12R7fY4r1XnV0HhSk2ML548cb9zAs8OXRSo6VPFr86Fh1tQt6/HRZlx1OAB+f8pUFksk39Ri6jTl7otDcy1+w/bNbmzp7V24D8OXk8oKHmLRmxLeF6fvwPE8w0mlSW2Jk2YMtdVsVZx0HvXeylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfZMf15I; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b58f2e1f4so7639255ad.2;
        Thu, 03 Oct 2024 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971633; x=1728576433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wQX2LX/wv/RIoIQmgU/BP3FU/uSb/iTRAGvr1uJUqQ=;
        b=EfZMf15ISynde7OndwRhwtQZHYiwhB+LzvStU+DpMYxRu69Ob9X3CTCspCirII5Ovw
         whQpViIob3DOgBSLqPcl8uR8Vdbmz5XNgeLCV4MeOPVrlRec1tQfRFEieJsqAJWiW56v
         AZ5lUsUtIak+GQ+x6V/uMufaF9PMQziaqrP4J+1nWe+sLYUWRKYQQyCIjv8r2EaQnnd0
         jcKin2v/Ea6n7ZErCqmkPdDomf+w9S5aML8iaKWzptLou6n+Oi2j+ThmiYKMjnWoPrW0
         YX0XOcj/QEiSf4cqVxn83x414fpGmpPrhT1jlizyY2fAMKZgCJ0EvFtvpgY7uoQTuq/i
         qSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971633; x=1728576433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wQX2LX/wv/RIoIQmgU/BP3FU/uSb/iTRAGvr1uJUqQ=;
        b=PXkReaP+Q0tmzGB1iCo7apP4leS8ZX3QHw9OeoB5rCkZmBdC+VH6UnJFbcsN5e87/L
         9iDtzeRCzysONOxt9jzhyltXz6A3v333dcAX+V5a+ADwxLuJHaXcIVd8PwUg11h866dh
         NMAzZ+HY1cHGqoATFaPWAEob3K3nlkZT5c9480cMwlMoVdYk9a6ExZG7iY+epwX5iFIW
         1G+ssFYRsYDb5vG/czIJDktV/C/69wvLcEaWkT5hWxzFy5KvnYpCU0/J9dwUSplZVaU9
         ZvYq4rlg/UGZgdYHvz4XVCftVnpnej4U00aJ++hmopPQyi9bD7p1Bd5GezCPaVGr0Hy9
         m3cg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZiVzg2RilFjBmSgdmZexWBE1y/qg6s1lYL/ttKgdK6RMNDaEiutZgaJ9CLmVpjal1lb3bv20yGA=@vger.kernel.org, AJvYcCXJ0GkAUzf43s25ycT67oHCCW49T/v5hHQKyA68h7UFOaJ/GUg4sThTFMU4ytxqukGgWAR/HXVE@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3BqWtXl9yMZ1i+ockVlQeKz9/AHEiCsc+9/KGg4JG/yprD1D
	QHlgvLHgvvosoqGNEzwwqLnz2GbLvUB5HQH+Qv6xGzyCjvDXvdTf
X-Google-Smtp-Source: AGHT+IGORnD4UEkFETTgSfUXqkR36wqi49XJV4ePNDbruOhZezv8WXJnkngJcBstkSHEYtCnAmG5/A==
X-Received: by 2002:a17:902:ea01:b0:20b:9062:7b00 with SMTP id d9443c01a7336-20bc54c7086mr89253895ad.0.1727971632807;
        Thu, 03 Oct 2024 09:07:12 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:07:11 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
Date: Thu,  3 Oct 2024 16:06:18 +0000
Message-Id: <20241003160620.1521626-6-ap420073@gmail.com>
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

If driver doesn't support ring parameter or tcp-data-split configuration
is not sufficient, the devmem should not be set up.
Before setup the devmem, tcp-data-split should be ON and
tcp-data-split-thresh value should be 0.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Patch added.

 net/core/devmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..a9e9b15028e0 100644
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
@@ -146,6 +150,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return -EEXIST;
 	}
 
+	if (!dev->ethtool_ops->get_ringparam) {
+		NL_SET_ERR_MSG(extack, "can't get ringparam");
+		return -EINVAL;
+	}
+
+	dev->ethtool_ops->get_ringparam(dev, &ringparam,
+					&kernel_ringparam, extack);
+	if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
+	    kernel_ringparam.tcp_data_split_thresh) {
+		NL_SET_ERR_MSG(extack,
+			       "tcp-header-data-split is disabled or threshold is not zero");
+		return -EINVAL;
+	}
+
 #ifdef CONFIG_XDP_SOCKETS
 	if (rxq->pool) {
 		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
-- 
2.34.1


