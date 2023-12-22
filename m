Return-Path: <netdev+bounces-59954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820CD81CDA8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC37E1F23255
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83B2C190;
	Fri, 22 Dec 2023 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbkWnUlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77028E16
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e34a72660so2527907e87.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703266598; x=1703871398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcqx42xGNqv9hptaZ/9+//L/6y4mdXg4n74iEw309cI=;
        b=HbkWnUlIhEUceDCvh3vC7mZuZEEjLW8+IxsTDlYw494NSofm+RnyXH/Ud9C7qyMGCK
         Sc2OTtu03s2TDaBHnhJ5xVKnp4mN+JR7QJDqfaNTDafy8fkLRaSzV+YrjhcHWZEesLr3
         X+eqkXEqiY2wVnoITEOvGQaG7h5gFXgxLc/DG4uj8JH/DhdTPoXQbqXVUUV6Lw1EtzH4
         rtQs2gkxKvDU/tNmNvrNQQQiia3juWNoPB6IPxo1agq8qaqGv1irz30qHxN15bN5Ypvm
         YdwQqlcw9XsNRjk2xus4CjvE8l5im8vSL+pcqQj/rwE1NtOERNgN9z8S+piK/2fx4wVF
         SVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266598; x=1703871398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcqx42xGNqv9hptaZ/9+//L/6y4mdXg4n74iEw309cI=;
        b=pyl6456BGpsFjsVG9HajZCPAr9TWaIWB9edCMwFUUQ3S1reEUI8KjD8epkQAY2CYft
         HsNJxF2UJiB0TyAXjYwa0t0xunIl5Zo4DrsIdgbF0OOSZUpxfP+XMO7wZKwQ+L47Gcxy
         jQGnRojUmgky4PBK0XywghoO2+O7GSU8BXLOHO2XjvkRzWLoKw2s0cfQ7ESGMCrZHKlO
         6+Vn3plhYKnOSVJofKWByIm0RJB+OZH2DP6PGRVyhiwry/I2pgpx7MiUdRCsNtpwqETV
         Nz2D+2IF0BbeUYoWf7buSUV3/02D2LrSWbJ9JbGwtychcR7bW+nOu3FX6CXuWa6MbqnU
         aHxA==
X-Gm-Message-State: AOJu0Yz0EBO0OfV7f/Qg1pv+k3dSXyy5Y0HKrZLMYAcb1HU2+/yKNCc7
	ALjGPoUBQHVAklXzvsnXOr2mEZC4mokJHA==
X-Google-Smtp-Source: AGHT+IHOJ0oz9prBCkxKJ2d4uIw4EmXeFnXmXsYkLRDFUqs6SwdYHsY8VEAaa1np20RqNUtrfxTq/Q==
X-Received: by 2002:a19:700e:0:b0:50d:179b:b38d with SMTP id h14-20020a19700e000000b0050d179bb38dmr792887lfc.45.1703266598625;
        Fri, 22 Dec 2023 09:36:38 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b0050e709c8deasm43036lfu.226.2023.12.22.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:36:38 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:36:36 +0100
Subject: [PATCH net v4 2/3] if_ether: Add an accessor to read the raw
 ethertype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-new-gemini-ethernet-regression-v4-2-a36e71b0f32b@linaro.org>
References: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
In-Reply-To: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
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
index 8a9792a6427a..264457f291eb 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -37,6 +37,22 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
 	return (struct ethhdr *)skb_inner_mac_header(skb);
 }
 
+/* This determines the ethertype incoded into the skb data without
+ * relying on skb->protocol which is not always identical.
+ */
+static inline __be16 skb_eth_raw_ethertype(struct sk_buff *skb)
+{
+	struct ethhdr *hdr;
+
+	/* If we can't extract a header, return invalid type */
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		return 0x0000U;
+
+	hdr = skb_eth_hdr(skb);
+
+	return hdr->h_proto;
+}
+
 int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
 
 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);

-- 
2.34.1


