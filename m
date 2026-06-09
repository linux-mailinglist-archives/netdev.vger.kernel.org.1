Return-Path: <netdev+bounces-297155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +zEOGOBEKGpxBQMAu9opvQ
	(envelope-from <netdev+bounces-297155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C45662A1C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DpPvCux7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297155-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297155-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0465D304C135
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588813EFD2E;
	Tue,  9 Jun 2026 16:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F93B5E01
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:20:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022015; cv=none; b=jVPRF+IAZbyJmO1Vd4QrMj14vS/R5KW2w5AQ9HVjtnft8r1vzZ0Lz5UgeVPvRNTJXfZdoQs5d2zD5s0LzjEJx8RfTSbuuR1krUnpdIMQANwdHKEKlS8HzhhlwG1up8h4pIbKkqzdj7MTEBR54Vku5q+KsX4BvRKE6px8yiGVQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022015; c=relaxed/simple;
	bh=rIK+8qwUbffbSCQ4JIm1hNQ6maO54VCXxjYbTZbIPiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFqypI1AkzdLwuEYrPS10yx8Wdef+A3zrUZWsMFKMGKVfbLqKgAYtbPBSwuNSxD0JHL2VdC2I5qQbsO+LONtsyUM0x0HySTS29w4goI3x3Wzni6fBSkkF3fUNi6XY4gTUe4VgR2/ivArFGKqq7t85pLaYAvfssAdkKNQA7snXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpPvCux7; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b64c8311so64300215e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022012; x=1781626812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUz34f8AUlG0gLWcG1NhLV3GhNlUwZnNfPkE4XwZzQc=;
        b=DpPvCux7dCy9YFhEwmQI651Cd8in5OfGTkqRQ1gHCiIg4IuVUTxL5hwLbXMl0x0CVB
         Jb8OTQz+KBFJYlif+WUTCPIVzSpnS1AMmFY+w6FFGuvQWBM54Qx4LaEtlG+8JpxZg5X7
         QZE035PPMrzg6lSc6UtsaGC48YCbDnqpo6Llof54KOIizfghVoUN7u+VxKydMATCQKdD
         yzpNLEKYqdCR+LbRveYjbm7593vERoMZWjgI0AVUpnFUD+Q2hulR7KvHmJPX3JmYwEom
         /Zv9+WDRp1zMNcifQYKN18QeimQaktxklG9PRXuseJEt2O6vJx+BTdhCkQHwUKZ4gYz3
         bngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022012; x=1781626812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUz34f8AUlG0gLWcG1NhLV3GhNlUwZnNfPkE4XwZzQc=;
        b=EMBTkrsmhu+ZRFIuZDkyjWiYdpAnybKDTWNNajqhYzTv3CjguJ2/772fw+Ywwbh6st
         XGowaiErgvmr5osZBzEL5EVasNdHWP58Pc/TJM0iKwmh8Btei878uJScJ871a365tC7n
         9e2QQhY8KmMM5xDL6y/CxBOCuWVZqKBJPeTBi/lQ+LYKtEQtzjZTlv5ZUk9h6XppYG6b
         KiDw6A7iRJSGiXdu3TN4ku+QmfxFBDATdujI9X7uHosYmTtNv3Lb8mJEAnynB6LvQbCh
         2NsXqUFdeDWb9xTvB+FieNR3Cc4065KldnEAiEh/XIRQnzmGGKG1UPRd7GPMhcXwGXSS
         J/ag==
X-Forwarded-Encrypted: i=1; AFNElJ8caYMy8cg+NKgJZUk4RomszXADDikr4mXeY8GhcI/JZsX98achQGfSwkdo/0ekY8/ckcOoHHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0eU39Q/jS1hnuAlYcnF3hraSBp4K3+IvENQ97xBMWT5JPbkp
	/kICI8I8mjKOIkFwYgsF/BbA4FvMwahincDQcAwUX0HhcbQFTO1ADaY2
X-Gm-Gg: Acq92OGlJXrlizRI6ksqph+xn+bsH3I3Dez4pAN3XnUJZ33UO4YnPfjofjkVQmF8sRR
	vuWejb3HQdCFiJv/4L8k4o6yFZuhQNxYNJ0z5ellT+sem7KkjL6IcuZmFO3QKrV4uFi78+/OUwY
	BglvF32UP1EOg72tNcIgksac5O0bIIqnSAztV7JwLUoyOgwCnxJyrl9yH+Ql/+Ps8oFp/Q8rvd1
	67RtcOt81IcyzFYwlJBviNjQ2Tj9jERo4ksCJd7d/ncCzzuY/MJ0/Qn6ck9kzYrdc8NQR6XRPII
	aCzVQAWR33Dbmy7AAULMnaldgmTKU1LND2kXQflAstDPkfZLvk1W2fcKRvfGWSUZijR6x+n8PSa
	b7zIoqCanR0kEzA9y1wuQfr8wkWG6q5gUvdytJuMsdfdKXEsYY8+KJ5B6fQJ+l0K40p8XcUIQOk
	f0Vj9asPwz3sistsoYoAt5/1DREm5E0qvHtffQEfZxtkW93Lfzse25ahHKqbaRP9/Zz20TsiwG4
	g0URe+mWTppDOw/NAyc
X-Received: by 2002:a05:600c:8216:b0:490:c2a3:23cf with SMTP id 5b1f17b1804b1-490c2a323f0mr322472225e9.34.1781022011871;
        Tue, 09 Jun 2026 09:20:11 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm569116365e9.1.2026.06.09.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:20:11 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Tue, 09 Jun 2026 18:19:55 +0200
Subject: [PATCH net-next v10 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ksz87xx_errata_low_loss_connections-v10-1-9ba4418cf3db@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
In-Reply-To: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tristram Ha <Tristram.Ha@microchip.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, 
 Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022010; l=8207;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=rIK+8qwUbffbSCQ4JIm1hNQ6maO54VCXxjYbTZbIPiM=;
 b=RNCFrs4UP8RZkJ5rjd8XFSFelSBAfG4A+xfrsn5Hr2aWMJhnQrupZ8C2SfB3arOS3VBAAofJT
 bTsF6UIT8SbCKsnRxswFpQtUHo72y1bqDeq07j3zf4Q1VXSh3mGg2NG
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:marex@nabladev.com,s:lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:mid,exotec.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,tipi-net.de:email,microchip.com:url,nabladev.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8C45662A1C

Implement the KSZ87xx short cable workaround.

This patch implements the KSZ87xx short cable erratum
described in Microchip document DS80000687C for KSZ87xx switches
and the following support article:

Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

KSZ87xx devices require a workaround for the Module 3 low-loss cable
condition, controlled through the switch TABLE_LINK_MD_V indirect
registers.

This change models the erratum handling as vendor-specific Clause 22 PHY
registers, virtualized by the KSZ8 DSA driver and accessed via
ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:

- A boolean “short-cable” preset, which applies a documented and
  conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
  value 0), and is the recommended interface for typical use cases.

- Separate LPF bandwidth and DSP EQ initial value controls intended for
  advanced or experimental tuning. These are orthogonal and independent,
  and override the corresponding settings without requiring any specific
  ordering.

The preset and tunables act as simple setters with no implicit state
machine or invalid combinations, keeping the API predictable and aligned
with the KISS principle.

The erratum affects the shared PHY analog front-end and therefore applies
globally to the switch.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 89 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 ++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f84b2e7d25d..4ec2d5d2a1bc 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -798,6 +798,40 @@ static int ksz879x_set_loopback(struct ksz_device *dev, u16 port, u16 val)
 			 stat3);
 }
 
