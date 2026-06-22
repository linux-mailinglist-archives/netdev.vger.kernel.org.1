Return-Path: <netdev+bounces-301058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1sBBPsVOWpomgcAu9opvQ
	(envelope-from <netdev+bounces-301058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AF96AEEB3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=b6gsrZS7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301058-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301058-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11FB9300B5B7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193119CCFA;
	Mon, 22 Jun 2026 11:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6E3546DF
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126072; cv=none; b=KNSyvHlxzMN+gadOh+Poj/yIqSgJ2NXERPQndZwYEmcs+LOE64G5JiWTJpO/5CxyUzAq01wrXJrKHVxcKEMEtVVccYUhjElhfjBSmIZD9HUnfIRcMLfZYSCvUfeIFTCywkm9VLGq/7LfvYy7kpSQqKrQsenmN71pYxkAxUg20l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126072; c=relaxed/simple;
	bh=hOqf5zMjMvMssmzv74ucGsF8JY6cSQNFPJXc1TK9WRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=reu/qHHj591iD2SE7hcG0w6MPrsVfVU1L2Sjs2Sq3/Jrb6f/sme6ajDDSYmaEkYbuj7GZuZxJg3CQV6zvECifcUX42ESsrimeRMIFXN+sDzy680RmvlpCyu684vnhOdzlpBKF2t/rlkLtglOBRyVN5JAK//jK/q5m8S+cAWMrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6gsrZS7; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-660f247c238so6614814d50.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782126070; x=1782730870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYBo1lFbyMKhv37YpAQVQ0c0jZzJaXmsQ9e4aJRcgZk=;
        b=b6gsrZS7JojxUdvCpnHsVbxZRJcLHVaCokkv1TbqL4ZRl2mbUJOiae/8Up7vCMqb4H
         esWfe+N/H9Voj4xEZ+BiSp2o39xr9lxrNRqGWLFnTCdJHA/jptsbn6F2wQJ467m5qEJ2
         E2KTOdURzLHgRgzYOLogQoM3Tn1RAZDGcp2dPuKqpVXR+wpcYMkj/BNE6q6CuX8Qh9aF
         LWRmg0miIZbVgDqZozC84BCA9V/i6gAX1qrCZ0NuRFwUXX5jh63gruvjCS86ykkbAWkb
         +8SaDudyHQP9S8v5UnnZ4MdUyNHj6LCRUFnO0PM8RzULAsTry7qAdJdNnGAY3DAHpjml
         Xjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126070; x=1782730870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYBo1lFbyMKhv37YpAQVQ0c0jZzJaXmsQ9e4aJRcgZk=;
        b=cjBfJo/DlKL4VfgSZ1m9y7pXkx/ttShwqBrDrjGRX3+u2HdGUwF6JgRpteh8EZ8U5y
         Pr0xsQmFHCIPXu+N09hhC2anl6sGiTZEDX+8Ug4rQ20UEFF3YwR74MjIAeOEyvc5yapS
         4N3WEvdI/mjFzmsKNucYZQK0jb2QHK+gpEDCalMYj7Gt+cccRht5+6jcO5KzaDc8qYAl
         hpS1Oj7s0hfr5FyIGh2vOlCE9bGUhaEOYeJesf+JU2TYz0n2IP9CmUGr0BkC3NkhgXw6
         x/VGZ5OuoOpB8pcRB5qdNvw8AazrKHY7qbVoMncPYfmt00cnTfmoQJcxQ2LGWZgYGfRG
         DtQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoVZWmIpDsdVVkhfJtiZPMA4hBDwBlNlHYBtNENAprTBMMnRmE7CgwXN7qAY7bXr4RKBJJgi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkzTNHBlx1+cmQ/pl++1AO6ZCk+iw347XBl6dwjoakvX+Q8mq
	mYhzSJbHgGetFaT4yv6GsFMLV7pza2snMu1DuFnqJ6guqCSXtbnytTFePoAZQE55johfTKQVeqJ
	tnk6Kms7t3fzjdw==
X-Received: from qvbkc30.prod.google.com ([2002:a05:6214:411e:b0:8dc:9bcb:85a2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:168d:b0:660:7ced:55cb with SMTP id 956f58d0204a3-662ffba0dc6mr10943928d50.1.1782126070084;
 Mon, 22 Jun 2026 04:01:10 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:01:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622110108.69541-1-edumazet@google.com>
Subject: [PATCH net] net: do not acquire dev->tx_global_lock in netdev_watchdog_up()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-301058-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:m.szyprowski@samsung.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AF96AEEB3

Marek Szyprowski reported a deadlock during system resume when virtio_net
driver is used.

The deadlock occurs because netif_device_attach() is called while holding
dev->tx_global_lock (via netif_tx_lock_bh() in virtnet_restore_up()).
netif_device_attach() calls __netdev_watchdog_up(), which now also tries
to acquire dev->tx_global_lock to synchronize with dev_watchdog().

This recursive lock acquisition results in a deadlock.

Fix this by removing the tx_global_lock acquisition from netdev_watchdog_up().

The critical state (watchdog_timer and watchdog_ref_held) is already
protected by dev->watchdog_lock, which was introduced in the blamed commit.

Fixes: 8eed5519e496 ("net: watchdog: fix refcount tracking races")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/netdev/a443376e-5187-4268-93b3-58047ef113a8@samsung.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 net/sched/sch_generic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 3f1c510df850dbdbaf10d483547c7b1f3a5d5482..ef2b4bf51564173751c74fefe17e3913ed2fa056 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -594,9 +594,8 @@ void netdev_watchdog_up(struct net_device *dev)
 		return;
 	if (dev->watchdog_timeo <= 0)
 		dev->watchdog_timeo = 5*HZ;
-	spin_lock_bh(&dev->tx_global_lock);
 
-	spin_lock(&dev->watchdog_lock);
+	spin_lock_bh(&dev->watchdog_lock);
 	if (!mod_timer(&dev->watchdog_timer,
 		       round_jiffies(jiffies + dev->watchdog_timeo))) {
 		if (!dev->watchdog_ref_held) {
@@ -605,9 +604,7 @@ void netdev_watchdog_up(struct net_device *dev)
 			dev->watchdog_ref_held = true;
 		}
 	}
-	spin_unlock(&dev->watchdog_lock);
-
-	spin_unlock_bh(&dev->tx_global_lock);
+	spin_unlock_bh(&dev->watchdog_lock);
 }
 EXPORT_SYMBOL_GPL(netdev_watchdog_up);
 
-- 
2.55.0.rc0.786.g65d90a0328-goog


