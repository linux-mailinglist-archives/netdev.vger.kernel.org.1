Return-Path: <netdev+bounces-61013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E833B8222A2
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 21:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C47C1F23690
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E816423;
	Tue,  2 Jan 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNJpyEYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F01168AC
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e77a2805fso6818042e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704227675; x=1704832475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci97zJBKMv+90pMXEKok7iRatK5RIKi/NRVSmudTOIQ=;
        b=aNJpyEYENFcKBtrmLnZoZrjO7NFTMORr8iM0NfG/WNj9pCDjgFL3RKxLS9Z+FbdXUV
         URXXrME+qNRowhsREHdacOeyz3oh8le/MerrVd2JjDiGmC10wCv8Io4nqrMPDeqs9YVx
         VC9G/Btrvui4J8klWTfFQhw4yP3ZkYNXkc1U1RD+0VCohUpmVIJTf+clTSGDeObNAIqG
         ajwm+5OUutqd6/H0wbqqWYng2bIA1I9ITtbF0cgAcCydCgOSHtWn+pYRLELdzxJ8Gmxd
         Jj6CbNC8xKzsVPUgylnHLF5w7rylvpkI8Gy8tCVkWyxpTTM2/75LUSN2wbQM8qbe1wTi
         2nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227675; x=1704832475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci97zJBKMv+90pMXEKok7iRatK5RIKi/NRVSmudTOIQ=;
        b=T69XADlP/mk/P5JO6enCek5k6UwGx+jKAHGkChV0BwbwqQuJPBgYM2hNqCKSNUDvdC
         KrM5AfBuy1t1niDeK0o9XzsUTdfxihz5q5DxMliU33Iu/4xPbymwEPWJyWhxKplpcskP
         sYQJA0XWM2czK/kPI7y5kqeK5xq87lTlRXkI9dGPjEIqphLVw3HU3VH9WbhdXbAhgO01
         RRTd12c9oqVre79eYNBQgkDpiODpoJ41cPoIBwURcwejMkgX+O7YoS1n5KiI8fiWR8Wp
         RgL7t1Np930uGaU3ZU6I3P9C7cgTki+YM1ZYItNDRctIk24JVn6koBpCKYtsN+UeGh2q
         s+JA==
X-Gm-Message-State: AOJu0YwMIup2QBHe/umz/w+xKGQqPv0jKQm2rLr8V8vCQqr0WR3HYlHa
	R4s8Tk9rGQSN/A9+gJ+RiTyHgOHARTc8Lg==
X-Google-Smtp-Source: AGHT+IH9dlfjIS5vApOqD3R3SBUmxsi5JvZhfrmohGt1S2dfe6GPXIccdxg6aiBoTPv+tJh5r8VjAg==
X-Received: by 2002:a05:6512:4001:b0:50e:633e:4cc9 with SMTP id br1-20020a056512400100b0050e633e4cc9mr6878442lfb.204.1704227674912;
        Tue, 02 Jan 2024 12:34:34 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25213000000b0050e7b52c735sm2668392lfl.145.2024.01.02.12.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:34:34 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 02 Jan 2024 21:34:26 +0100
Subject: [PATCH net v5 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-new-gemini-ethernet-regression-v5-2-cf61ab3aa8cd@linaro.org>
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

We had workarounds were the ethernet checksumming engine would be bypassed
for larger frames, this fixed devices using DSA, but regressed devices
where the ethernet was connected directly to a PHY.

The devices with a PHY connected directly can't handle large frames
either way, with or without bypass. Looking at the size of the frame
is probably just wrong.

Rework the workaround such that we don't activate the checksumming engine if
the ethertype inside the actual frame is something else than 0x0800
(IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engine
can actually handle. VLAN framing (0x8100) also works fine.

We can't inspect skb->protocol because DSA frames will sometimes have a
custom ethertype despite skb->protocol is e.g. 0x0800.

If the frame is ALSO over the size of an ordinary ethernet frame,
we will actively bypass the checksumming engine. (Always doing this
makes the hardware unstable.)

After this both devices with direct ethernet attached such as D-Link
DNS-313 and devices with a DSA switch with a custom ethertype such as
D-Link DIR-685 work fine.

Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5e399c6e095b..68da4ae26248 100644
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
@@ -1142,22 +1143,38 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
+	u16 ethertype;
 	void *buffer;
 
 	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
 	word3 = SOF_BIT | skb->len;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	/* Dig out the the ethertype actually in the buffer and not what the
+	 * protocol claims to be. This is the raw data that the checksumming
+	 * offload engine will have to deal with.
+	 */
+	ethertype = ntohs(eth_header_parse_protocol(skb));
+	/* This is the only VLAN type supported by this hardware so check for
+	 * that: the checksumming engine can handle IP and IPv6 inside 802.1Q.
+	 */
+	if (ethertype == ETH_P_8021Q)
+		ethertype = ntohs(__vlan_get_protocol(skb, htons(ethertype), NULL));
+
+	if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
+		/* Hardware offloaded checksumming isn't working on non-IP frames.
+		 * This happens for example on some DSA switches using a custom
+		 * ethertype. When a frame gets bigger than a standard ethernet
+		 * frame, it also needs to actively bypass the checksumming engine.
+		 * There is no clear explanation to why it is like this, the
+		 * reference manual has left the TSS completely undocumented.
+		 */
+		if (skb->len > ETH_FRAME_LEN)
+			word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
-		/* We do not switch off the checksumming on non TCP/UDP
-		 * frames: as is shown from tests, the checksumming engine
-		 * is smart enough to see that a frame is not actually TCP
-		 * or UDP and then just pass it through without any changes
-		 * to the frame.
-		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (ethertype == ETH_P_IP) {
 			word1 |= TSS_IP_CHKSUM_BIT;
 			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
 		} else { /* IPv6 */

-- 
2.34.1


