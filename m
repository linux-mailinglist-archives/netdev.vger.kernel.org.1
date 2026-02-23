Return-Path: <netdev+bounces-260069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD+AKrxrnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7771785F0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789863101E10
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1BF26B2CE;
	Mon, 23 Feb 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IQZxX/Yy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A245BE3
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858571; cv=none; b=Yf7QbtvTscwwyKLhxk53wmN9iR7NnJmqok+hXQXiMZdoTN7+/NWXT5nACEekF3RP5XK5BNEpuWdAy4dgsuYo3jXAYmyUs6ZTQuBeKTxJIL3EGrLIwEqU6Lc2rW3ScQGerJbZm7Zc0a9nGzi7/diJqFaRLYl7bKTwMCDu2QZxrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858571; c=relaxed/simple;
	bh=DOtV5eYc3cFeREfX7uYoDOObGBP5HXyf3mKaE7+zx7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFVvfIxXea1cYnNG4X70rpx+i+IbW0m/d9QfSVJ04Kef658+lFizrLbUmTCFqjEeykT6JQoPL0Hg0YrGpgnq+PW1U0VprlkvVv9jpWdkT8C3fhSEkUQhpGzxZ6I96Gj3G4CAvmj8CBChj51vg/J8fioF/PXu0QkP3LRLWW2mUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IQZxX/Yy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43622089851so4450246f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858568; x=1772463368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azNcwCqm/OhCBY0hL9l3npdXuViTH3DRFOheEn8bsNU=;
        b=IQZxX/YyMGbj/PHtbuCJXGqmLs2Zk2W4r3v6/JFAduKgE9MI+gLljCtvysel7/4zJU
         mFwbhpqYJo2QVc+f2Gse6ivKwqk25D60imZnKJRWFedgn6m2DqmpIlMkp6A6e198YZW/
         J9W9n432HuQzY/yHQIpIQ6UrIP2dbaKjUWgpD6JkjMDJkHmXCWKhOPtafGFgFAMw9FmG
         ht/ciLZEUEtFtdxJ1cgrrAKWPIdEn5ol86ZkCALIKahxQvue97nC/ssKNpanSVIKyopA
         Yw4BW9HtGKKUsceAOMFt1eribbWUc0PQUtb0rUY2PB7kX5t7L0LVtts7e3ihFVSPBM/Y
         FZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858568; x=1772463368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azNcwCqm/OhCBY0hL9l3npdXuViTH3DRFOheEn8bsNU=;
        b=c6OoZUkF0ovBx1NPRZE6L2sjX/yU4QbpGMPTMUMZsfrqwcroqfHzKzzt6JVEW6lzAw
         EHlqObIW/jZ2c0KuqGEy6BBbhrqS5bOIwL1//SdnYw96gt6DtyuyXSbntWBCivodWPi9
         n5scVNzJbF7F8xaDjRWTjzUT17mCsCHvc9z9uRJ5YaPqw+BI2N9nfTxD4aDJoADo4O31
         iYSDV1DFWNg7ZIn+bNJSlza/2YQYp+d/LMepr1iP/dexuQxQo78yQeQk9cNNG3XkTf5Z
         S/3ckni6fnpqgpEOqKtI9FqQJrbb2WI2U+oN+HDLzi4okemiSvbTGQTxebTR3B4/xGLG
         /zFw==
X-Gm-Message-State: AOJu0Yzqi6g2m8CdFUj+C5tqU9fs7rfKPElVUGYbRgGdTYoliWZ4pOLQ
	wxhZufI5H3hN5ytmlmhJe0rXCfztuaxUcJK3CUx79USFZQ1GDuJjO1rHhpT8S9QXzuEmkqHWuqw
	gyHjj
X-Gm-Gg: ATEYQzxpxK88VCB9+C012ozcACMRB15awZOnuu/Tuvo+rSx5rdMm7yM2vx+QpRXsVsN
	nRR2+A3Fwd8FAEAfc7ieQ14GNTrpyBERTWYK+t73kaiWUrLYlhk0Lr+MhCmvTPhSZpTDSDU50WN
	Jztjg4HUB4kfsZSliltlZCFcQiFiDaV00pWMwmpBRpr59xLpymR1IVcGOwg/Yh6SNqAXJWjxxLG
	g0K4jLtHL/UadTrDASAARkOlqJq5coto/95O15fKkGIIJmzabQ2XWvJgQ29T9ahlePwMH7qP7jE
	zAFt4SXl8c03Bmn8mqsZlswIIurnlklY6q6OhgLR07jknRY/u1JYyWxPCUHm9E2p9zaER0X6dLw
	8izoftssI8ieBRCq89YNyLOFXw5RD5ZxjmfRjKLF/1+96abWy+5z1xIGy4C2DbKfzKtsc7m9Nvv
	nuIGxhDxp3304ygg==
