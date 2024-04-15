Return-Path: <netdev+bounces-87920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F58A4EF5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202221C20434
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9565FBA3;
	Mon, 15 Apr 2024 12:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDC1DA5F
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183886; cv=none; b=bxfkHOa0ulepFPs1l2sZL3jp+9mj/+mfd4AXBvmaq1nJr4d161ggTCvvYgdhVG6QalD6EsmF/DIVWJ+9q4fCuisMW9JjzdTUkcJ0u0yszc6phVvNVrQlIvRQIlM4d0wnRAAViahu4oyiUGB6L5J/k7PwlyIEf9TskNDndkMOlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183886; c=relaxed/simple;
	bh=pwGKz1k595MkwOv0q9SZFWgQ9TxMwxuEDYHmNHUz0lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMVCxdtGv+AV/tUTuYuRSLdgT1r4n+raDWGdyNEK+SY8fcatYjJ0PPYL7nofdkGCt4ZPNIZD/V+eHOVnowC6AbGyZW3mtzFrp7y3VsMWfNWio0uUh0z5OItILr1V8ft1TUGwsZ2Nhb/d3qVigHVhNobpN/KD7iOeOA3rTPdAT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rwLO5-0006pO-KX; Mon, 15 Apr 2024 14:24:41 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
Date: Mon, 15 Apr 2024 14:23:44 +0200
Message-ID: <20240415122346.26503-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmemleak reports net_device resources are no longer released, restore
needs_free_netdev toggle.  Sample backtrace:

unreferenced object 0xffff88810874f000 (size 4096): [..]
    [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
    [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
    [<00000000b4be1e78>] vti6_init_net+0x94/0x230
    [<000000008830c1ea>] ops_init+0x32/0xc0
    [<000000006a26fa8f>] setup_net+0x134/0x2e0
[..]

Cc: Breno Leitao <leitao@debian.org>
Fixes: a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/ip6_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 4d68a0777b0c..78344cf3867e 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -901,6 +901,7 @@ static void vti6_dev_setup(struct net_device *dev)
 {
 	dev->netdev_ops = &vti6_netdev_ops;
 	dev->header_ops = &ip_tunnel_header_ops;
+	dev->needs_free_netdev = true;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->type = ARPHRD_TUNNEL6;
-- 
2.43.2


