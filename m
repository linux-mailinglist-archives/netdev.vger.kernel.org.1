Return-Path: <netdev+bounces-157986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEEA0FFC6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AAE1886B3B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252B23A0F0;
	Tue, 14 Jan 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utr38S1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2523A0EC
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826698; cv=none; b=t2Z6T4YifVjE67gLztUbatJAqAQqIOr9aa3pjd1rgP/tnX4J1bGqvXgybJVTIUjazCXXax2bxtkHBJg3iNV9U02q79LlI7v29GrCgDeJtyS1DbckV8AuamL2AgGJ5qflkPcwRy7ApvYS/003MQ0Hn2JcMXO4zP9AuJTpzN/P0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826698; c=relaxed/simple;
	bh=9B6DbiO4ZSRe+NwJ9j1gzriRNizmstFv55TgpwU6CXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq2baniTANix0vxJl9xeGNWClM4qfsHNCDZv2EB3VRgqE2ezn+ZWF6+iq1miIznHQcfVSUpTayEpeW4t5YbdSK4pAT54ez1XrY2OlKfr+XrM6AsNsxCFV8gnnYj+delBU5IsaotFILzbbRCOTCZ3VV0jj9unsUWq+GSNtIg1O/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utr38S1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E903FC4CEE7;
	Tue, 14 Jan 2025 03:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826697;
	bh=9B6DbiO4ZSRe+NwJ9j1gzriRNizmstFv55TgpwU6CXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Utr38S1LY8tm1ApDni7odvNhE5aid9OKjZtgb5lQKNVjUE6MrsL28VABgw7qJI7fl
	 QEBTVQMfLtEQwwqK6TnbNhus/JaUhuXECSEtnQhYuGC8/kDyJ62q9RDii38/mBDRAs
	 51069vHMAin/Krp8XqzuBL3guUAiLegDt0iBQLsCLh4/+HSAHtBkOE+9mOgHIad1Ya
	 YmryQByNC7Of+YYfbhjYwT+3ypKXj+BjXNtnH9r5h1qtmfVyUEDd3xgHZgikb7us1n
	 MpTY/9Uy+TLeN3Zs2Qn2RjyHvsVQHA5k3XXAPD5zmoZqbB8SPpE73/822F8P8Qg2uv
	 UmdcVjK08HZXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/11] net: protect NAPI config fields with netdev_lock()
Date: Mon, 13 Jan 2025 19:51:16 -0800
Message-ID: <20250114035118.110297-11-kuba@kernel.org>
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

Protect the following members of netdev and napi by netdev_lock:
 - defer_hard_irqs,
 - gro_flush_timeout,
 - irq_suspend_timeout.

The first two are written via sysfs (which this patch switches
to new lock), and netdev genl which holds both netdev and rtnl locks.

irq_suspend_timeout is only written by netdev genl.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 7 ++++---
 net/core/net-sysfs.c      | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03eeeac7dbdf..e16c32be0681 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -384,11 +384,11 @@ struct napi_struct {
 	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id; /* protected by netdev_lock */
 	struct hrtimer		timer;
-	struct task_struct	*thread; /* protected by netdev_lock */
+	/* all fields past this point are write-protected by netdev_lock */
+	struct task_struct	*thread;
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
-	/* all fields past this point are write-protected by netdev_lock */
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
@@ -2452,7 +2452,8 @@ struct net_device {
 	 * Drivers are free to use it for other protection.
 	 *
 	 * Protects:
-	 *	@napi_list, @net_shaper_hierarchy, @reg_state, @threaded
+	 *	@gro_flush_timeout, @napi_defer_hard_irqs, @napi_list,
+	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 * Partially protects (readers hold either @lock or rtnl_lock,
 	 * writers must hold both for registered devices):
 	 *	@up
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 5602a3c12e9a..173688663464 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -450,7 +450,7 @@ static ssize_t gro_flush_timeout_store(struct device *dev,
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	return netdev_store(dev, attr, buf, len, change_gro_flush_timeout);
+	return netdev_lock_store(dev, attr, buf, len, change_gro_flush_timeout);
 }
 NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
@@ -470,7 +470,8 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	return netdev_store(dev, attr, buf, len, change_napi_defer_hard_irqs);
+	return netdev_lock_store(dev, attr, buf, len,
+				 change_napi_defer_hard_irqs);
 }
 NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_uint);
 
-- 
2.47.1