+static int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool enable)
+{
+	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ init 0)
+	 * providing a conservative configuration for short or low-loss cables.
+	 */
+	u8 lpf_bw, eq_init;
+	int ret;
+
+	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
+	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
+
+	if (!ksz_is_ksz87xx(dev))
+		return -EOPNOTSUPP;
+
+	if (!enable) {
+		/* Restore default values (LPF 90 MHz, EQ init 15). */
+		lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+		eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
+	}
+
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, lpf_bw);
+	if (ret)
+		return ret;
+
+	dev->lpf_bw = lpf_bw;
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, eq_init);
+	if (ret)
+		return ret;
+
+	dev->eq_init = eq_init;
+
+	return ret;
+}
+
 /**
  * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a MIIM PHY
  *		     Control register (Reg. 31).
@@ -1046,6 +1080,22 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 		if (ret)
 			return ret;
 
+		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = !!(dev->lpf_bw == KSZ87XX_PHY_LPF_62MHZ &&
+				dev->eq_init == KSZ87XX_DSP_EQ_INIT_LOW_LOSS);
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->lpf_bw;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		data = dev->eq_init;
 		break;
 	default:
 		processed = false;
@@ -1272,6 +1322,41 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		if (ret)
 			return ret;
 		break;
+	case PHY_REG_KSZ87XX_SHORT_CABLE:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		ret = ksz87xx_apply_low_loss_preset(dev, !!val);
+		if (ret)
+			return ret;
+		break;
+	case PHY_REG_KSZ87XX_LPF_BW:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		/* Only accept LPF bandwidth bits [7:6] */
+		if (val & ~KSZ87XX_PHY_LPF_MASK)
+			return -EINVAL;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
+		if (ret)
+			return ret;
+		dev->lpf_bw = val;
+		break;
+	case PHY_REG_KSZ87XX_EQ_INIT:
+		if (!ksz_is_ksz87xx(dev))
+			return -EOPNOTSUPP;
+		dev_info_once(dev->dev,
+			      "KSZ87xx low-loss tuning is global, applied switch-wide\n");
+		/* Only accept DSP EQ initial value bits [5:0] */
+		if (val & ~KSZ87XX_DSP_EQ_VALID_MASK)
+			return -EINVAL;
+		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
+		if (ret)
+			return ret;
+		dev->eq_init = val;
+		break;
 	default:
 		break;
 	}
