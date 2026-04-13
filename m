Return-Path: <netdev+bounces-278157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHghEBsr3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:42:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DE3F19D1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8E953024476
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D74376BC6;
	Mon, 13 Apr 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzvH8hlA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47737475D
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102163; cv=none; b=OD8E2sEbMIaHT5zU2ljbtaOym3IbgImUET5P8vObgnI7va97ni6EKyisd9SO/uARZKr1wzA8zO4XDGjyJ4zTAyquiwXzhLEvgkgEFpKAsl1UC1o49NTHeiKuZFkwITIBuqshVmFncA4eBXq28UETm7Uv2pk93SCsr0wByFO0VqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102163; c=relaxed/simple;
	bh=OTz0X3yh+ntiuIihHVw3kNQYGzp/Ed0/a9WAqmWEkGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gbq+ZzWyTWdUSJvBed1fxKnqfM5Lcdmb3+bw3NcCPZhELmvp3NJztTCy13v36ksA5EFYavuhcJBzC5HG/2DFNR4XLofU6P6OVEu7ie48S75pVjqGhACbZy59nxPt8oA6iAMBXlyd6HvZWs6xAPHVPye0kr0ORisYqCojbf4Ofiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzvH8hlA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso50729835e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102160; x=1776706960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxhJ1B20uW8HHCurINx4/ryiANFYybUwN6IVfjVrf9U=;
        b=GzvH8hlAu4DnccEt3Ocw5XDfItG3MMADJn/GDUYnKhV8BVcXe/r4Oca0kRmjJjVvOC
         auHusLU6cINhHXDSx0YQgIkOD1GlJBEcr0NUDcobyP+X370zpEZl1dmqkTNVNXdgbGhB
         8sC9F9vmKwlYRKj46HjJNqMyll/uE2B8rsrQPLFkCdS9ZfUriI88pFrdwFhtubARS5J6
         SMs/i4SR85sqdLzfjWPB+LuysKwv1mqYN9E2woFcA3B98AZ5Knyz2XGeXwDs2Jh4k6TQ
         XiZO87Mgm5GjHfrTywLvohIt3dz14f/hifCWDdR8HE0JZhTvyCsAswaj9agUDKAm8jvM
         pGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102160; x=1776706960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cxhJ1B20uW8HHCurINx4/ryiANFYybUwN6IVfjVrf9U=;
        b=IkavGJHuBN46TTmI9285Zn2ehzc8vLa8QB6rgjhsoXum9XGpwXIVOQntS2jixncUJn
         IQWZp/SoYckyNuAwTNb0jh4bqPqmu5xvHe1IBoBBRD2anK+eceUPY5gFNj8IT36fATsz
         ctJCupf24zU+E2xG1pAfFAl1Myu2TS4SS0IT5slLJK0s3UZ0/hIhm5o9Ipq8zbrgk8t4
         hCW15j+Pd1BlMKG8T2ohl/Gt5HXyhgMXCFUTdmB7lNQgeHybGd/UyC4G6rWd/MuebSKF
         rkfRtMer9fUXA0mENabiCjaxJCeVOBKyX5XWUnrYksWVMw53LE4WktuVg0RfPUj4T1w7
         z7Jg==
X-Gm-Message-State: AOJu0YzbDOsxkCH8DibFNUtTSDX2jL49nRRSVBR9m2tLRiYmgJTg/zFY
	ZgOq3dwN1ZWVQ4tDjO/vOJ4ekKBBfF5Wj/vOUqV2Db0DxyBfwQcFAUkO+ZZn3AGs
X-Gm-Gg: AeBDietJkcLgjsfQo/W1rtuc7K616LfFWBwpqnOWGiRVQtmYw1JOflzDtTHMmylVNKs
	OiiX/LfIyhb9zrDGrzqaUK6r8qJSHv5rgDxn8vG3cXyU0iKBZTdktpCBNNKF6WT1iSVAgv/aaqO
	e5UOK9NMYsKpCLDErhb9vFLEz0f7aFK6KgXzd/Olu15XHR2pFYkeaDGg/auWWexcIHuokX1iPFD
	mhbQ8fIhwWfPm9Kr5YI9I95HUviwHq1xShCCu+J131TTrYKn9+GmBoD/R92cXkBPyA1tqKgsMNw
	m2/PqyDzICffHTYzN/+mYc4k95tSHyNuudM2BhtoGQIkSHnwSfvc4aolhu50gnUORs3UE58MIwn
	senOdjdhnzy0dBfwE07VP1o1hMgpDP1+oIqbApwR18W5V7rGdq0LzwcLAE980TuRTj+T11WaU2f
	RceKg+1H3y0kxHADemAEHdLP8oYOJvWHc2L1ddFVvibkhyPGBQXCv290XmkFQ+qIJaysti0xWFq
	+uB
X-Received: by 2002:a05:600d:1:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-488d6772785mr176197175e9.0.1776102160196;
        Mon, 13 Apr 2026 10:42:40 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm34922778f8f.29.2026.04.13.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:42:39 -0700 (PDT)
