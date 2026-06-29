Return-Path: <netdev+bounces-302444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YAygJqTcQWq/vAkAu9opvQ
	(envelope-from <netdev+bounces-302444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C46D58DF
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:46:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302444-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302444-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB523002136
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 02:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1933EB06;
	Mon, 29 Jun 2026 02:46:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366CB1A3029
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:46:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701216; cv=none; b=EvS/O+u/cBYjqJrBcFEiltUrwoswxE/irB02OnbM88SKaoemSmTIaPK7YpJAW5imv8osnfMjlzkao/OX29VXhEBwXjIuOl2xdHQ76lWzYXRhfJRuF7boImH53+OnxIwQKVY2RZ0tT019N2G/2n9wVJkpZGHZDm5KYOiGY0kIWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701216; c=relaxed/simple;
	bh=BkgfDcy080J6soHrHyhB5kJDtVrI82fUjClKXsXhleQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzWWvH+nQ/dnAiCn6RhTot0I6KLLyC7j2HXNVg6ldg6IMbA0u7fOF6QqkLDeCjJaHKQio77vgdAZ3W8lMxl/xkr3g5kqlw9MT+PHdyDy8KMWpeEmdwFlSPGXIPhqtPE3EcrRfgWNex5Hb4fAEfjcuGUQxgBikbRemzHwzXx6X+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Received: from enjou-Legion-Y7000P-2019 (unknown [117.157.85.28])
	by app1 (Coremail) with SMTP id ygmowAD3E7593EFqD3XCAA--.7547S3;
	Mon, 29 Jun 2026 10:46:28 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	peilin.ye@bytedance.com,
	cong.wang@bytedance.com,
	gnault@redhat.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/2] net/sched: act_skbmod: require an Ethernet header for MAC rewrites
Date: Mon, 29 Jun 2026 10:46:03 +0800
Message-ID: <3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782548651.git.bronzed_45_vested@icloud.com>
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E7593EFqD3XCAA--.7547S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13ZFyrAr4DtF4UZr4ruFg_yoW5Jr4rpF
	9Y9rW7Kr9xJr17KF1kCa4UWF45Kr4kGF4agan5K343XanFgF1FgFy0gF429F4kuFWFkr4j
	9r1jvFWrAa1jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
	Cv6cx26r4rMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiCJPtUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQANCWpA2VUKygAAsj
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302444-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:peilin.ye@bytedance.com,m:cong.wang@bytedance.com,m:gnault@redhat.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,bytedance.com,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:mid,icloud.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 700C46D58DF

From: Wyatt Feng <bronzed_45_vested@icloud.com>

tcf_skbmod_act() derives its writable length from
skb_mac_header_len(skb), but the DMAC, SMAC, ETYPE and SWAPMAC modes
always write through eth_hdr(skb).

After a prior action strips the L2 header, skb_mac_header_len(skb) can
drop below ETH_HLEN while skbmod still attempts to rewrite a full
Ethernet header. This is a buffer-size length miscalculation and can
corrupt packet data on short or non-linear skbs.

Reject Ethernet rewrite requests unless a full MAC header is still
present, and use ETH_HLEN as the writable length for those rewrites.
That matches the bytes skbmod actually modifies and leaves the ECN path
unchanged.

Fixes: 56af5e749f20 ("net/sched: act_skbmod: Add SKBMOD_F_ECN option support")
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
 net/sched/act_skbmod.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index a464b0a3c1b8..30c2eac17aff 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -38,7 +38,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	if (unlikely(p->action == TC_ACT_SHOT))
 		goto drop;
 
-	max_edit_len = skb_mac_header_len(skb);
 	flags = p->flags;
 
 	/* tcf_skbmod_init() guarantees "flags" to be one of the following:
@@ -49,6 +48,8 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	 * packets.
 	 */
 	if (flags == SKBMOD_F_ECN) {
+		max_edit_len = skb_mac_header_len(skb);
+
 		switch (skb_protocol(skb, true)) {
 		case cpu_to_be16(ETH_P_IP):
 		case cpu_to_be16(ETH_P_IPV6):
@@ -57,8 +58,12 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 		default:
 			goto out;
 		}
-	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER) {
+	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER ||
+		   !skb_mac_header_was_set(skb) ||
+		   skb_mac_header_len(skb) < ETH_HLEN) {
 		goto out;
+	} else {
+		max_edit_len = ETH_HLEN;
 	}
 
 	err = skb_ensure_writable(skb, max_edit_len);
-- 
2.47.3


