Return-Path: <netdev+bounces-204494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DFAFAE67
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D8117E8DB
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB11D5150;
	Mon,  7 Jul 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ciEutT78"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E7678F2F;
	Mon,  7 Jul 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876228; cv=none; b=hvTCnDv8loHM+GdyF/9kzxX6m997JNJb2GjsBn+ZcMw5UpqtPwGaKbay95jCLXewNHzy/pj4a5ATXi6QoxMM8RxjzftMuBkKX4u3QS0qLF/TpAOExKfQwTEN6zvQRGv3OzR1b/bj50+60piPU2H7XhTSqUuWb+rj05UyRs63NTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876228; c=relaxed/simple;
	bh=hXYSUPUhxwQkI0ghWfpB9b0o7xHhRFwbR0/1sggNjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6qwLi53Uw3k0tTtlVq8JoGBpYoQqZb1j7RiwZcb6xcSJuUWcmPjaXoNuAFNjyr7/MF3Qu5QjLMPkBQkej6oIK+7oiitbMbhkuk+6eiIQ4OG9h7Aya1sWvAGp5s5G2z0thTFBRfAUV2pZnNiUa4BThAg5gfg8PjCInXt77Q9JxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ciEutT78; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oV
	VnIcFqb7r6hIKCk7DeBtS2P/QrPbBx6XW+kGwHsTQ=; b=ciEutT78+PNPW0Utlz
	rq3X2Uhp8qTR1w+ODYu2kc2555HdlNnHOodPpcWkMoOcDsdi34r9pzbIWmS5wJbV
	OpcWlzvLddP6syxk8ZbwHwZGtaT0Luwo5iMZLvozUWy2YHl25tDLjQwL4yRgJX9W
	JSb6wE0MBW5SdgY7FV8xngJ/c=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnN4ZegmtoC+yoDA--.13373S2;
	Mon, 07 Jul 2025 16:16:31 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Mon,  7 Jul 2025 16:16:29 +0800
Message-ID: <20250707081629.10344-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN4ZegmtoC+yoDA--.13373S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr15CryUJr4kAFWDury5CFg_yoW5Jryxpa
	y5K342y3WDJr1Iqw18JFs5Jr12vws5JFs8GrWkX34Sywnxtas3tFWIkayjvFyUuFWvy3W3
	ZF4qvr4UZ34DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joFALUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOh6Dzmhrf6RpFgAAsO

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

In fact, as long as pending_refcnt is not zero, even if skb is NULL,
wait_for_completion_interruptible_timeout() should be executed to yield
the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
execution condition of this function should be modified to check if
pending_refcnt is not zero.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3d43f3eae759..7df96311adb8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2845,7 +2845,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
-- 
2.43.0


