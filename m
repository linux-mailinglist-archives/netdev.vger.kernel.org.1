Return-Path: <netdev+bounces-288613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLEUII1YCGqykQMAu9opvQ
	(envelope-from <netdev+bounces-288613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2155B840
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A2F300D32D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2A3D6480;
	Sat, 16 May 2026 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFt2K+Fu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E43C7E15
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931851; cv=none; b=sl/46D6L4I28JMBhsPcZTcjqk9sxj/WbMWLWTn+FO0eu6ufE15gK6n1BbIdC/Pl2KSftGmwuQ10OQ0Mlwnq0YidAznZVfMU0XDssx7CnTFf9aD+CSm7oAU32kD/FH0ELDstaWvSEmxmuhHGtJGJ2c+ESILN54bu+soc/16nqAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931851; c=relaxed/simple;
	bh=++BkVs6zd7CoLhOO3C+xH2eBltu/4VfD8o0OiHfcmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iMj1TLis/2IJOAJPN/IYC9ewThD2xfswYFB5iJy0cQ/mVBQNk6pO72wI0ko4znUcG8EB3XaeZyChitLDU+BwzfYYhwE3A/gHthS4/QkhDgaAXq3w8+kZLlcLAhG+M58a6cBYHjay0+NpJUvi3XxBPzoHFq+mDdOiY8gx58evjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFt2K+Fu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so332746f8f.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778931848; x=1779536648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xQSGGdfR3qK5EGYwiYLtow8+RTdavMFkAuIx9DxFHaE=;
        b=XFt2K+Fu+LU1Zz00STqqf5c+lMK3y/hadYTeP5wXUdkRqbTqtwnTFEpK3yYNeJcKnE
         5//3CJoREM9mJ95VSeLeEVrQYgs1TbCWAtaGgoG/J+7/pf0CtzO80d5UdLFBy0brNo+Z
         Y8lSAt5hoJ3Q8JbOeBCID7mJIHVJKlDmMHElcrpYI5JOpeyMfuyASS2/y901Dz2P7WsK
         JiqM7UuNLFnoNXT2UcKolP7yyIYJ9LYMGWkawaoGL/t6crefNkYQhxbHUNgQkHxYqcKi
         JzgEfasnd6zUsfIcvm/apusNUAdkUDM9SbUnfTbxGAJJTDFVDZjXGHy4UGZroGGSGIyc
         ntlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778931848; x=1779536648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQSGGdfR3qK5EGYwiYLtow8+RTdavMFkAuIx9DxFHaE=;
        b=ga3qF2F9aGrDUZQEMd0cdpzppcB+YSSj/a2LgO/80fypQC0GxPzTk+Ytfw8zoGnFb4
         nIxjDVdDvA9a94p5TtJR40u9ikqGo6o411YPJu5eZ9Xx2Kr2C5XQn5Mrgu/N83YI4AbV
         vtXXfEeZKnTNksWHHIcio09HjZ0xafkWoYNqapQWiMcChox5XUTTafcNHG/axSiaHTpR
         Q/IlqM7UWmhbnVEPw6tnNMwQIWDfHeuykqLp897OB9V0QfD4UibsLnCGu6mR7SC5wlK2
         4XbdfIwxjFefmiNZEW+u0xhGY5dxr6wYMYLfoEEAkwlV29BzVlYLKwzEtegYK3+7Accx
         sEDw==
X-Forwarded-Encrypted: i=1; AFNElJ+SaMLQ3k5BC73a/FJKP2akxJpBf8UMVV4bSlE4KYKPfvlQY3ZhZ9065pd5zembJ2eWQR3uvhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWWE5NgVxA4eqcZsi91l44JMaV7E/OqCtXSNjyjedFvW8yu59
	xWStxPVvyfmzje3BvlP5PGAYyMyFe0b1LSjcBJpED8S3cQe1JDa++Kw=
X-Gm-Gg: Acq92OHVVrnqOciMJfQ3be+dQSJkaPQjFw9aRqU9dSNFq0scxm64Pffzzu94QnMhxVX
	KeN4q7VaJ/mDQgjGmVFqKwRtBOHhEktdzXsY1xvgf6FLHG/uNVPsjw6h8l2RKCVmE+X5GGd9spj
	LCLyERDsHHPQKLxEd6JUo3toHqCJZyQYOomQkHXBa/7r3Zl7Q15pJtIp0kRV343gLDqN3ToMH5l
	/dpMAB7q3ieQi1yBStiNUzsF1t0Qgs02F5HqgDgXnOL8ci3A3h3p/OV3ThD1DTQwBBYE8nHuKot
	THiyEAA/FKwoqTes5tHDSjYiHSNkVLhkk0cjEXGwz8yc+rBmc4FWjYzPtN6vFly//q+HWJASUrV
	sCmI970wLh/poKiTDMeyzI4LAA06gsGzjyr5iXX+on8Jnt4SRywJ6+OatUJOum/UcTlse/mLi9K
	5n1YQywdQ+0elDfwuyuky7S5ZM/p7P/5GTkj2BU8Y7iCiIgMQtEnQzHQIx2VwNyWJ3YfFwu4LKN
	HwVyEDhNhgO6iMEDz3twXe9AoEO5VSW/ZODwyWZsEMPdtZJ70utfg==
X-Received: by 2002:a5d:64c6:0:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45e5c5dadbamr10534747f8f.38.1778931847777;
        Sat, 16 May 2026 04:44:07 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:5454:f357:ba89:4e22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm22836469f8f.18.2026.05.16.04.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 04:44:06 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net] net: phy: skip EEE advertisement write when autoneg is disabled
Date: Sat, 16 May 2026 14:43:34 +0300
Message-ID: <20260516114334.812828-1-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9B2155B840
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nerijusbendziunas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

genphy_c45_an_config_eee_aneg() writes the EEE advertisement to the
auto-negotiation device's MMD register space (MDIO_MMD_AN, register
MDIO_AN_EEE_ADV).  These registers are only consumed by the link
partner during auto-negotiation, so writing them while autoneg is
disabled is semantically a no-op.

On at least the Broadcom BCM54213PE PHY, however, the indirect MMD
write triggered from this path while the link is currently forced
(autoneg off) disturbs the receive datapath: the kernel still
reports the link as UP at the configured speed/duplex, but no
frames are received until the link is renegotiated.  Concretely,
running

    ethtool -s eth0 speed 100 duplex full autoneg off
    ethtool --set-eee eth0 eee off

leaves eth0 with TX working and RX completely silent on a
Raspberry Pi 4 / CM4 board (bcmgenet + BCM54213PE in rgmii-rxid).
Switching back to autoneg recovers the link.

Prior to commit f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled"),
the disable path was effectively a no-op because the helper read
the stale eee_cfg.eee_enabled, so the underlying PHY behavior never
surfaced.

Bisected on rpi-6.12.y between commits 83943264 (good) and
effcbc88 (bad) to f26a29a038ee.

Fixes: f26a29a038ee ("net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 drivers/net/phy/phy-c45.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d48aa7231b37..65de6a5fa204 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -940,6 +940,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
  */
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 {
+	/* MMD AN advertisements are only consumed during autoneg. */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
 	if (!phydev->eee_cfg.eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 
-- 
2.54.0


