Return-Path: <netdev+bounces-291663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GHYGFR9FWpEVwcAu9opvQ
	(envelope-from <netdev+bounces-291663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:00:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79175D48D7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59230302FA29
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FCA3DC4A8;
	Tue, 26 May 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRmhyzsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737903D9DAB
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793125; cv=none; b=oBG8DLMioOnByHQJpQxHZsDBz7ggRcsUCZaL6F/yB/aty+8esEOc+yMp/H0oXF+8aP8ZgZJn3RFWtRaNRBwaYw8Fi2awYTiewc2HlwbYuUmrobdVJieAiLDAjZu1jtqnY1xvfP1f9XwJYwC6Yw/PwXLoQ5OkmPSvs0sMtU23gH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793125; c=relaxed/simple;
	bh=h3eG2QmjIMETifXVAO+j11pIWPWGS1vPxHLSGhSl1xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myHDfNLdt1N5QEstkHFHyo6DodeYb1FzxsnvKEhQvisXjyVm+ikfV9YwfBam3WMtzMKFeaIpY7JlWN+MM9YtCmW9aRujiLeSnh+yi4GQnkFZ47vP1RMAVzCFHhbhlBdwh0NEsZuuXLKvKfSdmc9Y0abWsfoGH8nno1anIDYXC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRmhyzsL; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bd80b3aa13so68751275ad.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779793124; x=1780397924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh3fQg5HCIKo1w9Yqef6BJgswV1ozYytHs7xXsk3rlA=;
        b=YRmhyzsL7JxcGl54aWbEDyH6tjbsHjxNnk32vUJttK+oueJNO7fh/e2irlNIBLLkK9
         zYkqm7twHOWn2YRPz1ftGh0oJG+/ey+xa72VgLVFwuIjMKAntnM5R5mbuNJ8DcaY4osY
         ikH3cZ6DQSC6Ky2Sr/3A6OJROnSseXZYm3k1Vvpu52Deogedcohq9Dk6EcbDUuXXbUJ5
         HSCvawUnL0kE0f6Mnh7uWft8bJlTYUOZIcGl5EmuHF9ThO1qj3kQEt0HpsH98fEm5DEM
         8lVE0W79McLDKqXblc/FAzAiiZPky9G5Ih12y1ms76r4Znj0c671x1+iFTHaMWjKR8lH
         s9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793124; x=1780397924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh3fQg5HCIKo1w9Yqef6BJgswV1ozYytHs7xXsk3rlA=;
        b=J2/m3lWLvGW5C/nufbBO3g0UMz6Uj1k5cqorDNKfLXxFt976U4ybjtKDG9AhFO22r9
         GM7izOR1t4J8wxAUBIp0rVkC7ZkoAIL2fO17Wf/VJ1TCLS4f/pYac+hu9H9IiYHF3S6Y
         Qkcf6GFY9Wplj5rpN4CWXs9fHXS6L7tewsOHrEBUxUuOEBYoorePW9mr0Y+KlF0FgiQZ
         KYtAGtvulX1N3k6MHcUMXwOkPHpUwAeBPCpEnJbTlAvDnMOlHFFU9X2nbUOBoiqpUGQy
         2/4TZ7Dy6CcQE40W3OB3e53OuM34X+fQtH0CytQTZVDzXpG4sWi40L/pZp/aDgegRxyy
         WoEQ==
X-Gm-Message-State: AOJu0YwMW7snL77kNDET1ADFYXUPArWG/r6KfQkO2UuHCyz0Btk8uqcz
	tA/W5FEqUjGGXkshgezD2LmsrHXtfX1pQxqulVSuXJxzNXiNfIXng285a5woVgxMjJtHyysp
X-Gm-Gg: Acq92OF7zotKThetsiMdC84btDofqD0b+xt/f696VYvvQkWRWRMrnEF4zRsb6oxOCXf
	Vz6KaibIr66oSHsChfkFHQrjdMMhlG6dEwS0tXUAm8gdM/COzma2dq0ysCkqauVbj2D9KFT5dWT
	ct4JsFAx7ANsl3aHeLTsfeSwP/68GbxXlfGGoSzYNGawhh3C7wKAki6P4OV5wvpQqZ+ENVD6F0F
	RkPn1lPbXrkaxwMSL01thnE5mGmMlqTR0KbHbDZG0Lj0CsYtRXu3SlsqCgjIQ2+YgAYt8Px+gcl
	e26ySbLJHLJhXUsM8AO+EfuZF2mEscyDdzHqgdMU5Rru4odMYyeT9UW7ORQd4kZ9Aogp+9ligX8
	ZLfW8FBlBSK8uNSt5h5fyAs8g6NT/Dq0XErpjGf4OFRFOjj6B1qyVFmVUHoOkb5AZLjDL8ZNfZM
	PGzJ/aruCPQHJmie6/uP1oWni3c4QmLiwkvaCUPj+mM98bwq5ger5WrOiMS0s8
X-Received: by 2002:a17:903:1b4f:b0:2bd:9b0f:5f2e with SMTP id d9443c01a7336-2beb07bac6amr203012225ad.22.1779793123765;
        Tue, 26 May 2026 03:58:43 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3bb6sm123280855ad.47.2026.05.26.03.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:58:43 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] amt: fix use-after-free in amt_group_work
Date: Tue, 26 May 2026 18:58:39 +0800
Message-ID: <20260526105839.19787-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D79175D48D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amt_group_work() dereferences gnode->tunnel_list and gnode->amt before
acquiring tunnel->lock or entering an RCU read-side critical section.
When amt_del_group() runs concurrently (e.g. from amt_clear_groups()
during interface teardown), it calls cancel_delayed_work() which cannot
stop an already-executing handler, then proceeds to kfree_rcu(gnode).
Under PREEMPT_RCU the grace period can complete while amt_group_work()
is between the container_of() and spin_lock_bh(), freeing gnode and
causing a use-after-free.

Fix by wrapping the early gnode dereferences in rcu_read_lock() to
prevent the grace period from completing while the handler accesses the
freed object. Additionally, change hlist_del_rcu() to hlist_del_init_rcu()
in amt_del_group() so amt_group_work() can detect an already-deleted gnode
via hlist_unhashed() after acquiring the lock, avoiding double-processing.

Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 drivers/net/amt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a5..f937957dbd61 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -260,7 +260,7 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
-	hlist_del_rcu(&gnode->node);
+	hlist_del_init_rcu(&gnode->node);
 	gnode->tunnel_list->nr_groups--;
 
 	if (!gnode->v6)
@@ -412,23 +412,31 @@ static void amt_group_work(struct work_struct *work)
 	struct amt_group_node *gnode = container_of(to_delayed_work(work),
 						    struct amt_group_node,
 						    group_timer);
-	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
-	struct amt_dev *amt = gnode->amt;
+	struct amt_tunnel_list *tunnel;
 	struct amt_source_node *snode;
 	bool delete_group = true;
+	struct amt_dev *amt;
 	struct hlist_node *t;
 	int i, buckets;
 
+	rcu_read_lock();
+	tunnel = gnode->tunnel_list;
+	amt = gnode->amt;
 	buckets = amt->hash_buckets;
 
 	spin_lock_bh(&tunnel->lock);
+	if (hlist_unhashed(&gnode->node)) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		goto out;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		/* Not Used */
 		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
-- 
2.50.1 (Apple Git-155)


