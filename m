Return-Path: <netdev+bounces-69464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D784B593
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCE28A0B1
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BDA12F381;
	Tue,  6 Feb 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sa0rskME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81812E1FB
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223914; cv=none; b=KlHB942j6Ua1x2r+B7CyGswkuVAzdHiJArcyoor5Rh/ez0N0XTZjvmddtImvqdgGB5jTqVvepgHvvWm5q7bMBYzE+F22NydFMXGeTDFegWYqiHNxP6K7Ki0+3SyHrprjcaMhh/EZiYua6GA+Se09KPUPTKJ9Frzqgcq1fLjgCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223914; c=relaxed/simple;
	bh=+zBtpt/Ad+Exm2q8njKeFrta0cT06Gw2DnOsPFb33IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxnXXgXJeO0Sd9CFy7IKg4B5UbKtZBSR4Z6uN6Ec0d0uOkhjka9quuZi54rWdfrWbbjAf/N6PCIk0i182BQBivFVdHxlMkQcXJ9JYE0hmmmB5dAbW7RIJhxeyfSTLviitNUJt0EKxrSIRFnvA+jhuTobPdmqe35KCnTRBnCwiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=sa0rskME; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51025cafb51so8251708e87.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707223909; x=1707828709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KKARUp87LF6c9UcQtyI6AFhE1UpTF4lkCFhJwlnTdM=;
        b=sa0rskMEUffsIa+kWpFee2nRzhO+lXwYkQwys6JEm7KkfsoP9QO11QDnkp9UjEGCWw
         jY7wUtwk6riFgfP0E3fx5d3ZRtDzcMg1jEfi5VSw79/16NIMfsm4nT7HZVhicbyvJUAu
         ey74maR0S49tmDkKPSzzIpMaLW3FEoCGwobSzHo7tet5U5gg2KaWV0QMcAi3Mu0PiPqo
         UKTrJwM0arMUa2gjIZnd7NfgaKjVKMgeqzyIjUwGmWLXZSNlgu6WkYoERmj6sO5RexOw
         5fo/NXinXYgYUy/TpK1QhjhvG7/ziD39M4NiPcuqQ2iYW758HRqw9PRj5M6ot8nBmThq
         IgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707223909; x=1707828709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KKARUp87LF6c9UcQtyI6AFhE1UpTF4lkCFhJwlnTdM=;
        b=Q7BjGfJCnuHZF8Zu+3Bj6nTe6gTyC8u6AKjh3ymirxD3LUcki2xPC7jIz2HwqXSRWU
         kqYVWCcaZczBi7bOtBUcZ0TCqU/UrLlQo/GnL6SAf0XMfhxKBPVikgYHiEHkeFFOZt0F
         JCglwyRDH/rr4Pf5JICqfOmmwN4BillVxF4orCDIba7TKR3/J0qr6g59iTq7WPXCRCF6
         9p/HALh0dxVDOtD+QIfMKSqpIGXtsQ2uU3gHxCmP8MtOKbnKNgDcJQ/2JsK8q9czft/F
         SlBgeHNiWB8H5zGlfnLqSD9rsybW6FVEKD9VYHjG+PsAoEPXvM8bZKLVs4uWMZAoMvt6
         ZSog==
X-Gm-Message-State: AOJu0YwtSjx2UDQqstj5CD13av8zwMkQvLrbMyGI3iXoHL/fyXgtlr/G
	nutH1VfrK4cNt1r1ddAlr0kI7N5VRTYTRkq8Ej8T+POdfKgOKGDqvAYsM4Qfq7AGM0wTJIzkXha
	ov20=
X-Google-Smtp-Source: AGHT+IHMPJPr/8nwBUrHQTa0uygSuf0u603eVCCKcaJHxkqjihIwX253Q5QfrRE0X/J5oIc3X5FImA==
X-Received: by 2002:a19:760c:0:b0:511:621a:5d5f with SMTP id c12-20020a19760c000000b00511621a5d5fmr82899lff.39.1707223909250;
        Tue, 06 Feb 2024 04:51:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWc1BQ/1UG4tDjCcd4fZfW2GkJsFdfxwWR3uDqLqtzZf67w0T2mTVjO1Om3ygPbr0YvqBTpAAtoxjpyQ6PHsb47iJpf/zdcdmv3cdYLkUO074TYEk3f3uAVtzQZaTIrApw=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a35a11fd795sm1102910ejb.129.2024.02.06.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:51:48 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: [patch net] dpll: fix possible deadlock during netlink dump operation
Date: Tue,  6 Feb 2024 13:51:45 +0100
Message-ID: <20240206125145.354557-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Recently, I've been hitting following deadlock warning during dpll pin
dump:

[52804.637962] ======================================================
[52804.638536] WARNING: possible circular locking dependency detected
[52804.639111] 6.8.0-rc2jiri+ #1 Not tainted
[52804.639529] ------------------------------------------------------
[52804.640104] python3/2984 is trying to acquire lock:
[52804.640581] ffff88810e642678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: netlink_dump+0xb3/0x780
[52804.641417]
               but task is already holding lock:
[52804.642010] ffffffff83bde4c8 (dpll_lock){+.+.}-{3:3}, at: dpll_lock_dumpit+0x13/0x20
[52804.642747]
               which lock already depends on the new lock.

