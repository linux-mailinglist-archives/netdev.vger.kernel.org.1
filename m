Return-Path: <netdev+bounces-248300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B5D06AF9
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311D0302FBFB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47621DE885;
	Fri,  9 Jan 2026 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw3zlYK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC619DF62
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920958; cv=none; b=G5z2aO1aGnXBj69TgI5R2TTBXASQSEMdca0Up/ZujuiHPhbxXEs2ugSZAgF+DjbpKQqG2TUcPp2c3G9VBUL3+nGd0y1xtBPMyR3NdCFWsznCzoUKBYdhptC6ewHRACsuGkiUG6viEi+JFxIpHJe5sXSQ1ilT66TdHvRZgcF21n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920958; c=relaxed/simple;
	bh=qvZwfaPu5uCnTFXPKEZcwVmhpe79e1kDhuHev9xryz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8bHaZarCGA6hDUka1qfgsjEYK+VHNHck7+rXlL3m2Xywu5tpsefV3DgxBPWjkE4HWXykPt9Ki/MttZ0aOpMnwqChy4VymZ9DOl8/rqGGPesa0Hd5UirqiJoUzrLl1BpCVj8/B1m4jvM6yJcX77O8djSIv24+fpVjpVojxdlsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw3zlYK3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43277900fb4so1146206f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920953; x=1768525753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAturvmtQMGHtwjZ7axIFXlswJwZwqsgBCrBhkrK37g=;
        b=Dw3zlYK3rFzGCIgIicTeNT2IPIrR8MIDOaV0Q1jGE6dhCGZ1VViZhA4PQsunUjHuB+
         kpB+eprhPsKPwcPgmWMXWs+6eMwnw9zxtr4ZfvMm1/9Mv0hX+PgfEuhe1aa8DhRhXTPG
         b2A6OvS1d9PynPLThrw3EG4seZJmopVIVCbZ0sQ64Axbw61w11Y0TixhUHgNkj/kQh0p
         Z56fteAbAhYATu8ru4aXI/M+Xf5qphFTL0bnEXA2GXHHnaIxTs1pOqzU7g655oiNgagC
         vxMIR/NePlSYaGUCZ8RVK0WFM/d7lp2GrABCgW0GQ7rHN00lsWd9XE+XhHM5czZ38W2g
         jihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920953; x=1768525753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAturvmtQMGHtwjZ7axIFXlswJwZwqsgBCrBhkrK37g=;
        b=QtZQsCuLUOojr2dRCQgRJMb0vhMdQuNGjYOaPr9bWr6QF0TVkVCSXZz+OKP94STARG
         Ax9S8C24dz1FMkNU8xRPY+qFcFjBv2KefdkNKJFvc0m9eQ3h9DCiKXnQ24wSZTNTrYcc
         MG0YlQ/ZLrkKTBofZ0VciARtB+gZHAbnJdmuEGKDtZN41W4gkjgv1vxtMGTShu5g55ND
         e4W/H0gK6xcodNMC0IEoQrytP0L9rYQzuNS1XI1Ufy0edsJHqVwIS+d0NuHAnZinCtXx
         Tt5U4ycga6rbizPketaaOLwBBF7mfwOv307dqOXYQ1j2tVt27TyE6nTY/Mh/XZHpPfuj
         n1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/6JKx58urj/mvpMqSH23sBZH7n88NpdD/BH45WGSNKmBtricnzhVXFNlKT5J6bSE+TSni5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfuy8Y/Lf4n2sopp0zpoeA1vdRd9TM31C+mlTxhr1N7cavHcoX
	i5/mtJ16KI0jSQfGY3dEpyO8muo9MgFkkviG5z/YMlDPYrJz4AUDlL3j
X-Gm-Gg: AY/fxX5H6vttgwVl7aI6Ihl/YKt2MRGEQpH6ChtpblTAnqUVOVbq3qWawZDNxwFjS2z
	2HBPrlWoZQVlWewX03uszUo+vTj/Ujg1QaiibMJP5Z3Awgb0ed+CgZ+m+aRk/5hh95n7jwzfjzp
	uAcNy1aqXHtKi51pBQTPdVudkvYa77KCvihsT1vfdNCGv7/Oq7Xky87KPMQIqhxcJkdlLDCFtPS
	1S921Yd3IIlaIrBGC2DJ3A34ZkZh/x7G0/utSkdIUtKl6l8nOa89cOTyEQHXSlRLzQk3bbN1fZu
	fVJq+ZoDK4QNkUVD1NBRaT/vfT9ZKVaR6lMI3SDnUrKzVtTZeDhzKRW2PPH30Ou4SnYqpwC7XvM
	cOH7AYbcADlBkGIwKRlf8P5XL1c6w1hUiC3/vzpvNkcpO8/rG/eOSzKUTzLUKOh9cxL1m2R5stM
	L7u1rtgVz5og==
