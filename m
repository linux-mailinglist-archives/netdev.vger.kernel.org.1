Return-Path: <netdev+bounces-289846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFfKNcJ2DWpAxwUAu9opvQ
	(envelope-from <netdev+bounces-289846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:54:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A6658A346
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C8A83004D29
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4EF36C9D5;
	Wed, 20 May 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAP/4OTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D63438B5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266951; cv=none; b=Fvee5GTLPVPXnhaEy5tQ4cChEIzx38Ahwfy+3qOZJSl/OS5jP4z6qoPQ9XmKV1dNPbrFHtc/Nj7BPWagYaX8QxWzYNAPPD3VokO4sTx1GpB/Ql3tGwwroFD2+/YCCunZQq0Wfjynw84xy1Ih+kGlr5MzCSjtLG8s5v3hVYbkl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266951; c=relaxed/simple;
	bh=/sILZbxDKoq1vskza1mwSZlFPw4VrzFfpFOSLhoWh9o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mIVkl1yUis0v4cgGvtwkotIPR8oztvIWLBfp0O8dPMqL5dj139Z3xxTTYhH7cEB1mcPjj5YoFYAKHspsjA6gxiL8IB0Oc65Em9uProuTAWBNd5KG62mLbwvXi94nt68+rtHXiJHgPD8CeL2FjbIwEFC5zVt+rbGDs8fNZ1hMuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAP/4OTu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-441209fb77eso2801247f8f.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266948; x=1779871748; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejL+l53hnYgckUQi0VlDCQvjptKPu8absQUJq5r1j9Q=;
        b=qAP/4OTu/cXWbrhvHg1g7/MFsA+mUTRZV27PzCW3tiY+6m8V5IkJCkO/0czVcvbZA3
         l068LvpBEq1ZmWoGgu8UrOcy2ZfeiVs1MnARSVQ72mGHbPsJ2NvljUO6VtMLQW5qikfs
         RRj3PIZohZl6VigkTfTwmL2eDi/vw9Jz75Dy+iZpzPlfXR1oM8m8afVWY7Ru64C7KUSj
         uwJ9n4CUrOQjDs/GKQlIXXzJt7P+7iyxDalSro680jbNjvEMbnuEX7rvEvj6AQ2L/yAN
         GCeuNAQEGca5XMTN5DTRWiOtnlc/oDikQOvOlbh5n05E6+I0ASd8rHt68W3U/CmGb4qH
         LtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266948; x=1779871748;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejL+l53hnYgckUQi0VlDCQvjptKPu8absQUJq5r1j9Q=;
        b=f3ms2Hq3AfSpV9AyNXNYWtHxxrJnPJUbbS6QiT2Co+Eaof94i2kX+g4JiUtlsGl5CV
         U33eHlJafRi29FV1HjktRCwFa5GgjR9gxQr5DfamhItFtjTA5cFnHtQdWVeeBbUNVvtW
         QIpBJALtbuTX06WCc89kO3dw2FbU3b510RmjMWGrXMH5NWcQq7nV1UHISkuPssrVoZc/
         yZcKKgtI6iOX9/S736cGZy6JpHMP8hP1finMdKKZVKpvP55diObasR69TI17+SRmED+l
         C66V42BA2GypRsBkgGuTgqv7BBULk2jSdlUuuVe36D3rtf/AWlVZ2gIzEPWut90vyIQf
         awxw==
X-Forwarded-Encrypted: i=1; AFNElJ/Y56WVhTFw0sNbhFIaoao5C29s84nOPeTe4r/XI4hSVAL6U5nJ1VLApvwi/JGOGMNa1zmRX44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErPup0V7TiBp77FAF3qr+n5hYod9mXgVrMTpeUdZl5r4DO5Qd
	une8eJH/125C54PavndVtA6y2LHFrf+Sm9ZvChcwM8UXBs+pHv4dSL5G
X-Gm-Gg: Acq92OFVd5cqho7GJuoXyYoR6eSfCYsm95avI2G8HtPkkNmF5Ed3Rwave3P9/q8Tndv
	QjvKyViTDoFk3lojo4dSReb0HC1oVbini5830dJkRoMmamigjB/lwuT+mD/RujQ+Wsk0x8NxWDZ
	JkCfLbiDmYPgz9f/d/ogK0Tc0J3vi7FKo3tFESZqClwU4n5lwF1VM3zUPUkGMgNahGsY1e0abDf
	SZ1+82iwC/JgALY2zShtKHSnUm19936LXRi1ADRjemgrm/zWT8UK6Xdkkz6rlsccrXMXFvixyLS
	a2pLK5Sfq28T8t+hK2UH0eXbUheJOCqRReoneaw/LRrsXdPRPCXUbu8TKmvvlaMvUvaI9iWYLyO
	dgcAkcC7efR49D1JTMp5j9dX3GeLAxUk530uLq/sL2akGogTPbV9EeoMesQg2dUB2SMRJtFbOBx
	kML11WI8h7WxaUHokpRCD0vjUZO6qiHY5OAN8MZc/hIZ/FCaKjY4bBvuy/HOt7TB4uHGEr/gGDm
	wV05d/X0Q==
X-Received: by 2002:a05:6000:4012:b0:45d:2b7e:a20 with SMTP id ffacd0b85a97d-45e5b884f76mr36942576f8f.14.1779266947752;
        Wed, 20 May 2026 01:49:07 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm51244283f8f.9.2026.05.20.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:49:07 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH v6 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
Date: Wed, 20 May 2026 10:48:55 +0200
Message-Id: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHd1DWoC/43Py07DMBAF0F+pvMbIr/jBiv9AKHKmE2oeMbJDC
 FT5dyZFqEXdZOHFlcbnzhxZxZKwsrvdkRWcUk15oGBvdgwOcXhCnvaUmRLKCq00f6nf3s1zi6X
 EMbav+ZNerS3kYUAY6XvlnW3QWVSdEZqR9F6wT/Op5eHxN9eP7pnGV3qdOKQ65vJ1WmOS69xfo
 93UOEkuuAvRBt8bbZW9xzmPCLeQ39haOakzaoTfhioueYAetbdBOqmvUH2BSrMN1bSpIFJ7iMF
 DuELNJeq2oYZQC04Yg0D3X2/anNFGNNvQhtB9NEKoTkkw6h+6LMsPNkgajD0CAAA=
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
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266946; l=5082;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=/sILZbxDKoq1vskza1mwSZlFPw4VrzFfpFOSLhoWh9o=;
 b=AKMWaXqBuCTaMvaN5jBiUboaLWW+Za0y5J3fdUNJwry79t8A9LqDykqW3ji9waXzVAdvfrUoo
 SLAssUUvs0wBPqcqSdlS78lCdGQ2vP36RgV9/QsvlIKoKHhip2H3+S4
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289846-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,exotec.com:mid,exotec.com:email]
X-Rspamd-Queue-Id: 70A6658A346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This patch implements the “Module 3: Equalizer fix for short cables” erratum
described in Microchip document DS80000687C for KSZ87xx switches.

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

This series is based on Linux v7.0-rc1.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
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

---
Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

 drivers/net/dsa/microchip/ksz8.c       | 78 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 +++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 54 +++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  3 ++
 8 files changed, 168 insertions(+), 1 deletion(-)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


