Return-Path: <netdev+bounces-301081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zAVBRYlOWqznQcAu9opvQ
	(envelope-from <netdev+bounces-301081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:05:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7946AF471
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VLwhaMa1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301081-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852DF3033537
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3139A812;
	Mon, 22 Jun 2026 12:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E7378D98
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:05:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129931; cv=none; b=D5rrmsfHxNrPSRvq246wQhthBtaJPI0RSBfRhVW88ePUsPerTiE00FlrPH8CD6gtgccwf9xqoz4J4HIk4rdFbuvmtfg8hf41vhozRTbmxXBHcIyzT+spIVHECb8OSkpWDNE2OXJ/QgFhUgnUd6amCXX4vs7D9hatIN8hjwlggDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129931; c=relaxed/simple;
	bh=jq2Q7kF2niLdJHIw0DqhPfXbN3I9G2RrHLnNNIj0aVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyZjfSXljVnjzSLpSpya6AQmdycZ/8ClFlNMPxtHepvbVsMgYyjnyJRoHYTu9C0oS+jima1hqH1eo82zAjBXGwQ8Zs7CrdmdmRZEO9XB6UvmS+nwVN1RBDesl8oxrgRmy9x9Dzvv5JCbaf1c4PVJbk7KWEysBKmWTIJV3xQPnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLwhaMa1; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so3335262f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129928; x=1782734728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmxexLRgCg6Lmd6HPPcx8J9aTH3v2szSsHJ7h8NrQDY=;
        b=VLwhaMa1OG1Gd7EZ1pGpyswFaThbgKepoqzUGiRA36PrOUgXlDp5zlgpWlzZUdCWq6
         8n3C16/sY9Nre3WKaTru4IBT7FpH8ZGFrHuODq/NhmieHoNg5ctYkevGGjXFD5kMS/3U
         Jv1M+ydmmJ9+DEB8LvdzyRWB/KDFDVRIWZ4L8i1HtpGHRSTDx0fikgLKgDYGe6jhuvy2
         leufWbwJZFlkl0KVkKr3QcVP4krNqMmWQEfp04NB47LD2sG3UGzNaNf281m0zo7GtmnO
         FBeEeOqkCOz0PxAq1DILfhR6wFFr95k7GNJV1Q36RP2lDC6O8Kx8r6RevSUL4c6ikvHs
         DSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129928; x=1782734728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmxexLRgCg6Lmd6HPPcx8J9aTH3v2szSsHJ7h8NrQDY=;
        b=PFg3Kk53N3IpQ72mTOznkYpbGA+i6Ey4q191DxOGChi52ZkchuUqP7vZXT4lLe10UB
         Y04jNkvatEGwkYxCrPO3z/Wcd1TxFbjsseGFuk4wVkKhmpEUaRBKlO0VBkxx8Tf0zBnJ
         dTjbvLaWMEy3wJ3mEoEKbbU5kDE2FtQz+5nu7c+4dOGjGfFyhU+Fea+GmrY9ZSK4SI1K
         6XjaAuK5YnkkpaxvAHh4fCPwjRp5QMOw2k1fdWMdZgP2G+36ctPoFYLrZ5oBJJ+W4L+6
         FI0KBXxj3TaTBWG5XcR4WTqh/95E4POGFtPkjs4QCdcL8zuKWIHGsmHinA/kV0CzGB83
         Wg8w==
X-Forwarded-Encrypted: i=1; AFNElJ80B/VrLe6LxC8U5t/M260panplIabfolrw/8ENT/tqaXZ93ndE8jr7NUa5KD7CtZM31q228fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIslxKzRBn7YF4JXKSiJp4dR0+kt00SqAnYH1h1XhUPzuVwxz
	2eF1VozxqKeI5ZIYJXK4bD0D9tj3+ZTCihsNNZcMg2bBttTEeg9hEPtV
X-Gm-Gg: AfdE7clpJWilewWFIZRzGBeDqDL3bXSGRf9KtngirXVJHfSByaJDxxfPJ90DVtaFbKQ
	nyBNeWE/0pOYmEb6458e49KHgNpQBcMT1wQPeIhZL4+HvoSEv87AjpUsaIljDPqwJE+Y4tQw/rC
	dyPAOglRd9Aiu2f3g4tSYas7FWJDJ7FNtGw8FZpz1HVLtpgyFfXRV49TsFiohPzCkdy2KVaV7yc
	7MQn3dwEhfEbbT9upvW5nyVtZjs3NeBltVR8Hf95344MYF6bnOxSlziqAqINUBv9ApCsIMXSLD6
	6yf57EA4BnzIAxWvaCuyit1HWpU/tad8CmZWlYK8G+sGZg4L4qZKFQz8ScwDSK3vNTuHDz30/e2
	qJUH/NiG0mT3e60aKcXf42TeyQYnV/7ZCq/uEhqY5pI0jpKcmg77Blv5J+mh86BiHlFowbHX6IL
	/Ct1Zdz32G/XYOLlyNDiod6Qm7XEE=
X-Received: by 2002:a05:600d:4448:20b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-49240ea7f99mr191740295e9.31.1782129928229;
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	yonghong.song@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v8 1/7] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Mon, 22 Jun 2026 12:05:09 +0000
Message-Id: <20260622120515.137082-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622120515.137082-1-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301081-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A7946AF471

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
so that it can be reused in the following patches by BPF kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/route.h                 |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
 net/ipv4/route.c                    | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..300d292cd9a1 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
+int ip_route_reply_fill_dst(struct sk_buff *skb);

 static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fecf6621f679..c1c0724e4d4d 100644
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
+	if (!skb_dst(oldskb) && ip_route_reply_fill_dst(oldskb) < 0)
 		return;

 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;

-	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && ip_route_reply_fill_dst(skb_in) < 0)
 		return;

 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e..f24609933fbe 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2942,6 +2942,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);

+int ip_route_reply_fill_dst(struct sk_buff *skb)
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
+EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
+
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, dscp_t dscp,
--
2.34.1


