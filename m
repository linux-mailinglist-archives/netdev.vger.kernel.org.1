Return-Path: <netdev+bounces-302994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K0BDKthoQ2o3YAoAu9opvQ
	(envelope-from <netdev+bounces-302994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24876E0ED4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=HvmidflY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302994-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302994-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0FF301BC00
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1524E4A1;
	Tue, 30 Jun 2026 06:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40663769FF
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:55:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802553; cv=none; b=Si+/+9oZa8yIzxMmwCJDq+ZUFg66P0MYfclGMuabUjtM1Dtn6eRiJzEC9qQMrhXcJw/0YDcxusilm3WxNYYaDrcOZAogD3f7K91q/7g0OXs9aTWWQRrOCOlT5D3nqIGUONpRo0iz58q+p6IxL0qp9G0h+Npnfy+Oy7iDnHtAKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802553; c=relaxed/simple;
	bh=RzuoUUZ6tYzgPoyMYxyxx8mWj6eTajWQBCMtPu4AUYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNP8flaChJeREUGXj02gcioD9dPwsCh/J3/b8hQwDQds7LV5p+XMPqSpIDHwl+XGU7qdOJe7w6qVlLFjD+6UjFxOAOY59qqlrxoC3fMtOmnq3ByJRoz0JvXgB3xn4AGVqz1PhXfB3UrMhwwYYOVfiPSSs1swLiy2bjuIWdkYnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HvmidflY; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iN
	CHxb/XEYBf2o87FGPSKIto5KYs578bW7m8tmP/sPA=; b=HvmidflYU60hros/tV
	1oH0H4n1UVOmwWJB6IIvVmXSQgv0WbFCcj0aNGo7+03cw7tqyy1CMLKcEjFpzdx2
	T80RmY0QOmOIzdmbp2MVBpo0+8iQM4TvEv5x5L3y3McEJTF87wcc089+5E7KkVNJ
	k+GUeMSc7EewVwyg2uHaqmCaI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBX1PJBaENq4+DbEQ--.36962S2;
	Tue, 30 Jun 2026 14:54:59 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH net-next v2] ionic: Change list definition method
Date: Tue, 30 Jun 2026 14:54:57 +0800
Message-Id: <20260630065457.160081-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBX1PJBaENq4+DbEQ--.36962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr15tw1UXr4UArWkKrWUtwb_yoW8Xr1Upr
	W5Ja48Xw47Xr4UW3Wktr4xZFZ5Xa48ZrWDur1qk3yrWrn7tF4xAa1jqFW5J3WkXrW8G3WS
	qr9F9an8AF1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEAhLUUUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7wOV4mpDaEOfXQAA3b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302994-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:zhulei_szu@163.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E24876E0ED4

From: Lei Zhu <zhulei@kylinos.cn>

The LIST_HEAD macro can both define a linked list and initialize
it in one step. To simplify code, we replace the separate operations
of linked list definition and manual initialization with the LIST_HEAD
macro.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
Changes in v2:
  - Order the variable declaration lines longest to shortest

 drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 528114877677..c999754afb5f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -558,18 +558,15 @@ struct sync_item {
 void ionic_rx_filter_sync(struct ionic_lif *lif)
 {
 	struct device *dev = lif->ionic->dev;
-	struct list_head sync_add_list;
-	struct list_head sync_del_list;
 	struct sync_item *sync_item;
 	struct ionic_rx_filter *f;
+	LIST_HEAD(sync_add_list);
+	LIST_HEAD(sync_del_list);
 	struct hlist_head *head;
 	struct hlist_node *tmp;
 	struct sync_item *spos;
 	unsigned int i;
 
-	INIT_LIST_HEAD(&sync_add_list);
-	INIT_LIST_HEAD(&sync_del_list);
-
 	clear_bit(IONIC_LIF_F_FILTER_SYNC_NEEDED, lif->state);
 
 	/* Copy the filters to be added and deleted
-- 
2.25.1


