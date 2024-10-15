Return-Path: <netdev+bounces-135667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B399ECE0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0602849E1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935B1DD0E9;
	Tue, 15 Oct 2024 13:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E781DD0DD;
	Tue, 15 Oct 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998348; cv=none; b=saaARZ4iFN4+rfZud5CnZsL8UsYx9O88QIK4gmKqioYs4u5DW11xTE5bfwp4AV10tFfBDOghDbLKpne6U6ptecHdXL4dOPRg1/Dw/0KfzUQbZukF18Gyfbrp1/RMNwUq/cr06RKUp8V0uoIY2ElpbIqPqleU+1cRTX6d7fLvzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998348; c=relaxed/simple;
	bh=QpqIaM8N9zPhfV9L2BCBLTRstVrV21xsVwggs+Q3r34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5JRz8sEp9vtoqmtZbPOCQT1Q14/gp1IMF/YsDWx1vQkhHvNCHpLDB1sydnjGasX+y6ZIJfA6cvcdoswUZYF19Ak4cOOrHPcYwLmRWUTNGSLWYY8qU1JR1vPSgixy7VFGSKGp6e6c4EvFjQaG3ly/KMcRTSEsrursn/EvQOtpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost (unknown [10.193.54.193])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXbWYmaw5nTTojAA--.14492S2;
	Tue, 15 Oct 2024 21:16:22 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net v1] net: wwan: fix global oob in wwan_rtnl_policy
Date: Tue, 15 Oct 2024 21:16:21 +0800
Message-Id: <20241015131621.47503-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgBXbWYmaw5nTTojAA--.14492S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48Wr1DAFWrJFW3Kr45ZFb_yoWrurW3p3
	90gryxGr48Jry0qF4xXw1rJr1xXF1DA3WUGr1xWr1rAF15Gw1UJryUtFW3JrnxuF90yFy7
	Xr1DJr40vr15GaUanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VC0I7IYx2IY67AKxVWUAV
	WUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
	I48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RWuWlUUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

The variable wwan_rtnl_link_ops assign a *bigger* maxtype which leads to
a global out-of-bounds read when parsing the netlink attributes. Exactly
same bug cause as the oob fixed in commit b33fb5b801c6 ("net: qualcomm:
rmnet: fix global oob in rmnet_policy").

==================================================================
BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:388 [inline]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
Read of size 1 at addr ffffffff8b09cb60 by task syz.1.66276/323862

CPU: 0 PID: 323862 Comm: syz.1.66276 Not tainted 6.1.70 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x177/0x231 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x14f/0x750 mm/kasan/report.c:395
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 validate_nla lib/nlattr.c:388 [inline]
 __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
 __nla_parse+0x3c/0x50 lib/nlattr.c:700
 nla_parse_nested_deprecated include/net/netlink.h:1269 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3514 [inline]
 rtnl_newlink+0x7bc/0x1fd0 net/core/rtnetlink.c:3623
 rtnetlink_rcv_msg+0x794/0xef0 net/core/rtnetlink.c:6122
 netlink_rcv_skb+0x1de/0x420 net/netlink/af_netlink.c:2508
 netlink_unicast_kernel net/netlink/af_netlink.c:1326 [inline]
 netlink_unicast+0x74b/0x8c0 net/netlink/af_netlink.c:1352
 netlink_sendmsg+0x882/0xb90 net/netlink/af_netlink.c:1874
 sock_sendmsg_nosec net/socket.c:716 [inline]
 __sock_sendmsg net/socket.c:728 [inline]
 ____sys_sendmsg+0x5cc/0x8f0 net/socket.c:2499
 ___sys_sendmsg+0x21c/0x290 net/socket.c:2553
 __sys_sendmsg net/socket.c:2582 [inline]
 __do_sys_sendmsg net/socket.c:2591 [inline]
 __se_sys_sendmsg+0x19e/0x270 net/socket.c:2589
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x90 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f67b19a24ad
RSP: 002b:00007f67b17febb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f67b1b45f80 RCX: 00007f67b19a24ad
RDX: 0000000000000000 RSI: 0000000020005e40 RDI: 0000000000000004
RBP: 00007f67b1a1e01d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd2513764f R14: 00007ffd251376e0 R15: 00007f67b17fed40
 </TASK>

The buggy address belongs to the variable:
 wwan_rtnl_policy+0x20/0x40

The buggy address belongs to the physical page:
page:ffffea00002c2700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb09c
flags: 0xfff00000001000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000001000 ffffea00002c2708 ffffea00002c2708 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8b09ca00: 05 f9 f9 f9 05 f9 f9 f9 00 01 f9 f9 00 01 f9 f9
 ffffffff8b09ca80: 00 00 00 05 f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9
>ffffffff8b09cb00: 00 00 00 00 05 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
                                                       ^
 ffffffff8b09cb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

According to the comment of `nla_parse_nested_deprecated`, use correct size
`IFLA_WWAN_MAX` here to fix this issue.

Fixes: 88b710532e53 ("wwan: add interface creation support")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/net/wwan/wwan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..65a7ed4d6766 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1038,7 +1038,7 @@ static const struct nla_policy wwan_rtnl_policy[IFLA_WWAN_MAX + 1] = {
 
 static struct rtnl_link_ops wwan_rtnl_link_ops __read_mostly = {
 	.kind = "wwan",
-	.maxtype = __IFLA_WWAN_MAX,
+	.maxtype = IFLA_WWAN_MAX,
 	.alloc = wwan_rtnl_alloc,
 	.validate = wwan_rtnl_validate,
 	.newlink = wwan_rtnl_newlink,
-- 
2.39.2


