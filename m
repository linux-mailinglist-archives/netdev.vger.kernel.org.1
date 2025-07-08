Return-Path: <netdev+bounces-205183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E91AFDB82
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC9B1AA16C7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7023314B;
	Tue,  8 Jul 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9EzF66t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD21230D35
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015937; cv=none; b=ZjrFPStm4TfqC59x5wEKhJX2wbvlp5FowtjTRt3OWW8adA0uBDtrvS6+dRMKf4IwFw5hSFpKBxY16wKjR3fStF0yaV03PCCQhbjBYfXZPzNL592WQ4ORpzCInxwqpGdQgJpuQIJT747PCkt7heJIigZ/QCAlUhkyiDjNBBd4dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015937; c=relaxed/simple;
	bh=/yEtR6tPjS9oFbGTfKU1cpH828rgcHmpMYBRKSU4+pQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e03BEvjhQ3AtH+izpSHGLx2uQ0Eplg7eVtLiL+qCShGcATlP/4s2yt0lCtZPAgPQVT2nTYC9M67/C3OHwz7ExrupktVDMKo29LFb3nlOkvAc6E49C5B/h978UzNJSjYrhLKm6oG8/Wx0oUVOgQiNyny7/cJSYjUgKAtzcl3bALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9EzF66t; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-876a88d14baso938360139f.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752015934; x=1752620734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydReU0QIJZT7YXo3bwAQ6It4JXE9+5xG1ICd6gZCsIQ=;
        b=L9EzF66twArOsNDvnYARF5UFhAapu5lZRPKcRazj2Y+eZgZtnOEzYhMrPUZATL0t0H
         EvtczJb7WvPbuEy2ROLwa0u21D9gc7G0xcAdiSrpqse28f3uExjOjbsHdZ6O5aAE5lxL
         VJlg8Q2cNEjZCEMr0QO8IeS+Q7/RsELaLmCDKHh+cg7RELb5CV7ycq56KFS3d86B5SLo
         2Sq4x0XmoN62ktQQtkbPr5oF92RW5fYtI1TGXoaoe565ugsA6bjxMJIRHWelwxXHzBoz
         tQlDF6kqYd/d+bXzrZEudF4KE89z2MqQxNcV1h1RjASRcBWa32+KZ3FnJezxTdaIQQpb
         1tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015934; x=1752620734;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydReU0QIJZT7YXo3bwAQ6It4JXE9+5xG1ICd6gZCsIQ=;
        b=cdtgwZDWHsGVg/zWxiVTYYSD0TZ5b8hRmDkWmoi4tdGP4lGhDr9QwZk2zBdadIo/rC
         yoJMHwU6n+XP9Ffu3x6V7jp6IymDYF6xwhKvuZySTUIPlJKPb4JVQZ7ZxskPOnBUzTJj
         +6MjvyXwDB69p89Yfz6XXIWiZYtRNXe9gsY1fUYdGwdu6n8ofhWckSY6WdsPRnwipDvU
         XzF58xcTadvAXE9/LHfizjmkTqfv7n7CmTtWzoQNmWQkz3wga6CDSejoUeOjGBmvKHVD
         SGD4jZyHsHz1rLEwQow8skqRDHIfAZ+LpU086kzPzuQfKzxIAwTkmmmpc4fPyYHfrnOM
         dXeA==
X-Gm-Message-State: AOJu0YxLCAc8raFmhQd2fzzl+mtFlEzJiAppou6WWQyAVPCHi1HokRT3
	IZbXK8HJXoZ5FlUY2H49GrMM95DuR3NQaHUrX2iW03fmVIFXCmeHOpGaR60vN/JhP4HuUN1yG9h
	VXeKQJYv5pWCabKeWLsIuJwSdZkXUsACRJ2hwl7w/08CXeUdYYD6ZfXQBbV9IlZPot+/pyNEGb6
	Ao6ePEUs0m1uywz+MML+v8c2IIPqYKvlcRzrLWjwNAhg==
X-Google-Smtp-Source: AGHT+IGyIq2qx/+G1KUwARfX2EySC1OKrUiPgvbCwRThuDgP8H3kEf8YP25QyN81JTLH+4TPmrI1v+fJTndk
X-Received: from iov19.prod.google.com ([2002:a05:6602:7513:b0:876:41f5:7fcc])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:b83:b0:86c:fe66:4d6a
 with SMTP id ca18e2360f4ac-8795b18051dmr57754439f.13.1752015934614; Tue, 08
 Jul 2025 16:05:34 -0700 (PDT)
Date: Tue,  8 Jul 2025 23:04:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708230513.42922-1-nkapron@google.com>
Subject: [RFC net] netlink: lock nl_cb_mutex in netlink_release
From: Neill Kapron <nkapron@google.com>
To: netdev@vger.kernel.org
Cc: nkapron@google.com, kernel-team@android.com, cmllamas@google.com, 
	jstultz@google.com, Nick Hawkins <nick.hawkins@hpe.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Anastasia Kovaleva <a.kovaleva@yadro.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Siddh Raman Pant <siddh.raman.pant@oracle.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While investigating the following bug report on a 6.6 kernel (similar to
[1]), I believe I have identified a race condition between
__netlink_dump_start(), netlink_release(), and netlink_recvmsg() (which
calls netlink_dump()).

