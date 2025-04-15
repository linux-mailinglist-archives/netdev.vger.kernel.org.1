Return-Path: <netdev+bounces-182963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D6A8A738
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D09443DA3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DA239072;
	Tue, 15 Apr 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCrQSAEK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DC238D45;
	Tue, 15 Apr 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743028; cv=none; b=h/0atHOuGjagDbzEjqkChqaRJhIQ04/1VDNggvye9m0bFRKOGx9pF1W3e4krpxP1bxz1GspotDtFaJQNLbg/CZMMjuaHGHjlgFLhfHDjXzeVpEC5gwDGXk9SKHPlcWfrG5mzOj3JLo2oiQkY/be2BK7CNwVaV7eQk8wMFIdiMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743028; c=relaxed/simple;
	bh=i96Kyrg01izSj1tfm721taG9uBhVOrp8C74DnVe2tRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRn2Ttnu+k7FmUQwZGys8AiEnD0qXGDpovp5VZhpyd33xhakwgNQiXvtnW2vBhs9+/XCkPssm8ww5Pek4/ojQFWNRYtRWHzsfLpnjH1ziXIsQa5m9yACHyj8OwGqVvqeU2dWGbwt97lXz2nNWD+4CG15fcZjLJbOVDac40iIx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCrQSAEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B53C4CEF0;
	Tue, 15 Apr 2025 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743027;
	bh=i96Kyrg01izSj1tfm721taG9uBhVOrp8C74DnVe2tRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MCrQSAEKMtZ4BFC4CzgKRH3Kiv2Y0+KgoKyYvzwHdKcrSED0OTtY48wdLQygmdo5D
	 tMxBl933QsVBSutVfivfwp05hujsmARFi22dPQaxjTXmWl7t/odlOW8qV/cFo35sEN
	 mGf27JpGo4+msI2oOGAyGMxnzgaGUYAskNnmmva0zFUoQMVo+gIG264vG34jqvi3XY
	 M4f7jKwbZWHW8gkoqrKuB2s70t94x7VhdanoU7t5EWYbAODRdUOALSCt6AZe4fFNBi
	 UW3fmN57MmQDXDivIlnymPWpCUVkzzEb2MR5EL1SMp3y9rUeAr01079l3B/qzDGxlS
	 kHUDMDDSTkUJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:44 -0400
Subject: [PATCH v2 6/8] net: add ref_tracker_dir_debugfs() calls for netns
 refcount tracking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-6-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=i96Kyrg01izSj1tfm721taG9uBhVOrp8C74DnVe2tRA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qppbntLmbDxuB2097U+Q5euUqeIkoi/TdyB5
 FfsC4m6goOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaQAKCRAADmhBGVaC
 FSd9D/9CVyT8Q/Fp/vhtuyXenjQmxmD4fXzq1DXoOlSgFIlUgKQ2ibZzWyRwusZB2X/hC1p3p8s
 7OSSeEUPl8CCZwMXygiS0MLDphCj7dIPEMKF0Wjl93L1CNMzPYfv8nz73TM9TLdlfE72/qW0KD8
 xWBob+t6r5MqE9JtqQOdJo5Fa6EAvxTfJ4ist22yAFVR9nNqr53KkyadY25dTDWc5SzNaa6dQa9
 ul53LeBkaoi2Gn6zwNQfAaT6mOn6TdRrKiCaMFoK6pEPWW/m9LSa6G5KqtHAowH6rCr2y1e8J4m
 J5NLU5JD8TUn3o+l0vQQev79InxG1Y+Kdm4Lcsz3QXUmhh3lfnLxhoKDg+6NSpdqj3iqjUhw/eK
 D1K/LmIKP3aOanKhBYTj8+dLn3MQY0QI0EMFTsEkVF3P6HSy7kytigxf7pFNtiH3l0YtUTmA4N5
 DqGIWT+M7kwI+VADcLaYXtvJFK3PgpdpyW521TW01Kr2scqwl0A0phtS9OhtJgAFhh6YVEanduQ
 WWitmNVI0EAqlVtP4Z69yhwfvW9l3oeFedI8Y6DzwFYosw152TIaCUFZQJbd0ZMzRqvuNaHH5OZ
 gj6zll4egL01sD74Jfb601ZbZybD8dCLWPORLngFsKG00bze8AwdrwswkWPSQkrBGU5u1qxwB3N
 c6pUbgN4MfL5OAA==
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
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..f636eb9b8eba28114fd192d64bcd359a25381988 100644
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


