Return-Path: <netdev+bounces-197366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA9AD84EB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08F87A7B34
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DB2E0B69;
	Fri, 13 Jun 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b="WA/i2EJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446B2DA761;
	Fri, 13 Jun 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800652; cv=none; b=TjHRWzW8ZCvvzGujDwY3QhKvoN+EPxruicPRjKQ4HLbNzhYprLCVNK9HXHIiMKnQKGJ8hjq5siG8pjZU+uTTBNF+FrLCJnJet2M9IjNKsSvxUZtNHoAL9LL5AaiBOCMHUCrFxWj/TfVttIZk/u3tQHfA3dqeGY62Cw73gE4X5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800652; c=relaxed/simple;
	bh=rcLyjWA6iWah1E2lgGlYxaC7DrqkV6jmOnFtAUerKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Plv3boqRJQaTvoP6cLPCPvfVAcMv4EmQ6SCWhKPNLUa9+GhsXKdohEVlvCw+u3ZmuwRGHCsXG6bTRrgJr/FED4qvXlZuhwI/c00/mvy9Ga9TVHogKyvXjtKUUDW9cQ0rt6YU2N3RaAsb1NBBA07SDNvfk93OnhnN291z6KS4LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com; spf=pass smtp.mailfrom=hillstonenet.com; dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b=WA/i2EJ1; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillstonenet.com
Received: from localhost.localdomain (unknown [111.199.5.197])
	by smtp.qiye.163.com (Hmail) with ESMTP id 188e99b3c;
	Fri, 13 Jun 2025 15:38:49 +0800 (GMT+08:00)
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
Subject: [PATCH] tipc: fix panic in tipc_udp_nl_dump_remoteip() using bearer as udp without check
Date: Fri, 13 Jun 2025 07:38:26 +0000
Message-ID: <20250613073826.96527-1-hxqu@hillstonenet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613055506.95836-1-hxqu@hillstonenet.com>
References: <20250613055506.95836-1-hxqu@hillstonenet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkJKVkkeSExPHUkZGkwdTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkpVSkJCVU5VSkJMWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a97683a222d09dakunm9ca564cfa80574
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46LTo5LzErOVZCGigvFR4z
	QzMaCTdVSlVKTE9CQ0tLSEhKSUJNVTMWGhIXVRMDCg47ExIXFwgPFBUeFR4PVRgUFkVZV1kSC1lB
	WUpKSlVKQkJVTlVKQkxZV1kIAVlBSU1MSDcG
DKIM-Signature:a=rsa-sha256;
	b=WA/i2EJ1MCZZN8gzi4pEUkNkmK0owipdfSdPf+EIomkq0dlMjkYqw3QjCk0fJRlvDZe4/+k7Zyoxk4xP6gYQNOapaEarAWOmqawk95HOdsI9cPopkvWIeHUSphsYTHSUNr/tdZFx/sFKkfDnBPphsloOfNMfAzJoEttUw2tMvdU=; s=default; c=relaxed/relaxed; d=hillstonenet.com; v=1;
	bh=wtXKO9HXhZZMnYJ4fgvFMPEwRzEhJCJl8qJOxuHWRHc=;
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

Fixes: 832629ca5c31 ("tipc: add UDP remoteip dump to netlink API")
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


