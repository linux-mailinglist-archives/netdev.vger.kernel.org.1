Return-Path: <netdev+bounces-183758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4039EA91D7D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B557A7A2F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56024EA86;
	Thu, 17 Apr 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOGQmJYk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8C24E4DB;
	Thu, 17 Apr 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895489; cv=none; b=QAEacbGNB4OTbvDVeSGWdKu9sjgZHLV7CJeE60NCvRu+Zh3PnSiMrZFAL92ocjq/Mp17ET55VbjdKAHuo5ByLx+oLl/YD6uqZDiXi16ivLjrPbxHza2vc3kFuORSLIpOVz/pWkgyUH7ga8U+Sz2sG3tsD2pXBr6/TLoAz7YlsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895489; c=relaxed/simple;
	bh=aWTjfRaEMobezFG2YZ4FN2sK+E4zsG1rhipWv1lxbAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJv0xwn1yJDZQmWWqPYzk+lfRmjtz0LK78a5RipgGWHgOxVKbp8AFzPY1Hm8CR6/QVTYzgJqcWUafhLVs4AOxWBlGMWIjA3EoXI1AERafYXwf/Qk9I91/4oEq8fkmPM29pHNQq69WHrt9tiu5TJTfIXznheauOYdpLv9R5eYeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOGQmJYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB60C4CEF3;
	Thu, 17 Apr 2025 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895489;
	bh=aWTjfRaEMobezFG2YZ4FN2sK+E4zsG1rhipWv1lxbAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LOGQmJYkw6dJ0WI3d0aIK5DU7DHz9bIWVeKDmETU+MvUQvOEX8XJJDuZNDk4MAFTk
	 BTC1FWPVz9RHj6+r7HFhHwIaQo1kbDBJU3jdMggbD2bYUo0DsKEM0Sp1+Pa1hCxtAV
	 vHcIiWJoZx25Oh4eayF1XyQBfRL3ZY1X5XfbzTQ67lW2lTnyP1JBKepUEe0HqWulmA
	 mpUaxoU0mKw9Xy2gIhXdLMV+Yw0CsX9eTd4kggGNNBlTxD+RvcXT84ew9mEjWgMGNL
	 RReGlNNMqGN1CIinuFYhSFyP3cq0W9RuWT6wM847DnUSMa2/1USukJKuQeNNLKyjAt
	 bUq7YicSMrzNQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:10 -0400
Subject: [PATCH v3 7/8] net: add ref_tracker_dir_debugfs() calls for netns
 refcount tracking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-7-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aWTjfRaEMobezFG2YZ4FN2sK+E4zsG1rhipWv1lxbAw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP33wfsZXF9OZOsXYJKn+4XxG4pgmpagfhh0H
 ps4ydpIRryJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99wAKCRAADmhBGVaC
 FYhhD/9tbmIoudXwkXHL3mGnASG0+sRoB+jMVGgDLT7hVec5WGkfL3L001+wgG0tx+EyOcNHHw9
 COc1g47tILUmvuHhohuSGOSiSnp8BiufIfdLeNt6MPvhtGunKuq0+7o56gpioPfYxFsUFpdEBWL
 tORMdzIuL3M7aDtjKrolimdjYPqLf2yfXr/iWdnNnsBTdj9FfASYDB8ZX35jh/q851+jtF0H8f4
 0RvOde9hR/dmapZxdOUFn8RWtc+3xUGixKFPIxOzQnfriN2RyYEqcOMtMwqjLOibimpqIc4HpPN
 GBBfOcLS8P3XUn/IH+LT6FUKKCztj3V/5XsJlOLlz2CEz6jxG0jMDF+xnrNltETbmp6JVuL8o9F
 J/FfHdKzDXJlchcyMsXFYsstMSv2eCzduBv2iZh0Xnm6H9CNEAn6LEiJV4RtFRTbkYbOyD2ZrOa
 PAJniIhr7ZW+B4BaeWoJj7JMCLEfd/XZX/FMPdGESLeseVRwtGb7NgB6YjtK3WLoy46/HgWq2I/
 2lua6HrkrMX4wbKBIkfvo1tgyN6ZkrmLJtpYS9faEauxpuosg6jqPx3z+zbnE4zbtLIl7XgXzGM
 7j/VFPd1RMQ+kZjQE1hElS3KJWjPYI8HGmfzehlV/KYzUoWx/oUWFcvtc7wJHe4N+d5eczntjbU
 aDBY1V75yiU8tXQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After assigning the inode number to the namespace, use it to create a
unique name for each netns refcount tracker and register the debugfs
files for them.

init_net is registered before the ref_tracker dir is created, so add a
late_initcall() to register its files.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..cc8c3543e79b2b6948fdbe4080639e3dfbabda15 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -761,12 +761,44 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	char name[REF_TRACKER_NAMESZ];
+	size_t len;
+
+	len = snprintf(name, sizeof(name), "netns-%u-refcnt", net->ns.inum);
+	if (len < sizeof(name))
+		ref_tracker_dir_debugfs(&net->refcnt_tracker, name);
+
+	len = snprintf(name, sizeof(name), "netns-%u-notrefcnt", net->ns.inum);
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


