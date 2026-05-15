Return-Path: <netdev+bounces-288193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ+/LRy+BmqMnQIAu9opvQ
	(envelope-from <netdev+bounces-288193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BEA54A047
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FDF5300B05C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7737FF6E;
	Fri, 15 May 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EOglBsae"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEC37FF74;
	Fri, 15 May 2026 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826776; cv=none; b=ZfJwyzekX/X0OvMt9ZmFwsDwjSaK4wnq4m76zQldKsdC4oKozsbsWxqlF9t0P+mxOZltD/jucVQBGu1Z4NO94iMly11t71uNRDvItISclA69lrf0OczH0EpSTAGZvb4j+ctVvGxjlt36yzBQbd/caj7A1IaVxy/oBLywcbbkZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826776; c=relaxed/simple;
	bh=gb6duCW5IGF8d9WTN/wAjS3ei6atzzGUBKiYT5wRA58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PBISUtxWktL3qsdgXB7H34djF3kXNH3/BUrumVUGhm4rPRg1RTDbeCiwgg8vHvFzdZsDQCdCT5IDAVk2K2LJ5Q4OqlzzxjcKmcwsa7SM4n23XNe5qcfXA5g7N/LTgcMAyhQDFMeOC09zQsQRELfxRuwa7B9gZoi7tIQ3+COiTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EOglBsae; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0W
	rHOjUBp9UcG8rUhJwcHy9akfbGYkEznkndyWUraww=; b=EOglBsaelQzqNPJM+W
	1U9YsfOlceBOcpuR3QPJPew50V4S0O9Kmqs0Y26bjZ5nIv09mV/qE9l57kNN8gqx
	e2w8NKg1/VOIZzDjvsL1GiqP4qoI9lLWtBMQg+zlUhG9ebg9pULd0hqtpgikOD55
	4WOvv3KvXqK87K9BBHRbVIr+Y=
Received: from flipped.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHxVvcvQZqmAXoDQ--.178S2;
	Fri, 15 May 2026 14:32:00 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH v1] net: plip: cancel pending work before freeing device
Date: Fri, 15 May 2026 14:31:55 +0800
Message-Id: <20260515063155.3196112-1-congei42@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHxVvcvQZqmAXoDQ--.178S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW8WF1fJry7uF13JF4UCFg_yoW8JF47pr
	W5uryUA3ykJFs8K3ZrXw4fJFyrWFn7Kry8C398u3y5Zrs3J3WDtr1SkFWYvFn5trWqkFyf
	tFs7ZFW3ur98Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMfO79UUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC9QDDtmoGveBcwgAA3v
X-Rspamd-Queue-Id: 09BEA54A047
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-288193-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[congei42@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

plip_close() stops the IRQ and the poll timer but does not cancel
the immediate and deferred work items before returning. These two
work items are initialised in plip_init_netdev() via
INIT_WORK(&nl->immediate, plip_bh) and
INIT_DELAYED_WORK(&nl->deferred, plip_kick_bh).
plip_cleanup_module() calls free_netdev() which frees the
net_local structure while those work items may still be queued or
running in the workqueue, resulting in a use-after-free.

Fix this by calling cancel_delayed_work_sync() and cancel_work_sync()
after all sources of new work scheduling have been shut down (IRQ
disabled, poll timer stopped) but before releasing parport and
freeing any skbs.

Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/net/plip/plip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index d81163bc910a..4f0ab14f2024 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -1141,6 +1141,9 @@ plip_close(struct net_device *dev)
 		wait_for_completion(&nl->killed_timer_cmp);
 	}
 
+	cancel_delayed_work_sync(&nl->deferred);
+	cancel_work_sync(&nl->immediate);
+
 #ifdef NOTDEF
 	outb(0x00, PAR_DATA(dev));
 #endif
-- 
2.34.1


