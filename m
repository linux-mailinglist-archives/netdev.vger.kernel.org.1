Return-Path: <netdev+bounces-304731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /wNzHbN/SWqy2QAAu9opvQ
	(envelope-from <netdev+bounces-304731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 23:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A9708852
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 23:48:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H09rEDa7;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304731-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 116AD3015A59
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80534B1A7;
	Sat,  4 Jul 2026 21:48:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842F2F28EA
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 21:48:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783201702; cv=none; b=bdc/umQbNOzgI7dUelETZxYmlTvkIE5285hbs1tumIS/z1a6pDZMx5cQ0vr7Z9rMh1HNgqFt3hDNlo8MOet9DLPbCYNaYazREXh8q+wtT+lsyaCyLwlqM8HL55pqooYuVbogKU/BFf/jf5jITAlLJkpN9/WIsVwT7NyJQ3ZN318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783201702; c=relaxed/simple;
	bh=z3R8AtQftcGwlO+0IEJHngliyLgsjvnUXbrOecFxsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jG79ZjM0TxVN3Tg6rUtVnflyasJdlvZGaqeq0nQjl+4mjs1GHK6tOe5JY46L36WAASy7Wb0aW+QvxNr+FrWwZuFXZ5oG5zSWEN/4N0BUcqekg7zFS3KnYIo2UbjbCOuip4izF/fFzCJzu08XaZDPaFqGSXWIUlZtm2JprwQB9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H09rEDa7; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-845e363246aso1852845b3a.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783201700; x=1783806500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBu8eLtgFyfxE/8WdHQMx0CxcKxhtWNKmO3kujqn2EI=;
        b=H09rEDa7gp8sOwQykueObeZ6ssJ4RVFZZXj3KTrtnQyR2tUrcI9PiX9U9hKtf37D5o
         KLDz2V10LefoucH4U77U+owPeilkuJgiSmiwumjv9lLa+YWmQ+TODPDxW1y2dG4FQseW
         g5f+HEeSd7WT0I7C4k8OjAlDKDimRXtkWlNgJtOhqlIdB62biGKzASg6fc54LT4Wa3Fw
         up3ifqcICcZSdBwkVamfhHWpfWvtKjxfWQkkE3BXXT2ZS7A1c9dqMcHF/HJVZyOaHZKP
         /t5fh9NWGZsJdNCllExB2/1F7+S84bbRyK9KFGCKcEpEuo9Mo3f4Csz7WUuo1/RCNonL
         pOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783201700; x=1783806500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBu8eLtgFyfxE/8WdHQMx0CxcKxhtWNKmO3kujqn2EI=;
        b=fNU3D8SqrSLh9Fw9vvG9HbBnA7z74rNHVlSZJuLwQaMkO5Ra4CJvjMskpSX8JIa7AR
         Ty4ZVs78r7QBRQp03voHEjTtf92mIoPTmnqUZ1UOkQXm+cshd+I8qHLh/g+mqA1R2wVK
         buYb5Cai8erotnDUrCpeB2De+QHK6cLqDNKeDQbUg79Gg/xZkBiIS3JjlGDzRkruJxXm
         1DIYooOQFi3fuYip1sF0LdfWBuS27IyMNHWGg26uK5Kh+eb0NBGWVleIzu2dPdWoeO2H
         R/b6rHZSJCcreC5CmDt7fWgcjWWsjgfZhJFSOd4wZqYHIz60xdSOO+bc+RCGy6wFCjNu
         UFkA==
X-Gm-Message-State: AOJu0YzoCbOx08Oiq2iBskrvydRuLBObBS32lgoWpTq4LRJji2NIy0kg
	TIbrIVvIJcHAmVyJCbPhsCNvCKC7sDxavr7teVa1YqLkp5PKejwKZiM3LWOUlfXZrLyupg==
X-Gm-Gg: AfdE7cncvXH3KFvrFz2EYW+EZki0ZKqBgMqzNOs0U4VmWQhYGelMjfWZTFf/yhbilpO
	5FSJgkjEpJq4jhrPX3OKr67GEihdp/rsRl/QeKZCVYRTzqrHvvbqid6hHAeiLHD3rF5uJn3hh8p
	h/Y8F0lwV1XrWXWXghzkKoSwvarj4BS9546mEbulFwQwu+JdsN1bcFBsst5T7f9xVK7klkgbWGF
	x8ywzgaShnwVLQjLZxANV8YJLto7oHnsaHCHm0HwGVaG9QZvMJ0KSNRSvKEDguZo45y8YznVGtp
	HfHq4stBsBxoCL1siPeZiqsPSgfrmqvpSDrUTt+wTaa/8ylFdPtpMcettDUB3ujIyp0wd7plNex
	6VVmzvahNpk3RTcdHMCSygOEJt/M91RbKNURnNpUqO6YqJ7K2mi+SnLWriEtjL28GWKuU1YVKSb
	NgYz7opZguq58=
X-Received: by 2002:a05:6a00:1805:b0:845:ce2c:2a2e with SMTP id d2e1a72fcca58-847f6dc1003mr4199953b3a.17.1783201699536;
        Sat, 04 Jul 2026 14:48:19 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bcf03bsm1570479b3a.26.2026.07.04.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 14:48:17 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
Date: Sun,  5 Jul 2026 05:48:08 +0800
Message-ID: <20260704214808.1566710-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304731-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fancer.lancer@gmail.com,m:linux-kernel@vger.kernel.org,m:coiaprant@gmail.com,m:stable@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E9A9708852

The driver calls `pm_runtime_set_active()` before runtime PM is enabled,
and before the clock is prepared and enabled.

This causes the clock to be unprepared/disabled later in the suspend
callback even though it was never prepared/enabled, resulting in warnings:

clk_csr already disabled
clk_csr already unprepared

Fix this by setting the initial runtime PM status to SUSPENDED instead
of ACTIVE.

The clock will be properly enabled when the device is first resumed
via runtime PM (e.g., during MDIO access).

Fixes: f6bb3e9d98c2 ("net: pcs: xpcs: Add Synopsys DW xPCS platform device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index f4b1b8246ce96..fb80773379df5 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -285,7 +285,7 @@ static int xpcs_plat_init_clk(struct dw_xpcs_plat *pxpcs)
 		return dev_err_probe(dev, PTR_ERR(pxpcs->cclk),
 				     "Failed to get CSR clock\n");
 
-	pm_runtime_set_active(dev);
+	pm_runtime_set_suspended(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret) {
 		dev_err(dev, "Failed to enable runtime-PM\n");
-- 
2.47.3


