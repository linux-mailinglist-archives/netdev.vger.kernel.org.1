Return-Path: <netdev+bounces-250146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A9D24512
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3BE430B9688
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9139446F;
	Thu, 15 Jan 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A+xS9meI"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD4393DE8;
	Thu, 15 Jan 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477655; cv=none; b=DMZAL9l4wTg3ZfKZSZ1oSCzF/+pw/KjG1da1osAuPJS8oVHyq8HGKe9M+WkDvYzG0AeDCy2ZWiqe3X6dofu+/bH49w/scXF8Q2Ze8GM6yYuXzVwMp5ip26U7o+RmS60hywP29gqVrEeKXlLRfyWkIBjKESYOs3lPeM5moJrnlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477655; c=relaxed/simple;
	bh=4DVhCl4gbIXZz7OZyWroJqYsJfVpaSbkJ/cFhnuOB1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1/0VPvJzYnMhcHHBGegbU+7wZFyPLBXWBjutIPPXtV/wGCJwaQ/fN/BRljh6lPiksIyqmZgj+aA3byIezRt7swhNqN1q/Jxy4CfWoSkR5r8RzFzksGPU4nSPyUs1WULQ8JGNvcHhJ5DkpmpWXyVDf8+JU5N2AdVbdh69YgGr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A+xS9meI; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ez
	xx3sezb37S1HGZPsf+TTq5UcEdoA3/kKhmJ7zHOx4=; b=A+xS9meIXscL+2kO/C
	sGy6dF0UVWU9eJUUf96HIbXlHtXrgMpSvu+jDelMxOkcPwNNNuC0Rr7G3mzw3dQg
	18yu4NxyVfs2EDg47TORcGR3U26/rdOxT5UEfAyhD30YP7Mf2MpqL/KEUVu75ASp
	KazA22+jWQREVsKP97HPP8pJ4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S4;
	Thu, 15 Jan 2026 19:46:40 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [net-next v7 2/8] net: wwan: core: explicit WWAN device reference counting
Date: Thu, 15 Jan 2026 19:46:19 +0800
Message-Id: <20260115114625.46991-3-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw13Gry8Gw45Xry7CFyxuFg_yoWrZF47pa
	y3KFy3KFW8Jr4Uu39avr47XFyF9a1xCw1ft348W34Fkry3tryrXrWUXFyYqFy8tFWkCF45
	urWUta18CF4UW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRUUUUUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6AKR9Wlo06L4BAAA3C

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

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
 drivers/net/wwan/wwan_core.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ade8bbffc93e..1da935e84008 100644
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
@@ -263,30 +270,18 @@ static struct wwan_device *wwan_create_dev(struct device *parent)
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
+		put_device(child);
+		if (WARN_ON(wwandev->ops || child))	/* Paranoid */
+			goto out_unlock;
 
-	if (!ret) {
 #ifdef CONFIG_WWAN_DEBUGFS
 		debugfs_remove_recursive(wwandev->debugfs_dir);
 #endif
@@ -295,6 +290,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
 		put_device(&wwandev->dev);
 	}
 
+out_unlock:
 	mutex_unlock(&wwan_register_lock);
 }
 
-- 
2.25.1


