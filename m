Return-Path: <netdev+bounces-277469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFWMCgce2WnVmQgAu9opvQ
	(envelope-from <netdev+bounces-277469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:57:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6697F3D9EEB
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008573048F2C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E53148D2;
	Fri, 10 Apr 2026 15:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5683AE1AF
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836407; cv=none; b=APJqIZi3HasvZRgHXMKFZkYi3yYlrZK69ARL4nEqzq+tgCzd1MpmKrWnfSidPmVICd045xO/9tk8FaBFBNsy2WNFTnfYrwRGH4DLwEVeqQWKGWNBphZw6mTE8z6jDn6S6xD2L6omR+6QzXIv+5JH8mzjfhi5KQ2aOLxxO24OS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836407; c=relaxed/simple;
	bh=XyJxBrF5IWN79Ozjq+JvCPExBqEUKkO7azPq45Ms1W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwAYv3QGFL+ryzwLkDBPFJLP9VHh480tkK3irzhAq2wtjtl2Xa04w++7NvcPIrryqapOVVUnKkNVo1YvgcGD7FLISE8Fb7zZJq+3a+BjiIxqloGE09y0j//ONv70rosu4ge5seybFgJBwXPF6iRkzBCJEoxsbUziWxXbF1vaFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAA3q_vkHNlpJoq6AA--.7702S3;
	Fri, 10 Apr 2026 23:53:11 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tuong.t.lien@dektech.com.au,
	ying.xue@windriver.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Date: Fri, 10 Apr 2026 23:53:07 +0800
Message-ID: <1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775809726.git.caoruide123@gmail.com>
References: <cover.1775809726.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAA3q_vkHNlpJoq6AA--.7702S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZryxXFy3AF1DtFWrZFWkWFg_yoW5CrWxpa
	y3GFW8KrWqgrWfuFn2kF48tr13GFs7JFy7tas5Gw13Wan8tF45GFy5uFW2qF1Yyr40k3yU
	ZwnIgr1jkrZ8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0NCWnYuV4I-AAAsq
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-277469-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,dektech.com.au,windriver.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 6697F3D9EEB
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
payload. Return 0 for invalid lengths so malformed Gap ACK data is not
treated as a valid payload offset, and drop unicast STATE messages that
advertise Gap ACK support but still yield an invalid Gap ACK length. This
keeps malformed Gap ACK data ignored without misaligning monitor payload
parsing.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/tipc/link.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..44678d98939a 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1415,12 +1415,22 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 			  struct tipc_msg *hdr, bool uc)
 {
 	struct tipc_gap_ack_blks *p;
-	u16 sz = 0;
+	u16 sz = 0, dlen = msg_data_sz(hdr);
 
 	/* Does peer support the Gap ACK blocks feature? */
 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
+		u16 min_sz = struct_size(p, gacks, 0);
+
+		if (dlen < min_sz)
+			goto ignore;
+
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
+		if (sz < min_sz || sz > dlen) {
+			sz = 0;
+			goto ignore;
+		}
+
 		/* Sanity check */
 		if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p->bgack_cnt))) {
 			/* Good, check if the desired type exists */
@@ -1434,6 +1444,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 			}
 		}
 	}
+
+ignore:
 	/* Other cases: ignore! */
 	p = NULL;
 
@@ -2270,7 +2282,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	case STATE_MSG:
 		/* Validate Gap ACK blocks, drop if invalid */
 		glen = tipc_get_gap_ack_blks(&ga, l, hdr, true);
-		if (glen > dlen)
+		if (glen > dlen || ((l->peer_caps & TIPC_GAP_ACK_BLOCK) && !glen))
 			break;
 
 		l->rcv_nxt_state = msg_seqno(hdr) + 1;
-- 
2.34.1


