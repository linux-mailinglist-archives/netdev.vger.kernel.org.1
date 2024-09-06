Return-Path: <netdev+bounces-126008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE8B96F90A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA6B1F21198
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F41D4141;
	Fri,  6 Sep 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwHjk5AW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71B1C9ECF
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639062; cv=none; b=cIXpNkSRLLg1z9unoiz901+NiKXIVSKdNBddxEP4hcYWZ4e+LFujRB6pct6Vm7lAxDli5BX+Wk4fQAAjf3pyw+qDoMMxJ0jzZ/uW3rAt4rAicyW6efU4/rCGQjYVBJnmcCKMgjlYBZCMifEp+i3GRuvLrqpFQNj8UwIiGM6WVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639062; c=relaxed/simple;
	bh=CR/SBw9aecDILVzqbVSPWjGJPndygKuxP+dNdLhKfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acPgM/kCGVspD+mzf6bM/sUNZOTMesWTab/7/toUBLsLKXH9Gczuisc+j0Qquwytu7gY2KeSMXYMBy4xRHuyqFj6eXahDaOFZL8l2A57rNDAWdlB1utROOEoOMk38qsHTOhlJ8cOsZDAfe2nB4yZDJrfvvZ3/ML5teX1+2fPIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwHjk5AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C2C4CEC6;
	Fri,  6 Sep 2024 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725639062;
	bh=CR/SBw9aecDILVzqbVSPWjGJPndygKuxP+dNdLhKfTk=;
	h=From:To:Cc:Subject:Date:From;
	b=QwHjk5AWjBJ334KTMzLpZaLEGR5un5RbDJgIEhxomq20IWemZTYgZ5KlE+3q7aX06
	 sj4Zb5PFzleUP06hsK5IxyVatkjuoZujTv58gle0Ovi2fyujt0eI9OrWCF6HtRBIPF
	 JAsQXNDfh09OeNDRTa1h3QSDQ6n4SY+2/5d4eLhhmrKRP8uKRvGOa+1HYJGYkRik3D
	 T02EE8MZhmAugQFS6GS5GUs85CKF4ERe22p4g3R012t3WMdbRNK3EmPrsS6QkU+quS
	 cdPCK0NyOT4Rk6ipvsUWDRjVjZawIuGdRMWbchqpz/4lECXwhktbdLK+Lbnm5d08Ey
	 st+YnJ2ZGFtOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: remove dev_pick_tx_cpu_id()
Date: Fri,  6 Sep 2024 09:10:59 -0700
Message-ID: <20240906161059.715546-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_pick_tx_cpu_id() has been introduced with two users by
commit a4ea8a3dacc3 ("net: Add generic ndo_select_queue functions").
The use in AF_PACKET has been removed in 2019 by
commit b71b5837f871 ("packet: rework packet_pick_tx_queue() to use common code selection")
The other user was a Netlogic XLP driver, removed in 2021 by
commit 47ac6f567c28 ("staging: Remove Netlogic XLP network driver").

It's relatively unlikely that any modern driver will need an
.ndo_select_queue implementation which picks purely based on CPU ID
and skips XPS, delete dev_pick_tx_cpu_id()

Found by code inspection.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 2 --
 net/core/dev.c            | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9168449a51bd..ff184959770b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3106,8 +3106,6 @@ void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
-u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
-		       struct net_device *sb_dev);
 
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
diff --git a/net/core/dev.c b/net/core/dev.c
index 33629a9d0661..f85fcfb48457 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4249,13 +4249,6 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(dev_pick_tx_zero);
 
-u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
-		       struct net_device *sb_dev)
-{
-	return (u16)raw_smp_processor_id() % dev->real_num_tx_queues;
-}
-EXPORT_SYMBOL(dev_pick_tx_cpu_id);
-
 u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev)
 {
-- 
2.46.0


