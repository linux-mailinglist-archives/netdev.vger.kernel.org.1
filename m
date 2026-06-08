Return-Path: <netdev+bounces-296691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dsr3AeANJ2qSqwIAu9opvQ
	(envelope-from <netdev+bounces-296691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582C659D6F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:45:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296691-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296691-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DD833018A09
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC23E3C6D;
	Mon,  8 Jun 2026 18:34:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B63E1211
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:34:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943687; cv=none; b=aGmhAIfBcXP1O4AsnCZ9iHNGCkQonxhXP6j8AD1LG0Bj8XTrL1hV44M0Zkhh2sT4jNpXoV3tgAgMG0aDUZVoMmuHs0zkkvo/dYmePLFR9E6qh9m/PRPUO7T2mC0HCwuguqQHr9YOkSkZmHfHps5LqG+FLo7XmyaRqiCHNpXSPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943687; c=relaxed/simple;
	bh=ucnZlmTMvuYHH0ldg7Rzadpxooc7vDPTejdg/SdlYbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7x+7Je3Sztcp5a23dukI3ex94PevpQgXS+8Y/BT5b7Ta08fD8TaKwKAiswkoqVOmsRcDdieqvi/AdJlYZddOLc134dpymGpk/FiBT8iNQBppIyl54NesjOOON4SBaghTUizOLHul4ievyIveW0XvkRzAflThHT11Avue351eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sQ4CydqRBRuAA--.16762S4;
	Tue, 09 Jun 2026 02:34:35 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	victor@mojatatu.com,
	jhs@mojatatu.com,
	yotam.gi@gmail.com,
	davem@davemloft.net,
	xiyou.wangcong@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	edragain@163.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 2/2] net: ife: require ETH_HLEN to be pullable in ife_decode()
Date: Tue,  9 Jun 2026 02:34:23 +0800
Message-ID: <f988cd8a9bbfacd570329c06eb7df9ec4c75cade.1780901080.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780901080.git.edragain@163.com>
References: <cover.1780901080.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADH6sQ4CydqRBRuAA--.16762S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw17GFWrAFyDWF43JrW7CFg_yoW8Ww4fpw
	13Gr1kKrWvqa47Cr1kWw4xW343Ca9xJFWxWFsYy3sY93Z8Zr17JFySgr45uF10vrZ5Wa9r
	ZrnrZryUCa4DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAMCWome1AKFAAAs9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-296691-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:victor@mojatatu.com,m:jhs@mojatatu.com,m:yotam.gi@gmail.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:n05ec@lzu.edu.cn,m:yotamgi@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,davemloft.net,lzu.edu.cn,163.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2582C659D6F

From: Yong Wang <edragain@163.com>

ife decode may return after making only the outer IFE header and
metadata pullable. The caller then passes the decapsulated packet to
eth_type_trans(), which expects the inner Ethernet header to be
accessible from the linear data area.

With a malformed IFE frame, the inner Ethernet header may still be
shorter than ETH_HLEN in the linear area, which can lead to a crash in
the original code.

Fix this by extending the pull check in ife_decode() so that the inner
Ethernet header is also guaranteed to be pullable before returning.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- move the ETH_HLEN pull check from tcf_ife_decode() into ife_decode()
- apply Jamal's suggested total_pull + ETH_HLEN check shape
- v1 link: https://lore.kernel.org/all/6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com/

 net/ife/ife.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ife/ife.c b/net/ife/ife.c
index be05b690b9ef..7a75947a31e3 100644
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -79,7 +79,7 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
 	if (unlikely(ifehdrln < 2))
 		return NULL;
 
-	if (unlikely(!pskb_may_pull(skb, total_pull)))
+	if (unlikely(!pskb_may_pull(skb, total_pull + ETH_HLEN)))
 		return NULL;
 
 	ifehdr = (struct ifeheadr *)(skb->data + skb->dev->hard_header_len);
-- 
2.34.1


