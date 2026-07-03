Return-Path: <netdev+bounces-304417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9YPJKr1pR2qwXwAAu9opvQ
	(envelope-from <netdev+bounces-304417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3186FFBD1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:50:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=keHmE7Lx;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304417-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304417-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377E830E694B
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAA371860;
	Fri,  3 Jul 2026 07:40:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4336F411;
	Fri,  3 Jul 2026 07:40:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064454; cv=none; b=kS4TBWpRvrwbhvJiVS+lDsZ9V9c+znG+vf3eTiYiuw3tU2puErSz4kTrRwWCI1CGJrBIs0P/QFbXYR4morTlQmHBNJjQt72+6BH0ZYJ8oVoKqR3wJ8vnLnBAjSN4KRrH77R+lauVzcId44qXgn9j2upW4m/qTgiI3vw55h8fKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064454; c=relaxed/simple;
	bh=mm7P2sqBAF6bXKS3oZrmBAByBli5vv7qn3sSyLLB2G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWSUSeq/WStjfC85pS8h4D7FVhJkqOsOBZR967jyMOeumKj8vuyKd1OH8LDP6z/xIF+MZejFmAbxcrPSRxaPygG7v9mpi0dKey1I6XTm1rJazWZvux2nBIuGwjFddUqWsuA3GjyrJLQGhoUmhSo3/PL+HGviLYxgK9mZEei1RLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keHmE7Lx; arc=none smtp.client-ip=103.168.172.139
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id BA575138025A;
	Fri,  3 Jul 2026 03:40:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Jul 2026 03:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783064451; x=1783071651; bh=G
	5IdncEZMttblUkdvDrma7vZ1fMX6xFFr5IUmHWIufs=; b=keHmE7LxlimZWhiDp
	HalzhOiSqZ+LL53trdkqZ8Wd76H8b3ERTGWdLo8udomhsBgxGdJhh7lcFufwlF/l
	NXxZSyOhvKyTKUZbJ7ViRwh86VdBEM8boyfmRKHn3GysEmiSwLrE0daDSsG+SABc
	7NEud9nsMkY4xNzJa/FIf7M9QdbwLJg+2eskWWeF3qCjNXPtcI8yHJ0SUzbEBURX
	ZZYnUBLTVtagpxVgtpcv9m3wIjPESvpCeUn8I1vDuINeGCZozeZyIT2M4mxDo+Ng
	4cOTpip5t97/0cbdk02e+qIxIphAH938ssz6P6tGtQgcK9Lp4g6Vx9ZS/oUHjdTo
	VmIUw==
X-ME-Sender: <xms:g2dHavx0c1Fe7m2Nn1ps4LkAPn9VUaBoRZhwnn56il7NmEC90J1keg>
    <xme:g2dHauOUdt7-ZzAi5edF8o62XjZ9V8gjoF-oKpQdkVmNK4zrWv3mibI5AHVu15F3S
    9R29S-5539O03GyoPra2rMS52XNTz95DBqAx2aR6JeDwqQei0luBeg>
X-ME-Received: <xmr:g2dHauaodA-zPB2IgBuPkYFFCqkn4I_JPD1sxniHRsB84I-zb7mVwCtqH0KUjYFOWq447O8zy2V4ic0lThdGOXzylj84dHEpPEoHTA>
X-ME-Proxy-Cause: dmFkZTGD+55Le//f3h8RLTETwVa3bWav1dX8jX0sV5Dck/InRGicx/GeEaHwqqbxMviI6N
    J4Rea78NzJDlLaY60f+CVXfCs8Fg3Y5Cj+iTaTnWbo1ZA1zfFl+/deVfj6Sx7MBhcLuoUf
    1TRfB2c4wSGdKmPVmKaM/8miAneWrUINp9zV+LGN/NRIiyitqqExNDSbDFTI1l7pjIIX55
    gRvZ7TIcOkkZ+HtVWGJk7fOJgyWuHezOnrtpQZEnWIemAOLNlzSb88VMbbYhPEx5dpvfSX
    VpT7QCtPf88Qdki/FMnoISyPb+gXe0xwNYQyO+kTF+erVXDOhNquzZcEaIby0s7Z+TYTmm
    x4L1dtVnooR12YB9B4VjPYqPV6Uj2VCUbKSChFIWCfhRhOAAwFGdTplQUpLcl1OI5sEbBZ
    xZbXHacJrTJqbT+WFbP52p3pUZPMQaP0OJy+VDVJMFYLBGvr20WhETfZVW+HtMFvh3VkRc
    qwh9kb5O7GG8AHIuKrWeM8GLe2rlmWrkfxGAM2j1fmHms5J3ne+8Ar5wM7EzAQMFLIkC38
    B6ZoBzMp73aSGQoGre1Ea9wTLz9oQ/+P1A5hLv5/Y6PT6qZVrv995WjzREfG3d1OVurcBV
    nco+ItqNmrCJtZHE9pJ1iy1tYCprxGoOzKhfPHkXj7QNnnCudTSppbQ578lQ
X-ME-Proxy: <xmx:g2dHagrGKLEXZ3DLaLzb0uxFH38uoUa3V9kTfX9vK2DivLiatG7gzQ>
    <xmx:g2dHarxC4GdklIRng3P7ED1MKaVvsLXC6BjBv-0ksmaUek3uZAJdpQ>
    <xmx:g2dHaoIpk8CVizG0v0mH7LsRtFoL_EykU5tcdWI8Zwqrm_2siUCYpA>
    <xmx:g2dHat7AF2mvkNZBjWZtjSg_vqiYZOw892uHcaICYSqV_ksMWZoQew>
    <xmx:g2dHapSIwNlvuBaQ0Zy6DfttWG3UF6LlzNJkLTwoprkCqPLxHnmj06Tn>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 03:40:50 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Ericson <mail@JohnEricson.me>,
	Cong Wang <cwang@multikernel.io>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] coredump, net: remove `SOCK_COREDUMP`
