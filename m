Return-Path: <netdev+bounces-96054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466398C4213
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A248A286477
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C81534EC;
	Mon, 13 May 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOswRWZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE91534EA
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607535; cv=none; b=glGFGqZgYCWn3LuXUJf/e3HZJ3+Zr9TJdCtCix+rNCy647mi7/3yiqyPtGd727mKL90hs+IzaOMKKNByXii4r+94HiC7u+psSebVvZv+ozbAk+LmaIfNPa5NV7Lt8yLUvo1PjkmCztLmd7eTL99XGTfZtsaqLYqhzCQxIkzC6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607535; c=relaxed/simple;
	bh=TOcnDy0PN34+98xhqM6Q+UsUioQYwT3XmDQis0oaur4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHEj6Fd2VwvTkxnfm35nERDbSALw0HAt2kApIz9Z9RFOHdPL2R68PWPdBS6teVbcDvliZpwOKOlq6YSbupb/vXbhPC8msjmnZhgIhzKcbxy48LCkcWRRCGeYoGp7c7OTK7hDIHFQjJtSud+yIs8LLiOGp5ubU83fV4aPkHDbjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hOswRWZz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fea3031c3so5695085e87.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607531; x=1716212331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkfteHNXU4Gc7U7F5jS8dOpIBUIN8TpFTqroJmbcsZ8=;
        b=hOswRWZzgenocMjNlMVaZu8LHh+wlX/N5JcZ5eFxoU3TQ9p5TeRbD2uCv+CfIIpH9o
         oAC1fxR+mjNlICAgbXX0syXYOr9xnlEw3+lC9epyiYbrNGKU74Pabhz+Va81PLtf8Mrx
         bMzkz30jBUzDS3ZyvuFgLnED9nTvpm6VRTN+6Q4y27UZZWQih6ncwTp/HXxA3x2PDML4
         /y/InR+XKMpyYfMkOhsRKvSwVn3YmCzNvBH/IHdAkt6YnJ/jcrJ/ZRoUX740+jiEq9ty
         SbceELEjUD44UHSBfWqI9rSHXpA48QdzAUIoVcbuXSesiT7Botol9FYj2FPlM82FKrn3
         wDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607531; x=1716212331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkfteHNXU4Gc7U7F5jS8dOpIBUIN8TpFTqroJmbcsZ8=;
        b=YpzbnDyOlUhKh9zQfQHvkz2cLurP8g0gnNpuy5pUetJK/J3u+GJacD+JPdUJNQXsAT
         cnUfNLIUT26o7j2/u25hdNFG+vmMPn1DZQa54376DiG4N5dn6aFHMsC6ISFNPuBEs/73
         EDUfP1yIpzRjxedxsIMTrTCPjHQGr4aQk2GvsPGwMLikodbyuhVlGLTEg59vt+kslfUC
         erArQ3FtF1tq7QBokRq6GWZbLZ8zWO5HW+b6xgJ+rTfo/g0I1o9NeE5utNUrYVDFN8UC
         8/fNRirHtv0RQDbH4Al45vZzbXf8hv2ZvN9f/4SQnujRBEOwY9nByNLfO4UmB1mBWsmN
         PpIw==
X-Gm-Message-State: AOJu0Yy+x1EEv2SFX7pHfrs4wcdQ8UHBIapInV/vR/RiEIZV7VyxyLfh
	ZBlTOEYf9EQLFsBtIyzQ6O7nGtK7fpRDVOqQygJX8xkNxK56xPh9z2yfphGs3fw=
X-Google-Smtp-Source: AGHT+IFmzbeiaXhGbxDLOql85bYhNtluAasIp5mNZxG2qYihdJZetfrJSZ4lz3Z8qeotT39T+mDnxA==
X-Received: by 2002:a05:6512:3c9a:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-5221027858amr10287838e87.55.1715607531539;
        Mon, 13 May 2024 06:38:51 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 15:38:48 +0200
Subject: [PATCH net-next v3 1/5] net: ethernet: cortina: Restore TSO
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-1-b442540cc140@linaro.org>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
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