@@ -2070,6 +2155,10 @@ static int ksz8_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
+	/* Initialize KSZ87xx short-cable preset control */
+	dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY;
+	dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ;
+
 	ret = ksz8_handle_global_errata(ds);
 	if (ret)
 		return ret;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..981ab441d9b7 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -202,6 +202,10 @@
 #define REG_PORT_3_STATUS_0		0x38
 #define REG_PORT_4_STATUS_0		0x48
 
+/* KSZ87xx LinkMD registers (TABLE_LINK_MD_V) */
+#define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
+#define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
@@ -342,7 +346,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
 #define TABLE_STATIC_MAC_V		0
@@ -729,6 +733,23 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* Vendor-specific Clause 22 PHY registers (virtualized) */
+#define PHY_REG_KSZ87XX_SHORT_CABLE		0x1A
+#define PHY_REG_KSZ87XX_LPF_BW			0x1B
+#define PHY_REG_KSZ87XX_EQ_INIT			0x1C
+
+/* LPF bandwidth bits [7:6]: 00 = 90MHz (default), 01 = 62MHz, 10 = 55MHz, 11 = 44MHz  */
+#define KSZ87XX_PHY_LPF_MASK     GENMASK(7, 6)
+#define KSZ87XX_PHY_LPF_90MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 0)
+#define KSZ87XX_PHY_LPF_62MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 1)
+#define KSZ87XX_PHY_LPF_55MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 2)
+#define KSZ87XX_PHY_LPF_44MHZ    FIELD_PREP(KSZ87XX_PHY_LPF_MASK, 3)
+
+/* Low-loss workaround DSP EQ INIT VALUE */
+#define KSZ87XX_DSP_EQ_VALID_MASK		GENMASK(5, 0)
+#define KSZ87XX_DSP_EQ_INIT_LOW_LOSS	0x00
+#define KSZ87XX_DSP_EQ_INIT_FACTORY		0x0F
+
 /* KSZ8463 specific registers. */
 #define P1MBCR				0x4C
 #define P1MBSR				0x4E
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b67038cf1bd0..45613b9aeb1e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -222,6 +222,10 @@ struct ksz_device {
 	 * the switch’s internal PHYs, bypassing the main SPI interface.
 	 */
 	struct mii_bus *parent_mdio_bus;
+
+	/* KSZ87xx low-loss tuning state */
+	u8 lpf_bw;		/* KSZ87XX_PHY_LPF_* */
+	u8 eq_init;		/* DSP EQ initial value */
 };
 
 /* List of supported models */

-- 
2.54.0


