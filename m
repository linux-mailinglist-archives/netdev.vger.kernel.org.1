Return-Path: <netdev+bounces-94815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4E8C0C1D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC812829C3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08397149C69;
	Thu,  9 May 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTyxIQFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F513C9A9
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240926; cv=none; b=aqC8NHs5XVsdf0bFk2gAObFeewg0y7xgucBOtObL4WNnp+sRu+rrzJXxNljr6RtL5JK/wKgTxyoZE2pE9ez9v2styv/NvDmyQG/9CnLD41ZAWpngnSOtX+O4KWlLG7aEdDXoa52RhR4C5S5B2mzLaejUBtT+CEmqO7uo5LPwhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240926; c=relaxed/simple;
	bh=aI1KNgNfrBB3s3Y16MF1j5IdHikayqnAoLD6uN4hV6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtfklTPH8RxA3DVGJPnbmIzMLIscKsn36oJ6Hjxs+p46TJdVD5UhRMLHxnx+yFlzCteQFWS/2MzD4GtKqtbXw45eFJUqXH+SXh79kvNnVH7JnVoIOKv6PWQk1HfrFTuGNiI2SqfPoUVgzGk/nAmuW8cCGzJ9pt4GisVuYy4i5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTyxIQFc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a1054cf61so129245466b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715240923; x=1715845723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjFLWEknfZTex6sXau72gRbfcoZhO2p+qTiMxJZwALc=;
        b=QTyxIQFcGhqivnZwRryekgSZMlSYVkvTD7NDJq64vX+dPKKHJDII6ZQTCXEl+ENTCj
         py+/V+u0DZDtvARczRfugPBR18eObtOzKS2KRjng4M2+DJOgjUQ+skxLhAbDYmstYzs9
         ltb/iqYXmBG915tbCWPN8dVeFcAgMHnoxf/9x/+Kuev5SEJB0hjGEPqll+bGm8LuZX23
         7D5fLiPCcZEu3kyEwA16A7G5/+tyw3gtJIoT27A8tJp/+m0rUwgETVA7y44Dhom6Loud
         4uyYhCL6OaWUeh4bsbEA4oVRHf+IBTni5xX9pLkU3G7e5AwvaRb6L0QbVXD049H5eQ7U
         uZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240923; x=1715845723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjFLWEknfZTex6sXau72gRbfcoZhO2p+qTiMxJZwALc=;
        b=BJXUiF5JkjK/H+o8H8dAUMvClHz09Wjd4fhBxJdZdjaE1t7vtEBavR79W5HE6YjKa8
         Cg59uJ+mF1pGRRzNVjKMtHAHRTq3risEsPs+sr4BANQPkdFT8RVvHsR5mTbx+Vrg16Dk
         q65Vav0lLzf+Bo7IrGi2LjgdY/+RgsQC/dyFuvwlGVbzDaEv9p5REyCLal2+FjKuagta
         6Y2VNN2lgWkU8Cu0p37ltgdSlu0l244cdswSQb7o3ztLpm92/Kz0ZL4q9JLyefUSG8LT
         rLLJDCTKEVO5aj+r+n5V1ymaF6XakCib0wsoXIx4dy1eWq9a99FQq8XU4nPNR1SRZskw
         LWKg==
X-Gm-Message-State: AOJu0Yz2xZuQpBclCk3gADb/i5ji5rV9oBg8OOoaQ3eXYqah1Jzh5+YK
	YU4cFXlJDrkg6GIknnJw6d0PVgMc4Wdx0uclRoz10/v1L/OyTycXHLtCDhWwM/k=
X-Google-Smtp-Source: AGHT+IE3X/vKkVPWqKeNstNWckf7S91anMr6a0ABEmyBGfs6a8TDC0oGwp7OzIe/8BMNRo6iId99rw==
X-Received: by 2002:a17:906:ae87:b0:a59:c7d9:9d38 with SMTP id a640c23a62f3a-a59fb955e75mr408608966b.36.1715240923375;
        Thu, 09 May 2024 00:48:43 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d65sm44783366b.126.2024.05.09.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:48:43 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 May 2024 09:48:37 +0200
Subject: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
In-Reply-To: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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
60008000.ethernet-port eth0: segment offloading mss = 05a8 len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05a8 len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05a8 len=27da
60008000.ethernet-port eth0: segment offloading mss = 05a8 len=0b92
60008000.ethernet-port eth0: segment offloading mss = 05a8 len=2bda
(...)

It also performs well: ~268 MBit/s.

Fixes: ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index c569e5615ecf..599de7914122 100644
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
@@ -1148,13 +1149,29 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
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
+ 	if (mss) {
+		/* skb->len will be all segments in this case */
+		netdev_dbg(netdev, "segment offloading mss = %04x len=%04x\n",
+			   mss, skb->len);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
+	} else {
+		mss = skb->len;
+	}
+
+	/* Translate to link layer size */
+	mss += ETH_HLEN;
+	if (skb->protocol == htons(ETH_P_8021Q))
+		mss += VLAN_HLEN;
+
+	if (mss >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
@@ -1169,7 +1186,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
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


