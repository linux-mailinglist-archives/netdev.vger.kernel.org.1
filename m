Return-Path: <netdev+bounces-267243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBKKIglds2nfVQAAu9opvQ
	(envelope-from <netdev+bounces-267243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:40:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E823327BAE9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441363087E19
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831862D46B3;
	Fri, 13 Mar 2026 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcjYSCiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1B2C1584
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362358; cv=none; b=Lo+WFCwd0CQMQtnutQjlAcUN1RyL+pTbDTopU3HaxY3edzCDUbpJdUd8TWdKMUdG7hULJfyxFuj4ZADBpZmSwkLKeBh9+jvdkzVCtp1zpHU7sgms6S9xQ78kwyAmAj6LJ1Yr4gWusmONZAYERrMNmfXTPcAfaf5pQh9EQluZn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362358; c=relaxed/simple;
	bh=OAu8UlbgUd1nMPgKQB2dY98piL++9stgqPW2B9hO9gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ta1Tie+vEpJFbCw9yRdXdm1kbAGf221D8GjA0yCtoJNf2TtRr1kzi5a9RSRo4+PlEXm/P7eagP9b1NoRs60ev43/nPMjXNNs+9+W1BmdS8DT6s1w/iEoI+W9jGlbyhyPC/Xb6VuHg1ZsGD/JHEeCvmNsuS/gnttzFeWaYI/GVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcjYSCiO; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-466f1c3c627so1192900b6e.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773362354; x=1773967154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNk5qBnCRvn/ZWo31W3zBycf6HNs4s8EDW3tGXetEGw=;
        b=HcjYSCiO7XfWyTezFyt76j2dNuHQVMj36+JN3W78Z0xoguF6zHDghDFsfpmj388amQ
         C/dY74X3JyAn6HrWBisUbuQr62VEx9QU7d9iqq/4fvSsd7jHxKMaCpnUtzVVFCrjE8Mc
         vqTLH34JTzZ7IFyPoM/kWht2L1OjfWfMzfLRl9M/9F1OiSmgdZPysnXFGLABAlCAUFxM
         DELNzeoY5RqWdQYgEYblJ15k2/PXt5ghebn1yNMT1S4StjwqbZjQUbO1fGKEPKooAeTK
         x4Nxh9vDjWCr819l2hyRNRxJCRePZXjxdCnJGQkLIAosRZZN8CuOAH0uxmM4RMRvKREV
         Z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362354; x=1773967154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNk5qBnCRvn/ZWo31W3zBycf6HNs4s8EDW3tGXetEGw=;
        b=KgWwLHmLMRH+kqbSOUtXAJmSD1sTVMt1NDUDkyAKgwzU8GJDKpuHe/vq92PFszUAC+
         dbEDGS5+ga39UfHrY9ehTkuH7rLZzn3LHxXCCN1Gn1u5krowHt+tcD03mQQDl14/FE4k
         xG5Px4gqVBGgDYEg2ykniRLCQmf9ZadOJnzX/WnLXRB6U3rar7TUYruN4FkkuGVEDjCW
         eSSDb8827ldxEiy0reJCbxR1ZugSiRCye3w7fINiWZJGDzeCJZ2UFLI2BJVsiriWvQ/o
         vqjH7JGR/QRwOg+SXKiiLRv6JBEAfytiDHvVxK6GeSPYgKiZyUnw/07xFJLaDBdzD17O
         DULA==
X-Gm-Message-State: AOJu0YwNOYr/RN903PeTxDuui1WvPcFrBQDVHTB9bnrTKs/G/W8e+1Tt
	zGYAqo8W9RCBQ9D4iQ18nDzCOrx3kn9dSRwxfGZ8gs2Q0oZmk6kBqc6OQcIVcmupKQs=
X-Gm-Gg: ATEYQzxyxcvyiKzJz9JBhoHJ+PzhlvoQ6YWWMcmGTYC7ShAE6/AcN5dg2iZNiUAEjl2
	B/NVJ9GnzO5NZba68c1yvXmRPMCVMk1TQqQLilE/8FL4qN5ziPuiCWl2WaZbJkHVhRI+8BQtVAL
	XjPZPv6vT9qPesfXsjQkA5RD0xMg80l79y1L3MoUIj55jNJ8NGA3dCHWf06ccpfh0l+smyn6PkC
	iqYNlwIzyv/kTeL/FeInKe0pxXM1ZiEKgd3+dSYSRCfdjRA0uLBG6jx47+L0uFDyrj33P1A83ss
	DeYLTYfAWwgWwGpetLqhJa/Xp6NeJcHMU/fIRLT+2xmsd5IR7b0Db12kTugxbBVktJFUF5LDYBW
	eUkLevucwbDziOvGcRfHeb7blsC5JdL/6wUQbufu2o2wrvWrod4rI3nqhrAheeOuosr68jgP/nw
	1aKRf+DcjgVxsM7kXro5cDMLS2cx5TOMPDbduUt5HTwLxl7i9ZekOy1Zzn8XG1w5gHvu2UkgSVs
	QgF0vhxrrXU
X-Received: by 2002:a05:6808:c1d8:b0:463:8fba:5df5 with SMTP id 5614622812f47-46757196fdbmr782847b6e.24.1773362353889;
        Thu, 12 Mar 2026 17:39:13 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46743aca62fsm2448030b6e.2.2026.03.12.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:39:13 -0700 (PDT)
From: ShravyaPanchagiri <shravy112@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ShravyaPanchagiri <shravy112@gmail.com>
Subject: [PATCH] net: ifb: fix space after comma in for loops
Date: Thu, 12 Mar 2026 19:36:51 -0500
Message-ID: <20260313003651.65612-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267243-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shravy112@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E823327BAE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing space after comma in for loop to fix checkpatch errors.

Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
---
 drivers/net/ifb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 5407d2ed71b3..58a49ed5aabe 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -18,12 +18,10 @@
 	You need the tc action  mirror or redirect to feed this device
 	packets.
 
-
 	Authors:	Jamal Hadi Salim (2005)
 
 */
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -148,7 +146,6 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		txp->tasklet_pending = 1;
 		tasklet_schedule(&txp->ifb_tasklet);
 	}
-
 }
 
 static void ifb_stats64(struct net_device *dev,
@@ -160,7 +157,7 @@ static void ifb_stats64(struct net_device *dev,
 	u64 packets, bytes;
 	int i;
 
-	for (i = 0; i < dev->num_tx_queues; i++,txp++) {
+	for (i = 0; i < dev->num_tx_queues; i++, txp++) {
 		do {
 			start = u64_stats_fetch_begin(&txp->rx_stats.sync);
 			packets = u64_stats_read(&txp->rx_stats.packets);
@@ -191,7 +188,7 @@ static int ifb_dev_init(struct net_device *dev)
 	if (!txp)
 		return -ENOMEM;
 	dp->tx_private = txp;
-	for (i = 0; i < dev->num_tx_queues; i++,txp++) {
+	for (i = 0; i < dev->num_tx_queues; i++, txp++) {
 		txp->txqnum = i;
 		txp->dev = dev;
 		__skb_queue_head_init(&txp->rq);
@@ -299,7 +296,7 @@ static void ifb_dev_free(struct net_device *dev)
 	struct ifb_q_private *txp = dp->tx_private;
 	int i;
 
-	for (i = 0; i < dev->num_tx_queues; i++,txp++) {
+	for (i = 0; i < dev->num_tx_queues; i++, txp++) {
 		tasklet_kill(&txp->ifb_tasklet);
 		__skb_queue_purge(&txp->rq);
 		__skb_queue_purge(&txp->tq);
-- 
2.43.0


