Return-Path: <netdev+bounces-286130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFrbC1r+/mnm0wAAu9opvQ
	(envelope-from <netdev+bounces-286130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 745504FEFCD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39EC2301051B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE638F64C;
	Sat,  9 May 2026 09:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8E208D0;
	Sat,  9 May 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318930; cv=none; b=tCLcvotaMvMsaAKOZgiVlP6lPaAko2T3RGOtRssJci1LzFAoa7rmfDzpRuJhbj9CNwt1jB1KPqsflM+zjFiZwVuHPPUVXibfBFrRcfnL6N2eFSzbtS+A98q+eCXy61IFqKQcxrFpfzLnPnlps36RKmCI9vhSVMvfrGQfH0M2zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318930; c=relaxed/simple;
	bh=FWWXJkwrdDXa/mKHmNpzbx3h/Hc9w3djI2kCJYGaY9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3SR93n3rEto7PxGtgDtwUHhFbPk3NUJB33vJREh8tGYi8ywr5JBmaVBZV4yMYtGWkiMu8yLerU5wNmMX3rNgQEIsIGq9DNUjGcKsMHP4vK4n2fcPbapmvNvGM0ySNc0WrZrCmx+VSJabSLLKO81IcN5LAyfEiWmmcFwWtpYGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3WN9G_v5pCJJ7EA--.18905S2;
	Sat, 09 May 2026 17:28:38 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] netdevsim: Fix task hung by releasing bus lock before device ops
Date: Sat,  9 May 2026 09:28:37 +0000
Message-Id: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3WN9G_v5pCJJ7EA--.18905S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr13uw4fur45XryftrW5Wrg_yoW5urW5pw
	43tFy3tF97ZwnrXan8Z3W8ur1Y9r1q9w4furW5Ar97CFs8ZFyYqr17GFy3XrW09rW7uayU
	JFyUWw4UAr4UXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUS1v3UUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Rspamd-Queue-Id: 745504FEFCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mails.ucas.ac.cn:mid,ucas.ac.cn:email]
X-Rspamd-Action: no action

The new_device_store and del_device_store sysfs handlers hold
nsim_bus_dev_list_lock across device_register() and device_unregister()
calls, which in turn acquire rtnl_lock and devl_lock. This creates
a lock hold-time inversion: while one thread holds nsim_bus_dev_list_lock
and waits for rtnl_lock (acquired during probe), all other threads
attempting new_device_store or del_device_store are blocked on
nsim_bus_dev_list_lock, and threads waiting for rtnl_lock are also
blocked.

Fix by:
1. Moving nsim_bus_dev_new() (which calls device_register()) outside
   the nsim_bus_dev_list_lock critical section in new_device_store
2. Releasing nsim_bus_dev_list_lock before calling nsim_bus_dev_del()
   (which calls device_unregister()) in del_device_store
3. Moving refcount_inc(&nsim_bus_devs) into nsim_bus_dev_new() before
   device_register(), so the refcount correctly accounts for the
   device even if the bus is being torn down concurrently

Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 drivers/net/netdevsim/bus.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 41483e371f05..0e15c8605997 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -181,20 +181,18 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		return -EINVAL;
 	}
 
+	nsim_bus_dev = nsim_bus_dev_new(id, port_count, num_queues);
+	if (IS_ERR(nsim_bus_dev))
+		return PTR_ERR(nsim_bus_dev);
+
 	mutex_lock(&nsim_bus_dev_list_lock);
 	/* Prevent to use resource before initialization. */
 	if (!smp_load_acquire(&nsim_bus_enable)) {
-		err = -EBUSY;
-		goto err;
-	}
-
-	nsim_bus_dev = nsim_bus_dev_new(id, port_count, num_queues);
-	if (IS_ERR(nsim_bus_dev)) {
-		err = PTR_ERR(nsim_bus_dev);
-		goto err;
+		mutex_unlock(&nsim_bus_dev_list_lock);
+		nsim_bus_dev_del(nsim_bus_dev);
+		return -EBUSY;
 	}
 
-	refcount_inc(&nsim_bus_devs);
 	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
 
@@ -202,9 +200,6 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 	mutex_unlock(&nsim_bus_dev_list_lock);
 
 	return count;
-err:
-	mutex_unlock(&nsim_bus_dev_list_lock);
-	return err;
 }
 static BUS_ATTR_WO(new_device);
 
@@ -241,9 +236,9 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		if (nsim_bus_dev->dev.id != id)
 			continue;
 		list_del(&nsim_bus_dev->list);
+		mutex_unlock(&nsim_bus_dev_list_lock);
 		nsim_bus_dev_del(nsim_bus_dev);
-		err = 0;
-		break;
+		return count;
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
 	return !err ? count : err;
@@ -468,6 +463,11 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
 	/* Disallow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, false);
 
+	/* Increment refcount before device_register() so that the device
+	 * is accounted for even if the bus is being torn down concurrently.
+	 */
+	refcount_inc(&nsim_bus_devs);
+
 	err = device_register(&nsim_bus_dev->dev);
 	if (err)
 		goto err_nsim_bus_dev_id_free;
-- 
2.34.1


