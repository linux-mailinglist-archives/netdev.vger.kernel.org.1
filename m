Return-Path: <netdev+bounces-103463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080DD908381
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835051F2103F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68A145B34;
	Fri, 14 Jun 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ+g9hKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD819D894;
	Fri, 14 Jun 2024 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345094; cv=none; b=lqozqRgeAfZSDRWQU6eFa77J+JQC/SY1M5CVoD6HplTxYTYOW+CzG5bkZ+K7sSD7n0cTLstdwXLe43OhTRLQIzUy4L7y/8Y7e7skcJru9sLGpsYn66cSbX0Mds3VnKsAMK0hChYWYljOR3tcmOPtkDHAnAy4048DcR/kPcA6iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345094; c=relaxed/simple;
	bh=YZzNvjnIyL5l3wI9OwOC6IbvTkH9xCl+YDSPwtYl+Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GUx3FTEjvZ/HrkVjkJQSQoK6LEsTtu40MlN3Ma2r0avAN/eDWCaPFbukubz433nAZ5yqv0ppb2OhbkySDxjIpsBtbA/qBkOqzA4o/vfqxUt9HXhcvpFmiT84rO30kHYKLOqIlzEJNnToy+JUij0h7FXcg6mWcIpyv66IpkBEY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ+g9hKR; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f971cb3c9cso958372a34.1;
        Thu, 13 Jun 2024 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718345091; x=1718949891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lo12y0h1JrbPiWnZp57B9V/XXZzRLcsfqmffBDHVNA=;
        b=XJ+g9hKRAY0yvXicJIxHrIqccQ6bv1lgxfcd/F7cJWtGjZnhitsm3cvRf/9NDAL9m6
         zxcXXlt13WsAgUjTtANDZnLx1zfJYsHdu9wULB5UsXiuXQDn0Ej6KpIRQ3wH7KIUVGAS
         gVFpUN2h3vksm7X0i08kc/Q15Jg4YwtUO09BG3N4uWXxy2yEQxMk17uWqLCgi52oKikD
         6N4FJbMnSyzjIxkLAVfulSNV2QutMKmS01Bb7dKmXCq/OEJv8riZjHIVrl7OJv5sEkss
         1xbcAbeNDt5WUF+l/+rfZjUZaBPSf8aRqCQ4wYp/qshr5vXF9zusgpaNr8/VIb1vmWv8
         q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718345091; x=1718949891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lo12y0h1JrbPiWnZp57B9V/XXZzRLcsfqmffBDHVNA=;
        b=gR9YcnVfcmAGPj9nZnLHYxMSI9F0rbKA8F+VMRWwAw52Uci4XW4VnXSY5Z8q80sHRC
         bD1hdH1DovcaGN0fuzxB/wZrrIkG/p2WxZ5u1UvG34kvBYnWyVdWKi4rXR1I6KTWCpao
         Al0267QSc0q35p7Di72C1luxBkUmRWbc2QvbzhUchpGUnFl964ZkkStkSf2c0ignqOcE
         3Mpgawdhgciajd8dmw5Yh9CCzi2evSHMFvLQEEfooiaOXwM/if8yrrKvdEvIwhw6zBhG
         5OSn3QZpVktjRjpig9lWxl5MOdkFfaKAzvluC3r7Wz5keRiW8pIXgPU7wEJEbbJfv5Df
         nOeA==
X-Forwarded-Encrypted: i=1; AJvYcCW1K08sjbupD81mtk+kCKFsSOoPRq7OCRTMmABFEISCrKSfGpZyNSr1QwqBkK/z2KedwTtMzh5f+kBXb+otT7YJTCvTQah836dOY28L
X-Gm-Message-State: AOJu0YxNZ561pCx7++ZqvSrSqEwg2bKCPOJue6gClgPyxeP6cI+t1gTL
	hbUTvdTLqY0NCZ/+swm4xJsW1fSMKnlCiT3w1Hh55tZwbIxwyrnl
X-Google-Smtp-Source: AGHT+IHd6Af/QURKSaUQ0MKuVRMqC3GMrW5NEG8Y0fvRhKF5F4mHn374tTiHmP39jrSgym0Wc2WhmQ==
X-Received: by 2002:a05:6870:2251:b0:258:456f:2f91 with SMTP id 586e51a60fabf-258456f3325mr1445965fac.4.1718345091473;
        Thu, 13 Jun 2024 23:04:51 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6fee2d36622sm1969337a12.60.2024.06.13.23.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 23:04:50 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net-next v2] net: stmmac: Enable TSO on VLANs
Date: Fri, 14 Jun 2024 14:03:49 +0800
Message-Id: <20240614060349.498414-1-0x1207@gmail.com>
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
  Changes in v2:
    - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..e8cbfada63ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4233,18 +4233,27 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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
+	if (skb_vlan_tag_present(skb))
+		skb = __vlan_hwaccel_push_inside(skb);
+
+	nfrags = skb_shinfo(skb)->nr_frags;
+	queue = skb_get_queue_mapping(skb);
+
 	tx_q = &priv->dma_conf.tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
@@ -4297,9 +4306,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			skb->data_len);
 	}
 
-	/* Check if VLAN can be inserted by HW */
-	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
-
 	first_entry = tx_q->cur_tx;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
@@ -4309,9 +4315,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc = &tx_q->dma_tx[first_entry];
 	first = desc;
 
-	if (has_vlan)
-		stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
-
 	/* first descriptor: fill Headers on Buf1 */
 	des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
 			     DMA_TO_DEVICE);
@@ -7678,8 +7681,6 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->features |= NETIF_F_RXHASH;
 
 	ndev->vlan_features |= ndev->features;
-	/* TSO doesn't work on VLANs yet */
-	ndev->vlan_features &= ~NETIF_F_TSO;
 
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
-- 
2.34.1


