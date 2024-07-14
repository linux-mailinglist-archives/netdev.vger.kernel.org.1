Return-Path: <netdev+bounces-111380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D0930B8C
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603CE1C21670
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFD13E88B;
	Sun, 14 Jul 2024 20:23:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268624D5A2
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988630; cv=none; b=jlgmwn2RNpmLiVNkcN4rzzRpzwwgfnSjz24VPLyreF224f/JGdmAkWz2QDB55hjll0GxxPPBi1WTDc0mVN7ppm07oLO3hu7die+dOBnNoj7UPmVTXWgmixE5DEKXAOoDrIWMoY15BDSABLP6p8qtqnh3/Ebu9lYQxM6h/5R6opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988630; c=relaxed/simple;
	bh=oh4/VpuxanDdCr19USc9xTnigJGfEEY7jgWgORmgQog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjEspDNBa27yrkp+6crm678aWtXAhdx3cYxejvdkEOKKgXGhfxDrdMCr2p3zxZnQNVzH/M6jQJpfnKt0nL4pZbElmflW0xu3xWjKQeLbOvwPJoku7Ji8zefvGocLaYn6cpKHC8VB92f6dH1FoRXP0S5IEJSO+5RldtqhWixbv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 554317D12B;
	Sun, 14 Jul 2024 20:23:48 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v5 04/17] xfrm: sysctl: allow configuration of global default values
Date: Sun, 14 Jul 2024 16:22:32 -0400
Message-ID: <20240714202246.1573817-5-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714202246.1573817-1-chopps@chopps.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add sysctls for the changing the IPTFS default SA values.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 Documentation/networking/xfrm_sysctl.rst | 30 ++++++++++
 include/net/netns/xfrm.h                 |  6 ++
 net/xfrm/xfrm_sysctl.c                   | 70 ++++++++++++++++--------
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
index 47b9bbdd0179..4d900c74b405 100644
--- a/Documentation/networking/xfrm_sysctl.rst
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -9,3 +9,33 @@ XFRM Syscall
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
+
+xfrm_iptfs_max_qsize - UNSIGNED INTEGER
+        The default IPTFS max output queue size in octets. The output queue is
+        where received packets destined for output over an IPTFS tunnel are
+        stored prior to being output in aggregated/fragmented form over the
+        IPTFS tunnel.
+
+        Default 1M.
+
+xfrm_iptfs_drop_time - UNSIGNED INTEGER
+        The default IPTFS drop time in microseconds. The drop time is the amount
+        of time before a missing out-of-order IPTFS tunnel packet is considered
+        lost. See also the reorder window.
+
+        Default 1s (1000000).
+
+xfrm_iptfs_init_delay - UNSIGNED INTEGER
+        The default IPTFS initial output delay in microseconds. The initial
+        output delay is the amount of time prior to servicing the output queue
+        after queueing the first packet on said queue. This applies anytime
+        the output queue was previously empty.
+
+        Default 0.
+
+xfrm_iptfs_reorder_window - UNSIGNED INTEGER
+        The default IPTFS reorder window size. The reorder window size dictates
+        the maximum number of IPTFS tunnel packets in a sequence that may arrive
+        out of order.
+
+        Default 3.
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index d489d9250bff..73fce57ab14e 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -66,6 +66,12 @@ struct netns_xfrm {
 	u32			sysctl_aevent_rseqth;
 	int			sysctl_larval_drop;
 	u32			sysctl_acq_expires;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	u32			sysctl_iptfs_drop_time;
+	u32			sysctl_iptfs_init_delay;
+	u32			sysctl_iptfs_max_qsize;
+	u32			sysctl_iptfs_reorder_window;
+#endif
 
 	u8			policy_default[XFRM_POLICY_MAX];
 
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index ca003e8a0376..b70bb91d6984 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -10,34 +10,50 @@ static void __net_init __xfrm_sysctl_init(struct net *net)
 	net->xfrm.sysctl_aevent_rseqth = XFRM_AE_SEQT_SIZE;
 	net->xfrm.sysctl_larval_drop = 1;
 	net->xfrm.sysctl_acq_expires = 30;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	net->xfrm.sysctl_iptfs_max_qsize = 1024 * 1024; /* 1M */
+	net->xfrm.sysctl_iptfs_drop_time = 1000000; /* 1s */
+	net->xfrm.sysctl_iptfs_init_delay = 0; /* no initial delay */
+	net->xfrm.sysctl_iptfs_reorder_window = 3; /* tcp folks suggested */
+#endif
 }
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table xfrm_table[] = {
-	{
-		.procname	= "xfrm_aevent_etime",
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec
-	},
-	{
-		.procname	= "xfrm_aevent_rseqth",
-		.maxlen		= sizeof(u32),
-		.mode		= 0644,
-		.proc_handler	= proc_douintvec
-	},
-	{
-		.procname	= "xfrm_larval_drop",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-	{
-		.procname	= "xfrm_acq_expires",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
+	{ .procname = "xfrm_aevent_etime",
+	  .maxlen = sizeof(u32),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+	{ .procname = "xfrm_aevent_rseqth",
+	  .maxlen = sizeof(u32),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+	{ .procname = "xfrm_larval_drop",
+	  .maxlen = sizeof(int),
+	  .mode = 0644,
+	  .proc_handler = proc_dointvec },
+	{ .procname = "xfrm_acq_expires",
+	  .maxlen = sizeof(int),
+	  .mode = 0644,
+	  .proc_handler = proc_dointvec },
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	{ .procname = "xfrm_iptfs_drop_time",
+	  .maxlen = sizeof(uint),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+	{ .procname = "xfrm_iptfs_init_delay",
+	  .maxlen = sizeof(uint),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+	{ .procname = "xfrm_iptfs_max_qsize",
+	  .maxlen = sizeof(uint),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+	{ .procname = "xfrm_iptfs_reorder_window",
+	  .maxlen = sizeof(uint),
+	  .mode = 0644,
+	  .proc_handler = proc_douintvec },
+#endif
 };
 
 int __net_init xfrm_sysctl_init(struct net *net)
@@ -54,6 +70,12 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	table[1].data = &net->xfrm.sysctl_aevent_rseqth;
 	table[2].data = &net->xfrm.sysctl_larval_drop;
 	table[3].data = &net->xfrm.sysctl_acq_expires;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	table[4].data = &net->xfrm.sysctl_iptfs_drop_time;
+	table[5].data = &net->xfrm.sysctl_iptfs_init_delay;
+	table[6].data = &net->xfrm.sysctl_iptfs_max_qsize;
+	table[7].data = &net->xfrm.sysctl_iptfs_reorder_window;
+#endif
 
 	/* Don't export sysctls to unprivileged users */
 	if (net->user_ns != &init_user_ns)
-- 
2.45.2