Date: Fri,  3 Jul 2026 03:39:44 -0400
Message-ID: <20260703073948.2541875-4-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-304417-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@JohnEricson.me,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,johnericson.me:email,vger.kernel.org:from_smtp,Obsidian.Systems:mid,Obsidian.Systems:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F3186FFBD1

From: John Ericson <mail@JohnEricson.me>

The utility of the refactors of the last two commits is demonstrated by
fixing this glaring layer violation: the unix socket implementation
knowing about the coredump socket caller.

Before, when the only way to connect to a socket was via the UAPI
`struct sockaddr_un`, the only way to implement the proper logic that
the kernel needs to resolve the coredump socket path was via hacking it
into the socket implementation.

In addition to being quite ugly, this layer violation is not great for
security. The intent is that `SOCK_COREDUMP` can only be used by the
kernel, and to be clear, I have no reason to believe this is not
correctly enforced today. But because of the many functions with flags
arguments, this is not a locally-enforced invariant. Some change, at
some point, could mess up, and allow user-provided flags to sneak in,
and this strikes me as a mistake waiting to happen. At that point, a
user could exploit this to connect to any socket it likes, bypassing
permission checks.

Now, with the two functions we've just previously factored out, we can
fix the layering. The custom path lookup logic lives with the coredump
caller, where it belongs. Once the right `struct path` is found
(actually just the inode is needed), the coredump caller can resolve a
`struct sock *` from it, and then directly connect to it. With this
change, `SOCK_COREDUMP` is no longer needed at all, and can be deleted.
The layer violation is gone, and the security footgun is gone with it.

As an added bonus, remove `flags` parameters from a number of internal
functions that no longer need them. They were just taking flags
parameters for the sake of `SOCK_COREDUMP`, and so with that gone, those
flag parameters are also no longer needed. If or when there is a new
flag that motivates them, they can be added back.

Tested that `coredump_socket_protocol_test` still passes.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Ericson <mail@JohnEricson.me>
---
 fs/coredump.c                 | 47 ++++++++++++++++++++++++-----------
 include/linux/lsm_hook_defs.h |  3 +--
 include/linux/net.h           |  1 -
 include/linux/security.h      |  4 +--
 net/unix/af_unix.c            | 42 ++++++++++---------------------
 security/landlock/fs.c        |  7 +-----
 security/security.c           |  5 ++--
 7 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..e1452021218e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
+#include <linux/cred.h>
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
@@ -21,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/utsname.h>
 #include <linux/pid_namespace.h>
@@ -50,7 +52,6 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
-#include <uapi/linux/un.h>
 #include <uapi/linux/coredump.h>
 
 #include <linux/uaccess.h>
@@ -668,17 +669,10 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
 {
 	struct file *file __free(fput) = NULL;
-	struct sockaddr_un addr = {
-		.sun_family = AF_UNIX,
-	};
-	ssize_t addr_len;
-	int retval;
+	struct path root, path;
 	struct socket *socket;
-
-	addr_len = strscpy(addr.sun_path, cn->corename);
-	if (addr_len < 0)
-		return false;
-	addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
+	struct sock *sk;
+	int retval;
 
 	/*
 	 * It is possible that the userspace process which is supposed
@@ -710,14 +704,37 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	 */
 	pidfs_coredump(cprm);
 
-	retval = kernel_connect(socket, (struct sockaddr_unsized *)(&addr), addr_len,
-				O_NONBLOCK | SOCK_COREDUMP);
+	/*
+	 * Resolve the socket path relative to init's root and with kernel
+	 * credentials, and with symlinks, magic links and escaping the
+	 * root all forbidden, so the dumping process cannot use its own
+	 * filesystem view to redirect its core to an arbitrary socket.
+	 */
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	scoped_with_kernel_creds()
+		retval = vfs_path_lookup(root.dentry, root.mnt, cn->corename,
+					 LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
+					 LOOKUP_NO_MAGICLINKS, &path);
+	path_put(&root);
+	if (retval)
+		return false;
+
+	/* Connect directly to the socket bound there, by fd not by name. */
+	sk = unix_lookup_bsd_path(&path, SOCK_STREAM);
+	path_put(&path);
+	if (IS_ERR(sk))
+		return false;
 
+	retval = kernel_unix_connect_direct(sk, socket, O_NONBLOCK);
+	sock_put(sk);
 	if (retval) {
 		if (retval == -EAGAIN)
-			coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
+			coredump_report_failure("Coredump socket %s receive queue full", cn->corename);
 		else
-			coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
+			coredump_report_failure("Coredump socket connection %s failed %d", cn->corename, retval);
 		return false;
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..3d6fbb6d2628 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -323,8 +323,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
 #if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
-LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
-	 int flags)
+LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other)
 #endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395ce47..285cb67927f0 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -102,7 +102,6 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
