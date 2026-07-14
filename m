Return-Path: <netdev+bounces-307562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hFuzIYeKVmqT8gAAu9opvQ
	(envelope-from <netdev+bounces-307562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97D758217
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jIVt3usQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94832300C7C9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE9418A56;
	Tue, 14 Jul 2026 19:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60908418A4E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056449; cv=none; b=LtSxjTu+7hez3i4TMqMPrwVlMK9plaISHv/i6gO4BMCixc9gWcDce4kTbOsZS9bHqixS9Vdhi0/tKWcuWUO/iVRitpU/aIfgLZQC8LDmo+RcsiyzrpXuVj7feMjrZ95qkWkLJ3Whw6pyXP5a2jX3S1WMHMQBbYaLg6Q8M9V82zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056449; c=relaxed/simple;
	bh=ijfFWZi8yhZ0htXUYCmyIn6pdY++5flhVwsw4r77Oig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEOByjns6MIss8pLUQdi4g4jk7P8Zyr0XoR2W/ItzsrTqziTkSeh7oBgcpCXbN8penyZ65Uvj2HWjnn3pfbN83A0jlzqXQffItCawcmWlLKuhKuH92ehr5cu3DyC4MiJWw9ns8dZpln3QbRRZFBWNMrhGonauPj7T8E0IbtYJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIVt3usQ; arc=none smtp.client-ip=74.125.227.132
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc80544c74so4349765ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056448; x=1784661248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmQewzkR5beR2pgYuttXOlNbbfZWq2Schv5a88VtBYQ=;
        b=jIVt3usQfRXuRNf7Th3Yl7yvf3EP3DE1rb0IhFT6xLfmmHNeUKwtwU+1w4JyKeKIw1
         NjAAEL7TbdrzmsXsr3higyfaTthCFfpuzecUs4xT/LId9Xc8ypZIHABFxVOBmBTzXpT7
         L8ADx5gwT7GiXKfD9ZnaBAyGi90RpWHQYxipaKSTQUWP0QwSQnrz4GogvylPZyOIZilp
         n/4fFejSuD7zmAzEc9Gcl8zQ++C9Ttq1KSieM+iCfPBYitv4VepH5zmFQmC+FJJ7kdo2
         iJiyfHgs00V2WmBemzYgKGprEX7PFUo8H1OhQK2iBpTQaOLSNbbmYfi+3gU0APEM0p3Z
         XYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056448; x=1784661248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmQewzkR5beR2pgYuttXOlNbbfZWq2Schv5a88VtBYQ=;
        b=Zaaug9PPGBMTzbiW7DNuHweKfQCOZ94VQjQQYLqp1ePFAt+uv1bEqOvDbKTyMwVT45
         NPngi9L42z5j5AuX9Rdbn5Ey+D1eWdO93ihTCGModNKjVEiM5rEqDEMd7PAK8QsWoOdy
         ZGfkEODHxic8y5SmCFYhc2hrRtL2C1J1CnviJvL1tKQZTTM5xLpF6x2Oc8Jts+gfcY0m
         wVFeItTpydYrRlcNuPwX+KsTsyXdYTM4m4tRnbTd77SWxqnJwhdpoilngEaHQxuJZMli
         H2yfYCb1ZySRzM7Z8lReRXinmo2ZK2ABrqsTZ8u6I0BcIP4pi9XnEo1Xz7l/ApweJM8G
         gFAA==
X-Gm-Message-State: AOJu0Yy6HJ5alYBAQq/o1fmAsD8d/OjxkBpl6K4mP3Thu2ZhLYyiMkML
	BMILUYqDhzhaMJBCvza2xSXzf5tvR6+LImAQXn6KsIPoDjH0XFQfv37u
X-Gm-Gg: AfdE7cn/jFBUugmdPr9Dpb5XdrX5KUFToHyJG2xZ8DJY+wm3EbARCtQ4KuUm0K8TP3H
	0kzaKB/AZ/kfqXSTN81lhnYyPvsAHGHxmOem05hnEfXTYKK75qkoqGj1w971HWN9PjHcBoWOmNT
	3cbwxLFqAD0cjxiQvhBYIgvbzcT6Pjrhfc3JjlQ0nZ6y46BF6rjwaznKLm/BwCOVOY2zXWUr1h4
	5XfCMseNw3ORPJpOMkXOid13C3+UsJKteTFuiVv0DuQ88KB2O0zutj1U+wo9eSMgb74tYyRLRRO
	m8tEPMSGyx/ZeDgvS2JHllrfRjLAxuWO/pX18p1e+cz9BXpLpqoRZBC/tPvzBJybfNhGeK5bmyj
	Qu3vLIq+S7xyrSWWiwdTX0wzEM9pVCUksetrRtvBGo1tXFZmkJRXfp/U2cE8R5/xUVf5K5mdH84
	aJ1Wn7ZFDDu1QEsBz4N7/eLICoR0vhfGAF
X-Received: by 2002:a17:903:292:b0:2ca:52ce:6f91 with SMTP id d9443c01a7336-2ce9f285148mr135561755ad.27.1784056447537;
        Tue, 14 Jul 2026 12:14:07 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:07 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 03/10] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Wed, 15 Jul 2026 03:08:31 +0800
Message-ID: <20260714191341.690906-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307562-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A97D758217

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the GRF register pipe_sgmii_mac_sel.

Add support for this selection by introducing
the "rockchip,sgmii-mac-sel" DT property.

When the property is set to a non-zero value, GMAC1 is selected;
otherwise GMAC0 remains the default. (HW Reset Value: GMAC1)

This is necessary for boards such as the Ariaboard Photonicat, which
uses the SGMII interface connected to GMAC0.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 2b0f152f54709..ff290bc18589a 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -186,6 +186,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_xpcs_phy_ready;
 	struct combphy_reg pipe_pcie1l0_sel;
 	struct combphy_reg pipe_pcie1l1_sel;
+	struct combphy_reg pipe_sgmii_mac_sel;
 	struct combphy_reg u3otg0_port_en;
 	struct combphy_reg u3otg1_port_en;
 };
@@ -212,6 +213,7 @@ struct rockchip_combphy_priv {
 	bool enable_ssc;
 	bool ext_refclk;
 	struct clk *refclk;
+	u32 sgmii_mac_sel;
 };
 
 static void rockchip_combphy_updatel(struct rockchip_combphy_priv *priv,
@@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
+	priv->sgmii_mac_sel = 0;
+	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
+
 	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
 	/* fallback to old behaviour */
 	if (PTR_ERR(priv->phy_rst) == -ENOENT)
@@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 
 	case PHY_TYPE_SGMII:
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
+					priv->sgmii_mac_sel > 0);
 		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
@@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
+	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
 	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
 	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
 	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
-- 
2.47.3


