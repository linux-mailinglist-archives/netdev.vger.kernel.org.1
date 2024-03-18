Return-Path: <netdev+bounces-80491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A787F3DA
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 00:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7370B1F22027
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFB5D742;
	Mon, 18 Mar 2024 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2L6EO3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E315D727
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803620; cv=none; b=hOFO8E21Wb4bWpiAOaVFguetOZl2M2I2Zs8dBiMszOrebBIX2XuwadU81pPqXljq8D0Kn/FJe8PrVkHtLnu6fRl92FLfkxWdWdQxCgMcqJoKBrW/memHguwe+J1ugtkfR0+4fIcJ2F05Z+/2P09Zk4EEW+0Q2gMEn3cDXZvYcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803620; c=relaxed/simple;
	bh=FXc+M9klWY/q41q/XRbx56uqjqf8s6lw3gQrf3s5Zb8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ki8AeIs69fERZVoW3E8T0svi5yH3AM11U0vI9IArr1QMUPzMLAjvVA2jOC786AbGZ+hXWkRwDItyco4ChDTMVI8Wlhl/33S8WyGVjyd6PtnxbHxo24gIpkHA03ig9WxN+3Z16drhC5EjJkrwOnSuTdsLTh9OFpigY/t9gUag+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2L6EO3p; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0815e3f9so72835027b3.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710803618; x=1711408418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPyhBA1D7i8/h337R7x4G8QOXyXKXYyy/cHk2PX484A=;
        b=w2L6EO3pBh44E1PCIxCUsZAiASccAW0opjRg83N1nwRIQYLBnux8ciPj9pMI4WyYQh
         Kj4znRvqbFrLM7CFdmcLYtu3Fh2LitthvnTC7lHGbYB0txf432eePArN8ZLU+Y9kpmyJ
         u53hONEQin8XkCywEC8ciJum1+Dpkj7nsDWQ2hIH4+ffvqeAWQSpjv0iMRdjAZGaH4EK
         dFTuZ7ivHdmUtzhvDRKANi4KLweterDSJZFLKh7+CprRsrQSpYPkKtVrurkEmHZX76KL
         Ox2knA4Mii91iiaf+LyHJz1ezWni7Jp79Up77H3CPbIq/qrd49zEZE+p9VQUTOVgXCG7
         Lfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803618; x=1711408418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPyhBA1D7i8/h337R7x4G8QOXyXKXYyy/cHk2PX484A=;
        b=I6lEFt9mt8YU7X8UgfADug9VBeHj0tkx33urSR8P8tfwEeGssaqoJn6BCNaF2TNR+E
         /SqOWIgf6N5T7HgtBZk6itlp/96n9GRHhVjIy6P0KS1WvV4xlNlZEaeN93afTFlGCLkG
         dIjs0RDUrgfB0cd2R/We8vfstZ1hukSxtD7pQUUsSpwLBye17qnLdBlbxsF3PtG3U8OI
         AmM0vZpjj3ioSX3PjlNP7PczKtPT0lt4RZRu0E66qpVv3jsMegpje2QREd3rkX/Z24RQ
         tPxW/uYUkkuSZ7IUugfLgojSQRq9czjAyVfmawN0Po+VEvvBbubSU5YRZQ87s2uanuVC
         T+yQ==
X-Gm-Message-State: AOJu0YzWckEFut4SvhuEEYk5+T54uCN94FYrLlePKf8wi+zV3hsXUzJN
	P+tio8C08O7lif1bR+It9VCsP9OBnFtmxHT6KIeUXwYMRScZ8d5AmPU/WouYyWkNqwX3zzATQXZ
	GiKOeIDGtMdZKC+dQ7Ke9lSNDJSOvsiuThIMbfoyDL0V0w2dYR+p5tLKvGgNulo2XUd32uYp0Nz
	H/y6NwL8TjbVQTOG8NXG39H0OfUjnuF7gR
X-Google-Smtp-Source: AGHT+IEKMTRV2+l3OGfooRdcyx4P3eN+T5sEWHzBJRF7gQIRQRj4wk0Mg3ruWCJyEPXNsuO7tynIH8IacbI=
X-Received: from wangfe.mtv.corp.google.com ([2620:0:1000:5a11:a50c:9ab4:6067:8eb5])
 (user=wangfe job=sendgmr) by 2002:a05:6902:2484:b0:dd9:2d94:cd8a with SMTP id
 ds4-20020a056902248400b00dd92d94cd8amr171543ybb.9.1710803617932; Mon, 18 Mar
 2024 16:13:37 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:13:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318231328.2086239-1-wangfe@google.com>
Subject: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

From: wangfe <wangfe@google.com>

When there are multiple ipsec sessions, packet offload driver
can use the index to distinguish the packets from the different
sessions even though xfrm_selector are same. Thus each packet is
handled corresponding to its session parameter.

Signed-off-by: wangfe <wangfe@google.com>
---
 net/xfrm/xfrm_interface_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 21d50d75c260..996571af53e5 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -506,7 +506,9 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
 	skb->dev = tdev;
-
+#ifdef CONFIG_XFRM_OFFLOAD
+	skb->skb_iif = if_id;
+#endif
 	err = dst_output(xi->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
-- 
2.44.0.291.gc1ea87d7ee-goog


