Return-Path: <netdev+bounces-297992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1q9iFj9tKmqxpAMAu9opvQ
	(envelope-from <netdev+bounces-297992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7166FB7A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rOR6XUw0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297992-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297992-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C1153013BB7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56267376A18;
	Thu, 11 Jun 2026 08:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B2376BE4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:09:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165357; cv=none; b=EUcaomIkj954HB23Mh3gTczwT/W5wJ9sP005dU1oQ6R5atmk0rHSlSuoDlLJE8BWUJnJkunNHvWaxAaG2H7HPeiypwMcyvCOSbY3hcwpM1RfClk9Bih8vgbd4ZLJO0LuiNkYhJ8jh0izUbOA2S70De3V3twsi9BKkWPlEm9f58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165357; c=relaxed/simple;
	bh=sR75Kxpp9ciWrEqzIhWSy15CiwlustcGI+ACVNAzzmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCosucsrsHFB2LYIPCObfy5wHefKfzekREYEYD6l4V5H8tChelkJOqoTCMmmDugz7vKZcVpjT+G/IiM2CNQORGzvXrXzEy7MfviBehzwmCA5CXI4liAs/EB5mhNGvlBoPMDCz9Nn1h6IkHG3R4fQFbm0EMC2ePN7QFX/nzt1b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOR6XUw0; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf125989f2so57771505ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165354; x=1781770154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEmkuWYgkwtDboU8MaRt1GYSESJN149ZsYa5eKF7+QE=;
        b=rOR6XUw01oMY3DEKqmiZLIDFKJz41ylz9ZwC24Dmvd31Ku5TVFwM8paItgRDhaoT7f
         OJiXW0t0cL/t/bVaeEK6GoaHrkxuRsX6RJibl0BJX9Y0+LuhQ4C1z6sq6JRAV0VnL8Uz
         GlbR4snkE9vXj2MgkfcU7UKaBzppYsFub+5eFKpnlKBFHX5TOqp3BHaHGZTmLpdK2uyD
         f8okEJVW0MHnEA3KbDOOSnNNnsRG8QgMlzmIRVdG99PQQc6teSSVrL+XtchQXGCbw5XT
         BkzRlOQuns2ZX+8jrYlxA/h2tCPAcM4tA0wrPaHvc753gmk9WT1XIne+o8QTjD3yqOo+
         P1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165354; x=1781770154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEmkuWYgkwtDboU8MaRt1GYSESJN149ZsYa5eKF7+QE=;
        b=cze29oVAYeZjuXeKXNdAeiURhvWR/sm28oVOLlb/Bc5zPVthM1OEnn1WZVQfSoQgIV
         6IP6B+7xhmJkM20KYACtaGCCROPQS3H/RzAo62KUw+k1DpxSACvWkGCOKlRNCZXA2cO8
         IR7OnKxn7BBfD2I+XdKoe481qYME6wMC5jKBLqe0WhV9DdKV+kv/P+9IKt6nt9YbWQxy
         dhWIJhN2PdATjDBRjG2f1Xt7HUJDVjp4opONl0PGfpWwU3COkaTksW9FHpZXBWd8zCcy
         vBGdPtUqiL28aG35nerlDUlW3Sp0AUqCkiuX4YrZsejSwIWW77HPwgWCN+NItZ7FV2CY
         tWdQ==
X-Gm-Message-State: AOJu0YxJGvuX6SHZ2nltRU+RO5xo2TFAwZBhH57DB1US9PM3LSBFYTd3
	muZs0aZMiZ5v1FPb8Jd2A3b6pN7dHmuqUGzfaoN2/YDG8KoV6jTKRJJV
X-Gm-Gg: Acq92OG7cVA/VGARAO7BRZfQpMP7ZsI2UBKEQvBSQyUY3+Krl2c2SLw8Q/xRoUbdBHQ
	m6MlueLvPiwflrBhGsMyNWppoJGnbtE02XW3h5yWrSiA7HNEMrJ60rdCRbnomNTYFJENK3HbP4x
	ISVLjPBhl7Y/kRoar8luXB7X2W4GS8LxmdyJXgkIHPMIVRZIfGyOCe6DPzng/qRJfJNs/u5REpx
	nZVlnhaQNlYIgOLbXU3APbCL1+GEwa/14Cs8An8IHQhX0bi+/cJxBKgq/hyGqrH1Lf810ssTaun
	9eLWXy3Go7b7HDa54TvZyThIQUEAYNQ5ZyLrYfCql+sRlwOeqHUm8MrjVffb0CSjDhLuJdLYvO1
	Sn2RP51vx/aCVp7ho9ezHrdjvg13TBGKmiZRVMKPjo827Prb4vfAM0YasK8WZslBtUj2yp8nmNU
	pdyafUgMAsIciH8MPlS9gWw+c897IJvyZopM0BT6PzzeXI84rhHwPCIp72TB4NQsxPBxJKUYoRd
	Q3rYe0d+6QnHoZ0DZgNLJOdJn24
X-Received: by 2002:a17:903:1205:b0:2bf:2114:ecc2 with SMTP id d9443c01a7336-2c2f305ddebmr19239665ad.35.1781165353999;
        Thu, 11 Jun 2026 01:09:13 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm277591035ad.82.2026.06.11.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:09:13 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: Run generic devmap egress prog on private skb
Date: Thu, 11 Jun 2026 16:08:48 +0800
Message-ID: <20260611080850.536996-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
References: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297992-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FC7166FB7A

Generic XDP devmap multi redirect uses skb_clone() for intermediate
destinations and sends the last destination with the original skb. This
can leave multiple destinations sharing the same packet data.

This becomes visible after generic devmap egress-program support was
added: a devmap egress program may mutate packet data, and another
destination sharing the same data can observe that mutation.

Native XDP broadcast redirect does not have this issue because
xdpf_clone() copies the frame data for each destination. Generic XDP
should provide the same per-destination isolation before running a
devmap egress program.

Fix this by making cloned skbs private before running the generic devmap
egress program. Use skb_copy() instead of skb_unshare() so allocation
failure does not consume the skb and the existing caller error paths keep
their ownership semantics.

Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for generic XDP")
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..a3d6c60dbddb 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -512,35 +512,52 @@ static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	return 0;
 }
 
