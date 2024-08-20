Return-Path: <netdev+bounces-120325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8A958F5C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03E41F2312E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0C1C3798;
	Tue, 20 Aug 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtJZv+8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011F125D5
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724187082; cv=none; b=AsOi5DJm0W/CVGttSg/90wzghYmMWjefuhhHZ9/PuY2FUiQ/ZydpPKSBfV01X0sHA1hWEQimZpb+I3tYE6CuqRsGwvhybfweN+soZgRFd+2g+Ws4JjvQwshA8h7qiL+rsvncbBF8c6/ssrV/G461ZIKFZ7lNtUBAGk5FCTd0Gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724187082; c=relaxed/simple;
	bh=4DwSFhYi3/R04RA2JCl5MzJ2Vh7D4zUu1KRylp0htnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT3af5SUHbiWHmwK9YFnqrXfptO76fltz8oAVhfBpVDgf5pWa78BHkNgUl0kjWhegZ0jel9Na+E3AsmnYIHmalFoiZQPNWZzR0ciTqeN9FJiScamAuJEDKdXpnWiYVrQ14PjG/vKL5OaKfH+k8VtIgz9+9cGRLR1l6/+Oy/PqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtJZv+8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6022C4AF09;
	Tue, 20 Aug 2024 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724187082;
	bh=4DwSFhYi3/R04RA2JCl5MzJ2Vh7D4zUu1KRylp0htnw=;
	h=From:To:Cc:Subject:Date:From;
	b=FtJZv+8KvIFd840j31l18L6OeIMMndGnNR7yC7H1R/MEPj01O1+V8LmwqobfKpxPv
	 BzLkvTcfWjh1DNvcVtrz/6TueEAgbdam5LY7/58cELyQa/BSUcAObdY37h4WrZhQVV
	 jTjCjFN0kiosShF9d5pT7nAgTK4wTkSefay+yn8arUt3P5G7I2vLLoMnubPHZimHW2
	 R6ZR4A+Uj5dSODemTso2XSCKp89t4Nh+ZD7rM6SoqNOmaQUwBpk32pU+HbcZurk/eb
	 VEPahNJLneeTDUHPOSHtEpZ+RBJzGbgyKA4XJPC+zoc028o6Quladul6JtWSgrwH0r
	 ywJQ+p4/Aifeg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: repack struct netdev_queue
Date: Tue, 20 Aug 2024 13:51:19 -0700
Message-ID: <20240820205119.1321322-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the NAPI pointer to struct netdev_queue made it grow into another
cacheline, even though there was 44 bytes of padding available.

The struct was historically grouped as follows:

    /* read-mostly stuff (align) */
    /* ... random control path fields ... */
    /* write-mostly stuff (align) */
    /* ... 40 byte hole ... */
    /* struct dql (align) */

It seems that people want to add control path fields after
the read only fields. struct dql looks pretty innocent
but it forces its own alignment and nothing indicates that
there is a lot of empty space above it.

Move dql above the xmit_lock. This shifts the empty space
to the end of the struct rather than in the middle of it.
Move two example fields there to set an example.
Hopefully people will now add new fields at the end of
the struct. A lot of the read-only stuff is also control
path-only, but if we move it all we'll have another hole
in the middle.

Before:
	/* size: 384, cachelines: 6, members: 16 */
	/* sum members: 284, holes: 3, sum holes: 100 */

After:
        /* size: 320, cachelines: 5, members: 16 */
        /* sum members: 284, holes: 1, sum holes: 8 */

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
---
 include/linux/netdevice.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..614ec5d3d75b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -644,9 +644,6 @@ struct netdev_queue {
 	struct Qdisc __rcu	*qdisc_sleeping;
 #ifdef CONFIG_SYSFS
 	struct kobject		kobj;
-#endif
-#if defined(CONFIG_XPS) && defined(CONFIG_NUMA)
-	int			numa_node;
 #endif
 	unsigned long		tx_maxrate;
 	/*
@@ -660,13 +657,13 @@ struct netdev_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool    *pool;
 #endif
-	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
-	 */
-	struct napi_struct      *napi;
+
 /*
  * write-mostly part
  */
+#ifdef CONFIG_BQL
+	struct dql		dql;
+#endif
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
 	int			xmit_lock_owner;
 	/*
@@ -676,8 +673,16 @@ struct netdev_queue {
 
 	unsigned long		state;
 
-#ifdef CONFIG_BQL
-	struct dql		dql;
+/*
+ * slow- / control-path part
+ */
+	/* NAPI instance for the queue
+	 * Readers and writers must hold RTNL
+	 */
+	struct napi_struct	*napi;
+
+#if defined(CONFIG_XPS) && defined(CONFIG_NUMA)
+	int			numa_node;
 #endif
 } ____cacheline_aligned_in_smp;
 
-- 
2.46.0


