Return-Path: <netdev+bounces-232079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7BC00A6A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851463A82B4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F530C613;
	Thu, 23 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2sEHR+3z"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417073064B2;
	Thu, 23 Oct 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217955; cv=none; b=mwYbwyCaqedGVuhBmGUxggaybGbk3r6kH1sq21atk71s6+RWfGYwb2oBvVjHD++yWl11Mj+T/t4qR5ToKKPyyO1toGJaQtWQEK/Kz6x0s3ZmaBrbXGKCs/Vhqrjz2+oUvVbD3dZSZktaFlPJMWxoHLCGIkBRq/LVDBnSTe6mn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217955; c=relaxed/simple;
	bh=ke9vdkGE55BnqrQGnmExUZiJTixtXTFR+U2tr82HYu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeZjWgM6o3cy9t9E+UP+nf9K/iS6cip+qLf+q14G7OfwIBodWXYfT2JNmqh9hy8KvNHznt8eYgX1o2dSyNbsO4xi3ULi3+44FMAd8DjtSls8XicIYOoaC9Sqx9Ay+VDK+EWDCNFZ+YtzwJ9uMFgwMgHZcWAz93TJ0K49Jh4ORDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2sEHR+3z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=wmH3OxepXxDqffG/SOyXHXMEgKSwM3dGnIL8rLiJ1Nk=; b=2sEHR+3zu2kJ+AQMOFFkE/5uCj
	HSh/RMZQ8czmwM0QfPdcR6+jkT2TsTAJ9aAxUKk22IKLfg2FW0GdT8zmBbVdAsUSItn1Ess8SnqYx
	kFtpss2MvN4mbajDPG8IOj41h0JWwW0ATnEBRs6jjLBI0ILHpNG4Fce0s/QxqBeV6WyedT2LLW2tH
	EG5IymuncStcqbRUIccs2zMu4ds9YRFqwyVViyvwkmInfRiOuxVVwmwtg0pRnZXdHN7QeV81u8s9S
	MPmgnMlLmUK3Cxmg5kMHKJSIdixiIdOmdIJ70vQoYJUC+CXzaezrrgVvpX/xZCL+N/C7E1KyGQBMw
	k8dB+uCg==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEy-0002w5-Eu; Thu, 23 Oct 2025 13:12:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se,
	David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 4/5] ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support
Date: Thu, 23 Oct 2025 13:12:11 +0200
Message-ID: <20251023111213.298860-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251023111213.298860-1-heiko@sntech.de>
References: <20251023111213.298860-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wu <david.wu@rock-chips.com>

Add the needed glue blocks for the RK3506-specific setup.

The RK3506 dwmac only supports up to 100MBit with a RMII PHY,
but no RGMII.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..73330afa4353 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -827,6 +827,69 @@ static const struct rk_gmac_ops rk3399_ops = {
 	.set_speed = rk3399_set_speed,
 };
 
+#define RK3506_GRF_SOC_CON8		0x0020
+#define RK3506_GRF_SOC_CON11		0x002c
+
+#define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
+
+#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
+#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
+
+#define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
+#define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
+
+#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
+#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
+
+static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	unsigned int id = bsp_priv->id, offset;
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
+}
+
+static const struct rk_reg_speed_data rk3506_reg_speed_data = {
+	.rmii_10 = RK3506_GMAC_CLK_RMII_DIV20,
+	.rmii_100 = RK3506_GMAC_CLK_RMII_DIV2,
+};
+
+static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
+			    phy_interface_t interface, int speed)
+{
+	unsigned int id = bsp_priv->id, offset;
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
+				offset, interface, speed);
+}
+
+static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
+				       bool input, bool enable)
+{
+	unsigned int value, offset, id = bsp_priv->id;
+
+	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
+
+	value = input ? RK3506_GMAC_CLK_SELECT_IO :
+			RK3506_GMAC_CLK_SELECT_CRU;
+	value |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
+			  RK3506_GMAC_CLK_RMII_GATE;
+	regmap_write(bsp_priv->grf, offset, value);
+}
+
+static const struct rk_gmac_ops rk3506_ops = {
+	.set_to_rmii = rk3506_set_to_rmii,
+	.set_speed = rk3506_set_speed,
+	.set_clock_selection = rk3506_set_clock_selection,
+	.regs_valid = true,
+	.regs = {
+		0xff4c8000, /* gmac0 */
+		0xff4d0000, /* gmac1 */
+		0x0, /* sentinel */
+	},
+};
+
 #define RK3528_VO_GRF_GMAC_CON		0x0018
 #define RK3528_VO_GRF_MACPHY_CON0	0x001c
 #define RK3528_VO_GRF_MACPHY_CON1	0x0020
@@ -1808,6 +1871,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3366-gmac", .data = &rk3366_ops },
 	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
 	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
+	{ .compatible = "rockchip,rk3506-gmac", .data = &rk3506_ops },
 	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
-- 
2.47.2


