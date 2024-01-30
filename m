Return-Path: <netdev+bounces-67338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BD842DA2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031EA1F252B5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D7762F4;
	Tue, 30 Jan 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="qokZFpw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328BD762DE
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645993; cv=none; b=MSBaUCEQkNt4KdMiccB2XWJFFTlRHN7YBBhr/fOV0Jzauo3j6ZJlhNW28Wddst66OlAAp0ZDK0VmKxGD+nWIYMWKEWPF7nugPdWXDcrOxfHHsWtSP452iNcxwvEwl9YVHw/xEMxu2n+hjZWVes+RcguPfKtMv2uMJ4GG/NMYws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645993; c=relaxed/simple;
	bh=BapIGbjTv4sPl9p+qsdrvQS42GSfWfLQDFaWd63oDPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZz14zngCEDVWpCNsumbF2q/VbyG9ej4SdNRlowqtCH46vTUxeOimRTIYK8JfUebzE1LI369yamxmsnXzQpjG348AeblonC4HAvbmYDTCj07XV7ef1rYICmIuKLx543opwJERULed328F/nkDnLlIR/1YeIPnlE8cSiLwCdhqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=qokZFpw+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51121637524so656704e87.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645989; x=1707250789; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6IqLnC7Qt5c9O6JLoW4lXxD7qv4Fiq09H4uLYuiQRTQ=;
        b=qokZFpw+ktITi9NHTIrEofKMviN4fx8OsCyo/g2yzQL7kKI4j2bYmQCVwTXGiGgaKC
         3/oBbWauQj8aeGBDixsiJKq5OrzX3NBy8pb+noBvtdSO1FwwwIiDoj7jBvx/zwJJPgO5
         Ci2TsjoR4BCrYGQOT2qbQWvvoCttz9e8Rz/kMqI/1fSBPjUX1IWpjaHjp+RBRs2EE4CM
         0/8+Y2JHNjAFeRWw4gdf4/n6RJIaZUn0b+h2LiBD5eMx0+wbiRicg4mYp+8QfL8mJTPq
         z4oijAQicRgxXrTBoO/UQS7Ow5tM/ouoQYA1NpxhVAbNmlCbcAkU3Bq1c4aL3mbFrZYn
         /ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645989; x=1707250789;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IqLnC7Qt5c9O6JLoW4lXxD7qv4Fiq09H4uLYuiQRTQ=;
        b=sdsZfdiZY49+cXl6onxuq36yFiy3gLla260dpiet1IqHehun0ZzvqDhXUYSRC4TkgA
         +ZliM1628/SRBVlzAijCOTnM1cbNR/m7grZOvEREey/CqGtRuu/qqMf/q3uapGpiPciR
         d9aMWJSoCbLQBlzZeXtZ3aQVYYCyhhu6Bx8wrK3E1Yt4OlV4wRyJCMu1KeoFKVFVf+rp
         N65XHDC87Zc0NVuRcKlI3qEMmuXSdaOIAi13/qGFmKlgAZbpX6pGRmiMaO0hq9PPPm8j
         mfQgNYX7jb2ggrMtn2Qh4L9xDBmkNbGdNxXOFDhvFjUG9OCSSeLrpudCbTyswfp0AveQ
         J4Qg==
X-Gm-Message-State: AOJu0Yzv6rMoZnCQIiWT/mB6xahT10uAoIm33f7opl4RHJ5SG3vwsrVy
	e/NHwG2mOxDZK82E/4sEDYj7FePuDuXn8AKwurmRQaSmVcIkQl29e5TOFbGbswY=
X-Google-Smtp-Source: AGHT+IG9xBVa3UbjflAWcqCxOCqVmwqzOVXMJ08I7VEJoBUQtKwgVTlomzljcxK9lFma3n16UnFzEw==
X-Received: by 2002:ac2:47f2:0:b0:50e:7702:a189 with SMTP id b18-20020ac247f2000000b0050e7702a189mr7301248lfp.22.1706645989212;
        Tue, 30 Jan 2024 12:19:49 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:48 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 4/5] net: switchdev: Prepare deferred notifications before enqueuing them
Date: Tue, 30 Jan 2024 21:19:36 +0100
Message-Id: <20240130201937.1897766-5-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Instead of having a separate format for storing the canned objects and
attributes going to the deferred queue, store it using the
notification structures that will be needed once the item is dequeued
and sent to the driver.

