Return-Path: <netdev+bounces-307052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BH2CFIWYVGoxoAMAu9opvQ
	(envelope-from <netdev+bounces-307052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC57485B2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xnw9RqL7;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307052-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307052-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5769F3001187
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5823905F5;
	Mon, 13 Jul 2026 07:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DB3932CE
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:49:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928959; cv=none; b=bBou+mFCSkty+BQF2WRGtKG2bOXNWqVVnMrTz5niuvcdmo1X500uslojEp94Ii28HziXA2SaucO9XXaKRWG0KY3jxi0WcGKfs7tBnz7yMyWW5AzkuMe9V2gFijslEQasOMlHRkO56IlAH+dBGYcvcQ0j0YsCwaJkwRN+Kj87zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928959; c=relaxed/simple;
	bh=ezsg2AOmrKM5FPpRSvwQBgIf+v7yaFU9LPan/rSwf2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDArwO1LSY+FybSu4LZXujfxmdPtR4p59ufC9f5XYThuEAagH5Err8Wcogf/IyuqM4KjN269x9uWjnq4rGZ4dByr3OZQYshU5OdXjiB17vuj5GFhh9jg20wuVEqCylpTt2+1J/JHR//cAcGx3SzzHV8dc1ONvL8F2Eig87Zw9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xnw9RqL7; arc=none smtp.client-ip=209.85.167.53
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b021916bd3so2032985e87.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783928956; x=1784533756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhBptR0856mA7x4upmTCTlL4N4Ll18gQEKUqog0l9So=;
        b=Xnw9RqL7fI3e1jk6r1SIh8rS1+GAq4BlluarmYFCW/WhyDSwNj8clJYt85vqKlpUc7
         1por4W71IxYTMG5e5rZMD45hzgBWszv3HtxtaWl99eIShL5FjgKo4NObkz88LyCTbNOD
         +4+1sNg93OazuN336Y+Rvlqa0ybfuJmhafMwCMzM+G7LyKBZTbXIeIWNjtK62fMjR4MY
         H1LopoMvhPaTOaAtwT3wwlDlHBgMvWJLfu2Sqxex/1gB2VtUCksT8B3E2lupB7dD8fm1
         qlOawaYRMDlV1rgcW/Xy9Tu0iqmf6kO33NDb3b2B6gwckp45eaAeBUuwxIASrgPfGb5x
         DBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928956; x=1784533756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhBptR0856mA7x4upmTCTlL4N4Ll18gQEKUqog0l9So=;
        b=U/0nIKby6ouEOrUJ1PFC0CG0IWBP/bs8HiFtqqM7ve9LbiabG3fDZ19maem8RVGDJj
         R+RnyTXH6N2tyRf8JH8Y8hor7uS9/eymiTJZVZXFmnp3+1b2icobjCxmIKIYJhz4FRBm
         VxAa/9JDdJZFW1yn7WAVHFjgio369M9bhsBhtfrgQF8dhMBIVUlBQam6MiGnqnujr+3U
         P11n1rzv/Kxuf5s6TFJfl3s1Kzxb/h2ZYxILG46fB36rc1xZdt942iE3xYKdEX2D/8rO
         pCV0nq0qPU6wlSGBDdFG8yHFNYAi5Ad1iABOyQECbWJOOvY5AAQimt+1hgEynMtG6MoZ
         mlUQ==
X-Gm-Message-State: AOJu0YwEQhnARbt+vYR05xiIPNet9SzyprWNvJdom/1HlVUqYhYtqcBD
	xbJkHMvmrirU1UR0HeR1zFUVD6NhLcdRCDO6NkYeCjWEvrerwoylI8X807y5KAzU/29gAQ==
X-Gm-Gg: AfdE7cluf5FVCWM4OJUAIBlbjnOLlYvMllqHL4RP2GE3Koo1om5ztpr+DEP8t7OHncE
	aPIHtny5+x6sRne7VjnIIBjLIPHWUFR95n1s0qVcW4QnhK/ogRVza34CYar48/IYE2EIGWOGRbp
	aR2seIkc2ueOCasKvA+XkL6cQySje9QZdzGkPWas0rCvs/qzoyckSscAlAW4YY2MatmaddkTJ+4
	rKq/fSQw6LCftMIVlDBYB8x5tlOTJhweQ3rbdilqqoUmYWjthlzo9an6nGO3qFauJu6/C3A+gm1
	j964b5js76Q1VZ12f2JYE6nL95Gekj99VmBGySHg5VJKBNfvzFDvlEJk8iEihQxA73ds09oBJXM
	29pGDGoNm/GfObG4+BMAmwYhwj4mdZQPmdFY5uSxzCCClYM1Asy20IYGFyhba0ZYFh1gXhCbqkz
	+uSG89LciyeHjn2jtYj0YxZax7vqtDuLT5MmJy3ZWSSC2H4kASk+UQzAaTpyqZ/QNtJwrwDzuZX
	K00Gg==
X-Received: by 2002:ac2:50a2:0:b0:5ae:d7dd:5815 with SMTP id 2adb3069b0e04-5b02369c7b7mr1069316e87.41.1783928955715;
        Mon, 13 Jul 2026 00:49:15 -0700 (PDT)
Received: from jeeves.tailc718e.ts.net (91-157-100-11.elisa-laajakaista.fi. [91.157.100.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caab9e5sm2645037e87.67.2026.07.13.00.49.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 00:49:13 -0700 (PDT)
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
Subject: [PATCH net v3] net: stmmac: enable the MAC on link up for all supported speeds
Date: Mon, 13 Jul 2026 10:49:11 +0300
Message-ID: <20260713074911.30090-1-vadikas@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:vbhadram@nvidia.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadikas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DBC57485B2

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
v3:
 - Use phy_speed_to_str() rather than %d for the speed in the error
   message (Maxime).
 - Resend as a standalone thread rather than a reply to v1 (Maxime).

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
index 2a0d7eff8..8d3d87549 100644
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
+			   "unsupported speed %s on %s, leaving the MAC disabled\n",
+			   phy_speed_to_str(speed), phy_modes(interface));
+		return;
 	}
 
 	if (priv->plat->fix_mac_speed)
-- 
2.53.0


