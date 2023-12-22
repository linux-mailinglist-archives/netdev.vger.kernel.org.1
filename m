Return-Path: <netdev+bounces-59955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0A81CDA9
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1A1C21E71
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8512C1A0;
	Fri, 22 Dec 2023 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4sQesgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47728E3B
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e44c1b35fso2517011e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703266599; x=1703871399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbEsIRMQk4NPPKjRL9zFJNtECaKyqE/EOexWnszdu60=;
        b=S4sQesgOYUw/AB/iTZZJYXFQpOpttIt+P7pNjemDsbrE5eKy0EwSHddbwkz0xeXmXL
         R/zvPaEYA51Fkp4RD6+322y4O2Bc66XL9FSmdnhW2fvHdj3gzWichOHApLCn2AGgu/fb
         pW1UeCceJwqeZeVw2c7vzM2pXfcQidU79S2acvOYYCuE+xk6U9fG+RL3685Bx7ufeEqY
         4xiC8LY2dUB239JC8Zr4tMtOqOvrT1U5JCiIXN1BKAVPybQMUgWRlMwGoad2N1p9gLHz
         xz2zSB/KYbIhMwYVmlZkIgE5XV1i8BZZiEeiSRUcftfrlCgYpYz4cyAPxOqpjlvf0+Yy
         UEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266599; x=1703871399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbEsIRMQk4NPPKjRL9zFJNtECaKyqE/EOexWnszdu60=;
        b=Easj5Rws8Mr2qdU4jin1fIZGFB0rpJXo9zENFa90P+clCrGJaXJIISvC5mh2j4jjAJ
         ju1lbaWjVdcDq7idsFfFIBAJOVx2vxULnKJAS/6IRYvARe5p/dSDtWwD1ZTzOT5zTCRx
         e/6poi25sssu0mstHuXFKz5A6bX7VzanrITaQaHkZbJa5L7rA6pzDHRMqs1dOULP7tCf
         zawT3dWNeKkIc+/jAVJ5EqEjZtzEbLYwymeM0n0LGYD1E84lwFCfdOqVscw9CXpOkGLQ
         3d+Iv186kQmV0ZhltcHJrnmbkEKdP3aALL1XCl2chwH0glClCTab7xqgQLGYZdCPfcLn
         3C9g==
X-Gm-Message-State: AOJu0YwkPTNLCB3rNcH2TUBgWo7D0tV1iXpQCURyvbwyeQFVVzLJlqfm
	rWUfDZKde4db8TF7HfT7WoCf912TY3YcoocUWOwqvT4CViE=
X-Google-Smtp-Source: AGHT+IEe8HXFB31Kj3ZC/ZARJ16nD3ADWWlNASCZ3odHPGFVGdQWL3/JhVRwApg43qVZEg3gSpwmig==
X-Received: by 2002:ac2:547c:0:b0:50e:54aa:750d with SMTP id e28-20020ac2547c000000b0050e54aa750dmr844404lfn.85.1703266599561;
        Fri, 22 Dec 2023 09:36:39 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b0050e709c8deasm43036lfu.226.2023.12.22.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:36:39 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:36:37 +0100
Subject: [PATCH net v4 3/3] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-new-gemini-ethernet-regression-v4-3-a36e71b0f32b@linaro.org>
References: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
In-Reply-To: <20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
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
index 5e399c6e095b..db828e4f258f 100644
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
+	ethertype = ntohs(skb_eth_raw_ethertype(skb));
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


