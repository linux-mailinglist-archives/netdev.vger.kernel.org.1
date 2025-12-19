Return-Path: <netdev+bounces-245469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1ACCE62F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 04:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 163E43016DE1
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0631E230E;
	Fri, 19 Dec 2025 03:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032FB481DD;
	Fri, 19 Dec 2025 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116037; cv=none; b=YNcLUbSYBY3rJJBD/yPpuk/9/22gQKtpu15Mo70t8LGbqP/HcQ+uO7tJiCAafu2zfDuGT06KTpH3G3dU5K8BZNZm0FTTMziXLh6pQsxREMa9U80Qqb0eH++k50kfMc2msXs3MjjXMj2urRkJpTIvCWoZQqzNjaZd+e3oleGp36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116037; c=relaxed/simple;
	bh=wWx04aQ6g06P4aDR+O3WO/Y3zLXaoh0Cs00LSg9xp4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjL+pSLMwMVQ11nsJp0NTTp2kh/1XD+34PhXj9IJOxGHJOX0zWgeXo1okzT86+qTTZiLa+Bhkj+73nrH+X0efNuOz2sKtktQQUYMJQ6coiEmqF/lpHS4G9C3g51ryHoUrZA9f/nqpVoghSQBawryIN8PffM3HhyH9I9q6mN/n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 0DC778B2A3F; Fri, 19 Dec 2025 10:52:02 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
Date: Fri, 19 Dec 2025 10:51:39 +0800
Message-ID: <20251219025140.77695-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
current task can be preempted. Another task running on the same CPU
may then execute rt6_make_pcpu_route() and successfully install a
pcpu_rt entry. When the first task resumes execution, its cmpxchg()
in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
mdelay() after rt6_get_pcpu_route().

Using preempt_disable/enable is not appropriate here because
ip6_rt_pcpu_alloc() may sleep.

Fix this by:
1. Removing the BUG_ON and instead handling the race gracefully by
   freeing our allocation and returning the existing pcpu_rt when
   cmpxchg() fails.
2. Keeping the BUG_ON for non-PREEMPT_RT kernels, since preemption
   should not occur in this context and a cmpxchg failure would
   indicate a real bug.

Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")
Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6918cd88.050a0220.1c914e.0045.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v1 -> v2: Drop migrate_{disable, enabled} suggested by Steven and Paolo.
          https://lore.kernel.org/all/20251209124805.379112-1-jiayuan.chen@linux.dev/T/
---
 net/ipv6/route.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..9e7afda7cba2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1470,7 +1470,18 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 
 	p = this_cpu_ptr(res->nh->rt6i_pcpu);
 	prev = cmpxchg(p, NULL, pcpu_rt);
-	BUG_ON(prev);
+	if (unlikely(prev)) {
+		/*
+		 * Another task on this CPU already installed a pcpu_rt.
+		 * This can happen on PREEMPT_RT where preemption is possible.
+		 * Free our allocation and return the existing one.
+		 */
+		BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT));
+
+		dst_dev_put(&pcpu_rt->dst);
+		dst_release(&pcpu_rt->dst);
+		return prev;
+	}
 
 	if (res->f6i->fib6_destroying) {
 		struct fib6_info *from;
-- 
2.43.0


