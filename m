Return-Path: <netdev+bounces-172568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B9A556B0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86F8176A58
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109127E1D2;
	Thu,  6 Mar 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNOeT6fO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829A27D78D;
	Thu,  6 Mar 2025 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289276; cv=none; b=tRUBovm95+lFzzkEwmGnCS177DnvjSt4Ik97YXq/ztafPGXkA6rejEtOhPpLK+cwcmRc/TxomiKTM2B+bRCjl1e09KrPhSFFY/Sk23tVHhUagPbrjredK/3zK6L1LeeBlPXHLMZL2LGb6Ye91itppNePpl6xsyaAq7B3A/k/jJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289276; c=relaxed/simple;
	bh=EyZxcuqZS9qZx7JZeAMWGEFb7GLBvRG5vXwLKnz2vQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0esj/FJ9CfbTDzY49MSNQjgIlTOXSwE1eKK390tv/3Wa3U/wrXqvHye1CGhrnuPcg4H0qYcZZenuHRwwiC2k57WZKU91Vi1S8znj3jG346jGRXZMI0fpodxPn2F/uBBzUnQwDu/1R2t6/fXIM3N0DDfbL4CAa96usu7WI5wvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNOeT6fO; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7272cc739f7so1241838a34.1;
        Thu, 06 Mar 2025 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289273; x=1741894073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUMKuDs1LjlTbGCPBNfl702G3vkInr9aiyYjYPRma7w=;
        b=GNOeT6fOMVKHZ+6KEUIqd9bSukPia5o9UWf7SP2q2sts6WB4sLtWe73uwY1qt0PL+X
         dsC7FZRKPkb+Q78mImmBRy7vBfFOT8qQB2HZfiuLmHNdL05sa1q3bXgD0dbaGKooUkpi
         MKO8U9KRybkLCyu/s97w0wZrXZui5GU+FsulxoEYGGAW2fptbhPkisZhZ6LhcCpL/iSe
         3XlAzSN835+g6EMB1jeLR6+e8ZR8hTp2o75jPiku58H7gnRIXJEa2B8Bg1oHv/Pe8nZs
         XsBqACY/QBI7dxmexRiIpGADolgfgBpf/zQ3S1Mknys/qsDP1aOQikXA8eSbuNF6u8yP
         B0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289273; x=1741894073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUMKuDs1LjlTbGCPBNfl702G3vkInr9aiyYjYPRma7w=;
        b=vDx46BcBTUoBgbzekSzkuQIOGefHqFqh2dHz67ZKFl5r3i3mNQTcp1mkRa4F8XIefQ
         i24YHCKf+2/dE7anOSVs/Z0cMDs+UZ6OrYKEXcf2ZYbTbMDCQQzpcU182a2NiUexMR/f
         9X3d7AcgFskmXpEoZIoYhwnH9ddI4Oixqtwc6xOe8/dCQHeZOPg8OaEn7MFoLOBb4urT
         JbzxhVcfBh/tsdFTG+0dew9JuN5L4Jx6FDCWFs1UPJeKf91IfEyeEWoSmSqCvuKYpqZB
         HyKoXZHvKOTfojIuYmgMgGcxKpi/Qo9AC2OP8jowopxAnAVT52wt6su4j0yvQPGqoYHs
         9aVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqTFGuZ/OruEQTfSz3vHb8PlLwLjgjbTXv7gybpvfdLQb2DDi3dxutmdx5Eockuz0FvtAlPGOmWa1F3Ns=@vger.kernel.org, AJvYcCWER+wWJhnFXBNg2ReyPewuUKfzXxVekDxbabPbLR4OOhjBX+nxe415Dp2Q0QZEIRTTJcV/HEcp@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTFPAObuKz7UNyrUz0gL8zPsVs9Ql5MaA9TUfKmlfkKxn78Po
	eHT8EUircsrGrdGOYCQNM9AIPO0Q40pPIQD4bhNtOq5zttCf0Za5
