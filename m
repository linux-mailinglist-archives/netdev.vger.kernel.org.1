Return-Path: <netdev+bounces-228528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0674BCD59E
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1844E3260
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D52F362F;
	Fri, 10 Oct 2025 13:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C91C5D44;
	Fri, 10 Oct 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104460; cv=none; b=H6R8TdSg6FQfibeVIO9JWpBQIvUp8C6/K48UrU5bwkwDziptntRw9FZVPU6QIXoEyyHviNy2CqYI+dgMruNMiKvNdx+EBsNUjWu0kWa6Sy3quI4L/1E+W02m6P1K2PzJjEvjOE2jRA6GZSc8OwRhFZkBsuk5nFTcwho8oRD721g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104460; c=relaxed/simple;
	bh=74teSWYi4/L4IaGFglEu9oWYkl+qtemgenQPUyRahU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXbR/1wNw/f/WKtsWzjTqV+D75DienfLb3Yuz6VDP4m6dI4yJwin8hajXgedIa9IwlxrwQtQJNtd6flSQGr8IAv4uSr/8i7qO/TE355OYIdG/4n0qZ2AOuIXV0gQdbRzWX73H5bmYCo+axCVbOoIRQ7b5wNItQaXwo4uiJh2agE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3ACBA61775; Fri, 10 Oct 2025 15:54:16 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	sdf@fomichev.me
Subject: [PATCH net 0/2] net: avoid LOCKDEP MAX_LOCK_DEPTH splat
Date: Fri, 10 Oct 2025 15:54:10 +0200
Message-ID: <20251010135412.22602-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unshare -n bash -c 'for i in $(seq 1 100);do ip link add foo$i type dummy;done'
Gives:

BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by kworker/u16:1/69:
 #0: ffff8880010b7148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x7ed/0x1350
 #1: ffffc900004a7d40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0xcf3/0x1350
 #2: ffffffff8bc6fbd0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xab/0x7f0
 #3: ffffffff8bc8daa8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0x7e/0x2e0
 #4: ffff88800b5e9cb0 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x1056/0x1b00
[..]

Work around this by splitting the list into lockdep-digestable sublists.
This patchset should have no effect whatsoever for non-lockdep builds.

This issue is a problem for me because of a recent test case added
to nftables userspace which will create/destroy 100 dummy net devices,
so when I run the tests on a debug kernel lockdep coverage is now lost.

Alternative suggestions welcome.

I did not yet encounter another code path that would take so many mutexes
in a row, so I don't see a reason to muck with task_struct->held_locks[].

Florian Westphal (2):
  net: core: move unregister_many inner loops to a helper
  net: core: split unregister_netdevice list into smaller chunks

 net/core/dev.c | 89 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 24 deletions(-)

-- 
2.49.1

