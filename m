Return-Path: <netdev+bounces-244516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE4CB9474
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED42C3015AEC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26332D0C85;
	Fri, 12 Dec 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="mt/w5gZe"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BB2C21E6;
	Fri, 12 Dec 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557436; cv=none; b=G1yFpC9Mc1bDDDhZ/pTTjKKtLZvW+QKKjc5BwLStF+FqUmA2RbYHzGKj4FPiI5bb5LSZ8uFVj6z0D8CfRjpBOGsa8yjXJ3QvecNeQoTzpab86S1fIX+2qEuzm4W5t9+pa5h/XJ+KZUTpwOsl/CxAKCohP8xdJtOKmt7MneefgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557436; c=relaxed/simple;
	bh=Q7paCjt5WnYK7reLsmlgS7AbkEADAxbmP1l9toeW76c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCxQh4WapbKBFR7+X7TUqseBU9SnR7Yfe2LvXjp/0Px6l1BE2VBeY6NgZMVlpJBw2nMJYVnWK6kt8unGeiyxRRPyumGsj0zK3QyF416bhj3lI6zM17rMdxsg70zxJXtqz18k7Y7GrCq/tU5HQIq5E82FQCoIq+smFlyGlCq2Ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=mt/w5gZe; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557432; bh=Q7paCjt5WnYK7reLsmlgS7AbkEADAxbmP1l9toeW76c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt/w5gZeFntq4Z662Ltci0FVo/4mxbiAIIS/xD0hoOUWWVs8RpMzZ/w3lRCOHmywG
	 NU99sMOWYQMVjO2zf9hynyebp4K0YBflvyp6IzKO7jW2LdOFa0WJ+grhP2beQPSxml
	 XYB0h7RdSYo4pP/fleMMRl/fiuviSSYrFJ0iwwEmcTb0bsIrPZuxsm4b1eiqCNiAga
	 D6ywnZtY6nfkZ0Wdeec2YkOwl7c4/73LbfZGeyeSQCjpYQpwoKvKu7pGsmN6SmWepl
	 0Iz0JFhShkLcHXSfP6KF0Aaun7PugaKg2i6xW2ngQHKlosHWA2EkhFMzwu8SQCbVX0
	 kbKWEf2QVHzSw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id B65A9125492;
	Fri, 12 Dec 2025 17:37:11 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 7/8] samples/landlock: Add sandboxer UDP access control
Date: Fri, 12 Dec 2025 17:37:03 +0100
Message-Id: <20251212163704.142301-8-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add environment variables to control associated access rights:
- LL_UDP_BIND
- LL_UDP_CONNECT
- LL_UDP_SENDTO

Each one takes a list of ports separated by colons, like other list
options.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 58 ++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..65accc095926 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -62,6 +62,9 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
+#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
+#define ENV_UDP_CONNECT_NAME "LL_UDP_CONNECT"
+#define ENV_UDP_SENDTO_NAME "LL_UDP_SENDTO"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -299,7 +302,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 7
+#define LANDLOCK_ABI_LAST 8
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -322,6 +325,12 @@ static const char help[] =
 	"means an empty list):\n"
 	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
 	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
+	"* " ENV_UDP_BIND_NAME ": local UDP ports allowed to bind (server: "
+	"prepare to receive on port / client: set as source port)\n"
+	"* " ENV_UDP_CONNECT_NAME ": remote UDP ports allowed to connect "
+	"(client: set as destination port / server: receive only from it)\n"
+	"* " ENV_UDP_SENDTO_NAME ": remote UDP ports allowed to send to "
+	"without prior connect()\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -334,6 +343,8 @@ static const char help[] =
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
+	ENV_UDP_CONNECT_NAME "=\"53\" "
+	ENV_UDP_SENDTO_NAME "=\"53\" "
 	ENV_SCOPED_NAME "=\"a:s\" "
 	"%1$s bash -i\n"
 	"\n"
@@ -354,7 +365,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
@@ -436,6 +450,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7 */
 		supported_restrict_flags &=
 			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+		__attribute__((fallthrough));
+	case 7:
+		/* Removes UDP support for ABI < 8 */
+		ruleset_attr.handled_access_net &=
+			~(LANDLOCK_ACCESS_NET_BIND_UDP |
+			  LANDLOCK_ACCESS_NET_CONNECT_UDP |
+			  LANDLOCK_ACCESS_NET_SENDTO_UDP);
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -468,6 +489,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
+	/* Removes UDP bind access control if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_BIND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_BIND_UDP;
+	}
+	/* Removes UDP connect access control if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_CONNECT_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_CONNECT_UDP;
+	}
+	/*
+	 * Removes UDP send with explicit address access control if not
+	 * supported by a user.
+	 */
+	env_port_name = getenv(ENV_UDP_SENDTO_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_SENDTO_UDP;
+	}
 
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
@@ -512,6 +554,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
2.47.3


