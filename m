Return-Path: <netdev+bounces-297784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fks8MwCgKWpuawMAu9opvQ
	(envelope-from <netdev+bounces-297784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:33:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6F66BF92
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:33:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297784-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297784-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A86D302ACC7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72273343893;
	Wed, 10 Jun 2026 17:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1C28851F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:33:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112828; cv=none; b=JiO4uApgciJBU47SMS2aqxS3CKl8OgAwib+E+SHSTqTHKFb/qyj41n6Q0hnREl5Lq1885faC+zRGisNbXQ42RivaShAzYryARnack0PVyScoNxUuHyqFjzZASRQk0OJwjXiCCL3andfLGDv116LlalZiW7mHjeCk9T6vGmb6vDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112828; c=relaxed/simple;
	bh=K+maDEpyPdOC1FrcjOkvuB703sMgXedPUtlxfT+ghfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu/8lTxxn8tW5fWTvcgNG029YutVCrmK0m1F8xk/ck39PtvThsNEJZXzfH3uj6tb8qqV7nUdw+h7Q5pLoS+bCgb2gXZqRsiI4a5UnjlpZQD8LomCUgSPpYIx6estWr31jeBH9LwoDhZw5q89Kkke19WxOP9KS8Vv4n2gRHBtNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACHqMLsnylqcR54AA--.54546S3;
	Thu, 11 Jun 2026 01:33:35 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Cc: 3chas3@gmail.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	tr0jan@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] atm: svc: fix listen state corruption in svc_listen
Date: Thu, 11 Jun 2026 01:33:27 +0800
Message-ID: <4af79c95e316b9a65a4c6302fc912a5944198b6b.1781031726.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781031726.git.zzhan461@ucr.edu>
References: <cover.1781031726.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACHqMLsnylqcR54AA--.54546S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWrurWUCr1DGF4rWw17KFg_yoW5Gw17pr
	sxKasxWrW8Jr1IqrnayFWUWrn5C3WkJrW7G345J3Z3XanFgF4rX34vqrW5Kr13ArWkCF4r
	XFn8uFZ09ws8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE
	-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsOCWopHlEJawAAsj
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297784-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:3chas3@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:zzhan461@ucr.edu,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,ucr.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucr.edu:mid,ucr.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BB6F66BF92

From: Zhao Zhang <zzhan461@ucr.edu>

svc_listen() can corrupt the vcc_hash hlist by inserting the same socket
twice. The function never validates that listen is only entered from the
unconnected state, and it publishes listener state even when the
signaling daemon reports an error. A connected socket is already hashed,
so calling listen() on it re-adds the same sk_node and causes hlist
corruption. A successful listener can also later flow into svc_connect()
and get inserted again because listener state was not tracked correctly.

Fix the state machine in net/atm/svc.c. Reject listen on connected or
otherwise invalid socket states, only mark the socket as listening after
the signaling reply succeeds, record listener state on sk->sk_state, and
reject connect on sockets already marked as listeners. This removes the
double-insert list-corruption bug at its source.

Fixes: 9301e320e98f ("[ATM]: track and close listen sockets when sigd exits")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/atm/svc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/atm/svc.c b/net/atm/svc.c
index 005964250ecd..dfc4f3762bf8 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -168,6 +168,10 @@ static int svc_connect(struct socket *sock, struct sockaddr_unsized *sockaddr,
 		error = -EINVAL;
 		goto out;
 	}
+	if (test_bit(ATM_VF_LISTEN, &vcc->flags)) {
+		error = -EINVAL;
+		goto out;
+	}
 
 	switch (sock->state) {
 	default:
@@ -302,6 +306,14 @@ static int svc_listen(struct socket *sock, int backlog)
 		error = -EADDRINUSE;
 		goto out;
 	}
+	if (sock->state == SS_CONNECTED) {
+		error = -EISCONN;
+		goto out;
+	}
+	if (sock->state != SS_UNCONNECTED) {
+		error = -EINVAL;
+		goto out;
+	}
 	set_bit(ATM_VF_WAITING, &vcc->flags);
 	sigd_enq(vcc, as_listen, NULL, NULL, &vcc->local);
 	for (;;) {
@@ -315,10 +327,14 @@ static int svc_listen(struct socket *sock, int backlog)
 		error = -EUNATCH;
 		goto out;
 	}
+	error = -sk->sk_err;
+	if (error)
+		goto out;
 	set_bit(ATM_VF_LISTEN, &vcc->flags);
+	sk->sk_state = TCP_LISTEN;
 	vcc_insert_socket(sk);
 	sk->sk_max_ack_backlog = backlog > 0 ? backlog : ATM_BACKLOG_DEFAULT;
-	error = -sk->sk_err;
+	error = 0;
 out:
 	release_sock(sk);
 	return error;
-- 
2.47.3


