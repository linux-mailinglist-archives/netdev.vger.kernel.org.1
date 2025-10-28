Return-Path: <netdev+bounces-233606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D012C16475
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62733AC858
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AD34DCDF;
	Tue, 28 Oct 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eddZkTuW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48A34C9A1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673373; cv=none; b=FoeDpcUWqoUH7P8cNxqsZ+BcQ/gqQk3wXqyqTw7D8YP+Kzkcp0TFjg/8LRJGxH4zLxfZAyOgUQUnwoIaVTANs8mNxmebmGdWP5cftGlrRH8UHslJNVrc0ajhCCKxfCufeoObDssEyvHH56dserZm3n0dsLS9HkERvrXekjqkv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673373; c=relaxed/simple;
	bh=6v4wjgebPozLKUgfPJH5/qazZjK7CJHOf35355Wnrh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiqhAe81Pv27Y6ZBSgr1Zgyx13r3VL7K773P5FvpirBz5HNYXipwQz9P/ImBMD6bKTWBeyRiDcEs5CoaOB/8orGbOsAdXqyLdHx8o6jNnPtC/k4/bC6gD4OMl5MIAM/17wBJaFiGaaZe6n6GQybMhnbpn56MJXKyNWdvNQJ3OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eddZkTuW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so124578b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673371; x=1762278171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CmgKRjxqZ78TC/moM+aLGRRq1ZpH43SB88rhbo0/Vo=;
        b=eddZkTuWFeKasSR8uxsAbOvFKMc6xw0XfVaLl1yMyYW4rqkjJQB0H6Nw2NU5VSa83/
         qxlu+6sQ3ohVdkVH9AwI9y54F6orD10wlFyS5qcURMfZlmVuloJ6B0Jf9SI+Gb5uRv7A
         B8O+ywkfeNMWPw3QTWROX8SmGjkZ+jBqcmW5Sf054AlWKXHxYYv4bLQrSfEvWV9dY4uJ
         pAF2iPppu275yzGg7R/8lAfExfKm77HxYykEcyngvwiyO4BJp53Mz+VKD+oUU5ZjISWr
         CniwzGhbQDwOegWM3ido0wmhpt69Rzx7dGyoxKoKNVRsD+gfsYMGnT1lLPiWeuCWuOlE
         40Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673371; x=1762278171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CmgKRjxqZ78TC/moM+aLGRRq1ZpH43SB88rhbo0/Vo=;
        b=e+Zwr3+c2tyWMVg2BvlkWN+ubhzxxbHcaXjjl49PhS2vLQ6CpXSK9QAaSvmSRfqug0
         MPxQpIopQEvE58GxOCjDvpI9Y5lhhiTXvLjgI8RodLvZiT6S3IQRxMtWz1C79C4B2EtR
         LypvfRtqbdicKhcYO2vb4lqiWG/IGo6WJExHztVFwv4DOuAus8aHgt+ZjFKX58fcoDQR
         dqNTt2yHdycuq8RH1lJTDkXesn+5Y5vhmdrpIff+nQTI3bgaGkmI6wWuxbjjpGUaZfmW
         H8392wVJkF1wrKkDoZUdYdLUEbJ7jqgyzC888JxT1j9EyR//4fdnmVjPxWamKf5xQEvX
         mcLA==
X-Gm-Message-State: AOJu0YwHIugmW7xOGT0aHRWWbL5Fv61a9RmsJvKxZNGbUR3QJN4rk6C5
	lLdUX3p+to9LWaIj4j0QsLT3yICtoOK6JP1b09DrGKi5rOXsXyPkHmoE
X-Gm-Gg: ASbGncueYu7pVDyMdVdFhVvfg+VKBvOSDMsq/KaiJ4FKuECfY8Y1/MUtt8Qdj7iGxua
	Ts0+F4jXog5MbmfklrbWoeu9waEkG69lsQwxPapEmmkuNHq0WYkN30Tq2ym1JdnF0Z7xXy78aBO
	SwAtGDera8NFPLg0InZ0a//1k49v5g4nqslfv+v1p9OWBsVQAO/0tm6K2MreVTskAJmZNOpyuO8
	xwAGQLoaFr61YdZFb5Sa1F28j7fcfWKcgybDSRFYL8c03GpZSeLsP5IEYX9P2xh/URVGUJ7b2Or
	U8I331gIwUupcOIOX70etpn4Z8AtalSYqzdDRtjlcpdIeBsxQm8J8uG4HBPNNWd0aDkqCt3xjds
	UvhyrIEHuy3oGvfMgqmhg2bzcknd11B9trwsmV7igY8iSImXDsCXEMQK93d4Kr/oLLVYd8XoGRH
	dxLoWaYVsiKqOpgu64/eMPsQklbJSdNhJCo1rGE0yA0bkoVbmybcM2vS6WD+8mC+3NIPZ2beCgj
	5aBEA==
X-Google-Smtp-Source: AGHT+IF7n2P9v4I116Y5WIJSgeGFxuUTJM6UJ4Tic/BqkwkkiA9qVF8XSZ650kwCzK0xRThK/PyTsQ==
X-Received: by 2002:a05:6a21:ad16:b0:345:483a:48ae with SMTP id adf61e73a8af0-345483a4a8amr3360888637.12.1761673370932;
        Tue, 28 Oct 2025 10:42:50 -0700 (PDT)
Received: from debian.domain.name ([223.181.113.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm11086746a12.1.2025.10.28.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:50 -0700 (PDT)
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
Subject: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and helper structs and functions:
Date: Tue, 28 Oct 2025 23:12:21 +0530
Message-ID: <20251028174222.1739954-2-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
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
 include/linux/netdevice.h | 38 +++++++++++++++++++++++++++-
 net/core/dev.c            | 53 +++++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f5aad5cc9a1..9f188229443c 100644
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
index 378c2d010faf..69b8bfc0edeb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9571,6 +9571,37 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
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
+/*	Sets up the rx_config snapshot and schedules write_rx_config. If
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
@@ -9579,8 +9610,6 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
  */
 void __dev_set_rx_mode(struct net_device *dev)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
-
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags&IFF_UP))
 		return;
@@ -9601,8 +9630,7 @@ void __dev_set_rx_mode(struct net_device *dev)
 		}
 	}
 
-	if (ops->ndo_set_rx_mode)
-		ops->ndo_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 }
 
 void dev_set_rx_mode(struct net_device *dev)
@@ -11961,9 +11989,17 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
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
 
@@ -12045,6 +12081,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	free_netdev(dev);
 	return NULL;
 
+free_rx_work:
+	cancel_work_sync(&dev->rx_work->config_write);
+	kfree(dev->rx_work);
+
 free_pcpu:
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
@@ -12130,6 +12170,9 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	cancel_work_sync(&dev->rx_work->config_write);
+	kfree(dev->rx_work);
+
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
 	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
-- 
2.34.1


