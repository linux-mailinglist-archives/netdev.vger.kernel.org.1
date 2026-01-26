Return-Path: <netdev+bounces-253331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHjKG2cId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:23:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B828478E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DEF300602E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED927816C;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ApJUahrx"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E626F291;
	Mon, 26 Jan 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408586; cv=none; b=apM0Uc9bMiE6/5FBBx6W+85ZvoquMIWSmvx0FJ0W5UrHMLhmIS78sxnvQ1L+pf4Kco5hV9xEoS4bX9dSsXV+is1oUfmU3LasYyQhaBDE7qJiErjr3NEl7JXqWMCurOVJW1vtaTbs25G4AwBAKipGszrhhPXI8c7TuXY0UYvYEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408586; c=relaxed/simple;
	bh=4DVhCl4gbIXZz7OZyWroJqYsJfVpaSbkJ/cFhnuOB1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZryRAi5W6BvbkimyGRBFoteEw/OMcQ6TBEs3ZBLss3Y220s24EJLqMEJbQTESJvTSL689cbIETE2M7P3uxS2nDPKmyuw2dZTt8l6hI375eF3uIUGEJtEVzZQpdteMlC+2wK1Oipc969Q4fGxA2tpTFyUxMHenuIRTJAa0FaBxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ApJUahrx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ez
	xx3sezb37S1HGZPsf+TTq5UcEdoA3/kKhmJ7zHOx4=; b=ApJUahrxBkcW6iZBuo
	kU4vo12M7dPA0Wqa6fIk9Dz06ub70miTcTIhADv8jDvCnZ0ReK6D0BiadfujswrK
	D5s/u16MaRp2557qCVxqAAGuIdVaOy/zxlw7rJ9+KEgFLLBcQ64yrP3uhYf0mIBc
	/VKxI1QxE3g0DuE6eDWJeajs8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S4;
	Mon, 26 Jan 2026 14:22:09 +0800 (CST)
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
Subject: [net-next v8 2/8] net: wwan: core: explicit WWAN device reference counting
Date: Mon, 26 Jan 2026 14:21:52 +0800
Message-Id: <20260126062158.308598-3-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw13Gry8Gw45Xry7CFyxuFg_yoWrZF47pa
	y3KFy3KFW8Jr4Uu39avr47XFyF9a1xCw1ft348W34Fkry3tryrXrWUXFyYqFy8tFWkCF45
	urWUta18CF4UW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0fO7UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBE+oml3CBF0gQAA3-
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-253331-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0B828478E
X-Rspamd-Action: no action

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