X-Google-Smtp-Source: AGHT+IFzbqFh/f/vwHhrdMejROOldIso+1k/br/9NHK8zplFr2sEMkH2Q4RnxGZ2YNxpAA3A/WO07g==
X-Received: by 2002:a5d:64c7:0:b0:431:327:5dd6 with SMTP id ffacd0b85a97d-432c3634312mr9195979f8f.8.1767920953021;
        Thu, 08 Jan 2026 17:09:13 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:12 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [RFC PATCH v5 2/7] net: wwan: core: explicit WWAN device reference counting
Date: Fri,  9 Jan 2026 03:09:04 +0200
Message-ID: <20260109010909.4216-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need information about existing WWAN device children since we remove
the device after removing the last child. Previously, we tracked users
implicitly by checking whether ops was registered and existence of a
child device of the wwan_class class. Upcoming GNSS (NMEA) port type
support breaks this approach by introducing a child device of the
gnss_class class.

And a modem driver can easily trigger a kernel Oops by removing regular
(e.g., MBIM, AT) ports first and then removing a GNSS port. The WWAN
device will be unregistered on removal of a last regular WWAN port. And
subsequent GNSS port removal will cause NULL pointer dereference in
simple_recursive_removal().

In order to support ports of classes other than wwan_class, switch to
explicit references counting. Introduce a dedicated counter to the WWAN
device struct, increment it on every wwan_create_dev() call, decrement
on wwan_remove_dev(), and actually unregister the WWAN device when there
are no more references.

Run tested with wwan_hwsim with NMEA support patches applied and
different port removing sequences.

Reported-by: Daniele Palmas <dnlplm@gmail.com>
Closes: https://lore.kernel.org/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com/
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
Changes:
* RFCv2->RFCv5: new patch to address modem disconnection / system
  shutdown issues
---
 drivers/net/wwan/wwan_core.c | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ade8bbffc93e..33f7a140fba9 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -42,6 +42,9 @@ static struct dentry *wwan_debugfs_dir;
  * struct wwan_device - The structure that defines a WWAN device
  *
  * @id: WWAN device unique ID.
+ * @refcount: Reference count of this WWAN device. When this refcount reaches
+ * zero, the device is deleted. NB: access is protected by global
+ * wwan_register_lock mutex.
  * @dev: Underlying device.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
@@ -49,6 +52,7 @@ static struct dentry *wwan_debugfs_dir;
  */
 struct wwan_device {
 	unsigned int id;
+	int refcount;
 	struct device dev;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
@@ -222,8 +226,10 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 
 	/* If wwandev already exists, return it */
 	wwandev = wwan_dev_get_by_parent(parent);
-	if (!IS_ERR(wwandev))
+	if (!IS_ERR(wwandev)) {
+		wwandev->refcount++;
 		goto done_unlock;
+	}
 
 	id = ida_alloc(&wwan_dev_ids, GFP_KERNEL);
 	if (id < 0) {
@@ -242,6 +248,7 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 	wwandev->dev.class = &wwan_class;
 	wwandev->dev.type = &wwan_dev_type;
 	wwandev->id = id;
+	wwandev->refcount = 1;
 	dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
 
 	err = device_register(&wwandev->dev);
@@ -263,30 +270,21 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
 	return wwandev;
 }
 
-static int is_wwan_child(struct device *dev, void *data)
-{
-	return dev->class == &wwan_class;
-}
-
 static void wwan_remove_dev(struct wwan_device *wwandev)
 {
-	int ret;
-
 	/* Prevent concurrent picking from wwan_create_dev */
 	mutex_lock(&wwan_register_lock);
 
-	/* WWAN device is created and registered (get+add) along with its first
-	 * child port, and subsequent port registrations only grab a reference
-	 * (get). The WWAN device must then be unregistered (del+put) along with
-	 * its last port, and reference simply dropped (put) otherwise. In the
-	 * same fashion, we must not unregister it when the ops are still there.
-	 */
-	if (wwandev->ops)
-		ret = 1;
-	else
-		ret = device_for_each_child(&wwandev->dev, NULL, is_wwan_child);
+	if (--wwandev->refcount <= 0) {
+		struct device *child = device_find_any_child(&wwandev->dev);
+
+		if (WARN_ON(wwandev->ops))	/* Paranoid */
+			goto out_unlock;
+		if (WARN_ON(child)) {		/* Paranoid */
+			put_device(child);
+			goto out_unlock;
+		}
 
-	if (!ret) {
 #ifdef CONFIG_WWAN_DEBUGFS
 		debugfs_remove_recursive(wwandev->debugfs_dir);
 #endif
@@ -295,6 +293,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
 		put_device(&wwandev->dev);
 	}
 
+out_unlock:
 	mutex_unlock(&wwan_register_lock);
 }
 
-- 
2.52.0


