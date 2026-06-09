Return-Path: <netdev+bounces-297156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9cGAn5AKGo+BAMAu9opvQ
	(envelope-from <netdev+bounces-297156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD746626D1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XE6BTqkM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297156-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E85F30C6D8D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB03B6C12;
	Tue,  9 Jun 2026 16:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD843EDAB8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022015; cv=none; b=tXprApwr1ev6cykiZN5d41fmc9e6KdxmbaNclnXrXgtHOyxsoq8G8Ja/K0u5GxI4azV76CZkqB43RFxvX8eyhJEsdEJuaRFsKmTTa6GChx1o5ivwogM63Z2sBE2XXQppugnijfhy2ebHthHG7WYpa/fTXcihU4Q7zdEwp9GwXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022015; c=relaxed/simple;
	bh=Y0KkT+q8geByKfhlS7zKu7ViKUzzGvj3gP3iqgcc3vQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pj5vXt+/zto7K1ons7HKbjqYPBxPHiH9VzTwuhRm/j3m4Hta8gsqtZnjv1thTZ3PMrpATDn4goihqsnS/uJSuwn5Lp2WEg/bLVcwdUN2Pw0HuD8uBOC+IMXni5BgH5JtO90cehOd7U0N1cPo9uMSKCIiFGrQHwhXsHZEyRvAypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE6BTqkM; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4908b92904fso65792105e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022011; x=1781626811; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJJFmXKdltcOKHe83Fb4sYqMYC7/AyrDhk+Jja8PbdI=;
        b=XE6BTqkMuNYB3EChNkq8URljKH3/Fx5koEHt1x+n/y1g0+AwizMSTchounPGEnnAGV
         polNMFwI8DlaLrh/yvEwzTLkMZlPCfPK8uPsM5Y59ugtpxHS+B8OKzfLUngn2ZuR/VIG
         TlIA8RQ8JXlSyc5/QCiRCRajJK5o69CVTA4XFGtARHve7uEPFo4u1lNP5/SKWNZ5ExcM
         eLBC7m6N33koAwpV9nUf899Sb0t5dB6OGvc93yX3fqV3y+gep2NwYJqbohmrpBascvBs
         7MJNotietkc84SsA4shI2FZewvRh///fsQ1yRilO2NyNMDsmyxxHy2rdRAvj9UOilyBR
         W/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022011; x=1781626811;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJJFmXKdltcOKHe83Fb4sYqMYC7/AyrDhk+Jja8PbdI=;
        b=etHI+MTaDo1DUy65bDO8nLJYsxV62afVzLX91/WcT3zdwlxVkSOC3SAVn9h2lyvQAA
         NTPISPbms2cuPY3fsN0o0Xjk8yhjK4+odWbYpG6QykPGGHU0DHfo6dbPtqaSi3XxYFFu
         rTiMLp19vTBIsZM9qxWVxO1XPJw5T6LQXbyrKXyqmVC1HnXE98pZBvRi+ZQ6Ib3YDA7Z
         GLq0eitP6SR8FrCmiaF2ZdtWH4+IEDcpdLrZaGutyDB7bcfbg9kAYcxG6YBXgKX4GTn5
         cWHNyF4TClG4IwYwjJ5gE96A4Y9wwek79o8wN4MbbzxqfQDhIY0U6q51heCHOPIZjqSE
         JkJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+edyqjPGRT8R8MNCHyDjE7cKI9we0z2foRxvbextUla/D2jLwg/uU+IvgjG2+iTEqlBTX6DHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eqZQj8XIFc3K6ypmtJNIN+ryC7V9Uyholfa6w7iMhupOF87j
	FMzy2RC3vEw90+L8/q07GsYNBlO7UMZFOxom5DRK+Bqb/6r1hpXeO3kg
X-Gm-Gg: Acq92OG1GB8sTLT+w2mtQp6ufsP74MKy9B1fKuh6B/hldIS1EYI6WNbApo3QTRvjBtr
	xlhwfziXlZcpnuYhZ3wHrEzcFa8BbNwr5/ztTDZ3mHd5BDfFB7BlrwC+ihU+nsJohLh2D9oZy9r
	fNgsz5yTWbPCGzdz+dTEblQfiUC5fUtoytyql0cmguQezMUcAGyXTgwUSFmLuZV96TI/0DylOKH
	dq60yuuDqgqdWZFkM1Hx3hgb2ZAOWW1Z0wNtErErof3tcESCSVijKhTqiIXpOgSemn3T2Y+Lw3+
	VnZbpaTxJFBsBIPMDbXLNj6jU1isGLT8ubbWfPYCv8viD1zDq5aSiPRWzZ6QRMvXwb+uGgG4im2
	NeG48WLgyc6pBBiy9LB3AxyytvazGoBJdX7Lhtw9CHFc4fvTXhZEPCO7yEym1Y3EXS+0tsUQ1CK
	OIKr8qj/mo+BZMIJ4VWPV2aL3rUctajIMqYhOThug1BzWfxGzIlVTIxngTo5Kp/6xi2DJd/4pqX
	1QuSrprHuzaKvblbVsiZW0NnCqGi7g=
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-490c264cc2emr354168145e9.33.1781022011172;
        Tue, 09 Jun 2026 09:20:11 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm569116365e9.1.2026.06.09.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:20:10 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH net-next v10 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Date: Tue, 09 Jun 2026 18:19:54 +0200
Message-Id: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACo9KGoC/53R207EIBAG4FcxXIsZBsrBK9/DmA1QcOuhNaXW6
 mbf3dnVZGt6Q7zggsN8/wAHVtLYpcJurw5sTHNXuqGniYDrKxb3vn9MvGtpgSGgBomSP5cva5Z
 ll8bRT373MnzQKGUXh75PcaL6woNuktEJgwLJSHobU+6Wc8w969PE+7RM7OFnp7yHJyo8hZzO7
 rsyDePnuaNZnCt+s3VV9iw4cOO8djYrqVHfpWWYUryJw+s5csYLqsDWocgFdzEnabUTRsgNKle
 oUHWopE6BSGmjdza6DarWqKlDFaE6GlAqRbr/ttPmgjbQ1KENoa1XABhQRIUbVK9QhDpUE6pkl
 rJV3mfIG9Ss0co3NYSK2Cr6LI8qwwa1F1SDqEMtoeQJwJg1xi3q/oE6QnMbQhBN4zCGP+jxePw
 GSgbtopwDAAA=
X-Change-ID: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022010; l=6595;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=Y0KkT+q8geByKfhlS7zKu7ViKUzzGvj3gP3iqgcc3vQ=;
 b=h3P6hO0M2P3TOTr4RdOSDDg6xi+LXfvmXkAFvhDZ9TvLMAogqWwfsfM9+iqnDwIHccNKQ+UF2
 sXOtCffKQBMBFDuGXAcMvL3EV/IIl+Qg+D6VXwpBmzMKjrRmcuCywXo
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-297156-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AD746626D1

Hello,

This patch implements the KSZ87xx short cable erratum
described in Microchip document DS80000687C for KSZ87xx switches
and the following support article:

Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

According to the erratum, the embedded PHY receiver in KSZ87xx switches is
tuned by default for long, high-loss Ethernet cables. When operating with
short or low-loss cables (for example CAT5e or CAT6), the PHY equalizer may
over-amplify the incoming signal, leading to internal distortion and link
establishment failures.

Microchip documents two independent mechanisms to mitigate this issue:
adjusting the receiver low‑pass filter bandwidth and reducing the DSP
equalizer initial value. These registers are located in the switch’s
internal LinkMD table and cannot be accessed directly through a
stand‑alone PHY driver.

To keep the PHY‑facing API clean, this series models the erratum handling
as vendor‑specific Clause 22 PHY registers, virtualized by the KSZ8 DSA
driver. Accesses are intercepted by ksz8_r_phy() / ksz8_w_phy() and
translated into the appropriate indirect LinkMD register writes. The
erratum affects the shared PHY analog front‑end and therefore applies
globally to the switch.

Based on review feedback, the user‑visible interface is kept deliberately
simple and predictable:

- A boolean “short‑cable” PHY tunable applies a documented and
  conservative preset (LPF bandwidth 62MHz, DSP EQ initial value 0).
  This is the recommended KISS interface for the common short‑cable
  scenario.

- Two additional integer PHY tunables allow advanced or experimental
  tuning of the LPF bandwidth and the DSP EQ initial value. These
  controls are orthogonal, have no ordering requirements, and simply
  override the corresponding setting when written.

The tunables act as simple setters with no implicit state machine or
invalid combinations, avoiding surprises for userspace and not relying
on extended error reporting or netlink ethtool support.

This series contains:

  1. Support for the KSZ87xx low‑loss cable erratum in the KSZ8 DSA driver,
     including the short‑cable preset and orthogonal tuning controls.

  2. Addition of vendor‑specific PHY tunable identifiers for the
     short‑cable preset, LPF bandwidth, and DSP EQ initial value.

  3. Exposure of these tunables through the Micrel PHY driver via
     get_tunable / set_tunable callbacks.

This version follows the design agreed upon during v3 review and
reworks the interface accordingly.

This series is based on net-next.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
Changes in v10:
- Switch PHY tunables from u8 to u32, as they are part of the global UAPI
- Link to v9: https://patch.msgid.link/20260601-ksz87xx_errata_low_loss_connections-v9-0-fdbbb15592cb@exotec.com

Changes in v9:
- Drop incorrect Fixes tag
- Fix typo in comment
- Link to v8: https://patch.msgid.link/20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com

Changes in v8:
- Clarify LPF/DSP EQ register definitions based on Microchip support article
- Make short-cable preset reversible by restoring default settings when disabled
- Link to v7: https://patch.msgid.link/20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com

Changes in v7:
- Rebased on net-next/main
- Link to v6: https://patch.msgid.link/20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com

Changes in v6:
- Nitpicks corrections
- Link to v5: https://patch.msgid.link/20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com

Changes in v5:
- Added Fixes tag
- Added validation to ensure that only the documented bitfields are accepted before writing the registers
- Link to v4: https://patch.msgid.link/20260417-ksz87xx_errata_low_loss_connections-v4-0-6c7044ec4363@exotec.com

Changes in v4:
- Reworked the user‑visible API to a boolean short‑cable preset plus
  orthogonal advanced tunables, following the KISS principle.
- Dropped the previous mode‑selector semantics in favor of simple
  setters with no ordering requirements
- Added persistent tracking of LPF bandwidth and EQ initial value.
- Clarified defaults and preset values to match Microchip documentation.
- Link to v3: https://patch.msgid.link/20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com

Changes in v3:
- Exposed all LPF bandwidth values supported by the hardware.
- Added phy tunable.
- Link to v2: https://patch.msgid.link/20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com

Changes in v2:
- Dropped the device tree approach based on review feedback
- Modeled the errata control as a vendor-specific Clause 22 PHY register
- Added KSZ87xx-specific guards and replaced magic values with named macros
- Rebased on Linux v7.0-rc1
- Link to v1: https://patch.msgid.link/20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com

To: Woojung Huh <woojung.huh@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Marek Vasut <marex@denx.de>
To: Tristram Ha <Tristram.Ha@microchip.com>
To: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

 drivers/net/dsa/microchip/ksz8.c       | 89 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 ++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 61 +++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  7 +++
 7 files changed, 189 insertions(+), 1 deletion(-)
---
base-commit: c2c0486c56800ce276e79c40a6e576ffd672f2a9
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