[52804.643551]
               the existing dependency chain (in reverse order) is:
[52804.644259]
               -> #1 (dpll_lock){+.+.}-{3:3}:
[52804.644836]        lock_acquire+0x174/0x3e0
[52804.645271]        __mutex_lock+0x119/0x1150
[52804.645723]        dpll_lock_dumpit+0x13/0x20
[52804.646169]        genl_start+0x266/0x320
[52804.646578]        __netlink_dump_start+0x321/0x450
[52804.647056]        genl_family_rcv_msg_dumpit+0x155/0x1e0
[52804.647575]        genl_rcv_msg+0x1ed/0x3b0
[52804.648001]        netlink_rcv_skb+0xdc/0x210
[52804.648440]        genl_rcv+0x24/0x40
[52804.648831]        netlink_unicast+0x2f1/0x490
[52804.649290]        netlink_sendmsg+0x36d/0x660
[52804.649742]        __sock_sendmsg+0x73/0xc0
[52804.650165]        __sys_sendto+0x184/0x210
[52804.650597]        __x64_sys_sendto+0x72/0x80
[52804.651045]        do_syscall_64+0x6f/0x140
[52804.651474]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
[52804.652001]
               -> #0 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}:
[52804.652650]        check_prev_add+0x1ae/0x1280
[52804.653107]        __lock_acquire+0x1ed3/0x29a0
[52804.653559]        lock_acquire+0x174/0x3e0
[52804.653984]        __mutex_lock+0x119/0x1150
[52804.654423]        netlink_dump+0xb3/0x780
[52804.654845]        __netlink_dump_start+0x389/0x450
[52804.655321]        genl_family_rcv_msg_dumpit+0x155/0x1e0
[52804.655842]        genl_rcv_msg+0x1ed/0x3b0
[52804.656272]        netlink_rcv_skb+0xdc/0x210
[52804.656721]        genl_rcv+0x24/0x40
[52804.657119]        netlink_unicast+0x2f1/0x490
[52804.657570]        netlink_sendmsg+0x36d/0x660
[52804.658022]        __sock_sendmsg+0x73/0xc0
[52804.658450]        __sys_sendto+0x184/0x210
[52804.658877]        __x64_sys_sendto+0x72/0x80
[52804.659322]        do_syscall_64+0x6f/0x140
[52804.659752]        entry_SYSCALL_64_after_hwframe+0x46/0x4e
[52804.660281]
               other info that might help us debug this:

[52804.661077]  Possible unsafe locking scenario:

[52804.661671]        CPU0                    CPU1
[52804.662129]        ----                    ----
[52804.662577]   lock(dpll_lock);
[52804.662924]                                lock(nlk_cb_mutex-GENERIC);
[52804.663538]                                lock(dpll_lock);
[52804.664073]   lock(nlk_cb_mutex-GENERIC);
[52804.664490]

The issue as follows: __netlink_dump_start() calls control->start(cb)
with nlk->cb_mutex held. In control->start(cb) the dpll_lock is taken.
Then nlk->cb_mutex is released and taken again in netlink_dump(), while
dpll_lock still being held. That leads to ABBA deadlock when another
CPU races with the same operation.

Fix this by moving dpll_lock taking into dumpit() callback which ensures
correct lock taking order.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_netlink.c | 20 ++++++--------------
 drivers/dpll/dpll_nl.c      |  4 ----
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 314bb3775465..4ca9ad16cd95 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1199,6 +1199,7 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
+	mutex_lock(&dpll_lock);
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
 		if (!dpll_pin_available(pin))
@@ -1218,6 +1219,8 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
+	mutex_unlock(&dpll_lock);
+
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
 		return skb->len;
@@ -1373,6 +1376,7 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned long i;
 	int ret = 0;
 
+	mutex_lock(&dpll_lock);
 	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
 				 ctx->idx) {
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
@@ -1389,6 +1393,8 @@ int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 		genlmsg_end(skb, hdr);
 	}
+	mutex_unlock(&dpll_lock);
+
 	if (ret == -EMSGSIZE) {
 		ctx->idx = i;
 		return skb->len;
@@ -1439,20 +1445,6 @@ dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	mutex_unlock(&dpll_lock);
 }
 
-int dpll_lock_dumpit(struct netlink_callback *cb)
-{
-	mutex_lock(&dpll_lock);
-
-	return 0;
-}
-
-int dpll_unlock_dumpit(struct netlink_callback *cb)
-{
-	mutex_unlock(&dpll_lock);
-
-	return 0;
-}
-
 int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		      struct genl_info *info)
 {
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index eaee5be7aa64..1e95f5397cfc 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -95,9 +95,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 	},
 	{
 		.cmd	= DPLL_CMD_DEVICE_GET,
-		.start	= dpll_lock_dumpit,
 		.dumpit	= dpll_nl_device_get_dumpit,
-		.done	= dpll_unlock_dumpit,
 		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -129,9 +127,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 	},
 	{
 		.cmd		= DPLL_CMD_PIN_GET,
-		.start		= dpll_lock_dumpit,
 		.dumpit		= dpll_nl_pin_get_dumpit,
-		.done		= dpll_unlock_dumpit,
 		.policy		= dpll_pin_get_dump_nl_policy,
 		.maxattr	= DPLL_A_PIN_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
-- 
2.43.0


