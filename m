Return-Path: <netdev+bounces-103069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B34906209
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743F0B21681
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D7129E94;
	Thu, 13 Jun 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKDM00vW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66E748E;
	Thu, 13 Jun 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246341; cv=none; b=byJp0AsI6+KR3UNE1zW+grkd+iMCbCcjR7qBJR2xuS2YSG9AruNLnkmi24h/JeKQQM2SkGNsR8K92bwvaPPGKTUyHLKHNG1zaf+ayKmNl/z4yzwUkkyjhiwdAPHF5ard+m/WNqzklusqcpvjUZGjKEzVQpuBQdtzqj/rIRWXLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246341; c=relaxed/simple;
	bh=RlNn75bHESGL394O6dkF2mr2+UrqByxVpEbu21J5zA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FFUAlYsyvP2nfTcWRm/Csi3A/8p8tUAfcCWEMDliG3MuyXsdkHrybchlJYk4ltCUjdbo+POFTfp2QZNLr4MnuJzoVipywzDUDcXGAERrHb6Py52PGXTux6ayam7+z4dGkCcee2BMORSPJDUQ5if9JJAu386TV2yoR+aeNyHBAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKDM00vW; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9c1902459so318035a34.0;
        Wed, 12 Jun 2024 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718246339; x=1718851139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgbGeC4i3nOuWMYoPUlXHb+7fSmu0PqN2K8q/uuqHSs=;
        b=BKDM00vWO1HzfuxsQF6dvoOhbNUwIxOf3QqghEl2edh4OhuUVHlFWsQhPDmaAtwVgU
         i6utMvwyHLBzeXFuXljAvglEsx4wUK04CFD7/44UeTJg5YZFFfGv/Tn8Ku1YRPxUiVrw
         AR7AFQzKEMaHE5ZyKLv7jcWrJ4vbhWl4UTOyEUZPi6HptMC5NXwwMxIf46cDKCD1LcvW
         8DY047kE8Pr0kkzNOZOYsm7tPAIVaocTFXTO7CboidQaZwbZdQ/jwt6EiA+S011259hc
         mQAzK1DgLC26dgDt+QZXjI3fArZ5IDXSTIAZixqVBGSoEhjZ7XDciDdgg4fl+QytEjeL
         zPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718246339; x=1718851139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgbGeC4i3nOuWMYoPUlXHb+7fSmu0PqN2K8q/uuqHSs=;
        b=MojU8wPXUJxHCQXn0TtyCbhLY8F/47p1GyL4XXs2xrlB2+6J+ec68B2xheZdo210ej
         BA8VgSl3ZS5tFfj7yWgt2p4eM7k0eVd937lswOubht62zHhvMtqVQG2vsfT5E7VHaBOa
         Nfnyw8PVZPzf/kFfRm4VgxiaQxHTrtL9I+Krwzg+8cnYZp4Qg60fw2zIs1eywpoOhZNZ
         zK9gwwENj/QN7+d4FJ1XIZ0nJqvC3LksHuV1qED1/Cb5huNQIKmiD+GyC0shmf1p85cF
         C+D46Vc4/IbpAbRgnUYRTeiEx3omZ8rDjj0tqplIWawTjlN3RjMG95VeW0j6vKOXurb+
         Y5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVEm+95f9ExHil+B04DZVTeI2LPpWceFRDDdiDPh/+wWOd1oIP+Uq9ondZfCeeUnh/APLCIwXWDskiy75b7JoesCeeKg13MIy/89bi3
X-Gm-Message-State: AOJu0YwyQVmipL6C+sxR8tmZyFIXZQbKJJZFqNvAcMTZ//5wOyIJPp1q
	z9pU7zqBpW5k9JnFdVM3OI0zMwDxQoJeBhuV1GU28p7Q5Ntpy8bn
X-Google-Smtp-Source: AGHT+IGNr5kdsBRA2T5pp3GrUSQlJ23/IcNXqRpmruBsCoKYpEqhh2PB3TfnlgZj0Ys2t9iz3+YC0w==
X-Received: by 2002:a05:6830:264a:b0:6f9:944a:254f with SMTP id 46e09a7af769-6fa1b942179mr4011182a34.0.1718246339340;
        Wed, 12 Jun 2024 19:38:59 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6fee2d36622sm177556a12.60.2024.06.12.19.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 19:38:58 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v1] net: stmmac: Enable TSO on VLANs
Date: Thu, 13 Jun 2024 10:38:08 +0800
Message-Id: <20240613023808.448495-1-0x1207@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..d2d09edf5476 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4239,16 +4239,32 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_txq_stats *txq_stats;
 	int tmp_pay_len = 0, first_tx;
 	struct stmmac_tx_queue *tx_q;
-	bool has_vlan, set_ic;
+	bool set_ic;
 	u8 proto_hdr_len, hdr;
 	u32 pay_len, mss;
 	dma_addr_t des;
 	int i;
+	struct vlan_ethhdr *veth;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
 
+	if (skb_vlan_tag_present(skb)) {
+		/* Always insert VLAN tag to SKB payload for TSO frames.
+		 *
+		 * Never insert VLAN tag by HW, since segments splited by
+		 * TSO engine will be un-tagged by mistake.
+		 */
+		skb_push(skb, VLAN_HLEN);
+		memmove(skb->data, skb->data + VLAN_HLEN, ETH_ALEN * 2);
+
+		veth = skb_vlan_eth_hdr(skb);
+		veth->h_vlan_proto = skb->vlan_proto;
+		veth->h_vlan_TCI = htons(skb_vlan_tag_get(skb));
+		__vlan_hwaccel_clear_tag(skb);
+	}
+
 	/* Compute header lengths */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 		proto_hdr_len = skb_transport_offset(skb) + sizeof(struct udphdr);
@@ -4297,9 +4313,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb->data_len);
 	}
 
-	/* Check if VLAN can be inserted by HW */
-	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
-
 	first_entry = tx_q->cur_tx;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
@@ -4309,9 +4322,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc = &tx_q->dma_tx[first_entry];
 	first = desc;
 
-	if (has_vlan)
-		stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
-
 	/* first descriptor: fill Headers on Buf1 */
 	des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
 			     DMA_TO_DEVICE);
@@ -7678,8 +7688,6 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->features |= NETIF_F_RXHASH;
 
 	ndev->vlan_features |= ndev->features;
-	/* TSO doesn't work on VLANs yet */
-	ndev->vlan_features &= ~NETIF_F_TSO;
 
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
-- 
2.34.1


