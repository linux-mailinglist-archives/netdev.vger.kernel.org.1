Return-Path: <netdev+bounces-172558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081AA5569F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AAA3AB724
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B9927604A;
	Thu,  6 Mar 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE2spfik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018622755E9;
	Thu,  6 Mar 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289248; cv=none; b=Qf3fhTkcnbKsGdx9zoTecfjNGZqerWMgOz2R/GyxNETwyQbNY2+bdfsH7Ovp8O2db1/GJ9r4dh/30VhY6Gd+eUcMJANp++l16QKIPCkKQxQdHxrQFAtN99IGUQAdxqjTJZDSXr1ONBM7t/TKVHe+xaU/jNAALaFL+ScM2lN+rJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289248; c=relaxed/simple;
	bh=QL+jsvVNg7TrIfCIkfsOe+HXz5qFw1jD/1K+MsFFFFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RThALTWuVsii8FQoDSiq8mLwWSMYGxFtH0qpJ0MUEKw6+lPCo5Mt9fW0uasqCns6CfpZmK2QpJpP5M9L+QFKpRuNv2GEl5C6+6mPXSk+EZHjlT4uoB9i+QpK9yiUsR4qrKsTWxaRz5kxTznTGRgCdciZtc7dbznBp+3AvPYZ1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE2spfik; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7273b0d4409so230080a34.1;
        Thu, 06 Mar 2025 11:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289246; x=1741894046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9qAzhw3nxTctIXVbKox2jFYZtYHfe7xsGKs2tJQX2s=;
        b=IE2spfikcHbBQdNSH26/+Kg++gjV4YfzPxLToIz3+jwC4E2e8CfqvJuZOlNOAojaCS
         1EsAousJ4hb4ic4ljNxsnGL2CQadiuP7T8I6aYc0onSXzn0aQ8IL3Kd/ybIY++0c7A0S
         F2SiUI1ASgr3sAXM6Sbh7RDpNyBM0LZxh0ax78IhZDMqcBQvPSbCbGEXMSBvza8EZeXg
         9tYZ01PheUc5L9qzj/exGiwpHXB4twBnzkH4oSC2DnSFUFpkp6iJK90KGCGjNAIJszrA
         fnf3hrS5FW6lhoKgH4Mdi4zWM/XVuACMXbjYrpceBfWFYlY8AiBOoIv0P0wDNwrrWof6
         fAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289246; x=1741894046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9qAzhw3nxTctIXVbKox2jFYZtYHfe7xsGKs2tJQX2s=;
        b=F8MipETtI7QAHYXk50Sipi2afkYLbXr/U905Ev4gD+Go+3b5Q/fnOvjxMK1Hd+W1yE
         ydU4nKtqOObxe/JTNU+khLq5CogL87MnYeNr1Z3EyZhwjHly2inaEuJjoK4dG1Rzhn0U
         hTgsCNl738b6G6oFvPS7gEPooHVod3JPzjJYVzwu6uPlR1BMStDadjOghtVAjG1P4CKI
         r/PEqMUOOexVQRu3exQmnu0TA2arC9ezNsQCsuzdf0SKx2phE7nhCvQhaE+Rb5ikDpcd
         UQA9LfeyQfyA1D9IzM37oD9h8CYqB6F5CHKMX7hibbvoegSUx0lx3EsTmjwgBSd/wJMg
         Sc5w==
X-Forwarded-Encrypted: i=1; AJvYcCURn0zbRwAZpNSAgE2ubIvxhLuXc3vE3hrMrJWh0LFG8J6SOj6EZdysNmXMfpS9ZZiZg/yEFHcsFPeNlAA=@vger.kernel.org, AJvYcCWvteTSpEm9i3S5mAW5/2AVT1VkZQOZqBoxLG8Z6b/VLGm/ZzyGKcBrs8AXS24dz+YKK6f3FqvC@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8tjUC8uYpR0SUp2uNytwr3x84GUS38BCN8orX4mROFJd0ZY+
	pZIo5LUhg6LZ6vpr2Hy8RyYMlLxRQGK2Lxl1w4NcyjvQfsiZE2bJ
