Return-Path: <netdev+bounces-302111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O/5AAtcrPmp1AwkAu9opvQ
	(envelope-from <netdev+bounces-302111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128D6CAFE9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302111-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302111-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E282C3011A60
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136553E1233;
	Fri, 26 Jun 2026 07:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F93DFC99
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 07:35:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459349; cv=none; b=jGNGvcqvVCmM43EMgfIKhhK2xARdEfeDjZy/lEhOS/frnGxGX1rYfEzLAesIuaf1/BCrX3wJ7fV+bVWwNN4n+WsLWH79GPOqSh5e51HR8YdbaOL5/Nd9fVMRamFwQTFCZTDTtFx6GngtV2xplARp3m6Qi0lBcFvTFIO7DisyuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459349; c=relaxed/simple;
	bh=eP30SICnZo6M5PNnkdKFYIzlhguK54IYXWNFZilzDhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTYFXbILav8jaagwXi0kwFV/N7vJk+PeKPqtOb3ysUJChxWWZV5mw9h2rFw4AR7dg5/E4Pof53/avjjWZLhXWwLOZB5LnZTYszevug3X3T9qWOFNoEQU/ZOW+drqy1J56zHygyc8kxtaS7eoUXVqI9oDVIJGdvjVDDdCmhG0/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.175.55.52
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrABnbCibKz5qKyIVAQ--.38701S2;
	Fri, 26 Jun 2026 15:34:51 +0800 (CST)
Received: from uu22.. (unknown [38.79.119.137])
	by gateway (Coremail) with SMTP id _____wB3fxONKz5qFJxfAA--.21583S2;
	Fri, 26 Jun 2026 15:34:50 +0800 (CST)
From: Yinhao Hu <dddddd@hust.edu.cn>
To: David Heidelberg <david@ixit.cz>
Cc: Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	netdev@vger.kernel.org,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH net] nfc: pn533: hold a reference to the request skb during send_frame
Date: Fri, 26 Jun 2026 00:34:34 -0700
Message-ID: <20260626073434.3977525-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABnbCibKz5qKyIVAQ--.38701S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyUWF4fJw4UGFWruw4Uurg_yoW5XF4Dpa
	9rZFyYkr1DWr4UZFsrG3yku345JF1kAry7K342g3Z3Jr95JrykJrWSyFy0qwn3ur97ury7
	urWDXF45Ga4qyFDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04
	k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07jTa0QUUUUU=
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hust.edu.cn];
	TAGGED_FROM(0.00)[bounces-302111-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:kees@kernel.org,m:krzk@kernel.org,m:error27@gmail.com,m:kuba@kernel.org,m:sameo@linux.intel.com,m:michael.thalmeier@hale.at,m:netdev@vger.kernel.org,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,m:dddddd@hust.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.intel.com,hale.at,vger.kernel.org,hust.edu.cn,googlegroups.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hust.edu.cn:email,hust.edu.cn:mid,hust.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7128D6CAFE9

__pn533_send_async() publishes the command and then calls
dev->phy_ops->send_frame(). Once dev->cmd is set, an incoming frame
can be matched to this command: the I2C threaded IRQ runs
pn533_recv_frame(), which queues cmd_complete_work, and
pn533_send_async_complete() frees cmd->req with consume_skb().

On the I2C transport, pn533_i2c_send_frame() still dereferences the same
skb after i2c_master_send() returns, so a completion that races the
send can free the skb while the transport is still using it.

The request skb is owned by the command object and may be freed by
command completion at any time after dev->cmd is published, so the
transport send path must not assume it stays alive. Hold a temporary
reference to the request skb across the send_frame() call so the
transport always sees a live skb even if completion races the send.
Add a pn533_send_cmd_frame() helper and use it from all three send
paths.

Fixes: 9815c7cf22da ("NFC: pn533: Separate physical layer from the core implementation")
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
---
 drivers/nfc/pn533/pn533.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..55bbfa32d695 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -434,6 +434,18 @@ static int pn533_send_async_complete(struct pn533 *dev)
 	return rc;
 }
 
+static int pn533_send_cmd_frame(struct pn533 *dev, struct pn533_cmd *cmd)
+{
+	struct sk_buff *req = cmd->req;
+	int rc;
+
+	skb_get(req);
+	dev->cmd = cmd;
+	rc = dev->phy_ops->send_frame(dev, req);
+	dev_kfree_skb(req);
+	return rc;
+}
+
 static int __pn533_send_async(struct pn533 *dev, u8 cmd_code,
 			      struct sk_buff *req,
 			      pn533_send_async_complete_t complete_cb,
@@ -458,8 +470,7 @@ static int __pn533_send_async(struct pn533 *dev, u8 cmd_code,
 	mutex_lock(&dev->cmd_lock);
 
 	if (!dev->cmd_pending) {
-		dev->cmd = cmd;
-		rc = dev->phy_ops->send_frame(dev, req);
+		rc = pn533_send_cmd_frame(dev, cmd);
 		if (rc) {
 			dev->cmd = NULL;
 			goto error;
@@ -529,8 +540,7 @@ static int pn533_send_cmd_direct_async(struct pn533 *dev, u8 cmd_code,
 
 	pn533_build_cmd_frame(dev, cmd_code, req);
 
-	dev->cmd = cmd;
-	rc = dev->phy_ops->send_frame(dev, req);
+	rc = pn533_send_cmd_frame(dev, cmd);
 	if (rc < 0) {
 		dev->cmd = NULL;
 		kfree(cmd);
@@ -569,8 +579,7 @@ static void pn533_wq_cmd(struct work_struct *work)
 
 	mutex_unlock(&dev->cmd_lock);
 
-	dev->cmd = cmd;
-	rc = dev->phy_ops->send_frame(dev, cmd->req);
+	rc = pn533_send_cmd_frame(dev, cmd);
 	if (rc < 0) {
 		dev->cmd = NULL;
 		dev_kfree_skb(cmd->req);
-- 
2.43.0


