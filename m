Return-Path: <netdev+bounces-149724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB139E6F0E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17357168AE0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999A207641;
	Fri,  6 Dec 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="HTvnwFZR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E86207654
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490584; cv=none; b=ZxwZmTBdptWaJmN7ghIwbuaOdEV5coCHIvZ6P+IvUv3ATE4g9gO2qp0MTT7umfel79e7zwrZ9oEQptxF/nxuEB2rUuqxSRkMRwZ6wBN6Y6li9Dvhz5iP0UdQ7iOvbZyikX+U1ITqXO4lPhi7TboQnJolgJ8laptUP56Nd6+SOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490584; c=relaxed/simple;
	bh=hGRahh+MmHr3pi2zSs+l8nFA1RB34OaWlfrzTP+9vTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki7XWbIfJDlwhACLr2HMVs6DLd8lGmNvJzNed8o/fDsIOBpVsVaHR7o/TxHi6UZJ/7FPx0sUO4KYvmFrNo474gd27VQxACZnXUbgCT2w2AyvVEB6q50rxAIqpQrmy/Z6QKBkVWyH9p/k38Syg5W5wxr7WTDHFensmzj3FeZ+y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=HTvnwFZR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so18862161fa.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733490580; x=1734095380; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Gg3jMAkj0630p11Re7U3Vu4L1SZj1y7XR1d9VO0IIE=;
        b=HTvnwFZRA8ecVSTjEgkrCmsuVTy0vFpqrnybGc38HkGoF5oNbxzUraODLgPkJVautq
         IC1lAwhrSEawCi4Ah797ZyUHtnroufLqpzuvpi9XY0RsrVfVsa+RtzP2PXYRXo0NcfW+
         Qqsms52NyFWxlsNj1m2BEVNGxkpUGiYVWKyMLjgWpILb4nJ5hu+nGBjuaeo/wfpDAaj+
         hbpo15Tr0lVka+muUGfrlMaPjTAD1J1XKmCPwOWiHoNrnr/B4i2Jf21YItUahQmYtBD9
         2BgJeeJbN4qpsVKV4XiJtx3tlTeee+s4251bvjSzOT2Kr77P2hb0100S1ViBekKCcHRd
         2Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490580; x=1734095380;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Gg3jMAkj0630p11Re7U3Vu4L1SZj1y7XR1d9VO0IIE=;
        b=bTOJIiDwiSWLxXFx4R9+HsQdf9NAo78eZL91+dyKqNac9dUJG1RaCmz7tciZvIe262
         oF04ccbcvVFCCmZlYtWh8HKQ3k6GC9eCZD4xO3JJZNX8A/qOULuVokCHpOAbtxvKjzwc
         RIxO8r02yqPevPBRG0a3HmM8NfUBlsygW27OXRcDztNP95oBb+YK9N8s9xzSJwZN9dzs
         r8EXpAIbouJDovtizBgbV8aCcYsffvD0z2qbphFgA7hD7riMAg5f5kqsXFGwidzvjsfI
         nGTB6G2ZV9DxTIOLoyjX0KUvtayBh6J7SPkFS4Cec3RxmNP1Uhm+cPw5w5gnz4BBPQFo
         pi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE3/7+uUg/dTvGaM244p3KWgc+AI1WJL+H2/aN4qULt8Uf6t8If+cCDlpBLoD58cRszgptmE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglFyVUt5i7cUDhA3t1UUCie5BZqbtVOCrEu54z+E95RhVWaVe
	116lie0pIzmFUVY6mZxiV18LEZTXZc17HkQm/sLZLqeQGbmp+OaYfMroLRdj5rk=
X-Gm-Gg: ASbGncuuzmdGUmuRhqk8VRu1JdoACf3v4s6dJDR1OR610+x6zQWCfSiwqm1Tzw5mdh3
	FUhK9tNx//VP85+HB6GxzV6A4ydDD/anHMHQX63oQjdPcd/FtVVJGoCmvlJ0KNbhLXgKVdjkF9E
	GSV9tvnLAWcaMAViGqQvsu/1C5yHkCGk8CKJse1/uodnsX/X0mEWk5xMhMKH1JHQismb0laDlW0
	s0NIjoWmm5lelMtEIRNq6mvhW/Kdm+WBl0q2LyhwGZNO43VxyZs1ofUCNgpv428eFQzEVolSVLz
	WWOORiOpHg==