-static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev *dst)
+static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
+				    struct bpf_dtab_netdev *dst,
+				    u32 *act)
 {
+	struct sk_buff *skb = *pskb;
 	struct xdp_txq_info txq = { .dev = dst->dev };
 	struct xdp_buff xdp;
-	u32 act;
 
-	if (!dst->xdp_prog)
-		return XDP_PASS;
+	if (!dst->xdp_prog) {
+		*act = XDP_PASS;
+		return 0;
+	}
+
+	if (skb_cloned(skb)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		nskb->mac_len = skb->mac_len;
+		consume_skb(skb);
+		skb = nskb;
+		*pskb = nskb;
+	}
 
 	__skb_pull(skb, skb->mac_len);
 	xdp.txq = &txq;
 
-	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
-	switch (act) {
+	*act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
+	switch (*act) {
 	case XDP_PASS:
 		__skb_push(skb, skb->mac_len);
 		break;
 	default:
-		bpf_warn_invalid_xdp_action(NULL, dst->xdp_prog, act);
+		bpf_warn_invalid_xdp_action(NULL, dst->xdp_prog, *act);
 		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(dst->dev, dst->xdp_prog, act);
+		trace_xdp_exception(dst->dev, dst->xdp_prog, *act);
 		fallthrough;
 	case XDP_DROP:
 		kfree_skb(skb);
 		break;
 	}
 
-	return act;
+	return 0;
 }
 
 int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
@@ -700,6 +717,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 			     const struct bpf_prog *xdp_prog)
 {
+	u32 act;
 	int err;
 
 	err = xdp_ok_fwd_dev(dst->dev, skb->len);
@@ -710,7 +728,10 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 	 * return 0 even if packet is dropped. Helper below takes care of
 	 * freeing skb.
 	 */
-	if (dev_map_bpf_prog_run_skb(skb, dst) != XDP_PASS)
+	err = dev_map_bpf_prog_run_skb(&skb, dst, &act);
+	if (err)
+		return err;
+	if (act != XDP_PASS)
 		return 0;
 
 	skb->dev = dst->dev;
-- 
2.43.0


