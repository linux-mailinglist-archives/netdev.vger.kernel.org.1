Return-Path: <netdev+bounces-45663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B207DECE8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 07:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798B5B20DFC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59B524C;
	Thu,  2 Nov 2023 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB852D60C
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:37:03 +0000 (UTC)
X-Greylist: delayed 496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 23:36:53 PDT
Received: from njjs-sys-mailin01.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCC7D1A2
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 23:36:53 -0700 (PDT)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 5CFC27F00053
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:28:36 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Subject: [PATCH 2/2][net-next] rtnetlink: using alloc_large_skb in rtnl_getlink
Date: Thu,  2 Nov 2023 14:28:36 +0800
Message-Id: <20231102062836.19074-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20231102062836.19074-1-lirongqing@baidu.com>
References: <20231102062836.19074-1-lirongqing@baidu.com>
X-Spam-Level: *
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

if a PF has 256 or more VFs, ip link command will allocate a order 3
memory and maybe trigger OOM due to memory fragement, rtnl_vfinfo_size
is used to compute the VFs needed memory size

so using alloc_large_skb in which vmalloc is used for large memory,
to avoid the failure of allocating memory

    ip invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|\
	__GFP_COMP|__GFP_NOMEMALLOC), order=3, oom_score_adj=0
    CPU: 74 PID: 204414 Comm: ip Kdump: loaded Tainted: P           OE
    Call Trace:
    dump_stack+0x57/0x6a
    dump_header+0x4a/0x210
    oom_kill_process+0xe4/0x140
    out_of_memory+0x3e8/0x790
    __alloc_pages_slowpath.constprop.116+0x953/0xc50
    __alloc_pages_nodemask+0x2af/0x310
    kmalloc_large_node+0x38/0xf0
    __kmalloc_node_track_caller+0x417/0x4d0
    __kmalloc_reserve.isra.61+0x2e/0x80
    __alloc_skb+0x82/0x1c0
    rtnl_getlink+0x24f/0x370
    rtnetlink_rcv_msg+0x12c/0x350
    netlink_rcv_skb+0x50/0x100
    netlink_unicast+0x1b2/0x280
    netlink_sendmsg+0x355/0x4a0
    sock_sendmsg+0x5b/0x60
    ____sys_sendmsg+0x1ea/0x250
    ___sys_sendmsg+0x88/0xd0
    __sys_sendmsg+0x5e/0xa0
    do_syscall_64+0x33/0x40
    entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f95a65a5b70

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/core/rtnetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4a2ec33..be43044 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3813,7 +3813,8 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 
 	err = -ENOBUFS;
-	nskb = nlmsg_new(if_nlmsg_size(dev, ext_filter_mask), GFP_KERNEL);
+	nskb = alloc_large_skb(
+			nlmsg_total_size(if_nlmsg_size(dev, ext_filter_mask)), 0);
 	if (nskb == NULL)
 		goto out;
 
-- 
2.9.4


