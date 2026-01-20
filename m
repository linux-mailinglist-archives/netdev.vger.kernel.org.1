Return-Path: <netdev+bounces-251617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKYGGO7vb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:13:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3E4C0C2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEA9D8A6CAA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061D3D3015;
	Tue, 20 Jan 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQvGZWBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467029DB8F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941557; cv=none; b=IDlmHr8CtPdLFyWh6shQUFaKzYBUWFaXoe9bs3Tg9xefZ6XLh+0OSFigpgZzl7+vOZQ4ykaJnoCrWPQ03fZ4vtvB7fGMK9c+WzIodiYbaGeX7xvwXNHfDKbN92Q5iESvBjwf87ykthIvC0dB/QivZ7YfO1r4JXFKPegYZ2BDvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941557; c=relaxed/simple;
	bh=V0JUXLYyIdj3TL2lyf8gwxfS7pvDlhnP+6acRIt+loE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/e2RIUlb6DZ+OXfWR39isUsaOEsmoNYfXXNEUknsCW/uoAtBFcWjgKXE4xxw57PN26UPD7DqLLSGb0em47ri6dm/dYjyHOtwPKvCjDYjYHuGkdVOGuu9YIN+TvyFA3+MaIlCD3HUiVUX5f5ATEAATy/B4aXhrXBGfqehFEEiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQvGZWBz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee974e230so46367255e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941552; x=1769546352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS2abDDltV4uyJ83wWZDF+in02lUwUwLBKewiaizUbw=;
        b=eQvGZWBzZpAI6OGbJP8NOvjVFIdnl7kXp1u53srx3kkmjWOzIJYGlB2YX2h7bscWJ2
         4qUsdPGUPYyxzL+NaQN8aLzhXP6nYw6wn6RwADmGW/rHeEYflEAPiwXUg33UyI21a14U
         AB83JfTwxoHoD5QjabhUmClDTXMp03bco277QhlFNVb31j85+j0bxu5nJVvTyx+TPEwT
         6/A6FH13Dn54nobRrLNtRUInlwnBtU9H7cuZA/FkKWe1hz9AqOCLxjYCSQ+mMETi5HzL
         gbq7TKYX1DaD6/3I4qHU2yX3gDSNirsOx8rGOhZbAgyoUuTgBBOC8q23KUHAAjxFdlRK
         SfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941552; x=1769546352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FS2abDDltV4uyJ83wWZDF+in02lUwUwLBKewiaizUbw=;
        b=jELy0AkPWqxwya4rdFhgOMk2H04SqdNgr484vaM3WNdd/DzJKuTvusgQKEzvVhL86p
         cDziIUEfmk0O1BI3ZwT5toNuP5KoyIS7+4YuTzjX7gXWnhzNd0yfZVEPllmhMwXDt5ZX
         5Yr0fivKvT2aqIzSSeQMZOdbH7oSLIuJ/q3a0RZJ1GnrBLQvx7PbH1X26+3zUJH5lwe+
         b2Iwnq9ByjoECvSaUSP4eetw/l/3IYnaeS9d8wjOvC2Na3u3mHXphawDinNYXovEgP1C
         W+YdWGQU9HiRVnp38VvRFwj6VR1lyxhrw94W2u7TWP+VoPuFyO+RtBOUTa27lgI7kymr
         2fAg==
X-Gm-Message-State: AOJu0YzxfEugnX2KiDVChvskigXynfQsqjuQ1UYO2Cf2mJvCMNwlhYZP
	31lFz9KqDlAwl2Li4yqJumfVCDJWsuHE9CasoA2kyDmbifd2Pu/dvrd/
X-Gm-Gg: AY/fxX5u1UPQ7Om2v6QDMtr4fbUtLGRJFVl51kXlalBWIVROQIv/rwWWDkOUYN/xEg8
	3kauekjysLqVxjWvzYKJRoS/ODcUWelrg3mQcH125AzCwEKSiYqA2K+9jOA40VUcJkmzU/B7IVl
	fFxPDtnb0qWsxqw69eoZqFqL/pradi407pZTdce1JisC0CHpFsxf7IpdZmpBUWkz9/EcMhsQs08
	zK2a4gfSV6vwz4wLhqz28MXQWTXs3RlCWnvB3XFUOExxQO6VCS8Tgdlmgm5V2YZYjqYuhQQx5gD
	v1qHiCOTFY0tKRYxU+fDiGKCLsjjWW4j9BrR99BV/bA5gIMRhM3AKC3lwO+m7Lu9XtrPiRenN7R
	fdf+YC7NDNrp1G0IxQABOEHjamlVfuo7RU6N7tVCYQRqxjAZbpfsKfshEvi8rhLxE8m6AUn6JZS
	UMQ6VQZzqMOFbG0slR
