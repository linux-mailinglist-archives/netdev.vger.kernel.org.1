Return-Path: <netdev+bounces-172567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4FAA556B1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AA3B47C5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800527D776;
	Thu,  6 Mar 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYTSDKYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD127CCDD;
	Thu,  6 Mar 2025 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289273; cv=none; b=ZF5vFvMynANtAl5LfxdJTYbp+PttAnWP2cUFHC7fb8IAAAWXAEohoJ3JGIP5P14WARkSvbGDQARPs4E3WPRw8jwGhq0+AsABgBuAArGa6/AllFLmho6WEzUMa66O0NP7ev3029scCnurea+bpIbMuB0TBugBS+XvWQOm/8cEtoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289273; c=relaxed/simple;
	bh=+ALVKpFaGbWCPa8D1dUiOybrhmpqK3ttQCn6gXDje2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol76EKrz1FtTLt/hsXJqB3hrSGsK6euKTJyJEqvg+L4zj17CiVlTRqprugwLSDQFouB2OZGq4Llw42AI2XFAkL07zh2G+14BVATXvMq8rw20cqe5DYLgOWC4eK2BPvET6KEzlUFbTLoW34OhvNvssSJ7kLdxYtV/qbotqqm69bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYTSDKYN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-600250a14f4so1173104eaf.1;
        Thu, 06 Mar 2025 11:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289271; x=1741894071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGYIb4APztVRi2uQBXHOjlH1/u9S5ghE64JrkMZiZD0=;
        b=hYTSDKYNsKOAebuKn9lLn6bIdTx2I7CpxwKMxCpEhg0ggEckBulHUu02yhOgEbpKRb
         m04oZYW4zYxnpTIObGtc+6yvW0hjyFdva52gifqlpgDR8UNAcT2mE5l9qA8HaOKmbl5N
         IwSenJnqJq70tvBWfJb6NQ/6b58bY7fVb/eI0y77AWFA90DQ89blK8Ps4/F/EUlsV1J2
         UBH72fUfjfw4WHvAWtrBMMrN0K/PfsQ2KBdArpu4DhKQajpG2qAz+bRze4eHbxxNVrvE
         s7Uu3VCRG8gjQQvWEtGe47r9bYvxM8LEsJdOSwACwo8uiAnPZ+7TzJ9Uyo3rd9tr8IXA
         Mwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289271; x=1741894071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGYIb4APztVRi2uQBXHOjlH1/u9S5ghE64JrkMZiZD0=;
        b=dksxFx7GHG1R4C+r8ghfFKRXRyqRXIEUWXUMT+7Iiazk987cEJWZBSSwqPOsEOCByq
         lmjKS+9Td8PXhGsHCY+5D1uCkkFnazo2wFBb7lzAlaaZryBwgawxZ+BCcSW/YT3yIgRR
         aj1/TqM1o+wpB5EinHOWc1rr9u1Plh/r1WSbn2oG6XlZ92pCoT3Ed/FXKLud5xosfCbX
         giRlufS4wrLCBUKUKbo8UT28RwFMkQ9msILsf8qK0Wbj2D/bXd36o5VyNunEBGT0FsUS
         xYyT+ivx0wPheGN9TC/Gpkz3hNa1PhfhokPLWwoBgZX2mkXd8noOHKrN1HJ7BcVbVFBK
         uIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9DVBfpCXEd3fJLD1PZoId8Dz/8+bSg/1TnPB5HW733pAlT+/mEWp2OVceGgiaAY7TlAK8EqSQ@vger.kernel.org, AJvYcCX1A1N5pKLk7c3e3j/J3Pp5m+mXqWqVTX3yWS2uNdSGmvbhdpRUUvsRkk+VadmE1n6B+wRFMMug5/u7EpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++TNoSHA3SqPJ+WByElylk4hUVCZCv1R/PskWzK2A7V83Pyd0
	YZqp1cjA2nwT8JyS63/Wk9unHEZeDgvGtov+xpL8V1M24qtMT6g1
