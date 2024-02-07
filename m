Return-Path: <netdev+bounces-69801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090684CA10
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145231C23EDE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFA58AAA;
	Wed,  7 Feb 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mywlBo92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAF59B57
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307148; cv=none; b=fCGqTVoBVywow39fNwh7FF7qsyjV5ar+PSeq7oM/GpUh5E9MrR0vjBnTAYljPUV4wPduy7dqBKbUiCQ2iiDERsz1XpKyxGAqs/tk5YVzefCXVHZfv01iRwUqe/p61p3kTeqTbqkcDzwvCe8jE3QrALWJ7Q1dKmP0gY/fR7LNeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307148; c=relaxed/simple;
	bh=esJJ365ckljhCIbb4FHdZy603b3Drl9v1vV1g6qhgcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7ZHCMMYlKFlppYOMKhXWjysN8XBzx0KeGBeuHYEMDGtcy8wyt6mymVPsgyDH/Iy5PGKEhStQOXRtRW8sos38SrKKern+xwopxJqySEQpAGL0k6Bv3mdpEntlZDf/pmBqp8Zmp7xHv4PoV4S1hGH35iOeBvj8mAHcKcge8o0jfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mywlBo92; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4101fc00832so713415e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707307144; x=1707911944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlbZUUttCgJYIxTJGUqyDS2dQ/NKR2yB0Sm9y5e5rH4=;
        b=mywlBo92DVSc81zw/cbzHj252wpTyf8Fu7R7fSVDmg5iYRxwOlwo0t0G7VJ1LWgARV
         ARX8U6ugaO2MCTsjetYHHpFpqzyoGByGNuplB14UaSmSrix7gJyNaIC4L5RBl4vvXQgv
         iTgroWyYQT9T/EWzrlxqWxRYSgcb0yY48aWXiThGfZ4ZtJ19IOlJ64XaYdrmey3IuO6v
         iFVB7svihvOWJx7B/5RaXfBu+6lY5CsqqPoffpY3lxjuinNs0xnPCyFHlMGLOLK1LJdU
         CxFV+dUbFifkD1fCBpkFSq1nUev0nwMsf4BEGLmoEzpynTsPB1ffz2jgK9h4KBBBibRX
         X9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307144; x=1707911944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlbZUUttCgJYIxTJGUqyDS2dQ/NKR2yB0Sm9y5e5rH4=;
        b=H+OSJdIIdhHx0ooYwKqOW0Yhyvb313lyhMncDKmD8X0xKfLhU5dJqnXzpEG8oVDNy3
         v6tEyBcK9/A4nBcZF1s9EI6KgZ9uyFNCdwNkjxNYvHVOt23U1lP+EdSYhfns3v57bOR3
         KMYfUaqktLMDUucS1LA0oJ+nUbYdheZvwpHWSZ86CjLcsZov1wpqkONXvSzEyeP55ILB
         utXCv1hsGJSTSDQEkHy9w9LkVG2LXEZp2Tk0g0lWzh3Hp+3/Yg55Nx1p57uA+ubYRTvR
         W9cVoaD8qhVPEkIt6fOzpN9zqpY47yZT6vE0HV14oIcd1QdqnLVUw5fnamTezVHfUiwt
         A+ZA==
X-Gm-Message-State: AOJu0Yx7+/YIy8QGzEx3qXSXzT5vTfF/R+ygfgk3foiaDZ29AnjxZH6y
	bAaHW5fNPMRBHmHXTZE6fuLuNZUKda7uwZ1WDRkHmGxvkLdrA1W07CRrUIJ56hoTW+lpX36Px2p
	tdb4=
X-Google-Smtp-Source: AGHT+IHd6tD/e8s4+d/SyHLTMqIfWUBNolw2QsoCIFMMjpK83gsVYxnJ23UfqOxh9YqgZCtvkFqPeQ==
X-Received: by 2002:a05:600c:3146:b0:40d:484e:935 with SMTP id h6-20020a05600c314600b0040d484e0935mr4288807wmo.12.1707307144168;
        Wed, 07 Feb 2024 03:59:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdG72alH5NiBZv98VEl3rKIBwtuqF5R+23ni4S5h1Hb/D25dDnkpuzTsoq3rbcXX0HPf8f3EwQdPjJMGCznAoMWHPgvs2jmHgHCJtj5S1InGdrJb9VEa/2Srko63Z4Z3RDJKKi3XOtOS0oV7QfHlSU3g==
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y7-20020a7bcd87000000b0040fd2f3dc0esm1789108wmj.45.2024.02.07.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:59:03 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	kuba@kernel.org
Subject: [patch net v2] dpll: fix possible deadlock during netlink dump operation
Date: Wed,  7 Feb 2024 12:59:02 +0100
Message-ID: <20240207115902.371649-1-jiri@resnulli.us>
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
v1->v2:
- fixed in dpll.yaml and regenerated c/h files
---
 Documentation/netlink/specs/dpll.yaml |  4 ----
 drivers/dpll/dpll_netlink.c           | 20 ++++++--------------
 drivers/dpll/dpll_nl.c                |  4 ----
 drivers/dpll/dpll_nl.h                |  2 --
 4 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index b14aed18065f..3dcc9ece272a 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -384,8 +384,6 @@ operations:
             - type
 
       dump:
-        pre: dpll-lock-dumpit
-        post: dpll-unlock-dumpit
         reply: *dev-attrs
 
     -
@@ -473,8 +471,6 @@ operations:
             - fractional-frequency-offset
 
       dump:
-        pre: dpll-lock-dumpit
-        post: dpll-unlock-dumpit
         request:
           attributes:
             - id
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
diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
index 92d4c9c4f788..f491262bee4f 100644
--- a/drivers/dpll/dpll_nl.h
+++ b/drivers/dpll/dpll_nl.h
@@ -30,8 +30,6 @@ dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 void
 dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		   struct genl_info *info);
-int dpll_lock_dumpit(struct netlink_callback *cb);
-int dpll_unlock_dumpit(struct netlink_callback *cb);
 
 int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info);
 int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info);
-- 
2.43.0


