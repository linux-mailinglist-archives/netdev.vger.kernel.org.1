Return-Path: <netdev+bounces-205746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D1AFFF47
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C54D645E17
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CA2E7167;
	Thu, 10 Jul 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WRv5MeGD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C72E3371;
	Thu, 10 Jul 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143236; cv=none; b=H2Od5ad4cgRUuqGCEDXIE0a0Vmch1etPjf/Mn2xJxcYUjA4HeSUq40Zw2z4AghM0nQfR+p2GjSFNOCWW7Rd7oXq16fNGDftHD9RTdmKFimCg27IPMil4ibxmGcgsugCOAuDTTeEnV0tXYHkt2ToL6GSZLt/47ClyfMY+MqCMswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143236; c=relaxed/simple;
	bh=zp37PlGkHfVmmdq48K1DE8QuYM9q30RGH3jGioaNtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmSr59C/6BzntC0K1B/pxYnDDF/PDnmpv9rVQVkLItMXGvU/GrwNsYUkZuxWYXDhzpIcAw84SPW3yi9sgV455WDio7IV6bCnHZMzyeClfTPjZLMrcIGj1f45R2cB4PZUNdOAuaz5oqI8XoIT6adxtj1DHXFIM//4LpGxZwtTv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WRv5MeGD; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jn
	IZhnuu7jsGc4BggO4443W9yHX2Lgf/XTKh0QwjRG8=; b=WRv5MeGDjuS06fDqyx
	N/atfiGN7KNPoBRLa32MbJ8OUaIXwmaMk271m1N6Zu168TM/G8Ete9qJDUxdW0r8
	RLNJCG5eabQ/3F408UwmlXRsMN3DYSbz6GKSoUuEoD4QYwBKiqjgMqOoc4XHxCvd
	Rm8rNshAehcjlqgd+21vVyrpc=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAXowFflW9oGKJ1Dw--.26998S4;
	Thu, 10 Jul 2025 18:26:41 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Thu, 10 Jul 2025 18:26:38 +0800
Message-ID: <20250710102639.280932-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710102639.280932-1-luyun_611@163.com>
References: <20250710102639.280932-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXowFflW9oGKJ1Dw--.26998S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xXFy7Zr4rKw17Aw1rtFb_yoW5urWxpa
	yYg347t3WDGr1Iqr18Ga1kJr12vw4rJFsrGrWkJ34SywnIyF9ayrWIkrWj9FyUZFWDta4a
	vF4qvr1UAa4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV1vsUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxqGzmhvkAiYvQAAsr

From: Yun Lu <luyun@kylinos.cn>

When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
pending_refcnt to decrement to zero before returning. The pending_refcnt
is decremented by 1 when the skb->destructor function is called,
indicating that the skb has been successfully sent and needs to be
destroyed.

If an error occurs during this process, the tpacket_snd() function will
exit and return error, but pending_refcnt may not yet have decremented to
zero. Assuming the next send operation is executed immediately, but there
are no available frames to be sent in tx_ring (i.e., packet_current_frame
returns NULL), and skb is also NULL, the function will not execute
wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
will enter a do-while loop, waiting for pending_refcnt to be zero. Even
if the previous skb has completed transmission, the skb->destructor
function can only be invoked in the ksoftirqd thread (assuming NAPI
threading is enabled). When both the ksoftirqd thread and the tpacket_snd
operation happen to run on the same CPU, and the CPU trapped in the
do-while loop without yielding, the ksoftirqd thread will not get
scheduled to run. As a result, pending_refcnt will never be reduced to
zero, and the do-while loop cannot exit, eventually leading to a CPU soft
lockup issue.

In fact, skb is true for all but the first iterations of that loop, and
as long as pending_refcnt is not zero, even if incremented by a previous
call, wait_for_completion_interruptible_timeout() should be executed to
yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
the execution condition of this function should be modified to check if
pending_refcnt is not zero, instead of check skb.

As a result, packet_read_pending() may be called twice in the loop. This
will be optimized in the following patch.

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Cc: stable@kernel.org
Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v4:
- Split to the fix alone. Thanks: Willem de Bruijn.
- Link to v3: https://lore.kernel.org/all/20250709095653.62469-3-luyun_611@163.com/

Changes in v3:
- Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
- Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
---
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7089b8c2a655..581a96ec8e1a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2846,7 +2846,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
-- 
2.43.0


