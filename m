Return-Path: <netdev+bounces-285922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD2KFFgK/mm1mQAAu9opvQ
	(envelope-from <netdev+bounces-285922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F284F9334
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEEAC30BD374
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8B3D75B5;
	Fri,  8 May 2026 15:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F73FE669
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255932; cv=none; b=eZWMgZFmHL06gzBjZfpnp/DyurZv/4NeMHS3HJOLq1T8E+Gzl9oMq+9+ALj0lWBBuOP+ZBj2SVjstljJP6YsUp/GR6xNP3qKIIvPvjma/cHxlNji8t6BD96M+9zLLCb8GgSAkK67bi2+bTuyN2645i521Ktr1uxj3rMuNVVQD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255932; c=relaxed/simple;
	bh=nck0kZqjMkMaMsNTUP0Bx8WarBnSNZnz+rfVXMAaHpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH4lbvV9KxmPRQPJ7NJAZlljyhGCL5lfwqoLkGLzID6wUR3w+moHNjoHuSl/u0KT1CJGKYrbdF22RU8WYMwJMSpgXuMS/64l41NcDXkvlIkFoCqqguXFuj4iYD+EFZnJc9j9BVBWeUViCdWFMmNT8pzcZfv9lPCWDWQziLq2ZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADXRfYoCP5pHIP+AA--.2636S3;
	Fri, 08 May 2026 23:58:35 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	d4n.for.sec@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] rxrpc: serialize kernel accept preallocation with socket teardown
Date: Fri,  8 May 2026 23:58:28 +0800
Message-ID: <4e9e2d92be94ed4bcb43b70b36fcc3863414d61e.1778230563.git.d4n.for.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778230563.git.d4n.for.sec@gmail.com>
References: <cover.1778230563.git.d4n.for.sec@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADXRfYoCP5pHIP+AA--.2636S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArykWrW3GFyDCF4kWry3urg_yoW8try8pF
	WfGw1ftrWkXr1fuFnaqr40grW5Wa18Jr1UJ397Z3ZYkrn29a4aqry8tay2vr15Z3s5GrW3
	Ar1qka4v9w4xZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEBCWn9o2QIWgAAsJ
X-Rspamd-Queue-Id: 18F284F9334
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,gmail.com,lzu.edu.cn];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285922-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.117];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Li Daming <d4n.for.sec@gmail.com>

rxrpc_kernel_charge_accept() reads rx->backlog without any
socket/backlog synchronization and passes that raw pointer into
rxrpc_service_prealloc_one(). A concurrent rxrpc_discard_prealloc()
sets rx->backlog = NULL and frees the backlog rings, so a kernel
preallocation worker can keep using a freed struct rxrpc_backlog
while updating *_backlog_head/tail and array slots.

Serialize the state check and backlog lookup with the socket lock,
and reject kernel preallocation once teardown has disabled
listening or discarded the service backlog.

Fixes: 00e907127e6f ("rxrpc: Preallocate peers, conns and calls for incoming service requests")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Li Daming <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rxrpc/call_accept.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index ee2d131..4782412 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -471,13 +471,26 @@ int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct rxrpc_backlog *b = rx->backlog;
+	struct rxrpc_backlog *b;
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	int ret;
 
-	if (sock->sk->sk_state == RXRPC_CLOSE)
-		return -ESHUTDOWN;
+	sk = sock->sk;
+	rx = rxrpc_sk(sk);
+
+	lock_sock(sk);
+	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	b = rx->backlog;
+	ret = rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
+					 gfp, debug_id);
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
-					  gfp, debug_id);
+out:
+	release_sock(sk);
+	return ret;
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
-- 
2.43.0


