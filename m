Return-Path: <netdev+bounces-275655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMO9GlXn02lKnwcAu9opvQ
	(envelope-from <netdev+bounces-275655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AAE3A589A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D4E301CF89
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB3634A788;
	Mon,  6 Apr 2026 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a0/WVFwx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="udBgIr8b"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBB38C42E;
	Mon,  6 Apr 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494926; cv=none; b=I2GvtilCGQLvEb0ShK5CeY320Kwg3LaWAFFvf9wzT0anK9iwTDO+5dxylOT0NveHzfdg+Hwb7c+IyC+LttYAe//CMctH9draV8fVesIPme1Lu9Ex/zBctPSDYqL/ELPbfXKK+HUJeuqQYUgz+VyhR+mHoeGRjug65MeWlNFXS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494926; c=relaxed/simple;
	bh=idElmEV9x1NEx5c7emHcqtmiAc/XCq1b9VzEMW+DVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoOYlvj5ibvqEGvlTpD47h0e/ZIphwj42w9rAZHjkPrklTYYyQvG5yV/nlE7jkbDSJq7fipck4RyVcpAVXq8avztfCgbWdTiyijQGPC23TmvvPGkgeA9OW0jUqs6kjRg0GfKIMYhrQDl+w3N7vVKNjhJh44Ksf9ZLBiLFKsC3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=a0/WVFwx; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=udBgIr8b; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fqFwx63S9z9yMV;
	Mon,  6 Apr 2026 19:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775494913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApxqaTleQecF8TgqGnNZO60kcLr6U1Ym6AbToNAUwYU=;
	b=a0/WVFwxGaificscFo/EGgfoxFj8099QPUpc+l65WOphpdMOdrxd893kkYSfoeFuzutunk
	ksB5HRYmttLDdLC0ZW/QjfiSBpHtIUtSuOncqjYRGVkn+QBhzNGaSU1kJJf2rWIRyk2RYC
	m2P2XCr/+38BrmxDOLonai6jvJm184Z2rihzMgov80G08rWspvLiU8+qbZB9A5HbVepozX
	L0IVytpWEF7HtmETHLQK5g865rvKtNmFAi3l5SgvMWAseHL0m9iHyIuCd7kaeqCD8odjIK
	yImu7MSe7RFVBDaGi8T6GWvXQs6xfJlIxcVSvGQNesZKyXjgtQyLi1VKy0u5gA==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775494911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApxqaTleQecF8TgqGnNZO60kcLr6U1Ym6AbToNAUwYU=;
	b=udBgIr8bDsS6xvk8ZNP8Ibrbq8nVVvIfvdEig8eVn8ilzTLqNs+uLs7tbqwDMllv5Y7dOQ
	Wa4POy27YUenkP9ChemVgvlIny41wL40mdlr4tvDACaAedbSLDLnUmU94s41rQv/9hjUKF
	Lh32Vl8VmwC5VCreGfsDC7cC9vh08UAiuBAk6X2z5nBXByYhRj7tR03OzQQTBXZhsu+jp1
	IGxn842sT6FPtNKVDyMnMFPn+bsBsOPoP3phfJcaNh2yOqipPBvuAaxORUxJI4Awj0ykIJ
	v0DlMBtsJ5nl/WHkZ7082q0c/A2Z/YqGg5VFtoOSRrxHB9vyIme9W28GLjm65A==
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net v3] net: rose: defer rose_neigh cleanup to workqueue to fix UAF
Date: Tue,  7 Apr 2026 01:01:25 +0800
Message-ID: <20260406170125.175258-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260405125830.89251-1-mashiro.chen@mailbox.org>
References: <20260405125830.89251-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 21d1c14604bfdb8fd27
X-MBO-RS-META: g4e9ownz6mposspsqtdm8xkthyfpk6nf
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275655-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,abd2b69348e2d9b107a1];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C5AAE3A589A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_neigh_put() frees the rose_neigh object when the reference count
reaches zero, but does not stop the t0timer and ftimer beforehand.
If a timer has been scheduled and fires after the object is freed,
the callback will access already-freed memory, leading to a
use-after-free.

The UAF can be triggered through the following sequence:

1. rose_add_node() creates a rose_neigh with refcount=2
   (initial neigh_list reference plus one held by the new node entry)
2. A socket connects via rose_get_neigh(), rose_neigh_hold() raises
   refcount to 3; rose_transmit_link() arms t0timer on the neigh
3. The routing entry is deleted: rose_del_node() drops the node
   reference (3->2), calls rose_remove_neigh() which stops both
   timers, then drops the neigh_list reference (2->1); the socket
   now holds the only reference with t0timer stopped
