Return-Path: <netdev+bounces-272869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pt2HTT3yGmFswUAu9opvQ
	(envelope-from <netdev+bounces-272869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:56:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA923517C2
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ABE8300A26C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB383043DE;
	Sun, 29 Mar 2026 09:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D82F3C34;
	Sun, 29 Mar 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774778124; cv=none; b=pWT24fyDiRlI28UzRW0gwmjgvQfA0Scgc0MLiNVXy97utjLZWPp1h1Pokz2YGK60pB7Hnud85q1nVzBx5igSdJem80B02/jZuG95Z3IPpR2cRHYG9guWt1poIEl7dIR9M6yFl+SJL8XKT2lc/0mktEcOK1oSb2acx0veSp7eGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774778124; c=relaxed/simple;
	bh=XrsR9qx45NC4IWVRp22mz2up1Qtx5aeK6S8BgAQv43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNEbLkzUUNCvMvi/1Z8E448wscBe0dbbkLbHh5AySgJ+vowDwuGJDNSS2EsqIjh4dHMX5debaPmSTNhOuONS2wRxkvFyLxiGmXJIWHkN+6CPCHg9h9CTTJkxoIsdhjVkYRyikqN36+/1MkXCjbvWK98UUBE7FMSPkiwVs/tfNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowADHAJjt9shpLzIsAA--.35468S3;
	Sun, 29 Mar 2026 17:54:54 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: security@kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	xuyuqiabc@gmail.com,
	n05ec@lzu.edu.cn,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rxrpc: reject undecryptable rxkad response tickets
Date: Sun, 29 Mar 2026 17:54:52 +0800
Message-ID: <32271ec25eae3d23aae2450ab864f37e9d475e24.1774627789.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774627789.git.xuyuqiabc@gmail.com>
References: <cover.1774627789.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowADHAJjt9shpLzIsAA--.35468S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xZrW7CrWxGr1xCw1kuFg_yoW8Zryrpr
	ZIkrZ3J3s5Jw17Ca1rAr9agFyUtFWUGF13G3ykGr40van7Xr48ZanIqF4jqr1DJFWFkFW5
	AF4j9F1rt3ZxuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQMBCWnH+XsGOgAAsa
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-272869-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,gmail.com,lzu.edu.cn,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA923517C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyuqiabc@gmail.com>

rxkad_decrypt_ticket() decrypts the RXKAD response ticket and then
parses the buffer as plaintext without checking whether
crypto_skcipher_decrypt() succeeded.

A malformed RESPONSE can therefore use a non-block-aligned ticket
length, make the decrypt operation fail, and still drive the ticket
parser with attacker-controlled bytes.

Check the decrypt result and abort the connection with RXKADBADTICKET
when ticket decryption fails.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rxrpc/rxkad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index e923d6829008..0f79d694cb08 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -958,6 +958,7 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	struct in_addr addr;
 	unsigned int life;
 	time64_t issue, now;
+	int ret;
 	bool little_endian;
 	u8 *p, *q, *name, *end;
 
@@ -977,8 +978,11 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	sg_init_one(&sg[0], ticket, ticket_len);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, ticket_len, iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_free(req);
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, skb, RXKADBADTICKET, -EPROTO,
+					rxkad_abort_resp_tkt_short);
 
 	p = ticket;
 	end = p + ticket_len;
-- 
2.52.0


