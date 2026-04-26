Return-Path: <netdev+bounces-281168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCu9Gv0k7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B546A680
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B16302AC28
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0F36C9E5;
	Sun, 26 Apr 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfRKprcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C04365A12
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214592; cv=none; b=VA0N5T1Sslw3ENIvoCUO1+uMSsF32OFVyoJA5hKNkpMoVRSrAUIKm/ZJS7n/pM95Ij8t7vRQ2vGm3rU5HhW+Z8YvTHF5P9NEm/9H5VE/aczmw9BpIL7No/wv/ZHWRs3Lopvm3RWdil/MrDguKqOqFIIP6mqHvfus7ErCwLLIl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214592; c=relaxed/simple;
	bh=Re4gp72M+Kx1ob9peixynICA2ch+YUmknvJWbzp+frY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/5ROgGm1xVc8J3q7eR2qnfPC1h0/GlHQjTP1Ml0cNQzWkvt+fOyGwJBXdZpTwrAnTSDzyibGF42nwzUeNCtcrLj4oDJfSmoIrTNjyKYkXJa5H8Vz0l0eLqwAzf7ZS49oKkN7r8E9VVivU2ihE+Jj1aeBHcusnBE9n51nZAPIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfRKprcb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so110017735e9.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214589; x=1777819389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skBBZ9ixztfRWmWoAATqpN2NCAoakIzBp3aEndiAumw=;
        b=QfRKprcbzK2Z6Y18O2XVMC12KR8QL0tSoJVegEVPQhh4RCRwH7e6mQiaLGq7LWqWOU
         k257hSI/iYx48pCuhPM+XGC2LBhwu8ZPlawhXnWamHoXUfjhrlfIRCOuqq9O5xdgfQgR
         sPYVBvlsznoAHhQitUMt0iNv/BfIEBJsdQSSxJnVIbM8ROnOZru4aXuXNBfq9dQEHgzx
         p6XGnNrQT/VJcD1F/owWU99NFMPO3XZtBi9NpcjhER4ucN+o1K/ete/sLfC9C8/QtNCS
         V1WSjCdjUnqABrwe0AT71Af1MAuGYuADeFBbCLR5i9vIW/2h0nR4d3ZDTx/i7SVonVW8
         xuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214589; x=1777819389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=skBBZ9ixztfRWmWoAATqpN2NCAoakIzBp3aEndiAumw=;
        b=r21AwqWyGRz8hPKstVIVcG1v2Fpf/Dw3gQr7hTk5y4+CYH0volIIRKA9hVbOx+ZR9L
         ZZnuIlbc0Uz5o1gNtIVw84hLg9vajs5q3foHafXBTKRdHpaz2RuVMQMdlo4KmDxQ1WuV
         L7McztuNiRS2QQOKDFf1RTkOSnKJdLuIGh8W9BYaN323k3Gq46fCHaUjuM/dHYeTdrX0
         o7n+e7FFX57HyepaAMLnSWrTxNLo1yprRtzRY7KER7c0VNU+ttmUbHH5HC3rewKUc3d0
         qdNQYQHT33CXGxYk5E/ecViYSq6XkC4dzcP/No9pO7SPwvp7b1OBeK5qgcSg4enNfbBj
         MVOg==
X-Gm-Message-State: AOJu0Yz3N40Y2XdrHmU8v5GQYrEdfocz7JwiPqVOSJd1LUxLVM0OAg4A
	NxtSD46flfs9cyjEEqFxWnHmGEkfjzMu49TLnKuDrmhjhdvQY9cyUxAQlg3QKw==
