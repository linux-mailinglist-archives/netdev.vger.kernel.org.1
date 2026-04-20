Return-Path: <netdev+bounces-279656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aWG9LXSf5WkbmQEAu9opvQ
	(envelope-from <netdev+bounces-279656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:37:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A6426908
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 05:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33A9B3009566
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB26376BEC;
	Mon, 20 Apr 2026 03:37:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3235A381
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656239; cv=none; b=DR8ktjyNKpuceUNwEAezjqpR6hqO1PVnA+yse94kKNqMaF9MPrr+cPwyuWu9FFGB+htct3DvC/TDq6RY+3h9bZjpgboEERub0stWdFMwKHPUzK6OWhWpgS51oV+NnYFdWpb2/pHr+xe3khD8LtCqXyhkl2JvHmFL2HrO9ggmi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656239; c=relaxed/simple;
	bh=PTbjoGPm64msAqWgOgjeY2UgjqbYpW4zVyu+2IlNjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv1iTQY4h3DjUn3tJBa+V1XWgzAmdj0hiwTL8gub2fQo3ySoiB+jbCp495Mg9rZA52PPJSo8SGUfogFpx14QqA/JpU7PTX9ldO2Dju13UQQJcSubh0wJB4XOVcK6zVH3fzfR3Pq8kwkRCH6xQMAPe/2zLN8iruOJrMqQ+2mRJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnHwBbn+Vpo7XVAA--.49949S3;
	Mon, 20 Apr 2026 11:37:06 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jbenc@redhat.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	lx24@stu.ynu.edu.cn,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: nsh: handle nested NSH headers during GSO
Date: Mon, 20 Apr 2026 11:31:32 +0800
Message-ID: <6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776597597.git.caoruide123@gmail.com>
References: <cover.1776597597.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnHwBbn+Vpo7XVAA--.49949S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFykZr4fXw43CFyrKr4kWFg_yoWrZFWkpF
	13KFn8KrZ3JrWayFWkGr48Jr4fKrZ5GayagF43Jwn3XFs8Wr1fZF1a9F42vw48A3yrCryI
	yF1qvrWruw4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQADCWnkluAMVwAAsr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	TAGGED_FROM(0.00)[bounces-279656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DA1A6426908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ruide Cao <caoruide123@gmail.com>

nsh_gso_segment() currently redispatches the inner payload through
skb_mac_gso_segment() after stripping one NSH header. For nested NSH
payloads, including Ethernet-encapsulated NSH payloads, this can cause
repeated re-entry into nsh_gso_segment().

The existing validation added by commit af50e4ba34f4 ("nsh: fix infinite
loop") only covers invalid header lengths and does not address repeated
self-dispatch across nested NSH payload chains.

Handle nested NSH headers iteratively in a single nsh_gso_segment()
invocation. Unwrap consecutive NSH headers until the first non-NSH payload
is reached, including the case where the next redispatch target is reached
through ETH_P_TEB, segment that payload once, and then restore the full
outer encapsulation on each output segment. Also route validation failures
through the same unwind path so the skb state is restored after any partial
unwrap.

This keeps nested NSH GSO handling correct while avoiding recursive
redispatch.

Fixes: c411ed854584 ("nsh: add GSO support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/nsh/nsh.c | 75 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index bfb7758063f3..89c240c2ed7c 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -77,7 +77,7 @@ EXPORT_SYMBOL_GPL(nsh_pop);
 static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
 {
-	unsigned int outer_hlen, mac_len, nsh_len;
+	unsigned int outer_hlen, mac_len, nsh_len, total_pull_len = 0;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	u16 mac_offset = skb->mac_header;
 	__be16 outer_proto, proto;
@@ -88,40 +88,73 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	outer_hlen = skb_mac_header_len(skb);
 	mac_len = skb->mac_len;
 
-	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
-		goto out;
-	nsh_len = nsh_hdr_len(nsh_hdr(skb));
-	if (nsh_len < NSH_BASE_HDR_LEN)
-		goto out;
-	if (unlikely(!pskb_may_pull(skb, nsh_len)))
-		goto out;
+	while (true) {
+		if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
+			goto err;
+		nsh_len = nsh_hdr_len(nsh_hdr(skb));
+		if (nsh_len < NSH_BASE_HDR_LEN)
+			goto err;
+		if (unlikely(!pskb_may_pull(skb, nsh_len)))
+			goto err;
 
-	proto = tun_p_to_eth_p(nsh_hdr(skb)->np);
-	if (!proto)
-		goto out;
+		proto = tun_p_to_eth_p(nsh_hdr(skb)->np);
+		if (!proto)
+			goto err;
 
-	__skb_pull(skb, nsh_len);
+		__skb_pull(skb, nsh_len);
+		total_pull_len += nsh_len;
 
-	skb_reset_mac_header(skb);
-	skb->mac_len = proto == htons(ETH_P_TEB) ? ETH_HLEN : 0;
-	skb->protocol = proto;
+		skb_reset_mac_header(skb);
+		skb->mac_len = proto == htons(ETH_P_TEB) ? ETH_HLEN : 0;
+		skb->protocol = proto;
+
+		/* Keep unwrapping any payload that would redispatch back into
+		 * nsh_gso_segment(), including Ethernet-encapsulated NSH.
+		 */
+		if (proto == htons(ETH_P_NSH))
+			continue;
+
+		if (proto == htons(ETH_P_TEB)) {
+			int depth = skb->mac_len;
+
+			proto = skb_network_protocol(skb, &depth);
+			if (!proto)
+				goto err;
+
+			if (proto == htons(ETH_P_NSH)) {
+				__skb_pull(skb, depth);
+				total_pull_len += depth;
+
+				skb_reset_mac_header(skb);
+				skb->mac_len = 0;
+				skb->protocol = proto;
+				continue;
+			}
+		}
+
+		break;
+	}
 
 	features &= NETIF_F_SG;
 	segs = skb_mac_gso_segment(skb, features);
-	if (IS_ERR_OR_NULL(segs)) {
-		skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
-				     mac_offset, mac_len);
-		goto out;
-	}
+	if (IS_ERR_OR_NULL(segs))
+		goto err;
 
 	for (skb = segs; skb; skb = skb->next) {
 		skb->protocol = outer_proto;
-		__skb_push(skb, nsh_len + outer_hlen);
+		__skb_push(skb, total_pull_len + outer_hlen);
 		skb_reset_mac_header(skb);
 		skb_set_network_header(skb, outer_hlen);
 		skb->mac_len = mac_len;
 	}
 
+	goto out;
+
+err:
+	if (total_pull_len)
+		skb_gso_error_unwind(skb, outer_proto, total_pull_len,
+				     mac_offset, mac_len);
+
 out:
 	return segs;
 }
-- 
2.34.1


