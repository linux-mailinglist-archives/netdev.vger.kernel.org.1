Return-Path: <netdev+bounces-177206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8BA6E449
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9F6163003
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFED19539F;
	Mon, 24 Mar 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCbdCJr4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838917E0;
	Mon, 24 Mar 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847898; cv=none; b=f7xu4cYjOEtMsygTHaO0fWOoAiZd7nGOvYMm5sOJ1p+LJwS2YdHaEnvn4yRRQDUe/H+owVoRfBjSPCAQB1X4KhihtyPC1Uf84L5Kha2mg88Mnbf8N95Zx1Uumd1BnXbt8Jom/dnuEOnYVPxMtm5ZzwFCKxiyXqbCaVvYIz/Je3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847898; c=relaxed/simple;
	bh=J0JNRVB+bzg8pC2PcyfWVd1KKyUdH7Ve2gAkSWXVGsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQEbUyNvNfG3C6mhSFWiNkAufz+ixfOsNXXLuQn9b6egQ+Q5rshV8mH0Nhvm7jL4FKGI14aLnG7ivJvwixDhV/pvxo2R/eL9/5JlZOBy1EAQ9LpLgfriPFsHOuc3N/b/9/iscTCej3AzoH+1XkRoV5Ce+NvkvunCf1mFcv+sL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCbdCJr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFDBC4CEDD;
	Mon, 24 Mar 2025 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742847897;
	bh=J0JNRVB+bzg8pC2PcyfWVd1KKyUdH7Ve2gAkSWXVGsA=;
	h=From:Date:Subject:To:Cc:From;
	b=WCbdCJr4fqW+jM/ozULerjroGDXJztCB/tbc4lSApnBRbK3oCpGJVnpxo9Ie23PDk
	 03Pr4Xv8WJNVHcC2Yc891Lp9x7B5eUUz75Qnk+GRk/l2+reK9tIukwi3yyI3NfBOrY
	 6bDi0paNfwf78gaogIgxGJJpNdmCwTlagvVTGraOelhSq0nyehTSwyCnHEJYxbrIq4
	 OEHjdypOL+NsQ4MuE6rmIIH0H4FIvTLuuNfE7OcihkJVO7D8gXp9GnoFnQ69RcM2pJ
	 dEnDdP+Ku8J5QFS1BIAHdmOKOJJpeN1oy7udyhBoUKON8tC1EsYSc9j3Frr1lstoqc
	 3eRaCUS/Oi+Lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 24 Mar 2025 16:24:47 -0400
Subject: [PATCH] net: add a debugfs files for showing netns refcount
 tracking info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-netns-debugfs-v1-1-c75e9d5a6266@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI6/4WcC/x2MMQqAMAwAv1IyW9Cog35FHFpNa5YojYpQ/LvF6
 bjhLoNSYlIYTYZENyvvUqSpDCybk0iW1+KANfZ1i50VOkXtSv6KoTBg03p0flgISnMkCvz8v2l
 +3w/bkuEQXwAAAA==
X-Change-ID: 20250324-netns-debugfs-df213b2ab9ce
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4874; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=J0JNRVB+bzg8pC2PcyfWVd1KKyUdH7Ve2gAkSWXVGsA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn4b+TlX6OwW4QekaDsH43Bx8fG2Ea/OwNRaxWb
 Q+zAgEOEruJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ+G/kwAKCRAADmhBGVaC
 FTU/EADRzMszEE5rWLWpYxfbxLg136mneHvQzBfnRns0/RmMDx/bfPgarM63bMhsG+JJZTcGxdr
 2vBsGddHJH1qZCFg6sqM/FutywA0esQ3Zb2QQ4cUwkCVXpG64bwME9EkfcsahmHjuByldKGX0y/
 plhGkUU9Mn6kYzxvEtakYbslQYllliFZjUutHYJEeZZsZK0QPMU70Lp5zaMZU1mM/zHJXS4smnr
 6woDKpfuOgYQfTWsdIWD/GidM/T0TUf/ZWiRxG6qgz1U3W69EfJ9Ko30uaFOxRuKKV6QTAvkz8r
 9BpkWzH6MraJmfBxBQDiYu/a5rYnMr9Ri7qKGZlTS6nEWadiYT9DgJIobpdZ2LeYjutf4aPnvTe
 cHDifp8+/OhSKNk/90ICdfYHeiOVSXTPIuihZzP0ZmNJo1ZAS6VNcy3wCYFU9l0gxzZmvm1T4R/
 v5XpSY8VtcdJT1msJkJvvUkfBumeeYGJyQJDxSvZJiNI0Y7zZoA8lEMnylphM1Sg+Rjw338+a6E
 EFhZih95I9xdQJKkYtcSoQ0yJWk2J88XEI6J9iBmKcqHld+5/snKGz6sxSTRo+g+uVY4BR2hXea
 AUyQFQmWpM0cJfOenrWWTSvj36Unt5yjrYn3XnxEpV7Vsp+tZ2gI1Q8DVC/1mlFBo7F/p2OkWyq
 ETgaQdWPHbRoXbg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
