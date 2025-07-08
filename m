Return-Path: <netdev+bounces-204803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF54DAFC230
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FE63ADC70
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547F1F790F;
	Tue,  8 Jul 2025 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e/EICdqe"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D321F63F9;
	Tue,  8 Jul 2025 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953304; cv=none; b=RyVZwQ4jWecADDRnI/QJyiotScFlC31n05qJdvUd7I5FwrG5p7tcJY1x+OgrKGiQHpZu/pvqb7zo4OJLyz6q8jNc9qln4HlgRE/3X/npl0j7joHAlfVBkPJ0EVk4ZQSysO1lbA8kCJc1zhGKbe1T3LJWJDlxIYIbZYQtH2+l3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953304; c=relaxed/simple;
	bh=U91KJJNvviR0er8DdpJrBD+Tr8HIK+EjbsXrdILrQaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2LO2kWFkXP+TxznoO7zma8MDpVVsCziSG1tC6zdNbjV2COY95buGqfaRemia9DGWjgko+5tmPG16ls1Chbw50TZONDiJj9bwtTRYrl82AC4C9u7xfzzTax0wsNzXEk48JVjJx2Ot8K6BYZKMuq1z56EoENlsUA6sC1TriqT0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e/EICdqe; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hB
	9+b1LD8EAuIVyKEZhY6u3hXYecNCPzItwCce/1pNU=; b=e/EICdqeC9dOLWPRUY
	wtnCcM3upFl86bf8S7XCHH2afUyXYtRX41OQYO8rVDu54o0EfC36hT4U++Is9XUs
	b3iKsdHESRkoO1HFE5Vr+rwyg+bTn7cq2jE/lwsVNyt4CAuCGbQ4CCzAb/zUJ+qH
	PZd49oIMo5DYdq7LhwLUevn7U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDX7zVmr2xoBK_ADQ--.22627S2;
	Tue, 08 Jul 2025 13:40:55 +0800 (CST)
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
Subject: [PATCH v4] skbuff: Add MSG_MORE flag to optimize tcp large packet transmission
Date: Tue,  8 Jul 2025 13:40:53 +0800
Message-Id: <20250708054053.39551-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX7zVmr2xoBK_ADQ--.22627S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1rCry8tr1fZry7CrW5Awb_yoW8uw1kpF
	Z8Wa98uF47Xw18WFs3G39xur42qan5GFyxKFs5Z343Jr9Fqr18WrW8Kr4YvFsYgrs7CF43
	Zr4qvF17KFWUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZzVnUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQeEeGhsrdEwcwAAsl

From: Feng Yang <yangfeng@kylinos.cn>

When using sockmap for forwarding, the average latency for different packet sizes
after sending 10,000 packets is as follows:
size    old(us)         new(us)
512     56              55
1472    58              58
1600    106             81
3000    145             105
5000    182             125

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v4:
- limiting MSG_MORE hint to TCP. Thanks: Paolo Abeni, David Laight, Eric Dumazet.
- Link to v3: https://lore.kernel.org/all/20250630071029.76482-1-yangfeng59949@163.com/

Changes in v3:
- Use Msg_MORE flag. Thanks: Eric Dumazet, David Laight.
- Link to v2: https://lore.kernel.org/all/20250627094406.100919-1-yangfeng59949@163.com/

Changes in v2:
- Delete dynamic memory allocation, thanks: Paolo Abeni,Stanislav Fomichev.
- Link to v1: https://lore.kernel.org/all/20250623084212.122284-1-yangfeng59949@163.com/
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..b8da621f1552 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3235,6 +3235,7 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 			   int len, sendmsg_func sendmsg, int flags)
 {
+	int more_hint = sk_is_tcp(sk) ? MSG_MORE : 0;
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
 	unsigned short fragidx;
@@ -3252,6 +3253,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_flags = MSG_DONTWAIT | flags;
+		if (slen < len)
+			msg.msg_flags |= more_hint;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3292,6 +3295,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 					     flags,
 			};
 
+			if (slen < len)
+				msg.msg_flags |= more_hint;
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
 				      skb_frag_off(frag) + offset);
 			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
-- 
2.43.0


