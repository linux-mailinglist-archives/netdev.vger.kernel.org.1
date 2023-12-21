Return-Path: <netdev+bounces-59381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6527B81AB84
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED73028517F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713545951;
	Thu, 21 Dec 2023 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc4gz5R8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C6433CA
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so1909071fa.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703116962; x=1703721762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzhpH0J3TXUoWqEafbYmXb/5rBmLt887S+CmrUg/4PI=;
        b=kc4gz5R8ycupIs46wM5vNeERIMn/0bG6v8QRYPEeIJRMv8Nm4q7pw/TkyZIIgayqQB
         X7QH0W8+bsSpWh4Hs2paRwyj3uUMKSp9MROVir6lq1jnippMHpSBkInNwPWG40DJiH+J
         3XgmDDOjXFbBBJteZLpxEu4LDx686q2nq8fTy34kpypAZvPOLs6wnb0oauqM+alctmok
         eC4m9999A11sEmFIjvfdGQ85dW862ub7/6JP3pFfCPGbQS5xdFbSMIl3lyLszs8pfrN+
         AlymiR4mj7wtN6UP1pIYxNiyws8O4JZJJy1Lk89scHKfLGoje3E4KHx9fTIvjulFUp/Y
         jebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116962; x=1703721762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzhpH0J3TXUoWqEafbYmXb/5rBmLt887S+CmrUg/4PI=;
        b=vRv1jlMt9P2yFnmuK7keuyQwWnUuAZOZ8hiezYOdfbhmxpFPC9a6WaMFND8vsdljUv
         d505i6Gzhl/WOrhdiQThCpMHNkInaEunSKwgW28k8axIMdkYyKIGh1QcjHm2HGTxe45J
         JeY174qnc19t9VdD9BGjAzwX/6ffbvBxhN5aYvi18hGQZ5TxJhdCbyTZb3lDz+cVjcd5
         HyAfmC/R7JUrYlK4FUvrqXxe0ORvCQlS8wMuUCdsHpwcDJbo4xkkMzU8tBt0YieYZjoj
         +wy8u5BoRu9HWluUrAl4bsghDWgyA33cZpMG27h0nqMWJh1K+jJFAMJ20TKZZ+7Oqy7e
         rEBA==
X-Gm-Message-State: AOJu0YzH/jA5esDhvCkGizrojTnUYRboxhMAyUBYuKCaYQv+bc7pjVdj
	SiA6mE9olQVASOQzeoSyp+aaQA==
X-Google-Smtp-Source: AGHT+IEmxS6nsTZFx5eJB/F2NUTJW8o1tb0jbv1dJWfa683uFn2oM/6zz8xJ9omZuzbMlkFSQUhonw==
X-Received: by 2002:a05:6512:10c4:b0:50e:5889:e5ac with SMTP id k4-20020a05651210c400b0050e5889e5acmr532307lfg.71.1703116962762;
        Wed, 20 Dec 2023 16:02:42 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b0050e4ac5bf5asm100321lfe.284.2023.12.20.16.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:02:42 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 01:02:21 +0100
Subject: [PATCH net v3 2/3] if_ether: Add an accessor to read the raw
 ethertype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-new-gemini-ethernet-regression-v3-2-a96b4374bfe8@linaro.org>
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
In-Reply-To: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.12.4

There are circumstances where the skb->protocol can not be
trusted, such as when using DSA switches that add a custom
ethertype to the ethernet packet, which is later on supposed
to be stripped by the switch hardware connected to the
conduit ethernet interface.

Since ethernet drivers transmitting such frames with alien
ethertypes can have hardware that will get confused by
custom ethertypes they need a way to retrieve and act
on any such type.

The new eth_skb_raw_ethertype() helper will extract the
ethertype directly from the skb->data using the ethernet
and (if necessary) VLAN helper functions, and return the
ethertype actually found inside the raw buffer.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/if_ether.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427a..6bf265979757 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -37,6 +37,22 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
 	return (struct ethhdr *)skb_inner_mac_header(skb);
 }
 
+/* This determines the ethertype incoded into the skb data without
+ * relying on skb->protocol which is not always identical.
+ */
+static inline u16 skb_eth_raw_ethertype(struct sk_buff *skb)
+{
+	struct ethhdr *hdr;
+
+	/* If we can't extract a header, return invalid type */
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		return 0x0000U;
+
+	hdr = skb_eth_hdr(skb);
+
+	return ntohs(hdr->h_proto);
+}
+
 int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
 
 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);

-- 
2.34.1


