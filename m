Return-Path: <netdev+bounces-300005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0T9DDX4HMmqetwUAu9opvQ
	(envelope-from <netdev+bounces-300005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:33:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D569626F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:33:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=mApdaaOW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300005-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300005-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32D1E30060AF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A412E5B21;
	Wed, 17 Jun 2026 02:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4452E739F
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:33:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663607; cv=none; b=czQ+83x1YsxoOJp1WMamqPxCEgbH46Tv1fINTjgmcY81BADGwxPMn5uqiNSznHOhojhSqTI+9P+fU7MYINMiS/YqdCy2b7MogYRLxdkA1t3Mt/IfeoNARev62Ft5Bvh/Bgt8BFVWcswA91Jvbfppntc5Y08m2iYlhrNm5zYUMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663607; c=relaxed/simple;
	bh=vVC14vn7bkjD1+7EI3QB08N+5lsbGluXCihSl/wm/mY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE1L7V8TsfjCDz1IR+4oB1709KK/jWpUfnqsGcS6vuxtjvU5POCGA/KISq9vvYv/5PffQjXE82sh6SuVNKiDiZw1Y3Ctyv0UN48f7LZG+Pr5AD2+cPBnH6QCODnjWqL+/VJ5xEmvFLF2D1Le24KAUxrNIFRXzf/Vo+DBcHR8B6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mApdaaOW; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HC
	RNru1BWNtykXM8/uZR/foov5l92Z6L8bppAq8MdFc=; b=mApdaaOWQCiQUJZvXg
	1+DDb1frKumQdePMWzI7Z5JUvYB3FtHQUN990nWefkiWwIcNqas8s06VryT7xgQv
	oKnArM/aWBi/TThCQVceJqDnz/iJVI7S5R8zmkChi+xb7Br7ltKJQL7Z/Bd/gJ1+
	/TUL3cz3d1A+Pt99p3Pi8gwa8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3j71MBzJquHB5Cg--.57456S2;
	Wed, 17 Jun 2026 10:32:44 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH net-next] ionic: Change list definition method
Date: Wed, 17 Jun 2026 10:32:43 +0800
Message-Id: <20260617023243.61595-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3j71MBzJquHB5Cg--.57456S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr15tw1UXr47Jw4fAr4DXFb_yoW8GFW3pr
	W5Aa48Xr4UXr4UW3Wktr4xZFZ5X3WvvrWDurnIk3yrWrn7JF4xAa1qqFW5J3WkXrW8Gw1S
	qr9F9an8AFn8Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEjg4sUUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbCzgz7SWoyB0yjUQAA3R
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300005-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:zhulei_szu@163.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D5D569626F

From: Lei Zhu <zhulei@kylinos.cn>

The LIST_HEAD macro can both define a linked list and initialize
it in one step. To simplify code, we replace the separate operations
of linked list definition and manual initialization with the LIST_HEAD
macro.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
 drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 528114877677..967f4e1e97b4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -558,8 +558,8 @@ struct sync_item {
 void ionic_rx_filter_sync(struct ionic_lif *lif)
 {
 	struct device *dev = lif->ionic->dev;
-	struct list_head sync_add_list;
-	struct list_head sync_del_list;
+	LIST_HEAD(sync_add_list);
+	LIST_HEAD(sync_del_list);
 	struct sync_item *sync_item;
 	struct ionic_rx_filter *f;
 	struct hlist_head *head;
@@ -567,9 +567,6 @@ void ionic_rx_filter_sync(struct ionic_lif *lif)
 	struct sync_item *spos;
 	unsigned int i;
 
-	INIT_LIST_HEAD(&sync_add_list);
-	INIT_LIST_HEAD(&sync_del_list);
-
 	clear_bit(IONIC_LIF_F_FILTER_SYNC_NEEDED, lif->state);
 
 	/* Copy the filters to be added and deleted
-- 
2.25.1


