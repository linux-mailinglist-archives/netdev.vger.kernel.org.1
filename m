Return-Path: <netdev+bounces-218096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D32B3B152
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA931C827BE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010042264BB;
	Fri, 29 Aug 2025 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cs4ScC/n"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012861A83F8;
	Fri, 29 Aug 2025 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436725; cv=none; b=igVGqQVTzfkxw+4AFrU337lyyHb+rGNmXCYYEJdwoQ0wex+PjGDUuTyQnI3+AMGDt7JfNcKLBV+/AhGtnwJ5ZQE4s4XPWibfbqejcYe14jXlDOzTTIi66rPYusYQllS/6dm5EaM/AzwGmcWFTOc6rQkktbbV3OVto2jqmVgUNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436725; c=relaxed/simple;
	bh=OGDMwBQ69Yet+EPIGbI/9xMvQ4HzbUERkS3kXNOVH5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmSvW8YChtZVTKOsSmkMkdmE4hSlQUyhj57b9h0/04s35a03d/jVONPRjZoTBm/oLMJimaoCzMeRoX4qFa42e+2Auqvek0W5f89Kd6hbPzNq5KWWMCf2z2ScdPhprKiPMhTd87pJ3Qko7xIH6LvIvU10aIMZD61plGeBxfrojsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cs4ScC/n; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/J
	I7Zp+zbS43Is2//xp/DGcrppODXMsN9kFHi+lUQIA=; b=Cs4ScC/nPThzJUz/0+
	zWdL8uE1YVSR4SmkrV3kogFYODt4lr7dzvrtOA7TxeTq99MDV3J8QUuYzhvysqPW
	N5vgODXbnTa9xanBUbtH6s/Gf0QibpQJCi6ak1Z39AoDLOlTBywwMR7vSCa9jCmW
	K8QJORNVLdA1YTrlTGuo33hYM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXKLLaGLFo3SFOFA--.1285S2;
	Fri, 29 Aug 2025 11:04:59 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH] net: remove local_bh_enable during busy poll
Date: Fri, 29 Aug 2025 11:04:56 +0800
Message-Id: <20250829030456.489405-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXKLLaGLFo3SFOFA--.1285S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWftrW7AFW3JFWfWrW5Awb_yoW8Cr1rpr
	ZrK3WvkF4kXF18KFZrJFs7WF15J3s5Wa1xC3sYk343Wwn8tFn5trZ2kFy5XFn09rZavay8
	ZFsay345Ww1DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pin2-8UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/1tbiXB+4LmixEDzbsgAAsJ

From: Longjun Tang <tanglongjun@kylinos.cn>

When CONFIG_NET_RX_BUSY_POLL==Y and net.core.busy_read > 0,
the __napi_busy_loop function calls napi_poll to perform busy polling,
such as in the case of virtio_net's virnet_poll. If interrupts are enabled
during the busy polling process, it is possible that data has already been
received and that last_used_idx is updated before the interrupt is handled.
This can lead to the vring_interrupt returning IRQ_NONE in response to the
interrupt because used_idx == last_used_idx, which is considered a spurious
interrupt.Once certain conditions are met, this interrupt can be disabled.

The local_bh_enable during the busy polling process allows softirq to be
executed and interrupt notification to be enabled. Removing local_bh_enable
will significantly reduce the number of unhandled interrupts.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5a3c0f40a93f..f5737c551666 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6763,12 +6763,12 @@ static void __napi_busy_loop(unsigned int napi_id,
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
 		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
 		bpf_net_ctx_clear(bpf_net_ctx);
-		local_bh_enable();
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
 			break;
 
 		if (unlikely(need_resched())) {
+			local_bh_enable();
 			if (flags & NAPI_F_END_ON_RESCHED)
 				break;
 			if (napi_poll)
@@ -6784,6 +6784,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		}
 		cpu_relax();
 	}
+	local_bh_enable();
 	if (napi_poll)
 		busy_poll_stop(napi, have_poll_lock, flags, budget);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-- 
2.48.1


