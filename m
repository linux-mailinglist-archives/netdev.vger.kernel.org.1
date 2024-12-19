Return-Path: <netdev+bounces-153349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF19F7B71
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D3170323
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE8225793;
	Thu, 19 Dec 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="xHrU1Zr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EC227584
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611502; cv=none; b=d2T1dg1Nk3uK1Dw5c1ImOu8psnQgKPFeonbatb9STH+V2bRhVTtRKdfh2lxikufgOGm6JXcyNHO8iWsTqiyMbLM44LPadZ2c3+yw1XmLwUehk7M2Kl3ne3K6zOoNbTIANRvwORH4z+BHq3bepaHutUnEriK+cHReaCUvbhRLgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611502; c=relaxed/simple;
	bh=3OTZVHQ8WdzP+m1udJOsV+AyHZGt7lEDWtD7yytevYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaXIfElDXE/IxhtuzUBSqUYbNRQ3nFL4g/8pTcHAWYwt1zwT+XEDCKaGgsA6dtBWc6sDF9Au5DVbZF6HSQDe4+f6fY+c57cbMijvTUuwoXEOrWF4n6NJHpg0PyhpaYl5s7BwzlmH6wcDqgBVTRewTbwtdAEDWOnUIBrcjYyKkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=xHrU1Zr3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003e203acaso8142301fa.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734611498; x=1735216298; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndAkAKcgXaWtrAM06eZ4QPkT+4ZcOm+byTs+MOrt1bg=;
        b=xHrU1Zr3h7pZ6xDO6bQJxPhkYiL3oka9omv8d9R++jiLO6c/olf4ETtYh9R7HqVhIF
         n4AcBWK4pTB7/Um9XYSS4EKQwTOfUVF+xQGvnBWDl+5pexhYqF6mRGgpnW8/4uvjdd6B
         2X2KUqQCVy0R76ME5Dv3sfoF2EgguE1N/EgogIYFWMSluEyhWD7tOEwiiQlwWmox3lwi
         AI0BL3NRmMXYbxRgB4wGtNh9ywo2aKdXwxZegAp3gU6PRrLx2FJoRYj+47SXOzyldYxZ
         z5lwmAEsKIN1Syk3ODrNHthdTLLBf2rvLUcEFTjgGOfysfG1WWe1Riou4NxMcKO8O6NO
         KFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611498; x=1735216298;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndAkAKcgXaWtrAM06eZ4QPkT+4ZcOm+byTs+MOrt1bg=;
        b=orKo8MQ+X/sp46v6u0wuMgoz6JP+JSMSCPZ8LV50eZsvPsxx6/Mjax+qGoQJ0j8aeB
         riWsLBVjHCFvO/oT3pMjQOW5yiL8jE3Pk/G//MezZmdBXXejCAyCB3tDNA1MZoYzuUdE
         aR2hkkzA233nzxuX7wmUwPE4R1dj62gEqx0yOvtNSexO7e9/D9hROFD5rZ7fUHdWISsu
         QTl2cePfxPpJjNWoSWrZy4he9pgV+445MM/UXWYjEneyvZYGDC0oFXd+TwLoJt13YyNO
         Rk+MBtYceE+tKe1GGaGeVKJp8gHrVXOxQJDOUNaxjAgc301IU2gBRgYTp75GLu3dcXEI
         HBTA==
X-Forwarded-Encrypted: i=1; AJvYcCW5oGs76U55KIFRFhUoJgAxygmfB8K8lYUsw2ueOjjtVtJdyeExvbP9UA3NNRypye6wmZimB30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxai5x4P6ruq6ocxswnbSUh/4RY7Apj9jR3SBCMLBL9im74uZJI
	u60CdW5RSGQZ78Z9CEFN9CNGAu9UCHWkoLU361fGOME9Tq96SCIW0++jTjyHERo=
X-Gm-Gg: ASbGncujMKBzLTcE2v2fFweJMEPL0hVOcPJc6dWSBtEPLJGuEayvphJFykxcTMYDJoF
	GWee7w6tts+sSFxuzpLgMyNzVjHw9sx0PWvCqvX8I6GuQ2lANV0ZKErlO+dMl3x0dXaDivofDwu
	CkIGVdOOjXhItwruJpds3xeyWIiZyT8Gz1xZsYOWAUflMFSHVmEx3ywoLpDXGnf9S2MGqWLS6io
	kl8bJ+bW9avSOjyv01vBNMXrXbHKxgX3kmObmj5upG5H7QD+2Qh19+qXuGXFIcZY8d+7pAr0c7i
	5yprfllUPKNzxyoSQH6a47Ki
X-Google-Smtp-Source: AGHT+IH9CDgeIwWecCs7Z8aHxXIAUxVqDzxG/7doZ9bk/jmXw5dhJKqXpyfwLv2Q8Q+3tYP3Z2w9Bw==
X-Received: by 2002:a05:6512:2214:b0:540:3561:666f with SMTP id 2adb3069b0e04-541e67474d1mr2460876e87.20.1734611497663;
        Thu, 19 Dec 2024 04:31:37 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223b28722sm145975e87.243.2024.12.19.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:31:35 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz,
	pabeni@redhat.com
