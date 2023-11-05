Return-Path: <netdev+bounces-46114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D457E16B5
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B21B20F0D
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68918B18;
	Sun,  5 Nov 2023 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVrow5zP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8E18C3C
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:57:34 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F2E0
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 12:57:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50931355d48so5093999e87.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 12:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217851; x=1699822651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkmUkmLoK96BNboao7deauYFXBoeWm6vYd1S1QHVdg4=;
        b=NVrow5zPhOARUcJ620qmCGf0cuZ2picFuADI/ObES/Oco0TYqjoz1pQJyywbgPD1C5
         hWPzKNDAjAQoBAnTXQB9f3b2XIjSWOFdHemaGM8KUdgl/gsYa9p6tP8ZUoXDaNuTN7Pm
         vNYT3QpLD32izsPve5f6HGIcG3ku8VcUpYMy2QtAKBTuTqqcmBBA1K/84x2xZXlfJLG8
         g5kZO/yf7dCep1JDglfPTx3qW90oaIkGqxb5whXumg/QOHu3/63p9mYGIpkqquy3niW5
         yXPknZ60LFWXrqcHMlLoFovxG9N0fV+Ru1UAyx4eIlZQh4jxPyjPdqBX/F5Y3SBwlw4h
         Z+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217851; x=1699822651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkmUkmLoK96BNboao7deauYFXBoeWm6vYd1S1QHVdg4=;
        b=XQomSIR67WsHKJW+zHRVbxFDZN4tvHLNGR2Jbd3tBzIUN9K4xkLBuTWiCkXziBFilx
         J6kyCQFeR+qxQTHu7QjZ0+0/HmBONrBF8vc9ZfVit0Bz/ZMMVk0bRrNr5b6OpHDWePiH
         XZehWN99R9wtMkDgCwpX4JoFm6cGanqScVRsZayDxSdlbLMR/Ff0rGlkmttXkPK03yAU
         s7y3bx6G8p+tLjuReNBeH5IObWPkeLJ3N+7i31FthMNeCsvxkupiCj8LJ7VvFU8wY9xJ
         zVaKa46jCX/P/8AXFRzMmMdt13fokHrANmfortZJdC0YLb2Lo/zDRhqmxKjdSwH9hyUe
         DliA==
X-Gm-Message-State: AOJu0YzU6GhuUZoY1fMIB2Zi07h1lRFWuETQA7PzCodVPxaTueUC04iN
	Nc8zdU0f28r/ze/1ug2jhKFi0w==
X-Google-Smtp-Source: AGHT+IEZ5yfK1828ZFfg1z0JEcil3ZmjTYmj62YIDKrrJea9QiYH64N281WrNe7UIF3CYVdtagRcqg==
X-Received: by 2002:ac2:522c:0:b0:507:9dfd:f846 with SMTP id i12-20020ac2522c000000b005079dfdf846mr19156590lfl.69.1699217851479;
        Sun, 05 Nov 2023 12:57:31 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:31 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 05 Nov 2023 21:57:26 +0100
Subject: [PATCH net v2 4/4] net: ethernet: cortina: Handle large frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The Gemini ethernet controller provides hardware checksumming
for frames up to 1514 bytes including ethernet headers but not
FCS.

If we start sending bigger frames (after first bumping up the MTU
on both interfaces sending and receiveing the frames), truncated
packets start to appear on the target such as in this tcpdump
resulting from ping -s 1474:

23:34:17.241983 14:d6:4d:a8:3c:4f (oui Unknown) > bc:ae:c5:6b:a8:3d (oui Unknown),
ethertype IPv4 (0x0800), length 1514: truncated-ip - 2 bytes missing!
(tos 0x0, ttl 64, id 32653, offset 0, flags [DF], proto ICMP (1), length 1502)
OpenWrt.lan > Fecusia: ICMP echo request, id 1672, seq 50, length 1482

If we bypass the hardware checksumming and provide a software
fallback, everything starts working fine up to the max TX MTU
of 2047 bytes, for example ping -s2000 192.168.1.2:

00:44:29.587598 bc:ae:c5:6b:a8:3d (oui Unknown) > 14:d6:4d:a8:3c:4f (oui Unknown),
ethertype IPv4 (0x0800), length 2042:
(tos 0x0, ttl 64, id 51828, offset 0, flags [none], proto ICMP (1), length 2028)
Fecusia > OpenWrt.lan: ICMP echo reply, id 1683, seq 4, length 2008

The bit enabling to bypass hardware checksum (or any of the
"TSS" bits) are undocumented in the hardware reference manual.
The entire hardware checksum unit appears undocumented. The
conclusion that we need to use the "bypass" bit was found by
trial-and-error.

Since no hardware checksum will happen, we slot in a software
checksum fallback.

Check for the condition where we need to compute checksum on the
skb with either hardware or software using == CHECKSUM_PARTIAL instead
of != CHECKSUM_NONE which is an incomplete check according to
<linux/skbuff.h>.

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web interface.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 576174a862a9..84295c1b87e6 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1165,7 +1166,19 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
+		 * bytes fitting a normal frame and a checksum?
+		 * Just use software checksumming and bypass on bigger frames.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			ret = skb_checksum_help(skb);
+			if (ret)
+				return ret;
+		}
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		if (skb->protocol == htons(ETH_P_IP)) {

-- 
2.34.1


