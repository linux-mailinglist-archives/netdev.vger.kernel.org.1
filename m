Return-Path: <netdev+bounces-284353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBH0H97a+WkIEwMAu9opvQ
	(envelope-from <netdev+bounces-284353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:56:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46D4CD114
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1149830A121E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68E390233;
	Tue,  5 May 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6z7q9cZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CC33ADA4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981338; cv=none; b=kPIyT3IoCbxrlXdcv6BKbuR8j+NiOWBI32E+yWZUhUxKS2nWwVe6hZ+sHct9vwsd+JCy3Y6lN1HpSnbrPN1iyNK0BzPnooUSgvF3VAL7dd0yeYVZ5GdyIJP3PdUEO7ZZFg5ebK0OIWrUVSqd+y/z6KTHPeb0ksT3i+c3WCHljNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981338; c=relaxed/simple;
	bh=FxQElHt/fOKYj23QBPdK3CvIUIvuJcK1nZ9sBAqCPbc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HXnDRBM7oxXNiZJL/zfdA8io0hNhLBDXSr3Ar9RzgtT2IB9o7IU+MpVB9guWlxL6wGXdQCK337CdsEtXBJuCwaeVDnGMSn1jkjtSsAFX1A5yvhKoYWxs5i5H2hMRfL0iRKlTKUvAr4hKKRBoh2N72GYLjIIH3RG+VSNC2UCJjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6z7q9cZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so81611105e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777981335; x=1778586135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxlelZYRjQn8ADIOEbB6SjrWv/T/b58TR92Mmm8OXbA=;
        b=C6z7q9cZc0nofvViSzZoW0J3Rk10F2egXvda5UemKfls/D+hY43vWJcHEFF9fEqqxt
         LbDtGz6ki/ijHtbEFuy2VIpG31DF21W61WkJqa8CKWYJB3yOnT8L4JRKBu8DSx4pi04j
         mcGsOzioDfmnhl1JieIJ4wcQqze54R/JgpFl4ALDO3S+hU3WPrhtZqIlGwykC+jFtT89
         h/SqkqMBSONc0omf4lPb99CdheMNJWnpm0P/EDjHRkyF+BQ457sJQjPPbYXpvrodI5ht
         9b1lhi1DzhkFPZifdjDrf/otkq9smqE8ulmc9m6MHIs+wDklq/rjZIqw4zN/NW3HTi19
         0LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981335; x=1778586135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxlelZYRjQn8ADIOEbB6SjrWv/T/b58TR92Mmm8OXbA=;
        b=dxj7hCAuE1GKT+IzUU9BNi2WdN/yQseKDBSWdUGDTgMxNZFhCGktP8oH3UK5hc3QuL
         7NROKEoZ9kIGALm6E8QIUaX1C1/fDZ6HaJC2Zzpkn13h6OJp1i4kx1WojG6Gptr5dFUx
         50yJ+PHhDYjdRqM9wQGxa8NrpR6bSAQzNWscPHwqAz9C3zSmCqXZeyJMKxGt2vNnVdXO
         1aPyXv7ozWPkcHnRlPKqcDeyToycXaBgctKF2gRzDBTqknWY5IwBpVWSq40NmGi9yiuJ
         FB6SoA0iuF2QPaNTewt/iwy2/Lc3JcMo8V1XBbN1PsQ0/UVhFDseVMRKEWxtosJld0Aw
         7s1A==
X-Forwarded-Encrypted: i=1; AFNElJ+jSqDBqg5tF7lqQv7eEp3mRSkq6y5Msqsg+YABwR/KZkyyN+fL7M2Eqr66Zn5GMpffjpJnmuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/icji2I15rwRRECkvY59PKwrh42vERxLVGnVgERZQyOnQCk3y
	7uojo2iXAS8Euun4HvjPN63VzRP7tGmP9vvh3jpgMlGRSOZkFoFnch6S
X-Gm-Gg: AeBDies1bi7LlH4OpW9I4EOzJdpUCjqDWSJbJ+5Sw5XaNpJNPoHZl3gKSDWjQkJvidZ
	H6U2KXBgWcHTaUhW5zq4Tai/ws/QTZbg1stF2PzMLlpfxawrXltDEP6eACpbL950JBdNXoVeItQ
	LqZSupR13Sd8kyBoiD9oQpEwhogn40lqsKUY/diS2qo7N2OiwxTcN+rQEfr6D0wh1m9FLkTBjtr
	gFhvXmNb3e6exH7Nf+RBBweAF2NlxBbwWDd8SrKDfbBtFNkyLU4JP2qHTk+zss+NyJjhkJbAuFH
	wXdRGJn6KD73oFTxcgyH6uh0a7PAdMnYBKBK8XAHxcHHEcoZOfdcfWXC7ozKxSPSbJYvBW8YkE6
	aqDaTg+1Y1AGrCTZuCu7R40BigvWkG00zK84jLq0H0NYeZGjiEERN9pSr7g4RtP+oONhi8TlP4Q
	SH1GObkOG6EXIlt7evfd8658YWU60WJa+Ut3A1Hj+n9FX2nXM3CHxLeHxRT/8wyOSXx+gd88Hp2
	WRu0nxkKeXAyI6ipsl4pjFVlwarr6S/
X-Received: by 2002:a05:600c:c0c2:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48a9866b9c6mr164725295e9.23.1777981334536;
        Tue, 05 May 2026 04:42:14 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8434-6628-bc01-577d-da52-626d-d378.rev.sfr.net. [2a02:8434:6628:bc01:577d:da52:626d:d378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm616575105e9.1.2026.05.05.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:42:14 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH v5 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
Date: Tue, 05 May 2026 13:42:09 +0200
Message-Id: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJHX+WkC/43Py07DMBAF0F+pvMaVX/WDFf+BUORMJ9Q8YmSHE
 Frl3zspQhR1k4UXVxqfO3NiFUvCyu43J1ZwTDXlnsLubsPgEPtn5GlPmSmhrNBK89d69G6aGiw
 lDrF5y1/0am0g9z3CQN8rb+0OnUXVGqEZSR8FuzRdWh6ffnL9bF9ofKGXiUOqQy7flzVGucz9N
 tpVjaPkgrsQbfCd0VbZB5zygLCF/M6WylH9oUb4dajikgfoUHsbpJP6BtVXqDTrUE2bCiK1hxg
 8hBvUXKNuHWoIteCEMQh0//9N53k+A06qXIvoAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981333; l=4929;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=FxQElHt/fOKYj23QBPdK3CvIUIvuJcK1nZ9sBAqCPbc=;
 b=cK+i1b++GbDKCf4O7HUD/70GYPtaAKjPPQnRDqpTgAQLZS1c5+k4N8QNkRUNXqle+vtR1P0v6
 i4rAgQCh3VHDvsfvHX7KJkV6KxIQrTnd2tOUc4JsawlDlfxUJlXW7QG
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Queue-Id: DF46D4CD114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284353-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:mid,exotec.com:email,msgid.link:url]

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

 drivers/net/dsa/microchip/ksz8.c       | 73 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8.h       |  1 +
 drivers/net/dsa/microchip/ksz8_reg.h   | 24 ++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 drivers/net/phy/micrel.c               | 54 +++++++++++++++++++++++++
 include/uapi/linux/ethtool.h           |  3 ++
 net/ethtool/common.c                   |  3 ++
 net/ethtool/ioctl.c                    |  3 ++
 8 files changed, 164 insertions(+), 1 deletion(-)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260323-ksz87xx_errata_low_loss_connections-b65e76e2b403

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