X-Received: by 2002:a05:600c:190d:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-4803e79bbbamr44181875e9.6.1768941551414;
        Tue, 20 Jan 2026 12:39:11 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:378b:c660:2f9c:b651])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c3a7c1sm850425e9.13.2026.01.20.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:39:10 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v3 3/3] net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP
Date: Tue, 20 Jan 2026 21:30:04 +0100
Message-ID: <20260120203905.23805-4-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120203905.23805-1-eichest@gmail.com>
References: <20260120203905.23805-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251617-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,toradex.com:email]
X-Rspamd-Queue-Id: E1D3E4C0C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The stmmac implementation used by NXP for the i.MX8MP SoC is subject to
errata ERR050694. According to this errata, when no preamble byte is
transferred before the SFD from the PHY to the MAC, the MAC will discard
the frame.

Setting the PHY_F_KEEP_PREAMBLE_BEFORE_SFD flag instructs PHYs that
support it to keep the preamble byte before the SFD. This ensures that
the MAC successfully receives frames.

As this is an issue in the MAC implementation, only enable the flag for
the i.MX8MP SoC where the errata applies but not for other SoCs using a
working stmmac implementation.

The exact wording of the errata ERR050694 from NXP:
The IEEE 802.3 standard states that, in MII/GMII modes, the byte
preceding the SFD (0xD5), SMD-S (0xE6,0x4C, 0x7F, or 0xB3), or SMD-C
(0x61, 0x52, 0x9E, or 0x2A) byte can be a non-PREAMBLE byte or there can
be no preceding preamble byte. The MAC receiver must successfully
receive a packet without any preamble(0x55) byte preceding the SFD,
SMD-S, or SMD-C byte.
However due to the defect, in configurations where frame preemption is
enabled, when preamble byte does not precede the SFD, SMD-S, or SMD-C
byte, the received packet is discarded by the MAC receiver. This is
because, the start-of-packet detection logic of the MAC receiver
incorrectly checks for a preamble byte.

NXP refers to IEEE 802.3 where in clause 35.2.3.2.2 Receive case (GMII)
they show two tables one where the preamble is preceding the SFD and one
where it is not. The text says:
The operation of 1000 Mb/s PHYs can result in shrinkage of the preamble
between transmission at the source GMII and reception at the destination
GMII. Table 35-3 depicts the case where no preamble bytes are conveyed
across the GMII. This case may not be possible with a specific PHY, but
illustrates the minimum preamble with which MAC shall be able to
operate. Table 35-4 depicts the case where the entire preamble is
conveyed across the GMII.

This workaround was tested on a Verdin iMX8MP by enforcing 10 MBit/s:
ethtool -s end0 speed 10
Without keeping the preamble, no packet were received. With keeping the
preamble, everything worked as expected.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   | 6 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 include/linux/stmmac.h                            | 1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index db288fbd5a4df..c722ff2dc1fcb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -320,6 +320,9 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
 
+	if (data->flags & STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD)
+		plat_dat->flags |= STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD;
+
 	/* Default TX Q0 to use TSO and rest TXQ for TBS */
 	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
 		plat_dat->tx_queues_cfg[i].tbs_en = 1;
@@ -355,7 +358,8 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
 	.addr_width = 34,
 	.mac_rgmii_txclk_auto_adj = false,
 	.set_intf_mode = imx8mp_set_intf_mode,
-	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY,
+	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY |
+		 STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD,
 };
 
 static struct imx_dwmac_ops imx8dxl_dwmac_data = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index da206b24aaed9..08a6082fc0c02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1205,6 +1205,7 @@ static int stmmac_init_phy(struct net_device *dev)
 	struct fwnode_handle *phy_fwnode;
 	struct fwnode_handle *fwnode;
 	struct ethtool_keee eee;
+	u32 dev_flags = 0;
 	int ret;
 
 	if (!phylink_expects_phy(priv->phylink))
@@ -1223,6 +1224,9 @@ static int stmmac_init_phy(struct net_device *dev)
 	else
 		phy_fwnode = NULL;
 
+	if (priv->plat->flags & STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD)
+		dev_flags |= PHY_F_KEEP_PREAMBLE_BEFORE_SFD;
+
 	/* Some DT bindings do not set-up the PHY handle. Let's try to
 	 * manually parse it
 	 */
@@ -1241,10 +1245,12 @@ static int stmmac_init_phy(struct net_device *dev)
 			return -ENODEV;
 		}
 
+		phydev->dev_flags |= dev_flags;
+
 		ret = phylink_connect_phy(priv->phylink, phydev);
 	} else {
 		fwnode_handle_put(phy_fwnode);
-		ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, 0);
+		ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, dev_flags);
 	}
 
 	if (ret) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f1054b9c2d8ac..e308c98c7bd33 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -191,6 +191,7 @@ enum dwmac_core_type {
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
+#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD	BIT(14)
 
 struct mac_device_info;
 
-- 
2.51.0


