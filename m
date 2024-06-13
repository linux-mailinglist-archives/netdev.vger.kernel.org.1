Return-Path: <netdev+bounces-103153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7690692D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27541F2339A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0611411C7;
	Thu, 13 Jun 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FurgGQtT"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BA13FD60
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271819; cv=none; b=XMcgrAlFsTJt7LI+wiZ2BPx1aWzZSdoLcmn6mGHwnN01JkcwbqcOLSlvhQX8+3v/Me6ofwsJeOGLbsbN9BZlS0PwygOy2ylMhXnPAEzn23fG59iODNORUWpNXu3S/OFRbOVzGcxshLljRNgW5USI5ZAkKRhlxTL8KjrGAqcGcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271819; c=relaxed/simple;
	bh=mhikGHLUanps8KNo11VIGN8n/bfRVRCI0VycJU2m2YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRZv85JoR6AMJ5PKeiX5D6MtfpfouLmRQknxb8T+r3kN9kIBCKjNtY//0sEgf+OFJnvUkKSwIounbvrNZ49BmKrQIyWwiJNh8TI0QZATxxdq27ty3j1qKrlxCLRyddQp1NJYshgS6TMtcgqoIUa1UK7zhxeZLAyHyFh/dWjJh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FurgGQtT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=6dco+
	QIN/SHCnAE2XyQhmpp7v6WDia5kKYuWnmuspIo=; b=FurgGQtT1akJHpNWu9HO6
	9KoHhiQaxap27G1P6RyIle0jtTtaDJnt4ZhgYLSvFgIsxzkgrjrwgBa/yoTpnzyZ
	iKeVHC4N6AJg+tykXguVZJn02J2n4Leh2ab7xBA70JcG13Ye+A//uX3sppi6gnYM
	TrcizGZnIThqNHXz15KLU8=
Received: from vm-dev.test.com (unknown [36.111.140.9])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wBnNyApv2pmg1QMIA--.14264S5;
	Thu, 13 Jun 2024 17:43:08 +0800 (CST)
From: wujianguo106@163.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	contact@proelbtn.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	wujianguo106@163.com,
	Jianguo Wu <wujianguo@chinatelecom.cn>
Subject: [PATCH net v3 2/4] netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
Date: Thu, 13 Jun 2024 17:42:47 +0800
Message-ID: <20240613094249.32658-3-wujianguo106@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613094249.32658-1-wujianguo106@163.com>
References: <20240613094249.32658-1-wujianguo106@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNyApv2pmg1QMIA--.14264S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFWfAr1rJF1rJFy7WrWxWFg_yoWxGrykpF
	n0k3y3Jr4UWF1Yy3y09r1IyFn8trWrKa4j9r90k34Sywn2gw1DGa1FkrW7Xa1DW3yDtFW3
	JF1UKw1UAws5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEpBT7UUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNwz8kGXAlr1GGAAAsH

From: Jianguo Wu <wujianguo@chinatelecom.cn>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Currently, the sysctl net.netfilter.nf_hooks_lwtunnel depends on the
nf_conntrack module, but the nf_conntrack module is not always loaded.
Therefore, accessing net.netfilter.nf_hooks_lwtunnel may have an error.

Move sysctl nf_hooks_lwtunnel into the netfilter core.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 include/net/netns/netfilter.h           |  3 ++
 net/netfilter/core.c                    | 13 ++++-
 net/netfilter/nf_conntrack_standalone.c | 15 ------
 net/netfilter/nf_hooks_lwtunnel.c       | 68 +++++++++++++++++++++++++
 net/netfilter/nf_internals.h            |  6 +++
 5 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index 02bbdc577f8e..a6a0bf4a247e 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -15,6 +15,9 @@ struct netns_nf {
 	const struct nf_logger __rcu *nf_loggers[NFPROTO_NUMPROTO];
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *nf_log_dir_header;
+#ifdef CONFIG_LWTUNNEL
+	struct ctl_table_header *nf_lwtnl_dir_header;
+#endif
 #endif
 	struct nf_hook_entries __rcu *hooks_ipv4[NF_INET_NUMHOOKS];
 	struct nf_hook_entries __rcu *hooks_ipv6[NF_INET_NUMHOOKS];
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 3126911f5042..b00fc285b334 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -815,12 +815,21 @@ int __init netfilter_init(void)
 	if (ret < 0)
 		goto err;
 
+#ifdef CONFIG_LWTUNNEL
+	ret = netfilter_lwtunnel_init();
+	if (ret < 0)
+		goto err_lwtunnel_pernet;
+#endif
 	ret = netfilter_log_init();
 	if (ret < 0)
-		goto err_pernet;
+		goto err_log_pernet;
 
 	return 0;
-err_pernet:
+err_log_pernet:
+#ifdef CONFIG_LWTUNNEL
+	netfilter_lwtunnel_fini();
+err_lwtunnel_pernet:
+#endif
 	unregister_pernet_subsys(&netfilter_net_ops);
 err:
 	return ret;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 74112e9c5dab..6c40bdf8b05a 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -22,9 +22,6 @@
 #include <net/netfilter/nf_conntrack_acct.h>
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <net/netfilter/nf_conntrack_timestamp.h>
-#ifdef CONFIG_LWTUNNEL
-#include <net/netfilter/nf_hooks_lwtunnel.h>
-#endif
 #include <linux/rculist_nulls.h>
 
 static bool enable_hooks __read_mostly;
@@ -612,9 +609,6 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM,
 #endif
-#ifdef CONFIG_LWTUNNEL
-	NF_SYSCTL_CT_LWTUNNEL,
-#endif
 
 	NF_SYSCTL_CT_LAST_SYSCTL,
 };
