Return-Path: <netdev+bounces-198107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA0ADB42D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0641884D38
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513021C183;
	Mon, 16 Jun 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b="Cswv30FH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D3216E24;
	Mon, 16 Jun 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084795; cv=none; b=ZFCYsYBj2dptyKEQ6goOKc72R9t8p/kRy1tIPfb595zVJD57+kud0HYusEbuuOoiy091OC4aUri+DdGJdU/AdC2+CJbXMhGjqPqWYYPcgGciiL9lUd66Y8OFhxwKYffl1xnqpRHhddH7G+dT0IRW6aIw2X3FxnHR/fYHhwZgf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084795; c=relaxed/simple;
	bh=Hq8BGB78MSB1bwABjFq8eVa/UYbHdlW3XX5nempYpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIaphicLERoEyK1ygQ+XwnGjkRWvay2cL989EDsFyCj8YOhUv2aMcaSMCBXdoMsVTnzCh/h5phD1LSGL9eWr4bkP+c+vSUNmS86Uir7C9fKy6tT67O/j6/1AQOMehucyV+zwMwWPG9DU8HH6MdkVKWqLV4rlsz0EB4JzmcFFbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com; spf=pass smtp.mailfrom=hillstonenet.com; dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b=Cswv30FH; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillstonenet.com
Received: from ubuntu.. (unknown [120.244.177.73])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18c377ba7;
	Mon, 16 Jun 2025 12:29:46 +0800 (GMT+08:00)
From: Haixia Qu <hxqu@hillstonenet.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Alpe <richard.alpe@ericsson.com>
Cc: Haixia Qu <hxqu@hillstonenet.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: fix panic in tipc_udp_nl_dump_remoteip() using bearer as udp without check
Date: Mon, 16 Jun 2025 04:28:33 +0000
Message-ID: <20250616042901.12978-1-hxqu@hillstonenet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRpIVhpOSEhKSE5KSUofSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUtVSU9PVUpMTFVMSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a97770021d909dakunm7ad0add73107996
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Azo6NjE*F00RPSExOTEQ
	CDoKCilVSlVKTE5LS09DSkNDSUpKVTMWGhIXVRMDCg47ExIXFwgPFBUeFR4PVRgUFkVZV1kSC1lB
	WUpJS1VJT09VSkxMVUxIWVdZCAFZQUlOTUI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Cswv30FHbvHO1h5XHE3uTrne6tgUKGJr10ksqd6V7nFoqU+3UP4Y2Hn6Oo0/ugC9CdZ1OJG767ps0OqXwErFWPkIQU18qY1tV4rTUv+kPjnaUVQij2623HLPBfZa6w2wt626RjA5JpYo7O7BIzlnQaN5u6FTdPhuz3hM8t1Hj34=; s=default; c=relaxed/relaxed; d=hillstonenet.com; v=1;
	bh=YeiCMRU+GGDznU/jqFopoJClZm/E/OHhHUNSiUfiIjQ=;
	h=date:mime-version:subject:message-id:from;

When TIPC_NL_UDP_GET_REMOTEIP cmd calls tipc_udp_nl_dump_remoteip()
with media name set to a l2 name, kernel panics [1].

The reproduction steps:
1. create a tun interface
2. enable l2 bearer
3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun

the ub was in fact a struct dev.

when bid != 0 && skip_cnt != 0, bearer_list[bid] may be NULL or
other media when other thread changes it.

fix this by checking media_id.

[1]
tipc: Started in network mode
tipc: Node identity 8af312d38a21, cluster identity 4711
tipc: Enabled bearer <eth:syz_tun>, priority 1
Oops: general protection fault
KASAN: null-ptr-deref in range
CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
Hardware name: QEMU Ubuntu 24.04 PC
RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0

Fixes: 832629ca5c313 ("tipc: add UDP remoteip dump to netlink API")
Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>
---
 net/tipc/udp_media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 108a4cc2e001..258d6aa4f21a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -489,7 +489,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = tipc_bearer_find(net, bname);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
@@ -500,7 +500,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = rtnl_dereference(tn->bearer_list[bid]);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
-- 
2.43.0


