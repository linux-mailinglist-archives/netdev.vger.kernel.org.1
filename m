Return-Path: <netdev+bounces-292945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDmXMNjzGGoMpQgAu9opvQ
	(envelope-from <netdev+bounces-292945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C125FC417
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D0E23015D14
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698833ADA8;
	Fri, 29 May 2026 02:01:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2804189F43;
	Fri, 29 May 2026 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020095; cv=none; b=PBZU5rzIVR260EXzRzZQRvvnE1vyVgH2XnRVw7NRjIYZxlh7FDZCrIUpzZt9is5DqqEELyAjgbToR7LFxxDZMkv0HbOU5c0c4QXvJIl18WcuZehD/O/nMoVHJ6Ftvc/nY6MucYKKbVVN9BQLzfKblkdfd1HuqLV+A5XRYVHw9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020095; c=relaxed/simple;
	bh=PABjILJp1QVmtSZRNSQ0zmobsIJp6cw3kySkJ/jZmyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0X1jPq/9FUgl7BuUonOleqz0kjnnePbhwqDPKVryL39bpDs62VrEujpCR5Ws21i/xsj6CiLTIWh4k/rr0QGFRN9ZbJtSdaLRFQpAdPJMPEyplChC1GxopjG+6NmXVIHB0OscWGIJa8DGETgJz0j3jBwqjM54iX4Mtw+Ku/YmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3GNFd8xhqkJUWAA--.4625S2;
	Fri, 29 May 2026 10:01:01 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Breno Leitao <leitao@debian.org>,
	Eric Dumazet <edumazet@google.com>,
	Ernestas Kulik <ernestas.k@iconn-networks.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] llc: Fix race between sock_orphan() and timer callback in llc_sk_free()
Date: Fri, 29 May 2026 02:00:59 +0000
Message-Id: <20260529020059.3024038-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3GNFd8xhqkJUWAA--.4625S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3WFyfCrWfZrWxZF1DJrb_yoW8Zw4UpF
	45CFy7KFyqvrZIvFWftF1kGrn3Xan3K3y7CrWDCr4fuwn8Jr15K34rt3yq9Fs0yFs5Cry3
	Jr4kWr4rCa1kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292945-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ucas.ac.cn:email]
X-Rspamd-Queue-Id: 40C125FC417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In llc_ui_release(), sock_orphan() was called before llc_sk_free()
stopped all LLC timers. A pending timer callback
(llc_conn_ack_tmr_cb()->llc_process_tmr_ev()->llc_conn_state_process())
could fire between these two operations and dereference the
NULL sk->sk_socket that sock_orphan() sets, causing a kernel
page fault.

Fix the race by moving sock_orphan() into llc_sk_free(), after
llc_sk_stop_all_timers() has completed. This guarantees that
all timers are stopped before the socket is orphaned, eliminating
the window for the race.

Fixes: aa2b2eb39348 ("llc: call sock_orphan() at release time")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
V1 -> V2:
  - Replaced sk->sk_socket NULL checks with moving sock_orphan()
    after timer stop, as suggested by Paolo Abeni.
Link: https://lore.kernel.org/lkml/20260526013541.796307-1-xujiakai24@mails.ucas.ac.cn/T/#u
---
 net/llc/af_llc.c   | 1 -
 net/llc/llc_conn.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 35278c519a30..92f3576b339a 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -227,7 +227,6 @@ static int llc_ui_release(struct socket *sock)
 	}
 	netdev_put(llc->dev, &llc->dev_tracker);
 	sock_put(sk);
-	sock_orphan(sk);
 	sock->sk = NULL;
 	llc_sk_free(sk);
 out:
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..c02285441592 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -977,6 +977,11 @@ void llc_sk_free(struct sock *sk)
 	llc->state = LLC_CONN_OUT_OF_SVC;
 	/* Stop all (possibly) running timers */
 	llc_sk_stop_all_timers(sk, true);
+	/* Orphan the socket after timers are stopped; otherwise a pending
+	 * timer callback could dereference the NULL sk->sk_socket that
+	 * sock_orphan() sets.
+	 */
+	sock_orphan(sk);
 #ifdef DEBUG_LLC_CONN_ALLOC
 	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
 		skb_queue_len(&llc->pdu_unack_q),
-- 
2.34.1


