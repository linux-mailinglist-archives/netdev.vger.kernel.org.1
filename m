Return-Path: <netdev+bounces-181357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201DA84A3A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915DD9A59DF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F329346C;
	Thu, 10 Apr 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkFxFJtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872528A40B;
	Thu, 10 Apr 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302664; cv=none; b=Kk4vMOg+/wc62Hv3bjMMQd86GeWdxCzQ6Lz68MzcxadDeIjNYB8DIatdQYpScCd5grWHyRnanl3A4HDnnvgbn3bCvAClksYgP1wSNFWaIeSzB2d0492STOwNejpyevrApHp1Oawh2w+gfvC7GXU0+LnB7Nxc+fcjFkKnLi5BSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302664; c=relaxed/simple;
	bh=2mhDXsxikwdUiQFj8YGNVaw/ULeunUERVOgejNDyv/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlCJIOmLWPRr9E9hqgo3Obx64OKAmR5gHjalSQiuZ2hqjevGoGMnVjYZtlfPddYIhGGTQHuN5YhkFUt6Vyu3guZiDHAahzmy5sn2WPwPnWN9y8WzmVkMYlcCv74pZbCouUPJcfo2nTgUoEDSlAMIC+YzAE7/BFHJlzWOG7Zf+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkFxFJtc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914a5def6bso582144f8f.1;
        Thu, 10 Apr 2025 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302661; x=1744907461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xP5HKMU4Cr0Wg2B5uZWRhwyFTU2Cp05IOS2+VcVHgI=;
        b=XkFxFJtcMQ6XTK9mSSp2NlC76LualfgUBy+wFZUvquKcf8RHL9ckE7+mp7W2zJxpP2
         v1E4zgN2ymYbU9PXhALLyM2fO86apxm2d9At8agnaEHf39xISCFbktc+vBO0g1Gg8wNI
         NqJ2B5k/FVcqw15Z23TQslGnhso8oA0YV+pi2dlNXURqRfzHoEOlqkYSiR5kQ1BSacmo
         MLdWfT98wo7xVNBJQ1JMjaaMYJpr6g/ttFPJVMOd0z6+L4BOIh0D9+sbs4syPYb7kqUC
         eeHnRg0IfLEsumyi5zjCue4IWywwMlHL3GDVBM7BVDaqnKwIdspFp35+La8weK8Ou/Ic
         V4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302661; x=1744907461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xP5HKMU4Cr0Wg2B5uZWRhwyFTU2Cp05IOS2+VcVHgI=;
        b=QgMx4lavSkv/nuAOfSkrWyy4n937KmDo5j/P+lHHWPF5XdOCEQ5wsymu9JUXQ0Dnsp
         N/0viT0c+PKJaFQScBmoVqBsmNbEpXjU4L0BS49yHp5tozAUCsXrkw2cKiMEuTgZYsDv
         YFQUl11gozKnp2iQOrkRMjF+lCDhzhH8zlY3i/l4rYlIJR7mfyK6mr/QGvS0Q+KouFu9
         PTJBFND/9P5IREwD/6Ioe3MHTeUQSzmPqP3vu0+AZXk0/ZPbBBBcvv+WsGULDubngcbX
         iWWwkQIM+bAUnJra0QFmk+9p1fYiiVWHdoYtXPHT2l6Jde7/fJRkUJgdaDRlslatKGZi
         MavA==
X-Forwarded-Encrypted: i=1; AJvYcCUOdPdeoaLuEoSBljXu+ZER01sajNMMu28ER6d7y5QD7P/vYfNTJYfTvcBBgTFYgpcVv5lg4Hu9lED06P8=@vger.kernel.org, AJvYcCUXej6b+C+pCbhEBgXHw5Mi+gGo70CwavV1XUXhUlfqbFmmvRsUvIm+noSRIuOTDlL3D9NSGuTu@vger.kernel.org
X-Gm-Message-State: AOJu0YwViEKhWXhX4DIXhB/6R7uZXiRnp57eFnVFGSIonp6RT5QYLuOh
	IuwHPWApjmiTEHR6JFL/syKvcmEdoub6VzvyXm0M1EKps0UqBppP