X-Gm-Gg: ASbGnctiYBkjK0v/EmqwAs7BUNvyYCarg/JV4Y7ii7x5aRUE4l9INny9O/5lOxBDgtr
	UV6XgvAVHodcE7pYBkeRDbCnD+Q8pIA9eY5f3VVaHCwDvUH5M0JqHbbkwsirbpZFKREdE6pBbfz
	RPjA/Zf2LYK5UH4CZJKf90p868oozcq66cMlZPKsQco3w23MpMFgF8UNpKqnthNe09oX0dz+rz+
	PrBarNoSe32P+RzTudD/7YlNBT8opAWjoMik7TF3LVXvZOA+PEjgkZ7gOxMKHLoJuiRn6Z9YgZz
	EUG8ktvA+xMMnrR/q20niZ/JxCc/AibT9QD1vdrVmB/rOY6ddoEV9filyjpEIdCrVcigyBdTd1C
	YTM7bbIf0/mIy
X-Google-Smtp-Source: AGHT+IGSkfkwRtWCvRSiTb+A025eXnqhWYGHuVWDmexgQXrpWsIA9iIQA5BkdwyOSk9FwrgxfudzSg==
X-Received: by 2002:a05:6830:2706:b0:72a:28f6:7ec8 with SMTP id 46e09a7af769-72a37b74970mr315902a34.8.1741289245815;
        Thu, 06 Mar 2025 11:27:25 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:24 -0800 (PST)
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
Subject: [PATCH net-next 03/14] net: bcmgenet: move feature flags to bcmgenet_priv
Date: Thu,  6 Mar 2025 11:26:31 -0800
Message-Id: <20250306192643.2383632-4-opendmb@gmail.com>
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

