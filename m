Return-Path: <netdev+bounces-95598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FA8C2C72
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00633B2272F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48613D248;
	Fri, 10 May 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXbB+Zpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6D13CFAB
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378938; cv=none; b=dHhLKsamE5o9KCFEKBKM3AAtNSaNfChB2hf7t662khWTtoZHvRpnR/8Xegm5lVPvwHjA0XxTxhOaHqVbj01o5yQVVVogL17RUrED0li2AwEvHqbRbEZPOhPtULlKBd3gHxOuNHGu5A0P+0Cesr/6SBIso90OqJwoAilNSrp93y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378938; c=relaxed/simple;
	bh=TOcnDy0PN34+98xhqM6Q+UsUioQYwT3XmDQis0oaur4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr15/rVrheUFKJgvl8OWUq6+EU6LBqH1xWt+Z5KINMm1lxQveTE8i2dBfMhVxoWpJ4i6NUIMITIsLZgky3UdHBFG5oNhFFJHq/BOJ6OANyLKVGWuGL1ilkUwixgky6qAGy/7cO5z/Og5wE/oyaOzN1mi+I69TJdPFAAAXBh9YQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXbB+Zpy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a609dd3fso440476566b.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378935; x=1715983735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkfteHNXU4Gc7U7F5jS8dOpIBUIN8TpFTqroJmbcsZ8=;
        b=zXbB+Zpy9I2UhQ1TlUiibvwd4t3YWkm+OWyd3CsCTn/Z4WLPrLnRGdNwVNlF7GvMQF
         QdM+NseqHIfhTaAZSldi46l6IonZ/k8KCgbzutavXyT5SLdPVZ0IR5GQdudcHNbK41aO
         C/KmPW9t2X+Y/Ci5R87g2Xs7IszXqzDu77ZVOhSGNpgMCtv9y+oraFkKgualN+tb/jVH
         JMQQKOun/SiR5LcqYMI4CTo+a+ivsMlxKy3+i0/7WJ9vTDCrCHiQrN0PqkmEtFUrAi7r
         LHQUKprpRgHhk3/JzSeaFZCag8bhn5REvRBKiKrbd62n8KFw8O7I5Ui79C5zbRGi0KPT
         D7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378935; x=1715983735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkfteHNXU4Gc7U7F5jS8dOpIBUIN8TpFTqroJmbcsZ8=;
        b=MJGI+4Pot7AVbPbDCMDSzqfq06NamRtYBZ83OkF92I4Cz19tYIZGiyEUwvCqEkjCZg
         WgnUiCXK5xpKcr6e7oSxKwfc0IhTsB3hcbkFJ57dmY1TYgpxHneQ0PS1MPWmNjJ1KGOa
         O48SosvtG0shCUwo03xakA3bbV4bRlSj+SkVcqkA0i5Athu8WdNn5v1yopNRsGlIkfzS
         JmLdG41jaIA0WvlyiEaLpcLJxIKibMRaw0qY1P9zv/ZZA9nqCnVknSrrg/Atz/swpE3B
         79ih97Dr4pnprWTscpz5jm9kB93t6CQNk3D4dH6M+dLCQQay1dvay97wWAukL6o2RsCl
         C7VA==
X-Gm-Message-State: AOJu0YxLa2eJ6al3ybfwygoWPxtuYnrKBc9mbmHfeMFd5gKRuB3fGLrG
	+EUdcmMg5adThumhoBUozWG5XHBX+KLPCHhf5ONuY9L4N8JwMq5+CsBpalHJbHeoryqRuFMiLoL
	l
X-Google-Smtp-Source: AGHT+IFZv8zxor3aelYx0Z+QuoX97OOpApTZXRfWJNtP4SdKsu9Fc5JVznA7ZNAdzNSQNOws8XG/QQ==
X-Received: by 2002:a17:906:b7c4:b0:a59:bb24:a61 with SMTP id a640c23a62f3a-a5a2d292a23mr325908966b.30.1715378935372;
        Fri, 10 May 2024 15:08:55 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 May 2024 00:08:39 +0200