X-Gm-Gg: ASbGnctN+7njR+x645GsjThlEnIAfIJiOIGDiPMBPRoU3fxW2Uc2XObF9WX6gFX2fUJ
	AafLb/zWj+Qvnhze/f8IFzKHNpZLamLmYxvbd55IsGYb7v9Vtue2zZBRvxs7J+Y1Bep3+JuSeAJ
	zUrJ3NRQ6OursAX/47U+gWtrMIqXlY8Tr8rRxBqLGFLPFz5cvuCrJen8LcWmtdQ1AgTQ82B/vAV
	1cxi3+OwDSFu1BW3F7I+TRcSgM5jC5k935yRC8oizXexO4Rxu8O+fpF+C0mAmbtZTNCu/BtV86a
	baOjoD6irUYRgQAlKLqBc6ohPfMYOiugDnCV1OWr2k1vMywXRegDFP6o8EHQX28z2yvp3dFyg03
	zQOehu39lag==
X-Google-Smtp-Source: AGHT+IFLZORQGygpuGXuuMnpMFaA0HiTdtnbUlTXBQlP9aBu0HOw17B9WhsebA8iQM8vk0MLY/KEUg==
X-Received: by 2002:a05:6000:248a:b0:39d:724f:a8cd with SMTP id ffacd0b85a97d-39d8f4993d5mr3238673f8f.35.1744302660529;
        Thu, 10 Apr 2025 09:31:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:31:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 6/6] net: dsa: mt7530: implement .get_stats64
Date: Thu, 10 Apr 2025 18:30:14 +0200
Message-ID: <20250410163022.3695-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that the internally calculated counter might differ from
the real one from the Switch MIB. This can happen if the switch directly
forward packets between the ports or offload small packets like ARP
request. In such case, the kernel counter will desync compared to the
real one transmitted and received by the Switch.

To correctly provide the real info to the kernel, implement .get_stats64
that will directly read the current MIB counter from the switch
register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index fdceefb2083c..0a33ca1dd7ca 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -906,6 +906,51 @@ static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
 	*ranges = mt7530_rmon_ranges;
 }
 
+static void mt7530_get_stats64(struct dsa_switch *ds, int port,
+			       struct rtnl_link_stats64 *storage)
+{
+	struct mt7530_priv *priv = ds->priv;
+	uint64_t data;
+
+	/* MIB counter doesn't provide a FramesTransmittedOK but instead
+	 * provide stats for Unicast, Broadcast and Multicast frames separately.
+	 * To simulate a global frame counter, read Unicast and addition Multicast
+	 * and Broadcast later
+	 */
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNICAST, 1,
+			       &storage->rx_packets);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_MULTICAST, 1,
+			       &storage->multicast);
+	storage->rx_packets += storage->multicast;
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BROADCAST, 1,
+			       &data);
+	storage->rx_packets += data;
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_UNICAST, 1,
+			       &storage->tx_packets);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTICAST, 1,
+			       &data);
+	storage->tx_packets += data;
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BROADCAST, 1,
+			       &data);
+	storage->tx_packets += data;
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BYTES, 2,
+			       &storage->rx_bytes);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BYTES, 2,
+			       &storage->tx_bytes);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_DROP, 1,
+			       &storage->rx_dropped);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_DROP, 1,
+			       &storage->tx_dropped);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_CRC_ERR, 1,
+			       &storage->rx_crc_errors);
+}
+
 static void mt7530_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 				      struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
@@ -3207,6 +3252,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_eth_mac_stats	= mt7530_get_eth_mac_stats,
 	.get_rmon_stats		= mt7530_get_rmon_stats,
 	.get_eth_ctrl_stats	= mt7530_get_eth_ctrl_stats,
+	.get_stats64		= mt7530_get_stats64,
 	.set_ageing_time	= mt7530_set_ageing_time,
 	.port_enable		= mt7530_port_enable,
 	.port_disable		= mt7530_port_disable,
-- 
2.48.1


