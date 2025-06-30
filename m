Return-Path: <netdev+bounces-202323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE06AED54A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970CC3A6D6B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF220FA9C;
	Mon, 30 Jun 2025 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iPbGolaQ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443621ABB1;
	Mon, 30 Jun 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267489; cv=none; b=uVaD5+kndoneFYO27zKge8uvNtq9e7Jzzmy37YcOSR/xWQbGZ2b60DEm6LuWv9ktg8jYOHajRCPw2KJcYV7C04Od5Drj585YMLTzYHAUIFa5oaWHtSshUbofoaeY99MCfuzLgo5a5npMn5H8XFYB7M/fMpvSRjB/xpjchoj9K+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267489; c=relaxed/simple;
	bh=aLJ5Fh7woyj6lcXkF33z0s0wIaI2PABc4me1NR5K6wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUF5PS8AY9N2Kdpkmxh18RIupzyNPNCVOx6P2pC1JDUxlxavCouFHKuP9Eb2ae/F7eGbBtGl8MJyYjH2k5ZbELC5j44zhLoCzVWfcRHqM/6e71qmePuspX9DRWKonZaAVqpHWA2tx9vFJkL0ejwzt7jvdBwcevdEpP97bpBJtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iPbGolaQ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mq
	+lCN5C85/urD5+hhWk5hPE/mDa4QuDWCpfswWybYs=; b=iPbGolaQYSsX2LY5Lg
	YeS8LyytWOVYe7IWNc/iQ19vSx6etOz9qnODdMMDIC3dj8YApUId4XvKbmENke6w
	a0saHNE93OvkVY4S6H5heKlRk1iRoTZX+5RWGUFcyMOaWXcts+6vmpO8r1R68CWh
	7xakozcZpQdUraaw6f2ruoRvA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHzzBlOGJoS3s5Bg--.7606S2;
	Mon, 30 Jun 2025 15:10:30 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	almasrymina@google.com,
	kerneljasonxing@gmail.com,
	ebiggers@google.com,
	asml.silence@gmail.com,
	aleksander.lobakin@intel.com,
	stfomichev@gmail.com,
	david.laight.linux@gmail.com
Cc: yangfeng@kylinos.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet transmission
Date: Mon, 30 Jun 2025 15:10:29 +0800
Message-Id: <20250630071029.76482-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHzzBlOGJoS3s5Bg--.7606S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF17tFyktw15CFyrXF1UKFg_yoW8Aw1kpa
	98WFWDZF47Jw13WFs7Jws8ur47Kws5GFyj9FWYv345GasFqr1vgrWDKrWYvFs5KrZ7CFy3
	XrsFvF1UK3yYvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZiSLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTg98eGhiNtQyRwAAsY

From: Feng Yang <yangfeng@kylinos.cn>

The "MSG_MORE" flag is added to improve the transmission performance of large packets.
The improvement is more significant for TCP, while there is a slight enhancement for UDP.

When using sockmap for forwarding, the average latency for different packet sizes
after sending 10,000 packets(TCP) is as follows:
size    old(us)         new(us)
512     56              55
1472    58              58
1600    106             81
3000    145             105
5000    182             125

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v3:
- Use Msg_MORE flag. Thanks: Eric Dumazet, David Laight.
- Link to v2: https://lore.kernel.org/all/20250627094406.100919-1-yangfeng59949@163.com/

Changes in v2:
- Delete dynamic memory allocation, thanks: Paolo Abeni,Stanislav Fomichev.
- Link to v1: https://lore.kernel.org/all/20250623084212.122284-1-yangfeng59949@163.com/
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..cd1ed96607a5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3252,6 +3252,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_flags = MSG_DONTWAIT | flags;
+		if (slen < len)
+			msg.msg_flags |= MSG_MORE;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3292,6 +3294,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 					     flags,
 			};
 
+			if (slen < len)
+				msg.msg_flags |= MSG_MORE;
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
 				      skb_frag_off(frag) + offset);
 			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
-- 
2.43.0