This will be useful when we add switchdev tracepoints, as we can
uniformly trace deferred and immediate calls.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/switchdev/switchdev.c | 307 +++++++++++++++++++-------------------
 1 file changed, 156 insertions(+), 151 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index e50863a03095..309e6d68b179 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -22,17 +22,103 @@
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
-typedef void switchdev_deferred_func_t(struct net_device *dev,
-				       const void *data);
-
 struct switchdev_deferred_item {
 	struct list_head list;
-	struct net_device *dev;
+
+	enum switchdev_notifier_type nt;
+	union {
+		/* Guaranteed to be first in all subtypes */
+		struct switchdev_notifier_info info;
+
+		struct {
+			struct switchdev_notifier_port_attr_info info;
+			struct switchdev_attr attr;
+		} attr;
+
+		struct {
+			struct switchdev_notifier_port_obj_info info;
+			union {
+				struct switchdev_obj_port_vlan vlan;
+				struct switchdev_obj_port_mdb mdb;
+			};
+		} obj;
+	};
 	netdevice_tracker dev_tracker;
-	switchdev_deferred_func_t *func;
-	unsigned long data[];
 };
 
+static int switchdev_port_notify(struct net_device *dev,
+				 enum switchdev_notifier_type nt,
+				 struct switchdev_notifier_info *info,
+				 struct netlink_ext_ack *extack)
+{
+	const struct switchdev_notifier_port_attr_info *attri;
+	const struct switchdev_notifier_port_obj_info *obji;
+	int err;
+	int rc;
+
+	rc = call_switchdev_blocking_notifiers(nt, dev, info, extack);
+	err = notifier_to_errno(rc);
+
+	switch (nt) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		attri = container_of(info, typeof(*attri), info);
+		if (err) {
+			WARN_ON(!attri->handled);
+			return err;
+		}
+		if (!attri->handled)
+			return -EOPNOTSUPP;
+		break;
+	case SWITCHDEV_PORT_OBJ_ADD:
+	case SWITCHDEV_PORT_OBJ_DEL:
+		obji = container_of(info, typeof(*obji), info);
+		if (err) {
+			WARN_ON(!obji->handled);
+			return err;
+		}
+		if (!obji->handled)
+			return -EOPNOTSUPP;
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static void switchdev_deferred_notify(struct switchdev_deferred_item *dfitem)
+{
+	const struct switchdev_attr *attr;
+	const struct switchdev_obj *obj;
+	char info_str[128];
+	int err;
+
+	err = switchdev_port_notify(dfitem->info.dev, dfitem->nt, &dfitem->info, NULL);
+	if (err && err != -EOPNOTSUPP) {
+		switchdev_notifier_str(dfitem->nt, &dfitem->info,
+				       info_str, sizeof(info_str));
+		netdev_err(dfitem->info.dev,
+			   "deferred switchdev call failed (err=%d): %s",
+			   err, info_str);
+	}
+
+	switch (dfitem->nt) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		attr = &dfitem->attr.attr;
+		if (attr->complete)
+			attr->complete(dfitem->info.dev, err, attr->complete_priv);
+		break;
+	case SWITCHDEV_PORT_OBJ_ADD:
+	case SWITCHDEV_PORT_OBJ_DEL:
+		obj = dfitem->obj.info.obj;
+		if (obj->complete)
+			obj->complete(dfitem->info.dev, err, obj->complete_priv);
+		break;
+	default:
+		break;
+	}
+}
+
 static struct switchdev_deferred_item *switchdev_deferred_dequeue(void)
 {
 	struct switchdev_deferred_item *dfitem;
@@ -63,8 +149,8 @@ void switchdev_deferred_process(void)
 	ASSERT_RTNL();
 
 	while ((dfitem = switchdev_deferred_dequeue())) {
-		dfitem->func(dfitem->dev, dfitem->data);
-		netdev_put(dfitem->dev, &dfitem->dev_tracker);
+		switchdev_deferred_notify(dfitem);
+		netdev_put(dfitem->info.dev, &dfitem->dev_tracker);
 		kfree(dfitem);
 	}
 }
@@ -79,19 +165,9 @@ static void switchdev_deferred_process_work(struct work_struct *work)
 
 static DECLARE_WORK(deferred_process_work, switchdev_deferred_process_work);
 
