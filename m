Return-Path: <netdev+bounces-283404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNu+M37y9WmVQgIAu9opvQ
	(envelope-from <netdev+bounces-283404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 488574B206B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701883033F8A
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10436C9CB;
	Sat,  2 May 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="TAV5BgKW"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4536CDE0;
	Sat,  2 May 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725883; cv=none; b=qYt9PxnO03bu1U5SQK5VjTI4bJMiuzJAqO02EZVaj4SrWkcBdcRWPOuUc25UFyC4kowOdAGUNw6/D/vnqWA+r2NGkHSMxE9Jag3QBaPgSw9bbbypeZ69B/mlWpXdXcuUGw6rboBQVN0Zjwzc0895GVPWi+YPq+2cBLKU71daGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725883; c=relaxed/simple;
	bh=nuRNqZPXfUnT3q4IoZKNqwhyVL6+3GMw/kEmICQBDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5YU/b8g/Cqx8j/Wdsjg0sUFO2oEEPySP/MRdTgkosUb6OAHUzeUGVWgbbBNOByrepaza0dJXeZNqK/66vNCsgt9AujcC3p6xDrI6A6cDepM0hHC8LaOVTgkf8V1KTH1iO0Loa0/kisIlqWKpHlylafXUdd0ILbCIuLqrC0U4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=TAV5BgKW; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725879; bh=nuRNqZPXfUnT3q4IoZKNqwhyVL6+3GMw/kEmICQBDg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAV5BgKWM0QP84S2vmxrDxn3jbgCJidOwWqnGhsvxYQU8kBdMVfsogGL3ddil4QxN
	 /2NsN1CUdvL5QSzZArWA5xYgo9I7OdRrDb29KG38kfrgkR5Ynu3yfqDQTXY5gYmIT6
	 2sdrbieYQTk/UDSdrOx2mU9l6jHMCAgks24h9fS+DjrLl7V3c9CBOYVlHAwW4q8jOQ
	 XcfHRy4nPDDrc+VVfMnI7KReSjmqq7kS/G7wJo8ssd/9Q/NVX2FCv+nksowsrMyO2b
	 3xiIlRNaLegDHx0kchscnfSErzuYCAvIXzKve3tPUXXnngUijqD1LKOfEKWyA8LN8N
	 hKaV0OlsAevaw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id CAC30125924;
	Sat,  2 May 2026 14:44:39 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 6/7] samples/landlock: Add sandboxer UDP access control
Date: Sat,  2 May 2026 14:43:05 +0200
Message-Id: <20260502124306.3975990-7-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 488574B206B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283404-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[buffet.re:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,buffet.re:email,buffet.re:dkim,buffet.re:mid]

Add environment variables to control associated access rights:
- LL_UDP_BIND
- LL_UDP_CONNECT_SEND

Each one takes a list of ports separated by colons, like other list
options.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 66e56ae275c6..94e399e6b146 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -62,6 +62,8 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
 #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
+#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
+#define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -301,7 +303,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 9
+#define LANDLOCK_ABI_LAST 10
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -324,6 +326,10 @@ static const char help[] =
 	"means an empty list):\n"
 	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
 	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
+	"* " ENV_UDP_BIND_NAME ": local UDP ports allowed to bind (server: "
+	"prepare to receive on port / client: set as source port)\n"
+	"* " ENV_UDP_CONNECT_SEND_NAME ": remote UDP ports allowed to connect "
+	"or sendmsg (client: use as destination port / server: receive only from it)\n"
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
@@ -336,6 +342,7 @@ static const char help[] =
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 	ENV_TCP_BIND_NAME "=\"9418\" "
 	ENV_TCP_CONNECT_NAME "=\"80:443\" "
+	ENV_UDP_CONNECT_SEND_NAME "=\"53\" "
 	ENV_SCOPED_NAME "=\"a:s\" "
 	"%1$s bash -i\n"
 	"\n"
@@ -356,7 +363,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				      LANDLOCK_ACCESS_NET_BIND_UDP |
+				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 	};
@@ -444,6 +453,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
 		ruleset_attr.handled_access_fs &=
 			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+		__attribute__((fallthrough));
+	case 9:
+		/* Removes UDP support for ABI < 10 */
+		ruleset_attr.handled_access_net &=
+			~(LANDLOCK_ACCESS_NET_BIND_UDP |
+			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
@@ -475,6 +491,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
+	/* Removes UDP bind access control if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_BIND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_BIND_UDP;
+	}
+	/* Removes UDP connect/send access control if not supported by a user. */
+	env_port_name = getenv(ENV_UDP_CONNECT_SEND_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
+	}
 
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
@@ -519,6 +547,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
 		goto err_close_ruleset;
 	}
+	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
+		goto err_close_ruleset;
+	}
+	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)) {
+		goto err_close_ruleset;
+	}
 
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
-- 
2.39.5


