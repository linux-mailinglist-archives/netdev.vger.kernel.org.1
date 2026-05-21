Return-Path: <netdev+bounces-290570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCHCI3FCD2qcIQYAu9opvQ
	(envelope-from <netdev+bounces-290570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:35:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE3B5AA5AA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958843058750
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7453D7A05;
	Thu, 21 May 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qo5LlFV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AB3C81B7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383684; cv=none; b=ZFDgaSzIzX9GY5nusHNDVfwT5h9mO+DaU1CXLhzldhG4CaQ/4yTfmEETmqo+k/wip448PWaZfOW47lNOjz93OOVAejxmrg5cL/t0a0ymwo3X8OiA8vhuZnTr6bKRntSX1UTFA4Z4pdndXa8eVVtQdV7h7zHS89Mjd2KROhol7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383684; c=relaxed/simple;
	bh=+qMm+CZXngmYum+X3iU0oSu6ny3aQDO1+h1osDkyNfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UyGVTRuqJSJ0D3+pDieSzDw2Rs2U363E/3dn3zbbX7IRg0X4HM8cpRaVoPpTpdOD8PiU21s3tPotAsGzk8sgx5puzEFR3gPCf9ZuVlAp8y94WqeSEqodC+gcdFf+9M5JHoEj4OkbvztUAyGkV7FZHE7M002dMKZUNMyTRpKy7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qo5LlFV9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7bd66ec877aso116020707b3.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779383681; x=1779988481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=typKCKjAl8enyMc6mN/oPci91CLIiINIAt/JYd7ZEAQ=;
        b=qo5LlFV9/ChyioUR38GdhCkmkTWG4q/wCIQB6Y1T5yjIakE2ASF3EAbULiFrpwf/b2
         tnU5Ceyv+2m4bQVbPf7rSzZugqm+JN1RM2GYnEQqYCKJqIYmXJVnyB9DDyHfgdCXvw96
         d3edt427SW/Q8sXRXhJNJ/uM/McHe5me0NLpbWq8bys/vjzlnK8fO1qTOz90xRn0fwke
         PocLTFazF/7Co1MphqOuPGRinpHXZ8s//9QaGv7YvU39UO9XcE5KBE62c+DfJl5VS8UR
         9TewzwLEuDz4R6zPjSa/NHU/McVsQgsXXhm0O/Y802wpddTarGTEH4rpudk1vyEZFjMh
         FnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383681; x=1779988481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=typKCKjAl8enyMc6mN/oPci91CLIiINIAt/JYd7ZEAQ=;
        b=l/5ZFUnS66Z41Sy8/f1ujgSZQHsUyxU381wgmiq+tXUWGnEap991zHQTCKkjA961V9
         6pjAy5ILvjqwtafUw6fEEBU52sHaRSCrF1iL0HnfNeJ6YTVi3zCe1oZoAJiWJrQiamRf
         XPMOwOh6dGdg0Kuwm/mvydimnzNBpmrkIlZ0jjxkuWg+J+o7rIp9EzWYeVBmCd7+s3RL
         5dVx6BVgVI1Xsk7BcBL6Wd+478xtTffnl0jVLHBhVUGSwU7j+LOgxtSHXqRX4jdwbju8
         e9pDek+Vu1X4LMM1YLIzDWHKxItA0DqSNjyaXFEvzmNwlKMPcjQx8fRlbWdeHQGKhfPg
         90ag==
X-Forwarded-Encrypted: i=1; AFNElJ+63VVomSBq74c9qkTyEXCehEtK4pHQZnKj2PS2ov3lTB7KamXc47/zh3pluN+P4mnGJEMZiks=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWlFQ+QAc2KfcO5aotYD/bNcEppD5+IKr2iEMGFXBOE3RkXAS
	SRbPWzwJ0u5y1VEw85jK7cBC4Oi2QaqeIk1PWccXgN1LrJvNyLxFQWnnLwiT2+HgJJFaFN71b0+
	E9jVszXjwhhL4MA==
X-Received: from yweu3.prod.google.com ([2002:a05:690c:e763:b0:7c4:88d:4c27])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6b87:b0:7bd:6a98:58d3 with SMTP id 00721157ae682-7d213655610mr32268307b3.18.1779383681390;
 Thu, 21 May 2026 10:14:41 -0700 (PDT)
Date: Thu, 21 May 2026 17:14:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521171440.114956-1-edumazet@google.com>
Subject: [PATCH net-next] dpll: change dpll_netdev_pin_handle_size() to assume
 DPLL_A_PIN_ID will be used
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,linux.dev,intel.com,resnulli.us];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:email]
X-Rspamd-Queue-Id: 1AE3B5AA5AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We plan to no longer hold RTNL in "ip link show", and use RCU instead.

Assume rtnl_fill_dpll_pin() will have to fill DPLL_A_PIN_ID.

It is fine to over-estimate skb size (by 8 bytes) in if_nlmsg_size().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>
---
 drivers/dpll/dpll_netlink.c | 11 -----------
 include/linux/dpll.h        |  9 +++++++--
 net/core/rtnetlink.c        |  6 +++---
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 53ca24d0f191bc3268340543769fd96c836f9318..095ef8703c0b2687178a46c5312319376d518f79 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -89,17 +89,6 @@ static struct dpll_pin *dpll_netdev_pin(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->dpll_pin);
 }
 
-/**
- * dpll_netdev_pin_handle_size - get size of pin handle attribute of a netdev
- * @dev: netdev from which to get the pin
- *
- * Return: byte size of pin handle attribute, or 0 if @dev has no pin.
- */
-size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
-{
-	return dpll_netdev_pin(dev) ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
-}
-
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev)
 {
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 82dfadd9f593b780c11d1d05cd00b62a32d4f534..4071fd974dd714eca92cae70e40bcde5a87a4706 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -13,6 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/rtnetlink.h>
+#include <net/netlink.h>
 
 struct dpll_device;
 struct dpll_pin;
@@ -238,7 +239,11 @@ struct dpll_pin_notifier_info {
 void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
 void dpll_netdev_pin_clear(struct net_device *dev);
 
-size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
+static inline size_t dpll_netdev_pin_handle_size(void)
+{
+	return nla_total_size(4); /* DPLL_A_PIN_ID */
+}
+
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
 
@@ -249,7 +254,7 @@ static inline void
 dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
 static inline void dpll_netdev_pin_clear(struct net_device *dev) { }
 
-static inline size_t dpll_netdev_pin_handle_size(const struct net_device *dev)
+static inline size_t dpll_netdev_pin_handle_size(void)
 {
 	return 0;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6a5e9ace55a0880d7b1e4303d12dc0a8b8b7c5ed..d64600aa8adfe9ce7a0c45677ae36db73ee3d886 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1264,11 +1264,11 @@ static size_t rtnl_devlink_port_size(const struct net_device *dev)
 	return size;
 }
 
-static size_t rtnl_dpll_pin_size(const struct net_device *dev)
+static size_t rtnl_dpll_pin_size(void)
 {
 	size_t size = nla_total_size(0); /* nest IFLA_DPLL_PIN */
 
-	size += dpll_netdev_pin_handle_size(dev);
+	size += dpll_netdev_pin_handle_size();
 
 	return size;
 }
@@ -1349,7 +1349,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
-	       + rtnl_dpll_pin_size(dev)
+	       + rtnl_dpll_pin_size()
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
 	       + nla_total_size(2)  /* IFLA_HEADROOM */
 	       + nla_total_size(2)  /* IFLA_TAILROOM */
-- 
2.54.0.746.g67dd491aae-goog


