Return-Path: <netdev+bounces-279706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNajNuUG5mkIqgEAu9opvQ
	(envelope-from <netdev+bounces-279706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:58:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F5429AAA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555B7303409B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C839BFF1;
	Mon, 20 Apr 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJJVPpqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4239B494
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682714; cv=none; b=WwsrO+xGj46qpJLxABsvW3BfJRCzlmuauPDK5r/UOAic0sgv7MLzYEouY4ehcrUNB7x/XW0AkzCCRhv6iz6acGxh+b4SgLfE/A2I6u9+8gRVcViTlT6JfmpDiOaHxAWbszJSAZ+3dUjiD3FfHPFOsgdbZ11aW7F70l7actcQYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682714; c=relaxed/simple;
	bh=Z/RqQZ5y6bft4hMqHDaUqfOlQhmbzjC0l1HNhO7nBss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkZeews/aDJsSDNokhaco43uwXCqYg2h8n+RtHofYOzs5T57+pwEkp3twWnhzeZ9H4lJf1pyLIzU3OvGBRb8ZqKrkyZa4FQ2OADKu9TeIriZVtQGu4mWBb96U7VjTiEGjhcOGNHx1IZNTLaMZmnM78CGhuPa4f7CRah4ReUsffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJJVPpqu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso4312395e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682711; x=1777287511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQOWKei7Kltdv3X+USCnxklQ74uXe3yFxWu8Qz5lwVU=;
        b=jJJVPpqucET7sdp+zik/1K0WCBhkX0wEZkUdBUuIhuqyC5EMcg0CDVmcl25VK7gDaZ
         ekaE/8XtEQ7PtvT6fNB1YhcLyopAE2DIaoDakL2TBpwagHQU0IoZ42GBFlIy2SvX5Tj0
         LSa6jEKVo0Qp7j8tuiVkWRM3mEtPziw0bfqSewkE/6BSklBnRVy1EqEs6Th0g7mK/U5R
         geyzL1CpPkSl3WjSSN+8sl2Ru/YNCpzNvlwvZSie9q7+ZX/vUykDOOOktNAn+/Y2ZxXW
         +SI7WZMitSlWlYpEB0yRz2c5t9YjyvJBAgJ9JLn+AB3x+q27Z7oj+Y8OONR9np3Of2YY
         IxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682711; x=1777287511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQOWKei7Kltdv3X+USCnxklQ74uXe3yFxWu8Qz5lwVU=;
        b=sgAwWZ7qYnY+EXA5UAx3j9qSUKlOxloEMBcjElI3RJMJm9Rral4H1XcdSIWuNPTWz/
         RA/7ZLG0agroP5LRNoZ8ud1WWAcJ8Z9qMV3bBqSL4LcY/sEXYOQIM0Iby3uQ7PV4EJSD
         xFIXyxebxlZkypbEu51oncg67s81A04q6QrUkYh29UTWH5ZgUDASXz5Uy2KvT/X5aSPi
         3Rn0mcmpZCOZm3nycUxk5BV1vYT7Ye8sOrKwvNVFIkGWm+T/Mn9PWrOZ2YLcuhiXi9I3
         JcS6BTJdiFv5h5ozORXdVG+vXGYfeZe2pi5Zk846koo1R1KxpDM9Txvee9KtEB1PCZ0g
         k+iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F07PASFST6uhYeeEKItcydQqfwtV86b9Qh/Ga8eXK86zvY/AZ0w1KhCHC+pZ/2VZlxkKGPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOcUp0OD7zkAlI9D3bGj3qGG4vLaD/ND0bxzvr288ZXdKudChx
	zQFiOVJzD2kV1O1S17EE25sg52u0jBUoOHj+lKWufLWh8tlolXmnhPno
X-Gm-Gg: AeBDiesL2BKIsXaPoVWUFzRbtCbquOBBEaWykzoeSIaHUrT4TEgf+HdquBe75FXbrXn
	uiYkybHdw7axe8jPo0Qbq0fVaCPipdoo5n7rCuyEFoJ4lXo1k+I/HNL/IwNhEbc7YmC7pL4FxDT
	vSNe+18Y7wFxi6DspmSpo9yvwC3ZAXFGJaGXAdY5orXaMBHAbdl3SMmdHabenqU88VkwEuQEfLL
	gw1/Yl4BUnE1vYWFJQZcDmharCWwO0aR/dy0gx3Fl2SHUjmiier3Ef4AlzRAUX5SYIvAn98VIWr
	0NIJ/Nmpl3AsNzv7tSeDRLivkowUKTpE9vD8HqWMuThTvRmf3mCf4lQlDpnHBMYEMpQ4hP2gIsF
	Oxq2hH+L32SJ64lHUGnlTPZrrR/buP8nEAGfsz7x8Ze8+qeY5EjwVbM1koyYM7qSVlpf9/nV/xC
	rOx2Erl8iPi3GGdA6cvNB14HJTD/74WS+21zq/0g==
X-Received: by 2002:a05:600c:12d4:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-4891f049763mr20239635e9.2.1776682710673;
        Mon, 20 Apr 2026 03:58:30 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 1/6] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Mon, 20 Apr 2026 10:58:11 +0000
Message-Id: <20260420105816.72168-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279706-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 515F5429AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fetch_dst in
ipv4/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/route.h                 |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
 net/ipv4/route.c                    | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..ec2466fd0bec 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
+int ip_route_reply_fetch_dst(struct sk_buff *skb);

 static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fecf6621f679..2290451ed122 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -252,21 +252,6 @@ static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *
 	nskb->csum_offset = offsetof(struct tcphdr, check);
 }

-static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
-	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 /* Send RST reply */
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
@@ -279,7 +264,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (!oth)
 		return;

-	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
+	if (!skb_dst(oldskb) && ip_route_reply_fetch_dst(oldskb) < 0)
 		return;

 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;

-	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && ip_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index bc1296f0ea69..7091ef936073 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);

+int ip_route_reply_fetch_dst(struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl4 = {
+		.daddr = ip_hdr(skb)->saddr
+	};
+
+	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+	skb_dst_set(skb, &rt->dst);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);
+
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, dscp_t dscp,
--
2.34.1


