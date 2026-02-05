Return-Path: <netdev+bounces-256940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N6FEaYIhGnhxAMAu9opvQ
	(envelope-from <netdev+bounces-256940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:04:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C4EE2D2
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC7D300EA80
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98220DD72;
	Thu,  5 Feb 2026 03:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEE1F181F;
	Thu,  5 Feb 2026 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260627; cv=none; b=RLDdMkhLHOQWSzN9v0wf1VonN6xBFE4hZNqHbNoTTzv6eXcI/ZlVjTMnlr6CQV2Fku3wORjdWQKAqg9pOsgLYP+8Hnw2TB3xUBHsrRa5h965Zim/AorWL7viE/BWaydQRWHYyNrdZ4CTHOt4C8Tz4mQtpshpemFJEmTSGr3SsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260627; c=relaxed/simple;
	bh=7snZf3xWO7w7qme4Nvs/uKYHO7QsUP2wle692tObmsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y66CJ4aOFotJdpfloQkggDjYL+tzzkDePdy+TrvOFZ/xozTi2hZK5JWMtC3v2P8LRmIQy56RlPXuwetL9klN8TSANCQmzVaKmhdyDHtreBAToPt0PrEhzo09hN+0keGVzjkZEcBL+ltfC61ltK6guL/6jv3IYjs1wz07NB/JGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.17.60])
	by mtasvr (Coremail) with SMTP id _____wDX34eCCIRp1MGBAA--.17594S3;
	Thu, 05 Feb 2026 11:03:30 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.17.60])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHgdp3CIRp5OIHBg--.13127S2;
	Thu, 05 Feb 2026 11:03:21 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	3chas3@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] atm: fore200e: fix use-after-free in tasklets during device removal
Date: Thu,  5 Feb 2026 11:03:17 +0800
Message-Id: <20260205030317.39190-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHgdp3CIRp5OIHBg--.13127S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQNAWmDoQcK+AAUsh
X-CM-DELIVERINFO: =?B?B/17KAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1+U8zldnsn1nDMavq5TA/0qMhglio51OpoBZ7f5d8y3jxNiXI00LvtFLlZQBfsLiHk8P
	j9RQOd6DkVROwuLHMpaY4g0S53FMlCyUPdKkU+k48qgyEkEwrQ2siKb3+6U3tA==
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1Dtw43Xr4UJrWrJr45XFc_yoW8WFy8p3
	y7Cw47Cry8JrWj9w17Jw1UWr1ruFn3ZFWYkwsrK3y2qF1FvF10vr15tF4DWFWjk347ZFZ2
	kr1ktF13G34DJFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU72NtDUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-256940-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com,zju.edu.cn];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 677C4EE2D2
X-Rspamd-Action: no action

When the PCA-200E or SBA-200E adapters is being detached, the fore200e
is deallocated. However, the tx_tasklet or rx_tasklet may still be running
or pending, leading to use-after-free bug when the already freed fore200e
is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().

One of the race conditions can occur as follows:

CPU 0 (cleanup)           | CPU 1 (tasklet)
fore200e_pca_remove_one() | fore200e_interrupt()
  fore200e_shutdown()     |   tasklet_schedule()
    kfree(fore200e)       | fore200e_tx_tasklet()
                          |   fore200e-> // UAF

Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
synchronize with any pending or running tasklets.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/atm/fore200e.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f62e3857144..7470daf9469 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -358,7 +358,12 @@ fore200e_shutdown(struct fore200e* fore200e)
     printk(FORE200E "removing device %s at 0x%lx, IRQ %s\n",
 	   fore200e->name, fore200e->phys_base, 
 	   fore200e_irq_itoa(fore200e->irq));
-    
+
+#ifdef FORE200E_USE_TASKLET
+	tasklet_kill(&fore200e->tx_tasklet);
+	tasklet_kill(&fore200e->rx_tasklet);
+#endif
+
     if (fore200e->state > FORE200E_STATE_RESET) {
 	/* first, reset the board to prevent further interrupts or data transfers */
 	fore200e_reset(fore200e, 0);
-- 
2.34.1


