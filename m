Return-Path: <netdev+bounces-33571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73579EA0A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222AD1C20B05
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7F1A73C;
	Wed, 13 Sep 2023 13:48:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B803FFE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:48:44 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A019BF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:48:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d745094c496so6277387276.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694612923; x=1695217723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aIslcLurqrs1IQ6KFTaySLi7kCtg/l3vJLaGmkbdojY=;
        b=WWVQZGgrVrw/dDyWZyW1RIFsNeKEJNb+BpTviIAnYSN76HPfrjLJXPfavRehcdTIL7
         Qepiw5AokIpNOcXP0gUL6IMkVNzvKw4/4INIspExceOtU5XNv7vbOOSzLUvJ79q5k3Df
         bdi176SrrcUnKeofJB+Ld+76IOwMmrnPngOE/g5GY8JTyXLn4RC43b9HyrnkTFzwu/ax
         knEt3jRt/VY9qQ180cTO7OncWRBNFTu9Zo4Ibw7oAn9JwzJZXEyVW9FcufZXwRxrC3hh
         0iafpclts24J3YO/KoafmtPaAlJpOzoaKNPrXtaYnJm5+ajI8KRBQD6Gc5iIGTBrWHKO
         Im9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694612923; x=1695217723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIslcLurqrs1IQ6KFTaySLi7kCtg/l3vJLaGmkbdojY=;
        b=YAmIrjhScMosAczupfR1EJmirRRXanr72KV0csdTtO7wUcvA00KzNmD0Jz4f8pv/Rr
         6yMjiL94TbRpmsI5bg0cdSmccbybzRFQrPlIy66PuS0rssWphsDoY/QwY0H5JaRToFDK
         1hMTknB0LxLY9gBVsPsMKjnvCjCh+ImoGgic/esfYigtBWgIGeR2ITXnztLKt303fi7U
         SfqrcK4tczfOxZe8kA9DU9OZJoXfXOJucpcB0JpDe94Dfpz/HkpKsCcdUei4AMyo9B+o
         or0JdXN/2JlEhpvUue3Vm0O3w+gqEOfb7XIqawkPzBAOPXA/x2VJfoSu+J1t75ncotv0
         k/EA==
X-Gm-Message-State: AOJu0YwK4ZeV2yDMM3Q0dsvXeIE52l26LVPcRL98AeVWfbyx/GcdcN+Z
	IJoheE4WPiJ5rdQ3brezUc2YgeX330dp1A==
X-Google-Smtp-Source: AGHT+IGmNxQSAo/ogUGZU5G436JEhbLr2/lCCtxV3TG6eVXSl6DmTR4VNGcPCTE2Gwum/fbBB4ug9uz7qiGnIQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1102:b0:d0b:d8cd:e661 with SMTP
 id o2-20020a056902110200b00d0bd8cde661mr71986ybu.12.1694612923062; Wed, 13
 Sep 2023 06:48:43 -0700 (PDT)
Date: Wed, 13 Sep 2023 13:48:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913134841.3672509-1-edumazet@google.com>
Subject: [PATCH net-next] net: add truesize debug checks in skb_{add|coalesce}_rx_frag()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

It can be time consuming to track driver bugs, that might be detected
too late from this confusing warning in skb_try_coalesce()

	WARN_ON_ONCE(delta < len);

Add sanity check in skb_add_rx_frag() and skb_coalesce_rx_frag()
to better track bug origin for CONFIG_DEBUG_NET=y builds.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4eaf7ed0d1f44e8305109da2da2835013786a857..2198979470ecfaf5667aca7bdecfbf2aa569f852 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -847,6 +847,8 @@ EXPORT_SYMBOL(__napi_alloc_skb);
 void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
 		     int size, unsigned int truesize)
 {
+	DEBUG_NET_WARN_ON_ONCE(size > truesize);
+
 	skb_fill_page_desc(skb, i, page, off, size);
 	skb->len += size;
 	skb->data_len += size;
@@ -859,6 +861,8 @@ void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
 {
 	skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
+	DEBUG_NET_WARN_ON_ONCE(size > truesize);
+
 	skb_frag_size_add(frag, size);
 	skb->len += size;
 	skb->data_len += size;
-- 
2.42.0.283.g2d96d420d3-goog


