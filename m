Return-Path: <netdev+bounces-182271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D49A885BF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880C07A2CED
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CA289350;
	Mon, 14 Apr 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhUPEjDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97746289345;
	Mon, 14 Apr 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641959; cv=none; b=rvAVrbMwDHqv5VnXCOgrfURvvewi6VB2U+Ik1xD0Y0Fe71gpyMijJJc8t7ny7taFxCYjpYuVgvbTkDuPyO2OQKu61R9GgFz89e0zBkBD7i0HvHK83d2plVAkFZPFHiTcQAk3+CXwcj1BQ+AGgGDyK+kFUjLeGyr6DDXimvbGze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641959; c=relaxed/simple;
	bh=RWMKEsJSPzuLYx/7kTIAtozDlcdMPNgssbNFi3pA2/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1lGCTbiJMsQ1lGFA5xPIchWww5NbqqUIbjH1FfLWtftmBtTw19PwrmpniWC3+PLR6ZiG6NLC4lpx0i/0ymdosuI45sq6oWCRqFN/MqezPLh3HPr+ztMZDsthFAkkM7lRsTNOQ0bmPTIFn5LKmGZjf7yC810AAR1JvpiGgXe/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhUPEjDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB64C4CEE9;
	Mon, 14 Apr 2025 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641959;
	bh=RWMKEsJSPzuLYx/7kTIAtozDlcdMPNgssbNFi3pA2/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NhUPEjDi7Rm7gXSkhKAsj6TMk6RQqpKc4Vg1XzAj+MK3Tl8fyNHRxQO3LMTZRwxar
	 ceJ4+BsPJV4P5cDRnHfCY/u5w0m2yKITjl0MD/kzg9pom6IjllLvlb7oWKpOhpIulW
	 96SwIlCphrV+WTgnpsapbOse4nks3E6BTDW+iufrxbeg6CFFCcnN7SumnYu7sYyhq0
	 oXE9iDYXdbgP9+I1UUfLfpQjTDJLzyYBicdBJedmK4yGKyRelgHSE62PQhzfrBYHHz
	 EM2dfIbogO7IK+gP/zLJyp+VRTjShoeNoJLarv2FszcApEY896Fa2hSphwCetJa4ZM
	 HGLriWRabO6iA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Apr 2025 10:45:48 -0400
Subject: [PATCH 3/4] net: add ref_tracker_dir_debugfs() calls for netns
 refcount tracking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-reftrack-dbgfs-v1-3-f03585832203@kernel.org>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
In-Reply-To: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RWMKEsJSPzuLYx/7kTIAtozDlcdMPNgssbNFi3pA2/k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/R+icrDr2F1lIudHMWk7Ge8BOz9Vax3aXig3N
 gbOXTI9TgCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/0fogAKCRAADmhBGVaC
 FbieEACddz1w+oDatN7I3ozYJDPN7XPvXlNJg81TzzOQPAqcDL6DSpNqtcsFyTB97YRPquhgym7
 oJmlkCWNUzU/5Qt81lEBiU3juPoTE83ObGt9lT5tlgMB23sI5sd8lIf2CcEkS0+NQWfGeOgPinU
 /TZ+7VY43jnF0NTmXqiDBlirhCHKYiUhPgUUa9j+J10GwVCBI+R9W6teKfJCsKRiiV852wHi79n
 vTV2R4WUrlVciL6cd9/oh9KLmt47E7yoeApv7+A/DSB44djBM9j4XHMTohnl65oOWTOWwcVFfyu
 IhWG9SBDFMjmI3O2tB5DG837DtdiM7zQg/Fxp6W9xL+vdFzeLN1P6VW+E2+6LG4NWvFtL/GjpOS
 GVsKLsWo21DEn55QRk0sEfCBm8eAiOVg+Rr4Ui1StqfBnnu0L9wcv8xvwQwttsXHp61lbfMKx4+
 IbShY3vMOakDmLi39PE4z7xO2iDj0HcgW5gRSuL3lSr+MAqtzIGi7sxNnxybK3RzsSSIbyQJge9
 LYgUQcpn1T8G9jHK/bLd6SxPWGdoiAKAk85ZLxWq9qfDuIaVNdPHGUkbjGfB+G2WWuZGSDOA0Cl
 60Q8oWfg2aPDLqpfqq+5GDEsLcfsC86q5LDwsI3glQn77PNVTE05Rps8v5vpP9b2KHf8B+VOSTm
 VaQfcDdX0oYxozQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After assigning the inode number to the namespace, use it to create a
unique name for each netns refcount tracker and register the debugfs
files for them.

The init_net is registered early in the boot process before the
ref_tracker dir is created, so add a late_initcall() to register its
files.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..6ffd8aa05c38512e26572d6eada96a36e4aa1ef3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -761,12 +761,44 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	char name[32];
+	size_t len;
+
+	len = snprintf(name, sizeof(name), "net-%u-refcnt", net->ns.inum);
+	if (len < sizeof(name))
+		ref_tracker_dir_debugfs(&net->refcnt_tracker, name);
+
+	len = snprintf(name, sizeof(name), "net-%u-notrefcnt", net->ns.inum);
+	if (len < sizeof(name))
+		ref_tracker_dir_debugfs(&net->notrefcnt_tracker, name);
+}
+
+static int __init init_net_debugfs(void)
+{
+	net_ns_net_debugfs(&init_net);
+	return 0;
+}
+late_initcall(init_net_debugfs);
+#else
+static void net_ns_net_debugfs(struct net *net)
+{
+}
+#endif
+
 static __net_init int net_ns_net_init(struct net *net)
 {
+	int ret;
+
 #ifdef CONFIG_NET_NS
 	net->ns.ops = &netns_operations;
 #endif
-	return ns_alloc_inum(&net->ns);
+	ret = ns_alloc_inum(&net->ns);
+	if (!ret)
+		net_ns_net_debugfs(net);
+	return ret;
 }
 
 static __net_exit void net_ns_net_exit(struct net *net)

-- 
2.49.0


