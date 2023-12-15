Return-Path: <netdev+bounces-57813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA48143EF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E8EB2274F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22782179B7;
	Fri, 15 Dec 2023 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQa/TMl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1915EBB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bf69afa99so423636e87.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702630150; x=1703234950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBZx8iwY7hsa1Ukrg2VJzmYeuseJkOebEKzy3FhcaqI=;
        b=pQa/TMl7p0HQAymF3Fb7DraZkrmA1SdB8zVXaQCdNH1EMv9t+YMQ2OB0VzU/AQAGUp
         TaI2TbE0xIueTGecHQYkuDkLd68BZxXx1FNtSW7IKCHxxriXXdnWPRkXjBjJQJxFyXpr
         oAbV8BSQpNFUryfMfxvVKBXAoVxI/AbMUdm6C805DbtCCU8Jmw1ixg/jvN9OK7k3Lwxn
         K5qcJkuXRxxu79tv6FZBXNJxpxo46S3vI7lfkZR4iIh6TqKx+fbfmH+qw64TpJNdLT5i
         MiYEEfXZWJlsk1rLgJ0A9kTaT24Uxch6CzVNKIqFQBuB0W0DC+qKztvs6u+d7JJQt8kp
         UMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702630150; x=1703234950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBZx8iwY7hsa1Ukrg2VJzmYeuseJkOebEKzy3FhcaqI=;
        b=jqtxHIT6jbFTGNeDPRInIwhWKkDWUqHx1tIGm5zcJYBg2aPk0yqguKN39diuYNU2Fj
         +tjxu6n48lD1nfhfCH5IICOmEK409z6NpKjc4Kc8C6ltfC2jhXhNtC+sAewl5HtRwMpO
         xbLRuqGuquXiJ5xZs6guWumHFpCqDHRe8f7TfzK/nhr6fgAbjgaYldb0IICZsJutBnTx
         H8oMaRuyjN6yxYc6wF7DI9vF44KAS08QXG4YRLyUSJ9S4v4XUEc/lJXt3HU4KzWlibVR
         tL9LvxBUBNhW6XCKOMRELVNI5Z+PxBQAOPsjuFzwcUcVR6GKQSTy9x890UyBPB2Uh5L6
         FuhQ==
X-Gm-Message-State: AOJu0YyRP2XRC/EL9Sz7gloD8nglnbT50wJUNfhtRwdnAPlrjjCIlahY
	9vMi9e+O1gLqZ5aQVbLXOyYwTg==
X-Google-Smtp-Source: AGHT+IG+yAHBscm/yFSM4LXd50UzMfwWopPEwRtMN1GTWsybuYIsZOvG64TdkHNDkvlQuD5loQnpSw==
X-Received: by 2002:a05:6512:200a:b0:50e:4a0:f82a with SMTP id a10-20020a056512200a00b0050e04a0f82amr3166056lfb.115.1702630150566;
        Fri, 15 Dec 2023 00:49:10 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id cf21-20020a056512281500b0050e1db15277sm166692lfb.162.2023.12.15.00.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:49:09 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 09:49:08 +0100
Subject: [PATCH net 2/2] net: ethernet: cortina: Bypass checksumming engine
 of alien ethertypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-new-gemini-ethernet-regression-v1-2-93033544be23@linaro.org>
References: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
In-Reply-To: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
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
 drivers/net/ethernet/cortina/gemini.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 255fcffc1579..934016c8caa9 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1144,7 +1144,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	unsigned short mtu;
+	u16 ethertype;
 	void *buffer;
+	__be16 *p;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1159,12 +1161,21 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->len >= ETH_FRAME_LEN) {
-		/* Hardware offloaded checksumming isn't working on frames
-		 * bigger than 1514 bytes. A hypothesis about this is that the
-		 * checksum buffer is only 1518 bytes, so when the frames get
-		 * bigger they get truncated, or the last few bytes get
-		 * overwritten by the FCS.
+	/* Dig out the the ethertype actually in the buffer and not what the
+	 * protocol claims to be. This is the raw data that the checksumming
+	 * offload engine will have to deal with.
+	 */
+	p = (__be16 *)(skb->data + 2 * ETH_ALEN);
+	ethertype = ntohs(*p);
+	if (ethertype == ETH_P_8021Q) {
+		p += 2; /* +2 sizeof(__be16) */
+		ethertype = ntohs(*p);
+	}
+
+	if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
+		/* Hardware offloaded checksumming isn't working on non-IP frames.
+		 * This happens for example on some DSA switches using a custom
+		 * ethertype. Just bypass the engine for those.
 		 */
 		word1 |= TSS_BYPASS_BIT;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {

-- 
2.34.1