X-Gm-Gg: ASbGncseJD9ajBId4B1VVU3+u2JnMiUdxJfNZzT7gWT02WXS3hAIUBVboPv2pB6PZG8
	kmwukK3E7voVbAiQlVf3IeMznuzqF1eXoywbdMeF3ir/BY7DktB72JAWiLTH5phImz6skJkJzOL
	9s6XT6N+ojzsLdi1K/GNpyZZ83Vnsv85o+UEr4iitD4ULzJ0OGLN9Kxkt/JeWXQddYj75N1iUr8
	OAwuvbow6Q7fzukV2fNLzzPBof7r1DtT5QHomId3lD91L4gn0XrR3tIP71WSEORPD57lgUA6mmP
	2f7lCwZTN1Dm5QHIaHsHsJd3FolmEwDlTy6HD/tj0SLTwn+iyrqG+mv/l7JB+jnoijfuhw7OYSQ
	bx518f4EPXHz2
X-Google-Smtp-Source: AGHT+IEqKRVdNgBFczfviaBWvJPGXMKgQVLDQWujYTynNmLVeuFkPbWs3u4MpREK9ldGifPzAU83vw==
X-Received: by 2002:a05:6870:5b92:b0:29f:d993:a4cb with SMTP id 586e51a60fabf-2c23ebac690mr2734501fac.14.1741289271061;
        Thu, 06 Mar 2025 11:27:51 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:49 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 12/14] net: bcmgenet: move bcmgenet_power_up into resume_noirq
Date: Thu,  6 Mar 2025 11:26:40 -0800
Message-Id: <20250306192643.2383632-13-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bcmgenet_power_up() function is moved from the resume method
to the resume_noirq method for symmetry with the suspend_noirq
method. This allows the wol_active flag to be removed.

The UMAC_IRQ_WAKE_EVENT interrupts that can be unmasked by the
bcmgenet_wol_power_down_cfg() function are now re-masked by the
bcmgenet_wol_power_up_cfg() function at the resume_noirq level
as well.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 24 +++++++++----------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  1 -
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |  8 +++----
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 0706c9635689..8aecf56578cb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4038,8 +4038,20 @@ static int bcmgenet_resume_noirq(struct device *d)
 		reg = bcmgenet_intrl2_0_readl(priv, INTRL2_CPU_STAT);
 		if (reg & UMAC_IRQ_WAKE_EVENT)
 			pm_wakeup_event(&priv->pdev->dev, 0);
+
+		/* From WOL-enabled suspend, switch to regular clock */
+		bcmgenet_power_up(priv, GENET_POWER_WOL_MAGIC);
 	}
 
+	/* If this is an internal GPHY, power it back on now, before UniMAC is
+	 * brought out of reset as absolutely no UniMAC activity is allowed
+	 */
+	if (priv->internal_phy)
+		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
+
+	/* take MAC out of reset */
+	bcmgenet_umac_reset(priv);
+
 	bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_WAKE_EVENT, INTRL2_CPU_CLEAR);
 
 	return 0;
@@ -4055,18 +4067,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
-	/* From WOL-enabled suspend, switch to regular clock */
-	if (device_may_wakeup(d) && priv->wolopts)
-		bcmgenet_power_up(priv, GENET_POWER_WOL_MAGIC);
-
-	/* If this is an internal GPHY, power it back on now, before UniMAC is
-	 * brought out of reset as absolutely no UniMAC activity is allowed
-	 */
-	if (priv->internal_phy)
-		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
-
-	bcmgenet_umac_reset(priv);
-
 	init_umac(priv);
 
 	phy_init_hw(dev->phydev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 926523d019db..633fa9aa0726 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -641,7 +641,6 @@ struct bcmgenet_priv {
 	struct clk *clk_wol;
 	u32 wolopts;
 	u8 sopass[SOPASS_MAX];
-	bool wol_active;
 
 	struct bcmgenet_mib_counters mib;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index f37665ce40cb..5246214aebc9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -199,7 +199,6 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 		  retries);
 
 	clk_prepare_enable(priv->clk_wol);
-	priv->wol_active = 1;
 
 	if (hfb_enable) {
 		bcmgenet_hfb_reg_writel(priv, hfb_enable,
@@ -238,13 +237,12 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 		return;
 	}
 
-	if (!priv->wol_active)
-		return;	/* failed to suspend so skip the rest */
-
-	priv->wol_active = 0;
 	clk_disable_unprepare(priv->clk_wol);
 	priv->crc_fwd_en = 0;
 
+	bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_WAKE_EVENT,
+				 INTRL2_CPU_MASK_SET);
+
 	/* Disable Magic Packet Detection */
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
 		reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
-- 
2.34.1