X-Gm-Gg: AeBDievfWQOaVpeBNpS7zn1TDu+UbWl3NvCmGcOf9+SKI/zIBXtlfOF1JRrOY9kpQE8
	fu8ldutk6bP2cSSufEPxfeYsaovxp8CwE+/i+pXhjD8Jz+S7DHcDA7L01klWqOcy+mHQqsXtuPn
	fof5uN9bt8pj7ZPqWPpQl0x3tr+d6KU+tUcFHrZOMSd0ida7sWJeSwh0fpANOuMxoHQ1+aFPFJB
	ICSFUx9lz7bOTCph/KEvkJe+ecNtdEB/Oo5XzEjXdO2PQaR7dDFHXZR7HjEZW2DPZspGVTTafxM
	RSnyHcxrY9LrVSRYm+zZM48ipGNp/9OOsbvqpmkQTYluSFSdiout4HvOxXd5z9r55ctD+vK/z7z
	jCWj1lWtNBd5NUmgRsk+kkAaqYE7t2+FSR6mZBpZDP+9YOgVwqOqGJEDHSHqppBKvukoW5P8hsM
	hx9Dgdu352nEY++DiuWDc/YZy5esdQfgeA4eKg+bvKiwEr1h0BeJADT87mWUW/CdLxi/e/h0aS3
	6DnH9GmfxSgbyg=
X-Received: by 2002:a05:600c:a416:b0:488:e7e4:8425 with SMTP id 5b1f17b1804b1-488fb787674mr447887245e9.23.1777214589232;
        Sun, 26 Apr 2026 07:43:09 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:08 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 3/5] rose: fix race between loopback timer and module removal
Date: Sun, 26 Apr 2026 16:43:03 +0200
Message-ID: <20260426144305.984349-4-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
References: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 160B546A680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281168-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

rose_loopback_clear() called timer_delete() which returns immediately
without waiting for any running callback to complete.  If the timer
fired concurrently with module removal, rose_loopback_timer() could
re-arm the timer after timer_delete() returned and then access
rose_loopback_neigh after it was freed.

Two complementary changes close the race:

1. Add a loopback_stopping atomic flag.  rose_loopback_timer() checks
   it at entry (before acquiring a reference) and again inside the
   loop; when set it drains the queue and exits without re-arming the
   timer.

2. Switch rose_loopback_clear() to timer_delete_sync() so it blocks
   until any in-flight callback has returned before freeing resources.

The smp_mb() between setting the flag and calling timer_delete_sync()
ensures the flag is visible to any callback that is about to run.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
---
 net/rose/rose_loopback.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index d66913df360d..80d7879ef36a 100644
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
@@ -66,6 +68,9 @@ static void rose_loopback_timer(struct timer_list *unused)
 	unsigned int lci_i, lci_o;
 	int count;
 
+	if (atomic_read(&loopback_stopping))
+		return;
+
 	if (rose_loopback_neigh)
 		rose_neigh_hold(rose_loopback_neigh);
 	else
@@ -75,6 +80,13 @@ static void rose_loopback_timer(struct timer_list *unused)
 		skb = skb_dequeue(&loopback_queue);
 		if (!skb)
 			goto out;
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
@@ -118,7 +130,7 @@ static void rose_loopback_timer(struct timer_list *unused)
 out:
 	rose_neigh_put(rose_loopback_neigh);
 
-	if (!skb_queue_empty(&loopback_queue))
+	if (!atomic_read(&loopback_stopping) && !skb_queue_empty(&loopback_queue))
 		mod_timer(&loopback_timer, jiffies + 1);
 }
 
@@ -126,10 +138,15 @@ void __exit rose_loopback_clear(void)
 {
 	struct sk_buff *skb;
 
-	timer_delete(&loopback_timer);
+	atomic_set(&loopback_stopping, 1);
+	/* Pairs with atomic_read() in rose_loopback_timer(): ensure the
+	 * stopping flag is visible before we cancel, so a concurrent
+	 * callback aborts its loop early rather than re-arming the timer.
+	 */
+	smp_mb();
+
+	timer_delete_sync(&loopback_timer);
 
-	while ((skb = skb_dequeue(&loopback_queue)) != NULL) {
-		skb->sk = NULL;
+	while ((skb = skb_dequeue(&loopback_queue)) != NULL)
 		kfree_skb(skb);
-	}
 }
-- 
2.51.0


