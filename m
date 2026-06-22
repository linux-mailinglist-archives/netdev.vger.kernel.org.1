Return-Path: <netdev+bounces-301082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id joqDKzwlOWq/nQcAu9opvQ
	(envelope-from <netdev+bounces-301082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3E6AF485
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LbI2v0ck;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301082-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72EC4303E4D7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40D3A5E93;
	Mon, 22 Jun 2026 12:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE837B025
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:05:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129932; cv=none; b=NtaqYXXTGcQcm8eTNG8jBPq+0IbcV/7Jmf8LN1tAkkxWy6kFAp5zYTY4K6woK5T03/KtMTpWC/JySScZGsQeUe4sTTVQPjAajhHdXqG4RTK/Tkp9ZQ2ugijGpVkw/CvlSUOUpcWsCLnq8u3Yws0BdHhPxy4KBeKvvopbaT3Upqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129932; c=relaxed/simple;
	bh=Me0JkBhhzXdHG3A+0nI7/cjpzA+euLipBe1aJ57r19E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyi+31FAW1cM+vovtu20XaD3yAQc1+1sQcpJs9M2VIxLrU+3Bv1LOfQU4jkRpCdVtgjgUsdY139YLBpgGLPD0ipB+eRcQvW6EpvGZrX1XgoYiSMMqUCgF2NoTWqw+VQtUgb7IKju6CnLK67Z9jsjvGkru5ilCy37ml2y9uiGUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbI2v0ck; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b9318997so28989035e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129929; x=1782734729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY+jLSzUjV0iGelsgIOTUb0ZtH9fV1LBMjTKS1AiLeU=;
        b=LbI2v0ckwpQF3z0TsK12SeN5OuNVmP4ZL4LR0yNV8in1eeJXiPlaSgHJoxW2FclnwD
         cW/8LBD9/M4+aAmuEaiUPYmrAEFNzwPgX1RNst0/gGrZ+VEFVMriAt2YIXdeII7ZaqVo
         paNnRSbZJl8kszeG2ICir5wzu05UYJVNLU1qW/ZrlgF8LZBjzZFZid8aumlynUx+yJ/L
         R+oAgAlYijeC/079EYdWP0siXlBm23RgvnyI0ZaBvLcjuZK9UvLEhATpTtSq0VFnm3jg
         N7/htmgqg3uQ3h/CMqtpAPem5BWLYBgNOZzJWEN2nv98O/cB+fgz0VfIBCyVqXiOKPvw
         eiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129929; x=1782734729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qY+jLSzUjV0iGelsgIOTUb0ZtH9fV1LBMjTKS1AiLeU=;
        b=KzNz18We2Yb717lglJISKXT8fkaV26DlLjtcQS7Zvygbp0LJShQUWaujmtSIjLLeI8
         dkzywWlpksDXU5pH0vSjN6xTzTrVMVCs8tNsJt4mo+aniz983XH0Q2+vhV3BtH/eW0De
         JnD8iKg5TIGv+MTIpyyx4zsmSKV1YX90wuz2Moh5C2RhdhCUGLg/6sGR00hIxwby/ivp
         hC+6lWSs0ySvYfSuBqPJBAHFTxDM5G3iISM3HZqCVOKEXnM2dFbVpVBzLTPMzu8Jpjxg
         V2V/5DqyjGZbE3ic/+32JJsSblQWvYam4ih8aGHIJ745p3tBXNlvQCB4c3EKdWd6vHCr
         tIwA==
X-Forwarded-Encrypted: i=1; AFNElJ88fMMAuBbispCZciLSj88Oe6m44yobFb5joiJjSwABCUXEYY+PXOd+gXFUd0OqFKPv8DcP2Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxl+SVkH6xyvJDZT5rBPO571NB5jSrgOEXSNu5AYiVhee+ae73
	/gLpdhtDc146aL4y9DH3ySnNO7Ww32YI92XkJRryghiWVgcfnA5cFcOa
X-Gm-Gg: AfdE7cm265Fgzs4EGtmAyu1GP8Ds5RfIdojChBa5TgsYiGgWQ5UnM24HzRZrAuA6Us3
	MOyivQhgHFxaOkq7r/z8O6RwgET162i2catsnyF0gYoEaUoAkdRZPiEuYbni/rxeeQ40vKSqPkN
	OtP/ZfFu9ZxGqgS2CW1g5H2eMuU7ThGmLWy91sjNCsSmfOajc5dwU5E3T0XT4HliQlUuPsHUFXr
	wh17InecEPX3qG2XQeQTyz7GXsvtc0US/rgDMSw8Pw0E7Z1H3p1LUtIXX3BNvc+iEM1/wuIn/Nt
	+bHTyDfZzRDjcGCjFeX42hU1DPfSQvYAsyCuwHPPKypgHcJPzvRbWmnhsT9JW59kEmW5zLE5onv
	2QyvoYy0fZctEkpYkULHLALsRJabV+lgGzTQFAakexhUhv8elDRvGwLJfnIgintPkf1ZZFl2Z3/
	nT7YAwrL3bgLMhQ05y
X-Received: by 2002:a05:600c:468c:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-4923eeb494emr232891585e9.0.1782129928900;
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/7] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 22 Jun 2026 12:05:10 +0000
Message-Id: <20260622120515.137082-3-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301082-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE3E6AF485

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
ipv6/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip6_route that is almost a transparent wrapper around
ip6_route_output so this patch inlines it.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/ip6_route.h             |  2 ++
 net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
 net/ipv6/route.c                    | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..eb5a60d3babe 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 	return ip6_route_output_flags(net, sk, fl6, 0);
 }

+int ip6_route_reply_fill_dst(struct sk_buff *skb);
+
 /* Only conditionally release dst if flags indicates
  * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
  */
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85cffa..7d2f577e72b8 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -293,21 +293,6 @@ nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 						   sizeof(struct tcphdr), 0));
 }

-static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip6.daddr = ipv6_hdr(skb_in)->saddr;
-	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
@@ -440,7 +425,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;

-	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && ip6_route_reply_fill_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6361ad2fcf77..0fa56c801178 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2732,6 +2732,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 }
 EXPORT_SYMBOL_GPL(ip6_route_output_flags);

+int ip6_route_reply_fill_dst(struct sk_buff *skb)
+{
+	struct dst_entry *result;
+	struct flowi6 fl = {
+		.daddr = ipv6_hdr(skb)->saddr
+	};
+	int err;
+
+	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
+	err = result->error;
+	if (err)
+		dst_release(result);
+	else
+		skb_dst_set(skb, result);
+	return err;
+}
+EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
+
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
 	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
--
2.34.1


