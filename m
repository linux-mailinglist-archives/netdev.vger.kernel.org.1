Return-Path: <netdev+bounces-158569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A475A12877
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18052168998
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77738160799;
	Wed, 15 Jan 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKzu0dfo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E514658F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957687; cv=none; b=Y9DYnBQ5pgjIaYQJmV8Ya3tXE1cufEuJRCDgsLcZdRdQgSkb921PsJEp/NuJ4pFhFn4xS9yasFsAeTlYXoyvGd7sWhgEBFQXbm5KBq/GRJEIPtfDEgjd/F/PsEhSN29lqcZfXJ1vx7nVO+SOSoY0hkPrDg6eNmx+77O04dShWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957687; c=relaxed/simple;
	bh=LgzyHtJHf2JinoMlPhlfaw49mJRcQeSZJEE5AhHAChc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeCwEIplhIk1gCCDPMfFpw60OWoBkirTgE7dCz0TMhMpecTkDHXx7OqS2ilknRpHbcqE+yiC086sLu9ZI0W+iY8V9wJuUxEp2UNA1C4EpqE0MFfS9Rtf5VMu3X5hSql67dOMUJIqI6o6jQcTpGUqJlJ74ahxt7I+/wf5pt/BsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKzu0dfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75912C4CED1;
	Wed, 15 Jan 2025 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736957686;
	bh=LgzyHtJHf2JinoMlPhlfaw49mJRcQeSZJEE5AhHAChc=;
	h=From:To:Cc:Subject:Date:From;
	b=BKzu0dfo+JQox06gclHgJvZjrae9q8Nz90WiMmaCcu6GtmOlPN9u1i4THrgvRV3Y8
	 iMzgNSahaq87rLp0ssSvqRB99GWdLGsIBftak5IJJdjEKp//eqv3y7ViIV8kDYAuA2
	 2NFy16lhucZcfZo53L5rMOeSW8aTlFOY19rHvjrqUFmhm8EyQk6JzOtGzm64unEvye
	 s+CdWJs1HUqys0oQub4Y7xgjQpqeBS7nz1Fi5wZC3ruM1IQw4m4tavKN9dOrGri55n
	 LA1SYp0N7fxI8GBcEJz4/QWUI195lzk5eU5KiKWu6RQ7B2QPTsQhDYSxI2zcaRnaLY
	 Q3jDsSTZ8lAuw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Li Li <dualli@chromium.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com
Subject: [PATCH net] netdev: avoid CFI problems with sock priv helpers
Date: Wed, 15 Jan 2025 08:14:36 -0800
Message-ID: <20250115161436.648646-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Li Li reports that casting away callback type may cause issues
for CFI. Let's generate a small wrapper for each callback,
to make sure compiler sees the anticipated types.

Reported-by: Li Li <dualli@chromium.org>
Link: https://lore.kernel.org/CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com
Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: almasrymina@google.com
---
 net/core/netdev-genl-gen.c | 14 ++++++++++++--
 tools/net/ynl/ynl-gen-c.py | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index a89cbd8d87c3..996ac6a449eb 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -197,6 +197,16 @@ static const struct genl_multicast_group netdev_nl_mcgrps[] = {
 	[NETDEV_NLGRP_PAGE_POOL] = { "page-pool", },
 };
 
+static void __netdev_nl_sock_priv_init(void *priv)
+{
+	netdev_nl_sock_priv_init(priv);
+}
+
+static void __netdev_nl_sock_priv_destroy(void *priv)
+{
+	netdev_nl_sock_priv_destroy(priv);
+}
+
 struct genl_family netdev_nl_family __ro_after_init = {
 	.name		= NETDEV_FAMILY_NAME,
 	.version	= NETDEV_FAMILY_VERSION,
@@ -208,6 +218,6 @@ struct genl_family netdev_nl_family __ro_after_init = {
 	.mcgrps		= netdev_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
 	.sock_priv_size	= sizeof(struct list_head),
-	.sock_priv_init	= (void *)netdev_nl_sock_priv_init,
-	.sock_priv_destroy = (void *)netdev_nl_sock_priv_destroy,
+	.sock_priv_init	= __netdev_nl_sock_priv_init,
+	.sock_priv_destroy = __netdev_nl_sock_priv_destroy,
 };
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index d8201c4b1520..6750fdb42564 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2384,6 +2384,17 @@ _C_KW = {
     if not kernel_can_gen_family_struct(family):
         return
 
+    if 'sock-priv' in family.kernel_family:
+        # Generate "trampolines" to make CFI happy
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_init",
+                      [f"{family.c_name}_nl_sock_priv_init(priv);"],
+                      ["void *priv"])
+        cw.nl()
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_destroy",
+                      [f"{family.c_name}_nl_sock_priv_destroy(priv);"],
+                      ["void *priv"])
+        cw.nl()
+
     cw.block_start(f"struct genl_family {family.ident_name}_nl_family __ro_after_init =")
     cw.p('.name\t\t= ' + family.fam_key + ',')
     cw.p('.version\t= ' + family.ver_key + ',')
@@ -2401,9 +2412,8 @@ _C_KW = {
         cw.p(f'.n_mcgrps\t= ARRAY_SIZE({family.c_name}_nl_mcgrps),')
     if 'sock-priv' in family.kernel_family:
         cw.p(f'.sock_priv_size\t= sizeof({family.kernel_family["sock-priv"]}),')
-        # Force cast here, actual helpers take pointer to the real type.
-        cw.p(f'.sock_priv_init\t= (void *){family.c_name}_nl_sock_priv_init,')
-        cw.p(f'.sock_priv_destroy = (void *){family.c_name}_nl_sock_priv_destroy,')
+        cw.p(f'.sock_priv_init\t= __{family.c_name}_nl_sock_priv_init,')
+        cw.p(f'.sock_priv_destroy = __{family.c_name}_nl_sock_priv_destroy,')
     cw.block_end(';')
 
 
-- 
2.48.0


