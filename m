Return-Path: <netdev+bounces-289043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI3hL4kJC2o0/gQAu9opvQ
	(envelope-from <netdev+bounces-289043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE88456CEA7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D96F3013D4D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D961410D3F;
	Mon, 18 May 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5oCQSnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6440F8E2
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107342; cv=none; b=YkU0jpXl2cX5S4T7jluaWn9vJhpYxE1hE/N1aJrBgVC8ox/rSerYAXPotZN1BVwIK58FHewm+V9NFIdhjNLZyqi33m9sGQucD5dJvSu5gVtxMuiHFYS56JeCCMf4Qcy87zf6lhJ2c5ST3fTxzgvz4qINwKcRhg92LazN0xIM678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107342; c=relaxed/simple;
	bh=ov6+gI2FLpcVjn6o4KEEVsXvNT4PPkAZoGWX5AxLtwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7XV10+VdDmcH/RCFcGea5BE73lp/NJrAlXZMYAsbR9BA10c+4HY0Y7GhpS2TXCeARV4q892jB4YlNjpIopJIi5bMN7Ukep66u4UX+qPU1d+0KaTl5ZVteyIgSCzotY0TKFBiJ5viTA1UpPXjY8N/Y5F6gB5ggBku8PY/dlz5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5oCQSnQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so33370625e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107339; x=1779712139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuw5xtr2C0czpVUWTefIMp0AVKJYHgH7hJ3FkPC09qM=;
        b=l5oCQSnQQU5CAP7YG/rjcAmg1toy3Dlc7pgUlkmA+IANzbFM2/ZLich0GAPJVMFXFU
         F92mM67vT6MnLxDlJYmTe9gDxVXeM32LnPh+xOFSXQUz7EFINSUZsRCROKW4euFSFpkB
         a9D6Emnnjvy51CAdQ6cR5r08hE6A0wko6hvEOQQVKJKf1n1ZiotIegsS9D26JFNURBq6
         0wR0gwC1/XVyj9lS24emdEi+Bt8wOzEOh59r712qjFne+7XVoVsE7asG82gaoYn5mrgP
         TQrJaxYmUG9wymPvIsfLwQfFxZKS38CYrYFkL5luWLAp+XvROe4Ttzx/V7Vwd/Ue/t33
         vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107339; x=1779712139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuw5xtr2C0czpVUWTefIMp0AVKJYHgH7hJ3FkPC09qM=;
        b=F25QGVBYCGFv7Mb30/nCGvhm7wBlrZoxQH7IgzE2lRZzInB1aoRUPr0GzpGFBGasHO
         zMsUOnkKstqQKffDyNkvjRRs6XK3pKq31Wef2ZLtaEUahONhN2QsoqCkUFYxI05GNqvA
         FQ5taCNO/tdXxwARfy/yaEC+Sy0MBWTEkx3arHFTpTgW6BvytjvMZW6u68FT5mS/cBOr
         SRRlW+V0BucnbdAhZ9gwUdft5P+D0EYtnpU5TULJs7hIcTsQoJFErkh2Cad+wOaxH8Uu
         zLmP2G/0B6x3UawxcZZNmG9WGfb2zRJ1Go6c/qerac9MfPu4uF5IN+DCY3iUfdQVDSPW
         MLbw==
X-Forwarded-Encrypted: i=1; AFNElJ8/Z9QjpYVNgZY8ZJNSn/c7RMU/ixJ+6bMiCJHwiQmattG+9wdZHy+K6FwzZuFC5S19/m/QS60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vFf6dzD/NJrY7339vEUmatNTiBcN8wLzS0UTZLAKkq6fqVBr
	PgakhBebfXOJPiXZEtlzVAcuxosQO2Ctm7rcmgzgzB/bML1QDzHr+e2w
X-Gm-Gg: Acq92OGoy2A3km1T2RnmDNRV0kpdAOZs5f5QuYWVUT4s9V2MWMZeyuPnCTjPGJqZkyN
	/+NcXwHO+PalBKI7Fb8XgnWTEbwTMpOIIo/CnNRgm5yHpRFFogv8StAOpLQqThE22MdpwveSyEC
	/u7JBKUiQHl49xsX8JScqwmGqcYngTaQsqNWCbMKo6tSOEIt13RsMcMbWL3j1Oh8A0kqZYDdJmu
	gSEzqyv+mzej7UN5W26uJxjk1EDtiJ0l5BjC5Fsf9HiwcOIi6P7KMR2GrzLF7Uw5UREvBgPVQ4+
	PtTRaG9EMa/db+4IiUxgnkPMZ15C30XfCzIgZL58wS8Mmupd9xD8g/xOJdNqZxGcCAMr//RKB1Y
	hvQqFx4bxt0PZkkZWK/z9uTpoWsGXaWohMH6K5yY1oDOvUcoeIX9JyUxKLEDKwx2iY3thgN/Bg2
	jUp6rpQn5nsY0gMSgYtuLQTKB2cvsrJh5F89GH6A==
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48fe651690fmr232880725e9.26.1779107338783;
        Mon, 18 May 2026 05:28:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm104304315e9.0.2026.05.18.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:28:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/6] net: move netfilter nf_reject6_fill_skb_dst to core ipv6
Date: Mon, 18 May 2026 12:28:38 +0000
Message-Id: <20260518122842.218522-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518122842.218522-1-mahe.tardy@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE88456CEA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Move and rename nf_reject6_fill_skb_dst from
ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
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
index e3d355d1fbd6..37a7627a94de 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
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