@@ -946,15 +940,6 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.proc_handler   = proc_dointvec_jiffies,
 	},
 #endif
-#ifdef CONFIG_LWTUNNEL
-	[NF_SYSCTL_CT_LWTUNNEL] = {
-		.procname	= "nf_hooks_lwtunnel",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
-	},
-#endif
 };
 
 static struct ctl_table nf_ct_netfilter_table[] = {
diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 00e89ffd78f6..6ef415f82659 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -3,6 +3,9 @@
 #include <linux/sysctl.h>
 #include <net/lwtunnel.h>
 #include <net/netfilter/nf_hooks_lwtunnel.h>
+#include <linux/netfilter.h>
+
+#include "nf_internals.h"
 
 static inline int nf_hooks_lwtunnel_get(void)
 {
@@ -50,4 +53,69 @@ int nf_hooks_lwtunnel_sysctl_handler(struct ctl_table *table, int write,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_sysctl_handler);
+
+static struct ctl_table nf_lwtunnel_sysctl_table[] = {
+	{
+		.procname	= "nf_hooks_lwtunnel",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
+	},
+	{},
+};
+
+static int __net_init nf_lwtunnel_net_init(struct net *net)
+{
+	struct ctl_table *table;
+	struct ctl_table_header *hdr;
+
+	table = nf_lwtunnel_sysctl_table;
+	if (!net_eq(net, &init_net)) {
+		table = kmemdup(nf_lwtunnel_sysctl_table,
+				sizeof(nf_lwtunnel_sysctl_table),
+				GFP_KERNEL);
+		if (!table)
+			goto err_alloc;
+	}
+
+	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
+				     ARRAY_SIZE(nf_lwtunnel_sysctl_table));
+	if (!hdr)
+		goto err_reg;
+
+	net->nf.nf_lwtnl_dir_header = hdr;
+	return 0;
+
+err_reg:
+	if (!net_eq(net, &init_net))
+		kfree(table);
+err_alloc:
+	return -ENOMEM;
+}
+
+static void __net_exit nf_lwtunnel_net_exit(struct net *net)
+{
+	const struct ctl_table *table;
+
+	table = net->nf.nf_lwtnl_dir_header->ctl_table_arg;
+	unregister_net_sysctl_table(net->nf.nf_lwtnl_dir_header);
+	if (!net_eq(net, &init_net))
+		kfree(table);
+}
+
+static struct pernet_operations nf_lwtunnel_net_ops = {
+	.init = nf_lwtunnel_net_init,
+	.exit = nf_lwtunnel_net_exit,
+};
+
+int __init netfilter_lwtunnel_init(void)
+{
+	return register_pernet_subsys(&nf_lwtunnel_net_ops);
+}
+
+void netfilter_lwtunnel_fini(void)
+{
+	unregister_pernet_subsys(&nf_lwtunnel_net_ops);
+}
 #endif /* CONFIG_SYSCTL */
diff --git a/net/netfilter/nf_internals.h b/net/netfilter/nf_internals.h
index 832ae64179f0..25403023060b 100644
--- a/net/netfilter/nf_internals.h
+++ b/net/netfilter/nf_internals.h
@@ -29,6 +29,12 @@ void nf_queue_nf_hook_drop(struct net *net);
 /* nf_log.c */
 int __init netfilter_log_init(void);
 
+#ifdef CONFIG_LWTUNNEL
+/* nf_hooks_lwtunnel.c */
+int __init netfilter_lwtunnel_init(void);
+void netfilter_lwtunnel_fini(void);
+#endif
+
 /* core.c */
 void nf_hook_entries_delete_raw(struct nf_hook_entries __rcu **pp,
 				const struct nf_hook_ops *reg);
-- 
2.25.1


