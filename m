Return-Path: <netdev+bounces-300138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cuh8ALqDMmo41QUAu9opvQ
	(envelope-from <netdev+bounces-300138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:23:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 967D3699050
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:23:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jDZSgon4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300138-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300138-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F97E3028B5C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680D3B7750;
	Wed, 17 Jun 2026 11:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E330F7FF;
	Wed, 17 Jun 2026 11:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695132; cv=none; b=G5ksp/tY5Lc+bHmHu6u6cg5M3Hg/yPkE7oEnPa2AiZvf39/Mn0yyT48DkmJjWP6d9iEI2TVmbC5tksRlTUb8o7FmmNAlSwR04kqik0oobWo5734TyB/902PW7NwtSaQ5mps6AJyPiWYSBgK6tJgTcxb2tjxFc/3ah936pFXpDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695132; c=relaxed/simple;
	bh=nhtvb7n4nG7NtB98JV2iAuqTyzjMv1dlncYJFgBnYWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDkjtmikVnsVbQu8xWJFfeqaCakYgWd6N5F9+5/nsvA2VPAdHgDYZDJBFnliAa/x2uenvYjEhVPqqmLjINvz9fAoAnyafD7xWQDljsL2QvDfQyt4t32v+w/6n3yErtFNbV+tj2mTVmRt3UqKmx5BW4bH+WKTO+bt+rartukLfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDZSgon4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EB81F00A3A;
	Wed, 17 Jun 2026 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695129;
	bh=IOYHzpnmvPvW25xDPV/zweS3p1AZM7TIzPB0ltBBd6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jDZSgon4X/o1keAlZPXBdIhe7dvyzQhORt4PAu6yr//YLnKfECRtcKSN3bmmIjBJo
	 l+opHyiqCZJNkSznwM5Bm6wSKhXMKe6lu+90ceVvsjNRj0r0/pNIJybpTkggp3v8LG
	 oq4CY+zTsqgpvZKuMIVkLKnOANL0q2UmTTS/BX3YhzJtohkTbX/EXFGj+RpJywbqzP
	 n8VmbZ96XJ+PVeEW2nAadgJXcNxrvH9DWBuRSDFKT70DHfiBZlXYNX9ETLwu7VqTV1
	 AyOhzooMiLBq0IzL8HUlN9geoAZS92rI5/B/Xxjme9rGtyOF673cJp33WW4T1Teen4
	 YQJ2+SSCSJ9dw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Jun 2026 13:18:27 +0200
Subject: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nhtvb7n4nG7NtB98JV2iAuqTyzjMv1dlncYJFgBnYWM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZNfVvaMhY8PSAtVrTjvKFzA+dSuQ3sHw3lDNUNMtii
 7UtuNfZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBF3D0aGFXNzGVq9Vp7J0ru5
 v/8IU3P8XUFVt6L5uWfMe7Yu/b36KSPD68o56x5/ujvpKtNqwQz+8irDlRVnv3I1cdcfqA6e83s
 tOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300138-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,google.com,vger.kernel.org,linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 967D3699050

In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
we added support for extended attributes for sockets. This comes in two
flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
are actual filesystem objects so reading xattrs must use dedicated fs
helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
are inherently sleeping operations. Sockfs sockets on the other hand
don't need to use sleeping operations as the underlying data structure
is lockless. In addition, retrieval of sockfs extended attributes often
happens from LSM hooks that only provide struct socket and it's
completely nonsensical to grab a reference to a file, then force a
sleeping operation to retrieve the xattr and drop the reference. We know
that the sockfs file cannot go away while the LSM hook runs.

This series adds a bpf_sock_read_xattr() kfunc that, given a struct
socket, reads a user.* extended attribute from the socket's sockfs inode
into a bpf_dynptr. Together with fsetxattr() from userspace this lets a
process label a socket with a user.* xattr and have a BPF LSM program
retrieve that label locklessly. The kfunc mirrors the existing
bpf_cgroup_read_xattr(), including the restriction to the user.*
namespace.

systemd uses user.* xattrs on sockets to implement socket rate limiting
and to tag sockets for other purposes [1] such as implementing a varlink
registry. There is currently no efficient way for a BPF program to read
those labels back. The new helper allows a listening socket marked with
an extended attribute to be read back during bind/connect and then act
on the connect()ing socket. Extended attributes make it possible to
allow an unprivileged user manager such as systemd --user to mark
sockets from userspace and then rediscover them or implement policies.

The kfunc is registered KF_RCU and only for BPF LSM programs. A struct
socket is only guaranteed to live in sockfs when an LSM socket hook hands
it out, which is what keeps SOCK_INODE() valid. Sockets that embed struct
socket outside sockfs (tun, tap) are only reachable from tracing programs
and are excluded by the registration. (Btw, for consistency it would
be nice to force allocation of struct socket from sockfs instead of
simply embedding it in e.g., struct tun_file which makes the SOCKFS_I()
pattern a hazard - at least outside of sockfs functions.)

The read never sleeps and takes no lock. For sockfs the value lives in
the inode's in-memory xattr store and simple_xattr_get() resolves it
with an RCU-protected rhashtable lookup, taking neither the inode lock
nor any xattr lock. The kfunc is therefore usable from both sleepable
and non-sleepable LSM hooks.

Link: https://github.com/systemd/systemd/pull/40559 [1]
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/net.h |  1 +
 net/socket.c        | 25 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 11841c3d4260..85fc9519d1ff 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/kernfs.h>
 #include <linux/mm.h>
+#include <linux/net.h>
 #include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
@@ -359,6 +360,39 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 }
 #endif /* CONFIG_CGROUPS */
 
