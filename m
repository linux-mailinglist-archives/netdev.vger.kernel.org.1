Return-Path: <netdev+bounces-291759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKncDXfBFWoiaQcAu9opvQ
	(envelope-from <netdev+bounces-291759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:51:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4F5D9111
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34E18301E11D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815A370D44;
	Tue, 26 May 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syw9Gz+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44C36D9FE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809848; cv=none; b=dDkgpWJ9vaKDK18HwQ633W3EI3HVNVIYr5bRjorD71fy1Pb8h5H386/DW6cA63Wg6We69pMGFqwj92SPqGqk+woiCgWhxxTwAH6YEYyePebk1ooBPrBMnbCsg+CpmsV1oaJmwSYqI/3fmFeymY1iNhq62KQR1Xhnls17idEiv4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809848; c=relaxed/simple;
	bh=VhjFRgrOE/Yr9rD+jFPbkuXk41T6XFz1vqjlVnbwOrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcEpZiUBTvWcXS6tO/o03mV0tmhW5Jd1Fh0d6J93uHVCRW/tfHrRHKywrz///MeCFDsTGIvVpQuSOHHWaKidwudZlinnmRKrt2lo4U7ViildsbZFq8tCjNR93zq6YPrQPzcmMv2Eio9d9FmBNYwRLkoqdzM8ikDihTcumGOhpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syw9Gz+6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so68068795e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809845; x=1780414645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vjPz0DmyFpSASa6mS0vdkZOs2FKmbSch4i9h1Pv3x0=;
        b=Syw9Gz+6My4UCDlXnGVE9gD8Sty5486C8Q7fkma2wJyT+QWVW8W0Dx1Hs1DgRR8waS
         Vz71kAn377a3oFyrzJ/lMxE7/4KGUCcUE5p4e4eILaCgFUhSyYKQifI41ReyQ9QA4Agh
         W5GjYb1tcCb4VuVDurJIRlzPqZ9QGsHP2dlq1yr4nlxqbFOirVTJw6k/CJiceosi6YKR
         Ag+5+VYKECXfuLb3KH8vpQQe/IMSsXV4i4u6yEZoGf4aMnechi0EJ2osuzZnz0q1+cxI
         86NqRgYdFagPWrR1gG/7OolHhdIV4RUjonK62ClmxVZKITF4Wp5Ge6m24X1X+l9nvWAy
         00gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809845; x=1780414645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vjPz0DmyFpSASa6mS0vdkZOs2FKmbSch4i9h1Pv3x0=;
        b=MKG2aaIp7ehe2LNf48mhmuMc09PuUWUiDijODjx4kkyIQ8KywlgyEt5F2p3MrnAAkN
         A2/gxf/g7EZRVwFjT/nSryXD+msm0h6/qodDYyF8Cv/90uwpNqcLVEidyBSudBzW0AZV
         JRGLA9eRfEqZqW3M5VzJVCTLfR3DqAFyMkZDygJ+ysCVfmi1gikUrig7DjCIQeaalnG8
         vLf6kMd2e31VwODiCk7e+G8eXh/JSzjQLwp1610sz9PGN6iL5c6XzpwP+tTLaxiorLv5
         sJn1ARO+NPT0/OgvQqETMq9D2nHUXDvBHk//pPRem6kWftJW4JErg4apOb6L3Ww3FRL5
         PXYw==
X-Forwarded-Encrypted: i=1; AFNElJ/GiXZmU0K8OxUM7iGovTcoGyR1uBWe8o5hd7iqMUsWayxYKFSIoZSX1wxtRsn2nxUNU8CBqvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nJBppyrKbcIGbrAnCT7c61BLMEHbo2DLf14EyViBRghiCwN7
	Gvi/dQPchU4SYF7iNDOZ5tTad5nL/IInB63JeKDtbQoi25caxx9NimhA
X-Gm-Gg: Acq92OGjd/eggCSn6bAufSHugZalvdkTMnIrnNU6UVhiM+VM6CHj99GFrCKQ+vY7rWU
	U3iT3qb/IqGyx/kXPNLRAMeTsSttThgyLC52X57Ni1EjBGCQ9Z3+rkZkEDokYVjqWjEoG7loPNc
	UddmedanBiVSFww11WdmnGaF0YYyOnLdgGQxmnGuAhr9ZmOdf9mXPFE5J1pjhKV575vttFrnWJu
	vajM4CBwuBtg0lIaaU1rjGJNEqYUIjVfK15c5+TmkWKQKbriyk2WJ/xeWc86Cpqn5d1hP2689ib
	kErhuPRMnocLkwujnayh7IRZe2jO5o+NoerwjcVJRTJA4ZWQ0cHaO+BOhtlDE+vc6i2mUXiDljl
	Wd0QjLydXAbNxz+gxx9bCcnfDDMlOYD6JIrFL2FN1F3R5eic2VtMLUf7UxhYQ9o5wIe5/+dY5we
	twNSzx0yDBTulezWJqjRzvc9yn/W+wIBgiW9wEm47y66Uu+k7P
X-Received: by 2002:a05:600c:4583:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-49042252732mr317911715e9.0.1779809844968;
        Tue, 26 May 2026 08:37:24 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:24 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 1/7] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Tue, 26 May 2026 15:37:02 +0000
Message-Id: <20260526153708.279717-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153708.279717-1-mahe.tardy@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291759-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BC4F5D9111
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
so that it can be reused in the following patches by BPF kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

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
index bc1296f0ea69..1f031c5ef554 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
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


