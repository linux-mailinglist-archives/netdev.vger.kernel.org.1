Return-Path: <netdev+bounces-231383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA197BF845A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA44D4E7A59
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96692274B23;
	Tue, 21 Oct 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fswu2ulj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95D26CE34
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075213; cv=none; b=udFTR5v90QMuS0t9+bDnLEydQepuTkDcc+XfE5J9X6JpeZeObaIfx8MpJdAvMg0xfzrZK4Sm9WrGgF48x49OPDJ9Aj9wkQS2dlB5HTibTOSp6RYEpJ8qcUEBjh5MTl2H5V0xIOhNXJupCNG+sno53loFwI5kjLItE75YIia4Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075213; c=relaxed/simple;
	bh=ytzHVf3HtkaUkecNTvEeEXKk9CuPwb3tyEpnW7Jotog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfqfCp/AtzsQVhyvDqvCArlxV7+N0wZz/ze3mfnyXPgnhalqGUpCIfoSYUT328pHQq6FEn+ispxxF+DPq4h3134hHJG9tfrvLr4ABmV3jOPxwTFW8HbJhZOwVGSiUMZQLGJ3BhHZBKdzd58g2+MGiSLsH1c7JtcrINAAoki8d1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fswu2ulj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3455589f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075209; x=1761680009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39TYCjslUWZvszjsRXmpGak+arWZ5M/6BDn3chbsEM8=;
        b=fswu2uljwjQNDamHagWnTXKM4SUI7bWG40UPIZaXmHWTn9VBWbcFUYUMBZuyfTD8+F
         neWqXHSCrA8zXDEN9KoObHNdY3QhYIcwkBAMcMvff1FG0q4N1XLC0C6nn8Zdfs+UeO3p
         S0l+if6as8ze5hmA1w/duZlLN1af+UcHmXCzJU4zy14zcL3+OWBJrnr378Lxv4E4P6Is
         1DpArCrO1PXKJjGXUmsObXzpZ+NZsS4ilHpwAbp//mhzYGluT+F6s0dbdeNlEpjENrYf
         LURFOjLkOev7VVGInt0YWxZwVBF2YHkieVh9BemfAz25/Z2gXAX08vnxhb3dUVqqmzAf
         bkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075209; x=1761680009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39TYCjslUWZvszjsRXmpGak+arWZ5M/6BDn3chbsEM8=;
        b=srEOWQW/o/1ZKKzK+rHktAwAB3jFBAe2MfmOsoD+W+EQKbIbqurnpmH/DFLFNXOkf9
         NQ4aY2Cyd/Tw3Kh7Qcz3PihIr9/PAtfkRDFfyJSARZycbqsQDE40Dyw3wm3PupYwRH9e
         N3xRY7vTFYMWEYIL/sv99VCQpS6+z9qdvOKcsRH0XraZfZ6SmY7wYEp3MwbTUrjY05OZ
         P9FgFV1gcOfW0OJUeGzjsql5g/FCChBA4k3/0bPuYkP1vg9TiJ3NGGtUk+gnzlAJi/sB
         tw/pHa43OKkGOW2bewk32915Afylg5noz7tSZMeuyYNNyojheTfBaAi/wUmpMtrpmV1V
         IjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXLaR1o4SDNISlszTlRN6WE8+5Nr/i7mhaXqWS9PY1SLW+S1Rh+6PmdJ3tP8Gn3LuSTpfiLUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysp3gWRPWWHjs8lg4v+IVh50QtRijfwIZ6DGqlukI4MnUdOvdO
	1DR+gpR0u6DM6eico3doh1Jvf7FHkYa/j3G50dptl+57SyZZJ2e46tU6
X-Gm-Gg: ASbGncs20fud7iX8ENoi3h8Xqct40WGS26qYgRCI18F1FymNnERP0k6ZHzR29an7Ajl
	fG2oQx259chXPm6HkH18Bk7cBB+221fKgt9O6Zug4rNoHerqJ6SqDv/2Kpen/mJ2GSRXF2HWN3K
	X7RPrd5bh/zRmZxbeKB3vCpx8ElGkAOm1Qds5ZCbZDyPStC+A12DV4DSVVm8AMwtyox3/oCQDw6
	okGuooCDDvghYst7K/0yGmNaN9OqUCG774yO+bOW17OSFm0SFUXesBBojsfwoIQnN1yWCGQJ8r4
	ULi4C4gYLw+vwfaSwcPwVC+uQn4v1fGjGlFQ2CLI0bKotLoorIY9qtAIy/EWlD5rUcYP/zGam/0
	pS3Nu21JpjVr7IM4lyLykP8kXCJ+MorjPEJ9N4gS4qxGy/5PgUXOOzG97/LFmvhkYpEd7VFrv8x
	apsdMzG/M5YQVGJb0zZ+0HzPnciONh9FAAeK+6IW2PtFM=
