Return-Path: <netdev+bounces-157564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283DA0ACD6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B0A1886886
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D30C8C5;
	Mon, 13 Jan 2025 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quTImTkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FA9479
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736728517; cv=none; b=IqDjfzSyyx837tmTipm8g7KzJjf+kv+3zjqtEM6NsGIgibZFnglN46MyUFVVJOWDO4l4Ujg0tPtFN/rXF8ACZlcrkR/F4zxhIz7siOVbXKxKtG91OC0QhG+t2JZNM3vqEkoq/hoIC3rHLzlfCISeU8EJlAhp8gvGm8Zt3qfF4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736728517; c=relaxed/simple;
	bh=ct8wtBPMqAkkfzV23BJ4OI5ziQ8rX2+wAEe7R7Etjw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXkSsYXBi8yIpcLoVf3GxrwsCtwwSYDoaDLq3okbZfheP1t5Iyme8jST+LDtbhxFs8L8sUzBPZFhHvYAZb2LA8vG8KNITgLhlcrCtHyufyhSljznS6tEAmn5Kvii1ADLvVDmAFh10uace6O6FktWT4NALyIE6LbM0uweptaJV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quTImTkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E903C4CEE5;
	Mon, 13 Jan 2025 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736728517;
	bh=ct8wtBPMqAkkfzV23BJ4OI5ziQ8rX2+wAEe7R7Etjw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quTImTkA0Uz0x8adg6An3psQ2CgWweIUUlMApPOg719TXwWdaOmLrvcRsscMFhOiG
	 Z1uzwZAlmQncZAiNzDfIdGzoIEf1uk9rp+CZaJFFmgNqq4kptvEO3nmuFxuz40JCXK
	 8m5k4+moyOj9m7cFusHYSBkVLTR2LIJ4jtPIQ0sancSRBruhfl9s92Ay2hVpCQD+pH
	 bVy62XKEqXHALuHA2rhC49d6l20tE/jFMjYyYGoPDTOBCajepWR3CxyZ2h1ZIHVtnE
	 GEmdPBFg0Q2QkB+1fGjokJ3+k6d2dk0RixKrJOejEOOFv5tylk2d+9bYMqcu/Ao15X
	 OEFGDCSjLdnyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] net: cleanup init_dummy_netdev_core()
Date: Sun, 12 Jan 2025 16:34:56 -0800
Message-ID: <20250113003456.3904110-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113003456.3904110-1-kuba@kernel.org>
References: <20250113003456.3904110-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_dummy_netdev_core() used to cater to net_devices which
did not come from alloc_netdev_mqs(). Since that's no longer
supported remove the init logic which duplicates alloc_netdev_mqs().

While at it rename back to init_dummy_netdev().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c9abc9fc770e..fda4e1039bf0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10736,26 +10736,20 @@ int register_netdevice(struct net_device *dev)
 EXPORT_SYMBOL(register_netdevice);
 
 /* Initialize the core of a dummy net device.
- * This is useful if you are calling this function after alloc_netdev(),
- * since it does not memset the net_device fields.
+ * The setup steps dummy netdevs need which normal netdevs get by going
+ * through register_netdevice().
  */
-static void init_dummy_netdev_core(struct net_device *dev)
+static void init_dummy_netdev(struct net_device *dev)
 {
 	/* make sure we BUG if trying to hit standard
 	 * register/unregister code path
 	 */
 	dev->reg_state = NETREG_DUMMY;
 
-	/* NAPI wants this */
-	INIT_LIST_HEAD(&dev->napi_list);
-
 	/* a dummy interface is started by default */
 	set_bit(__LINK_STATE_PRESENT, &dev->state);
 	set_bit(__LINK_STATE_START, &dev->state);
 
-	/* napi_busy_loop stats accounting wants this */
-	dev_net_set(dev, &init_net);
-
 	/* Note : We dont allocate pcpu_refcnt for dummy devices,
 	 * because users of this 'device' dont need to change
 	 * its refcount.
@@ -11440,7 +11434,7 @@ EXPORT_SYMBOL(free_netdev);
 struct net_device *alloc_netdev_dummy(int sizeof_priv)
 {
 	return alloc_netdev(sizeof_priv, "dummy#", NET_NAME_UNKNOWN,
-			    init_dummy_netdev_core);
+			    init_dummy_netdev);
 }
 EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 
-- 
2.47.1


