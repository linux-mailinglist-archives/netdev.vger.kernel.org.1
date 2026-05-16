Return-Path: <netdev+bounces-288564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOsPAzTpB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0A55A100
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E4B3029E7F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03BC28C5B1;
	Sat, 16 May 2026 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM3VyOrd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D02701CB
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903230; cv=none; b=DsTijSlGgGe9UzJlQ63ssQFIRzhdl0dQPmaOzQCxnkZ3Tl+XFUYogU89ep5lLC2yVOJi/nhPm60CMu3OCVeKq/pZ/lrAYFDYi9/cXUrniWAxvrK0SbeiLiD+3QEsqJ2vVcj7oyrLMtbT8EtO802bS/HVPzMpLqp1wGo3Qsj5S9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903230; c=relaxed/simple;
	bh=cTbRztR4daSNn6FdbRQypiXJ+qpF6W/5moxuBhFKP+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDcjNRxTewpTN+Ugc3ZBA5ImKpPmygcNzs9YJF4BwmLgm1AMRQ/i4ZTgkMZgIgDUuoNCv86vd9ROcYL4nCqxugrVH1jkkVz4llCOoTzVEgJ3atW1xQ5ZHKhiTWF+koiowvILxYr0CIf58VNFMLJOwRvwwcM/uHSa9Z2c9xeEmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM3VyOrd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so8828196d6.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903228; x=1779508028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpCb6dtdmrBKh+Y9OCSsSmNkTM9oxHYAdURV0LdnR9s=;
        b=MM3VyOrdrKUbCqe41iACKtHU5UhtXivfRMcEQlYPwTjmftw++bBNf+Ul0TdGdeMCMK
         aVryZQVVPq3ZXQF2NH+R+lkr1R9a0+ojcSWPtob0t/t4vAsZ1vwa3oCbt1LmGgD7oI52
         7/9klDRHAT3obBlDIrIC/Hj3n8z22SgBjYUzOyPS27oo4+srnx91pqrIe4BU8dlnfLeQ
         mIE4wibCgdN/fnWKQURXzPxPy+Rur5AgIC6kA6zT5kU9IMa/cYEjnxeNOEFJM4y/+8d5
         KoGqabA0PrZbyzRr8XMprGndo0v9hCa7GjclomVFsqheXBhrCHnh4eDcIP4QgkEIVBTG
         QY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903228; x=1779508028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpCb6dtdmrBKh+Y9OCSsSmNkTM9oxHYAdURV0LdnR9s=;
        b=Jk4pawrEb5+s1SXDgt7P5XAkOCRFJCZVL0Jdc2cs13ap/UdMDo7/9ZHNPhfj4z8QG3
         Fv6610a8hcryt7jPajI4XsWYHoj+U8GkpWiP89KF3exH2+hozzOnJ2Zj3pBG88RhX1Wu
         hnhYMnddhA4H3kLMzwdR0/5e3xgIM1eXr9iEEb7j+B+sBg1fJQsEIUsQqHggXN4qf94c
         yimixD1EWPhM8cq0+mL6wuLmBQjN1IokO6inOBYH3TFlTKF8dmWQA3GYmmaMtrzxJsKL
         Dl9L8t4GO5FG+FluT31oxXOXO3dpNyAe3M9Jw80OnpXVo10LE/Tp2SPp83EgI2q3ejki
         s2qw==
X-Gm-Message-State: AOJu0Yw+hj0gWAltZJGmlzuzwhDqG6UlziKCCBrMQn4gN/vRr6kgHuFv
	Nb/6H78ZiaEMie1K6yAiQ45TcVUMMAtZY6uWlFkkNIm2FlKcY4apAEQI
X-Gm-Gg: Acq92OG6OaWTsmrbDlLwX+3ehttrNeqwCFdO9+3ONh8WOlpNih1ZJCtRLiK6cR3SrwZ
	LI/4Yk0Rw053v6Zk2zrma1eqvK4d8othwYMzqzTZZVWrngNldeDie9L8xgF2LBpCOTdys3UuN2b
	m9HgVqzLtxzDcVEZuKJicz/A5hPQNDhx7hkvqH1JoFol8jIAlvd/QHy+UkvXYQrcERkt/Z0UenC
	pKADQXbdMplFIxnT5MM3SfPoVqj1Z5YdFMG2cU/EE1OWhCZuk0d1/SY1NF25WpNjvLyTbLg3Qo+
	14A40e2Kx3FgqcwASfAc4H7rPXH0BGIeWicD7bINE9GWtTKmHu+k/opDpw6pkcVHWwOzJEnV2M7
	UljHmzD0prbXSvPFrr0tWXJxhjlgidr3W6JAUcf9LJwuyOuTiGsxD/Y9omVl1ODX/RRoGmXuuKu
	hwy/6x+28of5zoUTw6UXVv0XpZJ+62Ec6QiarBg8HCz3NoVfex2w==
