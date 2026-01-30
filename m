Return-Path: <netdev+bounces-255092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGHlFBOHfGmbNgIAu9opvQ
	(envelope-from <netdev+bounces-255092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:25:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADAB9521
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D2A300D468
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522135DCF9;
	Fri, 30 Jan 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiLYhVmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAB35CB92
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768587; cv=none; b=KLxFVf+fHA+jtGSeWGPWCSqFpaAsIvaH2F6dLYODl+jAFQPDTkVe3P6EbP+MkUnE4Ns8TDjJLX5YMTAv6Gur5QjAshBE0b7nNLmXHGecYYSRZSUUK4PV0IJ0pxDHJTJnbOP2JF+5zJWOUTPXLU0KUHGMgnpj8Qm6vt3JQBfoicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768587; c=relaxed/simple;
	bh=umLeoIezuuzWDN9KcyKP6hmewbYcA3GAdo8L2bv2ZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpZA1u+gyUkgTkhApnbXe+vHm2j8JpHh27Xx+8l9kYdT5oJ15DzBiKoJKDoqr/AeHdPXOuI0Y9ndE98zcbNv69N5QPUTMoFwHhHRGLLajNCoHkFKMvPwlnXnHO8l/HeMnu6dk6J/55fZuIrHAU3BNRfdG4ne/wFFRwu9ekG0jK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiLYhVmy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso17205155e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769768584; x=1770373384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLsfEdXp1ghYI/zV3x1liW6kVNIuPDvLp5lPLO4doYE=;
        b=jiLYhVmygo9Tyxkcsmn6jFIm88tSbrtwxfJr7EcLlsPBmGamlBk3ZVBh9wnwgIXCiK
         RpIv73T5gaNqq4yTZ3Db3KftgNlFcNnDo38ib6MQvjyBIBsp1d+AnISTOz4zI18XQYXZ
         tCoCDT22kqjKADaefnzF6uGN1FqpE0eEX84qNQMZPQqSqVkLJCb5m/1jZYJKcZp6jQxH
         PgeGonqA7mpMN0xyR4frZu65lBA7fz12t5Cz+xV6MCsEQ3rLgc2204HDBXRANRw3lxhT
         NT6TWeDZd3W1eWG41u3UbwaqS8OT1ONcS1e7IqrsRmrP1JsGwDaxVTOrTqGHwhTjNp8u
         u7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768584; x=1770373384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLsfEdXp1ghYI/zV3x1liW6kVNIuPDvLp5lPLO4doYE=;
        b=oyCnHju8GVMaO8sYLf3v6zSoR/LnMfLdBLtHgQ12SJ2PjymPTBlV3C+TkP9FCHCXrG
         8lZD83ssOlmFK/XhVSNwfilJN3eRvrxctwHJOzfZnCHywjrec99OZJmNDox0qS5EoQzo
         Tcu4g8SSw1f+bTRjDBzPEuNm2d4chKuA9K3JQR9p2EphTt2IhQ88Ln4Ga2WEOR7o3jN5
         TgufibeVe8NvgBlnI5jqVjqDZAGBw2/wuiXX5ZhYLmWt4kGJaoTV6q0n9kxJ3PuJnge6
         Z/9UNo++3tq8PJQTtnuYBknak6voOT66PYUeuIk6E++jAu+YMB66kJiuWnkYEdL/OMc0
         3gNA==
X-Gm-Message-State: AOJu0YzxrR3Uv7qOgzSlhCUHJPC8ymlx+Jsmb/STfusDKRFNz0qaFW9W
	aCgPmx5r1mEXSI4lTDftlhi5jkavVjVBXiMfM+M7+PVPKvEcErk3zXaXCMDzMGD0+A==
X-Gm-Gg: AZuq6aJKoK5h28ITCiKB4iD345ZrM58zSCQ0V8qfZRCOw1E+WippR8SRzbPBGiWOfFs
	R2RFwh6dSqURz9DcN8uV5hZx+Mnkx8RmX01qjcCra0IOIwhUqH2L4nwZf9LvS9wOgWgDTZNeFIu
	ooWVBNm++FndnllE6vEmHb5N2u4PMan+pKO1jRu4DdmtyX7h42vvn1rrA1iMOhy40G3bc0Gnpk8
	d4oTve7JUqNKKHR0UOg2wyM/NJLfWq9Fzi9cH1EWtOcRgZrnWOowD1fJzsA3nM9orIZ5foS2RAE
	XXN9INlyBH1LjJLCn2GBTsqA7++UeZj6mEui/100NeAe2kON7lgJRSQc59KE755lW2U1lCYjwTj
	9B369jVjmGj94UrKeClu520skWOERxm/0WK7/suR++PGsqS3llf2SQanYLIB/yIEgvy0jT31V0r
	26MX68
X-Received: by 2002:a05:600c:354c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-482db493a87mr25887295e9.15.1769768584156;
        Fri, 30 Jan 2026 02:23:04 -0800 (PST)
Received: from localhost ([2a02:169:c219:1:2541:8fc0:4fcf:ba6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm230093875e9.5.2026.01.30.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:23:03 -0800 (PST)
From: Tomas Hlavacek <tmshlvck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dlan@kernel.org,
	wangruikang@iscas.ac.cn,
	stable@vger.kernel.org,
	Tomas Hlavacek <tmshlvck@gmail.com>
Subject: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support
Date: Fri, 30 Jan 2026 11:23:01 +0100
Message-ID: <20260130102301.477514-1-tmshlvck@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iscas.ac.cn,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255092-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AADAB9521
X-Rspamd-Action: no action

The driver never programs the MAC frame size and jabber registers,
causing the hardware to reject frames larger than the default 1518
bytes even when larger DMA buffers are allocated.

Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
maximum buffer size from 4096 to 4095, since the descriptor buffer
size field is only 12 bits. Account for double VLAN tags in frame
size calculations.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Cc: stable@vger.kernel.org
Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
v3:
- Set all three frame/jabber registers, fix 12-bit buffer size field
  overflow, use actual frame size with VLAN headroom consistently.

v2: https://lore.kernel.org/netdev/20260126171449.83288-1-tmshlvck@gmail.com/
- Added Fixes tag and Cc stable.

v1: https://lore.kernel.org/netdev/20260126135919.77168-1-tmshlvck@gmail.com/
---
 drivers/net/ethernet/spacemit/k1_emac.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..cd6879d7434c 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -38,7 +39,7 @@
 
 #define EMAC_DEFAULT_BUFSIZE		1536
 #define EMAC_RX_BUF_2K			2048
-#define EMAC_RX_BUF_4K			4096
+#define EMAC_RX_BUF_MAX			FIELD_MAX(RX_DESC_1_BUFFER_SIZE_1_MASK)
 
 /* Tuning parameters from SpacemiT */
 #define EMAC_TX_FRAMES			64
@@ -202,8 +203,7 @@ static void emac_init_hw(struct emac_priv *priv)
 {
 	/* Destination address for 802.3x Ethernet flow control */
 	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
-
-	u32 rxirq = 0, dma = 0;
+	u32 rxirq = 0, dma = 0, frame_sz;
 
 	regmap_set_bits(priv->regmap_apmu,
 			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
@@ -228,6 +228,15 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
+	/* Set maximum frame size and jabber size based on configured MTU,
+	 * accounting for Ethernet header, double VLAN tags, and FCS.
+	 */
+	frame_sz = priv->ndev->mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
+
+	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, frame_sz);
+	emac_wr(priv, MAC_TRANSMIT_JABBER_SIZE, frame_sz);
+	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, frame_sz);
+
 	/* Configure flow control (enabled in emac_adjust_link() later) */
 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
@@ -924,14 +933,14 @@ static int emac_change_mtu(struct net_device *ndev, int mtu)
 		return -EBUSY;
 	}
 
-	frame_len = mtu + ETH_HLEN + ETH_FCS_LEN;
+	frame_len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
 
 	if (frame_len <= EMAC_DEFAULT_BUFSIZE)
 		priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
 	else if (frame_len <= EMAC_RX_BUF_2K)
 		priv->dma_buf_sz = EMAC_RX_BUF_2K;
 	else
-		priv->dma_buf_sz = EMAC_RX_BUF_4K;
+		priv->dma_buf_sz = EMAC_RX_BUF_MAX;
 
 	ndev->mtu = mtu;
 
@@ -2005,7 +2014,7 @@ static int emac_probe(struct platform_device *pdev)
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features |= ndev->hw_features;
 
-	ndev->max_mtu = EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
+	ndev->max_mtu = EMAC_RX_BUF_MAX - (ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN);
 	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 
 	priv = netdev_priv(ndev);
-- 
2.52.0


