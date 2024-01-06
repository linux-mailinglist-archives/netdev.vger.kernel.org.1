Return-Path: <netdev+bounces-62132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F769825D52
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 01:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F859284C49
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE26137C;
	Sat,  6 Jan 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnHlO+Md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFD136F
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso838511fa.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704499947; x=1705104747; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nd+q3T6bJn4LWU4P3zV0GEvzKAlcMoutm+I8kik9V9s=;
        b=YnHlO+MdOmGAXfxpFGThSFlx/dUzzasqiBvb+Mu6davzcvP+0qxpBgOfU2Rlfj+FUl
         CyYjfAhWckCkBnRWt/Tlj8iF3xZBJ7RX57QHDP4i5NXVtnWfjnhX5S2cRDCYIGb5xhsb
         xnkFd7M7SxJdpNftmrRrbzKoBT4779RjEx9bP74nxZNwq7qOK5NHb14dCDQco7C527wM
         4TqFxSyI5LKhfUVbAGUtqm8GFAdJegNaqA9KDhPs43jTk3mxuZY+6EgrHMSe3HaPJTbf
         7fWHcuZTqg1EuVYxSSxDza+pb6ikxKFr2C6olHUKGWiSKqQtwfgBlxcnsniY6ncf+ZKO
         HnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704499947; x=1705104747;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nd+q3T6bJn4LWU4P3zV0GEvzKAlcMoutm+I8kik9V9s=;
        b=LfTWBpVLpnj1StoxD/MMqLRW8ij0u7I3I6gNADaIvoaRMVR8FEjzmIHLv4k4hBOJqT
         C4moJXoXOxlyMhIadb+KSLX/7a2bD/YLbLqZiJ9Y6CuE/2eTiuuCsgOfVFBxj/H48dzl
         xJ8hSB6xl2ZXPFsFOuqWHCcI+2eQ3dhBpk3WJL1S9uPvhFaPqhCmNcKPL9S2GxsYM6M6
         2Yv3d1NxrleKvPNTVUQH3kQmv5iU2WC2TUVKIubt5qiQEEs8uBxgq+cFna0XwYIAZP5j
         TcGZA+DyOKTPFpVRdEPF9YMoGgvUiqe6nNYoZMOmSDuMiJLscQlQ62cu+5ClAwEx5aZl
         REXg==
X-Gm-Message-State: AOJu0Yy9v0LHSP9jrrGRBF6NzTJsqdLXGLYQQTqQo0z9jfNS5bQPnDgh
	lLcWwjrefomr84G+OIjDA53CbPpLAVRBXA==
X-Google-Smtp-Source: AGHT+IEWqvIOyFp7GlwZ7V5OPPgelD9RkT1c5QEW0ETnedp0MozEXjbEvgvl8qaVzz85S4vOQVGwxQ==
X-Received: by 2002:a05:6512:4019:b0:50e:6e7b:1ac5 with SMTP id br25-20020a056512401900b0050e6e7b1ac5mr96360lfb.5.1704499946958;
        Fri, 05 Jan 2024 16:12:26 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u11-20020ac258cb000000b0050e3508d03dsm368545lfo.194.2024.01.05.16.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 16:12:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 06 Jan 2024 01:12:22 +0100
Subject: [PATCH net v6] net: ethernet: cortina: Drop TSO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-new-gemini-ethernet-regression-v6-1-889e98d3deb7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOWamGUC/4XNy07FIBAG4Fc5YS0GZig9deV7GBdchpZEqYGma
 k767nJqTGq6YPnP5ftvrFCOVNjT5cYyrbHEOdWgHy7MTSaNxKOvmYEAlCCQJ/rkI73HFDktE+V
 EC880Zir3V45O9+BpcMEPrCIfmUL82gteWL1lr3U4xbLM+XsvXeW++vVl1/JXyQUfUCB2SlkCf
 H6LyeT5cc7jbq9w9HTTg+pp5UAPSqIP5uThwQPZ9LB6ZtBWYa9soOvJU0cPmp66e6ipl1YEBHv
 yuj9PCSnaXlc9F7Q0Fo25Ov/P27btBw77wSYSAgAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The recent change to allow large frames without hardware checksumming
slotted in software checksumming in the driver if hardware could not
do it.

This will however upset TSO (TCP Segment Offloading). Typical
error dumps includes this:

skb len=2961 headroom=222 headlen=66 tailroom=0
(...)
WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c/0x108
gemini-ethernet-port: caps=(0x0000010000154813, 0x00002007ffdd7889)

And the packets do not go through.

The TSO implementation is bogus: a TSO enabled driver must propagate
the skb_shinfo(skb)->gso_size value to the TSO engine on the NIC.

Drop the size check and TSO offloading features for now: this
needs to be fixed up properly.

After this ethernet works fine on Gemini devices with a direct connected
PHY such as D-Link DNS-313.

Also tested to still be working with a DSA switch using the Gemini
ethernet as conduit interface.

Link: https://lore.kernel.org/netdev/CANn89iJLfxng1sYL5Zk0mknXpyYQPCp83m3KgD2KJ2_hKCpEUg@mail.gmail.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This fix was developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.
---
Changes in v6:
- Keep the software checksum on larger frames, just drop the
  TSO support which is bogus anyway.
- Drop the heuristics in the second patch. Just dropping TSO
  makes everything work right.
- Drop adding the length in word3.
- Link to v5: https://lore.kernel.org/r/20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org

Changes in v5:
- Drop the patch re-implementing eth_header_parse_protocol()
- Link to v4: https://lore.kernel.org/r/20231222-new-gemini-ethernet-regression-v4-0-a36e71b0f32b@linaro.org

Changes in v4:
- Properly drop all MTU/TSO muckery in the TX function, the
  whole approach is bogus.
- Make the raw etherype retrieveal return __be16, it is the
  callers job to deal with endianness (as per the pattern
  from if_vlan.h)
- Use __vlan_get_protocol() instead of vlan_get_protocol()
- Only actively bypass the TSS if the frame is over a certain
  size.
- Drop comment that no longer applies.
- Link to v3: https://lore.kernel.org/r/20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org

Changes in v3:
- Fix a whitespace bug in the first patch.
- Add generic accessors to obtain the raw ethertype of an
  ethernet frame. VLAN already have the right accessors.
- Link to v2: https://lore.kernel.org/r/20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org

Changes in v2:
- Drop the TSO and length checks altogether, this was never
  working properly.
- Plan to make a proper TSO implementation in the next kernel
  cycle.
- Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..705c3eb19cd3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1143,23 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
-	unsigned short mtu;
 	void *buffer;
 	int ret;
 
-	mtu  = ETH_HLEN;
-	mtu += netdev->mtu;
-	if (skb->protocol == htons(ETH_P_8021Q))
-		mtu += VLAN_HLEN;
-
+	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
-	if (word1 > mtu) {
-		word1 |= TSS_MTU_ENABLE_BIT;
-		word3 |= mtu;
-	}
-
 	if (skb->len >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the

---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