X-Received: by 2002:a05:6214:21c6:b0:8be:3c37:5e6a with SMTP id 6a1803df08f44-8ca0f663a53mr116249596d6.21.1778903228457;
        Fri, 15 May 2026 20:47:08 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm70874546d6.16.2026.05.15.20.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:07 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 May 2026 00:46:17 -0300
Subject: [net-next PATCH v4 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-realtek_forward-v4-1-8b6d6a1eefdc@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
In-Reply-To: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 65C0A55A100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert numeric error codes into human-readable strings by
using %pe together with ERR_PTR() in dev_err() messages.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 44 ++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c35cef01ec26..9cb0f0b9beb6 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -789,8 +789,8 @@ static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to read PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to read PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -817,8 +817,8 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	ret = rtl8365mb_phy_ocp_write(priv, phy, ocp_addr, val);
 	if (ret) {
 		dev_err(priv->dev,
-			"failed to write PHY%d reg %02x @ %04x, ret %d\n", phy,
-			regnum, ocp_addr, ret);
+			"failed to write PHY%d reg %02x @ %04x, ret %pe\n", phy,
+			regnum, ocp_addr, ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1068,8 +1068,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to configure RGMII mode on port %d: %d\n",
-				port, ret);
+				"failed to configure RGMII mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 		return;
 	}
 
@@ -1098,8 +1098,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 						     false, false);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to reset forced mode on port %d: %d\n",
-				port, ret);
+				"failed to reset forced mode on port %d: %pe\n",
+				port, ERR_PTR(ret));
 
 		return;
 	}
@@ -1129,8 +1129,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 						     rx_pause);
 		if (ret)
 			dev_err(priv->dev,
-				"failed to force mode on port %d: %d\n", port,
-				ret);
+				"failed to force mode on port %d: %pe\n", port,
+				ERR_PTR(ret));
 
 		return;
 	}
@@ -1285,8 +1285,8 @@ static void rtl8365mb_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *da
 						 mib->length, &data[i]);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to read port %d counters: %d\n", port,
-				ret);
+				"failed to read port %d counters: %pe\n", port,
+				ERR_PTR(ret));
 			break;
 		}
 	}
@@ -1638,7 +1638,8 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 
 out_error:
-	dev_err(priv->dev, "failed to read interrupt status: %d\n", ret);
+	dev_err(priv->dev, "failed to read interrupt status: %pe\n",
+		ERR_PTR(ret));
 
 out_none:
 	return IRQ_NONE;
@@ -1712,8 +1713,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	irq = of_irq_get(intc, 0);
 	if (irq <= 0) {
 		if (irq != -EPROBE_DEFER)
-			dev_err(priv->dev, "failed to get parent irq: %d\n",
-				irq);
+			dev_err(priv->dev, "failed to get parent irq: %pe\n",
+				ERR_PTR(irq));
 		ret = irq ? irq : -EINVAL;
 		goto out_put_node;
 	}
@@ -1776,7 +1777,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	ret = request_threaded_irq(irq, NULL, rtl8365mb_irq, IRQF_ONESHOT,
 				   "rtl8365mb", priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to request irq: %d\n", ret);
+		dev_err(priv->dev, "failed to request irq: %pe\n",
+			ERR_PTR(ret));
 		goto out_remove_irqdomain;
 	}
 
@@ -1952,14 +1954,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to reset chip: %d\n", ret);
+		dev_err(priv->dev, "failed to reset chip: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
 	/* Configure switch to vendor-defined initial state */
 	ret = rtl8365mb_switch_init(priv);
 	if (ret) {
-		dev_err(priv->dev, "failed to initialize switch: %d\n", ret);
+		dev_err(priv->dev, "failed to initialize switch: %pe\n",
+			ERR_PTR(ret));
 		goto out_error;
 	}
 
@@ -2077,8 +2081,8 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	ret = rtl8365mb_get_chip_id_and_ver(priv->map, &chip_id, &chip_ver);
 	if (ret) {
-		dev_err(priv->dev, "failed to read chip id and version: %d\n",
-			ret);
+		dev_err(priv->dev, "failed to read chip id and version: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 

-- 
2.54.0


