Return-Path: <netdev+bounces-298186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8RSzDf3ZKmp9yAMAu9opvQ
	(envelope-from <netdev+bounces-298186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:53:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC590673396
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:53:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298186-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5B2304D74B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201935674D;
	Thu, 11 Jun 2026 15:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEEB35E1C8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193002; cv=none; b=LXitiygia6dRmAy0WTdB6vPgX7/tgG5fl1PEsZnnTTbARrIWzMm5yL3Eo0OZjiR1pCskX2X0r+CGGUc2T8LDdol81H8xGc35b2l/V8RdxvktM9bPcd1pxt5EMHq7iJqgcNylT2iWSKKux2GVzUkA+x7HIesORavXPV7nbWVBS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193002; c=relaxed/simple;
	bh=kaASs3J0ns5Y60qW0MFjJGp6DPoBw/CK9V56zgpT1VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOVw97GxfZnni7UqR0BTd19Yf9DqJiliIKe+dMEXcmrIDkS6h57WC3+bwZY3rG+CymEJLTRm0vv/6lksh1vxX7UkXszR95XBTNawYp0LXHiBRmayg2Fm54nal9ei/79ErKnmXM1yADT2AQ9ujFmpjBRasFFtdeNtVgU6W7Wcrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowADngwsN2SpqpwQnAA--.56415S3;
	Thu, 11 Jun 2026 23:49:39 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	paulb@nvidia.com,
	kuba@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	xizh2024@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net/sched: act_ct: preserve tc_skb_cb across defragmentation
Date: Thu, 11 Jun 2026 23:49:28 +0800
Message-ID: <20260611154939.2615919-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780651977.git.xizh2024@lzu.edu.cn>
References: <cover.1780651977.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowADngwsN2SpqpwQnAA--.56415S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrWw15XF1ktw4DWFy5twb_yoW8Zr48pF
	Z0grZrArZ5JF12k3W8Cr1j9a1ayFs3Wr43Krs3Aw17Jr4Sg3Wrtryxtw4S9r4YkrWUGa42
	y34DKa4ag3Z5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEPCWoqb9EGNQAAsL
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-298186-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:paulb@nvidia.com,m:kuba@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:xizh2024@lzu.edu.cn,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,nvidia.com,kernel.org,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC590673396

From: Zihan Xi <xizh2024@lzu.edu.cn>

tcf_ct_handle_fragments() calls nf_ct_handle_fragments() without saving
and restoring skb->cb. The defrag helper clears IPCB/IP6CB, which aliases
the tc_skb_cb/qdisc_skb_cb control buffer. Fragmented traffic through
act_ct therefore loses qdisc metadata such as pkt_segs and can trigger
WARN_ON_ONCE() in qdisc_pkt_segs() when panic_on_warn is enabled.

Save and restore the full tc_skb_cb around nf_ct_handle_fragments(),
matching the pattern used by ovs_ct_handle_fragments().

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sched/act_ct.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6158e13c98d3..ebd40daf05a6 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -845,10 +845,10 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 {
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
+	struct tc_skb_cb cb;
 	int err = 0;
 	bool frag;
 	u8 proto;
-	u16 mru;
 
 	/* Previously seen (loopback)? Ignore. */
 	ct = nf_ct_get(skb, &ctinfo);
@@ -862,12 +862,13 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	if (err || !frag)
 		return err;
 
-	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &mru);
+	cb = *tc_skb_cb(skb);
+	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &cb.mru);
 	if (err)
 		return err;
 
 	*defrag = true;
-	tc_skb_cb(skb)->mru = mru;
+	*tc_skb_cb(skb) = cb;
 
 	return 0;
 }
-- 
2.43.0


