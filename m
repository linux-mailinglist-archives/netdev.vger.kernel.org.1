Return-Path: <netdev+bounces-296197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Yj2BXw2JWqYEgIAu9opvQ
	(envelope-from <netdev+bounces-296197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 898FA64F386
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296197-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7537D3001F83
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 09:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D1337C0F9;
	Sun,  7 Jun 2026 09:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91651372EC2
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 09:14:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823670; cv=none; b=MC2ikZ3NX0YWww0WLP1tPCsSdyfhoZ8ukE2RLcQB6lEX/6bXkGkYYlgAk4Cwy/v6dTJYzdO+nZw1v9zvnLiXLHCfg3RPTtTC9bvLtg1VNr4qnVYT6XLrQLf0QttAVesFaEz6XRZvmPKnzKxJMG683HUXpyTyBaRocYvLxpmyhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823670; c=relaxed/simple;
	bh=iErmJWCMvtbEQXD2hnu/Ys+bGMFTDER2vVHmFfCDPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhVOmhCTlAUlUzBZKYxIy3vYB1NIy2fVNFoJILJjD//YCTAFiB43mMxb+7kNvmzcFiFjexG+utVTAZJawSAMfBvMulkcpPZTQpJoK8aRZqCY8nFCrBkCW/4JkFuW9/cHyIVZzmxpyNI7Q6n14fQLx1ZRti1nrAwyK7OzgKtHWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E75hNiVq2OVmAA--.51170S3;
	Sun, 07 Jun 2026 17:14:13 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	xiyou.wangcong@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	edragain@163.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net/sched: act_ife: ensure ETH_HLEN is pullable after decap
Date: Sun,  7 Jun 2026 17:14:01 +0800
Message-ID: <6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780809474.git.edragain@163.com>
References: <cover.1780809474.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E75hNiVq2OVmAA--.51170S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xWF13Cr1ftr48tF45trb_yoW8Wry7p3
	srWr4DKrZrCFy7Ar1vkry8u3y5CFsxG3y7XF4j93yYv3Z5Wr13tFyFkFW7ur18CFZ5ua42
	yr1qqryDAFWDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svP
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsLCWolKdAAbAAAsS
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-296197-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:n05ec@lzu.edu.cn,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,gmail.com,lzu.edu.cn,163.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 898FA64F386

From: Yong Wang <edragain@163.com>

tcf_ife_decode() calls eth_type_trans() after ife_decode() removes the
outer IFE header and metadata. However, ife_decode() only makes the outer
IFE header area pullable before advancing skb->data.

As a result, the decapsulated inner Ethernet header may still be shorter
than ETH_HLEN in the linear data area, or entirely reside in frags.
eth_type_trans() then operates on an skb that does not satisfy its
expected Ethernet header access requirements, which can trigger a BUG in
the pull path.

Fix this by requiring ETH_HLEN to be pullable before calling
eth_type_trans(). If that fails, drop the packet just like the other
decode error paths in tcf_ife_decode().

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sched/act_ife.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index d5e8a91bb4eb..e0075e3f6949 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -759,6 +759,11 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 		return TC_ACT_SHOT;
 	}
 
+	if (!pskb_may_pull(skb, ETH_HLEN)) {
+		qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+		return TC_ACT_SHOT;
+	}
+
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
 
-- 
2.34.1


