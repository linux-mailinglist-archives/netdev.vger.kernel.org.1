Return-Path: <netdev+bounces-296402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /BTGItN0Jmr/WgIAu9opvQ
	(envelope-from <netdev+bounces-296402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC874653B60
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296402-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20C223015732
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643D395AF2;
	Mon,  8 Jun 2026 07:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A1340412
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:47:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904884; cv=none; b=FpKjl5ZJ4Mo9PxGzxzgyOqCHZqC7A+cbQZcJKMcy7C6Px3L7yM9QIZWY3IcKvRpoUK+8tdab1QfkWshhWCGxYSpXH9JHRE7LuI6Yyz4n/fs6KUENSqf6jp/Uhkb0VPnL99sjjjvCQ9D+kvqCDDdBrMFPW3GLr2rQCaL+5UvshpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904884; c=relaxed/simple;
	bh=iLp+pSSxcFOQYdAuXizn0effW15cJ+rVES6Nv93S9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmgglwLqNgzkk2Rd+K5hXDkHcYlen5htQN0jCXyXKYUuJVptuHM20TZfjdFVgTeMP9ivn4II0UxApzg4XYKg8O6t3GS+j4153PcFt75LDme8GSq7PxD38YmJzD9oLtw/Qa5mBq6D9vSQFYMJJzCLgP/KjRFrVGcW4OpWMESBO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnycOncyZqzbRrAA--.51350S2;
	Mon, 08 Jun 2026 15:47:51 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	zcliangcn@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/2] llc: conn: use one state snapshot in llc_conn_service
Date: Mon,  8 Jun 2026 15:46:53 +0800
Message-ID: <86c82b564186dd085fae59984ea481493341b823.1780850934.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnycOncyZqzbRrAA--.51350S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xAr4kGFy5AFyrWFW5trb_yoWrJrWrpF
	Zxur9xK34DXr13uF18JF4DZrZxCa1kGr12kryDJwnxt3WDtr1rCa98tFy2kr45JF9YkrW5
	Jr4qvrn5Ga1xA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK6svP
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEMCWolKdANHQABsi
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-296402-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:zcliangcn@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC874653B60

From: Zhengchuan Liang <zcliangcn@gmail.com>

llc_conn_service() only rejects states above NBR_CONN_STATES before
the state machine lookup. That misses LLC_CONN_OUT_OF_SVC, whose value
is 0.

The LLC state machine can set a socket to LLC_CONN_OUT_OF_SVC, and
llc_conn_disc() does not actually detach or free that socket yet. A
later packet can therefore reach llc_qualify_conn_ev() with state 0,
which indexes llc_conn_state_table[state - 1] and turns the lookup
into an out-of-bounds access.

Take one READ_ONCE() snapshot in llc_conn_service(), reject
LLC_CONN_OUT_OF_SVC there, and pass the validated state down to
llc_qualify_conn_ev(). This also keeps the lookup on one consistent
state value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
  - Use a single READ_ONCE() snapshot of llc->state in llc_conn_service().
  - Pass the validated state into llc_qualify_conn_ev() to avoid mixed state reads.
  - v1 link: https://lore.kernel.org/all/5f646c530f4a0820060499054c46b8dbecebd7be.1778638129.git.zlian064@ucr.edu/


 net/llc/llc_conn.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 5c0ac243b248..9602183d09d8 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -37,7 +37,8 @@ static int llc_exec_conn_trans_actions(struct sock *sk,
 				       const struct llc_conn_state_trans *trans,
 				       struct sk_buff *ev);
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
-							      struct sk_buff *skb);
+							      struct sk_buff *skb,
+							      u8 state);
 
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
@@ -358,12 +359,15 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 {
 	const struct llc_conn_state_trans *trans;
 	struct llc_sock *llc = llc_sk(sk);
+	u8 state = READ_ONCE(llc->state);
 	int rc = 1;
 
-	if (llc->state > NBR_CONN_STATES)
+	if (state == LLC_CONN_OUT_OF_SVC)
+		return 0;
+	if (state > NBR_CONN_STATES)
 		goto out;
 	rc = 0;
-	trans = llc_qualify_conn_ev(sk, skb);
+	trans = llc_qualify_conn_ev(sk, skb, state);
 	if (trans) {
 		rc = llc_exec_conn_trans_actions(sk, trans, skb);
 		if (!rc && trans->next_state != NO_STATE_CHANGE) {
@@ -385,20 +389,20 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
  *	Returns pointer to found transition on success, %NULL otherwise.
  */
 static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
-							      struct sk_buff *skb)
+							      struct sk_buff *skb,
+							      u8 state)
 {
 	const struct llc_conn_state_trans **next_trans;
 	const llc_conn_ev_qfyr_t *next_qualifier;
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-	struct llc_sock *llc = llc_sk(sk);
 	struct llc_conn_state *curr_state =
-					&llc_conn_state_table[llc->state - 1];
+					&llc_conn_state_table[state - 1];
 
 	/* search thru events for this state until
 	 * list exhausted or until no more
 	 */
 	for (next_trans = curr_state->transitions +
-		llc_find_offset(llc->state - 1, ev->type);
+		llc_find_offset(state - 1, ev->type);
 	     (*next_trans)->ev; next_trans++) {
 		if (!((*next_trans)->ev)(sk, skb)) {
 			/* got POSSIBLE event match; the event may require
-- 
2.47.3


