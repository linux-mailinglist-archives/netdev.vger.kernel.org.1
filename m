Return-Path: <netdev+bounces-98325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61F8D0D2A
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C11C21346
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F615FD01;
	Mon, 27 May 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brgIPpNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854916079A
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838016; cv=none; b=FHaf6o/hHb8tdUz7fNCk+b8ybVS4n9jfqsKqGjb+XvrXonfO/0CW9HoPbgmitIr9gJOSqDiiU7F8piiytfJHJZMPFaB5rfppspsTOjEPVahZvn8G+aN9BS6VZ04XE9zfBuI+R7/je8Nss8ZD6jANCcxri79ZA9+jwmOkphejWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838016; c=relaxed/simple;
	bh=olFcNrlitRlhnfTwAlgRTvyLUkJBSwoDI9Y7TfWA3SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q4MeeXGA8dZUcQTEwsEKg5QSfG8ijXfV50zAD/+3cM+C3/irwODIpV8hZ+9yoOUg+A88PCkU1sQ97r1xIwNvPHfeYfGRrPGiOcqRZGHZbYTlLiLray7lKOzesQjqkIuqv4l8MZMU1tecG8PMrlgkGnIKPehsJ2x3/Rke65Q62Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brgIPpNe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5241b49c0daso115303e87.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716838012; x=1717442812; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U83Ki1k4xpCvigQsDNxXGV3XEaA/LvHC40BPYB5ABAE=;
        b=brgIPpNe5+0iCZy6U6ZFqzvDwWtxUougtBhoWrlw36dzVwKTGxpZmTV/RB4N6DloWu
         Wmuw3FGbOhRW+6xlQErN8PkBo6RXMGotEBB7ywXEeApo1T+LG66EsakDmFt2ScPtOUIx
         1udQZWjDdc1xj2mPmM7lUr4558nT65BvSPcjrjpJobLciLbY1ZH1FIjDBYxuyNDO4mVp
         FWp28FKYF7Ah33Wcj3/FAArMToxRbJtwck/znpfDMFYyudnAdQbuoiGsjV5UKl2y7+Kg
         oLxumdFr2jLngh06ibEa91pG7iXD1T8KYiJw9x7U+SKPdRORiYX1wKZL5Xjdu29pU9Jf
         tFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716838012; x=1717442812;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U83Ki1k4xpCvigQsDNxXGV3XEaA/LvHC40BPYB5ABAE=;
        b=KssadO95lF7+200hG2rm5iygjIb6pxyZhQ/caOUYoZxFuPV3sppYX5Yq2P9Ojj+sEb
         ICg4gohcKlJzNzbdIUoDscQigVwqk2O0OQbNsMf3Y7dPKjiTnJp4UwFgZ9WBzwXkeXib
         HQj4jWs3uvy8fEj7Z6n8A/JIZZylXl1VOJLT8fIgRBAONCvDYEb33I2dsQe4pe4eeVjv
         l6vYvE54d5WVF5bzAmONzbH1QwvsXmVbiLz2vHZxhOKtypgI27a6thj9tfp0BSgfaYP0
         PfOm3d+rZg3ImtmBDd3Ktzk76inpKQxq0dJRBP706SMuv2JbcYvZJl/VIH6aPl93MCfX
         5y9g==
X-Gm-Message-State: AOJu0YxN5Hi5hg+kubBvii2p32PRQh+4CFKYywHOiWSQrCc+9Z8Rp9A/
	bVeXuJEkBQ/zyj02GwKkq1IMQPurAATiqOc7g0l2AVUe8W5iCPMNf4ciKE3I2yTxora8co2BVCn
	zMkAeZQ==
X-Google-Smtp-Source: AGHT+IHDlWmX1y4xzhV2D/mQaNK3AYP/1WFl5grnIQ8r4aXA7exZFEqVcXzf5TFsSFp1GV37laCKew==
X-Received: by 2002:a05:6512:4cb:b0:521:54b5:86a3 with SMTP id 2adb3069b0e04-5296717fec4mr6286422e87.64.1716838012467;
        Mon, 27 May 2024 12:26:52 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e885ca5sm683811e87.17.2024.05.27.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:26:52 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 21:26:44 +0200
Subject: [PATCH net-next v4] net: ethernet: cortina: Restore TSO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-gemini-tso-1-v4-1-1f8103b27d44@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHPeVGYC/x3MQQ5AMBBG4avIrE1STRGuIhYNP2ZhSNuIRNxdY
 /kt3nsoIggi9cVDAZdEOTTDlQVNm9cVLHM2WWOdqW3LK3ZR4RQPrthPnakb31QejnJyBixy/7u
 BFIkVd6LxfT8vm4PCaAAAAA==
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Split this patch off from other patches as it is finished,
  and the other patches are unrelated or need discussion.
- Link to v3: https://lore.kernel.org/r/20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org

Changes in v3:
- None.

Changes in v2:
- Fix up the issue in the previous version where I packed the
  TSO segments into too small packets: the TSO hardware
  expects the "MTU" to be set to the length of the resulting
  ethernet frame for each segment.
- Link to v1: https://lore.kernel.org/r/20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org
---
 drivers/net/ethernet/cortina/gemini.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5f0c9e1771db..7ebd61a3a49b 100644
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

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-gemini-tso-1-ac9056a61ae4

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


