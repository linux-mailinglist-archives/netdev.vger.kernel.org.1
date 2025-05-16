Return-Path: <netdev+bounces-191188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264CABA5C6
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF2BA07D1A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3F28032E;
	Fri, 16 May 2025 22:09:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019F280034
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747433386; cv=none; b=u4ANme0kt/GtSTFvHbN8TE23yCDACTSW0k+uqvmxq1KM390S95HDE5J5ImzfnvwuJZEUsQ3YLeEthD0yFxY4lFli94l61S8W/9A2IUuCjz2vEP3Yf3bOr3gxiOPgy/9irhLHUhWg5DikVDTy0U3JbCfYlVmOURHLls7SpzT/6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747433386; c=relaxed/simple;
	bh=7+FvtjEG7eARyYDx+d80MRGsByjUX5PV97tLQHjDxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNQHv88RirSvDo0XwOIOfNPuDLgFUrGf90RnBbghgmH5Bg4U1K6AWp8f/GzxodBefhhHgqL/URGqh8UVnbrEIm/a/s3hHNZJ45gfaBrNZpcp8qcZEGf//JE7lMOSunO20wnv50IMGwuQXGCdRVixEUBjBcHRgCQmcGNQW2jo2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D556620006;
	Fri, 16 May 2025 22:07:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3006B13411;
	Fri, 16 May 2025 22:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cAkgOqW3J2hmGwAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Fri, 16 May 2025 22:09:41 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: netdev@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] net: socket: hint netns refcounting through @kern arg
Date: Fri, 16 May 2025 19:09:19 -0300
Message-ID: <20250516220920.1142578-2-ematsumiya@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516220920.1142578-1-ematsumiya@suse.de>
References: <20250516220920.1142578-1-ematsumiya@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D556620006
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 

Some modules require the netns a socket resides in to be properly
refcounted to avoid UAF (e.g. netns is gone before socket, socket goes
away before TCP timers kicking in).

Such refcounting is done based on sk->sk_net_refcnt, which, in turn, is
set based on @kern arg -- kernel sockets are not netns refcounted by
default.

In order to deal with that, modules are allocating a kernel socket, and,
right after, calling sk_net_refcnt_upgrade() (which sets sk->sk_net_refcnt
to 1 and do the proper setup for the netns refcounter).

This patch aims to centralize this behaviour on sk_alloc() by changing
the @kern arg to accept newly added SOCK_NETNS_REFCNT_* values.

Practically it only adds a third value which means "kernel socket with
netns refcounting".

To maintain compatibility with the previous boolean behaviour
(@kern/!@kern), SOCK_NETNS_REFCNT_USER is 0 and
SOCK_NETNS_REFCNT_KERN_* > 0.

Also add a sock_create_netns() wrapper.  Callers that need a kernel
socket with netns refcounting may use this wrapper.

Follow up patch will update callers of sk_net_refcnt_upgrade()
to use this new option instead.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 include/linux/net.h | 15 +++++++++++++++
 net/core/sock.c     | 10 ++++++----
 net/socket.c        | 27 +++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..bf5e2e68cee5 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -247,6 +247,20 @@ enum {
 	SOCK_WAKE_URG,
 };
 
+/*
+ * sock netns refcounting modes:
+ *
+ * @SOCK_NETNS_REFCNT_USER: user sockets always hold a netns reference
+ * @SOCK_NETNS_REFCNT_KERN_NONE: kernel socket will not hold active netns reference
+ * @SOCK_NETNS_REFCNT_KERN_ANY: kernel socket will hold active reference for any netns
+ *				(but init_net)
+ */
+enum {
+	SOCK_NETNS_REFCNT_USER,
+	SOCK_NETNS_REFCNT_KERN_NONE,
+	SOCK_NETNS_REFCNT_KERN_ANY,
+};
+
 int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
@@ -255,6 +269,7 @@ int __sock_create(struct net *net, int family, int type, int proto,
 		  struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
 int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
+int sock_create_netns(struct net *net, int family, int type, int protocol, struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/core/sock.c b/net/core/sock.c
index e54449c9ab0b..1b987d47e4d8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2244,7 +2244,7 @@ static void sk_prot_free(struct proto *prot, struct sock *sk)
  *	@family: protocol family
  *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
  *	@prot: struct proto associated with this new sock instance
- *	@kern: is this to be a kernel socket?
+ *	@kern: hint for netns refcounting (%SOCK_NETNS_REFCNT_USER, ...)
  */
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern)
@@ -2259,13 +2259,15 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		 * why we need sk_prot_creator -acme
 		 */
 		sk->sk_prot = sk->sk_prot_creator = prot;
-		sk->sk_kern_sock = kern;
+		sk->sk_kern_sock = !!kern;
 		sock_lock_init(sk);
-		sk->sk_net_refcnt = kern ? 0 : 1;
-		if (likely(sk->sk_net_refcnt)) {
+		if (likely(kern == SOCK_NETNS_REFCNT_USER) ||
+		    (kern == SOCK_NETNS_REFCNT_KERN_ANY && !net_eq(net, &init_net))) {
+			sk->sk_net_refcnt = 1;
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
 		} else {
+			sk->sk_net_refcnt = 0;
 			net_passive_inc(net);
 			__netns_tracker_alloc(net, &sk->ns_tracker,
 					      false, priority);
diff --git a/net/socket.c b/net/socket.c
index 9a0e720f0859..9cce213b3fc2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1459,11 +1459,12 @@ EXPORT_SYMBOL(sock_wake_async);
  *	@type: communication type (SOCK_STREAM, ...)
  *	@protocol: protocol (0, ...)
  *	@res: new socket
- *	@kern: boolean for kernel space sockets
+ *	@kern: hint for netns refcounting (%SOCK_NETNS_REFCNT_USER, ...)
  *
  *	Creates a new socket and assigns it to @res, passing through LSM.
  *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
+ *	be set to %SOCK_NETNS_REFCNT_* -- handled as boolean in most places,
+ *	effectively handled only in sk_alloc().
  *	This function internally uses GFP_KERNEL.
  */
 
@@ -1609,6 +1610,7 @@ EXPORT_SYMBOL(sock_create);
  *	@res: new socket
  *
  *	A wrapper around __sock_create().
+ *	Created socket will not hold a reference on @net.
  *	Returns 0 or an error. This function internally uses GFP_KERNEL.
  */
 
@@ -1618,6 +1620,27 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
 }
 EXPORT_SYMBOL(sock_create_kern);
 
+/**
+ *	sock_create_netns - creates a socket (kernel space)
+ *	@net: net namespace
+ *	@family: protocol family (AF_INET, ...)
+ *	@type: communication type (SOCK_STREAM, ...)
+ *	@protocol: protocol (0, ...)
+ *	@res: new socket
+ *
+ *	A wrapper around __sock_create().
+ *	If @net == %init_net (checked in sk_alloc), created socket will
+ *	not hold a reference on @net (i.e. same as sock_create_kern).
+ *	Otherwise, created socket will hold a reference on @net.
+ *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ */
+
+int sock_create_netns(struct net *net, int family, int type, int protocol, struct socket **res)
+{
+	return __sock_create(net, family, type, protocol, res, SOCK_NETNS_REFCNT_KERN_ANY);
+}
+EXPORT_SYMBOL(sock_create_netns);
+
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
 	struct socket *sock;
-- 
2.48.1


