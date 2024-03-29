Return-Path: <netdev+bounces-83416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA3892333
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409EDB21687
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B01DA4C;
	Fri, 29 Mar 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JufO63/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885F13777B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736215; cv=none; b=J87PQmsA3/lHr1Tz8ZEZybvR7zriLeTqfWXSUzYhZtXCDraCXW4QK8cLNHj0xrCT7eU2InQY1zr6jpsVO+irpaKzBnzB+NXoKAAJcn0PaZtWGjQD8mF3gezXhxHEw+C0iOsH6gWZCPxRbKxs//4VB3MGHf8MYOuR5FiTZIs3LyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736215; c=relaxed/simple;
	bh=sXz78RV7YN0s8/6a2RonuFVZ/rZy7ZQ35FKJvpkxMj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/sOf0KGCUXCbUIxxJFa5AKbht1PDhVeJqOWaHR7axpEPjAOMDFqvp2Arrj/Ye76/phIOqBcpM35pbnJI9438+xiLLyxRpI+AcHGSXfRd4q80i9YafXGvikIq/T/VZYPNqgK2A++Fv05k+67r14b50rP2KBdVHgmGKjuFb9aPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JufO63/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43BAC433F1;
	Fri, 29 Mar 2024 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711736215;
	bh=sXz78RV7YN0s8/6a2RonuFVZ/rZy7ZQ35FKJvpkxMj4=;
	h=From:To:Cc:Subject:Date:From;
	b=JufO63/UqAlmE4GqVRimRMl+23162+G+1ZPLIJHsP2xUhdqY4zqYgBC3zpUcQub+4
	 VmlTArGr5+mJ8KqCEvAp7cpRlvx8mJ477cuWQ/2y5+xct5lQFaoOGWaDXntAhcddsx
	 X4+k5MBer1oLNArFSAwyxrZjsSO2dSJ5YqMreWPi9iZrmgaIcfy0gFJiI1XaThVEFF
	 EVe8bRkrzFy4yf8ytGz2/b4I6ZETFA8kHRy4EP4smNdN9H2aWuzbKKtDyovqiA3yOC
	 rhL4zHfogdaZNgTW12b/76p4G3pQpWUTkQXdlvi4SrbaLESzxgkOzJE+qfVkfG/lUU
	 /r2cmiEqGmQIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	nicolas.dichtel@6wind.com,
	sdf@google.com
Subject: [PATCH net-next] tools: ynl: add ynl_dump_empty() helper
Date: Fri, 29 Mar 2024 11:16:51 -0700
Message-ID: <20240329181651.319326-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking if dump is empty requires a couple of casts.
Add a convenient wrapper.

Add an example use in the netdev sample, loopback is always
present so an empty dump is an error.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nicolas.dichtel@6wind.com
CC: sdf@google.com
---
 tools/net/ynl/lib/ynl.h        | 12 ++++++++++++
 tools/net/ynl/samples/netdev.c |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 9842e85a8c57..eef7c6324ed4 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -91,6 +91,18 @@ void ynl_sock_destroy(struct ynl_sock *ys);
 	     !ynl_dump_obj_is_last(iter);				\
 	     iter = ynl_dump_obj_next(iter))
 
+/**
+ * ynl_dump_empty() - does the dump have no entries
+ * @dump: pointer to the dump list, as returned by a dump call
+ *
+ * Check if the dump is empty, i.e. contains no objects.
+ * Dump calls return NULL on error, and terminator element if empty.
+ */
+static inline bool ynl_dump_empty(void *dump)
+{
+	return dump == (void *)YNL_LIST_END;
+}
+
 int ynl_subscribe(struct ynl_sock *ys, const char *grp_name);
 int ynl_socket_get_fd(struct ynl_sock *ys);
 int ynl_ntf_check(struct ynl_sock *ys);
diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index 591b90e21890..3e7b29bd55d5 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -100,6 +100,8 @@ int main(int argc, char **argv)
 		if (!devs)
 			goto err_close;
 
+		if (ynl_dump_empty(devs))
+			fprintf(stderr, "Error: no devices reported\n");
 		ynl_dump_foreach(devs, d)
 			netdev_print_device(d, 0);
 		netdev_dev_get_list_free(devs);
-- 
2.44.0


