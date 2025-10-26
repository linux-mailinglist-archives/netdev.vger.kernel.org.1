Return-Path: <netdev+bounces-233015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7AC0AF9E
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DD89349B4A
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91D2D94B2;
	Sun, 26 Oct 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLTwouwb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF820B81B
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501314; cv=none; b=r6/86n99Ou58Ou8HNOJ+ik4OD6Wu4oU/OfPPSnjakYLd0mrbGVjO1FSREwRJIPWG/ULx7viMPF0czfvUjC5Jjfs7RQPo+ak0a7x6X4SpSRzEZw2UVKjCVM/1PY+tFVEKiV0eFbkTZ0IWF/hKrh8HRz4RSTch8CqFTasazkgVhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501314; c=relaxed/simple;
	bh=vPXyZhUr98DoEtjaUOrz2pul6CQKaY15VKlhW9SmfZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeE+oaXRrVRx5SP8VfMcCY2Ro0VVaJUEQmklAaBoBg3NY5J6TE3rwaovlfQ/q39hlt770Qao18Vpy90GpcJmIE7hlgs8aoC9Zs2ByqFd5ESpOCLD7vKya0PEO64Xq501yoh93rv5qWP10NpBE3zudcoQv0SP2qtWuChdaVguKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLTwouwb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso2738649a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761501312; x=1762106112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3VPBhgYc9AzZ5HmwB7K9s4eliJBfl7/sTbcR+X1J2o=;
        b=JLTwouwbqU7KfU9BR9mQmXO01AiQwfvbJTMUoH9M65YWPnFMDmr0Rv/2i6nYYvprnt
         LNX1rNIKk4CjWGRO8mKb0uhcPC+55e79LhSkfdc36pO2R6Nh257slIMnarAed0qhK+ph
         JLmQalXj2DuIhx7/pemvKAsE7QmE4uksW4kI6foITxiqcIAv6xIlSRv7dyjfef1/l5y/
         w4/cg++b6FoT1aytHUkA+siUS9UMP1LUNP5xroGF0InG+Pk5dcaJV1PilI7t8GTPcK38
         d8e4l2T6ma5n22cgXQS3ZFx3pNkAbu6ftD1V3pAxta/pVdnckQ6Llo26Appc5TPB04sT
         kKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501312; x=1762106112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3VPBhgYc9AzZ5HmwB7K9s4eliJBfl7/sTbcR+X1J2o=;
        b=tTQsygseerEuvTDALlRqom1JjHfxS0O1xvqJSFs3d85hrcZ4BVr6qQAR6UabxLVbp8
         JlLEFFt91+87DgAEV4PAyB4gn492jTxpfIDZZhSuqgiuuu9WJKkxuvFG19JhHYxidAfh
         WNhzCSrT0xY46oTmX2IgEHR5uWrLhYGRJXevMmrHZzZiFzfsjG/J2fVQB0NBa6WkgCF0
         0aHTWmtugCPTRuUhvoWiiZn1abvhkSQLqophgLUrBjibqDD/GNazaKl4RSw5LZQYqX3N
         +oy3AanGi09lMmEIDX7tYcvx5UwGSEn/IWpxVjbQwKzIcCQHDk5jmTaRI9VoQOGkeoOZ
         nigw==
X-Gm-Message-State: AOJu0YxKei0/d262B6B9seLMqmD8ch/q8dr8jqXgi/WMstf/+vNK+3Uu
	je/W9eAPD2/BEOKEUgZlIwSTppbp7rc7DqXgHlrVoZUE19pJ+ggDU0g9
X-Gm-Gg: ASbGncvAXllACvuGJGPAmSwyGLSR2nyveyBMhuqCeIKqZgtz9M04V5/Rk8uYghlfaA5
	PCWFhzV3TK3zvzDBdXtG3STn3R7Ig4QMtUWBOPx4d+6ko/t9BlkPiPutkDcPWIlD8+1uN9HuRqA
	+wWMa/fKci4qdIu0CmdXMs13IFsUUmISDmfNicmxrWfbfBfMK6AvnJwwR4KoC4C8kauZ5FHrilQ
	odYIX9/f0AXbvsNUiRHRpXNgNcXcyWwpekIwDoVMUAvRU3d3wVFjTUrT8ewyBWiNeU22g/iTuq3
	7AJ/XFaoj6H6vDKze2wpzXO9i/hIfWKtP6ivqe/WjtfzRJ8F9OhQcWND8JGtQ7ILm9Fljbfkj9l
	g+qYHkFRmcGjuaDyZOM/Txgev9QG98fGvPBBqDw/rr96I8/GWagiYXYGinx1pZnGC8rzgoxtQeN
	JlrMajVOVqNliPS1hcZEFYk3KWcxsKoCrxweKBAjGltv3M0kbGp1x8/1iTIhEXmgPHhYuZM5nsM
	MHfDQ==
X-Google-Smtp-Source: AGHT+IHnRmkvGJ1cgnzH+OspovISCZVBIxQ5/cQMF2dRcrfI90+m8rwM1XBEr5cxcpTd8e0LUrx8AA==
X-Received: by 2002:a17:903:1247:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-290cb07adc0mr423085965ad.46.1761501311978;
        Sun, 26 Oct 2025 10:55:11 -0700 (PDT)
