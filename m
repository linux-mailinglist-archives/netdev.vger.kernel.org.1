Return-Path: <netdev+bounces-211288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9CAB17939
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDDA7A8BDA
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6B26CE26;
	Thu, 31 Jul 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq3bKOm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72918265CCB;
	Thu, 31 Jul 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003010; cv=none; b=kMW12rrvpl/iDmSzmwlI88cMaf3iXTh0AYGYuuAiFyqWzEXNtOIUsEHFgmNO/J4hnc4AaFfSQuAPpggT1XCJbm79FvnZ9OKvdms7rux5oRw3v4CB/RLqD1oYiriXpJX/0nhj9RDTVteC4Gg3jr++MGZ3zDeQI1FehVQe7ffESpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003010; c=relaxed/simple;
	bh=bByVB3eFZz3ChERtbjPjYgUzCCYFldGuSuFxTrRGkgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DiJS8MUmGPgY/QTy1NkZoqvzW0zINg08X/XXlICIB4WwTBiOzM+EF7fhfMRdhhJXIakFQ9J/erhBMFBu+f8VSg7Kp/1Sxz78QHX0aRlL/bpBdF67zsV/7mcpTqUXvNumAZgheQmUIPATE658mLDZaFAeN8bgl7jJqEbPrPmVMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq3bKOm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2BB9C4CEEF;
	Thu, 31 Jul 2025 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003010;
	bh=bByVB3eFZz3ChERtbjPjYgUzCCYFldGuSuFxTrRGkgE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Pq3bKOm9i4fPKtbkZppBRgIxAd1W85N7EiXpA9c7HcfFcQMWyAoxCWKC3xJNhVL+D
	 4NQUkA6Wkz5HIzByZbJPcnR/6IUGo8/E3FL4lbXPO172GOCKUzfLbJ5Q9XOqQQOZIN
	 RcZaNzwoqJuKnA1s3xyN7sSUAJvXkft0VgqOf9CUxdPCyD7r7k0cwOleUKwf052u70
	 yrNOhbsDbz8Rj4J4BLcMk/KAizyoUHvIIZJQ41TXHG/cb/A/my012IC9cWRpumOd70
	 /hDiqe5HKZ3e1jtyB0AzYvbbT28Z0soWAeVmGYj5kJu1izGsQUvzQglAwbev7KVDz2
	 Pd/5Cu+CPD5VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DBBC87FD3;
	Thu, 31 Jul 2025 23:03:29 +0000 (UTC)
From: Demi Marie Obenour via B4 Relay <devnull+demiobenour.gmail.com@kernel.org>
Date: Thu, 31 Jul 2025 19:03:29 -0400
Subject: [PATCH RFC net] af_unix: allow disabling connections to abstract
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-no-abstract-v1-1-a4e6e23521a3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAED2i2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3bx83cSk4pKixOQSXTMzc6NUi8QUA+NUQyWgjoKi1LTMCrBp0Up
 Bbs4gsbzUEqXY2loAaxSdmmkAAAA=
X-Change-ID: 20250731-no-abstract-6672e8ad03e1
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Demi Marie Obenour <demiobenour@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754003009; l=4404;
 i=demiobenour@gmail.com; s=20250731; h=from:subject:message-id;
 bh=P7P0D821FG7jnQ4Yv8OJFhXxaN7sjGrTD1AHkxfAEfw=;
 b=7rRHXR7v2m3QdnngMduiUvvCOD7xiUK8I0VSnsA1PQXg1x317xH0h1h7Aw1zso3eSG6JCaPHR
 LJ9H4IVrLe9C20Soet8Ggre9zg2ki4UH9APzOL0+LwTZSzFg/5wwDcL
X-Developer-Key: i=demiobenour@gmail.com; a=ed25519;
 pk=4iGY+ynEKxIfs+fIUK9EzsvZ44yGE0GvXLeLTPKKPhI=
X-Endpoint-Received: by B4 Relay for demiobenour@gmail.com/20250731 with
 auth_id=473
X-Original-From: Demi Marie Obenour <demiobenour@gmail.com>
Reply-To: demiobenour@gmail.com

From: Demi Marie Obenour <demiobenour@gmail.com>

