Return-Path: <netdev+bounces-53624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEBA803F28
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B064B20AC7
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325733CF5;
	Mon,  4 Dec 2023 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gF52IK8S"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F39AF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=nLRIsKHfPCSSM+B0sVxe89ivb9vOKkaNXVkyFCnEc4M=; t=1701721198; x=1702930798; 
	b=gF52IK8SSfaTUNvdPAO1u2H+L7VknMPsaj1I0wu5eAraaUpQQ4d4IJ8eiTl1txrEsAotGucSU9o
	TyF6yrvBrTbp0K5cgj3opRU31q9qyLA4bFzYmB5kGTn2Lg1Tmqp82fk5VbMgaBcUT/giXyWhvn8rO
	uUAPQlj5NhL+I9eRtUC9FSNfYwd/6nLIfNsM+wBnADrqVCryv4jZtI1LnjdAkgcg69AjkXMXugDx1
	88XFb6o9VsluiUBhh+oDKU4bqsm8T5rWXrs1Wv67HsugqIyow04ZzjPsh99uQ3OVnf0ZtVOJuDki9
	6Fx1Hf9ySqbpNpss6I1yH0QF4sBVRiSSShcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAFQ3-0000000FElb-1cYe;
	Mon, 04 Dec 2023 21:19:55 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] net: rtnetlink: remove local list in __linkwatch_run_queue()
Date: Mon,  4 Dec 2023 21:19:53 +0100
Message-ID: <20231204211952.01b2d4ff587d.I698b72219d9f6ce789bd209b8f6dffd0ca32a8f2@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Due to linkwatch_forget_dev() (and perhaps others?) checking for
list_empty(&dev->link_watch_list), we must have all manipulations
of even the local on-stack list 'wrk' here under spinlock, since
even that list can be reached otherwise via dev->link_watch_list.

This is already the case, but makes this a bit counter-intuitive,
often local lists are used to _not_ have to use locking for their
local use.

Remove the local list as it doesn't seem to serve any purpose.
While at it, move a variable declaration into the loop using it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/core/link_watch.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index c469d1c4db5d..ed3e5391fa79 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -192,8 +192,6 @@ static void __linkwatch_run_queue(int urgent_only)
 #define MAX_DO_DEV_PER_LOOP	100
 
 	int do_dev = MAX_DO_DEV_PER_LOOP;
-	struct net_device *dev;
-	LIST_HEAD(wrk);
 
 	/* Give urgent case more budget */
 	if (urgent_only)
@@ -215,11 +213,11 @@ static void __linkwatch_run_queue(int urgent_only)
 	clear_bit(LW_URGENT, &linkwatch_flags);
 
 	spin_lock_irq(&lweventlist_lock);
-	list_splice_init(&lweventlist, &wrk);
+	while (!list_empty(&lweventlist) && do_dev > 0) {
+		struct net_device *dev;
 
-	while (!list_empty(&wrk) && do_dev > 0) {
-
-		dev = list_first_entry(&wrk, struct net_device, link_watch_list);
+		dev = list_first_entry(&lweventlist, struct net_device,
+				       link_watch_list);
 		list_del_init(&dev->link_watch_list);
 
 		if (!netif_device_present(dev) ||
@@ -237,9 +235,6 @@ static void __linkwatch_run_queue(int urgent_only)
 		spin_lock_irq(&lweventlist_lock);
 	}
 
-	/* Add the remaining work back to lweventlist */
-	list_splice_init(&wrk, &lweventlist);
-
 	if (!list_empty(&lweventlist))
 		linkwatch_schedule_work(0);
 	spin_unlock_irq(&lweventlist_lock);
-- 
2.43.0


