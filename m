Return-Path: <netdev+bounces-291644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL03JfR2FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05535D4382
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E63931AFC12
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA443DD872;
	Tue, 26 May 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRAEpwtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA13DD85D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791167; cv=none; b=Cko8qlVV1JdOa8BeELfyuNGszwmPPf+qS8DV9fICfs+uZvnSdFwjOBjSuZva1/J7yilBLdczQGcWfIYUTqy4MZ8q2frH7KJyJ9n97Q7CLxyeWJqu/KPu+l+MFZIXHOOpsbMjiQ5S2kum8iqcVNIySVbh+zRDrXe1maaPPsvyOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791167; c=relaxed/simple;
	bh=ugdezamtbLqV8zRH5HK62q+0UmZzSIYuy75obV6uFz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILpaTyboqmGHb9UWJ0gOnpCYcSmxEGIunYdwlT2mmHvNyyLPekWdvGHi6/3LHERmM62IMN/awjFScC3m+jktiNIupQavOE5NOTln+63J3ZUU0YtWG2MaNPoZDRqImA+doXuZsKpnXsKNFBaY/zpS699Iypb2HY2j4k5jIYgaNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRAEpwtd; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36af4b7840aso1006165a91.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791165; x=1780395965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWfI8BI/45zELXfcQ9+WErn1G2kjuN1/82K6JhNrzNQ=;
        b=ZRAEpwtdw9VXHstM5ILhOp4s170vtBKc+mnvwfomkkQtn1Hv8AtlgwHk0KFyzVZ7DX
         Hug/H8Hakd5y7pk9VTdSwFObWKa+oyBdPkdgKIQM/b18Gur1p61K2AXoUfOKMlLxVp9Y
         fzcYoogKl1kZ+2mSHr4JUAkMFy0XP4NITAW5pkeZzxhK3KfqnscH5R0GPYowk3nodVUN
         dt9+wyJRBGii2qCUe2Y6gvU65uIlvRDbQEfGTH1oRzHkPiPI+8UiofElXe/BQpZxRH+e
         ZMgjNlZiqc6SdwDffp7XaY5Em1v14+DZx3WnbxdT5IWb/Xwd2lbYdxZqLWOACMNK96bK
         6RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791165; x=1780395965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWfI8BI/45zELXfcQ9+WErn1G2kjuN1/82K6JhNrzNQ=;
        b=gkjJl6QdBQEzmqSmNbdTXrdDZCGEpbiJHQMUP8IR43ZkeVyewvd8Q6zKokCw1bQ9qV
         AtBR19CpkGVtjwGMEKqCW9arKuVi4lq+NY4LvUjWDzScHgoj0GVViNNLPclsjLrvZCp1
         tWaXzTQ2RCF+56gaFm80ZqusZiwt2WHHFPMoAIe/7UA/yIqDKAnCNetGZwjb/TyWnu27
         COUzx2xfRsSMcfWrYqu1N7igFWLxNHWNsQZZ/JYA05MG59RNFlAtfqVtVmHZ6+BdK/2J
         i9xGYDZbJXQBYo/+dQf6xiefEN34ctWJZLLgGFHGY2LMPU7Y3J5wlsSkyOLT0jWxMKfg
         1yzQ==
X-Gm-Message-State: AOJu0YwUXmKfjmEE5HdCbHQ79iOgHssaECcI7mn5Z4PbsSr8JVGXRUQq
	OzZ58hBKM/J+kFJtbmjlZ6+BKKerW76/lDiGAkiq2lGNpzwTc8LNGNiQ
X-Gm-Gg: Acq92OE0JyJ0EBOjO1ByiNAwkCmGAh7Mr5Zw0Au5n+nKcHV51L5p9+ZSSS3hmLCSBxU
	5nAYbZhJ46iO0pqtp+LqpUU8TV3XZS1aYN8pJUUqcRRfZMFJnP/i4+S7+lfNdPa4xcsLuUL+ikf
	5PMSuIM5xspxXM2HRFQDcsJIFGdtd5+asrObmaEAOCkMs2GUpvE8b0WME8CVuO/FpeqTjstz8WZ
	ce19hRhU/2HFmxurCbr15KSlV+iTFr+8wykZc0ifsZb6yDZN1xkUTgDnStrO33t7ResP0QIvRrn
	7RLRFVTHpfKsTg1UudwzXPKqlN0B4HDI+ldWEHsN/Q+y6PUAMjzWHYqIB7RIf7SZPzMbB6TMAzF
	knftYyhihyWGMY9NzFkEhTbjl/+oN7rGA9WiEDYQ8Uid8CPC9WwlvNYDzeIJ55hVl13j2jvZftd
	NH4RzUZUd3hDDbOcWTR0LlfTIqMr/KMx44l9QmIzS8YdFwceoP7jqz0ZyoDf5JIZEZ9XC9C20=
X-Received: by 2002:a17:90b:2d44:b0:369:a74b:28cc with SMTP id 98e67ed59e1d1-36a674f3475mr16588346a91.18.1779791165456;
        Tue, 26 May 2026 03:26:05 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm12416647a91.9.2026.05.26.03.26.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:26:05 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] amt: fix use-after-free in amt_source_work
Date: Tue, 26 May 2026 18:25:59 +0800
Message-ID: <20260526102559.31926-1-kipreyyy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291644-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F05535D4382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amt_source_work() dereferences gnode->amt and gnode->tunnel_list before
acquiring rcu_read_lock() or tunnel->lock. A concurrent teardown
(amt_clear_groups -> amt_del_group) can free gnode via kfree_rcu between
the pointer read and dereference because cancel_delayed_work() in
amt_destroy_source() does not wait for already-running work.

Move rcu_read_lock() before the gnode dereferences so kfree_rcu cannot
reclaim the memory while the work handler is accessing it. After
acquiring tunnel->lock, verify the source node is still on gnode's hash
via amt_lookup_src() to handle the case where teardown already processed
this source.

Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 drivers/net/amt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a5..f70d49cca285 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -291,13 +291,18 @@ static void amt_source_work(struct work_struct *work)
 	struct amt_source_node *snode = container_of(to_delayed_work(work),
 						     struct amt_source_node,
 						     source_timer);
-	struct amt_group_node *gnode = snode->gnode;
-	struct amt_dev *amt = gnode->amt;
+	struct amt_group_node *gnode;
+	struct amt_dev *amt;
 	struct amt_tunnel_list *tunnel;
 
+	rcu_read_lock();
+	gnode = snode->gnode;
+	amt = gnode->amt;
 	tunnel = gnode->tunnel_list;
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
+	if (!amt_lookup_src(tunnel, gnode, AMT_FILTER_ALL,
+			    &snode->source_addr))
+		goto unlock;
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -308,8 +313,9 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
+unlock:
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
-- 
2.50.1 (Apple Git-155)