From: f6bvp <bernard.f6bvp@gmail.com>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	f6bvp <bernard.f6bvp@gmail.com>
Subject: [PATCH net-next 1/3] rose: fix race between loopback timer and module removal
Date: Mon, 13 Apr 2026 19:42:36 +0200
Message-ID: <20260413174238.112418-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278157-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C68DE3F19D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_loopback_clear() used timer_delete() which returns immediately
without waiting for any running callback to complete.  If the timer
fired concurrently with module removal, rose_loopback_timer() would
access rose_loopback_neigh after it was freed, causing a use-after-free.

Three changes fix the race:

1. Add a loopback_stopping atomic flag.  rose_loopback_timer() checks
   this at entry and mid-loop; when set it drains the queue and bails
   out without re-arming the timer.

2. Switch rose_loopback_clear() to timer_delete_sync() so it blocks
   until any in-flight callback has returned.

3. Wrap the timer body with rose_neigh_hold()/rose_neigh_put() so the
   loopback neighbour cannot be freed while the callback is running.

Also fix a pre-existing bug: dev_put(dev) was only called on the
failure path of rose_rx_call_request(); it is now called unconditionally
so the device reference is always released.

Remove a dead check (!neigh->dev && !neigh->loopback) that can never
be true for the loopback neighbour, which always has loopback=1.

Signed-off-by: f6bvp <bernard.f6bvp@gmail.com>
---
 net/rose/rose_loopback.c | 53 +++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index b538e39b3df5..80d7879ef36a 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -12,13 +12,15 @@
 #include <net/rose.h>
 #include <linux/init.h>
 
-static struct sk_buff_head loopback_queue;
 #define ROSE_LOOPBACK_LIMIT 1000
-static struct timer_list loopback_timer;
 
+static struct timer_list loopback_timer;
+static struct sk_buff_head loopback_queue;
 static void rose_set_loopback_timer(void);
 static void rose_loopback_timer(struct timer_list *unused);
 
+static atomic_t loopback_stopping = ATOMIC_INIT(0);
+
 void rose_loopback_init(void)
 {
 	skb_queue_head_init(&loopback_queue);
@@ -66,10 +68,25 @@ static void rose_loopback_timer(struct timer_list *unused)
 	unsigned int lci_i, lci_o;
 	int count;
 
+	if (atomic_read(&loopback_stopping))
+		return;
+
+	if (rose_loopback_neigh)
+		rose_neigh_hold(rose_loopback_neigh);
+	else
+		return;
+
 	for (count = 0; count < ROSE_LOOPBACK_LIMIT; count++) {
 		skb = skb_dequeue(&loopback_queue);
 		if (!skb)
-			return;
+			goto out;
+
+		if (atomic_read(&loopback_stopping)) {
+			kfree_skb(skb);
+			skb_queue_purge(&loopback_queue);
+			goto out;
+		}
+
 		if (skb->len < ROSE_MIN_LEN) {
 			kfree_skb(skb);
 			continue;
@@ -96,27 +113,24 @@ static void rose_loopback_timer(struct timer_list *unused)
 		}
 
 		if (frametype == ROSE_CALL_REQUEST) {
-			if (!rose_loopback_neigh->dev &&
-			    !rose_loopback_neigh->loopback) {
-				kfree_skb(skb);
-				continue;
-			}
-
 			dev = rose_dev_get(dest);
 			if (!dev) {
 				kfree_skb(skb);
 				continue;
 			}
 
-			if (rose_rx_call_request(skb, dev, rose_loopback_neigh, lci_o) == 0) {
-				dev_put(dev);
+			if (rose_rx_call_request(skb, dev, rose_loopback_neigh, lci_o) == 0)
 				kfree_skb(skb);
-			}
+			dev_put(dev);
 		} else {
 			kfree_skb(skb);
 		}
 	}
-	if (!skb_queue_empty(&loopback_queue))
+
+out:
+	rose_neigh_put(rose_loopback_neigh);
+
+	if (!atomic_read(&loopback_stopping) && !skb_queue_empty(&loopback_queue))
 		mod_timer(&loopback_timer, jiffies + 1);
 }
 
@@ -124,10 +138,15 @@ void __exit rose_loopback_clear(void)
 {
 	struct sk_buff *skb;
 
-	timer_delete(&loopback_timer);
+	atomic_set(&loopback_stopping, 1);
+	/* Pairs with atomic_read() in rose_loopback_timer(): ensure the
+	 * stopping flag is visible before we cancel, so a concurrent
+	 * callback aborts its loop early rather than re-arming the timer.
+	 */
+	smp_mb();
 
-	while ((skb = skb_dequeue(&loopback_queue)) != NULL) {
-		skb->sk = NULL;
+	timer_delete_sync(&loopback_timer);
+
+	while ((skb = skb_dequeue(&loopback_queue)) != NULL)
 		kfree_skb(skb);
-	}
 }
-- 
2.51.0