My understanding is that __netlink_dump_start() locks nl_cb_mutex, sets
cb_running and calls netlink_dump(), but this call into netlink_dump()
unlocks nl_cb_mutex and returns before clearing cb_running. Then,
netlink_recvmsg() is called, which calls back into netlink_dump(), which
then locks nl_cb_mutex, checks to make sure cb_running is set, then
proceeds with the dump.

It is at this point after the netlink_dump() checks for cb_running that
netlink_release() is called, which tears everything down. While the change
in [2] clears cb_running, it does so without holding the lock. This causes
the NULL pointer dereference in netlink_dump().

I think this should be resolved by locking the
nl_cb_mutex in netlink_release() as seen in the change below.

By locking this mutex early in netlink_release(), then performing the
cleanup and setting nlk->cb_running to false prior to releasing the
lock, netlink_dump() should be blocked waiting for the lock. Once
netlink_dump() acquires the lock, it will fail the check for
nlk->cb_running, and therefore jump to the errout_skb label. Since *skb
is NULL at this point, the call to kfree_skb() should be harmless.

Additionally, I believe [2] should be backported to stable trees, as it
does not exist on 6.6 where this bug was seen. It should be noted that
the fixes tag was removed for this patch per the request in [3], as it
was considered cleanup since 'code can't be run once we're in release',
however in both [1] and the trace collected below, the USB NCM gadget is
running, and I am suspicious that a cable unplug event asyncronously
causes netlink_release to be called during the netlink_dump(). I will send
a separate request to stable for this to be backported.

Note, I was unable to reproduce this bug, and therefore don't have a
good way to test this patch, but it seems to be a likely solution. That
being said, I do not have extensive background with netlink, and may
have overlooked something. Thanks for the thorough review.

Abbreviated trace below:
_______________________________________________________________________

Unable to handle kernel NULL pointer dereference at virtual address 00
...
 pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : __pi_strlen (arch/arm64/lib/strlen.S:87)
 lr : nla_put_string (include/net/netlink.h:1523)
 sp : ffffffc09e59b7d0
 x29: ffffffc09e59b7d0 x28: 0000000000000043 x27: ffffff8976deb000
 x26: 00000000c71085df x25: 0000000000000010 x24: 00000000ffffffff
 x23: 0000000000000000 x22: 0000000000000000 x21: ffffff89dfb97300
 x20: 0000000000000038 x19: 0000000000000000 x18: ffffffd1032dc5c0
 x17: 00000000d6618229 x16: 0000000000000018 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000029b8
 x11: 0000000000003e80 x10: 0000000000000b38 x9 : 000000000a370000
 x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : ffffff800a3729b8 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000038 x0 : 0000000000000000
Call trace:
 __pi_strlen (arch/arm64/lib/strlen.S:87)
 rtnl_fill_ifinfo (net/core/rtnetlink.c:1935)
 rtnl_dump_ifinfo (net/core/rtnetlink.c:2276)
 netlink_dump (net/netlink/af_netlink.c:2257)
 netlink_recvmsg (net/netlink/af_netlink.c:1978)
 __sys_recvfrom (net/socket.c:1047 net/socket.c:1069 net/socket.c:2256)
 __arm64_sys_recvfrom (net/socket.c:2274 net/socket.c:2270 net/socket.c:2270)
 invoke_syscall (arch/arm64/kernel/syscall.c:0 arch/arm64/kernel/syscall.c:51)
 el0_svc_common (arch/arm64/kernel/syscall.c:0)
 do_el0_svc (arch/arm64/kernel/syscall.c:154)
 el0_svc (arch/arm64/kernel/entry-common.c:136
  arch/arm64/kernel/entry-common.c:147 arch/arm64/kernel/entry-common.c:684)
 el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
 el0t_64_sync (arch/arm64/kernel/entry.S:599)
 Code: 92400c04 b200c3e8 f100009f 5400088c (a9400c02)
_______________________________________________________________________

[1] https://lore.kernel.org/all/bug-219826-208809@https.bugzilla.kernel.org%2F/
[2] https://lore.kernel.org/all/aff028e3eb2b768b9895fa6349fa1981ae22f098.camel@oracle.com/
[3] https://lore.kernel.org/all/20250214170631.6badcc24@kernel.org/

Reported-by: Nick Hawkins <nick.hawkins@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219826
Fixes: 438989137acd ("netlink: Unset cb_running when terminating dump on release")
Fixes: 1904fb9ebf91 ("netlink: terminate outstanding dump on socket close")
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 net/netlink/af_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 79fbaf7333ce..142529c08300 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -724,9 +724,11 @@ static int netlink_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	nlk = nlk_sk(sk);
+	mutex_lock(&nlk->nl_cb_mutex);
+
 	netlink_remove(sk);
 	sock_orphan(sk);
-	nlk = nlk_sk(sk);
 
 	/*
 	 * OK. Socket is unlinked, any packets that arrive now
@@ -773,6 +775,7 @@ static int netlink_release(struct socket *sock)
 		WRITE_ONCE(nlk->cb_running, false);
 	}
 
+	mutex_unlock(&nlk->nl_cb_mutex);
 	module_put(nlk->module);
 
 	if (netlink_is_kernel(sk)) {
-- 
2.50.0.727.gbf7dc18ff4-goog