-static int switchdev_deferred_enqueue(struct net_device *dev,
-				      const void *data, size_t data_len,
-				      switchdev_deferred_func_t *func)
+static int switchdev_deferred_enqueue(struct switchdev_deferred_item *dfitem)
 {
-	struct switchdev_deferred_item *dfitem;
-
-	dfitem = kmalloc(struct_size(dfitem, data, data_len), GFP_ATOMIC);
-	if (!dfitem)
-		return -ENOMEM;
-	dfitem->dev = dev;
-	dfitem->func = func;
-	memcpy(dfitem->data, data, data_len);
-	netdev_hold(dev, &dfitem->dev_tracker, GFP_ATOMIC);
+	netdev_hold(dfitem->info.dev, &dfitem->dev_tracker, GFP_ATOMIC);
 	spin_lock_bh(&deferred_lock);
 	list_add_tail(&dfitem->list, &deferred);
 	spin_unlock_bh(&deferred_lock);
@@ -99,62 +175,24 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
-				      struct net_device *dev,
-				      const struct switchdev_attr *attr,
-				      struct netlink_ext_ack *extack)
+static int switchdev_port_attr_defer(struct net_device *dev,
+				     const struct switchdev_attr *attr)
 {
-	int err;
-	int rc;
-
-	struct switchdev_notifier_port_attr_info attr_info = {
-		.attr = attr,
-		.handled = false,
-	};
-
-	rc = call_switchdev_blocking_notifiers(nt, dev,
-					       &attr_info.info, extack);
-	err = notifier_to_errno(rc);
-	if (err) {
-		WARN_ON(!attr_info.handled);
-		return err;
-	}
+	struct switchdev_deferred_item *dfitem;
 
-	if (!attr_info.handled)
-		return -EOPNOTSUPP;
+	dfitem = kzalloc(sizeof(*dfitem), GFP_ATOMIC);
+	if (!dfitem)
+		return -ENOMEM;
 
+	dfitem->nt = SWITCHDEV_PORT_ATTR_SET;
+	dfitem->info.dev = dev;
+	dfitem->attr.attr = *attr;
+	dfitem->attr.info.attr = &dfitem->attr.attr;
+	dfitem->attr.info.handled = false;
+	switchdev_deferred_enqueue(dfitem);
 	return 0;
 }
 
