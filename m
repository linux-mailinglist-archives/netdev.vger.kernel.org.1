Return-Path: <netdev+bounces-291160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPK7Nn3XEmom4gYAu9opvQ
	(envelope-from <netdev+bounces-291160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D7A5C21D2
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA713013246
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504E3911B8;
	Sun, 24 May 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5j/HMkY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169338E8BB
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619499; cv=none; b=P+6LtgczNg+fRkF10vdIUZ3nxwRjZ0hM3NNXJVMkxz4t4gFhbH7imuHZpwG8Bv1VAbSCqWtQ0KXnD5qlv1OfX908mu7X+L4mVmKD366lAEj1p3DnJpB83o31LqZSB4mWLaKzZGe+i3KHizLJdqRF0d7b+o0xVtkqZcM/+T+VMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619499; c=relaxed/simple;
	bh=xuVJMryb0G4Fg8Th8Oi0Y8PbmTEFWyDGsYhoMQvlDAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJRUg1Cmljwz+gx5gM+20z+VPR0EA7JCqgiif+vk9HPPcyKyBneJcgbD5hiypg8NvfpsJwUY0UYUeYgAIp2VwTJyPPPaOQxWr8npxtC4kWjDURQEcv5UAGU5eheedWnz9upE04auE/kjT49sB469qWvx3twnpc8xT1hsb30Y4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5j/HMkY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso75180235e9.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779619493; x=1780224293; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhVHeurwfBcX3dph0Y2lSjUY1guOVIBORV2Yb0oP1QQ=;
        b=Q5j/HMkYVieLNmFHAIFmIVfljbKBfg1dShXVsviBjk/849Y1FzApm7kEcFnfPSzhx5
         EpGO8A2Uia+fRUtvc4xg/gjoGh8WSSpwAox3fGr3zsXcacDIB5LxKFMtD9ehaTRsZq1K
         oofXq17MANow7wfBAdOrGTJlQK8MezOpGvqfLbm7ponDcYW/h3jqgiO4ZHN+icYet/MP
         0Eokbq+PzWeD6gOAIkQgZ+mkHUMx9wW6OKa5ry5ZYG0v8Nsbxipi12MHf3NK8XmBajhn
         brjsgKGvfA7Ig6+/EH/s3/3HZv5W5nXx5ptPhlguUG7IkrzQ9I0jSeoWPJHWdh+47tcQ
         o8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779619493; x=1780224293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhVHeurwfBcX3dph0Y2lSjUY1guOVIBORV2Yb0oP1QQ=;
        b=pn/skdao1DBsT+2goB6m1EAV98uQKIwRVjDhHTI6roLsRbjNBKp+w24+WaSuqcvGz6
         ZleVT+6rC0isyslgv4H/BgGjwX99wkH5jIU3b/wN3EymdyhUFBsx4tYxmmZ/6Wff3ahh
         M5mK0/6krmeFMj5pojBrZ8GOj87spj6FCQIORfKATcVWTvJjnHPluSc9YKKCv7raNTVt
         clU8Rin1WzlGg1pfVV0Ov4MRTDx16oS9sWSBAOhoPtUq6iBmVePiRYy5r1/sxRgLhZed
         D2y7J7fcE6eGp16ELal0QOB2jkaFxuasD9oIGjEep8p9tWQEOmMZUqkzEO6HKC1H3H0y
         5TPg==
X-Forwarded-Encrypted: i=1; AFNElJ8dTlPkJBVHTs+h9B1KxdGpZutfqGr0HHuf5QhGykvE8M4ZL+JZYhyrw7vP0pTnBhdmmaqGKwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjszqtx0tzJ7QNBnNB1oLtnV3HIm2+8XFVqP1gSRWEBuo4NiyO
	7kBNhIsiZC7Cn7KDL8KpU9Czkt/IUe+NXwXOTBmytb4P+er2h7Db5203
X-Gm-Gg: Acq92OF5DcYAxuzkhpBZsQNyHU4eOT5iHX1LeJi8qd6jtVBHKgx4ThT0pbnK3GCRX0x
	tr2oS3QXn2W0H7y9l6Cv+fDpC6/OCmmvh9sG2X6btmwH0j8mN+OSENkekvlyE1HZ2IcD6UFW0Fg
	MzSPfZtF3tl7g86sydXlmoXPRKZXnC/nLNefnbDzBMUYKSaZj4pNfmwo3rXTLk1diVFeI4hHt9C
	iNQgx62bQOM2O/VGw1KzFo6phrxmcfTZENyfH76dxfIRuzL8zSzSDLFcd7s/PlCUB+sA6QnDOde
	CgySSj0m+KR8mu/sf1Dl7GPlbMghhqRJuQ/SZv+Jp/lxhsSa7C2NvJAxNBzQ9d0Tz055I67hrHu
	R94o+2nKo4MwEHtTHw5Qi3u9UIo43S1r0IodiD94Zqfuv0fTUkDJW31E0Il/oxzdw7bQrJ44o/M
	p/2/woWet4oSnLaD/W188psmMb24h/ra/jgf7eFrHkZCiFk5WR3r/XFNjg70Vl7sOGlsQXmV2jT
	Lb2lL1ra7ZNu0zQ3505
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-490425ac8a1mr168289725e9.10.1779619493300;
        Sun, 24 May 2026 03:44:53 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb0c131d7300e352009073da06b6.ipv6.abo.wanadoo.fr. [2a01:cb0c:131d:7300:e352:90:73da:6b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm258967105e9.7.2026.05.24.03.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:44:52 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH net-next v7 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Date: Sun, 24 May 2026 12:44:23 +0200
Message-Id: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIjWEmoC/43Py07EIBQG4FeZsBbDrUBd+R7GNJQeHLyAAazVS
 d9dpprMmG5YsDiB8/0/J5Qhecjo7nBCCWaffQx1UDcHZI8mPAH2U50RI0wSzjh+yd9aLcsAKZl
 ihtf4WU/Og40hgC11PeNRdqAksFEQjqr0nsD5ZUt5QAEKDrAU9Ph7kz/G57p4Djm/PfpcYvraC
 s102/jLlk3ZM8UEq97IXjvBJZP3sMQC9tbGty1yZhdUEN2GMkxxbx1wLXuqKN+h/Aqlog3ltSm
 pJNfW9Nr2O1Rco6oNFRWVVhEhwNb/75t2F7QjXRvaVXQyghA2MmoF26HyCmWkDZUVFdxxPgljH
 HH/0HVdfwAV2cvcnAIAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779619492; l=5189;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=xuVJMryb0G4Fg8Th8Oi0Y8PbmTEFWyDGsYhoMQvlDAA=;
 b=fLt7Yp7ULNUDuAgNZSR1x0TPoPDkmhv2UgOKVDO4QFMO43ONKJS50q8YbchO7XjlXBBidcNxr
 puk8+nub2A3DtlYxHKTEuQyUywHudxVPhpCz35vXr6R5Wn+6j5/r665
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291160-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,exotec.com:mid,exotec.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 61D7A5C21D2
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

This series is based on net-next.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
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

---
Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

 drivers/net/dsa/microchip/ksz8.c       | 76 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 23 +++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 54 ++++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  3 ++
 7 files changed, 165 insertions(+), 1 deletion(-)
---
base-commit: c0aa5f13826dcb035bec3d6b252e6b2020fa5f88
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


