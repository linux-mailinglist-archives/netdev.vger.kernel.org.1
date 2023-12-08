Return-Path: <netdev+bounces-55256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5A809FF8
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C314281B9A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79612B83;
	Fri,  8 Dec 2023 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V67GxKH4"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952F9172B
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZfVcCRN7TGJNPU/oKOExKs0+eTvohw5Fj4WDNPwYC6I=; t=1702029141; x=1703238741; 
	b=V67GxKH4/BY8573xEGJXro4y7tSatk6ZVHS/ifjXHphQpFforoaX5XuB8CB/vJkRnCNBz3pzlQn
	J1cIkBdbYscYA94x6Xsd+7udTU7zwThS2t4ZZFSH7lwD176/o4kQc7IxBAsvN8AUyhz/3xSQa65rG
	Yzn7i3wQ3v/wOlGEXYbImmohCQ5EFdvwisj8363A5iZ87lz0d7OmOSurBqvibyd2l6crISScFTw65
	RrxfM5IXO30/9t54xJOobvkwkA3abj0AuYn7yzz0E8+roaSxAXDRy8JTnmiuL/CsPtddMOpe9BU8I
	8iwjD4ZEIRaEE73R2ttV9ND9yC4YjAEctG/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rBXWs-00000002g6Q-02dc;
	Fri, 08 Dec 2023 10:52:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] Revert "net: rtnetlink: remove local list in __linkwatch_run_queue()"
Date: Fri,  8 Dec 2023 10:52:15 +0100
Message-ID: <20231208105214.42304677dc64.I9be9486d2fa97a396d0c73e455d5cab5f376b837@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit b8dbbbc535a9 ("net: rtnetlink: remove local list
in __linkwatch_run_queue()"). It's evidently broken when there's a
non-urgent work that gets added back, and then the loop can never
finish.

While reverting, add a note about that.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: b8dbbbc535a9 ("net: rtnetlink: remove local list in __linkwatch_run_queue()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Clear case of me being asleep at the wheel ... sorry about that!
---
 net/core/link_watch.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 7be5b3ab32bd..429571c258da 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -192,6 +192,11 @@ static void __linkwatch_run_queue(int urgent_only)
 #define MAX_DO_DEV_PER_LOOP	100
 
 	int do_dev = MAX_DO_DEV_PER_LOOP;
+	/* Use a local list here since we add non-urgent
+	 * events back to the global one when called with
+	 * urgent_only=1.
+	 */
+	LIST_HEAD(wrk);
 
 	/* Give urgent case more budget */
 	if (urgent_only)
@@ -213,11 +218,12 @@ static void __linkwatch_run_queue(int urgent_only)
 	clear_bit(LW_URGENT, &linkwatch_flags);
 
 	spin_lock_irq(&lweventlist_lock);
-	while (!list_empty(&lweventlist) && do_dev > 0) {
+	list_splice_init(&lweventlist, &wrk);
+
+	while (!list_empty(&wrk) && do_dev > 0) {
 		struct net_device *dev;
 
-		dev = list_first_entry(&lweventlist, struct net_device,
-				       link_watch_list);
+		dev = list_first_entry(&wrk, struct net_device, link_watch_list);
 		list_del_init(&dev->link_watch_list);
 
 		if (!netif_device_present(dev) ||
@@ -235,6 +241,9 @@ static void __linkwatch_run_queue(int urgent_only)
 		spin_lock_irq(&lweventlist_lock);
 	}
 
+	/* Add the remaining work back to lweventlist */
+	list_splice_init(&wrk, &lweventlist);
+
 	if (!list_empty(&lweventlist))
 		linkwatch_schedule_work(0);
 	spin_unlock_irq(&lweventlist_lock);
-- 
2.43.0