-#define SOCK_COREDUMP	O_NOCTTY
 
 /**
  * enum sock_shutdown_cmd - Shutdown types
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..9797bd29c916 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1957,10 +1957,10 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
 
-int security_unix_find(const struct path *path, struct sock *other, int flags);
+int security_unix_find(const struct path *path, struct sock *other);
 
 #else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
-static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+static inline int security_unix_find(const struct path *path, struct sock *other)
 {
 	return 0;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index aa94da1f8c24..7cb537b404cc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1220,7 +1220,7 @@ struct sock *unix_lookup_bsd_path(const struct path *path, int type)
 EXPORT_SYMBOL_GPL(unix_lookup_bsd_path);
 
 static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
-				  int type, int flags)
+				  int type)
 {
 	struct path path;
 	struct sock *sk;
@@ -1228,29 +1228,13 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 
 	unix_mkname_bsd(sunaddr, addr_len);
 
-	if (flags & SOCK_COREDUMP) {
-		struct path root;
-
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
-
-		scoped_with_kernel_creds()
-			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
-					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
-					      LOOKUP_NO_MAGICLINKS, &path);
-		path_put(&root);
-		if (err)
-			goto fail;
-	} else {
-		err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
-		if (err)
-			goto fail;
+	err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
+	if (err)
+		goto fail;
 
-		err = path_permission(&path, MAY_WRITE);
-		if (err)
-			goto path_put;
-	}
+	err = path_permission(&path, MAY_WRITE);
+	if (err)
+		goto path_put;
 
 	sk = unix_lookup_bsd_path(&path, type);
 	if (IS_ERR(sk)) {
@@ -1258,7 +1242,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 	}
 
-	err = security_unix_find(&path, sk, flags);
+	err = security_unix_find(&path, sk);
 	if (err)
 		goto sock_put;
 
@@ -1297,12 +1281,12 @@ static struct sock *unix_find_abstract(struct net *net,
 
 static struct sock *unix_find_other(struct net *net,
 				    struct sockaddr_un *sunaddr,
-				    int addr_len, int type, int flags)
+				    int addr_len, int type)
 {
 	struct sock *sk;
 
 	if (sunaddr->sun_path[0])
-		sk = unix_find_bsd(sunaddr, addr_len, type, flags);
+		sk = unix_find_bsd(sunaddr, addr_len, type);
 	else
 		sk = unix_find_abstract(net, sunaddr, addr_len, type);
 
@@ -1558,7 +1542,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr_unsized *addr
 		}
 
 restart:
-		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, 0);
+		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out;
@@ -1897,7 +1881,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	 * unix_stream_connect_commit() means "retry": the peer had died,
 	 * or its backlog was full and we slept -- so re-resolve the name.
 	 */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
+	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
 		goto out_free;
@@ -2330,7 +2314,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_namelen) {
 lookup:
 		other = unix_find_other(sock_net(sk), msg->msg_name,
-					msg->msg_namelen, sk->sk_type, 0);
+					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out_free;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7e5e4ef9eac..d77080438c01 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1641,8 +1641,7 @@ static void unmask_scoped_access(const struct landlock_ruleset *const client,
 	}
 }
 
-static int hook_unix_find(const struct path *const path, struct sock *other,
-			  int flags)
+static int hook_unix_find(const struct path *const path, struct sock *other)
 {
 	const struct landlock_ruleset *dom_other;
 	const struct landlock_cred_security *subject;
@@ -1652,10 +1651,6 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
 		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
 	};
 
-	/* Lookup for the purpose of saving coredumps is OK. */
-	if (unlikely(flags & SOCK_COREDUMP))
-		return 0;
-
 	subject = landlock_get_applicable_subject(current_cred(),
 						  fs_resolve_unix, NULL);
 
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..fabb75c88254 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4839,16 +4839,15 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
  * security_unix_find() - Check if a named AF_UNIX socket can connect
  * @path: path of the socket being connected to
  * @other: peer sock
- * @flags: flags associated with the socket
  *
  * This hook is called to check permissions before connecting to a named
  * AF_UNIX socket. The caller does not hold any locks on @other.
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_find(const struct path *path, struct sock *other, int flags)
+int security_unix_find(const struct path *path, struct sock *other)
 {
-	return call_int_hook(unix_find, path, other, flags);
+	return call_int_hook(unix_find, path, other);
 }
 EXPORT_SYMBOL(security_unix_find);
 
-- 
2.54.0