X-Google-Smtp-Source: AGHT+IEFHpPPM1Wx3A6WdEo1T1OpnseTHYVgTATXBJCK48hAGL7QSzQehwcTYFOmDUyqoFBIEY5+hQ==
X-Received: by 2002:a2e:b88c:0:b0:300:3a15:8f2d with SMTP id 38308e7fff4ca-3003a159340mr3885451fa.34.1733490579685;
        Fri, 06 Dec 2024 05:09:39 -0800 (PST)
Received: from wkz-x13.. (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e21704sm4527401fa.90.2024.12.06.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:38 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: [PATCH net 3/4] net: dsa: mv88e6xxx: Never force link on in-band managed MACs
Date: Fri,  6 Dec 2024 14:07:35 +0100
Message-ID: <20241206130824.3784213-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206130824.3784213-1-tobias@waldekranz.com>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
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
index 20cd25fb4b75..13a97e6314ed 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1013,8 +1013,8 @@ static void mv88e6xxx_mac_link_down(struct phylink_config *config,
 	 * updated by the switch or if we are using fixed-link mode.
 	 */
 	if ((!mv88e6xxx_port_ppu_updates(chip, port) ||
-	     mode == MLO_AN_FIXED) && ops->port_sync_link)
-		err = ops->port_sync_link(chip, port, mode, false);
+	     mode == MLO_AN_FIXED))
+		err = mv88e6xxx_port_sync_link(chip, port, mode, false);
 
 	if (!err && ops->port_set_speed_duplex)
 		err = ops->port_set_speed_duplex(chip, port, SPEED_UNFORCED,
@@ -1054,8 +1054,7 @@ static void mv88e6xxx_mac_link_up(struct phylink_config *config,
 				goto error;
 		}
 
-		if (ops->port_sync_link)
-			err = ops->port_sync_link(chip, port, mode, true);
+		err = mv88e6xxx_port_sync_link(chip, port, mode, true);
 	}
 error:
 	mv88e6xxx_reg_unlock(chip);
@@ -4219,7 +4218,6 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4263,7 +4261,6 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6185_port_set_forward_unknown,
@@ -4298,7 +4295,6 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4345,7 +4341,6 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
@@ -4383,7 +4378,6 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
@@ -4428,7 +4422,6 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
@@ -4489,7 +4482,6 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_policy = mv88e6352_port_set_policy,
@@ -4535,7 +4527,6 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.phy_read = mv88e6165_phy_read,
 	.phy_write = mv88e6165_phy_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -4574,7 +4565,6 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4622,7 +4612,6 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4677,7 +4666,6 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4725,7 +4713,6 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -4779,7 +4766,6 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6185_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_set_frame_mode = mv88e6085_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6185_port_set_forward_unknown,
@@ -4821,7 +4807,6 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -4881,7 +4866,6 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
@@ -4941,7 +4925,6 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -5001,7 +4984,6 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5062,7 +5044,6 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6250_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5106,7 +5087,6 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -5168,7 +5148,6 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5217,7 +5196,6 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5265,7 +5243,6 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6341_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
@@ -5328,7 +5305,6 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5374,7 +5350,6 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5424,7 +5399,6 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6352_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6352_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
@@ -5487,7 +5461,6 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
@@ -5551,7 +5524,6 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6390x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
@@ -5614,7 +5586,6 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.phy_read_c45 = mv88e6xxx_g2_smi_phy_read_c45,
 	.phy_write_c45 = mv88e6xxx_g2_smi_phy_write_c45,
 	.port_set_link = mv88e6xxx_port_set_link,
-	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6393x_port_set_speed_duplex,
 	.port_max_speed_mode = mv88e6393x_port_max_speed_mode,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index dfdb0380e664..23a9466aa01d 100644
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