Subject: [PATCH net-next v2 1/5] net: ethernet: cortina: Restore TSO
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-1-2ed841574624@linaro.org>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

An earlier commit deleted the TSO support in the Cortina Gemini
driver because the driver was confusing gso_size and MTU,
probably because what the Linux kernel calls "gso_size" was
called "MTU" in the datasheet.

Restore the functionality properly reading the gso_size from
the skbuff.

Tested with iperf3, running a server on a different machine
and client on the device with the cortina gemini ethernet:

Connecting to host 192.168.1.2, port 5201
60008000.ethernet-port eth0: segment offloading mss = 05ea len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05ea len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05ea len=27da
60008000.ethernet-port eth0: segment offloading mss = 05ea len=0b92
60008000.ethernet-port eth0: segment offloading mss = 05ea len=2bda
(...)

(The hardware MSS 0x05ea here includes the ethernet headers.)

If I disable all segment offloading on the receiving host and
dump packets using tcpdump -xx like this:

ethtool -K enp2s0 gro off gso off tso off
tcpdump -xx -i enp2s0 host 192.168.1.136

I get segmented packages such as this when running iperf3:

23:16:54.024139 IP OpenWrt.lan.59168 > Fecusia.targus-getdata1:
Flags [.], seq 1486:2934, ack 1, win 4198,
options [nop,nop,TS val 3886192908 ecr 3601341877], length 1448
0x0000:  fc34 9701 a0c6 14d6 4da8 3c4f 0800 4500
0x0010:  05dc 16a0 4000 4006 9aa1 c0a8 0188 c0a8
0x0020:  0102 e720 1451 ff25 9822 4c52 29cf 8010
0x0030:  1066 ac8c 0000 0101 080a e7a2 990c d6a8
(...)
0x05c0:  5e49 e109 fe8c 4617 5e18 7a82 7eae d647
0x05d0:  e8ee ae64 dc88 c897 3f8a 07a4 3a33 6b1b
0x05e0:  3501 a30f 2758 cc44 4b4a

Several such packets often follow after each other verifying
the segmentation into 0x05a8 (1448) byte packages also on the
reveiving end. As can be seen, the ethernet frames are
0x05ea (1514) in size.

Performance with iperf3 before this patch: ~15.5 Mbit/s
Performance with iperf3 after this patch: ~175 Mbit/s

This was running a 60 second test (twice) the best measurement
was 179 Mbit/s.

For comparison if I run iperf3 with UDP I get around 1.05 Mbit/s
both before and after this patch.

While this is a gigabit ethernet interface, the CPU is a cheap
D-Link DIR-685 router (based on the ARMv5 Faraday FA526 at
~50 MHz), and the software is not supposed to drive traffic,
as the device has a DSA chip, so this kind of numbers can be
expected.

Fixes: ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index f9523022be9b..b2ac9dfe1aae 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,7 +79,8 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
+			       NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1148,13 +1149,25 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	void *buffer;
+	u16 mss;
 	int ret;
 
-	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
-	if (skb->len >= ETH_FRAME_LEN) {
+	mss = skb_shinfo(skb)->gso_size;
+	if (mss) {
+		/* This means we are dealing with TCP and skb->len is the
+		 * sum total of all the segments. The TSO will deal with
+		 * chopping this up for us.
+		 */
+		/* The accelerator needs the full frame size here */
+		mss += skb_tcp_all_headers(skb);
+		netdev_dbg(netdev, "segment offloading mss = %04x len=%04x\n",
+			   mss, skb->len);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
+	} else if (skb->len >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
@@ -1169,7 +1182,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 				return ret;
 		}
 		word1 |= TSS_BYPASS_BIT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	}
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP

-- 
2.45.0


