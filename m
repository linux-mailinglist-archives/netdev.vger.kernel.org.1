Return-Path: <netdev+bounces-306928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9CfJ2c6U2pNZAMAu9opvQ
	(envelope-from <netdev+bounces-306928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 08:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C274401D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 08:55:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="PM/BIb1w";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306928-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306928-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74FBC3004633
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9060235DA41;
	Sun, 12 Jul 2026 06:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81252DA775
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 06:55:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839329; cv=none; b=m92/TXVPKgyDhff5JOeXvNj2srYN7sS7pJeh5Ixixib9diDCLdPQsabprvPthrIjISHnQzt5qeWFoLuvNjrGxygUqY7EawUiNp0c7N3hbqx2ehPhjOxDpfTTynQtnWQuTS8S0XSQjMGvahwrqsABnjNdXcYAQqTFudlBQTG1VNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839329; c=relaxed/simple;
	bh=M142CXOOcTwByypcN5mMhsYsB6RWWGbV6iR96HMm62w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYMzsX4i1EmraKKuJtc64WJ6xazqwwn6qiqgENwTwEjBHh2VKU5qgAmmgYKvKO04+uE78swSlTJuX/J4u8WXqa+JqkzL9HyA0nhGxsovrVNj6eqRMNYx4qUwbii/SoFqeLyDsJCCjQn1nJIkq84mO5eEDKGEZ3C+i7hRt4i3/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM/BIb1w; arc=none smtp.client-ip=209.85.208.178
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39669bcaadfso20102801fa.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783839326; x=1784444126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnvNI/i6h4Bl3pvFIx+mkYbJPcSuAoOqqDQCNmGvUN8=;
        b=PM/BIb1wYZIZbmbsz7cBTgg+uri2MQwwKCZ85uunWlJqF55odbwgZJnDy+iXavABsF
         jyY6SuxB3bVbmukfN0JJ3HIqV5GFOFsWyyRrTrzmMszT8SIhDwat46dneBMauVLM0HtI
         jKJD6adCgb+U8aXNFBBL1lmu8xzedaJdD2YvUWx65LGi1PKSyZpCqPISYy2XYGklQEZS
         QhOanvFdUSkPcic3KB55Fk6Q0GICIFa0ypM9YQY9yQfbigrXFOk7wmyBnnjSkg/+1O/K
         V7qunWseiuQ3wVtsRqbPvD5HeZ9F17NgGYYuU52FR8mKkXmdQm+sCVVpRG1szkpOkGLJ
         r55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783839326; x=1784444126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hnvNI/i6h4Bl3pvFIx+mkYbJPcSuAoOqqDQCNmGvUN8=;
        b=beh55neU/UWqLOD1/TS7ycLYOeXE3j9Sfq9Nf1RMByVjqQfgltPzNkIYD6KJtn0Pin
         FEjXVBWnmWUPhsQqWQLhrRmYKHUrDJ+jkEtS/wbks5EVlTkz4fVhH6uQaGCZrO1Hqxk5
         0Adq95QG6t7d6xjej7Lvph1enVJFD2yIYpNSbnzBXPEz1hMINEq2hVyzw3RHrcJvTMhN
         3nTBGvwewVKAAdYLxn1Q9Rluo+pAxAXz4iYHNiX+hXnu+5x2FH5VgDuRzRvNEBafbpbq
         rM7+5pnvGADmXshf2l6VRw6Xy1JJXHstDxzwYvDWHDlyftP1fmraB2zds2p4Q2MDb3F3
         6wUA==
X-Gm-Message-State: AOJu0YzprlTRVxnrZp99UMxB8FxOIvAFMo2ZCYrehU6e24hXMPIAxGof
	03S2ggKIp35eMAC3o8IcRiGJXbRMPXs4PW7PE0uobNnTndFOuijAam3BcxKZPak9C02V5Q==
X-Gm-Gg: AfdE7cmc8I1qAinNjlJAEt+g53RNRULNKKWzWrsLigSEJFsn5FC6AY+FvDR36fKh5zM
	NVnJYgBVqAAU4qKnpuYhrev2izs/+ktVBPGHTqSxJ0G9irup2g71zDIPTBzIzv+DTOq+n/6cIBG
	T4Iyly1UOO9GDRXqC8ZiKVHAiJFKelw53JpPJexsxqH0XQ1r8Penzey9mazgg4CufQXrm2QSEtf
	mKUe/ZKJEsZK66zKF9CmEGMn0T1qyt1U/ct7dlMzxaLMt7VFkYv0M2PLKeE1Zgr1g3aw5ICcuDh
	KJThUwNeK4au+hez6ezjtdUcEr0pzBocFso+0B1r0o2sfoTZbRA9tAUbbL4vKowqrPuzIjXAGxK
	n/9052Ned/m+44Nv4xK0e3lyZTpfWJs2IElqfujNPMec/yxCywu5YLLoWSs1uZXrfyBdsQ81qzg
	MfetPWKHN374TsfkJhB5ZKdMtUamouu2FPCXdvKEhuacHbmQyXUwkRjC580XPxYhfc7y4DmP1oB
	40ilA==
X-Received: by 2002:a05:651c:19ab:b0:39c:7ae9:daa5 with SMTP id 38308e7fff4ca-39cae8d45acmr9951371fa.32.1783839325546;
        Sat, 11 Jul 2026 23:55:25 -0700 (PDT)
Received: from jeeves.tailc718e.ts.net (91-157-100-11.elisa-laajakaista.fi. [91.157.100.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84ba3337sm19904631fa.36.2026.07.11.23.55.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 23:55:24 -0700 (PDT)
From: vadik likholetov <vadikas@gmail.com>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	thierry.reding@kernel.org,
	jonathanh@nvidia.com,
	vbhadram@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: enable the MAC on link up for all supported speeds
Date: Sun, 12 Jul 2026 09:55:22 +0300
Message-ID: <20260712065522.30241-1-vadikas@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260710120908.3731591-1-vadikas@gmail.com>
References: <20260710120908.3731591-1-vadikas@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:vbhadram@nvidia.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadikas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadikas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 856C274401D

stmmac_mac_link_down() clears the MAC's transmit and receive enable bits.
stmmac_mac_link_up() is expected to set them again through
stmmac_mac_set(..., true), but it first switches on the negotiated speed
and returns early for a speed the switch does not list. The MAC is then
left gated off.

The speed selection is split into three switches, keyed on the interface.
The generic branch -- taken for everything that is neither USXGMII nor
XLGMII, so including PHY_INTERFACE_MODE_10GBASER -- lists only SPEED_2500,
SPEED_1000, SPEED_100 and SPEED_10.

MGBE on Tegra234 runs 10GBASE-R into an Aquantia AQR113C. That PHY does
rate matching, so phylink_link_up() replaces the media speed with the
MAC-side interface speed before calling into the MAC:

	case RATE_MATCH_PAUSE:
		speed = phylink_interface_max_speed(link_state.interface);
		duplex = DUPLEX_FULL;

The driver is therefore called as

	stmmac_mac_link_up(interface=10GBASER, speed=10000, duplex=1)

which falls through to "default: return;". The interface stops passing
traffic after the first link flap.

The failure is easy to misread. The link still comes up, because the PHY
is polled over MDIO and needs no MAC, so the interface reports carrier 1
at the media speed. The DMA is untouched, so its start bits stay set and
descriptors are still consumed. Only the MAC itself is gated off: the
receiver counts nothing (mmc_rx_framecount_gb stops advancing, RE is 0)
and nothing reaches the wire (TE is 0). The interface survives boot only
because stmmac_hw_setup(), called from ndo_open, enables the MAC
unconditionally -- so the problem appears only once the cable has been
unplugged and plugged back in, and "ip link set dev <ethX> down && ip
link set dev <ethX> up" appears to fix it.

The interface is not what the speed bits depend on: with the single
exception of 2.5G, which is selected through the XGMII block on USXGMII
and through the regular speed bits otherwise, each speed maps to one
field of struct mac_link. The per-interface switches are speed
validation, and phylink already validates the speed against
priv->hw->link.caps. So collapse the three switches into one keyed on the
speed alone, keeping the interface test only for the 2.5G case. This
covers 10G on 10GBASE-R, and equally 5G, and 1G/100/10 on USXGMII, all of
which hit "default: return;" today.

A core that does not support a speed leaves the corresponding mac_link
field at 0, and phylink will not offer it that speed in the first place.
For dwxgmac2 at 10G, link.xgmii.speed10000 is XGMAC_CONFIG_SS_10000,
which is 0 and is the correct speed selection for a 10GBASE-R MAC: ctrl
then equals old_ctrl, the register write is skipped, and execution
reaches stmmac_mac_set(..., true).

Log an error in the default case, since a speed with no entry here leaves
the MAC disabled and the symptom does not point at the cause.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: vadik likholetov <vadikas@gmail.com>
---
v2:
 - Collapse the three per-interface switches into a single switch on the
   speed, rather than adding SPEED_10000 to the generic branch, which
   left SPEED_5000 and the USXGMII sub-1G speeds broken (Maxime).
 - netdev_err() in the default case (Andrew).

Fixes tag: the missing speeds predate the commit cited above. I picked
d8ca113724e7 because MGBE is the first in-tree user to reach it -- it
needs a 10GBASE-R interface driven by a rate-matching PHY, so that
phylink hands the MAC a 10G speed. Happy to re-target it.

Verified on an AGX Orin devkit (Tegra234 MGBE0 + AQR113C), before and
after, on the same board and cable. MAC registers read with `ethtool -d`,
after a physical unplug and replug:

  stock		MAC_TX_CONFIG 0x00010000 (TE=0)
		MAC_RX_CONFIG 0x3ff022c0 (RE=0)
		rx_packets frozen, DHCP lease lost

  patched	MAC_TX_CONFIG 0x00010001 (TE=1)
		MAC_RX_CONFIG 0x3ff022c1 (RE=1)
		rx_packets keeps climbing, DHCP lease retained

Only the 10GBASE-R path is covered by hardware here; the other speeds are
by inspection. Testing was done with MGBE0 handed to a VM via
vfio-platform, so the driver ran in a guest; the MAC register evidence
above is read from the device itself and the code path is not
virtualisation-specific.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 92 ++++++++-----------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff8..fa9f88e51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1083,63 +1083,45 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
 	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
 
-	if (interface == PHY_INTERFACE_MODE_USXGMII) {
-		switch (speed) {
-		case SPEED_10000:
-			ctrl |= priv->hw->link.xgmii.speed10000;
-			break;
-		case SPEED_5000:
-			ctrl |= priv->hw->link.xgmii.speed5000;
-			break;
-		case SPEED_2500:
+	switch (speed) {
+	case SPEED_100000:
+		ctrl |= priv->hw->link.xlgmii.speed100000;
+		break;
+	case SPEED_50000:
+		ctrl |= priv->hw->link.xlgmii.speed50000;
+		break;
+	case SPEED_40000:
+		ctrl |= priv->hw->link.xlgmii.speed40000;
+		break;
+	case SPEED_25000:
+		ctrl |= priv->hw->link.xlgmii.speed25000;
+		break;
+	case SPEED_10000:
+		ctrl |= priv->hw->link.xgmii.speed10000;
+		break;
+	case SPEED_5000:
+		ctrl |= priv->hw->link.xgmii.speed5000;
+		break;
+	case SPEED_2500:
+		if (interface == PHY_INTERFACE_MODE_USXGMII)
 			ctrl |= priv->hw->link.xgmii.speed2500;
-			break;
-		default:
-			return;
-		}
-	} else if (interface == PHY_INTERFACE_MODE_XLGMII) {
-		switch (speed) {
-		case SPEED_100000:
-			ctrl |= priv->hw->link.xlgmii.speed100000;
-			break;
-		case SPEED_50000:
-			ctrl |= priv->hw->link.xlgmii.speed50000;
-			break;
-		case SPEED_40000:
-			ctrl |= priv->hw->link.xlgmii.speed40000;
-			break;
-		case SPEED_25000:
-			ctrl |= priv->hw->link.xlgmii.speed25000;
-			break;
-		case SPEED_10000:
-			ctrl |= priv->hw->link.xgmii.speed10000;
-			break;
-		case SPEED_2500:
-			ctrl |= priv->hw->link.speed2500;
-			break;
-		case SPEED_1000:
-			ctrl |= priv->hw->link.speed1000;
-			break;
-		default:
-			return;
-		}
-	} else {
-		switch (speed) {
-		case SPEED_2500:
+		else
 			ctrl |= priv->hw->link.speed2500;
-			break;
-		case SPEED_1000:
-			ctrl |= priv->hw->link.speed1000;
-			break;
-		case SPEED_100:
-			ctrl |= priv->hw->link.speed100;
-			break;
-		case SPEED_10:
-			ctrl |= priv->hw->link.speed10;
-			break;
-		default:
-			return;
-		}
+		break;
+	case SPEED_1000:
+		ctrl |= priv->hw->link.speed1000;
+		break;
+	case SPEED_100:
+		ctrl |= priv->hw->link.speed100;
+		break;
+	case SPEED_10:
+		ctrl |= priv->hw->link.speed10;
+		break;
+	default:
+		netdev_err(priv->dev,
+			   "unsupported speed %d on %s, leaving the MAC disabled\n",
+			   speed, phy_modes(interface));
+		return;
 	}
 
 	if (priv->plat->fix_mac_speed)
-- 
2.53.0


