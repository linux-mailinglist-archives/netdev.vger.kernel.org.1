Return-Path: <netdev+bounces-237129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF3C45B3E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E83B78DF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A626301480;
	Mon, 10 Nov 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB2RKXNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5E30146F
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767928; cv=none; b=qy515b272wOzihOCRoaxDRGai/+tzlCXHAfWfQhT3rCxsl/Ex6C3yRlTRxEvyB8P+fOD+lLa7lxTuBCqutXO4S02ulUqLqMpxhBWJI8UjQZolwsCNwD21Ht3vj338vZWyOj7lF0wKb9k4mooNXmWbEW3HpqddruSvqPYfBHhoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767928; c=relaxed/simple;
	bh=kYmzp10Rt9xbxmJL4oT3zy1Oc1kPLSwmfWdM463lRv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K22ocvfRZcbcd3eF/hVPkeK4MbRNZZF+wwsUls8FU0G30OeAu8jqWuUkrQHSxGyJC8eTTb2U5Y2d7BrWZ7pGNOKpJLS9ys2E4RkMAi6fvlwbl6c6eEj6C8JDmi0j+Ur4AhIG9MOxLgkZJasYCt+6MJVIsLBu7YZ77dRgQpmC6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB2RKXNz; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8823fbb4990so47500956d6.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767926; x=1763372726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0LQYesH9Z1C2lj1/Ytda9IJkf24ChcqTSoj3SvH7Zc=;
        b=fB2RKXNzh9+2dAP61xjnXpsvLWv+l30CJY1x5k4hdxj6YRsyG3y56cI7ptxm5t8AQS
         ashP+wUr45i9FEPjN7EQxf29oJ3APkYT1K7xxmgR0ADpAy9zEssgkxtQY7c/kaq63Oqt
         Wq+UMpPY/LsalGAtuWTDzEOaH9H2biPVbDqQy1LFPpFTr587cNSf2fD24w2Q16bsHZ6T
         Q5YmJ92dyYdOMGkJENrNXpF/tLR63yQWda+8X7hcvtODH2o8A2d1oDIaAspBKcYR8OT5
         Jhpt5pdIzVRtpj9kPQBnhdwiS9lqW2ytYWZ8pxgOaiGAoN96YQweMQUs0MnAFsV5EyFc
         eiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767926; x=1763372726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0LQYesH9Z1C2lj1/Ytda9IJkf24ChcqTSoj3SvH7Zc=;
        b=bSgLAP1eOsMpUzFSJAIdSlo27dMcZ3U4RYmz5CCGc4OHDUA1gUM+m4fSviZ4yETJjS
         jVDNMnhQqKPCNaCE9BVV6hzVyjOgTq8KJ/G/wolAPhk+BzsMA4jkdpEHqSCoqPI9sFrn
         Xci1GFadiWEGOdXCxliblmBz+j3IBewXUVoDsWjkw2/YdsMiwxSMnOe3mzAiWJxx22VA
         54oWepyqQvV7HnsomTirPzoUBwW4d0Lw2HKmvwQRYRxraCuVxOJy5zCZaXLtzZ0SpR5l
         VNe5UsYZPnI4gVo08vOyqtjwRHIJ8yg7XHYo19Viqa98sILhKxAOYXT0pdNKPqQzeITj
         MmKg==
X-Forwarded-Encrypted: i=1; AJvYcCUCaEO90IDpR3k+LTp11hhQP9zBk2TzmFo8VS6SoFwPeeeHJtBFRn1uCb7jeutoxRn2bChWjCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe//pmGTbvIZdTCmjA9qJcJq+7eI65ypav44a8RJxget+M3FyA
	r8lTxNl2U4zLXQ5qvblkH8myVk0jHI/qKWZrPOLfLkZDRldTuVRdCLwM+jNhwl3v3dGZ6tmb3S8
	RFrqFA1OvIxqpGw==
X-Google-Smtp-Source: AGHT+IFmPCqlihMWKdDkiyJ++2BuxUeItuf+lNHIMXIbe3KnZMw/oT+QINYArAWW3FgNCSgPMWJPdqoLvWHrjw==
X-Received: from qvbow5.prod.google.com ([2002:a05:6214:3f85:b0:880:924b:a55a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c66:b0:880:51f0:5b9e with SMTP id 6a1803df08f44-8823871d34cmr98891486d6.31.1762767925754;
 Mon, 10 Nov 2025 01:45:25 -0800 (PST)
Date: Mon, 10 Nov 2025 09:44:58 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-4-edumazet@google.com>
Subject: [PATCH net-next 03/10] net_sched: initialize qdisc_skb_cb(skb)->pkt_segs
 in qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

qdisc_pkt_len_init() is currently initalizing qdisc_skb_cb(skb)->pkt_len

Add qdisc_skb_cb(skb)->pkt_segs initialization and rename this function
to qdisc_pkt_len_segs_init().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index dba9eef8bd83dda89b5edd870b47373722264f48..895c3e37e686f0f625bd5eec7079a43cbd33a7eb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4069,17 +4069,23 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 }
 EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
-static void qdisc_pkt_len_init(struct sk_buff *skb)
+static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u16 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	if (!shinfo->gso_size) {
+		qdisc_skb_cb(skb)->pkt_segs = 1;
+		return;
+	}
+
+	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;
 
 	/* To get more precise estimation of bytes sent on wire,
 	 * we add to pkt_len the headers size of all segments
 	 */
-	if (shinfo->gso_size && skb_transport_header_was_set(skb)) {
-		u16 gso_segs = shinfo->gso_segs;
+	if (skb_transport_header_was_set(skb)) {
 		unsigned int hdr_len;
 
 		/* mac layer + network layer */
@@ -4113,6 +4119,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 				return;
 			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
 			shinfo->gso_segs = gso_segs;
+			qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
@@ -4738,7 +4745,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	skb_update_prio(skb);
 
-	qdisc_pkt_len_init(skb);
+	qdisc_pkt_len_segs_init(skb);
 	tcx_set_ingress(skb, false);
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
-- 
2.51.2.1041.gc1ab5b90ca-goog


