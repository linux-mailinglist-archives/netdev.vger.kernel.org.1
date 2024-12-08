Return-Path: <netdev+bounces-150012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758A9E8896
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 00:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD51884E2E
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679071917E4;
	Sun,  8 Dec 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eleDimTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80BB66E;
	Sun,  8 Dec 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733701803; cv=none; b=ZL5zFhRjCFgjlYaChSdEj0UDs/PoW6mCeh3kfxYYLECU3dKevOcGkdEQYRc/ZxbmwQY4iVGNhpiNVxNV5BaLGW7uWnCKnkUc0FOw/tOmaY+M3uVhVSkXm0Z3rwgD4d0+fooSY5DZ8GXEVTRA3+10I3iEQ3boS+0YNXuYfYW8Yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733701803; c=relaxed/simple;
	bh=V4HVzsI+XMBJjkzp/89Y6/G2AOKzwT5yoss94xIGubM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6Xzb4JIuGdOu6YiKUKgbwg0ZF17ME0NVo5lxbvyRurRAi2uiCdPr3HujdsnDeSQBcu0KZI/yI/fGH4/wRArRmjgCJ0r/FH9PRuMeNIaXJR73D6IxL+9W8k4eeXKSYnPvjEFGL3vWrDGzzC8c0w+7A7DjXSEgM7cZswG2hmHgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eleDimTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC12C4CED2;
	Sun,  8 Dec 2024 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733701802;
	bh=V4HVzsI+XMBJjkzp/89Y6/G2AOKzwT5yoss94xIGubM=;
	h=From:To:Cc:Subject:Date:From;
	b=eleDimTlh9CbHWtCzjsE8Jw+BZzCDgMvSwDrAHhW+PH+Biqzb7td6HtPBvGXnRZUr
	 eDfJZOskHissGyntos7heqy2ARzgXQK5juBrQF0b7Xi3tEODvEX85F3l1fbME+uVff
	 NcB9MLYCQrb6VjjzpXzRSUwOGUACtg7Rs++lMo65d0gsZ4qGbNlplM6nGP5pHTZ3Cs
	 wHZgySZVE/JRym2tlLWvYeL59YBs6HXn+6ndb+uMnc8IlH+nDpCIOvE5wmP+lGgoHV
	 C+leV6Qiny+aZzsfJffBg/SW+JZr4J7BMv28L/buMoleQX0jyXMbN9x6aFD33g4eyb
	 fiPIjkDV4dnMg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Subject: [PATCH] net: pktgen: Use kthread_create_on_cpu()
Date: Mon,  9 Dec 2024 00:49:55 +0100
Message-ID: <20241208234955.31910-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/pktgen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..7fcb4fc7a5d6 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3883,17 +3883,14 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
 	list_add_tail(&t->th_list, &pn->pktgen_threads);
 	init_completion(&t->start_done);
 
-	p = kthread_create_on_node(pktgen_thread_worker,
-				   t,
-				   cpu_to_node(cpu),
-				   "kpktgend_%d", cpu);
+	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu, "kpktgend_%d");
 	if (IS_ERR(p)) {
 		pr_err("kthread_create_on_node() failed for cpu %d\n", t->cpu);
 		list_del(&t->th_list);
 		kfree(t);
 		return PTR_ERR(p);
 	}
-	kthread_bind(p, cpu);
+
 	t->tsk = p;
 
 	pe = proc_create_data(t->tsk->comm, 0600, pn->proc_dir,
-- 
2.46.0


