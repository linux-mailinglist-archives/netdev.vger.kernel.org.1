Return-Path: <netdev+bounces-180245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621AA80CAA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541958A7226
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0A19AA63;
	Tue,  8 Apr 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy6Xkwnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBE194AEC;
	Tue,  8 Apr 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119415; cv=none; b=syjYbwZKf8gFFjbq8j+k04BiGRMoV/8R8Zaae4L0B1EMSjrAQ1WoNEGdT5DwA1r1LD2k7uNqjvrkya7v+4p0M58+/Nw0BhHXXrbytZLbfgFf3dUQiCQDmYUaKtqDoJOLZH80V7rEyYtWKGZmwDyguaPyWXp+YzXKui1jcG8zVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119415; c=relaxed/simple;
	bh=9FWqWDDMk9X5RfZvq4/RgURoBS/zCE/+xlI7ck/0dTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pu9EB9+e9aQx9h2Elt4y2GrBbXKpfIpfGyJuMPGhq4KYr3ImCj3RGbYcf3FQsIn/Db6hM6wYrQ0tSxWV6R2k7WOoAn336HLqCDVgDYC7QhfCLxG7M5TMTn5l/Z52K1TajZZlvo+57kCgonwjuvqdzsGy++SQDNzCkcG5o/LJdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy6Xkwnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51CFC4CEED;
	Tue,  8 Apr 2025 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119414;
	bh=9FWqWDDMk9X5RfZvq4/RgURoBS/zCE/+xlI7ck/0dTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oy6XkwnbF0S3k10GIE9d5bGi/sU1QnOf5X+l+wkW65zjq8N+AuqOgHEk1k/51j3P6
	 qtCHPZoN818vBnic9OPPz5/48LqkR62R8mtN4uBa/WXLlS+oADPB/ZkuAQro/UN++i
	 zScHND4VhVRjqxrDjhry+BY+eJcI1UTsrgY5F+m81rUDPK8h0w+u+F6lA4r4wKE1Jn
	 VZO+Cl4CzbEYqeXRr2iyIPB/5brdiKMiceUrAUIiCMtDpZmea0n+P6xeiI+KZ9Q7mf
	 UYougjCxdQ+F7c2x/B2EFD6YZrRlgVWWnVB3MQWNDVt3v6sdLT8IsMMaaK9ov/VoBw
	 5QA76z8N8cKlQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Apr 2025 09:36:38 -0400
Subject: [PATCH v2 2/2] net: add debugfs files for showing netns refcount
 tracking info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
In-Reply-To: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4519; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9FWqWDDMk9X5RfZvq4/RgURoBS/zCE/+xlI7ck/0dTk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9SZyg7Dj/a/HB8MgP0TlrFB5LCLoOomDN3DR6
 JVk99VzQbGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/UmcgAKCRAADmhBGVaC
 FdL+EACKdzEuea9Y/CWRS21SOBREThDU01A7JMW7fBRiLa7woWaBheVhFPAAD1wuo58LvfnLC04
 BTH71zfdaQyjU118A+jXdZ3vg1a2Bz5KDeBeYMSg4cUkCN0beRrZxVd0PU7ahdu6J0eBqrmEw9U
 cMG2I8KUdyoN2MRMWC7nfIBucFiej2dGYqa7P9fvFYEA6cxsMhSSDz0kPj2GEShPajpE6TR235x
 QZc3QWgnY0VQx1gKwpl8c2zFt+DlspANvwLwckcz/+/dSwdMifiQkCr2+Fe3C0Wg65gtpwEuNir
 8CSCXFq7/9kotq96bTSufQVoonkdwr4rHRBDmgQwzNZH36St2znhLOWxAHJNBl0OjBsrGU9RNmN
 vPFNHGg28N+LhnwjrWn3DbS4znvUJylLBhLAwCJoaL9ShIoHZfY5bWJ1UlE8Iiqs9LHs/7bcGHI
 KkpA7KTpGJ9k0C7KUCnNMi+w9FSQUGF4bTN2IoFtwCAlgcVjlBgCBJS/rrT+tco6WyGbKzUP9e2
 U+sovwn564nhp64zT6kOJFOBsdjC82EgRd1LRIFTceuk1dEuwKfQSYQQW7jLIqltuTissW/b1Hk
 PSOLAxmvEmAuobFfzU94Aklzx0WZjc42AuvT1nnkQu2RkGeS78oOQZqLaCnNcfHlAgVZnNa7lq2
 uNmZz+qnkUel3xg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
its tracking info. Add a new net_ns directory under the debugfs
ref_tracker directory. Create a directory in there for every netns, with
refcnt and notrefcnt files that show the currently tracked active and
passive references.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..7e9dc487f46d656ee4ae3d6d18d35bb2aba2b176 100644
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
+static struct dentry *ns_ref_tracker_dir;
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
+	dnet->netdir = debugfs_create_dir(name, ns_ref_tracker_dir);
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
+	ns_ref_tracker_dir = debugfs_create_dir("net_ns", ref_tracker_debug_dir);
+	if (IS_ERR(ns_ref_tracker_dir))
+		return PTR_ERR(ns_ref_tracker_dir);
+
+	register_pernet_subsys(&ns_debug_net_ops);
+	return 0;
+}
+late_initcall(ns_debug_init);
+#endif /* CONFIG_NET_NS_REFCNT_TRACKER */
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


