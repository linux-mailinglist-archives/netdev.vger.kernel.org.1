Return-Path: <netdev+bounces-294299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O7kKO/4IH2q7dwAAu9opvQ
	(envelope-from <netdev+bounces-294299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:46:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D936305A5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:46:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294299-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F5E530089AD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F637F8BA;
	Tue,  2 Jun 2026 16:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF437FF5E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:46:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418812; cv=none; b=P2dBN7Gy9PqqHSCNNZymCMHQ0/uxzCbjuoSEEtvzEWXLh4F7GOq+PsR+5A1mRR14ycQhZE1mdpxmnn81HGVDZBdoGlX4HulsLkF6UKPsi4iD3EXkmvt9FqQ13WbOPs4rnq0iNE7ZMzI4Hh6QdT43KgrVp16VJ/mahyjpGG1k4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418812; c=relaxed/simple;
	bh=HzdCyYXIqOjewQGlLmh9uc9SM9pkThdKvWCFVX6MwpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QP9SBJkJaYpWrTTEaqlQCgWG5QF4u23wiamgyIJO1iX6EnJXKTMVratlZsaLO373SaFK1iIf93eYA33uQuaYdYg9SdMd1372iv1xrMBoTMxuDlo0NNNtelnd2hGjlpAr/lc3eBR8YYKsfc7qTITuqPI24XfxAuS5uujOVna9a4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACXusToCB9qoJxRAA--.9883S2;
	Wed, 03 Jun 2026 00:46:32 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	sd@queasysnail.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH ipsec v2 1/1] xfrm: espintcp: do not reuse an in-progress partial send
Date: Wed,  3 Jun 2026 00:46:27 +0800
Message-ID: <f45b23780569de7e83d695bf5c439815d4ea4e21.1780377940.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACXusToCB9qoJxRAA--.9883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13uw1fGrW5tFy3ury8Xwb_yoW8Kryxpa
	yxWrnrKrWUtry2kF1vkF1IvF4UWrs3Wr17try7KF9rXr90qF13ZFnYgrsFvF4DuayxC34F
	yrsF93W0yw4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAGCWoekk8AYAAGsB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294299-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:sd@queasysnail.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,queasysnail.net,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,icloud.com:mid,icloud.com:email,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D936305A5

From: Wyatt Feng <bronzed_45_vested@icloud.com>

espintcp keeps a single in-flight transmit in ctx->partial.
Before building a new sk_msg, espintcp_sendmsg() first tries to flush
that state through espintcp_push_msgs().

For blocking callers, espintcp_push_msgs() may return success even when
the previous partial send is still pending. espintcp_sendmsg() would
then reinitialize emsg->skmsg and reuse ctx->partial while the old
transfer still owns that state.

Do not rebuild the send message when ctx->partial is still in progress.
If espintcp_push_msgs() returns with emsg->len still set, fail the new
send instead of overwriting the live partial state.

This is a memory-safety fix: reusing the live partial-send state can
leave a stale offset attached to a new sk_msg and lead to an out-of-
bounds read in the send path.

tcp_sendmsg_locked() already handles waiting for send buffer memory, so
the fix here is just to preserve espintcp's one-message-at-a-time
transmit state.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
  - Drop the new wait loop in espintcp_sendmsg().
  - Only reject reuse of ctx->partial if espintcp_push_msgs() leaves an
    in-progress transfer behind.
  - Reword the subject and changelog to match the narrowed fix.
  - v1 Link: https://lore.kernel.org/all/b05daae0607621114d3818722a46c543ab6ec6fb.1780040524.git.bronzed_45_vested@icloud.com/


 net/xfrm/espintcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index a2756186e13a..d9035546375e 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -346,6 +346,10 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			err = -ENOBUFS;
 		goto unlock;
 	}
+	if (emsg->len) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
 
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
-- 
2.43.7