Abstract sockets have been a security risk in the past.  Since they
aren't associated with filesystem paths, they bypass all filesystem
access controls.  This means that they can allow file descriptors to be
passed out of sandboxes that do not allow connecting to named sockets.
On systems using the Nix daemon, this allowed privilege escalation to
root, and fixing the bug required Nix to use a complete user-mode
network stack.  Furthermore, anyone can bind to any abstract socket
path, so anyone connecting to an abstract socket has no idea who they
are connecting to.

This allows disabling the security hole by preventing all connections to
abstract sockets.  For compatibility, it is still possible to bind to
abstract socket paths, but such sockets will never receive any
connections or datagrams.

Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
---
 net/unix/Kconfig   | 12 ++++++++++++
 net/unix/af_unix.c | 18 +++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 6f1783c1659b81c3c3c89cb7634a9ce780144f26..c34f222f21b097ce4a735ce02d8ce11fc71bde19 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -16,6 +16,18 @@ config UNIX
 
 	  Say Y unless you know what you are doing.
 
+config UNIX_ABSTRACT
+	bool "UNIX: abstract sockets"
+	depends on UNIX
+	default y
+	help
+	  Support for "abstract" sockets (those not bound to a path).
+	  These have been used in the past, but they can also represent
+	  a security risk because anyone can bind to any abstract
+	  socket.  If you disable this option, programs can still bind
+	  to abstract sockets, but any attempt to connect to one fails
+	  with -ECONNREFUSED.
+
 config	AF_UNIX_OOB
 	bool "UNIX: out-of-bound messages"
 	depends on UNIX
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 52b155123985a18632fc12dc986150e38f2fee70..81d55849dac58e4e68c28ed03a9bc978777cfe4f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -332,7 +332,8 @@ static inline void unix_release_addr(struct unix_address *addr)
  *		- if started by zero, it is abstract name.
  */
 
-static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len)
+static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len,
+			      bool bind)
 {
 	if (addr_len <= offsetof(struct sockaddr_un, sun_path) ||
 	    addr_len > sizeof(*sunaddr))
@@ -341,6 +342,9 @@ static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len)
 	if (sunaddr->sun_family != AF_UNIX)
 		return -EINVAL;
 
+	if (!bind && !IS_ENABLED(CONFIG_UNIX_ABSTRACT) && !sunaddr->sun_path[0])
+		return -ECONNREFUSED; /* pretend nobody is listening */
+
 	return 0;
 }
 
@@ -1253,6 +1257,8 @@ static struct sock *unix_find_other(struct net *net,
 
 	if (sunaddr->sun_path[0])
 		sk = unix_find_bsd(sunaddr, addr_len, type, flags);
+	else if (!IS_ENABLED(CONFIG_UNIX_ABSTRACT))
+		sk = ERR_PTR(-EPERM);
 	else
 		sk = unix_find_abstract(net, sunaddr, addr_len, type);
 
@@ -1444,7 +1450,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	    sunaddr->sun_family == AF_UNIX)
 		return unix_autobind(sk);
 
-	err = unix_validate_addr(sunaddr, addr_len);
+	err = unix_validate_addr(sunaddr, addr_len, true);
 	if (err)
 		return err;
 
@@ -1493,7 +1499,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		goto out;
 
 	if (addr->sa_family != AF_UNSPEC) {
-		err = unix_validate_addr(sunaddr, alen);
+		err = unix_validate_addr(sunaddr, alen, false);
 		if (err)
 			goto out;
 
@@ -1612,7 +1618,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	long timeo;
 	int err;
 
-	err = unix_validate_addr(sunaddr, addr_len);
+	err = unix_validate_addr(sunaddr, addr_len, false);
 	if (err)
 		goto out;
 
@@ -2048,7 +2054,9 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (msg->msg_namelen) {
-		err = unix_validate_addr(msg->msg_name, msg->msg_namelen);
+		err = unix_validate_addr(msg->msg_name,
+					 msg->msg_namelen,
+					 false);
 		if (err)
 			goto out;
 

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250731-no-abstract-6672e8ad03e1

Best regards,
-- 
Demi Marie Obenour <demiobenour@gmail.com>



