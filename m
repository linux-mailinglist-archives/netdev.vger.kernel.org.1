Return-Path: <netdev+bounces-136623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24B9A267E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E621F20FCA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57A1DEFD5;
	Thu, 17 Oct 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8d/GOt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D421DEFD2
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178674; cv=none; b=PdQNGym+Oi1kbW1ha8yjN6BlbxyzjgKF6UHpeUbrxXZEvUxnEYtrvx3CCe1rmdBCocZiBSiPgKM/d/OokTwrMgg//ApYgR4GG+Gqq9QJQhLmn0rhbJ8099NHXJEiXfiSfFVh5clsYOjq3+GltMDZAIKeT7odrgFC7ru83Vbtfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178674; c=relaxed/simple;
	bh=Bb+72Sy2zMBwPYXqRH2QU/V370T/6jS4805nMXZEIAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eL88kJ8fFVm/j9zSzqOFtYPHb/y3FdKvQ6Z0kfftoykNUlboge56PEekhmsAiXiFQ43UbpVs+fWbrDxbi617ZXlXpcbc9KEObX6C4Dkztt3VfDG44n4fjLh9v/XMyc13EQIAVLChACYYxKiFCjnCjTdDnjd0jWGM7WndHrkhD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8d/GOt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056ABC4CEC3;
	Thu, 17 Oct 2024 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729178674;
	bh=Bb+72Sy2zMBwPYXqRH2QU/V370T/6jS4805nMXZEIAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8d/GOt/R+2jirYIgCOBd2ZyvTM8QMC587spTQGMR1kI1rfsS4JkHiZ2ZJgnowQIt
	 ewAaG7wFkjfjGm7GzApZ9bNYTnHrXOQgzUtxZ2ijDKFYUsGuKFDdu9Lk0ASHE01v3U
	 J2cySFGzavavGvIylffcPXo+50nuRdjfOoO/fJV/TpXv2dq0+j3y+WuHk7e55liqK7
	 Syc+34oJfw1iQl3Re9OrOI8vUBy9/JW1qXHfNQM0Yy07al6J15jy0/E9kx+A9zbYS7
	 EbrhlR/SjGo4muRAvWDslkfFa86N+T2y9qzWNcIdtJA3eB9UdeRg35z5FYi89QZOMQ
	 QHLGfSQDXPAwQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: sysctl: allow dump_cpumask to handle higher numbers of CPUs
Date: Thu, 17 Oct 2024 17:24:19 +0200
Message-ID: <20241017152422.487406-4-atenart@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017152422.487406-1-atenart@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the output of rps_default_mask and flow_limit_cpu_bitmap when
the CPU count is > 448, as it was truncated.

The underlying values are actually stored correctly when writing to
these sysctl but displaying them uses a fixed length temporary buffer in
dump_cpumask. This buffer can be too small if the CPU count is > 448.

Fix this by dynamically allocating the buffer in dump_cpumask, using a
guesstimate of what we need.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/sysctl_net_core.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8dc07f7b1772..cb8d32e5c14e 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -51,22 +51,32 @@ int sysctl_devconf_inherit_init_net __read_mostly;
 EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
 
 #if IS_ENABLED(CONFIG_NET_FLOW_LIMIT) || IS_ENABLED(CONFIG_RPS)
-static void dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
-			 struct cpumask *mask)
+static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
+			struct cpumask *mask)
 {
-	char kbuf[128];
+	char *kbuf;
 	int len;
 
 	if (*ppos || !*lenp) {
 		*lenp = 0;
-		return;
+		return 0;
+	}
+
+	/* CPUs are displayed as a hex bitmap + a comma between each groups of 8
+	 * nibbles (except the last one which has a newline instead).
+	 * Guesstimate the buffer size at the group granularity level.
+	 */
+	len = min(DIV_ROUND_UP(nr_cpumask_bits, 32) * (8 + 1), *lenp);
+	kbuf = kmalloc(len, GFP_KERNEL);
+	if (!kbuf) {
+		*lenp = 0;
+		return -ENOMEM;
 	}
 
-	len = min(sizeof(kbuf), *lenp);
 	len = scnprintf(kbuf, len, "%*pb", cpumask_pr_args(mask));
 	if (!len) {
 		*lenp = 0;
-		return;
+		goto free_buf;
 	}
 
 	/* scnprintf writes a trailing null char not counted in the returned
@@ -76,6 +86,10 @@ static void dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 	memcpy(buffer, kbuf, len);
 	*lenp = len;
 	*ppos += len;
+
+free_buf:
+	kfree(kbuf);
+	return 0;
 }
 #endif
 
@@ -119,8 +133,8 @@ static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 		if (err)
 			goto done;
 	} else {
-		dump_cpumask(buffer, lenp, ppos,
-			     net->core.rps_default_mask ? : cpu_none_mask);
+		err = dump_cpumask(buffer, lenp, ppos,
+				   net->core.rps_default_mask ? : cpu_none_mask);
 	}
 
 done:
@@ -249,7 +263,7 @@ static int flow_limit_cpu_sysctl(const struct ctl_table *table, int write,
 		}
 		rcu_read_unlock();
 
-		dump_cpumask(buffer, lenp, ppos, mask);
+		ret = dump_cpumask(buffer, lenp, ppos, mask);
 	}
 
 done:
-- 
2.47.0


