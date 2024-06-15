Return-Path: <netdev+bounces-103780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2805909781
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE41283FD2
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD328DDF;
	Sat, 15 Jun 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoeRlsMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B110A11;
	Sat, 15 Jun 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718445386; cv=none; b=qEvkD0+j24gyoA1bVFXI2KyLm9+AIcM1NU/Uvf5oE5Zysq+Mn6HdKLpIY/h8ZMZ1sxDQfEQvzDwrsecdNThGY8xgyFtARUKxqr0o8Si5kVAx2MB+Pvq4aTHvaDvH3d9pd8Z4M3RJv8A1aMv9+XkCq+Gh3qKnCqo7DCgJe9NMigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718445386; c=relaxed/simple;
	bh=N2YEApRjXLgw063ZUXNRkiHZcwFijtkyX5h2sRacRUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CfrIR5ss5F+zCG6jtZlW4ewp4nw/6IHMOMPTo9jPLrZUWWTKHu+Pv1GsXRPOV/2IlFp6wG3j6pyOGxSOCyD1+PcjSTsQ2/rVgd614sJH+VJa5q9vkLgkN55GY2FI1gtIAWzcYGlBc4Mr2/VyED5c7pUoJRan/VQXEFrq9xG7ioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoeRlsMv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70109d34a16so2632338b3a.2;
        Sat, 15 Jun 2024 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718445384; x=1719050184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tg5u5ShuykptgMBL5I5DS/hZACOm+i1CYfL5BzH1+bY=;
        b=WoeRlsMvPCt+aaEiGFGuPIMI0I3wVO789dVR9TrT1TUBjAUo6geKoA07YMnNl7JF6J
         RmkL3RP99qj7C+khwMm8173kgT4VX10gfiuJHjZX1r2WD6Km04tUcAt4eGYK8J0EFCtY
         +Fm55kolU0K2PLKZAL7YHAmLNw/yoO7DKauM8Umutflr5mla8yl+bPpZEJEB05ItSuDu
         srFJZGMxk3jyvMHW2qZXbq76gRI6BNGPAky4yTdsLnS9RWfyADlPlwLarYnLl/2MXsgU
         aE7zEbBxCpoE0Fa4mSXQAPsLz5v7l5QcptlRyf1Zxg7Qu/8hnPr/G7izpbeG4zDBRGn+
         HhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718445384; x=1719050184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg5u5ShuykptgMBL5I5DS/hZACOm+i1CYfL5BzH1+bY=;
        b=mKZN1asqdcskE3Z1CLboB3QHsWdBfayjy6PQidP6ySWAZ3ewyD5m+h+zfoTws57R3n
         /xLgA9V+fmEcL2gNB5R1wLUD8BTb6R5yIQGuogCJqSxK0qKe1UCbdW2pV+5VZ80RJlug
         6EP+yZdfftByoqzML7bTp5eW7A8OOiXdmP6gomjoD3EPzUBqTOe1UEnvU0h/e04Ng/A8
         QArYpeYQ0WuWjCKH3HBgrw71Ps6mDEWmfhPlE381DrjbPQYoKHUiqVIvnryiqk7IK9Y6
         qj0axXOrlWyezYgAAhUh3ZSzVfDAFuPwwq2yDsDwGHzXKP1XU1NDEZTwKCMBOl7MXjtD
         x5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVm6e9EKVUcpB0jCUHAI06dLwGeRLQMdMQOZR3Kfijvdd3YN/7A6rfJD9EEgmi+OVWsRP1j05Hps7HbQ10XZXZfxoziLDcnQyAXH/6g
X-Gm-Message-State: AOJu0YwB6NQzC4KZpMp7p3C4QN2Csn+Hq9zsf+37Z8JFwON21tYrXwGu
	bLyVC5D3usyOj8hapLGmhKKm4tQNIzlVPGgw51LskI+zUQ9Yuaad
X-Google-Smtp-Source: AGHT+IEDUVaqWTyE5K7lkt2gzZ4FztGsgWD9JDp9eG7o9DJF60GqM8BDrnujcRy+GpHK8csEE5ZSVA==
X-Received: by 2002:aa7:8b94:0:b0:702:65de:19e5 with SMTP id d2e1a72fcca58-705d722b7a3mr5165325b3a.33.1718445384256;
        Sat, 15 Jun 2024 02:56:24 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-705ccb71715sm4531309b3a.175.2024.06.15.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 02:56:23 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Subject: [PATCH net-next v4] net: stmmac: Enable TSO on VLANs
Date: Sat, 15 Jun 2024 17:56:11 +0800
Message-Id: <20240615095611.517323-1-0x1207@gmail.com>
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
  Changes in v4:
    - Re-arrange variables to keep reverse x-mas tree order.

  Changes in v3:
    - Drop packet and increase stats counter when vlan tag insert fails.

  Changes in v2:
    - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5ddbb0d44373..83b654b7a9fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4237,18 +4237,32 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int nfrags = skb_shinfo(skb)->nr_frags;
-	u32 queue = skb_get_queue_mapping(skb);
+	int tmp_pay_len = 0, first_tx, nfrags;
 	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
-	int tmp_pay_len = 0, first_tx;
 	struct stmmac_tx_queue *tx_q;
-	bool has_vlan, set_ic;
+	u32 pay_len, mss, queue;
 	u8 proto_hdr_len, hdr;
-	u32 pay_len, mss;
 	dma_addr_t des;
+	bool set_ic;
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
@@ -4301,9 +4315,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb->data_len);
 	}
 
-	/* Check if VLAN can be inserted by HW */
-	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
-
 	first_entry = tx_q->cur_tx;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
@@ -4313,9 +4324,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc = &tx_q->dma_tx[first_entry];
 	first = desc;
 
-	if (has_vlan)
-		stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
-
 	/* first descriptor: fill Headers on Buf1 */
 	des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
 			     DMA_TO_DEVICE);
@@ -7682,8 +7690,6 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->features |= NETIF_F_RXHASH;
 
 	ndev->vlan_features |= ndev->features;
-	/* TSO doesn't work on VLANs yet */
-	ndev->vlan_features &= ~NETIF_F_TSO;
 
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
-- 
2.34.1


