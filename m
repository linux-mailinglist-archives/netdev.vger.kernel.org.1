Return-Path: <netdev+bounces-59382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC181AB85
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68F61F24444
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52444B153;
	Thu, 21 Dec 2023 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6YR8+uH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AF446A2
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso323540e87.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703116964; x=1703721764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJLMGs1lZHtbdX/Mvsz/3hJzF7Azi3GTCJ3LJqHm/1E=;
        b=d6YR8+uH8jZga/zOP4TqUCaqmkn8le5qm03iE8EiYWFDo4ML1cJgFKw3pS+vgI2YIF
         zhx4/9mC2zyHU7Uu30o+DOPYDWA7f0Gega+kxM+9GUp+3sitPvr9FJi3Se7IHCmDFB2G
         CspJG9MBHgqYjW07sze0cty0XWGLvgw6tfDl5G+4O9LJ9mWsbWtCQL5IsMrUYvNRoA2N
         gqRFwe89MuW1tWjwbflh/14H6ctBltRH2GGA56rcVAVIm23Ub8K4m58SKpJ697yYyjfF
         YcYDKR3ffZl4bozIySbV5BLcfDvK8zxRXFTHcbpo0/l1j0jWjawqd6/jJZyWbUk8otMO
         7v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116964; x=1703721764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJLMGs1lZHtbdX/Mvsz/3hJzF7Azi3GTCJ3LJqHm/1E=;
        b=HkNF34I0h+85m6n+8qmrJAk3U0R9YI3ik8UEjm+2a0VTpgE50Msa5djpYg2gV84uRC
         2FUEsmMNcO7UUr2gyk/lRLE+1ZtTZoUiX02c4riWHbjnOmYPC/EkMQuDi1hSHgN1LVQB
         UBohgFxPrctTZSV/oqH1Mt5yTS4FpG5AdgdUsyhxbVGrOWpzOp5Ll9jeoLrWpCgaEPfs
         VnW/m787ALzjawoxIxXK5CzTJbGX/CjSPwi079ZHrN2j0id3c4hdinaROFl7g3Q97FdF
         QiatvuETN82f978SWLWtr7Ye4ve2nwFgUEAqKcV6B+K6MxbcewSMCaw45EQa9u9lVmcr
         jpog==
X-Gm-Message-State: AOJu0Yyevo495k73/B+d+9iLXnkZkenjXjeb9LGgFnnEI1xTRvdzbc3r
	D8JZ97XkT4eT2BbcdIbt1dnhZw==
X-Google-Smtp-Source: AGHT+IE1WX0Y0fiv3yUhbmICABCtXC8/5OkNumN66LfZib/JXWiHTn/R1K783d8eGgvHPWesuzXGiQ==
X-Received: by 2002:a05:6512:1584:b0:50e:10e8:d544 with SMTP id bp4-20020a056512158400b0050e10e8d544mr9221601lfb.68.1703116963568;
        Wed, 20 Dec 2023 16:02:43 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b0050e4ac5bf5asm100321lfe.284.2023.12.20.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:02:43 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 01:02:22 +0100
Subject: [PATCH net v3 3/3] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-new-gemini-ethernet-regression-v3-3-a96b4374bfe8@linaro.org>
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
In-Reply-To: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

We had workarounds were the ethernet checksumming engine would be bypassed
for larger frames, this fixed devices using DSA, but regressed devices
where the ethernet was connected directly to a PHY.

The devices with a PHY connected directly can't handle large frames
either way, with or without bypass. Looking at the size of the frame
is probably just wrong.

Rework the workaround such that we just bypass the checksumming engine if
the ethertype inside the actual frame is something else than 0x0800
(IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engine
can actually handle. VLAN framing (0x8100) also works fine.

We can't inspect skb->protocol because DSA frames will sometimes have a
custom ethertype despite skb->protocol is e.g. 0x0800.

After this both devices with direct ethernet attached such as D-Link
DNS-313 and devices with a DSA switch with a custom ethertype such as
D-Link DIR-685 work fine.

Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index ecc247acac39..6d153eba8e81 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -29,6 +29,7 @@
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/etherdevice.h>
+#include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/skbuff.h>
 #include <linux/phy.h>
@@ -1143,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	unsigned short mtu;
+	u16 ethertype;
 	void *buffer;
 
 	mtu  = ETH_HLEN;
@@ -1158,7 +1160,24 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	/* Dig out the the ethertype actually in the buffer and not what the
+	 * protocol claims to be. This is the raw data that the checksumming
+	 * offload engine will have to deal with.
+	 */
+	ethertype = skb_eth_raw_ethertype(skb);
+	/* This is the only VLAN type supported by this hardware so check for
+	 * that: the checksumming engine can handle IP and IPv6 inside 802.1Q.
+	 */
+	if (ethertype == ETH_P_8021Q)
+		ethertype = vlan_get_protocol(skb);
+
+	if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
+		/* Hardware offloaded checksumming isn't working on non-IP frames.
+		 * This happens for example on some DSA switches using a custom
+		 * ethertype. Just bypass the engine for those.
+		 */
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP

-- 
2.34.1