X-Gm-Gg: ASbGncvSJ/dwFwf9EluS1mGxRnAwdDyIH2Aq2qtxP4dZ1DqH9KAsCcrdzGlFJitJzhK
	JMBDQAvcH1vNxsCzQusngRMWpxBkaZ8e/0KJCfWkppMalCCFC0vFiskvG9sg50oyl5fJ01+Heyl
	SUKrtFZmBAmBqsiKENajK6RxHQUt+zco1TbY0fPZ6VLlR6w2Nb5NeT/gMz/xLKigJ7i48pbk9QD
	+vnHqur+gbvs+t5mHdFlamav2QKUBWGNyC3Fun7BlRcjHEBjcgFBTovOGVoajfIMKOQ1DGBrEt7
	4gvghVBZ8M6tXOy3EmM+0QBCKjP2BEs/qSbWGUsjc5JHrtlZbmr5pI87WDQNRwsw2olTUR7oA+n
	yh3iAWr2XxUeb
X-Google-Smtp-Source: AGHT+IFRpQZKwWsJCLNnmSmMjUVA5i7QhfLawOyDX4NpCVmOHL5QDWRO1G3TxvP9MwpWU/gYW9gAoA==
X-Received: by 2002:a05:6830:a8f:b0:728:a42c:a503 with SMTP id 46e09a7af769-72a2b7e8bfbmr3354189a34.14.1741289273469;
        Thu, 06 Mar 2025 11:27:53 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:52 -0800 (PST)
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
Subject: [PATCH net-next 13/14] net: bcmgenet: allow return of power up status
Date: Thu,  6 Mar 2025 11:26:41 -0800
Message-Id: <20250306192643.2383632-14-opendmb@gmail.com>
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

It is possible for a WoL power up to fail due to the GENET being
reset while in the suspend state. Allow these failures to be
returned as error codes to allow different recovery behavior
when necessary.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 13 ++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  4 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 12 +++++++-----
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 8aecf56578cb..8aa575b93e56 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1685,13 +1685,14 @@ static int bcmgenet_power_down(struct bcmgenet_priv *priv,
 	return ret;
 }
 
-static void bcmgenet_power_up(struct bcmgenet_priv *priv,
-			      enum bcmgenet_power_mode mode)
+static int bcmgenet_power_up(struct bcmgenet_priv *priv,
+			     enum bcmgenet_power_mode mode)
 {
+	int ret = 0;
 	u32 reg;
 
 	if (!bcmgenet_has_ext(priv))
-		return;
+		return ret;
 
 	reg = bcmgenet_ext_readl(priv, EXT_EXT_PWR_MGMT);
 
@@ -1727,11 +1728,13 @@ static void bcmgenet_power_up(struct bcmgenet_priv *priv,
 		}
 		break;
 	case GENET_POWER_WOL_MAGIC:
-		bcmgenet_wol_power_up_cfg(priv, mode);
-		return;
+		ret = bcmgenet_wol_power_up_cfg(priv, mode);
+		break;
 	default:
 		break;
 	}
+
+	return ret;
 }
 
 static struct enet_cb *bcmgenet_get_txcb(struct bcmgenet_priv *priv,
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 633fa9aa0726..c95601898bd4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -724,8 +724,8 @@ void bcmgenet_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol);
 int bcmgenet_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol);
 int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 				enum bcmgenet_power_mode mode);
-void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
-			       enum bcmgenet_power_mode mode);
+int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
+			      enum bcmgenet_power_mode mode);
 
 void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 			     bool tx_lpi_enabled);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 5246214aebc9..d0f1fa702917 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -227,14 +227,14 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	return 0;
 }
 
-void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
-			       enum bcmgenet_power_mode mode)
+int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
+			      enum bcmgenet_power_mode mode)
 {
 	u32 reg;
 
 	if (mode != GENET_POWER_WOL_MAGIC) {
 		netif_err(priv, wol, priv->dev, "invalid mode: %d\n", mode);
-		return;
+		return -EINVAL;
 	}
 
 	clk_disable_unprepare(priv->clk_wol);
@@ -247,7 +247,7 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
 		reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
 		if (!(reg & MPD_EN))
-			return;	/* already reset so skip the rest */
+			return -EPERM;	/* already reset so skip the rest */
 		reg &= ~(MPD_EN | MPD_PW_EN);
 		bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 	}
@@ -256,7 +256,7 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	if (priv->wolopts & WAKE_FILTER) {
 		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
 		if (!(reg & RBUF_ACPI_EN))
-			return;	/* already reset so skip the rest */
+			return -EPERM;	/* already reset so skip the rest */
 		reg &= ~(RBUF_HFB_EN | RBUF_ACPI_EN);
 		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
 	}
@@ -267,4 +267,6 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	spin_unlock_bh(&priv->reg_lock);
+
+	return 0;
 }
-- 
2.34.1