X-Received: by 2002:a05:6000:4381:b0:436:369f:3a00 with SMTP id ffacd0b85a97d-4396f187c61mr15488650f8f.50.1771858568038;
        Mon, 23 Feb 2026 06:56:08 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00c18sm19349079f8f.14.2026.02.23.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:07 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 07/10] devlink: allow devlink instance allocation without a backing device
Date: Mon, 23 Feb 2026 15:55:54 +0100
Message-ID: <20260223145557.248679-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223145557.248679-1-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260069-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0A7771785F0
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Allow devlink_alloc_ns() to be called with dev=NULL to support
device-less devlink instances. When dev is NULL, the instance is
identified over netlink using "devlink_index" as bus_name and
the decimal index value as dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/core.c           | 26 +++++++++++++++++++++-----
 net/devlink/dev.c            | 11 +++++++----
 net/devlink/devl_internal.h  |  4 ++--
 net/devlink/port.c           | 14 +++++++++-----
 5 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 85e83a3b082a..9cdda570e584 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -330,7 +330,10 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
-	put_device(devlink->dev);
+	if (devlink->dev)
+		put_device(devlink->dev);
+	else
+		kfree(devlink->dev_name);
 	kvfree(devlink);
 }
 
@@ -445,7 +448,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -453,14 +456,22 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (!devlink)
 		return NULL;
 
+	if (dev) {
+		devlink->dev = get_device(dev);
+		devlink->bus_name = dev->bus->name;
+		devlink->dev_name = dev_name(dev);
+	} else {
+		devlink->bus_name = DEVLINK_INDEX_BUS_NAME;
+		devlink->dev_name = kasprintf(GFP_KERNEL, "%u", devlink->index);
+		if (!devlink->dev_name)
+			goto err_kasprintf;
+	}
+
 	ret = xa_alloc_cyclic(&devlinks, &devlink->index, devlink, xa_limit_31b,
 			      &last_id, GFP_KERNEL);
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = get_device(dev);
-	devlink->bus_name = dev->bus->name;
-	devlink->dev_name = dev_name(dev);
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
@@ -486,6 +497,11 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	return devlink;
 
 err_xa_alloc:
+	if (devlink->dev)
+		put_device(devlink->dev);
+	else
+		kfree(devlink->dev_name);
+err_kasprintf:
 	kvfree(devlink);
 	return NULL;
 }
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index e3a36de4f4ae..b63597312bbd 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -453,7 +453,8 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	 * (e.g., PCI reset) and to close possible races between these
 	 * operations and probe/remove.
 	 */
-	device_lock_assert(devlink->dev);
+	if (devlink->dev)
+		device_lock_assert(devlink->dev);
 
 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
 	       sizeof(remote_reload_stats));
@@ -892,9 +893,11 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto err_cancel_msg;
 	}
 
-	err = devlink_nl_driver_info_get(dev->driver, &req);
-	if (err)
-		goto err_cancel_msg;
+	if (dev) {
+		err = devlink_nl_driver_info_get(dev->driver, &req);
+		if (err)
+			goto err_cancel_msg;
+	}
 
 	genlmsg_end(msg, hdr);
 	return 0;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 67425c5d8cfc..89d08fd511cb 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -107,7 +107,7 @@ static inline bool devl_is_registered(struct devlink *devlink)
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 {
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_lock(devlink->dev);
 	devl_lock(devlink);
 }
@@ -115,7 +115,7 @@ static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 {
 	devl_unlock(devlink);
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_unlock(devlink->dev);
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1d4a79c6d4d3..f19b690ebe7e 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -976,7 +976,9 @@ static void devlink_port_type_warn(struct work_struct *work)
 	struct devlink_port *port = container_of(to_delayed_work(work),
 						 struct devlink_port,
 						 type_warn_dw);
-	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
+	if (port->devlink->dev)
+		dev_warn(port->devlink->dev,
+			 "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
@@ -1242,9 +1244,10 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  */
 void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	dev_warn(devlink_port->devlink->dev,
-		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-		 devlink_port->index);
+	if (devlink_port->devlink->dev)
+		dev_warn(devlink_port->devlink->dev,
+			 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+			 devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -1272,7 +1275,8 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
  */
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
-	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
+	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH &&
+	    devlink_port->devlink->dev)
 		dev_warn(devlink_port->devlink->dev,
 			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
 			 devlink_port->index);
-- 
2.51.1


