Return-Path: <netdev+bounces-297778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmh3OIiUKWojaAMAu9opvQ
	(envelope-from <netdev+bounces-297778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66866B9FD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:44:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297778-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297778-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42F1031B3A4E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07B337BA4;
	Wed, 10 Jun 2026 16:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A21A683E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:35:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109342; cv=none; b=UUrL2zVTwvXBB1oi69ctlAudgVc3Z3hcjuICVi3q2M/QigPVxI9hHK/mAgZ8BJ1ULdoMcqXPaZ/wlQQ6BeRjeNJpkfaFh4nx9JwZwZZCov0COxRqMz0b7ISZIOfOyQart8TZ81bWIXLQY6MmsCvQgWT68UKJPbwIsAR2GxH1W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109342; c=relaxed/simple;
	bh=RNrOcw2cd6RSgaCwtIgv/AGzXa3s9CKa0YF2HEC519k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I93SYU3d6VAYZxRBsbeF1qNdjK8joGYRdzhaQR2lKukRA3nfzxJyPcVgtIa0svGhlzJKh69Qwr5XU7UMCIvIiZLyqA/Ptce3n4XCH95uJ49kPX9qo/wWwKEWivo3YEkiH1eFdJjBLVbquK7FNm8eTJ6D53lkuNesUKGZPas14G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACHqMJFkilql_R3AA--.54502S3;
	Thu, 11 Jun 2026 00:35:20 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] rxrpc: input: reject ACKALL outside transmit phase
Date: Thu, 11 Jun 2026 00:35:12 +0800
Message-ID: <16a8974906e0d32578ffc2a47bba2329939b50e0.1780989782.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780989782.git.bronzed_45_vested@icloud.com>
References: <cover.1780989782.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACHqMJFkilql_R3AA--.54502S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13CFy8tw13XFy3Aw43Jrb_yoW8trWDpF
	W3Gr4rKrZ8XF4ayw47tryI9a15ZF4kGry3JFyDu3sYvFn8GF1YqF1kKa90qFZ8C3yxGrWU
	JrZrKa4UCa17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsOCWopHlEJIwAAsr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297778-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-afs@lists.infradead.org,m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:mid,icloud.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F66866B9FD

From: Wyatt Feng <bronzed_45_vested@icloud.com>

rxrpc_input_ackall() accepts ACKALL packets without checking whether
the call is in a state that can legitimately have outstanding transmit
buffers.  A forged ACKALL can therefore reach a new service call in
RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been
queued.

In that state call->tx_top is zero and call->tx_queue is NULL, so
rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
null-pointer dereference.

Fix rxrpc_input_ackall() to mirror the transmit-state gating already
used for normal ACK processing, and ignore ACKALL when there is no
outstanding transmit window to rotate.

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rxrpc/input.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..d3fb3bc62e86 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1206,8 +1206,22 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
+	rxrpc_seq_t top = READ_ONCE(call->tx_top);
+
+	switch (__rxrpc_call_state(call)) {
+	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
+		break;
+	default:
+		return;
+	}
+
+	if (call->tx_bottom == top)
+		return;
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
+	if (rxrpc_rotate_tx_window(call, top, &summary))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 
-- 
2.47.3


