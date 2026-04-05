Return-Path: <netdev+bounces-275434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lQP4FA7r0WmJRAcAu9opvQ
	(envelope-from <netdev+bounces-275434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 06:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E15239D52E
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 06:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330763009CDE
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55772773E4;
	Sun,  5 Apr 2026 04:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32495242D9D
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775364874; cv=none; b=oic7bmAPlfedwAhgKU9TwqY4GygHxMnf/aOnSDZsP9CKNa7mIbHyCP0xhdCtejVdoc1/npaPFh9Al9gNl+TpkpD+w1AGilRklS0Iw/JUexJPwcdvfrbfIlQvfsIzupkIRRgJTv4YXaNCQzQYjtM4QQ55GXh0ZX8bkykf2kPV3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775364874; c=relaxed/simple;
	bh=g/OUZVckuNw+zMl3FmSRhQQ6uyd0BUmrtl0ypkALBek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGk+SkJRB0zErY1BysEFRgO8MPZElhytwF/QYGEJIbhohCF8OE8q/mtS1mVDMCsf3OIeS5RfIymlIxPnkG/K6eZEaX/VvqRmh6xa3ol5BeN6hlYqc3ikaD3tMDVsINYk0BsQyksZ+ialN4mo8hEMmVUKkHCXwUFmFsOLxkkQ1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAAnv4X36tFpmx0yAA--.26392S3;
	Sun, 05 Apr 2026 12:54:17 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Date: Sun,  5 Apr 2026 12:54:14 +0800
Message-ID: <8b07adfdbda1c0fbcf10a114f3272b848d4ea3a0.1775269941.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775269941.git.caoruide123@gmail.com>
References: <cover.1775269941.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAAnv4X36tFpmx0yAA--.26392S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZryxXFy3AF1DtFWruF1DAwb_yoW5Gw47pa
	y3KFW5KrWqgFWS9Fn2kF1xtr43GFs7JF13tas5Cw43Wan8ta15CF17WFW7XFn0yr4jkay5
	Zrn0gr1jkrW5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQMICWnRM-0DAwAAs1
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-275434-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,windriver.com,dektech.com.au,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E15239D52E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ruide Cao <caoruide123@gmail.com>

tipc_get_gap_ack_blks() reads len, ugack_cnt and bgack_cnt directly from
msg_data(hdr) before verifying that a STATE message actually contains the
fixed Gap ACK block header in its logical data area.

A peer that negotiates TIPC_GAP_ACK_BLOCK can send a short STATE message
with a declared TIPC payload shorter than struct tipc_gap_ack_blks and
still append a few physical bytes after the header. The helper then trusts
those bytes as Gap ACK metadata, and the forged bgack_cnt/len values can
drive the broadcast receive path into kmemdup() beyond the skb boundary.

Fix this by rejecting Gap ACK parsing unless the logical STATE payload is
large enough to cover the fixed header, and by rejecting declared Gap ACK
lengths that are smaller than the fixed header or larger than the logical
payload. Return 0 for invalid lengths so callers do not treat malformed Gap
ACK data as monitor payload offset, while preserving the declared size for
valid but unused Gap ACK records. This keeps malformed Gap ACK data ignored
without misaligning monitor payload parsing in unicast STATE messages.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/tipc/link.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..a364822c1cd8 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1415,12 +1415,20 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 			  struct tipc_msg *hdr, bool uc)
 {
 	struct tipc_gap_ack_blks *p;
-	u16 sz = 0;
+	u16 sz = 0, dlen = msg_data_sz(hdr);
 
 	/* Does peer support the Gap ACK blocks feature? */
 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
+		if (dlen < sizeof(*p))
+			goto ignore;
+
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
+		if (sz < sizeof(*p) || sz > dlen) {
+			sz = 0;
+			goto ignore;
+		}
+
 		/* Sanity check */
 		if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p->bgack_cnt))) {
 			/* Good, check if the desired type exists */
@@ -1434,6 +1442,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 			}
 		}
 	}
+
+ignore:
 	/* Other cases: ignore! */
 	p = NULL;
 
-- 
2.34.1


