Return-Path: <netdev+bounces-227303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B94BAC1B7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E4189E2F4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55C2BD034;
	Tue, 30 Sep 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DL2u5X7f"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4472853EF
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222007; cv=none; b=stgM0kpdbm2jmBgSjbn8XyGT+gwFnLnDrhJR8Djy+4N7jSlscOLjmjnoP3RGD/KLau5dUDowJJOxCbnFOPA5A0N4vActVqPXmza+/LCSKL0EaHBXsaogJGJHJleG1DrHwPh0eObJx0Q0tek9r4J4FWsdDIP+6OEoMu8xVYNWk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222007; c=relaxed/simple;
	bh=kNodwE8ISdOsR62lgF1hpuhR9iqoNPi98sJfxdnumgM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s5V1gUCjB6IBg/N9bAclXrWmBdmILsV9ptALaWo+TFsNTE61nK14153AFnx68sC6MLqn4GxvH8Lq7fN6r6bqCJH88hXwBALeviq+AYkpjshk6QjwNhtM0JMLgGlqaq/SKhqUkb9sfP+rXlGrEG4tOlKwlDIaMt0cj50dZMpLgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DL2u5X7f; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759222001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=j5AcYdvJFrn+nCGCLPaED2CyHb1mgyd2csHm8RlZh3k=;
	b=DL2u5X7f0y2WjRKJPPtgDwkXH3jygPQkflOzbURaKgaKj+y704/p8VoNAgc2LZno+nSEJZ
	Uka6vYFxpcUVDYhyAFbh9v9mcDtHhk35DBWA6DLNVmqUjLYgOoxNkFpkqhIf7tOcpGMP7g
	wq6krYDC91EkcpgXsTmsnm6ix8Jb/K4=
From: Zqiang <qiang.zhang@linux.dev>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com
Cc: qiang.zhang@linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] usbnet: Fix using smp_processor_id() in preemptible code warnings
Date: Tue, 30 Sep 2025 16:46:36 +0800
Message-Id: <20250930084636.5835-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Syzbot reported the following warning:

BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The usbnet_skb_return() can be invoked in preemptible task-context,
this commit therefore use get_cpu_ptr/put_cpu_ptr() instead of
this_cpu_ptr() to get stats64 pointer.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Link: https://lore.kernel.org/all/681607f0.a70a0220.254cdc.001a.GAE@google.com/T/
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 drivers/net/usb/usbnet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 511c4154cf74..89f79a0bdc43 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -328,7 +328,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
  */
 void usbnet_skb_return (struct usbnet *dev, struct sk_buff *skb)
 {
-	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
+	struct pcpu_sw_netstats *stats64;
 	unsigned long flags;
 	int	status;
 
@@ -341,10 +341,12 @@ void usbnet_skb_return (struct usbnet *dev, struct sk_buff *skb)
 	if (skb->protocol == 0)
 		skb->protocol = eth_type_trans (skb, dev->net);
 
+	stats64 = get_cpu_ptr(dev->net->tstats);
 	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 	u64_stats_inc(&stats64->rx_packets);
 	u64_stats_add(&stats64->rx_bytes, skb->len);
 	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+	put_cpu_ptr(stats64);
 
 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
 		  skb->len + sizeof (struct ethhdr), skb->protocol);
-- 
2.17.1