X-Google-Smtp-Source: AGHT+IElUppWel9b0RVHM4zvWcmJ3xHtW8J1ioZFPpIwENi2ahFIOIMw6b/9n0+AeyKKg/4kFhaXWQ==
X-Received: by 2002:a05:6000:144a:b0:427:e1bf:13bd with SMTP id ffacd0b85a97d-427e1bf1a74mr9524872f8f.52.1761075208724;
        Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
Date: Tue, 21 Oct 2025 21:33:12 +0200
Message-ID: <20251021193315.2192359-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021193315.2192359-1-ansuelsmth@gmail.com>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
that is an INTERNAL port for the Embedded Switch.

Rework the GDM init logic by first preparing the struct with all the
required info and creating the phylink interface and only after the
parsing register the related netdev.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 108 ++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h |   3 +
 2 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ce6d13b10e27..fc237775a998 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	phylink_start(port->phylink);
+
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
@@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	phylink_stop(port->phylink);
+
 	return 0;
 }
 
@@ -2813,6 +2817,17 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 };
 
+static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
+							 phy_interface_t interface)
+{
+	return NULL;
+}
+
+static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+}
+
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
 {
 	int i;
@@ -2857,6 +2872,55 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 	return false;
 }
 
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
+				 phy_interface_t interface)
+{
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_select_pcs = airoha_phylink_mac_select_pcs,
+	.mac_config = airoha_mac_config,
+	.mac_link_up = airoha_mac_link_up,
+	.mac_link_down = airoha_mac_link_down,
+};
+
+static int airoha_setup_phylink(struct net_device *netdev)
+{
+	struct airoha_gdm_port *port = netdev_priv(netdev);
+	struct device *dev = &netdev->dev;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+
+	phy_mode = device_get_phy_mode(dev);
+	if (phy_mode < 0) {
+		dev_err(dev, "incorrect phy-mode\n");
+		return phy_mode;
+	}
+
+	port->phylink_config.dev = dev;
+	port->phylink_config.type = PHYLINK_NETDEV;
+	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+						MAC_10000FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  port->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	port->phylink = phylink;
+
+	return 0;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np, int index)
 {
@@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port->id = id;
 	eth->ports[p] = port;
 
-	err = airoha_metadata_dst_alloc(port);
-	if (err)
-		return err;
+	return airoha_metadata_dst_alloc(port);
+}
 
-	err = register_netdev(dev);
-	if (err)
-		goto free_metadata_dst;
+static int airoha_register_gdm_ports(struct airoha_eth *eth)
+{
+	int i;
 
-	return 0;
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int err;
 
-free_metadata_dst:
-	airoha_metadata_dst_free(port);
-	return err;
+		if (!port)
+			continue;
+
+		err = airoha_setup_phylink(port->dev);
+		if (err)
+			return err;
+
+		err = register_netdev(port->dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int airoha_probe(struct platform_device *pdev)
@@ -3034,6 +3109,10 @@ static int airoha_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = airoha_register_gdm_ports(eth);
+	if (err)
+		goto error_napi_stop;
+
 	return 0;
 
 error_napi_stop:
@@ -3047,10 +3126,14 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
-		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+		if (!port)
+			continue;
+
+		if (port->dev->reg_state == NETREG_REGISTERED) {
 			unregister_netdev(port->dev);
-			airoha_metadata_dst_free(port);
+			phylink_destroy(port->phylink);
 		}
+		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
@@ -3076,6 +3159,7 @@ static void airoha_remove(struct platform_device *pdev)
 
 		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
+		phylink_destroy(port->phylink);
 		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index eb27a4ff5198..c144c1ece23b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -531,6 +531,9 @@ struct airoha_gdm_port {
 	struct net_device *dev;
 	int id;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
-- 
2.51.0


