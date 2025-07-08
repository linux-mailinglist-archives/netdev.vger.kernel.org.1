Return-Path: <netdev+bounces-204772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45357AFC07C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D4542688E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAB20F062;
	Tue,  8 Jul 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QO0w/G4t"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB521322F;
	Tue,  8 Jul 2025 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940447; cv=none; b=EA58+KYXLf7PUglZ5gAR9HmxnedY2cTEDrNx7hAQoSbEskxWffLymUIIhWJq0ZTJ9cMjZksHDY66N3GiF0ZW8UYHlBEmuRQ9iX6KVI0iI5pL/GplLg6vDiZAMi/LVuryDdZK9NUNfxstcQx9gHSesBNas2feNdoXrinlQhqDl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940447; c=relaxed/simple;
	bh=HU5+bFi8QobTfHquwIIBkN9QpxnutF1KUIwAIOIWESs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Alp1FTfVJ2Aa92rLIqBgRZbGI+LKreR/0VIe+5Vg+AbiPtaJl0U/JdjzLXUT5b4MZ7ZznN2pTzOu8RP6OMp3sf1ZTfSfhgY/9eFvlezoGK1TWUhuNlsRJKUdHE2AfzhfTzVV9NwlwBh/IGWemA8vMbI6q4cbNtvQjviJbD74k00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QO0w/G4t; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5z
	orhIvaOkBat1cSqTlRVG3btInGdG0ASdxa2yf4GyY=; b=QO0w/G4tDGHs5KEQa1
	8yH+F4MiKDXgJFe4XGTfe+gUtk/KS1iTVLbj21st/UJWYAAS2MUi2i9ZcW3XwUUp
	dKUkLPB25ot40yE5OJMVcYs4xWVys6BwkCmIGS1qEsDwih8Namn9XpLBrlt+dIOp
	41xtqJjCBn+xscpYzTsap99ec=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCnutkyfWxoh2_qDA--.118S2;
	Tue, 08 Jul 2025 10:06:43 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Tue,  8 Jul 2025 10:06:42 +0800
Message-ID: <20250708020642.27838-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnutkyfWxoh2_qDA--.118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1xXFy7Zr4rKw17Aw1rtFb_yoW5XFWrpa
	y5K342y3WDJr1Iqw1rJan5Xr12vws5JFsrGrWkX34Sywnxtas3trWIk3yjyFyUZFWvya43
	ZF4qvr4UZ34qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrYFAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWwuEzmhse4ZRvwAAsN

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

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
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


