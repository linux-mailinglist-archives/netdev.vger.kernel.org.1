Return-Path: <netdev+bounces-94816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1368C0C1E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0611F22DF9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173F149DE0;
	Thu,  9 May 2024 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBkEUswb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5F149C55
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240928; cv=none; b=pNFIjADobbHWdD1ZbZsqTMpXj9Xrz3UdSEWNW5MsMMNGLu3aPhFmK8hE5hjdUF2AsizndBpP7YQPzZHJdOs6ex2lmM9r/t/V9JBEIsDFmt9UKtOO4sX1VidKSsNWAitGY3oCECRiuGusQkbzdC9KD/mJcR01yWme4HWv1g/1FcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240928; c=relaxed/simple;
	bh=eKflslt6nLXYdoLlZTqRNOAyKpcKOW3KVGxeAKcDXoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtHK8dvVQKogUJxLZR6VMW/+j/mJ8gxxxlP16tFHisfMtVsY7n/wS06lZ5gVqE7a8uUDGVlf8isrfzUvRpOM5GGkl+6Iu3SceLM1tP8M0AfmDdDgFX26FI91BZEzuoxbnYOoUy8XT0IyqXJFqSaSJ++drW10hqZyo7Wm1Rjyx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBkEUswb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b097b202so125528966b.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715240924; x=1715845724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vBzlEdh++Xq9GUTz6TB/P3FoiauMYeqkoCZXeTS91Y=;
        b=MBkEUswbUpCMnSL0UYzbww4MEQHcBO54/Ww+EoJAmbk7wDPZ8yboca6BAoJMUmM7Og
         iixWg1UuCt2yREST4hJgqctQueWai60UqPn3QsFymOrCtI7insQF6Srl9aN0xZuv+QV9
         LmesDXcb9GgrYIJlqL6q6aIBvvC9pJvUrnS6OCXhAOwOQ8Y4fCfb/8Tp0Yy7yZmK/hoW
         eU+PsvggFyq0IkW2Ljg9DpEUJjGtP+67i8Acg7OSL79iaO69Vj4oC+MiTMyx5bdbsrHR
         /lElhf/7Mr87FcCnPWKzOOJ5ZFIi1eEO8pTJwVbIbAhddSK2i35fYGkoZdsy5KsfzY2F
         Nteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240924; x=1715845724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vBzlEdh++Xq9GUTz6TB/P3FoiauMYeqkoCZXeTS91Y=;
        b=xKPEzXoaBiYLwG4S+nEtKbDLIdd4KvLmYNlrVV/O3efSD2XPDoEqDoJLSMIouxFI8t
         PKdnglH0KYfSYHslsBu8OlfMVsLRoQmmapx8K3KdnAi8cQJGdbX7vnzlNURlZk4hVngp
         0p/OpyDN9M1UQatMiODaZB48E2XXdq70eHch/IXgxGsVlyqRDZZ8UPH8PDns7rphF2CV
         PXe6BhMGVb8lakgo4GDLNLHMiSnPZ+F1z6jCS9zISyb0WLK280b26NnF0uSYUIXH9zt6
         bjCi4RVr42Y7giIvUonTaKXI8nct95St0oInYWJCK1ggJ74txHdVAp19AeqYi+JyFwhZ
         n4Dw==
X-Gm-Message-State: AOJu0YwXoXi/ohzNm3vQatRptKWTfVyg+69/fTtwr1C0ZkWWVQ52uSU1
	eh+dNQVQvv1oU07Gb+7Z3OsJT79ujRgPOCgpECtpNOMipQ2ieK63jnKsBba4I+k=
X-Google-Smtp-Source: AGHT+IFPzoruFCjOL5jl7DhwP12AjWlf4QaNFaQDXT2uqQEJODrkmjGjxZWtPPxYaRx5mCC9GSv5kQ==
X-Received: by 2002:a17:906:1688:b0:a59:c9ce:3389 with SMTP id a640c23a62f3a-a59fb9dbc4emr308112966b.67.1715240924408;
        Thu, 09 May 2024 00:48:44 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d65sm44783366b.126.2024.05.09.00.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:48:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 May 2024 09:48:38 +0200
Subject: [PATCH net-next 2/2] net: ethernet: cortina: Implement
 .set_pauseparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-gemini-ethernet-fix-tso-v1-2-10cd07b54d1c@linaro.org>
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
In-Reply-To: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The Cortina Gemini ethernet can very well set up TX or RX
pausing, so add this functionality to the driver in a
.set_pauseparam() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 599de7914122..c732e985055f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2138,6 +2138,28 @@ static void gmac_get_pauseparam(struct net_device *netdev,
 	pparam->autoneg = true;
 }
 
+static int gmac_set_pauseparam(struct net_device *netdev,
+				struct ethtool_pauseparam *pparam)
+{
+	struct gemini_ethernet_port *port = netdev_priv(netdev);
+	union gmac_config0 config0;
+
+	config0.bits32 = readl(port->gmac_base + GMAC_CONFIG0);
+
+	if (pparam->rx_pause)
+		config0.bits.rx_fc_en = 1;
+	if (pparam->tx_pause)
+		config0.bits.tx_fc_en = 1;
+	/* We only support autonegotiation */
+	if (!pparam->autoneg)
+		return -EINVAL;
+
+	writel(config0.bits32, port->gmac_base + GMAC_CONFIG0);
+
+	return 0;
+}
+
+
 static void gmac_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *rp,
 			       struct kernel_ethtool_ringparam *kernel_rp,
@@ -2258,6 +2280,7 @@ static const struct ethtool_ops gmac_351x_ethtool_ops = {
 	.set_link_ksettings = gmac_set_ksettings,
 	.nway_reset	= gmac_nway_reset,
 	.get_pauseparam	= gmac_get_pauseparam,
+	.set_pauseparam = gmac_set_pauseparam,
 	.get_ringparam	= gmac_get_ringparam,
 	.set_ringparam	= gmac_set_ringparam,
 	.get_coalesce	= gmac_get_coalesce,

-- 
2.45.0


