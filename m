Return-Path: <netdev+bounces-279708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPZoEwAH5mkIqgEAu9opvQ
	(envelope-from <netdev+bounces-279708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1680429AE9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C27B303D0AD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AB389104;
	Mon, 20 Apr 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8N8Uv9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063539B942
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682714; cv=none; b=AG00lXuJH0uJFfkAjnu+6fqfHV37RuZ+YyfNgA2esrj8ok0EGuHoqche9e6U2VOMqxzotdHoKSjMh/gD2PvIbyJvwLrGhh9gUqsqVG0WNwFZ5Cbav3Mv2/70YhxJ0i2m/WzUmNVTSwytzbCqywGLjHMzEeAOfHDIMuLocGfQl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682714; c=relaxed/simple;
	bh=eM+kBof0ulZSr5/cYF9WFtvW3e7WM/D2dX633xCjEDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d27xnxmlcm9WEgiFCOjk/pKvsTcUKzc7Ig1AT6HJK6N5t0tt2LmGlf6QrlFKiXqwrJdfc0sjTJTNjnxXNZvwP/lDI8y1h92uO1jYk0wur044CUgfy2O//vxWIYSjfB7wFH44ORtAhgpLj+vqlbM/bJ4UM15xd12LExjdIYsctnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8N8Uv9c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so44704785e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682711; x=1777287511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIn4y25U9iTbZ6u0/nqOP41USOI/jaT9h/eIclbE8HQ=;
        b=b8N8Uv9ckYN9oVUXD/7//phbUkLfbtPGrLcQAtf35oj318gCD2yyiDFVEuTYq40e6d
         bUb1p5Qqji2+StrZTqqu9UvUz+31sJ7BJxt6Z5o3H0LdJA+Rtk4ZwQ7ErGFc4aBkN11Y
         TCDm3lLqeeW2AAF7F1bxT2Ik5+8Hzr4n1RzW3U2sG8Dcpnn/3T+wKPp4QmO5WZgphRSP
         gC771MiQJ2x2oEB9Y+4s+/+gk8OF2cAlJEycw3keE3MAARsih3WgtzTc2/77c0EfzJp9
         CGoFCdXrNbPZ5ufaRGA+BGq1f6p0aD/dqp3BX83s7rdth1CV9rVUbExMg3J1Sld3NDHg
         N2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682711; x=1777287511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIn4y25U9iTbZ6u0/nqOP41USOI/jaT9h/eIclbE8HQ=;
        b=jI0qZ3hBB9xMxnaMAtdk7En15Vk5MtAqEDFFyrUKJTbnGIrBmoPgYWxYOLiXedByPR
         VYRZXHO49NmsyH9w8moL3rH6oxPdNW5ZhAZ7iToHlAJjU6FtSRosUWY4et4CDono7la1
         00kAFdCr1tGvm5oQ1+FrXabXCXX9Sv+tfraQC/kRPxd6WJWNxmM2epvFBgPI6dFH2ho7
         yboeooAMO5NlvDXxn6GFXIRlpGxCri02CYEDtq4gE3VhC/HrBQiLND3By0oR2QRHVOeJ
         9gChYVl/mLQdWPx8WLsOcsVWPgkbeGGP9uspwEWfFCfBt5TUh+KTDbHhB+KAm5arQUa3
         atSg==
X-Forwarded-Encrypted: i=1; AFNElJ+dlqFm1w80yzRki+0qpZXSon9HvJeJE75Q3zFB0Er4HdfuDm4X2lkIK5cRHisG5I+veGpZwCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywnUmNEqx1C9aT9vikVJeRYRgz4u/C+US/57Yy/tkubuwBhLq3
	cEaIUB+Pc10WYyrzBcVqY9latIHVgyh26Hk/MeL3pcSifekahqUhUzuF
X-Gm-Gg: AeBDiescgtbFKxo2Wi2xf6Ii0ykUBk5xdbAviMC/1H8FkMtlL8B09wlsI3lgFn2ZtQd
	3MBOwiPkYVuuuNCLFvtFz4Dse/gCP1RcKdRlwd4q9t9Z+TtISMcTdDzsdgVZyj/9dZs8TyAeMxW
	T8RQVUynTV32+fbpw65013SYY2m3DUK6J2uUlWqtdTLTDTv3LzNCTVYzPLaIiUkPzAi0RKRR/Pz
	RJ1GUwJ2RNe9plifdXs1TJO9VapHn201ZiQky9CiYaxPncgwTuz3uR31iOVDSsqO3raD+bdKngt
	Ube98wxWllQjKO6H57Da0CgwaG+FFC5pV50o6dlF2kwpp4A42HJ3oSXuYvNiY8b/RepmSL3aXyp
	cMD34po+Wz38mkwI7rwMP4dt7O4lU9iiq8FCj/VldjAQUsnimwevMEr0Bj863Iw1YADNbh9dWMh
	pA51nWqMmfEZjSfqpCdI1bjcRUDXgeIKvtYoMPSw==
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488fb768db3mr193873925e9.19.1776682711203;
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/6] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 20 Apr 2026 10:58:12 +0000
Message-Id: <20260420105816.72168-3-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,iogearbox.net,strlen.de,intel.com,linux.dev,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279708-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: C1680429AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fetch_dst in
ipv6/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip6_route that is almost a transparent wrapper around
ip6_route_output so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/ip6_route.h             |  2 ++
 net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
 net/ipv6/route.c                    | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..3652efec7081 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 	return ip6_route_output_flags(net, sk, fl6, 0);
 }

+int ip6_route_reply_fetch_dst(struct sk_buff *skb);
+
 /* Only conditionally release dst if flags indicates
  * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
  */
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85cffa..9663d1db6d80 100644
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
+	if (!skb_dst(skb_in) && ip6_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 19eb6b702227..41871fddec4d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2721,6 +2721,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 }
 EXPORT_SYMBOL_GPL(ip6_route_output_flags);

+int ip6_route_reply_fetch_dst(struct sk_buff *skb)
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
+EXPORT_SYMBOL_GPL(ip6_route_reply_fetch_dst);
+
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
 	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
--
2.34.1


