Return-Path: <netdev+bounces-307080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TYkTCNihVGoUogMAu9opvQ
	(envelope-from <netdev+bounces-307080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35612748AF2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:29:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WODcklja;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307080-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307080-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96A0530426B7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AA33FE0A;
	Mon, 13 Jul 2026 08:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0D36897C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:16:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930574; cv=none; b=KLGT0W4tUPWV9uAYa4z6F3SpRFpxAEy9nllIK8t5kdU9YL3y+vWyLUizTw8SNhdddQ0okm9Ow3seCYyMl/yHj0Zov6pUErpAEa7hw3LVYl+1XeiowssjRc/1LTJQewqJg3i/df5fy1qNFbRgAfLzsGTVM/kG6wk9S5G2W/t9LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930574; c=relaxed/simple;
	bh=V8yWkQWQef11KQqghrCtwXl9sI54ibYha+PpauednaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gr3O25GpzD5LqPf46LrCBAnpkM3i+EP4EV4AYC92Rz0B/MZUiAIFv6G7M7yrAfbvkmRXc2ws6X6uEzwc2imwbJ0w8LOzXx4pnfLIMUAKpRJptIZ+ny6EIZhdYCR4VlhmRN2OKDmpfFSPgevY7gFbhKsWh9DINXN436bQ2S5PUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WODcklja; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88da04b719so2824357a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783930572; x=1784535372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rp+BZZ4sCAI2PvV6Vs/+NH3TsJrf5X+qVbMBa5+BFoc=;
        b=WODckljashNCyBXwhf7mGom7exqOGohVJNx3xGVWzKDTnv5Vb4+WCDzThDHOj8to+/
         x3SD2w/Y/FmUSyE6bxZjISBbxumHDUBNZy/e0AaaB85LGkZ3H5OjxpGFPLQZMEdXHYO0
         V+zZXIdu2EDP2reNFKMnczoETNOvQk6ANbcJfgQQvKtY9QODAA2Cs5elPrrUW33YjmE+
         RXUvD7Zlza4JKBWy+M7pYtPcDax3a8R9696WXKeY9mCZN2EdfBotc+sZ5GmEvig9JX5F
         dXXeHLAJkQsKyz2i9IMBH0fD3WASbyRUeErYKyz8shUDKf0Ka5WElMmSQsVjat5KLNLG
         QenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930572; x=1784535372;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rp+BZZ4sCAI2PvV6Vs/+NH3TsJrf5X+qVbMBa5+BFoc=;
        b=ewiaIdxOSO+subLaBA9kzk8PUE0M/HEeiRZ8s4B5AkLkV2+yN9AgFbVSgC4lvA0SQr
         eikuBcbXvXCp9nJ4iM8SnF4NvY+dwmmz+u8fU/kuNqAtnXiWNwa+eje7mOUZ3zlZZ9bU
         JkKMoeWxLH6obmZMaI6hebiL4xMY6SxkXwPg7m7Hanj7E7dxnVAt4Yt4W7gZruWqN+E1
         GOJqcbAwpJEJr6vyYDOzZr2JSNRL95C+OAVUQHqwjY7xoQqSoCP5zhzcoH/mfoFiccGx
         x1QQrd9CAnHW4bZBLYuUDuWM9thRFfg271O2Orz6F6Jx2ONirvlip0lxewSdSmCD30nN
         YxIQ==
X-Gm-Message-State: AOJu0Yyx9pQJoWLBRo6DPsUPY1pFPyBzzvzjE34HPNHim56odnVVoAkC
	5IclsoWMTbDMTeCt+U4xyhJHXtZgKjBIuu3Rr9Mn6oArqSkZytFl9F8blVe7w2cNf31RstN3Nw=
	=
X-Received: from dlea20-n2.prod.google.com ([2002:a05:701b:4214:20b0:13b:968d:3582])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:101:b0:3c0:bfd6:9657
 with SMTP id adf61e73a8af0-3c1108b5ffbmr8613379637.16.1783930571812; Mon, 13
 Jul 2026 01:16:11 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:16:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713081606.950892-1-maze@google.com>
Subject: [PATCH] [RFC] net-ipv6: ipv4 emulation support
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zenczykowski@gmail.com,m:netdev@vger.kernel.org,m:fmancera@suse.de,m:maze@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maze@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307080-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maze@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35612748AF2

Change-Id: Ibab1a59f4730f3fd0a7d14fffc5100a02a170ac6
---
 gconfigs/Gconfig.net-configs.ipv6 |   2 +
 include/linux/ipv6.h              |   6 +-
 include/linux/socket.h            |   5 +-
 include/net/compat.h              |   2 +-
 net/compat.c                      |   6 +-
 net/core/iovec.c                  |   4 +-
 net/ipv6/Kconfig                  |  19 +++
 net/ipv6/af_inet6.c               |   5 +
 net/ipv6/ipv6_sockglue.c          |   8 +-
 net/ipv6/sysctl_net_ipv6.c        |  26 ++++
 net/socket.c                      | 211 +++++++++++++++++++++++++++---
 11 files changed, 260 insertions(+), 34 deletions(-)
 create mode 100644 gconfigs/Gconfig.net-configs.ipv6

diff --git a/gconfigs/Gconfig.net-configs.ipv6 b/gconfigs/Gconfig.net-configs.ipv6
new file mode 100644
index 000000000000..9eb5694bae8e
--- /dev/null
+++ b/gconfigs/Gconfig.net-configs.ipv6
@@ -0,0 +1,2 @@
+CONFIG_IPV6_IPV4_EMULATE=y
+CONFIG_IPV6_IPV4_EMULATE_SYSCTL_DEFAULT=y
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index ff560537dd61..8bc5306094b5 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -157,11 +157,13 @@ struct ipv6_pinfo {
 #if defined(__BIG_ENDIAN_BITFIELD)
 	/* Packed in 16bits. */
 	__s16			mcast_hops:9;
-	__u16			__unused_2:6,
+	__u16			__unused_2:5,
+				ipv4emu:1,
 				mc_loop:1;
 #else
 	__u16			mc_loop:1,
-				__unused_2:6;
+				ipv4emu:1,
+				__unused_2:5;
 	__s16			mcast_hops:9;
 #endif
 	int			ucast_oif;
diff --git a/include/linux/socket.h b/include/linux/socket.h
index bb9b83640070..4ae959a3443b 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>		/* pid_t			*/
 #include <linux/compiler.h>		/* __user			*/
 #include <uapi/linux/socket.h>
+struct sock;				/* from net/sock.h		*/
 
 struct pid;
 struct cred;
@@ -312,8 +313,8 @@ extern int csum_partial_copy_fromiovecend(unsigned char *kdata,
 extern unsigned long iov_pages(const struct iovec *iov, int offset,
 			       unsigned long nr_segs);
 
-extern int verify_iovec(struct msghdr *m, struct iovec *iov, struct sockaddr_storage *address, int mode);
-extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
+extern int verify_iovec(struct sock *sk, struct msghdr *m, struct iovec *iov, struct sockaddr_storage *address, int mode);
+extern int move_addr_to_kernel(struct sock *sk, void __user *uaddr, int *ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
 struct timespec;
diff --git a/include/net/compat.h b/include/net/compat.h
index 3b603b199c01..b9ee7aa5a31f 100644
--- a/include/net/compat.h
+++ b/include/net/compat.h
@@ -41,7 +41,7 @@ int compat_sock_get_timestampns(struct sock *, struct timespec __user *);
 #endif /* defined(CONFIG_COMPAT) */
 
 int get_compat_msghdr(struct msghdr *, struct compat_msghdr __user *);
-int verify_compat_iovec(struct msghdr *, struct iovec *,
+int verify_compat_iovec(struct sock *, struct msghdr *, struct iovec *,
 			struct sockaddr_storage *, int);
 asmlinkage long compat_sys_sendmsg(int, struct compat_msghdr __user *,
 				   unsigned int);
diff --git a/net/compat.c b/net/compat.c
index bc8aeefddf3f..f66bd6552204 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -80,15 +80,15 @@ int get_compat_msghdr(struct msghdr *kmsg, struct compat_msghdr __user *umsg)
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
+int verify_compat_iovec(struct sock *sk, struct msghdr *kern_msg, struct iovec *kern_iov,
 		   struct sockaddr_storage *kern_address, int mode)
 {
 	int tot_len;
 
 	if (kern_msg->msg_name && kern_msg->msg_namelen) {
 		if (mode == VERIFY_READ) {
-			int err = move_addr_to_kernel(kern_msg->msg_name,
-						      kern_msg->msg_namelen,
+			int err = move_addr_to_kernel(sk, kern_msg->msg_name,
+						      &kern_msg->msg_namelen,
 						      kern_address);
 			if (err < 0)
 				return err;
diff --git a/net/core/iovec.c b/net/core/iovec.c
index e1ec45ab1e63..a7a393cae2a7 100644
--- a/net/core/iovec.c
+++ b/net/core/iovec.c
@@ -35,7 +35,7 @@
  *	in any case.
  */
 
-int verify_iovec(struct msghdr *m, struct iovec *iov, struct sockaddr_storage *address, int mode)
+int verify_iovec(struct sock *sk, struct msghdr *m, struct iovec *iov, struct sockaddr_storage *address, int mode)
 {
 	int size, ct, err;
 
@@ -43,7 +43,7 @@ int verify_iovec(struct msghdr *m, struct iovec *iov, struct sockaddr_storage *a
 		if (mode == VERIFY_READ) {
 			void __user *namep;
 			namep = (void __user __force *) m->msg_name;
-			err = move_addr_to_kernel(namep, m->msg_namelen,
+			err = move_addr_to_kernel(sk, namep, &m->msg_namelen,
 						  address);
 			if (err < 0)
 				return err;
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 438a73aa777c..69924a6c2257 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -21,6 +21,25 @@ menuconfig IPV6
 
 if IPV6
 
+config IPV6_IPV4_EMULATE
+	bool "IPv6: IPv4 socket interface emulation support"
+	default n
+	depends on IPV6=y
+	---help---
+	  Whether to include support code which allows using a kernel IPv6
+	  socket from userspace as if it was an IPv4 socket.
+	
+	  ie. this is a userspace-kernel IP address translation shim layer.
+
+config IPV6_IPV4_EMULATE_SYSCTL_DEFAULT
+	bool "IPv6: IPv4 socket emulation - default sysctl setting"
+	default n
+	depends on IPV6_IPV4_EMULATE
+	---help---
+	  Default value for /proc/sys/net/ipv6/ipv4_emulation
+	  The content of this sysctl file determines whether userspace asking
+	  for IPv4 sockets gets IPv6 sockets with IPv4 emulation turned on.
+
 config IPV6_ROUTER_PREF
 	bool "IPv6: Router Preference (RFC 4191) support"
 	---help---
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index e8c4400f23e9..4f08abdf06e0 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -476,6 +476,11 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	struct sock *sk = sock->sk;
 	struct net *net = sock_net(sk);
 
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	if (inet6_sk(sk)->ipv4emu)
+		return inet_ioctl(sock, cmd, arg);
+#endif
+
 	switch (cmd) {
 	case SIOCGSTAMP:
 		return sock_get_timestamp(sk, (struct timeval __user *)arg);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index e1a9583bb419..2e97c6d55b62 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -857,7 +857,7 @@ int ipv6_setsockopt(struct sock *sk, int level, int optname,
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
 		return udp_prot.setsockopt(sk, level, optname, optval, optlen);
 
-	if (level != SOL_IPV6)
+	if ((level != SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
 		return -ENOPROTOOPT;
 
 	err = do_ipv6_setsockopt(sk, level, optname, optval, optlen);
@@ -888,7 +888,7 @@ int compat_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return udp_prot.setsockopt(sk, level, optname, optval, optlen);
 	}
 
-	if (level != SOL_IPV6)
+	if ((level != SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
 		return -ENOPROTOOPT;
 
 	if (optname >= MCAST_JOIN_GROUP && optname <= MCAST_MSFILTER)
@@ -1297,7 +1297,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (level == SOL_IP && sk->sk_type != SOCK_RAW)
 		return udp_prot.getsockopt(sk, level, optname, optval, optlen);
 
-	if (level != SOL_IPV6)
+	if ((level != SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
 		return -ENOPROTOOPT;
 
 	err = do_ipv6_getsockopt(sk, level, optname, optval, optlen, 0);
@@ -1334,7 +1334,7 @@ int compat_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		return udp_prot.getsockopt(sk, level, optname, optval, optlen);
 	}
 
-	if (level != SOL_IPV6)
+	if ((level != SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
 		return -ENOPROTOOPT;
 
 	if (optname == MCAST_MSFILTER)
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index c5c10fafcfe2..0ab6a8d5aa57 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/in6.h>
 #include <linux/ipv6.h>
@@ -18,6 +19,20 @@
 
 static int one = 1;
 
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+static int zero;
+
+# if defined(CONFIG_IPV6_IPV4_EMULATE_SYSCTL_DEFAULT)
+bool sysctl_ipv4_emulation = true;
+# else
+bool sysctl_ipv4_emulation = false;
+# endif
+
+module_param_named(ipv4_emulation, sysctl_ipv4_emulation, bool, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(ipv4_emulation,
+		 "Auto promote PF_INET sockets into PF_INET6 sockets, with IPv4 API emulation.");
+#endif
+
 static struct ctl_table ipv6_table_template[] = {
 	{
 		.procname	= "bindv6only",
@@ -73,6 +88,17 @@ static struct ctl_table ipv6_rotable[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &one
 	},
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	{
+		.procname	= "ipv4_emulation",
+		.data		= &sysctl_ipv4_emulation,
+		.maxlen		= sizeof(bool),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 	{ }
 };
 
diff --git a/net/socket.c b/net/socket.c
index fe20c319a0bb..e7d2f5281ff3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -101,6 +101,7 @@
 #include <linux/netfilter.h>
 
 #include <linux/if_tun.h>
+#include <linux/ipv6.h>
 #include <linux/ipv6_route.h>
 #include <linux/route.h>
 #include <linux/sockios.h>
@@ -178,30 +179,171 @@ static DEFINE_PER_CPU(int, sockets_in_use);
  * divide and look after the messy bits.
  */
 
+static int ipv6_promote_ipv4_address(struct sock *sk,
+	struct sockaddr_storage * kaddr, int * addr_len)
+{
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	if (!sk) {
+		pr_warning("ipv6_promote_ipv4_address: no sk\n");
+		return 0;
+	}
+
+	if (sk->sk_family != PF_INET6) {
+		//pr_warning("ipv6_promote_ipv4_address: sk_family == %d\n", sk->sk_family);
+		return 0;
+	}
+
+	if (!inet6_sk(sk)->ipv4emu) {
+		//pr_warning("ipv6_promote_ipv4_address: not ipv4emu\n");
+		return 0;
+	}
+
+	if (kaddr->ss_family == AF_UNSPEC) {
+		//pr_warning("ipv6_promote_ipv4_address: unspec\n");
+		return 0;
+	}
+
+	if (kaddr->ss_family != AF_INET) {
+		pr_warning("ipv6_promote_ipv4_address: addr is %d\n", kaddr->ss_family);
+		return -EAFNOSUPPORT;
+	}
+
+	if (*addr_len < sizeof(struct sockaddr_in)) {
+		pr_warning("ipv6_promote_ipv4_address: addr_len == %d\n", *addr_len);
+		return -EINVAL;
+	}
+
+	{
+		const struct sockaddr_in * kaddr4 = (const struct sockaddr_in *)kaddr;
+		struct sockaddr_in6 * kaddr6 = (struct sockaddr_in6 *)kaddr;
+		__be16 port = kaddr4->sin_port;
+		__be32 ipv4 = kaddr4->sin_addr.s_addr;
+
+		//*addr_len = sizeof(struct sockaddr_in6);
+		*addr_len = 24; //SIN6_LEN_RFC2133; /* 24 = 2+2+4+16, ie. without scope id */
+// Why not fill in scope_id with 0 ?
+// One way to avoid the magic 24 constant is to use offsetof(struct sockaddr_in6, scope_id)
+		kaddr6->sin6_family = AF_INET6;
+		kaddr6->sin6_port = port;
+		kaddr6->sin6_flowinfo = htonl(0);
+		kaddr6->sin6_addr.s6_addr32[0] = htonl(0);
+		kaddr6->sin6_addr.s6_addr32[1] = htonl(0);
+		kaddr6->sin6_addr.s6_addr32[2] = ntohl(ipv4) ? htonl(0xFFFF) : htonl(0);
+		kaddr6->sin6_addr.s6_addr32[3] = ipv4;
+		kaddr6->sin6_scope_id = 0;
+
+		pr_debug("ipv6_promote_ipv4_address: ok [%08X:%d]\n", ntohl(ipv4), ntohs(port));
+	}
+#endif
+	return 0;
+}
+
+static int ipv6_demote_ipv6_address(struct sock *sk, struct sockaddr_storage * kaddr, int * addr_len) {
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	if (!sk) {
+		pr_warning("ipv6_demote_ipv6_address: no sk\n");
+		return 0;
+	}
+
+	if (sk->sk_family != PF_INET6) {
+		//pr_warning("ipv6_demote_ipv6_address: sk_family == %d\n", sk->sk_family);
+		return 0;
+	}
+
+	if (!inet6_sk(sk)->ipv4emu) {
+		//pr_warning("ipv6_demote_ipv6_address: not ipv4emu\n");
+		return 0;
+	}
+
+	if (kaddr->ss_family != AF_INET6) {
+		pr_warning("ipv6_demote_ipv6_address: addr is %d\n", kaddr->ss_family);
+		return -EAFNOSUPPORT;
+	}
+
+	if (*addr_len < sizeof(struct sockaddr_in6)) {
+		pr_warning("ipv6_demote_ipv6_address: addr_len == %d\n", *addr_len);
+		return -EINVAL;
+	}
+
+	{
+		struct sockaddr_in6 const * kaddr6 = (struct sockaddr_in6 const *)kaddr;
+		struct sockaddr_in * kaddr4 = (struct sockaddr_in *)kaddr;
+		__be16 port = kaddr6->sin6_port;
+		__be32 ipv6a = kaddr6->sin6_addr.s6_addr32[0];
+		__be32 ipv6b = kaddr6->sin6_addr.s6_addr32[1];
+		__be32 ipv6c = kaddr6->sin6_addr.s6_addr32[2];
+		__be32 ipv4 = kaddr6->sin6_addr.s6_addr32[3];
+
+// please use ipv6_addr_v4mapped()
+
+		if (ipv6a) {
+			pr_warning("ipv6_demote_ipv6_address: not mapped [1]\n");
+			return -EINVAL;
+		}
+
+		if (ipv6b) {
+			pr_warning("ipv6_demote_ipv6_address: not mapped [2]\n");
+			return -EINVAL;
+		}
+
+		if ((ipv6c != htonl(0)) && (ipv6c != htonl(0xFFFF))) {
+			pr_warning("ipv6_demote_ipv6_address: not mapped [3]\n");
+			return -EINVAL;
+		}
+
+		if ((ipv6c == htonl(0)) && (ipv4 != htonl(0))) {
+			pr_warning("ipv6_demote_ipv6_address: not mapped [4]\n");
+			return -EINVAL;
+		}
+
+// Really avoid those magic values...
+// Since I doubt this is performance critical, just do the whole struct clear at the beginning:
+// memset(uaddr4, 0, sizeof(*uaddr4));
+
+		*addr_len = sizeof(struct sockaddr_in); // 2 + 2 + 4 + 8 padding
+		kaddr4->sin_family = AF_INET;
+		kaddr4->sin_port = port;
+		kaddr4->sin_addr.s_addr = ipv4;
+		memset(kaddr4->sin_zero, 0, 8);
+
+		pr_debug("ipv6_demote_ipv6_address: ok [%08X:%d]\n", ntohl(ipv4), ntohs(port));
+	}
+#endif
+	return 0;
+}
+
 /**
  *	move_addr_to_kernel	-	copy a socket address into kernel space
+ *	@sk: socket which is receiving the address (or NULL)
  *	@uaddr: Address in user space
  *	@kaddr: Address in kernel space
- *	@ulen: Length in user space
+ *	@ulen: pointer to user space length
  *
  *	The address is copied into kernel space. If the provided address is
  *	too long an error code of -EINVAL is returned. If the copy gives
  *	invalid addresses -EFAULT is returned. On a success 0 is returned.
  */
 
-int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr)
+int move_addr_to_kernel(struct sock *sk, void __user *uaddr, int *ulen,
+			struct sockaddr_storage *kaddr)
 {
-	if (ulen < 0 || ulen > sizeof(struct sockaddr_storage))
+	int err;
+
+	if (*ulen < 0 || *ulen > sizeof(struct sockaddr_storage))
 		return -EINVAL;
-	if (ulen == 0)
+	if (*ulen == 0)
 		return 0;
-	if (copy_from_user(kaddr, uaddr, ulen))
+	if (copy_from_user(kaddr, uaddr, *ulen))
 		return -EFAULT;
-	return audit_sockaddr(ulen, kaddr);
+	err = audit_sockaddr(*ulen, kaddr);
+	if (err)
+		return err;
+	return ipv6_promote_ipv4_address(sk, kaddr, ulen);
 }
 
 /**
  *	move_addr_to_user	-	copy an address to user space
+ *	@sk: socket which is generating the address (or NULL)
  *	@kaddr: kernel space address
  *	@klen: length of address in kernel
  *	@uaddr: user space address
@@ -217,7 +359,7 @@ int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *k
  *	specified. Zero is returned for a success.
  */
 
-static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
+static int move_addr_to_user(struct sock *sk, struct sockaddr_storage *kaddr, int klen,
 			     void __user *uaddr, int __user *ulen)
 {
 	int err;
@@ -225,6 +367,9 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 
 	BUG_ON(klen > sizeof(struct sockaddr_storage));
 	err = get_user(len, ulen);
+	if (err)
+		return err;
+	err = ipv6_demote_ipv6_address(sk, kaddr, &klen);
 	if (err)
 		return err;
 	if (len > klen)
@@ -1249,12 +1394,19 @@ call_kill:
 }
 EXPORT_SYMBOL(sock_wake_async);
 
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+extern bool sysctl_ipv4_emulation;
+#endif
+
 int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
 	int err;
 	struct socket *sock;
 	const struct net_proto_family *pf;
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	bool ipv4emu = false;
+#endif
 
 	/*
 	 *      Check protocol is in range
@@ -1283,6 +1435,13 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	if (err)
 		return err;
 
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	if (sysctl_ipv4_emulation && !kern && family == PF_INET) {
+		family = PF_INET6;
+		ipv4emu = true;
+	}
+#endif
+
 	/*
 	 *	Allocate the socket and allow the family to set things up. if
 	 *	the protocol is 0, the family is instructed to select an appropriate
@@ -1328,6 +1487,14 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	if (err < 0)
 		goto out_module_put;
 
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	if (ipv4emu) {
+		inet6_sk(sock->sk)->ipv4emu = 1;
+		/* we need to clear ipv6only, since it could have defaulted to true via sysctl */
+		sock->sk->sk_ipv6only = 0;
+	}
+#endif
+
 	/*
 	 * Now to bump the refcnt of the [loadable] module that owns this
 	 * socket at sock_release time we decrement its refcnt.
@@ -1532,7 +1699,7 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
 
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock) {
-		err = move_addr_to_kernel(umyaddr, addrlen, &address);
+		err = move_addr_to_kernel(sock->sk, umyaddr, &addrlen, &address);
 		if (err >= 0) {
 			err = security_socket_bind(sock,
 						   (struct sockaddr *)&address,
@@ -1646,7 +1813,7 @@ SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
 			err = -ECONNABORTED;
 			goto out_fd;
 		}
-		err = move_addr_to_user(&address,
+		err = move_addr_to_user(newsock->sk, &address,
 					len, upeer_sockaddr, upeer_addrlen);
 		if (err < 0)
 			goto out_fd;
@@ -1695,7 +1862,7 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		goto out;
-	err = move_addr_to_kernel(uservaddr, addrlen, &address);
+	err = move_addr_to_kernel(sock->sk, uservaddr, &addrlen, &address);
 	if (err < 0)
 		goto out_put;
 
@@ -1735,7 +1902,7 @@ SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
 	err = sock->ops->getname(sock, (struct sockaddr *)&address, &len, 0);
 	if (err)
 		goto out_put;
-	err = move_addr_to_user(&address, len, usockaddr, usockaddr_len);
+	err = move_addr_to_user(sock->sk, &address, len, usockaddr, usockaddr_len);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -1767,7 +1934,7 @@ SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
 		    sock->ops->getname(sock, (struct sockaddr *)&address, &len,
 				       1);
 		if (!err)
-			err = move_addr_to_user(&address, len, usockaddr,
+			err = move_addr_to_user(sock->sk, &address, len, usockaddr,
 						usockaddr_len);
 		fput_light(sock->file, fput_needed);
 	}
@@ -1806,7 +1973,7 @@ SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
 	msg.msg_controllen = 0;
 	msg.msg_namelen = 0;
 	if (addr) {
-		err = move_addr_to_kernel(addr, addr_len, &address);
+		err = move_addr_to_kernel(sock->sk, addr, &addr_len, &address);
 		if (err < 0)
 			goto out_put;
 		msg.msg_name = (struct sockaddr *)&address;
@@ -1871,7 +2038,7 @@ SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, ubuf, size_t, size,
 	err = sock_recvmsg(sock, &msg, size, flags);
 
 	if (err >= 0 && addr != NULL) {
-		err2 = move_addr_to_user(&address,
+		err2 = move_addr_to_user(sock->sk, &address,
 					 msg.msg_namelen, addr, addr_len);
 		if (err2 < 0)
 			err = err2;
@@ -2042,9 +2209,9 @@ static int ___sys_sendmsg(struct socket *sock, struct msghdr __user *msg,
 
 	/* This will also move the address data into kernel space */
 	if (MSG_CMSG_COMPAT & flags) {
-		err = verify_compat_iovec(msg_sys, iov, &address, VERIFY_READ);
+		err = verify_compat_iovec(sock->sk, msg_sys, iov, &address, VERIFY_READ);
 	} else
-		err = verify_iovec(msg_sys, iov, &address, VERIFY_READ);
+		err = verify_iovec(sock->sk, msg_sys, iov, &address, VERIFY_READ);
 	if (err < 0)
 		goto out_freeiov;
 	total_len = err;
@@ -2258,9 +2425,9 @@ static int ___sys_recvmsg(struct socket *sock, struct msghdr __user *msg,
 	uaddr = (__force void __user *)msg_sys->msg_name;
 	uaddr_len = COMPAT_NAMELEN(msg);
 	if (MSG_CMSG_COMPAT & flags)
-		err = verify_compat_iovec(msg_sys, iov, &addr, VERIFY_WRITE);
+		err = verify_compat_iovec(sock->sk, msg_sys, iov, &addr, VERIFY_WRITE);
 	else
-		err = verify_iovec(msg_sys, iov, &addr, VERIFY_WRITE);
+		err = verify_iovec(sock->sk, msg_sys, iov, &addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out_freeiov;
 	total_len = err;
@@ -2280,7 +2447,7 @@ static int ___sys_recvmsg(struct socket *sock, struct msghdr __user *msg,
 	len = err;
 
 	if (uaddr != NULL) {
-		err = move_addr_to_user(&addr,
+		err = move_addr_to_user(sock->sk, &addr,
 					msg_sys->msg_namelen, uaddr,
 					uaddr_len);
 		if (err < 0)
@@ -3159,7 +3326,11 @@ static int routing_ioctl(struct net *net, struct socket *sock,
 	u32 rtdev;
 	mm_segment_t old_fs = get_fs();
 
-	if (sock && sock->sk && sock->sk->sk_family == AF_INET6) { /* ipv6 */
+	if (sock && sock->sk && sock->sk->sk_family == AF_INET6
+#if defined(CONFIG_IPV6_IPV4_EMULATE)
+	    && !inet6_sk(sock->sk)->ipv4emu
+#endif
+	   ) { /* ipv6 */
 		struct in6_rtmsg32 __user *ur6 = argp;
 		ret = copy_from_user(&r6.rtmsg_dst, &(ur6->rtmsg_dst),
 			3 * sizeof(struct in6_addr));
-- 
2.55.0.795.g602f6c329a-goog