its tracking info. Add a new net_ns directory in debugfs. Have a
directory in there for every net, with refcnt and notrefcnt files that
show the currently tracked active and passive references.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Recently, I had a need to track down some long-held netns references,
and discovered CONFIG_NET_NS_REFCNT_TRACKER. The main thing that seemed
to be missing from it though is a simple way to view the currently held
references on the netns. This adds files in debugfs for this.
---
 net/core/net_namespace.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..b7ce8c7621bdf6055fa4aaa5cbfce111ca86b047 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1512,3 +1512,154 @@ const struct proc_ns_operations netns_operations = {
 	.owner		= netns_owner,
 };
 #endif
+
+#ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+
+#include <linux/debugfs.h>
+
+static struct dentry *ns_debug_dir;
+static unsigned int ns_debug_net_id;
+
+struct ns_debug_net {
+	struct dentry *netdir;
+	struct dentry *refcnt;
+	struct dentry *notrefcnt;
+};
+
+#define MAX_NS_DEBUG_BUFSIZE	(32 * PAGE_SIZE)
+
+static int
+ns_debug_tracker_show(struct seq_file *f, void *v)
+{
+	struct ref_tracker_dir *tracker = f->private;
+	int len, bufsize = PAGE_SIZE;
+	char *buf;
+
+	for (;;) {
+		buf = kvmalloc(bufsize, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		len = ref_tracker_dir_snprint(tracker, buf, bufsize);
+		if (len < bufsize)
+			break;
+
+		kvfree(buf);
+		bufsize *= 2;
+		if (bufsize > MAX_NS_DEBUG_BUFSIZE)
+			return -ENOBUFS;
+	}
+	seq_write(f, buf, len);
+	kvfree(buf);
+	return 0;
+}
+
+static int
+ns_debug_ref_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct net *net = inode->i_private;
+
+	ret = single_open(filp, ns_debug_tracker_show, &net->refcnt_tracker);
+	if (!ret)
+		net_passive_inc(net);
+	return ret;
+}
+
+static int
+ns_debug_notref_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct net *net = inode->i_private;
+
+	ret = single_open(filp, ns_debug_tracker_show, &net->notrefcnt_tracker);
+	if (!ret)
+		net_passive_inc(net);
+	return ret;
+}
+
+static int
+ns_debug_ref_release(struct inode *inode, struct file *filp)
+{
+	struct net *net = inode->i_private;
+
+	net_passive_dec(net);
+	return single_release(inode, filp);
+}
+
+static const struct file_operations ns_debug_ref_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ns_debug_ref_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= ns_debug_ref_release,
+};
+
+static const struct file_operations ns_debug_notref_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ns_debug_notref_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= ns_debug_ref_release,
+};
+
+static int
+ns_debug_init_net(struct net *net)
+{
+	struct ns_debug_net *dnet = net_generic(net, ns_debug_net_id);
+	char name[11]; /* 10 decimal digits + NULL term */
+	int len;
+
+	len = snprintf(name, sizeof(name), "%u", net->ns.inum);
+	if (len >= sizeof(name))
+		return -EOVERFLOW;
+
+	dnet->netdir = debugfs_create_dir(name, ns_debug_dir);
+	if (IS_ERR(dnet->netdir))
+		return PTR_ERR(dnet->netdir);
+
+	dnet->refcnt = debugfs_create_file("refcnt", S_IFREG | 0400, dnet->netdir,
+					   net, &ns_debug_ref_fops);
+	if (IS_ERR(dnet->refcnt)) {
+		debugfs_remove(dnet->netdir);
+		return PTR_ERR(dnet->refcnt);
+	}
+
+	dnet->notrefcnt = debugfs_create_file("notrefcnt", S_IFREG | 0400, dnet->netdir,
+					      net, &ns_debug_notref_fops);
+	if (IS_ERR(dnet->notrefcnt)) {
+		debugfs_remove_recursive(dnet->netdir);
+		return PTR_ERR(dnet->notrefcnt);
+	}
+
+	return 0;
+}
+
+static void
+ns_debug_exit_net(struct net *net)
+{
+	struct ns_debug_net *dnet = net_generic(net, ns_debug_net_id);
+
+	debugfs_remove_recursive(dnet->netdir);
+}
+
+static struct pernet_operations ns_debug_net_ops = {
+	.init = ns_debug_init_net,
+	.exit = ns_debug_exit_net,
+	.id = &ns_debug_net_id,
+	.size = sizeof(struct ns_debug_net),
+};
+
+static int __init ns_debug_init(void)
+{
+	ns_debug_dir = debugfs_create_dir("net_ns", NULL);
+	if (IS_ERR(ns_debug_dir))
+		return PTR_ERR(ns_debug_dir);
+
+	register_pernet_subsys(&ns_debug_net_ops);
+	return 0;
+}
+late_initcall(ns_debug_init);
+#endif /* CONFIG_NET_NS_REFCNT_TRACKER */
+#endif /* CONFIG_DEBUG_FS */

---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250324-netns-debugfs-df213b2ab9ce

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