4. T1 expires in ROSE_STATE_1: rose_timer_expiry() sends
   CLEAR_REQUEST via rose_transmit_link(), which sees
   neigh->restarted=0 and !rose_t0timer_running, and re-arms
   t0timer on the neigh (refcount still 1)
5. T3 expires in ROSE_STATE_2: rose_timer_expiry() calls
   rose_neigh_put(), refcount drops to 0, kfree(neigh)
6. t0timer fires, rose_t0timer_expiry() accesses freed neigh -> UAF

Calling timer_delete_sync() directly in rose_neigh_put() would fix
the UAF but is unsafe: rose_neigh_put() can be called while holding
spinlocks (e.g. rose_route_frame() holds rose_neigh_list_lock and
rose_route_list_lock), and timer_delete_sync() may block waiting for
a running callback, which is illegal in atomic context.

Fix this by deferring the final cleanup to a workqueue. When the
refcount drops to zero, schedule rose_neigh_free_work() instead of
freeing inline. The work function runs in process context where it
is safe to call timer_shutdown_sync() before freeing the object.
timer_shutdown_sync() is used instead of timer_delete_sync() to
permanently prevent the self-rearming t0timer from firing again
after the work function starts.

Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
Reported-by: syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=abd2b69348e2d9b107a1
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
Changes in v3:
  - Replaced timer_delete_sync() in rose_neigh_put() with a workqueue
    to avoid calling a blocking function in atomic context
  - Added rose_neigh_free_work() to handle cleanup in process context
  - Added struct work_struct free_work to struct rose_neigh
  - Used timer_shutdown_sync() to prevent the self-rearming t0timer
    from firing again after cleanup begins

Changes in v2:
  - Stop t0timer and ftimer before freeing the object

 include/net/rose.h    | 10 ++++------
 net/rose/rose_route.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/net/rose.h b/include/net/rose.h
index 2b5491bbf39ab..704214e38ef1d 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -9,6 +9,7 @@
 #define _ROSE_H 
 
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 #include <linux/rose.h>
 #include <net/ax25.h>
 #include <net/sock.h>
@@ -105,6 +106,7 @@ struct rose_neigh {
 	struct sk_buff_head	queue;
 	struct timer_list	t0timer;
 	struct timer_list	ftimer;
+	struct work_struct	free_work;
 };
 
 struct rose_node {
@@ -159,12 +161,8 @@ static inline void rose_neigh_hold(struct rose_neigh *rose_neigh)
 
 static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 {
-	if (refcount_dec_and_test(&rose_neigh->use)) {
-		if (rose_neigh->ax25)
-			ax25_cb_put(rose_neigh->ax25);
-		kfree(rose_neigh->digipeat);
-		kfree(rose_neigh);
-	}
+	if (refcount_dec_and_test(&rose_neigh->use))
+		schedule_work(&rose_neigh->free_work);
 }
 
 /* af_rose.c */
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index e31842e6b3c8b..8c8e09793d442 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/workqueue.h>
 #include <linux/init.h>
 #include <net/rose.h>
 #include <linux/seq_file.h>
@@ -44,6 +45,19 @@ static DEFINE_SPINLOCK(rose_route_list_lock);
 
 struct rose_neigh *rose_loopback_neigh;
 
+static void rose_neigh_free_work(struct work_struct *work)
+{
+	struct rose_neigh *rose_neigh =
+		container_of(work, struct rose_neigh, free_work);
+
+	timer_shutdown_sync(&rose_neigh->t0timer);
+	timer_shutdown_sync(&rose_neigh->ftimer);
+	if (rose_neigh->ax25)
+		ax25_cb_put(rose_neigh->ax25);
+	kfree(rose_neigh->digipeat);
+	kfree(rose_neigh);
+}
+
 /*
  *	Add a new route to a node, and in the process add the node and the
  *	neighbour if it is new.
@@ -103,6 +117,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 
 		timer_setup(&rose_neigh->ftimer, NULL, 0);
 		timer_setup(&rose_neigh->t0timer, NULL, 0);
+		INIT_WORK(&rose_neigh->free_work, rose_neigh_free_work);
 
 		if (rose_route->ndigis != 0) {
 			rose_neigh->digipeat =
@@ -388,6 +403,7 @@ void rose_add_loopback_neigh(void)
 
 	timer_setup(&sn->ftimer, NULL, 0);
 	timer_setup(&sn->t0timer, NULL, 0);
+	INIT_WORK(&sn->free_work, rose_neigh_free_work);
 
 	spin_lock_bh(&rose_neigh_list_lock);
 	sn->next = rose_neigh_list;
-- 
2.53.0