Subject: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on in-band managed MACs
Date: Thu, 19 Dec 2024 13:30:42 +0100
Message-ID: <20241219123106.730032-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219123106.730032-1-tobias@waldekranz.com>
References: <20241219123106.730032-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

NOTE: This issue was addressed in the referenced commit, but a
conservative approach was chosen, where only 6095, 6097 and 6185 got
the fix.

Before the referenced commit, in the following setup, when the PHY
detected loss of link on the MDI, mv88e6xxx would force the MAC
down. If the MDI-side link was then re-established later on, there was
no longer any MII link over which the PHY could communicate that
information back to the MAC.

        .-SGMII/USXGMII
        |
.-----. v .-----.   .--------------.
| MAC +---+ PHY +---+ MDI (Cu/SFP) |
'-----'   '-----'   '--------------'

Since this a generic problem on all MACs connected to a SERDES - which
is the only time when in-band-status is used - move all chips to a
common mv88e6xxx_port_sync_link() implementation which avoids forcing
links on _all_ in-band managed ports.

Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 35 +++-----------------------------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 ----
 drivers/net/dsa/mv88e6xxx/port.c | 17 ----------------
 drivers/net/dsa/mv88e6xxx/port.h |  1 -
 4 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7683ea334a7..707dfe5c1ed8 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1007,8 +1007,8 @@ static void mv88e6xxx_mac_link_down(struct phylink_config *config,
 	 * updated by the switch or if we are using fixed-link mode.
 	 */
 	if ((!mv88e6xxx_port_ppu_updates(chip, port) ||
-	     mode == MLO_AN_FIXED) && ops->port_sync_link)
-		err = ops->port_sync_link(chip, port, mode, false);
+	     mode == MLO_AN_FIXED))
+		err = mv88e6xxx_port_sync_link(chip, port, mode, false);
 
 	if (!err && ops->port_set_speed_duplex)
 		err = ops->port_set_speed_duplex(chip, port, SPEED_UNFORCED,
@@ -1048,8 +1048,7 @@ static void mv88e6xxx_mac_link_up(struct phylink_config *config,
 				goto error;
 		}
 
-		if (ops->port_sync_link)
-			err = ops->port_sync_link(chip, port, mode, true);
+		err = mv88e6xxx_port_sync_link(chip, port, mode, true);
 	}
 error:
 	mv88e6xxx_reg_unlock(chip);
@@ -4213,7 +4212,6 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4257,7 +4255,6 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6185_port_set_forward_unknown,
@@ -4292,7 +4289,6 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4339,7 +4335,6 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
@@ -4377,7 +4372,6 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4422,7 +4416,6 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
@@ -4483,7 +4476,6 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4529,7 +4521,6 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.phy_read = mv88e6165_phy_read,
 	.phy_write = mv88e6165_phy_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -4568,7 +4559,6 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4616,7 +4606,6 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4671,7 +4660,6 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4719,7 +4707,6 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4773,7 +4760,6 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6185_port_set_forward_unknown,
@@ -4815,7 +4801,6 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -4875,7 +4860,6 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
@@ -4935,7 +4919,6 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -4995,7 +4978,6 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5056,7 +5038,6 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6250_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5100,7 +5081,6 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -5162,7 +5142,6 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5211,7 +5190,6 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5259,7 +5237,6 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
@@ -5322,7 +5299,6 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5368,7 +5344,6 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5418,7 +5393,6 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5481,7 +5455,6 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -5545,7 +5518,6 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
@@ -5608,7 +5580,6 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6393x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6393x_port_max_speed_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9fe8e8a7856b..27d19d55f9e5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -525,10 +525,6 @@ struct mv88e6xxx_ops {
 	 */
 	int (*port_set_link)(struct mv88e6xxx_chip *chip, int port, int link);
 
-	/* Synchronise the port link state with that of the SERDES
-	 */
-	int (*port_sync_link)(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup);
-
 #define PAUSE_ON		1
 #define PAUSE_OFF		0
 
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index dc777ddce1f3..56ed2f57fef8 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -187,23 +187,6 @@ int mv88e6xxx_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int
 	int err = 0;
 	int link;
 
-	if (isup)
-		link = LINK_FORCED_UP;
-	else
-		link = LINK_FORCED_DOWN;
-
-	if (ops->port_set_link)
-		err = ops->port_set_link(chip, port, link);
-
-	return err;
-}
-
-int mv88e6185_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup)
-{
-	const struct mv88e6xxx_ops *ops = chip->info->ops;
-	int err = 0;
-	int link;
-
 	if (mode == MLO_AN_INBAND)
 		link = LINK_UNFORCED;
 	else if (isup)
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index c1d2f99efb1c..26452e0a8448 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -484,7 +484,6 @@ int mv88e6390_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
 int mv88e6xxx_port_set_link(struct mv88e6xxx_chip *chip, int port, int link);
 
 int mv88e6xxx_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup);
-int mv88e6185_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup);
 
 int mv88e6185_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				    int speed, int duplex);
-- 
2.43.0


