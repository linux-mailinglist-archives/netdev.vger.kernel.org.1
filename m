Return-Path: <netdev+bounces-128529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2A97A230
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71B71C21CCC
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA2446D1;
	Mon, 16 Sep 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="VsiK27BF"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC1155725;
	Mon, 16 Sep 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489462; cv=none; b=kitsi/0CMOs7phbj56vW7rr08URQAhLC9eIbrvWy1IjEXcrWEZv8Nse6Xg6iDBQ9jJr6i5WHCwBT4HPVKiXSFayM6HFM/ps3ZH/YJ+8yTVL/fEHw27mqwOjqFUNVEH7qBgkdaS1HqnfEiiFKKv7xEnA0ykJG35SpLiULY+mklQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489462; c=relaxed/simple;
	bh=tpOsQZQ8mh9RaxpihYmNS8rVEi4wnjTApVCvw9uhEnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cnxq5vI8U6mxdkr8BEMjC316inlXksN278D0FMgjmDrHufnPEz2sjpnOvH4TRbf/egCKOotZzqAYUwzi/cSdNy4fh8MIvYbE5BBV7CY8+ZxGfsxfnV01daX4GYfNex5doPxZKxuq7vMe/ytb1TVQ8XlKaEn8YSj2ey+/zC3C60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=VsiK27BF; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489453; bh=tpOsQZQ8mh9RaxpihYmNS8rVEi4wnjTApVCvw9uhEnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsiK27BFYBAtCoBYCQMrSi3foOZTBHFDQqISIc6y6wtoewjE3hNF6KNSmNkWqxao2
	 Rg+T9mIpn0j2uGKlsl7wr9JDJ8dmMOD+qAY/PqHOtLPRo4sBGNEVI+Z4HExZgJiCw/
	 Hfm1Q08Ea4vDuMOD6r08l3767ogjII6lTIVVvnaKx27EhhR6aD9SEG07lgIzAYMuWL
	 SaNJRX+wv2+RvZ7HPjK8rX56plxG3+qONTZWJIgPNe6X7FqVIlEuYN1TsTg3uXj69g
	 bsmjQ+fUz0GTUA5Cf+NvXLL6uOg5mii7c4ZF91n5iol2i2E+5MJ834pNXBrHS0cPuh
	 qQP3c0e21nH/Q==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id ECE471230C2;
	Mon, 16 Sep 2024 14:24:12 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 5/7] samples/landlock: Add sandboxer UDP access control
Date: Mon, 16 Sep 2024 14:22:28 +0200
Message-Id: <20240916122230.114800-6-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240916122230.114800-1-matthieu@buffet.re>
References: <20240916122230.114800-1-matthieu@buffet.re>
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
- LL_UDP_RECVMSG
- LL_UDP_SENDMSG

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 88 ++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08704504dc51..dadd30dad712 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -55,6 +55,10 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
+#define ENV_UDP_CONNECT_NAME "LL_UDP_CONNECT"
+#define ENV_UDP_RECVMSG_NAME "LL_UDP_RECVMSG"
+#define ENV_UDP_SENDMSG_NAME "LL_UDP_SENDMSG"
 #define ENV_DELIMITER ":"
 
 static int parse_path(char *env_path, const char ***const path_list)
@@ -219,7 +223,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 static void print_help(const char *prog)
 {
@@ -247,11 +251,25 @@ static void print_help(const char *prog)
 		"to allow nothing, e.g. %s=\"\"):\n",
 		ENV_TCP_BIND_NAME);
 	fprintf(stderr,
-		"* %s: list of ports allowed to bind (server).\n",
+		"* %s: list of TCP ports allowed to bind (server)\n",
 		ENV_TCP_BIND_NAME);
 	fprintf(stderr,
-		"* %s: list of ports allowed to connect (client).\n",
+		"* %s: list of TCP ports allowed to connect (client)\n",
 		ENV_TCP_CONNECT_NAME);
