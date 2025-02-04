Return-Path: <netdev+bounces-162766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1635A27DE9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DC53A685D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6C321C195;
	Tue,  4 Feb 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DAYfqHWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860B21C9E8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706196; cv=none; b=GNzlzOJZoxz0aa97kCsVcmTr8AlFAXF3gn9kdji+fpYoT9mUUSo5xatkWPQIOu+9ShLnD6fqXUygMp8knl23mmooz9MN6CojWhdlsMjyL6mhcVkn0eeQxEJgfWzRYUrEXCv268XBhCmSHz9bAmO7sGHFC4bRiUJmOb/FRnuLvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706196; c=relaxed/simple;
	bh=6QDqwWHWGPf8NoYVfbLhpDnV9LHjat0kKaCxvrsawP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyhJm2luk290VhAf6dKtm7CJCc9GVzNtkpi5B3ysuPUB2qfrHuLjA9YvNx5RuBSlIBQUXSIJVLbu+KyQgS7oBDJxUe8/FaDvMhYIkbpmwbPhJ/m6a5MiUgznVxfzF/ePGfAs7jvQ99ng37gKXmWT+Op2LgFvmUbFNWAFAXK8C1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DAYfqHWs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165448243fso24797095ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706194; x=1739310994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQjv963bDn8vs1vNijlQJNkBfHhMzXuqY8JojgkIBc=;
        b=DAYfqHWs6trcSibPfZ+ReH7jsce3W4+dtstixqCzOhv4+cM2gQZwbTQiIM02j56wJx
         o4BljdulfSLNqygLUvDnk7Ytx7p018L9Mt7poLgFh6Up+UPKJgb8jYF048Ik8xraQauv
         AdWSqilgqlbEeHOCIs1aSKBMNulr2myIqzhiv3W2gztEGTmurD/p/oh3O7I29xd5+mHt
         Q8ZX9OOHHT0vwTvhl0hojEvwgxkONvaw/gs5DIfz3YcyB/81SWBRWQzv8MP23XPIkE+D
         5Lmg/MS5tGD9F4N811QW8Al9tZS92VDtznso2hA2e74O5c1KZ8TfCyJlFCFlq/XA7EbD
         2bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706194; x=1739310994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCQjv963bDn8vs1vNijlQJNkBfHhMzXuqY8JojgkIBc=;
        b=w2uDCPhDDRzIEGY9WaJhQqOH17igdCMluo1mxzKTouf4Bx0WbfdT3Tgz8gO3pC1D2R
         YtoRiWmMG7E3LqGhZjjomUViDHod/J+VXNP4GxT/jj7rFp9Jzgwj928q4MmpdtlcFenU
         82sywoeO6ajsUboVvBvpobNa5Z8MZ8SfShyKuqNgAv3XO/whjtdv5rZy/bhPRw5rewmU
         XFw5rh9JlCo0HEcjLkEtW37w3KQHs7be1m8AcGnnz0XJNkOlqhtN+R15yLzvGoUw0zNu
         Jkqs/daFFkCEscrdJnreMIcJgBgGpgQtCMuUNbPurLkpJFuMHCx9B5tz1fuBlt6Ak30y
         gvEQ==
X-Gm-Message-State: AOJu0YyXVDpeP8vbF2Kf5TYMPArNhaHlLOTB4a0Pza0jdvVT0IZLih5H
	uCYHtYJOm2Xd3KCbBzZyvCAfx+/A5I6cvVWxnWfe71UDg248Lr0yFi7lECisxIMor6OO7M06Eeq
	7
X-Gm-Gg: ASbGncsXim43f5uquW76qK1okv1C/y4Y9averN1kFOqN5+vX7fWCBh2xR3doGIVNl+7
	616bi4JRS3rsateX9otPzqTwxFJ+vvIkxbIFgDwvV9wUyNg2uQb6cKXs5reHb8gIxAFxD0tT5zj
	arSUxpTCsLNYUsiblw1Za5qxt5oh8/k9QVcFIy/hLwKhIvX3zkkjFngzYg/uH1b7phEdmGyUiM6
	SICIWow+qIJBkpiHksKQKB5qjtGx9Wg4DTQmzJ+uI+RMueL/dO3jiVIuJ6BkqfTixrMXBsfBOk=
X-Google-Smtp-Source: AGHT+IFhoRZ6ciJkTOhC8GiIyAbHlA5un1pb5yAzwPqmpzXj7z4mxkNlDD5FaBCAN1Gxiz+16KXv4Q==
X-Received: by 2002:a17:902:ce86:b0:215:431f:268f with SMTP id d9443c01a7336-21f17ddf316mr9252985ad.10.1738706194110;
        Tue, 04 Feb 2025 13:56:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31fcdd0sm102869805ad.103.2025.02.04.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:33 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v13 10/10] net: add helpers for setting a memory provider on an rx queue
Date: Tue,  4 Feb 2025 13:56:21 -0800
Message-ID: <20250204215622.695511-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers that properly prep or remove a memory provider for an rx
queue then restart the queue.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  5 ++
 net/core/netdev_rx_queue.c              | 69 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 4f0ffb8f6a0a..b3e665897767 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -22,6 +22,11 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
+int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+		    struct pp_memory_provider_params *p);
+void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+		      struct pp_memory_provider_params *old_p);
+
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
   * @pool:      the page pool to place the netmem into
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index db82786fa0c4..db46880f37cc 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -3,6 +3,7 @@
 #include <linux/netdevice.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "page_pool_priv.h"
 
@@ -80,3 +81,71 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	return err;
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
+
+static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+			     struct pp_memory_provider_params *p)
+{
+	struct netdev_rx_queue *rxq;
+	int ret;
+
+	if (ifq_idx >= dev->real_num_rx_queues)
+		return -EINVAL;
+	ifq_idx = array_index_nospec(ifq_idx, dev->real_num_rx_queues);
+
+	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	if (rxq->mp_params.mp_ops)
+		return -EEXIST;
+
+	rxq->mp_params = *p;
+	ret = netdev_rx_queue_restart(dev, ifq_idx);
+	if (ret) {
+		rxq->mp_params.mp_ops = NULL;
+		rxq->mp_params.mp_priv = NULL;
+	}
+	return ret;
+}
+
+int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+		    struct pp_memory_provider_params *p)
+{
+	int ret;
+
+	rtnl_lock();
+	ret = __net_mp_open_rxq(dev, ifq_idx, p);
+	rtnl_unlock();
+	return ret;
+}
+
+static void __net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+			      struct pp_memory_provider_params *old_p)
+{
+	struct netdev_rx_queue *rxq;
+
+	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+		return;
+
+	rxq = __netif_get_rx_queue(dev, ifq_idx);
+
+	/* Callers holding a netdev ref may get here after we already
+	 * went thru shutdown via dev_memory_provider_uninstall().
+	 */
+	if (dev->reg_state > NETREG_REGISTERED &&
+	    !rxq->mp_params.mp_ops)
+		return;
+
+	if (WARN_ON_ONCE(rxq->mp_params.mp_ops != old_p->mp_ops ||
+			 rxq->mp_params.mp_priv != old_p->mp_priv))
+		return;
+
+	rxq->mp_params.mp_ops = NULL;
+	rxq->mp_params.mp_priv = NULL;
+	WARN_ON(netdev_rx_queue_restart(dev, ifq_idx));
+}
+
+void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+		      struct pp_memory_provider_params *old_p)
+{
+	rtnl_lock();
+	__net_mp_close_rxq(dev, ifq_idx, old_p);
+	rtnl_unlock();
+}
-- 
2.43.5


