Return-Path: <netdev+bounces-128525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2C97A221
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B070B24716
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6B156222;
	Mon, 16 Sep 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="opagS1JT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EA155751;
	Mon, 16 Sep 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489409; cv=none; b=fg/LfY+V9s/LhNCLkZ2NSih0XQLV73a35PjBG3g81eSBJoLVD2fYcO6GDK1j1HCCJNgEqO6WN6TpLyg4q9XDtaBc+xywLOi39EShZ7BsWn35aMeBWmA3vkt0unLiMWsONvJF0LjhjB8j6SRFBJ8/R1CV5bwNdBfgkMB2y+tEK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489409; c=relaxed/simple;
	bh=CjTRx2HNWouo/bwM47cNCn6ksq2RYj1shLQSdSTGFC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaY9FHEkHxwwYLJ8CLGugyuuEXcB39j2EtGWSA4VjcWY8qvnszQsQ4ioj7JbMfdkLyMQPz8nQInkQ8DB44P7kiLuxAW4WaKLTiQXjh9/lKenVbdceP/rtWmxD/0N8nsMYTmwo5fF4EAVOBE2iS99IaLngkDpk4tX8uRZNNz4Ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=opagS1JT; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489399; bh=CjTRx2HNWouo/bwM47cNCn6ksq2RYj1shLQSdSTGFC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opagS1JTwYBaTM71XSxbhmdpgUXdHxTMAMTBCEcjUtWpm6/7r1aasjg9znB1YSYZO
	 W92w1wiVXrhwCNLYdZf5OwevjTKAHj69bZqThv4iY7qY9oLuS7LacnWcJEo5vn0qkU
	 KmrAHWRDtJ3xNvZyhPjcG1dB/wHye5zB9fanLttkhWB3jDLgNB32XSm+vZ74tNHVhc
	 t2pyaNO2E4I+ByUMXiz4jb7AqXWGkoO8YQVg7USZJiadB0zMYgU2z2ptAV0xOuDXzB
	 qt/2/cjzuw95qib1q0tRqnQ5qE2QAuC/r/2jThQNLBWgxfG/LuRlYj8rooQGEtMjKM
	 wa5n3FEAQdHyQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 57FC91230C2;
	Mon, 16 Sep 2024 14:23:19 +0200 (CEST)
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
Subject: [RFC PATCH v1 2/7] samples/landlock: Clarify option parsing behaviour
Date: Mon, 16 Sep 2024 14:22:25 +0200
Message-Id: <20240916122230.114800-3-matthieu@buffet.re>
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

- Clarify which environment variables are optional, which ones are
  mandatory
- Clarify the difference between unset variables and empty ones
- Move the (larger) help message to a helper function

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 samples/landlock/sandboxer.c | 86 ++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index a84ae3a15482..08704504dc51 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -221,6 +221,53 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 #define LANDLOCK_ABI_LAST 5
 
+static void print_help(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s=\"...\" %s=\"...\" [other environment variables] %s "
+		"<cmd> [args]...\n\n",
+		ENV_FS_RO_NAME, ENV_FS_RW_NAME, prog);
+	fprintf(stderr,
+		"Execute a command in a restricted environment.\n\n");
+	fprintf(stderr,
+		"Environment variables containing paths and ports "
+		"can be multi-valued, with a colon delimiter.\n"
+		"\n"
+		"Mandatory settings:\n");
+	fprintf(stderr,
+		"* %s: list of paths allowed to be used in a read-only way.\n",
+		ENV_FS_RO_NAME);
+	fprintf(stderr,
+		"* %s: list of paths allowed to be used in a read-write way.\n",
+		ENV_FS_RW_NAME);
+	fprintf(stderr,
+		"\n"
+		"Optional settings (when not set, their associated access "
+		"check is always allowed) (for lists, an empty string means "
+		"to allow nothing, e.g. %s=\"\"):\n",
+		ENV_TCP_BIND_NAME);
+	fprintf(stderr,
+		"* %s: list of ports allowed to bind (server).\n",
+		ENV_TCP_BIND_NAME);
+	fprintf(stderr,
+		"* %s: list of ports allowed to connect (client).\n",
+		ENV_TCP_CONNECT_NAME);
+	fprintf(stderr,
+		"\n"
+		"Example:\n"
+		"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
+		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+		"%s=\"9418\" "
+		"%s=\"80:443\" "
+		"%s bash -i\n\n",
+		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
+		ENV_TCP_CONNECT_NAME, prog);
+	fprintf(stderr,
+		"This sandboxer can use Landlock features "
+		"up to ABI version %d.\n",
+		LANDLOCK_ABI_LAST);
+}
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
@@ -237,44 +284,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	};
 
 	if (argc < 2) {
-		fprintf(stderr,
-			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
-			"<cmd> [args]...\n\n",
-			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
-		fprintf(stderr,
-			"Execute a command in a restricted environment.\n\n");
-		fprintf(stderr,
-			"Environment variables containing paths and ports "
-			"each separated by a colon:\n");
-		fprintf(stderr,
-			"* %s: list of paths allowed to be used in a read-only way.\n",
-			ENV_FS_RO_NAME);
-		fprintf(stderr,
-			"* %s: list of paths allowed to be used in a read-write way.\n\n",
-			ENV_FS_RW_NAME);
-		fprintf(stderr,
-			"Environment variables containing ports are optional "
-			"and could be skipped.\n");
-		fprintf(stderr,
-			"* %s: list of ports allowed to bind (server).\n",
-			ENV_TCP_BIND_NAME);
-		fprintf(stderr,
-			"* %s: list of ports allowed to connect (client).\n",
-			ENV_TCP_CONNECT_NAME);
-		fprintf(stderr,
-			"\nexample:\n"
-			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
-			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
-			"%s=\"9418\" "
-			"%s=\"80:443\" "
-			"%s bash -i\n\n",
-			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
-		fprintf(stderr,
-			"This sandboxer can use Landlock features "
-			"up to ABI version %d.\n",
-			LANDLOCK_ABI_LAST);
+		print_help(argv[0]);
 		return 1;
 	}
 
-- 
2.39.5


