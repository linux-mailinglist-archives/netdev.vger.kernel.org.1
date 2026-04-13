Return-Path: <netdev+bounces-278065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MdrHu3h3GmKXwkAu9opvQ
	(envelope-from <netdev+bounces-278065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FC3EBFFC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE306300FFA8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229F39281F;
	Mon, 13 Apr 2026 12:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE82248A0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083416; cv=none; b=p5HJCSoJXrWCFAMcuqnOUbgEUzZsIb/TZPxlDQzMiSNldRc4skxLNA+noHOQeHd68rNQS3zUcT6tcTDIccN7NxKmChiIZzY0oZBx4CiSPNzu8yM+kKMbzgi1VMR+C6/whz+ezKmibBYauYfjWS2dkJDedqv24GYFFDe7w+2BUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083416; c=relaxed/simple;
	bh=sYQ3S67awRQU/gUkuqGYiHbD3EU0qlqgekRw/OTYGmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRCQm3ET57FJYCNQPNwkXPP+0tiBw9gQ3wymSOlC1ayaOdv5luw87aQwB3NPk5zzvob8YSwjn9/huXiztn9L36aQbztYdmX0EMKUpFSsZsTq5YTQzuKYO7l9P0bMNj52p/C0VIR9xmUL1k94S7j5vConWzG7SJjjf9uhtl+H8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABHwAC+4dxpxSvAAA--.46461S2;
	Mon, 13 Apr 2026 20:29:51 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rao.shoaib@oracle.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Mon, 13 Apr 2026 20:29:15 +0800
Message-ID: <20260413122916.1479959-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABHwAC+4dxpxSvAAA--.46461S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fAw18Gw43Gw45ZFyxZrb_yoW8Ar45pa
	yak3WUtrZ0yr4Iv395tryFkr45JFs7JFWxK39rGa4rZF4qgw43Jas0gF1DZr1kJFWUCFWr
	ArnF9Fs0vw4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQwQCWncrd8H+wAAsv
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-278065-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.922];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email,lzu.edu.cn:mid]
X-Rspamd-Queue-Id: CD2FC3EBFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiexun Wang <wangjiexun2025@gmail.com>

SIOCATMARK reports whether the receive queue is at the urgent mark for
MSG_OOB.

In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
so they should not support SIOCATMARK either.

Return -EOPNOTSUPP for non-stream sockets before checking the receive
queue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- Rework the fix based on maintainer feedback.
- Drop the receive-queue locking approach and reject SIOCATMARK on
  non-stream sockets instead, since it is only meaningful for MSG_OOB.
- V1 link: https://lore.kernel.org/netdev/f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com/

 net/unix/af_unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b23c33df8b46..09d43b4813b1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3300,6 +3300,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			mutex_lock(&u->iolock);
 
 			skb = skb_peek(&sk->sk_receive_queue);
-- 
2.34.1


