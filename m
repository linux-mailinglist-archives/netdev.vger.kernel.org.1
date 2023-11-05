Return-Path: <netdev+bounces-46111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C47E16AB
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F02028130A
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D951865F;
	Sun,  5 Nov 2023 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eebXLP15"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374A179A4
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:57:31 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDFE1
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 12:57:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507975d34e8so5451448e87.1
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217848; x=1699822648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQE5Q7bSQ5CYGQU246bebUi4YlUrrbixJJSlZ4tZEQg=;
        b=eebXLP15HFRHF1NnfTmdlPXcVOVbnmtE9p8dzz+IYmqFzesu1EkR+fVaXcEV5iDmYe
         OgiebByePomyAo9ga9txe6TlOwSPNlgoXQgeqP5GACCp9bYrQXhPdRX720MlHUkbui68
         cTzw/oERVjohWz//20L7BPP9MDgBvSTM3gV3Ekz1BWhnv7F1cqq6nApigEZKm9SFbfX5
         35qt0oBJ5n74RnqT8hcRD33giUNU6gZL91oYfaxDcHRUNYftLzJwix+fh+/nb0U64qNJ
         KQl5Cvfpk/oBhmmquYMwuSX35Y1xqmTlh/7be3SCtg88PVBM0T49LTvZy63IfKlPZSz+
         Si6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217848; x=1699822648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQE5Q7bSQ5CYGQU246bebUi4YlUrrbixJJSlZ4tZEQg=;
        b=j6AxuzXIoziMSzxPq4GU2fj9LdGzvWbMFyXJH6e4RkQ9k7e3bGwEtZidFzPZvBLrwj
         xqh66BugK8iMHrFLo6lkxKWrHUaJWGfO7Ix5+82PzjNrugnVzi+oX2XDJ77ZZCejS0Ow
         Z9U2bsW128w3NLuYn17b99Iou5nz1tckDbFavx69gs4Btfb9BVA7i7jdaqo3b2LViXQH
         xaZkel3rSNEzT9cFm1qLivXxzGXU9/tfu2+xpZMQ98VZQoJq0U/EDpaGAFvY5g0eG4j+
         1afDeGllpybCGhDHeONen+sCxg+I1q+cvqeNaz5/I/YiwBbCWy1+BNV6AohSznX4Zciw
         Kbqg==
X-Gm-Message-State: AOJu0YzgpuCSpUi8O+pzcVB78Z0F/BngDHSRY6fE8YhamqCerIIGBKxD
	HeM2KnpEimW91fOO2C/Y/FUNpw==
X-Google-Smtp-Source: AGHT+IHOmoeKz7m5iyemJOxxs0vWx/4QhLzQOa5mtwwvMfSXkeaGjljiQd5YYPz0Pgyz9fiVyiPrlQ==
X-Received: by 2002:ac2:4d07:0:b0:502:ff3b:766f with SMTP id r7-20020ac24d07000000b00502ff3b766fmr18019859lfi.6.1699217847698;
        Sun, 05 Nov 2023 12:57:27 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 05 Nov 2023 21:57:23 +0100
Subject: [PATCH net v2 1/4] net: ethernet: cortina: Fix MTU max setting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-1-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The RX max frame size is over 10000 for the Gemini ethernet,
but the TX max frame size is actually just 2047 (0x7ff after
checking the datasheet). Reflect this in what we offer to Linux,
cap the MTU at the TX max frame minus ethernet headers.

Use the BIT() macro for related bit flags so these TX settings
are consistent.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 ++++---
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5423fe26b4ef..ed9701f8ad9a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2464,11 +2464,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
-	/* We can handle jumbo frames up to 10236 bytes so, let's accept
-	 * payloads of 10236 bytes minus VLAN and ethernet header
+	/* We can receive jumbo frames up to 10236 bytes but only
+	 * transmit 2047 bytes so, let's accept payloads of 2047
+	 * bytes minus VLAN and ethernet header
 	 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
+	netdev->max_mtu = MTU_SIZE_BIT_MASK - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll);
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 9fdf77d5eb37..201b4efe2937 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -502,7 +502,7 @@ union gmac_txdesc_3 {
 #define SOF_BIT			0x80000000
 #define EOF_BIT			0x40000000
 #define EOFIE_BIT		BIT(29)
-#define MTU_SIZE_BIT_MASK	0x1fff
+#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */
 
 /* GMAC Tx Descriptor */
 struct gmac_txdesc {

-- 
2.34.1