+#ifdef CONFIG_NET
+/**
+ * bpf_sock_read_xattr - read xattr of a socket's inode in sockfs
+ * @sock: socket to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *sock* and store the output in *value_p*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: length of the xattr value on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
+				    struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	u32 value_len;
+	void *value;
+
+	/* Only allow reading "user.*" xattrs */
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data_rw(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	return sock_read_xattr(sock, name__str, value, value_len);
+}
+#endif /* CONFIG_NET */
+
 /**
  * bpf_real_inode - get the real inode backing a dentry
  * @dentry: dentry to resolve
@@ -385,6 +419,9 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
+#ifdef CONFIG_NET
+BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
+#endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395ce47..fdcf9956805c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -285,6 +285,7 @@ int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
 struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname);
 struct socket *sockfd_lookup(int fd, int *err);
 struct socket *sock_from_file(struct file *file);
+int sock_read_xattr(struct socket *sock, const char *name, void *value, size_t size);
 #define		     sockfd_put(sock) fput(sock->file)
 int net_ratelimit(void);
 
diff --git a/net/socket.c b/net/socket.c
index 9e8dc769ff7a..3566f8c8ea3f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -465,6 +465,31 @@ static const struct xattr_handler sockfs_user_xattr_handler = {
 	.set = sockfs_user_xattr_set,
 };
 
+/**
+ * sock_read_xattr - read a user.* xattr from a socket's sockfs inode
+ * @sock: socket whose inode holds the xattr
+ * @name: full xattr name, e.g. "user.bpf_test"
+ * @value: output buffer
+ * @size: size of @value in bytes
+ *
+ * SOCK_INODE() is valid only for sockfs sockets; sock_from_file() rejects
+ * anything else (e.g. tun, tap).
+ * Lockless: simple_xattr_get() looks up the value under RCU, no inode lock.
+ *
+ * Return: length of the value on success, a negative errno on error.
+ */
+int sock_read_xattr(struct socket *sock, const char *name, void *value, size_t size)
+{
+	struct file *file = sock->file;
+	struct sockfs_inode *si;
+
+	if (!file || sock_from_file(file) != sock)
+		return -EOPNOTSUPP;
+
+	si = SOCKFS_I(SOCK_INODE(sock));
+	return simple_xattr_get(&sockfs_xa_cache, &si->xattrs, name, value, size);
+}
+
 static const struct xattr_handler * const sockfs_xattr_handlers[] = {
 	&sockfs_xattr_handler,
 	&sockfs_security_xattr_handler,

-- 
2.47.3