+	fprintf(stderr,
+		"* %s: list of UDP ports allowed to bind (client: set as "
+		"source port/server: listen on port)\n",
+		ENV_UDP_BIND_NAME);
+	fprintf(stderr,
+		"* %s: list of UDP ports allowed to connect (client: set as "
+		"destination port/server: only receive from one client)\n",
+		ENV_UDP_CONNECT_NAME);
+	fprintf(stderr,
+		"* %s: list of UDP ports allowed to send to (client/server)\n",
+		ENV_UDP_SENDMSG_NAME);
+	fprintf(stderr,
+		"* %s: list of UDP ports allowed to recv from (client/server)\n",
+		ENV_UDP_RECVMSG_NAME);
 	fprintf(stderr,
 		"\n"
 		"Example:\n"
@@ -259,9 +277,12 @@ static void print_help(const char *prog)
 		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 		"%s=\"9418\" "
 		"%s=\"80:443\" "
+		"%s=\"0\" "
+		"%s=\"53\" "
 		"%s bash -i\n\n",
 		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-		ENV_TCP_CONNECT_NAME, prog);
+		ENV_TCP_CONNECT_NAME, ENV_UDP_RECVMSG_NAME,
+		ENV_UDP_SENDMSG_NAME, prog);
 	fprintf(stderr,
 		"This sandboxer can use Landlock features "
 		"up to ABI version %d.\n",
@@ -280,7 +301,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				      LANDLOCK_ACCESS_NET_BIND_UDP |
+				      LANDLOCK_ACCESS_NET_CONNECT_UDP |
+				      LANDLOCK_ACCESS_NET_RECVMSG_UDP |
+				      LANDLOCK_ACCESS_NET_SENDMSG_UDP,
 	};
 
 	if (argc < 2) {
@@ -354,6 +379,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			"provided by ABI version %d (instead of %d).\n",
 			LANDLOCK_ABI_LAST, abi);
 		__attribute__((fallthrough));
+	case 5:
+		/* Removes UDP support for ABI < 6 */
+		ruleset_attr.handled_access_net &=
+			~(LANDLOCK_ACCESS_NET_BIND_UDP |
+			  LANDLOCK_ACCESS_NET_CONNECT_UDP |
+			  LANDLOCK_ACCESS_NET_RECVMSG_UDP |
+			  LANDLOCK_ACCESS_NET_SENDMSG_UDP);
+		__attribute__((fallthrough));
 	case LANDLOCK_ABI_LAST:
 		break;
 	default:
@@ -366,18 +399,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	access_fs_ro &= ruleset_attr.handled_access_fs;
 	access_fs_rw &= ruleset_attr.handled_access_fs;
 
-	/* Removes bind access attribute if not supported by a user. */
+	/* Removes TCP bind access attribute if not supported by a user. */
 	env_port_name = getenv(ENV_TCP_BIND_NAME);
 	if (!env_port_name) {
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_BIND_TCP;
 	}
-	/* Removes connect access attribute if not supported by a user. */
+	/* Removes TCP connect access attribute if not supported by a user. */
 	env_port_name = getenv(ENV_TCP_CONNECT_NAME);
 	if (!env_port_name) {
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
+	/* Removes UDP bind access attribute if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_BIND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_BIND_UDP;
+	}
+	/* Removes UDP bind access attribute if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_CONNECT_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_CONNECT_UDP;
+	}
+	/* Removes UDP recv access attribute if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_RECVMSG_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_RECVMSG_UDP;
+	}
+	/* Removes UDP send access attribute if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_SENDMSG_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_SENDMSG_UDP;
+	}
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
@@ -392,7 +449,6 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
 		goto err_close_ruleset;
 	}
-
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
 		goto err_close_ruleset;
@@ -401,6 +457,22 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
+	if (populate_ruleset_net(ENV_UDP_RECVMSG_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_RECVMSG_UDP)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_net(ENV_UDP_SENDMSG_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_SENDMSG_UDP)) {
+		goto err_close_ruleset;
+	}
 
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
-- 
2.39.5


