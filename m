Return-Path: <netdev+bounces-302336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id baVKDeHMP2pgYQkAu9opvQ
	(envelope-from <netdev+bounces-302336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A176D1F9D
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302336-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302336-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702463023506
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC4D3B0AE1;
	Sat, 27 Jun 2026 13:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F939283C
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 13:14:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566102; cv=none; b=rn3SEVp3dxki+vlthINSOmoApmqioaUqYOyUopWZoJpBZrscS/VB4xwfzr8o/1IsZIt2KK3VlO7jQxFpcWclfg+IVHN3Ql41LoA5OD3XPRRTsjv0XlsYE60+UBJTxtmMRIotVbGi+bN80oWAGwuvPoAsjDZJs1sVM6dVZZiv2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566102; c=relaxed/simple;
	bh=nlj0RheuVdtQjC50V42GnvkA7UJWPKglvxn1B7AwyIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kA0j7fIHWuvfVb3/iRXdm50yP0yqgKNypT+NVAHJQhwUsdXbz7t2a2FBfnl6SQAVAvKxjJtljWn3icXEHmt2TkHUAgbMy5kRiCuyVggvq+A+PnvQ1HMdznISPs33HskHxpGrC/llQZlA+WG8yDOt6d2/aXuf1OwozvXwr28F9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.229.168.213
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrACXnSm1zD9qdZEiAQ--.11626S2;
	Sat, 27 Jun 2026 21:14:29 +0800 (CST)
Received: from uu22.. (unknown [38.79.119.137])
	by gateway (Coremail) with SMTP id _____wBHQMenzD9qu1wjAA--.19466S2;
	Sat, 27 Jun 2026 21:14:26 +0800 (CST)
From: Yinhao Hu <dddddd@hust.edu.cn>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Dan Carpenter <error27@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH net] nfc: pn533: fix use-after-free in pn533_recv_frame
Date: Sat, 27 Jun 2026 06:13:45 -0700
Message-ID: <20260627131345.1548407-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACXnSm1zD9qdZEiAQ--.11626S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr18KF1ftr18tr48ZF1DJrb_yoWxZFWrpa
	93Wa4Yyr4UXryjvanrGr48W345Xws5tFnFk34Igw1xAry5GryrJFWftFy5XrykZF97Zr13
	CFWDtF4DGayqqa7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7Cv6c
	x26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw2
	8IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IUYoSotUUUUU==
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hust.edu.cn];
	TAGGED_FROM(0.00)[bounces-302336-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:david@ixit.cz,m:error27@gmail.com,m:krzk@kernel.org,m:kees@kernel.org,m:kuba@kernel.org,m:sameo@linux.intel.com,m:michael.thalmeier@hale.at,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,m:dddddd@hust.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ixit.cz,gmail.com,kernel.org,linux.intel.com,hale.at,hust.edu.cn,googlegroups.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A176D1F9D

pn533_recv_frame() checks dev->cmd and then dereferences it several
times to store the receive status and the response skb. In parallel the
command completion worker runs pn533_send_async_complete(), which frees
the same struct pn533_cmd and only clears dev->cmd after the free. With
fast receive/completion timing the receive path can therefore write to
an already freed command object.

Serialize all accesses to dev->cmd with a new cmd_state_lock spinlock:
pn533_recv_frame() now inspects and updates the current command while
holding the lock, the send paths publish and clear the pointer through
pn533_set_current_cmd(), and the completion worker detaches the command
under the lock before freeing it. Once the worker has detached the command,
a racing receive observes a NULL dev->cmd and no longer touches the freed
object.

  BUG: KASAN: slab-use-after-free in pn533_recv_frame+0x54f/0x670
  Write of size 4 at addr ffff888105566a14 by task kworker/1:3/126

  CPU: 1 UID: 0 PID: 126 Comm: kworker/1:3 Not tainted 7.1.0+ #8 PREEMPT
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  Workqueue: events nfc_urelease_event_work
  Call Trace:
   <TASK>
   dump_stack_lvl+0x8c/0xb0
   print_report+0xd0/0x630
   kasan_report+0xce/0x100
   pn533_recv_frame+0x54f/0x670
   pn533_stop_poll+0xdc/0x150
   nfc_stop_poll+0xf2/0x1c0
   nfc_urelease_event_work+0x194/0x270
   process_one_work+0x701/0x1160
   worker_thread+0x5e6/0xd50
   kthread+0x373/0x4c0
   ret_from_fork+0x2e9/0x750
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 1744:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_cache_noprof+0x194/0x430
   __pn533_send_async+0x5c/0x410
   pn533_wq_rf+0xc6/0x160
   process_one_work+0x701/0x1160
   worker_thread+0x5e6/0xd50
   kthread+0x373/0x4c0
   ret_from_fork+0x2e9/0x750
   ret_from_fork_asm+0x1a/0x30

  Freed by task 1744:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x17b/0x440
   pn533_wq_cmd_complete+0x24d/0x450
   process_one_work+0x701/0x1160
   worker_thread+0x5e6/0xd50
   kthread+0x373/0x4c0
   ret_from_fork+0x2e9/0x750
   ret_from_fork_asm+0x1a/0x30

Fixes: 9815c7cf22da ("NFC: pn533: Separate physical layer from the core implementation")
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
---
 drivers/nfc/pn533/pn533.c | 47 ++++++++++++++++++++++++++++++++-------
 drivers/nfc/pn533/pn533.h |  1 +
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..921e93a5f16f 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -394,12 +394,32 @@ static void pn533_build_cmd_frame(struct pn533 *dev, u8 cmd_code,
 	ops->tx_frame_finish(skb->data);
 }
 
+static void pn533_set_current_cmd(struct pn533 *dev, struct pn533_cmd *cmd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->cmd_state_lock, flags);
+	dev->cmd = cmd;
+	spin_unlock_irqrestore(&dev->cmd_state_lock, flags);
+}
+
 static int pn533_send_async_complete(struct pn533 *dev)
 {
-	struct pn533_cmd *cmd = dev->cmd;
+	struct pn533_cmd *cmd;
 	struct sk_buff *resp;
+	unsigned long flags;
 	int status, rc = 0;
 
+	/*
+	 * Detach the current command before freeing it, so a concurrent
+	 * pn533_recv_frame() either observes a valid command under the lock
+	 * or a NULL dev->cmd and stops touching the freed object.
+	 */
+	spin_lock_irqsave(&dev->cmd_state_lock, flags);
+	cmd = dev->cmd;
+	dev->cmd = NULL;
+	spin_unlock_irqrestore(&dev->cmd_state_lock, flags);
+
 	if (!cmd) {
 		dev_dbg(dev->dev, "%s: cmd not set\n", __func__);
 		goto done;
@@ -430,7 +450,6 @@ static int pn533_send_async_complete(struct pn533 *dev)
 
 done:
 	kfree(cmd);
-	dev->cmd = NULL;
 	return rc;
 }
 
@@ -458,10 +477,10 @@ static int __pn533_send_async(struct pn533 *dev, u8 cmd_code,
 	mutex_lock(&dev->cmd_lock);
 
 	if (!dev->cmd_pending) {
-		dev->cmd = cmd;
+		pn533_set_current_cmd(dev, cmd);
 		rc = dev->phy_ops->send_frame(dev, req);
 		if (rc) {
-			dev->cmd = NULL;
+			pn533_set_current_cmd(dev, NULL);
 			goto error;
 		}
 
@@ -529,10 +548,10 @@ static int pn533_send_cmd_direct_async(struct pn533 *dev, u8 cmd_code,
 
 	pn533_build_cmd_frame(dev, cmd_code, req);
 
-	dev->cmd = cmd;
+	pn533_set_current_cmd(dev, cmd);
 	rc = dev->phy_ops->send_frame(dev, req);
 	if (rc < 0) {
-		dev->cmd = NULL;
+		pn533_set_current_cmd(dev, NULL);
 		kfree(cmd);
 	}
 
@@ -569,10 +588,10 @@ static void pn533_wq_cmd(struct work_struct *work)
 
 	mutex_unlock(&dev->cmd_lock);
 
-	dev->cmd = cmd;
+	pn533_set_current_cmd(dev, cmd);
 	rc = dev->phy_ops->send_frame(dev, cmd->req);
 	if (rc < 0) {
-		dev->cmd = NULL;
+		pn533_set_current_cmd(dev, NULL);
 		dev_kfree_skb(cmd->req);
 		kfree(cmd);
 		return;
@@ -2165,6 +2184,15 @@ static int pn533_data_exchange_complete(struct pn533 *dev, void *_arg,
  */
 void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 {
+	unsigned long flags;
+
+	/*
+	 * Hold cmd_state_lock across the whole receive path so the current
+	 * command cannot be freed by pn533_send_async_complete() between the
+	 * dev->cmd check and the stores into it.
+	 */
+	spin_lock_irqsave(&dev->cmd_state_lock, flags);
+
 	if (!dev->cmd)
 		goto sched_wq;
 
@@ -2182,6 +2210,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 
 	if (pn533_rx_frame_is_ack(skb->data)) {
 		dev_dbg(dev->dev, "%s: Received ACK frame\n", __func__);
+		spin_unlock_irqrestore(&dev->cmd_state_lock, flags);
 		dev_kfree_skb(skb);
 		return;
 	}
@@ -2200,6 +2229,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 	dev->cmd->resp = skb;
 
 sched_wq:
+	spin_unlock_irqrestore(&dev->cmd_state_lock, flags);
 	queue_work(dev->wq, &dev->cmd_complete_work);
 }
 EXPORT_SYMBOL(pn533_recv_frame);
@@ -2760,6 +2790,7 @@ struct pn533 *pn53x_common_init(u32 device_type,
 	priv->device_type = device_type;
 
 	mutex_init(&priv->cmd_lock);
+	spin_lock_init(&priv->cmd_state_lock);
 
 	INIT_WORK(&priv->cmd_work, pn533_wq_cmd);
 	INIT_WORK(&priv->cmd_complete_work, pn533_wq_cmd_complete);
diff --git a/drivers/nfc/pn533/pn533.h b/drivers/nfc/pn533/pn533.h
index 09e35b8693f5..8b009b2318d0 100644
--- a/drivers/nfc/pn533/pn533.h
+++ b/drivers/nfc/pn533/pn533.h
@@ -153,6 +153,7 @@ struct pn533 {
 	struct pn533_cmd *cmd;
 	u8 cmd_pending;
 	struct mutex cmd_lock;  /* protects cmd queue */
+	spinlock_t cmd_state_lock;  /* protects dev->cmd lifetime */
 
 	void *cmd_complete_mi_arg;
 	void *cmd_complete_dep_arg;
-- 
2.43.0


