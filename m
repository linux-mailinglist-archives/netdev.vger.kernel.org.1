Return-Path: <netdev+bounces-163367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA7A2A04E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282D67A3C86
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695772253E9;
	Thu,  6 Feb 2025 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ANfgefCf"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B102248A0;
	Thu,  6 Feb 2025 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820801; cv=none; b=LXm0ZwQa+KhbRl2mZeWRE9ewqpKslNgKZUtshBu/FsbCqeu5wuuzUe00bsabpRBq1KK69lWxFitDwowRjpRkhzP/TrRQQ55pjxUXzkcmqgheZ7pHBR3/r5lp3YIEvRGLQCHsCtJm47KBjUlJocZp0l1HdW3T+2sxvmwNRa++t5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820801; c=relaxed/simple;
	bh=UuUMuBAxmaaA9ODzyfCc1LG6fzSGQOP/4NGSDrfvQzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJUKnRprP7I+Y8Z7wzM3ua596H9MPiLmYs0UU+Eg/5CAiBfZ0KQ+H6dxi3BMLRMHsLcFAKhN2Dn9SWsE4o3GFPWqYT10ksfXNZO/4TFROsL6qn3+cxpkEG0vkH8ZIXoUuBXNxS+gCOq5gksvtTjBw91eHFvOilcRXOZfb2CEvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ANfgefCf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ivQkA
	lP9eA/Lpn22LOFvP6SLgOnTGtAKhz5Ti7LeVGo=; b=ANfgefCfoU75AutUU7+LC
	9EQupM2JOtFEBH3roX17UR+SLSAhx/OUbZ0Nz6hI6QBjPZKKbzCNWw3vzMhVK8gw
	3fGPOXmdXU0B1fPT5qekHrCScnWQJvEV/3YE6NYjgI6kB7uhOQ9jn55Uh9QoIODf
	dGxNe/FDkEsZaVFiN6CcEc=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAn_uJ7TKRn6jjdJw--.36629S2;
	Thu, 06 Feb 2025 13:45:32 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
Date: Thu,  6 Feb 2025 13:44:51 +0800
Message-Id: <20250206054451.4070941-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn_uJ7TKRn6jjdJw--.36629S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFykJw18JFyxKrW7WFykXwb_yoW5ZFWxpF
	W3K34DZrs5JFsrur4xJa1rCrs3ta1rtFyUGFZ2g3WSvFsxWr4xZF1kKFWjva4DGrW8tay3
	JF4jgr4jva4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbkuxUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNhjrIGekLSi1UgABsF

From: Liang Jie <liangjie@lixiang.com>

Refines autobind identifier length for UNIX pathname sockets, addressing
issues of memory waste and code readability.

The previous implementation in the unix_autobind function of UNIX pathname
sockets used hardcoded values such as 16 and 6 for memory allocation and
setting the length of the autobind identifier, which was not only
inflexible but also led to reduced code clarity. Additionally, allocating
16 bytes of memory for the autobind path was excessive, given that only 6
bytes were ultimately used.

To mitigate these issues, introduces the following changes:
 - A new macro UNIX_AUTOBIND_LEN is defined to clearly represent the total
   length of the autobind identifier, which improves code readability and
   maintainability. It is set to 6 bytes to accommodate the unique autobind
   process identifier.
 - Memory allocation for the autobind path is now precisely based on
   UNIX_AUTOBIND_LEN, thereby preventing memory waste.
 - To avoid buffer overflow and ensure that only the intended number of
   bytes are written, sprintf is replaced by snprintf with the proper
   buffer size set explicitly.

The modifications result in a leaner memory footprint and elevated code
quality, ensuring that the functional aspect of autobind behavior in UNIX
pathname sockets remains intact.

Signed-off-by: Liang Jie <liangjie@lixiang.com>
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---

Changes in v2:
 - Removed the comments describing AUTOBIND_LEN.
 - Renamed the macro AUTOBIND_LEN to UNIX_AUTOBIND_LEN for clarity and
   specificity.
 - Corrected the buffer length in snprintf to prevent potential buffer
   overflow issues.
 - Addressed warning from checkpatch.
 - Link to v1: https://lore.kernel.org/all/20250205060653.2221165-1-buaajxlj@163.com/

 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1fb1f..6c449f78f0a6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1186,6 +1186,8 @@ static struct sock *unix_find_other(struct net *net,
 	return sk;
 }
 
+#define UNIX_AUTOBIND_LEN 6
+
 static int unix_autobind(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -1203,12 +1205,12 @@ static int unix_autobind(struct sock *sk)
 		goto out;
 
 	err = -ENOMEM;
-	addr = kzalloc(sizeof(*addr) +
-		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
+	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
+			UNIX_AUTOBIND_LEN, GFP_KERNEL);
 	if (!addr)
 		goto out;
 
-	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
+	addr->len = offsetof(struct sockaddr_un, sun_path) + UNIX_AUTOBIND_LEN;
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
@@ -1217,7 +1219,7 @@ static int unix_autobind(struct sock *sk)
 	lastnum = ordernum & 0xFFFFF;
 retry:
 	ordernum = (ordernum + 1) & 0xFFFFF;
-	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
+	snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
 
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
-- 
2.25.1