Received: from debian.domain.name ([223.181.110.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm54813845ad.107.2025.10.26.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:55:11 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC PATCH net-next v2 1/2] net: Add ndo_write_rx_config and helper structs and functions:
Date: Sun, 26 Oct 2025 23:24:44 +0530
Message-ID: <20251026175445.1519537-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
References: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ndo_write_rx_config callback and helper structs/functions:

	rx_config_work - To schedule the callback and handle synchronization

	read_snapshot/update_snapshot - Helper functions to read/update the
		 rx_config snapshot

	set_and_schedule_rx_config - Helper function to call ndo_set_rx_mode
		 and schedule ndo_write_rx_config

	execute_write_rx_config - Helper function that will be scheduled
		 by rx_work->config_write

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/netdevice.h | 38 ++++++++++++++++++++++++++-
 net/core/dev.c            | 54 +++++++++++++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..80d6966d6981 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1100,7 +1100,12 @@ struct netdev_net_notifier {
  * void (*ndo_set_rx_mode)(struct net_device *dev);
  *	This function is called device changes address list filtering.
  *	If driver handles unicast address filtering, it should set
- *	IFF_UNICAST_FLT in its priv_flags.
+ *	IFF_UNICAST_FLT in its priv_flags. This sets up the snapshot of
+ *	rx_config that will be written to the device.
+ *
+ * void (*ndo_write_rx_config)(struct net_device *dev);
+ *	This function is scheduled immediately after ndo_set_rx_mode to
+ *	write rx_config to the device.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
@@ -1421,6 +1426,7 @@ struct net_device_ops {
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
 	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_write_rx_config)(struct net_device *dev);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1767,6 +1773,12 @@ enum netdev_reg_state {
 	NETREG_DUMMY,		/* dummy device for NAPI poll */
 };
 
+struct rx_config_work {
+	struct work_struct config_write;
+	struct net_device *dev;
+	spinlock_t config_lock;
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2082,6 +2094,8 @@ enum netdev_reg_state {
  *			dev_list, one per address-family.
  *	@hwprov: Tracks which PTP performs hardware packet time stamping.
  *
+ *	@rx_work: helper struct to schedule rx config write to the hardware.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2559,6 +2573,8 @@ struct net_device {
 
 	struct hwtstamp_provider __rcu	*hwprov;
 
+	struct rx_config_work *rx_work;
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
@@ -2734,6 +2750,26 @@ void dev_net_set(struct net_device *dev, struct net *net)
 	write_pnet(&dev->nd_net, net);
 }
 
+#define update_snapshot(config_ptr, type)						\
+	do {										\
+		typeof((config_ptr)) rx_config = ((type *)(dev->priv))->rx_config;	\
+		unsigned long flags;							\
+		spin_lock_irqsave(&((dev)->rx_work->config_lock), flags);		\
+		*rx_config = *(config_ptr);						\
+		spin_unlock_irqrestore(&((dev)->rx_work->config_lock), flags);		\
+	} while (0)
+
+#define read_snapshot(config_ptr, type)						\
+	do {										\
+		typeof((config_ptr)) rx_config = ((type *)(dev->priv))->rx_config;	\
+		unsigned long flags;							\
+		spin_lock_irqsave(&((dev)->rx_work->config_lock), flags);		\
+		*(config_ptr) = *rx_config;						\
+		spin_unlock_irqrestore(&((dev)->rx_work->config_lock), flags);		\
+	} while (0)
+
+void set_and_schedule_rx_config(struct net_device *dev, bool flush);
+
 /**
  *	netdev_priv - access network device private data
  *	@dev: network device
diff --git a/net/core/dev.c b/net/core/dev.c
index 2acfa44927da..2d3c6031e282 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9524,6 +9524,38 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
+static void execute_write_rx_config(struct work_struct *param)
+{
+	struct rx_config_work *rx_work = container_of(param,
+					 struct rx_config_work,
+					 config_write);
+	struct net_device *dev = rx_work->dev;
+
+	// This path should not be hit outside the work item
+	WARN_ON(!dev->netdev_ops->ndo_write_rx_config);
+	dev->netdev_ops->ndo_write_rx_config(dev);
+}
+
+/*
+ *	Sets up the rx_config snapshot and schedules write_rx_config. If
+ *	it's necessary to wait for completion of write_rx_config, set
+ *	flush to true.
+ */
+void set_and_schedule_rx_config(struct net_device *dev, bool flush)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (ops->ndo_set_rx_mode)
+		ops->ndo_set_rx_mode(dev);
+
+	if (ops->ndo_write_rx_config) {
+		schedule_work(&dev->rx_work->config_write);
+		if (flush)
+			flush_work(&dev->rx_work->config_write);
+	}
+}
+EXPORT_SYMBOL(set_and_schedule_rx_config);
+
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9532,8 +9564,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9554,8 +9584,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11914,9 +11943,17 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	refcount_set(&dev->dev_refcnt, 1);
 #endif
 
-	if (dev_addr_init(dev))
+	dev->rx_work = kmalloc(sizeof(*dev->rx_work), GFP_KERNEL);
+	if (!dev->rx_work)
 		goto free_pcpu;
 
+	dev->rx_work->dev = dev;
+	spin_lock_init(&dev->rx_work->config_lock);
+	INIT_WORK(&dev->rx_work->config_write, execute_write_rx_config);
+
+	if (dev_addr_init(dev))
+		goto free_rx_work;
+
 	dev_mc_init(dev);
 	dev_uc_init(dev);
 
@@ -11998,6 +12035,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	free_netdev(dev);
 	return NULL;
 
+free_rx_work:
+	cancel_work_sync(&dev->rx_work->config_write);
+	kfree(dev->rx_work);
+
 free_pcpu:
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
@@ -12083,6 +12124,9 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	cancel_work_sync(&dev->rx_work->config_write);
+	kfree(dev->rx_work);
+
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
 	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
-- 
2.47.3


