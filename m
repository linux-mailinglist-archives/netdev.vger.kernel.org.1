Return-Path: <netdev+bounces-95599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CD8C2C73
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AA12841AF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F03F13D25B;
	Fri, 10 May 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faUWGNhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E613CFB7
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378940; cv=none; b=iVnIAGTAFs3dlZTjO4QNLK8ijZ6GMYQlz9Lr7gnK44eEX8RVoqXG08geziixHkcNtga2KDP6dKjHWq7o9awNDdF02Mah+4Ej22UKg/FSlCP/i2vuV6JaBmNrKhXIyXUkGjmT6od2ri+VExQzZHE5Gcq8wlSbxakQ1L1PAZg+j/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378940; c=relaxed/simple;
	bh=b2ZaZuAXoLgiE853TvZNovEefrO1OrW6SCZpSyhLG9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpieK5ywXX5vfuOcvg5VQMaqaNPLOJrdfg/WgZnH+7O06SJqQzPqnfWfGrWTSLirBlpjuG3sGHBQkJDBhti3jl13eCaLMo/nUIT6uWIWlSEScYCW9rZsBiLHx2OFVpxeEzGHy0QN9XrAK/fVdErxAiX26K8fEzjbeuGyA3R9mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=faUWGNhZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f71e4970bso2895641e87.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378936; x=1715983736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFSaFpCcqr8xkac6+4cEe6s97eneJvsC2wKr3pUSeSQ=;
        b=faUWGNhZ+u/H703XIiS0I7WSnuGKYTnn0V70gxqaLemkpw49LaYfLF1fCGcc1o8qnm
         PpDVLGh2O8uCNu2d14LFPaKZAE060Mgew6vVnKrdJpmFUeUXNveQ8kDxwOa2SfCloJ+I
         eJL86dZHSwhBsbl6bZKMyntV7lIUdW60XLJXzZpmLcu9ZDqTT/9Y7iWeJmgnZZHxDgcA
         ObAOcylh/OIGGo1QvoRZSOgYIYPZIr4PHgmaAtgQuDIta2Hmtc9jQchMpSj+dnZ7ZJ8d
         rOUNY0yyD2ipeh1a75WF5bu6Kc5UinDDWtoFQeh6LFn+0ut7bDgRJLdqVUSBnjKvppFi
         Xr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378936; x=1715983736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFSaFpCcqr8xkac6+4cEe6s97eneJvsC2wKr3pUSeSQ=;
        b=JwQQI/3vjQRaywIU45vhTt5iynCln+lPCzPimc1QuZwCR8/00Zvwn3sHTozQ8lFxcr
         OUGhwz/TJApqlfTmFf0IBnM1D4bU3jJOsBtDbG/1ktMLY0y017esle7KX9B1zQCCgW2A
         OxNUihHuluTDLLRZu5H3SvypK7YYf57wCWlnc2Va9xpMxc5yVRSfaw6jN4BXopm/Re0Z
         9uZ+N1WweI1PRZmx9noSUy5g6/7ZDROoNSs6xi0ckvCll6mH3grKJ8rddTYij9s8gs8f
         Ddrl1N6pHJ+aF5Z4icvIDeyJo94RCS2MaM9D+JxPOtXJS9aw0jFQrATr9Zgg9740hxiB
         JXXw==
X-Gm-Message-State: AOJu0YwYS85bDYKkKm10l9j6TkBWnTLmy9RQbGnzvacPdX4BEHLA0ZDw
	rUiYeVJV3WgX5qN4QR+2jGIZCnrg0rsDxY1IwnzX0ZMPqloTYryDuNXLEZAmgNc=
X-Google-Smtp-Source: AGHT+IGL75tO/4jHaA/CpM+86i9MINHZbynV9KEX4JA/gQ8sOHvkgdf9PB66tiYdZLsqOQ3d6+9Kbw==
X-Received: by 2002:a05:6512:3a8f:b0:51e:876d:17d0 with SMTP id 2adb3069b0e04-5221016b5dcmr3995815e87.52.1715378936336;
        Fri, 10 May 2024 15:08:56 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 May 2024 00:08:40 +0200
Subject: [PATCH net-next v2 2/5] net: ethernet: cortina: Use TSO also on
 common TCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-2-2ed841574624@linaro.org>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
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


