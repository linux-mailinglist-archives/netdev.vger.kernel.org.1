Return-Path: <netdev+bounces-157985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48108A0FFC5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008F21640ED
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C34235BF7;
	Tue, 14 Jan 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJvpqpFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615A23A0E1
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826697; cv=none; b=aniwzJ+9nfbnIJPf+HfBoZQhtNgpXM4/cD1Lw+T8vrylmYQofYb8uqcChosdPAC/OZzCwM2DtE/nq1Zo48EUwcGmGz2PXlxnPniYxQBY23Qgdk6Q1OjMLsVwCwFv5A48ASd9wWMmUB5Pmlb4XT8lXEW3Riz7S5APCBGzz1kSsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826697; c=relaxed/simple;
	bh=T2hHdMnwlJjzPSQy/h1ZlyaDftN2OztTzYmg3F2yVRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOUc5Spsfl9L6WYpvsM6S9q1HKe3vo6SEmnoNooYx8CKhkN/DHeqLHa8Ct4r9YMph7SRnlsM6QF7o5FABeO2IgrdovwR3/QUgUt7lG3vNkC078/JTlT9E81Vm+HEpKxrqszmaId8EvAkCv+r1ani0hd+Q4xyLjKJIHSnnNYXtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJvpqpFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B0EC4CEDF;
	Tue, 14 Jan 2025 03:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826696;
	bh=T2hHdMnwlJjzPSQy/h1ZlyaDftN2OztTzYmg3F2yVRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJvpqpFySSU/JiFGR2TOETOaBiW5snOxagGZ0+OiWl+Ln+AhhiYFeetzr1LLHVKC9
	 04kLiqDKQHPYaHJ/L0UAFsKoSkN5+TVLuFEvKMLlLNDwosL/1DP7CWLARqn9ft9A8Y
	 Zq8HmyjPIBq8I9hgBUWroskOTP2EPFP4AgRqq+M4wkR3iU+3jYbUrJ/V+ThlbcISVr
	 jqjZs3gDq4J5huEg1DnPfXUZCjeCO/tnI6J+ZSVHttjiWdcIohlIU2ph6X5y3dyecp
	 IWSW+i+IyvZPuf+5I9jee53I55NL7JqMrX0i5qG4Tz+8kmN0g2MiTmHstRdEXspW31
	 FxtPalgLG+34Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] net: protect napi->irq with netdev_lock()
Date: Mon, 13 Jan 2025 19:51:15 -0800
Message-ID: <20250114035118.110297-10-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take netdev_lock() in netif_napi_set_irq(). All NAPI "control fields"
are now protected by that lock (most of the other ones are set during
napi add/del). The napi_hash_node is fully protected by the hash
spin lock, but close enough for the kdoc...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 10 +++++++++-
 net/core/dev.c            |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 75c30404657b..03eeeac7dbdf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -388,6 +388,7 @@ struct napi_struct {
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
+	/* all fields past this point are write-protected by netdev_lock */
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
@@ -2705,11 +2706,18 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 		netdev_assert_locked(dev);
 }
 
-static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+static inline void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
 }
 
+static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+{
+	netdev_lock(napi->dev);
+	netif_napi_set_irq_locked(napi, irq);
+	netdev_unlock(napi->dev);
+}
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 5872f0797cc3..df2a8b54a9f2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6956,7 +6956,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = false;
-	netif_napi_set_irq(napi, -1);
+	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
 
-- 
2.47.1


