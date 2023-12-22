Return-Path: <netdev+bounces-59953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D581CDA7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B84B23E07
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5EA2C183;
	Fri, 22 Dec 2023 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXcYShDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFF28DDF
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e44c1b35fso2516984e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703266597; x=1703871397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M9nYN3vG6J30yAr/55QkQJHhhME7G4QwBy/DGljMWQ=;
        b=LXcYShDfCEtiCvDbtZeKYQw7ta0lmI3rZV920r0TxC3ZJNrKczW9wuejRJBXz/6MuH
         I3z4CzGckxwr9YcpbYAhIUsAlVh8Xw3tHE5tvqyKB8QHbnWbZM9xFwyv5nm8lOX6Y2Tv
         w224kIJcq/nDZ1+R5TUsELiIDlAcQerbIkkWXPmF4R5eVmxAD1mie+m9NeFDmM1QqpQR
         aW/TLlhINBlgG/MdxaFpzSnUh0TKB9V8pZvs5+dGbYHWQFQON8yQ0G1wcLtHJsuPYhZE
         OCMEuhwoM3zznX3jfMtxMrs86d1EW+/MOBfX49XiDTIbBE9ACNI2NTJRQ/poS0HQJ5Fi
         qLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266597; x=1703871397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M9nYN3vG6J30yAr/55QkQJHhhME7G4QwBy/DGljMWQ=;
        b=c4tx0svD5RvoxfeHF2hXaIfFSZxzWDc42nfHMR16S+voqoaZrvdKthgrkfNN0SumeZ
         4jsJhJfSloRSG+bao1ExhzLpCrQyudoyYK3HcK91YJUvEDHlcAVLXuxAdDezDVtwagl6
         ydaMaVrbLyhvWkZrwL0G8XxFQkmfLXSRjzOQkvZDvTK+3npCSB+iE0rfCWUogrKgZIh5
         +00gvnuAE8vDhJKPjxhXeLF8ATPTujbKjKgU7de6igj5oV3vxY2SPtn4t65fWRAY65MZ
         J9aVObo2IrW3dTSS6NBR4C7DmvufnPDT8f3sR+jq2hIgDuQ7Aq6hU/tahzIuclw+8PMm
         o20Q==
X-Gm-Message-State: AOJu0YzXJ3HbmE99f98SyqyjYJpmKNGBphSxVrYjwVPkRdLT5HUCf/Qw
	WMoXZtzOUqQZnqMOCJYnspPO7kZSXQ0HjQ==
X-Google-Smtp-Source: AGHT+IGgMI6M/QgASNrvCSKO+u0Iq0nP4gu1FT8Vj+b5HFoD2eaUHdyJON09YHe9tjDkmSjnE1kaow==
X-Received: by 2002:ac2:5325:0:b0:50e:4316:4a1e with SMTP id f5-20020ac25325000000b0050e43164a1emr854795lfh.15.1703266597648;
        Fri, 22 Dec 2023 09:36:37 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b0050e709c8deasm43036lfu.226.2023.12.22.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:36:37 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:36:35 +0100
Subject: [PATCH net v4 1/3] net: ethernet: cortina: Drop software checksum
 and TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-new-gemini-ethernet-regression-v4-1-a36e71b0f32b@linaro.org>
References: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
In-Reply-To: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The recent change to allow large frames without hardware checksumming
slotted in software checksumming in the driver if hardware could not
do it.

This will however upset TSO (TCP Segment Offloading). Typical
error dumps includes this:

skb len=2961 headroom=222 headlen=66 tailroom=0
(...)
WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c/0x108
gemini-ethernet-port: caps=(0x0000010000154813, 0x00002007ffdd7889)

And the packets do not go through.

After investigating I drilled it down to the introduction of the
software checksumming in the driver.

Since the segmenting of packets will be done by the hardware this
makes a bit of sense since in that case the hardware also needs to
be keeping track of the checksumming.

That begs the question why large TCP or UDP packets also have to
bypass the checksumming (like e.g. ICMP does). If the hardware is
splitting it into smaller packets per-MTU setting, and checksumming
them, why is this happening then? I don't know. I know it is needed,
from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
and hang unless the bypass bit is set: the frames are not getting
through.

Drop the size check and the offloading features for now: this
needs to be fixed up properly.

Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..5e399c6e095b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1143,39 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
-	unsigned short mtu;
 	void *buffer;
-	int ret;
-
-	mtu  = ETH_HLEN;
-	mtu += netdev->mtu;
-	if (skb->protocol == htons(ETH_P_8021Q))
-		mtu += VLAN_HLEN;
 
+	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
-	word3 = SOF_BIT;
-
-	if (word1 > mtu) {
-		word1 |= TSS_MTU_ENABLE_BIT;
-		word3 |= mtu;
-	}
+	word3 = SOF_BIT | skb->len;
 
-	if (skb->len >= ETH_FRAME_LEN) {
-		/* Hardware offloaded checksumming isn't working on frames
-		 * bigger than 1514 bytes. A hypothesis about this is that the
-		 * checksum buffer is only 1518 bytes, so when the frames get
-		 * bigger they get truncated, or the last few bytes get
-		 * overwritten by the FCS.
-		 *
-		 * Just use software checksumming and bypass on bigger frames.
-		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			ret = skb_checksum_help(skb);
-			if (ret)
-				return ret;
-		}
-		word1 |= TSS_BYPASS_BIT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP

-- 
2.34.1


