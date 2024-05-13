Return-Path: <netdev+bounces-96055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B98C4214
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F5D286573
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C9153564;
	Mon, 13 May 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es6GygUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C7153503
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607536; cv=none; b=RePfccv9w8SltxpUgkKSDfZtu+CX0ChimL6FWBS1/nssoJQjFFtEd65FvG0vCWQ/2NMvWVzTo3TJLKn7JN4AtLzaeSGSvT/1el5wsoDvyEZNTnBHF+Zo5/CRNtZZq6/ssS1P68qRqd9mNhpJtydz3ZnBBU+XxOJZz1BbxZU0IME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607536; c=relaxed/simple;
	bh=b2ZaZuAXoLgiE853TvZNovEefrO1OrW6SCZpSyhLG9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcJZwDnWF3oRx68BVm4w2pjKnkYZ00j2sVmqJGDc7shmEGwu5ieu5HDKUZFTvN6IfN/uQtspfJd78sCrhvY4PWyYoza2GjspjeM2quy+qksyctZ6yujVhaU1aKvQtgBu8ZFmCpGuETkx/NKvKkAFM5BGP0Fc4vEGihSEcH895bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=es6GygUL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518931f8d23so4372135e87.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607532; x=1716212332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFSaFpCcqr8xkac6+4cEe6s97eneJvsC2wKr3pUSeSQ=;
        b=es6GygULuuTlz3e/Gt9r5Fk8053nhconO/knHFQYbPjGgMgtAvQE1liZ9l9bxMfHFx
         ADZZRnr/Cu4ifZBdErNn+u4BgSC5/VanfuxE+9wcVPnyxpOwglD6Ttd7r/ZAgnuF0yJJ
         TiPix8lfmKI0P7R10lvSc5u48Wrotl1qGanQjYGZ0xOHynbU8LzeXe54XiLQDdjkuvx3
         wxjctn48GN6DXSz5SixkGMYnRbsw/APLVRgA9ZGWzr2pD9AxoRmfARIM+yZLUZ0NNgzh
         FKzzuCEZbFH37iFvei9bappGPW3urY6LpTyZ+ZSONPUI+3WaOkOHsvMKE6ZDkqn3Zz2S
         7t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607532; x=1716212332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFSaFpCcqr8xkac6+4cEe6s97eneJvsC2wKr3pUSeSQ=;
        b=xFwKatgoiKTDZ2nsEijnz1lJhhqNRRWPzE73Erpv2koK7hFkbfjn2XaZmmEods9I8q
         LuNLjk3GlKH2SkZbX3IqMYYJlLdiv4pwj4AmSxMCFLQSp4qREKkFvgF2nYCrascu8tMa
         pH7TR85TFEv5Jl9BAwTWNOwFxVSuCONikRtNMte1iHLDVLNTFK/fmO4iFsrQsX3jlnrs
         V4FaWLRmXS3Ya9fW4wLuQ52rdqUHaR+pqKbd/7uI8pQ7rR6vIRzTeVjOClA4rPr3dEdO
         LaBVN7U8WNwbNdfFOHsx5igO6FSKfVTvs33V/uS3BhA76RRJiIXEQLBPCtujMMKf2BZs
         zb5w==
X-Gm-Message-State: AOJu0YwXA+RM564aPddaSJQTwBC/xOJx7RFeZlAy4gSVMnM/ZXToW0Y9
	RHONI/namR/lr7JbykOWv5d0S6eKW4T0NL+2kR5NKh0dDgOi7xiYHOwcNaPsAu8=
X-Google-Smtp-Source: AGHT+IHg6pHRqaucCQoxAqmQ8O0ySum0qcvKxAvvmPZMQWEHDKVwQWbq/F6eBJjVes/ZENfe9KtZWw==
X-Received: by 2002:a05:6512:2117:b0:519:2828:c284 with SMTP id 2adb3069b0e04-52210273c8amr5758616e87.65.1715607532672;
        Mon, 13 May 2024 06:38:52 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:52 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 15:38:49 +0200
Subject: [PATCH net-next v3 2/5] net: ethernet: cortina: Use TSO also on
 common TCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-2-b442540cc140@linaro.org>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

It is possible to push the segment offloader to also
process non-segmented frames: just pass the skb->len
or desired MSS to the offloader and it will handle them.

This is especially good if the user sets up the MTU
and the frames get big, because the checksumming engine
cannot handle any frames bigger than 1518 bytes, so
segmenting them all to be at max that will be helpful
for the hardware, which only need to quirk odd frames
such as big UDP ping packets.

The vendor driver always uses the TSO like this, and
the driver seems more stable after this, so apparently
the hardware may have been engineered to always use
the TSO on anything it can handle.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index b2ac9dfe1aae..3ba579550cdd 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1148,6 +1148,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
+	bool tcp = false;
 	void *buffer;
 	u16 mss;
 	int ret;
@@ -1155,6 +1156,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
+	/* Determine if we are doing TCP */
+	if (skb->protocol == htons(ETH_P_IP))
+		tcp = (ip_hdr(skb)->protocol == IPPROTO_TCP);
+	else
+		/* IPv6 */
+		tcp = (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP);
+
 	mss = skb_shinfo(skb)->gso_size;
 	if (mss) {
 		/* This means we are dealing with TCP and skb->len is the
@@ -1167,6 +1175,20 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 			   mss, skb->len);
 		word1 |= TSS_MTU_ENABLE_BIT;
 		word3 |= mss;
+	} else if (tcp) {
+		/* Even if we are not using TSO, use the segment offloader
+		 * for transferring the TCP frame: the TSO engine will deal
+		 * with chopping up frames that exceed ETH_DATA_LEN which
+		 * the checksumming engine cannot handle (see below) into
+		 * manageable chunks. It flawlessly deals with quite big
+		 * frames and frames containing custom DSA EtherTypes.
+		 */
+		mss = netdev->mtu + skb_tcp_all_headers(skb);
+		mss = min(mss, skb->len);
+		netdev_dbg(netdev, "botched TSO len %04x mtu %04x mss %04x\n",
+			   skb->len, netdev->mtu, mss);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
 	} else if (skb->len >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
@@ -1185,21 +1207,16 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	}
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		int tcp = 0;
-
 		/* We do not switch off the checksumming on non TCP/UDP
 		 * frames: as is shown from tests, the checksumming engine
 		 * is smart enough to see that a frame is not actually TCP
 		 * or UDP and then just pass it through without any changes
 		 * to the frame.
 		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP))
 			word1 |= TSS_IP_CHKSUM_BIT;
-			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
-		} else { /* IPv6 */
+		else
 			word1 |= TSS_IPV6_ENABLE_BIT;
-			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
-		}
 
 		word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
 	}

-- 
2.45.0