-static int switchdev_port_attr_set_now(struct net_device *dev,
-				       const struct switchdev_attr *attr,
-				       struct netlink_ext_ack *extack)
-{
-	return switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
-					  extack);
-}
-
-static void switchdev_port_attr_set_deferred(struct net_device *dev,
-					     const void *data)
-{
-	const struct switchdev_attr *attr = data;
-	int err;
-
-	err = switchdev_port_attr_set_now(dev, attr, NULL);
-	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to set attribute (id=%d)\n",
-			   err, attr->id);
-	if (attr->complete)
-		attr->complete(dev, err, attr->complete_priv);
-}
-
-static int switchdev_port_attr_set_defer(struct net_device *dev,
-					 const struct switchdev_attr *attr)
-{
-	return switchdev_deferred_enqueue(dev, attr, sizeof(*attr),
-					  switchdev_port_attr_set_deferred);
-}
-
 /**
  *	switchdev_port_attr_set - Set port attribute
  *
@@ -169,73 +207,75 @@ int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
 			    struct netlink_ext_ack *extack)
 {
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.handled = false,
+	};
+
 	if (attr->flags & SWITCHDEV_F_DEFER)
-		return switchdev_port_attr_set_defer(dev, attr);
+		return switchdev_port_attr_defer(dev, attr);
+
 	ASSERT_RTNL();
-	return switchdev_port_attr_set_now(dev, attr, extack);
+	return switchdev_port_notify(dev, SWITCHDEV_PORT_ATTR_SET,
+				     &attr_info.info, extack);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_attr_set);
 
-static size_t switchdev_obj_size(const struct switchdev_obj *obj)
+static int switchdev_port_obj_defer(struct net_device *dev,
+				    enum switchdev_notifier_type nt,
+				    const struct switchdev_obj *obj)
 {
+	const struct switchdev_obj_port_vlan *vlan;
+	const struct switchdev_obj_port_mdb *mdb;
+	struct switchdev_deferred_item *dfitem;
+
+	dfitem = kzalloc(sizeof(*dfitem), GFP_ATOMIC);
+	if (!dfitem)
+		return -ENOMEM;
+
+	dfitem->nt = nt;
+	dfitem->info.dev = dev;
+	dfitem->obj.info.handled = false;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		return sizeof(struct switchdev_obj_port_vlan);
+		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+		dfitem->obj.vlan = *vlan;
+		dfitem->obj.info.obj = &dfitem->obj.vlan.obj;
+		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
-		return sizeof(struct switchdev_obj_port_mdb);
 	case SWITCHDEV_OBJ_ID_HOST_MDB:
-		return sizeof(struct switchdev_obj_port_mdb);
+		mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+		dfitem->obj.mdb = *mdb;
+		dfitem->obj.info.obj = &dfitem->obj.mdb.obj;
+		break;
 	default:
-		BUG();
+		goto err_free;
 	}
+
+	switchdev_deferred_enqueue(dfitem);
 	return 0;
+
+err_free:
+	kfree(dfitem);
+	return -EINVAL;
 }
 
-static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
-				     struct net_device *dev,
-				     const struct switchdev_obj *obj,
-				     struct netlink_ext_ack *extack)
+static int switchdev_port_obj_op(struct net_device *dev,
+				 enum switchdev_notifier_type nt,
+				 const struct switchdev_obj *obj,
+				 struct netlink_ext_ack *extack)
 {
-	int rc;
-	int err;
-
 	struct switchdev_notifier_port_obj_info obj_info = {
 		.obj = obj,
 		.handled = false,
 	};
 
-	rc = call_switchdev_blocking_notifiers(nt, dev, &obj_info.info, extack);
-	err = notifier_to_errno(rc);
-	if (err) {
-		WARN_ON(!obj_info.handled);
-		return err;
-	}
-	if (!obj_info.handled)
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-static void switchdev_port_obj_add_deferred(struct net_device *dev,
-					    const void *data)
-{
-	const struct switchdev_obj *obj = data;
-	int err;
+	if (obj->flags & SWITCHDEV_F_DEFER)
+		return switchdev_port_obj_defer(dev, nt, obj);
 
 	ASSERT_RTNL();
-	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					dev, obj, NULL);
-	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to add object (id=%d)\n",
-			   err, obj->id);
-	if (obj->complete)
-		obj->complete(dev, err, obj->complete_priv);
-}
-
-static int switchdev_port_obj_add_defer(struct net_device *dev,
-					const struct switchdev_obj *obj)
-{
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_add_deferred);
+	return switchdev_port_notify(dev, nt, &obj_info.info, extack);
 }
 
 /**
@@ -252,42 +292,10 @@ int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
 			   struct netlink_ext_ack *extack)
 {
-	if (obj->flags & SWITCHDEV_F_DEFER)
-		return switchdev_port_obj_add_defer(dev, obj);
-	ASSERT_RTNL();
-	return switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
-					 dev, obj, extack);
+	return switchdev_port_obj_op(dev, SWITCHDEV_PORT_OBJ_ADD, obj, extack);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_add);
 
-static int switchdev_port_obj_del_now(struct net_device *dev,
-				      const struct switchdev_obj *obj)
-{
-	return switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_DEL,
-					 dev, obj, NULL);
-}
-
-static void switchdev_port_obj_del_deferred(struct net_device *dev,
-					    const void *data)
-{
-	const struct switchdev_obj *obj = data;
-	int err;
-
-	err = switchdev_port_obj_del_now(dev, obj);
-	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to del object (id=%d)\n",
-			   err, obj->id);
-	if (obj->complete)
-		obj->complete(dev, err, obj->complete_priv);
-}
-
-static int switchdev_port_obj_del_defer(struct net_device *dev,
-					const struct switchdev_obj *obj)
-{
-	return switchdev_deferred_enqueue(dev, obj, switchdev_obj_size(obj),
-					  switchdev_port_obj_del_deferred);
-}
-
 /**
  *	switchdev_port_obj_del - Delete port object
  *
@@ -300,10 +308,7 @@ static int switchdev_port_obj_del_defer(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj)
 {
-	if (obj->flags & SWITCHDEV_F_DEFER)
-		return switchdev_port_obj_del_defer(dev, obj);
-	ASSERT_RTNL();
-	return switchdev_port_obj_del_now(dev, obj);
+	return switchdev_port_obj_op(dev, SWITCHDEV_PORT_OBJ_DEL, obj, NULL);
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
-- 
2.34.1