The feature flags are moved and consolidated to the primary
private driver structure and are now initialized from the
platform device data rather than the hardware parameters to
allow finer control over which platforms use which features.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 ++++++++++++-------
 .../net/ethernet/broadcom/genet/bcmgenet.h    | 14 ++++++------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 769d920a0fc0..48830942afa8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3757,7 +3757,6 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v2 = {
 	.rdma_offset = 0x3000,
 	.tdma_offset = 0x4000,
 	.words_per_bd = 2,
-	.flags = GENET_HAS_EXT,
 };
 
 static const struct bcmgenet_hw_params bcmgenet_hw_params_v3 = {
@@ -3776,8 +3775,6 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v3 = {
 	.rdma_offset = 0x10000,
 	.tdma_offset = 0x11000,
 	.words_per_bd = 2,
-	.flags = GENET_HAS_EXT | GENET_HAS_MDIO_INTR |
-		 GENET_HAS_MOCA_LINK_DET,
 };
 
 static const struct bcmgenet_hw_params bcmgenet_hw_params_v4 = {
@@ -3796,8 +3793,6 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v4 = {
 	.rdma_offset = 0x2000,
 	.tdma_offset = 0x4000,
 	.words_per_bd = 3,
-	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
-		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
 };
 
 /* Infer hardware parameters from the detected GENET version */
@@ -3906,7 +3901,7 @@ static void bcmgenet_set_hw_params(struct bcmgenet_priv *priv)
 struct bcmgenet_plat_data {
 	enum bcmgenet_version version;
 	u32 dma_max_burst_length;
-	bool ephy_16nm;
+	u32 flags;
 };
 
 static const struct bcmgenet_plat_data v1_plat_data = {
@@ -3917,32 +3912,43 @@ static const struct bcmgenet_plat_data v1_plat_data = {
 static const struct bcmgenet_plat_data v2_plat_data = {
 	.version = GENET_V2,
 	.dma_max_burst_length = DMA_MAX_BURST_LENGTH,
+	.flags = GENET_HAS_EXT,
 };
 
 static const struct bcmgenet_plat_data v3_plat_data = {
 	.version = GENET_V3,
 	.dma_max_burst_length = DMA_MAX_BURST_LENGTH,
+	.flags = GENET_HAS_EXT | GENET_HAS_MDIO_INTR |
+		 GENET_HAS_MOCA_LINK_DET,
 };
 
 static const struct bcmgenet_plat_data v4_plat_data = {
 	.version = GENET_V4,
 	.dma_max_burst_length = DMA_MAX_BURST_LENGTH,
+	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
+		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
 };
 
 static const struct bcmgenet_plat_data v5_plat_data = {
 	.version = GENET_V5,
 	.dma_max_burst_length = DMA_MAX_BURST_LENGTH,
+	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
+		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
 };
 
 static const struct bcmgenet_plat_data bcm2711_plat_data = {
 	.version = GENET_V5,
 	.dma_max_burst_length = 0x08,
+	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
+		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET,
 };
 
 static const struct bcmgenet_plat_data bcm7712_plat_data = {
 	.version = GENET_V5,
 	.dma_max_burst_length = DMA_MAX_BURST_LENGTH,
-	.ephy_16nm = true,
+	.flags = GENET_HAS_40BITS | GENET_HAS_EXT |
+		 GENET_HAS_MDIO_INTR | GENET_HAS_MOCA_LINK_DET |
+		 GENET_HAS_EPHY_16NM,
 };
 
 static const struct of_device_id bcmgenet_match[] = {
@@ -4040,7 +4046,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (pdata) {
 		priv->version = pdata->version;
 		priv->dma_max_burst_length = pdata->dma_max_burst_length;
-		priv->ephy_16nm = pdata->ephy_16nm;
+		priv->flags = pdata->flags;
 	} else {
 		priv->version = pd->genet_version;
 		priv->dma_max_burst_length = DMA_MAX_BURST_LENGTH;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 9b73ae55c0d6..a7f121503ffb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -476,6 +476,7 @@ enum bcmgenet_version {
 #define GENET_HAS_EXT		(1 << 1)
 #define GENET_HAS_MDIO_INTR	(1 << 2)
 #define GENET_HAS_MOCA_LINK_DET	(1 << 3)
+#define GENET_HAS_EPHY_16NM	(1 << 4)
 
 /* BCMGENET hardware parameters, keep this structure nicely aligned
  * since it is going to be used in hot paths
@@ -496,7 +497,6 @@ struct bcmgenet_hw_params {
 	u32		rdma_offset;
 	u32		tdma_offset;
 	u32		words_per_bd;
-	u32		flags;
 };
 
 struct bcmgenet_skb_cb {
@@ -597,6 +597,7 @@ struct bcmgenet_priv {
 
 	/* other misc variables */
 	const struct bcmgenet_hw_params *hw_params;
+	u32 flags;
 	unsigned autoneg_pause:1;
 	unsigned tx_pause:1;
 	unsigned rx_pause:1;
@@ -615,7 +616,6 @@ struct bcmgenet_priv {
 	phy_interface_t phy_interface;
 	int phy_addr;
 	int ext_phy;
-	bool ephy_16nm;
 
 	/* Interrupt variables */
 	struct work_struct bcmgenet_irq_work;
@@ -652,27 +652,27 @@ struct bcmgenet_priv {
 
 static inline bool bcmgenet_has_40bits(struct bcmgenet_priv *priv)
 {
-	return !!(priv->hw_params->flags & GENET_HAS_40BITS);
+	return !!(priv->flags & GENET_HAS_40BITS);
 }
 
 static inline bool bcmgenet_has_ext(struct bcmgenet_priv *priv)
 {
-	return !!(priv->hw_params->flags & GENET_HAS_EXT);
+	return !!(priv->flags & GENET_HAS_EXT);
 }
 
 static inline bool bcmgenet_has_mdio_intr(struct bcmgenet_priv *priv)
 {
-	return !!(priv->hw_params->flags & GENET_HAS_MDIO_INTR);
+	return !!(priv->flags & GENET_HAS_MDIO_INTR);
 }
 
 static inline bool bcmgenet_has_moca_link_det(struct bcmgenet_priv *priv)
 {
-	return !!(priv->hw_params->flags & GENET_HAS_MOCA_LINK_DET);
+	return !!(priv->flags & GENET_HAS_MOCA_LINK_DET);
 }
 
 static inline bool bcmgenet_has_ephy_16nm(struct bcmgenet_priv *priv)
 {
-	return priv->ephy_16nm;
+	return !!(priv->flags & GENET_HAS_EPHY_16NM);
 }
 
 #define GENET_IO_MACRO(name, offset)					\
-- 
2.34.1


