Return-Path: <netdev+bounces-279299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH2XM5kU4mnZ1QAAu9opvQ
	(envelope-from <netdev+bounces-279299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6676741AB2F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A85C630849A5
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6773B7B7D;
	Fri, 17 Apr 2026 11:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76A3BADB8;
	Fri, 17 Apr 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423985; cv=none; b=GmracWzNb2q+GSDyySUshw3i3bsVq297z2QXyb1oEPVmmeYRjErKqK3wqp7RmjFLXDi32rNdlJpB6sL3w6Bg8gbexiAJFPezEu4ljulBVRXjjEv8admE3owyTfzMLr67fRMkXNgti5dK1YksaiMS56jKVWO1FusDzzpqobZ7k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423985; c=relaxed/simple;
	bh=HkLSyeiNCmaZ/eTzP/RNGQFO3wuTTAdkzPbmhyHUJKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJVo/A2k5wxJaPK6pwDZkGC5Ld7qx2uLGe/d83JnwOBdoz/9HJzlpgoHN2LVvmQgVgwmBGhqSi/VymBOc2jV8k+xLHnsZv8+Kt9PdoYnl1i34jrbMNS9Zv2yC6uvjh9zZj1aThnO0eOLGvkPCLILEwrdeusDgD52wID/bHENh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowACHHoX4E+Jp+bk+AA--.31247S3;
	Fri, 17 Apr 2026 19:05:36 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	takamitz@amazon.co.jp,
	kuniyu@google.com,
	jiayuan.chen@shopee.com,
	mingo@kernel.org,
	stanksal@purdue.edu,
	jlayton@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	yuantan098@gmail.com,
	tonanli66@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net/rose: hold listener socket during call request handling
Date: Fri, 17 Apr 2026 19:01:51 +0800
Message-ID: <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776327338.git.tonanli66@gmail.com>
References: <cover.1776327338.git.tonanli66@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowACHHoX4E+Jp+bk+AA--.31247S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryruF43tr13WF4rWryDZFb_yoW5Xr45pF
	Wakay3Jry8Xw1v9Fs3tryUZrnxA3Z7J39rGrW5G3Z3CrnFqrZ3Aa4jqa4DXrnxAFWkWFW5
	tr1DZFW09rsrurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAACWnh8+ADoQAAsx
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-279299-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,amazon.co.jp,shopee.com,purdue.edu,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6676741AB2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nan Li <tonanli66@gmail.com>

The call request receive path keeps using the listener socket after the
lookup lock has been dropped. Keep the listener alive across the
remaining validation and child socket setup by taking a reference in the
lookup path and releasing it once request handling is finished.

This makes listener lifetime handling explicit and avoids races with
concurrent socket teardown.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rose/af_rose.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index d5032840ee48..c96325e54a86 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -277,8 +277,10 @@ static struct sock *rose_find_listener(rose_address *addr, ax25_address *call)
 
 		if (!rosecmp(&rose->source_addr, addr) &&
 		    !ax25cmp(&rose->source_call, call) &&
-		    !rose->source_ndigis && s->sk_state == TCP_LISTEN)
+		    !rose->source_ndigis && s->sk_state == TCP_LISTEN) {
+			sock_hold(s);
 			goto found;
+		}
 	}
 
 	sk_for_each(s, &rose_list) {
@@ -286,8 +288,10 @@ static struct sock *rose_find_listener(rose_address *addr, ax25_address *call)
 
 		if (!rosecmp(&rose->source_addr, addr) &&
 		    !ax25cmp(&rose->source_call, &null_ax25_address) &&
-		    s->sk_state == TCP_LISTEN)
+		    s->sk_state == TCP_LISTEN) {
+			sock_hold(s);
 			goto found;
+		}
 	}
 	s = NULL;
 found:
@@ -1056,10 +1060,13 @@ int rose_rx_call_request(struct sk_buff *skb, struct net_device *dev, struct ros
 	/*
 	 * We can't accept the Call Request.
 	 */
-	if (sk == NULL || sk_acceptq_is_full(sk) ||
+	if (sk == NULL)
+		goto out_clear_request;
+
+	if (sk_acceptq_is_full(sk) ||
 	    (make = rose_make_new(sk)) == NULL) {
-		rose_transmit_clear_request(neigh, lci, ROSE_NETWORK_CONGESTION, 120);
-		return 0;
+		sock_put(sk);
+		goto out_clear_request;
 	}
 
 	skb->sk     = make;
@@ -1110,7 +1117,14 @@ int rose_rx_call_request(struct sk_buff *skb, struct net_device *dev, struct ros
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_data_ready(sk);
 
+	sock_put(sk);
+
 	return 1;
+
+out_clear_request:
+	rose_transmit_clear_request(neigh, lci, ROSE_NETWORK_CONGESTION, 120);
+
+	return 0;
 }
 
 static int rose_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
-- 
2.43.0


