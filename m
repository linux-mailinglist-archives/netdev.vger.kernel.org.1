Return-Path: <netdev+bounces-103486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC2908425
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD20B212CC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA2146D55;
	Fri, 14 Jun 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHqB0eXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1C17C72;
	Fri, 14 Jun 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348558; cv=none; b=gTSRNs76ssmeHwotwqe1TMJaKXweguYjhq95k6y9dpmAKdGH8AlNkhq7qMmovoWA4HO1OJdLrWozYQJn2Fzrb7N4rAMTJXEs0I/x+raazA8ejh4ZayMxrNi+q2HrezqAS1Gulgv3EYp7SeJjGy/7e7rdnVmVFduek4/lph2v1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348558; c=relaxed/simple;
	bh=jDYNxMYUTSaQU5TQ2+5iBWuMX4NMSKkItAeMuFhk76M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttr/09L0WNqGyqwo34BVFa3zDz1SlLDTy7TD63EBzP0u23ExbndFcSO04C6rW5UB4/ySXpRh6VGVOkvolk8sXFTuNADdOoY4ye8imILQMlPYvCrOMC+Oh7/+ujd+gDWo+5+lL4LwGZrGRPK8tuzxhWZ0v7efebR23oTl1XGrGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHqB0eXj; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9cc66c649so842214b6e.1;
        Fri, 14 Jun 2024 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718348556; x=1718953356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=By4P0vcgLroOQCJskwfGLQoINqqC43myu7beQ18KDt0=;
        b=KHqB0eXjVYi2mGMz004Xhf3TUEsZmN6JR6aLwKYAttLSi3YvMDfMbDsmwAsXJouRYO
         JSD3InIKYqeiA8o2lAvNGfUjQX+zRJoLeF1a5UJ4Ol6M7YcQ61kuKyGo6iX9c8CHqL3h
         9ClQrjfDYwx4wivgBpvB3bZrowiwe5geBe5Lgov8m78Zy4SneQIWLXAA//R6zKBEEGBW
         R/gu9GSZ0j8mqyFH4z8mUGycmBw/8iScT0pEAbE2zPlYDYuOuxKjFHuNCVuat8jv5Ock
         Y6M/L9zlSEAX6U2mtQ+u1u28KKUVHy6zdl1P1I0tAWJl7xvZdZnhXfXZtde2Kq9oNwsF
         YCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718348556; x=1718953356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By4P0vcgLroOQCJskwfGLQoINqqC43myu7beQ18KDt0=;
        b=BM3CR+IgSGvYFVlfuGVX9q4hdHpstp1izlvIf96xPLuVrT78FKE6fVEDCFeQQ9JzN3
         Qx785RO8BICxXS6iySc5xsDN/7V6NNj4RmCmcmCWZV7BLjyB+GPFkyGu52hiEdgbTD7S
         S9ebmU/JUuy/UbceSywhsCnl1UFsjrEO6Rc05M4oFxjLqkpN4WW54/oazllj8iun/oPs
         WvYXSbMaZiG+eAavgrayNhIFISp705yk1/8uPBQYGnTKHEqcoiyUUOEOypqIB+ABVyED
         VtsFeBCmn3SnQwK6rXgRR+vqhXNzK2dFYqcRaa0aXHxMFh9NT++iXqwXTDxpV65zSsEv
         c4bw==
X-Forwarded-Encrypted: i=1; AJvYcCV6W7kRJdc2rl/L46L31FQ+bGqLVIH6wJr/YKPJu+O8PCvB06IuX48dLTm6IXIBvK226A5znrvgY3lBVCHHUqZwqsar4g1e0FZQVdy8
X-Gm-Message-State: AOJu0YwYrCL73cfV+iQc6F8gGIi3hjqtWJS1BcLAAzcpqQV8T9bexVoO
	ees2D2VOvk4+fEW3qVt4ux8UlKJNl8NczqD4KzBZnAwMYicuJITE
X-Google-Smtp-Source: AGHT+IFIcoEGF1ujGsaAknACmdVAzRUo/ikVN155rUrAwKruOrjOfcAV7bcoaC10WeY7S6jOQeHj6w==
X-Received: by 2002:a05:6358:7184:b0:19f:5631:97cd with SMTP id e5c5f4694b2df-19fa9e5c312mr252970455d.15.1718348555911;
        Fri, 14 Jun 2024 00:02:35 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6fede354612sm2072893a12.35.2024.06.14.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:02:35 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3] net: stmmac: Enable TSO on VLANs
Date: Fri, 14 Jun 2024 15:02:06 +0800
Message-Id: <20240614070206.506999-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TSO engine works well when the frames are not VLAN Tagged.
But it will produce broken segments when frames are VLAN Tagged.

The first segment is all good, while the second segment to the
last segment are broken, they lack of required VLAN tag.

An example here:
========
// 1st segment of a VLAN Tagged TSO frame, nothing wrong.
MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1518: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [.], seq 1:1449

// 2nd to last segments of a VLAN Tagged TSO frame, VLAN tag is missing.
MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 1449:2897
MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 2897:4345
MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 4345:5793
MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [P.], seq 5793:7241

// normal VLAN Tagged non-TSO frame, nothing wrong.
MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1022: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [P.], seq 7241:8193
MacSrc > MacDst, ethertype 802.1Q (0x8100), length 70: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [F.], seq 8193
========

When transmitting VLAN Tagged TSO frames, never insert VLAN tag by HW,
always insert VLAN tag to SKB payload, then TSO works well on VLANs for
all MAC cores.

Tested on DWMAC CORE 5.10a, DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
  Changes in v3:
    - Drop packet and increase stats counter when vlan tag insert fails.

  Changes in v2:
    - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..87aa3528cc0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4233,18 +4233,32 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int nfrags = skb_shinfo(skb)->nr_frags;
-	u32 queue = skb_get_queue_mapping(skb);
 	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
-	int tmp_pay_len = 0, first_tx;
+	int tmp_pay_len = 0, first_tx, nfrags;
 	struct stmmac_tx_queue *tx_q;
-	bool has_vlan, set_ic;
+	bool set_ic;
 	u8 proto_hdr_len, hdr;
-	u32 pay_len, mss;
+	u32 pay_len, mss, queue;
 	dma_addr_t des;
 	int i;
 
+	/* Always insert VLAN tag to SKB payload for TSO frames.
+	 *
+	 * Never insert VLAN tag by HW, since segments splited by
+	 * TSO engine will be un-tagged by mistake.
+	 */
+	if (skb_vlan_tag_present(skb)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (unlikely(!skb)) {
+			priv->xstats.tx_dropped++;
+			return NETDEV_TX_OK;
+		}
+	}
+
+	nfrags = skb_shinfo(skb)->nr_frags;
+	queue = skb_get_queue_mapping(skb);
+
 	tx_q = &priv->dma_conf.tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
@@ -4297,9 +4311,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb->data_len);
 	}
 
-	/* Check if VLAN can be inserted by HW */
-	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
-
 	first_entry = tx_q->cur_tx;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
@@ -4309,9 +4320,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc = &tx_q->dma_tx[first_entry];
 	first = desc;
 
-	if (has_vlan)
-		stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
-
 	/* first descriptor: fill Headers on Buf1 */
 	des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
 			     DMA_TO_DEVICE);
@@ -7678,8 +7686,6 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->features |= NETIF_F_RXHASH;
 
 	ndev->vlan_features |= ndev->features;
-	/* TSO doesn't work on VLANs yet */
-	ndev->vlan_features &= ~NETIF_F_TSO;
 
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
-- 
2.34.1


