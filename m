Return-Path: <netdev+bounces-47092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362F7E7BEC
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E2528109E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54118E15;
	Fri, 10 Nov 2023 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A510179AB
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:45:14 +0000 (UTC)
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C1CF311AB
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:45:12 -0800 (PST)
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 60E667D133;
	Fri, 10 Nov 2023 11:38:38 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: [RFC ipsec-next 4/8] iptfs: sysctl: allow configuration of global default values
Date: Fri, 10 Nov 2023 06:37:15 -0500
Message-ID: <20231110113719.3055788-5-chopps@chopps.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110113719.3055788-1-chopps@chopps.org>
References: <20231110113719.3055788-1-chopps@chopps.org>
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
 Documentation/networking/xfrm_sysctl.rst | 29 ++++++++++++++++++
 include/net/netns/xfrm.h                 |  6 ++++
 include/net/xfrm.h                       |  7 +++++
 net/xfrm/xfrm_sysctl.c                   | 38 ++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
index 47b9bbdd0179..365220e4a072 100644
--- a/Documentation/networking/xfrm_sysctl.rst
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -9,3 +9,32 @@ XFRM Syscall
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
+
+xfrm_iptfs_maxqsize - UNSIGNED INTEGER
+        The default IPTFS max output queue size. The output queue is where
+        received packets destined for output over an IPTFS tunnel are stored
+        prior to being output in aggregated/fragmented form over the IPTFS
+        tunnel.
+
+        Default 1M.
+
+xfrm_iptfs_drptime - UNSIGNED INTEGER
+        The default IPTFS drop time. The drop time is the amount of time before
+        a missing out-of-order IPTFS tunnel packet is considered lost. See also
+        the reorder window.
+
+        Default 1s (1000000).
+
+xfrm_iptfs_idelay - UNSIGNED INTEGER
+        The default IPTFS initial output delay. The initial output delay is the
+        amount of time prior to servicing the output queue after queueing the
+        first packet on said queue.
+
+        Default 0.
+
+xfrm_iptfs_rewin - UNSIGNED INTEGER
+        The default IPTFS reorder window size. The reorder window size dictates
+        the maximum number of IPTFS tunnel packets in a sequence that may arrive
+        out of order.
+
+        Default 3.
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index bd7c3be4af5d..d5ad2155d0bb 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -65,6 +65,12 @@ struct netns_xfrm {
 	u32			sysctl_aevent_rseqth;
 	int			sysctl_larval_drop;
 	u32			sysctl_acq_expires;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	u32			sysctl_iptfs_drptime;
+	u32			sysctl_iptfs_idelay;
+	u32			sysctl_iptfs_maxqsize;
+	u32			sysctl_iptfs_rewin;
+#endif
 
 	u8			policy_default[XFRM_POLICY_MAX];
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index c9bb0f892f55..d2e87344d175 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2190,4 +2190,11 @@ static inline int register_xfrm_interface_bpf(void)
 
 #endif
 
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+#define XFRM_IPTFS_DEFAULT_MAX_QUEUE_SIZE (1024 * 1024)
+#define XFRM_IPTFS_DEFAULT_INIT_DELAY_USECS (0)
+#define XFRM_IPTFS_DEFAULT_DROP_TIME_USECS (1000000)
+#define XFRM_IPTFS_DEFAULT_REORDER_WINDOW (3)
+#endif
+
 #endif	/* _NET_XFRM_H */
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 7fdeafc838a7..bf8e73a6c38e 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -10,6 +10,12 @@ static void __net_init __xfrm_sysctl_init(struct net *net)
 	net->xfrm.sysctl_aevent_rseqth = XFRM_AE_SEQT_SIZE;
 	net->xfrm.sysctl_larval_drop = 1;
 	net->xfrm.sysctl_acq_expires = 30;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	net->xfrm.sysctl_iptfs_maxqsize = XFRM_IPTFS_DEFAULT_MAX_QUEUE_SIZE;
+	net->xfrm.sysctl_iptfs_drptime = XFRM_IPTFS_DEFAULT_DROP_TIME_USECS;
+	net->xfrm.sysctl_iptfs_idelay = XFRM_IPTFS_DEFAULT_INIT_DELAY_USECS;
+	net->xfrm.sysctl_iptfs_rewin = XFRM_IPTFS_DEFAULT_REORDER_WINDOW;
+#endif
 }
 
 #ifdef CONFIG_SYSCTL
@@ -38,6 +44,32 @@ static struct ctl_table xfrm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	{
+		.procname	= "xfrm_iptfs_drptime",
+		.maxlen		= sizeof(uint),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec
+	},
+	{
+		.procname	= "xfrm_iptfs_idelay",
+		.maxlen		= sizeof(uint),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec
+	},
+	{
+		.procname	= "xfrm_iptfs_maxqsize",
+		.maxlen		= sizeof(uint),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec
+	},
+	{
+		.procname	= "xfrm_iptfs_rewin",
+		.maxlen		= sizeof(uint),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec
+	},
+#endif
 	{}
 };
 
@@ -55,6 +87,12 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	table[1].data = &net->xfrm.sysctl_aevent_rseqth;
 	table[2].data = &net->xfrm.sysctl_larval_drop;
 	table[3].data = &net->xfrm.sysctl_acq_expires;
+#if IS_ENABLED(CONFIG_XFRM_IPTFS)
+	table[4].data = &net->xfrm.sysctl_iptfs_drptime;
+	table[5].data = &net->xfrm.sysctl_iptfs_idelay;
+	table[6].data = &net->xfrm.sysctl_iptfs_maxqsize;
+	table[7].data = &net->xfrm.sysctl_iptfs_rewin;
+#endif
 
 	/* Don't export sysctls to unprivileged users */
 	if (net->user_ns != &init_user_ns) {
-- 
2.42.0


