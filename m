Return-Path: <netdev+bounces-151965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF59F2067
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFABE1671CB
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06C194C61;
	Sat, 14 Dec 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="RAvU4f7c"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC44C70;
	Sat, 14 Dec 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202040; cv=none; b=R+1f84D6BX2F4dad6wrD5IJAXjTgM3aNrDLXtP9+ukav2soF09U8Qoi97RfRYwDglGi3Bf/bc9/nY0VKA21sicVIx5pUZx4TTjtCMdXhd/iYXkpcbNqIAT82/Wc0tGrRej7ylsEthMAbUCIBMyLuX3WKvHr/ecfqA8IAcn0+6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202040; c=relaxed/simple;
	bh=c3c8i9vxt/J1hI9IcvbUCco0t0yoUSHvZM/nsz58PHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBZDH4T+d73ZzBhlwvS/4vtNYPyyel3ru4sJxiuOiWcDjMfbKpunJY1hjayiJX9G1f7140RYTCjHFpS6oyE7Wpw9pPhnLK8Bb39PN9LiAMdLv89UfY+M0rEQvebznhpP0t4UFPtUXb/ITToPKCRYWk0A7MEXJSGbHIStpS9AKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=RAvU4f7c; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734202036; bh=c3c8i9vxt/J1hI9IcvbUCco0t0yoUSHvZM/nsz58PHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAvU4f7cSGgeT2TMJe/V9BOOAsGlQiCCRuW+xip10mYyBZEAy/NrRH2BvngFQTfDX
	 j3ph4fCTkU3A3Xt2CXQvWbxYCkpzFXe8lY/fe4FPr0Ztabht+lH90s5oCuVvcXwU7p
	 6UFLNtwy4i8ZvaxN8qYTdVJhNtfox1z2ZyftTqVeqlmFWvs/ajNageDBhFZOfWhk3f
	 mNmBm8VvEH1LbTJ/3QGSt5HW2rMdSgGLFFPVmL8jhVA/M5SVpREEYF+uk2Y7fkBD/F
	 qLii6ZVGhVywvrIrsaPft9GY/8ya7WlTJzND64zDX/DxjIlPOZWNtB4ZPw3Z1469d5
	 xy9R75vnxhQ8g==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 6C1051252E8;
	Sat, 14 Dec 2024 19:47:16 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: Mickael Salaun <mic@digikod.net>
Cc: Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 5/6] samples/landlock: Add sandboxer UDP access control
Date: Sat, 14 Dec 2024 19:45:39 +0100
Message-Id: <20241214184540.3835222-6-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241214184540.3835222-1-matthieu@buffet.re>
References: <20241214184540.3835222-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add environment variables to control associated access rights:
(each one takes a list of ports separated by colons, like other
list options)

- LL_UDP_BIND
- LL_UDP_CONNECT
- LL_UDP_SENDTO

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 58 ++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..61dc2645371e 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,9 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
+#define ENV_UDP_CONNECT_NAME "LL_UDP_CONNECT"
+#define ENV_UDP_SENDTO_NAME "LL_UDP_SENDTO"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -288,7 +291,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 6
+#define LANDLOCK_ABI_LAST 7
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -311,6 +314,11 @@ static const char help[] =
 	"means an empty list):\n"
 	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
 	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
+	"* " ENV_UDP_BIND_NAME ": UDP ports allowed to bind (client: set as "
+	"source port / server: prepare to listen on port)\n"
+	"* " ENV_UDP_CONNECT_NAME ": UDP ports allowed to connect (client: "
+	"set as destination port / server: only receive from one client)\n"
+	"* " ENV_UDP_SENDTO_NAME ": UDP ports allowed to send to (client/server)\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -320,6 +328,8 @@ static const char help[] =
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
+	ENV_UDP_CONNECT_NAME "=\"53\" "
+	ENV_UDP_SENDTO_NAME "=\"53\" "
 	ENV_SCOPED_NAME "=\"a:s\" "
 	"%1$s bash -i\n"
 	"\n"
@@ -340,7 +350,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				      LANDLOCK_ACCESS_NET_BIND_UDP |
+				      LANDLOCK_ACCESS_NET_CONNECT_UDP |
+				      LANDLOCK_ACCESS_NET_SENDTO_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 	};
@@ -415,6 +428,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes UDP support for ABI < 7 */
+		ruleset_attr.handled_access_fs &=
+			~(LANDLOCK_ACCESS_NET_BIND_UDP |
+			  LANDLOCK_ACCESS_NET_CONNECT_UDP |
+			  LANDLOCK_ACCESS_NET_SENDTO_UDP);
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -445,6 +466,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
+	/* Removes UDP bind access control if not supported by a user */
+	env_port_name = getenv(ENV_UDP_BIND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_BIND_UDP;
+	}
+	/* Removes UDP connect access control if not supported by a user */
+	env_port_name = getenv(ENV_UDP_CONNECT_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_CONNECT_UDP;
+	}
+	/*
+	 * Removes UDP sendmsg(addr != NULL) access control if not
+	 * supported by a user
+	 */
+	env_port_name = getenv(ENV_UDP_SENDTO_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_SENDTO_UDP;
+	}
 
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
@@ -471,6 +513,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
 		goto err_close_ruleset;
 	}
+	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_net(ENV_UDP_CONNECT_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_CONNECT_UDP)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_net(ENV_UDP_SENDTO_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_SENDTO_UDP)) {
+		goto err_close_ruleset;
+	}
 
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
-- 
2.39.5


