Return-Path: <netdev+bounces-159225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0A1A14D83
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4417A1C09
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2381FC0EC;
	Fri, 17 Jan 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbT53H41"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D11FA8EB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109588; cv=none; b=GdqeV5Hpkiq8JLqAK7cnbTG4ibB1lqe5ofi3uxZW7xPl3Mo+TXbJvpXXdYY8jNpqKPOhuv8LkzFzaJSX7qRJqmPcFHj/lVqbzpDP87NqIfZWvAR94raHsu2d8guJ1MYGk8scgtDFwhrYom7ZmufAEljQguv0kdfNL/dor09szSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109588; c=relaxed/simple;
	bh=v7WuItA8SNlRsa6NKgoQwPnWt/msCgIITb9CpU1AxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njHo2fUdeO4YGbl19mdGHOs8CayUFoXNnayx/QARZOl5wCgvDRi+IGkVbDrDOABm35O/keQ92G1gq8z+r49Ou8U8ssw3Sf32D259lDoSjrNJsKJ5Afy6mebUUM4HWY/aKD61tcAeurkEPNiJTizSgf5eZHL1+CyoAVu16Bl/kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbT53H41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA4C4CEE2;
	Fri, 17 Jan 2025 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737109587;
	bh=v7WuItA8SNlRsa6NKgoQwPnWt/msCgIITb9CpU1AxEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbT53H41ddZhlPPgVsgsloivwG9VoMGeWZa2Iolz+Fm7DTRExiCmKE8394ZYJEBju
	 x0/GE1xlEHP+orfO//+vDdErKFG2ZMYHw7iEIq29CTHm1PdyKLF4GTEhsCQx8PlUqX
	 sDfl1tHxFoEzC8nE0t9R7ygdqqM9tz1V9jt7kJkt1Y8eVYD4TYdYvU2iRz47ypsWoy
	 zhzPu1/C4AizgxY2+9Cm42Ccl7FO+FQWP+dgLiuJI60L60D9qpKn5/c8Enqmd5vyP6
	 6qBuZ0Bi42a1lY/XsTnIghV1XQoyrcVHTDXobJS4IhaAJjtFMW7BNeKcK8ut0lY/sk
	 rY4eDHfQWAlUw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] net-sysfs: prevent uncleared queues from being re-added
Date: Fri, 17 Jan 2025 11:26:10 +0100
Message-ID: <20250117102612.132644-4-atenart@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117102612.132644-1-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the (upcoming) removal of the rtnl_trylock/restart_syscall logic
and because of how Tx/Rx queues are implemented (and their
requirements), it might happen that a queue is re-added before having
the chance to be cleared. In such rare case, do not complete the queue
addition operation.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/net-sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0b7ee260613d..fdfcc91c3412 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1210,6 +1210,20 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Rx queues are cleared in rx_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized))
+		return -EAGAIN;
+
 	/* Kobject_put later will trigger rx_queue_release call which
 	 * decreases dev refcount: Take that reference here
 	 */
@@ -1898,6 +1912,20 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Tx queues are cleared in netdev_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized))
+		return -EAGAIN;
+
 	/* Kobject_put later will trigger netdev_queue_release call
 	 * which decreases dev refcount: Take that reference here
 	 */
-- 
2.48.0


